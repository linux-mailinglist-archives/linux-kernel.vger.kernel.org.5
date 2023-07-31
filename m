Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F059D768BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGaGTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGaGTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:19:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36BD188;
        Sun, 30 Jul 2023 23:19:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so5512483a12.1;
        Sun, 30 Jul 2023 23:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690784376; x=1691389176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eyuVZGHrYlHoh+nOWqETVRc5+l/gf1Sp6LFIyZxmPk=;
        b=IQHnBA7dPB9m/24AyUTctN9XhN1LYoI6aX0FljAh8cmqXxXE9pX91h0u1GOjha0zrZ
         AHhrOk8YjFyLyZ+MoTdjyb+T66aTsbuLF4dtJYsW2aGcfuI1N7ua34bi7YXOjDYDvQOG
         XZjbd7Vd2df7SOzHxxvZRIVcVB2ocFgjQAIv49PqaxTpSogRmMBTmqwxZTnP/Y+MWtBc
         g9LMHrP6w6fJ8WE18TPkzjbqEX8VASaekPd/o3VbFyudLJFKQqvXfdR9YKaIH3+2+FMj
         zbB2DEiaOTNA+yBSLZDx9Rp8dG2XsjxpJEqk6a1hTl8W7Xg2g8usdqwmwTtAuRvxuhuw
         xpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690784376; x=1691389176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eyuVZGHrYlHoh+nOWqETVRc5+l/gf1Sp6LFIyZxmPk=;
        b=GuvL5DJqNNlTZ0HuiRa8rbuRIBgWpiVKGHA1n4hBgJT+/JPepZ+2NNJzWOoZU94Hsx
         SPA3IVDykd2lj5z7dlaZlIUJDlTBueN1WG67MbXGyNoWj9+ICqBVj0TXQJgyRDn4FTMT
         huocJa8EfE5IrYG6UKV3l5dMFsA6FjbJn69arpvaVwhcKhliKiqGd5NrpQvlTYpeKyxR
         VB3GC1vPYDxmdwjPtvIR9b6Gm4OHfaGLkP71qXbba6bA7EcrQo7C+gXlMvOTJigVNime
         oP1syFkSXhRnlI7psi1bDq60NiwnrLHwEd/9dmC3mezPMuE1TPxf4UccXRdejB/5rUI1
         6yEw==
X-Gm-Message-State: ABy/qLYvdQ0DtNav3zP84B01v1B3tfDo2/JtIylE26woODz0hekvNvAT
        4yYQ9+9DgO5Oh68BXNhvTQG+KWf+te40X2sOo68=
X-Google-Smtp-Source: APBJJlGUu+b6hGycgKDKx4XQRNH2CN8zd3aq60kYZ3brNmliml1QFDvzDdgclUQXsmxYrpAccCk3WQbDSusbh5MSHfU=
X-Received: by 2002:a50:ec82:0:b0:522:2aba:bb32 with SMTP id
 e2-20020a50ec82000000b005222ababb32mr7599019edr.13.1690784376100; Sun, 30 Jul
 2023 23:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230726121618.19198-1-zegao@tencent.com> <20230731125254.b059f0c7f29761d018dedbe8@kernel.org>
In-Reply-To: <20230731125254.b059f0c7f29761d018dedbe8@kernel.org>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Mon, 31 Jul 2023 14:19:24 +0800
Message-ID: <CAD8CoPDvVK7SDC+4Rq66W0i+7Phnri9EOrK3GwskRNiYhawNug@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] report task state in symbolic chars from sched tracepoint
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Thanks for your review!

Sincerely,
Ze

On Mon, Jul 31, 2023 at 11:53=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Wed, 26 Jul 2023 20:16:15 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> >
> > This is the 2nd attempt to fix the report task state issue in sched
> > tracepint, here is the first version:
> >
> > https://lore.kernel.org/linux-trace-kernel/20230725072254.32045-1-zegao=
@tencent.com
> >
> > Against v1, add a new var to report task state in symbolic char instead
> > of replacing the old one and to not to break anything.
> >
> > --
> >
> > In the status quo, we should see three different outcomes of the report=
ed
> > sched-out task state from perf-script, perf-sched-timehist, and Tp_prin=
tk
> > of tracepoint sched_switch.  And it's not hard to figure out that the
> > former two are built upon the third one, and the reason why we see this
> > inconsistency is that the former two does not catch up with the interna=
l
> > change of reported task state definitions as the kernel evolves.
> >
> > IMHO, exporting internal representations of task state in the tracepoin=
t
> > sched_switch is not a good practice and not encouraged at all, which ca=
n
> > easily break userspace tools that relies on it. Especially when tracepo=
ints
> > are massively used in many observability tools nowadays due to its stab=
le
> > nature, which makes them no longer used for debug only purpose and we
> > should be careful to decide what ought to be reported to userspace and =
what
> > ought not.
> >
> > Therefore, to fix the issues mentioned above for good, instead of choos=
ing
> > I proposed to add a new variable to report task state in sched_switch w=
ith
> > a symbolic character along with the old hardcoded value, and save the
> > further processing of userspace tools and spare them from knowing
> > implementation details in the kernel.
> >
> > After this patch seires, we report 'RSDTtXZPI' the same as in procfs, p=
lus
> > a 'p' which denotes PREEMP_ACTIVE and is used for sched_switch tracepoi=
nt only.
>
> This series looks good to me. Putting the flag in the trace record is
> a good idea :)
>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> for this series.
>
> Thank you,
>
> >
> > Reviews welcome!
> >
> > Regards,
> >
> > Ze
> >
> > Ze Gao (2):
> >   sched, tracing: add to report task state in symbolic chars
> >   perf sched: use the new prev_state_char instead in tracepoint
> >     sched_switch
> >
> >  include/trace/events/sched.h | 60 +++++++++++++++++++++---------------
> >  tools/perf/builtin-sched.c   | 57 ++++++----------------------------
> >  2 files changed, 45 insertions(+), 72 deletions(-)
> >
> > Ze Gao (1):
> >   libtraceevent: use the new prev_state_char instead in tracepoint
> >     sched_switch
> >
> >  plugins/plugin_sched_switch.c | 29 ++++-------------------------
> >  1 file changed, 4 insertions(+), 25 deletions(-)
> >
> > --
> > 2.40.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
