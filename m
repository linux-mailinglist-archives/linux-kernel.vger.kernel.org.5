Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF57770A7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjHJGrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjHJGqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:46:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568CCED;
        Wed,  9 Aug 2023 23:46:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5237365f3a6so658193a12.2;
        Wed, 09 Aug 2023 23:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691650013; x=1692254813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d97DNxVWndRKqy+GYLUUwTxQ5wSEsSYDcK7bljZp6nM=;
        b=fShcXfPyq5qTLCY/hQVnKm0r+Fz1cWZbRI6whRrplxAtEaOAvSNl/QW55WZ4OWIVUQ
         nkM3mryRvhgEptszJeJvJTLwPW6pDtlbZDRSQmQSIHGPHSaCe++dzkz948vwpEvv22wQ
         7hrCdpMjaYC+s/dofUAUWnwBy5125U/oushoyb+K/W8oExKlQwjn0SIVcX/MPN2epsn1
         J3dc0NtrnbzUge744OmpfaYD33NwztV5USXEsk3oWu72Yx/In4wy6u2STE7kM96i6mGk
         w/yFRaGe4xTmHbC775KZ0lUZVoBBtqESIjss+7LGjwngnYcbKNacPFyCISmKniBjerAh
         7/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691650013; x=1692254813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d97DNxVWndRKqy+GYLUUwTxQ5wSEsSYDcK7bljZp6nM=;
        b=gSdYBXh6i2jXzvBdGk2ByEObOmw0CUFYl+UZUINPUTHlR1gWKA+asxc8C5BD0HY7Hh
         0jmag4WgJhFugR5NwcoGJ5smOqKDlBOqgpYLjA2dhfOLQRIcFC4V/t74mJVamce63DDI
         Jq/TrED9yK1aLSG0gsQfISP3sBcyjHKXKS4yOCHMMyLNl+6vkDCcwB5/GLuchxbtxqjg
         8efzBg+VH1MzYPFuW7HS66bDhB0lt1P/CciEb86y12mqG1rlBkiGEpEuDSw+rhuboEjM
         eKMNQXRSMq01m4qtneKov1GabU3+MmO0RdwGaIrUsY1V9ESH30VUeY61Xkam/yECpQjR
         zQ/A==
X-Gm-Message-State: AOJu0YzBVjN6uasKP28nvJ7nH5iuRJaRBOiJZ8DHK5129Dek8mQpRRw1
        powkCOBZkMkMDZZQs/XwkM8ZcunJTRr2O9zC4UrPLYp9QaY=
X-Google-Smtp-Source: AGHT+IEwWVlBeLryVc/eVOBBpMdYCkROMbaNhtiRKBVmwPQPhVZYoNNJyQh4qTwTplR/yAaIor0VgaZyup3j8VKzHP4=
X-Received: by 2002:a05:6402:184d:b0:522:41b8:3dad with SMTP id
 v13-20020a056402184d00b0052241b83dadmr1303993edy.15.1691650012582; Wed, 09
 Aug 2023 23:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230809171245.92081-1-coolrrsh@gmail.com>
In-Reply-To: <20230809171245.92081-1-coolrrsh@gmail.com>
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Thu, 10 Aug 2023 12:46:41 +0600
Message-ID: <CAABMjtECX_p=G_Vwedxn3xuxm+WDy7hnyuSVc_rTNDr9yXKrYA@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-imx-scu: Use ARRAY_SIZE for array length
To:     coolrrsh@gmail.com
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 11:12=E2=80=AFPM <coolrrsh@gmail.com> wrote:
>
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
>
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
> This fixes warnings reported by Coccinelle:
> drivers/gpio/gpio-imx-scu.c:106:32-33: WARNING: Use ARRAY_SIZE
>
> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
> ---
>  drivers/gpio/gpio-imx-scu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-imx-scu.c b/drivers/gpio/gpio-imx-scu.c
> index e190bde5397d..fb05a53c9712 100644
> --- a/drivers/gpio/gpio-imx-scu.c
> +++ b/drivers/gpio/gpio-imx-scu.c
> @@ -103,7 +103,7 @@ static int imx_scu_gpio_probe(struct platform_device =
*pdev)
>         gc =3D &priv->chip;
>         gc->base =3D -1;
>         gc->parent =3D dev;
> -       gc->ngpio =3D sizeof(scu_rsrc_arr)/sizeof(unsigned int);
> +       gc->ngpio =3D ARRAY_SIZE(scu_rsrc_arr)/sizeof(unsigned int);
Since ARRAY_SIZE is being used, no need to divide it with sizeof unsigned i=
nt
again.
...
 gc->ngpio =3D ARRAY_SIZE(scu_rsrc_arr);
...

>         gc->label =3D dev_name(dev);
>         gc->get =3D imx_scu_gpio_get;
>         gc->set =3D imx_scu_gpio_set;
> --
> 2.25.1

thanks,
  -- Khalid Masum
