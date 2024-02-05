Return-Path: <linux-kernel+bounces-52719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50B8849BD7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699D41F2446D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27271CD05;
	Mon,  5 Feb 2024 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZI6aDvze"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F081CD1C;
	Mon,  5 Feb 2024 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139972; cv=none; b=d430USeu6lis8gAfnfcCap38mCjECnB2kg6s39F3Jf9ao3GXPzJgGJrpFUTIk2K8gsHPqF4eZnqMSfajDciCKqJS0Oa7T3CSYJra9f3rwAF+Gpy51WKP3zjDbQ8rtOcr0HObR0TCNqFqdfrBVzyn9uCw5N4BY0zwkj3oWzn1ASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139972; c=relaxed/simple;
	bh=HWm28kdbG2bw3TeeNcZwzfshOWPZDIfup7xJaZlsBu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VupoDGEIivzT+bMweedRPGK3Wgc0Iy7jNB7EB71LyTAAs2q/PS+Kw9pS8/WpzVIr4CoGu9p/Ltnz7bDUaZFxNQlfXLZ+qXKsXj3CPJQlz7V1o5OfD6Xh2qNnFyFT6d4JzuVCsDqNSN7bHQOSj99HBcotakDu5BjSWmd3ADCXkWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZI6aDvze; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D384FF809;
	Mon,  5 Feb 2024 13:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707139968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=koe9bjcAN33voyRHmbaxK/dVbeKGFFFrjtmLDWOmCww=;
	b=ZI6aDvzem4bJwwgbG1O4FDdd8g4QYZqNsTqWtLPfd0LebqWxmQSUeW8/mJhuLLZNaf+Fix
	snlRDLbbL531U8mYjvQfHaqAXpNavizDZc7xVtsebKqelDzOqHb+cQQv/9nLneGJBtMDNR
	IquYlZzG3mIULBGlcU5LqwKz0UYZk9Lv1zouCXJdAqYp/G5Pm2r2nTERY8JZngMI0bCF1j
	WRRcqpMOiRhleJ3KR9/P3NUPNqGDj2liA4aKj3O11Im7RFfYusR6XsWp+Zz1fqhd5R1dGr
	gnzOWZmYAhU3c5qS5Wbo+SpZWuPUb+YWozNE0hzcgKvQo04BoauF4oLYBjHDbQ==
Date: Mon, 5 Feb 2024 14:32:46 +0100
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
Subject: Re: [PATCH v4 02/12] dt-bindings: mtd: brcmnand: Add WP pin
 connection property
Message-ID: <20240205143246.52ee97ec@xps-13>
In-Reply-To: <20240203002834.171462-3-william.zhang@broadcom.com>
References: <20240203002834.171462-1-william.zhang@broadcom.com>
	<20240203002834.171462-3-william.zhang@broadcom.com>
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

william.zhang@broadcom.com wrote on Fri,  2 Feb 2024 16:28:23 -0800:

> Add brcm,wp-not-connected property to have an option for disabling this
> feature on broadband board design that does not connect WP pin.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>=20
> ---
>=20
> Changes in v4:
> - Move the WP pin property to this separate patch and change it to
> boolean type.
>=20
> Changes in v3: None
> Changes in v2: None
>=20
>  Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/D=
ocumentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> index e54ca08a798a..d0168d55c73e 100644
> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> @@ -113,6 +113,14 @@ properties:
>        earlier versions of this core that include WP
>      type: boolean
> =20
> +  brcm,wp-not-connected:
> +    description:
> +      Use this property when board design does not connect controller's
> +      NAND_WPb pin to NAND chip's WP_L pin and disable the write
> +      protection feature. By default, controller assumes the pin is
> +      connected and feature is used.

I would rephrase slightly. What about:

	 WP pin is not physically wired to the NAND chip. Write
	 protection feature cannot be used.
=20
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
>  patternProperties:
>    "^nand@[a-f0-9]$":
>      type: object


Thanks,
Miqu=C3=A8l

