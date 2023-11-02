Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A34D7DFCC6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377552AbjKBW70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377540AbjKBW7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:59:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FF1193
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:59:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so2347a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698965959; x=1699570759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP31fLX+pxaO5hDZO6DHoxgvhUAHCcHqxZGWN/MwNfQ=;
        b=JHaMZxzzpF1Cn1yV/IA/F6iFUVhaXwA2p/OVH7ugye6yb3i9Ari5JBkjeNPBPfO5cT
         Fh2qxB8sJjjHk42A+Kg1i+UoTGzywh4EM3x+r0JuYXg3BjaFWjinvVx8b3AT7vQWPoTP
         m2p3YJsaHX2wIAoLRuCwMtO6NHiARKlQCxcMwg8HtchLMFKlMLs7FMeMPdmHQUTB2J+/
         Ju0mZMhlbCWxyK3CqQEh4F7Vvfqj5a4oMNFuzxmL0EkcztD7J+pX1qBiTgRq7iLGBINE
         zie4hc6FIqClCPcGnwc35sEO98Qq0l5sIU4OzAtQ6UH9uB1VXywl+1vwSMlJ6dCWr5MA
         UjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965959; x=1699570759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP31fLX+pxaO5hDZO6DHoxgvhUAHCcHqxZGWN/MwNfQ=;
        b=fBbvQwhhBuWu48Zsyo3zrXVJcetgerFFKfXWwhAj8kU8WqWJJvhTKynA+PRlnFi3Di
         OgnxPSSPh3jnbX6lCWW6Q4C6H0WgXQ/hrm99bt7RlcFjL0dMFipupLmKhdxjjiatwWNZ
         KNkki+HW6z9GIEOeOYThQMi3j4uC9zaUI2pq/jkJ0BTIyPZtAzKtOiL5vnj3IFqObG0+
         U4PuobdF3EJ/oCJAAu7CTgQMw5TB+9IqEVZ3wItLzXflH8TWK4ix9NOTU5AKEdPItaP2
         NEzwElank/HDVDj/bMSj/ueY7X7Yg4phwgGybL690Hw1y7OQG1BfJlb45Hvy3Sg+PD53
         kRMQ==
X-Gm-Message-State: AOJu0Yxbyg+jkLJkwj2nRoWlRQU61XhrG8LNWkzlbwRMXm0SWAtGigKU
        1nd/HwUM56Vr1rAbRBW5XPea0HVJMyFXg7tNBaHuHw==
X-Google-Smtp-Source: AGHT+IER/U62zMtD0dfjlB8xVUMWLzaEfk+FVmtEYeeOf4e2H7qaz0cqMSQAHaoKrBNn0fyQr4PgrJoZLliy0h0JKx0=
X-Received: by 2002:a05:6402:501c:b0:543:fa43:a361 with SMTP id
 p28-20020a056402501c00b00543fa43a361mr146040eda.1.1698965959359; Thu, 02 Nov
 2023 15:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231102222653.4165959-1-namhyung@kernel.org> <20231102222653.4165959-4-namhyung@kernel.org>
In-Reply-To: <20231102222653.4165959-4-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Nov 2023 15:59:07 -0700
Message-ID: <CAP-5=fVWKrSN+c5gc9KwKjP-_tXDi1RaFhEvbD9aP20qMJiHJg@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf annotate: Move max_coverage to annotated_branch
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 3:27=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> The max_coverage is only used when branch stack info is available so
> it'd be natural to move to the annotated_branch.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-annotate.c | 7 +++++--
>  tools/perf/util/annotate.c    | 2 +-
>  tools/perf/util/annotate.h    | 4 +++-
>  tools/perf/util/block-range.c | 7 ++++++-
>  4 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.=
c
> index aeeb801f1ed7..a9129b51d511 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -94,6 +94,7 @@ static void process_basic_block(struct addr_map_symbol =
*start,
>         struct annotation *notes =3D sym ? symbol__annotation(sym) : NULL=
;
>         struct block_range_iter iter;
>         struct block_range *entry;
> +       struct annotated_branch *branch;
>
>         /*
>          * Sanity; NULL isn't executable and the CPU cannot execute backw=
ards
> @@ -105,6 +106,8 @@ static void process_basic_block(struct addr_map_symbo=
l *start,
>         if (!block_range_iter__valid(&iter))
>                 return;
>
> +       branch =3D annotation__get_branch(notes);
> +
>         /*
>          * First block in range is a branch target.
>          */
> @@ -118,8 +121,8 @@ static void process_basic_block(struct addr_map_symbo=
l *start,
>                 entry->coverage++;
>                 entry->sym =3D sym;
>
> -               if (notes)
> -                       notes->max_coverage =3D max(notes->max_coverage, =
entry->coverage);
> +               if (branch)
> +                       branch->max_coverage =3D max(branch->max_coverage=
, entry->coverage);
>
>         } while (block_range_iter__next(&iter));
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 2fa1ce3a0858..92a9adf9d5eb 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -946,7 +946,7 @@ static int __symbol__inc_addr_samples(struct map_symb=
ol *ms,
>         return 0;
>  }
>
> -static struct annotated_branch *annotation__get_branch(struct annotation=
 *notes)
> +struct annotated_branch *annotation__get_branch(struct annotation *notes=
)
>  {
>         if (notes =3D=3D NULL)
>                 return NULL;
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 9c199629305d..d8a221591926 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -280,10 +280,10 @@ struct annotated_branch {
>         unsigned int            total_insn;
>         unsigned int            cover_insn;
>         struct cyc_hist         *cycles_hist;
> +       u64                     max_coverage;
>  };
>
>  struct LOCKABLE annotation {
> -       u64                     max_coverage;
>         u64                     start;
>         struct annotation_options *options;
>         struct annotation_line  **offsets;
> @@ -356,6 +356,8 @@ static inline struct annotation *symbol__annotation(s=
truct symbol *sym)
>  int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct per=
f_sample *sample,
>                                  struct evsel *evsel);
>
> +struct annotated_branch *annotation__get_branch(struct annotation *notes=
);
> +
>  int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
>                                     struct addr_map_symbol *start,
>                                     unsigned cycles);
> diff --git a/tools/perf/util/block-range.c b/tools/perf/util/block-range.=
c
> index 680e92774d0c..15c42196c24c 100644
> --- a/tools/perf/util/block-range.c
> +++ b/tools/perf/util/block-range.c
> @@ -311,6 +311,7 @@ struct block_range_iter block_range__create(u64 start=
, u64 end)
>  double block_range__coverage(struct block_range *br)
>  {
>         struct symbol *sym;
> +       struct annotated_branch *branch;
>
>         if (!br) {
>                 if (block_ranges.blocks)
> @@ -323,5 +324,9 @@ double block_range__coverage(struct block_range *br)
>         if (!sym)
>                 return -1;
>
> -       return (double)br->coverage / symbol__annotation(sym)->max_covera=
ge;
> +       branch =3D symbol__annotation(sym)->branch;
> +       if (!branch)
> +               return -1;
> +
> +       return (double)br->coverage / branch->max_coverage;
>  }
> --
> 2.42.0.869.gea05f2083d-goog
>
