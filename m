Return-Path: <linux-kernel+bounces-126786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCBD893CB2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C55E7B21EC3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D0846426;
	Mon,  1 Apr 2024 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOYUl9Cp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7224596D;
	Mon,  1 Apr 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984457; cv=none; b=UqqIXY8nSOYSZHzH6Hc5khEOGUrn2FY8ZJJ+4rVX0CgEFTOVrkNsANvTukSckyZf0oBFLH6s/1hi4z1S6JirbntlAkbwjA/kY6qo5GqO3gS1GvxhFDKpz6TJVNTdbqXSbtT15gS2MmFQV63v93wEULMMLh7Pr1ffFjMD17wNS6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984457; c=relaxed/simple;
	bh=JltTTo7L3Pqb7x/nOOqrDGh4IIDaFzvkM7xcA0ivsp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHFHJoPZhi4/rGBdnGLpt/42AQMkrvv6a9I138D2LvuIo4lpYgNcR2j+jvV8//8EIsVNVOcuxO7H19kQjBit4Bjz/uWl+OkNOzcjxOJ4QnhmWm5bGDv1CU6VAwk6Qo+t/T++lo5Wj0nlsduop05rK1tjnuuYLjrVhXqgcgoiIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOYUl9Cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47B0C433C7;
	Mon,  1 Apr 2024 15:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711984457;
	bh=JltTTo7L3Pqb7x/nOOqrDGh4IIDaFzvkM7xcA0ivsp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOYUl9CpeoWpySvUK2rUyJSDEeRhPXzAHbVHYDs5CFBnvRRj4DVrls0W7obkCxRwR
	 EEPk4esZ4pUA7/dilS17s/Z4pT5eOIpZw8WrSqXNcLxS/gaZ/37r7LWPiAHNcMAnCw
	 u6mahNDpuw8dv6REBM/9UnBLP5vur6pY73oGNmKEk75DENS31rw3hrBScSV3SGVLyq
	 1p/WGUNP10x7qJdySPicK7tP2b4nhDZCi0rjatOUbLFrXJSIYXA5VjQjzFQP3dSlWb
	 B7SLYw1B5HU/gFkCZ31mE4jx6eBMgFqPqYPIg9RIvohuUJMwNeZ6RM9zLp6LlA4eg0
	 Qjq9Q5PfDa9/g==
Date: Mon, 1 Apr 2024 10:14:14 -0500
From: Rob Herring <robh@kernel.org>
To: Kartik Agarwala <agarwala.kartik@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ASoC: dt-bindings: mt2701-wm8960: Convert to dtschema
Message-ID: <20240401151414.GA706943-robh@kernel.org>
References: <20240401043505.40972-1-agarwala.kartik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401043505.40972-1-agarwala.kartik@gmail.com>

On Mon, Apr 01, 2024 at 10:05:05AM +0530, Kartik Agarwala wrote:
> Convert mt2701-wm890 bindings from text to dtschema. This is used by MediaTek mt77623a/n SoC.

Wrap lines at 75.

> 
> Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>
> ---
>  .../sound/mediatek,mt2701-wm8960.yaml         | 59 +++++++++++++++++++
>  .../bindings/sound/mt2701-wm8960.txt          | 24 --------
>  2 files changed, 59 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt2701-wm8960.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/mt2701-wm8960.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt2701-wm8960.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt2701-wm8960.yaml
> new file mode 100644
> index 000000000..771f14a59
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt2701-wm8960.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mediatek,mt2701-wm8960.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT2701 with WM8960 CODEC
> +
> +maintainers:
> +  - Kartik Agarwala <agarwala.kartik@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt2701-wm8960-machine
> +
> +  mediatek,platform:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT2701 ASoC platform.
> +
> +  audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description: |

Don't need '|'.

> +      A list of the connections between audio components. Each entry is a
> +      pair of strings, the first being the connection's sink, the second
> +      being the connection's source.
> +
> +  mediatek,audio-codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of the WM8960 audio codec.
> +  
> +  pinctrl-names:
> +    const: default
> +
> +  pinctrl-0: true

You can drop pinctrl properties. Those are implicitly supported.

> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - mediatek,platform
> +  - audio-routing
> +  - mediatek,audio-codec
> +  - pinctrl-names
> +  - pinctrl-0
> +
> +examples:
> +  - |
> +    sound {
> +        compatible = "mediatek,mt2701-wm8960-machine";
> +        mediatek,platform = <&afe>;
> +        audio-routing =
> +            "Headphone", "HP_L",
> +            "Headphone", "HP_R",
> +            "LINPUT1", "AMIC",
> +            "RINPUT1", "AMIC";
> +        mediatek,audio-codec = <&wm8960>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&aud_pins_default>;
> +    };

