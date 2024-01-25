Return-Path: <linux-kernel+bounces-38242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6836383BCF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B841F2C878
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC131BDDF;
	Thu, 25 Jan 2024 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="MMD7PC6p"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0481BC5A;
	Thu, 25 Jan 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173932; cv=none; b=i60wzGSvmBdfDiI6wiXr49PyuHFNn85SxpSeM9xkP6wAiQOGjcCLgkIeukcwKe9J2Af2j97jC3OIVKnOMws2bUQdr2Qf2L4wGsTsds1KAp7aU4bTYsQ0jeiyTNAFbexJwxuK8EzUcEpRRVhEIuJ7nJeS0vNfi4tMVfq0wt0xc3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173932; c=relaxed/simple;
	bh=ibob9So5LsOD/sjW4bKonztTIlxVUC8HtZ04POfdPHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6+/u3pSzYQW4xqXQjjTPgDz0k6S7zxG8u+7Ek0LJNNZwdVIKZE4vNH5mcDp1FKNW7UP+QlSQU+8uPrOZnlbE2oyiGEUkMl0LauhfKYSL3fQnnp7M4rDiQfMf8gOvSbjoDvCBVSUqXVw0h9WYFUAHzR0Lq1mTO7M7dDASG0zI70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=MMD7PC6p; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1706173928; x=1737709928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FeUFODrwDWTHKBoEZylP9hxRYVHRbSJKlDURreDdsJk=;
  b=MMD7PC6pVE/e30/hMbNkA7O6mCdarupDSsODbNP9eTah7k8elGgXY+os
   cFoeRb5nXdJxJJjIPbRmVp2pCuJTmFbU8VHbNqDEAemI6AIAaP70qhKpq
   0zy+xdqmmT+jbzNrl3V/gMBhtl2vNW+lcWV49UKdYfKH4Snu4ubxmFsXp
   IBm1RfXL8RKeI+3qYldpYWNGowylQdNB0eaHahrYu4YrGVoWoHGibQZ09
   Z/cPuuQZ032W+v9J3PM+xRd58mQuu+KXJF032Ni0E1IWq9xa/J2er+FCr
   nH7FQSSnAxOlnkdpVk5RlDOc6BEavgwihWLsPUZGqTudSma3WdyicSKvE
   Q==;
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="35071346"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 Jan 2024 10:11:58 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 62619280075;
	Thu, 25 Jan 2024 10:11:55 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: Re: [PATCH v4 2/4] mailbox: imx: support return value of init
Date: Thu, 25 Jan 2024 10:11:54 +0100
Message-ID: <5774190.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240125-imx-mailbox-v4-2-800be5383c20@nxp.com>
References: <20240125-imx-mailbox-v4-0-800be5383c20@nxp.com> <20240125-imx-mailbox-v4-2-800be5383c20@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Peng,

Am Donnerstag, 25. Januar 2024, 06:20:04 CET schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
>=20
> There will be changes that init may fail, so adding return value for
> init function.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mailbox/imx-mailbox.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 656171362fe9..dced4614065f 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -110,7 +110,7 @@ struct imx_mu_dcfg {
>  	int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void
> *data); int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
> int (*rxdb)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp); -	void
> (*init)(struct imx_mu_priv *priv);
> +	int (*init)(struct imx_mu_priv *priv);
>  	enum imx_mu_type type;
>  	u32	xTR;		/* Transmit Register0 */
>  	u32	xRR;		/* Receive Register0 */
> @@ -737,7 +737,7 @@ static struct mbox_chan *imx_mu_seco_xlate(struct
> mbox_controller *mbox, return imx_mu_xlate(mbox, sp);
>  }
>=20
> -static void imx_mu_init_generic(struct imx_mu_priv *priv)
> +static int imx_mu_init_generic(struct imx_mu_priv *priv)
>  {
>  	unsigned int i;
>  	unsigned int val;
> @@ -757,7 +757,7 @@ static void imx_mu_init_generic(struct imx_mu_priv
> *priv) priv->mbox.of_xlate =3D imx_mu_xlate;
>=20
>  	if (priv->side_b)
> -		return;
> +		return 0;
>=20
>  	/* Set default MU configuration */
>  	for (i =3D 0; i < IMX_MU_xCR_MAX; i++)
> @@ -770,9 +770,11 @@ static void imx_mu_init_generic(struct imx_mu_priv
> *priv) /* Clear any pending RSR */
>  	for (i =3D 0; i < IMX_MU_NUM_RR; i++)
>  		imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
> +
> +	return 0;
>  }
>=20
> -static void imx_mu_init_specific(struct imx_mu_priv *priv)
> +static int imx_mu_init_specific(struct imx_mu_priv *priv)
>  {
>  	unsigned int i;
>  	int num_chans =3D priv->dcfg->type & IMX_MU_V2_S4 ? IMX_MU_S4_CHANS :
> IMX_MU_SCU_CHANS; @@ -794,12 +796,20 @@ static void
> imx_mu_init_specific(struct imx_mu_priv *priv) /* Set default MU
> configuration */
>  	for (i =3D 0; i < IMX_MU_xCR_MAX; i++)
>  		imx_mu_write(priv, 0, priv->dcfg->xCR[i]);
> +
> +	return 0;
>  }
>=20
> -static void imx_mu_init_seco(struct imx_mu_priv *priv)
> +static int imx_mu_init_seco(struct imx_mu_priv *priv)
>  {
> -	imx_mu_init_generic(priv);
> +	int ret;
> +
> +	ret =3D imx_mu_init_generic(priv);
> +	if (ret)
> +		return ret;
>  	priv->mbox.of_xlate =3D imx_mu_seco_xlate;
> +
> +	return 0;
>  }
>=20
>  static int imx_mu_probe(struct platform_device *pdev)
> @@ -866,7 +876,11 @@ static int imx_mu_probe(struct platform_device *pdev)
>=20
>  	priv->side_b =3D of_property_read_bool(np, "fsl,mu-side-b");
>=20
> -	priv->dcfg->init(priv);
> +	ret =3D priv->dcfg->init(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to init MU\n");

As this is during probe, I rather use dev_err_probe right away. Even if dcf=
g-
>init won't return -EPROBE_DEFER for now.

Best regards,
Alexander

> +		goto disable_clk;
> +	}
>=20
>  	spin_lock_init(&priv->xcr_lock);
>=20
> @@ -878,10 +892,8 @@ static int imx_mu_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, priv);
>=20
>  	ret =3D devm_mbox_controller_register(dev, &priv->mbox);
> -	if (ret) {
> -		clk_disable_unprepare(priv->clk);
> -		return ret;
> -	}
> +	if (ret)
> +		goto disable_clk;
>=20
>  	pm_runtime_enable(dev);
>=20
> @@ -899,6 +911,7 @@ static int imx_mu_probe(struct platform_device *pdev)
>=20
>  disable_runtime_pm:
>  	pm_runtime_disable(dev);
> +disable_clk:
>  	clk_disable_unprepare(priv->clk);
>  	return ret;
>  }


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



