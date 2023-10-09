Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CF37BD564
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345357AbjJIIlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbjJIIli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:41:38 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24E7A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:41:36 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-352a27ab1aeso16498895ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696840896; x=1697445696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMLtu1C6zjO/Ty2dcI4XWJq4s0FcrkN8Rrwmwi6e4Xc=;
        b=VXusormLL5DFHN28qoq5m7V1nT6XY1skQzqoa24adT4+wmALWZEvVuVV042Q6d0/e+
         XgvnR/CdZExdfDTsnSBkUAZewMzpp7u8vYjk8ihZI0rzOeJwH6BCkddIPAVVYRstk9hC
         BdO3tD3kCSc9Q3EKyKLH1bDtr+KzaJewST2XS8AnPsA2GE7XvTDUjjC02tMBkY/BN4Rw
         eU/SabgDjvbk6ldvTQEszXTJIhDo/tLVX2UcEVQXr1N2mWGyqe+qijXuxSMjv6QrauVH
         uAbAl05DZGNvvvmuflkLH7EsK0wYx+7CTdVlMsdVnggtiKG5n80wxDLB6/G8UQPC956q
         J/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696840896; x=1697445696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMLtu1C6zjO/Ty2dcI4XWJq4s0FcrkN8Rrwmwi6e4Xc=;
        b=lS+QDzcphCShVfkMNwFDoW+1O6M/pec8iZD/91PEGwK8vXcjwLgvgrc45W1vV/e0jU
         dQXwcD6oeCamOe6Bf9uCWaEe1JXE8IK6Cm/zXANllvmiqydwDCWCWQes9lj5uq4KPZXV
         +M4mBGJJqA/1p67GJvyHHGxqxcCNOyqb2Uk3poOPfkEy0iSpvEQzh4QTXLdrR5vKzU5F
         qR6MlB1hA6UWIhfPaIN3JmX0+FhUPIZ9FnH+SKKr1DDDkGs+TK63LVWKlu+50C8rY4dN
         4d7eWrmlRtvnLM0eteoSEjB2JXOLiNSK++aPMBHwEcUMsvBIJBcWWAIbdLXMFbCbO1Fi
         cJZQ==
X-Gm-Message-State: AOJu0Yxa9XnoNXreKFGl+UHuKD1IQz36h9X9a7U9zchfu7JxtSDz+nMU
        vvCj6swTOE9qXzmJQgd9Z3uyIg==
X-Google-Smtp-Source: AGHT+IGT2X4bu5EsWCmNlcvJx5lx3Q2YFIKbXBKPt6Waom4C9CkGcFy6kSV5VQaD7OivliE/Fr7I7w==
X-Received: by 2002:a05:6e02:1145:b0:352:67e6:878d with SMTP id o5-20020a056e02114500b0035267e6878dmr12461472ill.31.1696840896317;
        Mon, 09 Oct 2023 01:41:36 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id q30-20020a638c5e000000b0058a9621f583sm4806101pgn.44.2023.10.09.01.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 01:41:35 -0700 (PDT)
Date:   Mon, 9 Oct 2023 14:11:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch] cpufreq: tegra194: remove redundant AND with
 cpu_online_mask
Message-ID: <20231009084133.tvtqjhr4qac3tosm@vireshk-i7>
References: <20231009082423.16714-1-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009082423.16714-1-sumitg@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-10-23, 13:54, Sumit Gupta wrote:
> Remove redundant 'AND' with cpu_online_mask as the policy->cpus always
> contains only the currently online CPUs.
> 
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Link: https://lore.kernel.org/lkml/20231003050019.a6mcchw2o2z2wkrh@vireshk-i7/
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index 386aed3637b4..607e699b3d84 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -135,7 +135,7 @@ static void tegra234_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
>  	u32 cpu, cpuid, clusterid;
>  	u64 mpidr_id;
>  
> -	for_each_cpu_and(cpu, policy->cpus, cpu_online_mask) {
> +	for_each_cpu(cpu, policy->cpus) {
>  		data->soc->ops->get_cpu_cluster_id(cpu, &cpuid, &clusterid);
>  
>  		/* use physical id to get address of per core frequency register */

Applied. Thanks.

-- 
viresh
