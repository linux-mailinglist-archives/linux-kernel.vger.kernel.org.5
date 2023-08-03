Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001C276EB29
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbjHCNte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbjHCNtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:49:13 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCCF2109
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:49:10 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-486519e5e19so356642e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691070549; x=1691675349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXPwONeZi032xrr2tXbKwXlQ0hqWUqQyu0KYsSokTuc=;
        b=Qh8xBl1ZexjQPkKxAGtvbRgJdvmymYy/aGTOHGA+Gl9UL6/GlYnN/vQcbzfrJAjNjJ
         h8tOHJ4t0S/Cqttixz9S453qkxcXPyfUH02Z7h7TKiIHoN2fmMYWjk9yn8/+CEtWDBHl
         k1U5h7sruvDCeB3s6AineTwgROhAYcwNZeYIKjl0E3dmXq74bQuSpEI6L4noqbLONvJd
         SGpfRXGsEyaBVTiknWplCoo/3zx3+JiYeYT/0yI9Zq5+Pn4/a7taW7WTtANetMtginYe
         WEGaeMg4incuNyz/+0ULM4i25hyx+Okb9NFga8+WMAbnv+XR6nxmoq0UemEd2eiynR3f
         Yvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691070549; x=1691675349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXPwONeZi032xrr2tXbKwXlQ0hqWUqQyu0KYsSokTuc=;
        b=bFS+td0KmpGtNLjYXO0Uca48ScYbnOH3wEZA85YuWG1rkleaDptDeEMnE3GQY3dY4l
         TfUN2CqkpXmb5+uhsCA6BYtViyXY797UmHKitVB0LSVG+KQX1hEwUnhaSzLxlTuglONs
         DyA4Yb4WeVD64kMAFVAynQpuCM0C1nOWL7opUwicJ2sTxoN8nOL80w0bJoiMEOuNfyLp
         q9SoYkrUUtTUVNI7DNd3x5A4bFBkSTvq88n6YJMke5AizbzUMCSmbb0YKQoHL48paqFp
         0FhYqmW8WlGNw/X8eG0WHztXpmb6+TWUKYK2ekyyk5JHKyLQs++LpDnjLHGim0t7rsLS
         I2/Q==
X-Gm-Message-State: ABy/qLZU1SqygS1oVt/SABLFxaJQmHYi/B0kAPKdUb4ODu1yqJ4rznr9
        USN30xaZVMGEeE1+xGuHeycGmzW96h+o17xBtqnh6g==
X-Google-Smtp-Source: APBJJlGkAp/hm5SaM4utaaDMERECGOjea/6mU473r6+F4Tkfw2vOdvWjhAePzRyyGuqLQZWCi3m/bBa/YAyvHO1vkTc=
X-Received: by 2002:a1f:bdcb:0:b0:471:2aa6:41f6 with SMTP id
 n194-20020a1fbdcb000000b004712aa641f6mr6148505vkf.2.1691070549435; Thu, 03
 Aug 2023 06:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230801204445.9677-1-aboutphysycs@gmail.com>
In-Reply-To: <20230801204445.9677-1-aboutphysycs@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 3 Aug 2023 15:48:58 +0200
Message-ID: <CAMRc=Me2Y=WXrcbw+GbjbEBdftWZZj7RQK2G-o=YKw4G2pYAHw@mail.gmail.com>
Subject: Re: [PATCH] gpio: vx855: remove unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy@kernel.org, linus.walleij@linaro.org,
        Alexandru Ardelean <alex@shruggie.ro>
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

On Tue, Aug 1, 2023 at 10:45=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>
> Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/gpio/gpio-vx855.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-vx855.c b/drivers/gpio/gpio-vx855.c
> index 69713fd5485b..8fd6c3913d69 100644
> --- a/drivers/gpio/gpio-vx855.c
> +++ b/drivers/gpio/gpio-vx855.c
> @@ -240,8 +240,6 @@ static int vx855gpio_probe(struct platform_device *pd=
ev)
>         if (!vg)
>                 return -ENOMEM;
>
> -       platform_set_drvdata(pdev, vg);
> -
>         dev_info(&pdev->dev, "found VX855 GPIO controller\n");
>         vg->io_gpi =3D res_gpi->start;
>         vg->io_gpo =3D res_gpo->start;
> --
> 2.34.1
>

Applied, thanks!

Bart
