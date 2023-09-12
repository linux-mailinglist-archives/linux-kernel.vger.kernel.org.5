Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31C279C357
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbjILCxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240922AbjILCxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:53:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299849A03D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694485386; x=1726021386;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=w1RWwBztHQNTQqzLclV3AwZsQWe0H6oexUfg+VGwI2M=;
  b=e/trlDV09lF0rXv0IHiv2I/aovlOYHJY4vmsBXLNjc98r5O9fkCP5JDd
   oB3kC4aWTVkDX9Vl9krm96QJhkoXcatk4Kce2Pq01VX1Z5IwmyeCYU94g
   LvG5asYF3m8u9UTk2dbBMhvYFwvKN1vSf727L748MyqNTKC97dZrlZ7dv
   k3WGFLPe0X0cdkp5fpgNYlJ5nVU8v3e9rPnLfMRm3whCUdBkhB5abAyoz
   k3lqdTOYgFXdQqMNbifsRrzBj9pAkxYf4g9nbBtLBjjjZGZc07fowJdLZ
   ga2+JYdlRY3pfaEuscpaDOHwwiceisd+6UCYMXLw9q50LU9l5dpXiq9ck
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378164646"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378164646"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 19:23:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="833725241"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="833725241"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 19:23:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 19:23:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 19:23:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 19:23:04 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 19:23:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3R4OCQSaP42pL+TatyQghkAlZ4njDYM0RaTFykrP578i2P4smANlb3dYnluyrnhYq8bANCKAZYCaSumUkqA/1OYbf+b8rPTrIgAjimItUsuVGJBa+wK9cy/VmJspvelX/g1cU3zQq8aJRxrDXesPsK17W+WSvCGmdvO+8eggTTiXG8sXxcWLF064fzX2D54YIJJGNZztXLdZ58oLGvQnoMosrljNlXYTicgahkvvfWh3XRvNxarHzVe7gkHE7y21dQgPtPzdPcrudecJ2AcWNnXIc0Jok/a1HSgS685g4oGjIlwAao0jdRmcrkr59gPZYIanUv/69NoYkjpnSE5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PeE7Xk+mP1Ao61cJJpf3a/NbWJkCZWcvc28EsLvA/s=;
 b=N5iIgDeKsfswQo002RFFtAT+FB8TrNTD/+mevo//miCZIjRbFPYbA7dZSc+U8v5XnmHifIxfzyGs+h+VvVUdaIoguawvvOAoE4AV2GR+YRxT+IHs18GDScs4gHB70Uc/6bjon53h4XJL1/lvLO79JGqinppKUT5WOVHduzOZloMxfe/MOMd5iL4JQ7gY3XETcQvbFKxvpUMML9VXq0/wy51wiQ9T3awC6Y8dcQmpbJ6+zBMR7SxTFoUXy/3u/jQOWjGz+UFEg7IQepURBvfNs9pcSL+coqQWmmI3MDy6vVRg+sl8qYlbhWTC0zyZ7k+dm6OJ+4V/hNb40q9iva2SVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SN7PR11MB6875.namprd11.prod.outlook.com (2603:10b6:806:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 02:23:01 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 02:23:01 +0000
Date:   Tue, 12 Sep 2023 10:22:48 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Raghavendra K T <raghavendra.kt@amd.com>
CC:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        "Bharata B Rao" <bharata@amd.com>, <linux-kernel@vger.kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <aubrey.li@linux.intel.com>,
        <yu.c.chen@intel.com>, <linux-mm@kvack.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, <rppt@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aithal Srikanth <sraithal@amd.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        <oliver.sang@intel.com>
Subject: Re: [RFC PATCH V1 5/6] sched/numa: Allow recently accessed VMAs to
 be scanned
Message-ID: <ZP/LeEQpE1TBs7LS@xsang-OptiPlex-9020>
References: <202309102311.84b42068-oliver.sang@intel.com>
 <1e8fcce9-fda4-7bf7-97c3-cb9e4a4d788e@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e8fcce9-fda4-7bf7-97c3-cb9e4a4d788e@amd.com>
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SN7PR11MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c642671-db08-4bbb-8d7f-08dbb3372fb1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPV8FNfZISsWLg6egOav6gekmDEA2VQT9xjc8A2xocjvYeWXBdyCxyutsMzhI+xkPRsqc+ywc8FTYBa4lC+DaSqgErRWV6McsTbujQa2BXwbY5/6cjs7MYbEu375ryPsQaK+MEvLdcnx1EKRolI5OVQsMWfgynp/jPGqY/hVD61QYUi7CNPf8J5c+b+vYM7a4V2iDhmuTCsGB+o7axDxMDD4GMFzCBO2s5fdi0hBm3rDnCYdJ3vdSmCkQwZew8VFm8C9MWpK32CWbSoGKBrPqGfZhAzW/5HTxjmXfg4EOJTyui5Cf0gOLWFpGv2skxuLoRUiawdnrd9/yUf00kw86GcwrCdm+oM1DrTnADnKn5mi5oXBpHkZrV+0bNFMeMyeQzZDGb/wX77PGilfrsFIAUhLeNBuf8QFgpxtatioZDgi+zq5ABkGl/pVn3Gz3uvUxuyjTHrKkCyqYePJ/y94NyvTn+KF98SpH4tQ/VS4cfJIrmnS5Uc2RNUE+X4Dc6cs+HSPiw/AVlks1cR/sIY/C+qhx3zxfVx+R4PVsYz8iZEM3pY46BBDseMZgUgzGdyD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199024)(1800799009)(186009)(33716001)(6666004)(6486002)(53546011)(6506007)(9686003)(6512007)(83380400001)(26005)(478600001)(2906002)(8936002)(66476007)(66556008)(66946007)(41300700001)(6916009)(44832011)(54906003)(8676002)(7416002)(5660300002)(316002)(30864003)(38100700002)(86362001)(4326008)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wjQ23iti8X8DEUCv+UwqvnvzEQtHV8D8VSaFor64j+LfrwfLt2k0rwj7UI?=
 =?iso-8859-1?Q?0LbWKhyYW//7a/rfTnvguRp42xXSIT0Iidn1HQQdxzMVqOAs8BtJCLKKdg?=
 =?iso-8859-1?Q?poDQwchp3eW6YYbEs3CXGlTncfOLMNSICaQ1mRQesZLd/I7zzhyDEOSbkc?=
 =?iso-8859-1?Q?TOWRKGb0vrbpoeobfNtPslmQeG4BLhhObZt61bZnogvxFUGZBefDhn3zST?=
 =?iso-8859-1?Q?1zfCdFu7/I2DeKPPRr/ChZOk8l69qu+CLRiMQIlS2wIhvA2jNoqaWXnOzs?=
 =?iso-8859-1?Q?Ne6k/aHG73pSQZkT0x8eqrivnIqz0lEtk8SR+w8nHfmy23Kzht8mBwbKpY?=
 =?iso-8859-1?Q?uMSMWLXJxc6mTu0qRMkcK6jsPMU/hUqNf4n0fhkYmLFQJ+nfY9lbF2UpD+?=
 =?iso-8859-1?Q?AqQJFE85MiNt+GgwpcP4c6M9s9c6D0SX/KRUwa/zsy/JVIvy/Go0ayJf+W?=
 =?iso-8859-1?Q?g5x9MKRrGUtS8y1HpWF/l8TdlWfU9d1uQ1y+D3DsyxQorVErAgZZ8/ywIF?=
 =?iso-8859-1?Q?Ksk+mH0Qdy3Pk05chWA2HVwtRZEXzFpDO7O8atqj3g3dVf/CWKZ71HCkBs?=
 =?iso-8859-1?Q?0ZX+BTb0oknfQVI9ZAfHhQsti8FNmxwkWqsv3VYHKcOljS71S8VDSWBCqt?=
 =?iso-8859-1?Q?9rwlM84ekQhkr0ZYGD9g3U+JaRV1y4ow3KIOiJ+12vIZ1aFdk600ZP4KO7?=
 =?iso-8859-1?Q?4gFT7H8Y8GB5rJIIe5tR2CA65L/2pMXNWJioB1ZE6SVR9S4V0/cStLzKt6?=
 =?iso-8859-1?Q?bXvMolCNJg+45KJqvPyiU/VQhaMAN+a8KIX7STMb4pFA3PE+dtn7sw3QWY?=
 =?iso-8859-1?Q?YT3VtxBF4kGXwbPDXhrQNCScrwO+lnXBUIkp7FE7HfCM4BxzvjS+b2x7mY?=
 =?iso-8859-1?Q?Uz//RfFBdLaQX6IcBiqAut2Q2MAFWRTKrgyRBDpc9JGsP80c7XNPTsFyN3?=
 =?iso-8859-1?Q?KF35kgkqeHxR0oBERM0sAAj45kSumpA2hnRYQK0Nm8ahZHmZH8b3nuIasc?=
 =?iso-8859-1?Q?TAVFi8sXpIy/MFSGhkCr2Owr3o/kIB6Xq1JWk9BNeNMhSVm0UOTUl7//Cw?=
 =?iso-8859-1?Q?bmTXb268otjsb1nG1edWQuvyoiADFzJJEVopD+ZYeBpgJqgLuOXOwwvUQY?=
 =?iso-8859-1?Q?4dB5sY/3BRperT44n3lIQqdj19WxmOk5LXv0GUroDLz7tynZzNDFZoPQtS?=
 =?iso-8859-1?Q?m/jUds4/ZrikkQhdE6fb8+kzXuIYdGHUY/w4LNJNFZgAPL8o+7LUeRAzEa?=
 =?iso-8859-1?Q?FtXrZS5AX2/hQDC1jSyzjb3j43n8Be7KfS9vLMuvX6t5td2DJ/oXiP+0TX?=
 =?iso-8859-1?Q?WmHuNgVCtAJ9TI0qvBG4GtbTrVB1AlJDtrdDwJXyxL8DmEwfF4V426GASz?=
 =?iso-8859-1?Q?95tD5yCT0K+BE56nTCUBlYDa1bvWOWVZQ5M1h7u2wX50sYFbmoGhWvMVoC?=
 =?iso-8859-1?Q?xWAbfXJBrXD8sThwVdEv2ZGfmjU9UGJV5RC3WMd8LV0uHFnUf07f41XRZx?=
 =?iso-8859-1?Q?84bQ/AOUFoIVmhsvcPdASYZpEM9NsrUliB+LJAPujyn3KuDZlet4X5ow77?=
 =?iso-8859-1?Q?HVv344ltY/XbVQzaNl4vCDGrIXLIo9vzj2K7jAMAEPlCRO7/K8npoB59Mw?=
 =?iso-8859-1?Q?IPFJUKyD+IdnhYaNkRDgbbjlSI7ezYaaFpAxnvEIK26dtKgOCT5z/hZg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c642671-db08-4bbb-8d7f-08dbb3372fb1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 02:23:01.1388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/FMhwDqSW9z9/0ANWYIpYLKkbJJsmJym1DiPSNzWUSl50rFRy7+s657o1+fWR06j70WAIt978VQa0r2Ysnfag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6875
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Raghu,

On Mon, Sep 11, 2023 at 04:55:56PM +0530, Raghavendra K T wrote:
> On 9/10/2023 8:59 PM, kernel test robot wrote:
> >    341.49            -4.1%     327.42 ±  2%  autonuma-benchmark.numa01.seconds
> >      186.67 ±  6%     -27.1%     136.12 ±  7%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
> >       21.17 ±  7%     -33.6%      14.05        autonuma-benchmark.numa02.seconds
> >        2200 ±  2%     -13.0%       1913 ±  3%  autonuma-benchmark.time.elapsed_time
> 
> Hello Oliver/Kernel test robot,
> Thank yo alot for testing.
> 
> Results are impressive. Can I take this result as
> positive for whole series too?

FYI. we applied your patch set like below:

68cfe9439a1ba (linux-review/Raghavendra-K-T/sched-numa-Move-up-the-access-pid-reset-logic/20230829-141007) sched/numa: Allow scanning of shared VMAs
af46f3c9ca2d1 sched/numa: Allow recently accessed VMAs to be scanned
167773d1ddb5f sched/numa: Increase tasks' access history
fc769221b2306 sched/numa: Remove unconditional scan logic using mm numa_scan_seq
1ef5cbb92bdb3 sched/numa: Add disjoint vma unconditional scan logic
2a806eab1c2e1 sched/numa: Move up the access pid reset logic
2f88c8e802c8b (tip/sched/core) sched/eevdf/doc: Modify the documented knob to base_slice_ns as well

in our tests, we also tested the 68cfe9439a1ba, if comparing it to af46f3c9ca2d1:

=========================================================================================
compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp6/numa01_THREAD_ALLOC/autonuma-benchmark

commit:
  af46f3c9ca ("sched/numa: Allow recently accessed VMAs to be scanned")
  68cfe9439a ("sched/numa: Allow scanning of shared VMA")

af46f3c9ca2d1648 68cfe9439a1baa642e05883fa64
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    327.42 ±  2%      -1.1%     323.83 ±  3%  autonuma-benchmark.numa01.seconds
    136.12 ±  7%     -25.1%     101.90 ±  2%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
     14.05            +1.5%      14.26        autonuma-benchmark.numa02.seconds
      1913 ±  3%      -7.9%       1763 ±  2%  autonuma-benchmark.time.elapsed_time


below is the full comparison FYI.


af46f3c9ca2d1648 68cfe9439a1baa642e05883fa64
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
     36437 ±  9%     +20.4%      43867 ± 10%  meminfo.Mapped
      0.02 ± 17%      +0.0        0.03 ±  8%  mpstat.cpu.all.iowait%
     71.00 ±  2%      +6.3%      75.50        turbostat.PkgTmp
   3956991 ±  7%     -15.0%    3361998 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.stddev
   3956991 ±  7%     -15.0%    3361997 ±  5%  sched_debug.cfs_rq:/.min_vruntime.stddev
    -30.18           +27.8%     -38.56        sched_debug.cpu.nr_uninterruptible.min
      1913 ±  3%      -7.9%       1763 ±  2%  time.elapsed_time
      1913 ±  3%      -7.9%       1763 ±  2%  time.elapsed_time.max
   3194802            -2.4%    3117907        time.minor_page_faults
    210725 ±  3%      -8.7%     192483 ±  3%  time.user_time
    327.42 ±  2%      -1.1%     323.83 ±  3%  autonuma-benchmark.numa01.seconds
    136.12 ±  7%     -25.1%     101.90 ±  2%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
     14.05            +1.5%      14.26        autonuma-benchmark.numa02.seconds
      1913 ±  3%      -7.9%       1763 ±  2%  autonuma-benchmark.time.elapsed_time
      1913 ±  3%      -7.9%       1763 ±  2%  autonuma-benchmark.time.elapsed_time.max
   3194802            -2.4%    3117907        autonuma-benchmark.time.minor_page_faults
    210725 ±  3%      -8.7%     192483 ±  3%  autonuma-benchmark.time.user_time
      1.33 ± 91%     -88.0%       0.16 ± 14%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.09 ±194%   +3204.2%       3.03 ± 66%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      3.72 ±  9%     -24.8%       2.80 ± 21%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
     41.00 ±147%   +2060.2%     885.67 ±105%  perf-sched.wait_and_delay.count.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault
     18.61 ± 18%     -28.5%      13.30 ± 21%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      7.84 ±100%    +354.6%      35.66 ± 89%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      9285 ±  8%     +20.1%      11152 ± 10%  proc-vmstat.nr_mapped
   6984234            -4.0%    6706018        proc-vmstat.numa_hit
   5686795 ±  2%      -5.2%    5390176        proc-vmstat.numa_local
  10616944 ±  4%     +15.7%   12279801 ±  3%  proc-vmstat.numa_pages_migrated
   7827793 ±  2%      -5.2%    7421440 ±  2%  proc-vmstat.pgfault
  10616944 ±  4%     +15.7%   12279801 ±  3%  proc-vmstat.pgmigrate_success
    334391 ±  2%      -8.6%     305628 ±  2%  proc-vmstat.pgreuse
     20686 ±  4%     +15.7%      23939 ±  3%  proc-vmstat.thp_migration_success
  14322816 ±  3%      -8.2%   13147392 ±  2%  proc-vmstat.unevictable_pgs_scanned
      1339 ±  3%      +8.6%       1454 ±  2%  perf-stat.i.MPKI
 1.716e+08            +2.8%  1.764e+08        perf-stat.i.branch-instructions
      1.03            +0.1        1.11 ±  3%  perf-stat.i.branch-miss-rate%
   1707146 ±  2%      +9.5%    1869960 ±  4%  perf-stat.i.branch-misses
 7.513e+08 ±  4%     +11.1%  8.351e+08 ±  3%  perf-stat.i.cache-misses
 9.542e+08 ±  3%      +8.9%   1.04e+09 ±  3%  perf-stat.i.cache-references
    534.57            -1.5%     526.34        perf-stat.i.cpi
    158.57            +1.6%     161.11        perf-stat.i.cpu-migrations
    582.98 ±  6%     -11.4%     516.40 ±  3%  perf-stat.i.cycles-between-cache-misses
 2.263e+08            +2.2%  2.312e+08        perf-stat.i.dTLB-loads
 8.538e+08            +2.5%  8.753e+08        perf-stat.i.instructions
     15.98 ±  3%      +8.9%      17.40 ±  3%  perf-stat.i.metric.M/sec
      3958            +3.0%       4075        perf-stat.i.minor-faults
     37.89 ±  3%      -3.6       34.28 ±  5%  perf-stat.i.node-store-miss-rate%
 2.585e+08 ±  4%      -7.7%  2.385e+08 ±  3%  perf-stat.i.node-store-misses
 4.902e+08 ±  7%     +21.1%  5.937e+08 ±  7%  perf-stat.i.node-stores
      3958            +2.9%       4075        perf-stat.i.page-faults
      1116 ±  2%      +6.2%       1186 ±  2%  perf-stat.overall.MPKI
      0.98            +0.1        1.04 ±  3%  perf-stat.overall.branch-miss-rate%
    448.99            -2.8%     436.60        perf-stat.overall.cpi
    508.08 ±  4%     -10.1%     456.56 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.00            +2.8%       0.00        perf-stat.overall.ipc
     34.70 ±  6%      -5.7       29.02 ±  7%  perf-stat.overall.node-store-miss-rate%
 1.698e+08            +2.8%  1.746e+08        perf-stat.ps.branch-instructions
   1665855 ±  2%      +9.5%    1824511 ±  3%  perf-stat.ps.branch-misses
 7.489e+08 ±  4%     +10.9%  8.306e+08 ±  4%  perf-stat.ps.cache-misses
 9.447e+08 ±  3%      +8.9%  1.029e+09 ±  3%  perf-stat.ps.cache-references
    158.05            +1.4%     160.31        perf-stat.ps.cpu-migrations
 2.244e+08            +2.1%  2.292e+08        perf-stat.ps.dTLB-loads
  8.46e+08            +2.5%  8.672e+08        perf-stat.ps.instructions
      3906            +2.9%       4020        perf-stat.ps.minor-faults
    284110 ±  5%     +12.0%     318166 ±  2%  perf-stat.ps.node-loads
 2.584e+08 ±  3%      -7.3%  2.395e+08 ±  3%  perf-stat.ps.node-store-misses
 4.879e+08 ±  7%     +20.6%  5.883e+08 ±  7%  perf-stat.ps.node-stores
      3906            +2.9%       4020        perf-stat.ps.page-faults
 1.622e+12 ±  2%      -5.7%   1.53e+12 ±  2%  perf-stat.total.instructions
      6.29 ± 13%      -2.2        4.11 ± 24%  perf-profile.calltrace.cycles-pp.read
      6.22 ± 13%      -2.2        4.05 ± 24%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      6.21 ± 13%      -2.2        4.04 ± 24%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      6.04 ± 13%      -2.1        3.90 ± 24%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      6.09 ± 13%      -2.1        3.96 ± 24%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.68 ± 17%      -1.4        2.25 ± 36%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.22 ± 16%      -1.4        1.79 ± 27%  perf-profile.calltrace.cycles-pp.open64
      3.66 ± 16%      -1.4        2.24 ± 36%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      3.88 ± 13%      -1.4        2.49 ± 20%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.83 ± 13%      -1.4        2.48 ± 19%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      3.03 ± 17%      -1.3        1.71 ± 26%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      3.09 ± 17%      -1.3        1.77 ± 27%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      3.08 ± 17%      -1.3        1.76 ± 27%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      3.04 ± 17%      -1.3        1.73 ± 26%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      2.61 ± 14%      -1.0        1.60 ± 20%  perf-profile.calltrace.cycles-pp.proc_single_show.seq_read_iter.seq_read.vfs_read.ksys_read
      2.58 ± 13%      -1.0        1.58 ± 21%  perf-profile.calltrace.cycles-pp.do_task_stat.proc_single_show.seq_read_iter.seq_read.vfs_read
      0.99 ± 17%      -0.5        0.46 ± 75%  perf-profile.calltrace.cycles-pp.__xstat64
      0.97 ± 18%      -0.5        0.46 ± 75%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat64
      0.96 ± 18%      -0.5        0.46 ± 75%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      0.95 ± 18%      -0.5        0.45 ± 75%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      0.92 ± 19%      -0.5        0.45 ± 75%  perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      0.72 ± 12%      -0.3        0.40 ± 71%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      7.12 ± 13%      -2.4        4.73 ± 22%  perf-profile.children.cycles-pp.ksys_read
      6.91 ± 12%      -2.3        4.57 ± 23%  perf-profile.children.cycles-pp.vfs_read
      6.30 ± 13%      -2.2        4.12 ± 24%  perf-profile.children.cycles-pp.read
      5.34 ± 12%      -1.9        3.46 ± 25%  perf-profile.children.cycles-pp.seq_read_iter
      4.65 ± 13%      -1.7        2.98 ± 31%  perf-profile.children.cycles-pp.do_sys_openat2
      4.67 ± 13%      -1.7        3.01 ± 30%  perf-profile.children.cycles-pp.__x64_sys_openat
      4.43 ± 13%      -1.6        2.86 ± 29%  perf-profile.children.cycles-pp.do_filp_open
      4.41 ± 13%      -1.6        2.85 ± 29%  perf-profile.children.cycles-pp.path_openat
      3.23 ± 16%      -1.4        1.80 ± 27%  perf-profile.children.cycles-pp.open64
      3.89 ± 13%      -1.4        2.49 ± 20%  perf-profile.children.cycles-pp.seq_read
      2.61 ± 14%      -1.0        1.60 ± 20%  perf-profile.children.cycles-pp.proc_single_show
      2.59 ± 13%      -1.0        1.58 ± 21%  perf-profile.children.cycles-pp.do_task_stat
      1.66 ± 12%      -0.7        0.96 ± 36%  perf-profile.children.cycles-pp.lookup_fast
      1.43 ± 16%      -0.6        0.86 ± 29%  perf-profile.children.cycles-pp.walk_component
      1.50 ± 14%      -0.5        0.96 ± 30%  perf-profile.children.cycles-pp.link_path_walk
      1.24 ± 10%      -0.5        0.77 ± 32%  perf-profile.children.cycles-pp.do_open
      1.53 ±  7%      -0.4        1.08 ± 19%  perf-profile.children.cycles-pp.sched_setaffinity
      1.02 ± 15%      -0.4        0.64 ± 33%  perf-profile.children.cycles-pp.__xstat64
      1.10 ± 18%      -0.4        0.72 ± 31%  perf-profile.children.cycles-pp.__do_sys_newstat
      1.09 ± 18%      -0.4        0.73 ± 30%  perf-profile.children.cycles-pp.path_lookupat
      1.10 ± 18%      -0.4        0.74 ± 29%  perf-profile.children.cycles-pp.filename_lookup
      1.07 ± 19%      -0.4        0.72 ± 32%  perf-profile.children.cycles-pp.vfs_fstatat
      0.97 ±  9%      -0.4        0.62 ± 34%  perf-profile.children.cycles-pp.do_dentry_open
      0.82 ± 19%      -0.4        0.48 ± 34%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.94 ± 18%      -0.3        0.61 ± 35%  perf-profile.children.cycles-pp.vfs_statx
      0.61 ± 11%      -0.3        0.33 ± 32%  perf-profile.children.cycles-pp.pid_revalidate
      0.78 ± 14%      -0.3        0.50 ± 29%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.64 ± 15%      -0.3        0.37 ± 29%  perf-profile.children.cycles-pp.getdents64
      0.62 ± 16%      -0.3        0.35 ± 28%  perf-profile.children.cycles-pp.proc_pid_readdir
      0.64 ± 15%      -0.3        0.37 ± 29%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      0.64 ± 15%      -0.3        0.37 ± 29%  perf-profile.children.cycles-pp.iterate_dir
      0.61 ± 15%      -0.3        0.35 ± 24%  perf-profile.children.cycles-pp.__percpu_counter_init
      0.96 ±  8%      -0.3        0.71 ± 20%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      1.03 ± 12%      -0.2        0.78 ± 15%  perf-profile.children.cycles-pp.__libc_read
      0.75 ±  8%      -0.2        0.53 ± 17%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.39 ± 13%      -0.2        0.19 ± 24%  perf-profile.children.cycles-pp.__entry_text_start
      0.40 ± 18%      -0.2        0.22 ± 25%  perf-profile.children.cycles-pp.ptrace_may_access
      0.62 ±  7%      -0.2        0.45 ± 17%  perf-profile.children.cycles-pp.__sched_setaffinity
      0.36 ± 16%      -0.2        0.20 ± 25%  perf-profile.children.cycles-pp.proc_fill_cache
      0.57 ±  6%      -0.2        0.40 ± 20%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      0.42 ± 21%      -0.2        0.27 ± 38%  perf-profile.children.cycles-pp.inode_permission
      0.36 ± 20%      -0.1        0.22 ± 25%  perf-profile.children.cycles-pp._find_next_bit
      0.39 ± 14%      -0.1        0.25 ± 22%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.44 ± 12%      -0.1        0.30 ± 26%  perf-profile.children.cycles-pp.pick_link
      0.25 ± 18%      -0.1        0.12 ± 19%  perf-profile.children.cycles-pp.security_ptrace_access_check
      0.32 ± 15%      -0.1        0.19 ± 22%  perf-profile.children.cycles-pp.__x64_sys_readlink
      0.22 ± 13%      -0.1        0.11 ± 33%  perf-profile.children.cycles-pp.readlink
      0.31 ± 14%      -0.1        0.19 ± 22%  perf-profile.children.cycles-pp.do_readlinkat
      0.32 ± 11%      -0.1        0.22 ± 30%  perf-profile.children.cycles-pp.vfs_fstat
      0.26 ± 19%      -0.1        0.15 ± 26%  perf-profile.children.cycles-pp.load_elf_interp
      0.22 ± 17%      -0.1        0.12 ± 32%  perf-profile.children.cycles-pp.d_hash_and_lookup
      0.21 ± 31%      -0.1        0.12 ± 31%  perf-profile.children.cycles-pp.may_open
      0.30 ± 14%      -0.1        0.21 ± 18%  perf-profile.children.cycles-pp.copy_strings
      0.24 ± 18%      -0.1        0.14 ± 32%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.19 ± 19%      -0.1        0.10 ± 32%  perf-profile.children.cycles-pp.__kmalloc_node
      0.29 ±  8%      -0.1        0.21 ± 10%  perf-profile.children.cycles-pp.affine_move_task
      0.24 ± 21%      -0.1        0.16 ± 24%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.22 ± 10%      -0.1        0.14 ± 28%  perf-profile.children.cycles-pp.mas_preallocate
      0.24 ± 12%      -0.1        0.16 ± 30%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.21 ± 14%      -0.1        0.14 ± 20%  perf-profile.children.cycles-pp.__d_alloc
      0.10 ± 19%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.pid_task
      0.14 ± 24%      -0.1        0.06 ± 50%  perf-profile.children.cycles-pp.single_open
      0.20 ± 11%      -0.1        0.12 ± 12%  perf-profile.children.cycles-pp.cpu_stop_queue_work
      0.18 ± 16%      -0.1        0.11 ± 25%  perf-profile.children.cycles-pp.generic_fillattr
      0.14 ± 19%      -0.1        0.07 ± 29%  perf-profile.children.cycles-pp.apparmor_ptrace_access_check
      0.14 ± 23%      -0.1        0.08 ± 30%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.10 ± 10%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.vfs_readlink
      0.09 ± 19%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.aa_get_task_label
      0.14 ± 25%      -0.1        0.08 ± 23%  perf-profile.children.cycles-pp.proc_pid_get_link
      0.16 ± 21%      -0.1        0.10 ± 28%  perf-profile.children.cycles-pp.thread_group_cputime_adjusted
      0.19 ± 15%      -0.1        0.13 ± 27%  perf-profile.children.cycles-pp.strnlen_user
      0.18 ± 27%      -0.1        0.11 ± 21%  perf-profile.children.cycles-pp.wq_worker_comm
      0.18 ± 13%      -0.1        0.11 ± 36%  perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.17 ± 16%      -0.1        0.11 ± 24%  perf-profile.children.cycles-pp.proc_pid_cmdline_read
      0.12 ± 10%      -0.1        0.06 ± 48%  perf-profile.children.cycles-pp.terminate_walk
      0.14 ± 18%      -0.1        0.09 ± 27%  perf-profile.children.cycles-pp.thread_group_cputime
      0.13 ± 21%      -0.0        0.08 ± 27%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.14 ± 18%      -0.0        0.10 ± 26%  perf-profile.children.cycles-pp.get_mm_cmdline
      0.14 ± 10%      -0.0        0.10 ± 17%  perf-profile.children.cycles-pp.wake_up_q
      1.37 ± 16%      -0.6        0.81 ± 23%  perf-profile.self.cycles-pp.do_task_stat
      0.80 ± 18%      -0.3        0.46 ± 34%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.39 ± 15%      -0.2        0.19 ± 33%  perf-profile.self.cycles-pp.pid_revalidate
      0.37 ± 11%      -0.2        0.18 ± 22%  perf-profile.self.cycles-pp.__entry_text_start
      0.36 ± 14%      -0.2        0.21 ± 37%  perf-profile.self.cycles-pp.do_dentry_open
      0.44 ± 17%      -0.1        0.31 ± 24%  perf-profile.self.cycles-pp.gather_pte_stats
      0.23 ± 15%      -0.1        0.14 ± 14%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.10 ± 18%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.pid_task
      0.21 ± 17%      -0.1        0.14 ± 25%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.14 ± 23%      -0.1        0.08 ± 30%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.16 ± 23%      -0.1        0.09 ± 26%  perf-profile.self.cycles-pp.generic_fillattr
      0.09 ± 20%      -0.1        0.03 ±101%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.10 ± 25%      -0.1        0.04 ± 76%  perf-profile.self.cycles-pp.proc_fill_cache
      0.12 ± 20%      -0.1        0.06 ± 58%  perf-profile.self.cycles-pp.lookup_fast



> 
> Mel/PeterZ,
> 
> Whenever time permits can you please let us know your comments/concerns
> on the series?
> 
> Thanks and Regards
> - Raghu
> 
