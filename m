Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7904678C0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjH2Iqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjH2Iq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:46:26 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0F0518F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:46:20 -0700 (PDT)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8CxbetbsO1kzrMcAA--.56433S3;
        Tue, 29 Aug 2023 16:46:19 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxWM1asO1kXVZmAA--.53118S3;
        Tue, 29 Aug 2023 16:46:19 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Define the symbol fault as a local label in
 fpu.S
To:     Xi Ruoyao <xry111@xry111.site>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <1693290485-3516-1-git-send-email-yangtiezhu@loongson.cn>
 <b826520103c7462b0c2f10a7bc69347799d1217b.camel@xry111.site>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <6b65d5c4-f648-7a84-bba0-d25e6a9091b6@loongson.cn>
Date:   Tue, 29 Aug 2023 16:46:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b826520103c7462b0c2f10a7bc69347799d1217b.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxWM1asO1kXVZmAA--.53118S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF1rWr48KrW8GF4fGw1fZrc_yoW8uF4fpr
        97ZFWkJrW5uFn3Ja9Fyw4rWry5Jan7J3W5WF1DJFyxCrWUWF1qva18Xr90gFy2qw4rJF1F
        qF1rXryavF4DAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
        xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2NB_UUUUU
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-29 14:45, Xi Ruoyao wrote:

> On Tue, 2023-08-29 at 14:28 +0800, Tiezhu Yang wrote:
>> The initial aim is to silence the following objtool warnings:
>>
>>    arch/loongarch/kernel/fpu.o: warning: objtool: _save_fp_context() falls through to next function fault()
>>    arch/loongarch/kernel/fpu.o: warning: objtool: _restore_fp_context() falls through to next function fault()
>>    arch/loongarch/kernel/fpu.o: warning: objtool: _save_lsx_context() falls through to next function fault()
>>    arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lsx_context() falls through to next function fault()
>>    arch/loongarch/kernel/fpu.o: warning: objtool: _save_lasx_context() falls through to next function fault()
>>    arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lasx_context() falls through to next function fault()
>>
>> Obviously, the symbol fault is not a function, it is just a local label,
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
>>          jr      ra
> _restore_lasx_context returns with this instruction.  How can it fall
> through into fault?

I think it is because objtool will check ex_table. Something special 
here. (in special.c)

So this function control flow reaches another global function, caused 
warning. (Just some impressions)


Thanks,

Jinyang

>
>>   SYM_FUNC_END(_restore_lasx_context)
>> -SYM_FUNC_START(fault)
>> +SYM_CODE_START_LOCAL(fault)
>>          li.w    a0, -EFAULT                             # failure
>>          jr      ra
>> -SYM_FUNC_END(fault)
>> +SYM_CODE_END(fault)

