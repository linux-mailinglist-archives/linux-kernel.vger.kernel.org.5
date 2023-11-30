Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2FB7FF898
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjK3Rms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346496AbjK3Rmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:42:46 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E34197
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:42:49 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4b28e7a5b41so352209e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701366168; x=1701970968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqziEWQ8hcVSIREtlgxXVkhZ6XD2q21JqLi48D18QSE=;
        b=D7MmWi9WlXiqr2Ohii+aWqE3Czvgx6C2YApyxPHPAjsZQJdSGD0CB5EjfVdeF4qOTr
         3GkexUjC2xt8l+ZPSRhkYxhQE2/FDbzDZUMR27BH03/Tj1vb4uk7Vxg8blGQaOeeBnxz
         2vyAQ1YN6vAP0sOrtWVIf/zjHYAIqM8eFlH/Ajovrz/z58VfdL702KvQmnRW9z/xMo2Q
         U7dW4Mr+7nde011eIHsmaJaJfXbacvESSQo4X7XqHbTDSLMfMDstJeCRhhBCOTbsHW+K
         awR6G+6NXYUrGQrV1to6q+3loJVGpD2etwo2hfatv7/fx5mxUInPox6NGR/gToUo1z08
         gZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701366168; x=1701970968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqziEWQ8hcVSIREtlgxXVkhZ6XD2q21JqLi48D18QSE=;
        b=WXCeYs/PKm/HXfXIGpz1wci4KogpBbWapVqPkHKrnsPRHJIO+3lQRw4YLmrWMvTxuJ
         4GRq9HxblQi4dAKjOrq9af8ItqwGfBG+gECQyXSvKHFTlWUrPM4s6mrK9cioDglFxN/3
         G702hMsnPG1+Arghx0QwIupGrQFmhTW/ooGjxgnGXpndzI75HBAd9KjdHM7sOkIb5TXb
         zbTHW+92EXWcFmN04q/coWve0OqeqAlhV7+dUwwuLxCnaFdpOCPoXvkBMgeDl31TFbwS
         sgiGhoQhee5KO+Y9+viIQeAecHjdpl5WklD5vn3pBvxx8+Rlvb9oF6CayNGb+VrNGZ18
         6Opw==
X-Gm-Message-State: AOJu0YyA7+39lWXHfWffVFkNJc0UEJtlt8fdWhq12wWlu+TuI5orGFq8
        0hSEyvgGIp0DNpP8tuRh1/ocfnLmDbbRLPEkRgpzUugnzCofFOfg
X-Google-Smtp-Source: AGHT+IG76s8PlXysbg/bGFFqcSBsEzLMyndFmxdYHz6VSVcOSJUOzOgaHvsILnhDYlzQt408pJ3KgSNZDoNn761blcg=
X-Received: by 2002:a1f:c405:0:b0:4ac:b0a6:4c16 with SMTP id
 u5-20020a1fc405000000b004acb0a64c16mr13397943vkf.10.1701366168281; Thu, 30
 Nov 2023 09:42:48 -0800 (PST)
MIME-Version: 1.0
References: <20231130134630.18198-1-brgl@bgdev.pl> <20231130134630.18198-10-brgl@bgdev.pl>
 <ZWi6_WnOQZB0vgPL@smile.fi.intel.com>
In-Reply-To: <ZWi6_WnOQZB0vgPL@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 30 Nov 2023 18:42:37 +0100
Message-ID: <CAMRc=MfC9sxgvaigtP5=MMZwbzaSkUukfH61QBf+r_eTJh5fJA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] gpiolib: use gpiochip_dup_line_label() in
 for_each helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Thu, Nov 30, 2023 at 5:40=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 30, 2023 at 02:46:29PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Rework for_each_requested_gpio_in_range() to use the new helper to
> > retrieve a dynamically allocated copy of the descriptor label and free
> > it at the end of each iteration. We need to leverage the CLASS()'
> > destructor to make sure that the label is freed even when breaking out
> > of the loop.
>
> ...
>
> >  const char *gpiochip_is_requested(struct gpio_chip *gc, unsigned int o=
ffset);
> >  char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offse=
t);
> >
> > +
>
> One blank line is enough.
>
> > +struct _gpiochip_for_each_data {
> > +     const char **label;
> > +     int *i;
>
> Why is this a signed?
>

Some users use signed, others use unsigned. It doesn't matter as we
can't overflow it with the limit on the lines we have.

Bart

> > +};
>
> ...
>
> > +DEFINE_CLASS(_gpiochip_for_each_data,
> > +          struct _gpiochip_for_each_data,
> > +          if (*_T.label) kfree(*_T.label),
> > +          ({ struct _gpiochip_for_each_data _data =3D { label, i };
> > +             *_data.i =3D 0;
> > +             _data; }),
>
> To me indentation of ({}) is quite weird. Where is this style being used
> instead of more readable
>

There are no guidelines for this type of C abuse AFAIK. The macro may
be ugly but at least it hides the details from users which look nice
instead.

Bart

>         ({
>            ...
>         })
>
> ?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
