Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75267CFC7B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345795AbjJSO17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjJSO15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:27:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECDADB0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:27:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBF582F4;
        Thu, 19 Oct 2023 07:28:35 -0700 (PDT)
Received: from [10.57.81.37] (unknown [10.57.81.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EF713F762;
        Thu, 19 Oct 2023 07:27:51 -0700 (PDT)
Message-ID: <0de4ce43-bba5-4a6a-929a-7dc9bfea79cd@arm.com>
Date:   Thu, 19 Oct 2023 15:28:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/25] timer: Move from a push remote at enqueue to a
 pull at expiry model
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <1891aa6c-037f-46a1-9584-17aaa63e4e74@arm.com> <87fs26909o.fsf@somnus>
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <87fs26909o.fsf@somnus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/23 15:04, Anna-Maria Behnsen wrote:
> Hi Lukasz,
> 
> Lukasz Luba <lukasz.luba@arm.com> writes:
> 
> [...]
> 
>>
>> I have tested this on my 2 Arm boards with mainline kernel
>> and almost-mainline. On both platforms it looks stable.
>> The results w/ your patchset looks better.
>>
> 
> Thanks for testing!

You're welcome


> 
> [...]
> 
>> The performance looks good. Only one test 'Speedometer'
>> has some interesting lower score.
> 
> Is it required to look into this more detailed or is the regression in a
> acceptable range for you?

That's something which we can ignore. I have tested with a different
cpu idle governor and it goes away. So, I suspect that the governor
heuristic just probably was confused. I will spend some time on
different idle governor tuning.

Feel free to go forward with this patch set.

> 
>>
>> Fill free to add:
>>
>> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Thanks,
> 
> 	Anna-Maria
> 
