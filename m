Return-Path: <linux-kernel+bounces-26190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B582DC93
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FD1B21715
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3579517758;
	Mon, 15 Jan 2024 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skFXbUDC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8003017980;
	Mon, 15 Jan 2024 15:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87F6C433C7;
	Mon, 15 Jan 2024 15:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705333621;
	bh=CKlMsBgiRFguC4EeGf8G4YmTN9XESV+58mgkD1W4SPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skFXbUDCV/2M/7goc7hXpkMmxJNhc6isLScK4FQwrlU9+0IKA2Ue7/tEKI/9xiUcl
	 QMuMMNeQlAtjNBoBcuqibBIwMirN0OAwrDE89FoCcS/zC8USBomywfB6cY22ZYX/cB
	 WfElSbPDp0DqEDhYvF9DjIc/m0jAXJeVo26uom6+1s9eMYAizNjiZ6j6BPOUaCMPps
	 A7iUNWfw7taRvEDEbpmWkgyHies6OKZfU9QqJgvDrvRT3onnSi/8H//NLXGRPYyIKg
	 ydN83g3LT/GqiV7q21OZUw3K82CE2bJ1mAyVVq/xskSlX+TRtrH7GOYq5x/mPoz7da
	 tx48yxQpVT/XA==
Date: Mon, 15 Jan 2024 09:46:59 -0600
From: Rob Herring <robh@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: display: add dt-bindings for STM32
 LVDS device
Message-ID: <20240115154659.GA815331-robh@kernel.org>
References: <20240115132009.101718-1-raphael.gallais-pou@foss.st.com>
 <20240115132009.101718-2-raphael.gallais-pou@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115132009.101718-2-raphael.gallais-pou@foss.st.com>

On Mon, Jan 15, 2024 at 02:20:04PM +0100, Raphael Gallais-Pou wrote:
> Add "st,stm32mp25-lvds" compatible.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
> Depends on: "dt-bindings: stm32: add clocks and reset binding for
> 	    stm32mp25 platform" by Gabriel Fernandez
> 
> Changes in v3:
> 	- Clarify commit dependency
> 	- Fix includes in the example
> 	- Fix YAML
> 	- Add "clock-cells" description
> 	- s/regroups/is composed of/
> 	- Changed compatible to show SoC specificity
> 
> Changes in v2:
> 	- Switch compatible and clock-cells related areas
> 	- Remove faulty #include in the example.
> 	- Add entry in MAINTAINERS
> ---
>  .../bindings/display/st,stm32-lvds.yaml       | 119 ++++++++++++++++++

Filename matching compatible.

> +properties:
> +  compatible:
> +    const: st,stm32mp25-lvds


> +examples:
> +  - |
> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
> +
> +    lvds: lvds@48060000 {
> +        compatible = "st,stm32-lvds";

Wrong compatible.

