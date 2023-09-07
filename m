Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FBB7975F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjIGQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243345AbjIGP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:59:40 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2EB4C15
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:49:41 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1d4daca8edcso857531fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694101708; x=1694706508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13mPF61qHFznELBakOuaBROvGPz0+u+UN1db/TtYWeY=;
        b=Mlde1OaXeNhgQEQcIfLgK1B/9+AIMgfj2F0PB7G3zBiZfWFXKSVl8I3tIWbPJFQpvH
         NJrJVrvo4fmr3L4PvJklsJXjURvK6FSo9xmaBiTIy4kitNy/ir/di8y3hpdUxsAKKV1J
         un7ep4M/aZuQP/RhJ1CDs+JZYgA/b+4z9xyL9NhhBRPzT0Wm1PNvraKdYR1creuhRFy0
         vJD1yxHACUFfEUyi3+0Mso7Knijpf2gcwhgXc7KWZzXpra5dcmskWThfTaGKlYtLigon
         f5Al2x8rtQsBd6DJY8zzsGTD++tAPSCcvvNDV73WEhO9YtN8v3yJLZ8JqP5N4F74XpBj
         YZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101708; x=1694706508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13mPF61qHFznELBakOuaBROvGPz0+u+UN1db/TtYWeY=;
        b=iGNB03yNapr2ZzSjnEF3jY3gXAuSitlRc3AF9L9ifP/c5pAPVRbc3wamb9flhqrGnG
         tspwhXEmbyvK3WKDj0uc5WUevtxT62YKDT87DWRaoDo8o1hCqu7uhba/m2aiRPW4s9gF
         mA+Y9m4u/yxd0+IReVNgVvk7HtTIXf90ph/6LniEo2H7fG6o+x2r9eDrINE9vBJjibPn
         rFNNtshvjXCLyU0b8G7zpM6DKq6ZFSVHEFzelwOURUtXm89OJoUmdHHIlX3kblszyXzO
         IhriKKUBU2Va/pKS7F0SrJ9T/QF+fC0kWU/nveO6wh/MDi/qcP6ip9vDS065SDVQbB80
         MeoQ==
X-Gm-Message-State: AOJu0YyGYgM1qUXxIiA8dxKCxmkzRodgZYHNaXUYvGbwioaNRhOdqYCo
        szVF7qVBziez2QqOkf0xd2QCPkg4daj6BUwT/VO9fGLX8awcD/1rPoc=
X-Google-Smtp-Source: AGHT+IEb93BSLJ6ys0EYsaB8W8EpvBdYT15JIdt6VJnTL5yTIvHPIi3k4AVOKcoqpkbYj81EENL5j+za7CaCpwJcXlw=
X-Received: by 2002:a25:d783:0:b0:d0e:b924:8e20 with SMTP id
 o125-20020a25d783000000b00d0eb9248e20mr19000067ybg.22.1694072539775; Thu, 07
 Sep 2023 00:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-22-brgl@bgdev.pl>
In-Reply-To: <20230905185309.131295-22-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:42:08 +0200
Message-ID: <CACRpkdZBa7SY=3vykMSOxcQ=z8=igru5uFmyVw0zmTBvAWZTBQ@mail.gmail.com>
Subject: Re: [PATCH 21/21] gpiolib: remove gpiochip_find()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
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
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> With all users of gpiochip_find() converted to using gpio_device_find(),
> we can now remove this function from the kernel.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This is so much cleaner, and introducing some scoped guards
along the way it's a clear win.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
