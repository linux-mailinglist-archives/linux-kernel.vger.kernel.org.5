Return-Path: <linux-kernel+bounces-132235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A9E8991E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0772286639
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7213BC17;
	Thu,  4 Apr 2024 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LPKzNAhc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25682548FE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272164; cv=fail; b=EH3g+C5uC7lu5kIgEHjcVY6XHbU9uqLLRuBW6PmMbjehb2B8OUzfFyOlNZ2AE6krP/n6XItplA4lK5D3M1QCyNH9qM+Rga7vTSOT4kzfKzlmeu6wXhuhYd62cH06+9ovm/skw+rrH1UzOchjlwVWfWdjAuRUFMGf7iycWnZTZGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272164; c=relaxed/simple;
	bh=4NWTSgl4oqC9lA/Cj7dZ0w/uIPciQ4EOoDhlizkZHVQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gmS9aqrf0CNa+mEWjI2aKJEm599340DJMh8yCX9Ghgp83PlpNK9nCbEFNeWVdL9LSpryyOahGIDIwa+GWaQzETCs3MKdXxwEaDqzvX4ET62/3zYtAOMpqUBKQMF8VxAmH2CQ38Qtp0yBZ1UxSBguNR0Xb/hdrWUEuM4KaHY1JwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LPKzNAhc; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712272162; x=1743808162;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4NWTSgl4oqC9lA/Cj7dZ0w/uIPciQ4EOoDhlizkZHVQ=;
  b=LPKzNAhcBb3ybSVzknZ23jMIB2Apxml7KkfSj/MVtgAI5IDTuqfIWM72
   Ti/eSL/GoFMM2cmFdu+F1aMCSDA77YZL3s7O3oGQXIPP/7ZVqe84htfGk
   98pi+5PrHTas/IVK3VPSTwGsHt6AbikIT5Etj1gOXpy/2clPQqP+GLBBC
   lAT1hh7jZxqPeRhP7rzkgCj4flCFRIC9kQpZiifA8eHRCgdaXZlpcBRmN
   1BsJpcRivy2iVMbfzabOmP6Nhdkq+iVbrRTwTtLe2RKOJTTdGncjarWpa
   tvvB2NXc/Uj9lKZKgdS7knL1b4wvV4ZAGbdv96Q6rPGIB50cB+gRmu+Yw
   A==;
X-CSE-ConnectionGUID: dyJyIMuRSdegmMI2ih1Z1w==
X-CSE-MsgGUID: ZKTlS7hwQA6iHgDK5dlkag==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25096483"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="25096483"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 16:09:21 -0700
X-CSE-ConnectionGUID: HybXEGOZSsyZDuoMFAgMag==
X-CSE-MsgGUID: ncxdbjhqRp2y38ZBrPfCUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="19407954"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 16:09:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 16:09:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 16:09:19 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 16:09:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fb7sJrx+L7PM1iO4w2V/s0WhE5m0H3XLjWIY5OLlL9JanNacfvAUlh7uTZSpwBDUI3Z9ejU5XoROSJ69U9hpbGntMgmGlm1pab/tvjcm9xU3reWHfSv67JQSaMSWUwIRkRde9tfevBUlDJeA1iGOASomvolaZMOZPwQ6dTHl+TkkNYT3gNtgjyZ1tuy3/Dyr125lF+pMd+gbnCjrEPwGR0FWJKTa6jjrCqWnMhH3vc4dAHghTkRwC4whc8iV+xAfR1AQKtsQyOqVAUF6Qa+P+fojC7rbl3Gn5o5e32Ipr3PrcXGqEWn3OO/KdR0RSwFWXErsf9H9GdHJlxR3ED9Jog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOL7he7FtppaCowat53nleHhU4xfC/L9P99xk5nFAC8=;
 b=ZbvaMM2jf1VILlOemjcVdQ6ViDWjkPLc0FKVGCLeW1FA5nvxt3tAQ3b5FgeTakGQ85G+yUk0Bi02SGa7eGEAhq7Ng8LDnwFEGqw0Mf3RzC5sE9El5cuDICtHCJKSwLu97tYdSRnttdkzCBaqGdALtvAT4+lAVf5CcfZ56mwoDSNwWUy4eoXeKdBWyERWZQpfCOWbvHDcWU90W+5Inqh/9K8gSQ2hP2Y20gWHQYkJWwYGfHVDNriNw/viK/FN+/BRgURrKGsm6NW/KBAauDP0dfaiFcEHStXAnDPfXLTKkwIKQoaCdOEhMfqE7Ag124ZU4xjN5KPaW8KFpe4+yPaXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5069.namprd11.prod.outlook.com (2603:10b6:a03:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Thu, 4 Apr
 2024 23:09:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 23:09:17 +0000
Message-ID: <4681c9c5-3364-4628-a581-0366d0024211@intel.com>
Date: Thu, 4 Apr 2024 16:09:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] x86/resctrl: Avoid searching tasklist during
 mongrp_reparent
To: Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
	James Morse <james.morse@arm.com>
CC: Stephane Eranian <eranian@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
	"Juri Lelli" <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	"Valentin Schneider" <vschneid@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
	"Mike Rapoport" <rppt@kernel.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, Babu Moger
	<babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, "Maciej
 Wieczor-Retman" <maciej.wieczor-retman@intel.com>, Jens Axboe
	<axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen
	<tandersen@netflix.com>, Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave
	<beaub@linux.microsoft.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240325172707.73966-1-peternewman@google.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240325172707.73966-1-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:303:83::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5069:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hkgzuqnu4g6GU9jvmhqEexGAp3rTxhR3cUCrA3ErYJjAMqaq3o2//tsZnfBHRno4cbOtT1ctlvMN3OpGkqZfm5zRqoAdsUxQ/1Nqb0M09A2oL9bXQa/Ri8R5uq24nu89WmvqNLcr7PfKOEnyTyue38SOcPxcAyC/s9HONPmD62BHZA6FKGXCnBF6yRBXFABRdZuXw2x5OfRIiClaXqZAEobkmIIeSeg03apHgsFNnXmZQmmML7B1uErad+MBshXCFpElJwEfQrXozPrZ/rMcQBt8W2Xxl3iy0fdqBK7+afAzc6ulwiDxXo7REuhSgwimYBmCx8ImmIaOyZhk9CWhC1A7wWfyqF17PGAWV5DNhpgppvvT39jNby1e+fQjWqwEd30379M04GlfqRc5PE/mqY7yQ3fl3uLXIskPLthVyjlTuS/lbwedjV+/qKfpm0wmnpZB4CWyVYymtz4arYlT4Nv7iL9Q8kARQT4yHt2IgTGbSWHMBj41f/cdEBSkMmlCL9nMPm51A+zIBuL2xpar3Z+Agy8pm9oLVL0k/q3djxbFzIqYZ0sF4c8Do/w8Jd07Q8t8LOFeYe2CxmN07hLKTargJyrSnU0gXxsrzVRsrh7YX4uhFHbk0KZQDLH+075rxJaEJW36ZtNb4cKiiEc2dxqBFSw/sDZQ+xAHIZSergk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1N1RnR3MUw2a3VEZ2lRR3l0UUorWHdVT0QvZzY5YXpaT3Q3aENnUlZKaDlt?=
 =?utf-8?B?aWlWYlAzSHNETXpTbkc3cVZ0and6MFZPOXlGbTlqVDhJTmVMRzhaeFZhUE5l?=
 =?utf-8?B?Zzc2dDl3NnJLRnhuK0dKaUZabm0wemg3MzFNNXgzTWpqQU1Vdm5HTUxpb1Jh?=
 =?utf-8?B?d0Jlcm1IemtyUVVkd05NcnBvc2htTUdnMnBDYVFpeERXRzhEVzkwQjE2bmtz?=
 =?utf-8?B?eVR2NGwwNHBYZkNNMXRqSUlOTzQ0SUozalRKWDh0MmZlOTRSSEgraU95dWov?=
 =?utf-8?B?anFLZTgvL09NNUdJQkdSNDJHSTkwaHNOZ2xJQmx3cnRxVTBoNXgreVdQWTJn?=
 =?utf-8?B?U01GOXd5eFIyWDRSNW1tSmJ5Qmt5VUpsRUxpWCtsRzc1S2lmWW5GUCsrV2Fp?=
 =?utf-8?B?S1ludmhTM0l5YnkrcDFVbmM4WndvL3hnK2hOZytGMWF3MENzNzhwRmZiWnVI?=
 =?utf-8?B?dThCRWd3Q1JmRXZ1MEdEMUw0Ni9UMm16K09XdG1xVE4zUkNsd2dIOEF5WjJZ?=
 =?utf-8?B?V001VXZ3WUlERmVIMnBFOThzaEhOVGFqRnFOa0NVUU95M0lnVVR4TTcxUXhJ?=
 =?utf-8?B?MFNrTFFoVVMxS1NqWXo2dHlxZE1rVTlaNGU4cE4rQ2gvZXFTQVltSmJMeU5C?=
 =?utf-8?B?cTRrWGlmSkR1RWdJbjJnL3F5clFrRERCRGRYOENsaWJHSFRmaFV1ZjRlMnlj?=
 =?utf-8?B?N0s1ejVLR3JvYWsvaS80UEVRNXF4T0NDdmp3MDVqYlA2ZDNudUpMWXM4OUVD?=
 =?utf-8?B?THpxV3pFdG1PWjZYQXNwUEtYQWgxdjFoSloxVUhqcXZoVkdUMDcwNEJhVkZG?=
 =?utf-8?B?YnJFNkVxa3Jmem9iYXJuWWY0bXNBc1RCQXVsL0pncDlFTkR6M1ROMlVHOGVC?=
 =?utf-8?B?V2tXUjViVDVyV0JpUEtZMU8xZ2RUb1VNdWZIN3pIL1JnUDgvdVBBQ2c2VDgz?=
 =?utf-8?B?azBaYTAxSWZUMmVZMEUyWXBVb3IzSWdLb3plaTdobGVTSkgwNlJDNkhjK3RV?=
 =?utf-8?B?Q0ZMS2JiWXpkbS91RVBUeVEwV0hTdmY1djM4OW1kMytTVi9sbWxHcXhiaWhX?=
 =?utf-8?B?Sk9zT1NMVDIrZHgza3FJZ0k2RzhYZGlneS9Rem9HM3BTay9QcHVvRUNKQVlu?=
 =?utf-8?B?OWxxYXR1MXdOelVlbGVJNlRVcENLSzNWWXBvT3V4NjVaeHBTN3lMTng2SjRS?=
 =?utf-8?B?UVhGVk1WZFlRT3pBTkZtYm5LZ3h2Z2dBQnFtd0ZqNEFKQWdMdHg2UUJCMXAw?=
 =?utf-8?B?ekdyNkNFTXUvV2hVdGgzd0RQeWtmUHlUZzFELzJrK2t4RGdIU0JRUGl1QjdT?=
 =?utf-8?B?K0pwZGpZbWVmOTY5RnJ4NDZISnNuYldxSTlyZWNQSmdkYVZWeGYvYmNKcjZY?=
 =?utf-8?B?MVZhaFBVNDNIaHptOGxhNDlWVGM4eEdYSEw2RXhDbVpKeS9hNURQNjB1M05x?=
 =?utf-8?B?Q2dwc1c4eDBGSmJCTHJJclZ5eXY2NEVWWE9lUUYxWEF4SkN0dHY1NitmYjlO?=
 =?utf-8?B?RCsydE05K2VMLy9WVW9XWEs2Z2VlZTBmLzdVTFBLWU5jdmg1MThCT0F5WVo3?=
 =?utf-8?B?MmFIaWZ1TWxuOW81UDE0ODVyMWhtVXpvSFJSQVZ1ZkF1eE8vU1N1N1dsa0tD?=
 =?utf-8?B?SHdPaXZtaTBRa2hsczdldGE4Qjc3cVdSWk85L1hGeTQxcUlkVFhJL25FMS9z?=
 =?utf-8?B?d1BkOUpyeDJKcThNVHVORzUzeU5ZaDF0TVNmNVNMd1FqS1VqVTVaSkpWd1d3?=
 =?utf-8?B?Nmlhd3RsVlBNNjJqTHBjeW1sN2xKR2xiaGFUalB1ODc0TStQRjBwV3Q0UjBv?=
 =?utf-8?B?Sm1pRnBvTzRGZGUvWngvUmZOTmpjblVBWTdiZzU5bE9iQlZDL0xyckhpaUtn?=
 =?utf-8?B?RHozU0E1QXpyOEUvZkVWUEFMNmtIU2x5QW51bXJucHhHc05WU2xJeHVudmcv?=
 =?utf-8?B?RDgzblc2V1UxVCtOelBZMkdkS3ZId0R5QmFBRUpuRW5aSHJzYmdtKzc0Unpx?=
 =?utf-8?B?emx0RUEvSXlMTGVnTDVwalVSSWFhTU9kc3Q5aUY2RWRWb0xXMUNUZEswbUhi?=
 =?utf-8?B?YjhJSnhWQ3BvTTVlNlNLbW5odHdOeUNCN3ZIOWRNd2cwcExzbnprOGRNblUx?=
 =?utf-8?B?UW5UUUZDcm9VK2ZmblphUkxubGhsQzBGckViUU1YbDRvUmIvbXQ2djFWNTdP?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dd1335-6f6a-49f6-e481-08dc54fc404c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 23:09:16.8901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9iNI4qWBgV1pyxzpPUu8bOX2fdHLrQYuHnPm2gTSKWRTwD1cnDAhLlJtv9CjmFZTN/YiKK8yY2eEHi7hoJHwiYtG6dcgLNod0GIpPmpwCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5069
X-OriginatorOrg: intel.com

Hi Peter,

On 3/25/2024 10:27 AM, Peter Newman wrote:
> Hi Reinette,
> 
> I've been working with users of the recently-added mongroup rename
> operation[1] who have observed the impact of back-to-back operations on
> latency-sensitive, thread pool-based services. Because changing a
> resctrl group's CLOSID (or RMID) requires all task_structs in the system
> to be inspected with the tasklist_lock read-locked, a series of move
> operations can block out thread creation for long periods of time, as
> creating threads needs to write-lock the tasklist_lock.

Could you please give some insight into the delays experienced? "long
periods of time" mean different things to different people and this
series seems to get more ominous as is progresses with the cover letter
starting with "long periods of time" and by the time the final patch
appears it has become "disastrous".

> 
> To avoid this issue, this series replaces the CLOSID and RMID values
> cached in the task_struct with a pointer to the task's rdtgroup, through
> which the current CLOSID and RMID can be obtained indirectly during a

On a high level this seems fair but using a pointer to the rdtgroup in the
task_struct means that the scheduling code needs to dereference that pointer
without any lock held. The changes do take great care and it
would be valuable to clearly document how these accesses are safe. (please
see patch #4 and #6)

> context switch. Updating a group's ID then only requires the current
> task to be switched back in on all CPUs. On server hosts with very large
> thread counts, this is much less disruptive than making thread creation
> globally unavailable. However, this is less desirable on CPU-isolated,
> realtime workloads, so I am interested in suggestions on how to reach a
> compromise for the two use cases.

As I understand this only impacts moving a monitor group? To me this sounds
like a user space triggered event associated with a particular use case that
may not be relevant to the workloads that you refer to. I think this could be
something that can be documented for users with this type of workloads.
(please see patch #6)

> 
> Also note that the soft-ABMC[2] proposal is based on swapping the RMID
> values in mongroups when monitors are assigned to them, which will
> result in the same slowdown as was encountered with re-parenting
> monitoring groups.
> 
> Using pointers to rdtgroups from the task_struct been used internally at

"have been used internally"?

> Google for a few years to support an alternate CLOSID management
> technique[3], which was replaced by mongroup rename. Usage of this
> technique during production revealed an issue where threads in an
> exiting process become unreachable via for_each_process_thread() before
> destruction, but can still switch in and out. Consequently, an rmdir
> operation can fail to remove references to an rdtgroup before it frees
> it, causing the pointer to freed memory to be dereferenced after the
> structure is freed. This would result in invalid CLOSID/RMID values
> being written into MSRs, causing an exception. The workaround for this
> is to clear a task's rdtgroup pointer when it exits.

This does not sound like a problem unique to this new implementation but the
"invalid CLOSID/RMID values being written into MSRs" sounds like something
that happens today? Probably not worth pulling out for this reason because
in its current form the exiting process will keep using the original
CLOSID/RMID that have no issue being written to MSRs.

Reinette

