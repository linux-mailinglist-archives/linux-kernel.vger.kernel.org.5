Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2637BD3CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbjJIGvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjJIGvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:51:36 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB7FA3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 23:51:34 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7aae07e7ba4so1269499241.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 23:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696834293; x=1697439093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBDSaY0/ASjdBE7rCbqSIiyhd+2s1GCtZituRbz4r4E=;
        b=jGk0U/yHEw60pkwn4+7oXf/1xLJEGy6cUrEO6gYaGm6B9ZZB3fJLrQWNlwRT6jZXXt
         cQKHLl4AN2yb8kSJKLa7dRz4LciLj1sw2Aa/v8OItkwmg8gW127noO3CmXP1dEWMkaDI
         1er7HBipihkgG3RkDZRvqLOoqmLJY4ngJzabLfvznlNR5mMpVdlmAj1xpVQOYmC9jxh2
         R+lohTZ8HcJeh4NB1HQ3Zcy931ZSjMJJZfmOoDCZzPCz4F+9Ih2FEHbBmSmaw3ZT4S8r
         RcWLS7NCFhee+smv8TyrxN2pp7Y1+cuy8nJ4R6kzRgRkrobKvhJ1uFw3er0FhRWUPzVZ
         J98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696834293; x=1697439093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBDSaY0/ASjdBE7rCbqSIiyhd+2s1GCtZituRbz4r4E=;
        b=MPbz/zXbIFW9CHE6/27WJw+5Lyp5SNQIpP+SsemH7t8eT5Uit0RUsoFcA6nQel/3fd
         uARjLvV7jtc8rRxtQ/N+kzP6318lWgel0TgtiomN1XbbbIUGjP5uC4Pb+UJ80oHYLxt1
         M/v4HCpLks79tyryuUrCIsaqB16Q4mF+4ebPosYfWXsNfxhoJS/a7O+J4SFpmYRXiP0I
         To174fglPisPB/785MVS6WoCYD4hZJfDMBlZYnc7QGCzfQVRJsmNzNwvg5NPvlh+Lanv
         4ATDj5OyqpPxMm7bgExCVxxUqo0xRdDduCwKwhhDCFrDpS1sr3mQ4GU9aSKTlQSl7VoI
         GUog==
X-Gm-Message-State: AOJu0Yw4f/4MLwNrMiqlh4YoDyGGsjRts5+wCaVrltJdf1Oiqs4cxhJA
        lW5m/ZqJM51JVtx5sdypSl8QJSoTKiYKapzlC9qaGJMaWUVXNK6b
X-Google-Smtp-Source: AGHT+IH1LWeJKXPZE+vvTZ4Oau9CzNroYWz1QipmerCrdTudthpWuwe8ud3nA9hbzuN+ZUJaN3IsyD6+sAOH3HFrDjA=
X-Received: by 2002:a1f:c6c7:0:b0:49a:3538:18e3 with SMTP id
 w190-20020a1fc6c7000000b0049a353818e3mr9876309vkf.6.1696834293585; Sun, 08
 Oct 2023 23:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231007125550.529700-1-peng.fan@oss.nxp.com>
In-Reply-To: <20231007125550.529700-1-peng.fan@oss.nxp.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 9 Oct 2023 08:51:22 +0200
Message-ID: <CAMRc=MdBRndJTGBhUPNkVGtRUpjaqph1aduzhDoitwjUy7VCyA@mail.gmail.com>
Subject: Re: [PATCH] gpio: vf610: update comment for i.MX8ULP and i.MX93
 legacy compatibles
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linus.walleij@linaro.org, andy@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
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

On Sat, Oct 7, 2023 at 2:51=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX8ULP and i.MX93 legacy compatible strings use dual regs, while
> new compatible strings use one reg. The "support old compatible strings"
> is not clear to reflect the fact, so update it.
>
> Suggested-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> To address:
>  https://lore.kernel.org/all/20231004050428.o7l2e23xjcjkzzck@pengutronix.=
de/
> Marco:
>  I added your tag with Suggested-by, since you suggested this.
>
>  drivers/gpio/gpio-vf610.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
> index c03dfda41d4c..a89ae84a1fa0 100644
> --- a/drivers/gpio/gpio-vf610.c
> +++ b/drivers/gpio/gpio-vf610.c
> @@ -287,7 +287,10 @@ static int vf610_gpio_probe(struct platform_device *=
pdev)
>
>         dual_base =3D port->sdata->have_dual_base;
>
> -       /* support old compatible strings */
> +       /*
> +        * Handle legacy compatible combinations which used two reg value=
s
> +        * for the i.MX8ULP and i.MX93.
> +        */
>         if (device_is_compatible(dev, "fsl,imx7ulp-gpio") &&
>             (device_is_compatible(dev, "fsl,imx93-gpio") ||
>             (device_is_compatible(dev, "fsl,imx8ulp-gpio"))))
> --
> 2.37.1
>

Applied, thanks!

Bart
