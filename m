Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483A37EB3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjKNPlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKNPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:41:11 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77414126
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:41:07 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-45d9b477f7bso2549724137.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976466; x=1700581266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkzCZG3bXMVbyNxn4+yNeclmA7RVlYHI+byE/zFEyOY=;
        b=GC/duJEuwd6+Q1YIk9AKaUtsD5NPxSpYhTJb/URdXbupnUaJlBVEN1yt4s3Zw6rGy0
         iKPHxDYEdT9io+U6Xs2qEOwE2xzqZMZYgvpiiUefNJ8oUoLtyT1wGdFFufHWwXYRewAi
         fKoyjdjLlXyF5UCnKTcrwxbh72oaaGZHzsmZzo+C2/u+FaRVQVMVUvX77tCn6KSv/+tS
         f3+oi1usX3ZgS/43xrl+miLbbxEybNrThnJMtixscRu3C+VDMW52DWBntjJF/HmjngtK
         5jaMrkZ/TZBlZpQ2USNDu+wzwFUPlcClK8lvo5wxQlKcWVbm4nj7HvfN2UNRIyJ0whO/
         zAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976466; x=1700581266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkzCZG3bXMVbyNxn4+yNeclmA7RVlYHI+byE/zFEyOY=;
        b=nhHz9bCiXzFnwVXytCkmo8I4xxpnAMIzo1Oiyw4WiP9j4H2dfRwunhAJn5cHw2s9qk
         xL3eDD2hjZRMxaJGkRm9Yv/sKXeSqHaIuw4ZwUGdAB/IrGXRDh8QfEL4P4t9D0xmBYvK
         QYzJeJ+BWvqnDHmWvKnfL6Az3kKz1ywlLeOQA1g974tUtkUMmpXuGnekFMvm8PDcnQdT
         255cmBtZ837HfxbQWBdO01JKGJr7JM/V+tGaVZN6PVHy1rL431YCvzz6AzlxWcQzqCZT
         b6t8aHYKtHVZeAXhNpK26Z63w1DuwWYa04NEgtIkfb5RX2hrA+7LeL1EF7jWB6X8yKlq
         WMIA==
X-Gm-Message-State: AOJu0YyWdNLI8GHVS5Km8DpToAGkvkS47S31h0uPfG3RTpHykw53Q5vL
        704klnqp29HHEgr3vcEguDQnWQyDJe2Fydm0cW4=
X-Google-Smtp-Source: AGHT+IFuFIQZ+mZpvOtn+ca8j7Tl2Ztiooh5QfpblKcX1u+E5DCeY6eg1Yy8U3e3pcin6HZ1pIKzgO91iQzbvTtZLxs=
X-Received: by 2002:a67:b70f:0:b0:45f:80ff:e111 with SMTP id
 h15-20020a67b70f000000b0045f80ffe111mr8422093vsf.22.1699976466471; Tue, 14
 Nov 2023 07:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-12-lb@semihalf.com>
 <CAJfuBxzhz7pBYkfqfPomH4PUzqLPX1nxsev4yrQ2P6m5hyMT+Q@mail.gmail.com>
 <CAK8ByeJ1fYSVaVQz3tERzj_5QNAN4Ggx850pKcAG3vhsoWnS+w@mail.gmail.com>
 <CAJfuBxyu3VqakFNr4mW0h4QiPVSf-7HSPXobGO2_qC-H8yLgcw@mail.gmail.com>
 <CAK8ByeL1WwdVKSMtGfbHZLfYm73ZwjiEbtNZJiWur-spMc74Zg@mail.gmail.com>
 <CAJfuBxz1=9o06Rj_mX-2aZXhCSF7rKxyusayPiy4RuJZ7qKbQw@mail.gmail.com>
 <CAK8ByeJH8vKUxeM21ME0vYjKmC_Z=P8XsKiB42k95iZ09bJXJg@mail.gmail.com>
 <CAJfuBxxw6DbmGG-UdiZeUr9680tJVEVcw-czPL+jt-88YUMgbw@mail.gmail.com> <CAK8ByeL4YSCBPPGSeNAPAKtR2=BEZxBjpNE3KeX8TaMmJrficQ@mail.gmail.com>
In-Reply-To: <CAK8ByeL4YSCBPPGSeNAPAKtR2=BEZxBjpNE3KeX8TaMmJrficQ@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Tue, 14 Nov 2023 08:40:32 -0700
Message-ID: <CAJfuBxwA_1kkjeqDRCDKvJ+PesUgYcVwdQeL-ePM7+ZFLfnO0w@mail.gmail.com>
Subject: Re: [PATCH v1 11/12] dyndbg: write debug logs to trace instance
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
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

On Tue, Nov 14, 2023 at 12:45=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.=
com> wrote:
>
> wt., 14 lis 2023 o 02:08 <jim.cromie@gmail.com> napisa=C5=82(a):
> >

> > > > > Also I think we need a reserved keyword for writing debug logs to
> > > > > trace events - maybe "event" keyword ?
> > > >
> > > > do you mean "event" as a selector, like module, function, class, et=
c ?
> > > > if so, what are the values ?
> > > > any event under  /sys/kernel/debug/tracing/events/ ?
> > > >
> > > > how does this get used ?
> > > >
> > >
> > > I meant that we need to reserve name/keyword to enable writing debug
> > > logs to trace events (prdbg and devdbg), for example
> > > echo module usbcore +T:event > /proc/dynamic_debug/control
> > >
> > > Or do you anticipate other way to do it ?
> >
> > way back, when I had even fewer clues,
> > I sent patches to call trace-printk when +T was set.
> > Steve didnt like it, I think cuz it could flood the tracebuf.
> >
> > Thats why I added the prdbg and devdbg event-types,
> > so that they could be disabled easily using /sys/kernel/debug/tracing/
> > putting them squarely under trace-control.
> >
> > Note that this puts 2 off-switches in series,
> > both tracefs and >control can disable all the pr_debug traffic,
> > tracefs by event-type, and >control at individual callsite level.
> >
> > echo 1 > /sys/kernel/debug/tracing/dyndbg/enable
> > echo 1 > /sys/kernel/debug/tracing/dyndbg/prdbg/enable
> > echo 1 > /sys/kernel/debug/tracing/dyndbg/devdbg/enable
> >
> > I briefly thought about linking the 2 off-switches,
> > but punted cuz I thought it complicated things,
> > (how exactly would they get coupled?)
> > and I didnt want to distract from larger goals
> >
> > Does that address your question ?
> >
>
> Jim,
>
> Thanks but it doesn't answer my question.
>
> How do you plan to enable output to tracefs event at a callsite level ?
>
> In my original proposal it was enabled by setting trace destination to
> 0. Since we are moving to names instead of numbers now I guess we need
> to reserve a name for it not to clash with trace instance names
> provided by users. That's why I proposed to reserve name "event" for
> that purpose and be used as +T:event.
>

Ok, I got your point now.

how about we call it "0" ?
it should be an obvious "magical" value,
cuz it doesnt need to be open'd, and cant be close'd

then we can revert to global tracebuf by its "name"
echo module foo +T:0 > /proc/dynamic_debug/control

we probably should also limit the trace-instance-names to ^\w+

> Or did I miss answer to that in our long discussion :> ?

nope :-)

thanks,
Jim

>
> Thanks,
> Lukasz
>
> > On a related point, I also added drm_dbg and drm_devdbg.
> > Those are issued from __drm_dbg & __drm_dev_dbg
> >  respectively when CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dn.
> >
> > Im not sure theyre more useful than confusing yet.
> >
> > >
> > > > >
> > > > >
> > > > > >
> > > > > > > >
> > > > > > > > and +T  w/o dest means use existing setting, not just 0 (un=
less thats
> > > > > > > > the existing setting)
> > > > > > > >
> > > > > > >
> > > > > > > Sounds good.
> > > > > > >
> > > > > >
> > > > > > :-)
