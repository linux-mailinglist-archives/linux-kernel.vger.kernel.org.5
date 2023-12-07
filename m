Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3103808737
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjLGMAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjLGMAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:00:13 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200D110CA;
        Thu,  7 Dec 2023 04:00:18 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77d6f853ba0so42029685a.0;
        Thu, 07 Dec 2023 04:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701950417; x=1702555217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N1+cn+fBSeHCGuo21Zugsp7Q1cczJw+MFPsoqSobZY=;
        b=kcR7eQ5T/lKtqsRWoAx/y1o4g/R6A+tkpk4MAYJ/Zp9/xCM0QhAii1wCDYkbe4BIXr
         YEGbKLVncH4ocj6toT8d0rctejB7d85IAQLCAy/v5Qoup/OpKK+RnxeBCn2oRkVgqFTg
         SLtbWXvQ8OqXx3tXiBnP6cM1ZFBF0qhqrxP1qqtNrtd1U6r4mNhNclU11qcB+qBO+yIA
         uYZCpoSamoPf8cZ4Ig7Iw1ted+bPVsOH8L9A5ACzga2DHZKA+oRazG4lynENcfzHotJc
         Z9FSfI0FNUZJU6fJLHghZ+x9O+yfMS7QJcCQwS8HJrLx/kDODIfL0GpIZfv+omQI8tqb
         pqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701950417; x=1702555217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8N1+cn+fBSeHCGuo21Zugsp7Q1cczJw+MFPsoqSobZY=;
        b=akQ9wUylxJGOwOBIRjB10nQb7Trc889IUsigmbH8quyjotMxrsf/xNw/3KHX9jmFhm
         X3MVsi+BaPd70t2MTT9sqjgmwBzGIrH231tCHKc0FRC16UTwv26NRrEJk1XdQmNtI1IM
         I7EkemHGGaY4Etkh9sDfI87FYZqv9VnqWAfVC0ok5u+6CYenvSxkZzBuhUEun4NGzDte
         +v7SgLLtCNXwUWFch4pVmTZsx9fGMgx1+PGMYCIVqMn/ZOIqdxOEfAdWfscmHeNTt+jZ
         dQbKuRVamMT4AQQ2sJn2slonplXKqpbxIkMLObmTOcgl35YUUqgCeam0Bxbh0gHqPbrv
         sqdg==
X-Gm-Message-State: AOJu0Yxin22VmXHgmCcBGzqjMugydx/jE4r1jGFNaoxso8Yo3B3amuCl
        tG89Wsppy4uarSLVuDjd2r5NieYm4iTCWhG28nI=
X-Google-Smtp-Source: AGHT+IH34Xzv5KtY/D+BMVlkWYo9rwuiVxKqxlh5Ap5AifKPY0cMFdnuMB2UOvEGr+7lT/XiUh+en9FVxjhpx4Akg3E=
X-Received: by 2002:a05:620a:2486:b0:77f:34bf:5593 with SMTP id
 i6-20020a05620a248600b0077f34bf5593mr1943614qkn.17.1701950417106; Thu, 07 Dec
 2023 04:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20231204180603.470421-1-gnstark@salutedevices.com>
 <20231204180603.470421-2-gnstark@salutedevices.com> <81798fe5-f89e-482f-b0d0-674ccbfc3666@redhat.com>
 <29584eb6-fa10-4ce0-9fa3-0c409a582445@salutedevices.com> <17a9fede-30e8-4cd5-ae02-fe34e11f5c20@csgroup.eu>
 <be693688-2e82-4e1a-9ead-cf1513ee637b@csgroup.eu> <2a68534b-9e64-4d6e-8a49-eeab0889841b@salutedevices.com>
In-Reply-To: <2a68534b-9e64-4d6e-8a49-eeab0889841b@salutedevices.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Dec 2023 13:59:40 +0200
Message-ID: <CAHp75VdMzZZg3w_jr-SF2APeyq1wVNHK=r=Amf0+JUOq1hy0Fw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] devm-helpers: introduce devm_mutex_init
To:     George Stark <gnstark@salutedevices.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Hans de Goede <hdegoede@redhat.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
        "vadimp@nvidia.com" <vadimp@nvidia.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, mingo@redhat.com,
        will@kernel.org, boqun.feng@gmail.com,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kernel@salutedevices.com" <kernel@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 1:23=E2=80=AFAM George Stark <gnstark@salutedevices.=
com> wrote:
> On 12/7/23 01:37, Christophe Leroy wrote:
> > Le 06/12/2023 =C3=A0 23:14, Christophe Leroy a =C3=A9crit :
> >> Le 06/12/2023 =C3=A0 19:58, George Stark a =C3=A9crit :
> >>> On 12/6/23 18:01, Hans de Goede wrote:
> >>>> On 12/4/23 19:05, George Stark wrote:

...

> >>>> mutex_destroy() only actually does anything if CONFIG_DEBUG_MUTEXES
> >>>> is set, otherwise it is an empty inline-stub.
> >>>>
> >>>> Adding a devres resource to the device just to call an empty inline
> >>>> stub which is a no-op seems like a waste of resources. IMHO it
> >>>> would be better to change this to:
> >>>>
> >>>> static inline int devm_mutex_init(struct device *dev, struct mutex
> >>>> *lock)
> >>>> {
> >>>>        mutex_init(lock);
> >>>> #ifdef CONFIG_DEBUG_MUTEXES
> >>>>        return devm_add_action_or_reset(dev, devm_mutex_release, lock=
);
> >>>> #else
> >>>>        return 0;
> >>>> #endif
> >>>> }
> >>>>
> >>>> To avoid the unnecessary devres allocation when
> >>>> CONFIG_DEBUG_MUTEXES is not set.
> >>>
> >>> Honestly saying I don't like unnecessary devres allocation either but
> >>> the proposed approach has its own price:
> >>>
> >>> 1) we'll have more than one place with branching if mutex_destroy is
> >>> empty or not using  indirect condition. If suddenly mutex_destroy is
> >>> extended for non-debug code (in upstream branch or e.g. by someone fo=
r
> >>> local debug) than there'll be a problem.
> >>>
> >>> 2) If mutex_destroy is empty or not depends on CONFIG_PREEMPT_RT opti=
on
> >>> too. When CONFIG_PREEMPT_RT is on mutex_destroy is always empty.
> >>>
> >>> As I see it only the mutex interface (mutex.h) has to say definitely =
if
> >>> mutex_destroy must be called. Probably we could add some define to
> >>> include/linux/mutex.h,like IS_MUTEX_DESTROY_REQUIRED and declare it n=
ear
> >>> mutex_destroy definition itself.
> >>>
> >>> I tried to put devm_mutex_init itself in mutex.h and it could've help=
ed
> >>> too but it's not the place for devm API.
> >>>
> >>
> >> What do you mean by "it's not the place for devm API" ?
> >>
> >> If you do a 'grep devm_ include/linux/' you'll find devm_ functions in
> >> almost 100 .h files. Why wouldn't mutex.h be the place for
> >> devm_mutex_init() ?
> mutex.h's maintainers believe so.
>
> https://lore.kernel.org/lkml/070c174c-057a-46de-ae8e-836e9e20eceb@saluted=
evices.com/T/#mb42e1d7760816b0cedd3130e08f29690496b5ac2
> >
> > Looking at it closer, I have the feeling that you want to do similar to
> > devm_gpio_request() in linux/gpio.h :
> >
> > In linux/mutex.h, add a prototype for devm_mutex_init() when
> > CONFIG_DEBUG_MUTEXES is defined and an empty static inline otherwise.
> > Then define devm_mutex_init() in kernel/locking/mutex-debug.c
>
> Yes, this would be almost perfect decision. BTW just as in linux/gpio.h
> we wouldn't have to include whole "linux/device.h" into mutex.h, only
> add forward declaration of struct device;
>
> > Wouldn't that work ?

No. It will require inclusion of device.h (which is a twisted hell
from the header perspective) into mutex.h. Completely unappreciated
move.

--=20
With Best Regards,
Andy Shevchenko
