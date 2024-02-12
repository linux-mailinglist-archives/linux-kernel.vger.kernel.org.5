Return-Path: <linux-kernel+bounces-61720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFF48515AB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF391C22C95
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB53A29F;
	Mon, 12 Feb 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf4dyCaa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BBE3A1C4;
	Mon, 12 Feb 2024 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745282; cv=none; b=YDBL31RZoK/iP53LZ2HmS9SdfEOzB9npYtJsyZeAIg6acY7/MiaZi7F8kVA8INCDa2RGF4ogbX5YXVr9CplfazUNIFHiuxL0rTLbmnHjH/Hmscch68HfTHFo9uecPnTQeW3gGSSpOuND6/MpMCRnqzM9qpl/FNv75igjy/Of/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745282; c=relaxed/simple;
	bh=m8kRKJlzaxyXLxtRatEt7YpuzCQxnntT+vzxtpamjKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkL+CyAXNaEm6fslV2gLOA0/GfJb2O5BX0KVglbdI72S2FCEIdx1SlxOMPioABshNpwlDrI4dUzWJ33bjGYx5T20wGtWatE7gclDp14WjBhFj9pWz+ZFvg8+Moy8CxSha912yjD+Km25O3V49/RMt6Z8PuJ7/ucWaX53kmXpfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf4dyCaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B8AC433F1;
	Mon, 12 Feb 2024 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707745281;
	bh=m8kRKJlzaxyXLxtRatEt7YpuzCQxnntT+vzxtpamjKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nf4dyCaa/SI9jTKUbILyhiMLOsWVoFQ5PSIU0feqVN76Yz9duMVcYtC94IfOrqDhB
	 h3Pr4VqlK4agUmnDCWZwtrEj1VHBG+jox+OQId6T8IxBz1MJ3Ka0l/ng56jPUiyvYf
	 0L+x/Boq6VgCJO2vwnYkMopRSoFg/7wky36sZyjkHmK1l1OW7sS+ZJA6S9ZVoCP1eq
	 xfiiJFzfoTwOqbkDisCzKZSDQJ1Yhm7z0fCyXuPGkK9EU0N0gxlG12QmpVsCnpTNOp
	 E3pHtyTB52KXUUz8KhSNdpX3cr6Jnk+SbTjbxD+ZmHO2uCt6/IiUUHInU8Ptv3AD+n
	 vw2nsreLUjv1Q==
Date: Mon, 12 Feb 2024 07:41:19 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/14] dt-bindings: sound: fsl,imx-asrc: convert to
 YAML
Message-ID: <20240212134119.GA37175-robh@kernel.org>
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-4-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210012114.489102-4-sre@kernel.org>

On Sat, Feb 10, 2024 at 02:18:07AM +0100, Sebastian Reichel wrote:
> Convert the i.MX ASRC DT binding to YAML.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../devicetree/bindings/sound/fsl,asrc.txt    |  80 ---------
>  .../bindings/sound/fsl,imx-asrc.yaml          | 159 ++++++++++++++++++
>  2 files changed, 159 insertions(+), 80 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl,asrc.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml


> diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> new file mode 100644
> index 000000000000..bc1607ecf345
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> @@ -0,0 +1,159 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,imx-asrc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Asynchronous Sample Rate Converter (ASRC) Controller
> +
> +description:
> +  The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of
> +  a signal associated with an input clock into a signal associated with a
> +  different output clock. The driver currently works as a Front End of DPCM
> +  with other Back Ends Audio controller such as ESAI, SSI and SAI. It has
> +  three pairs to support three substreams within totally 10 channels.
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +  - Sascha Hauer <s.hauer@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - fsl,imx35-asrc
> +          - fsl,imx53-asrc
> +          - fsl,imx8qm-asrc
> +          - fsl,imx8qxp-asrc
> +      - items:
> +          - enum:
> +              - fsl,imx6sx-asrc
> +              - fsl,imx6ul-asrc
> +          - const: fsl,imx53-asrc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 6
> +
> +  dma-names:
> +    items:
> +      - const: rxa
> +      - const: rxb
> +      - const: rxc
> +      - const: txa
> +      - const: txb
> +      - const: txc
> +
> +  clocks:
> +    maxItems: 19
> +
> +  clock-names:
> +    items:
> +      - const: mem
> +      - const: ipg
> +      - const: asrck_0
> +      - const: asrck_1
> +      - const: asrck_2
> +      - const: asrck_3
> +      - const: asrck_4
> +      - const: asrck_5
> +      - const: asrck_6
> +      - const: asrck_7
> +      - const: asrck_8
> +      - const: asrck_9
> +      - const: asrck_a
> +      - const: asrck_b
> +      - const: asrck_c
> +      - const: asrck_d
> +      - const: asrck_e
> +      - const: asrck_f
> +      - const: spba
> +
> +  fsl,asrc-rate:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The mutual sample rate used by DPCM Back Ends
> +
> +  fsl,asrc-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The mutual sample width used by DPCM Back Ends

Constraints?

> +
> +  fsl,asrc-clk-map:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Defines clock map used in driver
> +      <0> - select the map for asrc0 in imx8qm/imx8qxp
> +      <1> - select the map for asrc1 in imx8qm/imx8qxp

Looks like constraints.

> +
> +  big-endian:
> +    type: boolean
> +    description:
> +      If this property is absent, the little endian mode will be in use as
> +      default. Otherwise, the big endian mode will be in use for all the
> +      device registers.
> +
> +  fsl,asrc-format:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Defines a mutual sample format used by DPCM Back Ends, which can
> +      replace the fsl,asrc-width. The value is 2 (S16_LE), or 6 (S24_LE).

Looks like constraints.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - dmas
> +  - dma-names
> +  - clocks
> +  - clock-names
> +  - fsl,asrc-rate
> +  - fsl,asrc-width
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qm-asrc
> +              - fsl,imx8qxp-asrc
> +    then:
> +      required:
> +        - fsl,asrc-clk-map
> +    else:
> +      properties:
> +        fsl,asrc-clk-map: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/imx6qdl-clock.h>
> +    asrc: asrc@2034000 {
> +        compatible = "fsl,imx53-asrc";
> +        reg = <0x02034000 0x4000>;
> +        interrupts = <0 50 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clks IMX6QDL_CLK_ASRC_IPG>,
> +                 <&clks IMX6QDL_CLK_ASRC_MEM>, <&clks 0>,
> +                 <&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
> +                 <&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
> +                 <&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
> +                 <&clks IMX6QDL_CLK_ASRC>, <&clks 0>, <&clks 0>,
> +                 <&clks IMX6QDL_CLK_SPBA>;
> +        clock-names = "mem", "ipg", "asrck_0",
> +                "asrck_1", "asrck_2", "asrck_3", "asrck_4",
> +                "asrck_5", "asrck_6", "asrck_7", "asrck_8",
> +                "asrck_9", "asrck_a", "asrck_b", "asrck_c",
> +                "asrck_d", "asrck_e", "asrck_f", "spba";
> +        dmas = <&sdma 17 23 1>, <&sdma 18 23 1>, <&sdma 19 23 1>,
> +               <&sdma 20 23 1>, <&sdma 21 23 1>, <&sdma 22 23 1>;
> +        dma-names = "rxa", "rxb", "rxc",
> +                    "txa", "txb", "txc";
> +        fsl,asrc-rate  = <48000>;
> +        fsl,asrc-width = <16>;
> +    };
> -- 
> 2.43.0
> 

