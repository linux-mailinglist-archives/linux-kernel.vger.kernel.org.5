Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27E27CE4C2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjJRRi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjJRRiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:38:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568B0123
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:38:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6be840283ceso1642042b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697650693; x=1698255493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+2+QN7EU6t/QqHaWaFRD+XbpNqyec7NeEjYKA6Lgk8=;
        b=FHP/MQOiIh6F5CVSpuwXU2ATYSnBkP6KSZ26vQVmcXNDjArQIPR3snEErag4KdoHv3
         N9TIHWgvxYbjMaKmb3nGTBVUfffpiJ59wY175u7ZzdukYYG0GU/8y6j0Gec0frZja4m8
         m3KaS66AMD4vsk21ycOUhMfiREb6X1mXHNjM/Men4cnLfOCy3KvSdpAM4qcr2nJWecY/
         Bfnp7Z/WsQXfs+Fwva0FjpLvnGuRg6Ee2xelONMeYQKLrQYoB7zgDdrW9a0lQ9GkINI7
         6I/4nJnuMb1Doa8WMCE8siSV7SsX6+8O5Iwgxwyzt3hGtnFiJTM5bcabfYVi+gREMrxI
         XaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650693; x=1698255493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+2+QN7EU6t/QqHaWaFRD+XbpNqyec7NeEjYKA6Lgk8=;
        b=H00zBA+wbTblZf9Q5KUxPm8cu/Xj67SnbSy6OtrYTQs1q6DsljOnS1+0EaZtJHYxEy
         HAuo7+Tst5BQHYv66yWg7S2cpMyFsytkdiVjyz8q7X6Qtz1jZrGKQJ0Sp1EYs2Za9IaH
         V6y7hZIflF50Lm5H/eMDCBqBwxIxuq/FBjW55b72731ePR1KmLilKwXRxI2c9T76soKf
         IWrC04Upl51G31hNZga2EZZNeNvK1numpIbzhwQGaU/ZCm2slTdM76ydJ4kcuk+zrLDI
         DvY5lywui5gCjWkxrLHpcpMXHzXHKrawpWXuK0d0TRHzIpk/vFfT2bbdGZzC1aZBC/Sn
         k80w==
X-Gm-Message-State: AOJu0Yw8O+Xgb4pV4JuyAJeG6xKlCycv/yoOMMh5HdzNUAMZKuCb1UPK
        nBMldZpcbGFNWp+ZbXMZG5oQ7Q==
X-Google-Smtp-Source: AGHT+IEtkwbf8prVSdlSLecr5GXdhJeX9bwEul/GCTLMW8+yqICig3mT5WqxnNFIiQSQTCZTpEcJUw==
X-Received: by 2002:a05:6a21:3812:b0:17a:2f1:ce1 with SMTP id yi18-20020a056a21381200b0017a02f10ce1mr4768462pzb.31.1697650692529;
        Wed, 18 Oct 2023 10:38:12 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:da8e:1d08:48f5:2571])
        by smtp.gmail.com with ESMTPSA id k64-20020a17090a4cc600b0027360359b70sm197326pjh.48.2023.10.18.10.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:38:12 -0700 (PDT)
Date:   Wed, 18 Oct 2023 11:38:09 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, ben.levinsky@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] remoteproc: zynqmp: add pm domains support
Message-ID: <ZTAYASCZA3dZOvmJ@p14s>
References: <20231013042229.3954527-1-tanmay.shah@amd.com>
 <20231013042229.3954527-4-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013042229.3954527-4-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

On Thu, Oct 12, 2023 at 09:22:28PM -0700, Tanmay Shah wrote:
> Use TCM pm domains extracted from device-tree
> to power on/off TCM using general pm domain framework.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v6:
>   - Remove spurious change
>   - Handle errors in add_pm_domains function
>   - Remove redundant code to handle errors from remove_pm_domains
> 
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 262 ++++++++++++++++++++++--
>  1 file changed, 243 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 4395edea9a64..04e95d880184 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
> +#include <linux/pm_domain.h>
>  
>  #include "remoteproc_internal.h"
>  
> @@ -102,6 +103,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
>   * @rproc: rproc handle
>   * @pm_domain_id: RPU CPU power domain id
>   * @ipi: pointer to mailbox information
> + * @num_pm_dev: number of tcm pm domain devices for this core
> + * @pm_dev1: pm domain virtual devices for power domain framework
> + * @pm_dev_link1: pm domain device links after registration
> + * @pm_dev2: used only in lockstep mode. second core's pm domain virtual devices
> + * @pm_dev_link2: used only in lockstep mode. second core's pm device links after
> + * registration
>   */
>  struct zynqmp_r5_core {
>  	struct device *dev;
> @@ -111,6 +118,11 @@ struct zynqmp_r5_core {
>  	struct rproc *rproc;
>  	u32 pm_domain_id;
>  	struct mbox_info *ipi;
> +	int num_pm_dev;
> +	struct device **pm_dev1;

s/pm_dev1/pm_dev_core0

> +	struct device_link **pm_dev_link1;

s/pm_dev_link1/pm_dev_core0_link;

> +	struct device **pm_dev2;

s/pm_dev2/pm_dev_core1

> +	struct device_link **pm_dev_link2;

s/pm_dev_link2/pm_dev_core1_link;

>  };
>  
>  /**
> @@ -575,12 +587,21 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  		bank_size = r5_core->tcm_banks[i]->size;
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>  
> -		ret = zynqmp_pm_request_node(pm_domain_id,
> -					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> -					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> -			goto release_tcm_split;
> +		/*
> +		 * If TCM information is available in device-tree then
> +		 * in that case, pm domain framework will power on/off TCM.
> +		 * In that case pm_domain_id is set to 0. If hardcode
> +		 * bindings from driver is used, then only this driver will
> +		 * use pm_domain_id.
> +		 */
> +		if (pm_domain_id) {
> +			ret = zynqmp_pm_request_node(pm_domain_id,
> +						     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> +						     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +			if (ret < 0) {
> +				dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> +				goto release_tcm_split;
> +			}

This should go in the next patch.

>  		}
>  
>  		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, da=0x%x, size=0x%lx",
> @@ -646,13 +667,16 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
>  	for (i = 0; i < num_banks; i++) {
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
>  
> -		/* Turn on each TCM bank individually */
> -		ret = zynqmp_pm_request_node(pm_domain_id,
> -					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> -					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> -			goto release_tcm_lockstep;
> +		if (pm_domain_id) {
> +			/* Turn on each TCM bank individually */
> +			ret = zynqmp_pm_request_node(pm_domain_id,
> +						     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> +						     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +			if (ret < 0) {
> +				dev_err(dev, "failed to turn on TCM 0x%x",
> +					pm_domain_id);
> +				goto release_tcm_lockstep;
> +			}

Same

>  		}
>  
>  		bank_size = r5_core->tcm_banks[i]->size;
> @@ -687,7 +711,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
>  	/* If failed, Turn off all TCM banks turned on before */
>  	for (i--; i >= 0; i--) {
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> -		zynqmp_pm_release_node(pm_domain_id);
> +		if (pm_domain_id)
> +			zynqmp_pm_release_node(pm_domain_id);
>  	}
>  	return ret;
>  }
> @@ -758,6 +783,192 @@ static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
>  	return ret;
>  }
>  
> +static void zynqmp_r5_remove_pm_domains(struct rproc *rproc)
> +{
> +	struct zynqmp_r5_core *r5_core = rproc->priv;
> +	struct device *dev = r5_core->dev;
> +	struct zynqmp_r5_cluster *cluster;
> +	int i;
> +
> +	cluster = platform_get_drvdata(to_platform_device(dev->parent));
> +
> +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> +		device_link_del(r5_core->pm_dev_link1[i]);
> +		dev_pm_domain_detach(r5_core->pm_dev1[i], false);
> +	}
> +
> +	kfree(r5_core->pm_dev1);
> +	r5_core->pm_dev1 = NULL;
> +	kfree(r5_core->pm_dev_link1);
> +	r5_core->pm_dev_link1 = NULL;
> +
> +	if (cluster->mode == SPLIT_MODE) {
> +		r5_core->num_pm_dev = 0;
> +		return;
> +	}
> +
> +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> +		device_link_del(r5_core->pm_dev_link2[i]);
> +		dev_pm_domain_detach(r5_core->pm_dev2[i], false);
> +	}
> +
> +	kfree(r5_core->pm_dev2);
> +	r5_core->pm_dev2 = NULL;
> +	kfree(r5_core->pm_dev_link2);
> +	r5_core->pm_dev_link2 = NULL;
> +	r5_core->num_pm_dev = 0;
> +}
> +
> +static int zynqmp_r5_add_pm_domains(struct rproc *rproc)
> +{
> +	struct zynqmp_r5_core *r5_core = rproc->priv;
> +	struct device *dev = r5_core->dev, *dev2;
> +	struct zynqmp_r5_cluster *cluster;
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	int i, j, num_pm_dev, ret;
> +
> +	cluster = dev_get_drvdata(dev->parent);
> +
> +	/* get number of power-domains */
> +	num_pm_dev = of_count_phandle_with_args(r5_core->np, "power-domains",
> +						"#power-domain-cells");
> +
> +	if (num_pm_dev <= 0)
> +		return -EINVAL;
> +
> +	r5_core->pm_dev1 = kcalloc(num_pm_dev,
> +				   sizeof(struct device *),
> +				   GFP_KERNEL);
> +	if (!r5_core->pm_dev1)
> +		ret = -ENOMEM;
> +
> +	r5_core->pm_dev_link1 = kcalloc(num_pm_dev,
> +					sizeof(struct device_link *),
> +					GFP_KERNEL);
> +	if (!r5_core->pm_dev_link1) {
> +		kfree(r5_core->pm_dev1);
> +		r5_core->pm_dev1 = NULL;
> +		return -ENOMEM;
> +	}
> +
> +	r5_core->num_pm_dev = num_pm_dev;
> +
> +	/*
> +	 * start from 2nd entry in power-domains property list as
> +	 * for zynqmp we only add TCM power domains and not core's power domain.
> +	 */

It would be worth mentionning where the 1st entry get added.

> +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> +		r5_core->pm_dev1[i] = dev_pm_domain_attach_by_id(dev, i);
> +		if (IS_ERR_OR_NULL(r5_core->pm_dev1[i])) {
> +			dev_dbg(dev, "failed to attach pm domain %d, ret=%ld\n", i,
> +				PTR_ERR(r5_core->pm_dev1[i]));
> +			ret = -EINVAL;
> +			goto fail_add_pm_domains;
> +		}
> +		r5_core->pm_dev_link1[i] = device_link_add(dev, r5_core->pm_dev1[i],
> +							   DL_FLAG_STATELESS |
> +							   DL_FLAG_RPM_ACTIVE |
> +							   DL_FLAG_PM_RUNTIME);
> +		if (!r5_core->pm_dev_link1[i]) {
> +			dev_pm_domain_detach(r5_core->pm_dev1[i], true);
> +			r5_core->pm_dev1[i] = NULL;
> +			ret = -EINVAL;

Cleanup for this iteration is properly done here.  As such the while() loop in
fail_add_pm_domains needs to be while (--i >= 0).  See my comment below.

> +			goto fail_add_pm_domains;
> +		}
> +	}
> +
> +	if (cluster->mode == SPLIT_MODE)
> +		return 0;
> +
> +	r5_core->pm_dev2 = kcalloc(num_pm_dev,
> +				   sizeof(struct device *),
> +				   GFP_KERNEL);
> +	if (!r5_core->pm_dev2) {
> +		ret = -ENOMEM;
> +		goto fail_add_pm_domains;
> +	}
> +
> +	r5_core->pm_dev_link2 = kcalloc(num_pm_dev,
> +					sizeof(struct device_link *),
> +					GFP_KERNEL);
> +	if (!r5_core->pm_dev_link2) {
> +		kfree(r5_core->pm_dev2);
> +		r5_core->pm_dev2 = NULL;
> +		ret = -ENOMEM;
> +		goto fail_add_pm_domains;
> +	}
> +
> +	/* get second core's device to detach its power-domains */
> +	np = of_get_next_child(cluster->dev->of_node, of_node_get(dev->of_node));
> +
> +	pdev = of_find_device_by_node(np);
> +	if (!pdev) {
> +		dev_err(cluster->dev, "core1 platform device not available\n");
> +		kfree(r5_core->pm_dev2);
> +		kfree(r5_core->pm_dev_link2);
> +		r5_core->pm_dev2 = NULL;
> +		r5_core->pm_dev_link2 = NULL;
> +		ret = -EINVAL;
> +		goto fail_add_pm_domains;
> +	}
> +
> +	dev2 = &pdev->dev;
> +
> +	/* for zynqmp we only add TCM power domains and not core's power domain */
> +	for (j = 1; j < r5_core->num_pm_dev; j++) {
> +		r5_core->pm_dev2[j] = dev_pm_domain_attach_by_id(dev2, j);
> +		if (!r5_core->pm_dev2[j]) {
> +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> +			ret = -EINVAL;
> +			goto fail_add_pm_domains_lockstep;
> +		} else if (IS_ERR(r5_core->pm_dev2[j])) {
> +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> +			ret = PTR_ERR(r5_core->pm_dev2[j]);
> +			goto fail_add_pm_domains_lockstep;
> +		}
> +
> +		r5_core->pm_dev_link2[j] = device_link_add(dev, r5_core->pm_dev2[j],
> +							   DL_FLAG_STATELESS |
> +							   DL_FLAG_RPM_ACTIVE |
> +							   DL_FLAG_PM_RUNTIME);
> +		if (!r5_core->pm_dev_link2[j]) {
> +			dev_pm_domain_detach(r5_core->pm_dev2[j], true);
> +			r5_core->pm_dev2[j] = NULL;
> +			ret = -ENODEV;
> +			goto fail_add_pm_domains_lockstep;
> +		}
> +	}
> +
> +fail_add_pm_domains_lockstep:
> +	while (j >= 1) {
> +		if (r5_core->pm_dev_link2 && !IS_ERR_OR_NULL(r5_core->pm_dev_link2[j]))
> +			device_link_del(r5_core->pm_dev_link2[j]);
> +		if (r5_core->pm_dev2 && !IS_ERR_OR_NULL(r5_core->pm_dev2[j]))
> +			dev_pm_domain_detach(r5_core->pm_dev2[j], true);
> +		j--;
> +	}
> +	kfree(r5_core->pm_dev2);
> +	r5_core->pm_dev2 = NULL;
> +	kfree(r5_core->pm_dev_link2);
> +	r5_core->pm_dev_link2 = NULL;
> +
> +fail_add_pm_domains:
> +	while (i >= 1) {
> +		if (r5_core->pm_dev_link1 && !IS_ERR_OR_NULL(r5_core->pm_dev_link1[i]))
> +			device_link_del(r5_core->pm_dev_link1[i]);

Because the cleanup is properly done above we can start the loop at the previous
value of 'i', i.e --i.  The added bonus is that you don't need the if()
statement.

Another problem with starting at 'i' is that you get an out of bound access when
all PM domains have been properly added for core 0 but fail for core 1.

> +		if (r5_core->pm_dev1 && !IS_ERR_OR_NULL(r5_core->pm_dev1[i]))
> +			dev_pm_domain_detach(r5_core->pm_dev1[i], true);

Same as above.

I will stop here for this revision.

Mathieu


> +		i--;
> +	}
> +	kfree(r5_core->pm_dev1);
> +	r5_core->pm_dev1 = NULL;
> +	kfree(r5_core->pm_dev_link1);
> +	r5_core->pm_dev_link1 = NULL;
> +
> +	return ret;
> +}
> +
>  /**
>   * zynqmp_r5_rproc_prepare()
>   * adds carveouts for TCM bank and reserved memory regions
> @@ -770,19 +981,30 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
>  {
>  	int ret;
>  
> +	ret = zynqmp_r5_add_pm_domains(rproc);
> +	if (ret) {
> +		dev_err(&rproc->dev, "failed to add pm domains\n");
> +		return ret;
> +	}
> +
>  	ret = add_tcm_banks(rproc);
>  	if (ret) {
>  		dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
> -		return ret;
> +		goto fail_prepare;
>  	}
>  
>  	ret = add_mem_regions_carveout(rproc);
>  	if (ret) {
>  		dev_err(&rproc->dev, "failed to get reserve mem regions %d\n", ret);
> -		return ret;
> +		goto fail_prepare;
>  	}
>  
>  	return 0;
> +
> +fail_prepare:
> +	zynqmp_r5_remove_pm_domains(rproc);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -801,11 +1023,13 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
>  
>  	r5_core = rproc->priv;
>  
> +	zynqmp_r5_remove_pm_domains(rproc);
> +
>  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> -		if (zynqmp_pm_release_node(pm_domain_id))
> -			dev_warn(r5_core->dev,
> -				 "can't turn off TCM bank 0x%x", pm_domain_id);
> +		if (pm_domain_id && zynqmp_pm_release_node(pm_domain_id))
> +			dev_dbg(r5_core->dev,
> +				"can't turn off TCM bank 0x%x", pm_domain_id);
>  	}
>  
>  	return 0;
> -- 
> 2.25.1
> 
