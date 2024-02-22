Return-Path: <linux-kernel+bounces-76680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7897885FAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB27A1C22178
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642741474BD;
	Thu, 22 Feb 2024 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swmaF298"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0F1419A4;
	Thu, 22 Feb 2024 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611385; cv=none; b=OF1pMdaOF3SvkZgJYnWrl6tBAWxSuGesJirh0aSFzfzB1hmcFcjwj9n10Q20rRo9Zp4lfhkwr5UevhzXpKRHp1VJ10/gVCusw5C8s4fZlUF1/4dMAekl7zwMbeNDnHBXUMGkFXZgMCG5YLHWhLyxenBvXcYx4t6uAHECFS2vWww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611385; c=relaxed/simple;
	bh=SZ/Zk8BWOQjTPubYMUBoHg3tSEyPhODwMelB+zqkglQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXAp7ostRKSqdKOnv2ComdCKsJ1UkKXahpw1igIXhcLzmEsqkuQtQG4O0psdAALYXdo9bdrrb/eFc5t4RfRlbrYkFPS7viy1OHn73B1fym4Odi84xpEqoQYAvDx4Q/Rl4YTSBE7id4jAihJNGXpWROERxbQ1IhfvxuLjWzdZ2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swmaF298; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D59C433C7;
	Thu, 22 Feb 2024 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708611385;
	bh=SZ/Zk8BWOQjTPubYMUBoHg3tSEyPhODwMelB+zqkglQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=swmaF2984HLAl0s/d0P4xSdY/AMjSYjub6C/25DGguLpnzREhpoGB6RsRh0ImwSUk
	 U80FUff6MDpnpx6VTr5ryRBxGQ5fI3qwuoT9pTLIBiZeZb8k90PucUg93E3D5iV4s2
	 hPSzdmEAwq+ir2fRC4vauk+nWBdSlBvJd3dNuiEzMbuLHSKka8WQU3Scep9y92xKai
	 Ozpdnqy8rZir9ppdzGr19FXzCoZyNPxI7pAKa/wJObtJZrn9j2w2psydtZoDKPy5M1
	 zyLKOIgpZ7mvXixgVcb0Xu/SkLD7n/T9aTfLdPQrfnvLNpm63sse7N/hAqWyGy2RgH
	 ZvvWsvgM/QbRw==
Date: Thu, 22 Feb 2024 07:16:22 -0700
From: Rob Herring <robh@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
	CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
	supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: Added schema for
 "nuvoton,nau8325"
Message-ID: <20240222141622.GA2748112-robh@kernel.org>
References: <20240222083825.190854-1-wtli@nuvoton.com>
 <20240222083825.190854-2-wtli@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222083825.190854-2-wtli@nuvoton.com>

On Thu, Feb 22, 2024 at 04:38:24PM +0800, Seven Lee wrote:
> Added a DT schema for describing nau8325 audio amplifiers.

Please test your bindings before sending.

> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../bindings/sound/nuvoton,nau8325.yaml       | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
> new file mode 100644
> index 000000000000..fc72baf0bb7a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nuvoton,nau8325.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NAU8325 audio Amplifier
> +
> +maintainers:
> +  - Seven Lee <WTLI@nuvoton.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: nuvoton,nau8325
> +
> +  reg:
> +    maxItems: 1
> +
> +  nuvoton,vref-impedance:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Use standard unit suffixes.

> +    description:
> +      VREF impedance selection.
> +    enum:
> +      - 0 # Open
> +      - 1 # 25kOhm
> +      - 2 # 125kOhm
> +      - 3 # 2.5kOhm
> +    default: 2
> +
> +  nuvoton,dac-vref:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Use standard unit suffixes.

> +    description:
> +      DAC Reference Voltage Setting.
> +    enum:
> +      - VDDA

in Volts?

> +      - VDDA*1.5/1.8V

Volts/Volts

So 2 different units?

> +      - VDDA*1.6/1.8V
> +      - VDDA*1.7/1.8V
> +    default: 2
> +
> +  nuvoton,alc-enable:
> +    description:
> +      Enable digital automatic level control (ALC) function.
> +    type: boolean
> +
> +  nuvoton,clock-detection-disable:
> +    description:
> +      When clock detection is enabled, it will detect whether MCLK
> +      and FS are within the range. MCLK range is from 2.048MHz to 24.576MHz.
> +      FS range is from 8kHz to 96kHz.
> +    type: boolean
> +
> +  nuvoton,clock-det-data:
> +    description:
> +      Request clock detection to require 2048 non-zero samples before enabling
> +      the audio paths. If set then non-zero samples is required, otherwise it
> +      doesn't matter.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        codec@21 {
> +            compatible = "nuvoton,nau8325";
> +            reg = <0x21>;
> +            nuvoton,vref-impedance = <2>;
> +            nuvoton,dac-vref = <2>;
> +            nuvoton,alc-enable;
> +            nuvoton,clock-det-data;
> +        };
> +    };
> -- 
> 2.25.1
> 

