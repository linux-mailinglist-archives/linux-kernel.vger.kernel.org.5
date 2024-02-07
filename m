Return-Path: <linux-kernel+bounces-55939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3718E84C3C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B631A1F25A8A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260BC134A6;
	Wed,  7 Feb 2024 04:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgK/CRbn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E612E5D;
	Wed,  7 Feb 2024 04:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281000; cv=none; b=SMKoP94l7wimvZH9g79KrUds/2fX6A866v4jbHSzgkZ74pFe0F98136jGa5eWIZa1/Lx7SSK2rmw6SGzcMv4+7ZHD3IRbrzhnZGTx79hZORSYTZQlcmsv+kr2x1FjiCVHQglL+WOlmuzMPX4htrhyKAk3FXGga8tl1EYqHCGrNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281000; c=relaxed/simple;
	bh=hIFmOefpum49CQqkTH6BjfMQ7L16rAL+BsMfLm131pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWyKRyvOhI6OozjgY5kHToOwbQlWIpfE8xUevO1YXC1yHzt+D/1ci1n1DedRQ3+Tik7Q1VAq8b/gRF+sPBwdHrrSZJe8r8yXNb6evugdkngHeEQjkwU3YCTbci4Y2kbcKuNtye9xxXtZFYg8531547d11zkD2C8bDYC2zszNfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgK/CRbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17874C433F1;
	Wed,  7 Feb 2024 04:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707280999;
	bh=hIFmOefpum49CQqkTH6BjfMQ7L16rAL+BsMfLm131pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GgK/CRbneraBnuzrSEPEo6k4QAY9gyAJeRedmq6ya+qUYjQ02KTi3sDRCjuk+LJfm
	 BeaubQzoIwyToQp9tn/7UKO/7Cyeq4COkppQ0HiCPBaotu+xQiADT56w98h0JNO/tR
	 VW3svP/QfnuBURKjqu0Rh7FHi3ofkiT2Qt/xeDUW8V6WEGKgpb42gZ4seLXDATGkVj
	 +N9xmS9M9GJN2/LQ4mxVRIcNwrTKoAmen6CCEwcWRkZGtMW53rz7XLA3s9RyFBMd4V
	 wzoaZHQbhFaIteLh50aDAZh0nFfi2oRgc4dFCqGVGszLo9mD+qyhFkL2VYdZ0c24q6
	 gAM0cHg9NSfpw==
Date: Wed, 7 Feb 2024 05:43:14 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Sergey Kozlov
 <serjk@netup.ru>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 07/33] media: netup_unidvb: Follow renaming of SPI
 "master" to "controller"
Message-ID: <20240207054314.404ccd1c@coco.lan>
In-Reply-To: <e745359645a4af795f229d84e39949fe75bd2ec8.1705944943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
	<e745359645a4af795f229d84e39949fe75bd2ec8.1705944943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Mon, 22 Jan 2024 19:07:02 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> escreveu:

> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
>=20
> To be able to remove these compatibility macros push the renaming into
> this driver.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

It is probably better to have this series applied altogether, so=20
feel free to handle it via your tree:

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> ---
>  .../media/pci/netup_unidvb/netup_unidvb_spi.c | 48 +++++++++----------
>  1 file changed, 24 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c b/drivers/=
media/pci/netup_unidvb/netup_unidvb_spi.c
> index 526042d8afae..e90aa1c1584c 100644
> --- a/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c
> +++ b/drivers/media/pci/netup_unidvb/netup_unidvb_spi.c
> @@ -35,7 +35,7 @@ struct netup_spi_regs {
> =20
>  struct netup_spi {
>  	struct device			*dev;
> -	struct spi_master		*master;
> +	struct spi_controller		*ctlr;
>  	struct netup_spi_regs __iomem	*regs;
>  	u8 __iomem			*mmio;
>  	spinlock_t			lock;
> @@ -78,7 +78,7 @@ irqreturn_t netup_spi_interrupt(struct netup_spi *spi)
>  	reg =3D readw(&spi->regs->control_stat);
>  	if (!(reg & NETUP_SPI_CTRL_IRQ)) {
>  		spin_unlock_irqrestore(&spi->lock, flags);
> -		dev_dbg(&spi->master->dev,
> +		dev_dbg(&spi->ctlr->dev,
>  			"%s(): not mine interrupt\n", __func__);
>  		return IRQ_NONE;
>  	}
> @@ -88,15 +88,15 @@ irqreturn_t netup_spi_interrupt(struct netup_spi *spi)
>  	spi->state =3D SPI_STATE_DONE;
>  	wake_up(&spi->waitq);
>  	spin_unlock_irqrestore(&spi->lock, flags);
> -	dev_dbg(&spi->master->dev,
> +	dev_dbg(&spi->ctlr->dev,
>  		"%s(): SPI interrupt handled\n", __func__);
>  	return IRQ_HANDLED;
>  }
> =20
> -static int netup_spi_transfer(struct spi_master *master,
> +static int netup_spi_transfer(struct spi_controller *ctlr,
>  			      struct spi_message *msg)
>  {
> -	struct netup_spi *spi =3D spi_master_get_devdata(master);
> +	struct netup_spi *spi =3D spi_controller_get_devdata(ctlr);
>  	struct spi_transfer *t;
>  	int result =3D 0;
>  	u32 tr_size;
> @@ -131,7 +131,7 @@ static int netup_spi_transfer(struct spi_master *mast=
er,
>  				NETUP_SPI_CTRL_START |
>  				(frag_last ? NETUP_SPI_CTRL_LAST_CS : 0),
>  				&spi->regs->control_stat);
> -			dev_dbg(&spi->master->dev,
> +			dev_dbg(&spi->ctlr->dev,
>  				"%s(): control_stat 0x%04x\n",
>  				__func__, readw(&spi->regs->control_stat));
>  			wait_event_timeout(spi->waitq,
> @@ -144,11 +144,11 @@ static int netup_spi_transfer(struct spi_master *ma=
ster,
>  				}
>  			} else {
>  				if (spi->state =3D=3D SPI_STATE_START) {
> -					dev_dbg(&spi->master->dev,
> +					dev_dbg(&spi->ctlr->dev,
>  						"%s(): transfer timeout\n",
>  						__func__);
>  				} else {
> -					dev_dbg(&spi->master->dev,
> +					dev_dbg(&spi->ctlr->dev,
>  						"%s(): invalid state %d\n",
>  						__func__, spi->state);
>  				}
> @@ -161,7 +161,7 @@ static int netup_spi_transfer(struct spi_master *mast=
er,
>  	}
>  done:
>  	msg->status =3D result;
> -	spi_finalize_current_message(master);
> +	spi_finalize_current_message(ctlr);
>  	return result;
>  }
> =20
> @@ -172,30 +172,30 @@ static int netup_spi_setup(struct spi_device *spi)
> =20
>  int netup_spi_init(struct netup_unidvb_dev *ndev)
>  {
> -	struct spi_master *master;
> +	struct spi_controller *ctlr;
>  	struct netup_spi *nspi;
> =20
> -	master =3D devm_spi_alloc_master(&ndev->pci_dev->dev,
> -		sizeof(struct netup_spi));
> -	if (!master) {
> +	ctlr =3D devm_spi_alloc_master(&ndev->pci_dev->dev,
> +					 sizeof(struct netup_spi));
> +	if (!ctlr) {
>  		dev_err(&ndev->pci_dev->dev,
>  			"%s(): unable to alloc SPI master\n", __func__);
>  		return -EINVAL;
>  	}
> -	nspi =3D spi_master_get_devdata(master);
> -	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
> -	master->bus_num =3D -1;
> -	master->num_chipselect =3D 1;
> -	master->transfer_one_message =3D netup_spi_transfer;
> -	master->setup =3D netup_spi_setup;
> +	nspi =3D spi_controller_get_devdata(ctlr);
> +	ctlr->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
> +	ctlr->bus_num =3D -1;
> +	ctlr->num_chipselect =3D 1;
> +	ctlr->transfer_one_message =3D netup_spi_transfer;
> +	ctlr->setup =3D netup_spi_setup;
>  	spin_lock_init(&nspi->lock);
>  	init_waitqueue_head(&nspi->waitq);
> -	nspi->master =3D master;
> +	nspi->ctlr =3D ctlr;
>  	nspi->regs =3D (struct netup_spi_regs __iomem *)(ndev->bmmio0 + 0x4000);
>  	writew(2, &nspi->regs->clock_divider);
>  	writew(NETUP_UNIDVB_IRQ_SPI, ndev->bmmio0 + REG_IMASK_SET);
>  	ndev->spi =3D nspi;
> -	if (spi_register_master(master)) {
> +	if (spi_register_controller(ctlr)) {
>  		ndev->spi =3D NULL;
>  		dev_err(&ndev->pci_dev->dev,
>  			"%s(): unable to register SPI bus\n", __func__);
> @@ -207,8 +207,8 @@ int netup_spi_init(struct netup_unidvb_dev *ndev)
>  		ndev->pci_bus,
>  		ndev->pci_slot,
>  		ndev->pci_func);
> -	if (!spi_new_device(master, &netup_spi_board)) {
> -		spi_unregister_master(master);
> +	if (!spi_new_device(ctlr, &netup_spi_board)) {
> +		spi_unregister_controller(ctlr);
>  		ndev->spi =3D NULL;
>  		dev_err(&ndev->pci_dev->dev,
>  			"%s(): unable to create SPI device\n", __func__);
> @@ -227,7 +227,7 @@ void netup_spi_release(struct netup_unidvb_dev *ndev)
>  	if (!spi)
>  		return;
> =20
> -	spi_unregister_master(spi->master);
> +	spi_unregister_controller(spi->ctlr);
>  	spin_lock_irqsave(&spi->lock, flags);
>  	reg =3D readw(&spi->regs->control_stat);
>  	writew(reg | NETUP_SPI_CTRL_IRQ, &spi->regs->control_stat);



Thanks,
Mauro

