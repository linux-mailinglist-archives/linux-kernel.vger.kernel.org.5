Return-Path: <linux-kernel+bounces-61877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE08517B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2871F21611
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AB33C68C;
	Mon, 12 Feb 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NslzxFXW"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E43BB47;
	Mon, 12 Feb 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750687; cv=none; b=nNki16YOWys2BY1lRuZlGn+Lfe7UgdJcUCn12/kV45h5s+RVxzK8l/AX4d4RzQXJWxhe+x0gGLV4O444xAyPh1QNHyE3Pi29gSyZCr4z4uMkkNW1V6UQYvf32yLa8DQz3mr7dHMhQUpqPkHdyxxF9wO382Vyu1OO1AhiEQnlnvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750687; c=relaxed/simple;
	bh=Z6PbrS/54nr3uTDQ/r5+bbWElRXdrXgp6MGlAFsN3TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqq5tH8bFURoASiy9XT3MQxCAR/Cn1PvWmMV/+hRcfdCSTAWMSzOgyuYqE1LY5U9UGUHnFwXI3Gz/lY3UAkc9zweZ/ReQd4fs3n4huFwNPlda9UrzibdKzRXU9IxDas4xgQ/wcSdVjzykzJypEd+B9/Dilsb7kYWwTms+4CDCwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NslzxFXW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ss2Gdsb9s4ZaDWMsTt+eMw+ubVBWFoCUmo1ODydN/mM=; b=NslzxFXW4ui1gaNavsjs4QcwMT
	ef+/bfTQUiNfNdWJNJfyzZZ9IJmo9X7HOu/t0+uEK8HM4UOVzMZ6rYnJECu+Y4U3KgMfXlIfNVBI8
	MjkEebpguYjvxTgUqs38DyyeCaYsysHpkwp3CFhEMszREnHc3AyX+A4zGSeZqlq4cKJ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZXQl-007a9N-Lw; Mon, 12 Feb 2024 15:37:11 +0100
Date: Mon, 12 Feb 2024 15:37:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"afd@ti.com" <afd@ti.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH v4 2/2] net: phy: dp83826: support TX data voltage tuning
Message-ID: <10ed19e3-01a9-4fcb-819f-686c6d0bf772@lunn.ch>
References: <20240212074649.806812-1-catalin.popescu@leica-geosystems.com>
 <20240212074649.806812-2-catalin.popescu@leica-geosystems.com>
 <186cf83c-b7a7-4d28-a8b1-85dde032287b@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <186cf83c-b7a7-4d28-a8b1-85dde032287b@leica-geosystems.com>

On Mon, Feb 12, 2024 at 02:15:47PM +0000, POPESCU Catalin wrote:
> I just figured out that I forgot to disable WOL in the callback config_init.
> It looks the PHY driver should explicitly disable WOL feature at init, 
> and leave it to ethtool to be enabled.
> I will provide a v5 ASAP to fix that.

WoL is a bit murky. On x86, it can be the BIOS which configures WoL,
behind the back of Linux. That is not something i would actually
recommend, so disabling it at boot does make sense. But consider
suspend and resume. If the PHY is used for WoL, the WoL settings
should be kept through suspend/resume. So you need to be careful where
you disable it, so its only disables on boot, not resume.

    Andrew

