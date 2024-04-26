Return-Path: <linux-kernel+bounces-160450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FDA8B3DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2D11C20EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C4515ADBE;
	Fri, 26 Apr 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUgAYz/Q"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431615AACD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151399; cv=none; b=SUK9PKpyJEUQ39GJAqA64Rg9nIWi1wKWLlAPCIpYvRBxsoujuoyzG1fxyhsJDeCUuthN7ueSiOx7RRQpXp/OdkoOqL3BvhNEdApjbKuGAPaEDn/44bqNSRJp4lW2VquQxvTJ8xZjPf0tjm4pKrl7vAtKkut+XEsudHX6kAfwqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151399; c=relaxed/simple;
	bh=P+CYk46wJTO78LFJlKrMChQ9vLTaRMF/uOARCyNFy6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkQeOtF0guzDYkJ168scjKIbjm9IRc4LVMyLzI7dM1260h+YIWimGis3PENhRMqYL2bt1hF6fkWiV0XtRexAB/hnEJiHzen1gMdwLxas5bF+65EaozeuyRjY/3cgbHmkIqlqcDoG+MLnKgUq8G7tW6HS/JVCrnRm1jcJJtceYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mUgAYz/Q; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f103b541aeso2089210b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714151396; x=1714756196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpORPumHnXviKElGqJxnpMwhaItVQ3uuUpHgLD68KWE=;
        b=mUgAYz/QyQiV5JabWUCOtnV4x+/CrBHHm/QyBvfaLxrQuQkjvtcCswaXSH5BFhMU0m
         3aS4Eiyb/1QI8hRtR6EdWt7XmuPRSzYw7lPXLXJxaavMf6mEH94ZsMoT7tlWLFfSuL0r
         tOY9EP2CUJhJgv3eSm+Ne26nBex9PKIRx2Q0bz4raMNSHGt7wyWWO2KMyHj+rjtCSiZD
         w1ZMd4BhdjkY9Y1l0Emqh6ElNahJ11yL3ZiT19JRngZIYZOOtXqBKUL+DY2Aj8lqxmLI
         oAK6GEswWtXWH6hFrqN9OznAr/c+/Kli49hDWDl2qnCezfxc0CuguntmmRLx+z+apscL
         Wapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714151396; x=1714756196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpORPumHnXviKElGqJxnpMwhaItVQ3uuUpHgLD68KWE=;
        b=KjhsUnJJE+Iy8KYCIJ7ljrk2PwUqNZmVoki/L4+PyvFeCXN/Gj+1LCcsLtuqnDBrsu
         kELchhQshN/kC7Y4rVIgErE6oFGbMqNvhkpucm9a9o0Naw5N/VZX2slZ1+ljobl1q4Ag
         /+c6gnDCg+r/FMuZjtgSlNB2GU34Tkzy/jo5WiUGRiPSnwwzDawdGjWmsUjV8apP9HNK
         TvRC5tKTXdwWqrj5aewTD6mcZySd4OgF498TBoxMB5Ex2QrzgLuUiRXOQZNt9Z3OjT+D
         eSZbt6vTEmGCjX5oYOohS6l4VXSzd34mzDhiTi27CExIqhpt5oKw9fo8Jw10c/XfWlsu
         voXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWENwYEb9NecpIB/S5Meg4hA1QQomKd9wYxxqLzYmFLOLTXhlsWZnU9QJKCvs3qD+D9Qg47FhvksMFgldg85d50bvNphzRB/t7HyPWs
X-Gm-Message-State: AOJu0YzicH33yjtMpO2MqXgTUSIb0N6p+WLI3BXpeNAzh1pnFQIONQb1
	rqgfdifTybMvWBLNIIvL/PmGbVeFnFcIYjFu0IRidL8sARc6dHTHMVBj5em4ucg=
X-Google-Smtp-Source: AGHT+IFTRFN+NqZiT36h/4RLKjKGJ0CRxEpqLlzLqRF3GLzRXmnaLareb/1+Aqf3QmLNLMA/zDieeA==
X-Received: by 2002:a05:6a20:3945:b0:1a7:878f:e9a3 with SMTP id r5-20020a056a20394500b001a7878fe9a3mr4099773pzg.22.1714151396059;
        Fri, 26 Apr 2024 10:09:56 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:76e2:954b:3ea:1d57])
        by smtp.gmail.com with ESMTPSA id q13-20020a62e10d000000b006ece7862035sm15062830pfh.128.2024.04.26.10.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:09:55 -0700 (PDT)
Date: Fri, 26 Apr 2024 11:09:52 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: andersson@kernel.org, s-anna@ti.com, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, u-kumar1@ti.com, nm@ti.com,
	devarsht@ti.com, hnagalla@ti.com
Subject: Re: [PATCH v2 1/2] remoteproc: k3-r5: Wait for core0 power-up before
 powering up core1
Message-ID: <Zivf4Bhi8zqEQh7p@p14s>
References: <20240424130504.494916-1-b-padhi@ti.com>
 <20240424130504.494916-2-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424130504.494916-2-b-padhi@ti.com>

Good day,

On Wed, Apr 24, 2024 at 06:35:03PM +0530, Beleswar Padhi wrote:
> From: Apurva Nandan <a-nandan@ti.com>
> 
> PSC controller has a limitation that it can only power-up the second core
> when the first core is in ON state. Power-state for core0 should be equal
> to or higher than core1, else the kernel is seen hanging during rproc
> loading.
> 
> Make the powering up of cores sequential, by waiting for the current core
> to power-up before proceeding to the next core, with a timeout of 2sec.
> Add a wait queue event in k3_r5_cluster_rproc_init call, that will wait
> for the current core to be released from reset before proceeding with the
> next core.
> 
> Fixes: 6dedbd1d5443 ("remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem")
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>

You need to add your own SoB as well.

> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 28 ++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index ad3415a3851b..5a9bd5d4a2ea 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -103,12 +103,14 @@ struct k3_r5_soc_data {
>   * @dev: cached device pointer
>   * @mode: Mode to configure the Cluster - Split or LockStep
>   * @cores: list of R5 cores within the cluster
> + * @core_transition: wait queue to sync core state changes
>   * @soc_data: SoC-specific feature data for a R5FSS
>   */
>  struct k3_r5_cluster {
>  	struct device *dev;
>  	enum cluster_mode mode;
>  	struct list_head cores;
> +	wait_queue_head_t core_transition;
>  	const struct k3_r5_soc_data *soc_data;
>  };
>  
> @@ -128,6 +130,7 @@ struct k3_r5_cluster {
>   * @atcm_enable: flag to control ATCM enablement
>   * @btcm_enable: flag to control BTCM enablement
>   * @loczrama: flag to dictate which TCM is at device address 0x0
> + * @released_from_reset: flag to signal when core is out of reset
>   */
>  struct k3_r5_core {
>  	struct list_head elem;
> @@ -144,6 +147,7 @@ struct k3_r5_core {
>  	u32 atcm_enable;
>  	u32 btcm_enable;
>  	u32 loczrama;
> +	bool released_from_reset;
>  };
>  
>  /**
> @@ -460,6 +464,8 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
>  			ret);
>  		return ret;
>  	}
> +	core->released_from_reset = true;
> +	wake_up_interruptible(&cluster->core_transition);
>  
>  	/*
>  	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
> @@ -1140,6 +1146,7 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
>  		return ret;
>  	}
>  
> +	core->released_from_reset = c_state;

I understand why this is needed but it line could be very cryptic for people
trying to understand this driver.  Please add a comment to describe what is
happening here.

>  	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl,
>  				     &stat);
>  	if (ret < 0) {
> @@ -1280,6 +1287,26 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  		    cluster->mode == CLUSTER_MODE_SINGLECPU ||
>  		    cluster->mode == CLUSTER_MODE_SINGLECORE)
>  			break;
> +
> +		/*
> +		 * R5 cores require to be powered on sequentially, core0
> +		 * should be in higher power state than core1 in a cluster
> +		 * So, wait for current core to power up before proceeding
> +		 * to next core and put timeout of 2sec for each core.
> +		 *
> +		 * This waiting mechanism is necessary because
> +		 * rproc_auto_boot_callback() for core1 can be called before
> +		 * core0 due to thread execution order.
> +		 */
> +		ret = wait_event_interruptible_timeout(cluster->core_transition,
> +						       core->released_from_reset,
> +						       msecs_to_jiffies(2000));
> +		if (ret <= 0) {
> +			dev_err(dev,
> +				"Timed out waiting for %s core to power up!\n",
> +				rproc->name);
> +			return ret;
> +		}
>  	}
>  
>  	return 0;
> @@ -1709,6 +1736,7 @@ static int k3_r5_probe(struct platform_device *pdev)
>  	cluster->dev = dev;
>  	cluster->soc_data = data;
>  	INIT_LIST_HEAD(&cluster->cores);
> +	init_waitqueue_head(&cluster->core_transition);
>  
>  	ret = of_property_read_u32(np, "ti,cluster-mode", &cluster->mode);
>  	if (ret < 0 && ret != -EINVAL) {
> -- 
> 2.34.1
> 

