Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956A77807AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358879AbjHRJAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358873AbjHRJAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:00:37 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08C73C16;
        Fri, 18 Aug 2023 02:00:20 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bcade59b24so619842a34.0;
        Fri, 18 Aug 2023 02:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692349220; x=1692954020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y5Zjf4Br8l/yI83N5VEcoQEhKvn7JUFC0W/m6x6V5Y=;
        b=Y0uxcIRoCGwlTtD/IvhVUbI2rSWmFAWE92NgHSeLQaFHlW1EcyZ7gCXvLo4IV/jF4t
         ZKS3dP5xIlr8YE/KCy396GjUzMFf/A9ohfDvTPqR2Y4xRyHE8WTmIKzcsZFPAJ5t3L9K
         D+AC4w405D+8GDalmiKlfSXXv/WDN7H2lQJG7UHT/N8GeJgq93MWZPPKw9GsiTUivQD6
         bXXNfoF9aJezIoFEdiw/0bCpHDZgfZwzYzVRpDi1p0A2CQA188kEC7VtjmpmxE9kGv3c
         mlGrlb2umy8UT+U0VZQEOSokmOpfCqSi84f+yFQuOsDEffCTOPS8uE8scJw8t5TkdwPU
         GIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349220; x=1692954020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Y5Zjf4Br8l/yI83N5VEcoQEhKvn7JUFC0W/m6x6V5Y=;
        b=D4lT/0EpIX6OP2Mcm/sY7c9fM9lPn01QUHF9lSyX7XogF48ALBu4iy+acL7ksTLhhD
         JqOQOCw+/yJH13X5XhAhnmgBkneKYGaz2NjNSSjlseoganc7M7G/lfwryOrJYI6L+2dC
         Faz8eT85t/uk7lBuO+EbruOFhI4mh3FqJgXl59uFSf7rTjp8iBWVwbej4ZZ5GS/ROkiJ
         tPJMvBMa16wwedknC9XLiPZtS1wy4QFlDimbaV3gWBdEe91nOOntpqHtD/jYQLkF4mbp
         9tq+L4paV9IaSUoztjDCd5GHgMmx1ir9v5Lf8BPKmW1Z1HZjrD3gxTnGsz3T+meX142H
         2mZA==
X-Gm-Message-State: AOJu0YyaUlQNNf51YpDouGy6vZbiqA4crDHJ4yHxzc68X/JIGwGwrPe8
        9RzyoIovwa/ENaa7MGfTaBAQPFUvdLytkqK9JiM=
X-Google-Smtp-Source: AGHT+IHO5of0Xf3dIaJovpBYbVdfni5HT9nb9RZ2UCgHSkLXgxgPEOIp3svCEVUC0/IIfTwto6gnlz1FTvAMpmt8tHs=
X-Received: by 2002:a05:6870:15d5:b0:1c0:1424:5e79 with SMTP id
 k21-20020a05687015d500b001c014245e79mr1885968oad.42.1692349219840; Fri, 18
 Aug 2023 02:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230818012111.22947-1-asmaa@nvidia.com> <20230818012111.22947-3-asmaa@nvidia.com>
In-Reply-To: <20230818012111.22947-3-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Aug 2023 11:59:43 +0300
Message-ID: <CAHp75VehagLZLTb4hC5J+w8JVUu-zYBDb+npeS8ZgadfF9MheA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpio: mlxbf3: Support add_pin_ranges()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 4:21=E2=80=AFAM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:
>
> Support add_pin_ranges() so that pinctrl_gpio_request() can be called.
> The GPIO value is not modified when the user runs the "gpioset" tool.
> This is because when gpiochip_generic_request is invoked by the gpio-mlxb=
f3
> driver, "pin_ranges" is empty so it skips "pinctrl_gpio_request()".
> pinctrl_gpio_request() is essential in the code flow because it changes t=
he
> mux value so that software has control over modifying the GPIO value.
> Adding add_pin_ranges() creates a dependency on the pinctrl-mlxbf3.c driv=
er.

Better now,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

...

>  #define MLXBF3_GPIO_MAX_PINS_PER_BLOCK 32
> +#define MLXBF3_GPIO_MAX_PINS_BLOCK0    MLXBF3_GPIO_MAX_PINS_PER_BLOCK
> +#define MLXBF3_GPIO_MAX_PINS_BLOCK1    24

Since it's a fix for backporting, I'm not insisting to amend it now,
but can we actually drop the common define and use

#define MLXBF3_GPIO_MAX_PINS_BLOCK0    32
#define MLXBF3_GPIO_MAX_PINS_BLOCK1    24

and modify code accordingly, please?

--=20
With Best Regards,
Andy Shevchenko
