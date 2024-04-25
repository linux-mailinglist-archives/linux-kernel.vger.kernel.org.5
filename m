Return-Path: <linux-kernel+bounces-158768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D18298B24A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879E72815A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B5314B06E;
	Thu, 25 Apr 2024 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7i9G3QY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E8414A0B2;
	Thu, 25 Apr 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057565; cv=none; b=oubXkQCUOmvtUmAcy9036JhTYi3XfJ2WBZ2nyNVlr8+nSWbZMu2M1TEsDfz7sy1vDBWRjnGrCqn9pnwPO6tpAMAWv5BFjFN7ChEQCB3NECEZBtGEbeOl1MZMzImHRK1nigpf/NR8evuBOX8xAbxF8hmySz82NB77rrKqhTMtQ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057565; c=relaxed/simple;
	bh=YYdxZ2iuMpRX8Qcm7I+r/grTTBlmJZFnrlNrHolBd3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k191MoWucWaXItsrBJYJcbnaSkapsZmQG0XfcCYaLq4zY9srieDMD3vJI16x89ECotRJkv5W0lZnStOeW57EKayBOn5YARG4x+mqDD6uhVkwXSTXEdrdnUOAEFWLJ+Au0GR+os+PgjOVYji3QZ7v5EcqelAXVTjGVUxoeV9Ts8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7i9G3QY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30898C113CC;
	Thu, 25 Apr 2024 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714057564;
	bh=YYdxZ2iuMpRX8Qcm7I+r/grTTBlmJZFnrlNrHolBd3Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B7i9G3QYg21wVQA4UDNw6wU20FEXjdhjArslg6RRONMfNG7/qqa7U/ciz43VogdJi
	 bfZ9ryICzcgdH2vlgNDXEC+cIP/loWz1Ga4l4a+imLg8jouXTMr6RjueSeAj+vBvaX
	 19/c6Q1l80auk65ZA3Myrm9EEOqSdTeLW64PQXC5t0lw6iRIeuRrOgBes4WVhtdt5L
	 V6KcsLxSVaeN5oxoh+CoxEaHq+USuPysDbjznybdhiLKYQa3lJjvdgzJu8hDblKVwg
	 3+kxTG8dHv0jA6jUIYcakg5E6GeGw4uWfGtvyuXX4YTWonNW2LuVdpsrlQjk/Oei9Z
	 Mpjg85OAKrlsw==
Message-ID: <99496fb5-50d3-4e91-a519-881cae58b47a@kernel.org>
Date: Thu, 25 Apr 2024 17:05:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ASoC: dt-bindings: tegra30-i2s: convert to dt schema
To: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240425090716.176818-1-sheharyaar48@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240425090716.176818-1-sheharyaar48@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2024 11:07, Mohammad Shehar Yaar Tausif wrote:
> Convert NVIDIA Tegra30 I2S binding to DT schema and
> add new examples.
> 
> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> ---
> Changes v2->v3:
> - Fixed example indentation
> - Fix compatible logic
> - Add new examples from existing dts

Why? One different property does not justify new example. I don't think
I asked for such change.

> - Add clock-names in properties
> 
> v2:
> https://lore.kernel.org/all/20240421123037.75680-1-sheharyaar48@gmail.com/
> ---
>  .../bindings/sound/nvidia,tegra30-i2s.txt     | 27 ------
>  .../bindings/sound/nvidia,tegra30-i2s.yaml    | 94 +++++++++++++++++++
>  2 files changed, 94 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
> deleted file mode 100644
> index 38caa936f6f8..000000000000
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -NVIDIA Tegra30 I2S controller
> -
> -Required properties:
> -- compatible : For Tegra30, must contain "nvidia,tegra30-i2s".  For Tegra124,
> -  must contain "nvidia,tegra124-i2s".  Otherwise, must contain
> -  "nvidia,<chip>-i2s" plus at least one of the above, where <chip> is
> -  tegra114 or tegra132.
> -- reg : Should contain I2S registers location and length
> -- clocks : Must contain one entry, for the module clock.
> -  See ../clocks/clock-bindings.txt for details.
> -- resets : Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names : Must include the following entries:
> -  - i2s
> -- nvidia,ahub-cif-ids : The list of AHUB CIF IDs for this port, rx (playback)
> -  first, tx (capture) second. See nvidia,tegra30-ahub.txt for values.
> -
> -Example:
> -
> -i2s@70080300 {
> -	compatible = "nvidia,tegra30-i2s";
> -	reg = <0x70080300 0x100>;
> -	nvidia,ahub-cif-ids = <4 4>;
> -	clocks = <&tegra_car 11>;
> -	resets = <&tegra_car 11>;
> -	reset-names = "i2s";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
> new file mode 100644
> index 000000000000..3d8d56c666d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nvidia,tegra30-i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra30 I2S controller
> +
> +maintainers:
> +  - Thierry Reding <treding@nvidia.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nvidia,tegra124-i2s
> +          - nvidia,tegra30-i2s
> +      - items:
> +          - enum:
> +              - nvidia,tegra114-i2s
> +              - nvidia,tegra132-i2s
> +          - enum:
> +              - nvidia,tegra124-i2s
> +              - nvidia,tegra30-i2s
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    maxItems: 1

This was not in the previous binding and is not explained in commit msg.

Also, this needs to be specific.

> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: i2s
> +
> +  nvidia,ahub-cif-ids:
> +    description: list of AHUB CIF IDs
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      - description: rx (playback)
> +      - description: tx (capture)
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - reset-names
> +  - nvidia,ahub-cif-ids
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/tegra30-car.h>
> +
> +    i2s@70080300 {
> +        compatible = "nvidia,tegra30-i2s";
> +        reg = <0x70080300 0x100>;
> +        nvidia,ahub-cif-ids = <4 4>;
> +        clocks = <&tegra_car TEGRA30_CLK_I2S0>;
> +        resets = <&tegra_car 30>;
> +        reset-names = "i2s";
> +    };

Just keep one or two examples.

Best regards,
Krzysztof


