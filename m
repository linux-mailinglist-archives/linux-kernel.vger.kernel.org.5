Return-Path: <linux-kernel+bounces-9369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F081C4A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869181F24FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D0A8F57;
	Fri, 22 Dec 2023 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1gmV8BQR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4678F40
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyVLt7lcPqu/WpPmAyqKRIyZUfbsLBSyFqV7yP8bfzdAHhN1vtTUTpTH9Imejed3Rr1ZxBenVmWIB9tF74M1UHfITa0h95XRy8S+v9FKSLFzzO5iplpQu19m4nrXmwXoWUA6xw+vUuaVBFLY8a+fvF5Ur6kiWVJJYKKZ23+k4D6wl+BqON+4rEprU3ZFIXyxKSpIjmlTLLHuZqZ6XDqNVhlMfZ8Yz/EdETin1PCJWkoSjM1Lj6lGzi1dwG3mVoqZm1z0ZgsTbQsKxxkfMsEkTXi7w+GcOEwS9Zo/Zsi5+WEArtHD8pjmDY3kcndasQAEXPsL6VvVG23mFoWq7BtJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s59GZ2EVGzKOH3ueBvfINUqFksaJYvuIAka+ZRnR6gk=;
 b=GOkIPXBtz4aJt9LOwJQYiORmyTpNoIWfn9nmTP+qzk0IxJ/KhPHaVthb6SEX6tWffjRwN/oHX+xROzx2wmfoj+SJ8+T5O3iDpwLUQazx9aLLlYmC6s2wA9BLHQzR1Qb7AVMw6RP4bvUoqtLC95XWGkSQxogKqGOIgI4g/zgfWAxSDf7nzeFea4xWZvIIL6lLzchS/rAzr+iOMn0beHZdfxQtLTyIccFxKheMPPzaHIehL2TTMKr3+0++rQaXGnWY6D8odRI+B0b3sue/MQuUQYPSIZhnXkIDf+Ei4lyz/GbuX9/z1LfauANeDLjNfHcBqaduNv9E+aa6yLZfI31uIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s59GZ2EVGzKOH3ueBvfINUqFksaJYvuIAka+ZRnR6gk=;
 b=1gmV8BQR80gQVfqfiMtFD4aanrWcdnYQbYG6uuTaeTBoPA+WW25mRvSPW0cQ/DVJmPt7IQlF6/HqJBiCBZLUQL1vmXQGHfhifcHYP/iYYQOTWjVN3CwlTXpsnSJWSj/Dmb3PPKKYgsBFi4SHR1U4sJ3oNqLOrxGBM3iN4SJvB5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Fri, 22 Dec
 2023 05:32:55 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::59d1:c9f5:2c67:1da6]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::59d1:c9f5:2c67:1da6%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 05:32:55 +0000
Message-ID: <ec05208f-f0ad-495e-bd6c-30adb5606e09@amd.com>
Date: Fri, 22 Dec 2023 11:02:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] drivers: soundwire: refactor amd soundwire manager
 device node creation
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 pierre-louis.bossart@linux.intel.com, vinod.koul@intel.com,
 venkataprasad.potturu@amd.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
 <20231221073558.3181911-3-Vijendar.Mukunda@amd.com> <ZYRpAcmfMtegIvj_@matsya>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <ZYRpAcmfMtegIvj_@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::31) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: b8122074-8bcb-47ba-30df-08dc02af72df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QDCjfzBcR5m4WndeYRn8TE1ZCf06w1ZSa9VkH6IE11r5X0OSdUHW1Sld6hqKDS1M7WI2MEowbbRW681YhXzelyNOGMPqiCEe934l+xEGGNxDcIhKLnCjIIK8i6fy2XdsrOT8GaN8GjP27PiCtRBLNmOP3lTNP2y0uTYNDfK1eoHY9kljEafhdAFOfZQhQniaHyGqQHek5eRz3a6YBUqR9kcp9NZurfioqQ5eelB74MDFsVjcwdYgb9F5LYJuoe2VARMb9ittVfkxk6yrtJl4yXkn09gJ5JDH+i0vdpBS3tnb1tdygCKIOiL7j9xbbLGwLi1f1QLgUGH2Umh568/X0BVHXIkMUuIHDIPMXLftAVmNRyGgKYiOoRkh8s7DGAZkAOKDx6DHKyUxJDzGlB4hehasuy9uwuqUXsEdUpt8yw7oyKPmsGwInI/iw04esbq/4g/uB6bsv9gKA4iXV6Dooso42u1D1eVX0b2QBr4nYu4t8naQUSLfgsvueUtov9nwuFr7/cXwneHGaoOocdmMGr4yqlBkH/T8xXEC6yuMHQPCIYGo9wt6w6ChNkZ3BOQdCqaNZJvmm6kpT1WTNFCQUWu/bx8CX8hTJkUV8n8fsWholcjLryPvR61Wc/LxKgClbnecgIvYTw2kTXRYgG2hiw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(366004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6916009)(316002)(26005)(30864003)(2906002)(2616005)(478600001)(83380400001)(54906003)(66556008)(66476007)(66946007)(53546011)(6666004)(5660300002)(6512007)(6506007)(4326008)(8936002)(8676002)(31686004)(38100700002)(6486002)(41300700001)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1hEa2hpdFFDM2FWQUtwVENDNUNMQnlGbGhIN2JxbE9qakttaEZiYzllSlRS?=
 =?utf-8?B?eEp5OVVlNlRQL0VyQ3dLbWlXa0R3YTVydFV3engrZ2IybzFYNmhQWkxWVDdO?=
 =?utf-8?B?L3p5R3BOVngyWDdaT0ZpcWtjM1V6OUxvcHNoZFJ4N2Y5ZC95MWNpSkZqb2Z3?=
 =?utf-8?B?SUJJYXpKREpmWGt4OWVienB5NHMyU29aekIrSWxuY2hkM2srTENHTndmemZY?=
 =?utf-8?B?ZG5vbWxrdXptd2krNDJxRFpnYlBaMHBvQ2V4andsRlVJM05VNHVEOEVYUEVu?=
 =?utf-8?B?cThkckNpeGxVSnJ3Y2ZXaDdIMHMvcEFrMTFZd3llZXhKSGdvU1VLVjZqeWpH?=
 =?utf-8?B?aVpDZTNacTJ5aTNhUUhGdFJTRDFGSDBDTjRIV3A3SWJ5dGk0Uys4NXc3ZWVR?=
 =?utf-8?B?bDJUKzJ5UU0xNFN2UGRuTjZQdTFmUjU3VXFnTURiNkc3MGNYZ0lVR05tVlJl?=
 =?utf-8?B?ZXdCb2JZQVQyZEFlUFZrMWtMVlRWZGNkMVdob3hYeUxaTlllNFR6Y3VHd1Zs?=
 =?utf-8?B?eEdiUUJCSmlsL1dZNzBtM0lkNUxoWG9VTGJEOVNaWkVCV2dHM0pYQU1zcU1n?=
 =?utf-8?B?Z0dsaFQxVm1IMGR4VElLWlF1aEE0aE5rRVBtd1c3T2xJYUsyUXl0YWlGVmJM?=
 =?utf-8?B?bDVnbFdMSHNYVElCQUYzWFRLdWh4Nm01RjFiSU5xS1ZFdHVOakxrRVhzcUM2?=
 =?utf-8?B?Vkk3K1NqM3JCd1VUMW83Q29xb2JVb2Z1TGFvSGxnMUpkQ1JNaGw5OU4zRE9m?=
 =?utf-8?B?d1JkK2JyMVN1TlMvZXhNejgvRlFFbVJ3WER6OGF3dnVsT0M4RzcvVHlTMVVl?=
 =?utf-8?B?bC9WdXFnQ2xHSjk0L0NyczM1eXZzUk44M2ZGcjJmR1l0WFUyQUQrRWtUOGZv?=
 =?utf-8?B?ZGRUZnUvSktBbG5YODhwVGFXU0JrK1RPNW8wZEhVaktFOFI0cHJXbkVGcm01?=
 =?utf-8?B?NjRsU1hadmlnR3JoclF0MnFvOG1ENVZheWRxNUNXWVdtR0VGVmFDMU1ySkQx?=
 =?utf-8?B?d3BnNFFoWTAxNXdNcVhDSUJpdHJtT1pydHBBT3VYTC9NK01aNE1rWHNMRVV0?=
 =?utf-8?B?dE9TaGNSODRlMDh0ditIR1JxamM4M3BncTlaYzR2Z3Ixbjl2eUJZQmFuVVFj?=
 =?utf-8?B?UWJiWjNVeHBManBLbGUwZUJTTnZxczJVclZYblArRTU2bVBPUlovaWg4UENO?=
 =?utf-8?B?QVNPaWYrVjI2ekdYUWVnZS9UTkZpQ005dUVyc0tWbGpiOVo1bm1mZ1dUT3lo?=
 =?utf-8?B?cTNLVHI1VkZGRmwwdWVwY0dyM2Z5R1BBSmhWWW1EMXp4SXRHUzhKM3NaTFlG?=
 =?utf-8?B?VzNoUG9Xc3VycDBLaEc4QlNBZ240c3JDMXNVMnIzQTFRa04ybit4R0d1eC9p?=
 =?utf-8?B?UFJyQS9xd1BrajRUV0t0bWM2WGw1cU1ueE1BTkZxc2VCZnF1Mk80RVo5UE0r?=
 =?utf-8?B?dm5hYUlMTmhOWFpZSWpRZFNJZHhWQm8rRi9TZVVkRW9ETTNDZW03cEdKaHVw?=
 =?utf-8?B?N0pTQ2g4VXo1N2xXVjV1K1RJVGIwUDkrOEdTWUxxZVF1d3FndnFJNFRoZ2gy?=
 =?utf-8?B?S1Fnb3VqYWYzMy9XSUZmM2ZoMm16ZzlzQmllSzBTQnd6bmJRTFM1M2pGVW5Z?=
 =?utf-8?B?T1RFY3BZQy9GUkh1SjkrLzM1NGxIK3VUZUFYcXlVWlBiV2lKbGpoVFYwQ3F4?=
 =?utf-8?B?azBJdndBZGxwVVFWSlhvQ0cyOGlucHN1TmUxaGZPNEw5cDFVejlVTE0zdFYz?=
 =?utf-8?B?c2pvMEhmczNBYlViNHlpVDB0RCtqdWkraWFFSERNYzJZVGdlUW85WmJnN2pP?=
 =?utf-8?B?dGJ3K0lSU3podzR4bGo3c0JtY3V1Z3FvQjRnZHF2Z2dBL2VOSnVvY29mSVFM?=
 =?utf-8?B?anN1MHVkZ1UydERhQ3lJWVZTUTB2eVdBSzE4ODBkNmd0b0djeUE1NDR4Y1oz?=
 =?utf-8?B?NzJRTUVuZFRqTE04MXRjdWF3Y0RWTmlJRkRWWTNxWWNsYy94QVRwMG5ObHpG?=
 =?utf-8?B?KzNBdmFwdFVWRDFJWWNNMTN0OWdRMU9zTjFTeTJYQmw0bHIwVXdTMTErNVNI?=
 =?utf-8?B?Yk90V2JpSGUrUS9PWXcwZmduZHk2K1RicnZIcG9LMkFzNTZkQnVDaVdiMURK?=
 =?utf-8?Q?6Yqhmv6oYs8gJ9UUB1pXZ3aLI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8122074-8bcb-47ba-30df-08dc02af72df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 05:32:55.3101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsYRQYMJFVI9yLfqq6Sy8CTXQDq4dm6EXYrbWjQoCOhPbHvrRse0mkldfY5HOgENWypRmMujB0pJdC3SHg+msw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973

On 21/12/23 22:04, Vinod Koul wrote:
> On 21-12-23, 13:05, Vijendar Mukunda wrote:
>
> Why is the tag drivers: soundwire: ...??
>
> should have been amd: to indicate amd driver code
will add "amd" tag
>> Refactor amd SoundWire manager device node creation logic and
>> implement generic functions to have a common functionality for
>> SoundWire manager platform device creation, start and exit sequence
>> for both legacy(NO DSP) and SOF stack for AMD platforms.
>> These functions will be invoked from legacy and SOF stack.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  drivers/soundwire/Makefile        |   2 +-
>>  drivers/soundwire/amd_init.c      | 147 ++++++++++++++++++++++++++++++
>>  drivers/soundwire/amd_init.h      |  13 +++
>>  drivers/soundwire/amd_manager.c   |  16 +---
>>  include/linux/soundwire/sdw_amd.h |  54 ++++++++++-
>>  5 files changed, 218 insertions(+), 14 deletions(-)
>>  create mode 100644 drivers/soundwire/amd_init.c
>>  create mode 100644 drivers/soundwire/amd_init.h
>>
>> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
>> index 657f5888a77b..e80a2c2cf3e7 100644
>> --- a/drivers/soundwire/Makefile
>> +++ b/drivers/soundwire/Makefile
>> @@ -20,7 +20,7 @@ soundwire-bus-y += irq.o
>>  endif
>>  
>>  #AMD driver
>> -soundwire-amd-y :=	amd_manager.o
>> +soundwire-amd-y := amd_init.o amd_manager.o
>>  obj-$(CONFIG_SOUNDWIRE_AMD) += soundwire-amd.o
>>  
>>  #Cadence Objs
>> diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
>> new file mode 100644
>> index 000000000000..d732ab0bfd59
>> --- /dev/null
>> +++ b/drivers/soundwire/amd_init.c
>> @@ -0,0 +1,147 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>> +/*
>> + * SoundWire AMD Manager Initialize routines
>> + *
>> + * Initializes and creates SDW devices based on ACPI and Hardware values
>> + *
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/export.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "amd_init.h"
>> +
>> +static int sdw_amd_cleanup(struct sdw_amd_ctx *ctx)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ctx->count; i++) {
>> +		if (!(ctx->link_mask & BIT(i)))
>> +			continue;
>> +		platform_device_unregister(ctx->pdev[i]);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
>> +{
>> +	struct sdw_amd_ctx *ctx;
>> +	struct acpi_device *adev;
>> +	struct resource *sdw_res;
>> +	struct acp_sdw_pdata sdw_pdata[2];
>> +	struct platform_device_info pdevinfo[2];
>> +	u32 link_mask;
>> +	int count, index;
>> +
>> +	if (!res)
>> +		return NULL;
>> +
>> +	adev = acpi_fetch_acpi_dev(res->handle);
>> +	if (!adev)
>> +		return NULL;
>> +
>> +	if (!res->count)
>> +		return NULL;
>> +
>> +	count = res->count;
>> +	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
>> +
>> +	/*
>> +	 * we need to alloc/free memory manually and can't use devm:
>> +	 * this routine may be called from a workqueue, and not from
>> +	 * the parent .probe.
>> +	 * If devm_ was used, the memory might never be freed on errors.
>> +	 */
>> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return NULL;
>> +
>> +	ctx->count = count;
>> +	ctx->link_mask = res->link_mask;
>> +	sdw_res = kzalloc(sizeof(*sdw_res), GFP_KERNEL);
>> +	if (!sdw_res) {
>> +		kfree(ctx);
>> +		return NULL;
>> +	}
>> +	sdw_res->flags = IORESOURCE_MEM;
>> +	sdw_res->start = res->addr;
>> +	sdw_res->end = res->addr + res->reg_range;
>> +	memset(&pdevinfo, 0, sizeof(pdevinfo));
>> +	link_mask = ctx->link_mask;
>> +	for (index = 0; index < count; index++) {
>> +		if (!(link_mask & BIT(index)))
>> +			continue;
>> +
>> +		sdw_pdata[index].instance = index;
>> +		sdw_pdata[index].acp_sdw_lock = res->acp_lock;
>> +		pdevinfo[index].name = "amd_sdw_manager";
>> +		pdevinfo[index].id = index;
>> +		pdevinfo[index].parent = res->parent;
>> +		pdevinfo[index].num_res = 1;
>> +		pdevinfo[index].res = sdw_res;
>> +		pdevinfo[index].data = &sdw_pdata[index];
>> +		pdevinfo[index].size_data = sizeof(struct acp_sdw_pdata);
>> +		pdevinfo[index].fwnode = acpi_fwnode_handle(adev);
>> +		ctx->pdev[index] = platform_device_register_full(&pdevinfo[index]);
>> +		if (IS_ERR(ctx->pdev[index]))
>> +			goto err;
>> +	}
>> +	kfree(sdw_res);
>> +	return ctx;
>> +err:
>> +	while (index--) {
>> +		if (!(link_mask & BIT(index)))
>> +			continue;
>> +
>> +		platform_device_unregister(ctx->pdev[index]);
>> +	}
>> +
>> +	kfree(sdw_res);
>> +	kfree(ctx);
>> +	return NULL;
>> +}
>> +
>> +static int sdw_amd_startup(struct sdw_amd_ctx *ctx)
>> +{
>> +	struct amd_sdw_manager *amd_manager;
>> +	int i, ret;
>> +
>> +	/* Startup SDW Manager devices */
>> +	for (i = 0; i < ctx->count; i++) {
>> +		if (!(ctx->link_mask & BIT(i)))
>> +			continue;
>> +		amd_manager = dev_get_drvdata(&ctx->pdev[i]->dev);
>> +		ret = amd_sdw_manager_start(amd_manager);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **sdw_ctx)
>> +{
>> +	*sdw_ctx = sdw_amd_probe_controller(res);
>> +	if (!*sdw_ctx)
>> +		return -ENODEV;
>> +
>> +	return sdw_amd_startup(*sdw_ctx);
>> +}
>> +EXPORT_SYMBOL_NS(sdw_amd_probe, SOUNDWIRE_AMD_INIT);
>> +
>> +void sdw_amd_exit(struct sdw_amd_ctx *ctx)
>> +{
>> +	sdw_amd_cleanup(ctx);
>> +	kfree(ctx->ids);
>> +	kfree(ctx);
>> +}
>> +EXPORT_SYMBOL_NS(sdw_amd_exit, SOUNDWIRE_AMD_INIT);
>> +
>> +MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
>> +MODULE_DESCRIPTION("AMD SoundWire Init Library");
>> +MODULE_LICENSE("Dual BSD/GPL");
>> diff --git a/drivers/soundwire/amd_init.h b/drivers/soundwire/amd_init.h
>> new file mode 100644
>> index 000000000000..f710703ffae9
>> --- /dev/null
>> +++ b/drivers/soundwire/amd_init.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
>> +/*
>> + * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __AMD_INIT_H
>> +#define __AMD_INIT_H
>> +
>> +#include <linux/soundwire/sdw_amd.h>
>> +
>> +int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager);
>> +
>> +#endif
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>> index 3a99f6dcdfaf..c27b0b0f33a6 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -19,6 +19,7 @@
>>  #include <sound/pcm_params.h>
>>  #include <sound/soc.h>
>>  #include "bus.h"
>> +#include "amd_init.h"
>>  #include "amd_manager.h"
>>  
>>  #define DRV_NAME "amd_sdw_manager"
>> @@ -864,10 +865,8 @@ static void amd_sdw_irq_thread(struct work_struct *work)
>>  	writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
>>  }
>>  
>> -static void amd_sdw_probe_work(struct work_struct *work)
>> +int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
>>  {
>> -	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
>> -							   probe_work);
>>  	struct sdw_master_prop *prop;
>>  	int ret;
>>  
>> @@ -876,11 +875,11 @@ static void amd_sdw_probe_work(struct work_struct *work)
>>  		amd_enable_sdw_pads(amd_manager);
>>  		ret = amd_init_sdw_manager(amd_manager);
>>  		if (ret)
>> -			return;
>> +			return ret;
>>  		amd_enable_sdw_interrupts(amd_manager);
>>  		ret = amd_enable_sdw_manager(amd_manager);
>>  		if (ret)
>> -			return;
>> +			return ret;
>>  		amd_sdw_set_frameshape(amd_manager);
>>  	}
>>  	/* Enable runtime PM */
>> @@ -889,6 +888,7 @@ static void amd_sdw_probe_work(struct work_struct *work)
>>  	pm_runtime_mark_last_busy(amd_manager->dev);
>>  	pm_runtime_set_active(amd_manager->dev);
>>  	pm_runtime_enable(amd_manager->dev);
>> +	return 0;
>>  }
>>  
>>  static int amd_sdw_manager_probe(struct platform_device *pdev)
>> @@ -964,11 +964,6 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
>>  	dev_set_drvdata(dev, amd_manager);
>>  	INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
>>  	INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
>> -	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
>> -	/*
>> -	 * Instead of having lengthy probe sequence, use deferred probe.
>> -	 */
>> -	schedule_work(&amd_manager->probe_work);
>>  	return 0;
>>  }
>>  
>> @@ -978,7 +973,6 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
>>  	int ret;
>>  
>>  	pm_runtime_disable(&pdev->dev);
>> -	cancel_work_sync(&amd_manager->probe_work);
>>  	amd_disable_sdw_interrupts(amd_manager);
>>  	sdw_bus_master_delete(&amd_manager->bus);
>>  	ret = amd_disable_sdw_manager(amd_manager);
>> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
>> index 41dd64941cef..064174c2f401 100644
>> --- a/include/linux/soundwire/sdw_amd.h
>> +++ b/include/linux/soundwire/sdw_amd.h
>> @@ -26,6 +26,7 @@
>>  #define AMD_SDW_POWER_OFF_MODE		2
>>  #define ACP_SDW0	0
>>  #define ACP_SDW1	1
>> +#define AMD_SDW_MAX_MANAGER_COUNT	2
>>  
>>  struct acp_sdw_pdata {
>>  	u16 instance;
>> @@ -63,7 +64,6 @@ struct sdw_amd_dai_runtime {
>>   * @reg_mask: register mask structure per manager instance
>>   * @amd_sdw_irq_thread: SoundWire manager irq workqueue
>>   * @amd_sdw_work: peripheral status work queue
>> - * @probe_work: SoundWire manager probe workqueue
>>   * @acp_sdw_lock: mutex to protect acp share register access
>>   * @status: peripheral devices status array
>>   * @num_din_ports: number of input ports
>> @@ -87,7 +87,6 @@ struct amd_sdw_manager {
>>  	struct sdw_manager_reg_mask *reg_mask;
>>  	struct work_struct amd_sdw_irq_thread;
>>  	struct work_struct amd_sdw_work;
>> -	struct work_struct probe_work;
>>  	/* mutex to protect acp common register access */
>>  	struct mutex *acp_sdw_lock;
>>  
>> @@ -120,5 +119,56 @@ struct sdw_amd_acpi_info {
>>  	u32 link_mask;
>>  };
>>  
>> +/**
>> + * struct sdw_amd_ctx - context allocated by the controller
>> + * driver probe
>> + * @count: link count
>> + * @num_slaves: total number of devices exposed across all enabled links
>> + * @link_mask: bit-wise mask listing SoundWire links reported by the
>> + * Controller
>> + * @ids: array of slave_id, representing Slaves exposed across all enabled
>> + * links
>> + * @pdev: platform device structure
>> + */
>> +struct sdw_amd_ctx {
>> +	int count;
>> +	int num_slaves;
>> +	u32 link_mask;
>> +	struct sdw_extended_slave_id *ids;
>> +	struct platform_device *pdev[AMD_SDW_MAX_MANAGER_COUNT];
>> +};
>> +
>> +/**
>> + * struct sdw_amd_res - Soundwire AMD global resource structure,
>> + * typically populated by the DSP driver/Legacy driver
>> + *
>> + * @addr: acp pci device resource start address
>> + * @reg_range: ACP register range
>> + * @link_mask: bit-wise mask listing links selected by the DSP driver/
>> + * legacy driver
>> + * @count: link count
>> + * @mmio_base: mmio base of SoundWire registers
>> + * @handle: ACPI parent handle
>> + * @parent: parent device
>> + * @dev: device implementing hwparams and free callbacks
>> + * @acp_lock: mutex protecting acp common registers access
>> + */
>> +struct sdw_amd_res {
>> +	u32 addr;
>> +	u32 reg_range;
>> +	u32 link_mask;
>> +	int count;
>> +	void __iomem *mmio_base;
>> +	acpi_handle handle;
>> +	struct device *parent;
>> +	struct device *dev;
>> +	/* use to protect acp common registers access */
>> +	struct mutex *acp_lock;
>> +};
>> +
>> +int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **ctx);
>> +
>> +void sdw_amd_exit(struct sdw_amd_ctx *ctx);
>> +
>>  int amd_sdw_scan_controller(struct sdw_amd_acpi_info *info);
>>  #endif
>> -- 
>> 2.34.1


