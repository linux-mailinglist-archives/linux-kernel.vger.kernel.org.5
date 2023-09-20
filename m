Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112FE7A7327
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjITGv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjITGvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:51:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF801AD;
        Tue, 19 Sep 2023 23:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695192707; x=1726728707;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nRQoidmQ6oXqOzrl4Un0VpMUtF0g4YsyQA8qDNJiT5I=;
  b=hO6Czr4JiLewUil7LmqtBfKbQ/nNpUz8s/+BD7AolGYqJGkfBSu/WHFZ
   9SXVhkSr6MysmWZgrkB7oakqtev8ZMUI7ocflDdPXaIqz6cQCLgp7OcsK
   xEWpHHWYd8yUGjGv5K1Is4h1rlCzRnPxJcC+bsugoOjxB3KE/5w4te/RN
   2kQr8pm1qnw8L1lu7Lkc7pEI0OHjcIpfCxaCsVktOrIdkDop3fonuX+Fr
   CM5i6b78o+g7+tUhzxNQqBuYQcMU0YG4719yp+g98efFT5fq6i+fEQSeQ
   9W03iazhgq8GhnK84SSlfY88xwibj7kbZnuz/0bzoc/zpMVNgaEON1Csl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="383986559"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="383986559"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:51:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="993473783"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="993473783"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 23:51:47 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 23:51:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 23:51:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 23:51:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DP26ZvDQU44XfxR0w6juFKVSmdugzaumJ5+yaAh5+Bk2y18dhGt7kGn0i1Q2vuxGdy0F8H8/dfTa6mu3hjhnceav2UBQ5rdYwAAjBTyKJxqIEC7BaPZZQk26/xSpuNNjVTf1p6WgKWflkezRwj4fPdt0eqSwF1ueYV61nr2iVP/OFYcuRBuzs5sdsp2LCK56WMdz0DiB8Jtspz7Mh+lhPoO3i7cdGxzBxK6coX56ejf+IcYKk3/pIxw6VBjxbyORc/rAzAfRENP0DiW1mMFJIAAhx6t2BFtu9Wvx50iK5XDx7WfZC6UEfUsLy4B6YrWzY3TdaPgfEXRurjheVQfErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxLTkmaHzMlS605Cjtpb5pBePat4k6vO9eWi3V/+xyY=;
 b=oepyoOegMN3E7CO+qOo0G4yUgP4MEWhVqgJF15JDIs5bLwD5ZgHUU5yWJUIKTl4hszZlucSOeGZIuK65vbl3UR7j3VwkPe/TOzpTpHXljE4NRyY4OsXdDopZ5LBo6+cLkFe09zYXpsS+RD8n8Yyy+4PtplBat7qtCTyljngxNRhaGJf/jKg6oP9NkDkMGxnp9ViH4IywHg1O1HIfCiFti4R9ZET5DIIEm/ULQ9tFiMFPKuLYPT6ghuxzBEqh0mD3jmviqjlJXH8vz9XGt/WnNuTPsOfQ1PCWSt1aguqH3RAsOqm1UU/IsbrVdWk0AL14YkB3YgBSlFabVZGj4hjsGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB6524.namprd11.prod.outlook.com (2603:10b6:510:210::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30; Wed, 20 Sep
 2023 06:51:42 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 06:51:42 +0000
Date:   Wed, 20 Sep 2023 14:51:32 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        <netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [connector/cn_proc]  2aa1f7a1f4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202309201456.84c19e27-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0085.apcprd02.prod.outlook.com
 (2603:1096:4:90::25) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b8e808-1b39-4d6b-b033-08dbb9a60c2c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQNJYBLw0fdo28Br2Wa8JJUBc7cXVdh3dNvKA6t/oWmn/Bvpd9JY1iJGDo6VD8arx+mbEy55KxGIlvG8nYheBLXc875i8SAILIX80ckkAy7L4urjN4sxnJW0mv5y34o9DTAg4rrQGkcaI8pgDqYVst/IQCT7GoNT3QS3kcVyvcFaMC5T1r6PnKlW24BuerBXq7kd2qqHgYRJcje0jkNprfmMr4MQcefs/Vd44BvucOcBqCNWKa1nYVEY8CBaIc6fBAVMQNln/ntCquZhr6VbNK9IWHLXOgzXBp/SmcM7MsFPBMa67FcYQYpqmVWOSxwqXkbZReFa3h0/XmN4J9L0wHFKBV/nwl8lhdkSSEqcLxnkTpr49V7ZiTmwLHI8HVitbVbH3RoBsUtkuYdc8tk+PjOIo636UnDF2LRq1wFbepkUtJRfJWJODau6xFi1OZnYQJkb0lNnx1W9Lj0hmmF4RtRvFwJacvIlbQPg0Bj/TB/flgqMC9/hc7b9L8i1Zalvr6QPMblRBNVOx8KN8hW5j1IQ5jiiGyYLoOcErQvbiigKCcGyx6YCclEcfnUg/6nkMXi3k2d3dLLhjiLyNYAn290/Lf68ynZ89FZ7iVBJdZFH2BR0yN0ZPQnGTYEXFW9w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199024)(1800799009)(186009)(6486002)(6506007)(6666004)(6512007)(966005)(478600001)(83380400001)(26005)(2616005)(107886003)(1076003)(2906002)(54906003)(66476007)(66556008)(66946007)(316002)(6916009)(4326008)(8676002)(5660300002)(8936002)(41300700001)(36756003)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x1ReZoNzgpOz4ln6DUWmJ+MJLijio3cMFNFDMqRwvvzPb7elafHu4Ub77ast?=
 =?us-ascii?Q?rGaD+orkZkwwXtF7t52wuCYWGNRyCsGgyHkxpnjNIxAg2uEEJCtff5Q5kpyz?=
 =?us-ascii?Q?FT2XbMTT8Wp8bvjJEr73T/k2lzAak7YGUbBjEEz8YbU1XnNvLcQMachH5LUH?=
 =?us-ascii?Q?AL6ALIK9yqd972PLRH+9PBWq9vIazMF3T9pHRHlgvcOllLYpbcO0FSkEgRmC?=
 =?us-ascii?Q?J+EqdRtWkQdmeO9as/v17vQ5034eh5BCelbbmjjzpTYotR+RLJkSD7tyQbvz?=
 =?us-ascii?Q?FyUK7sCdMf8VfiRL9JpyFgg27jczTDJz2xHny2HjMSnrEgEYrKDfHdRu9ZIW?=
 =?us-ascii?Q?3jM58DW+OQZgvBJ0/dOObfQvDG/nrGSCSnIQr+GrQTDDmVy7o8Tee5xPUgUB?=
 =?us-ascii?Q?7pTODSlSjpoZmBHAqNOFiXLKW9wnV87xmHZWnDR0lwxfgxnJBLQd1qXqqMWl?=
 =?us-ascii?Q?o8kJliIodDE2OVFOaXA+8T/cuiAdloviTiNE7BVsRKERgDPBxkoi2ULO6qn9?=
 =?us-ascii?Q?DnJfco1koZOAE+fxQ9hdS1+5szSYzqMZepu19H1l79DR9wv20ooCE6QFWZjC?=
 =?us-ascii?Q?mkUzjkHMqdn+QDxdW52pmgCTuB2uElqUJjJuwMp+cy5OEld67B2X0kOzVkP0?=
 =?us-ascii?Q?BWCqLWgVnUdZ8rGhPOHQ1TE4nKb8zpNGcxmS4w4nu0/vOnFJ8Hrlloh1tMEY?=
 =?us-ascii?Q?f1wySepYHwf7S4Ubep90+wqUH/oe54q4awsgTP00BiMabdN5eXeXFtBAC0tX?=
 =?us-ascii?Q?/WIoKU5nwLJon8Jowtd7NAAxU/EEqtCafw9HSUCTH8xlWPwbMQzVQcFv3sVG?=
 =?us-ascii?Q?d5pszFzASgEKg2+TMqou5450GZyQ0UV5dajQiSLarFJ+ic1XKRXs9FLPvNCT?=
 =?us-ascii?Q?Pfu1cHMaFdEYi5sjq06sj2oH7tYFv1/UIOw9GCzZl53C1lsyjZDV61Oc0967?=
 =?us-ascii?Q?NcbKXR1Vy80gBj1Kcn1YNYQAkiNZ5FaIWYnXtGvWvH6JD65hKYFJJ8Y16Gto?=
 =?us-ascii?Q?mUW/0ed0ZN4UgZkXGRzPWvh69cFv24X4Aker8JZGyl8QOUGLE1u6mkh/12wq?=
 =?us-ascii?Q?B1sXeHRpi6X7LdsL3+nECu+hMooB0sCI3D1GWN9fQlQkf5inUCNH1mTKeSmF?=
 =?us-ascii?Q?A6glbMH+bUqCbq1bBfJ0uVhWTBxd54iPhUG6EyyLQM+Ps8jMg6jHLBNQOlQ+?=
 =?us-ascii?Q?Kinbh0HB/Fq6jti+7AYyIiSh6Ogl2jmRX66iVAY5h/x6Qc98HfVRzP/U5LSU?=
 =?us-ascii?Q?o7FdV3Cc/tDFmyTGtMLGswJp7tZbyfMzeQprFvDo1yke1I0oPN+FOZeqKOsS?=
 =?us-ascii?Q?scwM0kM1BFKCUcZxf6HsJ37u3JBCHlftwbyLoq3XE+pdPRJ7I9ZQoRzf+bsj?=
 =?us-ascii?Q?wUQMGOz3uKWqsOFho0V6wM2jIQe1Yfc01HC3gDZ7S+WDtAS/xZ2ycwfbG0lU?=
 =?us-ascii?Q?/FRWK2bNBvoiQgW/HfPE1cz6aAhBwHrwXafc+3s/OrqX8CrYzD5Dc0zi9ek0?=
 =?us-ascii?Q?e1tktRAkMUvlWWVNgOPeuJV5xwv53x5wgRoT4xgM2x893C81XeurIISJXlSF?=
 =?us-ascii?Q?9Entmkin7qwzgB1Fms2BnSGwB/rnOp5vDcL93H/m3nhtZvzG2ZfljC0kJjLp?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b8e808-1b39-4d6b-b033-08dbb9a60c2c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 06:51:42.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bhNERDtMP9JbJD8NOkfgEDRoby7RUjCyJsdY/qwlO19sJ55juUSln235i8PgIrhC4IzndyMrydSymBrJZn89Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6524
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 2aa1f7a1f47ce8dac7593af605aaa859b3cf3bb1 ("connector/cn_proc: Add filtering to fix some bugs")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 57d88e8a5974644039fbc47806bac7bb12025636]
[test failed on linux-next/master dfa449a58323de195773cf928d99db4130702bf7]

in testcase: stress-ng
version: stress-ng-x86_64-0.15.04-1_20230912
with following parameters:

	nr_threads: 100%
	testtime: 60s
	sc_pid_max: 4194304
	class: scheduler
	test: netlink-proc
	cpufreq_governor: performance



compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309201456.84c19e27-oliver.sang@intel.com


[   37.396174][ T4144] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   37.419771][ T4144] #PF: supervisor read access in kernel mode
[   37.425772][ T4144] #PF: error_code(0x0000) - not-present page
[   37.431771][ T4144] PGD 184255067 P4D 0
[   37.435867][ T4144] Oops: 0000 [#1] SMP NOPTI
[   37.440388][ T4144] CPU: 45 PID: 4144 Comm: stress-ng Not tainted 6.5.0-rc2-00552-g2aa1f7a1f47c #1
[   37.449509][ T4144] Hardware name: Inspur NF5180M6/NF5180M6, BIOS 06.00.04 04/12/2022
[ 37.457502][ T4144] RIP: 0010:cn_filter (drivers/connector/cn_proc.c:60) 
[ 37.462384][ T4144] Code: 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 85 ff 74 15 48 8b 87 78 02 00 00 <83> 38 02 0f 94 c0 0f b6 c0 c3 cc cc cc cc 31 c0 c3 cc cc cc cc 66
All code
========
   0:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	f3 0f 1e fa          	endbr64 
  19:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1e:	48 85 ff             	test   %rdi,%rdi
  21:	74 15                	je     0x38
  23:	48 8b 87 78 02 00 00 	mov    0x278(%rdi),%rax
  2a:*	83 38 02             	cmpl   $0x2,(%rax)		<-- trapping instruction
  2d:	0f 94 c0             	sete   %al
  30:	0f b6 c0             	movzbl %al,%eax
  33:	c3                   	retq   
  34:	cc                   	int3   
  35:	cc                   	int3   
  36:	cc                   	int3   
  37:	cc                   	int3   
  38:	31 c0                	xor    %eax,%eax
  3a:	c3                   	retq   
  3b:	cc                   	int3   
  3c:	cc                   	int3   
  3d:	cc                   	int3   
  3e:	cc                   	int3   
  3f:	66                   	data16

Code starting with the faulting instruction
===========================================
   0:	83 38 02             	cmpl   $0x2,(%rax)
   3:	0f 94 c0             	sete   %al
   6:	0f b6 c0             	movzbl %al,%eax
   9:	c3                   	retq   
   a:	cc                   	int3   
   b:	cc                   	int3   
   c:	cc                   	int3   
   d:	cc                   	int3   
   e:	31 c0                	xor    %eax,%eax
  10:	c3                   	retq   
  11:	cc                   	int3   
  12:	cc                   	int3   
  13:	cc                   	int3   
  14:	cc                   	int3   
  15:	66                   	data16
[   37.482194][ T4144] RSP: 0018:ffa000002efcfc78 EFLAGS: 00010286
[   37.488305][ T4144] RAX: 0000000000000000 RBX: ff1100014764c000 RCX: 0000000000000000
[   37.496325][ T4144] RDX: 0000000000000000 RSI: ff110001005e4c00 RDI: ff1100014764c000
[   37.504340][ T4144] RBP: ffa000002efcfcc0 R08: 0000000000000000 R09: ffffffff83b2cd80
[   37.512358][ T4144] R10: ff110001005e4c00 R11: 0000000000000000 R12: ff110001005e4c00
[   37.520375][ T4144] R13: ff1100014764c080 R14: ffffffff81971d50 R15: 0000000000000001
[   37.528391][ T4144] FS:  00007f06a096e740(0000) GS:ff11002000140000(0000) knlGS:0000000000000000
[   37.537365][ T4144] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.543997][ T4144] CR2: 0000000000000000 CR3: 0000000148042001 CR4: 0000000000771ee0
[   37.552020][ T4144] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   37.560047][ T4144] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   37.568073][ T4144] PKRU: 55555554
[   37.571676][ T4144] Call Trace:
[   37.575021][ T4144]  <TASK>
[ 37.578016][ T4144] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
[ 37.581966][ T4144] ? page_fault_oops (arch/x86/mm/fault.c:707) 
[ 37.586875][ T4144] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1494 arch/x86/mm/fault.c:1542) 
[ 37.591689][ T4144] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
[ 37.596765][ T4144] ? __pfx_cn_filter (drivers/connector/cn_proc.c:52) 
[ 37.601575][ T4144] ? cn_filter (drivers/connector/cn_proc.c:60) 
[ 37.605865][ T4144] ? kmalloc_reserve (net/core/skbuff.c:562) 
[ 37.610671][ T4144] do_one_broadcast (net/netlink/af_netlink.c:1496 (discriminator 1)) 
[ 37.615481][ T4144] netlink_broadcast_filtered (net/netlink/af_netlink.c:1555 (discriminator 11)) 
[ 37.621246][ T4144] ? __pfx_cn_filter (drivers/connector/cn_proc.c:52) 
[ 37.626053][ T4144] proc_fork_connector (drivers/connector/cn_proc.c:82) 
[ 37.631118][ T4144] copy_process (kernel/fork.c:2728) 
[ 37.635844][ T4144] kernel_clone (include/linux/random.h:26 kernel/fork.c:2913) 
[ 37.640301][ T4144] __do_sys_clone (kernel/fork.c:3056) 
[ 37.644848][ T4144] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 37.649309][ T4144] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   37.655250][ T4144] RIP: 0033:0x7f06a0ad89fb
[ 37.659713][ T4144] Code: ed 0f 85 f8 00 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 41 89 c5 85 c0 0f 85 9e 00 00
All code
========
   0:	ed                   	in     (%dx),%eax
   1:	0f 85 f8 00 00 00    	jne    0xff
   7:	64 4c 8b 0c 25 10 00 	mov    %fs:0x10,%r9
   e:	00 00 
  10:	45 31 c0             	xor    %r8d,%r8d
  13:	4d 8d 91 d0 02 00 00 	lea    0x2d0(%r9),%r10
  1a:	31 d2                	xor    %edx,%edx
  1c:	31 f6                	xor    %esi,%esi
  1e:	bf 11 00 20 01       	mov    $0x1200011,%edi
  23:	b8 38 00 00 00       	mov    $0x38,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	0f 87 91 00 00 00    	ja     0xc7
  36:	41 89 c5             	mov    %eax,%r13d
  39:	85 c0                	test   %eax,%eax
  3b:	0f                   	.byte 0xf
  3c:	85                   	.byte 0x85
  3d:	9e                   	sahf   
	...

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	0f 87 91 00 00 00    	ja     0x9d
   c:	41 89 c5             	mov    %eax,%r13d
   f:	85 c0                	test   %eax,%eax
  11:	0f                   	.byte 0xf
  12:	85                   	.byte 0x85
  13:	9e                   	sahf   


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230920/202309201456.84c19e27-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

