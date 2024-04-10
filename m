Return-Path: <linux-kernel+bounces-138228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB589EE57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E831C211EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C10C156C6B;
	Wed, 10 Apr 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acs1jdIA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA1A156C61
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740277; cv=fail; b=pxOsIahDlJN1fnyVQsg7uR9Rv2G11T8d3FVuxC2mAWGB3PoiDFqiNXGvEVbpF309VGbJ3dVoo1tbqTCT1sll4l1wqdAza3Sy2RW1nDXnUOXOBFWJRH/ap32J4E5p96dWqEVpdbZbpE2b8X5vyVYy+JTlkW40E1jxrSMHRzd90Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740277; c=relaxed/simple;
	bh=D4Ff4atjaDLKyWK/D4uQ4OmK2TD/EcmsKozWbYH28tQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9ziKIBNevJqdlV50JGAEI5VNXHAMrfw0zOrt3ZShTf5OaUG2W1wywhFNhshIlqZqJn3YwYkGgTWmQ4BJBirM+3IN5HkvCBzUsNkcrOuhwV1WiRM/+iNVGpHtBgQ2UFRKc97igjnU2uxeAvAGbYz/78k0BzOP9g142MRwH/Jm2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acs1jdIA; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712740275; x=1744276275;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D4Ff4atjaDLKyWK/D4uQ4OmK2TD/EcmsKozWbYH28tQ=;
  b=acs1jdIAmYTlJh5bWC9LBkmBC0GTxCHoDhQsAlIrjR0QIY8FRg7O6aXM
   7X+Q1+ll4811p4mfREMwjrI3jUMjRzRyYyKtqTh3RmcdP5mKthTzQlLbv
   81OwR5CxoIGkdp5HOCNx3JJTD4+1vSrbuYv60sXk9tATaP1A9cmJVKCHf
   c3ZYzZgh62qol/5sHUof7/iYMbwamznbk1ftGO8eupaKRujA97/vaUVDw
   /613UTnT+axuTYVasRmJiEUiQvV4RDFxYAknoTPa/brthoMAYV4B0QkKx
   7bGrNxTxSv3QVAAZUf4n0SvvMBdWY05jO21bZv6T7cmWQnkwKmd03XI03
   A==;
X-CSE-ConnectionGUID: Mcb8ZFSGQCeqXxhCDUlBQQ==
X-CSE-MsgGUID: 7Xb3VUyDSwaceWtzCVNJ5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8216544"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8216544"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 02:11:14 -0700
X-CSE-ConnectionGUID: z/WB9vKITau+I+5fWry1AA==
X-CSE-MsgGUID: 5ionESW5TUOS+ramTyoHEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20928224"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 02:11:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 02:11:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 02:11:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 02:11:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8SDA8RREmGVmwV9YMhdgg/H8mx8dwQkAbTm6kn3z6nmXikTvE91W9hU2LH80qg/X0hNaLbfQLC2UnFI5liW/r0gBrhHoZL+uRtPEjykwcBIVBcL1SG9Om1JYL4ixZGrdKZ47Jd5sSHpFBoKR1srNMHZAPcy/yg19wzvob8kiXoREczR+2Ww4cq7V+3xRiSuGSJ1hc3+f00OXGpW4F12vvd2+4Cb0hCLYuR7h3VMPp3QbxReXQKetNhwXDF9jrDhZ8M1YUKbHYhANioS6aFb2hs04RIEFaF69VNOA3yqKqSCQvfIEHi/NS+dp6/4IXcEQyyJri8ZVGoNzpDrILLGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsFFlQcrPzRiWPOuvw7VeAZvtVxC0OOCboN5MpTSxcE=;
 b=J6PBvdOuBeiqjZsqxxbPegz/585NGZ1ObsRuQWMhprJ7vFjPGNwAANsli0zyCBBLFBmMjFAZSiBiAjGdQU+KxxGDy9nml1bPrN7I/lFJLmtp33eElWOz8/0hub9HTvbcY3WdWj65o7Cv03/qQsII/67dNgoH0z3H6lYaSGFACsCB1hVrM8BQKbaozqxcYdu//0VLibx+tuoa4E0Duq51beAVtUQNhFnjDWW++jhIOyRU2UGr5rhZuQifq0Ief38jNDphW+d0JYhnnpoA08r2us45YXclKymE+1eyMntahSgSdW/f/KpvAxuRrOdVqACyIUBL3hHoJSpWlF2bHYSQ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB6936.namprd11.prod.outlook.com (2603:10b6:303:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 09:11:05 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c%3]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 09:11:05 +0000
Message-ID: <be0b254d-d6c0-4a94-8234-936f40538bbc@intel.com>
Date: Wed, 10 Apr 2024 17:14:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
CC: Kevin Tian <kevin.tian@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
References: <20240410055823.264501-1-baolu.lu@linux.intel.com>
 <7e78917f-f84c-4e98-a612-73b8013ae367@intel.com>
 <0231631b-44ca-45ee-adf9-0a5c8852cc27@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <0231631b-44ca-45ee-adf9-0a5c8852cc27@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB6936:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jm1hxM8b6HpvoENxa775GsLel8DeT2HCz3Y2L5MaCkEs6vT3p4mT5n4DuyMfk7M6GiMUQCR/L6+uvNCG2NrHaF3Og5VFB0wtZgnhvUcrokVHxXo3jJZts5dquSB/urk8K8R4hLm7n6kn4NypwD+owc19qIk2SOOXrW2j+/gH7heul7GTOCgNnfSSkWl18wRdbBQhFHjnkr+G0o+6epWPb1e13kdNM45njtPEURP8RIHm9UZ6GX14bQ4WzYkWUSB9ESfUsxXtNh+QlKUaG4I5KzdOBAer6ogVvZrgztk0YuGK1+bVTUbjHag2IlfYHaOG9LtwpzYARk+W/q64Hi6Lv9sVVbNXAh2F2HVgz/5jE0xElcK5lGsVCF3xM9YD+aHxBr5IoavMn6tXSG6s4r8XBuO6dwtne9AuHSeauMuP2qUcv/rEyQkcosXM7xRbfXtSdhdL6stPnB7aw1g1b/Jho+jfybbCclNSg0Ki2oCg9CiPZnSi1tvPlaZ9zUkWEIdXx7ZvOfrsErvdi2Dg3UBN4SaIEoK0830SYOd2nrA0PSG20/J78hZnhGUI2sH0tld8AQcjC22854KyzpXslTXx4++8F9Oanrodq+Pk2BP52siJAC9jruiCr7t4WYBIq6+I3baKkU53/PG5vTZHRq3Zqc9uMRLp8rcWcV04XRz/nh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGcxSTVjbk9nOUIxR3poZ3NQMlltdmtQL3BtRHR3enJvUXhFbzBSYVB6am11?=
 =?utf-8?B?VE1kRG42NFk1OUVLdzZyV3NDcENEWXNvbzVFV0RYQm81QmRpbjhETTVaR0JZ?=
 =?utf-8?B?bGo5WlFWY0FZMzhBaVpuUzlSY2RDeC9CanBZdU1WR2hRY3hvR3hsU3E3aXlB?=
 =?utf-8?B?N2JlaHd5VnU2a2Z3eTIxQlI5bDcxMlhqbjJ4bHE3SjUzckpWZDA0RUFUak5H?=
 =?utf-8?B?ZUNLcE5XS29zZ2JkZThXUW5CTVVodDdzSG90Y0pkbGN3Vm9qR2JaQVlQSTR2?=
 =?utf-8?B?REg3cnR0OUYvRFlvajdjYTAwaUwvYitqWXpkd3ZkdlFiL1FoSHBwaEF0OW1X?=
 =?utf-8?B?U05LZnVrTU5IcjN6T2ZwTHpBSTNSakVud1BkOHMxSEF0NzFxNFR4aEZIRE9t?=
 =?utf-8?B?VEwxQW5LbWR2UFNicThqZHRUdGxrdUV0Y1I4Z0VYWmtUSTh5OFJMbEpVcWVE?=
 =?utf-8?B?TTVXS20rRmVzOFRCN3dwNkN4R2h5a1dWdTRFbXo5blo1QjhHL2JLU09vRVZF?=
 =?utf-8?B?Vm1USytVd0xndjZKeUxmdnZTeENtZWdrYmtpc2tZR1ArSTJnZ2x0OVFqa2JM?=
 =?utf-8?B?cVZoQmVGMFdIdVdKYUhVK0RRRVBydElVWWhQTnNSZnFlRHZuV3FQRjJ3Vmxr?=
 =?utf-8?B?NUxWaDRKbmczaW1hMlE5dmc3blFaUFpkb0Y5RTUwM1dBOWYrUG5Sck4wTmsw?=
 =?utf-8?B?MEttaXBiU3B4U29ub09RdnA1djgvc0lvelAwU2NXZDdzTUhoaWlibW9ydzRR?=
 =?utf-8?B?ZXh3aW1mUXNvM2hEQ3QyZFdVOHRBUVVUYzFnZkVnRFpqMENURWgzQktpbWVM?=
 =?utf-8?B?VC9KZVBDMXZCZFF6REhkMDk5ZHkxQmhrQWhJYkwwdmUwNlQ4di9HNjlKOUJ4?=
 =?utf-8?B?U01QNFRBOXpyUmVqQ2d1TjlDVmIzb3NGT3c4cjdtVys4QXJ3clpXeFVZREl2?=
 =?utf-8?B?dklidjcvcjRXek50REdqcFZiZzNXbWphYVZwK1AxVC9vUFYwRjRUUFdNbzJl?=
 =?utf-8?B?YkVDYTlybkIxcU5GMkVFL3htUHpOdmxYQy9UekYzNEdRaEduMnJBY2xYWnUw?=
 =?utf-8?B?c2lVdDRPNUJJUkFVNVBSSWxZTXRnazk4TnRFSG40dk9XbHZUVnp0WmFPbHM2?=
 =?utf-8?B?aFQyR2hZaWpPVFdHK0ZnTnl5djVHYi9FcHU2akp0RkltazBCMjdPaWNXVEJr?=
 =?utf-8?B?YlEzMVFrNm8waHVXMVhWWEREc2VBN284T3ljWDRxL1l6WEFXR3lRRFRpN1hX?=
 =?utf-8?B?OTQvM2xHbUpvbjdGb0JZSjBzU0RyVEFST3dOd2dIOGhoTnRqbHJlS2FCR2hY?=
 =?utf-8?B?RkdBMmltYzhDZEgyN3ZUZ1oxNU9rdjRvTzBRWjBlaWlwSUhIbWF1T2NOWjlQ?=
 =?utf-8?B?WGFjemZ0UmpEL2FrWmMvd05FdWF3Vzljd3hTOGZycU0wT3Q0WGQ0bUFzd1hu?=
 =?utf-8?B?Mkp1Yi9Jc3MwazhvRlRjczhGZ0gySnU4RkdXN3VjdHUxd2F6Vi9YVjIwVXE5?=
 =?utf-8?B?UnIrTTlPekVneERPNUx2MSs4S1VGZDJucU9wOGR2TndFWUxJbnBYRkdTa3Jw?=
 =?utf-8?B?RDEwSFpNUmFOVnNiVjBCbWZwd0JHRXFRT2tDUDEySWJ0RzhOaS82QVhVbFhV?=
 =?utf-8?B?VjVrSGZ6eklXNkV4RnVLVGJVcjN1WitZNllOQ3BTcnFUVTlOSW1ZNjV6alQ5?=
 =?utf-8?B?eVFxb29rYkNxL3A1ODlVSFlpNmVodXU1dklpcGxSeW9tdWQ2cWtIWlJFcmpa?=
 =?utf-8?B?bnRiTFo4V1cxTnJGa3NkWWpBZ1ZLQWJJNW05M2ZudGVQekdnU2lTME1nVFdQ?=
 =?utf-8?B?Nmx1MVQ1cW1SREl0MVppbEFDclNxMldsb0dSNEExTWJ4d0Uxd2RhOWxuYnJx?=
 =?utf-8?B?UXpLSFFyb0dNb01TcVRDS0lsbGZIWGcxWEt2OEVWOHM4cHNDVnltNGlTcE1i?=
 =?utf-8?B?cmgyRUNSdE1hdlY2TTZIZFhPWk1qODNCZDk0K2htbHJ6TU93OUVQM2ZpYUtY?=
 =?utf-8?B?VWQ3WHpzbFpMTUlZMTQ2UCtJOXgxbXF5TnhQeUZ5UTdDM1FmTFc0aFl6amVM?=
 =?utf-8?B?OUxObWlhS09yeHRvUWtoOVpxYitLS1JkVFY5TkkwUU1hdXhnYjV0OXYycUlL?=
 =?utf-8?Q?ic65lkp0TzY1LOOfOUuiRewXF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 218ce489-244c-41bf-dfd5-08dc593e26d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 09:11:05.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bpRvwQ3ERq9VQd+8tQK9MehUuF0mc9lvro4obXfIwdSw5itk0zshgByAUlG+OtUqyjASywoc4dktvXsm6dMCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6936
X-OriginatorOrg: intel.com



On 2024/4/10 16:02, Baolu Lu wrote:
> On 2024/4/10 14:30, Yi Liu wrote:
>> On 2024/4/10 13:58, Lu Baolu wrote:
>>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>>> implementation caches not-present or erroneous translation-structure
>>> entries except the first-stage translation. The caching mode is
>>> irrelevant to the device TLB , therefore there is no need to check
>>> it before a device TLB invalidation operation.
>>>
>>> iommu_flush_iotlb_psi() is called in map and unmap paths. The caching
>>> mode check before device TLB invalidation will cause device TLB
>>> invalidation always issued if IOMMU is not running in caching mode.
>>> This is wrong and causes unnecessary performance overhead.
>>
>> I don't think the original code is wrong. As I replied before, if CM==0,
>> the iommu_flush_iotlb_psi() is only called in unmap path, in which the
>> @map is false. [1] The reason to make the change is to make the logic
>> simpler. 🙂
> 
> Oh, I see. There is a magic
> 
>          if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
>                  iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
> 
> in __mapping_notify_one().
> 
> So if it's caching mode, then
> 
>   - iommu_flush_iotlb_psi() will be called with @map=1 from
>     __mapping_notify_one(), "!cap_caching_mode(iommu->cap) || !map" is
>     not true, and device TLB is not invalidated.
>   - iommu_flush_iotlb_psi() will also be called with @map=0 from
>     intel_iommu_tlb_sync(), device TLB is issued there.
> 
> That's the expected behavior for caching mode.
> 
> If it's not the caching mode, then
> 
>   - iommu_flush_iotlb_psi() will be called with @map=0 from
>     intel_iommu_tlb_sync(), device TLB is issued there.
> 
> That's also the expected behavior.
>
> So the existing code is correct but obscure and difficult to understand,
> right? If so, we should make this patch as a cleanup rather than a fix.

aha, yes. As the below table, iommu_flush_iotlb_psi() does flush device TLB
as expected. But there is a NA case. When CM==0, it should not be possible
to call iommu_flush_iotlb_psi() with @map==1 as cache invalidation is not
required when CM==0. So the existing code logic is really confusing,
checking @map is enough and clearer. Since the old code works, so perhaps
no fix tag is needed. :)

+----+------+-----------+------------+
|  \       |            |            |
|   \ @map |            |            |
| CM \     |      0     |     1      |
|     \    |            |            |
+------+---+------------+------------+
|          |            |            |
|     0    |      Y     |     NA     |
+----------+------------+------------+
|          |            |            |
|     1    |      Y     |     N      |
+----------+------------+------------+

Y means flush dev-TLB please
N means no need to flush dev-TLB
NA means not applied

BTW. I think it is better to have the below change in a separate patch.
The below change does fix a improper dev-TLB flushing behavior. Also
how about Kevin's concern in the end of [1]. I didn't see your respond
about it.

@@ -1579,8 +1575,7 @@ static void intel_flush_iotlb_all(struct iommu_domain 
*domain)
  			iommu->flush.flush_iotlb(iommu, did, 0, 0,
  						 DMA_TLB_DSI_FLUSH);

-		if (!cap_caching_mode(iommu->cap))
-			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
+		iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
  	}

  	if (dmar_domain->nested_parent)


[1] 
https://lore.kernel.org/linux-iommu/BN9PR11MB52764F42C20B6B18DDE7E66B8C072@BN9PR11MB5276.namprd11.prod.outlook.com/

-- 
Regards,
Yi Liu

