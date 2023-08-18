Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CCE7802DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356792AbjHRBJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356825AbjHRBJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:09:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CC73A8B;
        Thu, 17 Aug 2023 18:09:35 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RRkGf4XqczFqgb;
        Fri, 18 Aug 2023 09:06:34 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 09:09:33 +0800
Message-ID: <90d0cc3d-08f7-8470-0fbf-61f10aed3ee1@huawei.com>
Date:   Fri, 18 Aug 2023 09:09:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3] cpufreq: cppc: Set fie_disabled to FIE_DISABLED if
 fails to create kworker_fie
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230817074756.883380-1-liaochang1@huawei.com>
 <20230817085624.dfevjozfpmmxcldn@vireshk-i7>
 <7fca5d2d-ad02-08b4-01d0-e9d997a7a58d@huawei.com>
 <20230817104801.5bdor4jbdeqlttyz@vireshk-i7>
From:   "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20230817104801.5bdor4jbdeqlttyz@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/17 18:48, Viresh Kumar 写道:
> On 17-08-23, 18:44, Liao, Chang wrote:
>> Hi Viresh,
>>
>> 在 2023/8/17 16:56, Viresh Kumar 写道:
>>> On 17-08-23, 07:47, Liao Chang wrote:
>>>> The function cppc_freq_invariance_init() may failed to create
>>>> kworker_fie, make it more robust by setting fie_disabled to FIE_DISBALED
>>>> to prevent an invalid pointer dereference in kthread_destroy_worker(),
>>>> which called from cppc_freq_invariance_exit().
>>>
>>> Btw, this version information present below should be added ... (see later)
>>>
>>>> v3:
>>>> Simplify cleanup code when invariance initialization fails.
>>>>
>>>> v2:
>>>> Set fie_disabled to FIE_DISABLED when invariance initialization fails.
>>>>
>>>> Link: https://lore.kernel.org/all/20230816034630.a4hvsj373q6aslk3@vireshk-i7/
>>>>
>>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>>>> ---
>>>
>>> ... here after the "---" line, this way this not-so-useful information will not
>>> be committed while applying the patch.
>>
>> Got it, I will move the "v2:... v3:..." lines below the "---" line in next patch.
> 
> I have already applied the fixed version now, don't resend it :)

OK，thanks

> 

-- 
BR
Liao, Chang
