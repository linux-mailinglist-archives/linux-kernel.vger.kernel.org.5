Return-Path: <linux-kernel+bounces-73599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3E485C4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2A11F216F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1B814A0A4;
	Tue, 20 Feb 2024 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tD5Wzn2W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7876C89;
	Tue, 20 Feb 2024 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457579; cv=none; b=QmG0yPqRSlNJZqqQOW/WkybPtaOEHvWnkVwMffmTNUhE5KwyeZCtRuH2Pf0rNzifCKaVlcV9gj2lHO+EGhBXWiWbIrBolmO0gdKg78Ryv1XZFAElsXLex4LqAGOIdYfVvnHCwFDnWQh8k8VWl//QAd/ehc9F1m8MlzagAtD9b2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457579; c=relaxed/simple;
	bh=oh3mnkgCiDFEq+VN0OlXRtz7LZpJZL9+ukyJd0pym7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffQ+3HWoTz2inMiNAj6miQ7q5a9kPMZV1KIfjoYfiujivCIuhWa9GNX2MYTofpT3c2FZrFJbep0O2EGRO1UU8NJBPhuUxuDvxejosXr3+y/PGA4htWdtYNC0ewrYJav53RLPlKI01Defag7S4jwB4kkn5y8EUiCuRclk1f2AJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tD5Wzn2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315CAC433F1;
	Tue, 20 Feb 2024 19:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708457578;
	bh=oh3mnkgCiDFEq+VN0OlXRtz7LZpJZL9+ukyJd0pym7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tD5Wzn2WfXP4QmxHXbXUwRvuJE+2tpeXaIi1RCGdvYReWLwCjVoWRfQxgjutp6ZE/
	 B1sQlivkpTLjoCBjxsgIHdsxq4TNLxmmXxGN6kHIG1XT1ocOZXquCrMXEVUE0cOX86
	 AFXvm0Vdc2gGAWxRCdh7ztBNtULtFzumG6/Q6fk6sws5b9Op+FzqON4OTUn2HtMcDL
	 ur7sI/QLuI1N9QM0ADdl+QDKBtAS0BoR9lYhUMYS6ZzRHUqjNijMu9hp9btvEbiPGD
	 jtsKDQkw6D2YI5k25Pj2rlyF6VIlv/XTDBsL13vpnaREOnQCvTpUkgy1GlgFPGFbDW
	 olP/ZJFPMT5uw==
Date: Tue, 20 Feb 2024 19:32:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma.B@microchip.com
Cc: robh@kernel.org, tglx@linutronix.de, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema
Message-ID: <20240220-carmaker-subprime-112c44f4f2e6@spud>
References: <20240209100122.61335-1-dharma.b@microchip.com>
 <20240212140824.GA107736-robh@kernel.org>
 <003d61c9-b914-4e1c-b3f8-1140ea640039@microchip.com>
 <20240213-estranged-charger-bf0372f367e0@spud>
 <a97650cd-8e06-4df6-9757-826c00a4d7cc@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oixT++1NaGaSoyb2"
Content-Disposition: inline
In-Reply-To: <a97650cd-8e06-4df6-9757-826c00a4d7cc@microchip.com>


--oixT++1NaGaSoyb2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 03:30:52PM +0000, Dharma.B@microchip.com wrote:
> Hi Rob and Conor,
>=20
> On 14/02/24 12:43 am, Conor Dooley wrote:
> > On Tue, Feb 13, 2024 at 04:23:36AM +0000,Dharma.B@microchip.com  wrote:
> >> On 12/02/24 7:38 pm, Rob Herring wrote:
> >>> On Fri, Feb 09, 2024 at 03:31:22PM +0530, Dharma Balasubiramani wrote:
> >>>> +  atmel,external-irqs:
> >>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >>>> +    description: u32 array of external irqs.
> >>> Constraints on the array size and/or entry values?
> >> The hardware's support for external IRQs may differ, which is why a u32
> >> array is utilized. This choice is based on the fact that IRQ numbers a=
re
> >> commonly expressed as integers, and a 32-bit unsigned integer provides=
 a
> >> standardized size capable of representing a broad range of numbers. Th=
is
> >> size is more than adequate for accommodating IRQ numbering.
> > I don't think Rob was questioning your use of u32s, but rather the fact
> > that you do not limit the values at all nor the number of values.
>=20
> The peripheral identification defined at the product level corresponds=20
> to the interrupt source number.
>=20
> SoC           External Interrupts    Peripheral ID
> AT91RM9200    - IRQ0=E2=80=93IRQ6            25 - 31
> SAMA5D2       - IRQ0=E2=80=93IRQn            49
> SAMA5D3       - IRQ0=E2=80=93IRQn            47
> SAMA5D4       - IRQ0=E2=80=93IRQn            56
> SAM9x60       - IRQ0=E2=80=93IRQn            31
>=20
> To reflect these constraints in bindings, I intend to make the following=
=20
> changes.
>=20
>    atmel,external-irqs:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      description: u32 array of external irqs.

>      if:
>        properties:
>          compatible:
>            contains:
>              const: atmel,at91rm9200-aic
>      then:
>        minItems: 1
>        maxItems: 7
>      else:
>        minItems: 1
>        maxItems: 1

Just to point out, that if this is not psuedocode, the syntax here is
not quite right. It should be:

allOf:
- if:
    properties:
      compatible:
        contains:
          const: atmel,at91rm9200-aic
  then:
    properties:
      atmel,external-irqs:
        minItems: 1
        maxItems: 7
  else:
    properties:
      atmel,external-irqs:
        minItems: 1
        maxItems: 1

But you can simply this further by applying minItems: 1 & maxitems: 7
to the property directly and just setting maxItems: 1 when the
compatible is not atmel,at91rm9200-aic.

There should be plenty of examples in-tree for you to copy this sort of
thing from - clock-names is a property you often see this used for.

Cheers,
Conor.

--oixT++1NaGaSoyb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdT+ZQAKCRB4tDGHoIJi
0tWrAQDA0M79FYs8kBO/dXhIdEIyv//B1MOZxFKmHMtCxqGsBgEAzc28f4+CT8Lc
fmXrS1VSSFmNnFNCBsISOsq7MNz8WwY=
=EMPj
-----END PGP SIGNATURE-----

--oixT++1NaGaSoyb2--

