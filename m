Return-Path: <linux-kernel+bounces-59271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0B384F458
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCE21C24E0F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BE728DBC;
	Fri,  9 Feb 2024 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miVWYdy6"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A72225618
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477138; cv=none; b=upZWsPUbvUSz0OWNEfBJXa0lTzoRIMqBNWsJx0fe5wZC4HFDBFagi8pr7W4Pmb1J01bemoHkATHp3NUIeIHEVtccXkhlxbJCCCiZkHvrzwzSRP1wZaSgIpMLDDdZvqizjFoQjShPPdAds3OkvHosZtrriiMSx84t9NMFd8s119I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477138; c=relaxed/simple;
	bh=HIYMrYtonymq7acf8E7e587AAl0PTQyop4vxHOQ4YRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hoEgdpIK50Gk2KLM+DsXfhLfJN98YH0clinUFqbVLROvPcobtoJR49dVhFjxJhP/b+P66vAPIRMr6/temZQxMpj/etlDdabi+0m9FdgPfACjIfDncvpWfBEgBgDcP2gH5+LuAoCleEx+uOtEnrpNJiy94gIVUso+gFHBHGqo3Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miVWYdy6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d953fa3286so6358195ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 03:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707477136; x=1708081936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XXjDhP9nLtrxtdF4uU0uugVAt74PW9a05majkCSGnQ=;
        b=miVWYdy6/CbR4erfUBywTOOZDYv5Q7JAaOjQEpXkR8XppDvQB/RgNj+q9rNLDe1SNP
         J4AVuJFsjpsK+8v1JPyyaV6UtsZbZ3vuY3TgmUYve99xhfFTdYQQlnrwRSxt+QyUaqGJ
         y95KofsW88a3c+UU4gsAs6/1FAj1CrvIU8n9m0z8Qx2wdfpOKljJezdMZgcild7Cl0b4
         J1WOl0lLPX3nfq//0Ri4tB4tlwimUZ7aHDiTk/MbldNW/heuuzpDyOyGEQDk42V7cwS+
         qyylILKAt51JNXJP+kyggBNIHiIEnInrXGRLWZZbDC5HUXQVMhW+6b0Z+oNxQx+OpTAU
         K2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707477136; x=1708081936;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XXjDhP9nLtrxtdF4uU0uugVAt74PW9a05majkCSGnQ=;
        b=L4SdZ2pHPS/HheiESGcRmpy14NKnB+oeaFAXV5FwYalM/aB5xHmVYjrhyLkEuHUPVg
         xRJhhYzTBCyXqikUxEX7HG/tKxxcvXUtJe7TJtyLKIyYx47ZbR9ST+m9xj5rBRqc+NkA
         aPmq87Z1mI6oOQGL9HaR/qMzvdfiB97xA9on8ZSrucHIY5lt4zXZGoDcR139aBJpmcLg
         Fa4qwuTjwiGsNfeoOg39tP/97AC1ZWH3gvsAZnBtI5FfvFpr94jJ0AaSid7DNeq5nCLt
         Xthxy9AXDI2EINKop0y+MjEuwXmFbz+Bfwhjo5Ay4nKKxpnDKMxsAQrfN7Y9rdIpP2/g
         Baqg==
X-Forwarded-Encrypted: i=1; AJvYcCU8npm8gR8Gukod5QQOCaITrXvjurhsvsjqPUDqk5FXJr+2TP+ZznDjiUcn0pNB5RHA6gmz/0nT8h0WcIA5C9OiQnP/SNfE79ylegyG
X-Gm-Message-State: AOJu0YwqXSY5MrYQQDCsJD+70G3dIXm4RRhnzi60p1MgQFue+cg8Rrbw
	YwmkroZcrOR9V1BDnREDIvN03+6bopSQsvuh+dZu+SpNgrLxoeY6
X-Google-Smtp-Source: AGHT+IFfaX1piIW0rvCxi6fdAqL0p3n9TJ6x9KN5apeXTTdjQXc7tM3J/Thxq7Uwb/bvlacRwZnfbQ==
X-Received: by 2002:a17:902:e986:b0:1d9:803a:8b14 with SMTP id f6-20020a170902e98600b001d9803a8b14mr1222572plb.59.1707477136387;
        Fri, 09 Feb 2024 03:12:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjEU9M1ho+pB48BzoXsHiPmI79MoppsWcrDD6dsDQRm8fnOL/oBiZip1m01bvzfwzJmUKs8VtDZBtMdZQmKhh6sRNqhQKaHNvaanHQjafy1VeBmw28LlZKOCr183gsM4F1iMiQcFFDdAZc6vcD/dxO78T7F4S5Ir9Cw8eNfCNycGk6yC/tMz8QwuPf3uV4knOI7LDl0wr2D0v1/6f5RnK11e/zcFclMJsCBN5jppshzFFIw5VEIAn/1kWpcTgTn5tP/NEeeReCZlmCdLUb3+lLko/txZesib70nxm22Z9K6wDoRzEvb8ngKeBcjuaAslnfAQ5T+livZgIhFIAybGUKqkx8Co3S0GPi88RmoGnigK4O2/HqWtagn6TwspiQgoXnwfPXn+xhVYXd37ZwXaSyRpFwCmwhmJ0BMGWPZisLsTUnwU8i4nohTU5jiE4iFdS1IQQN
Received: from [192.168.255.10] ([58.32.33.209])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8b0750940sm1280590pln.175.2024.02.09.03.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 03:12:15 -0800 (PST)
Message-ID: <4b0e6966-eb31-4d44-99e2-e33294c7e129@gmail.com>
Date: Fri, 9 Feb 2024 19:12:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] sched/fair: Check the SD_ASYM_PACKING flag in
 sched_use_asym_prio()
Content-Language: en-US
To: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 ricardo.neri-calderon@linux.intel.com, yangyicong@hisilicon.com
References: <20240207034704.935774-1-alexs@kernel.org>
 <20240207034704.935774-4-alexs@kernel.org>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240207034704.935774-4-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Valentin&Ricardo,

Any more comment for this patch? or Reviewed-by from you as a Chinese new year gift for this patch? :)

Thanks
Alex

On 2/7/24 11:47 AM, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> sched_use_asym_prio() checks whether CPU priorities should be used. It
> makes sense to check for the SD_ASYM_PACKING() inside the function.
> Since both sched_asym() and sched_group_asym() use sched_use_asym_prio(),
> remove the now superfluous checks for the flag in various places.
> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: linux-kernel@vger.kernel.org
> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> To: Ben Segall <bsegall@google.com>
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Dietmar Eggemann <dietmar.eggemann@arm.com>
> To: Valentin Schneider <vschneid@redhat.com>
> To: Daniel Bristot de Oliveira <bristot@redhat.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Juri Lelli <juri.lelli@redhat.com>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/sched/fair.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 942b6358f683..10ae28e1c088 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9740,6 +9740,9 @@ group_type group_classify(unsigned int imbalance_pct,
>   */
>  static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  {
> +	if (!(sd->flags & SD_ASYM_PACKING))
> +		return false;
> +
>  	if (!sched_smt_active())
>  		return true;
>  
> @@ -9941,11 +9944,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  	sgs->group_weight = group->group_weight;
>  
>  	/* Check if dst CPU is idle and preferred to this group */
> -	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
> -	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> -	    sched_group_asym(env, sgs, group)) {
> +	if (!local_group && env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> +	    sched_group_asym(env, sgs, group))
>  		sgs->group_asym_packing = 1;
> -	}
>  
>  	/* Check for loaded SMT group to be balanced to dst CPU */
>  	if (!local_group && smt_balance(env, sgs, group))
> @@ -11041,9 +11042,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  		 * If balancing between cores, let lower priority CPUs help
>  		 * SMT cores with more than one busy sibling.
>  		 */
> -		if ((env->sd->flags & SD_ASYM_PACKING) &&
> -		    sched_asym(env->sd, i, env->dst_cpu) &&
> -		    nr_running == 1)
> +		if (sched_asym(env->sd, i, env->dst_cpu) && nr_running == 1)
>  			continue;
>  
>  		switch (env->migration_type) {
> @@ -11139,8 +11138,7 @@ asym_active_balance(struct lb_env *env)
>  	 * the lower priority @env::dst_cpu help it. Do not follow
>  	 * CPU priority.
>  	 */
> -	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
> -	       sched_use_asym_prio(env->sd, env->dst_cpu) &&
> +	return env->idle != CPU_NOT_IDLE && sched_use_asym_prio(env->sd, env->dst_cpu) &&
>  	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
>  		!sched_use_asym_prio(env->sd, env->src_cpu));
>  }

