Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC007B6CAB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbjJCPKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjJCPKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:10:40 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFF6A1;
        Tue,  3 Oct 2023 08:10:37 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c4bf619b57so672507a34.1;
        Tue, 03 Oct 2023 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696345837; x=1696950637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiXxWMJ47nKQjlB2J9U2l8AGA4fKp6m9M3Jty/can1k=;
        b=hNqOt8V2s98KEctUz4bJiK0RNVnVTIx6ZPlIuap+Y/ovKrp+eRJcmlX/+rcsOlfR/m
         AzhWpHGzrpmq/bO+5mtrgJORLixDqmL5kgaF02UFJb7Qsx2sTvee41GgV+oJ97Bs2Bt7
         2ryybGGhqvGo6rY7QGGSDayEK8LzJmte3tba/WymAcPJE3OGrt6/0rTv80zF+XfdF0GE
         dkUxJSe0RNYaWRFIKf1g+e7ASJBf6PPpik+zPmbAA6ZU5vg5gm7j/alACqOop013D5Wp
         czNMj2PZpouu3fmT6XdMvwvGm7CH20ZsRjgxTMa6oADjYZZB/AaBN4U7J5je4gGH0WW1
         WGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696345837; x=1696950637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiXxWMJ47nKQjlB2J9U2l8AGA4fKp6m9M3Jty/can1k=;
        b=T2JevvaY24ZkoF4wj+gcnw0zXnSsT8zakOZMIchk+YNV9vrikYh9WIrpLp4W9dEh/f
         ZQX+lEB/nr1T5+WP34JfQ1dnxZtYrmDAppMFtC8NF9iM6JBk139SCihOpzrf50JKZcmy
         /GOp2hp+UoNdPSbLLgHS0dBTsGS5AtXDjuMjNRdpPv5lPCc1QfNgMssYjv6rV2kCdrpv
         WHcAHyD9DByG+5hJ8B6DgIozdIab/0yeCNyXMmw6zZvk72xM7acvRlqtotvxKxuaXfIX
         OI0w7YQpw7+HNMHtrhf1v4vxzpCIKQ29jF4YlmXGJXX6X8tewPI+sbsJmCPJK2vM9okU
         chNA==
X-Gm-Message-State: AOJu0YxXj8ZVgyVU1cN2RiWZrIGFA5VisABWG6nnMMFQ0aBXjTSHJwVG
        VgmTlMKmIX2Iiv6u7KiMUoUb9aJ6GMbY5AMK3CcWTjIgeSwnUg==
X-Google-Smtp-Source: AGHT+IFVYj/b287ok1yTxVdPc83SdF6yNZOr8wmJ4ylyiYMAj1QqoBJqpFFiha+JZwoMIsIf2Dmksflujrplu3Dcou8=
X-Received: by 2002:a05:6808:b29:b0:3a9:9ce5:83a9 with SMTP id
 t9-20020a0568080b2900b003a99ce583a9mr14105387oij.50.1696345836748; Tue, 03
 Oct 2023 08:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-3-brgl@bgdev.pl>
 <CAHp75VfK6Z+Dw44Z4eP-45hK4ipCxrkbj1ifJnmZ3ooZ+ksP-A@mail.gmail.com>
In-Reply-To: <CAHp75VfK6Z+Dw44Z4eP-45hK4ipCxrkbj1ifJnmZ3ooZ+ksP-A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Oct 2023 18:10:00 +0300
Message-ID: <CAHp75VeuX0sG3bncz47wdXO==zO0CUhdP-b628wMw4TdZMh0Cw@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 6:08=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Oct 3, 2023 at 5:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

...

> > + * pinctrl_gpio_request_new() - request a single pin to be used as GPI=
O
>
> "new" is too broad and too odd suffix, what I would see as a better
> alternative(s) is (are):
>
> pinctrl_gpiochip_request()
> pinctrl_gpio_chip_request()
> pinctrl_gc_request()
>
> (sorted by personal preference from high to low).
>
> The similar comment to all of them.

Or since it's about the GPIO line

pinctrl_gpio_line_request()

(and other variants near to this).

--=20
With Best Regards,
Andy Shevchenko
