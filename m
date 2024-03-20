Return-Path: <linux-kernel+bounces-109475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F988819A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A0CB21002
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4296185C74;
	Wed, 20 Mar 2024 22:55:03 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D03381D1;
	Wed, 20 Mar 2024 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975302; cv=none; b=KZM9Vb7SakBQDGEyYg4Ypje7tAdQRhSO43n/keeqyp1gBiShd2kYYeUlYGiO3aBAymb0E7nQnQJFe7YvceH3gnb1mkh1ujEeyuOpuToa0UFXH6dDQJ2vvRCg4pjDA603CWR1DYjif/9tK1MKWewES2hVNx/o+dw9kv3J7IoUfHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975302; c=relaxed/simple;
	bh=W3PdZbuJxmfIn33kY02vgnrW1nMZ5/5OIYob3g+hyuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdRsCsQpM1QHmGVTDowvOQ4Upa97bp0F2UMchihbzwv3TLee//TutpWUmDxqbRpmeNI0m0jwldpRPsFO4o3Bt5tRGbwiQlHl390tz6Z0pvuZ7TQoIQZz35JFBMKikR4C0jhnWsNjytw0WJWyDZX0ykllhLpz8GXJboT1P2k1UjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29fb7e52731so345988a91.2;
        Wed, 20 Mar 2024 15:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710975300; x=1711580100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nd9U5cv4fdeaFsXK9u3eZEmu+VOq7nI3lOVtZgOEtyY=;
        b=obVN7hNbg4HTYMcpkx2ivLjK7nTBPyIp6/+atwtfeWAxQkB9rBMljfGZUCyUL46uUN
         gw68dkwTX1/werKMk/rIqJX8SvaZPP3IyzjRAqt+Z91fjZVSRz6tXu2XWfNpC6SDhxtM
         OhgsJlUTktmio6U8+AIR/TTTyLp19/gfl9SBm1O2KQoxs/acS0vn6XyhGBJMUq1NjFOI
         JliqevRG6K2F4tHaj7tLCdzWecxkwubpyVgi615Hw6kpll/n3B1qQb2QSSBQTO+SRCxZ
         0254CeQdgup261a/Tzucasf/079I793JGtNdB5t41IVFB58nIOMrkELxvzfqvmc7oaIO
         ZSuA==
X-Forwarded-Encrypted: i=1; AJvYcCWygv95FAcdZNyhOejJv7w8ATSxuz2edwsf5SMGyR2nI9MRQ6+K11Eh7mTUTXpE3Yg3KEudSXvnInZfRUKWG/mgs1hpvMCmESFZz4010uXjyQX+0fYt6dRoAoAG+OGiIa3qDXLQlF2Z8iRSf8Jv8g==
X-Gm-Message-State: AOJu0Yw5qCjV0mTBNkJn0GZm6JqbtejGCFxuvUZZD3REJUhtnf6Do62U
	oRELk3ERHdntaUBbaiKEmfoIpVyVZ+psu0Q310cQXUrKTH5T8eve/1UIEH3u8g7iuJn+7wjshpt
	8NV7V9uCUSvs7eUGqlE96ttuAFZY=
X-Google-Smtp-Source: AGHT+IEnoMeN9R6PtAZ8FNx+i2CH/pU82cRjrkklkma1HQX0vAwUIJPjKWHTrG32gxIPrFkcP7h7DoM1eWBDT4d0Q6c=
X-Received: by 2002:a17:90a:dc10:b0:29f:c352:7941 with SMTP id
 i16-20020a17090adc1000b0029fc3527941mr5987788pjv.45.1710975300227; Wed, 20
 Mar 2024 15:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319143629.3422590-1-retpolanne@posteo.net>
In-Reply-To: <20240319143629.3422590-1-retpolanne@posteo.net>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 20 Mar 2024 15:54:49 -0700
Message-ID: <CAM9d7cjU-LdApNjFt+hDbX5GGPC2Ako8WZsFbV8DF=RzE3cZ+Q@mail.gmail.com>
Subject: Re: [PATCH v4] perf lock contention: skip traceiter functions
To: Anne Macedo <retpolanne@posteo.net>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anne,

On Tue, Mar 19, 2024 at 7:36=E2=80=AFAM Anne Macedo <retpolanne@posteo.net>=
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
> changes since v3:
>
> - remove dummy value and assume machine->traceiter and machine->trace
> have zero address
>
> changes since v2:
>
> - add dummy value to machine->traceiter and machine->trace to make
> necessary checks, fixing possible null pointer access
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

Thanks for your work!

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/machine.c | 24 ++++++++++++++++++++++++
>  tools/perf/util/machine.h |  2 +-
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 527517db3182..5eb9044bc223 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -3266,6 +3266,17 @@ bool machine__is_lock_function(struct machine *mac=
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
> @@ -3280,5 +3291,18 @@ bool machine__is_lock_function(struct machine *mac=
hine, u64 addr)
>         if (machine->lock.text_start <=3D addr && addr < machine->lock.te=
xt_end)
>                 return true;
>
> +       /* traceiter functions currently don't have their own section
> +        * but we consider them lock functions
> +        */
> +       if (machine->traceiter.text_start !=3D 0) {
> +               if (machine->traceiter.text_start <=3D addr && addr < mac=
hine->traceiter.text_end)
> +                       return true;
> +       }
> +
> +       if (machine->trace.text_start !=3D 0) {
> +               if (machine->trace.text_start <=3D addr && addr < machine=
->trace.text_end)
> +                       return true;
> +       }
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

