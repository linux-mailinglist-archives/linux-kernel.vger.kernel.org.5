Return-Path: <linux-kernel+bounces-168416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 899098BB850
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB611C22B73
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2B84A56;
	Fri,  3 May 2024 23:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzKd+LXo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC683CC4;
	Fri,  3 May 2024 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779191; cv=fail; b=LUa2mtfBlzAQRij3HMVg8eGEO+76pg0XYE/zFyQxITyEO4N+XjJXUZqmNBrqW4Uh5j1YQ4W62m1a4j9p3vGDUqrvr/ZlGCh2eB82BrDU8adT/r7LzQGJbUnEH0h7m5hn/sWienQdxJmPZT3x1jIqX5VpB9vxXDwVopzlHQOxbeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779191; c=relaxed/simple;
	bh=Fkr3qMQFglLgs+KVeBb4kMTE8GeefXK+X6V6DZKE1eI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NHXTQ+WhM99u0cMZTR7f8vZKeKQ0SY0cKyy2b4CQusFmnCvqd4EddA45XdrS3Xl3c6od8MTaoaAocouhL8b6rBRkzI56FFMSaOyfpiwJAhafjMZh9aQsoqC9oumas5bIJSUR+Ea9f+JqrIBOizVK+9rswTeIfhB+7oR/+BVNUQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzKd+LXo; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714779190; x=1746315190;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fkr3qMQFglLgs+KVeBb4kMTE8GeefXK+X6V6DZKE1eI=;
  b=SzKd+LXoiZS2bGkuXT/1NmGTem2SMPQPpXm0kXRmGQdShyUfuDAyklk2
   hj4xaEp3Clm3v3V8e3hqNx/SkD4vmKK+AmV7PKVwhQ/bTD+lczuJkyMtj
   S9oCWlVGb88MCUjDQFcQczPgJXGEMYxGdYTZ9WzKKGj+kF6LoZZzYpvC1
   5TDW0bFxCAtWjZaFMsoBm2qbav7oLxgAf/4BYnxFEhyZaJbm/SYPNVEJk
   W86qB61eXKUzRiIiY49S2biW5F8/ryLTsgvK1q1yIPZMsFa/Pe5OLZgF0
   V2L2Yz/CK3lAMLB9RKLhCgS3OqFdLzg4u0nIqfL0Bja3IAd1jxBDAtMv6
   Q==;
X-CSE-ConnectionGUID: WJeMlJxATt25syfe/qG7jw==
X-CSE-MsgGUID: 7eEJ7gvFTo+NOIQwBm0eJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10529565"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="10529565"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 16:33:10 -0700
X-CSE-ConnectionGUID: a0KDNlIjS223Z4fL7v6b2g==
X-CSE-MsgGUID: jyGirqK3Qe2HeFxf45hzSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="32272051"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 16:33:10 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:33:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 16:33:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 16:33:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT3hRYAsUkKju5C81kZVj03UB2JQ73hltnAx3b/s8wsyLzdM4uICuFzYAqZStPH97vTPSAXhUbml+ZOOYgWEGidCzNiT4/N0lxHu6gOrIPJZMAv2pX4u5HrME8kSjhhGF3vmtixIgBcbhz5hfODHokoO96YkClaPiddIwsRwJ1uAajQPbC8xujvjeUmU85zpAXrZF8TwShlETds703IYSpswqmtBVwv0KmG3O1ctWvmHUN620tXaTtC0aIo5QJ0XivH9iV+W3zhoZFc8x706epgHnx7PUWqzZ0PpLCe9RdqQ9IR5NuOAUVpr/59SD4dk3jTrQjOH/fNhcQc1voMPwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsvSvvvfDgKGu4MpN6ZCABYgkNXlqdIeXVvhgyuEcfA=;
 b=bFRR9sgYHg08wmpU1OIsXu0HVMjYvpZTL0jznGHKoKzngtM1QoVRSGzQPh/D/dZSBsDyXuDpv3Nn5xTlryzZ64L9Heox0VdW4DF625i7q2X9k+4Q8KRWito0u5n+hrkZI/TYJm8SGM4qoEL1dEld9M0xWKMeMHCGPbzRnjd/IWUcycHqSYnd08FEyhHAXXX2RQx1r3DoHznB6jkE6Y6RAS3G0Wdv9pMR7PDRMhqGnImvRxGF+gFd81C/wtDovfEIfBiz32InY1w+lS8/bR29Sm4QiaO+LhQA9eeJ/09HDl48nTQy76Tp1tJGEXFwklgHIOBpuOvVPEgvwzPGAZQ99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 23:33:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 23:33:06 +0000
Message-ID: <5c612f5c-7709-49db-b998-a676b61245e1@intel.com>
Date: Fri, 3 May 2024 16:33:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 11/17] x86/resctrl: Introduce mbm_total_cfg and
 mbm_local_cfg
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
 <46f83accddba3c25a428d1a30f6091913a4f7c73.1711674410.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <46f83accddba3c25a428d1a30f6091913a4f7c73.1711674410.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bb9799-2f63-4c37-d17b-08dc6bc96240
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWg1aFJYbGE1dk9wTXEwYlo3Qko0TGZ5USs4L1V0Qzcwam9yRkJSRytodmVF?=
 =?utf-8?B?OGk0UU1WeHd3eWFzcWJGTldBZEZnNEhSVmVHR2NkNElSTEhnZFZWYlVGNWN5?=
 =?utf-8?B?MmFsaGFWeUJZK0JXUXFDaTBCaVNHNSttN0czVmk1MmFOUGhObm5kL2MvZWtB?=
 =?utf-8?B?VlhvSHpzV0hlZVpMU1BQQ1NycmxXbTg1cGVMODJYcHMrL2xqR3VHdEZuQTNt?=
 =?utf-8?B?OVdaTnJ1R1B6Q3MvS1JoOTNuZy9pelAzRndCOGFjOEI4d3p0RUFURk5qby93?=
 =?utf-8?B?WkJRUkoyQnJJT3FrOURCeGd6RWxuOGc5TEtOVWFUNEo3S1FNeExrem4xU24z?=
 =?utf-8?B?YS96N2pPWm1xcm01a1NQVnI0MHJxSy9pdWVmVHRGS2lGdytlZDJsR0lCUFBU?=
 =?utf-8?B?S08yUy8yK21pODZ1OEVCS0t2WUtHOW4va0xKeXI2Tm1URlpLeGVnbHd5VVli?=
 =?utf-8?B?V2V3VW5NQ3ZzUmpFL2ZvUFRWd0UzakpkenNaZHpnaFVoNGJQYUJKa0dZSjJx?=
 =?utf-8?B?dDR6NzZLVkxGdWJvR3ZKMXk2eEJsSVBKSGt2Z0lCaTJ0VHQ0V0hWZTVhNUZT?=
 =?utf-8?B?Z1hqcmc0L2UvaDZpN0Z6eGk4UXJsV2Q0MXVQVExqQnlUN2o5a0tqb2dvamZo?=
 =?utf-8?B?aEhkcHgrbFYxMnhxeFc4WGZwWk9hcU5qOXRoYkpQeGEvbkt0QjZDN05RZkFk?=
 =?utf-8?B?Y3VBdWo5b0Z2OXZENXpxZ1pkSVAxK0JnbUVqOXpab1RoalJ3TXVJdHR1VXpF?=
 =?utf-8?B?elIya3F4aWdoeVNBWHlaOU9OZ3RwUnVFcXhqemNJb1dON2xwYXhEU0FGUTBj?=
 =?utf-8?B?UG1PYlhhVU1RcVMyZVNRaHpqZ1JlTU9FM1Rkd1F6dUtBSEpSZkhGaStBYnNt?=
 =?utf-8?B?L1NRaUY5a1BMOENnK2hRQ2xJRDAwd2pWN29wb0h5alVSZm1nZjRkUkdvUWpD?=
 =?utf-8?B?b3daeGg1UC9BamZMUm1tcE4rQjBmTjVkWkthaTI5K25hMnEzdzBtTDdRYktF?=
 =?utf-8?B?VitURUY5eWRaZ0k4QkFXdVBjenFOT001aEM2MG5RckpnMUQwV2V4MWtNZ2lG?=
 =?utf-8?B?bElFOGdBdG1jNjB6N0NQNk1Id2svUG4raXgwMnpnMXJ4cDBacU9qRkZuOW51?=
 =?utf-8?B?eHJORmcxL09Ld3U3U2xCNENhYm9GMW42a011SkNTMyt6NDNoOHg4WTZCbU0z?=
 =?utf-8?B?WkJVREtlSFk0eVo3aTRKZ1BlQnpEUnN4R0ttdkU4S29tL0lPak1nUURvUHRn?=
 =?utf-8?B?ZEF1cTZmMGtjQ01GUi92MUdORHBqTDFBandJS2tDdm9kanVTTFNiWER4OFdi?=
 =?utf-8?B?RmRFS3lpNit3M1VJRDdxZVVDTk10bGpoQjVlZWtrTzJISHQvSlNJWm1CUmp6?=
 =?utf-8?B?YWxvbzhBTE5ZdW5ab3VYc2tWem1XV2E0NkRLVkFQUUhGVUh1ZkNyNGY3VWRM?=
 =?utf-8?B?SXF6UnNyLzVSVEJFeGhTaTRZdnpuTEkwbTBzdjlWN0x6b3BCb1l2ZmQwdjNO?=
 =?utf-8?B?Mk5HTEIyckxkY2VoTWRWM3lhcjZZY3BiRzViTTJUbGx0ZSt0UW5obUJYWFZx?=
 =?utf-8?B?bUtKZHI5TXN1QlpFdzJaSUVMK1BrejQ3QmtaOFRVMGt0ZUp3Z1Y5WGFsOXNy?=
 =?utf-8?B?bnd2QjRKNHVFNWNPVkJZa0pHQnEyaktPL2s5c0ZKUkZPSTJqbHdmWUxGK1ND?=
 =?utf-8?B?a2RhT1BYQlozK3RiR2pDZ0RFYmpEN0hpbjNHSWkrdVZicFZSaDdBaE5nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVRiRE9xYWFLU05mYmMwamN2bTgxUy9ZOHl4MVBTak5kL0VteVRTamZSN0JQ?=
 =?utf-8?B?YnB3WVlaZ0pqWE9PYVl1YlFHdHRJWG9HZEZnSHNFRkRjbmdmcUhwY2FwajRG?=
 =?utf-8?B?bEFDTldudXA2YnhjVUJoRkhBSk55SjdSYXVKR0lSUVNkR2lUeHIrdVYvcFVJ?=
 =?utf-8?B?VTA3My9OUi90Yll0M2VTMVFPY1didTZjRmM3eWZ4Q211TDdmeTFmMG4rT2U5?=
 =?utf-8?B?Vy9obk9WOXp1cHZZVlJPbXpRaWdZZHdxb3NHMlFRZkRaUmFUcERicWcyRlpK?=
 =?utf-8?B?THRkcElycHZFTmhUMDRad0lyOHRsSmc3Nkk3b1A1MmJDR2UzTXk2TVJnaGhT?=
 =?utf-8?B?SGxTRjZ5OThhOXRDNUxvWFIwQkg3eTJRUm1ZK3pBUEtJZmVENlduRnNIeldt?=
 =?utf-8?B?OGk2ZVhxY3d3aWpsS1NCZ25PQ3NoTDJXWjIrLzVaNGJYQnc2ODBhclZLMnBy?=
 =?utf-8?B?Q2R5RDRZNE8yVWhjMnpOdjV6LytNdU9VYnhpL1gvWnJ6NytnNUp1VFN3blk0?=
 =?utf-8?B?aFJRN2I2M2pWK21uSDNHR09qWC9lQWJacTBudmhCRzU0d2lKdTN1MDYvR2RK?=
 =?utf-8?B?T1RUQVY1N0YyVFpOSWRnVVo0UHpsbCsyVE82VnpQZVpYVXl0d2pjYkJTUXJT?=
 =?utf-8?B?Wm8xTisrQXNYV2xjdGdRSTRaTFJLQjNXb3p0dUllT2Y4WFI2ODJleFBac2Q3?=
 =?utf-8?B?U3g3WFRuK2NpY29zUjErT3FCWWRtWkRQaTNucmswK3pqWE9hcUJKM0JJNlNz?=
 =?utf-8?B?RzkvWnR4VGRjM0R6VDV1cytrVXI1VHRSZVBaQmVGbkRMK3JERi9JNUc0ZWZo?=
 =?utf-8?B?clZkODRNcmhsWDU0QUo1T01BeUNXd2NzalNmdDNSUEF5VFErRnN6elVmY3ZX?=
 =?utf-8?B?M1hRYWVoN2hJdlhkTkFVRDZTZ213WVhkdm9lNVhzdlFVTWxEdk1IZHlPNzBM?=
 =?utf-8?B?bG9HYXB0S0c2UUV2cWpnaXlLSDdRVEJYcFU1T0krdmFzZUtHQVhJQTl1MUFp?=
 =?utf-8?B?VWtMdHNEUWJzOGs0bGpoZ01odzB1eWNVWDZYOHJpWmM0ay9LVzRDSEs3S2cx?=
 =?utf-8?B?TmZJaDJiYUZGWEQ5TVVad29pWk1wUXcyallkYzNFcElvTUR6dG5SSTVMejUw?=
 =?utf-8?B?cENFbit6SEpvcEw2dVVDdTZhUGpvSk1RelMycHROeEsxMFBhQUVodUVzd1gy?=
 =?utf-8?B?dFh6RHZZUnJNTXNmY2lQeGlKYlBod2gxa0tPdFN6OEZDVCt1dXZmeC9qdTFy?=
 =?utf-8?B?NjFDNlNrSUt2d2V3QjhPOWJ5TGtBQ01BS3ZSU29keXN2Rk5JWFdpZlJTZ3Vz?=
 =?utf-8?B?b2d5Uk5EeGRONDdaSmtLUlJWMHdrT0JlSTR0VzZJRWd3YnVCeFAveGxIWTVs?=
 =?utf-8?B?Zk5raFUwMHZjb1pZUmY3WGFHQ0M3UHUxVDRmTDFlbkFvY09EVHRBYTBBWnNT?=
 =?utf-8?B?ekl1dmpGc2lYa3NhVDg0SVY4Y25RbEpRMjl1NTVHMVhjYkI4VmxGYWRVUUFN?=
 =?utf-8?B?aExHWE10d2VKTVRmRkltUmV1NXhpeitUV1pra0JVQitoVFpSNlNwTUgzSDZD?=
 =?utf-8?B?UERxNCszZlpXL25IbjBjWmVuaC9ZeUZlRnh3S0h2TzVpUXhjM1I4enBQaXVv?=
 =?utf-8?B?WS91WWZkQ1NxUVVBR1QzUVNoOUlldllaUTN4bVlGeXVEKzhVYVhUMEpWK2Nj?=
 =?utf-8?B?ZnVkdm83bGZUTzZHQUhxaEFVVDNaQ1dDQkxJK3pjL0tVbll1dWVXdkljZzlI?=
 =?utf-8?B?aUtraXdmaFpYOTNuRTdiejZ6OTBmK1FyQ0taZGt5ZEhybzI2QUtONndFN1U0?=
 =?utf-8?B?bHN6aU9maEg5d2FMb1VKbGNwZEVhWFJKSHRza2tXWi9hMmd6cVRHUkEyYVNE?=
 =?utf-8?B?ZHJVd0lDd3BwWjZYeENUeFdCNEwxL2ZDSmlSR1M0UnVURmlvMzZhM1FTTFdI?=
 =?utf-8?B?eFNsaUxaajNURzcvdkdoYnkxa2dmYWs2eU1IMENBSlhQY3krR2VJc0I0MlNI?=
 =?utf-8?B?azZaRnEvakpGQ2lmZ2JHbE0wY3RxVHduRWJxUWp4UFlNMUNhbEppU1Fvaytj?=
 =?utf-8?B?R09GazMxeDNUOUpoRXVDN2MxWklHRnUxMk5uY3RxZ3JjeGZPUWpaRG9pV05J?=
 =?utf-8?B?Z3ZndEkwWVNoNUdYVVlCdmQ5V0VpenFwWXpITC94ZnhEa0lEQmNWVnR2ekJy?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bb9799-2f63-4c37-d17b-08dc6bc96240
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 23:33:06.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aT/kPETzi7IbVCAGWf0C25TrSNEESeaeG22HeOp4ZWiKB4cKMfXIJJc5ZmzX7loDym8S+7/yAuUzCOXfR7f6G/DMcXj0oWY4j0mmRN8ViAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Hi Babu,

On 3/28/2024 6:06 PM, Babu Moger wrote:
> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
> supported, the bandwidth events can be configured to track specific events.
> The event configuration is domain specific. ABMC (Assignable Bandwidth
> Monitoring Counters) feature needs event configuration information to
> assign RMID to the hardware counter. Currently, this information is not
> available.

hmmm ... "Currently, this information is not available." does not sound
accurate. Perhaps it can be made more specific with something like:
"Event configurations are not stored in resctrl but instead always
read from or written to hardware directly when prompted by user space."
(feel free to improve)

> 
> Save the event configuration information in the rdt_hw_domain, so it can
> be used while for RMID assignment.

"be used while for RMID assignment" -> "be used for RMID assignment"?

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> 
> ---
> v3: Minor changes related to rebase in mbm_config_write_domain.
> 
> v2: No changes.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>  arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 11 +++++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++++++++++++++-
>  4 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 50e9ec5e547b..ed4f6d49d737 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -555,6 +555,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  		return;
>  	}
>  
> +	arch_domain_mbm_evt_config(hw_dom);
> +
>  	list_add_tail_rcu(&d->list, add_pos);
>  
>  	err = resctrl_online_domain(r, d);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 41b06d46ea74..88453c86474b 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -385,6 +385,8 @@ struct rdt_hw_domain {
>  	u32				*ctrl_val;
>  	struct arch_mbm_state		*arch_mbm_total;
>  	struct arch_mbm_state		*arch_mbm_local;
> +	u32				mbm_total_cfg;
> +	u32                             mbm_local_cfg;

(please fix tabs/spaces)

>  };
>  
>  static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
> @@ -648,6 +650,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free);
>  void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>  void __init resctrl_file_fflags_init(const char *config,
>  				     unsigned long fflags);
> +void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
>  void rdt_staged_configs_clear(void);
>  bool closid_allocated(unsigned int closid);
>  int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 56dc49021540..8677dbf6de43 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1090,3 +1090,14 @@ void __init intel_rdt_mbm_apply_quirk(void)
>  	mbm_cf_rmidthreshold = mbm_cf_table[cf_index].rmidthreshold;
>  	mbm_cf = mbm_cf_table[cf_index].cf;
>  }
> +
> +void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom)
> +{
> +	if (mbm_total_event.configurable)
> +		hw_dom->mbm_total_cfg = MAX_EVT_CONFIG_BITS;
> +
> +	if (mbm_local_event.configurable)
> +		hw_dom->mbm_local_cfg = READS_TO_LOCAL_MEM |
> +					NON_TEMP_WRITE_TO_LOCAL_MEM |
> +					READS_TO_LOCAL_S_MEM;
> +}

Shouldn't the defaults be discovered from hardware?

Reinette


