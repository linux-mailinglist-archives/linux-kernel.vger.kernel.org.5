Return-Path: <linux-kernel+bounces-136173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3E589D0C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F8C1F2507B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6C548EB;
	Tue,  9 Apr 2024 03:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHA2iC48"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B054773
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632407; cv=fail; b=HQAnyw1NPOgn2DGpnWWx9y1XsYTB/9m4kY8GsscC08nUMSkGFxpzF0bmpGD9U3130X/BQFqCEt5O0HPKOAYy+guaRRSYL17K7uMG177TxMIHBX+6+Kd66Ef33ga2nzxXoohdsNWWICeCczISPMEdPtb8Is3f5X2z2hSfmwOPOCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632407; c=relaxed/simple;
	bh=yLcgULLiAe8T4spOByCHyQw+whz5RF3nQH4ruIYoAW4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uOfpC+CUDlEkPk0HAYHU3jBvKHdu33QY5BisS/l5pcSnzEWXozxmUUsa2TvOPBmoudXGATbO/cCOXLlAhn3vcyt50WcYYW9GExmF2679oeq325sEz3JnDymhqm8VKMNjGZ1eNdbaKzB0VEwOG8yzpHBxLtSvxZcn103lWoXsArM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHA2iC48; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632406; x=1744168406;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yLcgULLiAe8T4spOByCHyQw+whz5RF3nQH4ruIYoAW4=;
  b=aHA2iC48sOQJC70RZpbQ3NBs/Xo4m7PwdIMo09uhaRm9w7YYJLCIWXPN
   v7NoQWqlFD2PYpivwZsaMIfbA75wLFxoECOb3JfxPPmbHFDgrs9v/nRpI
   8iZPtx/wm19Q/jv6Cu7vCJoKgGO7numgXuqa+NJUAulWVd8DMOV1whqVm
   GPLo5hDaSqU9J/wjLpU5MUSI+AAlh065Q8j6Uo8C7dKNuLhsMm8xwBw8l
   DDX1W1D+mcQeJi8OsY/QDwiQNb1O+x6zLIwf19Jzmo3lePvYXbuTggm6W
   jVQqDIlmLWHqvhZYmSOXgSXEYBo0Yb4hP/8MJOQXpxB2J3IM4t+WcAPRf
   Q==;
X-CSE-ConnectionGUID: ukgsgS2cS0i43XcxrT1rfA==
X-CSE-MsgGUID: vgkIaOAHSfuyc06dAQSQoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7798882"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7798882"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:13:25 -0700
X-CSE-ConnectionGUID: t+QKRBHHQtuslD6DydE3BA==
X-CSE-MsgGUID: npEFXyiER/qpGXmIuxo/3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20207401"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:13:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:13:24 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:13:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:13:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:13:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRYKimZLq+MupHr5N8AkF6FQzBvNa793lo1gVyQZdox1mpQlUBlFuDwQ1+zxCpIdfiTivqkZGHRVvdEakKMAPjVvd4EgN5ZFE7e9RnVhA8MHxGQ2727CcymqEAFqnuTMAqV+FeZLlAkhgzuBoMUvBkSKHPH29h58khYSrIzwjtMbGUCAACoCOrVJMVZYaraZQAqCuHhB5AFDCsbDH5hzb8ynvDnopFcbkWhg0y/+pv8j8R4zEcPg2hszLMpFkWt23bUwNYo2UdxiQG6vpsy6t3EjsUDzbRH11AQY71V6UhMBDakIBaulQLqTpbJqimY6pDTmX2DV9LRfDwx3kxNSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EAsMm6ZdLeOcybfTJg7JRwS7Mssr+8v/TIEncA9FrY=;
 b=mGv6RjzbjJPHrD/kw+te/rVqMN5VXSsxuVGFKJtaASszXwBrZkbpjt6OwMBf0c+QlzLkfPageX/aawRsczdfbA2xFIbLoe6BbvbIoOG4mCRS0sY+y7+cP9/F22L2gHVishzRf1xYNmNAEynxUktkna+l/9wxvLFJ106DGNtqE+mVmbTJGArpHxhIxU+h2maCKFzQ8DEZ47dolDD4umuGkKRZ5Y5NsQqwh5m8S0l/kIh6AnTThpMYBV8kvXXVZsZG8wqEw+NEeJHtOR32Wfo9IgtWRwJJXtW7oBr0fy0cbaFjNIF/g4lsJ3Z2aGINzwy+DsrOYTTVJ7pX5jkIrGNtzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.23; Tue, 9 Apr
 2024 03:13:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:13:22 +0000
Message-ID: <ed23454e-16df-48e9-a344-a6d8baf902a5@intel.com>
Date: Mon, 8 Apr 2024 20:13:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/31] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
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
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-1-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:907:1::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4783:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWpalm9X9zP8QdDoT4IZ7zqkn6vddW1IosCfbINKsGnWxWmhO4wMJuy2J5ANulVEfyTkSmVqY6nhxEXyioi5mhH9cuAl8UHFQF4QNtgfGM2Fvaq9XHwq8J8O0Ra7t3ccLBpCKF5MqQhZfnfdeei8w6jORooIVMiK3fe1X3Sgdp6guj+UAAFlVQie9NjJTKlEDbFYve04Km9k+hG9wmM6H4WKu22lrqIfpynUkAsNbq2t0yfnyHnSoZ6HsSXvE0kG0Cwvvb5bcIMT6KEXTMUBACRQmRKhtAxqhYcEihvang2/UApekndMBJ1W81cvkjSPxF+Vp7a9qqfugNmKQZo9qf78CmxgKPAh8AMARQucOgDn9cTbFO/KM3UPOImzfY3RYIvReeDJ1hWf8cY2YCqmoQ5M3IDeHeMcBZOqVBbvUbOcEeMO265PuZyZBMZ6gh9D7Q7OjxAaBH5BixJ8q8NB25HUk6WBSqfN8ivcJcV8sL+vp7tGpcLIgDGPPfPLSMPDs7gmAqLlcz4AyQwety5GCM3bOTZFClR+YCBJ2le+jiYaAlIQEzPOs40SETIhox8wgZm7Zj1VxutmveHgpxfjs0GUbKkKwiLaIep5lqBylztfDV/b975WNYqD2vo2LBp4PZJi8nM+/Tz3wI635StNXgCyQHDajZSL84bzxc9VvBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGcyUkR1enVzd0NLWWZIYXdlUVQvZm9YL0xMVUFtU2lJS3ZmK2FUa2draGFW?=
 =?utf-8?B?SHliSENoRkU0NTUxWXVMSVFPTFZPR3ZzeUJHb1J3NlUvNFZPTjVJNWJXZVFi?=
 =?utf-8?B?clUvQnhGMm5UT1ltOWZCVWdkR3B1T2VBRmRWZG1WT3Q0SkZ2c1Q4Q1R6M2p3?=
 =?utf-8?B?NTRvM0pDSi93MFo2aFV2Y1hMUVlsQ00rVHVuK2dUVnpiaS9WVDl2aVdkQkMx?=
 =?utf-8?B?alI3TzV1YjBLcjlSTlFROEYxRjllUmVXMUtTTitTbTZhNnZSVjhSL3RYUzhw?=
 =?utf-8?B?Q1NGNlpuY0RCMmxqTndNTzRvdEJQZFhBWkg0RExPL2Y3Z0l1WERHT294SUVB?=
 =?utf-8?B?Ykg1MzFCVWtMUklxUTJBS1FLTjhiaGVhei9kcHUrMXRIaTBVT1FGTGVDWkVx?=
 =?utf-8?B?Q2pJRTdwcTNkaXVwdlo5M0g3aW8rTUZ1MHBwUm5RcW5hanBWRkpjeWxhNXB1?=
 =?utf-8?B?cGx3ZDcvK0RQL3pVZjNWVmdPdnFoczJSU1F3MFkwMXJnODZqbXVNTGtXdWZi?=
 =?utf-8?B?V2NKTTN0UHFPOUNiQ1k3YURrRC93N0liRXpTNGgvd0tNbit4UUtqajl0Q1ll?=
 =?utf-8?B?V1luaXFESHpVNmJaN3BQTUhENmFCNlh0VGQ1K0R2cEw4TVJ2d25yOVQ3Njc5?=
 =?utf-8?B?RU5vR1VMT1pyblkwQURTZTlmVkdNOVVOQUc3WVlvWEU4UExyS3V5WGM3VjU0?=
 =?utf-8?B?L3c4QUxQQ25XS2dvbUJOdGZxeTFEMTRDQlIwazRUME9rbTQ3ZEZzTy90VWNo?=
 =?utf-8?B?VmxVbm1YL2c3Z2dsRE4vdjNwb05Ua2ZWTzhKK055cFVIRStaa1pTTkFoUlA4?=
 =?utf-8?B?ZjY5QWg1SXlkOWZlSStoNnBuQVA0TVhHVzI5WGlmaTNvOG5rZEdlcklxRXMr?=
 =?utf-8?B?K0xLRVNTQ0FBelZqdWh5QXN5K24rWlgxZlQ0NDB1TFVuN2xrYXRrNVBHa0hK?=
 =?utf-8?B?NmlDbms4MXg1MmhaVStOdkNSbzZCVXNjQVlOVnlnS29WWVZOQmU2UmRVeDNV?=
 =?utf-8?B?Y3N0L1N0UVVjVGp6Y1ljV2gxMXFJeHVpRW41UVgxRzRmZjFnMFkrSThLREVm?=
 =?utf-8?B?OEtmMmQyK2x6UmpnYVkwQVk5bmhHOHRCL0xIQVlTS0NYcUNaSUN0ZE1Ya085?=
 =?utf-8?B?QnlQZURSeUMrYkhyTGk2MCswODRwWUxaZDNYMkJ4blhJdVJqdzB6Y09NZHJq?=
 =?utf-8?B?bnZQTTVYUTFnNUdtT1Y4UytYb210Uk53dEw2VC9GbWdrSEx1WDk4aGQvZHhB?=
 =?utf-8?B?MWZYSzhqcWh3dk1aRGRMWWxsdTN2Zk1aZWN4K09Bd3V1ZkRFbXMzak5zdmND?=
 =?utf-8?B?WEdkQ2gzNnlLSm1ENVpvOEhWN0hCcS9mcCtLZEdHZ2xVU1FyK3owVWt3QVQy?=
 =?utf-8?B?YXczbzVXUFRLTHZpaGNZTDA5eW9zTEhYRDdvTDRmL05RUXJRY2ljRlRESWFW?=
 =?utf-8?B?a1dkQkZuMHBoMm1LS2lzbGUvTzFRK2dRUk1kWExXUFNLN0JxdU5pVHFuZXY0?=
 =?utf-8?B?VDBSbUVBWnk4VitjRWlTKzBPVjJwQVhUL1M3cE4zK29wMmVOSUovVGFFeFJX?=
 =?utf-8?B?d283M21xaENzbkxxTzgwcmVnclZHL2xycmkzWjU5eHF3TEp3c25LcllnUEZD?=
 =?utf-8?B?NmZBVWkrZFdpdUNaSW85V01UeFhmUXZxSXBrOWhyVEJUWEVzdG9BTS9aYU12?=
 =?utf-8?B?cWNJMHo3K1VPSDl5M2FoK0pZeEVWVU95d29udCtKZzBYcFh1UXFjbHF4T1F3?=
 =?utf-8?B?ZXRTRFF2L0s2MHFaQSt2Rm9hdm16V3ZSRVBkeFA3a3dzOERkd0JvMlVqNFRI?=
 =?utf-8?B?eHVsckRYeVpwQjVjNGJ0UjMzczV2Ry9LM2lHZWJpQjkrcVVZVGRKejBjZndt?=
 =?utf-8?B?N2hrOUtkZnp3UUxHUDRkV1VobjMxOFJ2NHI0NTh0b1ZWaVp1bmJ2OFR1eThD?=
 =?utf-8?B?QTlHSlB1dzRrZ1RROTlkT1M3Y0N4bEtsL1FENnB2Y3piSmp2TG9vRGZlNWxB?=
 =?utf-8?B?T0ZJMGRNNFhmbWtHa00yMXZZdVYxUEJGN1BwZmp4bWtyWmxYNnhKU2YvZFFG?=
 =?utf-8?B?eS85WDdjTzY1TlVSTnZSV0phVnJSeHVLZXMrWk8zZFV6Y1RsWmFZaVdMYlR3?=
 =?utf-8?B?ZkhyM2hMSHduUlQ4VG5NWVFRRlRLc1dsY1BNWmtaR1lveFl5dE5obVh1WGFQ?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 620aa439-6d1d-43de-20f2-08dc58430366
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:13:22.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2LDD4YA+llG/Y/7oFKavnBXJ2SR6TrOakgl3ObjblA+JG80rr+Wvt6PTnAERn9OmUEKy9nTU9i1x9jACE0yY3TLnPLYXo0Ja1r7IpTcHnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com

Hi James and x86 Maintainers,

Please consider the file movements as captured in the diffstat below:

On 3/21/2024 9:50 AM, James Morse wrote:
>  MAINTAINERS                               |    2 +
>  arch/Kconfig                              |    8 +
>  arch/x86/Kconfig                          |    5 +-
>  arch/x86/include/asm/resctrl.h            |   45 +-
>  arch/x86/kernel/cpu/resctrl/Makefile      |    5 +-
>  arch/x86/kernel/cpu/resctrl/core.c        |  119 +-
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  506 +--
>  arch/x86/kernel/cpu/resctrl/internal.h    |  433 +--
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  813 +----
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 1126 +-----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 3929 +-------------------
>  arch/x86/kernel/process_32.c              |    2 +-
>  arch/x86/kernel/process_64.c              |    2 +-
>  fs/Kconfig                                |    1 +
>  fs/Makefile                               |    1 +
>  fs/resctrl/Kconfig                        |   23 +
>  fs/resctrl/Makefile                       |    3 +
>  fs/resctrl/ctrlmondata.c                  |  527 +++
>  fs/resctrl/internal.h                     |  340 ++
>  fs/resctrl/monitor.c                      |  843 +++++
>  fs/resctrl/psuedo_lock.c                  | 1122 ++++++

(sidenote: James, please note typo in psuedo_lock.c)

>  fs/resctrl/rdtgroup.c                     | 4013 +++++++++++++++++++++
>  include/linux/resctrl.h                   |  153 +-
>  include/linux/resctrl_types.h             |   98 +
>  24 files changed, 7244 insertions(+), 6875 deletions(-)
>  create mode 100644 fs/resctrl/Kconfig
>  create mode 100644 fs/resctrl/Makefile
>  create mode 100644 fs/resctrl/ctrlmondata.c
>  create mode 100644 fs/resctrl/internal.h
>  create mode 100644 fs/resctrl/monitor.c
>  create mode 100644 fs/resctrl/psuedo_lock.c
>  create mode 100644 fs/resctrl/rdtgroup.c
>  create mode 100644 include/linux/resctrl_types.h

I would like to check in on the sentiments regarding maintaining the resctrl
contributions after this work is merged. Considering that resctrl will 
be split between fs/resctrl and arch/x86, would it still be acceptable for
resctrl code to both areas (filesystem as well as arch) to flow via the tip tree with
help from x86 maintainers?

How will Arm patches flow?

James, are you planning a separate MAINTAINERS entry for the Arm specific code?
I would like to propose that you add yourself as a reviewer to the existing resctrl
MAINTAINERS entry to learn when any changes are submitted that may impact Arm. 

Reinette


