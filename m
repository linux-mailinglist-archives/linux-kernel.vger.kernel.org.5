Return-Path: <linux-kernel+bounces-95256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6511F874B5D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A1F1F25CB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDE685278;
	Thu,  7 Mar 2024 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pAROI+NQ"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93EE85265;
	Thu,  7 Mar 2024 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805247; cv=none; b=TW8wB/3b5PkyNkb75M4RDJN4p051MqW0y2VQV3Evh9gT2Xpw1xDqdqMr64vwArvU6o6I/6SF+dNUQ7eqEUB0T9y2CdLEV9skOSVrwTHP6PDVCrEQWmPgxKZt+IdBsKR5JduPgiUQZUdjGNbQVFnZqmA9VH7igthxMKIK1zjCH2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805247; c=relaxed/simple;
	bh=0SnMAXaV9sTSjk/IyJvoJM+DoU/obkmhOdV/QOy3nVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+CruSCoblOKoX+qk0z8P23RZ/VJJSqTW+t4t22aGewFg56mC6Tn3T1kovkfOLwEOnftJU2x7l5A41/e2UFUCD/Br5VozSbx89hHursYCNTZwlPOv6D0Mbot7aJWy2hGIERTpBj5bLIV9GKnLm8Rj4M2G+rGv4D6vfBdAZhKpgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pAROI+NQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8Wd64duwC2fsuB7URl1NXnnq7MkV0J65J9GZP0R8Zyg=; b=pAROI+NQ6k0gEPLDCZC9vSq2a2
	NvhwoJhDMUZzsSH3Z1u3sllij5F1bZoFdp4psANIE+slOl5DQQvlUT3Avzp1OIkzXjP1/nJvlZBhy
	ipu+8AAk4VbrKOpoLinBncLOrXZ0jpXquDJsN62igLplPPvIacodJ9VrRCcsQylURkD5HvpzDONBC
	Z8LGF9CvJOtRX685zHd6T3avF2i/cUSHMmFfrp8UK+xC2aKDWjlhxMbTOapsrN+ykuE5fqnxUvDD8
	6uL+FngsruGxYHV6Ypfhj7FIfIR+BVHaBR+F33R4BE+8mVYCyEwU6/QFTTndvO4pHds+yrwkrzGX1
	vhKUIq7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36770)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1riARf-0000tY-09;
	Thu, 07 Mar 2024 09:53:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1riARb-0007AW-U5; Thu, 07 Mar 2024 09:53:43 +0000
Date: Thu, 7 Mar 2024 09:53:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?iso-8859-1?Q?K=E9vin_L'h=F4pital?= <kevin.lhopital@savoirfairelinux.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Murphy <dmurphy@ti.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: Re: [PATCH] net: phy: fix phy_get_internal_delay accessing an empty
 array
Message-ID: <ZemOp4MGP/UK31wq@shell.armlinux.org.uk>
References: <20240307085254.183905-1-kevin.lhopital@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307085254.183905-1-kevin.lhopital@savoirfairelinux.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 07, 2024 at 09:52:54AM +0100, Kévin L'hôpital wrote:
> The phy_get_internal_delay function could try to access to an empty
> array in the case that the driver is calling phy_get_internal_delay
> without defining delay_values and rx-internal-delay-ps or
> tx-internal-delay-ps is defined to 0 in the device-tree.
> This will lead to "unable to handle kernel NULL pointer dereference at
> virtual address 0". To avoid this kernel oops, the test should be delay
> >= 0. As there is already delay < 0 test just before, the test could
> only be size == 0.
> 
> Fixes: 92252eec913b ("net: phy: Add a helper to return the index for of the internal delay")
> Signed-off-by: Kévin L'hôpital <kevin.lhopital@savoirfairelinux.com>
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>

The sign-offs look wrong to me. They indicate the path that the patch is
taking to be merged into mainline. Who is the author of this patch and
who is passing it along? If it's co-development, then there is a specific
tag for that.

For the actual patch itself:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

