Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268667FE8CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344549AbjK3FuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjK3FuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:50:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0680810C2;
        Wed, 29 Nov 2023 21:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701323422; x=1732859422;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=XFb+obhUwH7z0Z1bZZ3NBgzC4nju2g+i5YwTV09h9Ck=;
  b=RqBGgJc0ou7qViWUQfn9Ligu9QvXwxiWzTbARIgg8p/6fKGgCaR03+/U
   cIYg4iYsmnCYDPtTM7ZKNtCcHv14ztndFb/LcufMVXwwKQSirwItbY0ju
   qVPDHy9AKmTp+pOdp4Ay11sxh/o3gVak8q96SLeg4qjUOibG3VUQxW/qf
   Teyl+JhLV/de/StSGQ5c4gsPKcd9iCac0Ea3rTBbaUx7pqCfy71RGR+2L
   0HxSauMV1fxnb82jPEJ5iig5+jFHVGj0eU8o+zm1lDIu9hkEmf4/D9U73
   q6JUY4Ng9rzs+x6rpQF5vD8pdQxxGJsySRJ6Pt4D2+dtflSD5ml7TjlVJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="393016555"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="393016555"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 21:50:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="892697383"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="892697383"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 21:50:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 21:50:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 21:50:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 21:50:14 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 21:49:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLRIbsN9Pz0Q++Zsf0Br2Vmc+JyjHPRI2KuwaBcNy5KXp6A6JE8b1TJHP8m++Ob14mw+JUs6HS+1ZGJfwz2q4gJNm0AyfXUV0K3D8SZcb417DakZBk05f2XkHOP5YqiwFavF2i1AM9uSopNZyQj/JhoKDNB7mUAAEKbci6M9nRPFJ4srrTW++ffM2l6s01ufQVoEKY4faN+oSFmFn+DtwQfqT6e3Al19/Ub8GCxFffpySuyBB6iij9zUigGiFz/JD6ln4ELick4ROs/z1l/IIcvlf3jhfjYd+esRQYmvV1a3XHQN2gdndkqea+wu6TVHg1uEi6b3hSE6m2wRnicZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2MtmyctJiotXqdWzq/twqvuduuj+NDp90gcW3RGmgw=;
 b=Lovl3SACIO5geW3qKomXeeFv04bU5CYFtd3Nq3a0G2tFtml7uR+A9gBmk5l4BUYPovdNTJnaqTCPovSDdH5mX/PUNAQj8PkJxIJKEFCQRbFL5vXOXPZ37I7z1u7zoNgucSPUy/qZREaqwsnMCHYb+oUUko1ODl/mdvt1mQ7KL7tmB+rlRvdFI3zVW+h9epB8xQtFv851V3CRG9nRErGVTvxR85aRKAvzPKXf+Uw9ZSbKi++Wrahk+efp0iDavOHqUFg4D9bmKWMhYCK3Oc+YwtGGAWRAOV8n4dBo0ef+tu5MD6uv06UxYXOPdNV8onPybIv14JQhqJOmjoXItS6VtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7329.namprd11.prod.outlook.com (2603:10b6:208:437::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 05:49:32 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 05:49:31 +0000
Date:   Thu, 30 Nov 2023 13:49:21 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Zhang Rui <rui.zhang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-acpi@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [x86/acpi]  ec9aedb2aa:  aim9.exec_test.ops_per_sec
 2.4% improvement
Message-ID: <202311301346.56b0fcd6-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: ae66fcda-5194-47d5-48ed-08dbf1681fc1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4h27DnOnL6u3gWyJsIJWCercELZPZNY0z6uifl+no0F1JpcZUwJQMsQmkzMoGmA3LhGWkLnX8V/cfmdTotyzo4And8h9KvjOinfYkBZ8joH2H4Mdi2EkFO7/72SmVcJMpNQFZkPDA1xw2s7NbHq32tJPoEFUT6hmQ7f5bWGiioClLLH+wYL7LgqnG2/IcgdqnskkQebRQol42fWvKDMhOxbU0gq7giuENSRFsITOfpQ+kGG44yRQOdwu/CeLCSGWZFlMWcD0XKiUip4ySWCW7q7kjzd7ZmOJzutrWHA3mx7oOFScJX6T9Mv5710gFXwBxE5Z3A6dv9pvaCCR3RCeFT6lJuuglffXtOOPU/wJG6VBTOZ8e/QO5JT1Ql56VsKarB31ms+IquDdDF6sq9Ba/VcsnpMAI76K7nvTweG68h7q/lhI+eZ0ChRjs8hpeuwMKR0/9VxhRIGf1EtJNvQQqzzQSFXiH8cZXEo14DwtwrHMUTEUU4ibI9eg+WZy8gKvueGc2eV/bpoqp8LkTR7mhCFxHIU7Fm5dmJ9MHFsolsvqKAdsRQD2AuuazoqKI+0rMmIm3avLE33VuhqRIqS+F5qmCvikxE+KehuYabTw25NCgmGmswHhp4lBi7zClqI+1vjJjWv7Ue2vWoG8cqzHg0sKNJxbMPSO0bQ+8DUQtDTE3t/muq1pjnPQmFpNDZV7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(230473577357003)(230373577357003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(478600001)(6486002)(966005)(36756003)(6512007)(2616005)(107886003)(26005)(1076003)(6506007)(41300700001)(38100700002)(83380400001)(86362001)(82960400001)(2906002)(202311291699003)(6666004)(66946007)(316002)(6636002)(66476007)(37006003)(54906003)(66556008)(4326008)(6862004)(8676002)(8936002)(19627235002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?09gV0gpiuxwVO3jQ02WbkQ7MYZpT2aAY3AXYFcP3FcC8iJN9k0DjIlcZoZ?=
 =?iso-8859-1?Q?R309hmH3zmFAhXuMH+Z+yUH6nWqYxfex+04ixj3EwvTg1k55tjhsfd74Sz?=
 =?iso-8859-1?Q?7EJC28EUZ39WAxvyjCq0HnvyWZlFXFEICZC21ILClH070eLPCxmnT8tMFy?=
 =?iso-8859-1?Q?Pcy8Ox3ArCX2GbxfVN9A7IxqOutNHLglaoG2ind04+27m8bOQD8Jh18kxf?=
 =?iso-8859-1?Q?yq6fxy9P4TQ7aa01zLasQI/5FigGIHUtyUV2AMUlaDTjM+CmFX4sFzj9UF?=
 =?iso-8859-1?Q?Dizqxbf7aCYq6qYSNhVVluWfxOtrsqlQyGGkxkYYvMbu8cK8/jb5b+Lms4?=
 =?iso-8859-1?Q?vfJnnfbwBeKou9axToOVxspdfBlBOVs4IqzCgWVM31n4750rj7zPylyUsq?=
 =?iso-8859-1?Q?eghxrv5DbMaYaIQIKcIIottTnoBwKqxtTtWUdsFLeupuN3vLCE1LCFqkrP?=
 =?iso-8859-1?Q?1Yau65ehs78cvgYdnmQAJDGi5f2/UU/bf28Nkw+aJXhX++OpniZrlKiq+g?=
 =?iso-8859-1?Q?Uk4iVdSwgfg/gnfK3mbnOqxvXIGA8wDTRQR4sz44Iqm41ad4pe3jc9yahy?=
 =?iso-8859-1?Q?YSArRaPyXNhlnAfiYPXuKhSvonr4ALWGiqdsI9M8dENWC/5F7vsmwzvpHR?=
 =?iso-8859-1?Q?Fy9MVsxQigEaoFy71iZ7W/UhlfHTAnTIMUl9I55jpzsFsRdCLbiZNouAX4?=
 =?iso-8859-1?Q?zH6ZfX1qPGKUk3xMMVFq9+XSqEcNI7J+RwAG1uWfGT7cYgEMFHt/98zdq/?=
 =?iso-8859-1?Q?hT1EAcoeNFrSJJOrOpJuNleg7xFzzAyS5S0N9uZNv6kXbbCJ248MWdX+Aw?=
 =?iso-8859-1?Q?glguIAkI2dEN6NsOqkwNYOrEf0zSAefhk4jPTMutBYn0SsmoNfylNQttVe?=
 =?iso-8859-1?Q?TbNkoWKU2dqA6w9/MZ9mefTH55xs1laVo8zZaGhl6DVaRVVx0yzbVax3o5?=
 =?iso-8859-1?Q?JWm3P+JcONaNws0q+OczXR9HiO8jlf6b1TWB4mkhZiA88wFSgcu7xOyPzJ?=
 =?iso-8859-1?Q?k9+ZF/qm2v2MgMc6dY+3TdmCJqS7SJVRRZ90a4wNveLmaCciYAYjLNevEo?=
 =?iso-8859-1?Q?a2L8siziaQJAFvXSQ9PKGjpvdBODCGEC+vi6I9ZCZg1vWZFkGgkbh/E3q4?=
 =?iso-8859-1?Q?a98+/fvT6mpdwxBi8GozEXRnr0kpr4vL7LITO8QSlxJn3Kgx2cwSRgPA3a?=
 =?iso-8859-1?Q?HB0ZlYg5DF4GuFcVYx8MoSbsNxjwTl1mGY8RfNZ/nsBHev86FZSMXhunEg?=
 =?iso-8859-1?Q?6aqxOKl39wvKBc8DMuxEhb+saqluoMUJsCrm36zU2sp8ClkN/lB+srTxo7?=
 =?iso-8859-1?Q?eRjLw4F3645ZROcg5Hm8ZyGPllE4q0zbFGcXQVsUGrShFn/PmZYFIzWS9K?=
 =?iso-8859-1?Q?9SQmwaWvGonkyiXMB9KY9PBZEo0Xmvxq9t6zc+Zp1DXeLHna3CDVdPkKGa?=
 =?iso-8859-1?Q?zdiCN21crD6dWqRp/8fkvFsskKr7XMvsZtLkfmeCIonfkT49hhyTOt+MAC?=
 =?iso-8859-1?Q?0gaMfKT+JT9eb+70Yk/3q69zBFK9Ukggtuckuficoza9XSPpTkkTR0UKQA?=
 =?iso-8859-1?Q?ZVIWlc9wrQabY5tKWi8yfQA955U6yA5vaV1EqzPezmCUSmrTMi7PDVQmV+?=
 =?iso-8859-1?Q?2NS4dBwaq2dLaq2M1sR9P4Oz410kxfBXYgI9atOT8RxJQex22ksxAbcA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae66fcda-5194-47d5-48ed-08dbf1681fc1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 05:49:31.6190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msDxJNk+4YHntmLDHXw6Vf+gPkDxD4uJulCq3TLcK3Zuiuc942bxfyEexcx7h59yQlaxNlxHSNZ3A9QiIeeHFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7329
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

kernel test robot noticed a 2.4% improvement of aim9.exec_test.ops_per_sec on:


commit: ec9aedb2aa1ab7ac420c00b31f5edc5be15ec167 ("x86/acpi: Ignore invalid x2APIC entries")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: aim9
test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
parameters:

	testtime: 300s
	test: exec_test
	cpufreq_governor: performance


besides below detailed comparison, we also noticed some difference from dmesg.

for this commit ec9aedb2aa:

[    1.311075][    T0] smpboot: Allowing 48 CPUs, 0 hotplug CPUs

for parent:

[    1.311098][    T0] smpboot: Allowing 168 CPUs, 120 hotplug CPUs


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231130/202311301346.56b0fcd6-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-ivb-2ep1/exec_test/aim9/300s

commit: 
  31255e072b ("x86/shstk: Delay signal entry SSP write until after user accesses")
  ec9aedb2aa ("x86/acpi: Ignore invalid x2APIC entries")

31255e072b2e91f9 ec9aedb2aa1ab7ac420c00b31f5 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      8587 ±  3%      +5.9%       9091        vmstat.system.cs
      6542 ±  9%     -18.2%       5352 ±  7%  numa-meminfo.node1.KernelStack
     57960 ±  4%     -12.6%      50656 ±  6%  numa-meminfo.node1.SUnreclaim
      6541 ±  9%     -18.0%       5363 ±  6%  numa-vmstat.node1.nr_kernel_stack
     14490 ±  4%     -12.6%      12663 ±  6%  numa-vmstat.node1.nr_slab_unreclaimable
    179678 ±  7%     -22.6%     139060 ± 10%  meminfo.DirectMap4k
     13670           -13.6%      11809        meminfo.KernelStack
     78243           -72.5%      21498        meminfo.Percpu
      1222            +2.4%       1251        aim9.exec_test.ops_per_sec
  27978802            +3.1%   28859909        aim9.time.minor_page_faults
    175.04            -6.2%     164.11        aim9.time.system_time
    115.72            +9.1%     126.24        aim9.time.user_time
    731948            +2.4%     749684        aim9.time.voluntary_context_switches
     13669           -13.8%      11788        proc-vmstat.nr_kernel_stack
     21028            -3.2%      20355        proc-vmstat.nr_slab_reclaimable
     29074            -9.0%      26443        proc-vmstat.nr_slab_unreclaimable
     50357            -1.3%      49699        proc-vmstat.numa_other
  28937047            +3.0%   29790891        proc-vmstat.pgfault
      0.55 ±  5%      +0.1        0.65 ±  7%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      1.38 ±  6%      -0.7        0.67 ±  9%  perf-profile.children.cycles-pp.mm_init
      0.87 ±  7%      -0.5        0.38 ± 10%  perf-profile.children.cycles-pp.pcpu_alloc
      0.76 ±  8%      -0.3        0.42 ±  8%  perf-profile.children.cycles-pp.alloc_bprm
      0.50 ±  6%      -0.3        0.17 ±  6%  perf-profile.children.cycles-pp.memset_orig
      0.40 ±  5%      -0.2        0.15 ± 18%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.15 ± 20%      -0.1        0.03 ±101%  perf-profile.children.cycles-pp.mm_init_cid
      0.23 ± 14%      -0.1        0.12 ± 19%  perf-profile.children.cycles-pp._find_next_bit
      0.30 ± 10%      -0.1        0.24 ± 16%  perf-profile.children.cycles-pp.mas_preallocate
      0.14 ± 18%      -0.0        0.09 ± 16%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.09 ± 15%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.remove_vma
      0.05 ± 47%      +0.1        0.11 ± 26%  perf-profile.children.cycles-pp.malloc
      0.20 ± 22%      +0.1        0.25 ±  7%  perf-profile.children.cycles-pp.do_brk_flags
      0.44 ±  5%      +0.1        0.53 ±  8%  perf-profile.children.cycles-pp.mod_objcg_state
      0.80 ±  4%      +0.2        0.96 ±  6%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.50 ±  7%      -0.3        0.17 ±  6%  perf-profile.self.cycles-pp.memset_orig
      0.26 ± 16%      -0.2        0.04 ±106%  perf-profile.self.cycles-pp.mm_init
      0.14 ± 25%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.mm_init_cid
      0.18 ± 22%      -0.1        0.08 ± 34%  perf-profile.self.cycles-pp.pcpu_alloc
      0.13 ± 16%      -0.0        0.08 ± 20%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.37 ±  6%      +0.1        0.45 ± 10%  perf-profile.self.cycles-pp.mod_objcg_state
      0.66 ±  5%      +0.1        0.80 ±  6%  perf-profile.self.cycles-pp.next_uptodate_folio
  34087721 ±  2%      +3.6%   35301961        perf-stat.i.branch-misses
      8601 ±  3%      +6.1%       9122        perf-stat.i.context-switches
     72.92 ±  2%      +7.4%      78.30 ±  3%  perf-stat.i.cpu-migrations
      1.55 ±  2%      -0.1        1.42 ±  3%  perf-stat.i.dTLB-load-miss-rate%
      0.51 ±  2%      -0.2        0.32        perf-stat.i.dTLB-store-miss-rate%
   2867856 ±  3%     -36.9%    1810983        perf-stat.i.dTLB-store-misses
 5.561e+08 ±  2%      +3.0%   5.73e+08        perf-stat.i.dTLB-stores
     92019 ±  4%     +10.2%     101371        perf-stat.i.iTLB-loads
    126.43 ± 15%     -33.8%      83.76        perf-stat.i.metric.K/sec
     90050 ±  4%      +6.8%      96193        perf-stat.i.minor-faults
     19.22 ±  4%      -1.5       17.77 ±  3%  perf-stat.i.node-store-miss-rate%
     90050 ±  4%      +6.8%      96194        perf-stat.i.page-faults
      1.48 ±  2%      -0.1        1.38 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
      0.51            -0.2        0.32        perf-stat.overall.dTLB-store-miss-rate%
  33982829 ±  2%      +3.5%   35183134        perf-stat.ps.branch-misses
      8573 ±  3%      +6.0%       9090        perf-stat.ps.context-switches
     72.73 ±  2%      +7.4%      78.13 ±  3%  perf-stat.ps.cpu-migrations
   2858954 ±  3%     -36.9%    1805251        perf-stat.ps.dTLB-store-misses
 5.545e+08 ±  2%      +3.0%  5.712e+08        perf-stat.ps.dTLB-stores
     91889 ±  4%     +10.2%     101265        perf-stat.ps.iTLB-loads
     89770 ±  4%      +6.8%      95880        perf-stat.ps.minor-faults
     89771 ±  4%      +6.8%      95880        perf-stat.ps.page-faults



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

