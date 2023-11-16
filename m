Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE507EDAFA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 05:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjKPEwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 23:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjKPEv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 23:51:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4290DDA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700110314; x=1731646314;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=52jDNIuPHTVg1Mi/OyderOClnm0oThn6tkT+ZjIY4tI=;
  b=Axiq4VO/HUTn8B1SYTkfvOoz/4q3IJ4OulokTHJaTqKSLvBtNsSGs43q
   azOlTqzaWWGR9L+3gaXW9x+VKR6Cc+urQFjgV/szTiyFT8gb4HSzZfBd8
   sfnUzqBRvtp+/zr43zWrOXGIYORE/RLhTrb5+nREThW85JVPRIT9xSTx4
   k2SEeepYaq5CwBDj04/3CA+5QUtdHp6ku51OT3thyaroup6E24FWVm0kN
   1uWLoEpL9r9mNSAI5EqqdcuU8ojqOFg2GKTabS+Npgm6kC3+0cmu3Xn9g
   MI57JInQlOCG0UI+nm/v3ZyumiTA9e/6ecPGx+DrTpX7z5ICDhYgx4a7n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="477230829"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="477230829"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 20:51:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1012487152"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="1012487152"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 20:51:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 20:51:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 20:51:52 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 20:51:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLWJrIstDEnCjNV2x6Yz2Ju5tblDDz7/MO6Ew9CUankIc1FAvWzLqE6dHNrnytMeQC5Ytp0oRyofGZ3BdrnqBN/hHaI26nw2/186LBfGIpG5VXNGhgLzh7CkBqFtVBXBholuraNeXYWYBDWUgMXb9ErlRmyJSwxjSoDhAosTfPGmUwYTaRgtOeOLMC3nvhCJSUwtoMrXc1nHywiPy3xgMhiTx0EfoBaJeOxz2oi4rROBb10K0g2Za5wheEP3byCcEQwQFy8LrUPbavfkOXy4IfL4CUPc9D3G8+S7OqmIMp7CbAIiMHFpA3hvhvQEbNnPaG2iAA8sjiF4SuFDv+FrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwxgAws+mqOBNAtZcuQJHpbLNuXW8Elq3qxzsZrsjgE=;
 b=dAFEtGT6Kf0IkEUOlm7/SuUiWRQ2yqZA+WzuiA8XPhOhkFOMkV/76/7fkMUoyZCshjHS1IQguQ34c3pnN3Z7w3keYhl5ucCS82IIwB1spO0W94L0p/EZ6CS125ufHTXKkcwG0dloasP7V1mpLnmVVxDsUWi6XTInPcVqtP0+6s9GJ9qNeT3e3gO0RNb+bDqh4vBv4U9qRTCJKPgMgJ+ZVX4obFn+UsSsEcZ5zea6sk6Q94YnqmbsNNz7l0OvVYIylYh9xr7K2GrIFKHZyOTvYh1+fXRvUmD95+j7uBibmsqp5Gv+q774wgpdrvFHjrbnWynqORfq6SPrrq3IeWEPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SN7PR11MB6727.namprd11.prod.outlook.com (2603:10b6:806:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.35; Thu, 16 Nov
 2023 04:51:49 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 04:51:49 +0000
Date:   Thu, 16 Nov 2023 12:51:41 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     John Johansen <john.johansen@canonical.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Georgia Garcia <georgia.garcia@canonical.com>,
        <apparmor@lists.ubuntu.com>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [apparmor]  90c436a64a:  stress-ng.kill.ops_per_sec
 -8.0% regression
Message-ID: <202311161149.4d39cc37-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SN7PR11MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 00aa1e7e-4e0e-4193-de19-08dbe65fbe13
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISkzZZ/pBBXYzbC4H6rORx/lQgQH1ZvlFx68BbEHPWcQx5/hTkT21qTR5w4McfbT4t6XMeTo4zBmSVLiWSja+Wkzl/WPfynOS93c28kGCblQI88OJiZy3XQgpD8vq79zXNuJ3tv535/4T9GBn+3NclYLJsIbqdCCBtkCJUSfVlEcL6UcpjfSLnp7wYQmyjm/fXpbuPbcW0RCvvd5fA0CZ10Ad5bug13NqFCfCcxnC4fOZjifK5lUf/xlA2hqnRjF1k9opkBvq4FULyJE/XkCIjXDUrNK+LdSR6ojcbvISNMLWIGKkGSgr986IpPu0IP5YyYR9XT+TGhRlrgAqjdAFq8whLb9w2bDAfCcErKc0Ce4rfyAPQDLD2j4jd8D5LAdQoe4QKgZuVIcKJkQDJli5SflRbU4NYlh0g/GP43hIDFGWj/rHYSv+X9MjtsgWWOzGx+Mhad5FEyUCPB5I15sXF2urOq8cRz5hdew73pGmk5laP3+Ce/Zw4AlgESRrNL30XkuyLvDXdRM5VXMDqtj6eOuJdiBaksmh6FCNrvePtbW/ZS7QnjXnyMoDaaRmjUKlGBC6hGpsXTxU8YQ0KZtPuwdgtM9B/9EmtVWfpEOtfiXf2fSfnbuJIWjndbbXJRk3Cr/DjfKx057lWVSJtPLoogZDxU/OD4JbSe8jkoHD4JkFsD8GBkA3h9hCeQmP2Rd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(230373577357003)(230473577357003)(451199024)(1800799009)(186009)(64100799003)(36756003)(38100700002)(2906002)(30864003)(41300700001)(5660300002)(66476007)(83380400001)(6506007)(966005)(6486002)(8676002)(8936002)(4326008)(86362001)(66556008)(6666004)(66946007)(316002)(478600001)(6916009)(107886003)(2616005)(26005)(1076003)(82960400001)(6512007)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+1fBLzUxoBHdh1feV+UadsJL0+YaFMUXiaIt7nS2IXd2wNFZ5tMGKg/Amt?=
 =?iso-8859-1?Q?fPui7DERLIOQaWAkdcm/eVoNaiYvMK9dWe0DdVV0okTgt1cxFPlnhpeQPc?=
 =?iso-8859-1?Q?o2wwoPrEJg74fDwDUDUwY3QNOBQhncnWX9qps9aBUqnDRJaWR3DvRdLDRg?=
 =?iso-8859-1?Q?WnBDzDEfPFd12dKhgMkD6nz0jGlFw3l9U7E72X4japveZ9hzuL+J52r7r0?=
 =?iso-8859-1?Q?I4Eyxst9KvajzfhHg9NmIy8JIJIiPfJPbX0rLqB5sKvcAj4uqduXo6zw4F?=
 =?iso-8859-1?Q?2uICD6s6nGjC7L/AB0ZSEvZu2wPvyPjEDDKmhKgcGzX0Gy9edxzteLCAfF?=
 =?iso-8859-1?Q?vc+SFcydVK7tpg7j568YA1Y2fByC863auBPhNVkIW+eftjKBhSACiw46TH?=
 =?iso-8859-1?Q?WBbyD0oHBvLyVTpxLpryUvVKaf4+QzejI/hJQlht8GNRqmoqFWeaSF3hTj?=
 =?iso-8859-1?Q?8Ad/0RqUTDZt2c9PbkcJoI3ffs6aQMHMcKjlrNUkLdRApqGCF6aKUWTNWH?=
 =?iso-8859-1?Q?22WPWbBMyTwv82Sx6dgsMCQKnmwFqB1Hw0qb4WLVrLuzD6nWcopBNHegbm?=
 =?iso-8859-1?Q?ogkLeg6pZBb6wuX6zHU2r0alB3kwIGEgr6OzIvKQTGbKonsSi97R7pJ/Up?=
 =?iso-8859-1?Q?q5iKvDJCJGU+jfGkZs1tsbLeXF8thidrjMhBS8xdOGdbl3TFZbrUQRXRXk?=
 =?iso-8859-1?Q?1h4uArH4sFjtqMIfHN0wIi/LvOOhl7AbozUjL1QSiN8gc8hFuzPv/+rbpz?=
 =?iso-8859-1?Q?nahE9NWtmsYoWvA1gu2BGhjrs1+6D3Y0TNyO3PYVDweNZG+aMKBIjRDJS4?=
 =?iso-8859-1?Q?nfxFDn9UG1LewjlnF3G7TM7TBf6TGfsV0B0O6jyqHod8obx9Cwyv3S9Qo0?=
 =?iso-8859-1?Q?FstFlO5MemJ05PWUgpJmO0nLk4BlgAVBwgmMHIwehXLuxAUdhrFBBQX/1a?=
 =?iso-8859-1?Q?cVJFzwKAY4sBzXcR8oHI2aWZzny4B3Jj4kLNBBemVhXKoiBaKziwpQxpwA?=
 =?iso-8859-1?Q?rydjgclxm1q/vaDYISM+c6T9aCtEUGp/5DQ+amPZB2mnSaxOuXjE/kxWrN?=
 =?iso-8859-1?Q?uc6S1kyzpv6yHerpHNhO4RHKZmbGT3ycQ20W6PTYICYyIZHedsLdKFuabc?=
 =?iso-8859-1?Q?94ZxKEzalFHjfZRcKWkndpGByToUZ8wQxJMihYjtmgqavpma5bjERhAmFd?=
 =?iso-8859-1?Q?hXma1omBhZUPBV86fyeDUatheA3D6PmSk4BGKp8F09WJkisS/an0zMEmjS?=
 =?iso-8859-1?Q?TarNOBmG2D+UgvSl+50/Apr5G6EjGPC7qRNApVX/h/cPNTBnr4uEsH0ody?=
 =?iso-8859-1?Q?7XqyqIX8y+vudhl9RwAY1/ngiPlYr7/L2K1Si/aPi1P17w+BF5+1eqvr6D?=
 =?iso-8859-1?Q?A4+hIgkz3RGmPTB1Pl8eMStIDJ4WBuCbFkPLoIz0D0GOGiWkcN1fe9cuYy?=
 =?iso-8859-1?Q?2Jzzl5fqM1qNP8nFmJ9Ag5hXUuFgsPa9S3LI/YepnNpfVdbyPyHbzjM8rd?=
 =?iso-8859-1?Q?sxLdxYoyxWLfzaFf+LicnquYzLkJFA7Iptw2NxZ9XuXnB3HGQmvddlDxSE?=
 =?iso-8859-1?Q?Qg/S5hLrqY1FIz+A/MK+rALxqnKB4RHCICBP2vWgorc5PjXEZLr/dyVUhI?=
 =?iso-8859-1?Q?DzYAR1lXxBtFZPtudIAy/yWKkFZJeKxYm89h8cGXqTuMWID8fI9oCAUQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00aa1e7e-4e0e-4193-de19-08dbe65fbe13
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 04:51:49.1824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29h9MN9Occ3GxvwHp/ghYYXqwfxae6cPJydL+Bpw+Kysw/sRIahqmYtOLB6ztKHlOyoYu1tncUmtc4rUgZQQqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6727
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi, John Johansen,

we reported
"[linux-next:master] [apparmor]  90c436a64a: stress-ng.kcmp.ops_per_sec 383.0% improvement"
in
https://lore.kernel.org/all/202310311037.173ebf2b-oliver.sang@intel.com/
when this commit is in linux-next/master.

now we noticed this commit is in mainline, however, we catpured a small
regression by another stress-ng test. FYI.


Hello,

kernel test robot noticed a -8.0% regression of stress-ng.kill.ops_per_sec on:


commit: 90c436a64a6e20482a9a613c47eb4af2e8a5328e ("apparmor: pass cred through to audit info.")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	class: interrupt
	test: kill
	cpufreq_governor: performance



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311161149.4d39cc37-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231116/202311161149.4d39cc37-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  interrupt/gcc-12/performance/1HDD/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/kill/stress-ng/60s

commit: 
  d20f5a1a6e ("apparmor: rename audit_data->label to audit_data->subj_label")
  90c436a64a ("apparmor: pass cred through to audit info.")

d20f5a1a6e792d22 90c436a64a6e20482a9a613c47e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    112.01        +21438.4%      24124 ±200%  meminfo.Active(file)
     62.80            +4.5%      65.65        turbostat.RAMWatt
     15.04 ±100%   +4879.0%     748.88 ±114%  vmstat.io.bo
     82957 ±  2%      -7.4%      76795 ±  3%  vmstat.system.cs
     28.00        +21403.0%       6021 ±200%  proc-vmstat.nr_active_file
     28.00        +21403.0%       6021 ±200%  proc-vmstat.nr_zone_active_file
    129482            -4.4%     123826        proc-vmstat.pgactivate
      1032 ±100%   +4641.1%      48928 ±113%  proc-vmstat.pgpgout
     16.90 ± 14%     +25.5%      21.21 ± 20%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     16.89 ± 14%     +25.5%      21.21 ± 20%  sched_debug.cfs_rq:/.removed.util_avg.avg
    247.17 ±  6%     +14.0%     281.82 ±  8%  sched_debug.cfs_rq:/.util_est_enqueued.avg
     34402 ±  2%     -21.9%      26867 ±  6%  sched_debug.cpu.nr_switches.min
    181.33 ±  7%    +129.4%     416.00 ±  2%  perf-c2c.DRAM.local
      1766 ±  4%    +140.5%       4249 ±  4%  perf-c2c.DRAM.remote
      3189 ±  5%    +119.0%       6984        perf-c2c.HITM.local
    538.00 ± 10%    +273.7%       2010 ±  7%  perf-c2c.HITM.remote
      3727 ±  6%    +141.3%       8995 ±  2%  perf-c2c.HITM.total
    738.58            -8.1%     678.88        stress-ng.kill.kill_calls_per_sec
    912564            -8.0%     839201        stress-ng.kill.ops
     15208            -8.0%      13985        stress-ng.kill.ops_per_sec
   2741058            -7.8%    2527111        stress-ng.time.involuntary_context_switches
   2721296            -7.9%    2505879        stress-ng.time.voluntary_context_switches
      0.58 ±  7%     +35.9%       0.79 ±  6%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
     21.33 ± 18%     -50.0%      10.67 ± 32%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.01 ± 26%     +54.5%       0.01 ± 25%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.proc_sys_call_handler.vfs_read
      1.68 ±214%     -99.5%       0.01 ± 64%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.01 ± 36%     +66.0%       0.01 ± 28%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.proc_sys_call_handler.vfs_read
      8.10 ± 43%     -29.7%       5.69 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.task_work_run.exit_to_user_mode_loop
      1.64 ±  2%    +152.0%       4.13 ±  3%  perf-stat.i.MPKI
     11.98            +6.8       18.75 ±  2%  perf-stat.i.cache-miss-rate%
  13072329 ±  2%    +145.9%   32141491 ±  4%  perf-stat.i.cache-misses
 1.082e+08 ±  3%     +53.1%  1.657e+08 ±  4%  perf-stat.i.cache-references
     86654 ±  2%      -8.4%      79368 ±  4%  perf-stat.i.context-switches
     15915           -59.2%       6487        perf-stat.i.cycles-between-cache-misses
      0.01 ± 15%      -0.0        0.01 ±  5%  perf-stat.i.dTLB-load-miss-rate%
    338311 ± 15%     -21.7%     264729 ±  8%  perf-stat.i.dTLB-load-misses
    149.20 ±  5%    +115.1%     320.97 ±  2%  perf-stat.i.metric.K/sec
     86.96            +3.9       90.83        perf-stat.i.node-load-miss-rate%
   2659602 ±  3%    +205.8%    8133328 ±  4%  perf-stat.i.node-load-misses
    398586 ±  5%     +69.2%     674468 ±  5%  perf-stat.i.node-loads
   4272013 ±  2%    +102.4%    8646615 ±  5%  perf-stat.i.node-store-misses
    444659 ±  3%    +117.1%     965253 ±  5%  perf-stat.i.node-stores
      1.63 ±  2%    +149.4%       4.06 ±  2%  perf-stat.overall.MPKI
     12.08            +7.3       19.41        perf-stat.overall.cache-miss-rate%
     16313           -59.8%       6554        perf-stat.overall.cycles-between-cache-misses
      0.02 ± 15%      -0.0        0.01 ±  7%  perf-stat.overall.dTLB-load-miss-rate%
     86.84            +5.5       92.33        perf-stat.overall.node-load-miss-rate%
  12940552 ±  2%    +146.4%   31886577 ±  3%  perf-stat.ps.cache-misses
 1.072e+08 ±  2%     +53.3%  1.643e+08 ±  3%  perf-stat.ps.cache-references
     85805 ±  2%      -8.3%      78664 ±  3%  perf-stat.ps.context-switches
    341154 ± 16%     -21.3%     268598 ±  9%  perf-stat.ps.dTLB-load-misses
   2632824 ±  2%    +206.4%    8067907 ±  4%  perf-stat.ps.node-load-misses
    398939 ±  5%     +68.2%     670849 ±  5%  perf-stat.ps.node-loads
   4233610 ±  2%    +102.6%    8578379 ±  4%  perf-stat.ps.node-store-misses
    434918 ±  3%    +119.3%     953796 ±  4%  perf-stat.ps.node-stores
     38.66           -38.7        0.00        perf-profile.calltrace.cycles-pp.aa_get_task_label.apparmor_task_kill.security_task_kill.kill_something_info.__x64_sys_kill
      9.04 ±  6%      -2.4        6.67        perf-profile.calltrace.cycles-pp.aa_may_signal.apparmor_task_kill.security_task_kill.kill_something_info.__x64_sys_kill
      0.74            -0.0        0.68        perf-profile.calltrace.cycles-pp.profile_signal_perm.aa_may_signal.apparmor_task_kill.security_task_kill.kill_something_info
      0.76            -0.0        0.72        perf-profile.calltrace.cycles-pp.kill_pid_info.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe
     98.37            +0.1       98.46        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
     98.38            +0.1       98.47        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.kill
     98.40            +0.1       98.49        perf-profile.calltrace.cycles-pp.kill
     98.24            +0.1       98.36        perf-profile.calltrace.cycles-pp.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
     98.20            +0.1       98.32        perf-profile.calltrace.cycles-pp.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
      0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.check_kill_permission.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.74        perf-profile.calltrace.cycles-pp.get_task_cred.apparmor_task_kill.security_task_kill.kill_something_info.__x64_sys_kill
     38.96           -39.0        0.00        perf-profile.children.cycles-pp.aa_get_task_label
      9.14 ±  6%      -2.4        6.74        perf-profile.children.cycles-pp.aa_may_signal
      0.47 ±  4%      -0.1        0.41 ±  2%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.47 ±  3%      -0.1        0.41 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
      0.46 ±  3%      -0.1        0.41        perf-profile.children.cycles-pp.open64
      0.76            -0.1        0.71        perf-profile.children.cycles-pp.profile_signal_perm
      0.45 ±  4%      -0.1        0.40        perf-profile.children.cycles-pp.do_filp_open
      0.45 ±  4%      -0.1        0.40 ±  2%  perf-profile.children.cycles-pp.path_openat
      0.20 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__schedule
      0.20 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.schedule
      0.32 ±  6%      -0.0        0.28 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      0.76            -0.0        0.72        perf-profile.children.cycles-pp.kill_pid_info
      0.07 ±  7%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.complete_signal
      0.10 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.do_send_sig_info
      0.09            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__send_signal_locked
      0.19 ±  3%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.apparmor_capable
      0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.try_to_wake_up
      0.19 ±  3%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.ns_capable
      0.19 ±  3%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.security_capable
      0.09            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__close
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.__x64_sys_pause
      0.07            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.task_work_run
      0.09 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.09 ±  8%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.lookup_fast
      0.07 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.proc_sys_call_handler
     98.24            +0.1       98.36        perf-profile.children.cycles-pp.__x64_sys_kill
     98.23            +0.1       98.35        perf-profile.children.cycles-pp.kill_something_info
      0.05            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.audit_signal_info
      0.07 ±  7%      +0.2        0.27 ±  2%  perf-profile.children.cycles-pp.audit_signal_info_syscall
      0.42            +0.3        0.70        perf-profile.children.cycles-pp.check_kill_permission
      0.00            +0.8        0.76        perf-profile.children.cycles-pp.get_task_cred
     38.83           -38.8        0.00        perf-profile.self.cycles-pp.aa_get_task_label
      8.36 ±  6%      -2.3        6.03        perf-profile.self.cycles-pp.aa_may_signal
      0.74            -0.1        0.68        perf-profile.self.cycles-pp.profile_signal_perm
      0.10 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.security_task_kill
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.07 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.12 ±  4%      -0.0        0.11 ±  5%  perf-profile.self.cycles-pp.__kill_pgrp_info
      0.09 ±  5%      -0.0        0.08        perf-profile.self.cycles-pp.kill_something_info
      0.11 ±  4%      -0.0        0.10        perf-profile.self.cycles-pp.check_kill_permission
      0.00            +0.2        0.16 ±  2%  perf-profile.self.cycles-pp.audit_signal_info
      0.06 ±  8%      +0.2        0.26 ±  2%  perf-profile.self.cycles-pp.audit_signal_info_syscall
      0.00            +0.8        0.75        perf-profile.self.cycles-pp.get_task_cred
     46.37           +40.2       86.58        perf-profile.self.cycles-pp.apparmor_task_kill



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

