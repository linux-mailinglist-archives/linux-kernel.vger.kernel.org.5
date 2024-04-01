Return-Path: <linux-kernel+bounces-127185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5648947D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D02E28382B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330925730C;
	Mon,  1 Apr 2024 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsmTklMs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8656760;
	Mon,  1 Apr 2024 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014814; cv=none; b=NQuM6kuL7yYHvj1FY+hlzpBKlv6/aCGhUCjAJYzxVkV5fB7daozclq6eowKwEEnVRphfmqiZ6pVlgBZN7JcbGGqlcJiR+p6y+cNJ0FIXIo1w+P5VaajnCpmdNRDWuzPI53oiN6L7tBM739XsYhqq6JWOmwc6F0H+gh89btb5d0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014814; c=relaxed/simple;
	bh=7ZzuN0E5FJAIusgfFsV6NIYO/Dp9pbGAoWrIo0VHKN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZCzH61aurB5Dce9b0+9ojJdCP4BdptV2O3vTRiR9ZBdMl3BvsX6toJSdmmY70tm6HVvQOW5Z9jz7+LbkMzEkHtGLmTyGJxIx1jMekEmEFdiuZeD4t5JyY1BaoKxCblZ9YrG12huZth1njnZNp1AMpsY1W8X+twweTEb6GfX+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsmTklMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F42C433F1;
	Mon,  1 Apr 2024 23:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712014813;
	bh=7ZzuN0E5FJAIusgfFsV6NIYO/Dp9pbGAoWrIo0VHKN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WsmTklMsOOFb6FOOI7d+qMoyUjFrdfhPMc2XYpW9zvfgomkDzk3iijWjXP4+YX9wO
	 A8pd8mDnAsy7u1GKgaR2OcxqEuqJj8AjxuEfNeUNI3+nSwbKT5YtUx33d2Ad6KXf3X
	 FJDZHZnHUBr3os4zRbT4mBp0T5U7GXIFF2MoYrOlOTLH+xxy2pL/lQNGE4ug1e8XMN
	 rn9QqtS+0N4CyOJ9lqvbDUsvXrl14JIsieQ5CQUpfxHy6DfkYiDQ80Ii5iHY57w59/
	 CT04eNIXUHy646qvwGsW1v32rFrA43JFTUjMauMTw98ZQolLodIM3FNQ1qYP15DCNV
	 ocDgkx8RWB+yQ==
Message-ID: <d5429736-8305-4afe-89a8-fe62907616e1@kernel.org>
Date: Tue, 2 Apr 2024 08:40:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: ata: ahci-da850: Convert to dtschema
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327064354.17384-1-animeshagarwal28@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240327064354.17384-1-animeshagarwal28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/24 15:43, Animesh Agarwal wrote:
> Convert the ahci-da850 bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

Krzysztof, Rob,

Are you OK with this patch ?

> 
> ---
> Changes in v3:
> - Fixed line length issue on line 20
> - Removed unneccessary '|' character
> Changes in v2:
> - Added description for reg property items.
> ---
>  .../devicetree/bindings/ata/ahci-da850.txt    | 18 ---------
>  .../bindings/ata/ti,da850-ahci.yaml           | 39 +++++++++++++++++++
>  2 files changed, 39 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Documentation/devicetree/bindings/ata/ahci-da850.txt
> deleted file mode 100644
> index 5f8193417725..000000000000
> --- a/Documentation/devicetree/bindings/ata/ahci-da850.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -Device tree binding for the TI DA850 AHCI SATA Controller
> ----------------------------------------------------------
> -
> -Required properties:
> -  - compatible: must be "ti,da850-ahci"
> -  - reg: physical base addresses and sizes of the two register regions
> -         used by the controller: the register map as defined by the
> -         AHCI 1.1 standard and the Power Down Control Register (PWRDN)
> -         for enabling/disabling the SATA clock receiver
> -  - interrupts: interrupt specifier (refer to the interrupt binding)
> -
> -Example:
> -
> -	sata: sata@218000 {
> -		compatible = "ti,da850-ahci";
> -		reg = <0x218000 0x2000>, <0x22c018 0x4>;
> -		interrupts = <67>;
> -	};
> diff --git a/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml b/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml
> new file mode 100644
> index 000000000000..ce13c76bdffb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/ti,da850-ahci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI DA850 AHCI SATA Controller
> +
> +maintainers:
> +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: ti,da850-ahci
> +
> +  reg:
> +    items:
> +      - description: Address and size of the register map as defined by the AHCI 1.1 standard.
> +      - description:
> +          Address and size of Power Down Control Register (PWRDN) for enabling/disabling the SATA clock
> +          receiver.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sata@218000 {
> +        compatible = "ti,da850-ahci";
> +        reg = <0x218000 0x2000>, <0x22c018 0x4>;
> +        interrupts = <67>;
> +    };

-- 
Damien Le Moal
Western Digital Research


