Return-Path: <linux-kernel+bounces-108524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB810880BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 408D9B21FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673C51EEE7;
	Wed, 20 Mar 2024 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R6H1BQAo"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E11EB20;
	Wed, 20 Mar 2024 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918471; cv=none; b=fymL0h8amq7w8ZI4PamaUXNXpKERaoQYlg3ReXTrvmGBSf7kxqzzHPONiO9KxBss9ciY3/XHU0+0dFaZi4aDw57ulwCsRT42a2+1A9xbcHA9IuvaothKGI1fVvkuOu+ka+b16jSuIQR5AQA1TuLVEbuHrWOGb4DXJxVx2NYKhwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918471; c=relaxed/simple;
	bh=id+YrcKzvPn+roLxUhcmy08zTVa12BwyuqXaxnIsJ0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mkzswf/a4zix6f+zMwba+Bp5X0M5/z41RM4CwUjofaV8FbppjpiMz3lAPsz/U9OXh0hQRwpZALCblCzmjFTvYw/e2WEt47VyJfkdrm3JbFtuVvaUn1177GV2DWTd7bI84C+mVPxmZfMhdtOP+gJJVbG8dA+yRziIey/bLeOvgog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R6H1BQAo; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A01A020003;
	Wed, 20 Mar 2024 07:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710918459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AL30gxN2yDxjzqImljq77WKx4g//YWKGdQLQDyEKupE=;
	b=R6H1BQAoVXPekaFsRtzSoEQBULpxTVygeQ5dgqe41dUWGbQm3BwMbL/BkjcYVigscVk7cW
	93TzuvNn/tzdDUEFGKQiEaJr0dmWsCJkzO42E0MIt+gB3EkUgIcNzrNDwvjjulQqDJV1iC
	7TghrDUA50RUSI84CT6HanpAWNattl09gNrGskDLdup3YatpyrIdwBROO2dIGgDmYx5Kis
	qclT1+rueoDo0Q/12GvPbQ7eE41u9AZgd/FQ8xr/nkdyWBsHEYK3dacjF4UXMhvgbyhSCd
	yfozFtxn4bnKbjSFrQ31rCw7AcR/dVzivfHP+vi6tK4oFVKSqkXkaBchU9Ih9g==
Date: Wed, 20 Mar 2024 08:07:37 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, Md Sadre Alam
 <quic_mdalam@quicinc.com>, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: qcom: Fix broken misc_cmd_type in exec_op
Message-ID: <20240320080737.00e7bb37@xps-13>
In-Reply-To: <20240320001141.16560-1-ansuelsmth@gmail.com>
References: <20240320001141.16560-1-ansuelsmth@gmail.com>
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

Hi Christian,

ansuelsmth@gmail.com wrote on Wed, 20 Mar 2024 01:11:39 +0100:

> misc_cmd_type in exec_op have multiple problems. With commit a82990c8a409
> ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
> reworked and generalized but actually dropped the handling of the
> RESET_DEVICE command.
>=20
> The rework itself was correct with supporting case where a single misc
> command is handled, but became problematic by the addition of exiting
> early if we didn't had an ERASE or an OP_PROGRAM_PAGE operation.
>=20
> Also additional logic was added without clear explaination causing the
> erase command to be broken on testing it on a ipq806x nandc.
>=20
> Add some additional logic to restore RESET_DEVICE command handling and
> fix erase command.
>=20
> Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec=
_op path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qco=
m_nandc.c
> index b079605c84d3..b8cff9240b28 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2815,7 +2815,7 @@ static int qcom_misc_cmd_type_exec(struct nand_chip=
 *chip, const struct nand_sub
>  			      host->cfg0_raw & ~(7 << CW_PER_PAGE));
>  		nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
>  		instrs =3D 3;
> -	} else {
> +	} else if (q_op.cmd_reg !=3D OP_RESET_DEVICE) {
>  		return 0;
>  	}
> =20
> @@ -2830,9 +2830,8 @@ static int qcom_misc_cmd_type_exec(struct nand_chip=
 *chip, const struct nand_sub
>  	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> =20
>  	write_reg_dma(nandc, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
> -	(q_op.cmd_reg =3D=3D OP_BLOCK_ERASE) ? write_reg_dma(nandc, NAND_DEV0_C=
FG0,
> -	2, NAND_BAM_NEXT_SGL) : read_reg_dma(nandc,
> -	NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> +	if (q_op.cmd_reg =3D=3D OP_BLOCK_ERASE)
> +		write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);

Ugh. How did that went through...

I don't want to get into the details of this controller, but the fix
looks legitimate.

>  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>  	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);


Thanks,
Miqu=C3=A8l

