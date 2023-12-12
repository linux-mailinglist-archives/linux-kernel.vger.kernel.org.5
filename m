Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929A580FBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377522AbjLLX6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjLLX6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:58:08 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BFDB2;
        Tue, 12 Dec 2023 15:58:14 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c210e34088so5228291a12.2;
        Tue, 12 Dec 2023 15:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702425490; x=1703030290; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WY977mAi5HwM1Re1JNSyw1hSd3wTJM+QSi5mNmNbSmY=;
        b=kD/xs5DG8YRdT4UUhe+frEZQxebNTUXf/Sh+XSMIh6ANWlqxYtynZxe0JJ1AfW9bPq
         BFuMKYw4f7A1G9v3Jt36ZiaHGcKh/Y/BgekfByYuSd7rsy3SAAurywiFO72/5Z12kSkn
         Kks97R3wjj2q5e+jm+31rVs8KGVYPDzskloN/wcA5NJ5YnwTMVP6mJ25BYVLz/e09ZgP
         x4tYFU20j5ZknLke+uL+fgTZmVm1TDVoUw0z/ElKpKT13pJJwMCC9nyEd/UpvFyad5xD
         FplNvFpkxyNv+tyd5zRkgxM9z1H9bx+V97nBfhXsL6gEP/niKNkQhGtPcVICNQm0+yOS
         p8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702425490; x=1703030290;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WY977mAi5HwM1Re1JNSyw1hSd3wTJM+QSi5mNmNbSmY=;
        b=aQa8LVdCfNIFNCNQdlOMO6D4dNW1RxS1pVGVDjuYqJv2TgRiw2BcbRzbfujhX7ijgf
         dAAXBNwrT95Z8rAfiBPkZdvrCiBtHSNr9F9gg2KxexATIjgE3x98zDHVW+iOUcSXGDvy
         inyurEuaYYf7he/U0SPOYRF3Kgx5ToM/owWeTL7C+Qri7UNeirYfJSeyKTEr+NzuiSYv
         rcuVKirGdjHmI2CGok61vM+LzTF/nlCO4++yzDv4FFTqJ3r4yEkwZBkAraMjI2wqZJAX
         VgQ+FeCEWejeTSgwrDZjYfPXn6gxqs3MipqkWxq1NECLe0iNpH/YG9hQvRcnujhg/VLg
         DQAA==
X-Gm-Message-State: AOJu0YwxDt5uMnFXok1v22ACRcWCKzSLt2UurO9ckRZpyqbDkza8za+f
        p5tKpEUWz7CrdG/qM4FuC+hs8KcXBBQ=
X-Google-Smtp-Source: AGHT+IEN1M2m1fMPKM1QlMZNADUU9UIl8/5swPq2xJewaX3t8kJvummweEvIbGb+B2HDSgH1vZA0eA==
X-Received: by 2002:a17:902:f7c5:b0:1d0:98db:6fd4 with SMTP id h5-20020a170902f7c500b001d098db6fd4mr6344189plw.56.1702425489555;
        Tue, 12 Dec 2023 15:58:09 -0800 (PST)
Received: from rigel (194-223-186-106.tpgi.com.au. [194.223.186.106])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902834300b001d1d1ef8be5sm9144470pln.173.2023.12.12.15.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 15:58:09 -0800 (PST)
Date:   Wed, 13 Dec 2023 07:58:04 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, andy@kernel.org
Subject: Re: [PATCH 0/4] gpiolib: cdev: relocate debounce_period_us
Message-ID: <ZXjzjOtKFoMRhKA-@rigel>
References: <20231212054253.50094-1-warthog618@gmail.com>
 <CAMRc=Me90Lu7Duc8-4xSfDcHQd6M7+0t0O8FAa6jiizp-OO5=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me90Lu7Duc8-4xSfDcHQd6M7+0t0O8FAa6jiizp-OO5=Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 06:09:00PM +0100, Bartosz Golaszewski wrote:
> On Tue, Dec 12, 2023 at 6:43 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > This series contains minor improvements to gpiolib-cdev.
> >
> > The banner change is relocating the debounce_period_us from gpiolib's
> > struct gpio_desc to cdev's struct line.  The first patch stores the
> > field locally in cdev.  The second removes the now unused field from
> > gpiolib.
> >
> > The third patch is somewhat related and removes a FIXME from
> > gpio_desc_to_lineinfo().  The FIXME relates to a race condition in
> > the calculation of the used  flag, but I would assert that from
> > the userspace perspective the read operation itself is inherently racy.
> > The line being reported as unused in the info provides no guarantee -
> > it just an indicator that requesting the line is likely to succeed -
> > assuming the line is not otherwise requested in the meantime.
> > Give the overall operation is racy, trying to stamp out an unlikely
> > race within the operation is pointless. Accept it as a possibility
> > that has negligible side-effects and reduce the number of locks held
> > simultaneously and the duration that the gpio_lock is held.
> >
> > The fourth patch is unrelated to debounce or info, but addresses Andy's
> > recent assertion that the linereq get/set values functions are confusing
> > and under documented.  Figured I may as well add that while I was in
> > there.
> >
> > Kent Gibson (4):
> >   gpiolib: cdev: relocate debounce_period_us from struct gpio_desc
> >   gpiolib: remove debounce_period_us from struct gpio_desc
> >   gpiolib: cdev: reduce locking in gpio_desc_to_lineinfo()
> >   gpiolib: cdev: improve documentation of get/set values
> >
> >  drivers/gpio/gpiolib-cdev.c | 257 ++++++++++++++++++++++++++++--------
> >  drivers/gpio/gpiolib.c      |   3 -
> >  drivers/gpio/gpiolib.h      |   5 -
> >  3 files changed, 201 insertions(+), 64 deletions(-)
> >
> > --
> > 2.39.2
> >
>
> Patches 2-4 look fine, I was about to review patch 1 in detail but I
> thought I'd just throw this one in here before we commit to a specific
> solution.
>
> For some reason I thought this would not work but I'm now considering
> it as an alternative approach: is there anything wrong with adding
> struct kref to struct line, allocating it separately per-line when
> gpio_chardev_data is created, referencing it from struct linereq when
> the line is being requested, and dropping the reference from
> gpio_chardev_data and linereq when either is being removed? Other than
> the increased number of allocations?
>

The collection of struct line always has to be global, right, as both
gpio_chardev_data and linereq are ephemeral.  e.g. if one process requests
a line and another checks the lineinfo, those will have distinct
gpio_chardev_data.

But the key issue is that the linereq and struct line lifetimes are
strictly tied - a struct line does not live beyond the containing linereq.
Leaving the struct line alive after the linereq is released is just wrong.
The line has been released back to gpiolib so there can be no
supplemental info left.
If you want any such info to persist beyond the line release then it
should be located in gpiolib itself, not cdev.

Cheers,
Kent.

