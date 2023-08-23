Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01736785ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjHWRlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjHWRlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:41:02 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE250E7A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:40:42 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-407db3e9669so19691cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692812442; x=1693417242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzJTuhNrsz6VczjFndY8A/oFd6jwxo4RJUv1lWj5spE=;
        b=QDYn5DwFs6g/OFkCNBnZJjEsg/pRRF24KQ7HLKe5/bBep6N2sihfAcnuQbb20qxejh
         OW1IA8GCSQYYgxAAIu8IPCVI1GLUIRAY7C0+GZTzefsDLnApHWRtVXha4nHLXRc4aYl3
         7qqHliJXbwK2dHY+27x4IODP0UKNQwEsE8sdCETedZymGLJedXtiKJ21oCbL7VThSAP3
         gQ+sdQqFjtdyS/shcQMOQ+YZt9HRILuwgtzyZHBJBDqyoKqwBXB6wC+IkoCJ+2RvzX2E
         WRMURqANne6R+jgNUL0nenVmhwx1C+U97Ra9UvCRumjvYWGc2JC5Ox7iKgdieHxblgP2
         0A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692812442; x=1693417242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzJTuhNrsz6VczjFndY8A/oFd6jwxo4RJUv1lWj5spE=;
        b=k9IuWctBT9/9qpiGr5LUe8kIny0ePAaQNmlNYaGZiDrhWbhOh66h+4GS0J/JrtPiIq
         /dkjN/nHAyaEZa2mxMgk0dsGqlpaQAheUUveFrTxMVByzmwL/Bj0AoKtX0SQ2C+IlJQO
         d/hvQWwStSLINUcn7PjMJvpQneze8zP2sm73CgcTC3bmlTNcf86X4Bzg+QYuGZT+YxIc
         NhaXg6ai3dAj3e1gYQqfwOLD3GzEEtf0CupPIwvUi9V+aui+grMtqJWe7ibfbsU/gjou
         TDHVBaN5g3NtBpL63yrjqlBgN5X/IgG3f1u4astohqJX9K1tAWAX7KiURJAFii3noqeV
         +6aA==
X-Gm-Message-State: AOJu0YxcjYRbLxh3L+RjqVKDXAnWqV3T18XJGxWzeKhcSP9hwJDF1by8
        wHMn+ONBkE60bjwYVYFh8k3/X+2chK1Shhhr94vJ1g==
X-Google-Smtp-Source: AGHT+IFLp2IxuH8zJE7PLcswVE5OaWRyBt/GsOYrQ+qhElOX3ZBtvehI0RJAoOpfQkIynEtEGDpin7XsGm2ujj9ceZM=
X-Received: by 2002:a05:622a:41:b0:40f:db89:5246 with SMTP id
 y1-20020a05622a004100b0040fdb895246mr556992qtw.21.1692812441669; Wed, 23 Aug
 2023 10:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com> <ZOYsLZi44G84IWFk@kernel.org>
 <CAP-5=fXYDMo6GgSaLuC3YMNr66yAXLMyZoAOMpdgmMb=xazCOw@mail.gmail.com> <ZOY9t8W1APC/Hurk@kernel.org>
In-Reply-To: <ZOY9t8W1APC/Hurk@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Aug 2023 10:40:30 -0700
Message-ID: <CAP-5=fUV82BBc6-G5QXrQ0wHeXUNYwxNciVjjG5FizcvtS-7DQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/25] Lazily load PMU data
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 10:11=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Aug 23, 2023 at 09:45:50AM -0700, Ian Rogers escreveu:
> > On Wed, Aug 23, 2023, 8:56 AM Arnaldo Carvalho de Melo <acme@kernel.org=
>
> > wrote:
> >
> > > Em Wed, Aug 23, 2023 at 01:08:03AM -0700, Ian Rogers escreveu:
> > > > Lazily load PMU data both from sysfs and json files. Reorganize
> > > > json data to be more PMU oriented to facilitate this, for
> > > > example, json data is now sorted into arrays for their PMU.
> > > >
> > > > In refactoring the code some changes were made to get rid of maximu=
m
> > > > encoding sizes for events (256 bytes), with input files being direc=
tly
> > > > passed to the lex generated code. There is also a small event parse
> > > > error message improvement.
> > > >
> > > > Some results from an Intel tigerlake laptop running Debian:
> > > >
> > > > Binary size reduction of 1.4% or 143,264 bytes because the PMU
> > > > name no longer appears in the string.
> > > >
> > > > stat -e cpu/cycles/ minor faults reduced from 1733 to 1667, open ca=
lls
> > > reduced
> > > > from 171 to 94.
> > > >
> > > > stat default minor faults reduced from 1085 to 1727, open calls red=
uced
> > > > from 654 to 343.
> > > >
> > > > Average PMU scanning reduced from 4720.641usec to 2927.293usec.
> > > > Average core PMU scanning reduced from 1004.658usec to 232.668usec
> > > > (4.3x faster).
> > >
> > > I'm now chasing this one when building it on ubuntu arm64
> > >
> >
> > I'll fix and send a v2.
>
> Its fixed already, I'm pushing it to tmp.perf-tools-next

Thanks!
Ian

> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util=
/cs-etm.c
> index 7c51fa182b51dab0..b8d6a953fd7423e1 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -79,9 +79,9 @@ static int cs_etm_validate_context_id(struct auxtrace_r=
ecord *itr,
>         int err;
>         u32 val;
>         u64 contextid =3D evsel->core.attr.config &
> -               (perf_pmu__format_bits(&cs_etm_pmu->format, "contextid") =
|
> -                perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1")=
 |
> -                perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2")=
);
> +               (perf_pmu__format_bits(cs_etm_pmu, "contextid") |
> +                perf_pmu__format_bits(cs_etm_pmu, "contextid1") |
> +                perf_pmu__format_bits(cs_etm_pmu, "contextid2"));
>
>         if (!contextid)
>                 return 0;
> @@ -106,7 +106,7 @@ static int cs_etm_validate_context_id(struct auxtrace=
_record *itr,
>         }
>
>         if (contextid &
> -           perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1")) {
> +           perf_pmu__format_bits(cs_etm_pmu, "contextid1")) {
>                 /*
>                  * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextI=
D
>                  * tracing is supported:
> @@ -122,7 +122,7 @@ static int cs_etm_validate_context_id(struct auxtrace=
_record *itr,
>         }
>
>         if (contextid &
> -           perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2")) {
> +           perf_pmu__format_bits(cs_etm_pmu, "contextid2")) {
>                 /*
>                  * TRCIDR2.VMIDOPT[30:29] !=3D 0 and
>                  * TRCIDR2.VMIDSIZE[14:10] =3D=3D 0b00100 (32bit virtual =
contextid)
> @@ -151,7 +151,7 @@ static int cs_etm_validate_timestamp(struct auxtrace_=
record *itr,
>         u32 val;
>
>         if (!(evsel->core.attr.config &
> -             perf_pmu__format_bits(&cs_etm_pmu->format, "timestamp")))
> +             perf_pmu__format_bits(cs_etm_pmu, "timestamp")))
>                 return 0;
>
>         if (!cs_etm_is_etmv4(itr, cpu)) {
