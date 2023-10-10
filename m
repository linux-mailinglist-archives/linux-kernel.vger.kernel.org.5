Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604327BF94F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjJJLKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjJJLKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:10:02 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C912CC6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:10:00 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-49d0f24a815so1822729e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696936200; x=1697541000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCYF5qT9Gs8IkTnnIfRUFKntaORMi6z87ONR0oJTVDQ=;
        b=C5u5QACxDqFmgS22h975qnPRhVJRK0lqoBbCBcPuMAuI9javRqL+IJfPQ3T7DO2nbM
         dIm6Lyq4E8+J0uFZXy/DlTUkBKcSJB3o+1KtJOELKtsX0ZShVJJkguQoVtGds8Dz1yMY
         B4JDSn771MggeNzu/Bcxnqj+jTf2QpdGqTIyYncQOVdXKBYOLfepiKncbPRRo/H7aRsR
         gvac1+HMy8GmQM19Vrvpx0lRB9MzLt+IsK4Y/EYQ1GV7TbKiywxY8q7GCKRZawiw/+a4
         a0QHV6Dz3YU7AF6tpwhONklWChnl42CB8nc4msmAHJf7ZLiXp4wsG4TwPRJTRBoJmq/n
         /xMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936200; x=1697541000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCYF5qT9Gs8IkTnnIfRUFKntaORMi6z87ONR0oJTVDQ=;
        b=MgAWsd4NXmviWASgar0dfHyvg5GukMuOE6Xt7qrYUyY1PmFXlm/hwupUDU3pdbd8o3
         J6o80Mq4nyJRP88xGo4y9lFepe97EE4KE7iTt8jGAyKbApTyOnqlDlGqfJNteSS8DcDU
         QqwbMcAMhGr7XX+BgNTJmkYHuPMu03qcGiw+ixQPG6cqiZ78focQf55MMJCvVW6QNTRP
         NtoC0RDnthC+RPEG8daFwLCDfpcS1rnUXZRSPLeRzYnRMLj2AdOEe7fuBo4+HRuBpvLy
         oP28Gwf5Ljp27QO+2y94Nm1XW2HTMJuH3a4mPkZ8/eW16NiU6dt6IouGI+RY7Eo4bvio
         Zymw==
X-Gm-Message-State: AOJu0YxM5Il29stLbhHI2LuflU4DxeFixfObPYZLHFNkxlSj+rKhtYpd
        YJnGfDdbsuLbj5CDs+8vgUhZAUAGLbkP4owLMe08Mw==
X-Google-Smtp-Source: AGHT+IG8EjKGLHcnRs66KBlvSVDW7XewFvqtnC+gvRCdLGJTRcz5KkRFMmp9YsubRZ0+HFgXMzlZdGl+PFDx9vN6yg8=
X-Received: by 2002:a05:6122:2641:b0:496:a6cc:7ffe with SMTP id
 dr1-20020a056122264100b00496a6cc7ffemr11008131vkb.13.1696936199801; Tue, 10
 Oct 2023 04:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231009-pxa-gpio-v7-0-c8f5f403e856@skole.hr> <20231009-pxa-gpio-v7-1-c8f5f403e856@skole.hr>
In-Reply-To: <20231009-pxa-gpio-v7-1-c8f5f403e856@skole.hr>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 10 Oct 2023 13:09:48 +0200
Message-ID: <CAMRc=Mcb5WpTyGyb20Kd_ycOGKPywhuGc9wFoxCcjtZ_oHC46A@mail.gmail.com>
Subject: Re: [PATCH RFT v7 1/6] ARM: pxa: Convert Spitz OHCI to GPIO descriptors
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

On Mon, Oct 9, 2023 at 8:34=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic@=
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
>  drivers/usb/host/ohci-pxa27x.c |  5 +++++
>  2 files changed, 11 insertions(+), 7 deletions(-)
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
> index 357d9aee38a3..a809ba0bb25e 100644
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
> +       pxa_ohci->usb_host =3D devm_gpiod_get_optional(&pdev->dev, "usb-h=
ost", GPIOD_OUT_LOW);
> +       if (IS_ERR(pxa_ohci->usb_host))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(pxa_ohci->usb_ho=
st),
> +                               "failed to get USB host GPIO\n");
>
>         for (i =3D 0; i < 3; ++i) {
>                 char name[6];
>
> --
> 2.42.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
