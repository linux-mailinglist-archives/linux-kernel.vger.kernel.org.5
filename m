Return-Path: <linux-kernel+bounces-144544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4608A4799
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47971F21AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44948610C;
	Mon, 15 Apr 2024 05:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNZklJ1m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708634C61;
	Mon, 15 Apr 2024 05:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713159059; cv=fail; b=BUpcgOzNBRG2T6JsrSIwulI+xXMJx6v4vrzUr4LsebSRlbWtHQcOotIe9ISu0TfUPnn4HVampZfMvdoJ2rMdlBJCW8Oktbn9b4klvWJDoa1HSEdQqdwj0fopZw7ln8v800L1h12IpBRLYHpdW8G5e3U9jPpwjZYvbQ46zxU5cvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713159059; c=relaxed/simple;
	bh=iUAVtk7qYFAepW2qgWpNRlBfPv1/4reGtdqmMgPnTRM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=onxu5WXX38kcOiHO5KJtu8O5TlBVDR4eURHD0Md0TwUtFQ7cD5tcAm5Omkp+MOEbKrCvh04k+SPX7KVq0Wl/efRUgfZY9ijciJThy2EBZbFCk8lY75WpiHDcmwK/VVxH+8S+9ayA6Q+1vO78hd+hilLGcV+AHHNjFRXKKolWgTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNZklJ1m; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713159058; x=1744695058;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iUAVtk7qYFAepW2qgWpNRlBfPv1/4reGtdqmMgPnTRM=;
  b=VNZklJ1m2EiZfp795Qeqik5S3KTD4dvlQkNt+bc8AmpHM0ZM8uTXyUun
   mXrk+n//HGWHIlPv3zsqRBh4qpR0n5foGtgD/8o2Cy+RWxLlsyBfroP+r
   l0+iYlFzK4xFMjIV2FlCCUmo2mez1zjgyyo7bccgS4V1TrcUIVnZfyqSa
   lFDCtmmH0ah973vGPLWjJHvBa64KazumY8/3ujJqd8eKIr/8paR2g37dz
   qVHhnwtz6M7wHa2J7jQ1PhWFsCX+ikZGQoZtO5+fxM5Dm/CiJrwEBUTh6
   n3RVz9k3NCtnz1N6KpYgZK66Q/MAnKlKJAJbQsaBxxmYxkTZU4JG55w05
   A==;
X-CSE-ConnectionGUID: 9YZ+pOAnRLSC36dvgkuwaA==
X-CSE-MsgGUID: EIYO1DcTSNObWvCfB8uPwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8654563"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8654563"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 22:30:57 -0700
X-CSE-ConnectionGUID: PCrQCQjjQXyr09Q12+YHHA==
X-CSE-MsgGUID: KdOYy+YWSVGFYtf6i85cyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="22276677"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Apr 2024 22:30:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 22:30:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 22:30:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Apr 2024 22:30:55 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Apr 2024 22:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5LSWIk7k25gKdmU0TohHEGHIKfFGeUgROuzZuDvCdSujtaLIM9r8C4trsvnMDjaIEF1ymg0GvOIPaq+yhcCcjXthm/4BiS58fETmPx+mwycwYoNt9kLhTAGHDeu4M14nsY/Rm6/i8aWEqcVCvKb9aJmdzmIb9e33kXKvoZp6K0Z3DdQTvOZLXv4Ua7lrXk8zcDzW2Z3I3t7HnKoenRNtJGDPDt4Mr5B57aRLUR6qMPNlHCKryVj56uKUZZUQQ0MSKIVJFitkcPvtbhdwXM8nCTugdTLyaYuGDS6NK75GxLnOA0oF8CXieLttGDjWefduSGdO5vUg0Arr0BTof/30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVlHKkcgoP0hlvzrmfYbnTe5v6BXXjUdGDMnQ/DeQk0=;
 b=iK+ejRF51EweNBnsYGDBPOa4/fchOTKky/jj77vprR1MUL5q0qOYHyYCX9Z4Vayi9Rpcum1Xb8tlpe7QdBONPQKMTqtusRHas0CguPfKjLJ1Qz8wGiSA/tQto9/anafwMveeqg6y1VohTOPNJCDZX2I9HFEdcD9mBgE0X3HVV4pEi7GdWuKIF2B9h1fegtZMm013GuFBGylv10t+XViHsFFsOczY8KK6TOw1FwQ7GjBhKPv6o7A9VOwfAbSPdiIx8Jyn7ebiDb/x/wYzZAtB0YEdUtTxt4IIQE+h9HV4Kh/hJGhLXIo2CdqbkF5xWZZwuD1adyZ2gxKdu6g7wXqunQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6651.namprd11.prod.outlook.com (2603:10b6:510:1a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Mon, 15 Apr
 2024 05:30:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 05:30:53 +0000
Date: Mon, 15 Apr 2024 13:30:45 +0800
From: kernel test robot <oliver.sang@intel.com>
To: KP Singh <kpsingh@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Casey Schaufler
	<casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, Song Liu
	<song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [kpsingh:static_calls] [security]  9e15595ed0:
 Kernel_panic-not_syncing:lsm_static_call_init-Ran_out_of_static_slots
Message-ID: <202404151225.ce542e38-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 773dad59-5dc4-4287-71b2-08dc5d0d37cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6bNajX3WdNuUpyb0/AcBZxMuFrBdQQFxsXsUyyEvL2eHGtucoBqthdgSykKgVglJ3TsSOQH9h3NafCZ6k5E1h1Amo8peZWqvrHqy1bT9OU/33inwqkjqOPotLtnAP4nF3AQOjEi9tgFPBNNNJedwiocR/UZ2jM+OqlSApWlVDARYL8b+F08Y/Mm90lzBrLogPeSkOo9/Y3vnMR4qbOhrTj7fLjhk3owI53a+Q9kB/W6U/B0k7/nT2LOb0J5wn3Gc7oZlyK0hai+1Qt8ZCQhEwJMjS6AaOMrCWlMaZ2St2+rkPGVALSyRnBI2RS2gZJ77+KbR6EnSakxw6cjxcljEN+aA9REsO8xA95rv58F7z3lev/tt8QcEC+5eu66NbiCoIqsrBVN3ruCot6rIqf0O/g3RhK0jDeTpocO+W9QWxffkr9GVY6Yam8jt6ZHqzeLmdms77hU1GJ8bvDj3zoMMHkJ8+089XJjDzhwXxkEVg7zj30AtlzcizLhUXeqLhb/yR2OIK5kIe4UG25Q8HMTqMX5P8hUixFpuWHq2EvgBmf6qLfJxegDeMmC0ffFMsKQJHJuUU+g5WpDxo3NQgCaSuCdwgTC+eoKMgyfvSrmauaIDYY5Z4LJuDrb+SsWaV19
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?efRojqI/Xflhdh3+gij3V3CzrztN28UuwZdXBecQYsBL15E0+0AsGy4oynTL?=
 =?us-ascii?Q?bs+BXoFQi/8reJc6lRzPEj3qgXK41q/YhbP0xGV+4sSumkoP+IMZ1/uMYZOs?=
 =?us-ascii?Q?+am27yR7aC+Jj06Y11T18PhgoyZ86mCnp8oAWS29EAAbbVjQEPiNeETCzCdU?=
 =?us-ascii?Q?NkebVRczHHLfoYKUDSienMNZMW1TopTPqAbqwgbuFnPhCr1jE6fQd+jErlEe?=
 =?us-ascii?Q?+jmxnqVNt5zBnqQtmMfZBBB5fOEPG9FrMzU/o1zRvKPVO5O2a3qUdlsC5yru?=
 =?us-ascii?Q?HXoDghP7ECFhMct3oz/erPVLrbes6k88n8nmpHJdI5tN4/ns+NRt4Is3hiS1?=
 =?us-ascii?Q?muCxn8onOejN3NSwf0ZxkTn81j+KZ4MaNQTl4CrTkHFY18gT8l66EkySaBvB?=
 =?us-ascii?Q?X8CjrGk8wYz1OF83bBKZm6IDkuyUr75ch0XiWYxYccT8TbXr8t9Ncw5qNZjW?=
 =?us-ascii?Q?byIVswVAv2TMU7JjTr/0kKiAwm/f7uNoDohwaFIjyvRE/GaL9g1k80dPh3uR?=
 =?us-ascii?Q?jBbWodg1kyXpTqIXMxiVoH5eY9Ya+X2R2L2FxI8LaQB3QvDJ0iMrGyusevC3?=
 =?us-ascii?Q?MBt2Iocha8l64/FYt3HYcV5vGCXQfINW7zKOXG3AE23TC7woZ37KXu4VtKh4?=
 =?us-ascii?Q?2OGAPkmSwcvsmM5zigFYhh2d5j9r9mFPeDf7KikYNJEtgVxZpahizqGgoeSh?=
 =?us-ascii?Q?rNNy5T6sWXFWqB07ioeqlsNkSOx/dS2dZ7pk7uA6oVvteDo2vKLhDxHZX/R8?=
 =?us-ascii?Q?KgihV85hOEhYrq2aNzsOsuE8sWEmBjvnnaga3SMooEmLc8C6+YUlvSlswwY0?=
 =?us-ascii?Q?F5mVDwmTixWfXgZ5hOsS0dfSu+Mzy+qJFixOQ0mOX1F5nwDIP9pJQC/Xn1kx?=
 =?us-ascii?Q?+54TWOC8kx9BtrANpTYfHk2eiZIuzaQPbjgYJXfD8wofAP0il5UEJFQ+uI09?=
 =?us-ascii?Q?VIT66RYhae/k5nYQyM+7l6mr8wdsVZ5n5qg5khYWJo1BZqLZyuOLW9znndio?=
 =?us-ascii?Q?jufAqZbHXPv7Dq0kf4PV4tIjQGi90c71jcHtMbkrszFvPzstl6JxJI6itqxh?=
 =?us-ascii?Q?QK0/3/KYokIcgvlCriisin3T97Z8/Qr9Ha5X1VPQHdREATxlLI99BXDIqN7/?=
 =?us-ascii?Q?vfjgPBdCH5N0SAT4UopYoMw4QhDvYxGyPqeiMupSv2q8BYa+GIMrcgn1k5jd?=
 =?us-ascii?Q?O45s9CtCXk5iBA1ukBut4EVdJszk7/wnWSPZJh/u+YAm64tFuxJ6mLVJbc3E?=
 =?us-ascii?Q?yYHeXZc9726CzB0QzbidxT4H8jnDKZhKAwBe8SSBoS9BVTMpSjfmsA04L93f?=
 =?us-ascii?Q?QXbRmhLzDWF4m/qTHWPPXdGphmUZz+P+9hn2wqQN4OG2iXUd8+V3Q2g7MLH5?=
 =?us-ascii?Q?a/I8k+prf3HxKKTd/RFDIYl48KwJ85PIrg8T07ZR2/cY04l7UtewXJhzvDBu?=
 =?us-ascii?Q?ARsJ5i3oC7xOtmjAIQDfCySX1pNVgUnUE1Z6kOkjFVoJ0AHitD99iQbe+5Vt?=
 =?us-ascii?Q?BGrFcFYVhh7Ww99aYNEBZrZApnrpbOmKHhQtxa2Yk5AxWonpEHjnw2oMy9lf?=
 =?us-ascii?Q?4KD90mdTmxCMgLesJdj5Q+gmD7FhO+xluZeU/armiyG95Cmxpuknd17islEU?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 773dad59-5dc4-4287-71b2-08dc5d0d37cf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 05:30:53.2770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mnYnHAE+ar8K8nUVf5pq0mM8qmcgslpQkYF9lFWOfp8c+ArhnQEHAIn47r5JDiJCNncTYsqBSWkoTshQmmjgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6651
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Kernel_panic-not_syncing:lsm_static_call_init-Ran_out_of_static_slots" on:

commit: 9e15595ed016dc9b726b7b13ec3d9b92b9e53c68 ("security: Replace indirect LSM hook calls with static calls")
https://git.kernel.org/cgit/linux/kernel/git/kpsingh/linux.git static_calls

in testcase: boot

compiler: clang-17
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------------+------------+------------+
|                                                                       | e2f2a7e74d | 9e15595ed0 |
+-----------------------------------------------------------------------+------------+------------+
| Kernel_panic-not_syncing:lsm_static_call_init-Ran_out_of_static_slots | 0          | 12         |
+-----------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404151225.ce542e38-lkp@intel.com


[    1.020355][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    1.020966][    T0] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    1.022632][    T0] Freeing SMP alternatives memory: 32K
[    1.023145][    T0] pid_max: default: 32768 minimum: 301
[    1.025772][    T0] LSM: initializing lsm=capability,ima
[    1.027282][    T0] Kernel panic - not syncing: lsm_static_call_init - Ran out of static slots.
[    1.028283][    T0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                T  6.9.0-rc1-00003-g9e15595ed016 #1
[    1.028948][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    1.028948][    T0] Call Trace:
[ 1.028948][ T0] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:116) 
[ 1.028948][ T0] ? vprintk (kbuild/src/consumer/kernel/printk/printk_safe.c:?) 
[ 1.028948][ T0] dump_stack (kbuild/src/consumer/lib/dump_stack.c:123) 
[ 1.028948][ T0] panic (kbuild/src/consumer/kernel/panic.c:369) 
[ 1.028948][ T0] lsm_static_call_init (kbuild/src/consumer/security/security.c:415) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240415/202404151225.ce542e38-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


