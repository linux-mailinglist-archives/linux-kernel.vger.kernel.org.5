Return-Path: <linux-kernel+bounces-2760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F392816178
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D757B21893
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158E847A51;
	Sun, 17 Dec 2023 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="la1vahpE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7254777D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33662243274so315598f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 09:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702835894; x=1703440694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZFlAxdIr5wSvxYzQ9x9VD+dv6ardxZUrRu2h6HI6Tc=;
        b=la1vahpEyMnzDABTz3czCO4pWv4uigXTRXHD6o1PEPwfjxyIbcwWiTIsozKPLT7A3j
         J4YngP7a5iUAu8Jnr8z5gT0kMs+ya+eOAoL66o2wxSQRmfxGhAw8gl0PComRq5n2c6TS
         JhoSxIi/lVhoNGnkBFLWMduKIGmg8DaBYyVqJNrAQHLjPLyUzIw60dOOgIa64qHoU6H1
         afGL+9MxnrxONO0cFd3JSgGRKY/Y7ZO0BAmi69uDW6vyp179AO8FIpZlrpOWGMLPHEEG
         jdSutSHQHiQgdZCcNI2hNQhh5ULaS6SYn2z6pra0CFhUPnO/v/peq7t8CZGoSsl83QiI
         SoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702835894; x=1703440694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZFlAxdIr5wSvxYzQ9x9VD+dv6ardxZUrRu2h6HI6Tc=;
        b=JaJDABGApx33igNMnPGjpElo6Rt+31ly7xWGE2QliWhkFM6QkrYDwJL0k9DHGHd23m
         6FGRbJLTIP0rZ1A8Aj3fXasYXShDRDeqyjoVt4few0B9cG2BmteJ1ZUXKHHyzISOmI1+
         XH6KRaI6MRKjDcDfcylA19Hh3Ni3XmT77T4/FX0mPt09xx6/PLGMaIAiSQcBXVqpNSUT
         wIflU78DBot0tcS78MJ9y/MA5uwjO6nVOzGqvk4W+41D+nvgBIc5czxwiUEYRUq3Rq0L
         /yhtV+lGk9I7Lw9VGpteFCyOLCG4/0S3nO56WXRLs4oNDRnbX2+/fYo+3Trif3r5KWDV
         jDJQ==
X-Gm-Message-State: AOJu0YybfJnIAVph+Atw5yH4K8v4CJNhoSo/fmfBMS969xEcGCOH+Kje
	Jf22N1pgPf34nEHh4o2s5TLiKQ==
X-Google-Smtp-Source: AGHT+IHMvorCdC6ZfIcCq0DsW+yRKk0KQpEv5AhkzQ6oQWszWfTnGIOp0dHojQDqwgC0VBvu+8KSfQ==
X-Received: by 2002:a05:600c:34cd:b0:40d:177b:c3b3 with SMTP id d13-20020a05600c34cd00b0040d177bc3b3mr513435wmq.18.1702835894307;
        Sun, 17 Dec 2023 09:58:14 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b0040b45282f88sm40508062wmq.36.2023.12.17.09.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 09:58:13 -0800 (PST)
Date: Sun, 17 Dec 2023 17:58:12 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 02/23] PM: EM: Refactor
 em_cpufreq_update_efficiencies() arguments
Message-ID: <20231217175812.s5vaabxtm4cgil36@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-3-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129110853.94344-3-lukasz.luba@arm.com>

On 11/29/23 11:08, Lukasz Luba wrote:
> In order to prepare the code for the modifiable EM perf_state table,
> refactor existing function em_cpufreq_update_efficiencies().

nit: What is being refactored here? The description is not adding much info
about the change.


Cheers

--
Qais Yousef

> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 8b9dd4a39f63..42486674b834 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -237,10 +237,10 @@ static int em_create_pd(struct device *dev, int nr_states,
>  	return 0;
>  }
>  
> -static void em_cpufreq_update_efficiencies(struct device *dev)
> +static void
> +em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
>  {
>  	struct em_perf_domain *pd = dev->em_pd;
> -	struct em_perf_state *table;
>  	struct cpufreq_policy *policy;
>  	int found = 0;
>  	int i;
> @@ -254,8 +254,6 @@ static void em_cpufreq_update_efficiencies(struct device *dev)
>  		return;
>  	}
>  
> -	table = pd->table;
> -
>  	for (i = 0; i < pd->nr_perf_states; i++) {
>  		if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
>  			continue;
> @@ -397,7 +395,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>  
>  	dev->em_pd->flags |= flags;
>  
> -	em_cpufreq_update_efficiencies(dev);
> +	em_cpufreq_update_efficiencies(dev, dev->em_pd->table);
>  
>  	em_debug_create_pd(dev);
>  	dev_info(dev, "EM: created perf domain\n");
> -- 
> 2.25.1
> 

