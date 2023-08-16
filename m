Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACFD77E3E6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245375AbjHPOl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343832AbjHPOlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:41:22 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98E5E2;
        Wed, 16 Aug 2023 07:41:21 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1bbdddd3c94so5097274fac.0;
        Wed, 16 Aug 2023 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692196881; x=1692801681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+O5J48zlOMffFyK7ShPKRZLj72xD0eamwdeBSf3vdB0=;
        b=Z1CDtXr+5OM+Em8WEEf/Z2LMtcxg/gUe5xibFCAEXX1b00g7fvvWp5eV0cIkfWvwUA
         n7h7VjjxXohbBgOx/pjBDQbGJiaANrHKNonEVwDgqeoNrWrm/eLtSmbhuoq7W2S7ZFrQ
         sCPOta8OyDPyq8R9jY0Uz94diJQK5LBkEd9RCg/havUEsOqw/pVrnMzGYWpp1ZcxTaL3
         jgscfQBOAVFa0jLJdNZAdPHsOKgRUZjvQkap/KAHbZn5K2hAm3Mt7oCenNwhfePV5xRD
         ygsuWJMNc8UEvsY8sxBbtdPQn9lG8KYgygxVkps9RXdnyGBHX7Aj0rFRH8vGcX8pssUF
         X4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692196881; x=1692801681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+O5J48zlOMffFyK7ShPKRZLj72xD0eamwdeBSf3vdB0=;
        b=VMsFAzqJM1URd4Dj+Zlzn+wHYPqbSNz6CiTdziTLM85+IJt7URRfy+adTBp87ZijCu
         TI+EbNJ+2+lMHRO9SjePCLcuRmU5UW6SbZ8DJArZFk3+jubzE97C8SDD1zihJmW+8byx
         jvcBjFetgK3d/6PultYBK1Oi4tawB0wkgxuRbTQidallphBQJONRQbKtsIkSxZfZHaGq
         sZ8AgS2Pdc9BqLvLiD8ngkdLv6581mU9ZouM0+kNvMExsxxcrFgAdABGw7c7IC9PI0tZ
         GapQLNEAG3BawvSIIp+jztV6F8IifjZDLI4Xl0FmK48ZCd0VtpuUUqZP6i+UlC/ppDZA
         Ui4g==
X-Gm-Message-State: AOJu0Yysrze2PYr0Dj6/Dk4L3UwSTSo5pJzmCQ/UUcjoutxuLTkFeCh0
        kfV94/Hpi12QhOy05axvjFUyuBf89JvHfrJOYNw=
X-Google-Smtp-Source: AGHT+IFJ4EFHKUJLhwY9hKt98EBKYPSH1tI9pnsRYRhVOi3/DNJt+GzJSPSWVsrVsLrmcsSZj6hQrh5dYPyg6FU3vcM=
X-Received: by 2002:a05:6871:54f:b0:1be:cc5b:6ce with SMTP id
 t15-20020a056871054f00b001becc5b06cemr2216884oal.20.1692196881189; Wed, 16
 Aug 2023 07:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230816135839.24011-1-asmaa@nvidia.com> <20230816135839.24011-3-asmaa@nvidia.com>
In-Reply-To: <20230816135839.24011-3-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Aug 2023 17:40:45 +0300
Message-ID: <CAHp75Vf1qw==m_OSfY-p5E3tnDFVcKMwky4eGbSbR=aWhQnE5g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: mlxbf3: Support add_pin_ranges()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 4:59=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:
>
> Support add_pin_ranges() so that pinctrl_gpio_request() can be called.
> The GPIO value is not modified when the user runs the "gpioset" tool.
> This is because when gpiochip_generic_request is invoked by the gpio-mlxb=
f3
> driver, "pin_ranges" is empty so it skips "pinctrl_gpio_request()".
> pinctrl_gpio_request() is essential in the code flow because it changes t=
he
> mux value so that software has control over modifying the GPIO value.
> Adding add_pin_ranges() creates a dependency on the pinctrl-mlxbf3.c driv=
er.

...

> +static int mlxbf3_gpio_add_pin_ranges(struct gpio_chip *chip)
> +{
> +       int ret;
> +       int id =3D 0;

Redundant assignment.

> +       id =3D !!(chip->ngpio % MLXBF3_GPIO_MAX_PINS_PER_BLOCK);

Using int as boolean. Seems to me you wanted something different here.

> +       ret =3D gpiochip_add_pin_range(chip,
> +                       "MLNXBF34:00",
> +                       chip->base,
> +                       id * MLXBF3_GPIO_MAX_PINS_PER_BLOCK,
> +                       chip->ngpio);
> +       if (ret)
> +               return ret;
> +
> +       return 0;

You can return directly:

  return gpiochip_add_pin_range(...);

> +}

--=20
With Best Regards,
Andy Shevchenko
