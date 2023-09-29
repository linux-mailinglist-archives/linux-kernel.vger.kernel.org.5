Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1226E7B3837
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjI2Q6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjI2Q6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:58:19 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB131A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:58:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-573c62b3cd2so9233967a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696006696; x=1696611496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NMqJFtytKcP8lUd+Bm9Yn0vug485IKuzeteN3fJyMJ8=;
        b=YHNOBKfegl5vIN3StJTAxXd37e9It+sewIyEqwcUK34NcIIFmPX6CysM60rk37Xftx
         PM46FlQjIE8zBJh4y9xu0jbcRzZnSoZ4CJ9zec76O6O/7TxGDRGjLHk2zXGmve3Fg+7e
         cviByyUnak6tZNXNmAwZO0agXc2bGi+H8m50o+1+ffo+nhj2vz+1e3hLVCCNQEZWrevF
         ndFAwEVPoYEvdwfBxrydJ8DLgQUstUoRNcP3yLYqAk06MbvI0etmRKDvfoMiyQ/FVCGi
         ntO3Y25ShPEJDJ5DHMh3wjN63kHOw8FYtYYFYVTVBnyXoEKRvazMRTozOk2AQAwV0vN/
         d70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696006696; x=1696611496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMqJFtytKcP8lUd+Bm9Yn0vug485IKuzeteN3fJyMJ8=;
        b=nv9taAoLt/4HCkX+/kOncUmwQjSWcXgTANvqDju/lNc4LYTq93OOYLPndzjQaWcDJ1
         bOgsQ5hdXhUQ9b6wVGtt+CH9S7Lh9X/ICcEwPuiMncIfqNhhWJk/vQhPLoMH4AnBipsa
         S7gvL2o/1coq1ClVHu55cASQye/lbZ2J5hggtvxj74QtMGobAoOcRs0eSpSbPBxf5bqp
         PMrp864jlWs8e4UzsCoP81b1JqnAlR3UJOqy1uDZ3tJGNWwkp0VLbM3JJyo3NiSpsW6+
         /4IWGPBD2CkyFg0SaF4m/HBCAzD5DJ1dwpO0o64I/bQAFfBA7zjtuwcyj41aGCR/rXT6
         RzyA==
X-Gm-Message-State: AOJu0Yx4V6d038s9JotniE5FBEQMK4xIOVYwaiyfDCni0kH0+1MAsr9V
        d0EVwkfv6gpzs3D7z3MeTrzQ7w==
X-Google-Smtp-Source: AGHT+IFYDdh+LIB4m9kIWN0rVKInvkNQerIgkvMPdRsEywsL347q8XFzZ5L+QEjwFYfmBYdr+a/Ndg==
X-Received: by 2002:a17:90b:3b8a:b0:268:d456:123 with SMTP id pc10-20020a17090b3b8a00b00268d4560123mr4403232pjb.41.1696006695992;
        Fri, 29 Sep 2023 09:58:15 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:6039:c963:11ba:ad1b])
        by smtp.gmail.com with ESMTPSA id v1-20020a17090abb8100b002777b8fc74bsm1685259pjr.21.2023.09.29.09.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 09:58:15 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:58:13 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     andersson@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: zynqmp: change tcm address translation method
Message-ID: <ZRcCJbbyW+g4yjgs@p14s>
References: <20230925172648.2339048-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925172648.2339048-1-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:26:48AM -0700, Tanmay Shah wrote:
> Introduce device address in hardcode TCM table.
> Device address is used for address translation.
> Also, previous method(hack) to mask few bits from address
> to achieve address translation is removed
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 58 +++++++++----------------
>  1 file changed, 20 insertions(+), 38 deletions(-)
>

Applied.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index efd758c2f4ed..4395edea9a64 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -39,12 +39,14 @@ enum zynqmp_r5_cluster_mode {
>   * struct mem_bank_data - Memory Bank description
>   *
>   * @addr: Start address of memory bank
> + * @da: device address
>   * @size: Size of Memory bank
>   * @pm_domain_id: Power-domains id of memory bank for firmware to turn on/off
>   * @bank_name: name of the bank for remoteproc framework
>   */
>  struct mem_bank_data {
>  	phys_addr_t addr;
> +	u32 da;
>  	size_t size;
>  	u32 pm_domain_id;
>  	char *bank_name;
> @@ -76,18 +78,18 @@ struct mbox_info {
>   * accepted for system-dt specifications and upstreamed in linux kernel
>   */
>  static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
> -	{0xffe00000UL, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> -	{0xffe20000UL, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
> -	{0xffe90000UL, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
> -	{0xffeb0000UL, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
> +	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> +	{0xffe20000UL, 0x20000, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
> +	{0xffe90000UL, 0x0, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
> +	{0xffeb0000UL, 0x20000, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
>  };
>  
>  /* In lockstep mode cluster combines each 64KB TCM and makes 128KB TCM */
>  static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> -	{0xffe00000UL, 0x20000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 128KB each */
> -	{0xffe20000UL, 0x20000UL, PD_R5_0_BTCM, "btcm0"},
> -	{0, 0, PD_R5_1_ATCM, ""},
> -	{0, 0, PD_R5_1_BTCM, ""},
> +	{0xffe00000UL, 0x0, 0x20000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 128KB each */
> +	{0xffe20000UL, 0x20000, 0x20000UL, PD_R5_0_BTCM, "btcm0"},
> +	{0, 0, 0, PD_R5_1_ATCM, ""},
> +	{0, 0, 0, PD_R5_1_BTCM, ""},
>  };
>  
>  /**
> @@ -534,30 +536,6 @@ static int tcm_mem_map(struct rproc *rproc,
>  	/* clear TCMs */
>  	memset_io(va, 0, mem->len);
>  
> -	/*
> -	 * The R5s expect their TCM banks to be at address 0x0 and 0x2000,
> -	 * while on the Linux side they are at 0xffexxxxx.
> -	 *
> -	 * Zero out the high 12 bits of the address. This will give
> -	 * expected values for TCM Banks 0A and 0B (0x0 and 0x20000).
> -	 */
> -	mem->da &= 0x000fffff;
> -
> -	/*
> -	 * TCM Banks 1A and 1B still have to be translated.
> -	 *
> -	 * Below handle these two banks' absolute addresses (0xffe90000 and
> -	 * 0xffeb0000) and convert to the expected relative addresses
> -	 * (0x0 and 0x20000).
> -	 */
> -	if (mem->da == 0x90000 || mem->da == 0xB0000)
> -		mem->da -= 0x90000;
> -
> -	/* if translated TCM bank address is not valid report error */
> -	if (mem->da != 0x0 && mem->da != 0x20000) {
> -		dev_err(&rproc->dev, "invalid TCM address: %x\n", mem->da);
> -		return -EINVAL;
> -	}
>  	return 0;
>  }
>  
> @@ -579,6 +557,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  	u32 pm_domain_id;
>  	size_t bank_size;
>  	char *bank_name;
> +	u32 da;
>  
>  	r5_core = rproc->priv;
>  	dev = r5_core->dev;
> @@ -591,6 +570,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  	 */
>  	for (i = 0; i < num_banks; i++) {
>  		bank_addr = r5_core->tcm_banks[i]->addr;
> +		da = r5_core->tcm_banks[i]->da;
>  		bank_name = r5_core->tcm_banks[i]->bank_name;
>  		bank_size = r5_core->tcm_banks[i]->size;
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> @@ -603,11 +583,11 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  			goto release_tcm_split;
>  		}
>  
> -		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, size=0x%lx",
> -			bank_name, bank_addr, bank_size);
> +		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, da=0x%x, size=0x%lx",
> +			bank_name, bank_addr, da, bank_size);
>  
>  		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> -						 bank_size, bank_addr,
> +						 bank_size, da,
>  						 tcm_mem_map, tcm_mem_unmap,
>  						 bank_name);
>  		if (!rproc_mem) {
> @@ -648,6 +628,7 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
>  	struct device *dev;
>  	u32 pm_domain_id;
>  	char *bank_name;
> +	u32 da;
>  
>  	r5_core = rproc->priv;
>  	dev = r5_core->dev;
> @@ -679,11 +660,12 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
>  			continue;
>  
>  		bank_addr = r5_core->tcm_banks[i]->addr;
> +		da = r5_core->tcm_banks[i]->da;
>  		bank_name = r5_core->tcm_banks[i]->bank_name;
>  
>  		/* Register TCM address range, TCM map and unmap functions */
>  		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> -						 bank_size, bank_addr,
> +						 bank_size, da,
>  						 tcm_mem_map, tcm_mem_unmap,
>  						 bank_name);
>  		if (!rproc_mem) {
> @@ -695,8 +677,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
>  		/* If registration is success, add carveouts */
>  		rproc_add_carveout(rproc, rproc_mem);
>  
> -		dev_dbg(dev, "TCM add carveout lockstep mode %s addr=0x%llx, size=0x%lx",
> -			bank_name, bank_addr, bank_size);
> +		dev_dbg(dev, "TCM carveout lockstep mode %s addr=0x%llx, da=0x%x, size=0x%lx",
> +			bank_name, bank_addr, da, bank_size);
>  	}
>  
>  	return 0;
> 
> base-commit: 1a93ced18d7b81be39beba26b1c168ef21c8d0ad
> -- 
> 2.25.1
> 
