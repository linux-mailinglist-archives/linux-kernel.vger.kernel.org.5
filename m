Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA81A7AE854
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjIZIw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjIZIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:52:26 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD29BDE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:52:19 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59c0d329a8bso100535327b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695718339; x=1696323139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NajgLg0J9ZRZ9dxlVjqGamAcS2J4TWmxpdZ8CDcWXXs=;
        b=u3XJ5mDTB7L8Qw29oThWy4vExIHT0gkw1+Li6pYo+XbW9Qpnf2TKOjj8MDhDIN6kar
         99Obqrng/bUEPdy8nx+z4IzWiHZCNzn6j2kHWBSlstXiU04KH8J4yEaWS8sV5WLEJBJX
         y23nNehJw8KuFCsKE9qTbr3KflOuB2reMZkOTCs7KaMMl1hQTXjj3XBISTAlMq4mI1SQ
         LPuuHL2jloIsVKeZD2dCzldubXZ8NEbZzDPW7/6PMMSR9Ca2u7Xi9oBMUXrZ7a/ZilcV
         KxpMb5p9fLklDAqlSHBi7xBb++bUSfBg+hnLA3l2SdfG80x2ouCAM7FJ16Y765WPozhG
         KhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695718339; x=1696323139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NajgLg0J9ZRZ9dxlVjqGamAcS2J4TWmxpdZ8CDcWXXs=;
        b=EbovOJx4F82votoMaFnvZiJ3wCJbNxBoNZ4Vfd6HpxFCv794Hx0C/pgKWxT9OUoqqW
         PZQVs5OmQPqtrJgr8jV4uQ0guFSfenNMLyP5o2GMmvH8UVqrRA171wtQwnO9O5KitgLc
         iIZAfRk7Cx/tRe1wOWdFt12Pjeh0AEvl6VgoHSSlY7FJdmBAZbaps9XvUFutABM4mNMN
         0IBYjfJIpKM5/gFmvI2Yz9e0bKL5xzCYiXkjObkQz60OmIHyaSYwZAoCm+K0yXBR+DE8
         iEao4z5+eX7UCOu+1xUxykuUqG05D6UDIlvfPrSFdBodghbqugIkuo4J0S7GZi1p61kj
         Fwcw==
X-Gm-Message-State: AOJu0YyJnZ5dlSZSBJWw2Hbk4v0aegDv6uQQd5ffNov5aTsVJ2FeUJe2
        laMokjO6d1TbX3MKvjt7ZRrujdG9va3nOW/sNmj8vw==
X-Google-Smtp-Source: AGHT+IGaTn9+E8MiVA9mTTAzTlh5BjP/aULRmMqIstVahTUxNoAfr2vyacuq/Q/2G+tK5Q2Lhv7tmCUGk8E2c7J2+Wc=
X-Received: by 2002:a81:6241:0:b0:58c:b8b4:2785 with SMTP id
 w62-20020a816241000000b0058cb8b42785mr9588689ywb.45.1695718337612; Tue, 26
 Sep 2023 01:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Sep 2023 10:52:05 +0200
Message-ID: <CACRpkdYCY+P5+6nk28TQ9stoyYO83q1X1YG7mbrBJnG65uTwwA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] bitmap: get rid of bitmap_remap() and
 bitmap_biremap() uses
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 7:20=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> As Rasmus suggested [1], the bit remapping APIs should be local to NUMA.
> However, they are being in use outside of that for a while. To make
> above happen, introduces simplified APIs that can be used otherwise.
>
> It seems we might have yet another user of the above mentioned APIs.
>
> The last patch has not been tested anyhow (except compilation, so
> all testing and comments are welcome).
>
> The idea is to get an immutable tag (via my tree) that can be pulled
> by bitmap and GPIO trees on the need (while usually I send PR to
> the GPIO subsystem).
>
> Link: https://lore.kernel.org/all/20230815235934.47782-1-yury.norov@gmail=
.com/ [1]

I don't understand the bitmap changes very well, but the resulting
changes to cdev look very nice clearly making that code more readable
and maintainable, so FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
