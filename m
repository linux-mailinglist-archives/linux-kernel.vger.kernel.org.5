Return-Path: <linux-kernel+bounces-21854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9C8829546
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E1F1F27788
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B42D39AEF;
	Wed, 10 Jan 2024 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="oFUD/rKd"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8C91D683;
	Wed, 10 Jan 2024 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 357696054F;
	Wed, 10 Jan 2024 08:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1704875422;
	bh=bFoJA47e/ENQMqfrZCLeRoCUKOWsd4nstT11nKJGDEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFUD/rKdNHlx9bjp6ogxVOFj4ZI/BOAzLLQBtWg5/TRZhMohqej9K85C1Lpzhl7W7
	 8laoKqARuPWNg5S7DAKwpovVR1Y6uXZmpS5qbWI7ehXoLGbVSDNP2ZuHLJj5wwz1sW
	 Dpe/375EBlmljQTyGl/QmMIBBtqnMArNTLevJ4rJ7hbxybvH3MjIIPlAItPyIh2npD
	 X9O8fvQBcrrt6ZLIZlmDy5zx6rFhA87E73hhyh+trKl6lR9ppWTXsfcCC+p8PpWHdM
	 0OU1RfCWx3HTulxANJWE80mhmT0+iyz9m3KlvqSGCyLqc/9XgrmQaqt2vXAHQ0y0WM
	 TLR4v3NQjCHJQ==
Date: Wed, 10 Jan 2024 10:29:24 +0200
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
Message-ID: <20240110082924.GA5185@atomide.com>
References: <20240109171950.31010-1-afd@ti.com>
 <20240109171950.31010-9-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109171950.31010-9-afd@ti.com>

* Andrew Davis <afd@ti.com> [240109 17:20]:
> --- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> @@ -850,12 +850,19 @@ target-module@56000000 {
>  					<SYSC_IDLE_SMART>;
>  			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
>  					<SYSC_IDLE_NO>,
> -					<SYSC_IDLE_SMART>;
> +					<SYSC_IDLE_SMART>,
> +					<SYSC_IDLE_SMART_WKUP>;

You probably checked this already.. But just in case, can you please
confirm this is intentional. The documentation lists the smart wakeup
capability bit as reserved for dra7, maybe the documentation is wrong.

Regards,

Tony


