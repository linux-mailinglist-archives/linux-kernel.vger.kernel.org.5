Return-Path: <linux-kernel+bounces-135027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 366B089BA23
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7726CB21BE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688BF2E62C;
	Mon,  8 Apr 2024 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lttW2J/o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0532C69C;
	Mon,  8 Apr 2024 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564679; cv=fail; b=Jgk9JGZYmtLcCSz9kWp4I+sIdy+Ir+Sd6v88WG1ygc1SN6ElmxJX7Q33X+gZJyq/utb+J9hmuLjNiLE9clcXv/TlVHIFct8DS4e915Bo9okIICMkfvsUa450aTUfle4dmBTTJ2xk6ces4jCuprvlSKeNdI2RflVa/OiU18snYnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564679; c=relaxed/simple;
	bh=jKecivEPxZquuDE7YnFeahbkj5EZ9ItJZlf5fEG5t4c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OSo2QnwHcFwirNihob42QVgAjxyXPXHG6gtWV8XmNMgila3K2QRf/eIt4s24SRIVEwpOwl8B1AMopKpBYtSKRX9nP4ZYvNCRmxsHFu2AyH3+gUKiLh62VvIY6ySWidPHKvK/x6qc6H1mLqGs/dMrvrkAvKMtSVYJ4FDgrePiLdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lttW2J/o; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712564677; x=1744100677;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jKecivEPxZquuDE7YnFeahbkj5EZ9ItJZlf5fEG5t4c=;
  b=lttW2J/ovZerOy7MAZaQcZBIN0UP5x1sWD+Z9oUew91IclaB43WVB0+S
   qsLjnTPumeTBlZtuBrWRd6AfO6N2J+2HMVxNZ9Whv0kTE2uu3RVAGnesg
   B5f3mACRAZhf1+iMAqlK0YitTJ2WdaVIKiVRhYzCYcOHjirq8+MvyaPwn
   BNP4/fIFf4vlh9O0FYHdbw+9sbjkxkCZzx8GlUtkwxGPZ8Sj7ruHE89q5
   L67r/1auCku2r6Lpv+oUrVbFrSY7L8JZ18EDONMlxvQ7ozwphYnXxJs74
   jz5JI4r5j2K3Ocnb4kiRelStNKnNthH614iHxtHfBS3I9+1TUx+35xgf9
   A==;
X-CSE-ConnectionGUID: SJa4CfzuTPCKsvEecg0dSw==
X-CSE-MsgGUID: Nc6h3m44RX6RWaCr+42crg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7688306"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7688306"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 01:24:36 -0700
X-CSE-ConnectionGUID: 49RiPfprRoCRiYIOpP+PiA==
X-CSE-MsgGUID: B6NA6AFeRjS2LeMugAwnog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="24284597"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 01:24:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 01:24:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 01:24:35 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 01:24:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjUp/hxZEcDsbDlVKk8iaOZ5P1IQNwE5IYfz6UyPSF2lMCl9OZ9imvJojucGaQtf0DbcrDEjFdUG3gqC4QnBv9A7Ue3RYFY38lGp4ii6obSRY/BKu2557RVES3rlNJFQmovhY+wXZ996CJC6kF11rZamVd3slDa/Ccz6K2VaQwfoQl18DCwcrEOTdpPdMX+Etx0cUy6V0KlUm8iuJP5yz91rH9VFAUZusb53vuC0WeaWCq74mDt5xr6eiffCT5jFx48sxDJEq7jazookWGJ+daX+YtsHQGGCjrbzKdYz3O4LM/B916pGVmiY42GzddIVx5uOwPiBFWQG50nO5i4tkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wbRXRkYFMIaOZ3yboKh25Qm2jU3mkGsLbYKZVry398=;
 b=M3jL8+2cNPGU2WHLZZtrrHBE/jlI5wnmKkEhO5/GWYQGHLdI9S1Q5VjtfJmw3ZT5UGmPXynDfOZB86KxrdekROCMgCq8Y/tWxqeAbqiDDLKztnr35m85i1VGSmSNtWz6LnuYortDxmwZjnl3rdEtmUHVq3054FXiHciI4+pXnkXGqoDGP1kzGtP4vx9GKgPpe361bKEDEgjzSxnTuAWfjEvuygHkqooz+LE8XosP+93b8QxoypJFg0YUsvVVfD40wkwz8ct1pAfBESSkgGiUZVNaXfc5eAYrsCbQgWJSrrNAGG9+GkY3WVATk0APMqpu8MjRm6HAU9b6V8MzebEC3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 IA0PR11MB7839.namprd11.prod.outlook.com (2603:10b6:208:408::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 08:24:33 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cb11:e68c:53db:aba5]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cb11:e68c:53db:aba5%7]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 08:24:33 +0000
Message-ID: <00016dca-9e32-4cc1-8d0e-36eaf12dc466@intel.com>
Date: Mon, 8 Apr 2024 10:24:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>
References: <20240408141216.3eb1128c@canb.auug.org.au>
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20240408141216.3eb1128c@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::20) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|IA0PR11MB7839:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1+jpVa2FE0ROcspuYH6RVtbiUo23mwpOd+i0myixr97etn5RkHtN5b08SvAImTiV6HZ4o1snYuuz5xuYl/ZRKvXsw0QgMCN71SKk+z9C8he2/o7U2pGCjcjf1YIuRrtQNi4ANwJkXfrUQQzQ6cIUaafJyA7ZknJeTqMJ3P1e/SDhSAf3A1GyabpvGGc6bl3ztoKSyPPSmzh4PLAR5Wo5a/+vlbs9f/LX5m+dGx8s6n2IEDFIj11EuCEul9a1cy6XxGjHHnfkZNRidZIHUNY6EzbEgZB0NCoGpCrYNS5mGmZpbj2DXepM4712N1QLQe8on+d5J9o0F7PdrzCwl2WHNkeS7R6ueuKgQ1tZ7k3sPi3jWhYdsD7LqvbNZHJ3BGd8VQSD04UR0tUj64Nt8pfkSJHIIyaVxT7CIcpwdLNTBk8QE/YVOHZbz6JQyd3aN4iR53qIVa7YZI8yrBtIj05iemsbsM5dkkbIh42WKAq7Jz32hXUts+m5vlBjKAe74YQv2VTVUiw/vVPbfcCsj4fc481Ph6cblpAyQxu7CQP3hYa0Z8x7rAu9mLKTY4DLBbrJ9Tam3edJNrDrPI9XWFG/sRXdqk85OscZS3crJdkLJsOcMw3i8+gXDgeNtd8PiBg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dytIdkw0WjBwd3gyRzJFQXdoQjZlTHVMd0dMaTZUb3Z5S0VXWGZIT3NKdEF3?=
 =?utf-8?B?YUkvcXZwbnNBdFJKK2t0cG5LcjRNOTlQRFIyRUxma1hpdkp0TWpCeGljS0pF?=
 =?utf-8?B?Q1V6T2VRSmpBVXkwS0hHeEZxT1QxRzNHYURxK1kvUHIrbXdXMkMwTDVwZUt2?=
 =?utf-8?B?ZkJHb25PcTdkUCtDQ3JRYzMwQ0JEUEI4RDFmUzF1TUZvKy9tTzF0aG1LeDlQ?=
 =?utf-8?B?R1FncVJFSm1DRGZ2bFRSaDQzOGY2VkxZMi9tT2twY2wwb1dzd2xYelZqQkhw?=
 =?utf-8?B?T1ZpeHlNcVVFbDhyTTNETHpWTkJyc2hRa0lIYlBoNG53YmNaSjNCL2VIYWhk?=
 =?utf-8?B?QXI4R29TYXdrcVo2MDhWNXZVM0owOHlQYzEvcTNzaXdwRHpJaXIxMDdlMGVx?=
 =?utf-8?B?a2F6SFJ6cWRHSWRVbERjMVA2eHk1dnYwMVJCTmprRjh6d1ZOUGVuUExEaTNt?=
 =?utf-8?B?dmowR3NRaVFUWEFXM1JZMFpsSDhHbHFYQVZaemNrb21WM3YxdUZpUUhxY3ZL?=
 =?utf-8?B?UzZEUkp1aUwyMm16clZ1MXhxZElybFBRZnVMeks5K0JBUnRWRis2b0o3a2d0?=
 =?utf-8?B?WTZoR2ozRUhiQkpkeGtITjBCUXlxR0JjTHZGTWkzeXBIMnNFVi9nZnU5eHcr?=
 =?utf-8?B?YVVaU01QNzFHWXRJVUtVb0xHRXVwOS9xcmM4YW5lblJWb1A5dDhWa0xwazZa?=
 =?utf-8?B?aXB2RmN6aEFmdzd1Vk5iVUtqZFQ4VjUzVFBzbDhKQWQycmVleXBoNzJETkJQ?=
 =?utf-8?B?Vm5VaExEYkdMRGpxMXlvWlZkVzk3LzRVbmd0N2xXUE40K21Ha3BlNGxrdDE5?=
 =?utf-8?B?c3k2SEpUeEkvMVBVaUw4d2NSZXVLZU9KTU5FRTZwUHF3T1JTd2lYOTA3Vm1j?=
 =?utf-8?B?THVpQ1NQV0owWnRranpBY3JwcTl0YW5BalFZMGVTTytsZjRJQktaU0lHZkov?=
 =?utf-8?B?R2FnM1g1N2pDWVY2M2lkTWFvcmtVQjVleGlOMzlobjlJa1VtcXRhNWNZUlN5?=
 =?utf-8?B?cEh5SE1va1NuYWJqSXRUZjdHeS9YK0U0SnZobTF5QXB6Z2ZpalcwbTlGRXBa?=
 =?utf-8?B?QlBTQ3JRNGVTOWlJVzh4OFFqUDdPcmpZZW03YkdiSzVGMUFFMjZVSFFZbmx3?=
 =?utf-8?B?K0lpUGZKNzhwRXRRcHVwalA5dkRWMjJ0cEthTW9XN0s5d3FQcGNFTXVIdWV2?=
 =?utf-8?B?d25ZeGhvUUlKMVllcWlUcVN1U1RnQlNJUG9iWEdEMHcwYTNBYzdBcExxOTNJ?=
 =?utf-8?B?dnluK1lKVE15NEVTbnlXQ2Nsc3U5RndOTi9hTERtTlAwdTZLUTlWQTRsbXAx?=
 =?utf-8?B?TE1oU3N1ZE0wbWRKYjl1SXhkcnk3VUplcGJGdnMrT1pJWWxSbzEyWlcwTEFR?=
 =?utf-8?B?NnpySXM3VzZ3Y20wS2NTTGZBUzEreFFpQUtOUmhRbUNJM2Z6RmlySmNLSU9E?=
 =?utf-8?B?THppeDg5bnpNRzdQNVVHNjZra1RhbEpmM2g3dHpiRFVzTjUxN3NEWTBJZUpl?=
 =?utf-8?B?Ri9VQi9FUjhDcWZmWVBabTh0R3VmeDJQNEUrSWk3WEcvWi84azEwc2JWc3Zy?=
 =?utf-8?B?MnpDUFRmaTV0MElKOU5uL05icjZxTzBhSVBmYjkrNzVZUlhtNFRzT3ZqcXlJ?=
 =?utf-8?B?dVgxcVZzZXBWbVBGOEhDejFyN0hDYllOSGtSMkNMQXdSK1ZjbFBjVlk2bllK?=
 =?utf-8?B?d252aHdWZ0VwbVdnUXlLcTNlWHVvSnBudksva2p0QXlsL1B3eDhOZGFtZ1pR?=
 =?utf-8?B?RXlHalg0YVZYMTF2WHUzK0VjTE1ubEo0VTVIOTk1SlNLVWpzWUJUQ2tTVEY0?=
 =?utf-8?B?ZFFVK3l1OTk1MUxGb2t0UXRuWUNqNGFIZC9sdFR1bUNueStTN2EyVnBaNzNy?=
 =?utf-8?B?S3JibHErMlIwQzJYdEZrWTY1bjdpRlUyZEVERFR5NHgvQmJ2K1VINjhJdXZB?=
 =?utf-8?B?YnFrNHhydXlxR2J5MFFwTFB0MGkxTVA5bjU1b09wZGdtM1VPbTd5MGJmQTRG?=
 =?utf-8?B?cFgxNTdHRGlPTnZ0VnBDc0ZhUEFjcEhWREtVQU9iRng3K2JPVU5oRHREUzZl?=
 =?utf-8?B?Uy9ZQXl5dko1aitaRGlMc3dDMGtFWTk1RWE1c0RaRVdQQS9obW5ONUtkMk1Z?=
 =?utf-8?B?dTR4cTJNZm9nNkZYejBybTM2RnZicjdjMDBXNTgybzl4MUs2eFc1WVRMM0hQ?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e74fae-5704-40bd-d087-08dc57a551da
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 08:24:33.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpS9SBsS56JottxcJJWa4YvwDojbz9SeAYJc25Kq7PX2yn+rev6U5BZnp9YYgj/0gn1rXR6sGQscs7goADVzf64NfvhMQXacaGrXbgFZeYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7839
X-OriginatorOrg: intel.com

On 2024-04-08 6:12 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the sound-asoc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> In file included from include/linux/bits.h:22,
>                   from include/linux/gfp_types.h:5,
>                   from include/linux/gfp.h:5,
>                   from include/linux/slab.h:16,
>                   from sound/soc/intel/avs/icl.c:9:
> include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct avs_icl_memwnd2) == 65536"
>     78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>        |                                         ^~~~~~~~~~~~~~
> include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>     77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>        |                                  ^~~~~~~~~~~~~~~
> sound/soc/intel/avs/icl.c:73:1: note: in expansion of macro 'static_assert'
>     73 | static_assert(sizeof(struct avs_icl_memwnd2) == 65536);
>        | ^~~~~~~~~~~~~
> 
> Caused by commit
> 
>    c2b10acb62c1 ("ASoC: Intel: avs: Add assert_static to guarantee ABI sizes")
> 
> PAGE_SIZE is 64K for this build.
> 
> I have applied this patch for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 8 Apr 2024 13:50:53 +1000
> Subject: [PATCH] ASoC: Intel: avs: stop building when PAGE_SIZE == 64K
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   sound/soc/intel/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 4b9e498e3303..abe5cba82d50 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -211,7 +211,7 @@ config SND_SOC_INTEL_KEEMBAY
>   
>   config SND_SOC_INTEL_AVS
>   	tristate "Intel AVS driver"
> -	depends on X86 || COMPILE_TEST
> +	depends on X86
>   	depends on PCI
>   	depends on COMMON_CLK
>   	select SND_SOC_ACPI if ACPI

Hello Stephen,

Thank you for the report. I do not believe the patch above is the 
correct fix. Below is the context and the proposed fix [1] has just been 
sent to alsa-devel.

Recent series for the avs-driver added static_asserts() [2]. Since that 
moment, build problems occur when PAGE_SIZE != SZ_4K. Patch originally 
designed to fix problems with the window description [3], didn't address 
all the problems, unfortunately.


[1]: 
https://lore.kernel.org/alsa-devel/20240408081840.1319431-1-cezary.rojewski@intel.com/
[2]: 
https://lore.kernel.org/alsa-devel/20240405090929.1184068-13-cezary.rojewski@intel.com/
[3]: 
https://lore.kernel.org/alsa-devel/20240405090929.1184068-3-cezary.rojewski@intel.com/


Kind regards,
Czarek

