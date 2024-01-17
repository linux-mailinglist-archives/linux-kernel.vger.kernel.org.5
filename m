Return-Path: <linux-kernel+bounces-29253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E6C830BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC87C1F218B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93AF224E2;
	Wed, 17 Jan 2024 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wAHIHXY1"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FF5224D3;
	Wed, 17 Jan 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511056; cv=none; b=m50+UlUIwdqhURjm1KK8l0XlIZHN1OSMx5AXM6Hx0GjT0fEPymZo3riuAk93XdddQ8fgAlIk1ZX31VkUsbPku8LSta3QUdxkbmqqBjAC3tV1j5xoVNsN7bYYXJrRWY5P7tPrNLSZrhx26JX6CB1BQrWsOILug+gAlH/BnsGrJh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511056; c=relaxed/simple;
	bh=PCnHCIBcMIrtdxe6gfCE1zg42s8OxJnV4lvd4LUbthU=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=WwxulNNsdRJtfyF9IFnSimqJgLcDgYaLgR6Ei9lGXli27PCZ19Ce0YZ6ii05CyWPY0Rg/0iPHBOg0xex+KQZcRra4RMleyUj27Vvm2zFZwmKtSeVDsT2wWm0+18wD1NMN2+lGN8AZG9dOvfWgs/gyfuSrpOfVc5yLZ6ckAsIYS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wAHIHXY1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=71oRC0QNOLC5T5Xfwt4Sxyl5vPyoqFz+oPfRpT6Q6/I=; b=wAHIHXY1IdQj+8nCs3HF1cyQw6
	EeLDjRt6NQPdjgM8cs8fjmvEmRPNwsAPiPbTQ7IwFjDq5VDXVyv//OQ0Vf32TVmbDV2JEpr6fylxW
	da46O2bljL1i34qBkQKL0h3uAh82rewjlUg+L6htMtXQ9FqixovpCD1TM1ShJmghMB+M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQ9Kb-005QG5-17; Wed, 17 Jan 2024 18:04:01 +0100
Date: Wed, 17 Jan 2024 18:04:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mirsad Todorovac <mirsad.todorovac@alu.hr>
Cc: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>, nic_swsd@realtek.com,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 021/108] r8169: improve RTL8411b phy-down
 fixup
Message-ID: <b7e75488-ecf9-4c83-b6ab-3f1194c63e54@lunn.ch>
References: <20240116194225.250921-1-sashal@kernel.org>
 <20240116194225.250921-21-sashal@kernel.org>
 <20240116174315.2629f21c@kernel.org>
 <4523ad21-d06a-4ba2-9b46-974a6093b189@alu.unizg.hr>
 <2c590117-96fa-4e0b-84bd-9e3ea138d93b@lunn.ch>
 <ccb8b694-4361-40bc-b7df-528a6616c15b@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccb8b694-4361-40bc-b7df-528a6616c15b@alu.unizg.hr>

> Hi Andrew,
> 
> Yes, I wasn't aware of the 100 lines limit, and yes, this is not a bug fix,
> but an improvement (optimisation).
> 
> I think by this I can join to consensus, this patch is not a candidate for
> backporting. :-/
> 
> However, I am concerned about the possibility of two kernel threads accessing
> the RTL NIC intermittently attempting to program the NIC over the RTL_(R|W)(8|16|32)
> instructions (which are expanded to readl/writel and assembly).

Most calls into the driver are protected by the RTNL lock. There are a
few exceptions. probe() obviously does not hold RTNL. Actually sending
packets, and interrupt handlers don't hold RTNL.

Please look at the code and see if you can see any paths which might
do parallel access without holding RTNL.

You could also do some testing. Add ASSERT_RTNL() in the code you are
worried about. If the lock is not held, you will get a stack trace.

	Andrew

