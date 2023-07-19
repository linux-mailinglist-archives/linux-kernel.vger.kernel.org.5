Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF33D75951F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGSMan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGSMam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:30:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0273EE0;
        Wed, 19 Jul 2023 05:30:40 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e590a8ab5so9379566a12.2;
        Wed, 19 Jul 2023 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689769838; x=1690374638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xN2l+O6gJGRa84uZb1BsKBHRU7JKgcju1wz8yosyb6M=;
        b=Dr9HMbIgFpXgZvjVl2cm/7LYBEgOpp+BumU0LigiIqOKShfyAP70ZYXEuLx2Nnmmai
         l8N8kpsQeoORaNIgOL5nNgynGVpuFLliUPX7wEJeseDZh7tus6ms7exuFJwZP9Q7X4cV
         qNqEtjzohE4MZjlrjmOguOOAUKA67tPWauK56261JZEYeZj+Nd8FpPQEw1hWiuiSArUa
         R3McQ/aQ1/BCT3k6Cx4ug1DJP+zLIMr7K1lzSpkk1bN4NKR9mAIoNyZk5Aymh3xOsJIa
         fi4iaPOJF5Cex7d9JUHltPu/Mt8pYuSuRmcKPDCvZV5WgabfCI8wxs8t0pmNVXI48Wjj
         +gNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689769838; x=1690374638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xN2l+O6gJGRa84uZb1BsKBHRU7JKgcju1wz8yosyb6M=;
        b=OPd5NIEtVmkaWx2oymX9j1NQvIdlmsZSF+PiU/d14dh625hppSnFmUVYqccKG9lhng
         R4re2IKp13mhelr+EaQDY0HiU+CW8prmmNguePiPhkN5zcV4Blbdq4QL5R3tkg9PJrC4
         oBfHoE3EV4+gKqNsokmXIy9yCaFKhfu7F7F+ZA5Gx/YTyztcN5XuB0yhZnTZDvIkYv56
         blUY0z3KlgOaosJYT74y00CHd4PkOgJD/MbhwhyvFwjDsvD6a27BWRQJZ0tfQkZxIPEo
         iVCXNPW3te1lLOCnTJu4+VHWNeRw0epKORegw8ziNg6Z5PVzs+lFcHmG+UHM3V3aq6Km
         3pwQ==
X-Gm-Message-State: ABy/qLYGH7bukB85isbAtNLM8b6iwI4ynPoz2+yGY1coiGgdU9Xc2OJf
        YoPT94IER1jz+NMOw7OQXRnVMPzn7lYjMgVcVG8=
X-Google-Smtp-Source: APBJJlFqasK+/oeB2EkcK3d1RtcgXvs+4PEasJMm6GAJfFeOQ5eqhXf5jf7NKFl6Rw6YMA2a2SdaSKcdixrqKwwRrn8=
X-Received: by 2002:a05:6402:12d9:b0:51d:dbf1:c825 with SMTP id
 k25-20020a05640212d900b0051ddbf1c825mr2900612edx.1.1689769838275; Wed, 19 Jul
 2023 05:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230719101339.18256-1-aboutphysycs@gmail.com>
In-Reply-To: <20230719101339.18256-1-aboutphysycs@gmail.com>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Wed, 19 Jul 2023 20:30:21 +0800
Message-ID: <CAJhJPsUBWC6h2ZL_wcqwkd0Krih-PxErVeGFdFdPxocL1RTNcw@mail.gmail.com>
Subject: Re: [PATCH] gpio: loongson1 :remove unneeded platform_set_drvdata()call
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@vger.kernel.org, andy@kernel.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, Alexandru Ardelean <alex@shruggie.ro>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 6:14=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> In the drivers/gpio/gpio-loongson1 the call to platform_set_drvdata was
> removed.
> This function call was found to be unnecesarry as the associated
> structure is defined inside the local .c file.
> It doesn't use any type of function either so it can be removed without
> any complications.

If there is a ls1x_gpio_remove(), platform_get_drvdata() will be called.
Then platform_set_drvdata() will be necessary.
>
> Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/gpio/gpio-loongson1.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.=
c
> index 6ca3b969db4d..2a57ffa0548b 100644
> --- a/drivers/gpio/gpio-loongson1.c
> +++ b/drivers/gpio/gpio-loongson1.c
> @@ -78,8 +78,6 @@ static int ls1x_gpio_probe(struct platform_device *pdev=
)
>         if (ret)
>                 goto err;
>
> -       platform_set_drvdata(pdev, ls1x_gc);
> -
>         dev_info(dev, "GPIO controller registered with %d pins\n",
>                  ls1x_gc->gc.ngpio);
>
> --
> 2.34.1
>


--=20
Best regards,

Keguang Zhang
