Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FD977F458
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349914AbjHQKdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349903AbjHQKdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:33:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACB8E2D54
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:33:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FDFAD75;
        Thu, 17 Aug 2023 03:34:10 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3A323F64C;
        Thu, 17 Aug 2023 03:33:27 -0700 (PDT)
Message-ID: <e3782710-e631-6b5b-8bbc-568e37131c90@arm.com>
Date:   Thu, 17 Aug 2023 11:33:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] coresight: trbe: Allocate platform data per device
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>, hejunhao3@huawei.com
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jonathan.cameron@huawei.com,
        leo.yan@linaro.org, mike.leach@linaro.org, linuxarm@huawei.com,
        yangyicong@huawei.com, prime.zeng@hisilicon.com
References: <20230814093813.19152-1-hejunhao3@huawei.com>
 <20230816141008.535450-1-suzuki.poulose@arm.com>
 <20230816141008.535450-2-suzuki.poulose@arm.com>
 <9cd9f83c-7778-2d87-a175-a4cb7ceb8723@arm.com>
 <3f681660-a0f0-20cb-b79b-7b2e2f6a1b5c@arm.com>
 <d3a75551-8027-c95c-f83b-468877daf93d@arm.com>
 <f8f8ce42-889c-9a6b-5f74-121bd9dc09b1@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <f8f8ce42-889c-9a6b-5f74-121bd9dc09b1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 11:16, Anshuman Khandual wrote:
> 
> 
> On 8/17/23 15:31, Suzuki K Poulose wrote:
>> On 17/08/2023 10:24, James Clark wrote:
>>>
>>>
>>> On 17/08/2023 07:37, Anshuman Khandual wrote:
>>>> Hi Suzuki,
>>>>
>>>> Seems like this patch is going to conflict with the below proposed change
>>>>
>>>> https://lore.kernel.org/all/20230817055405.249630-4-anshuman.khandual@arm.com/
>>>>
>>>> Please let me know how should we resolve this conflict.
>>>
>>> We could merge them both, with the fixes: one first, just to acknowledge
>>> that there was a problem. But I suppose your one will have to be rebased
>>> on top.
>>>
>>>>
>>>> On 8/16/23 19:40, Suzuki K Poulose wrote:
>>>>> Coresight TRBE driver shares a single platform data (which is empty btw).
>>>>> However, with the commit 4e8fe7e5c3a5
>>>>> ("coresight: Store pointers to connections rather than an array of them")
>>>>> the coresight core would free up the pdata, resulting in multiple attempts
>>>>> to free the same pdata for TRBE instances. Fix this by allocating a pdata per
>>>>> coresight_device.
>>>>>
>>>>> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
>>>>
>>>> The above mentioned commit i.e 4e8fe7e5c3a5 seems to be a more recent one which
>>>> has triggered this problem. But would the problem be still there without that ?
>>>> Else 'Fixes:' tag would need changing.
>>>>
>>>
>>> Yes I think the fixes tag should point to 4e8fe7e5c3a5.
>>
>> Agreed, I will change the fixes tag and push this.
> 
> In the first patch, the last hunk might not be required to fix the
> IPI problem and in fact might be bit problematic as well. Besides,

Please could you comment your concerns on the patch ?

Suzuki

> could you please hold off pushing this change into coresight tree
> for some time ?

