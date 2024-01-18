Return-Path: <linux-kernel+bounces-29922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE3C831538
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885201F22DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEC41D55A;
	Thu, 18 Jan 2024 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="Gw04zt0W"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369F012B6B;
	Thu, 18 Jan 2024 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568211; cv=none; b=om9c3oYFJEPNGniRjTPcq1swSSOe4TE97EOEY/OcFfbGFs3+zT73Pf36SdLfqf5hZN0kwRYU0wab+4rnwGbuTs+xzGYgQSdSCnaWaH6g8/YijBMJMR+xZFBqVdqasFKOVpzXsKlEzBH/vWFwSvdroYPGqO7WJxEkzWPzdrGAVag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568211; c=relaxed/simple;
	bh=vULAl46BBydQR4ps2jMZiFaBG2168vzYuRJQjRETXmM=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=nhNn7IN6Skrow6ERuKY+PA5TEFhceeGkqX4dVPv2jRUkiVW3lcZaDf9l5RyUvKv6mRC9bUwstwb659M56L+f6hqpw/9kTAYKJpdxEdR4yVvnFJ13arHjj7r5rviX6FcUnm2qg5NM2pd6+6G/Q1BLHgjUcWhFlU9T1tID16qhWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=Gw04zt0W; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 8CA6960547;
	Thu, 18 Jan 2024 08:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1705568209;
	bh=vULAl46BBydQR4ps2jMZiFaBG2168vzYuRJQjRETXmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gw04zt0Wpjy9eWoxk2lS2uRHPyetKndWTDy1xt3tVGx6vKHlNkOkWIOKrTzvdlw/9
	 66hcjRDA6awFbthpcjUwMl9Ag054ol8J7CDoqS8Ylxom3qRjvEEiO42kKCJd7piKXG
	 /pBdyyWMFJWk62EFvYAkz/ET12d+9KZ1ZrUe4VIu/KG0WZBdK7YpSKhh2xshMli9/S
	 gVVlFTKdKDM0zIga8bgoPdDQsFxhXBtVWbkeetqLrliFyg9Pu7b1qV6J7RCc90wGT2
	 zl6zEaNx93DQC83AFSlIeGXIbiPEfkOHUAzePS1mHU6/9kjkvMvgRKFiAOeMPcANkR
	 mknuZHXKNV/qg==
Date: Thu, 18 Jan 2024 10:55:51 +0200
From: Tony Lindgren <tony@atomide.com>
To: Andrew Davis <afd@ti.com>
Cc: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Adam Ford <aford173@gmail.com>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH 08/11] ARM: dts: DRA7xx: Add device tree entry for SGX GPU
Message-ID: <20240118085551.GQ5185@atomide.com>
References: <20240109171950.31010-1-afd@ti.com>
 <20240109171950.31010-9-afd@ti.com>
 <20240110082924.GA5185@atomide.com>
 <55efd488-c6a0-4dca-baea-1fa93d13dd17@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55efd488-c6a0-4dca-baea-1fa93d13dd17@ti.com>

* Andrew Davis <afd@ti.com> [240117 15:52]:
> On 1/10/24 2:29 AM, Tony Lindgren wrote:
> > * Andrew Davis <afd@ti.com> [240109 17:20]:
> > > --- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > > +++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > > @@ -850,12 +850,19 @@ target-module@56000000 {
> > >   					<SYSC_IDLE_SMART>;
> > >   			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> > >   					<SYSC_IDLE_NO>,
> > > -					<SYSC_IDLE_SMART>;
> > > +					<SYSC_IDLE_SMART>,
> > > +					<SYSC_IDLE_SMART_WKUP>;
> > 
> > You probably checked this already.. But just in case, can you please
> > confirm this is intentional. The documentation lists the smart wakeup
> > capability bit as reserved for dra7, maybe the documentation is wrong.
> > 
> 
> It was an intentional change, although I'm not sure it is correct :)
> 
> This is how we had it in our "evil vendor tree" for years (back when it
> was hwmod based), so when converting these nodes to use "ti,sysc" I noticed
> this bit was set, but as you point out the documentation disagrees.
> 
> I'd rather go with what has worked before, but it doesn't seem to
> break anything either way, so we could also break this change out into
> its own patch if you would prefer.

I agree it's best to stick what is known to work. How about let's add
the related information to the patch description?

Regards,

Tony

