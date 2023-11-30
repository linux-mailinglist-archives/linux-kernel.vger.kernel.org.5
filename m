Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7857FF8B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346627AbjK3Rq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjK3Rq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:46:26 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC9910F4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:46:33 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-4644cef778aso404878137.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701366392; x=1701971192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhlHn25QeHPYSjMHyn9yKbAJlm6toOyf7s9qJJhl0TU=;
        b=mFN//AFQpl7Ftr1iiWpcxvjubqFtRcaht1EvMAVPqLuZ0p/+7P7QmwuZzL1nYchx5p
         3iPZj5BYkLo72PE+YW+36PimC64m9G4QuhKKllb58iUQxTp+3gtoXE19aUwAmoXBds9P
         8xpWkuRFdPn6pop+QvPTfa7l0TQfubeZviB3nEpHBqx3CDdLrgYZrQc/1FOUhrqH24gc
         IljWU5Fvd6TNj+jefKqwRdk00WkfvmCLKFsE1dX5rw1l+pb9Ft5Cui/zOv3lofOgS5Iw
         dsbYNOL1y2/hNk2Y6xIIpz4+nbFovuuHXHvjhwyuV9HQ3iO3OQXju6bPJslEKOoxa0Ud
         noDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701366392; x=1701971192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhlHn25QeHPYSjMHyn9yKbAJlm6toOyf7s9qJJhl0TU=;
        b=lM2kC2BdEFXYedgDh0r7heUBj/gMVCrTt2nniJMiQ2XAgYW1OTCtTgUmOTncronlk2
         6lb0OTt8LNNRXHRYu6Hqv63O7ELcTqIdzpk757oigydS4DNGaBHXc1P4Olsuki8Lu2gm
         aoll/OZgoS5f9DGyuYlrcqK1pnTv44ZoaTXtnMemgfsCWQlrXKgzJicTSuokPiF80qAQ
         kjaRrm47W8NCt/pETaKUh+9pJBYbqE5sA7gTYnfiq00WTkjXiaEbnhzYEMGhDxIUHW0M
         fWK9xiWHVzwql8Ya1UAVnHv90nZzQGn5djxfQ096VOvmCVr4RphEV5z83u9cpyQmt22V
         eidg==
X-Gm-Message-State: AOJu0Ywra46GEA0qkSEofpxedCjGQFIegZsqYekqsTcUfapL5kM2rBym
        Va9rZkTHoZIKXYTiozDQ8tNmOOBjkbiPerUY0/Ow2g==
X-Google-Smtp-Source: AGHT+IGZP8hjbo4MKcnG+l1MjuGzVxe7X8C2UCXD0GfRN+1nVFxVu8VDRCBLE2m3vSP/3CtSfMNJxiwCPiL84Zfh1oI=
X-Received: by 2002:a67:e3d9:0:b0:464:5b30:1f78 with SMTP id
 k25-20020a67e3d9000000b004645b301f78mr2303709vsm.26.1701366391796; Thu, 30
 Nov 2023 09:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20231130134630.18198-1-brgl@bgdev.pl> <20231130134630.18198-11-brgl@bgdev.pl>
 <ZWi8X7pQpUm-nIpN@smile.fi.intel.com>
In-Reply-To: <ZWi8X7pQpUm-nIpN@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 30 Nov 2023 18:46:20 +0100
Message-ID: <CAMRc=McpYK9vLA65zdoteUa72_cpwzmv3X_pZt5purocDYBJnw@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] gpiolib: remove gpiochip_is_requested()
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

On Thu, Nov 30, 2023 at 5:46=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 30, 2023 at 02:46:30PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We have no external users of gpiochip_is_requested(). Let's remove it
> > and replace its internal calls with direct testing of the REQUESTED fla=
g.
>
> ...
>
> > -     cpy =3D kstrdup(label, GFP_KERNEL);
> > -     if (!cpy)
> > -             return ERR_PTR(-ENOMEM);
> > +     scoped_guard(spinlock_irqsave, &gpio_lock) {
> > +             if (!test_bit(FLAG_REQUESTED, &desc->flags))
> > +                     return NULL;
>
> > +             cpy =3D kstrdup(desc->label, GFP_KERNEL);
> > +             if (!cpy)
> > +                     return ERR_PTR(-ENOMEM);
>
> You just introduced these lines earlier in the series, and here you moved
> them again. With guard() instead it may be kept in a better shape.
>

I wanted to limit the critical section to a minimum hence scoped
variant. And this will go away as soon as we have a desc lock so it's
temporary anyway. What matters to me is how the code looks when
sending it to Torvalds. On the off chance that we don't get the
locking rework merged in time for v6.8, I want this to at least be
under the existing lock.

Bart

> > +     }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
