Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B667EAB04
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjKNHpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKNHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:45:05 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A8D19E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:45:01 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-543c3756521so7869161a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699947900; x=1700552700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hstYwjfzwfpwj7k4Pe9kh0yKfZSsN+Vh5R4G+1/QXfI=;
        b=q+6DQwLQQFo1K9wd8ieRhlnXR1TL59ktZBCTYpVLeH0qQvj0fTv4p1J31j6F7u+iml
         vVmt2la0GyoaEeN1JDtjTHaE2zEauqaiI6lWaNm8BCdRx1OAtr8TY768P2doM+fAjpTG
         aZG7xGWrfYNziwkcDLApNr9CiKfzyhaqVnTW9to4Ajrm+xKNPb5Ek4wFRySnYPiRjOgk
         1X6NvieD32pHf8+scK+zoDWDHx4Y3kNxX2N9vQoECVUNy23cmW7HQQjtjB0J+Q3w9JaR
         vRrJGTW5Z3sTlqueLK4lAyNgAiUUUjHRUamQxHYed7mpsY4UE+kqfnOgsp8T/iv3uv+U
         rTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699947900; x=1700552700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hstYwjfzwfpwj7k4Pe9kh0yKfZSsN+Vh5R4G+1/QXfI=;
        b=H/dGaPlwE286tZnjjZBR3HH9cKgihtu0v3CRiVfQsa6KwW176OHHik/h6OeaYHiQxE
         2UAK0S+eITG3zT+NzUQ9CAm35TSGjVPhgAqiIT9fwCgPTBXWo+IBuaJtNzWIGkGJE3BR
         0Yt13OfkUANxy6W7F8bFecLXh+05/OwG68U0SKLHKGf6UHKG2XAuo8hFTMkMz3ve5+Sb
         EcIbbSDCGzWsTDkeFjJB60i/hMcN89OZgQfEB6D+DxoR4KlEPCBOaF5ni9ZfbPz+nEOn
         8/1xkvPKyfcX2Hq4FpP/UhaxOx4zyuiHh8dSehZBDmDhG0MKU5ZqSKOT+tvCk8LiJd+Q
         CZhA==
X-Gm-Message-State: AOJu0YxgDnUA3edz4JQXKPuIsUGyzN5IuVWxCXkWlg39yHySLuEZUHDv
        9R63vbt8lDc28k5dZL8tQz4TST2Pz1IebAbs/KAh
X-Google-Smtp-Source: AGHT+IFveKL5fRAE3z1gUKJNiU+sfNeLfeobZRy7BI0/ReD/EuEhJPV4GIerp3Sf7gyze82P1NacDS+XJyYWrTT29DI=
X-Received: by 2002:a05:6402:1a45:b0:53e:1815:ed0f with SMTP id
 bf5-20020a0564021a4500b0053e1815ed0fmr6628261edb.31.1699947900134; Mon, 13
 Nov 2023 23:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-12-lb@semihalf.com>
 <CAJfuBxzhz7pBYkfqfPomH4PUzqLPX1nxsev4yrQ2P6m5hyMT+Q@mail.gmail.com>
 <CAK8ByeJ1fYSVaVQz3tERzj_5QNAN4Ggx850pKcAG3vhsoWnS+w@mail.gmail.com>
 <CAJfuBxyu3VqakFNr4mW0h4QiPVSf-7HSPXobGO2_qC-H8yLgcw@mail.gmail.com>
 <CAK8ByeL1WwdVKSMtGfbHZLfYm73ZwjiEbtNZJiWur-spMc74Zg@mail.gmail.com>
 <CAJfuBxz1=9o06Rj_mX-2aZXhCSF7rKxyusayPiy4RuJZ7qKbQw@mail.gmail.com>
 <CAK8ByeJH8vKUxeM21ME0vYjKmC_Z=P8XsKiB42k95iZ09bJXJg@mail.gmail.com> <CAJfuBxxw6DbmGG-UdiZeUr9680tJVEVcw-czPL+jt-88YUMgbw@mail.gmail.com>
In-Reply-To: <CAJfuBxxw6DbmGG-UdiZeUr9680tJVEVcw-czPL+jt-88YUMgbw@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Tue, 14 Nov 2023 08:44:49 +0100
Message-ID: <CAK8ByeL4YSCBPPGSeNAPAKtR2=BEZxBjpNE3KeX8TaMmJrficQ@mail.gmail.com>
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

wt., 14 lis 2023 o 02:08 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Mon, Nov 13, 2023 at 4:44=E2=80=AFPM =C5=81ukasz Bartosik <lb@semihalf=
.com> wrote:
> >
> > pon., 13 lis 2023 o 19:59 <jim.cromie@gmail.com> napisa=C5=82(a):
> > >
> > > On Sun, Nov 12, 2023 at 9:32=E2=80=AFAM =C5=81ukasz Bartosik <lb@semi=
half.com> wrote:
> > > >
> > > > pt., 10 lis 2023 o 21:03 <jim.cromie@gmail.com> napisa=C5=82(a):
> > > > >
> > > > > On Fri, Nov 10, 2023 at 7:53=E2=80=AFAM =C5=81ukasz Bartosik <lb@=
semihalf.com> wrote:
> > > > > >
> > > > > > sob., 4 lis 2023 o 22:49 <jim.cromie@gmail.com> napisa=C5=82(a)=
:
> > > > > > >
> > > > > > > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <=
lb@semihalf.com> wrote:
> > > > > > > >
> > > > > > > > When trace is enabled (T flag is set) and trace_dst field i=
s set
> > > > > > > > to value greater than 0 (0 is reserved for trace events) th=
en
> > > > > > > > debug logs will be written to trace instance pointed by tra=
ce_dst
> > > > > > > > value, for example when trace_dst value is 2 then debug log=
s will
> > > > > > > > be written to <debugfs>/tracing/instances/dyndbg_inst_2 ins=
tance.
> > > > > > > > Given trace instance will not be initialized until debug lo=
gs are
> > > > > > > > requested to be written to it and afer init will persist un=
til
> > > > > > > > reboot.
> > > > > > > >
> > > > > > >
> > > > > > > restating 00 comments -
> > > > > > >
> > > > > > > you can get rid of integer destination ids by adding a new co=
mmand: open/close
> > > > > > >
> > > > > > > $> echo  \
> > > > > > >  open kms-instance \;\
> > > > > > >  class DRM_UT_KMS -T:kms-instance  # preset-dests-disable-sit=
es \;\
> > > > > > > > /proc/dynamic_debug/control
> > > > > > >
> > > > > >
> > > > > > Instead of using above command to preset destination we could p=
reset
> > > > > > destination with open command. I mean last successful
> > > > > > open would preset destination ? What do you think ?
> > > > > >
> > > > >
> > > > > I dont think it works - if open maps to a dest-number, (or implic=
it as
> > > > > TOP-of-stack)
> > > > > then you just have +T<dest-number>  (or +T <implicit tos>)
> > > > > rather than +T:dest-name
> > > > > and you still have to keep track of what dest-numbers were alread=
y used.
> > > > > (or every new dest needs an explicit OPEN before it)
> > > > >
> > > > > and how do you then get back to default instance ?
> > > > > open 0 ?
> > > > > close <previous-handle> ?
> > > > >
> > > > >
> > > > > by using names, all opens can be at the top,
> > > > > (and thus document in 1 block all the named-instances)
> > > > > and any named dest that hasnt been opened is an error
> > > > > (not just reusing previous OPEN)
> > > > >
> > > >
> > > > Sorry, I should have been more specific with my proposal. Let me us=
e
> > > > an example to clarify it:
> > > > open usb    # -> create trace instance "usb" and make it default
> > > > echo module usbcore +T > /proc/dynamic_debug/control ## --> write u=
sbcore
> > > > ## debug logs to trace instance named usb
> > > > open tbt --> create trace instance "tbt" and make it default
> > > > echo module aaa +T:usb > /proc/dynamic_debug/control --> write aaa
> > > > debug logs to trace instance named usb, instance usb has to be used
> > > > explicitly
> > > >
> > > >                          because now tbt is default trace instance
> > >
> > > that feels too magical/ action at a distance.
> > >
> > > ISTM it also muddles what the "default" is:
> > >
> > > my-default:
> > > what each callsite's current/preset dest is/was
> > > the only way to set it is with explicit [-+]T:outstream
> > >
> >
> > I see your point, I will follow your suggestion.
> >
> > > your-default:
> > > whatever was last opened. whether it was 2 or 50 lines above,
> > > or set weeks ago, the last time somebody opened an instance.
> > >
> > > and as more instances are created
> > > (potentially by different users?
> > > after all there are separate instances,
> > > and presumably separate interests),
> > > the default gets less predictable.
> > >
> > >
> > > > echo module bbb +T > /proc/dynamic_debug/control --> write bbb debu=
g
> > > > logs to trace instance named tbt
> > > > close tbt --> close tbt trace instance, I omit this step but in ord=
er
> > > > for an instance to be successful closed it must not be used by any
> > > > callsite, after
> > > >                     closing tbt instance the usb becomes default in=
stance
> > >
> > > so after 'close tbt',  the previous 'open usb' is now top-of-stack ?
> > >
> > > how does that affect all existing callsite-users of tbt ?
> > > do they continue to use the trace-instance theyve been writing to ?
> > > If not, then reverting to the global instance seems much more predict=
able.
> > >
> > > Or are you proposing that the close fails because the instance is sti=
ll in use ?
> > > this seems least surprising,
> > > and more robust in the face of the next 'open foo'
> > > which could otherwize reuse the dst_id mapped to tbt
> > >
> > >
> > > >
> > > > I agree that your method of setting default trace instance is more =
flexible:
> > > > class DRM_UT_KMS -T:kms-instance  # preset-dests-disable-sites
> > > >
> > > > Maybe we can combine both to set default trace destination ?
> > > >
> > > > Also I think we need a reserved keyword for writing debug logs to
> > > > trace events - maybe "event" keyword ?
> > >
> > > do you mean "event" as a selector, like module, function, class, etc =
?
> > > if so, what are the values ?
> > > any event under  /sys/kernel/debug/tracing/events/ ?
> > >
> > > how does this get used ?
> > >
> >
> > I meant that we need to reserve name/keyword to enable writing debug
> > logs to trace events (prdbg and devdbg), for example
> > echo module usbcore +T:event > /proc/dynamic_debug/control
> >
> > Or do you anticipate other way to do it ?
>
> way back, when I had even fewer clues,
> I sent patches to call trace-printk when +T was set.
> Steve didnt like it, I think cuz it could flood the tracebuf.
>
> Thats why I added the prdbg and devdbg event-types,
> so that they could be disabled easily using /sys/kernel/debug/tracing/
> putting them squarely under trace-control.
>
> Note that this puts 2 off-switches in series,
> both tracefs and >control can disable all the pr_debug traffic,
> tracefs by event-type, and >control at individual callsite level.
>
> echo 1 > /sys/kernel/debug/tracing/dyndbg/enable
> echo 1 > /sys/kernel/debug/tracing/dyndbg/prdbg/enable
> echo 1 > /sys/kernel/debug/tracing/dyndbg/devdbg/enable
>
> I briefly thought about linking the 2 off-switches,
> but punted cuz I thought it complicated things,
> (how exactly would they get coupled?)
> and I didnt want to distract from larger goals
>
> Does that address your question ?
>

Jim,

Thanks but it doesn't answer my question.

How do you plan to enable output to tracefs event at a callsite level ?

In my original proposal it was enabled by setting trace destination to
0. Since we are moving to names instead of numbers now I guess we need
to reserve a name for it not to clash with trace instance names
provided by users. That's why I proposed to reserve name "event" for
that purpose and be used as +T:event.

Or did I miss answer to that in our long discussion :> ?

Thanks,
Lukasz

> On a related point, I also added drm_dbg and drm_devdbg.
> Those are issued from __drm_dbg & __drm_dev_dbg
>  respectively when CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dn.
>
> Im not sure theyre more useful than confusing yet.
>
> >
> > > >
> > > >
> > > > >
> > > > > > >
> > > > > > > and +T  w/o dest means use existing setting, not just 0 (unle=
ss thats
> > > > > > > the existing setting)
> > > > > > >
> > > > > >
> > > > > > Sounds good.
> > > > > >
> > > > >
> > > > > :-)
