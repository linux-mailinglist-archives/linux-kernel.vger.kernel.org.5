Return-Path: <linux-kernel+bounces-168232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4B68BB575
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052022874A0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E26F58AB9;
	Fri,  3 May 2024 21:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HriZBWD/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C9D537E9;
	Fri,  3 May 2024 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770954; cv=fail; b=ljhZdgCGrE02WGbUGR29Jz1zuawoHIb0NgGIeBHAzUkmdTd+pC16rFkvBFisNGEZy44z93VgwB3lLOsMX5kib69yVWHkZzfx61cnLcjtJ/tcVGwoj5i0TkbTpomV1u6II8r+3IH4/Erg4QTEGnZvwMe/oTL1V+ZbQJdksTMYPPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770954; c=relaxed/simple;
	bh=vpfzCkCZqY9A7tFcHxJ5Gk8GfhDKB8BMpoKCbvk38/I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k7rFdYINw1XOCwZqV3SVA1ejy7AyyxVGLuECUpAjec6WsnAsPOOeJHTERs9O/KjT15y8xGADJlHSdAwL4DEcyP0dcrZaJtomsqegwH4WKvnyg0q4rmT7sRldJ7+gUSIdMmPtEZQssThf2nBkbZ2x844bdcl5P53ax6c0R0Ot/+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HriZBWD/; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714770953; x=1746306953;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vpfzCkCZqY9A7tFcHxJ5Gk8GfhDKB8BMpoKCbvk38/I=;
  b=HriZBWD/69UVsL4+TElwdc41GfdlKVCWZ0lY5U1kvKDa5YXpX0oI1+pO
   ES2bGggO/iCyisiCZGWfNJcE6pQp998SzznoTzRJwPI8W76M20ouZ3vX/
   ETEolN3vAEbYCeqpAE0MQioIxMahiWMZN+o5C/ZR8o5ItaB+PGez5v3PS
   YRGF7+E+6HF56RKnNXq+ycl5XRLGt7OGoMVYHwIX3l03io4cGQD1vZ5L6
   huoJMNAMU3arDDMdud9jcnLqJsBw5ARIBKNew1HvAGSLdzpMBMUZl/yu5
   xQA5eveNx3A92n76xG/pqViyhpKkSEwdVMZ2oMrGMFkfJtWu9ixNObc7o
   Q==;
X-CSE-ConnectionGUID: I1Wn5CXjQQ+Vr9oasWcMjQ==
X-CSE-MsgGUID: I9U0zCx4RoynIK7IPKaEvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14409928"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="14409928"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 14:15:52 -0700
X-CSE-ConnectionGUID: yHSzfDDDQ4SiDqaAOdsmPQ==
X-CSE-MsgGUID: 4AMYY+Q8TseSZ+tDBEMzqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27592253"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 14:15:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 14:15:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 14:15:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 14:15:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnwSBVedlCVGG5AeJUWCNI8o54Y+54w3ZjvGistPQ+aBcFP1N87rRBv+Ojmff0GP+K/PUoaxNAGsTWUjXBvJxFszImycNVNFgoypUwmXO4oxA6Jn/IzLuieK/gILvPwOspneLH4iKcWRe1TcQWnm0rhQR5boc4ZXY05t3IWpQ77erj+IODU3OzVdeCjHfAKDjGe1X/7gAu5ZnQftaBXDiecnABwqvxbGZy394N5nHJlorYR30vs8UdT2tXPIOoEAdDN+Hj7LNhDzYUXtJtjqm+DR9SXVLeEvIk6HrlMgKyAmZFvQ+bwcGKFRB48SLkfvtHGhdMK0/bbHh6XyM17A9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkhFFNNFBpS8nPhFAISekCu8PhYcVQclOuWaHaibQ7o=;
 b=VRLLDby4qKF6gEFnVgUzWsa0KNMqE/DbxAjk5OGIAkiGp5XrEYV55DQeyXSi+woCMIlt2JklARNQLfgvKDyfDvlawt9xsDo22Ozv5C30aIbpa1ClmfF/h1gxoTEO3lS5GQLbRS+37zU85KDrVSTTmaSIDWIByT7CNbTgEV7CTkZSDOKMVzzsF6nLt4X+4RKf17pyTy2NHPlqKG/sAx8luZPHXiMz0zZtfHBfXxK4aWGlb7CnhCfaTXvfLLogrsJchy5BBu8T3QToQt+YoPjXmwohipXTxAiG0MZOi8YuHE+rtEF+RpxHUYfuRuvztyUIZ0mkpLfhNdzTaNeFx/Be/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6218.namprd11.prod.outlook.com (2603:10b6:208:3ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.31; Fri, 3 May
 2024 21:15:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 21:15:48 +0000
Message-ID: <98e06625-7e62-4614-969c-075462c2d27e@intel.com>
Date: Fri, 3 May 2024 14:15:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 17/17] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Dave Martin <Dave.Martin@arm.com>
CC: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <rdunlap@infradead.org>, <tj@kernel.org>,
	<peterz@infradead.org>, <yanjiewtw@gmail.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>
 <ZjO9hpuLz/jJYqvT@e133380.arm.com>
 <4875492c-13cd-4a77-a42f-243fe0f868a2@intel.com>
 <ZjT6b/nbZWjm0vw+@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZjT6b/nbZWjm0vw+@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b187458-725f-4cb6-5d6f-08dc6bb63416
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE96RjdGQTIxT3NlaWsxM25ydm5MbVp4eHVkWGtxN3dzRDdkYkl5Titzd1Fz?=
 =?utf-8?B?ZHRsWEVseWhmQjcxeDZpYUVMOXVQK3VWNTBmNDNMV2hMYzl4N2JYTlpndGJs?=
 =?utf-8?B?aTRQSm1mZFREN1ZFZEZKZDlralpUemZsVHV3bVdpN1hOb281SGE3aUxEQlAr?=
 =?utf-8?B?UTNOQUhjNWFSS3N4SGpyLzY5NUZNd1c3V2VLdU9QRDlzU0F6MzFtZDVZdTB6?=
 =?utf-8?B?RXFHbjN1T2U4bXl0RXRMeEJ3MThFSzFsUXVvekhxYXVXVWF5dldzWTF0NHRQ?=
 =?utf-8?B?aENTUTdGU0grNS8xcW92YlJMNDBoYWQ3TW5nd01FMVVsd3lybmE0Z3FxY3Vk?=
 =?utf-8?B?bjliSU9zZHVkakZGRWNuTlk1VW5mKzdhRXZoRFM5Zm5hbkxxbnVoeW16a1Fm?=
 =?utf-8?B?aUhpZEdhNnpRelFzT29sdFh1NTQ1MHYyM2ZPZDBLUXR3ZjM3SEMrTG13Zjdn?=
 =?utf-8?B?cEhQS29Eb1FrNGN6ODA2YUNTUllhVEtwSkVhVDk3ZlFDOTIya0F2NlFsMDZN?=
 =?utf-8?B?ekFxbm92bG1XTEtIWmJ5ZDZqeitTMUN6bjRDMFhYZGoxeTBEaVVmS0Y1MzZw?=
 =?utf-8?B?T2w2VVpGdVdQRE1vU1huUWZQV2UwZmlaZGRnSllsTUxjQy9paHRWOXFrQ2Jo?=
 =?utf-8?B?V2w1MW5VM2dUaWZhSGJRdCtUZkw3Rm11V3JMUm1vNkp1YzhTcUNxQ01wUU80?=
 =?utf-8?B?S01uMTRMZktOeXRxNG5ncHR6bGVGbmxaU2FnRUJQUVhHTE1kOVpQalNqcnh4?=
 =?utf-8?B?b3RtVmNaUktPT2UrRVhjcitwbGFORUVqcTVRclVTay9uUTQ5VG9vUXZHQWta?=
 =?utf-8?B?dHgyS01VejlJT0x1ZzIvK2RmRWJBbG1maDhQbXpkczhKOVBEeUFaWXVjalgv?=
 =?utf-8?B?S0hsUXFyaGRkRm9IY052bzhEWkVoaXB2T2Jhc0dGUGtKbnJHT3BuZ1FyZ29M?=
 =?utf-8?B?R0tyZC9GSkd6SkJsOXJ6S1VHM0tsNHZkYzd6SnpmNmFIT3FucFdlVHdxMTky?=
 =?utf-8?B?K0N4Z21LK3hwcDI4QjBOYzlvbzI2OG8xajMzUDVXWWllMWt2U2l3V25jRzJC?=
 =?utf-8?B?WmRud0M0cFR1ek00dUl5Mm45UGNHdHEzdFoxTnI5NG9jeEMrS1B1QXlveURH?=
 =?utf-8?B?ZlUwQ1hXU05YUDRyTG9sQ2Y5LzdNZkhlUUpoZ3JoUUozbG1wc1puVC9udG01?=
 =?utf-8?B?RkpPUlZXd1JlV0EzYjNqWmJEeVlsREhGZytGQzVDZ1UvVVRoZTFCQmgxUStT?=
 =?utf-8?B?MGhJRnBwZHpWR1UrVW9ML1hzZG1SNFlCbW9IRVpSSit4UU9zQ3VZVUF5cmgr?=
 =?utf-8?B?ZkxnVXdhaUQ5b1EybXF3UlhNN2I1S29iSkx2YngwWXAyRzJtcEltTUpSbTF4?=
 =?utf-8?B?V3B3am1MVzBQeXVDZ1U2Smh4R2FHQ1JHL21iZk81TThCb282SVBUSk1tNm1K?=
 =?utf-8?B?TUUvRnIxSFBralkybk1MWDV6bTZzQUt6MzJ6YXgrNWJPc2YrR3lQMlZoWUQy?=
 =?utf-8?B?UVk2dlRnb2RvNERCWEI1d1JTTlhYeW9ldmhlR29OT3N2Wjl0V0RPaUF4MWg1?=
 =?utf-8?B?c3lYcDlERWFjRDRxZitZbldIeERYQTc5VWh1N20yQS9VS0ZiU0lFaWtZMDdF?=
 =?utf-8?Q?XEXUh6IzLtwVgpDkg6esbAPKkD2tktr/Rvmf9/i2YeiI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGxueU8xdUp5SGJFV3RGUndRaVhqMGlKcHZiL1FTc3lBYVduZzBCelFuMCti?=
 =?utf-8?B?QVZtazkwbW5NOGhDOHhkZllCS3czcDBRSWlUZGNjeFgydk1XZmhtbXpoc2NS?=
 =?utf-8?B?RXNaYmp1S2V6NzNyaWJEcFNaZVV0bVF1QkZsd0JwWFVzUzRFYlRnTlVjZG1o?=
 =?utf-8?B?T0NqYWNHVU0zMU5oK0llNVpCUTdoNTVHelUrMysyNnVvcExDZ2dmdXljWHF2?=
 =?utf-8?B?elNYTjdxZU85VkUwb1RqS1hiVXpZU2x3OUhISXNnd093eVRKekNIVHk5NVJq?=
 =?utf-8?B?ZU5PWGY1WkptUy82VGtGR1NVaUQycXNXdlFLU3FYV3ZDWFpXWVdwMGVrYnph?=
 =?utf-8?B?ZW8wQm53eTBod1JtSDIxL0NXdHd4WEp2b3hYWm9Vc1piQ25YYWN1OGF4R0dK?=
 =?utf-8?B?Z0l1eHVSNlVnOVBlR0Q3Q2k4MnNQZE1yenF3eXorOEVWRmFaSE5uNlh2L0dr?=
 =?utf-8?B?WlpWUjdFdnF1NENTQWU3cm5ad3p3Yk41SXhpMjVrWHhJdHFhaEtpTE1YcDVG?=
 =?utf-8?B?S3JQcVZVWVM2bVprRExsa3luZEZRbFpiZjFWMzdrT2UwWmNxWGhqQ2hUaEVO?=
 =?utf-8?B?SFU4MFIwN2E0M1hBSEVoKzhrSXFIRCtXaGhtSE1qV09lMTRsSE5rTmd4Yks5?=
 =?utf-8?B?K0FFci9LWnlJQVFlYW1tQy8xT05hSUFKTEdYQy9WUHYwNjFxVytOZVZ2VFpF?=
 =?utf-8?B?a3h6M1NMSi9FemhScGlJRGJYNmR0dElBM3N5VXpDWG1PcG9EamRWcTA0WHpK?=
 =?utf-8?B?UzRiU2MrYkJ4aGR1dFduYkJVcEJlUEE1WDhwREhPV08zV0VzUVkzT1p6S2Ux?=
 =?utf-8?B?VFlOcVVxOVlCazUzVXB4S3VIYjQyRkwvV2lpcWtHOVdwTHNmU3dHb0VJaW1H?=
 =?utf-8?B?WVFxMnJyeHFmb1l1ekdBSmhPVmRMcDdiRjk4MzE5QzByK0lRcGE4MFBDYVgz?=
 =?utf-8?B?RDE2Y2sraWNVVjN0VDFBT3RKUE1qWGZubzBnbkdUWC9XcHArSStWZEwvNkd4?=
 =?utf-8?B?VGpWdFQyRlYxVGpVMnRpajM0M2lxZWFMYXBRZ0JhamtpKy9lY0d5bVUrZHBy?=
 =?utf-8?B?WEh0clEwdjJJaTZOSUxmRC9RRC9xL05ObUxYbWtXL2VxQks1aUgzM3ZWZmpP?=
 =?utf-8?B?aitTZ093K1dPZkhsb1M4aUhqRTVQanBZSDVLNFB3SHVyK3ZSVmVBUVBUMnBr?=
 =?utf-8?B?cTNYeUg2anA4UjBXWDhOdzFvdERwN2F4bmsyeTNEMUx4VXpYUm5YcUMxaGpT?=
 =?utf-8?B?dGdFT1dnRDhxL1BZME5HSjAvYWwrZXJSNk55NlUySXVpbmpqYzI5ZVhkWVVo?=
 =?utf-8?B?YkovNVN0QWJuRjVnUWZmNGxSc1ZCZUVZdFpiOTIzbUpZMU9aSStyWFVscE5C?=
 =?utf-8?B?bDI4UG4xQS9VZUI3TUFtTWRiYWdzcHFJTnhFaUJVTjRXbkt1R0tRZjdMZkpF?=
 =?utf-8?B?RDJCM0E4UGNWZWZ3Tnk5a0xNRkJPeWQwRmJLTHZXdkhDaythUGFqNTVSUk1h?=
 =?utf-8?B?dlZSVzltNWs1MXBqcHRkdm56VUtkRWtSSUpWcU1FK05oQ05tVk4wRzJRbnpH?=
 =?utf-8?B?TENudlFlMEpXUzQ3bVp4Mm04OHltS0JqMm4xeVFzMWN0S1VEaGtaT2NUOG4x?=
 =?utf-8?B?bW1kUm1aMWw4MWxVTEt1QWU3SkFmOWxBYitmZE1DQ0h6N2QvYUJaOHc4dnY5?=
 =?utf-8?B?TWdGOTZkdU9WZE05NnYyV1pVN0ptd2lMd29hckMzZ3pqREdBMmhnNjZVbXBV?=
 =?utf-8?B?NE91VnlkL0d2Ukl3dXhQWGpSajNDcHg4dDJTU0Z2STRsRHlaaCtTeVlMK3FC?=
 =?utf-8?B?VllZZ0lYYTc3TlpnS2FTa0hicW1LK0JQNitmUDFYaUlXTktLRTlHbVovaU9E?=
 =?utf-8?B?U0E3VVJkclhyVktZR29WSk5NaVFrUVhXUHpWTmxvMitmeDRFL0RHMVhrRmhJ?=
 =?utf-8?B?ODUvVDJqbTk3M0Jqdmg5UnNSVWoydVA1ZVZFR0o3S2Fvd0duaStVYXpPTGM0?=
 =?utf-8?B?b3Bwdlo5Rk1ZZVhRYXl0K1REWkFRdUxFYUE0dEt1MFArQnV4bWwya1NFMzNY?=
 =?utf-8?B?NDROY25WL3JkcDVmdG5ZWnRQYmkxTDUvaVV6MW13UFlKdXBITHpwbXZDNTlW?=
 =?utf-8?B?UHk1amFxRURnWHhuWHdlSmR5SUtJTU95UWJHcjhVWUpBMW9LL3FxN29oc25Q?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b187458-725f-4cb6-5d6f-08dc6bb63416
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 21:15:48.3055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgIGrd35vITmkfLouzy0s3kG07y+7jiw26ddb43pPyjroX/Gew+qL1TUOTWMODNWAN8b84+arYNl4AJvkuktuXr8iA/koxTAUQ/+Uy0k4J8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6218
X-OriginatorOrg: intel.com

Hi Dave,

On 5/3/2024 7:53 AM, Dave Martin wrote:
> On Thu, May 02, 2024 at 10:52:15AM -0700, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 5/2/2024 9:21 AM, Dave Martin wrote:
>>> On Thu, Mar 28, 2024 at 08:06:50PM -0500, Babu Moger wrote:
>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>> index 2d96565501ab..64ec70637c66 100644
>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>> @@ -328,6 +328,77 @@ with the following files:
>>>>  	 None of events are assigned on this mon group. This is a child
>>>>  	 monitor group of the non default control mon group.
>>>>  
>>>> +	Assignment state can be updated by writing to this interface.
>>>> +
>>>> +	NOTE: Assignment on one domain applied on all the domains. User can
>>>> +	pass one valid domain and assignment will be updated on all the
>>>> +	available domains.
>>>> +
>>>> +	Format is similar to the list format with addition of op-code for the
>>>> +	assignment operation.
>>>> +
>>>> +        * Default CTRL_MON group:
>>>> +                "//<domain_id><op-code><assignment_flags>"
>>>> +
>>>> +        * Non-default CTRL_MON group:
>>>> +                "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"
>>>> +
>>>> +        * Child MON group of default CTRL_MON group:
>>>> +                "/<MON group>/<domain_id><op-code><assignment_flags>"
>>>> +
>>>> +        * Child MON group of non-default CTRL_MON group:
>>>> +                "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"
>>>
>>> The final bullet seems to cover everything, if we allow <CTRL_MON group>
>>> and <MON group> to be independently empty strings to indicate the
>>> default control and/or monitoring group respectively.
>>>
>>> Would that be simpler than treating this as four separate cases?
>>>
>>> Also, will this go wrong if someone creates a resctrl group with '\n'
>>> (i.e., a newline character) in the name?
>>
>> There is a check for this in rdtgroup_mkdir().
> 
> Ah, right.  Found it.  I guess that works.
> 
> On a (sort of) related point, are there any concerns about namespace
> clashes in resctrlfs?  This looks like a potential issue for the resctrl
> top-level directory at least.
> 
> It's not clear to me how userspace can pick a name for a resctrl group
> that is guaranteed not to clash with the name of one of resctrl's own
> files in a future kernel.
> 
> (Note, this is nothing to do with series; I haven't been sure where to
> fit this into the dicsussion...)

It is not obvious to me what scenario you have in mind. Could you please
give an example?

> 
>>
>>>
>>>> +
>>>> +	Op-code can be one of the following:
>>>> +	::
>>>> +
>>>> +	 = Update the assignment to match the flags
>>>> +	 + Assign a new state
>>>> +	 - Unassign a new state
>>>> +	 _ Unassign all the states
>>>
>>> I can't remember whether I already asked this, but is "_" really
>>> needed here?
>>
>> Asked twice:
>> https://lore.kernel.org/lkml/ZiaRXrmDDjc194JI@e133380.arm.com/
>> https://lore.kernel.org/lkml/ZiervIprcwoApAqw@e133380.arm.com/
>>
>> Answered:
>> https://lore.kernel.org/lkml/4cd220cc-2e8e-4193-b01a-d3cd798c7118@amd.com/
>>
>> You seemed ok with answer then:
>> https://lore.kernel.org/lkml/ZiffF93HM8bE3qo7@e133380.arm.com/
> 
> There, I was asking about "_" meaning "no flags" in "=_".

Apologies. I did not notice the difference. Yes, I agree, "_" is
not expected to be an operator.

Reinette

