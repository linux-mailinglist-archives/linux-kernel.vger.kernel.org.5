Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD7177F12E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348462AbjHQH2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348453AbjHQH1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:27:50 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0091BE7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:27:49 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-447d394d1ebso408951137.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692257268; x=1692862068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dcnCLNSx6SSlpD02iUzLA7e/ZtUtV2RfTBo4GCu2ZI=;
        b=Wj4t4oJ4Smea/Ro550oyP9VJ5BGkV/m5EYLuhrk73PbktdXAu9z2L6LpkEJIubskXz
         iCiQNnyC6WCgc89kRw7xlL/ZCLs8bb/8GUZuheBHnpsh5y0YDh89idjX71JjpYkcJWML
         yzYW29YpPD8H/OYIrRcD++8/omiyeiVBorHzPaGyp3FoJjWqhJgiP28pYghCFUE8K62G
         iJQ8jVtUiJbAHwtm8yKi6A7qjgPEdXedEacw/wJxbJh2W3K3ApPQIt5vst0Ab3S3LjR+
         3uQiBFY1+BIGOmt85nVXX9R/djJbF4HGRu7/klwdxLPB/SP4vHo/EIT/HoPLhJcwsXZ+
         mxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692257268; x=1692862068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dcnCLNSx6SSlpD02iUzLA7e/ZtUtV2RfTBo4GCu2ZI=;
        b=ca9lEsG8clFstfanhsUKBuzR/LwEh8bJeSN4G29uzQQu5Yd2komxlACzPCsbcKnf+Q
         Nmt3YqhobUa2wIQP1Cebubvh1BRiybTg2PUUyHxvk3gOz/57chWWWmUPQt8S4xbD7Jg1
         piPfWwxGEulXfMNJyMfC9yQmO+XSPiQnuXwHoefUgTUEBZiq87ZcyQYTP6ec1+Fq4Kew
         VMB6/oSw9mmMhGzYvf908RoakIF4lX2aP4P4RfhNuKn9ADRmglfnnSLjNkFQYtq+AA5m
         nMSXW60LU5kenHoSvoqqw2GyG2ze0VbodF5+4MICllfO1F3rJyO9BNMwlYUNofAcPCb5
         cu+Q==
X-Gm-Message-State: AOJu0YySaQjVlOAD1ifF/j7IWhLQ6QW+5SLma4+fTkOsixB+agrUiOG8
        eKcwb5vUdwHJDaJB9e3BUKBmC65KzC5oM/6Z0GKdzw==
X-Google-Smtp-Source: AGHT+IG+B9a3PmK10X8sykovRor1/C5v2L5Bk5bwp9/HV9WBfI9PgsKA8nI98gLtiLKB8+cOsW4wSpJBlRJq/Gcd9yQ=
X-Received: by 2002:a05:6102:105:b0:447:9339:a5f with SMTP id
 z5-20020a056102010500b0044793390a5fmr1163876vsq.0.1692257268162; Thu, 17 Aug
 2023 00:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230816122032.15548-1-brgl@bgdev.pl> <CACRpkdaTUi0r+nY12J8sLxmvfG2xRd+OMngcMiQkr5cqerevtA@mail.gmail.com>
 <ZN2k7gemanIpbyFh@sol>
In-Reply-To: <ZN2k7gemanIpbyFh@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 17 Aug 2023 09:27:37 +0200
Message-ID: <CAMRc=MfwK6_m0N4cZqkpMX0Rka4WnWmtKTjq-cwbTR5+sjw9vw@mail.gmail.com>
Subject: Re: [PATCH 0/5] gpio: cdev: bail out of poll() if the device goes down
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Thu, Aug 17, 2023 at 6:41=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Wed, Aug 16, 2023 at 11:41:06PM +0200, Linus Walleij wrote:
> > On Wed, Aug 16, 2023 at 2:20=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Wake up all three wake queues (the one associated with the character
> > > device file, the one for V1 line events and the V2 line request one)
> > > when the underlying GPIO device is unregistered. This way we won't ge=
t
> > > stuck in poll() after the chip is gone as user-space will be forced t=
o
> > > go back into a new system call and will see that gdev->chip is NULL.
> > >
> > > Bartosz Golaszewski (5):
> > >   gpio: cdev: ignore notifications other than line status changes
> > >   gpio: cdev: rename the notifier block and notify callback
> > >   gpio: cdev: wake up chardev poll() on device unbind
> > >   gpio: cdev: wake up linereq poll() on device unbind
> > >   gpio: cdev: wake up lineevent poll() on device unbind
> >
> > I see why this is needed and while the whole notification chain
> > is a bit clunky I really cannot think about anything better so:
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
>
> The issue I have is with the repurposing/reuse of the existing notifier
> block that sends line changed events to the chardev.
> Correct me if I'm wrong, but now all line requests will receive those
> events as well.
> They have no business receiving those events, and it scales badly.
>
> My preference would be for a separate nb for the chip removal to keep
> those two classes of events distinct.
>

I would normally agree if there was a risk of abuse of those
notifications by drivers but this is all private to gpiolib. And line
requests that receive line state notifications simply ignore them.
This isn't a bottleneck codepath IMO so where's the issue? We would be
using a second notifier head of 40 bytes to struct gpio_device for no
reason.

It's your code for most part so if you insist, I can rework it but I'm
more in favor of repurposing the existing notifier.

Bartosz
