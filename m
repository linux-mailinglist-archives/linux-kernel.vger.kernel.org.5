Return-Path: <linux-kernel+bounces-160324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC65B8B3BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7541C23B90
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDCE14A4E9;
	Fri, 26 Apr 2024 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/gwIiX3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA7148FE5;
	Fri, 26 Apr 2024 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146302; cv=none; b=Cyp4noI2gpt4oLIowWtXufGDVBNoLrU3werm4UwwwC6z9NrO1Aowqe+zvgkLcsrnRC7uvaROR0yEhkER/YFNvq8mk7cfnRC68u9ExiXG4xN18enXa0gixJrUdIxsPyf74J/BTHVBZkIJ3dCHMnm0155RMTh9khQkYjrRKtCS0AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146302; c=relaxed/simple;
	bh=eOP2/U4Vd5DzPmdW0xejV5wEgvRGsN/4+Hk2GtsLxhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJGJp7ilVWMaQyS9/tfVs8MnVgdy8vSoKwgvMKiZG0LA9hunBCnaDA4jreoErmJZiGepB4UqngMVqzvWPFe+ZbXGouq+IDPmVaQaFl5MIOsA1Z1tchHm6KHeUDPGr2KSztlSEkg4uipPiMy63NeGMgrbGv8u7gpe8IsmLJu9oXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/gwIiX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CB2C113CD;
	Fri, 26 Apr 2024 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714146301;
	bh=eOP2/U4Vd5DzPmdW0xejV5wEgvRGsN/4+Hk2GtsLxhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/gwIiX36LDs2I9/Z1NuMFucOvQCei1MAXd+b28yCja93zW8rs3K36b2ifWD+p/sh
	 YdrablzWIkEWpsiAry8zadTIEddCuvv7yQ/nbH8YPvuCsDQ94Qk/kOeebuV9q6dftB
	 +5VpqNDteiE6rs4saJM3xoHCaRSOtwrUMC5LgaQ7+j5l2z38oGa7diu7lN+0xvOcu+
	 4L7x+6SWLJ1PMiP462dzHqxy1woJVywKaa9Uig8xbDl1pI8vIrnWhrUo+6M4wKxQ7T
	 GoRh0sUP3ne4TeZu3fJNZLK/NrgtxhxZNMpEdNlDLT5PkVifWoBC1KMRHN/igePNyF
	 M0yn5bBNfR16Q==
Date: Fri, 26 Apr 2024 10:44:58 -0500
From: Rob Herring <robh@kernel.org>
To: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ASoC: dt-bindings: tegra30-i2s: convert to dt schema
Message-ID: <20240426154458.GA1964057-robh@kernel.org>
References: <20240425153045.49939-1-sheharyaar48@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425153045.49939-1-sheharyaar48@gmail.com>

On Thu, Apr 25, 2024 at 09:00:43PM +0530, Mohammad Shehar Yaar Tausif wrote:
> Convert NVIDIA Tegra30 I2S binding to DT schema and
> add "clock-names" property used by multiple tegra i2s blocks
> in arch/arm64/boot/dts/nvidia/tegra132.dtsi. This is not a
> required property by the binding.
> 
> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> ---
> Changes v3->v4:
> - removed redundant example
> - defined clock-names property
> 
> v3:
> https://lore.kernel.org/all/20240425090716.176818-1-sheharyaar48@gmail.com/
> ---
>  .../bindings/sound/nvidia,tegra30-i2s.txt     | 27 ------
>  .../bindings/sound/nvidia,tegra30-i2s.yaml    | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 27 deletions(-)
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
> index 000000000000..13cee366f5b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.yaml
> @@ -0,0 +1,83 @@
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

This allows 4 possible combinations for 2 SoCs. That may be how the old 
binding was worded, but that's not valid.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: i2s
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
> +  - |
> +    #include <dt-bindings/clock/tegra124-car.h>
> +
> +    i2s@70301100 {
> +        compatible = "nvidia,tegra124-i2s";
> +        reg = <0x70301100 0x100>;
> +        nvidia,ahub-cif-ids = <5 5>;
> +        clocks = <&tegra_car TEGRA124_CLK_I2S1>;
> +        clock-names = "i2s";
> +        resets = <&tegra_car 11>;
> +        reset-names = "i2s";
> +    };

I didn't check what you removed, but this is still 1 example too many. 
They are almost the same.

