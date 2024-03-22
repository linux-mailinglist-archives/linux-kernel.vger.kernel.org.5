Return-Path: <linux-kernel+bounces-111571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080B886DED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7445E1C21517
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBBE46449;
	Fri, 22 Mar 2024 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPCXHgW1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1BF45BFC;
	Fri, 22 Mar 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115883; cv=none; b=P2IMFvYXsAOWmZVLh1ZfkQL8bNu7mSd/oaUNFUdAp0HTlj2q7jD7b2zs8FBbuAXLZRXw0OwlNgcBKbfUg+4Hk9mC21ufkEZPnV66npiTTX/VrmvmuQPLKuOe1BRRUGQUwAULJeWXhWI+IQHEipbd5CsKSgH7sE5ierXRf4oG208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115883; c=relaxed/simple;
	bh=5nLcUidKgB5r+f5iPuyJSAw+a/z19rQjH3i+N+5NLRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLJvfnIsbMENillpc9boM21MUumsTYXhWUWh5w0NS97B6ADWMggvBxS9jPNL1BkqxxadM2apiV07EEuV41ivDF4eu9VSvfEKxSBjHQYfcjmGxPBhi6IMfE4BxdFrXKZFLgQJwOXxHwaQWSIpbCy9cMCIgMn3dk3GMrCKcNWASAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPCXHgW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2916C433C7;
	Fri, 22 Mar 2024 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711115882;
	bh=5nLcUidKgB5r+f5iPuyJSAw+a/z19rQjH3i+N+5NLRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPCXHgW1IBzKaRUZPDWCykrnbXv43wXL7J6eM7RgiJ7FOAg+unkiSiXgkoNDZCR0s
	 1nWXtMW8Sgwlzry9/Vgn8jvX4HZ+fm3gYLfjXlKF5OA0BiTPZo9ik9Kw07HhYwnTUD
	 czzmn0tBqc3otfzGUCqszU3mFmL5rzRrM+/cAcfipejrtLAtQ7rPsYepJGQawNlwOx
	 s8B2+WkK7N+KpmDz9UYRKrqLP/vAJZLVzOdT2h1q2Vddh67n4V2yPMHvjF8GlpA5AY
	 NDBsBzlgZSX5ShiwasgCNsp9Lasfue6Cn0bs6+XinuqqOUBXMqWIAhqybOzHMdeMYk
	 WnpdAzFDKULyA==
Date: Fri, 22 Mar 2024 08:58:00 -0500
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shengjiu.wang@gmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl-asoc-card: convert to YAML
Message-ID: <20240322135800.GA811908-robh@kernel.org>
References: <1711102406-8399-1-git-send-email-shengjiu.wang@nxp.com>
 <1711102406-8399-2-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711102406-8399-2-git-send-email-shengjiu.wang@nxp.com>

On Fri, Mar 22, 2024 at 06:13:25PM +0800, Shengjiu Wang wrote:
> Convert the fsl-asoc-card binding to YAML.
> 
> In order to pass the checking, add some used compatible
> string from devicetree.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../bindings/sound/fsl-asoc-card.txt          | 117 -----------
>  .../bindings/sound/fsl-asoc-card.yaml         | 196 ++++++++++++++++++
>  2 files changed, 196 insertions(+), 117 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> deleted file mode 100644
> index 4e8dbc5abfd1..000000000000
> --- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> +++ /dev/null
> @@ -1,117 +0,0 @@
> -Freescale Generic ASoC Sound Card with ASRC support
> -
> -The Freescale Generic ASoC Sound Card can be used, ideally, for all Freescale
> -SoCs connecting with external CODECs.
> -
> -The idea of this generic sound card is a bit like ASoC Simple Card. However,
> -for Freescale SoCs (especially those released in recent years), most of them
> -have ASRC (Documentation/devicetree/bindings/sound/fsl,asrc.txt) inside. And
> -this is a specific feature that might be painstakingly controlled and merged
> -into the Simple Card.
> -
> -So having this generic sound card allows all Freescale SoC users to benefit
> -from the simplification of a new card support and the capability of the wide
> -sample rates support through ASRC.
> -
> -Note: The card is initially designed for those sound cards who use AC'97, I2S
> -      and PCM DAI formats. However, it'll be also possible to support those non
> -      AC'97/I2S/PCM type sound cards, such as S/PDIF audio and HDMI audio, as
> -      long as the driver has been properly upgraded.
> -
> -
> -The compatible list for this generic sound card currently:
> - "fsl,imx-audio-ac97"
> -
> - "fsl,imx-audio-cs42888"
> -
> - "fsl,imx-audio-cs427x"
> - (compatible with CS4271 and CS4272)
> -
> - "fsl,imx-audio-wm8962"
> -
> - "fsl,imx-audio-sgtl5000"
> - (compatible with Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt)
> -
> - "fsl,imx-audio-wm8960"
> -
> - "fsl,imx-audio-mqs"
> -
> - "fsl,imx-audio-wm8524"
> -
> - "fsl,imx-audio-tlv320aic32x4"
> -
> - "fsl,imx-audio-tlv320aic31xx"
> -
> - "fsl,imx-audio-si476x"
> -
> - "fsl,imx-audio-wm8958"
> -
> - "fsl,imx-audio-nau8822"
> -
> -Required properties:
> -
> -  - compatible		: Contains one of entries in the compatible list.
> -
> -  - model		: The user-visible name of this sound complex
> -
> -  - audio-cpu		: The phandle of an CPU DAI controller
> -
> -  - audio-codec		: The phandle of an audio codec
> -
> -Optional properties:
> -
> -  - audio-asrc		: The phandle of ASRC. It can be absent if there's no
> -			  need to add ASRC support via DPCM.
> -
> -  - audio-routing	: A list of the connections between audio components.
> -			  Each entry is a pair of strings, the first being the
> -			  connection's sink, the second being the connection's
> -			  source. There're a few pre-designed board connectors:
> -			   * Line Out Jack
> -			   * Line In Jack
> -			   * Headphone Jack
> -			   * Mic Jack
> -			   * Ext Spk
> -			   * AMIC (stands for Analog Microphone Jack)
> -			   * DMIC (stands for Digital Microphone Jack)
> -
> -			  Note: The "Mic Jack" and "AMIC" are redundant while
> -			        coexisting in order to support the old bindings
> -				of wm8962 and sgtl5000.
> -
> -  - hp-det-gpio		: The GPIO that detect headphones are plugged in
> -  - mic-det-gpio	: The GPIO that detect microphones are plugged in
> -  - bitclock-master	: Indicates dai-link bit clock master; for details see simple-card.yaml.
> -  - frame-master	: Indicates dai-link frame master; for details see simple-card.yaml.
> -  - dai-format		: audio format, for details see simple-card.yaml.
> -  - frame-inversion	: dai-link uses frame clock inversion, for details see simple-card.yaml.
> -  - bitclock-inversion	: dai-link uses bit clock inversion, for details see simple-card.yaml.
> -  - mclk-id		: main clock id, specific for each card configuration.
> -
> -Optional unless SSI is selected as a CPU DAI:
> -
> -  - mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX)
> -
> -  - mux-ext-port	: The external port of the i.MX audio muxer
> -
> -Example:
> -sound-cs42888 {
> -	compatible = "fsl,imx-audio-cs42888";
> -	model = "cs42888-audio";
> -	audio-cpu = <&esai>;
> -	audio-asrc = <&asrc>;
> -	audio-codec = <&cs42888>;
> -	audio-routing =
> -		"Line Out Jack", "AOUT1L",
> -		"Line Out Jack", "AOUT1R",
> -		"Line Out Jack", "AOUT2L",
> -		"Line Out Jack", "AOUT2R",
> -		"Line Out Jack", "AOUT3L",
> -		"Line Out Jack", "AOUT3R",
> -		"Line Out Jack", "AOUT4L",
> -		"Line Out Jack", "AOUT4R",
> -		"AIN1L", "Line In Jack",
> -		"AIN1R", "Line In Jack",
> -		"AIN2L", "Line In Jack",
> -		"AIN2R", "Line In Jack";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml b/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
> new file mode 100644
> index 000000000000..48051655230d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.yaml
> @@ -0,0 +1,196 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl-asoc-card.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Generic ASoC Sound Card with ASRC support
> +
> +description:
> +  The Freescale Generic ASoC Sound Card can be used, ideally,
> +  for all Freescale SoCs connecting with external CODECs.
> +
> +  The idea of this generic sound card is a bit like ASoC Simple Card.
> +  However, for Freescale SoCs (especially those released in recent years),
> +  most of them have ASRC
> +  (Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml) inside. And
> +  this is a specific feature that might be painstakingly controlled and
> +  merged into the Simple Card.
> +
> +  So having this generic sound card allows all Freescale SoC users to
> +  benefit from the simplification of a new card support and the capability
> +  of the wide sample rates support through ASRC.
> +
> +  Note, The card is initially designed for those sound cards who use AC'97, I2S
> +  and PCM DAI formats. However, it'll be also possible to support those non
> +  AC'97/I2S/PCM type sound cards, such as S/PDIF audio and HDMI audio, as
> +  long as the driver has been properly upgraded.
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx-sgtl5000
> +              - fsl,imx53-cpuvo-sgtl5000
> +              - fsl,imx51-babbage-sgtl5000
> +              - fsl,imx53-m53evk-sgtl5000
> +              - fsl,imx53-qsb-sgtl5000
> +              - fsl,imx53-voipac-sgtl5000
> +              - fsl,imx6-armadeus-sgtl5000
> +              - fsl,imx6-rex-sgtl5000
> +              - fsl,imx6-sabreauto-cs42888
> +              - fsl,imx6-wandboard-sgtl5000
> +              - fsl,imx6dl-nit6xlite-sgtl5000
> +              - fsl,imx6q-ba16-sgtl5000
> +              - fsl,imx6q-nitrogen6_max-sgtl5000
> +              - fsl,imx6q-nitrogen6_som2-sgtl5000
> +              - fsl,imx6q-nitrogen6x-sgtl5000
> +              - fsl,imx6q-sabrelite-sgtl5000
> +              - fsl,imx6q-sabresd-wm8962
> +              - fsl,imx6q-udoo-ac97
> +              - fsl,imx6q-ventana-sgtl5000
> +              - fsl,imx6sl-evk-wm8962
> +              - fsl,imx6sx-sdb-mqs
> +              - fsl,imx6sx-sdb-wm8962
> +              - fsl,imx7d-evk-wm8960
> +              - karo,tx53-audio-sgtl5000
> +              - tq,imx53-mba53-sgtl5000

None of these were documented before. It's fine to add all these in this 
patch, but please state in the commit message what missing or incorrect 
things you added in the schema.

> +          - enum:
> +              - fsl,imx-audio-ac97
> +              - fsl,imx-audio-cs42888
> +              - fsl,imx-audio-mqs
> +              - fsl,imx-audio-sgtl5000
> +              - fsl,imx-audio-wm8960
> +              - fsl,imx-audio-wm8962
> +      - items:
> +          - enum:
> +              - fsl,imx-audio-ac97
> +              - fsl,imx-audio-cs42888
> +              - fsl,imx-audio-cs427x
> +              - fsl,imx-audio-mqs
> +              - fsl,imx-audio-nau8822
> +              - fsl,imx-audio-sgtl5000
> +              - fsl,imx-audio-si476x
> +              - fsl,imx-audio-tlv320aic31xx
> +              - fsl,imx-audio-tlv320aic32x4
> +              - fsl,imx-audio-wm8524
> +              - fsl,imx-audio-wm8960
> +              - fsl,imx-audio-wm8962
> +              - fsl,imx-audio-wm8958
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: The user-visible name of this sound complex
> +
> +  audio-asrc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      The phandle of ASRC. It can be absent if there's no
> +      need to add ASRC support via DPCM.
> +
> +  audio-codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of an audio codec
> +
> +  audio-cpu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of an CPU DAI controller
> +
> +  audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      A list of the connections between audio components. Each entry is a
> +      pair of strings, the first being the connection's sink, the second
> +      being the connection's source. There're a few pre-designed board
> +      connectors.
> +        * Line Out Jack
> +        * Line In Jack
> +        * Headphone Jack
> +        * Mic Jack
> +        * Ext Spk
> +        * AMIC (stands for Analog Microphone Jack)
> +        * DMIC (stands for Digital Microphone Jack)
> +      Note, The "Mic Jack" and "AMIC" are redundant while coexisting in
> +      order to support the old bindings of wm8962 and sgtl5000.

Please list the strings out as schema:

minItems: 2
items:
  enum:
    - "Line Out Jack"
    ...

> +
> +  hp-det-gpio:
> +    maxItems: 1
> +    description: The GPIO that detect headphones are plugged in

       deprecated: true

> +
> +  hp-det-gpios:
> +    maxItems: 1
> +    description: The GPIO that detect headphones are plugged in
> +
> +  mic-det-gpio:
> +    maxItems: 1
> +    description: The GPIO that detect microphones are plugged in

       deprecated: true

> +
> +  mic-det-gpios:
> +    maxItems: 1
> +    description: The GPIO that detect microphones are plugged in
> +
> +  bitclock-master:
> +    description: Indicates dai-link bit clock master; for details see simple-card.yaml.

Drop the prose reference and add:

       $ref: simple-card.yaml#/definitions/bitclock-master

Otherwise, bitclock-master could be anything. 

And similar for the rest.

> +
> +  frame-master:
> +    description: Indicates dai-link frame master; for details see simple-card.yaml.
> +
> +  dai-format:
> +    description: audio format, for details see simple-card.yaml.
> +
> +  frame-inversion:
> +    description: dai-link uses frame clock inversion, for details see simple-card.yaml.
> +
> +  bitclock-inversion:
> +    description: dai-link uses bit clock inversion, for details see simple-card.yaml.
> +
> +  mclk-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: main clock id, specific for each card configuration.
> +
> +  mux-int-port:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 7]
> +    description: The internal port of the i.MX audio muxer (AUDMUX)
> +
> +  mux-ext-port:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [3, 4, 5, 6]
> +    description: The external port of the i.MX audio muxer
> +
> +  ssi-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of an CPU DAI controller
> +
> +required:
> +  - compatible
> +  - model
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sound-cs42888 {
> +        compatible = "fsl,imx-audio-cs42888";
> +        model = "cs42888-audio";
> +        audio-cpu = <&esai>;
> +        audio-asrc = <&asrc>;
> +        audio-codec = <&cs42888>;
> +        audio-routing =
> +             "Line Out Jack", "AOUT1L",
> +             "Line Out Jack", "AOUT1R",
> +             "Line Out Jack", "AOUT2L",
> +             "Line Out Jack", "AOUT2R",
> +             "Line Out Jack", "AOUT3L",
> +             "Line Out Jack", "AOUT3R",
> +             "Line Out Jack", "AOUT4L",
> +             "Line Out Jack", "AOUT4R",
> +             "AIN1L", "Line In Jack",
> +             "AIN1R", "Line In Jack",
> +             "AIN2L", "Line In Jack",
> +             "AIN2R", "Line In Jack";
> +    };
> -- 
> 2.34.1
> 

