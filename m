Return-Path: <linux-kernel+bounces-154203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109548AD93A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DE1282604
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BE645BE6;
	Mon, 22 Apr 2024 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Prg5yt0a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7244375;
	Mon, 22 Apr 2024 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829286; cv=fail; b=Iw4cvAiB928Oi25vXK1xN/+d26fC1v7OQwEO7uwZBqsM3f3jxTjk3+XItUPKvCKNFUEYyW+U6a26noQ+VHGdwbGvr0e7UCjslqTJgWs8xjFI5tNbj12Xy7JU5zR2qvxHXX7DFieNzA3DBNgbCejILxiACao3QUOyO2pWRHNTi2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829286; c=relaxed/simple;
	bh=8t0KkY2jYr2fSvhmed3VpIbvqnG/b8K/5PXbZwXTSKk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M3CSAUYbEba+9Uiopr+v6L1c41ZTKqPhR4CqddhdtgRCk1S7pJhdsEY2qlGZ7ULBsYvkT13FmBQkdRJExNgEZFQU0wMRjC3FzdsaVOvvHQ8haK3L0Kh7oaEvNim8s2sZcsHEu2HHWidWzFhl0hoMdcPvXH00EAinqTasxafmJYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Prg5yt0a; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713829285; x=1745365285;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8t0KkY2jYr2fSvhmed3VpIbvqnG/b8K/5PXbZwXTSKk=;
  b=Prg5yt0aiLVSohsH7djFkEsRjNITfXr0rkkweyX86oFEqGVTiTRvKzYD
   971+KNM8ijPo9Pj2ZZgFfQubchLoTcE47HImIFNpcbqPP8kgC7e0yawMx
   zAI5S7glcApyzsQiOu6VglDgDOTM9EPL0XQ6cTA0+ZB/g6E6R5cDJfqv5
   gEz4cXYUUqCv64opzYcMvgfganCGWZKT19hlLZLOnZgwRFE6HdyZ4LWtv
   yV8eebeM/vTxd8lkOsrcLmouvaU7JxypPauOvyRNJwcKP2u25ZOibKgZJ
   Sx91deVY9nZcYNsj9PNqRplyo0aZ8WGSBR9o8BNKeP9nTxOLZl3oUV0Yt
   w==;
X-CSE-ConnectionGUID: 98G6xyVHRfi2bkV92+Qjpg==
X-CSE-MsgGUID: FBj41SKYR06IsfUKgnb7RQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9560034"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9560034"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:41:24 -0700
X-CSE-ConnectionGUID: hXg356GJQsSK6kav/oyveA==
X-CSE-MsgGUID: 0OntW1RzR/SZp0yU5hpOvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="55114226"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 16:41:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 16:41:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 16:41:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 16:41:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 16:41:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQzg+ArXAAwcf9DSfltTybDC6raVPCaf1pbBwyBjdqQ9d6ygkUCM/s2lD9D4YcxfYRkRQDBOI3wGfK1dfcdra7euW4xlAWEIXb5J0EZUmqoq/J5LCWBlSfOFxAmldKN3UTKJB5hQaBH5UHA0tj850y1dOp0HmvP08JrJmCgNk0REg8JU9Q7hhs/+G0TxsPd+3nEMT82+ZA41MWd+jgRkv1TjF8cjCjxDK8eKc1chbXDEECF7o9GBqItvj/ydSuPG+z24GhRF9aydlSqT6zB4qxavxG43x9pxtokcDNE5YJQR/xOOicNri65La3ylbjHzn/iKx2+vRdaHtxnWxaEBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kNEn3+gdKl4x95k1ReWarEp0yCK2oCQrs68Ks8UB7E=;
 b=mOZ2+sNAg4aBtYQbTdkwhE5BjCAwAGK/T3bGUgLVRETgrIx4xQLiAQ0H7/HOghcInCPD3qsaUKVYs+1cTahegb9MqtFziGGKY9hGRY00jf7xoYj4zAx9o31aHKC5E2MLrRJNylYM1L92cR72zHKGCApWplEanw4QwkiAV02lPKUtyT6HJJoalQTUg1VFarHLjhrGAxExFOhJurdgHxdqJI3VgmJSNzBt/nFKZAS6Gw7HwPvaaeM/5KfNTgTbXfjfMjfheOI38J5B+n973k0uVdBFngGXB6OFjp8mlYht3snyQbv79cJW/xQCo+ezE7PIO06cdp7SU8ECRNIDTUD9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB8258.namprd11.prod.outlook.com (2603:10b6:510:1c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 23:41:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 23:41:13 +0000
Message-ID: <a12ac71c-5621-4014-9b01-e74ce7429120@intel.com>
Date: Mon, 22 Apr 2024 16:41:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] octeontx2-pf: flower: check for unsupported
 control flags
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
	<netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, "Geetha
 sowjanya" <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>, Suman Ghosh <sumang@marvell.com>
References: <20240422152735.175693-1-ast@fiberby.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240422152735.175693-1-ast@fiberby.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 907a0416-7170-4de1-dc63-08dc6325b26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2wyKzd1Mm5ObW9aY0Z0WUNtekZmYmdWMWxvdXRxWmJYK3NtTitMNTZtUWdO?=
 =?utf-8?B?UXBXc0Zmc2dvbzV3OGVydGRyZ1NIU1NMbGtDcHRTVG5zSjlONFBqS2xCRncr?=
 =?utf-8?B?eXpRMkhIM0dDVDBJN0hlQ2RPVzV5ZHMxUDAzSkF2aWoxLytXM0UwamlZcVRr?=
 =?utf-8?B?R0RWTkx6clBXSlNhdFBLU1N5aHhpTWNtMzk3b0tPOGxmdVBWQ0VMVjd2TDA4?=
 =?utf-8?B?c1h1amJLYjBTUVlleXZ4ODMrcmF2M1c1SXRhd2h1WCtiR2ZOTmUvT2N3LzMr?=
 =?utf-8?B?VXRMTWVJMmtwQjQ4R1JjMjVpakk2Nno4dlZHMVAvdlQxbERDSFF4czQxQWth?=
 =?utf-8?B?U2xpa2QwNXdpTEhtNlpGSHR1UUM0ZHNaY3k4eGpmRGg5RHZua2czY09RWnc2?=
 =?utf-8?B?R240c3pRN1BxSUdiUVg2d3Y2bXVrMTdBOE05ZmM3aFMwZWxNbWw3dEt0b3NW?=
 =?utf-8?B?L2gzcFNxaWNvdC9kRmtIYSt2NkFXK2FYbXBXVjFmR3gyTFh0NXFJRkRRSk0x?=
 =?utf-8?B?SWpyY2Y5VTIyUWx3M3BjMHp1Y0c5ZGJoSzdrejM5eW9iZ05PU2VkV0JVZml6?=
 =?utf-8?B?VGNtcGpucTAwRnZFUlBBS2FtOUJzNVQyenV6cnIxcUZIdG9oc3FnY2Q4R1py?=
 =?utf-8?B?dk5YSTV3eVhUMVZCWHhaVHg3aFJZRjNoanhPcHFmb1lyRHFVTGxnZWVTbHRq?=
 =?utf-8?B?YTBEaml1UW5nSS9ubGVRNjB3WnZLRVRlc1VrU3hLT0xRbWZKeDd5MXRhSTUv?=
 =?utf-8?B?WTczSmo5Mk83Um9EcTlYR0ZIc0szaUk4VGw0OVcrc2tIZnZFK2syQWE5Z0s4?=
 =?utf-8?B?azU3Mm0weVRZOEJoMTIrZURmdnN1Qk15TWMzRVdRY042TkNTNkRSekMxTEJZ?=
 =?utf-8?B?b0dDd0JEM0tsc29hdU5LVE1tTEdRUktoSlN0c0d0bXd3S1NzeFJ4MWllNU1P?=
 =?utf-8?B?RlRSTVY2ZDNmalhmcE8wR2kxY1Q4WXVOeVlyWjhic2dKcmZBekNhVDQwWEt1?=
 =?utf-8?B?aGtxcTV6Tm9uV0pLRVJEd1Q4bGRSdFBHR3hPaExMTjZRaDgzSHllTTNCbGIr?=
 =?utf-8?B?ak1qc055eFl2d3FOQUJtcG96VDhGU0JlaEcwT2tieHVpbEZubFJQbTVCdGpB?=
 =?utf-8?B?RFF2aUg5T1dlaWRwSlFJRHg2UzhiWWx1VFEvVjBQNFFkdFhBTVk4ck5Gc0pU?=
 =?utf-8?B?RS91ZSsvamUyNzJDdDBycXl3YU9GZDlFaGtQWllWZmFpWmJBbXJhN25VYlJI?=
 =?utf-8?B?N1BvYkV0OGxMR093amV2dkpFTzNSRlV2SklESVJ1R3I5S0dkbjhoNTg1eFJ6?=
 =?utf-8?B?S1FySEZsUGpMbW5uTjVDbHVSR2J3QS8wd1p6MjFZN2VQcFBFRXo3Sy9iSjYy?=
 =?utf-8?B?MldPVDQ5T0lqYThJVWI0RWtKcUlQaTF1Skp5SWtiUFN1eHdxWFpyNlhYZTJW?=
 =?utf-8?B?V0VVbjdSR3h6YlN6MGpod3N0MDYxUi9wYk1hZjdDcW1oOUh1WjU5N3VmSzlu?=
 =?utf-8?B?Nmdtb204d0Z5NzFMRmFJZ2NqbjJweEU2RVQvMGVFY21SNUxRRnJsL2FGem4w?=
 =?utf-8?B?N1lCQ1BLY1ZndEZpY01VMVZLYjFPK3NOcUNZRjdoZFYwbk1kSGFOSDl2bW4y?=
 =?utf-8?B?VW12TEVsWmNSa0tkODNRcXE2M1YzczJWQjFlM2lBYnY3K2ZoWHJVVnVZd3U5?=
 =?utf-8?B?RWhPZHlvWGNzeEJDa0xZelJjNktXV1J4UHZHRVo5MVUzRk9BYWRQRWVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHV1L2ZYdHF6UjVxaDIrQ0tXbi8yWXByc3UxUTJoTW5LMGx6Z0QxM0t6QmhX?=
 =?utf-8?B?ZWczL1FRNUc0Y00rV2FIRHVKSENHeUtoNHp4ZnBUR3JFR1RnK0pjVlJjaWhu?=
 =?utf-8?B?S2YzTEVRU2pnSGhRZHlyZFYybXNZU21pRnJtL0NKeVl6TjJyaklBM0dPb0d2?=
 =?utf-8?B?SEtSWHB2WTJrWTBjSzJuWVRpQ1AyMmRXc1FYQ21NS2FqRTN3TnNxQTArODFV?=
 =?utf-8?B?YXg3L280L0RHbWE5K3BHemt1SWducEgybTA0bEdzdGVkYktxNnlTdENtV2dV?=
 =?utf-8?B?bDFXY2xKUHppNm9Eb0krdnppMVljZE92RUpNSkliZzFZWnMweHZtdXhrQWlz?=
 =?utf-8?B?YUR1UTkzMDBNUVNwcDhETU43b21zc0R2bVpXMVQ2SFRHZTJKYnVIM2ZRK0lx?=
 =?utf-8?B?ZlpoL1VyV2hSYjdzTkVrRE9QcXd3QnV1UXh3ZmExVUZoMGFSMjNWenVSUjI1?=
 =?utf-8?B?MUVQYStMRXlLc0ZnYjRCYzRML21EYmNLa1A1bUdrRzhBTGdvcEp0a253QWln?=
 =?utf-8?B?NTB1VWRnQTZ0Qkp4NVRnMFVTSW5QeEFBVDA1ZHJYMUJ3Ym5aQVBweG0zbW56?=
 =?utf-8?B?U2p3NWJzd3Vqb2JOYU4ySTVnWjFWU2xGVkgwV2FnR2pZdzZFd2FyenBFVkkz?=
 =?utf-8?B?aTJpVkY2VlU2eDlkbGV0c0NnNkZvYVVZMHdpK29hODFrejBOcDdWVVZudkNp?=
 =?utf-8?B?Ri9Zem9pSEo3Qm5BR1p2M3YvUkZUZXpJOVdsVE5FdVgxWlZjdkxtcmQyQ3Yy?=
 =?utf-8?B?NlUxamxPRnF0RE5qdTllSGlOQkdUeVpGdjNIZGplUUYvVlpzZ2MySHAzaEpN?=
 =?utf-8?B?RDBsNlY3N1kyZUtXVGttazhWeUtqRnlLdWNvMHlQd1A3SHhMQkgvQkdjVmxX?=
 =?utf-8?B?NXBFUGhidktNaysrOVpRQjVpamM0NDd6SENqMU1lWDdXbzJQay9HKy9xVGpi?=
 =?utf-8?B?Q3lMWnFWZWhDUVBRVW1BcHpmSEZWL3RZUFhaV2xkOFo2MjYvVFdobVBqZFRI?=
 =?utf-8?B?SlVFMVVKWnpmRkJVWVNNMGFGTFRxbTdSbGg2ek8wQU1Bdi9OVFpHRmpkM0JO?=
 =?utf-8?B?L2xWaEJyeFRoU3BJYkU2QXVEVDFlK1pWN01vLzk0V3cybXFzNmVzRFB1K3ZG?=
 =?utf-8?B?SXN5MzhNbkkycWp5Nm5BalRLSGE5UUsvdEtweE40Ty9ic0luUW5OZHhQUkUw?=
 =?utf-8?B?dS9JVkJCSFpCdG13UlBWQ0xYcTlzL1BYNW5GSG9RUVV6em5jUlJsQkFtdlNM?=
 =?utf-8?B?SG1JbWFhZnM4WEVNbjZBTFU2bHp6THc3ZzFXN2QxZ0lTeU1mMjNmODJkaVdv?=
 =?utf-8?B?SWFSeU1kNzZzTXNsZVlRZlhiOHkzdnlTaTlkc0JyV2QzOWNMeTJKNzcyaXRN?=
 =?utf-8?B?MTY3bEFGOXBrS2lWeUk2bTFFQU50RmRvcG9GTU1JK3hZVUduNHJxVzJGeWFw?=
 =?utf-8?B?elJXS25QRnc3RVRjaTlCNlF2VnozVlM5MUw3Q0ZQNmJ4Vlc5SjNGcDIweFh1?=
 =?utf-8?B?Q3FTSFE0SS9SYTZpTThxMkVSUWZaUzBiYnQvQS9WdGFsa25lWFdoNFlpMUE1?=
 =?utf-8?B?SVpsZ2RzeVpGNlA4MXNVZnNSRU5XVS9FYm1EekdhZWZ1cTlBMFB5aTk2cFU2?=
 =?utf-8?B?Tk10bDNlNDZEN0g4a0FrUzV0bXFzNEZGaklpT1FBT05uMFlrb2p6czkzMm91?=
 =?utf-8?B?WllIdy9rKzBqd2lVYlI4bHczYXhmOEFSRzlqdUIwazMySm5RU3ZNZWE3WTZh?=
 =?utf-8?B?UnQrNUhscm4yQXoyN0c5NjRxazh3SEozMFlUSXpDWkZlU0dSVHY4cTNIbDRP?=
 =?utf-8?B?SWhadmZVcnNhZXR5ZWJ0MWZlYVE5OU1TSjJMdGxXR0wvVFNmelhLa3hUNVBR?=
 =?utf-8?B?L0xEWnFjN1BCYmtscElaSy9hRExpcmN3eGNXanRIYlhoS2RQQUxZeFdoMGo4?=
 =?utf-8?B?aGE5SVB4QjBvc3VkQmFOR2NmSjJEWi9IOFZjcFUrTW5pbjd5Uk81UUo3NXo2?=
 =?utf-8?B?eklLTkE4WjMxT1BLNWwxT2pocGNENjhlVW5VanorQ0k0Qm1PZzBhV3M4NHFB?=
 =?utf-8?B?L2NLUVNSQk9maitlczJyVUxwM1FWdTRwYkNmSFovRzZKemJoMmw2Zm8vNkMr?=
 =?utf-8?B?Ykt0cHE3S1kvdEQ5T2ovd2VFeVlvODNyZDQ0SC9MVU9hUWFEK0M5NHhtcUxj?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 907a0416-7170-4de1-dc63-08dc6325b26e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 23:41:13.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0B9DlVHYuXEXWd09zjS/HYERtgdEvyVp90/jsA2dv6Rd2mqBmR0JvSxsGXBhaCnvnEHtMWZzBuIt1qVxiecHLOOyLVRE71OsncW3Rk2eUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8258
X-OriginatorOrg: intel.com



On 4/22/2024 8:27 AM, Asbjørn Sloth Tønnesen wrote:
> Use flow_rule_is_supp_control_flags() to reject filters with
> unsupported control flags.
> 
> In case any unsupported control flags are masked,
> flow_rule_is_supp_control_flags() sets a NL extended
> error message, and we return -EOPNOTSUPP.
> 
> Remove FLOW_DIS_FIRST_FRAG specific error message,
> and treat it as any other unsupported control flag.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 6d4ce2ece8d0..e63cc1eb6d89 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -700,10 +700,6 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
>  		u32 val;
>  
>  		flow_rule_match_control(rule, &match);
> -		if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
> -			NL_SET_ERR_MSG_MOD(extack, "HW doesn't support frag first/later");
> -			return -EOPNOTSUPP;
> -		}
>  
>  		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
>  			val = match.key->flags & FLOW_DIS_IS_FRAGMENT;
> @@ -721,6 +717,10 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
>  				return -EOPNOTSUPP;
>  			}
>  		}
> +
> +		if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT,
> +						     match.mask->flags, extack))
> +			return -EOPNOTSUPP;

This confuses me since you pass FLOW_DIS_IS_FRAGMENT here, but you
removed the check for FLOW_DIS_FIRST_FRAG??

Am I misunderstanding how flow_rule_is_supp_control_flags works?

The code just above this appears to support FLOW_DIS_IS_FRAGMENT.

Here is the implementation of flow_rule_is_supp_control_flags for reference:

> /**
>  * flow_rule_is_supp_control_flags() - check for supported control flags
>  * @supp_flags: control flags supported by driver
>  * @ctrl_flags: control flags present in rule
>  * @extack: The netlink extended ACK for reporting errors.
>  *
>  * Return: true if only supported control flags are set, false otherwise.
>  */
> static inline bool flow_rule_is_supp_control_flags(const u32 supp_flags,
>                                                    const u32 ctrl_flags,
>                                                    struct netlink_ext_ack *extack)
> {
>         if (likely((ctrl_flags & ~supp_flags) == 0))
>                 return true;
> 
>         NL_SET_ERR_MSG_FMT_MOD(extack,
>                                "Unsupported match on control.flags %#x",
>                                ctrl_flags);
> 
>         return false;
> }
> 

This seems to me that it you accidentally passed FLOW_DIS_IS_FRAGMENT
when you meant FLOW_DIS_FIRST_FRAG??

I also think its a bit strange that you moved the placement of the check
instead of replacing in the same location as where the previous check was.


>  	}
>  
>  	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {

