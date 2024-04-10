Return-Path: <linux-kernel+bounces-139388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D2E8A0265
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAAA5B21FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B48818410F;
	Wed, 10 Apr 2024 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKLZd50G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46E181D03
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712786071; cv=fail; b=Dxq+fPPM7UtJXzIaZrTgz/ykFbbDe9vdCCAuQ1jjJ4AwA9gxuPEQuhrAhgVgESOyTcTOUDqRD2tawdUUEwP5z6UNVSzavvZU5Uioqr1KGb+StDQ01PgPlYF90gy59ELX843AQCpe8kSVdH3OkNp6/DZ0UGpGG0R+ZKM4l2godk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712786071; c=relaxed/simple;
	bh=FzLesinh61PLQjbENOt1x79JztBfg6zcdlKrsM1Qe4c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GThY7bViVHjsk+nNAOJrRM9mdER09GoNlJL8NoL79ccTw6meSnGDGvjlH/2341FZzDz1GMePqZJLEQ7+a5zb1z+vqzCJGNhIFD159Pb7n7R004Re7JPUGNMW9Wqwuu+/4qdvWWkV+qrZLox1fDcGCYHMwI42vUNo7kt9NoqRjJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKLZd50G; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712786070; x=1744322070;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FzLesinh61PLQjbENOt1x79JztBfg6zcdlKrsM1Qe4c=;
  b=WKLZd50GWFAVrJlecDfHfKEnwjChfe3C8bYvn7W6EU481AvHJQ9Ej/08
   T0Prx54YB1vD/1em3UGio7stZVD0QRBYLBAQRAYDsRBhYKRIMfu3qYLWa
   9513NfoKJP8QZCX+8GEcw6PtHORN3rC+wdBdtGfQINR/MbBMrLFBFn88+
   oLbP5vBnxwybD6D+2M7PtVBvxJJLQKXIkBxf6YdjMoXbHhmXuoGZNlg/R
   ddVqbzWoK+Lmyyd4LwQSqFwa0wyhAeZn2egynTsP2Xl0RDY+xlQPRyibu
   UzmLoHn/7mmpqquobsuD3R0PkaOaV5O6LwCsNnfcXXaR2gUfjr9FlGjL1
   A==;
X-CSE-ConnectionGUID: fo0PIQQMRv6NFA9I7+G2gQ==
X-CSE-MsgGUID: 7Exx1Q3hRLSTIZ+LDLc72g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8397419"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8397419"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 14:54:29 -0700
X-CSE-ConnectionGUID: nB7yJfUDRLez/Ys/xmvCfw==
X-CSE-MsgGUID: P4q5aP4pROSM90Gi9x1lnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="20591373"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 14:54:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 14:54:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 14:54:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 14:54:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 14:54:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiJSVr9IdnxAcDLoItDrStZjAcj1BKm318m/OBhZGnysE7dmxFZQP8GwwC5kJw8s6+TIabgN1d+DoStrV18U0AoXoA8q998LDS6cV4SzfuobJ8Js2ftlbO8qLhB05hsrCESHs5Tw2PEnMq2CDfHc9BQL3PCCMmMKoQcO0DgD/pzS/Dha1KGNgoEa7vnHUO2/24M0Il+YtGc+ooKJ7E29tEvGcWjWijGYA/tsOWBxo9gqWeTmD4mNWHFKunce3HhVI2SumzuMvNXdpFBAGhjLJ0eUt8FbR4YGAOHSVriKdGQlzGoHP7PQp78pEojAlFRm5Ka3Ki3zOVlnV1YGu9Ip/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZrrmgnRR1igpw/N+TRG5prx/SNYYn8IcGqr0f22UiE=;
 b=VCfKJtEEDQ6psIQElQgw474SkcT8lirzhOtVEPa29JBf9xXdTRzKqgiSI1aa0HmKsM6FocPwL2mK6jwBDePQ/JxxN09iIfNkedYCJ5hnGcr1HAep/q8QV9CaCHbiT/ZARh6zKAlFBGEs4udQDoIeDzyBB47clGXJS5sVIustsOndCjONY1JBh5+XdjGtI1rTcstxUjMXd9SxFqCX4HFp/fwHND3+EejX/ZiSitkvSwjhNgJJ5nVCuYjQojbw0+qX6cnz6aSvY604IRDfk/zyO3Up4ascJQ2vC9TgRScr+ohfioLLHUg084zIGagWmfcIsL3DXE2UYOYbS/bKkLASgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by LV8PR11MB8723.namprd11.prod.outlook.com (2603:10b6:408:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 21:54:25 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 21:54:25 +0000
Message-ID: <4875349a-90e5-4a04-8a56-7d172b17e245@intel.com>
Date: Thu, 11 Apr 2024 09:54:13 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <dave.hansen@intel.com>,
	<bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <ashish.kalra@amd.com>, <chao.gao@intel.com>,
	<bhe@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>,
	<seanjc@google.com>
References: <cover.1712493366.git.kai.huang@intel.com>
 <33b985a8f4346f4bcf0944eaf37193a906b11af3.1712493366.git.kai.huang@intel.com>
 <a4o4wlaojm5am4hc5yhr2mpn7clm3sjy5vx3w76ahm52lhxvwr@msdcnkcj3i6k>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <a4o4wlaojm5am4hc5yhr2mpn7clm3sjy5vx3w76ahm52lhxvwr@msdcnkcj3i6k>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:303:6a::13) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|LV8PR11MB8723:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1itwPds1CyXIhzsMOCdbWpH90dj0S+whg6v5jQDZNlwadgTQG5LKjkxR6tLw1kp8kHU7QX/IPYZ7dUMDUB7L6fQNWW8zf1zfuFg7CJjz+RkOFEZmjlB7qv2R+iBC3RqHawljTRyH5J2Z8TXOK4JPpYKQ42CAH0WKTYhNk7IPT30HE0u67bx36E2YzIxH3rnrFuGl08QOJgjQdBf7uCZCx5wPEiUS67k0IYRVmmGHT5meZJ/r4McRRXpEEk0k/j8l3iJ5T4TT9j0yUgY0g1yFSLWOdgrcvylBV8Y6gKVKYBd9k4iAnoB179jUBiXYcOzXsRLoLVppsI8tM5F8FmlO7bJU9pfkUKe272ospFpAwC8dFQIlF07hJryzaYMTUTaJqMdTQ1UITntQmIIrBOOTIqWAQUwYjSjMkD+bTXbuct1/IxkRZLWIBcTJj1LQqB08jG4PNOhEuYmBpBD19QmFuHXAPVnkK7Eh9RuaVZ8PuaVUm6YvZbEP+7LmovXugKLTd5ltNcdZNsttrMec6va4zjfv0HnhDCJnS6f7VfsaL9V4Z0bJRd3FdymwRuHt5MoKqqgJiTwsXrZjQnrCXxFEWVoVY72HWs0uIXQ3dzyArMOvyj+enK9ubPWYkLVP5ceuwTdhLNda2jol2/tsp8cLKO1809Ly127/sM7ku5m6DA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2NGR0w5M2JPaDFzaThuZDQxS0lHdjNtTjZtcENuTUpsOWNoT1YyOThPWk16?=
 =?utf-8?B?NVd4NXU4WnZmelRYQ1hiSDlESzdpeldwZjRyREt5cG1sL3ZaMmlpNTZ1enVh?=
 =?utf-8?B?N29aa2FjaVNzcVEyOVRPTytFOVNjaE9xUzMxYkU1NjV5aVA3cDJZRWt3bTVl?=
 =?utf-8?B?dTV4WXQyRkxXLytTYXhKaGd5azB3Ky9HY29pdnRHZW9MMDN6M3lnMjZlYjJj?=
 =?utf-8?B?M25hTytqWUFkZTVrRjNCUXVYS05wOHpWbEtybWwxK29XZDZ4bTVUNGNnU0FS?=
 =?utf-8?B?U21OUmJmQVQ0WXVkbVdTYkRidjdhZHJqd2Z3U2s3aE5DSHNnVFNwWFdiYzhs?=
 =?utf-8?B?dXZRUDc4OVpraVVibUNYR1d1cjRYVzJNOWRXWjJPZVNpekpMTklVWlRwalZn?=
 =?utf-8?B?M3hBaGtodzBLTDFDYmROWFRWR2hnUk5hdFVIYURORWhUT3FYUlExSzNBcjFP?=
 =?utf-8?B?V2lvd29nUDNkZEJqbHJaM1R0a0JCaXVtT2ZKV1JKZ2VLSlk4RzFhbXZ1T0x3?=
 =?utf-8?B?bGgwWERKbUtISG83akd4R3NpeGZkaHcrU3lCTGEzY1ZzUGVCQWIwalQ4RjhZ?=
 =?utf-8?B?ZDFWdUZVNHc3VkxNM3F3Y28rb3B3N0ZSd0doa2d0S2xRSUxncjFNcVAzVEhq?=
 =?utf-8?B?bjRLZW5hbDA5eXlPSXlEZ25VZHpoNmdCb05oV0RmQ1dFUHkvSUdxaTB6bjA1?=
 =?utf-8?B?NDNWOXBDWmlzWmhwODRnc0pTcjVFZkJ4bFlkRkpJcWhkZ2M5cExtLzNWMjJD?=
 =?utf-8?B?Y1dkL0VqbnFoZTl0ZWd1c2lLdHA1RDZxK29iTjlkTEY5ZVljTzRXMWJQRjFR?=
 =?utf-8?B?Z05aVnh5eHYvRTlVc1pqRUsydzBqWXdsMUVJNE9qWjZRQ3FFcEE4VW1OeVZY?=
 =?utf-8?B?SjNtYWY0b2tBUWFSNmFzOHdBRHp0ejh5Z3Q2T0NURy8yUTlCdzNKYmpvUENy?=
 =?utf-8?B?VWh6WFp0V051bkxSV3IxUmN4RlVkbDJFa2dOelRFOW1RU3FhbUxqT0tNcFph?=
 =?utf-8?B?QjVoUisrUDhmL0pMaERuWHRmY3NESkE2dEVXQnpWRlp2YlNWbG9pV2lNVE1T?=
 =?utf-8?B?eXlMck8yYWpXbUNycmtWN2YyRmNLUytNdytFa1l4am5YNmFwaDNhRFh4YStX?=
 =?utf-8?B?VlNKT2NJcXJDN05DUzRqT0U4S0JZMWxkVXNTUElpVWpuSHJoY3BFQlpHTDRO?=
 =?utf-8?B?SndacEJ1UnVvZmVScklhcjVJcDZCc1B0YTVhbnVQMU5EVUNYMVFrcy90dzcv?=
 =?utf-8?B?bHJxRDBLUHVoYytLYXJ5aDFtUFo5QVdFeTFyZXBSUHBIbTNQNU40WjdHREdR?=
 =?utf-8?B?S1AwUFZnd0dxS3R5S3JOUFFkRXV1bzdLeDhkSTFCR2NBQkFVOGlFSHB5Q1d5?=
 =?utf-8?B?ckdET2F0Wnd5M0hFem55V0FKUUc3Zjk5dXJPSFJieWlnVUI3OWVmc01NRlhL?=
 =?utf-8?B?OWhid0pFcEYvQkVXbHdvV0doNi9SZ2Q5WEkzNDNYUzdJdDJZdHBRcUdIUU9m?=
 =?utf-8?B?SnJoaWo2b1g5Uld0cUlzSU5Sb0Q0TUgzVGRzQ0xXSHBXYTh5d1BNM01saGZF?=
 =?utf-8?B?WlJ1WnI3VUkxQ2dORXovZTByaXBydkJZZnJ0V2U4S3Y0ZEtVNXFPM1AzODJL?=
 =?utf-8?B?VFE4aktOWTFyS1h4aTNQaDJOVXlXb3hxdEtrODUrU0E4NE0xTERRRGE3NFFo?=
 =?utf-8?B?cHd6OU5VdzdyNUdNNEQ4NXhhTjFUdHRTWHIxNzFnRjZNSzBldWo5NDRDaUxU?=
 =?utf-8?B?Z0JwZmVsUFEwRCs4TnRDY2dRTjBTQ1Nta3pCRXgwdWRQRVdSdVVxaHNnRFlJ?=
 =?utf-8?B?Si93VmFXQ0tFeXorMTF0S2hjNnROTU5xNTBEVHVCZTNaVlNOUUxZY3Q3TElk?=
 =?utf-8?B?a2MxUWp1TGtxZERvUy9kTk9TekFrczl6d3gxVUFYWHUxcFdyYUMzb1JBU3Yr?=
 =?utf-8?B?MVFzd0NHRzhiYWxYaWFQVmZOcFEwa0JzWThWSlF4Vm0zTlg1WHNEOWlFdktq?=
 =?utf-8?B?cjNJK0UvR2pPSSs2eUI5NktaQ0R5aWpqMHhXSHlzRklwc2RJZWd4Q0xjSmoz?=
 =?utf-8?B?QktrcmV4VHJiVmNSUVBsZStlSWYvdm1IemNTN0JST0RVOFFwZTM0WHZMTksy?=
 =?utf-8?Q?mWHIffrCwQoeEm5XyYpzgThsT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abc864d-a7a4-4d1a-1767-08dc59a8c9ab
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:54:25.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Xh9PEwTaVnxVCyyestT2FU+WyLg4Wgfqh9u4ZxQX+t360mEp09UYqiqHYNX1FKS3rf0RPqdtpjKLbA/GOFz1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8723
X-OriginatorOrg: intel.com



On 11/04/2024 2:12 am, Kirill A. Shutemov wrote:
> On Mon, Apr 08, 2024 at 12:44:54AM +1200, Kai Huang wrote:
>> TL;DR:
> 
> The commit message is waaay too verbose for no good reason. You don't
> really need to repeat all the history around this code.

Could you be more specific?

I was following Boris's suggestion to summerize all the discussion 
around the "unconditional WBINVD" issue.

https://lore.kernel.org/linux-kernel/20240228110207.GCZd8Sr8mXHA2KTiLz@fat_crate.local/

I can try to improve if I can know specifically what should be trimmed down.

> 
>> ---
>>   arch/x86/kernel/process.c | 18 ++++++++----------
>>   1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>> index b8441147eb5e..5ba8a9c1e47a 100644
>> --- a/arch/x86/kernel/process.c
>> +++ b/arch/x86/kernel/process.c
>> @@ -813,18 +813,16 @@ void __noreturn stop_this_cpu(void *dummy)
>>   	mcheck_cpu_clear(c);
>>   
>>   	/*
>> -	 * Use wbinvd on processors that support SME. This provides support
>> -	 * for performing a successful kexec when going from SME inactive
>> -	 * to SME active (or vice-versa). The cache must be cleared so that
>> -	 * if there are entries with the same physical address, both with and
>> -	 * without the encryption bit, they don't race each other when flushed
>> -	 * and potentially end up with the wrong entry being committed to
>> -	 * memory.
>> +	 * The kernel could leave caches in incoherent state on SME/TDX
>> +	 * capable platforms.  Flush cache to avoid silent memory
>> +	 * corruption for these platforms.
>>   	 *
>> -	 * Test the CPUID bit directly because the machine might've cleared
>> -	 * X86_FEATURE_SME due to cmdline options.
>> +	 * stop_this_cpu() is not a fast path, just do unconditional
>> +	 * WBINVD for simplicity.  But only do WBINVD for bare-metal
>> +	 * as TDX guests and SEV-ES/SEV-SNP guests will get unexpected
>> +	 * (and unnecessary) #VE and may unable to handle.
> 
> s/#VE/exception/
> 
> On SEV it is #VC, not #VE.
> 

Thanks.  I think I'll use "exception (#VE or #VC)" which is clearer, as 
Tom typed in the comments to patch 2.

