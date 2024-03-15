Return-Path: <linux-kernel+bounces-104629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8171C87D13D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45591C20CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D722628FC;
	Fri, 15 Mar 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5gZGKH4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15465D29B;
	Fri, 15 Mar 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520571; cv=none; b=jfb9gijzL7N9mue7HbYIN34zw/Mr0gUDMNPn2REOGKQbgI+rHtn1x9P2D7HxPCJL8IDDlprOKO/TtjursAo6OGyOu1SgT00u7yXrGqm1I/cVl+/lC4m1gHdeVVjNE5HyZu9VJnzOS3uVX6Kq+8v3oMwF8NSOd57OVaHNoGupuKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520571; c=relaxed/simple;
	bh=5szkVEXe0ekaYiJWoeSLGaHsidYU+VV3wwTnpAmCoFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GukwoziJumCG5eW2FFY8AB1vU/T0ArOgQDqjf9gduRsjq5t+c7Jb9ASoP0IaNP0WWQ1O5WyDrtol151MyR15JUDCg6qVNs8FWXA54xoE/cMVwDB4FDmT6+lO3mGi/299swygGmrUDOi+xv+NxWQN5/DyWR5lePt1RyMePUQMbpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5gZGKH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F74C433F1;
	Fri, 15 Mar 2024 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710520569;
	bh=5szkVEXe0ekaYiJWoeSLGaHsidYU+VV3wwTnpAmCoFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5gZGKH4u/iN1Yqk/CcmFVJsWIdVx4yRHC1F9Og9J1iru3arWK5PhESTZvEuiGzP1
	 DL07X+Jxl7H8PxRz4Wy1FbvMdrG1g/mi3vczhVQ6mCT0Nfbh/RBiEQW5gQQ4VcCKAA
	 MtP/TXEoxpQG5XO870KxWKn/CO4+waojEqfpW9kFaonMbEj6QXFSj+kISsNGt0LJ6E
	 joxqWbJm//5lI/RtUp20LA8KoQ82hhIn7DGxi6miGwCXBgZYNpIiSMlv8vYlbSQk2g
	 V21mBUNo+FYllTyrQUSoaJbBD1gau2Slnk/Vhpy6rBMNGFs1zrW1YFO1rl7qvfL7gB
	 AWmBd4bsSERVQ==
Date: Fri, 15 Mar 2024 10:36:07 -0600
From: Rob Herring <robh@kernel.org>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	geert+renesas@glider.be, prabhakar.mahadev-lad.rj@bp.renesas.com,
	conor.dooley@microchip.com, alexghiti@rivosinc.com,
	evan@rivosinc.com, ajones@ventanamicro.com, heiko@sntech.de,
	guoren@kernel.org, uwu@icenowy.me, jszhang@kernel.org,
	conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, leyfoon.tan@starfivetech.com,
	jeeheng.sia@starfivetech.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: cache: Add docs for StarFive
 StarLink-500 cache controller
Message-ID: <20240315163607.GA1444248-robh@kernel.org>
References: <20240314061205.26143-1-joshua.yeong@starfivetech.com>
 <20240314061205.26143-5-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314061205.26143-5-joshua.yeong@starfivetech.com>

On Thu, Mar 14, 2024 at 02:12:05PM +0800, Joshua Yeong wrote:
> Add DT binding documentation used by StarFive's
> Starlink-500 cache controller.
> 
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> ---
>  .../cache/starfive,starlink-500-cache.yaml    | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cache/starfive,starlink-500-cache.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cache/starfive,starlink-500-cache.yaml b/Documentation/devicetree/bindings/cache/starfive,starlink-500-cache.yaml
> new file mode 100644
> index 000000000000..97ddf7db39e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cache/starfive,starlink-500-cache.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cache/starfive,starlink-500-cache.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive StarLink-500 Cache Controller
> +
> +maintainers:
> +  - Joshua Yeong <joshua.yeong@starfivetech.com>
> +
> +description:
> +  StarFive's StarLink-500 controller manages cache shared between clusters of
> +  CPU cores. The cache driver provides mechanism to perform invalidate and write
> +  back functionality to the shared memory.

What a driver does is not relevant to the binding. You could describe 
what the registers control though.

> +
> +allOf:
> +  - $ref: /schemas/cache-controller.yaml#
> +
> +# We need a select here so we don't match all nodes with 'cache'
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - starfive,starlink-500-cache
> +
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: starfive,starlink-500-cache
> +      - const: cache
> +
> +  reg:
> +    maxItems: 1
> +
> +  cache-size: true
> +  cache-sets: true
> +  cache-block-size: true
> +  cache-level: true
> +  cache-unified: true

Drop these and...

> +
> +additionalProperties: false

.. use 'unevaluatedProperties' instead.

> +
> +required:
> +  - compatible
> +  - reg

cache-unified should be required as I imagine the cache is always 
unified. Perhaps other properties too (cache-level already is)?

> +
> +examples:
> +  - |
> +      cache-controller@15000000 {
> +        compatible = "starfive,starlink-500-cache", "cache";
> +        reg = <0x15000000 0x278>;
> +        cache-block-size = <64>;
> +        cache-level = <3>;
> +        cache-sets = <8192>;
> +        cache-size = <0x400000>;
> +        cache-unified;
> +      };
> -- 
> 2.25.1
> 

