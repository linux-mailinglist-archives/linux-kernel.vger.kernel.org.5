Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6665B7ADA03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjIYOYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjIYOYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:24:43 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D12103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:24:32 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-452527dded1so2562511137.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695651872; x=1696256672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqqxusyY5ypWGs0jnrBogjXShcemFzSc0iU4IU8sqCE=;
        b=sdsVE52Lr5f6aIu75J4lPL4owknwLFQ4NTyUAQghb6pQ2PVwRXc0oQw5S3zs2h146h
         DrrdB67D0t+koY+bP5UgRyBkDDyJgn3tJSUFTaLAD3NaBfDqHeD69598w2s7VSmvm83S
         xiQ63PFW1OolQbeCDj+U07AP6TNh8MRc43h0Fo/+Zqo0fwD879cJK/HrVjrucdmaORdL
         sEhufOr7V8BF5+JJGj9ZbFNO+sa8tONArNXhQN/mZrHqpXN+skb7J/eusEP62YbwVsUR
         C4a6nvNOjWcUFue0UNyegCrfHgKLlTI9Fl+BGFDBKrNByyJl1VFs+XmJWYQ7MDrcksUR
         PQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695651872; x=1696256672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqqxusyY5ypWGs0jnrBogjXShcemFzSc0iU4IU8sqCE=;
        b=HFTdVdWW2U5v9JkH+Uh8NF8BeiaIGUbk55FsTdn63KRxtwquFj9WSEqTacbB8iSG3q
         RrKLJFojNxRAWGkSbw5gJ9dTg0UjY9evVePbvYY/Z/tDCEsnwj0HUf02g0GCrxr8Mpm7
         4wte/rfs8gDjFcZFvNumlhFD3M8KqOZEnUZJjGJrDftFdd2UrAoMhN62JQn0EzzxiFuC
         X0MnM9LDzyLPWSY0BYMM8B37rhh8qCDTExiL9+I+yO5I/Rv0KdifoHwQq7kTIzvaZdAJ
         UP7nCluCr7DhvSKmdPSbH0/4EdsS8oud2DhmhowpDwGIzISYDglhLAEbYEHoRf0a10Lf
         zs/g==
X-Gm-Message-State: AOJu0YznKAX6e7RoIfOiCsj+huZUm2q7F6jaAo8VNCZuBHwemFeIYwOl
        2dViiu0KnWQZBy2Ag92fH/VxoTavPFy8GurjL4A+ugjVS0e9IWze
X-Google-Smtp-Source: AGHT+IFo0FhBijmrr5hD6xPMdp/ePBcvjNHI00ylV6YLlyYdtidnYQBppJ9nLaNNf7itmPDRec+l1GECRX0IUujkQnk=
X-Received: by 2002:a05:6102:191:b0:452:c0bd:a6b with SMTP id
 r17-20020a056102019100b00452c0bd0a6bmr4603589vsq.21.1695651871989; Mon, 25
 Sep 2023 07:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230920085639.152441-1-brgl@bgdev.pl> <CACRpkdYtbGqmMqN7FNhjYJGG+e0jWQmozf9kpNHiUBJvd2c=7Q@mail.gmail.com>
 <CAMRc=McrXEQbwcsK3yrfROujezjMd1L4EcJj7GNTCE5L6zD1gw@mail.gmail.com>
 <CACRpkdYNA1rkG5wJ0+rAT9g4EyzfbN5VP2a9vuMMk_RD6bMLFA@mail.gmail.com> <CAMRc=MeaAG5w_JzgSNs-EC5HY=2izC4W1FHZ54trEW_PvA8Yfg@mail.gmail.com>
In-Reply-To: <CAMRc=MeaAG5w_JzgSNs-EC5HY=2izC4W1FHZ54trEW_PvA8Yfg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 25 Sep 2023 16:24:20 +0200
Message-ID: <CAMRc=McuKNg5r7m6OPtwYc3er7i6JB2JN=H6QVJU_G9BVtnuAA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: extend the critical sections of lookup tables
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 2:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Wed, 20 Sep 2023 12:58:58 +0200, Linus Walleij <linus.walleij@linaro.o=
rg> said:
> > On Wed, Sep 20, 2023 at 11:33=E2=80=AFAM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:
> >> On Wed, 20 Sep 2023 11:12:58 +0200, Linus Walleij
> >> <linus.walleij@linaro.org> said:
> >> > On Wed, Sep 20, 2023 at 10:56=E2=80=AFAM Bartosz Golaszewski <brgl@b=
gdev.pl> wrote:
> >
> >> > Can we rename this function gpiod_find_lookup_table_locked()
> >> > as per precedents in the kernel, to indicate that it needs to be
> >> > called with a lock held?
> >> >
> >>
> >> I think you mean gpiod_find_lookup_table_unlocked() as with this chang=
e it
> >> will no longer take the lock?
> >
> > I think the pattern is the one I indicated: *_locked() means the functi=
on
> > is to be called with the appropriate lock held, cf
> > arch/arm64/kvm/hyp/nvhe/mm.c
> >
> > pkvm_create_mappings() takes a lock and then calls
> > pkvm_create_mappings_locked() which even asserts that
> > the lock is held.
> >
>
> Ha! I always though the pattern is to call the functions that *DON'T* tak=
e
> the lock _unlocked(). This is what I used in gpiolib-cdev.c or gpio-sim.c=
.
>
> I guess both conventions make sense in some way.
>
> Bart

I don't think I will be doing it just now. We don't use this
convention elsewhere in drivers/gpio/ and we'll have a lot of locking
reworked soon anyway. We may get to it when that is done.

Bart
