Return-Path: <linux-kernel+bounces-58805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06BD84EC48
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DED51C236DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEC450244;
	Thu,  8 Feb 2024 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGm3mTcF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA364F89C;
	Thu,  8 Feb 2024 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707433838; cv=none; b=O/S3bQ0LCLknuAVFdZ8zrVMwuBt9ofG2GEdBcYv07Md1zLa0Lgc30gI0XMuN28ClyyX7nVxrcKdMMlDBpvvLRkpm9qAI9Dn0ISgPkSIARB/qu2vX2WYFZzu/5TJfEwGwkcULbEK11OOlQdkRdoLatYCyab3MjWhujkYDO131PEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707433838; c=relaxed/simple;
	bh=lhdos3/FRVCViIYt/3y2jkHpoKfTqfy0DuWlvx2WQuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ3bPnh7+WfF2WSGx5d73UeIuwavKdTufhC1HwhMU/gkjAUdM+idsbELUAYOH2osk/4nN8bXVoeqsdhXsqjs6lHhR+8yOjux51F8PGtSXXU7iuIGI0NShonevxJS2zHMlFFi84vAyizY9BUyUV1uGkFuX666LmaSm0sV4X8HCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGm3mTcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3EBC433F1;
	Thu,  8 Feb 2024 23:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707433837;
	bh=lhdos3/FRVCViIYt/3y2jkHpoKfTqfy0DuWlvx2WQuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGm3mTcFrkS2QGE9MXtwhMYYXQl8c8mTcrcz0MzZAAp8VhfZq1+jKWnmi2zSmaGpS
	 sWxsOdjh4L/QZArLu9nZrG6+0lFPcHm0JkDbjUVSkivEO7uyl6J9GjBC0Opw/XWnOe
	 r6AsAAVm909sz6mXdBFCn8+Zl1pY5ZtuP47vUucRJF/LLKhcvo8tf1zw2fGDQEeyoc
	 lKLItCpSu4f2hdRBKwmteNPCnIaf+EhOkKgoU1v7AljcmoxAzk17AyTJlZOaJ2MkbT
	 SOHd29Q6S2kIdkFtJmbbGWwRVThZTLgbZxA3O5z4Z4Fi4knuY29TGKyIngWNkVZt80
	 ht/PBAb6pGkbQ==
Date: Thu, 8 Feb 2024 23:10:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: tglx@linutronix.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert Atmel AIC to
 json-schema
Message-ID: <20240208-daintily-craftsman-c7f514d49c0f@spud>
References: <20240208092015.263210-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BfuxVjJMfQvJA03G"
Content-Disposition: inline
In-Reply-To: <20240208092015.263210-1-dharma.b@microchip.com>


--BfuxVjJMfQvJA03G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Dharma,

Overall this looks alright, but I have a few comments for you.

On Thu, Feb 08, 2024 at 02:50:15PM +0530, Dharma Balasubiramani wrote:

> diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
> new file mode 100644
> index 000000000000..396eac53da3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/atmel,aic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Advanced Interrupt Controller (AIC)
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Dharma balasubiramani <dharma.b@microchip.com>
> +
> +description: |

The chomping operator, |, is not needed here as you have no formatting
to preserve.

> +  The Advanced Interrupt Controller (AIC) is an 8-level priority, individually
> +  maskable, vectored interrupt controller providing handling of up to one
> +  hundred and twenty-eight interrupt sources.

> It is designed to substantially
> +  reduce the software and real-time overhead in handling internal and external
> +  interrupts.

This reeks of a marketing statement and should be removed IMO.

> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91rm9200-aic
> +      - atmel,sama5d2-aic
> +      - atmel,sama5d3-aic
> +      - atmel,sama5d4-aic
> +      - microchip,sam9x60-aic
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 3
> +    description: |
> +      The 1st cell is the IRQ number (Peripheral IDentifier on datasheet).
> +      The 2nd cell specifies flags:
> +        bits[3:0] trigger type and level flags:
> +          1 = low-to-high edge triggered.
> +          2 = high-to-low edge triggered.
> +          4 = active high level-sensitive.
> +          8 = active low level-sensitive.
> +        Valid combinations: 1, 2, 3, 4, 8.

Shame that these are not aligned with the IRQ_TYPE defines :(

> +        Default for internal sources: 4 (active high).
> +      The 3rd cell specifies irq priority from 0 (lowest) to 7 (highest).
> +
> +  interrupts:

> +    description: Interrupt source of the parent interrupt controller.

Drop the description, it's obvious.

> +    maxItems: 1
> +
> +  reg:

A nit, but I would put reg after compatible.

> +    description: Specifies base physical address(s) and size of the AIC registers.

Same here.

> +    maxItems: 1
> +
> +  atmel,external-irqs:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: u32 array of external irqs.
> +
> +required:
> +  - compatible
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - reg

A nit, but I would put reg after compatible

> +  - atmel,external-irqs
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    /* AIC */

Drop the comment, its obvious.

> +    aic: interrupt-controller@fffff000 {

The node name here is not used, drop it.

> +      compatible = "atmel,at91rm9200-aic";
> +      interrupt-controller;
> +      #interrupt-cells = <3>;
> +      reg = <0xfffff000 0x200>;
> +      atmel,external-irqs = <31>;
> +    };
> +

> +  - |
> +    /* An interrupt generating device that is wired to an AIC. */
> +    dma: dma-controller@ffffec00 {
> +      compatible = "atmel,at91sam9g45-dma";
> +      #dma-cells = <2>;
> +      reg = <0xffffec00 0x200>;
> +      interrupts = <21 4 5>;
> +    };

And delete this whole example :)

Cheers,
Conor.


--BfuxVjJMfQvJA03G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcVfaAAKCRB4tDGHoIJi
0qFfAP9f7CgCDfdt+jqCp1hlMsB/4vlKyCAoGb92Hen1sqXizQEAsOMwh1LtoGiK
xxGnS6Su5F3v+hfMCZFYXGdNFOwDoQY=
=tsS3
-----END PGP SIGNATURE-----

--BfuxVjJMfQvJA03G--

