Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9269078C460
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjH2Mkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbjH2MkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:40:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56E27D7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:40:19 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Axueox5+1k3sIcAA--.48856S3;
        Tue, 29 Aug 2023 20:40:17 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXSMw5+1kqXdmAA--.32801S3;
        Tue, 29 Aug 2023 20:40:17 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Define the symbol fault as a local label in
 fpu.S
To:     Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>
References: <1693290485-3516-1-git-send-email-yangtiezhu@loongson.cn>
 <b826520103c7462b0c2f10a7bc69347799d1217b.camel@xry111.site>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a4bd839b-d55e-07e5-67a5-016d77f77112@loongson.cn>
Date:   Tue, 29 Aug 2023 20:40:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <b826520103c7462b0c2f10a7bc69347799d1217b.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxXSMw5+1kqXdmAA--.32801S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF4DAry3Jw4xKrW7Wry8Zwc_yoWrtF1UpF
        yUAFWvkrWrWF93Ja9rtws5CrZ8KanrGw1293Z8JrWxCFWjgF1qva18trWDXF12qw43JF1F
        qa1FqrWSq3WUA3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
        xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
        AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vApUUU
        UUU==
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/29/2023 02:45 PM, Xi Ruoyao wrote:
> On Tue, 2023-08-29 at 14:28 +0800, Tiezhu Yang wrote:
>> The initial aim is to silence the following objtool warnings:
>>
>>   arch/loongarch/kernel/fpu.o: warning: objtool: _save_fp_context() falls through to next function fault()
>>   arch/loongarch/kernel/fpu.o: warning: objtool: _restore_fp_context() falls through to next function fault()
>>   arch/loongarch/kernel/fpu.o: warning: objtool: _save_lsx_context() falls through to next function fault()
>>   arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lsx_context() falls through to next function fault()
>>   arch/loongarch/kernel/fpu.o: warning: objtool: _save_lasx_context() falls through to next function fault()
>>   arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lasx_context() falls through to next function fault()
>>
>> Obviously, the symbol fault is not a function, it is just a local label,
>
> Hmm why?  To me this seems a function.  We don't branch to it but store
> its address (a "function pointer") in the extable.
>
> And these warnings do not make any sense to me:
>
> /* snip */
>
>> diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
>> index b4032de..7defe50 100644
>> --- a/arch/loongarch/kernel/fpu.S
>> +++ b/arch/loongarch/kernel/fpu.S
>> @@ -521,7 +521,7 @@ SYM_FUNC_START(_restore_lasx_context)
>>         jr      ra
>
> _restore_lasx_context returns with this instruction.  How can it fall
> through into fault?
>
>>  SYM_FUNC_END(_restore_lasx_context)
>
>> -SYM_FUNC_START(fault)
>> +SYM_CODE_START_LOCAL(fault)
>>         li.w    a0, -EFAULT                             # failure
>>         jr      ra
>> -SYM_FUNC_END(fault)
>> +SYM_CODE_END(fault)
>

In the current code, SYM_FUNC_END() defines the symbol as SYM_T_FUNC
which is STT_FUNC, the objtool warnings are generated through the
following code.

arch/loongarch/include/asm/linkage.h
#define SYM_FUNC_END(name)				\
	.cfi_endproc;					\
	SYM_END(name, SYM_T_FUNC)

include/linux/linkage.h
/* SYM_T_FUNC -- type used by assembler to mark functions */
#ifndef SYM_T_FUNC
#define SYM_T_FUNC				STT_FUNC
#endif

tools/objtool/include/objtool/check.h
static inline struct symbol *insn_func(struct instruction *insn)
{
	struct symbol *sym = insn->sym;

	if (sym && sym->type != STT_FUNC)
		sym = NULL;

	return sym;
}

tools/objtool/check.c
static int validate_branch(struct objtool_file *file, struct symbol *func,
			   struct instruction *insn, struct insn_state state)
{
...
	while (1) {
		next_insn = next_insn_to_validate(file, insn);

		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
			/* Ignore KCFI type preambles, which always fall through */
			if (!strncmp(func->name, "__cfi_", 6) ||
			    !strncmp(func->name, "__pfx_", 6))
				return 0;

			WARN("%s() falls through to next function %s()",
			     func->name, insn_func(insn)->name);
			return 1;
		}
...
}

We can see that the fixup can be a local label in the following code.

arch/loongarch/include/asm/asm-extable.h
#define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
	.pushsection	__ex_table, "a";		\
	.balign		4;				\
	.long		((insn) - .);			\
	.long		((fixup) - .);			\
	.short		(type);				\
	.short		(data);				\
	.popsection;

	.macro		_asm_extable, insn, fixup
	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP, 0)
	.endm

Like arch/loongarch/lib/*.S does, I prefer the following changes,
if you are ok, I will send v2 later.

diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
index b4032deb8e3b..3177725ea832 100644
--- a/arch/loongarch/kernel/fpu.S
+++ b/arch/loongarch/kernel/fpu.S
@@ -22,7 +22,7 @@

         .macro  EX insn, reg, src, offs
  .ex\@: \insn   \reg, \src, \offs
-       _asm_extable .ex\@, fault
+       _asm_extable .ex\@, .L_fixup_fpu_fault
         .endm

         .macro sc_save_fp base
@@ -521,7 +521,6 @@ SYM_FUNC_START(_restore_lasx_context)
         jr      ra
  SYM_FUNC_END(_restore_lasx_context)

-SYM_FUNC_START(fault)
+.L_fixup_fpu_fault:
         li.w    a0, -EFAULT                             # failure
         jr      ra
-SYM_FUNC_END(fault)
diff --git a/arch/loongarch/kernel/lbt.S b/arch/loongarch/kernel/lbt.S
index ecf08bbff650..402eb8ec4024 100644
--- a/arch/loongarch/kernel/lbt.S
+++ b/arch/loongarch/kernel/lbt.S
@@ -16,7 +16,7 @@

         .macro  EX insn, reg, src, offs
  .ex\@: \insn   \reg, \src, \offs
-       _asm_extable .ex\@, lbt_fault
+       _asm_extable .ex\@, .L_fixup_lbt_fault
         .endm

  /*
@@ -150,7 +150,6 @@ SYM_FUNC_START(_restore_ftop_context)
         jr              ra
  SYM_FUNC_END(_restore_ftop_context)

-SYM_FUNC_START(lbt_fault)
+.L_fixup_lbt_fault:
         li.w            a0, -EFAULT             # failure
         jr              ra
-SYM_FUNC_END(lbt_fault)

Thanks,
Tiezhu

