Return-Path: <linux-kernel+bounces-106989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C188387F65F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38AD6B221D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429217C6C8;
	Tue, 19 Mar 2024 04:25:02 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110AB5F544;
	Tue, 19 Mar 2024 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710822301; cv=none; b=tZfOTHhNF84HqjoVQLOb95tHXrflEMi8Z+xp/+66SM0/3P5W7+K7eO3IsZIwVnzmqj/2DJDm510vuKOvvJXVGYcCNs/0wmXhqgLvqVwM/Z//cM0mUL7o6rBFT+pA8KusDeJvWOCZtUcQ9gSAa/OF6BJpDpO+ngiKaP2je74ZMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710822301; c=relaxed/simple;
	bh=ek6Pl79/6OC/W647PdCOnSWgMGV+lOPW1TxDkhL6tNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xs+8sVWVgGiW3obl2LuCgWr5vFOsXsJhMC8+nzpijAoATNCL0K3qEM+8nYJ0wDfaDjVaoeyyD9gAt1VpBNWl8XlD1QYgzfWNoixLxJUl1fNeKfwhwQKgTB47bDJavrRLz0zjkFpU/IJJFYY5kDkR8zWeBn1qu8OYEZD76hNY3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29ddfd859eeso3906930a91.1;
        Mon, 18 Mar 2024 21:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710822299; x=1711427099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZWn6JmukE/KhxGaygznJp+UdYClha+aD49PPLebiJA=;
        b=nybnYVzYgqc7N9VXVm02cu/jKl/Dj3s+roukQ/iCgI6M+IMYTel8ep1o8BOo/O2j7t
         CwMmQaUAM6VvxZWFmWLRG07l9pEi57PLt6Zl4FZpzZha/0UkDHNjwYW69HiizURHs9J2
         MDIIguYJOeCAqmOAiIpCQJR7HJM3ub6kDG4jPyKe7yhpOTI0v3D07MqUeyBkPsDlVv3c
         mPTeBqXC4brOddk/LpGmzSHfD+phrnGTabzFXNsudozyvYAeVP5eWd6DiF9FRHBz7gaf
         NWcr72CeN5E6hLfWFd0tKd/VcGKu5cXQgwfbr1NX9uefMk8OjGXTtqbp2q/t9FAz4Oe6
         OMjw==
X-Forwarded-Encrypted: i=1; AJvYcCVi8VwOIsgtihBkbWr+3teF7OIKTf9BYTFIusXAlyjOIDnCAh51Rjnnatf5U0CEMoDE/wOFpGVNOnIOBnbJihT5+mMJnH+2/LmO4oX4LWhE4/YuDFaNz250gf2YnEqHNzSZPeTkXN1rZWiDKk8caA==
X-Gm-Message-State: AOJu0YxQJbj6UzHtg7dbhUDNMEUWYbrqHZkGvN8RHQ2SR1WLdYKCJaUv
	EYIBfmQ7kz3Oszp6BjUqWe6uoHCS3+nxy/chdztzlw5E3wsrfK+tOV5Qxgbs8jtqi2sVEGJFDxj
	qzdETG42LeTQoJA6X/3KTkZcNxSE=
X-Google-Smtp-Source: AGHT+IHt0U7BQFQl/8mm8RjT50key1Z1Mc/KUWFvQ4E/wXYLHbCFKfRyZf4eo+9EgSHqDBzY4wkdWGDGX2YxRHxBaB0=
X-Received: by 2002:a17:90a:6c06:b0:29c:77f9:437f with SMTP id
 x6-20020a17090a6c0600b0029c77f9437fmr10527868pjj.49.1710822299247; Mon, 18
 Mar 2024 21:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315111907.1434909-1-retpolanne@posteo.net>
In-Reply-To: <20240315111907.1434909-1-retpolanne@posteo.net>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 18 Mar 2024 21:24:48 -0700
Message-ID: <CAM9d7cia-zbAO_0U5MZA24-fGqjqAFT+SxN+DP60auCBy=_7Ww@mail.gmail.com>
Subject: Re: [PATCH v3] perf lock contention: skip traceiter functions
To: Anne Macedo <retpolanne@posteo.net>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 4:19=E2=80=AFAM Anne Macedo <retpolanne@posteo.net>=
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
> ---
>  tools/perf/util/machine.c | 29 +++++++++++++++++++++++++++++
>  tools/perf/util/machine.h |  2 +-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 527517db3182..373a3b852f72 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -3266,6 +3266,22 @@ bool machine__is_lock_function(struct machine *mac=
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
> +               } else {
> +                       machine->traceiter.text_start =3D 1;
> +               }

I think you can remove the else part as it's initialized to 0
and the addresses cannot be 0.

> +
> +               sym =3D machine__find_kernel_symbol_by_name(machine, "tra=
ce_contention_begin", &kmap);
> +               if (sym) {
> +                       machine->trace.text_start =3D map__unmap_ip(kmap,=
 sym->start);
> +                       machine->trace.text_end =3D map__unmap_ip(kmap, s=
ym->end);
> +               } else {
> +                       machine->trace.text_start =3D 1;
> +               }

Ditto.


>         }
>
>         /* failed to get kernel symbols */
> @@ -3280,5 +3296,18 @@ bool machine__is_lock_function(struct machine *mac=
hine, u64 addr)
>         if (machine->lock.text_start <=3D addr && addr < machine->lock.te=
xt_end)
>                 return true;
>
> +       /* traceiter functions currently don't have their own section
> +        * but we consider them lock functions
> +        */
> +       if (machine->traceiter.text_start !=3D 1) {

Then you can just check if it's non-zero here.


> +               if (machine->traceiter.text_start <=3D addr && addr < mac=
hine->traceiter.text_end)
> +                       return true;
> +       }
> +
> +       if (machine->trace.text_start !=3D 1) {

And here too.

Thanks,
Namhyung


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

