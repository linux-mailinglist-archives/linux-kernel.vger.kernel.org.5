Return-Path: <linux-kernel+bounces-68715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFD6857EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E42C6B27315
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C2D12CDAB;
	Fri, 16 Feb 2024 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S2ESfiJ/"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03EF12CD82;
	Fri, 16 Feb 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092649; cv=none; b=Cqbtl6Xv5J57460eX4zSvwST9CbLOyPYZQ+U6G8ZdaXRXc85AHPV5Dzc/HIifhtwwroBezxEs/sdD/ZxV5faCEgzIoNzjyJYBWYDyInbAsM1omCPNYDSnfW2t2zJdUuEqZphlmFsYensZYrd9wvToim8qiqe7fHnHcFJ3ifmJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092649; c=relaxed/simple;
	bh=1iy6CxC9Waaj0hohnWYknSXb5/aRv741GtNAK6JPztA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeMisrK+PETU3mzdhnuOkfwmmmFeSeDjVUWhcs69GpeRij3vRl1g/KavR6iPCGMxj2Enui3w30wC+CaHaxQuZDixlor+DPLDerFic/H4AGpJONrdlURYavJcKO0HHOsz9GhkkxnuhJPYN1feXtFXZVYJnmmPSNWDP+es8PIsJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=S2ESfiJ/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q6d71is/n12xGe3ig+ts7IS05i+52OoTZJCq8M0DwPs=; b=S2ESfiJ/9sXFR/mb77Ka1u8T9k
	fD848CRqEqlvHlS97wnllKgn7vDyen55rVbbBxfSix62PV/M2lhDrusG00TrXH1yn8Y9kc/ivJ69K
	d5IkUbbwtKzwFreA4zO/bKBwWP6KJ7IdWmOPFK78yNmugYnKtTA0UjMqZm3iGeEMlYxg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rayvC-007zGr-1s; Fri, 16 Feb 2024 15:10:34 +0100
Date: Fri, 16 Feb 2024 15:10:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: net: add hisilicon-femac
Message-ID: <3deb4ac9-558b-4ce5-912c-aa07797d2eda@lunn.ch>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-4-e0ad972cda99@outlook.com>
 <6dbd998c-269d-44eb-bf00-1eb79ee66f0e@lunn.ch>
 <SEZPR06MB69599F74D3C7D2B7705C9DA7964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR06MB69599F74D3C7D2B7705C9DA7964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>

> I've tried accessing MDIO address space and MAC controller address space in
> u-boot with `md` and `mw` [1]. From the result, i guess the CLK_BUS is the
> System Bus clock (AHB Bus clock), and the CLK_MAC is the clock shared by
> both MDIO bus and MAC. The MAC has a internal clock divider to divide the
> input clock(54MHz in common) to a configurable variable rate.

In general, sharing a clock is not a problem. The clock API does
reference counting. So if two consumers enable the clock, it will not
be disabled until two consumes disable the clock. So it should not be
an issue for both the MAC and the MDIO driver to consume the clock.

However, the funny PHY reset code is going to be key here. We need to
understand that in more detail.

Talking about details, you commit messages need improving. The commit
message is your chance to answer all the reviewers questions before
they even ask them. Removing a binding was always going to need
justification, so you needed to have that in the commit message.  In
order to review a DT bindings, having an overview of what the hardware
actually looks like is needed. So that is something which you can add
to the commit messages.

Please take a look at your patches from the perspective of a reviewer,
somebody how knows nothing about this device. What information is
needed to understand the patches?

       Andrew

