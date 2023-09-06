Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247E87937AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjIFJFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjIFJFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:05:11 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF0491B3;
        Wed,  6 Sep 2023 02:05:06 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.176])
        by gateway (Coremail) with SMTP id _____8CxNvHBQPhkW0AgAA--.64422S3;
        Wed, 06 Sep 2023 17:05:05 +0800 (CST)
Received: from [10.180.13.176] (unknown [10.180.13.176])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxDCO+QPhk6VtuAA--.49808S3;
        Wed, 06 Sep 2023 17:05:03 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: add p?d_leaf() definitions
To:     David Hildenbrand <david@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport IBM)" <rppt@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Matthew Wilcox Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230906084351.3533-1-zhanghongchen@loongson.cn>
 <f7ca2e61-825a-f6cb-09b0-3b12e2c308ac@redhat.com>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <09c3b714-2325-feee-bf13-50ad844cf817@loongson.cn>
Date:   Wed, 6 Sep 2023 17:05:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f7ca2e61-825a-f6cb-09b0-3b12e2c308ac@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDCO+QPhk6VtuAA--.49808S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAGB2T3-DUDaQABsx
X-Coremail-Antispam: 1Uk129KBj9xXoWruryDWF47uryrGFy3tF13Awc_yoWftrX_Aa
        4xZrs7WrWjqw48ta1rJr4fZrsYqa1j9w45Z3sayr4rXFn8GF9xWFyrAF93Cw15Cr4YyryI
        9F98XwsayrW7AosvyTuYvTs0mTUanT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbq8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Cr1j6rxdM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUstxhDUUUU
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/6 下午4:45, David Hildenbrand wrote:
> On 06.09.23 10:43, Hongchen Zhang wrote:
>> When I do LTP test, LTP test case ksm06 caused panic at
>>     break_ksm_pmd_entry
>>       -> pmd_leaf (Huge page table but False)
>>       -> pte_present (panic)
>>
>> The reason is pmd_leaf is not defined, So like
>> commit 501b81046701 ("mips: mm: add p?d_leaf() definitions")
>> add p?d_leaf() definition for LoongArch.
>>
>> v2: add Fixes: in commit message.
> 
> This belongs under the "---". I assume whoever picks that up can fix it up.
> 
OK, let me change it under the "---".
>>
>> Fixes: 09cfefb7fa70 ("LoongArch: Add memory management")
>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>> ---
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> We should CC stable. I assume whoever picks that up can fix it up.
OK,let me add Cc: stable@ the commit message.
> 


-- 
Best Regards
Hongchen Zhang

