Return-Path: <linux-kernel+bounces-81714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889BF867950
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FB11C2AB93
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA3314D452;
	Mon, 26 Feb 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="i36GNJFU"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9C14AD2D;
	Mon, 26 Feb 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958362; cv=none; b=V/NybaR+DA7/X4GtxnFH7ztOtRvOz4KHXpvq7aFBOnAfkWbGOAgFgDTvLBmTW0YMD5Kqxe9vb24kEmSd8RDARZ8uDRduhhIgLIpLYgFPNMvLgXmK45nkFhEqEw4vF6kyWiTv9EF8qLzuxYPyFCmw1L+eQmi553wictYUprz7mLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958362; c=relaxed/simple;
	bh=u6Nlj9aFWUkGtMphlgtcfzyYeMBYqT2bTgNnhxzd4PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOFpq6rrWE0okhZIUPbi8cnh+KMKhcwFhWKRPRNHlu9JP70LF27zruBxHAJ2VKdOZAMN3gHqUZs+5PdEgOtHTqceH53goStOPdkdVhhOCO0DrHjwVIC2NOyno00zWDbUQQSvxQ3dp0okeGauYhIGFnEU3SFVAUslzJfvibj3I6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i36GNJFU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XPs0zPZIiUMU61zxAetpvc6AZcILYC4oTZnxDxpcdNc=; b=i36GNJFUnA++Z4gOewmHXVagLb
	6ejWEec7cnUdo6EPzUZnziutrcncOvwrvq/t31x4xz5gInslKYJbXQH9/Nu7s/CARGxVrP/eckNPc
	YocpXU/nvYsaKSb9a23T84FaOIQ/5Vh9ZMRPJbmLWOQL2dk6OfvW2cRHs6gMThumQ6p4XDdEW9/9r
	iSimuM7vxqGMMNyTL1WEmsiovJdAj/4R77IJtcGI+LKG/FQBiTlyh741voW9xicVhea+DTRbbB3uI
	WQq2A+H6aS4g40j10/cZRZsa7FRSrJa53olqCx2KCIxKgmxG72NpIDwb9mPlR10OMVmdTCJ20KoLA
	4ar5Lq4A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45490)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rec8K-0003qd-23;
	Mon, 26 Feb 2024 14:39:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rec8I-0006VD-77; Mon, 26 Feb 2024 14:39:06 +0000
Date: Mon, 26 Feb 2024 14:39:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
Message-ID: <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 10:16:46PM +0800, Shengyu Qu wrote:
> Hi Russell,
> 
> > On Mon, Feb 26, 2024 at 09:23:46PM +0800, Shengyu Qu wrote:
> > > ODI DFP-34X-2C2 is capable of 2500base-X, but incorrectly report its
> > > capabilities in the EEPROM.
> > > So use sfp_quirk_2500basex for this module to allow 2500Base-X mode.
> > This was previously submitted by Sergio Palumbo, and comes in two
> > different forms - an OEM version and non-OEM. There was extensive
> > discussion about this, and the result is that I'm not accepting this
> > quirk for this module.
> > 
> > The reason is that the module _defaults_ to 1000base-X and requires
> > manual reconfiguration by the user to operate at 2500base-X.
> > Unfortunately, there is no way for the kernel to know whether that
> > reconfiguration has occurred.
> No, In the firmware of this stick, the speed rate is configured to auto
> negotiation rather than fixed 1000base-X.

How does this "auto negotiation" work?

I mean *exactly* how does it work? How does it know whether the host is
operating at 1000base-X or 2500base-X?

There is *no* inband protocol to allow this to be negotiated.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

