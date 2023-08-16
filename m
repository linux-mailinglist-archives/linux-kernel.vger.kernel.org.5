Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0B177DF98
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbjHPKss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbjHPKsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:48:45 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4348C2D6D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:48:20 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bd6a34474cso596220a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692182831; x=1692787631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHVFwf2+IJdhvL1m7bcmD2X+8MDeoieDkbHIWtoTZtU=;
        b=Nlgcv2HJLA79Yxsz2pDMqw8KXCAYKf35hze4/k++oS8i+tFaUoOBUCemVoo+mmy2et
         TkNIzFP6EPK8Ex14d6TifkAeVTJ7s5Ank/Jj+Gvch59tbIuJ+5GT75kH2Nw951pwiyDN
         vvYJMQprRBYlJFsncnqLvGU8DfW0XcaIcqmLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692182831; x=1692787631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHVFwf2+IJdhvL1m7bcmD2X+8MDeoieDkbHIWtoTZtU=;
        b=bA8ekE/es3OoybJMbTkVxZj+YwWNZ2tw8ACfzAWxfw8/QzY/2GTAPn6ltikuKsYUAL
         ebjOJhrYRDgao9vJbbVEVwZAblc8KfuwUdlIg8nQXWPG36YAhspapuTy0L4aALm1scNc
         LGnwjSAGYB1KJjoe/BBN+GvcR5f70TnrAkD3wPHY7Mp17N52GEIvVFZot5ft1ca1WAwr
         yCdfHvY+qWBot2xcmtDBPfniVwKCRsfU+lZsz2ppAQcUuorBUWgxPHeoQ30b1YldG7zN
         ruJQ/nKcUN3memJSAHsNiSJ0y0r2sBV2uhSZOBzntKr3xXqephpC8fT/kxVegiCPsMzv
         PD1w==
X-Gm-Message-State: AOJu0Yyy3nQfNyBAxPok5oj7d0hljSm9nSrue6BUeQLQCNcUFya81X9q
        5df/tTDy+M7FoM3LRtvES4rE/EDnefjVaV9XBW4Rig==
X-Google-Smtp-Source: AGHT+IFop6ccKvKv4AO2QL1MFngv5Zyjpe0Iy6hNB7Ea7XfS2ppUUNyTqyfMkTCzFCreFuZWS/ZjF6x+8JoQCmIeYP8=
X-Received: by 2002:a05:6830:1d69:b0:6bd:b40:8912 with SMTP id
 l9-20020a0568301d6900b006bd0b408912mr1258271oti.35.1692182831303; Wed, 16 Aug
 2023 03:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230816104245.2676965-1-hsinyi@chromium.org>
In-Reply-To: <20230816104245.2676965-1-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 16 Aug 2023 18:46:45 +0800
Message-ID: <CAJMQK-hR0eaO0b4Vd0U8_KAndLyZapqdHjVLAoe42rWi9rdLkA@mail.gmail.com>
Subject: Re: [PATCH v2,1/2] mtd: spi-nor: giga: gd25lq64c: Disable quad mode
 according to bus width
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        "Miquel Raynal )" <miquel.raynal@bootlin.com>,
        "Richard Weinberger )" <richard@nod.at>,
        "Vignesh Raghavendra )" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 6:42=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> gd25lq64c has Quad Enable Requirement flag parsed as
> BFPT_DWORD15_QER_SR2_BIT1_BUGGY in BFPT, even if spi-{rx/tx}-bus-width
> set as non QUAD, eg. 0, 1, 2... Thus quad_enable will not be NULL and
> quad enable (QE) bit will be set to 1 by default. According to
> datasheet[1], if QE bit is enabled, WP pin will become IO pin and the
> system can't use write protection feature, and it's also not recommended
> to set QE bit to 1[1].
>
> Add a post_bfpt fixup that reads spi-rx-bus-width to remove quad_enable
> if the width is set to below QUAD mode.
>
> [1]
> https://www.gigadevice.com.cn/Public/Uploads/uploadfile/files/20220714/DS=
-00012-GD25LQ64C-Rev3.4.pdf
> page 13
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
change log:
v1->v2: read bus width property in driver instead of creating a
duplicate dt property.
v1 link: https://lore.kernel.org/lkml/20230815154412.713846-1-hsinyi@chromi=
um.org/
---
>  drivers/mtd/spi-nor/gigadevice.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigad=
evice.c
> index d57ddaf1525b3..8ea89e1858f9b 100644
> --- a/drivers/mtd/spi-nor/gigadevice.c
> +++ b/drivers/mtd/spi-nor/gigadevice.c
> @@ -33,6 +33,31 @@ static const struct spi_nor_fixups gd25q256_fixups =3D=
 {
>         .post_bfpt =3D gd25q256_post_bfpt,
>  };
>
> +static int
> +gd25lq64c_post_bfpt(struct spi_nor *nor,
> +                   const struct sfdp_parameter_header *bfpt_header,
> +                   const struct sfdp_bfpt *bfpt)
> +{
> +       struct device_node *np =3D spi_nor_get_flash_node(nor);
> +       u32 value;
> +
> +       /*
> +        * Even if spi-{tx,rx}-bus-width is set to DUAL mode, due to the =
QER
> +        * flag parsed from BFPT is BFPT_DWORD15_QER_SR2_BIT1_BUGGY, so t=
he
> +        * quad_enable will be set and QE bit set to 1.
> +        */
> +       if (!of_property_read_u32(np, "spi-rx-bus-width", &value)) {
> +               if (value <=3D 2)
> +                       nor->params->quad_enable =3D NULL;
> +       }
> +
> +       return 0;
> +}
> +
> +static struct spi_nor_fixups gd25lq64c_fixups =3D {
> +       .post_bfpt =3D gd25lq64c_post_bfpt,
> +};
> +
>  static const struct flash_info gigadevice_nor_parts[] =3D {
>         { "gd25q16", INFO(0xc84015, 0, 64 * 1024,  32)
>                 FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> @@ -53,7 +78,8 @@ static const struct flash_info gigadevice_nor_parts[] =
=3D {
>         { "gd25lq64c", INFO(0xc86017, 0, 64 * 1024, 128)
>                 FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>                 NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> -                             SPI_NOR_QUAD_READ) },
> +                             SPI_NOR_QUAD_READ)
> +               .fixups =3D &gd25lq64c_fixups },
>         { "gd25lq128d", INFO(0xc86018, 0, 64 * 1024, 256)
>                 FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>                 NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> --
> 2.41.0.694.ge786442a9b-goog
>
