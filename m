Return-Path: <linux-kernel+bounces-141846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F358A2434
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BC3286ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B4D14F7F;
	Fri, 12 Apr 2024 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpNwUrrc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4CF12E4E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891528; cv=fail; b=AM7iHloE5APGfEALcq0MO3AzYevDIvVrXXWNZ7VPrgUF6WtCRLZUOBv1FQcW6ixZjC749cL/BRzyzJXKbSNCVloAYubTkyJTzym7q69sXpcFViEtwL+5mJ+4d0MBMrXXxwpGFLK8isjfWEAzp1HoGwNTD7cnGtWPTAHqqLpnGIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891528; c=relaxed/simple;
	bh=paUIOSAJabin4d4e7F5NGZJ+5C359aDDZJAVLaiOuJ0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=UXyMhJvMGHpFWMTLxnDlnLHDic8uHlr8LYv+pBKY0V/jtVbSY/eK5UTquspxinQrWoM2YQhKJzI71nPf2mczS04dzcqOVhGuS5NcKCjQQkoL8S5oBZpjXRVO3Xoj5aZ7bK909KctcQyHF40+IPE+5YJ1pcf2zO6+NLuyyQqJ7rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpNwUrrc; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712891527; x=1744427527;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=paUIOSAJabin4d4e7F5NGZJ+5C359aDDZJAVLaiOuJ0=;
  b=lpNwUrrcbnLQx2+JYS/G1FVoSj+gl0PZI2aLgWHT9XzTsq9nDcE2V/3J
   qAjEC00+bgsFiCTKgw/WGRo+VAPoBO/1mGFFnyFVd9nJokgz5l8ZQW2Nv
   CCL1FnDyKYg5mveBsMwoO9eaK6aSRwHmRBbSTUBgIm0CgOUSW+6PQSILI
   ex8OOb0Rd5lTaDNnEJ7RvnR2AE0bg5bOuUrUijO3QbWnUcqKmt94BSqQE
   avC+TY1ODfIrPudZF5EW8anaVDNtPk+8/EVbXwSzpIJqPKWIFhB3Q4tCD
   VVlnkBJSlXolErj6sT8SyxxAJX5v8N55DN6ogjOc8vdqNqCcUQRg/pwsV
   A==;
X-CSE-ConnectionGUID: /bN7u9NwTlKRyvzBGcHybw==
X-CSE-MsgGUID: No9WcZTNR0S/BKDHulV+vg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19045455"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="19045455"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 20:12:06 -0700
X-CSE-ConnectionGUID: U1mRHKCgREKgyCo6sMY2aQ==
X-CSE-MsgGUID: NVkhr9yzRxOzcZD4sOMeaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="25904701"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 20:12:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 20:12:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 20:12:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 20:12:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 20:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aASVXT5rZWbWppQmP47Qk3NBJ7U5NTMl1ejPCbVK2kJeJzha5cA3i5Tl3962EOPco5VKQAAvGH8mHnTAbH81qVMMlG6XdH3CG2mVq/75LUl7f7UBWCQx35TLFDVKu9JHt8WraG98zQ0+N9Ts6dAHQ26tyCi9POY4qDbknPm8tGtavRHvSnhqDKRQgYgk01NVyvx4GxK7QSe162n32boAwNMzBoSpsjp25YHiq93DPDwf3jKATimseexoNLF+b2mwhgyhFDyXnb4CbVNeigdculERWf1dV6pESoA28ji9iAGxnLKKclcSUnhfCjbCfNMumsxZgBiyYvUS4WpO2OCyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdDqayHv+gOhuGhpHtkHgwbD5yyBBWKimCBZeddVLg8=;
 b=APTEz8KtKlhxhOgqnkbAFpiqTgZc7/wq4gMt7+OM+qOHO58F/R0t7q5naiNvXmWHWTIrelx6wWddSPjqsidE3Xp/rGasFQ3I3FmPzIiAeRUEKP9D7XEV/fs6EmhLbyUJpr0CFjk/VzuSBGfK43YYxWroB9gDAz68kn40VPrgn8K9rDlSSmkv2Sid91NFCozG7QWUrj1IYRq6aJ26x5egUpZ3w+XFbxLl94KLzVekNcQ3fx/gm0pq+BOQJeLJSru9UQeEYeR0TgbAOilFbTDSrAeoSXkygJQ/3/s94g2xzYB1YNtTRSl7tpYuatVmVeSvtK4rogXS4wrSnmFIUaBpVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6973.namprd11.prod.outlook.com (2603:10b6:510:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Fri, 12 Apr
 2024 03:12:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7472.025; Fri, 12 Apr 2024
 03:12:02 +0000
Date: Fri, 12 Apr 2024 11:11:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Daniel Bristot de Oliveira
	<bristot@kernel.org>, <linux-kernel@vger.kernel.org>, <ltp@lists.linux.it>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [bristot:dl_server_v6_try11] [sched/rt]  03100a344f:
 WARNING:at_kernel/sched/deadline.c:#task_contending
Message-ID: <202404121034.21a3864a-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df5d57b-05e3-42b8-c5fd-08dc5a9e52d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIUmq926izglL+zNPY3T+kDJF7/AzV1rLRKQSfv0EiFjSbg8jGKj8mhuznqJvzgDNG+QkfKgpax1/MZqip9xCBqXVpONe1z2VDbuF4ZgF2/dRyVV9ZDIAYutiWZ1BS7pKMew9+sJAWDeN1XygRvmpXEHM8/lhF98kvbsawz0/e1XqMXUMSMPAUOLE8qP06o0qHG0TP6TuMcJ2AfqgyuGZFRQiSkHgpa/j0TxArGlDJS6AleYHvKpuiRdSD9CZPcMzedvQDmU4PLWZHqWT6+Db6R99VSNoukboBKa/wTn/3avsI3iI+0Zx1L6l3q39fCJ/wgLbAMaQFbCvKYBvYm9m7TgdG7JrsH0QXLmFtbaRFXd0kgxEQvF/EOvn93trSwB7udhDLNqeQn0ImtFzOhaVwvxnl353pRztox94pJPcCAv3PphY80D1v+2DV3GDbm0dX9Wnw1mmbH16DvHrrsh6qwe31IyAUSJXVwHYCOlGqnZYc1VDU2xY7/8s7H0JF/pbJ+2Y5s2+pto7jVyh5wM4KKtW9gm0iNfNEQtzkPt1R0LMUeDnMKog5KSLJC5lvF71T7v4tX/yXZ7Bp76SztLAgWzp+a7T39LX3IBKo923hd2A8lJ8FtdIfli0vyXXOKT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BLFv3lG3Qkt1wC3mP6nE9KAFqgfbTs9ekfLyXBA7HhJO/sjbQ1RQfg2K7ycj?=
 =?us-ascii?Q?oFDnIxrkJoW1kACd9GArhhJeVBRUGDlsLw9RGaVdd5ezyG7H9ShlAYY5r99S?=
 =?us-ascii?Q?gShoP8nmWPm/aLv5jJtI/Fklj+vzrr7L4/53k+l33DrOGZsoltRJwWD0Ym9m?=
 =?us-ascii?Q?govHfcMMGAQuWD+1Y/5W/sRvOoH0bIw7rhQhENKvM1ayInj4qgNlrfzARySw?=
 =?us-ascii?Q?anSp00QQ7KRoABd0z1FC/d6kB/BYt18Xj1Vk+TYAafVhiCSTPIV+jOw/kJXm?=
 =?us-ascii?Q?C4O/onLKrHKjWfdHMTMhbDS4dTVBVwUpJ/azIiVVuWDl5LX3r2oYCYZbCZvK?=
 =?us-ascii?Q?m9Wx46WDpQfG86g9BSKZ87/E6++UnJCC2bXhfClbx09xqr0eR5mXRwXWlBk+?=
 =?us-ascii?Q?SZZ1sMnTQSfI0yM8zaXzFwpU/InAEyxO5PJY7CR46MtlEwfoFogl2qHlk49a?=
 =?us-ascii?Q?g0Q7nsp5XK43c0bOZ/j2+X9l6ruNqViwYc32T7WAZeTgztaQv+FtHVUNYeuU?=
 =?us-ascii?Q?CKuhw8qVRiSH1MGI1n3G7QO5nAGJTzLHN3xKHs903fGseVB1WdHvjeUWG4Gm?=
 =?us-ascii?Q?+2ThBDNdpkdkb/hO0NLZDpPHcRxMiWgr6LpVsUbxmij1y4B9WigbrsLYW09q?=
 =?us-ascii?Q?RP7Idzgqdtu+5QhVvWskoqtGfJWfwkIj7F7keanz0P8UtM2chq49ghSYOFhg?=
 =?us-ascii?Q?G5veK1K3UEWyJEwC/DUW8pxasSUY76GEwEwswUgn74o269XR0YSAPuBH4VHq?=
 =?us-ascii?Q?t8KCU32Czqkhryd0uKhkIXOIF0tBGCS3q8CHpUwZbVktI0+CkfeTTnOdak6Q?=
 =?us-ascii?Q?NvndIL1w7aqdlCw0N6A3ppVYR3IhBiLaO8kUko4G2Rnler3I4hQPrOyTMMDE?=
 =?us-ascii?Q?36uteuFef4Xl8kee3tH4/JpO7MpF8sbvwh30yH7e83/zxky22khXwsS8Jcqw?=
 =?us-ascii?Q?uUnvkOfmqWS1DhpONWzFbDdLu3vLyW2TGN8YSn2pzMnG/iHa4iwd0h0dVLO5?=
 =?us-ascii?Q?UJZArOXW6PZ6+Lojh2UHLnz52/Mn+XEw+JeNEINIgIjOKIZMo8GJEaOr2l/K?=
 =?us-ascii?Q?63AMY20j57Na5r/xVEZrzwyPTU3d02Jvy8hVTOVdx/YLuF/Ri0d4RI0XjFwH?=
 =?us-ascii?Q?0QTy6sYrm5bNVka2D+uMxtm1LcoBD4KlXLlXPZ8BmNBWU0gp2MfzmfDeq6k/?=
 =?us-ascii?Q?3rGVDBgvVRjdGNFqcuJhKMcNQhmoGFWSSxvlvorpcU2M4LBT+KT+QDWUELLg?=
 =?us-ascii?Q?UDC+Ocj+GHpZO8WYOe9i6Bn/6mSgN9mW50mBs+AS7yLecMGbnUa8QDm0Zkz7?=
 =?us-ascii?Q?SBpNb7FdA2/ies0AIG0QNAStDlnsgP/5IAKM3QFIXybzxK7Y8iOarkcmbpma?=
 =?us-ascii?Q?IMKoDUSpg6YviwIhML8nrXQm84MZfoRereQXPE3/MtrDceV7/sj3pI9Jte15?=
 =?us-ascii?Q?lmUGnJo6EEKTBeodmQHzaxOkpkQKfJkPBiI7u6E4c3oAh9l1Kd2TsXU6ltts?=
 =?us-ascii?Q?ayZTofy9Ev7Yc7V32jrFWMOspe5SDbUCTpUyqJBBg1fV7Oc3FG7ouN82xpKR?=
 =?us-ascii?Q?nUVs88jaK+KAYkumrXIIP9dxADfvfrupdsP3/+STQZBTKWr/rd085MfzgE5u?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df5d57b-05e3-42b8-c5fd-08dc5a9e52d2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 03:12:02.1999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBtKd1fheCMUU2FN9Zlwv7Dap9A/EaXE3eHbGV8tA44OimiqCq/8C8zoWg9CUeKSzF+sVXyEnyR9Gx8QVFd7GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6973
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/sched/deadline.c:#task_contending" on:

commit: 03100a344f14806e2e965fd79319b2bd8615601b ("sched/rt: Remove default bandwidth control")
git://git.kernel.org/cgit/linux/kernel/git/bristot/linux dl_server_v6_try11

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240406
with following parameters:

	test: sched



compiler: gcc-13
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404121034.21a3864a-oliver.sang@intel.com


[  185.555673][ T4639] ------------[ cut here ]------------
[  185.555940][ T4639] dl_rq->running_bw > dl_rq->this_bw
[ 185.555952][ T4639] WARNING: CPU: 2 PID: 4639 at kernel/sched/deadline.c:254 task_contending (kernel/sched/deadline.c:254 (discriminator 1) kernel/sched/deadline.c:314 (discriminator 1) kernel/sched/deadline.c:511 (discriminator 1)) 
[  185.556507][ T4639] Modules linked in: netconsole btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c sd_mod t10_pi intel_rapl_msr intel_rapl_common crc64_rocksoft_generic x86_pkg_temp_thermal intel_powerclamp coretemp crc64_rocksoft crc64 sg kvm_intel ipmi_devintf i915 ipmi_msghandler kvm drm_buddy crct10dif_pclmul intel_gtt crc32_pclmul crc32c_intel drm_display_helper ghash_clmulni_intel sha512_ssse3 ttm rapl mxm_wmi ahci drm_kms_helper intel_cstate firewire_ohci libahci video firewire_core i2c_i801 intel_uncore libata crc_itu_t lpc_ich i2c_smbus wmi binfmt_misc loop drm fuse dm_mod ip_tables
[  185.557861][ T4639] CPU: 2 PID: 4639 Comm: cfs_bandwidth01 Not tainted 6.9.0-rc2-00006-g03100a344f14 #1
[  185.558184][ T4639] Hardware name:  /DZ77BH-55K, BIOS BHZ7710H.86A.0097.2012.1228.1346 12/28/2012
[ 185.558459][ T4639] RIP: 0010:task_contending (kernel/sched/deadline.c:254 (discriminator 1) kernel/sched/deadline.c:314 (discriminator 1) kernel/sched/deadline.c:511 (discriminator 1)) 
[ 185.558674][ T4639] Code: e8 f2 1c 75 00 e9 29 fd ff ff 80 3d 85 11 50 04 00 0f 85 ed fc ff ff 48 c7 c7 a0 05 e9 83 c6 05 71 11 50 04 01 e8 7d aa ec ff <0f> 0b e9 d3 fc ff ff 80 3d 5f 11 50 04 00 0f 85 97 fc ff ff 48 c7
All code
========
   0:	e8 f2 1c 75 00       	callq  0x751cf7
   5:	e9 29 fd ff ff       	jmpq   0xfffffffffffffd33
   a:	80 3d 85 11 50 04 00 	cmpb   $0x0,0x4501185(%rip)        # 0x4501196
  11:	0f 85 ed fc ff ff    	jne    0xfffffffffffffd04
  17:	48 c7 c7 a0 05 e9 83 	mov    $0xffffffff83e905a0,%rdi
  1e:	c6 05 71 11 50 04 01 	movb   $0x1,0x4501171(%rip)        # 0x4501196
  25:	e8 7d aa ec ff       	callq  0xffffffffffecaaa7
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 d3 fc ff ff       	jmpq   0xfffffffffffffd04
  31:	80 3d 5f 11 50 04 00 	cmpb   $0x0,0x450115f(%rip)        # 0x4501197
  38:	0f 85 97 fc ff ff    	jne    0xfffffffffffffcd5
  3e:	48                   	rex.W
  3f:	c7                   	.byte 0xc7

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 d3 fc ff ff       	jmpq   0xfffffffffffffcda
   7:	80 3d 5f 11 50 04 00 	cmpb   $0x0,0x450115f(%rip)        # 0x450116d
   e:	0f 85 97 fc ff ff    	jne    0xfffffffffffffcab
  14:	48                   	rex.W
  15:	c7                   	.byte 0xc7
[  185.559149][ T4639] RSP: 0018:ffffc9000ac3fb18 EFLAGS: 00010086
[  185.559382][ T4639] RAX: 0000000000000000 RBX: ffff8883447c52a8 RCX: 0000000000000027
[  185.559652][ T4639] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff888344530b08
[  185.559938][ T4639] RBP: ffff8883447c4940 R08: 0000000000000001 R09: ffffed10688a6161
[  185.560241][ T4639] R10: ffff888344530b0b R11: 0000000000000001 R12: 0000000000019998
[  185.560540][ T4639] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000071
[  185.560811][ T4639] FS:  00007f685e46f740(0000) GS:ffff888344500000(0000) knlGS:0000000000000000
[  185.561114][ T4639] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  185.561374][ T4639] CR2: 00007f685e470068 CR3: 00000003ff104001 CR4: 00000000001706f0
[  185.561667][ T4639] Call Trace:
[  185.561840][ T4639]  <TASK>
[ 185.562039][ T4639] ? __warn (kernel/panic.c:694) 
[ 185.562270][ T4639] ? task_contending (kernel/sched/deadline.c:254 (discriminator 1) kernel/sched/deadline.c:314 (discriminator 1) kernel/sched/deadline.c:511 (discriminator 1)) 
[ 185.562502][ T4639] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 185.562731][ T4639] ? handle_bug (arch/x86/kernel/traps.c:239 (discriminator 1)) 
[ 185.562933][ T4639] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 185.563142][ T4639] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 185.563351][ T4639] ? task_contending (kernel/sched/deadline.c:254 (discriminator 1) kernel/sched/deadline.c:314 (discriminator 1) kernel/sched/deadline.c:511 (discriminator 1)) 
[ 185.563553][ T4639] ? task_contending (kernel/sched/deadline.c:254 (discriminator 1) kernel/sched/deadline.c:314 (discriminator 1) kernel/sched/deadline.c:511 (discriminator 1)) 
[ 185.563758][ T4639] enqueue_dl_entity (kernel/sched/deadline.c:75 kernel/sched/deadline.c:1071 kernel/sched/deadline.c:2053) 
[ 185.563981][ T4639] dl_server_start (kernel/sched/deadline.c:1652) 
[ 185.564185][ T4639] ? dl_server_update_idle_time (kernel/sched/deadline.c:1611 kernel/sched/deadline.c:1594) 
[ 185.564410][ T4639] enqueue_task_fair (kernel/sched/fair.c:6749) 
[ 185.564614][ T4639] activate_task (kernel/sched/core.c:2167 (discriminator 2)) 
[ 185.564834][ T4639] wake_up_new_task (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/sched.h:185 kernel/sched/core.c:4921) 
[ 185.565042][ T4639] ? __pfx_wake_up_new_task (kernel/sched/core.c:4897) 
[ 185.565266][ T4639] kernel_clone (kernel/fork.c:2830 (discriminator 1)) 
[ 185.565469][ T4639] ? __pfx_kernel_clone (kernel/fork.c:2756) 
[ 185.565674][ T4639] ? __pfx_free_object_rcu (mm/kmemleak.c:508) 
[ 185.565891][ T4639] ? rcu_segcblist_enqueue (arch/x86/include/asm/atomic64_64.h:25 include/linux/atomic/atomic-arch-fallback.h:2672 include/linux/atomic/atomic-long.h:121 include/linux/atomic/atomic-instrumented.h:3261 kernel/rcu/rcu_segcblist.c:214 kernel/rcu/rcu_segcblist.c:231 kernel/rcu/rcu_segcblist.c:343) 
[ 185.566093][ T4639] ? __call_rcu_common+0x319/0xa00 
[ 185.566310][ T4639] __do_sys_clone (kernel/fork.c:2928) 
[ 185.566502][ T4639] ? __pfx___do_sys_clone (kernel/fork.c:2928) 
[ 185.566715][ T4639] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 185.566929][ T4639] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
[ 185.567119][ T4639] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  185.567343][ T4639] RIP: 0033:0x7f685e546293
[ 185.567565][ T4639] Code: 00 00 00 00 00 66 90 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	00 66 90             	add    %ah,-0x70(%rsi)
   7:	64 48 8b 04 25 10 00 	mov    %fs:0x10,%rax
   e:	00 00 
  10:	45 31 c0             	xor    %r8d,%r8d
  13:	31 d2                	xor    %edx,%edx
  15:	31 f6                	xor    %esi,%esi
  17:	bf 11 00 20 01       	mov    $0x1200011,%edi
  1c:	4c 8d 90 d0 02 00 00 	lea    0x2d0(%rax),%r10
  23:	b8 38 00 00 00       	mov    $0x38,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 35                	ja     0x67
  32:	89 c2                	mov    %eax,%edx
  34:	85 c0                	test   %eax,%eax
  36:	75 2c                	jne    0x64
  38:	64                   	fs
  39:	48                   	rex.W
  3a:	8b                   	.byte 0x8b
  3b:	04 25                	add    $0x25,%al
  3d:	10 00                	adc    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 35                	ja     0x3d
   8:	89 c2                	mov    %eax,%edx
   a:	85 c0                	test   %eax,%eax
   c:	75 2c                	jne    0x3a
   e:	64                   	fs
   f:	48                   	rex.W
  10:	8b                   	.byte 0x8b
  11:	04 25                	add    $0x25,%al
  13:	10 00                	adc    %al,(%rax)
	...
[  185.568066][ T4639] RSP: 002b:00007ffc6abbefd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  185.568335][ T4639] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f685e546293
[  185.568593][ T4639] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  185.568865][ T4639] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000064
[  185.569126][ T4639] R10: 00007f685e46fa10 R11: 0000000000000246 R12: 0000000000000001
[  185.569403][ T4639] R13: 0000555c55664069 R14: 0000555c55675cb8 R15: 0000000000000000
[  185.569668][ T4639]  </TASK>
[  185.569823][ T4639] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240412/202404121034.21a3864a-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


