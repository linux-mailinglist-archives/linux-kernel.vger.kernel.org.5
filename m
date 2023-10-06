Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B097BB1BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjJFGtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 02:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjJFGs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:48:58 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19556F0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 23:48:57 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-49dd3bb5348so719803e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696574936; x=1697179736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO/HF0HBlJ2Jej01g1aJHNBVplRdvJlEtkw7wkfb7oc=;
        b=n9VfNPG43PZykPiJD9d/kOVQZJ+Ok4amJ7LFHcRq4SeymchD72kUOoB63ixgxRXZKf
         JTz3sljJDPWIvW8OuOFmihmVuwNe5/IZWQbAGDAlrXVv1MrMv4AdWui0q2UD8e73DAum
         SBmx9FxGZHcu/Y+TrTd9aLhTHrYny0DC06/3mKmtDu+hewf9zooOb7FF507DKnqvYIuc
         yIgla7cwuZxeq2aM/gQ7qELzaAIk87ATXPQ4Rs9X543OakX3rb244auYay80MnBf4WDl
         bGlG9zrzS8n4nEaKozCfToSS2MgqlkCs/acZAchSyl6ROtIkltCOLL6zDSA/Nnd3GAGG
         ciTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696574936; x=1697179736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mO/HF0HBlJ2Jej01g1aJHNBVplRdvJlEtkw7wkfb7oc=;
        b=crFs8CV9cHa1r8nsExlLgJM2GF0k3yjUWrvnlIwffA6GjNJPh3h/BJ79duqNk9SBwZ
         4vQVABpky71xMYGop4t9Tqo8bfSeJdI0EkgVlUh2f1VvZc6flvkMJvPz4647WeTOo8mf
         ztduHJsWRpFDMpyVyt43s7dKzDojGfMEAB4DEQME7WmvL6h5qnxguHQtHRbztarszCP1
         QX65DX5q2TwV7muPDV+g3wdNtbGzDMsvtF+N1pss3UEy0SKWh1LqMNyNOXVR95FnvAqR
         UFpcDcXhmglBCzub1EdAfoXF4HmpB7Po68wuQ0qwyTwpRjF8NBS5yrlhH5nMB1pHHOK7
         gr8Q==
X-Gm-Message-State: AOJu0Yxf8BQ37GWNgQHwUu9Swxo44E288Lon0iOl1bTvcIabUcoF7s7m
        OMDctmEt2ZMzomEdbqoEEY3LSL11Cwm57qrQS/Aw/Q==
X-Google-Smtp-Source: AGHT+IHc9dtSUxk9aTGH3bM96KLhGyZh0ypnD/UpuBZUbcF28r4HaYyVgxXbe8jAdN+8Fs12j0+oIUMyajEl8XyHuZE=
X-Received: by 2002:a1f:cbc5:0:b0:49d:9916:5747 with SMTP id
 b188-20020a1fcbc5000000b0049d99165747mr7103460vkg.13.1696574936048; Thu, 05
 Oct 2023 23:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-pxa-gpio-v5-0-d99ae6fceea8@skole.hr> <20231004-pxa-gpio-v5-1-d99ae6fceea8@skole.hr>
In-Reply-To: <20231004-pxa-gpio-v5-1-d99ae6fceea8@skole.hr>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 6 Oct 2023 08:48:45 +0200
Message-ID: <CAMRc=MeoxVOgs2D21P2ECXxUC-wfHAV0YAgZFwKDC99jLQSC5Q@mail.gmail.com>
Subject: Re: [PATCH RFC v5 1/6] ARM: pxa: Convert Spitz OHCI to GPIO descriptors
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 4:56=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic@=
skole.hr> wrote:
>
> Sharp's Spitz board still uses the legacy GPIO interface for controlling
> a GPIO pin related to the USB host controller.
>
> Convert this function to use the new GPIO descriptor interface.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---
>  arch/arm/mach-pxa/spitz.c      | 13 ++++++-------
>  drivers/usb/host/ohci-pxa27x.c |  7 +++++++
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index cc691b199429..535e2b2e997b 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -649,23 +649,22 @@ static inline void spitz_mmc_init(void) {}
>   * USB Host
>   ***********************************************************************=
*******/
>  #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
> +GPIO_LOOKUP_SINGLE(spitz_usb_host_gpio_table, "pxa27x-ohci", "gpio-pxa",
> +               SPITZ_GPIO_USB_HOST, "usb-host", GPIO_ACTIVE_LOW);
> +
>  static int spitz_ohci_init(struct device *dev)
>  {
> -       int err;
> -
> -       err =3D gpio_request(SPITZ_GPIO_USB_HOST, "USB_HOST");
> -       if (err)
> -               return err;
> +       gpiod_add_lookup_table(&spitz_usb_host_gpio_table);
>
>         /* Only Port 2 is connected, setup USB Port 2 Output Control Regi=
ster */
>         UP2OCR =3D UP2OCR_HXS | UP2OCR_HXOE | UP2OCR_DPPDE | UP2OCR_DMPDE=
;
>
> -       return gpio_direction_output(SPITZ_GPIO_USB_HOST, 1);
> +       return 0;
>  }
>
>  static void spitz_ohci_exit(struct device *dev)
>  {
> -       gpio_free(SPITZ_GPIO_USB_HOST);
> +       gpiod_remove_lookup_table(&spitz_usb_host_gpio_table);
>  }
>
>  static struct pxaohci_platform_data spitz_ohci_platform_data =3D {
> diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27=
x.c
> index 357d9aee38a3..876842b940c0 100644
> --- a/drivers/usb/host/ohci-pxa27x.c
> +++ b/drivers/usb/host/ohci-pxa27x.c
> @@ -121,6 +121,7 @@ struct pxa27x_ohci {
>         void __iomem    *mmio_base;
>         struct regulator *vbus[3];
>         bool            vbus_enabled[3];
> +       struct gpio_desc *usb_host;
>  };
>
>  #define to_pxa27x_ohci(hcd)    (struct pxa27x_ohci *)(hcd_to_ohci(hcd)->=
priv)
> @@ -447,6 +448,10 @@ static int ohci_hcd_pxa27x_probe(struct platform_dev=
ice *pdev)
>         pxa_ohci =3D to_pxa27x_ohci(hcd);
>         pxa_ohci->clk =3D usb_clk;
>         pxa_ohci->mmio_base =3D (void __iomem *)hcd->regs;
> +       pxa_ohci->usb_host =3D gpiod_get_optional(&pdev->dev, "usb-host",=
 GPIOD_OUT_LOW);

Any reason not to use devm_gpiod_get_optional()?

Bart

> +       if (IS_ERR(pxa_ohci->usb_host))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(pxa_ohci->usb_ho=
st),
> +                               "failed to get USB host GPIO\n");
>
>         for (i =3D 0; i < 3; ++i) {
>                 char name[6];
> @@ -512,6 +517,8 @@ static void ohci_hcd_pxa27x_remove(struct platform_de=
vice *pdev)
>         for (i =3D 0; i < 3; ++i)
>                 pxa27x_ohci_set_vbus_power(pxa_ohci, i, false);
>
> +       gpiod_put(pxa_ohci->usb_host);
> +
>         usb_put_hcd(hcd);
>  }
>
>
> --
> 2.42.0
>
>
