Return-Path: <linux-kernel+bounces-163059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B26E8B6459
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7E21C21B59
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF91A17A924;
	Mon, 29 Apr 2024 21:08:01 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98001779AB;
	Mon, 29 Apr 2024 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424881; cv=none; b=YYKyniWzmNimshpKnEhCktWSGsNcQGXOZFgNh23iWFZfxKPWe6Y9XX6nHbn1ktyKLmZ5l68tXMgv2AlarjnMzJzZU/WaGNWdZXbMhChicbz67F/RETmLbRHFHKAxnBOGRrwOGUnYwPqKSknzwc7DNFU/FFUWttv1rkyNQItSuuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424881; c=relaxed/simple;
	bh=Ck+yU6NTUWP8ICw7uIeeZj66jrbtziQMq+kb6I3uJ2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+9lMZ5ODHws1xgbB/8nqA9HY2WOMaz13Y7t/8LfKNjb7rnSuobX7PNR1ObE92fr3DctzSh3VxBfsO03rFmAu2L5Hxh3UxJet9UZFNtvdHRerMppppfJckoTejJABcE67Lxm3j/Fe/UKDH3dY49qKxNddt7AhiZsy8xOISe//7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ae913878b0so3751497a91.2;
        Mon, 29 Apr 2024 14:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714424879; x=1715029679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXG/B9wOT7I/oGXfnn//74gTvJCRnNe/uGGOds8fU7M=;
        b=HPcyhDs1H9ekNjMZDaPs6Uvzs4x8xygg1Zxcmv4snCyIpTEvmyB9jUPucLhFIKYqyz
         HTvJK9nBHn3Zmvs6/4Apcxs9HlmMSTqrTTXMw3R07Nok5tqxTfBXrjSxK6JUc0ajSESV
         At6CpyEKwVsClnPQ3V1W66Mu+CqfC2IpV+3EFPtr/Qn9pKheb8Y2vbce5JDfSixPOA+E
         CkFBdVlWfo1rytDg0Mi8Pe+3QfNyoMeXRwV8im57QJZRJ4KKjRTWlflzSqERpaVtQQZO
         tdXRdHrEJHccDTkncV7/wD9hV7cHvU8FqlVEikJnv6QHhIQw5eyBYVV1lyFThka3twSp
         9lPA==
X-Forwarded-Encrypted: i=1; AJvYcCUQw5njqp7aXj/JWp24869EsUO8kGvh9HdbYoni+kwTWjfMxTkekbzHYwgKVLdOHiXe7A90QT7ci+kgBdA3R7MCYXfUyDisJB+uIrn8JSPrRtKHBzC89nHutM5tNGCbV52ATTNo21TlFUrJCXImUg==
X-Gm-Message-State: AOJu0YyB7QjhcxeR034UkpjatwmjFtf6xejpambTRfoQwGLRhUijPCAF
	935f3fpxrYE920mu+dQrnp0SGhLiynO3UdBI1L3dCkukXxFIC7T7cOS2QYskp42qvjVS0jQHTTr
	5VhobzuEfssZBU2/r6bnvDl8KyUY=
X-Google-Smtp-Source: AGHT+IF4y3VAkm0tJulxB6cw/8mXzSvSjrr4Iq3tAkfP6ii8md5k0vpGaPJ/dMI+uERJDvbTXLFImqMh3aZurxkZ4v8=
X-Received: by 2002:a17:90a:f314:b0:2b1:74ad:e243 with SMTP id
 ca20-20020a17090af31400b002b174ade243mr3792021pjb.24.1714424879049; Mon, 29
 Apr 2024 14:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428053616.1125891-1-irogers@google.com> <20240428053616.1125891-3-irogers@google.com>
In-Reply-To: <20240428053616.1125891-3-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 29 Apr 2024 14:07:48 -0700
Message-ID: <CAM9d7cgcC-qO63neiCtyovC6qiAprMs=HKF66XvfiBqZrOiXXg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] perf parse-events: Add a retirement latency modifier
To: Ian Rogers <irogers@google.com>
Cc: weilin.wang@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Song Liu <song@kernel.org>, James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 10:36=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Retirement latency is a separate sampled count used on newer Intel
> CPUs.

Can you please update the "event modifiers" section in the perf list
documentation too?

Also I'm curious if we have a doc for the JSON metric format.

Thanks,
Namhyung

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.h        | 1 +
>  tools/perf/util/parse-events.c | 2 ++
>  tools/perf/util/parse-events.h | 1 +
>  tools/perf/util/parse-events.l | 3 ++-
>  4 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 43f6fd1dcb4d..bd8e84954e34 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -98,6 +98,7 @@ struct evsel {
>                 bool                    bpf_counter;
>                 bool                    use_config_name;
>                 bool                    skippable;
> +               bool                    retire_lat;
>                 int                     bpf_fd;
>                 struct bpf_object       *bpf_obj;
>                 struct list_head        config_terms;
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 0f308b4db2b9..9c2a76ec8c99 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1818,6 +1818,8 @@ static int parse_events__modifier_list(struct parse=
_events_state *parse_state,
>                         evsel->weak_group =3D true;
>                 if (mod.bpf)
>                         evsel->bpf_counter =3D true;
> +               if (mod.retire_lat)
> +                       evsel->retire_lat =3D true;
>         }
>         return 0;
>  }
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-event=
s.h
> index 5695308efab9..eb94d1247dae 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -201,6 +201,7 @@ struct parse_events_modifier {
>         bool hypervisor : 1;    /* 'h' */
>         bool guest : 1;         /* 'G' */
>         bool host : 1;          /* 'H' */
> +       bool retire_lat : 1;    /* 'R' */
>  };
>
>  int parse_events__modifier_event(struct parse_events_state *parse_state,=
 void *loc,
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-event=
s.l
> index 08ea2d845dc3..85015f080240 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -209,6 +209,7 @@ static int modifiers(struct parse_events_state *parse=
_state, yyscan_t scanner)
>                 CASE('W', weak);
>                 CASE('e', exclusive);
>                 CASE('b', bpf);
> +               CASE('R', retire_lat);
>                 default:
>                         return PE_ERROR;
>                 }
> @@ -250,7 +251,7 @@ drv_cfg_term        [a-zA-Z0-9_\.]+(=3D[a-zA-Z0-9_*?\=
:]+)?
>   * If you add a modifier you need to update check_modifier().
>   * Also, the letters in modifier_event must not be in modifier_bp.
>   */
> -modifier_event [ukhpPGHSDIWeb]{1,15}
> +modifier_event [ukhpPGHSDIWebR]{1,16}
>  modifier_bp    [rwx]{1,3}
>  lc_type        (L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruc=
tion|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|=
bpu|btb|bpc|node)
>  lc_op_result   (load|loads|read|store|stores|write|prefetch|prefetches|s=
peculative-read|speculative-load|refs|Reference|ops|access|misses|miss)
> --
> 2.44.0.769.g3c40516874-goog
>

