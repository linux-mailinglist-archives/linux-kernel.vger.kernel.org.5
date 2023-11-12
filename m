Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BF07E91A3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 17:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjKLQ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 11:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKLQ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 11:28:40 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D23E10F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 08:28:36 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so5672264a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 08:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699806515; x=1700411315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCbs69Tds4xA2ve8042KTHQeH0ZiMjy62WCu32iSZ4o=;
        b=m2e0inb+6Vxvcy64FLvQwPMYFXgicPxwexBYL2x/QhIsyWD20fgyzwiOw57FMUXpI3
         jfKVZnsNnacFtjvEb5RXxQRLwyFW+OXQv7uoOaoeHXOenKStR1zV3e6lrOs4zDIoRoIa
         gFvXScFVprqQrUdtqDmhOoj+TIcVAWmcYXEg7+7YwKwl1g19jL93eqh13CoYpr2KTNdW
         psyNBzIzZmoLcLMXTwUUbmJ0qYyMcTb/WoiMz8+c5znCaEZ4OMr45fQjE09S3uV/bud1
         Z4U2hngCTrle0FDBBc1hhnUfdXBrlxR+9n8tEvEzx9GUP7beWkU2c16JO4WCQ05m2TWY
         1mQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699806515; x=1700411315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCbs69Tds4xA2ve8042KTHQeH0ZiMjy62WCu32iSZ4o=;
        b=ID0nsdNb0nBITT7GUDuDE3cfieLsMqtwd8diOHhAtvKHLxIjFzA3Rv6WW77KHBCS1i
         bPK2Ub4sgJmBPpQu3qAXe7evSQitZbyE+xai2BRkfyet5Ay3gwxwcGlHlIO6eFG8FYHf
         SyzErg1m8V2cmWh80hzj1Ompfw6EAa0Zj1cOOQvECvaf55PlJ6TJBsBAefhmioPr8H9E
         Jig2lKVEGUa3CG1GhhOsxqbEJXlR2aLxwri05v8gyxsdDp7fbnCBq5fheRS9HGsgrIMR
         9/rWJkmT5lFyifxSNJnMIzDwO/mINBmo0L5kJxCUN97Pu0U1lpmrawwWu4hsEfjIqQ0u
         2iMQ==
X-Gm-Message-State: AOJu0Yw/SORZWltp3HKuzp3fQpQoj481ku82am2bjkrwIaM27wpX2TD5
        AFB+cQIM4LVYhepdujUzUHx1Ag1DOjCss/M011uj
X-Google-Smtp-Source: AGHT+IFuvMBh+5u5eIrx+y6uiAEUta5B44PaprHsuU3/24YXVfX/f36AJatOTUj1BT6FBDEXwPba0/YFZOKk6SUjRAU=
X-Received: by 2002:a05:6402:609:b0:53f:8493:5b0b with SMTP id
 n9-20020a056402060900b0053f84935b0bmr2693884edv.35.1699806514975; Sun, 12 Nov
 2023 08:28:34 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-5-lb@semihalf.com>
 <20231106185513.79411f9a@gandalf.local.home> <CAK8Bye+eAad4Lx6BWztD4Eax_WLyGB39oV2VFDfL5pGJJTYgcw@mail.gmail.com>
 <CAJfuBxxxW5qHRNRXfkNZwvKrLWeTVWZL2QQQck-YednN=QQ0fQ@mail.gmail.com>
In-Reply-To: <CAJfuBxxxW5qHRNRXfkNZwvKrLWeTVWZL2QQQck-YednN=QQ0fQ@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Sun, 12 Nov 2023 17:28:23 +0100
Message-ID: <CAK8Bye+L9Hri+mj1gc2Q8ydmtsYx=mk5+OQhXE-BHO+1VJruVw@mail.gmail.com>
Subject: Re: [PATCH v1 04/12] dyndbg: add 2 trace-events: pr_debug, dev_dbg
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 10 lis 2023 o 20:20 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Fri, Nov 10, 2023 at 7:51=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf=
.com> wrote:
> >
> > wt., 7 lis 2023 o 00:55 Steven Rostedt <rostedt@goodmis.org> napisa=C5=
=82(a):
> > >
> > > On Fri,  3 Nov 2023 14:10:03 +0100
> > > =C5=81ukasz Bartosik <lb@semihalf.com> wrote:
> > >
> > > > +/* capture pr_debug() callsite descriptor and message */
> > > > +TRACE_EVENT(prdbg,
> > > > +         TP_PROTO(const struct _ddebug *desc, const char *text, si=
ze_t len),
> > > > +
> > > > +         TP_ARGS(desc, text, len),
> > > > +
> > > > +         TP_STRUCT__entry(
> > > > +                     __field(const struct _ddebug *, desc)
> > > > +                     __dynamic_array(char, msg, len + 1)
> > > > +                 ),
> > > > +
> > > > +         TP_fast_assign(
> > > > +                     __entry->desc =3D desc;
> > > > +                     /*
> > > > +                      * Each trace entry is printed in a new line.
> > > > +                      * If the msg finishes with '\n', cut it off
> > > > +                      * to avoid blank lines in the trace.
> > > > +                      */
> > > > +                     if (len > 0 && (text[len - 1] =3D=3D '\n'))
> > > > +                             len -=3D 1;
> > > > +
> > > > +                     memcpy(__get_str(msg), text, len);
> > > > +                     __get_str(msg)[len] =3D 0;
> > > > +                 ),
> > > > +
> > >
> > >
> > > > +         TP_printk("%s.%s %s", __entry->desc->modname,
> > > > +                   __entry->desc->function, __get_str(msg))
> > > > +);
> > > > +
> > >
> > > That TP_printk() is dangerous. How do you know __entry->desc still ex=
ists
> > > when reading the buffer?
> > >
> > > Is the struct _ddebug permanent? Can it be freed? If so, the above ca=
n
> > > easily cause a crash.
> > >
> >
> > I assume that we're talking here about the scenario where TP prdbg is
> > called and before TP_printk runs _ddebug pointer
> > becomes invalid, is that correct ? If so then I believe this also
> > applied to __dynamic_pr_debug and other dyndbg functions because there
> > is also potential for _ddebug pointer to become invalid (in case of
> > rrmod) before a function dereferences it.
> >
> > Would it be acceptable to increase reference count of a module and
> > hold it until at least one callsite in that module is enabled ?
> > This  would ensure that passed pointer to a _ddebug struct is valid.
> >
>
> Im not understanding you, but I dont think its on-point -
>
> a loadable module might write lots to trace-log, and each trace-entry
> would have the descriptor address, with which it could deref and print 3 =
fields.
> Then rmmod happens, all the module mem is freed, and reused for someth9in=
g else.
>
> then someone cats trace, and the descriptor addrs are used to render
> the tracelog.
> BOOM.
>

Jim, thanks for educating me on this one. I completely missed the fact
that TP_printk is delayed until, for example as you mentioned cat is
run on a trace.

I'll remove passing of _ddebug ptr to trace_prdbg and trace_devdbg
functions. Probably also passing of dev ptr can removed from
trace_devdbg.

>
>
> > > -- Steve
