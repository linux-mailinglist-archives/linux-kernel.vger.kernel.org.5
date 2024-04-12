Return-Path: <linux-kernel+bounces-141854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA58A2444
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6E81C2176B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4256015491;
	Fri, 12 Apr 2024 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqw/hKz7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678FA168A8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891946; cv=fail; b=naiGlezKSmq7ie8Jrq9+M68BDvVfPMS2kHC5ZSyb57xxuHHqNPTFAoHYXJ3ZZEhBV4b67OL5AwWoEmVHXjrsgn9GaLETiBs94irvSLUQPUglRmVcSX0gr4auO9EVG6t3E85waoHxK6jkM1VpWAcpLGpoOsDT6ZhZLwTdR4dqAiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891946; c=relaxed/simple;
	bh=epytCaOydIhBetAGarq1rf/elrKMNnHihmlS1nkmSng=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=EWKDvbi+UMMLuBA1KauZGZ48A7iWJSbyZtq8LhCeh4lyuXnlhM50gL1HW6tH1jJK4YCEtYEANCJyrZu1/aa+NzClgNPABEDdPou+dCITZegIBl4F6NIwX5XunamUe+oAtR0xQLXgZJmGEHHqBvxDqXntsXrbgA47MfPhJPOgoCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqw/hKz7; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712891944; x=1744427944;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=epytCaOydIhBetAGarq1rf/elrKMNnHihmlS1nkmSng=;
  b=cqw/hKz7+92bBLIQ3aVcnNJ764DN2ycL5jtxOJ90YMRWiT5B/aCmnVTE
   4FrQ2Bpwrkdmjx/3voZmsvrH7zM3ztVCHajEF5na+hVBaxe4IzD0/a9oB
   f1KB70Mgq7Tb7kN2G17ZRC4dUVI3ttELiC+s9FbyJTRB70u0laZovJS+m
   t/9rCvLGo4Wx7Gn9ZFbidvF0Z0VTsk6Fo1ODuFgq6Rt5JtNaXyjA0RhE2
   SU4r1nn5F+ZU4540QNB0LPXUS+TNVCmUVqE0Y9MCC1QYyPpHRJ3YXQGaG
   j4x7E8Xb8WZYUNmKgl1ZPf+nVD6gQa4AL8V8oAKO4vHVATKJsEbkj6o6n
   g==;
X-CSE-ConnectionGUID: 6kfprEznRHWaMINjUlyLog==
X-CSE-MsgGUID: 3pJThhSiT222zVlajhAT7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19728766"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="19728766"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 20:18:53 -0700
X-CSE-ConnectionGUID: Ve1X03WqTXyb2TaMJO3k1Q==
X-CSE-MsgGUID: 0TFKD74ZT56gTet+Mt/SBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="44384852"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 20:18:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 20:18:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 20:18:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 20:18:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 20:18:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCN8b8UPkvt/dhxvJhm2xv5sOpTrKndrPVh70trTbftKxl9MlAVIlpMp/sapJ8zo/KmazthulFITz5GmFywc3O4bN+gvIk2i5ZmaRFVxmlehPVgbet37tZlLkzLbE5WZ9pVECKPhzIUaU3+OJxgXGqbLJvwjJM8kOON8mn/6blXd9oBGphI+HZ/XdLISYBnF6myo20R6bpYunMPxQhA+8zMrmp3d/sy08OwYYUydq0G7JXG7x/7Z0cwU2nHyDq+c4OGeDudgs2T8BSb7kOXcEvS+MoMZsfqvlJtr6Ftzx7TKEJfq+XkGBLZ9ES6fjt/PEhpR9isX6j9Htdk0NUBmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8vVSbJDdCg+dEgIcR3r3BF6yGHa53GlWpQG+Be47oo=;
 b=K6catzZCu4amFiS3myjk681Teu2ne4WcVhZNSZeHtMeoq5eI1uKQTP8DHb8XAyC3vwH3ofIa5JY0BA3hhCcfrul4zRErosJjoyMBVfjksu01yBKhq8sLOBPPfc3ThI3Ga/JHg2emR2LX5D5Sff+OReRBf9PNOU2iTwXKGyknqyHj+o+LNkMBvvhvrxTfIvh+lM8YutpviJyK9MBa903Ff+QRtSOcmm0vtsYoRTq11NC7lzJaay9/ym/80RCzYflqau6kh6BMt4tQXu94VyIUVCJ7VZb5beFLLbw0xacNgRB2gI8rZt7TZhKcQW7q4y0P5apedmfcMiQSpLdKWfCg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 12 Apr
 2024 03:18:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7472.025; Fri, 12 Apr 2024
 03:18:50 +0000
Date: Fri, 12 Apr 2024 11:18:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Barry Song <v-songbaohua@oppo.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Yujie Liu
	<yujie.liu@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [mm]  cf5dec6389:
 WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault
Message-ID: <202404121129.c53d5406-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL1PR11MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa95446-d9dd-4ce6-7c97-08dc5a9f45cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCTLEMKPL6QaJIh4N+BGmdlXCQAhnEiuVlaXXDEKJh77NiEgYcPawje31oyDW6vTFdAtktzGo9sQcefTxu3PP/Lfj7niKK8uXfoUmUpMCM4yXzDMm+AWBrSGHVcwZWLfOyShCF33Q66gDdivt7btyh8t9R0RE3CfpXP4XDSGATEzvS+erQZCCrLy7X3O0mWSUt1chNLHMSHB/tuZKFpEf1EdfnCjOVffRUlWGYpwtA6iBR+UFmWnnCWCBpE4cN8Q8tbPbiB9ARbNHuDLdRgg+aOdiD4u4fulFuaw3e5aOo+LhDCw5sGLZ0lEWIPyIOKkyy2S+F7ZzJ3dSWLX5luNO6pCs1on4cESeiPsKZ+sKwIgRylqn5gGcFSdZoJp2U0goPufNUdBGLAlHBF8v6GMEz3COeDbrjW0RXWqNwqtNn5i/kZxVzD5KYWEuEqzhpE8yJITW9qe1KCT9Us9Y493DipeS7ka/oWsbF9DlcZEWH+43ryDr8EVjFniAijGLrEK0acP8np81NUm1LypjL59NueyllbgkQBzuulSHgn2kUp+M4RzgzhZXP0PUV63GyOYTyTwiXZH0n/9WZbUTW58/JZXXV+zureQSfY0VvzmvNZ9G7QCf6ps/DQYRhhXwmnG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wJIhn/iVi8MLrKNI5cg8Nbo0ufZ+ToUIAkP/lFq7agYwQ3wjqsmXn1nOj2I/?=
 =?us-ascii?Q?yQplSrIgGsO2m8Cfe42WPaj+G91aC1w7V1UkHM48jyFFat3VtfG0A0I3CeBY?=
 =?us-ascii?Q?dTva6Dp87cNB6mxacC8oaI48ZMFu3usQo9W4AwPV7fSnZArxrd8LfgnlfAPT?=
 =?us-ascii?Q?r/eS73KhBghv2Bcp1zUJ9MhBV8aXr1ZJKHrmyNbT/oocfS0QTiGWCGA618Fd?=
 =?us-ascii?Q?lTbt12+swJlLyKj3R7mjAg221FEn8J72XKSrAUXixGJ4CeRlPiWD0t8YajRQ?=
 =?us-ascii?Q?4ihjkKkX10Bw90uXUfHvz7d4/kKBNBfXyQPZkOFbLmYx4lAse1dbb7LCPkuI?=
 =?us-ascii?Q?og3K4Yh1l3LhCPljSA9vg0HKd7NQj2Rd5EMaxp6NryyMPgdGHdYBo/a2Kqax?=
 =?us-ascii?Q?vGBC2PzqM87HZ/oMBI4UeL3KK0O91CdYDiSJsUYQ0KUJ61s29zwJ+PeuvE95?=
 =?us-ascii?Q?w3206lU0QGkW2SlbNKHAcfY7uGq89CJtvsHSV1NiNhfWtOnxV4Jaa36CcohZ?=
 =?us-ascii?Q?lT5eq2FJmZxB+gnRT8vpYNjvIYBFwqEK8nk/Mgh+kkLwmnbfrxiomjARhr1i?=
 =?us-ascii?Q?sFKCsEGsEivV+EO5MvrYTeDyehyJb00Ldm87It9VY8FEGO3dn9H6qdd0fEUW?=
 =?us-ascii?Q?blWq6NHx/2IPAk7nKz/akrtA6SYQTZtBjqCZ1HEt3AxaNm+DjiaxVyELff2F?=
 =?us-ascii?Q?/V7O/QnwVBpxqRm5EkSruheUlZDTO5A7PTojnrLzrktbl24xAKVF506cOtYq?=
 =?us-ascii?Q?/rcgiZJAUx+ZMAPIp+0vRmXVOmyzPJ+sWVadxMCRjviN3jHnnzGVb3vMrYDm?=
 =?us-ascii?Q?EmmV8Nc+ZZxI6SWqhDw3RwiddOLL2MXauypiRX9pWxQebGtLJNDCzTRWGgpl?=
 =?us-ascii?Q?maLF+ub+HvmkKt6f5GPkNzwsVGhiyYRlHdYxgP1sXscE7puNJJPjqtjrFF+J?=
 =?us-ascii?Q?9KelJ1PgAfdAM4C7+e1DEkyvb8uSnUkW/YR8CnpkdhBIqIvTAbbaH/NjxQ7A?=
 =?us-ascii?Q?IXyTQtrnS6Lwc9JGVnnJR0PW+nwXmWqy4nfYmCcrvIkq6RNySA8RO0+LMTTf?=
 =?us-ascii?Q?2ndqhrpqtLcK/zW8STjgikHkYaEcqyrYfDVZK9l8tSYLr3pvQ4ghzBdY1vlD?=
 =?us-ascii?Q?Ay6RoaITsgkon2ZzvpoukJKUFD023sDZGnkBsdYGyPXh9qCyjoY/AHZxpLk6?=
 =?us-ascii?Q?/c2D4cZIevMSjVfHlxAIzj21qRsljRpXbnT9QjZtHTeeFMRR29QmmYpPqGjp?=
 =?us-ascii?Q?kgQs2ojS6tZJxYNvWMXihMB4s9GMkgbklU5RIyXaUruG/osCgDRlLS9/EDN9?=
 =?us-ascii?Q?rR8hd6dBO5ZHIoVl6vUPOow+XpdEsJFmebZPEhdqHiO8UjxuG06DInW0xQba?=
 =?us-ascii?Q?hpo/N5xzQoxhbgIDik/RVoM0JzYBAWS+6Kb0l2atp76HsmvbYk2iMic80gct?=
 =?us-ascii?Q?JVv9Yq0p+CsLaaSkNvTtwIIg31m4gkZ8ypZbMP2xdHVjN0lcnWyt+OB+sIb4?=
 =?us-ascii?Q?Z9wt2Aut/tauiMAmRn4x+5PSvNh8+ZX6UO6uKg6h3Jzfpc+v1wvob1wzCaYC?=
 =?us-ascii?Q?QE+B0Bnt4GqAEBaScGHOp4I8/HWsfkfbxz3aQTOBFckqxyEk8OJ7WSKfA4d4?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa95446-d9dd-4ce6-7c97-08dc5a9f45cb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 03:18:50.0101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAqiw6DfIXwWH1u2L1AWEhgPjEG+l87kDTp5LDAGkhNatblELdhbqdmpMACieabNDh6aX9773zimxF7njQOGoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault" on:

commit: cf5dec6389f307a43c6c494660e28f16c7e0265a ("mm: fix powerpc build issue")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master a053fd3ca5d1b927a8655f239c84b0d790218fda]

in testcase: boot

compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------+------------+------------+
|                                                    | d9130022ad | cf5dec6389 |
+----------------------------------------------------+------------+------------+
| WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault | 0          | 6          |
| EIP:do_user_addr_fault                             | 0          | 6          |
| EIP:string                                         | 0          | 6          |
| BUG:unable_to_handle_page_fault_for_address        | 0          | 6          |
| Oops:#[##]                                         | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception           | 0          | 6          |
+----------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404121129.c53d5406-oliver.sang@intel.com


[  122.507941][  T251] ------------[ cut here ]------------
[  122.508786][  T251] ------------[ cut here ]------------
[ 122.509528][ T251] WARNING: CPU: 1 PID: 251 at arch/x86/mm/fault.c:1308 do_user_addr_fault (arch/x86/mm/fault.c:1308) 
[  122.510801][  T251] Modules linked in: crc32_pclmul aesni_intel crypto_simd evdev drm drm_panel_orientation_quirks firmware_class zstd_decompress zstd_common autofs4
[  122.512743][  T251] CPU: 1 PID: 251 Comm: dpkg-deb Tainted: G        W        N 6.9.0-rc2-00330-gcf5dec6389f3 #1
[  122.514132][  T251] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 122.515462][ T251] EIP: do_user_addr_fault (arch/x86/mm/fault.c:1308) 
[ 122.516186][ T251] Code: 03 00 00 83 c4 04 e9 ba fd ff ff 0f 0b e9 b3 fd ff ff 89 f9 89 da 56 e8 ff 06 00 00 8b 55 e8 8b 4d e4 83 c4 04 e9 c8 fc ff ff <0f> 0b 89 f9 89 da 56 e8 b5 00 00 00 83 c4 04 e9 87 fd ff ff 8b 45
All code
========
   0:	03 00                	add    (%rax),%eax
   2:	00 83 c4 04 e9 ba    	add    %al,-0x4516fb3c(%rbx)
   8:	fd                   	std
   9:	ff                   	(bad)
   a:	ff 0f                	decl   (%rdi)
   c:	0b e9                	or     %ecx,%ebp
   e:	b3 fd                	mov    $0xfd,%bl
  10:	ff                   	(bad)
  11:	ff 89 f9 89 da 56    	decl   0x56da89f9(%rcx)
  17:	e8 ff 06 00 00       	call   0x71b
  1c:	8b 55 e8             	mov    -0x18(%rbp),%edx
  1f:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
  22:	83 c4 04             	add    $0x4,%esp
  25:	e9 c8 fc ff ff       	jmp    0xfffffffffffffcf2
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	89 f9                	mov    %edi,%ecx
  2e:	89 da                	mov    %ebx,%edx
  30:	56                   	push   %rsi
  31:	e8 b5 00 00 00       	call   0xeb
  36:	83 c4 04             	add    $0x4,%esp
  39:	e9 87 fd ff ff       	jmp    0xfffffffffffffdc5
  3e:	8b                   	.byte 0x8b
  3f:	45                   	rex.RB

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	89 f9                	mov    %edi,%ecx
   4:	89 da                	mov    %ebx,%edx
   6:	56                   	push   %rsi
   7:	e8 b5 00 00 00       	call   0xc1
   c:	83 c4 04             	add    $0x4,%esp
   f:	e9 87 fd ff ff       	jmp    0xfffffffffffffd9b
  14:	8b                   	.byte 0x8b
  15:	45                   	rex.RB
[  122.518827][  T251] EAX: 80000000 EBX: 00000000 ECX: ecd11e00 EDX: eceaf3c0
[  122.519822][  T251] ESI: 80000040 EDI: ecf11cdc EBP: ecf11cb8 ESP: ecf11c8c
[  122.520643][  T251] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010046
[  122.521539][  T251] CR0: 80050033 CR2: 80000040 CR3: 2cc98000 CR4: 00040690
[  122.522448][  T251] Call Trace:
[ 122.522885][ T251] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
[ 122.523435][ T251] ? __warn (kernel/panic.c:240 kernel/panic.c:694) 
[ 122.523958][ T251] ? do_user_addr_fault (arch/x86/mm/fault.c:1308) 
[ 122.524553][ T251] ? report_bug (lib/bug.c:199) 
[ 122.525103][ T251] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 122.525624][ T251] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 122.526180][ T251] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
[ 122.526753][ T251] ? handle_exception (arch/x86/entry/entry_32.S:1054) 
[ 122.527347][ T251] ? xas_create_range (lib/xarray.c:729) 
[ 122.527986][ T251] ? xas_create_range (lib/xarray.c:729) 
[ 122.528578][ T251] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 122.529134][ T251] ? do_user_addr_fault (arch/x86/mm/fault.c:1308) 
[ 122.529801][ T251] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 122.530345][ T251] ? do_user_addr_fault (arch/x86/mm/fault.c:1308) 
[ 122.530992][ T251] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 122.531680][ T251] exc_page_fault (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1519 arch/x86/mm/fault.c:1569) 
[ 122.532252][ T251] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1524) 
[ 122.533061][ T251] handle_exception (arch/x86/entry/entry_32.S:1054) 
[ 122.533679][ T251] EIP: string (lib/vsprintf.c:646) 
[ 122.534266][ T251] Code: 54 24 04 85 f6 75 4b 31 f6 eb 79 89 04 24 89 54 24 04 c1 fa 10 74 78 31 ff eb 0c 90 90 90 90 90 90 90 47 39 fa 74 6e 8d 34 39 <0f> b6 04 3b 84 c0 74 69 3b 74 24 08 73 ea 88 06 eb e6 89 c6 0f b7
All code
========
   0:	54                   	push   %rsp
   1:	24 04                	and    $0x4,%al
   3:	85 f6                	test   %esi,%esi
   5:	75 4b                	jne    0x52
   7:	31 f6                	xor    %esi,%esi
   9:	eb 79                	jmp    0x84
   b:	89 04 24             	mov    %eax,(%rsp)
   e:	89 54 24 04          	mov    %edx,0x4(%rsp)
  12:	c1 fa 10             	sar    $0x10,%edx
  15:	74 78                	je     0x8f
  17:	31 ff                	xor    %edi,%edi
  19:	eb 0c                	jmp    0x27
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	47 39 fa             	rex.RXB cmp %r15d,%r10d
  25:	74 6e                	je     0x95
  27:	8d 34 39             	lea    (%rcx,%rdi,1),%esi
  2a:*	0f b6 04 3b          	movzbl (%rbx,%rdi,1),%eax		<-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 69                	je     0x9b
  32:	3b 74 24 08          	cmp    0x8(%rsp),%esi
  36:	73 ea                	jae    0x22
  38:	88 06                	mov    %al,(%rsi)
  3a:	eb e6                	jmp    0x22
  3c:	89 c6                	mov    %eax,%esi
  3e:	0f                   	.byte 0xf
  3f:	b7                   	.byte 0xb7

Code starting with the faulting instruction
===========================================
   0:	0f b6 04 3b          	movzbl (%rbx,%rdi,1),%eax
   4:	84 c0                	test   %al,%al
   6:	74 69                	je     0x71
   8:	3b 74 24 08          	cmp    0x8(%rsp),%esi
   c:	73 ea                	jae    0xfffffffffffffff8
   e:	88 06                	mov    %al,(%rsi)
  10:	eb e6                	jmp    0xfffffffffffffff8
  12:	89 c6                	mov    %eax,%esi
  14:	0f                   	.byte 0xf
  15:	b7                   	.byte 0xb7


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240412/202404121129.c53d5406-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


