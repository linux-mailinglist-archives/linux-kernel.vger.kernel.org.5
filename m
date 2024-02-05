Return-Path: <linux-kernel+bounces-52733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5145C849C07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B501C238B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222BC2C6A6;
	Mon,  5 Feb 2024 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EtlhRWyV"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441322C69E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140270; cv=none; b=h2sKS7EklwWxOodHZcxpn/FfFN4nUuC1hfo+FvWAgwOe350gtWFp1A3tg2jPHLWFhGPhI10JRkc0yA6qbeao76Xo8wQmxI1LHC32V97tKkPRhg0ZlvDbXYM4GNStutnQEyB6zr5JEHsl4CFtMrCwnH9Za1uKnSApC7x0oNfGaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140270; c=relaxed/simple;
	bh=cHUZ/eF2WFsbMSiWzBOdb1vrE66W5fGdpXU05l1SVmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4JjaCCCLOfXrh6dzjP1gOKcImshvDm8zEorwX/caZUgKqj9qbAhpRzxOur7sdX/LNY/fXoco/k9rgbCcMd3zGItYCbyp7FEhGjlOfdUmqvHqFx8BJkOfnV6v/DsZkNRitEGO25jYPf/T1CCULSkQNfMuCqfE+DTuppc3hn7QSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EtlhRWyV; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0B28FF80A;
	Mon,  5 Feb 2024 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707140266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gmo5Tbcnd6hBEUVcUcmoKYDOTr9Bxvr6QlF36iEzjhg=;
	b=EtlhRWyVcFv1F7humVGz3aiopPeU08j0j0yTyAWqwlRpiX/iskZcIkrWV1wrbMbXY4/XlJ
	df769TiJpjYY4SZiuixWyXdOyIWumHD8EKT9rdMD9IOPavyTN123AA8r3n5y7QmCLNLPSO
	Z0Z49HLKbZyI9vKeMdauBBK0cxtBnHtO+tTzO/fmFjGkNmvB65pEk58ziHOu8xGB7ntqlM
	rjLiX8o0y4y/uBPOrl+LCf3uEsZFO7QMYdlq2PiDloz6U8Q9avHtACUARwdFypyaQfZpPm
	kAxXeF+xjKYacRIxHwMxlTGs0OwMfQelzOGJbpqCQm3gB8FqeOTZMJzqXlKy8g==
Date: Mon, 5 Feb 2024 14:37:45 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: William Zhang <william.zhang@broadcom.com>
Cc: Linux MTD List <linux-mtd@lists.infradead.org>, Linux ARM List
 <linux-arm-kernel@lists.infradead.org>, Broadcom Kernel List
 <bcm-kernel-feedback-list@broadcom.com>, f.fainelli@gmail.com,
 kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com, David Regan
 <dregan@broadcom.com>, linux-kernel@vger.kernel.org, Vignesh Raghavendra
 <vigneshr@ti.com>, Brian Norris <computersforpeace@gmail.com>, Richard
 Weinberger <richard@nod.at>
Subject: Re: [PATCH v4 12/12] mtd: rawnand: brcmnand: update log level
 messages
Message-ID: <20240205143745.5a1036c6@xps-13>
In-Reply-To: <20240203002834.171462-13-william.zhang@broadcom.com>
References: <20240203002834.171462-1-william.zhang@broadcom.com>
	<20240203002834.171462-13-william.zhang@broadcom.com>
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

william.zhang@broadcom.com wrote on Fri,  2 Feb 2024 16:28:33 -0800:

> From: David Regan <dregan@broadcom.com>
>=20
> Update log level messages so that more critical messages
> can be seen.

This commit log does not convince me. Warning messages are visible,
they are in dmesg. If you want them on your console, lower your default
console level by 1 and they will appear. I'm fine increasing the log
level on error messages, but the justification cannot be specific to
your own setup.

>=20
> Signed-off-by: David Regan <dregan@broadcom.com>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>
>=20
> ---
>=20
> Changes in v4:
> - Revert the log level change for correctable ecc error
>=20
> Changes in v3: None
> Changes in v2:
> - Added to patch series
>=20
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index 7ce2b267676f..e50582b45182 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -1143,7 +1143,7 @@ static int bcmnand_ctrl_poll_status(struct brcmnand=
_host *host,
>  	if ((val & mask) =3D=3D expected_val)
>  		return 0;
> =20
> -	dev_warn(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
> +	dev_err(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
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
>  			(unsigned long long)err_addr);
>  		mtd->ecc_stats.failed++;
>  		/* NAND layer expects zero on ECC errors */


Thanks,
Miqu=C3=A8l

