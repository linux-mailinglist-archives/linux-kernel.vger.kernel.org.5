Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8EA76CCEE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjHBMif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjHBMiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:38:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED12326B0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:38:20 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGBJJ01GtztRLq;
        Wed,  2 Aug 2023 20:34:55 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 20:38:17 +0800
Message-ID: <32b748d2-3d88-87d6-3797-c82d7bb7a927@huawei.com>
Date:   Wed, 2 Aug 2023 20:38:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/4] mm: migrate: more folio conversion
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Huang Ying <ying.huang@intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
 <bf4b5b30-4ed1-13ed-bba9-234887c9eeb3@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <bf4b5b30-4ed1-13ed-bba9-234887c9eeb3@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
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



On 2023/8/2 19:47, David Hildenbrand wrote:
> On 02.08.23 11:53, Kefeng Wang wrote:
>> This patch series converts several functions to use folio in migrate.c.
> 
> Please clearly spell out in the patch descriptions when you are changing 
> mapcount logic and which effects that might have (both, positive and 
> negative) for PTE-mapped THP.

Oh, I see your comments on another mail[1], the folio_estimated_sharers()
is not good to evaluate the sharing by multiple processes, will read more
history of the mail's discussion, maybe just ignore the first three patches.

Thank.


[1] [PATCH 0/2] don't use mapcount() to check large folio sharing
> 
