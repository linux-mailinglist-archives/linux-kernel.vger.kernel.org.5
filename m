Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C307978A9FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjH1KSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjH1KRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:17:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB7519F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:17:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a56401b9aso2115910b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693217844; x=1693822644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eZsxRxv+CQTRUY7A/T7Jkd4dX0Ikc5XaKyAkP131uo=;
        b=To/JKiCa2vTswPz+vcuEe9l1osMwbns2sF0xYnhfBBoe0lG5Z7w4ekpCaEmHlP/0Je
         Iej4LW0sbaMP5RkUoW3mqytTouTf6mYvAAkMya4XQoqtZ7+LOH3Yv0OSIMt4lIdfJthY
         EOBE1q69DG/phunf5iFI7y5aqs20Qc7M0YMsE/qEIdxaZxCZEa1V3YnXDHY6gsN2xqXl
         yCorBOZ9MNrNWL71cv4UFotVAWaD7GcCdJ+387W6Uf4Br6fKgLKoGZH+wQm8utatzx+n
         ZR/2s28mBVN6vJtLVnCtaXINLPwAxSZuwsyR9LbyrclQtH6eXb4W3oIPxrq+khYZ+Wxt
         7YnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693217844; x=1693822644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eZsxRxv+CQTRUY7A/T7Jkd4dX0Ikc5XaKyAkP131uo=;
        b=a7+AN9ZavRqIzpsTSukSeuVOplxyxO1+YZQxQz84qRg+jOGtQyO6sNILznXpYAtxCi
         6YByXqqF9RKa7T8imUA+slfgExjj7woJBdZybkxXg6TFXpVyYr0BGnoYreYXk3UqJH/+
         Vj5SWy5U+EnRDgrsQS+Xs8jzz4w2QPbyimhn4TaA4CzWVPdjuyfpmPUAErHkgY6bdbjA
         3JEbcGVWJO8ACdC2+QIJME0O2RMFAx0XuAWJRMY2WOQwZfuxV/W/mWf5e345VdKrhxTU
         j9WC/KNnFoPanwsu7r1V8j9+9g5TjjPbVnAkIQKaQWgaaE+Qy9mFNG1LjufsrsLTPTrt
         J3Eg==
X-Gm-Message-State: AOJu0YxufQ6Z9uXWikaG81vh/ArtyBlX4IPkLfoNAiaX2WoBoRmjEu6B
        gk97Jtr8c++9ZRj0wJh/XC8Vt6Kus1pypjIfz4Q=
X-Google-Smtp-Source: AGHT+IG5eYyKxQ7v4BeSYTP68ZLyOM0a+2UD6jhzG4o1aaQzmzh48JM6+NSHjC/PrFyhQzDxn0ocYQ==
X-Received: by 2002:a05:6a20:2449:b0:13f:3d25:d83 with SMTP id t9-20020a056a20244900b0013f3d250d83mr24662771pzc.19.1693217844123;
        Mon, 28 Aug 2023 03:17:24 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id t25-20020a63a619000000b0056da0ae25cdsm6984680pge.80.2023.08.28.03.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 03:17:23 -0700 (PDT)
Date:   Mon, 28 Aug 2023 15:47:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com
Subject: Re: [Patch v2] cpufreq: tegra194: remove opp table in exit hook
Message-ID: <20230828101721.zq5vlc53p5umi63c@vireshk-i7>
References: <20230825111617.8069-1-sumitg@nvidia.com>
 <20230828061115.vsepgtexyv3hvffu@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828061115.vsepgtexyv3hvffu@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-23, 11:41, Viresh Kumar wrote:
> On 25-08-23, 16:46, Sumit Gupta wrote:
> > Add exit hook and remove OPP table when the device gets unregistered.
> > This will fix the error messages when the CPU FREQ driver module is
> > removed and then re-inserted. It also fixes these messages while
> > onlining the first CPU from a policy whose all CPU's were previously
> > offlined.
> > 
> >  debugfs: File 'cpu5' in directory 'opp' already present!
> >  debugfs: File 'cpu6' in directory 'opp' already present!
> >  debugfs: File 'cpu7' in directory 'opp' already present!
> > 
> > Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > ---
> > 
> > v1[1] -> v2:
> > - updated commit description.
> > 
> > [1] https://lore.kernel.org/lkml/20230809153455.29056-1-sumitg@nvidia.com/
> > 
> >  drivers/cpufreq/tegra194-cpufreq.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> > index c90b30469165..66a9c23544db 100644
> > --- a/drivers/cpufreq/tegra194-cpufreq.c
> > +++ b/drivers/cpufreq/tegra194-cpufreq.c
> > @@ -454,6 +454,8 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
> >  		if (ret < 0)
> >  			return ret;
> >  
> > +		dev_pm_opp_put(opp);
> > +
> 
> Missed this earlier, can you please do this in a separate patch please
> ?

I have pushed rest of this commit and dropped this part. Send it
separately. Thanks.

-- 
viresh
