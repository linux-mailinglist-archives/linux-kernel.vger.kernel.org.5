Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B13F79779F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbjIGQaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbjIGQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:29:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DF17698
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:26:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c09673b006so8590445ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694103963; x=1694708763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1CUVSUE/g7AfxRwMSaLzU3EKx7ahKOV7VYgsEDqqhY=;
        b=hpjVAO9DyqJbzzyu9zLrSmKgC0TKBxAKbEHHoPiBONW0EOZuB8DFA9REV9VP2atn0M
         v8JOAJh3VnNQ8bmbFBvnf7hrcQB+wpxot9mdVp7t0kThQN+ILU0/q4mGVakXr//T+HTu
         C1htG9Tjd9Ux3U8j9Rq+YB7oo6diuQJeMCC/kqS5HbAaaaQ4UgSf7vgd+Pn6xXiq5xwz
         TeNPIWeb3EUoN+FaQdPESczMC2N4dPJ6vM3rEMsY7uyDJGv2iX/45p6YjUJv/E2hNFWg
         stENtIccwewhzYBIlz5lLIvTj6BkPvT3CdKC6wO7KLRHgoBDiDGvCpBuehTbNAKdKb6u
         /hHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103963; x=1694708763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l1CUVSUE/g7AfxRwMSaLzU3EKx7ahKOV7VYgsEDqqhY=;
        b=PYVDu7UpXIqzIySKh2VHPzcRm1ZutZYsN0dLr8s2wg6mx+TYzCIafeGs49FXcyllcT
         08Wy8rJO+Pd36PmkdTUup3fVDHPF26hx5HR3JffTTaoNxO7HYHA7oUwDCsHiQMaE0J6I
         D6SSWKhprClFjQebqSxQnz2lXrzbD4n7V7E590MgAWF+euasjDorGdrljYlwIbnH0r7P
         uJmf+8vDjUEPh7HGI9UQgjgB7kssrqJvijm0o2awbHmC0H3xMPMDJj3txY3O/+io6W9X
         mpOEbwZcjI7adCTrTFzKYTbsqVto+YNbQczLq+te4m2jYLTXYVPNFwHOdOvUAdspqdZs
         csdg==
X-Gm-Message-State: AOJu0YxwG3Iohj1xyahn9VCjSaBzbXaIgNyQ4sHFkzUGmbo9YzCTBSF4
        x4PUhqzpZVPcUH6UWjUQRymnx/4O1dCpeWnNmGM=
X-Google-Smtp-Source: AGHT+IEhSwixRwMFJ/PEPA+HuSWv/jCCwwmhpvjeHTvgxdJeu9Oz8P1U41uftIqVJn6ThXvamkVttA==
X-Received: by 2002:a05:6a21:7889:b0:153:a00b:dca0 with SMTP id bf9-20020a056a21788900b00153a00bdca0mr4104800pzc.11.1694077170404;
        Thu, 07 Sep 2023 01:59:30 -0700 (PDT)
Received: from [10.84.158.67] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id t23-20020a1709028c9700b001bdb85291casm12313579plo.208.2023.09.07.01.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 01:59:29 -0700 (PDT)
Message-ID: <3544d5e3-3070-9ddc-fa6c-a05ed35dfd14@bytedance.com>
Date:   Thu, 7 Sep 2023 16:59:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [External] Re: Fwd: WARNING: CPU: 13 PID: 3837105 at
 kernel/sched/sched.h:1561 __cfsb_csd_unthrottle+0x149/0x160
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Benjamin Segall <bsegall@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Igor Raits <igor.raits@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>
References: <a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com>
 <xm26cyz4ibnb.fsf@google.com>
 <55e2861e-9722-08f8-2c49-966035ff4218@bytedance.com>
 <20230904222351.GC2568@noisy.programming.kicks-ass.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230904222351.GC2568@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/5 Peter Zijlstra wrote:
> On Thu, Aug 31, 2023 at 04:48:29PM +0800, Hao Jia wrote:
> 
>> If I understand correctly, rq->clock_update_flags may be set to
>> RQCF_ACT_SKIP after __schedule() holds the rq lock, and sometimes the rq
>> lock may be released briefly in __schedule(), such as newidle_balance(). At
>> this time Other CPUs hold this rq lock, and then calling
>> rq_clock_start_loop_update() may trigger this warning.
>>
>> This warning check might be wrong. We need to add assert_clock_updated() to
>> check that the rq clock has been updated before calling
>> rq_clock_start_loop_update().
>>
>> Maybe some things can be like this?
> 
> Urgh, aside from it being white space mangled, I think this is entirely
> going in the wrong direction.
> 
> Leaking ACT_SKIP is dodgy as heck.. it's entirely too late to think
> clearly though, I'll have to try again tomorrow.

Hi Peter,

Do you think this fix method is correct? Or should we go back to the 
beginning and move update_rq_clock() from unthrottle_cfs_rq()?

Thanks,
Hao
