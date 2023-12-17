Return-Path: <linux-kernel+bounces-2765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D012F816182
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A90B20A97
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9FB47A60;
	Sun, 17 Dec 2023 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="KqNHoZ2/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB9481AA
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c2c65e6aaso28647955e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 09:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702835996; x=1703440796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PB5TqBvmgxA5EFBzHlsLEmjHmlM7x/tbO20cnIclOF0=;
        b=KqNHoZ2/tETIe0A9zv+skvgLD6JEzRLRACEgxkcyhoK2HMmzqjJIelMFZ0pS+dgLpD
         1V/zFwd7d0Irre3h7KdavEhZ5YbY0IpYL9rsvFO/6ysdxoBFM8x+aSqwqO7zTaFM5L3i
         8+hfhtIJYBvVVM9PzMhLNUtllMs5XWvS7zf7m5P+FxMPUBusC6uD/MFa+qRCzpzHEz6I
         e0yedcJiDJdF0YL1JgH6ReRa7mxxNWlm8RkYrITjyj2AerILQ9wVVkXmEytxY64/0+N1
         5i4czcSIYHrH8SiAXoLJmad9b9aMiqoM4Wb3oL+plItCup/PvN0tk4sDfHCDszFPoBm8
         vTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702835996; x=1703440796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB5TqBvmgxA5EFBzHlsLEmjHmlM7x/tbO20cnIclOF0=;
        b=YBfj+ixrU9trOtCGPQMf/Yc97o6t5vw0YH5kbICjdk2QgI6eEOauuTouUn67Tgj07Z
         rl1FtZE0zqu7gNxLMNCRod73ea/p99OLRmsoaF5sEsEnUxxP/Nsg6D62mN7o2HbIhNI5
         BbbzLQBPYQ/ju7bqwVP3b43ah4ww8pLVS6XSqlgHdhGjmZhKDdhNdvgpiFMHjvtmuwnQ
         3cgTicsOeZo3+y0wxvkcGvfu2vGoLDo0f1NBNL5O5Az7Czls61Ii6D+GHlPHtokJ3mzI
         G4TzoVcFb8lWJmeCKjlb+P5YcOHrQFgNSG4f1OzTpHSf+LB1RGB0l4bWLc5mSiX0OLae
         ds2g==
X-Gm-Message-State: AOJu0YyIdPJP4MiIv0j9QAIj42PK6WKzNpD1gTc7SC7X15p4qca2ykgg
	ydNafgqv7WSeLSeIqFpSUpMdgw==
X-Google-Smtp-Source: AGHT+IF2SUXwZzo0JIGvQbZxVYfZuQ6LNiGHl0aDHrLZ0Lr25HO/Iyesi/PcPHNXMN4hfCQD7TfL2g==
X-Received: by 2002:a05:600c:4296:b0:40b:5e4a:406c with SMTP id v22-20020a05600c429600b0040b5e4a406cmr7409281wmc.140.1702835996023;
        Sun, 17 Dec 2023 09:59:56 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c4e8a00b0040d15dcb77asm3446604wmq.23.2023.12.17.09.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 09:59:55 -0800 (PST)
Date: Sun, 17 Dec 2023 17:59:54 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 10/23] PM: EM: Add API for memory allocations for new
 tables
Message-ID: <20231217175954.ascmdio7smqwmnfi@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-11-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129110853.94344-11-lukasz.luba@arm.com>

On 11/29/23 11:08, Lukasz Luba wrote:
> The runtime modified EM table can be provided from drivers. Create
> mechanism which allows safely allocate and free the table for device
> drivers. The same table can be used by the EAS in task scheduler code
> paths, so make sure the memory is not freed when the device driver module
> is unloaded.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 11 +++++++++
>  kernel/power/energy_model.c  | 44 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 94a77a813724..e785211828fe 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -5,6 +5,7 @@
>  #include <linux/device.h>
>  #include <linux/jump_label.h>
>  #include <linux/kobject.h>
> +#include <linux/kref.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sched/cpufreq.h>
>  #include <linux/sched/topology.h>
> @@ -39,10 +40,12 @@ struct em_perf_state {
>  /**
>   * struct em_perf_table - Performance states table
>   * @rcu:	RCU used for safe access and destruction
> + * @refcount:	Reference count to track the owners
>   * @state:	List of performance states, in ascending order
>   */
>  struct em_perf_table {
>  	struct rcu_head rcu;
> +	struct kref refcount;
>  	struct em_perf_state state[];
>  };
>  
> @@ -184,6 +187,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>  				struct em_data_callback *cb, cpumask_t *span,
>  				bool microwatts);
>  void em_dev_unregister_perf_domain(struct device *dev);
> +struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd);
> +void em_free_table(struct em_perf_table __rcu *table);
>  
>  /**
>   * em_pd_get_efficient_state() - Get an efficient performance state from the EM
> @@ -368,6 +373,12 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
>  {
>  	return 0;
>  }
> +static inline
> +struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd)
> +{
> +	return NULL;
> +}
> +static inline void em_free_table(struct em_perf_table __rcu *table) {}
>  #endif
>  
>  #endif
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 489287666705..489a358b9a00 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -114,12 +114,46 @@ static void em_destroy_table_rcu(struct rcu_head *rp)
>  	kfree(runtime_table);
>  }
>  
> -static void em_free_table(struct em_perf_table __rcu *table)
> +static void em_release_table_kref(struct kref *kref)
>  {
> +	struct em_perf_table __rcu *table;
> +
> +	/* It was the last owner of this table so we can free */
> +	table = container_of(kref, struct em_perf_table, refcount);
> +
>  	call_rcu(&table->rcu, em_destroy_table_rcu);
>  }
>  
> -static struct em_perf_table __rcu *
> +static inline void em_inc_usage(struct em_perf_table __rcu *table)
> +{
> +	kref_get(&table->refcount);
> +}
> +
> +static void em_dec_usage(struct em_perf_table __rcu *table)
> +{
> +	kref_put(&table->refcount, em_release_table_kref);
> +}

nit: em_table_inc/dec() instead? matches general theme elsewhere in the code
base.

> +
> +/**
> + * em_free_table() - Handles safe free of the EM table when needed
> + * @table : EM memory which is going to be freed
> + *
> + * No return values.
> + */
> +void em_free_table(struct em_perf_table __rcu *table)
> +{
> +	em_dec_usage(table);
> +}
> +
> +/**
> + * em_allocate_table() - Handles safe allocation of the new EM table
> + * @table : EM memory which is going to be freed
> + *
> + * Increments the reference counter to mark that there is an owner of that
> + * EM table. That might be a device driver module or EAS.
> + * Returns allocated table or error.
> + */
> +struct em_perf_table __rcu *
>  em_allocate_table(struct em_perf_domain *pd)
>  {
>  	struct em_perf_table __rcu *table;
> @@ -128,6 +162,12 @@ em_allocate_table(struct em_perf_domain *pd)
>  	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
>  
>  	table = kzalloc(sizeof(*table) + table_size, GFP_KERNEL);
> +	if (!table)
> +		return table;
> +
> +	kref_init(&table->refcount);
> +	em_inc_usage(table);

Doesn't kref_init() initialize to the count to 1 already? Is the em_inc_usage()
needed here?


Cheers

--
Qais Yousef

> +
>  	return table;
>  }
>  
> -- 
> 2.25.1
> 

