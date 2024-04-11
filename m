Return-Path: <linux-kernel+bounces-140022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969448A0A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D18B1F2497B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811A513E881;
	Thu, 11 Apr 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crdVATW2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085513C824;
	Thu, 11 Apr 2024 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821767; cv=none; b=OZb/vchSvyBsXKm3SYYwpkm5CMt68CQDzw15XT5KIWJcfoAr3Br5KzIqhx3EJW4CV2h/qCaRHWL7XNFK0guGmVcHnv+Zk4nxV1ICjVvEjiRO4/dheEWE31bwfNTiurxl0FUaW+4Y6bvVoU9ape/ELIRxf4gJWg0BGAOkNyTvsDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821767; c=relaxed/simple;
	bh=GQQD6YHCcBkicBSPTMO2OoklUsO8Qz/uM9luYCPMi30=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Ayc4slkldwOoTkCycVEmMG3321YOCp6XAf7yODcPBCBNiRBisGNAqj1o0aAiaMfe7EH80esqwkUKJYzljZ//4IvqTNUqA4WtDHKfhaqmgNptiDr0LBQUj7RpDTnWD2zhtt+UzFbumFgwnV9fMm8cAlTsW7sc9cyYI0Qdabb2GyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crdVATW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FA2C433F1;
	Thu, 11 Apr 2024 07:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712821767;
	bh=GQQD6YHCcBkicBSPTMO2OoklUsO8Qz/uM9luYCPMi30=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=crdVATW2FLVb3crXNiLBHqFn6ynsHqIcCfM5bLTeAs5VDh9JY3eMei8amlkl5tVKg
	 KES6kIL4Nwmjyjybv5PKIyspbnq+7a96u7fm66OoqzqrsQkyuTQN0O1W5nRgiVzQSw
	 UmWvDHagKpqtXszJ/ezQrDVD7m2jOogiY3vsGAzDZLnaF2pQcq7sxhOhQK/G4bHWWu
	 Kui7KQaf1dY6ThAosg5QR005yovEguC3NhlZO/Ed6HpmFQUcAH0c2zku7BC2f8OdCf
	 ccCr0G79iv3SXv3wtIlpUHus7wwW7R/VN3JmNhf8cVGRwivsYVjnbSLJuwle6WToGZ
	 OPUboYjEB4J/Q==
Message-ID: <44131080f148a472ed5dee901a66ffa7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240110133128.286657-9-jeeheng.sia@starfivetech.com>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com> <20240110133128.286657-9-jeeheng.sia@starfivetech.com>
Subject: Re: [RFC v3 08/16] clk: starfive: Add JH8100 North-West clock generator driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>, aou@eecs.berkeley.edu, conor@kernel.org, emil.renner.berthing@canonical.com, hal.feng@starfivetech.com, kernel@esmil.dk, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, p.zabel@pengutronix.de, palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org, xingyu.wu@starfivetech.com
Date: Thu, 11 Apr 2024 00:49:25 -0700
User-Agent: alot/0.10

Quoting Sia Jee Heng (2024-01-10 05:31:20)
> diff --git a/drivers/clk/starfive/clk-starfive-jh8100-nw.c b/drivers/clk/=
starfive/clk-starfive-jh8100-nw.c
> new file mode 100644
> index 000000000000..018f5af6c777
> --- /dev/null
> +++ b/drivers/clk/starfive/clk-starfive-jh8100-nw.c
> @@ -0,0 +1,237 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StarFive JH8100 North-West Clock Driver
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
[...]
> +
> +static int jh8100_nwcrg_probe(struct platform_device *pdev)
> +{
> +       struct starfive_clk_priv *priv;
> +       unsigned int idx;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(&pdev->dev,
> +                           struct_size(priv, reg, JH8100_NWCLK_NUM_CLKS),
> +                           GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&priv->rmw_lock);
> +       priv->dev =3D &pdev->dev;
> +       priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
> +
> +       for (idx =3D 0; idx < JH8100_NWCLK_NUM_CLKS; idx++) {
> +               u32 max =3D jh8100_nwcrg_clk_data[idx].max;
> +               struct clk_parent_data parents[4] =3D {};
> +               struct clk_init_data init =3D {
> +                       .name =3D jh8100_nwcrg_clk_data[idx].name,
> +                       .ops =3D starfive_clk_ops(max),
> +                       .parent_data =3D parents,
> +                       .num_parents =3D
> +                               ((max & STARFIVE_CLK_MUX_MASK) >> STARFIV=
E_CLK_MUX_SHIFT) + 1,
> +                       .flags =3D jh8100_nwcrg_clk_data[idx].flags,
> +               };
> +               struct starfive_clk *clk =3D &priv->reg[idx];
> +               unsigned int i;
> +
> +               for (i =3D 0; i < init.num_parents; i++) {
> +                       unsigned int pidx =3D jh8100_nwcrg_clk_data[idx].=
parents[i];
> +
> +                       if (pidx < JH8100_NWCLK_NUM_CLKS)
> +                               parents[i].hw =3D &priv->reg[pidx].hw;
> +                       else if (pidx =3D=3D JH8100_NWCLK_OSC)
> +                               parents[i].fw_name =3D "osc";

Please generate this one time with structures and use an index instead
of string names. This is faster in multiple ways, and the parent data is
copied anyway.

> +                       else if (pidx =3D=3D JH8100_NWCLK_APB_BUS)
> +                               parents[i].fw_name =3D "apb_bus";
> +                       else if (pidx =3D=3D JH8100_NWCLK_APB_BUS_PER4)
> +                               parents[i].fw_name =3D "apb_bus_per4";

