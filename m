Return-Path: <linux-kernel+bounces-138126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F5389ECE4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4771F21E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57AC13D2A0;
	Wed, 10 Apr 2024 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LKEc+lYf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E595353E00;
	Wed, 10 Apr 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736025; cv=fail; b=WVBtq1QRrMcHJCGSaOuIG4nv7zYLRnXu/rZQZ1FLY934WKD+AIuQiE9Ii15m7dW9mwjsS2g/R/swDTITZHxdMZ84tM/y33i1PV+74uuKiCRjy2jhFEhbjn3acCCYlgl8AvpX1jk3jiiBqqEUU8Ux9ActOobckPeUnX1HDIYSCuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736025; c=relaxed/simple;
	bh=ACoq9uvLTC2hxsrkgFksSG0oL0iKmKMMQfr5AVhn1DM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=tqbZHcj5OWQYedsTjzCLysmMYbIppGSpZw2EYFGJNH0mxpxdgiPmMPb2ZT21f6vApQva4WtE4maFiAGgEX8NVclcPuoTCiPkneAKAkR4Yu6bKnX71Spr6EeKK5m7fGdaxMdcbSkzZa3oqi2gBobpMKIvlLdiC6ceZ3LB3HODB98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LKEc+lYf; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712736024; x=1744272024;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ACoq9uvLTC2hxsrkgFksSG0oL0iKmKMMQfr5AVhn1DM=;
  b=LKEc+lYfx5ZruUFx2tM0RVzhfj6IFtdojELoflEG1/JlTfrYin9EDJLr
   hlC0ikX2lO0FJJgQBozR/JnUr/aM/7ABxTHYZKZWQ7pl21D704pAxgBo9
   UpExyIcSGmpHteRq8SQdoS6lIKtItXZc4DeFB02HnlD9C7KKosVTW3UhT
   sk/bIORaelQfxV7K5o8h+K7Gki4t7HVDQsQf/rTv7kLxtBl+ehAmwKDUi
   Rxbq6Q7Pv+ckqGBSUKdormfHqiqAwchUe/96SnFxOJv/yubcC7r5Q8nKK
   eYvujRHHm+iTxL4f6b1DKVVWG/urdrn5t/Kfzgu3k0Ip9grMrnG0MCeKU
   g==;
X-CSE-ConnectionGUID: Rt1YuDNaQtu6U/wGaoznfw==
X-CSE-MsgGUID: NOtEbSPjQG6M/JPN0PqvJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19470835"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19470835"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 01:00:22 -0700
X-CSE-ConnectionGUID: SMdU2xr/RXWQW/GB0kwaPw==
X-CSE-MsgGUID: wqxoQafHQvu2HiaviIbPTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24962929"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 01:00:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 01:00:21 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 01:00:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 01:00:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 01:00:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er5IYXkKMy8VB+TG2T1QrNibcy7M34D72Z48zyO9JS5ipjXyS/+bf9rRhs7x3f9gxbt2wGgJYjoLX92+q+xFzG4Rmvu1K1zzD6uIkRqMfnyKeWJxJVSFzdGnRuc+yU7Y+O4pkB7PWPDTkvU0o4iu9lG5hDwu1ySKAmDyXJ3vLX5Nqc9DLEfYWHDBJVphK/uMWJHLeS0TG40JZk6dnOQfum84djC0tsHtWwgmWynuMs/RYf4HcrvFJmq1Cia5Ecx6NaJNHu93Hz8RJYrfBvG46DOw2mZm5fox6c3nr/sbNlSYvswHsbOk1eSr/C3NGCWo3Bxv6qTsUOBVOtvydHIJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFb5pfp/hhGu1+jB2kz5tHt4Vo8D3AfnlNdHxjqdjgw=;
 b=SQeWSw7gXks7W7dFRZmDGjTbC1UkPy33ppjDUoVaOJnpHXNvsuCYGn3xpGOEj++LIIy5uEeT5UWsEqHqoTpa99oCTLBhn5crLxYu3FEtSeESqKFq3qL/azTPawlc6LUaML77xcfr9qGOJsYxY/fHS26yuWrX2Peuiuc7K7wpoYTJe+MayO7afKpwjsMaqYfxC0n7C/pox7xSxs+tsszof5gYyY69WPEIW4+dTS9uZM7dLG5ATq8SdLPjfw7jAesWvSZLxStO56DyAe2k6xZlcKwQxPfz4E7731pqIdtbnpZrFPUQOW4rRzRPAWLE6fD6+BU97g9PxAi29OwOLM0YpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 08:00:12 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 08:00:12 +0000
Date: Wed, 10 Apr 2024 16:00:03 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [trace_seq]  40fc60e36c:
 BUG:KASAN:global-out-of-bounds_in_hex_string
Message-ID: <202404101431.bb9742bf-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8570:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XFwTkZW7eZiNZb2bk6LIrvd3a3q50Dny5YnoeaRz8VxbiYn4iTPyk9sjNskkab+WXqjSNoG5GiMh+PS/s0FDDlPe411IRj4FmUZctYfjUlVdVnHJ+SLuSTJWBpzzxDUXZQLu9AEKDd7zwx15/T8cVHaA8buIAS7qXBZWTA0X47V7Dkxee6qVczVEi09IwuqVS140YUApp/4RiLAxkNVEuPgni1/N8+Bgw8p5koM3VXleWdA8jIBzuXYncvX6u8r9DAji5XVg/PXIsGz858tnDoFabPaCqeyBthG+NqAwseiclezZETNi9gysVaVFQoqy1WTPTSv06dir3VAFqc9SDb1iWGLCMDRjbVSwDp9oca4tUyt/gySnjzY9LQRF/M7jxJbKOV7XNdOvgbFZB+TBLB+VJGXIUq8yZIEElrsruvsuigkJ678TT0Vn8L7CbvJlwM+HW6KpFh9SiHGvG/GjmCPKCMgsJV2pidvR0oB9Uze6ZbC9+xTp+emcdkj1bwrGhill30LUchpxUTHOsVyi7DM+VxNhx+i2V7j3wuvsb9bPLVB05aDQ6sY2IilhPENREs3PGuUEL1081Du9fre9/rGVf/+Nn2U27YPQ4gaFDMGOgtiLcPNB/OjzzV+DLRc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?37KTWMescNzY7IbmIc2i/f7zR5rWV7vSJj3Sec3VKXIx5mgwfFCMd4T38iOV?=
 =?us-ascii?Q?b9OSw2wZKMShTdNlAba3T0KUh4Iwo88Qg1HHP3A47u5ZHrVUn6bJmPHttsiG?=
 =?us-ascii?Q?K5YeXWqfDA3ZLtmPEx25ctBr/sLNc7QA4/0oaVzRjMokE4vctFPHkiyfG5lX?=
 =?us-ascii?Q?OBJSye8QaD1DRNro8qXeyJuis0CFOrEFH5w2ESDztsNLpDA9dhJBLMh0Xink?=
 =?us-ascii?Q?lKqOmY1yVzcjszTM6czpwg++AAQ4hjyBZ16k7RGWhsma4VS2uGsOhRqxKO3Q?=
 =?us-ascii?Q?U1FUzPf9tTu453lEGdihDXnynzpgYp7HiL/5Pla+Jsnl0ml2iqAfy8Slkz1x?=
 =?us-ascii?Q?L4a0WEzweEPmt74cAaTLBLStPisI98qsITEfZ+x0IjJVjyjBgbQH5syopdxi?=
 =?us-ascii?Q?e60sSEl5xRbDSfkAyD2frl+RAjL0dqAGcghQ9gqsg8o3+23pRNkArhAv0lsI?=
 =?us-ascii?Q?ZUxgDQV9izX9ujAlvPE7GHG/EOdpY3gylldJZd92RLKYgV38i0udEZFf0I1l?=
 =?us-ascii?Q?rvOj8AGbvUCAIml5UfzQI0PqrpmXNVr1haNaBVnQqcWytIHztTmTvrpWi8m3?=
 =?us-ascii?Q?ga5MGdCNhU+HQWnwj7Gj3yXD2jX8g86iH5pLYzWJwZywOJcXFthUWxFNq3l/?=
 =?us-ascii?Q?Ery2cwfyf52jR9jw3FUH3CnefgD6AypHrO11S4VrpqWn3ka0CMvX+Z6+oFPB?=
 =?us-ascii?Q?tic3c4TOR/FoUnuinwGUK5pbsy4I5IkHiqyL+f7JGMpbjTQc/eJkOXEZpnAc?=
 =?us-ascii?Q?PDO4Hqq4RnE0vo5zweiU49r74zdPRiMblM0xuoSiE8nLEulCgh6oFRE8BJuI?=
 =?us-ascii?Q?bSfugK3e7joVh2UZFWC3gMHlv0yo2i+DoXkNBVbQTcItfWrs9m7zuj64LFD5?=
 =?us-ascii?Q?cUfODisGRRzlgkaHLYoZ1drA3tdE6ey5MOhVCkC3FVDkY9zAaSRkKlDfhVm1?=
 =?us-ascii?Q?enR0KNmza3N3g4kWHGFmbyktqMWVEJ7Z9sVwqmY4psF3N668zhEAgJ50mJuw?=
 =?us-ascii?Q?DF+wETFu0Ai/F1bIvc2v/2sDHE+StbosStW+JGH0YXenaOER8vTGg1Kl2bPS?=
 =?us-ascii?Q?wueSDon8qVqUKAyNjmzmChB88h0y97b3FOLuG2mJYAMu7ZWYysrzK+O2QooQ?=
 =?us-ascii?Q?zV4Z44U31H3aIBE5LIDuTVQFWIPm2ETOx+bKarBAlvJv3nrlzbfco64icl0X?=
 =?us-ascii?Q?Tw2tjcCBIVO3Z4DL0c9gu/ykstlu8POjcdyjgmlFL/2YeXAPmidde1yK4ZCK?=
 =?us-ascii?Q?Hh6DdAyWFn9phJKXdL0QbTwza77DtDhQdlkorXmhCg8FKP1s4cp4FKp1/Ruk?=
 =?us-ascii?Q?lAWBSBUYxyHgBvvsRGXLGiyw2T9Vxgw9zraH05Yg9QaRCeGL9aghJVy/yZdJ?=
 =?us-ascii?Q?YDfuFRu0ibPb3b6nsetZj2WnGi6+Pr8/fmdGyCeRAA5JKR9Wlc9iTAZU/2NQ?=
 =?us-ascii?Q?SNTUuLRKzlMWzIESTOjX7FSqdEg8gzw63BIwHAvwH1a1ydyeISEwkMoFtgXX?=
 =?us-ascii?Q?ovV4vLIe+ZjHSq75QKNIPonr29U3ExDSOu+K14XbShmayCLB9bRCdVbREtPu?=
 =?us-ascii?Q?KTlBf1dyHNYKNlv9NEnA5MwNDjJf2IiZNdCUKJSt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55030f6d-51a9-42f5-6b80-08dc59343f5e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 08:00:11.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNu22YgboBgaBEGAbU2b8JzvUpws6oOxD+yB+nXWQ6KN0OPKKQO0EbJUUs/jyKz/hICIgYbkppWjcIqU0DNHMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:global-out-of-bounds_in_hex_string" on:

commit: 40fc60e36c60ba85b2974e507b67df40c94e9578 ("trace_seq: Increase the buffer size to almost two pages")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 6c6e47d69d821047097909288b6d7f1aafb3b9b1]
[test failed on linux-next/master 8568bb2ccc278f344e6ac44af6ed010a90aa88dc]

in testcase: rcuscale
version: 
with following parameters:

	runtime: 300s
	scale_type: tasks



compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we also noticed this issue does not always happen. we observed it 17 times
out of 30 runs as below, but did not observe it on parent.


8ec90be7f15fac42 40fc60e36c60ba85b2974e507b6
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :30          57%          17:30    dmesg.BUG:KASAN:global-out-of-bounds_in_hex_string


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404101431.bb9742bf-lkp@intel.com


[ 413.751080][ T494] BUG: KASAN: global-out-of-bounds in hex_string (lib/vsprintf.c:?) 
[  413.752115][  T494] Read of size 1 at addr ffffffff960c19c4 by task rcu_scale_write/494
[  413.753237][  T494]
[  413.753659][  T494] CPU: 0 PID: 494 Comm: rcu_scale_write Tainted: G                T  6.7.0-rc2-00035-g40fc60e36c60 #1 a4d5f5b4375fec29a5dddc8a474a6031f87af2c2
[  413.755544][  T494] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  413.756859][  T494] Call Trace:
[  413.757375][  T494]  <TASK>
[ 413.757850][ T494] dump_stack_lvl (lib/dump_stack.c:?) 
[ 413.758486][ T494] print_report (mm/kasan/report.c:365) 
[ 413.759147][ T494] ? hex_string (lib/vsprintf.c:?) 
[ 413.759803][ T494] kasan_report (mm/kasan/report.c:590) 
[ 413.760455][ T494] ? hex_string (lib/vsprintf.c:?) 
[ 413.761099][ T494] hex_string (lib/vsprintf.c:?) 
[ 413.761719][ T494] pointer (lib/vsprintf.c:?) 
[ 413.762328][ T494] vsnprintf (lib/vsprintf.c:2823) 
[ 413.762978][ T494] seq_buf_vprintf (lib/seq_buf.c:64) 
[ 413.763647][ T494] trace_seq_vprintf (include/linux/seq_buf.h:53 kernel/trace/trace_seq.c:151) 
[ 413.764351][ T494] trace_event_printf (kernel/trace/trace_output.c:325) 
[ 413.765043][ T494] trace_raw_output_i2c_write (include/trace/events/i2c.h:25) i2c_core
[ 413.766410][ T494] ? i2c_put_dma_safe_msg_buf (include/trace/events/i2c.h:25) i2c_core
[ 413.767794][ T494] ftrace_dump (kernel/trace/trace.c:10262) 
[ 413.768472][ T494] rcu_scale_writer (kernel/rcu/rcuscale.c:535) rcuscale
[ 413.769741][ T494] ? rcu_scale_writer (kernel/rcu/rcuscale.c:526) rcuscale
[ 413.771241][ T494] kthread (kernel/kthread.c:390) 
[ 413.771847][ T494] ? rcu_scale_reader (kernel/rcu/rcuscale.c:453) rcuscale
[ 413.773073][ T494] ? kthread_unuse_mm (kernel/kthread.c:341) 
[ 413.773791][ T494] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 413.774441][ T494] ? kthread_unuse_mm (kernel/kthread.c:341) 
[ 413.775186][ T494] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[  413.775893][  T494]  </TASK>
[  413.776406][  T494]
[  413.776859][  T494] The buggy address belongs to the variable:
[ 413.777635][ T494] btf_allowlist_d_path+0x4/0x20 
[  413.778325][  T494]
[  413.778740][  T494] The buggy address belongs to the physical page:
[  413.779592][  T494] page:ffffea00074c3040 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d30c1
[  413.780914][  T494] flags: 0x8000000000004000(reserved|zone=2)
[  413.781710][  T494] page_type: 0xffffffff()
[  413.782341][  T494] raw: 8000000000004000 ffffea00074c3048 ffffea00074c3048 0000000000000000
[  413.783501][  T494] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[  413.784669][  T494] page dumped because: kasan: bad access detected
[  413.785556][  T494] page_owner info is not present (never set?)
[  413.786370][  T494]
[  413.786789][  T494] Memory state around the buggy address:
[  413.787550][  T494]  ffffffff960c1880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  413.788643][  T494]  ffffffff960c1900: 00 00 00 00 f9 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9
[  413.789739][  T494] >ffffffff960c1980: 04 f9 f9 f9 04 f9 f9 f9 04 f9 f9 f9 00 00 00 f9
[  413.790848][  T494]                                            ^
[  413.791705][  T494]  ffffffff960c1a00: f9 f9 f9 f9 00 f9 f9 f9 00 f9 f9 f9 04 f9 f9 f9
[  413.792789][  T494]  ffffffff960c1a80: 01 f9 f9 f9 01 f9 f9 f9 00 00 f9 f9 00 00 f9 f9
[  413.797442][  T494] ==================================================================
[  413.798544][  T494] Disabling lock debugging due to kernel taint
[  413.799401][  T494]  swapper-1         0dNZ.. 118977266us : i2c_write: i2c--1868734768 #65535 a=ffff f=7b28 l=4231 [00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00]
[  413.802715][  T494]  swapper-1         0.N.1. 118977275us : i2c_read: i2c--1868734768 #65535 a=ffff f=36fb l=38182
[  413.804088][  T494] ---------------------------------
[  413.804885][  T494] tasks-scale: Test complete



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240410/202404101431.bb9742bf-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


