Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA25D7BA1DB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjJEPBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjJEPAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:00:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D547F25247
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:38:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 138CB12FC;
        Thu,  5 Oct 2023 05:42:43 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62FE83F59C;
        Thu,  5 Oct 2023 05:42:03 -0700 (PDT)
Message-ID: <a5cb74e2-86ba-eb49-a8cc-f8778e68bcbc@arm.com>
Date:   Thu, 5 Oct 2023 13:42:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: coresight: Add filename catchall for
 Coresight
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
Cc:     gregkh@linuxfoundation.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, namhyung@kernel.org,
        atrajeev@linux.vnet.ibm.com
References: <20231005084001.34741-1-james.clark@arm.com>
 <CAJ9a7Vhrup63a8+auvacTTNQgXpsuZW-9fex3r=w+JZQs6aXcg@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAJ9a7Vhrup63a8+auvacTTNQgXpsuZW-9fex3r=w+JZQs6aXcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2023 13:08, Mike Leach wrote:
> Won't this also pick up....
> 
> drivers/accel/habanalabs/gaudi/gaudi_coresight.c
> 
> ?
> 
> Which isn't part of anything we maintain
> 

Ah ok I did try to check for other non Arm Coresight files with
Coresight in the name and didn't find any, but I must have missed that one.

I will just explicitly add the missing ones instead.

Although on further inspection it does seem to be related to some Arm
Coresight implementation, although not one that fits in the existing
Perf or Coresight driver framework. So I'm not sure if there could ever
be any sharing of code between the two, maybe not from an initial glance.

> On Thu, 5 Oct 2023 at 09:40, James Clark <james.clark@arm.com> wrote:
>>
>> There are a few files missing from the list like test_arm_coresight.sh
>> and arm-coresight.txt. These could be picked up just with a name match.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 90f13281d297..3ee45066b7e4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2066,6 +2066,7 @@ F:        tools/perf/arch/arm/util/pmu.c
>>  F:     tools/perf/tests/shell/coresight/*
>>  F:     tools/perf/util/cs-etm-decoder/*
>>  F:     tools/perf/util/cs-etm.*
>> +N:     coresight
>>
>>  ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
>>  M:     Hans Ulli Kroll <ulli.kroll@googlemail.com>
>> --
>> 2.34.1
>>
> 
> 
