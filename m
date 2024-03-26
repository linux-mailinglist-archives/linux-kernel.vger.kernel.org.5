Return-Path: <linux-kernel+bounces-119811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A39388CD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2902E1F668B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63FE13D24A;
	Tue, 26 Mar 2024 19:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7o5nuNC"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A3713CFB7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481558; cv=none; b=j57O1RE1uVqq8Mlxfem7l2oTivCMTq7tOdNALcKBprqFDFsUkhJF+Udoyc+KI6R6I66lvWJyGH8mcVohLVlbxQWsvYl5JByNVm/dXv4vzbJIReRHZFbJGOjeCUxU+V6WwMZT9PUEhJARWGLtUq3gcjXAKVU7FX7fYM6ioieuE/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481558; c=relaxed/simple;
	bh=IPTD8oL30airMY5JK2E65jlSfMHn9jgIs+D1MlKnlpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8o2Ad2kq0MeXH1Q7gncnovh/8GLooUgo1bqZ3Suc9s1X0Pwbw3QXv69deWQMEJ3sTOtZBWz60x2uoNa/Y9NeKqrlkP4spEBdDj1tuHHwcyeA92D7TiB/DWPGM2SkAaYzjfUVZdUmSGEVsRPwNh8csW+H6u+J1AWHGv+n4IPyH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7o5nuNC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-414925779c2so2157875e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711481555; x=1712086355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFsAgCFr+w/nTt11Lu+H5UTp3Q2SaaYj41jQ35tN2FU=;
        b=C7o5nuNC+JDg8EPyRVZir+KE5UFYursRzxgx9ZIy6S1IOBKhAcDhsROD+ig+aELUXU
         4/UmZQzmLHpKLhLd6sF8aqgtm87PSoZc20WYnRmgHb0Oxiru5gh6i3AiIstAGFGQjM8D
         P7DyXraiyYSyiMItieEs6j4e9EIcV2JiR9F0RHvJtgO0u2T365R2eAtIcwWKkDzGAWsn
         7Es1sVjH6umICbeWKQDspuxi6N2IhTB3Zvg8zCTMOeON72/ZSkGZrSEXxY+Rkzq/nJRW
         eNM+f7mG4zM82EcAeY5qxUfvSvk/w4MqT3GlWACdc0ndw4C1xv03I7w+/sfFPAf8OwFI
         rbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711481555; x=1712086355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFsAgCFr+w/nTt11Lu+H5UTp3Q2SaaYj41jQ35tN2FU=;
        b=KbLoAtLI/wTcbDYw9eT/6HQMSLCr6RlNBYw0wRsMaiBNhpB0Qgp9huxuo8p9hI96Xf
         sIdZfTAo7AH8CZec1VJWcOwIuMtW1sM81v3nZCMCBmc8/hmLwP0ZvjZ6CxaQBYYwWE1e
         qEiL9e/67G3lhA1Zd5JhSesYetTprqN7+oYUre+t8OVsLW4lz4DlTB14VI95glatJdKG
         v+xmHUMcjL/TS11niTwqFC9RwNLlDZK/890MrEKf3qr52JU9PSzDfTy1FGcPTwr2LrDG
         KqCJWEeydTqGLaKlcpnA1zE0dhZkop49j8Cuazw3w+AIbBFacjAO+pZMk+vM4AGKL2nL
         YtPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb/x5ohXzleMTSMEQe5a11Wdi3hMHKgiBYuEM2NcpIfXWCWOzAn3xgG5dlV4fHmoBDE4+BJwfbAxNmhwAoP2g2zzTjEHvTas2W5SQt
X-Gm-Message-State: AOJu0YwfsQrbiAAXgRREtQDeUdO1UsHo+AYdHiRSYWNuM2MJXKEN5/Bj
	lFPeSBOvVfeAIQfx52Idt/hM2I2+71zWZnYh4MHssNXasUC3rX1M
X-Google-Smtp-Source: AGHT+IH+dWoypG0EcbOQ631T6H40mF1E7DKx4ijjVUepTMphEcKfJEZDlma/mEIxpGTB3hHmhhNAuA==
X-Received: by 2002:a05:600c:1547:b0:414:88a2:fb7b with SMTP id f7-20020a05600c154700b0041488a2fb7bmr359887wmg.11.1711481554422;
        Tue, 26 Mar 2024 12:32:34 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b00414850d567fsm10444617wmq.1.2024.03.26.12.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:32:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 26 Mar 2024 20:32:17 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, qyousef@layalina.io,
	linux-kernel@vger.kernel.org, vschneid@redhat.com
Subject: Re: [PATCH] sched/fair: Combine EAS check with overutilized access
Message-ID: <ZgMiwYxF5rnVTpLf@gmail.com>
References: <20240326152616.380999-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326152616.380999-1-sshegde@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> Access to overutilized is always used with sched_energy_enabled in
> the pattern:
> 
> if (sched_energy_enabled && !overutilized)
>        do something
> 
> So modify the helper function to return this pattern. This is more
> readable code as it would say, do something when root domain is not
> overutilized. This function always return true when EAS is disabled.
> 
> No change in functionality intended.
> 
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 24a7530a7d3f..e222e3ad4cfe 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6686,12 +6686,11 @@ static inline bool cpu_overutilized(int cpu)
>  }
> 
>  /*
> - * Ensure that caller can do EAS. overutilized value
> - * make sense only if EAS is enabled
> + * overutilized value make sense only if EAS is enabled
>   */
>  static inline int is_rd_overutilized(struct root_domain *rd)
>  {
> -	return READ_ONCE(rd->overutilized);
> +	return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
>  }
> 
>  static inline void set_rd_overutilized_status(struct root_domain *rd,
> @@ -6710,8 +6709,6 @@ static inline void check_update_overutilized_status(struct rq *rq)
>  	 * overutilized field is used for load balancing decisions only
>  	 * if energy aware scheduler is being used
>  	 */
> -	if (!sched_energy_enabled())
> -		return;
> 
>  	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
>  		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);

On a second thought, I'm not sure removing the open-coded 
sched_energy_enabled() branches is a good idea: the current code makes it 
really, really clear when we are within EAS code paths.

Hiding it within is_rd_overutilized() makes it a lot less obvious IMO.

And this one:

> @@ -8202,7 +8199,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  		    cpumask_test_cpu(cpu, p->cpus_ptr))
>  			return cpu;
> 
> -		if (sched_energy_enabled()) {
> +		if (!is_rd_overutilized(this_rq()->rd)) {
>  			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>  			if (new_cpu >= 0)
>  				return new_cpu;

Didn't have a root_domain::overutilized check before?

Thanks,

	Ingo

