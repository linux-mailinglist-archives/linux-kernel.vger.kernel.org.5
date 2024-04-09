Return-Path: <linux-kernel+bounces-137717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAD289E654
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A67D1F22CAB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAD31591E6;
	Tue,  9 Apr 2024 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRv9pFmw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9824158A27;
	Tue,  9 Apr 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706292; cv=fail; b=PenrS4wj3icjZmHi+3Zj4TQ+P4vxUCwUUYtZDh5Z+6S7RohrZQK1YKaIY1VBx8w5mukGeuCvjC84up8XuU6xrCzIHYJtSavSS1xPDCI1RJ3GJeA2PpLA6PyQ+Ap3HQyOERQQHuLDL9vZGVkK+zg/NGulTP5lCpj8lmvWyEwgKvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706292; c=relaxed/simple;
	bh=081TC0wJxXzgNg8xgeF1MGVLnldRmWkeOQFUHd1USF0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tt6BkjDlzveU+nAYopAAaaat6V0wrdDQsXnf+rdfC7RCfJW0dMO3EyZToUand+RVrXHIN1uBZdPZ4hfu9ljM4LL2EYvaRCIWqQFgaIHvczRxlkscQRUx+DxW+FDMs26+PkEWcDHQF7ePWnrblGQzdO5szARq3EAsbU3KNBohKkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRv9pFmw; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712706291; x=1744242291;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=081TC0wJxXzgNg8xgeF1MGVLnldRmWkeOQFUHd1USF0=;
  b=GRv9pFmwrQvG7LAh94k3EVtYA3xsi18F7LCBcvb2qt2S+cFwsiH35dQz
   QSoJjczR4IZoTeABlAombbnKlP85wQsaw2rvz9wbomx6BA2Z31xaXPXlH
   BC52BU67GEXAYPm1a2CVSnUhBTFgxkr+p7Ojq3IKjRrmfQJlZHR1XkwqR
   RTn0EwhE/LC2zKt786+1q67HnWobbHfCbcW+9XcoPaOyURO7GpWPiSDq7
   /PEejskwwBwi5fXuWJnzT5HjEpQXIYUCq11TFi2W8Dmxv41fiJQgcZ4iw
   weX9/AuTOs6VpJevekYwdsb4xJM2OmYFxFKVWc71Vq1+xheJNQTrDM4xS
   w==;
X-CSE-ConnectionGUID: oJLVDkufSTytA8ASNeeZxg==
X-CSE-MsgGUID: eDj15eR1TF6ykeTepH/XOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7918908"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7918908"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:44:50 -0700
X-CSE-ConnectionGUID: i85KZtseSyqOeBYOJDZIng==
X-CSE-MsgGUID: 2Jo2Qr74RSyaYvnMMmfsOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20854068"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 16:44:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:44:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:44:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 16:44:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 16:44:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7Yj+qXhuYQmPFe79IDr2jSjUkaVRkV5y1q+ZSeDeiN3EG7TM/FOMW+hmt8+as3eraOfyePCb3wDV2LFfXk7SvJPHpQuTBVixc40Kfa0dFlSsubZsCyn06kchEyAr2J5a2box5zwxr+NcXNtZJT9yRy98p2DJT0Dz90Fz9pelD4tmr9+uuimZ6ameFXxdXdPosRzFs/ICgF0v4Jlgge1ybowyZPwFv1plffBvpfY/X78U8YrcHbFOgEme0wznMUzT+QbD16woHNYrO1mPWEXaYEvZDdJnIGf284FVNw1o/VqOGpvjqnwjqmxF5cCtda6OUdKy3ZHQ8Ia9pwMW5nFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFoZ7IjasnYs2xrrjy3wVuC/zS6Mk2PMRlen6Gs7Pgo=;
 b=cneBGFQzi1BbUMK+mdFAEaMLvvIOgpWZcf9pdZ5mHjHu4orkd/z6DpTTIKBzuyTK2UIMrd8sgAhjh+tSJ/6Lb0rkdAIxvqt+XJ7MD0OtDadgJhaMkKTwRbZyThePhHmDb/T/Cpv6XvfE6kDsqDjR6tOY/d+grA4vq92dCV0QjMn1+be0rO/1WexF0FWeD9CPPCkAaPj6sD8CRNOnVZ37hGOEteGWjPWydAaSCsu6bqLhUOgjeYnBOQOS/33pXm9wGHIieSt5EB8KEx8SIgHvjPGz7zrdawycyZltmYeqWPrPRiYxs/cCIP/f/GUkwsXxHMCeI65bbfhXMJ5H0hFtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6854.namprd11.prod.outlook.com (2603:10b6:510:22d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 23:44:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 23:44:47 +0000
Message-ID: <196d6381-b5f2-41aa-b49c-003834616dd2@intel.com>
Date: Tue, 9 Apr 2024 16:44:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] octeontx2-af: Fix NIX SQ mode and BP config
To: Geetha sowjanya <gakula@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<edumazet@google.com>, <sgoutham@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>
References: <20240408052611.25736-1-gakula@marvell.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240408052611.25736-1-gakula@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0286.namprd04.prod.outlook.com
 (2603:10b6:303:89::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6854:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZCbaskXFLb5JKQ5RpS1zg1m9RKjHlkI0cNuNMyPSRMkPyzHYHXnB3IhJTEwvqOVZlb8CX/eBD/zh7dp2zDOLMCk/Vp8dUfT4H0yCxNeP4GGBSJr9C9gG1+eXXgbKsYNSICu0quFtalWpVMOVUsEIf6FHRyImlbKhGulSNEjqZHx7UqSvX8hp7uJ5oxL15JqJolM//XsxhDE6y83HEHDm41jvysdk1c0F3c1RVRbLwHLwT88AYRkWjyEzO3yHWv2bRuY2yjBbu/R9cT6AuA6+UckYK3AMS469+ef8+pJV0zmM+WxCOV99FAgnNom93mSTU6NdCGQi1jnKHc7YzP6Xv69iauK8EFWCRgknFGPRQuvvYJBShdMPGpfWuV7n+8auOIxXP8Amt5BBsyiohB1mkcFEMrVt7AgyDrAW5/Z4+uPKwb3OvTMz3K05gXN8YEgy5GOVh93nrPIOo188sQIZXBgotqLe6xNql1NF/wBx7PzyRlhRbTb58j9mf0/Oh8t38781Wbt785jEybPnFKXozw6OPRKwSF1XiYj4KzcDS8kTvgiWPtNjInJH5NN61x8q5Qsc1ozSHL7fKFd2uaJTsOOGWDezuWM8D5EoxjrabtMCx1yzV/JeARFeoRL7CRjKRfgggsZZxGdmcPOJLBJXGnfHxKPPxp4RtZbb/XNtCHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L25vWDdHajhNQnF2cW5CeFIxRGNQM0g1WDFLTHVFTGlEekcrQ20yK21wYjA4?=
 =?utf-8?B?d0ZOWno1WHQxaWhKTS9qVjNMaHdScndicUxSWXY0Q28vN3kwaEo5N2lZa3lP?=
 =?utf-8?B?NWw2ZTcwWGhVVlh6UWNlYktIbGNYbDIrRmcrK2h0OHQrZmJlTmxnK25NQ1NO?=
 =?utf-8?B?STh5US9oM2JFN1czWkMzd0cvL1dQazNZa2xGZG5zVVplaHIyRkVJUEMrYTlR?=
 =?utf-8?B?SlgyTXNvbzdkWHVVR1JtQXNUa2s4a0t3aUdYOFdzV3lBNVlXWnAyUXVtSWQ5?=
 =?utf-8?B?Vk9PYjdrWldIbHB4NjVrUDgzdjMrU21Xb3VaYXpjTFJDc20rczlVeS8xSGtS?=
 =?utf-8?B?YkwrcngxeE16Qjk3Z0FSMkp5SHkwUVlwOFNhTlg1dS9hU1pLQjZZMDkyTnhk?=
 =?utf-8?B?cWNTSmpVMjdtOGpRRmNGR2xGUkVhdmM0bkt6b1VLbkNnTE4vZ094WGxqRkFP?=
 =?utf-8?B?aDVEWk9LNGdxN1JhNTlpVW5RUzdoR21FdU0xQldsMFBXK0I2NThUTDNDVGlN?=
 =?utf-8?B?YzdERHV2SEIrQkRJaVBTdUNabnZtMFh1Tm9XMTVTcjV4M21aQnovUjdwSzVy?=
 =?utf-8?B?T1czbDNzSnFrSWFTWklJcGNYNkN5dEdmQ0VxbnFxWG1qMTZhUHBQQnlpRlFF?=
 =?utf-8?B?QUNGSFQvYUJuR0tsQUFaVkpzN0JOZTV4d0VKcWxUQkl6a0Q5UFBuSTJvcGFG?=
 =?utf-8?B?b1dObGlTelFaNlYvbUVpaXA3MWYyYWN0VUVLU3BsSnhVV0NxaVNIL1ljNWRB?=
 =?utf-8?B?b3VsTkJTUkQwL1B3M2VIOU5ZMC9VTkdKWjBUU0JsemVodk1tb3hEZHoveDV3?=
 =?utf-8?B?SWVKdWJNQ1ZUd29TR1JEckVoMXdQdTNNU0ZFTGQ1emo4U2l6VEsxSXVLR3hY?=
 =?utf-8?B?N1FWbFFTS1E0UzhpaFB0TU9yU1JUaXZDSkFEdEF5OGhyMkpBcUcrZS9pMzFk?=
 =?utf-8?B?dGhCVGhtVlYrNDl4WUxER2IzMGxjRzRxbXFQUkZKdnpsZEdNNGJMZDJyR3c2?=
 =?utf-8?B?Nk53Q01RbjMxWHhOWXZ0cHhhMUdLMWxIUzViS0kyQWJ4bzFMYzhXWlpQR3Nn?=
 =?utf-8?B?VGl3azE2L2MrVW9SeS9BMFBKTGlOd0JjeVQ1ZUFTRTRKTHdTTVZTOWdPRTJv?=
 =?utf-8?B?bGU3SEE2bkEwaExXWTRzY2VWTWVjall0Y3c2YXRnRWx0NVhiYW41bjFrcGs4?=
 =?utf-8?B?L3FwRjNoWDFPVDB1S2dkK2hVeGpuY05IdG93UUFacExhRFQzUUJhUitGWlB3?=
 =?utf-8?B?a2xyeXZHV3Jqb25IUVRvUkIvVDBLWFpTVG54ZTVFSDdndTZiYTVuczVQSGJa?=
 =?utf-8?B?c0pURFU5NzFISTY3ZnZVYmVCVDB5dHI0dkxOckVoU1ZMOGNkMkxhNEFUU3BX?=
 =?utf-8?B?MHB2QmdicTZaRHRCc3l6dTk5SG1xK3ZPeUp6RHNMTEIxTTlOd1JIWjJoQVpK?=
 =?utf-8?B?V0h3dXIzbm8xVkYwaUVYU3ZzMklhL0piSUxMNm1qNXkvaWpQZ1I4c1E3bEZ6?=
 =?utf-8?B?enhZWnlVS25CQm00OC9HeFFWSTQ1OXpqTkxVYmRFcW14Uk9ZbzZ0a01zRGxq?=
 =?utf-8?B?Qkt4c0tJYUh0QmV6dFBnNTFjNm42QVlyaUU5QThkdElmNVRqOXd4ek9odDc1?=
 =?utf-8?B?Uk9DeisxdkVnOTdOUUo5R2FCZ01kd1NZZzNUZHlZS09WOTFMZVFXaXFQb0VE?=
 =?utf-8?B?S2w1ckt6NkdLM25qMm5RRERSSnBocXBrRlJsL09RdFBlS1RQOXRqNXl1WlFu?=
 =?utf-8?B?UUpjZ3Z0QkI1L24wdlJUcWZkSmJGMFB1akZUWmdiNEhPNnFvdlNPeEU4VlMv?=
 =?utf-8?B?UFZ6Uy9nU1U2bGYvak12UG1zbG1NUjBRbHNLMlIxZkJIRW5Gb0orMFBHMGVr?=
 =?utf-8?B?dGJMSkRjVUhNeFBCcERob3NqU00rOXpDKzZVN0hHblRXa1RYd2ZjeEFqazk1?=
 =?utf-8?B?TW4xS2tFU0NFd0VWY1E0L3EwR1pFYU5PSU1uano1eVZsb2NMdHhGRDhTZTJI?=
 =?utf-8?B?Wnc5ZmlTN2QybGgxNFlzUjVFa1JGaU5WdGlCM1NCSGJmdmFoWVhmOWZPdlFZ?=
 =?utf-8?B?bS9sR3dKQkxTZVdQZzNWUDBVYVcrbVZFOEl6T3JWWjFXR05pUGNXQUxxRmxD?=
 =?utf-8?B?VDRaZGtKK3JnQUJWcGFVRU5jNUx0c1ptdjQzMEtwRzlPd0JOeHJibnk5WUEy?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f58483-fc9c-446a-648c-08dc58ef0a42
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:44:47.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpIXM3EeMGV2mG6BedFthugVyO7v39RpJ/Lyh+1xypoEZ3zczPOrSGQXHc4jdxU9ghWdKI9VYT2xx6HZAd70irbcbzuqUg2v8nMw58Nblao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6854
X-OriginatorOrg: intel.com



On 4/7/2024 10:26 PM, Geetha sowjanya wrote:
> NIX SQ mode and link backpressure configuration is required for
> all platforms. But in current driver this code is wrongly placed
> under specific platform check. This patch fixes the issue by 
> moving the code out of platform check.
> 
> Fixes: 5d9b976d4480 ("octeontx2-af: Support fixed transmit scheduler topology")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

