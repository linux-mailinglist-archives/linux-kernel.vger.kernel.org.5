Return-Path: <linux-kernel+bounces-99352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E22878720
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB2D1F21A16
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50B653E12;
	Mon, 11 Mar 2024 18:17:16 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6F5537E3;
	Mon, 11 Mar 2024 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181036; cv=none; b=hKKjYYXr57ePfOrUXoLBvwR9XmRo8rDIlR2ydRgkX/M8i00OGw/CiuuHqkcAP2rJ5NXMpfXBe57/96vpsPEYwvSsOq6rzS7hyBqGVJnWxhOqMt2wAIk/ZmJ3v8oJjLp02/ZUhgvZZctAqApiA6t53t+cDBiw8lvZfrrS1hZFRs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181036; c=relaxed/simple;
	bh=i30HJipBERyBeNnBGt/AmRXW/1xlVlVVTCl0skxzybE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5v988Gs2bwszM2zBqHkGsMJr616GSII3qN1kfx2MlR+SJPqz5NjW5KKnGCOHpRJ8uqSh6muTEelGBn+F3U/X+6R2ZDv5QHU0Q6CrLGIcs85MZkztfgsEhOPcnzBnwUhHDerhTYDBpskNiop+Y0bMtP37vs9vFuxqfYNsZ/2qpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29a8911d11cso2584713a91.1;
        Mon, 11 Mar 2024 11:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710181034; x=1710785834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inO+ZkWQOzLmMHjS1ustIMza3dommiYmwCPrQAo/hpg=;
        b=B6Dr62QWJEwawfEWmKCUNZ/Q6MWMHtQ/l658d7ypWr8J9vlqoPv07kNFKIG713ZZtb
         QYW84wDqe3MyHveskN/4VONJDCKUlr3FlVMh/YLKUjh2A1cSEFlx+edTYZLitpGfpkYZ
         QQBBFnZbP2Ln43m9oyRCvF4APjY4FTX4ey94C5kSRRERFCIkFMXjxMIge2MJbhYh8OAk
         gmtV0wfnrUYR1kVsiLcQzqkR6FYo9DjO2tKI05x90D+JUn2Xrpfb2eAgvybOpyLk9eE1
         +QnIDVjg6UYWNbywpdCt0efEREpe5dUUhTYYfeiBDTNjKzFuoxnv55wbTq1y7qhODhZF
         Q5wA==
X-Forwarded-Encrypted: i=1; AJvYcCURbZgkAUGjH1+3z1B1siRWPaBmWGIaVVAlc6v5WPAOXB+qpKHslfE73DhekrOnvwvYbQFSid0rLwEvLCm34TLAwqii4NVXVbtxwibBj69eMYXdxTDtxoI9l2FaLHg8ZLl3Ed+y7sPQ0tltOcz+2g==
X-Gm-Message-State: AOJu0Yyh5YyFYSB21JXQGbo/WDZXiT1JUvurl8q9NgSO7NkNQMznkS5b
	EzyHGcUEKrfuyUGjZp1lCMJO8Vvsy2FAs2W5kzs6tzckcK18fC2TwjRMlCt8dZGsdiFwN1biMHQ
	Fb8PiGyy/FTTKKblNoqUg6jK5gTc=
X-Google-Smtp-Source: AGHT+IG+GzYXuKcTtjLrrDQoKIvbdrrpEw5q8H0qipehz120xzyhA2PoOsg2xGaLG5crSVElf91HyS3P+xOzG7JpSHA=
X-Received: by 2002:a17:90a:fb98:b0:29b:b322:1a1d with SMTP id
 cp24-20020a17090afb9800b0029bb3221a1dmr1375742pjb.21.1710181033924; Mon, 11
 Mar 2024 11:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309132710.1055941-1-retpolanne@posteo.net>
In-Reply-To: <20240309132710.1055941-1-retpolanne@posteo.net>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Mar 2024 11:17:01 -0700
Message-ID: <CAM9d7cjhiua5rBj=CTDJJC-XJN6PzKxQ5DsooJGEz0QcQAry7w@mail.gmail.com>
Subject: Re: [PATCH v1] perf lock contention: skip traceiter functions
To: Anne Macedo <retpolanne@posteo.net>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Anne,

On Sat, Mar 9, 2024 at 5:27=E2=80=AFAM Anne Macedo <retpolanne@posteo.net> =
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
> changes since v0:
>
> - skip trace_contention functions
> - use sym->end instead of __traceiter_contention_end for text_end
>
> Signed-off-by: Anne Macedo <retpolanne@posteo.net>
> ---
>  tools/perf/util/machine.c | 17 +++++++++++++++++
>  tools/perf/util/machine.h |  2 +-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 527517db3182..db443947ccd1 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -3266,6 +3266,14 @@ bool machine__is_lock_function(struct machine *mac=
hine, u64 addr)
>
>                 sym =3D machine__find_kernel_symbol_by_name(machine, "__l=
ock_text_end", &kmap);
>                 machine->lock.text_end =3D map__unmap_ip(kmap, sym->start=
);
> +
> +               sym =3D machine__find_kernel_symbol_by_name(machine, "__t=
raceiter_contention_begin", &kmap);

Unlike __sched_text_{start,end} and __lock_text_{start,end} I guess
this traceiter thing is optional so it might not be there.  You need to
handle if it's NULL.

I think it depends on the kernel version and configuration.  I remember
I saw a different symbol on old kernels.  But it'd be hard to handle all
the cases.  Let's have a single trace text section in the struct machine
and use __traceiter_contention_begin only.  If it's not found you can
fallback to trace_contention_begin.

Thanks,
Namhyung


> +               machine->traceiter.text_start =3D map__unmap_ip(kmap, sym=
->start);
> +               machine->traceiter.text_end =3D map__unmap_ip(kmap, sym->=
end);
> +
> +               sym =3D machine__find_kernel_symbol_by_name(machine, "tra=
ce_contention_begin", &kmap);
> +               machine->trace.text_start =3D map__unmap_ip(kmap, sym->st=
art);
> +               machine->trace.text_end =3D map__unmap_ip(kmap, sym->end)=
;
>         }
>
>         /* failed to get kernel symbols */
> @@ -3280,5 +3288,14 @@ bool machine__is_lock_function(struct machine *mac=
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

