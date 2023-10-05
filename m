Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E86C7BA16B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbjJEOly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjJEOhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 007327ABE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:03:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 605791595;
        Thu,  5 Oct 2023 05:57:00 -0700 (PDT)
Received: from [10.57.2.226] (unknown [10.57.2.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 367153F641;
        Thu,  5 Oct 2023 05:56:20 -0700 (PDT)
Message-ID: <2c0547a7-9d55-bfc9-cd3f-02f4f8b0308b@arm.com>
Date:   Thu, 5 Oct 2023 13:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: coresight: Add filename catchall for
 Coresight
To:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     gregkh@linuxfoundation.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        namhyung@kernel.org, atrajeev@linux.vnet.ibm.com,
        Oded Gabbay <ogabbay@kernel.org>
References: <20231005084001.34741-1-james.clark@arm.com>
 <CAJ9a7Vhrup63a8+auvacTTNQgXpsuZW-9fex3r=w+JZQs6aXcg@mail.gmail.com>
 <a5cb74e2-86ba-eb49-a8cc-f8778e68bcbc@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <a5cb74e2-86ba-eb49-a8cc-f8778e68bcbc@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2023 13:42, James Clark wrote:
> 
> 
> On 05/10/2023 13:08, Mike Leach wrote:
>> Won't this also pick up....
>>
>> drivers/accel/habanalabs/gaudi/gaudi_coresight.c
>>
>> ?
>>
>> Which isn't part of anything we maintain
>>
> 
> Ah ok I did try to check for other non Arm Coresight files with
> Coresight in the name and didn't find any, but I must have missed that one.
> 
> I will just explicitly add the missing ones instead.
> 
> Although on further inspection it does seem to be related to some Arm
> Coresight implementation, although not one that fits in the existing

True, indeed it is hand written code sequence that we do for the
normal CoreSight components. The access to the components looks a bit
convoluted. However, with the coresight_access abstraction we have,
it is possible to abstract it away and move the driver framework to
CoreSight drivers.

> Perf or Coresight driver framework. So I'm not sure if there could ever
> be any sharing of code between the two, maybe not from an initial glance.

Nothing that we could do at the moment without support from the
habana labs folks.

Suzuki

> 
>> On Thu, 5 Oct 2023 at 09:40, James Clark <james.clark@arm.com> wrote:
>>>
>>> There are a few files missing from the list like test_arm_coresight.sh
>>> and arm-coresight.txt. These could be picked up just with a name match.
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>>   MAINTAINERS | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 90f13281d297..3ee45066b7e4 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2066,6 +2066,7 @@ F:        tools/perf/arch/arm/util/pmu.c
>>>   F:     tools/perf/tests/shell/coresight/*
>>>   F:     tools/perf/util/cs-etm-decoder/*
>>>   F:     tools/perf/util/cs-etm.*
>>> +N:     coresight
>>>
>>>   ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
>>>   M:     Hans Ulli Kroll <ulli.kroll@googlemail.com>
>>> --
>>> 2.34.1
>>>
>>
>>

