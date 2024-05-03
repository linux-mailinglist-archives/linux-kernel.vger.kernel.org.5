Return-Path: <linux-kernel+bounces-168229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E7B8BB56E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48510281A40
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B4D54903;
	Fri,  3 May 2024 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhrWWe8I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C151037;
	Fri,  3 May 2024 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770910; cv=fail; b=Us5fCfUKuLcNrkHHP87CMActFrw7LvglSU1VsMD7Grs3/2kG5pdkoBtaHP+Oc8npnmEjUe2fMCFCHYtNDe5il96DKqPmJ2BOXLnFVfnYC2vyDfGkywLE/JmbGB7nYaq4+rjl5IMQbax1UECUlXsvDMFuAK9ze5F14YkU287HoW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770910; c=relaxed/simple;
	bh=d1cAdb1oYQrR/4lqvmTVPco1R+xFMVhmwDqyoWMkvAU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j4BVit6RqS7hfxLIcU2TsFV0ebdhXoJPm/0JpG3tjq6cIqbgh3wnDI2Mdbfp4uzMqhtiICGNmqnEObR3pTszaGCiQ4SPjSM5VS9LuwzyCAUnM8SmA/k1ydquxu+jxaKggi5ZvSPAYqwUdW4nTJdXNCjzqRZlA0ktBAbwI5ZICQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhrWWe8I; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714770908; x=1746306908;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d1cAdb1oYQrR/4lqvmTVPco1R+xFMVhmwDqyoWMkvAU=;
  b=hhrWWe8I3rfSXciGmLMMnYbfTnlKSsVAAebEswBxa7D9Pc3btTnDyf1l
   xpNTCkRhK9ESJEyzKcOuBxDxZgL5QMp+PU8JS61uWsXGpJlEHYK+vcYMg
   zrKRMU8pu7CAHqqi5eatxtDh+t9l7Li71knnp74TcXlxs71ue3bCB8ZOO
   KfT9331fxxDtm/j9crnfA0i2sRAc4JskhoxPF9HCidAYvR+QtiIUe1/x0
   cZBpcz9SWBbO1XGEMqtrPJjna2ccQ42+mbBilPY520n4lwJvj4671HfvY
   IXZOPpoS7GZ0FmlFmreZBdc3QV+R8LGyMIkD9KC4QX+Ht7kWC2JY89fNy
   g==;
X-CSE-ConnectionGUID: x4WfLNJkRsCJySe7OFcegA==
X-CSE-MsgGUID: hxPgNBRBQRmt0VaP1CZoCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21148136"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="21148136"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 14:15:07 -0700
X-CSE-ConnectionGUID: Ah5hR/ruS2CGH5rWgtTr+g==
X-CSE-MsgGUID: pGEe193dSRGWiX11qTYMCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="58763782"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 14:15:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 14:15:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 14:15:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 14:15:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 14:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrwypXUAzTNpFRE5dt4p4puSU+C1uto2j6Moq+HR8qb5dBSmfbrvwaHgUuODTz9XdlYgnbCCVe7zAULKxFKp0E0mmJ6Z89tmh9X5eRXEKx2Hhydu+efNuPN0QBEk46FGdAulh854FgZxozVoZttokkh0T9/f8AE5QPakfiRCQgrkHUfzUmA3YDC9i6maopjKcStHqfoCVvsbTn+eLVPw3TBHx7XmZE66Mh8RAihzFRckohkH8As8D2zjry56+8v+XW+102yN0H7+Qg+yY0KF1Eklb2IwW1b8OfMoQfG9a6Vo8XjPqg/8I8c33HBEtNy60PaJ+cHrMPBqm2v3qvo6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcZ4iT+XP6LbURJRWmonsHUbd0hlkgQeLn1XOdy1kzs=;
 b=FQcSyaHYYOhbaflLbAF9FfSr8SUE+azo4Tdsd+LgvrCfZK19cVwwdglQgK4ayjvXzuYYKhWbKtCAjDoZK1ujSBZpB9fdAHRMig3+4oVNfuY4vHV8DvqFUTL2OqGk3jS7+jdyhePNOCWxcO83LxL7WRS1mtCW7Q0638q9fFQD/0hiHb5Qg5a1qOsFo1ydwniaS7Ya03hhQQzPpwmSZNaUCBwphEEjVZZazwJdhT6/Y8uIyYz/wYDpmrctWh/2HWYYgMTlRcNzuVQpNdTTuyDgT7hnOHd0am47vr9X/ZEzrLvSNDQrnfp0GWjRs76DIh9sGlWaSKTjLVkOMhUWblZZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6218.namprd11.prod.outlook.com (2603:10b6:208:3ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.31; Fri, 3 May
 2024 21:15:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 21:15:01 +0000
Message-ID: <ea56c630-80f4-4564-beb3-2b61e810a558@intel.com>
Date: Fri, 3 May 2024 14:14:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
CC: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>, <james.morse@arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
 <b35dc4e9-7e8b-42ed-9a51-ae50d521cf4b@amd.com>
 <CALPaoChxYoJx8eR48EkSKf-hu2p2myQJLZEhj_Pq6O4R15-=5A@mail.gmail.com>
 <6edffe1b-e9a9-4995-8172-353efc189666@amd.com>
 <ab2a6a4b-3740-47c6-9443-e6bb7a0c1adb@intel.com>
 <CALPaoCiYFKeASPMDwzzaHLw4JiMtBB6DTyVPgt0Voe3c3Tav_A@mail.gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCiYFKeASPMDwzzaHLw4JiMtBB6DTyVPgt0Voe3c3Tav_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0230.namprd04.prod.outlook.com
 (2603:10b6:303:87::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a120cdc-15d2-4d10-90e4-08dc6bb617f4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEt6akpRSFN6RUo0dFlWZ0swUFlISVdQbzBFSHVUUUp5a2NCN2UzSUtxQUZh?=
 =?utf-8?B?T09yZWdYSUZWVGJPaEtrRU1QTnBQendGbklEOXR4WkhUL01BNG9uR2ROcmdX?=
 =?utf-8?B?WEhGcWR4VzZxQ283TnlrMUVBamFIKzFNU2NSM3Frck9sd3ZWaUxxb29Wc2l0?=
 =?utf-8?B?blRKR3FYY01SblFQVVJQa2lGMWlveURXeFZkb2FpakhPTHlYK2lxcUpMSnN6?=
 =?utf-8?B?Q0NHNXJXcTMzRkhOaUIwOTFMYTY4WFkvdnZJWnl5WGY4Rjg3aWhQSWYyaXQ0?=
 =?utf-8?B?elA4TkpiN2VxdXVIR0hqWHdhT3hTWlZhNFN4RU1ScmN1WWJHbTRCRER1MVZU?=
 =?utf-8?B?WUJlVnBuMnFHalZaNXp6dXFzaElndkk4dE1PTkdYK1MyKzR2R0tFeTNpRXJO?=
 =?utf-8?B?K2tpT2pKOHViZjl0bTJoU0NLcVV2VUdTRC9XNlBXM2N0Y1pnY2E2S2FwM1Mw?=
 =?utf-8?B?enJXWmp2SW93TzYxRkJaMDdBSy9ndlptckVTbE1MbEdhSkNKNmVDZmJ5bG81?=
 =?utf-8?B?OUYrVHZPcVF1UjVYY1c4QUNIMnNGenFPckM5TEdiOXByVmxGTnZOUFoxRVBI?=
 =?utf-8?B?cUlYelZsWjVYaGFuT0VFSjQ2dXBYcDZTVVZPZmVqcWtYYzgva0dub0IyRUR3?=
 =?utf-8?B?ZHdnTkRPNUNBd1VVWnJJQ0xuRVBtbXI2YTZTMWlwMW5HcnFWc0labWJnbElw?=
 =?utf-8?B?bWc5bUVrOWp6eVpMTUE1b203WlZQendDd1lzMUlKb0lpMDZKd1lWTGFyZCtM?=
 =?utf-8?B?VlA0b0FaQ29kTDZIK1NDdG8zcXp0ZXlEdjBCZFNpb1lrSFp5MkV0SHRCRVZG?=
 =?utf-8?B?cXVWMGRqekkxWEhwNnlpYXE5ZUdoOG42Qko0ZVRWNUFGWFNxeVl2SXFwUElG?=
 =?utf-8?B?SlhRcCtnNWNYRC9YUG90WlVXL2RLWFJZeUFoc2tON3k5dGV0Q2tXRkFvTEEr?=
 =?utf-8?B?MXlicEt3TzJuSWtTQi9QSWt6YnV6TWk4MURHZTJxc25VL3ZjVklFVVE0Q1cx?=
 =?utf-8?B?UmpUbXBuM2xPU05qTkNGdE9xcDY0UDBZUHY4WjNkNC84RjRuVlhqbUUyZVk1?=
 =?utf-8?B?M3BlRjJxMzdmQXJwQmN1MFFRS1ZXa2dQRnR6eEh0V1l5U0NsZzdzTFNtSCsv?=
 =?utf-8?B?M2dOL1FPaStaSkl5cjNKOXhwRDJYVDJNL0RVSFpjQnRqRjZxUnBUc3RJemR0?=
 =?utf-8?B?WStETXV4YTJTT2FXYnNSTm9ZWlcxbHNvK0VnSUVwZXR4SkVOU1M0M0VyR05r?=
 =?utf-8?B?U1FBMkd6UXRoNklGbWNJdEQveVdZOUhQUndySU9UMzBCRVJtRU1mZUJxM0Zi?=
 =?utf-8?B?bGdPSmJLUmIzYXZjS1kzL3VqQnNBVis3dDlLd2tTWFd4S1BJRGhjZi9teWY3?=
 =?utf-8?B?S2VpOUZXYU80dllJdklZdDNlS2Y2bk1WSXFNc0NaMFVHdWg2ZWtyQW1RaXd1?=
 =?utf-8?B?VWg4K2krbWRoeDJMeDZ3eGVpOCtvTnJlQ2FqUjRHMDNJMVFNMmU1YktkMnU0?=
 =?utf-8?B?eDFaalc4UU01WUNhT0lka0NpUFk3eE93aFkvUnRYdGRsbVZERnR1T2diRUN6?=
 =?utf-8?B?V1RSQ1ZHR2liOXoxUUxZYkRvaHE0M1l4UjlnejZ1SHZYeWRRT28xVFdrVDVK?=
 =?utf-8?Q?v3riVbbJdV9tDtEG3gxdWFPPdgTHya4NdC3eVLa5pbu0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjZQMi9YMU0vcjJMWVkzYXlUam1YTGdnZjViclQwR1cyK0tZL1NxMWFKaWNC?=
 =?utf-8?B?ekJReWpEaitiTWpRYlhsd2RCRGxjaFRiWXYzTGxQcllPdDRHa21xbXlpbDlz?=
 =?utf-8?B?R3o5ck1aREFQejFmbGc0TVJLclo4TW03SXd3RGp4MmRiQjZHcTRGVjduZ0Ft?=
 =?utf-8?B?S091S0NBNGYwUDBOeTVDVHc5UWpUMU80Q2wxODV3VW96S1gybUxkSHhGQ3FS?=
 =?utf-8?B?N1NhMmpnenMzY0xHUEkzRVduZTB6dHVOd1JubFlLNjErNFFMMERyTUFpakUv?=
 =?utf-8?B?czNXeTNLWDh0Rk4vWnVMaEpIM04yRjBkWlMrcGsvKyt5OUFZb1doYURrMTE0?=
 =?utf-8?B?MHdsczlMRmhPVHdVTXFSNkpCVHhwdXJmT1RHeGtXWEFZQlRxU2NCb2x1RzVP?=
 =?utf-8?B?NmJxRk5LaEU2dHl5MHhucEZkcWViQzRIQ2xJNWNwaWx3amczTUZXWVZHV0Zx?=
 =?utf-8?B?c1QvZzRQWEhEbk53aG10S3M0SkliWEJSc2pkcU9IQ0JKcXVsUnUyRlpBY3pY?=
 =?utf-8?B?S0ZiTlVQV0pQa0hjcXBNNlM1R2RVdkhEdGpkejEwWkhqZVJMQVZIVTdoakVM?=
 =?utf-8?B?aEFEelZHQVgyYXUvTmVOV0hzT2RRYmI5WGVWMXBkS2ZWUTJtWkxuV3czUHRC?=
 =?utf-8?B?cWtpcFVoRmZCNHJMSmIyOTlCSG44VUZGQnhxTzJSM0pGOHA0ZGtUZjNzRU1B?=
 =?utf-8?B?OVkwTC9rcU1tYlZ3cHpvVGYrT2hJWTBZdDJNVlhSdlRYRE9pV1BCT1FBV1RM?=
 =?utf-8?B?eEhIc2tudUo3cm1iN3V5RERTK2hmbjN4T2RqVTU3NUdEMy91c2pTVmFHeGJh?=
 =?utf-8?B?VXJaSnlXOVhvOEdFQ1FSREZEMlAwcThEMGVNbFlUdnIyVHdhRUZ0b3FYY09k?=
 =?utf-8?B?a2RpK3lDOCtzRlRMSXBQSjAwQUFiVVg0Q3JCYVU3amtLRW9RaWZVWjc2bU5U?=
 =?utf-8?B?RFR4SFFGeG5vODgzYjJQQXcxYklUdkRQdlN5WXgyS1BaYlhiRUZRcnVSNXVt?=
 =?utf-8?B?NEJSSXI2MHQ4UmY1UW5vMjVwSUpneW0rb3BqQkIzbk9HeHhyRTdTTXpEL0J3?=
 =?utf-8?B?TW1jRFZTbzhWRVZjblh0SVo5cC9TekhUVjk3c3NrcnpFSG1mbzRXeFRVQWs2?=
 =?utf-8?B?Wk95aU1KTzIrRVNCTDRmNU1VWE94N3BmeGhwS09GR1M0QVMycjRhOXVyS09z?=
 =?utf-8?B?anB3TkRpOTJVejFnMk9nWC9ieWZwU3F1UjVTZ3d4SU5mU0dmOWJCbWtBZ3Qr?=
 =?utf-8?B?Q2I2QmVXTUF1a2huVXFqbUZnaC9zVGFROTF2ZGZ3Y1FQbTNKSmFTOUlHSUdy?=
 =?utf-8?B?cHdWdGRjOWhrWnZkMDJnVFV0NmRIa2l1UTJhQW1JR3ZvUkk1eDcyQUN4SHJF?=
 =?utf-8?B?NERFcjIzOGpPc2thbVVjL2lmREwvbWtRakNVVXFKWHkwNzJsYmhpL1VQSWF0?=
 =?utf-8?B?NVdYekQyTUpLeVY2YU9kS3YvWXcvY2Nzak5zNTlyYk56S0FkamsyenpnTENX?=
 =?utf-8?B?N1licjJlMlhneGNzbTdETno3OCs4QWw0SWhESGVmYVFIcUNwWHJ4RW5YL1RQ?=
 =?utf-8?B?ZzRaZ0xQRGt4ME0rWkdGcEhWZ0NqZVFZaGlKM0d4OURJMTl0OW9YVFdHV0VI?=
 =?utf-8?B?VHVhM3FsZE80WXBxTmg0T0ZsRU54bENvYjdsSllwNUpOOFVhbkxRWVVsZ282?=
 =?utf-8?B?RzNCODkydWVNdEF0WlZiNUg1ZC9kR1NvVktUbWIxMmxUNFFGUW9WWS92Z2pu?=
 =?utf-8?B?eXNha0pwMDM0MDJhcWJpZFVwY2N6RGVGT09UVG1PRlNiWUZucHhoN1hKaGhI?=
 =?utf-8?B?WU9ud0pJUExmdnFrbWIvTG9ObTFVVnZpR0JLOWZHT0FLc3ZuUUtFYVJuNXBB?=
 =?utf-8?B?cUNZOENLdzdvM0FHN3pOTyt1Q24rNzdBbjl6REVoWG1SMXJRVDgrdnYzSjVr?=
 =?utf-8?B?YnhGK1AvZ0dXVTJPdzlFYnlvSXBjVmh6Y2ZaK2xkTmdhaDhaemljZXhZTTVl?=
 =?utf-8?B?QTJqd25kU0RMNFlId09STEpIZmxIaTRTK0tXQmxveDBGY3hSVE1ycmp5cmRu?=
 =?utf-8?B?bFg5NzByZllNRkV0eEU0ZnFCb1Z4eG9SbHBQeWRVUzhNRzFXbVJZaE5leTJW?=
 =?utf-8?B?Yis1TTN6SVE1bXptN3ZZajJjVHVjR2lYN211YzZoaGsxaHFQa0tKZC9UbDVk?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a120cdc-15d2-4d10-90e4-08dc6bb617f4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 21:15:01.1490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6ZSeXgyjfi6lh19QgjrRXQU7SqKyAk0aeuzXymOwKoER3qKFs7UHkwrntJrn6fspqb/HWhHmfL9MxMkq9QfhxkLsvMIj78jytIFX6Zy9s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6218
X-OriginatorOrg: intel.com

Hi Peter,

On 5/2/2024 5:57 PM, Peter Newman wrote:
> Hi Reinette,
> 
> On Thu, May 2, 2024 at 4:21 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Peter and Babu,
>>
>> On 5/2/2024 1:14 PM, Moger, Babu wrote:
>>> Are you suggesting to enable ABMC by default when available?
>>
>> I do think ABMC should be enabled by default when available and it looks
>> to be what this series aims to do [1]. The way I reason about this is
>> that legacy user space gets more reliable monitoring behavior without
>> needing to change behavior.
> 
> I don't like that for a monitor assignment-aware user, following the
> creation of new monitoring groups, there will be less monitors
> available for assignment. If the user wants precise control over where
> monitors are allocated, they would need to manually unassign the
> automatically-assigned monitor after creating new groups.
> 
> It's an annoyance, but I'm not sure if it would break any realistic
> usage model. Maybe if the monitoring agent operates independently of
> whoever creates monitoring groups it could result in brief periods
> where less monitors than expected are available because whoever just
> created a new monitoring group hasn't given the automatically-assigned
> monitors back yet.
> 

I will respond in other thread.


>>
>> I thought there was discussion about communicating to user space
>> when an attempt is made to read data from an event that does not
>> have a counter assigned. Something like below but I did not notice this
>> in this series.
>>
>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> Unassigned
>>
>>>
>>> Then provide the mount option switch back to legacy mode?
>>> I am fine with that if we all agree on that.
>>
>> Why is a mount option needed? I think we should avoid requiring a remount
>> unless required and I would like to understand why it is required here.
>>
>> Peter: could you please elaborate what you mean with it makes it more
>> difficult for the FS code to generically manage monitor assignment?
>>
>> Why would user space be required to recreate all control and monitor
>> groups if wanting to change how memory bandwidth monitoring is done?
> 
> I was looking at this more from the perspective of whether it's
> necessary to support the live transition of the groups' configuration
> back and forth between programming models.  I find it very unlikely
> for the userspace controller software to change its mind about the
> programming model for monitoring in a running system, so I thought
> this would be in the same category as choosing at mount time whether
> or not to use CDP or the MBA software controller.

This seems reasonable to me if only considering ABMC and legacy. When
also taking into account soft-RMID it is no longer obvious to me. I do
still have an impression that the soft-RMID solution impacts context switch
duration so I am considering the scenario where user space may want to
use soft-RMID for portions of time to get an idea of workload behavior and
then dynamically move to less accurate measurements to not impact the
workloads all the time.

In this case perhaps more like how user space can dynamically change power
saving mode based on requirements of responsiveness etc.


> Also, in the software implementation of monitor assignment for older
> AMD processors, which is based on allocating a subset of RMIDs, I'm
> concerned that the context switch handler would want to read the
> monitors associated with the incoming thread's current group to
> determine whether it should use one of the tracked RMIDs. I believe it
> would be cleaner if the lifetime of the generic monitor-tracking
> structures would last until the static branches gating
> __resctrl_sched_in() could be disabled.

Yes, this falls under the umbrella of needing to understand the impact
of switching between mechanisms that is not obvious to me.

> 
>>
>> From this implementation it has been difficult to understand the impact
>> of switching between ABMC and legacy.
> 
> I'll see if there's a good way to share my software monitor assignment
> prototype so it's clearer how the user interface would interact with
> diverse implementations. Unfortunately, it's difficult to see the
> required abstraction boundaries without the fs/resctrl refactoring
> changes[1] applied. It would also require my changes[2] for reading a
> thread's RMID from the FS structures to prevent monitor assignments
> from forcing an update of all task_structs in the system.
> 
> -Peter
> 
> [1] https://lore.kernel.org/lkml/20240426150537.8094-1-Dave.Martin@arm.com/
> [2] https://lore.kernel.org/lkml/20240325172707.73966-1-peternewman@google.com/

