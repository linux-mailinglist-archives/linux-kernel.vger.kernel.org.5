Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DC3767364
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjG1R34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjG1R3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:29:40 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213363A84
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:29:34 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-407db3e9669so13111cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690565373; x=1691170173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFPU8SbvYweWy/0B9ZVn/iGNrEhN7Hrca5mOWZOVSiU=;
        b=nEit5NaFSV+d69VnhyIMyDi7ZFOro3SqVLWfk35Rsp2LrpqqOYa11gQbZ1dGhFYZjO
         Afh6VozNEL0ks6qP/Uq8h5Dbc5eJaKnFb2AZhHCKwngdd7KYq+MJkjoFkeFaaGBiJX3H
         4EjbTVeBBlsTq62ugO4uQCYA3Tr7JW7a8emgyx9YqxPfgmqlbfNcj2KNfflSsUMRgYkL
         yENQ2Re/UG/e1i7YlvnWuUuGrDiAmxZGLGbv0tHqm/CWX8cbI016jCyDNP49GxfIfG35
         3x2v1Aq4lLl1ktCUyWnf4NS43oOYW4M4IkVzX91LeYkdN9cWDWMbMsPeOhMqiyHVICPr
         iDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565373; x=1691170173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFPU8SbvYweWy/0B9ZVn/iGNrEhN7Hrca5mOWZOVSiU=;
        b=KDQtn5MGZ1WGRrFv4VZjnWM9laqndqm/rmKbGQja0Vkm2LeI/SgtdFc8coiQe2yoLU
         LcpBk+hy1+TPzuBhqeWxRQgiuB7AT8d7VdMCzTilnSQHL0w9XZPR24nCcZFjpbv+WQtH
         Z0LVuQmfNjk10Q/pT/mT4PysrhM1wf54Xv6er3rVjcHvKzEnSE9AIRU9AW3IdBGePRFz
         /2waqUNwKU+sqixitR/raWZKgjcPbhiK2NqUv3RIcTa8VfKeSTYEiZuU7hNUFMpLE3OW
         Flibbx+Jiee24GnfNSWRSTQnJ5zRTVFor6luCEP41YYrm7dIrgP8ZQjBaGJJKGcibEDB
         z2rQ==
X-Gm-Message-State: ABy/qLaRlQtUUWmjdFIcuCAieFeP8qBW520nRnLAnM/pa3strHXHW8LV
        BKm0P0ZAKE5jotdLM/1mhhV5MXxAa+krjFi+hQCKxg==
X-Google-Smtp-Source: APBJJlG3vkdSXwaK+QDwCWAi4fCSKVsG1lcjeI6l+A0NqIBc3JZ3ilJG1lR+n3Zlckmgqy8iCgjf90vwAh2UPBOumC4=
X-Received: by 2002:a05:622a:1301:b0:403:dcd4:b9b1 with SMTP id
 v1-20020a05622a130100b00403dcd4b9b1mr7450qtk.18.1690565373022; Fri, 28 Jul
 2023 10:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230726121618.19198-1-zegao@tencent.com>
In-Reply-To: <20230726121618.19198-1-zegao@tencent.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 28 Jul 2023 10:29:21 -0700
Message-ID: <CAP-5=fVJ_RL9Md92R4nWBKvZcF9iovL07-=dJ7bqN3LWwufVGw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] report task state in symbolic chars from sched tracepoint
To:     Ze Gao <zegao2021@gmail.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 5:16=E2=80=AFAM Ze Gao <zegao2021@gmail.com> wrote:
>
>
> This is the 2nd attempt to fix the report task state issue in sched
> tracepint, here is the first version:
>
> https://lore.kernel.org/linux-trace-kernel/20230725072254.32045-1-zegao@t=
encent.com
>
> Against v1, add a new var to report task state in symbolic char instead
> of replacing the old one and to not to break anything.
>
> --
>
> In the status quo, we should see three different outcomes of the reported
> sched-out task state from perf-script, perf-sched-timehist, and Tp_printk
> of tracepoint sched_switch.  And it's not hard to figure out that the
> former two are built upon the third one, and the reason why we see this
> inconsistency is that the former two does not catch up with the internal
> change of reported task state definitions as the kernel evolves.
>
> IMHO, exporting internal representations of task state in the tracepoint
> sched_switch is not a good practice and not encouraged at all, which can
> easily break userspace tools that relies on it. Especially when tracepoin=
ts
> are massively used in many observability tools nowadays due to its stable
> nature, which makes them no longer used for debug only purpose and we
> should be careful to decide what ought to be reported to userspace and wh=
at
> ought not.
>
> Therefore, to fix the issues mentioned above for good, instead of choosin=
g
> I proposed to add a new variable to report task state in sched_switch wit=
h
> a symbolic character along with the old hardcoded value, and save the
> further processing of userspace tools and spare them from knowing
> implementation details in the kernel.
>
> After this patch seires, we report 'RSDTtXZPI' the same as in procfs, plu=
s
> a 'p' which denotes PREEMP_ACTIVE and is used for sched_switch tracepoint=
 only.
>
> Reviews welcome!

Thanks Ze,

I think this is worthwhile cleanup and makes the code overall simpler.
I don't know if others have strong opinions, I don't often work in
this code, but I think the patches are worth landing this.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Regards,
>
> Ze
>
> Ze Gao (2):
>   sched, tracing: add to report task state in symbolic chars
>   perf sched: use the new prev_state_char instead in tracepoint
>     sched_switch
>
>  include/trace/events/sched.h | 60 +++++++++++++++++++++---------------
>  tools/perf/builtin-sched.c   | 57 ++++++----------------------------
>  2 files changed, 45 insertions(+), 72 deletions(-)
>
> Ze Gao (1):
>   libtraceevent: use the new prev_state_char instead in tracepoint
>     sched_switch
>
>  plugins/plugin_sched_switch.c | 29 ++++-------------------------
>  1 file changed, 4 insertions(+), 25 deletions(-)
>
> --
> 2.40.1
>
