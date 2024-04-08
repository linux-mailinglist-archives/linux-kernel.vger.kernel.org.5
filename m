Return-Path: <linux-kernel+bounces-135473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA86289C5D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE297B2A2C0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9D97F478;
	Mon,  8 Apr 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJxljgJ2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA007EEF2;
	Mon,  8 Apr 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584599; cv=fail; b=cnsALAd43vmuSgeIcCahl47UZa43BNcAMWPudHLktMNuX5iVoH5H+pEJKc8VU8EVpijwPnHnZ4dusogxlp0yPBhjnQ6Ut7wtUiu5qwlqsa8RoPOMaDfsRsmZEqL0TQ9++zME25CDqifaUgzpnxIAbBVIGFBCHoyydNIjZfnYWqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584599; c=relaxed/simple;
	bh=gxVnXcu376VcyunHWBhMFIh2tXtG6YOp6B/A7J+6ZK8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mEgzCat3u/QsTwiKLncMgIOCtQpCayoYf4t0zDDlnuWqJz1Liu3aF5evaAABkkmSlDHRHV9Z9FdrVR6ijF9rrxG4MblY6zPxKaloXYWEtiClrTt7Bpey1zgHdG06/xOH+q1mDOflEeqgj7h7v2aO1VJCe6Tkb7/FZc67aKqEFvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJxljgJ2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712584598; x=1744120598;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gxVnXcu376VcyunHWBhMFIh2tXtG6YOp6B/A7J+6ZK8=;
  b=kJxljgJ25QLQ9LI9//gxE/Tgkgj5IFLq4YkkRQGzAyfFoYttQZBeL1hy
   BMOhjMovBVU4WqvIgHZnzyyPVxSBxxBK4waucILn8Q14tpqrXRatAapdW
   FpWzTtyo4rVXHHb+WbRmgN2uLvHru+s+rXQowlzmBFoT1Oe0qVQz/RZQX
   pb5AjE29lWl9+4PYOpgqU5F/A28VDqFf3d6qvUizmjmuLuba8ia0HSTS7
   u8vJM1NeQBUOkDAyGMWx3vTi5dSJP1X9O3r1/uTzrlphOBn5JpMQybm42
   ePghMhfxLqdQoxLW0izQ9My744KByGVSph8ITvdsCc9GOisCmsrtfm2MM
   Q==;
X-CSE-ConnectionGUID: atiUTno7QOWK/Ksxo1aeTQ==
X-CSE-MsgGUID: VopUolHtQOiGlEmLyVzP/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7770773"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7770773"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 06:56:33 -0700
X-CSE-ConnectionGUID: OUYD2HW4Ti+9dp5fTXuagA==
X-CSE-MsgGUID: HdJ4vo81QFCZ9ApxKhJJJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="24666640"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 06:56:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 06:56:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 06:56:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 06:56:27 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 06:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEtUjRFUJIzGKp11PATgOtena8w9Mp/V6zl25HrAlb5hIUrg/Xodyot7+SNBCREGOhOBqmp3iS3g8lpeCOdPshPN7niKH84Iobib4xqHyyx831w+5It4dA44KzRh+8bIbtxAlilybB1yj8iK1InGfph+5CwCy+0xMO22jyox5eA3sH4TKWh6ufHwHt97RdOmAMFeZy9ljvF4GE4iaC/c2YBhPenHtQMhOP0qaPh1Hegu1uEq7fGI9vjiykr/tqEb7OqUSb2ubNsHKpi3rdrR/Nty6KcHStwjSLcR3ujEijKKn6Q7bAKk5xEIT8MaH4B6yurAbZb5HHOp/+Fldwr70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdX8ezm4O0NdC40qsvz4e5ZkqRvSj5XAxKo4I8CzcMk=;
 b=FkmGT8cxjNaF0Di+AYagVvnsnTVGWFGgzD+RTNLiTu0xJ2Jk9pYaYRtSCWZ/VV4RGVh8G7vKXrvRRVADY2BM9R623w01113EGthWlza/mkbJ8Z4YiKbCyeGo7J5ixGgAXSe7TZTKFhXpyD/3gEcJrHVp/ZgNk6wBeJq0wOk/v7VYHVRiasxr/CFfIYUVzjwKXu0Xeaexy1xNQ5Bvs3YoGM1t1eL7GIIdvDCagWOs2iIdajFwtqY/kGDQFgkGfy9yd1ywpIXbZxBN4YATPrlAXJWfUU6+JmYcevDd2OcBsRDnlEnb1gfbk3vnTWiZcsQJcaEcf1DkOLLzVpgU89SMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 MW3PR11MB4746.namprd11.prod.outlook.com (2603:10b6:303:5f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.26; Mon, 8 Apr 2024 13:56:26 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cb11:e68c:53db:aba5]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cb11:e68c:53db:aba5%7]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 13:56:26 +0000
Message-ID: <ef3dfc2a-fe7d-468f-828e-a97ee30f7549@intel.com>
Date: Mon, 8 Apr 2024 15:56:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
To: Mark Brown <broonie@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
CC: Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>, =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
	<amadeuszx.slawinski@linux.intel.com>, <linux-sound@vger.kernel.org>
References: <20240408141216.3eb1128c@canb.auug.org.au>
 <ccfe882c-652d-45d2-a9e3-d320ebe01834@sirena.org.uk>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <ccfe882c-652d-45d2-a9e3-d320ebe01834@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0177.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::26) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|MW3PR11MB4746:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJx5RUmEUiZATuCm4+BSvFKkQAQ3lZ2TFBbiTa2QR/5l5wqnljtRurenv7cqKadtuWUlkUcRZxP1Mj6+pEV6LRR1YExlxRQLhfptUsoLVgv9tZXTXjog+9jNclSvovgyhGjvaKEfwi21J3t7pvzy6pIGrV5xildiz+hqihtZU9US804XxAOH8+dR6GnPz3jEjkFgji3bEQ47ZOCIWjGNR57Od/sYX3gVaYnhqgiuRo7pU7fOyweHeIKhSTahtHwShvBXGpFzFA4z4kSFDsDRWLiQ05lcgAUKiAKgnQxQeIlL4RIxV2rO9WG9jcsZB9ozJ7MCKv8LalAHuufT4S8NBniT+lnia+e06QCfgtTp8mzqQmgax3PVtsC8wYV2D0ZxnZGhIvHmR4kdViIdwh5g7ennbqBT26aNM5Ti/JG7njAK2kILT/1QxoCUBLy8jew38vwPYKaGb9HwEw5N25k1y8mPNLWXtpwcs9IZ7/ZEYvhd4LlP+Is4wRWqfreeK3mSFmmYVr4LgRLXKyfFRoBwxOmWVSP/HzUEndLrhy4223ZXl5t3HxN/9m3SXWGG3qriL7Ty6i4RdIbW6k+zcasmS6ZePuieWjzn3WjfqGXYboI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFdrSFlOQmNLMlV3d3JrL2NoOXJsYTZ5YUJvR2Z5dFFHb21NcFl1SFlDZHhx?=
 =?utf-8?B?VUFQd0VtZ3VLVFhOcHh2ZnRsc1pjaDhpR0kzYUxyZzVKRHpxN3VIK0NuMEQz?=
 =?utf-8?B?ZjRucHRBeEhJR3l6ZEJySXhVNlRNcEYxenEzT2x5WGRlb2dYS21PcGlsRmZq?=
 =?utf-8?B?bVVJUDZZemgvc1liWEQxSkl3RU5udEZzM09PNnpPeUtXaDV2cXRheHBiKzBu?=
 =?utf-8?B?VmZQSW9mZHFSUzBRK3JXVjhoT1dQbWpsc2VsMlJvUFYyQXV1U3JFRjhoWGl2?=
 =?utf-8?B?TXQ3VXlZMzlvaWQ1ZFM3by91SlhuRjY5WVhhSzNlVnE1SzhreGdhS1huY0R2?=
 =?utf-8?B?T01ZSEFIdkRsSVdGZzBRa0ZvcSthbWZpR3F2enBJdjBjSjBrZTdOWXJ3YkZ0?=
 =?utf-8?B?QWtGUElwZjJuZUZGQTFzTm93SHhWK2laQnVJT1lNU0ZTZE0xYXNlRDRvVTZH?=
 =?utf-8?B?cUk0QnNpVUJrRE9WWmdENmtVeHlCdmVKWUpuYTdrc0tUc1JRd3pTSlRzRlZ6?=
 =?utf-8?B?dW5SOUFBYlNWZXZNYldGaDBXM2pPbjlrWmg5ZldNbmJsTHhQdDgxdU91STA3?=
 =?utf-8?B?VWJQM2xFYTQybk94R2crdDFNVVVIS2k5N3k2NjhQREowcVh4bEYvaHA2aXVi?=
 =?utf-8?B?TWNKb0FhTVZZZ3ZMc0hyc3RkOWNLUDdZNE41S0liVWI5dGV2M3YwVnZBQTZh?=
 =?utf-8?B?OWw2VE8wTmZEcGh5dExDSWxkeGJEaGJGRENHK3NrU0tiZk9YY2JKaXpUemFr?=
 =?utf-8?B?VUlmTjdUR0wzMUhDclhicjNUSHlmaTJZcVhnZGRhQ3krMUpadW1NOUJrUWRF?=
 =?utf-8?B?aVNJNnpQaHNieHJ2bXM2d2NLVGhOTWJzUlF4cjVQMmhWNUdNU2hZeGpZU1FD?=
 =?utf-8?B?VlcwZ2dVNjVxVWlCRXA1Sm8vU0NsUi94YzJ3alFkNWx2VE1oZVJEQi85MnBF?=
 =?utf-8?B?b0RUYVhjYW5NYmhCZE95bjJxVk94dlAzNkNZR1NHdFFXZTVRcTZFWkdET1d6?=
 =?utf-8?B?dldwTVFFcm43T2VYc3VyNWlPT2djQTNOZmFDRWtaMVYyZzR4dmxFVk5vQ0pB?=
 =?utf-8?B?d1V3cUxtOGd1eWk5U21tVUZBcW5rK0pvN1hwRkxGbGRiajErTmVDakVxMEh6?=
 =?utf-8?B?ZVVKY3lvamdLYW5pNzhVVUwrN1JqbzB3ZU9RMVJOVDJaOVpMLzcyY2Nkanhr?=
 =?utf-8?B?WXFGcnY5VVA1WTMybWVFc25NS3h5SXE3eVNlenkwR0k1REZWdW5YNHI4Y1d2?=
 =?utf-8?B?TXpnL2F6cGhaYWhxcUtSa2JXbkplTmZzUmpUcjcza1d3N2dHV1ltcFJCT3NB?=
 =?utf-8?B?MHhoclNHMzRWRHRmU2pob3FZTHE2cTR3MndHWVBBMmFUZ1JaYS9hblZGSTVX?=
 =?utf-8?B?YUNwMTlwQmlWdnBiM2lLTWhmczU5YjlKTGI1QStHVldUMXpOSGpqZU1uSnMx?=
 =?utf-8?B?OGlDQ0kwMGdZUFhXZktiTXJtOU5MSGdUQWxhUmVXRG9mTHlyckh4QTNEaXVn?=
 =?utf-8?B?ZkpqbHByUDI2SFplZGNCSjRUL040cS9jK0xscE45UjlDOEFBOGM0bVFNc3hv?=
 =?utf-8?B?OFBsU0pwYkdMS0RhL2I4Q1lHcGJYdHpmSjcveHNJNTMvSWhpT1pqdXNPNDRD?=
 =?utf-8?B?WTZPUGJaVE95SGNKVzhCQ2hpSUhYY3Q3cStUMVdEZDVCUHRLUmM0TWNxbzR5?=
 =?utf-8?B?eW1OTjRCazdBekJ6ZXUwWm80cUswNmc3aGFRSm5zTXFBL0UyU3IyNUQ5V1pj?=
 =?utf-8?B?MXlZTVpZODB5SGxtUHBkRXhsN0t6dU9Xd1hhQnM2dVBKME5ZUHd1MjBZUkZB?=
 =?utf-8?B?U3dROEJrMVBTSzlnaHBnTlVkS0VkcUlPTGd6YzFmTmJiSHR3aE9HVjBKVWFn?=
 =?utf-8?B?bEhGcnora2UwcERpcHdPN1VXZFpLZjdUSnNYaTVJS3R4cDZNYkxQMDY2UnhU?=
 =?utf-8?B?aDJkSnhNSWJDOW4yajUrKzJpYXVaUkEzdFN3eFQ5Q0RtVFA5Q3dGQWVRd0lS?=
 =?utf-8?B?UmU1alRmMFJPOW9QZ0dFSytKZ285OEZScG5ad1QvL1V1a01XbnFOTmNTaDZh?=
 =?utf-8?B?ZnBpbldPajZ3UGJPajdjcUYycE5pTXdiQzkwNjdEcS9vWGkwMm14Z0ZUbmhG?=
 =?utf-8?B?M1JLVEs5ZTBSRzdNZXZRVW9wZE0yZ3JNTXlkRTNLZU9RQ0xSdjMyZkVZdGp2?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a530dc-ae58-4f89-0f3a-08dc57d3ae9a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 13:56:26.0794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCM2h5akEjKxjPzqjuorgoI1RecSxbqgFUEDzL4tCy/Ufs31Jgtf7+dJxQrV/unzAzMn1rM8ikA5QyjPhoHiFhJyLasBIBBiE2NRMPJZI7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4746
X-OriginatorOrg: intel.com

On 2024-04-08 2:28 PM, Mark Brown wrote:
> On Mon, Apr 08, 2024 at 02:12:16PM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the sound-asoc tree, today's linux-next build (powerpc
>> allyesconfig) failed like this:
> 
> Copying in Amadeusz and Cezary, this is from the recent AVS changes.

Hello Mark,

Sorry for the trouble caused by one of my changes. I've replied earlier 
today in this very topic and provided a patch [1] which I believe 
addresses the problem properly.


[1]: 
https://lore.kernel.org/alsa-devel/20240408081840.1319431-1-cezary.rojewski@intel.com/

>>
>> In file included from include/linux/bits.h:22,
>>                   from include/linux/gfp_types.h:5,
>>                   from include/linux/gfp.h:5,
>>                   from include/linux/slab.h:16,
>>                   from sound/soc/intel/avs/icl.c:9:
>> include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct avs_icl_memwnd2) == 65536"
>>     78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>>        |                                         ^~~~~~~~~~~~~~
>> include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>>     77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>>        |                                  ^~~~~~~~~~~~~~~
>> sound/soc/intel/avs/icl.c:73:1: note: in expansion of macro 'static_assert'
>>     73 | static_assert(sizeof(struct avs_icl_memwnd2) == 65536);
>>        | ^~~~~~~~~~~~~
>>
>> Caused by commit
>>
>>    c2b10acb62c1 ("ASoC: Intel: avs: Add assert_static to guarantee ABI sizes")
>>
>> PAGE_SIZE is 64K for this build.
>>
>> I have applied this patch for today:
>>
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Mon, 8 Apr 2024 13:50:53 +1000
>> Subject: [PATCH] ASoC: Intel: avs: stop building when PAGE_SIZE == 64K
>>
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> ---
>>   sound/soc/intel/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
>> index 4b9e498e3303..abe5cba82d50 100644
>> --- a/sound/soc/intel/Kconfig
>> +++ b/sound/soc/intel/Kconfig
>> @@ -211,7 +211,7 @@ config SND_SOC_INTEL_KEEMBAY
>>   
>>   config SND_SOC_INTEL_AVS
>>   	tristate "Intel AVS driver"
>> -	depends on X86 || COMPILE_TEST
>> +	depends on X86
>>   	depends on PCI
>>   	depends on COMMON_CLK
>>   	select SND_SOC_ACPI if ACPI
>> -- 
>> 2.43.0
>>
>> -- 
>> Cheers,
>> Stephen Rothwell
> 
> 

