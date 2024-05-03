Return-Path: <linux-kernel+bounces-168230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A048BB570
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489EB28714D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFFF537E9;
	Fri,  3 May 2024 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXp5W2hl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B6B41C7F;
	Fri,  3 May 2024 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770917; cv=fail; b=c06YHmId45j5XriReG0rGllqssu4d8KGLYGKwYvT9c1z1iIBWURliRKjK8w41WkQHhGrH0D5MGsvkElsKYKqfALRX8vp+hD5DdFeINlSylyip8jB8SCy5I3NK3b+HllcwApgJfX8ZEpmF3rURcC+9sXL1y1151pWiGOsGketZpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770917; c=relaxed/simple;
	bh=ZqxFR+JN97K2nyyK0PyZ/6D+MeWtA/Tq6dMBd2XxIlo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FjE2TR4pisp/hp0+kYCcxX1ZB1ao0L+O+RUMCanKR+6SzL8TzvOkxPBj26NIGIk/cjRNSKeojSOADWm3Fs1GfUkJDvIK4gb4YCpNgq/iEyUJC7W6UYi4FPPA4Mu4HEIqz6DmEh3vu6zVW1sZa6VoJFQ1pWwuTDMJOKeo4VzdOJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXp5W2hl; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714770916; x=1746306916;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZqxFR+JN97K2nyyK0PyZ/6D+MeWtA/Tq6dMBd2XxIlo=;
  b=jXp5W2hlRV05nQizDQttg32/j2n/LBcZcvXCGzPN7/kVGOu2zUT2Qc0d
   XVetZGs1ekNWjD/CtHpIMPVsPY9AkYc4dgNUqWlLa9++nGiK3UbTuMK0p
   GgeEgitVqFvaMrPFDY7bL/fVOK43/+VNx5NeZ1ssx5jfB8j9NPdI4NSpC
   EtafQvgKgnnjRwRZgRWj+EBfVoo2p05N3Crb8V88m7NdCSS/+9PmAk05l
   Zf3JoUwXNl0t9YoKpneGqQfLsMYUyVrqcGDyQwHXNeo5sYJC0D34Z7/5p
   yH6lBAiUAqLbJO1bxgIP3+1sFb95ZfReJLh7WizpqyPN23HX7mgRC/u3x
   A==;
X-CSE-ConnectionGUID: 2103rffoTCuWJyqDVIMYcA==
X-CSE-MsgGUID: otTgAzQ/QqeoAi8nKBSOvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="28072244"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28072244"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 14:15:16 -0700
X-CSE-ConnectionGUID: UlTc+oKbTzeP8XcwJIhPUw==
X-CSE-MsgGUID: 4QLoSq1uQ2C/Wg1X5JI0OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="32376023"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 14:15:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 14:15:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 14:15:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 14:15:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm5v34+LuV+chao+zzMmz+05OFbU5//Tn4b7MoIFirPI9BWivAFIkDMts0bdjc6gGc/iMdqSc0gwgfAyDzSKgA0njz+XFPqQDmvrRrJsGjueQkNjvmdedxd1r3QT4/IsY035JqwdUB2GG1NAkgH4RScdgd1rgEWuEikzaApN/nf88cttzc9O5yRKeb+zTSUiciJxIF0sghyKm8JQqyM3vPWw/MWzYwYZq4HaRu5Qsqsir0B8kV4GlLrMSC50BIyqm5QE6gj7Iv5HnAKSvr/1iWizEhAbkI1/Vq+VwNTAuvw1LHvUwpQ0Wgdnw182jsUm+NZtFFwMVx2f6nMdyIkETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZoOD9vPINCJIRn11x/KS22DEvi7luGK2DC0lF/rSj4=;
 b=TIIb7WtLnXCj3p7ju6n/GrsiPgA8psmrKBA3QRWU78o7XdW9iKy+CX6vcim2o1toU0sC60VeYYwtFmrbn9sBoBYRtor5WLdJ9pzVM/GGzScwzb+PiPukByx5VsN2B148gGeGjZk+rQ6dqirxRuy/KM3wS+SrDxy6I/nBg4UpXtpnH06Z7Ey5/XuS2A2FOt97/YssUihOEv1yDHD7wj8bL+FqAxCK63CQM3DUvkgmQPSWjVQ85SVoidwi+IdeLufIUucO3eiUS8KcfQQJkx3jSWVh/FDq4zPsvzv9siSLVXvpkAhUkHA9wKhF5A1phN/HL/nGuJ06TzQB3Pqx4oAtBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6218.namprd11.prod.outlook.com (2603:10b6:208:3ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.31; Fri, 3 May
 2024 21:15:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 21:15:12 +0000
Message-ID: <d7f3c5b1-c39d-4c66-92c3-5b096b9e0579@intel.com>
Date: Fri, 3 May 2024 14:15:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>, <babu.moger@amd.com>
CC: <corbet@lwn.net>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
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
 <b725e4ca-8602-eb26-9d47-914526621f52@amd.com>
 <CALPaoCiu2_UHyGjsyitz28BL1N93TSn28E1r-6nhXg--bzmU+Q@mail.gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCiu2_UHyGjsyitz28BL1N93TSn28E1r-6nhXg--bzmU+Q@mail.gmail.com>
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
X-MS-Office365-Filtering-Correlation-Id: bfbcc23d-d50d-441c-5a9f-08dc6bb61e79
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWdFNUtQUnVyeFB1WEp6WWtEd3VFUE1vY1ZBM0FrZi83K0t3aTgwNDZZYkVi?=
 =?utf-8?B?QVRuSkovQWord0tMS0dBVlBIeEptcnRYazArczhZRXB3bC8ybEVzVW1vVnQx?=
 =?utf-8?B?bWNrVk9lRHdScGJyYVNlUVFCeFcrejlRak1CTDZRYTc0cnBIMDNPSjlFNG9V?=
 =?utf-8?B?MldKTDBHeDhkTC9HanNwWTc0ekZ3K29KQVRrZm4xZml5WUcyN24zbVpYODNB?=
 =?utf-8?B?UDhScW1zbno2cFZPSVlJeXRzMENkZForOUF0SkhoRlBBREkvcTNIeUNiQzN5?=
 =?utf-8?B?emI4SFhUUS9pRlhOTEZic2k4UTBOZ3lvTkpZdzFGbGJDRnNIOWNCVDJVWFJx?=
 =?utf-8?B?UU4xN1p1aGx2OWFzUUY1dFJxeGEwQ3JmZHF4Ui9ObVA5ZXBHYXNCazVLVy9J?=
 =?utf-8?B?R05aUVp3TzBWZGlnVUllRWltQXgvb1JZWC9rRjErNm92eHZiTXVPNFBaRWlu?=
 =?utf-8?B?dDN1WDVBaVBUVkNDOTNQV1MxRTNKVU1uWGdEYmh3dUNnS1hPTnZ0R2JRN2ty?=
 =?utf-8?B?V1pPRFk5WVA2R1I4VXBZWWFVQ3A2eUd1bzhCRTVIamlpVEx6dVNJdkQzR3ZT?=
 =?utf-8?B?blo3UFZPQmJzZU9LY1NxS0dSbzd0N0dvVzNwOFFpNkRaN2Y5OXBkZVJDYnBP?=
 =?utf-8?B?VUR3TnhsbC9LSVhiN1NjTDFmbTVZVGRTY1ZkRGZUOVVGSFlGMC9SbTlQUVpt?=
 =?utf-8?B?WHIrWUoxUjJ0Mm9DWXFTN1licnl2NWxhK1V1UGJuOUNVa3FYclg4Ym5NSjVj?=
 =?utf-8?B?b081cEowb3owZ05PWjQ5SVZ5bll2bWpLSTBScjdRTWdKUTJKUG85WHZ0dktk?=
 =?utf-8?B?UnZiWWVQT3d1RlR0T1JsaXNaS1hWTGNTaTFaMWNPenc5czJ4b3oza1ZiTWpH?=
 =?utf-8?B?UUY4cy9KUkcxZFhzQTdFb1hZM2xkLzhGS05RWjlTbXgyN1BNK05CN1Vrb2p5?=
 =?utf-8?B?MkcxR0lMMllmSlBqaE9GUHNjdmdBWE84aVRCZW1KUS9EQXFOSGd6UGNpemtS?=
 =?utf-8?B?d092cmdaRzhMTWVCS013RWZFVzhobHR2UG11UG9TZHhZTXI0VDJjYnpqWFJz?=
 =?utf-8?B?VnljZVBjT251Zk40S2hyMHpUVDNyN0hlOUdPTEZabCtZWW5HNkd6RExnZkJ3?=
 =?utf-8?B?SnVYOElMNXNRY0RJN2NpdU83aVhReGsxK0d3R2tlbU5MNTg2QVh4Skd0dXR6?=
 =?utf-8?B?RUpieVJaKzVRRnp2QWpjdGNtK2ZTcnJtaS8xa0J2V1JvYUJNV01kQS9mUWZU?=
 =?utf-8?B?dWNxci9jZmFGNlpvcFhsOExPWXFWWGQ0dDRiSFNSWjI0SXVPb2c0ZGFlblR4?=
 =?utf-8?B?QlNjQ3h1VW9ZdUpyMWJValVwMUJ6aUhZSDNwU01TU1NicStab3BkVUlBQ3lu?=
 =?utf-8?B?YjhGNHZBLzFQM2twR0FiaXNvd2RYenl5Nm41eU5od1J6citONVJZaFYrYnBY?=
 =?utf-8?B?Ym9xZlRjQTRmeXUrdEJEazNCT0k4aW1CdHdkcXo1bTYwbFYveXdlazIzQ1dF?=
 =?utf-8?B?WVh6Qkt2Q2x3SzdheHU5Vk1YelUwWE1LV1RMa0pwQThOY01nZG5tN3NlbkFr?=
 =?utf-8?B?RUxUOHR1a1dxcUNITkVhSW5GQzkwblJHNmo5Qm5jMzR4SUtvYzg4b0hWLy9o?=
 =?utf-8?B?bEVTMFVudm4ySnNZTCtqdmk5MUk4SlhoRmN6UHpQTHdXSm95VHdiVFVubHpp?=
 =?utf-8?B?bzJ2dVB0QWpqSEc4SkRNbXBzRkprLzFqeHYycWEzSWl6Z25BMVNWT2dRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1A1VUlTMXREeWVDMmY2a0FTeFR2MmdJTFBLU2lQVlJsd1JGNnpqTDJ4bElv?=
 =?utf-8?B?ckNQOEhwMWdtNGRpaUtuOEtvejlzcXV5U3VkOGdnWWFoWWJVZnlYL2s5dHFl?=
 =?utf-8?B?OUw0NVluTkpYL1d6VVJFYldCRU5Yek9BU0FLUnM2WEhjdlBhSnMrOG1kelBl?=
 =?utf-8?B?Vms1ZDg2RUYzM1F5OFlZNzdCMnZQRE5FTlZFYU92djZLcmxzTHpJa2MzeFJW?=
 =?utf-8?B?MXRKdFhSenduZ0xVQWZVSVNJd1JFZlkrVjkrbGJDNld4MlNIcUZpdXB6V2I5?=
 =?utf-8?B?RFZwckJUTFNPem1vSVhSTFRTS3VOR0ZaVU01MWxJbnV4aElOOURFc2NMT3Vt?=
 =?utf-8?B?cFhCcGwzZ094R0NnRUlmNjNVTFU5VzN2bFVXdGNRYVA4a0pLOU1aVDlHcm4w?=
 =?utf-8?B?SU53MGNUMWo5ZStGSVVTY0tGdHB5OWxHLytCUE9QWnpCOStmZm94ZmtqY1pj?=
 =?utf-8?B?NlhNQjM3WFRyQ0tkT04ra1doSjY4OENkVURWQXA0SlBxMmlpc3FxZkppL1h6?=
 =?utf-8?B?UVZPdjVFako4MnEzMzhDWkMwK1NsbmlpWlhLenAyMjVyc3NubUtqUHN6UmNI?=
 =?utf-8?B?OGJ2S2JXVm9yRUthcG9ReksydGVKMHZVN2JMRFl6eWFEdEpVbDF1Rlk2RWJs?=
 =?utf-8?B?N3orem9UaUY1TlVBMDlBdmF0U0R2Wkp1U0poQy9Va3B2SHZpdDIvNHREZzJ6?=
 =?utf-8?B?d3ZOSCtPM0EvR2ZjMy9GT2NkMlQ2NGU0UlIyK1dvRTUrWUs4MEV1Ykt0UEpt?=
 =?utf-8?B?a3U5TnBQQzE5R2pXZUJFL1UzS0hoemhqa2dBT2FDMGpIZEdYQ0lTNEVibWNI?=
 =?utf-8?B?bmRpZENUUUpSR2RYRkI5ZlRvNGswMmF0VFgyMWlraVIxM3lDbXk1S09RQkgy?=
 =?utf-8?B?cjdSR012YTh6U1Vpd3B1RStVWFNraDZqc1Z2bXdqUVNqbW9PUnVyb0lTbm1K?=
 =?utf-8?B?ejNyd1ArU3lhQmJrdEN0V0ZDTU5oV2lnUXBMc0hUNklLaXhPUzBmUzY5emJJ?=
 =?utf-8?B?cUlqdmlEVVdDSGczcXdPaEFVYzljTS9tT0NSRHZWS0pNM244MmVIUlFNbGJR?=
 =?utf-8?B?Wkx3dHZabDBSYnRUdnZPT0laQ3dvNlMyL1RjdE16dDRNSm9EaVMxRnI1UURm?=
 =?utf-8?B?VWZ3S1RDOXZ6bWlaRUpITEpxNjNrdnBpblplYkVZTGRQRXZES3h4WnljcldP?=
 =?utf-8?B?a3Z3YjRkNDZpV282QTR0cjFqNzFRMFNSampBTXU4MDRKWDVCc3lmNWVTVTBX?=
 =?utf-8?B?TnlmelpjSTIvazFOTkJhSjQxY1ZmYmFma25pNjc3SWdHREpuOXlHNnIxMTk0?=
 =?utf-8?B?SFBhanFJWFh0VmFsVkx2eXkzWHlpa1U0MEFiRERZaEphaWZaelJCZWIwTXZP?=
 =?utf-8?B?d0dUQXBvbzVuWTFscGxxRHBBQlU5OE52ZjNYNTIwa2tIRWdxY01HWDlJK251?=
 =?utf-8?B?MUQrQUZaanhJWWRhTzZyK2xoM3NDbHVvMzNnRE94cXZZMWcyb0pia2Nwak8v?=
 =?utf-8?B?WExCTFEzc3Y0MFRGYXNScS9UVE44Z01PWkMrV29Hdk9Qak1NcW1PcGN3b2ow?=
 =?utf-8?B?OFlhS0dzQ2k3QkJuUGx6WDJyK01TV0drWFRnaDg2YUIvRlUxVU5Uc2YyR3hW?=
 =?utf-8?B?dkxqcUFGaG5iQVBzSnVraDk0Q2lMemZiNGU1WFBtdUlRcklhODZma2hxZzlr?=
 =?utf-8?B?b0V1T0x5NE5nZ1RpUlpQVHc1VW1XUDVhUVdBUlgyQnVVWnQrOG4wV0p2N2g5?=
 =?utf-8?B?ZzE4bmNhcHlJOEZkY2kxK3R1QWFGa0pEZ0tYdThZSWdXcGRPVldibmNCMlVG?=
 =?utf-8?B?V2ZoZEVLUVVZM0VVa2QyUDhmeVRVeGlkVDZaclVSeVRmcVNCVVpiRU1qanJB?=
 =?utf-8?B?eGJBczRSaDdIZkdRaE1RNlM1OGtGVnFmSkh6Sm0zVFJnOUgxRldJWnpSMDlu?=
 =?utf-8?B?YnE3REluUzhGSjlGbzg4eHRRSVpYaG9XUU9HT1V2d04yUjRNQlErbEp6b2cy?=
 =?utf-8?B?Zjc3T25FMmgvNnZwdDRMMVlWaWU1VFYzTzVaOEIzMG85bU9BU3kxTVByblBW?=
 =?utf-8?B?RE5QY1ZYdUdPd21EaVNJVGQyZVJnYTFNM0NJUVhDVVlJVEZUZHEwaXhzSkMx?=
 =?utf-8?B?R0RHSE8vOWt2MktNWmVZSkphUDR2V210U2ZnaTdjQ3JLZlFkS1AzcjRNVVBl?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbcc23d-d50d-441c-5a9f-08dc6bb61e79
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 21:15:12.0383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnu0gvBkwhyo3jCewQ8i41XSmopnV52+IIDgjCfWi3Din8jN9fKHWVyyNSDjvnRjkteCPriV+1vNF6n9ixLqoBdAPOXghCWopTZ7yiFAZ18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6218
X-OriginatorOrg: intel.com

Hi Peter,

On 5/3/2024 2:00 PM, Peter Newman wrote:
> Hi Babu,
> 
> On Fri, May 3, 2024 at 1:44 PM Moger, Babu <bmoger@amd.com> wrote:
>>
>> Hi Peter,
>>
>> On 5/2/2024 7:57 PM, Peter Newman wrote:
>>> Hi Reinette,
>>>
>>> On Thu, May 2, 2024 at 4:21 PM Reinette Chatre
>>>> I do think ABMC should be enabled by default when available and it looks
>>>> to be what this series aims to do [1]. The way I reason about this is
>>>> that legacy user space gets more reliable monitoring behavior without
>>>> needing to change behavior.
>>>
>>> I don't like that for a monitor assignment-aware user, following the
>>> creation of new monitoring groups, there will be less monitors
>>> available for assignment. If the user wants precise control over where
>>> monitors are allocated, they would need to manually unassign the
>>> automatically-assigned monitor after creating new groups.
>>>
>>> It's an annoyance, but I'm not sure if it would break any realistic
>>> usage model. Maybe if the monitoring agent operates independently of
>>
>> Yes. Its annoyance.
>>
>> But if you think about it, normal users don't create too many groups.
>> They wont have to worry about assign/unassign headache if we enable
>> monitor assignment automatically. Also there is pqos tool which uses
>> this interface. It does not have to know about assign/unassign stuff.
> 
> Thinking about this again, I don't think it's much of a concern
> because the automatic assignment on mongroup creation behavior can be
> trivially disabled using a boolean flag.

This could be a config option.

Reinette


