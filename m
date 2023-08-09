Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A720775660
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjHIJaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHIJaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:30:15 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0732210F6;
        Wed,  9 Aug 2023 02:30:12 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxyOijXNNklrYTAA--.7213S3;
        Wed, 09 Aug 2023 17:30:11 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF8yhXNNk7hJRAA--.32120S3;
        Wed, 09 Aug 2023 17:30:10 +0800 (CST)
Subject: Re: [PATCH] MIPS: Remove noreturn attribute for die()
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <1690887599-11442-1-git-send-email-yangtiezhu@loongson.cn>
 <alpine.DEB.2.21.2308081544180.38537@angie.orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <13aaa917-e55d-f529-8b3f-cab285402808@loongson.cn>
Date:   Wed, 9 Aug 2023 17:30:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2308081544180.38537@angie.orcam.me.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxF8yhXNNk7hJRAA--.32120S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFyUGr1xJr47Gry8JryxJFc_yoW8Ww4kpa
        yrKFWSyws09FnIvr4qvr4rXa4YkrWftw45tryfurZYyw1Yvw4kAFZagw1SqF4rJr1I934q
        gF4vq3W3AFZ7AacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
        1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
        Z7UUUUU==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2023 10:54 PM, Maciej W. Rozycki wrote:
> On Tue, 1 Aug 2023, Tiezhu Yang wrote:
>
>> If notify_die() returns NOTIFY_STOP, there is no need to call
>> make_task_dead(), we can remove noreturn attribute for die(),
>> this is similar with arm64, riscv and csky.
>
>  So you want to keep a task alive that has caused a kernel oops in the
> process context in this case, right?  What purpose would it be for and
> what condition causes `notify_die' to return NOTIFY_STOP?  IOW why is
> there no need to call `make_task_dead' in this case?
>
>   Maciej
>

I did some research, hope it is useful.

There is a related description in Documentation/input/notifier.rst:

   For each kind of event but the last, the callback may return
   NOTIFY_STOP in order to "eat" the event: the notify loop is
   stopped and the keyboard event is dropped.

In commit 748f2edb5271 ("x86 NMI: better support for debuggers"), it said:

   If the notify is handled with a NOTIFY_STOP return, the
   system is given a new lease on life.

In commit 004429956b48 ("handle recursive calls to bust_spinlocks()"),
it said:

   However, at least on i386 die() has been capable of returning
   (and on other architectures this should really be that way, too)
   when notify_die() returns NOTIFY_STOP.

In commit 22f5991c85de ("x86-64: honor notify_die() returning NOTIFY_STOP"),
it said:

   This requires making die() return a value, making its callers honor
   this (and be prepared that it may return)

In commit 620de2f5dc69 ("[IA64] honor notify_die() returning NOTIFY_STOP"),
it said:

   This requires making die() and die_if_kernel() return a value,
   and their callers to honor this (and be prepared that it returns).

Thanks,
Tiezhu

