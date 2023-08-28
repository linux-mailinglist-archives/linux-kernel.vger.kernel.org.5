Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C91078A844
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjH1Ix0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjH1Iwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:52:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E0AEB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:52:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bbc87ded50so15998255ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693212771; x=1693817571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wAjh/Ck2JmNcTliVM9iab+dmtjxUWH0F9AvGYbrAQ3g=;
        b=EjZKcyJFfVT1nTenec+sOAkrh6R/PVmxa/YsbaV8eBgr5XPTO2VPF9mmDPTssL+MKa
         8G5GIWaWMdG49QDuJ2GM9TK8Op6TIzVpH6FYEQFGH33yJI/vLR83iF28vcB/HxprIy9m
         OJPIQjVpVDq7Lc2JhqyYcEjdX91JXMEcpdWDe9Ebv3QbmrL6psl+p73ISO/XeceDTI0m
         n3bjsrCGelf85++tp6JNsqviUBKw9Nmt3lpFKjPiKjJYv6dqKCuucGrNi8LDj0W7QT4G
         g5zAO3OZT9imkpPhBLByhRJBZX0PthGZrC58xZNZy5d7VO6xoY0gyquavRkqb8J0YGG0
         eUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693212771; x=1693817571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAjh/Ck2JmNcTliVM9iab+dmtjxUWH0F9AvGYbrAQ3g=;
        b=CdQmwV6jITEc2BazhnUM8hLFtzJ92fC+dLwCWWgREsZt4M431n2xgHmvkQjsU7Ywpg
         qZvcjHYhGYAtRLOVBeo91Eb6XuD5icyZfV2OTQzRdumRvhNgydpaRd7Iy8fwHfJwqPbh
         k7Zx9ETuJv89D0s/ppFdhBjFxQGRHLg4TSdOXTKDAecF4BaScxnOvbhmjklpELKXEPoB
         M3bRJXo4s7HALQ4lbt6/rIjiFRxEbD2y5Dza+DQcD07QJJbY5eWRyyMlAyzK0+HstMMi
         NJnQkGHnoqiijDl75mmJmWQjni5O44brGkzj3TdOQ1Kn2msOlA7UTGH6MlLTMjsqTrYd
         uekA==
X-Gm-Message-State: AOJu0Ywn9xuv9r3CUDRunOmEZ60awYquJdCMJ1wfPujlLfF95RrociGO
        y+PheGg/WALhdt/VUa6YQfqv7A==
X-Google-Smtp-Source: AGHT+IHoxULP6S7942CkDlGBDDicDV1bV8/nioyrsBX08kP0b+1d99gkEGCgJ8rJbxpcn9vFETFFNA==
X-Received: by 2002:a17:902:e5c5:b0:1c0:aca0:8c2d with SMTP id u5-20020a170902e5c500b001c0aca08c2dmr13824390plf.67.1693212771572;
        Mon, 28 Aug 2023 01:52:51 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b001bde77f3d0esm6682425plo.117.2023.08.28.01.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 01:52:50 -0700 (PDT)
Date:   Mon, 28 Aug 2023 14:22:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Liao, Chang" <liaochang1@huawei.com>
Cc:     rafael@kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix the race condition while updating the
 transition_task of policy
Message-ID: <20230828085248.sz6aljr5aln7j435@vireshk-i7>
References: <20230826095836.1138608-1-liaochang1@huawei.com>
 <20230828072347.ly23mbptu3yw4zkv@vireshk-i7>
 <bcac1b3c-a2f7-7f18-4c2f-5cf27f4e89b5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcac1b3c-a2f7-7f18-4c2f-5cf27f4e89b5@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-23, 16:29, Liao, Chang wrote:
> Task B does not necessarily go to sleep when it calls wait_event(), it depends on
> the condition to wait for evaluate false or not. So there is a small race window
> where Task A already set 'transition_ongoing' to false and Task B can cross wait_event()
> immediately.
> 
> wait_event:
> do {
> 	might_sleep();
> 	if (condition) // !transition_ongoing
> 		break;
> 	__wait_event();
> };
> 
> I hope I do not miss something important in the code above.
 
> Yes, if the CPU uses weak memroy model, it is possible for the instructions to be reordered.
> therefore, it is a good idea to insert an smb() between these two lines if there is race here.

Maybe it would be better to do this instead ?

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6b52ebe5a890..f11b01b25e8d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -455,8 +455,10 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
                            policy->cur,
                            policy->cpuinfo.max_freq);

+       spin_lock(&policy->transition_lock);
        policy->transition_ongoing = false;
        policy->transition_task = NULL;
+       spin_unlock(&policy->transition_lock);

        wake_up(&policy->transition_wait);
 }

-- 
viresh
