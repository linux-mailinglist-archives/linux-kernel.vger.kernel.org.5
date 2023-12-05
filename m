Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFAB805B87
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345704AbjLEQxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345227AbjLEQwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:52:49 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F041BDF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:52:17 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50beed2a46eso4241e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 08:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701795136; x=1702399936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozE0cmIttMTLuBosEiNstLlhdhoGcrcDmK/U0m7kOgk=;
        b=SrVz9qloL3NcMjegLB+b4Ub3c5Mv77FCcrKFWDWbwtIL7PV8KZEGO0hKizp/Bao4G2
         etTmXjHUnBkxurelN9rwYi3OdMcGGQXiWVWsMxFeh4wokgIOrvKMlOTGmT12QsAw7oQB
         +dcN5e1oAfwmNbzdZ8nkEguy+vmU6WGPlSDxEz3p/6f8lbrytwROkVFKilcD4+UmL1Ld
         xlQobl0p3SpT5gTpZTKltHcXpYrlIhN3D16pSreJ9fWa1YcH5SVRXXyIEzAS2pacpi8i
         UWt+ME1J5e91Xo1bihirb4Rqj+LtMR1TGpe8W9zpbxlzSuBVxqXoyxZsPCjpLJFsdoax
         55Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701795136; x=1702399936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozE0cmIttMTLuBosEiNstLlhdhoGcrcDmK/U0m7kOgk=;
        b=ffrw9WPKByJ45ZV9k/mjxOSNiDPHqhoRLN57CoakiRG01wI97ExLPH/kW2mZwVP0v/
         KtoPxaGfR8Q8mgkh8Ul6ZFVB7UhMJswPgtz1yG+qJwRS/KtFtepKCN+bpZOODvenocI+
         IgPypaeMcfZJpntQ2X2OIFKyymEOBno7/AImWZTIBwTaU55OcKXCd3nY4Xj2fGk451tt
         U16bXnxc9aUbkZ7G7mkc5PZ2LtpF+xTIVS9pDuLtz2hA+xQXh9ZpDEMS8jDIgcJSaEfV
         IWV9GDbMoJAj6PdV9enA+JG1S2dOoZpST31kzUvfQOntaEOv4BzvFWiekpY4S8zx85Zu
         XbZA==
X-Gm-Message-State: AOJu0YxadRpxQn/ppiDxnYrvZv98uytleknb/AAtemPIhVy/HXA8g4yh
        6vQgapkrPO4n/PAxaDxlOIaqWeZdo3qKQLXahm3ceg==
X-Google-Smtp-Source: AGHT+IE+wE7u8QQbEvQtluoa1AZVMOHmnpR3hpWiRBfsW/QhzK8oHbWpqwTC6AMwds6yXHmd4ulC1VxS4PZ+ftMabEY=
X-Received: by 2002:a05:6512:3d88:b0:50b:fa6c:3e11 with SMTP id
 k8-20020a0565123d8800b0050bfa6c3e11mr186655lfv.6.1701795135616; Tue, 05 Dec
 2023 08:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20231120190408.281826-1-irogers@google.com> <CAP-5=fWvADeeHVQObwk-eVNeOSC=eTTv2q8Rz4j3UtL5-6Getw@mail.gmail.com>
 <ee68f32d-72a2-4e9f-aee1-7c195ad44765@intel.com>
In-Reply-To: <ee68f32d-72a2-4e9f-aee1-7c195ad44765@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 5 Dec 2023 08:52:04 -0800
Message-ID: <CAP-5=fVo+YVAc44Pkes-bXp4Tm605x6RuRi=EdFJeGEEE4iwkQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Add basic perf diff test
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        atrajeev@linux.vnet.ibm.com
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

On Mon, Dec 4, 2023 at 9:44=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 4/12/23 18:00, Ian Rogers wrote:
> > On Mon, Nov 20, 2023 at 11:04=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> >>
> >> There are some old bug reports on perf diff crashing:
> >> https://rhaas.blogspot.com/2012/06/perf-good-bad-ugly.html
> >>
> >> Happening across them I was prompted to add two very basic tests that
> >> will give some perf diff coverage.
> >>
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Ping.
> >
> > Thanks,
> > Ian
> >
> >> ---
> >>  tools/perf/tests/shell/diff.sh | 101 ++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 101 insertions(+)
> >>  create mode 100755 tools/perf/tests/shell/diff.sh
> >>
> >> diff --git a/tools/perf/tests/shell/diff.sh b/tools/perf/tests/shell/d=
iff.sh
> >> new file mode 100755
> >> index 000000000000..213185763688
> >> --- /dev/null
> >> +++ b/tools/perf/tests/shell/diff.sh
> >> @@ -0,0 +1,101 @@
> >> +#!/bin/sh
> >> +# perf diff tests
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +
> >> +set -e
> >> +
> >> +err=3D0
> >> +perfdata1=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> >> +perfdata2=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> >> +perfdata3=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> >> +testprog=3D"perf test -w thloop"
> >> +testsym=3D"test_loop"
>
> Could it benefit from skip_test_missing_symbol

Good idea, sent:
https://lore.kernel.org/lkml/20231205164924.835682-1-irogers@google.com/

Thanks,
Ian
