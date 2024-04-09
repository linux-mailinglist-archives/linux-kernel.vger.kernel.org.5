Return-Path: <linux-kernel+bounces-136491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C889D4B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720CC281976
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE8012D1FD;
	Tue,  9 Apr 2024 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSDnp4Gz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9CC12C7FA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651598; cv=fail; b=FAEjkfjv7RcUO6LHsNfRaLkZOFCA77evLJ4QMDpOM4CYP3m8670xbGalqVx4C1gEwyHD+wtzXtcpqP6AXWrua7R5LPmT7uydKQ9CpVQ3TC8GN0QIFqemU1FrZE8Ge2H0Pxl8omUN+A5NMW/Inz7NhOARR24nrnQKi2sjPqby1lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651598; c=relaxed/simple;
	bh=bgpA8OTW7TLg9Ep+6yQVj+q8/ZK4uSj1Vedsy0KIIbI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCs6rpY1CFbm4c5yBf8kt62t2n4rlowh5b5BVTPCayGWNkUCQON0NERB4d79w/PMQkScaKbMyvsBUMmnzN8QVENz9Zu1JpmLH/0O6xYQ7hBbtSac60jlG4Xhf9LkmhSOQcnCJBdwWqbv4K++e2JSB3CJZ1dPrH2o47rYC+KG9iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSDnp4Gz; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712651596; x=1744187596;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bgpA8OTW7TLg9Ep+6yQVj+q8/ZK4uSj1Vedsy0KIIbI=;
  b=kSDnp4GziDc0nO9TkCuebVmWq1QfTE81JSTm3rjSgpmOETOhnjN9ZUTy
   2aUaHRG9C9EUuMz/eDOh48AY7334A0XiPb0OfGtz7rTcePwaqLnLhv1FU
   FIAbXg+I90TLXLwDXg8pS2SFopDYb37M8Ps02GFrsNOwfQXhPcHfYLTQk
   KOySwfQEtR/3HgadZHj/Wzsuh+EvAkFoahNiMinhMamo/w6a2WoO614vK
   fAf1y55m9xX3OI0JxDfZBKvgNRUiAhx5fWnhQzay7DTMiZ2CyLGZqBQgk
   lZTLkpJlaa2F1fQpP05tbRHqNF+UisNJj1IUiZnnurop3BSKMdI/0M/5o
   g==;
X-CSE-ConnectionGUID: rJf+QwhKTjejmJO2WFgK5Q==
X-CSE-MsgGUID: pO48yaNuSt65MKg7KzfVGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8080238"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="8080238"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 01:33:16 -0700
X-CSE-ConnectionGUID: oLtcsEGbSeyu0LSi6C1cHA==
X-CSE-MsgGUID: SIzO6q3lQraGVXy1QAA/ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20232532"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 01:33:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 01:33:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 01:33:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 01:33:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 01:33:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBcawkXcN3lu5TRlm/LgMneqXU25qgRtYznHc4RrSMZWzL33f8lTZmJAyHwxQ+zQvsIg+3fzLYgzb4NLI0eUfwnjvJOS5Uc7BX4MjcpFhpahJIvvL+Xz5AOZ2T0jntUDwwMpAjTMKSRhJETH4DtgLtqIEQz0B4Dto1bstVol6GiROgHAsCQus5KbWoxVnVxvPUQn+Xq5+Z9jRD6zzxypMbVh9GnSZAAlWrxkcLOWvqeB4Jot2XjY00/dq+jWh348YssTaoC7NI3MNm6WfisRoOcYn3ASUTsxoju/NFKSiUnKM12878zm/VDgKuyfwaeecwTI+H0E5tTRyB4F3NOC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=it3KSI85er69ZQmcggstiZCKUZBaq08bJhEqb0viwJE=;
 b=lUc/+VNo+ADQxhZ1L0YzeywaroiSTK7MFvE1Kk0qp/ERXljBnq/AXlnZy9zr5JyPRiqxUWWD5g43x4DGXm8B5i0RBdZ1MUjS/4DzmFL9frEyvngrkAVluJrZtDQmG3Ow5n5+OnV0k56h4DinSwayj1ncxevRXJQN8EOmZQpHfv1XAaedh/SEHFAUYNmkuh0uvAIhM/TVx5N5hVPsYfKH2lzy+r1OP94X0GvVS4s7GGv/oDslscsKVYgKhWLChcb82/zfEElINuKM0+8tvgrhUoGYoe2UQKGswFEYlJ7j05kPh/Fgs+LwqEM5K6n7hz65/WhlqKsZLJ8/JSsPAw8drA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Tue, 9 Apr
 2024 08:33:12 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c%3]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 08:33:12 +0000
Message-ID: <04b9c7cb-e2ac-4dcf-8594-da101a98bc49@intel.com>
Date: Tue, 9 Apr 2024 16:36:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
Content-Language: en-US
To: Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
CC: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
 <20240407144232.190355-2-baolu.lu@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240407144232.190355-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW5PR11MB5881:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qS9r4xCb81elxRqf+VTamaj1gpOYYt4vhnx5TJMlDiE2e030VgmxrtmrccohkSXjJiweYU1nJHXJ0Y29aB5EiNJA5xe4WdmQ8tlcNdpGtp5qwZ/DkXYUmDxOc4Hjw78tWc325gmsAYcL2EZcYudu6R25CD9V/djV4w2iUnxvMqPOtQna7C8PpEP1avsL9GcVdZ5ZL182TAg1YMs/CvCVaJL1uDufIGVkOm+c72MBF+5PtQ/4lz30eD3W4vMM3tYqiyXKDciUTehtJhoLpezbIaznhxIzMQYgUG0Io/+KJT5J0ZgjA8DpdiLxPavfmZvBzeR2hJ1PggVWbfAXlLadmfkWw68adt4AneD+9x8JOqBfFc92VapwIdGSmHyRbfteuxCqelsxVvpU3uzRY90YqTkLJPfEVmQPnqQeMlJ4WeKlowLuGHiYlK/Ee13NxoUFnB7EyyeKIoVeiTfKpo/oJPQh+wjFSA7t2I2lap7a5hTQxe9kta47e2gYP6ZjZeksSrzWwXZITxzEwMf84LIQMm8xQ9yWv+To3ic4fFLe9nVJLpo97jOy0f2b6iwiMxj75z/w8sB8Umiph5Psl7UDF5ToARBZmOVZaP4gTnKU+JsyQR4AJkupk1fUHqx+8PkYHZYj5JFh+6udFstbRcPMEijmZGYRMvIK5SXnB8pQ8+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHVLdzVjalY3Ly9UWnExS2JVRUV5RXdleGlwMXd2eXZrUEtOaSs4Q2hLSGVP?=
 =?utf-8?B?eUtGdE9tMmszaU5ldmtUNEQ1QnR6aXpmTXYyRzdsaGp6MERTMEJRa05FcnJT?=
 =?utf-8?B?bUxLNHlHODZsRjl4N0pNWFpadDFmYmJyaTF4MFBPYnh4a25vQWFpNWFNUWta?=
 =?utf-8?B?S2gwNXhoRVF5RGx1bnhrbjgzTFUzS1o0TVQ3cHMydW8xQzJWM2FybUVDSHVY?=
 =?utf-8?B?ejkvb1ROUG1IWGlHZE5XcXJsd0RvWDV2dzJMVkE0ZkpHbitCWmx5cDNMUmZn?=
 =?utf-8?B?Ym5oOEtmL2FzM2s5Tmt3VSt3bTluM1hCbEJBMWk4U1hJWFNvdkp4QWpYckpV?=
 =?utf-8?B?bW9ObHBkNndoTGo1WUJkdXRPRWRYUmFaK2NLNEF5ODYvTGJpd2NqOVNabUdz?=
 =?utf-8?B?ZkJkblJhaUVEbm9yTTdrWGFlWmFyYVdsbnJzQ0Z0elFRdHhPMmZNMWh2Y0N6?=
 =?utf-8?B?cVh4bVhpR1ZWczVZQll5QktsQjg0a0xsV1hGRTlLeHJlR0FhdHBMcm4wN0o2?=
 =?utf-8?B?U0xwcHBGL3JPeVY2UUZzL2RXTDFvdGZlbE4xMUR5V1Q0RW9ESHdDWi9YdEh0?=
 =?utf-8?B?Ykc5QzY1VWQ5Y1JLNlZxZjVkVmttOFJVdlpBRTRyYXl1bXJ0Y1VTOUxneVZI?=
 =?utf-8?B?c0Q4dU9TeG5uT3pKcHgvTHQ4NnhtcXJucEJhcS9NVmdmaGdvbi9seFZHc2pq?=
 =?utf-8?B?djJVVUVBSTBmMVpJOUdkQUZrWG91YnlvVlZDVTlmUC8rbzJ4QzBrTHBQenVs?=
 =?utf-8?B?YXFyOHZoNXFjc0dSYmxsMjJycythWGtWc1BxUkpjeGFyczEyOVZMY3QxRDd1?=
 =?utf-8?B?cy9ZWFhzRnozSVZmL29iQ0ZHYmdKSUFMcno3SU9zUndtSnZ2Uno3S3NWSi80?=
 =?utf-8?B?dzMzUTR4OXZXcEpzaERCRmc1RzBnQS9TSTJMQlU3T0RLVGc0TndNTmVjT0hN?=
 =?utf-8?B?RDRuV3VYN2NDS2R6M1BOVnZ4Y3ppWnljUTB2elRWdVpIK2MzM0JCRjJLMnhK?=
 =?utf-8?B?T09sdm96UDFjOUpKMnpzYUJvRzNUT0taMkU5SXNybEZRK0s0dDlZMDMvNDFO?=
 =?utf-8?B?Rk9pdHZiQ29YTGlteWdJUUlVT24wTVZuVE1QT0swcnBlZlhING5IYXorMVpK?=
 =?utf-8?B?WUV4V3dIWWtaaTVxbDY0Y0hyVDhrd1hlSUp1Y2JzblRNOVJyb0RPOUFwWTh0?=
 =?utf-8?B?NEFpYUttQjB4UHk2SjNwYkV6Y0tPTlBQb2tWbkRBVmFhbDV2WmxyQVdpK0Zp?=
 =?utf-8?B?a0pMcisyVnp3bE9xMlZnODcxTGJIQk9EUHpnSXo3QUQ4c2xiL0dpQzFGd29o?=
 =?utf-8?B?eTFvZDlEZlRFUFRPeHhTRXN3M3BLU3ppNk52UVhUNVovS1pQUHFCQSthTWNX?=
 =?utf-8?B?SGpXemJmbnIvb2JFQ053enRiV2tIc205K21OQ2Y4SXdOZTNCaGhCVWd0WU5B?=
 =?utf-8?B?cEZTdys5UHFxUitSaGtsM2tMQjFtTktraXQrUU9COUJ2TFdTUk05cnBOTGV1?=
 =?utf-8?B?RldMN2RSMXp0K3dtQWYvT1NUUy9sSG5JODdjRG8yWXRCKzZONS9qQ0FmaEZV?=
 =?utf-8?B?YjliZ2NaWlYwaDIzakcrbDUvVlNSaDBXajM1UVEyRVlQem1EU08zeXR5Wkdp?=
 =?utf-8?B?YXVJU0doOHFaVnBydUh3VWRRa1FOOFh6eDRqOU94SHhPTDBNRzRPVktlQ3Nx?=
 =?utf-8?B?TDNDYWE4Ui85c3NWSEx2UklxRzR1OXFQMEN3ak1wVllzVllJYW5kVWJER0dE?=
 =?utf-8?B?czB5Mi9NTWxmNjY2bU1UckkvRHVSbndyL0UvdVJJcVBLc1Q0VloxeGo2Nksz?=
 =?utf-8?B?VHVvOTlvV21mRFBiRGhJMTBZcE15aFZGSjN3VC8vMFFMbjdHbkY4b2ZWZWtr?=
 =?utf-8?B?YWg2Tmtwa1lJTzQzTmVFVkcwbVROYXFhK0ZzekhsRmtaQjFrRy9rMlpzYlNa?=
 =?utf-8?B?VC9hVnNqalRlZ2RIMjRXWVlJM2RFby9UbDhtUUo5aTlFbHhkbkdybG5SNGVs?=
 =?utf-8?B?eTEwUEsxSEg0bFhMdVd0MUhQd2pOT2MzNUg4bjRjQ3RpNmdWUlcvUHZ3WnFh?=
 =?utf-8?B?cXM1Tm9vbHR0Z3BXUWxjQU16NStiNDlqemMwKzh1YXFwUmVQd204dmRWMUlJ?=
 =?utf-8?Q?qG5fcAsHFsY/sJEg+sMFvETl1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37657521-09ee-4ef2-ed2c-08dc586fb166
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 08:33:12.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6NoMsAAHCIuiYSKlsaZEtUWVpuIP3RlPoyRG7XxWehT1Mi7rkZkF2fqsmTVoCmkT3iZExtjcDfAzKsSMImogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
X-OriginatorOrg: intel.com

On 2024/4/7 22:42, Lu Baolu wrote:
> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
> implementation caches not-present or erroneous translation-structure
> entries except the first-stage translation. The caching mode is
> unrelated to the device TLB , therefore there is no need to check
> it before a device TLB invalidation operation.
> 
> Before the scalable mode is introduced, caching mode is treated as
> an indication that the driver is running in a VM guest. This is just
> a software contract as shadow page table is the only way to implement
> a virtual IOMMU. But the VT-d spec doesn't state this anywhere. After
> the scalable mode is introduced, this doesn't stand for anymore, as
> caching mode is not relevant for the first-stage translation. A virtual
> IOMMU implementation is free to support first-stage translation only
> with caching mode cleared.
> 
> Remove the caching mode check before device TLB invalidation to ensure
> compatibility with the scalable mode use cases.
> 
> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by default")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 493b6a600394..681789b1258d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1501,7 +1501,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
>   	else
>   		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>   
> -	if (!cap_caching_mode(iommu->cap) && !map)
> +	if (!map)
>   		iommu_flush_dev_iotlb(domain, addr, mask);
>   }
>   

IMHO. this change can be merged with patch 01. And the reason is to make
the logic simple and clear.

> @@ -1575,8 +1575,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
>   			iommu->flush.flush_iotlb(iommu, did, 0, 0,
>   						 DMA_TLB_DSI_FLUSH);
>   
> -		if (!cap_caching_mode(iommu->cap))
> -			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
> +		iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
>   	}
>   
>   	if (dmar_domain->nested_parent)

you can also move the iommu_flush_dev_iotlb() call out of the iommu_array 
loop since it does not require checking iommu cap.

-- 
Regards,
Yi Liu

