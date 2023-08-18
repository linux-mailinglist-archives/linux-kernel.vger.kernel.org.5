Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE5E780DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377239AbjHROZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348084AbjHROZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:25:27 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93572D4A;
        Fri, 18 Aug 2023 07:25:25 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1c4c6717e61so589320fac.1;
        Fri, 18 Aug 2023 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692368725; x=1692973525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBL4ltIIW/RZGmyXJIvtwShlgX2Xe5UDc+ZZ5Bj8UuI=;
        b=QFYyftYhW6RzPbFzvHifdi4haxOlWdZ43SsDaXDUVejV2cVQ/jT1V431izBW5gGkcZ
         3bmEHOq6kjn2D+QwKGRT2cu/QqiCHl6EUUFZ2JLiOfVw1PNpWs0EoOTz/o4ZEIwZ234P
         U3h0Kv8FjXoJ4ndQngCbx5pIXXmZKym131uSnyEeGPs62qXAEi51dNcRxBx6ryTXx5NC
         HP63Vbulahdj1CpfrCbGhB1uW+ADEbxuwMo9PRAySM914DUWczoZZoQ5i08ACNitJGkS
         /IY1Z1bTL91OIRMSWT4LUS0kFKbeLtIbQ1zdf1hffdokE/123LPKmNZvUEdgakQgtxmj
         6BGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692368725; x=1692973525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBL4ltIIW/RZGmyXJIvtwShlgX2Xe5UDc+ZZ5Bj8UuI=;
        b=Gme1qSnlHE5zG+8wKMR+BbSdObURdbe4q1qRfzc1nWIMBwMMd/ud7Mja8BT5il49NV
         i9ICvTU2vcBDh2fv4rigP6w5HYkodiKKCuwLo9tbSY+uwwgFz/1AxC+aRrG4K6sVv3Ms
         KNOsyRC7MZFJcyk3n4q0WOFvas0zqQwo39KG4T2z0Pnb/fG7qRy/T99yxXKcTLpmLa74
         YZ/q/gY8jmd1EhTfm5GINGrLuuRzAsDk/Ka+UWQ6uYrCSkfa7KdP3ypiercfN/38E2rS
         d5RCzIUDHN1/zI7XRjdKvmikFSGvSf0YB4hzyUvM2yTJ/cUUxmLwD2o/YkPNG7Ijw2FY
         igNw==
X-Gm-Message-State: AOJu0YzTVCrNUlM1y9nRvJ9Mx05wxvgL1KaaZSsU94RrxqjrcIP8xFCu
        MCvEpscTUI7AVYkI4IUEbun6pjN9/nCTjyX8Cbg=
X-Google-Smtp-Source: AGHT+IGHL7antrqn5wCJT+a1t2ARJz0cXc1jnpzrhBtNj2GWzju8VdOjYaJzVi1IS1mPpkfNjH17m8B7gCKkqsQBaQE=
X-Received: by 2002:a05:6870:ac24:b0:1c8:c27f:7dbb with SMTP id
 kw36-20020a056870ac2400b001c8c27f7dbbmr3314161oab.41.1692368725262; Fri, 18
 Aug 2023 07:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230818122909.7122-1-asmaa@nvidia.com> <20230818122909.7122-3-asmaa@nvidia.com>
In-Reply-To: <20230818122909.7122-3-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Aug 2023 17:24:49 +0300
Message-ID: <CAHp75VcZ43Zf4co=cVAPNUqHrhJ_zm=Gg7L=v1DYGxntr+Lkfw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpio: mlxbf3: Support add_pin_ranges()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org
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

On Fri, Aug 18, 2023 at 3:29=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
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
>
> Fixes: cd33f216d24 ("gpio: mlxbf3: Add gpio driver support")
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>

You ignored my tag, why?

--=20
With Best Regards,
Andy Shevchenko
