Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52D478A588
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjH1GLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjH1GLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:11:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BAA127
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 23:11:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68c3ec0578bso675927b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 23:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693203078; x=1693807878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIYwhouQMA9l5NGpKySDWUf3dxmgZ01VIeueyPAqR8w=;
        b=PezwnI7NG1oL1O27AcGuldbKp8UuttEC1M4HMxyj/px07uuHLrfoKqg2sY0cVvRHBV
         YGIHzfeXPqPAYxzgZFplc7RQuYKU/6RDy+e3J66sArctrwV5K63KZ6BxkMSub+L3ILUJ
         kUjZ37S4llFfTVHsuZ0yRUx4uNfSsfDHUbFvsv3t2JZOhfRN8Ed7mJSMnOKPqb8q6HF8
         skngThJY2OIRtGBRIj4LcJmVr1VXg2QaF4EFxnvW7jjrUYU60qz24EzSdsn9863ojaaA
         gYmbTqvPy9NPRiLYz+xkLNSQbta4MIxia7FAak9LK+sxJM8/W90854dixvk+KcXMi99E
         4vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693203078; x=1693807878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIYwhouQMA9l5NGpKySDWUf3dxmgZ01VIeueyPAqR8w=;
        b=VFrbXqZM3NblKNYhUnB5eKxEi9buIjFDy1vrJY/PB05MVuU5k7UI5XK00aPgsCquOE
         6wXc5HPmkQi8B394knKxYHUVj67y5TW5/pI+jt8NyZP0pO7ImnEEMt+30a8d9FnxunOL
         Qnxz96Ya6JghNuPL8MdaZBXIRUeqzVdpFtrmz2IH3P5TgainyCbrcJjNq1m3ObjLX3z5
         n9CpGXrIWlhkI2UriJY2PD0EwE4/FZ5Jj19IbGRAhPwWSJkIp00IDir38sjTESEHny7d
         7Acve7bqKS+SRInwt5xrK0/zCTtM51ZtQKD0Kuw7mJJYNklZUvFuZYdj+O5o/fB3laV2
         hmng==
X-Gm-Message-State: AOJu0YxyjKUJHMvtEVp9WvCVrrBAuivIZSG41ickFJm+57Wj0LP8qfzV
        /viBJHOuD5QVIq2iYkHoFkRG5w==
X-Google-Smtp-Source: AGHT+IEyVv32vhFFpZcqLVmK0dwHdxb+ZLMbz8+Oc0x8XGO0RVaHmSvwijjI/RG0UopHH2iRrSZUNw==
X-Received: by 2002:a05:6a00:1387:b0:68c:10c:1c52 with SMTP id t7-20020a056a00138700b0068c010c1c52mr7714953pfg.9.1693203078602;
        Sun, 27 Aug 2023 23:11:18 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id g4-20020aa78184000000b0068703879d3esm5750683pfi.113.2023.08.27.23.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:11:18 -0700 (PDT)
Date:   Mon, 28 Aug 2023 11:41:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com
Subject: Re: [Patch v2] cpufreq: tegra194: remove opp table in exit hook
Message-ID: <20230828061115.vsepgtexyv3hvffu@vireshk-i7>
References: <20230825111617.8069-1-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825111617.8069-1-sumitg@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-23, 16:46, Sumit Gupta wrote:
> Add exit hook and remove OPP table when the device gets unregistered.
> This will fix the error messages when the CPU FREQ driver module is
> removed and then re-inserted. It also fixes these messages while
> onlining the first CPU from a policy whose all CPU's were previously
> offlined.
> 
>  debugfs: File 'cpu5' in directory 'opp' already present!
>  debugfs: File 'cpu6' in directory 'opp' already present!
>  debugfs: File 'cpu7' in directory 'opp' already present!
> 
> Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
> 
> v1[1] -> v2:
> - updated commit description.
> 
> [1] https://lore.kernel.org/lkml/20230809153455.29056-1-sumitg@nvidia.com/
> 
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

Missed this earlier, can you please do this in a separate patch please
?

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
>  
> -- 
> 2.17.1

-- 
viresh
