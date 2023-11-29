Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D94B7FDE33
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjK2RVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjK2RVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:21:20 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64A2133
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:21:25 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bc9893f32so1012e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701278484; x=1701883284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0WD7fcwZghshT6pQtqRNF+fU/TfXoDz5lmg+dpWNqY=;
        b=TMt+sY1y0gZU98aS5T7VlQsd23rxE+ppDeECKYGoJN88+nSkZ/Iva8lT/EEY6PGJc2
         flCcS4hEzb893NaRl8kMKbFKBzlKRORw3EL3VwoT0vGVYRLyAzci87KPSVhfcz6jgt8n
         4glOp4uU6GC3MWEvF311MlN28e8xkJLJU/h12BHcJQ/RwjtuhdNV6MKwgMj9jk+gigja
         UOnhvTZ6QdneXlt8Dbwxvi12mLX/BRR9Y9igWyUYlb8yN3g8417t3SLwaQK1Bdly4DYC
         6qCL4IcmO1dE5DVunck6Oeq4p98mUUHdJQPAuE0r4ApuMo13YWwLGmzUK/1uYaOtDLny
         T35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701278484; x=1701883284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0WD7fcwZghshT6pQtqRNF+fU/TfXoDz5lmg+dpWNqY=;
        b=WI5KY42pZuJhn40cRflPHkKnBjO6ipcKQJBGBcIMdVyHH7KFzrdMWMFAkt9/s7uF+M
         ciDWQfHrePzFzcFRDF8/yvJnS/y+xcusHJu9MHbxT4ZdSYsf6g0pkMWnFrkmjVLNqSIp
         6GIKm2Fa496DYfFIWA+urPMGBUxdcOcR2JycFQHeQj+7/0SlXjmR8+QCB3YuI+bekDrZ
         1Ku5dMW20IrI+vhhiVG4JCKs9+1gc48mJuRTIqIQQHhKGWovPl+Zj1L8meuAOn8nVOC7
         72l7AvXM3bj99gCKB9veLtZ5fSURSzCVDksVgYo5IVX6PhQm+n3MagP+3hY2JzLwMriS
         9Ycw==
X-Gm-Message-State: AOJu0YxsGz36Z/QCIZo+sNMpODbg8QFvqGQeJHI6nPlqyhow5dloOU63
        uNW2XhfOVhnAC14D4Pr2jqgpML3xTG70oBwaSBHGjQ==
X-Google-Smtp-Source: AGHT+IGVV1TGIDxwnNXLYTa0rh72NULVQOapS8AJzg1O7PwjPII7qvDdW/qTKXFLUpdv3kJ9T/l+ukXpSPWQFHaF/DQ=
X-Received: by 2002:a19:ad43:0:b0:504:7b50:ec9a with SMTP id
 s3-20020a19ad43000000b005047b50ec9amr536638lfd.1.1701278483956; Wed, 29 Nov
 2023 09:21:23 -0800 (PST)
MIME-Version: 1.0
References: <20231129081004.1918096-1-irogers@google.com> <20231129081004.1918096-2-irogers@google.com>
 <a54d0a93-aacd-4c69-a34c-8628b0e18ee7@intel.com> <03b314c6-ed6d-ae17-5bc5-0170139f7feb@arm.com>
In-Reply-To: <03b314c6-ed6d-ae17-5bc5-0170139f7feb@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Nov 2023 09:21:12 -0800
Message-ID: <CAP-5=fX7UQGCXp3rqk8bKdevPUH6bnP2hxZ_jktj17YDzkuUDA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf test: Add basic list test
To:     James Clark <james.clark@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 1:27=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 29/11/2023 09:00, Adrian Hunter wrote:
> > On 29/11/23 10:10, Ian Rogers wrote:
> >> Test that json output produces valid json.
> >>
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> >> ---
> >>  tools/perf/tests/shell/list.sh | 29 +++++++++++++++++++++++++++++
> >>  1 file changed, 29 insertions(+)
> >>  create mode 100755 tools/perf/tests/shell/list.sh
> >>
> >> diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/l=
ist.sh
> >> new file mode 100755
> >> index 000000000000..286879a9837a
> >> --- /dev/null
> >> +++ b/tools/perf/tests/shell/list.sh
> >> @@ -0,0 +1,29 @@
> >> +#!/bin/sh
> >> +# perf list tests
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +
> >> +set -e
> >> +err=3D0
> >> +
> >> +if [ "x$PYTHON" =3D=3D "x" ]
> >> +then
> >> +    if which python3 > /dev/null
> >
> > 'which' isn't always present.  Maybe
> >
> > python3 --version >/dev/null 2>&1 && PYTHON=3Dpython3
> >
>
> Now that we have shellcheck integrated into the build, we could enable
> the POSIX mode test which would warn against this usage of which and
> suggest the alternative.
>
> At the moment though there are several other usages of which already in
> the tests. And probably enabling POSIX mode would come with hundreds of
> other warnings to fix.
>
> I'm not saying we shouldn't change this instance though, just adding the
> info for the discussion.

Sounds good to me. Fwiw, the instance where I lifted this code was:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/stat+json_output.sh?h=3Dperf-tools-next#n12

With this change:
```
diff --git a/tools/perf/tests/Makefile.tests b/tools/perf/tests/Makefile.te=
sts
index fdaca5f7a946..06de6d3f4842 100644
--- a/tools/perf/tests/Makefile.tests
+++ b/tools/perf/tests/Makefile.tests
@@ -1,7 +1,7 @@
# SPDX-License-Identifier: GPL-2.0
# Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 2023

-PROGS :=3D $(shell find tests/shell -perm -o=3Dx -type f -name '*.sh')
+PROGS :=3D $(shell find tests/shell -executable -type f -name '*.sh')
FILE_NAME :=3D $(notdir $(PROGS))
FILE_NAME :=3D $(FILE_NAME:%=3D.%)
LOGS :=3D $(join $(dir $(PROGS)),$(FILE_NAME))
```

shellcheck now runs for me. I'll try adding the posix check into the
patch series, as well as fixing other instances I can see.

Thanks,
Ian



> >> +    then
> >> +            PYTHON=3Dpython3
> >> +    elif which python > /dev/null
> >> +    then
> >> +            PYTHON=3Dpython
> >> +    else
> >> +            echo Skipping test, python not detected please set enviro=
nment variable PYTHON.
> >> +            exit 2
> >> +    fi
> >> +fi
> >> +
> >> +test_list_json() {
> >> +  echo "Json output test"
> >> +  perf list -j | $PYTHON -m json.tool
> >> +  echo "Json output test [Success]"
> >> +}
> >> +
> >> +test_list_json
> >> +exit $err
> >
> >
