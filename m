Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94DF77F25D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349059AbjHQIoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349063AbjHQIoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:44:02 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18001BE7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:44:01 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso4449759a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692261841; x=1692866641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fR5pG2U0zFVAXgwh49Fb4a1m5XkUhPxLBUBEsrZbP70=;
        b=E5e/gAx7h9EuB5jHU91xKT217LmYKJt1fHHKqi8Ja6aAjs+rpyTX4jwk36pZL3155x
         FX4II9kCVzDTDci+URUTmoV8fDv/IDwlt3B2fGDAST4ckNEjhCU7Ksgdfls11OMLJ/X2
         l307nVljP7KK/RA59cYRys2bsqSeOkYzkAyBrxccQsTRa1pxH42e1R3s5rmF3niB4H2V
         ScA77+uytHBl7AHZDXqyWJnt14lUGU858PbzdZyZQf9JIkH5CYi+FNALP/AFPG4hsJgI
         8r+WNQmmcgAgpG6VU60S31W9d9rC8b9jUldOcB9zCSM06PnQ7wVXkpyGsOORJg8CJuQp
         R96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692261841; x=1692866641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fR5pG2U0zFVAXgwh49Fb4a1m5XkUhPxLBUBEsrZbP70=;
        b=gAq0LKJbN+VdsIe13DDVH6LdK8SR8er7VTU0JZ23C4Kis9HSV99h2LGgx0jJZoRLdV
         oMZp3HVL+XV354BEzqugsihSoF128r5EcgCW6++SBehqG8mje/PHxh82/BJrWReQVaIK
         WmaTb5Pq2yVIREjBxl7bFnfZtqy6c0Zp/SLzzmtkU3qAm9dONSc2MDUT+uyC+lhdnemw
         zkIQUefGhzB9gDzctKNLR01tPKozsfuLACwx/jY7oQOr+FCm/jKEJbjL3JYZ5B/+KcmC
         TpLtJJKYtpJ3IBB/h2NVPUPN2gRTlIuxpBqH88hpyAfXn5Sne7AwF6ULRepucawxz5px
         dVog==
X-Gm-Message-State: AOJu0YyeOO3LGCMfCr+14M/Mjv37oTmuGbp5Pyc2w4NldP2rbu8ePySx
        XrFJxeZaymrxgsPqsq7Mew3b7g==
X-Google-Smtp-Source: AGHT+IGh/haHyCY6XRyeot4wtRP9PEqm3NELI02P19jxlZ5Ji+qTmnbf6VMZvmPdHiVPT/uUeA0CBQ==
X-Received: by 2002:a05:6a21:819b:b0:135:4527:efcc with SMTP id pd27-20020a056a21819b00b001354527efccmr4303456pzb.46.1692261841234;
        Thu, 17 Aug 2023 01:44:01 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id j17-20020a62b611000000b0067777e960d9sm12339594pff.155.2023.08.17.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 01:44:00 -0700 (PDT)
Date:   Thu, 17 Aug 2023 14:13:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: Prefer to print cpuid in MIN/MAX QoS
 register error message
Message-ID: <20230817084358.7gg4lsudfpv2ziso@vireshk-i7>
References: <20230815014002.4132226-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815014002.4132226-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-08-23, 09:40, Liao Chang wrote:
> When a cpufreq_policy is allocated, the cpus, related_cpus and real_cpus
> of policy are still unset. Therefore, it is preferable to print the
> passed 'cpu' parameter instead of a empty 'cpus' cpumask in error
> message when registering MIN/MAX QoS notifier fails.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 50bbc969ffe5..a757f90aa9d6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1234,16 +1234,16 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  	ret = freq_qos_add_notifier(&policy->constraints, FREQ_QOS_MIN,
>  				    &policy->nb_min);
>  	if (ret) {
> -		dev_err(dev, "Failed to register MIN QoS notifier: %d (%*pbl)\n",
> -			ret, cpumask_pr_args(policy->cpus));
> +		dev_err(dev, "Failed to register MIN QoS notifier: %d (CPU%u)\n",
> +			ret, cpu);
>  		goto err_kobj_remove;
>  	}
>  
>  	ret = freq_qos_add_notifier(&policy->constraints, FREQ_QOS_MAX,
>  				    &policy->nb_max);
>  	if (ret) {
> -		dev_err(dev, "Failed to register MAX QoS notifier: %d (%*pbl)\n",
> -			ret, cpumask_pr_args(policy->cpus));
> +		dev_err(dev, "Failed to register MAX QoS notifier: %d (CPU%u)\n",
> +			ret, cpu);
>  		goto err_min_qos_notifier;
>  	}

Applied both the patches. Thanks.

-- 
viresh
