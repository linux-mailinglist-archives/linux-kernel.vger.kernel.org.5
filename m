Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C0D7816BB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 04:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243869AbjHSCi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 22:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjHSCiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:38:06 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 829DB1BB;
        Fri, 18 Aug 2023 19:38:03 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cxh+gJK+BkYQ0aAA--.17781S3;
        Sat, 19 Aug 2023 10:38:01 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxvM4IK+BkTRReAA--.33690S3;
        Sat, 19 Aug 2023 10:38:00 +0800 (CST)
Subject: Re: [PATCH v3 1/3] MIPS: Remove noreturn attribute for
 nmi_exception_handler()
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <1692005246-18399-1-git-send-email-yangtiezhu@loongson.cn>
 <1692005246-18399-2-git-send-email-yangtiezhu@loongson.cn>
 <alpine.DEB.2.21.2308180227580.8596@angie.orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d2a56d80-d71c-30e5-c001-13aa503398f3@loongson.cn>
Date:   Sat, 19 Aug 2023 10:38:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2308180227580.8596@angie.orcam.me.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxvM4IK+BkTRReAA--.33690S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur1fZw1Duw1xGFWkWr1rAFc_yoW8Xw18pF
        yFkFyDCr1qy3WF9an7Jrnag343Zrs7Ar4UtF1vqr90y3yjqwsakF4rKa40gF90gw1fK3Wj
        qF48XwsIyryqyFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
        AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUU
        UUU==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/18/2023 10:39 AM, Maciej W. Rozycki wrote:
> On Mon, 14 Aug 2023, Tiezhu Yang wrote:
>
>> In the later patch, we will remove noreturn attribute for die(), in order
>> to make each patch can be built without errors and warnings, just remove
>> noreturn attribute for nmi_exception_handler() earlier because it calls
>> die(), otherwise there exists the following build error after the later
>> patch:
>
>  I find the wording a bit odd here, but you'll have to rewrite the change
> description for the update requested below, so let's defer any style fixes
> to v4.
>
>>   arch/mips/kernel/traps.c:2001:1: error: 'noreturn' function does return [-Werror]
>
>  Now that I've looked into it in detail, this change is incomplete and
> will make the kernel go astray if `nmi_exception_handler' actually ever
> does return.  See code in arch/mips/kernel/genex.S, which calls this
> function and doesn't expect it to return.  It has to be fixed before 2/3
> can be considered.  I wonder how you didn't catch it: you did check how
> this code is used, didn't you?
>

I think the proper way is to keep the noreturn attribute for
nmi_exception_handler(), and add a noreturn function BUG() at
the end of nmi_exception_handler() to make sure it does not
return.

>  Before submitting an updated version can you actually arrange for the
> NOTIFY_STOP condition to happen in your lab and verify it is handled as
> expected?  And what was the motivation for this code update, just a
> hypothetical scenario?

Yes, just a hypothetical scenario.

Thanks,
Tiezhu

