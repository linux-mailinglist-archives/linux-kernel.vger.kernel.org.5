Return-Path: <linux-kernel+bounces-154572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778CC8ADDC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DD51F22EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BB32C190;
	Tue, 23 Apr 2024 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRFRCWtr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CB822EF0;
	Tue, 23 Apr 2024 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854953; cv=none; b=jpK0sk+WWvWLtpfUrZAt0ZxhrrVhFiq9GmnDszash4Nv2Dc/7ZQkKSIgAJ8cHyCSViaCBYOoDOTY2iqGeiqqf4oM7VmPvmT5gyyMkUUTjHVPzZHnZ14HW4g5/WYDVZFqbkfmPPYzu3USk0VwYA507GgXTsZeeC3S7m1Vh5UszkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854953; c=relaxed/simple;
	bh=fUTtTh/zPyc+NtsblpZ/UF14U9cjpJ2EZFr6zt2djgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxvQMJerEdWy7GGRujkE1OyKLiuR8Fd8jz7daMOE4Y7axpSBdzEWWIzEz8gO9Fwfeu/Guw7P48RrhWuE7caVkm5OR/HHq4f5SbFt5jJAkI/ENK6ht5RlPUQdoRTj0nRx0ssEKGop0m+M2d/71S4r+qRyQKbSLXLcQVOg9MxZiZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRFRCWtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18DCC116B1;
	Tue, 23 Apr 2024 06:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713854953;
	bh=fUTtTh/zPyc+NtsblpZ/UF14U9cjpJ2EZFr6zt2djgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hRFRCWtrtjnyl6lqm22dSfsZFR2ds8NiGVumQqLYNdpofrDz2J1qIYsGtp+s93Iey
	 76BGfnLzqXy1PYZHPz+bqO1idx5HwG2rWgf7XebzE8LwHhyJX4zHgyEQBiLXDS6lKi
	 jt95f+d+i/qmgiTXLga8D1Ony5+Ik4dpfrsG41tHFjbLQwcnoaAOYzxeg0p4G4Fy3s
	 YX3mM+MDijIokb9PtBNwis0C1Scea5cbF23vehnnzmITZVq99UcNHoSPsPmZLzHGkt
	 aaXICFfED9AsPabwRv6eRYcFou4ixkfDs9VyoPBRXu3LpvxrZJp/AKHmITr8pXgWbY
	 ab0azg08RmPFw==
Message-ID: <9936177c-1800-4425-be36-bc9f06fcf5ba@kernel.org>
Date: Tue, 23 Apr 2024 08:49:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: dt-bindings: tegra20-ac97: convert to dt schema
To: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240422123830.472109-1-sheharyaar48@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240422123830.472109-1-sheharyaar48@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 14:38, Mohammad Shehar Yaar Tausif wrote:
> Convert NVIDIA Tegra20 AC97 binding to DT schema.
> Change -gpio to -gpios in both schema and nvidia/tegra20-colibri.dtsi

Why? Please always explain why you are doing things. "gpio" suffix is
deprecated.

> 
> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> ---
> Changes v1->v2:
> - change -gpio to -gpios in both schema and dtsi
> - tested against dts
> - add header files and defines
> ---
>  .../bindings/sound/nvidia,tegra20-ac97.txt    | 36 --------
>  .../bindings/sound/nvidia,tegra20-ac97.yaml   | 86 +++++++++++++++++++
>  arch/arm/boot/dts/nvidia/tegra20-colibri.dtsi |  4 +-

Bindings are separate patches.

>  3 files changed, 88 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
> deleted file mode 100644
> index eaf00102d92c..000000000000
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -NVIDIA Tegra 20 AC97 controller
> -
> -Required properties:
> -- compatible : "nvidia,tegra20-ac97"
> -- reg : Should contain AC97 controller registers location and length
> -- interrupts : Should contain AC97 interrupt
> -- resets : Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names : Must include the following entries:
> -  - ac97
> -- dmas : Must contain an entry for each entry in clock-names.
> -  See ../dma/dma.txt for details.
> -- dma-names : Must include the following entries:
> -  - rx
> -  - tx
> -- clocks : Must contain one entry, for the module clock.
> -  See ../clocks/clock-bindings.txt for details.
> -- nvidia,codec-reset-gpio : The Tegra GPIO controller's phandle and the number
> -  of the GPIO used to reset the external AC97 codec
> -- nvidia,codec-sync-gpio : The Tegra GPIO controller's phandle and the number
> -  of the GPIO corresponding with the AC97 DAP _FS line
> -
> -Example:
> -
> -ac97@70002000 {
> -	compatible = "nvidia,tegra20-ac97";
> -	reg = <0x70002000 0x200>;
> -	interrupts = <0 81 0x04>;
> -	nvidia,codec-reset-gpio = <&gpio 170 0>;
> -	nvidia,codec-sync-gpio = <&gpio 120 0>;
> -	clocks = <&tegra_car 3>;
> -	resets = <&tegra_car 3>;
> -	reset-names = "ac97";
> -	dmas = <&apbdma 12>, <&apbdma 12>;
> -	dma-names = "rx", "tx";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.yaml
> new file mode 100644
> index 000000000000..9a68578f6fc3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nvidia,tegra20-ac97.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra20 AC97 controller
> +
> +maintainers:
> +  - Thierry Reding <treding@nvidia.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra20-ac97
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: ac97
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +  nvidia,codec-reset-gpios:
> +    description:
> +      The Tegra GPIO controller's phandle and the number
> +      of the GPIO used to reset the external AC97 codec

Drop redundant parts and just "Reset pin of external AC97 codec"

> +    maxItems: 1
> +
> +  nvidia,codec-sync-gpios:
> +    description:
> +      The Tegra GPIO controller's phandle and the number
> +      of the GPIO corresponding with the AC97 DAP _FS line

"AC97 DAP _FS line"



Best regards,
Krzysztof


