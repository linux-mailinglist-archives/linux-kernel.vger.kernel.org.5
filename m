Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B33D7AFB98
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjI0HB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjI0HB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:01:26 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FDFDD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:01:25 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-44ee3a547adso4461012137.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695798084; x=1696402884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bu46Nnc5KiWOqP0iBU5OgSADQzvEFoHS7NZgYb78GE=;
        b=iYetDO6FIHX9BY/YomwCZYRI7v2zaWfonRVnvLhBb9EV7D1AqCRxzjj2fia43L1rvT
         aDpczhw1jRbkVIdpIsrJVdoCKyavSxACt0NcwmYt+Yi0wXE9+z0+7eUBh+MlVzFdQOuE
         0dffzueDkywu/UQjDmWRAFKInKzrF3yLUt0YMPAqK2OtWultcfGePnf1l3ZQIQ/DUUou
         ZDSqvxBISRraYaEBc/BUTHYJ+gQeXFULRjrEbNcj2C9fQvdIPju+22GJwdTrJ2o/OxOJ
         KRnm7RVWQ9PlxNBwVNEI9uc6X2jf0ni3n1LttSsI2NG8lOcu/PFHimMxYB7Ua6WOnNd1
         amRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695798084; x=1696402884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bu46Nnc5KiWOqP0iBU5OgSADQzvEFoHS7NZgYb78GE=;
        b=YCEVL64kf6sTI4JqTlsIFjBi0BexJgkGdcs2/n1d6gjGjrLf8tkhJErsqtowwEeKXM
         d3WX2yn+GUmtKq86OzdxbsVdrwV+3ojzf/EZkLnzdQ1zcjx+wMDWaYjVQ11pLJbK8eGo
         MLhZJepJ8sZ+8kjqUT3WsOfvIhRGJ7MRVY2Us3jIfEjHxxwAdKZOAdRQ5za4fM2Lch26
         YPHh1XSDchYPv9UMTlgg8axdvIjAe8XJzvCTZYAri9YUaTh6QETZpti2JMnZyDDSLhzs
         Qf8J+YFFIgRSPS9aeufRUxPTPVcSvE7RwZj7HUtjpWn6+CGez5+udfU14IxdyPDwSJgC
         6Xdg==
X-Gm-Message-State: AOJu0Yy+fFJi0fxbp++rJcq8I5LbYyqBzM9Kr4IjTChLAADXE8Gk4VAw
        zauDrzBhqekxN+XUBY24jSjelHZj+B1+1Co3Z3xYkw==
X-Google-Smtp-Source: AGHT+IEsrVpVYrIqwlm3PLb8sGk3S8YZ/Uy/pN5ne1loIRWFmPa2c94oyGEq8VELO8JqjndDjY174GednvN4dOW+kUQ=
X-Received: by 2002:a05:6102:119:b0:44d:4b8d:31e5 with SMTP id
 z25-20020a056102011900b0044d4b8d31e5mr925106vsq.35.1695798084516; Wed, 27 Sep
 2023 00:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230920085639.152441-1-brgl@bgdev.pl> <CACRpkdYtbGqmMqN7FNhjYJGG+e0jWQmozf9kpNHiUBJvd2c=7Q@mail.gmail.com>
 <CAMRc=McrXEQbwcsK3yrfROujezjMd1L4EcJj7GNTCE5L6zD1gw@mail.gmail.com>
 <CACRpkdYNA1rkG5wJ0+rAT9g4EyzfbN5VP2a9vuMMk_RD6bMLFA@mail.gmail.com>
 <CAMRc=MeaAG5w_JzgSNs-EC5HY=2izC4W1FHZ54trEW_PvA8Yfg@mail.gmail.com> <CAMRc=McuKNg5r7m6OPtwYc3er7i6JB2JN=H6QVJU_G9BVtnuAA@mail.gmail.com>
In-Reply-To: <CAMRc=McuKNg5r7m6OPtwYc3er7i6JB2JN=H6QVJU_G9BVtnuAA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 27 Sep 2023 09:01:13 +0200
Message-ID: <CAMRc=Md6=UNVt-HygYoaqwXXDdjrqsPvbyOrQcThjHOWAzLQ9w@mail.gmail.com>
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

On Mon, Sep 25, 2023 at 4:24=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Wed, Sep 20, 2023 at 2:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > On Wed, 20 Sep 2023 12:58:58 +0200, Linus Walleij <linus.walleij@linaro=
.org> said:
> > > On Wed, Sep 20, 2023 at 11:33=E2=80=AFAM Bartosz Golaszewski <brgl@bg=
dev.pl> wrote:
> > >> On Wed, 20 Sep 2023 11:12:58 +0200, Linus Walleij
> > >> <linus.walleij@linaro.org> said:
> > >> > On Wed, Sep 20, 2023 at 10:56=E2=80=AFAM Bartosz Golaszewski <brgl=
@bgdev.pl> wrote:
> > >
> > >> > Can we rename this function gpiod_find_lookup_table_locked()
> > >> > as per precedents in the kernel, to indicate that it needs to be
> > >> > called with a lock held?
> > >> >
> > >>
> > >> I think you mean gpiod_find_lookup_table_unlocked() as with this cha=
nge it
> > >> will no longer take the lock?
> > >
> > > I think the pattern is the one I indicated: *_locked() means the func=
tion
> > > is to be called with the appropriate lock held, cf
> > > arch/arm64/kvm/hyp/nvhe/mm.c
> > >
> > > pkvm_create_mappings() takes a lock and then calls
> > > pkvm_create_mappings_locked() which even asserts that
> > > the lock is held.
> > >
> >
> > Ha! I always though the pattern is to call the functions that *DON'T* t=
ake
> > the lock _unlocked(). This is what I used in gpiolib-cdev.c or gpio-sim=
.c.
> >
> > I guess both conventions make sense in some way.
> >
> > Bart
>
> I don't think I will be doing it just now. We don't use this
> convention elsewhere in drivers/gpio/ and we'll have a lot of locking
> reworked soon anyway. We may get to it when that is done.
>
> Bart

If there are no objections, I'd like to queue it this week.

Bart
