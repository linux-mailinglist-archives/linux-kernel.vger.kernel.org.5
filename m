Return-Path: <linux-kernel+bounces-118967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D84888C208
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE64030102C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E35D71B5D;
	Tue, 26 Mar 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayg9VoQK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0B12B6C;
	Tue, 26 Mar 2024 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455926; cv=none; b=H3BdFr28NEYoQ4BBfm+zjVWJfqhG7j2mp2T9knEAy4RdENJIzHqjhyYUnjVRdvLKCm5xhbKfDwnOUyVmgxqrTiQ9K3dU42TfPX02XFMaoWbsRY6fD26UyaGVuLP+ntf0wkCncUeAoXZxiucvKyNXeaz9nbHdCl28H82KzT4ShLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455926; c=relaxed/simple;
	bh=ldJ9Nm/iuvd89E7SnQDTNwEFNyi9MnhkhwTmIieqySE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4bq//9QVlEAQ0ncPWDyak1wcNs8nYVi7vjaeaqVevs4KA9aYTjC9CSXKZwkEb2gHIfSe3Z1VpuB1EFJF5CrFga/Nd8CIaTQ03lRVpvvR2jTJs6r4OqtIcQYg64xfJarFp3WDXGjrFStVOCFnHrQKh/XGBoC7W4xmnoE/GvHlB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayg9VoQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7865EC43390;
	Tue, 26 Mar 2024 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711455926;
	bh=ldJ9Nm/iuvd89E7SnQDTNwEFNyi9MnhkhwTmIieqySE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ayg9VoQKq7kNzpnfirynX8P2OaEo193Jk44IThRfg0q8hf6nZPxTzTBRN+MPxE35v
	 +fTgYOFTf6zQMC7SDdfT9389j+AUknSoloeeoDplQI2EFmnPHSFXiusH1P1Clgpf3D
	 z0/fluuSfahRFboChZu7eM52x+h6X/63I0QM6c3lyvKTVR+ehJ7cenQ2WyJx89m30b
	 ajPmlzB+4IHPKe/uzz3t990pjIAtME3ASiVfu2pAStdSolXeVNA69sfnO8WI/UBhcU
	 M6FpZ1P9jeMYwd8WqY6BfPaQ5Mu82jEeLR17AYt68itPakl/c9qzdbHqhf4+ZSvDrl
	 AKuKUSjVienAg==
Message-ID: <7567a9b5-fd6d-4729-964e-14c4e129bcd7@kernel.org>
Date: Tue, 26 Mar 2024 21:25:01 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: ahci-da850: Convert to dtschema
Content-Language: en-US
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326121735.11994-1-animeshagarwal28@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240326121735.11994-1-animeshagarwal28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/24 21:17, Animesh Agarwal wrote:
> Convert the ahci-da850 bindings to DT schema

Missing a period at the end of the sentence.

> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
>  .../devicetree/bindings/ata/ahci-da850.txt    | 18 ----------
>  .../bindings/ata/ti,da850-ahci.yaml           | 36 +++++++++++++++++++
>  2 files changed, 36 insertions(+), 18 deletions(-)
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
> index 000000000000..d54f58c12e78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml
> @@ -0,0 +1,36 @@
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
> +    minItems: 2
> +    maxItems: 2
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


