Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDD879B866
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377865AbjIKW3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbjIKLKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:10:12 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE861CDC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:10:07 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-44e8d9e6ca0so1347341137.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694430607; x=1695035407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygzI44NeTHTXZv1CATzGbcxyMKxYdJM78sd/Ui4mbh4=;
        b=S43RlbxgMRIDxaYPaKhgHxFMDEy0YycLcdWKGNBFWNq47kUz/NhhofQvphaQpnnNxA
         rds3vE4/NWKTO/pCmnSC4FhHUg+M40LqaQ06VSDlukuh8FqhZZYBFXONsm10ihTBcxFg
         Bq6mZsekZCorKFbhzsTLz0J3tWCufljGqV8C/jDsHw/wECFgV7QGkvtq4dvZ++yfcMKk
         crn3f7v3a5vweADREqwCWgCnqCMffVF3YlZhK4Q7K0kgWAsgDCrrcwwpOSzZulggjX5P
         tTVCpNbLuc2uQtV1zkW0M/loqKJ4PXklWOB/oXmyBtH7YGIWN3nB93ojRPszCIZyyjpY
         bwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694430607; x=1695035407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygzI44NeTHTXZv1CATzGbcxyMKxYdJM78sd/Ui4mbh4=;
        b=ssoIHTFQ5ZTXgdQg+hPuzcBaK0QJqKQADER4mHksGBPH3IpPyzJijaNBVLEmLd7Vay
         2Xx5DlDItaQsEN8z4eEo11WDiRUbDTWS0nl6+XZKrC/cQdJ/FBMLK4HopcEJintg9wrk
         elmYyHzhRaGKU9gXK3SJuWqK9WJxbzzHYLGI7KNlZmount7dF84pjzMrgDc4XathwH8u
         9tQiqfs8LZh/DWEiO+RAn1vzkpoG2Kx/IBSBMMHRgchr+Eo+wBKwYflB2UOPHSqfW0FV
         D/+poQbdUvlejMZB2MWI2wrUyRiH6HMD70ysSXErzCjcJLVGhuDwpGJg7Yg8jt6eYkml
         BBkw==
X-Gm-Message-State: AOJu0YyDd4yzigjkNm+XFr0sW02XpO1kPiD/HrVRmD0xbeNV1LZSHUD7
        T1UWTQzONkt82Y2DHlohLdIKUUIbnGA2svAFYkvYUQ==
X-Google-Smtp-Source: AGHT+IHKoGdBmULT8rxuDZNFn4KOQlQw0ew3QXPEPQ2cSj+YIXX/HcTVOBuC3A6SmscStWmmEPnPXA1WJ+6yAFCejlE=
X-Received: by 2002:a67:f557:0:b0:44d:5b62:bcd5 with SMTP id
 z23-20020a67f557000000b0044d5b62bcd5mr8865170vsn.23.1694430607044; Mon, 11
 Sep 2023 04:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-16-brgl@bgdev.pl>
 <CACRpkdaVUPNYVjAi2XsNKVhwmtk2qpVp62Lke4xeDOwhhBXLtg@mail.gmail.com> <6555932.G0QQBjFxQf@dell>
In-Reply-To: <6555932.G0QQBjFxQf@dell>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Sep 2023 13:09:56 +0200
Message-ID: <CAMRc=Mfrk9q6fJyEAuxDXYPpbjVHeLJaTjHEcKiYHzrE3r+_7A@mail.gmail.com>
Subject: Re: [RFT PATCH 15/21] arm: omap1: ams-delta: stop using gpiochip_find()
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 8, 2023 at 8:07=E2=80=AFPM Janusz Krzysztofik <jmkrzyszt@gmail.=
com> wrote:
>
> Dnia czwartek, 7 wrze=C5=9Bnia 2023 09:31:01 CEST Linus Walleij pisze:
> > On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > gpiochip_find() is going away as it's not hot-unplug safe. This platf=
orm
> > > is not affected by any of the related problems as this GPIO controlle=
r
> > > cannot really go away but in order to finally remove this function, w=
e
> > > need to convert it to using gpio_device_find() as well.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > I was cleaning this one just some merge cycle ago, now it
> > looks even better!
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Acked-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>

Janusz,

Is it fine if I take it through the GPIO tree?

Bartosz

> Thanks,
> Janusz
>
> >
> > Yours,
> > Linus Walleij
> >
>
>
>
>
