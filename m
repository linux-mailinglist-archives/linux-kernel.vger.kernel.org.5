Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9E07628D8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGZCsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGZCse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:48:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5023010F8;
        Tue, 25 Jul 2023 19:48:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5221ee899a0so5228727a12.1;
        Tue, 25 Jul 2023 19:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690339710; x=1690944510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkPelLDMNOyH3OdtnOt1tDO5lIdgxwJuRCGnJfwsAPo=;
        b=ogGnr9VM4S0/sUBo0Jp2HGiPHHhFNJSoDNW60S8qONqlLMEeyRvP0VeFFdxcZBp6E7
         fruasZx0fHoeDctQ0s2aV9g6MQ3CjUZSLMAYIgRxxjqOHRTjZ9CjVdtCYljYnk2zgOx5
         hkhIgIuzZ7KWPT43U6bTdr1YigbGOk6AWUuJMWBLSPL43tbqmZl+YpTrv6epTEx4lNUI
         aA2kMQe8WKYl28kGWwCNPnCmgvRmbBo6xkVzf+u5B9/LcJEXgAuoPz57Ij2ZDV2gATqL
         rQCev/5xao6/ik98wttTcCMJP34/F6Aof+g60G+ziJYltc0DTFccOKMMKTS5PUhXaOkS
         I1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690339710; x=1690944510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkPelLDMNOyH3OdtnOt1tDO5lIdgxwJuRCGnJfwsAPo=;
        b=ENy6XGfMw1Du1LmjYteIYYJmSHw9tUrEaCXMiYGCLJY4IzOG6+pnw0wHsyAmGU6Kgg
         IgtNx93gwFr/s6OheJ2v0QAz9f0pYPHeCZtU7ZnPVm9xHeO/z0XJS5GIYPI0pdONxf7e
         lrC4hLpGvzOdzexWjG7yViQHe3+J/EJc/xgMiVIT3eZdPEXLI6vNNWglQ5mAvLEgifCJ
         dud/f7gHRexT4yy0oHcxQ410hBT84DhwcyjePU/xS3UgK713tbcTf+izkDp8yB+tbvPB
         gdlnxfcm1JLExn1XMLRAjRdAA2wLTXs0TqItRx9HI8ptHIUPnxoF/85H2OYchDQhI5eG
         fgEg==
X-Gm-Message-State: ABy/qLY2TVjuVggVuIdjb9phbxFvf7hoPuzq7gUFDhHDuJqFGOLLOE8/
        2qSddVA1sL64HAk68nkRFMK2gVqXAG2CSCCZ0QA=
X-Google-Smtp-Source: APBJJlHtpO+4Uco650H9ikgEM/y0Hm8a4gqM5Cx0CHVOJRgANVZvO8OkuAdLqky8XTbpW35zFwj2Xg/XDTS252FPTpY=
X-Received: by 2002:a05:6402:683:b0:522:2b76:1985 with SMTP id
 f3-20020a056402068300b005222b761985mr443891edy.2.1690339709624; Tue, 25 Jul
 2023 19:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230725072254.32045-1-zegao@tencent.com> <20230725072254.32045-2-zegao@tencent.com>
 <20230725135938.1e056a02@rorschach.local.home> <20230725201603.GB3784071@hirez.programming.kicks-ass.net>
 <20230725175536.5449807c@rorschach.local.home>
In-Reply-To: <20230725175536.5449807c@rorschach.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Wed, 26 Jul 2023 10:48:18 +0800
Message-ID: <CAD8CoPDmHFLMixss1oEk0e-mVYKgwKxt1tXGtFpnwS+Rg-VwBA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] sched, tracing: report task state in symbolic
 chars instead
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
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

I'd like to try this one, and request for another RFC.

Regards,
Ze

On Wed, Jul 26, 2023 at 5:55=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 25 Jul 2023 22:16:03 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > Now, because the old tools still do the parsing of this format, we ca=
n
> > > add a new field called prev_state_char that will give you this. Now t=
o
> > > save space, we should change prev_state to int (can't make it short a=
s
> > > there's that test for "+" which does sometimes happen). I believe we
> > > can make prev_prio and next prio into shorts (and possibly chars!).
> >
> > Or just leave the thing alone?
>
> Sure, but I would like to change the fields to smaller ones just so
> that the event wastes less space on the buffer.
>
> -- Steve
