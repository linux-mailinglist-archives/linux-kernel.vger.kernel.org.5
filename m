Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17FD7D077C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbjJTFGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJTFGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:06:51 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E3FD50
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:06:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5079f6efd64so472296e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697778407; x=1698383207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0jgQzh15tbFUAVOhe9LIEhZLsMkajruBrfzpNc5b9w=;
        b=kzWF0HkC/gBYvQ53HKn0xRQyQNf5kiYfD/seJb6mKvt/ZwyiI1h5rBDX8C84Unbvnw
         gJl40GfQ1MyFwmwnYyGB0ToQUzbiGNLRkQiXnU6a4lB1XT1rnEQLDenOQ1WafRZXTFiY
         6cPo3CEseAxc94Pb++1ppswTCdMTukdogN4Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697778407; x=1698383207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0jgQzh15tbFUAVOhe9LIEhZLsMkajruBrfzpNc5b9w=;
        b=kJxCT+YVszOJUiyELHW7ct/Xv7sENOm710hzdc4jaaGv4Ov+WNzOEtjMljxfXFU7U+
         V0WucsUEYcBCpgVXgUPLlPlHCJ5TKx+9AzPHBNeJPKP/mpcX2gxLvzyKLojr8YXERoCf
         FTI5AB+pu16Xzbn1XIfbypIpdj4Wi76NIX9z8EItxbhgyE8FN+HkOxUr6WRdbIz1WxIq
         mp/Z5Qls1pzVwPeNX73u+y1yq9FW9QGBgOp0vAy8bY8OVBH7Pmet07K0VQAmqTiue0HY
         Zn1k2p4tggeLilac9+Zv4viwdz9bntW5/YEbVXaJUrVOezrmqo+xCDFPCyUqM1MGyY2o
         SHHg==
X-Gm-Message-State: AOJu0Yzj/A8NH2cgYok2cbqRtBbDg/85s555QVxS7vYnOgq1I3x853U0
        YUf/A5HNWqGLT/DsWsePL8wb0bFb5qzhSM2iG3CKpg2J8L8FB5eA
X-Google-Smtp-Source: AGHT+IFmCdlNIlds8uaCs9bu6h6l6p+rnQ0UHqe7D43uyuGzPJgRp6m8F0GVh5IYUPL/Omk3FKAR5Km/rjyluUqBl80=
X-Received: by 2002:a05:6512:20d2:b0:500:bf33:3add with SMTP id
 u18-20020a05651220d200b00500bf333addmr380886lfr.47.1697778406807; Thu, 19 Oct
 2023 22:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231019124914.13545-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231019124914.13545-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 20 Oct 2023 13:06:35 +0800
Message-ID: <CAGXv+5H0rUajeU-i8nYyV2xWFQTnzqxioZCCyyP_RZXKqmcugQ@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: mt8186: Change I2C 4/5/6 ap clocks parent
 to infra
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        u.kleine-koenig@pengutronix.de, chun-jie.chen@mediatek.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 8:49=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Fix the parenting of clocks imp_iic_wrap_ap_clock_i2c{4-6}, as those
> are effectively parented to infra_ao_i2c{4-6} and not to the I2C_AP.
> This permits the correct (and full) enablement and disablement of the
> I2C4, I2C5 and I2C6 bus clocks, satisfying the whole clock tree of
> those.
>
> As an example, when requesting to enable imp_iic_wrap_ap_clock_i2c4:
>
> Before: infra_ao_i2c_ap -> imp_iic_wrap_ap_clock_i2c4
> After:  infra_ao_i2c_ap -> infra_ao_i2c4 -> imp_iic_wrap_ap_clock_i2c4
>
> Fixes: 66cd0b4b0ce5 ("clk: mediatek: Add MT8186 imp i2c wrapper clock sup=
port")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

I'm curious about what led to discovering this error?

ChenYu

> ---
>  drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c | 6 +++---
>  drivers/clk/mediatek/clk-mt8186-infra_ao.c     | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c b/drivers/clk=
/mediatek/clk-mt8186-imp_iic_wrap.c
> index 640ccb553274..871b8ff4c287 100644
> --- a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
> +++ b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
> @@ -29,11 +29,11 @@ static const struct mtk_gate imp_iic_wrap_clks[] =3D =
{
>         GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C3,
>                 "imp_iic_wrap_ap_clock_i2c3", "infra_ao_i2c_ap", 3),
>         GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C4,
> -               "imp_iic_wrap_ap_clock_i2c4", "infra_ao_i2c_ap", 4),
> +               "imp_iic_wrap_ap_clock_i2c4", "infra_ao_i2c4", 4),
>         GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C5,
> -               "imp_iic_wrap_ap_clock_i2c5", "infra_ao_i2c_ap", 5),
> +               "imp_iic_wrap_ap_clock_i2c5", "infra_ao_i2c5", 5),
>         GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C6,
> -               "imp_iic_wrap_ap_clock_i2c6", "infra_ao_i2c_ap", 6),
> +               "imp_iic_wrap_ap_clock_i2c6", "infra_ao_i2c6", 6),
>         GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C7,
>                 "imp_iic_wrap_ap_clock_i2c7", "infra_ao_i2c_ap", 7),
>         GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C8,
> diff --git a/drivers/clk/mediatek/clk-mt8186-infra_ao.c b/drivers/clk/med=
iatek/clk-mt8186-infra_ao.c
> index 837304cd0ed7..c490f1a310f8 100644
> --- a/drivers/clk/mediatek/clk-mt8186-infra_ao.c
> +++ b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
> @@ -132,7 +132,7 @@ static const struct mtk_gate infra_ao_clks[] =3D {
>         GATE_INFRA_AO2(CLK_INFRA_AO_AUDIO_26M_BCLK, "infra_ao_audio26m", =
"clk26m", 4),
>         GATE_INFRA_AO2(CLK_INFRA_AO_SSUSB_TOP_P1_HCLK, "infra_ao_ssusb_p1=
_hclk", "top_axi", 5),
>         GATE_INFRA_AO2(CLK_INFRA_AO_SPI1, "infra_ao_spi1", "top_spi", 6),
> -       GATE_INFRA_AO2(CLK_INFRA_AO_I2C4, "infra_ao_i2c4", "top_i2c", 7),
> +       GATE_INFRA_AO2(CLK_INFRA_AO_I2C4, "infra_ao_i2c4", "infra_ao_i2c_=
ap", 7),
>         GATE_INFRA_AO2(CLK_INFRA_AO_MODEM_TEMP_SHARE, "infra_ao_mdtemp", =
"clk26m", 8),
>         GATE_INFRA_AO2(CLK_INFRA_AO_SPI2, "infra_ao_spi2", "top_spi", 9),
>         GATE_INFRA_AO2(CLK_INFRA_AO_SPI3, "infra_ao_spi3", "top_spi", 10)=
,
> @@ -145,7 +145,7 @@ static const struct mtk_gate infra_ao_clks[] =3D {
>         GATE_INFRA_AO2_FLAGS(CLK_INFRA_AO_SSPM, "infra_ao_sspm", "top_ssp=
m", 15, CLK_IS_CRITICAL),
>         GATE_INFRA_AO2(CLK_INFRA_AO_SSUSB_TOP_P1_SYS,
>                        "infra_ao_ssusb_p1_sys", "top_ssusb_1p", 16),
> -       GATE_INFRA_AO2(CLK_INFRA_AO_I2C5, "infra_ao_i2c5", "top_i2c", 18)=
,
> +       GATE_INFRA_AO2(CLK_INFRA_AO_I2C5, "infra_ao_i2c5", "infra_ao_i2c_=
ap", 18),
>         GATE_INFRA_AO2(CLK_INFRA_AO_I2C5_ARBITER, "infra_ao_i2c5a", "top_=
i2c", 19),
>         GATE_INFRA_AO2(CLK_INFRA_AO_I2C5_IMM, "infra_ao_i2c5_imm", "top_i=
2c", 20),
>         GATE_INFRA_AO2(CLK_INFRA_AO_I2C1_ARBITER, "infra_ao_i2c1a", "top_=
i2c", 21),
> @@ -167,7 +167,7 @@ static const struct mtk_gate infra_ao_clks[] =3D {
>                              CLK_IS_CRITICAL),
>         GATE_INFRA_AO3_FLAGS(CLK_INFRA_AO_SSPM_32K_SELF, "infra_ao_sspm_3=
2k", "clk32k", 4,
>                              CLK_IS_CRITICAL),
> -       GATE_INFRA_AO3(CLK_INFRA_AO_I2C6, "infra_ao_i2c6", "top_i2c", 6),
> +       GATE_INFRA_AO3(CLK_INFRA_AO_I2C6, "infra_ao_i2c6", "infra_ao_i2c_=
ap", 6),
>         GATE_INFRA_AO3(CLK_INFRA_AO_AP_MSDC0, "infra_ao_ap_msdc0", "top_a=
xi", 7),
>         GATE_INFRA_AO3(CLK_INFRA_AO_MD_MSDC0, "infra_ao_md_msdc0", "top_a=
xi", 8),
>         GATE_INFRA_AO3(CLK_INFRA_AO_MSDC0_SRC, "infra_ao_msdc0_clk", "top=
_msdc50_0", 9),
> --
> 2.42.0
>
