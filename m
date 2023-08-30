Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A3778DEF7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbjH3TSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242069AbjH3HPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:15:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF14D1B1;
        Wed, 30 Aug 2023 00:15:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so1231271a12.0;
        Wed, 30 Aug 2023 00:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693379724; x=1693984524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MzJ5oBSb7luD02ued3bJvWqlDC+kCaw52rdLQgmodc=;
        b=qz1LkWZKVDs+YWiOc+QGSxuT624qkYFdzcr9VYygrIs+ynOfzV3D3raf1AYztDrhj1
         yc+ibTipINoa0Q8PJ2IlY1ZOjUI8lCI4FCd5tHweLRMWQXZTVrQG+OQrUtukWiw0nNNu
         JkANwpHfCCm1iWycDcRhxLGgmsqQCXlP6ZjZRu/NTmAtXQVZPKKdAJcotMrAH3VJll9K
         P9OovrxGJHHu/3/NKQ4tBHJZN1Kpdqai7lI7C8T18bQnKdkW+JPsOzDUgEUCMMojObLA
         0qiL0O8W2AmYRMyTmL+MAo3JKg+PRfHbXzAlSGYTb3XdKcawW5449s1Mhmw/jL8016nJ
         nh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693379724; x=1693984524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MzJ5oBSb7luD02ued3bJvWqlDC+kCaw52rdLQgmodc=;
        b=WSu7km2lpks84ZV0/kF6biAe8YIsHwM+Tt2o+dHQXDHRxNQqZ1tX3fDxagRJinEvRs
         62ITercF6gF4dOj/y6pgzVkueISeljGh5IuVCUrmyRr/hogMX/DzwAThEr6UPuIrYJVz
         UCf2Xl1FCjxnWGXcdx0iChLBVgtYWgL98mZ/nIbvCBLzTiE8W24pQmjr6vf8atvL09fQ
         eN5te+MkNc4ng9i9UN0LMfPZRiUclTNpDvIK1sqPtagwNEvDTy3BTVwOPuP/gGU+9rv/
         Ub2UFm3hBqn5THJCDXvJ7Mqkm725Uf7f/aZeNDN+YSrgvr7OPKJ3i2OOCKY1sNnRUfWV
         e7Rg==
X-Gm-Message-State: AOJu0YwubRuF8rbvh1/0GLmZxr3Fc/i+890fcBB8PSD6+cvKtBUM3Kef
        qLg8WVLjFyCRm8JEvDxQ1/l+wc6+ghTGo22ZVPU=
X-Google-Smtp-Source: AGHT+IEto/3VmuhK35ccRqBIACHxYK0lHbx5h7sC8hT1i/+LKEpWC528Pqk0ZhoD99Re+41Fh85jcQ+j3A8wwlzWtYM=
X-Received: by 2002:a17:907:2cc1:b0:9a5:9f3c:961e with SMTP id
 hg1-20020a1709072cc100b009a59f3c961emr1657955ejc.18.1693379723856; Wed, 30
 Aug 2023 00:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230816080225.21482-1-mingjin.yang@unisoc.com>
 <20230816080225.21482-3-mingjin.yang@unisoc.com> <20230828165709.56ffa299@jic23-huawei>
In-Reply-To: <20230828165709.56ffa299@jic23-huawei>
From:   =?UTF-8?B?5p2o5piO6YeR?= <magicyangmingjin@gmail.com>
Date:   Wed, 30 Aug 2023 15:15:12 +0800
Message-ID: <CAKJtOf5chsyPrnMZGv32YFvxG1x5cDtBQmzk7wRqCn7C2+cB=g@mail.gmail.com>
Subject: Re: [PATCH V0 2/2] iio: adc: sprd_pmic_adc: Add support for UMP
 serise pmic adc
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mingjin Yang <mingjin.yang@unisoc.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Ling_Ling.Xu@unisoc.com,
        Jinfeng.Lin1@unisoc.com, Yangbin.Li@unisoc.com,
        Jiansheng.Wu@unisoc.com, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=80 23:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 16 Aug 2023 16:02:25 +0800
> Mingjin Yang <mingjin.yang@unisoc.com> wrote:
>
> > This patch adds support for UNISOC UMP family
> > of ADC driver. The ADC peripheral can support both
> > voltage and current mode whose input signal is
> > connected to the PMIC ADC AMUX.
> >
> > Signed-off-by: Mingjin Yang <mingjin.yang@unisoc.com>
>
> Hi Mingjin,
>
> Thanks for your driver - it's in pretty good shape for a v0.
>
> Comments inline.
>
> Jonathan
>
>
> > diff --git a/drivers/iio/adc/sprd_pmic_adc.c b/drivers/iio/adc/sprd_pmi=
c_adc.c
> > new file mode 100644
> > index 000000000000..6113bd84cd77
> > --- /dev/null
> > +++ b/drivers/iio/adc/sprd_pmic_adc.c
> > @@ -0,0 +1,1298 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2020 Unisoc Inc.
> > +
> > +#include <linux/hwspinlock.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/math64.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/slab.h>
> > +#include <linux/sort.h>
> > +
> > +/* ADC controller registers definition */
> > +#define SPRD_ADC_CTL                 0x0
> > +
> > +#define SPRD_ADC_CH_CFG                      0x4
> > +#define SPRD_ADC_CHN_ID_MASK         GENMASK(4, 0)
> > +
> > +#define SPRD_ADC_DATA                        0x4c
> > +#define SPRD_ADC_DATA_MASK           GENMASK(11, 0)
> > +
> > +#define SPRD_ADC_INT_EN                      0x50
> > +#define SPRD_ADC_IRQ_EN                      BIT(0)
> > +
> > +#define SPRD_ADC_INT_CLR             0x54
> > +#define SPRD_ADC_IRQ_CLR             BIT(0)
> > +
> > +#define SPRD_ADC_INT_STS             0x58
> > +
> > +#define SPRD_ADC_INT_RAW             0x5c
> > +#define SPRD_ADC_IRQ_RAW             BIT(0)
> > +
> > +/* Bits and mask definition for SPRD_ADC_CTL register */
> > +#define SPRD_ADC_EN                  BIT(0)
> > +#define SPRD_ADC_CHN_RUN             BIT(1)
> > +#define SPRD_ADC_12BIT_MODE          BIT(2)
> > +#define SPRD_ADC_RUN_NUM_MASK                GENMASK(7, 4)
> > +#define SPRD_ADC_RUN_NUM_SHIFT               4
> > +#define SPRD_ADC_AVERAGE_SHIFT               8
> > +#define SPRD_ADC_AVERAGE_MASK                GENMASK(10, 8)
> > +
> > +/* Timeout (ms) for the trylock of hardware spinlocks */
> > +#define SPRD_ADC_HWLOCK_TIMEOUT              5000
> Name it so the units are CLAR
>         SPRD_ADC_HWLOCK_TIMEOUT_MS
> then drop teh comment that tells us nothing.
> > +
> > +/* Maximum ADC channel number */
> Obvious comment: drop it.
> > +#define SPRD_ADC_CHANNEL_MAX         32
> > +
> > +/* Timeout (us) for ADC data conversion according to ADC datasheet */
> Reference specific part of datasheet or drop the comment.
> > +#define SPRD_ADC_RDY_TIMEOUT         1000000
> Name it so the unit is obviously
>         TIMEOUT_US
>
> > +#define SPRD_ADC_POLL_RAW_STATUS     500
> What's this one?
> > +
> > +/* ADC voltage ratio definition */
> > +#define SPRD_RATIO_NUMERATOR_OFFSET  16
> > +#define SPRD_RATIO_DENOMINATOR_MASK  GENMASK(15, 0)
> > +#define RATIO(n, d)                  (((n) << SPRD_RATIO_NUMERATOR_OFF=
SET) | (d))
> > +#define R_INVALID                    (0xffffffff)
> > +#define RATIO_DEF                    RATIO(1, 1)
>
> Prefix every define..
>
> > +
> > +/* ADC specific channel reference voltage 3.5V */
> > +#define SPRD_ADC_REFVOL_VDD35                3500000
> > +
> > +/* ADC default channel reference voltage is 2.8V */
> > +#define SPRD_ADC_REFVOL_VDD28                2800000
> > +
> > +#define SPRD_ADC_CELL_MAX            (2)
> > +#define SPRD_ADC_INVALID_DATA                (0XFFFFFFFF)
> > +#define SPRD_ADC_INIT_MAGIC          (0xa7a77a7a)
> > +#define ADC_MESURE_NUMBER_SW         (15)
> > +#define ADC_MESURE_NUMBER_HW_DEF     (3) /* 2 << 3 =3D 8 times */
>
> Prefix with SPRD and also the brackets around integer values have little =
purpose
> so drop them.  Note the ones around variables are good.
>
> > +
> > +#define CH_DATA_FMT "ch%d_d[(%d %d 0x%x 0x%x) | (%u/%u), (%u/%u), (%u/=
%u), (%u/%u), (%u/%u)]\n"
> This define hurts readability.  Just put in inline in the one place it's =
used for debug.
> > +
> > +#define SPRD_ADC_CHANNEL(index, mask) {                              \
> > +     .type =3D IIO_VOLTAGE,                                    \
> > +     .channel =3D index,                                       \
> > +     .info_mask_separate =3D mask | BIT(IIO_CHAN_INFO_SCALE),  \
> > +     .datasheet_name =3D "CH##index",                          \
> > +     .indexed =3D 1,                                           \
> > +}
> > +
> > +#define CH_DATA_INIT(sl, filter, isen, ip_r)         \
> > +{                                                    \
> > +     .scale =3D sl,                                    \
> > +     .isen_info =3D isen,                              \
> > +     .filter_info =3D filter,                          \
> > +     .ip_ratio =3D ip_r,                               \
> > +     .ch_aux_ratio =3D {0, 0, 0, 0},                   \
> > +     .inited =3D SPRD_ADC_INIT_MAGIC,                  \
> > +}
> > +
> > +#define CALIB_INFO_INIT(ch, sl, gph) \
> > +{                                    \
> > +     .channel =3D ch,                  \
> > +     .scale =3D sl,                    \
> > +     .graph =3D gph,                   \
> > +     .inited =3D SPRD_ADC_INIT_MAGIC,  \
> > +}
> > +
> > +#define GRAPH_POINT_INIT(v0, a0, v1, a1)\
>
> space before \
> also why the blank line here?
>
> > +                                     \
> > +     .volt0 =3D v0,                    \
> > +     .adc0 =3D a0,                     \
> > +     .volt1 =3D v1,                    \
> > +     .adc1 =3D a1,                     \
> > +     .inited =3D SPRD_ADC_INIT_MAGIC
> > +
>
> > +
> > +enum SPRD_PMIC_TYPE {
> > +     UMP9620_ADC,
> > +     UMP518_ADC,
> > +};
> > +
> > +enum SPRD_ADC_GRAPH_TYPE {
> > +     TWO_CELL_GRAPH,
> > +     SPRD_ADC_GRAPH_TYPE_MAX
> > +};
> > +
> > +enum SPRD_ADC_GRAPH_OFFSET {
> > +     GRAPH_BIG,
> > +     GRAPH_SMALL,
> > +     GRAPH_VBAT_DET,
> > +     GRAPH_MAX
> > +};
> > +
> > +enum SPRD_ADC_SCALE {
> > +     SCALE_00,
> > +     SCALE_01,
> > +     SCALE_10,
> > +     SCALE_11,
> > +     SPRD_ADC_SCALE_MAX
> > +};
> > +
> > +enum SPRD_ADC_REG_TYPE {
> > +     REG_MODULE_EN,
> > +     REG_CLK_EN,
> > +     REG_SOFT_RST,
> > +     REG_XTL_CTRL,
> > +     REG_SCALE,
> > +     REG_CFG_FIXED_ST =3D 11,/* FIXED CFG START */
> > +     REG_CAL_EN,
> > +     REG_NTC_MUX,
> > +     REG_CFG_FIXED_END,/* FIXED CFG END */
> > +     REG_ISEN_ST =3D 21,/* CURRENT MODE START */
> > +     REG_ISEN0,
> > +     REG_ISEN1,
> > +     REG_ISEN2,
> > +     REG_ISEN3,
> > +     REG_ISEN_END,/* CURRENT MODE END */
> > +     SPRD_ADC_REG_TYPE_MAX
> > +};
> > +
> > +enum SPRD_ADC_REG_BASE {
> > +     BASE_GLB,
> > +     BASE_ANA
> > +};
> > +
> > +struct sprd_adc_pm_data {
> > +     struct regmap *clk_regmap;
> > +     u32 clk_reg;/* adc clk26 vote reg */
> > +     u32 clk_reg_mask;/* adc clk26 vote reg mask */
> > +     bool dev_suspended;
> > +};
> > +
> > +/*bit[0-7]: scale
> /*
>  * bit[0-7]: scale
> ...
>  */
>
> However, what is it referring to?
>
> > + *bit[8-15]: filter_info(bit8: sw filter support, bit[9-15]: hw filter=
 val(2<<n))
> > + *bit[16-23]: isen_info (bit16: isen support, bit[17-23]: isen val)
> > + */
> > +struct sprd_adc_channel_data {
> > +     int scale;
> > +     int graph;
> > +     int isen_info;
> > +     int filter_info;
> > +     int ip_ratio;
> > +     int ch_aux_ratio[SPRD_ADC_SCALE_MAX];
> > +     int inited;
> > +};
> > +
> > +struct calib_info {
> > +     int channel;
> > +     int scale;
> > +     int graph;
> > +     int ch_aux_ratio[SPRD_ADC_SCALE_MAX];
> > +     int inited;
> > +};
> > +
> > +struct reg_bit {
>
> sprd_adc_reg_bit etc
> to reduce chance of a clash on naming in future.
>
> > +     u32 base;
> > +     u32 reg_addr;
> > +     u32 mask;
> > +     u32 offset;
> > +     u32 val_set;
> > +     u32 val_clr;
> > +     u32 inited;
> > +     bool reverse;
> > +     u32 (*get_val)(void *pri, int ch, bool set);
> > +};
>
>
>
> > +
> > +static void sprd_adc_calib_with_two_cell(struct sprd_adc_linear_graph =
*graph);
> > +static u32 get_isen(void *pri, int ch, bool enable);
> > +static int sprd_adc_soft_rst(struct sprd_adc_data *data);
> > +static int sprd_adc_hw_enable(struct sprd_adc_data *data);
>
> blank line here.
>
> > +static inline u32 GET_REG_ADDR(struct sprd_adc_data *data, int index)
> Unless you have a very strong reason don't tell the compiler what to inli=
ne.
> These hints are often limit what it can optimise somewhat and can hurt
> the actual performance.
>
> Generic naming without a prefix tends to break long term. Also, this is
> just a function, shouldn't be in capitals.
>
> sprd_adc_get_reg_addr()
>
>
> > +{
> > +     u32 base =3D ((data->var_data->reg_list[index].base =3D=3D BASE_G=
LB)
> > +                 ? (data->var_data->glb_reg_base)
> > +                 : (data->base - data->var_data->adc_reg_base_offset))=
;
> > +     return (base + data->var_data->reg_list[index].reg_addr);
> > +}
>
>
> > +
> > +static inline void sprd_adc_ch_data_show(struct sprd_adc_data *data, i=
nt ch)
> > +{
> > +     struct sprd_adc_channel_data *ch_data =3D &data->ch_data[ch];
> > +     struct u32_fract ip_fract, aux_fract0, aux_fract1, aux_fract2, au=
x_fract3;
> > +
> > +     ratio_to_u32_fract(ch_data->ip_ratio, &ip_fract);
> > +     ratio_to_u32_fract(ch_data->ch_aux_ratio[0], &aux_fract0);
> > +     ratio_to_u32_fract(ch_data->ch_aux_ratio[1], &aux_fract1);
> > +     ratio_to_u32_fract(ch_data->ch_aux_ratio[2], &aux_fract2);
> > +     ratio_to_u32_fract(ch_data->ch_aux_ratio[3], &aux_fract3);
> > +     dev_dbg(data->dev, CH_DATA_FMT,
> > +             ch, ch_data->scale, ch_data->graph, ch_data->isen_info, c=
h_data->filter_info,
> > +             ip_fract.numerator, ip_fract.denominator,
> > +             aux_fract0.numerator, aux_fract0.denominator,
> > +             aux_fract1.numerator, aux_fract1.denominator,
> > +             aux_fract2.numerator, aux_fract2.denominator,
> > +             aux_fract3.numerator, aux_fract3.denominator);
>
> A lot of code in this driver is debug.  Is it actually useful once you've=
 finished
> development?  I'd consider dropping at least some of it to reduce the amo=
unt of
> code you need to maintain long term.
>
> > +}
> > +
> > +static void sprd_adc_ch_data_merge(struct sprd_adc_data *data, struct =
sprd_adc_channel_data *d_diff,
>
> Long line - generally try to stay under 80 chars if it doesn't hurt reada=
bility
> and under 100 unless it's a message someone might want to grep for.
>
>
> > +                                struct sprd_adc_channel_data *d_def)
> > +{
> > +     struct sprd_adc_channel_data *ch_data;
> > +     int ch;
> > +
> > +     for (ch =3D 0; ch < SPRD_ADC_CHANNEL_MAX; ch++) {
> > +             ch_data =3D &data->ch_data[ch];
> > +             *ch_data =3D ((d_diff[ch].inited =3D=3D SPRD_ADC_INIT_MAG=
IC) ? d_diff[ch] : *d_def);
> > +     }
> > +
> > +     for (ch =3D 0; ch < SPRD_ADC_CHANNEL_MAX; ch++) {
> > +             sprd_adc_aux_ratio_init(data, ch);
> > +             sprd_adc_ch_data_show(data, ch);
> > +     }
> > +}
>
>
> > +static void ump9620_ch_data_init(struct sprd_adc_data *data)
> > +{
> > +     struct sprd_adc_channel_data ch_data_def =3D CH_DATA_INIT(SCALE_0=
0, 0, 0, RATIO_DEF);
> > +     struct sprd_adc_channel_data ch_data[SPRD_ADC_CHANNEL_MAX] =3D {
>
> const
>
> > +             [0] =3D CH_DATA_INIT(SCALE_01, 0, 0, RATIO_DEF),
> > +             [5] =3D CH_DATA_INIT(SCALE_00, 0x1, 0x9, RATIO_DEF),
> > +             [6] =3D CH_DATA_INIT(SCALE_00, 0x1, 0x9, RATIO_DEF),
> > +             [7] =3D CH_DATA_INIT(SCALE_10, 0, 0, RATIO_DEF),
> > +             [9] =3D CH_DATA_INIT(SCALE_10, 0, 0, RATIO_DEF),
> > +             [10] =3D CH_DATA_INIT(SCALE_11, 0, 0, RATIO_DEF),
> > +             [11] =3D CH_DATA_INIT(SCALE_00, 0, 0, RATIO_DEF),
> > +             [13] =3D CH_DATA_INIT(SCALE_01, 0, 0, RATIO_DEF),
> > +             [14] =3D CH_DATA_INIT(SCALE_00, 0, 0, RATIO(68, 900)),
> > +             [15] =3D CH_DATA_INIT(SCALE_00, 0, 0, RATIO(1, 3)),
> > +             [19] =3D CH_DATA_INIT(SCALE_11, 0, 0, RATIO_DEF),
> > +             [21] =3D CH_DATA_INIT(SCALE_00, 0, 0, RATIO(3, 8)),
> > +             [22] =3D CH_DATA_INIT(SCALE_00, 0, 0, RATIO(3, 8)),
> > +             [23] =3D CH_DATA_INIT(SCALE_00, 0, 0, RATIO(3, 8)),
> > +             [30] =3D CH_DATA_INIT(SCALE_11, 0, 0, RATIO_DEF),
> > +             [31] =3D CH_DATA_INIT(SCALE_11, 0, 0, RATIO_DEF),
> > +     };
> > +
> > +     sprd_adc_ch_data_merge(data, ch_data, &ch_data_def);
> > +}
> > +
>
> > +
> > +static int sprd_adc_isen_enable(struct sprd_adc_data *data, int channe=
l)
> > +{
> > +     bool isen_support =3D data->ch_data[channel].isen_info & 0x1;
>
> As below.
>
> > +
> > +     if (!isen_support)
> > +             return 0;
> > +
> > +     sprd_adc_regs_set_order(data, channel, REG_ISEN_ST, REG_ISEN_END)=
;
> > +     usleep_range(500, 1000);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sprd_adc_isen_disable(struct sprd_adc_data *data, int chann=
el)
> > +{
> > +     bool isen_support =3D data->ch_data[channel].isen_info & 0x1;
>
> FIELD_GET()
>
> > +
> > +     if (!isen_support)
> as isen_support not otherwise used.
>         if (!FIELD_GET(...., ....))
>
> > +             return 0;
> > +
> > +     sprd_adc_regs_clr_order_reverse(data, channel, REG_ISEN_ST, REG_I=
SEN_END);
> > +     usleep_range(500, 1000);
> > +
> > +     return 0;
> > +}
> > +
>
> > +
> > +static int sprd_adc_enable(struct sprd_adc_data *data, int channel)
> > +{
> > +     int ret =3D 0;
> > +     u32 reg_read =3D 0;
> > +
> > +     if (data->pm_data.clk_regmap) {
> > +             ret =3D regmap_update_bits(data->pm_data.clk_regmap, data=
->pm_data.clk_reg,
> > +                                      data->pm_data.clk_reg_mask,
> > +                                      data->pm_data.clk_reg_mask);
> > +             ret |=3D regmap_read(data->pm_data.clk_regmap, data->pm_d=
ata.clk_reg, &reg_read);
> > +             if (ret) {
> > +                     dev_err(data->dev, "failed to enable clk26m, chan=
nel %d\n", channel);
> > +                     return ret;
> > +             }
> > +             dev_dbg(data->dev, "enable clk26m: ch %d, reg_read 0x%x\n=
", channel, reg_read);
>
> Directly accessing the regmap of a clock seems unusual. Why not provide g=
eneric clock interfaces
> for this?

This register is used to vote to enable/disable the pmic 26m clk which
is provided to modules like audio, typec and adc.
Therefore, this clk cannot be disabled or enabled directly.

> > +     }
> > +
> > +     ret =3D sprd_adc_isen_enable(data, channel);
> > +     if (ret) {
> > +             dev_err(data->dev, "failed to enable isen\n");
> > +             return ret;
> > +     }
> > +
> > +     ret =3D regmap_update_bits(data->regmap, data->base + SPRD_ADC_CT=
L,
> > +                              SPRD_ADC_EN, SPRD_ADC_EN);
> > +     if (ret) {
> > +             dev_err(data->dev, "failed to set SPRD_ADC_EN\n");
> > +             return ret;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int sprd_adc_disable(struct sprd_adc_data *data, int channel)
> > +{
> > +     int ret =3D 0;
>
> Set just below here. Check for other instances of this.
>
> > +     u32 reg_read =3D 0;
> > +
> > +     ret =3D regmap_update_bits(data->regmap, data->base + SPRD_ADC_CT=
L, SPRD_ADC_EN, 0);
> > +     if (ret) {
> > +             dev_err(data->dev, "failed to reset SPRD_ADC_EN\n");
> > +             return ret;
> > +     }
> > +
> > +     ret =3D sprd_adc_isen_disable(data, channel);
> > +     if (ret) {
> > +             dev_err(data->dev, "failed to disable isen\n");
> > +             return ret;
> > +     }
> > +
> > +     if (data->pm_data.clk_regmap) {
> > +             ret =3D regmap_update_bits(data->pm_data.clk_regmap, data=
->pm_data.clk_reg,
> > +                                      data->pm_data.clk_reg_mask, 0);
> > +             ret |=3D regmap_read(data->pm_data.clk_regmap, data->pm_d=
ata.clk_reg, &reg_read);
>
> Don't combine ret values. Can result in complete garbage.  Just handle ea=
ch error
> separately.  It costs a few lines, but always works!
>
> > +             if (ret) {
> > +                     dev_err(data->dev, "failed to disable clk26m, cha=
nnel %d\n", channel);
> > +                     return ret;
> > +             }
> > +             dev_dbg(data->dev, "disable clk26m: ch %d, reg_read 0x%x\=
n", channel, reg_read);
> > +     }
> > +
> > +     return ret;
>
> return 0;
> Can't get here with any other value that I can see.
>
> > +}
> > +
> > +static int sprd_adc_read(struct sprd_adc_data *data, int channel, int =
scale, int *val)
> > +{
> > +     int ret =3D 0, sample_num_sw;
> > +     u32 rawdata =3D 0, tmp, status, scale_shift, scale_mask;
> > +     bool filter_sw =3D data->ch_data[channel].filter_info & 0x1;
> > +     int sample_num_hw =3D data->ch_data[channel].filter_info >> 1;
>
> FIELD_GET() for both of these.
>
> > +
> > +     if (data->pm_data.dev_suspended) {
> > +             dev_err(data->dev, "adc_exp: adc bas been suspended, igno=
re.\n");
>
> has
>
> > +             return -EBUSY;
> > +     }
> > +
> > +     dev_dbg(data->dev, "ch_data[%d]: scale %d, graph %d, filter_info =
0x%x, isen_info 0x%x\n",
> > +             channel, data->ch_data[channel].scale, data->ch_data[chan=
nel].graph,
> > +             data->ch_data[channel].filter_info, data->ch_data[channel=
].isen_info);
> > +
> > +     ret =3D hwspin_lock_timeout_raw(data->hwlock, SPRD_ADC_HWLOCK_TIM=
EOUT);
> > +     if (ret) {
> > +             dev_err(data->dev, "timeout to get the hwspinlock\n");
>
> timeout getting the
> or
> timeout trying to get
>
> > +             return ret;
> > +     }
> > +
> > +     ret =3D sprd_adc_enable(data, channel);
> > +     if (ret)
> > +             goto disable_adc;
> > +
> > +     ret =3D regmap_update_bits(data->regmap, data->base + SPRD_ADC_IN=
T_CLR,
> > +                              SPRD_ADC_IRQ_CLR, SPRD_ADC_IRQ_CLR);
> > +     if (ret)
> > +             goto disable_adc;
> > +
> > +     /* Configure the channel id and scale */
> > +     scale_shift =3D data->var_data->reg_list[REG_SCALE].offset;
> > +     scale_mask =3D data->var_data->reg_list[REG_SCALE].mask;
> > +     tmp =3D (scale << scale_shift) & scale_mask;
> > +     tmp |=3D channel & SPRD_ADC_CHN_ID_MASK;
> > +     ret =3D regmap_update_bits(data->regmap, data->base + SPRD_ADC_CH=
_CFG,
> > +                              SPRD_ADC_CHN_ID_MASK | scale_mask, tmp);
> > +     if (ret)
> > +             goto disable_adc;
> > +
> > +     /* Select 12bit conversion mode, and only sample 1 time */
> > +     tmp =3D SPRD_ADC_12BIT_MODE;
> > +     sample_num_sw =3D (filter_sw ? ADC_MESURE_NUMBER_SW - 1 : 0);
> > +     sample_num_hw =3D ((sample_num_hw > 0) ? sample_num_hw : ADC_MESU=
RE_NUMBER_HW_DEF);
> > +     tmp |=3D ((unsigned long)sample_num_sw << SPRD_ADC_RUN_NUM_SHIFT)=
 & SPRD_ADC_RUN_NUM_MASK;
> > +     tmp |=3D ((unsigned long)sample_num_hw << SPRD_ADC_AVERAGE_SHIFT)=
 & SPRD_ADC_AVERAGE_MASK;
> > +     ret =3D regmap_update_bits(data->regmap, data->base + SPRD_ADC_CT=
L,
> > +                              SPRD_ADC_RUN_NUM_MASK | SPRD_ADC_12BIT_M=
ODE |
> > +                              SPRD_ADC_AVERAGE_MASK, tmp);
> > +     if (ret)
> > +             goto disable_adc;
> > +
> > +     ret =3D regmap_update_bits(data->regmap, data->base + SPRD_ADC_CT=
L,
> > +                              SPRD_ADC_CHN_RUN, SPRD_ADC_CHN_RUN);
> > +     if (ret)
> > +             goto disable_adc;
> > +
> > +     ret =3D regmap_read_poll_timeout(data->regmap, data->base + SPRD_=
ADC_INT_RAW, status,
> > +                                    (status & SPRD_ADC_IRQ_RAW), SPRD_=
ADC_POLL_RAW_STATUS,
> > +                                    SPRD_ADC_RDY_TIMEOUT);
> > +     if (ret) {
> > +             dev_err(data->dev, "read adc timeout 0x%x\n", status);
> > +             sprd_adc_regs_dump(data, channel, scale, "t_bef");
> > +             sprd_adc_hw_enable(data);
> > +             sprd_adc_soft_rst(data);
> > +             sprd_adc_regs_dump(data, channel, scale, "t_aft");
> > +             goto disable_adc;
> > +     }
> > +
> > +     if (filter_sw) {
> > +             rawdata =3D sprd_adc_get_val_with_sw_filter(data, channel=
);
> > +     } else {
> > +             ret =3D regmap_read(data->regmap, data->base + SPRD_ADC_D=
ATA, &rawdata);
> check ret.
> > +             rawdata &=3D SPRD_ADC_DATA_MASK;
> > +     }
> > +disable_adc:
> > +     ret =3D sprd_adc_disable(data, channel);
> > +
> > +     hwspin_unlock_raw(data->hwlock);
> > +
> > +     if (!ret)
> > +             *val =3D rawdata;
> I think val is valid even if the disable fails. So do it up a few lines u=
nconditionally.
>
> > +
> > +     return ret;
> > +}
> > +
> > +static int sprd_adc_calculate_volt_by_graph(struct sprd_adc_data *data=
, int channel,
> > +                                         int scale, int raw_adc)
> > +{
> > +     int tmp;
> > +     struct sprd_adc_graphs *graphs =3D &sprd_adc_graphs_array[data->v=
ar_data->graph_index];
> > +     int graph_offset =3D data->ch_data[channel].graph;
> > +     struct sprd_adc_linear_graph *linear_graph =3D &graphs->adc_graph=
s[graph_offset];
> > +
> > +     tmp =3D (linear_graph->volt0 - linear_graph->volt1) * (raw_adc - =
linear_graph->adc1);
> > +     tmp /=3D (linear_graph->adc0 - linear_graph->adc1);
> > +     tmp +=3D linear_graph->volt1;
> > +     tmp =3D (tmp < 0 ? 0 : tmp);
>
>         tmp =3D max(0, tmp) perhaps makes it clearer this is clamping a s=
mall negative (I think)
>
> > +
> > +     dev_dbg(data->dev, "by_graph_c%d: v0 %d a0 %d, v1 %d a1 %d, raw_a=
dc 0x%x, vol_graph %d\n",
> > +             channel, linear_graph->volt0, linear_graph->adc0, linear_=
graph->volt1,
> > +             linear_graph->adc1, raw_adc, tmp);
> > +
> > +     return tmp;
> > +}
> > +
> > +static int sprd_adc_calculate_volt_by_ratio(struct sprd_adc_data *data=
, int channel,
> > +                                         int scale, int vol_graph)
> > +{
> > +     struct u32_fract ip_fract, aux_fract;
> > +     int pmic_type =3D data->var_data->pmic_type;
> > +     u32 vol_final =3D vol_graph;
> > +
> > +     ratio_to_u32_fract(data->ch_data[channel].ip_ratio, &ip_fract);
> > +     vol_final =3D DIV_ROUND_CLOSEST(vol_final * ip_fract.denominator,=
 ip_fract.numerator);
> > +
> > +     ratio_to_u32_fract(data->ch_data[channel].ch_aux_ratio[scale], &a=
ux_fract);
> > +     vol_final =3D DIV_ROUND_CLOSEST(vol_final * aux_fract.denominator=
, aux_fract.numerator);
> > +
> > +     dev_dbg(data->dev, "by_ratio_c%d: id %d, scale %d, ip_r[%d/%d], a=
ux_r[%d/%d], vol_f %d\n",
> > +             channel, pmic_type, scale, ip_fract.numerator, ip_fract.d=
enominator,
> > +             aux_fract.numerator, aux_fract.denominator, vol_final);
> > +
> > +     return vol_final;
> > +}
> > +
> > +static int sprd_adc_read_processed(struct sprd_adc_data *data, int cha=
nnel, int scale, int *val)
> > +{
> > +     int ret, raw_adc, vol_graph;
> > +
> > +     ret =3D sprd_adc_read(data, channel, scale, &raw_adc);
> > +
> > +     if (ret)
> > +             return ret;
> > +
> > +     vol_graph =3D sprd_adc_calculate_volt_by_graph(data, channel, sca=
le, raw_adc);
> > +     *val =3D sprd_adc_calculate_volt_by_ratio(data, channel, scale, v=
ol_graph);
> > +
> > +     return 0;
> > +}
> > +
> > +static int sprd_adc_ch_data_encode(struct sprd_adc_data *data, int ch)
> > +{
> > +     int scale =3D data->ch_data[ch].scale & 0xff;
> > +     int isen_info =3D data->ch_data[ch].isen_info & 0xff;
> > +     int filter_info =3D data->ch_data[ch].filter_info & 0xff;
> > +
> > +     return (scale | (filter_info << 8) | (isen_info << 16));
>
> As below - looks like an array of u8. Treat it as such or use FIELD_PREP(=
)
> and treat it as a u32
>
>
> > +}
> > +
> > +static void sprd_adc_ch_data_decode(struct sprd_adc_data *data, int ch=
, int val)
> > +{
> > +     int scale_override, filter_override, isen_override;
> > +
> > +     scale_override =3D (val & 0xff);
> > +     filter_override =3D ((val >> 8) & 0xff);
> > +     isen_override =3D ((val >> 16) & 0xff);
>
> FIELD_GET() with appropriate mask defines.
> Or just convert it to an array of u8 with appropriate endian conversion.
>
>
> > +
> > +     if (scale_override < SPRD_ADC_SCALE_MAX && scale_override !=3D da=
ta->ch_data[ch].scale)
> > +             data->ch_data[ch].scale =3D scale_override;
> > +
> > +     if (data->ch_data[ch].filter_info !=3D filter_override)
> > +             data->ch_data[ch].filter_info =3D filter_override;
> > +
> > +     if (data->ch_data[ch].isen_info !=3D isen_override)
> > +             data->ch_data[ch].isen_info =3D isen_override;
> > +}
> > +
>
> ...
>
> > +static int sprd_adc_hw_enable(struct sprd_adc_data *data)
> > +{
> > +     int ret;
> > +     u32 reg_addr, mask;
> > +
> > +     reg_addr =3D GET_REG_ADDR(data, REG_XTL_CTRL);
>
> I'm not sure the local variables much help readability.
> So I'd just put them inline instead perhaps providing a
> local variabel for the reglist.
>         u32 *reg_list =3D data->var_data->reg_list;
>
>         ret =3D regmap_update_bits(data->regmap,
>                                  GET_REG_ADDR(data, REG_XTL_CTRL),
>                                  reg_list[REG_XTL_CTRL]);
>
> etc.  May make sense for other similar cases.
>
>
> > +     mask =3D data->var_data->reg_list[REG_XTL_CTRL].mask;
> > +     ret =3D regmap_update_bits(data->regmap, reg_addr, mask, mask);
> > +     if (ret)
> > +             return ret;
> > +
> > +     reg_addr =3D GET_REG_ADDR(data, REG_MODULE_EN);
> > +     mask =3D data->var_data->reg_list[REG_MODULE_EN].mask;
> > +     ret =3D regmap_update_bits(data->regmap, reg_addr, mask, mask);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Enable ADC work clock */
> > +     reg_addr =3D GET_REG_ADDR(data, REG_CLK_EN);
> > +     mask =3D data->var_data->reg_list[REG_CLK_EN].mask;
> > +     ret =3D regmap_update_bits(data->regmap, reg_addr, mask, mask);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
>
>         return regmap_update_bits()
>
> > +}
> > +
>
> > +
> > +static int sprd_adc_ch_data_init(struct sprd_adc_data *data)
> > +{
> > +     struct device_node *np =3D data->dev->of_node;
> > +     int size, ret, ch, ch_data_val, i;
> > +     u32 *ch_data_override;
> > +
> > +     data->var_data->ch_data_init(data);
> > +
> > +     size =3D of_property_count_elems_of_size(np, "ch_data_override", =
sizeof(u32));
> > +     if (size <=3D 0)
> > +             return 0;
> > +
> > +     if (size % 2) {
> > +             dev_err(data->dev, "Pair of ch data err!\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ch_data_override =3D kcalloc(size, sizeof(u32), GFP_KERNEL);
> > +     if (!ch_data_override)
> > +             return -ENOMEM;
> > +
> > +     ret =3D of_property_read_u32_array(np, "ch_data_override", ch_dat=
a_override, size);
> > +     if (ret < 0) {
> > +             dev_err(data->dev, "Failed to read ch data from dt: %d\n"=
, ret);
> > +             kfree(ch_data_override);
>
> Probably better to use a goto for this cleanup so it can be shared with t=
he normal
> exit path. Of if you want to have fun (and don't need to backport this),
> try the new __free() infrastructure to do scope based cleanup found in
>
> linux/cleanup.h
>
> This sort of pattern is exactly what that code is for.
>
>
> > +             return ret;
> > +     }
> > +
> > +     for (i =3D 0; i < size; i +=3D 2) {
> > +             ch =3D ch_data_override[i];
> > +             ch_data_val =3D ch_data_override[i+1];
> kernel style always has spaces around an operator with two parameters.
> [i + 1]
> > +             sprd_adc_ch_data_decode(data, ch, ch_data_val);
> > +             sprd_adc_ch_data_show(data, ch);
> > +     }
> > +
> > +     kfree(ch_data_override);
> > +
> > +     return 0;
> > +}
> > +
>
> > +
> > +static int sprd_adc_probe(struct platform_device *pdev)
> > +{
> > +     struct device_node *np =3D pdev->dev.of_node;
> > +     struct sprd_adc_data *sprd_data;
> > +     const struct sprd_adc_variant_data *pdata;
> > +     struct iio_dev *indio_dev;
> > +     int ret;
> > +
> > +     pdata =3D of_device_get_match_data(&pdev->dev);
>
> device_get_match_data()
>
>
> > +     if (!pdata) {
> > +             dev_err(&pdev->dev, "No matching driver data found\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*sprd_data=
));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     sprd_data =3D iio_priv(indio_dev);
> > +
> > +     sprd_data->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > +     if (!sprd_data->regmap) {
> > +             dev_err(&pdev->dev, "failed to get ADC regmap\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     ret =3D of_property_read_u32(np, "reg", &sprd_data->base);
>
> Even though some elements of this (of_hwspin...) don't have generic firmw=
are
> interfaces, I would prefer to see those from linux/property.h used
> wherever possible.  It will take us a long time to make that a subsystem
> wide change, but good not to have more unnecessary instances of device tr=
ee
> specific property reading.

Sorry, I don't understand what needs to be modified. Can you provide
more information or give an example?
Do you mean that the "reg"  property reading is unnecessary?

> > +     if (ret) {
> > +             dev_err(&pdev->dev, "failed to get ADC base address\n");
> > +             return ret;
> > +     }
> > +
> > +     sprd_data->irq =3D platform_get_irq(pdev, 0);
> > +     if (sprd_data->irq < 0) {
> > +             dev_err(&pdev->dev, "failed to get ADC irq number\n");
> > +             return sprd_data->irq;
> > +     }
> > +
> > +     ret =3D of_hwspin_lock_get_id(np, 0);
> > +     if (ret < 0) {
> > +             dev_err(&pdev->dev, "failed to get hwspinlock id\n");
> > +             return ret;
> > +     }
> > +
> > +     mutex_init(&sprd_data->mutex);
> > +     sprd_data->hwlock =3D hwspin_lock_request_specific(ret);
> > +     if (!sprd_data->hwlock) {
> > +             dev_err(&pdev->dev, "failed to request hwspinlock\n");
> > +             return -ENXIO;
> > +     }
> > +
> > +     ret =3D devm_add_action(&pdev->dev, sprd_adc_free_lock, sprd_data=
);
> > +     if (ret) {
> > +             sprd_adc_free_lock(sprd_data);
>
> devm_add_action_or_reset() as below.  Same for any more cases of this, I =
won't
> mention it again (not I review up the driver as they make more logical se=
nse
> to me that way around ;)
>
> > +             dev_err(&pdev->dev, "failed to add free lock action\n");
> > +             return ret;
> > +     }
> > +
> > +     sprd_data->dev =3D &pdev->dev;
> > +     sprd_data->var_data =3D pdata;
> > +     sprd_data->indio_dev =3D indio_dev;
> > +
> > +     /* ADC channel scales calibration from nvmem device */
> > +     ret =3D sprd_adc_graphs_calibrate(sprd_data);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "failed to calib graphs from nvmem\n"=
);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D sprd_adc_pm_init(sprd_data);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "adc pm init err.\n");
> > +             return ret;
> > +     }
> > +
> > +     ret =3D sprd_adc_ch_data_init(sprd_data);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "ch data init err.\n");
> > +             return ret;
> > +     }
> > +
> > +     ret =3D sprd_adc_hw_enable(sprd_data);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "failed to enable ADC module\n");
> > +             return ret;
> > +     }
> > +
> > +     ret =3D devm_add_action(&pdev->dev, sprd_adc_hw_disable, sprd_dat=
a);
>
> ret =3D devm_add_action_or_reset() and...
>
> > +     if (ret) {
> > +             sprd_adc_hw_disable(sprd_data);
>
> drop this.
>
> This is such a common case that we have the or_reset() form for it.
>
> > +             dev_err(&pdev->dev, "failed to add ADC disable action\n")=
;
> > +             return ret;
>
> return dev_err_probe(&pdev->dev, ret, "...");
> Same for all similar error handling in probe, or functions that are only
> called from probe.
>
> > +     }
> > +
> > +     ret =3D sprd_adc_soft_rst(sprd_data);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "adc soft rst failed\n");
> > +             return ret;
>                 return dev_err_probe(...);
>
> > +     }
> > +
> > +     indio_dev->dev.parent =3D &pdev->dev;
> > +     indio_dev->name =3D dev_name(&pdev->dev);
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->info =3D &sprd_info;
> > +     indio_dev->channels =3D sprd_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(sprd_channels);
> > +     ret =3D devm_iio_device_register(&pdev->dev, indio_dev);
> > +     if (ret)
> > +             dev_err(&pdev->dev, "could not register iio (ADC)");
>
> Prefer return dev_err_probe() in all cases.
> Also should not carry on to set drvdata if this failed as we should never
> need it.
>
> > +
> > +     platform_set_drvdata(pdev, indio_dev);
> > +
> > +     return ret;
> > +}
>
> > +
> > +static const struct sprd_adc_variant_data ump9620_data =3D {
> > +     .pmic_type =3D UMP9620_ADC,
> > +     .glb_reg_base =3D 0x2000,
> > +     .adc_reg_base_offset =3D 0x4,
> > +     .reg_list =3D regs_ump9620,
> > +     .graph_index =3D TWO_CELL_GRAPH,
> > +     .calib_infos =3D {
> > +             CALIB_INFO_INIT(11, SCALE_00, GRAPH_BIG),
> > +             CALIB_INFO_INIT(1, SCALE_00, GRAPH_SMALL),
> > +             CALIB_INFO_INIT(0, SCALE_01, GRAPH_VBAT_DET)
> > +     },
> > +     .aux_ratio_comm =3D {RATIO_DEF, RATIO(100, 133), RATIO(1000, 2600=
), RATIO(1000, 4060)},
> > +     .ch_data_init =3D ump9620_ch_data_init,
> > +};
> > +
> > +static const struct sprd_adc_variant_data ump518_data =3D {
> > +     .pmic_type =3D UMP518_ADC,
> > +     .glb_reg_base =3D 0x1800,
> > +     .adc_reg_base_offset =3D 0x4,
> > +     .reg_list =3D regs_ump9620,
> > +     .graph_index =3D TWO_CELL_GRAPH,
> > +     .calib_infos =3D {
> > +             CALIB_INFO_INIT(11, SCALE_00, GRAPH_BIG),
> > +             CALIB_INFO_INIT(1, SCALE_00, GRAPH_SMALL),
> > +             CALIB_INFO_INIT(0, SCALE_01, GRAPH_VBAT_DET)
> > +     },
> > +     .aux_ratio_comm =3D {RATIO_DEF, RATIO(100, 133), RATIO(1000, 2600=
), RATIO(1000, 4060)},
> > +     .ch_data_init =3D ump9620_ch_data_init,
> > +};
> > +
> > +static const struct of_device_id sprd_adc_of_match[] =3D {
> > +     { .compatible =3D "sprd,ump9620-adc", .data =3D &ump9620_data},
> > +     { .compatible =3D "sprd,ump518-adc", .data =3D &ump518_data},
>
> Space before } for consistency with the opening bracket.
>
> Numerical order preferred as for the bindings.
>
> > +     { }
> > +};
> > +
> > +static const struct dev_pm_ops sprd_adc_pm_ops =3D {
> > +     .suspend_noirq =3D sprd_adc_pm_suspend,
> > +     .resume_noirq =3D sprd_adc_pm_resume,
> > +};
> > +
> > +static struct platform_driver sprd_adc_driver =3D {
> > +     .probe =3D sprd_adc_probe,
> > +     .driver =3D {
> > +             .name =3D "sprd-adc",
> > +             .of_match_table =3D sprd_adc_of_match,
> > +             .pm     =3D &sprd_adc_pm_ops,
>
> Just space before =3D not a tab.
>
> Also what stops this building without pm_sleep support?
> You probably should either map to one of the macros that set the pm
> ops up or add pm_sleep_ptr() protection to allow the sprd_adc_pm_ops
> structure to be removed if appropriate.
>
> > +     },
> > +};
> > +
> > +module_platform_driver(sprd_adc_driver);
> > +MODULE_DESCRIPTION("SPRD PMIC ADC Driver");
> > +MODULE_LICENSE("GPL");
>
