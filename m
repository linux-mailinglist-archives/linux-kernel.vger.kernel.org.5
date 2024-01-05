Return-Path: <linux-kernel+bounces-17883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4859382548D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C779B22863
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A292D63E;
	Fri,  5 Jan 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yi/kVB36"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E67C2D78B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTo/NtLCrqWhnEmr76bN7s6/lS9bbwRntx4UPN0Us2/DQ0TLLqJewEzPP5IXgbU7hhMKaEXqB2KtniZRgYI38EKVLC/8XLqCotuvw7ykCUHsn1av05vgWEG9y9QN9rIp5NhKS9o4yxZpaXJcRC7hHtDLBJt8b1H2UFxOE4uZIav9sJxEAUzEudk/o4MRdzd7P+aGicM6rl/aE/2eR1Vwy561JZbQWsEapXwRP7g4NDwjfYq9M55KwxG7i2qBBKyG5buPyt5ySsB/11r3Ib9dgxNPm9lLyC/U0hLzy/CtVB2K7d63VYmCL5z7jNag1Wu09HrA6AIgU50nyouvqXbHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6E2YH/eFuruQG7kHIg5CKm3yildiEcjCowZiC5f0guc=;
 b=F10uPtBTs9+6+VOu538A30lTVnD8Fuj9eA4CpxyteKjeDoteoefRnvWhLWVq6RscpDQq3z8yeT1uHN4VV8eKo3i9QNvH4KkQ7vGbooHw2uVUnBsqNQoHB7WtNyYcpQThDIaLjbrh3bg73LCCr4jpeycKHkpvsBBV89lzFJVDecOpUfO/hnRwFEXIujcUq0gM/7I5wKBPhqINMKQ5KmUr0F9nELsBXL9/t2bzW6ekI/pqsuCsckOKKdNMLTxUCY+XhxpSdxUZePptqzEdh5SUWVAz5FBuNYVwcKEzfFfXe5QpqcRbGjrjBmdpTZUBl0wWY4TLYqJXOzxHfHJAovi8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E2YH/eFuruQG7kHIg5CKm3yildiEcjCowZiC5f0guc=;
 b=Yi/kVB36zaDkHBR5zhXYdh2JgJPkEtiddAHCx7gLn4L8C5BLiK+NdV2HMg0DxN3gd6TcZ7NUO2q9pLWRyBtayzT+JqjEjmqMiGW4LGMfqgsKK5hc++64uuv/61P1L36lJBH3vx+fpWN/1sP60NEMk9dqPdJT2WwzSXU81yD368g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 13:39:20 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 13:39:20 +0000
Message-ID: <447e7e1b-97ef-4570-80dc-72df618a0b3a@amd.com>
Date: Fri, 5 Jan 2024 20:39:14 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] iommufd: Introduce data struct for AMD nested
 domain allocation
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 eric.auger@redhat.com, vasant.hegde@amd.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, Dhaval.Giani@amd.com, pandoh@google.com,
 loganodell@google.com
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-5-suravee.suthikulpanit@amd.com>
 <20231213140359.GU3014157@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20231213140359.GU3014157@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 571dcdf8-d798-4ba6-31e6-08dc0df3b85a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EX/8EefEngy9v8WhH6vwuMzRFOIOXRFSZY0XA6PlHPGJevN1xpY45+1IhoOeVGyH6LWseyGIBDfMSLb0Gfbv6hIxTR4CNmP+MliU1Mz3tk54zi4SFmBGyn8C1ZBxNYuAIROSdS1OvMrFEUAzNDCVX/Vzw0IcbfyYqGbWQ0+hQhtxcW9fh+zu5dDDHu7EbILdI7/gCOmRcCLwoa/kjeiplhPD1QXcEQKxkh8djY+gh/cQOIjwGycYxtebOsBH/SdJu8NDONw3mhftyZKB3CJI2pbLtSCktzriVCaxneKElOes4by4KzPGIwyRnC4EJVXAmCZtkNz5k1Yun9B2SepOg4s5SMRVeRpfNAtKd0RFSZVnklpfWUPShDErKpHno2SQWY+1yYoWEf2i1jRWZPgh0MGd+KRHbJ8xpt1tI4oj1SK6lp46SNdC17hW6m6qlPQ9EHW2fV5nDmSaaAwRwXX13xNx4BFtntY4F5NqPDeQGFFZbdhB/VAQ46AVucfuAuhtXbnS51dCaGCWNHwG0RQrXecETgG5n/zrIXXCAOpX4jxHCNq9wdgJPYwfZ83Df/QZjLDwHdr2TeH2fVnNoh+FCi/YREvYmfQPpf8OdmGrmO9WsBWSakboKfFIcwfdDXTezXyyj4HeGI+aIFBdXPXGNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31696002)(6666004)(478600001)(26005)(86362001)(83380400001)(6506007)(6512007)(53546011)(2616005)(8936002)(8676002)(36756003)(41300700001)(5660300002)(66476007)(6916009)(66556008)(7416002)(316002)(66946007)(2906002)(4326008)(6486002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE1YbXRyL1RGb3JXclh4S3JaL2VPL3NISXdCMHVOcW9ldjVObitwRTVXeUI2?=
 =?utf-8?B?b0g1a0dyanZ3T0FmbmtnNXdUT2swSjM4Q3pCTjZlTERNS2tHaDI3a1lPU0xh?=
 =?utf-8?B?WVRYYzI2MWxOZGwySjlVS1ZpWmZWdWpNMVVqSUhwd1d4aFNTTzNBb0VpVUNT?=
 =?utf-8?B?NnQ0eGdQSWM4TFU4cGFBVG1mOUV3NVNULzBWS2MybG1xZDBLTjVmY3FmU1FL?=
 =?utf-8?B?Lzd2VW1qeVRtTEVUZE9yK2JST0FCeFNwUjBKNCttV1ZJUWthVW1iN0VPVzN6?=
 =?utf-8?B?a0EwMW12VExBNEJ0dXhoZmRlQlhJbkhpeEgzS25LVDRKK29QN2gzdUhHdm55?=
 =?utf-8?B?RHo0aWw4WmlYVXRJZElteFd2YWpuei84S28zam1uK09TTW5CYTNCSGZXWVlv?=
 =?utf-8?B?bkhjYlZIZTh0dlU0UU5Vd0VDMm5pS2ZXRDdGMnhRUFlFUUhKWm5YaGprdDhz?=
 =?utf-8?B?WFk3MGhldFhMSklTSFhCbE9mb1Z3OHFPMjNzdTVtVWVXbGRhQkhpWE1seHRl?=
 =?utf-8?B?WXVwUTBjalo3a0M4OGY3c1E1aXJMWUkvNFZSR3V6eDBrWllRVlZLN3BIZUxF?=
 =?utf-8?B?ZWd1MmhLa0VzbkZic05HalBNUUJEMk1VcGRwbnA1ek1WdkxJRnBLOVhwQk5k?=
 =?utf-8?B?MEhYK0owdDlkTjhWRVI1V1pQaDlJNEZjWGIrTjJWeXBEaHcvVWJKMzVsbXQx?=
 =?utf-8?B?Q3k3TGlqTXZrelNwMDA5SnZiQzdlL2dHSmEyajlIb29iUkMzYm1yM29BaWFs?=
 =?utf-8?B?dlFLNmNnR0Zmd3UwblRjK045cm5FQmtvQzNCSEFtVmtYbEZpa2ZqZWUrd3h0?=
 =?utf-8?B?dGVXeTJsVXljMUlaOU95dlpaU1VoQnFlb3llVG4wRnE2ZUMyUVEvMVpUSGdE?=
 =?utf-8?B?VFg0WjFWNkhaajdvZEdkWXQ2Z1RGRzkxS0JTYnJkMFRtbFZteEZBemsvZTBq?=
 =?utf-8?B?TW9NVEIreTFOUXZRVW1xNGtOVml1cUthZlBIVklNRzN0QU5PK25HZEdCQ1ky?=
 =?utf-8?B?dG95K0dTUmNJSlk2WThMZTNWQXhpU1EyUXVFTTBPK3BUL2NVYlYwRXNRK0xS?=
 =?utf-8?B?NjN4RnNBZXdaWGdYOEtFNWdLWHpzOGF2ZFltOXdVV2NxT09KZU1RQ1VWaTFI?=
 =?utf-8?B?SjN1YStaRDA3bzhMRlFQTk1wWmpKSXN4RlFqRjJKam5MeW1jZkgwcm9wdXQ5?=
 =?utf-8?B?OG0wUjFxOVV6VWZ6eUJLNXJ1WmdSdUVYVmVVS2dhVkhrOXc3dGk1b0w5WlI0?=
 =?utf-8?B?THBJaWY1akVRa1U0UnR3VVBhbU5UVm1CVnhXN3N4TnNEWnlEYTNmR1plTzh3?=
 =?utf-8?B?bTVnRU0wdHdRazJtRmlscklvNWx1S3pRaHVyOE5tbURZQ3BLMW5uRDF2dE4r?=
 =?utf-8?B?aXF0dllIOFF0ZlhYWkVtSDNlS0psOXQzYjBBdXgzUFpSa1g3eWl5dlREUU1k?=
 =?utf-8?B?dklscXRqVEFUQkNHajFEOEhyZ1pWVjhzVEtkWUVqbXh6QUlOTWdwNmxrS0R5?=
 =?utf-8?B?QVptWHUzM2x6U1hxSGVFNkpvTHl1T2JabnBHbFA5WU9oTVZXb0hiWm9udHpG?=
 =?utf-8?B?VHlqSlYyOGI0dUdtakN4NUV0K24xbWVLM0FXVnRicEdTamJoYnZqekhHY3lH?=
 =?utf-8?B?d3V0MmR1bGgzNVRVZFpHRXR5TWdmeVFxZitxOFRpYml3NFgzWC9FTzdqd2Nl?=
 =?utf-8?B?RVZLZ2t3OWlyazNjUmp1YTc1S3VxU2U0NExXb040K3pYamdjbjd4dE52K3Ey?=
 =?utf-8?B?TEwrcGtSQ01oS0FWaWJGVFBnekZNZ0kzbVlINHd0MktuMUtEZ1U4RmI0VXRt?=
 =?utf-8?B?SjNZYlgwL0FURnNlYXl5My9zRVJzWWRVOW9FZnIvQjdUZlNNUHl6MVAwNFhl?=
 =?utf-8?B?UVNNZCtJZTllT1lINnA3VzErcmxucUZCM0cxQlZKNzB0NU0zY2RjZUpEbVhj?=
 =?utf-8?B?LzU1QTR4T3FOdjZka0JoRjRNeGpubk5YZTN0UFpzTVpPNjFCQTVXQU5JZUs4?=
 =?utf-8?B?aUg5T2xMOUliZ053SXN6UDkyckNtb2VpZFNMTTZJTkJZUkZuVlBwKzBWM1Uv?=
 =?utf-8?B?aVkzRktLblhyY3V4L1cvV3JLdDhSdTRHSkFYQ3Z4NG8rcnJWNnR2L2ZBKzlZ?=
 =?utf-8?Q?2HWfycdsxagc7oY0SOm6bLckf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571dcdf8-d798-4ba6-31e6-08dc0df3b85a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 13:39:20.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXgPSmAzkbOkQs+vFFlyX07XekWyQdeXqnMJ/Tu9X0qiErILV6Tq4Quu43KIk3+v99HxsPWKXYtDe5yiexh6Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

Hi Jason

On 12/13/2023 9:03 PM, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 10:01:37AM -0600, Suravee Suthikulpanit wrote:
>> Introduce IOMMU_HWPT_DATA_AMD_V2 data type for AMD IOMMU v2 page table,
>> which is used for stage-1 in nested translation. The data structure
>> contains information necessary for setting up the AMD HW-vIOMMU support.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   include/uapi/linux/iommufd.h | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
>> index bf4a1f8ab748..e2240d430dd1 100644
>> --- a/include/uapi/linux/iommufd.h
>> +++ b/include/uapi/linux/iommufd.h
>> @@ -389,14 +389,37 @@ struct iommu_hwpt_vtd_s1 {
>>   	__u32 __reserved;
>>   };
>>   
>> +/**
>> + * struct iommu_hwpt_amd_v2 - AMD IOMMU specific user-managed
>> + *                            v2 I/O page table data
>> + * @gcr3: GCR3 guest physical ddress
>> + * @gid: Guest ID
>> + * @iommu_id: IOMMU host device ID
>> + * @gdev_id: Guest device ID
>> + * @gdom_id: Guest domain ID
>> + * @glx: GCR3 table levels
>> + * @guest_paging_mode: Guest v2 page table paging mode
>> + */
>> +struct iommu_hwpt_amd_v2 {
>> +	__aligned_u64 gcr3;
>> +	__u32 gid;
>> +	__u32 iommu_id;
>> +	__u16 gdev_id;
>> +	__u16 gdom_id;
>> +	__u16 glx;
>> +	__u16 guest_paging_mode;
> 
> Add explicit padding please

OK

> Also, I'm pretty sure that most of these IDs cannot be here.
> 
> These are Ok:
> 
> 	__aligned_u64 gcr3; // table top pointer
> 	__u16 gdom_id;      // virtual cache tag
>          __u16 glx;          // configuration of radix
>          __u16 guest_paging_mode; // configuration of radix
> 
> These are confusing, probably incorrect.
> 
>   +	__u32 gid;
>   +	__u32 iommu_id;
>   +	__u16 gdev_id;

> iommu_id is the RID of the IOMMU, so definately not. The iommu
> instance to work on is specifed by the generic dev_id which becomes a
> struct device * in the driver callback. Access the target iommu
> instance via dev_iommu_priv_get()/etc
>
> The translation of gdev_id to pdev_dev needs to be connected to some
> future viommu object, so this shouldn't be part of this series, and
> will eventually be provided through some new viommu object API - see
> my long outline email

Got it.

> The viommu object should hold the GID. I'm not sure you need a GID
> right now (can you just issue invalidation on the physical side?), but
> if you do need GID to bridge until the viommu is ready it should
> probably be allocated by and stored in the nesting parent.

Currently, the GID is needed when setting up domain ID mapping table 
(and device ID mapping table in future series), which will be moved to 
when attaching domain to a device. By that time, we should already have 
GID information already stored in other struct (e.g. struct 
iommu_dev_data). So it should be alright to get rid of GID from the 
struct iommu_hwpt_amd_v2.

Thanks,
Suravee

