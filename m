Return-Path: <linux-kernel+bounces-45030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33213842AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FFE1C250B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FF6129A8F;
	Tue, 30 Jan 2024 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpLjzPUW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A41292D6;
	Tue, 30 Jan 2024 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635151; cv=none; b=as8MDToy9YyJu+DFnSknJfZDS3JOweNP3Y8B3xVdyLE7aherVGjja+pO3zOsGV2bU+LAX+3fRIUkk0FHyaDUG0ssrn0pWadApKk+urhsffFp9i59t4SyAzAEYNUZvS3K2aps708D3WgV69DPin7IHmtf3zWY4Zq2NYZoesLmRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635151; c=relaxed/simple;
	bh=y4IszyoidWFXzhNhDY2c9NDxcMcu1lKzZ3vPlfsqW38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3CMu204px1xN/sRajQlcBFUFvOu0uu3ruHTVAaAjq7syO3uninJdyGB3CV+q9dJ8lt5DG0PfuVmwEbXaiv7HnMaIfL6gQWdl8OQ7KHlhNHfOsmzFY7nrSi5MSlzCgUHnUOzHutQrKxB7Iqm07rCPe6WKZJJvf5SwheEPxbEn/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpLjzPUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14E4C433C7;
	Tue, 30 Jan 2024 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706635151;
	bh=y4IszyoidWFXzhNhDY2c9NDxcMcu1lKzZ3vPlfsqW38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpLjzPUWXqKV54fhDJhAYBoggAWgle3OxuN85QdeHkEbaDgS22ahV8cnmW+CwRNpO
	 SIAcp+xgeFPt0rW4GBFx8d6u498AvJg6rfEbJf8z4srNRDx55/CEL4DGy3YDE4RHw0
	 p6I4x5rFA7NMe73dKX7X3Q7xbPNBDhcfToS0rULHyT+XIvusI7y5jsOkAl6awCK9/F
	 7LXkHo2wZT1wdYmcDT1qXwIaTSaXpCbkCjoDyqVmYiFFh3dAjVbYKJpRxr6jVUbLnV
	 jVSuPZlSkOwnYqsRkbr8lSgJXzuS+IsycbymTehgrvqM88w9IsW5p+v3thCgAynqZL
	 65iP3i0p/mhNA==
Date: Tue, 30 Jan 2024 11:19:08 -0600
From: Rob Herring <robh@kernel.org>
To: Petlozu Pravareshwar <petlozup@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	p.zabel@pengutronix.de, dmitry.osipenko@collabora.com,
	ulf.hansson@linaro.org, kkartik@nvidia.com, cai.huoqing@linux.dev,
	spatra@nvidia.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 2/3] dt-bindings: tegra: pmc: Update scratch as an
 optional aperture
Message-ID: <20240130171908.GA1964535-robh@kernel.org>
References: <20240117202504.943476-1-petlozup@nvidia.com>
 <20240117202504.943476-2-petlozup@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117202504.943476-2-petlozup@nvidia.com>

On Wed, Jan 17, 2024 at 08:25:03PM +0000, Petlozu Pravareshwar wrote:
> Scratch address space register is used to store reboot reason. For
> some Tegra234 systems, the scratch space is not available to store
> the reboot reason. This is because scratch region on these systems
> is not accessible by the kernel as restricted by the Hypervisor.
> Such systems would delist scratch aperture from PMC DT node.
> 
> Accordingly, this change makes "scratch" as an optional aperture for
> Tegra234 in PMC dt-binding document.
> 
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> ---
> Changes in v2:
> - Fix dt_binding_check indentation warning.
> - Update 'reg-names' property items list.
> 
>  .../arm/tegra/nvidia,tegra186-pmc.yaml        | 78 ++++++++++++++-----
>  1 file changed, 58 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
> index 0faa403f68c8..79928824005d 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml
> @@ -27,7 +27,7 @@ properties:
>        - const: pmc
>        - const: wake
>        - const: aotag
> -      - const: scratch
> +      - enum: [ scratch, misc ]
>        - const: misc
>  
>    interrupt-controller: true
> @@ -41,25 +41,63 @@ properties:
>      description: If present, inverts the PMU interrupt signal.
>      $ref: /schemas/types.yaml#/definitions/flag
>  
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        const: nvidia,tegra186-pmc
> -then:
> -  properties:
> -    reg:
> -      maxItems: 4
> -
> -    reg-names:
> -      maxItems: 4
> -else:
> -  properties:
> -    reg:
> -      minItems: 5
> -
> -    reg-names:
> -      minItems: 5
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra186-pmc
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 4
> +        reg-names:
> +          items:
> +            - const: pmc
> +            - const: wake
> +            - const: aotag
> +            - const: scratch

There is no need to define the names and order again. Just this is 
sufficient:

maxItems: 4
contains:
  const: scratch

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra194-pmc
> +    then:
> +      properties:
> +        reg:
> +          minItems: 5
> +        reg-names:
> +          items:
> +            - const: pmc
> +            - const: wake
> +            - const: aotag
> +            - const: scratch
> +            - const: misc

Just 'minItems: 5' is sufficient here.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra234-pmc
> +    then:
> +      properties:
> +        reg:
> +          minItems: 4
> +          maxItems: 5

That should already be the top-level constraint.

> +        reg-names:
> +          anyOf:
> +            - items:
> +                - const: pmc
> +                - const: wake
> +                - const: aotag
> +                - const: misc
> +            - items:
> +                - const: pmc
> +                - const: wake
> +                - const: aotag
> +                - const: scratch
> +                - const: misc

Only need:

contains:
  const: misc

