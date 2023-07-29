Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B389A767FEF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjG2OGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjG2OG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:06:29 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4947C26B8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:06:25 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a5ad6087a1so1938538b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690639584; x=1691244384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crd6A1HxfzYrRiHiG3JTOKFWwf3yPPJzZ+7nyJosIlQ=;
        b=oA17bYfJB+sOc1FYbbZASQMOvUZu5/Sxo9vTA7LT34hjORio7D4hD6RAsPc814HcN1
         /Asv1He6MoLQgHHpYWD/1v5HXUAcBslu8HlIcA3KKPtcKaqfB/3R/CjAcPO7ojRihWvO
         JRwDtaFt9HrpgnqeSshNb9WxUCS0QwQAJjaQcU0mg5MDYvT0aDBiaynKSWz9NafHgoJA
         EDUCHipYISO/gCFV7LpFLn8+EN+bHhKgRuU9Mp2MDERHSzytwidPESSvFceB7Jt+gqcc
         uPyD6/VQhBP6UzLvnoK0Mc6TZwYNZCtfWYaWDoiPB7jGTIrXcw3K9Owt1sdVqVlGM0hC
         gc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690639584; x=1691244384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crd6A1HxfzYrRiHiG3JTOKFWwf3yPPJzZ+7nyJosIlQ=;
        b=bfJxHYMxkqamBcHYxr2mZ05rXB4G7l25sgzUp04wCr5L4ZAfpnuBEQZNogd/0Quv4F
         HP26ouwYsaQjL0EVqMmvFWXbSv0z6VNCW030oBPF5720W2sl8d0nUZJQeEP3OZl8AiWb
         kfHENXbwR3uswRGumpB2QJyuHclcyv48NuRcWfBNORy35pAYQI+s/b+oRndMAGVOq/oH
         9PgXzivFmev/G8yQ7sQV81UwFXZV054Sm8nCAyv8+ZG0zpJJ4Vq2ssWG5yM2iyLUK61r
         kw8t2wSLs4/uFVq5287kdXrbIbvfsZP7CTLlmdC11ezrf3Q9UaupmMAiqOH9me9HRhEh
         0a1Q==
X-Gm-Message-State: ABy/qLbUQ2btwBPbH9g1eAV27w18tuT5gEz/1DTzlVqASREauy+xhYOU
        aAK2G9dc1nUG73vEboFGYXd0J1hhZNgrHMvk/96lTg==
X-Google-Smtp-Source: APBJJlErm1+d3GEVhaaq1fHgFl4iK7NNfgxhOTKhBvKUG+2eD3XIHyV3Yy9G2z12mepW01OzXkAvL3uwZ0ht3DcDT8M=
X-Received: by 2002:a05:6358:5292:b0:137:881b:fc73 with SMTP id
 g18-20020a056358529200b00137881bfc73mr2293977rwa.2.1690639584580; Sat, 29 Jul
 2023 07:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230719094803.17677-1-aboutphysycs@gmail.com>
In-Reply-To: <20230719094803.17677-1-aboutphysycs@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 29 Jul 2023 16:06:13 +0200
Message-ID: <CAMRc=Mfvfj1VgRkJUbcnqHr=RM1oaR4+nDGX46FLyE_pfhX0UA@mail.gmail.com>
Subject: Re: [PATCH] gpio: logicvc: remove unneeded platform_set_drvdata() call
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy@kernel.org, linus.walleij@linaro.org,
        Alexandru Ardelean <alex@shruggie.ro>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 11:48=E2=80=AFAM Andrei Coardos <aboutphysycs@gmail=
.com> wrote:
>
> The platform_set_drvdata() isn't needed for anything. The function is a
> simple setter that doesn't change anything in the code. That is because
> there isn't a get function and since it has no dependencies it can be
> removed.
>
> Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/gpio/gpio-logicvc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-logicvc.c b/drivers/gpio/gpio-logicvc.c
> index 992cc958a43f..9b4789deae45 100644
> --- a/drivers/gpio/gpio-logicvc.c
> +++ b/drivers/gpio/gpio-logicvc.c
> @@ -139,8 +139,6 @@ static int logicvc_gpio_probe(struct platform_device =
*pdev)
>         logicvc->chip.set =3D logicvc_gpio_set;
>         logicvc->chip.direction_output =3D logicvc_gpio_direction_output;
>
> -       platform_set_drvdata(pdev, logicvc);
> -
>         return devm_gpiochip_add_data(dev, &logicvc->chip, logicvc);
>  }
>
> --
> 2.34.1
>

Applied, thanks!

Bart
