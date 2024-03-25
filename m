Return-Path: <linux-kernel+bounces-118159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C719288B694
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632BDB3C2CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF70839FC;
	Mon, 25 Mar 2024 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iieNI8fM"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED482D90;
	Mon, 25 Mar 2024 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408472; cv=none; b=W7erh6GZmNnDMh2RKt8Ooi3/+Ydv0ZIRKAuOGLbDnP3NaO/hmRkmVnNNtxKl0HAC/YEIcBZ45ij9PpmIhRKkZQ/yo13/bUxjfPYls/d3o5nVId/p2HNT8MeIavLwl34WuAQnGrqLM2Oq4yGAZJzxPjL+xsMq53l+su7g5+72QeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408472; c=relaxed/simple;
	bh=06TOXQCi5RKMcovaZsXCGquZGkXuqjIcnKZqO3Wu4Ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItLOPO1wYUGjcwtF/dptXBvDNQytHeAEm8Xan2lj5mCFy4Lxqe/cYeoeQe9ucMjuAhpdy/mwrltSo59fRQmkA2MeWvYo+vetFSo/8EVV9tPv4dUnPE8IYnbPtwRN8ud9KIbhj0KTbbd18pJQR/Af+3kUmSqXGKv2dtv4WUBRFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iieNI8fM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1def3340682so40200955ad.1;
        Mon, 25 Mar 2024 16:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711408470; x=1712013270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NA+R3becyndYRGT5f8sRZeSnD9n4TKt3ID9pBHYfjo=;
        b=iieNI8fMf+U7/f6xvIY/x3uJJ6gAqOUfnDAnwU4TYSeJOSKq4+HixgseY6BAz8Z55D
         4axv4Q89DF7t8R1sK+HM5xPBLxD55CxniU4sotk5vxu0jyN0A7XZtaQbjADu88lPjqNG
         9srCw1/AnqPsCCRSnf8/62Y+4/Z2ONS0heiGUW7DYeRDV+aX+AyaGXsyCGxEdEAfFWlf
         R/iXRAS+dBLQA56it0hn+6+Ftnha0gABxB9fsD+5UeMTeRmAMhELBj4KF10AXN7awOzT
         mxxsSnb7YmN+PehmW/zR7ua6WVExqYXt+6A31L1bUxyWFh9UriduT/Dhe0074frjEodZ
         BjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711408470; x=1712013270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NA+R3becyndYRGT5f8sRZeSnD9n4TKt3ID9pBHYfjo=;
        b=QoOJB44E+iyTqJVk/p3TXAugqRQN31UIZpP07lk7LB93zDT3yqkbW1ihr4RfM/62/7
         9JDy2MmoKGB25Im+nyH487TvyDHTh7IhNv/shjtgVhSfNKiSTs+65sJV+jtCg3lyyWyN
         IQ/U86/42WL9uHdSjhlOf76Odfve7tQAV4WCGcSR/ZLTzvUA+CCgOF4m977lEhoHtc96
         +ekvnD9M51cXNnI/xakVXP49QCRfLP6iTcAKNZrIUu2ZQL6tRTRqHpuLmzB+fsA8lhtF
         m66UTXO8q3ek7cYP1TZBowm4B5tmVxD3XC9o7ZIiW+OdrT0yYd6KCSMlEvddXGcvM2Qa
         SDkw==
X-Forwarded-Encrypted: i=1; AJvYcCWOHmnhJ3F8oesh6LhVh7T9TNrjWBR03gVBXZAeSdiBhZlGO45Mco7ptgmM6ufAqgC3R7JWeIQ1PtKnAOL2hKKo3NuXhNLeQBNtQ2BaKMU5JaO+wzkoyeehxgPVizrxjDqB3CGEI68efBFPTWpeQhnduGlLwzJnrXUsHjhtPnPwdy69zIW8gmcXL0Ajv6aQfvqpmsj9RHSsnAAv5QtPcELhdYTZll5Uyw==
X-Gm-Message-State: AOJu0YzJdlkUb3LlodBbswYaq+LXX4JTLyHOOhN/Mj6H49fzcPz5KTxi
	ZVjEAel96YBWPLf26rji4xinf2L1I7OUmiVu8/PRSvzJTTU7pW8rwhF+J01z2QAiFkVNXC/NLKa
	hg+ykcHWWvePZ7tHMPoUybpOjJuk=
X-Google-Smtp-Source: AGHT+IFxtJvxausC+t3c2Ddd3qmq7+4yC5kPd5b9eF5t4jHFtC+2YDB2Ym3wRBE6w7MeUZl3AFK1b7sboD4SM2UzNxc=
X-Received: by 2002:a17:902:dac3:b0:1e0:bd8e:5a66 with SMTP id
 q3-20020a170902dac300b001e0bd8e5a66mr5770221plx.8.1711408470124; Mon, 25 Mar
 2024 16:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321145736.2373846-1-jonathan.haslam@gmail.com>
 <Zf+d9twfyIDosINf@gmail.com> <syviklbpdblcwr3l2seuwyzfrg2hy2shx5f6ho6yf4s4ce63tc@nbo4by247y6z>
In-Reply-To: <syviklbpdblcwr3l2seuwyzfrg2hy2shx5f6ho6yf4s4ce63tc@nbo4by247y6z>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Mar 2024 16:14:18 -0700
Message-ID: <CAEf4BzZnUcFEk+7r39n8=zopBeK96wfQ4Vtndd2tY2ymqOpCtA@mail.gmail.com>
Subject: Re: [PATCH] uprobes: reduce contention on uprobes_tree access
To: Jonthan Haslam <jonathan.haslam@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-trace-kernel@vger.kernel.org, andrii@kernel.org, 
	bpf@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 12:12=E2=80=AFPM Jonthan Haslam
<jonathan.haslam@gmail.com> wrote:
>
> Hi Ingo,
>
> > > This change has been tested against production workloads that exhibit
> > > significant contention on the spinlock and an almost order of magnitu=
de
> > > reduction for mean uprobe execution time is observed (28 -> 3.5 micro=
secs).
> >
> > Have you considered/measured per-CPU RW semaphores?
>
> No I hadn't but thanks hugely for suggesting it! In initial measurements
> it seems to be between 20-100% faster than the RW spinlocks! Apologies fo=
r
> all the exclamation marks but I'm very excited. I'll do some more testing
> tomorrow but so far it's looking very good.
>

Documentation ([0]) says that locking for writing calls
synchronize_rcu(), is that right? If that's true, attaching multiple
uprobes (including just attaching a single BPF multi-uprobe) will take
a really long time. We need to confirm we are not significantly
regressing this. And if we do, we need to take measures in the BPF
multi-uprobe attachment code path to make sure that a single
multi-uprobe attachment is still fast.

If my worries above turn out to be true, it still feels like a first
good step should be landing this patch as is (and get it backported to
older kernels), and then have percpu rw-semaphore as a final (and a
bit more invasive) solution (it's RCU-based, so feels like a good
primitive to settle on), making sure to not regress multi-uprobes
(we'll probably will need some batched API for multiple uprobes).

Thoughts?

  [0] https://docs.kernel.org/locking/percpu-rw-semaphore.html

> Thanks again for the input.
>
> Jon.

