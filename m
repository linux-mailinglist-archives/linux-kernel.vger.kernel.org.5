Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90209764944
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjG0Ht3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjG0Hrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:47:46 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7B644B4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:41:00 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4475d891d0eso416411137.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690443656; x=1691048456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y6Ww/Hps4ekYyaueVrTmTuZFPtK46a7P6gDhJscw3A=;
        b=lZl4dehodJurgoVIaC73y/eC9wYlITfHe4k+3NZRwvtbtZUUyiPoJ0QDneyfoTTTiG
         em4ZFEKmmd1+kXQpevVRNFMnkJyO1nYEzpaqMH10C87JxDERPhYzao+LyfQHfQye0M/R
         1HRTEHdEcs3rHusA+e98W3Z8ZQQw80KJYSQ3Luied4gCPtLoXbKWYE0dWcbJ0lDqqTO7
         WlnrNy3ZI5rBmyvztLhCd1SGEFW65pry6e1123zYOa5Xg+LLAOCXmXn0XdapI77rbsnT
         Gg8QVJN/guBX67ngK3kI+bXw107xTyyTnoHWjZJrkNFzHXsQmM7aAyu7YR26dstQxhsG
         D9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443656; x=1691048456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y6Ww/Hps4ekYyaueVrTmTuZFPtK46a7P6gDhJscw3A=;
        b=VyGnCoR7JidxpOj5f93SZiSC7yHuQlDVxta8ikh5cMPjV2gntj4lbvYvGm3s7C2fUg
         KPEbETeaj3vGIX4zTvVupNsY+Dj+muIi95FlvxHKQkI6IHVcW2Up4oX6fC8kAy/+7+pw
         SFl29GmMd3TC58bzZb/Eb32SX2DcktWSFiULu2lLQHRFpcQhIPj0agMeBQzDtSuQ9RB/
         hx5fCYx4f0vlTv2/uiuhnbXOkTWS28gMqDdc29p+z5QfYLPkhuZZurBwVho794MGTwTc
         da5MsapOAoWpudeFRjBRYZ8p0ik6sQJjciiqkMz5+6qjpu4lDHNiwHhX0gaVLCi08UEz
         4OnQ==
X-Gm-Message-State: ABy/qLYFKNbaURtRzX/iskRPa/q1pG8bJFONMq2CDtmXXWNasNL+66gQ
        f8snnBTgknhWh8UmHFi2JbALTsB/tl3vFIaNUNGmxg==
X-Google-Smtp-Source: APBJJlGEfmpoEXq+Qzglm+2heQrKM3Nw8InqN9U9NkeatxiuELwtIv2vQj/VPHsCl1tYzVd2KxZqySCnsDpeE4/NduU=
X-Received: by 2002:a67:ef0a:0:b0:443:74a8:b7fd with SMTP id
 j10-20020a67ef0a000000b0044374a8b7fdmr419670vsr.9.1690443656054; Thu, 27 Jul
 2023 00:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230722115046.27323-1-paul@crapouillou.net> <20230722115046.27323-5-paul@crapouillou.net>
In-Reply-To: <20230722115046.27323-5-paul@crapouillou.net>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 27 Jul 2023 09:40:45 +0200
Message-ID: <CAMRc=MdR5K-mZZzKKgBgKUgEoWUT_41t6FDUsLB2Q-VQaOhOVA@mail.gmail.com>
Subject: Re: [PATCH v2 04/22] i2c: davinci: Remove #ifdef guards for PM
 related functions
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 1:51=E2=80=AFPM Paul Cercueil <paul@crapouillou.net=
> wrote:
>
> Use the new PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
>
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
>
> Note that the behaviour is slightly different than before; the original
> code wrapped the suspend/resume with #ifdef CONFIG_PM guards, which
> resulted in these functions being compiled in but never used when
> CONFIG_PM_SLEEP was disabled.
>
> Now, those functions are only compiled in when CONFIG_PM_SLEEP is
> enabled.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/i2c/busses/i2c-davinci.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-da=
vinci.c
> index 71b60778c643..52527189a7bf 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -902,7 +902,6 @@ static void davinci_i2c_remove(struct platform_device=
 *pdev)
>         pm_runtime_disable(dev->dev);
>  }
>
> -#ifdef CONFIG_PM
>  static int davinci_i2c_suspend(struct device *dev)
>  {
>         struct davinci_i2c_dev *i2c_dev =3D dev_get_drvdata(dev);
> @@ -926,15 +925,10 @@ static int davinci_i2c_resume(struct device *dev)
>  static const struct dev_pm_ops davinci_i2c_pm =3D {
>         .suspend        =3D davinci_i2c_suspend,
>         .resume         =3D davinci_i2c_resume,
> -       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                                     pm_runtime_force_resume)
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                                 pm_runtime_force_resume)
>  };
>
> -#define davinci_i2c_pm_ops (&davinci_i2c_pm)
> -#else
> -#define davinci_i2c_pm_ops NULL
> -#endif
> -
>  static const struct platform_device_id davinci_i2c_driver_ids[] =3D {
>         { .name =3D "i2c_davinci", },
>         { /* sentinel */ }
> @@ -947,7 +941,7 @@ static struct platform_driver davinci_i2c_driver =3D =
{
>         .id_table       =3D davinci_i2c_driver_ids,
>         .driver         =3D {
>                 .name   =3D "i2c_davinci",
> -               .pm     =3D davinci_i2c_pm_ops,
> +               .pm     =3D pm_sleep_ptr(&davinci_i2c_pm),
>                 .of_match_table =3D davinci_i2c_of_match,
>         },
>  };
> --
> 2.40.1
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
