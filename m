Return-Path: <linux-kernel+bounces-84863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA1A86ACC6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682B8284C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF4C12D777;
	Wed, 28 Feb 2024 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="twqyNHC2"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F3712AAEF;
	Wed, 28 Feb 2024 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118957; cv=none; b=IXG87LZ+K2LvoBDM/4KCp0LmmsORnHkwWfvOlgSgbsi54kCjJrRCbt2x5LKNgMNM+Plv1I+PsVJk9jeCXbKqrM/wXvp56rFAoZ4i/zWBBJ437RykHpz1JaMoElHPh7KEgHGZ5m+5qMtOeH2QKQI/Dr50Nt0dYIzCTdCa4WUypRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118957; c=relaxed/simple;
	bh=TQ/YwyKxlqI1Y4hUm9MOyJBRStGaTQj83ZS3poyCqH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1D1VCHNZU8Tkcz7qo9s7w7+H/xKil6+oeI2OQ1tcLGbnhPTuB3qsLXgdzBiR4ocS5YBqEC+kyU/yF83rXD64UQDUhh55NwOnjJKC3JpkGIJCopyt+hbUI0b0CLJGIAIzruVp5h0B4NBYDt0emCDQ2bhiZ+Jxpv8yKqduBIaNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=twqyNHC2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kr0+UQeVSYNZ4QKTsVOt17tKmNujoD+5WHzstujRJJk=; b=twqyNHC2YcFsIZu8bR+3JS6H6C
	zoIgDE+uOwWAUl1WZC7bNXdPQ18b95oFUOQiXiBqmV/XYurb0ouKZvGvhqI+zyyjmANFy9Fv2h5+R
	9JTkCwkYBrcuDRprgWOe1mdqjyFjfWMcEYIIPPbeps/5fVQJZJahirmWfjWEMpVLtanQray6sWtlP
	CyvpQLMERTyG2pPNu1yRJ8qu493dpWtVH1SC9EFGH8XXaOu6K36F0RhIS2M+JKdMOS5WmGlyFLWp5
	nSpJGr0kiPIP4JH44fVbdeLBDxeDOGjrPAhVvyPoCndn7dmtTQeonWj3J3V+Zr93b7UGs+7kKjD6s
	adqRIU4A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53478)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rfHuX-00044y-2r;
	Wed, 28 Feb 2024 11:15:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rfHuV-0008He-8K; Wed, 28 Feb 2024 11:15:39 +0000
Date: Wed, 28 Feb 2024 11:15:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
Message-ID: <Zd8V2z4sKzVj+4jX@shell.armlinux.org.uk>
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
 <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyxXzVe+fsILxrS@shell.armlinux.org.uk>
 <OS3P286MB2597F3FDEAB7A1CC886F414798582@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3P286MB2597F3FDEAB7A1CC886F414798582@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 28, 2024 at 06:42:55PM +0800, Shengyu Qu wrote:
> Hi Russell,
> 
> I got contact with someone that has access to this chip's datasheet.
> He tolds me that according to the datasheet, this chip
> "supports a rate adaptor feature, which is a Realtek proprietary SERDES
> mechanism."
> " When the chip's SERDES operates in Rate adaptor mode, the SERDES speed
> is fixed at 2.5Gbps and the Ethernet speed cannot be higher than the
> SERDES speed.
> The SOC need not follow the Ethernet link speed, and cannot change the
> SERDES speed in this mode. There is a data flow control mechanism to
> ensure correct data transmission."
> 
> Is it enough to put this into the commit information?

I think you need to read that again and understand it. Specifically
"the SERDES speed is fixed at 2.5Gbps". When operating in this mode
(rate adapter mode) this would mean the SERDES (which is what talks
to the host) is fixed at 2500base-X and is fundamentally incompatible
and incapable of linking with a host operating at 1000base-X.

"Rate adapter" is a term that is used by manufacturers to mean that
a e.g. PHY is able to operate at several different speeds on its
media side while operating at a specific speed on its host side.
E.g. a PHY that presents at 10GBASE-R host interface but supports
media at 10M, 100M, 1G, 2.5G and 5G speeds. Typically, it controls
the rate at which the host sends packets by sending PAUSE frames to
the host.

This feature is irrelevant to the abilities of the module to link at
either 1000base-X or 2500base-X with the host.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

