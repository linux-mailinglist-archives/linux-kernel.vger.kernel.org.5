Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5D79AD93
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346825AbjIKVYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbjIKQpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:45:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AB6E3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:45:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fb5bd8f02so1287171b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694450736; x=1695055536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oqKvGMHqYqut6M1/awSuIk3zziLg+uksxVFlWIgcNLk=;
        b=K2VUXHeUUB9BDeeaYt/OuNxcDryMWfV8FITVMjuFlE6uYdZ3YN2tTECNeG3Lk1ugS0
         xZlL4SEl+V6fmgGKiQVygFSyhB1yk0ZA9jUSdaTT3a8yNxfqA6QM5Ogg1NCtovKTd0Z+
         4gXDWKXABP66OZPHIyRNXq7JAoZoTSZJbT/i74P4IgrQ9VYtf0tGweHCM8vQf92T+gGQ
         24PJbiDtpXmOb5KwrS/si5ZcU8KkwCrrjzn1e+H+zeYncqT6iZs5YaLqJPLaiFevTmvz
         zDTxzpe7/Ynv7abJOsVBYahnLMuM9O3gerv5NrqHFmT7vwZmoI92e0gjXzlJVr/EicZy
         7a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694450736; x=1695055536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqKvGMHqYqut6M1/awSuIk3zziLg+uksxVFlWIgcNLk=;
        b=jXpqd1DH4dGDB+uCkXV1P4T7MezoCIRZdP3sYsWNi0Sz04K3HighXtSxq8/bw/pjIy
         KeKXb2UbRdzgiEY8Obc0ij2wVyyScpbY1qNdSdnqiOxhW62QndGZqqWsLUpoSMMivuXq
         Mw3q1L4QX8PzoVeI96d/NukU0wVAKARcwJjxGj644Sc98tKBOLktCeSln5pjGe1NE+Gw
         7uaP1WXMdaoswVVcXf0w4qUJyUIYLI7xvUshWovPCeuXzUbrW9+EByOAjZxEpRWhewrl
         0B9cEEqm7F7hE4ogoE4jdYgG3qp50IRF8qh2XcHRnPcx4NGeZa5jS5DN13S8czYx+BSF
         XQmQ==
X-Gm-Message-State: AOJu0YxlwQ8Q7bFNNxRbK4y4xqomnn3riyoBqLp9wVeaUsRfxvkxIl0E
        I/K5JKjNG4wPK+5raGKCemcWaA==
X-Google-Smtp-Source: AGHT+IGVKv99gjdhTfQwWUcVSjYyCdzVgcuDt5u9yDRwFVKUSkhQxBLAXf3VgNUeXzKBENN2j5I6SA==
X-Received: by 2002:a05:6a20:3d93:b0:152:6b63:f1e7 with SMTP id s19-20020a056a203d9300b001526b63f1e7mr10224833pzi.1.1694450736278;
        Mon, 11 Sep 2023 09:45:36 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:cb1c:f39e:e329:2c3d])
        by smtp.gmail.com with ESMTPSA id t4-20020a62ea04000000b0068bc44dc40dsm5794566pfh.34.2023.09.11.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:45:35 -0700 (PDT)
Date:   Mon, 11 Sep 2023 10:45:33 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Bjorn Andersson <andersson@kernel.org>,
        Suman Anna <s-anna@ti.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>,
        Hari Nagalla <hnagalla@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH] remoteproc: k3-r5: Wait for core0 power-up before
 powering up core1
Message-ID: <ZP9ELdOQ9WMj2Rxd@p14s>
References: <20230906124756.3480579-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906124756.3480579-1-a-nandan@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Apurva,

On Wed, Sep 06, 2023 at 06:17:56PM +0530, Apurva Nandan wrote:
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
> ---
> 
>  kpv report: https://gist.githubusercontent.com/apurvanandan1997/feb3b304121c265b7827be43752b7ae8/raw
> 
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index ad3415a3851b..ba5e503f7c9c 100644
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
>  	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl,
>  				     &stat);
>  	if (ret < 0) {
> @@ -1280,6 +1287,21 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>  		    cluster->mode == CLUSTER_MODE_SINGLECPU ||
>  		    cluster->mode == CLUSTER_MODE_SINGLECORE)
>  			break;
> +
> +		/* R5 cores require to be powered on sequentially, core0
> +		 * should be in higher power state than core1 in a cluster
> +		 * So, wait for current core to power up before proceeding
> +		 * to next core and put timeout of 2sec for each core.
> +		 */

Wrong multi-line comment format.

> +		ret = wait_event_interruptible_timeout(cluster->core_transition,
> +						       core->released_from_reset,
> +						       msecs_to_jiffies(2000));
> +		if (ret <= 0) {
> +			dev_err(dev,
> +				"Timed out waiting for %s core to power up!\n",
> +				rproc->name);
> +			return ret;
> +		}

From my perspective, this is needed because rproc_auto_boot_callback() for core1
can be called before core0 due to thread execution order.  Am I correct?  

If so please add this explanation to the comment you have above.  Also, let's
say a user decides to switch both cores off after reboot.  At that time, what
prevents a user from switching on core1 before core0 via sysfs?

Thanks,
Mathieu

>  	}
>  
>  	return 0;
> @@ -1709,6 +1731,7 @@ static int k3_r5_probe(struct platform_device *pdev)
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
