Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92CD7AFB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjI0HCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjI0HCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:02:17 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AD5121
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:02:16 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-452c0d60616so6481208137.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695798135; x=1696402935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIhw6V2vNvwuHPJdanJymYad1CWCeReXt9hAkVYiSu8=;
        b=UUgp2qkBRuw7atZO+bq6YhZnv2XP7IXd16nAdUZoFPR6yYKrrje3qoKCG8PWe+lXZA
         wvB6L/b2+jWifMiFq2LqfScOb5McaPyr2PYzZvk/ALoL6VW2SHkFRXRTaOUvDD1IGoHf
         ITmQj2ihroFVxBp29v3yyrtt+7r4ErTriCU25/tuGZFctbEV2L4PwyKDhg1o6oBDNOGT
         HP1HGeGNkUro89LmwjFXv9IxiUI4w2v3dQP6TpVZoFaNzNKjsYz9lDXyuSXIwU0eiwqt
         Dud/Vjhj74jiZ3HK5VGJR00Uvdcm+B5JEEbgSrmp3KrKxH+4A1JhuTZCA4KDgkZniqJM
         tmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695798135; x=1696402935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIhw6V2vNvwuHPJdanJymYad1CWCeReXt9hAkVYiSu8=;
        b=lWjQ/U51kS1rYEC1fibOjh+PogZAknS6oU1JmwaC8WCZSUse1EoKSuuP5uOJbRYzbH
         eg3XNXbt6Phm3kvelsIyhiOiN0L2d/45yqjP04D2/RXeIPI5emO6tBNkTSFCudYSkLKC
         Z+wQF15Xfj0Cmv32EUzcYT/ZlVhFWAz08jFVf6SKfsLUMPy1dtSmghdzBB6vazq5j9os
         DL3+M3emtTxnxY68AP/RF4HoJRSvhiQUYsNDYfXVob2Sts8u/hMkDLYNu/qvLv+m7vnq
         NUGIBQC4IIw8epK42vW/BR13+UpIJDYkeyYTilwy6zIWDX29ps0azEXvkBbZfzm1XWwA
         FTrw==
X-Gm-Message-State: AOJu0Yx8pFHuFvaK38vHpwiEru8ozxbW8jYTURb3fKt+mqluBaYp1cfI
        cGIuPKtg0qvadWpzg9FOBjERmnZV0VDV6NB/CJMPEQ==
X-Google-Smtp-Source: AGHT+IFeBg+cETieioky1nVVQRLBCT9NkB2t+sJgbjsopgLmTzgcBajxJFtqUg5cY06CWtryBPEjDMHEXp1rIT8Co8E=
X-Received: by 2002:a05:6102:3e0f:b0:450:985f:ef28 with SMTP id
 j15-20020a0561023e0f00b00450985fef28mr2450526vsv.5.1695798135672; Wed, 27 Sep
 2023 00:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230926145943.42814-1-brgl@bgdev.pl> <20230926145943.42814-3-brgl@bgdev.pl>
 <ZRL4PYeX21bwCPR0@smile.fi.intel.com>
In-Reply-To: <ZRL4PYeX21bwCPR0@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 27 Sep 2023 09:02:04 +0200
Message-ID: <CAMRc=Mf7P4sWdhgTV+jVD8HEVpxbSuGK8JjJb5Q9djCkKUeUcg@mail.gmail.com>
Subject: Re: [RFT PATCH 2/4] platform/x86: int3472: led: don't use gpiod_toggle_active_low()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
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

On Tue, Sep 26, 2023 at 5:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 26, 2023 at 04:59:41PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Instead of acpi_get_and_request_gpiod() + gpiod_toggle_active_low(), us=
e
> > temporary lookup tables with appropriate lookup flags.
>
> ...
>
> > +     int3472->pled.gpio =3D skl_int3472_gpiod_get_from_temp_lookup(
> > +                             int3472->dev, path, agpio->pin_table[0],
> > +                             "int3472,privacy-led", polarity,
> > +                             GPIOD_OUT_LOW);
>
> Personally I found this style weird. I prefer to have longer line over
> the split on the parentheses.
>

I in turn prefer this one. Checkpatch doesn't complain either way so
I'll leave it to the maintainers of this driver to decide.

Bart
