Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D69378DD6B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243819AbjH3Stv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344085AbjH3SAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:00:05 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0976193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 11:00:01 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4036bd4fff1so31131cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693418401; x=1694023201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSQNuNC+nJKncdSv1JlIWKsTQmknhlgUmj3mWVmhEGI=;
        b=cEQAfwAJW1bZZmf0qozfnTxj09hPKlzAWYCFUPcaKb7ZYZTs6kbLN701uN7xyg8tyN
         N8fcBWsHJCzddZuGCKpKzDsE5IPzwRKxDJlrf+LDGzUuieh38fsxuUOXVhYHceTHbViM
         GnrwtpELSQ4CfKs87jJ8Wj6YYbsQ282vhyym9Md1YR8fet0ioHXMhcCuw0kko6orwCDB
         hl5bJCW8AAvIgFw6IYH+WURiprja7P7BlEg8lhym8yf18BRqLG5fA10opmodlEDUR/OW
         BeWAP+3NpmrMDf0AjhiDtS5NODJ5pRPImjmrRs/HuuBtJ/lzcv3NF/+X8Xpx1FOlbp4Y
         uORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693418401; x=1694023201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSQNuNC+nJKncdSv1JlIWKsTQmknhlgUmj3mWVmhEGI=;
        b=XH+BziTpvtw7sozaJ7OCOw6/S0yhJWF72iAo31A/xJXfBv7wqEdcDOoiizsvU+Em9t
         6R9YOw56guRJanS5Wg3VnucwG9zcojeEqPwOqxDr9nB6kK4k+ZI+l+iKx+y1Trw7ttvQ
         8Os2EL37tZZaOuj5AJnk0poHcnewC5TcTkF05xMlTlAviCNx5lYgYXstnnOd+cHs6iJx
         7+fDjhZl2WiClV6KJBtCdaMydgkswZekO2ZPt3OQ80Yf95QV3hyr+xqj29GogdMuN14j
         BYwhhp3EkARxXlT/A4V0Urs3+QgdPwzhAE3ur8cNtAphyCJ/iJJz7LCv7GdaengWAajO
         1Eag==
X-Gm-Message-State: AOJu0YwopuNKY/TX7A6iUGq5i2zQ93HpWnKNVMC6oiMbs4CaCuIKqjnG
        Sgr1U1fKrRK0mGX223uOfvPq4GrgQPOaxrnLC/gqFA==
X-Google-Smtp-Source: AGHT+IF3gFyDSZvEthHza47f5cVqZvPPx/Cbv7vnKCWIgZOxs43aaLiQfgnoqQtlroX4NLtCgp9XOBF9V+FdZe2t2Fc=
X-Received: by 2002:a05:622a:199d:b0:412:7cc4:a0f4 with SMTP id
 u29-20020a05622a199d00b004127cc4a0f4mr15361qtc.8.1693418400692; Wed, 30 Aug
 2023 11:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230816114841.1679234-1-james.clark@arm.com> <20230816114841.1679234-5-james.clark@arm.com>
 <CAP-5=fVZxtgxj62EFNzweNfENVHrc8DwExcUGH-3odz=ZmMrQA@mail.gmail.com> <73b04666-803a-c121-403c-60d67fe44812@arm.com>
In-Reply-To: <73b04666-803a-c121-403c-60d67fe44812@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Aug 2023 10:59:48 -0700
Message-ID: <CAP-5=fVnUx0BnJC7X1rrm42OD7Bk=ZsHWNwAZMBYyB7yWhBfhQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] perf jevents: Add a new expression builtin strcmp_cpuid_str()
To:     James Clark <james.clark@arm.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, renyu.zj@linux.alibaba.com,
        acme@kernel.org, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:15=E2=80=AFAM James Clark <james.clark@arm.com> =
wrote:
>
>
>
> On 30/08/2023 00:46, Ian Rogers wrote:
> > On Wed, Aug 16, 2023 at 4:52=E2=80=AFAM James Clark <james.clark@arm.co=
m> wrote:
> >>
> >> This will allow writing formulas that are conditional on a specific
> >> CPU type or CPU version. It calls through to the existing
> >> strcmp_cpuid_str() function in Perf which has a default weak version,
> >> and an arch specific version for x86 and arm64.
> >>
> >> The function takes an 'ID' type value, which is a string. But in this
> >> case Arm CPU IDs are hex numbers prefixed with '0x'. metric.py
> >> assumes strings are only used by event names, and that they can't star=
t
> >> with a number ('0'), so an additional change has to be made to the
> >> regex to convert hex numbers back to 'ID' types.
> >>
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> ---
> >>  tools/perf/arch/arm64/util/pmu.c | 18 +-----------------
> >>  tools/perf/pmu-events/metric.py  | 17 +++++++++++++++--
> >>  tools/perf/util/expr.c           | 18 ++++++++++++++++++
> >>  tools/perf/util/expr.h           |  1 +
> >>  tools/perf/util/expr.l           |  1 +
> >>  tools/perf/util/expr.y           |  8 +++++++-
> >>  tools/perf/util/pmu.c            | 17 +++++++++++++++++
> >>  tools/perf/util/pmu.h            |  1 +
> >>  8 files changed, 61 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/=
util/pmu.c
> >> index 512a8f13c4de..615084eb88d8 100644
> >> --- a/tools/perf/arch/arm64/util/pmu.c
> >> +++ b/tools/perf/arch/arm64/util/pmu.c
> >> @@ -2,28 +2,12 @@
> >>
> >>  #include <internal/cpumap.h>
> >>  #include "../../../util/cpumap.h"
> >> +#include "../../../util/header.h"
> >>  #include "../../../util/pmu.h"
> >>  #include "../../../util/pmus.h"
> >>  #include <api/fs/fs.h>
> >>  #include <math.h>
> >>
> >> -static struct perf_pmu *pmu__find_core_pmu(void)
> >> -{
> >> -       struct perf_pmu *pmu =3D NULL;
> >> -
> >> -       while ((pmu =3D perf_pmus__scan_core(pmu))) {
> >> -               /*
> >> -                * The cpumap should cover all CPUs. Otherwise, some C=
PUs may
> >> -                * not support some events or have different event IDs=
.
> >> -                */
> >> -               if (RC_CHK_ACCESS(pmu->cpus)->nr !=3D cpu__max_cpu().c=
pu)
> >> -                       return NULL;
> >> -
> >> -               return pmu;
> >> -       }
> >> -       return NULL;
> >> -}
> >> -
> >>  const struct pmu_metrics_table *pmu_metrics_table__find(void)
> >>  {
> >>         struct perf_pmu *pmu =3D pmu__find_core_pmu();
> >> diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/m=
etric.py
> >> index 85a3545f5b6a..0e9ec65d92ae 100644
> >> --- a/tools/perf/pmu-events/metric.py
> >> +++ b/tools/perf/pmu-events/metric.py
> >> @@ -413,6 +413,10 @@ def has_event(event: Event) -> Function:
> >>    # pylint: disable=3Dinvalid-name
> >>    return Function('has_event', event)
> >>
> >> +def strcmp_cpuid_str(event: str) -> Function:
> >> +  # pylint: disable=3Dredefined-builtin
> >> +  # pylint: disable=3Dinvalid-name
> >> +  return Function('strcmp_cpuid_str', event)
> >>
> >>  class Metric:
> >>    """An individual metric that will specifiable on the perf command l=
ine."""
> >> @@ -541,14 +545,23 @@ def ParsePerfJson(orig: str) -> Expression:
> >>    """
> >>    # pylint: disable=3Deval-used
> >>    py =3D orig.strip()
> >> +  # First try to convert everything that looks like a string (event n=
ame) into Event(r"EVENT_NAME").
> >> +  # This isn't very selective so is followed up by converting some un=
wanted conversions back again
> >>    py =3D re.sub(r'([a-zA-Z][^-+/\* \\\(\),]*(?:\\.[^-+/\* \\\(\),]*)*=
)',
> >>                r'Event(r"\1")', py)
> >> +  # If it started with a # it should have been a literal, rather than=
 an event name
> >>    py =3D re.sub(r'#Event\(r"([^"]*)"\)', r'Literal("#\1")', py)
> >> +  # Convert accidentally converted hex constants ("0Event(r"xDEADBEEF=
)"") back to a constant,
> >> +  # but keep it wrapped in Event(), otherwise Python drops the 0x pre=
fix and it gets interpreted as
> >> +  # a double by the Bison parser
> >> +  py =3D re.sub(r'0Event\(r"[xX]([0-9a-fA-F]*)"\)', r'Event("0x\1")',=
 py)
> >> +  # Convert accidentally converted scientific notation constants back
> >>    py =3D re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
> >> -  keywords =3D ['if', 'else', 'min', 'max', 'd_ratio', 'source_count'=
, 'has_event']
> >> +  # Convert all the known keywords back from events to just the keywo=
rd
> >> +  keywords =3D ['if', 'else', 'min', 'max', 'd_ratio', 'source_count'=
, 'has_event', 'strcmp_cpuid_str',
> >> +              'cpuid_not_more_than']
> >>    for kw in keywords:
> >>      py =3D re.sub(rf'Event\(r"{kw}"\)', kw, py)
> >> -
> >>    try:
> >>      parsed =3D ast.parse(py, mode=3D'eval')
> >>    except SyntaxError as e:
> >> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> >> index 7410a165f68b..0985a3cbc6f9 100644
> >> --- a/tools/perf/util/expr.c
> >> +++ b/tools/perf/util/expr.c
> >> @@ -13,6 +13,8 @@
> >>  #include <util/expr-bison.h>
> >>  #include <util/expr-flex.h>
> >>  #include "util/hashmap.h"
> >> +#include "util/header.h"
> >> +#include "util/pmu.h"
> >>  #include "smt.h"
> >>  #include "tsc.h"
> >>  #include <api/fs/fs.h>
> >> @@ -495,3 +497,19 @@ double expr__has_event(const struct expr_parse_ct=
x *ctx, bool compute_ids, const
> >>         evlist__delete(tmp);
> >>         return ret;
> >>  }
> >> +
> >> +double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx __mayb=
e_unused,
> >> +                      bool compute_ids __maybe_unused, const char *te=
st_id)
> >> +{
> >> +       double ret;
> >> +       struct perf_pmu *pmu =3D pmu__find_core_pmu();
> >> +       char *cpuid =3D perf_pmu__getcpuid(pmu);
> >> +
> >> +       if (!cpuid)
> >> +               return NAN;
> >> +
> >> +       ret =3D !strcmp_cpuid_str(test_id, cpuid);
> >> +
> >> +       free(cpuid);
> >> +       return ret;
> >> +}
> >> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> >> index 3c1e49b3e35d..c0cec29ddc29 100644
> >> --- a/tools/perf/util/expr.h
> >> +++ b/tools/perf/util/expr.h
> >> @@ -55,5 +55,6 @@ double expr_id_data__value(const struct expr_id_data=
 *data);
> >>  double expr_id_data__source_count(const struct expr_id_data *data);
> >>  double expr__get_literal(const char *literal, const struct expr_scann=
er_ctx *ctx);
> >>  double expr__has_event(const struct expr_parse_ctx *ctx, bool compute=
_ids, const char *id);
> >> +double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx, bool =
compute_ids, const char *id);
> >>
> >>  #endif
> >> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> >> index dbb117414710..0feef0726c48 100644
> >> --- a/tools/perf/util/expr.l
> >> +++ b/tools/perf/util/expr.l
> >> @@ -114,6 +114,7 @@ if          { return IF; }
> >>  else           { return ELSE; }
> >>  source_count   { return SOURCE_COUNT; }
> >>  has_event      { return HAS_EVENT; }
> >> +strcmp_cpuid_str       { return STRCMP_CPUID_STR; }
> >
> > For the sake of coverage, it'd be nice to have a test case like:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/expr.c?h=3Dtmp.perf-tools-next#n257
> >
> >>  {literal}      { return literal(yyscanner, sctx); }
> >>  {number}       { return value(yyscanner); }
> >>  {symbol}       { return str(yyscanner, ID, sctx->runtime); }
> >> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> >> index 65d54a6f29ad..6c93b358cc2d 100644
> >> --- a/tools/perf/util/expr.y
> >> +++ b/tools/perf/util/expr.y
> >> @@ -39,7 +39,7 @@ int expr_lex(YYSTYPE * yylval_param , void *yyscanne=
r);
> >>         } ids;
> >>  }
> >>
> >> -%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT HAS_EVE=
NT EXPR_ERROR
> >> +%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT HAS_EVE=
NT STRCMP_CPUID_STR EXPR_ERROR
> >>  %left MIN MAX IF
> >>  %left '|'
> >>  %left '^'
> >> @@ -207,6 +207,12 @@ expr: NUMBER
> >>         $$.ids =3D NULL;
> >>         free($3);
> >>  }
> >> +| STRCMP_CPUID_STR '(' ID ')'
> >> +{
> >> +       $$.val =3D expr__strcmp_cpuid_str(ctx, compute_ids, $3);
> >> +       $$.ids =3D NULL;
> >> +       free($3);
> >> +}
> >>  | expr '|' expr
> >>  {
> >>         if (is_const($1.val) && is_const($3.val)) {
> >> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> >> index d5406effc169..a7f05e4dda97 100644
> >> --- a/tools/perf/util/pmu.c
> >> +++ b/tools/perf/util/pmu.c
> >> @@ -1790,3 +1790,20 @@ void perf_pmu__delete(struct perf_pmu *pmu)
> >>         zfree(&pmu->alias_name);
> >>         free(pmu);
> >>  }
> >> +
> >> +struct perf_pmu *pmu__find_core_pmu(void)
> >
> > I think as this is scanning all PMUs it more logically belongs in
> > pmus.c than pmu.c.
> >
> >> +{
> >> +       struct perf_pmu *pmu =3D NULL;
> >> +
> >> +       while ((pmu =3D perf_pmus__scan_core(pmu))) {
> >> +               /*
> >> +                * The cpumap should cover all CPUs. Otherwise, some C=
PUs may
> >> +                * not support some events or have different event IDs=
.
> >> +                */
> >> +               if (RC_CHK_ACCESS(pmu->cpus)->nr !=3D cpu__max_cpu().c=
pu)
> >
> > The RC_CHK_ACCESS can be avoided using perf_cpu_map__nr.
> >
> > Not all CPUs need to be online. I think the number for the PMU is
> > bound by the number online while cpu__max_cpu gives the maximum
> > present. It is common to workaround SMT vulnerabilities by making
> > cores offline in which case this would never be true. I think the
> > following is nearly equivalent and simpler:
> >
> > perf_pmus__num_core_pmus > 1 ? NULL : perf_pmus__scan_core(NULL);
> >
>
> I'm not sure about this one, I'm hesitant to change it because I only
> moved it out of the arm file and into the generic one and it seems like
> it could cause subtle issues.
>
> From the comment above the if statement, it seems like it intentionally
> refuses to return a PMU on heterogeneous systems, and the original
> commit message (e126bef55f1d) from John lines up with that too. I can't
> see exactly why it should be like that though.
>
> Although you could say that now I've pulled some Arm specific quirk into
> the generic code and we should re-think it. To me I don't see why it
> doesn't just unconditionally return the first core PMU it finds on any
> architecture, but I'd like to understand the original intention first.
>
> Apart from this one, I've done the other changes and will send patches.

Even on a homogeneous ARM system this will always return NULL/NAN if a
core is taken offline. We didn't used to count core PMUs, so the
approach I proposed wouldn't have been possible previously.

Thanks,
Ian

> > Thanks,
> > Ian
> >
> >> +                       return NULL;
> >> +
> >> +               return pmu;
> >> +       }
> >> +       return NULL;
> >> +}
> >> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> >> index 6b414cecbad2..7ff925224165 100644
> >> --- a/tools/perf/util/pmu.h
> >> +++ b/tools/perf/util/pmu.h
> >> @@ -289,5 +289,6 @@ int perf_pmu__pathname_fd(int dirfd, const char *p=
mu_name, const char *filename,
> >>  struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, =
const char *lookup_name);
> >>  struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_he=
ad *core_pmus);
> >>  void perf_pmu__delete(struct perf_pmu *pmu);
> >> +struct perf_pmu *pmu__find_core_pmu(void);
> >>
> >>  #endif /* __PMU_H */
> >> --
> >> 2.34.1
> >>
