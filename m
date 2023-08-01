Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E90C76B59E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjHANRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjHANRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:17:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CFFE9;
        Tue,  1 Aug 2023 06:17:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so1059888e87.3;
        Tue, 01 Aug 2023 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690895820; x=1691500620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIXWLmHWaAppS2BxnmUwozE9qzcrfXtbdStzdLC/lgA=;
        b=COYlb4Ga4N1eBlWAcXr7YiqPw4OBJOT0EcO5/bzHq6jKC+4SZUg4RwcUkk65mGgCGr
         LSwXIaq3rCpJ0841e2fgii2K91DtVz+9S4ZOsrHsPiI77c6oQwaW+MYD/mI8roDiLpmR
         iNGWb+sSmBpy2erneqAUBbDZ2bg0/7VRDWp/vljkiNkPtE7kFXqfq4aftuvsIqNyL43y
         1B49mLUy9fKqbWzpLnPwh7Y3DqrNOWTtSB9GPbk6tgRvAomhKW/elZxeDxcAMNUwbUSP
         7jHeGLOANXc9HcB5u9TOGgXkQpBlAF9JMcxCiZ+FapEKrxclrOCNiKFN0t11STAFUhnz
         qeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690895820; x=1691500620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIXWLmHWaAppS2BxnmUwozE9qzcrfXtbdStzdLC/lgA=;
        b=T2+eSGYxZI6f1jQ0FK0UTnGDCGB5bqln9qQedPluRvu+jePvUbiazLWDmpgP+QrU94
         8jXG5ZBTDXt1ay9WKwc5FtQFprkr3LFvXPk2ZJZ0lEmKkb1ABeKp0zSkqVEf9etamtae
         NzsY7RGVbDCCtxhpqH+i/jw9o5IeAmIeGAbZTmLYiGT69L7uM5WE8iCEQRKNBhh4YrXi
         8p0PFcoCmFtZ3FqUl823HRmKNVguwDudOjOb8xdoBQLyis8i+aEfQc8C8sKC3eUvNuih
         arNhrhyF/k2qeE/yzB153HdLv9RRCFmpldifbU2qyjPfgUE1YMWZ3cYIdr/4Lvi+dpSv
         z08A==
X-Gm-Message-State: ABy/qLYBFfsutfkHJu0l4RThlNbKm+GznutNTEH44gFEa3mBm6cRHfEH
        F9+mYFZzjThh0JYxehYB4m3UjUnNBRctZQ4/0EjuxWvFWs0=
X-Google-Smtp-Source: APBJJlEaeifujEnX/crqUtvzVD864qQAiL4PlyAVphNY10MLKwdXfLjV4kSyQfs69RecRyDEtCRnM5vrhQa0JW41zLY=
X-Received: by 2002:ac2:51a1:0:b0:4fd:c715:5667 with SMTP id
 f1-20020ac251a1000000b004fdc7155667mr2000808lfk.20.1690895820122; Tue, 01 Aug
 2023 06:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230801090124.8050-1-zegao@tencent.com> <20230801090124.8050-5-zegao@tencent.com>
 <20230801114650.GE79828@hirez.programming.kicks-ass.net>
In-Reply-To: <20230801114650.GE79828@hirez.programming.kicks-ass.net>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Tue, 1 Aug 2023 21:16:49 +0800
Message-ID: <CAD8CoPCJ0g7CLjQH9NL9bCfiPJqito1XZnitDg1MQOC6=gb=Gg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/6] sched, tracing: reorganize fields of switch
 event struct
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I thought sending this series for RFC is the "effort" you mean
to audit the users :/

Correct me if I'm making stupid moves here and enlighten me what
I should do furthermore to audit the users.

Thanks,
Ze

On Tue, Aug 1, 2023 at 7:47=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Tue, Aug 01, 2023 at 05:01:22PM +0800, Ze Gao wrote:
> > Report priorities in 'short' and prev_state in 'int' to save
> > some buffer space. And also reorder the fields so that we take
> > struct alignment into consideration to make the record compact.
> >
> > Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> I don't see a single line describing the effort you've done to audit
> consumers of this tracepoint.
>
> *IF* you're wanting to break this tracepoint ABI, because seriously
> that's what it is, then you get to invest the time and effort to audit
> the users.
