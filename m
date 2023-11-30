Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5077FFBA9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjK3Tm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjK3TmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:42:23 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12241FC6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:41:02 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4b29f4f9029so321005e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701373261; x=1701978061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn7QMiHmnBhhrQtWzWviINIVzAQIsTIp5DW2ypi2s40=;
        b=QiGhVFcaw8Dn2A2zW1Sha+D4yBySlstOP7PIN8ehquw3tTVueDlk+yUW0hk2thAtdZ
         h/cTfs4BELrGJanZlV8UN6+xwNEPYdJO+gwmmRZhtCIYhTk5XQmBkV7JGKcJA/y76ZMl
         1896F0YO/314IIVRfQWA/ALnjb5vuzzdNFGecKW/uMnClyQgdKVAYLnqegU/8ik4ItV6
         Kf+hXrrp8J8gMsgMy3n0jarvbZPKnPXcHHMI7Obl0ythMqxv6+zhGz0Mq4pIni+L4cYo
         WhcNwYYuk8pfFdZX/JYlipZ9RKDrgtBd7eYph+7+Cx1BCU8r3GKbFwepX78Q5/fUtxYm
         372Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373261; x=1701978061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn7QMiHmnBhhrQtWzWviINIVzAQIsTIp5DW2ypi2s40=;
        b=UtsgWmedddncwFpp+0zFc2/i+5xpA6KUp4z2Vwmm+ivBwDgDk36QIXv7BhGf7CKPhA
         u7qcbQDPc/ErcUbzIyFP+m535ZmjR1JAHjzY83mR4zn9Ly5VzCmb3619nOqRajAznn7f
         sMIV4GadLm3rC0Wia8gQev/pIYM1orA2P8XZGEsXsNT3nKKDE5nuvggsjUuQgvVu22AN
         hTYbNIANBzqbcgl4fhaeK7L5ibXqa7D183tt7YycMXQwku+ttQS9XDNtIyKHWphSXdJL
         p8aDxirfyVHEEnA2w3ArHOA2MRQFDnpyN8MGE9ahUn5h6gBBiFErszBiANhasmTQS9SL
         Pw5g==
X-Gm-Message-State: AOJu0YyCr+qcusU18xOvHy1aLRosowUeNIMSlVNlHUlM4m3yQTkgbpMi
        yHwXj5nlDqtLF+epN8AY9XNda2NI08HiWZMOx/qSMB0w/khW2+qz
X-Google-Smtp-Source: AGHT+IEUMj926+Pj2U9c1X4FFM4L/vibbx6irF3m7H97aRXN73BRfnXeixzpx16hwX/ZcqoMgnUulXyiok+bqErrHr0=
X-Received: by 2002:a1f:4982:0:b0:4b2:8efa:65df with SMTP id
 w124-20020a1f4982000000b004b28efa65dfmr5392973vka.14.1701373261670; Thu, 30
 Nov 2023 11:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20231130134630.18198-1-brgl@bgdev.pl> <20231130134630.18198-2-brgl@bgdev.pl>
 <ZWi34tkzNsvkCQqi@smile.fi.intel.com> <CAMRc=McLyT9h=VGPwserUgwmXOtNx4k2Za7j8VEwAqu7ChXZzQ@mail.gmail.com>
 <ZWjNr6ae4VPTbuvP@smile.fi.intel.com>
In-Reply-To: <ZWjNr6ae4VPTbuvP@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 30 Nov 2023 20:40:50 +0100
Message-ID: <CAMRc=McXbe9iQVMNjcAQCU6m2apO3qnpbAb6d=HWf7y=7PuzeA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] gpiolib: provide gpiochip_dup_line_label()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 7:00=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 30, 2023 at 06:48:06PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Nov 30, 2023 at 5:27=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Nov 30, 2023 at 02:46:21PM +0100, Bartosz Golaszewski wrote:
>
> ...
>
> > > > +     char *cpy;
> > >
> > > So, why not naming it fully, i.e. "copy"?
> > >
> >
> > Ekhm... let me quote the BigPinguin :)
> >
> > --
> >
> > C is a Spartan language, and your naming conventions should follow suit=
.
> > Unlike Modula-2 and Pascal programmers, C programmers do not use cute
> > names like ThisVariableIsATemporaryCounter. A C programmer would call t=
hat
> > variable ``tmp``, which is much easier to write, and not the least more
> > difficult to understand.
>
> In contrary the cpy is more difficult to understand.
>
> `git grep -lw cpy` vs. `git grep -lw copy` suggests that my variant
> is preferable (even excluding tools/ and Documentation/).
>

You are a thorough reviewer but man, are you also a bikeshedder. :)

Whatever, let's make it 'copy'.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
