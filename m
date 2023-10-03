Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620167B6942
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjJCMoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjJCMoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:44:15 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B40883
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 05:44:12 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7b08ac3ce7fso442306241.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 05:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696337051; x=1696941851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2Pno/JhxzC81iyArk4MRwQPITa8ij+SuPHaUkw0Zzo=;
        b=3HF3H8BsTslLk7/1e4ZCNOzHtXjVGKplDxezdpHV3+eXZPSa+WzfYJfw4UyRpA1hJZ
         uI9izc8QzfzXcR9CGxjZ+QtR5WPEJW7fkN6pDuuqMjC86/K20wSRH9WLn5sQYAXBiLmB
         yG7F4e4I0YcsBpI7LrH7FA1JVes9QX8U6SC12RTFHZFjm8K/1v98eqnVdZPNJYpWRj4Q
         LL5TGezjyLmE2RFNPFX8N7U0P8BLSwnE3pdsMbF4ANrbRZEq3MBLSwMjqdsTovhvgPCy
         iK74w0Do3EylK49Y7X70ZkHljegXAunOdpCegw2WRFEgb5DhaP2G2Pjr64SGDprwKq85
         K1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696337051; x=1696941851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2Pno/JhxzC81iyArk4MRwQPITa8ij+SuPHaUkw0Zzo=;
        b=jR0pVAUHzSGEYuQj32HRaBvL6kaEXGWsNGxDlJFl1hyrkSRGQAP6Zo6QgQc8hT9dep
         NwFffC30CHE7qPiGr1aUg/ixxODrO945bKDRR19mhkQxl0LW9e+WIPzZi4IyzKrI0/TE
         u3Ec3b4peccCfoCfEYeATVhTOGqC4MG+iY1lLbXrf9+jIFfQeB5yHno1Vf9G8HGXyKhU
         mQ8dWkUvQbx3o1M4go70ba2cK22dLryOXbrcqTD2Sz1HU88zbcEp4djSDaSrhiyoJyeF
         lMHTMN+cne9DYUsm337FdfFGX/9mkV4pd9+NaupgM0WUvH48ALl14NmcI12PagN2y3rA
         oXjA==
X-Gm-Message-State: AOJu0YxKoCZqDqGV32o3wrm3naxL8gj1RkMizWoGR3IwoiNL2Tm/BLAw
        XLE6/5zb5muhMT75UxNZ0gxvWI/WPRzuVStI73ajng==
X-Google-Smtp-Source: AGHT+IErCFcuSqB4wWvRMBRfCVGEHv974hU2g6PLQPWynHZYSInHq6KRvT1h4y5s5BMLVOtfJ+GUaa1l3/Yhk9D5obo=
X-Received: by 2002:ac5:cfe1:0:b0:49d:af5:95df with SMTP id
 m33-20020ac5cfe1000000b0049d0af595dfmr10851727vkf.0.1696337051205; Tue, 03
 Oct 2023 05:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230927142931.19798-1-brgl@bgdev.pl> <20230927142931.19798-5-brgl@bgdev.pl>
 <ZRqQ9KZe619vx7pz@smile.fi.intel.com> <CAMRc=MfGPHk9vyS1iDJnB8PQEowB+mWBGM-9CKxDvMrNKnNuhw@mail.gmail.com>
In-Reply-To: <CAMRc=MfGPHk9vyS1iDJnB8PQEowB+mWBGM-9CKxDvMrNKnNuhw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 3 Oct 2023 14:44:00 +0200
Message-ID: <CAMRc=MeiqkENbaJ0SHXJENFoA=+3DZc-kuY4-zUa5Lv5xvw_eg@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] gpiolib: provide gpio_device_find_by_label()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 11:53=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Mon, Oct 2, 2023 at 11:44=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Sep 27, 2023 at 04:29:24PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > By far the most common way of looking up GPIO devices is using their
> > > label. Provide a helpers for that to avoid every user implementing th=
eir
> > > own matching function.
> >
> > ...
> >
> > > +struct gpio_device *gpio_device_find_by_label(const char *label)
> > > +{
> > > +     return gpio_device_find((void *)label, gpio_chip_match_by_label=
);
> > > +}
> >
> > Are we expecting that data referenced by the first parameter to the
> > gpio_device_find() can be altered? If not, why not using const void *
> > there and here as well?
> >
>
> I guess it's a good idea.
>
> Bart

Scratch that. When we know that we're passing a label, it's fine to
have it const but almost treewide, various matching functions take
"void *data" as argument. I'll leave it this way.

Bart
