Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C59F78A63E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjH1HCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjH1HCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:02:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629441A3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:02:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-26814e27a9eso1396669a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693206130; x=1693810930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xsZIF9+60TMVxXmhZKS5XPgvvX8LG2+xbCqzfDRe3+E=;
        b=FqYIeGOwn3SSNvjtNnm1rhX0BvyvuHNbPW83FPPLziQLaeyhHm6UoZCkmpO9sXvm4z
         XKnnyAbqrS36WOiMtgpXwXUC49y9p4fvVVeU1B+sGkLfUZJi39uF3yWD9ydOHkbyvm6s
         yeYAcvMspsrfX12NGfzO/vu4Efm2UGLBVzi/d8wVplDD1Gofc6V3Vd+KTyu3wzgvOUkS
         7LFhTZKmFMHB0kGWfJYKGvX1IVPW1GvoACFkyWXYxL8z1aRnNgKN4ANLppptEIzyPDvE
         Arv6ITG95xNT/5WzS5B4tdK59H6bazh7L+IZvb7hs+1atLy2UdLvF8Lc7HK2d2EjnmW3
         ZuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693206130; x=1693810930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsZIF9+60TMVxXmhZKS5XPgvvX8LG2+xbCqzfDRe3+E=;
        b=SVkw9WwV+DUvpNmkzRrHd724yx3stNwzwx5o941ut+rGF98UoNakAzjdYmybE+sZOp
         Wx/6CNx+BhJgXmaQZgiIlwjMyFjudAYGBKOPaIGwYmWjKfYLq3IhIBV9jWyCFrCjgXFG
         npJxdF5Y4qbVEQtydNrzJ3DiisNzdaJDf5CHZxHocdyguf5+m3zEg3lRwMm6Wi+4UW/5
         SHi5Qg1Fs2vdPidu5klzRp65/YQtYov1sAgOwA6X0VuKtUbVhlznBMBLykqmmGavfllR
         C066fP0OkHDwvublaQ7ODiJuLnIOk7GQwVBrGd3W6IxMFPiSp/Nxjj8jiKPxPYB6Ip90
         qgYg==
X-Gm-Message-State: AOJu0YwdGYkvOzxOGuNmzOnQeHEEiONdkyyHxtMGSpV+46nodi4fZFuq
        kId7kZOsUCTX7ffYStaEYstBoA==
X-Google-Smtp-Source: AGHT+IGJc2k99Qa1Tvg70j17m+GRIFLpV6j0x/Z3aoEHd7i/SC/vVcaGVxqWXJqQLw4iLTJSHQTq+g==
X-Received: by 2002:a17:90b:ecd:b0:26c:f871:e6b1 with SMTP id gz13-20020a17090b0ecd00b0026cf871e6b1mr17355572pjb.22.1693206129440;
        Mon, 28 Aug 2023 00:02:09 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id gw15-20020a17090b0a4f00b0026f90d7947csm6277659pjb.34.2023.08.28.00.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 00:02:08 -0700 (PDT)
Date:   Mon, 28 Aug 2023 12:32:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: pcc: Fix the potentinal scheduling delays in
 target_index()
Message-ID: <20230828070206.dc44mhe4qztg52kc@vireshk-i7>
References: <20230826095743.1138495-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826095743.1138495-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-08-23, 09:57, Liao Chang wrote:
> pcc_cpufreq_target():
> 	cpufreq_freq_transition_begin();
> 	spin_lock(&pcc_lock);
> 	[critical section]
> 	cpufreq_freq_transition_end();
> 	spin_unlock(&pcc_lock);
> 
> Above code has a performance issue, consider that Task0 executes
> 'cpufreq_freq_transition_end()' to wake Task1 and preempted imediatedly
> without releasing 'pcc_lock', then Task1 needs to wait for Task0 to
> release 'pcc_lock'. In the worst case, this locking order can result in
> Task1 wasting two scheduling rounds before it can enter the critical
> section.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/pcc-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index 73efbcf5513b..9d732a00e2a5 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -232,8 +232,8 @@ static int pcc_cpufreq_target(struct cpufreq_policy *policy,
>  	status = ioread16(&pcch_hdr->status);
>  	iowrite16(0, &pcch_hdr->status);
>  
> -	cpufreq_freq_transition_end(policy, &freqs, status != CMD_COMPLETE);
>  	spin_unlock(&pcc_lock);
> +	cpufreq_freq_transition_end(policy, &freqs, status != CMD_COMPLETE);
>  
>  	if (status != CMD_COMPLETE) {
>  		pr_debug("target: FAILED for cpu %d, with status: 0x%x\n",

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
