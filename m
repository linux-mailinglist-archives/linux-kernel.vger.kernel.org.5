Return-Path: <linux-kernel+bounces-141421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE7A8A1E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D619228E996
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71A0130E4E;
	Thu, 11 Apr 2024 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XSPUTo+r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4847A151
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857379; cv=fail; b=lfwbgYCGTxs8C9n1FvceWgpIK1IdEz4DEeA1hIeqW1041K2LfcXiWao6zhS+trSRoEs314XVbnByQ4JP7dnAJnBPcUrB+nqeEUhcFSKcz0ArezCxESn4sIMh2bmJWzTkhdB0Ukd6hMDA3KJgTJYQ0Uq8htXUbSLzdvLHD85iPL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857379; c=relaxed/simple;
	bh=ybdPwk4Uy+GnoIevghCLqYk0YK7jp2g+tNHjJqxQV5U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VFrQCaB/eZxoxPP7meyGhw7A6f4bEEWYOCEUmPDd/GQjO2RFW6jAepHpN85Hk4Dsbf8/vyH8jFF2Q5XGsAUiMnhf24cdDKhwhykl1Dt4JJ4vsqOJOPPt01omnui2SMiROsx97dfGCDNAcq8MbwWV1mlNLfW6lxyUoj5X+YW0dxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XSPUTo+r; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712857378; x=1744393378;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ybdPwk4Uy+GnoIevghCLqYk0YK7jp2g+tNHjJqxQV5U=;
  b=XSPUTo+r9T8RAEaEcT7DiuSTK0G0R4z7832a5JOPbELsuTmHij76ZQm2
   pTTesQ13WsG/TLEOJMUWk4eA12r61hbiUY7oO5csil6ooWv1HE30hBqzX
   +U1RfD5EJepCrtHxpSY7WlYWNSt8T8ZSKVwCJotvWPMrkavXZI3DxnTA6
   exK8jO/hND/mTkk5s75SWMlmOSVYvG/dZ3JolQEqlRnf42wciwW/bCo49
   ClJwjRhoOyI08kZhFDIVc+cHWJTgPhCERSGxvdC/a3r61wBLHFwbVFfF3
   yoAw7qqFTzC3qdIlnYCBLUvuDT2ZexYzGw4/IXLgyrY1+tpFtv8C0vdCP
   Q==;
X-CSE-ConnectionGUID: K9oMOAmrQ467pVexaf1m1A==
X-CSE-MsgGUID: qyLJ/wJbSIGrAAWqc46bew==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12138076"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="12138076"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:42:57 -0700
X-CSE-ConnectionGUID: MNTfbgsrRxWmB1t6JC9pWg==
X-CSE-MsgGUID: bqdn7TtZR92qa711zzBigA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="21039450"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 10:42:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:42:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:42:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 10:42:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:42:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAftUkWr4RslFg02R0flFPiaIAKjwVT1HaP60hwL86IeLPCZy504vpkT5EDn/5eqPCyW3Sg6KT3nEDvICQvc+A9mfeYYqCTslasqi7sOMwDoWA377zrTo1JXoiWw4AYfDvvWPxk1qhc/bRutGpMWdKuYLvhpPww+qfs/Cp3FCdd3QnFsTVjD2uvoGXgVBScN7QMJCzZHS7afSiU8aOa5yse6VLYmhf/KbHlj3dKDGWjtvxFneirUkm+UQURZoz2guBfldajrevoGt+T9yHCSb+2DYuWcWAr1zsZzNS6OtE6I8+2qrvR0YKr0IHucirUUp+6pouB7HdHNg4O88vC2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njyIqYWGyl5ziKyF0YFssOp12C91wuEA8txl5v0ebh0=;
 b=gni+GT9EBM6IfT5WptU4faUOCiPmLa3XDTA/r9mzswBLZMNciBGGTSgG86rl97d0/WgpBMjUMosWBn7CKdrTYvR+VKRdtHnXgOsiy6+7ykzDMTCPzmshQzU+yVxgIp6D+rhXq8Md2jYMK4R8A168E59XL5ma+a8KiY5i2T5186QwbTG60Kv4YnLuVlqkal4u7dC83zSW7wmphkB1wOTgTZuFc6cBS+8/PQSlMcjxlpfRJiub2k6eUIBR8s3opzRTUBjX0edcof4XQsnkEHa3Lx3NBOrd+4CN1xo3mWFIe2rKP+u5H79ydyC9wB/WIWTQ78yrsYvgRE+qt9/MD95TQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7823.namprd11.prod.outlook.com (2603:10b6:208:3f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 17:42:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 17:42:51 +0000
Message-ID: <23afb7ff-222f-40d0-a68e-3d7b0c3df55d@intel.com>
Date: Thu, 11 Apr 2024 10:42:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 29/31] fs/resctrl: Add boiler plate for external
 resctrl code
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-30-james.morse@arm.com>
 <fb4abe11-5859-4a53-a4db-bb4e59a571c6@intel.com>
 <ZhfzObobGI/p9ISP@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZhfzObobGI/p9ISP@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 247d1540-88a4-4c28-0f19-08dc5a4ecf54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JY2pb3b+jef8j0WiewdBTvhQH0J2bxISs1jYCYYaJliUfoAZmZNhgEjoqmvkiH/pZgvDWSzAtqSYq56OM/1/yEyf7tDs/TpfVGvxDhgZ/ntrPWYl4aBRerS7AIAiu4K0yGX9ThNizlzT39SgcjII9fv8xiw0W8JKfRSArqHkzwtT+i/WWpL+Q+QICxmvNuVshoNuSa/hIKhCTa/v+wXlPg9hk7u28STBYfMppm3LyO3YHpjlUIEOFmf/lWOAT7Thf4Z4z38308mMzTF4f2IeeU2QfuBCGbpGjedCaaWees701XU0AC0ftMZ7RSXx8wKhJJYBqb6P1NjXpbtGAKu4YHK339l0c0L3ox015ZadTvHIlSVXT2nS21rAaeTM9gfXQv9E3P+ICvGZztERF6cpYywJtWgRW/8wgjmx2avC0sDlMZV2SZJ9BhCir0it/tVOQOgJrCbwpX7N+mlB48IgVKL2XgSDQqLPAA8tPYipXwP9FKcRcpAqDP64YVpvz9LMH48vSp1MsApEPLS4UIWA3Au9Re5y977l2NmUBjjQdLpgfp5A/2x5BgdiNOywzsuTwAxWEihqdQ1x/IkLveOMtp1WVC/jEScWfdeLcOu8XOPivo4r60kGSgFXtZz5rVqJgw9lpHwOLzlhkH6xDbm3kNug4f7YFJxEG6aAagJV1UU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTR5Rm1WU05vNUNMN2lpSXl6Rlgyc0NxaE8rR2g5UGhtT0ErQlVMcDdla1hi?=
 =?utf-8?B?am9hcnNRZkpYaEc4b1FKcmhBTVRFUXdFa3JneDM3QWc0L0ZxbUw3YnRZenI3?=
 =?utf-8?B?Y2FacEd0WnErVmZLOWVNYlcwdXpxT3Brd2crVjQzSE81dkVMZEVld1RaYk9l?=
 =?utf-8?B?STBNR3pyb1A3SHRpRkVMVGk2dTJmR1VHL3d2YWdrT0xKRWYrTnRhZnJrRlM5?=
 =?utf-8?B?QmZnRWt6Uy9GdGh2RDZrb2dweFFuSWtwbnNkbkwxbGlRY2w2aW9VaEpDcU1R?=
 =?utf-8?B?SExBSWlDYm1BTjhXczE4aU9QTnZEdWw5cFB6RllJdWdWcTFUMXEwSlNSNkx2?=
 =?utf-8?B?aTZ3MlZzRThMWjlscWxnU1NQdXBpWG9xRExWb3VzUEtwNnMxdkppbDdiQ283?=
 =?utf-8?B?dkdSeWszR3ZjVDZJS1lqdEtOQWoyTC9BelhvSmg5aGE5R2l4akJnNlBzbjZX?=
 =?utf-8?B?U25jcHVpbTkvWnZPbGJaNFZLVEhhVkV6Tm9NUndNSWFtbXpFWnZLN0pOZ3hS?=
 =?utf-8?B?M052Mnh2Sml5clF4VnhKSmZXUlJ6dk03bTI2Sm15UVZTc1BjOHEzSjlyRzZz?=
 =?utf-8?B?R3hxTkcwUjBrSmU3ZlFkc0RIYllXTEZXVW0xR0s1OVZ2NUs4U01rZWNmWVFh?=
 =?utf-8?B?dUF1QUZ0VzFLcDBGSGdmZndjRHNBRG9ha1BTem0rQTI1Y21ENlpGOHNNWFZB?=
 =?utf-8?B?VzAyeEkwUWVVU2I4bzlHa1RWc3BxekhoSXdHTWpsNFZsU1ZTZHUrSUZ3bGtB?=
 =?utf-8?B?WGZlSTl4U1o4Y3MwT0pBTW5jWXpEa0NtWnI0cFhmZ0t0NHI0RG5HaldqTlFj?=
 =?utf-8?B?UnJOQy9yTTYzcWxqZlp1NmlpVE1MTEZvSUd4RU9rYmp5OVpyZ3NJT3lCUDg1?=
 =?utf-8?B?WXcxU2wvbVplQnZvL1M0MWFaUUhkbnRpc3BTbWpXUjFGM0IydHhlMklyT1lO?=
 =?utf-8?B?dGhZTkZ0bXo2RlhQRDdBOXBDVTZnTG5EU3VBNHE1MlVLUlBmUURDZVg3cjZx?=
 =?utf-8?B?UGFRejNjZlRYdkRudDdIdndQYjRuZ2ViMlJWV1dJdVlRQ3Z5ZnkzVW15eUZh?=
 =?utf-8?B?Ri9LRG14dGJXTFRxbUVEb2FTcFJSVFN2dEJpbGxrYjhBdTluUWhGQzAzckFN?=
 =?utf-8?B?RGQ4WGhXN3p0R3BxaHZ5VHFScEVleUo5Qzh6dkFQY2IvVG9GZ1A3UjI5bjd6?=
 =?utf-8?B?TDRhWXc4MXRnSE9PcURZL0dnbzJMSjJzcjdMVWRhYk9idVgyM2k4NkVjZkht?=
 =?utf-8?B?VlE2KytJeS92UW1HMW1qSjNwNG55Z3FvYkIyL001RHh6WmxwNWpNZ1IzNUlG?=
 =?utf-8?B?djBjSGticy9DWGtPOUlMQ1o4TGJLZXM3dzE3MVlWSnlIQjBOVGFnbis4OEF5?=
 =?utf-8?B?ZVFJcGFYUUpoV00zL0VwQ2lqMjBJczhUM1RYenluRGw5N0xOcGZqT05yQS84?=
 =?utf-8?B?bnVyZWNLUU03UGhwemJ1akRuUFpuQmlMeldrZHBqMXRRendoMkRJMmJpOHly?=
 =?utf-8?B?QmJnZnJZcWE4M05QQW5oZHJhcnJzSHhNNm5xKzdlczc5Qm9FdEduNjJrMFBk?=
 =?utf-8?B?aURiK1U0cFptUy9xaFBrdDU3Q3FOWU1aNHhNT21yUUl3TTJhZXh0WmxZSDFt?=
 =?utf-8?B?YTk1Sy9hRFlmcmtiQUdLaU5IMTVBNk5FT0MzcjhFT09NZ0k2dHRCZU1ienNt?=
 =?utf-8?B?OXFMVUoyeW5Sc1RoSjEwYkR3Q016ejg4Z01iZnhIZk90dmVaNVBrNm4vc1o0?=
 =?utf-8?B?aW9DYituR3pyU2xPTE5sQWpvNHJMM01EVUxWcEM1Z1NjZnNTbWJUYkRTMFU0?=
 =?utf-8?B?bWt6bDZXZkEwM1kyMksvNm43OEIwdGFVcmsvdFBLMXBiRUFmWWNQMUZtbThJ?=
 =?utf-8?B?Ti8rSGZvWVN0SEZoV252Z25VZGFaSTNNNkI0OG1JaGNzWmxNR0NLMWNSYXly?=
 =?utf-8?B?aHBtbDIzcTZWZ0ovQ1hDV09DVC8rU241aXNpZmV6aXBzUDJWdGxUcEx4NGw4?=
 =?utf-8?B?NWtkWU9YMGhsS1hqZElIbDZPU3hkVTl1bUFDVjZDa0ZMVGwraTRROHV3OWhU?=
 =?utf-8?B?Z0tjRitOL25rV3NlWWFjTUlHbUg2YVhUSHJrVitNY0IwVzhHUHMwRVpGbS9z?=
 =?utf-8?B?OXVKTGQrWHNxOXcvY2k0MnBBd1ZkVlA1ZmQ3LzJXNHN6Q215empySUJQL0JS?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 247d1540-88a4-4c28-0f19-08dc5a4ecf54
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:42:51.3174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNIhRuJ2UTI9e00d+sIy74RE1iU8WAASWKPFKMUz7lDwJZpGq2nlzBlcEHxZEYKGQJglfmiwiGPSDg5L+BFYynZVh+9CD82Z1TbNl0bIdjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7823
X-OriginatorOrg: intel.com

Hi Dave,

On 4/11/2024 7:27 AM, Dave Martin wrote:
> On Mon, Apr 08, 2024 at 08:41:04PM -0700, Reinette Chatre wrote:
>> Hi James,
>>
>> On 3/21/2024 9:51 AM, James Morse wrote:
>>> Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
>>> for the common parts of the resctrl interface and make X86_CPU_RESCTRL
>>> depend on this.
>>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> ---
>>>  MAINTAINERS              |  1 +
>>>  arch/Kconfig             |  8 ++++++++
>>>  arch/x86/Kconfig         | 10 +++-------
>>>  fs/Kconfig               |  1 +
>>>  fs/Makefile              |  1 +
>>>  fs/resctrl/Kconfig       | 23 +++++++++++++++++++++++
>>>  fs/resctrl/Makefile      |  3 +++
>>>  fs/resctrl/ctrlmondata.c |  0
>>>  fs/resctrl/internal.h    |  0
>>>  fs/resctrl/monitor.c     |  0
>>>  fs/resctrl/psuedo_lock.c |  0
>>>  fs/resctrl/rdtgroup.c    |  0
>>>  include/linux/resctrl.h  |  4 ++++
>>>  13 files changed, 44 insertions(+), 7 deletions(-)
>>>  create mode 100644 fs/resctrl/Kconfig
>>>  create mode 100644 fs/resctrl/Makefile
>>>  create mode 100644 fs/resctrl/ctrlmondata.c
>>>  create mode 100644 fs/resctrl/internal.h
>>>  create mode 100644 fs/resctrl/monitor.c
>>>  create mode 100644 fs/resctrl/psuedo_lock.c
>>>  create mode 100644 fs/resctrl/rdtgroup.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 5621dd823e79..c49090e9c777 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -18543,6 +18543,7 @@ S:	Supported
>>>  F:	Documentation/arch/x86/resctrl*
>>>  F:	arch/x86/include/asm/resctrl.h
>>>  F:	arch/x86/kernel/cpu/resctrl/
>>> +F:	fs/resctrl/
>>>  F:	include/linux/resctrl*.h
>>>  F:	tools/testing/selftests/resctrl/
>>>  
>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>> index fd18b7db2c77..131d874d6738 100644
>>> --- a/arch/Kconfig
>>> +++ b/arch/Kconfig
>>> @@ -1406,6 +1406,14 @@ config STRICT_MODULE_RWX
>>>  config ARCH_HAS_PHYS_TO_DMA
>>>  	bool
>>>  
>>> +config ARCH_HAS_CPU_RESCTRL
>>> +	bool
>>> +	help
>>> +	  The 'resctrl' filesystem allows CPU controls of shared resources
>>> +	  such as caches and memory bandwidth to be configured. An architecture
>>> +	  selects this if it provides the arch-specific hooks for the filesystem
>>> +	  and needs the per-task CLOSID/RMID properties.
>>
>> Should it mention monitoring capabilities?
> 
> Probably, although I wonder whether it is better to describe this just
> once, under RESCTRL_FS.  Does it makes sense to have something
> like this here?
> 
> 	  An architecture selects this option to indicate that the necessary
> 	  hooks are provided to support the common memory system usage
> 	  monitoring and control interfaces provided by the 'resctrl'
> 	  filesystem (see RESCTRL_FS).

This looks good to me.

> 
> If so, I can propose this.
> 
> (Details on what gets added to task_struct is maybe unnecessarily low-
> level to bother with here...)
> 
>>> +
>>>  config HAVE_ARCH_COMPILER_H
>>>  	bool
>>>  	help
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index e071e564452e..cb043543f088 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -479,8 +479,10 @@ config GOLDFISH
>>>  config X86_CPU_RESCTRL
>>>  	bool "x86 CPU resource control support"
>>>  	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
>>> +	depends on MISC_FILESYSTEMS
>>>  	select KERNFS
>>
>> Do both X86_CPU_RESCTRL and RESCTRL_FS need to select KERNFS?
> 
> Hmmm, hopefully the arch backend doesn't need to re-depend on KERNFS.
> I'll note that for review.
> 
> (If not, we can probably drop filesystem-related #includes from the
> remaining x86 arch code too...)
> 
> [...]
> 
>>> diff --git a/fs/Kconfig b/fs/Kconfig
>>> index a46b0cbc4d8f..d8a36383b6dc 100644
>>> --- a/fs/Kconfig
>>> +++ b/fs/Kconfig
>>> @@ -331,6 +331,7 @@ source "fs/omfs/Kconfig"
>>>  source "fs/hpfs/Kconfig"
>>>  source "fs/qnx4/Kconfig"
>>>  source "fs/qnx6/Kconfig"
>>> +source "fs/resctrl/Kconfig"
>>>  source "fs/romfs/Kconfig"
>>>  source "fs/pstore/Kconfig"
>>>  source "fs/sysv/Kconfig"
>>> diff --git a/fs/Makefile b/fs/Makefile
>>> index 6ecc9b0a53f2..da6e2d028722 100644
>>> --- a/fs/Makefile
>>> +++ b/fs/Makefile
>>> @@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
>>>  obj-$(CONFIG_EROFS_FS)		+= erofs/
>>>  obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
>>>  obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
>>> +obj-$(CONFIG_RESCTRL_FS)	+= resctrl/
>>> diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
>>> new file mode 100644
>>> index 000000000000..36a1ddbe6c21
>>> --- /dev/null
>>> +++ b/fs/resctrl/Kconfig
>>
>> Could you please review the contents of this file for
>> appropriate line length and consistent tab usage?
> 
> Noted.
> 
>>> @@ -0,0 +1,23 @@
>>> +config RESCTRL_FS
>>> +	bool "CPU Resource Control Filesystem (resctrl)"
>>> +	depends on ARCH_HAS_CPU_RESCTRL
>>> +	select KERNFS
>>> +	select PROC_CPU_RESCTRL               if PROC_FS
>>> +	help
>>> +	  Resctrl is a filesystem interface
>>> +	  to control allocation and
>>> +	  monitoring of system resources
>>> +	  used by the CPUs.
> 
> (Not quite a haiku, but I don't know how many syllables "resctrl"
> counts as...)
> 
> Since this is the Kconfig user's primary knob for enabling resctrl,
> maybe flesh this out and make it a bit more generic and newbie-friendly?
> Something like:
> 
> 	  Some architectures provide hardware facilities to group tasks and
> 	  monitor and control their usage of memory system resources such as
> 	  caches and memory bandwidth.  Examples of such facilities include
> 	  Intel's Resource Director Technology (Intel(R) RDT) and AMD's
> 	  Platform Quality of Service (AMD QoS).

Nit: We should double check with AMD how they want to refer to their
feature. Their contribution to the resctrl docs used the term you provide
but their spec uses PQOS.

Do you expect this snippet to be updated when MPAM full support lands or
does resctrl have enough support at this point to include a mention of MPAM?

> 
> 	  If your system has the necessary support and you want to be able to
> 	  assign tasks to groups and manipulate the associated resource
> 	  monitors and controls from userspace, say Y here to get a mountable
> 	  'resctrl' filesystem that lets you do just that.
> 
> 	  If nothing mounts or prods the 'resctrl' filesystem, resource
> 	  controls and monitors are left in a quiescent, permissive state.

Well written, thank you.

> 
> 	  If unsure, it is safe to say Y.
> 
> 	  See <file:Documentation/arch/x86/resctrl.rst> for more information.
> 
> I'm assuming that just enabling this option doesn't introduce
> significant overheads.  For MPAM I'm pretty sure it doesn't,
> but if this is a concern that we could go for "If unsure, say N."

I would vote for N for when folks are not sure.

> 
> If this looks OK, I can propose it to James.
> 

Reinette


