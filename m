Return-Path: <linux-kernel+bounces-17884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E2182548E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E82B22BBB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BBE2D78A;
	Fri,  5 Jan 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iK4YuXlz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2252D61B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLBDtjqDs5VqVeZ7kIHyjmvGTrX//zZgyr/dcajB0XcP1F4TwBdgCLtN5Ob50+mBW8W8lEkl7sKbsIj7RjNAYZsmaTSvo7iInXiHCr/vMtbsrutFMNaSLnv4VtauXKg3AaD9wwAZYcOwqcvOsNzqaA4Tt6LTuui23ifdBC+KUkoGcKX/onPLX2kqO784DSLXfHr2oUY4G2l8ajSc8NCBfRPyx1TER3n8dbF2OpbJ2oh7FScK7zUut2Vg5S20vAxii/Cjzx1rD1tsfGqGNCSrbnETVK9qBWWAGyRD7QdM5VpFQgAiIgiRzsa7u++F8hxT5X0raJs9j2F6ZvbSuWLfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eUA8LYzbUyVPZZZR3h42EzpM2J33F95geq0w75Nsyk=;
 b=BJUSVcPXnHFjnesK1LWO6CqJzYvRWnvhFzISjw8F1st/3IG6E2lbbyeCTZdkwbd8xHUXEcg+ktyWDKxXWMRnwB/IzXIHLGTYMhwYPjeEXWU+eCBqU0PcmOzg+camTk8PfAzvO2B+N70rMmzNNQi2/RjZkco/KKI34Bw6VoelnT+W/00pym7UTcE4SNu3FFEsf8g4FGHQ2/VsOYEQ/oT11Q/Y89wA/Xux8OFsNfMENvCUI47XOODglRTKMW8hzSm3kr4u3cdY7zg8scMlg+HjxF70aTFNO2b8VGfElgwAkkHRZqwwIBmBp5M9TkdHKFGEzalznEyX0CTisyDgK19bFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eUA8LYzbUyVPZZZR3h42EzpM2J33F95geq0w75Nsyk=;
 b=iK4YuXlzCPFDy/NIMTaSFApW23T4PHGRGmb0iwxKr0H0jxBDOBf5XSdG9YUJrKs7AsN59zZ7CUxvbUSsrVICdyeoN/AUqP5OLBFeL9hCMYnxv/U2cHSJ643f6TOGwt+lq9cuZxvzjvNXJinL32nu1e1XiVwNkEyTMygHYFhwINI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 13:39:32 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 13:39:32 +0000
Message-ID: <8ecc6de8-825d-4518-af75-6ba590a89024@amd.com>
Date: Fri, 5 Jan 2024 20:39:28 +0700
User-Agent: Mozilla Thunderbird
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [RFC PATCH 2/6] iommu/amd: Add support for hw_info for iommu
 capability query
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 eric.auger@redhat.com, vasant.hegde@amd.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, Dhaval.Giani@amd.com, pandoh@google.com,
 loganodell@google.com
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-3-suravee.suthikulpanit@amd.com>
 <20231213132721.GT3014157@nvidia.com>
Content-Language: en-US
In-Reply-To: <20231213132721.GT3014157@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: e011a95b-d40f-4a3e-60b4-08dc0df3bfbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uFgLQAFJw+Vbd8s8imom9XNKncocfARQwSD1907jWDBLveIS2ljU+6inUgvzZothGINgldD91V/ONesUWmZ8c/4fpGS3nXL7tK/ZUzMTXbneOB0CV0yJ0B258GoPkBbiiH0Ve3FQ+E4wSUd0g+HDG9k2ETkQOQGKqFso23BJgiwxQ7ULMhc0AFF8CmELx/kTv8Y7tDe6qrx0iWgTlSEet/60L2DGtGxEVksnBixUPSM72ObTeifKrSejf2fCkBZCutekN1Z1DRAzD++/DgAj8TbCIY6nKx2mFBeO45W7qGwFaMRpMpwlPMWWE2vabpjEBFDOqTkuYb3Z+lANyCDXgBelJU0sJvUH76caQpT2Pu4tVLlIK/B+CnFG8Wek485WMcLcL3EXvwKR33RzMbTpEX1RlBDcugil5NMqZLzVxsP8p/0mXVEaaYnFfFAN7zGDK+nkJkDUuXfnkL3xLJN8sNMdtyDXseFpcTZ9FhBGguKn+EeFrflJBUl5oqTQ6KevZr4Xl9reM6urKozl2MWJdOuDa85itQwP6aQzWEKXxwV3K++L1fpT4HLjXQ8bzBfDvvZl9ylDuV2VBaAhxbZhBvBMAt2mDsKAHxFmdDfurlhx1jjEnIyGjiy8kXc6r2QiJft/aJ2n7Pue8BgFzLIHeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31696002)(6666004)(478600001)(26005)(86362001)(6506007)(6512007)(53546011)(2616005)(8936002)(8676002)(36756003)(41300700001)(5660300002)(66476007)(6916009)(66556008)(7416002)(316002)(66946007)(2906002)(4326008)(6486002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blZVTzdyTzVjcytNY3p2eWlQK1lGa2hKWmE5UWFYalF6WVZnZ2pMMWxka1ho?=
 =?utf-8?B?VjlaWEw3YnUvSzFIeStHZ0RnYURDWGR3SzdrQ0Rybi9tWnl4bmMwNjhSS3Nz?=
 =?utf-8?B?ZTFBMTNCNG9ZTXAyRDZHR0NSQWJHdVhCZGVKR0ZUTm9HTGN0TG96bTBVRHk5?=
 =?utf-8?B?SHozenhNRSs0eVl1Uk9MVHdocXlMVmtLK05rNThvdkNjaXkyZERnOWk1eXhx?=
 =?utf-8?B?SGwyYm5YVTBhNlpGcHl4MzdCcmxlQTdmMFZnWkN6L2dRRWUwUTRvZ1JxN2F2?=
 =?utf-8?B?U0JoRWloZVNZNmxpOGdBck9uVG9KLzdFc040cnppbis5Wld2Y0Y5ZS94bkVq?=
 =?utf-8?B?VUs0dy9CaEdsTk5hWTFrdExIRTNUTzhDZWdDRWZVdnpyT0RZZ3dPeCs0aE4y?=
 =?utf-8?B?VnplbUcwenpPSUlGLzU4TkN4Mjh3c2RxNTlIMVpUQzJPL1M3WWtCMFlsbStT?=
 =?utf-8?B?b0Vza1FyQ3JONnQ3QlJWV3VwcHh5WUZKQWhITTA4WkN5TWlONmNuQW52NHN4?=
 =?utf-8?B?N1R6UWNoNC85eXlLSHptOGk0SUZ6K2o0clRaVDViUkp4cEtzRi80ajZCaFZR?=
 =?utf-8?B?ZngxUnpXRWkrVkdDWGc1VExaTXV6VFliZmhKK2ZmN210RlkxRXVHbk54Y1Nn?=
 =?utf-8?B?VG5tSW9JY3NIK21sYjRjYS9aNElqN3VHcld3d25zVkFxZVVuLzRJNW91S2tZ?=
 =?utf-8?B?REVZUlBRSTN0VGJFUE44QWRJbmFTanA1MWhzMzVFbDVpcE9IQWNKRWxpdktm?=
 =?utf-8?B?Q2Joem4xS0hFa1NmbmpuQTRpRnRqZ1hpSFY3Uy9IblVMVHg1UnE5OE52WmRY?=
 =?utf-8?B?OVlmTk5QQmZhT1hkdzR5WTNHa0pjVzkxd25PNk53RW5ObUUvZnpLZWhhcGZO?=
 =?utf-8?B?MHltd0VkYTdHenVSUnh5YU5WZHRNbnZnNXYwajFLanBnVVI2WHprempwUDR6?=
 =?utf-8?B?VXJ2OVhUMy83dFRXbmNUVkVSd2ZIU2JxaWRjQm15d0VTNlFJSWNoTUV0RFFp?=
 =?utf-8?B?QWZ5K0lmWHl2VlA0a2I1QTZjUVJ2LzBrdmdSYTl0V0k2MFNJWG1YZEVsVklK?=
 =?utf-8?B?bkZlMEN2RndjclpqUlN5bkQySlBZd05VSG96YWVhcW5HS0FYOWloMlBqSWpN?=
 =?utf-8?B?M2FpSlEvek9PUkFNSERWemVROVpYdTBqdm9ld21aQWplejlJNFVMM0crTmwr?=
 =?utf-8?B?c3NvaldEZURYMWxYaFFTRnd6MUJ2NXU5MTdvNlB5VFlnTHlld1dudFFDbUZL?=
 =?utf-8?B?WDZabVE5SHUzVm9mSmR1L2hWbWVaQ21PZVNGRlV6WHY0U09LNTJqTTJpRkNC?=
 =?utf-8?B?WG54amdybEcrWU5hd2h5VXhiUi9OaDRrMUdIK1ZrRlRqa2g3QjJrajc3OG4x?=
 =?utf-8?B?a01wdFIzNEs5bHlXVkU3aFh5RzQwWTVHUy9nK2gwSGcvcUVJRDBXYVpsWGVC?=
 =?utf-8?B?SGRwN2hheU5OSmpUVHI4dGRXSDRjWkI1K3JWVC80SXRQak83eXBNWVh3V0hK?=
 =?utf-8?B?ajlWd0Q4WDNWR25FN0MrR0swVUg0MGc4OWNQTUlJYVluU2lkMHB1L1JaTWd6?=
 =?utf-8?B?UklIV0hJYnVyY1dKSUhaWVV3Uk5ObkZtRWVSRzRIZU9HeXZZN1cxZG1LV3E5?=
 =?utf-8?B?SjQrK2hTRjg1bEZ3a1A4Y0tTRk5yTm9SNklDTS9lQzJheDVETzRta0tVRmRx?=
 =?utf-8?B?OGRtSVJUVCtyS3Q5cFBGNGtxNDRMNmtuVjRsTEttMEVpZTQrNnZuM0lJRVVX?=
 =?utf-8?B?MTI5OUxDU0RjU0IwcjVtMlVxQkZUZkFCL1JlWG5aeE96WHIxbFFmZi9hb3kr?=
 =?utf-8?B?SXZaMkNucGJiWUpSUHNES1o0bVlrRUtyaGRzVnFSZzFSQkZXNkxVWjgrOVlX?=
 =?utf-8?B?aHBKWkw2Y1lxcGJsN0o2amIva1hMRW91QldMWGdGczFRU2twMGpCVXdFTUpV?=
 =?utf-8?B?ZkpvRVlIYXpxZVBNcndJMmZ1MUNSSXp5alRIdldKUHR3eDQ2ZGMyR09zOWtD?=
 =?utf-8?B?R2dRL01FNTRBRUpoNVFYM1VaTmVETmpJNHd3clBGaWR3cEdyWWFJakNpM1Rq?=
 =?utf-8?B?Wk1xcHhSZGhsL2x4WSt1TmtwQmlLbSswY2tkMVpSSnJsck92SEkvdTczRlps?=
 =?utf-8?Q?RF+NKHdoibd2a9auCUEb7l3UA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e011a95b-d40f-4a3e-60b4-08dc0df3bfbf
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 13:39:32.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXLtZcz5Yo0Hsq5UhkyxYd0iMCJuKocDGArMJ2UsU3JOcRnDKrpsuOhWLxdz93KBbVmYT/HkVRnu+0l49L98Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

Hi Jason

On 12/13/2023 8:27 PM, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 10:01:35AM -0600, Suravee Suthikulpanit wrote:
>> AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
>>
>> ...
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 4e4ff1550cf3..c41932e9f16a 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2822,8 +2822,46 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
>>   	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
>>   };
>>   
>> +void amd_iommu_build_efr(u64 *efr, u64 *efr2)
>> +{
>> +	if (efr) {
>> +		*efr = (FEATURE_GT | FEATURE_GIOSUP | FEATURE_PPR);
>> +
>> +		/* 5-level v2 page table support */
>> +		*efr |= ((FEATURE_GATS_5LEVEL << FEATURE_GATS_SHIFT) &
>> +			 FEATURE_GATS_MASK);
>> +
>> +		/* 3-level GCR3 table support */
>> +		*efr |= ((FEATURE_GLX_3LEVEL << FEATURE_GLX_SHIFT) &
>> +			 FEATURE_GLX_MASK);
>> +
>> +		/* 16-bit PASMAX support */
>> +		*efr |= ((FEATURE_PASMAX_16 << FEATURE_PASMAX_SHIFT) &
>> +			 FEATURE_PASMAX_MASK);
>> +	}
>> +
>> +	if (efr2)
>> +		*efr2 = 0;
> 
> Why are you checking for null here? It is never called with null

In subsequent patches of the part 2, this helper function will be used 
to help populate the EFR and/or EFR2 in different call paths, which can 
pass only efr or efr2 parameter individually.

>> +/**
>> + * struct iommu_hw_info_amd - AMD IOMMU device info
>> + *
>> + * @efr : Value of AMD IOMMU Extended Feature Register (EFR)
>> + * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2)
> 
> Please reference a section in the spec for what these are just for
> clarity

Sure

>> + */
>> +struct iommu_hw_info_amd {
>> +	__u64 efr;
>> +	__u64 efr2;
>> +};
> 
> __aligned_u64

Okey.

Thanks,
Suravee

