Return-Path: <linux-kernel+bounces-52159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B537B8494B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2891F24F5A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4A710A2C;
	Mon,  5 Feb 2024 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CsZ2xu/8"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A110A0F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707119118; cv=none; b=GeeJHy+ENhkLOtckZPubUeW4feipQHt2nUry2+FJBCRXgSXM78sOMzKF1YWc627wQzMe062gDaP20qDBxEtEXRwBda3SB3pTNVUf8bqJCURFFrTP14GEzNsAyFyP1SPJqmry38fUYI02L7QfjREPb/Wpcfr8B9xOoSncP6p/mLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707119118; c=relaxed/simple;
	bh=4ditESpSvXO3CQA9RfFDubZPLUjwNbBXaDxb7YTzR4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3JTB4PcD4KofyoycPpWX1horn/5Cq6CnriCtg+DcO/+766ZGB4wqgtwQf1pvboeFP0GPGKcyeYoq6zdSjLKhQbKdmAtWC6HoASzxgnceUDiResJ8UVOPlpZ/EFxsT+JFTxewe2u1BkiQKhg/FVQwD/FRYc88uqJUTa4elrbOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CsZ2xu/8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7232dcb3eso29566565ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 23:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707119117; x=1707723917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5pZ7raTnr2lgK0OrNyzLvdmrD6RJWaTC7ovP0GMB90=;
        b=CsZ2xu/8/FjceThOzr/Au+zz8g2AbvUDNZAhVhNUpCOmP6gRT5dX5cZSYX19eHFeNK
         rBSaNLaBxqwMnlxu9QhusoE3h/i9z+dduDs1+3sNLVDCJoNBtIqGBzqoEC4A9atNu6Vo
         lr4rhpgeAtqHu8mDWr0ZYKf24ikIRKIjLgxZeOmulYoRl+ry/93WMeUl1kAvjn+0EWQj
         1dQFSFSYxXJnRV6MPEJ6YYaGBuSkF1l2mRWfUZZxUk2SshgmnTA2l9e4bTqyV20r2rDy
         BfHKk3ISEnB4lBgiAK2W7CdyNFYt3lWED4LpuSXpaofrzicAC2xj29TW+JGN2b/7vcBr
         jV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707119117; x=1707723917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5pZ7raTnr2lgK0OrNyzLvdmrD6RJWaTC7ovP0GMB90=;
        b=elyWEuUEP+Q71Pbekj4V7Kv/2Wxx4EP4TTktZnftJ/mcq3VIxcG7xSDfHPMzQyz9Et
         c6UEgoN3jpWHaBOjP8xb2lYBy//gdHABPtzP9I8Qn+vgSDATjma45cbzn4y7B2KbX3Em
         CmS9ZRYgP40RrFOw9k4sMLgHyUlRDko0voeup6VYTsotQqAPjntSgth15nsuWvKFC4S0
         xDSLYMgLsBa1utB1dIHzM9Wh1Ft144Vv7AlXfb8noIfC8+4kTTLxWemleRRsz6ldwtz9
         XSIIqJsSZv6VKr+Nq6hsIblrckcIuxHVd39r/db+KnRw2/xsKUER35WG3wTNuAyhffRk
         +cHg==
X-Gm-Message-State: AOJu0YydQwAI4qqEHNfJmdz/rKri5e5T0rUa6IkTQvUntVtBplxGagWe
	HiSmFbsm3lKvOTeMwq2z/jFnb+67LYDxgw+vAaL9Ns0xcPM3XPyR5Z9o9NTbzPY=
X-Google-Smtp-Source: AGHT+IH3inHOeV/32gOcYBEpkgRtN/F0pBAJGBbxhm5JASQAUblS2EZclwertIUh/yJtcwkvZsomFg==
X-Received: by 2002:a17:903:487:b0:1d7:7347:d80e with SMTP id jj7-20020a170903048700b001d77347d80emr7652637plb.37.1707119116680;
        Sun, 04 Feb 2024 23:45:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVCJciGez7husAYuw+I3m6BQSRCfZzxZsfJxUhVV244QxKzScjFDReEI0Xk016tg1zU/FMYBf06Ny4fGnsQdh7z6pDPynZxOsEbizlASpTM27I7Dzr/YX+cRC9YA0fTgPXFwhBSoqzsXafCv3oTuiL7IL7RE+DjgNz/aHjoR0tyVi2WU7RL/sYP0gnHBmnDoYmgsKcA+iSqSvo6EO5M5JdUhTJXwPZwOKIEdKQ7dUhsX9szpA20Ony5ydzAtpFQhQSs6ud8hEkKrlqTQexsUA4fg129jFJhPsqo5oZJsA==
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id r7-20020a170902be0700b001d947e65ad8sm5610644pls.251.2024.02.04.23.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 23:45:16 -0800 (PST)
Date: Mon, 5 Feb 2024 13:15:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
Message-ID: <20240205074514.kiolurpounokalum@vireshk-i7>
References: <20240205022500.2232124-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205022500.2232124-1-qyousef@layalina.io>

On 05-02-24, 02:25, Qais Yousef wrote:
> 10ms is too high for today's hardware, even low end ones. This default
> end up being used a lot on Arm machines at least. Pine64, mac mini and
> pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
> it's too high for all of them.
> 
> Change the default to 2ms which should be 'pessimistic' enough for worst
> case scenario, but not too high for platforms with fast DVFS hardware.
> 
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44db4f59c4cc..8207f7294cb6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>  		 * for platforms where transition_latency is in milliseconds, it
>  		 * ends up giving unrealistic values.
>  		 *
> -		 * Cap the default transition delay to 10 ms, which seems to be
> +		 * Cap the default transition delay to 2 ms, which seems to be
>  		 * a reasonable amount of time after which we should reevaluate
>  		 * the frequency.
>  		 */
> -		return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
> +		return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));

Please add spaces around '*'.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

