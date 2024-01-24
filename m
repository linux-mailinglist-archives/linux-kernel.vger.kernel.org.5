Return-Path: <linux-kernel+bounces-37450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC32F83B034
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DDB28206D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038F8615A;
	Wed, 24 Jan 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GTartNSV"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E886C86129;
	Wed, 24 Jan 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118035; cv=none; b=PCwAaIPuGKsMghXVKZuugIwvJusiwcM7jYsC2jX5BSaiXxo1fJZzxpr9jb5xbPymmodsE32LQ1a5bRsxixOayFb/rE7oZUkitVmmeWO5tbOiDU1FZkHp7+JHw18gcMYsdxS6LkH32K++PQa3qr2y9T/a+9qYJeCrs/Vj7MdovrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118035; c=relaxed/simple;
	bh=8gQF0U6eHH6iUkLw6yhHPNLgdvAzk3OMbv/DK+aIbko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTHisE8fRoTsZnE1tO5SypMqEqWyQIFGLZKA9C0gQaUQUcplwTuJg/WvRjRt8qJr5NuOIDhhyPQGDe2MdQUN3YL/u7j+LuifJ0VUVL//4uSO/ymPwkt1oUqly99VLxvIggTUk2gJNEFa4IAh21k4XLWE3EsO5nVC5g8Xvk/9Fmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GTartNSV; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DCF851BF20E;
	Wed, 24 Jan 2024 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706118030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9fxvXwre8RvANs3toNyR8cUFT2cBUQEnb6nLZSDgnE=;
	b=GTartNSV42U1nllXnMMP3aHwlGI/uQS1npcEBCAhl82CqzmhpWZyy0umHbMQZvndvILcei
	+MzcRQdSS1m/SffVGt+DBHi1UneiynjaI+ZoON+wxOloCR1MWHkivqQcex1aGBj2A4otll
	BKR/wB/kNds+aHS8FpUH6HuTLci1NVg33cDOFWLZV+H+RaIadaxRap2pgvkPlgtMunlB6r
	pCCb/fPnrzaV1a6Iz7PjlF9c0IXZ7Xr8iup3NuWDjy6TqJ1akkpsAuYCEc2DbHQdrTmdhI
	v9okB9VMwgbEDboKsfT0uyjTvjB7gPsEWBA7obVIB1ACu54CKMnVzexPyged5g==
Date: Wed, 24 Jan 2024 18:40:27 +0100
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
Subject: Re: [PATCH v3 10/10] mtd: rawnand: brcmnand: allow for on-die ecc
Message-ID: <20240124184027.712b1e47@xps-13>
In-Reply-To: <20240124030458.98408-11-dregan@broadcom.com>
References: <20240124030458.98408-1-dregan@broadcom.com>
	<20240124030458.98408-11-dregan@broadcom.com>
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

dregan@broadcom.com wrote on Tue, 23 Jan 2024 19:04:58 -0800:

> Allow settings for on-die ecc such that if on-die ECC is selected
> don't error out but require ECC strap setting of zero
>=20
> Signed-off-by: David Regan <dregan@broadcom.com>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>
> ---
> Changes in v3: None
> ---
> Changes in v2:
> - Added to patch series
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index a4e311b6798c..42526f3250c9 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -2727,9 +2727,11 @@ static int brcmnand_setup_dev(struct brcmnand_host=
 *host)
>  	cfg->blk_adr_bytes =3D get_blk_adr_bytes(mtd->size, mtd->writesize);
> =20
>  	if (chip->ecc.engine_type !=3D NAND_ECC_ENGINE_TYPE_ON_HOST) {
> -		dev_err(ctrl->dev, "only HW ECC supported; selected: %d\n",
> -			chip->ecc.engine_type);
> -		return -EINVAL;
> +		if (chip->ecc.strength) {
> +			dev_err(ctrl->dev, "ERROR!!! HW ECC must be set to zero for non-hardw=
are ECC; selected: %d\n",
> +				chip->ecc.strength);

Can you use a more formal string? Also clarify it because I don't
really understand what it leads to.

> +			return -EINVAL;
> +		}
>  	}
> =20
>  	if (chip->ecc.algo =3D=3D NAND_ECC_ALGO_UNKNOWN) {
> @@ -2797,7 +2799,11 @@ static int brcmnand_setup_dev(struct brcmnand_host=
 *host)
>  	if (ret)
>  		return ret;
> =20
> -	brcmnand_set_ecc_enabled(host, 1);
> +	if (chip->ecc.engine_type =3D=3D NAND_ECC_ENGINE_TYPE_ON_DIE) {
> +		dev_dbg(ctrl->dev, "Disable HW ECC for on-die ECC\n");

Not needed.

> +		brcmnand_set_ecc_enabled(host, 0);
> +	} else
> +		brcmnand_set_ecc_enabled(host, 1);

Style is wrong, but otherwise I think ECC should be kept disabled while
not in active use, so I am a bit surprised by this line.

> =20
>  	brcmnand_print_cfg(host, msg, cfg);
>  	dev_info(ctrl->dev, "detected %s\n", msg);


Thanks,
Miqu=C3=A8l

