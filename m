Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20DB80EDF7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376296AbjLLNrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346652AbjLLNrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:47:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CB683;
        Tue, 12 Dec 2023 05:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702388867; x=1733924867;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7lBhzlIkqNxEAY+mqds2ea52owKJvtFLkD+lodMjl2U=;
  b=cNeqVql7/chk4LwusRk/s+GgG1VSHvuaN++r3l9x4E04K6flTYamJ51M
   GNWiWHf5iN9oC+x8Ot2QwVu5Vp1xYTBuj+Umo8I3XqUH77Lx9CExOIOi+
   xAq0cAQU18xMR3Ap3ltwSMFw6gU4khE6b+vRWgNYOqq8aZ8wi+ssWx6j6
   ym44m+M8Gdt1qsldmmM4R8cicarI1C2w5WiH9C7eNkno6YG9n47z+Vs58
   LWvd6dEFU55hTlJyqsqaG6VmRIVspebZGHr3Z5tHrh+vqDZEg9mqYGIUn
   Wq6uBKRCzEssPwiBcmhrnrlvAVpBI2K+ofKT5fm8pxrNPeHU2yoTaXkxP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="385217408"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="385217408"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 05:47:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="766824699"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="766824699"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 05:47:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 05:47:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 05:47:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 05:47:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 05:47:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juwcM77AzzvPb0xwGIqIPqRC+wYBYdTlrFzDiQFJwEJEMkt9gy1hoWNxixuKEjFqTmfFlu6VYqxAAs+QlW7fVSlTzHQLjy6dQbfdtTUhqQr/fDFVhhNfaD7sdPbtII2f7nSU5LoP65yt6DJInvHSFi4dwH7UQDdnEGjYB/ZJz/q6yPDVHLe8OEbwntSFM2OFEVRFRzabgWyS5aQdW0BGJm+HYVa2wTbZBnH4EP+LScBq+KdDqCteKE5lAyMNiAZ8hQXXltJI7FU6HXgJaB9xNCda4CW1HFj8vPCDmpKZl0bjumRtSYn9lYJxZOqo+UL1BOztgawr5B9rNrOprNnssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUEvZKi+Q4twHnntpJ+jGtMzmG8NN6wrrDqrBr79oO4=;
 b=ZjfYhitIy7cHa1OGXnc1Tb2BiZ6kzU+v7Bl9RScJdkSZDorTMOni+hLI3hfet2JSMRzSCM+yTVFKA68O0G89f+7aUheTejGG4O0JZJpGPPqLa/VcYlINLErPM1XGnNSHPEGCDHSvwYb3RvtEedO0AzRm/CC1LrD2zK/6Ac7lsJy7A/3Fmw53nwLiQEI4TRVahH2/KQ2wBsu6bn2UFzvMoI+n/LILZx0sC780lgV+qNJBhxSSbBc37b3lklTB1ABCx7mJpcDUJYQMwmlykHCvwvLmzSHzHCBMv8ZiC6oE2HLmFxCwW3MCepUzKLbEE6dZaGAMKFnGvApw1W3qf4RfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6759.namprd11.prod.outlook.com (2603:10b6:806:25e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 13:47:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 13:47:44 +0000
Date:   Tue, 12 Dec 2023 21:47:36 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        <linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [ring]  f458a14534:
 WARNING:at_kernel/trace/ring_buffer_benchmark.c:#ring_buffer_consumer
Message-ID: <202312121655.f8f36552-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 524c2ffc-c8b9-465e-4ce3-08dbfb18eac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Ec2hWfwfHzdYQ2K0DviyIzB5s0d5YBWlwI6vyN5QUnIuGkwmgGYWHLVj12nptZ+xnbvQHf/J/sPxEZtDB2iq1ZFYxAllb42tTuLjknFyriXbKwhsjZl3i0glZ/Lh6MlJnYZsCH42GNqI7wu4HXi8ku4IJLzJk3nv/A1JMljAVyxxKT3DwBPWsSSi6njaDpyl4Bm/qjqhpi4wcXKa/gAVE8DhSdIUDbx8LGh1FAGxJLxltUdN7VdcfaBi1McxtffPlnaXJ7eLA2P5QyKlmv1TK2/16eweRJR5Bo06+gK+mLxigoUe7IaMkw7ikbM2tm3VHwTQucpvD0PGW3TO3Z5NKOvDcDpP2379ZEF524VPvoXGl1xnL8OVigCDnj0l4ziAGiBtL7cVsK5IaiWwtbi1AqepgwG48zCmaIbt8cfY/1m8XlLdCQoexnjfol5fgjfI1Qw6FPbbKX9UUulTJwveaczVLiqiH0OI6mPrAWtIipTzI//qWVc09bDrksSIjzxo6aFhJuYwsAcO2q+cBC718qWUnxnIR5MWTpN65FpupFQgCaUHXiCQ3HNrYATx0TSdubhZw410x6BLttMaFVau46fzY6SDapTHv2y0LQkgFdJF5eaqfoKUcQ2zClBHEf74v4klqOJQMX37YjI9txLVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(8676002)(5660300002)(4326008)(8936002)(41300700001)(2906002)(966005)(6486002)(478600001)(26005)(38100700002)(316002)(45080400002)(6666004)(66946007)(6916009)(54906003)(66476007)(66556008)(36756003)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ORVFttKHP+KWBWDtLzKwSxsh7gmL/MnVSot6KgSeDu3KQmJNVx1+ZUATj6Bj?=
 =?us-ascii?Q?LPv/U9VEqiyNfNZVev8n++ZpCKs1z7l5uWpF/4l5gHzp5c8Re6V17mUQ2G2q?=
 =?us-ascii?Q?j+xBlSj5f24fncfwpYoW8qMNe04WJqW/IsFXYV14r9frJxxQXJdoKNdq2CQv?=
 =?us-ascii?Q?hAwS2+lhlbijLb9nlMniNnzIm5LreltQqVmWb70xnaG8md6thuf4E5/+kFVc?=
 =?us-ascii?Q?TexZCacoR/tI1WI18d2rPdtbCRBcs2CdeMHVRbxqf/B8ZfTyDhe5lGQeL+rh?=
 =?us-ascii?Q?AbdBmoKlyPfZzR5zmqCy9blslp6T6hxxzvT+5jVy37fz0xgiJDO6ZNXsLXQn?=
 =?us-ascii?Q?C9bV1O7ChCbfaouxXFviawlvLyrc2JckDqQYJj6DL4KQ4bH8MJHHWethS3RI?=
 =?us-ascii?Q?7G/7hyrDLj8EFcGh2ezMcvIY4uWD6J8tFPDvKwNOrUY9F24sczV6d/gZHULu?=
 =?us-ascii?Q?KDpVYwljzHrqLGbQcAUMKKg9zh5Sa/vgNL/FuwAqbuvMtDJxmyO4/8tN/iNw?=
 =?us-ascii?Q?LW8BtJdsaZGzmqCQTXgVO6QfQ1fPWhGByW3XAvkEWWcPW1YHYOitFORwIjyb?=
 =?us-ascii?Q?3+xl8OjzTvQbuE4WcdMkvzHk0qAPVtQyKPNBkw2ScmlKxbKE+wmeC4XIdoM6?=
 =?us-ascii?Q?ecEA88bw+rog93OZ12Jv5x/N3jviqFLprvRD8OY1lzhF/fxVtcKLbPJtgtVU?=
 =?us-ascii?Q?dvDTJ3/d2eVu7hzBJHBupw65OW7RQtN+w81F7GnkwOoy9E3eTqMQy+mHyUsc?=
 =?us-ascii?Q?Fp3oryL0KLgy95R0dVANRBjhJWnbJjYRWM1UbSUJqcBT6sOGKb2IaQYawkKr?=
 =?us-ascii?Q?fvbgWVoWvxaU1dT9IcEYJPF9gG9ayEU50XhbAPNedlqwk5Azc5ZD5b1Vxlhd?=
 =?us-ascii?Q?DKABB/Gyo0Mj6OCDDxJ5e05+im3k1nWJpq0xHBPHyf4q6bhcoQ3uH6ogW4F7?=
 =?us-ascii?Q?vRkYe1bstrLMVExfSNV1Q4ko3/c3DsWbkjzUE2K8zoOwlBYFfjN/F6v3QKfl?=
 =?us-ascii?Q?pttAIft30L+fCW/r3jk543JOW0Rf3FRWL8RXwTuRo6evjn7pvatzj7DNctTE?=
 =?us-ascii?Q?xeoP8tXE0StB7P7abNgN1smBQl5/6kAJime6rYOC8l4SEOeMlpADMN4gHJtt?=
 =?us-ascii?Q?Mzc0o+sN8p4syiCaL6MKdL55VzUeGtoMjwan/RXm68ZKoRl+GgO/x+q7WvHg?=
 =?us-ascii?Q?Q4G8aOdaqKY5fj6MogAUwY5QJ4dJV/iBEFykGzR2tGUQPk+WiOCWBt06FIql?=
 =?us-ascii?Q?9PbzkaQGuiv63wpDb7zUofXnfknD6EmN0nW5XJLKwoLSqMved54eazGgSFjO?=
 =?us-ascii?Q?LM3wnc+FG/+mP/uAV7q2/LnzOQu1l7+fsVhIufHihmxrLZr1kmx/aLAGS2Ak?=
 =?us-ascii?Q?ZXAkxZ0Grn4jR3tReAAZ7Pnu1J/sJ24GwdDnIt5DPctkOFs3nQ9XTPPs3J2O?=
 =?us-ascii?Q?GZ+WJPYc73DGrUhN5RVej9UJCfDudWL9DJSH1dY0BtJPijXTdljnXTpniLXR?=
 =?us-ascii?Q?MmdM0RmvA6IHpIRPc1elr7Nf+L/ZD3yD3bdrcjk1DZFTzqDh7OXGaN//7OFg?=
 =?us-ascii?Q?6Bvr/hxqXuCDozPUSfhyODC35vWr5BB8dcxpir0kpuVbBR/iXF2VZQbFCfsk?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 524c2ffc-c8b9-465e-4ce3-08dbfb18eac4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 13:47:44.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TkocVlIBPrwcL1Qz05Isj87z/tmu54I+E1SnOa6wjK7LZNspnNUuxawoLI4CmfbdoSMBSWUX7fCHUzJROxJWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6759
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_kernel/trace/ring_buffer_benchmark.c:#ring_buffer_consumer" on:

commit: f458a1453424e03462b5bb539673c9a3cddda480 ("ring-buffer: Test last update in 32bit version of __rb_time_read()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 26aff849438cebcd05f1a647390c4aa700d5c0f1]
[test failed on linux-next/master abb240f7a2bd14567ab53e602db562bb683391e6]

in testcase: locktorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug



compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------------+------------+------------+
|                                                                       | b2dd797543 | f458a14534 |
+-----------------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/trace/ring_buffer_benchmark.c:#ring_buffer_consumer | 0          | 14         |
| EIP:ring_buffer_consumer                                              | 0          | 14         |
+-----------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312121655.f8f36552-oliver.sang@intel.com


[   38.075826][   T45] ------------[ cut here ]------------
[ 38.077859][ T45] WARNING: CPU: 1 PID: 45 at kernel/trace/ring_buffer_benchmark.c:147 ring_buffer_consumer (kernel/trace/ring_buffer_benchmark.c:147) 
[   38.080140][   T45] Modules linked in:
[   38.080906][   T45] CPU: 1 PID: 45 Comm: rb_consumer Not tainted 6.7.0-rc2-00015-gf458a1453424 #9
[   38.082662][   T45] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 38.084759][ T45] EIP: ring_buffer_consumer (kernel/trace/ring_buffer_benchmark.c:147) 
[ 38.085829][ T45] Code: 00 83 e0 1f 8d 04 85 04 00 00 00 80 3d e4 48 ac c2 00 0f 84 00 ff ff ff eb 7c 80 3d e4 48 ac c2 00 75 73 c6 05 e4 48 ac c2 01 <0f> 0b e9 d5 fe ff ff 80 3d e4 48 ac c2 00 75 5c c6 05 e4 48 ac c2
All code
========
   0:	00 83 e0 1f 8d 04    	add    %al,0x48d1fe0(%rbx)
   6:	85 04 00             	test   %eax,(%rax,%rax,1)
   9:	00 00                	add    %al,(%rax)
   b:	80 3d e4 48 ac c2 00 	cmpb   $0x0,-0x3d53b71c(%rip)        # 0xffffffffc2ac48f6
  12:	0f 84 00 ff ff ff    	je     0xffffffffffffff18
  18:	eb 7c                	jmp    0x96
  1a:	80 3d e4 48 ac c2 00 	cmpb   $0x0,-0x3d53b71c(%rip)        # 0xffffffffc2ac4905
  21:	75 73                	jne    0x96
  23:	c6 05 e4 48 ac c2 01 	movb   $0x1,-0x3d53b71c(%rip)        # 0xffffffffc2ac490e
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 d5 fe ff ff       	jmp    0xffffffffffffff06
  31:	80 3d e4 48 ac c2 00 	cmpb   $0x0,-0x3d53b71c(%rip)        # 0xffffffffc2ac491c
  38:	75 5c                	jne    0x96
  3a:	c6                   	.byte 0xc6
  3b:	05 e4 48 ac c2       	add    $0xc2ac48e4,%eax

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 d5 fe ff ff       	jmp    0xfffffffffffffedc
   7:	80 3d e4 48 ac c2 00 	cmpb   $0x0,-0x3d53b71c(%rip)        # 0xffffffffc2ac48f2
   e:	75 5c                	jne    0x6c
  10:	c6                   	.byte 0xc6
  11:	05 e4 48 ac c2       	add    $0xc2ac48e4,%eax
[   38.089748][   T45] EAX: c4f1b094 EBX: 00000000 ECX: c4f1b08c EDX: 00000001
[   38.091153][   T45] ESI: 00000080 EDI: 00000000 EBP: c0c03f60 ESP: c0c03f28
[   38.092549][   T45] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
[   38.093938][   T45] CR0: 80050033 CR2: 00000000 CR3: 023d0000 CR4: 00040690
[   38.095291][   T45] Call Trace:
[ 38.095913][ T45] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
[ 38.096866][ T45] ? ring_buffer_consumer (kernel/trace/ring_buffer_benchmark.c:147) 
[ 38.097962][ T45] ? __warn (kernel/panic.c:236 kernel/panic.c:677) 
[ 38.098783][ T45] ? ring_buffer_consumer (kernel/trace/ring_buffer_benchmark.c:147) 
[ 38.099849][ T45] ? ring_buffer_consumer (kernel/trace/ring_buffer_benchmark.c:147) 
[ 38.100987][ T45] ? report_bug (lib/bug.c:199) 
[ 38.101835][ T45] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 38.102705][ T45] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 38.103537][ T45] ? exc_invalid_op (arch/x86/kernel/traps.c:258) 
[ 38.104583][ T45] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 38.105519][ T45] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 38.106381][ T45] ? ring_buffer_consumer (kernel/trace/ring_buffer_benchmark.c:147) 
[ 38.107426][ T45] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 38.108429][ T45] ? ring_buffer_consumer (kernel/trace/ring_buffer_benchmark.c:147) 
[ 38.109508][ T45] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63) 
[ 38.110505][ T45] ? complete (kernel/sched/completion.c:48) 
[ 38.111212][ T45] ring_buffer_consumer_thread (arch/x86/include/asm/current.h:41 kernel/trace/ring_buffer_benchmark.c:388) 
[ 38.112335][ T45] kthread (kernel/kthread.c:390) 
[ 38.113096][ T45] ? rb_check_timestamp (kernel/trace/ring_buffer_benchmark.c:382) 
[ 38.114061][ T45] ? kthread_unuse_mm (kernel/kthread.c:341) 
[ 38.114962][ T45] ? kthread_unuse_mm (kernel/kthread.c:341) 
[ 38.115897][ T45] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 38.116892][ T45] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 38.117827][ T45] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[   38.118756][   T45] irq event stamp: 45237315
[ 38.119660][ T45] hardirqs last enabled at (45237323): console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 38.121456][ T45] hardirqs last disabled at (45237572): console_unlock (kernel/printk/printk.c:339) 
[ 38.123207][ T45] softirqs last enabled at (45237570): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[ 38.125116][ T45] softirqs last disabled at (45237589): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[   38.126991][   T45] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231212/202312121655.f8f36552-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

