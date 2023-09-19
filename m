Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E807A6914
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjISQmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjISQmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:42:09 -0400
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CEAD6;
        Tue, 19 Sep 2023 09:42:02 -0700 (PDT)
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1qidmu-002SbU-Ay; Tue, 19 Sep 2023 16:41:24 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1qidmr-00FzAL-KO; Tue, 19 Sep 2023 17:41:23 +0100
Message-ID: <de98424d-41f9-90f9-742d-623e2b55c564@cambridgegreys.com>
Date:   Tue, 19 Sep 2023 17:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Arches that don't support PREEMPT
Content-Language: en-US
To:     Richard Weinberger <richard@nod.at>
Cc:     tglx <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        torvalds <torvalds@linux-foundation.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, x86 <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, bp <bp@alien8.de>,
        dave hansen <dave.hansen@linux.intel.com>, hpa <hpa@zytor.com>,
        mingo <mingo@redhat.com>, juri lelli <juri.lelli@redhat.com>,
        vincent guittot <vincent.guittot@linaro.org>, mgorman@suse.de,
        Steven Rostedt <rostedt@goodmis.org>,
        jon grimm <jon.grimm@amd.com>, bharata@amd.com,
        raghavendra kt <raghavendra.kt@amd.com>,
        boris ostrovsky <boris.ostrovsky@oracle.com>,
        konrad wilk <konrad.wilk@oracle.com>, jgross <jgross@suse.com>,
        andrew cooper3 <andrew.cooper3@citrix.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        linux-alpha <linux-alpha@vger.kernel.org>
References: <87zg1u1h5t.fsf@oracle.com> <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com>
 <87y1h2ur98.ffs@tglx>
 <9a5c0856-d542-9912-7494-53d7fe4538a3@cambridgegreys.com>
 <551475267.58816.1695140566849.JavaMail.zimbra@nod.at>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <551475267.58816.1695140566849.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 19/09/2023 17:22, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "anton ivanov" <anton.ivanov@cambridgegreys.com>
>> It's been a while. I remember that I dropped it at the time, but do not remember
>> the full details.
>>
>> There was some stuff related to FP state and a few other issues I ran into while
>> rewriting the interrupt controller. Some of it may be resolved by now as we are
>> using host cpu flags, etc.
> 
> I remember also having a hacky but working version almost 10 years ago.
> It was horrible slow because of the extra scheduler rounds.
> But yes, if PREEMPT will be a must-have feature we'll have to try again.

We will need proper fpu primitives for starters that's for sure. fpu_star/end in UML are presently NOOP.

Some of the default spinlocks and other stuff which we pick up from generic may need to change as well.

This is off the top of my head and something which we can fix straight away. I will send some patches to the mailing list tomorrow or on Thu.

A.

> 
> Thanks,
> //richard
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
