Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F9976E706
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjHCLge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjHCLgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:36:33 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A3E92708
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:36:26 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxfOo5kctk_q4PAA--.9334S3;
        Thu, 03 Aug 2023 19:36:25 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx3yM4kctk5SBHAA--.12598S3;
        Thu, 03 Aug 2023 19:36:24 +0800 (CST)
Subject: Re: [PATCH v1 5/6] objtool: Add skipped member in struct reloc
To:     Peter Zijlstra <peterz@infradead.org>
References: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
 <1690272910-11869-6-git-send-email-yangtiezhu@loongson.cn>
 <20230725115959.GE3765278@hirez.programming.kicks-ass.net>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b111cb87-3f30-860a-640b-2f7264a16838@loongson.cn>
Date:   Thu, 3 Aug 2023 19:36:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230725115959.GE3765278@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Bx3yM4kctk5SBHAA--.12598S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFykXr4xtFy3urWrJw4xAFc_yoW8Kw48pr
        W3WanFka18JF4DWr42qw4Uuw1jgw48uF15JrW5JrykGw1DA34kKw42qw4SyayUGryvkw4F
        qryfWw1qyFyDAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/25/2023 07:59 PM, Peter Zijlstra wrote:
> On Tue, Jul 25, 2023 at 04:15:09PM +0800, Tiezhu Yang wrote:
>> There exist multiple relocation types in one location, such as a pair of
>> R_LARCH_ADD32 and R_LARCH_SUB32 in section .rela.discard.unreachable and
>> .rela.discard.reachable on LoongArch.
>>
>> Here is an example:
>>
>> $ readelf -rW init/main.o
>>
>> Relocation section '.rela.discard.unreachable' at offset 0x3e20 contains 2 entries:
>>     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
>> 0000000000000000  0000000a00000032 R_LARCH_ADD32          0000000000000000 .init.text + 230
>> 0000000000000000  0000001a00000037 R_LARCH_SUB32          0000000000000000 L0^A + 0
>>
>
> Please explain; why is this?
>
> How does:
>
> #define __annotate_unreachable(c) ({					\
> 	   asm volatile(__stringify_label(c) ":\n\t"                       \
> 			".pushsection .discard.unreachable\n\t"            \
> 			".long " __stringify_label(c) "b - .\n\t"          \
> 			".popsection\n\t" : : "i" (c));                    \
> })
> #define annotate_unreachable() __annotate_unreachable(__COUNTER__)
>
> Manage to generate this..
>

Sorry for the late reply, let me try to explain it.

R_LARCH_ADD32 relocation type is 32-bit label addition,
R_LARCH_SUB32 relocation type is 32-bit label subtraction,
they are intended for local labels, the label difference
will be calculated as a constant before linking, preserve
a pair of R_LARCH_ADD32 and R_LARCH_SUB32 to fix the label
difference.

Here is a simple example:
-------------------------------
.L0
  // do something
.L1

.data
.word .L0 - .L1
-------------------------------

NewDiff = 0
R_LARCH_ADD32:
NewDiff = NewDiff + .L0_Addr
R_LARCH_SUB32:
NewDiff = NewDiff - .L1_Addr

I discussed offline with the engineers who are familiar with gnu
assembler of LoongArch, maybe it can modify the gnu assembler
to use R_LARCH_32_PCREL to replace a pair of R_LARCH_ADD32 and
R_LARCH_SUB32, then I will test it again and drop this change if
possible.

Here is LoongArch ELF Relocations spec:
https://github.com/loongson/la-abi-specs/blob/release/laelf.adoc

R_LARCH_ADD32
32-bit in-place addition
*(int32_t *) PC += S + A

R_LARCH_SUB32
32-bit in-place subtraction
*(int32_t *) PC -= S + A

R_LARCH_32_PCREL
32-bit PC relative
(*(uint32_t *) PC) = (S+A-PC) [31 ... 0]

Thanks very much for your review comments, it is helpful to
make progress in the right direction.

Thanks,
Tiezhu

