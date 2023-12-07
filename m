Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084B9808860
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379476AbjLGMqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjLGMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:46:23 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1AA10DA;
        Thu,  7 Dec 2023 04:46:29 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db547d3631fso1052690276.1;
        Thu, 07 Dec 2023 04:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701953189; x=1702557989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHfqqy7VSfkSG99E4cdZjp3eHb2ShoLvFftEF8wWjOQ=;
        b=WFtHqGGMvS/oZ3PlURTFdhwBGyTexUB80CkWy8RhJ2ZEmAjhm53f61RXaxV5wBiPoi
         k+CzyuZbJIXZ8WdfP6PgENHraJT12NMJcBc9HMXe3thfg2uBeSANqCGpCJ7mFdDVLehT
         VN2kR96RMREE9ZGwMMvr9KIA/CBElKaW6Fmb/iauPxptQEWrS97c8CYYWWa62VUHqAq/
         vLkAuYrNSS0zokite/BYdKOeslJuf03Dea2CtqwiWTt4SZCEapAh/16Y/nOfcE+Enops
         2Nr4mbSPbc2wQdrmwL4iac747aUsNU0b4BZQpYrhaxydQz1WGM7YiYGstIgeNI3mQLSG
         SjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701953189; x=1702557989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHfqqy7VSfkSG99E4cdZjp3eHb2ShoLvFftEF8wWjOQ=;
        b=wGe8FK3AA48ajjKkA6pwcQJBAsPlN64HAWpOHWMItoi1fCi4vNNKBoPBUC4tBzuYae
         SM4Iiift9mURvLlrB3YLFE0O+ZII3mOw+I2zHhpRQPUUjFf2sFVWrng4l/58YAthOrE+
         a2NxbaBxDNlXQiJjvnZ+gOrcfgo/F9EFfgu+lgJHqhKyd9gJHo9jZ+6k7EgvpVgo4fZd
         WViYSmP7cYsiAt/g4RSemucd43OEa9qAxqXNFUTUr7MPY4RjUzR1wXGPFm+0AZSuRoIV
         jtYkQJGghNkb9vSWY9PFWWWMlRD1AkADzuayHtW/qFNFgi+ObL9Kdg+X9WCu0xKgdmsp
         acoQ==
X-Gm-Message-State: AOJu0YyHSIHW0dnZ/vbiZmjHdfl8ZtasKdnaIRZ0FQfbY6yTEnXefj3W
        QyKLV1QICNxg0YhLgybw5ASq9EBIxnpDLjxLVqQ=
X-Google-Smtp-Source: AGHT+IFwsBRm2Rebv+SFsvxcHiAxag8PhUK1dcHIdFKH5KX2JpHW3VXWMpLshEKz01dWJ6+Za1oDmJQd0KMGyh6EKoc=
X-Received: by 2002:a25:aa6a:0:b0:db7:dad0:60c1 with SMTP id
 s97-20020a25aa6a000000b00db7dad060c1mr2364100ybi.78.1701953188938; Thu, 07
 Dec 2023 04:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20231204180603.470421-1-gnstark@salutedevices.com>
 <20231204180603.470421-2-gnstark@salutedevices.com> <81798fe5-f89e-482f-b0d0-674ccbfc3666@redhat.com>
 <29584eb6-fa10-4ce0-9fa3-0c409a582445@salutedevices.com> <17a9fede-30e8-4cd5-ae02-fe34e11f5c20@csgroup.eu>
 <be693688-2e82-4e1a-9ead-cf1513ee637b@csgroup.eu> <2a68534b-9e64-4d6e-8a49-eeab0889841b@salutedevices.com>
 <CAHp75VdMzZZg3w_jr-SF2APeyq1wVNHK=r=Amf0+JUOq1hy0Fw@mail.gmail.com> <3275dec3-fd19-4aa1-8eba-441fd64cc185@csgroup.eu>
In-Reply-To: <3275dec3-fd19-4aa1-8eba-441fd64cc185@csgroup.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Dec 2023 14:45:52 +0200
Message-ID: <CAHp75VfmF0sMrQTrq8G+R9e7icjEZR9jM9L9GEQHqTutS+E-Uw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] devm-helpers: introduce devm_mutex_init
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     George Stark <gnstark@salutedevices.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
        "vadimp@nvidia.com" <vadimp@nvidia.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
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

On Thu, Dec 7, 2023 at 2:31=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 07/12/2023 =C3=A0 12:59, Andy Shevchenko a =C3=A9crit :
> > On Thu, Dec 7, 2023 at 1:23=E2=80=AFAM George Stark <gnstark@salutedevi=
ces.com> wrote:
> >> On 12/7/23 01:37, Christophe Leroy wrote:
> >>> Le 06/12/2023 =C3=A0 23:14, Christophe Leroy a =C3=A9crit :
> >>>> Le 06/12/2023 =C3=A0 19:58, George Stark a =C3=A9crit :
> >>>>> On 12/6/23 18:01, Hans de Goede wrote:
> >>>>>> On 12/4/23 19:05, George Stark wrote:

...

> >>>>>> mutex_destroy() only actually does anything if CONFIG_DEBUG_MUTEXE=
S
> >>>>>> is set, otherwise it is an empty inline-stub.
> >>>>>>
> >>>>>> Adding a devres resource to the device just to call an empty inlin=
e
> >>>>>> stub which is a no-op seems like a waste of resources. IMHO it
> >>>>>> would be better to change this to:
> >>>>>>
> >>>>>> static inline int devm_mutex_init(struct device *dev, struct mutex
> >>>>>> *lock)
> >>>>>> {
> >>>>>>         mutex_init(lock);
> >>>>>> #ifdef CONFIG_DEBUG_MUTEXES
> >>>>>>         return devm_add_action_or_reset(dev, devm_mutex_release, l=
ock);

^^^^ (1)

> >>>>>> #else
> >>>>>>         return 0;
> >>>>>> #endif
> >>>>>> }
> >>>>>>
> >>>>>> To avoid the unnecessary devres allocation when
> >>>>>> CONFIG_DEBUG_MUTEXES is not set.
> >>>>>
> >>>>> Honestly saying I don't like unnecessary devres allocation either b=
ut
> >>>>> the proposed approach has its own price:
> >>>>>
> >>>>> 1) we'll have more than one place with branching if mutex_destroy i=
s
> >>>>> empty or not using  indirect condition. If suddenly mutex_destroy i=
s
> >>>>> extended for non-debug code (in upstream branch or e.g. by someone =
for
> >>>>> local debug) than there'll be a problem.
> >>>>>
> >>>>> 2) If mutex_destroy is empty or not depends on CONFIG_PREEMPT_RT op=
tion
> >>>>> too. When CONFIG_PREEMPT_RT is on mutex_destroy is always empty.
> >>>>>
> >>>>> As I see it only the mutex interface (mutex.h) has to say definitel=
y if
> >>>>> mutex_destroy must be called. Probably we could add some define to
> >>>>> include/linux/mutex.h,like IS_MUTEX_DESTROY_REQUIRED and declare it=
 near
> >>>>> mutex_destroy definition itself.
> >>>>>
> >>>>> I tried to put devm_mutex_init itself in mutex.h and it could've he=
lped
> >>>>> too but it's not the place for devm API.
> >>>>>
> >>>>
> >>>> What do you mean by "it's not the place for devm API" ?
> >>>>
> >>>> If you do a 'grep devm_ include/linux/' you'll find devm_ functions =
in
> >>>> almost 100 .h files. Why wouldn't mutex.h be the place for
> >>>> devm_mutex_init() ?
> >> mutex.h's maintainers believe so.
> >>
> >> https://lore.kernel.org/lkml/070c174c-057a-46de-ae8e-836e9e20eceb@salu=
tedevices.com/T/#mb42e1d7760816b0cedd3130e08f29690496b5ac2
> >>>
> >>> Looking at it closer, I have the feeling that you want to do similar =
to
> >>> devm_gpio_request() in linux/gpio.h :
> >>>
> >>> In linux/mutex.h, add a prototype for devm_mutex_init() when
> >>> CONFIG_DEBUG_MUTEXES is defined and an empty static inline otherwise.
> >>> Then define devm_mutex_init() in kernel/locking/mutex-debug.c
> >>
> >> Yes, this would be almost perfect decision. BTW just as in linux/gpio.=
h
> >> we wouldn't have to include whole "linux/device.h" into mutex.h, only
> >> add forward declaration of struct device;
> >>
> >>> Wouldn't that work ?
> >
> > No. It will require inclusion of device.h (which is a twisted hell
> > from the header perspective) into mutex.h. Completely unappreciated
> > move.
>
> I see no reason for including device.h, I think a forward declaration of
> struct device would be enough, as done in linux/gpio.h
>
> Am I missing something ?

Yes, see (1) above. If you want to have it in the header, you must
provide an API, which is located in device.h. The idea about
mutex-debug.c is interesting, but the file naming and the devm_*() API
for _initing_ the mutex seems confusing.

--=20
With Best Regards,
Andy Shevchenko
