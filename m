Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C79876DDCB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjHCCCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCCCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:02:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F219C13E;
        Wed,  2 Aug 2023 19:02:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe48d0ab0fso740230e87.1;
        Wed, 02 Aug 2023 19:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691028136; x=1691632936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcK6gslx0LoIyGj+/TpyBsBC+gruy1kemhKkiJB+8W8=;
        b=RPwVsk4sOj2Nq+sKh3qHWv5DoD9cfQy6DEJ0Xn0EP9Ohsx5uqkXr1sq33B4R0hQlcm
         nn50Nxo6gN8AfE1bLB+54DPKFLHRswl4IRGMJF4eAwBbggUrk6pOzAYTn0ypCFTsIhgU
         mmnLiPjuzQNEOWw7esUMP3kfC01KdQYe8d1l3lDrFckvKr6nd26cL0f0ZU/S0Wo94j27
         7ZH14DzJuuQ0RCMRZhA/3ZodUUQW5SRRVCHptEXjUIyl7HI0RoljhkDoYbPcb0KuGR8t
         Ube0htK2aiilLm6tlCcF8gQcBgStQ0Bi8GhhrwneXS+YwmDhwdASPvV75e+cN24bIVzY
         lk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691028136; x=1691632936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcK6gslx0LoIyGj+/TpyBsBC+gruy1kemhKkiJB+8W8=;
        b=NX4dP+Q/0iOmImVpT+4RBHsWPGe3Nd7QX4Ut18Q355buO5g8NDS0a4dVnigUWyqolP
         rnnZGluaiKr2KM4ajluvslb9+ShfElArz6ZsfH4wsPhkj/qFLbZIi6crtzzwWgAy1ZPb
         qNAqEdqwE3ZWgVGeTI80OL3VkkmP/NB1WK6zrdU9bNtl7OLiBXpsm+P83pwlNAUlo8Cj
         Mzy5ES1jm410mvhwJzBoka3T7FM6vN8autmBvQBA/G8anMd8S70CrVMPEXLtEhAsIp5s
         F6K9OIDD2GyuM/DC55CyK2+wqKGbWi9qcw5HoCiSzAU9p1Cr7vISntu4WZUeNV5xZ6ds
         H65Q==
X-Gm-Message-State: ABy/qLYzbATFHJzx7svClVE7WWzt0J/DdxQODnVZK3wTZ+LqoBzy7DGq
        wfBAR5RAxrq4P3Sgod0fgw85juLoJbKlcuTl6wU=
X-Google-Smtp-Source: APBJJlFQhf0kZ84BOcTysEnD0b4btfk6w9fnBq19hPWw57ei4khkRRWhYI+YozSgtnSXcZlMZ0w2YrKbBWkXD/ljXPg=
X-Received: by 2002:a19:384d:0:b0:4f7:6685:2c5f with SMTP id
 d13-20020a19384d000000b004f766852c5fmr5164267lfj.61.1691028135872; Wed, 02
 Aug 2023 19:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230802121116.324604-1-zegao@tencent.com> <20230802121116.324604-5-zegao@tencent.com>
 <20230802110552.768f0487@gandalf.local.home>
In-Reply-To: <20230802110552.768f0487@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Thu, 3 Aug 2023 10:02:04 +0800
Message-ID: <CAD8CoPDad+PckQVD51c4bU7Z-cDuguknWMhoBVQ5G1PX0R-npQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/7] sched, tracing: reorganize fields of switch
 event struct
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 11:05=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed,  2 Aug 2023 08:09:59 -0400
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > From: Ze Gao <zegao2021@gmail.com>
> >
> > Report priorities in 'short' and prev_state in 'int' to save
> > some buffer space. And also reorder the fields so that we take
> > struct alignment into consideration to make the record compact.
> >
> > Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >  include/trace/events/sched.h | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.=
h
> > index fbb99a61f714..7d34db20b2c6 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -187,7 +187,7 @@ DEFINE_EVENT(sched_wakeup_template, sched_wakeup_ne=
w,
> >            TP_ARGS(p));
> >
> >  #ifdef CREATE_TRACE_POINTS
> > -static inline long __trace_sched_switch_state(bool preempt,
> > +static inline int __trace_sched_switch_state(bool preempt,
> >                                             unsigned int prev_state,
> >                                             struct task_struct *p)
> >  {
> > @@ -229,23 +229,23 @@ TRACE_EVENT(sched_switch,
> >       TP_ARGS(preempt, prev, next, prev_state),
> >
> >       TP_STRUCT__entry(
> > -             __array(        char,   prev_comm,      TASK_COMM_LEN   )
> >               __field(        pid_t,  prev_pid                        )
> > -             __field(        int,    prev_prio                       )
> > -             __field(        long,   prev_state                      )
> > -             __array(        char,   next_comm,      TASK_COMM_LEN   )
> >               __field(        pid_t,  next_pid                        )
> > -             __field(        int,    next_prio                       )
> > +             __field(        short,  prev_prio                       )
> > +             __field(        short,  next_prio                       )
> > +             __field(        int,    prev_state                      )
>
> I was talking with Peter on IRC and since the biggest number that
> prev_state can be is TASK_REPORT_MASK which is 0x100, I think we can make
> prev_state into a short as well.

Make sense, let's change it to short.

Regards,
Ze
