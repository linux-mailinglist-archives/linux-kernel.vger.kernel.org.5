Return-Path: <linux-kernel+bounces-146346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF59F8A63BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4371C21043
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117463D38E;
	Tue, 16 Apr 2024 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuRs5tk6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0689A3BBEC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248859; cv=fail; b=MEHCcujDg7v6MueCHd9kznMUC0Y4SznBY11RPpKHxLbgD7F9NF7wKnCTPbDk+D657VrDYJChYms/urVpzC7ihln3ZDjgNPFUht4buBJYJFzdmiEy1UwPgzA9EsTMm4Z2E2ccd0LcpZuZEa5JsHkPERI//qDBYTKdAGfjXDcIAF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248859; c=relaxed/simple;
	bh=ULeCFe1in1tlqgzNpvFdGZJUQH00N7qsK/f/EBtJybk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=crPeTqGvmliPXAUed6Qs3p2T2o5devnOnN+LgEqBZ8NhorVSv2ejLDbVs40Ch61cmjpSs8/O1XFsiYn97bbUtlHGauJh4LLP0ffG1bddq2HSYQt+EqTWcu1q6XRPogIPsR3BJ3UxjpDNrMOI8Ttxgz142naWq+FIU0X0Se9UgQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FuRs5tk6; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713248857; x=1744784857;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ULeCFe1in1tlqgzNpvFdGZJUQH00N7qsK/f/EBtJybk=;
  b=FuRs5tk64abbqH5z8ekFUfidaK+eVX2XkvXyHS+xi3ctu6CQYx9KRKqR
   0c82F21tcZJPxWPn3ymE0BiLbmtnNe8lZW70pJCRgobO7IQhyczfyvs16
   e+iGhCTNu2fpENtcILYJcxLcXWWhi+0m4iVrj05f6GZNP7BglLyQor5Wz
   fS/g9zEc8yiwy3IuY9XiZZKBGjciDn4aC8uSP1T/D1HNalTYV4n49nTFf
   b2O2X1B7x4EONMA+IpmzolZKBWLV0RalOozLvPuuSLgj+FE31c9jytcjC
   9gvzPzS8Jf0qBgBep0IBBhPxEDNC8+XLltmzSQf7gtlrw7A2vbX0VhcI4
   Q==;
X-CSE-ConnectionGUID: UDr+67l5RieLSCUtdnA2Lw==
X-CSE-MsgGUID: 9/kVQdGCSDqanrjcOmasLA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8888830"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8888830"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:27:36 -0700
X-CSE-ConnectionGUID: pfqixzP4TemN/TYbnf9B8Q==
X-CSE-MsgGUID: mMXmqkYxSEGhVe4H3SkZag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22220349"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 23:27:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 23:27:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 23:27:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 23:27:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGhB8AJum88QOsfUfNld9zeD8D6zF3sEW3YzsiQDSgJvTVw6LnekdkizhjKf/InnOw1zThs8mSx39fo8u+cOIA2pO3MHYdjtpfVu2jdobGw8wlxFVZ3esay4dSMICyAbvToxy6PVmdcqLyNcFnjjhT0GU2cevNC6xfybDbYq8GBd3iMiXqDjvzHoGoHzQ45LqT8u5yxkP5M2C1Yoo7owKWx6XVlDIBSYGFRnEFRcB6wyCj3ctnw/G7n9vo2kUlrTxJBm1O6ln7eHFoMfgQnf96Sj8wD5phrU714xdowUmUNupMr4XxStwqjmF5sXscSdCKFF21f41JHEdpNt7Fdqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaJmgJy50yDclOJ/dDYfdiLzRUyDswOmfyM3fxzzQ5A=;
 b=bF1ZjYVSkRIq3V3cPdJ+kzGcH/y+6KSWevdE3LMW3oTomYFcgpg02uonPyodgOzkTtXgSTp1N+gAtr3E3i1/YbTBecnTdOhBnC2m2Tk57XmTwe1X/cgF0hwuK5Ulhb5WbXZzeJcPzqVVIU3cpzKLky5NSWiCYCrSXJuT1oJG5mmbwl7r54X4zVxpIFOFD3jMsfq/XvEKhlZd6uls7aIS7rmZYHA0Hnv0OsYeqnJeLIaX0dmD3WvHreFR4lSF97mEsIFaCTfGcz1nMG61hbxUgIwKFoll1ktkPvXHv39xO6T2LUm7G95VCZrhdPH6kP4VqLi8tjkz/bBGsM0qVZAeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7801.namprd11.prod.outlook.com (2603:10b6:8:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:27:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7472.025; Tue, 16 Apr 2024
 06:27:34 +0000
Date: Tue, 16 Apr 2024 14:27:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	<oliver.sang@intel.com>
Subject: [tip:timers/core] [timekeeping]  e84f43e34f:
 BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns
Message-ID: <202404161050.38f1c92e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f2151e-7364-4383-ae7e-08dc5dde4d19
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5UZYUAVf4hNiCRh1anD5KzQpfijeAyB5HMCfNVbdV+tNDWVNUM+h1lXfcwKTCCSaC8RBAYouzrnLAV+sHUMcOGddg0EymGj0spDDny20pIse+Tboj4H2i+VCZI0kWhyELz96tnOmdUajstt6wfPW/j1w2EaTU9ACKqcNsgapdPVUNJWNiuFIgn6IjNgU5R1MvTSjEcn2LvkLjAetG/5ezFv1lswsBRq9uY744PJenudnuT9IXYwcsQEb5+2TcWpis8L3ANKazxcEkhtJLu8P+R3zoLmYnlLQQ4PFh/SdU8TuoLq8NUm28mAVjhYaONjyAs2k4muXgRuJpDfueIbAxSrf+4d8rz8hHMcg9najf1I9A2IOIx272fBOi3CYXvLEbyJ1Ra0ISCNMBkoSB3sNhCgF9LuDx3fkJWLjKchB+Fp38Q7xORVSFwx5chsV3inEzGaf9yuVRJsWdsMVf/bB+ku8lVPVJFUqUHUYetm19TJeJH9WdBSZ/qG49H3VHUttOsMwymzOLpkwCiQfHHE31vUxg0PJWLRE/Tdwr2MBcIG6FOT/0cQMwBB7pY4VIkKWjLYfRL21Ag3dE75Vv3leld3dI3rF1zVkiIkwBdfsMELvs2PeUEZBuNs5VFK3qKL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cS9YRWSX+qe9ZAyvpV/SlE9nw7DAmbykI21lj1QyBtcSo8VZi5Kv6cvT+ku9?=
 =?us-ascii?Q?T+leXFX+4O7KdM5/kajrVj1y/v1A5G5vrvN2N9TyD5QFw9oLPyVhgImKKISd?=
 =?us-ascii?Q?V41S1EhegJl7An2reT4r3rf5+h3WcRIN+LxtrHgyOvvTNDymg4AVPtJm53bD?=
 =?us-ascii?Q?xmj3vL0FwoSWb4KAPpTIi9DDMix8p+ZR9b+AiQs7AO2rcZr+PfQuE4vZD2DY?=
 =?us-ascii?Q?BSCMvi9txrznhG9/ua8Y95i0wXOjO71ta85M2WEulVMI4fkqq225cpXZEzBB?=
 =?us-ascii?Q?I9/6L7jC5vrv3MUbA/Ig+MviTBsLo68YMmLcaAohpMnIAPZSyfldRDbMl51r?=
 =?us-ascii?Q?FisI58IgiY3d9Gwuo+EB+enZQDDFOd2G816QNXluYFyXmvz+jV9jruoAZ/Mp?=
 =?us-ascii?Q?4KlyyDsqMYSQyPA2pHW+nS90WTo35354XXl8aBnFJsYaWlqwIT3/MeENFrMX?=
 =?us-ascii?Q?K4fgXbQmyqnxdr9lG27Hd+RYqhmdyKkXkP0wt8iiuxTchDJsVmGUY6p3YQQh?=
 =?us-ascii?Q?LXpHq3/5oNNaRAgQ3ETp+roDqTP/savjddSKSSuDXc/dD7ffj3syzJtsgTY2?=
 =?us-ascii?Q?A+2rH6m5PBx76eRFzhhif6HCe7+s8y8WM/l4yhkt5Q3TOHyIQkM21iJBWCrx?=
 =?us-ascii?Q?G777ksmd1vsvp+4h+J/I7QoT02Tfa555oldGKJboQBSUxFdWZN2pgmJ/HYXa?=
 =?us-ascii?Q?C9GfeVx8CCxxm320cJJkiuApkIV1vG5VIMOVIrHsjIKErLPASKQot54tXZqp?=
 =?us-ascii?Q?kXpQwe6v7D9AmObWHXT73wjHS6Q5f9vVu5ckEt8akQPBGEQBX40oNnFeLsmH?=
 =?us-ascii?Q?azT0zMhtS5vuTMYBWpx6/maiqHWzs7EDerz8/5UMxIopRfKGiCp6uHi8HamV?=
 =?us-ascii?Q?CBpLOqk0LSA2jWpc8hQ+Ih1zM1yzagVzaxmarzvKArlDlkcNoEQparg0dNSW?=
 =?us-ascii?Q?HjzeEbAdwzBkFBFr6pJsypZizfBipkmkBE5lCNgybTiHZS/HIeEmJ8E3H+RQ?=
 =?us-ascii?Q?GphqcjzP1JqAQyx51fLZgf7VXL1SNoFxakLLJiHDZA1kpt+G+TfyBrboHKSP?=
 =?us-ascii?Q?m3eY1nIGlVrJh104SxftUr/mYJSgOQqpmWxcXjpkqumnauEHbJuUO3KLIfwi?=
 =?us-ascii?Q?XutDyWt1huc9JWUNB9KP+o+E7R0lZ11qAG+ntAhQnQLzCRynDFPfuS3al4Yt?=
 =?us-ascii?Q?gSsNSUlDlwUm6cOoWJfw60+7GhxWB299mkglGprmq7Yimy3nqqGwuxXSB/rT?=
 =?us-ascii?Q?ZCfKrRQLAMAJFBofdgM/008UVxhe0e3Imx5rq2/XcyhsOL977m8ucTsC8KKt?=
 =?us-ascii?Q?BjQgiL36brsGvD3Qi8sV4uRGoiilLCgqNKLy2vtxQKGRrlqTLIF6gp4gLS4q?=
 =?us-ascii?Q?/asDRmytqE54Qudk8nhVwhSU5f1cd1yaSz8TPNGXgRYVpQ1LaNnzt6dYlRTM?=
 =?us-ascii?Q?THbN7khtJc6NJAJGU7h/AZVHtT+jbqyqMiGXXy64v1N87RYAL0PmntesSTwG?=
 =?us-ascii?Q?N5djJqplIcG8kXUc4YKlvFJhOLm06qidBg8tIIW+koo85NSwy4Kdu8mKBwPC?=
 =?us-ascii?Q?6KtDOngjlNonWL1b1l/dmKr30pm4u0TjeuiMefCMU5YaXTWkRRKpkfkaZzl8?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f2151e-7364-4383-ae7e-08dc5dde4d19
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:27:34.0346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1v6heYSG5GJmuvaYO2WeP0JkukBGyVGnglWuQNPHdbjsluC0GuQGWNJhl+oyTSGek+OhjrKPYv0E1jtvZqXOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7801
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns" on:

commit: e84f43e34faf85816587f80594541ec978449d6e ("timekeeping: Consolidate timekeeping helpers")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git timers/core

[test failed on linux-next/master 9ed46da14b9b9b2ad4edb3b0c545b6dbe5c00d39]

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed this issue doesn't always happen on this commit (63 times out of
111 runs as below), however, parent keeps clean for this issue, but has other
KCSAN:data-race issues which does not happen on e84f43e34f.

e8e9d21a5df655a6 e84f43e34faf85816587f805945
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
         16:60         -27%            :111   dmesg.BUG:KCSAN:data-race_in_ktime_get/timekeeping_advance
          7:60         -12%            :111   dmesg.BUG:KCSAN:data-race_in_ktime_get_update_offsets_now/timekeeping_advance
           :60         105%          63:111   dmesg.BUG:KCSAN:data-race_in_timekeeping_advance/timekeeping_debug_get_ns



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404161050.38f1c92e-lkp@intel.com


[  108.068027][    C1] BUG: KCSAN: data-race in timekeeping_advance / timekeeping_debug_get_ns
[  108.069188][    C1]
[  108.069511][    C1] write to 0xffffffff95672dc0 of 296 bytes by interrupt on cpu 0:
[ 108.070559][ C1] timekeeping_advance (kernel/time/timekeeping.c:2207 (discriminator 1)) 
[ 108.071242][ C1] update_wall_time (kernel/time/timekeeping.c:2222 (discriminator 1)) 
[ 108.071883][ C1] tick_do_update_jiffies64 (kernel/time/tick-sched.c:149) 
[ 108.072638][ C1] tick_nohz_handler (kernel/time/tick-sched.c:229 kernel/time/tick-sched.c:287) 
[ 108.073235][ C1] __hrtimer_run_queues (kernel/time/hrtimer.c:1692 kernel/time/hrtimer.c:1756) 
[ 108.073840][ C1] hrtimer_interrupt (kernel/time/hrtimer.c:1821) 
[ 108.074430][ C1] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
[ 108.075132][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 2) arch/x86/kernel/apic/apic.c:1043 (discriminator 2)) 
[ 108.075821][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[  108.076657][    C1]
[  108.076982][    C1] read to 0xffffffff95672de0 of 8 bytes by interrupt on cpu 1:
[ 108.077994][ C1] timekeeping_debug_get_ns (kernel/time/timekeeping.c:373 kernel/time/timekeeping.c:383 kernel/time/timekeeping.c:280) 
[ 108.078766][ C1] ktime_get (kernel/time/timekeeping.c:394 kernel/time/timekeeping.c:838) 
[ 108.079325][ C1] tick_nohz_handler (kernel/time/tick-sched.c:220 kernel/time/tick-sched.c:287) 
[ 108.079995][ C1] __hrtimer_run_queues (kernel/time/hrtimer.c:1692 kernel/time/hrtimer.c:1756) 
[ 108.080740][ C1] hrtimer_interrupt (kernel/time/hrtimer.c:1821) 
[ 108.081423][ C1] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1050) 
[ 108.082241][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043 (discriminator 2) arch/x86/kernel/apic/apic.c:1043 (discriminator 2)) 
[ 108.083014][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[  108.083849][    C1]
[  108.084183][    C1] value changed: 0x000e771a64000000 -> 0x000e959ee4000000
[  108.085518][    C1]
[  108.085775][    C1] Reported by Kernel Concurrency Sanitizer on:
[  108.086563][    C1] CPU: 1 PID: 265 Comm: sed Tainted: G        W   E    N 6.9.0-rc3-00015-ge84f43e34faf #1 ddd7212d5d239f10e5f20ca1605d3d23d4ce80eb
[  108.088374][    C1] ==================================================================



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240416/202404161050.38f1c92e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


