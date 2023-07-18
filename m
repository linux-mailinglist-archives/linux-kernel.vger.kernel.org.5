Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8067585DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGRTzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGRTzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:55:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A339D;
        Tue, 18 Jul 2023 12:55:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e5d9e20ecso8719632a12.1;
        Tue, 18 Jul 2023 12:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689710110; x=1692302110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UWnGFL06djDI18ZDxplYijmA/LhPZTehuJTXj64eeE=;
        b=PYpqmIsHL0fQtrd3ph7eSnd7uh7yD9uygv+j89ny+cEFFuxF8fT2OyrWvyNsWiMDVC
         yLoxBll87sLgXYvPT1/oyFUl+Bw1do9Je3tXlzniQirOU9vO4JMMuL+qS/1WHysh7jkx
         Q8LFBhpX8JDD3wtW3RrNrMCSN1Zg8N8qoS4tF+A4hmHILx29w3nk1nrpa9TRJPEbazyv
         ElCIuHfDYcyzpAkx5nfZqVWpamk1CiYmK1SHu2TcTrNmaY7e9Esvgq9T9unsM/z9UCtt
         CBFfFlLeCitD6I3PTEtBWjOBXe9uljZ2+kH5HqI8H6B0VH0hXrmtEH862sflxLFmHllm
         7OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689710110; x=1692302110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UWnGFL06djDI18ZDxplYijmA/LhPZTehuJTXj64eeE=;
        b=gYxh9mYkEgYKwyvKcRx2MilL6mS57UKIY3qkgcm9bfGdrkYdaXBNhpOkEur/Twtj4u
         tkEQvLNSg1LWRtvEUeOOf73r5PnfDJhmFGAXR5pL/sbC4KvbGcKTN2QmhxAQslIS+QCi
         VNqctRRi6dwN2WrM4xL9qb5WhcjCbjsS/LM8uMU9TdMs5rDLMQgKASN0SoIpW22hVJw6
         wtEYMQFL2QUOuyIyNh+Mqlhb9V4olHaFveWPEEgBogO48ZN5TDPKgcBH2ryu7fi3K6OT
         8c5HDUcUw1yMBTbgBITqUJIabJCppwK3hh8hrskZhPPV0tu0pBf3WUbv7zmW/GmqsXoL
         cvsg==
X-Gm-Message-State: ABy/qLbRE418uYzVxQLoSeDP9UZOmXND+DCeqbG9/naaE0/zoyWlEILF
        e9quLMseOC1TBkCelQoMor2X9gKJaXGDMn/lKHU=
X-Google-Smtp-Source: APBJJlG8StHVSbZUu7JD5afeJfPRR83rioPgDuZbd8H/UHy44fk9sV3w0CUiAi/0oYpNDxZConPQt3H/9iokbVHMQkM=
X-Received: by 2002:a17:906:7a11:b0:994:56db:cb8d with SMTP id
 d17-20020a1709067a1100b0099456dbcb8dmr786213ejo.14.1689710110022; Tue, 18 Jul
 2023 12:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230718193913.3578660-1-arnd@kernel.org>
In-Reply-To: <20230718193913.3578660-1-arnd@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jul 2023 22:54:33 +0300
Message-ID: <CAHp75Ve51WqLoPHnxLf_uAP8zEr=iK2e0s7uLM441gtOqPmQdg@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: fix unused function warnings
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy@kernel.org>, Marek Vasut <marex@denx.de>,
        Marc Zyngier <maz@kernel.org>,
        Dan Carpenter <error27@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:39=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wr=
ote:
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

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

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


--=20
With Best Regards,
Andy Shevchenko
