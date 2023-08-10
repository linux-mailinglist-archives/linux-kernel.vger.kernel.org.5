Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996FC776F96
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjHJFbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHJFbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:31:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CFA10C0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 22:31:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6877eb31261so384280b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691645490; x=1692250290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5ljNanWHdg+wPtc/Kk05lnhsdHx9EY+uf3rbi8Jyl0=;
        b=I27rOOPr2QKMxXmLmFoN3O2gZmbSvC3MTJNLfcaN3hBLpGcR7pFrfX9LOdQYB0v9UX
         FS8XX3MUSQ5L0gIICKO8NssntbaRGqlbEqzwuKa+pLKtWuk06X2yhmtS7VTVlYfAnI+v
         WKxiNAcp+vPFU60KAunF3U/BZyA32W/Ac8SeviyR9THNiFH71X16XZrWx6cievakG9Z7
         qeKr3mJrkHEkcCc8UCFXIxrAuloRn3IsRd7EGOfEwAuiwEwnkCtEqAUiTDdX1epyJN4u
         NsVG9PR6QKeaAkBlE7WjbLaffCm+7NAoUI1/55O8nPeAMcM2OgaDml3Ca2EP+OQEWLYi
         iecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691645490; x=1692250290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5ljNanWHdg+wPtc/Kk05lnhsdHx9EY+uf3rbi8Jyl0=;
        b=FVVynF8OzcqP0jZeqW38dSYOytpIKwHHzBKwptZJ/KDHnduqIeBxY7vQiDmJEUReKR
         cWHzpks/CERb52E34NN3O7Qxz8uMdx0yhTizXndoKH/W9rk6Q8BHQ/JTFlOwoUHs8wZf
         EyEUteB/JSrlaNkvl50WTDN3sFoYRl+3hgwkRt3CRCiv9y8UI0J9ubJmiV7kkD4qmOTu
         B86QvobsOc//0nk/8tqyOt4zHDDso34OVnzOKnwuHVArKPhsguHYHv21CRGSe6rN/weL
         jSEjxDgmGcBXsdqSTO3RTSWmQufebsgODf02pKLNhdyABwOf9eK/tczI2TFugPJHXgyq
         6jBQ==
X-Gm-Message-State: AOJu0YwCnIhsj3sd5PoK9IrPz4YPVGFuyP8kOGI6W/ar8FBWv5x7MQVv
        6igm8fO1ybXgHp1aDWjfeYW+gA==
X-Google-Smtp-Source: AGHT+IF8M6ULj5qBpYswknmIk/UC9uqMvQ52qHszDjMGFcxfrplMUEDi6y9znOX9SLT1wRvxKfXt4Q==
X-Received: by 2002:a05:6a00:884:b0:687:5415:7282 with SMTP id q4-20020a056a00088400b0068754157282mr1456448pfj.23.1691645490418;
        Wed, 09 Aug 2023 22:31:30 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id p11-20020a637f4b000000b005501b24b1c9sm581374pgn.62.2023.08.09.22.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 22:31:29 -0700 (PDT)
Date:   Thu, 10 Aug 2023 11:01:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com
Subject: Re: [Patch] cpufreq: tegra194: remove opp table in exit hook
Message-ID: <20230810053127.y4wmumlggkro7r66@vireshk-i7>
References: <20230809153455.29056-1-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809153455.29056-1-sumitg@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-08-23, 21:04, Sumit Gupta wrote:
> Add exit hook and remove OPP table when all the CPU's in a policy
> are offlined. It will fix the below error messages when onlining
> first CPU from a policy whose all CPU's were previously offlined.
> 
>  debugfs: File 'cpu5' in directory 'opp' already present!
>  debugfs: File 'cpu6' in directory 'opp' already present!
>  debugfs: File 'cpu7' in directory 'opp' already present!
> 
> Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index c90b30469165..66a9c23544db 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -454,6 +454,8 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
>  		if (ret < 0)
>  			return ret;
>  
> +		dev_pm_opp_put(opp);
> +
>  		freq_table[j].driver_data = pos->driver_data;
>  		freq_table[j].frequency = pos->frequency;
>  		j++;
> @@ -508,6 +510,16 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> +static int tegra194_cpufreq_exit(struct cpufreq_policy *policy)
> +{
> +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> +
> +	dev_pm_opp_remove_all_dynamic(cpu_dev);
> +	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
> +
> +	return 0;
> +}
> +
>  static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
>  				       unsigned int index)
>  {
> @@ -535,6 +547,7 @@ static struct cpufreq_driver tegra194_cpufreq_driver = {
>  	.target_index = tegra194_cpufreq_set_target,
>  	.get = tegra194_get_speed,
>  	.init = tegra194_cpufreq_init,
> +	.exit = tegra194_cpufreq_exit,
>  	.attr = cpufreq_generic_attr,
>  };

If it is only about hotplugging of the CPUs, then you can also do this I guess.

commit 263abfe74b5f ("cpufreq: dt: Implement online/offline() callbacks")

But since your driver is capable of being built as a module, I suggest you try
to build it as one and insert remove it multiple times. It must cause you some
trouble as you don't implement an .exit() before this patch.

Eventually, I think you need to do both, what this patch and 263abfe74b5f do.
Just that the reasons need to be correct for both the changes.

-- 
viresh
