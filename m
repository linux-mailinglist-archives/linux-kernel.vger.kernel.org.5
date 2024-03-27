Return-Path: <linux-kernel+bounces-121650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE82088EBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00421C2F66D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D0914D431;
	Wed, 27 Mar 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OlCqOZhR"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806E412F5A2;
	Wed, 27 Mar 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558299; cv=none; b=cUhoFSGz99CY8g0Aw8Oqn6C9H7CEdRIKeUZEL7CqQN/SLfx+DOt0Xj8uJskZvVjz090MpeOgaip0yWiKFNc9wzCF6109UN3IFrHxi9Mxtrb9o+lggt+jFxSGnOkwbTPk5kng7IDmu055qja8/LU//aSmwSjtaibwfoWt8I7JpXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558299; c=relaxed/simple;
	bh=LM8sbbiZKaeBPMakgJ3MutVIXuYeOb/HCEs0DQyWv2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZ2nGNmNo43CkXIDmLuAheSjYZsFmkdsiTQFgP060ixXj5gIOves2qUeGUltiKzQrvaUoYY79o9fJvZaISdIbRRiwH9NCnnRBNFtBwBRqMusFp/wrsHuJlxzxGFSAlzXSz1wh4MQcgeKu5qKaaDJhQhrLDQYNPCG7jvisM6iUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OlCqOZhR; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B652240008;
	Wed, 27 Mar 2024 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711558294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dkDsTM+CyF3T1RfUsZvTaGtiJGxz0u7kuWWxBLiq70=;
	b=OlCqOZhRUE+LEglVKAzyRaIJnfHwR7NpVwTLoTmHNcTFLc1l2Ze/9ictqKZcclr3fbO0nE
	JFO/Ll9eSZm0QJZUc7JFGocaYue1wLCziUiLa/3wRMVohIQ2NLg7RI87xwUd3YtaU+owPM
	Vll6eIkZQFjuJGT1soHhKBI2DemQ2JnZx3vT1lIb+F2cQ2AuT2ZTc9LDO+/YBI6d+FnvGW
	kDbQt4FW3pInjRk5kBdRExWdgGsNnLTQbx3ypV2enI06lf+G8BbHC05YFWikJ+bJHQBIA+
	7arwt6GAfJQ/f6JD3pTIs/h0gSnDzYG4vuEA8A/B3CVYNpBvSNN/iujE0U5JhA==
Date: Wed, 27 Mar 2024 17:51:31 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Md
 Sadre Alam <quic_mdalam@quicinc.com>, Sricharan Ramabadhran
 <quic_srichara@quicinc.com>, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mtd: rawnand: qcom: Fix broken erase in
 misc_cmd_type in exec_op
Message-ID: <20240327175131.3c0100c3@xps-13>
In-Reply-To: <66044bea.050a0220.dee16.c250@mx.google.com>
References: <20240325103053.24408-1-ansuelsmth@gmail.com>
	<20240326072512.GA8436@thinkpad>
	<66044bea.050a0220.dee16.c250@mx.google.com>
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

Hi,

ansuelsmth@gmail.com wrote on Wed, 27 Mar 2024 16:20:58 +0100:

> On Tue, Mar 26, 2024 at 12:55:12PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Mar 25, 2024 at 11:30:47AM +0100, Christian Marangi wrote: =20
> > > misc_cmd_type in exec_op have multiple problems. With commit a82990c8=
a409
> > > ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
> > > reworked and generalized but actually broke the handling of the
> > > ERASE_BLOCK command.
> > >=20
> > > Additional logic was added to the erase command cycle without clear
> > > explaination causing the erase command to be broken on testing it on
> > > a ipq806x nandc.
> > >=20
> > > Fix the erase command by reverting the additional logic and only addi=
ng
> > > the NAND_DEV0_CFG0 additional call (required for erase command).
> > >=20
> > > Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in =
exec_op path")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > > Changes v2:
> > > - Split this and rework commit description and title
> > >=20
> > >  drivers/mtd/nand/raw/qcom_nandc.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw=
/qcom_nandc.c
> > > index b079605c84d3..19d76e345a49 100644
> > > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > > @@ -2830,9 +2830,8 @@ static int qcom_misc_cmd_type_exec(struct nand_=
chip *chip, const struct nand_sub
> > >  	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> > > =20
> > >  	write_reg_dma(nandc, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
> > > -	(q_op.cmd_reg =3D=3D OP_BLOCK_ERASE) ? write_reg_dma(nandc, NAND_DE=
V0_CFG0,
> > > -	2, NAND_BAM_NEXT_SGL) : read_reg_dma(nandc,
> > > -	NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> > > +	if (q_op.cmd_reg =3D=3D OP_BLOCK_ERASE)
> > > +		write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL); =20
> >=20
> > So this only avoids the call to, 'read_reg_dma(nandc, NAND_FLASH_STATUS=
, 1,
> > NAND_BAM_NEXT_SGL)' if q_op.cmd_reg !=3D OP_BLOCK_ERASE. But for q_op.c=
md_reg =3D=3D
> > OP_BLOCK_ERASE, the result is the same.
> >=20
> > I'm wondering how it results in fixing the OP_BLOCK_ERASE command.
> >=20
> > Can you share the actual issue that you are seeing? Like error logs etc=
..
> > =20
>=20
> Issue is that nandc goes to ADM timeout as soon as a BLOCK_ERASE is
> called. BLOCK_ERASE operation match also another operation from MTD
> read. (parser also maps to other stuff)
>=20
> I will be away from the testing board for 7-10 days so I can't provide
> logs currently.

So, shall we wait for additional logs from Christian or shall I merge
the two-patches series? I'm not sure what's the status anymore.

Thanks,
Miqu=C3=A8l

