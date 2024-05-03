Return-Path: <linux-kernel+bounces-168417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C83028BB852
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1A0282A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0CE84A56;
	Fri,  3 May 2024 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXRbLEhq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932C290F;
	Fri,  3 May 2024 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779248; cv=fail; b=Y8CPTHZaHp9kpUGAJVwCOAyQIGfndDSY3qUxX4WBXbXsWxJ5/+XXfqtNyOH4LKXTG3K9aGfNJj4vX1dRAXf8BE9kfoVLPzNuzZTNsW1LOrmuNERg6BB0/ua8vkXf7fh3geaI8Km8Se0ZLV5+RuEvvZ9ziAsxUrgLoITFo3SrUxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779248; c=relaxed/simple;
	bh=YthRoeLFNcZARS9/vagqbzk+jauZrvqg2OYZuOVhngE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ue+Wfg5ceDxBVPJy7uPanCC6rZZtwEx5VYyolQ4cXFx87RTAgKgvVHE891R6T0gfbEg1FWEao65x5+tP8SpqHuhr+4X69IsnZ0NFrY9aeq9FqAF3pwlVsmkan158xAEKpH8lHVqlA2r7HPP2nlOi6n/V3tkzLkfzDiC14OwvFbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXRbLEhq; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714779246; x=1746315246;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YthRoeLFNcZARS9/vagqbzk+jauZrvqg2OYZuOVhngE=;
  b=CXRbLEhqEdONNJU2Da6eibU0nK/sfM4uo3nMODt7TlDdeIIdu0Eg6+SN
   YjhHlkdGQDVs423OQdKIdniLPz1uhw0aaruS618Si+vhCTmagcogkPaDy
   icuqRRQ0Tv+HRXl+rMf2Y5nSTv4cT5ergHRSwXiALUJCw+6JASPBXitfR
   Zg1YaDPz9Db9rwU9PNITUJYk2vo/2FF8Cop5TGOjNMlnG4I5Uwm0Emshf
   sl7NEjva+OkgazMKBC0Y3qMBoLRLKMu3JqrTdlP4xT8JH+nhqBm9epH2f
   akTDgeq52mMy7LxnxnK7ck+HQfPQ0qN59MR7nEn5eiZgNIOaGH5wqCM5t
   A==;
X-CSE-ConnectionGUID: JUwYt6elSY+Z13WfXorgJw==
X-CSE-MsgGUID: Hf2/OH5FQcSZ5rptEcTosw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="13545897"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="13545897"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 16:34:05 -0700
X-CSE-ConnectionGUID: 1B3rC3LMQE2+ws+d+hAu/A==
X-CSE-MsgGUID: d4tPmHMcR5iKVysaY0N0Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="27565438"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 16:34:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:34:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:34:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 16:34:04 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 16:34:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l98+nXiO8+m9pHH8PnfznYCvQov7aUG5gEKvz8EfrKrJj2Iqm9mXxigNydRYCnGy66MNIyNC+9ef0n7JeKgl1rkNpl0GqO6eAT2rYCRLQM2kkjhDKAS23W5FP2MSWvL1kKKKPEsltTWlc2/5tGa/R2dFWZGsS7IsFtlfsvg4OvxgIZa39+6MYRFpLXangJ8QUPrrU79h+13rCElUtT5bNpEWospGTqX9rqvyyXqH9R7PqdXXnRNd6+DceVbdOvZeT92/i/SUlxaAgP41toOrcWYZFa5/DGSjnlxVkZ+MFYNpI2K+eZMchnAzASCc9vZobJn0FIwVQ7mn1jCW1wNFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TuWpmI+kbmJOBlIpV86wsjKgayHgC3ZCkja6RQve6Y=;
 b=itT6NpXJRWv5vUF77KwqWJRQGR1XWgfCEiLtr19dE8QZ8nj6fs5XJk7WnZM4AI+ZTWB3nH9apmVR3k0ZdBZdr9B1YjXuFGZdyNs5yDh9b4TXOgiO5BB56NYk+rWv4ydARPnMs5la6Z2GrEXmqoiLyqochR39wvm2rpWOEt6a8dAFsZM0zrlLB0YeOPq4Xhjo45tyIf5rVGQebUlModwp43EKSag/fWhkalSWTe38ue9R6P7bldkHD+A7Si8ugV7/mAChm6a5ukuelGTnJswH/lOh2ETf6pOa2bkncsA1RLr4jJS91EkfgEIhgYf5NlGfX8vdCFlrdQvNP/jUW0WNAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 23:34:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 23:34:01 +0000
Message-ID: <b5e68d85-4bf2-4e55-a9c1-b39cb7d94db6@intel.com>
Date: Fri, 3 May 2024 16:33:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 12/17] x86/resctrl: Add the functionality to assign
 the RMID
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
 <a6cb26639976873b1b85ec1606c2168493120ba3.1711674410.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a6cb26639976873b1b85ec1606c2168493120ba3.1711674410.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:302:1::40) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: d9af1b68-39af-4a3a-7de8-08dc6bc9833e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REV3c01VQUpQV2YzRitUYnR3S2tDL1RuamNIZHg1THJJUTVKUG9FSDJGUzFU?=
 =?utf-8?B?VFhSMjdiMncrRDEyRG5wU2ZvbmllUkFRS3NWNXFaa3lRZ2k4clhGcG5BS2E3?=
 =?utf-8?B?ZHVYT0xBdHVweWtJT3hZYjFMbEpUM2FSdWZlMW53ZFZYbnhCMHJQR2laWk1V?=
 =?utf-8?B?cTRCNE5Sb2U0SHFPSU9HUndjaE5TRTJjak1ZaW1iUG9LSFhtdUxkdVpMUEV0?=
 =?utf-8?B?UFR2N0hBMEVXV25VMXM2Vm5aWFpDZmFENG1ETThwOStpRE1VTTNyWVRWQk5q?=
 =?utf-8?B?VHZJOWM5K3Q2RkdnMUxLUXEzMW9JVlorUTdQMTNTa1V3MkpGOU1wZ0xvUzVn?=
 =?utf-8?B?MlZweDNuVXNydW9ndVF0enBqSzhDUGQzMHEvdlNmWUpIRW9qUUdEN0xDazFX?=
 =?utf-8?B?V1lMM1Qya2hSa1Mya3laUFRRcVZDdzB5MVZCeWp0YVFoWUpqdS9maGp0M2Rx?=
 =?utf-8?B?anBOL2NhcVpBYytZR1pJYzQ2bjlnb2NJcXdRSTErKzE4elVCSVBhOWViQVlD?=
 =?utf-8?B?eHA0TTFRbjc3RkxzK0VuK1lVR3drajZrSU8wTXlUTXVpQlk2LzFXSDdoOWRI?=
 =?utf-8?B?cGxPc1ptUzJzTWpuaEcxcnBuWnl1TjZCR0UrN01Lc1lQKzUvSmFFQ3R1MTIz?=
 =?utf-8?B?WXg0S0J2cXJ5bmFpOFBHbFFUaHlObmZ5MCs4MkpocUw5VVhUK2syQWVISWND?=
 =?utf-8?B?cnFRd0lVY2NmVWxvVXlxYXBiMmdDY08xTWQ3bklEM3FxQmhFTHdkaDNlNlNX?=
 =?utf-8?B?WGZaVDJzamhVcHQ5cGtoUWtTOUR1bFl3aXlQSm45OFhSU0VhNXBoR1ljZUg3?=
 =?utf-8?B?M1grMmI4VWRTRDcrNXV3UjVueEM2M21OTzhTYmZZYmNDV0w3a0ZWUm9DZStU?=
 =?utf-8?B?OHF2T2trSTBkVk1CQjRvZ2NteENnUEkraGcyQk02MjI4STVBdjNNUWhqM0N6?=
 =?utf-8?B?YkpiYi9xQVZvL3NFRUtUN0Y0aEhwQTk5MCtmejBkTXJFdjFnODc1Z1g1Rjhj?=
 =?utf-8?B?Q1Z6L2VVZGx1MXZ2U25OY3VBYnNMaWdpbk03OEhFLzd4UGltdDlKbDVTYnpk?=
 =?utf-8?B?ekx4a1ZxWTFaMkNScThuSDZqRWF0Sys2NHFJR1c5TE5NTWw3bFlIR3YxTHYx?=
 =?utf-8?B?KzQ0cldTenMyQmNWRHRONm1yb2VGaGJYcXdoeU91amp1L0tRVm11N2wxbVBw?=
 =?utf-8?B?Y0dJY1RQcE9xbzBVUHhsdWRVMTBpaCttR1dNVkRjcVJPdHlrU2RWNG9kN2RC?=
 =?utf-8?B?Z0FxUFNaZ3ExZk5DRjdJTlU1WS90d2NYeXg3VktyenJrRzc2K0RoN3JiRFRY?=
 =?utf-8?B?WnBZM3huVldubGxXN1g5QVExNkxtREI3ejRzN2JqMnNOa1Rsd2F3SzR4aTZI?=
 =?utf-8?B?VHUyS01rMG1ka1lndk04SUJ4QzdsNlByUVJyTlQwVEc4V2xjWFhwaUd4UHpZ?=
 =?utf-8?B?ZW1pa2grK293UGRoZVlMbnZNSlJxWVJxZ012R09iS2ZnZDhrbEE2a094RWNv?=
 =?utf-8?B?WEp2bzVLUUpWT0lzM3hBMXhqM2JkL2d1QWs0RUMwcVdLaC8xUjR2bmNkd25Z?=
 =?utf-8?B?cTh4RzZyVW1pQjRtVjdpN0JPS0tmVGNlTVVBdjlkVVkvR3d1aDAreDMzMzlw?=
 =?utf-8?Q?cBpOf1cL91tzTWK3xF8tHCxWD10UiVYCHnUb384uVzm0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHgzZmoxSWJpWHFXODhMeHlwYkI3TEJRcHNPZDhkTXc4bHZXcVEzRmlRQktN?=
 =?utf-8?B?R3AxL2VKVHhQTFlSTzhWS1dZVlVHNW5iaXo3VUQ4bWZuaVNnTWtYbUpGaHBQ?=
 =?utf-8?B?Mld3Q3F1ckhEcVdyOFBuRU9jc0JWa1FuQzltYzhJdXZHaTFadWwwckkxTWgv?=
 =?utf-8?B?eHVIYk9zS1hwYVRHWEkxRTNWSWU1YnF6cm9IWVYzeTRBTlRMYk9ZMlludTVY?=
 =?utf-8?B?R2gwWlUvQ0V6WEgwMFNtamtweVZFS3B4cHd5ZlR2Rm5vZlRRelJkS1BWWnFp?=
 =?utf-8?B?NzZlY2d1Zksra25XYkovYXRFK25YNDkrRkVpRFQ4bmVoYS9Xd1pTL1Q0WEQ5?=
 =?utf-8?B?bXVSbTBKYUNGL2ZGUzV6WUhhNlR3TEs1cjBZVHBWeDhXcCtYWkdrRzkzOTNJ?=
 =?utf-8?B?L005WFJQNkR1ZTlBTkNhRHFDK0diQWNVNW5UajVTWkZGait1RGtlTGRpUzN1?=
 =?utf-8?B?aVk4VDhsQloxenZlLys4bHhrNWI5RjVQc09pc2IrWnZvSUpHU1QxdGVmRmN5?=
 =?utf-8?B?aUlmTnNyREdTdWNWdjE1cGtVTjZPMXdaMEIzTkk3WC9TZUIxbzB3K0YzUm50?=
 =?utf-8?B?Myt5NGNXcU5pbjBWNVRiN1kwK1hTWjYzaWxzUVdOYXIzeC93WERHQU81OXNF?=
 =?utf-8?B?Q3VsTFJOd3R1L0tLUy8vQitwZkxWcFArYUhEZ2VHSytuRTZFWVkrSVliZTZt?=
 =?utf-8?B?eG9wbkliejUxK3hjNk1uWmpVSmRrdDBrV1ZGY1RRUGx0eW56a2x3eWhtTm1K?=
 =?utf-8?B?V1dsdE5MQzFTeVlIVCs5VTRtejR0cDZUMmM5SkwvZ0V5ekJLM2tzd0pKOUFs?=
 =?utf-8?B?eXdQZEJqU0x2TlJ3eDhsOUJqTmNjK1ZnNDJCMGQrdUhHS2xDV3FvTFVoZlkv?=
 =?utf-8?B?a2ZOTys5KzJPNmExR3RYOHlOTWE1d1lVOFgyMkJValRjMkM0U24rNFludEt2?=
 =?utf-8?B?OEMzUEoxQ2oyM1JEcytJVitVVk16N1gzUGRJZ3FTVVlSVEIxK3VCeStqLytI?=
 =?utf-8?B?T2xmS0RkT2JtMGg4QXF3TitHLzZ6c0xOWGU5dVFzMkRyL2EvVHcrSERTb0N4?=
 =?utf-8?B?YTlBdUtuWGZrc1Z1dERPdW5tdzg2eDVpZmNRcTVrenEreGczV2tXY2VqMGhB?=
 =?utf-8?B?Y2ZyVWxVYWRUdGxKYXZIQXdnRDNrYXFBTzR4dnp5QVY1cVJ4dTRUMVFaR0l4?=
 =?utf-8?B?elFKM3k4Y2wxK1FMaEhNY01peXFiTktRRXNjaXRGOHR1YlMzWjFRZWJ3algv?=
 =?utf-8?B?eFhNdjFHMkFYclYwN1F0UG5BQUg3WGY5aWZoQXN0Z2ZrSzNzVHc5ZHpkV000?=
 =?utf-8?B?OVBQNy9CMWVHM0gwV2VKS084V1ZyZEdzd1AyaUtzV0Z4MEZYVmxTOXFiR3ly?=
 =?utf-8?B?OWEwSkZiN2Q4Y2hCeDB0SjluUFNZdFhLZ2loK2VHZGpIVVJTYmhUblJPZ1RG?=
 =?utf-8?B?eVlJSGVmV2R0NllVbUo3b1d3dFpMMHdBamtpYUpmQXVOSHpkZjJPTTIzYkpM?=
 =?utf-8?B?QzZRM2JzWUd5dWwxYUdhTmhORitZZGRCZTRpa202bDNVZ21ST1FaelprbldR?=
 =?utf-8?B?SFlHbEtGcDJ5V0NWZHMzU29LUWJCODBNZlhZVnVhVzZCQURtTXFxOWRhd2FD?=
 =?utf-8?B?Qk0xYmZjUldWOHl3OTRhV2V4WHBlaEhwam82MW1oc29BUk1jVExmRHNBR00v?=
 =?utf-8?B?ZThGR2xTeU94cHl6THlpcW9JdnY4K3VSUWw3QTVpWFBmQmhxSDNzbCtCek8x?=
 =?utf-8?B?dVROUVd1UkNQQVgrdjlkc3ozb3dmQkRDM0I3QVhoZDc2d3BNSGwxWExuOUpC?=
 =?utf-8?B?ZUVNYkxZaUl5TkNnc0swaFRFR2U0QU1NRzdabTlNUnlNeUVXNlVkUGFHK3hQ?=
 =?utf-8?B?YjRQQnVYdmhLRUdXaTdIdDRjeFk0LzdqSktreXMyZWxrSDBRdkNzRU1nbC9Q?=
 =?utf-8?B?bXY5dzNXblJSbHZWSElxb0JrZDQyR0hBeDU1U1k2QmU5Q3dUV0Jic2NFZTRj?=
 =?utf-8?B?WDBBaWN6eWZ0RjNQMDlDSUVMOXhmaUlXN2kydTJUaVVwMVlOSHh6cGZ6di9m?=
 =?utf-8?B?V1FDY2RqcEgzdHpMUUxJb29DSWVQdlkvUFVtbW4rR0lkU0hEVDdWanNuWjFG?=
 =?utf-8?B?KzlJTWVNWXVLUGQ2aVU5QzNTMjZzNzdFMVhOSGgwZllTWUNLbHpkUSsyZFky?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9af1b68-39af-4a3a-7de8-08dc6bc9833e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 23:34:01.5659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzrcVCpyRjVnieqgY7LhzfwWWpsH5mBA60RyR8oYPcJUFXCipxXCSV/xzWJcHRGdoWeBnzsHTjEPr2lXE6YRd6e3Fj2CuwNyJo/stcPf4hU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Hi Babu,

On 3/28/2024 6:06 PM, Babu Moger wrote:
> With the support of ABMC (Assignable Bandwidth Monitoring Counters)
> feature, the user has the option to assign or unassign the RMID to
> hardware counter and monitor the bandwidth for the longer duration.

What is meant with "the longer duration" (this term is used throughout
this series)? Perhaps "for as long as a hardware counter is assigned"?

> 
> Provide the interface to assign the counter to the group.
> 
> The ABMC feature implements a pair of MSRs, L3_QOS_ABMC_CFG (MSR
> C000_03FDh) and L3_QOS_ABMC_DSC (MSR C000_3FEh). Each logical processor
> implements a separate copy of these registers. Attempts to read or write
> these MSRs when ABMC is not enabled will result in a #GP(0) exception.
> 
> Individual assignable bandwidth counters are configured by writing to
> L3_QOS_ABMC_CFG MSR and specifying the Counter ID, Bandwidth Source, and
> Bandwidth Types. Reading L3_QOS_ABMC_DSC returns the configuration of the
> counter specified by L3_QOS_ABMC_CFG [CtrID].

This mentions the AMD architecture parts needing configuration but not what
resctrl parts are used to accomplish this configuration. It is difficult to
understand this work without this connection.

> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>     Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>     Monitoring (ABMC).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
> v3: Removed the static from the prototype of rdtgroup_assign_abmc.
>     The function is not called directly from user anymore. These
>     changes are related to global assignment interface.
> 
> v2: Minor text changes in commit message.
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 86 ++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 88453c86474b..9d84c80104f9 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -651,6 +651,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>  void __init resctrl_file_fflags_init(const char *config,
>  				     unsigned long fflags);
>  void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
> +ssize_t rdtgroup_assign_abmc(struct rdtgroup *rdtgrp, u32 evtid, int mon_state);
>  void rdt_staged_configs_clear(void);
>  bool closid_allocated(unsigned int closid);
>  int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 7f54788a58de..cfbdaf8b5f83 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -202,6 +202,18 @@ static void assign_cntrs_init(void)
>  	assign_cntrs_free_map_len = r->mbm_assign_cntrs;
>  }
>  
> +static int assign_cntrs_alloc(void)
> +{
> +	u32 counterid = ffs(assign_cntrs_free_map);
> +
> +	if (counterid == 0)
> +		return -ENOSPC;
> +	counterid--;
> +	assign_cntrs_free_map &= ~(1 << counterid);
> +
> +	return counterid;

Use bitmap API ... eg. find_first_bit() (eliminates
need to adjust counterid), __clear_bit()

> +}
> +
>  /**
>   * rdtgroup_mode_by_closid - Return mode of resource group with closid
>   * @closid: closid if the resource group
> @@ -1848,6 +1860,80 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>  	return ret ?: nbytes;
>  }
>  
> +static void rdtgroup_abmc_msrwrite(void *info)
> +{
> +	u64 *msrval = info;
> +
> +	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
> +}
> +
> +static void rdtgroup_abmc_domain(struct rdt_domain *d, struct rdtgroup *rdtgrp,
> +				 u32 evtid, int index, bool assign)
> +{
> +	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
> +	struct arch_mbm_state *arch_mbm;
> +
> +	abmc_cfg.split.cfg_en = 1;
> +	abmc_cfg.split.ctr_en = assign ? 1 : 0;
> +	abmc_cfg.split.ctr_id = rdtgrp->mon.abmc_ctr_id[index];
> +	abmc_cfg.split.bw_src = rdtgrp->mon.rmid;
> +
> +	/*
> +	 * Read the event configuration from the domain and pass it as
> +	 * bw_type.
> +	 */
> +	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
> +		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
> +		arch_mbm = &hw_dom->arch_mbm_total[rdtgrp->mon.rmid];
> +	} else {
> +		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
> +		arch_mbm = &hw_dom->arch_mbm_local[rdtgrp->mon.rmid];
> +	}
> +
> +	smp_call_function_any(&d->cpu_mask, rdtgroup_abmc_msrwrite, &abmc_cfg, 1);
> +
> +	/* Reset the internal counters */
> +	if (arch_mbm)
> +		memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
> +}
> +
> +ssize_t rdtgroup_assign_abmc(struct rdtgroup *rdtgrp, u32 evtid, int mon_state)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	int counterid = 0, index;
> +	struct rdt_domain *d;
> +
> +	if (rdtgrp->mon.mon_state & mon_state) {
> +		rdt_last_cmd_puts("ABMC counter is assigned already\n");
> +		return 0;
> +	}
> +
> +	index = mon_event_config_index_get(evtid);
> +	if (index == INVALID_CONFIG_INDEX) {
> +		pr_warn_once("Invalid event id %d\n", evtid);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Allocate a new counter and update domains
> +	 */
> +	counterid = assign_cntrs_alloc();
> +	if (counterid < 0) {
> +		rdt_last_cmd_puts("Out of ABMC counters\n");
> +		return -ENOSPC;
> +	}
> +
> +	rdtgrp->mon.abmc_ctr_id[index] = counterid;
> +
> +	list_for_each_entry(d, &r->domains, list)
> +		rdtgroup_abmc_domain(d, rdtgrp, evtid, index, 1);
> +
> +	rdtgrp->mon.mon_state |= mon_state;
> +
> +	return 0;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{

It is not clear to me where the filesystem and architecture boundaries
are, but I understand that you and Peter already discussed this and I look
forward to next version that will make this easier to understand.

Reinette

