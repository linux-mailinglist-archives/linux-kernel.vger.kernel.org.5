Return-Path: <linux-kernel+bounces-2763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C2D81617D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079612812E7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4282447A40;
	Sun, 17 Dec 2023 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="2hLCpXyW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EE847A55
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33668163949so189151f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 09:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702835946; x=1703440746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X6JzbzzThKIzjfGlad3RhLjL5DtAjn9ZJdacj7M/Yvg=;
        b=2hLCpXyWIFMe5NsOyv8ek3ijwn+LLeUOSQ45XpNg1WwHv7hMzRLMLAXDkeoEvnPEEu
         Yj1bSfxff1pDkqS7/FwinTFWWQJd9Rxh1hN7uVp/LqVvxxOFGeG6V0TAF5xdfWVrQKtI
         EVl6Eh5V9gK++jdZnHdytt60Lh8RK9nC/i7uo5qZb6RAekruMAvHboVtn+lIKa7cPoY4
         yGXCZ/baV5442OdMmsI57URbDbSLMkMlyrKRtVvK7LDtlMd76mXiF+biYMtiWMkHGiT+
         j5Nmjpe54w9d50Y/GjsYb8TYMFP7gQDVq/EmBlyJp8PZVe3Q7McZdFkp/7Dye0Nbo51I
         1eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702835946; x=1703440746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6JzbzzThKIzjfGlad3RhLjL5DtAjn9ZJdacj7M/Yvg=;
        b=ZrfBgeLe42aoeiV7RnX3zTRsC2X6iZ4OzBUyXR9gGxaGrstUiYFQtKTn1SuxLhEdj+
         4qh246yhu6ZZpI0ngbbxtMjP54rSTwDN97e+k4ErVAGW4U5v4OkZn/gx+Hky/EakJlKc
         UXG8gWfhNmLl2rUuSL6JlJ9Qpj1OA+sucAH2jAsHHpGyGwARhgudLJ4iY3HNxxkhHSSI
         OYxbqFYCF6ZR9cNAJI+FKdCgrQ5wwXRWrQQXqwtZwiTkC6b7yiLa3gY4XXfOwjhSmuAr
         S5ru/yFTelaH3LqnOV5OjD3Jmn6LeAXbIpvsJnLi3fqiDPtnJGrC0x5wJnHJgAY0t+so
         iOTQ==
X-Gm-Message-State: AOJu0YxkP7B1uR6UZcDC4v6cft4MfvTZ6X07sqO9f5yfNi3zYKKH4GWW
	nX0aq3Yhf/CdqW6PJ4cQGu8rRQ==
X-Google-Smtp-Source: AGHT+IExs5lymcJVgUi8ra/BfGSkftTHWviT4YespBX+9izDXMShEBVo5Da+muSuCkiS7lxqb1npEg==
X-Received: by 2002:adf:ce0a:0:b0:336:66be:adcc with SMTP id p10-20020adfce0a000000b0033666beadccmr278832wrn.137.1702835946379;
        Sun, 17 Dec 2023 09:59:06 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id y16-20020adffa50000000b00336472260c0sm10108647wrr.115.2023.12.17.09.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 09:59:06 -0800 (PST)
Date: Sun, 17 Dec 2023 17:59:04 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 07/23] PM: EM: Refactor how the EM table is allocated
 and populated
Message-ID: <20231217175904.v3aaoqyp3n7pqyph@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-8-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129110853.94344-8-lukasz.luba@arm.com>

On 11/29/23 11:08, Lukasz Luba wrote:
> Split the process of allocation and data initialization for the EM table.
> The upcoming changes for modifiable EM will use it.
> 
> This change is not expected to alter the general functionality.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 52 ++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 3c8542443dd4..99426b5eedb6 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -142,18 +142,25 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>  	return 0;
>  }
>  
> +static int em_allocate_perf_table(struct em_perf_domain *pd,
> +				  int nr_states)
> +{
> +	pd->table = kcalloc(nr_states, sizeof(struct em_perf_state),
> +			    GFP_KERNEL);
> +	if (!pd->table)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
> +				struct em_perf_state *table,
>  				int nr_states, struct em_data_callback *cb,
>  				unsigned long flags)
>  {
>  	unsigned long power, freq, prev_freq = 0;
> -	struct em_perf_state *table;
>  	int i, ret;
>  
> -	table = kcalloc(nr_states, sizeof(*table), GFP_KERNEL);
> -	if (!table)
> -		return -ENOMEM;
> -
>  	/* Build the list of performance states for this performance domain */
>  	for (i = 0, freq = 0; i < nr_states; i++, freq++) {
>  		/*
> @@ -165,7 +172,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  		if (ret) {
>  			dev_err(dev, "EM: invalid perf. state: %d\n",
>  				ret);
> -			goto free_ps_table;
> +			return -EINVAL;
>  		}
>  
>  		/*
> @@ -175,7 +182,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  		if (freq <= prev_freq) {
>  			dev_err(dev, "EM: non-increasing freq: %lu\n",
>  				freq);
> -			goto free_ps_table;
> +			return -EINVAL;
>  		}
>  
>  		/*
> @@ -185,7 +192,7 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  		if (!power || power > EM_MAX_POWER) {
>  			dev_err(dev, "EM: invalid power: %lu\n",
>  				power);
> -			goto free_ps_table;
> +			return -EINVAL;
>  		}
>  
>  		table[i].power = power;
> @@ -194,16 +201,9 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  
>  	ret = em_compute_costs(dev, table, cb, nr_states, flags);
>  	if (ret)
> -		goto free_ps_table;

We don't care about propagating the error number here stored in ret?

> -
> -	pd->table = table;
> -	pd->nr_perf_states = nr_states;
> +		return -EINVAL;
>  
>  	return 0;
> -
> -free_ps_table:
> -	kfree(table);
> -	return -EINVAL;
>  }
>  
>  static int em_create_pd(struct device *dev, int nr_states,
> @@ -234,11 +234,15 @@ static int em_create_pd(struct device *dev, int nr_states,
>  			return -ENOMEM;
>  	}
>  
> -	ret = em_create_perf_table(dev, pd, nr_states, cb, flags);
> -	if (ret) {
> -		kfree(pd);
> -		return ret;
> -	}
> +	pd->nr_perf_states = nr_states;
> +
> +	ret = em_allocate_perf_table(pd, nr_states);
> +	if (ret)
> +		goto free_pd;
> +
> +	ret = em_create_perf_table(dev, pd, pd->table, nr_states, cb, flags);
> +	if (ret)
> +		goto free_pd_table;

Ditto for all the above


Cheers

--
Qais Yousef

>  
>  	if (_is_cpu_device(dev))
>  		for_each_cpu(cpu, cpus) {
> @@ -249,6 +253,12 @@ static int em_create_pd(struct device *dev, int nr_states,
>  	dev->em_pd = pd;
>  
>  	return 0;
> +
> +free_pd_table:
> +	kfree(pd->table);
> +free_pd:
> +	kfree(pd);
> +	return -EINVAL;
>  }
>  
>  static void
> -- 
> 2.25.1
> 

