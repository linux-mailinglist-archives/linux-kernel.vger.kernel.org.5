Return-Path: <linux-kernel+bounces-31437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBC4832E59
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D52AB237DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59AA21;
	Fri, 19 Jan 2024 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8l2whsR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE4B55E4A;
	Fri, 19 Jan 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686498; cv=none; b=nwQenYjfTuISUbYufS2NhW5m2X/bf4wkGl1iUbV9CD2M0678MjszLtVLuc7As4918OJJLuXzVqKCC5EcrcbRe2at9k8HvDhcpFLg07zTZ5Lh5chgsxPUBNG+S+Zk2ubGTmPuGUIO5pcjVlTY9ARQ1PuXoa+XM6hhZBrj+a5Paj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686498; c=relaxed/simple;
	bh=P0KUF6vFTlftYyWUFDT96WHN8XRiIFXd1b2/AovY2hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8WapgewyzxhgcLamfu0BJqFHlH8Y/PQZy0bGtfGVLsZUSCcKV2L7zRHW47/ngXA7zJIxUHS7izINbcGOXccVZBQlXtJnIQ9hnoTOYrT1Qz8l82v9lxZHRmckfPVSA0xPZUZtONXjJEma0WA1xBWlBO0R3yV9/shct2goMvhzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8l2whsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B518C433F1;
	Fri, 19 Jan 2024 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705686497;
	bh=P0KUF6vFTlftYyWUFDT96WHN8XRiIFXd1b2/AovY2hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8l2whsRDimVA5MSS/fooSc43HMZGOw3e+psIFF/j1oxW2EmsXHFG1D4YvSgvIuH6
	 iG1Zb2PwoSl6ZCX8Yrh+isB4kZCErgwIM9kDmhEmcfr9eAKlm6saKW9g6DDl7GpV4i
	 ZSOGZi2k3LxyfhVWg1LZ8nrNbjSqYxzEg9DkRArtIfeqXDUUIUxgZSiGMUFYpvSUyt
	 N4KAM+OLfp8736eK6ZLkE540xGh+g5jLNVZRPLQ45c7pXkZ6rO3c8ldkssh2898lih
	 lMcILIdXvdVRY/4/QMFv6Ci7SgV+SpbvUku4VYZWpuX0TaZa2zaWXia+eRyjbV0bVr
	 8Zo+PZg/w6ueg==
Date: Fri, 19 Jan 2024 11:48:15 -0600
From: Rob Herring <robh@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andrew Davis <afd@ti.com>, Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Adam Ford <aford173@gmail.com>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	=?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH 02/11] dt-bindings: gpu: Add PowerVR Series5 SGX GPUs
Message-ID: <20240119174815.GA633343-robh@kernel.org>
References: <20240109171950.31010-1-afd@ti.com>
 <20240109171950.31010-3-afd@ti.com>
 <e2fce141-4966-4e70-9a5c-865a2737174c@linaro.org>
 <20240110083857.GB5185@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110083857.GB5185@atomide.com>

On Wed, Jan 10, 2024 at 10:38:57AM +0200, Tony Lindgren wrote:
> * Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> [240109 19:53]:
> > On 09/01/2024 18:19, Andrew Davis wrote:
> > > The Imagination PowerVR Series5 "SGX" GPU is part of several SoCs from
> > > multiple vendors. Describe how the SGX GPU is integrated in these SoC,
> > > including register space and interrupts. Clocks, reset, and power domain
> > > information is SoC specific.
> > > 
> > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> > 
> > 
> > > +  clock-names:
> > > +    minItems: 1
> > > +    items:
> > > +      - const: core
> > > +      - const: mem
> > > +      - const: sys
> > 
> > There are no devices currently using third clock, but I assume it is
> > expected or possible.
> 
> I think the third clock is typically merged with one of the two clocks but
> yeah possibly it's a separate clocke in some cases.
> 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Looks good to me too.
> 
> So for merging these, as many of the changes touch the omap variants, I
> could set up an immutable branch with all the changes after -rc1. Or I can
> ack the patches too if somebody has better ideas.

Just take all but patches 10 and 11. I don't think it matters if the 
binding is there for them as long as it is all there in next. No one is 
paying that close attention to the warnings I think.

Rob

