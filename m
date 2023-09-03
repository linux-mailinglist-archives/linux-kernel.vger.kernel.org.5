Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4021C790B8E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbjICLOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbjICLOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:14:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB9691;
        Sun,  3 Sep 2023 04:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4298160B71;
        Sun,  3 Sep 2023 11:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558EDC433C7;
        Sun,  3 Sep 2023 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693739652;
        bh=xksW8ataBM3f2JzXguQZovnO398ymnhbyG6nZVbqfD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IAtKUIWM9jclNpk6e5lL94sA0jaKmlsoEfUmF6skVscFFFJ+l+Ba0aaiauE7/UKbj
         IZjxSWs4hZ2SUIeI1/9QuluWVOZZSxe5h/dlsqCPrTrtOIU7pT0XZonYv/MDipi4lV
         Jhv8t0Px3AkBOproF+9gcC6YGB3Bt7+JQqRTnRmxH8NjDWJvXKmtnGS0kiONG4Wwh2
         pHy7SZxk292sjJ1sLD++/pDUIrYtB/yjdon2AxbyrHI1jd303fMIuGYzokTOFwdNAy
         uQ5SsBnDf3ykHLGkmjhHvtfCKTRvH8lbDoB3mc8BTjQvXSr1bezvOF8TdTTB2bnOeE
         Db4IFe/ygKGIA==
Date:   Sun, 3 Sep 2023 12:14:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?5p2o5piO6YeR?= <magicyangmingjin@gmail.com>
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
Subject: Re: [PATCH V0 2/2] iio: adc: sprd_pmic_adc: Add support for UMP
 serise pmic adc
Message-ID: <20230903121437.520e5da3@jic23-huawei>
In-Reply-To: <CAKJtOf5chsyPrnMZGv32YFvxG1x5cDtBQmzk7wRqCn7C2+cB=g@mail.gmail.com>
References: <20230816080225.21482-1-mingjin.yang@unisoc.com>
        <20230816080225.21482-3-mingjin.yang@unisoc.com>
        <20230828165709.56ffa299@jic23-huawei>
        <CAKJtOf5chsyPrnMZGv32YFvxG1x5cDtBQmzk7wRqCn7C2+cB=g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 30 Aug 2023 15:15:12 +0800
=E6=9D=A8=E6=98=8E=E9=87=91 <magicyangmingjin@gmail.com> wrote:

> Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=80 23:56=E5=86=99=E9=81=93=EF=BC=9A
> >
Hi,

Please crop replies to relevant part only.  Hopefully I found it!


> > > +static int sprd_adc_enable(struct sprd_adc_data *data, int channel)
> > > +{
> > > +     int ret =3D 0;
> > > +     u32 reg_read =3D 0;
> > > +
> > > +     if (data->pm_data.clk_regmap) {
> > > +             ret =3D regmap_update_bits(data->pm_data.clk_regmap, da=
ta->pm_data.clk_reg,
> > > +                                      data->pm_data.clk_reg_mask,
> > > +                                      data->pm_data.clk_reg_mask);
> > > +             ret |=3D regmap_read(data->pm_data.clk_regmap, data->pm=
_data.clk_reg, &reg_read);
> > > +             if (ret) {
> > > +                     dev_err(data->dev, "failed to enable clk26m, ch=
annel %d\n", channel);
> > > +                     return ret;
> > > +             }
> > > +             dev_dbg(data->dev, "enable clk26m: ch %d, reg_read 0x%x=
\n", channel, reg_read); =20
> >
> > Directly accessing the regmap of a clock seems unusual. Why not provide=
 generic clock interfaces
> > for this? =20
>=20
> This register is used to vote to enable/disable the pmic 26m clk which
> is provided to modules like audio, typec and adc.
> Therefore, this clk cannot be disabled or enabled directly.

clk_enable() and friends support reference counted enable and disable
so I don't understand why this needs something unusual.


>=20

> > > +static int sprd_adc_probe(struct platform_device *pdev)
> > > +{
> > > +     struct device_node *np =3D pdev->dev.of_node;
> > > +     struct sprd_adc_data *sprd_data;
> > > +     const struct sprd_adc_variant_data *pdata;
> > > +     struct iio_dev *indio_dev;
> > > +     int ret;
> > > +
> > > +     pdata =3D of_device_get_match_data(&pdev->dev); =20
> >
> > device_get_match_data()
> >
> > =20
> > > +     if (!pdata) {
> > > +             dev_err(&pdev->dev, "No matching driver data found\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*sprd_da=
ta));
> > > +     if (!indio_dev)
> > > +             return -ENOMEM;
> > > +
> > > +     sprd_data =3D iio_priv(indio_dev);
> > > +
> > > +     sprd_data->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > > +     if (!sprd_data->regmap) {
> > > +             dev_err(&pdev->dev, "failed to get ADC regmap\n");
> > > +             return -ENODEV;
> > > +     }
> > > +
> > > +     ret =3D of_property_read_u32(np, "reg", &sprd_data->base); =20
> >
> > Even though some elements of this (of_hwspin...) don't have generic fir=
mware
> > interfaces, I would prefer to see those from linux/property.h used
> > wherever possible.  It will take us a long time to make that a subsystem
> > wide change, but good not to have more unnecessary instances of device =
tree
> > specific property reading. =20
>=20
> Sorry, I don't understand what needs to be modified. Can you provide
> more information or give an example?
> Do you mean that the "reg"  property reading is unnecessary?

No.  Where possibly use
	device_property_read_u32(dev, "reg".. etc
and similar functions from
include/linux/property.h rather than device tree specific ones.
The generic property handling deals with various different types of firmware
without needing drivers to be aware of it.

Some elements that you need here do not have generic property handling so
for those you will need to continue using the of_ variants.
Note that this is to support long term move of everything to the generic
firmware framework.  Even if we drivers in IIO etc that are really device
tree only there are benefits for maintenance in using one framework
for all drivers. As some IIO drivers do support other firmware types
(ACPI for example) the generic version is the preferred choice.

Thanks,

Jonathan
