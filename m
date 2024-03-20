Return-Path: <linux-kernel+bounces-109087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D1188147B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F5B1C21665
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285EA524B7;
	Wed, 20 Mar 2024 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXE8Z2BP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E139AF4;
	Wed, 20 Mar 2024 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948278; cv=none; b=gU9ypUv8ua7MKoPTK1TX5PYjOT3GhgsBEiAflQ51wkzlWdPElkmWxmL9417WmgkWve+uQWxawIG6/aWycLBY2DTvwx9UdvlX0Gkh9AvTJp/kRxwzh0kJrdi3NITIk572xSmpJiD1GjPIffjoV5nQJKJG/nEv/e0V/FA2UYpw8Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948278; c=relaxed/simple;
	bh=jMJNWDr4Oq6R+QFdtiIkIxG3CyxghSZhQ7z0m1GBulY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0aJiZ0kWY0/YCF/zl85R4Jnym3hs81LyxbZokYW0bDB7aB1bz/FSCcRA8GeoNiL1b41wMc/LcAnV+A8sATD9AV7Dd+KjlmbWlmx+ExVNAnmKDeZne8V4DG+p/GKwVH19BpXn4W58xqTDnYxkoxpCXvUCp2BiB/9+LhB5MQe+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXE8Z2BP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E8FC433C7;
	Wed, 20 Mar 2024 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710948277;
	bh=jMJNWDr4Oq6R+QFdtiIkIxG3CyxghSZhQ7z0m1GBulY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXE8Z2BPqA+Yj86VvT71M8x8u0h+qlafu3lvZ8qPk0OaScKRSuN3BSnzFhae+G8MA
	 UD9g+n9iaT8tOpjOpmUvcim6bxjnvoFHfPc35+bDgrIpoPjmE9DvdHiGPXVcnjz1Z2
	 yxQQI1lrO2kpyjj2qQ6gFzCydfBXMIdg6guSWj323mFd1QoGKL7N2+fuDh+GDQNy2L
	 e/bKaCPJgV2NaD3mncYHCycRqm2M2XXXRQrgkbvoyztcaHyS5tB/Pn+Xrm5cl77xED
	 L83eu7vZXkaGwMI+jMONI/zZHnodQuV2KXlaNymAK23SxNF0/b6Bw2VYEFUkD01O4u
	 GuH0KBQLuWrBQ==
Date: Wed, 20 Mar 2024 10:24:35 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: fsl-esai: Convert fsl,esai.txt to
 yaml
Message-ID: <20240320152435.GA1753500-robh@kernel.org>
References: <20240318194535.2274543-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318194535.2274543-1-Frank.Li@nxp.com>

On Mon, Mar 18, 2024 at 03:45:34PM -0400, Frank Li wrote:
> Convert fsl,esai.txt to yaml. So DTB_CHECK tools can verify dts file about
> esai part.
> 
> clock-names 'spba' is optional according to description. So minItems of
> clocks and clock-names is 3.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Pass dt_binding check
>      make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
>       DTEX    Documentation/devicetree/bindings/sound/fsl,esai.example.dts
>       LINT    Documentation/devicetree/bindings
>       CHKDT   Documentation/devicetree/bindings/processed-schema.json
>       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>       DTC_CHK Documentation/devicetree/bindings/sound/fsl,esai.example.dtb
> 
>  .../devicetree/bindings/sound/fsl,esai.txt    |  68 -----------
>  .../devicetree/bindings/sound/fsl,esai.yaml   | 110 ++++++++++++++++++
>  2 files changed, 110 insertions(+), 68 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl,esai.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,esai.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> deleted file mode 100644
> index 90112ca1ff423..0000000000000
> --- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -Freescale Enhanced Serial Audio Interface (ESAI) Controller
> -
> -The Enhanced Serial Audio Interface (ESAI) provides a full-duplex serial port
> -for serial communication with a variety of serial devices, including industry
> -standard codecs, Sony/Phillips Digital Interface (S/PDIF) transceivers, and
> -other DSPs. It has up to six transmitters and four receivers.
> -
> -Required properties:
> -
> -  - compatible		: Compatible list, should contain one of the following
> -			  compatibles:
> -			  "fsl,imx35-esai",
> -			  "fsl,vf610-esai",
> -			  "fsl,imx6ull-esai",
> -			  "fsl,imx8qm-esai",
> -
> -  - reg			: Offset and length of the register set for the device.
> -
> -  - interrupts		: Contains the spdif interrupt.
> -
> -  - dmas		: Generic dma devicetree binding as described in
> -			  Documentation/devicetree/bindings/dma/dma.txt.
> -
> -  - dma-names		: Two dmas have to be defined, "tx" and "rx".
> -
> -  - clocks		: Contains an entry for each entry in clock-names.
> -
> -  - clock-names		: Includes the following entries:
> -	"core"		  The core clock used to access registers
> -	"extal"		  The esai baud clock for esai controller used to
> -			  derive HCK, SCK and FS.
> -	"fsys"		  The system clock derived from ahb clock used to
> -			  derive HCK, SCK and FS.
> -	"spba"		  The spba clock is required when ESAI is placed as a
> -			  bus slave of the Shared Peripheral Bus and when two
> -			  or more bus masters (CPU, DMA or DSP) try to access
> -			  it. This property is optional depending on the SoC
> -			  design.
> -
> -  - fsl,fifo-depth	: The number of elements in the transmit and receive
> -			  FIFOs. This number is the maximum allowed value for
> -			  TFCR[TFWM] or RFCR[RFWM].
> -
> -  - fsl,esai-synchronous: This is a boolean property. If present, indicating
> -			  that ESAI would work in the synchronous mode, which
> -			  means all the settings for Receiving would be
> -			  duplicated from Transmission related registers.
> -
> -Optional properties:
> -
> -  - big-endian		: If this property is absent, the native endian mode
> -			  will be in use as default, or the big endian mode
> -			  will be in use for all the device registers.
> -
> -Example:
> -
> -esai: esai@2024000 {
> -	compatible = "fsl,imx35-esai";
> -	reg = <0x02024000 0x4000>;
> -	interrupts = <0 51 0x04>;
> -	clocks = <&clks 208>, <&clks 118>, <&clks 208>;
> -	clock-names = "core", "extal", "fsys";
> -	dmas = <&sdma 23 21 0>, <&sdma 24 21 0>;
> -	dma-names = "rx", "tx";
> -	fsl,fifo-depth = <128>;
> -	fsl,esai-synchronous;
> -	big-endian;
> -};
> diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.yaml b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
> new file mode 100644
> index 0000000000000..9e31283933d1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Enhanced Serial Audio Interface (ESAI) Controller
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description:
> +  The Enhanced Serial Audio Interface (ESAI) provides a full-duplex serial port
> +  for serial communication with a variety of serial devices, including industry
> +  standard codecs, Sony/Phillips Digital Interface (S/PDIF) transceivers, and
> +  other DSPs. It has up to six transmitters and four receivers.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx35-esai
> +      - fsl,vf610-esai

Alphabetical order

> +      - fsl,imx6ull-esai
> +      - fsl,imx8qm-esai
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3
> +    maxItems: 4
> +
> +  clock-names:
> +    minItems: 3
> +    description: |
> +      core:   The core clock used to access registers.
> +      extal:  The esai baud clock for esai controller used to
> +              derive HCK, SCK and FS.
> +      fsys:   The system clock derived from ahb clock used to
> +              derive HCK, SCK and FS.
> +      spba:   The spba clock is required when ESAI is placed as a
> +              bus slave of the Shared Peripheral Bus and when two
> +              or more bus masters (CPU, DMA or DSP) try to access
> +              it. This property is optional depending on the SoC
> +              design.

This description should be split into each items entry below.

> +    items:
> +      - const: core
> +      - const: extal
> +      - const: fsys
> +      - const: spba
> +
> +  dmas:
> +    minItems: 2
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +  fsl,fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The number of elements in the transmit and receive
> +                 FIFOs. This number is the maximum allowed value for
> +                 TFCR[TFWM] or RFCR[RFWM].

Not the normal indentation. Should be just indent 2 more spaces than 
'description'.

> +
> +  fsl,esai-synchronous:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: This is a boolean property. If present, indicating
> +                 that ESAI would work in the synchronous mode, which
> +                 means all the settings for Receiving would be
> +                 duplicated from Transmission related registers.
> +
> +  big-endian:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If this property is absent, the native endian mode
> +                 will be in use as default, or the big endian mode
> +                 will be in use for all the device registers.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-names
> +  - fsl,fifo-depth
> +  - fsl,esai-synchronous
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    esai@2024000 {
> +      compatible = "fsl,imx35-esai";
> +      reg = <0x02024000 0x4000>;
> +      interrupts = <0 51 0x04>;
> +      clocks = <&clks 208>, <&clks 118>, <&clks 208>;
> +      clock-names = "core", "extal", "fsys";
> +      dmas = <&sdma 23 21 0>, <&sdma 24 21 0>;
> +      dma-names = "rx", "tx";
> +      fsl,fifo-depth = <128>;
> +      fsl,esai-synchronous;
> +      big-endian;
> +    };
> -- 
> 2.34.1
> 

