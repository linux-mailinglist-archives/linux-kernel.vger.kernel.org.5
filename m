Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082CD78A590
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjH1GOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjH1GO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:14:29 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2401C6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 23:14:26 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a88c422e23so1661780b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 23:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693203266; x=1693808066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=386ok7shWOJlruYDJGJwfZYhWifBb/vBMYMt3Zuo+Ow=;
        b=wrBMPPHmYEigi+MvjNy+h3s8aCuog+9Wqj0hUDLhdpgJgqLqe9BN8Umna3Qq024uxT
         joVL0t0pEAiLP0GNba/YQe8ngpjHZpFjgn5zOKJQ5O01D2LC+lP9oZTOANAujE9bII4J
         LKHtaT+WPpr339YFT4Yu01NGVt06GhdZvJh773lfTJchICfjG9D2z3WNicQXysch9pco
         +ZKawK4uywUSmNeG5gy2sYxkNKXrNPTaoVCom4tlNMTbypY5WdPJLYQdRD8hRd6h0gWd
         s1KLxwpyH64aqYHuJrDAx1iuB33Bb2hVNavMWsnuWp9tq+aXEYKI+9+CK2VBTSBCl9Ah
         abww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693203266; x=1693808066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=386ok7shWOJlruYDJGJwfZYhWifBb/vBMYMt3Zuo+Ow=;
        b=PqysmRYlD3S4rEoopZnmz5/rH5L86qXHoNU3YFqWFLjTtnSTW2vy5Rjuq7xnKMGgXB
         nfJwYcgO1D6i+Bqf6PkkIi6bo73QszwjiU52RxsKp3tZC/HTKdlvORhwjzMGrzSISPLF
         /NNDTTbVnE0jb31slSUKzXi1djC5b7MDMwDMD9rmih48kysvjR5YVk3qQzOv9N5U7b9O
         rNwrLVR+YFbEvXfTbpVZG5ov3sFepBG3lfYjkWlKLdJQcF2r0l8A6yu3cJ+t82N5qYHz
         RfiGstybNaaUp69Vixi5vcFCLASoyGxNAHXhfFt2RP8LuO6ROtpiB03G1BLJ2SAI8hk4
         G8tA==
X-Gm-Message-State: AOJu0Ywe7LKp9Wi/3LDz2bj7g/Q8I3KWwOhYfuF1nUWgY2oRRTijnLX/
        8AzWuNqStHJylh3TaAm6EkSaVA==
X-Google-Smtp-Source: AGHT+IHZlduIK8tmAqKEeieK3IxWR14s2o9pmF6xMaL4d6UcGN8N3gP3vOap7FkxjhBcYFk20cGZPw==
X-Received: by 2002:a05:6808:23c4:b0:3a4:8a41:c69c with SMTP id bq4-20020a05680823c400b003a48a41c69cmr9760903oib.13.1693203266006;
        Sun, 27 Aug 2023 23:14:26 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id l6-20020a62be06000000b00688214cff65sm5785323pff.44.2023.08.27.23.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:14:25 -0700 (PDT)
Date:   Mon, 28 Aug 2023 11:44:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com
Subject: Re: [Patch] cpufreq: tegra194: add online/offline hooks
Message-ID: <20230828061423.6u3xd4f7vuizyqls@vireshk-i7>
References: <20230825111920.8257-1-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825111920.8257-1-sumitg@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-08-23, 16:49, Sumit Gupta wrote:
> Implement the light-weight tear down and bring up helpers to reduce the
> amount of work to do on CPU offline/online operation.
> This change helps to make the hotplugging paths much faster.
> 
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> Link: https://lore.kernel.org/lkml/20230816033402.3abmugb5goypvllm@vireshk-i7/
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index 66a9c23544db..09582696b83d 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -510,6 +510,21 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> +static int tegra194_cpufreq_online(struct cpufreq_policy *policy)
> +{
> +	/* We did light-weight tear down earlier, nothing to do here */
> +	return 0;
> +}
> +
> +static int tegra194_cpufreq_offline(struct cpufreq_policy *policy)
> +{
> +	/*
> +	 * Preserve policy->driver_data and don't free resources on light-weight
> +	 * tear down.
> +	 */
> +	return 0;
> +}
> +
>  static int tegra194_cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct device *cpu_dev = get_cpu_device(policy->cpu);
> @@ -548,6 +563,8 @@ static struct cpufreq_driver tegra194_cpufreq_driver = {
>  	.get = tegra194_get_speed,
>  	.init = tegra194_cpufreq_init,
>  	.exit = tegra194_cpufreq_exit,
> +	.online = tegra194_cpufreq_online,
> +	.offline = tegra194_cpufreq_offline,
>  	.attr = cpufreq_generic_attr,
>  };

Applied. Thanks.

-- 
viresh
