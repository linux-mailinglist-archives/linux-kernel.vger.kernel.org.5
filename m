Return-Path: <linux-kernel+bounces-72756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFA385B85D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F43FB247ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB34960ED1;
	Tue, 20 Feb 2024 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cvDEEtdu"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03C160BBA;
	Tue, 20 Feb 2024 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423003; cv=none; b=PBcXs+RrX+zZC4jNdyhIr+sxbqfaO05wN2OGoFZvVpYLT8sYrHPL3FjWelaQgPBU28AtE2AfzmsOCuX3MDVaak5au0LcNWGPhBZSZUDUXD5RxLi0D+/A9dQAkZlUaskiVy7/JTanqPYU+/GvdCAFZtgkstuDscgp868TDKlN1CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423003; c=relaxed/simple;
	bh=4Q+Eytv8Lqu7vRaPxXLCovjvrNp3hPC/myttHLGJDFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBQYOICMQY9+TJdLj1YNqWUn0SQeI1smEgkRu7MvK60yY8+Tpz794RN+shjB92+15l0+EVVEky/9c/IPhBMeQZ1U+tOlHVLuWPZRaPK9j+phzssZe3HfN+4EOQ0/jEUCfM7PGpb7C1EXVPU+9U4jt9pDTz2aq8gUbk37ku5Y0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cvDEEtdu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29EB1240005;
	Tue, 20 Feb 2024 09:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708422998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8vYmz20JtDfNNRe27+16Y9GfbpnqV9b0nYEvIzUvwE=;
	b=cvDEEtdujSkBM0JSloT0c+vkmgUHZKt59K6583zRWp+UHoVJtv9nUKuxOEXRMkwbgse7Ue
	Yg0earM/LIN0c6sfqzrIsNEZAuGsti2YXWLMqBpgJCi79h8JaYPySLLK8QlQSlEM70T1B6
	BSH6wRyz362bRgFHuRYZ4ry8o3AZY7MHONQZxBgu6wHLdYChFn9Vwp8LtI/Qj/juQQUIx4
	kihISrkrWTksIIg+AwQdNwzcs4bV284PdTRhCL1oOYyrF1gtk57A7fAzxmiIgHLH7vhIwE
	tHViXT0j+R43onIFmbbVlXZ7CiEP4fPVURi7oTK/zjaaX1R/A5/DPa1qRHDJHg==
Date: Tue, 20 Feb 2024 10:56:34 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: William Zhang <william.zhang@broadcom.com>
Cc: Linux MTD List <linux-mtd@lists.infradead.org>, Linux ARM List
 <linux-arm-kernel@lists.infradead.org>, Broadcom Kernel List
 <bcm-kernel-feedback-list@broadcom.com>, f.fainelli@gmail.com,
 kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 devicetree@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Richard Weinberger <richard@nod.at>, Kamal Dasu
 <kdasu.kdev@gmail.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 03/12] dt-bindings: mtd: brcmnand: Add ecc strap
 property
Message-ID: <20240220105634.02b505b6@xps-13>
In-Reply-To: <20240207202257.271784-4-william.zhang@broadcom.com>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
	<20240207202257.271784-4-william.zhang@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi William,

william.zhang@broadcom.com wrote on Wed,  7 Feb 2024 12:22:48 -0800:

> Add brcm,nand-ecc-use-strap to get ecc and spare area size settings from
> board boot strap for broadband board designs because they do not specify
> ecc setting in dts but rather using the strap setting.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>=20
> ---
>=20
> Changes in v5:
> - Update the description for this ecc strap property
> - Add check to make sure brcm,nand-ecc-use-strap and
>   nand-ecc-strength/brcm,nand-oob-sector-size can not be used at the
>   same time
>=20
> Changes in v4:
> - Move ecc strap property to this separate patch and remove some
> non-binding related text from the description
>=20
> Changes in v3: None
> Changes in v2: None
>=20
>  .../bindings/mtd/brcm,brcmnand.yaml           | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/D=
ocumentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> index 6a717bcedfd3..52a4c993b6f1 100644
> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> @@ -146,6 +146,13 @@ patternProperties:
>            layout.
>          $ref: /schemas/types.yaml#/definitions/uint32
> =20
> +      brcm,nand-ecc-use-strap:
> +        description:
> +          This property requires the host system to get the ECC strength
> +          and step size from the SoC NAND boot strap setting. This is a
> +          common hardware design on BCMBCA based boards.
> +        $ref: /schemas/types.yaml#/definitions/flag
> +
>      unevaluatedProperties: false
> =20
>  allOf:
> @@ -195,6 +202,18 @@ allOf:
>        required:
>          - interrupt-names
> =20
> +  - if:
> +      patternProperties:
> +        "^nand@[a-f0-9]$":
> +          required:
> +            - brcm,nand-ecc-use-strap
> +    then:
> +      patternProperties:
> +        "^nand@[a-f0-9]$":
> +          properties:
> +            nand-ecc-strength: false
> +            brcm,nand-oob-sector-size: false

Can you also excluse all the other nand-ecc- settings and brcm,
settings as well? Either you use the strap *or* you provide values in
the DT, but not both.

> +
>  unevaluatedProperties: false
> =20
>  required:


Thanks,
Miqu=C3=A8l

