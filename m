Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791857E67A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjKIKQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjKIKPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:15:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C6983592;
        Thu,  9 Nov 2023 02:15:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D6F91063;
        Thu,  9 Nov 2023 02:16:02 -0800 (PST)
Received: from [10.1.36.59] (e127643.arm.com [10.1.36.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74F2E3F703;
        Thu,  9 Nov 2023 02:15:15 -0800 (PST)
Message-ID: <1196a091-0af1-1658-338e-dba981d94ec3@arm.com>
Date:   Thu, 9 Nov 2023 10:15:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [EXT] Re: [PATCH 5/7] coresight: tmc: Add support for reading
 tracedata from previous boot
To:     Linu Cherian <lcherian@marvell.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Anil Kumar Reddy H <areddy3@marvell.com>
References: <20230929133754.857678-1-lcherian@marvell.com>
 <20230929133754.857678-6-lcherian@marvell.com>
 <acc2a406-2cff-eb3b-7661-1a93d4749bf2@arm.com>
 <9b519a19-548c-dec0-ed69-52695ff12a69@arm.com>
 <PH0PR18MB50021A139FE779A51257C41BCECDA@PH0PR18MB5002.namprd18.prod.outlook.com>
 <CO3PR18MB500522338168207AA463A642CEAFA@CO3PR18MB5005.namprd18.prod.outlook.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CO3PR18MB500522338168207AA463A642CEAFA@CO3PR18MB5005.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/2023 01:08, Linu Cherian wrote:
> Hi James,
> 
>> -----Original Message-----
>> From: Linu Cherian <lcherian@marvell.com>
>> Sent: Tuesday, October 10, 2023 6:53 PM
>> To: James Clark <james.clark@arm.com>; suzuki.poulose@arm.com;
>> mike.leach@linaro.org; leo.yan@linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org; coresight@lists.linaro.org; linux-
>> kernel@vger.kernel.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> devicetree@vger.kernel.org; Sunil Kovvuri Goutham
>> <sgoutham@marvell.com>; George Cherian <gcherian@marvell.com>; Anil
>> Kumar Reddy H <areddy3@marvell.com>
>> Subject: RE: [EXT] Re: [PATCH 5/7] coresight: tmc: Add support for reading
>> tracedata from previous boot
>>
>> Hi James,
>>
>>> -----Original Message-----
>>> From: James Clark <james.clark@arm.com>
>>> Sent: Wednesday, October 4, 2023 7:18 PM
>>> To: Linu Cherian <lcherian@marvell.com>; suzuki.poulose@arm.com;
>>> mike.leach@linaro.org; leo.yan@linaro.org
>>> Cc: linux-arm-kernel@lists.infradead.org; coresight@lists.linaro.org;
>>> linux- kernel@vger.kernel.org; robh+dt@kernel.org;
>>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>>> devicetree@vger.kernel.org; Sunil Kovvuri Goutham
>>> <sgoutham@marvell.com>; George Cherian <gcherian@marvell.com>; Anil
>>> Kumar Reddy H <areddy3@marvell.com>; Tanmay Jagdale
>>> <tanmay@marvell.com>
>>> Subject: [EXT] Re: [PATCH 5/7] coresight: tmc: Add support for reading
>>> tracedata from previous boot
>>>
>>> External Email
>>>
>>> ----------------------------------------------------------------------
>>>
>>>
>>> On 03/10/2023 17:43, James Clark wrote:
>>>>
>>>>
>>>> On 29/09/2023 14:37, Linu Cherian wrote:
>>>>> * Introduce a new mode CS_MODE_READ_PREVBOOT for reading
>>> tracedata
>>>>>   captured in previous boot.
>>>>>
>>>>> * Add special handlers for preparing ETR/ETF for this special mode
>>>>>
>>>>> * User can read the trace data as below
>>>>>
>>>>>   For example, for reading trace data from tmc_etf sink
>>>>>
>>>>>   1. cd /sys/bus/coresight/devices/tmc_etfXX/
>>>>>
>>>>>   2. Change mode to READ_PREVBOOT
>>>>>
>>>>>      #echo 1 > read_prevboot
>>>>>
>>>>>   3. Dump trace buffer data to a file,
>>>>>
>>>>>      #dd if=/dev/tmc_etrXX of=~/cstrace.bin
>>>>>
>>>>>   4. Reset back to normal mode
>>>>>
>>>>>      #echo 0 > read_prevboot
>>>>>
>>>>> Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
>>>>> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
>>>>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
>>>>> ---
>>>>>  .../coresight/coresight-etm4x-core.c          |   1 +
>>>>>  .../hwtracing/coresight/coresight-tmc-core.c  |  81 +++++++++-
>>>>>  .../hwtracing/coresight/coresight-tmc-etf.c   |  62 ++++++++
>>>>>  .../hwtracing/coresight/coresight-tmc-etr.c   | 145
>> +++++++++++++++++-
>>>>>  drivers/hwtracing/coresight/coresight-tmc.h   |   6 +
>>>>>  include/linux/coresight.h                     |  13 ++
>>>>>  6 files changed, 306 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>> index 77b0271ce6eb..513baf681280 100644
>>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>> @@ -1010,6 +1010,7 @@ static void etm4_disable(struct
>>>>> coresight_device *csdev,
>>>>>
>>>>>  	switch (mode) {
>>>>>  	case CS_MODE_DISABLED:
>>>>> +	case CS_MODE_READ_PREVBOOT:
>>>>>  		break;
>>>>>  	case CS_MODE_SYSFS:
>>>>>  		etm4_disable_sysfs(csdev);
>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>> b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>> index 6658ce76777b..65c15c9f821b 100644
>>>>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>> @@ -103,6 +103,45 @@ u32 tmc_get_memwidth_mask(struct
>>> tmc_drvdata *drvdata)
>>>>>  	return mask;
>>>>>  }
>>>>>
>>>>> +int tmc_read_prepare_prevboot(struct tmc_drvdata *drvdata) {
>>>>> +	int ret = 0;
>>>>> +	struct tmc_register_snapshot *reg_ptr;
>>>>> +	struct coresight_device *csdev = drvdata->csdev;
>>>>> +
>>>>> +	if (!drvdata->metadata.vaddr) {
>>>>> +		ret = -ENOMEM;
>>>>> +		goto out;
>>>>> +	}
>>>>> +
>>>>> +	reg_ptr = drvdata->metadata.vaddr;
>>>>> +	if (!reg_ptr->valid) {
>>>>> +		dev_err(&drvdata->csdev->dev,
>>>>> +			"Invalid metadata captured from previous boot\n");
>>>>> +		ret = -EINVAL;
>>>>> +		goto out;
>>>>> +	}
>>>>
>>>> I'm wondering if a more robust check is needed than the valid flag,
>>>> like a checksum or something. I didn't debug it yet but I ended up
>>>> with an invalid set of metadata after a panic reboot, see below. I'm
>>>> not sure if it's just a logic bug or something got lost during the
>>>> reboot, I didn't debug it yet. But I suppose unless you assume the
>>>> panic didn't affect writing the metadata, then it could be partially
>>>> written and shouldn't be trusted?
>>>>
>>>> [...]
>>>>> +
>>>>> +static int tmc_etr_sync_prevboot_buf(struct tmc_drvdata *drvdata) {
>>>>> +	u32 status;
>>>>> +	u64 rrp, rwp, dba;
>>>>> +	struct tmc_register_snapshot *reg_ptr;
>>>>> +	struct etr_buf *etr_buf = drvdata->prevboot_buf;
>>>>> +
>>>>> +	reg_ptr = drvdata->metadata.vaddr;
>>>>> +
>>>>> +	rrp = reg_ptr->rrp;
>>>>> +	rwp = reg_ptr->rwp;
>>>>> +	dba = reg_ptr->dba;
>>>>> +	status = reg_ptr->sts;
>>>>> +
>>>>> +	etr_buf->full = !!(status & TMC_STS_FULL);
>>>>> +
>>>>> +	/* Sync the buffer pointers */
>>>>> +	etr_buf->offset = rrp - dba;
>>>>> +	if (etr_buf->full)
>>>>> +		etr_buf->len = etr_buf->size;
>>>>> +	else
>>>>> +		etr_buf->len = rwp - rrp;
>>>>> +
>>>>> +	/* Sanity checks for validating metadata */
>>>>> +	if ((etr_buf->offset > etr_buf->size) ||
>>>>> +	    (etr_buf->len > etr_buf->size))
>>>>> +		return -EINVAL;
>>>>
>>>> The values I got here are 0x781b67182aa346f9 0x8000000 0x8000000 for
>>>> offset, size and len respectively. This fails the first check. It
>>>> would also be nice to have a dev_dbg here as well, it's basically
>>>> the same as the valid check above which does have one.
>>>>
>>>
>>> So I debugged it and the issue is that after the panic I was doing a
>>> cold boot rather than a warm boot and the memory was being randomised.
>>>
>>> The reason that 0x8000000 seemed to be initialised is because they are
>>> based on the reserved region size, rather than anything from the
>>> metadata. When I examined the metadata it was all randomised.
>>>
>>> That leads me to think that the single bit for 'valid' is insufficient.
>>> There is a simple hashing function in include/linux/stringhash.h that
>>> we could use on the whole metadata struct, but that specifically says:
>>>
>>>  * These hash functions are NOT GUARANTEED STABLE between kernel
>>>  * versions, architectures, or even repeated boots of the same kernel.
>>>  * (E.g. they may depend on boot-time hardware detection or be
>>>  * deliberately randomized.)
>>>
>>> Although I'm not sure how true the repeated boots of the same kernel
>>> part is.
>>>
>>> Maybe something in include/crypto/hash.h could be used instead, or
>>> make our own simple hash.
>>
>> Thanks for the pointers. Will take a look at it.
> 
> Since the purpose is to identify any data corruption, crc32(using crc32_le API) looks okay to me. Any thoughts on this ?
> May be we could add crc32 checks for trace data as well ?
> 
> Thanks.
> 

Seems fine to me. Maybe doing it on the trace data is overkill if you
already know the metadata is fine, but at the same time it might not do
any harm either. It might catch some edge case where the firmware or
device is doing something strange.

> 
> 
> 
>>
>>
>>
>>
>>
>>
>>
>> _______________________________________________
>> CoreSight mailing list -- coresight@lists.linaro.org To unsubscribe send an
>> email to coresight-leave@lists.linaro.org
