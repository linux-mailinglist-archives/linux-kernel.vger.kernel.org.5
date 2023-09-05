Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B66792C0D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353455AbjIERGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354368AbjIELDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:03:06 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 214D41AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:02:58 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8BxIvDhCvdk7oYfAA--.62931S3;
        Tue, 05 Sep 2023 19:02:57 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB83hCvdkx8lsAA--.58503S3;
        Tue, 05 Sep 2023 19:02:57 +0800 (CST)
Message-ID: <22b90beb-4eeb-de44-fce5-e8504c58f1f0@loongson.cn>
Date:   Tue, 5 Sep 2023 19:02:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] LoongArch: Remove zero_page_mask symbol
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230905080147.1625448-1-maobibo@loongson.cn>
 <20230905080147.1625448-2-maobibo@loongson.cn>
 <CAAhV-H7VK+XkpCJUjX8vE2MtHDqzteCeDkvdxurKMbCZ6brSFg@mail.gmail.com>
Content-Language: en-US
From:   bibo mao <maobibo@loongson.cn>
In-Reply-To: <CAAhV-H7VK+XkpCJUjX8vE2MtHDqzteCeDkvdxurKMbCZ6brSFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxB83hCvdkx8lsAA--.58503S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur1UAw4kArWkWryfKF4fCrX_yoW5JF18pF
        9rAF1vgF48GryrArn2vwnF9r18JwsxKF4IgFy2yFyq93sFqry0gr1ktrZ7ZFyUtayxGFWI
        va15Gr1avFs0yacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
        vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
        6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU8zwZ7UUUUU==
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/5 18:58, Huacai Chen 写道:
> Hi, Bibo,
> 
> On Tue, Sep 5, 2023 at 4:01 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> On LoongArch system, there is only one page for zero page, and
>> there is no COLOR_ZERO_PAGE, so zero_page_mask is useless and
>> macro __HAVE_COLOR_ZERO_PAGE is not necessary. This patch removes
>> zero_page_mask and macro __HAVE_COLOR_ZERO_PAGE.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>  arch/loongarch/include/asm/pgtable.h | 4 +---
>>  arch/loongarch/mm/init.c             | 9 +--------
>>  2 files changed, 2 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
>> index 06963a172319..342c5f9c25d2 100644
>> --- a/arch/loongarch/include/asm/pgtable.h
>> +++ b/arch/loongarch/include/asm/pgtable.h
>> @@ -71,11 +71,9 @@ struct vm_area_struct;
>>   */
>>
>>  extern unsigned long empty_zero_page;
>> -extern unsigned long zero_page_mask;
>>
>>  #define ZERO_PAGE(vaddr) \
>> -       (virt_to_page((void *)(empty_zero_page + (((unsigned long)(vaddr)) & zero_page_mask))))
>> -#define __HAVE_COLOR_ZERO_PAGE
>> +       (virt_to_page((void *)(empty_zero_page)))
>>
>>  /*
>>   * TLB refill handlers may also map the vmalloc area into xkvrange.
>> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
>> index 3b7d8129570b..8ec668f97b00 100644
>> --- a/arch/loongarch/mm/init.c
>> +++ b/arch/loongarch/mm/init.c
>> @@ -35,14 +35,8 @@
>>  #include <asm/pgalloc.h>
>>  #include <asm/tlb.h>
>>
>> -/*
>> - * We have up to 8 empty zeroed pages so we can map one of the right colour
>> - * when needed.         Since page is never written to after the initialization we
>> - * don't have to care about aliases on other CPUs.
>> - */
>> -unsigned long empty_zero_page, zero_page_mask;
>> +unsigned long empty_zero_page;
>>  EXPORT_SYMBOL(empty_zero_page);
>> -EXPORT_SYMBOL(zero_page_mask);
>>
>>  void setup_zero_pages(void)
>>  {
>> @@ -60,7 +54,6 @@ void setup_zero_pages(void)
>>         for (i = 0; i < (1 << order); i++, page++)
>>                 mark_page_reserved(page);
>>
>> -       zero_page_mask = ((PAGE_SIZE << order) - 1) & PAGE_MASK;
> In my opinion it is better to combine two patches to one. Because this
> patch can only work *accidently* when 'order' is zero.
sure, will do.

Regards
Bibo Mao

> 
> Huacai
>>  }
>>
>>  void copy_user_highpage(struct page *to, struct page *from,
>> --
>> 2.27.0
>>
>>

