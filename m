Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0157E662F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbjKIJFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKIJFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:05:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C607EA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:05:51 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SQwtT5bJKzPpB4;
        Thu,  9 Nov 2023 17:01:37 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 9 Nov 2023 17:05:38 +0800
Message-ID: <059593a8-aa30-475f-9de6-35e7136c1759@huawei.com>
Date:   Thu, 9 Nov 2023 17:05:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kpageflags: respect folio head-page flag placement
Content-Language: en-US
To:     Gregory Price <gregory.price@memverge.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Gregory Price <gourry.memverge@gmail.com>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <david@redhat.com>, <vbabka@suse.cz>, <naoya.horiguchi@linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20231030180005.2046-1-gregory.price@memverge.com>
 <ZUA6qq6zXuc0fqOE@casper.infradead.org> <ZUA/IzTMokFsXS5Y@memverge.com>
 <ZUDFSEvpxxoGWmdG@casper.infradead.org> <ZUCD1dsbrFjdZgVv@memverge.com>
 <bc332eb1-fe00-416d-b915-b2957d7b25b9@huawei.com>
 <ZUpZCsR1rmIau8wv@memverge.com>
 <cc4ac7de-97f5-4131-804d-622fb158dba9@huawei.com>
 <ZUwauTb/MqvyUEfI@memverge.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZUwauTb/MqvyUEfI@memverge.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/9 7:33, Gregory Price wrote:
> On Wed, Nov 08, 2023 at 10:01:19AM +0800, Kefeng Wang wrote:
>>
>> Yes, I see your "Node Weights and Weighted Interleave", this is an
>> interesting topic, we need some easy and efficient way to use tiered
>> memory.
>>
> 
> There will be an LPC talk on it next week in the CXL track, presented
> by another group that's been testing it.  Please tune in!

Sure.

> 
>>>
>>> There's only a handful, so yeah the best way is probably to go ahead and
>>> swap k = page->flags for k = *folio_flags(folio, 0) and then handle the
>>> couple of outliars.
>>
>> If you don't mind, I maybe try to convert it in my changes.
>>
> 
> Please feel free! I am happy to help test, CC me on subsequent patches
> please!

Will do, thanks.
> 
> ~Gregory
