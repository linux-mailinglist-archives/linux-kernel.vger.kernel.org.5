Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C48278BE58
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjH2GW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjH2GWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:22:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EC0184;
        Mon, 28 Aug 2023 23:22:18 -0700 (PDT)
Received: from kwepemd100002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RZcjx6cLQzrSLt;
        Tue, 29 Aug 2023 14:20:37 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Tue, 29 Aug 2023 14:22:15 +0800
Message-ID: <655f122b-2c27-0629-15da-7a60348a6ddf@huawei.com>
Date:   Tue, 29 Aug 2023 14:22:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] cpufreq: Fix inconsistency in error messages of
 cpufreq_resume/suspend()
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230826095201.1137288-1-liaochang1@huawei.com>
 <20230828070000.ooymfbw3qhs5xl5y@vireshk-i7>
 <b7be717c-41d8-bbbf-3e97-3799948ab757@huawei.com>
 <20230829060129.ux7lbf22t225necx@vireshk-i7>
From:   "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20230829060129.ux7lbf22t225necx@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100002.china.huawei.com (7.221.188.184)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/29 14:01, Viresh Kumar 写道:
> On 28-08-23, 20:31, Liao, Chang wrote:
>> What about printing message like this below when cpufreq_start_governor() fails.
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 50bbc969ffe5..b78b509429a6 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1943,16 +1943,16 @@ void cpufreq_resume(void)
>>
>>                         if (ret)
>> -                               pr_err("%s: Failed to start governor for policy: %p\n",
>> -                                      __func__, policy);
>> +                               pr_err("%s: Failed to start governor for policy%u\n",
> 
> s/policy/CPU%u's policy/ ?

Sounds good, thanks.

-- 
BR
Liao, Chang
