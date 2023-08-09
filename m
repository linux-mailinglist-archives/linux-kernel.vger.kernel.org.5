Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F097756BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjHIJzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjHIJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:55:38 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1EF81FEA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:55:36 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxIvCXYtNk_LcTAA--.42343S3;
        Wed, 09 Aug 2023 17:55:35 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxxsyWYtNkRRZRAA--.49183S3;
        Wed, 09 Aug 2023 17:55:35 +0800 (CST)
Subject: Re: [PATCH v1 0/6] Add objtool and orc support for LoongArch
To:     Peter Zijlstra <peterz@infradead.org>
References: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
 <20230725120110.GF3765278@hirez.programming.kicks-ass.net>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <33274746-a943-947b-55b0-5ba449ebc769@loongson.cn>
Date:   Wed, 9 Aug 2023 17:55:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230725120110.GF3765278@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxxsyWYtNkRRZRAA--.49183S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr4xGr43GrWrZr45KFW5CFX_yoW8KrWUpF
        y7GFZxKr4rXFWxA3Z7J3W2q3y3XryYyFW7ta98JryrCr45ZF9Yg3yfKa12v3W5Wr43XFyF
        y3y8WasrKa1qyagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/25/2023 08:01 PM, Peter Zijlstra wrote:
> On Tue, Jul 25, 2023 at 04:15:04PM +0800, Tiezhu Yang wrote:
>
>> To be honest, there still exist some objtool warnings, I will try my best
>> to fix them in the later versions or the other separate patches.
>
> Please give us some examples of what's still going wrong. Are you
> running into jump-tables? IIRC I've not seen code for those yet.
>

Sorry for the late reply, I did more analysis and test recently.
I have already addressed most of the objtool warnings, discussed
offline with compiler engineers, sent separate patch to maillist
or modified the related code locally.

For example,
arch/loongarch/mm/fault.o: warning: objtool: no_context.part.0() falls 
through to next function do_sigsegv()
[PATCH] LoongArch: Remove noreturn attribute for die()
https://lore.kernel.org/loongarch/1690871581-23944-1-git-send-email-yangtiezhu@loongson.cn/

Additionally, when I update the latest upstream gcc and binutils,
it generates more objtool warnings, like this:
init/version.o: warning: objtool: early_hostname+0x20: sibling call from 
callable instruction with modified stack frame

[fedora@linux 6.5.test]$ gcc --version
gcc (GCC) 14.0.0 20230803 (experimental)
[fedora@linux 6.5.test]$ as --version
GNU assembler (GNU Binutils) 2.41.50.20230803
[fedora@linux 6.5.test]$ objdump -M no-aliases -D init/version.o
0000000000000000 <early_hostname>:
    0:   00150085        or              $a1, $a0, $zero
    4:   1a000004        pcalau12i       $a0, 0
    8:   02ffc063        addi.d          $sp, $sp, -16
    c:   02810406        addi.w          $a2, $zero, 65
   10:   02c00084        addi.d          $a0, $a0, 0
   14:   29c02061        st.d            $ra, $sp, 8
   18:   54000000        bl              0       # 18 <early_hostname+0x18>
   1c:   0281000c        addi.w          $t0, $zero, 64
   20:   6c001584        bgeu            $t0, $a0, 20    # 34 <.L2>
   24:   1a000004        pcalau12i       $a0, 0
   28:   02810005        addi.w          $a1, $zero, 64
   2c:   02c00084        addi.d          $a0, $a0, 0
   30:   54000000        bl              0       # 30 <early_hostname+0x30>

0000000000000034 <.L2>:
   34:   28c02061        ld.d            $ra, $sp, 8
   38:   00150004        or              $a0, $zero, $zero
   3c:   02c04063        addi.d          $sp, $sp, 16
   40:   4c000020        jirl            $zero, $ra, 0

A preliminary analysis shows that the common functions is_sibling_call()
and add_jump_destinations() in tools/objtool/check.c need to be modified
to handle the case "reloc->sym->type == STT_NOTYPE", I will send a patch
in the next week.

Thanks,
Tiezhu

