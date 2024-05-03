Return-Path: <linux-kernel+bounces-168406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70AA8BB83A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC471C22BB6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D384DE8;
	Fri,  3 May 2024 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLApgQSj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB083CD8;
	Fri,  3 May 2024 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778797; cv=fail; b=M9QGjXxZTXhHarUh8mzgo3xX9HCwQplnXrysneYWWttdZoBU7WVpDrVMo+Xi6hwUjGIVaVMNFUcGTbIGNcCg8hWWfhl7KVM3h+IhxtlD+quWSTsJ1kNoW5vvh645EnI892r5OJ1fUbqDPUJgcz/4drYAiO9RXYhl5a3tluOSEhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778797; c=relaxed/simple;
	bh=0hGCJUcDDE7DBAchvv6TyTrcHBDSAGxRxgCzuCGVyYk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oYD1nDkLZPQTbar8+A+i/2ScE2ua3Y0CF3IJeW55GgyH48mA2A0C+JKJ3XJOan7XuJLEDgywLzFBYzTAvSNvmzohxT2u+VW1wER2PHrcR5z6prHBAnHudIShtCfyPDk1+O+UhotX/mUME5pn8Jbi48gjSdakb4Nk3VLSOvtZ0ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLApgQSj; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714778795; x=1746314795;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0hGCJUcDDE7DBAchvv6TyTrcHBDSAGxRxgCzuCGVyYk=;
  b=TLApgQSjTFn2a4aCnSM7aIOko12mZ0BNxkeiQNqgVFLURKEael+q0Tg2
   pcm2UXbdpBsYsO1bTbLrMm9Ql+H1xnuz8MwJ6iXNZaICkelkUdOSZWRxN
   X/7rbf7H2f0MFg5zaA1W9Akp37PUGWy6un4MhIsq5Yl641OeUT18JcbnQ
   FVRpHE7sHT5/3nQFiK0F21KB5PzlA9nULQKE3HGMBf+zWCYEVTGVRIfLE
   bTEhMd8Vr4/kJA8ZjcRLwJxv3d+U+BC2ubNWvgTZbM4AoB2Yg79Xu/fRO
   zfs/d3kOsJ7139dex70Gp8Am9FZtcDQei0u5yzu0umWpWI7i31PYsYu33
   w==;
X-CSE-ConnectionGUID: ws3C/0CQRKSDwaFReFXcNQ==
X-CSE-MsgGUID: /MvTdSgOTyewzzfI+abGsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10729648"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="10729648"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 16:26:35 -0700
X-CSE-ConnectionGUID: AsxYhgjnTJmMZ5bfKAfjkg==
X-CSE-MsgGUID: WHtde73iSIWCcLOvbnLfZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="58493382"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 16:26:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:26:34 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 16:26:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 16:26:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 16:26:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZIiBBjDGvlELZ3m6rm9Sw+KnSzAsHvY0kDQhjpOaUmYf9nzweVhHvo39BPAcKfAoSJr8/hHPMgKS8VVW3zphfLXnpQvFFJdMXyCUNxo9+29bZvh9Hj8x/xXbuEDekvogP7BPDQ+3pTa1jZGFHPjN8CyFI2VSuk31PafHPd5VLZJ5Dya9oiZ8dEc+MASZ49VKCb/JRLkE0iv2zmMSAFBQHCJsOMhn1ijjyST/0Y+LgjoNagr9WO4DH+nE25RAv4bGT+mT/WRqg8o4Wq75iRUiFD9G9cTXdPNmi9bfVhjbN/H0WnDI7NZBUbzOJnA7lFPf1yUKBodSVqO1NWrZy0Ghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pglX8pa7xzow2SscX+NQ0FwJ3fmpN2BqohFAvfM8BXQ=;
 b=dmIHcDS6rizby4PnuNT0ts+Gok0qTVYx0d9v70WrNoJ0srkxEICd22WlD5tYvrm/ShqpnzMaQVWlG/Cf6TUp79qaPxF3UODk2p7Gxjnwk8QuzM55w1y+FFe1o74DYmbtXd022FFX17EzVxyg8GzXD44KuHASw7coSrEXc0sH8zKDzXVyBnVeRR2EGyJ1Z+RpHqUPbjQzgY9jl+UqxRbjWeQeujOxKtW6LHlb0ErK9pCu2V51Rz3FepcCpE4gtkGoMDEIRpcSz7iXuxzRXfgUAVJNC1Vq9OApb0PVEE3v03oGzhO81OQvma0tI7SIk2PLayyuy595kwTmNdroDTZgMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8607.namprd11.prod.outlook.com (2603:10b6:408:1ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Fri, 3 May
 2024 23:26:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 23:26:31 +0000
Message-ID: <55fa3189-b5da-494f-8ec2-7f0ab4b8d33e@intel.com>
Date: Fri, 3 May 2024 16:26:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 04/17] x86/resctrl: Introduce
 resctrl_file_fflags_init
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
 <363c14eeeac99eb0453ac3429f9e7bd446b2acdb.1711674410.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <363c14eeeac99eb0453ac3429f9e7bd446b2acdb.1711674410.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0283.namprd04.prod.outlook.com
 (2603:10b6:303:89::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 718ce420-857f-48ea-7025-08dc6bc87718
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0ZBdDhRQ0xrcTdDT3YrWWQ1c1VDNlB4b1A5MXM1OXlOd0RNZjRSWHVBVFZY?=
 =?utf-8?B?M0RiUnhaQjFkNVcrU2lIcXowMWNTTkFzZlUzRTBpSUFXU2VZNkI5M3NOQ2xx?=
 =?utf-8?B?T0dDdkpsRE9Wd2RETjdJYWtSVjVCWXkyelZ1N25TaHllbHhiNTZ4ODJMSWVt?=
 =?utf-8?B?Q0FwekQzOEJTM2VkSHErRWgwZVY0NVhyT091TlpNR0FDOHR6MXNPVzNQWXhG?=
 =?utf-8?B?SmxjWEloWUpzSHRnN0xUVUlQNXJXc1QxWkZEYUs0T250MGVRQmtmalB3amJu?=
 =?utf-8?B?Um9TWFFaZEE4KzgySzYyTXR0S3dCa0JETVQ1V3hnU1JEQ0hjVmJJWmN3bmJK?=
 =?utf-8?B?a0VYbWc4V0ExUVlTdnNnVGdGZS9weWlORW1waHdnbitGR2d0aENGNlYxWUpH?=
 =?utf-8?B?VGZic09DbjRISlY5M1VSRnBDVXpEOFhFSmo0RXZPelczMHY1QVdOZTRHVkc2?=
 =?utf-8?B?ZUwwNk00Ykd3ZU15bnpUYjZCcWo3ZHBvNVgyNk9wT1Z6WWY2c0w1V2VRSzQw?=
 =?utf-8?B?QzloS1d6YktvQXBLMHNmYUVVSWRjdnlDbkptSnBPRDZNaWpwajBqL3lzMVdi?=
 =?utf-8?B?ZjRsNTVSbUcvcXk1b2d5NDRlTnlaS3pZYU5qTXlNdjFsV2NKY1R0a1ZKd25Y?=
 =?utf-8?B?bEltZCtyenRzQk9zREU2SFEwalJMQVV4OXYyRnliV2xzSk1VRDBkcFF4Y2tw?=
 =?utf-8?B?ZjVwbFBTbmZSRldhRWdWVzRIQmx3RUcySXVidmFKZUJIWGEwM3l1U3ZxMDVi?=
 =?utf-8?B?QVBmV1l6Mms4a0xDazgxblBVRHRhVW9jTXowRUU4S2NXSm9oODlJS1dSVTNI?=
 =?utf-8?B?L2VxVmhQb0h3bG5WVWVVNDQ3SUxZVUR2ZVRHWWZReW95TnQrbTNZK1Qrd0ww?=
 =?utf-8?B?WUgyN0JqYTIxVE5LRk03TUxmMTEwT21aWkxSSTVqUCtxaVUyc0FDNlM5V3Bm?=
 =?utf-8?B?enBuYnZOalYrMWZqNmIvMnRsV29mU2Y2MVJMbFY1SEo1MmZRTzRldmFwKzBu?=
 =?utf-8?B?bE1vOWp4dmd5UG5wYVlxcVZOSGpaODl2cExFL3p5bGVqOGY5eUNOeWlsZDk5?=
 =?utf-8?B?VjZiV2tyT1BoeFhMN3phVE41dys1SHNhU0FoZWg2ejNHLytReDZxOW0yWXlZ?=
 =?utf-8?B?QUhldXNiZ2QvL0pDRjJQR0luNjJWZXVjU1ZaWlhtNVJLSXVaL204TFZvcGlO?=
 =?utf-8?B?dFI3aDN5b2p4aFQ5ckN2dEMzQVp5R0VJbGxUQVV1eDJaMG9SMHVSOFJWc2pX?=
 =?utf-8?B?MVJCU1lqamY4YngvbUNUbk9JdDduUUxLb1RtM2dENmRYRTRQQXZXbE5zSFU2?=
 =?utf-8?B?bEtianNKdnYwOVJiZTFpak5JT014cS9BQUt5akZTMU4vMEk4WnpCekRudjdH?=
 =?utf-8?B?RnZ2U3lrKzh1YUxaMWZ1WWRvaytnR0RCcnh2dTdJenk2VWxxbmw5bkpoZGhF?=
 =?utf-8?B?bFZZWnB1Y0YwUnpEQ29MOE96cnFudzVoa3g3VlRhVTVQdkQwVEt3ZGlCeFg1?=
 =?utf-8?B?YzJZckJYMXNkNTM2LzR2dG1BcDZ5RFZUZ1NHQkVyNjlMSXBBV1BMcXdCWTUw?=
 =?utf-8?B?bnJKS1V1S2xBMDBFblJ0N2h0dDFvb2tqMGRmeTEwN1Q2Yy91bWRJYzlNSU0w?=
 =?utf-8?B?blZ1L1M3YVBzQzByZUlrWjJvdmFqOVBMQUZ2WVJaM3kyd3NraDAzRnBPZjc2?=
 =?utf-8?B?WGNzWjYydXNnVVM1VExJaUo3Q2dMWjkrOFdNQWUxVEhZK2Mwd0tvNXlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFVuV2xDUzFxNGVFSlFxMi8zSXF4ZEVRSXkvcTZtcmdWdW9Jc2hEWmk5c2ht?=
 =?utf-8?B?VDZLaVErOWVmeE9rMUVtOWdzVXBseXFhU0hpbGFNSTRtbS9pMFhFdUFtME51?=
 =?utf-8?B?YTFkbndLUmdOV20yWE9oOGIxUDljVTE1YXhvTVBGSFRZZU1WZ0ZWY3E2UFZ6?=
 =?utf-8?B?ZzQ0ejcrSU9BdmdxNis5UG5pT085Zi9CYW9URDJnRndxYk5OdG1uV2h0bHlI?=
 =?utf-8?B?dGR6bTEwK0YzR1lVZnR2YTJTS3VRcS9kTEVXSEtJaGNGQlVnS0Qzdm91M2Yw?=
 =?utf-8?B?dlpmcy9QdFQvTGxXME92QXo1NjB4NDZKTjdJYlFORGdQdTdMZDdPUnJSbFlL?=
 =?utf-8?B?U3c4K3dTYTlkT0liazJHMGlQUmJwckZJeGt1T2hhVGhhV3IxU0w0NmZva3lP?=
 =?utf-8?B?S3N4d09rTTBQaHh5czc3VUgrRGxNbTFhTTl4b3hCaG9LNHJILzhqQmtFbGpi?=
 =?utf-8?B?YlZRWlk5OXkzM0lhM20rTEFVV1o4OWJna0o4UHJuT0Y5SVFualZ4YlQ4RlQ1?=
 =?utf-8?B?alFvbHZNMG5SSnQzL2JkTHJjNm5RYlRqWmtIMWtxcGhCR2FjTnBhamxmWHRm?=
 =?utf-8?B?ZmN3NkhTcHBKTVY1QUpsaFZVeWtEbENmMEViNHA3c3BQWlVhQ29zcWoyS0NP?=
 =?utf-8?B?Skh3SDVTa00yeFNPNEJyTmdaMjZRdlpuRjFUQ3VtSmdTZ0Y2b3oxRmowKzlo?=
 =?utf-8?B?emtPQTM4VjJRMDdvMHNYT0tkaCtRRTY2SEZMMzNsWlFUeXVKWStHeEMzSElZ?=
 =?utf-8?B?SzRWdm5tbDlCMlQ5NnNvWDltVHNJV053UW9haWlZVTZFVWJtM0E1aUZvUjMy?=
 =?utf-8?B?V0xLLzZ2SnBxZFo4U3lSdFlnMHpQUDJHVzlCYzI3OXFnY21RMTBjcEU1Wkwv?=
 =?utf-8?B?UVVkSTd5NjZrckNNTVhKYzVBSG9qRmpuRWdGbS9SRnlrWnhJaTZ6TWJqZkdI?=
 =?utf-8?B?L2tteTlMeGVPTVV5b0hzS0JOMW4rVUxRT3lSdWRWTTlpbmZkWS92aTQ4T0lX?=
 =?utf-8?B?bDF4clJGQUNtMi9mVXNETkdXQmJtclk2ZXlYOEQ5RmtwVnU4VUFDalVWNUhS?=
 =?utf-8?B?UXVyWFFxVDdjU2FJVGV2dC9wVkxuUUlLdUkvZ2lIYzU2bjNRZ1ZZbHJMQ01t?=
 =?utf-8?B?VkVRMUdtQUZveEJGaDhJdmduM3NESTFnQ3JwWGRuamZNKzVRczhQTyt6L3hh?=
 =?utf-8?B?LzZZbXUyRVlycWEyV1g5Ym42am9NbGxkblFUK3c0aTczZmFWcWlpMDZiT1Nx?=
 =?utf-8?B?OVpFS1JFbGgrei9zVkdkTnphdDU0ZjNmcXYvSk1wY3BVT0w5Slg0U2l0czQr?=
 =?utf-8?B?OVZqM2p3OUx3ekpwMnNSL0xpUkdZMkNXMEdXSGRZc0dtdWhNdE8rbTZzcTZa?=
 =?utf-8?B?a3pqVlZTTHBxNHRJTUxTdVhPZFVHRzRJZ3F3MVJnZHp0RWZPcnpndXZKTE9W?=
 =?utf-8?B?dEorREZMNFh2d3RUOC9GcEhoQnBNbWQzTS9kYy96dTNjc3hNUjVDVk9iRVp0?=
 =?utf-8?B?UkdqeGxjVlpSdUdqREduWXkxT1VZNkZLeHpZMDRkUnRPNjQrTmg4SlRNVnll?=
 =?utf-8?B?Z3d4dGFmdnlhQlZKU05vTStGTVhWVGR2OTludEN4QUJEcW5sNXphOEdpUDA5?=
 =?utf-8?B?SVBkOWNSVnpnTXd0YkVBSHIvVTVNZ011YkVBeEtFT3Z5TnpqTGpZczQ1cXV5?=
 =?utf-8?B?NDB2d0VCSW9QaENPdHJUWWFqT2pNbnlieHB4cmc0LzRlc0hqdUVnaGFKRy9N?=
 =?utf-8?B?UjRoN3hXcVZWdFB2a3pjRG4wQmNSb2ZaWDI3SUVwTEUxZURvWTV0bDBlc2kx?=
 =?utf-8?B?bmRHWmw4M1RxdlB1UG1CZ0VvZTlmeU1KQS9Yd2t4S2pWc3ozK3RMUFArak1a?=
 =?utf-8?B?K0hKYmlrKzlwTXpGcFI0NmRGQU56dUhUMVZQcHFLRUYvZFVUL2J6TmFJeE5Y?=
 =?utf-8?B?ZHpGbnhIL1lOcDdCR0RqVG9hclJnUkRmZDRsWVhBK0lVSTdQQlNIbzMxc2Yv?=
 =?utf-8?B?Y0VLMWJHdnl2Y2NXV3RyOXliYWRUNktkN2FNbThrOXRUakw2RTVrMjBMdG9h?=
 =?utf-8?B?MG82ckROZzZhbnJnSHFzcy9TTkhDUHFLb29Rcms1L1RScnI5WGJOcDUvMTI1?=
 =?utf-8?B?YWtYdzdPYWRobENrRHNRTUpEaVpacG9yK3p5SjhKNlNyWmNtbkNRVm5tMmZp?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 718ce420-857f-48ea-7025-08dc6bc87718
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 23:26:31.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsESkfu/hAxOTIsrGE/Vf+VsNdw/gcXAXpt6ZpFCRsGugoHjEj0uL8kZxIQNIzOpcWG75+cO7pn+sgQi6St9f5rdwYzaiZENNQX2/sBuIk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8607
X-OriginatorOrg: intel.com

Hi Babu,

In shortlog, please use () to indicate function:
resctrl_file_fflags_init().

On 3/28/2024 6:06 PM, Babu Moger wrote:
> Consolidate multiple fflags initialization into one function.
> 
> Remove thread_throttle_mode_init, mbm_config_rftype_init and
> consolidate them into resctrl_file_fflags_init.

This changelog has no context and only describes what the code does,
which can be learned from reading the patch. Could you please
update changelog with context and motivation for this change?

Reinette

