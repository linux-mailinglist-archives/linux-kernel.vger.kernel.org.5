Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD288065AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376426AbjLFDfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFDfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:35:36 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4651AA;
        Tue,  5 Dec 2023 19:35:42 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7b411be1eb7so196307739f.3;
        Tue, 05 Dec 2023 19:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701833742; x=1702438542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqCT9UhzTcxCbk+fnZ9QwAf1vc+qB4SCnje0SUyPZjY=;
        b=l7+KilkatRSnTIuXGMbwZOfZvkhbVacc/pxBSvxe/6jbffrFiIo4qNdFijgpIl+z6V
         cMEJ1P0sfceMtUVo77MUkWV71lyxijeIsGI0fE4I1BmkVNu2nLtUbgrPnXDzCxZMvC54
         nMFmke3NxU4qL1R8J5+xd3GJhu/+0mweej/ywdCT3z/6973R3/a2Fo5aaOryEvdeai8X
         vNy8p68C2a1aUwSf6gDTtEBnlGlHhoIL53h9Rj/EpQ/+olxpqhcI3b9PZamsTgQCG3Cr
         9X+f4IBTixHbk34kt40GyedDFuQRPtSZvxkgpAh86TiFaQTiclMEjuMOwJj7vKTVQYpC
         LabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701833742; x=1702438542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqCT9UhzTcxCbk+fnZ9QwAf1vc+qB4SCnje0SUyPZjY=;
        b=lqnqblPCx5TJO5EkOSqpMju8fCgBWMteCP2K8ftEcvZGerhs7gCutkCd530q+Rq/Yk
         rehfm/pG73msHJr32ipn80ThOeRHqlsV7qWVAIjHqRgCP/RTbWxkOnsQibERuxz+WkVX
         ibb8ciMejQw1Y3QCEXg8TteedEpx3F6mvK579JFMu0ZrMrUKtD/6WwMRneGrXSrXS/rG
         jLCWumDM3HjPhK2ew1cBDbDh6pSRWx3YegJV9xjIh9baqAB12kssO3XVJTylBMRU0UO3
         OEfouD9TLVrH95JtQbULK+BLRI1CPsDgAopfWPWBQxesOkGBk+F+QbRtH8bvOOaK6gWw
         3bQg==
X-Gm-Message-State: AOJu0YydmuS6wmjcOyHA7YRvE5Ga13nUG3+5niGpBrhb3ra1h09tfQA5
        Bd09qUwvWRRRimwys+zciiUDCg4103iDm2Uj8qY=
X-Google-Smtp-Source: AGHT+IGuATMBPOBFtF6RH56kIjCimhrIka6bGKrmGiIqvOXMga9sjzCyu5oUk3o/rp3s8+ryBzSYi+qt9f55n1hiHUg=
X-Received: by 2002:a6b:5a0c:0:b0:7b3:e542:5894 with SMTP id
 o12-20020a6b5a0c000000b007b3e5425894mr395428iob.8.1701833741879; Tue, 05 Dec
 2023 19:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20231204055650.788388-1-kcfeng0@nuvoton.com> <20231204055650.788388-3-kcfeng0@nuvoton.com>
 <eff4defd-dfd5-448b-9056-d2f711f14018@linaro.org>
In-Reply-To: <eff4defd-dfd5-448b-9056-d2f711f14018@linaro.org>
From:   Ban Feng <baneric926@gmail.com>
Date:   Wed, 6 Dec 2023 11:35:31 +0800
Message-ID: <CALz278b9QCVM7SPd3QUn9qaHCom+s0i7SmGZFPjuXRmgVTG_6A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] hwmon: Driver for Nuvoton NCT736X
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kcfeng0@nuvoton.com, DELPHINE_CHIU@wiwynn.com,
        Bonnie_Lo@wiwynn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2023=E5=B9=
=B412=E6=9C=884=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:06=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 04/12/2023 06:56, baneric926@gmail.com wrote:
> > From: Ban Feng <kcfeng0@nuvoton.com>
> >
> > NCT736X is an I2C based hardware monitoring chip from Nuvoton.
> >
> > Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> > ---
>
>
> > +
> > +static const struct i2c_device_id nct736x_id[] =3D {
> > +     {"nct7362", nct7362},
> > +     {"nct7363", nct7363},
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, nct736x_id);
> > +
>
> All ID tables are next to each other. Move it down. Why does it not
> match of_device_id?

ok, I'll put all ID tables together,
and add .data to of_device_id so that matching i2c_device_id.

>
> ...
>
> > +
> > +static int nct736x_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     struct nct736x_data *data;
> > +     struct device *hwmon_dev;
> > +     u32 pwm_mask, fanin_mask, val, wdt_cfg;
> > +     int ret;
> > +
> > +     data =3D devm_kzalloc(dev, sizeof(struct nct736x_data), GFP_KERNE=
L);
>
> sizeof(*)

ok, I'll modify it in v2.

>
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     i2c_set_clientdata(client, data);
> > +     mutex_init(&data->update_lock);
> > +
> > +     data->client =3D client;
> > +
> > +     if (of_property_read_u32(dev->of_node, "nuvoton,pwm-mask", &pwm_m=
ask))
> > +             pwm_mask =3D 0;
> > +     if (of_property_read_u32(dev->of_node,
> > +                              "nuvoton,fanin-mask", &fanin_mask))
> > +             fanin_mask =3D 0;
> > +     if (of_property_read_u32(dev->of_node, "nuvoton,wdt-timeout", &va=
l))
> > +             wdt_cfg =3D 0xff;
> > +     else
> > +             wdt_cfg =3D WDT_CFG(val) | EN_WDT;
> > +
> > +     /* Initialize the chip */
> > +     ret =3D nct736x_init_chip(client, pwm_mask, fanin_mask, wdt_cfg);
> > +     if (ret)
> > +             return ret;
> > +
> > +     data->fan_mask =3D (u16)fanin_mask;
> > +     data->pwm_mask =3D (u16)pwm_mask;
> > +
> > +     data =3D nct736x_update_device(dev);
> > +
> > +     data->groups[0] =3D &nct736x_group_fan;
> > +     data->groups[1] =3D &nct736x_group_pwm;
> > +     data->groups[2] =3D NULL;
> > +
> > +     hwmon_dev =3D devm_hwmon_device_register_with_groups(dev,
> > +                                                        client->name,
> > +                                                        data, data->gr=
oups);
> > +     return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +static const struct of_device_id nct736x_of_match[] =3D {
> > +     { .compatible =3D "nuvoton,nct7362" },
> > +     { .compatible =3D "nuvoton,nct7363" },
>
> This means your devices are compatible. Express compatibility in your
> bindings (specific compatible followed by fallback). But then your
> i2c_device_id is not matching this one here... confusing and clearly wron=
g.
>

Same as above.

> Best regards,
> Krzysztof
>
