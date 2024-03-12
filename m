Return-Path: <linux-kernel+bounces-99849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3490878E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2131F22575
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DB81E48C;
	Tue, 12 Mar 2024 05:44:27 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B14433BD;
	Tue, 12 Mar 2024 05:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710222267; cv=none; b=ul+XYmjzxIHak+SOsQFCXcol4fVuS3EzvTu6iTNnH6SJWN33Ay3CJxB8Ux+AeI6wK1v2eEH2YkvHhf51G7mnRU4BBeg9XQjzqPRv7BouKUsJ4cM3jqIcp0Cv//F2xlYmv5Ec1V1L4nYdfdNKrrFobfLAWX2iURrBrwAZKrQ/UEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710222267; c=relaxed/simple;
	bh=vsDdw5AoKb7t2Fr1pwSs+CiRh2m89COXoT7sPIXGtCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBPhthXDfd4VBOu+TqEulbSTbIZqRU4x2HjnJR3dBuECWPd7aEmhiSQImAcB0XXTFCOC6qi+qiHSbLRFmJjFUkytyARF8eFbs2CsrlrxeiTXnObP8gOddoWA8tDQ3Ew6X5tdY8RNcsoNQRXopaZ7Db8klXcz0ueoLR/2waEbDOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29bbff1505dso1801485a91.0;
        Mon, 11 Mar 2024 22:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710222264; x=1710827064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mikke4cs+ZZ27PoBUQOVOzuXIffj5gVMRmy7vQDDZeE=;
        b=crvDmJWMjRjYUJD+7kdWDwblbdE2EhbuSDrs2/7xzooe9nZKt2b2B/nM8y6CFjPimJ
         JY5qNe18pY/1Ho9+fBY7uIPejKHb3qyqTqTciapmiP0WgvVayyB+51zcCUZ1Cp+Y/qhS
         Jr1+4mcpvA+h6oEHxiCs9I4MppiVo0ubC7/61hFwZvysU46oYVQgb5McAy8mxZeoNhYl
         R3/C0eVMO1BrbQxdBnNV5JkW4vgShRrhRH8hqRxarEhP4lASOwvQR4jeto+rsDJgMRCm
         28f/vARFZ/2kDR7Y+Y+w3iSl50xj6lhYO6/zIHEY4fA5sMSBIWL218VZvD4vfso+tj4e
         61sQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3BIGTipUvFpYTLoeaXxJQEDNZ/GPbdWdTU3uCpEVPfqhKynB1q1ylUuqRX5SseXLluuXspIGcNyG+1jGIYUlDWP3bMnNU4qwd31lNgqhqxZrPMwOXu/5PGEbbsPL+La3nTD4a9nexnqG0HaxHHA==
X-Gm-Message-State: AOJu0YxjttC4vNnVi3iFLJYDLj7v63gFVtRFBM5L2CJpqILI3/D6zXtA
	kf7mSTFEOIwrnDR9pdvLBjcnwA3tNOhp3RdnAIQagZVC/8dTgnyPLRqaKiwJg5onW4vSAdxVRls
	Jyk+atvnfKSGG9Y1THtPvPazUhyc=
X-Google-Smtp-Source: AGHT+IGYx33ZxIgxGQWOQHAYzCM45EMtSCfx0vcZ8NbS22ydjPzGF/yHICSx7ZDQqMdZFviAJ/dqszz2s+bT4LtR+EI=
X-Received: by 2002:a17:90b:4b46:b0:29c:32ad:2fbe with SMTP id
 mi6-20020a17090b4b4600b0029c32ad2fbemr1207866pjb.49.1710222263698; Mon, 11
 Mar 2024 22:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311225617.179184-1-retpolanne@posteo.net>
In-Reply-To: <20240311225617.179184-1-retpolanne@posteo.net>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Mar 2024 22:44:12 -0700
Message-ID: <CAM9d7civcSVL92SYhssCjYzaomyJNfn0CHWz7ErGwKY-H8_Kfw@mail.gmail.com>
Subject: Re: [PATCH v2] perf lock contention: skip traceiter functions
To: Anne Macedo <retpolanne@posteo.net>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 3:57=E2=80=AFPM Anne Macedo <retpolanne@posteo.net>=
 wrote:
>
> The perf lock contention program currently shows the caller of the locks
> as __traceiter_contention_begin+0x??. This caller can be ignored, as it i=
s
> from the traceiter itself. Instead, it should show the real callers for
> the locks.
>
> When fiddling with the --stack-skip parameter, the actual callers for
> the locks start to show up. However, just ignore the
> __traceiter_contention_begin and the __traceiter_contention_end symbols
> so the actual callers will show up.
>
> Before this patch is applied:
>
> sudo perf lock con -a -b -- sleep 3
>  contended   total wait     max wait     avg wait         type   caller
>
>          8      2.33 s       2.28 s     291.18 ms     rwlock:W   __tracei=
ter_contention_begin+0x44
>          4      2.33 s       2.28 s     582.35 ms     rwlock:W   __tracei=
ter_contention_begin+0x44
>          7    140.30 ms     46.77 ms     20.04 ms     rwlock:W   __tracei=
ter_contention_begin+0x44
>          2     63.35 ms     33.76 ms     31.68 ms        mutex   trace_co=
ntention_begin+0x84
>          2     46.74 ms     46.73 ms     23.37 ms     rwlock:W   __tracei=
ter_contention_begin+0x44
>          1     13.54 us     13.54 us     13.54 us        mutex   trace_co=
ntention_begin+0x84
>          1      3.67 us      3.67 us      3.67 us      rwsem:R   __tracei=
ter_contention_begin+0x44
>
> Before this patch is applied - using --stack-skip 5
>
> sudo perf lock con --stack-skip 5 -a -b -- sleep 3
>  contended   total wait     max wait     avg wait         type   caller
>
>          2      2.24 s       2.24 s       1.12 s      rwlock:W   do_epoll=
_wait+0x5a0
>          4      1.65 s     824.21 ms    412.08 ms     rwlock:W   do_exit+=
0x338
>          2    824.35 ms    824.29 ms    412.17 ms     spinlock   get_sign=
al+0x108
>          2    824.14 ms    824.14 ms    412.07 ms     rwlock:W   release_=
task+0x68
>          1     25.22 ms     25.22 ms     25.22 ms        mutex   cgroup_k=
n_lock_live+0x58
>          1     24.71 us     24.71 us     24.71 us     spinlock   do_exit+=
0x44
>          1     22.04 us     22.04 us     22.04 us      rwsem:R   lock_mm_=
and_find_vma+0xb0
>
> After this patch is applied:
>
> sudo ./perf lock con -a -b -- sleep 3
>  contended   total wait     max wait     avg wait         type   caller
>
>          4      4.13 s       2.07 s       1.03 s      rwlock:W   release_=
task+0x68
>          2      2.07 s       2.07 s       1.03 s      rwlock:R   mm_updat=
e_next_owner+0x50
>          2      2.07 s       2.07 s       1.03 s      rwlock:W   do_exit+=
0x338
>          1     41.56 ms     41.56 ms     41.56 ms        mutex   cgroup_k=
n_lock_live+0x58
>          2     36.12 us     18.83 us     18.06 us     rwlock:W   do_exit+=
0x338
>
> changes since v1:
>
> - consider trace_contention and __traceiter_contention functions as
> optional (i.e. check if sym is null to avoid segfault)
>
> changes since v0:
>
> - skip trace_contention functions
> - use sym->end instead of __traceiter_contention_end for text_end
>
> Signed-off-by: Anne Macedo <retpolanne@posteo.net>
> ---
>  tools/perf/util/machine.c | 21 +++++++++++++++++++++
>  tools/perf/util/machine.h |  2 +-
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 527517db3182..968f69364f9a 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -3266,6 +3266,18 @@ bool machine__is_lock_function(struct machine *mac=
hine, u64 addr)
>
>                 sym =3D machine__find_kernel_symbol_by_name(machine, "__l=
ock_text_end", &kmap);
>                 machine->lock.text_end =3D map__unmap_ip(kmap, sym->start=
);
> +
> +               sym =3D machine__find_kernel_symbol_by_name(machine, "__t=
raceiter_contention_begin", &kmap);
> +               if (sym) {
> +                       machine->traceiter.text_start =3D map__unmap_ip(k=
map, sym->start);
> +                       machine->traceiter.text_end =3D map__unmap_ip(kma=
p, sym->end);
> +               }
> +
> +               sym =3D machine__find_kernel_symbol_by_name(machine, "tra=
ce_contention_begin", &kmap);
> +               if (sym) {
> +                       machine->trace.text_start =3D map__unmap_ip(kmap,=
 sym->start);
> +                       machine->trace.text_end =3D map__unmap_ip(kmap, s=
ym->end);
> +               }
>         }
>
>         /* failed to get kernel symbols */
> @@ -3280,5 +3292,14 @@ bool machine__is_lock_function(struct machine *mac=
hine, u64 addr)
>         if (machine->lock.text_start <=3D addr && addr < machine->lock.te=
xt_end)
>                 return true;
>
> +       /* traceiter functions currently don't have their own section
> +        * but we consider them lock functions
> +        */
> +       if (machine->traceiter.text_start <=3D addr && addr < machine->tr=
aceiter.text_end)
> +               return true;
> +
> +       if (machine->trace.text_start <=3D addr && addr < machine->trace.=
text_end)
> +               return true;

You cannot simply check these as they are set optionally.

Thanks,
Namhyung


> +
>         return false;
>  }
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index e28c787616fe..4312f6db6de0 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -49,7 +49,7 @@ struct machine {
>         struct {
>                 u64       text_start;
>                 u64       text_end;
> -       } sched, lock;
> +       } sched, lock, traceiter, trace;
>         pid_t             *current_tid;
>         size_t            current_tid_sz;
>         union { /* Tool specific area */
> --
> 2.39.2
>

