Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69FC7B6CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbjJCPI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjJCPIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:08:54 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B7A7;
        Tue,  3 Oct 2023 08:08:51 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3af608eb34bso590306b6e.1;
        Tue, 03 Oct 2023 08:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696345731; x=1696950531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8z9u1jazZxUkm/2qxN8EBAJw5LUMMLBIMP/RABmSXQ=;
        b=AYaiOOQ2r5bkQh3vjr7U1UslHnG7ZY5NCJkRLI9rlK6f9kjS8ib4ZKRGigV0THvfiR
         aKNC/srzCNqx36i0sDDpVCTSlLnEIjJkyIpCmiuqU4uBhxgVsbiNTmp9U4WR2f9f1c9I
         jWcmE92dOyLe/ZOgM3qHKpeoAujOyIDqajfbeCYeMqnaw3B0k1NGlb1HHmT3hhZedjX8
         kT8bj1sCRS35rs3a671Vxmaiis32DQAxUUzBON9serkOd6wQdAWEkszFM4Js6ab2gSXK
         x4XKYqNS/G5+whkX6Viw577DWJ4r6E//RatS47XKt5mVCOsG7R+GvquZZ3m2RMH1WGNE
         PPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696345731; x=1696950531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8z9u1jazZxUkm/2qxN8EBAJw5LUMMLBIMP/RABmSXQ=;
        b=qtcgZRz75BewlEp7/iLR8DcHwezIXFIIDHUDMdMtnLSqrrx7L8ZvNeSJLj6VT/Eu3Y
         6OqgAxYBe4Fx3zXAzwJ/9fXFhd5xL0axqPsksoUjTPYAMxrrXDdPpVUAO+Mn07OJvWp3
         hDnw9LdV52UyeeyiUgZGLKbB9aVRuzYiV3qNPFWmWkcbEj3twTyEkLFYsmYwh9F30KnQ
         vjNg0gh+1er8o5C7HgWeHXmtQ7T0XhwleO2dr1jxXFquu7GG5L1vaKAC7Wdf6On2RiOK
         0i3x/5JzDEwROHt8kG1pO3oHY4gCtKtUUVfIxxVfKKwsO42a5IC7iHp9x5yvvmfxnCJ+
         5aDA==
X-Gm-Message-State: AOJu0YzN7AEysVKlnKqQf5WMEqR/ip4upIA1yOXDxHgAuDiWIrlz1cCS
        bj8QKaCRNtaC6DiwAvAkx76x6g4MVouMoUXkndKgh4CeOL6qiA==
X-Google-Smtp-Source: AGHT+IERYmvkNLmw5JtjuVtgXExuDbxmMRfnEkEaotGFHgHiorftVljmI1jXWi5rbW6ouKxikrUVumfWBsYCkcR8ExY=
X-Received: by 2002:a05:6808:92:b0:3a8:5fd6:f4cf with SMTP id
 s18-20020a056808009200b003a85fd6f4cfmr15122566oic.22.1696345731263; Tue, 03
 Oct 2023 08:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-3-brgl@bgdev.pl>
In-Reply-To: <20231003145114.21637-3-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Oct 2023 18:08:15 +0300
Message-ID: <CAHp75VfK6Z+Dw44Z4eP-45hK4ipCxrkbj1ifJnmZ3ooZ+ksP-A@mail.gmail.com>
Subject: Re: [PATCH 02/36] pinctrl: provide new GPIO-to-pinctrl glue helpers
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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

On Tue, Oct 3, 2023 at 5:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Currently the pinctrl GPIO helpers all take a number from the global
> GPIO numberspace - of which we're trying to get rid of as argument.
>
> These helpers are almost universally called from GPIOLIB driver
> callbacks which take a pointer to the backing gpio_chip and the
> controller-relative offset as arguments.
>
> Let's provide improved variants of these functions that match the
> GPIOLIB signatures as the first step in removing the older flavor.

...

> +#include <linux/gpio/driver.h>

+ blank line here

>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pinctrl/devinfo.h>
>  #include <linux/pinctrl/machine.h>

...

>  EXPORT_SYMBOL_GPL(pinctrl_gpio_can_use_line);

> +/* This function is deprecated and will be removed. Don't use. */

Shouldn't the same / similar comment be added to
pinctrl_gpio_can_use_line() above?

...

> + * pinctrl_gpio_request_new() - request a single pin to be used as GPIO

"new" is too broad and too odd suffix, what I would see as a better
alternative(s) is (are):

pinctrl_gpiochip_request()
pinctrl_gpio_chip_request()
pinctrl_gc_request()

(sorted by personal preference from high to low).

The similar comment to all of them.

...

>   * This function should *ONLY* be used from gpiolib-based GPIO drivers,
> - * as part of their gpio_free() semantics, platforms and individual driv=
ers
> - * shall *NOT* request GPIO pins to be muxed out.
> + * as part of their gpio_request() semantics, platforms and individual d=
rivers
> + * shall *NOT* request GPIO pins to be muxed in.

Hmm... This looks like a fix to the previous code that can even be backport=
ed.

>   */

--=20
With Best Regards,
Andy Shevchenko
