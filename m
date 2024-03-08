Return-Path: <linux-kernel+bounces-96969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FA08763ED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D401C210ED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CBA5647A;
	Fri,  8 Mar 2024 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yelj7KCq"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD856478
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899343; cv=none; b=u9RAKZyDDW2il8xc6SRs2OvS8K5qA8gKy5b4qoshNwR21L0HBaOrZYwu05Or6G1Rbr/q2Kutc4syO6hhYMDjvKqOrzdZXX0ct6/sKqxRdxA1WRc5W6oEsY8K2HodU82kKOxcRJfWBMu7mDNgJ95L1kX5Ua3BueR611S9cycEDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899343; c=relaxed/simple;
	bh=FLDz2NpyC6Myn7sIgxl303jihh2YBhuOLWWFLwNNCBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpSL9et2m3VvtqYbdYS2FcQuLR4Aec22gilm/0KIMNCJPlLixg7LqKU02iS3itrUXKeRJDtACThIovhTlQ79YZRTuFHBE9q8ydLritlCLkTMysU+JaUwlNt4zkGsvU+CXBHxXiqoVdPLVD6Br7ukm8DG0zIpWurlHhARN7uHLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yelj7KCq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e655a12c81so1615527b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 04:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709899341; x=1710504141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d9ZCbf/93pqQbLM7ea+Cwydkxajd4ef/mXSYYru8Nq0=;
        b=yelj7KCqV5HRdRvdoVJN4nXnP7+g6GvjWVS9b/bUyIyg87Kc7UVSjqShN4oFJ0UivH
         kxCICBcYKWIXT4uK3p1LJXEvPPL5gjBjlf50wWXRTfsUBBNYutrR/77Yq1XVhCOoK88O
         nwsv48umtjyu06w2Z8bfMR7UbDQn6/wpVkNh6sYBdabEJ2M2LokZ4YqWCPljypw70iL/
         wVJ2PZRd6uqKTl6XegnNdjaOoeZCQ/Y9fquq2Rob7JpQbNBfV2+0B3Nes5Jilm1y8qn8
         ie3WLPoUWkwRhPE/8MYZmZjrG1Gu5AMshnnXqbkGCkbxKFrhpo3W/5bM+iV5MgFSEaU3
         zPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709899341; x=1710504141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9ZCbf/93pqQbLM7ea+Cwydkxajd4ef/mXSYYru8Nq0=;
        b=F5Ilk4oMVChK//4rhSaXl180T77tZQ92wRMytcs41G2ufIdodw7T+QO1L8K2IHAB+p
         BelnYw+kSCpHl4no/ljMTunMsDLo0nDP5kSZ0pGGBBk1XqVAyLD9m34iDgJrZWYePlBk
         HGLpQHYF07qkqnWGtYaXqjd8YqYFCQ/JIjS9cTK11QYVkCkIb8w/g56BWU5ebpweSQ0r
         KU/J4Odp45XMlGKq6OJnNQs207ACaUnbfJQFjbx2zZDW7EodLLRfrr8piIiLZB0NeYyp
         YuPobdO1bJqWFhxNnR4zDT2pQdIkLsAx5IV7g5u3nGYvCW71zga0ysAiFm85h6RSp+6k
         nh3A==
X-Gm-Message-State: AOJu0Yx9Y1/fCRQnFCqPqqOeZUVdyZpPuYP1pOI/jmrZOMiunTRXE+eB
	0z4QvpuobwIUjVToKLaG/9TiFdGF4ovkXQmcjBexfoqsroT0g6YP3iY36KY+HlPlIbRpznMPFyk
	1m4XzmaVYmn729p9ep8AXFfF4Woe3Y6FI0eHMxw==
X-Google-Smtp-Source: AGHT+IFMVoCZdad1KTo+x1jkUMxOXJo3fL6t0MAoyoldEaATm+eGvl9KgTUdmYq4h4g9cz2FvJ74TvaTBEm3mD39PC0=
X-Received: by 2002:a17:90a:e2c5:b0:29b:1ab3:ed77 with SMTP id
 fr5-20020a17090ae2c500b0029b1ab3ed77mr24447pjb.21.1709899341488; Fri, 08 Mar
 2024 04:02:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308105901.1096078-1-mingo@kernel.org> <20240308105901.1096078-9-mingo@kernel.org>
In-Reply-To: <20240308105901.1096078-9-mingo@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 8 Mar 2024 13:02:10 +0100
Message-ID: <CAKfTPtD_Bi5FYCyQVCOmFhxGzByLBDxqFa4Ai4S8qZJ2URfLfQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] sched/balancing: Update run_rebalance_domains() comments
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 11:59, Ingo Molnar <mingo@kernel.org> wrote:
>
> The first sentence of the comment explaining run_rebalance_domains()
> is historic and not true anymore:
>
>     * run_rebalance_domains is triggered when needed from the scheduler tick.
>
> ... contradicted/modified by the second sentence:
>
>     * Also triggered for NOHZ idle balancing (with NOHZ_BALANCE_KICK set).
>
> Avoid that kind of confusion straight away and explain from what
> places sched_balance_softirq() is triggered.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f3c03c6db3c8..b567c0790f44 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12409,9 +12409,12 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  }
>
>  /*
> - * This softirq may be triggered from the scheduler tick, or by
> - * any of the flags in NOHZ_KICK_MASK: NOHZ_BALANCE_KICK,
> - * NOHZ_STATS_KICK or NOHZ_NEXT_KICK.
> + * This softirq handler is triggered via SCHED_SOFTIRQ from two places:
> + *
> + * - directly from the local scheduler_tick() for periodic load balancing
> + *
> + * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
> + *   through the SMP cross-call nohz_csd_func()
>   */
>  static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
>  {
> --
> 2.40.1
>

