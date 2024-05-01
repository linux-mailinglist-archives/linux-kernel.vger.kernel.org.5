Return-Path: <linux-kernel+bounces-165721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7FB8B9030
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA574283339
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B2F161900;
	Wed,  1 May 2024 19:46:52 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2192B1607B4;
	Wed,  1 May 2024 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714592811; cv=none; b=MGKZNeHXW5GV4YX50ZpfvTlecxcJemmk6E/fFiFYIdQaL8gt+RuZ3tDsysYTY7gnmXGTnNlh+b4gcb1mXuhVG4nILSflZMe9mlY/7U+LYuLmKTJuR7sUjJDR+xV2sD9o0EUQ2UAlEg1ZqFdlj3tJtBrLNnP+HM4HGODADAKlPR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714592811; c=relaxed/simple;
	bh=UXLxZiwO9j4G9yblpoqhCe1Fedph3TfzSAiBDi6VnF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCh6gD4bIEVgGuFldffvbXKyFdwCteaZ+ElYKJxYP3ZZAu3ELH6vRQbBVcqL5EIzkKw8Phy8dBWJQSNAXkdc+aJV50HmacQzM0I+NBNlNm60wauhl/IIPgp15SzXI1ZfUQyfDMfpxnUI6ATzgpeCMN9JgV5tfAZRV7y+etqoZ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b273cbbdfdso1693188a91.1;
        Wed, 01 May 2024 12:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714592809; x=1715197609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=am9dpPV5imiX1yoIG8XzwmO0kyg9MHdmsXivnnyrnxI=;
        b=Ctgt8FwXqAvKIBNC0OtBS3Y3Cwu/f1vdPQN7m6J1UMKuUJ+eocuBaxt7HiFfp/m3GB
         WyfzV6uG1WH7jOw6IfcgICgsO/OLmMXDrU6/yS0DZeUHwnDXK4xGuj5X8isML4Ut0dpW
         KoFs87pVCRdbmgI5/DiKaorNFGx+Gak9wzAI374jHWnerx/DwR3oB2ZCCW3DgJxArG9N
         lC1+AK5UbdFWDvfMmORFQ6cbzGWWSvwaagkCu1JDPMh7BI6xtyJye5LtmSUbafrJ02No
         YS3rmIS6QntrmjGS4+tQHFGf01Q9Ax6UBdInxqrbIPlLKVO6b6WatuZAHWKS1/557Sla
         Kr0A==
X-Forwarded-Encrypted: i=1; AJvYcCUrIXj39/aFjOfTlRPJjzX2pWPYEpzIbvlNBTkElF4omrLo2iXYhkW4knartOu75u5oRrwO+nIoxP5zHXtP0cDJbdrfti6YR+QSlKQh7tnnIxLQ/Nx4rhjRU1wCgm2VL+ym4g52BATapaHZqqaNtw==
X-Gm-Message-State: AOJu0YxWSnJrYqY5Sxi9euZSpZESwa6CaKSRry0U1BWC2c/xkkpi60PK
	8G2Aw1MH0am+yWAjOH1MWASIgvAjtuMqCCOi8Z6pfeLsZL7FIjJlRhbxof5SuMS6wytrkZdnHop
	2Rfe6FA2+4l/wtDzNHWjw6QddFLBWkw==
X-Google-Smtp-Source: AGHT+IFb5Tk2f/ZK+6gQtWBcIg9Q1zkVzgWYqCuDhWC67Jv+IVN72ZxjRKz5eOfAABzhSsA41X3tpzSvsvpFP0GbniM=
X-Received: by 2002:a17:90a:f3cc:b0:29b:b5a4:c040 with SMTP id
 ha12-20020a17090af3cc00b0029bb5a4c040mr3352447pjb.46.1714592809181; Wed, 01
 May 2024 12:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430184156.1824083-1-irogers@google.com>
In-Reply-To: <20240430184156.1824083-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 1 May 2024 12:46:38 -0700
Message-ID: <CAM9d7chFv38q+a9m_OE-dP1aSUpvd35tM1V7DA_t756O6hrTUA@mail.gmail.com>
Subject: Re: [PATCH v1] perf lock: More strdup argument freeing
To: Ian Rogers <irogers@google.com>
Cc: zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 11:42=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Leak sanitizer complains about the strdup-ed arguments not being
> freed. rec_argv is reordered and duplicates inserted, meaning making
> all its contents strdup-ed and freeing them all leads to double frees
> or leaks. Add an extra array to track strup-ed arguments and free
> them. This makes address sanitier running `perf test` "kernel lock
> contention analysis test" memory leak free.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-lock.c | 44 +++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 230461280e45..26c059397cdf 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2230,10 +2230,11 @@ static int __cmd_record(int argc, const char **ar=
gv)
>         const char *callgraph_args[] =3D {
>                 "--call-graph", "fp," __stringify(CONTENTION_STACK_DEPTH)=
,
>         };
> -       unsigned int rec_argc, i, j, ret;
> +       unsigned int rec_argc, i, j, dups =3D 0, ret;
>         unsigned int nr_tracepoints;
>         unsigned int nr_callgraph_args =3D 0;
>         const char **rec_argv;
> +       char **to_free;
>         bool has_lock_stat =3D true;
>
>         for (i =3D 0; i < ARRAY_SIZE(lock_tracepoints); i++) {
> @@ -2270,28 +2271,25 @@ static int __cmd_record(int argc, const char **ar=
gv)
>         /* factor of 2 is for -e in front of each tracepoint */
>         rec_argc +=3D 2 * nr_tracepoints;
>
> -       rec_argv =3D calloc(rec_argc + 1, sizeof(char *));
> +       rec_argv =3D calloc(rec_argc + 1, sizeof(*rec_argv));
>         if (!rec_argv)
>                 return -ENOMEM;
>
> -       for (i =3D 0; i < ARRAY_SIZE(record_args); i++)
> -               rec_argv[i] =3D strdup(record_args[i]);
> -
> -       for (j =3D 0; j < nr_tracepoints; j++) {
> -               const char *ev_name;
> +       to_free =3D calloc(rec_argc, sizeof(*to_free));
> +       if (!to_free)
> +               return -ENOMEM;

Need to free rec_argv.  'goto out' would be fine.

>
> -               if (has_lock_stat)
> -                       ev_name =3D strdup(lock_tracepoints[j].name);
> -               else
> -                       ev_name =3D strdup(contention_tracepoints[j].name=
);
> -
> -               if (!ev_name) {
> -                       free(rec_argv);
> -                       return -ENOMEM;
> -               }
>
> +       for (i =3D 0; i < ARRAY_SIZE(record_args);) {
> +               to_free[dups] =3D strdup(record_args[i]);
> +               rec_argv[i++] =3D to_free[dups++];
> +       }
> +       for (j =3D 0; j < nr_tracepoints; j++) {
> +               to_free[dups] =3D strdup(has_lock_stat
> +                                      ? lock_tracepoints[j].name
> +                                      : contention_tracepoints[j].name);
>                 rec_argv[i++] =3D "-e";
> -               rec_argv[i++] =3D ev_name;
> +               rec_argv[i++] =3D to_free[dups++];

Now I'm curious why we copy the string in the first place.
Maybe not needed..?

Thanks,
Namhyung


>         }
>
>         for (j =3D 0; j < nr_callgraph_args; j++, i++)
> @@ -2302,7 +2300,17 @@ static int __cmd_record(int argc, const char **arg=
v)
>
>         BUG_ON(i !=3D rec_argc);
>
> -       ret =3D cmd_record(i, rec_argv);
> +       for (i =3D 0; i < dups; i++) {
> +               if (to_free[i] =3D=3D NULL) {
> +                       ret =3D -ENOMEM;
> +                       goto out;
> +               }
> +       }
> +       ret =3D cmd_record(rec_argc, rec_argv);
> +out:
> +       for (i =3D 0; i < dups; i++)
> +               zfree(&to_free[i]);
> +       free(to_free);
>         free(rec_argv);
>         return ret;
>  }
> --
> 2.45.0.rc0.197.gbae5840b3b-goog
>

