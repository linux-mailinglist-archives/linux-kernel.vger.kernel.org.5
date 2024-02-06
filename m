Return-Path: <linux-kernel+bounces-55409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E084BC57
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9F81F234A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FC5171D4;
	Tue,  6 Feb 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLgJ5XHh"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4468D51D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241182; cv=none; b=dI807HwjhqKFHWimttQz3/UpnA0mln6RVBCUQIZXLzuuRw1Qxhdhsxq2UMbkNMhex7XGY3GL1U9LL0kBEvijBdhhE8m7op19aHfwnABHfGckFKYSVEry3Gc1ehzl9oTIWmt3MjI9q+JP4Sas5Bidtr5UkeFkywgGEvhDCV2zjO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241182; c=relaxed/simple;
	bh=VVhzDt1nzxBLlkryootH7gB0a0OIdkDAPabVbkIWJxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3GDxblx4gwATJ9tqzAvnMpTmPejq5IKuUX7w1jpZEO9eXNgekRx9Htxok5Ztv7+15VEJnVXYtjCu3LDTKMJjnKphHGxPHM88B8mp8al0Z7QvSws4dD2KHUV8X6cZ8LUK064TJ3UlQV1O3GQ+9P44LTOS90dboImU7ucnretW28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NLgJ5XHh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e02fa257eeso633960b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 09:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707241178; x=1707845978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rb9xEyirtGCsTVMLq3WXEVsBdomE7xpr3Gl07IaIp9Y=;
        b=NLgJ5XHh4AM2IGUouqqFKmoERVPw22jAiHWpGGz1p+NaOUNxXt4lnTjtoxZViAHJgd
         9/lGYnkLdzTkfY4Abyz+kl1kqerKTnOKvwJisCRCTpCddC6HzDsH0YsmtN15vr4LbepS
         mXfcymXaDLvDe50uPENtJQLLLdzMZ+Y+o63pcJ/cK5TLGJ9bi7qvYMZ1mwx4mL+8bfCc
         5bf/f8jWX4ZnbG+7TE7TSgHuYhg0azyJN1xGfYcIyMyOOb6HgIOqzqpIGIyIqbUQvOWZ
         mDYZsmNNCrZtQhNgOTP8kWsCzA9M/0M3KTzxCpnHGmLPWTvrx4F0L4LA/wejBMDFDjSt
         b0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707241178; x=1707845978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rb9xEyirtGCsTVMLq3WXEVsBdomE7xpr3Gl07IaIp9Y=;
        b=COXDEHeKzmm/0dqvM/0SHKzjhSZg2FjCKQSBIcOnsx9K3uM/bO1WuxYBL9v5h1PpEz
         q2rklyoyloJNQorG9JyMb1DjTt38Q28FWtolhZrdPE4y3+K3XbQlHIUxM4zbmOHokcgr
         uwmTr0M86CHbeuZwImer+hbtJvBbkqgJB9KgfxCWnp+TeDiZF715ZM4K2ArwRHZE2Gvb
         shES6PxFS+30tgAE6JMrf/Wnk7r6H2kGMJW9t+Tpn0mall1tKgWeq3J0m+CNAkffFeSm
         KI0Ig+eKOjhyTL9Mt8N+BuWgn+yb78GG2MKDsvW+mu/GPNFjuUIR5IhM4haSXAHXAWFt
         AHFA==
X-Gm-Message-State: AOJu0YwV14JSjphlYu/RuO1X2exvQlHIyo7k9lvt5LiOfnrKRSFSzCiF
	r3GZxNq5eTyZz88vir9VEqCL6j+XAyExmrpkmI333BTaPOMnXPNXqde8L9NHyoWN7bN0l/+EDrd
	D
X-Google-Smtp-Source: AGHT+IEi/8CfW9wDHyEA2OHQP6EePASJl1jizXwsc41zLMMs2c3n0jD1ZcH8FWiqgRxsqI02AF9mSA==
X-Received: by 2002:a05:6a00:13a6:b0:6df:ee93:570 with SMTP id t38-20020a056a0013a600b006dfee930570mr216558pfg.6.1707241177800;
        Tue, 06 Feb 2024 09:39:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVbO66R4TOpmw2ZmlS3Fyp5Baz/4XtRIsg/bhQYV5FusHW7Xai8QXnA009TZVYEJ5O84/RAgTQ1ApRvxTGjgjXsvyKT7WZ9KYrN1ieff/P+aHcnidvtfzqOsC854JRhqVJrVD6E7chZ4KXRN5ckqA==
Received: from p14s ([2604:3d09:148c:c800:628f:df28:fb60:e513])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78696000000b006e04a659ed6sm2244047pfo.67.2024.02.06.09.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:39:37 -0800 (PST)
Date: Tue, 6 Feb 2024 10:39:35 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: zynqmp: fix lockstep mode memory region
Message-ID: <ZcJu10CIVYF9iodF@p14s>
References: <20240201004812.1471407-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201004812.1471407-1-tanmay.shah@amd.com>

On Wed, Jan 31, 2024 at 04:48:12PM -0800, Tanmay Shah wrote:
> In lockstep mode, r5 core0 uses TCM of R5 core1. Following is lockstep
> mode memory region as per hardware reference manual.
> 
>     |      *TCM*         |   *R5 View* | *Linux view* |
>     | R5_0 ATCM (128 KB) | 0x0000_0000 | 0xFFE0_0000  |
>     | R5_0 BTCM (128 KB) | 0x0002_0000 | 0xFFE2_0000  |
> 
> However, driver shouldn't model it as above because R5 core0 TCM and core1
> TCM has different power-domains mapped to it.
> Hence, TCM address space in lockstep mode should be modeled as 64KB
> regions only where each region has its own power-domain as following:
> 
>     |      *TCM*         |   *R5 View* | *Linux view* |
>     | R5_0 ATCM0 (64 KB) | 0x0000_0000 | 0xFFE0_0000  |
>     | R5_0 BTCM0 (64 KB) | 0x0002_0000 | 0xFFE2_0000  |
>     | R5_0 ATCM1 (64 KB) | 0x0001_0000 | 0xFFE1_0000  |
>     | R5_0 BTCM1 (64 KB) | 0x0003_0000 | 0xFFE3_0000  |
> 
> This fix makes driver maintanance easy and makes design robust for future
> platorms as well.
> 
> Fixes: 9af45bbdcbbb ("remoteproc: zynqmp: fix TCM carveouts in lockstep mode")

This patch doesn't fix a bug, i.e users won't see any changes once this patch
gets applied.  As such there is no need for a "Fixes" tag.  When you resend this
patch (see below), please remove the line.

> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 145 ++----------------------
>  1 file changed, 12 insertions(+), 133 deletions(-)
>

I am happy with this patch but won't apply it because I want to see what comes
next.  Please include it in your next patchet.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 4395edea9a64..42b0384d34f2 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -84,12 +84,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
>  	{0xffeb0000UL, 0x20000, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
>  };
>  
> -/* In lockstep mode cluster combines each 64KB TCM and makes 128KB TCM */
> +/* In lockstep mode cluster uses each 64KB TCM from second core as well */
>  static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> -	{0xffe00000UL, 0x0, 0x20000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 128KB each */
> -	{0xffe20000UL, 0x20000, 0x20000UL, PD_R5_0_BTCM, "btcm0"},
> -	{0, 0, 0, PD_R5_1_ATCM, ""},
> -	{0, 0, 0, PD_R5_1_BTCM, ""},
> +	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> +	{0xffe20000UL, 0x20000, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
> +	{0xffe10000UL, 0x10000, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
> +	{0xffe30000UL, 0x30000, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
>  };
>  
>  /**
> @@ -540,14 +540,14 @@ static int tcm_mem_map(struct rproc *rproc,
>  }
>  
>  /*
> - * add_tcm_carveout_split_mode()
> + * add_tcm_banks()
>   * @rproc: single R5 core's corresponding rproc instance
>   *
> - * allocate and add remoteproc carveout for TCM memory in split mode
> + * allocate and add remoteproc carveout for TCM memory
>   *
>   * return 0 on success, otherwise non-zero value on failure
>   */
> -static int add_tcm_carveout_split_mode(struct rproc *rproc)
> +static int add_tcm_banks(struct rproc *rproc)
>  {
>  	struct rproc_mem_entry *rproc_mem;
>  	struct zynqmp_r5_core *r5_core;
> @@ -580,10 +580,10 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
>  		if (ret < 0) {
>  			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> -			goto release_tcm_split;
> +			goto release_tcm;
>  		}
>  
> -		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, da=0x%x, size=0x%lx",
> +		dev_dbg(dev, "TCM carveout %s addr=%llx, da=0x%x, size=0x%lx",
>  			bank_name, bank_addr, da, bank_size);
>  
>  		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> @@ -593,7 +593,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  		if (!rproc_mem) {
>  			ret = -ENOMEM;
>  			zynqmp_pm_release_node(pm_domain_id);
> -			goto release_tcm_split;
> +			goto release_tcm;
>  		}
>  
>  		rproc_add_carveout(rproc, rproc_mem);
> @@ -601,7 +601,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  
>  	return 0;
>  
> -release_tcm_split:
> +release_tcm:
>  	/* If failed, Turn off all TCM banks turned on before */
>  	for (i--; i >= 0; i--) {
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> @@ -610,127 +610,6 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  	return ret;
>  }
>  
> -/*
> - * add_tcm_carveout_lockstep_mode()
> - * @rproc: single R5 core's corresponding rproc instance
> - *
> - * allocate and add remoteproc carveout for TCM memory in lockstep mode
> - *
> - * return 0 on success, otherwise non-zero value on failure
> - */
> -static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> -{
> -	struct rproc_mem_entry *rproc_mem;
> -	struct zynqmp_r5_core *r5_core;
> -	int i, num_banks, ret;
> -	phys_addr_t bank_addr;
> -	size_t bank_size = 0;
> -	struct device *dev;
> -	u32 pm_domain_id;
> -	char *bank_name;
> -	u32 da;
> -
> -	r5_core = rproc->priv;
> -	dev = r5_core->dev;
> -
> -	/* Go through zynqmp banks for r5 node */
> -	num_banks = r5_core->tcm_bank_count;
> -
> -	/*
> -	 * In lockstep mode, TCM is contiguous memory block
> -	 * However, each TCM block still needs to be enabled individually.
> -	 * So, Enable each TCM block individually.
> -	 * Although ATCM and BTCM is contiguous memory block, add two separate
> -	 * carveouts for both.
> -	 */
> -	for (i = 0; i < num_banks; i++) {
> -		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> -
> -		/* Turn on each TCM bank individually */
> -		ret = zynqmp_pm_request_node(pm_domain_id,
> -					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> -					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> -			goto release_tcm_lockstep;
> -		}
> -
> -		bank_size = r5_core->tcm_banks[i]->size;
> -		if (bank_size == 0)
> -			continue;
> -
> -		bank_addr = r5_core->tcm_banks[i]->addr;
> -		da = r5_core->tcm_banks[i]->da;
> -		bank_name = r5_core->tcm_banks[i]->bank_name;
> -
> -		/* Register TCM address range, TCM map and unmap functions */
> -		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> -						 bank_size, da,
> -						 tcm_mem_map, tcm_mem_unmap,
> -						 bank_name);
> -		if (!rproc_mem) {
> -			ret = -ENOMEM;
> -			zynqmp_pm_release_node(pm_domain_id);
> -			goto release_tcm_lockstep;
> -		}
> -
> -		/* If registration is success, add carveouts */
> -		rproc_add_carveout(rproc, rproc_mem);
> -
> -		dev_dbg(dev, "TCM carveout lockstep mode %s addr=0x%llx, da=0x%x, size=0x%lx",
> -			bank_name, bank_addr, da, bank_size);
> -	}
> -
> -	return 0;
> -
> -release_tcm_lockstep:
> -	/* If failed, Turn off all TCM banks turned on before */
> -	for (i--; i >= 0; i--) {
> -		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> -		zynqmp_pm_release_node(pm_domain_id);
> -	}
> -	return ret;
> -}
> -
> -/*
> - * add_tcm_banks()
> - * @rproc: single R5 core's corresponding rproc instance
> - *
> - * allocate and add remoteproc carveouts for TCM memory based on cluster mode
> - *
> - * return 0 on success, otherwise non-zero value on failure
> - */
> -static int add_tcm_banks(struct rproc *rproc)
> -{
> -	struct zynqmp_r5_cluster *cluster;
> -	struct zynqmp_r5_core *r5_core;
> -	struct device *dev;
> -
> -	r5_core = rproc->priv;
> -	if (!r5_core)
> -		return -EINVAL;
> -
> -	dev = r5_core->dev;
> -
> -	cluster = dev_get_drvdata(dev->parent);
> -	if (!cluster) {
> -		dev_err(dev->parent, "Invalid driver data\n");
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * In lockstep mode TCM banks are one contiguous memory region of 256Kb
> -	 * In split mode, each TCM bank is 64Kb and not contiguous.
> -	 * We add memory carveouts accordingly.
> -	 */
> -	if (cluster->mode == SPLIT_MODE)
> -		return add_tcm_carveout_split_mode(rproc);
> -	else if (cluster->mode == LOCKSTEP_MODE)
> -		return add_tcm_carveout_lockstep_mode(rproc);
> -
> -	return -EINVAL;
> -}
> -
>  /*
>   * zynqmp_r5_parse_fw()
>   * @rproc: single R5 core's corresponding rproc instance
> 
> base-commit: 99f59b148871dadb9104366e3d25b120a97f897b
> -- 
> 2.25.1
> 

