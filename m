Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39877F6290
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346025AbjKWPS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345997AbjKWPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:18:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26460C1;
        Thu, 23 Nov 2023 07:19:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B41E12FC;
        Thu, 23 Nov 2023 07:19:46 -0800 (PST)
Received: from [10.57.4.190] (unknown [10.57.4.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0667D3F6C4;
        Thu, 23 Nov 2023 07:18:58 -0800 (PST)
Message-ID: <5fd9ce52-9216-47ae-9ed3-fabb0f3b02fd@arm.com>
Date:   Thu, 23 Nov 2023 15:19:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Minor cleanup for thermal gov power allocator
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com
References: <20231025192225.468228-1-lukasz.luba@arm.com>
 <CAJZ5v0gniBtFduwjhDku+OZzjvkCaFK7ew0uJTfW254XKTOyyw@mail.gmail.com>
 <ce8f1a13-b56f-4419-a954-8d987af44112@arm.com>
In-Reply-To: <ce8f1a13-b56f-4419-a954-8d987af44112@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Gentle ping

On 10/26/23 13:22, Lukasz Luba wrote:
> 
> 
> On 10/26/23 09:54, Rafael J. Wysocki wrote:
>> On Wed, Oct 25, 2023 at 9:21 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>> Hi all,
>>>
>>> The patch set does some small clean up for Intelligent Power Allocator.
>>> Those changes are not expected to alter the general functionality. 
>>> They just
>>> improve the code reading. Only patch 3/7 might improve the use case for
>>> binding the governor to thermal zone (very unlikely in real products, 
>>> but
>>> it's needed for correctness).
>>>
>>> The changes are based on top of current PM thermal branch, so with the
>>> new trip points.
>>>
>>> Regards,
>>> Lukasz
>>>
>>> Lukasz Luba (7):
>>>    thermal: gov_power_allocator: Rename trip_max_desired_temperature
>>>    thermal: gov_power_allocator: Setup trip points earlier
>>>    thermal: gov_power_allocator: Check the cooling devices only for
>>>      trip_max
>>>    thermal: gov_power_allocator: Rearrange the order of variables
>>>    thermal: gov_power_allocator: Use shorter variable when possible
>>>    thermal: gov_power_allocator: Remove unneeded local variables
>>>    thermal: gov_power_allocator: Clean needed variables at the beginning
>>>
>>>   drivers/thermal/gov_power_allocator.c | 123 ++++++++++++++------------
>>>   1 file changed, 64 insertions(+), 59 deletions(-)
>>>
>>> -- 
>>
>> The series looks good to me overall, but I'd prefer to make these
>> changes in the 6.8 cycle, because the 6.7 merge window is around the
>> corner and there is quite a bit of thermal material in this cycle
>> already.
> 
> Thanks for having a look! Yes, I agree, we can wait after the
> merge window. It just have to be cleaned one day a bit and I postponed
> this a few times, so no rush ;)

I've seen you've created the new pm/thermal. Could you consider to take
those in, please?

I would send some RFC on top showing the issue with reading back the CPU
max frequency from the PM_QoS chain.

Regards,
Lukasz
