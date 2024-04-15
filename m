Return-Path: <linux-kernel+bounces-144833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275028A4B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9186C1F21D38
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA3B3FB1C;
	Mon, 15 Apr 2024 09:28:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEAA1BF2B;
	Mon, 15 Apr 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173324; cv=none; b=ZKejjKSevitrR+Ca92TnMTDf97T36eWZvZ8dpDOXhyEhN4Y5Pas/Np1cTOLIuOCb15G0ByAM6P304ptgRAnY2WE4CngBVW904gHOb944VCrXiTcBxz8Qp59zJn/o8oXp5qWxjUjzN3AJzMRbdV58Ks6YWhf2Zc/7gzNqtK8AbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173324; c=relaxed/simple;
	bh=ngml+9qlMlfIm2PqGnHZsrZJ2/bGHZk/OCrm7zti4uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IR38+iMAqRpZMMHQ7GNN7D3RE9LzK8oRnwaktnWiMRQAVxsppCFRaHQk4hLJxJmDYCuvmAUAID42Yxdad19nDCddHqmLMu9kMUZTD9EUtX0dN6oUtO9Gqtu2uuh4S6ujJF/2yFUjzrXKmxu2+b2Q8eYjmtx67oaBjLCKU8occnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29A6C2F4;
	Mon, 15 Apr 2024 02:29:09 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA0663F64C;
	Mon, 15 Apr 2024 02:28:37 -0700 (PDT)
Message-ID: <a7b8d15f-5bcf-4774-a5b2-eb95d6174c43@arm.com>
Date: Mon, 15 Apr 2024 10:28:36 +0100
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
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <PH0PR18MB5002D42E980EDF6317051B77CE092@PH0PR18MB5002.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/04/2024 05:01, Linu Cherian wrote:
> Hi James,
> 
>> -----Original Message-----
>> From: James Clark <james.clark@arm.com>
>> Sent: Friday, April 12, 2024 3:36 PM
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
>> On 07/03/2024 03:36, Linu Cherian wrote:
>>> * Introduce a new mode CS_MODE_READ_CRASHDATA for reading trace
>>>   captured in previous crash/watchdog reset.
>>>
>>> * Add special device files for reading ETR/ETF crash data.
>>>
>>> * User can read the crash data as below
>>>
>>>   For example, for reading crash data from tmc_etf sink
>>>
>>>   #dd if=/dev/crash_tmc_etfXX of=~/cstrace.bin
>>>
>>> Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
>>> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
>>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
>>> ---
>>> Changelog from v6:
>>> * Removed read_prevboot flag in sysfs
>>> * Added special device files for reading crashdata
>>> * Renamed CS mode READ_PREVBOOT to READ_CRASHDATA
>>> * Setting the READ_CRASHDATA mode is done as part of file open.
>>>
>>
>> [...]
>>
>>> @@ -619,6 +740,19 @@ static int tmc_probe(struct amba_device *adev,
>> const struct amba_id *id)
>>>  		coresight_unregister(drvdata->csdev);
>>>  	else
>>>  		pm_runtime_put(&adev->dev);
>>> +
>>> +	if (!is_tmc_reserved_region_valid(dev))
>>> +		goto out;
>>> +
>>> +	drvdata->crashdev.name =
>>> +		devm_kasprintf(dev, GFP_KERNEL, "%s_%s", "crash",
>> desc.name);
>>> +	drvdata->crashdev.minor = MISC_DYNAMIC_MINOR;
>>> +	drvdata->crashdev.fops = &tmc_crashdata_fops;
>>> +	ret = misc_register(&drvdata->crashdev);
>>> +	if (ret)
>>> +		pr_err("%s: Failed to setup dev interface for crashdata\n",
>>> +		       desc.name);
>>> +
>>
>> Is this all optional after the is_tmc_reserved_region_valid()? Skipping to out
>> seems to be more like an error condition, but in this case it's not? Having it
>> like this makes it more difficult to add extra steps to the probe function. You
>> could move it to a function and flip the condition which would be clearer:
>>
> 
> Ack.
> 
>>    if (is_tmc_reserved_region_valid(dev))
>>       register_crash_dev_interface(drvdata);
>>
>>
>>>  out:
>>>  	return ret;
>>>  }
>>
>> [...]
>>
>>>
>>> +static int tmc_etr_setup_crashdata_buf(struct tmc_drvdata *drvdata) {
>>> +	int rc = 0;
>>> +	u64 trace_addr;
>>> +	struct etr_buf *etr_buf;
>>> +	struct etr_flat_buf *resrv_buf;
>>> +	struct tmc_crash_metadata *mdata;
>>> +	struct device *dev = &drvdata->csdev->dev;
>>> +
>>> +	mdata = drvdata->crash_mdata.vaddr;
>>> +
>>> +	etr_buf = kzalloc(sizeof(*etr_buf), GFP_ATOMIC);
>>> +	if (!etr_buf) {
>>> +		rc = -ENOMEM;
>>> +		goto out;
>>> +	}
>>> +	etr_buf->size = drvdata->crash_tbuf.size;
>>> +
>>> +	resrv_buf = kzalloc(sizeof(*resrv_buf), GFP_ATOMIC);
>>> +	if (!resrv_buf) {
>>> +		rc = -ENOMEM;
>>> +		goto rmem_err;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Buffer address given by metadata for retrieval of trace data
>>> +	 * from previous boot is expected to be same as the reserved
>>> +	 * trace buffer memory region provided through DTS
>>> +	 */
>>> +	if (is_tmc_reserved_region_valid(dev->parent)
>>> +	    && (drvdata->crash_tbuf.paddr == mdata->trc_paddr))
>>> +		resrv_buf->vaddr = drvdata->crash_tbuf.vaddr;
>>> +	else {
>>> +		dev_dbg(dev, "Trace buffer address of previous boot
>> invalid\n");
>>> +		rc = -EINVAL;
>>> +		goto map_err;
>>> +	}
>>> +
>>> +	resrv_buf->size = etr_buf->size;
>>> +	resrv_buf->dev = &drvdata->csdev->dev;
>>> +	etr_buf->hwaddr = trace_addr;
>>
>> trace_addr is uninitialised at this point. If you pull the latest coresight branch
>> we enabled some extra compiler warnings which catch this.
>>
>> I assume it's supposed to be mdata->trc_paddr?
> 
> 
> Since no DMA operation happens here, its supposed to be kept NULL.
> Since it was redundant for crash data read operation, missed catching this. Will fix this.
> 
>>
>> Is there some kind of test that could be added that could have caught this?
>> Maybe skip the full reboot flow but just enable the feature and see if we can
>> read from the buffer.
> 
> As pointed above this field is redundant for crashdata read mode. So its not a functionality breakage as such.
> 

Ah ok that's not as bad as I thought then. I went back to version 4 or 5
and thought I saw it was assigned so assumed there was a mistake.

>>
>> Or even just toggling the mode on and off via sysfs. We're running the Perf
>> and kselftests on Juno internally so I can add a reserved region to the Juno DT
>> and make sure this stays working.
> 
> Did you meant adding a kselftest for tracing and reading back tracedata in sysfs mode using the reserved region ?
> 

Yes just enable, disable then read back. I don't think we need to do a
decode, but make sure a non zero size is read. And the test can be
skipped if the reserved region doesn't exist.

> Thanks
> Linu Cherian. 
> 


