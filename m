Return-Path: <linux-kernel+bounces-72764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F285B872
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5A51F23518
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681D660BBA;
	Tue, 20 Feb 2024 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JScQNfoG"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA95D745
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423294; cv=none; b=V4vXd2Cjgk6y77wkCZGzy1B1f1vhABGQjleNnvRXnQC3EmzLyDvcOE7JbMV9HHeTOEL1MoRNohHlXiUHyhmyj6ytbAq7sSFkipJ6nanoPQNcNyigqVDm67yOISMSCpDleG5+6uR8RrTWPN7YePyhX1P2lsFK6aEugCmjo9YOgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423294; c=relaxed/simple;
	bh=z9GZDpHK4nEBZTaVpDGBn7u07katCtHDDqS3OYKIwJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmrm6QZ2BN8XgCj/pYqgaN5ReHl2vUWMplZSiUch/RY9QJz6lQqpbeTnncrzD6u1Go55RMxUwiMcUiFgk5aBa/3kcRVZX1UKT8iqbT8xDTCAG+qSylWuywKLUw4dxJHBt8yux6K1grlWTx3Jq8CLB4hTip0jPp0TAOc5j/9VdjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JScQNfoG; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47CEF20015;
	Tue, 20 Feb 2024 10:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708423290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLJjwyWcAA92P8/mQkEbJc7X1g1TkiGOhieOujelkek=;
	b=JScQNfoGuwPh8Gycp9Jpo1bd6uRBdCwt/WKZNDRY7e0EmTjtWumU/Yx97kLCbNEaDK5pX+
	pZwKsKvwpVc8lUCbhFU4E6d1/vp4WLOOfjgFITNityg37EtyDYp110ov3AKj3RSVQt81r7
	Ui4YT40hStXZXm2WIMVgt+Mg361jvx++g5j4mqcl+LI3yoW0S7E5GiWr6GUk/PPLvlr73h
	5ngIgQDodDQwGjtVdBMNggpB7Lpb1yHaD2p6qIrMHpaNZSyv9UvLHuWHT1Eh2jmPiJRYDL
	zjUor/AtVDNL/6zT5hQPGfqD4Yo1ItaLpUaTU/kbpN5LbcGLAZkgj8EMco6+Pw==
Date: Tue, 20 Feb 2024 11:01:28 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: William Zhang <william.zhang@broadcom.com>
Cc: Linux MTD List <linux-mtd@lists.infradead.org>, Linux ARM List
 <linux-arm-kernel@lists.infradead.org>, Broadcom Kernel List
 <bcm-kernel-feedback-list@broadcom.com>, f.fainelli@gmail.com,
 kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com, David Regan
 <dregan@broadcom.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>, Brian
 Norris <computersforpeace@gmail.com>, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v5 11/12] mtd: rawnand: brcmnand: exec_op helper
 functions return type fixes
Message-ID: <20240220110128.3cadbcc2@xps-13>
In-Reply-To: <20240207202257.271784-12-william.zhang@broadcom.com>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
	<20240207202257.271784-12-william.zhang@broadcom.com>
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

Hi,

william.zhang@broadcom.com wrote on Wed,  7 Feb 2024 12:22:56 -0800:

> From: David Regan <dregan@broadcom.com>
>=20
> fix return type for exec_op reset and status detect helper functions

Please make a correct sentence (Fic, detect?, '.').

> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: http://lists.infradead.org/pipermail/linux-mtd/2023-December/1024=
23.html
> Fixes: 3c8260ce7663 ("mtd: rawnand: brcmnand: exec_op implementation")
> Signed-off-by: David Regan <dregan@broadcom.com>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>
>=20
> ---
>=20
> Changes in v5: None
> Changes in v4:
> - Fix the commit id in the fixes tag
>=20
> Changes in v3: None
> Changes in v2:
> - Added to patch series
>=20
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index 8c1489ff7bd6..7ce2b267676f 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -625,7 +625,7 @@ enum {
>  /* Only for v7.2 */
>  #define	ACC_CONTROL_ECC_EXT_SHIFT		13
> =20
> -static u8 brcmnand_status(struct brcmnand_host *host);
> +static int brcmnand_status(struct brcmnand_host *host);
> =20
>  static inline bool brcmnand_non_mmio_ops(struct brcmnand_controller *ctr=
l)
>  {
> @@ -1749,7 +1749,7 @@ static int brcmnand_waitfunc(struct nand_chip *chip)
>  				 INTFC_FLASH_STATUS;
>  }
> =20
> -static u8 brcmnand_status(struct brcmnand_host *host)
> +static int brcmnand_status(struct brcmnand_host *host)
>  {
>  	struct nand_chip *chip =3D &host->chip;
>  	struct mtd_info *mtd =3D nand_to_mtd(chip);
> @@ -1760,7 +1760,7 @@ static u8 brcmnand_status(struct brcmnand_host *hos=
t)
>  	return brcmnand_waitfunc(chip);
>  }
> =20
> -static u8 brcmnand_reset(struct brcmnand_host *host)
> +static int brcmnand_reset(struct brcmnand_host *host)
>  {
>  	struct nand_chip *chip =3D &host->chip;
> =20
> @@ -2492,11 +2492,14 @@ static int brcmnand_exec_op(struct nand_chip *chi=
p,
> =20
>  	if (brcmnand_op_is_status(op)) {
>  		status =3D op->instrs[1].ctx.data.buf.in;
> -		*status =3D brcmnand_status(host);
> +		ret =3D brcmnand_status(host);
> +		if (ret < 0)
> +			return ret;
> +
> +		*status =3D ret & 0xFF;
> =20
>  		return 0;
> -	}
> -	else if (brcmnand_op_is_reset(op)) {
> +	} else if (brcmnand_op_is_reset(op)) {

This is another change, please make it in another patch. Also while you
are at it, there are probably other checkpatch warnings that can be
fixed, if you want.

>  		ret =3D brcmnand_reset(host);
>  		if (ret < 0)
>  			return ret;


Thanks,
Miqu=C3=A8l

