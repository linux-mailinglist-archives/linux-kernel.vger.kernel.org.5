Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAB876C34D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjHBDG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjHBDGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:06:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A208AC;
        Tue,  1 Aug 2023 20:06:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so8954418a12.2;
        Tue, 01 Aug 2023 20:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690945577; x=1691550377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjCa5fCGA5c0sBNIjPzRV62nYHp7nzSq3BtvJOrnO+w=;
        b=By/JMFuxmimrvNsuLjPeoII+8qmCISQMQozt4h6bX/XCX43Gl+TeF6Pwl1Wzc4Fhs4
         Gfb6AOrcHW3IBx+eV+xZPF6Hy6/fAl+7qvpZQ7wgrkxNq7xN3+A6wfzjOf8rzs5wBo3g
         qBK45caShxCjRZFOSorzWd3g8F1rUgBzdgccX5HSV6G267UhGE65Lm00dbDwxxpuPx7z
         MDBZ+UJOjrdgIsSwRNjbN7Y7vNzpyN2CQ/8b0/W3LQNKlmOT4V2Vtea09eRZb9OYIDYu
         hE/VejtErNiOo6PXEtQOUu6czbVeJCvUJn1ElbPZh2DQ9rM0kvZXIaCkWfqS5dmIS0sp
         IASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690945577; x=1691550377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjCa5fCGA5c0sBNIjPzRV62nYHp7nzSq3BtvJOrnO+w=;
        b=WYFHC4rmcHu4H8c9S/FW71DRXR6UFKzWEhtOQIfQxFDgvTiVmmduAcM7p+Lb6XlS/M
         4kBjIY3L3kTODAehOetj7CVt9aVqrlMvOvGtlYHLDOGpvgnDopf+djcWIWeqeyG+GzHl
         uIT4Rvm7hWpQ41pgz2nsy67LzykcygyCRSbMkGKai7CQGo3Hu8CW0khcSKcEkffB4Dlw
         nfCWbZDgxs53DAzZOiPUATe6fugpgYw7Yuc5acB3GkCNrtMpYQDXIX6mmqTLhCdxXE3Z
         SEFtgi8VRoX957QFMYMvDyLnjuJIiSV72Ht7l0jwwcgAKhFwbFx1Mz0a7UEY8TSh+Ziv
         Tyhw==
X-Gm-Message-State: ABy/qLZcwGNXPgNYS9xFgV/qOtPfU7wdlyDJOoXGKpF8MMLOKxBP/LZ/
        Fsvi6t6hXtn7Ls4pkymIgcINFqLkM2K3psKXpIU=
X-Google-Smtp-Source: APBJJlEP1WyNHQeDfzsMH9265DrUPKteZVP8X1+Z7aiKVLN4sw3qDqh3VXfXbkMQEZM3cEvbr4H+//KtSpwod8E8SB8=
X-Received: by 2002:aa7:d293:0:b0:51e:f83:6de6 with SMTP id
 w19-20020aa7d293000000b0051e0f836de6mr4012423edq.16.1690945576747; Tue, 01
 Aug 2023 20:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230801090124.8050-1-zegao@tencent.com> <20230801090124.8050-5-zegao@tencent.com>
 <20230801114650.GE79828@hirez.programming.kicks-ass.net> <20230801103340.5dfa7133@gandalf.local.home>
In-Reply-To: <20230801103340.5dfa7133@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Wed, 2 Aug 2023 11:06:05 +0800
Message-ID: <CAD8CoPAPsCyg=P=pDmzjM3qZt5qcTp7Q=AL2w3_ZwGCnNpgu2g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/6] sched, tracing: reorganize fields of switch
 event struct
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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

Thanks for clarifying this ! Steven. This is really helpful.

Regards,
Ze

On Tue, Aug 1, 2023 at 10:33=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 1 Aug 2023 13:46:50 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > On Tue, Aug 01, 2023 at 05:01:22PM +0800, Ze Gao wrote:
> > > Report priorities in 'short' and prev_state in 'int' to save
> > > some buffer space. And also reorder the fields so that we take
> > > struct alignment into consideration to make the record compact.
> > >
> > > Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> >
> > I don't see a single line describing the effort you've done to audit
> > consumers of this tracepoint.
> >
> > *IF* you're wanting to break this tracepoint ABI, because seriously
> > that's what it is, then you get to invest the time and effort to audit
> > the users.
>
> The known major users that I am aware of is raesdaemon,
> powertop/latencytop, perf, trace-cmd and some bpf tools. The bpf tooling =
is
> known to update per kernel. The others all use libtraceevent that can
> handle this change.
>
> What other tools are there? There's Perfetto, but it also looks at tracef=
s
> to examine where the values are. There's LTTng, but I believe it uses the
> raw tracepoint directly and doesn't look at the layout of the ftrace/perf
> buffers.
>
> All other tooling I am slightly aware of uses libtracefs and libtraceveen=
t,
> as I've been giving many talks on how to use those libraries.
>
> -- Steve
