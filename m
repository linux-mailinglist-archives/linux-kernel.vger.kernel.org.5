Return-Path: <linux-kernel+bounces-81578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D874A8677CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157F81C23231
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA69A12BEB1;
	Mon, 26 Feb 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Clac9yRf"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A36E5E4;
	Mon, 26 Feb 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956310; cv=none; b=g3m+r2E3VXBYtvM4LKBdBwov+ZZ9s30NhuNXchTt32uCdUGsCxcb2a215cZdlOJMgG3F0PNEBFMpPHgMuf686Y6eCBjhduDdRep4i+GoZTkQslPNXzt1fATLJ5y6TBPyGzehwGGJJbY1rMFGMb/lt9mzpEyl3/h62KlXNVDabDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956310; c=relaxed/simple;
	bh=dnftFdY8VqdOgojQCgXwDM7PhxDarzbWxRwZDJmUAOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sl2o9Qj+RbYrHma8X2O6SN2VfmVqPqEkS8xVoGaxez1YSEgkz1+ZXnK0n2o64vp0yTzdX00OsZcdEbgAb9YML7e5DJlC/ITYfxsqGB3/zLVg1qX+LuqNVOeygIPzRdCXpLUJDZ1/tIHi8mdzn9MaZL/BOvCyU/wPXKXiFkSM4OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Clac9yRf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5y6HROkFi5XzN2ly4doWlXui4PXni9QOJgZq8uvzy6Q=; b=Clac9yRfCmprivunqvFzwOF3Vp
	veOafi534cS4fkI0gDuYJw8uMv9Sepu5nfwf2AdzEMfpGX54AD4rCKMZBrAbSGZz4YSzQeqPE2XnG
	8zjky85kAJWCfDtnQigvkDeB+ZXsNntPL2Yn2SGLkloL858VTfTFKSjWI5HpXgdJ2uyT62llekbjk
	HNiqcKu0YTSMiztAAHLyYvQ5saMhYrBLD1c1y7SBY/of9cB70m+uc2ejoxWHsjBuKYYkN1K2Hsph9
	3Llwr/jGu1J96/QED3PyiVzHsEHC07LlM1g7ncTB54/l4NPgN/mwG0vZxL5ixHRidryVEVoomoCA4
	ttYTIFPQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44126)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rebbE-0003hL-1w;
	Mon, 26 Feb 2024 14:04:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rebbB-0006Tw-Ix; Mon, 26 Feb 2024 14:04:53 +0000
Date: Mon, 26 Feb 2024 14:04:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
Message-ID: <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 09:23:46PM +0800, Shengyu Qu wrote:
> ODI DFP-34X-2C2 is capable of 2500base-X, but incorrectly report its
> capabilities in the EEPROM.
> So use sfp_quirk_2500basex for this module to allow 2500Base-X mode.

This was previously submitted by Sergio Palumbo, and comes in two
different forms - an OEM version and non-OEM. There was extensive
discussion about this, and the result is that I'm not accepting this
quirk for this module.

The reason is that the module _defaults_ to 1000base-X and requires
manual reconfiguration by the user to operate at 2500base-X.
Unfortunately, there is no way for the kernel to know whether that
reconfiguration has occurred.

The addition of this quirk makes the kernel select 2500base-X when
the module is plugged in to a host that supports both 2500base-X
and 1000base-X, resulting in the link with the module never coming
up. (2500base-X is 1000base-X clocked 2.5x faster, and there is
nothing in the line protocol that identifies this.)

Consequently, adding this quirk makes modules in their default
configuration not link with the host, and thus be inaccessible.

Therefore, for the best user experience (in terms of having a working
module when it turns up at the doorstep) the only option is to refuse
this quirk.

Now, what I really don't like is that I had a lengthy discussion over
this with Sergio, and it seems from a mainline developer point of view
that "oh, Sergio wasn't successful in getting this merged, someone else
can have a go".

It _isn't_ the person who is the problem - it is the principle and the
confusion this will cause to users who receive modules in their default
configuration (1000base-X), and then plug them in with this quirk in
place, and the kernel selects 2500base-X resulting in no link and *no*
access to the module.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

