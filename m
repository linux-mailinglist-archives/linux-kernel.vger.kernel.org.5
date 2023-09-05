Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1360A792B0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjIEQqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343948AbjIEC7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:59:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3DBCC6;
        Mon,  4 Sep 2023 19:59:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a64619d8fbso271268566b.0;
        Mon, 04 Sep 2023 19:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693882786; x=1694487586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxWUNwYphtC2MjkU9wb4XrP5jvw/E3bI2SXm+N5BiH4=;
        b=qE9M5xjoLowHM6p/7WXXpMJmYN4HM9tVSc0zOO1feVk+mvJbn/eG+J527ED0ECaqA1
         WkCTYjBvOCrVVgsVu8T/ZXgtGUCTK53StgJd5FCNhMD402luj+6nmvDppAPguB38bUM9
         uNtLfy0cO1sOlzIPRSOWACRa/dhMwxMNb9eLLBO/479RVsQnjsC2bYM+W0eph53YCgrA
         3tXSDp4Wp6FDYP4xHJRzE61x31v0krJ/Uv6FwHvsaBdTKzULKIQUunw24eAiF0PfNY6F
         6A+l60MOge7OR1YalC0jfbjvGB4MsEcZD+Kxrd5Wk6Q7JJ01Wvnme1uhxvuHYT4QvE3T
         GzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693882786; x=1694487586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxWUNwYphtC2MjkU9wb4XrP5jvw/E3bI2SXm+N5BiH4=;
        b=Vo5bn2kDMW1MzLIHCtTywvcjlGYmh0pVYE3fOGaa+en2X35BZMwqbAh+rX+vZeJRpY
         alP2DgI44hFGYEaDp692/VV5Dh7i92U5hJ2Y+m3PK6NtdrasdxXNCgfyTQ7CtLqsxOKZ
         R0kXUMc3Jy2iug2ct9+0yaxk9euHrVVDiy6iMDtQpvTF3AseLPaNqW6jOnZfAO3XmBsK
         Odf7zFl5sgaZiw0ZzPj3toANLthkNsizZXv3GlOpfln6CjAFLwgSzOSscbkSGCgYGZh7
         Y1XqpPzcO7aThtdhjeCrG5hCTAcX0oS9kHnvZTb0XWHwvQei/lV5Gh6EhBpvWMa+Imvc
         wMGg==
X-Gm-Message-State: AOJu0YwcvhgSdx8AnFh9FfAjYw1NGrmnK3b9Bu/BqFcmLhf+w2ZUeVs1
        TpbhwHEEQwhpDAsDskE6Lftr+NTYTFzLWm28I+g=
X-Google-Smtp-Source: AGHT+IEQy22rB5pO4ydeBXGpSDuCnae3CUKSyHU4KJdZ1HSIdgd17i/J7e3S6nL8cMfvFRM6JQZOYkf6ebH4p/LdLAs=
X-Received: by 2002:a17:907:78c2:b0:9a1:b05a:c07c with SMTP id
 kv2-20020a17090778c200b009a1b05ac07cmr10058405ejc.55.1693882785945; Mon, 04
 Sep 2023 19:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230816080225.21482-1-mingjin.yang@unisoc.com>
 <20230816080225.21482-3-mingjin.yang@unisoc.com> <20230828165709.56ffa299@jic23-huawei>
 <CAKJtOf5chsyPrnMZGv32YFvxG1x5cDtBQmzk7wRqCn7C2+cB=g@mail.gmail.com> <20230903121437.520e5da3@jic23-huawei>
In-Reply-To: <20230903121437.520e5da3@jic23-huawei>
From:   =?UTF-8?B?5p2o5piO6YeR?= <magicyangmingjin@gmail.com>
Date:   Tue, 5 Sep 2023 10:59:33 +0800
Message-ID: <CAKJtOf6N0P9Phqsm-2B1p1kCZ+Tezz3rZ8muLzAvXQoi=QFCtg@mail.gmail.com>
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

> > > > +static int sprd_adc_enable(struct sprd_adc_data *data, int channel=
)
> > > > +{
> > > > +     int ret =3D 0;
> > > > +     u32 reg_read =3D 0;
> > > > +
> > > > +     if (data->pm_data.clk_regmap) {
> > > > +             ret =3D regmap_update_bits(data->pm_data.clk_regmap, =
data->pm_data.clk_reg,
> > > > +                                      data->pm_data.clk_reg_mask,
> > > > +                                      data->pm_data.clk_reg_mask);
> > > > +             ret |=3D regmap_read(data->pm_data.clk_regmap, data->=
pm_data.clk_reg, &reg_read);
> > > > +             if (ret) {
> > > > +                     dev_err(data->dev, "failed to enable clk26m, =
channel %d\n", channel);
> > > > +                     return ret;
> > > > +             }
> > > > +             dev_dbg(data->dev, "enable clk26m: ch %d, reg_read 0x=
%x\n", channel, reg_read);
> > >
> > > Directly accessing the regmap of a clock seems unusual. Why not provi=
de generic clock interfaces
> > > for this?
> >
> > This register is used to vote to enable/disable the pmic 26m clk which
> > is provided to modules like audio, typec and adc.
> > Therefore, this clk cannot be disabled or enabled directly.
>
> clk_enable() and friends support reference counted enable and disable
> so I don't understand why this needs something unusual.

Through communication with internal clk colleagues,
I learned that this register is not a traditional eb register,
so the current clk driver is not configured to support this.

Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2023=E5=B9=B49=E6=9C=883=E6=97=
=A5=E5=91=A8=E6=97=A5 19:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 30 Aug 2023 15:15:12 +0800
> =E6=9D=A8=E6=98=8E=E9=87=91 <magicyangmingjin@gmail.com> wrote:
>
> > Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=B8=80 23:56=E5=86=99=E9=81=93=EF=BC=9A
> > >
> Hi,
>
> Please crop replies to relevant part only.  Hopefully I found it!
>
>
> > > > +static int sprd_adc_enable(struct sprd_adc_data *data, int channel=
)
> > > > +{
> > > > +     int ret =3D 0;
> > > > +     u32 reg_read =3D 0;
> > > > +
> > > > +     if (data->pm_data.clk_regmap) {
> > > > +             ret =3D regmap_update_bits(data->pm_data.clk_regmap, =
data->pm_data.clk_reg,
> > > > +                                      data->pm_data.clk_reg_mask,
> > > > +                                      data->pm_data.clk_reg_mask);
> > > > +             ret |=3D regmap_read(data->pm_data.clk_regmap, data->=
pm_data.clk_reg, &reg_read);
> > > > +             if (ret) {
> > > > +                     dev_err(data->dev, "failed to enable clk26m, =
channel %d\n", channel);
> > > > +                     return ret;
> > > > +             }
> > > > +             dev_dbg(data->dev, "enable clk26m: ch %d, reg_read 0x=
%x\n", channel, reg_read);
> > >
> > > Directly accessing the regmap of a clock seems unusual. Why not provi=
de generic clock interfaces
> > > for this?
> >
> > This register is used to vote to enable/disable the pmic 26m clk which
> > is provided to modules like audio, typec and adc.
> > Therefore, this clk cannot be disabled or enabled directly.
>
> clk_enable() and friends support reference counted enable and disable
> so I don't understand why this needs something unusual.
>
>
> >
>
> > > > +static int sprd_adc_probe(struct platform_device *pdev)
> > > > +{
> > > > +     struct device_node *np =3D pdev->dev.of_node;
> > > > +     struct sprd_adc_data *sprd_data;
> > > > +     const struct sprd_adc_variant_data *pdata;
> > > > +     struct iio_dev *indio_dev;
> > > > +     int ret;
> > > > +
> > > > +     pdata =3D of_device_get_match_data(&pdev->dev);
> > >
> > > device_get_match_data()
> > >
> > >
> > > > +     if (!pdata) {
> > > > +             dev_err(&pdev->dev, "No matching driver data found\n"=
);
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*sprd_=
data));
> > > > +     if (!indio_dev)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     sprd_data =3D iio_priv(indio_dev);
> > > > +
> > > > +     sprd_data->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > > > +     if (!sprd_data->regmap) {
> > > > +             dev_err(&pdev->dev, "failed to get ADC regmap\n");
> > > > +             return -ENODEV;
> > > > +     }
> > > > +
> > > > +     ret =3D of_property_read_u32(np, "reg", &sprd_data->base);
> > >
> > > Even though some elements of this (of_hwspin...) don't have generic f=
irmware
> > > interfaces, I would prefer to see those from linux/property.h used
> > > wherever possible.  It will take us a long time to make that a subsys=
tem
> > > wide change, but good not to have more unnecessary instances of devic=
e tree
> > > specific property reading.
> >
> > Sorry, I don't understand what needs to be modified. Can you provide
> > more information or give an example?
> > Do you mean that the "reg"  property reading is unnecessary?
>
> No.  Where possibly use
>         device_property_read_u32(dev, "reg".. etc
> and similar functions from
> include/linux/property.h rather than device tree specific ones.
> The generic property handling deals with various different types of firmw=
are
> without needing drivers to be aware of it.
>
> Some elements that you need here do not have generic property handling so
> for those you will need to continue using the of_ variants.
> Note that this is to support long term move of everything to the generic
> firmware framework.  Even if we drivers in IIO etc that are really device
> tree only there are benefits for maintenance in using one framework
> for all drivers. As some IIO drivers do support other firmware types
> (ACPI for example) the generic version is the preferred choice.
>
> Thanks,
>
> Jonathan
