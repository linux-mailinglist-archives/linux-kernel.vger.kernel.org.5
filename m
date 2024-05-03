Return-Path: <linux-kernel+bounces-168401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38A68BB831
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C16828588E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2C784A4F;
	Fri,  3 May 2024 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGisIY4I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC383CCA;
	Fri,  3 May 2024 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778660; cv=fail; b=KxaECrw2WEAZ9ts8p8jOYdtFd2eaTWR4+uRf+a0l28XPMjoTCkJZKPgwDNVWInWHiNb9tGH9Nk+i6j24TmR70E05dSRdp8vSUO5qBvlolC/KtyzuRNUb2dYo4r1+oqIraF+y++wC0lXproeN+clm+wJO13ABgDVdHiqXDt7tdEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778660; c=relaxed/simple;
	bh=vrgLoJtBo3OPdiBW9oqoGbYqlxH3mmwidTlxdhkaZA0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=llgtUaFVu61I9KUD597zDlzrwetZnSwrbYugyliABsM0kcG2Mlmax6X35701G3tizDbPD2WBezmu/7l83c/LlacSG7eCPvA7NVQOLMH4yg7WJti8ijyK/Uzbo4gR7Royde0qTQQrNjXY3/pKn77cBKOvc42yQ7h4t3laJvFkr7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGisIY4I; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714778659; x=1746314659;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vrgLoJtBo3OPdiBW9oqoGbYqlxH3mmwidTlxdhkaZA0=;
  b=BGisIY4IcnJvUtBJMlWa1ZeWmN0VgfG58qOltSzoLLe+zi/QyVS2mJcu
   fsfw/oNyirDetaCi1vwkUeWPemGEChmiQGXcj8TvcaZXafKAcqeTsljLz
   QdjqV5Jw/Tc2/W5a3WA4/ruOua41swIlDz0KYk4JP8uNufE1Os1VaC+HS
   D4Lf5WEPZRTsGIdmSrjPIsftIjYaoKMFzXPnJeoG4BgjLndI1/GIt2EAs
   9394iubt3a8G/ch2NS6lTYARfkCD/dDWwvqDn/d/Vqsm2kfydVf97qVEA
   Yo0/LV2CGoRDlFhWyfW6dEEeGg1jbc1PWssEM7q7/IfKxjW5zS4pHVId5
   A==;
X-CSE-ConnectionGUID: 7Vy7Q2TETyKbdEQFsAqF1Q==
X-CSE-MsgGUID: r2PNz7vOTOSUksutWFCOgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="35989139"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="35989139"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 16:24:17 -0700
X-CSE-ConnectionGUID: Xr/+8a5kQTiec23teIaxMg==
X-CSE-MsgGUID: v0Wo0Fc3S1+Gian7iqfVrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="27563731"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 16:24:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:24:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 16:24:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 16:24:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FU1mggl0ddYjaoqhh1JC+CcyZHk3i/VSZ4D/tlV1VZ6FLLJIMKM9VUMTsdwKz16LdBMM2x73IViWtGAohgq+q8kw+rQ5KZgt+l/x/pk2YIrbFG0vigycJO22AXUSbNtoPfxVcLsKXoTaRRhZyrjqh8jZTf1rBqc/MESGaLNbzb7+a7iNMCz7IQVgyF1Cr44pOyxGr0LQVAbG2QGh0FPc7Sf6uJOKkSI1N1MKRWTIfefZc8rD7QXox4lhAENyMqNdo/b69jyLhE1uCYD0REUsvUN56q//LTSqKHi8zFZSkaRQR5e7hcBWxZxxdeA9H+E3pTpqpvEhtgkYrNP73fxHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxDgBznf/HK5LAkXcmLtKYGy9Dqo9l15Idwh90oETsQ=;
 b=i/MnTlg7Rsv/Jf7+2eYS39n8m6H0vtPn41aW3+ny/ma5H+iGDOGqgeJBFn6a3MBEeJPTIjZ8vVEDd5EKJO45vqAusXCEjrhiywMmzfESdFuM6cgSIfr66lJy9rR+UUJUi1pZLqmoIuflwVQeHlo192JgWEcsQT10lqKlD6l/+7pGAePY3JJvvQndb1tyzHvZR3VzXXRcE+98e6V1rK93IHYF263RmXiFXkmdqA8P+jjRGFljNmE3PIFX/2Iokomr2SMEnXdmtGiiGOYq4tIQyEOR1NM2KlwO4B+bfXRNr63RuxvFB/hvDwm8UwxG87DopwwCk/4AGNA+QK9jTk/rEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8607.namprd11.prod.outlook.com (2603:10b6:408:1ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Fri, 3 May
 2024 23:24:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 23:24:14 +0000
Message-ID: <48b595cc-5ffe-4507-bffd-335a60fdaab9@intel.com>
Date: Fri, 3 May 2024 16:24:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cover.1711674410.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:303:b7::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: eb41db43-2025-4a9b-cd74-08dc6bc8253e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGhsa1F1SFVzNzJhdkNvVlc1VS9TVlZxd0h2b3hSZDBqT0Vvci94UzY2NXlp?=
 =?utf-8?B?MGRSaUM3UEplT05QdVhmYzF3d3l5TDNYb1E5S1lsVVhDVEp5RUk3ajJkM3Jv?=
 =?utf-8?B?TnYvbjZxcnhsQ3pnUTQrWHF4QVlQb0M1blA5SEZweU1pbkJlWDV1SHhzdldN?=
 =?utf-8?B?ems1cnpGWDdjc3VJcVFocUFXYVJDWGlBMWRFYUloTlhXV2pyWDlYUDkvNlhk?=
 =?utf-8?B?YlJJeGtzenpaM0RLRkFqUHYvMU9LbXExTVlkM1RyTUZPWGp0eC93c09vN0Nl?=
 =?utf-8?B?YVMrdXJDcjZaU0N0MzRoQ3VoeEY0eHZ3dVpKcEpvSWdkY2xBNzZsc0VvTHNm?=
 =?utf-8?B?UzM5SlgxNk1wMmM5U0lxNFlyeWFHdm8va1NlOS9ySGhvaU93ekFkZkhmU01t?=
 =?utf-8?B?TFoxNHdUM04zcWlGTDQ5N2ZVZTVZZmljNkNrTko0QTZWUm5mTE9HNGdrZVFr?=
 =?utf-8?B?b0FvYjRvQ3U0UEt5NHFwSitLT0k0T2ZrT0lIMHYrM1RjRll4Q0tyTFZINVpt?=
 =?utf-8?B?U1cvcTZXdkZjek05TmRYeTlTMTJBN21ZQ2ZkTjEvNUE0UW9rczZVdWZGRFEx?=
 =?utf-8?B?ZjZNTWR6bCswVjVlbHZRckxCZEExajF1RnhNaEZOM0dEQWtLYWs5OGVoTlNy?=
 =?utf-8?B?VkhjODJ4OTZIanpQekdmaEVOUmtyazdsWHJkOTI3eVhNU2FCNXVCMURFdSts?=
 =?utf-8?B?NzhCS0NIekNjLzN1aHpjSjliL1hoZ2l2Skp4WjhYSWRPTHlWbEtOa1ZPVDFQ?=
 =?utf-8?B?UldmdndjTThvUFlxb011empXUHN5amNWTlV0bzVzRVE2M3dSSk9sTzgvMW0v?=
 =?utf-8?B?azRSTWFwRDZaZ2hUQWhYUENpV2svTVJvRlMwOG5hVVNtMTVwWU0xODdaWGY0?=
 =?utf-8?B?bVY5SS9qMXhKeDdONktDWGF4elZlenBCK00vWmFnQTFXYnJCazUzVXB0ZXBm?=
 =?utf-8?B?RXBZSDM2aEx6M2lheFJQU3pDS2N2RVdiaEs4TXBWaC9hZGloUmlwVjVaMXlj?=
 =?utf-8?B?WVh3VWNySzU0enVjUnhKYS9HUFZ4d25GbndTbDNwUmROdndEUFlzaXEwc3pn?=
 =?utf-8?B?TXdyNTkvZ0VDQUNrNHNobmdLL0pQTC9wdFNoZlMxOWF4anpycXR3RmZTbWhw?=
 =?utf-8?B?WXZTZENBSzRhdU5yNU95THArSUdBMTJBbXhBYVdoYWxWV3N4cCt4Z3hKQW4w?=
 =?utf-8?B?ZnpBSHFWS0Z6QW9mRnd5TEgya2NsWDJUdS84Wk1FbmNnb1hLclVGTCswYWJm?=
 =?utf-8?B?clZtVmZHZXFFalpuTTlQVGdSOFFZUGx5T1NQRFJ6SzBob291RDYvejVwMTI5?=
 =?utf-8?B?emdyRjBObHZPMnhEblBodHc4bmZOQXc3OS9hQi9td3lubk1OaE14RG5yWEtU?=
 =?utf-8?B?SkpvbUgyTjQvek45Y2ozaEx3VkdabEduOGV1dU5Ba1JVc0EvbFR6NlNqTEV1?=
 =?utf-8?B?YlI4dDlVakZPMkx4b3hNNlVvenA3S0taVll6Nyt4ckY0eHlKNHd2STBtbEU3?=
 =?utf-8?B?eDRSR0hjMVFJYzVzOEVCb0FlRU1pSjRqc1dGeHhGcmVWT2tzZHd6R0ZaSi9Z?=
 =?utf-8?B?Sm8zcUtzUjdTalI4dGVCUUxXNnNhaURXb3VSZjR5d1JYWUNBRTA2QndaRU1S?=
 =?utf-8?Q?70+bi8WR8czjtMTgV8Pmf3LVQakob+EwtP6GiqWIDoN0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUZyTVRVZUJvTE91bExiUjNiYmV5QjcrWCtZOXBuU05YRmxybGRCQ0hpbjBh?=
 =?utf-8?B?Y0hDaGprYWZrQitWbFpNL2lJM0lkMExuN0U0U0J1Y01LdjczQ1BFY3JZVkFN?=
 =?utf-8?B?a01NdFdPMXVJdTFMclpPMDJiRmVma0J5S3dDd1lPK2hvZUNyT0RyQUxQZXM5?=
 =?utf-8?B?SURMbTdsc0pmTWhjbnZ6TmpEakxSb2lMTjROQ29QSGlBWGZyMWZRb1o5cWd3?=
 =?utf-8?B?U21aVjREemY3WGpua2d6MHBqclVMVG1MUUhZR2xta2ZRTTNyaWVtRHhnTzRK?=
 =?utf-8?B?QmptTG4xMS9xaEVwMm0wNGNTZHdRcVJJWnpNdlc4Z1RjSks2dSsvcjZMd1d6?=
 =?utf-8?B?bVRNUGJjUzRVdXBIcWpTbGFrdVJtMVhLTldiQVdIbEFGYTZKd2FGS1R4WkVa?=
 =?utf-8?B?NzVTKzJTRWRQNVkrOWZ5MlJHcTRiQjk5Q1JwZm5tcXM1WlUxaGhsZnZpVG9D?=
 =?utf-8?B?bmRZSUQvZG9ZVWgzREhRVldMajJLc2VQdWI1WVB2RVQrYjE5ZFlSOTc1bWFh?=
 =?utf-8?B?MXM0eFNHaVp3RzAyT0JDVWRoOWFlaC9DSGl1aWdLTU9DRHA0TEEzekNVcEk3?=
 =?utf-8?B?ejE5dktacnBjeGVPOGFlL2V5dGtZVGRWVkQvYlhSbWwrSnZsemMwbWpZalpp?=
 =?utf-8?B?cVRZamc2eWFFQlN1b095eGprTHJXa1d1dm1GeFZLaUxnU00rd3VqNHd6WUhG?=
 =?utf-8?B?TXJYMkJkNS9KeEViN2hRdWZHUThDUytPN2lzUDhQZFJNYzhmb0NVdlhpM2lM?=
 =?utf-8?B?UFNIV1dvN0VBbTE4U1FpY0RZWGVCZFZHOW82UEo2NElFOHZwTG9HeWc5NXRS?=
 =?utf-8?B?N0hQc0hiZDNZMXE0UFN1TkNiOVZrVkthVmhYTHJCYUgzNjZsK1h6MFJYazAx?=
 =?utf-8?B?N1BpY0RJbXkrWSt1ajZqSXJKOFZuKzRCSVUxTTdTdUwwWkdPZ3FNd3FJRHVp?=
 =?utf-8?B?Z1J5a1h6VkgyeU45Sk9VMGdOUVlqa3dtdVhtSXAwemdxS09hMkxqclV4K2Rh?=
 =?utf-8?B?dFNzTGxZZUpDMlNQaUVoWkM4UjZ1MWh3amYyZ1RxMjJKbnN0VHFESldldzhZ?=
 =?utf-8?B?NUN2QnYrTEJvdUxEd2djZ2M0RG04ZjVFcTcwSmE3dHpOOGp1Y0Y5Smt1RlRv?=
 =?utf-8?B?cFQ1T2cxUXZzdEE1akFodkZZRFdZVTUvQTBYeFpIK0p0VytUYklXYmMveE04?=
 =?utf-8?B?eTVBS012WXNIZTRsRml5YXdWWGZGRTNWaEFmWDJQKzI5eExsUkRWWWZXajhY?=
 =?utf-8?B?RFNMRmdaLy9CdzFMQlpEY2FJRW02V0JEUmpPNjRFbmwwRWpBRWdmZ25hMzM4?=
 =?utf-8?B?YjhJSjZkbEFMWGsvS3d4cU10b2w4TURNbHpiL29lczVLYkU5Vkc0RDlXbzlt?=
 =?utf-8?B?d0tCbjdlQjB0MnhBY3dNazd2M2JpZEExaDJndWI2RDdWejZydnhDNEVlMmNM?=
 =?utf-8?B?L0dDWDRYbGdrelR0SklGWTkzOTN1K1RuTDBIM01qY3pTcVRUQWJlWGRHUDMw?=
 =?utf-8?B?NVFVZks4aE4yenVmTE9LQzhMNEN2Vy9ZMHNkZ0g1SFU3TzJSQVZnSVhPbjRP?=
 =?utf-8?B?SXJtTHQ2L0tMRU9tQmxUaUJmNUN1RGlsU1orbFEyenpXcTN6S0g5QWNFRnVZ?=
 =?utf-8?B?LzNhOFlGVG85WjdDWk1FTE9lcFlycVVrQzAxUFREczNyRTBvb1dYQUFZZ2o1?=
 =?utf-8?B?K2dwdFVwZzBSUUZEMzhyZ01MTjFKNmlCYS95R0ZISnU3Mk9vQmtWelRPV3Ju?=
 =?utf-8?B?YUZybU9uMnZTN1B0VE9YT3hoK3hDeDl3cjZDaTdFV0JPQ3grbUpydytjc0d2?=
 =?utf-8?B?K1NKSVN1TERNOTE3bm14VWlmUVlxWmJPN0M4ZmozdjIrU0h3NXVSRG1sdmhi?=
 =?utf-8?B?eWNobFByTDF1S3ZsdTZVdW5McUtpNmZrMnYxL2pKc3NxOXFtK2dEOEZMZEQz?=
 =?utf-8?B?QmY4TkZTVStwYzlaSnRwcFhTbUhnc1E0TUtXeE9XbVVWeUtqNEtiU2dWc2NR?=
 =?utf-8?B?Skd5NWZwRE5PRGdSTUR2a3JhV2E1TDdJaDFVU3JsS1RPcHpHeEc4WnI1cnh2?=
 =?utf-8?B?WmVKL0VUby9yeTYvNXB6RG8ycU5tVmMyYTZuL1grZ1FqRCtWVUcyVHpnMlhw?=
 =?utf-8?B?cUgrcllKVlVmbmd3TVJsK0RFTnYzR3ZLQ2plRnRqTlNQYUtTSXRRM1h3cGpu?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb41db43-2025-4a9b-cd74-08dc6bc8253e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 23:24:14.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqCD4vNidObT9d7LcKAoYfViLeg+pDLp4A2hBhsvN71sFotSqAt4NDM2nQILDmredfclG7OUsiYM0svEOYFawFvO/WB2uC3u2vhgTQwp0UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8607
X-OriginatorOrg: intel.com

Hi Babu,

On 3/28/2024 6:06 PM, Babu Moger wrote:

> a. Check if ABMC support is available
> 	#mount -t resctrl resctrl /sys/fs/resctrl/
> 
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign
> 	[abmc] 
> 	legacy_mbm
> 
> 	Linux kernel detected ABMC feature and it is enabled.

Please note that this adds the "abmc" feature to the resctrl
*filesystem* that supports more architectures than just AMD. Calling the
resctrl filesystem feature "abmc" means that (a) AMD needs to be ok with
other architectures calling their features that are
similar-but-maybe-not-identical-to-AMD-ABMC "abmc", or (b) this needs
a new generic name.

> b. Check how many ABMC counters are available. 
> 
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_cntrs 
> 	32
> 
> c. Create few resctrl groups.
> 
> 	# mkdir /sys/fs/resctrl/mon_groups/default_mon1
> 	# mkdir /sys/fs/resctrl/non_defult_group

Can this be non_default_group instead? Seems like non_defult_group is used
consistently but its spelling is unexpected.

> 	# mkdir /sys/fs/resctrl/non_defult_group/mon_groups/non_default_mon1
> 
> d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    to list and modify the group's assignment states.
> 
>    The list follows the following format:
> 
>        * Default CTRL_MON group:
>                "//<domain_id>=<assignment_flags>"
> 
>        * Non-default CTRL_MON group:
>                "<CTRL_MON group>//<domain_id>=<assignment_flags>"
> 
>        * Child MON group of default CTRL_MON group:
>                "/<MON group>/<domain_id>=<assignment_flags>"
> 
>        * Child MON group of non-default CTRL_MON group:
>                "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
> 
>        Assignment flags can be one of the following:
> 
>         t  MBM total event is assigned
>         l  MBM local event is assigned
>         tl Both total and local MBM events are assigned
>         _  None of the MBM events are assigned
> 
> 	Examples:
> 
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control 
> 	non_defult_group//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> 	non_defult_group/non_default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> 	//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> 	/default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> 
> 	There are four groups and all the groups have local and total event assigned.
> 
> 	"//" - This is a default CONTROL MON group
> 
> 	"non_defult_group//" - This is non default CONTROL MON group
> 
> 	"/default_mon1/"  - This is Child MON group of the defult group
> 
> 	"non_defult_group/non_default_mon1/" - This is child MON group of the non default group
> 
> 	=tl means both total and local events are assigned.
> 
> e. Update the group assignment states using the interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control.
> 
> 	The write format is similar to the above list format with addition of
> 	op-code for the assignment operation.
> 
>         * Default CTRL_MON group:
>                 "//<domain_id><op-code><assignment_flags>"
> 
>         * Non-default CTRL_MON group:
>                 "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"
> 
>         * Child MON group of default CTRL_MON group:
>                 "/<MON group>/<domain_id><op-code><assignment_flags>"
> 
>         * Child MON group of non-default CTRL_MON group:
>                 "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"
> 
>        Op-code can be one of the following:
> 
>         = Update the assignment to match the flags
>         + Assign a new state
>         - Unassign a new state
>         _ Unassign all the states

As mentioned in https://lore.kernel.org/lkml/ZjO9hpuLz%2FjJYqvT@e133380.arm.com/
the "_" is not an operator but instead viewed as an part of <assignment_flags>.
It is expected to be used with "=", to unset flags it will be used as below:

echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/0=_" ...

> 
> 
>         Initial group status:
> 
>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>         non_default_ctrl_mon_grp//0=tl;1=tl;
>         non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>         //0=tl;1=tl;
>         /child_default_mon_grp/0=tl;1=tl;
> 
> 
>         To update the default group to assign only total event.
>         # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
>         Assignment status after the update:
>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>         non_default_ctrl_mon_grp//0=tl;1=tl;
>         non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>         //0=t;1=t;
>         /child_default_mon_grp/0=tl;1=tl;

As mentioned in https://lore.kernel.org/lkml/330e3391-b917-4a88-bae3-bdcbb8cfd6f4@intel.com/
using "0=t" is expected to only impact domain #0, not all domains. Similar for
other examples below.

> 
>         To update the MON group child_default_mon_grp to remove local event:
>         # echo "/child_default_mon_grp/0-l" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
>         Assignment status after the update:
>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>         //0=t;1=t;
>         /child_default_mon_grp/0=t;1=t;
>         non_default_ctrl_mon_grp//0=tl;1=tl;
>         non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> 
>         To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
>         remove both local and total events:
>         # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/0_" >
>                       /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
>         Assignment status after the update:
>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>         //0=t;1=t;
>         /child_default_mon_grp/0=t;1=t;
>         non_default_ctrl_mon_grp//0=tl;1=tl;
>         non_default_ctrl_mon_grp/child_non_default_mon_grp/0=_;1=_;
> 
> 	
> f. Read the event mbm_total_bytes and mbm_local_bytes of the default group.
>    There is no change in reading the evetns with ABMC. If the event is unassigned

evetns -> events

>    when reading, then the read will come back as Unavailable.
> 	
> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	779247936
> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
> 	765207488
> 	
> g. Users will have the option to go back to legacy_mbm mode if required.
>    This can be done using the following command.
> 
> 	# echo "legacy_mbm" > /sys/fs/resctrl/info/L3_MON/mbm_assign
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>         abmc
>         [legacy_mbm]
> 

This needs a mention about how state is impacted when a user makes this
switch. For example, if switching from "legacy" to abmc ... if there
are fewer than "num counters" monitor groups, will they get counters
assigned dynamically? What happens to feature specific resctrl files?
What happens to the counters themselves, are they reset? What else
happens during this switch?

> 	
> h. Check the bandwidth configuration for the group. Note that bandwidth
>    configuration has a domain scope. Total event defaults to 0x7F (to
>    count all the events) and local event defaults to 0x15 (to count all
>    the local numa events). The event bitmap decoding is available at
>    https://www.kernel.org/doc/Documentation/x86/resctrl.rst
>    in section "mbm_total_bytes_config", "mbm_local_bytes_config":
> 	
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
> 	0=0x7f;1=0x7f
> 	
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config 
> 	0=0x15;1=0x15
> 	
> j. Change the bandwidth source for domain 0 for the total event to count only reads.
>    Note that this change effects total events on the domain 0.
> 	
> 	#echo 0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
> 	0=0x33;1=0x7F
> 	
> k. Now read the total event again. The mbm_total_bytes should display
>    only the read events.
> 	
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	314101
> 	
> l. Unmount the resctrl
> 	 
> 	#umount /sys/fs/resctrl/
> 
> ---

Reinette

