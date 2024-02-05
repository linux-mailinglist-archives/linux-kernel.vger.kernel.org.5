Return-Path: <linux-kernel+bounces-52540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E2B849977
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A991F21741
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF171A27E;
	Mon,  5 Feb 2024 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="ENQ3x8O/"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1742168B9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134513; cv=none; b=CMULrrKa/5mzypBwtoKeW1qDheJADEV6UOHF4opnOdRY19EfTFFoy0057vx0T2nP5LnzKOdHFP1s1KgxvH6l+iPAUxx9jLXGdedB2k6VEAgg6NzSeCeiSNBBZtpGVv0mQQj2Zo6lX9Odc2FQFz9R1lkjtoAYJslffTV0k/DfttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134513; c=relaxed/simple;
	bh=wy0r1UGOlI8VWUg4o5WQ5eNOjowjM5g7AjUKiiYZx5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu7QHOyDQzo7SJz0zx520M/2y/QOGVHamlLGIslU/YwUQkgIvolW1p8R0hSooUbYZGrXVF1D31B4RmbWdKAmq+CsZAiTZrFFdybotkng+wIpNQWrkm6B7Mz7lCaoBcjyzLihUzmDMxo7Bt4MoW6ssMCBZwS8UrywKcHAXXwscYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=ENQ3x8O/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fc654a718so25425545e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707134510; x=1707739310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNUTLRh0uORxgdvQZdWeV7OWpCRm6fjT9p0GI9ATEAA=;
        b=ENQ3x8O/fiJMJymc7LxtJbwj6H2YWeJcVdeqE44iu1CcFRielLkqV+391oEqW638z+
         fUa4wgm5UzTtIbd5UzWMWwTRcfjs5eaDVrUSFurjGfULmPrUxpvaty+mgwATNA0kS3Wa
         Wej6g3i1rHcVtkYNl8igq0GoOzz54iJ9hVRrPbpore4/Hg1LR7I3+UIfl8h9XcQPTVDH
         PNjtqbx51WZs9sRKdSO6rIk5k4YLF6GxXsFquBCzPV7dtwTMdrSTaZTISonp1xTRthL/
         p8CpFLvGtnUBeIDZVLeBB0pSlluelcv48HJYlrfWYgQCve8bUFacNrKg3CvJ9sOv6Hvf
         q6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707134510; x=1707739310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNUTLRh0uORxgdvQZdWeV7OWpCRm6fjT9p0GI9ATEAA=;
        b=wYrpZyDZfd2FDV/qYqce+64JsX6l52vPX6M6nFt4l9NgUWtKYEfxKdjY1W+84Z7/9S
         fPV4f4tHD6xohGUQI00c/RMtAwewimMEFJj2acN0SyyAHxOfFUFr70f6t1ZbcVCdnEqz
         ogc0vcRlrgDoSShiGg7sFH+Ig8WZbNNoYQv31BA3rB0gEiGwz5nmk+JMxLUXjlR46KGV
         z29rH1uKAbnuf6MwwWtxqH8XLAb5rssU/mxwWs3uwVMDB/hMSwzJqHl25urVE0jq7LKF
         3xVGbIiBSELXqi+rNRm6eeygWerxReBuXEsvH36WlD/x46wJmk3XCpwjbOIk4MDPaGqb
         8nmA==
X-Gm-Message-State: AOJu0YxKUqKw43WN56q9yUd+fLNgoTLMbGrJDnOtnbPYLi5XYWwImFlo
	ahRlTLhFlaxATNFmopJQ+tVsuq87mLIuQvkgHUglgfnItkuFn37OBathhjdFMOs=
X-Google-Smtp-Source: AGHT+IHWqNiVcAQK8HVihsJjFtCl6C0gSNKBH/FtbKc34ErpwQ7Bj+kbyDVaKXxEc4JE0pjClnzq6A==
X-Received: by 2002:a05:600c:468d:b0:40f:dc51:1882 with SMTP id p13-20020a05600c468d00b0040fdc511882mr1359629wmo.8.1707134509374;
        Mon, 05 Feb 2024 04:01:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW/WeIZaLbIJdUoV2uOi8CtBU7/5uQmbaWjHK4eakyFqOpEUCrvdBLgh2S2jHCdZy4hHmXTSyLfDp3sPFiKh0OdaarA0eYJCMhAlhqZu4IQfYCllpkzEk5vYraCS8T22HotTdcAof9isywvzsSdX9zQZloV3Yfh0+nDo8/T1braAwGHp3UZTuqLGBpaR6dCfAmehzNbHMk3QO7jmUYOrnffOibWHzlCR5Cz0u2WgOij4byGlTla5J3h/I2N/DxDqzXsEh+P2aKYvSWTJY9yXKqSkucoXGVkMorC+q3i9Q==
Received: from airbuntu (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c139400b0040ee0abd8f1sm8382027wmf.21.2024.02.05.04.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:01:48 -0800 (PST)
Date: Mon, 5 Feb 2024 12:01:47 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
Message-ID: <20240205120147.ui5zab2b2j4looex@airbuntu>
References: <20240205022500.2232124-1-qyousef@layalina.io>
 <326b568d-d460-4a69-9336-28da328ffdcf@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <326b568d-d460-4a69-9336-28da328ffdcf@arm.com>

Hi Christian

On 02/05/24 09:17, Christian Loehle wrote:
> On 05/02/2024 02:25, Qais Yousef wrote:
> > 10ms is too high for today's hardware, even low end ones. This default
> > end up being used a lot on Arm machines at least. Pine64, mac mini and
> > pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
> > it's too high for all of them.
> > 
> > Change the default to 2ms which should be 'pessimistic' enough for worst
> > case scenario, but not too high for platforms with fast DVFS hardware.
> > 
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> >  drivers/cpufreq/cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 44db4f59c4cc..8207f7294cb6 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
> >  		 * for platforms where transition_latency is in milliseconds, it
> >  		 * ends up giving unrealistic values.
> >  		 *
> > -		 * Cap the default transition delay to 10 ms, which seems to be
> > +		 * Cap the default transition delay to 2 ms, which seems to be
> >  		 * a reasonable amount of time after which we should reevaluate
> >  		 * the frequency.
> >  		 */
> > -		return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
> > +		return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));
> >  	}
> >  
> >  	return LATENCY_MULTIPLIER;
> 
> Hi Qais,
> as previously mentioned I'm working on improving iowait boost and while I'm not against
> this patch per se it does make iowait boosting more aggressive. ((Doubling limited by rate_limit_us)
> Since the boost is often applied when not useful (for Android e.g. periodic f2fs writebacks),
> this might have some side effects. Please give me a couple of days for verifying any impact,
> or did you do that already?

I don't understand the concern, could you elaborate more please?

Products already ship with 500us and 1ms which is lower than this 2ms.

On my AMD desktop it is already 1ms. And I think I've seen Intel systems
defaulting to 500us or something low too. Ideally cpufreq drivers should set
policy->transition_delay_us; so this path is taken if the driver didn't
populate that. Which seems to be more common than I'd like tbh.

I never run with 10ms. It's too slow. But I had several tests in the past
against 2ms posted for those margin and removal of uclamp-max aggregation
series. Anyway. I ran PCMark storage on Pixel 6 (running mainlinish kernel) and
I see

10ms: 27600
2ms: 29750

HTH

Cheers

--
Qais Yousef

