Return-Path: <linux-kernel+bounces-14256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA2B821A0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C683282FFA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D8BEAF5;
	Tue,  2 Jan 2024 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MkugAq/n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D659DF78
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA2D21BF207;
	Tue,  2 Jan 2024 10:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704191889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dD/7vrp7PobLXT38gn14ZFy05WSFmJZV0dJfDmvXWWw=;
	b=MkugAq/n3uM4OqEQwTq+Sdy2Wq4rqMTOHhKGGp05cyzvbwP+BIGAaG1BkXK6/vcArPorrx
	FoGa92KcNRVU2jiAmr5qQhCxO57rNuu4rC1WAl7gWYGFYgFIjQ4qKTRZUSePnfDOaJzWeq
	9/s94EXdNPWOHtgjLV9nmnkwUPdGZoPY7ZLFCxxxgEf0w/bSKyqLRODjx9N162eVa1LNeO
	M8M+NXzadTH3aQkBaYijCWjjUYSl8aLeoYXAXuJIHNmJ3DO7pZgL6JtHCtVvehb5dr033b
	zE6JUPzC7PNAwY+F1SYJ1CPabqqlLLrUmxV9qX07QLFqVeZePzLVl/f6BN3fYA==
Date: Tue, 2 Jan 2024 11:38:06 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Elad Nachman <enachman@marvell.com>
Cc: <richard@nod.at>, <vigneshr@ti.com>, <vadym.kochan@plvision.eu>,
 <aviramd@marvell.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: marvell: fix layouts
Message-ID: <20240102113806.3fa88503@xps-13>
In-Reply-To: <20231231174950.3272727-1-enachman@marvell.com>
References: <20231231174950.3272727-1-enachman@marvell.com>
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

Hi Elad,

enachman@marvell.com wrote on Sun, 31 Dec 2023 19:49:50 +0200:

> From: Elad Nachman <enachman@marvell.com>
>=20

Please fix your mailer because this paragraph is way too small (<50
chars!).

> Check in nand_base.c, nand_scan_tail() :
> if (ecc->steps * ecc->size !=3D mtd->writesize)
> Fails for some NAND chips.
> Remove entries which cannot create integral
> multiplications, and adjust the number of chunks
> for entries which fails the above calculation to
> calculate correctly (this was previously done
> automatically before the check).

I'm okay with that.

> Also fix spacing of the said table.

No, please don't do this in the same commit, it becomes totally
unreadable.

Please keep the spacing as it is, or if you want to change the spacing,
keep additional spaces so that it is easily readable by keeping clear
columns.

>=20
> Fixes: 68c18dae6888 ("mtd: rawnand: marvell: add missing layouts")

Please add:

Cc: stable@vger.kernel.org

> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  drivers/mtd/nand/raw/marvell_nand.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c
> index a46698744850..21f4469b5cda 100644
> --- a/drivers/mtd/nand/raw/marvell_nand.c
> +++ b/drivers/mtd/nand/raw/marvell_nand.c
> @@ -285,21 +285,18 @@ struct marvell_hw_ecc_layout {
> =20
>  /* Layouts explained in AN-379_Marvell_SoC_NFC_ECC */
>  static const struct marvell_hw_ecc_layout marvell_nfc_layouts[] =3D {
> -	MARVELL_LAYOUT(  512,   512,  1,  1,  1,  512,  8,  8,  0,  0,  0),
> -	MARVELL_LAYOUT( 2048,   512,  1,  1,  1, 2048, 40, 24,  0,  0,  0),
> -	MARVELL_LAYOUT( 2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
> -	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,32, 30),
> -	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024,  0, 30,1024,64, 30),
> -	MARVELL_LAYOUT( 2048,   512,  12, 3,  2, 704,   0, 30,640,  0, 30),
> -	MARVELL_LAYOUT( 2048,   512,  16, 5,  4, 512,   0, 30,  0, 32, 30),
> -	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
> -	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
> -	MARVELL_LAYOUT( 4096,   512,  12, 6,  5, 704,   0, 30,576, 32, 30),
> -	MARVELL_LAYOUT( 4096,   512,  16, 9,  8, 512,   0, 30,  0, 32, 30),
> -	MARVELL_LAYOUT( 8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
> -	MARVELL_LAYOUT( 8192,   512,  8,  9,  8, 1024,  0, 30,  0, 160, 30),
> -	MARVELL_LAYOUT( 8192,   512,  12, 12, 11, 704,  0, 30,448,  64, 30),
> -	MARVELL_LAYOUT( 8192,   512,  16, 17, 16, 512,  0, 30,  0,  32, 30),
> +	MARVELL_LAYOUT(512,   512,  1,  1,  1,  512,  8,  8,  0,  0,  0),
> +	MARVELL_LAYOUT(2048,   512,  1,  1,  1, 2048, 40, 24,  0,  0,  0),
> +	MARVELL_LAYOUT(2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
> +	MARVELL_LAYOUT(2048,   512,  8,  2,  1, 1024,  0, 30, 1024, 32, 30),
> +	MARVELL_LAYOUT(2048,   512,  8,  2,  1, 1024,  0, 30, 1024, 64, 30),
> +	MARVELL_LAYOUT(2048,   512,  16, 4,  4, 512,   0, 30,  0, 32, 30),
> +	MARVELL_LAYOUT(4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
> +	MARVELL_LAYOUT(4096,   512,  8,  4,  4, 1024,  0, 30,  0, 64, 30),
> +	MARVELL_LAYOUT(4096,   512,  16, 8,  8, 512,   0, 30,  0, 32, 30),
> +	MARVELL_LAYOUT(8192,   512,  4,  4,  4, 2048,  0, 30,  0,  0,  0),
> +	MARVELL_LAYOUT(8192,   512,  8,  8,  8, 1024,  0, 30,  0, 160, 30),
> +	MARVELL_LAYOUT(8192,   512,  16, 16, 16, 512,  0, 30,  0,  32, 30),
>  };
> =20
>  /**


Thanks,
Miqu=C3=A8l

