Return-Path: <linux-kernel+bounces-48974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D41846440
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F5B1F24633
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D165A47A7A;
	Thu,  1 Feb 2024 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO2rXlrF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E413D960;
	Thu,  1 Feb 2024 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828621; cv=none; b=t3D6rKezXZ7WiEweqmGPVhbtlk8sFZkceYcigaIDa1HsyBo7BhmKC87dS74tLkiiQNd0PhfwgxbXrpb6hTM9+PKsI4bjKBgRJ/rhKviHd7M/2II5wIj1Ei0WoyYhEBnZ/Cvn2DzIfxUtKDW0dRDA6gpE72qnoEdKbz17v7TZGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828621; c=relaxed/simple;
	bh=LNTO+c64KChLGhrxel1IzuAD7R4UluaRK677Eqkl+KA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=G7YlG/vkoPc47GropVw8WRpwMwqMUgo0ugOuPrkujTqaPsVOyxydyDWyk6V/BFrxlID1Jbv2k9gIFuP8LZ5XD2HSXRGV2koBeyXKFivzVnPy/jwI1C1+COpBx08IdW1V924nZYtMJuLHWw+LL/TApvze1FK+KCXFAZZXRZgv0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO2rXlrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA41C433C7;
	Thu,  1 Feb 2024 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706828620;
	bh=LNTO+c64KChLGhrxel1IzuAD7R4UluaRK677Eqkl+KA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nO2rXlrF/E80L5xMAbP2msyJqY2RziYyjjxpeXrNH/Ne3p3ncg6RLw52N9ljGOI4z
	 PHw+gD28jS5IyNHJxcnma7mto+7nz4gXedC5lky2cH4RSHEuzgjCJxOmUbHywYWGQy
	 I5kncSgbFH2caZ/ShtsVbkwxcIhhtjLpvoGwIV3k6nIq4XOZcKAjZ8D5pbpIfPgDPm
	 x6HuC0cpH+YM393LIiFCwOoFy2ZNkSLggMFfMTqwVcVHs4mj7odFaMSKStnhzhe9wk
	 6KFnRmTH9GGmbJleqdW+61GHna7Lk/b/bjB+cZoP6+tuSlCFQmE/HWp2OWZD8fdRSj
	 L5BKDlulAHvmA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 01:03:36 +0200
Message-Id: <CYU48XUW36D8.3P6EOVJFFA4NF@suppilovahvero>
Cc: <LinoSanfilippo@gmx.de>, <p.rosenberger@kunbus.com>, <lukas@wunner.de>,
 <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] tpm,tpm_tis: Avoid warning splat at shutdown
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lino Sanfilippo" <l.sanfilippo@kunbus.com>, <peterhuewe@gmx.de>
X-Mailer: aerc 0.15.2
References: <20240201113646.31734-1-l.sanfilippo@kunbus.com>
In-Reply-To: <20240201113646.31734-1-l.sanfilippo@kunbus.com>

On Thu Feb 1, 2024 at 1:36 PM EET, Lino Sanfilippo wrote:
> If interrupts are not activated the work struct 'free_irq_work' is not
> initialized. This results in a warning splat at module shutdown.
>
> Fix this by always initializing the work regardless of whether interrupts
> are activated or not.
>
> cc: stable@vger.kernel.org
> Fixes: 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 unhandle=
d IRQs")
> Reported-by: Jarkko Sakkinen <jarkko@kernel.org>
> Closes: https://lore.kernel.org/all/CX32RFOMJUQ0.3R4YCL9MDCB96@kernel.org=
/
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 1b350412d8a6..64c875657687 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -919,8 +919,6 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *=
chip, u32 intmask,
>  	int rc;
>  	u32 int_status;
> =20
> -	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
> -
>  	rc =3D devm_request_threaded_irq(chip->dev.parent, irq, NULL,
>  				       tis_int_handler, IRQF_ONESHOT | flags,
>  				       dev_name(&chip->dev), chip);
> @@ -1132,6 +1130,7 @@ int tpm_tis_core_init(struct device *dev, struct tp=
m_tis_data *priv, int irq,
>  	priv->phy_ops =3D phy_ops;
>  	priv->locality_count =3D 0;
>  	mutex_init(&priv->locality_count_mutex);
> +	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
> =20
>  	dev_set_drvdata(&chip->dev, priv);
> =20
>
> base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3

Thank you had forgotten about this.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

