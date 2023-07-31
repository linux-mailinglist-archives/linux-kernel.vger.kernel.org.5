Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC477689D8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGaCJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGaCJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:09:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C817A4;
        Sun, 30 Jul 2023 19:09:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso8396475e9.0;
        Sun, 30 Jul 2023 19:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690769375; x=1691374175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nqjr596pMoOTR0MHkgpKhNB8FMr2abG/11cQfPMno8=;
        b=fPLYv/WQnpLXi50r0B0N1uytjAp7sO9fq3+e62vHH1UBfRfZUcdI5FvWgANg8GnJY5
         j+zS3EWFge0nCvlDL61R9yujmcfDdCLJ6FXERsSTqNxDWSttH/DElTzVaTx8KV7MW/ZP
         7pKa5x7DKcd8hGOEFxdzTDRuvkH3iiUCzFfAbafDFf2CK+gUDn6iQE8Fltd80vNEpmKb
         LPeESzuT6T0MFy2AGIv9hvtC5/LcUw5M0AoIn3BzMxzwWldcOdDjRmX5tVQ9Z7eUp6U9
         M71Y3xbr6A8K+mndwCEl/IFhA6SI+HDVfctPTIge/ONoMHttQMDZj2WUrV885qA/FmDt
         ulWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690769375; x=1691374175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nqjr596pMoOTR0MHkgpKhNB8FMr2abG/11cQfPMno8=;
        b=gPHSD+/+0ZoPui+BKQ0TJv+ZWR7NYkF7+iZwTpt68ln3IHBpXiytmPK5glNklaD8f1
         19jm+KI664e+kMX7Zs+dIFTPF50fBuZzDm5bjWtyA0WmBoNfobXeNg27taPK9tt5un2/
         ni3IisfZQ9Z9Q9rCbxRRT8Ef+Rc1XQaZS7ykSnj59F+Btshqm3y1Tgv0HiY3I5Y9xvDk
         A+dOzxroCREO1AnlUvBgoEoaT0zGMi48ImNUL6hgyg1qikPwr5+Ygpb9CD1n7KnbFkNj
         GN0YA1LLY8T8pSj7nZzPhC5k4xGkmFcaULFD99Ngg8ps0q43omnPTYoDGJE3zQ0zX2F1
         AjoA==
X-Gm-Message-State: ABy/qLbc5xegQ2ajAXcOfMBGNd2gHKdEE/z/jc5jbAQaTFhjIhecMZWQ
        s2c9GUa9NsB/B5rI7xCTRlYjdFixjyBzJ9vk329Oyl883ms=
X-Google-Smtp-Source: APBJJlFkd4zDhULgADlEQsYZLK6qTtbOsuVRrqiKOiBn362F7WJxSlCt4mgWd495AlQzBHS72tiuC60CShZ6MPNGmh4=
X-Received: by 2002:adf:df02:0:b0:316:f3cf:6f12 with SMTP id
 y2-20020adfdf02000000b00316f3cf6f12mr6913491wrl.48.1690769374958; Sun, 30 Jul
 2023 19:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230726121618.19198-1-zegao@tencent.com> <CAP-5=fVJ_RL9Md92R4nWBKvZcF9iovL07-=dJ7bqN3LWwufVGw@mail.gmail.com>
In-Reply-To: <CAP-5=fVJ_RL9Md92R4nWBKvZcF9iovL07-=dJ7bqN3LWwufVGw@mail.gmail.com>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Mon, 31 Jul 2023 10:09:23 +0800
Message-ID: <CAD8CoPBC-OT+EWp_Gfqg31p8S91hbReR1nEnVWBzsUmtmKtZKw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] report task state in symbolic chars from sched tracepoint
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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

Thanks Ian,

In regard to ABI, symbolic chars are much more stable and I think
we can benefit from this in the long run.

Regards,
Ze

On Sat, Jul 29, 2023 at 1:29=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Jul 26, 2023 at 5:16=E2=80=AFAM Ze Gao <zegao2021@gmail.com> wrot=
e:
> >
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
> >
> > Reviews welcome!
>
> Thanks Ze,
>
> I think this is worthwhile cleanup and makes the code overall simpler.
> I don't know if others have strong opinions, I don't often work in
> this code, but I think the patches are worth landing this.
>
> Acked-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian
>
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
