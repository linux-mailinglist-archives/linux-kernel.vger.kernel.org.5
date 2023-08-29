Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96BF78BE22
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjH2GAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjH2F7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:59:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54741A1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:59:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf1935f6c2so26616165ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693288774; x=1693893574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uw7aXMxiE8vTFTPymrMp+MvNaW+lEP6ixS9BnwKSDuM=;
        b=vT5lY24HH66FH/JjN17T6am4JNeOJDWVS4kpVRwOz3KOHDo5CWyoQfNy4PWUYzji/s
         4iaRVwDhxuZ8cjS4Wq/9bP6QLYLSTGR0qp5yZRZpCLBVwswgsJUxOrCbd/hMswZQJruG
         /lonPdI0Vj3xxWRd4jI7fjwgXymxM1PP8e3Ebt2rv2YbF9W/GT5hLcEY6B0vLnSPBf3c
         3IxygHrGdord+J8WHoZkDYx2WWQH0Foj+c1SFkRmA/18r7gd9HCm1V1UAVK9b0aDFT9M
         5+23Q2+oOlKwpBH4UMEdvuPCMGy5T/qDZlFGQ51zUAwb9goSF6uIHw1zEs2D32d+ugwK
         tn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693288774; x=1693893574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uw7aXMxiE8vTFTPymrMp+MvNaW+lEP6ixS9BnwKSDuM=;
        b=IkvQHowjNRclvzANz6N0IKHznJ0GyZCtqy1a6w3gDf7+e0SgIJ1PP1rbyPyqxDnE+D
         Fc6ai4gT0g7eeU9hJxz/SAjT0yIOsdjOsKQUtW4IsR3TERPdwF6hyZXnYiJRfsJlmoup
         XMji86qqTOMnFnoODjepL5VvUF5lb0/WclObeI3IH7jFP1crbjZ7UL751Fi/5Hlyrfbr
         gM23g/Uoe17+CqYoQ3MWWbPAtWahysbjMmMco6TxPdeSWW4X7zWTyS2h1fDvyA/r0k86
         8rv1zCovKzzcwvt5MTAz/L+rbrgAoWn9301NEriU1YVuT0FK+dRWQqmCSxNexVdSpr/f
         cvFg==
X-Gm-Message-State: AOJu0YzJJc6/29hI4gBSo/EpenKt5F08TIULLvzpZonACiSLpFG7BIEu
        LXuEPfiPF6c+OpIWlXcC9cU/AA==
X-Google-Smtp-Source: AGHT+IHZsexYBSOXCaMDIndYB6MxZkA9lTswJOf40JwCBZROwG+VB0VO+dmFeJSWvWhXpOTthlEp9A==
X-Received: by 2002:a17:903:22cc:b0:1bb:fcb9:f85 with SMTP id y12-20020a17090322cc00b001bbfcb90f85mr2331114plg.32.1693288774027;
        Mon, 28 Aug 2023 22:59:34 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id x19-20020a170902821300b001bdd68b3f4bsm8365105pln.295.2023.08.28.22.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 22:59:32 -0700 (PDT)
Date:   Tue, 29 Aug 2023 11:29:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com
Subject: Re: [Patch] cpufreq: tegra194: fix warning due to missing opp_put
Message-ID: <20230829055930.csddryecm72ehz3o@vireshk-i7>
References: <20230828120959.24680-1-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828120959.24680-1-sumitg@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-23, 17:39, Sumit Gupta wrote:
> Fix the warning due to missing dev_pm_opp_put() call and hence
> wrong refcount value. This causes below warning message when
> trying to remove the module.
> 
>  Call trace:
>   dev_pm_opp_put_opp_table+0x154/0x15c
>   dev_pm_opp_remove_table+0x34/0xa0
>   _dev_pm_opp_cpumask_remove_table+0x7c/0xbc
>   dev_pm_opp_of_cpumask_remove_table+0x10/0x18
>   tegra194_cpufreq_exit+0x24/0x34 [tegra194_cpufreq]
>   cpufreq_remove_dev+0xa8/0xf8
>   subsys_interface_unregister+0x90/0xe8
>   cpufreq_unregister_driver+0x54/0x9c
>   tegra194_cpufreq_remove+0x18/0x2c [tegra194_cpufreq]
>   platform_remove+0x24/0x74
>   device_remove+0x48/0x78
>   device_release_driver_internal+0xc8/0x160
>   driver_detach+0x4c/0x90
>   bus_remove_driver+0x68/0xb8
>   driver_unregister+0x2c/0x58
>   platform_driver_unregister+0x10/0x18
>   tegra194_ccplex_driver_exit+0x14/0x1e0 [tegra194_cpufreq]
>   __arm64_sys_delete_module+0x184/0x270
> 
> Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index 88ef5e57ccd0..f63f7a6c2034 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -454,6 +454,8 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,

You need to put the OPP here, even if this fails.

>  		if (ret < 0)
>  			return ret;
>  
> +		dev_pm_opp_put(opp);
> +
>  		freq_table[j].driver_data = pos->driver_data;
>  		freq_table[j].frequency = pos->frequency;
>  		j++;
> -- 
> 2.17.1

-- 
viresh
