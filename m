Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E37C75B26C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjGTPYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjGTPYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:24:00 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3752C268F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:23:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so13543591fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689866637; x=1690471437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EH5XJadTjYUCZPX5UHJQBVA28A6Iz0OEGos6BVFZVHw=;
        b=tSC2U4Jr5y1+wh2Mb5Bdb0MhaB0/k0NaklotQi7CQjr9fXtQoh4MnlSb8JXnxqcezs
         kZz3e3sVkp/puKrYAFTViH9WvT5i+BHMCCXQWX1exoIxO2ICjFVl4NvzHbwAguNan0E+
         JzzcV4zy9IfAv07PLb5IGqvvzIriOFJrvItxLUmrnMil6zR/qWTbJHknU2vO8A7c7OWe
         cvWAP1XHGVeYlZzHSaSpfMuK1IB6NcDXSvhXAUlmMw9W5+2LVJ6GltWycftoV36Aezvs
         9L7xBgi32/zccz98FQwvMwFHJ4LDI3+hRkspkVRygSp9cywlsvKfNuAAchQ6s9ughWoR
         a8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866637; x=1690471437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EH5XJadTjYUCZPX5UHJQBVA28A6Iz0OEGos6BVFZVHw=;
        b=d7GFM2M0jurkOFTfcynilN5hXN4dITJR3VGg2mHOQOpBxIXHOTiXWicSRUyhlFNkrm
         KO8pt6t0fvelmPY5X6VHcv6TC6hy1VDQ8lZuiCV/mEoooxcMur0NZfG8KGYR8njNkVPL
         9bsQ2xLEJFU2lgPFPOTufZtxNkxNeWAhrqiGfZ+pVg+kW5/oa5DhVareGOyW8vgRvQfq
         1iw5YMPpquGaAVqPlhXNdIApm/Jyxfh6P2smKD5OQxCk7m2gX6ukrAv+zeXJhuMHM6/n
         /RQ3641WtuY0NQytAmuLh0SRHQd/JZJ0KnlndeNeV3tY2sw72SXSrspmozIdCm5Hu4yb
         iH3A==
X-Gm-Message-State: ABy/qLZ074Z2IhBUcnHQmv7EyoL4bzfZt57mNyjF4ypGzLEukHFYJtvf
        oAuu5NUNhT9sDrzOugVao9o4MVet+j8QjtPLVdA/dg==
X-Google-Smtp-Source: APBJJlEOzmEtOLhlMlHkEj7ifVntBb1Vm6jU1/PVSuCDtkWGuxJDc0p/aEQORKlogSjij1Ea6FCgQdhciawX6Ab8WHc=
X-Received: by 2002:a2e:7c12:0:b0:2b6:de59:1ba4 with SMTP id
 x18-20020a2e7c12000000b002b6de591ba4mr2326446ljc.20.1689866637429; Thu, 20
 Jul 2023 08:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230718193913.3578660-1-arnd@kernel.org>
In-Reply-To: <20230718193913.3578660-1-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Jul 2023 17:23:45 +0200
Message-ID: <CAMRc=McQ5PH-4umCDQGOiy_tZsoC5gH7h3EJm0gUEz5OBZZ6NQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: fix unused function warnings
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy@kernel.org>, Marek Vasut <marex@denx.de>,
        Marc Zyngier <maz@kernel.org>,
        Dan Carpenter <error27@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 9:39=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The new runtime PM support causes a harmless warning about
> unused functions when runtime PM is disabled:
>
> drivers/gpio/gpio-mxc.c:612:12: error: 'mxc_gpio_runtime_resume' defined =
but not used [-Werror=3Dunused-function]
> drivers/gpio/gpio-mxc.c:602:12: error: 'mxc_gpio_runtime_suspend' defined=
 but not used [-Werror=3Dunused-function]
>
> Change the driver to use the more modern helper macros that avoid these
> warnings, and remove the now unnecessary __maybe_unused annotations
>
> Fixes: 3283d820dce64 ("gpio: mxc: add runtime pm support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpio/gpio-mxc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index a9fb6bd9aa6f9..e03fc8d375fe1 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -623,7 +623,7 @@ static int mxc_gpio_runtime_resume(struct device *dev=
)
>         return 0;
>  }
>
> -static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
> +static int mxc_gpio_noirq_suspend(struct device *dev)
>  {
>         struct platform_device *pdev =3D to_platform_device(dev);
>         struct mxc_gpio_port *port =3D platform_get_drvdata(pdev);
> @@ -634,7 +634,7 @@ static int __maybe_unused mxc_gpio_noirq_suspend(stru=
ct device *dev)
>         return 0;
>  }
>
> -static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
> +static int mxc_gpio_noirq_resume(struct device *dev)
>  {
>         struct platform_device *pdev =3D to_platform_device(dev);
>         struct mxc_gpio_port *port =3D platform_get_drvdata(pdev);
> @@ -647,8 +647,8 @@ static int __maybe_unused mxc_gpio_noirq_resume(struc=
t device *dev)
>  }
>
>  static const struct dev_pm_ops mxc_gpio_dev_pm_ops =3D {
> -       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_no=
irq_resume)
> -       SET_RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_res=
ume, NULL)
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noirq_=
resume)
> +       RUNTIME_PM_OPS(mxc_gpio_runtime_suspend, mxc_gpio_runtime_resume,=
 NULL)
>  };
>
>  static int mxc_gpio_syscore_suspend(void)
> --
> 2.39.2
>

Applied, thanks!

Bart
