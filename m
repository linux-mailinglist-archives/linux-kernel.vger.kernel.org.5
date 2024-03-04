Return-Path: <linux-kernel+bounces-90091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF23D86FA36
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561681F21643
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE711731;
	Mon,  4 Mar 2024 06:45:34 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9AA11C80;
	Mon,  4 Mar 2024 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709534733; cv=none; b=OOz1lo3mRQi5tAjNBSTbE/AFgK7VQCCfL4+KWJITjX0C1igVeTtVcO1xN5l1UdshveLDhAVLPQXpjRfmv7cnIyKbFzyqF2DVYv2Eu6PEB2Ck6OBpLuZw9tZnqfUKWXoKtRrivm+czTUd0lZxXSmVxHJb04qkrNsEu6iWEizBpuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709534733; c=relaxed/simple;
	bh=6Uu8xa55c8DULF3ppbXOa4fSBPHyOdf3aLeFqGDK5so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhHoacU3liREfJgYb5mQejHw9QikVhHd0xV+G0m+RASvvkCYpMN6khjnqvdJvtdLnXDDRfrtpo8E/zPrpCpvYRmm+hG7BbHvL1sbDjPCQJnRpCHoVBvJGyKwZcCmZS38V26J69+fJ08N4VX7vo9ptQjouHpZFpkG0fEGr0UCnhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-299b818d63aso2975639a91.0;
        Sun, 03 Mar 2024 22:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709534732; x=1710139532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdBfdlVEHddJCDG9FaCI+sxFZG9z0a/9PfXhMIaBlrQ=;
        b=NP+LD4kY3lNVIESNjLLsQPH803JuIfFLeViLmvAbMb/ngs7MpdpwaHzY2G9bJzzRkw
         VFPyNOVGn2F51HlVC+3nQs75O843nTAp1TTVWkBS3VGJXCmqJPK95K+24Xm1d5HXt1Nz
         dAtJSzOWeZ4mDx39HQX8G5zT9cbvbPUrc++MF7Tb7nnJsR7UBSF2mLCWiwa2q5hTOmrd
         7I2KgZnsWVV6OpTKNkk8b7xWYCQFNsUAEkOhlGn5X1a7HUtI1U+k5rmmQWZgTzLoFo09
         ubazoJpDdP41jozeVv7TUZGG6p+WL5k0hV56sz/3Ruu8MirpEFJ7mGVTZjgKJWBnv11b
         apiA==
X-Forwarded-Encrypted: i=1; AJvYcCXmJ9+zIOFAILSjuddULNw95+LSqnJ4aQP0w4q2zIJq5/g8UBtgzOKOLmAe2pN+sj1PUQll/o+MVSmJR00lMaoDEesNz9Zx+MDFi1GByDTRTnl+zs2826NUu0kd8cLgm4drsu7cfSgDGtXLd77byg==
X-Gm-Message-State: AOJu0YyzcLMJCnHQFoYyzSWFQ0Mm2wQ4kUL9gbcACsMUSt9fmmvXxQqT
	FJWvkszIYqiXE02E6It60D/LtwlGLqK1eRaoISEYOZG75KtM8cfzKmri8TNyzI4lPhn9Z5EqG7R
	ybaP2E9UvwcK7+s7sRjMRRXGmv8c=
X-Google-Smtp-Source: AGHT+IEYKJjljiCsnptZUihoUc5d0E9Rrm0JqwX8DUwWiZ6Hegxtw1yFb9aMsFwJnAks5/YFPnWWUYjDmVqHSZf5QJs=
X-Received: by 2002:a17:90a:6286:b0:29b:1ab3:ed77 with SMTP id
 d6-20020a17090a628600b0029b1ab3ed77mr10648400pjj.21.1709534731664; Sun, 03
 Mar 2024 22:45:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301053646.1449657-1-irogers@google.com>
In-Reply-To: <20240301053646.1449657-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 3 Mar 2024 22:45:20 -0800
Message-ID: <CAM9d7cikTKZiW8dquh7VaFnBo0h2f7UGz+KUrvDs54Bwv=PB2Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Thread memory improvements and fixes
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Thu, Feb 29, 2024 at 9:36=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> The next 6 patches (now 7) from:
> https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
> now the initial maps fixes have landed:
> https://lore.kernel.org/all/20240210031746.4057262-1-irogers@google.com/
>
> Separate out and reimplement threads to use a hashmap for lower memory
> consumption and faster look up. The fixes a regression in memory usage
> where reference count checking switched to using non-invasive tree
> nodes.  Reduce threads default size by 32 times and improve locking
> discipline. Also, fix regressions where tids had become unordered to
> make `perf report --tasks` and `perf trace --summary` output easier to
> read.
>
> v4. Add read lock to threads__for_each_thread, Namhyung.
> v3. Factor threads out of machine in 1 patch, then move threads
>     functions in a second.
> v2: improve comments and a commit message.
>
> Ian Rogers (7):
>   perf report: Sort child tasks by tid
>   perf trace: Ignore thread hashing in summary
>   perf machine: Move fprintf to for_each loop and a callback
>   perf machine: Move machine's threads into its own abstraction
>   perf threads: Move threads to its own files
>   perf threads: Switch from rbtree to hashmap
>   perf threads: Reduce table size from 256 to 8

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/perf/builtin-report.c           | 217 +++++++++-------
>  tools/perf/builtin-trace.c            |  41 ++--
>  tools/perf/util/Build                 |   1 +
>  tools/perf/util/bpf_lock_contention.c |   4 +-
>  tools/perf/util/machine.c             | 341 +++++++-------------------
>  tools/perf/util/machine.h             |  30 +--
>  tools/perf/util/rb_resort.h           |   5 -
>  tools/perf/util/thread.c              |   2 +-
>  tools/perf/util/thread.h              |   6 -
>  tools/perf/util/threads.c             | 190 ++++++++++++++
>  tools/perf/util/threads.h             |  35 +++
>  11 files changed, 478 insertions(+), 394 deletions(-)
>  create mode 100644 tools/perf/util/threads.c
>  create mode 100644 tools/perf/util/threads.h
>
> --
> 2.44.0.278.ge034bb2e1d-goog
>

