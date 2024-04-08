Return-Path: <linux-kernel+bounces-134988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EACAB89B9A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A075028105A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0F42E407;
	Mon,  8 Apr 2024 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EU5MHYlA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C333CC2;
	Mon,  8 Apr 2024 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563361; cv=fail; b=HgoBCgHyLHq9s/JHyTG07l8KBtUX8r9TZbdQaTJnkpv9kjy49aH5lnTtb6d6cmDzp/ljcQjlmRBcJTxlccJgxs5EKJElbRTOILXA8vL0iQTMsk3JPzT5mqzf5Gs31lI1S+YJl+sHM1m+v79rnqCdzFHPFarF6XPDepcxNGQlPCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563361; c=relaxed/simple;
	bh=QzeBSzgCYsPtUBGYEJqsISqGTJbsbbV1hR/dlSijN4g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ha7G8LDAzPN3BZJvAzWiuPOkidTEoI7yfm+Mcd9J6Bm+nfVAAC9j9DIpA0IxFMht+4ODFoj7fzn2FnruxkS/9ifrHNg3vjm+Ac25Y/eUYIfeP9CmknBPQLbPCnCRQjo8hz3122SNAnqfYe/p0AMaqj8S4X6UKOJgSVG8fMAQngM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EU5MHYlA; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712563359; x=1744099359;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QzeBSzgCYsPtUBGYEJqsISqGTJbsbbV1hR/dlSijN4g=;
  b=EU5MHYlAx7669AWq4kaKEmFw4UsBL2/y2JaGhysTEfD8HDp5SPFZeERG
   UL2i79XoXbipmDuZVOIaEVHREydqrv7zKN27uAGXwmXHzjKntdKC2q6/I
   QmiKEIVRFkrY020C2fhCF8KHBbLaoIR0S9D4w9/S00acZ3dCw5X8ATejQ
   a3WaKDzYOxBvYBLD4esqgMXKs9nZ4g/poQzrddaKgRlodd1nqAOP9UQNb
   uj5qLXdwzZG8p9a45lqxtbzJItiYQqoH6KsEQDPFhDckzTuKmjZ4Q0UR9
   D4xSVL10TgFQW9MDOF/HOZ3uu7XEvbxNvBmZ5plXc9XZxuUpi7LI5jbLx
   g==;
X-CSE-ConnectionGUID: FpZuhD12SXK3neq7Ey8Dfg==
X-CSE-MsgGUID: sLvq70SKQamXvkf7ZEZAkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="8053596"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="8053596"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 01:02:38 -0700
X-CSE-ConnectionGUID: hraJqASTQumRcG/31aY/WQ==
X-CSE-MsgGUID: JtXAZMarSgWlodbP/HvG7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="20371534"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 01:02:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 01:02:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 01:02:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 01:02:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8GklWf5ICtFXTn6c51XbAjEy+uDAUaLhbot/971Rlcwq8AIGAPqWwHH78c4K/J48no6ZDJ+glOB3RN8arqDPfcO+UOGpnd3iN2KtXC7EwchYFWZ+FH1lVi9z2Pp73HtyPEsnNqRJ4FJEYwaTyUbwesPqGedMRgjbARQfMWYpX4l7cjy4X8GYlOPzHgOCT7g4GkWNpay/nd3IPq8ku/OJkmgYcaxzeoyUm7xmvE1qfgJcq/jN3vsGCunPGkiPYb4ns3wSSDoj0Qe+cz0Cyge7bt3oulxD3RUm0RkBtS0FyAdoJDPLQ6WUmPtQeKcDh3VSbfucsWF8BoR1SY5dz0YKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJcUFAq9EuYxhNSwsSTGvWZp7B5eoNi/05M0BstbMi4=;
 b=UhFkp3w+o36sG+WqRb0eEbBcAzofG8mbqWGvYPVWlYUH+mWFCEqnn9h9hqrUYE5iU/DYNayFMDrqTtkWad71Icv4KTVcjGtxVPnA21hZGdublNthGiJEeD+DxAXkhBfSq/XfBwDxuxq+d7+7NMWEcWiDjY1OxAs8KdpzKi29FE3KRQ2E4csC/W4cr4vLkkxPuoGR7qQl2s6CsNX+WzZ1QZCeWVw+O+aztspBhEez9h1x50FJ0JtrS+nZawxZZ9HoFEXtKUG3CfiaFakAOTasxW2H1CwdCBLd5wqQnxjnON1/IIUNjBIePL9HwpY1ES4xPZdKgOazKAZ0oE1wUgUaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BL1PR11MB5224.namprd11.prod.outlook.com (2603:10b6:208:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 08:02:35 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf%5]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 08:02:35 +0000
Message-ID: <8177c5c1-ef0d-40c8-b1b9-d018bede732f@intel.com>
Date: Mon, 8 Apr 2024 10:02:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
To: Leon Romanovsky <leon@kernel.org>, Edward Cree <ecree.xilinx@gmail.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David
 Ahern" <dsahern@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
	<lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Aron Silverton <aron.silverton@oracle.com>,
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cefa2b9a-4227-969e-d31e-c19a552b9c1c@gmail.com>
 <20240403190012.GV11187@unreal>
 <d75ee9d5-36a9-4056-a0f3-0c05b2e744aa@kernel.org>
 <20240403170149.7d2b8f2b@kernel.org> <20240404122338.GI1723999@nvidia.com>
 <20240404074850.19ecd52e@kernel.org> <20240404174728.GL1723999@nvidia.com>
 <d0b11055-1804-515b-7916-cb83a6274955@gmail.com>
 <20240404183540.GX11187@unreal>
 <d09cc7f0-3e2c-f22d-51ce-43a36412425b@gmail.com>
 <20240405104140.GZ11187@unreal>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240405104140.GZ11187@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR03CA0087.eurprd03.prod.outlook.com
 (2603:10a6:10:72::28) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BL1PR11MB5224:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMa7tzRYJUkn44Si8PJzkcFfXKuAalx8JAXASrL2j1TxqQx0JTC6cnvs7IaaBLUWojilAjILe6ZetxC2XrT1RhBffe8NiliOWSrItNdKrY8ZzHLXJSANxuj6xecGkneCbhIJopn1bfuEUaA096MVIXXg0kpwlRAnyXyslq1wTbug/ipOFAmOfIgIQKN9xhRlIpvcVwAXBqCIEQYbY95QUPmxlWGmpjZjHuKOPg2CcW+9DhL79e0ZidaH6jbiQWNnJtO5i48kd1A41a8YgOeqoMWnSNiHeuoTF442E6fdqpQlbFA9/sBNrNP2aJGVW/DZogWVl/kPIksoVCcCn5CgUpnKYkdipigZ9gfHd3r7imwJOMZYPnVqYwQTqxQ4SVdFgiYIV2qlTvqxMh/85uivYevTWZsGw/PeBLgty09/60yM74E60ZhwfunVf8CDNNyg2SGB4Gnf2loC8uuR6VFs29ZTLYzEWEtcGbbM8TDE1Tv54aVf6Sf6MfKO6pTGjEI/QTKtFo9KayFSHDHh5TVMmvVnIWORutPG7hVGLt3/cw/eRGYiKDx8BqRcoFW2f4ujDU5v019BzpN/t0qKNc/uNu99lEGH++2x+aAmDq6C3QqgBOjKkq67J7REsm7lB0NN/cJol3iiEC2A+uuPoeWCk3MAvbReT03RBXtSEmdmfFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3J4R2tHZnVzbGFBRTA4SnowN2JxbUNyenJNSHF2V01iU2V5L1h5UWY2amdK?=
 =?utf-8?B?SkRTSXU2WEdSS0xYTlkwYjVzVnJtYWFYV0VSdFg4R2N1N0lYOWU3am9CQkhv?=
 =?utf-8?B?TXRBdGRnR0JwMFhoMEpxTzNwMHVmb0IvWHAxbmdqdWoxbUxUUTZnWmdsbHJN?=
 =?utf-8?B?L3JKbmJVTzRGclhhL0lCeURpek9SRTFOemo4OXBnU2hrQVJSWnVQWHRVVGxZ?=
 =?utf-8?B?NEd6SHBEZXgrMFp3bUpxYlBSTlFRWjBURnNDQ1MzU0hyVnZNMUgyT3lqTVRa?=
 =?utf-8?B?ZGU1V2syZTl4anFPS3o2UjROYXVBODMyN2VxOTNJd290dVhTZDhDKzlnb0o1?=
 =?utf-8?B?cTdCQ1llUjdLYU5ONVBVdGJmTlYyeXcrMFAwWjRFcGM4TmtqYktEb2tzeVdG?=
 =?utf-8?B?LzYxMmNXbzh3b2dobzdWZnhnYlBNV2hQUjFvQ1Bla2lSUHVRaHJTUDN4WUp2?=
 =?utf-8?B?YnE1WTVHaDJtckRDZ2oxUG9DQUgxSzJpZ3I0a2FzNCttQkFTWE1rYXRrTHhH?=
 =?utf-8?B?RU1yVWVndlZFVXpBL09GUk1Zbm1xc2FwL1gxWmRJVjBzZXd5Rko3cXByYnNx?=
 =?utf-8?B?MkYzZ2lXTE9Penh4OGxFTWhsaENuNDVqT2dQOEZxWWd6Mitob1EyVHdrWDN4?=
 =?utf-8?B?WUZwR1JDWDdnQ0djZnRXY1dDT01UMjVURy95R3RFWU1rUE5NNThJSHZvOXc2?=
 =?utf-8?B?WUdOOG1YYWFHcEdSVWRvbkhYd3hjdzNTaHh2WGlYYkhFMkkwazZ0dXFIT2U1?=
 =?utf-8?B?R3ROejdZcEVHdzVma3BxdHZzZ3BMUEdWbWpkNjN2OFhXQWNnSHhMMlpwaGtM?=
 =?utf-8?B?bktUdmJEcXpHTUk0dy9Qcjhqd2tZUUhzd1M0cEV1M1YzUlN0WVUrZ0JaMFFk?=
 =?utf-8?B?V0k3Qm0yQW5ORWQ4WGRJb2x1R2xHb2UxRjcxM0RkMkhaNDVmQ0k3a3JVVGlI?=
 =?utf-8?B?eVRTdWN0b3c0TW8rOHdVU0ticEtjb1E2TlpPS1gyNmhOYkJQSldpVjFoN2JD?=
 =?utf-8?B?Mi9lSWNkMjN6Z0tlWThXUHY1cjdvaE5JTXN1OGNIM0RnZDlwNG1FK2p2dWpI?=
 =?utf-8?B?MVVHRjJ0REVyVmpRNWNBVDJSTHVLN09ST2svMnRKdDdFV0JSMFhpY0FLK2d3?=
 =?utf-8?B?RzdHdHUwUmhiaXA1UFZrbWR5eVRCYWtQd1NWQkh3VjUyTGlRNXUrdmYyK2tM?=
 =?utf-8?B?V2NxZzV1MWJZREJ5SE9aMVd3cUJuaXBILzJvTUZpRVYwMlZsL0FBNHlNMHdw?=
 =?utf-8?B?clJ5UXhxYzk3OXFrRDNRUU56S3d0aUFDZDNhQjZIdnVOWHhQUEcvRXlKUU9v?=
 =?utf-8?B?SktqdVNBR3l6TFpzYU5wRFBmbklNdTIweXRsNm9odXZRRzVBejdYNFpjYThx?=
 =?utf-8?B?Z0ovTHRqaXJleWswUzZ2VjhJWHR5RktpK1UxdkoxUXV3UkgxeFo3ZHZkMnoz?=
 =?utf-8?B?ejJ2SmJuajBOaHpQY2hlbjRtWUNXR3A5cHlhUUJ4Q2phL203VTBBOVFpTXlY?=
 =?utf-8?B?bkp6VHlyc05Nem5jUm9kallhaWR2bUR1SjAyNjhhMFFBcGRreThNWFF2OVN3?=
 =?utf-8?B?bzM5cDEyOUxGVFBNQ2txUzhkWGRjWUhrNldGOEpFZ0dpV3pYMTFuUjdueHVv?=
 =?utf-8?B?TnpsbWpWVW1kbUFvdkxZRlpwMWpBQUtkdFVmZFJrb0FQbkYrb1gxbU9yMEJ2?=
 =?utf-8?B?SlRzMGpwUzZudDhjbGl6dmNMMzRxODYxSjBra3hoaThQb1hrRHRDMTBFLzlu?=
 =?utf-8?B?R3k0bmtyRmxrbjF3WkxJVWovZHhZOFVvUzNzemdZdEtUZWgxdnFKallVRXl6?=
 =?utf-8?B?ajdjQ1FxS2Zqd0xRalFUckUvNDQ5Ync3MDFOeUhKN0RaaEhUUzZiQzRGYTNw?=
 =?utf-8?B?WGQ5dDNsM2t5ZmZRelN5QTUrVmRLQ1pkSWVWTWl0aFZJR0gwOEczYlRoMC9m?=
 =?utf-8?B?Rmo5TDZUWFlTaFRZYlVPZXNJTExTYnJRbzkxN29TS1RLSzJqdVZpZHZhM2Zo?=
 =?utf-8?B?Q0FOd1FpR1FsL0NOU1U3YXBBRFBvemlXa1BVdmxodFRtNzhGWEJ0eG1NTVFN?=
 =?utf-8?B?NzhBTVVNUVVEQjF1bDVYMGg2NE1sbFdISGFpZVpzbHl3SmNPQXRRSTdjbUNQ?=
 =?utf-8?B?Y3Q2VTk5Tkc3cjB5aElkUkFZRDd4VzdYODZiNU5zamQyWndBcWQ5NVU4cVRr?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11599ea4-bc33-49c8-e202-08dc57a23fe3
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 08:02:34.9783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtDSknAq0tQzYduJevxR0XAjIAAcbvFnqXoU7D87FY1Fj94hf4AagzYmg1ZyRDbIn7Ri4QZPO+Tdcrx2WRoSpA2U7dFmYnLv7VsnmLRAVIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5224
X-OriginatorOrg: intel.com

On 4/5/24 12:41, Leon Romanovsky wrote:
> On Thu, Apr 04, 2024 at 08:46:41PM +0100, Edward Cree wrote:
>> On 04/04/2024 19:35, Leon Romanovsky wrote:
>>> On Thu, Apr 04, 2024 at 07:06:53PM +0100, Edward Cree wrote:
>>>> Why?  What does the kernel get out of it?
>>>>
>>>> Maybe *you* need them to be supported, but maybe you should have
>>>>   thought of that earlier in the design process.  ("A failure on
>>>>   your part to foresee the eminently foreseeable does not
>>>>   constitute an emergency on mine.")
>>>> If we let folks bypass our standards with a _fait accompli_, we
>>>>   don't really have standards in the first place.
>>>
>>> Sorry, who are "we" and what are "our standards"?
>>
>> As should be obvious from context, "we" in that sentence referred to
>>   the mainline kernel.  And while participants in this thread currently
>>   disagree on what "our standards" are, I hope it is not contentious
>>   that the kernel community *does* have standards as to what code and
>>   design is acceptable for inclusion.
> 
> You didn't answer my question. What are "our standards"?
> 
> Thanks
> 

Our standards include use of tone that is welcoming, and, in this
thread, you are aggressive instead.

With that said, I appreciate your review feedback that I have received
from you.

