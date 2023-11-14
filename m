Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DAC7EAA3F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 06:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjKNFox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 00:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKNFou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 00:44:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F941135
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 21:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699940684; x=1731476684;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=JjACH7zNAL1SbVQcY/A3UJc/KHcCrqCinyIQegqGum0=;
  b=XdCIA1NsnTGITV2hT07cDdcRWaGHvkuM1a4IM6r8M/QeAc/2/Ehnt8je
   Ub6PspTtHdBEqgaryyeW4xheGSMEmAZBx13AD28B2tNNi8VCnCxi8tytH
   DferPXhw6znxtNj0p0iYsGj2SGqUc9byuRUlweXoHPA/2l+Gj046/9zHP
   rSKrhSvclTAS6iSzhw7vUmHbd8ohj8IX0d41LXPzbj+pysevSoBDIECoA
   7PdHHqS0n/RHslgnVKvKs8K4osZWFzLdII/SAPDyKjmQhrq+J9T4EHTSI
   MFCLjxuMrhzhbzB//hpnJxYAOcZkkPLsmHD7ewWyNFnWiA3ARfOEUEhHi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="390383999"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="390383999"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 21:44:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="12685021"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 21:44:43 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 21:44:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 21:44:42 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 21:44:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cj/xfN+lEtpAQtpMHDPTmXNg02jwbiJTApifJUZNiRmsk9Mvus0d1rWxhnY+2Kt42ppFE7lW216YslZlJIX99d9O/e/gIWUKrMtHWLFogiE593oxI0QQKYniJZ2rW6wFByjCnkym3JJaUstOZdZtxFijPFZ/qO0G9czFBJPWC/Cw5MilS0gqr+818Jv94d+BybSFJ/xkUfuA4sCyAXaBs3T4OZttq8wPHNZBiptj0Z4nS9l5PLaI+3mfqC+mjmyHYniLCiIenj/57+G3ls1maImmH8XUgyFqTGpQEj/r+HtDeBE72ug5Ddk+E43yI38XxLtSE2PBCCD6TyFP030hHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXprqdjEyOR8I8mWciVdPqfLgrvGXbCXsIJFRvVzY+Y=;
 b=IZcJCgwrKyUawnoAk1sG7u23ZoUjYfev9nZp2sHolsQhpk5gnPBSC6gGwMjkoeek1XPe8f2/2JA4GPCMnLztoMUl+3M5A5Z65GHo2b7EL7b7moGP9b2qtvMk5sfVrV6hM/r9NnDyDjdrcl8LCzMNSRGiupCtSOUWSRyZTV0kxRkVb6jeYXfPSaRPRiRD8XSoqMDiEeKBLR5HG7KR0Z7NYSHpNHsesHShcEufja3LeGSWm2ExUW3OYilf7Tne4fjNs8vR4Et1ccfnoaAmEIS3cvHKS3cLxZ4batcPgsQZcmHDJ1526V1IMxu+1FpdFSsebYjZY/kfCOE7wIThRYcpRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22)
 by SA3PR11MB8002.namprd11.prod.outlook.com (2603:10b6:806:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 05:44:39 +0000
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::da78:347a:db6a:ed75]) by SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::da78:347a:db6a:ed75%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 05:44:39 +0000
Date:   Tue, 14 Nov 2023 13:44:28 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     <chengming.zhou@linux.dev>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <cl@linux.com>, <penberg@kernel.org>,
        <rientjes@google.com>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <roman.gushchin@linux.dev>,
        <linux-kernel@vger.kernel.org>, <chengming.zhou@linux.dev>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH v5 6/9] slub: Delay freezing of partial slabs
Message-ID: <202311141204.e918dbda-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231102032330.1036151-7-chengming.zhou@linux.dev>
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To SJ0PR11MB6792.namprd11.prod.outlook.com
 (2603:10b6:a03:485::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6792:EE_|SA3PR11MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 5244ab12-0fcc-4ee1-d332-08dbe4d4caa9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7O6fk2KRcEy1XhEWXyf6W8o22UlvVYaxCNj8nLjHNkQogsq2AEmumVcQqfPUKkWl2b4+BkBKsVxpke3pEH5jZVDzhTztEiOky80eQeybEPq+B+q/E6hGDwf3HoMKvACuPChq/7kNUZqgJPJIIAsqHW1gLnvXwfGoAixxnQYYMWl4MZiSCJ7Vvompc0pHnxMm7S5H7p0hxaDj2fKlTkfJUogZJOEsUWc2z4kvZSQ+U519hVs/Oku+EUWSEMe9iD7jPkNfzpFiDB+qki55VLeufKVD1kH/jILn3FZIY7lzLEGoZkJDjPDSd78ngEvoHVhWfN4H8+MhoiaS2XyuCQKRfV+CT5h7Drl7ZIQ7GflBbbSUB62Bmd83GoolFMNX9ingz8sNO+LA8o3tA14KS5ZFgV2wYX57N9gqo1u7LAS+IvYUTSKJuSMecuFLdyiYcDN5/IWY+R+75Jtd2xY5pb1booeB1JN9lSJRUy4uLXv340pZEGblyk+/2YxVYsuYOGRTEKMVYWiQlnu9O//dyzxWy1j8A4nWL5f7HWS7jnllUGk0kr7dWrvMqJh+NnDRibaJ/n1Un96CU1dpNHG4z+IEeF38ErHnIPRbsOMZ0M8QtV0Cflt2JVbbOdy9kouhz/gPucT44a7xAxfKYSzhYEU7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230473577357003)(230373577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(83380400001)(86362001)(5660300002)(478600001)(30864003)(7416002)(6506007)(41300700001)(6666004)(2616005)(6512007)(38100700002)(316002)(8936002)(8676002)(4326008)(6916009)(82960400001)(1076003)(36756003)(26005)(107886003)(66946007)(54906003)(66476007)(66556008)(966005)(6486002)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DqrC2DQ274sldA4gYie9yXN0O2VrGEXsd47oeo+eBp9b9LmuRB920zm86C?=
 =?iso-8859-1?Q?v234PV1xuHsia+3F4c8YAztM4vBzvntLaEQoXG0+XJhVFG/0ew1/JhrLp9?=
 =?iso-8859-1?Q?L9QAIbbQm+EaQRY27S89EM3+NN8gQv7O8MkFTAKsWDs73vM4HqfxcQsqvs?=
 =?iso-8859-1?Q?+ue6zJ15kN5iSxLZNUUyXgEV/jtR4WnZHLkpokvWm9isnlVB9aIye7AaGp?=
 =?iso-8859-1?Q?lVYjYHMd/FrqOJB8J6e1Dv8WsJz7am8Xe0m/10fjJxKcQ82ZrnWQ3nvHx+?=
 =?iso-8859-1?Q?xtdARHDLQSo2LlUn+Cz/CsqYZXtDndTgxcBEHOC+J60nTp0AjJckHAkV5B?=
 =?iso-8859-1?Q?Ax+IFyMHmkjIpkxBfdz9Srb+Ia8OMWTARXdtAjCnGvsnW7AuxlhecNgkKw?=
 =?iso-8859-1?Q?S953vb+39Ww+NjwWIdGPE9xJp02Vzk6RpvNY+TREkgOphGwigKkHZKNW/z?=
 =?iso-8859-1?Q?sIjZr9N+w+XYvIZYYwUW/OAsZVDlAwZnR2lH9pZMOcTD7PYx3Gum9WUEkN?=
 =?iso-8859-1?Q?5XnNt9V+r1QXZ1SnSUqm0onIt1+j6YHR4+GWfxtW71Yl95uY6m5piIAF8Q?=
 =?iso-8859-1?Q?/7nyZclIOmD7lPF+RvrXm2/L8mW6u9bwb95jR3ac4n3LL9ZRkLiCZ5CdAG?=
 =?iso-8859-1?Q?PgPeGn7gKckTavDuws/VwFKBZREXmPIpJV42mNPBxsmMBr2o8DAFMcU1qy?=
 =?iso-8859-1?Q?uDmTC8RNvA3tHNJigZ9xSZLstUx0p/iqxMpRKGTermuq1HcnRLWvjOYXp4?=
 =?iso-8859-1?Q?UgEeTcjstF4NtaIM4fwH9Dw3G8oEQiXyRHDwYWx4IlxmgCvzfN7e5g/jrY?=
 =?iso-8859-1?Q?Bua9j+Dw/BDepAYYUUyMb0WqRcQNmA0rzpNoo42kyWP4cGqDn1gnvQ6jYZ?=
 =?iso-8859-1?Q?HoScixr0KYzhPuy+wVEfb7c22Vjr6IEyGXR0imHO7WlZqPJ+alUndULh2X?=
 =?iso-8859-1?Q?zBQDnsYYFdk2T3aEj7EM5w0S0R+ruXKOeo3pUjDDULhikpPjc5hawJsuPc?=
 =?iso-8859-1?Q?m/+Fwe+oVDUN4EPvE6r+RA+PFpRKrEycoK+ggL2w+al/olLZ/Sy5l33G8W?=
 =?iso-8859-1?Q?2HM4dwQXAegGpovlBVCiERjlvC52kJ7KYAUu+CK7pioLgxdXaQCtSddzUE?=
 =?iso-8859-1?Q?keWnn8jYxER8eHicE6XlHOfEvOiol8apTwUT2Uucz2hMXjWDA1OKA9B1Nv?=
 =?iso-8859-1?Q?lOtB4dcG+kY+qKRXXj3QzCzTG1UbBWGv7ivakFd9emYH80WXLW0kLjn3WG?=
 =?iso-8859-1?Q?ql+ml87Xcf8hj6QUAIqCrgP4FBHzs1wd7sfYFhcRyq4V0cr9WoAhqNU2kb?=
 =?iso-8859-1?Q?6Q2E60ZRZ5gqb4v6xbH7Q9DMCoEUhuAOTc+W4SV4q68ejx8kc/ChUP91V4?=
 =?iso-8859-1?Q?dl6M65daZ4w24pvmFXNdZdy68ePlVwrwt6Sc/y0WAHjopqkc8rYV0HKBRo?=
 =?iso-8859-1?Q?YG7x1qslvrO867kr8EJVsXPGSVW8HBlT1ksVv3h+4pFUpZ0hMzBjWYA4nC?=
 =?iso-8859-1?Q?Ul5MzNTILdmL9M+pv5NgtbkXh3FJMorp91eEpEalgGJynvu+RT8qIapbmW?=
 =?iso-8859-1?Q?GoHHy+tcyDHlFbCpBIMkdnendU1h7Re4j1Ll81M2TldMtEUEOWcPcSiXQS?=
 =?iso-8859-1?Q?OPjBGgsP+iTANZlLidjFIHTGUuL1hJP+7c5bkEXC1ZNaRjThU10MVH4A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5244ab12-0fcc-4ee1-d332-08dbe4d4caa9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 05:44:39.1266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wY35LjkspnGRDsLGKwHlg+1Ej5+HfeyaHdf/sdxRRlRO7cC+iPqeo031GhjyAzY7/1eN5skERmIF0jMOvezZNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8002
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 34.2% improvement of stress-ng.rawudp.ops_per_sec on:


commit: b73583016198aecef1dea07033a808da7875ede1 ("[PATCH v5 6/9] slub: Delay freezing of partial slabs")
url: https://github.com/intel-lab-lkp/linux/commits/chengming-zhou-linux-dev/slub-Reflow-___slab_alloc/20231102-112748
base: git://git.kernel.org/cgit/linux/kernel/git/vbabka/slab.git for-next
patch link: https://lore.kernel.org/all/20231102032330.1036151-7-chengming.zhou@linux.dev/
patch subject: [PATCH v5 6/9] slub: Delay freezing of partial slabs

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	class: network
	test: rawudp
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231114/202311141204.e918dbda-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  network/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/rawudp/stress-ng/60s

commit: 
  fae950af3a ("slub: Introduce freeze_slab()")
  b735830161 ("slub: Delay freezing of partial slabs")

fae950af3a484ec4 b73583016198aecef1dea07033a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.51 ± 15%      +0.1        0.66 ±  3%  mpstat.cpu.all.usr%
     30758 ± 11%     +41.0%      43361 ±  4%  vmstat.system.cs
  14033150           +13.1%   15877158        numa-numastat.node0.local_node
  14069328           +13.1%   15912745        numa-numastat.node0.numa_hit
  14246260           +11.6%   15894273        numa-numastat.node1.local_node
  14274705           +11.6%   15927700        numa-numastat.node1.numa_hit
  14069250           +13.1%   15912955        numa-vmstat.node0.numa_hit
  14033072           +13.1%   15877368        numa-vmstat.node0.numa_local
  14274619           +11.6%   15927488        numa-vmstat.node1.numa_hit
  14246174           +11.6%   15894061        numa-vmstat.node1.numa_local
      0.30 ± 19%     +38.5%       0.42 ±  7%  sched_debug.cfs_rq:/.nr_running.stddev
      2434 ±  4%     -10.6%       2176 ±  6%  sched_debug.cpu.curr->pid.avg
      1079 ± 20%     +36.7%       1474 ± 10%  sched_debug.cpu.curr->pid.stddev
     18781 ±  2%     +28.4%      24113 ±  2%  sched_debug.cpu.nr_switches.avg
     11540 ±  4%     +41.8%      16360 ±  5%  sched_debug.cpu.nr_switches.min
      0.03           +33.3%       0.04        stress-ng.rawudp.MB_recv'd_per_sec
   4064768           +34.2%    5456370        stress-ng.rawudp.ops
     67734           +34.2%      90929        stress-ng.rawudp.ops_per_sec
    757287 ±  2%     +31.6%     996382        stress-ng.time.involuntary_context_switches
   1112941 ±  2%     +40.5%    1564161 ±  2%  stress-ng.time.voluntary_context_switches
  28346406           +12.3%   31843356        proc-vmstat.numa_hit
  28281784           +12.3%   31774341        proc-vmstat.numa_local
    103553 ±  2%      +6.3%     110100 ±  3%  proc-vmstat.numa_pte_updates
    128452           +10.1%     141426 ±  2%  proc-vmstat.pgactivate
  70199954           +10.8%   77804409        proc-vmstat.pgalloc_normal
  70032258           +10.8%   77627740        proc-vmstat.pgfree
  81626657 ± 11%     +20.5%   98326255 ±  3%  perf-stat.i.branch-misses
 8.365e+08 ± 11%     +16.8%   9.77e+08 ±  3%  perf-stat.i.cache-references
     31476 ± 12%     +42.8%      44947 ±  4%  perf-stat.i.context-switches
      2.46 ±  2%      -5.3%       2.33        perf-stat.i.cpi
      7610 ± 11%     +51.7%      11547 ±  3%  perf-stat.i.cpu-migrations
      1807 ±  6%     -35.8%       1160 ±  9%  perf-stat.i.metric.K/sec
  67795798 ± 11%     +17.2%   79489592 ±  3%  perf-stat.i.node-load-misses
     42.11 ±  5%      +2.2       44.32        perf-stat.i.node-store-miss-rate%
  53640005 ± 11%     +16.1%   62254015 ±  3%  perf-stat.i.node-store-misses
      4.42            +3.9%       4.59        perf-stat.overall.MPKI
      0.53            +0.0        0.57        perf-stat.overall.branch-miss-rate%
      2.46            -4.0%       2.36        perf-stat.overall.cpi
    556.40            -7.6%     513.88        perf-stat.overall.cycles-between-cache-misses
      0.41            +4.2%       0.42        perf-stat.overall.ipc
     59.01            +0.9       59.88        perf-stat.overall.node-load-miss-rate%
  80834242 ± 10%     +19.7%   96751983 ±  2%  perf-stat.ps.branch-misses
 3.595e+08 ± 10%     +14.6%  4.121e+08 ±  3%  perf-stat.ps.cache-misses
 8.308e+08 ± 10%     +16.1%  9.643e+08 ±  3%  perf-stat.ps.cache-references
     31157 ± 10%     +42.0%      44245 ±  3%  perf-stat.ps.context-switches
      7566 ± 10%     +50.5%      11389 ±  3%  perf-stat.ps.cpu-migrations
  67342566 ± 10%     +16.5%   78472343 ±  2%  perf-stat.ps.node-load-misses
  53274045 ± 10%     +15.4%   61453717 ±  2%  perf-stat.ps.node-store-misses
  66741521 ± 10%     +13.4%   75684953 ±  2%  perf-stat.ps.node-stores
 5.522e+12            +4.0%  5.742e+12        perf-stat.total.instructions
      0.40 ±  5%     -28.4%       0.29 ±  8%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.58 ±  5%      -9.2%       0.53 ±  4%  perf-sched.sch_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_datagram.skb_recv_datagram
      0.37 ± 11%     -38.4%       0.22 ± 16%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    128.50 ± 19%     -30.6%      89.17 ± 18%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.52 ±  3%     -13.8%       0.45 ±  4%  perf-sched.total_sch_delay.average.ms
      9.51 ±  5%     -24.7%       7.16 ±  5%  perf-sched.total_wait_and_delay.average.ms
    150858 ±  3%     +33.8%     201844 ±  6%  perf-sched.total_wait_and_delay.count.ms
      8.99 ±  5%     -25.3%       6.71 ±  5%  perf-sched.total_wait_time.average.ms
      4.32 ±  4%     -34.8%       2.81 ±  7%  perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      3.22 ±  8%     -34.3%       2.12 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
     47.40 ±  6%     -13.9%      40.79 ± 11%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.93 ±  4%     -29.4%       3.48 ±  7%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.14 ±  5%     -16.3%       1.79 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_datagram.skb_recv_datagram
    508.50 ±  7%     +39.9%     711.50 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
      1533 ±  6%     +22.0%       1871 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      1003 ±  4%     +28.4%       1288 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
     48937 ±  3%     +28.2%      62737 ±  5%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     86063 ±  4%     +39.4%     120002 ±  7%  perf-sched.wait_and_delay.count.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_datagram.skb_recv_datagram
      6201 ±  3%     +14.1%       7077 ± 11%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     85.45 ±120%    +384.6%     414.09 ± 82%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
     22.16 ±105%    +162.1%      58.07 ± 36%  perf-sched.wait_and_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      1.37 ± 17%     -38.1%       0.85 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.apparmor_sk_alloc_security.security_sk_alloc
      2.32 ± 14%     -48.3%       1.20 ± 33%  perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
      4.31 ±  4%     -34.9%       2.81 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      2.24 ± 11%     -36.7%       1.42 ± 24%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      3.89 ± 41%     -57.2%       1.67 ± 36%  perf-sched.wait_time.avg.ms.__cond_resched.lock_sock_nested.raw_destroy.sk_common_release.inet_release
      3.22 ±  8%     -34.2%       2.12 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
     47.20 ±  6%     -14.0%      40.58 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.52 ±  4%     -29.5%       3.19 ±  7%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      5.84 ± 24%     -45.9%       3.16 ± 40%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ip_ra_control
      1.56 ±  5%     -19.0%       1.26 ±  4%  perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_datagram.skb_recv_datagram
    107.91 ± 77%    +281.4%     411.55 ± 82%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      7.19            -2.9        4.31 ±  4%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.kmem_cache_alloc.skb_clone.raw_v4_input
     10.26            -2.8        7.48 ±  3%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc.skb_clone.raw_v4_input.ip_protocol_deliver_rcu
     12.04            -2.7        9.31 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.skb_clone.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish
      6.51            -2.7        3.79 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.kmem_cache_alloc.skb_clone
     12.55            -2.7        9.83 ±  2%  perf-profile.calltrace.cycles-pp.skb_clone.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      6.37            -2.7        3.67 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.kmem_cache_alloc
      6.44 ±  2%      -2.1        4.34 ±  5%  perf-profile.calltrace.cycles-pp.__unfreeze_partials.raw_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      3.03 ±  4%      -2.0        0.99 ± 28%  perf-profile.calltrace.cycles-pp.__unfreeze_partials.inet_sock_destruct.__sk_destruct.rcu_do_batch.rcu_core
      5.59 ±  2%      -1.9        3.67 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__unfreeze_partials.raw_recvmsg.inet_recvmsg
      2.81 ±  4%      -1.9        0.92 ± 29%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__unfreeze_partials.inet_sock_destruct.__sk_destruct.rcu_do_batch
      2.69 ±  4%      -1.9        0.82 ± 30%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__unfreeze_partials.inet_sock_destruct.__sk_destruct
      5.88 ±  2%      -1.8        4.07 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__unfreeze_partials.raw_recvmsg.inet_recvmsg.sock_recvmsg
     15.12            -1.3       13.86 ±  2%  perf-profile.calltrace.cycles-pp.inet_sock_destruct.__sk_destruct.rcu_do_batch.rcu_core.__do_softirq
     12.74            -1.1       11.66 ±  2%  perf-profile.calltrace.cycles-pp.__sk_destruct.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
     13.45            -1.1       12.39 ±  2%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
     13.46            -1.1       12.40 ±  2%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
     13.48            -1.1       12.42 ±  2%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     13.49            -1.1       12.43 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     13.49            -1.1       12.43 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     13.49            -1.1       12.43 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     13.46            -1.1       12.40 ±  2%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     13.46            -1.1       12.40 ±  2%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     11.50            -0.6       10.88 ±  2%  perf-profile.calltrace.cycles-pp.raw_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     11.54            -0.6       10.93 ±  2%  perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     11.72            -0.5       11.18 ±  2%  perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.18 ±  3%      -0.5        0.71 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_partial_node.get_any_partial.___slab_alloc.kmem_cache_alloc
      1.15 ±  3%      -0.5        0.68 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_partial_node.get_any_partial.___slab_alloc
      1.23 ±  3%      -0.5        0.77 ±  3%  perf-profile.calltrace.cycles-pp.get_partial_node.get_any_partial.___slab_alloc.kmem_cache_alloc.skb_clone
     12.05            -0.4       11.61 ±  2%  perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
     12.07            -0.4       11.64 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
      1.38 ±  3%      -0.4        0.94 ±  3%  perf-profile.calltrace.cycles-pp.get_any_partial.___slab_alloc.kmem_cache_alloc.skb_clone.raw_v4_input
      1.84 ±  2%      -0.3        1.56 ±  6%  perf-profile.calltrace.cycles-pp.__slab_free.inet_sock_destruct.__sk_destruct.rcu_do_batch.rcu_core
      0.78 ±  7%      -0.1        0.66 ±  5%  perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.sk_common_release.inet_release
      0.78 ±  7%      -0.1        0.66 ±  5%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.sk_common_release.inet_release.__sock_release
      0.78 ±  7%      -0.1        0.66 ±  5%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.do_softirq.__local_bh_enable_ip.sk_common_release
      0.78 ±  7%      -0.1        0.67 ±  5%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.sk_common_release.inet_release.__sock_release.sock_close
      0.52            +0.0        0.55        perf-profile.calltrace.cycles-pp.icmp_route_lookup.__icmp_send.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.56            +0.0        0.60 ±  2%  perf-profile.calltrace.cycles-pp.new_inode_pseudo.sock_alloc.__sock_create.__sys_socket.__x64_sys_socket
      0.57            +0.0        0.61 ±  2%  perf-profile.calltrace.cycles-pp.sock_alloc.__sock_create.__sys_socket.__x64_sys_socket.do_syscall_64
      0.52            +0.0        0.57 ±  2%  perf-profile.calltrace.cycles-pp.alloc_file.alloc_file_pseudo.sock_alloc_file.__sys_socket.__x64_sys_socket
      0.73            +0.1        0.78        perf-profile.calltrace.cycles-pp.sock_alloc_file.__sys_socket.__x64_sys_socket.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.72            +0.1        0.78 ±  2%  perf-profile.calltrace.cycles-pp.alloc_file_pseudo.sock_alloc_file.__sys_socket.__x64_sys_socket.do_syscall_64
      1.03 ±  3%      +0.1        1.10 ±  3%  perf-profile.calltrace.cycles-pp.sk_filter_trim_cap.sock_queue_rcv_skb_reason.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu
      0.59 ±  3%      +0.1        0.68 ±  2%  perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc.skb_clone.raw_v4_input
      1.14            +0.1        1.22        perf-profile.calltrace.cycles-pp.dst_release.ipv4_pktinfo_prepare.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu
      1.96            +0.1        2.05        perf-profile.calltrace.cycles-pp.skb_release_data.kfree_skb_reason.inet_sock_destruct.__sk_destruct.rcu_do_batch
      1.64            +0.1        1.75 ±  2%  perf-profile.calltrace.cycles-pp.ipv4_pktinfo_prepare.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.42 ± 44%      +0.1        0.55 ±  2%  perf-profile.calltrace.cycles-pp.alloc_empty_file.alloc_file.alloc_file_pseudo.sock_alloc_file.__sys_socket
      2.42 ±  3%      +0.1        2.55 ±  3%  perf-profile.calltrace.cycles-pp.icmp_socket_deliver.icmp_unreach.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      2.41 ±  3%      +0.1        2.54 ±  3%  perf-profile.calltrace.cycles-pp.raw_icmp_error.icmp_socket_deliver.icmp_unreach.icmp_rcv.ip_protocol_deliver_rcu
      2.47 ±  3%      +0.1        2.60 ±  3%  perf-profile.calltrace.cycles-pp.icmp_unreach.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      0.66            +0.1        0.80        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.raw_recvmsg
      2.70 ±  2%      +0.2        2.84 ±  3%  perf-profile.calltrace.cycles-pp.icmp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      0.70            +0.2        0.88        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.raw_recvmsg.inet_recvmsg
      0.62 ±  7%      +0.2        0.79 ± 11%  perf-profile.calltrace.cycles-pp.free_unref_page.inet_sock_destruct.__sk_destruct.rcu_do_batch.rcu_core
      0.66 ±  2%      +0.2        0.85 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.raw_recvmsg
      0.66            +0.2        0.84        perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.raw_recvmsg.inet_recvmsg.sock_recvmsg
      0.70 ±  2%      +0.2        0.90 ±  2%  perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.raw_recvmsg.inet_recvmsg
      0.94            +0.3        1.24        perf-profile.calltrace.cycles-pp.consume_skb.raw_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      0.81            +0.3        1.14 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__skb_try_recv_datagram.__skb_recv_datagram.skb_recv_datagram.raw_recvmsg
      0.99            +0.4        1.37 ±  3%  perf-profile.calltrace.cycles-pp.__skb_try_recv_datagram.__skb_recv_datagram.skb_recv_datagram.raw_recvmsg.inet_recvmsg
      1.53            +0.4        1.94 ±  2%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.raw_recvmsg.inet_recvmsg.sock_recvmsg
      1.55 ±  2%      +0.4        1.97 ±  2%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.raw_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      1.10 ±  2%      +0.4        1.52 ±  3%  perf-profile.calltrace.cycles-pp.__skb_recv_datagram.skb_recv_datagram.raw_recvmsg.inet_recvmsg.sock_recvmsg
      1.12 ±  2%      +0.4        1.54 ±  3%  perf-profile.calltrace.cycles-pp.skb_recv_datagram.raw_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.alloc_inode.new_inode_pseudo.sock_alloc.__sock_create.__sys_socket
      4.85            +0.6        5.40        perf-profile.calltrace.cycles-pp.__copy_skb_header.__skb_clone.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish
      7.74            +0.6        8.32        perf-profile.calltrace.cycles-pp.kfree_skb_reason.inet_sock_destruct.__sk_destruct.rcu_do_batch.rcu_core
      0.00            +0.6        0.61 ±  2%  perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.00            +0.7        0.65 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__skb_try_recv_datagram.__skb_recv_datagram.skb_recv_datagram
      4.56            +0.7        5.25        perf-profile.calltrace.cycles-pp.sock_def_readable.__sock_queue_rcv_skb.sock_queue_rcv_skb_reason.raw_rcv.raw_v4_input
      7.56            +0.7        8.31        perf-profile.calltrace.cycles-pp.__skb_clone.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
     50.71            +0.8       51.47        perf-profile.calltrace.cycles-pp.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      3.67            +0.9        4.59 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__sock_queue_rcv_skb.sock_queue_rcv_skb_reason.raw_rcv
     55.46            +1.0       56.43        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     55.45            +1.0       56.42        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     58.02            +1.0       59.01        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.raw_send_hdrinc.raw_sendmsg
     57.99            +1.0       58.98        perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     58.01            +1.0       59.00        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.raw_send_hdrinc
     55.61            +1.0       56.60        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__do_softirq
     58.10            +1.0       59.10        perf-profile.calltrace.cycles-pp.ip_finish_output2.raw_send_hdrinc.raw_sendmsg.sock_sendmsg.__sys_sendto
     58.09            +1.0       59.09        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.raw_send_hdrinc.raw_sendmsg.sock_sendmsg
     55.68            +1.0       56.68        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
     55.70            +1.0       56.70        perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     55.68            +1.0       56.68        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
     59.51            +1.0       60.54        perf-profile.calltrace.cycles-pp.raw_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     59.58            +1.0       60.61        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     58.64            +1.0       59.68        perf-profile.calltrace.cycles-pp.raw_send_hdrinc.raw_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
     59.70            +1.0       60.74        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     59.69            +1.0       60.73        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
      4.97            +1.0        6.02 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__sock_queue_rcv_skb.sock_queue_rcv_skb_reason.raw_rcv.raw_v4_input
     59.76            +1.0       60.81        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     59.78            +1.1       60.84        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendto
     59.85            +1.1       60.91        perf-profile.calltrace.cycles-pp.sendto
     22.21            +2.3       24.51        perf-profile.calltrace.cycles-pp.__sock_queue_rcv_skb.sock_queue_rcv_skb_reason.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu
     23.65            +2.4       26.03        perf-profile.calltrace.cycles-pp.sock_queue_rcv_skb_reason.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish
     29.20            +2.7       31.86        perf-profile.calltrace.cycles-pp.raw_rcv.raw_v4_input.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
     28.65            -5.8       22.86 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     24.32            -5.6       18.77 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     10.24 ±  2%      -4.1        6.14 ±  5%  perf-profile.children.cycles-pp.__unfreeze_partials
      8.45            -3.3        5.11 ±  4%  perf-profile.children.cycles-pp.get_partial_node
     10.66            -2.8        7.90 ±  3%  perf-profile.children.cycles-pp.___slab_alloc
     12.63            -2.7        9.92 ±  2%  perf-profile.children.cycles-pp.skb_clone
     12.72            -2.7       10.02 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
     17.07            -1.4       15.72 ±  2%  perf-profile.children.cycles-pp.inet_sock_destruct
     17.58            -1.3       16.26 ±  2%  perf-profile.children.cycles-pp.__sk_destruct
     18.54            -1.3       17.26 ±  2%  perf-profile.children.cycles-pp.rcu_do_batch
     18.54            -1.3       17.27 ±  2%  perf-profile.children.cycles-pp.rcu_core
     13.48            -1.1       12.42 ±  2%  perf-profile.children.cycles-pp.smpboot_thread_fn
     13.49            -1.1       12.43 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
     13.49            -1.1       12.43 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
     13.49            -1.1       12.43 ±  2%  perf-profile.children.cycles-pp.kthread
     13.46            -1.1       12.40 ±  2%  perf-profile.children.cycles-pp.run_ksoftirqd
     11.51            -0.6       10.89 ±  2%  perf-profile.children.cycles-pp.raw_recvmsg
     11.55            -0.6       10.94 ±  2%  perf-profile.children.cycles-pp.inet_recvmsg
     11.73            -0.5       11.19 ±  2%  perf-profile.children.cycles-pp.sock_recvmsg
     12.06            -0.4       11.63 ±  2%  perf-profile.children.cycles-pp.__sys_recvfrom
     12.08            -0.4       11.65 ±  2%  perf-profile.children.cycles-pp.__x64_sys_recvfrom
      1.39 ±  3%      -0.4        0.96 ±  3%  perf-profile.children.cycles-pp.get_any_partial
      3.16            -0.2        3.00 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.13 ±  2%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.apparmor_capable
      0.12 ±  3%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.05 ±  7%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__wake_up_common
      0.15            +0.0        0.16 ±  3%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.34 ±  2%      +0.0        0.36        perf-profile.children.cycles-pp.ip_route_output_key_hash
      0.11 ±  6%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.12 ±  3%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.release_sock
      0.05            +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.schedule_timeout
      0.05            +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.try_to_wake_up
      0.08 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__free_one_page
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.16 ±  5%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.32 ±  2%      +0.0        0.34        perf-profile.children.cycles-pp.security_socket_post_create
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.stress_rawudp_server
      0.24            +0.0        0.26        perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.06 ±  6%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__skb_wait_for_more_packets
      0.04 ± 44%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.24            +0.0        0.26 ±  2%  perf-profile.children.cycles-pp.init_file
      0.18 ±  4%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
      0.33            +0.0        0.36 ±  3%  perf-profile.children.cycles-pp.sock_alloc_inode
      0.11 ±  8%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.__fget_light
      0.15 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.44            +0.0        0.47        perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.29 ±  4%      +0.0        0.32 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.14 ±  2%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.put_cpu_partial
      0.23 ±  6%      +0.0        0.26 ±  5%  perf-profile.children.cycles-pp.tick_sched_timer
      0.32 ±  3%      +0.0        0.35 ±  3%  perf-profile.children.cycles-pp.setsockopt
      0.08 ±  5%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.__schedule
      0.07 ±  6%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.schedule
      0.16 ±  2%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.14 ±  6%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.29            +0.0        0.32 ±  4%  perf-profile.children.cycles-pp.setup_object
      0.28 ±  4%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.52            +0.0        0.56        perf-profile.children.cycles-pp.icmp_route_lookup
      0.49            +0.0        0.53 ±  2%  perf-profile.children.cycles-pp.alloc_inode
      0.13 ±  4%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.51            +0.0        0.55 ±  2%  perf-profile.children.cycles-pp.alloc_empty_file
      0.22 ±  2%      +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      0.57            +0.0        0.61        perf-profile.children.cycles-pp.sock_alloc
      0.44            +0.0        0.48        perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.56            +0.0        0.61        perf-profile.children.cycles-pp.new_inode_pseudo
      0.52            +0.0        0.57 ±  2%  perf-profile.children.cycles-pp.alloc_file
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__ip_finish_output
      0.72 ±  2%      +0.1        0.78 ±  2%  perf-profile.children.cycles-pp.alloc_file_pseudo
      0.15 ±  3%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.01 ±223%      +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.73            +0.1        0.78        perf-profile.children.cycles-pp.sock_alloc_file
      0.16 ±  3%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.20 ±  2%      +0.1        0.27 ±  3%  perf-profile.children.cycles-pp.aa_sk_perm
      1.12 ±  3%      +0.1        1.19 ±  3%  perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.14 ±  3%      +0.1        0.21 ±  5%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.67            +0.1        0.75        perf-profile.children.cycles-pp.shuffle_freelist
      0.12 ±  4%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      1.24            +0.1        1.33        perf-profile.children.cycles-pp.dst_release
      2.12            +0.1        2.22        perf-profile.children.cycles-pp.kmem_cache_free
      0.89 ±  2%      +0.1        1.00        perf-profile.children.cycles-pp.allocate_slab
      1.72            +0.1        1.84        perf-profile.children.cycles-pp.ipv4_pktinfo_prepare
      2.42 ±  2%      +0.1        2.55 ±  3%  perf-profile.children.cycles-pp.icmp_socket_deliver
      2.41 ±  3%      +0.1        2.54 ±  3%  perf-profile.children.cycles-pp.raw_icmp_error
      2.47 ±  3%      +0.1        2.60 ±  3%  perf-profile.children.cycles-pp.icmp_unreach
      2.70 ±  2%      +0.1        2.85 ±  3%  perf-profile.children.cycles-pp.icmp_rcv
      0.67 ±  2%      +0.2        0.83        perf-profile.children.cycles-pp.copyout
      0.60 ±  2%      +0.2        0.77 ±  2%  perf-profile.children.cycles-pp.check_heap_object
      0.71 ±  2%      +0.2        0.88        perf-profile.children.cycles-pp._copy_to_iter
      0.73 ±  2%      +0.2        0.93 ±  2%  perf-profile.children.cycles-pp.__check_object_size
      0.71 ±  2%      +0.2        0.91 ±  2%  perf-profile.children.cycles-pp.simple_copy_to_iter
      0.82 ±  7%      +0.2        1.03 ± 10%  perf-profile.children.cycles-pp.free_unref_page
      2.39            +0.2        2.63        perf-profile.children.cycles-pp.sock_rfree
      2.99            +0.3        3.28        perf-profile.children.cycles-pp.skb_release_head_state
      1.01            +0.3        1.31        perf-profile.children.cycles-pp.consume_skb
      4.47            +0.4        4.85        perf-profile.children.cycles-pp.skb_release_data
      1.01            +0.4        1.39 ±  3%  perf-profile.children.cycles-pp.__skb_try_recv_datagram
      1.54            +0.4        1.95 ±  2%  perf-profile.children.cycles-pp.__skb_datagram_iter
      1.56 ±  2%      +0.4        1.97 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      1.11 ±  2%      +0.4        1.53 ±  3%  perf-profile.children.cycles-pp.__skb_recv_datagram
      1.12 ±  2%      +0.4        1.55 ±  3%  perf-profile.children.cycles-pp.skb_recv_datagram
      4.89            +0.6        5.45        perf-profile.children.cycles-pp.__copy_skb_header
      4.58            +0.7        5.27        perf-profile.children.cycles-pp.sock_def_readable
     10.70            +0.7       11.42        perf-profile.children.cycles-pp.kfree_skb_reason
      7.65            +0.8        8.40        perf-profile.children.cycles-pp.__skb_clone
     50.92            +0.8       51.69        perf-profile.children.cycles-pp.raw_v4_input
     59.46            +0.8       60.25        perf-profile.children.cycles-pp.do_softirq
     59.48            +0.8       60.28        perf-profile.children.cycles-pp.__local_bh_enable_ip
     85.69            +0.9       86.58        perf-profile.children.cycles-pp.do_syscall_64
     85.79            +0.9       86.70        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     55.46            +1.0       56.44        perf-profile.children.cycles-pp.ip_local_deliver_finish
     55.45            +1.0       56.43        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     55.61            +1.0       56.61        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     55.68            +1.0       56.68        perf-profile.children.cycles-pp.__napi_poll
     55.71            +1.0       56.71        perf-profile.children.cycles-pp.net_rx_action
     55.68            +1.0       56.68        perf-profile.children.cycles-pp.process_backlog
     58.22            +1.0       59.22        perf-profile.children.cycles-pp.__dev_queue_xmit
     58.26            +1.0       59.26        perf-profile.children.cycles-pp.ip_finish_output2
     59.52            +1.0       60.54        perf-profile.children.cycles-pp.raw_sendmsg
     58.65            +1.0       59.68        perf-profile.children.cycles-pp.raw_send_hdrinc
     59.58            +1.0       60.61        perf-profile.children.cycles-pp.sock_sendmsg
     59.71            +1.0       60.75        perf-profile.children.cycles-pp.__x64_sys_sendto
     59.69            +1.0       60.74        perf-profile.children.cycles-pp.__sys_sendto
     59.87            +1.1       60.93        perf-profile.children.cycles-pp.sendto
     22.30            +2.3       24.61        perf-profile.children.cycles-pp.__sock_queue_rcv_skb
     23.78            +2.4       26.16        perf-profile.children.cycles-pp.sock_queue_rcv_skb_reason
     29.56            +2.7       32.22        perf-profile.children.cycles-pp.raw_rcv
     28.12            -5.9       22.26 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.64            -0.5        0.12 ±  3%  perf-profile.self.cycles-pp.__unfreeze_partials
      0.45            -0.2        0.26 ±  3%  perf-profile.self.cycles-pp.get_partial_node
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.__dev_queue_xmit
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.__cond_resched
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.06 ±  6%      +0.0        0.07        perf-profile.self.cycles-pp.__check_object_size
      0.13            +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.apparmor_capable
      0.10 ±  3%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__sk_destruct
      0.37            +0.0        0.39        perf-profile.self.cycles-pp.sock_queue_rcv_skb_reason
      0.15 ±  2%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.06 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.__virt_addr_valid
      0.43            +0.0        0.44        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.19 ±  3%      +0.0        0.21        perf-profile.self.cycles-pp.ip_route_output_key_hash_rcu
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.06 ±  9%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.is_vmalloc_addr
      0.12 ±  3%      +0.0        0.14        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.30            +0.0        0.32 ±  2%  perf-profile.self.cycles-pp.apparmor_socket_post_create
      0.06 ±  9%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.stress_rawudp_server
      0.41            +0.0        0.43        perf-profile.self.cycles-pp.skb_clone
      0.24            +0.0        0.26        perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.07 ±  5%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.__skb_try_recv_datagram
      0.45            +0.0        0.48 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.36 ±  2%      +0.0        0.38        perf-profile.self.cycles-pp.inet_sock_destruct
      0.10 ±  8%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.__fget_light
      0.14 ±  3%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.put_cpu_partial
      0.69            +0.0        0.72        perf-profile.self.cycles-pp.raw_rcv
      0.03 ± 70%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.15 ±  2%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.get_any_partial
      0.11 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.recv
      0.16 ±  3%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.12 ±  5%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.47            +0.0        0.51        perf-profile.self.cycles-pp.skb_release_head_state
      0.43            +0.0        0.47 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.00            +0.1        0.05        perf-profile.self.cycles-pp._copy_to_iter
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.__skb_recv_datagram
      0.45 ±  2%      +0.1        0.51 ±  2%  perf-profile.self.cycles-pp.shuffle_freelist
      1.12 ±  3%      +0.1        1.18 ±  5%  perf-profile.self.cycles-pp.raw_v4_input
      0.16 ±  2%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.aa_sk_perm
      0.20 ±  2%      +0.1        0.26 ±  3%  perf-profile.self.cycles-pp.__sys_recvfrom
      0.11 ±  5%      +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      1.18            +0.1        1.26        perf-profile.self.cycles-pp.dst_release
      1.91            +0.1        2.00        perf-profile.self.cycles-pp.kmem_cache_free
      0.44            +0.1        0.57 ±  2%  perf-profile.self.cycles-pp.check_heap_object
      2.40 ±  3%      +0.1        2.53 ±  3%  perf-profile.self.cycles-pp.raw_icmp_error
      0.64 ±  2%      +0.2        0.79        perf-profile.self.cycles-pp.copyout
      2.25            +0.2        2.42        perf-profile.self.cycles-pp.__slab_free
      0.60 ±  2%      +0.2        0.78 ±  3%  perf-profile.self.cycles-pp.raw_recvmsg
      2.75            +0.2        2.94        perf-profile.self.cycles-pp.__skb_clone
      2.36            +0.2        2.60        perf-profile.self.cycles-pp.sock_rfree
      4.24            +0.4        4.59        perf-profile.self.cycles-pp.kfree_skb_reason
      4.24            +0.4        4.60        perf-profile.self.cycles-pp.skb_release_data
      2.52            +0.4        2.91        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
     12.54            +0.6       13.09        perf-profile.self.cycles-pp.__sock_queue_rcv_skb
      4.83            +0.6        5.38        perf-profile.self.cycles-pp.__copy_skb_header
      4.40            +0.6        5.03        perf-profile.self.cycles-pp.sock_def_readable
      0.91            +0.7        1.60        perf-profile.self.cycles-pp.___slab_alloc




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

