Return-Path: <linux-kernel+bounces-67082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8808565F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EADA1F25219
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0A131E59;
	Thu, 15 Feb 2024 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnwrRn4Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60612EBD4;
	Thu, 15 Feb 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007326; cv=none; b=u30p8pQX03dMvqSdJhso4nUsfJpXQ23dY/2XVNU4SCIx34TIbCTrhEra8X4dr0oGOIGtfqKYXHJKawevDdN7jNpV1+WAo4w+y3yw5KagJOMrnhCTISx2zPPbp2F3H3NaZtOIK0CXkmRgYviKp4Uc7p/eBRQGprkKZkTDtSVeAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007326; c=relaxed/simple;
	bh=Wf73cxr87GHpuYxipFrmEqJpur94FjNtOwVM6tDrmHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRLr7rJjfijgw+w7PVkcU79G29YuH2IsIldHhMcnAVGDEIyAySYcQRjJwSCqPwbnzoJfip4iicuvT9YIchdfCTDOxi23kRykeqk2HX0CUzACW/jqjS9kO5GRp8+g9tet7hFdTRcyZE9mRYr/DmAbE8uDlSUQpLYiN3Vumjw+wEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnwrRn4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E47C433F1;
	Thu, 15 Feb 2024 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708007326;
	bh=Wf73cxr87GHpuYxipFrmEqJpur94FjNtOwVM6tDrmHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OnwrRn4YKZaN4o1RuqeBymMAMru8kHE4Q7Da3aedo1qE+afwhoWtdDqJtOIdPWKgw
	 gQvyrUrqgOnWGPZ8/Qgu959Z3QHSL8emHdN4LSum5F2q+AOImwwJWUtxDRwS/V6NFt
	 IOIjYalS6OCk1hpZ9ib+aTK9CXfLC7i9svg2cimI9AZ5Gn9rA5fOZtr0PsWyDtAb9e
	 UP6WsTWcu0klLjyEGsrTOgn4OZeKLWmwxP0PEvgDQra4BCCDFE9lbdwG8ex0YOlxoi
	 FGFl2LjoTrW3gTrV2auku35SWYgHg/5nMzk9odSNesFJDa+gvBenTcg0Pwvd5a6wi6
	 rr5Vo/HIhkmvw==
Date: Thu, 15 Feb 2024 08:28:36 -0600
From: Rob Herring <robh@kernel.org>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, clabbe@baylibre.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, vadim.fedorenko@linux.dev,
	linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
Subject: Re: [PATCH v4 16/20] dt-bindings: crypto: meson: support new SoC's
Message-ID: <20240215142836.GA1186-robh@kernel.org>
References: <20240212135108.549755-1-avromanov@salutedevices.com>
 <20240212135108.549755-17-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212135108.549755-17-avromanov@salutedevices.com>

On Mon, Feb 12, 2024 at 04:51:04PM +0300, Alexey Romanov wrote:
> Now crypto module available at G12A/G12B/S4/A1/SM1/AXG.
> 
> 1. Add new compatibles:
>   - amlogic,g12a-crypto
>   - amlogic,s4-crypto (uses g12a-crypto as fallback)
>   - amlogic,a1-crypto (uses g12a-crypto as fallback)
>   - amlogic,axg-crypto
> 
> 2. All SoC's, exclude GXL, doesn't take a clock input for
> Crypto IP. Make it required only for amlogic,gxl-crypto.
> 
> 3. All SoC's, exclude GXL, uses only one interrupt flow
> for Crypto IP.
> 
> 4. Add power-domains in schema.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  .../bindings/crypto/amlogic,gxl-crypto.yaml   | 43 ++++++++++++++++---
>  1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> index 948e11ebe4ee..41f0153d58c8 100644
> --- a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> +++ b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> @@ -11,20 +11,30 @@ maintainers:
>  
>  properties:
>    compatible:
> -    items:
> -      - const: amlogic,gxl-crypto
> +    oneOf:
> +      - items:
> +          - enum:
> +              - amlogic,a1-crypto
> +              - amlogic,s4-crypto
> +          - const: amlogic,g12a-crypto
> +      - enum:
> +          - amlogic,gxl-crypto
> +          - amlogic,axg-crypto
> +          - amlogic,g12a-crypto
>  
>    reg:
>      maxItems: 1
>  
>    interrupts:
> -    items:
> -      - description: Interrupt for flow 0
> -      - description: Interrupt for flow 1
> +    minItems: 1
> +    maxItems: 2

Just keep the descrptions here and add 'minItems: 1'. Then in the 
if/then schema, you only need minItems and maxItems to require 1 or 2 
interrupts.

>  
>    clocks:
>      maxItems: 1
>  
> +  power-domains:
> +    maxItems: 1
> +
>    clock-names:
>      const: blkmv
>  
> @@ -32,8 +42,27 @@ required:
>    - compatible
>    - reg
>    - interrupts
> -  - clocks
> -  - clock-names

New chips work without clocks? Cool!

Rob

