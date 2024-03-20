Return-Path: <linux-kernel+bounces-109295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F89881756
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAC9283B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807282D6C;
	Wed, 20 Mar 2024 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH0VdWOP"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CFE82895
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959529; cv=none; b=aS4Vk1o/vbZnfweiNsV0BdRd+YLNL7yif3ycHgbE4fmrY+CFO8YslTu+gw0fx6a1/94x8zj23BjpDe6OVvZJqlk+LrifC/YnehaUp8VkCPFwKjFrAig8Q6XFHHQ1wJo1+5fvP5mlaAnIcPnABbmNDyDMyIoR8Ut3ySd/HLQ/TwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959529; c=relaxed/simple;
	bh=OZJmzQmsq8RoLA2HV169YApdqFmaoOPy04ZyTtr6fZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpJ4wSJIZsrYrP1tEL1Xf2Gz1qsiK2D9gKGvS9tBHq/ur6VJcGsbDu/IOKUzXSEeppPbb9z6aQgF32I0e4ddFggvMi9yLPbup4oxS7vP8IYfy6jjXJeuv5rxwkdZxIloVlc221bqzfNcUvj87gQ1fUWn7B3TmzOVEYdbnuZhbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KH0VdWOP; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-609f4d8551eso10305707b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710959527; x=1711564327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=erL2M4LXM/B+qCyMj42WmQgW5yD4BAoh510aD1gL/bY=;
        b=KH0VdWOPdHmI+OOXsoa73qTeuejrmhc9/r1V5H6MAtBMeE7KPfcORTjNs+DWFNqMXO
         DgiQlSyNT2zT9RYF1qoMRubtj2tjKT9TAAZuO0W3IkKJAMRcgauIR+OsVMR7U0x5UlWc
         zh/OOy7FJ4EbPSiyvQ7FB6Wk0lRApvrUuF4a6lswdBt0HVskvv7RZQhYfvRiFovqo3Bt
         Preb7f3/lqeU+F14iJ+Uwk05ZWUX7HNpDoWAZIuHsKLij01X02/NqXZy50X6XAcCUyQU
         kK1kg2YTWcI54bpRa9BsEcdYS9Fwb22n5SqZGo281ajgcxcrMiSDYPhFuHTTN2oy64iu
         QyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710959527; x=1711564327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erL2M4LXM/B+qCyMj42WmQgW5yD4BAoh510aD1gL/bY=;
        b=fJJLRALb+8hdLDyyDymCIFtJkntjbOhr1OgbKPUEsmcvlGUr+C7pc7kHPr08iCkMf9
         aodd+hnvP1g/NOej9qxOUdv/nckh9AGYYPQdM3+zzzquyDIn/knyPeKpdJZ9qRQ+v1bY
         X/H2+5luIfdRxLwu1SJQDQQt3ZQ1OLSH5EOAHcITsU7H6fEas3YtZ7WuUMLqpv82yIMa
         Mpu2c9Y36ZmI1P+vYqaNbx8KfbFsH7aE0xgCRJ4e0tGBK857n2vHyObrBvMm9uo5OM0D
         l443BxQCz7M1tSXnh5Q5Mvb2eo111RuLR/kOJ4MVKvTNX0TbkfhM114u5FWuq7khVrrF
         Ps8w==
X-Forwarded-Encrypted: i=1; AJvYcCWnl4X22bI+TgHIZq8MNErrBA1FwDYe/1eJqNJsj/UgI1WOPpUwHNZumRhcm8Utf5wMBg1866QMFAeBFfrOt0WZwyPMilA34pavO0Kz
X-Gm-Message-State: AOJu0YxWys1uGtbgKPepHFg2NEmZsAHu5O2mW8jaCSNAsLqjs4qYCUHv
	kHWq6GsGR5l/hUxg0JNXtt6ciHm7lpHnsj6bMrNF/EixnU3sUUY1
X-Google-Smtp-Source: AGHT+IG/HqMq4IMKXfwzps1/x209o+xTcCrvRk4XRJHKBNzwXYERQupsWLFkug/lhR3k9DUzv2nVJQ==
X-Received: by 2002:a81:7342:0:b0:610:d7c1:b92d with SMTP id o63-20020a817342000000b00610d7c1b92dmr402305ywc.14.1710959526727;
        Wed, 20 Mar 2024 11:32:06 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:a6a6:49c0:6a02:df54])
        by smtp.gmail.com with ESMTPSA id v32-20020a81b720000000b00610b502dd20sm1871446ywh.51.2024.03.20.11.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:32:06 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:32:05 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, russ.anderson@hpe.com,
	dimitri.sivanich@hpe.com, steve.wahl@hpe.com
Subject: Re: [PATCH 2/2] sched/topology: Optimize topology_span_sane()
Message-ID: <ZfsrpeCgsWMQ4emW@yury-ThinkPad>
References: <20240319185148.985729-1-kyle.meyer@hpe.com>
 <20240319185148.985729-3-kyle.meyer@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319185148.985729-3-kyle.meyer@hpe.com>

On Tue, Mar 19, 2024 at 01:51:48PM -0500, Kyle Meyer wrote:
> Optimize topology_span_sane() by removing duplicate comparisons.
> 
> The total number of comparisons is reduced from N * (N - 1) to
> N * (N - 1) / 2 (per non-NUMA scheduling domain level).
> 
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>

Reviewed-by: Yury Norov <yury.norov@gmail.com>

> ---
>  kernel/sched/topology.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 99ea5986038c..b6bcafc09969 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2347,7 +2347,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>  static bool topology_span_sane(struct sched_domain_topology_level *tl,
>  			      const struct cpumask *cpu_map, int cpu)
>  {
> -	int i;
> +	int i = cpu + 1;
>  
>  	/* NUMA levels are allowed to overlap */
>  	if (tl->flags & SDTL_OVERLAP)
> @@ -2359,9 +2359,7 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
>  	 * breaking the sched_group lists - i.e. a later get_group() pass
>  	 * breaks the linking done for an earlier span.
>  	 */
> -	for_each_cpu(i, cpu_map) {
> -		if (i == cpu)
> -			continue;
> +	for_each_cpu_from(i, cpu_map) {
>  		/*
>  		 * We should 'and' all those masks with 'cpu_map' to exactly
>  		 * match the topology we're about to build, but that can only
> -- 
> 2.44.0

