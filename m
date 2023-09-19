Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606A27A5A76
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjISHGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjISHGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:06:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A365116
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695107161; x=1726643161;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=o0XIFYToZLeqDY1YQPGrcGvewVFQBQk+grrsXV8MofA=;
  b=T6FDXRHb9FmTzIMQucsMGejl9ONVmCU56ygpiEHTtIO8CSYlpQE6vnVR
   DGvR6GATeZm+tjc8nUOzJf4jIWuaq7Cm1kVwO2QONga92MGMCLhfoNq3o
   2To7KlkohckDjHewV90j/EUaAr/hWsynm2yiyR2V32qC9Vt7xPTOyQVWL
   JGzY6sJavrFXxD10jnQ6C47J5udFSCYhPau6y01Dhik2M88/LO3pla4q6
   PgG9eQV9qRQnX4RlsUjra7RlJDjSNJqTOrKpp/m88mXZur7QUaYU+B35P
   lNRX5CHx2tg7WFT/qhSxoasvbg80+U3I18tIIU2Le+pImF2FXhJIQRAOQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="443955581"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="443955581"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 00:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="739572389"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="739572389"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 00:05:51 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 00:05:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 00:05:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 00:05:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1PjBRXVf0B/GD27GZFcSGmd32c89S3hlnkk4tVbnsVMtl+z5cbRu/5QKfRgKwd0jIIjeywsAQ6LiabMUDAQ+aOJ43+G/yMK6RLff9EKsznnOxZX3vjJNCdr9ZNcAFINGpZPfxbHhBpNoPzEJH4wGjoXJ7ehjtJ/6XGOVgUBfCqxsppOwJqfoDOdOde7jybLO7rrPIK6MzGv8R0gcfECNcmEKRrRr146hMiHtuXD0TNlL/cCwHRnEjmkqOPVLP0gbr8//TR/MLya7+3kfKWUPu1K8ou7S+JZss8EqvHfqEnXEe+9uhWB+2M4rBOFFjZSQoRTu+vG3WVLYNEBqHgC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe1154qhwnwESqxdhqYwEZxtLLPrSSuHjI0V35vYx6A=;
 b=kz1J0lFeI7h5ESERjtP95SaIc4ZW3cAYtHZLalY6VTPnVJZ6pU968xsILIY1JnunZxYeZR8GutqI3vVuvoal8zOxVGtighDxC/I4rIP4Lyk4ccGrn0waig6DO7040NpY4BPoj5Uos7mhwul/asaY0MHC5GtZK48qN0cjuWOvhBsjwyzsxCBJydG+0JMXK9cT0uJUXY9jabkrauHsw3qxmrwNQDhb7yY1CFBKEHTWMaKv/gTIMADAvi1MEvz/tMZ+QwFAG9GtBzU754TbcgHsuLYpbNnogEgcDCM1K0GlYyJ2UoRSkrfrSjLGCiqNLwiyiTbd+dPCjpNkTmHMMmyJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB6450.namprd11.prod.outlook.com (2603:10b6:510:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 07:05:24 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 07:05:24 +0000
Date:   Tue, 19 Sep 2023 15:05:12 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <aubrey.li@linux.intel.com>,
        <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched/fair]  86bfbb7ce4:
 fxmark.ssd_ext4_dbench_client_2_directio.works/sec -15.5% regression
Message-ID: <202309191404.2d18793e-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:54::24) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 063931ad-240e-49b2-9cfa-08dbb8decb36
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsspyx/Di9R1R9SSF9f+zcHl3KqDAltJuC+mKoJQ0mPcUp0FLCP26s5Z5pORE24pS3R34oSfBC914mvthA/QzC1246IaTvXVkdL1Czm1xS2gYKckcju4e0Rh5SQoCJ7uCPCyY2S3KkNaDTXdIFifEv3rydquTc1/J1jVHzKt0ZDqF+ZFXDEs7vK4rsO7UpfUHzWaS3e0UAKkVmCfmcWTh5tGY35xks3C81C2HzNUYqjGSUStTaz2ZjrBW5SDFztxsDg57QHJNJD14TFSQ5wTTWVXViJSUmGcBg89tONxZgapoRZ1KBqtO5RsFYBbbZDQq/bkJH7x81LjWniolH+5XYNEljEUxP2VsAZPZ2Tqo/LchfMuHKPd6NO2fIPjkFeuvSlok9y0yW6F2GnsE+ZWvljLVRW9ZB+B+RqK6GIQGmhZ1mhNYQu6KXYv8MOkEkNc042ZeHSNUf7AZRS9M2Rdb9godYux4DpTp0g0WGlFUI4lhB08VedQNMRbuybPKrvfNmqDPSKQlcUlldLG+5mDjthQVLRTVxdSgs8CAIjTYTTcB6iOMHwuJ5YSJJSCse9isJnnNP4HqOYWmeeMxilVAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(186009)(451199024)(1800799009)(6916009)(316002)(66476007)(86362001)(66556008)(66946007)(30864003)(38100700002)(82960400001)(2906002)(36756003)(41300700001)(19627235002)(5660300002)(478600001)(6666004)(966005)(6486002)(6506007)(6512007)(4326008)(8936002)(8676002)(1076003)(83380400001)(26005)(2616005)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pDPr0ZaK2WlEk1IMk+4UV8cjRj26R7nBAXefGatNv2NueeuFjcwdYpS6Kz?=
 =?iso-8859-1?Q?jf8J+T5c3EyOe7MUBARwI4hws3uyTkOxJ5oO4VTAhMe+Z3lIMh3KRHaGQz?=
 =?iso-8859-1?Q?Kw1wY1fxg6mNHXxFDP8lJYaaFsqaPB/iS1cY+cSytV7c03TxqkUs+Sq3hg?=
 =?iso-8859-1?Q?ntmSN30rD95qxhmY2Uj3lz19fPXlic/NbRsCcBUJafYMRXlZvc6ENwnkRC?=
 =?iso-8859-1?Q?YRrYpu43QWh6OBAt17DymrEFYOPg5OlZUJPtMcrYF9UVSEgIXnBySJJxUu?=
 =?iso-8859-1?Q?yZj+D/eLL5KQIsfoRhYO1o+5kFb/Lu8vVIb7zT+fJCLJb0hplNMNbRrdk2?=
 =?iso-8859-1?Q?crvuguKlQaQYeOsw1LrS+lgzIIAVcBjNIeIosZbuhHwzfMrR7n3sHteQZu?=
 =?iso-8859-1?Q?LoYjjf4TjCDoy06O/iAgArlJLKzWXzAiWOYJH4bEfH7Sfhweo0gZlwrNqr?=
 =?iso-8859-1?Q?pi9ucUH0kd1dN7Nuz1s9qX49qwmw+udOKwQJH4IT+kJMb9gPI3iK5MfYeS?=
 =?iso-8859-1?Q?oz4DQGe5zS7ShPN6dm6VFf+bKls1zycYt4euqsCTsCNIVY5NJIqn0YQnm5?=
 =?iso-8859-1?Q?fW68HW274OIEFIpeLg6dxAkzjSieJ36P8PIJRXSEDG1nThlfKtVnNn4+2f?=
 =?iso-8859-1?Q?HUcDwgNY1mjZJvolhiNSBTnzP+ji4PSr8Oh2kXFxNa9viF+m5kEljNeDEW?=
 =?iso-8859-1?Q?KDbzjrUMUOEnyJqykvddo8jTVKcGzHBqrDBwDHpo0sDLV9rkYy/+4ZD53v?=
 =?iso-8859-1?Q?H9UfczculHXwpad40acKHo3Esa3jjRDyWL9rdG3swrFxAIW0Q2yy16RY54?=
 =?iso-8859-1?Q?LDPEtoe0M4nS5fh4JZN3I4QSLVu3DkH+p83OIwPwjQ1hkZUCXcQnz6uCx+?=
 =?iso-8859-1?Q?ajeKDO3RjmywKLrFGtV03Sr6LWwr1lV2rTz3lBXJ74C/2jpINKUiYzSLaf?=
 =?iso-8859-1?Q?UfJXIR6lZ7DR0Dmd5CItjqySeP6Tf79LmQpqSmSa5KbLaKAeGnSBER3ZCB?=
 =?iso-8859-1?Q?7SEqUX0Af9tptXesd4IGKPKHRdJJ0l5gipg+pK4Q4HcK9ct+1TdzZGPjpo?=
 =?iso-8859-1?Q?BjXXdu76uAAUdcevSQ3LJKwD9+up7PUFPCBlQ0EGfYeh3n7+GHtXE2jheK?=
 =?iso-8859-1?Q?txtBy5QDF06j/PSr8YQe62MamIhO3wsKcxuOnZh/7pGj3L0EvB+jfWq/4w?=
 =?iso-8859-1?Q?zdv/hmeFlSw5Gfh1xOaw6/mS2oR9JzTTTAOnWd8WrwLNdKyWe3aPsHWtHx?=
 =?iso-8859-1?Q?S+TX0xnxm54pBWmu41mHAQXMQK939+YcaUFg0p4tNq8XVgHVcXCaBPe/UP?=
 =?iso-8859-1?Q?EbU6nvoHKEkrSPMJyTQlrCSk1CLXcUyB/bap+ZFR0nOKQzTUazZiAJQXc6?=
 =?iso-8859-1?Q?Sw4DEsW+h7kQnQ0mLfesFksJYy0RTr4aCHvwmmBKQ7cpHEJKJJ4pxM5uz2?=
 =?iso-8859-1?Q?pjrJz4XWVzAtLKz7piajjgQf+t3+ylDwyWPv5fRe5TQMz3WJnbR5GewCW3?=
 =?iso-8859-1?Q?G8VLwmGBZ48R8QmWHEPNxtrXro/lEnwH058yvACfBBhMQHmCT7uv2mMlDk?=
 =?iso-8859-1?Q?74iCBzST4CqtW0sqXsa3G8UUodEicXy7p0nA6KjKK94FdfISobCL2NiprO?=
 =?iso-8859-1?Q?BDT5M3RMQjPf6aQRw2/7vyi8jRbd2EmkVMsEv2ZCoIVHhW9EumxtOZ8A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 063931ad-240e-49b2-9cfa-08dbb8decb36
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 07:05:24.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyeDuMstZWAfxHTaovcptcyBQPAUATab8ZE9Wco8LB7eV1bHjTMCLxQ3YtgMvnruqaHE9s/eZuNuzHldeIslpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6450
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

kernel test robot noticed a -15.5% regression of fxmark.ssd_ext4_dbench_client_2_directio.works/sec on:


commit: 86bfbb7ce4f67a88df2639198169b685668e7349 ("sched/fair: Add lag based placement")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: fxmark
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1SSD
	media: ssd
	test: dbench_client
	fstype: ext4
	directio: directio
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops 24.7% improvement                                       |
| test machine     | 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory   |
| test parameters  | cpufreq_governor=performance                                                                         |
|                  | mode=process                                                                                         |
|                  | nr_task=100%                                                                                         |
|                  | test=context_switch1                                                                                 |
+------------------+------------------------------------------------------------------------------------------------------+
| testcase: change | filebench: filebench.sum_operations/s 1.7% improvement                                               |
| test machine     | 96 threads 2 sockets (Ice Lake) with 128G memory                                                     |
| test parameters  | cpufreq_governor=performance                                                                         |
|                  | disk=1HDD                                                                                            |
|                  | fs2=cifs                                                                                             |
|                  | fs=xfs                                                                                               |
|                  | test=webproxy.f                                                                                      |
+------------------+------------------------------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps -56.6% regression                                                   |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory   |
| test parameters  | cluster=cs-localhost                                                                                 |
|                  | cpufreq_governor=performance                                                                         |
|                  | ip=ipv4                                                                                              |
|                  | nr_threads=200%                                                                                      |
|                  | runtime=300s                                                                                         |
|                  | test=TCP_MAERTS                                                                                      |
+------------------+------------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309191404.2d18793e-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230919/202309191404.2d18793e-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase:
  gcc-12/performance/directio/1SSD/ext4/x86_64-rhel-8.3/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp5/dbench_client/fxmark

commit: 
  e0c2ff903c ("sched/fair: Remove sched_feat(START_DEBIT)")
  86bfbb7ce4 ("sched/fair: Add lag based placement")

e0c2ff903c320d3f 86bfbb7ce4f67a88df263919816 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1048 ±  3%      -7.9%     964.83 ±  5%  perf-c2c.HITM.local
     45457 ±  3%      -7.4%      42090 ±  2%  vmstat.system.cs
     15.56            -5.5%      14.71        iostat.cpu.system
      3.87            -5.4%       3.66 ±  2%  iostat.cpu.user
     53900            -3.5%      52031        proc-vmstat.nr_active_file
     53900            -3.5%      52031        proc-vmstat.nr_zone_active_file
      0.12 ± 26%      +0.0        0.16 ± 12%  perf-profile.children.cycles-pp.trigger_load_balance
      0.17 ± 15%      +0.1        0.24 ± 13%  perf-profile.children.cycles-pp.task_tick_mm_cid
      0.51 ±  8%      -0.1        0.42 ± 10%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.11 ± 30%      +0.0        0.15 ± 16%  perf-profile.self.cycles-pp.trigger_load_balance
      0.16 ± 14%      +0.1        0.24 ± 13%  perf-profile.self.cycles-pp.task_tick_mm_cid
     45359 ±  3%      -7.5%      41945 ±  2%  perf-stat.i.context-switches
      1899 ±  3%      -9.7%       1716 ±  2%  perf-stat.i.cpu-migrations
      0.56 ±  6%      +0.1        0.61 ±  3%  perf-stat.i.node-load-miss-rate%
     45294 ±  3%      -7.4%      41921 ±  2%  perf-stat.ps.context-switches
      1897 ±  3%      -9.6%       1714 ±  2%  perf-stat.ps.cpu-migrations
      0.02 ± 85%    +194.2%       0.07 ± 42%  perf-sched.sch_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
      0.01 ± 42%   +1044.4%       0.12 ± 22%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.53 ±135%    +411.6%       7.84 ± 49%  perf-sched.sch_delay.max.ms.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
      0.07 ±142%    +207.9%       0.22 ± 40%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.37 ± 45%    +521.8%       2.31 ±114%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.32 ±206%    +431.1%       7.02 ± 31%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±172%   +1433.7%       0.21 ±152%  perf-sched.sch_delay.max.ms.start_this_handle.jbd2_journal_start_reserved.__ext4_journal_start_reserved.ext4_convert_unwritten_io_end_vec
      2.75 ±  3%    +135.1%       6.47 ± 41%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ± 52%     +58.1%       0.06 ±  3%  perf-sched.total_sch_delay.average.ms
      4329 ± 18%     -18.6%       3524 ± 25%  perf-sched.total_wait_and_delay.max.ms
      4329 ± 18%     -18.6%       3524 ± 25%  perf-sched.total_wait_time.max.ms
      1.49 ± 73%     +90.0%       2.84 ±  8%  perf-sched.wait_and_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      8.00 ± 88%    +255.4%      28.42 ± 40%  perf-sched.wait_and_delay.max.ms.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
      0.26 ±113%    +338.7%       1.13 ± 51%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
      1.43 ± 73%     +90.5%       2.73 ±  9%  perf-sched.wait_time.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      7.97 ± 89%    +237.3%      26.89 ± 37%  perf-sched.wait_time.max.ms.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
    160405 ±  9%  +8.4e+08%  1.341e+12 ± 27%  sched_debug.cfs_rq:/.avg_vruntime.max
    138915 ± 11%  -9.3e+08% -1.286e+12        sched_debug.cfs_rq:/.avg_vruntime.min
      4758 ± 53%    +1e+10%  4.758e+11 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.50 ±  6%     +52.9%       0.77 ± 24%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.21 ±  3%     +35.0%       1.64 ± 15%  sched_debug.cfs_rq:/.h_nr_running.max
      5423 ± 83%  +1.8e+09%  9.877e+10 ± 64%  sched_debug.cfs_rq:/.left_vruntime.stddev
    352.93 ± 22%    +431.3%       1875 ±  8%  sched_debug.cfs_rq:/.load_avg.avg
      7305 ± 40%     +94.4%      14201 ±  3%  sched_debug.cfs_rq:/.load_avg.max
    869.49 ± 42%    +278.9%       3294 ±  7%  sched_debug.cfs_rq:/.load_avg.stddev
    160405 ±  9%  +8.4e+08%  1.341e+12 ± 27%  sched_debug.cfs_rq:/.min_vruntime.max
    138916 ± 11%  -9.3e+08% -1.286e+12        sched_debug.cfs_rq:/.min_vruntime.min
      4758 ± 53%    +1e+10%  4.758e+11 ± 11%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.40 ±  9%     +41.5%       0.57 ± 13%  sched_debug.cfs_rq:/.nr_running.avg
      1.08 ±  5%     +31.0%       1.41 ± 12%  sched_debug.cfs_rq:/.nr_running.max
      5423 ± 83%  +1.8e+09%  9.877e+10 ± 64%  sched_debug.cfs_rq:/.right_vruntime.stddev
      0.48 ±  6%     +56.7%       0.76 ± 26%  sched_debug.cpu.nr_running.avg
      1.20 ±  2%     +36.7%       1.64 ± 15%  sched_debug.cpu.nr_running.max
   1257368 ±  5%     -10.8%    1122186 ±  5%  sched_debug.cpu.nr_switches.max
   -453.52           -62.4%    -170.37        sched_debug.cpu.nr_uninterruptible.avg
   -128.88          -313.2%     274.83 ± 99%  sched_debug.cpu.nr_uninterruptible.max
  29305629          +300.0%  1.172e+08        sched_debug.sysctl_sched.sysctl_sched_features
    515.47           +10.9%     571.52        fxmark.ssd_ext4_dbench_client_18_directio.idle_sec
     47.68           +10.9%      52.89        fxmark.ssd_ext4_dbench_client_18_directio.idle_util
    355.55 ±  2%     -14.4%     304.50        fxmark.ssd_ext4_dbench_client_18_directio.iowait_sec
     2.89 ±  2%     -14.3%      28.18        fxmark.ssd_ext4_dbench_client_18_directio.iowait_util
     18.76            -9.1%      17.06        fxmark.ssd_ext4_dbench_client_2_directio.idle_sec
     49.58           +20.2%      59.62        fxmark.ssd_ext4_dbench_client_2_directio.iowait_sec
     41.75           +20.5%      50.30        fxmark.ssd_ext4_dbench_client_2_directio.iowait_util
      2.65           -10.1%       2.38        fxmark.ssd_ext4_dbench_client_2_directio.irq_sec
      2.23           -10.0%       2.01        fxmark.ssd_ext4_dbench_client_2_directio.irq_util
      1.30           -11.2%       1.16        fxmark.ssd_ext4_dbench_client_2_directio.softirq_sec
      1.09           -11.0%       0.97        fxmark.ssd_ext4_dbench_client_2_directio.softirq_util
     35.23           -17.5%      29.05 ±  2%  fxmark.ssd_ext4_dbench_client_2_directio.sys_sec
     29.67           -17.4%      24.51 ±  2%  fxmark.ssd_ext4_dbench_client_2_directio.sys_util
     11.23           -17.6%       9.26 ±  3%  fxmark.ssd_ext4_dbench_client_2_directio.user_sec
      9.46           -17.4%       7.81 ±  3%  fxmark.ssd_ext4_dbench_client_2_directio.user_util
    996.93           -15.5%     842.40 ±  3%  fxmark.ssd_ext4_dbench_client_2_directio.works/sec
     56.73           +25.6%      71.27        fxmark.ssd_ext4_dbench_client_4_directio.idle_sec
     23.81           +25.5%      29.87        fxmark.ssd_ext4_dbench_client_4_directio.idle_util
      3.89            -9.5%       3.52        fxmark.ssd_ext4_dbench_client_4_directio.irq_sec
      1.63            -9.6%       1.48        fxmark.ssd_ext4_dbench_client_4_directio.irq_util
      2.17           -14.6%       1.86        fxmark.ssd_ext4_dbench_client_4_directio.softirq_sec
      0.91 ±  2%     -14.7%       0.78        fxmark.ssd_ext4_dbench_client_4_directio.softirq_util
     54.18 ±  4%     -13.5%      46.85 ±  2%  fxmark.ssd_ext4_dbench_client_4_directio.sys_sec
     22.74 ±  4%     -13.7%      19.64 ±  2%  fxmark.ssd_ext4_dbench_client_4_directio.sys_util
     16.46 ±  3%     -11.2%      14.62 ±  2%  fxmark.ssd_ext4_dbench_client_4_directio.user_sec
      6.91 ±  3%     -11.3%       6.13 ±  2%  fxmark.ssd_ext4_dbench_client_4_directio.user_util
    477474 ±  3%     -85.5%      69214 ± 12%  fxmark.time.involuntary_context_switches


***************************************************************************************************
lkp-cpl-4sp2: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-11.1-x86_64-20220510.cgz/lkp-cpl-4sp2/context_switch1/will-it-scale

commit: 
  e0c2ff903c ("sched/fair: Remove sched_feat(START_DEBIT)")
  86bfbb7ce4 ("sched/fair: Add lag based placement")

e0c2ff903c320d3f 86bfbb7ce4f67a88df263919816 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     27.90            +1.4%      28.28        boot-time.dhcp
     17.83            +2.2%      18.21        turbostat.RAMWatt
      0.02            -0.0        0.02 ±  2%  mpstat.cpu.all.soft%
      9.30            +1.9       11.24        mpstat.cpu.all.usr%
   1588801 ±  3%     +94.7%    3093024 ±  3%  numa-numastat.node3.local_node
   1702856 ±  3%     +86.2%    3170127 ±  4%  numa-numastat.node3.numa_hit
    111078 ±  6%     -30.4%      77335 ± 42%  numa-numastat.node3.other_node
   7791689 ±  4%     +60.9%   12534430 ±  3%  vmstat.memory.cache
    292.33           +15.3%     337.00        vmstat.procs.r
  84550840           +24.2%   1.05e+08        vmstat.system.cs
  85803060           +24.7%   1.07e+08        will-it-scale.224.processes
    383048           +24.7%     477602        will-it-scale.per_process_ops
  85803060           +24.7%   1.07e+08        will-it-scale.workload
    518.00 ± 16%     -60.8%     203.00 ± 29%  perf-c2c.DRAM.local
     21295 ± 17%     -49.6%      10723 ± 35%  perf-c2c.HITM.local
    285.00 ±  5%     -28.9%     202.67 ± 24%  perf-c2c.HITM.remote
     21580 ± 17%     -49.4%      10925 ± 34%  perf-c2c.HITM.total
   2062818 ± 10%    +162.6%    5415996        meminfo.Active
   2062738 ± 10%    +162.6%    5415916        meminfo.Active(anon)
   7606438 ±  5%     +62.1%   12333478 ±  3%  meminfo.Cached
  29708938           +15.9%   34422163        meminfo.Committed_AS
   3255374 ±  7%     +42.2%    4628412 ±  8%  meminfo.Inactive
   3255194 ±  7%     +42.2%    4628232 ±  8%  meminfo.Inactive(anon)
   1345186 ±  9%     +46.0%    1963698 ±  8%  meminfo.Mapped
  10413302 ±  3%     +44.2%   15020958 ±  2%  meminfo.Memused
   4717773 ±  8%    +100.2%    9444812 ±  4%  meminfo.Shmem
  11143616 ±  3%     +44.9%   16150456 ±  2%  meminfo.max_used_kB
     10518 ± 10%     +17.0%      12303 ± 10%  numa-vmstat.node0.nr_kernel_stack
     32438 ±  5%     -25.3%      24235 ±  4%  numa-vmstat.node0.nr_mapped
      1345 ± 26%     +35.8%       1826 ± 13%  numa-vmstat.node0.nr_shmem
     30546 ± 70%     -99.2%     256.67 ± 90%  numa-vmstat.node1.nr_active_anon
     12128 ±  8%     -15.7%      10228 ±  3%  numa-vmstat.node1.nr_kernel_stack
     41219 ±  3%     -28.4%      29518 ± 10%  numa-vmstat.node1.nr_mapped
     31395 ± 70%     -98.7%     414.33 ± 88%  numa-vmstat.node1.nr_shmem
     24163 ±  4%     -11.6%      21365 ±  3%  numa-vmstat.node1.nr_slab_unreclaimable
     30546 ± 70%     -99.2%     256.67 ± 90%  numa-vmstat.node1.nr_zone_active_anon
    469078 ± 12%    +188.7%    1354332        numa-vmstat.node3.nr_active_anon
   1129498 ±  8%    +108.8%    2358542 ±  4%  numa-vmstat.node3.nr_file_pages
  11058299           -11.1%    9830943        numa-vmstat.node3.nr_free_pages
    709774 ±  9%     +48.7%    1055523 ± 10%  numa-vmstat.node3.nr_inactive_anon
    228992 ± 11%     +78.5%     408834 ±  9%  numa-vmstat.node3.nr_mapped
   1129341 ±  8%    +108.8%    2358253 ±  4%  numa-vmstat.node3.nr_shmem
    469077 ± 12%    +188.7%    1354330        numa-vmstat.node3.nr_zone_active_anon
    709774 ±  9%     +48.7%    1055522 ± 10%  numa-vmstat.node3.nr_zone_inactive_anon
   1702835 ±  3%     +86.2%    3170187 ±  4%  numa-vmstat.node3.numa_hit
   1588780 ±  3%     +94.7%    3093085 ±  3%  numa-vmstat.node3.numa_local
    111078 ±  6%     -30.4%      77335 ± 42%  numa-vmstat.node3.numa_other
    516760 ± 10%    +161.9%    1353199        proc-vmstat.nr_active_anon
   4629486            -2.5%    4514455        proc-vmstat.nr_dirty_background_threshold
   9270292            -2.5%    9039950        proc-vmstat.nr_dirty_threshold
   1901822 ±  5%     +62.1%    3083178 ±  3%  proc-vmstat.nr_file_pages
  46543443            -2.5%   45391452        proc-vmstat.nr_free_pages
    812636 ±  7%     +42.5%    1157608 ±  8%  proc-vmstat.nr_inactive_anon
    336010 ±  9%     +46.2%     491211 ±  8%  proc-vmstat.nr_mapped
     16849            +1.8%      17155        proc-vmstat.nr_page_table_pages
   1179654 ±  8%    +100.1%    2361011 ±  4%  proc-vmstat.nr_shmem
     45808            +5.5%      48350        proc-vmstat.nr_slab_reclaimable
    516760 ± 10%    +161.9%    1353199        proc-vmstat.nr_zone_active_anon
    812636 ±  7%     +42.5%    1157608 ±  8%  proc-vmstat.nr_zone_inactive_anon
    462879 ±  3%    +115.2%     995994 ±  7%  proc-vmstat.numa_hint_faults
    376385 ±  4%    +115.5%     810972 ±  8%  proc-vmstat.numa_hint_faults_local
   2738437 ±  3%     +48.2%    4059353 ±  2%  proc-vmstat.numa_hit
   2387639 ±  4%     +55.5%    3711759 ±  3%  proc-vmstat.numa_local
    846973 ±  3%     +59.5%    1351057 ±  5%  proc-vmstat.numa_pte_updates
   1309449 ±  8%    +102.8%    2655907 ±  3%  proc-vmstat.pgactivate
   2879073 ±  3%     +46.6%    4220187 ±  2%  proc-vmstat.pgalloc_normal
   2074779           +29.4%    2684996 ±  2%  proc-vmstat.pgfault
   2726656            -6.0%    2562304 ±  4%  proc-vmstat.unevictable_pgs_scanned
    201985 ± 22%     +29.6%     261678 ± 11%  numa-meminfo.node0.AnonPages.max
     10517 ± 10%     +17.0%      12302 ± 10%  numa-meminfo.node0.KernelStack
    130426 ±  5%     -25.5%      97185 ±  4%  numa-meminfo.node0.Mapped
      5380 ± 26%     +35.8%       7306 ± 13%  numa-meminfo.node0.Shmem
    116873 ± 18%     +18.9%     138931 ± 10%  numa-meminfo.node0.Slab
    122169 ± 70%     -99.2%       1026 ± 89%  numa-meminfo.node1.Active
    122143 ± 70%     -99.2%       1026 ± 89%  numa-meminfo.node1.Active(anon)
     12127 ±  8%     -15.7%      10227 ±  3%  numa-meminfo.node1.KernelStack
    165582 ±  3%     -28.4%     118482 ± 10%  numa-meminfo.node1.Mapped
     96656 ±  4%     -11.6%      85462 ±  3%  numa-meminfo.node1.SUnreclaim
    125513 ± 70%     -98.7%       1658 ± 88%  numa-meminfo.node1.Shmem
    191453 ±  3%     -19.9%     153306 ± 21%  numa-meminfo.node1.Slab
   1876280 ± 12%    +188.6%    5415245        numa-meminfo.node3.Active
   1876280 ± 12%    +188.6%    5415245        numa-meminfo.node3.Active(anon)
    442998 ± 17%     +23.5%     547217        numa-meminfo.node3.AnonPages.max
   4516666 ±  8%    +108.9%    9433700 ±  4%  numa-meminfo.node3.FilePages
   2837681 ±  9%     +48.8%    4223489 ±  9%  numa-meminfo.node3.Inactive
   2837681 ±  9%     +48.8%    4223489 ±  9%  numa-meminfo.node3.Inactive(anon)
    912783 ± 11%     +79.2%    1636140 ±  9%  numa-meminfo.node3.Mapped
  44233750           -11.1%   39323843        numa-meminfo.node3.MemFree
   5249336 ±  7%     +93.5%   10159243 ±  4%  numa-meminfo.node3.MemUsed
   4516038 ±  8%    +108.9%    9432543 ±  4%  numa-meminfo.node3.Shmem
  33654613         +1013.5%  3.748e+08 ± 14%  sched_debug.cfs_rq:/.avg_vruntime.avg
  34041261        +34504.8%  1.178e+10 ± 20%  sched_debug.cfs_rq:/.avg_vruntime.max
  31346703           -14.2%   26896148 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.min
    244236 ±  7%  +6.2e+05%  1.508e+09 ± 13%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      2.22 ±  9%     +22.5%       2.72 ±  7%  sched_debug.cfs_rq:/.h_nr_running.max
     89225 ±141%  +1.6e+05%  1.389e+08 ±133%  sched_debug.cfs_rq:/.left_vruntime.stddev
      5667 ±  6%    +400.1%      28345 ±111%  sched_debug.cfs_rq:/.load.avg
     49.07 ± 52%    +298.4%     195.50 ± 40%  sched_debug.cfs_rq:/.load_avg.avg
    593.44 ± 67%    +143.1%       1442 ± 26%  sched_debug.cfs_rq:/.load_avg.stddev
  33654613         +1013.5%  3.748e+08 ± 14%  sched_debug.cfs_rq:/.min_vruntime.avg
  34041261        +34504.8%  1.178e+10 ± 20%  sched_debug.cfs_rq:/.min_vruntime.max
  31346704           -14.2%   26896148 ±  5%  sched_debug.cfs_rq:/.min_vruntime.min
    244236 ±  7%  +6.2e+05%  1.508e+09 ± 13%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.05 ±  3%     -27.7%       0.04 ±  7%  sched_debug.cfs_rq:/.nr_running.stddev
     89225 ±141%  +1.6e+05%  1.389e+08 ±133%  sched_debug.cfs_rq:/.right_vruntime.stddev
      1160           +14.9%       1333        sched_debug.cfs_rq:/.runnable_avg.avg
    797.61 ± 10%     +29.4%       1031 ±  5%  sched_debug.cfs_rq:/.runnable_avg.min
    568.00           +23.0%     698.41        sched_debug.cfs_rq:/.util_est_enqueued.avg
    190.22 ± 15%     +91.2%     363.61 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.min
    212.33           +10.1%     233.86        sched_debug.cfs_rq:/.util_est_enqueued.stddev
    689405           +12.3%     774171        sched_debug.cpu.avg_idle.avg
     30867 ± 11%     +72.8%      53341 ± 32%  sched_debug.cpu.avg_idle.min
     62.94 ±  2%     -55.8%      27.79 ±  2%  sched_debug.cpu.clock.stddev
      0.00 ±  2%     -35.8%       0.00 ± 32%  sched_debug.cpu.next_balance.stddev
      1.10           +18.8%       1.30        sched_debug.cpu.nr_running.avg
      2.06 ± 10%     +32.4%       2.72 ± 10%  sched_debug.cpu.nr_running.max
  56165887           +23.7%   69450178        sched_debug.cpu.nr_switches.avg
  59405269           +21.8%   72371938        sched_debug.cpu.nr_switches.max
  50439136           -23.2%   38752422 ±  4%  sched_debug.cpu.nr_switches.min
   1557683 ±  9%     +76.1%    2743805 ±  6%  sched_debug.cpu.nr_switches.stddev
      0.42 ±  4%     -63.9%       0.15 ±107%  sched_debug.rt_rq:.rt_time.avg
     94.66 ±  4%     -63.9%      34.13 ±107%  sched_debug.rt_rq:.rt_time.max
      6.31 ±  4%     -63.9%       2.28 ±107%  sched_debug.rt_rq:.rt_time.stddev
  29305629          +300.0%  1.172e+08        sched_debug.sysctl_sched.sysctl_sched_features
      0.01 ± 29%  +11066.7%       1.12 ±137%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 46%    +150.0%       0.01 ± 19%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.14 ± 15%     -60.4%       0.05 ±  5%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00          +4e+05%      15.89 ±105%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  3%     +51.2%       0.02 ± 11%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
     85.47 ± 39%     -71.8%      24.07 ±  9%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 70%  +16482.1%       1.55 ±139%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
    102.39 ±141%    -100.0%       0.05 ± 18%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  7%     -70.0%       0.00 ±141%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±  9%   +7440.0%       1.13 ±135%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 72%  +9.1e+05%      63.46 ±141%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 35%    +602.4%       0.10 ± 71%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1817 ± 25%     -50.4%     900.90 ± 47%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.01 ± 24%  +2.1e+06%     221.70 ±108%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±  5%     +67.3%       0.03 ± 21%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      1922 ± 57%     -70.1%     575.01 ± 47%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.02 ±  6%    +540.0%       0.12 ± 64%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 70%  +15410.0%       1.55 ±138%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.07 ± 18%     -59.3%       0.03 ±  2%  perf-sched.total_sch_delay.average.ms
      4274 ± 19%     -40.3%       2553 ± 14%  perf-sched.total_sch_delay.max.ms
      0.25 ± 14%     -56.1%       0.11 ±  3%  perf-sched.total_wait_and_delay.average.ms
   8189057 ±  9%    +113.7%   17497214 ±  4%  perf-sched.total_wait_and_delay.count.ms
      0.17 ± 12%     -54.6%       0.08 ±  5%  perf-sched.total_wait_time.average.ms
     82.16 ± 75%     -99.7%       0.26 ± 60%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.13 ±  7%     -55.1%       0.06        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.31 ± 14%     -57.2%       0.13 ±  3%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.83 ± 31%   +2896.9%      84.79 ± 42%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    237.34 ± 33%     -57.8%     100.05 ± 25%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
   3942210 ± 10%    +118.9%    8628293 ±  4%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
   4245920 ±  8%    +108.9%    8868039 ±  4%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.00 ± 49%    +177.8%      16.67 ± 15%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    437.33 ± 66%     -99.5%       2.01 ± 78%  perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      3.56 ±  3%     -13.5%       3.08 ±  6%  perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      4.99 ± 16%  +13808.2%     694.67 ± 66%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      3871 ± 56%     -62.1%       1466 ± 26%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      5387 ±  7%     -21.4%       4234 ± 19%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    668.96 ± 70%    -100.0%       0.01 ± 31%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.02 ± 35%     -79.3%       0.00 ±141%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.task_work_run.exit_to_user_mode_loop
     82.16 ± 75%     -99.7%       0.26 ± 60%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      1.78 ±  3%     -43.6%       1.00 ± 70%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 60%  +1.1e+06%     160.22 ± 94%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.19 ± 29%    +385.8%       0.94 ± 95%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.12 ±  7%     -57.8%       0.05 ±  2%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.17 ± 14%     -54.8%       0.08 ±  2%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.83 ± 31%   +2338.7%      68.90 ± 30%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    151.87 ± 30%     -50.0%      75.98 ± 30%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    669.48 ± 70%    -100.0%       0.03 ± 83%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.02 ± 54%     -84.0%       0.00 ±141%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.task_work_run.exit_to_user_mode_loop
    437.33 ± 66%     -99.5%       2.01 ± 78%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      3.55 ±  3%     -45.0%       1.95 ± 70%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.06 ± 61%  +2.7e+06%       1737 ± 74%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.82 ± 54%   +1170.4%      10.36 ±123%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      4.99 ± 16%  +10104.3%     508.99 ± 42%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      2046 ± 49%     -56.4%     891.66 ± 18%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      5387 ±  7%     -21.4%       4234 ± 19%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.67 ±  4%     -35.6%       1.07 ± 17%  perf-stat.i.MPKI
      1.21            -0.0        1.17        perf-stat.i.branch-miss-rate%
      1.02 ±  9%      +0.5        1.53 ± 25%  perf-stat.i.cache-miss-rate%
 1.055e+09 ±  5%     -33.8%  6.982e+08 ± 13%  perf-stat.i.cache-references
  85605365           +31.6%  1.126e+08 ±  3%  perf-stat.i.context-switches
      1.15            +2.5%       1.18        perf-stat.i.cpi
    224043            +4.5%     234077 ±  3%  perf-stat.i.cpu-clock
 7.343e+11            +4.8%  7.692e+11 ±  3%  perf-stat.i.cpu-cycles
    357.38            -4.9%     339.95        perf-stat.i.cpu-migrations
     84833           +13.1%      95986 ±  7%  perf-stat.i.cycles-between-cache-misses
   1578257 ±  8%    +140.7%    3799592 ± 24%  perf-stat.i.dTLB-load-misses
    111475 ± 12%    +127.9%     254065 ± 23%  perf-stat.i.dTLB-store-misses
 1.086e+11            +4.0%   1.13e+11 ±  3%  perf-stat.i.dTLB-stores
     31.60           +10.1       41.65        perf-stat.i.iTLB-load-miss-rate%
 2.652e+08           +39.6%  3.702e+08 ±  4%  perf-stat.i.iTLB-load-misses
 5.808e+08           -10.5%  5.198e+08 ±  3%  perf-stat.i.iTLB-loads
      2414           -27.1%       1760        perf-stat.i.instructions-per-iTLB-miss
      0.87            -2.7%       0.85        perf-stat.i.ipc
    427.05           +20.6%     515.09        perf-stat.i.metric.K/sec
      1865            -1.5%       1837        perf-stat.i.metric.M/sec
      6038           +33.9%       8086 ± 17%  perf-stat.i.minor-faults
     74.58           +12.9       87.50 ±  7%  perf-stat.i.node-load-miss-rate%
   4028900            +9.5%    4411024 ±  5%  perf-stat.i.node-load-misses
     99912 ± 31%    +113.4%     213203 ± 36%  perf-stat.i.node-stores
      6038           +33.9%       8086 ± 17%  perf-stat.i.page-faults
    224043            +4.5%     234077 ±  3%  perf-stat.i.task-clock
      1.65 ±  5%     -36.0%       1.05 ± 18%  perf-stat.overall.MPKI
      1.21            -0.1        1.15        perf-stat.overall.branch-miss-rate%
      0.94 ±  4%      +0.9        1.88 ± 23%  perf-stat.overall.cache-miss-rate%
      1.15            +2.5%       1.17        perf-stat.overall.cpi
     74120           -16.3%      62022 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  8%      +0.0        0.00 ± 11%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ± 12%      +0.0        0.00 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
     31.35           +10.3       41.63        perf-stat.overall.iTLB-load-miss-rate%
      2415           -26.3%       1779        perf-stat.overall.instructions-per-iTLB-miss
      0.87            -2.4%       0.85        perf-stat.overall.ipc
     65.82 ±  2%      -6.1       59.75        perf-stat.overall.node-load-miss-rate%
     87.47 ±  4%      -9.4       78.04 ±  5%  perf-stat.overall.node-store-miss-rate%
   2251263           -21.5%    1768325        perf-stat.overall.path-length
 1.518e+09            -5.2%  1.439e+09        perf-stat.ps.branch-misses
   9872460           +19.9%   11837554 ±  2%  perf-stat.ps.cache-misses
 1.051e+09 ±  5%     -37.4%  6.581e+08 ± 17%  perf-stat.ps.cache-references
  85297490           +24.3%   1.06e+08        perf-stat.ps.context-switches
    355.72           -21.1%     280.58 ±  9%  perf-stat.ps.cpu-migrations
   1598361 ±  8%    +139.1%    3821899 ± 10%  perf-stat.ps.dTLB-load-misses
 1.808e+11            -2.0%  1.771e+11        perf-stat.ps.dTLB-loads
    111078 ± 12%    +131.1%     256716 ±  5%  perf-stat.ps.dTLB-store-misses
 2.643e+08           +32.8%  3.509e+08        perf-stat.ps.iTLB-load-misses
 5.788e+08           -15.0%   4.92e+08        perf-stat.ps.iTLB-loads
 6.384e+11            -2.2%  6.246e+11        perf-stat.ps.instructions
      6015           +32.8%       7986 ±  3%  perf-stat.ps.minor-faults
   4015277            +5.9%    4253942        perf-stat.ps.node-load-misses
   2085542 ±  4%     +37.4%    2865700        perf-stat.ps.node-loads
    692803 ±  4%     +12.6%     780367 ±  9%  perf-stat.ps.node-store-misses
     99472 ± 31%    +119.5%     218355 ± 17%  perf-stat.ps.node-stores
      6015           +32.8%       7986 ±  3%  perf-stat.ps.page-faults
 1.932e+14            -2.1%  1.892e+14        perf-stat.total.instructions
     57.13           -10.9       46.19        perf-profile.calltrace.cycles-pp.read
     48.87            -9.8       39.07        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     47.93            -9.7       38.22        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     27.01            -9.3       17.66        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
     26.67            -9.3       17.38        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
     38.22            -9.3       28.96        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     27.92            -9.2       18.70        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
     28.40            -9.1       19.33        perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
     25.91            -8.9       17.03        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
     27.67            -8.8       18.86        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
     41.64            -8.4       33.21        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     42.84            -8.3       34.58        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     32.86            -7.9       24.91        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.67            -6.9       28.76        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     36.93            -6.7       30.27        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     14.75            -5.2        9.57 ±  2%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
     13.05            -5.0        8.08 ±  2%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
     12.82            -4.9        7.93 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
     10.57            -2.6        7.97        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
      6.48            -2.5        3.98 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      4.54            -1.7        2.82        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.pipe_read.vfs_read
      4.54            -1.4        3.14        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.pipe_read.vfs_read
      3.20            -1.2        2.01 ±  2%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      4.28            -1.2        3.11        perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      3.91            -1.1        2.78        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.86            -1.1        2.77        perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common
      3.60            -1.1        2.52        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.79            -0.9        1.86        perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function
      4.90            -0.9        3.98        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
      2.16 ±  2%      -0.9        1.27 ±  5%  perf-profile.calltrace.cycles-pp.update_curr.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      2.46            -0.7        1.72        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.13 ±  2%      -0.7        1.40 ±  2%  perf-profile.calltrace.cycles-pp.reweight_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      2.11            -0.7        1.40        perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.pipe_read
      1.72 ±  3%      -0.7        1.03 ±  2%  perf-profile.calltrace.cycles-pp.perf_tp_event.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.98 ±  2%      -0.7        1.31        perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.pipe_read.vfs_read
      2.03 ±  2%      -0.6        1.38 ±  2%  perf-profile.calltrace.cycles-pp.reweight_entity.dequeue_task_fair.__schedule.schedule.pipe_read
      1.96            -0.6        1.33        perf-profile.calltrace.cycles-pp.__switch_to_asm.read
      1.38 ±  4%      -0.6        0.76 ±  4%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      1.48            -0.5        0.97 ±  2%  perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
      1.35            -0.5        0.86 ±  2%  perf-profile.calltrace.cycles-pp.os_xsave.read
      1.35 ±  4%      -0.5        0.86 ±  3%  perf-profile.calltrace.cycles-pp.update_curr.reweight_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      1.38            -0.5        0.90        perf-profile.calltrace.cycles-pp.___perf_sw_event.prepare_task_switch.__schedule.schedule.pipe_read
      1.38            -0.5        0.90        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      1.22 ±  3%      -0.4        0.83 ±  2%  perf-profile.calltrace.cycles-pp.update_curr.reweight_entity.dequeue_task_fair.__schedule.schedule
      0.95            -0.4        0.57        perf-profile.calltrace.cycles-pp.__switch_to.read
      0.84            -0.3        0.51        perf-profile.calltrace.cycles-pp.__calc_delta.update_curr.reweight_entity.enqueue_task_fair.activate_task
      1.18            -0.3        0.87 ±  2%  perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_task_fair.__schedule.schedule.pipe_read
      0.98            -0.3        0.67        perf-profile.calltrace.cycles-pp.perf_trace_buf_alloc.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.82            -0.3        0.52        perf-profile.calltrace.cycles-pp.__calc_delta.update_curr.reweight_entity.dequeue_task_fair.__schedule
      0.81            -0.3        0.53        perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up
      2.04            -0.3        1.76 ±  3%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.88            -0.3        0.61 ±  2%  perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      0.86 ±  6%      -0.3        0.59 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.80            -0.3        0.53        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      1.15            -0.2        0.92        perf-profile.calltrace.cycles-pp.place_entity.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.83 ±  2%      -0.2        0.60 ±  3%  perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_task_fair.__schedule.schedule.pipe_read
      1.50 ±  2%      -0.1        1.37        perf-profile.calltrace.cycles-pp.check_preempt_curr.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.23            -0.1        1.14        perf-profile.calltrace.cycles-pp.check_preempt_wakeup.check_preempt_curr.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      0.84 ±  2%      -0.0        0.80        perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.58            -0.0        0.55        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.60            -0.0        0.58        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
      1.00            +0.1        1.13        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
      1.25            +0.1        1.39        perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.58            +0.1        0.72 ±  3%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read
      0.57            +0.2        0.74        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.94            +0.2        1.11 ±  3%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_write.ksys_write.do_syscall_64
      0.58 ±  2%      +0.2        0.76 ±  3%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.61 ±  2%      +0.2        0.81 ±  3%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.15            +0.2        1.35        perf-profile.calltrace.cycles-pp.update_load_avg.set_next_entity.pick_next_task_fair.__schedule.schedule
      0.93 ±  2%      +0.2        1.16 ±  3%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_read.ksys_read.do_syscall_64
      1.00            +0.2        1.25        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
      1.10            +0.3        1.38        perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      1.17            +0.3        1.48        perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.41            +0.3        1.76        perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.08            +0.4        1.44 ±  3%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.63            +0.4        2.01        perf-profile.calltrace.cycles-pp.__entry_text_start.write
      1.65            +0.4        2.04        perf-profile.calltrace.cycles-pp.__entry_text_start.read
      1.09            +0.5        1.62 ±  2%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.55        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      0.00            +0.6        0.55        perf-profile.calltrace.cycles-pp.current_time.atime_needs_update.touch_atime.pipe_read.vfs_read
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.__switch_to.write
      0.00            +0.6        0.58 ±  3%  perf-profile.calltrace.cycles-pp.update_entity_lag.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.00            +0.6        0.58 ±  2%  perf-profile.calltrace.cycles-pp.anon_pipe_buf_release.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00            +0.6        0.60        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write
      0.00            +0.7        0.74 ±  3%  perf-profile.calltrace.cycles-pp.update_load_avg.put_prev_entity.pick_next_task_fair.__schedule.schedule
      0.00            +0.8        0.78 ±  3%  perf-profile.calltrace.cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_syscall_64
      2.86            +0.8        3.68        perf-profile.calltrace.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00            +0.8        0.83 ±  3%  perf-profile.calltrace.cycles-pp.___perf_sw_event.prepare_task_switch.__schedule.schedule.exit_to_user_mode_loop
      0.00            +0.8        0.84 ±  2%  perf-profile.calltrace.cycles-pp.os_xsave.write
      3.43            +1.1        4.49        perf-profile.calltrace.cycles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.17 ±  2%  perf-profile.calltrace.cycles-pp.__switch_to_asm.write
      0.00            +1.3        1.27 ±  2%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
      0.00            +1.3        1.33 ±  3%  perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_loop
      0.00            +1.4        1.43 ±  3%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_loop
      0.00            +2.8        2.82 ±  2%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
      0.00            +4.1        4.11 ±  3%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
     38.65            +7.2       45.82        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     39.55            +7.3       46.83        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.56 ±  2%     +10.2       10.75 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.58           +10.6       11.17 ±  2%  perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     43.02           +10.7       53.68        perf-profile.calltrace.cycles-pp.write
      0.63           +11.0       11.68 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.96           +13.4       14.36 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.15           +13.5       14.68 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     57.23           -10.9       46.28        perf-profile.children.cycles-pp.read
     27.03            -9.4       17.68        perf-profile.children.cycles-pp.__wake_up_common
     26.71            -9.3       17.40        perf-profile.children.cycles-pp.autoremove_wake_function
     38.45            -9.3       29.16        perf-profile.children.cycles-pp.pipe_read
     27.97            -9.2       18.76        perf-profile.children.cycles-pp.__wake_up_common_lock
     26.00            -8.9       17.08        perf-profile.children.cycles-pp.try_to_wake_up
     41.69            -8.4       33.27        perf-profile.children.cycles-pp.vfs_read
     42.86            -8.3       34.60        perf-profile.children.cycles-pp.ksys_read
     32.96            -7.9       25.09        perf-profile.children.cycles-pp.pipe_write
     35.73            -6.9       28.86        perf-profile.children.cycles-pp.vfs_write
     36.96            -6.7       30.31        perf-profile.children.cycles-pp.ksys_write
     14.78            -5.2        9.58 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
     13.07            -5.0        8.09 ±  2%  perf-profile.children.cycles-pp.activate_task
     12.85            -4.9        7.95 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      6.69            -2.6        4.06 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
     10.59            -2.6        7.99        perf-profile.children.cycles-pp.dequeue_task_fair
     88.53            -2.6       85.98        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     86.70            -2.6       84.15        perf-profile.children.cycles-pp.do_syscall_64
      7.35            -1.9        5.46 ±  2%  perf-profile.children.cycles-pp.update_curr
      4.21 ±  2%      -1.4        2.81 ±  2%  perf-profile.children.cycles-pp.reweight_entity
      3.22            -1.2        2.03 ±  2%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      4.29            -1.2        3.12        perf-profile.children.cycles-pp.select_task_rq
      3.88            -1.1        2.78        perf-profile.children.cycles-pp.select_task_rq_fair
      6.86            -1.1        5.80        perf-profile.children.cycles-pp.update_load_avg
      2.87            -1.0        1.90        perf-profile.children.cycles-pp.select_idle_sibling
      5.04            -0.9        4.11        perf-profile.children.cycles-pp.dequeue_entity
      2.52            -0.8        1.76        perf-profile.children.cycles-pp.prepare_to_wait_event
      1.73 ±  3%      -0.7        1.04 ±  2%  perf-profile.children.cycles-pp.perf_tp_event
      1.32            -0.7        0.66 ±  2%  perf-profile.children.cycles-pp.update_min_vruntime
      1.65            -0.6        1.04        perf-profile.children.cycles-pp.__calc_delta
      2.31            -0.6        1.70        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.83            -0.5        1.30 ±  3%  perf-profile.children.cycles-pp.update_cfs_group
      1.37            -0.5        0.90        perf-profile.children.cycles-pp.update_rq_clock
      2.28            -0.5        1.82        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      1.13            -0.4        0.73        perf-profile.children.cycles-pp.sched_clock_cpu
      1.01            -0.3        0.67        perf-profile.children.cycles-pp.sched_clock
      1.01            -0.3        0.69 ±  2%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.68 ±  6%      -0.3        0.36 ±  3%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.80            -0.3        0.49        perf-profile.children.cycles-pp.avg_vruntime
      0.71            -0.3        0.41        perf-profile.children.cycles-pp._find_next_and_bit
      0.83            -0.3        0.54        perf-profile.children.cycles-pp.select_idle_cpu
      0.90            -0.3        0.62        perf-profile.children.cycles-pp.native_sched_clock
      1.17            -0.2        0.92        perf-profile.children.cycles-pp.place_entity
      1.22 ±  5%      -0.2        0.98 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      0.44            -0.2        0.22 ±  2%  perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.70            -0.2        0.48 ±  6%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.61            -0.2        0.40 ±  2%  perf-profile.children.cycles-pp.finish_wait
      2.13            -0.2        1.93 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.62 ± 10%      -0.2        0.42 ± 11%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.61 ±  5%      -0.1        0.47 ± 13%  perf-profile.children.cycles-pp.cpuacct_charge
      0.37            -0.1        0.23 ±  5%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      1.52 ±  2%      -0.1        1.38        perf-profile.children.cycles-pp.check_preempt_curr
      0.34            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.__bitmap_and
      0.33 ±  3%      -0.1        0.22        perf-profile.children.cycles-pp.check_spread
      0.33            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.44            -0.1        0.35 ±  3%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      1.27            -0.1        1.19        perf-profile.children.cycles-pp.check_preempt_wakeup
      0.57            -0.1        0.50        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.34            -0.1        0.27 ±  3%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.34 ±  2%      -0.1        0.27 ±  3%  perf-profile.children.cycles-pp.available_idle_cpu
      0.29 ±  2%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.mm_cid_get
      0.54            -0.1        0.48        perf-profile.children.cycles-pp.__list_add_valid
      0.15 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.perf_trace_run_bpf_submit
      0.26            -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.init_wait_entry
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.make_vfsuid
      0.09 ±  5%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.write@plt
      0.07 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.perf_exclude_event
      0.30            +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.__x64_sys_read
      0.12 ±  4%      +0.0        0.15        perf-profile.children.cycles-pp.switch_ldt
      0.11 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.rb_next
      0.91            +0.0        0.95        perf-profile.children.cycles-pp.mutex_unlock
      0.33            +0.0        0.37        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.15            +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.rb_erase
      0.57            +0.0        0.62        perf-profile.children.cycles-pp.finish_task_switch
      0.28 ±  3%      +0.0        0.33 ±  3%  perf-profile.children.cycles-pp.__x64_sys_write
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__wake_up_sync_key
      0.23 ±  3%      +0.1        0.28        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.make_vfsgid
      0.17 ±  2%      +0.1        0.23 ±  8%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.06 ±  7%      +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.rb_insert_color
      0.15 ±  3%      +0.1        0.22 ± 19%  perf-profile.children.cycles-pp.scheduler_tick
      0.29            +0.1        0.36        perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.68            +0.1        0.75        perf-profile.children.cycles-pp.pick_next_entity
      0.11 ±  4%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.rw_verify_area
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.evlist__parse_sample
      0.05            +0.1        0.13        perf-profile.children.cycles-pp.cr4_update_irqsoff
      0.23 ±  2%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.check_cfs_rq_runtime
      0.29            +0.1        0.38        perf-profile.children.cycles-pp.__enqueue_entity
      0.36 ±  2%      +0.1        0.46        perf-profile.children.cycles-pp.child
      0.29 ±  7%      +0.1        0.39 ±  8%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.21 ±  2%      +0.1        0.31 ±  5%  perf-profile.children.cycles-pp.aa_file_perm
      0.53            +0.1        0.64 ±  5%  perf-profile.children.cycles-pp.rep_movs_alternative
      0.00            +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.39 ±  3%      +0.1        0.51        perf-profile.children.cycles-pp.testcase
      0.45 ±  2%      +0.1        0.56        perf-profile.children.cycles-pp.__get_task_ioprio
      0.52            +0.1        0.64        perf-profile.children.cycles-pp.__wrgsbase_inactive
      1.05            +0.1        1.18        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.00            +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.__ordered_events__flush
      1.02            +0.1        1.16        perf-profile.children.cycles-pp.atime_needs_update
      1.42 ±  2%      +0.1        1.56 ±  2%  perf-profile.children.cycles-pp.__fget_light
      1.25            +0.1        1.40        perf-profile.children.cycles-pp.touch_atime
      0.15 ±  6%      +0.1        0.29 ±  8%  perf-profile.children.cycles-pp.queue_event
      0.16 ± 12%      +0.2        0.31        perf-profile.children.cycles-pp.inode_needs_update_time
      0.15 ±  6%      +0.2        0.30 ±  6%  perf-profile.children.cycles-pp.ordered_events__queue
      0.65            +0.2        0.81        perf-profile.children.cycles-pp.copyin
      0.58            +0.2        0.74        perf-profile.children.cycles-pp.__dequeue_entity
      0.15 ±  6%      +0.2        0.31 ±  7%  perf-profile.children.cycles-pp.process_simple
      1.66            +0.2        1.83        perf-profile.children.cycles-pp.mutex_lock
      1.57            +0.2        1.74        perf-profile.children.cycles-pp.__fdget_pos
      0.73            +0.2        0.91 ±  2%  perf-profile.children.cycles-pp.copyout
      0.62            +0.2        0.80        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.43 ±  9%      +0.2        0.63 ±  5%  perf-profile.children.cycles-pp.set_next_buddy
      0.61 ±  2%      +0.2        0.85        perf-profile.children.cycles-pp.current_time
      0.34            +0.2        0.58 ±  2%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      1.01            +0.3        1.27        perf-profile.children.cycles-pp._copy_to_iter
      0.24            +0.3        0.51        perf-profile.children.cycles-pp.clear_buddies
      1.13            +0.3        1.41        perf-profile.children.cycles-pp._copy_from_iter
      0.00            +0.3        0.28 ±  2%  perf-profile.children.cycles-pp.resched_curr
      1.63            +0.3        1.92        perf-profile.children.cycles-pp.__switch_to
      1.40            +0.3        1.70        perf-profile.children.cycles-pp.os_xsave
      1.19            +0.3        1.49        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.19            +0.3        1.50        perf-profile.children.cycles-pp.copy_page_to_iter
      1.45            +0.3        1.76        perf-profile.children.cycles-pp.___perf_sw_event
      0.49 ±  2%      +0.3        0.81 ±  2%  perf-profile.children.cycles-pp.file_update_time
      0.15 ±  5%      +0.3        0.48 ±  5%  perf-profile.children.cycles-pp.reader__read_event
      0.17 ±  8%      +0.3        0.50 ±  4%  perf-profile.children.cycles-pp.__cmd_record
      0.15 ±  5%      +0.3        0.48 ±  4%  perf-profile.children.cycles-pp.record__finish_output
      0.15 ±  5%      +0.3        0.48 ±  4%  perf-profile.children.cycles-pp.perf_session__process_events
      1.43            +0.4        1.79        perf-profile.children.cycles-pp.copy_page_from_iter
      1.90            +0.4        2.30 ±  3%  perf-profile.children.cycles-pp.apparmor_file_permission
      2.11            +0.5        2.60        perf-profile.children.cycles-pp.__entry_text_start
      2.11            +0.5        2.60        perf-profile.children.cycles-pp.__switch_to_asm
      2.05 ±  2%      +0.5        2.58        perf-profile.children.cycles-pp.prepare_task_switch
      0.00            +0.6        0.58 ±  3%  perf-profile.children.cycles-pp.update_entity_lag
      2.24            +0.7        2.93        perf-profile.children.cycles-pp.set_next_entity
      2.95            +0.7        3.68        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      2.21            +0.9        3.14 ±  3%  perf-profile.children.cycles-pp.security_file_permission
      3.54            +1.0        4.49        perf-profile.children.cycles-pp.switch_fpu_return
      0.46            +1.2        1.67 ±  2%  perf-profile.children.cycles-pp.put_prev_entity
      4.69            +1.3        5.98        perf-profile.children.cycles-pp.switch_mm_irqs_off
     28.38            +1.4       29.79        perf-profile.children.cycles-pp.__schedule
     29.00            +1.5       30.52        perf-profile.children.cycles-pp.schedule
      5.05            +2.3        7.33        perf-profile.children.cycles-pp.pick_next_task_fair
     43.12           +10.7       53.86        perf-profile.children.cycles-pp.write
      0.68           +11.0       11.73 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      4.61           +12.4       16.96        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      5.14           +12.4       17.57        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.73 ±  6%      -0.8        0.95 ±  5%  perf-profile.self.cycles-pp.enqueue_task_fair
      1.47            -0.7        0.79 ±  3%  perf-profile.self.cycles-pp.enqueue_entity
      1.24            -0.6        0.62 ±  3%  perf-profile.self.cycles-pp.update_min_vruntime
      1.62            -0.6        1.02        perf-profile.self.cycles-pp.__calc_delta
      2.21            -0.6        1.62        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      2.90            -0.6        2.31 ±  5%  perf-profile.self.cycles-pp.update_curr
      1.79            -0.5        1.26 ±  3%  perf-profile.self.cycles-pp.update_cfs_group
      1.61            -0.5        1.10 ±  2%  perf-profile.self.cycles-pp.reweight_entity
      1.03            -0.5        0.53 ±  3%  perf-profile.self.cycles-pp.check_preempt_wakeup
      2.56 ±  3%      -0.4        2.12 ±  3%  perf-profile.self.cycles-pp.update_load_avg
      2.19            -0.4        1.75        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      1.06            -0.4        0.69 ±  2%  perf-profile.self.cycles-pp.perf_tp_event
      1.20            -0.4        0.83        perf-profile.self.cycles-pp.prepare_to_wait_event
      1.03            -0.4        0.66        perf-profile.self.cycles-pp.dequeue_task_fair
      0.82 ±  2%      -0.3        0.47 ±  2%  perf-profile.self.cycles-pp.try_to_wake_up
      0.91            -0.3        0.56        perf-profile.self.cycles-pp.dequeue_entity
      1.00            -0.3        0.68        perf-profile.self.cycles-pp.select_idle_sibling
      0.78            -0.3        0.48        perf-profile.self.cycles-pp.avg_vruntime
      0.70            -0.3        0.40        perf-profile.self.cycles-pp._find_next_and_bit
      0.43            -0.3        0.14        perf-profile.self.cycles-pp.autoremove_wake_function
      0.88            -0.3        0.60        perf-profile.self.cycles-pp.native_sched_clock
      1.19 ±  4%      -0.2        0.95 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.69            -0.2        0.47 ±  5%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.44            -0.2        0.22 ±  2%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.70            -0.2        0.49 ±  2%  perf-profile.self.cycles-pp.perf_trace_buf_alloc
      2.08            -0.2        1.88        perf-profile.self.cycles-pp.__update_load_avg_se
      0.61 ± 10%      -0.2        0.41 ± 12%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.47            -0.2        0.31        perf-profile.self.cycles-pp.select_idle_cpu
      1.01 ±  3%      -0.1        0.88 ±  2%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.34 ±  7%      -0.1        0.21 ±  4%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.35            -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.58 ±  5%      -0.1        0.45 ± 12%  perf-profile.self.cycles-pp.cpuacct_charge
      0.33            -0.1        0.21 ±  2%  perf-profile.self.cycles-pp.__bitmap_and
      0.28 ±  5%      -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.check_spread
      0.30            -0.1        0.20        perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      0.20 ±  6%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.23 ± 19%      -0.1        0.14 ±  6%  perf-profile.self.cycles-pp.perf_trace_buf_update
      0.40 ±  2%      -0.1        0.32 ±  3%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.24 ±  3%      -0.1        0.16 ±  5%  perf-profile.self.cycles-pp.update_rq_clock
      0.21 ±  2%      -0.1        0.14        perf-profile.self.cycles-pp.activate_task
      0.41 ±  5%      -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.select_task_rq
      0.54            -0.1        0.47        perf-profile.self.cycles-pp.__list_add_valid
      0.52            -0.1        0.45        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.82            -0.1        0.75        perf-profile.self.cycles-pp.do_syscall_64
      0.27 ±  3%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.mm_cid_get
      0.26 ±  8%      -0.1        0.20 ±  4%  perf-profile.self.cycles-pp.check_preempt_curr
      0.12 ±  3%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.32 ±  2%      -0.1        0.26 ±  3%  perf-profile.self.cycles-pp.available_idle_cpu
      0.30            -0.1        0.25 ±  3%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.32            -0.0        0.27        perf-profile.self.cycles-pp.__wake_up_common
      0.24            -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.14 ±  5%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.perf_trace_run_bpf_submit
      0.15            -0.0        0.11        perf-profile.self.cycles-pp.finish_wait
      1.89            -0.0        1.85        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.51            -0.0        0.48        perf-profile.self.cycles-pp.atime_needs_update
      0.08            -0.0        0.05        perf-profile.self.cycles-pp.sched_clock
      0.20            +0.0        0.21 ±  2%  perf-profile.self.cycles-pp.__fdget_pos
      0.08 ±  5%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.write@plt
      0.06 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.perf_exclude_event
      0.15 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.check_cfs_rq_runtime
      0.41            +0.0        0.43        perf-profile.self.cycles-pp.__cond_resched
      0.89            +0.0        0.92        perf-profile.self.cycles-pp.mutex_unlock
      0.28            +0.0        0.31 ±  3%  perf-profile.self.cycles-pp.__x64_sys_read
      0.08            +0.0        0.11        perf-profile.self.cycles-pp.rb_next
      0.29            +0.0        0.32        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.42            +0.0        0.45        perf-profile.self.cycles-pp.finish_task_switch
      2.00            +0.0        2.04        perf-profile.self.cycles-pp.pipe_read
      0.11 ±  4%      +0.0        0.15        perf-profile.self.cycles-pp.switch_ldt
      0.12 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.rb_erase
      0.27 ±  4%      +0.0        0.31 ±  3%  perf-profile.self.cycles-pp.__x64_sys_write
      0.58            +0.0        0.62        perf-profile.self.cycles-pp.pick_next_entity
      0.19            +0.0        0.24 ±  3%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.09 ±  5%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.rw_verify_area
      0.25            +0.1        0.30        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.29            +0.1        0.35        perf-profile.self.cycles-pp.child
      1.25            +0.1        1.30        perf-profile.self.cycles-pp.pick_next_task_fair
      0.34            +0.1        0.40        perf-profile.self.cycles-pp.__dequeue_entity
      0.17 ±  2%      +0.1        0.22 ±  8%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.make_vfsgid
      0.23 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.29            +0.1        0.35        perf-profile.self.cycles-pp.__wake_up_common_lock
      0.06 ±  8%      +0.1        0.12        perf-profile.self.cycles-pp.rb_insert_color
      0.32            +0.1        0.39 ±  9%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.29            +0.1        0.36        perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.34            +0.1        0.42        perf-profile.self.cycles-pp.testcase
      0.30            +0.1        0.38        perf-profile.self.cycles-pp.copy_page_from_iter
      0.27            +0.1        0.35 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
      0.14            +0.1        0.23 ±  2%  perf-profile.self.cycles-pp.file_update_time
      0.29 ±  7%      +0.1        0.38 ±  8%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.33 ±  2%      +0.1        0.42        perf-profile.self.cycles-pp.place_entity
      0.18 ±  4%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.aa_file_perm
      0.18 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp.put_prev_entity
      0.00            +0.1        0.11        perf-profile.self.cycles-pp.cr4_update_irqsoff
      0.42            +0.1        0.53        perf-profile.self.cycles-pp.__get_task_ioprio
      0.90            +0.1        1.01        perf-profile.self.cycles-pp.read
      0.61            +0.1        0.73        perf-profile.self.cycles-pp.schedule
      0.33            +0.1        0.45        perf-profile.self.cycles-pp.set_next_entity
      0.23            +0.1        0.35        perf-profile.self.cycles-pp.__enqueue_entity
      0.52            +0.1        0.64        perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.48            +0.1        0.60        perf-profile.self.cycles-pp._copy_from_iter
      1.03            +0.1        1.15        perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.09            +0.1        1.21 ±  2%  perf-profile.self.cycles-pp.mutex_lock
      0.53            +0.1        0.67        perf-profile.self.cycles-pp.copyin
      0.50            +0.1        0.64        perf-profile.self.cycles-pp.copyout
      0.15 ±  6%      +0.1        0.29 ±  7%  perf-profile.self.cycles-pp.queue_event
      0.92 ±  2%      +0.1        1.07        perf-profile.self.cycles-pp.write
      0.15 ± 15%      +0.1        0.30 ±  2%  perf-profile.self.cycles-pp.inode_needs_update_time
      1.35 ±  2%      +0.2        1.50 ±  2%  perf-profile.self.cycles-pp.__fget_light
      0.42 ±  2%      +0.2        0.58 ±  5%  perf-profile.self.cycles-pp.current_time
      0.59            +0.2        0.77        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.42 ±  9%      +0.2        0.60 ±  5%  perf-profile.self.cycles-pp.set_next_buddy
      1.69            +0.2        1.88        perf-profile.self.cycles-pp.vfs_read
      0.60 ± 10%      +0.2        0.81 ±  4%  perf-profile.self.cycles-pp.prepare_task_switch
      0.57            +0.2        0.78        perf-profile.self.cycles-pp.switch_fpu_return
      0.94            +0.2        1.15 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
      0.32            +0.2        0.56 ±  2%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.31            +0.2        0.55 ±  2%  perf-profile.self.cycles-pp.ksys_write
      1.54            +0.3        1.81        perf-profile.self.cycles-pp.__switch_to
      0.00            +0.3        0.27 ±  3%  perf-profile.self.cycles-pp.resched_curr
      1.69            +0.3        1.96 ±  4%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.20 ±  4%      +0.3        0.48        perf-profile.self.cycles-pp.clear_buddies
      1.33            +0.3        1.62        perf-profile.self.cycles-pp.___perf_sw_event
      1.39            +0.3        1.68        perf-profile.self.cycles-pp.os_xsave
      1.15            +0.3        1.44        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.79            +0.3        2.14        perf-profile.self.cycles-pp.pipe_write
      0.37            +0.4        0.74 ±  2%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.00            +0.5        0.47 ±  3%  perf-profile.self.cycles-pp.exit_to_user_mode_loop
      2.10            +0.5        2.58        perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.5        0.54 ±  3%  perf-profile.self.cycles-pp.update_entity_lag
      1.42            +0.5        1.96        perf-profile.self.cycles-pp.vfs_write
      0.31 ±  3%      +0.6        0.86 ±  2%  perf-profile.self.cycles-pp.security_file_permission
      2.95            +0.7        3.66        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      4.64            +1.2        5.85        perf-profile.self.cycles-pp.switch_mm_irqs_off



***************************************************************************************************
lkp-icl-2sp1: 96 threads 2 sockets (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/xfs/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp1/webproxy.f/filebench

commit: 
  e0c2ff903c ("sched/fair: Remove sched_feat(START_DEBIT)")
  86bfbb7ce4 ("sched/fair: Add lag based placement")

e0c2ff903c320d3f 86bfbb7ce4f67a88df263919816 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      5.19           +14.0%       5.91        iostat.cpu.system
      3.30            +0.8        4.09        mpstat.cpu.all.sys%
      5205 ± 14%     +90.4%       9909 ± 34%  numa-meminfo.node0.Active(anon)
      1302 ± 14%     +90.3%       2477 ± 34%  numa-vmstat.node0.nr_active_anon
      1302 ± 14%     +90.3%       2477 ± 34%  numa-vmstat.node0.nr_zone_active_anon
     40916            -3.9%      39326        vmstat.system.cs
     98915            -0.9%      98031        vmstat.system.in
     20869            +9.9%      22931        proc-vmstat.nr_active_anon
     34978            +3.7%      36259        proc-vmstat.nr_shmem
     20869            +9.9%      22931        proc-vmstat.nr_zone_active_anon
    954.33 ±  4%     +16.6%       1112 ±  3%  proc-vmstat.numa_huge_pte_updates
    639798 ±  4%     +10.6%     707819        proc-vmstat.numa_pte_updates
     83809            +5.7%      88601        proc-vmstat.pgactivate
     20579            +8.4%      22301 ±  3%  proc-vmstat.pgreuse
    180.33           +11.5%     201.00        turbostat.Avg_MHz
      6.61            +0.7        7.29        turbostat.Busy%
      2731            +1.1%       2762        turbostat.Bzy_MHz
      0.02            -0.0        0.01        turbostat.C1%
      6.02            +0.6        6.65        turbostat.C1E%
     16.45           +12.7%      18.55        turbostat.CPU%c1
     37.09 ±140%    +518.8%     229.48 ± 52%  turbostat.IPC
      9010           +11.5%      10049 ±  4%  turbostat.POLL
      3.89 ± 17%     +35.6%       5.28 ±  6%  turbostat.Pkg%pc2
     58.08            -1.9%      57.00        turbostat.RAMWatt
     16.07            +1.5%      16.30        filebench.sum_bytes_mb/s
    285730            +1.7%     290566        filebench.sum_operations
      4761            +1.7%       4842        filebench.sum_operations/s
      1253            +1.7%       1274        filebench.sum_reads/s
     20.95            -1.7%      20.60        filebench.sum_time_ms/op
    250.67            +1.6%     254.67        filebench.sum_writes/s
      1492 ±  3%     -86.6%     200.00 ± 11%  filebench.time.involuntary_context_switches
     66476 ±  2%      +9.3%      72630 ±  2%  filebench.time.minor_page_faults
    231.00           +21.1%     279.67        filebench.time.percent_of_cpu_this_job_got
    165.14           +21.7%     201.01        filebench.time.system_time
    443753            -7.4%     410985        filebench.time.voluntary_context_switches
      1973        +4.9e+07%   9.59e+08 ± 39%  sched_debug.cfs_rq:/.avg_vruntime.avg
     13143 ± 10%  +1.5e+08%  2.006e+10 ± 61%  sched_debug.cfs_rq:/.avg_vruntime.max
      2582 ±  2%  +1.2e+08%  3.058e+09 ± 40%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      1973        +4.9e+07%   9.59e+08 ± 39%  sched_debug.cfs_rq:/.min_vruntime.avg
     13143 ± 10%  +1.5e+08%  2.006e+10 ± 61%  sched_debug.cfs_rq:/.min_vruntime.max
      2582 ±  2%  +1.2e+08%  3.058e+09 ± 40%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1591 ± 17%     -19.0%       1289 ± 17%  sched_debug.cfs_rq:/.runnable_avg.max
      1589 ± 17%     -19.2%       1284 ± 17%  sched_debug.cfs_rq:/.util_avg.max
     26787 ±124%     -90.8%       2458 ±  7%  sched_debug.cpu.avg_idle.min
      9854 ± 87%     +99.1%      19619 ± 33%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 12%     +29.7%       0.00 ±  9%  sched_debug.cpu.next_balance.stddev
      0.00 ±116%   +5070.9%       0.00 ±121%  sched_debug.rt_rq:.rt_time.avg
      0.01 ±116%   +5070.9%       0.33 ±121%  sched_debug.rt_rq:.rt_time.max
      0.00 ±116%   +5070.9%       0.03 ±121%  sched_debug.rt_rq:.rt_time.stddev
  29305629          +300.0%  1.172e+08        sched_debug.sysctl_sched.sysctl_sched_features
     18.14            -6.4%      16.99 ±  2%  perf-stat.i.MPKI
      1.12            -0.1        1.05 ±  2%  perf-stat.i.branch-miss-rate%
  26646919            -3.3%   25765825        perf-stat.i.branch-misses
   6165072            -2.9%    5988372        perf-stat.i.cache-misses
 1.792e+08            -3.4%  1.731e+08        perf-stat.i.cache-references
     42111            -4.3%      40288        perf-stat.i.context-switches
      1.53            +9.2%       1.67        perf-stat.i.cpi
 1.608e+10           +12.8%  1.814e+10        perf-stat.i.cpu-cycles
    700.59 ±  2%     +64.5%       1152        perf-stat.i.cpu-migrations
      2865           +18.1%       3384        perf-stat.i.cycles-between-cache-misses
      0.18 ±  4%      -0.0        0.16 ±  2%  perf-stat.i.dTLB-load-miss-rate%
   4686249 ±  2%      -9.3%    4248854        perf-stat.i.dTLB-load-misses
      0.03 ± 11%      -0.0        0.03 ±  2%  perf-stat.i.dTLB-store-miss-rate%
    350806 ±  4%      -9.6%     316962        perf-stat.i.dTLB-store-misses
      0.69            -7.9%       0.63        perf-stat.i.ipc
      0.17           +12.8%       0.19        perf-stat.i.metric.GHz
     42.78            -3.1%      41.43        perf-stat.i.metric.K/sec
   1440516            -4.3%    1378031        perf-stat.i.node-load-misses
     51109            -5.6%      48269        perf-stat.i.node-loads
     16.84            -5.1%      15.98        perf-stat.overall.MPKI
      1.06            -0.1        1.01        perf-stat.overall.branch-miss-rate%
      1.51           +10.9%       1.67        perf-stat.overall.cpi
      2608           +16.2%       3030        perf-stat.overall.cycles-between-cache-misses
      0.17 ±  2%      -0.0        0.15        perf-stat.overall.dTLB-load-miss-rate%
      0.03 ±  4%      -0.0        0.02        perf-stat.overall.dTLB-store-miss-rate%
      0.66            -9.8%       0.60        perf-stat.overall.ipc
  26276300            -3.3%   25402609        perf-stat.ps.branch-misses
   6079761            -2.9%    5904055        perf-stat.ps.cache-misses
 1.767e+08            -3.4%  1.707e+08        perf-stat.ps.cache-references
     41529            -4.3%      39728        perf-stat.ps.context-switches
 1.586e+10           +12.8%  1.789e+10        perf-stat.ps.cpu-cycles
    690.96 ±  2%     +64.5%       1136        perf-stat.ps.cpu-migrations
   4621257 ±  2%      -9.3%    4189616        perf-stat.ps.dTLB-load-misses
    345894 ±  4%      -9.7%     312505        perf-stat.ps.dTLB-store-misses
   1420644            -4.3%    1358892        perf-stat.ps.node-load-misses
     50402            -5.5%      47609        perf-stat.ps.node-loads
 7.617e+11            +1.9%   7.76e+11        perf-stat.total.instructions
     14.42 ± 25%      -5.7        8.71 ± 28%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     14.42 ± 25%      -5.3        9.09 ± 24%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.86 ± 72%      +1.0        1.88 ± 34%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.generic_file_write_iter.vfs_write
      0.86 ± 72%      +1.0        1.88 ± 34%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      0.86 ± 72%      +1.0        1.88 ± 34%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.86 ± 72%      +1.0        1.88 ± 34%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      0.37 ±141%      +1.1        1.43 ± 18%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +1.4        1.43 ± 18%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.00            +1.4        1.43 ± 18%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.00            +1.4        1.43 ± 18%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.__evlist__disable
      0.00            +1.4        1.43 ± 18%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
      0.00            +1.4        1.43 ± 18%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next
      0.00            +1.4        1.43 ± 18%  perf-profile.calltrace.cycles-pp.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.4        1.43 ± 18%  perf-profile.calltrace.cycles-pp.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity
      0.00            +1.4        1.43 ± 18%  perf-profile.calltrace.cycles-pp.__open64_nocancel.setlocale
      0.00            +2.3        2.25 ± 16%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      0.37 ±141%      +2.4        2.78 ± 67%  perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      4.27 ± 27%      +2.9        7.21 ± 20%  perf-profile.calltrace.cycles-pp.read
      0.37 ±141%      +3.0        3.37 ± 51%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.00            +3.4        3.37 ± 48%  perf-profile.calltrace.cycles-pp.setlocale
      4.27 ± 27%      +3.5        7.81 ± 21%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      5.88 ± 43%      +4.2       10.04 ± 23%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.88 ± 43%      +4.2       10.04 ± 23%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.88 ± 43%      +4.2       10.04 ± 23%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      6.26 ± 48%      +4.2       10.42 ± 18%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      2.85 ± 80%      +5.0        7.86 ± 41%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      3.23 ± 85%      +5.0        8.24 ± 37%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     13.49 ± 71%      +9.0       22.47 ± 12%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.49 ± 71%      +9.0       22.47 ± 12%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.49 ± 71%      +9.1       22.61 ± 11%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     14.43 ± 25%      -5.3        9.16 ± 33%  perf-profile.children.cycles-pp.path_openat
     14.43 ± 25%      -4.9        9.53 ± 29%  perf-profile.children.cycles-pp.do_filp_open
     14.80 ± 27%      -4.7       10.06 ± 14%  perf-profile.children.cycles-pp.__x64_sys_openat
     14.80 ± 27%      -4.7       10.06 ± 14%  perf-profile.children.cycles-pp.do_sys_openat2
      6.12 ± 26%      -4.4        1.73 ± 98%  perf-profile.children.cycles-pp.lookup_fast
      3.58 ± 39%      -2.8        0.83 ± 71%  perf-profile.children.cycles-pp.vma_alloc_folio
      0.86 ± 72%      +1.0        1.88 ± 34%  perf-profile.children.cycles-pp.copyin
      0.86 ± 72%      +1.0        1.88 ± 34%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.86 ± 72%      +1.0        1.88 ± 34%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.86 ± 72%      +1.0        1.88 ± 34%  perf-profile.children.cycles-pp.find_busiest_group
      0.37 ±141%      +1.1        1.43 ± 18%  perf-profile.children.cycles-pp.__open64_nocancel
      0.86 ± 72%      +1.3        2.18 ± 40%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.00            +1.4        1.43 ± 18%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.00            +1.4        1.43 ± 18%  perf-profile.children.cycles-pp.__sched_setaffinity
      0.00            +1.4        1.43 ± 18%  perf-profile.children.cycles-pp.mas_walk
      0.00            +1.4        1.43 ± 18%  perf-profile.children.cycles-pp.schedule
      0.37 ±141%      +1.4        1.80 ± 20%  perf-profile.children.cycles-pp.mod_objcg_state
      0.86 ± 72%      +1.8        2.70 ± 35%  perf-profile.children.cycles-pp.newidle_balance
      0.86 ± 72%      +1.8        2.70 ± 35%  perf-profile.children.cycles-pp.load_balance
      0.37 ±141%      +2.2        2.62 ± 74%  perf-profile.children.cycles-pp.__do_softirq
      0.37 ±141%      +2.2        2.62 ± 74%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.37 ±141%      +2.4        2.78 ± 67%  perf-profile.children.cycles-pp.init_file
      0.49 ±141%      +2.7        3.23 ± 11%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.49 ±141%      +2.7        3.23 ± 11%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.49 ±141%      +2.7        3.23 ± 11%  perf-profile.children.cycles-pp.sched_setaffinity
      2.28 ± 36%      +2.8        5.03 ± 43%  perf-profile.children.cycles-pp.__schedule
      4.27 ± 27%      +2.9        7.21 ± 20%  perf-profile.children.cycles-pp.read
      0.37 ±141%      +3.0        3.37 ± 51%  perf-profile.children.cycles-pp.alloc_empty_file
      2.17 ± 24%      +3.2        5.39 ± 48%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.00            +3.4        3.37 ± 48%  perf-profile.children.cycles-pp.setlocale
      5.88 ± 43%      +4.2       10.04 ± 23%  perf-profile.children.cycles-pp.start_secondary
      6.26 ± 48%      +4.2       10.42 ± 18%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      6.26 ± 48%      +4.2       10.42 ± 18%  perf-profile.children.cycles-pp.cpu_startup_entry
      6.26 ± 48%      +4.2       10.42 ± 18%  perf-profile.children.cycles-pp.do_idle
      2.17 ± 24%      +4.6        6.74 ± 48%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      3.23 ± 85%      +5.0        8.24 ± 37%  perf-profile.children.cycles-pp.cpuidle_enter
      3.23 ± 85%      +5.0        8.24 ± 37%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.86 ± 72%      +1.0        1.88 ± 34%  perf-profile.self.cycles-pp.copyin
      0.01 ± 43%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      0.02 ± 64%     -89.3%       0.00 ±141%  perf-sched.sch_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.smb_send_kvec
      0.01 ±  8%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.cifs_demultiplex_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 12%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup
      0.01 ± 24%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.xfs_ilock_attr_map_shared.xfs_attr_get.xfs_xattr_get
      0.01 ± 13%     -53.6%       0.00 ± 71%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.xfs_ilock_data_map_shared.xfs_dir2_leaf_getdents.xfs_readdir
      0.01 ± 78%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.01 ±  7%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.path_put.set_fs_pwd.__x64_sys_chdir
      0.01 ± 35%     -60.7%       0.00 ± 71%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
      0.03 ± 57%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.01 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      0.01 ± 14%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.01 ± 27%     -83.3%       0.00 ±141%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.posix_lock_inode.do_lock_file_wait.fcntl_setlk
      0.01 ± 29%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      0.01 ± 74%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.posix_lock_inode.do_lock_file_wait.fcntl_setlk.do_fcntl
      0.01 ± 57%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.wait_for_response.compound_send_recv.cifs_send_recv.__SMB2_close
      0.00          +583.3%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
      0.02 ±  3%    +502.7%       0.15 ±111%  perf-sched.sch_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
      0.02 ±  2%     +51.4%       0.04 ± 23%  perf-sched.sch_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      0.01           +29.2%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      0.04 ±  3%     -13.2%       0.03 ± 11%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.02 ± 11%     +28.8%       0.03 ±  8%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ± 71%    +192.3%       0.01 ± 31%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.04 ±  5%     -18.6%       0.04 ±  2%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.04 ±  9%     -24.8%       0.03 ±  8%  perf-sched.sch_delay.avg.ms.kthreadd.ret_from_fork.ret_from_fork_asm
      0.06 ±  8%     +61.4%       0.10 ± 27%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.04 ±  4%     -21.1%       0.03 ±  5%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.cifs_call_async
      0.03           -30.5%       0.02        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.02 ± 27%     -30.0%       0.02 ± 17%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.04 ± 16%     -47.6%       0.02 ± 38%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_killable.__kthread_create_on_node
      0.01 ±  5%     +68.0%       0.01        perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.01 ± 14%    +175.0%       0.02 ±  9%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.07 ± 39%     +64.5%       0.11 ± 20%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.06 ± 12%     -13.3%       0.05 ±  6%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.01 ± 16%    +484.6%       0.08 ±  7%  perf-sched.sch_delay.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_lease_break
      0.03           +99.0%       0.06 ± 19%  perf-sched.sch_delay.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_open
      0.02 ±  4%     +78.4%       0.03 ± 12%  perf-sched.sch_delay.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.__SMB2_close
      0.03 ±  3%    +256.8%       0.11        perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.17 ± 11%     -33.2%       0.12 ± 29%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.cifs_strndup_to_utf16.cifs_convert_path_to_utf16
      0.03 ± 85%     -77.8%       0.01 ± 12%  perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
      0.01 ± 46%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      0.10 ± 38%     -53.4%       0.05 ± 40%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.05 ± 66%     -96.1%       0.00 ±141%  perf-sched.sch_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.smb_send_kvec
      0.39 ± 76%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.cifs_demultiplex_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 14%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup
      0.02 ± 53%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.xfs_ilock_attr_map_shared.xfs_attr_get.xfs_xattr_get
      0.08 ± 48%     -94.8%       0.00 ± 71%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.xfs_ilock_data_map_shared.xfs_dir2_leaf_getdents.xfs_readdir
      1.12 ± 27%     -94.9%       0.06 ± 73%  perf-sched.sch_delay.max.ms.__cond_resched.dput.cifsFileInfo_put_final._cifsFileInfo_put.process_one_work
      0.02 ± 86%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.01 ± 14%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.path_put.set_fs_pwd.__x64_sys_chdir
      0.06 ±111%     -93.5%       0.00 ± 71%  perf-sched.sch_delay.max.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
      0.10 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.02 ± 22%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      0.01 ± 17%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.01 ± 14%     -76.0%       0.00 ±141%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.posix_lock_inode.do_lock_file_wait.fcntl_setlk
      0.01 ± 25%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      0.01 ± 78%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.posix_lock_inode.do_lock_file_wait.fcntl_setlk.do_fcntl
      0.07 ± 75%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.wait_for_response.compound_send_recv.cifs_send_recv.__SMB2_close
      0.40 ± 46%    +946.5%       4.16 ± 62%  perf-sched.sch_delay.max.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      0.17 ±  5%     +32.9%       0.22 ±  6%  perf-sched.sch_delay.max.ms.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      0.13 ± 27%     -94.4%       0.01 ± 17%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.14 ± 12%     -41.2%       0.08 ± 62%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.23 ± 38%    +252.4%       0.82 ± 65%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.71 ±108%    +607.2%       5.01 ± 84%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.47 ± 42%    +395.1%       2.32 ± 45%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.10 ± 21%     +50.8%       0.15 ± 15%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.39 ± 45%    +225.1%       1.28 ± 14%  perf-sched.sch_delay.max.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_lease_break
      3.68 ±132%   +5400.0%     202.27 ±  3%  perf-sched.sch_delay.max.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_open
      4.82 ± 22%     +93.2%       9.32 ± 15%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 10%     +72.1%       0.04 ±  5%  perf-sched.total_sch_delay.average.ms
      0.11          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.cifs_demultiplex_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.09 ±  2%     -26.7%       0.07        perf-sched.wait_and_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
     20.34 ±  5%    +121.3%      45.02        perf-sched.wait_and_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
     25.44 ±  2%     +49.5%      38.02 ±  2%  perf-sched.wait_and_delay.avg.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      3.47           -18.6%       2.82 ±  3%  perf-sched.wait_and_delay.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.67 ±  4%     -25.2%       0.50 ±  3%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
     15.66 ± 11%     -14.2%      13.43 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
     16.45 ±  2%     +13.2%      18.62 ±  3%  perf-sched.wait_and_delay.avg.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_query_path_info
      5.19 ±  6%     +62.2%       8.43 ± 30%  perf-sched.wait_and_delay.avg.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_unlink
     18.98 ±  4%     +20.2%      22.82 ±  2%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      6368 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.cifs_demultiplex_thread.kthread.ret_from_fork.ret_from_fork_asm
      6031 ±  2%     -68.1%       1924 ±  5%  perf-sched.wait_and_delay.count.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
      1336 ±  4%     -52.6%     633.33 ±  4%  perf-sched.wait_and_delay.count.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
      1932 ±  4%     -51.8%     930.67 ±  3%  perf-sched.wait_and_delay.count.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      2278 ±  6%     +31.4%       2994        perf-sched.wait_and_delay.count.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
     45.67 ±  4%     +11.7%      51.00 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      3529 ±  5%     -16.2%       2957 ±  2%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.compound_send_recv
     21692           +31.4%      28510        perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     15498           -11.7%      13687        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.52 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.cifs_demultiplex_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.27 ±  9%     +70.9%       2.17 ± 37%  perf-sched.wait_and_delay.max.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
      1213 ± 15%    +142.5%       2943 ± 23%  perf-sched.wait_and_delay.max.ms.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
    639.62 ± 14%     +36.7%     874.64 ± 13%  perf-sched.wait_and_delay.max.ms.kthreadd.ret_from_fork.ret_from_fork_asm
    230.08 ±  2%      -6.7%     214.71 ±  2%  perf-sched.wait_and_delay.max.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_unlink
      2878 ± 12%     +39.3%       4011 ±  6%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     19.80 ± 18%     -97.2%       0.55 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.cifs_strndup_to_utf16.cifs_convert_path_to_utf16
      0.19 ± 10%     -90.4%       0.02 ±141%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.do_getxattr.getxattr
      0.20 ± 36%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      0.11          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.cifs_demultiplex_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.14 ± 61%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup
      0.12 ± 25%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.xfs_ilock_attr_map_shared.xfs_attr_get.xfs_xattr_get
      0.30 ±129%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.17 ± 97%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.set_fs_pwd.__x64_sys_chdir
      0.16 ± 21%     -61.9%       0.06 ± 86%  perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
      0.91 ± 43%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.16 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      0.22 ± 58%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.05 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      0.08 ± 46%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.posix_lock_inode.do_lock_file_wait.fcntl_setlk.do_fcntl
      1.63 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.wait_for_response.compound_send_recv.cifs_send_recv.__SMB2_close
      0.09 ±  2%     -40.6%       0.05        perf-sched.wait_time.avg.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
     20.32 ±  5%    +120.9%      44.88        perf-sched.wait_time.avg.ms.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
     25.42 ±  2%     +49.5%      37.99 ±  2%  perf-sched.wait_time.avg.ms.__lock_sock.lock_sock_nested.tcp_sock_set_cork.__smb_send_rqst
      3.41           -18.9%       2.77 ±  3%  perf-sched.wait_time.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.62 ±  4%     -25.7%       0.46 ±  3%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.88 ±  6%     -14.9%       0.75 ±  4%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.cifs_call_async
     15.65 ± 11%     -14.3%      13.41 ± 10%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.71 ±  3%     +16.7%       0.83 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_killable.__cifs_readv
      0.90 ±  8%     +29.3%       1.16 ± 25%  perf-sched.wait_time.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.SMB2_lease_break
     16.43 ±  2%     +13.1%      18.59 ±  3%  perf-sched.wait_time.avg.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_query_path_info
      5.16 ±  6%     +62.7%       8.40 ± 30%  perf-sched.wait_time.avg.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_unlink
     18.95 ±  4%     +19.8%      22.71 ±  2%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    214.80 ±  3%     -99.2%       1.69 ± 29%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.cifs_strndup_to_utf16.cifs_convert_path_to_utf16
      0.50 ± 46%     -94.4%       0.03 ±141%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.do_getxattr.getxattr
      0.71 ± 32%     -52.0%       0.34 ± 61%  perf-sched.wait_time.max.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
      0.32 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      1.60 ± 30%     -63.4%       0.59 ±141%  perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.smb_send_kvec
      1.44 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.cifs_demultiplex_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.37 ±102%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup
      0.20 ± 36%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.xfs_ilock_attr_map_shared.xfs_attr_get.xfs_xattr_get
      0.85 ± 24%     -82.2%       0.15 ±108%  perf-sched.wait_time.max.ms.__cond_resched.down_read.xfs_ilock_data_map_shared.xfs_dir2_leaf_getdents.xfs_readdir
      5.43 ±  4%     -81.9%       0.99 ± 99%  perf-sched.wait_time.max.ms.__cond_resched.dput.cifsFileInfo_put_final._cifsFileInfo_put.process_one_work
      0.63 ±131%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.22 ± 93%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.set_fs_pwd.__x64_sys_chdir
      0.81 ± 31%     -92.7%       0.06 ± 86%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
      1.80 ± 13%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.40 ± 16%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.fcntl_setlk.do_fcntl.__x64_sys_fcntl
      0.48 ± 60%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.06 ± 37%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      0.12 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.posix_lock_inode.do_lock_file_wait.fcntl_setlk.do_fcntl
      5.68 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.wait_for_response.compound_send_recv.cifs_send_recv.__SMB2_close
      1.27 ±  8%     +65.2%       2.09 ± 38%  perf-sched.wait_time.max.ms.__lock_sock.lock_sock_nested.tcp_recvmsg.inet6_recvmsg
      1213 ± 15%    +142.5%       2943 ± 23%  perf-sched.wait_time.max.ms.__lock_sock.lock_sock_nested.tcp_sendmsg.sock_sendmsg
      1.10 ± 12%     -78.8%       0.23 ± 65%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
     70.93 ±138%     -99.4%       0.43 ± 67%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    639.55 ± 14%     +36.7%     874.58 ± 13%  perf-sched.wait_time.max.ms.kthreadd.ret_from_fork.ret_from_fork_asm
      0.00 ±141%    +311.1%       0.01 ± 32%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    230.02 ±  2%      -6.7%     214.64 ±  2%  perf-sched.wait_time.max.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_unlink
      2878 ± 12%     +39.3%       4011 ±  6%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm




***************************************************************************************************
lkp-csl-2sp3: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/200%/debian-11.1-x86_64-20220510.cgz/300s/lkp-csl-2sp3/TCP_MAERTS/netperf

commit: 
  e0c2ff903c ("sched/fair: Remove sched_feat(START_DEBIT)")
  86bfbb7ce4 ("sched/fair: Add lag based placement")

e0c2ff903c320d3f 86bfbb7ce4f67a88df263919816 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.226e+08 ±  6%     +48.3%  4.786e+08 ± 13%  cpuidle..time
   1535647 ±  3%    +309.9%    6294878 ± 23%  cpuidle..usage
    234.00           +16.7%     273.00        vmstat.procs.r
  10770893           -95.9%     444555 ±  6%  vmstat.system.cs
    142595 ±  2%     -18.1%     116761 ± 11%  vmstat.system.in
 4.624e+08 ±  5%     -40.7%  2.743e+08        numa-numastat.node0.local_node
 4.623e+08 ±  5%     -40.7%  2.741e+08        numa-numastat.node0.numa_hit
 4.366e+08 ±  4%     -36.1%  2.788e+08 ±  2%  numa-numastat.node1.local_node
 4.366e+08 ±  4%     -36.2%  2.788e+08 ±  2%  numa-numastat.node1.numa_hit
    176.00 ±  5%   +3510.4%       6354 ± 46%  perf-c2c.DRAM.local
    911.33 ± 26%     -33.2%     608.67 ± 43%  perf-c2c.DRAM.remote
      4988 ±  5%     -70.3%       1482 ± 43%  perf-c2c.HITM.local
    195.33 ± 21%     -48.1%     101.33 ± 35%  perf-c2c.HITM.remote
      5183 ±  6%     -69.4%       1584 ± 43%  perf-c2c.HITM.total
     88289           -40.6%      52481 ± 20%  meminfo.Active
     87601           -40.9%      51793 ± 20%  meminfo.Active(anon)
    176566 ±  8%     +27.8%     225718 ±  9%  meminfo.DirectMap4k
   4234912           +11.5%    4723511        meminfo.Memused
     93738           -32.5%      63231 ± 11%  meminfo.Shmem
   5475086           -10.4%    4903564        meminfo.max_used_kB
      1.00 ±  3%      +0.6        1.57 ± 15%  mpstat.cpu.all.idle%
      0.00 ±141%      +0.0        0.00        mpstat.cpu.all.iowait%
      1.30 ±  3%      +1.2        2.46        mpstat.cpu.all.irq%
     18.74           -12.8        5.94        mpstat.cpu.all.soft%
     71.99           +11.9       83.89        mpstat.cpu.all.sys%
      6.97            -0.8        6.15        mpstat.cpu.all.usr%
      5943           -56.6%       2577        netperf.Throughput_Mbps
   1141105           -56.6%     494893        netperf.Throughput_total_Mbps
    591594 ± 34%    +144.6%    1446798        netperf.time.involuntary_context_switches
      2820           +61.2%       4547        netperf.time.percent_of_cpu_this_job_got
      7667           +78.5%      13683        netperf.time.system_time
    858.98           -68.2%     273.58        netperf.time.user_time
 1.651e+09           -96.1%   64354651 ±  5%  netperf.time.voluntary_context_switches
 2.612e+09           -56.6%  1.133e+09        netperf.workload
     22473 ± 28%     -70.7%       6591 ± 48%  numa-meminfo.node0.Active
     22243 ± 29%     -72.4%       6133 ± 46%  numa-meminfo.node0.Active(anon)
     25602 ± 28%     -59.1%      10483 ± 35%  numa-meminfo.node0.Shmem
     65615 ± 10%     -17.9%      53849 ± 13%  numa-meminfo.node1.Active
     65156 ± 11%     -17.7%      53619 ± 13%  numa-meminfo.node1.Active(anon)
      3345 ± 13%    +103.6%       6810 ± 36%  numa-meminfo.node1.Mapped
    831473 ±  3%     +33.3%    1108221 ±  8%  numa-meminfo.node1.MemUsed
      1978 ± 35%   +3678.5%      74751 ±101%  numa-meminfo.node1.Unevictable
     21843           -32.5%      14746 ± 10%  proc-vmstat.nr_active_anon
      9222           +16.1%      10710 ±  9%  proc-vmstat.nr_mapped
     23390           -20.8%      18514 ±  5%  proc-vmstat.nr_shmem
     21843           -32.5%      14746 ± 10%  proc-vmstat.nr_zone_active_anon
 8.989e+08           -38.5%  5.529e+08        proc-vmstat.numa_hit
 8.991e+08           -38.5%  5.531e+08        proc-vmstat.numa_local
 7.182e+09           -38.5%  4.415e+09        proc-vmstat.pgalloc_normal
    910099           -10.8%     811852        proc-vmstat.pgfault
 7.182e+09           -38.5%  4.414e+09        proc-vmstat.pgfree
     49784 ± 13%     -19.6%      40020 ±  8%  proc-vmstat.pgreuse
   2798848            +9.3%    3059968 ±  5%  proc-vmstat.unevictable_pgs_scanned
      5568 ± 29%     -73.2%       1493 ± 47%  numa-vmstat.node0.nr_active_anon
      6408 ± 28%     -60.3%       2541 ± 34%  numa-vmstat.node0.nr_shmem
      5568 ± 29%     -73.2%       1493 ± 47%  numa-vmstat.node0.nr_zone_active_anon
 4.623e+08 ±  5%     -40.7%  2.741e+08        numa-vmstat.node0.numa_hit
 4.624e+08 ±  5%     -40.7%  2.742e+08        numa-vmstat.node0.numa_local
     16288 ± 11%     -19.1%      13170 ± 17%  numa-vmstat.node1.nr_active_anon
    820.33 ± 11%    +104.1%       1674 ± 30%  numa-vmstat.node1.nr_mapped
    494.00 ± 36%   +3682.9%      18687 ±101%  numa-vmstat.node1.nr_unevictable
     16288 ± 11%     -19.1%      13170 ± 17%  numa-vmstat.node1.nr_zone_active_anon
    494.00 ± 36%   +3682.9%      18687 ±101%  numa-vmstat.node1.nr_zone_unevictable
 4.366e+08 ±  4%     -36.2%  2.787e+08 ±  2%  numa-vmstat.node1.numa_hit
 4.366e+08 ±  4%     -36.1%  2.788e+08 ±  2%  numa-vmstat.node1.numa_local
      2721           +10.9%       3018        turbostat.Avg_MHz
      2769           +11.3%       3083        turbostat.Bzy_MHz
    777955 ± 11%    +462.5%    4375927 ± 20%  turbostat.C1
      0.02 ± 28%      +0.1        0.09 ± 23%  turbostat.C1%
      9851           +96.6%      19371 ± 18%  turbostat.C1E
      0.01            +0.0        0.02        turbostat.C1E%
    266835 ±  8%     +51.0%     402841 ± 14%  turbostat.C6
      1.04 ±  7%      +0.4        1.47 ± 12%  turbostat.C6%
      1.30 ±  4%     +28.6%       1.68 ±  9%  turbostat.CPU%c1
      0.14 ±  3%     -79.1%       0.03        turbostat.IPC
  43523293 ±  2%     -20.5%   34620615 ± 12%  turbostat.IRQ
    456324 ± 24%    +223.4%    1475732 ± 39%  turbostat.POLL
     41.20 ±  5%    +124.6%      92.52        turbostat.RAMWatt
  12071011        +54898.8%  6.639e+09 ± 30%  sched_debug.cfs_rq:/.avg_vruntime.avg
  17308223 ±  3%  +1.5e+06%  2.534e+11 ± 71%  sched_debug.cfs_rq:/.avg_vruntime.max
   9463501 ±  2%   +2180.3%  2.158e+08 ±127%  sched_debug.cfs_rq:/.avg_vruntime.min
   1956204 ±  3%  +1.4e+06%  2.727e+10 ± 69%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      2.09           +14.9%       2.40 ±  3%  sched_debug.cfs_rq:/.h_nr_running.avg
      3.56 ±  2%     +34.4%       4.78 ±  5%  sched_debug.cfs_rq:/.h_nr_running.max
      0.66 ±  2%     +26.4%       0.83 ±  5%  sched_debug.cfs_rq:/.h_nr_running.stddev
      0.00        +1.6e+15%   15714991 ± 82%  sched_debug.cfs_rq:/.left_vruntime.avg
      0.00        +9.8e+16%  9.788e+08 ± 57%  sched_debug.cfs_rq:/.left_vruntime.max
     11774 ±  7%     +79.4%      21127 ± 42%  sched_debug.cfs_rq:/.load.avg
    137048 ± 57%    +338.4%     600854 ± 59%  sched_debug.cfs_rq:/.load.max
     14917 ± 53%    +409.5%      76002 ± 64%  sched_debug.cfs_rq:/.load.stddev
  12071011        +54878.0%  6.636e+09 ± 30%  sched_debug.cfs_rq:/.min_vruntime.avg
  17308223 ±  3%  +1.5e+06%  2.534e+11 ± 71%  sched_debug.cfs_rq:/.min_vruntime.max
   9463501 ±  2%   +2180.3%  2.158e+08 ±127%  sched_debug.cfs_rq:/.min_vruntime.min
   1956204 ±  3%  +1.4e+06%  2.727e+10 ± 69%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1.00           +55.6%       1.56 ± 22%  sched_debug.cfs_rq:/.nr_running.max
      0.05          +127.2%       0.12 ± 38%  sched_debug.cfs_rq:/.nr_running.stddev
      7.04 ± 19%    +753.6%      60.09 ±116%  sched_debug.cfs_rq:/.removed.load_avg.avg
     33.59 ±  9%   +1484.3%     532.16 ±128%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      0.00        +1.6e+15%   15966955 ± 81%  sched_debug.cfs_rq:/.right_vruntime.avg
      0.00        +9.9e+16%  9.896e+08 ± 56%  sched_debug.cfs_rq:/.right_vruntime.max
      2078           +19.6%       2485 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
      3250 ±  3%     +33.9%       4352 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
    496.81           +47.6%     733.33 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
      1386           +15.2%       1596 ±  4%  sched_debug.cfs_rq:/.util_avg.max
    493.44 ±  2%     -45.6%     268.33 ± 16%  sched_debug.cfs_rq:/.util_avg.min
    155.42 ±  3%     +28.3%     199.40 ±  2%  sched_debug.cfs_rq:/.util_avg.stddev
    734.47 ±  2%     +16.5%     855.34        sched_debug.cfs_rq:/.util_est_enqueued.avg
      1635 ±  3%     +21.4%       1986 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.max
    155.44 ± 15%     +24.8%     194.00 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.min
    301.21 ±  6%     +18.1%     355.87 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
      3943 ± 10%    +851.4%      37518 ± 10%  sched_debug.cpu.avg_idle.min
     26.01 ±  5%    +262.7%      94.33 ± 13%  sched_debug.cpu.clock.stddev
    162907           +10.1%     179321        sched_debug.cpu.clock_task.min
      1489 ± 34%     -39.3%     904.09 ±  4%  sched_debug.cpu.clock_task.stddev
      0.00 ±  3%    +193.4%       0.00 ± 13%  sched_debug.cpu.next_balance.stddev
      2.10           +14.4%       2.40 ±  3%  sched_debug.cpu.nr_running.avg
      3.61 ±  2%     +33.8%       4.83 ±  5%  sched_debug.cpu.nr_running.max
      0.64           +29.0%       0.83 ±  5%  sched_debug.cpu.nr_running.stddev
  16368908 ±  3%     -96.1%     641907        sched_debug.cpu.nr_switches.avg
  18892803 ±  2%     -86.5%    2559350 ±  4%  sched_debug.cpu.nr_switches.max
  12991247 ± 10%     -98.0%     263371 ±  6%  sched_debug.cpu.nr_switches.min
   1847756 ± 16%     -83.5%     304052 ±  3%  sched_debug.cpu.nr_switches.stddev
  29305629          +300.0%  1.172e+08        sched_debug.sysctl_sched.sysctl_sched_features
     11.51          +430.3%      61.02        perf-stat.i.MPKI
 2.555e+10           -76.6%   5.97e+09 ±  7%  perf-stat.i.branch-instructions
      1.47            -0.3        1.17        perf-stat.i.branch-miss-rate%
 3.733e+08           -81.7%   68308705 ±  7%  perf-stat.i.branch-misses
     10.56 ± 23%     +59.2       69.77        perf-stat.i.cache-miss-rate%
 1.519e+08 ± 22%    +762.5%   1.31e+09 ±  5%  perf-stat.i.cache-misses
  1.51e+09           +24.3%  1.877e+09 ±  6%  perf-stat.i.cache-references
  10910186           -95.1%     539736 ±  9%  perf-stat.i.context-switches
      2.00 ±  2%    +444.7%      10.90        perf-stat.i.cpi
     96010           +17.0%     112365 ±  6%  perf-stat.i.cpu-clock
 2.612e+11           +27.6%  3.333e+11 ±  5%  perf-stat.i.cpu-cycles
    783.88 ±  2%     +15.6%     906.45 ±  4%  perf-stat.i.cpu-migrations
      3028 ± 19%     -89.8%     310.17 ±  6%  perf-stat.i.cycles-between-cache-misses
  17166233 ±  6%     -77.5%    3856145 ± 43%  perf-stat.i.dTLB-load-misses
 3.826e+10           -77.1%   8.78e+09 ±  7%  perf-stat.i.dTLB-loads
      0.02 ± 14%      -0.0        0.01        perf-stat.i.dTLB-store-miss-rate%
   3844553 ± 14%     -90.1%     379087 ±  8%  perf-stat.i.dTLB-store-misses
 2.224e+10           -77.5%  4.999e+09 ±  7%  perf-stat.i.dTLB-stores
     55.44           +28.6       84.09        perf-stat.i.iTLB-load-miss-rate%
 1.324e+08           -78.0%   29068110 ±  8%  perf-stat.i.iTLB-load-misses
 1.074e+08 ±  2%     -94.8%    5569730 ±  7%  perf-stat.i.iTLB-loads
 1.331e+11           -76.5%  3.127e+10 ±  7%  perf-stat.i.instructions
      1029           +12.3%       1156        perf-stat.i.instructions-per-iTLB-miss
      0.51           -79.0%       0.11 ±  4%  perf-stat.i.ipc
      2.72            +8.7%       2.96        perf-stat.i.metric.GHz
    457.19 ± 10%     -54.4%     208.63        perf-stat.i.metric.K/sec
    913.44           -78.2%     198.86        perf-stat.i.metric.M/sec
      2395           +25.6%       3007 ± 13%  perf-stat.i.minor-faults
     70.38 ±  4%     -65.8        4.60 ± 22%  perf-stat.i.node-load-miss-rate%
  23739962 ± 35%   +1803.7%  4.519e+08 ±  5%  perf-stat.i.node-loads
     68.89 ±  6%     -63.6        5.25 ± 23%  perf-stat.i.node-store-miss-rate%
   4126003 ± 11%     +43.0%    5899737 ±  8%  perf-stat.i.node-store-misses
  21291131 ± 39%    +905.7%  2.141e+08 ±  6%  perf-stat.i.node-stores
      2395           +25.6%       3008 ± 13%  perf-stat.i.page-faults
     96010           +17.0%     112365 ±  6%  perf-stat.i.task-clock
     11.35          +445.6%      61.95        perf-stat.overall.MPKI
      1.46            -0.3        1.13        perf-stat.overall.branch-miss-rate%
     10.15 ± 23%     +61.2       71.32        perf-stat.overall.cache-miss-rate%
      1.96          +463.6%      11.07        perf-stat.overall.cpi
      1793 ± 21%     -86.0%     250.63        perf-stat.overall.cycles-between-cache-misses
      0.02 ± 13%      -0.0        0.01        perf-stat.overall.dTLB-store-miss-rate%
     55.22           +29.1       84.27        perf-stat.overall.iTLB-load-miss-rate%
      1005            +7.9%       1084        perf-stat.overall.instructions-per-iTLB-miss
      0.51           -82.3%       0.09        perf-stat.overall.ipc
     33.52 ± 21%     -31.5        2.03        perf-stat.overall.node-load-miss-rate%
     17.48 ± 28%     -14.7        2.76 ±  5%  perf-stat.overall.node-store-miss-rate%
     15369           -54.2%       7041        perf-stat.overall.path-length
 2.544e+10           -80.5%  4.951e+09        perf-stat.ps.branch-instructions
 3.718e+08           -85.0%   55888599        perf-stat.ps.branch-misses
 1.526e+08 ± 22%    +651.3%  1.146e+09        perf-stat.ps.cache-misses
 1.505e+09            +6.8%  1.607e+09        perf-stat.ps.cache-references
  10862971           -96.1%     424862 ±  5%  perf-stat.ps.context-switches
 2.603e+11           +10.3%  2.873e+11        perf-stat.ps.cpu-cycles
    780.37 ±  2%      -6.9%     726.59 ±  7%  perf-stat.ps.cpu-migrations
  17089014 ±  6%     -81.4%    3186378 ± 39%  perf-stat.ps.dTLB-load-misses
  3.81e+10           -80.9%  7.291e+09        perf-stat.ps.dTLB-loads
   3825690 ± 15%     -91.7%     318568        perf-stat.ps.dTLB-store-misses
 2.214e+10           -81.2%  4.155e+09        perf-stat.ps.dTLB-stores
 1.318e+08           -81.9%   23917524        perf-stat.ps.iTLB-load-misses
 1.069e+08 ±  2%     -95.8%    4467618 ±  5%  perf-stat.ps.iTLB-loads
 1.325e+11           -80.4%  2.595e+10        perf-stat.ps.instructions
      0.16 ±  5%     -34.7%       0.11 ± 23%  perf-stat.ps.major-faults
      2389           -14.4%       2045        perf-stat.ps.minor-faults
  11417554 ± 17%     -27.6%    8267014        perf-stat.ps.node-load-misses
  23993619 ± 35%   +1558.8%   3.98e+08        perf-stat.ps.node-loads
   4112378 ± 11%     +26.1%    5184959 ±  5%  perf-stat.ps.node-store-misses
  21561488 ± 39%    +746.0%  1.824e+08        perf-stat.ps.node-stores
      2389           -14.4%       2045        perf-stat.ps.page-faults
 4.014e+13           -80.1%  7.976e+12        perf-stat.total.instructions
     51.67 ± 14%     -18.5       33.19 ±  2%  perf-profile.calltrace.cycles-pp.accept_connections.main.__libc_start_main
     51.67 ± 14%     -18.5       33.19 ±  2%  perf-profile.calltrace.cycles-pp.accept_connection.accept_connections.main.__libc_start_main
     51.67 ± 14%     -18.5       33.19 ±  2%  perf-profile.calltrace.cycles-pp.spawn_child.accept_connection.accept_connections.main.__libc_start_main
     51.67 ± 14%     -18.5       33.19 ±  2%  perf-profile.calltrace.cycles-pp.process_requests.spawn_child.accept_connection.accept_connections.main
     20.95           -16.2        4.79 ±  3%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb
     20.81           -16.0        4.78 ±  3%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
     18.29           -16.0        2.30 ± 14%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
     20.53           -15.8        4.77 ±  3%  perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     18.50           -15.6        2.85 ± 12%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
     18.40           -15.6        2.84 ± 12%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
     17.65           -14.8        2.80 ± 12%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__do_softirq
     19.13           -14.5        4.64 ±  3%  perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     51.64 ± 14%     -13.1       38.51 ± 17%  perf-profile.calltrace.cycles-pp.recv_omni.process_requests.spawn_child.accept_connection.accept_connections
     15.45           -12.8        2.65 ± 12%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     15.39           -12.7        2.65 ± 11%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     14.89           -12.3        2.62 ± 12%  perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
     13.71           -12.2        1.49 ± 24%  perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
     12.26           -11.2        1.07 ±  5%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
     12.14           -11.1        1.05 ±  5%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
     10.44           -10.4        0.00        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
     12.01            -9.8        2.22 ±  4%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      9.58            -9.6        0.00        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
     11.31            -9.1        2.22 ±  4%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
     50.20            -8.8       41.39        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
      8.80            -8.8        0.00        perf-profile.calltrace.cycles-pp.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      8.73            -8.7        0.00        perf-profile.calltrace.cycles-pp.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
     49.07            -8.5       40.60        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     49.81            -8.4       41.44        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send.recv_omni
     48.58            -8.3       40.31        perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     12.05            -7.8        4.27 ±  8%  perf-profile.calltrace.cycles-pp.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      7.73 ±  2%      -7.7        0.00        perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
     11.72            -7.6        4.13 ±  8%  perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto
      7.39 ±  2%      -7.4        0.00        perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      7.17 ±  2%      -7.2        0.00        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      7.08            -7.1        0.00        perf-profile.calltrace.cycles-pp.sock_def_readable.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      6.94 ±  2%      -6.9        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_woken.sk_wait_data
      6.89            -6.9        0.00        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv
      6.48 ±  2%      -6.5        0.00        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_data_queue.tcp_rcv_established
      6.02 ±  6%      -6.0        0.00        perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_data_queue
      8.77            -5.7        3.05        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      7.93            -4.8        3.09 ±  2%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      6.62            -4.7        1.88 ±  6%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      5.44            -4.5        0.91 ± 10%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg
      5.90            -4.4        1.50 ± 22%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      5.04            -4.2        0.86 ± 11%  perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked
      6.92            -3.9        3.02 ±  2%  perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg
      7.84            -3.9        3.94 ±  8%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
      7.69            -3.8        3.94 ±  8%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg
      6.35            -3.7        2.67 ±  8%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      6.30            -3.6        2.67 ±  8%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      6.62            -3.6        2.99 ±  2%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked
      5.14            -3.4        1.73 ± 18%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established
      5.62            -2.9        2.74        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv
      3.26            -2.4        0.88        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      2.63            -1.8        0.82 ±  4%  perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      2.49            -1.7        0.83 ±  3%  perf-profile.calltrace.cycles-pp.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      2.51            -1.6        0.91 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.send_omni_inner
      2.11            -1.5        0.62        perf-profile.calltrace.cycles-pp.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      5.14            +0.2        5.29        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send.recv_omni
     35.59            +0.2       35.76        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      0.96 ±  2%      +0.4        1.31 ±  3%  perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      0.77            +0.5        1.25        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      0.69 ±  2%      +0.6        1.24 ±  4%  perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      0.65            +0.6        1.23        perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked
      0.00            +0.6        0.59 ±  7%  perf-profile.calltrace.cycles-pp.try_charge_memcg.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_wmem_schedule
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.try_charge_memcg.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_try_rmem_schedule
      0.53            +0.7        1.18        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.00            +0.7        0.65 ±  4%  perf-profile.calltrace.cycles-pp.skb_release_data.napi_consume_skb.net_rx_action.__do_softirq.do_softirq
      0.00            +0.7        0.65 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.rep_movs_alternative.copyout._copy_to_iter
      0.00            +0.7        0.66 ±  4%  perf-profile.calltrace.cycles-pp.napi_consume_skb.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
      0.70 ±  3%      +0.7        1.39        perf-profile.calltrace.cycles-pp.__sk_mem_reduce_allocated.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      0.00            +0.8        0.75 ± 10%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill
      0.34 ± 70%      +0.8        1.11 ±  9%  perf-profile.calltrace.cycles-pp.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg
      0.00            +0.8        0.80 ±  4%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      0.00            +0.8        0.80 ±  4%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      0.00            +1.0        0.95 ±  3%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_try_rmem_schedule.tcp_data_queue
      0.00            +1.0        0.99 ±  9%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked
      0.00            +1.0        1.00 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.rep_movs_alternative.copyout._copy_to_iter.__skb_datagram_iter
      0.00            +1.0        1.02 ±  2%  perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_try_rmem_schedule.tcp_data_queue.tcp_rcv_established
      0.00            +1.0        1.02 ±  3%  perf-profile.calltrace.cycles-pp.__sk_mem_schedule.tcp_try_rmem_schedule.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv
      0.00            +1.0        1.03 ±  2%  perf-profile.calltrace.cycles-pp.tcp_try_rmem_schedule.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      0.77 ± 13%      +1.2        1.95 ±  4%  perf-profile.calltrace.cycles-pp.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      0.75 ± 13%      +1.2        1.94 ±  4%  perf-profile.calltrace.cycles-pp.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.00            +1.3        1.33 ± 18%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page.skb_release_data
      0.00            +1.3        1.33 ±  3%  perf-profile.calltrace.cycles-pp.__sk_mem_reduce_allocated.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv
      0.00            +1.4        1.39 ± 18%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page.skb_release_data.skb_attempt_defer_free
      0.00            +1.4        1.43 ±  2%  perf-profile.calltrace.cycles-pp.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      0.00            +1.6        1.57 ±  3%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_recvmsg
      0.00            +1.8        1.84 ± 15%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page.skb_release_data.skb_attempt_defer_free.tcp_recvmsg_locked
      0.00            +2.0        1.98 ±  2%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      0.00            +2.0        2.02 ±  2%  perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      0.00            +2.1        2.06 ±  2%  perf-profile.calltrace.cycles-pp.release_sock.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      0.00            +2.5        2.48 ± 13%  perf-profile.calltrace.cycles-pp.free_unref_page.skb_release_data.skb_attempt_defer_free.tcp_recvmsg_locked.tcp_recvmsg
      0.00            +2.7        2.75 ± 13%  perf-profile.calltrace.cycles-pp.skb_release_data.skb_attempt_defer_free.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      0.00            +2.8        2.76 ± 13%  perf-profile.calltrace.cycles-pp.skb_attempt_defer_free.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      0.37 ± 71%      +3.6        3.93 ±  4%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked
      0.91 ± 13%      +3.8        4.66 ±  3%  perf-profile.calltrace.cycles-pp.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      0.84 ± 13%      +3.8        4.62 ±  3%  perf-profile.calltrace.cycles-pp.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.76 ± 13%      +3.8        4.55 ±  3%  perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg
      9.78           +12.3       22.07        perf-profile.calltrace.cycles-pp.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      8.50           +12.5       20.97        perf-profile.calltrace.cycles-pp.rep_movs_alternative.copyin._copy_from_iter.skb_do_copy_data_nocache.tcp_sendmsg_locked
      8.66           +12.5       21.20        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg
      8.95           +12.6       21.54        perf-profile.calltrace.cycles-pp._copy_from_iter.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
     38.27           +13.2       51.46        perf-profile.calltrace.cycles-pp.send_tcp_maerts.main.__libc_start_main
     38.20           +13.3       51.46        perf-profile.calltrace.cycles-pp.send_omni_inner.send_tcp_maerts.main.__libc_start_main
     37.21           +14.1       51.31        perf-profile.calltrace.cycles-pp.recv.send_omni_inner.send_tcp_maerts.main.__libc_start_main
     36.74           +14.7       51.43        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv.send_omni_inner.send_tcp_maerts.main
     36.45           +15.0       51.41        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.send_omni_inner.send_tcp_maerts
     32.61           +15.5       48.09        perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
     34.67           +15.8       50.46        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
     34.03           +16.3       50.32        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     33.61           +16.6       50.25        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     33.81           +16.7       50.47        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.send_omni_inner
     33.40           +16.8       50.24        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     10.03           +26.2       36.25        perf-profile.calltrace.cycles-pp.rep_movs_alternative.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
     10.63           +26.3       36.88        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
     10.40           +26.3       36.72        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked
     11.71           +27.0       38.69        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
     11.67           +27.0       38.68        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
     30.95           -22.7        8.27        perf-profile.children.cycles-pp.__tcp_transmit_skb
     28.25           -21.2        7.09        perf-profile.children.cycles-pp.__ip_queue_xmit
     25.80           -19.0        6.78        perf-profile.children.cycles-pp.ip_finish_output2
     25.05           -18.4        6.67        perf-profile.children.cycles-pp.__dev_queue_xmit
     25.15           -18.2        6.92 ±  2%  perf-profile.children.cycles-pp.tcp_write_xmit
     21.24           -15.4        5.87        perf-profile.children.cycles-pp.__local_bh_enable_ip
     20.92           -15.1        5.82        perf-profile.children.cycles-pp.do_softirq
     20.66           -14.5        6.14        perf-profile.children.cycles-pp.__do_softirq
     18.58           -14.2        4.41 ±  3%  perf-profile.children.cycles-pp.__napi_poll
     18.48           -14.1        4.40 ±  3%  perf-profile.children.cycles-pp.process_backlog
     18.62           -13.6        5.05 ±  4%  perf-profile.children.cycles-pp.__tcp_push_pending_frames
     17.72           -13.4        4.30 ±  3%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     19.22           -13.4        5.86        perf-profile.children.cycles-pp.net_rx_action
     51.67 ± 14%     -13.1       38.52 ± 17%  perf-profile.children.cycles-pp.accept_connections
     15.51           -11.5        3.98 ±  3%  perf-profile.children.cycles-pp.ip_local_deliver_finish
     15.45           -11.5        3.97 ±  3%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     14.99           -11.1        3.91 ±  3%  perf-profile.children.cycles-pp.tcp_v4_rcv
     11.68           -11.1        0.62 ±  6%  perf-profile.children.cycles-pp.__schedule
     58.35           -10.9       47.41        perf-profile.children.cycles-pp.__send
     19.92           -10.6        9.34 ±  2%  perf-profile.children.cycles-pp.tcp_v4_do_rcv
     19.11           -10.3        8.85 ±  2%  perf-profile.children.cycles-pp.tcp_rcv_established
     56.99            -9.5       47.50        perf-profile.children.cycles-pp.recv_omni
      9.55            -9.0        0.51 ±  5%  perf-profile.children.cycles-pp.schedule
     50.35            -8.9       41.47        perf-profile.children.cycles-pp.__x64_sys_sendto
     50.22            -8.8       41.43        perf-profile.children.cycles-pp.__sys_sendto
      8.96            -8.6        0.37 ± 11%  perf-profile.children.cycles-pp.sk_wait_data
     49.07            -8.4       40.63        perf-profile.children.cycles-pp.sock_sendmsg
     48.62            -8.3       40.35        perf-profile.children.cycles-pp.tcp_sendmsg
      7.86            -7.4        0.45 ±  5%  perf-profile.children.cycles-pp.wait_woken
      7.51            -7.1        0.43 ±  6%  perf-profile.children.cycles-pp.schedule_timeout
      7.09            -6.8        0.30 ±  9%  perf-profile.children.cycles-pp.sock_def_readable
      6.90            -6.6        0.34 ±  7%  perf-profile.children.cycles-pp.__wake_up_common_lock
      8.80            -6.5        2.33        perf-profile.children.cycles-pp.tcp_data_queue
     12.76            -6.4        6.38 ±  6%  perf-profile.children.cycles-pp.release_sock
      6.65            -6.3        0.32 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      6.36            -6.1        0.30 ±  8%  perf-profile.children.cycles-pp.try_to_wake_up
     12.03            -5.8        6.19 ±  6%  perf-profile.children.cycles-pp.__release_sock
      4.34            -4.2        0.17 ±  9%  perf-profile.children.cycles-pp.ttwu_do_activate
      3.90            -3.5        0.36        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      3.65 ±  2%      -3.5        0.14 ± 11%  perf-profile.children.cycles-pp.activate_task
      3.54 ±  2%      -3.4        0.14 ±  9%  perf-profile.children.cycles-pp.enqueue_task_fair
      3.23            -3.1        0.12 ±  6%  perf-profile.children.cycles-pp.pick_next_task_fair
      3.01 ±  3%      -2.9        0.13 ±  9%  perf-profile.children.cycles-pp.dequeue_task_fair
      2.80 ±  2%      -2.6        0.20 ±  6%  perf-profile.children.cycles-pp.__cond_resched
      2.44            -2.2        0.24        perf-profile.children.cycles-pp.exit_to_user_mode_loop
      2.33            -2.2        0.16 ±  5%  perf-profile.children.cycles-pp.update_load_avg
      2.41            -2.0        0.37 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      3.10            -2.0        1.06 ±  3%  perf-profile.children.cycles-pp.__alloc_skb
      4.79            -2.0        2.79        perf-profile.children.cycles-pp.tcp_ack
      8.18            -1.9        6.24        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.00 ±  2%      -1.9        0.08 ± 10%  perf-profile.children.cycles-pp.enqueue_entity
      2.03 ±  3%      -1.9        0.16 ±  5%  perf-profile.children.cycles-pp.update_curr
      1.88            -1.8        0.10 ± 12%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      2.77            -1.6        1.19 ±  2%  perf-profile.children.cycles-pp.tcp_stream_alloc_skb
      1.85 ±  3%      -1.6        0.29 ±  4%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      1.71 ±  3%      -1.4        0.26 ±  4%  perf-profile.children.cycles-pp.loopback_xmit
      1.40 ±  2%      -1.3        0.08 ±  6%  perf-profile.children.cycles-pp.dequeue_entity
      1.47            -1.3        0.20 ±  4%  perf-profile.children.cycles-pp.ip_rcv
      1.34            -1.2        0.10 ±  4%  perf-profile.children.cycles-pp.switch_fpu_return
      1.39            -1.1        0.27 ±  6%  perf-profile.children.cycles-pp.__kfree_skb
      1.05            -1.0        0.04 ± 71%  perf-profile.children.cycles-pp.select_task_rq
      1.05            -1.0        0.08 ± 10%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      1.00            -0.9        0.07 ± 11%  perf-profile.children.cycles-pp.prepare_task_switch
      0.92            -0.9        0.04 ± 70%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.90 ±  2%      -0.8        0.05 ±  8%  perf-profile.children.cycles-pp.__switch_to_asm
      3.38            -0.8        2.54        perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      0.80 ±  3%      -0.7        0.07        perf-profile.children.cycles-pp.sched_clock_cpu
      0.82 ±  2%      -0.7        0.10 ±  8%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.80 ±  3%      -0.7        0.11 ±  4%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.74            -0.7        0.05 ±  8%  perf-profile.children.cycles-pp.___perf_sw_event
      0.71 ±  3%      -0.7        0.05 ±  8%  perf-profile.children.cycles-pp.dst_release
      0.70 ±  2%      -0.6        0.06        perf-profile.children.cycles-pp.sched_clock
      0.83 ±  2%      -0.6        0.23 ±  5%  perf-profile.children.cycles-pp.sk_reset_timer
      0.78 ±  3%      -0.6        0.18 ±  5%  perf-profile.children.cycles-pp.__tcp_send_ack
      0.83            -0.6        0.24        perf-profile.children.cycles-pp.tcp_current_mss
      0.67            -0.6        0.08 ±  6%  perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      0.71 ±  4%      -0.6        0.13 ±  7%  perf-profile.children.cycles-pp.__netif_rx
      0.81            -0.6        0.24        perf-profile.children.cycles-pp.tcp_send_mss
      0.71 ±  7%      -0.6        0.14 ±  8%  perf-profile.children.cycles-pp.__inet_lookup_established
      0.82 ±  3%      -0.6        0.25 ±  4%  perf-profile.children.cycles-pp.tcp_event_new_data_sent
      0.69 ±  2%      -0.6        0.12 ±  6%  perf-profile.children.cycles-pp.netif_rx_internal
      0.62 ±  4%      -0.6        0.06 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      0.90 ±  4%      -0.5        0.35 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.59 ±  2%      -0.5        0.05        perf-profile.children.cycles-pp.native_sched_clock
      0.60 ±  2%      -0.5        0.06 ± 14%  perf-profile.children.cycles-pp.__sk_dst_check
      0.73 ±  2%      -0.5        0.22 ±  5%  perf-profile.children.cycles-pp.__mod_timer
      0.61            -0.5        0.10 ±  4%  perf-profile.children.cycles-pp.tcp_mstamp_refresh
      0.63            -0.5        0.12 ±  6%  perf-profile.children.cycles-pp.read_tsc
      0.61 ±  4%      -0.5        0.11 ±  4%  perf-profile.children.cycles-pp.enqueue_to_backlog
      0.56 ±  2%      -0.5        0.10 ± 12%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.59 ±  2%      -0.5        0.13        perf-profile.children.cycles-pp.kmalloc_reserve
      0.71            -0.4        0.26 ±  4%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.50 ±  3%      -0.4        0.07        perf-profile.children.cycles-pp.ip_output
      0.49 ±  2%      -0.4        0.08        perf-profile.children.cycles-pp.validate_xmit_skb
      0.46 ±  2%      -0.4        0.06        perf-profile.children.cycles-pp.update_cfs_group
      0.45 ±  3%      -0.4        0.07 ±  6%  perf-profile.children.cycles-pp.ip_rcv_core
      0.43 ±  5%      -0.4        0.07 ±  7%  perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.51 ±  3%      -0.3        0.17 ±  2%  perf-profile.children.cycles-pp.__entry_text_start
      0.36 ±  3%      -0.3        0.05        perf-profile.children.cycles-pp.recv_data
      0.34            -0.3        0.03 ± 70%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.65            -0.3        0.35 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      0.34            -0.3        0.05        perf-profile.children.cycles-pp.ip_local_out
      0.81 ±  3%      -0.3        0.52        perf-profile.children.cycles-pp.sockfd_lookup_light
      1.00 ±  4%      -0.3        0.73 ±  4%  perf-profile.children.cycles-pp.ktime_get
      0.50 ±  2%      -0.3        0.23 ±  3%  perf-profile.children.cycles-pp.aa_sk_perm
      0.35 ±  7%      -0.3        0.10 ±  8%  perf-profile.children.cycles-pp.send_data
      0.29 ±  3%      -0.2        0.05        perf-profile.children.cycles-pp.security_socket_recvmsg
      0.34 ±  2%      -0.2        0.10 ±  4%  perf-profile.children.cycles-pp.ipv4_mtu
      0.29 ±  2%      -0.2        0.06        perf-profile.children.cycles-pp.update_rq_clock_task
      0.37 ±  3%      -0.2        0.15 ±  3%  perf-profile.children.cycles-pp.tcp_tso_segs
      0.29 ±  4%      -0.2        0.07        perf-profile.children.cycles-pp.tcp_add_backlog
      0.61 ±  3%      -0.2        0.40        perf-profile.children.cycles-pp.__fget_light
      0.30 ±  4%      -0.2        0.09        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.29 ±  2%      -0.2        0.08 ±  5%  perf-profile.children.cycles-pp.tcp_rcv_space_adjust
      0.22 ±  2%      -0.2        0.03 ± 70%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.25 ±  3%      -0.2        0.08 ± 10%  perf-profile.children.cycles-pp.rb_erase
      0.38 ±  2%      -0.2        0.22 ±  2%  perf-profile.children.cycles-pp.lock_sock_nested
      0.25 ±  4%      -0.1        0.12 ±  7%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.17 ±  2%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.__list_add_valid
      0.15 ±  3%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.import_single_range
      0.15 ±  6%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.lock_timer_base
      0.33 ±  4%      -0.1        0.26 ±  4%  perf-profile.children.cycles-pp.__skb_clone
      0.12 ±  6%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.tcp_mtu_probe
      0.29 ±  2%      -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.10 ±  4%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.check_stack_object
      0.09 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.alloc_pages
      0.11            -0.0        0.09 ±  5%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.10 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.kfree_skbmem
      0.16 ±  3%      +0.0        0.18 ±  5%  perf-profile.children.cycles-pp.__tcp_cleanup_rbuf
      0.29 ±  5%      +0.0        0.31 ±  3%  perf-profile.children.cycles-pp.tcp_check_space
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__folio_put
      0.04 ± 71%      +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.account_system_index_time
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.record__pushfn
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__libc_write
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.writen
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.ksys_write
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.vfs_write
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.generic_perform_write
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.perf_mmap__push
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.__run_timers
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.kthread
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.run_timer_softirq
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.07            +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.07            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.task_work_run
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.__slab_free
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.run_builtin
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.cmd_record
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.__cmd_record
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.folio_test_hugetlb
      0.00            +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.sk_stream_write_space
      0.24 ±  6%      +0.1        0.34 ±  5%  perf-profile.children.cycles-pp.bpf_skops_write_hdr_opt
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.___slab_alloc
      0.23 ±  7%      +0.1        0.35        perf-profile.children.cycles-pp.__tcp_ack_snd_check
      0.34            +0.1        0.46 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.sk_stream_wait_memory
      0.03 ± 70%      +0.1        0.18        perf-profile.children.cycles-pp.__zone_watermark_ok
      0.12 ±  6%      +0.2        0.28 ±  3%  perf-profile.children.cycles-pp.sock_rfree
      0.16 ±  7%      +0.2        0.34 ±  2%  perf-profile.children.cycles-pp.tcp_queue_rcv
      1.47            +0.2        1.69        perf-profile.children.cycles-pp.__check_object_size
      0.09 ±  5%      +0.2        0.31        perf-profile.children.cycles-pp.skb_clone
      0.08 ±  6%      +0.2        0.31 ±  4%  perf-profile.children.cycles-pp.task_tick_fair
      0.22 ±  4%      +0.2        0.45 ±  2%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.22 ±  4%      +0.2        0.45 ±  2%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.00            +0.3        0.28 ±  5%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.00            +0.3        0.28 ±  3%  perf-profile.children.cycles-pp.skb_try_coalesce
      0.10            +0.3        0.40 ±  3%  perf-profile.children.cycles-pp.__build_skb_around
      0.00            +0.3        0.31 ±  3%  perf-profile.children.cycles-pp.tcp_try_coalesce
      0.00            +0.3        0.31 ±  3%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.53 ±  6%      +0.3        0.87 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_skmem
      0.00            +0.4        0.45 ±  4%  perf-profile.children.cycles-pp.__free_one_page
      0.22 ±  7%      +0.5        0.67 ±  3%  perf-profile.children.cycles-pp.__tcp_select_window
      1.06            +0.5        1.54        perf-profile.children.cycles-pp.check_heap_object
      0.79            +0.5        1.27        perf-profile.children.cycles-pp.simple_copy_to_iter
      0.03 ± 70%      +0.5        0.57 ±  2%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.34 ±  2%      +0.6        0.89 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
      0.43 ±  3%      +0.7        1.10 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.48            +0.7        1.15 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.44 ±  3%      +0.7        1.12 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
      0.00            +0.7        0.74 ± 11%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.57 ±  4%      +0.7        1.31 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.65 ±  6%      +0.8        1.41 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.64 ±  5%      +0.8        1.40 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.04 ± 73%      +0.8        0.81 ±  4%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.06 ±  8%      +0.8        0.86        perf-profile.children.cycles-pp.drain_stock
      0.33 ±  2%      +0.8        1.17 ±  2%  perf-profile.children.cycles-pp.refill_stock
      0.21 ±  4%      +0.9        1.09 ±  7%  perf-profile.children.cycles-pp.rmqueue
      0.33 ±  2%      +1.0        1.33        perf-profile.children.cycles-pp.free_unref_page_prepare
      0.39 ±  3%      +1.0        1.42 ±  6%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.69 ±  5%      +1.0        1.72        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.53 ±  3%      +1.1        1.60 ±  5%  perf-profile.children.cycles-pp.__alloc_pages
      0.86            +1.1        1.95 ±  5%  perf-profile.children.cycles-pp.sk_page_frag_refill
      0.82            +1.1        1.94 ±  4%  perf-profile.children.cycles-pp.skb_page_frag_refill
      0.84            +1.3        2.13 ± 15%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +1.3        1.31 ±  5%  perf-profile.children.cycles-pp.napi_consume_skb
      0.41 ±  4%      +1.3        1.73 ±  2%  perf-profile.children.cycles-pp.try_charge_memcg
      0.00            +1.4        1.36        perf-profile.children.cycles-pp.tcp_try_rmem_schedule
      0.76 ±  5%      +1.4        2.19        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.35 ±  3%      +1.7        3.05 ±  2%  perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
      0.00            +2.0        2.01 ± 13%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.00            +2.1        2.06 ± 15%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.19 ±  4%      +2.6        2.79 ± 12%  perf-profile.children.cycles-pp.skb_attempt_defer_free
      1.36            +3.0        4.32 ±  6%  perf-profile.children.cycles-pp.skb_release_data
      0.46            +3.1        3.53 ±  7%  perf-profile.children.cycles-pp.free_unref_page
      1.03 ±  4%      +3.6        4.67 ±  3%  perf-profile.children.cycles-pp.tcp_wmem_schedule
     94.82            +4.1       98.91        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.28 ±  6%      +4.2        5.51 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_charge_skmem
     94.25            +4.6       98.83        perf-profile.children.cycles-pp.do_syscall_64
      0.95 ±  4%      +5.2        6.17 ±  2%  perf-profile.children.cycles-pp.__sk_mem_schedule
      0.86 ±  5%      +5.3        6.12 ±  2%  perf-profile.children.cycles-pp.__sk_mem_raise_allocated
      9.82           +12.3       22.08        perf-profile.children.cycles-pp.skb_do_copy_data_nocache
     39.70           +12.3       52.03        perf-profile.children.cycles-pp.recv
      8.77           +12.6       21.34        perf-profile.children.cycles-pp.copyin
      8.95           +12.6       21.55        perf-profile.children.cycles-pp._copy_from_iter
     38.61           +13.3       51.93        perf-profile.children.cycles-pp.send_tcp_maerts
     38.54           +13.5       52.03        perf-profile.children.cycles-pp.send_omni_inner
     35.36           +15.5       50.90        perf-profile.children.cycles-pp.__x64_sys_recvfrom
     32.91           +15.6       48.51        perf-profile.children.cycles-pp.tcp_recvmsg_locked
     35.25           +15.6       50.88        perf-profile.children.cycles-pp.__sys_recvfrom
     34.32           +16.4       50.73        perf-profile.children.cycles-pp.sock_recvmsg
     33.90           +16.8       50.67        perf-profile.children.cycles-pp.inet_recvmsg
     33.72           +16.9       50.65        perf-profile.children.cycles-pp.tcp_recvmsg
     10.82           +26.5       37.30        perf-profile.children.cycles-pp._copy_to_iter
     10.63           +26.5       37.15        perf-profile.children.cycles-pp.copyout
     11.92           +27.2       39.14        perf-profile.children.cycles-pp.skb_copy_datagram_iter
     11.88           +27.3       39.13        perf-profile.children.cycles-pp.__skb_datagram_iter
     19.04           +39.2       58.27        perf-profile.children.cycles-pp.rep_movs_alternative
      1.86            -1.8        0.09 ± 10%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.16 ±  4%      -1.1        0.09 ±  5%  perf-profile.self.cycles-pp.update_curr
      1.15            -1.0        0.10 ±  4%  perf-profile.self.cycles-pp.__schedule
      1.36            -1.0        0.32 ±  2%  perf-profile.self.cycles-pp.__tcp_transmit_skb
      1.11 ±  2%      -1.0        0.09        perf-profile.self.cycles-pp.update_load_avg
      1.05            -1.0        0.08 ± 10%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      1.49 ±  2%      -0.9        0.62 ±  5%  perf-profile.self.cycles-pp.__dev_queue_xmit
      0.90 ±  2%      -0.8        0.05 ±  8%  perf-profile.self.cycles-pp.__switch_to_asm
      0.98 ±  3%      -0.8        0.16        perf-profile.self.cycles-pp.tcp_ack
      0.93            -0.7        0.21 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.79 ±  2%      -0.7        0.10 ±  8%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.83 ±  5%      -0.6        0.19 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.68 ±  3%      -0.6        0.05 ±  8%  perf-profile.self.cycles-pp.dst_release
      0.73            -0.6        0.11 ±  7%  perf-profile.self.cycles-pp.tcp_v4_rcv
      0.82            -0.6        0.22 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.69            -0.6        0.10 ±  4%  perf-profile.self.cycles-pp.ip_finish_output2
      0.62 ±  2%      -0.5        0.08 ±  6%  perf-profile.self.cycles-pp.__do_softirq
      0.59 ±  3%      -0.5        0.06        perf-profile.self.cycles-pp._raw_spin_lock
      0.57 ±  2%      -0.5        0.05        perf-profile.self.cycles-pp.native_sched_clock
      0.57 ±  2%      -0.5        0.07 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.61            -0.5        0.11 ±  7%  perf-profile.self.cycles-pp.read_tsc
      0.55            -0.5        0.08 ± 10%  perf-profile.self.cycles-pp.net_rx_action
      0.56            -0.5        0.10 ± 12%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.52 ±  3%      -0.4        0.07 ±  7%  perf-profile.self.cycles-pp.__sys_recvfrom
      0.56 ±  9%      -0.4        0.12 ±  8%  perf-profile.self.cycles-pp.__inet_lookup_established
      0.50            -0.4        0.07 ±  7%  perf-profile.self.cycles-pp.send_omni_inner
      0.68            -0.4        0.26 ±  4%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.51 ±  3%      -0.4        0.10 ±  4%  perf-profile.self.cycles-pp.__ip_queue_xmit
      0.45 ±  3%      -0.4        0.06        perf-profile.self.cycles-pp.update_cfs_group
      0.42 ±  3%      -0.4        0.03 ± 70%  perf-profile.self.cycles-pp.loopback_xmit
      0.61 ±  3%      -0.4        0.23 ±  2%  perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.44 ±  3%      -0.4        0.07        perf-profile.self.cycles-pp.ip_rcv_core
      0.41            -0.4        0.06 ±  8%  perf-profile.self.cycles-pp.process_backlog
      0.68 ±  3%      -0.3        0.37        perf-profile.self.cycles-pp.tcp_write_xmit
      0.65            -0.3        0.34 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      0.34            -0.3        0.03 ± 70%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.62            -0.3        0.32 ±  2%  perf-profile.self.cycles-pp.__sys_sendto
      0.33 ±  5%      -0.3        0.03 ± 70%  perf-profile.self.cycles-pp.ip_output
      0.43 ±  7%      -0.3        0.13        perf-profile.self.cycles-pp.tcp_rcv_established
      0.36 ±  3%      -0.3        0.07 ±  7%  perf-profile.self.cycles-pp.__mod_timer
      0.40 ±  6%      -0.3        0.11        perf-profile.self.cycles-pp.tcp_current_mss
      0.31            -0.3        0.03 ± 70%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.30 ±  3%      -0.3        0.03 ± 70%  perf-profile.self.cycles-pp.tcp_data_queue
      0.38 ±  8%      -0.3        0.12        perf-profile.self.cycles-pp.recv_omni
      0.39 ±  4%      -0.3        0.13 ±  9%  perf-profile.self.cycles-pp.__send
      0.67            -0.2        0.42        perf-profile.self.cycles-pp.tcp_recvmsg_locked
      0.45 ±  2%      -0.2        0.21 ±  4%  perf-profile.self.cycles-pp.aa_sk_perm
      0.34 ±  2%      -0.2        0.09 ±  5%  perf-profile.self.cycles-pp.ipv4_mtu
      0.28 ±  4%      -0.2        0.03 ± 70%  perf-profile.self.cycles-pp.tcp_v4_do_rcv
      0.36 ±  3%      -0.2        0.14 ±  3%  perf-profile.self.cycles-pp.tcp_tso_segs
      0.29 ±  4%      -0.2        0.08 ±  5%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.60 ±  3%      -0.2        0.40        perf-profile.self.cycles-pp.__fget_light
      0.26 ±  5%      -0.2        0.05 ±  8%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.28 ±  8%      -0.2        0.07 ± 11%  perf-profile.self.cycles-pp.send_data
      0.48            -0.2        0.27 ±  5%  perf-profile.self.cycles-pp.__alloc_skb
      0.23 ±  8%      -0.2        0.03 ± 70%  perf-profile.self.cycles-pp.tcp_event_new_data_sent
      0.23 ±  5%      -0.2        0.03 ± 70%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.25            -0.2        0.07 ± 11%  perf-profile.self.cycles-pp.do_syscall_64
      0.22 ±  2%      -0.2        0.03 ± 70%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.24 ±  5%      -0.2        0.08 ±  6%  perf-profile.self.cycles-pp.rb_erase
      0.29 ±  4%      -0.1        0.16        perf-profile.self.cycles-pp.__check_object_size
      0.22 ±  2%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.__entry_text_start
      0.17 ±  2%      -0.1        0.05        perf-profile.self.cycles-pp.copyout
      0.16 ±  3%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.__list_add_valid
      0.24 ±  3%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.27 ±  3%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.copyin
      0.10 ±  4%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.tcp_wmem_schedule
      0.17 ±  4%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp.skb_do_copy_data_nocache
      0.11 ±  7%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.tcp_mtu_probe
      0.10 ±  4%      -0.0        0.05        perf-profile.self.cycles-pp.check_stack_object
      0.27 ±  6%      -0.0        0.22 ±  7%  perf-profile.self.cycles-pp.tcp_check_space
      0.08 ±  6%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.__sk_mem_schedule
      0.19 ±  2%      -0.0        0.15 ±  6%  perf-profile.self.cycles-pp._copy_to_iter
      0.46            -0.0        0.43        perf-profile.self.cycles-pp.skb_release_data
      0.10            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.10 ±  4%      +0.0        0.11        perf-profile.self.cycles-pp.kfree_skbmem
      0.09 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.18 ±  2%      +0.0        0.21 ±  2%  perf-profile.self.cycles-pp._copy_from_iter
      0.13 ±  7%      +0.0        0.18 ±  5%  perf-profile.self.cycles-pp.__alloc_pages
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.07            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.___slab_alloc
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.__slab_free
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.folio_test_hugetlb
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.10            +0.1        0.19 ±  2%  perf-profile.self.cycles-pp.rmqueue
      0.20 ±  4%      +0.1        0.29        perf-profile.self.cycles-pp.skb_page_frag_refill
      0.23 ±  6%      +0.1        0.33 ±  5%  perf-profile.self.cycles-pp.bpf_skops_write_hdr_opt
      0.12 ± 10%      +0.1        0.26 ±  3%  perf-profile.self.cycles-pp.sock_rfree
      0.17 ±  5%      +0.1        0.31 ±  2%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.00            +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.31            +0.1        0.45 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.02 ±141%      +0.2        0.18        perf-profile.self.cycles-pp.__zone_watermark_ok
      0.38 ± 12%      +0.2        0.61 ±  6%  perf-profile.self.cycles-pp.ktime_get
      0.08 ±  6%      +0.2        0.31        perf-profile.self.cycles-pp.skb_clone
      0.24            +0.3        0.51        perf-profile.self.cycles-pp.__skb_datagram_iter
      0.00            +0.3        0.27 ±  3%  perf-profile.self.cycles-pp.skb_try_coalesce
      0.00            +0.3        0.28 ±  5%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.00            +0.3        0.29 ±  9%  perf-profile.self.cycles-pp.drain_stock
      0.10 ±  4%      +0.3        0.39 ±  2%  perf-profile.self.cycles-pp.__build_skb_around
      0.00            +0.4        0.39 ±  4%  perf-profile.self.cycles-pp.__free_one_page
      0.43 ±  8%      +0.4        0.83 ±  7%  perf-profile.self.cycles-pp.mem_cgroup_uncharge_skmem
      0.00            +0.4        0.41 ±  3%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.21 ±  5%      +0.4        0.66 ±  3%  perf-profile.self.cycles-pp.__tcp_select_window
      0.34 ±  3%      +0.5        0.84 ±  2%  perf-profile.self.cycles-pp.try_charge_memcg
      0.26 ±  3%      +0.5        0.80 ±  4%  perf-profile.self.cycles-pp.__sk_mem_raise_allocated
      0.50 ±  2%      +0.6        1.06 ±  2%  perf-profile.self.cycles-pp.__sk_mem_reduce_allocated
      0.03 ± 70%      +0.6        0.67 ±  3%  perf-profile.self.cycles-pp.page_counter_try_charge
      1.35 ±  2%      +0.6        1.99        perf-profile.self.cycles-pp.tcp_sendmsg_locked
      0.24 ±  3%      +0.9        1.18        perf-profile.self.cycles-pp.check_heap_object
      0.28            +1.0        1.29        perf-profile.self.cycles-pp.free_unref_page_prepare
      4.15            +1.7        5.86        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.00            +2.1        2.06 ± 15%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.74 ±  7%      +2.8        3.56 ±  5%  perf-profile.self.cycles-pp.mem_cgroup_charge_skmem
     18.81           +38.3       57.15        perf-profile.self.cycles-pp.rep_movs_alternative



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

