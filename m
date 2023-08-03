Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0F776EB1E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbjHCNtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjHCNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:48:43 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5192D4691
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:47:30 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-794b8fe8cc4so1334998241.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691070449; x=1691675249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7qFNZbvxgKG/pfY+414xL5ZiFLKcO5iJ+7JnPY1dJ0=;
        b=46v6sODuFGuLTBNGZoqWdv3+za2sbTFewm9q1l0lTnB+g86wGO6TuGO/pfZ10C9AmB
         2NSMud/3VMy8xzPxUHBISukNd9qUR2N4PpuFPiBn95tXWOHq+ItOSaRr9P9IUdF3+KQ7
         ulnEuM21PA+PGOK6YXXTYeUi6SIkItkA7aw0cocwyNjfIqvFu7G0ZiU0xG5r261npbJP
         TIso/5HvzMUVOp4RtwS+i1PnN1SLSx3kqMu5nZS6kB8HwQ9osfiMTCwV+NvrR4BxbAx9
         dR5ygkvJPS84KhmyHUz3ud5WiIfeZlX769gy4JZLPHuYCmQXzh8fxjaV7EK4D3KKKQHz
         ncdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691070449; x=1691675249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7qFNZbvxgKG/pfY+414xL5ZiFLKcO5iJ+7JnPY1dJ0=;
        b=hy0SwPt4QsvxUGI5pSThWW0VrcfMCzdqw3KqwemOvPk4KANVjhTkJhvbGnnjGAtENI
         kNuogqcmqAye8JOQ9b04wTy9sZXcitfW9swWax2gkbdd97CqPPa5kMr/bBILNaiMOoN0
         FywDxfksAxqlOUMTbYMER5KxL+EzZJw9P5EKedr6zRg8TdxPJvDODOlwgchocURqkr1q
         p55HzzkaCMxVjA0w1GekkviWdcKox/XuU0OEzaKa6Z1AB8J71ZksgkwV2Zhl+Y9ZsRmz
         1+mNzADRV6aldvbBYZm2XF6tBtM8cl+AVMNVOP1F98C/IOg5lroMH7hRTbmUb08td0YA
         mQZw==
X-Gm-Message-State: ABy/qLYP1bWOIMRqky2Z1/DQ+VH+gUNzl/0esDIgts4YxV+Wpv5GyIyD
        7g33ydVsGwrsP1Riv0cYBM1SDTcMYDImdLmlP2b7aA==
X-Google-Smtp-Source: APBJJlEW7QgXMaP6hNgSxspZLwMEVYePiMLubm3nRuwMgxqw+0ATUbGqvX0TrxmWCcS92cLTjbfneZWZQ9RE8nP/49c=
X-Received: by 2002:a05:6102:508a:b0:439:3e26:990e with SMTP id
 bl10-20020a056102508a00b004393e26990emr4507298vsb.6.1691070449442; Thu, 03
 Aug 2023 06:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230801074430.5179-1-aboutphysycs@gmail.com>
In-Reply-To: <20230801074430.5179-1-aboutphysycs@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 3 Aug 2023 15:47:17 +0200
Message-ID: <CAMRc=MdCmK4K-KNtnqzuSjgHu-Z1Aai2qAeXikp9mkdQJVuRFA@mail.gmail.com>
Subject: Re: [PATCH] gpio: sifive: remove unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-gpio@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, andy@kernel.org, linus.walleij@linaro.org,
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

On Tue, Aug 1, 2023 at 9:44=E2=80=AFAM Andrei Coardos <aboutphysycs@gmail.c=
om> wrote:
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
>  drivers/gpio/gpio-sifive.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
> index c6a8d2374e31..0010f607a9ef 100644
> --- a/drivers/gpio/gpio-sifive.c
> +++ b/drivers/gpio/gpio-sifive.c
> @@ -259,7 +259,6 @@ static int sifive_gpio_probe(struct platform_device *=
pdev)
>         girq->child_to_parent_hwirq =3D sifive_gpio_child_to_parent_hwirq=
;
>         girq->handler =3D handle_bad_irq;
>         girq->default_type =3D IRQ_TYPE_NONE;
> -       platform_set_drvdata(pdev, priv);
>
>         return gpiochip_add_data(&chip->gc, chip);
>  }
> --
> 2.34.1
>

This patch does not correspond with the code upstream. Please verify.

Bart
