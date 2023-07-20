Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC675A9AC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjGTI42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGTIhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:37:37 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5D426A4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:37:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R65fL2mlJz4f3p0S
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 16:37:30 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgBHJ9VJ8rhkhrpDOQ--.6998S2;
        Thu, 20 Jul 2023 16:37:31 +0800 (CST)
Subject: Re: [PATCH 0/3] add page_ext_data to get client data in page_ext
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, pasha.tatashin@soleen.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230718145812.1991717-1-shikemeng@huaweicloud.com>
 <20230719094421.GI1901145@kernel.org>
 <aa2134aa-3767-b9fe-1504-d6945e8c2f7b@huaweicloud.com>
 <20230720053736.GM1901145@kernel.org>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <cef4f633-8d5c-0029-cbac-feed9f106bfc@huaweicloud.com>
Date:   Thu, 20 Jul 2023 16:37:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230720053736.GM1901145@kernel.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgBHJ9VJ8rhkhrpDOQ--.6998S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr48XFyUCFykWF15Cr4xXrb_yoW8ur1fpF
        WDAFyUtF4kJw4avanFyw4kAw1rtw4fJF4UX3WYkryxZa98Gr15tF1xAr1UuayIgF1Yv347
        ursrta4jv34DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 7/20/2023 1:37 PM, Mike Rapoport wrote:
> Hi,
> 
> On Thu, Jul 20, 2023 at 10:38:39AM +0800, Kemeng Shi wrote:
>>
>> on 7/19/2023 5:44 PM, Mike Rapoport wrote:
>>> On Tue, Jul 18, 2023 at 10:58:09PM +0800, Kemeng Shi wrote:
>>>> Current client get data from page_ext by adding offset which is auto
>>>> generated in page_ext core and expose the data layout design insdie
>>>> page_ext core. This series adds a page_ext_data to hide offset from
>>>> client. Thanks!
>>>
>>> Implementers of page_ext_operations are anyway intimately related to
>>> page_ext, so I'm not convinced this has any value.
>>>  
>> Hi Mike, thanks for reply. I thinks page_ext_operations can be futher splited
>> into public part which used by client to simply register and private part which
>> only page_ext core cares and should not be accessed by client directly
>> to reduce decoupling.
> 
> It would be easier to justify changes in this series if they were a part of
> the refactoring you describe here.
Actually, it's not the refactoring trigger this. I found offset used
in client code while I could not find intialization of offset in client.
After some search, I found how offset is generated in page_ext core and
it's more like a page_ext internal behavior. Feel it's better to reduce
dependency from upper level client to low level internal implementation.

>> This series makes offset to be private which client
>> doesn't really care to hide data layout inside page_ext core from client.
>> There are some concrete gains I can list for now:
>> 1. Future client cound call page_ext_data directly instead of define a
>> new function like get_page_owner to get it's data.
>> 2. No change to client if layout of page_ext data change.
> 
> These should be a part of the changelog.
Yes, it's better to highlight the gains. This series was taken into the tree.
I'm not sure if I need send a v2 to include this or Andrew could add this
when code merged to more stable tree.
>> I hope this could be more convincing to you now.
>> Thanks!
>>
>> -- 
>> Best wishes
>> Kemeng Shi
>>
> 

-- 
Best wishes
Kemeng Shi

