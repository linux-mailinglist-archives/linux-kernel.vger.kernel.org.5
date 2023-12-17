Return-Path: <linux-kernel+bounces-2524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56A1815E6F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721EF2831C8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 10:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560BE20E6;
	Sun, 17 Dec 2023 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ixypsilon.net header.i=@ixypsilon.net header.b="AGoAW/i2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from uvw.ixypsilon.net (uvw.ixypsilon.net [81.223.58.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163211FAD;
	Sun, 17 Dec 2023 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixypsilon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixypsilon.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ixypsilon.net; s=20210903; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I5qCWbnHdT3J6I/2pNx1YRFPO8CuYS6nTizw89enV14=; t=1702807829; x=1704017429; 
	b=AGoAW/i266xFMTE7jjgGsNuuWCvKQ8K/9UoRg8bzuMfaP8IK8UbjdL6JlYHu1vIF+1DWrUYld12
	L0WTG3mucitmI5k8BHUPprYtkd8JciVf8c48018RR36G/25W36INHqEKeyQSHN8E7NbbN5Bzyrw46
	fD9EJ11G5Q3T3TpJTBTmxUV6UXONY5Hova1UpiWpS6ntlwXRC1OON0UNQJwOiGpFoV9BsuYDrwlyW
	T53DamA5oWniavJDNFs8qnM7bjL/qm3dUpFcYbL0a7hopPh+hhSoHHy6nGBtN/OL3aFUeFvH1tFEs
	KNnP/SD0rG9VBUQhgVH0GT2y9avrkmU7jHAg==;
Received: from [192.168.0.1] (helo=[192.168.0.12])
	by uvw.ixypsilon.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <stefan.nagy@ixypsilon.net>)
	id 1rEo64-0000o9-1I;
	Sun, 17 Dec 2023 11:10:10 +0100
Message-ID: <2f5e3bacaedb979748417dff77364530f3fb7a62.camel@ixypsilon.net>
Subject: Re: [PATCH] arm64: dts: rockchip: Increase maximum frequency of SPI
 flash for ROCK Pi 4A/B/C
From: Stefan Nagy <stefan.nagy@ixypsilon.net>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 17 Dec 2023 11:10:08 +0100
In-Reply-To: <4fce0de996d6cc3056d972cd3fc3fb93@manjaro.org>
References: <20231215122848.59534-1-stefan.nagy@ixypsilon.net>
	 <33e632c38fa57053585c0016652ed8c8@manjaro.org>
	 <4fce0de996d6cc3056d972cd3fc3fb93@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0

Am Freitag, dem 15.12.2023 um 19:20 +0100 schrieb Dragan Simic:
> On 2023-12-15 19:15, Dragan Simic wrote:
> > On 2023-12-15 13:28, Stefan Nagy wrote:
> > > The ROCK Pi 4A/B/C boards come with a 32 Mbit SPI NOR flash chip
> > > (XTX Technology Limited XT25F32) which has a maximum clock
> > > frequency of 108 MHz. However, the Rockchip SPI controller driver
> > > limits the maximum SPI clock frequency to 50 MHz. Use this limit
> > > for spi-max-freq.
> > > 
> > > This patch has been tested on ROCK Pi 4A.
> > > 
> > > Signed-off-by: Stefan Nagy <stefan.nagy@ixypsilon.net>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts | 2 +-
> > >  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts | 2 +-
> > >  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts | 2 +-
> > >  3 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
> > > b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
> > > index d5df8939a..30e63e62a 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
> > > @@ -19,6 +19,6 @@ &spi1 {
> > >         flash@0 {
> > >                 compatible = "jedec,spi-nor";
> > >                 reg = <0>;
> > > -               spi-max-frequency = <10000000>;
> > > +               spi-max-frequency = <50000000>;
> > >         };
> > >  };
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
> > > b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
> > > index bee6d7588..7122bf6c0 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
> > > @@ -37,7 +37,7 @@ &spi1 {
> > >         flash@0 {
> > >                 compatible = "jedec,spi-nor";
> > >                 reg = <0>;
> > > -               spi-max-frequency = <10000000>;
> > > +               spi-max-frequency = <50000000>;
> > >         };
> > >  };
> > > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
> > > b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
> > > index de2ebe4cb..8af75bc7c 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
> > > @@ -49,7 +49,7 @@ &spi1 {
> > >         flash@0 {
> > >                 compatible = "jedec,spi-nor";
> > >                 reg = <0>;
> > > -               spi-max-frequency = <10000000>;
> > > +               spi-max-frequency = <50000000>;
> > >         };
> > >  };
> > 
> > It would be better to upstream these changes to the Linux kernel
> > first, and then sync them back to U-Boot.
> 
> Oops, my bad, sorry, I got confused with your other patch on the U-
> Boot mailing list.
> 
> Regarding the new spi-max-frequency value, it should be better to
> have it set to what the SPI chip actually supports, and let the SPI
> driver do its thing.

OK, I agree. I'll send a v2 of this patch with a new spi-max-frequency
of 108 MHz.


