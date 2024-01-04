Return-Path: <linux-kernel+bounces-16434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5B3823E8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFE4287488
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5357020330;
	Thu,  4 Jan 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDVLS0hr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D002031C;
	Thu,  4 Jan 2024 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704360306; x=1735896306;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iH8mZfy4z3bXeluQ3SiXbNx9xlfsEzn+JeEJgF3IPfM=;
  b=MDVLS0hruaVcxV9n/BbPgU6mwXCRm56pnERFCT9Mnu2MDJmQiK17FwTn
   FPt2C/tyvMAtg4k928Q5BB/Gu5JaXn4Y4YkALih7cdAzyxx19artVDbUt
   aoz1oWOVoL/0giMh09utFks6t5AkFI/JqM92+/GvXoRet7Mp+0OP6DPUr
   Tdx43dh1USryRjHY7QK3hyQXArKze3WoscbVK1Ms9TSO/hdDDlyqOvMq9
   tJx70DVGmOOz1v2R49yHmxPid7bqSCjxlKx1e2pRlEfGlu5WLnenJ/2Pf
   MUhACQY/dX5tEQSpQC3WczeEcOFizWjEtpywDxrei/eo7V9WJBKpXIcqg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="400972584"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="400972584"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 01:25:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="814571457"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="814571457"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.85])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 01:25:03 -0800
Message-ID: <a7e6cf13-1873-47b1-a3d8-75d958edafe7@intel.com>
Date: Thu, 4 Jan 2024 11:24:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk for
 BlueField-3 SoC
Content-Language: en-US
To: Liming Sun <limings@nvidia.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, David Thompson <davthompson@nvidia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6082b74cbc681e8c24354828941361f4f4294242.1700315051.git.limings@nvidia.com>
 <3912dd1e-b15b-49a9-9c91-88e00e986efd@arm.com>
 <BN9PR12MB506854D38EA7E2702319F1AAD382A@BN9PR12MB5068.namprd12.prod.outlook.com>
 <66aa74f5-0613-49eb-80d3-ce4381f717ae@intel.com>
 <BN9PR12MB50682F406ABEF9999CEEF1D0D397A@BN9PR12MB5068.namprd12.prod.outlook.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <BN9PR12MB50682F406ABEF9999CEEF1D0D397A@BN9PR12MB5068.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/23 23:18, Liming Sun wrote:
> 
> 
>> -----Original Message-----
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Sent: Monday, December 11, 2023 6:39 AM
>> To: Liming Sun <limings@nvidia.com>; Christian Loehle
>> <christian.loehle@arm.com>; Ulf Hansson <ulf.hansson@linaro.org>; David
>> Thompson <davthompson@nvidia.com>
>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk for
>> BlueField-3 SoC
>>
>> On 30/11/23 15:19, Liming Sun wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Christian Loehle <christian.loehle@arm.com>
>>>> Sent: Monday, November 27, 2023 8:36 AM
>>>> To: Liming Sun <limings@nvidia.com>; Adrian Hunter
>>>> <adrian.hunter@intel.com>; Ulf Hansson <ulf.hansson@linaro.org>; David
>>>> Thompson <davthompson@nvidia.com>
>>>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk
>> for
>>>> BlueField-3 SoC
>>>>
>>>> On 18/11/2023 13:46, Liming Sun wrote:
>>>>> This commit enables SDHCI_QUIRK_BROKEN_TIMEOUT_VAL to solve the
>>>>> intermittent eMMC timeout issue reported on some cards under eMMC
>>>>> stress test.
>>>>>
>>>>> Reported error message:
>>>>>   dwcmshc MLNXBF30:00: __mmc_blk_ioctl_cmd: data error -110
>>>>>
>>>>> Signed-off-by: Liming Sun <limings@nvidia.com>
>>>>> ---
>>>>>  drivers/mmc/host/sdhci-of-dwcmshc.c | 3 ++-
>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>> b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>>> index 3a3bae6948a8..3c8fe8aec558 100644
>>>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>>>> @@ -365,7 +365,8 @@ static const struct sdhci_pltfm_data
>>>> sdhci_dwcmshc_pdata = {
>>>>>  #ifdef CONFIG_ACPI
>>>>>  static const struct sdhci_pltfm_data sdhci_dwcmshc_bf3_pdata = {
>>>>>  	.ops = &sdhci_dwcmshc_ops,
>>>>> -	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>>>>> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>>>>> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>>>>>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>>>>>  		   SDHCI_QUIRK2_ACMD23_BROKEN,
>>>>>  };
>>>>
>>>> __mmc_blk_ioctl_cmd: data error ?
>>>> What stresstest are you running that issues ioctl commands?
>>>> On which commands does the timeout occur?
>>>> Anyway you should be able to increase the timeout in ioctl structure
>>>> directly, i.e. in userspace, or does that not work?
>>>
>>> It's running stress test with tool like "fio --name=randrw_stress_round_1 --
>> ioengine=libaio --direct=1 --time_based=1 --end_fsync=1 --ramp_time=5 --
>> norandommap=1 --randrepeat=0 --group_reporting=1 --numjobs=4 --
>> iodepth=128 --rw=randrw --overwrite=1 --runtime=36000 --
>> bssplit=4K/44:8K/1:12K/1:16K/1:24K/1:28K/1:32K/1:40K/32:64K/5:68K/7:72K
>> /3:76K/3 --filename=/dev/mmcblk0"
>>> The tool(application) is owned by user or with some standard tool.
>>
>> fio does not send mmc ioctls, so I am also a bit confused about
>> how you get "__mmc_blk_ioctl_cmd: data error -110" ?
> 
> There are other activities or background task going on. I assume it's other
> MMC access which are affected by the stress FIO and got timeout. Would it make sense?
> 

It depends on whether the IOCTL is overriding the timeout.  In
struct mmc_ioc_cmd there is data_timeout_ns which overrides the
mmc core data timeout calculated by mmc_set_data_timeout().  There
is also cmd_timeout_ms for commands.  You need to check whether
"__mmc_blk_ioctl_cmd: data error -110" is because data_timeout_ns
was set too low (but non-zero) by the caller of the IOCTL.


