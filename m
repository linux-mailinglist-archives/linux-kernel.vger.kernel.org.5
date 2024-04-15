Return-Path: <linux-kernel+bounces-144493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4648A470C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552211C20E63
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7D61798F;
	Mon, 15 Apr 2024 02:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/0K82Bn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B4F1401F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713148795; cv=fail; b=Ecpr5QJg8CV+c4zBZ7LxGtXrgf54AcB3t38vX8uRp2hs4R5LlUaqPnQFCk9eRh2O1YeqBxkpzYQyYejNzOegzFMKxkNmLY0Y9P8bRCV5kqZdSgx527ZwM+P4W4K/SwbOOcGo9CbINAEdUFGr9vcMCchxarjpAYK5OqZ2ze9x9HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713148795; c=relaxed/simple;
	bh=xSpwQ3EqbKaSulEX2vg91qU9uUhU/ZKq7w6bTQRABKQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ijlPphyIM59cV5Vc6vB2Nc0lwkBfEkk5k0bRbABcrdWq5aPocGWqCASVQdhw4FIZwiuQ1AUj6wvN4KXKCu2Qv64Fbiv3DfuzdFEGzmtnwaDOv9tnxuLqaZaXtAr0BbVS5XsR6kRZ3Y9wjtGZE4kgsTCxbh4Mgit5iEm8s67qxyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/0K82Bn; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713148793; x=1744684793;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xSpwQ3EqbKaSulEX2vg91qU9uUhU/ZKq7w6bTQRABKQ=;
  b=G/0K82BnbQ3vWDUjr/fqWB1McZuHbu30JM6wKoNPkigxh0JngZyChL/K
   1kniluI1JnvTs7lR0/pbbBzpIx2hXHxYVq9VG5tnUobZzkf53dLVPkunR
   mxwzECPHRoOsTd7iM/+XOrNRGkPFsszrijh9mfQH/cgIdFvvlI9nDgRC6
   52kg5ZX0B+jYTzwkKMnN2UbklUZEKodm/g2vbwKYFwn8FP83nSUwEyIdq
   ygxw8MyMIp1PJ5hGtPCsgG2tp0g3ZgOEMu8IcLac/4E9NKNsGZXlhBlEp
   jvqeZJg4+kPIOQJipsKpCT/6Z5SS7XVVmM3+qPlVlR7c6gqFnpElSI2MG
   w==;
X-CSE-ConnectionGUID: EqsX56TOTLKTOapyaQtAkQ==
X-CSE-MsgGUID: 9DtRwuCvR8S+DHXE5ZAZKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8376823"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8376823"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 19:39:53 -0700
X-CSE-ConnectionGUID: BjV0rdubQByU5UbQ+18ARw==
X-CSE-MsgGUID: NuBPKVw+RISq7mK4EOkyEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="52963414"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Apr 2024 19:39:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 19:39:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 19:39:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Apr 2024 19:39:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Apr 2024 19:39:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR1wK+DdnKWlc08ywgkJnleQHnlDwj/8yJ7Nkqxtzt02JLE82BG7/hZXK9EgU1irwbc4ElOxSJ7qyTtIRYReNyP6MFE6xxKoIC+xROWwUbGh37oVKAUWhSQVAI5FSJSajNSEbHxb6LgNBOs5ElyF2PM7BnM/vHW+NX6Oqv2FdXVL9PXwp1w/g08leIxyplQBnIMCrDRXfP/GD3oj1akcc2SjnmMlJuL1J3+wYse5mCJqCzUs4McF4we1wz4yr0hwjrStRkc4bU4aFcCr/YhzNidqQdkV6hNN/nYGi9n/NHsUqrG5Nr3WVS/ptCuAAwCKFjFlusdEGxNxn3cw9a/imQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/3CE/++RLhp3FggGbv/yEd89vbub3gqBl+91Bfoolk=;
 b=cin8dZJ76D3CKpIv2d2ohuKRjMPaR23rTLihPcvkYq2AO+NHehE7lnNNy0z5kP48R+lOSZ2s0VSOgY8ev55qCIPC8uW3PVfCsadTKKtznLVxBjhtxpEgWGrT3iSVTXKWNwVv5mINc/niTS2dQ2tFrPUbh0a+fT2Bk2B38LYWYSO8pOz2uBwFg0P53XsKv9AUSFpxJi7GD+BFD760nG6SuMMT5r7q0QPZbQdas54RWRtlkWpH08VuCne/gPVOVkZFWPzYpR5kvxtl5T7X2RTDrAMJVwqnE0705yVdHJqOiBlSBc+62Lp0YdMd5mt4pOPep0Sr0mvp5m5m6ZO3pKBKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Mon, 15 Apr
 2024 02:39:49 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 02:39:49 +0000
Message-ID: <f3502244-5f37-4f44-94a5-39939ba20eec@intel.com>
Date: Mon, 15 Apr 2024 10:43:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
Content-Language: en-US
To: "Zhang, Tina" <tina.zhang@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "Tian, Kevin" <kevin.tian@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240415013835.9527-1-baolu.lu@linux.intel.com>
 <MW5PR11MB58818970CB8E9A37A6AF563889092@MW5PR11MB5881.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <MW5PR11MB58818970CB8E9A37A6AF563889092@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0ce4a5-78af-4aa0-3ac4-08dc5cf551e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pwj/HuiA16Tg5jPYKvE0j2bv/Awqx5sc9SEghadi8py4yDjLvpZVpqCCAkeBRPW3wpRwLM7dfcCWOTC9AgT6wGFmJYB5buGUfO/5+S0HuyH7W3p7Y7/xsICk/FnQW/CSLheKhSpshz7Ehoal9lpqJCUJeymusJ4AJXxCogvjvQQ9ImRCFyEIlqXgQSN0YPhCXFIzwAzXdFtyfxgL6y8PQJkHhSZVSPWmmleeNcLCcq/fbyWRUmBSCC27YHvlKpr+NyTnRNgvMN0RauE82nZqQXKpsnDdwav0Sxbvhyie7WT0L6502cETlT5HmFcpJez3WUJYsHbUel+FUdBFpS1HDFIKJkp/hY1OIal+n1tw6dNgTYEnQe+vGCecvMskiSnFEx0h05dSUUJFY3ZCHdbBdJ90KeFBTnZO2jI7vBzmysnrWZrP+KkrpNUqIkzTmwPli18T0l1OnUzWxukSiXmRFk7kG01/adhQBK8LGKDSJlDoQ1hLff1rTFXzkWardFAEKuZR7PXttXwsKfnTvDkWApTy1MU9a5R+p7y2VCcTxOqxAzqIkKpw7ceeL7qmjR2ukdfIqSJPSM8Px53PML3W1wILE1tlWF/aL70czwkTD1vr3ItUvHwp6z/vHsA4z8yrlSYt6PECC52RoEGqBLraGEcpdfWbXZZ5boF21QDpUTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGNGS2pselpVRFR3MytNaHN2MW9md1dzaWNOaHNvbStvTW9raFRMYkgxMGEy?=
 =?utf-8?B?RDBhbTZCZVdzT0F0akZxQWxabWxhVmI5S0pleDd0L2x4Y29hVzR1UEZRY1dO?=
 =?utf-8?B?UWlrZTQwdmRlSEhpaGhOSTluRkVHN3BrT01JTE1QODd1dHdpZjZIMnpzdnFn?=
 =?utf-8?B?ajRWejhhUGtOTEdiYjFKOS85eTRDVEQ4MVRIOE1ESjJsclJKWTZVLzdER3Yr?=
 =?utf-8?B?RC93bUZTUlVhMmxZLzVjL3pNL0hFbkx3LzEwR3N4cGNGcUlWQ1BiU0NDWGcz?=
 =?utf-8?B?aTN5L01pTFhSR1ppeGd1NDB1UnV6d2VJQlJLVG51MWwzZVMrbndtcW5PUEgx?=
 =?utf-8?B?TjBMNVFCbE5NZTRFekVSdXZoWEhrc2lLbUxnb3pKbkpOVGNiNDQvMWplZU9P?=
 =?utf-8?B?Mmk1YTE5cC9NR0VHd3RYdUVod25GdzlsTFBHQUZPU1BxbXhBVWx5RG5vVWxl?=
 =?utf-8?B?eWdDaEhxanNGU29qU2NWRm1EZ3o3LzNSczdiOTlGbkFyTnlRYTN0RGQ2UkhC?=
 =?utf-8?B?b3k4a1I3SXpFSEF3UEFhT1NtMWFOVWQ2UjlUaFFKV0tlM285emR6TldoejA1?=
 =?utf-8?B?LzB2elRzY0ZMT3pBWmtVMVdBTVZGcm1jR2tBZXZMRzlHdEwwM2ZVNEVFQVZz?=
 =?utf-8?B?VkcyVXE0dEU2QkdQUk94SFdaa0NiNTJnRXFxSjRoTHZRNDJUV0I1cDJkVUpK?=
 =?utf-8?B?bTRiUk1PaExXNEpFV3ViYTBIYlJIeHc2eUpHenlRbFFURjBJa1FmMjkxbTFr?=
 =?utf-8?B?UHN5MXliRXpJWVg3L2VHeVh3K0tZcWgvQjJQVHJEc0J5eFZTN0RRQW1Rdk5D?=
 =?utf-8?B?aHBWVGJiOEdiZlhLUVU1MHJTSWljRUFGczhwc05WcnNxdEV0ZEN4T1FVdm0r?=
 =?utf-8?B?Y3RubG56VjVJQTJ0ME93TTZWR1U3cE5SK0xzTE9VUm4zYmF0UDVicU9rMUxH?=
 =?utf-8?B?N0o2UGtuSGoxSDJRb0VPL2lGZWJuRmcwRGo4NkNTTTMwb1ROb1lhbUxJRkNR?=
 =?utf-8?B?c29INWpsMktVUWNYSXpzWWVVZnUzeVNNUWdBVWpqSnpjeUd5VzJTZVZlSXhC?=
 =?utf-8?B?bkp5ODJSVmdXOFY4UW11bi9xMnkyVTJGeTM3Znh5d09hcTBTbHAyVjBIL1Uv?=
 =?utf-8?B?a2ovTzdVMXh0Z3JEYk04bkhHclVyTkxKMFNPTjVMNTV1ZXpnZEYrLzVyU0Fp?=
 =?utf-8?B?eUpyWjhuejRZUVpMT3ZiR2lXRytXREhiZG1oVzB2bFAzeXNGVGZURTIxN1gv?=
 =?utf-8?B?bzVaZFhLT3NlekRzeHVTSHJvQXVROE9LQ2ZvR1JxbkJQekx2S01vaVBycURL?=
 =?utf-8?B?UVlJVnNoMk5ZSDNFUWYxMHhzRjE5NVpGTTY5TEc2c2RWWnozSWprK2ZlN3M0?=
 =?utf-8?B?bFlrUWRjWmV0My9QQWdxbFBBV21LKy9zS25NeS92eVpLazAwZXk0LzA2T0xm?=
 =?utf-8?B?TXRJUlF1a3R6YjdtK2dwbVBFbzVkNkFySGZqRmh0Qkhkd3lDeG1nWFA5bjU4?=
 =?utf-8?B?ZEdDRmwwVXBVYzhKM2YvOFpGUzB5QkE1NVdobWQwTk13MHpxNjd1K2dVdkNk?=
 =?utf-8?B?YTM4ei9mMzJjTVFRbWdjOHh0MmlCYmdZc2ZVSmFpT2dsSjMzNGY4bzNIaDFW?=
 =?utf-8?B?QXpPeHJ6NFo5S1UyNVZmRXFHMkU3WDdReWlwaStjSVFlbS95UUhhOEFjOG04?=
 =?utf-8?B?aEovMHBtNlZKMGRnYzZtd0srQ3pOUlBsSDdXZGRUR25abDNyZTQxbDVaUnRu?=
 =?utf-8?B?ejR4YU5IVzJGQVRnNitPZTd5TWlyc0JNM1E5QVMxR25CLzFjYktEQW4rYmI4?=
 =?utf-8?B?Z2t5UytmRFVaR3R4Ylg0eUxEUVV4Q29mNG1Kby96ckEzSDQyQ2IxcWZDV0cr?=
 =?utf-8?B?MWxFLy8vSWk0RVBjeHl1SU9UZzZScFBuYkViWWU1TStTMXlJVXlOMHQ5bkFj?=
 =?utf-8?B?b0VlNVArdGo4WHdpVWFaeDMvYnJXcEp4ZU9Wd2h4UGtPcytIc0xuYVpXdnky?=
 =?utf-8?B?b1VsTzFOU2hNa2gvekV6U2xwQ21PbXphdk1LcGNNYzR3YkNsTmhUOWlRVEYy?=
 =?utf-8?B?MnMzZ1hlYkVQL3o3blpqVS93cEV2Y3hQZTlQV1JadVZScXRvNkV1cGxSbEpp?=
 =?utf-8?Q?GAmpaG0LVWaJngyQCh94n8g1T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0ce4a5-78af-4aa0-3ac4-08dc5cf551e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:39:49.3819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cW8KD/jcd38gTkNwGsOoa45nympeaL9hJPTVaJSZ/7pN/IuvweSbSpah3piDTYnOIvY7lHXT5r9WpCZzRtJrCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5160
X-OriginatorOrg: intel.com

On 2024/4/15 10:22, Zhang, Tina wrote:
> 
> 
>> -----Original Message-----
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, April 15, 2024 9:39 AM
>> To: iommu@lists.linux.dev
>> Cc: Tian, Kevin <kevin.tian@intel.com>; Liu, Yi L <yi.l.liu@intel.com>; Jacob
>> Pan <jacob.jun.pan@linux.intel.com>; Joerg Roedel <joro@8bytes.org>; Will
>> Deacon <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>; linux-
>> kernel@vger.kernel.org; Lu Baolu <baolu.lu@linux.intel.com>
>> Subject: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
>> device TLB flush
>>
>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>> implementation caches not-present or erroneous translation-structure entries
>> except for the first-stage translation. The caching mode is irrelevant to the
>> device TLB, therefore there is no need to check it before a device TLB
>> invalidation operation.
>>
>> Remove two caching mode checks before device TLB invalidation in the driver.
>> The removal of these checks doesn't change the driver's behavior in critical
>> map/unmap paths. Hence, there is no functionality or performance impact,
>> especially since commit <29b32839725f> ("iommu/vt-d:
>> Do not use flush-queue when caching-mode is on") has already disabled
>> flush-queue for caching mode. Therefore, caching mode will never call
>> intel_flush_iotlb_all().
> The current logic is if the caching mode is being used and a domain isn't using first level I/O page table, then flush-queue won't be used. Otherwise, the flush-queue can be enabled.
> See https://github.com/torvalds/linux/commit/257ec29074
> 
> In other words, if the caching mode is being used and a domain is using first level I/O page table, the flush-queue can be used for this domain to flush iotlb. Could the code change in this patch bring any performance impact to this case?

This seems to have performance deduction in the nested translation case.
The iommufd nested support bas been merged in 6.8, while the Qemu side
is wip. So this performance deduction does not happen until Qemu is
done. Should this also be considered as a performance regression? TBH.
I doubt if it should be.

-- 
Regards,
Yi Liu

