Return-Path: <linux-kernel+bounces-128957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A6F89623F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551D91C23720
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00B8168DE;
	Wed,  3 Apr 2024 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7CyeRN0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2414A9D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712109482; cv=fail; b=kN+W3tvW75yVqH/RNFdyxwSCB+kQ/mWIHDVmvm4f/jmt5FpWhKzYZhJ9UZfn93FzL7LR6ZWoqGscGFhHqky3ZSIC5kZVJDK9SVnUklFbOsMMWutQw2b3xTzVYeZP9QVnz4e467VAX6udVfkpa5E5VFRVsgT4Iz1/fsDC36GOmuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712109482; c=relaxed/simple;
	bh=KMVsjQo9ATKnGReLBK6l3BMyU4EUuXizDtS3GiP0Ots=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VT/01jdtYOR+k7Wy/ObeyP17NnDTSid0ZpR09i0z5ypQzfMsZN+O+dU3VFuHjvbdJV2/gGDjCtUU4Vkgs/ROWrNycMqOpVpPT+8nfERJ29Hsnh/LC/JfmjdEVWsq2s0+1R7TwKQ9GQ2Wp/d8W5QMUUi/dNGeq1i7OHHRGMNCg8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7CyeRN0; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712109480; x=1743645480;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KMVsjQo9ATKnGReLBK6l3BMyU4EUuXizDtS3GiP0Ots=;
  b=d7CyeRN0zb6+VzwoNrwEUj05hlQ3JnIjeyGx/GK2CdTOGoY68wGJMeJe
   sSRGKm2xAAyH5LM2vyV2WX5O7DsWKO4MQQz5/fbJtruz+zxF6FbE9ng/D
   J1BEEP9ogXBTb8IWzDwR0PFcmPjLD4/z6V6JqbHEenrmFA1eokGuv9pUO
   IPhu4hTJwijP1CsYpIJfS/jkD4GaJlMS/11GseB69LTOUHxIGb5Cp5BV0
   ci6JYwKBvwOQhHDM8v0BRaNl0nuxL0vVaInwJpuVVgF4WiNcVjdbG6Snw
   RnBhx0YisYHzT16n1jdIjmszKiSflTzRcZqpPkWeW/k+Il77EV+75ykVH
   Q==;
X-CSE-ConnectionGUID: t9fDCC9QSA26Xpbee3mhog==
X-CSE-MsgGUID: AvdX7rB8THO90TeaUAlanw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24774519"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="24774519"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 18:58:00 -0700
X-CSE-ConnectionGUID: TCWG/R4eSrqU33D4Bpjxxw==
X-CSE-MsgGUID: 5ib7yxBuQBmqgcjUXp8Akw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22731469"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 18:57:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 18:57:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 18:57:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 18:57:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9i1RPkp1tS7ZSFTGfcZVqBCjIXhkDWSwjo2nl+y0SiRlyGLDljIjvmECL1Bru98zOMZmN4QnyiP6XDHEvJv90VEGd0Cno3vLn5VDcn50trTmD3iCYCTFOt8kA3SdTlBZALU1DTwHOsb4r4+VPIjEozy9Wt8Pz7RkO4nz0wU8gwzJDx2WfY2KrLtdgnVWXBH28NSgag1+lMBsDu2LZo8zncp6iFuM7Jy9wET+2iL2VAbqYNOkK1w1gpQkttiuGAeVE1E7BLmTvrN4nOwKU8Zrv2h3AfdAsK5LFV+Hx1WfBl5U+fxHFE67cPv/CkG1Mi7BpYYmYjfHUtgzZpZoOf4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sAb0CHoQBLrvGidtDG3vaAQTXgXew0U7FWhONcQw1k=;
 b=YPA5YCQ5fj5Lglr3KLeVbPneYqtecIG0jESOopustcPZUa/0rj0ReYvnjmgwxdVyKR/n3VJ2UWgeyt0BgVUm2EDEDhSNy71BsaHg7+uZD3fUcA5J2DP0AeK60ZS/kT5CoGqJru7g0XtbPHuao/dnDb7lK4s1w6sgAIxzrTZiZGRCzkSzb1VWkp7rkwAzbdfyC4Ve2SMq0ysC/5fAFNyCvWg/YO6YvsnGtZvmILLFmDjyZGsPS6nkEv2nbWHgGnfvYJaCfu4N3SOSWARq1ZF4GH7bY4vXqpnbIh08M7V62GLC4/7KXJU3SppSuieSTfQRH9BGiLMH3hfe5f1EYTT2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7746.namprd11.prod.outlook.com (2603:10b6:930:86::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41; Wed, 3 Apr
 2024 01:57:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 01:57:47 +0000
Date: Wed, 3 Apr 2024 09:57:38 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: "Paul Heidekr\"uger" <paul.heidekrueger@tum.de>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Marco Elver <elver@google.com>, Andrey Konovalov
	<andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, "Andrey
 Ryabinin" <ryabinin.a.a@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>, <kasan-dev@googlegroups.com>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [kasan]  4e76c8cc33:
 BUG:KASAN:slab-out-of-bounds_in_kasan_atomics_helper
Message-ID: <Zgy3ksqpuz4WJl5x@xsang-OptiPlex-9020>
References: <202403310849.3bb9f3d2-lkp@intel.com>
 <ZgxB4PZ8N6QjRqLA@FVFF77S0Q05N>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZgxB4PZ8N6QjRqLA@FVFF77S0Q05N>
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7746:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjwGKGh1W0e3n7++NsoyB11d+bvdBE4fSQGhJ9ZhFsOzp0YK1EIT6znpIhS6u5+IS26b79LHjRgqVeWSydzLkr+/DONAPPvV9kuu4zsUVaa11KZRd1M/bxFORbo9oxp4+OXvpsfJUu2GUBvbYJVf6PKYyCIMCCcWOHdMIxaU8rlk0UEToWGd3ovVvGfLW5Wej6XGd3BcSeDOKru5UvnzOSPOYBDZR91L5v6BO0wTyg/6H8nz1H/Fly9T+LIhuURRSe9SnlbHNcoRckh6sywrfDfVgGUcxE/hLK7BfCslXBpyph0Oj7+4DoxlmgSuC8erNjiLTA4WghUgs8TRo6CKQ8r5HlMEWT90onW/z2qlQUJBekJv9s39Z++LwSV8832om3rn6JC5Pfit7XrggAL9fVniuDj6Fz/WDeKT0g3/QkyQxzBs68m30bJsMCJddTTsv3pXPUvvQSLiH6kOOK2lmeHVDUAMn4RIR7CGuJWEddXJYw2wQw/zeLZn25lLGFqMS2M7gm0Dn2nERIdKzfMpROFuS6wrM4OcbbI3RQ1JTA7La+5Tn5NAKMJIBTFk1qtbpXBIZZx1bKhKBZjtsb2/9qCGM1OOMLdcRnYMzF4x9wY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aaWtbLBtgzKUF1LU2UmriOxFeovADlW5w/OvjV84cReedOeUR4dUS2XIoEGV?=
 =?us-ascii?Q?FpIdEuobImhR7y+fuHfQOTkeAoTWxeG0NLmeuwn6VV40fhoK6aFg82nopjoI?=
 =?us-ascii?Q?BpOhIyETcTHcwg9kVPXNq2xCH74gj4UmgIXNpyAam6hhG3Ka1wtr72jGt/EQ?=
 =?us-ascii?Q?gf+Hj8RGqvmAIymMI+/2R2kluExZ/DoigXOOfz3d+wiefatF3pgTIXuU/lHq?=
 =?us-ascii?Q?PwoMoVL8OKAT2Pvr/6o77joVPidPUwE4Yy+yrhV9XuDWhWtmq7O544SjSM63?=
 =?us-ascii?Q?LeqiQ+2n63p0Wgw6+9EE0QdW9Zbu+Al6iAYF3Y89BaAMtk/TuePRmH/l1Z5A?=
 =?us-ascii?Q?sl+Ofh/b35FSntC+9lTJ73QsKfCukck7lVGUB6hFYg+O5ah8nBqkqh0Y0reL?=
 =?us-ascii?Q?temuWU+XkrP2o/u+B+VZ1L3Cf15ICaeB095QnlABAe7Yowxhw3wyPkBpZliR?=
 =?us-ascii?Q?UpDqKCF2MfxVlWQ03JIbS8m0vNjdvMqyc/NnL9Um6SGhxZiMy0+kopua67po?=
 =?us-ascii?Q?DIxyZKHf+Fc28sdFGuVywFNlSDYh6q4YeG26zcYLfx1bgyEphAzCzY2VOZOZ?=
 =?us-ascii?Q?9bgR+Up/lEUe6FiTwaRnJ3cEMUPUyaW5uQFdzLMHwmq2i2Jbd79eWzrg3QQj?=
 =?us-ascii?Q?HKcmD50ZW+plWfFAHUvylDgwyTvNwtS8wE7F6h9eMzbytM0Sv0Po1dX1PWsI?=
 =?us-ascii?Q?n2FAu1spMed7EmH0cc6opTiv7bE+eh4JiFLw+nnqh2UUAQvxSSLv5kWYLa2Z?=
 =?us-ascii?Q?Ugpz+y5YCkVicX/4aoXeUrtnMJkfcwIQ4x9hfZcId9Do5sdHKrQi/TqSmXKH?=
 =?us-ascii?Q?4NXL+QVQ4iOZXKmnJqY1Y1MuVsaUf6dnvjfDydLn2H5lIVNJNHyPwyDAg/ur?=
 =?us-ascii?Q?ZPuW8PwRrhD5sAti0IKmpkn5Vs80SSSx7Zj8czxlVw4fspcNfd4JXAIXIF1y?=
 =?us-ascii?Q?A1NtKuoOKgbJFGZKwWPaLXcLJtbJ/06HVW6GXq8CWkN82F4imsj04JKzzT8I?=
 =?us-ascii?Q?4PDuQS1WOjXo6yvZKsWABJi9+9CcdA2VB7qLfJ4on7/1nno4A23GrFblmcwx?=
 =?us-ascii?Q?4aF4seeIUAmVvfwMg+hCTd6b4AGtR1sPGuQqJ6xghdLXdXC1ezuWdORq3cv3?=
 =?us-ascii?Q?55WzKtbQozVb/3myUXaJYAem5Ee46ZeEmJb0LYXZcvAm6VDm7MMcO+cUOHet?=
 =?us-ascii?Q?dqcCA4xw2hKQhYQOrfROthNL7sMDG8aDuMcPrwoFsh9bdJcEf8ez8ohapLst?=
 =?us-ascii?Q?uy49pLs+WMERAf2m3VSr5I5gyx0XaLhOpPmGzvwLQe7a7uFKt4zkGzPcdarO?=
 =?us-ascii?Q?LmZDRzUgje4c6LJ7JI6VDiAwZBKOf58N1sC8qQGaL25dXwqhCO+n5yhe4hqQ?=
 =?us-ascii?Q?NyKEDfVg+Gy2foyOVZtHiyf9nKcOFnH/xKAtpjMOvtte3Dmzf+klM9LXiJuY?=
 =?us-ascii?Q?BdEC0C7u3GgTjWBWOgElvsSlsdzqyhT8v7wqSZaZ1nZOgITP+qRztVhXMSvB?=
 =?us-ascii?Q?UvYix9uxkWlXR30QZMHwtaj5LSH9jSSMUaGyTGXOG/JBwJDVhRmY9jRh38zt?=
 =?us-ascii?Q?dM7urPYYu96IjbXZh8BhBsYFbqt378EMD+WAeCo9U85KVs44Kzsa+kzPKmvY?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 213a6f5b-1a38-4cde-e92e-08dc538175c5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 01:57:47.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucdBrdXHFxE/kPpCBBI5BdhlE9VDKWOOD1PCjhfNBZ6b3JzDyLRl3ZUEBvVW+i0sX+NLvYjpwnuBtMp1Aq37eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7746
X-OriginatorOrg: intel.com

hi, Mark,

On Tue, Apr 02, 2024 at 06:35:28PM +0100, Mark Rutland wrote:
> On Sun, Mar 31, 2024 at 10:18:17AM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "BUG:KASAN:slab-out-of-bounds_in_kasan_atomics_helper" on:
> > 
> > commit: 4e76c8cc3378a20923965e3345f40f6b8ae0bdba ("kasan: add atomic tests")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> This is expected; it's the point of the test...
> 
> Is there something this should depend on such that the test robot doesn't build
> this? Otherwise, can we please avoid reporting KASAN splates from this KASAN test module?

got it. we will ignore KASAN issues from this module.

> 
> Mark.
> 

