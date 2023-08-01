Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D176F76B57D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjHANJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjHANJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:09:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5741AA;
        Tue,  1 Aug 2023 06:09:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso9327917e87.2;
        Tue, 01 Aug 2023 06:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690895346; x=1691500146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSYDgSBr6VIvVqvgbXgY8DPNQYD4uXETQ2T5A74Rvsc=;
        b=F6nEL7Ho556Dfk2exHEr29Vo4qtyJkXFQPcNlQNpma4SmTaGFLvLCXPC305sLsnfBQ
         j9KENhvnNsi8lsOX1YhfASfk4tcChhBOxzA/4mK6+BfQR/5n0sNQ9It1S1XTQWfYeCC2
         GQGW317tfBsKC57mj+Igu5MT9BK3S4CRxtrDuSK7YjT8xiWiJrwbCGHGOPvIsJOYoUwZ
         DpeNqh6LiFHQx4p9b6TkynfMeZ8+v+9Iayty8s07vF5tRzmJ66piCInNWIipHM+VhohQ
         osIVp+zKPleVbLNbRewe2JfP9IuVpsCyIeoe5oU8mPlTy3EyMsAj11Q4ZZGrFzW00Ej8
         WApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690895346; x=1691500146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSYDgSBr6VIvVqvgbXgY8DPNQYD4uXETQ2T5A74Rvsc=;
        b=Awrw1LI17ZVnsIrK5jIkWZpd78lCOtKf5Um1TRlvoMmgoGEN/1pIof0pQ3Y8rTPWYP
         UiIUyPvwnBSsVAy8dPDUuJdSlkxCs2VUHmcIiHESFDuxSNVfRL5BPpbpZNGX2PH7mmYh
         Ypux0BD8HZ86qgnUg5CBZ7j8fCVURabPFCyxXmcd4NDGKMs1Pzz010Y6lwiL9wLsJwjv
         KiaxaXHc3N+jJJZJPShWHNhYBqQTABeoxueiFddo3jKbxE0GXBVezrgFOG+iz9GDMk5I
         SsuMai0oWCHcjLa2YZSyyrgqqe91U8oaf2XwmAxJ2WQrUHW9gF1ijP86WbDifSmuJFp4
         BioA==
X-Gm-Message-State: ABy/qLbJkYK48r1XMk4wwW/glG2HT1ZhcZq0Fi3QcDNh18adjINIvsv0
        EaFR3nZBzvigr3r/qF4Y8x0DD3NZHn/ZIJsy6SQ=
X-Google-Smtp-Source: APBJJlEPgm+rKFREoqAK7tMrKT/g94LHucm846vevp2vNaEkwbHbMtUMiipJXA5+QCwFlxd7fXsqJA09oNOrvVNG4y8=
X-Received: by 2002:a05:6512:612:b0:4fb:89cd:9616 with SMTP id
 b18-20020a056512061200b004fb89cd9616mr2140636lfe.0.1690895345745; Tue, 01 Aug
 2023 06:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230801090124.8050-1-zegao@tencent.com> <20230801090124.8050-4-zegao@tencent.com>
 <20230801114545.GD79828@hirez.programming.kicks-ass.net>
In-Reply-To: <20230801114545.GD79828@hirez.programming.kicks-ass.net>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Tue, 1 Aug 2023 21:08:54 +0800
Message-ID: <CAD8CoPBb7-j7RLggWfu+Y-bmb_VW_0O46MyH35vWL=24C3Tndw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/6] sched, tracing: add to report task state in
 symbolic chars
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

Sorry that I don't get this one, did you mean kernel subsystems like
bpf or third party modules?  Honestly I don't know how it works here
for userspace to consume the raw tracepoint without looking at
tracefs.

Regards,
Ze

On Tue, Aug 1, 2023 at 7:46=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Tue, Aug 01, 2023 at 05:01:21PM +0800, Ze Gao wrote:
> > @@ -233,6 +255,7 @@ TRACE_EVENT(sched_switch,
> >               __field(        pid_t,  prev_pid                        )
> >               __field(        int,    prev_prio                       )
> >               __field(        long,   prev_state                      )
> > +             __field(        char,   prev_state_char                 )
> >               __array(        char,   next_comm,      TASK_COMM_LEN   )
> >               __field(        pid_t,  next_pid                        )
> >               __field(        int,    next_prio                       )
>
> And this again will wreck everybody that consumes the raw tracepoint
> without looking at tracefs.
