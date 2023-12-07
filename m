Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68E1809218
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjLGUOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGUOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:14:30 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7401710
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:14:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso2172a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 12:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701980075; x=1702584875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O59CADGEUW6I15GmJQjsmBYRut0M70PjtjxoPXjvnZo=;
        b=RSHFfBI5cnyPBAa/SOFWl4kamY+bc+MhBa6SZT5PD+BtArkyu8GzGQfm0TsFkhQrgg
         xo1TpZC0ehPnIuR4wHjzVmuj8IaMXOgGvpTR/Hmqyeum5ZB0gCrXtFL/bFn6/bBB84VF
         Kd7C/oK08blnT7GB+/hooPA5XLlaKe6vwGjxAYpNd8YR+caYXYevmO27/9BOvpQglLQG
         1Vb1TImUlmCKiVKnt510ZvjY9iPIZmAMq3+UkOYg1Ag+/YjAMnpl/9TnH84XnYJrJdxz
         4zVZmte6QjiKgDqCUF1FIgTMSLGiMHuwhtI5MvbySHSe8NXDcvZoeSWu7wrNUsdKBDZS
         JjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701980075; x=1702584875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O59CADGEUW6I15GmJQjsmBYRut0M70PjtjxoPXjvnZo=;
        b=Jn2FevPd9rMBT881ZEib3SMNdXCWPWUCjslX4HZHX/e+PcjkFWASdQiC/TQnmljYEC
         7KrpBA29i72laEvxjGwZOTCWiUNApxrEuN3UXfF+UKGt7eCFVd1TDTtrJzw6cvG1XRvp
         DF1ji2Ll+4iACuwi9+ei7y44pjhE95FNcZd9fjZu2yr8+Xm2o0dp95jBKoUGTcSyX0Jz
         +LxuC9TcYwUD79ynVF1lbqdyfYYTQyMmiwqNNhRs3ANBI5U5NhQzBYNJcc51tD+s8n9C
         ykuFa2K7b501NwP/MLgUq86MK1tpwTah1XCIh7R2s0DVBS36tp4TsHIhIeMakyf3oGIX
         pxLA==
X-Gm-Message-State: AOJu0Yzdw/CHfwhqC/DJ26qU4pucU2BPyONzk6v2ZP/h0ZhrjvUi+v+/
        pohNvMt/JMAgO6n04EidhCckLSREx9uyByQ+A1UcIg==
X-Google-Smtp-Source: AGHT+IHKHtr5xE3RkGK0fJwUK612HPcHHmi9TzXyZbEI0xzrbY30jcQXq3kwA1TkT9ayLJiDTy7rskFOTZTnNxoE6f4=
X-Received: by 2002:a50:ccc6:0:b0:54a:ee8b:7a99 with SMTP id
 b6-20020a50ccc6000000b0054aee8b7a99mr17972edj.0.1701980074584; Thu, 07 Dec
 2023 12:14:34 -0800 (PST)
MIME-Version: 1.0
References: <20231128175441.721579-1-namhyung@kernel.org> <CAP-5=fWfKqgT60TFRALw8vTDQT7VFV+0+eo1rFSSH3eVrjzPmA@mail.gmail.com>
 <CAM9d7chKmDETK6Ea2wyR8L21jyHWcPHbKavarnq-JmNA-AoUnQ@mail.gmail.com>
 <CAP-5=fUf6R=bsfg7i8atFApJBY-=zWUBMq7inFsCPZhB+w2==Q@mail.gmail.com>
 <CAM9d7cjDiu=dksnhboJFT4uPQJcvGMB-vBt96v3i7Kqy5LKRMw@mail.gmail.com>
 <CAP-5=fXKbi3DYoOKrJvNKLNU=fJEY9aDAOQhH+Vh+XWxHzGjwA@mail.gmail.com>
 <ZXIiBp-rvdvSI-ZY@kernel.org> <ZXIicbe9K5KYGSV4@kernel.org>
In-Reply-To: <ZXIicbe9K5KYGSV4@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 7 Dec 2023 12:14:23 -0800
Message-ID: <CAP-5=fWN5Jwsf5dxqw0BJxpdu89FM54A-AtQpEqxeE7XLDx3mA@mail.gmail.com>
Subject: Re: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 11:52=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Dec 07, 2023 at 04:50:30PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Tue, Dec 05, 2023 at 09:59:02AM -0800, Ian Rogers escreveu:
> > > On Mon, Dec 4, 2023 at 2:46=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > > > On Thu, Nov 30, 2023 at 10:37=E2=80=AFAM Ian Rogers <irogers@google=
.com> wrote:
> > > > > Sgtm. My point wasn't to criticize, I think this is a good change=
, I
> > > > > was just trying to imagine doing things in a way that could overa=
ll
> > > > > reduce complexity
> >
> > > > Yep, thanks for your review.  Can I get your ACKs? :)
> >
> > > For the series:
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Thanks, applied to perf-tools-next.
>
>
> Now trying to fix this:
>
>   CC      bench/numa.o
>   CC      tests/hists_cumulate.o
> ui/gtk/annotate.c: In function =E2=80=98symbol__gtk_annotate=E2=80=99:
> ui/gtk/annotate.c:179:43: error: passing argument 3 of =E2=80=98symbol__a=
nnotate=E2=80=99 from incompatible pointer type [-Werror=3Dincompatible-poi=
nter-types]
>   179 |         err =3D symbol__annotate(ms, evsel, options, NULL);
>       |                                           ^~~~~~~
>       |                                           |
>       |                                           struct annotation_optio=
ns *
> In file included from ui/gtk/annotate.c:5:
> /home/acme/git/perf-tools-next/tools/perf/util/annotate.h:376:36: note: e=
xpected =E2=80=98struct arch **=E2=80=99 but argument is of type =E2=80=98s=
truct annotation_options *=E2=80=99
>   376 |                      struct arch **parch);
>       |                      ~~~~~~~~~~~~~~^~~~~
> ui/gtk/annotate.c:179:15: error: too many arguments to function =E2=80=98=
symbol__annotate=E2=80=99
>   179 |         err =3D symbol__annotate(ms, evsel, options, NULL);
>       |               ^~~~~~~~~~~~~~~~
> /home/acme/git/perf-tools-next/tools/perf/util/annotate.h:374:5: note: de=
clared here
>   374 | int symbol__annotate(struct map_symbol *ms,
>       |     ^~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>   CC      tests/python-use.o
>   CC      trace/beauty/sockaddr.o
>   CC      arch/x86/util/topdown.o
> make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:1=
05: ui/gtk/annotate.o] Error 1
> make[6]: *** Waiting for unfinished jobs....
>   CC      arch/x86/util/machine.o

Maybe a signal to remove the gtk support :-)

Ian
