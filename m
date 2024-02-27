Return-Path: <linux-kernel+bounces-83061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA0C868DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624642860B7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1FA139594;
	Tue, 27 Feb 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="F6H4VZvC"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877D1386B3;
	Tue, 27 Feb 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031030; cv=none; b=UroDivX9mOU2CtXG6nJneiHW97ltpuvLmPHxYZVWWzmrWnlS6IdJlK5FGgs/5zkKL16y9eU9n+Ez+YRgBal05q8oyFn5ZadLg1INPdFUe3zVR3wfPGfdx6GdUNVudFsPwQHQYNe9PRo0fNzM+a+iYNJcsG1LLjkU6huHI5cUV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031030; c=relaxed/simple;
	bh=VwY8x8Vlvy0pr005Hz3YAUwOJLUuvB336WB7fyepl4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br/4bazBGuKmmPH62UmFXL/Vtc7+mnGyVx2xQVCGJV8kc+TytoI27X0xYyfXJB7eyjRjif1ePhik1W6SG3jzHS8PiG7tIv1Owe3SB6z7hOowrEKSRcPNUKteZBlO7wAhyv1xnY6xLP3XhpSXuPy6iY2Tx6dL6o3auz+/F16VxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=F6H4VZvC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B0GwNKyxnzYc2XZeJrd2Jp5upk3uHbpBLhel/j4Yu/g=; b=F6H4VZvCxh+oko+L1U7idHXzpv
	5mSBTveOKOzNSpLbTrR+M7PYwoYlRjJNbNJkCyGeFxVJJMJs090VrFzcmWtj4pGL9Uv6AhSaW9mlV
	dzaqys+fCiPY+JqY2P9CAOUQXu5F9xCtPDEXjET14bImYYxdsYd2VLVrlDRIQV1C6+fGvJnmigDV1
	mgk5RGtRBACg8tVs6lac+SzGvN5EbM3Ia4/gUJTMP1iRS5+SVCnrsFIclhgJVuRSwUp4kRSpQtNlj
	AmRrmwbmzATOnVzCqoDVnAdBtUIU1gDVZSz9YdYkSf5+NeVe9i6Ss3IBn4uZD9838OvLAo+098h4V
	5La3mY+Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36540)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rev2J-0007rZ-0M;
	Tue, 27 Feb 2024 10:50:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rev2G-0007L7-6v; Tue, 27 Feb 2024 10:50:08 +0000
Date: Tue, 27 Feb 2024 10:50:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, christophercordahi@nanometrics.ca
Subject: Re: [PATCH v2 3/6] net: phy: DP83640: Add LED handling
Message-ID: <Zd2+XwM7hIpycjVO@shell.armlinux.org.uk>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
 <20240227093945.21525-4-bastien.curutchet@bootlin.com>
 <20240227105806.7201b34a@device-28.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227105806.7201b34a@device-28.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 27, 2024 at 10:58:06AM +0100, Maxime Chevallier wrote:
> > +		val = phy_read(phydev, PHYCR) & ~(LED_CNFG_1 | LED_CNFG_0);
> > +		switch (mode) {
> > +		case DP83640_LED_MODE_1:
> > +			val |= LED_CNFG_0;
> > +		break;
> > +		case DP83640_LED_MODE_2:
> > +			/* Keeping LED_CNFG_1 and LED_CNFG_0 unset */
> > +			break;
> > +		case DP83640_LED_MODE_3:
> > +			val |= LED_CNFG_1;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		phy_write(phydev, PHYCR, val);

This should also be phy_modify() as well. Any read-modify-write sequence
is open to race conditions if it is open coded because the bus lock will
be dropped after the read and regained on the write.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

