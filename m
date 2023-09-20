Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9C37A8752
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbjITOlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbjITOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:41:11 -0400
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619231BDC;
        Wed, 20 Sep 2023 07:40:28 -0700 (PDT)
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1qiyLd-002W2U-3v; Wed, 20 Sep 2023 14:38:37 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1qiyLa-00HNGo-By; Wed, 20 Sep 2023 15:38:36 +0100
Message-ID: <159b79fc-16d8-2d12-ed17-fb508879d791@cambridgegreys.com>
Date:   Wed, 20 Sep 2023 15:38:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Arches that don't support PREEMPT
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
References: <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <20230919141627.GB39281@noisy.programming.kicks-ass.net>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20230919141627.GB39281@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -2.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/09/2023 15:16, Peter Zijlstra wrote:
> On Tue, Sep 19, 2023 at 03:48:09PM +0200, John Paul Adrian Glaubitz wrote:
>> On Tue, 2023-09-19 at 15:42 +0200, Peter Zijlstra wrote:
>>>> The agreement to kill off ia64 wasn't an invitation to kill off other stuff
>>>> that people are still working on! Can we please not do this?
>>>
>>> If you're working on one of them, then surely it's a simple matter of
>>> working on adding CONFIG_PREEMPT support :-)
>>
>> As Geert poined out, I'm not seeing anything particular problematic with the
>> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
>> something about organizing KConfig files.
> 
> The plan in the parent thread is to remove PREEMPT_NONE and
> PREEMPT_VOLUNTARY and only keep PREEMPT_FULL.
> 
>> I find it a bit unfair that maintainers of architectures that have huge companies
>> behind them use their manpower to urge less popular architectures for removal just
>> because they don't have 150 people working on the port so they can keep up with
>> design changes quickly.
> 
> PREEMPT isn't something new. Also, I don't think the arch part for
> actually supporting it is particularly hard, mostly it is sticking the
> preempt_schedule_irq() call in return from interrupt code path.

That calls local_irq_enable() which does various signal related/irq pending work on UML. That in turn does no like being invoked again (as you may have already been invoked out of that) in the IRQ return path.

So it is likely to end up being slightly more difficult than that for UML - it will need to be wrapped so it can be invoked from the "host" side signal code as well as invoked with some additional checks to avoid making a hash out of the IRQ handling.

It may be necessary to modify some of the existing reentrancy prevention logic in the signal handlers as well and change it to make use of the preempt count instead of its own flags/counters.

> 
> If you convert the arch to generic-entry (a much larger undertaking)
> then you get this for free.
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
