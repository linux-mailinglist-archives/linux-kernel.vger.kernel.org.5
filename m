Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE8579D072
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjILL5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbjILL5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:57:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9ED9170B;
        Tue, 12 Sep 2023 04:56:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC342C15;
        Tue, 12 Sep 2023 04:57:33 -0700 (PDT)
Received: from [10.57.93.149] (unknown [10.57.93.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 957213F67D;
        Tue, 12 Sep 2023 04:56:54 -0700 (PDT)
Message-ID: <83b8c8d7-d53f-bea7-4ca3-5730d5c80b30@arm.com>
Date:   Tue, 12 Sep 2023 12:57:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Content-Language: en-US
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, juri.lelli@redhat.com
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <6011d8bb-9a3b-1435-30b0-d75b39bf5efa@arm.com>
 <20230907115307.GD10955@noisy.programming.kicks-ass.net>
 <89067f71-9b83-e647-053e-07f7d55b6529@arm.com>
 <20230907132906.GG10955@noisy.programming.kicks-ass.net>
 <5616e50d-b827-4547-5b16-9131ace98419@arm.com>
 <20230907133840.GH10955@noisy.programming.kicks-ass.net>
 <8657cc7c-169b-3479-5919-72bd39335b15@arm.com>
 <7c1cedb5-6342-1bf9-d1a6-3a87f63801fc@redhat.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <7c1cedb5-6342-1bf9-d1a6-3a87f63801fc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 9/8/23 13:51, Daniel Bristot de Oliveira wrote:
> On 9/7/23 15:45, Lukasz Luba wrote:
>>>>> RT literatur mostly methinks. Replacing WCET with a statistical model of
>>>>> sorts is not uncommon, the argument goes that not everybody will have
>>>>> their worst case at the same time and lows and highs can commonly cancel
>>>>> out and this way we can cram a little more on the system.
>>>>>
>>>>> Typically this is proposed in the context of soft-realtime systems.
>>>>
>>>> Thanks Peter, I will dive into some books...
>>>
>>> I would look at academic papers, not sure any of that ever made it to
>>> books, Daniel would know I suppose.
>>
>> Good hint, thanks!
> 
> The key-words that came to my mind are:
> 
> 	- mk-firm, where you accept m tasks will make their deadline
> 	           every k execution - like, because you run too long.
> 	- mixed criticality with pWCET (probabilistic execution time) or
> 		  average execution time + an sporadic tail execution time for
> 		  the low criticality part.
> 
> mk-firm smells like 2005's.. mixed criticality as 2015's..present.
> 
> You will probably find more papers than books. Read the papers
> as a source for inspiration... not necessarily as a definitive
> solution. They generally proposed too restrictive task models.
> 
> -- Daniel
> 

Thanks for describing this context! That would save my time and avoid
maybe sinking in this unknown water. As you said I might tread that
as inspiration, since I don't fight with life-critical system,
but a phone which needs 'nice user experience' (hopefully there are
no people who disagree) ;)

Regards,
Lukasz
