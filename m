Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3630F797B98
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbjIGSWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241923AbjIGSV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:21:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E368B4;
        Thu,  7 Sep 2023 11:21:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 897A4175A;
        Thu,  7 Sep 2023 06:33:52 -0700 (PDT)
Received: from [10.57.92.126] (unknown [10.57.92.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00AE03F766;
        Thu,  7 Sep 2023 06:33:12 -0700 (PDT)
Message-ID: <5616e50d-b827-4547-5b16-9131ace98419@arm.com>
Date:   Thu, 7 Sep 2023 14:33:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qyousef@layalina.io>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <6011d8bb-9a3b-1435-30b0-d75b39bf5efa@arm.com>
 <20230907115307.GD10955@noisy.programming.kicks-ass.net>
 <89067f71-9b83-e647-053e-07f7d55b6529@arm.com>
 <20230907132906.GG10955@noisy.programming.kicks-ass.net>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230907132906.GG10955@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/23 14:29, Peter Zijlstra wrote:
> On Thu, Sep 07, 2023 at 02:06:15PM +0100, Lukasz Luba wrote:
> 
>>> Many extentions to the periodic task model are possible, including
>>> things like average runtime with bursts etc.. all have their trade-offs.
>>
>> Was that maybe proposed somewhere on LKML (the other models)?
> 
> RT literatur mostly methinks. Replacing WCET with a statistical model of
> sorts is not uncommon, the argument goes that not everybody will have
> their worst case at the same time and lows and highs can commonly cancel
> out and this way we can cram a little more on the system.
> 
> Typically this is proposed in the context of soft-realtime systems.

Thanks Peter, I will dive into some books...
