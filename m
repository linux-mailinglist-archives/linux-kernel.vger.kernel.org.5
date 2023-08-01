Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD676BDB8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjHAT2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjHAT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:28:17 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6652702
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 12:28:14 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-48662837573so1964546e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690918093; x=1691522893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCrBZ+LARUcvOa9R+ORZqbZu0aG8I3aHxOBsAiGdDF8=;
        b=MC9nGd/11OgWvJFBXkX7+UwU+Y4an+7b6KwxNnqjCTGVTdrRltuAvJ0IFU3fQTbg7a
         b6E+L0stygSE91lezyJ9xyIJ1teNBytoo/hmIC+QPzc0Z+xDWTOw+hbY4QPavYKjc0sY
         h3B2geZNqR7igvGgE8+4l/xLn/uvM2uoUr1vC/KLJNCWoPFj6f3j5SxRqNcl3+wy9owh
         8C7ixOh42cbcVDDm6LdwOPSJb6KMcinP5y1eYm6chCZhqRvUAR0pfHDki9mYc8nvhOpk
         miHrtHPhCFqpb21poHGvLcWXGoc9qw0sMHTBQZpDZW28wrTyIxwfIF7Ungm3HWCZ88+T
         6T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690918093; x=1691522893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCrBZ+LARUcvOa9R+ORZqbZu0aG8I3aHxOBsAiGdDF8=;
        b=Y1crrzMclNmnXJVxVmutGsNkPYDigtmDnml9CWS82iCO+qBJ2yfaXcacDWmZx52YiA
         KhTrsjhcOzlWkzszNqCTnfDpcj+8LzotZ7jnxwopFWLuqPb4T6u6t5jNroV22mtI2yKY
         0sUZA3agar9amDNdBmnbkVLDv7GZxB6gru11ISXqe4eDHdAxByC4yqOU0W73jmmRlesY
         uHwm3q3eCXPIcqTvOZFLYupdV0fdJ17RpBxdEXgMoZ9JOkjbC+af8KNNGr13f1fM21Cc
         JZ+EoQKL2LC+WEoSnkmVTx3urFUAWlia/A+GcrwfDiKOZEvMFC06EKzBPcZLrlhOxSAS
         Sn1g==
X-Gm-Message-State: ABy/qLaDSj6PAmgDGiesHOyB6Ml9O1BlhGiux44/zghGL/eK40XDJnSO
        LsDS3vrip4Gx/6h7g/wYbdznXQZl26KStM4SA/EMFQ==
X-Google-Smtp-Source: APBJJlGmsrWrqHsKoCkpTUDByMprWAgrRIUfS39Wr3WrmpPuTLgxZfyQunwmIu+/Uh5bMCyrmj7Hgk/YY6eK92ve+jk=
X-Received: by 2002:a1f:bfc5:0:b0:486:6cad:b6e7 with SMTP id
 p188-20020a1fbfc5000000b004866cadb6e7mr3451015vkf.10.1690918093314; Tue, 01
 Aug 2023 12:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230728182522.18477-1-aboutphysycs@gmail.com>
In-Reply-To: <20230728182522.18477-1-aboutphysycs@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 1 Aug 2023 21:28:02 +0200
Message-ID: <CAMRc=McZS65f4Z8bXSCW_6gHQ5hgQD8x1z5OvM6-oKJfii4F=w@mail.gmail.com>
Subject: Re: [PATCH] gpio: sama5d2-piobu: remove unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, andy@kernel.org,
        linus.walleij@linaro.org, ludovic.desroches@microchip.com,
        Alexandru Ardelean <alex@shruggie.ro>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 8:25=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
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
>  drivers/gpio/gpio-sama5d2-piobu.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-sama5d2-piobu.c b/drivers/gpio/gpio-sama5d=
2-piobu.c
> index 767c33ae3213..d89da7300ddd 100644
> --- a/drivers/gpio/gpio-sama5d2-piobu.c
> +++ b/drivers/gpio/gpio-sama5d2-piobu.c
> @@ -189,7 +189,6 @@ static int sama5d2_piobu_probe(struct platform_device=
 *pdev)
>         if (!piobu)
>                 return -ENOMEM;
>
> -       platform_set_drvdata(pdev, piobu);
>         piobu->chip.label =3D pdev->name;
>         piobu->chip.parent =3D &pdev->dev;
>         piobu->chip.owner =3D THIS_MODULE,
> --
> 2.34.1
>

Applied, thanks!

Bartosz
