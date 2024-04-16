Return-Path: <linux-kernel+bounces-146447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F50D8A656A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7C3281949
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D584DFC;
	Tue, 16 Apr 2024 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0muTWgS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B280611
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253732; cv=fail; b=RX/5Lx68lt6SRYJbBkiy039ZSaUWKvpp3LELrbdPU8LswBfXfA+mlZapI2+Nlsv+LA48+wI7yTCdYqFRqWMfWG6f9bDqilmsRVl9uboDFjMXeIhhheqWIS39hfhw+6L6M1HSopwxHezaTrdfZlJpr2ecMNXMDPO7vm+cyFMgblQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253732; c=relaxed/simple;
	bh=nmolJeDnEeLcmYUaqQ/hFoVTwQ5HQjN8OmLjiw//zmU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PifxMSoPxJWXIpgMPofFCfsWJ47vMJbOdu1VBYBSIZJfku4Z4PhOF2oriK282V59aiFpSrSoIkcwmDJknZfsrZ9evy639aXqZxDljqcB7nToTedBxyjonKVsI1fACbjR53vWeixdWFfwR6aAL+YBXKQyMihw+Cbc/6ZfoJV4ju4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0muTWgS; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713253729; x=1744789729;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nmolJeDnEeLcmYUaqQ/hFoVTwQ5HQjN8OmLjiw//zmU=;
  b=g0muTWgSmMSgyeMATDHnOll821b8piaeGy2yMgYoZ+CHE4f872P43x7B
   iFAVd6ps06uK32mcSvqFHvNBCC44gL/47JkaSuLRMtX87mKhmrriXafLT
   bhCfxnoj27J43dj9wW1n0Zug494X+P9Tn4mWLPsBwln1g0POT/yYyYwgM
   GRRHRu8MesRO4buuXMxf8pgAutKD8VbCCHb+DM5oMjBy7Th4Wmr/IxTRz
   B8pgaDG6QpGYuwEP3ABDV7nWtWkRyMJvIjvsMOF+GsmQwn8YTHBaK3ro1
   AsxiqRpxsL//FISBv5daEkWk57JztdHi3aurMsCzpu4Hea29M48SFwSA0
   w==;
X-CSE-ConnectionGUID: ygdXRJXGTaGB1zFgWdGUoQ==
X-CSE-MsgGUID: BNSSe99bRHeNi3YqEdz6/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="19384640"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="19384640"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 00:48:49 -0700
X-CSE-ConnectionGUID: IFD46eIMSQSImV3hMvwmig==
X-CSE-MsgGUID: +x7FOdL8QqyQfhYY3wi5Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22586276"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 00:48:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 00:48:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 00:48:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 00:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itQAmQIv4XACtU3JvvCZujh4+a9gfEjk9GD7YU09zfwJVu4zsDyPLJjnH4afqXRqNPJq+bOLI3JiM+Ce2I4tKjgNDnyS+MIBQvn+ZldjOdikz8It53APqWyPY4tls0I/hXDC05BrN6nPgx/MI3dzWweaGg1KN91BUxJdXfXHwBewwoaBgeNuUTHMCgP8cDglcAS2tC/hzJ+AxqjEUcFPSmuzDdLVKX6SZ/G0kT80hjw9SgNmU9QaqWXVBo/k3tpVvN/g87pv3naLsWqTa5Rrv9IEo+nhWKTZhgJtzCwUHC+rPmlyfnHXH4uj0PIxrDw3R3K481EjrfnUUFLJzcHUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGspuqwO94GHO60MQ5A8ro56T+iTlwJ/EqzipyiI0To=;
 b=c/1lCbCgmJN46x0kTr+HgUvfMEbN1NWgxMQQCKth/23I08TQ04mQy6Jn/oLBs20lGr3+A8I+UsZqI0B5ySrMm2d528a63ZJPZgSI09NccvN4ujGtGU9t5ecGSDmINEWEWCF5X2u4UkvJ+iImmCmaDJMxekhPqZl0Yj4CXImTNUquU49Z+mnHKRo1o9a57IiZh0tAHhN3SSWgxbIZ1L+SzehHtMmhIcNWp27KK+E76MoHpFi4Ljd9n6sqQqaMQpG3uP1g1huO0ogTB5gHa/Vb2aS/NlkZT0WK9PnO1bYLRmjJ811pBcuMSP0j92iDVAWyScUpdSKyHIRkvjdEezvMeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by BL3PR11MB6315.namprd11.prod.outlook.com (2603:10b6:208:3b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Tue, 16 Apr
 2024 07:48:41 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd%6]) with mapi id 15.20.7452.041; Tue, 16 Apr 2024
 07:48:41 +0000
Date: Tue, 16 Apr 2024 15:42:04 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, <llvm@lists.linux.dev>, "Linux Memory
 Management List" <linux-mm@kvack.org>
Subject: clang: error: unknown argument '-static-libasan'; did you mean
 '-static-libsan'?
Message-ID: <202404141807.LgsqXPY5-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0182.apcprd04.prod.outlook.com
 (2603:1096:4:14::20) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|BL3PR11MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f99a985-9204-40a1-3e2e-08dc5de9a230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4zZd7tljTYXSvSiRbEED8aW40FY8zBWn6uW/gjamN7cXvB3I5FdnX1kOcFWl9bNgFgZoCu2WXk7N+tv2EBdxN5Fz7EU+JU90xV1qH7ymOXMl8BnLEemk0TfO9j+hv0qDr3QQDnfutQje8zdnXeiIL4fjqdYK1s2jWR0/c2YTZRgrFISc8nauzyzCnakG3xBDm3M6mHsbWeIX+4FhGJMkoCGdwRlHuHfCQ4bc2z8rwOgo3CtwPVbP/PAopPBVpC3I6tkjkLLsk7hHOUYhg+/SUM/pADojfnOkIyAaKqbCV1aaZtt/EcPX20tIwTvctUrqO0+XGdb4viyY9Zl8R0GBOmtTiba+cTMDqQb69fOeEwTzuo1ucMQVef2CUTIz9gs6/BMZyqNMPST+V47u6e6w3ij2vKHM/8K/v3L/CAFBbGjABpWOSMeRU6HyvZ+1cCuytqlwdmUVguvGhWF0wWboC6uLLtwfERTzsql41MIN8jP2iOYGTcgHbpme7saAF6ofITpi8ygFOdT67knMHpd4yPa3Fo9Wic7Wqjf/UkOHSHIkJicV6U9q8j/CsBvlGDMOm7JWHkSIlmYqAPBBEySp+oVAqkCYgp5KhD0sxUg5YwjPRjr49pIzYx/wwJB2C0ypQ5mcoJHgs+UfR8/58EVU897PMwGQwCEF+rshXRJaL8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PZbtFKWNORXS1obsli67BbTDuKiXNXGewXtHOMBL/6C47wFHEfPqXyuGeXZF?=
 =?us-ascii?Q?QijyfzD2qv8IW2m4PF2JnJ4VXxWg5QclRKA5D2856KCGaxcPVffEmwMfzs+s?=
 =?us-ascii?Q?1vLihDVj/uXPOox1x/nWREdHv9h2EUg+ogTwMwxMMsr/ehkrKmbWsk3CR2iD?=
 =?us-ascii?Q?b8w5fankdbAhv/IZFwLx0CpK/X+bp+cakD+MQuQ753YJ9wFc2h6l+k37cLzB?=
 =?us-ascii?Q?JsEwZzfrSagA+pIFGrRbSuzJujMJTFKihE8h1bA1m5kAefjUz9OfIsPJLSai?=
 =?us-ascii?Q?OYjM+JjvWS96tLlqM+w5c9c+iWhqFv5UzKuI3s/itDqRg3q1Ts8cdIl6lN9h?=
 =?us-ascii?Q?uzJ2wRRsviAvZsNGZzgPUP1ZzdlcSuD740W36EtWMf6+acgMhKTXZp6SahYd?=
 =?us-ascii?Q?fmbJXT9wnaCtFISo1Da2b84L74y25+Hu0VchMZzPhRTeWdFEKelZzXLxjPbi?=
 =?us-ascii?Q?0Zl54Rl/OIrA+Mf4IbgO0QypKFHuIQ/o6OuPGzZ8q8fP/pEgaYiWVZch7vqq?=
 =?us-ascii?Q?rC0TnejuUSG1BwqK6kRd6KManzXghdGW4nAC9tVw/ASs5ThjhY7BMQuBvZBz?=
 =?us-ascii?Q?HQ58iwZxJu4DQVmUFHPAD6vwjBDVvEw7576f7Ocg6SsjO13i12RxL7vHUHAB?=
 =?us-ascii?Q?VCPjLNBJK1ioZV7WT0GcHvJ7GTQsT86sbTC+jTJP14cGy9lvwCiIMpNzfMyv?=
 =?us-ascii?Q?/n9C6lZ93nByqVJdOH+MbeAcqlKjpdni+UVbbqJB/oBoynkGXIytQA78bnev?=
 =?us-ascii?Q?8tFCbsufHNN4FfHV9Pzr5Z67cQSHJrYLwuxJql5RgqWQhV5eHzcUw1HZw2Xv?=
 =?us-ascii?Q?1g08+tNr44clNWrrg0O8Uys59WORMEFI13P357TPmt7PAHvgV8ec2UvWYnEV?=
 =?us-ascii?Q?2mD2/c7zIb07j/v1Blw8gLMKuhUgSdwOG4PXC/Unw/WwEWSgDF7yCBSNHUtz?=
 =?us-ascii?Q?eQc43Tmon3my0lnnDREC1EpuIy2y4Q7jLUOmysDJ8jhimMqpQ8U6u1+rXfJm?=
 =?us-ascii?Q?ugahlLd37cMvM8hAX9IJTs++686vRAq7ByK01Sma9UqFoXwPizRIpBjFXzAY?=
 =?us-ascii?Q?SyzpZpMas+fVBEThM+zgQ/RLqTNS7+icQ7pBSkUS3FvAeRduwNRoPopbTRca?=
 =?us-ascii?Q?36SjSc3SZkVe2HTbYdkblMcrPPUOlzEBWEKTj64Q+ywKL8lFN1z3LIZeIxXl?=
 =?us-ascii?Q?kw4qHxxUkgjjiuDn9BGwcyxgN0rXTjbgoxoClkRSJxRXUVOV3p/nLRtgB9El?=
 =?us-ascii?Q?COXSbEMRKVc0Lr/UneEf8Sw6L2qk3uKx2IIEoWyebNgp5qkS3MsMXOkjYJ8m?=
 =?us-ascii?Q?UWdlVDWMSMZtY0RdOxsi/ayKPSbqVcxd2mTtPBZ0Wfa9CfWzjJK7oUU9Dl8k?=
 =?us-ascii?Q?TwCUa0c8j2XcSq9KKNgJ00HkkMY5iLYX9aM0tx8h5frO9FXBHPzDzwjIV2qX?=
 =?us-ascii?Q?skmwRyuJd8opJdHe57CdYtqBlVtbXziL7mkdZQFppJytaqMnwn5o5l5AvIW2?=
 =?us-ascii?Q?XzX+aBbutLG4O2/z0TDe12NAgJNMIdgx1xvNQYg95l4zKAHLm0Jh7DK8dEFs?=
 =?us-ascii?Q?u1crzd1iQCaHed5IKzZwoa/ye/TV9kEoJE+9MLI6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f99a985-9204-40a1-3e2e-08dc5de9a230
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 07:48:41.0442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDboYLN3N+LYqhnDfGduB/a3SsdkzyqI7yC2OqdXi8ZQ5XwMCFML8nAW/KraRZXplVsxu8ReQbhdlZ0t8M57dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6315
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7efd0a74039fb6b584be2cb91c1d0ef0bd796ee1
commit: c652df8a4a9d7853fa1100b244024fd6f1a9c18a selftests: link libasan statically for tests with -fsanitize=address
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202404141807.LgsqXPY5-lkp@intel.com/

All errors (new ones prefixed by >>):

# tools/testing/selftests/fchmodat2$ make CC=clang
clang -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan -isystem usr/include     fchmodat2_test.c  -o tools/testing/selftests/fchmodat2/fchmodat2_test
clang: error: unknown argument '-static-libasan'; did you mean '-static-libsan'?
make: *** [../lib.mk:181: tools/testing/selftests/fchmodat2/fchmodat2_test] Error 1

# tools/testing/selftests/openat2$ make CC=clang
clang -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan     openat2_test.c helpers.c helpers.h  -o tools/testing/selftests/openat2/openat2_test
clang: error: unknown argument '-static-libasan'; did you mean '-static-libsan'?
clang: error: cannot specify -o when generating multiple output files
make: *** [../lib.mk:181: tools/testing/selftests/openat2/openat2_test] Error 1

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


