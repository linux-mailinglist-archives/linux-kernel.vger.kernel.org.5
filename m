Return-Path: <linux-kernel+bounces-136190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2CE89D0F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2809D282439
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A3469DF4;
	Tue,  9 Apr 2024 03:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2MNttSS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2260260
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632747; cv=fail; b=St0fFiEkYQfEXwlQ+jI5Dyk4lXAvod2yK87k8KaHkylBgdK8xsMZmPAwSstTJgZcdHzAffORpGdYoi+UDC6RKs73kodI4f2kjBBaANI8wGKX6CcQNFo6UqugAYVHKsF8hgd/2XqUHUDKOghMUiOF4Eo/3VbDBD8Uv11F4In9WZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632747; c=relaxed/simple;
	bh=iSjp7JKt0PXY9luv4RhVa/NoGi7Lrt1a0GezNHImulM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kxm106wdvo5pSh8cFa2u092DwumnIDtO/GYELKzQrs05pGl3DsRJZpaHoQ89iZN/2CIDm1m2y6HxVAFvPgvcEPEY9SQPjQTmuEkD1LrRZ8gCvsAyNXIoc/TcUURiiMSOG5lLlBlu9+vYcebTaHL7m10ij6vBQY250zgcXZqncvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2MNttSS; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632747; x=1744168747;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iSjp7JKt0PXY9luv4RhVa/NoGi7Lrt1a0GezNHImulM=;
  b=m2MNttSS4M9zvdLdxp1OLtcHd04q7Zf/uNltemjqGQmS3deZa+tKaf2y
   w/5zgP442DgiiT5Pr1sRWNGgXfvmczRM04vSFspYmXYpwWvkWJVEniytv
   26vtYjBlkCtmGgPWa0NmkctW2ettkb6hRDaTREOdVsU7yy1w7HfcJ+ATm
   JqYZau0EJQQ4BCbVBN4SgMRWu+Y2l6Gz2NLSzYJIXPsAdq+IwE3gyZQcq
   KToeiYDkRwoEE0xIdRH2FSHqccTBdzRPNTDKeAjUKTwfj6+ZKt8fVjuXr
   mVnVFo6wYkTctdPYohAADcoxlDpXEzztkruHp3VMSNIc8ZcJlumxtR9B5
   A==;
X-CSE-ConnectionGUID: pUbczFKqReCCFzQp/N/49A==
X-CSE-MsgGUID: lAvpajN5RuWPZWws/UxJWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="25435954"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="25435954"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:19:06 -0700
X-CSE-ConnectionGUID: 5cQQY48YR6iNpVsnWR0sQw==
X-CSE-MsgGUID: 5VBmBOnZSs2WnhOlvq+Hwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24575984"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:19:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:19:05 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:19:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:19:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:19:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3RQ/uHVAIL4EVd1TCvKYMXx10faAyweG5CaPWX2lkT1+n0xKAbUWTe/U7MbzURxMU7/D9CK1Q26dKRo/z7i6zRHKIiSjVha9hLwmwbVE6YdTJ1Mgta+ukpoT6y5bTPqTJg6tCgzDKfSCsBqVQtSTtlTotxdFwXKVJd5gBbCZKit5fLiOGM+zO7b+rId30lrnqSoocT4lBJRzIYfoyt6j2/UOmTRw1t3CeliypFzvVD41IfUquHPaiF+yGlptnwT0UrT4k1szwTFPrUuKcH4m3AwK/QEn5TUQp9mwQD2QsIiBSnYUIRBhRNlJlDxmqqTutYlEQa1A7MT0+N16ZGIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQxmbfnKDoyLmj6vZ20eLLaPTKY9VXSbyv0hncvqNjU=;
 b=hkzMrGgGYyYjy3QE7EH5SFL2f8+4WbmdUK9pXCa7oKOtEp1//t/qifKWCM+k2NXTPeeRSCkUY38ctDUCsskZHcndIZ+ztVCURRdcF3VIFxHGxeJvU5yzBlJRz0Me3+h4wrA6kzdA/2U1pHM0/CvZv5GLFacLIHB6CBE03MT68at14z687TANcifcmL60Mqsjcit3ecZn2o0ncvIEWSPR4falRG2+4xL+kkpYKrmUwsi11a7nlNBIpDZohM5aIktwlbrri6RY6pdEiFI76pshACfttXmE0V6AhbeR1tgcKmh8q1MZpp7gpysUhQIEa0c3uI/3HQGCJvdvc5W+2fd6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:19:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:19:02 +0000
Message-ID: <92187846-374f-4b45-865e-543ba198b6b9@intel.com>
Date: Mon, 8 Apr 2024 20:19:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/31] x86/resctrl: Move monitor exit work to a restrl
 exit call
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-12-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-12-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:303:85::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFZAounO/5WmyH0bO2+omINsPFc8cdY83hDTYm644B8yULktMMDc7qx77iJDleDQ8jIA7Rvp2uajl1xNpFsU4E8PYHalayaBIrMCJjDi5w9QM6k+7/qDk8qYx31TQGSVHOitWqaFeqbNdTSSovviABE4dRi0m8QsJfapODoDHw/nGfXIA/L1lU9ujg4zuJrZHFz+YIWFfbgKwf/nnLlwFY9s99363bAI8qVX0wKiBiuW5Lw51xFyepwU95/H/N43czQjvYdUtRDyELQkWii4U+UDCks/bLyBahkX2rQQEA3PGMVUb15Rv4ClNgT+CSelibJa8d4gNvK77nW+P8JGHenHRg6xZt21ezXeGck0rTEEDMOXVKEzOaz5TtjkdEvfru3P5HGgxSnRARPGSLABMt0xkVc3//Tqpt2tcwu3yUQRcy5lQf3CnhK9VVkGGTPZUNqJzIQ5obgRFkefgjc6/dVz0Lu1+QKDWm7DfN4yjf1YMPW2Sfj9/JOgD6hxeBJM1no8WN4OE9Bd3OblB7F7nvH5KxBQN5GxziglT/x/1iFKnCYsvW006DcM7Qf4NJJD2+t5zWoSMX4iHuvlP9hFnyfqMc26QzJSh0LS+v6326k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dERFTFJkeitmTmRIcU9OOHBRK2tkMENkWmxqT3dMLzBrTDkwYmQ0VlpoODhQ?=
 =?utf-8?B?NVEwa0w3cG5Yd29QVWlobG05MFQ4andLU1E3ZThHcjlXazlnd0dNVTIrS0R3?=
 =?utf-8?B?TC9VRlFTbjhKYnBuY0FYZ1A5V01UeE9iRUljODdGcGNPVGtnVXV1Wi9uRlFp?=
 =?utf-8?B?dW5scENndVZzTktxdGo5UjhETGkvTTl3OEY0QnFDUTBDYy96bVRDUm5UWm52?=
 =?utf-8?B?cXdPcTdsNkRqN0E5aS9jVFdxT1oyVGUwR2J2a1pXd3k2QXY2UUs5Tm44R1Jp?=
 =?utf-8?B?M0ZRNWNkVjBpOUdGSGt6UUxqQVhQL0tkL2Q4dlliMWppRWxhdER4SWpPZWdv?=
 =?utf-8?B?T0J1Y0xzeG1OK3U4M21wUTRqSnk4Vk55ZmpyQ0V1TmVYeXZNaHFndnhNZElN?=
 =?utf-8?B?ZzhMck4wMGdIUGRyM3N2OGxMaVkwUDlyMnFsU3Qvb0QvdlJiQU1qa2paelJU?=
 =?utf-8?B?UVJpUnRXTmh6Wi8reXJ1WVhnQ2xLWlY0b2IzbFRUdkhoNlgvaW95Ymwyb2da?=
 =?utf-8?B?MHd5Mko5ZEVMb2RpamFsSmduVGhBZUVhZmNnblA3bktoMG41dW9NL2hsWmpm?=
 =?utf-8?B?WUlOemF6TG1JNFNqaVd1S1U3WlFaNDJ0T00wY2cxejIrZ1AyeTZlZmpCMEU2?=
 =?utf-8?B?VnhvZGxJSjIySlpqbWFTdWhMbzl1NDd2eVJIYnJ1VEFJdnVVZGhOendZVXd5?=
 =?utf-8?B?aW5vQXFlRmJ0V3ZJS1dFbWRSQWwyYUdHWlpzeHpTajdYRGVqRHNsMnJEZmZL?=
 =?utf-8?B?ZXJhNEhjUEhxT0FadlRZR1pDOWs2bXE0QVRMeGVLMm1jNnBSTWUwUk91U29o?=
 =?utf-8?B?SVRXak5zaS9mRlpYekNJVEd6OUFPcTNzYjJ6Y2RWMTlZcmdSZkJ1cTRmQ1Iy?=
 =?utf-8?B?VmUxcEhWTEwvOWZwRUVQUnN2WTIzdDg2ZEx0bG1rbjEzdlNZY2xMVG82ZzdQ?=
 =?utf-8?B?OTUwbEhraXJzUUllZkt0OFBIUGdTeU5OWFdCcXpJTVdidHcvMDdLVUZncTJl?=
 =?utf-8?B?emFldXJJUjlYR2Z2NjdSQVZ3OCtQblFsWEl2aGh3cUpXWi9zRDhnaDhQM3A0?=
 =?utf-8?B?L2RGdHJ4endWYzFzZ0N5M1l5Y1hFUTgxcEVZVlZkVFExb3VWV2l3ZWVxbndP?=
 =?utf-8?B?SmIyU0JTajlldkRDeWRyNGhQa2RjVU56OGpBM2pHYjV1bGdpM293aEx2TnJE?=
 =?utf-8?B?VEREamVqYTJQRjltVWpHczNET3BqOVYydDlTNk4vMVNvM3k4V0NNRTdiaWxl?=
 =?utf-8?B?UzBMc1B0Ry9TYU5NWGMwZjZUYnFHSGFpeEVINkIwMmZmLzFjNDhudDNMckVu?=
 =?utf-8?B?V3FtMFoydllZbW1YZ2swMDY0UWE4RWpaNVJwZDhtVnR6Y3ZteUdING40dFFt?=
 =?utf-8?B?ZXVrMjZSMzNSelRGSDllaStIMk41UkZONC9nd3hMM3R6L05iYTRQR01yU0No?=
 =?utf-8?B?bzV3eTEwa21DaDhOWDlKOHlQd0JPYmxkMFpmMWl3UTE2UEVvTHpFQTNxZEtp?=
 =?utf-8?B?cUVmVGI4d0Y5d3krS3d6LzlZR3R4d1dKTDRtbEhGamlvNmMxY21UT2hDMFVh?=
 =?utf-8?B?ODdKZnFpcm9RTjhtcVVQdlQ5THZaVUc3ZDlLYmIwcE1VMlcyTTJOQ1NtcXIy?=
 =?utf-8?B?TFJuRjBKNEZpWkZoV2Q1WnFzNHNSTEd4SHhWVmdOaEpjS3UrWk1FYW4rSDF4?=
 =?utf-8?B?UzUweW11M3dXUks4NXdpVTdvSXNQVDlxZEo1cEQxWVB1VEROamtlZ2NPeWQy?=
 =?utf-8?B?MXJpQVBFSExSWi8yeHhBWmhnM05MaGZwQmJuNHpnL1ppYzF1aVZRbjJVeGNj?=
 =?utf-8?B?eldybnFRelpaUTNuMGx3RU91Ukd0YzlYZkVxK2FYVjZWZlIrUHovL2Z5UDJH?=
 =?utf-8?B?NmdDT1MzS3hJbTBUQ1RBYVAzWWZtLzE3cWcxL1llVWhWc3lvTkx5YUR0NUV4?=
 =?utf-8?B?S2p1RXhMN0FZTW8yZ3ZsUGxHbHA1YzcwUXI0ZHBqK0RlMmlXK3BkVVBJZ25X?=
 =?utf-8?B?bnBrekRpMGQrVk52cVcvVWN3azhEYkQ5c3V5ZktxQW5jR2FGZlhKSkd5d2Zy?=
 =?utf-8?B?eGU4V29OUGtGS3Byd3FhTXFGcW10WldUenp5Yjg2Vm5lZW14L0hXMkNxWG5y?=
 =?utf-8?B?U2F5U0ZrRHdwbVcycitKV25rQVlDaFFWRlhTUGZ6ZHNGTWVVOW9VR3NySUZI?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf36d589-e278-48df-2b9f-08dc5843ce4f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:19:02.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzyZmjC33OtEskt0gV3QNL06PzlzIgqH1pyM4dZsP1sop0fB8kYmHWaw7/St0zth+d1Aw2FLbA/95f08JHxcmqVteyVeJpNlp41spDgBjYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> rdt_put_mon_l3_config() is called via the architecture's
> resctrl_arch_exit() call, and appears to free the rmid_ptrs[]
> and closid_num_dirty_rmid[] arrays. In reality this code is marked
> __exit, and is removed by the linker as resctl can't be built

resctl -> resctrl

> as a module.
> 
> MPAM can make use of this code from its error interrupt handler,
> a later patch drops all the __init/__exit annotations.

Reminder:
https://lore.kernel.org/lkml/85f8756a-23a0-444e-b37d-a7817b600f46@intel.com/

Reinette

