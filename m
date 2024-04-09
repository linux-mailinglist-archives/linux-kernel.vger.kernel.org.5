Return-Path: <linux-kernel+bounces-136448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF3B89D428
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6561F21D7B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D447E77B;
	Tue,  9 Apr 2024 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBZ6iRGL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CEA7C0BD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651070; cv=fail; b=jO1yJPRziizdop0LlHPPU/oJs1OGF2Ci8s/7aZg7097pgYel/WATAxbTM0NO5Sqoi1hFd05qOdMLpy8IHBs3FoO75V5GEXV6VemXbpB5m5NJ+BWsHouPgTF0KT7+IQFGKNOQsfTVWbjRtnPb77QCbebg3p/i+FE5onT123a2E/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651070; c=relaxed/simple;
	bh=8+eH3I5NRjhV83SAjaXsGZniSLmsJBQ1ckZPfkUjnPk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i8pwk9jWIbKxuBJqejdJi9CxAQGm3CnFtb2r3M/4RQjuC85FXDbqnS5IayoUHqNvSckTm0L12tfJ4w+STb/EVpEgAIKVHDu/vlVDHWTUaoqElX/Fv8KshAM1OqDquVnnDEBJ6jMhYEM5Q3tcmYib59+15rxN9zcYfhhIGkGCGMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBZ6iRGL; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712651069; x=1744187069;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8+eH3I5NRjhV83SAjaXsGZniSLmsJBQ1ckZPfkUjnPk=;
  b=KBZ6iRGLDNvRDWyK1VIQvfY7S57mXwl0Sf7moGe0D6X/3JXCBjXedoF7
   KmoBes4vE9vskEIlMInKnKpAdQS41FyHomk/kx2dkXBjHMFlaqXMb6Zbd
   cGGvaxbYcdJd/fyLeRC5nY0eaPUmoqXev2AWOFdgNO96XDRd9KF2mmkw7
   sduRQEvpQlHInO9C0iE/ap8FPkdnrKYM176JjJwHUXYVmBrEqZyoD7ETF
   buDBPYEulCZzYTVVYCHaO2s/vZSoY+X8vTYAt5FSiCA2dNIXubLhZP40w
   uQtsWG7sCtUPAj8ctw2sUwSk+6KE1B0w1odkgioToKz4TLeWZK+Ji41Vp
   Q==;
X-CSE-ConnectionGUID: idFhwm2DS32vDxq1BLOy8Q==
X-CSE-MsgGUID: D5A+hKkXRb6jUISIi6T1YQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11751491"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="11751491"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 01:24:28 -0700
X-CSE-ConnectionGUID: x5GpBjqgRCCbZYQYhDTZ5A==
X-CSE-MsgGUID: ZrWTXrrJQFena899VMDj1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="24644084"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 01:24:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 01:24:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 01:24:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 01:24:27 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 01:24:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g87cTfl+OLEOnCEF1d5fZM9cNVDQ+VHRcaEWSmBET9IeGPSVDgSQcSEGRNNdZpaMpPcbby1XtQoOToVyLJUHYHt/U6Qug+lRIlo4L0F3JJzKx7CnAm7bYfWuoJS+er/O8Q3JUNSfUBZdM8nB/2qistWX6tiyiYXmNRJh5ZLfGNUixkOkeBXtnLFbOCo7jzNV71w1GgSlORcXXXeZPf9FkplRkylUn9z06TuBow/bjgr/ZmMJ7Uy6BoQB1Rra7hRI+EaP0/cv0wqBpCoIffujD0GFS4sdBJ8xHHY2kZLJpB93JMIi0nfRcRnfYqjZYQ743qlOebu1/sxoTbJFa6NMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4/ETbT/a1bw1yi93YwrLJcUhX9hk0IWucPcB7UpCag=;
 b=IrWUjjHInUa8axSaUJUdPxR3h4w+4v/MCeAL2E4CjZxbz4zkI5FGdPTjHHg9bmyEKpcctmoe9C9leQiOIdTs1tiBhZv04sjE7SCZUOivqIZm8mBi2LHlL5AgRvQxiYKJdzT+L0DQxV4uY0zzXwslX4k2d2kkzZu/C2C5sC2FpE7GuoRqTyJoqgnOU9lb5GNrQwYUw0uX2eEdxH4CES6e6vRYJLaB37gFQ6aMrU+0u314jmB8XfLg3rgEAc6666LC0nBl0l7rEOsSoGO/l18YB7vSEHdKxRtgaqzCIgeOS3Dqcj1whTO2ja18aGjqKXLfIY/vbWZUXOx/xxPhCoAzZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB6345.namprd11.prod.outlook.com (2603:10b6:208:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 08:24:25 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c%3]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 08:24:25 +0000
Message-ID: <ac7fdf0f-ecb9-415f-9c1b-600536b92ca5@intel.com>
Date: Tue, 9 Apr 2024 16:27:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/vt-d: Avoid unnecessary device TLB flush in map
 path
Content-Language: en-US
To: Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
CC: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240407144232.190355-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB6345:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lITcmyUcq9/IE00fq6vViCRVGAGKxC0ZKOz7GdTUWUBEfBfbN948Shf/toJlz+jJaJrqEB7OC8wfTu2wab6481oWa0Hl/ht8Sb525TKO6RI6ujGagXoPq8JQNwgt5Tjb+9y0cdAHY0Ww+SdYNMtyzDBVavy2D9cxukTmzW9mXJbnjzc/WXZuJJZPpgovl0iS9y2nTuMo1dkRBHk6ktHezJc/Ulyl3nyJpG/r+XmGoexKx3cxFw+d5xbU4yOu3ZqUuGKYWT8i6233sR1fA9e6TNFPH6g9ebbfSP/etzavuRmG2acj8X4gaSBHTQFnBRS8F6PwE/9WVfeefx39qWiTlA5Rm+13wLyStdSX7g1440MmMrlhJOljFvuBeIkuEarrjo+NW6Um94jnudJQxem3YAhzscVS5/y6wcpaNEVT5JAkjy39NH2Cvu0Ly1doE879lfWmmveYffSwq/c39qfJ5YB8ITjmd3FxFtshXOgTy+djptbEaav5jcucOWO+RWjN7uYedi4mo1mddR8oj5gAf9swBSro0rYhgo9TRcWnvDchhXkdzLmyh6ghPZCmOOf6EqWlwUCx8zGod1MUwuqGOUZn8GuO3+SMfjIoZMwOIPNJYPdzvWdN4YSIAFs5nJajxxSVeAQvvfc1QEUx7s9PRZ0txY5cCWVWX3JpmrpQJGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnVTRlVBNDU5VzZ2MndDeDN4WW02VUVqZmtwRlE4L2hWUjZzd3lzNkhKN0RN?=
 =?utf-8?B?Y0Z6eC9MT2hrL3lvUEY5VFAxN280M0xXUEN6STlRSENnbzNpRDBVajc3cXZW?=
 =?utf-8?B?RHVjbENiM1Zoc2NldEhPeHhDK2FYQmFKQU5HRU12emxSazZUL3dKcjI1STdk?=
 =?utf-8?B?VmRpOEJyWTl6OFFHcEdqck9sTjBVT0VnTmg0TEhhbjh4RVFJUG5KMm5Zem1w?=
 =?utf-8?B?TWVTbDBPVVVwWG1YZVVjdFUwQmhkbmlZNkRFY1NFSVdtUi9DY3dibjRNV0dm?=
 =?utf-8?B?QXNOZzZJSnNCbGJrOXB0VXF1bzFaeVlmQllGUXc1WGMxaXMrK3h6eFYwenNh?=
 =?utf-8?B?RENiSHB3bjBXVnhtTHI5K3ByUXZBZ05qNkgzQUdtWGpFTXRxNWhVK0dZb1V2?=
 =?utf-8?B?aEZNYVpxTVdQVlFBcGx1Ui9PRzRKR2pkb2NXRjB2OHVLQzBCWGlISWw5dm9z?=
 =?utf-8?B?ZExOSmRxbnNqS01Vem43dzNYTDlyZXMyN3pEK2JHcnlnQjBSRmIvUzFJTXVz?=
 =?utf-8?B?TDdjUm5sTjRtdVMvZ3kxcDN6NTdGZVY4NmJXUWZEQjhtTWxhRityTERqQ3dP?=
 =?utf-8?B?QnNmL0JQMzJwTzl4a2xUa1NkdGVjWjYxM0VSUDYvUWd5S2FKa3NaWTJsdDBK?=
 =?utf-8?B?ZUVkdXF6U3JUVlJiZTBsK1ZENmQyTVVLRXBST0taOHQ1THgyRGZXM0tWbkQ1?=
 =?utf-8?B?aUdpUi9SUldLcHNJKzd2NlZnajhHVmpWcHE0UUpwcHRQOWEvZ2EwSnhOdU4r?=
 =?utf-8?B?MUpBeEtkZEN2dmdTWkRWQ2cvckVhL2IzMjYrTDBObWVNVjZ3YVhIUnEzRkhz?=
 =?utf-8?B?OWpiakVZNXB1NWE5U2hPckw0a1FleHdtaWk3YUc2WUVPYWhiRjRNNjhLZ3oy?=
 =?utf-8?B?dGRzSE5SZWV5T0hKdFBGdzdvSk9CSHpVZmRpZkNqMWNiOHBkZHp1WXg4ckpU?=
 =?utf-8?B?dE15VVRjY0VSMzRZd2hGUnBJYWxxT1FENnp5T0NtTmpyUlNjckJwajhzY3Rm?=
 =?utf-8?B?UFFxWWRyMTRjR05rZG1LdFFpUnQ5WjVpV1lNbHRqZFIzR3pGamVTVnhFSjE5?=
 =?utf-8?B?dmFLanZGQ1BObjdoTENFR2tSNjRQMUlSSE9NNkIxV2hSL3hHTHJjTTBDUS9M?=
 =?utf-8?B?UFIvTUZQTXpVRk1zUC9BUHpxQ2lqSEIyMUdNTWd4UXQ3TkdEWXhRdEJZTWlC?=
 =?utf-8?B?VC84a3FLbnYxRlNVQzJtRHpTZmhPWVlOdFZ0NGo0LzVkdmI1RGlBNTBxY3d0?=
 =?utf-8?B?cnFKVEtiNW9qK0JHd0hMM1lWTGNkQlVuWU1ic2Q0bnRmOG5sYlkvTUZ5YTJB?=
 =?utf-8?B?LzZCTUJ0b0g3ZnVCd1Z4aVFXV3BiZW9jdExHdXI1ZDdhUC9QblJBR0pXdE5z?=
 =?utf-8?B?ZlFYVE1RUXRNM01hVHFxMDhKckx2YUlJSXY4Y0s2aDY1cTNPb2o0VkFjRlM0?=
 =?utf-8?B?cnh4OERpOWp5Ti9PRlJaMHlPaHFXN3lWSGQxc21kUzkzS2hWU2t1RDRBMDlO?=
 =?utf-8?B?a2ZyWjY3REZ0SFM5UklKdFRGLzdnYnNxK01MY1lVbXlETkxQT2JQdFRVODJk?=
 =?utf-8?B?aVUvOWZlN3RxMXYyNlY0LzFjSlRXY1FuUzNNMkdBYVR3WThLYU9PdUUzWjhR?=
 =?utf-8?B?VnVya0o4V1M3cm9UOHExcXRtTXJmSFBZaC9XdVBCYU8rWVFWUkFNVEFzMWpC?=
 =?utf-8?B?SkNVSVJyMU81MG1BRHJ4VU9zZDRsVTRLaXRwbDBpcUZNbDc2RjdnQk9Fb1k0?=
 =?utf-8?B?NzRYeTJOOEtMODhNajNjTXppTjZMQVN0dmNhYkxjbVhSenNCRktvdDlxS3po?=
 =?utf-8?B?VEZ4b0EzQWVBRENBR3RXaWcvejdqWlA5RFkzT3VmUW5TUnIvRHJuckozNGs0?=
 =?utf-8?B?dkJ2bjVrQzFlUFJ4aWwrdnd6dUgyenNRVkcwQStzcUJkWlhnSE5VRmhDT2ll?=
 =?utf-8?B?dTFndnBpeEdvSjhFcTZkRGxycDJNVWNrbWtOQlJHRGE1c1I5QXIzZ2dRYW5Z?=
 =?utf-8?B?TVkvOTFMMGg3N2JzOERRZm41akxDSjdUdzNGbVFFZGV0dXdsRkhubW1HSmNt?=
 =?utf-8?B?eFJBaytBNmpncFhERHhFWU5BNlNLbFc1WEx5c29GTHpLdzVVamNlcWhhNkhj?=
 =?utf-8?Q?JeXUfMSkn7+6biiRkbD0p4j7w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe201bad-89d1-491d-b7b0-08dc586e7749
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 08:24:25.4054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTH0l6UEaBiUQhop8firFLqQpRGEfgDPYGUNivEd+C6ZJO3oItde4Mm97ZajjtdpUKOYaMTOBpIpqwKOWUTCvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6345
X-OriginatorOrg: intel.com

On 2024/4/7 22:42, Lu Baolu wrote:
> iommu_flush_iotlb_psi() is called in map and unmap paths. The caching
> mode check before device TLB invalidation will cause device TLB
> invalidation always issued if IOMMU is not running in the caching mode.
> This is inefficient and causes performance overhead.
> 
> Make device TLB invalidation behavior consistent between batched mode
> unmapping and strict mode unmapping. Device TLB invalidation should only
> be requested in the unmap path if the IOMMU is not in caching mode.
> 
> Fixes: bf92df30df90 ("intel-iommu: Only avoid flushing device IOTLB for domain ID 0 in caching mode")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 50eb9aed47cc..493b6a600394 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1501,11 +1501,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
>   	else
>   		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
>   
> -	/*
> -	 * In caching mode, changes of pages from non-present to present require
> -	 * flush. However, device IOTLB doesn't need to be flushed in this case.
> -	 */
> -	if (!cap_caching_mode(iommu->cap) || !map)
> +	if (!cap_caching_mode(iommu->cap) && !map)
>   		iommu_flush_dev_iotlb(domain, addr, mask);
>   }
>   

The existing code works but kind of confusing. The iommu_flush_iotlb_psi()
helper will be called in both the map and unmap path. But device-TLB only
needed to be flushed in the unmap path since there is no chance for
device ATC to have cache for a non-present mapping. And only when caching
mode is reported, then should the helper be called in the map path. So the
fact is if caching mode is 0, the @map should always be false. If caching
mode is 1, then @map can be either false or true. To be simpler, it should
be enough to check @map before flushing device-TLB. no matter caching mode
or not.

-- 
Regards,
Yi Liu

