Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57900793716
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjIFIXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjIFIXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:23:02 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1644CE6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:22:57 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.176])
        by gateway (Coremail) with SMTP id _____8CxtPDgNvhkDjwgAA--.22S3;
        Wed, 06 Sep 2023 16:22:56 +0800 (CST)
Received: from [10.180.13.176] (unknown [10.180.13.176])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxvM7fNvhkzlNuAA--.3078S3;
        Wed, 06 Sep 2023 16:22:55 +0800 (CST)
Subject: Re: [PATCH] LoongArch: add p?d_leaf() definitions
To:     David Hildenbrand <david@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport IBM)" <rppt@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Matthew Wilcox Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <20230905064955.16316-1-zhanghongchen@loongson.cn>
 <d6012fe0-9d06-f5ac-857c-c38034bf0758@redhat.com>
 <4a06f415-281f-b76f-ed03-211b07ccd6a4@loongson.cn>
 <a371b120-5536-1054-7f09-957b427e46ff@redhat.com>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <ff90ca49-88b7-c2ab-d1b3-81e07eed5a97@loongson.cn>
Date:   Wed, 6 Sep 2023 16:22:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a371b120-5536-1054-7f09-957b427e46ff@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvM7fNvhkzlNuAA--.3078S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAGB2T3-DUCoQABs4
X-Coremail-Antispam: 1Uk129KBj9xXoW7XF1UXrW8Jryktw47Gw4Dtrc_yoWDZFXEva
        92vrWDu3y8Ww47t3ZYyrZa9F9rJF109F45Z39xXrs2ga4UJFn8JF13Wr9YvryUKa95Cr1x
        C3s0vw4Sva12yosvyTuYvTs0mTUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbq8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_GFv_Wrylx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/6 下午4:08, David Hildenbrand wrote:
> On 06.09.23 10:06, Hongchen Zhang wrote:
>> Hi David,
>>
>> On 2023/9/6 pm 3:42, David Hildenbrand wrote:
>>> On 05.09.23 08:49, Hongchen Zhang wrote:
>>>> When I do LTP test, LTP test case ksm06 caused panic at
>>>>      break_ksm_pmd_entry
>>>>        -> pmd_leaf (Huge page table but False)
>>>>        -> pte_present (panic)
>>>>
>>>
>>> Probably there are other problematic bits without that can trigger that?
>>> I suspect walk_page_range*() callers might be affected,
>> I rechecked the code and found that other architectures that support
>> THP have defined pmd_leaf.
>> So there is not problem on other architectures.
> 
> I meant other walk_page_range*() callers on loongarch might similarly be 
> affected. IOW, KSM might not be the only bit being able to trigger such 
> panics on loongarch.
Yes, perf_get_pgtable_size and vmalloc_to_page also call pmd_leaf.
So they may also trigger this issue on LoongArch.
> 


-- 
Best Regards
Hongchen Zhang

