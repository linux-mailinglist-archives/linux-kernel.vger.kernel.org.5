Return-Path: <linux-kernel+bounces-37446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1746383B026
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C422F287902
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5DD85C6F;
	Wed, 24 Jan 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HIZ2SCf4"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DF280058;
	Wed, 24 Jan 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117835; cv=none; b=dn9CqEMAhUbASOpWYdVoWkd5pFjvj5/8SF5TanSDKkHRU41C/SUR+/H7ws+s/4xfOdeT93S3vJqL1/irT0fgOGp6sFCSp7MR42e6Atiq37osVgoJh4bpfXWQ5xZ2+E7+Ki7Bb9M9A/IoysnrH19bXoKv0W/V47bbSsuIMv9FOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117835; c=relaxed/simple;
	bh=5Q/X4BDx+OG4wno+JjCLue6X1fnbnCnSvHwdDvEfpYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8b6cWLwfUUFf7puaLq1uSx1V6cVfyB6PzWiVKzjm2au32gwnALdaMghkt8SjHQoONq33Aa7nvfNozNiX5Uo+gF2vR4cToL9t1AnhB6vFD0odTt8DuR2QAX5NIoQPBJeOCbwtdyCRlRLGAg5oQIIy11HEoZQ/s/niCaLaU3Cdqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HIZ2SCf4; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A1FE40004;
	Wed, 24 Jan 2024 17:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706117831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/BxeLszBNs63fVi69FVb8KqYEuY2QieBZcGTh/0vEI=;
	b=HIZ2SCf4+7ftfgx4u1xCkua32iokQNJ47AhhJaVPBQFeB822hQ7YXyCjJFpFXzgNokY+W/
	Q6G7aSePGb7embqemWmm3LHXoVmlj4VCawnBg8j4Xere/BdIHtHbb7rsejhFpxU2HmXrm2
	pb+brT4jNMn/wglyIHUGG/+5wWQVyPfnwA0fKG7gD2BkZzsBCwUyoG5WJ4gobOxjEtvjxm
	9uWaB8XedUejmplB022E9J9Pqx8yoGiUjB7OlmfdYAcSlC1L/UfHsQYvxxP9kC+kK2MsPM
	yUR3IGzNSwWXTqlpNpGVmDSsGyGLR6i7tdprJynKRENVVxL92ZSv14KjE2jQFQ==
Date: Wed, 24 Jan 2024 18:37:06 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: David Regan <dregan@broadcom.com>
Cc: dregan@mail.com, richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 computersforpeace@gmail.com, kdasu.kdev@gmail.com,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, joel.peshkin@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 william.zhang@broadcom.com, anand.gore@broadcom.com,
 kursad.oney@broadcom.com, florian.fainelli@broadcom.com, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andre.przywara@arm.com,
 baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org,
 dan.carpenter@linaro.org
Subject: Re: [PATCH v3 09/10] mtd: rawnand: brcmnand: update log level
 messages
Message-ID: <20240124183706.0af8fb90@xps-13>
In-Reply-To: <20240124030458.98408-10-dregan@broadcom.com>
References: <20240124030458.98408-1-dregan@broadcom.com>
	<20240124030458.98408-10-dregan@broadcom.com>
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

Hi David,

dregan@broadcom.com wrote on Tue, 23 Jan 2024 19:04:57 -0800:

> Update log level messages so that more critical messages
> can be seen.
>=20
> Signed-off-by: David Regan <dregan@broadcom.com>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>
> ---
> Changes in v3: None
> ---
> Changes in v2:
> - Added to patch series
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index 6b5d76eff0ec..a4e311b6798c 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -1143,7 +1143,7 @@ static int bcmnand_ctrl_poll_status(struct brcmnand=
_host *host,
>  	if ((val & mask) =3D=3D expected_val)
>  		return 0;
> =20
> -	dev_warn(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
> +	dev_err(ctrl->dev, "timeout on status poll (expected %x got %x)\n",

I don't see the point but if you want.

>  		 expected_val, val & mask);
> =20
>  	return -ETIMEDOUT;
> @@ -2196,7 +2196,7 @@ static int brcmnand_read(struct mtd_info *mtd, stru=
ct nand_chip *chip,
>  				return err;
>  		}
> =20
> -		dev_dbg(ctrl->dev, "uncorrectable error at 0x%llx\n",
> +		dev_err(ctrl->dev, "uncorrectable error at 0x%llx\n",

Upper layer will complain, you can keep this at the debug level.

>  			(unsigned long long)err_addr);
>  		mtd->ecc_stats.failed++;
>  		/* NAND layer expects zero on ECC errors */
> @@ -2211,7 +2211,7 @@ static int brcmnand_read(struct mtd_info *mtd, stru=
ct nand_chip *chip,
>  			err =3D brcmnand_read_by_pio(mtd, chip, addr, trans, buf,
>  						   oob, &err_addr);
> =20
> -		dev_dbg(ctrl->dev, "corrected error at 0x%llx\n",
> +		dev_info(ctrl->dev, "corrected error at 0x%llx\n",

Definitely not! Way too verbose. Please keep this one as it is.

>  			(unsigned long long)err_addr);
>  		mtd->ecc_stats.corrected +=3D corrected;
>  		/* Always exceed the software-imposed threshold */


Thanks,
Miqu=C3=A8l

