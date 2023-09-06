Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B810793720
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbjIFI0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjIFI0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:26:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD12CE4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693988802; x=1725524802;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nb9YgIWk5l3e3inIinz/XhMIL/am7ec3VDzOX+SWlUA=;
  b=IJmliuoiteR4B/fIfecWZWasNmJU7i+mCqcf4YjdQ8Ul8mPCPPoHkoQd
   q05vxUntJei3Nxw21Awut3+PeB8ucV+4QH2bMvW4pVzIZBNM5KPPZcQpC
   +OJvBmStE5BAeBJ5hLGKjPazm91mEJi4yvvqYjDQifDhU9ialZlTtTW8Z
   +BeXJvVy+wqVS+N+9JKs64uwgR7NU0/HeE+jQSnv0efu1vD+w4U12/UGr
   S7UsTyFOCoCQy92a7+ca0MfFYg338Q7ypuiu5zP39CCvH6sTt6LnaDvrF
   lLgp3Y9yvnCxMYkRufynvJXzvVVy21jV3IzWe7PSVwXjuGtM/YqMsbOr5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="376920006"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="376920006"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 01:26:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="856338829"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="856338829"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 01:26:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 01:26:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 01:26:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 01:26:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJrh6+XaiKofCyz78IMBUm3yLXg32P+C3IVPZb8CALl2fvlxu8+WTFK7h0Fbbe9/QUMeJmji/rrjlcnMCPO5PHvI3VJu32lMRl+tv9gWRCID91fgLDLdBDZc2mqPOjGsCPE1NmCHgKNIiAoxyi0c3non6FcxtbwPn5hGZ6/FPx2glyAonS0VN7ur2bS7vSSEgIJhHGrUHGANz18oaIS+CkTVk22jeI5KzDulHBqIsSCyl+zPnH4FAVkDiT2PjOaZ3lEpUQY21ahNa9QWcavSeJ2l1kmLDK1AhqFHKcXNY2RZwu/S738T5Hf5GWOWnjsxYp/j04kG+u1eylJjiodM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fpyXBO9hvCX3Sepsr2KBUTB2DqhFgUrIM3jNWqK/PE=;
 b=AvcMkIyUS7drQMAVEItEjMVf9Lio0rHJI3+4XDnOqGbNw8IQja3LNNOwsMcpaaxCMolE0FHYZ0w7csRhhYp2AlF9TX7xgxPWKQ7vH6f42POswxNEfnh4RzMmOsjd3SSdsBtMEQ0jOGgWHHToGA2EYdUfeUqLof5/de0biGKdEEB/JWH0gVbWa5ThBAUlOMH7KyCkUtzxRtz+X403bHlWxe3pMEe9W3QD1l3BkzFKb3DQFMKqVZvxDcRA55URW6fiuLkoLtGyb9UkNt+SjNkTymGuTkxcxmzb1f7c1aRe9GONWi5anddizKxQ1EFgmWzJtUUpp80ZYZQ5VHB+bf+z2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CH0PR11MB8216.namprd11.prod.outlook.com (2603:10b6:610:192::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 08:26:07 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 08:26:07 +0000
Date:   Wed, 6 Sep 2023 16:25:54 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>,
        <akpm@linux-foundation.org>, <shakeelb@google.com>,
        <vegard.nossum@oracle.com>, <linux-mm@kvack.org>,
        Mateusz Guzik <mjguzik@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3 2/2] kernel/fork: group allocation/free of per-cpu
 counters for mm struct
Message-ID: <202309061504.7e645826-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823050609.2228718-3-mjguzik@gmail.com>
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CH0PR11MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a1c66c-bb87-4338-7c2e-08dbaeb2e990
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YC7/me2ZtvfilGJ14NugWTNjdiqsQzyUpr8nCDNDXAlc/LywRX3cIqbs7+Ii/8eubPUzz1ouOPSzUh1T5X6e+mp+X9jvALoSkJ/07LCnQRogZlcTFkPI/RzrYs+lnRZmd22k1i0jojEn3xvom79anbNpdzIx8nIK7ksZCkSv3rGKmrIuR2Gz5yxsvsFOgKyaoWichFMiNFmKG1AOIb4O2Wadz60PYC8f/2CF17OB09KXzzcMl7ey55KbQyNqo+68cezF1R5rc5Fb8DCGA3tH1c1DHNUId8jJa85dUA8uFi6Lf2xLTQjR1cFgsHfm1uRhy2AYp4FlZ/OysiXG/BnTh8C4Rdg962Ru8TgI9nMv57ZFa0aFMyfmO1KM7dCowj0g73IbSoi02zpnevyg31a2oMt8bx709gxuEaQXHvWKXcqS3TWQVOSbajoiYkCemYhsTCAaZlQBzxwLsERaCcsnhBXnX7VStC/qeJ6BfSBh6M06LvjEXlpaEsuORnCV9+7YihS/PLj/uqmnEBCqa25U6XJrB8v9BwSfV/F/s6goc2pcSSwKtCihMLB9EvDK3o8Gh0LCxwpVHg2VU2URTsm3NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199024)(186009)(1800799009)(6486002)(6506007)(6666004)(6512007)(966005)(478600001)(83380400001)(107886003)(1076003)(2616005)(26005)(2906002)(7416002)(6916009)(66476007)(66556008)(66946007)(316002)(41300700001)(5660300002)(4326008)(8676002)(8936002)(36756003)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xmez1X8gaSaXqtuYyfMhDt9lv2YpVVg8lp5G92G9t/YXNdbDkS46j8Tqua?=
 =?iso-8859-1?Q?zOdHjLJ1VKOLmEdVR78kdyYwtHNUAxp8qStjrcQTX9b01vnTTsdIN0/UuV?=
 =?iso-8859-1?Q?582swyv3/OABLODrxIbetMegFyPv/DkDVvbU37LtE9cZYRL2V8k0XoP39v?=
 =?iso-8859-1?Q?gCkQtA+CmUp8oj0qsU1aHF3GDOO4wgBIIkbte9t5F5fsipDOS10P92U6Oa?=
 =?iso-8859-1?Q?maXfPyEeO0ati0q6VXEKVKx/Z1j/BgiLXEJNT8f2U8PW5AZ1aDrChyVlvA?=
 =?iso-8859-1?Q?XC7tkqePL44rT+BE+Q7C5IYrFwTdlU3hI3v0Ugr9cQQIdc46g8rrZr8F74?=
 =?iso-8859-1?Q?T7iUi/boBGtm6C0iZhVMVNhcotHcNp2v4YELPzG/IVeA+E2FbAtCT2iysA?=
 =?iso-8859-1?Q?OPSfUmhPI1zTpIOhxKSV4gzEfGWkuNzd3UE1rFIR2ybQTxiiWrHhp2sFjp?=
 =?iso-8859-1?Q?aNdq2+ah5ehe90oNAINfC0Jt7G6n0cOBP+eTrLV3mmgXGvMmXHzUkLWXG6?=
 =?iso-8859-1?Q?tbJM5irhWkuB5Ex9kgwKNUe48+KlOL+OSZ3D1sM5JgUocu8giZHicka/D0?=
 =?iso-8859-1?Q?pQe+kwYI993AcX9U0eG01iTXgV0qm/96pGSZLQjM9OC+YHaeiZ/Jn07ME7?=
 =?iso-8859-1?Q?9eo/D+QL8Lfy1uSl0L2PT5YGR6l7YLRziIU6GZ++Sy+g7B0/Wl+WDRDp2s?=
 =?iso-8859-1?Q?Wc0B0WYulZIqJz+Ld7ktnk2IFkRZeGBLKRW54ulsne1tbLb8fP00WlBX9y?=
 =?iso-8859-1?Q?4+HA1l0riJoZywmqf7hcWW+xMc/8UYWXhG0h/kJQXyzI1qUHrhvkyEBGTh?=
 =?iso-8859-1?Q?kulkSmMnpDpIn04yUFM5PvMwzBXxcgxo7u4nOIZJqYkqj8qvzEofbJTPAX?=
 =?iso-8859-1?Q?+xaqcwO2zXtByxxCqUz4txV9tZFHcR5tig2gcbSsKPhgTPpKdn3ZwbtQ7S?=
 =?iso-8859-1?Q?WndO1sL9YSWffYWLbMhqPq5OGQAsTRcgdf73rDjW0C1T67vxdhNm279qvJ?=
 =?iso-8859-1?Q?AsfK8y0i2ap8nQjNju73vHAH1PRlg7pYsEhaiYK08uuhqy72hdNPhVbcEl?=
 =?iso-8859-1?Q?b2OE3T6ybvBwf6+3+BoPGDuHuYrbAjAMSQuMSX9ayJPV13CQhNkv2/uZdm?=
 =?iso-8859-1?Q?E9PWv+x9ZREpqfpPicfjKs2gRb7kv0c2DdqdlR3qeY3Pwv//ovwScZoR+r?=
 =?iso-8859-1?Q?S2SsI3KPMB+AIr4HJGY0utsyHidDjDaW3kuevfmZauvGdgjr7eqc1iuics?=
 =?iso-8859-1?Q?xshXKz0IPfsPFM+05WjvdBtgWTzhbkmJ+c+uXIXTwOoH3Ok6nsWj5vfx5d?=
 =?iso-8859-1?Q?CDBvx+5GWX+61GSMaSIFp4y+DT3sDYVWBfVEWzNhJyWijnYyAVY0oeInuV?=
 =?iso-8859-1?Q?WrGpQE46ADnvLxIt819ghsgms8984eYYf4NLombGqsGzvVphjG9wNTbDj2?=
 =?iso-8859-1?Q?5Cxbq3Le8XDlzoarMREcNl949fE1mNbvGVlCXdbd3P2o7z8GNgDJ2Zm4K9?=
 =?iso-8859-1?Q?E/BR1ffOF/unvXY5lHzC/MJRTX50FV2YLMEHq3JAsFP2o7lH8qtydCI74Q?=
 =?iso-8859-1?Q?DeDlUpXYc+2zTmBEM9jXDuWQP+qQBySQuvFHf/qgnZj2HWbk7ruwiGFjvv?=
 =?iso-8859-1?Q?K1Z6Ljrkvm5sbjOm5QgbC20r4rtuvgG4bkezv0rzsiRIVROcyl2acKpA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a1c66c-bb87-4338-7c2e-08dbaeb2e990
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 08:26:06.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YomC1ufCr5YgveT2i4VJmtr4KVTDSMQqMe8E06spbh0ohP1OCI8psz9iagcKxNU4iGvqJ9SybKUbOTfpG0GoFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8216
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a -8.2% improvement of phoronix-test-suite.osbench.LaunchPrograms.us_per_event on:


commit: 9d32938c115580bfff128a926d704199d2f33ba3 ("[PATCH v3 2/2] kernel/fork: group allocation/free of per-cpu counters for mm struct")
url: https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/pcpcntr-add-group-allocation-free/20230823-130803
base: https://git.kernel.org/cgit/linux/kernel/git/dennis/percpu.git for-next
patch link: https://lore.kernel.org/all/20230823050609.2228718-3-mjguzik@gmail.com/
patch subject: [PATCH v3 2/2] kernel/fork: group allocation/free of per-cpu counters for mm struct

testcase: phoronix-test-suite
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
parameters:

	test: osbench-1.0.2
	option_a: Launch Programs
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230906/202309061504.7e645826-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/Launch Programs/debian-x86_64-phoronix/lkp-csl-2sp7/osbench-1.0.2/phoronix-test-suite

commit: 
  1db50472c8 ("pcpcntr: add group allocation/free")
  9d32938c11 ("kernel/fork: group allocation/free of per-cpu counters for mm struct")

1db50472c8bc1d34 9d32938c115580bfff128a926d7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      3.00           +33.3%       4.00        vmstat.procs.r
     14111            +5.7%      14918        vmstat.system.cs
      2114            +1.1%       2136        turbostat.Bzy_MHz
      1.67            +0.2        1.83        turbostat.C1E%
    121.98            +5.1%     128.24        turbostat.PkgWatt
     98.05            -8.2%      90.02        phoronix-test-suite.osbench.LaunchPrograms.us_per_event
     16246 ±  4%      +6.1%      17243        phoronix-test-suite.time.involuntary_context_switches
   9791476            +9.2%   10689455        phoronix-test-suite.time.minor_page_faults
    311.33            +9.3%     340.33        phoronix-test-suite.time.percent_of_cpu_this_job_got
     83.40 ±  2%      +9.2%      91.07 ±  2%  phoronix-test-suite.time.system_time
    151333            +8.6%     164355        phoronix-test-suite.time.voluntary_context_switches
      3225            -5.5%       3046 ±  5%  proc-vmstat.nr_page_table_pages
   9150454            +8.0%    9884178        proc-vmstat.numa_hit
   9088660            +8.7%    9882518        proc-vmstat.numa_local
   9971116            +8.3%   10802925        proc-vmstat.pgalloc_normal
  10202032            +8.8%   11099649        proc-vmstat.pgfault
   9845338            +8.4%   10676360        proc-vmstat.pgfree
    207049           +10.3%     228380 ±  8%  proc-vmstat.pgreuse
 1.947e+09            +5.0%  2.045e+09        perf-stat.i.branch-instructions
  52304206            +4.4%   54610501        perf-stat.i.branch-misses
      9.06 ±  2%      +0.5        9.52        perf-stat.i.cache-miss-rate%
  19663522 ±  3%     +10.0%   21634645        perf-stat.i.cache-misses
 1.658e+08            +3.6%  1.717e+08        perf-stat.i.cache-references
     14769            +6.2%      15691        perf-stat.i.context-switches
 1.338e+10            +6.2%   1.42e+10        perf-stat.i.cpu-cycles
   3112873 ±  3%     -12.5%    2724690 ±  3%  perf-stat.i.dTLB-load-misses
 2.396e+09            +5.5%  2.528e+09        perf-stat.i.dTLB-loads
      0.11 ±  4%      -0.0        0.10 ±  2%  perf-stat.i.dTLB-store-miss-rate%
   1003394 ±  6%     -14.0%     862768 ±  5%  perf-stat.i.dTLB-store-misses
  1.25e+09            +6.0%  1.325e+09        perf-stat.i.dTLB-stores
     71.16            -1.3       69.88        perf-stat.i.iTLB-load-miss-rate%
   1872082            +8.2%    2025999        perf-stat.i.iTLB-loads
 9.606e+09            +5.4%  1.012e+10        perf-stat.i.instructions
     23.37 ±  5%     +30.6%      30.53 ±  4%  perf-stat.i.major-faults
      0.14            +6.2%       0.15        perf-stat.i.metric.GHz
     59.39            +5.4%      62.61        perf-stat.i.metric.M/sec
    249517           +10.0%     274572        perf-stat.i.minor-faults
   5081285            +6.0%    5385686 ±  4%  perf-stat.i.node-load-misses
    565117 ±  3%      +8.1%     610682 ±  3%  perf-stat.i.node-loads
    249541           +10.0%     274602        perf-stat.i.page-faults
     17.27            -1.7%      16.98        perf-stat.overall.MPKI
     11.85 ±  2%      +0.7       12.59        perf-stat.overall.cache-miss-rate%
      0.13 ±  2%      -0.0        0.11 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
      0.08 ±  7%      -0.0        0.07 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
     67.26            -1.1       66.12        perf-stat.overall.iTLB-load-miss-rate%
 1.895e+09            +5.0%   1.99e+09        perf-stat.ps.branch-instructions
  50921385            +4.4%   53146828        perf-stat.ps.branch-misses
  19140130 ±  3%     +10.0%   21047707        perf-stat.ps.cache-misses
 1.615e+08            +3.5%  1.672e+08        perf-stat.ps.cache-references
     14376            +6.2%      15266        perf-stat.ps.context-switches
 1.303e+10            +6.1%  1.383e+10        perf-stat.ps.cpu-cycles
   3033019 ±  3%     -12.5%    2654269 ±  3%  perf-stat.ps.dTLB-load-misses
 2.332e+09            +5.5%   2.46e+09        perf-stat.ps.dTLB-loads
    976773 ±  6%     -14.1%     839517 ±  5%  perf-stat.ps.dTLB-store-misses
 1.217e+09            +6.0%  1.289e+09        perf-stat.ps.dTLB-stores
   1822198            +8.2%    1971115        perf-stat.ps.iTLB-loads
 9.349e+09            +5.3%  9.846e+09        perf-stat.ps.instructions
     22.75 ±  5%     +30.5%      29.69 ±  4%  perf-stat.ps.major-faults
    242831           +10.0%     267074        perf-stat.ps.minor-faults
   4945101            +5.9%    5238638 ±  4%  perf-stat.ps.node-load-misses
    550029 ±  3%      +8.0%     594116 ±  3%  perf-stat.ps.node-loads
    242854           +10.0%     267104        perf-stat.ps.page-faults
 3.719e+11            +4.4%  3.883e+11        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

