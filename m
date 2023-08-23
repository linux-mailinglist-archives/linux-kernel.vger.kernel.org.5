Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA91784EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjHWCic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjHWCib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:38:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6E3E47
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 19:38:29 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVr023tlhztS8Q;
        Wed, 23 Aug 2023 10:34:42 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 10:38:25 +0800
Message-ID: <767363ed-aaae-af58-33de-939dc29ff1e6@huawei.com>
Date:   Wed, 23 Aug 2023 10:38:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <jonathan.cameron@huawei.com>,
        <mark.rutland@arm.com>, <chenhao418@huawei.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH drivers/perf: hisi: 1/2] drivers/perf: hisi: hns3: default
 use hardware event 0 as group leader event.
To:     Will Deacon <will@kernel.org>
References: <20230816094619.3563784-1-shaojijie@huawei.com>
 <20230816094619.3563784-2-shaojijie@huawei.com>
 <20230821115820.GA19617@willie-the-truck>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20230821115820.GA19617@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/8/21 19:58, Will Deacon wrote:
> On Wed, Aug 16, 2023 at 05:46:18PM +0800, Jijie Shao wrote:
>> From: Hao Chen <chenhao418@huawei.com>
>>
>> For hns3 pmu events, we use command as below before:
>> perf stat -g -e hns3_pmu_sicl_0/config=0x00105,global=1/
>> -e hns3_pmu_sicl_0/config=0x10105,global=1/ -I 1000
>>
>> We want to use -g parameter to make 0x00105 event and 0x10105 event
>> share a hardware event, but for kernel 6.2, 'commit 5f8f95673f68
>> ("perf evlist: Remove group option.")' remove -g parameter.
>>
>> So add this patch to set default related event idx as 0 to share
>> the first hardware event.
> Hmm, but the change cited above is a userspace change so I don't think
> we should be making driver-side changes for that. Furthermore, the commit
> message there suggests that you should be using a different syntax,
> introduced by 89efb029502d ("perf tools: Add support to parse event
> group syntax") (which describes the grammer and has some examples too).
>
> Will

Thanks for your introduction, we are retesting this scenario as

89efb029502d("perf tools: Add support to parse eventgroup syntax")

Jijie Shao

