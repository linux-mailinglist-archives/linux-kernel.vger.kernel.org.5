Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303D078C054
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjH2Idq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbjH2IdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:33:21 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D0EBFC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:33:17 -0700 (PDT)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8CxfOpMre1k87EcAA--.31508S3;
        Tue, 29 Aug 2023 16:33:16 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c5Kre1kSFRmAA--.51114S3;
        Tue, 29 Aug 2023 16:33:15 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Define the symbol fault as a local label in
 fpu.S
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <1693290485-3516-1-git-send-email-yangtiezhu@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <63f8c4d8-ee94-4bf0-a0d5-ba5145360514@loongson.cn>
Date:   Tue, 29 Aug 2023 16:33:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1693290485-3516-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx_c5Kre1kSFRmAA--.51114S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr4rZr4fKw18KF15AFyfZrc_yoW8KFWUp3
        srZF4kCr4rWFnIya9xAw1kWrW5GanrGa17W3ZFyryxCrWjgF1qva18JryvqF12qa1fJF40
        qF1rXr9Iq3WDA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
        wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
        CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkU
        UUUU=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-29 14:28, Tiezhu Yang wrote:

> The initial aim is to silence the following objtool warnings:
>
>    arch/loongarch/kernel/fpu.o: warning: objtool: _save_fp_context() falls through to next function fault()
>    arch/loongarch/kernel/fpu.o: warning: objtool: _restore_fp_context() falls through to next function fault()
>    arch/loongarch/kernel/fpu.o: warning: objtool: _save_lsx_context() falls through to next function fault()
>    arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lsx_context() falls through to next function fault()
>    arch/loongarch/kernel/fpu.o: warning: objtool: _save_lasx_context() falls through to next function fault()
>    arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lasx_context() falls through to next function fault()
>
> Obviously, the symbol fault is not a function, it is just a local label,
> so use SYM_CODE_START_LOCAL and SYM_CODE_END to define the symbol fault.
>
> Before:
>
> $ readelf -s arch/loongarch/kernel/fpu.o | awk -F: /fault/'{print $2}'
>   000000000000053c     8 FUNC    GLOBAL DEFAULT    1 fault
>
> After:
>
> $ readelf -s arch/loongarch/kernel/fpu.o | awk -F: /fault/'{print $2}'
>   000000000000053c     8 NOTYPE  LOCAL  DEFAULT    1 fault
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/loongarch/kernel/fpu.S | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
> index b4032de..7defe50 100644
> --- a/arch/loongarch/kernel/fpu.S
> +++ b/arch/loongarch/kernel/fpu.S
> @@ -521,7 +521,7 @@ SYM_FUNC_START(_restore_lasx_context)
>   	jr	ra
>   SYM_FUNC_END(_restore_lasx_context)
>   
> -SYM_FUNC_START(fault)
> +SYM_CODE_START_LOCAL(fault)


Hi, Tiezhu,

The include/linux/linkage.h noted,
  * FUNC -- C-like functions (proper stack frame etc.)
  * CODE -- non-C code (e.g. irq handlers with different, special stack 
etc.)
I think here should be SYM_FUNC_START_LOCAL. Thus, it may create debug
info like sp_offset == 0 && ra == CFI_UNDEFINED, (just some impressions).

BTW, I've noticed some funcs should be marked as SYM_CODE.., e.g.
handle_syscall, handle_tlb_xxx. If you are sure that changes are
necessary, fix them.

Thanks!

Jinyang


>   	li.w	a0, -EFAULT				# failure
>   	jr	ra
> -SYM_FUNC_END(fault)
> +SYM_CODE_END(fault)

