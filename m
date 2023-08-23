Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F09784EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjHWCdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjHWCdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:33:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF33CCF9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 19:33:10 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RVqtg4pfJzLpBZ;
        Wed, 23 Aug 2023 10:30:03 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 10:33:07 +0800
Message-ID: <7fb893ab-9f82-4dd6-ccf6-2432e9e1e769@huawei.com>
Date:   Wed, 23 Aug 2023 10:33:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <jonathan.cameron@huawei.com>,
        <mark.rutland@arm.com>, <chenhao418@huawei.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH drivers/perf: hisi: 2/2] drivers/perf: hisi: fix set wrong
 filter mode for running events issue
To:     Will Deacon <will@kernel.org>
References: <20230816094619.3563784-1-shaojijie@huawei.com>
 <20230816094619.3563784-3-shaojijie@huawei.com>
 <20230821120440.GB19617@willie-the-truck>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20230821120440.GB19617@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/8/21 20:04, Will Deacon wrote:
>> -	return tc_id != HNS3_PMU_FILTER_ALL_TC;
>> +	return (tc_id != HNS3_PMU_FILTER_ALL_TC) && (!bdf);
>>   }
> Sorry, but I'm struggling to see how this correlates with your example
> in the commit message, which implies that it's the config of 0x3 causing
> the problem rather than the bdf.
>
> Please can you explain the problem in more detail?
>
> Thanks,
>
> Will


We'll send the v2 patch to add more details.

Jijie Shao

