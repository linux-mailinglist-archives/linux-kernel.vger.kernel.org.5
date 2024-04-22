Return-Path: <linux-kernel+bounces-153668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9A8AD16A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0051C22256
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD677153572;
	Mon, 22 Apr 2024 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Luf13UlZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684E15356D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801710; cv=fail; b=ShQ6qtf/jA9WYZgqiECRWYDXIxvEck4m8Nad/hZeuhDbYqpVEKeJsyivJ4gdfVKT7Qmozqs2ef4GEJUrvKIsquM+alwYWxPhoZEdy8dxGYmz/bHFWonoFhcjor8BcXOnH0i6sjvyAHvYkEPxA3TbGgndP1oGwy46c6cUIt5u9KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801710; c=relaxed/simple;
	bh=w2uQ5ADs3fvKnHvaRAjW5UcSjJd0kW9UG45q3NYIVog=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QhM0qp/TR1X0En+asxyvUwCC1ZzkMt0NO8JkelUN9wXFVcilXTX7+wWu+gqNEod2MIHUEFVWC0Yc4Ffvf4EpaRZaNzzd08Cuz0G4WJ5mbZ6RhROdRlclwi9x6gAbVkAtLco46rPtGtJNoddxoj2Kw//OtNtk0ggtLBMUpcNzEGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Luf13UlZ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713801707; x=1745337707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w2uQ5ADs3fvKnHvaRAjW5UcSjJd0kW9UG45q3NYIVog=;
  b=Luf13UlZg8Yd2qkgm3fDT2EUEmY5Opyks4j3akJ0Oq88EilXb52jK5wI
   KudSxHPHtM8FALan7HDVC7hSroudrgVybyXkwea4XrHaKWDt/Uz54n8lY
   yir69ObnAfk2hGUUPA5LTlkZdLJZHbRlqZQDmYd0CxFmuIsfNVOkGgM4z
   WkHxNSMXpGKyyvf14G/RNH+tEpN19OBCpnaTdpItO6POE1sF0PnR55Tq2
   81r7AY6NxXmjADEBReTB71oWqK7zRjn9xMa3SsJadVowXyqEjIeIuf+ug
   SSTGkVtSC1SFfWqtI04NuFXngYEXq5VxuPt8j0Dkz+LWLvRwjHEh27F1t
   w==;
X-CSE-ConnectionGUID: q05AzBd8QSiBPCKIlu4d0w==
X-CSE-MsgGUID: BeabZTDySj6tX8e2iLqHMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26864244"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="26864244"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 09:01:42 -0700
X-CSE-ConnectionGUID: LpeKp6lURd6+nm37wvhX0A==
X-CSE-MsgGUID: PLwOAGxdRd66MRqopFgVWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24107304"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 09:01:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 09:01:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 09:01:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 09:01:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 09:01:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiNGHT6unc80rYXTm3ioac6FEgRZlP1yWrzH+zs79YRV+r9biH8tFjlxagBElS1pJQyhFWqyKOXHGunKYC651TJjTMKfwIWYUCvK+RxvPuZOZcPfohEjYpUVaq/3cTeRtjj3eSZw0NGSmflzKfNSyjTxqOJRoEFsUbh8ZCGQPe/Ea2YgxbxBgiOoNz2yX3YGCuSAFkWG2W9HXPGz8JJYJbF0tBRe7myDhVJrbbnzT3fnXEGNYzKwjT9XDQzn526rfhQVvUhiu+PcjY04imRL25y/XC0N6NxpFqUZK7rEC4ihGh+h3iRG6ZPl+5ScjMKznTNrM3U4BidntH08GMrrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn/L6IrTzUzg6rFVMyXs+WQYOzb1IAsA5Nkyfp+563E=;
 b=IlmJ9CfOYKrknm42MYu6Z259DrGxD8M7e9oIU7OxAhm17ArpLJHu9DrpVFK5m2Ubwrqj691dMOt4VVXLNphuSDGkOLXDQyKemQBkD5Tj4/GdScWYmIp/nNKE9EvF0sYuYQpiVvUeSeGQrSWepDLyTlAdqsWmClE7HxmnZ3Y7e2Db5hvRsSWMMxrHizbp5+ZDKjQXe5dpZKuUrT212INlyK2i6R+y7RH5MZKGY22ZVAtzpF9WYaZTsH54XRik6/G+74h/8mLtuEbxYAxcrnGLtOrTzbNoR+vCaPCz4dWR8k+lewS1c6qItlIyPumzYaO/jr1bb19SzuJY/zCtS1kwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Mon, 22 Apr
 2024 16:01:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 16:01:36 +0000
Message-ID: <4cf859be-294f-4db3-948c-a96b5457a10d@intel.com>
Date: Mon, 22 Apr 2024 09:01:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/31] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: <babu.moger@amd.com>, Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <ed23454e-16df-48e9-a344-a6d8baf902a5@intel.com>
 <ZiE8/oXyjBef2qTy@e133380.arm.com>
 <acce93e6-4c8e-472d-a2bc-5cbad2950661@intel.com>
 <94c3bfd0-e221-46c7-86c4-f0545e66f17d@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <94c3bfd0-e221-46c7-86c4-f0545e66f17d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b157047-e660-4d84-6d1e-08dc62e57d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlZnazU0SzZpQzlHVkpLazJFZFhHOHhYWkNuUXNTelVlVUdaaUNzWW52UVh6?=
 =?utf-8?B?U3FqVVdTREw4MDFxOGJjVWNqL3lseE5tWDZyT3lVMExVd2dyUi9QdThRWC9C?=
 =?utf-8?B?WHhZTDR6ZUt4aEg5S0NiZW82YUdCb3EzU1ZRSEtGVEoyMzA5WFl5VDVuVWta?=
 =?utf-8?B?WCtSNER0clNpMzJGVFVpOGFBMmp2eHBueUJDWXZkQmpGZkc0VUtZcUJNZGVm?=
 =?utf-8?B?OGpkbGRaVVk3eXltblRKWUx0T042eWNyenJoVmNDT1l4VlFwVlpRaXRBY3Qx?=
 =?utf-8?B?c2grZ21sZy9lNFN4cko2NStVVmw5d3djTGMxSmpVdFNWRTFoZEVMSnQveTFQ?=
 =?utf-8?B?dkRVOUQvbGVUeVhTOWFYSUJxeW1XejNJMHYvQWhNSEJNNEZQRXFRcTdUZjhx?=
 =?utf-8?B?bFBCbEJubHhnVkdHNTRlU2dJWWxPQS9majNnSUxWNWhRSE1XVVZ6OE45VFNl?=
 =?utf-8?B?RVZ2RC9LZndXa2VjRS92QllhNjZ0a2dHNHBrdnA1N3hncmxtcWxvYVRZS1Yv?=
 =?utf-8?B?L0JoMjcvQkRxTUdtSFlreTZrRCtkMTRML1I4VWYzWFdWQ0tXRys1Rjd1cjlx?=
 =?utf-8?B?UzltUDVocW5YL0RlK0lqTVltbWlpeHg4ajJjNS8zeGVzNzVLV1M1UHBIUlUr?=
 =?utf-8?B?TUF1aGVGV0VhWTlaV1lJZU94WERrem8xUWlya1BTREVMM0IrOTNtMDlVQUxv?=
 =?utf-8?B?Qks2b0QrRTl2VEY4aWdIVEtNZ2lQVExTV3Awb1o4K1NSY1duZHZPQlZTMTF5?=
 =?utf-8?B?WnlZSUtHNjFrSHNuMUR0SWJVNHNhRmxNaHhqWFN0TWYrZkFucjBTVmI1ZW1n?=
 =?utf-8?B?c0poMlhzN1N4bGMxc2pDMW9mZTdnTXFtbW5yRU82RnU2MkFPbmNCRnFNc24z?=
 =?utf-8?B?dWFTdlZJRy9PbHF5NHRDQStWWllqRXJrTFo2Wi9RK0JHSGxsT3NEeldaK0pS?=
 =?utf-8?B?ZGorRWwxY1VXMExYQ1ptZjl0bGkwWUVjRTMvb1RtZ1VsV0ZLOHNqSmZnaXMr?=
 =?utf-8?B?Y0RGYTVjQkJRVjhGcXNYYlNlYU1meHB4R3NDSXNPajNOemptVDh6VWVtdExL?=
 =?utf-8?B?bG9MRWlhRU8rSUhQUE1GYWk4ZEp0S0NrL2RCOFp0V2xzaTU0VlVnSmhyRWZx?=
 =?utf-8?B?VkJTUk1CT2VQeHl5SHF1ZC8wc0JaTGc5RGszV0loQ3Vkd3Y5cWdTQm1jRXFI?=
 =?utf-8?B?Mjhyc3NkbWVJMHpNcWFEMzZmV3A1ZTNKLzBzOTNqcWpENGxYRkxPZ0pHd3Iy?=
 =?utf-8?B?djZ0bzk2blgzVHZaTVJYZ3JZUTliMllIOXhsOXg3Z2I5UmVvY3VQM2p2NU1k?=
 =?utf-8?B?REJ2R05TRlBtdERwUUV4aWxmMzMvYmJCdHpPcTN0MjJtWkFucnBiMVg4eWJW?=
 =?utf-8?B?WUNhVjRmUi9BOFRsbGNOZmR6c3JQbW1nRzVwSWtkRFczYWhDenY3TmhCVmFx?=
 =?utf-8?B?OE9Yc1hNQ1RBTkxOYTlRdHFGdUxmMnJQTHkrNEpUOXg5ZHIrRHdUd0VxOG1V?=
 =?utf-8?B?eTE1WFdzN0tLZjIrSENCUWpBUW9SdlZrcC84STVVdkhXNGZ6c3N0aWtGK1B0?=
 =?utf-8?B?MWNsRW9ZNGhVRGRSYTdpUkdtSGNwdEtpS2UxRE1PK0NGV3J6N2VobTNWTmc5?=
 =?utf-8?B?UTZQNEFidzkyTWJQSkY5b05WaUFpSUFaQ2V0Zk9DQ0hVenVtazRSRGJHb3Ev?=
 =?utf-8?B?S0dTLzNQRWtndHBhYStZblZKQVdDYysyRVZvRlFEZFhDRXY5UnMrSGZ4blJZ?=
 =?utf-8?Q?XPOPBtc9DXIJK+33lk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW9PbU1zQWwrSVhISXc1N092R0l6VExKeVM1amUrQWRZem4vcjUyQzEweHhK?=
 =?utf-8?B?VFFrc0lqVnA3SlFiUzh5NlhNY2RpTmsyN1NoRU9zVzZOdG42dnBGYkNaNGRL?=
 =?utf-8?B?QXZRRU8zYUttWWpya2luR2F3MnRTTGNNeUdTb1pyci95ZjV6UHNmYlN2czh5?=
 =?utf-8?B?djNnak56cGJwZ2laM3dGa3hLY2NRcWlnTWQveE1XQjYwa2lzajd3VVdrRWlK?=
 =?utf-8?B?Ums0WUhBbGRXRWZ6M2c3SmRNS0Mxa1lnZjM2T0I5cmVNeVN0SkQvZHpVSHJw?=
 =?utf-8?B?MUxlU2VKZW0wdzhMN0NwanZSSVZQNE5EU1NqQTcwWDVVQ0hBOHBVa2NaeFk5?=
 =?utf-8?B?S1FJMmUwNEtRTFlpUllhOUh5dWh1Zm9LTUJyMEZJeVJYSUR1VisxYmNhNmZa?=
 =?utf-8?B?NmgzQXM5TkpJdkZRTWFuMEJVZnpmYzN5eXpldjNua0lnc1RYVEwybXV2azlI?=
 =?utf-8?B?OUxFMlZoaGU2c3hzSkVKVHVHVzJEMWUwRXl2SFlpYzJadlpZZld4cGdLV1pU?=
 =?utf-8?B?L3Z4a2duYW9jMDR6SW5mczFxYW9ZVDVDK3RNbThpNGdpcHE3U05XbFNRNkRJ?=
 =?utf-8?B?WWFtMU53SzR2L0VoQVFacVpweERYa0d1MW5TU01Oa3RVdW1YdWE3NFM4SEVl?=
 =?utf-8?B?WUM1bk5NbTlselFaai9UbXpGcGw4YVorL2ZySDNyeWxtdFR6RjYySUl4UWUz?=
 =?utf-8?B?OE5YZzJRYlY4czlXR3B0UlNyZVNnODVvUERLM3VuSHZWSDh3K3JGNDlQdWha?=
 =?utf-8?B?d0o4a1Eyb20xM0N5RTcwa0RNdlBHRWd4b3hLejdJOU1NcGtyQ3dHQk5pcUps?=
 =?utf-8?B?c0pvSkp0RlVFSTFVS2VHcVp3VThjVjRrNW9rTHZRc20yWHhGNDQyZXpKNWVW?=
 =?utf-8?B?d3FINWtDQ25FN0FFT1FURmxsLzFSdk5Pd2tZQWd2akoyUnFrR3FQNkplRVdB?=
 =?utf-8?B?MitweEpOYzQ0bG9RMFhGa2FkMEFZTklRYTc5MjZIK1pGR1pGV1ZuSk9CakNI?=
 =?utf-8?B?SWFXWklzeTBjaURnN2pRSzdkVzNHN213NHF2SUhCVU1la08rUEtqYzRBaU1z?=
 =?utf-8?B?QW5WMWE3TVdmU0ZzdFBNZlV4dE82ZUMvaUJpN25uVEpGaklQZGJJVUhaZVc2?=
 =?utf-8?B?S1hseXBJdFBwajhCeVlMNHFiWko2eUVqTW0zWkNBN1FXZVQ2aTg3M1dCZ2t5?=
 =?utf-8?B?VEtXRVJVaVhhRmpLSDk3b2tIK3NHV0EwZDlobjJqU1lKRzNoa1FSQ2hsZy9q?=
 =?utf-8?B?WGE4YW9aek1mTUNIQ1dkSkRIZUY2bHFsaWRtcmZROGRQRk1FSW9zUEhtL2xU?=
 =?utf-8?B?bDNPV1hWZEdtODEraDFmM0dIOE83VkVWVDBXQmJNUDB0KzJjQ25nRG1Mb2sr?=
 =?utf-8?B?ZC95VW5JMWZkbUI4S09Ia3NaZ3FTZ0hHM2UveTFlVVA5OGQrL05RdDFJK2pH?=
 =?utf-8?B?dG0vZzVMdDNMRjlUUlpSRmowcWM2ZXI2U0xwTHFVbU0vaTFqVEtKZzNVS2k4?=
 =?utf-8?B?WEViaGNldWVVR1YrRHVOKzlEWkprVmIzNTVQdDkvZG5Kc1MyNTJuWkNEckZH?=
 =?utf-8?B?VWpCckVYZEdmbUh3anRqRXk3Vko3TVJjSUtXTzhOVGFMcW9sMmtiREtBVzJi?=
 =?utf-8?B?b2FNQUoyQXhpSzFrM3JWQlhPUWpNa3VWaThRZ1NkZzU1Qjh5cHVmSDh3VTNn?=
 =?utf-8?B?dGt1ZmtKL1h5c0thZGFCOHE3ZDBUV0NHT0ZqMzQvT1dWV1ZMMTFTcEtRZTJ6?=
 =?utf-8?B?d0N2cXBGMWpFSU9ralhqTWhDZGJQdVExdk5xNWVJbmNZYXJWVXZzeVVOcUIw?=
 =?utf-8?B?MmVpd0U4QzBsSkIxNm5aUjk1dk9UZDl1b3YvN2tXUGFIeTQ3NksvNXV0U1M0?=
 =?utf-8?B?d293bTR4RThTczBhU25QQXlSbUl0aWlzL3NGOVNkd0FVdncrT25jOHBRckNW?=
 =?utf-8?B?RDIrNFprZmFSK2s5M2x4N3JXTy8zejB6bHdKaDJOYUljQjJtZUM0YXdzSjJ0?=
 =?utf-8?B?bkVtRHRNaThhWWtrNS9VVHFMZEVpWmZEZ0JXM1VRNlN6NE5FUlpVNnR6Ny83?=
 =?utf-8?B?QmZYRVIwWk01cWhpUTNEQVFZU2k5cmdrQVhhUW0yTnV2ckIxSlBJeE52YWpL?=
 =?utf-8?B?R1BjelZVSGx6Q1FSckVWMWdKOHVLWE9sSm9nclZUYUs5VEwvQUZjU0gzS01t?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b157047-e660-4d84-6d1e-08dc62e57d00
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 16:01:36.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F82+FDbk53+eMQVN9FyX+GUonrYBv4/eS/ytByWBoNMtUz+2xCrBMWutpyot1SttgBjpFmQc3Y6lmmmCn2+vvXu7ASzhJrfvuBXJiX/cL+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com

Hi Babu and Dave,

On 4/22/2024 6:51 AM, Moger, Babu wrote:
> On 4/19/24 23:06, Reinette Chatre wrote:
>>
>> [1] https://lore.kernel.org/lkml/cover.1711674410.git.babu.moger@amd.com/
> 
> Do you have any more feedback on this series. I have few feedbacks from
> Peter. I was planning to work on v4 of this series.
> 

Babu: It is difficult to start drilling into the implementation before there
is agreement on the interface. One reason you went through the effort of
the first few iterations was to accommodate Arm's use cases as we understand
it, but we need to hear from Arm if we are on the right track here.
I do hope that we will hear something in the next couple of weeks. 

Dave: Could you please check in if the interface introduced [1] is something
of interest to Arm? If it is not, we can proceed with the implementation without
trying to consider how Arm may use/need such an interface. If it is, could you
please let us know when we can expect feedback from Arm? 

Dave: fyi ... there is a similar scenario with [2] that aims to address some Arm
feedback ([3]). Do not be deceived by version number of [2], which is categorized
as a "new approach" aiming to accommodate feedback. It has a long history [4].

Reinette  

[2] https://lore.kernel.org/lkml/20240327200352.236835-1-tony.luck@intel.com/
[3] https://lore.kernel.org/lkml/88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com/
[4] https://lore.kernel.org/lkml/20240312214247.91772-1-tony.luck@intel.com/

