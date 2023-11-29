Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB387FE224
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjK2ViC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjK2ViB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:38:01 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD7695
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:38:07 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso1013a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701293886; x=1701898686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy/DOxiHYGOEhpK16Bls8GJxdkJJyBiBMP5pgr/S1pE=;
        b=h5QU13l390tViRGxSa68EluVR2+FUcht2vqNklPF6P4G3/DlluLNgDh3WHugkAJdF6
         yM5V0+e5rWLQUfy6++W1EAmVoE+yrVKN8oNtr3f5CNxKC7dgIyTBSAuWP3r+as3k97gM
         RJMAjoEKZuaGWoC7ysMqWnPvTqotKTzN+sJNKzgCHi7pRegsjP+4BRRpIXu+XEvYfFqP
         VoYHZv39qV9iE6p2AaRc91E+D9EhzNzZTbEvQIeJLg12jusyhxDfPTLXF9rwdet1V7eu
         4uUO8UpXPCfmWv4xR8XmW1A1ggwm2teARzAgTnz1+0LxZHzP+st6s93xyq1hJXQ9+O4j
         SABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293886; x=1701898686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy/DOxiHYGOEhpK16Bls8GJxdkJJyBiBMP5pgr/S1pE=;
        b=OKHN+RK82ARKIVX+bbtsVEm7LB8OC49zkxLFiF0gUlWpqfwsTOq/qdWrwTo12y6G7A
         qX7Iw8Js2rMDNRmlAkKZAwdQlcI3+yeTUloE9Dg3aZJIxlZsybgCPu5tq2izYGdgY/Wc
         P9bwKOJA/4OsBgF0JI6gTUHFmWIpqs7FRRiLxzpFcOT16a+gkl7l66GC7BfVGqgE9jHb
         C2AUZ6onH1tPuXa8w1rrVlIsGwfTAiOYlrAuRcqQwVYeOg3l6KOwjddXNAPsvoOpZNNo
         gPeB4CLmRn00mIMd3e/7hq2MtvgYFSYf1QJimsUtZJLpCb+GSTBzm6FprbpM7ayku9sN
         z2gw==
X-Gm-Message-State: AOJu0YwRaF/A8hEoDYfJyRj7tvi2mbLjKnHY4tA+nEvwMVGGv1YffvZw
        CBibXo5gdb1mC5Ia4EfHP2X8x9ixTl9LCXUnOwHZAw==
X-Google-Smtp-Source: AGHT+IFhVjKm0RHfQndiRRFYR19DYkcLgKI6xac3oSakerNml9rp7rFIetEWiJnCQ4M68deGfq+Dspz6+pHC9WpZXz8=
X-Received: by 2002:aa7:c6c1:0:b0:54b:8f42:e3dc with SMTP id
 b1-20020aa7c6c1000000b0054b8f42e3dcmr40148eds.2.1701293885558; Wed, 29 Nov
 2023 13:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20231129081004.1918096-1-irogers@google.com> <20231129081004.1918096-2-irogers@google.com>
 <a54d0a93-aacd-4c69-a34c-8628b0e18ee7@intel.com> <03b314c6-ed6d-ae17-5bc5-0170139f7feb@arm.com>
 <CAP-5=fX7UQGCXp3rqk8bKdevPUH6bnP2hxZ_jktj17YDzkuUDA@mail.gmail.com> <ZWefcAoHBe+GpuiY@kernel.org>
In-Reply-To: <ZWefcAoHBe+GpuiY@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Nov 2023 13:37:53 -0800
Message-ID: <CAP-5=fVZy7R1b7WRaernfddEO-pL72AxsPZ_2C_6nCUYM3KCWg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf test: Add basic list test
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:30=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 29, 2023 at 09:21:12AM -0800, Ian Rogers escreveu:
> > On Wed, Nov 29, 2023 at 1:27=E2=80=AFAM James Clark <james.clark@arm.co=
m> wrote:
> > >
> > >
> > >
> > > On 29/11/2023 09:00, Adrian Hunter wrote:
> > > > On 29/11/23 10:10, Ian Rogers wrote:
> > > >> Test that json output produces valid json.
> > > >>
> > > >> Signed-off-by: Ian Rogers <irogers@google.com>
> > > >> ---
> > > >>  tools/perf/tests/shell/list.sh | 29 +++++++++++++++++++++++++++++
> > > >>  1 file changed, 29 insertions(+)
> > > >>  create mode 100755 tools/perf/tests/shell/list.sh
> > > >>
> > > >> diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/she=
ll/list.sh
> > > >> new file mode 100755
> > > >> index 000000000000..286879a9837a
> > > >> --- /dev/null
> > > >> +++ b/tools/perf/tests/shell/list.sh
> > > >> @@ -0,0 +1,29 @@
> > > >> +#!/bin/sh
> > > >> +# perf list tests
> > > >> +# SPDX-License-Identifier: GPL-2.0
> > > >> +
> > > >> +set -e
> > > >> +err=3D0
> > > >> +
> > > >> +if [ "x$PYTHON" =3D=3D "x" ]
> > > >> +then
> > > >> +    if which python3 > /dev/null
> > > >
> > > > 'which' isn't always present.  Maybe
> > > >
> > > > python3 --version >/dev/null 2>&1 && PYTHON=3Dpython3
> > > >
> > >
> > > Now that we have shellcheck integrated into the build, we could enabl=
e
> > > the POSIX mode test which would warn against this usage of which and
> > > suggest the alternative.
> > >
> > > At the moment though there are several other usages of which already =
in
> > > the tests. And probably enabling POSIX mode would come with hundreds =
of
> > > other warnings to fix.
> > >
> > > I'm not saying we shouldn't change this instance though, just adding =
the
> > > info for the discussion.
> >
> > Sounds good to me. Fwiw, the instance where I lifted this code was:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/stat+json_output.sh?h=3Dperf-tools-next#n12
> >
> > With this change:
> > ```
> > diff --git a/tools/perf/tests/Makefile.tests b/tools/perf/tests/Makefil=
e.tests
> > index fdaca5f7a946..06de6d3f4842 100644
> > --- a/tools/perf/tests/Makefile.tests
> > +++ b/tools/perf/tests/Makefile.tests
> > @@ -1,7 +1,7 @@
> > # SPDX-License-Identifier: GPL-2.0
> > # Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 2023
> >
> > -PROGS :=3D $(shell find tests/shell -perm -o=3Dx -type f -name '*.sh')
> > +PROGS :=3D $(shell find tests/shell -executable -type f -name '*.sh')
> > FILE_NAME :=3D $(notdir $(PROGS))
> > FILE_NAME :=3D $(FILE_NAME:%=3D.%)
> > LOGS :=3D $(join $(dir $(PROGS)),$(FILE_NAME))
> > ```
> >
> > shellcheck now runs for me. I'll try adding the posix check into the
> > patch series, as well as fixing other instances I can see.
>
> So I'll wait for a v2 for this one, ok?

Yep, sent:
https://lore.kernel.org/lkml/20231129213428.2227448-1-irogers@google.com/

There are 2 fixes, one for perf list and the other for the shellcheck
log file building stuff. The shellcheck stuff took a little longer
PTAL.

Thanks,
Ian

> - Arnaldo
