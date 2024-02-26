Return-Path: <linux-kernel+bounces-81842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D5A867ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954D928924A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54FA12BF26;
	Mon, 26 Feb 2024 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="P1/DIoeU"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183F1BDDC;
	Mon, 26 Feb 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962653; cv=none; b=oAlp0juLQtIkbFr5GGzypKLvIDgtJDko73V8g+Y20Bkj68K3yv8pQFNL6DnkC8CexhP09DQk/NfHarfa0wtL9vlsvCU0KrVnoqqXoPZl2p9j5Pdk+buKmJL5BDHwZuaF+y+/nEClMKhfPGy56p1X971kzoWNOJcVvIbsVxB65Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962653; c=relaxed/simple;
	bh=hePlh93u4XXUHR1BI8WwV3QAM8EGXP2vvnNe4R5gcAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSJFN9om/WTbXRxDTo68SWSrzQCNXA/M0XEQh/JCwshiE62h8xOSblMxhrodo0Xst2RYbCzU1knDuD67XMJIeOKo0pv8jA2jzsgoR2YYYT+W+iy3kr6Lf7fpy88RNafvlqYrkjloqBBm6/qo46SK+APgcszuvLB/mVFBbYOeWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=P1/DIoeU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VTknhU/j0S+TFKgathhuAGd6GVWPtOPefADa7SFok1o=; b=P1/DIoeUAxIuhX8rToX6Jm818m
	2Il57xrk8I2BUehcQQpqbUdvwRdfXRlnjDEU+TmhD98V4ST5G+lrb2pcSnIDB5yD/qqEWh0ukF1d2
	trRol/o7ha7Y68IdXCwZMfQCdb/vqnAsVC+QWyCea2hV6jVoKKMs5DMdE9Lf9Bxm/D6X0Az9RxoLq
	wvS6CvK46gJdRGf92M3T4e6BCxMW11BjIM9/fvr9nrWI4/aVfZg/K2ISM2jeB6jUmA9y6JAky4gQ9
	4BUHm3JidYRr5fJenhPFRO6mQ1aSJ6BmkoqEUCmzzme+5hkPh1FXkS6bveTcfSYOIGJjS6TYcUOMx
	tWlozHbw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33124)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1redFZ-00045f-2G;
	Mon, 26 Feb 2024 15:50:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1redFY-0006YJ-FF; Mon, 26 Feb 2024 15:50:40 +0000
Date: Mon, 26 Feb 2024 15:50:40 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
Message-ID: <ZdyzUMQ+MmQ7E7sX@shell.armlinux.org.uk>
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
 <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <b8fdb5df-57e4-491a-b310-e8e13a89d331@lunn.ch>
 <TY3P286MB2611578CBBB25D48FA5452A7985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB2611578CBBB25D48FA5452A7985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 11:20:47PM +0800, Shengyu Qu wrote:
> Hi Andrew,
> 
> When telnet connected to the stick(It's using busybox), "cat /proc/kmsg"
> would report something like "<4>change mode to 0", that 0 is the actual
> speed rate codename it changes to. You could check this [1] for more
> information.
> 
> Sorry but I can't record my kmsg output now, since enable connection to
> my stick would make the network to disconnect for all users and my
> roommates are using it.
> 
> Best regards,
> Shengyu
> 
> [1] https://github.com/Anime4000/RTL960x/blob/main/Docs/FLASH_GETSET_INFO.md#lan_sds_mode

I'm aware of that link, and sadly the information in that table can at
best be described as "confused".

For example, under "Behaviour" it mentions "1GbaseT/100baseT". How
exactly does a SFP module exhibit baseT behaviour (which is twisted
pair copper ethernet.) Hint: it can't and it doesn't. "Mode" being
listed as "TP" is also misleading and wrong. The ethtool value of
0x20 is bit 5, which is 1000baseT_Full which has nothing to do with
a SFP (and won't be reported as even a supported mode for this SFP.)
Bit 41 would make sense (1000baseX), which is listed against mode 1.

I'm afraid looking at that URL just adds to more confusion.


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

