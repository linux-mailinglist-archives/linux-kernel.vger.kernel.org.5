Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB167B02AF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjI0LWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI0LWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:22:48 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C832F191
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:22:47 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-4545db20ebfso384231137.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695813767; x=1696418567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9W5Ngnr14nBoSC3H+GsUsSguJamNvyP0jPE38TzV6Q=;
        b=dpFKMwO2uHfiNz9y2gx0Nnmmy5ODNomLeaiTrhwCZYmUFpdRnyO1BLzHYplu5oyFnR
         HRrVQvhd9QE63j59Kr7yo+xZwqTsLyZFMYsTI7yHzaOlimyDKiuHdRJck96Wv6DelP68
         ci1gmyg4D6OUdADmjrYrVdvCtDR7wYvOo6hYZfR4KXnVQif6IlwCvLdfzBQqH9YaS/ZX
         wKlNkdVFwnejAQ4zIJWp9NwAzbW5zxHvkQCTNaXDlXpanBScvc8kNME3vJ9cZpwiNvH4
         DVZZlsz4oMxTPazgDGKG/y2qeR85RtEUCiqTA73DPE2y8EOAGMYmsdwpFh32s0Gfa3XK
         6jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813767; x=1696418567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9W5Ngnr14nBoSC3H+GsUsSguJamNvyP0jPE38TzV6Q=;
        b=OHw4stbct7g5PEdG1aGNk6rI+6CTL74By2xgXXpIsqXJ0hKb1WohKXbQhpeMg8ujVZ
         RjQgfqEPm0ix3IBkK0fq/ipxeVoqE7We4/rLfBI4veGSQa8VStFPop8rEhRVuzzTAt4z
         4b97PpJyxWTBNt2l9VboAYgI5DiP43IJMeHBGA/PFwS5i1PB+rGs4QahBSJLox635pGe
         PQzMUKhWPl2vLxgF+b9tDW14OGUFnFRJDibgMxyIwCiwB9Igxzff4ooafaSF/nmnF/Em
         Gq9WzzmcyTHu7PKGhyHLnCBT3yFeJ8z0Yp0TP8JTaARODWYxbWD6kz/VPFV+cL7yOnva
         8jdw==
X-Gm-Message-State: AOJu0YysyKH9TWgAv0qfWHABV7KHd6bPY6rH4A1UTyAKdWP6pb6GBUKo
        tmT0jtuBPr/Qg38sDW1JWtSrCLyh1H9KZSWNwG6y+g==
X-Google-Smtp-Source: AGHT+IGr1xBVjlwUfBbRaYOQjuqK8MH9oxjPnhUw6XCTjJAgAJXthvL/V4CfCz4xo2U7wFPkIciv9LoUnl3NtvK5zJg=
X-Received: by 2002:a67:ec59:0:b0:452:8e0e:9aff with SMTP id
 z25-20020a67ec59000000b004528e0e9affmr1694068vso.2.1695813766870; Wed, 27 Sep
 2023 04:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230915150327.81918-1-brgl@bgdev.pl> <20230915150327.81918-5-brgl@bgdev.pl>
 <ZQf6E+itll3dmCnU@smile.fi.intel.com>
In-Reply-To: <ZQf6E+itll3dmCnU@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 27 Sep 2023 13:22:36 +0200
Message-ID: <CAMRc=Mcq-0yWcYp6ksDF5RP-B+7b+r2KYh5onEMKx1tpS9O4hQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] gpiolib: provide gpio_device_find_by_label()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
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

On Mon, Sep 18, 2023 at 9:19=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 15, 2023 at 05:03:19PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > By far the most common way of looking up GPIO devices is using their
> > label. Provide a helpers for that to avoid every user implementing thei=
r
> > own matching function.
>
> ...
>
> > +static int gpio_chip_match_by_label(struct gpio_chip *gc, void *label)
> > +{
> > +     return gc->label && !strcmp(gc->label, label);
> > +}
>
> I am still wondering if we can oblige providers to have label to be non-e=
mpty.
>

Of course we can. Just bail out of gpiochip_add_data_with_key() if it
is. But that's material for a different patch.

Bart
