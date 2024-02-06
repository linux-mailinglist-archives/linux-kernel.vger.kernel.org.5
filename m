Return-Path: <linux-kernel+bounces-55468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C67684BD12
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5791C23089
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3CB134CE;
	Tue,  6 Feb 2024 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYatzYeT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FB7DDCF;
	Tue,  6 Feb 2024 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244989; cv=none; b=Z3aRHfm1lZyonW1y7MPLev6Mmp+ee5QZWPpGqYSDuIhoroCsjvajOHVJFgd/f4dk99HPxFknsSAc48ju05dl1MsiEcInopvA+cAi7FbGaUxtjXfg4bkX8XeeZalDmiL2Ajz0atA/Tuw11DzwH20otnEEy0x+A8aPNs3YyzDKtjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244989; c=relaxed/simple;
	bh=b8iiNmOxD0YSZRAXkjUpo5Bj7K1mUidd9Bi4uo8nVYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptcgRHgMc4J74WgEtKi7Rl1pehq/N+C/6wdjgSfvGNCdSg00WPt0tzDNlwnNrE8uxzJihs2AU33EctHr98PUVP5wpCeMnNu0TNq6SzHSoB5jOh1UKPSIS6CClAjSReXXMokF1vkkaF6YEntyf9cZSmOh5wVBnPwqOhQFwNqcXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYatzYeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E06C433C7;
	Tue,  6 Feb 2024 18:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707244989;
	bh=b8iiNmOxD0YSZRAXkjUpo5Bj7K1mUidd9Bi4uo8nVYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYatzYeTjSOJMl3yYbLE926+PErs/nE/D8+JB+OZLPPymTr2qQp0fE8/NfA1Kkq7p
	 6B6Ok33LCm9VU/Y/g+tz4MZoDf9IAH2hTq38poE/STBvgOKXRbpeZHlqXGuxlezhhq
	 3XM6jO0cnIjaXypc2XERjyS3qlEB0rJ17M7o/pGbbm1DaDoPLekeABJUqXaqeQjbD9
	 Heux0j0VHAvbGpDtWI2dw6gxtvnHzjwp1PcQP69q5zo5nT6lqYLbTTaVbW8G0KCck0
	 qXPRimIzR8CWO7g+7yTnbO5Q0rCjjd4CvnQsaUmMAm9tKQsAAeqAPpPAWgMSZR7EhG
	 jwjRU4jop5E3g==
Date: Tue, 6 Feb 2024 18:43:05 +0000
From: Rob Herring <robh@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Santosh Shilimkar <ssantosh@kernel.org>, Andrew Davis <afd@ti.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: hwinfo: ti,k3-socinfo: Add nvmem-cells
Message-ID: <20240206184305.GA1875492-robh@kernel.org>
References: <20240206143711.2410135-1-msp@baylibre.com>
 <20240206143711.2410135-3-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206143711.2410135-3-msp@baylibre.com>

On Tue, Feb 06, 2024 at 03:37:09PM +0100, Markus Schneider-Pargmann wrote:
> The information k3-socinfo requires is stored in an efuse area. This
> area is required by other devices/drivers as well, so using nvmem-cells
> can be a cleaner way to describe which information are used.
> 
> If nvmem-cells are supplied, the address range is not required.
> Cells chipvariant, chippartno and chipmanufacturer are introduced to
> cover all required information.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Reviewed-by: Andrew Davis <afd@ti.com>
> ---
>  .../bindings/hwinfo/ti,k3-socinfo.yaml        | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> index dada28b47ea0..f085b7275b7d 100644
> --- a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> +++ b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> @@ -26,9 +26,24 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  nvmem-cells:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: chipvariant
> +      - const: chippartno
> +      - const: chipmanufacturer
> +
>  required:
>    - compatible
> -  - reg
> +
> +oneOf:
> +  - required:
> +      - reg
> +  - required:
> +      - nvmem-cells
> +      - nvmem-cell-names
>  
>  additionalProperties: false
>  
> @@ -38,3 +53,9 @@ examples:
>          compatible = "ti,am654-chipid";
>          reg = <0x43000014 0x4>;
>      };
> +  - |
> +    chipid: chipid@14 {
> +        compatible = "ti,am654-chipid";

This isn't compatible if you have a completely different way to access 
it. 


> +        nvmem-cells = <&chip_variant>, <&chip_partno>, <&chip_manufacturer>;
> +        nvmem-cell-names = "chipvariant", "chippartno", "chipmanufacturer";
> +    };
> -- 
> 2.43.0
> 

