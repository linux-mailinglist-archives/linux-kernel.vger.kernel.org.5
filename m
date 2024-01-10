Return-Path: <linux-kernel+bounces-21855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E382954E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51C8B26252
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACAB3A8CA;
	Wed, 10 Jan 2024 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="lI0HjohH"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99370360AD;
	Wed, 10 Jan 2024 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 081BB6050F;
	Wed, 10 Jan 2024 08:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1704875996;
	bh=wG6D9r+AI35mwEbnFd6ymRyQAT79Vq6rM5ctoGLtHBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lI0HjohHY5ZqItxAs8wT161JVYpJtAgnjXEDs+XAyJc9k4uwAIKZILCoxniGxeHM7
	 NMpL2XdZBWs7+S3w/NZWsNimkeJR16R95GGWUpKizv2Adtqb7FXYWlzxwi2V8+nFoP
	 RTiflB6mFHXKPGPj2+TZa7Ttqzte47OVO5wCtpk/a3jM3EtOWoczIwawN0tSH8TgEZ
	 p+8904d/1MpIM6uukmZIHlwKjUrgcv3Hn6jYHHrOMm5heZJAuYWXVcNuvp1ITYC3H5
	 5YZX2Q1DTS1LnZJLB3LqYmb7VI5cGaZX5FqpnZ+7cjS6IsYI7KpDEbaMmJIcktwVcV
	 lgNioh8C/jw9w==
Date: Wed, 10 Jan 2024 10:38:57 +0200
From: Tony Lindgren <tony@atomide.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrew Davis <afd@ti.com>, Frank Binns <frank.binns@imgtec.com>,
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
Subject: Re: [PATCH 02/11] dt-bindings: gpu: Add PowerVR Series5 SGX GPUs
Message-ID: <20240110083857.GB5185@atomide.com>
References: <20240109171950.31010-1-afd@ti.com>
 <20240109171950.31010-3-afd@ti.com>
 <e2fce141-4966-4e70-9a5c-865a2737174c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2fce141-4966-4e70-9a5c-865a2737174c@linaro.org>

* Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [240109 19:53]:
> On 09/01/2024 18:19, Andrew Davis wrote:
> > The Imagination PowerVR Series5 "SGX" GPU is part of several SoCs from
> > multiple vendors. Describe how the SGX GPU is integrated in these SoC,
> > including register space and interrupts. Clocks, reset, and power domain
> > information is SoC specific.
> > 
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> 
> > +  clock-names:
> > +    minItems: 1
> > +    items:
> > +      - const: core
> > +      - const: mem
> > +      - const: sys
> 
> There are no devices currently using third clock, but I assume it is
> expected or possible.

I think the third clock is typically merged with one of the two clocks but
yeah possibly it's a separate clocke in some cases.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Looks good to me too.

So for merging these, as many of the changes touch the omap variants, I
could set up an immutable branch with all the changes after -rc1. Or I can
ack the patches too if somebody has better ideas.

Regards,

Tony

