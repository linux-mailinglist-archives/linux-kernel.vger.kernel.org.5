Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F057C78240A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjHUGw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjHUGwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:52:55 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFA4AF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:52:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a85c5854deso373280b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692600773; x=1693205573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ve8D51PRNPIO0v8XFqJRtrlKQMMc1izQOOwzjOms4oM=;
        b=HVgK2a04PyDpRfBCjcc//cMVzFPNj8VWQJlHGXckaQe38UawlQwmRbTjbQu51UlR5p
         oTkpoSkmfnyEHehX3ZrBX545FhsRM2vxrHrSsKZKPK5xII4Ep8dkpnkvPt5+8WW3dCDy
         rMbw1OMLUBMJyHGggmu3JDzILHxhYgzkBBAe80Bf+gm6WDsFGowxR4RqfuJvJkRtcs2p
         l1kuBJ+1LQbjz0EPeARLbsgAF3UVfXJJHidizN7GwxXyZqry/FEaScrW1nnh7atq8/pg
         oV2cQhSNsRlmbddFVC0NS+584xYBw5jiXhz3sn0WjPSfQVj7IRUK6JiVoT6YCYitROVD
         ZSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692600773; x=1693205573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve8D51PRNPIO0v8XFqJRtrlKQMMc1izQOOwzjOms4oM=;
        b=R5mg1Pb6nwZUIX9QiqHI1QfGEfTl50jpRhk3EAtmTMgeD8FlppH4ynMRdkYNpE3q+4
         /TylcoZBHd1kqMKKdMLfhPkMWbfw4krHtdUg2CxxmkeMAEIOgSeRuzDl/h2MF0DsNe06
         J+ARNB3EmWkujVTAq/vIU7b1dRe6w9vMlXBHx/tZKj7X1naN39UBfvpY/gazXZtSzscR
         T+1ImVkdvJBL1Ct0+0CMFWckvEnjU2EZVY3J9gPlzrdEQBi8n66lj2aw1of7CWhK8Mlj
         IBW8FY20dMG1q2gS/9RbrvMNc4PN2phOLbXVRbwIgewiup5b59hhz9F1+mkXZKASBmVf
         IAzA==
X-Gm-Message-State: AOJu0YzVKQ62Mmw2cQaLeNxHSAT5mhO60u9c6i3Ph9xJyy1COkhaWFH6
        +iOLRAKRrxMh9zAbRhNYA2PL9bsMiqe8471TXiE=
X-Google-Smtp-Source: AGHT+IHCzbmFF/CCMTXlVU/61Q8U5IED/IrulPQT4R1ZXNHBKizJ+8pmgnMHsjQoT+FflakA4O/aWw==
X-Received: by 2002:a54:4e1b:0:b0:3a8:4392:5b7 with SMTP id a27-20020a544e1b000000b003a8439205b7mr7489784oiy.39.1692600773712;
        Sun, 20 Aug 2023 23:52:53 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id u15-20020a62ed0f000000b006887be16675sm5394897pfh.205.2023.08.20.23.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 23:52:52 -0700 (PDT)
Date:   Mon, 21 Aug 2023 12:22:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: stats: Improve the performance of
 cpufreq_stats_create_table()
Message-ID: <20230821065250.oz7jga5jcveiddlg@vireshk-i7>
References: <20230818095000.937633-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818095000.937633-1-liaochang1@huawei.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-23, 09:50, Liao Chang wrote:
> In the worst case, the freq_table of policy data is not sorted and
> contains duplicate frequencies, this means that it needs to iterate
> through the entire freq_table of policy to ensure each frequency is
> unique in the freq_table of stats data, this has a time complexity of
> O(N^2), where N is the number of frequencies in the freq_table of
> policy.
> 
> However, if the policy.freq_table is already sorted and contains no
> duplicate frequencices, it can reduce the time complexity of creating
> stats.freq_table to O(N), the 'freq_table_sorted' field of policy data
> can be used to indicate whether the policy.freq_table is sorted.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 55c7ffd37d1c..fcb74050711a 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -243,7 +243,8 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  
>  	/* Find valid-unique entries */
>  	cpufreq_for_each_valid_entry(pos, policy->freq_table)
> -		if (freq_table_get_index(stats, pos->frequency) == -1)
> +		if ((policy->freq_table_sorted != CPUFREQ_TABLE_UNSORTED) ||
> +		    (freq_table_get_index(stats, pos->frequency) == -1))
>  			stats->freq_table[i++] = pos->frequency;
>  
>  	stats->state_num = i;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
