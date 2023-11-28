Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC87FC14B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346170AbjK1OVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346155AbjK1OVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:21:47 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645ADD53
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:21:53 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5cc55b82ee5so51978417b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701181312; x=1701786112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+UG3eivAjAm0i+X6/FSUZzwGX02Fl0BzHgHDeFoqqU=;
        b=jZZs0GbzNn+sz7MrBuzHP8HBxsQui+JiZa+plNf5Q5NjxvnUikDNTjHvFoqLvZgns0
         WY+6/HYPprNvDDA+aKo7tjC7sQ7gL+rSKOLXtPjmmKN1GnXJuKvvv8hgyzwXvwsNB8Hn
         JuCpq6zPQJuKuoyn1qHPCMix398JiF4oTf3u/ZYOZ2ObbXYJoZw1qrUfn+teLF9aITV0
         ZNQ59fYtNstKStrazOyhEFW+EKJytlY7RRnWH4eNKS/5XNQ3Nczi8He4JoQxBI1bsrJS
         UWUvi0n7igED3NuWzaGudyzzZyTg6jp8+RzVUBhww63enFCfpyuGKcRMh3KBarZ5bUfb
         QcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701181312; x=1701786112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+UG3eivAjAm0i+X6/FSUZzwGX02Fl0BzHgHDeFoqqU=;
        b=HTFZw7acLc4gA57cDdr+J5Af3ILNUrra/DXo8E4ZAEuLLE7GpGAQl4/MA+1Cqvro19
         eBxSpXhcH+dssPxgzcKbHoYXOqbQf3TiFmWXkU4URkZ+CgwXfb0c8x3gYr1/OScygYg0
         Vdvsij210lAnKF3oi5QQgcTRYa5qgFBK7OKjzb6nuu45z2DQQd0ljTx2bnlnWdO2jyud
         h4hU2dgSe5kOlsMxkxWFKhFhMbPn3Jf0OxHyhRft/3BA3mq/b+9oIl0SB5cvYvvKyVa0
         I6jFxjW0mo/jCEWMuWAxKnGbz81UvJWnQLJDX3JMzuw/qDxKyaad//kqgQQKU0Lmmh9n
         tFkg==
X-Gm-Message-State: AOJu0YzdGPLPZxsDFyWtTWYz+1DItcEW6DP3jXYjhCggTEFg3h0XckUG
        kr4jbmAa+9TFDpLzXdng58A9je4Pe6OwccAtBlmHJ68E5aZNcxEWsbY=
X-Google-Smtp-Source: AGHT+IEkGyMKRQn99rVKa8rwk67p/2ddZWmlor3GIfPaWY/5muKqPhZwdy5yzvNoOsgSzfzHVvBhs+aoqqmTJ4cKQxg=
X-Received: by 2002:a81:ac28:0:b0:5d0:4947:63c3 with SMTP id
 k40-20020a81ac28000000b005d0494763c3mr7234365ywh.14.1701181312555; Tue, 28
 Nov 2023 06:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20231127193716.63143-1-brgl@bgdev.pl> <20231127193716.63143-2-brgl@bgdev.pl>
In-Reply-To: <20231127193716.63143-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Nov 2023 15:21:40 +0100
Message-ID: <CACRpkdYG5FbOLDLM+WGEbX-42mjkALU-HfAgdLLhHSq+K1gnaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: use a mutex to protect the list of GPIO devices
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 8:37=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The global list of GPIO devices is never modified or accessed from
> atomic context so it's fine to protect it using a mutex. Add a new
> global lock dedicated to the gpio_devices list and use it whenever
> accessing or modifying it.
>
> While at it: fold the sysfs registering of existing devices into
> gpiolib.c and make gpio_devices static within its compilation unit.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Nice! I might have found some snag:

gpio_device_find() still does guard(spinlock_irqsave)(&gpio_lock);
shouldn't that be switched to the mutex?

On top of this I can update my patch to the delete the comment
for gpio_lock to just rename that thing to gpio_descriptor_lock
and document it as such.

But when I think about it: gpio[_decriptor]_lock can now (after this
patch) be moved into struct gpio_chip as it is really just protecting
the descriptors on the same chip from simultaneous modification,
especially desc->flags. This is a BIG WIN because it makes it a local
lock not a global one, do you wanna try it or should I? (On top of
these two patches, then.)

Yours,
Linus Walleij
