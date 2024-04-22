Return-Path: <linux-kernel+bounces-154102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C768AD767
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DB4285859
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA971F94D;
	Mon, 22 Apr 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkoGiARq"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BD210F8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825887; cv=none; b=hutETIFjHN1S9HuN8nG1Krx3z3pRkkS8ca5HBfpUQM7HJg9CblYZ8dhmljTPYkJgOEte8xDMaInhBUx+XKo6wF0tbHB+JRlZcuKao9q4yBk0X7dDumPnSnPV8c2PcY7R/n/yjD11lEH9BUumgbYbuafvQixmvJsl9oS0ohSVsT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825887; c=relaxed/simple;
	bh=32e9lVdtJqoFoXLz4PAykbI7pAzpiZgd8+atu09Gz9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdBeOLgpVpXNyBf9LHinoeug7oXn7tVQ8WWod1xWa5Q5/ZwT5hLkQUwLj7vLm8KBO+EQj7c1XMYPC7TLiTigQg/Em7MC/nsaUKznI99UXTUbuj3TJ6QU6B6bid2c7mLbZySvJF+6L/8L8rbgVS8wbKOY0kGunWo1yX27FC9siVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkoGiARq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f30f69a958so927728b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713825885; x=1714430685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aDDVLwYcvEoLquUUa43udKP5AiZZTm01F2O/4zQSb8=;
        b=mkoGiARqrwPUPKL7amEuvV3l/RqiZaLaS1UFjtLOQn1vI7mcc66n3NEMAaiyHqRUhO
         AXvbbabs4B311GXSAqLDA4VWzShYjSlX0c/zwNVT22zYr/Os406E4SCrNLyrgZEeSQ3k
         Ckdfn7NEpNMrHYjBlw9eXV2OI0gaL8fvkaVrgPRhQ3Gkz3uuI4Wj83lPRXjCiJDzbgbV
         ivTpBvL0cD05uEFW5qH5sG3qRBhsfJCT3wNf4P2h2pRK4KRYgnPLCptcBUrY/Rc1MMlF
         JznK8difZBL8XGC5M+EyGUHJICW4+I+t6N45W4C6DFR3YXNecGthLHf5T+Vhd0EiYSaW
         TKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713825885; x=1714430685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aDDVLwYcvEoLquUUa43udKP5AiZZTm01F2O/4zQSb8=;
        b=b/vUX2uDvikgYryknsgB3ozLtUKYEX8iVLtlemtH2O66d5uV5fTQuGUN3bjNBr5XvN
         6D/5NMuvclulacL3gBMLXasRhbCTjX/x1f/5F7b8uG5bP26mCEfTg2doCHl0buU+7zBu
         q9oFkSRyPYQhHZOu2jJo+5/Eu5xtLn80/1TtZO4pMILoJ5Li0njmrzgZMQv+RRkSmfg7
         JdUTagz0kdOkqBv9C7XbOxt3hhui74lT8WOJlT8aucvK82SaPrdjgSuDFnRxcD1vQ1qs
         CzIVvScg+UsqDcoELXzez6x7Wp1hYsmJiAMFiD2S5hsZUUU8uhEYFakV6UqoD2OQZePy
         y5Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVfcHDMGSZmEQ+O8uGPU5DayDT3bOi5A8irVfG22xdNR5Q35M11ZnhUCmgssxD3JZhC2YYkOveRU29BHFjDpFvI5smYv+RbLOoqM4pC
X-Gm-Message-State: AOJu0YzbTafpmaTlGJe1Q+Pxhabb30yh9c53CmbceYh0aS7R5BmQAWPK
	fh6koyBUUarEzZ2dxHmmd//ERFsgg6cU7n5zV3Glhp3nWQEib2CYO0EcBM5u
X-Google-Smtp-Source: AGHT+IEeOW8ac6oRLQLrnnj/b+HH8MeuZytH5/kfrGRzzscUSY4px9C/9+Xrv5ruomYLLUkuZitJiQ==
X-Received: by 2002:a05:6a00:b4f:b0:6ea:c156:f8dd with SMTP id p15-20020a056a000b4f00b006eac156f8ddmr13575668pfo.11.1713825885053;
        Mon, 22 Apr 2024 15:44:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id g25-20020a62e319000000b006ed59172d2fsm8359515pfh.87.2024.04.22.15.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:44:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 22 Apr 2024 12:44:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix selection of wake_cpu in kick_pool()
Message-ID: <ZiboW5wm5M8Ee6ip@slm.duckdns.org>
References: <20240415053550.538722-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415053550.538722-1-svens@linux.ibm.com>

Hello,

On Mon, Apr 15, 2024 at 07:35:49AM +0200, Sven Schnelle wrote:
> With cpu_possible_mask=0-63 and cpu_online_mask=0-7 the following
> kernel oops was observed:
> 
> smp: Bringing up secondary CPUs ...
> smp: Brought up 1 node, 8 CPUs
> Unable to handle kernel pointer dereference in virtual kernel address space
> Failing address: 0000000000000000 TEID: 0000000000000803
> [..]
>  Call Trace:
> arch_vcpu_is_preempted+0x12/0x80
> select_idle_sibling+0x42/0x560
> select_task_rq_fair+0x29a/0x3b0
> try_to_wake_up+0x38e/0x6e0
> kick_pool+0xa4/0x198
> __queue_work.part.0+0x2bc/0x3a8
> call_timer_fn+0x36/0x160
> __run_timers+0x1e2/0x328
> __run_timer_base+0x5a/0x88
> run_timer_softirq+0x40/0x78
> __do_softirq+0x118/0x388
> irq_exit_rcu+0xc0/0xd8
> do_ext_irq+0xae/0x168
> ext_int_handler+0xbe/0xf0
> psw_idle_exit+0x0/0xc
> default_idle_call+0x3c/0x110
> do_idle+0xd4/0x158
> cpu_startup_entry+0x40/0x48
> rest_init+0xc6/0xc8
> start_kernel+0x3c4/0x5e0
> startup_continue+0x3c/0x50
> 
> The crash is caused by calling arch_vcpu_is_preempted() for an offline
> CPU. To avoid this, select the cpu with cpumask_any_and_distribute()
> to mask __pod_cpumask with cpu_online_mask.
> 
> Fixes: 8639ecebc9b1 ("workqueue: Implement non-strict affinity scope for unbound workqueues")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  kernel/workqueue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 0066c8f6c154..d02b0c02c9e2 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1277,7 +1277,8 @@ static bool kick_pool(struct worker_pool *pool)
>  	    !cpumask_test_cpu(p->wake_cpu, pool->attrs->__pod_cpumask)) {
>  		struct work_struct *work = list_first_entry(&pool->worklist,
>  						struct work_struct, entry);
> -		p->wake_cpu = cpumask_any_distribute(pool->attrs->__pod_cpumask);
> +		p->wake_cpu = cpumask_any_and_distribute(pool->attrs->__pod_cpumask,
> +							 cpu_online_mask);

So, this wouldn't necessarily fix the problem completely but regardless of
how that's plugged, this is still something we want to do to avoid picking
offline CPUs. Can you please update the patch description accordingly and
resend?

Thanks.

-- 
tejun

