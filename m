Return-Path: <linux-kernel+bounces-152579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AEC8AC0BB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 20:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496FD1C209BC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0FC3CF40;
	Sun, 21 Apr 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FihFIFls"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B29C10A35;
	Sun, 21 Apr 2024 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713723809; cv=none; b=C07Ys1AKPngwh/ddl3oscqsCcHH/dLKkcjO8u0vuY5iP0k7oFyfdM+9+iXW30jQNB8eJXd45OO+U1wM6wiWjm11dTMTM/UcR5u4RdNFPEegCa1e1/MgJLTJ1q7ry0nhrALCa+NJwi2wdAj1abIUmtJ8uZFKPpZH2s59pXP+SarY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713723809; c=relaxed/simple;
	bh=BV+7ZhZojp/eFlhUHpQbc4Yl9vwGklRIUscYmJ+Lehg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XE4PLaFCNoBVUU+yIRuSmuIrVwjnrN8UxPiP2xjIiUl8r/aQxlTf6nqY6GswtvoVyfPGu2IBuCZWudUStbPU8psb0P9sMQ6uwhDwtEEZGL2sQAdg2FXXUh3Lw1djLjIkVj/KjKYHEk/u/IbB52kvHJCyEYpTEbgTk2lkGHlcqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FihFIFls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2964CC113CE;
	Sun, 21 Apr 2024 18:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713723809;
	bh=BV+7ZhZojp/eFlhUHpQbc4Yl9vwGklRIUscYmJ+Lehg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FihFIFlsG/5RA5cmqQF1sjN9ATQO2E8Er2pZ2dIig5Msx4Qc3Ob/EkzVmuyBLiAi1
	 PW12c/ws/Ovc9PjZZ6JYNq7wRs2fR/Bs2tpBsC4x9jz0RXGYwZTxwYCJf9QmW/HurH
	 qLe+JJGehu7xVyDb6wv3DoEIezygPrfVd2Nn6ioM1iYbED9+x2OyV1qOohTpo+IWKx
	 CvP1oFCDHk+inV1iyy5RzPT5PUFYszSLFA0HaHevk0tF8ZRgR/Lc3Lr7FXkZ3JCGNc
	 +7PuaeGa1HvJsia06vufo37BZVxVVqaFWxIU8Cj99migq0diFEcGgAiRZRZ2ClEaUU
	 nmn/4iKN+oErA==
Message-ID: <f1c27992-5014-440b-a1e2-835744d51062@kernel.org>
Date: Sun, 21 Apr 2024 20:23:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: dt-bindings: tegra30-i2s: convert to dt schema
To: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240421123037.75680-1-sheharyaar48@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240421123037.75680-1-sheharyaar48@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/04/2024 14:30, Mohammad Shehar Yaar Tausif wrote:
> Convert NVIDIA Tegra30 I2S binding to DT schema.
> 
> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> ---
> v1->v2:
> - Removed incorrect item ref definition
> 
> Previous versions:
> v1:
> https://lore.kernel.org/all/20240420175008.140391-1-sheharyaar48@gmail.com/
> ---
>  .../bindings/sound/nvidia,tegra30-i2s.txt     | 27 --------
>  .../bindings/sound/nvidia,tegra30-i2s.yaml    | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 27 deletions(-)
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
> index 000000000000..b4cc0b0abfb8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
> @@ -0,0 +1,66 @@
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
> +          - const: nvidia,tegra124-i2s
> +          - const: nvidia,tegra30-i2s

That's not what the binding said and not what DTS is saying.

This points to the fact you did not really test this binding on real DTS.

When you convert the binding to DT schema, you *must* test all existing
DTS. Especially that trivial one, like this case armv7 multiplatform boards.

That's a requirement in DT conversion work.


> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: i2s
> +
> +  nvidia,ahub-cif-ids:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      The list of AHUB CIF IDs for this port, rx (playback)
> +      first, tx (capture) second. See nvidia,tegra30-ahub.txt for values.
> +    minItems: 2
> +    maxItems: 2

Better list items with description
items:
 - description:
 - description:

Also provide proper constraints. Looks like RX and TX are max 5.


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
> +    i2s@70080300 {
> +            compatible = "nvidia,tegra30-i2s";

Use 4 spaces for example indentation.



Best regards,
Krzysztof


