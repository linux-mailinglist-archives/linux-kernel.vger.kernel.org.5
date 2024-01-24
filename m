Return-Path: <linux-kernel+bounces-37439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9FE83B017
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A367428DC67
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFA786AF8;
	Wed, 24 Jan 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nmJQe8B2"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69168613D;
	Wed, 24 Jan 2024 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117537; cv=none; b=kda3Aw/kigbGjXi78HoAlQoBLc7qicv1nPl0VwOlwY7tle7CW/3nrqr5Da4dbqhDhpygMrOKqs0QDS50N68uJSzrY2nNkIoACIAis+RW4pL5H0g6WOH2c+QGj/shRhvuZt+mycZfP9jv83o5Basx0u2YkfCErb8jd/6CwLotJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117537; c=relaxed/simple;
	bh=TxZ56d8Oz9RWmCGvMMps0htj1F9xyGSeaGqs7QVJ/lA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImQZh0UVeAKhWhCiPXsK3PZOu14f3ZldUjSWxkGO4WqWN67wC4R4iBq2u/e707ZPxpbHdooCggYBjxocVUWaeFdZh1nhWA1ApwFNsCZDwYTeSUDmoMwjTkCzCnuZAIeQf6fLyvnvZSyUlkfYjSZql0jqQov23HHqxXmLLsSBMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nmJQe8B2; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B943E1BF207;
	Wed, 24 Jan 2024 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706117532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNQYUSii9IjmdDn/Eb+hTpvR6w3u80ExSZv/+b1sAR0=;
	b=nmJQe8B2zb5cM/dskpVL/QljwU7tZ7EygdQYNJY5H+r6ur3QxzLR63BdYwrVGVBAAVz8oE
	f4dDfPhiZjkkSClGTfGwZ0hmYQdv0Kti0MciANI+m95RAwbnYuSvSmkdJdu5gO35Jtfwaw
	+vEoi1MuBYArur6IIgtKv1KMLdBcDN7helz+kEfosN7n5SvVxDzogQ6GMbPvB4jaHw2aai
	qGYALCoCVhbp91Py7SzTrj1m2dx42VJZkUDdC4KyUVJU17OONEjIhbgdMkjmSGCqOhLyr8
	zy2/DvI4Q55fFqygmXd6kauIiykFiMA1B8P8Zfvu9zBkqdEECPQ243YCargCdA==
Date: Wed, 24 Jan 2024 18:32:07 +0100
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
Subject: Re: [PATCH v3 06/10] mtd: rawnand: brcmnand: Add support for
 getting ecc setting from strap
Message-ID: <20240124183207.5898cbfd@xps-13>
In-Reply-To: <20240124030458.98408-7-dregan@broadcom.com>
References: <20240124030458.98408-1-dregan@broadcom.com>
	<20240124030458.98408-7-dregan@broadcom.com>
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

> @@ -2622,19 +2667,43 @@ static int brcmnand_setup_dev(struct brcmnand_hos=
t *host)
>  		nanddev_get_memorg(&chip->base);
>  	struct brcmnand_controller *ctrl =3D host->ctrl;
>  	struct brcmnand_cfg *cfg =3D &host->hwcfg;
> -	char msg[128];
> +	struct device_node *np =3D nand_get_flash_node(chip);
>  	u32 offs, tmp, oob_sector;
> -	int ret;
> +	int ret, sector_size_1k =3D 0;
> +	bool use_strap =3D false;
> +	char msg[128];
> =20
>  	memset(cfg, 0, sizeof(*cfg));
> +	use_strap =3D of_property_read_bool(np, "brcm,nand-ecc-use-strap");
> =20
> -	ret =3D of_property_read_u32(nand_get_flash_node(chip),
> -				   "brcm,nand-oob-sector-size",
> +	/*
> +	 * Set ECC size and strength based on hw configuration from strap
> +	 * if device tree does not specify them and use strap property is set
> +	 * If ecc strength is set in dts, don't use strap setting.
> +	 */

You would have to use the strap settings only if the property is set.
If not property is set, the default from the core should apply I guess.

> +	if (chip->ecc.strength)
> +		use_strap =3D 0;
> +
> +	if (use_strap) {
> +		chip->ecc.strength =3D brcmnand_get_ecc_strength(host);
> +		sector_size_1k =3D brcmnand_get_sector_size_1k(host);
> +		if (chip->ecc.size =3D=3D 0) {
> +			if (sector_size_1k < 0)
> +				chip->ecc.size =3D 512;
> +			else
> +				chip->ecc.size =3D 512 << sector_size_1k;
> +		}
> +	}
> +
> +	ret =3D of_property_read_u32(np, "brcm,nand-oob-sector-size",
>  				   &oob_sector);
>  	if (ret) {
> -		/* Use detected size */
> -		cfg->spare_area_size =3D mtd->oobsize /
> -					(mtd->writesize >> FC_SHIFT);
> +		if (use_strap)
> +			cfg->spare_area_size =3D brcmnand_get_spare_size(host);
> +		else
> +			/* Use detected size */
> +			cfg->spare_area_size =3D mtd->oobsize /
> +						(mtd->writesize >> FC_SHIFT);
>  	} else {
>  		cfg->spare_area_size =3D oob_sector;
>  	}


Thanks,
Miqu=C3=A8l

