Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799D775B1A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjGTOuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjGTOuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:50:11 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FF62706
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:50:08 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4816078ab3cso645120e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689864607; x=1690469407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44I4QTXSdpRlGQNX01aNu7Q8jYmgKrsVdvaz0FbrT9w=;
        b=VHsv4k0q2otI210G2fx8UlqZVBouT1yhHPQeX4/iYKRduLbBfujemaFd84GC3ZVtWX
         jIbCktQqByAp5iqMc/vfuiwpcDzR/b7VidjqvAa00eAxbSRDadKzFL7ftVkL0wpM8mY4
         3nANvQf6LnRvO72e3X3PIZq6dwVKEuHJlUuToqWh59bGJFqRqqo0SosmrUxvzzRd1bBC
         FBz8bvcUB7PznBNwhuRezNy3z5i/4TW+ggCxtW15DP+i0Lj50o4B9jSN9WUDe5Vyw8rc
         EUeWyncBdaKXPsUBWXs360RXDU8t4kC/iicYJ16kjPZL2O0Kgs5iYg9GIm/a1AZfdPvo
         1iNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864607; x=1690469407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44I4QTXSdpRlGQNX01aNu7Q8jYmgKrsVdvaz0FbrT9w=;
        b=LJlgSMin17KQCxcf594TgBjj14VbWAX45i2K1WDDoiCBOhQFnEa/dPTVickNol0VJx
         ooMrFCF9e6QLhG82Nq+5+XhOq6A/ahBPSN22sc2yizwWnfveBMC9Yejg6H42om2ZoivB
         ejZRpjxtmpLI6VgIDDYTFf0+7Whx5OnEYfCTj3fzopPlpGtiePar1An75kaYymUVlF1J
         XeU+2iBY7kdkJwbdSSjb8JdfMIMVu6GI1JLcER4pZ7iqFLwkI38wz35CXXbj1vAvYh9J
         wYmk1NPrX3HGiFmiX/ALVEtlKKAMNYSyvi6YoKTdcLDX059ejVpo/k5mYrHB87SZVZAQ
         EnOw==
X-Gm-Message-State: ABy/qLZFQiS36YKrVfTKOKgCKf+YyyKsoYiJxuL+6k1fzJhfBC8uBPEK
        Py8cOHfKwFrd9uZ/ObwNwBHg3tj6d+D0W9BaDard5w==
X-Google-Smtp-Source: APBJJlHcVbVjnQaUrT7V7jD6HpKLdUNhc+KcBHJVAgkGL82QQnDc268rPznkIAv5GUoMxsi+qdzT6lIi9u/QnbbIPgk=
X-Received: by 2002:a05:6122:929:b0:481:5132:48c7 with SMTP id
 j41-20020a056122092900b00481513248c7mr2136264vka.1.1689864607273; Thu, 20 Jul
 2023 07:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me> <20230605-ep93xx-v3-33-3d63a5f1103e@maquefel.me>
In-Reply-To: <20230605-ep93xx-v3-33-3d63a5f1103e@maquefel.me>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Jul 2023 16:49:56 +0200
Message-ID: <CAMRc=McbD1w47GsfvY6p==jDiTQrwg96jFvVKO-9bPhNOBmapw@mail.gmail.com>
Subject: Re: [PATCH v3 33/42] gpio: ep93xx: add DT support for gpio-ep93xx
To:     nikita.shubin@maquefel.me
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 10:30=E2=80=AFAM Nikita Shubin via B4 Relay
<devnull+nikita.shubin.maquefel.me@kernel.org> wrote:
>
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>
> Add OF ID match table.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  drivers/gpio/gpio-ep93xx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
> index 9a25bb0caf17..c4e272a8773d 100644
> --- a/drivers/gpio/gpio-ep93xx.c
> +++ b/drivers/gpio/gpio-ep93xx.c
> @@ -360,9 +360,15 @@ static int ep93xx_gpio_probe(struct platform_device =
*pdev)
>         return devm_gpiochip_add_data(&pdev->dev, gc, egc);
>  }
>
> +static const struct of_device_id ep93xx_gpio_match[] =3D {
> +       { .compatible =3D "cirrus,ep9301-gpio" },
> +       { /* sentinel */ }
> +};
> +
>  static struct platform_driver ep93xx_gpio_driver =3D {
>         .driver         =3D {
>                 .name   =3D "gpio-ep93xx",
> +               .of_match_table =3D ep93xx_gpio_match,
>         },
>         .probe          =3D ep93xx_gpio_probe,
>  };
>
> --
> 2.39.2
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
