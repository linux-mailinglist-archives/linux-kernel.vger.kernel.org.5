Return-Path: <linux-kernel+bounces-158301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C20C8B1E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD201C222D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBC384DE6;
	Thu, 25 Apr 2024 09:32:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951F528F7;
	Thu, 25 Apr 2024 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037558; cv=none; b=Hu439UqBATg02B8PDPyW6G9oxuqMn4ZG8hDWedtaT8bGzrLT81fklduBYwNcOpSF9MjkCI55YHwkTZeJLK0eSXi09cFXiq/XcokpOZD2RIIEXrdLHlzr/UXuNrHYr46D5IGbWtg3lfykhCS/ECC1ilGNHzptYBzCB8tAtWpBRcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037558; c=relaxed/simple;
	bh=vAAPcR08Lfk7tNRCkcxaWVf2F2/2MEJYOvGihhU5akI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q91twtLFLShnWtTkVkpeu1fv9ZJ2rzagpPOHLDmYItSicRtyJlynM9LV6xUS2Z+V8zwJM0Vh8V6uFMdHBPd2Ur6oBnomFWedo+VadzUuc6L4SnB0PW86EIBk6nuHq6IlaL9UGIoR9Cz4oPYPMomEZf2rGN3JnOnxMes7aH21Xkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A12E1007;
	Thu, 25 Apr 2024 02:32:58 -0700 (PDT)
Received: from [192.168.1.216] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3232C3F64C;
	Thu, 25 Apr 2024 02:32:27 -0700 (PDT)
Message-ID: <1d360b13-ea7a-4d13-bb16-ab3d0688ddd2@arm.com>
Date: Thu, 25 Apr 2024 10:32:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v7 5/7] coresight: tmc: Add support for
 reading crash data
To: Linu Cherian <lcherian@marvell.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 George Cherian <gcherian@marvell.com>,
 Anil Kumar Reddy H <areddy3@marvell.com>, Tanmay Jagdale
 <tanmay@marvell.com>, "mike.leach@linaro.org" <mike.leach@linaro.org>,
 "leo.yan@linaro.org" <leo.yan@linaro.org>
References: <20240307033625.325058-1-lcherian@marvell.com>
 <20240307033625.325058-6-lcherian@marvell.com>
 <d707430f-00ee-4427-a9e4-6e42bc5b6aa9@arm.com>
 <PH0PR18MB5002D42E980EDF6317051B77CE092@PH0PR18MB5002.namprd18.prod.outlook.com>
 <a7b8d15f-5bcf-4774-a5b2-eb95d6174c43@arm.com>
 <PH0PR18MB5002CFB5DD77312CE0337896CE132@PH0PR18MB5002.namprd18.prod.outlook.com>
 <02191345-7048-4839-aecf-0e34479d49ef@arm.com>
 <PH0PR18MB5002E428481F88D92EA9FA22CE172@PH0PR18MB5002.namprd18.prod.outlook.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <PH0PR18MB5002E428481F88D92EA9FA22CE172@PH0PR18MB5002.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 25/04/2024 03:07, Linu Cherian wrote:
> Hi James,
> 
>> -----Original Message-----
>> From: James Clark <james.clark@arm.com>
>> Sent: Monday, April 22, 2024 1:48 PM
>> To: Linu Cherian <lcherian@marvell.com>; Suzuki K Poulose
>> <suzuki.poulose@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org; coresight@lists.linaro.org; linux-
>> kernel@vger.kernel.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> devicetree@vger.kernel.org; Sunil Kovvuri Goutham
>> <sgoutham@marvell.com>; George Cherian <gcherian@marvell.com>; Anil
>> Kumar Reddy H <areddy3@marvell.com>; Tanmay Jagdale
>> <tanmay@marvell.com>; mike.leach@linaro.org; leo.yan@linaro.org
>> Subject: [EXTERNAL] Re: [PATCH v7 5/7] coresight: tmc: Add support for
>> reading crash data
>>
>> Prioritize security for external emails: Confirm sender and content safety
>> before clicking links or opening attachments
>>
>> ----------------------------------------------------------------------
>>
>>
>> On 21/04/2024 03:49, Linu Cherian wrote:
>>> Hi James,
>>>
>>>> -----Original Message-----
>>>> From: James Clark <james.clark@arm.com>
>>>> Sent: Monday, April 15, 2024 2:59 PM
>>>> To: Linu Cherian <lcherian@marvell.com>; Suzuki K Poulose
>>>> <suzuki.poulose@arm.com>
>>>> Cc: linux-arm-kernel@lists.infradead.org; coresight@lists.linaro.org;
>>>> linux- kernel@vger.kernel.org; robh+dt@kernel.org;
>>>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>>>> devicetree@vger.kernel.org; Sunil Kovvuri Goutham
>>>> <sgoutham@marvell.com>; George Cherian <gcherian@marvell.com>;
>> Anil
>>>> Kumar Reddy H <areddy3@marvell.com>; Tanmay Jagdale
>>>> <tanmay@marvell.com>; mike.leach@linaro.org; leo.yan@linaro.org
>>>> Subject: Re: [EXTERNAL] Re: [PATCH v7 5/7] coresight: tmc: Add
>>>> support for reading crash data
>>>>
>>>>
>>>>
>>>> On 15/04/2024 05:01, Linu Cherian wrote:
>>>>> Hi James,
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: James Clark <james.clark@arm.com>
>>>>>> Sent: Friday, April 12, 2024 3:36 PM
>>>>>> To: Linu Cherian <lcherian@marvell.com>; Suzuki K Poulose
>>>>>> <suzuki.poulose@arm.com>
>>>>>> Cc: linux-arm-kernel@lists.infradead.org;
>>>>>> coresight@lists.linaro.org;
>>>>>> linux- kernel@vger.kernel.org; robh+dt@kernel.org;
>>>>>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>>>>>> devicetree@vger.kernel.org; Sunil Kovvuri Goutham
>>>>>> <sgoutham@marvell.com>; George Cherian <gcherian@marvell.com>;
>>>> Anil
>>>>>> Kumar Reddy H <areddy3@marvell.com>; Tanmay Jagdale
>>>>>> <tanmay@marvell.com>; mike.leach@linaro.org; leo.yan@linaro.org
>>>>>> Subject: [EXTERNAL] Re: [PATCH v7 5/7] coresight: tmc: Add support
>>>>>> for reading crash data
>>>>>>
>>>>>> Prioritize security for external emails: Confirm sender and content
>>>>>> safety before clicking links or opening attachments
>>>>>>
>>>>>> -------------------------------------------------------------------
>>>>>> --
>>>>>> -
>>>>>>
>>>>>>
>>>>>> On 07/03/2024 03:36, Linu Cherian wrote:
>>>>>>> * Introduce a new mode CS_MODE_READ_CRASHDATA for reading
>> trace
>>>>>>>   captured in previous crash/watchdog reset.
>>>>>>>
>>>>>>> * Add special device files for reading ETR/ETF crash data.
>>>>>>>
>>>>>>> * User can read the crash data as below
>>>>>>>
>>>>>>>   For example, for reading crash data from tmc_etf sink
>>>>>>>
>>>>>>>   #dd if=/dev/crash_tmc_etfXX of=~/cstrace.bin
>>>>>>>
>>>>>>> Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
>>>>>>> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
>>>>>>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
>>>>>>> ---
>>>>>>> Changelog from v6:
>>>>>>> * Removed read_prevboot flag in sysfs
>>>>>>> * Added special device files for reading crashdata
>>>>>>> * Renamed CS mode READ_PREVBOOT to READ_CRASHDATA
>>>>>>> * Setting the READ_CRASHDATA mode is done as part of file open.
>>>>>>>
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> @@ -619,6 +740,19 @@ static int tmc_probe(struct amba_device
>>>>>>> *adev,
>>>>>> const struct amba_id *id)
>>>>>>>  		coresight_unregister(drvdata->csdev);
>>>>>>>  	else
>>>>>>>  		pm_runtime_put(&adev->dev);
>>>>>>> +
>>>>>>> +	if (!is_tmc_reserved_region_valid(dev))
>>>>>>> +		goto out;
>>>>>>> +
>>>>>>> +	drvdata->crashdev.name =
>>>>>>> +		devm_kasprintf(dev, GFP_KERNEL, "%s_%s",
>> "crash",
>>>>>> desc.name);
>>>>>>> +	drvdata->crashdev.minor = MISC_DYNAMIC_MINOR;
>>>>>>> +	drvdata->crashdev.fops = &tmc_crashdata_fops;
>>>>>>> +	ret = misc_register(&drvdata->crashdev);
>>>>>>> +	if (ret)
>>>>>>> +		pr_err("%s: Failed to setup dev interface for
>> crashdata\n",
>>>>>>> +		       desc.name);
>>>>>>> +
>>>>>>
>>>>>> Is this all optional after the is_tmc_reserved_region_valid()?
>>>>>> Skipping to out seems to be more like an error condition, but in
>>>>>> this case it's not? Having it like this makes it more difficult to
>>>>>> add extra steps to the probe function. You could move it to a
>>>>>> function and flip
>>>> the condition which would be clearer:
>>>>>>
>>>>>
>>>>> Ack.
>>>>>
>>>>>>    if (is_tmc_reserved_region_valid(dev))
>>>>>>       register_crash_dev_interface(drvdata);
>>>>>>
>>>
>>> Did you meant changing the condition of "is_tmc_reserved_region_valid"
>> by "flip the condition".
>>> If yes, that’s not required IMHO, since the reserved region is still valid.
>>>
>>
>> By flip I mean remove the !. You had this:
>>
>>   	if (!is_tmc_reserved_region_valid(dev))
>> 		goto out;
>>
>> But instead you should put your registration code in a function, remove the !
>> and replace the goto with a function:
>>
>>     if (is_tmc_reserved_region_valid(dev))
>>         ret = register_crash_dev_interface(drvdata);
>>
>> Where register_crash_dev_interface() is everything you added in between
>> the goto and the out: label. The reason is that you've made it impossible to
>> extend the probe function with new behavior without having to understand
>> that this new bit must always come last. Otherwise new behavior would also
>> be skipped over if the reserved region doesn't exist.
>>
> 
> Thanks. That’s clear to me.
> 
>>> IIUC, the idea here is to not to fail the tmc_probe due to an error
>>> condition in register_crash_dev_interface,  so that the normal condition is
>> not affected. Also the error condition can be notified to the user using a
>> pr_dbg / pr_err.
>>>
>>> Thanks.
>>>
>>
>> I'm not sure I follow exactly what you mean here, but for the one error
>> condition you are checking for on the call to misc_register() you can still
>> return that from the new function and check it in the probe.
> 
> Actually was trying to clarify that we may not want to fail the probe due to a failure in the register_crash_dev_interface, since the normal trace operations could continue without crash_dev interface.(Tracing with or without the reserved region doesn’t get affected as well).
>  Please see the changes below. That way the changes are simpler. 
> 
> 
> @@ -507,6 +628,18 @@ static u32 tmc_etr_get_max_burst_size(struct device *dev)
>         return burst_size;
>  }
> 
> +static void register_crash_dev_interface(struct tmc_drvdata * drvdata,
> +                                        const char *name)
> +{
> +       drvdata->crashdev.name =
> +               devm_kasprintf(&drvdata->csdev->dev, GFP_KERNEL, "%s_%s", "crash", name);
> +       drvdata->crashdev.minor = MISC_DYNAMIC_MINOR;
> +       drvdata->crashdev.fops = &tmc_crashdata_fops;
> +       if (misc_register(&drvdata->crashdev))
> +               dev_dbg(&drvdata->csdev->dev,
> +                       "Failed to setup user interface for crashdata\n");
> +}
> +
>  static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  {
>         int ret = 0;
> @@ -619,6 +752,10 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>                 coresight_unregister(drvdata->csdev);
>         else
>                 pm_runtime_put(&adev->dev);
> +
> +       if (is_tmc_reserved_region_valid(dev))
> +               register_crash_dev_interface(drvdata, desc.name);
> +
>  out:
>         return ret;
>  }
> 
> Thanks.
> Linu Cherian.

Looks good to me!

