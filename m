Return-Path: <linux-kernel+bounces-17882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C1A82548C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE151F226AF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593472D63F;
	Fri,  5 Jan 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZVi12DbT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005C32D61B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOYooizcNKtSuSJdvLb72uAwguKqOv7OgspQ5ECd///o3v+34dtO/SJn9b2q2lAClwWM5zpGPZ6rkbn46KhPK+ywSMz9twlODRkrT67Iz3zcHuCVHUGjiFzFieJCfxPP6hE6NabnVuOSMfPa7HzZYKe74xu5Hvrp2uN+hagphnt5uvas+O8s1H34sCFIqZmmRifGjd4jjT9YawZFU4awSAKtxh5S7nR/que8uJcYsa9rnay7VfP/0155Fymq6lsTcyoqAO4FduHL8T75JalNM2unYCN35a2jGbeVdG97H7tLzur5ytwsF2YSfjl0YtCq8Ni/cuiT9w68S/lRhURVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlobqjRylICpSowWD1iZdXmssuQ7MKFAoShD3G3ScIE=;
 b=TiNYxkYz9q1fyuB7MGtXNf34TBnFfzW+D3tXn9lvxEK+SIIyIbPOP8xKwKx0NW/s20KLRZxnsdJyWfYOm/vQ6VPx0LnowyvjNblE/7tO0aiztUR/JVUIIPztIjV85Sd4/IS3S4NYUOkPK3Ga8vuGSRCMoDIm4NW5njtEuqjYletMZtzzwIxpJ618c3CrGZMApW9Yhh5myF8YJ+92FUHuUUZvayiY9Q9P3mhs9S+qQWVV0WKIaHyRWn1FifFydIhopHEQ9ZG7vSY4jK0eL7V11eepc8RUIIhkpYKXwY+SNMcf5MuPptjH4VLLOULuHZnNn7lberGVqFj85Ete2tnF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlobqjRylICpSowWD1iZdXmssuQ7MKFAoShD3G3ScIE=;
 b=ZVi12DbT8Bl/uuZf+Y6OCWBD1XYxDqj7wJeBdNq5TTbI9lpcVtBJG6k576SVsqoVt9POwv/lxwXNOazz6lcghP12nRc3CFbynJz+c/px0mmEpqjA5fvXRK/vLVtNGPuwkJjC+3DWsBK+1y6P2wTTVJNA5PgU0rljZF0dg6VoSa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.17; Fri, 5 Jan 2024 13:38:56 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 13:38:56 +0000
Message-ID: <12c5b705-1387-4d50-8706-cf5c35dcb3cc@amd.com>
Date: Fri, 5 Jan 2024 20:38:47 +0700
User-Agent: Mozilla Thunderbird
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [RFC PATCH 6/6] iommu/amd: Introduce nested translation support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 eric.auger@redhat.com, vasant.hegde@amd.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, Dhaval.Giani@amd.com, pandoh@google.com,
 loganodell@google.com
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-7-suravee.suthikulpanit@amd.com>
 <20231213135206.GD3259566@nvidia.com>
Content-Language: en-US
In-Reply-To: <20231213135206.GD3259566@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: 47299bd6-2d6d-4719-4678-08dc0df3aa21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	liaupWPqXia6s41AxKGvlpLSCDyxScrT3ZuxCDLersz3VqfLgQusb+H3MkI20ckfDDm0YDkexzsgC5ML8uzW9IXFwqqcsmqE455gJN/wlSc3z2T6UmM5PKgFsBqNNCPlXOMTGLdwA4g9gxoJbHr9JeXKFNENIbs9MJEv9VVA/NxjgFhf0lmyZRP4UTHnhtlwY/cdYPcVGGPmPAs1lpBYZ1m4lUt8cGbPPADCAszGAmqAC6cp/shlskv4FebVrFhloP/ewspmoPgiaKo/hsd8QxkZfXRIJPsBh1AHFUzlKUs17NkNFg8OMBcrv7RUaQxP+nh0vsf9g7kq16+wIuuHvAVkxDz+iU/WAVFvrkkOGyododtSZpmaDCoxRRNQXsqmf/JxIR2rxJtiPh6Iv9756O0kxj3YwKLBAaOhHDevMI6J8iQftjtcyobZmwj9/zkG/3S/kAEdB8e7wgzR4JRensV4mxnN4oi7W/0aGdukzIo63MTdYNuT7DJ2AlL+2mmXZNILpXTHIA7zFS/m3af799EtwIyrxqd9CBdZntcMrXk3C30EatVbqbjWJ15NFZsPhDggfYsx0jsJDC5we8LN7VOE18+dGkQbOGpT5XAiKxWR3r5AvnkDx7W+TpKhNUSLWrL4cXF8HMXKnkBRyh+8Gg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(83380400001)(41300700001)(316002)(66946007)(86362001)(31696002)(36756003)(2616005)(6512007)(38100700002)(26005)(53546011)(6506007)(6486002)(6916009)(5660300002)(478600001)(2906002)(66476007)(66556008)(6666004)(4326008)(8936002)(8676002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDBwWHVDZ05oMzBHMCt6ZmFOc09tU3pDVWVuRXA5L1VBMUtXcCt0M3RqWjh6?=
 =?utf-8?B?M2ZuVEEyRW9BZmpiQWEzUnpyM2Rqbm0ySVRneVhXMElqZ3kxTzYyOVhmN0pP?=
 =?utf-8?B?Q2tDUGYzSVY1cVZsRGNBbTFCOUlaRzlIcTI5dlZUZWhtQ1lPWFlwc0xweSsw?=
 =?utf-8?B?aGJuZ29kU1FFU3NFcHp4UFRRUlhqK3JnckY2UUcyblR5VXQxYU5YM0R6UEc5?=
 =?utf-8?B?Ly83Q1RHOStDdEg4WTVvcXU0RVQrbkx4ZUdRVE5hQ1A3Q0ROcktudk1ycGFL?=
 =?utf-8?B?VVRtU1Rnd2pZV2hSc1o0WXljMklGT1BHR3BjcHJKQ3FmNnVwdm9wM0w1bnNZ?=
 =?utf-8?B?b1RqOFhFZEFlR3pBODMrZDA4eDJ5cnl2ZWkrVUI3VGZuZWt4cUpIVGplMXcv?=
 =?utf-8?B?VVFnVDdSWldPcGdPVFFpNmRQVi9hbmNPNlRPZzNpRTZFaExsSGdDOUhCUXdo?=
 =?utf-8?B?ZFY5OEN2TXVrYmkzc1dBL2xPd1JtWjlURjJxMFNmajZZdU9hUzdxR01Zd29N?=
 =?utf-8?B?K0dXc1RHVlYxRHZPVUNWZHh5THp4SHdDNW5qSzFIb3VTR2VsQm9hK2dCZXNw?=
 =?utf-8?B?dWpNN1FRNzVlOWhPZklYY2xjb1VnMWJweTdGU1k4WGVLTXVLR05QRm5jSlBr?=
 =?utf-8?B?TlpSdlMySlIrNDlMMVd0TGhkaFdsejBLaWdkMUpsZG5oM2FVY2FiRzNTZXNH?=
 =?utf-8?B?bUtVdG9SMHFHVi9RRTFGS2JtWDlnQlN3eSt4alpxbHg5cjlVZFBWZmUyaEZF?=
 =?utf-8?B?bXlOWlgyZktsR2JwbWZ1dU5qemFUbE9JZ0FNbjlPYzRWTXpQOFE5cXd3K0ty?=
 =?utf-8?B?NjA5QzRDb2xJR0pkS2VTVi95WU5tcmYxVUFuMkdLRys3NzZaRTY4b0JUZXdt?=
 =?utf-8?B?Ky9xOExHT0hzajF3QXZRZjlrWERuS21HUHRTLy9OZjFBa2FzSHNOZUJpemhL?=
 =?utf-8?B?eGhUdGgyelYzcExSNGpoa1M3N0Y1TnJ1dXl1Vlk4WmM3d2xuTnpvT2R0Y1pi?=
 =?utf-8?B?clZZK2RLczZPSkxqVWVvUStoY1YzQkdPY29EZ2wxZzliV3k2NXMzUnFhV1Ur?=
 =?utf-8?B?dmVhZHRiYXczQnZEWmlYWmJaaGpUMHZIQmZsd0VxSFBFN2VOK0tiU2FuU0lM?=
 =?utf-8?B?dThKbkFqSjNrSTdlMTh4MHI3bU8xU2ZhbHFNUzVxN2ZsdFd0bHVOZDBkZm1L?=
 =?utf-8?B?OE55Ni8wejN0RmJzb2hsaEVIZStEMkxTODJ4M3QyTXlvT2txQmdVa21rOTZN?=
 =?utf-8?B?UzY5RmxyQWlXM2hkRXAxK0c3Q01DSkRUS0d0bUxIbzVWbTR1UUovZE1IaDdJ?=
 =?utf-8?B?SEkvOWhINlBRWTg5TGlXTys3R2V4N0NEWXRGK2hCZUljUjQxQzJ4S0lkdmF1?=
 =?utf-8?B?R1JHampGcTFDak1jNnNjc2tOZWxBcFVaMWZNU2ROWjNqd09oeVV2aW4rOHJG?=
 =?utf-8?B?OGdyUytpNnkwNjhhWVNrRmlVc2Y5MXNJLytTZnJabElueW9uZHUrWEc2SXIv?=
 =?utf-8?B?QUNNSC8xUEJwdnA5OERETzI0VlNteUlKam52R3p5UDB4dytXSmtoQlN3ekRM?=
 =?utf-8?B?SndYdWgzRjUxbmNVY1lTOHdXNWxzSEZ1NWJ5eVVoSUc1WmlkNm56RHRHTCtn?=
 =?utf-8?B?UzBPeXNqTmR2ekoyQ2Y0T2owN3dUT1dpR2NZQWZ4WlhVYmxsMDIrNjNyZ2tH?=
 =?utf-8?B?VTFPZ3ZDR3hwSEc0b1BNNUJVNVhNVmxSY0ZxUTl3UExITDFpZTU0TFRMYy9z?=
 =?utf-8?B?R0I0WFYwcXpOY1U5NWJISzFmWk1BMGRUbUdVQ3FMYTcvQmJWZldPQVF3N3pO?=
 =?utf-8?B?YzZlK214dWNHUHF1cUkyb3ZnVjY3WjZTQVZzanhKYXZlRXFUdDNMdE5DdDFh?=
 =?utf-8?B?Y2JCeExXSkxVdS9Wakpsc21uSzBCaTBpbnAxdmZPS3RpaW82bXlhOUtxSHBZ?=
 =?utf-8?B?TFpSRWJuaGdjM1lSYmhocmhVZFBXM0Q4S2tLR0tnNS9qQWZzZzJKU1ZIZnIx?=
 =?utf-8?B?QzllVGVTdU5SSkFZRmF4clpDZjV5SytkOG1vQTNLcEs2NHFqaXpSajFOa2hm?=
 =?utf-8?B?S05SakhBUlk2enIvdS9KbnhGTVlhSFJhMktGUFhHelRzMU9VQUY3TUc5MFVK?=
 =?utf-8?Q?kLCdT3Vp44IwyYoPhEssbBVex?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47299bd6-2d6d-4719-4678-08dc0df3aa21
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 13:38:56.4203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+ViEcELEJfN52p3vkerHBh1lsmPVhDLKndsz0J1Wtho51eub/1bYXc5yWI2KkPoTeYVGGsLSnfkjUy93hf1rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925

Hi Jason

On 12/13/2023 8:52 PM, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 10:01:39AM -0600, Suravee Suthikulpanit wrote:
> 
>> -	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
>> +		ret = udata_to_iommu_hwpt_amd_v2(user_data, &hwpt);
>> +		if (ret)
>> +			return ERR_PTR(ret);
>> +
>> +		return amd_iommu_nested_domain_alloc(dev, &hwpt);
>> +	}
>> +
>> +	/* Check supported flags */
>> +	if (flags & (~(IOMMU_HWPT_ALLOC_NEST_PARENT |
>> +		       IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>> +	if (!check_nested_support(flags))
>>   		return ERR_PTR(-EOPNOTSUPP);
>>   
>> -	return do_iommu_domain_alloc(type, dev, flags);
>> +	dom = iommu_domain_alloc(dev->bus);
> 
> Please don't call iommu_domain_alloc, call your internal function and
> force it to allocate the v1 domain..

Okay.

>> +static int nested_gcr3_update(struct iommu_hwpt_amd_v2 *hwpt, struct iommu_domain *udom)
>> +{
>> +	int ret;
>> +	u16 hdev_id;
>> +	struct pci_dev *pdev;
>> +	struct amd_iommu *iommu;
>> +
>> +	iommu = get_amd_iommu_from_devid(hwpt->iommu_id);
>> +	hdev_id = get_hdev_id(iommu, hwpt->gid, hwpt->gdev_id);
>> +
>> +	pr_debug("%s: gid=%u, hdev_id=%#x, gcr3=%#llx\n",
>> +		 __func__, hwpt->gid, hdev_id,
>> +		 (unsigned long long) hwpt->gcr3);
>> +
>> +	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(hdev_id),
>> +					   hdev_id & 0xff);
> 
> Huh? "hdev_id"? This is not OK..
> 
> The device you are allowed to look at is the "struct device *dev" passed
> to alloc. You cannot pass in a struct device and then override it with
> another value.

Good point. I'll fix this to use the dev.

>> +	if (!pdev)
>> +		return -EINVAL;
>> +
>> +	/* Note: Currently only support GCR3TRPMode with nested translation */
>> +	if (!check_feature2(FEATURE_GCR3TRPMODE))
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = amd_iommu_set_gcr3tbl_trp(iommu, pdev, hwpt->gcr3, hwpt->glx,
>> +					hwpt->guest_paging_mode);
> 
> Waah?
> 
> This is touching the dev table? That is not right, allocation is only
> *ALLOCATION*. The dev table can't be changed until you do attachment.

My understanding is QEMU should call:

1. iommufd_backend_get_ioas()
    -> ioctl(IOMMU_IOAS_ALLOC)

2. For parent domain
iommufd_backend_alloc_hwpt(IOMMU_HWPT_ALLOC_NEST_PARENT)
   -> ioctl( IOMMU_HWPT_ALLOC)
   --- in Linux ---
   ....
   -> iommufd_hwpt_paging_alloc()
     -> struct iommu_ops.domain_alloc_user(IOMMU_HWPT_ALLOC_NEST_PARENT)

3. For parent domain
iommufd_device_attach_hwpt()
   -> vfio_device_attach_container()
     -> ioctl(VFIO_DEVICE_ATTACH_IOMMUFD_PT)
     --- in Linux ---
     vfio_iommufd_physical_attach_ioas()
     -> iommufd_device_attach()
       -> iommufd_device_do_attach()
         -> iommufd_hw_pagetable_attach()

4. Same as (2) but for child domain w/ stage 1 table.

5. Same as (3) but for child domain w/ stage 1 table.

You want the gcr3 table root point in the DTE to be update at step 5 
only, right? If so, this should be okay.

> Please look at the smmuv3 patches and try to be structurally
> similar. AMD and SMMUv3 are *very similar* in how their HW works
> excluding the viommu stuff.

Could you please point me to the series? I found one but it was really 
old. I might have missed the latest stuff.

> You also can't assume your parent is currently attached to anything.
> 
> The construction of the DTE has to be from-scratch based on the parent
> domain and the provided values in the "hwpt". Again see how smmuv3
> does this where there is one function that builds the entire DTE
> (called STE)

Ok. I'll program fields of the DTE, which are related to DMA-remapping 
with v1 and v2 table using the information in the parent and child 
domains only.

> I'm skeptical you can do this properly without also restructuring the
> DTE logic like I've mentioned before, there is a reason I did that for
> SMMUv3. :)
A device can be attached to a domain, which could be either one-level or 
nested domain. In case of nesting, the parent domain contains 
information for the stage2 (v1) table, while the child domain contains 
information for the stage1 (v2) table. For each domain, we need to keep 
track of the parent domain.

When calling set_dte_entry(), we need to check if the device is attached 
to a domain, which has parent. If so, we need to configure DTE using 
information in both domains accordingly.

I'll update the set_dte_entry() to reflect this logic for programming DTE.

>> +struct iommu_domain *amd_iommu_nested_domain_alloc(struct device *dev,
>> +						   struct iommu_hwpt_amd_v2 *hwpt)
>> +{
>> +	int ret;
>> +	struct iommu_domain *dom;
>> +	struct protection_domain *pdom;
>> +
>> +	dom = iommu_domain_alloc(dev->bus);
>> +	if (!dom)
>> +		return ERR_PTR(-ENOMEM);
> 
>
> Also no, do not allocate a normal domain and then 'wreck'
> it into a nesting domain. Refactor the allocation code to be in
> smaller chucks so you can alloc and init the memory directly here.

Good point. I'll take care of this in the drivers/iommu/amd/iommmu.c: 
do_iommu_domain_alloc().

Thanks,
Suravee

