Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E5A7936DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjIFIGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjIFIGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:06:53 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25736E7D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:06:41 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.176])
        by gateway (Coremail) with SMTP id _____8AxEvAQM_hknjIgAA--.63890S3;
        Wed, 06 Sep 2023 16:06:40 +0800 (CST)
Received: from [10.180.13.176] (unknown [10.180.13.176])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLCMPM_hkNk5uAA--.49402S3;
        Wed, 06 Sep 2023 16:06:39 +0800 (CST)
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
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <4a06f415-281f-b76f-ed03-211b07ccd6a4@loongson.cn>
Date:   Wed, 6 Sep 2023 16:06:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d6012fe0-9d06-f5ac-857c-c38034bf0758@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLCMPM_hkNk5uAA--.49402S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAGB2T3-DUCWwABsC
X-Coremail-Antispam: 1Uk129KBj93XoWxJrWktrWDCFWftr1kGF4xZrc_yoW8Zr4DpF
        n3CFy8KFWrKr97C3srtr1Y9ryUAw4DGa10gr1FyF18G3W3Jw4Iqr4jgrn09Fy5XanaqFWx
        WF42qw15uF48J3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2023/9/6 pm 3:42, David Hildenbrand wrote:
> On 05.09.23 08:49, Hongchen Zhang wrote:
>> When I do LTP test, LTP test case ksm06 caused panic at
>>     break_ksm_pmd_entry
>>       -> pmd_leaf (Huge page table but False)
>>       -> pte_present (panic)
>>
> 
> Probably there are other problematic bits without that can trigger that? 
> I suspect walk_page_range*() callers might be affected,
I rechecked the code and found that other architectures that support
THP have defined pmd_leaf.
So there is not problem on other architectures.
> 
>> The reason is pmd_leaf is not defined, So like
>> commit 501b81046701 ("mips: mm: add p?d_leaf() definitions")
>> add p?d_leaf() definition for LoongArch.
>>
> 
> We most certainly want to cc stable, no?
OK, let me cc stable in V2.
> 
> Can we come up with a Fixes: tag? Probably when we added THP support to 
> loongarch.
OK, let me add Fixes: in commit message in V2.
> 
>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/pgtable.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/loongarch/include/asm/pgtable.h 
>> b/arch/loongarch/include/asm/pgtable.h
>> index 370c6568ceb8..ea54653b7aab 100644
>> --- a/arch/loongarch/include/asm/pgtable.h
>> +++ b/arch/loongarch/include/asm/pgtable.h
>> @@ -243,6 +243,9 @@ static inline void pmd_clear(pmd_t *pmdp)
>>   #define pmd_phys(pmd)        PHYSADDR(pmd_val(pmd))
>> +#define pmd_leaf(pmd)        ((pmd_val(pmd) & _PAGE_HUGE) != 0)
>> +#define pud_leaf(pud)        ((pud_val(pud) & _PAGE_HUGE) != 0)
>> +
>>   #ifndef CONFIG_TRANSPARENT_HUGEPAGE
>>   #define pmd_page(pmd)        (pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
>>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE  */
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 


-- 
Best Regards
Hongchen Zhang

