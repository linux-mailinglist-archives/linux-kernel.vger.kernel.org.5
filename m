Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D877C924C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 04:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjJNCMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 22:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNCMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 22:12:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBC05A9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 19:12:20 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxfesC+SllGukxAA--.28251S3;
        Sat, 14 Oct 2023 10:12:18 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_y8B+SllHbojAA--.9890S3;
        Sat, 14 Oct 2023 10:12:17 +0800 (CST)
Subject: Re: [PATCH v2 1/8] objtool/LoongArch: Enable objtool to be built
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1696856590-30298-1-git-send-email-yangtiezhu@loongson.cn>
 <1696856590-30298-2-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7NQM_W-T80UdPy0F7jUFa-eWKLymoLHkgUGoAGzZPUTQ@mail.gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <872be5af-26f0-34db-dedb-0d6ecb7092c0@loongson.cn>
Date:   Sat, 14 Oct 2023 10:12:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7NQM_W-T80UdPy0F7jUFa-eWKLymoLHkgUGoAGzZPUTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_y8B+SllHbojAA--.9890S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrur47Ar4rGrWUCFWxCw47Jrc_yoWkZrc_uw
        17Wa1kur1rXFWft3Z0vF95uF98GayrZrs5ArWvqr43W3Z8ta1DGFZrX348Zr45K3yvvFsx
        CFZ5Jr13CrnFgosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
        AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9N3UU
        UUU==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2023 08:45 PM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> On Mon, Oct 9, 2023 at 9:03 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> Add the minimal changes to enable objtool build on LoongArch,
>> most of the functions are stubs to only fix the build errors
>> when make -C tools/objtool.
>>
>> This is similar with commit e52ec98c5ab1 ("objtool/powerpc:
>> Enable objtool to be built on ppc").

...

>> diff --git a/tools/objtool/arch/loongarch/include/arch/special.h b/tools/objtool/arch/loongarch/include/arch/special.h
>> new file mode 100644
>> index 0000000..1a8245c
>> --- /dev/null
>> +++ b/tools/objtool/arch/loongarch/include/arch/special.h
>> @@ -0,0 +1,33 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#ifndef _OBJTOOL_ARCH_SPECIAL_H
>> +#define _OBJTOOL_ARCH_SPECIAL_H
>> +
>> +/*
>> + * See more info about struct exception_table_entry
>> + * in arch/loongarch/include/asm/extable.h
>> + */
>> +#define EX_ENTRY_SIZE 12
>> +#define EX_ORIG_OFFSET 0
>> +#define EX_NEW_OFFSET 4
> Other archs use tab for indentation in special.h
>

OK, thank you, will do it.

Thanks,
Tiezhu

