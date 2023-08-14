Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C7177AFD5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjHNDCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjHNDBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:01:54 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE1EC10D7;
        Sun, 13 Aug 2023 20:01:33 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxV_EMmdlk2t0XAA--.49753S3;
        Mon, 14 Aug 2023 11:01:32 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjiMKmdlkNkNZAA--.48747S3;
        Mon, 14 Aug 2023 11:01:31 +0800 (CST)
Subject: Re: [PATCH] MIPS: Remove noreturn attribute for die()
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <1690887599-11442-1-git-send-email-yangtiezhu@loongson.cn>
 <alpine.DEB.2.21.2308081544180.38537@angie.orcam.me.uk>
 <13aaa917-e55d-f529-8b3f-cab285402808@loongson.cn>
 <alpine.DEB.2.21.2308132148500.8596@angie.orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <17bc8aca-6590-02ac-cb03-95d4b5af1d40@loongson.cn>
Date:   Mon, 14 Aug 2023 11:01:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2308132148500.8596@angie.orcam.me.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxjiMKmdlkNkNZAA--.48747S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1rZFy7JrWDWw13Ary5trc_yoW8CrWkpa
        48Ca9YkanrJa4IkFs2yw4xJa42kF1rGry5Jr95K3ykur15Xr9IyFWxtw4F9Fn2grsagw4q
        qw4jqa4jqa4DAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
        AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
        0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
        UUUUU
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/14/2023 05:30 AM, Maciej W. Rozycki wrote:
> On Wed, 9 Aug 2023, Tiezhu Yang wrote:
>
>>>  So you want to keep a task alive that has caused a kernel oops in the
>>> process context in this case, right?  What purpose would it be for and
>>> what condition causes `notify_die' to return NOTIFY_STOP?  IOW why is
>>> there no need to call `make_task_dead' in this case?
>>
>> I did some research, hope it is useful.

...

>>
>>   This requires making die() and die_if_kernel() return a value,
>>   and their callers to honor this (and be prepared that it returns).
>
>  Thanks, that indeed helps, though indirectly.  I think the most relevant,
> though still terse explanation comes from commit 20c0d2d44029 ("[PATCH]
> i386: pass proper trap numbers to die chain handlers"), which I believe is
> the earliest of similar changes.  The patch was originally submitted here:
> <https://lore.kernel.org/r/43DDF02E.76F0.0078.0@novell.com/> and hardly
> any discussion emerged, but I think the key statement is:
>
> "[...] honor the return value from the handler chain invocation in die()
> as, through a debugger, the fault may have been fixed."
>
> Now it makes sense to me: even if ignoring the event will make the system
> unstable, by allowing access through a debugger it has been compromised
> already anyway.
>
>  So I think your change will be good if you update the change description
> to include the justification quoted above rather than just: "the others do
> it too, so it must be good" (though you can of course mention that your
> change also makes our port consistent with other ones).  I suggest linking
> to the original i386 submission too for future reference.

Thank you very much.

>
>  Also I note that you combine three independent changes into one, so
> please split it into individual patches as per our requirements.
>

Will do it in v2.

Thanks,
Tiezhu

