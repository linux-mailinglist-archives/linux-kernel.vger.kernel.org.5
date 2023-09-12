Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABF979D2DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbjILNxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbjILNw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:52:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8564510F1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694526773; x=1726062773;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=+onSet1+o2pf1NUnRkSP0EfVk29JKDhCjdyK4y6vAOs=;
  b=HC+2cS+zU0RMfG/PLbg5ObYVMKbPMDrjBVMW5TGLbO7S3n2Bsrc3NWVx
   DTVPmtL3lEhohIAM64pobcF0gXNrdgQgVrewoSQY97hwCgsHf88UWPEET
   y4tRAbPqBGzVfLREeIx71IgcIDYfhzaYHbyn7+s0stEijchtp6ePuEPhe
   c9hDd7Pc468cwygRaWeNYNAqZzazrlfmzWsmoRMYEm1r0P5hr/sQAUaKZ
   kMThCoQOIeB+OLD8RRMEEaiS2w/lHTR9gR9nTCBq3uUkXE+ESf+0sxx1b
   WqRHP4GeTXRLtTvwuMyfzwLxyqy/L2MBsrat1VOHTLd2Wfx1pCjhFKvzk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="381080557"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="381080557"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 06:52:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="743728057"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="743728057"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 06:52:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 06:52:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 06:52:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 06:52:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqyza85FHULXfq7TWojQTMVnsXDeJAm50TJETerTW6knMzdbhiAsM7/gFNMiaa8JoVSKCu6e25/oaUifCakqQFL5x9BvzzZqbXGmyKPU5XNh4ASae0opvLBEDn/tx0aQirqygqDuNqtYbCKsZBtSoQLlP01CqCjyQOIeRR7bU8qP/EZ4Br6AIDNVgGHw7TPFzon8w5nSSVII1Qj9NiEc1Tvl2+RBtTVt2yYksEp4FYNbRc2NYNYvDS4LRFmLdqDY1i83n7y3P4zY3s4wfBvnxQ3m39i6O4T0hhepQfwnND24jsNRRI8soCcs5yw+VqGrZoBa1OjrrAe1+arx2SRqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x64sLuow0Hu+IBZJe64uSMV1pmjvOfZXAALmuS1nH4A=;
 b=GT/obd/frGgObZqx3p01NN1C2U4lKbKNeotg81Kp/OcSbXCmTfGUkTCwO87mN1Oju1+ZMvjywxJbr/6ZQvW7H7+kbdJb4LJd9RlS9wITyNPKEvICaTb0TNnkmgaplSHd/wr0brrVyqpvXwNfhi3MOPZ5FqxHhctaC/OsFB5YkjeVVrLH+OzplOhU7ZjhRvcvkQBUKfl880WM4nf9AA18i+jfpSsTreI2pKwAIi/5bcaBFFne0OMQSAMgDkLIKX+nHYVK77fEIiCEphDzMUQklnY5/wvFcRUT/MkW+YIIBfFWzeqT0WVxFPxdCKodfkdpJxFCXRusb5rszHpAZwB/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA1PR11MB7889.namprd11.prod.outlook.com (2603:10b6:208:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Tue, 12 Sep
 2023 13:52:50 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 13:52:50 +0000
Date:   Tue, 12 Sep 2023 21:52:39 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Dennis Zhou <dennis@kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [kernel/fork]  14ef95be6f:
 phoronix-test-suite.osbench.LaunchPrograms.us_per_event -8.2% improvement
Message-ID: <202309122106.b440c4c6-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA1PR11MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 47710bf3-eb37-46de-73dc-08dbb3978d81
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zD0chltnd8JD2nz7yFqaOrNJ7c4WThddsp/NM8jitr3XVNUY/0VwwkM6/ZjxvKGhQ1r2ps5KtNdpO0lyfGSUvg1ksKPl1bHdq021sQqismMdny2Q2bueIVZ7WvrYZSGcEmqWNE16F/VInksidHlbSQHAiAeXqmklPQT6BZ6S/C1fdPOPcFxNQGyo2d/ZCwzY4azvrLQwSt3rhiKBIiCSasUe5rDcJVEZmUPlvjwe9mQzUldVH0mBl+vbsxR7X3oIvo+fgLCMNInNrVld1OKlgSnP9DoY+0Tm8rtWVivJuBCKZJZ2ZYMuq9PVxfAS9VDtIopt0WtT5r3cDzmIqTa5tsHsNvqiiQZL7N06KLCWYSqZt52wJt3dkC0OSrzFsQSawPcfsnmyHr3oGOkkGss1ahmb+tsGv1FyxroWtVONR4IuqVlqLelXSiz18sRi28v9EBpTXhhH9oU8yD4rPlDmbYy2cELWj19DU9aKXFVQuM7dn4z3iXZteLJg+GR8IyTUoOFXXXDr5OP/Z0yf2Utr5+LCTMctxOYDe2q6XP9XRm46HBi7M+78drmm+iFtcRW0mhEVHzUKcD2zsvrzyvXbXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(186009)(1800799009)(451199024)(2906002)(83380400001)(41300700001)(6916009)(316002)(966005)(6486002)(478600001)(66556008)(2616005)(66476007)(66946007)(107886003)(26005)(6512007)(6506007)(1076003)(6666004)(38100700002)(86362001)(5660300002)(8936002)(8676002)(36756003)(4326008)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FTMT+SH+Svl4s1DBcDJdvwcWlatpLbl1jrwEu96fVD3NCfbnm28tUggvq/?=
 =?iso-8859-1?Q?PHkyvQft4vKNHvu5kzAEVjp8XywLJMHFTp2PCM5K6drbQFWyRhHgRHmRrF?=
 =?iso-8859-1?Q?oSBh6shCWghaoGfPJRrAVS5cEwtBMqpEEf/0gUjIlGPUft9sHRAQ5sF+Gm?=
 =?iso-8859-1?Q?qS5J5+R/Zx3lj2eg5bJ9J99bBNSMjQ7R7DyCfShQlccCKo5iL66Az1h0s8?=
 =?iso-8859-1?Q?Pe20BizFEx7mm1+zm+2/QpUOy3QkiBpIK1IxibOtuIj+zTQgkh2JNnSGaG?=
 =?iso-8859-1?Q?4ElxOMKRCobqeDhdYgM2tYojNnygkuH2Sdt+cLzS75vGReRwuF838sOqyF?=
 =?iso-8859-1?Q?4ERlYoFBmeCGqSnK7mGnP3u59ytxS/JhlpXowYcsrGLk/kblTeT6+gDyhu?=
 =?iso-8859-1?Q?Ue0WWttDlSpb5Z20aymWB1TnednnP1QNgRJuznNceS4afjvhGTkDrd/uMF?=
 =?iso-8859-1?Q?kIfpeLfBMc9svjfw+LnMIkWFsNCryjtSWE/Cq7gXalqBN015+wpT/kw2SL?=
 =?iso-8859-1?Q?MqnsY/tagCEeHDnCXHJODAR607ZeHqLzI03ImrfLLRSRmaOyTN06vYicrD?=
 =?iso-8859-1?Q?FFYqyapZiDXzPccoXY+LxQePJAfnGjdlJyhkj1+0Vn0oUojHWcnssTTttg?=
 =?iso-8859-1?Q?x0oA+YiTvw5vCQSgJo4u15Pd/q5zxJOIQ5NgFiMeF3NFkYs+1VpvoiqhkN?=
 =?iso-8859-1?Q?AvVTq42ek5V44rPCoRngT6The/Orf5vA6QKcT+Idkgb9yx8SFDCWm8Vnnc?=
 =?iso-8859-1?Q?52rgBDN6tE03ZRRHgsI4pRsB9s+cKVxoT2vi28VQeepDejh+5cDK8dtgA4?=
 =?iso-8859-1?Q?/rJx+m2gE1WNZ4CGUEVPSiKNqS5V/JSGPsmA6d9cTHVZXPnKnddyWtz+DX?=
 =?iso-8859-1?Q?ThD9F770RpE9Av5eZ6pwAotyzcTJ3+6o9mYPbFpUyODEkUDSplNmaBXLjh?=
 =?iso-8859-1?Q?yWe4kFuTO1RONdvkNu+k2FiQv/yOXFMNeM5reqATRPv6eDJ8ZsHSNNmydX?=
 =?iso-8859-1?Q?pLdWO2bltv9HTNJ8iHAoceW8MnS3EyH+4Ce74+UGCtqODQznm870smHnfK?=
 =?iso-8859-1?Q?2bB4WrIer3xvd3Suzr23um85JNOLCxG6QIGJ7jMmkIoMRf3BTZtOs76rt+?=
 =?iso-8859-1?Q?VAsMBAYSKYp3bLkZYjmbgmN2GyHcczWX9vE1qfRwLwa9jDr5QTZ+ShqvKC?=
 =?iso-8859-1?Q?D7r88ifEByW9CaZo+b7oN2B+ZxiklffpCrxDuPXsXMUAXAifD5fPieLC2H?=
 =?iso-8859-1?Q?SgzKUkwXzIZnPUfle04JinVdtxJXT70/3r2K6W/1j0R3ZVAmP79bDRoed7?=
 =?iso-8859-1?Q?DGtKhkaJ3vH1MrBEyOx5RQW6Nb2p/R3Fd6kRim+idSjroFWwREFuvZ7W5x?=
 =?iso-8859-1?Q?ZbQ3raRVzctg7DhQ3F5Sw6kLbKReyGfItTgDj9KmmpkdkwdI4dT+DSzSKC?=
 =?iso-8859-1?Q?lIrDgjqqF+nM0uewz1JEfET6awRaE5FQBDYs++hVtxadMM748sby8c5GUs?=
 =?iso-8859-1?Q?zH1Szv0Akst50Ju+0Ncb04c498D2ar9PTnyt5j/REjbB/FyaZxjnAXAE8o?=
 =?iso-8859-1?Q?DEUvTz4+yujryouSl/3AqgXMh6qRIig2aZ3lqffHPwR6PHeUE4PNYI7efQ?=
 =?iso-8859-1?Q?COSPl7lHpUNKyCZfmNmx3UsbvLuPlvl4TcB29eVWkjCofI2cTrEHE1Og?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47710bf3-eb37-46de-73dc-08dbb3978d81
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:52:50.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFdrWFvOB9SXwpGHbFKtCW7CwnkRCM5dkPeOhxqz+1DYNnlTLkdXu4Pzxn1YY9gHvrUf8YdJ48ro19IKpmkkpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7889
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a -8.2% improvement of phoronix-test-suite.osbench.LaunchPrograms.us_per_event on:


commit: 14ef95be6f5558fb9e43aaf06ef9a1d6e0cae6c8 ("kernel/fork: group allocation/free of per-cpu counters for mm struct")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: phoronix-test-suite
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
parameters:

	test: osbench-1.0.2
	option_a: Launch Programs
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230912/202309122106.b440c4c6-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/Launch Programs/debian-x86_64-phoronix/lkp-csl-2sp7/osbench-1.0.2/phoronix-test-suite

commit: 
  c439d5e8a0 ("pcpcntr: add group allocation/free")
  14ef95be6f ("kernel/fork: group allocation/free of per-cpu counters for mm struct")

c439d5e8a0deb731 14ef95be6f5558fb9e43aaf06ef 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      5222 ± 19%     -22.2%       4060 ± 16%  numa-meminfo.node1.Active(anon)
      1.69            +0.1        1.80 ±  2%  turbostat.C1E%
     14072            +4.1%      14642        vmstat.system.cs
      1306 ± 19%     -22.3%       1014 ± 16%  numa-vmstat.node1.nr_active_anon
      1306 ± 19%     -22.3%       1014 ± 16%  numa-vmstat.node1.nr_zone_active_anon
     98.32            -8.2%      90.23        phoronix-test-suite.osbench.LaunchPrograms.us_per_event
   9835435            +8.4%   10659372        phoronix-test-suite.time.minor_page_faults
    314.33            +7.1%     336.67        phoronix-test-suite.time.percent_of_cpu_this_job_got
     83.25            +9.8%      91.44 ±  3%  phoronix-test-suite.time.system_time
    151162            +8.7%     164239        phoronix-test-suite.time.voluntary_context_switches
   9116125            +7.9%    9839611        proc-vmstat.numa_hit
   9115159            +7.7%    9818723        proc-vmstat.numa_local
      8183 ±  5%     -36.5%       5197 ± 70%  proc-vmstat.numa_pages_migrated
   9972768            +7.9%   10764494        proc-vmstat.pgalloc_normal
  10251204            +8.1%   11080823        proc-vmstat.pgfault
   9845664            +8.0%   10637337        proc-vmstat.pgfree
      8183 ±  5%     -36.5%       5197 ± 70%  proc-vmstat.pgmigrate_success
    207326            +7.0%     221825        proc-vmstat.pgreuse
      5.18 ± 13%      -0.9        4.32 ± 19%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      9.03 ± 23%      -2.8        6.21 ± 20%  perf-profile.children.cycles-pp.asm_exc_page_fault
      7.18 ± 27%      -2.5        4.70 ± 19%  perf-profile.children.cycles-pp.exc_page_fault
      7.02 ± 27%      -2.4        4.59 ± 17%  perf-profile.children.cycles-pp.do_user_addr_fault
      1.60 ± 11%      -1.1        0.47 ± 75%  perf-profile.children.cycles-pp.wp_page_copy
      0.78 ± 38%      -0.5        0.33 ± 34%  perf-profile.children.cycles-pp.__mmdrop
      0.49 ± 46%      -0.4        0.14 ±111%  perf-profile.children.cycles-pp.wake_up_new_task
      0.76 ± 29%      -0.5        0.21 ± 83%  perf-profile.self.cycles-pp.copy_mc_fragile
      0.10 ±101%      +0.2        0.29 ± 32%  perf-profile.self.cycles-pp.kmem_cache_free_bulk
  19578013 ±  3%      +7.1%   20966194 ±  2%  perf-stat.i.cache-misses
 1.648e+08            +3.3%  1.702e+08        perf-stat.i.cache-references
     14793            +3.9%      15372        perf-stat.i.context-switches
      3.13            +6.0%       3.32 ±  3%  perf-stat.i.cpi
  1.34e+10            +5.1%  1.408e+10        perf-stat.i.cpu-cycles
   2995824 ±  3%      -6.1%    2812561 ±  2%  perf-stat.i.dTLB-load-misses
 2.399e+09            +3.9%  2.493e+09        perf-stat.i.dTLB-loads
 1.255e+09            +3.9%  1.303e+09        perf-stat.i.dTLB-stores
   1908762            +3.4%    1973692        perf-stat.i.iTLB-loads
 9.658e+09            +2.8%  9.931e+09        perf-stat.i.instructions
      0.58            -3.8%       0.56        perf-stat.i.ipc
     22.17 ±  5%     +33.6%      29.63 ±  7%  perf-stat.i.major-faults
      0.14            +5.1%       0.15        perf-stat.i.metric.GHz
     59.57            +3.4%      61.62        perf-stat.i.metric.M/sec
    251853            +6.9%     269294 ±  2%  perf-stat.i.minor-faults
    549142 ±  3%      +9.6%     601791 ±  2%  perf-stat.i.node-loads
    833543            +6.0%     883652 ±  2%  perf-stat.i.node-stores
    251875            +6.9%     269324 ±  2%  perf-stat.i.page-faults
     11.87 ±  2%      +0.4       12.31        perf-stat.overall.cache-miss-rate%
      1.39            +2.2%       1.42        perf-stat.overall.cpi
      0.12 ±  3%      -0.0        0.11 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
      2511            +1.5%       2549        perf-stat.overall.instructions-per-iTLB-miss
      0.72            -2.1%       0.71        perf-stat.overall.ipc
     81.09            -1.4       79.72        perf-stat.overall.node-store-miss-rate%
  19054112 ±  3%      +7.1%   20408724 ±  2%  perf-stat.ps.cache-misses
 1.605e+08            +3.4%  1.658e+08        perf-stat.ps.cache-references
     14397            +3.9%      14963        perf-stat.ps.context-switches
 1.305e+10            +5.1%  1.371e+10        perf-stat.ps.cpu-cycles
   2918655 ±  3%      -6.1%    2741385 ±  2%  perf-stat.ps.dTLB-load-misses
 2.334e+09            +4.0%  2.427e+09        perf-stat.ps.dTLB-loads
 1.221e+09            +3.9%  1.269e+09        perf-stat.ps.dTLB-stores
   1857710            +3.4%    1921204        perf-stat.ps.iTLB-loads
 9.399e+09            +2.8%  9.666e+09        perf-stat.ps.instructions
     21.57 ±  5%     +33.7%      28.83 ±  7%  perf-stat.ps.major-faults
    245071            +6.9%     262088 ±  2%  perf-stat.ps.minor-faults
    534454 ±  2%      +9.6%     585755 ±  2%  perf-stat.ps.node-loads
    811200            +6.0%     860097 ±  2%  perf-stat.ps.node-stores
    245093            +6.9%     262117 ±  2%  perf-stat.ps.page-faults
 3.723e+11            +4.2%  3.878e+11        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

