Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7497829E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjHUNEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbjHUNEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:04:06 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C69EE8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:04:04 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d7260fae148so3394176276.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692623043; x=1693227843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fftlaxB/hAY2qV7eGstMIqoqzzhLCuD6MNuSzMJeQ8Q=;
        b=uxHabXuXp1KNAVNO3m4TW3krW7hKeDEIgsHNMRhkluZkuCE7glVzKQTrDLKRiZdt9o
         7iXt0XB065FT5V9zE4KcvFQ3JXP+GzXFoTKtLSuXZKtbExY6exBJJ0tr0fAiWeB0AbiZ
         bw//4cbd8H/i6QCxQYPztItUwbnaTqiOholRPwbWCRxs4IZvXkwUW3zcJ+Nab0Jc//8K
         ITr5jTI4UB/E92ootLJcML4ki3fL8XWUIYt5ZrKlP+xKuoSb47lWikDmwJCkbcF+hfcv
         y3vxcLqXL3FBTwO42d7fkO/pqJmvEc0/bksPDQor39+2FpGk1AjATL0Mz5cwzfdel4BK
         Bddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692623043; x=1693227843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fftlaxB/hAY2qV7eGstMIqoqzzhLCuD6MNuSzMJeQ8Q=;
        b=h9JJIXcIm5qdUnCCRxWhMjVazN+k2Lm7YOTH08ObZEcCzUZXQyIudE12dNuDxBmu8k
         3XHx3let2taITLWMk7g4jHZE4PCF7wwOAUALLkA7i++AUcWsH91hDnNyqcEoUZIxVHcH
         XQFmpJqEQllEXDgosyGF5qfaumdRbOAbGTxVhXzjyGyMqDI85QOY0ysClNpr/bs+37ON
         3YDzpHmjDh9F/6zEOt0R4y9lg2wSrgN9VDIYUCHdnHh7debg3KWy0I7amRIm+Nlb2S0Y
         rDSeyWR7JRRTaC5a9+7dCyPJLgJVMxJIGw39abdgosiKoEGwF4xag5qLi869byZ6E6/1
         5BMQ==
X-Gm-Message-State: AOJu0YyGWXlkSXgsQ0Jtb8dDarlh9KTG2ZJcU5HMt50CIuBt1dqPK4yK
        Su3OztxTR09uElI3wMbgpnW2hZc9jdb0aMawaCkcqA==
X-Google-Smtp-Source: AGHT+IF4hK9dTEy+qIC8KIyQfLc1auoMEebGvpJ7FiQxroEgxJgWgjBLCC6gtgisiv3apV0M7Qt2YoGTdUi3bIWiHwU=
X-Received: by 2002:a25:3746:0:b0:d3b:e659:5329 with SMTP id
 e67-20020a253746000000b00d3be6595329mr5894894yba.9.1692623043275; Mon, 21 Aug
 2023 06:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230817184958.25349-1-brgl@bgdev.pl> <20230817184958.25349-5-brgl@bgdev.pl>
 <ZN9IYYgD6q/H3EuG@smile.fi.intel.com> <CAMRc=MfHCz8CfJniDXhuHXovPZ5AvNdTFUT3-LNYM4sQ15d=yA@mail.gmail.com>
In-Reply-To: <CAMRc=MfHCz8CfJniDXhuHXovPZ5AvNdTFUT3-LNYM4sQ15d=yA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 21 Aug 2023 15:03:52 +0200
Message-ID: <CAMRc=MdtEwZKtySM0DXrrQWz+nFDxDZxwXBhWXywctmz8gAX1A@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] gpio: cdev: wake up chardev poll() on device unbind
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 2:43=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Fri, Aug 18, 2023 at 12:31=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Aug 17, 2023 at 08:49:56PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Add a notifier block to the gpio_chardev_data structure and register =
it
> > > with the gpio_device's device notifier. Upon reception of an event, w=
ake
> > > up the wait queue so that the user-space be forced out of poll() and =
need
> > > to go into a new system call which will then fail due to the chip bei=
ng
> > > gone.
> >
> > ...
> >
> > > +     struct gpio_chardev_data *cdev =3D container_of(nb,
> > > +                                                   struct gpio_chard=
ev_data,
> > > +                                                   device_unregister=
ed_nb);
> >
> >         struct gpio_chardev_data *cdev =3D
> >                 container_of(nb, struct gpio_chardev_data, device_unreg=
istered_nb);
> >
> > ?
>
> I could live with the other version but sure, why not.
>
> I will send a v3 with a helper wrapper around
> blocking_notifier_call_chain() for more brevity.
>

Scratch that, I need coffee. This was supposed to go under the line
state notifications patch.

Bart
