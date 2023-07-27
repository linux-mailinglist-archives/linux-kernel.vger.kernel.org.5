Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F34764902
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjG0Hkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjG0HkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:40:25 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B822BE62
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:33:51 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4865f74d470so193681e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690443231; x=1691048031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vv4REg2Yf8PS5o0bQhEpp9B0P8Z+RXmWHj0h5x6kcbI=;
        b=L9jQunHGJvlcdLxkZLlCKaHE96iBdUbE2mx/3tQxsUO1uXTy4vnagEWE9beUg08on8
         VWoOvb0SgjUmGF6bXBjKQYDeYIdMwzTPt4cukCmyT8V+VHSsTijWeqoen56kSct41h4u
         yrhp5iApm+TEjUh+x4vLy41eVbt0ySmF04xCzvSFXPGM143T7zeP9gDaoG+x3lEVHV5o
         uUeT4gdA+85PE/6Aw7FwqLrwmXphITIOkYIFSgvkXkb+n0KFaiiCUoEyyqd/2Il3xN3B
         spSuykZuq06E/cifhIk8PPSH8mBS6tjbF/R1oDgYBne6nmgfjI+dUVKtWxOwozOwloyF
         CFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443231; x=1691048031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vv4REg2Yf8PS5o0bQhEpp9B0P8Z+RXmWHj0h5x6kcbI=;
        b=Cb0rxAHHrhF5QcwaOYuvzdr0kjGQICilGtndTny+5JnRyMlQsMZMURmqcRjrCfohHR
         U8yDbpV6uQxqcnHzrwJA+3qrrWDAw+ZlRLxkLv57XLKe+dj+/eX6O/U4DP3TPzvmivjk
         cMWK1DwWizyFEkZOb6tI8awxaxOv0HMn268DKDk56IRWRJBY90dZqtBs9Swxlc+t5rIv
         vunXYc7Gjo7M8W7gHfQIp2f4r5Tq6n2KjU3FXdftexthWHSnr2ZjxCqZJjez8abZu/Hy
         kcpqlRXVN1PwG+rRkj3Pu7mvFM7QZr6MDhoCRsS9VtZys1uxLjI97V3jM5zoL2XYnGLZ
         LPvw==
X-Gm-Message-State: ABy/qLbSqlgNxyspufunxwyCIosUCJgQQ2VGjMl5tD1Y1xGyyPd1ls3H
        zqbVrs1d4ZbnksHI+uyXZZ8Rp9GizlEWQGhKnudEMA==
X-Google-Smtp-Source: APBJJlHwXIS2/hgcr/ap/qeSP4G3MaqFHX+C0spE06QB+kbzJg3x+PLhUgw73AD5llBGxjU367x3l72hA5G8kzeDD/U=
X-Received: by 2002:a1f:da03:0:b0:486:4a16:63c6 with SMTP id
 r3-20020a1fda03000000b004864a1663c6mr419235vkg.15.1690443230867; Thu, 27 Jul
 2023 00:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 27 Jul 2023 09:33:40 +0200
Message-ID: <CAMRc=McFgnE5mP8qQoTjdqF2p9upojPqs6UG-i897scO+kqEvg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] gpio: ge: fixes and cleanups
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 6:13=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Randy reported a couple of problems, the first two patches
> fix that. On top are a few cleanups.
>
> Andy Shevchenko (6):
>   gpio: ge: Add missing header
>   gpio: ge: Fix English spelling and grammar
>   gpio: ge: Make driver OF-independent
>   gpio: ge: Utilise temporary variable for struct device
>   gpio: ge: Replace GPLv2 boilerplate with SPDX
>   gpio: ge: Enable COMPILE_TEST for the driver
>
>  drivers/gpio/Kconfig   |  2 +-
>  drivers/gpio/gpio-ge.c | 66 +++++++++++++++++++-----------------------
>  2 files changed, 30 insertions(+), 38 deletions(-)
>
> --
> 2.40.0.1.gaa8946217a0b
>

Sweet! Applied the entire thing.

Bart
