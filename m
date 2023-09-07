Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29719797602
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbjIGQBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjIGP5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:57:50 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C53A9E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:45:31 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6c0b40a13ebso444658a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694101469; x=1694706269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM9vERMeF0RyymslElMGVcmFN1ITJOkS0HhbR6rj4eY=;
        b=zmBZWIdaDPVVBwFkTu0eixzB40SbDP4aH0XxHFI13QI2JDmQVUutH/YfoJOsP7rZjh
         SPXwajjHGe53teSwzcDTRmVSPtraBV8PHTAsZzaGEQl+/JcZSCqkOJ4cV2xBDMQ1BxSF
         YtYWlHb0EdacIPjBgjdpl11zM6axbCMv6a+XSfFgStYatz46GJJknOKOzxXl0I/LI+wx
         +Qq2bJt0KgXqpf2uB7UAPYglUedS64TG1CLd+tPj1d5zJ3w0hFQHGYHRln/37A6I68IE
         6GQxW2yCqnzjvZM2UWlzVJm+asvDp+GGZP5g1BfJBWTXjr0akigvIn0PR0puDqokSHc9
         /DVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101469; x=1694706269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EM9vERMeF0RyymslElMGVcmFN1ITJOkS0HhbR6rj4eY=;
        b=kQ+1RYmfCkkpjMZyLWI835SUmKw9Jw+gZztdSU6NHQg5gF5M2UIxVJslJNVl9SkpJh
         W7e2+Am5NBXNOCQJTAWSox54TWoSyHAMVGzo51/0IbHijumaKFNYCRfVBBMN3N6c/BjL
         11ToH4fVkyUQT/kX7EEqHL/zr/B5AGLat4tTw1XXJbFxesMPdfYG68BLVY3n5mXFhBsS
         pDp3bCCBZdyUn9/lxEfGuBPwaihAqsKTDbDxRGo5lrcCxV1MTGbF0F4M/vTj7DJxPLZA
         x2fKjZhsW5JdSRsUpJZ89EX/5pWc44lKs/RZtY7aUMXUmJe8rI2nSxUmoCRnY5ehVptE
         467Q==
X-Gm-Message-State: AOJu0YyxxX7FGvOru1OHxP5bYvTbhobwAt4SEPRvEcsMsp3mjkY4b2Df
        7RjOy6LG/Wdrbtq9Wx0CgDk5SpmcGCVc0GT3Qu2YF0HOU74ii2bI
X-Google-Smtp-Source: AGHT+IE8anPJZAGlVEtdUDBvfZSj/6PcDMAuKXqvs+G37inCYN9bOlMGcS0/NNLAQtkZM5qKA1KbbaOuVnGUeMyCl78=
X-Received: by 2002:a05:6102:2408:b0:447:9339:a5f with SMTP id
 j8-20020a056102240800b0044793390a5fmr1416739vsi.0.1694073488292; Thu, 07 Sep
 2023 00:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-16-brgl@bgdev.pl>
 <CACRpkdaLKqNM1xMCo9jz1Pe_18A=GJodbaTHL+VmoRZa5jJbjQ@mail.gmail.com>
In-Reply-To: <CACRpkdaLKqNM1xMCo9jz1Pe_18A=GJodbaTHL+VmoRZa5jJbjQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 7 Sep 2023 09:57:57 +0200
Message-ID: <CAMRc=McBMTrcVpjWr2Qo2N5Z6+BEAWr6kLG_bPDmmuO=OFTtfg@mail.gmail.com>
Subject: Re: [RFT PATCH 15/21] arm: omap1: ams-delta: stop using gpiochip_find()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 7, 2023 at 9:35=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> Oops one more note:
>
> On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > gpiochip_find() is going away as it's not hot-unplug safe. This platfor=
m
> > is not affected by any of the related problems as this GPIO controller
> > cannot really go away but in order to finally remove this function, we
> > need to convert it to using gpio_device_find() as well.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> (...)
> > +       struct gpio_device *gdev;
> (...)
> > +       gdev =3D gpio_device_find_by_label(OMAP_GPIO_LABEL);
>
> This leaves a reference to the gdev right? No scoped guard?
>
> If you leave a dangling reference intentionally I think it warrants
> a comment ("leaving a ref here so the device will never be
> free:ed").
>

It's right there in the comment. :)

Bart
