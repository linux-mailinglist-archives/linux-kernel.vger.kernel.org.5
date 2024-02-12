Return-Path: <linux-kernel+bounces-61803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D588A8516BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874FF2817D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F923C087;
	Mon, 12 Feb 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h41mHQNm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96338F94;
	Mon, 12 Feb 2024 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746907; cv=none; b=W+sYRcVO8r/eRJJoqswMRcpvNz4QzttoV5ZRkvewyD1A115gcYjThMqk5u4ztZB+dA9ZLbry9yBJcKWWBuAtCklIwSiy6Uv0OBftgACuqMToFxjzYHL17lkviCxx5lFY98LWFbnoUAIqntdTAR4KmRHcCuQwvioJeSMsX8Gtbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746907; c=relaxed/simple;
	bh=fuoMnWAu+ZMm9NlS+AyhNaczEZnsOEG3YfISVRX2pV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0ghoC/89IdYFhUdQ34n63+VURyHJrlqMKSmZhxkbCWqEx84H6KxNoShRPKscyLil2FiPO3Z8EiZXYOWmjayav90BDmn7dAwM2eEwET8p+nOXbtsWFeCNIOMV6AeJAU/sMomYe9LexGTp1wDShOzyOWSYGLV8AJQ8iZCBPIakcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h41mHQNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946FAC433C7;
	Mon, 12 Feb 2024 14:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707746906;
	bh=fuoMnWAu+ZMm9NlS+AyhNaczEZnsOEG3YfISVRX2pV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h41mHQNmzWUYUBySyMLKKbuVv7mTvOJI9tJE3SeEqe1fWhZLmyVY6doYAM/IdocWf
	 NJTTUjNoJeYRn+voj3CqUpDrs6mbydwkd1AVUIrBXYFC91Qz+xRJiF9Bbfphb3npKf
	 1kYAwp6Al5ODjc34V+59aWdEickjM+HkQsgMbAeeIGXv1st3QGWijUgeGsm2DzVvRn
	 d5HtNfHC+MA20zGGG/VVX3n+3uGoSZzkrRjDFvVRnskdMjzl1+l5l8jSozOL2uIrGq
	 tjHlPxmV87uMTsLhLlgp3kZRTm+jvc4CgTLczSTWaNjOaHgh+J1EEHrKm1pJhLXNaR
	 SxnjSA4+9D7yQ==
Date: Mon, 12 Feb 2024 08:08:24 -0600
From: Rob Herring <robh@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: tglx@linutronix.de, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema
Message-ID: <20240212140824.GA107736-robh@kernel.org>
References: <20240209100122.61335-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209100122.61335-1-dharma.b@microchip.com>

On Fri, Feb 09, 2024 at 03:31:22PM +0530, Dharma Balasubiramani wrote:
> Convert the Atmel AIC binding document to DT schema format using
> json-schema.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> Changelog
> v1 -> v2
> - Drop the '|' as there is no formatting to preserve.
> - Remove unnecessary marketing statement from description.
> - Drop the description for interrupts and reg, it's obvious.
> - Put reg after compatible.
> - Drop comment in example.
> - Drop the example of device that is wired to an AIC as it's(dma) binding is
>   not yet available.
> ---
>  .../interrupt-controller/atmel,aic.txt        | 43 -----------
>  .../interrupt-controller/atmel,aic.yaml       | 74 +++++++++++++++++++
>  2 files changed, 74 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
> deleted file mode 100644
> index 7079d44bf3ba..000000000000
> --- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -* Advanced Interrupt Controller (AIC)
> -
> -Required properties:
> -- compatible: Should be:
> -    - "atmel,<chip>-aic" where  <chip> can be "at91rm9200", "sama5d2",
> -      "sama5d3" or "sama5d4"
> -    - "microchip,<chip>-aic" where <chip> can be "sam9x60"
> -
> -- interrupt-controller: Identifies the node as an interrupt controller.
> -- #interrupt-cells: The number of cells to define the interrupts. It should be 3.
> -  The first cell is the IRQ number (aka "Peripheral IDentifier" on datasheet).
> -  The second cell is used to specify flags:
> -    bits[3:0] trigger type and level flags:
> -      1 = low-to-high edge triggered.
> -      2 = high-to-low edge triggered.
> -      4 = active high level-sensitive.
> -      8 = active low level-sensitive.
> -      Valid combinations are 1, 2, 3, 4, 8.
> -      Default flag for internal sources should be set to 4 (active high).
> -  The third cell is used to specify the irq priority from 0 (lowest) to 7
> -  (highest).
> -- reg: Should contain AIC registers location and length
> -- atmel,external-irqs: u32 array of external irqs.
> -
> -Examples:
> -	/*
> -	 * AIC
> -	 */
> -	aic: interrupt-controller@fffff000 {
> -		compatible = "atmel,at91rm9200-aic";
> -		interrupt-controller;
> -		#interrupt-cells = <3>;
> -		reg = <0xfffff000 0x200>;
> -	};
> -
> -	/*
> -	 * An interrupt generating device that is wired to an AIC.
> -	 */
> -	dma: dma-controller@ffffec00 {
> -		compatible = "atmel,at91sam9g45-dma";
> -		reg = <0xffffec00 0x200>;
> -		interrupts = <21 4 5>;
> -	};
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
> new file mode 100644
> index 000000000000..df81115a8b7f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/atmel,aic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Advanced Interrupt Controller (AIC)
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Dharma balasubiramani <dharma.b@microchip.com>
> +
> +description:
> +  The Advanced Interrupt Controller (AIC) is an 8-level priority, individually
> +  maskable, vectored interrupt controller providing handling of up to one
> +  hundred and twenty-eight interrupt sources.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91rm9200-aic
> +      - atmel,sama5d2-aic
> +      - atmel,sama5d3-aic
> +      - atmel,sama5d4-aic
> +      - microchip,sam9x60-aic
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 3
> +    description: |
> +      The 1st cell is the IRQ number (Peripheral IDentifier on datasheet).
> +      The 2nd cell specifies flags:
> +        bits[3:0] trigger type and level flags:
> +          1 = low-to-high edge triggered.
> +          2 = high-to-low edge triggered.
> +          4 = active high level-sensitive.
> +          8 = active low level-sensitive.
> +        Valid combinations: 1, 2, 3, 4, 8.
> +        Default for internal sources: 4 (active high).
> +      The 3rd cell specifies irq priority from 0 (lowest) to 7 (highest).
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  atmel,external-irqs:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: u32 array of external irqs.

Constraints on the array size and/or entry values?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - atmel,external-irqs
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    interrupt-controller@fffff000 {
> +      compatible = "atmel,at91rm9200-aic";
> +      interrupt-controller;
> +      #interrupt-cells = <3>;
> +      reg = <0xfffff000 0x200>;
> +      atmel,external-irqs = <31>;
> +    };
> +...
> 
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> -- 
> 2.25.1
> 

