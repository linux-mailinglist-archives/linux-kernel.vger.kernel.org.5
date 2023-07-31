Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE717693FF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGaLAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjGaLAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:00:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D57E40;
        Mon, 31 Jul 2023 04:00:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so6409101a12.2;
        Mon, 31 Jul 2023 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690801212; x=1691406012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0ZOvY/Xpr5zHXbVwVBZloVfJ8G8FuuDZCTbV8z9EOA=;
        b=rH997djt343XybxXVBV+uA0CT9/skZz1zl6AUqtYMfTepAhSK30GnxKvmO4yoKPYYz
         hnjki4wYcBX+3CdzG7u+09ySzk2ZuKO0WR3ynbk46LfhoUGX3BqFkg8WjgNtC4XDI/A4
         hbWVK4ZPCphdTdXL+/Ns+pkjRg5Gaz+2FshCJ51XoVlFmVshuZmyL9sNMIq9yuuNPqPl
         Jms53b74uOPrTI+pxyUusWF6dludQQW/2ZecBGJem6LETbdvQpR4GPmaiHEwSOKQAgEO
         NjEOxgen7eugWN5X6Pa0Jf7fpbDOQmmZ35uW4PYR+xPTGHOfNqQYmHhLr/f+IwPbWLxs
         YBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690801212; x=1691406012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0ZOvY/Xpr5zHXbVwVBZloVfJ8G8FuuDZCTbV8z9EOA=;
        b=MoZ1asJ5565cf+gP1AgS1JfDEBwGPMN2luUoACG7jftQxL5SweeHJ1H4/0j2HiMJIN
         817MZtdlDgU32Zn5GhuDEdMH9D6okij7VCqcTZNH0ZJTGaiwEUK2e7BFfGqHq8jgdVTm
         Km3stGF0cDJebaQqXCgbSmz3I45a9pPL3osIj0qqXaWbY5IebSKV+MtYMIjtcQs3YBVM
         vCN+BdX0sdoXRAP40lgtTLRqfGSaYi+UD8feCamHdF3GrrpvNQmqGhcyHWFbHBZTdCz7
         6tXepb8b9+06WJt9Z5MjKUuwxhutN97jhQZL1Ppzk8ZRYb6eC7DKsXM0ObPrYawDdpl4
         n4Zg==
X-Gm-Message-State: ABy/qLadGyDeRpnvI427EVrt8cGK+zcUzLJFI3AIdRtTDSoWNT0ilSym
        6OdX6KyCG/v9y/snXAUXlA92KaRHQSbHlsb7Mko=
X-Google-Smtp-Source: APBJJlEvzB3AzJ/tG+b0S8KLUVw6iL3Bw2nnGad8E+g1GQ8IQvLcu2BlyGA3ZVDjaEJxmRry1M5WYsjqAZIYec3ZxO0=
X-Received: by 2002:aa7:d745:0:b0:522:289d:8dcd with SMTP id
 a5-20020aa7d745000000b00522289d8dcdmr7624694eds.35.1690801211659; Mon, 31 Jul
 2023 04:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230726121618.19198-1-zegao@tencent.com> <20230726121618.19198-2-zegao@tencent.com>
 <20230731093655.GC29590@hirez.programming.kicks-ass.net>
In-Reply-To: <20230731093655.GC29590@hirez.programming.kicks-ass.net>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Mon, 31 Jul 2023 19:00:00 +0800
Message-ID: <CAD8CoPDvXN6u8uw48UU97bWJgkB0S2qGimAFwhHo9XvWe_x03A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] sched, tracing: add to report task state in
 symbolic chars
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
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

On Mon, Jul 31, 2023 at 5:37=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Jul 26, 2023 at 08:16:16PM +0800, Ze Gao wrote:
> > Internal representations of task state are likely to be changed or
> > ordered, and reporting them to userspace without exporting them as
> > part of API is not a good choice, which can easily break a userspace
> > observability tool as kernel evolves. For example, perf suffers from
> > this and still reports wrong states by this patch.
> >
> > OTOH, some masqueraded state like TASK_REPORT_IDLE and TASK_REPORT_MAX
> > are also reported inadvertently, which confuses things even more.
> >
> > So add a new variable in company with the old raw value to report task
> > state in symbolic char, which is self-explaining and no further
> > translation is needed, and also report priorities in 'short' to save
> > some buffer space.  Of course this does not break any userspace tool.
> >
> > Note for PREEMPT_ACTIVE, we introduce 'p' to report it and use the old
> > conventions for the rest.
>
> So I really dont much like this. This looses the ability to see the
> actual wait state flags, there could be multiple. Eg, things like
> TASK_FREEZEABLE gets lost completely.

Also, IIRC, TASK_FREEZABLE which is defined as 0x2000, is already lost
in the current implementation of __trace_sched_switch_state which limits
all states except PREEMPT_ACTIIVE below TASK_REPORT_IDLE to be
reported. So I do not believe you can achieve this by just leaving things a=
lone.

Regards,
Ze
