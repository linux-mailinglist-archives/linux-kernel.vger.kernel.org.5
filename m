Return-Path: <linux-kernel+bounces-58286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF7584E411
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AFF284348
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBAC7CF1F;
	Thu,  8 Feb 2024 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jYVNYEcZ"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121B7B3E8;
	Thu,  8 Feb 2024 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406145; cv=none; b=gLxfuWiFPSzJpZ8Ssg/IqW677AotnKbpus3A0Zmca0kQS7OH1byU8L0HuyUK89ZJKmpaVjrqq/wxYiDo7ZNjsAVfgZ/KWGXigN9QLryQ/hrlt4zRz+PLr9NnMf4y4pS0+HLgx7KyvshgFSkAkV9uAVeKTfXZTMRfuCQc0EAyYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406145; c=relaxed/simple;
	bh=PWKix2jKXr3GaATEVoBS68T9Tfwt6Jo13vkkigskCYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuiu/CVZ9sB1FRMKRxtx2iGvKJ1+v6JaRH/HDnjIQvnXLiXAScGYrXBlN89XRhBtbo7rIkmHKe4LZE9p3myu6WSp3y9SliqFt9PhSwOoiRAuR2eCC/IYRpvd7QshNDpOPBwO+NVVAeOdzbqM1f2Dd36Tq/AUI+600iI8YJs5yM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jYVNYEcZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ti0YAgSioGF9FSFHJYn0ruEVqEp65nTgDbJ/iL5dHSs=; b=jYVNYEcZ9HmlQ+cD7nhE40Nu6z
	GnC8qmWuIQpLCyMSApowCI4ER3NhLw90JKR+PuBijJ2FyWkLyPC1g/xTBn2LPZjtpWDdmm0bo6/Nb
	LDM6M9O1bMIw0TX75iB8X9QRlK9iS1m93ii8bARZHvWeo/nZikzATkE4pZ3K+lKLSz+SUxHpcPqEN
	353B4FQPLh52U9UvRS5zouhs7AyzD3dVPkcU+S8j/k4E3pDwYE0WPSJOGtIR+46nyMvIKFSouxWym
	NskBuZBLRBEZ/sMT8uNT8KJOafFaLZPMYdKLef/bVzFwVNAI4ezHPCqBrEf2faRhShRIP6UOz7q/l
	HI+s4ESQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47690)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rY6Ka-0004bQ-39;
	Thu, 08 Feb 2024 15:28:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rY6KY-0005cD-7X; Thu, 08 Feb 2024 15:28:50 +0000
Date: Thu, 8 Feb 2024 15:28:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sergio Palumbo <palumbo.ser@outlook.it>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON
 ONU SFP
Message-ID: <ZcTzMgxmA6WOoiA/@shell.armlinux.org.uk>
References: <AS1PR03MB8189B99C360FB403B8A0DD6882422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb0t+zKHx+0wTXH5@shell.armlinux.org.uk>
 <AS1PR03MB8189D48114A559B080AF5BEA82422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb1+p6FiJwUF53xc@shell.armlinux.org.uk>
 <f8cf41f2-4a90-4ef5-b214-906319bd82d4@outlook.it>
 <AS1PR03MB818911164FB76698446CFEDC82472@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcI+7grKa33oLtwc@shell.armlinux.org.uk>
 <AS1PR03MB818926990092981B0E09E60B82442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcSZtLSWd09xqc10@shell.armlinux.org.uk>
 <AS1PR03MB8189A24B92030AA8F011C7B582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR03MB8189A24B92030AA8F011C7B582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 08, 2024 at 03:00:08PM +0100, Sergio Palumbo wrote:
> Dear Russel,
> this is the first time I do such a test and kindly ask you to help me in
> preparing it.
> In my openwrt environment I have found phylink.c file in two different
> directories:
> /build_dir/toolchain-aarch64_cortex-a53__gcc-112.30_musl/linux-5.15.137/drivers/net/phy
> /build_dir/toolchain-aarch64_cortex-a53__gcc-112.30_musllinux-mediatek_filogic/linux-5.15.137/drivers/net/phy

Oh, openwrt. That means I need to re-understand their build system to
advise how to do it. I only know the mainline kernel.

> do I have to change both adding a line:
> #define DEBUG
> 
> before the first #define line:
> #define SUPPORTED_interfaces \

Mainline has never had "SUPPORTED_interfaces" in phylink.c, so I'm
wondeirng what that's about. I'm also wondering what other changes
there are to it. I'm also wondering whether the behaviour you're
seeing is somehow special to openwrt. Too many things to wonder about
and effectively means there's too much that I don't know.

Therefore, I don't think I can help you, and I don't think I can
possibly accept your proposal for this quirk. For mainline, as far
as I'm aware, it will cause these modules to regress when they are
in the manufacturer default state when used with a host that supports
both 1000base-X and 2500base-X.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

