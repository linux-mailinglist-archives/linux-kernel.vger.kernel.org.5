Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE07A1AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjIOJou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjIOJoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:44:39 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C902105
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:44:16 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4935f2d6815so1262857e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694771056; x=1695375856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tF5LWb4LmDR/0uHlwp2XVb+QliWqjJkKv0xE9oTF8bs=;
        b=nf1+hd76BAnirPdvhSPipVmjWaXYu762fauSyG7PRWTMhK3FSSu1Us+VDtXiN76TS2
         qo0veKMVjXPay8F1Tb5FSyMDW5P22qfXoXDEbh2+acQuUDai3OfKc3HK5zScCiseJKXP
         PCQNfoz8xoLw+bwZ8Mj3pWDyezkE6OhMuaDAdEJwvUzOu14Bo+KsIT5rk96RFNyljP5I
         MG+d+4bCLJjEqjlZiWV9OC7kGGTxyjbSZ5ZXNq38KhlMxqcTmeJHc2XWT2+p86sLuKqZ
         J9bhMk3PsIwpo5CBNNBQA9PEXM0FSZERHqThZqI8z1X98Q4LsBQ8lhEwdbKCpoqZOoK3
         JXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771056; x=1695375856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tF5LWb4LmDR/0uHlwp2XVb+QliWqjJkKv0xE9oTF8bs=;
        b=PaigPBqXI1Ch4gu6TVBnPO8icm9DNmgoFiChA+P0qSNCVy+NGaZmpzCDjqMjWdYkf2
         HOsZcK/4QlXY4Ck3lxSCakfshfjAgc3XBBTfGys1ahG74Z7kfbamQ5Kb9NYeLpnNF/X8
         wiWu5jqEtnydCKZNVxIITSi8pNZ80OeIK8jVLK0zEPXxAhBhI033Xy4AA98A7rIC1BU6
         Zj+RQaObQFOM+nmeX8uTiC4toXch3C0XFs1UyIWWXcCrnqX/kBkzECNNEsDiCfP4YXWD
         7sf+tyy0JHRaCWadgWclaOlp2PhxRHpuFPrLMcO7q8uwJmGZxcDTcoGLJ5CywzIJ/24y
         /spA==
X-Gm-Message-State: AOJu0Ywc7zTVV3OCMcDyiAObpfNg+p8Na9bIzqqlPJie+FOxPfJ6EsYK
        8dp3jNg/kcaG68IWXRUqc4BkxhCOA62ZZsI7D32KyQ==
X-Google-Smtp-Source: AGHT+IGJLWXutY6U2zEqL7q1V2LuAyFrHrx4++Z9ZzxAb/VawSPdr29noZ4EdZGKdsIgtmwssVzaZ0MYfRBhaHxEU4s=
X-Received: by 2002:a1f:ca07:0:b0:490:248d:84f4 with SMTP id
 a7-20020a1fca07000000b00490248d84f4mr475224vkg.6.1694771056020; Fri, 15 Sep
 2023 02:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230912100727.23197-1-brgl@bgdev.pl> <20230912100727.23197-8-brgl@bgdev.pl>
 <ZQBIi3OsUUe+JcoB@smile.fi.intel.com> <CAMRc=MfS1J38ij4QjTz2SRxXrmxqqz0mQow_HUuC_0WcHZA8Cg@mail.gmail.com>
In-Reply-To: <CAMRc=MfS1J38ij4QjTz2SRxXrmxqqz0mQow_HUuC_0WcHZA8Cg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 15 Sep 2023 11:44:05 +0200
Message-ID: <CAMRc=MeVfXKfz=vcgDxToYpTsrSrmD5xh5J6OeEApY4d=qyyTw@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] gpiolib: replace find_chip_by_name() with gpio_device_find_by_label()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
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

On Tue, Sep 12, 2023 at 1:35=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Tue, Sep 12, 2023 at 1:16=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Sep 12, 2023 at 12:07:23PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Remove all remaining uses of find_chip_by_name() (and subsequently:
> > > gpiochip_find()) from gpiolib.c and use the new
> > > gpio_device_find_by_label() instead.
> >
> > ...
> >
> > >       for (p =3D &table->table[0]; p->key; p++) {
> > > -             struct gpio_chip *gc;
> > > +             struct gpio_device *gdev __free(gpio_device_put) =3D NU=
LL;
> >
> > > +             gc =3D gpio_device_get_chip(gdev);
> >
> > What the heck is this, btw? You have gdev NULL here.
> >
>
> Gah! Thanks. I relied on tests succeeding and no KASAN warnings, I
> need to go through this line-by-line again.
>

Fortunately, this was just an unused leftover. I fixed it for v3.

Bart

> Bart
>
> > >               /* idx must always match exactly */
> > >               if (p->idx !=3D idx)
> > > @@ -4004,9 +3996,8 @@ static struct gpio_desc *gpiod_find(struct devi=
ce *dev, const char *con_id,
> > >                       return ERR_PTR(-EPROBE_DEFER);
> > >               }
> > >
> > > -             gc =3D find_chip_by_name(p->key);
> > > -
> > > -             if (!gc) {
> > > +             gdev =3D gpio_device_find_by_label(p->key);
> > > +             if (!gdev) {
> >
> > ...
> >
> > >               if (gc->ngpio <=3D p->chip_hwnum) {
> > >                       dev_err(dev,
> > >                               "requested GPIO %u (%u) is out of range=
 [0..%u] for chip %s\n",
> > > -                             idx, p->chip_hwnum, gc->ngpio - 1,
> > > +                             idx, p->chip_hwnum, gdev->chip->ngpio -=
 1,
> >
> > In other patch you use wrapper to get gdev->chip, why not here?
> >
> > >                               gc->label);
> >
> > Is this gc is different to gdev->chip?
> >
> > >                       return ERR_PTR(-EINVAL);
> > >               }
> >
> > ...
> >
> > Sorry, but this patch seems to me as WIP. Please, revisit it, make sure=
 all
> > things are done consistently.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
