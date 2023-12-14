Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40108132D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573431AbjLNOS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjLNOSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:18:54 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3113118
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:19:00 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7c5bfd8858cso2408741241.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702563540; x=1703168340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xK1Zz0ik7xN5iCx8Rt0y08scTAc5eJ32ICjBtV1g5R0=;
        b=kYYZoevhROyiajdFeiO6llNmswfxd1iVdGn/Tf5GNyNGkBUxtJ9ipHU2WyVB9eymgY
         CfaeT0Gf/A4UU+fsq2F8iJsr1iGR7t8K/sw8ehYFwCMPJXVEXOLJTElaYPpgpk0fQPG4
         t1zaMtBtxcdPpss0b8mvSUK+LaXyP4BddU05txoQew26l7OKlu6KSJGLNnlfc2NvmKjM
         lAtKfJpEjgsdRkue26KyhcPjHAjVWolCpGxNzKwxmZTdZFBrhx8NyOrK0eWkODM4hN58
         pEHhYhP6O5Dx7feNPOhtjs8pXjwZhe8Hhr//EykN1A3jYRX1kHE/6qj3ZKhLcmDXrAFV
         Cb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563540; x=1703168340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xK1Zz0ik7xN5iCx8Rt0y08scTAc5eJ32ICjBtV1g5R0=;
        b=QuWEPmJwe6Awoxl+IiMN39ICPKmuiw/+IK348M9oodk5c/hm1p1ruRNlVT1UgZfFem
         71JzXAzok7xodpqudlsvs9ykmBPbNoAbCJYtScRqpdpsT+2z87LWVv31VLKaCC4I1CZG
         wp2nWiLhsjd3ayvNuDPcOhi7lr7Yi1eXGSxH7WbEhYH/WSJStbXpgBenXZon5/tl9Vus
         bfjKSyjBENf86v09MlYkrdtizpLd7td+TAKez6LaQLzXutHJtNqq3i9HY263eFpsbQyg
         LbzP91/Lo82HXCAys8zL08EzHJSWVQ2HFsWV8BEcpNtyxRfQJ2zV7VEkGHG7fCAULmZK
         WPLg==
X-Gm-Message-State: AOJu0YwucTW2n6OXz7rJdJSHq5dEAZn9cGPA3pMPMKk55HQifCczubXJ
        8UZBtIkOKK6lE67gdXWkNvIQ0sxmC7NoMS6R8Z/mdQ==
X-Google-Smtp-Source: AGHT+IGp7N0kDKKmg44BR/UTVhPYQAXaP/J0i9EfoiSn3v8/kmsSPtwUVxlkF51Mb6DLMeWbbOQ2HLX16hUnLvPRqkk=
X-Received: by 2002:a05:6122:2986:b0:4b2:c554:d2bf with SMTP id
 fn6-20020a056122298600b004b2c554d2bfmr6676722vkb.33.1702563540050; Thu, 14
 Dec 2023 06:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20231208102020.36390-1-brgl@bgdev.pl> <20231208102020.36390-3-brgl@bgdev.pl>
 <ZXMiq3wDOt9zFzuX@smile.fi.intel.com> <CAMRc=Me5fzUaxQZ8Ec086papUpOD+chZ3+BM4CzASmB=ksh9kw@mail.gmail.com>
 <ZXsLhDGeNofXp4IC@smile.fi.intel.com>
In-Reply-To: <ZXsLhDGeNofXp4IC@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 14 Dec 2023 15:18:48 +0100
Message-ID: <CAMRc=Me5mj19jH7QxkL4LPfwUkr0F9t5UQpPjz5GDjRbC5XDsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpiolib: use a mutex to protect the list of GPIO devices
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 3:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Dec 14, 2023 at 02:59:28PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Dec 14, 2023 at 2:53=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Fri, Dec 08, 2023 at 11:20:20AM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > The global list of GPIO devices is never modified or accessed from
> > > > atomic context so it's fine to protect it using a mutex. Add a new
> > > > global lock dedicated to the gpio_devices list and use it whenever
> > > > accessing or modifying it.
>
> ...
>
> > > > While at it: fold the sysfs registering of existing devices into
> > > > gpiolib.c and make gpio_devices static within its compilation unit.
> > >
> > > TBH I do not like injecting sysfs (legacy!) code into gpiolib.
> > > It makes things at very least confusing.
> > >
> > > That _ugly_ ifdeffery and sysfs in the function name are not okay.
> > >
> > > If you want do that, please create a separate change and explain the =
rationale
> > > behind with answering to the Q "Why do we need all that and why is it=
 better
> > > than any alternatives?".
> >
> > I can move it back to gpiolib-sysfs.c but this way we'll have to keep
> > the GPIO device mutex public in gpiolib.h.
>
> And I'm fine with that. Again, we can discuss this in a separate change t=
hat
> will do that (make that mutex local with the explanation why).
>

No, I won't be sending one. I'll send another iteration of this with
sysfs stuff contained to gpiolib-sysfs.c.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
