Return-Path: <linux-kernel+bounces-81760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DECD8679D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE213291BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAC912BEB9;
	Mon, 26 Feb 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qgABhc4V"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C412B157;
	Mon, 26 Feb 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960013; cv=none; b=Vr5LFyDmqvqg2+ooVh6mloLSIIjDt4Z319z5rk25llo++nhhztWvoC9vRTijLXuJ1MCXIPnvZ7HKlPnPcXl0CP+U2e6PBFklcxVLtOeE4sWqZ2LXk6m9kcNLasOxU/FvECcRU/1L/QWhn8OyxbWbHg4Ude8L9CV5T7RVNzfRMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960013; c=relaxed/simple;
	bh=gTTT/xt37ba6unWv4bWQIlsiwtT9vCOYF4yilWXM058=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjRbzcuudHRpS2JBPp979ZuRJHQbOOiM3q1REE0S4NmQ6mkkdaZE7c5uoEFy3UGL6FZ1vY2guO3YeyUrAbrwrx3hDf8B0EQci3UDzMIpBuJAFCd1qmp+hN+bF0NlxJEuKO3tVA8bh3x3eEss//fcClDuxlAZ2jHo41gNzg+7S1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qgABhc4V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nGdq6XXk/UeuFTtMavMdttmSA0H2jvS5cq8hYJMXAAE=; b=qgABhc4VCew3o6bM8DM/zk3Nhx
	6ofzYt23vaaOqwho9Sz+QjCExHO1D3JxIxkJJDbw4CuELj+2CXQ2RjUQBdJem0lb1nG5DzYXsS323
	ejPk9phPb7CiS59mMOLbmyv4W6GmHBzTGnN6/V3b2uDlEKYf+UDlIkczFDY3MjEcgJT8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1recZ7-008jZO-R1; Mon, 26 Feb 2024 16:06:49 +0100
Date: Mon, 26 Feb 2024 16:06:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
Message-ID: <b8fdb5df-57e4-491a-b310-e8e13a89d331@lunn.ch>
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
 <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>

> Well, that seems some kind weird trick implemented in that chip's SDK (maybe
> hardware?). It would automatically detect the speed rate that host uses and
> switch to that rate. The system log of the stick shows that.

Please could you show some examples from the system log.

If this patch is accepted, these details need to be in the commit
message, to explain how this actually works, when it should not
actually work....

       Andrew

