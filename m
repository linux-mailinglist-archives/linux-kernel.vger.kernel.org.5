Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2C57D7AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjJZCNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZCNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:13:15 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328BE12F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:13:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507c9305727so843e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698286391; x=1698891191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z36Xa2wceQFeKAxpFjwnpPznj0rOATWn2poikjqJb14=;
        b=fiC5zBi7bHqUzTOld+VUo3pP23dsdDPKsfPI9Xef/ysJt7OnriArzPUM7GeuVUmMuk
         tTHetjZ6VYblt/jCWZaKHAEgqgtYW4Pb3eci12E3/xToU+STGgabl0tSxC7kcSiz9eTa
         tdFIeChbiJhX06+Rw/jftG0YSvh2YBMVrb8Z9u5cj0CJiY9Tu9kcecH5tFzefW62jIJL
         ee+wAYdGwC+lwre7gffRxLC5uyzuOwETq/ZQgCOXBQ4o4Tk9lJhiN6ZB2kJZAwiMvnrB
         gXHL37/ZmkCV9XQ9m+W3r8Oxs5SoAJetCGCPPsv3GkhSNf4hQUqdg7sSYWGjKNlzSYBQ
         mKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698286391; x=1698891191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z36Xa2wceQFeKAxpFjwnpPznj0rOATWn2poikjqJb14=;
        b=bIWFKj01wwd6mbfh1l9u8cjMYUBpP/I8n4lOB8gyLeiIaTCQNcPZSIIpkLX4mEpWXH
         UPTx4GHfr5Sf0JRPhWQtlXkXIJSPbxSSM60C1MAN5NEc/E+2JOQ34H078fDwGIWj+b+A
         lkwWa7F9GClwLDdm1e9HXxPtRyTH6U85bUxWX9ZteJAGYMnhO7F8n1QOuDByGKXptz5I
         ci9xQnV1U/dL6yLEIjFc2g+taQ3vxd8JGyb4Ydgl3RHK3P/ASka6L22IklhHKv8R/DYV
         qEelGp2HLRmZwb9vio0JiS53RETrsuebfYBST37MF56jSbTqWOmAviEq+nwFb3zvTUQK
         S8xA==
X-Gm-Message-State: AOJu0Yx/cO7E1cpComgadmx5FEEuu25adkN+BbRpcxUt4hmxotm0s0WR
        aG70D11SL/rWRVWHRI6+ICXW8qTqLYwajtLWDlEfuQ==
X-Google-Smtp-Source: AGHT+IG5GmQwT8V2g29sDvxBcL1bOCihBa+NoHO47hpk+1xkLuxcNIJVpGe8fOExfNxz0pS6yZOu6G4tP8z7Jw4pxQE=
X-Received: by 2002:a05:6512:748:b0:505:715f:d36b with SMTP id
 c8-20020a056512074800b00505715fd36bmr118750lfs.5.1698286391229; Wed, 25 Oct
 2023 19:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231025201626.3000228-1-kan.liang@linux.intel.com> <20231025201626.3000228-8-kan.liang@linux.intel.com>
In-Reply-To: <20231025201626.3000228-8-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 Oct 2023 19:12:59 -0700
Message-ID: <CAP-5=fUjVAk7+2EocoX5pvMKaQ2+Y_quW7p4840=L-mRT_CtXg@mail.gmail.com>
Subject: Re: [PATCH V5 8/8] perf tools: Add branch counter knob
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, ak@linux.intel.com,
        eranian@google.com, alexey.v.bayduraev@linux.intel.com,
        tinghao.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 1:16=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Add a new branch filter, "counter", for the branch counter option. It is
> used to mark the events which should be logged in the branch. If it is
> applied with the -j option, the counters of all the events should be
> logged in the branch. If the legacy kernel doesn't support the new
> branch sample type, switching off the branch counter filter.
>
> The stored counter values in each branch are displayed right after the
> regular branch stack information via perf report -D.
>
> Usage examples:
>
> perf record -e "{branch-instructions,branch-misses}:S" -j any,counter
>
> Only the first event, branch-instructions, collect the LBR. Both
> branch-instructions and branch-misses are marked as logged events.
> The occurrences information of them can be found in the branch stack
> extension space of each branch.
>
> perf record -e "{cpu/branch-instructions,branch_type=3Dany/,
> cpu/branch-misses,branch_type=3Dcounter/}"
>
> Only the first event, branch-instructions, collect the LBR. Only the
> branch-misses event is marked as a logged event.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Perhaps add a test somewhere like:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/record.sh
for coverage when hardware supports the feature.

Thanks,
Ian

> ---
>
> No changes since V4
>
>  tools/perf/Documentation/perf-record.txt  |  4 +++
>  tools/perf/util/evsel.c                   | 31 ++++++++++++++++++++++-
>  tools/perf/util/evsel.h                   |  1 +
>  tools/perf/util/parse-branch-options.c    |  1 +
>  tools/perf/util/perf_event_attr_fprintf.c |  1 +
>  tools/perf/util/sample.h                  |  1 +
>  tools/perf/util/session.c                 | 15 +++++++++--
>  7 files changed, 51 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Docume=
ntation/perf-record.txt
> index d5217be012d7..b6afe7cc948d 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -442,6 +442,10 @@ following filters are defined:
>                      4th-Gen Xeon+ server), the save branch type is uncon=
ditionally enabled
>                      when the taken branch stack sampling is enabled.
>         - priv: save privilege state during sampling in case binary is no=
t available later
> +       - counter: save occurrences of the event since the last branch en=
try. Currently, the
> +                  feature is only supported by a newer CPU, e.g., Intel =
Sierra Forest and
> +                  later platforms. An error out is expected if it's used=
 on the unsupported
> +                  kernel or CPUs.
>
>  +
>  The option requires at least one branch type among any, any_call, any_re=
t, ind_call, cond.
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a8a5ff87cc1f..58a9b8c82790 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1831,6 +1831,8 @@ static int __evsel__prepare_open(struct evsel *evse=
l, struct perf_cpu_map *cpus,
>
>  static void evsel__disable_missing_features(struct evsel *evsel)
>  {
> +       if (perf_missing_features.branch_counters)
> +               evsel->core.attr.branch_sample_type &=3D ~PERF_SAMPLE_BRA=
NCH_COUNTERS;
>         if (perf_missing_features.read_lost)
>                 evsel->core.attr.read_format &=3D ~PERF_FORMAT_LOST;
>         if (perf_missing_features.weight_struct) {
> @@ -1884,7 +1886,12 @@ bool evsel__detect_missing_features(struct evsel *=
evsel)
>          * Must probe features in the order they were added to the
>          * perf_event_attr interface.
>          */
> -       if (!perf_missing_features.read_lost &&
> +       if (!perf_missing_features.branch_counters &&
> +           (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COU=
NTERS)) {
> +               perf_missing_features.branch_counters =3D true;
> +               pr_debug2("switching off branch counters support\n");
> +               return true;
> +       } else if (!perf_missing_features.read_lost &&
>             (evsel->core.attr.read_format & PERF_FORMAT_LOST)) {
>                 perf_missing_features.read_lost =3D true;
>                 pr_debug2("switching off PERF_FORMAT_LOST support\n");
> @@ -2344,6 +2351,18 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
>         return new_val;
>  }
>
> +static inline bool evsel__has_branch_counters(const struct evsel *evsel)
> +{
> +       struct evsel *cur, *leader =3D evsel__leader(evsel);
> +
> +       evlist__for_each_entry(evsel->evlist, cur) {
> +               if ((leader =3D=3D evsel__leader(cur)) &&
> +                   (cur->core.attr.branch_sample_type & PERF_SAMPLE_BRAN=
CH_COUNTERS))
> +                       return true;
> +       }
> +       return false;
> +}
> +
>  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>                         struct perf_sample *data)
>  {
> @@ -2577,6 +2596,16 @@ int evsel__parse_sample(struct evsel *evsel, union=
 perf_event *event,
>
>                 OVERFLOW_CHECK(array, sz, max_size);
>                 array =3D (void *)array + sz;
> +
> +               if (evsel__has_branch_counters(evsel)) {
> +                       OVERFLOW_CHECK_u64(array);
> +
> +                       data->branch_stack_cntr =3D (u64 *)array;
> +                       sz =3D data->branch_stack->nr * sizeof(u64);
> +
> +                       OVERFLOW_CHECK(array, sz, max_size);
> +                       array =3D (void *)array + sz;
> +               }
>         }
>
>         if (type & PERF_SAMPLE_REGS_USER) {
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 848534ec74fa..85f24c986392 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -191,6 +191,7 @@ struct perf_missing_features {
>         bool code_page_size;
>         bool weight_struct;
>         bool read_lost;
> +       bool branch_counters;
>  };
>
>  extern struct perf_missing_features perf_missing_features;
> diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/par=
se-branch-options.c
> index fd67d204d720..f7f7aff3d85a 100644
> --- a/tools/perf/util/parse-branch-options.c
> +++ b/tools/perf/util/parse-branch-options.c
> @@ -36,6 +36,7 @@ static const struct branch_mode branch_modes[] =3D {
>         BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
>         BRANCH_OPT("hw_index", PERF_SAMPLE_BRANCH_HW_INDEX),
>         BRANCH_OPT("priv", PERF_SAMPLE_BRANCH_PRIV_SAVE),
> +       BRANCH_OPT("counter", PERF_SAMPLE_BRANCH_COUNTERS),
>         BRANCH_END
>  };
>
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/=
perf_event_attr_fprintf.c
> index 2247991451f3..8f04d3b7f3ec 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -55,6 +55,7 @@ static void __p_branch_sample_type(char *buf, size_t si=
ze, u64 value)
>                 bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
>                 bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
>                 bit_name(TYPE_SAVE), bit_name(HW_INDEX), bit_name(PRIV_SA=
VE),
> +               bit_name(COUNTERS),
>                 { .name =3D NULL, }
>         };
>  #undef bit_name
> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> index c92ad0f51ecd..70b2c3135555 100644
> --- a/tools/perf/util/sample.h
> +++ b/tools/perf/util/sample.h
> @@ -113,6 +113,7 @@ struct perf_sample {
>         void *raw_data;
>         struct ip_callchain *callchain;
>         struct branch_stack *branch_stack;
> +       u64 *branch_stack_cntr;
>         struct regs_dump  user_regs;
>         struct regs_dump  intr_regs;
>         struct stack_dump user_stack;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 1e9aa8ed15b6..4a094ab0362b 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1150,9 +1150,13 @@ static void callchain__printf(struct evsel *evsel,
>                        i, callchain->ips[i]);
>  }
>
> -static void branch_stack__printf(struct perf_sample *sample, bool callst=
ack)
> +static void branch_stack__printf(struct perf_sample *sample,
> +                                struct evsel *evsel)
>  {
>         struct branch_entry *entries =3D perf_sample__branch_entries(samp=
le);
> +       bool callstack =3D evsel__has_branch_callstack(evsel);
> +       u64 *branch_stack_cntr =3D sample->branch_stack_cntr;
> +       struct perf_env *env =3D evsel__env(evsel);
>         uint64_t i;
>
>         if (!callstack) {
> @@ -1194,6 +1198,13 @@ static void branch_stack__printf(struct perf_sampl=
e *sample, bool callstack)
>                         }
>                 }
>         }
> +
> +       if (branch_stack_cntr) {
> +               printf("... branch stack counters: nr:%" PRIu64 " (counte=
r width: %u max counter nr:%u)\n",
> +                       sample->branch_stack->nr, env->br_cntr_width, env=
->br_cntr_nr);
> +               for (i =3D 0; i < sample->branch_stack->nr; i++)
> +                       printf("..... %2"PRIu64": %016" PRIx64 "\n", i, b=
ranch_stack_cntr[i]);
> +       }
>  }
>
>  static void regs_dump__printf(u64 mask, u64 *regs, const char *arch)
> @@ -1355,7 +1366,7 @@ static void dump_sample(struct evsel *evsel, union =
perf_event *event,
>                 callchain__printf(evsel, sample);
>
>         if (evsel__has_br_stack(evsel))
> -               branch_stack__printf(sample, evsel__has_branch_callstack(=
evsel));
> +               branch_stack__printf(sample, evsel);
>
>         if (sample_type & PERF_SAMPLE_REGS_USER)
>                 regs_user__printf(sample, arch);
> --
> 2.35.1
>
