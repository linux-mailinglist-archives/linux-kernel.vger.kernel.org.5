Return-Path: <linux-kernel+bounces-135411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B8489C0F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227D31C21BB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3927A71B3D;
	Mon,  8 Apr 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TYiyMgXw"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E074BE8;
	Mon,  8 Apr 2024 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581867; cv=none; b=tJc7k/sscsZmQCmB9pJ3x+tUVwlowV6d/STuoua71wkTyM4U7r2KUYucnzX7TViVEyrz+kZ+3ZmTHo+QAd9XDVUn3/rPCu+riddPtqL93tBA4Z7+tNOOHLlx3uUz7U5jLbgCfl1KZ7y2NKeVxzPNDlu04Ne7U9Y9KsbIjB6VRpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581867; c=relaxed/simple;
	bh=zV6jZJfotqWfBpmLY5Cg4KAuWzuvUJvpwq8D8Ks3bGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haYmxfCRulCTYbXdai9qX4mi/mDTaL8f60He5h15mpbQjU7SFSi5NVQ7tnxy8ygsBOoe9ZbjM2g+JUkvyTT0f1VRFMUo49RfDBE4A/J0xKquKrv97tvGy1+UwZ5GTl1pcrHaccNuOmV12oMfzveLoJSzzlJ+8vjJX6dl9INv3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TYiyMgXw; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A7F71BF209;
	Mon,  8 Apr 2024 13:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712581862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irIHF5I8mXyLCKw8dni+/EZgNZOMISZkd0b9zPdDuaU=;
	b=TYiyMgXw+kQUQbK4L36ZVzZLv2VElfGQi5RM0DQOm15l7UTgnBnIa2WeyMU64WSAuJk3Hg
	CNMMw3B0XKX+E9glwfXqm0qIbnWAoc95Ny5x9NI8vCCv8xmSmGkyu9RgpHJWDTIeNIUYGR
	vCx6aUkoYFE/V4erY7lNKihCMVCNJcx88NGbr7t0aif/OiDlpaRqjJ6fjbrAZZJs4PXK/N
	El0IMjmjarmPGeFprPCSVP9ppKT+1ikNUOiLQ+5FkfQf2enZx+VhvkG9Vxju0XkMvKz5xJ
	a8ZJlglJfwPz3UzatjI5SXuHUCy8OF1MlrvbLMTZlW//jpCc2Dxo6QuRFQH0zw==
Date: Mon, 8 Apr 2024 15:10:57 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, Michael Walle <mwalle@kernel.org>, U-Boot
 Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Rob
 Herring <robh@kernel.org>, linux-mtd@lists.infradead.org, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/2] dt-bindings: mtd: fixed-partitions: Add
 alignment properties
Message-ID: <20240408151057.1d1fcfb3@xps-13>
In-Reply-To: <20240326200645.1182803-1-sjg@chromium.org>
References: <20240326200645.1182803-1-sjg@chromium.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Simon,

sjg@chromium.org wrote on Tue, 26 Mar 2024 14:06:44 -0600:

> Add three properties for controlling alignment of partitions, aka
> 'entries' in fixed-partition.
>=20
> For now there is no explicit mention of hierarchy, so a 'section' is
> just the 'fixed-partitions' node.
>=20
> These new properties are inputs to the Binman packaging process, but are
> also needed if the firmware is repacked, to ensure that alignment
> constraints are not violated. Therefore they are provided as part of
> the schema.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>=20
> Changes in v10:
> - Update the minimum to 2
>=20
> Changes in v9:
> - Move binding example to next batch to avoid build error
>=20
> Changes in v7:
> - Drop patch 'Add binman compatible'
> - Put the alignment properties into the fixed-partition binding
>=20
> Changes in v6:
> - Correct schema-validation errors missed due to older dt-schema
>   (enum fix and reg addition)
>=20
> Changes in v5:
> - Add value ranges
> - Consistently mention alignment must be power-of-2
> - Mention that alignment refers to bytes
>=20
> Changes in v2:
> - Fix 'a' typo in commit message
>=20
>  .../bindings/mtd/partitions/partition.yaml    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.y=
aml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> index 1ebe9e2347ea..656ca3db1762 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> @@ -57,6 +57,57 @@ properties:
>        user space from
>      type: boolean
> =20
> +  align:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 2
> +    maximum: 0x80000000
> +    multipleOf: 2
> +    description:
> +      This sets the alignment of the entry in bytes.
> +
> +      The entry offset is adjusted so that the entry starts on an aligned
> +      boundary within the containing section or image. For example =E2=
=80=98align =3D
> +      <16>=E2=80=99 means that the entry will start on a 16-byte boundar=
y. This may
> +      mean that padding is added before the entry. The padding is part of
> +      the containing section but is not included in the entry, meaning t=
hat
> +      an empty space may be created before the entry starts. Alignment
> +      must be a power of 2. If =E2=80=98align=E2=80=99 is not provided, =
no alignment is
> +      performed.
> +
> +  align-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 2
> +    maximum: 0x80000000
> +    multipleOf: 2
> +    description:
> +      This sets the alignment of the entry size in bytes. It must be a p=
ower
> +      of 2.
> +
> +      For example, to ensure that the size of an entry is a multiple of =
64
> +      bytes, set this to 64. While this does not affect the contents of =
the
> +      entry within binman itself (the padding is performed only when its
> +      parent section is assembled), the end result is that the entry ends
> +      with the padding bytes, so may grow. If =E2=80=98align-size=E2=80=
=99 is not provided,
> +      no alignment is performed.

I don't think we should mention binman here. Can we have a software
agnostic description? This should be understandable from anyone playing
with mtd partitions I guess.

> +
> +  align-end:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 2
> +    maximum: 0x80000000
> +    multipleOf: 2

seems not to perfectly match the constraint, but I don't know if there
is a powerOf keyword? (same above)

> +    description:
> +      This sets the alignment (in bytes) of the end of an entry with res=
pect
> +      to the containing section. It must be a power of 2.
> +
> +      Some entries require that they end on an alignment boundary,
> +      regardless of where they start. This does not move the start of the
> +      entry, so the contents of the entry will still start at the beginn=
ing.
> +      But there may be padding at the end. While this does not affect the
> +      contents of the entry within binman itself (the padding is perform=
ed

content?				same comment about binman?

> +      only when its parent section is assembled), the end result is that=
 the
> +      entry ends with the padding bytes, so may grow. If =E2=80=98align-=
end=E2=80=99 is not
> +      provided, no alignment is performed.
> +
>  if:
>    not:
>      required: [ reg ]


Thanks,
Miqu=C3=A8l

