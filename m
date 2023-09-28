Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883B07B1497
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjI1HSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjI1HSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:18:16 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B5497
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:18:13 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c0b3cea424so7155594a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695885492; x=1696490292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLRpGiit+sJwzR8qIWWGXU438uIPMVyxLn/z2JLLlVw=;
        b=DBFfBfrCadXtpIJmqLMNuTKWzLVjhYU3PGAxOThtE5M8MXRbSmzLpavlNYk8kPq5VJ
         yqqbAxe3EtINuQN4q/ad+9dEUGzADwx0j20wWRhPeDJViCGVcPYH5OxIf8fBbm/FhFUA
         ay5rEMT0xuUQMqVly/wzJIwGogV2eF4xy064Ng6uRteQa6vYInMPIGAA6OKl79G4iyVf
         +JGaFkCROUPyVFa6Og3pXo9lydBSFYBfZfx9bbhcJw8rCGt3aRTvw/SHjptxEKaNWMd4
         YAseNXm/2tUGvhEazUWMq3Dsud8XEm0792op+kyAVx1azSMVrO27Qju9XpldwjX3ZqFA
         sjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695885492; x=1696490292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLRpGiit+sJwzR8qIWWGXU438uIPMVyxLn/z2JLLlVw=;
        b=L/CbPv/jwQm/lbIXI1A1fS382lzPYT17uxafe6cPxL0vYL3paIcHlKMLLo02Whj8kR
         wpdTmoufQzvXkMfE5g8yTdfACh70k4X3JYr/qRbMs3uaVGSEEHK1a9wEDANdzSKaRh9N
         h3VAvuF5foHV757ot9LYjE7WUyBZmUDs6pyziWH3Fcl5eGBbJoIqO6sEcRPL2uZMn7uR
         /qAfXh4RcMzC0Ic5JlqnqeTNOyLfIlImvI9jEIuj18Ii3Vn7B7VP63IOfeCqnZUzMvEo
         FGi5szwDPA1Pj5H2EH/aDOXzmaoPQmNSn3P99U9XZDTqI5y3PGugCfjjkKSrFsQZvl5p
         BWhw==
X-Gm-Message-State: AOJu0YypgxGibEMU/ACvrySkrbIRk44MlcvEJilUNZEOESD0U1pMHBSF
        8k/MImJE6jGKlO0fiuSxKlcAog==
X-Google-Smtp-Source: AGHT+IGWIP72/g0OKh8wEA7aVc8k8yYTJn4/XYg19kDlzIfKVmxB+J3mb/+BWVd7u1O0+mKn4jbvxw==
X-Received: by 2002:a05:6830:1da1:b0:6b2:91c9:8e1e with SMTP id z1-20020a0568301da100b006b291c98e1emr481187oti.2.1695885492528;
        Thu, 28 Sep 2023 00:18:12 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id u10-20020aa7848a000000b0069343e474bcsm1221361pfn.104.2023.09.28.00.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 00:18:12 -0700 (PDT)
Date:   Thu, 28 Sep 2023 12:48:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        vschneid@redhat.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Rebuild sched-domains when removing cpufreq
 driver
Message-ID: <20230928071810.hkdmuoaasrv4b2oq@vireshk-i7>
References: <20230918112937.493352-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918112937.493352-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-09-23, 13:29, Pierre Gondois wrote:
> The Energy Aware Scheduler (EAS) relies on the schedutil governor.
> When moving to/from the schedutil governor, sched domains must be
> rebuilt to allow re-evaluating the enablement conditions of EAS.
> This is done through sched_cpufreq_governor_change().
> 
> Having a cpufreq governor assumes having a cpufreq driver running.
> Inserting/removing a cpufreq driver should trigger a re-evaluation
> of EAS enablement conditions, avoiding to see EAS enabled when
> removing a running cpufreq driver.
> 
> Add a sched_cpufreq_governor_change() call in cpufreq driver removal
> path.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 60ed89000e82..0a4979c34fd1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1673,6 +1673,8 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
>  		cpufreq_driver->exit(policy);
>  		policy->freq_table = NULL;
>  	}
> +
> +	sched_cpufreq_governor_change(policy, policy->governor);

This is called from many paths. Consider using cpufreq_remove_dev() instead,
before the policy is freed.

>  }
>  
>  static int cpufreq_offline(unsigned int cpu)
> -- 
> 2.25.1

-- 
viresh
