Return-Path: <linux-kernel+bounces-166828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB988BA020
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF081C223BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7925172BCE;
	Thu,  2 May 2024 18:15:05 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6016FF2B;
	Thu,  2 May 2024 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673705; cv=none; b=gBLHwoOd9sumAw0v35mcTLHEEct21/YdYzFg1mn568gKFY71fHtWGjiZLPjNTfG5asNoeGhrwxkf6FxAb7L26/w7yX7zPE02YpYYdevjiq3zyEDZGk6v2b6ReRmWuu6ljmgCmp3YtmGPn+r8UAVI6B3e6jcKBzUri9eeuXNUOPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673705; c=relaxed/simple;
	bh=ZA92IXsc0X3IgFWFWIxdK48Y8F36zabbvP6VZiHZCog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsYIMekkiDmPtItxkeLHK2udJeI8olDZMmOQTPmeuOymHUnv476TcTuw+VnNFMHQzaSTHV0a6sdOf9MEBuhHp5Td+CmTUfmkBm2iLFXroaJujYKUWzLwHNb5ZBmzvCo5j/cw5MZvbgm/vI1bzQPs5pi9Fzd5Vy9ONiIwXYUJnPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ad8fb779d2so6652876a91.0;
        Thu, 02 May 2024 11:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714673702; x=1715278502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jX8aKvbafhGbnZvdnKVSz/mpn0msgf30qB56G9DbOhQ=;
        b=m4AjLkZwcMEUaEJbiLcPW1I+HhN0n2AOr6yG+CcY3vfEVAdEzRmE8mEZ8mVxH8U0YK
         k0nFWjZwjBP3E6zM7tV8paMAjsqphVwLMms1USEZEPG1/124N+WPznxmUQzSi/CJYcHo
         oyj0JDJaSXiU1/myBStaFnvsdvLnELwJ9A3PuYI7FeTzzAARtmAQNp1T3Z7vopjAHO8v
         ieuEd+9zvc9Zx0IMgfpabOQN6GazsHmV9O5ly2GfWe9IWmBKa2cuykoXkWyF385VL5tc
         KcUXnGHUHIqjF41fcdnprcnxWxiPn/+2nMubKzzuYTLeSps2eAavs2y+pU4bo8EzNEmA
         2XvA==
X-Forwarded-Encrypted: i=1; AJvYcCWo27RR0zZTWIScnoaM3ytUsXFWFvsJRQxreKCm9LN71b0xHjd0wZBvLLuMkVgW+EXb7Tx+sDl8kAbZ7KIbAaPM+jq5m5XE9ZoFzkC0JoweyB9iSN9r9XgZ/dIGcBGW/pfhfOZFuz1EjHnOdMlKgQ==
X-Gm-Message-State: AOJu0YyJTxM0pWx6gbb9PmgcPc3nxFK9VYup92Bjct1Xt4M+VRbF1Rl7
	qc0cCxQDVOM2ge52daL2325wIu4Kqs+66HhpRk9dVl0SdTRwvChXJNvyMXK0Fxdh1bCs6B07LdZ
	mIIiN6p6bedzfpHFzbMHtw/HVxdI=
X-Google-Smtp-Source: AGHT+IHavTkVVIrzDWL1qUo+gBIJUOmiH9xgSYf34ilpJN5TlE5NU3ymJCXRyeLNnhZFgJIIC6yItiB9cR3pPMlffSQ=
X-Received: by 2002:a17:90a:c697:b0:2b2:32c2:44b4 with SMTP id
 n23-20020a17090ac69700b002b232c244b4mr635207pjt.10.1714673702312; Thu, 02 May
 2024 11:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502060011.1838090-1-namhyung@kernel.org> <20240502060011.1838090-5-namhyung@kernel.org>
 <ZjOdkHraWXZIuSy_@x1>
In-Reply-To: <ZjOdkHraWXZIuSy_@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 2 May 2024 11:14:50 -0700
Message-ID: <CAM9d7cg_YL1x8YfJ5+7+o+0dccFJJxUye8L_FLrgdGeAh81LBA@mail.gmail.com>
Subject: Re: [PATCH 4/6] perf annotate-data: Check memory access with two registers
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 7:05=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Wed, May 01, 2024 at 11:00:09PM -0700, Namhyung Kim wrote:
> > The following instruction pattern is used to access a global variable.
> >
> >   mov     $0x231c0, %rax
> >   movsql  %edi, %rcx
> >   mov     -0x7dc94ae0(,%rcx,8), %rcx
> >   cmpl    $0x0, 0xa60(%rcx,%rax,1)     <<<--- here
> >
> > The first instruction set the address of the per-cpu variable (here, it
> > is 'runqueus' of struct rq).  The second instruction seems like a cpu
>
> You mean 'runqueues', i.e. this one:
>
> kernel/sched/core.c
> DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>
> ?

Right, sorry for the typo.

>
> But that 0xa60 would be in an alignment hole, at least in:
>
> $ pahole --hex rq | egrep 0xa40 -A12
>         struct mm_struct *         prev_mm;              /* 0xa40   0x8 *=
/
>         unsigned int               clock_update_flags;   /* 0xa48   0x4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         u64                        clock;                /* 0xa50   0x8 *=
/
>
>         /* XXX 40 bytes hole, try to pack */
>
>         /* --- cacheline 42 boundary (2688 bytes) --- */
>         u64                        clock_task __attribute__((__aligned__(=
64))); /* 0xa80   0x8 */
>         u64                        clock_pelt;           /* 0xa88   0x8 *=
/
>         long unsigned int          lost_idle_time;       /* 0xa90   0x8 *=
/
> $ uname -a
> Linux toolbox 6.7.11-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Mar 27 16=
:50:39 UTC 2024 x86_64 GNU/Linux
> $

This would be different on kernel version, config and
other changes like backports or local modifications.

On my system, it was cpu_stop_work.arg.

$ pahole --hex rq | grep 0xa40 -C1
    /* --- cacheline 41 boundary (2624 bytes) --- */
    struct cpu_stop_work       active_balance_work;  /* 0xa40  0x30 */
    int                        cpu;                  /* 0xa70   0x4 */

$ pahole --hex cpu_stop_work
struct cpu_stop_work {
    struct list_head           list;                 /*     0  0x10 */
    cpu_stop_fn_t              fn;                   /*  0x10   0x8 */
    long unsigned int          caller;               /*  0x18   0x8 */
    void *                     arg;                  /*  0x20   0x8 */
    struct cpu_stop_done *     done;                 /*  0x28   0x8 */

    /* size: 48, cachelines: 1, members: 5 */
    /* last cacheline: 48 bytes */
};


>
> The paragraph then reads:
>
> ----
> The first instruction set the address of the per-cpu variable (here, it
> is 'runqueues' of type 'struct rq').  The second instruction seems like
> a cpu number of the per-cpu base.  The third instruction get the base
> offset of per-cpu area for that cpu.  The last instruction compares the
> value of the per-cpu variable at the offset of 0xa60.
> ----
>
> Ok?

Yep, looks good.

Thanks,
Namhyung

