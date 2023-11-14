Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6730B7EB929
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 23:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjKNWJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 17:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjKNWJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 17:09:58 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE357D5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 14:09:54 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5409bc907edso9434858a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 14:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699999793; x=1700604593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOWSIOTkoYVhdJW/e1at8pVxx0R5Ml9A0hrQNNSN9AM=;
        b=Aw1sxJm+3WsFYliWtUUW9rDKzuHX1sKsf6398sC7MfuHu7OLGExxwnSBcmTCFjAyfz
         g/nNFPN7ZI5efovSs0usBUpB1ibF0vDOuHJg0qYt6CMJwaQP0CiFV8mvzU2ec4qnXgJY
         kRcEFSK9xcPNueNkqzEpKgmIMMpozgOFdk56Xpklb/qDeN/S0T3VgfG6x1QzBT2FlbNN
         DJ2pYQb1kOOrgYjkMezc5W4RcBsfjUEvfl+hnMdzcWVp5tIhBQR9HXIEMxl3CaLu8KjV
         v5HyZsjrNi760bIy3B+PJlhFjZ/MAw+SB9U8lO/PqCu5fmQINxM81x5bYrw1cQjyQCoU
         M4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699999793; x=1700604593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOWSIOTkoYVhdJW/e1at8pVxx0R5Ml9A0hrQNNSN9AM=;
        b=hqBUlUje0svodmfzo3tA/VbeyqVU5McZST4lYr7J6xA3jInzsU8hkihvRAgDPpp949
         ReMcSC7+7ESB4AREBpdtlwlzYGoBUBMpoxC6/U8jLgub6AkpYLM5/Ena+70E0EEzh483
         P2ZivINg+P3bzVkIYgbNh/qLcmeQSMwClKF3RQbkYD+yOkWdI30HZs6kFRSHGZWvF/JE
         WO4e9BgEJtaEj01VWkwPuy7FqrVEl6Sw8+/OcLgRhbLCKDDMpF0Sf8wiGJ1fkuX3FYqQ
         Bzpx/8/rq/oL4QFSNAc/LVTwuBNum5VQuXghE9wgvw7NwMXAdvcpxyDRVvaWTOEtZoss
         Zz2Q==
X-Gm-Message-State: AOJu0YwJA/8OZow5HNqhl+fQ0oOnaML0KoGHVySd5KuI5jS54qvDnu2b
        +WOikQ+yZfc72fUvg2N+epRp7XpwSb0/HnUL61y0xzvYMibcjGeedQ==
X-Google-Smtp-Source: AGHT+IGu5Da7Fx7w6dKGqncWUDwqlv8DKsTdj0C3ZFrjuuXNPVjUyVzx6uJUWeakcxaUg6x9i5+nZ8p4QGDClX9NRYc=
X-Received: by 2002:a50:fb14:0:b0:53d:eca8:8775 with SMTP id
 d20-20020a50fb14000000b0053deca88775mr8261542edq.26.1699999793127; Tue, 14
 Nov 2023 14:09:53 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-12-lb@semihalf.com>
 <CAJfuBxzhz7pBYkfqfPomH4PUzqLPX1nxsev4yrQ2P6m5hyMT+Q@mail.gmail.com>
 <CAK8ByeJ1fYSVaVQz3tERzj_5QNAN4Ggx850pKcAG3vhsoWnS+w@mail.gmail.com>
 <CAJfuBxyu3VqakFNr4mW0h4QiPVSf-7HSPXobGO2_qC-H8yLgcw@mail.gmail.com>
 <CAK8ByeL1WwdVKSMtGfbHZLfYm73ZwjiEbtNZJiWur-spMc74Zg@mail.gmail.com>
 <CAJfuBxz1=9o06Rj_mX-2aZXhCSF7rKxyusayPiy4RuJZ7qKbQw@mail.gmail.com>
 <CAK8ByeJH8vKUxeM21ME0vYjKmC_Z=P8XsKiB42k95iZ09bJXJg@mail.gmail.com>
 <CAJfuBxxw6DbmGG-UdiZeUr9680tJVEVcw-czPL+jt-88YUMgbw@mail.gmail.com>
 <CAK8ByeL4YSCBPPGSeNAPAKtR2=BEZxBjpNE3KeX8TaMmJrficQ@mail.gmail.com> <CAJfuBxwA_1kkjeqDRCDKvJ+PesUgYcVwdQeL-ePM7+ZFLfnO0w@mail.gmail.com>
In-Reply-To: <CAJfuBxwA_1kkjeqDRCDKvJ+PesUgYcVwdQeL-ePM7+ZFLfnO0w@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Tue, 14 Nov 2023 23:09:41 +0100
Message-ID: <CAK8Bye+yYQZ6UGYB6sTaJpwRnhHYRF=qdz7FC5bMA4zqzCEgOw@mail.gmail.com>
Subject: Re: [PATCH v1 11/12] dyndbg: write debug logs to trace instance
To:     jim.cromie@gmail.com
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 14 lis 2023 o 16:41 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Tue, Nov 14, 2023 at 12:45=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihal=
f.com> wrote:
> >
> > wt., 14 lis 2023 o 02:08 <jim.cromie@gmail.com> napisa=C5=82(a):
> > >
>
> > > > > > Also I think we need a reserved keyword for writing debug logs =
to
> > > > > > trace events - maybe "event" keyword ?
> > > > >
> > > > > do you mean "event" as a selector, like module, function, class, =
etc ?
> > > > > if so, what are the values ?
> > > > > any event under  /sys/kernel/debug/tracing/events/ ?
> > > > >
> > > > > how does this get used ?
> > > > >
> > > >
> > > > I meant that we need to reserve name/keyword to enable writing debu=
g
> > > > logs to trace events (prdbg and devdbg), for example
> > > > echo module usbcore +T:event > /proc/dynamic_debug/control
> > > >
> > > > Or do you anticipate other way to do it ?
> > >
> > > way back, when I had even fewer clues,
> > > I sent patches to call trace-printk when +T was set.
> > > Steve didnt like it, I think cuz it could flood the tracebuf.
> > >
> > > Thats why I added the prdbg and devdbg event-types,
> > > so that they could be disabled easily using /sys/kernel/debug/tracing=
/
> > > putting them squarely under trace-control.
> > >
> > > Note that this puts 2 off-switches in series,
> > > both tracefs and >control can disable all the pr_debug traffic,
> > > tracefs by event-type, and >control at individual callsite level.
> > >
> > > echo 1 > /sys/kernel/debug/tracing/dyndbg/enable
> > > echo 1 > /sys/kernel/debug/tracing/dyndbg/prdbg/enable
> > > echo 1 > /sys/kernel/debug/tracing/dyndbg/devdbg/enable
> > >
> > > I briefly thought about linking the 2 off-switches,
> > > but punted cuz I thought it complicated things,
> > > (how exactly would they get coupled?)
> > > and I didnt want to distract from larger goals
> > >
> > > Does that address your question ?
> > >
> >
> > Jim,
> >
> > Thanks but it doesn't answer my question.
> >
> > How do you plan to enable output to tracefs event at a callsite level ?
> >
> > In my original proposal it was enabled by setting trace destination to
> > 0. Since we are moving to names instead of numbers now I guess we need
> > to reserve a name for it not to clash with trace instance names
> > provided by users. That's why I proposed to reserve name "event" for
> > that purpose and be used as +T:event.
> >
>
> Ok, I got your point now.
>
> how about we call it "0" ?
> it should be an obvious "magical" value,
> cuz it doesnt need to be open'd, and cant be close'd
>
> then we can revert to global tracebuf by its "name"
> echo module foo +T:0 > /proc/dynamic_debug/control
>

I like it. It resembles surprise emoji :0

> we probably should also limit the trace-instance-names to ^\w+
>

Ack

I think this closes the last open topic to discuss for now.
I will get back with next patchset version to you soon.

> > Or did I miss answer to that in our long discussion :> ?
>
> nope :-)
>
> thanks,
> Jim
>
> >
> > Thanks,
> > Lukasz
> >
> > > On a related point, I also added drm_dbg and drm_devdbg.
> > > Those are issued from __drm_dbg & __drm_dev_dbg
> > >  respectively when CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dn.
> > >
> > > Im not sure theyre more useful than confusing yet.
> > >
> > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > and +T  w/o dest means use existing setting, not just 0 (=
unless thats
> > > > > > > > > the existing setting)
> > > > > > > > >
> > > > > > > >
> > > > > > > > Sounds good.
> > > > > > > >
> > > > > > >
> > > > > > > :-)
