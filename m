Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398D47FBB5B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345184AbjK1NW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344875AbjK1NW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:22:57 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D706FA0;
        Tue, 28 Nov 2023 05:23:03 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1fa48ad4e99so1243799fac.3;
        Tue, 28 Nov 2023 05:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701177783; x=1701782583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dCUnmn0BnrE2m+8WTS8NvC7pbXYOAUPOHwpmf2nQ5k=;
        b=Hr3Mz0/UY0h6jQy7EuuYQyzv9uboz54Iyf4bCWukeT7/2J3wo3t2Z9cS/Y9/KSeHNA
         8mI5015zlE8C9qGNSpBrKFHKrG/pPdBirUboTDKU6O/DnIkRE2A+A2XlB+yaBJrv/hAO
         ewVix0i55Hh8A5WvWFhQKsQlUml3FxBOw1UDxJpjDGXI1vXGvFkSQ60djYhv0ukHzoA7
         dcolUVQwJ3HnZMYbs1FXEZpEuupG/zJ9sDb2eOFMWGpIovCelHbiZRHee5jHmDe1xoSA
         RSVQPS05rt7wibN4DXcFzRFSndf+SaAENTvmeQTL6tPbeqAW90sEErWneVS/mUGV0aPz
         2Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177783; x=1701782583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dCUnmn0BnrE2m+8WTS8NvC7pbXYOAUPOHwpmf2nQ5k=;
        b=b7VtmVeH6xdHUCTy/CRSlKl/lBZLE+GDasJQoQqfzmzKmbJwAMpBZpT7ouMOHoQrZI
         S/KnrR32Ol1XeI1BhodOYtvnhQHk7Xw1B2r66TLCRjyCnkPsMT0OPAA9Cn/3YbWpg66l
         jaI2Qggc3GkyxC5g7Cfv+1MOqeHKJbX2klFqqi4e5bHpI40+Kzt84rpF7A6kBFxA8Ikv
         XNrKMpDE1Y7RBszI0ufzEidvXHJ/lL1NQZ3yTQwvBZ80g6xvwVf83s2x6IXTw5t0q8CU
         wK2H6Hk+mIlYPrEj/6OJOxic++/NJ8QlNmXN25kEIgowJVpZ2VEohZSEtT4vrXpw33aa
         qiuQ==
X-Gm-Message-State: AOJu0YxXN8mCWNwGTBTmpPlSDajIBaxC4zNxN3wOR1ybKg4NPqL0aT4/
        Ya4kgdYbqd3yfT1str3Eys3+5STKnT8+3ctiw0o=
X-Google-Smtp-Source: AGHT+IG4eo1lRqCyzRbI4aFlhW1Z6q6ycRX9VtpnrLDU5d/q8u+XwyLpGVKGiY10at7a6Aa740AOieFwgKcjbmp/tBw=
X-Received: by 2002:a05:6870:6c0b:b0:1ef:f14e:6f0a with SMTP id
 na11-20020a0568706c0b00b001eff14e6f0amr20536626oab.0.1701177783127; Tue, 28
 Nov 2023 05:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20231121094642.2973795-1-qiujingbao.dlmu@gmail.com>
 <20231121094642.2973795-3-qiujingbao.dlmu@gmail.com> <09b29f1f-a42b-49f7-afca-f82357acd4c8@linaro.org>
In-Reply-To: <09b29f1f-a42b-49f7-afca-f82357acd4c8@linaro.org>
From:   jingbao qiu <qiujingbao.dlmu@gmail.com>
Date:   Tue, 28 Nov 2023 21:22:52 +0800
Message-ID: <CAJRtX8TU9Z3OXL1zw9+mGNhxugp_C2jo40k-s9V2byNCQeBoLQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] rtc: add rtc controller support for Sophgo CV1800B SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org, chao.wei@sophgo.com,
        unicorn_wang@outlook.com, conor+dt@kernel.org, robh+dt@kernel.org,
        conor@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 6:01=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/11/2023 10:46, Jingbao Qiu wrote:
> > Implement the RTC driver for CV1800B, which able to provide time and
> > alarm functionality.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  drivers/rtc/Kconfig       |  10 ++
> >  drivers/rtc/Makefile      |   1 +
> >  drivers/rtc/rtc-cv1800b.c | 293 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 304 insertions(+)
> >  create mode 100644 drivers/rtc/rtc-cv1800b.c
>
> Bindings were not tested, so I assume you did not compile the code
> either. Please confirm that you fixed all warnings pointed out by W=3D1
> builds, smatch and sparse. All of them.

 will test & fix in next version

>
> >
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 3814e0845e77..2089cceea38c 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -1103,6 +1103,16 @@ config RTC_DRV_DS2404
> >         This driver can also be built as a module. If so, the module
> >         will be called rtc-ds2404.
> >
> > +config RTC_DRV_CV1800B
> > +     tristate "Sophgo CV1800B RTC"
> > +     depends on ARCH_SOPHGO || COMPILE_TEST
> > +     help
> > +       If you say yes here you will get support for the
> > +       RTC of the Sophgo CV1800B SOC.
> > +
> > +       This depend on ARCH_SOPHGO and COMPILE_TEST. Please
> > +       first config that.
>
> ...
>
> > +static int cv1800b_rtc_probe(struct platform_device *pdev)
> > +{
> > +     struct cv1800b_rtc_priv *rtc;
> > +     struct resource *res;
> > +     int ret;
> > +
> > +     rtc =3D devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> > +     if (!rtc)
> > +             return -ENOMEM;
> > +
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!res) {
> > +             ret =3D -ENODEV;
> > +             goto err;
> > +     }
> > +
> > +     rtc->core_map =3D devm_ioremap_resource(&pdev->dev, res);
>
> Use helper combining these two calls.

Ok, will use devm_platform_ioremap_resource() to replace it.

>
> > +     if (IS_ERR(rtc->core_map)) {
> > +             ret =3D PTR_ERR(rtc->core_map);
> > +             goto err;
> > +     }
> > +
> > +     rtc->irq =3D platform_get_irq(pdev, 0);
> > +     platform_set_drvdata(pdev, rtc);
>
> Your code has random order. First you get IRQ, then you check its value,
> then you go further.

ok

>
> > +     if (rtc->irq < 0) {
> > +             ret =3D -EINVAL;
> > +             goto err;
> > +     }
> > +
> > +     ret =3D
> > +         devm_request_irq(&pdev->dev, rtc->irq, cv1800b_rtc_irq_handle=
r,
>
> Wrong wrapping.

ok

>
> > +                          IRQF_SHARED, "rtc alarm", &pdev->dev);
>
> Why shared?

ok

>
> > +     if (ret)
> > +             goto err;
> > +
> > +     rtc->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +     if (IS_ERR(rtc->clk)) {
> > +             dev_err(&pdev->dev, "no clock");
>
> This code is not ready for upstream. There are multiple things wrong here=
.
>
> First, syntax is return dev_err_probe.
>
> Second, you do not have clocks and you do not allow them! Just open your
> binding.

I'm not fully understanding here, can you elaborate more?
as there is clocks info like this in the dt-bindings:
 clocks =3D <&osc>;

>
> Third, use wrapper - devm_clk_get_enable or something like that.

I will use devm_clk_get_enabled() to replace it.

>
>
> > +             ret =3D PTR_ERR(rtc->clk);
> > +             goto err;
> > +     }
>
> Blank line.

ok

>
> > +     ret =3D clk_prepare_enable(rtc->clk);
> > +     if (ret)
> > +             goto err;
>
> Blank line.

ok

>
> > +     ret =3D cv1800b_rtc_softinit(rtc);
> > +     if (ret)
> > +             goto err;
> > +     cv1800b_rtc_alarm_irq_enable(&pdev->dev, 1);
> > +     rtc->rtc_dev =3D devm_rtc_allocate_device(&pdev->dev);
> > +     if (IS_ERR(rtc->rtc_dev)) {
> > +             ret =3D PTR_ERR(rtc->rtc_dev);
> > +             goto err;
> > +     }
> > +     rtc->rtc_dev->range_max =3D U32_MAX;
> > +     rtc->rtc_dev->ops =3D &cv800b_rtc_ops;
> > +
> > +     return rtc_register_device(rtc->rtc_dev);

I find the commet of devm_rtc_device_register wirte
=E2=80=9CThis function is deprecated, use devm_rtc_allocate_device and
rtc_register_device instead=E2=80=9D
but all of code about this, they all use devm_rtc_device_register
function. So which one do you suggest I use?

> > +err:
> > +     return dev_err_probe(&pdev->dev, ret, "Failed to init cv1800b rtc=
\n");
>
> Drop, just return.

ok

>
> Best regards,
> Krzysztof
>

Best regards,
Jingbao Qiu
