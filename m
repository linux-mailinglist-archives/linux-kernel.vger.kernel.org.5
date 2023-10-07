Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC927BC558
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343642AbjJGHE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343578AbjJGHEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:04:24 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72420BD;
        Sat,  7 Oct 2023 00:04:23 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3ae65e8eb45so1953303b6e.1;
        Sat, 07 Oct 2023 00:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696662262; x=1697267062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZVQpme/Czd5/VYAsQPo4BoFaas9BoftbCjcn0zFcSw=;
        b=hTRSVcznJYi1i4XDYx3+tVSmKH/Pu5jUsfxKuHPcR7FeVHjjhy3fAxQP7M5WMEAbbb
         RfXKozW0yZv6ena1ZD0BLPAifHEz/0V6bVLbrmLyC64SRQc/IbJYGS6gf1VR9KF0ssez
         rdqVzaZkQCFfD0o/kNX/rSdWcxWIh9T4ghUUDEBNhkwVUNws+5WOY8xQNqthVusj3dWN
         bWKI++Uss43e0Qxr5LxqX9vlaAIJE44vhVd2QEcMCMAA9RaSwy08AFT2g2SVxfR3d2Oc
         I+/0AWdVRRPtD2B0CQqVMdinWoZnaCJUeWQXyXOfQdiOhNQsUScOrFz+6kFXac20W1HN
         Alug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696662262; x=1697267062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZVQpme/Czd5/VYAsQPo4BoFaas9BoftbCjcn0zFcSw=;
        b=shLzKtL+mzh6SCKbZUgWhBZwNpEp/olI6HK550t9oBvmhlCxRx3/fRCsRAWhRWdLE4
         7VTLZ6CyE0T1mSRz/Z1ZYuR6DAqT0u1yFuNicXWOuW4G13xxHX5qHHTvEcZnKjYtC2fA
         XuYJOiSzGMl8uJU1PgBSlnes9ESapSNLZcvcBp+ryqk9YUEiIW3wO/ig/0dNgWaHw9Ed
         RZbwmL4dtcHs0TMk7NgJDUqClNW1PBUIgmuCEOKtI+MQ+YxQYjoa5KHbxTHFA2an1jA3
         j+emHvHISJ8vMrBm0jd41ueLHlI7tNSH/wDFIgrUFXxvBWaDoJTelKN/XiYBSc6mKBxf
         abxw==
X-Gm-Message-State: AOJu0YwhXn8ev9Iznb430st828HI1efl4rLq3ioZxQEEBI3718eA5Gp5
        5gSG/l5eLkOYrIgPfStjdp7b/j6eNiTEsfVHFaU=
X-Google-Smtp-Source: AGHT+IElCh6zbQYAtET/SeI7Qf0Z54wtjDgQ0dGJOlBmT13Na90J4+1qHL69tsqck07fHDG0CQu2wLQxL0VT8p2avyI=
X-Received: by 2002:aca:2810:0:b0:3ad:fdfb:d384 with SMTP id
 16-20020aca2810000000b003adfdfbd384mr9676137oix.53.1696662262569; Sat, 07 Oct
 2023 00:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231006115147.18559-1-brgl@bgdev.pl> <CACRpkdZP_nOgj77iek_V28Ny8Pb03Xyy-=ho+WqzMHzXajtfqA@mail.gmail.com>
In-Reply-To: <CACRpkdZP_nOgj77iek_V28Ny8Pb03Xyy-=ho+WqzMHzXajtfqA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Oct 2023 10:03:45 +0300
Message-ID: <CAHp75Vdm-um7Ep=kfjEnDotJrbXi1vtfPUVJgcogou8Gr9+MQQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] gpiolib: reverse-assign the fwnode to struct gpio_chip
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dipen Patel <dipenp@nvidia.com>,
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

On Sat, Oct 7, 2023 at 1:14=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
> On Fri, Oct 6, 2023 at 1:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> > struct gpio_chip is not only used to carry the information needed to
> > set-up a GPIO device but is also used in all GPIOLIB callbacks and is
> > passed to the matching functions of lookup helpers.
> >
> > In that last case, it is currently impossible to match a GPIO device by
> > fwnode unless it was explicitly assigned to the chip in the provider
> > code. If the fwnode is taken from the parent device, the pointer in
> > struct gpio_chip will remain NULL.
> >
> > If we have a parent device but gc->fwnode was not assigned by the
> > provider, let's assign it ourselves so that lookup by fwnode can work i=
n
> > all cases.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> because we want the code to work (rough consensus and running code)
>

> The core of the crux is that we have
> information duplication with a reference to the fwnode in two
> places. One in gdev->dev and one in gc->fwnode.

No, we don't. We have plenty of drivers that have gc->fwnode =3D=3D NULL,
which means that it is shared with the parent device.


...

> A gdev is created for each gpio_chip so in my naive brain we could
> get rid of gc->fwnode and only have the one inside gdev->dev?
> +/- some helpful getters/setters if need be.
>
> Or what am I thinking wrong here?

That would work I think. But I'm definitely against this change. It is
the way to nowhere. We should really be quite strict about fwnode and
do NOT assign the gc one behind the provider's back. If something is
not working in this scenario, that should be fixed and not with a hack
like this.

--=20
With Best Regards,
Andy Shevchenko
