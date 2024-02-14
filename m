Return-Path: <linux-kernel+bounces-65301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425A3854AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFF9285B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDFE54BEF;
	Wed, 14 Feb 2024 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpH00fCG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C354BC7;
	Wed, 14 Feb 2024 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919107; cv=none; b=jmeVoNxjfCZLYXl2AsmRi04KyZNPFc8T67QPc5H1TzPTzbYrx1ejgWxkFJoTP3GBJtVwZqayngkhfe6Xos1ks+qrPfxycNSJecp48kSJDqvEMczKoDZrvxViYukMNqEq2pNNqSEACAozv9sgbsiSEkVRRJEZV55hwnBlgkNFQVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919107; c=relaxed/simple;
	bh=D4otYk0l4L8666y0XkXrWB2HS/+cq+srK0Sn0rtCIgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQaW1NHpJ08xR7qk7ykMDWprq/MBrenU5Qc0tPxSWnFsu7nT1jrlyym56w87PcE6kX1j/jEd5Oy/ZzuHWWsTO5ti4C5lNkA3XimI+9UamO3GRT7H+CzhZF44YGSo0+YauP9KLX7nw1d/JBKtNhrCeLCw1WTs+Q5rC6ygv7tdRlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpH00fCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4735BC433F1;
	Wed, 14 Feb 2024 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707919106;
	bh=D4otYk0l4L8666y0XkXrWB2HS/+cq+srK0Sn0rtCIgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PpH00fCGZkawUyAQTGR2TJxby/VMmedAoH91WkBzTCBJPBA9L9ngKEcwTbQB1WeOn
	 Vm+B+wi8IE+rNXNnlBUb+MngbMOaFL/yhsgGY/K6mWYtahg/XAh2jAgUrOx3356qgS
	 yPXSEGPFbdums4li05nbf2yeQjT4rY+RxFT+DKgqTpEWBWeMZmumjkjcB2HG4ahyQ6
	 7Ih/Dz/EfauKYuTUaObB3U+1wMhWe0zyYG4+oU/cGCE9deNCUP3i9ds7ici6u/zOHJ
	 XaGeyZGm71QkHVZiawpTCIC/qNECvfNzq9m2fpUjKqXGeuiEqBq++0UBf9wfrp8WZH
	 jv9s8oPPfPk7Q==
Date: Wed, 14 Feb 2024 07:58:24 -0600
From: Rob Herring <robh@kernel.org>
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: sound:atmel-at91sam9g20ek: convert bindings
 to json-schema
Message-ID: <20240214135824.GA692740-robh@kernel.org>
References: <20240214-at91sam9g20ek-wm8731-yaml-v1-1-33333e17383b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-at91sam9g20ek-wm8731-yaml-v1-1-33333e17383b@microchip.com>

On Wed, Feb 14, 2024 at 12:10:06PM +0530, Balakrishnan Sambath wrote:
> Convert atmel-at91sam9g20ek-wm8731-audio DT binding to yaml
> based json-schema.Change file name to match json-scheme naming.
> 
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
>  .../bindings/sound/atmel,at91sam9g20ek-wm8731.yaml | 60 ++++++++++++++++++++++
>  .../sound/atmel-at91sam9g20ek-wm8731-audio.txt     | 26 ----------
>  2 files changed, 60 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml b/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml
> new file mode 100644
> index 000000000000..f6330707fe1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/atmel,at91sam9g20ek-wm8731.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel at91sam9g20ek wm8731 audio complex
> +
> +maintainers:
> +  - Balakrishnan Sambath <balakrishnan.s@microchip.com>
> +
> +properties:
> +  compatible:
> +    const: atmel,at91sam9g20ek-wm8731-audio
> +
> +  atmel,model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: The user-visible name of this sound complex.

blank line between DT properties

> +  atmel,audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description: A list of the connections between audio components.
> +    minItems: 2

No max?

> +    items:
> +      enum:
> +        # Board Connectors
> +        - "Ext Spk"
> +        - "Int MIC"
> +
> +        # CODEC Pins
> +        - LHPOUT
> +        - MICIN
> +  atmel,ssc-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of the SSC controller
> +  atmel,audio-codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of WM8731 audio codec
> +
> +required:
> +  - compatible
> +  - atmel,model
> +  - atmel,audio-routing
> +  - atmel,ssc-controller
> +  - atmel,audio-codec
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sound {
> +        compatible = "atmel,at91sam9g20ek-wm8731-audio";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_pck0_as_mck>;
> +        atmel,model = "wm8731 @ AT91SAMG20EK";
> +        atmel,audio-routing =
> +            "Ext Spk", "LHPOUT",
> +            "Int MIC", "MICIN";
> +        atmel,ssc-controller = <&ssc0>;
> +        atmel,audio-codec = <&wm8731>;
> +    };

