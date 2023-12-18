Return-Path: <linux-kernel+bounces-4428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A4817CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AFA2824E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4945E740B7;
	Mon, 18 Dec 2023 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XbCd2IGn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355B6FB6;
	Mon, 18 Dec 2023 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ib9zVyJM/RfIrXcnOtgrxeN+F0lc2Mca/hGSZiE/hvIuT+XQPnt2mlSMxKXf7sUATzKp8vhrrw2oENZw47koRGtZG/J3LasMCzKTjVv5z9jvY5WsfUyZN9BIP+GcFm0M11Iqm4Fp+2MzqFdwSCuST2j/2FHfo9RXl5gX63/G74tYpeB5zmMiwryP6rYtD/vdGcSo4T1o0Q6afdDyXyFf7X23Nge7vu3YVk6gdXCjagh8Mg07i2bgOE/Uk4wawB9dy4cooEHgwAi3jVof8OXKR9Sc0ygqBq7JQIv4RwNVcMKci+91/WPNSVUALHmKbdYUTDX8BD4YAB8Lss6+7F3wfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGyHTbOT88Y8fM0Q0GPk5Kuw5+pxBupo9crxVorAtgA=;
 b=aDv4MAMK/qKq6l2x8EJlXW06UV0cqNs9+yqKWMgmTSnL5TryLkAcZsdRYT8SiT3y3nrKRLg9GS/xs+Ma5jsribv1wDv9fGE1F/l4y78PluZSajSMz3jugXXO85j0n6vi47Jj71bFNxuRvGPmwmjNyfaAqD9ZisoN6Uz1jjYYkAPrxtYUb1BqAowqSHUu+OFAXRMEFQLcNr1L/eVAnl05D1yTT5yIZ+z9tvR76GZW9Jy1/tjhiU5v35vZjkLpAraOkSQEIIL7803H3tUqiedGcFyF4WgNi3Gqj5PxpvrABUW4d+w5jWqvDhKEYBenCosigIXlij4RG+RgckkfOXwvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGyHTbOT88Y8fM0Q0GPk5Kuw5+pxBupo9crxVorAtgA=;
 b=XbCd2IGnpZepx00yLizIxsnCyLejW4vxlUrJgwkoOaFiQJdl+T4ImYYzM333g0mN9hBCyqPkZsdkOIkt0o+MM/9LM8Eo2RNviaZXFINSz2D4uyug/B639rC9b4CoeA1NbZatLhpGkmDaOFAOsGo5BoEBhgz0hQQ71ldNboQxy6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 21:53:27 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 21:53:27 +0000
Message-ID: <2f114c41-5dbb-4019-b0f1-046509521d44@amd.com>
Date: Mon, 18 Dec 2023 16:53:24 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
 avadhut.naik@amd.com, tony.luck@intel.com, john.allen@amd.com,
 william.roche@oracle.com, muralidhara.mk@amd.com
Subject: Re: [PATCH v4 1/3] RAS: Introduce AMD Address Translation Library
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, bp@alien8.de,
 linux-edac@vger.kernel.org
References: <20231218190406.27479-1-yazen.ghannam@amd.com>
 <20231218190406.27479-2-yazen.ghannam@amd.com>
 <42c6ed78-75bd-4b4b-8b59-e0562d4968aa@wanadoo.fr>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <42c6ed78-75bd-4b4b-8b59-e0562d4968aa@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:408:fc::28) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fcb442-e69a-43a6-2be8-08dc0013c3be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0q0t/Hm/5VmYgXX5HU9zKnumXqgT8O49xRTN7OdzKGYsUR92v4FASU00XCbnvT4ddtmKH8/3HJEiqGsxV4D9XUzf29YPibEGhueJsrYePLuYVpDDuBQm3gzLz/QObkairF7CfsuAJB1tvKoSFeKGCZLl6GX4oaEtWd+z6VxCwDKuwKRY2AK9jSv6kWOl2yWHRcuNU0VxWmFwMI3N3uOQout5ksRhQ+XyzBhXm4eI3/A6JnBII8fwGaE7JMxsSOM7QYIayrO9/vKKwkpv5Bh9q8NcE53nwo5yJyQfbc+HHW9Gggb/ll2g+zHB8FLEf/jGCkyYZR13JXADfiZQoWjuv6be8E+jNoh1WuH5Gnaq2AITZbUlZmbn09HnTFcJSYLeGQPvM5lSlsNabVrctvaSrr0YvyY+e8mDj6C5/11hBEsZwCsYDOvKOCbqDC1mefKAiXy9mY5bsiIJ2+qk3Sm6KqcWmdWUOW6wvFcd9H7m6XQ2Vu99ruAi3uhEJMdSZE8lhHZbX7BI/6dL9qoe36qYSAHY3pgx7HBeWynYjI9cqCNAY20JXhPwUxjnexN3l3pnlIY9Wq0co4q5yox34YyN5rPUTzGK3GsnNvqS2DVL+AKcDVPVS+wXuXsqYU5ZgaF8NdGDWd6aAVMjQTnra7TzRg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66574015)(2616005)(26005)(31696002)(86362001)(38100700002)(36756003)(5660300002)(44832011)(6512007)(53546011)(6506007)(8936002)(6486002)(4326008)(66946007)(316002)(66556008)(8676002)(66476007)(83380400001)(2906002)(41300700001)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3ZLS2ZzNDVwbHN4TU10UTlCakNEYW5VdDdKN0JEczk2Y0V5dUZpRW9jRm5M?=
 =?utf-8?B?RXRIQzF6MWZWOHpBRTk5cnBmYWFLUVl6c0ZaazZqRE1yS1RzZUhFK0t5K3pL?=
 =?utf-8?B?T1o0cENxWjZjb20vUDVSWDdmczZzL2NrL1NJUFhCNFIrMkQreE1scGVmaVl4?=
 =?utf-8?B?UHB4eEV3K1JSM05meGNnQVEzbmNpQnFEVUtiTlQ0Mkg1TTQ1Mi9hNWwwNU1U?=
 =?utf-8?B?bVZSSzFzQ1B6MnhUa2tKZFRsV2VvK0cvL1JmQXVSYlh4akd1bmRBSXZQd3ps?=
 =?utf-8?B?enp2ZmpZckdxbE1PTHJRcENFelFIc2phaDhFT3ZHTnZxd29JMVlYb3B1eFBC?=
 =?utf-8?B?ano2UnZ5V0o3Ni9nN0ZDRi9acE9hSmUvMGcxWGVPUk1BN1ZIZFpKWXg2azgy?=
 =?utf-8?B?Wkh3WThpWVJ1akNqKys2TFBpV1NmOWJHMzNrRWkxRHVlY0krbnpub1dmTEZY?=
 =?utf-8?B?SG9qZHpEODFGdDF2S2FsVkxHM0ZYQzdWc1JJdHdabGlwbW1qcGtTZFF6ZkVp?=
 =?utf-8?B?QTY5aFZiNVppaW0yK2tPUlpndmVBQ2dod0ZHZU1Cckxqd2xZeXJFMG4vQWdJ?=
 =?utf-8?B?bHRWTFhQZFErK1VTbmk0ZmFQWVJObDZUWTZyT0VFT2tzYUNldzB5aVBKZWVZ?=
 =?utf-8?B?Um1qd0pxbmJRU3VaMisvMEcyNXNvTVZ6bGdXUjUyejZSaHhtUjZmVUlvb3ZN?=
 =?utf-8?B?U2VvVGROeHdXOGpRakJUZ1ZoR2w1bDhlYWZkNzhhQ1JneGt2YTFTazZCdVEy?=
 =?utf-8?B?Y3FwekoxRnBPaGVxemhBS1dObWFvV2F4Y3hDamkyWUd0VnFYNlkzbGIvUktz?=
 =?utf-8?B?aElSUkFZeForTUdzSWdtdzc4alF5MUR3ZGdZaEV3cXRlS0pyc1ViamlZcmVQ?=
 =?utf-8?B?YktqbW9mbVBlYjRKNGpPZFN5Qm1wZjVXMlhkUlU2Mm0rTmtyYXQ2R3hrcDNP?=
 =?utf-8?B?NTkrVHFjcGlGcEJFTzF6QmpoelBzRFZwTW1icGlSNXBTVUJjTGJDMmMvWHZL?=
 =?utf-8?B?cnVlaURxeDg5bk9LRWhGY3NNMnJqVDFVRUFsTHZGQlBNVWJFR0x3d3dsZEow?=
 =?utf-8?B?bFpjbk9GM25LOFNFSXZOcFc4RExFSWhGOUFHMkZtTFRMV1R2a2dZVnF6T2Zo?=
 =?utf-8?B?TkkwcTB5TmMva0c2cjI0UzdTVFZVVzA0QmtjOU1jaTNiMEkxNGpXT3RiVG44?=
 =?utf-8?B?MzRRbXdHZTA3T29NQVowVGFtK3JPSlI5YjRjNlRzSmRjNWgzUmZucmRWQXhU?=
 =?utf-8?B?K1JvbjNoc2MrbmcrWlkyNVBzSkpHUTkveEgzLzhOUUNNd2ZscGdOMDAzRkJZ?=
 =?utf-8?B?NjZ0MS85UmNlRG00Z2IvVXZGejI5U1I4dkQrN3E5L09obnZDeGtJTlV5eTA2?=
 =?utf-8?B?RjlPS3F6VnVaWlJSYmdqWlFGSkM2ZFZnQ2VOSnZBMVJMNkxEclBUOEUxK0p2?=
 =?utf-8?B?dlhvam1ueFp5ekdhbWZzMGVHRXJOZEkzd3hhRW1GTUJubGZnbjdDZlBMSS9j?=
 =?utf-8?B?OVpvRVlZOHg2NEh0Y2hrUm41RW52eTY3LzRqK0htNnVsTTFINzU4cS9BcEhq?=
 =?utf-8?B?U0VzQStnUmlXTXdTbmJqSVY3clgrREhiazlyaTlISWpVQ0M0d0lIdEh0WVRS?=
 =?utf-8?B?RzFRTWlCdVA1M1RMNFlOLzc3MEJYU20vRWpXSTk5RU94STY4amQ1MEoxTi92?=
 =?utf-8?B?RmdTMEtZQ251dm1kb3d2MkJZc1NvVWwvM0RXL3QzQmtyeHlaaDFaa3VCaVZ3?=
 =?utf-8?B?OTdaMURtaE9ZUTRKck5DRzlYSnFyeG50SkJUcDluTVo5cU41cy9GbExUNXdG?=
 =?utf-8?B?dXZmMHczbGppL1JLMGZLM1FxYkxUanVnQy9BSTBYUHhlb1RwWG5EbEJVNlNp?=
 =?utf-8?B?c0xETFBqZU1qcThJSS85ZEptMHUrMXF4cUtHRm0zTTcyQUZNMHBDY0tXWHZV?=
 =?utf-8?B?Q0dDMnNFNEhGTmM4cm44L2IwZHBDRlR3OEM4VHdhSlpNQWxoMFAzZjN2cFZY?=
 =?utf-8?B?dC9KejFsRUNnWVVjMi9nTngyRU9nRUZVWGNzRGRGTHJGZHBrcFVhZFZDM2U4?=
 =?utf-8?B?aUN6MXdGMzBOdTlVbUs4enFEU1g0YjVxd2pGV3NyU0I0TEZSckswVy82aFRC?=
 =?utf-8?Q?HpIvp9Ob6svd0ripd4M7iKhUa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fcb442-e69a-43a6-2be8-08dc0013c3be
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 21:53:26.9909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTf6AGsRBbWIYzB5UneXdIPXXwuQPiKBzmrrNp661WsyarLs/bWV/v/ZD7lqstGRzpUEqIvYrXkXn/Js4L/Rzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942

On 12/18/2023 2:21 PM, Christophe JAILLET wrote:
> Le 18/12/2023 à 20:04, Yazen Ghannam a écrit :
>> AMD Zen-based systems report memory errors through Machine Check banks
>> representing Unified Memory Controllers (UMCs). The address value
>> reported for DRAM ECC errors is a "normalized address" that is relative
>> to the UMC. This normalized address must be converted to a system
>> physical address to be usable by the OS.
>>
>> Support for this address translation was introduced to the MCA subsystem
>> with Zen1 systems. The code was later moved to the AMD64 EDAC module,
>> since this was the only user of the code at the time.
>>
>> However, there are uses for this translation outside of EDAC. The system
>> physical address can be used in MCA for preemptive page offlining as done
>> in some MCA notifier functions. Also, this translation is needed as the
>> basis of similar functionality needed for some CXL configurations on AMD
>> systems.
>>
>> Introduce a common address translation library that can be used for
>> multiple subsystems including MCA, EDAC, and CXL.
>>
>> Include support for UMC normalized to system physical address
>> translation for current CPU systems.
>>
>> The Data Fabric Indirect register access offsets and one of the register
>> fields were changed. Default to the current offsets and register field
>> definition. And fallback to the older values if running on a "legacy"
>> system.
>>
>> Provide built-in code to facilitate the loading and unloading of the
>> library module without affecting other modules or built-in code.
>>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
> 
> ...
> 
>> +int get_address_map(struct addr_ctx *ctx)
>> +{
>> +    int ret = 0;
> 
> Nit: unneeded init
> 
>> +
>> +    ret = get_address_map_common(ctx);
>> +    if (ret)
>> +        goto out;
>> +
>> +    ret = get_global_map_data(ctx);
>> +    if (ret)
>> +        goto out;
>> +
>> +    dump_address_map(&ctx->map);
>> +
>> +out:
>> +    return ret;
>> +}
>> diff --git a/drivers/ras/amd/atl/reg_fields.h 
>> b/drivers/ras/amd/atl/reg_fields.h
>> new file mode 100644
>> index 000000000000..6aaa5093f42c
>> --- /dev/null
>> +++ b/drivers/ras/amd/atl/reg_fields.h
>> @@ -0,0 +1,603 @@
> 
> ...
> 
>> +static void get_num_maps(void)
>> +{
>> +    switch (df_cfg.rev) {
>> +    case DF2:
>> +    case DF3:
>> +    case DF3p5:
>> +        df_cfg.num_coh_st_maps    = 2;
>> +        break;
>> +    case DF4:
>> +        df_cfg.num_coh_st_maps    = 4;
>> +        break;
> 
> If 4 is the correct value in both cases, DF4 and DF4p5 cases could be 
> merged.
> 
> CJ
> 
>> +    case DF4p5:
>> +        df_cfg.num_coh_st_maps    = 4;
>> +        break;
>> +    default:
>> +        atl_debug_on_bad_df_rev();
>> +    }
>> +}
> 
> ...
> 

Yep, good points. Thanks for your feedback!

-Yazen

