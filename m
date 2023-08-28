Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0FF78A622
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjH1G4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjH1G4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:56:34 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F5113
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 23:56:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68bec3a1c0fso1920972b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 23:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693205788; x=1693810588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhN4mtNsUWFDMN8D+eETjmwG67/vLS/iFwqcwOo96T4=;
        b=KjwAjrAfreohxpiBzykExsMcO8KiPFM4rKqJuxLVzS8wumN48HLDdtA2XR7feEB3wH
         Af1ttwaWYFvRGyj3kxl4uVSSJFVHwV9NEa/ASu4R7H5Bh0RnvA1c1EfiTKHLkN4FdEMn
         zuLLcTPtHonyYW/zEX8NaWbS/EtdizensX9u8OLzDtF/biLFE9FRLMz/YDUm4JMMirqh
         /wYXjZEMfVkL2bEWktyjlUZpkRzTzz+08IgNcKFQOHts5kAzdNT2RQtd/orYJw4XbHZp
         pjdQ9mtVyIk4WWkkJoIW2EQG3l+oFgk0CGuwlhJDUKT0TIuGDgCPBEQAnMrQOomg7dt6
         7jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693205788; x=1693810588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhN4mtNsUWFDMN8D+eETjmwG67/vLS/iFwqcwOo96T4=;
        b=a8bJ2EyyVYmyvbn+fnAFhfqIMgLcxbwhb5quCJC2h/KGnZRKHAl6TQhyXOGSyKDV6G
         D5YdUhwKnXzEIyOlo1jEx0nUPLpLXky5IjBQq6sM5nvMuJN7mL3zYHEF3dcsG9ZgSUAr
         D4z8erA5L/pTn2P0QPj8jH8uQtAZ/qfDMGOP+qJHZDg1nK117b/EiO0JHFuTj5NjXGbe
         VNSbVRe/0YKF8ccxzGJmF2bhw0CmGPpBEpUY/gQvjDNWmaBNA43YOi/sFpTti2VJUhxx
         AQFmGKIYE9AH2gItReE2Um2SasBEtAlwK2f0twm9kvQdrV8n3Vciig/9eis50MwI754W
         5Frw==
X-Gm-Message-State: AOJu0YyQyzUKkXJWc3OgOtK8H5BEWDoriyNrj1Ac87EJsKF5NTYJAeva
        4HY5yC/wetdCkjUSv3b9K2W0PA==
X-Google-Smtp-Source: AGHT+IFrQMoO7tYhslhoEddXU+QHLNpKSr4s4IaqnyDG6BcPpI/1VZ1uhOkjU0WPepTJsPCZSieqNQ==
X-Received: by 2002:a05:6a20:3ca6:b0:14c:e4f8:e676 with SMTP id b38-20020a056a203ca600b0014ce4f8e676mr3608067pzj.23.1693205788480;
        Sun, 27 Aug 2023 23:56:28 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001b9e9f191f2sm6472844plb.15.2023.08.27.23.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:56:27 -0700 (PDT)
Date:   Mon, 28 Aug 2023 12:26:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: governor: Free dbs_data directly when
 gov->init() fails
Message-ID: <20230828065625.ufp66goznd72rcyh@vireshk-i7>
References: <20230826012415.1126955-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826012415.1126955-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-08-23, 01:24, Liao Chang wrote:
> Due to the kobject embedded in the dbs_data doest not has a release()
> method yet, it needs to use kfree() to free dbs_data directly when
> governor fails to allocate the tunner field of dbs_data.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 85da677c43d6..6e1ac864e87e 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -438,8 +438,10 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>  	gov_attr_set_init(&dbs_data->attr_set, &policy_dbs->list);
>  
>  	ret = gov->init(dbs_data);
> -	if (ret)
> +	if (ret) {
> +		kfree(dbs_data);
>  		goto free_policy_dbs_info;
> +	}

What about this instead ?

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 85da677c43d6..af44ee6a6430 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -439,7 +439,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)

        ret = gov->init(dbs_data);
        if (ret)
-               goto free_policy_dbs_info;
+               goto free_dbs_data;

        /*
         * The sampling interval should not be less than the transition latency
@@ -474,6 +474,8 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
        if (!have_governor_per_policy())
                gov->gdbs_data = NULL;
        gov->exit(dbs_data);
+
+free_dbs_data:
        kfree(dbs_data);

 free_policy_dbs_info:

-- 
viresh
