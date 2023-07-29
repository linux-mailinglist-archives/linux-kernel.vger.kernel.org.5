Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED978767FE7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjG2ODv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjG2ODs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:03:48 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033421FFA
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:03:48 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1bbaa549c82so2353317fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690639427; x=1691244227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEVF7rXPeI4PGjsgBxtiYZJ/zbC37N4D4oIpXtrNUo8=;
        b=n9rjjQhBzl9xSGTDKJvdpNt3zao4B2YKPNBUsV4RNnvPx0ylvu0D7RYZMUAXJeKGcA
         vAci9rb1PSg9kD0up/XAsEq5cAcilOhXTeCX3GhT/ZvDHKp96i4nsmTPBpu4nZT/nEBd
         HERL56HO/4+9pqPB33hnajQGV40cT2vYQQMmVApaG196V9Md5FlRwfxdDr0A96d4RUZP
         4vFB4KiH/3ilJaM7urVznxxrL5m85R/EZnk8ziB3nxipN9PIqYiyoptr2XLxnL9E5iIL
         aRnobeoKitpymlzl8iackFGhMU/8wdOm3/wERK8jAjtnnkV4fbWthaKOv9cWjqUY5A+R
         LTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690639427; x=1691244227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEVF7rXPeI4PGjsgBxtiYZJ/zbC37N4D4oIpXtrNUo8=;
        b=Vw9le+HSuMQhWnr3jMNZv3ed+Drjd+Weq/UjjN+5EJsv0hy+/fzCTZV7N8JE4mSPSG
         tjoylRtAjHY+5Z+Qn/OfuMbkduZ+28H2LOayk2cPMYAw/tgDgxYUcbQDxpkrBpsp4f9o
         RG3J+K3hH97/js6CgMip0GEN7UANl37PhxVmUG2xt0YVqoDFpYUZd9whCXnfBnlJpUEo
         8crtAj4LMvjXdioCfauMetsl6po/tO56K3g2iFmM9RqcLkhh5CoZM+PlpD7HmjOZgG+Z
         1rZKlMDH0uyU1LGGwZA4Zw4OH5ifBfkt6XNZueDghjeKRD+5UzPQfekgogyxIIrWAieC
         9q9Q==
X-Gm-Message-State: ABy/qLZEh9RESYPR/Y4jm97o7bAYJ1pc3uryJ3B3+yMvDyNhxqKEo9IK
        4J4KPymAG/EpvD99dPduZJxLJN6+Yw3IkfUem0hhwA==
X-Google-Smtp-Source: APBJJlH6AijIQ1JOjRYCMzv/L1hp+lVX335euKo8lnemq/h4JZC8ji77ZfUsvEpxrqUMMnpKdq8hMj1x+vWJBjKJrJQ=
X-Received: by 2002:a05:6870:41d0:b0:1a6:a547:ffe1 with SMTP id
 z16-20020a05687041d000b001a6a547ffe1mr5626596oac.21.1690639427203; Sat, 29
 Jul 2023 07:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230712094857.218105-1-alex@shruggie.ro>
In-Reply-To: <20230712094857.218105-1-alex@shruggie.ro>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 29 Jul 2023 16:03:36 +0200
Message-ID: <CAMRc=Mfs_bAxHGqVzuAUOTLLAX8gUhAepNcHrgLXzkFHc89Nnw@mail.gmail.com>
Subject: Re: [PATCH] gpio: 74xx-mmio: remove unneeded platform_set_drvdata() call
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:49=E2=80=AFAM Alexandru Ardelean <alex@shruggie.=
ro> wrote:
>
> The platform_set_drvdata() was needed when the driver had an explicit
> remove function.
> That function got removed a while back, so we don't need to keep a pointe=
r
> (on 'dev->driver_data') for the private data of the driver anymore.
>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
>  drivers/gpio/gpio-74xx-mmio.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.=
c
> index 0464f1ecd20d..c7ac5a9ffb1f 100644
> --- a/drivers/gpio/gpio-74xx-mmio.c
> +++ b/drivers/gpio/gpio-74xx-mmio.c
> @@ -135,8 +135,6 @@ static int mmio_74xx_gpio_probe(struct platform_devic=
e *pdev)
>         priv->gc.ngpio =3D MMIO_74XX_BIT_CNT(priv->flags);
>         priv->gc.owner =3D THIS_MODULE;
>
> -       platform_set_drvdata(pdev, priv);
> -
>         return devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
>  }
>
> --
> 2.40.1
>

Applied, thanks!

Bart
