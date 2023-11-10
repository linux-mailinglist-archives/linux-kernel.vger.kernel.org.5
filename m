Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B907E82A9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbjKJTXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbjKJTXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:23:18 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D263F5B9C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:20:28 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7ba0c234135so763061241.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699644028; x=1700248828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TlWo1vYeGdzuVuCQORa0xZC4CeIlKfvMlohZKb/QW0=;
        b=Gha1uf9llCfCG8I9FHl2fYaWyqHZpn7yyzytzuuANl9LHCQBMyTjwqOU7ZIkbsEXJG
         TdC6bDSbUsN6LgjcintoAjYWmjwjN7P1N3BJ3kCIOCB7LTK9xOMHoo5l76ieSAnf3f+L
         epeq6v+TKDEtcZ1yu6DPhiQRAfTrTgBDN0ZS0Ndi7qGrCEFty5DxDDSHt+5UqgFYHfOJ
         6mGmEk6CSgTbF5JM/D75kD0iR9KT5v4jLPqNbS+v6oaB/f7CqeqafIFlfsDboScDmLe9
         5qzcjYiX2CYSygRxdbz1HlKGDUpg+dTWL33JzyulfrevXVH/BNoeRj/GNahzrA0pd6i6
         GJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699644028; x=1700248828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TlWo1vYeGdzuVuCQORa0xZC4CeIlKfvMlohZKb/QW0=;
        b=kZSepOzFzG1ZLkXbA3xTLPWYtt+xFPk4ijA8saEX8G1BaNh5qpht62F25NxsTaiylx
         lufOxs+o1PEGoDmIIIB7GFZ2Q63muxsWz+jk4Oggbnt5+bDPeNEMUR9WOkezH61lfTR3
         THLABPjWDPnOh+Uyy9sWw9AWn1e68c/uMDTnaylYZsqTfVV0uLphqqryjmoyvQ5Il4nV
         n45oRWTR0YF5tnLOqp9DTtDaiwPBxUYMrP5V7BrHWrTKA8m1e6NL5ane95ZUcP+fcaNA
         GGH2UbHxquy89H3MS5ZKgYOHZ44qPRfv58YLCrH2wT+uvgrJd5zfPuyWZ9kgrKAJT0dl
         m6fw==
X-Gm-Message-State: AOJu0Yyrnkkg3/Sj1bGcFBka2roQIIO7jCGzN7ytBBvI0PlV3Db+y6Es
        Nw9Is4Ja9LllEcOBckVwuFd7XSQrXA/elr+w+4A=
X-Google-Smtp-Source: AGHT+IG3aRFWJUpgbhiHngNVKGiKGuhGe18uw98Z5TXQLQbUKCqRsmPpVgxqpGewQTKfTXcIqMVwIrLsLOn+2Jmbfds=
X-Received: by 2002:a67:e04e:0:b0:452:78ea:4aec with SMTP id
 n14-20020a67e04e000000b0045278ea4aecmr347767vsl.7.1699644027871; Fri, 10 Nov
 2023 11:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-5-lb@semihalf.com>
 <20231106185513.79411f9a@gandalf.local.home> <CAK8Bye+eAad4Lx6BWztD4Eax_WLyGB39oV2VFDfL5pGJJTYgcw@mail.gmail.com>
In-Reply-To: <CAK8Bye+eAad4Lx6BWztD4Eax_WLyGB39oV2VFDfL5pGJJTYgcw@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Fri, 10 Nov 2023 12:20:01 -0700
Message-ID: <CAJfuBxxxW5qHRNRXfkNZwvKrLWeTVWZL2QQQck-YednN=QQ0fQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/12] dyndbg: add 2 trace-events: pr_debug, dev_dbg
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

On Fri, Nov 10, 2023 at 7:51=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> wt., 7 lis 2023 o 00:55 Steven Rostedt <rostedt@goodmis.org> napisa=C5=82=
(a):
> >
> > On Fri,  3 Nov 2023 14:10:03 +0100
> > =C5=81ukasz Bartosik <lb@semihalf.com> wrote:
> >
> > > +/* capture pr_debug() callsite descriptor and message */
> > > +TRACE_EVENT(prdbg,
> > > +         TP_PROTO(const struct _ddebug *desc, const char *text, size=
_t len),
> > > +
> > > +         TP_ARGS(desc, text, len),
> > > +
> > > +         TP_STRUCT__entry(
> > > +                     __field(const struct _ddebug *, desc)
> > > +                     __dynamic_array(char, msg, len + 1)
> > > +                 ),
> > > +
> > > +         TP_fast_assign(
> > > +                     __entry->desc =3D desc;
> > > +                     /*
> > > +                      * Each trace entry is printed in a new line.
> > > +                      * If the msg finishes with '\n', cut it off
> > > +                      * to avoid blank lines in the trace.
> > > +                      */
> > > +                     if (len > 0 && (text[len - 1] =3D=3D '\n'))
> > > +                             len -=3D 1;
> > > +
> > > +                     memcpy(__get_str(msg), text, len);
> > > +                     __get_str(msg)[len] =3D 0;
> > > +                 ),
> > > +
> >
> >
> > > +         TP_printk("%s.%s %s", __entry->desc->modname,
> > > +                   __entry->desc->function, __get_str(msg))
> > > +);
> > > +
> >
> > That TP_printk() is dangerous. How do you know __entry->desc still exis=
ts
> > when reading the buffer?
> >
> > Is the struct _ddebug permanent? Can it be freed? If so, the above can
> > easily cause a crash.
> >
>
> I assume that we're talking here about the scenario where TP prdbg is
> called and before TP_printk runs _ddebug pointer
> becomes invalid, is that correct ? If so then I believe this also
> applied to __dynamic_pr_debug and other dyndbg functions because there
> is also potential for _ddebug pointer to become invalid (in case of
> rrmod) before a function dereferences it.
>
> Would it be acceptable to increase reference count of a module and
> hold it until at least one callsite in that module is enabled ?
> This  would ensure that passed pointer to a _ddebug struct is valid.
>

Im not understanding you, but I dont think its on-point -

a loadable module might write lots to trace-log, and each trace-entry
would have the descriptor address, with which it could deref and print 3 fi=
elds.
Then rmmod happens, all the module mem is freed, and reused for someth9ing =
else.

then someone cats trace, and the descriptor addrs are used to render
the tracelog.
BOOM.



> > -- Steve
