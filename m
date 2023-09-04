Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5834791267
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjIDHl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjIDHlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:41:24 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2988E1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:41:20 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-48d167f6cffso193571e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693813280; x=1694418080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBWs5YzX8VVJrC+PXflF69xIax+rUZX/BM+Y4AzGNmU=;
        b=hPI9VSnGLNpq50YJy4tIh1KhWdv6f3k3A0yN2Cx0nld5gqQYYbQ6uiAJFVjwdNVCdV
         oQyXwFP22Kua2vgOvMilE7knNxEA+re32LlH7p0QOC3/+CZK5EhZfzz6qB96G5/Cp1f5
         ZnhaIA4VAd3DsJFED3AokQIIk/RmgfvSGziPUrm2ZHlkOHQBEO7NeX8vKBC41A9hVVDM
         ctker3aPvG8T5CceZZIuZLkYLCLjIlIFzbX9A8A5khOvfhYHXX+binsCAa9G6wxJJh5q
         ZbAPV3rJdZPLzvvYV+cqO1z7r0Bt/wMCJPtrFm3o4Nrtn25Dlhcj7jgDztaUuxn6+2yl
         VL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693813280; x=1694418080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBWs5YzX8VVJrC+PXflF69xIax+rUZX/BM+Y4AzGNmU=;
        b=Npn0zLtSOQ7wXF4Mx1d+wGc7tg9QNITiSWq2RdWfUzZIIUwrDNfXAz+DIbWaHZcW39
         5LHVST3uJDTvQvRlDfCzXiISFiOe8AO4xgCIfTGxhCoWF83yyOtXVuiH2R2DhPz+VQpW
         HrnTs/rzF5Idvz2Wt9+lPYUbMKAb0YPkBZyBN+H8t7sirgMzn33KTMnIEvg1v2+M78+z
         r1ZYTnU4QCysjuOtfxrVGm2JfBJNWTUJzOZdc7/WEY9Jc1BPXWVjL5sKjPNvWNLw8vJ8
         ckddLOrEqae0zBn51niMY1IAnZyS6alsTMBzxn4Invn4pMQNl/Fa+H4EHInYxckMI8zZ
         WnsA==
X-Gm-Message-State: AOJu0YzINqpuPRZfoAqaJrPOZv4hEwn7jMZBIQMxbIUS7AeJ4tQaPNWD
        tM8y8SX8X2R2dm07kaBmmnqrydxF/rrbcMzoiminmA==
X-Google-Smtp-Source: AGHT+IH+JoKCZ5WR4l3LQeiirN0/VmedEawwtvGNnmhIhapvRAKwYsIlo2FphkVlCYMPWJdeKFSSfEnYEJOtdBABqaU=
X-Received: by 2002:a1f:c887:0:b0:490:1ad3:d645 with SMTP id
 y129-20020a1fc887000000b004901ad3d645mr6866914vkf.11.1693813279892; Mon, 04
 Sep 2023 00:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com> <20230901134041.1165562-9-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230901134041.1165562-9-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 4 Sep 2023 09:41:09 +0200
Message-ID: <CAMRc=Md0K2MxLKtJ2c1JB4GF-2L7THCN-maCqFVFGZ+qYM1Uaw@mail.gmail.com>
Subject: Re: [PATCH v1 09/10] gpio: pca953x: Get rid of useless goto label
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023 at 3:40=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In a few functions goto label is useless as there are no locking,
> no nothing that may justify its usage. Get rid of it.
>

I guess it was supposed to be "so nothing" but I'll fix it when applying.

Bart

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index bf27e2d920f7..16f5e3043bf0 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -988,20 +988,18 @@ static int device_pca95xx_init(struct pca953x_chip =
*chip)
>         ret =3D regcache_sync_region(chip->regmap, regaddr,
>                                    regaddr + NBANK(chip) - 1);
>         if (ret)
> -               goto out;
> +               return ret;
>
>         regaddr =3D chip->recalc_addr(chip, chip->regs->direction, 0);
>         ret =3D regcache_sync_region(chip->regmap, regaddr,
>                                    regaddr + NBANK(chip) - 1);
>         if (ret)
> -               goto out;
> +               return ret;
>
>         /* clear polarity inversion */
>         bitmap_zero(val, MAX_LINE);
>
> -       ret =3D pca953x_write_regs(chip, chip->regs->invert, val);
> -out:
> -       return ret;
> +       return pca953x_write_regs(chip, chip->regs->invert, val);
>  }
>
>  static int device_pca957x_init(struct pca953x_chip *chip)
> @@ -1012,19 +1010,13 @@ static int device_pca957x_init(struct pca953x_chi=
p *chip)
>
>         ret =3D device_pca95xx_init(chip);
>         if (ret)
> -               goto out;
> +               return ret;
>
>         /* To enable register 6, 7 to control pull up and pull down */
>         for (i =3D 0; i < NBANK(chip); i++)
>                 bitmap_set_value8(val, 0x02, i * BANK_SZ);
>
> -       ret =3D pca953x_write_regs(chip, PCA957X_BKEN, val);
> -       if (ret)
> -               goto out;
> -
> -       return 0;
> -out:
> -       return ret;
> +       return pca953x_write_regs(chip, PCA957X_BKEN, val);
>  }
>
>  static void pca953x_disable_regulator(void *reg)
> @@ -1262,12 +1254,10 @@ static int pca953x_resume(struct device *dev)
>         }
>
>         ret =3D pca953x_restore_context(chip);
> -       if (ret) {
> +       if (ret)
>                 dev_err(dev, "Failed to restore register map: %d\n", ret)=
;
> -               return ret;
> -       }
>
> -       return 0;
> +       return ret;
>  }
>
>  static DEFINE_SIMPLE_DEV_PM_OPS(pca953x_pm_ops, pca953x_suspend, pca953x=
_resume);
> --
> 2.40.0.1.gaa8946217a0b
>
