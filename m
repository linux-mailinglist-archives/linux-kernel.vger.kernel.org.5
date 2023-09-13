Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21A79E832
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbjIMMji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjIMMjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:39:37 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A53B19B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:39:33 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44ee7688829so2237775137.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694608772; x=1695213572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofo7sSePT/jaZ7VhEZ8Xa5CLpX5xgx/ZwhBkOWdddew=;
        b=FS6PKu7cFaiKkXGoREvmNvcSSWrkorNOoAb4llWAGsgpSLVeeW4D/Gm++e0sgDRfyS
         GBc0IFv3IqiDlzD7V1Pr6EYiCvtQas/PWj+QkoM5mKd1yYELakqwYdUWl2xAq8uhArXh
         h7GL6P+ZtWmXtporIoYgenT5SSaWXfwd09MSxxBHsnfZseW4XfKU5T+r57b+XRh35x/I
         DQkaWSQute483X7x8XwVGIlMJIZ6EhaWmd06OxHDG23iKaqye40V5kprbMb6FMVVdObJ
         n11R2oTaGCL5dijA3BNyqZwY0FO6AE0vJwhnXistP4pdxMgmIFGUFPnbjNndB88k9Lew
         zcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694608772; x=1695213572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofo7sSePT/jaZ7VhEZ8Xa5CLpX5xgx/ZwhBkOWdddew=;
        b=aU+POEEaNoQtO+qHTvDmzYbVKWFImRGA3+buy9Xb3q4fqPdTJIAVJXETWOMy87iEUF
         bzx/+oReKUmIuh4wkg7kdPU9FMDp9QI24XWLjW4nxrEzRdreE2GdzvefE1lkeQTX94vQ
         IbjiQsaH1viTMXSetqUmP0nCS2lCY97BzQAcp1jp5xMyohpu7rfPthgJH+3NxMFXloUT
         rUJktDZLwjEiNP9CUbteCZaPFpZ2RTHssi+1Bj4xq+dcjwYBfapWuWzUDmz1NwXfmIvZ
         k51Cey2ej9ZwI9zbgAeeCC1vyZJRltM9wxuwpXaxdN0ujcqk8J7XDFqQDTbu42EWLrk7
         GVvw==
X-Gm-Message-State: AOJu0Yx5EmJBX8BFL4jWVPF5waknlHXsBrBXR1AGQWmKd/2SNuxdfN0Q
        +fsQdkFRiOdheCqSqn7inwxeJrnaJo7KatYhm9tEEg==
X-Google-Smtp-Source: AGHT+IGdKI7ktabjI9KwOzEcCjHAPyvQReZHZJXN4jgvOMDrMNawaWOJWq7y+jd93g3lR7Fo2HZ29IzhmronhGMfaDk=
X-Received: by 2002:a67:fa03:0:b0:447:779b:a357 with SMTP id
 i3-20020a67fa03000000b00447779ba357mr1865242vsq.32.1694608772217; Wed, 13 Sep
 2023 05:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230913115001.23183-1-brgl@bgdev.pl> <20230913115001.23183-4-brgl@bgdev.pl>
 <CACRpkdax-CrB42LeQ1bs3E7VqMncsgEwMs7b_v7J6R5AE+BjAg@mail.gmail.com>
In-Reply-To: <CACRpkdax-CrB42LeQ1bs3E7VqMncsgEwMs7b_v7J6R5AE+BjAg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Sep 2023 14:39:21 +0200
Message-ID: <CAMRc=Mdt0wbjzbwBLK5m--VLV2WE5JybgrNYWXtbinPu_c=psw@mail.gmail.com>
Subject: Re: [PATCH 3/5] mmc: slot-gpio: use gpiod_set_active_[low|high]()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 2:24=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Wed, Sep 13, 2023 at 1:50=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We have new, less cumbersome and clearer interfaces for controlling GPI=
O
> > polarity. Use them in the MMC code.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> I like the looks of the code better, obviously but this looks like this f=
or
> a reason unfortunately.
>
> See the following from
> Documentation/devicetree/bindings/mmc/mmc-controller.yaml:
>
>   # CD and WP lines can be implemented on the hardware in one of two
>   # ways: as GPIOs, specified in cd-gpios and wp-gpios properties, or
>   # as dedicated pins. Polarity of dedicated pins can be specified,
>   # using *-inverted properties. GPIO polarity can also be specified
>   # using the GPIO_ACTIVE_LOW flag. This creates an ambiguity in the
>   # latter case. We choose to use the XOR logic for GPIO CD and WP
>   # lines.  This means, the two properties are "superimposed," for
>   # example leaving the GPIO_ACTIVE_LOW flag clear and specifying the
>   # respective *-inverted property property results in a
>   # double-inversion and actually means the "normal" line polarity is
>   # in effect.
>

I hate it, thanks. :)

> Will you still provide the desired "double inversion" after this patch?
>

Not in the current form. Would it work to go:

if (override_active_level) {
    if (!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH))
        gpiod_set_active_high(desc);
    else
        gpiod_set_active_low(desc);
} else {
    if (host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
        gpiod_set_active_high(desc);
    else
        gpiod_set_active_low(desc);
}

?

Alternatively we could reimplement the toggle semantics locally in a
helper function in order to get rid of it from GPIOLIB.

Bart
