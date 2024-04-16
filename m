Return-Path: <linux-kernel+bounces-146091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3660B8A6085
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F091C20C18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC80D7464;
	Tue, 16 Apr 2024 01:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXAtzzM7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B506AB9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713231710; cv=fail; b=HfnQw22+ihDj2WVlGD10zOGUGOMFDg9JVKfdfJpnWa3omKtEoiPzsVFfIpGbGM2MJtly7KuU6QV/CKaKnsuuIZ4cDPmMaCCKiYvEQV2c1NsfANPfWAriEUvs70+uLUGHJ4CKrveE2VgpxccKMBzKU/ejLmbv0RPt+hdfK2xUHPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713231710; c=relaxed/simple;
	bh=qJuAGQWDYMbsgRGz8Hrb/nBNVkJ80mnnCzaEx7DjtWM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=DMKZJ6KMOeEBfUC2gKE/7Es8omB4t10waVUWFOzpZbt4rRJprrGhCrMOPjzG6PqobO0hULWu3qhjMr5Q8rYMg2gSjT/Y1BnwNzH+o1yRBLevCvcMdsjHnfjjUq26Eif2EicOC5AgTYq3QajSqihF2ND//i1i3AYA+8N5OBexMJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXAtzzM7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713231708; x=1744767708;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qJuAGQWDYMbsgRGz8Hrb/nBNVkJ80mnnCzaEx7DjtWM=;
  b=AXAtzzM7B49A8hJspN1D1NkCJWF629zc3zrcdmJcPejZfnVIreI2UJkd
   VvFUIBfae3xdEFTmEkJfmkWKJr9ADPbcmo2N7m+WWDHyttzLYj6ldolcl
   YkfkHDK1oNlbbzCybi5hB27rcGx+Dc84FcsjFrrzzAJgEQweWIEhSAvg+
   rtJjJp5wU2CQ17mvj/yOCTyE8wsPs0Jxncvv5Cmq+YIKdh4+eKlYx2Ve/
   TD0yddvv+T5Dcz8XuaYSMSKXOg9Izvl93wQoEoKrKaNEUrRMtodd3INcN
   mz3tHd1b7lfl3xRvaoH+Npcv+Lrb/tOKrbmScVszL5Sbl72TRsuJ1CUCo
   Q==;
X-CSE-ConnectionGUID: J1TiLBawSr2KzYCsCM9B8w==
X-CSE-MsgGUID: PvK9cFmhSSuGKiW2MS4zkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="20070432"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="20070432"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 18:41:48 -0700
X-CSE-ConnectionGUID: pZe5Jk+CRx2fW6QznX3OBg==
X-CSE-MsgGUID: 2DA0hRI1T9ao5GyUV/3q3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="26522102"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 18:41:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 18:41:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 18:41:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 18:41:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aymL2a3Hr00VUBOKP6UIMpLAJHG6YVnmSKirF357cV99cIWlecrkhrCuufsQyq5iyF+JorlJTktN6x9LBEIxSlRNmD/BqhqA/dBViuW2DJY4G9lr2Sjn4B/fTlc0y7FLFKxhCtomihK0EdqyfyJ888PUsyNSfCpx9uyKt+i4140d4WfNjZRPJxgAooTqyTohSZj2xnW/RHUt6pPjzXBZK3knFEWKXU/VEOrPi0yui8hZYRKyLG86S57EQ6JwH6gJDyk2ei2FKmrN1NoLHZFj8T6AiY36kwOrE15Z0eiUu9jLVEhy2m6W18wdUoPlgTeDHbB2IBgnDEXtRzkQAQKmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztEYG9mkdQq9p3t5D67vv8lkVZ5COac6OngBZNn1ANo=;
 b=B7AstNeNs7nSANRBPmnXmfEN8Nu0tEnNEvAeiZ4YteQrDaLN39youY+7cDeVG0AcK6p5KBYtf9Hht58y0K8abo3IWuMyBSqH0fdZytOKJvjy8CbxRuWQWq7bUCELkAg5AscoD2jabsXHjt3hZtsltWm3qFXFy6t9wLRkBvjnZZuCQOos915WK0zMj/GYePds3dognwWlIgFibpfKa6e5bhtb0aCw2ub2oSxp5cqNGt5AqnAb3kqFrUhguGcXwrBc23T7us+vNUbNKTOe3ioMfEAz6yoMsmNKSRWNLmhpDdhvw0KgbzIokEBMxrOvTUqObJFniEX3kov6bbMxRICJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6886.namprd11.prod.outlook.com (2603:10b6:303:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Tue, 16 Apr
 2024 01:41:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7472.025; Tue, 16 Apr 2024
 01:41:44 +0000
Date: Tue, 16 Apr 2024 09:41:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [bristot:dl_server_v6_try11] [sched/fair] 1abba9e7f4:
 RIP:__dl_server_attach_root
Message-ID: <202404160945.7f0031c5-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4199bf-603f-4d7a-6db6-08dc5db65f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sd00qNiGB20H7fHK02bwcfNuQPDIdiR/2y9lunF6BMzhvxNxe9HZtzf9z3vJ5zdNdYtU0uuYNvzR8dl/wV4Le9Ds0irwGjMCnJwKO0rbFubhuQCyQ0ZLNH2V26PBe9MSgNkXSsVp09643RMo0+upXr2S6YItUHDtKyTg3QxAxGc3lzhmw8LtICrC+oU5LF3Q6MegkwXsNWwEkFHmcjzZQoHiGIiEyedUWTVwyqfwWsG5lWlG+NUIFzTPLN4MkWLR8tb4N7Gd/DN6bs0oeysfmyIRln510X9sT0+w7S31XjjyGDzdc+EhTz0JSGW9FEVBkFdQvHXSw235WFcYOlf8oWZGgUXJf/B+EgDDqAcfLKVrrgrcGvNLiobob2aqdLTzqRU26g6EljgPu44kav2mrhBFp4WGUfu8vxYKh9pRXBNT8jL4WLw4EuhJjC6vvcU9sXFdFEoigIeFga358PchmsaH7woWsIIJLz6A2xKUtDAY3eYZimNNA5SUCiRqMcFZ578r9nQ+jH7t4267PlOpisnl6Kl9y/jJn7o7Z19m0cfX0lUq3tIhGJ+GuRAZ6WhoaXMS8bl9lDwWNLZtApUOE6HkBJNYcnGGDzT7QLB5mLV7SVvfVCoVhXrLf7DqYQsG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tYiNqBs9D2L3KoW2vUyGFvsyaJkYU9bKqHOSIl1AOy6SQ10+UEuP8X4ESEvn?=
 =?us-ascii?Q?SZq9/8UN5uuHDeVSTajvwRY4Ue3WdYlzyH5vK9iMgZ9ApXY19kDb4khUtfn6?=
 =?us-ascii?Q?L2aHorbsh2Q0Ac82BiucAp+djlWKLjddOfZWXNYlpk/6fWUq/E9fqoFEKhs6?=
 =?us-ascii?Q?vNsjQU9kTTvP/GTA+23n54xQOFupq7GCnuMnNyfGRZDaDu6iSl2yFwBSAEnm?=
 =?us-ascii?Q?QBqY7z2lPOCBdEA9a58x7Ns2twUllqMJxn9F5ocB++9WLe4YsjGBJWh58QB8?=
 =?us-ascii?Q?YIdRffMeghpYU9Dez02yHjVT6m1pIm2udelTgzwhtdjCnpXELVA+CBAMfn+9?=
 =?us-ascii?Q?vsAvY3a4FwLhuQkDvKi4koW368EIyLd9Pgjyq/1Q3i3/dUmZlv4I5dd9qLiH?=
 =?us-ascii?Q?7aeMAo1GF8I7JrW2Pw5Gp3H1URsg8OMdOU+jtGleqZjD0aYY0ZmlAMaRmg5r?=
 =?us-ascii?Q?K4OGmbTweBpVtW1H8aSm1ZG5Nhltl4JYPPYVmX9YZfEMJwFPWWAcMsQJdURc?=
 =?us-ascii?Q?aLTxdiTyLp5jOeFL7ucSxlA2kidRRCmEMcs2usC+yTVsrRBzEPB0TVRRUN10?=
 =?us-ascii?Q?e+6A8lIhzotDrAkrGL1rzi7hDT2bgXsOgWgSm+swRcB+UzPWoe/4omMeS9o7?=
 =?us-ascii?Q?l4CzP6ljT1si4k2ZrMEV9klr2zL1AwIV/53NzLflcRUBCM0fk7RBEP6gqIZY?=
 =?us-ascii?Q?ziOKmTE1C3qhSNFvZ67Lyhds94bAXKbUuFEbCjbBJz/okfKuss8Du6AkvYwP?=
 =?us-ascii?Q?I0B7mglihl9yNqnippLNbWQqzj/RVY71phxH87+fy8leNx4Iumsu9PxUE4vk?=
 =?us-ascii?Q?C/Is97NolX0NYrh1Az/JqZRztLB4t5T+uLcXuXik6zbKj34De5y+PnDsxt0K?=
 =?us-ascii?Q?JUlveSmh159PVYBUf8PflLRo6lpiLQQO5L2u0aV2/o67kS+o6+JGv3sW7wbO?=
 =?us-ascii?Q?JwCfyimcFFlV/IQPQzLteEVITZC5MZoIaaNKi6zXQ8mHuusv93NmTHMOG/Le?=
 =?us-ascii?Q?UFCmMY7Vr/dIBv6dOzWV1JxZo0oKUahDzF79uQ/ESjIbbKJMd7UUfVwv0Yy6?=
 =?us-ascii?Q?cn2tDB2jRgVT87WXTYuDcxRNdnwbnQ8n+KGp1mnVIzO9C4jTjzX7PIRrrQON?=
 =?us-ascii?Q?LtC1nBpUr3wW86DjWYQk31rSUi8COXyVRQvMijQwlbWq1wU1pVnHtCJ6rqOf?=
 =?us-ascii?Q?QYJiW7oWuvmb+5hiOwBjUpqEB++JALCm8spb75I1DDjAW4g27JIRnpx92RoV?=
 =?us-ascii?Q?fKKJBLD9yCZF2WT1yi0lVJUNOeUWmwQzzXGdp5wre7U2jPfPxn+gwyV1lf0/?=
 =?us-ascii?Q?lT4TV9xV6LgAhC3nVLHtu9xa0mLcaxBhrLcYxSS7KH60KnlWW7lGXK2Vzp6s?=
 =?us-ascii?Q?hBdrmIEpzVc3VzPUFMyKIOq7I/O40kdray+kOkNOJJhM+6SL/SAprwamXzIN?=
 =?us-ascii?Q?fDwIxpNdgb2nUOB4aUcHWKvHDEO5wTuvnNnpQYCPWPdOXO64uqjgFhx3+/oB?=
 =?us-ascii?Q?ELO+gWt1jm1eeMKWNZ8mW+BCa27LWHxuM+5Re3QUAYa0DkZ2xWLUjziQKlcN?=
 =?us-ascii?Q?83JQDWIRWPLjhGB/Y6GYUl2RMg3ihA1jmssViHY3F9uoy0Om8BzjQ8G57nm6?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4199bf-603f-4d7a-6db6-08dc5db65f35
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 01:41:44.4015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIFPxtkmsgyffD4donD9emChEwZjbifZviD8yDfFF0woxEQlxgZpfAIumpc+L0HpWissukAhVQeF1Bs2WVAwag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6886
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "RIP:__dl_server_attach_root" on:

commit: 1abba9e7f47ad4a5dfd8b2dfb59aa607983cdce4 ("sched/fair: Fair server interface")
git://git.kernel.org/cgit/linux/kernel/git/bristot/linux dl_server_v6_try11

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7a6d30c9-1_20240318
with following parameters:

	group: cgroup



compiler: gcc-13
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404160945.7f0031c5-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240416/202404160945.7f0031c5-lkp@intel.com


[  387.680270][  T212] divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  387.680905][  T212] CPU: 0 PID: 212 Comm: kworker/2:1 Not tainted 6.9.0-rc2-00003-g1abba9e7f47a #1
[  387.681752][  T212] Hardware name: Gigabyte Technology Co., Ltd. X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
[  387.682702][  T212] Workqueue: events cpuset_hotplug_workfn
[  387.683256][  T212] RIP: 0010:__dl_server_attach_root+0x143/0x430
[  387.683848][  T212] Code: ea 03 80 3c 02 00 0f 85 d9 02 00 00 4c 01 a5 88 00 00 00 44 89 e0 41 81 fc 00 00 00 80 75 0a 41 83 fd ff 0f 84 1c 0e a7 02 99 <41> f7 fd f7 d8 89 04 24 e8 90 cb aa 02 85 c0 0f 85 6e 01 00 00 49
[  387.685550][  T212] RSP: 0018:ffffc9000110f988 EFLAGS: 00010887
[  387.686124][  T212] RAX: 0000000000000000 RBX: 0000000000047100 RCX: dffffc0000000000
[  387.686861][  T212] RDX: 0000000000000000 RSI: 1ffffffff0bc1724 RDI: ffffffff86ef2948
[  387.687602][  T212] RBP: ffffffff86ef28c0 R08: ffff888100058638 R09: fffff52000221f23
[  387.688345][  T212] R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000000
[  387.689083][  T212] R13: 0000000000000000 R14: 0000000000000002 R15: ffff888805d47100
[  387.689824][  T212] FS:  0000000000000000(0000) GS:ffff888805c00000(0000) knlGS:0000000000000000
[  387.690646][  T212] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  387.691264][  T212] CR2: 0000000000451c00 CR3: 000000089ba7a002 CR4: 00000000003706f0
[  387.692005][  T212] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  387.692744][  T212] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  387.693490][  T212] Call Trace:
[  387.693842][  T212]  <TASK>
[  387.694161][  T212]  ? die+0x36/0x90
[  387.694551][  T212]  ? do_trap+0x19e/0x240
[  387.694977][  T212]  ? __dl_server_attach_root+0x143/0x430
[  387.695522][  T212]  ? __dl_server_attach_root+0x143/0x430
[  387.696065][  T212]  ? do_error_trap+0xa3/0x170
[  387.696526][  T212]  ? __dl_server_attach_root+0x143/0x430
[  387.697066][  T212]  ? exc_divide_error+0x38/0x50
[  387.697542][  T212]  ? __dl_server_attach_root+0x143/0x430
[  387.698081][  T212]  ? asm_exc_divide_error+0x1a/0x20
[  387.698592][  T212]  ? __dl_server_attach_root+0x143/0x430
[  387.699133][  T212]  ? __dl_server_attach_root+0x100/0x430
[  387.699675][  T212]  ? sched_clock+0x10/0x30
[  387.700119][  T212]  ? lock_pin_lock+0x162/0x240
[  387.700590][  T212]  rq_attach_root+0x3c1/0x490
[  387.701055][  T212]  cpu_attach_domain+0x4c5/0x7e0
[  387.701536][  T212]  ? mark_held_locks+0x96/0xe0
[  387.702009][  T212]  partition_sched_domains_locked+0x356/0xa70
[  387.702588][  T212]  rebuild_sched_domains_locked+0x2e1/0x480
[  387.703149][  T212]  ? __pfx_rebuild_sched_domains_locked+0x10/0x10
[  387.703754][  T212]  ? trace_contention_end+0xf0/0x140
[  387.704353][  T212]  cpuset_hotplug_workfn+0x49b/0xe40
[  387.704865][  T212]  ? __pfx_lock_acquire+0x10/0x10
[  387.705354][  T212]  ? __pfx_cpuset_hotplug_workfn+0x10/0x10
[  387.705908][  T212]  ? lock_is_held_type+0x8f/0x100
[  387.706404][  T212]  process_one_work+0x804/0x1720
[  387.706891][  T212]  ? __pfx_lock_acquire+0x10/0x10
[  387.707385][  T212]  ? __pfx_process_one_work+0x10/0x10
[  387.707903][  T212]  ? assign_work+0x16c/0x240
[  387.708364][  T212]  worker_thread+0x724/0x1300
[  387.708830][  T212]  ? __pfx_worker_thread+0x10/0x10
[  387.710258][  T212]  kthread+0x2de/0x3c0
[  387.710670][  T212]  ? __pfx_kthread+0x10/0x10
[  387.711122][  T212]  ret_from_fork+0x31/0x70
[  387.711565][  T212]  ? __pfx_kthread+0x10/0x10
[  387.712023][  T212]  ret_from_fork_asm+0x1a/0x30
[  387.712501][  T212]  </TASK>
[  387.712828][  T212] Modules linked in: netconsole openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp btrfs coretemp blake2b_generic xor zstd_compress kvm_intel raid6_pq libcrc32c kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 nvme rapl nvme_core ahci intel_cstate t10_pi libahci ipmi_devintf mei_me ipmi_msghandler wmi_bmof mxm_wmi intel_wmi_thunderbolt intel_uncore crc64_rocksoft_generic wdat_wdt libata crc64_rocksoft i2c_i801 crc64 ioatdma mei i2c_smbus dca wmi binfmt_misc loop fuse drm dm_mod ip_tables
[  387.717730][  T212] ---[ end trace 0000000000000000 ]---
[  387.718259][  T212] RIP: 0010:__dl_server_attach_root+0x143/0x430
[  387.718852][  T212] Code: ea 03 80 3c 02 00 0f 85 d9 02 00 00 4c 01 a5 88 00 00 00 44 89 e0 41 81 fc 00 00 00 80 75 0a 41 83 fd ff 0f 84 1c 0e a7 02 99 <41> f7 fd f7 d8 89 04 24 e8 90 cb aa 02 85 c0 0f 85 6e 01 00 00 49
[  387.720553][  T212] RSP: 0018:ffffc9000110f988 EFLAGS: 00010887
[  387.721130][  T212] RAX: 0000000000000000 RBX: 0000000000047100 RCX: dffffc0000000000
[  387.721871][  T212] RDX: 0000000000000000 RSI: 1ffffffff0bc1724 RDI: ffffffff86ef2948
[  387.722616][  T212] RBP: ffffffff86ef28c0 R08: ffff888100058638 R09: fffff52000221f23
[  387.723359][  T212] R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000000
[  387.724101][  T212] R13: 0000000000000000 R14: 0000000000000002 R15: ffff888805d47100
[  387.724839][  T212] FS:  0000000000000000(0000) GS:ffff888805c00000(0000) knlGS:0000000000000000
[  387.725661][  T212] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  387.726277][  T212] CR2: 0000000000451c00 CR3: 000000089ba7a002 CR4: 00000000003706f0
[  387.727017][  T212] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  387.727755][  T212] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  387.728499][  T212] Kernel panic - not syncing: Fatal exception
[  387.729153][  T212] Kernel Offset: disabled



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


