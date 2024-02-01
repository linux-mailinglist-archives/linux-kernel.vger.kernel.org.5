Return-Path: <linux-kernel+bounces-48944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081BB846372
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F631C20D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E1C405F4;
	Thu,  1 Feb 2024 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="nBOFyOVr"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446253CF4F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826694; cv=none; b=K1fUboAhbbm0cMksyOW9QCte0H1NNgqU5mMJIcafxPA4rlKPm/4JK8wtpIHSvgHQs6qB247GdqQA44e8nAO+s7Yd4014xrKJfTlsycz1kb46tyEG8PgCEoyGU0EziJCMBayfzDLfWBFnVkp+ZJxhz7UPkURGOnOAw5vxc6e+sEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826694; c=relaxed/simple;
	bh=P85U7qVEtiwib4InPfeSXcENaMJdinVkRUgfk7DtKHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kM19Yf7VlZNPtndy3KKMfEPLYEkiuccCihreerFLqHu9gLHwlvFrvkQQmZlnFscLlOgjySe62rhh8QAEVBloSPGjqMQbsOzvPKvkPxWtZREYm0KndXCyPzc9lWx6yySX5Id8a7D4mhtarzcDYIgJsdHqN2lWhkU/h+B0NmM2jec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=nBOFyOVr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e80046264so12716425e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706826691; x=1707431491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bSwwFBcdZU7AoQFv7c4YL4HHZxb8TbX42mV1GK+DKhc=;
        b=nBOFyOVrwYU8v5+SrJXKESazdNxqy/IU3SDuOuKMOVsmM4B1zSSU8AcNwkWeybxKdf
         40YyKujzupfDMJDZBnimxy2PUnTvsqnm4iFRQEWY6pdgLSDo3wV79Qi57Jf+H4HaWRiV
         OsBmIdSuVpZlKQHTaU11u32DC0W3CnZ3L0IV84QRl6doenpay5Eot6WEbRrnnbxG3MEo
         6epRoReXuik2ZU00IbC/dwBdUZCqNjDwBp+x5Rzi3EslF3vEVdsgPNlhBNu7ICtjwmkU
         zYzOTDgSOL9TYXJXXnFtjHUXyzxMEbad/ITx1V1vrcIsD4dIEuNv5vStYzc+36M/DKNh
         ztxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826691; x=1707431491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSwwFBcdZU7AoQFv7c4YL4HHZxb8TbX42mV1GK+DKhc=;
        b=E87zXfvOdH808HLRmm/V5UfFHdwHnXyYl92GjiFA8PWtEyY2RvdbyX+ZyJh8hDo4uY
         G4xv+gNtKyVPfPZdaQwbfCyiUhIpWxHUuqdq2NXSy+VBFCu+em07dCzGAkyuJXeOzACD
         43uFLvLmyVWKb0tP1vhd6j2LnuM2FzXD1Pe1v+diPXKqBg770iCStz4Pb9RZ7quG9QZ5
         Mrkry4m6pMuYuv/y/NH07y2AvoEp4atYy+CgZYOGxs6all7vtVt4trrpSfw8Ae5fD6Sr
         EwcXy5t74RTO6GfKEj3kbWxafaYYXYj7jGc9nEH7vZxwwn0pIKGA9DFVBukTXdSN5hSr
         xe0w==
X-Gm-Message-State: AOJu0YxnT5PNHrByql4f5VL9TPRJYhUAZrUp0VKdc6Z6r+NSN9sW4NQi
	UfAwRmTpXOXGY3EEY1UJXYlrrG0tHj3S7rm5LB5sXt8/WSWm/uWJDxRADZSRB7M=
X-Google-Smtp-Source: AGHT+IF8QApT7bATZDY+w5kW8aQ4j60TNo6unSXL6IYGopuNDYPYb+8DLkY4V4sQt1uNgqgtE55e1A==
X-Received: by 2002:a05:600c:519a:b0:40f:aff2:7e47 with SMTP id fa26-20020a05600c519a00b0040faff27e47mr262722wmb.9.1706826691295;
        Thu, 01 Feb 2024 14:31:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWIf31ZoqlyXSpCq4fHgoJGp+ghpYzElUZnT2g5S0rmRR1kZ+Og+7ds3qYKF8aMdhUtXUM+IqpHmefJnjkGigCIrWgSBWBMvfIAmO6ZVGy8U5y3LdxVBf07WfuaBDHgw4AH/jNzmn5JlHnVcCjdgl77BGgXa+comDcI3VdAVgCTpIIPxb0dCBd+OkQ8cmv37RxG5CHG26KWa46M1Y7bA1ciiVL0GuuL3PlJQ6L8QObXE2koc3cFz5J5TLw/Ke60x/f8saMdns0vTnKG78ufhdW20+jIuyQIt8J++Kf5wUg289QgyxqdrsMnWUvapDqy0B4HNmm/eD88dCQGVUJMNJG1P5uXG/dpk3HsQHKtJ4w=
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b0040fb44a9288sm5680446wmq.48.2024.02.01.14.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:31:30 -0800 (PST)
Date: Thu, 1 Feb 2024 22:31:29 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>
Subject: Re: [PATCH v2 7/8] sched/schedutil: Add a new tunable to dictate
 response time
Message-ID: <20240201223129.2dgeko4aikkpisqf@airbuntu>
References: <20231208002342.367117-1-qyousef@layalina.io>
 <20231208002342.367117-8-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231208002342.367117-8-qyousef@layalina.io>

On 12/08/23 00:23, Qais Yousef wrote:

> +static inline u64 sugov_calc_freq_response_ms(struct sugov_policy *sg_policy)
> +{
> +	int cpu = cpumask_first(sg_policy->policy->cpus);
> +	unsigned long cap = arch_scale_cpu_capacity(cpu);
> +	unsigned int max_freq, sec_max_freq;
> +
> +	max_freq = sg_policy->policy->cpuinfo.max_freq;
> +	sec_max_freq = __resolve_freq(sg_policy->policy,
> +				      max_freq - 1,
> +				      CPUFREQ_RELATION_H);
> +
> +	/*
> +	 * We will request max_freq as soon as util crosses the capacity at
> +	 * second highest frequency. So effectively our response time is the
> +	 * util at which we cross the cap@2nd_highest_freq.
> +	 */
> +	cap = sec_max_freq * cap / max_freq;
> +
> +	return approximate_runtime(cap + 1);

After Linus problem (and more testing) I realize this is not correct. This
value is correct for the biggest core only, for smaller cores I must stretch
time with capacity. I have similar invariance issues that I need to address in
this series and uclamp max aggregation series.

