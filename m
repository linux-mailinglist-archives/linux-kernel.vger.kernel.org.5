Return-Path: <linux-kernel+bounces-9435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71BB81C571
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6C92830B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6369447;
	Fri, 22 Dec 2023 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AUJxz5Yp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265FA9449
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIKCXxWCrC61tIYQZtWe8hjB/OJnxWTiI73x/3vwCj+hgjPbPKERioL5U+Msd4i4YfyOOYfsl4ny9Gpt5cn2dBj3oxNYZDv1OWBGCUvYZLTBJjMKc1BKCgpnGXa0SOF59OryOdBUqD3Dy2iNbuwI1s6eorpQLahgBZahl0JSdxptNirDUNzVjfbDRzRlMqZCqNrw+07MmZ4r7qPXirxkwQv0C9Sn5rKswo3Sd/rPi/mEb3W53N8mI2xOoxAxX9a3An+61k+alPMxiB+UkZaHRzpwFvP7lDonp+SQyn89hlg0Dh62L0i+3gcrA9U8FPYC0NDL4u486Tvh/a5QR0Nr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5kWAewovdbWQRiFe1FNF9iBMdp6ElGMe82bAV10PhU=;
 b=jUH4vSpQozS3ocE3C2LPmvsI7a2Zy69w162DJSAMT0l5bGB+0XS9vvLxkrkHRgT2mgjcWGu136Bl5prQxNBDswoLaU1bPWlBi8VqNUgjotejuBvXnU9Da8VzMMMFdXrjkiayfUz2xZ/kSeL/7wjX585b1vC9lmHEc+/TBmMyKzmjTrvg7Zyrp1dzxdZAchbUyv3PAklCkl/AQe5N69AoFJqPmhVh7OktgkhGyWJ0GEVjkowuftwO5fm+awFscWeUnVLNpyejoT1mjHhNpgLzLSy0kQmikmn8F4EGwMQVS2b7/KmnXgE5k5lT2WkMrdLQUCe2T+VpiNyjhEo53iVp3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5kWAewovdbWQRiFe1FNF9iBMdp6ElGMe82bAV10PhU=;
 b=AUJxz5YpWIfN4GvvfbtOmgorP8F3EhEQzZQHawyhZ5LGzpIUI/6qhMaiBaEsJznZ5gCf0Ea+1nhFRI7/5DREhZIoIE8EvvDdFa8unSt6S/1eyS37Kgboq42pocU7RY2BTkvwfmVA1V5yG5UZGeImPPaQEZFV0QSo06jqXFcJdhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 07:15:53 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::59d1:c9f5:2c67:1da6]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::59d1:c9f5:2c67:1da6%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 07:15:53 +0000
Message-ID: <6d98c43d-fb90-4cfa-a22e-8fd6d5a6eb50@amd.com>
Date: Fri, 22 Dec 2023 12:45:43 +0530
User-Agent: Mozilla Thunderbird
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 04/12] drivers: soundwire: refactor soundwire pads enable
To: Vinod Koul <vkoul@kernel.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 pierre-louis.bossart@linux.intel.com, vinod.koul@intel.com,
 venkataprasad.potturu@amd.com, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
 <20231221073558.3181911-5-Vijendar.Mukunda@amd.com> <ZYRqEbVADgU4fNtB@matsya>
Content-Language: en-US
In-Reply-To: <ZYRqEbVADgU4fNtB@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0250.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::15) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: d196acb4-e138-406f-30df-08dc02bdd541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PZFVSo+gBltqMw+bauUr9cVMPQk7+m9dDRuNLBeQx6i2yH8YUMthcI2QqKK1ta/udi5Rbmx649OTZJ3BnFy/ozB1Vz7UeMWnEQJX+0rTj4NrOpkRuh/xLlVriVpleACEEpgAlLPbvoE5iUR+Mh187Th0Fl8aF2Pei4+oKMs12REWu2IMpWLRixKBgfjl7NCY0m9/1/czhzsJ8gl12Eh6FVmkMjwKRYBwjqis0UMj67Z2+qkvzUMr3ETxHPkqq9ujKcCvckfJb2eyR6horQ71N8jcQ/nXSb5Kzi96Ra1k8/XI9si2OVp0KpqjmkFrSdcZ+OYzY4tvrrHr6ryY43+/kCMmHxlp6LGsKtx9rCu+pqQT7+ThLa2G8jtu0KIBeCMUneop7MgAQr86cPUvLNfBvLVE9ytfnqMtwvTR+Pk2lv7S0d7wxjXpaDfAmTVoXqv3XwDptvBsdk5JZXohd2uAsbw8pEp4A+xpE+ozV2fdx9XZwBbTDFbuYj1TIXOlpyCbLCBg1mNp8GBGZIcP2t3KeUXWJiYSNaB/keplGEhdJoRJU85vYAu19Iw/IH/PtlTFI9fVPzAkNKLCD2Z2JVIQZU7xZ16tIaNKTo2JFPxc0676n7P+hq8gDpCFLqxf9EgbCeVO5BssYRCzuHKWrxgo9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(53546011)(6506007)(6512007)(5660300002)(478600001)(6666004)(6486002)(26005)(31686004)(83380400001)(2616005)(54906003)(316002)(6916009)(66476007)(66946007)(66556008)(8676002)(8936002)(4326008)(41300700001)(2906002)(31696002)(86362001)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGdPVTN0THhBOTYrNkVzemh3VWJURWlIM3hKNnp1ZFJqcHhmVnY0ZVhCakZm?=
 =?utf-8?B?SENJai9TNmdPdzdKSEJSVkR4U1hWeVRHUzBoNlZjM04xaW1STnl5ZTcwV2pL?=
 =?utf-8?B?TDNUU3hvNmgwUzZtMExJZXJucXdCcmVLeDV5YzFNZWNVb1VBNlhpREFocnV3?=
 =?utf-8?B?S3o5N1pybGRFbmRZSVUwMUY3a2ZnMzEwVGczdTFFYS9OWjZ2SEplMlNjcnhV?=
 =?utf-8?B?dDFSTSttUFdlQnFFVWVUS1ZsZXFZdW1lSXNPSWdPZ25BbXJ1SEw4bjdWVWVR?=
 =?utf-8?B?WWVIbFZvdUVBd3NPSWZGVE8zbVMydE9GSkpIVjBtYmNhSG1hVHJCUUhNMmQ0?=
 =?utf-8?B?VmhnQzZyS0tWUzZPVHh4TFZUQ21Td1ZHTGhSMGJzRVQvWHRVelA1VGJqNTh6?=
 =?utf-8?B?dW1OdVgxWDY3Z1g1eEt1VEp0T095VVF3NHFrNGNBNDR4cW5qS2JQYjJkNlA1?=
 =?utf-8?B?M1oyY3RaQUNIdXd5UG4vczZJQkNoVFNCaCtLTElGbWpyYlRmaEcvT1dQa01Z?=
 =?utf-8?B?OUtYYUxKS1lxTGJaTjI2RmVZT3lEcWVQMStsdURzczI3NkMvbzdsbjVFU2FV?=
 =?utf-8?B?SnJsUnQwQmNjMW83ODRIa1YvK2tuRkUranNZcDZjbENwdXZPZWRiZ2ZQenJ5?=
 =?utf-8?B?c282RFI2OUt4RFgvUFZtU081VnhnQzNkY2RLYXdEemU1SEpuaG8xbm4wQ1Jv?=
 =?utf-8?B?dkpqUkxPRFJPUUI2dmZteDJhZUsyZzNiZ3d0NE1IY282NlJ2cHFGeC9YTHF2?=
 =?utf-8?B?alpYU3VsSTJwb0JsWFJTT3ZYTmQyeCtzdFR5UlAwSHB4WjQ0OUZOUTJKcWFX?=
 =?utf-8?B?eXJsQkJzeUZzZVE4Y256bm9jYXh4Y2N1RVRYakJTRHR3Wmc0Q21SSU9NeGdw?=
 =?utf-8?B?bUU5Si9jTEpVRUFYREtFYjR5MHJzNVlwU3M0VkNkM1VMUDUxUTA4Mk5zZWhq?=
 =?utf-8?B?TjJZUHZGUXF1ZzcvbXNVTjBGSFdwMGNGb2M0aE5DSXFHTy9YMUJuOVpGNVI0?=
 =?utf-8?B?d0FNOWpEcHVOa2VKa0VMQWEyUVdsWWJXTkxsN1ZxNkNQaTJJR1V6N1hMQzVH?=
 =?utf-8?B?R0MrSUtrVjhZc21kZHhWMlhVVlhLVHAraC9ySGdqaGVZdFRXMm9xSkZ4bXdj?=
 =?utf-8?B?N0IvQ2cyS3FpYUdYRlUvMWRnaUwxNkh1NkhkMU1yclFRSURmTU1SaksvYzlN?=
 =?utf-8?B?SEh4NGkrV3lhcUlGNzNGOU11UXFiYmNBMjd1bGhOMTdVZ2V2SUNSY0ErTzVk?=
 =?utf-8?B?MDN3TG5VcUh5Q1VJYytXR2luVDF0MlloN1ZadkpFdkxFL28wZEpDNkVxZUww?=
 =?utf-8?B?ZmRCK3orWGNpaG52OFlQd3Q3MXN3My8reWdwMWk0V1dDU1ZaNitaZXdKNm91?=
 =?utf-8?B?SHdtYVFsQ2Q5QXA0N0xXbTRuaFZSb1NZekdOK0RrQngwZ1VtbEd2YXM3S0VL?=
 =?utf-8?B?azNZSEZvbHFHN1Evd3ZCTzRCRHJTTmRGU0xkUkZkYVErckVoYzgxT2t3MVdw?=
 =?utf-8?B?OTVtYVFzZS9NaDIxYmJIbUFWbTBxdGpuRDhsOEdpRjIzVStJeFpXbWlFUVAr?=
 =?utf-8?B?N0YyaVdMUTFKYVd3NkhNWVpiWmd0R1M2Z1p6NFdsYVNPY2tYOTdab0kwVE1x?=
 =?utf-8?B?QnIwNlN3K09yQStQemN1UElMeC9SR0U2TXp1MWdENlJKcWxqVjM5WUtPaWR0?=
 =?utf-8?B?RmdDM0hCTmRNWndqTDR4MW5wUURkMjNhc3Rsa0JrRHRoc0F0THlIQisyU2I2?=
 =?utf-8?B?YVN2Snl5eGRhQ2xZSU5ndGpQeldhOW1oemFyYXEraGtOZGQyUFhLRU5PZ0pz?=
 =?utf-8?B?NjlGbzB2eithcFBPbTgvMDhZYjkyUWZkTjdUWW9tZVh2VXNzcnJTRVNuVXFn?=
 =?utf-8?B?RnpWOWdwd2FUM2ZmalJwTnd5UXhMSkxCRUFCVmt3bjV2ZmlvTGRRYlVNakd6?=
 =?utf-8?B?YTFGUWdZZHNnWERsUm90blpueURvVzA3bWZXNG5TU0ZBS0RFRThHSVpNWE0r?=
 =?utf-8?B?SDVVbnU5MFI0S2lJL2JVRDFKa0pJYWZRR29ud2syR2Jvc1R6cFk4bnNOUkxI?=
 =?utf-8?B?ZXF6UlhOUldmaDNZU0dSa0pOdU95VzUvYjFOdDRhNzZKM0dVYmZhZ0l2NGp1?=
 =?utf-8?Q?DkmIogSVTAj0vhGmB+WiZKfnG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d196acb4-e138-406f-30df-08dc02bdd541
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 07:15:53.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQYcV21fH46mD2fYXbJVMTZu4OWcMVWMiqmVVR03OlKcjkP9zoAPDn8WqGHyGV53YlyVzTB06eiG5zrSBWcVlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695

On 21/12/23 22:08, Vinod Koul wrote:
> On 21-12-23, 13:05, Vijendar Mukunda wrote:
>> As sdw pads enable sequence is executed only once, invoke it
>> from probe sequence.
>>
>> Program required pads for both manager instances
>> based on link_mask during probe sequence. This will avoid
>> acquiring mutex lock.
> something wrong with your editor to have this formatting, you can use
> upto 80 chars here!

Will check.
>> Remove unnecessary delay after programming ACP_SW_PAD_KEEPER_EN
>> register.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  drivers/soundwire/amd_init.c    | 45 +++++++++++++++++++++++++++++++++
>>  drivers/soundwire/amd_manager.c | 18 -------------
>>  2 files changed, 45 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
>> index 5c9569d9ad01..b3b3c7266384 100644
>> --- a/drivers/soundwire/amd_init.c
>> +++ b/drivers/soundwire/amd_init.c
>> @@ -15,6 +15,47 @@
>>  
>>  #include "amd_init.h"
>>  
>> +#define ACP_PAD_PULLDOWN_CTRL				0x0001448
>> +#define ACP_SW_PAD_KEEPER_EN				0x0001454
>> +#define AMD_SDW_PAD_PULLDOWN_CTRL_ENABLE_MASK		0x7f9a
>> +#define AMD_SDW0_PAD_PULLDOWN_CTRL_ENABLE_MASK		0x7f9f
>> +#define AMD_SDW1_PAD_PULLDOWN_CTRL_ENABLE_MASK		0x7ffa
>> +#define AMD_SDW0_PAD_EN_MASK				1
>> +#define AMD_SDW1_PAD_EN_MASK				0x10
>> +#define AMD_SDW_PAD_EN_MASK	(AMD_SDW0_PAD_EN_MASK | AMD_SDW1_PAD_EN_MASK)
>> +
>> +static int amd_enable_sdw_pads(void __iomem *mmio, u32 link_mask, struct device *dev)
>> +{
>> +	u32 val;
>> +	u32 pad_keeper_en_mask, pad_pulldown_ctrl_mask;
>> +
>> +	switch (link_mask) {
>> +	case 1:
>> +		pad_keeper_en_mask = AMD_SDW0_PAD_EN_MASK;
>> +		pad_pulldown_ctrl_mask = AMD_SDW0_PAD_PULLDOWN_CTRL_ENABLE_MASK;
>> +		break;
>> +	case 2:
>> +		pad_keeper_en_mask = AMD_SDW1_PAD_EN_MASK;
>> +		pad_pulldown_ctrl_mask = AMD_SDW1_PAD_PULLDOWN_CTRL_ENABLE_MASK;
>> +		break;
>> +	case 3:
>> +		pad_keeper_en_mask = AMD_SDW_PAD_EN_MASK;
>> +		pad_pulldown_ctrl_mask = AMD_SDW_PAD_PULLDOWN_CTRL_ENABLE_MASK;
>> +		break;
>> +	default:
>> +		dev_err(dev, "No SDW Links are enabled\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	val = readl(mmio + ACP_SW_PAD_KEEPER_EN);
>> +	val |= pad_keeper_en_mask;
>> +	writel(val, mmio + ACP_SW_PAD_KEEPER_EN);
>> +	val = readl(mmio + ACP_PAD_PULLDOWN_CTRL);
>> +	val &= pad_pulldown_ctrl_mask;
>> +	writel(val, mmio + ACP_PAD_PULLDOWN_CTRL);
> updatel() local macro?
We have identified similar update() inline function should be used in other
parts of the code with different mmio base address. We will push it as a
separate patch.

>> +	return 0;
>> +}
>> +
>>  static int sdw_amd_cleanup(struct sdw_amd_ctx *ctx)
>>  {
>>  	int i;
>> @@ -37,6 +78,7 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
>>  	struct platform_device_info pdevinfo[2];
>>  	u32 link_mask;
>>  	int count, index;
>> +	int ret;
>>  
>>  	if (!res)
>>  		return NULL;
>> @@ -50,6 +92,9 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
>>  
>>  	count = res->count;
>>  	dev_dbg(&adev->dev, "Creating %d SDW Link devices\n", count);
>> +	ret = amd_enable_sdw_pads(res->mmio_base, res->link_mask, res->parent);
>> +	if (ret)
>> +		return NULL;
>>  
>>  	/*
>>  	 * we need to alloc/free memory manually and can't use devm:
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>> index c27b0b0f33a6..1427cccfc309 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -26,23 +26,6 @@
>>  
>>  #define to_amd_sdw(b)	container_of(b, struct amd_sdw_manager, bus)
>>  
>> -static void amd_enable_sdw_pads(struct amd_sdw_manager *amd_manager)
>> -{
>> -	u32 sw_pad_pulldown_val;
>> -	u32 val;
>> -
>> -	mutex_lock(amd_manager->acp_sdw_lock);
>> -	val = readl(amd_manager->acp_mmio + ACP_SW_PAD_KEEPER_EN);
>> -	val |= amd_manager->reg_mask->sw_pad_enable_mask;
>> -	writel(val, amd_manager->acp_mmio + ACP_SW_PAD_KEEPER_EN);
>> -	usleep_range(1000, 1500);
>> -
>> -	sw_pad_pulldown_val = readl(amd_manager->acp_mmio + ACP_PAD_PULLDOWN_CTRL);
>> -	sw_pad_pulldown_val &= amd_manager->reg_mask->sw_pad_pulldown_mask;
>> -	writel(sw_pad_pulldown_val, amd_manager->acp_mmio + ACP_PAD_PULLDOWN_CTRL);
>> -	mutex_unlock(amd_manager->acp_sdw_lock);
> so the code is copied from a GPL declared file to now and GPL + BSD one!
> Have you had lawyers look into this... why change one file license ?
As per recommendations from our legal team, we have updated the license as dual
one for amd_init.c file.
We have also observed that license terms should be updated for other files as
well (amd_manager.c, amd_manager.h & sdw_amd.h) as dual one, which we have
planned to submit as a supplement patch.

>> -}
>> -
>>  static int amd_init_sdw_manager(struct amd_sdw_manager *amd_manager)
>>  {
>>  	u32 val;
>> @@ -872,7 +855,6 @@ int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
>>  
>>  	prop = &amd_manager->bus.prop;
>>  	if (!prop->hw_disabled) {
>> -		amd_enable_sdw_pads(amd_manager);
>>  		ret = amd_init_sdw_manager(amd_manager);
>>  		if (ret)
>>  			return ret;
>> -- 
>> 2.34.1


