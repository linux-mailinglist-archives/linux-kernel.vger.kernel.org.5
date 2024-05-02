Return-Path: <linux-kernel+bounces-166163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 001138B96FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D731C21A81
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCB443AB3;
	Thu,  2 May 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ls72qZyf"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0625634
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640235; cv=none; b=gakjqkmxfRk5qmCQ4bCsFZQWQdkBCc5f4u8FeloHvbRD3JPpbnQvgFd/T5WnuaQ/lFf7cYix5J339X4ymuk4IcuSueKrzu2zh9b+qFAZPiig9w1T1s/evVsjnq/A4jHnC/0pZ5Bc5MGfip49/4zpQCuMEYj9xw33MkyWfI1nqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640235; c=relaxed/simple;
	bh=sa/8HDfFL5CFAauNZ2UMFU9u1zkFTrNif2xikpD73u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKCUVlcHtKOnFOhQRQSNYNRUHoDQMJSUVo3iF2c5k8lQIqiSqchuOJCWFfd0GrNy4HrK+BQsW8reaOUcHXoHq9Wf/ycwuSQo0GnSpMA5OaEjWY6B94OMcGFrsF1o0uy5p4ZKIXDwKW6UqV5xaBX0D526BAj5AtRko+2eqIajl30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ls72qZyf; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso6296322a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714640233; x=1715245033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4r1Ogu9VhTDx/tfecsOBWKHykrKbw6y12iAWdXGVaIU=;
        b=Ls72qZyfwsGai+8Lre/x1zGcIzFegRC6AZy8VMOSBVEy/Pr1WIYAuD345J4NMe6nOF
         Tphmr2KrIMOm0FAcoTp8Fk/Zbf2jiyvcuECh+TVLTkjN5W93eY6HvP9mHvYVTl8YhHnT
         glU4qzL2W8Aam+rBQCY4MOnuZ8e9FUF3omy0mK4xEbQlIzDyM93kZwPs2Tv9qhCe0gmz
         gWRePthVp+gToUIyWZW84IJMPSdCezNpvJ8aoN7TDH9FwkdNkc1ZAAHqkoPJsWq2sKyK
         VY82dtias30pkNxvbnJ9MdMg9898jKBzaHoMd2eGZpY3cBtrVLlJLQHhOeDK1Jyo/bL1
         /qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714640233; x=1715245033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4r1Ogu9VhTDx/tfecsOBWKHykrKbw6y12iAWdXGVaIU=;
        b=dBjnCi13QGQZ3aridJoh/6cY9OGWAWaGqyeItkjhIi8znMwnGcU4wvlmqayhoL6E0a
         h0swELPkKezlWlar4L8kLuvL8CCacgabolvTng/6KHWY6jJXNzHADHxO79EHE1BBzhGl
         TE4KnXlpnGdgE8bcGncCFHvhsqkLlbFw1zcF3BpJKQuTAgHdLn+uHB0i3p/WdYZ3fgp+
         XuTAIIGHLzGOJRW1qTP+N4PjqyWZh4sv0mWkyXoTVxKir3AWYEU3LWoxAn9Z9rljzUfz
         p5i88kND2TUYzOVaVFiQOhXnpOJJjDvybRmjg9W1ytG6zsuf4hH3+oXUUPUqykNTThk8
         qi5w==
X-Forwarded-Encrypted: i=1; AJvYcCW4xINH4K7TDZL9NPR5ZXlWRXIR5kTdfBgIwIdon7uNTQUnmh7P7raZWnIt57QTH/PWEuBt2YYQufk/PZiYCNJ/vKzrAruqeTwz8B7L
X-Gm-Message-State: AOJu0YxwXHXdl34t/5Z/5YVoW5fg33R7gLCl35zrRjUUpDb0AHumuETQ
	6nhnT/V1X8RoVbMllZ4uqnzwew8J+ST6Xpo5S8mhqqIZoWeghfqX88yMagGJX7Tq67KV6S6T8qF
	KGFaPeTbJVGkJmtNGx/lI6bSRY9Ydz0f8GcrFkw==
X-Google-Smtp-Source: AGHT+IEe2eAuToBWuTwXa55lTIfNnyP7Y8GQeBJFrOCwkGsAoaPlIj7shcgafUBSRnhEQEvdKszCho278n3qNeY5erA=
X-Received: by 2002:a17:90a:e549:b0:2b2:7e95:e3ef with SMTP id
 ei9-20020a17090ae54900b002b27e95e3efmr1476669pjb.44.1714640233122; Thu, 02
 May 2024 01:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424132438.514720-1-serein.chengyu@huawei.com>
In-Reply-To: <20240424132438.514720-1-serein.chengyu@huawei.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 2 May 2024 10:57:01 +0200
Message-ID: <CAKfTPtAeHeTKnbfE160ChxpVDK5FAS8SHn8TSFMpSWNQrizPVg@mail.gmail.com>
Subject: Re: [PATCH] sched/core: fix incorrect parameter burst in cpu_max_write()
To: Cheng Yu <serein.chengyu@huawei.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	changhuaixin@linux.alibaba.com, shanpeic@linux.alibaba.com, 
	dtcccc@linux.alibaba.com, tj@kernel.org, linux-kernel@vger.kernel.org, 
	zhangqiao22@huawei.com, judy.chenhui@huawei.com, yusongping@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 15:29, Cheng Yu <serein.chengyu@huawei.com> wrote:
>
> In the cgroup v2 cpu subsystem, assuming we have a
> cgroup named test, we set cpu.max and cpu.max.burst:
>     # echo 1000000 > /sys/fs/cgroup/test/cpu.max
>     # echo 1000000 > /sys/fs/cgroup/test/cpu.max.burst
> then we check cpu.max and cpu.max.burst:
>     # cat /sys/fs/cgroup/test/cpu.max
>     1000000 100000
>     # cat /sys/fs/cgroup/test/cpu.max.burst
>     1000000
>
> Next we set cpu.max again and check cpu.max and
> cpu.max.burst:
>     # echo 2000000 > /sys/fs/cgroup/test/cpu.max
>     # cat /sys/fs/cgroup/test/cpu.max
>     2000000 100000
>     # cat /sys/fs/cgroup/test/cpu.max.burst
>     1000
> we found that the cpu.max.burst value changed unexpectedly.
>
> In cpu_max_write(), the unit of the burst value returned
> by tg_get_cfs_burst() is microseconds, while in cpu_max_write(),
> the burst unit used for calculation should be nanoseconds,
> which leads to the bug.
>
> To fix it, we get the burst value directly from
> tg->cfs_bandwidth.burst.
>
> Reported-by: Qixin Liao <liaoqixin@huawei.com>
> Fixes: f4183717b370 ("sched/fair: Introduce the burstable CFS controller")
> Signed-off-by: Cheng Yu <serein.chengyu@huawei.com>
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7019a40457a6..d211d40a2edc 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11402,7 +11402,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
>  {
>         struct task_group *tg = css_tg(of_css(of));
>         u64 period = tg_get_cfs_period(tg);
> -       u64 burst = tg_get_cfs_burst(tg);
> +       u64 burst = tg->cfs_bandwidth.burst;
>         u64 quota;
>         int ret;
>
> --
> 2.25.1
>
>

