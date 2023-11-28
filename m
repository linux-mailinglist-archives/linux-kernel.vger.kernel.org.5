Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303097FC1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbjK1QkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjK1QkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:40:19 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A11D6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:40:25 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58a42c3cbb8so3316124eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701189625; x=1701794425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmTesqK+F/QJOwGcug6iguQ/D1cpFRALPok0GTAiegc=;
        b=W6iio8H0DjYnScIKoSjJxxKpR6lzuR0bWtjfKpNAnwaySc27ItVi06kcA/sYM2/O4e
         qvnL/aK19jjR2v4dMfCzAwkbtV7zB90NLFHxo9ZqHgYAE8by+ylv/Yw9Muz9nKW8X8lA
         RWK1mF5L0MvPl8qLl9z0a1W0IZBUHwa81v7Z/rfSVjLEL7FZ0nhWMNQS4OcUbXb69Vyv
         tYAWhNaEGx/tJNTGOVKNN4sgGCfme8ikmF5vSteBLnjbdhcB6sjVoeS7ZKVIsFhDXD92
         02YOWomZ76COswgRhL9dRSkmRbi3VWUOzJFvue0Y8Yt8Zvv6Ax0mhJAuklWG1nXioXGw
         Voig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701189625; x=1701794425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmTesqK+F/QJOwGcug6iguQ/D1cpFRALPok0GTAiegc=;
        b=T1g40vl8MtnZ8sCUkCd7oGtI+4kl6tf2I8FCrr6KT2inXm8wWzGRpTJsyVyp5L5ar6
         K+kMagzs8Ag88tOfEhlPRWMKr2fLPeEaHNVwl1vw4zP7R9tLzb5QxG5w3aIKkUWajhVW
         v3kZwZzKB9+ypVJxiEXziEFTB+l3xFFBgKVS7AekHhsgiCFmFHc8WOO2kmfk5jVaLRim
         6yS2pobibdie/A6N6eP6609kymLqAhdhlx74i/yK0Q8BSaydiy8zIKgLGeRIW7MgRuF9
         ans9oxf7PDLcT/QY4mRtBsMhm120LuJHH54fIlle8R75NHGCQYrFiK/ebjT2MAngrNoI
         zZlg==
X-Gm-Message-State: AOJu0YxDlXkO3k9K2QR9mME8ASl2/78TiaTs74xQEzCa/2N2DStkdLzZ
        zms+pREja44dL025B6cHaXVoDOvQGdxeUv5rxYjZvGX0lqyr0mru
X-Google-Smtp-Source: AGHT+IHXFi0CMJEmOBG0drT6Yl0cizFCRxptP85Y28ocOtyAbffCNU1ckrWUrQn8BzD9g8lJdqrDPCghi1L6+RVklQY=
X-Received: by 2002:a05:6358:9394:b0:16d:fe28:f8cc with SMTP id
 h20-20020a056358939400b0016dfe28f8ccmr17146875rwb.4.1701189624933; Tue, 28
 Nov 2023 08:40:24 -0800 (PST)
MIME-Version: 1.0
References: <20231127193716.63143-1-brgl@bgdev.pl> <20231127193716.63143-2-brgl@bgdev.pl>
 <ZWYQmpe7UxnJW0_g@smile.fi.intel.com>
In-Reply-To: <ZWYQmpe7UxnJW0_g@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 28 Nov 2023 17:40:13 +0100
Message-ID: <CAMRc=MdJQLe-f_B5OqmV0t5R8Jy72iAesAnPV0E8K-tYcBE2Ag@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: use a mutex to protect the list of GPIO devices
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

On Tue, Nov 28, 2023 at 5:09=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 27, 2023 at 08:37:16PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The global list of GPIO devices is never modified or accessed from
> > atomic context so it's fine to protect it using a mutex. Add a new
> > global lock dedicated to the gpio_devices list and use it whenever
> > accessing or modifying it.
> >
> > While at it: fold the sysfs registering of existing devices into
> > gpiolib.c and make gpio_devices static within its compilation unit.
>
> ...
>
> > +     scoped_guard(mutex, &gpio_devices_lock) {
>
> This is a lot of churn with this because of switching to RAII.
> Can the body be firstly moved to a helper?
>

But that would mean more churn. I don't get why you insist on
splitting these everytime. We're going from spinlock to a mutex so we
may as well use guards right away.

> > +             /*
> > +              * TODO: this allocates a Linux GPIO number base in the g=
lobal
> > +              * GPIO numberspace for this chip. In the long run we wan=
t to
> > +              * get *rid* of this numberspace and use only descriptors=
, but
> > +              * it may be a pipe dream. It will not happen before we g=
et rid
> > +              * of the sysfs interface anyways.
> > +              */
>
> ...
>
> >       list_for_each_entry(gdev, &gpio_devices, list)
> > +             if (index-- =3D=3D 0)
> >                       return gdev;
>
> I believe this is better with outer {}.
>

Right.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
