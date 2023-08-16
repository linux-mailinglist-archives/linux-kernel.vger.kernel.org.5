Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D457B77E08A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244682AbjHPLhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244737AbjHPLhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:37:01 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1251999
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:36:57 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-79414715edeso1234850241.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692185816; x=1692790616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8utVMODUqm6xsvxcRtWOhFIkEQFzWJINP/JmaVKaTtU=;
        b=sezLwRdx4hxsP/dGkVzThHl9b/Jhg2mXJZagXcwHA31f7oKy0Oxbrmytex6rfStRno
         rjQyI2YRvpFMRhBCRxRSubPVo5t/RbZJQPHhD0lg21Yay5fc69nvR49qxVeBc6gLRkbo
         KM2EkPMLEFa4lKVpFxkmOUReBBvz/76310o2mtQ9XlT9X61yQPr0k3RJuVGy6QneBViK
         fPUhi2NcjXPQ4whePoPpzRAn9qtbI2gXN9kkyCd7RA3tIe6OwXQBjReLRDg7Onx004Gm
         IqA5eKCeblLI1xbxUq2EjQCQIIehhWpZkcrNHxZ/YeImfwiG2wEcledLRnzdewQ+KDLk
         0vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692185816; x=1692790616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8utVMODUqm6xsvxcRtWOhFIkEQFzWJINP/JmaVKaTtU=;
        b=FGxY4ZrTqf+x1s/tr+BM0BRi6xPJcwMbP3b3RfakRLe1ch9NKoutJTLRI561wnZw7R
         1F/M3u/1miCPdpSzBisdwObRUwnq8yEx6HbYivl1IejYdVeb5JWFRam6040OThFs83qE
         xc8ajTAC47m3CMPHTiDgAu3TIpbBp6J/59/LME8PIVUK3Z4sRmazqcL93wpa/pgfI/Nk
         VxTt7HFLf2NA+/nt9ZlBjoQpEGzCJuxN2w6sCTTWSepdOTh7LnR9wQ69T9xA5HDenZWP
         PHUoqDkEbalXZ+wCC0+Q4yNweeg7IuWoNjdJOFhuuKVp6iyDuDyHqlnAJy2I31OGPuiG
         fkRw==
X-Gm-Message-State: AOJu0YwN7NHuyL0hDZG9HwLnHx5odtsXJBBO9Sxz9OQpiyx+TygDQKaf
        P3GELYy0FcOd1kPqCWl9tYc15AFEEVxLDqXHQUXANA==
X-Google-Smtp-Source: AGHT+IFfEn4Rk4jNN7VvWna5cPpznsBqX0dSIl1iaR7rq/jEXlx/oYgKmzwMMAPmH8KlqfUlptM1ZC60SjtZeKTdvng=
X-Received: by 2002:a67:db0f:0:b0:447:54ff:388 with SMTP id
 z15-20020a67db0f000000b0044754ff0388mr726858vsj.23.1692185816397; Wed, 16 Aug
 2023 04:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230814112615.42448-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MfhoeMfC7gAcKioKpkCA1jykyqGSH4vg7Hpu9bb=yeGaA@mail.gmail.com> <CAHp75VdLuj1UZB+UqfvkrBUreT6NdFY5xrXASncinj-_XVqEbA@mail.gmail.com>
In-Reply-To: <CAHp75VdLuj1UZB+UqfvkrBUreT6NdFY5xrXASncinj-_XVqEbA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 16 Aug 2023 13:36:45 +0200
Message-ID: <CAMRc=MfYHxQ8Ku60QGTcW-ew-18bwWMcgYR7XPhZuze-+6jqMg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: sysfs: Do unexport GPIO when user asks
 for it
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
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

On Mon, Aug 14, 2023 at 6:29=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Aug 14, 2023 at 7:13=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > On Mon, Aug 14, 2023 at 1:19=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > It seems that sysfs interface implicitly relied on the gpiod_free()
> > > to unexport the line. This is not good and prone to regressions.
> > > Fix it by explicitly calling gpiod_unexport().
> > >
> >
> > I wouldn't say it's prone to regressions, it's literally just that
> > gpiod_free() should not deal with sysfs.
> >
> > How about that for commit message (I can change it when applying):
> >
> > It seems that sysfs interface implicitly relied on the gpiod_free()
> > to unexport the line. This is logically incorrect as core gpiolib shoul=
d
> > not deal with sysfs so instead of restoring it, let's call gpiod_unexpo=
rt()
> > from sysfs code.
>
> I'm fine with it, go ahead and apply with the change. Thank you!
>
> --
> With Best Regards,
> Andy Shevchenko

Queued for fixes.

Bart
