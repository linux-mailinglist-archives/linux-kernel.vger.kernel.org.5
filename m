Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411927816C9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 04:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244288AbjHSCoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 22:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244285AbjHSCoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:44:12 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63AA53ABC;
        Fri, 18 Aug 2023 19:44:09 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxDOt3LOBklg0aAA--.48136S3;
        Sat, 19 Aug 2023 10:44:07 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF8xxLOBkSRVeAA--.59155S3;
        Sat, 19 Aug 2023 10:44:01 +0800 (CST)
Subject: Re: [PATCH v3 2/3] MIPS: Remove noreturn attribute for die()
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <1692005246-18399-1-git-send-email-yangtiezhu@loongson.cn>
 <1692005246-18399-3-git-send-email-yangtiezhu@loongson.cn>
 <alpine.DEB.2.21.2308180231290.8596@angie.orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <efc0eacb-195a-9587-8315-15a31ae9bedd@loongson.cn>
Date:   Sat, 19 Aug 2023 10:44:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2308180231290.8596@angie.orcam.me.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxF8xxLOBkSRVeAA--.59155S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur1UCFyrWrW5ZF4kXF1fGrX_yoW5trWUp3
        yjkayjkryDJFn2qryvyw1xJayjyr98J3y2kw1v9ayFka43Z34rWr97KrWF9a1rtr1vgayj
        qr4jqwsxuFZrAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
        6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5xhLUUUUU=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/18/2023 10:41 AM, Maciej W. Rozycki wrote:
> On Mon, 14 Aug 2023, Tiezhu Yang wrote:
>
>> If notify_die() returns NOTIFY_STOP, honor the return value from the
>> handler chain invocation in die() as, through a debugger, the fault
>> may have been fixed. It makes sense even if ignoring the event will
>> make the system unstable, by allowing access through a debugger it
>> has been compromised already anyway. So we can remove the noreturn
>> attribute for die() to make our port consistent with x86, arm64,
>> riscv and csky.
>
>  I find it weird that you say that it is specifically the removal of the
> `noreturn' attribute that makes our port consistent with the other ones
> (and make it the change heading too).  I don't think you need to mention
> the removal of `noreturn' even as you can see it in the code itself and
> it's a natural consequence of the change proper.  How about:
>
> "
> MIPS: Do not kill the task in die() if notify_die() returns NOTIFY_STOP
>
> If notify_die() returns NOTIFY_STOP, honor the return value from the
> handler chain invocation in die() and return without killing the task
> as, through a debugger, the fault may have been fixed. It makes sense
> even if ignoring the event will make the system unstable: by allowing
> access through a debugger it has been compromised already anyway. It
> makes our port consistent with x86, arm64, riscv and csky.
> "
>
> then (notice the use of a colon rather than a comma changing the meaning
> of the sentence above)?

OK, it looks better.

>
>> Commit 20c0d2d44029 ("[PATCH] i386: pass proper trap numbers to die
>> chain handlers") may be the earliest of similar changes.
>>
>> Link: https://lore.kernel.org/all/alpine.DEB.2.21.2308132148500.8596@angie.orcam.me.uk/
>
>  I think you meant:
>
> Link: https://lore.kernel.org/r/43DDF02E.76F0.0078.0@novell.com/
>
> didn't you?

Yes, I will update it in v4.

>
>> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
>> index 7a34674..4f5140f 100644
>> --- a/arch/mips/kernel/traps.c
>> +++ b/arch/mips/kernel/traps.c
>> @@ -391,16 +391,15 @@ void show_registers(struct pt_regs *regs)
>>
>>  static DEFINE_RAW_SPINLOCK(die_lock);
>>
>> -void __noreturn die(const char *str, struct pt_regs *regs)
>> +void die(const char *str, struct pt_regs *regs)
>>  {
>>  	static int die_counter;
>> -	int sig = SIGSEGV;
>> +	int ret;
>>
>>  	oops_enter();
>>
>> -	if (notify_die(DIE_OOPS, str, regs, 0, current->thread.trap_nr,
>> -		       SIGSEGV) == NOTIFY_STOP)
>> -		sig = 0;
>> +	ret = notify_die(DIE_OOPS, str, regs, 0,
>> +			 current->thread.trap_nr, SIGSEGV);
>>
>>  	console_verbose();
>>  	raw_spin_lock_irq(&die_lock);
>> @@ -422,7 +421,8 @@ void __noreturn die(const char *str, struct pt_regs *regs)
>>  	if (regs && kexec_should_crash(current))
>>  		crash_kexec(regs);
>>
>> -	make_task_dead(sig);
>> +	if (ret != NOTIFY_STOP)
>> +		make_task_dead(SIGSEGV);
>
>  It doesn't appear to me we should panic or execute the crash kernel if
> the oops is to be suppressed.  Can we just do what the x86 port does, that
> is return if !sig after the call to `oops_exit'?

Yes, I think so, I will add a separate patch to do this.

>
>  Also I note that the individual ports aren't exactly consistent here with
> respect to each other, so maybe that's something you might want to post a
> combined follow-up clean-up patch series for too?
>

Maybe do it someday if possible.

Thanks,
Tiezhu

