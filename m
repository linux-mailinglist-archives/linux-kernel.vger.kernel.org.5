Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402667857E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjHWM3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjHWM3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:29:43 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233EBCEE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:29:38 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso5189441276.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692793777; x=1693398577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM2mBO0PFbPREfV6y5utVh2uALzEkEsaG8Xoi0Qft/g=;
        b=Cd9OYG6UG81jfau+T3IdehXTKw4ReKMw2IoJPnYZzAxGGzKNAFti+ubPYfRZQXe2lV
         9cyH7NPPn5nY+3gJsPyUCPZwcnor6ws79981VjqYLlmK9E6BpewaCHc6rXMn7xxen4sS
         rR5Z9EikHYKIzTdu2Cq7KxgROwodbpvbtPWT8e9R+GgMcWIEdYdTyutJLzWJ9me4fEFh
         8pP18HFTdKaMMbrbtVcw+WkbiBrRnXJSvmbz6gbM98Mn7QvEp8gyQyymj+2XI+Buyf0L
         Cj8xBkAUJXgCU1tN8JXdssrj48IPPEwDQAnm/x7n9jIwESLqINE8C2vQNBX3FSl5g4Kt
         Lcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692793777; x=1693398577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vM2mBO0PFbPREfV6y5utVh2uALzEkEsaG8Xoi0Qft/g=;
        b=CcGBoTXgYj8Q11/OGXOhnzPgnI6H41ARtgofGwIKvY1s1vJPHlFX4gDxAmuCKSkhWg
         E1BEnvpqWzHNoalIGFF6t2odpioW8FeWzGQ8YsAyU4Y1wTSJiArqMg0bfgyn7D8M9R3X
         1luC/cYWmT3h9iiox0XUCRKYB9x7ujSKMyCpXjsNOoqGcefiqY41MX6Ad0AtCvEsqhLl
         3NXE1qLclSF+c/3+jy2EVXls+KON8vFTe643dYIp9HFKXW/w87H/OORrr5Z0GECq9/oG
         LAU/gSfnOW7yebFIj7zKEsNBWFbonI6nWuT1MgW4SIuKahq+ha6HlK2vhMeh816Ha/jK
         EW4w==
X-Gm-Message-State: AOJu0Yw22YIGMViM8/7l2JU+HoiPWNyjYVQrqX7QfSEvXvdsUfsSStoK
        0XupGqN0M8Kampf/xDgq7WVg5wzDoX7tuvsOMY+WfA==
X-Google-Smtp-Source: AGHT+IFFKP6YhXlKwTz5rGZpalkEJfHxEFdkjbdXxEPEMXoQfAsKDqn6fiAmTAPzSUrq8396Ku0mZMSONe0jbpZGYXQ=
X-Received: by 2002:a25:3757:0:b0:d35:9a48:51b0 with SMTP id
 e84-20020a253757000000b00d359a4851b0mr11184274yba.7.1692793777291; Wed, 23
 Aug 2023 05:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230823033427.23072-1-zhuyinbo@loongson.cn> <20230823033427.23072-3-zhuyinbo@loongson.cn>
In-Reply-To: <20230823033427.23072-3-zhuyinbo@loongson.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Aug 2023 14:29:25 +0200
Message-ID: <CACRpkdZJVjwOCGYhmzaPLWbcX0rgrDD-d2OX=TnmYs0F56fGug@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpio: loongson: add more gpio chip support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yinbo,

thanks for the new patch, it's starting to look really good!
The main point with offsets in the match data is very nice.

On Wed, Aug 23, 2023 at 5:34=E2=80=AFAM Yinbo Zhu <zhuyinbo@loongson.cn> wr=
ote:

> This patch was to add loongson 2k0500, 2k2000 and 3a5000 gpio chip
> driver support.
>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
(...)


>  static int loongson_gpio_to_irq(struct gpio_chip *chip, unsigned int off=
set)
>  {
> +       unsigned int u;
>         struct platform_device *pdev =3D to_platform_device(chip->parent)=
;
> +       struct loongson_gpio_chip *lgpio =3D to_loongson_gpio_chip(chip);
> +
> +       if (lgpio->chip_data->mode =3D=3D BIT_CTRL_MODE) {
> +               u =3D readl(lgpio->reg_base + lgpio->chip_data->inten_off=
set + offset / 32 * 4);
> +               u |=3D BIT(offset % 32);
> +               writel(u, lgpio->reg_base + lgpio->chip_data->inten_offse=
t + offset / 32 * 4);

This offset / 32 * 4 is really hard to read.
What about

/* Get the register index from offset then multiply by bytes per register *=
/
(offset / 32) * 4

>         lgpio->reg_base =3D reg_base;
> +       if (device_property_read_u32(dev, "ngpios", &ngpios) || !ngpios)
> +               return -EINVAL;
> +
> +       ret =3D DIV_ROUND_UP(ngpios, 8);
> +       switch (ret) {
> +       case 1 ... 2:
> +               io_width =3D ret;
> +               break;
> +       case 3 ... 4:
> +               io_width =3D 0x4;
> +               break;
> +       case 5 ... 8:
> +               io_width =3D 0x8;
> +               break;
> +       default:
> +               dev_err(dev, "unsupported io width\n");
> +               return -EINVAL;
> +       }

Is it really a good idea to infer the register width from ngpios?

What about just putting this into the struct loongson_gpio_chip_data
as well? Certainly it will be fixed for a certain device.

Yours,
Linus Walleij
