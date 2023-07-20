Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE4175AB78
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjGTJwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjGTJwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:52:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4B4213
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:50:56 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R66r90jwJz18LQR;
        Thu, 20 Jul 2023 17:31:05 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 17:31:49 +0800
Message-ID: <a989179a-102a-d07d-aa80-0ff45d21a74a@huawei.com>
Date:   Thu, 20 Jul 2023 17:31:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
Subject: Re: [PATCH v2 8/9] mm/page_io: convert count_swpout_vm_event() to
 take in a folio
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <sidhartha.kumar@oracle.com>, <akpm@linux-foundation.org>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20230719095848.3422629-1-zhangpeng362@huawei.com>
 <20230719095848.3422629-9-zhangpeng362@huawei.com>
 <ZLfyDvSgFxkX6Z1Z@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <ZLfyDvSgFxkX6Z1Z@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/19 22:24, Matthew Wilcox wrote:

> On Wed, Jul 19, 2023 at 05:58:47PM +0800, Peng Zhang wrote:
>> -static inline void count_swpout_vm_event(struct page *page)
>> +static inline void count_swpout_vm_event(struct folio *folio)
>>   {
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -	if (unlikely(PageTransHuge(page)))
>> +	if (unlikely(folio_test_pmd_mappable(folio)))
>>   		count_vm_event(THP_SWPOUT);
>>   #endif
> As I said in my earlier response, you don't need the ifdefs.  Check
> the definition of folio_test_pmd_mappable.

Sorry I forgot to delete the ifdefs. I'll fix it in a v3.
Thanks.

-- 
Best Regards,
Peng

