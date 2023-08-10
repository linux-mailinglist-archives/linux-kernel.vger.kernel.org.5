Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A415777AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjHJO2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjHJO23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:28:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00939121;
        Thu, 10 Aug 2023 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691677706; x=1723213706;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=aKQS7NiwZf9eFFmFuomWb6ued9Bo6ddA8xy0PDS4tUs=;
  b=aW8xJ027vvBSPeexpwbK2P2nLrQ0OiBJA2ZIJxmpfpgFII7B8qk8sixZ
   ALVrAMkEvf5pd65DTVbbfgYZ/8B9eVZanR/R3rbxzxlC7KhSxkaZVkK0j
   yDr194LgOfy4v+V8djw2Hwf2tMueBWBtiBxu59WPi2mTiFcssrvoz5o+X
   PvaABOYw2XUT25/Lv8WahXeMQHpk51rNevX//TkGDi8/1jFhQ7VsyVMQm
   aGF4gpIEgHx4PUBWCo1aDQOVFPNYOMxYwBQo6n96D+/UaTFd7IMMkC9FQ
   IgyccdHUoaTFun28iY9z+G4S5KVXcEHvCRyP4OT32XXbusGhdyINydTj3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351733420"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="351733420"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 07:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="732267592"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="732267592"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 10 Aug 2023 07:25:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 07:25:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 07:25:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 07:25:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbJKgFNx92mWctLXjWLintmWTDxlDAzF/aC6phmOwW48FfTr0OKqHMPhxVQY8aiudFn7TQdTXNUun4pBlzpX3enpMVCvbubseI35WhOxJ1gAJhuY/rn/PPP9rV+F95YlxA/8nVIAAotL6IZraC7dOROAh/jkNDPtTmPUhCGngtRJcsGE1Cufl8mB9ZJDyx0Ril566gH2OG8urvloCU1T30kvCa7ThB/WvSRM4E9pBV3JAvZUewqre3csjEpJ1LOr5PdsyMgKPX5bP5zSLdfhQt+doRB7V8wJ3w5+HAoJYD6R619CwgzchwJicDE/R9E9aQ2Q7TBjCDLzcOvFYCO8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s890S8nWfR190Ra8nO05GQ8t2sulQh4IZkisGPXgNk=;
 b=MrjRVbQyDsEF88RsPCALaGmHNEmibv0m74XEDl+csofsq7+FHP84ypBrcw748tP7jPtK101BxdMYX3n/jHEDndy7nU6isem7vDpku+fTcyal+TC30t8rEoF2Pfgf/XrhKRytAws014srbwai4rvHdcsKAD46SKgCEx7xgUbiUv5qTjF1gubfzhZktOB6R9sN8/uJNcZLaRmy4MnfPMfmnJebS2CiSIDJ7mUjxJnAiV6BU2q3FADkcoqmcS/Tfq2eR6A55XJQgDVDTKTetxTQImaWey4ih2rgIPFo1tQpkYsQB/T5yrjQma2dHgk7mPsb3KWe93lApWw+ZhLUT1hLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA1PR11MB6822.namprd11.prod.outlook.com (2603:10b6:806:29f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:25:21 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::1778:c00c:d5ff:da66]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::1778:c00c:d5ff:da66%6]) with mapi id 15.20.6652.028; Thu, 10 Aug 2023
 14:25:21 +0000
Date:   Thu, 10 Aug 2023 22:25:08 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     <chengming.zhou@linux.dev>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-block@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>, <axboe@kernel.dk>,
        <hch@lst.de>, <ming.lei@redhat.com>,
        <linux-kernel@vger.kernel.org>, <zhouchengming@bytedance.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH v2 4/4] blk-flush: don't need to end rq twice for non
 postflush
Message-ID: <202308102227.eb19f29a-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725130102.3030032-5-chengming.zhou@linux.dev>
X-ClientProxiedBy: KL1PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:820::17) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA1PR11MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 5543f393-eab6-4204-d059-08db99ada0e9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKnM36gI/JqNRxkwVisjGDs0/Fiybhj/y9bmDnHcSwAoU/di9w0oL/ZhaBdaj67JWvVY7VScdSX53H5oa0xe22OiSW5yuNra2Z+5PuNt5LfmLUFZbXUkBjfueMJSF7rNjwIPVKD+P+opbeD9DXLUp5wxsZWTq0HnCXTI4bFhfpZVRxBC4neqA6rTBuWYCcZNN2I+MbbZoa79LGTXwZX8wb7EDzN2c+1DnRHyn9xTYB9CEVMJzzWpmiaivcK+b6GkDA0O85Sy3Sm+R6PlW7gXbuMjEq3INNsLvpBGrsWuHuhWimnOpo0Aj/cfwQJCihz3hAGUdgkcEc0bk+A6vri0lfQDmCLPyj9vfrjtyZ16SihxLrchwOXA0rOtPRnpZunly4hSpE39gfIyclyvqnYJu/tRrvzWWWHUf9F7WIpXG3u92PhokC80SDbgiMxSNEnNHY7LDCBY/5ynNjTSDa5GksxwQS31uaCYj97k5E3trvwqxK7fXRHSDaihturH2ypQU9mfFCjMsM42ia00Ys8ID59Zj/a4PEN+sXNaHa/inMGp1RrBRQfyvtsBRB38zZ9sfhWsdiqmWwID6cuuF+kouQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(136003)(346002)(396003)(186006)(451199021)(1800799006)(86362001)(5660300002)(38100700002)(6916009)(4326008)(66476007)(66556008)(66946007)(107886003)(8676002)(83380400001)(41300700001)(8936002)(478600001)(30864003)(316002)(2906002)(82960400001)(6666004)(2616005)(6486002)(966005)(6512007)(36756003)(26005)(6506007)(1076003)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?grdVrNL4J5WyytLy+jPF1ol0P3NYLwY+s+ItHKDPbpaF0KlQlJPAc8/Gba?=
 =?iso-8859-1?Q?BMm/qbv62XzNJe1Lin46LjKv0nQvdS7B19tEQwrvunwwTXLlf4q2p0o1tk?=
 =?iso-8859-1?Q?d0Zndk1Id+5rCylJjO+30zG5QS0hGMETMYtlQZO5Dm2sxzD7J3bOCXJCw0?=
 =?iso-8859-1?Q?3kak12ynwlYlhzvLqiKuM2nSWNgD+xY/TIcWy4cBgnXvp0rgOqkbh3Damh?=
 =?iso-8859-1?Q?pKQ8oc+6j5FqPUAMr6in677UlVraO/w9R/cUCKAHB4ik6ZzPp85Rem10YA?=
 =?iso-8859-1?Q?aj0QYYVtjmnvL/U6bTy8ULL9pGnVjaQSNys49NtLW2uCDA39QiKGutDyiZ?=
 =?iso-8859-1?Q?Yje6KqqriWC30yKZ0a++iObkAYAqye2ehxwDj/b8SYxxHt0neMA5ojqlr+?=
 =?iso-8859-1?Q?yVa9WUAd6PFOFeaE2Xsh+YwTL9yg0ZVA73QkoM8u1nPp2PM/vSqcXqeQOw?=
 =?iso-8859-1?Q?lgYblM0s3UtKpx9p8rMqyfnXSkiI6lfJxgIyjdXLo2vwdzymync7OGx+Yd?=
 =?iso-8859-1?Q?oPjOFIuVHXezZFtnwEdCjXj3KbdNVUWHrOK2J6yQr8hU5yG7De4HxXv/Ip?=
 =?iso-8859-1?Q?MOZrMci1Aa/kl+veReGWYUdz+1Ek7KfPHQKNcMYQcaufqOG9V8m5uTf5en?=
 =?iso-8859-1?Q?anPO0YUwqENr4SeZEs9nFaNNupo+yXnS/tk7tqV5yKksv4HrDXx+cSAS1d?=
 =?iso-8859-1?Q?7810LhPWYdevSu+UZD0mgULUvtnQDPZxSFP4fVDWxBYjrha9Wt3UYCzXFu?=
 =?iso-8859-1?Q?oX5obwIXqvTAu9NATTrTZosfzfUUOVY5BloOQorpk0+C0HIvhjhjqvJF1g?=
 =?iso-8859-1?Q?4mBjJz+OS2uLVmJf0Magw9Dk+meKYZcC9ifA4VFtZnnjcEDNdxkXfDIGcK?=
 =?iso-8859-1?Q?GEoE4tS44p4xpuAtK+445Fizf1Ql3aQmBwwYsZ2peR3lk6BNMHCKFgn4BI?=
 =?iso-8859-1?Q?TfyvZOgjVAfq7Mlv/Jxc8s3YSgowvEojm3/wbjMP62CjxhSy+2eavYxi98?=
 =?iso-8859-1?Q?60sN1Vn7Rgq0wQS8DCStAdUwkoSMMsIZYFiOpQujD5GlaH6rEBi/na7GfI?=
 =?iso-8859-1?Q?FDA/xLNJF63A0Vgw/GShcJ1nbgfIaYIOidfdUKA9oJyHfUBLVtxIf4nzRG?=
 =?iso-8859-1?Q?/mmWslfBK7x3x+vxJtDgXl5b5LZV7hIRQSbtJ0uqddFuaERACexg55CUa7?=
 =?iso-8859-1?Q?CHWJwSaHV6aesYlD7soXHV51vxSL9mNYG3W2YxnNSu5aE1aSTF4STCEAap?=
 =?iso-8859-1?Q?2R+iEvzrZ+5mMLcMX3CuYvdOp5cVMahs6LsSqLe8FVcTvv6EeRQGRnw46h?=
 =?iso-8859-1?Q?r8M7NueWnz/otsGltNUiSupmFPKJj7adwxKREomQC8KeoBqBi+THbacHCO?=
 =?iso-8859-1?Q?oC3BzsWAG1WBp4p5a4kDQSCLwloEJtQFnxTWakk8agDMgFlNBpwinN+jcw?=
 =?iso-8859-1?Q?KnmmYTOh3/G9PoXIMmAk4fFvwoG4neIIRdNf9sG/YnuIBlUrzI1pxega+6?=
 =?iso-8859-1?Q?BRUGOyfum8myT+VVOdkiDj2dP3wUiaHdXpqN8uC2nGcxCjwCFjNlhzxPUS?=
 =?iso-8859-1?Q?IwuUus1MP/FBHzHg+uWhyJwSj68yE2RSQ5GHQjeE6U8Kqq/01twC28pKM7?=
 =?iso-8859-1?Q?Qnopzvj9eMBByxEhG+6zmDUyBoHMXJq6w3qjYhlZ3PsMU2HcISRU2oBQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5543f393-eab6-4204-d059-08db99ada0e9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:25:21.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUwwXrlwvKs/t1fxOHlFB4dcIfVxflve3oh7VIwyyx8zYHsVBqwM1W2s8hld0Y1d1Lo9VYHYH+979ZWk1h9XfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6822
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

kernel test robot noticed a -54.7% regression of stress-ng.symlink.ops_per_sec on:


commit: b3afbe4f56ec07dd9cbfd59734fe5bc084f4d307 ("[PATCH v2 4/4] blk-flush: don't need to end rq twice for non postflush")
url: https://github.com/intel-lab-lkp/linux/commits/chengming-zhou-linux-dev/blk-flush-flush_rq-should-inherit-first_rq-s-cmd_flags/20230725-212146
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/20230725130102.3030032-5-chengming.zhou@linux.dev/
patch subject: [PATCH v2 4/4] blk-flush: don't need to end rq twice for non postflush

testcase: stress-ng
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
parameters:

	nr_threads: 10%
	disk: 1SSD
	testtime: 60s
	fs: ext4
	class: filesystem
	test: symlink
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308102227.eb19f29a-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230810/202308102227.eb19f29a-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1SSD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/symlink/stress-ng/60s

commit: 
  9e046e4b9a ("blk-flush: kill the flush state machine")
  b3afbe4f56 ("blk-flush: don't need to end rq twice for non postflush")

9e046e4b9a326538 b3afbe4f56ec07dd9cbfd59734f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     81.33 ± 23%    +701.4%     651.83 ±  8%  perf-c2c.DRAM.local
    385.00 ± 24%     -60.2%     153.33 ± 18%  perf-c2c.HITM.local
     12838 ±  9%     -83.6%       2111 ± 19%  vmstat.io.bo
   4894104 ±  2%     -25.0%    3672720 ±  4%  vmstat.memory.buff
      0.03 ±  9%      +2.1        2.12 ±  5%  mpstat.cpu.all.iowait%
      0.05 ±  6%      -0.0        0.03 ±  7%  mpstat.cpu.all.soft%
      1.01 ±  2%      -0.4        0.65 ±  5%  mpstat.cpu.all.usr%
     91.34            -2.4%      89.12        iostat.cpu.idle
      0.04 ±  9%   +5309.5%       2.10 ±  5%  iostat.cpu.iowait
      7.60            +6.7%       8.11        iostat.cpu.system
      1.02 ±  2%     -34.2%       0.67 ±  5%  iostat.cpu.user
      2.70 ±  7%      +2.0        4.75 ±  4%  turbostat.C1E%
      0.22 ±  3%     -43.2%       0.12 ±  6%  turbostat.IPC
      1.24 ± 63%    -100.0%       0.00        turbostat.Pkg%pc2
     82.91            -4.1%      79.50        turbostat.PkgWatt
    395.50           -54.7%     179.17 ±  6%  stress-ng.symlink.ops
      6.58           -54.7%       2.98 ±  6%  stress-ng.symlink.ops_per_sec
     19194 ±  2%     -57.0%       8247 ±  8%  stress-ng.time.involuntary_context_switches
    280.33            +1.7%     285.00        stress-ng.time.percent_of_cpu_this_job_got
    157.58            +7.8%     169.80        stress-ng.time.system_time
     16.88           -54.6%       7.67 ±  6%  stress-ng.time.user_time
   4864550 ±  2%     -24.0%    3694800 ±  4%  meminfo.Active
   4805969 ±  2%     -24.3%    3637287 ±  4%  meminfo.Active(file)
   4807385 ±  2%     -24.3%    3638747 ±  4%  meminfo.Buffers
    137311 ±  8%     -93.5%       8969 ± 61%  meminfo.Dirty
    253893            -8.9%     231389        meminfo.KReclaimable
   8558145           -13.9%    7368683 ±  2%  meminfo.Memused
    253893            -8.9%     231389        meminfo.SReclaimable
   8560008           -13.9%    7372705 ±  2%  meminfo.max_used_kB
   1201519 ±  2%     -24.3%     909340 ±  4%  proc-vmstat.nr_active_file
    146816 ±  4%     -90.7%      13672 ± 38%  proc-vmstat.nr_dirtied
     34328 ±  8%     -93.5%       2241 ± 61%  proc-vmstat.nr_dirty
   1918325           -15.2%    1626003 ±  2%  proc-vmstat.nr_file_pages
   6000925            +5.0%    6298304        proc-vmstat.nr_free_pages
     10094            +1.8%      10278        proc-vmstat.nr_mapped
     63476            -8.9%      57854        proc-vmstat.nr_slab_reclaimable
     25073            -3.4%      24225        proc-vmstat.nr_slab_unreclaimable
    101605 ±  6%     -86.6%      13660 ± 38%  proc-vmstat.nr_written
   1201519 ±  2%     -24.3%     909340 ±  4%  proc-vmstat.nr_zone_active_file
     34329 ±  8%     -93.5%       2242 ± 61%  proc-vmstat.nr_zone_write_pending
   2922100           -39.4%    1771460 ±  4%  proc-vmstat.numa_hit
   2925326           -39.4%    1771382 ±  4%  proc-vmstat.numa_local
    182296           -37.3%     114290 ±  4%  proc-vmstat.pgactivate
   3716779           -41.6%    2171212 ±  5%  proc-vmstat.pgalloc_normal
   1205341 ±  4%     -41.5%     705041 ±  5%  proc-vmstat.pgfree
    852188 ± 10%     -83.7%     138853 ± 20%  proc-vmstat.pgpgout
      0.01 ± 26%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.01 ± 62%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 26%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.01 ± 29%     -69.0%       0.00 ±101%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.01 ± 21%     -40.0%       0.01 ± 23%  perf-sched.sch_delay.max.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      0.01 ± 62%    -100.0%       0.00        perf-sched.sch_delay.max.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 14%    +166.0%       0.09 ± 58%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    101.49 ±  7%     +59.7%     162.10 ± 17%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2048 ±  3%     -33.5%       1363 ± 19%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ±  6%     +40.8%       0.05 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_getblk.ext4_bread.ext4_init_symlink_block
      0.05 ± 11%     +24.3%       0.06 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.__getblk_gfp.ext4_getblk.ext4_bread.__ext4_read_dirblock
      0.03 ± 51%     -90.6%       0.00 ±150%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.__ext4_new_inode.ext4_symlink.vfs_symlink
      5.83 ± 73%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.03 ± 61%     -84.7%       0.01 ±183%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
      5.73 ±140%     -99.2%       0.05 ±223%  perf-sched.wait_time.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      0.70 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
    101.46 ±  7%     +59.7%     162.08 ± 17%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ± 41%     -93.0%       0.00 ±150%  perf-sched.wait_time.max.ms.__cond_resched.down_read.__ext4_new_inode.ext4_symlink.vfs_symlink
     16.16 ±215%     -97.7%       0.38 ± 22%  perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.user_statfs.__do_sys_statfs
      5.83 ± 73%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.07 ± 82%     -90.7%       0.01 ±171%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
     25.16 ±122%     -99.3%       0.16 ±223%  perf-sched.wait_time.max.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      0.70 ± 18%    -100.0%       0.00        perf-sched.wait_time.max.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      9.77 ± 18%     +57.5%      15.38        perf-stat.i.MPKI
 1.759e+09           -44.0%  9.852e+08 ±  4%  perf-stat.i.branch-instructions
  20930583           -32.7%   14087563 ±  4%  perf-stat.i.branch-misses
     10.78            +4.2       14.98 ±  4%  perf-stat.i.cache-miss-rate%
   8025531            -4.2%    7684648        perf-stat.i.cache-misses
  77754557 ±  2%     -25.5%   57916998 ±  3%  perf-stat.i.cache-references
      1.45 ±  8%    +173.5%       3.96 ±  5%  perf-stat.i.cpi
 1.221e+10            +1.7%  1.241e+10        perf-stat.i.cpu-cycles
      1592            +8.1%       1721        perf-stat.i.cycles-between-cache-misses
    661039           -47.4%     347558 ±  5%  perf-stat.i.dTLB-load-misses
  2.38e+09           -45.8%  1.289e+09 ±  4%  perf-stat.i.dTLB-loads
     10275 ±  9%     -13.3%       8913 ±  2%  perf-stat.i.dTLB-store-misses
  1.15e+09           -48.8%  5.892e+08 ±  5%  perf-stat.i.dTLB-stores
     45.27 ±  3%     -14.9       30.42 ±  5%  perf-stat.i.iTLB-load-miss-rate%
    796188 ±  8%     -47.8%     415706 ±  8%  perf-stat.i.iTLB-load-misses
    929612 ±  3%     -10.6%     830862        perf-stat.i.iTLB-loads
 9.024e+09           -45.7%  4.902e+09 ±  5%  perf-stat.i.instructions
      0.75           -45.0%       0.41 ±  4%  perf-stat.i.ipc
      0.34            +1.7%       0.34        perf-stat.i.metric.GHz
    191.07 ±  8%     +60.2%     306.12 ± 11%  perf-stat.i.metric.K/sec
    149.18           -45.7%      81.00 ±  5%  perf-stat.i.metric.M/sec
   1273025 ±  2%    +178.5%    3545558 ±  5%  perf-stat.i.node-loads
   3427034 ±  2%     -43.4%    1939169 ±  5%  perf-stat.i.node-stores
      8.60           +37.5%      11.82        perf-stat.overall.MPKI
      1.19            +0.2        1.43 ±  4%  perf-stat.overall.branch-miss-rate%
     10.33            +3.0       13.29 ±  4%  perf-stat.overall.cache-miss-rate%
      1.35           +87.9%       2.54 ±  4%  perf-stat.overall.cpi
      1520            +6.2%       1614        perf-stat.overall.cycles-between-cache-misses
      0.03            -0.0        0.03        perf-stat.overall.dTLB-load-miss-rate%
      0.00 ± 11%      +0.0        0.00 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
     46.13 ±  3%     -12.8       33.30 ±  5%  perf-stat.overall.iTLB-load-miss-rate%
      0.74           -46.7%       0.40 ±  5%  perf-stat.overall.ipc
 1.734e+09           -44.1%  9.699e+08 ±  4%  perf-stat.ps.branch-instructions
  20610819           -32.7%   13862952 ±  4%  perf-stat.ps.branch-misses
   7900440            -4.3%    7563578        perf-stat.ps.cache-misses
  76460521 ±  2%     -25.4%   57007500 ±  3%  perf-stat.ps.cache-references
 1.201e+10            +1.7%  1.221e+10        perf-stat.ps.cpu-cycles
    652055           -47.5%     342193 ±  5%  perf-stat.ps.dTLB-load-misses
 2.347e+09           -45.9%  1.269e+09 ±  4%  perf-stat.ps.dTLB-loads
     10120 ±  9%     -13.3%       8770 ±  2%  perf-stat.ps.dTLB-store-misses
 1.134e+09           -48.8%  5.801e+08 ±  5%  perf-stat.ps.dTLB-stores
    785838 ±  8%     -47.9%     409304 ±  8%  perf-stat.ps.iTLB-load-misses
    915395 ±  3%     -10.7%     817774        perf-stat.ps.iTLB-loads
 8.896e+09           -45.8%  4.826e+09 ±  5%  perf-stat.ps.instructions
   1253851 ±  2%    +178.3%    3488888 ±  5%  perf-stat.ps.node-loads
   3362358 ±  2%     -43.2%    1909414 ±  5%  perf-stat.ps.node-stores
 5.702e+11           -46.4%  3.056e+11 ±  4%  perf-stat.total.instructions
     18.41 ±  6%     -11.3        7.13 ± 37%  perf-profile.calltrace.cycles-pp.unlink
     18.05 ±  6%     -11.0        7.05 ± 38%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
     17.92 ±  6%     -10.9        7.02 ± 38%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     17.61 ±  6%     -10.7        6.94 ± 38%  perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     17.45 ±  6%     -10.5        6.90 ± 39%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
     12.32 ±  8%      -6.7        5.61 ± 48%  perf-profile.calltrace.cycles-pp.evict.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.70 ±  5%      -6.6        2.05 ± 14%  perf-profile.calltrace.cycles-pp.__statfs
     12.06 ±  8%      -6.5        5.56 ± 49%  perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.do_unlinkat.__x64_sys_unlink.do_syscall_64
      7.28 ±  5%      -5.5        1.74 ± 14%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__statfs
      6.78 ±  5%      -5.2        1.62 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
      6.90 ±  5%      -5.1        1.79 ± 14%  perf-profile.calltrace.cycles-pp.ext4_map_blocks.ext4_getblk.ext4_bread.ext4_init_symlink_block.ext4_symlink
      6.55 ±  5%      -4.8        1.72 ± 14%  perf-profile.calltrace.cycles-pp.ext4_ext_map_blocks.ext4_map_blocks.ext4_getblk.ext4_bread.ext4_init_symlink_block
      5.91 ±  5%      -4.5        1.40 ± 14%  perf-profile.calltrace.cycles-pp.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
      5.69 ±  5%      -4.3        1.35 ± 14%  perf-profile.calltrace.cycles-pp.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
      5.46 ±  5%      -4.0        1.44 ± 14%  perf-profile.calltrace.cycles-pp.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_blocks.ext4_getblk.ext4_bread
      4.23 ±  5%      -3.2        1.06 ± 10%  perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.96 ±  6%      -3.0        0.94 ± 12%  perf-profile.calltrace.cycles-pp.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.16 ±  5%      -3.0        1.14 ±  5%  perf-profile.calltrace.cycles-pp.ext4_add_nondir.ext4_symlink.vfs_symlink.do_symlinkat.__x64_sys_symlink
      3.98 ±  5%      -3.0        1.00 ± 11%  perf-profile.calltrace.cycles-pp.ext4_unlink.vfs_unlink.do_unlinkat.__x64_sys_unlink.do_syscall_64
      3.95 ±  5%      -3.0        0.99 ± 11%  perf-profile.calltrace.cycles-pp.__ext4_unlink.ext4_unlink.vfs_unlink.do_unlinkat.__x64_sys_unlink
      3.87 ±  6%      -3.0        0.92 ± 13%  perf-profile.calltrace.cycles-pp.ext4_statfs.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64
      3.50 ±  6%      -2.7        0.83 ± 12%  perf-profile.calltrace.cycles-pp.__percpu_counter_sum.ext4_statfs.statfs_by_dentry.user_statfs.__do_sys_statfs
      3.57 ±  5%      -2.6        0.99 ±  5%  perf-profile.calltrace.cycles-pp.ext4_add_entry.ext4_add_nondir.ext4_symlink.vfs_symlink.do_symlinkat
      3.45 ±  5%      -2.5        0.96 ±  5%  perf-profile.calltrace.cycles-pp.ext4_dx_add_entry.ext4_add_entry.ext4_add_nondir.ext4_symlink.vfs_symlink
      3.36 ±  5%      -2.4        0.97 ± 14%  perf-profile.calltrace.cycles-pp.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_blocks.ext4_getblk
      3.13 ±  5%      -2.3        0.78 ± 11%  perf-profile.calltrace.cycles-pp.__ext4_new_inode.ext4_symlink.vfs_symlink.do_symlinkat.__x64_sys_symlink
      2.53 ±  6%      -1.9        0.65 ± 10%  perf-profile.calltrace.cycles-pp.ext4_mb_clear_bb.ext4_remove_blocks.ext4_ext_rm_leaf.ext4_ext_remove_space.ext4_ext_truncate
      2.48 ±  4%      -1.8        0.65 ±  5%  perf-profile.calltrace.cycles-pp.add_dirent_to_buf.ext4_dx_add_entry.ext4_add_entry.ext4_add_nondir.ext4_symlink
      1.92 ±  5%      -1.6        0.35 ± 70%  perf-profile.calltrace.cycles-pp.ext4_mb_complex_scan_group.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_blocks
     36.63 ±  5%     +23.9       60.51 ±  5%  perf-profile.calltrace.cycles-pp.symlink
     36.25 ±  5%     +24.2       60.42 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.symlink
     36.12 ±  5%     +24.3       60.40 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.symlink
     35.81 ±  5%     +24.5       60.32 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_symlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.symlink
     35.53 ±  5%     +24.7       60.24 ±  5%  perf-profile.calltrace.cycles-pp.do_symlinkat.__x64_sys_symlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.symlink
     34.80 ±  5%     +25.3       60.07 ±  5%  perf-profile.calltrace.cycles-pp.vfs_symlink.do_symlinkat.__x64_sys_symlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
     34.73 ±  5%     +25.3       60.06 ±  5%  perf-profile.calltrace.cycles-pp.ext4_symlink.vfs_symlink.do_symlinkat.__x64_sys_symlink.do_syscall_64
      4.32 ± 22%     +28.7       32.98 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.find_revoke_record.jbd2_journal_cancel_revoke.jbd2_journal_get_create_access.__ext4_journal_get_create_access
      4.29 ± 22%     +28.7       32.97 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.find_revoke_record.jbd2_journal_cancel_revoke.jbd2_journal_get_create_access
     27.14 ±  6%     +30.9       58.06 ±  5%  perf-profile.calltrace.cycles-pp.ext4_init_symlink_block.ext4_symlink.vfs_symlink.do_symlinkat.__x64_sys_symlink
     27.08 ±  6%     +31.0       58.05 ±  5%  perf-profile.calltrace.cycles-pp.ext4_bread.ext4_init_symlink_block.ext4_symlink.vfs_symlink.do_symlinkat
     27.08 ±  6%     +31.0       58.04 ±  5%  perf-profile.calltrace.cycles-pp.ext4_getblk.ext4_bread.ext4_init_symlink_block.ext4_symlink.vfs_symlink
     18.24 ±  8%     +37.4       55.63 ±  5%  perf-profile.calltrace.cycles-pp.__ext4_journal_get_create_access.ext4_getblk.ext4_bread.ext4_init_symlink_block.ext4_symlink
     18.24 ±  8%     +37.4       55.63 ±  5%  perf-profile.calltrace.cycles-pp.jbd2_journal_get_create_access.__ext4_journal_get_create_access.ext4_getblk.ext4_bread.ext4_init_symlink_block
     17.96 ±  8%     +37.6       55.56 ±  5%  perf-profile.calltrace.cycles-pp.jbd2_journal_cancel_revoke.jbd2_journal_get_create_access.__ext4_journal_get_create_access.ext4_getblk.ext4_bread
     17.84 ±  8%     +37.7       55.53 ±  5%  perf-profile.calltrace.cycles-pp.find_revoke_record.jbd2_journal_cancel_revoke.jbd2_journal_get_create_access.__ext4_journal_get_create_access.ext4_getblk
     18.44 ±  6%     -11.3        7.14 ± 37%  perf-profile.children.cycles-pp.unlink
     17.61 ±  6%     -10.7        6.94 ± 38%  perf-profile.children.cycles-pp.__x64_sys_unlink
     17.46 ±  6%     -10.6        6.90 ± 39%  perf-profile.children.cycles-pp.do_unlinkat
     12.32 ±  8%      -6.7        5.61 ± 48%  perf-profile.children.cycles-pp.evict
      8.76 ±  5%      -6.7        2.06 ± 14%  perf-profile.children.cycles-pp.__statfs
     12.07 ±  8%      -6.5        5.56 ± 49%  perf-profile.children.cycles-pp.ext4_evict_inode
      7.58 ±  5%      -5.6        1.97 ± 13%  perf-profile.children.cycles-pp.ext4_map_blocks
      7.08 ±  4%      -5.3        1.77 ±  9%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      6.56 ±  5%      -4.8        1.72 ± 14%  perf-profile.children.cycles-pp.ext4_ext_map_blocks
      5.91 ±  5%      -4.5        1.40 ± 14%  perf-profile.children.cycles-pp.__do_sys_statfs
      5.92 ±  4%      -4.4        1.49 ±  9%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      5.69 ±  5%      -4.3        1.35 ± 14%  perf-profile.children.cycles-pp.user_statfs
      5.43 ±  3%      -4.1        1.35 ± 10%  perf-profile.children.cycles-pp.ext4_do_update_inode
      5.46 ±  5%      -4.0        1.45 ± 14%  perf-profile.children.cycles-pp.ext4_mb_new_blocks
      4.23 ±  5%      -3.2        1.06 ± 10%  perf-profile.children.cycles-pp.vfs_unlink
      4.10 ±  5%      -3.0        1.06 ± 12%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      3.96 ±  6%      -3.0        0.94 ± 12%  perf-profile.children.cycles-pp.statfs_by_dentry
      4.16 ±  5%      -3.0        1.14 ±  5%  perf-profile.children.cycles-pp.ext4_add_nondir
      3.98 ±  5%      -3.0        1.00 ± 11%  perf-profile.children.cycles-pp.ext4_unlink
      3.96 ±  5%      -3.0        0.99 ± 11%  perf-profile.children.cycles-pp.__ext4_unlink
      3.88 ±  6%      -3.0        0.92 ± 13%  perf-profile.children.cycles-pp.ext4_statfs
      3.96 ±  3%      -3.0        1.00 ± 11%  perf-profile.children.cycles-pp.ext4_fill_raw_inode
      3.64 ±  6%      -2.8        0.86 ± 13%  perf-profile.children.cycles-pp.__percpu_counter_sum
      3.57 ±  5%      -2.6        0.99 ±  5%  perf-profile.children.cycles-pp.ext4_add_entry
      3.45 ±  5%      -2.5        0.96 ±  5%  perf-profile.children.cycles-pp.ext4_dx_add_entry
      3.36 ±  5%      -2.4        0.97 ± 14%  perf-profile.children.cycles-pp.ext4_mb_regular_allocator
      3.14 ±  5%      -2.4        0.78 ± 11%  perf-profile.children.cycles-pp.__ext4_new_inode
      2.85 ±  3%      -2.1        0.70 ± 13%  perf-profile.children.cycles-pp.ext4_inode_csum_set
      2.75 ±  4%      -2.1        0.64 ±  8%  perf-profile.children.cycles-pp.__find_get_block
      2.68 ±  3%      -2.0        0.66 ± 13%  perf-profile.children.cycles-pp.ext4_inode_csum
      2.64 ±  7%      -1.9        0.72 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.54 ±  7%      -1.9        0.65 ± 10%  perf-profile.children.cycles-pp.ext4_mb_clear_bb
      2.54 ±  5%      -1.9        0.66 ± 12%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      2.48 ±  4%      -1.8        0.65 ±  5%  perf-profile.children.cycles-pp.add_dirent_to_buf
      2.42 ±  5%      -1.8        0.61 ± 14%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      2.29 ±  6%      -1.7        0.56 ± 16%  perf-profile.children.cycles-pp.user_path_at_empty
      2.32 ±  4%      -1.7        0.63 ±  7%  perf-profile.children.cycles-pp.__filemap_get_folio
      1.92 ±  5%      -1.4        0.49 ± 12%  perf-profile.children.cycles-pp.ext4_mb_complex_scan_group
      1.82 ±  4%      -1.3        0.47 ± 10%  perf-profile.children.cycles-pp.open64
      1.71 ±  6%      -1.3        0.44 ± 10%  perf-profile.children.cycles-pp.do_readlinkat
      1.63 ±  8%      -1.2        0.40 ± 15%  perf-profile.children.cycles-pp.filename_lookup
      1.66 ±  7%      -1.2        0.44 ± 11%  perf-profile.children.cycles-pp.readlinkat
      1.66 ±  7%      -1.2        0.44 ±  9%  perf-profile.children.cycles-pp.crc_pcl
      1.60 ±  3%      -1.2        0.38 ±  3%  perf-profile.children.cycles-pp.filemap_get_entry
      1.57 ±  6%      -1.2        0.36 ± 11%  perf-profile.children.cycles-pp.syscall
      1.58 ±  3%      -1.2        0.40 ±  7%  perf-profile.children.cycles-pp.ext4_find_dest_de
      1.63 ±  6%      -1.2        0.46 ±  9%  perf-profile.children.cycles-pp.__getblk_gfp
      1.29 ± 15%      -1.1        0.14 ± 22%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.29 ± 15%      -1.1        0.14 ± 22%  perf-profile.children.cycles-pp.ret_from_fork
      1.29 ± 15%      -1.1        0.14 ± 22%  perf-profile.children.cycles-pp.kthread
      1.48 ±  8%      -1.1        0.36 ± 16%  perf-profile.children.cycles-pp.path_lookupat
      1.49 ±  5%      -1.1        0.38 ± 14%  perf-profile.children.cycles-pp.getname_flags
      1.41 ±  5%      -1.0        0.36 ± 13%  perf-profile.children.cycles-pp.__lxstat64
      1.42 ±  4%      -1.0        0.37 ± 15%  perf-profile.children.cycles-pp.ext4_get_inode_loc
      1.37 ±  4%      -1.0        0.36 ± 15%  perf-profile.children.cycles-pp.__ext4_get_inode_loc
      1.27 ±  8%      -1.0        0.30 ± 20%  perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      1.29 ±  7%      -1.0        0.32 ± 13%  perf-profile.children.cycles-pp.__mark_inode_dirty
      1.26 ±  5%      -0.9        0.31 ± 15%  perf-profile.children.cycles-pp.__entry_text_start
      1.28 ±  7%      -0.9        0.38 ± 12%  perf-profile.children.cycles-pp.__ext4_read_dirblock
      1.24 ±  4%      -0.9        0.35 ± 10%  perf-profile.children.cycles-pp._find_next_bit
      1.16 ±  9%      -0.9        0.30 ± 10%  perf-profile.children.cycles-pp.ext4_orphan_del
      1.12 ±  6%      -0.9        0.27 ± 10%  perf-profile.children.cycles-pp.__close
      1.09 ±  2%      -0.8        0.30 ±  9%  perf-profile.children.cycles-pp.__x64_sys_openat
      1.05 ±  9%      -0.8        0.26 ± 14%  perf-profile.children.cycles-pp.ext4_orphan_add
      1.02 ±  7%      -0.8        0.24 ± 13%  perf-profile.children.cycles-pp.ext4_mb_mark_diskspace_used
      1.07            -0.8        0.29 ±  8%  perf-profile.children.cycles-pp.do_sys_openat2
      1.03 ±  8%      -0.8        0.26 ± 13%  perf-profile.children.cycles-pp.ext4_dirty_inode
      0.99 ±  5%      -0.7        0.26 ± 10%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.96 ±  6%      -0.7        0.24 ± 16%  perf-profile.children.cycles-pp.strncpy_from_user
      1.09 ±  6%      -0.7        0.37 ± 11%  perf-profile.children.cycles-pp.__getblk_slow
      0.92 ±  9%      -0.7        0.22 ± 17%  perf-profile.children.cycles-pp.__ext4_find_entry
      0.88 ±  7%      -0.7        0.21 ± 16%  perf-profile.children.cycles-pp.ext4_dx_find_entry
      0.89 ± 10%      -0.7        0.22 ± 15%  perf-profile.children.cycles-pp._find_next_or_bit
      0.91 ±  5%      -0.6        0.26 ±  9%  perf-profile.children.cycles-pp.__x64_sys_readlinkat
      0.84 ±  7%      -0.6        0.19 ± 12%  perf-profile.children.cycles-pp.__x64_sys_readlink
      0.86 ±  7%      -0.6        0.22 ±  9%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      0.89 ±  8%      -0.6        0.26 ± 18%  perf-profile.children.cycles-pp.ext4_block_bitmap_csum_set
      0.84 ±  6%      -0.6        0.22 ± 15%  perf-profile.children.cycles-pp.link_path_walk
      0.80 ±  4%      -0.6        0.20 ±  6%  perf-profile.children.cycles-pp.xas_load
      0.81 ±  2%      -0.6        0.21 ± 12%  perf-profile.children.cycles-pp.do_filp_open
      0.77 ±  3%      -0.6        0.20 ± 12%  perf-profile.children.cycles-pp.path_openat
      0.74 ±  7%      -0.6        0.18 ± 11%  perf-profile.children.cycles-pp.ext4_free_inode
      0.70 ±  9%      -0.6        0.14 ± 21%  perf-profile.children.cycles-pp.jbd2__journal_start
      0.77 ±  7%      -0.6        0.21 ±  8%  perf-profile.children.cycles-pp.dx_probe
      0.69 ±  7%      -0.5        0.15 ± 18%  perf-profile.children.cycles-pp.complete_walk
      0.71 ±  4%      -0.5        0.18 ± 13%  perf-profile.children.cycles-pp.__check_object_size
      0.69 ±  8%      -0.5        0.18 ± 15%  perf-profile.children.cycles-pp.__do_sys_newlstat
      0.64 ±  8%      -0.5        0.14 ± 18%  perf-profile.children.cycles-pp.try_to_unlazy
      0.64 ±  5%      -0.5        0.15 ± 10%  perf-profile.children.cycles-pp.vfs_readlink
      0.77 ± 12%      -0.5        0.31 ± 13%  perf-profile.children.cycles-pp.__do_softirq
      0.66 ±  7%      -0.5        0.19 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.64 ±  3%      -0.5        0.18 ± 19%  perf-profile.children.cycles-pp.ext4_handle_dirty_dirblock
      0.59 ±  8%      -0.5        0.13 ± 13%  perf-profile.children.cycles-pp.filename_create
      0.63 ±  8%      -0.5        0.18 ± 12%  perf-profile.children.cycles-pp.new_inode
      0.57 ±  9%      -0.4        0.13 ± 18%  perf-profile.children.cycles-pp.__legitimize_path
      0.60 ±  9%      -0.4        0.16 ± 12%  perf-profile.children.cycles-pp.vfs_fstatat
      0.55 ±  7%      -0.4        0.13 ± 15%  perf-profile.children.cycles-pp.__cond_resched
      0.58 ± 14%      -0.4        0.16 ± 18%  perf-profile.children.cycles-pp.rcu_core
      0.54 ± 10%      -0.4        0.13 ± 12%  perf-profile.children.cycles-pp.ext4_es_remove_extent
      0.51 ±  8%      -0.4        0.10 ± 21%  perf-profile.children.cycles-pp.start_this_handle
      0.55 ±  8%      -0.4        0.14 ± 12%  perf-profile.children.cycles-pp.ext4_mb_load_buddy_gfp
      0.52 ±  6%      -0.4        0.13 ± 23%  perf-profile.children.cycles-pp.lookup_one_qstr_excl
      0.48 ±  3%      -0.4        0.09 ± 22%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.53 ±  9%      -0.4        0.14 ± 14%  perf-profile.children.cycles-pp.__ext4_journal_stop
      0.55 ±  8%      -0.4        0.16 ± 13%  perf-profile.children.cycles-pp.alloc_inode
      0.52 ±  7%      -0.4        0.13 ± 23%  perf-profile.children.cycles-pp.lookup_dcache
      0.51 ±  9%      -0.4        0.12 ± 10%  perf-profile.children.cycles-pp.__es_remove_extent
      0.51 ±  8%      -0.4        0.12 ± 14%  perf-profile.children.cycles-pp.__filename_parentat
      0.54 ± 15%      -0.4        0.15 ± 17%  perf-profile.children.cycles-pp.rcu_do_batch
      0.51 ±  6%      -0.4        0.13 ± 23%  perf-profile.children.cycles-pp.d_lookup
      0.51 ±  6%      -0.4        0.13 ± 23%  perf-profile.children.cycles-pp.__d_lookup
      0.50 ± 10%      -0.4        0.12 ± 17%  perf-profile.children.cycles-pp.ext4_ext_insert_extent
      0.46 ±  3%      -0.4        0.10 ± 11%  perf-profile.children.cycles-pp.__ext4_check_dir_entry
      0.47 ±  8%      -0.4        0.11 ± 16%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.49 ± 10%      -0.4        0.14 ± 17%  perf-profile.children.cycles-pp.ext4_alloc_inode
      0.48 ±  9%      -0.4        0.13 ± 14%  perf-profile.children.cycles-pp.jbd2_journal_stop
      0.48 ± 10%      -0.3        0.13 ±  8%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.44 ±  9%      -0.3        0.10 ± 17%  perf-profile.children.cycles-pp.path_parentat
      0.45 ±  6%      -0.3        0.11 ± 18%  perf-profile.children.cycles-pp.kmem_cache_free
      0.42 ±  8%      -0.3        0.08 ± 22%  perf-profile.children.cycles-pp.jbd2_journal_revoke
      0.47 ±  4%      -0.3        0.14 ± 25%  perf-profile.children.cycles-pp.jbd2_journal_get_write_access
      0.46 ±  9%      -0.3        0.13 ± 12%  perf-profile.children.cycles-pp.pagecache_get_page
      0.44 ±  6%      -0.3        0.12 ± 14%  perf-profile.children.cycles-pp.ext4_delete_entry
      0.42 ± 13%      -0.3        0.09 ± 11%  perf-profile.children.cycles-pp._raw_read_lock
      0.44 ± 10%      -0.3        0.12 ± 14%  perf-profile.children.cycles-pp.vfs_statx
      0.42 ±  8%      -0.3        0.11 ± 16%  perf-profile.children.cycles-pp.jbd2_journal_dirty_metadata
      0.43 ± 11%      -0.3        0.12 ± 11%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.41 ±  4%      -0.3        0.10 ± 18%  perf-profile.children.cycles-pp.check_heap_object
      0.41 ± 10%      -0.3        0.10 ± 13%  perf-profile.children.cycles-pp.xas_descend
      0.39 ± 10%      -0.3        0.09 ± 12%  perf-profile.children.cycles-pp.__brelse
      0.37 ±  8%      -0.3        0.08 ± 19%  perf-profile.children.cycles-pp.ext4_es_insert_extent
      0.40 ± 11%      -0.3        0.12 ± 23%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.39 ±  8%      -0.3        0.10 ± 16%  perf-profile.children.cycles-pp.fscrypt_match_name
      0.36 ±  7%      -0.3        0.08 ± 22%  perf-profile.children.cycles-pp.dput
      0.38 ± 12%      -0.3        0.11 ± 22%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.36 ±  7%      -0.3        0.09 ± 23%  perf-profile.children.cycles-pp.ext4_group_desc_csum_set
      0.36 ±  8%      -0.3        0.09 ± 21%  perf-profile.children.cycles-pp.mb_find_extent
      0.36 ± 16%      -0.3        0.09 ± 24%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.35 ±  9%      -0.3        0.08 ± 16%  perf-profile.children.cycles-pp.ext4_get_link
      0.34 ±  7%      -0.3        0.08 ± 23%  perf-profile.children.cycles-pp.ext4_group_desc_csum
      0.30 ±  8%      -0.3        0.05 ± 48%  perf-profile.children.cycles-pp.ext4_get_group_desc
      0.34 ± 12%      -0.2        0.10 ± 21%  perf-profile.children.cycles-pp.inode_permission
      0.36 ±  6%      -0.2        0.11 ± 26%  perf-profile.children.cycles-pp.jbd2_write_access_granted
      0.30 ±  6%      -0.2        0.06 ± 51%  perf-profile.children.cycles-pp.jbd2_journal_forget
      0.32 ±  7%      -0.2        0.08 ± 20%  perf-profile.children.cycles-pp.__slab_free
      0.31 ±  6%      -0.2        0.08 ± 20%  perf-profile.children.cycles-pp._IO_default_xsputn
      0.31 ± 10%      -0.2        0.08 ± 19%  perf-profile.children.cycles-pp.alloc_empty_file
      0.29 ± 11%      -0.2        0.06 ± 15%  perf-profile.children.cycles-pp.__es_insert_extent
      0.31 ±  8%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.mb_find_order_for_block
      0.32 ±  2%      -0.2        0.09 ± 10%  perf-profile.children.cycles-pp.memset_orig
      0.31 ± 13%      -0.2        0.09 ± 32%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.34 ± 11%      -0.2        0.13 ± 11%  perf-profile.children.cycles-pp.filemap_add_folio
      0.27 ±  5%      -0.2        0.06 ± 11%  perf-profile.children.cycles-pp.crypto_shash_update
      0.25 ± 13%      -0.2        0.04 ± 71%  perf-profile.children.cycles-pp.path_init
      0.29 ±  9%      -0.2        0.08 ± 11%  perf-profile.children.cycles-pp.___slab_alloc
      0.24 ±  8%      -0.2        0.03 ±101%  perf-profile.children.cycles-pp.path_put
      0.26 ± 11%      -0.2        0.06 ± 17%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.44 ± 13%      -0.2        0.25 ± 12%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.25 ± 10%      -0.2        0.06 ± 47%  perf-profile.children.cycles-pp.ext4_read_block_bitmap
      0.28 ± 11%      -0.2        0.08 ± 22%  perf-profile.children.cycles-pp.ext4_mb_free_metadata
      0.23 ± 18%      -0.2        0.04 ± 72%  perf-profile.children.cycles-pp.ext4_inode_bitmap_csum_set
      0.29 ± 13%      -0.2        0.10 ± 40%  perf-profile.children.cycles-pp.ext4_mb_prefetch
      0.22 ±  6%      -0.2        0.03 ±105%  perf-profile.children.cycles-pp.lockref_put_return
      0.22 ± 12%      -0.2        0.04 ± 72%  perf-profile.children.cycles-pp.task_work_run
      0.24 ± 10%      -0.2        0.06 ± 47%  perf-profile.children.cycles-pp.ext4_read_block_bitmap_nowait
      0.21 ±  9%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.ext4_es_free_extent
      0.22 ± 10%      -0.2        0.04 ± 72%  perf-profile.children.cycles-pp.__check_block_validity
      0.22 ± 13%      -0.2        0.04 ± 77%  perf-profile.children.cycles-pp.generic_permission
      0.24 ±  8%      -0.2        0.07 ± 20%  perf-profile.children.cycles-pp.ext4_sb_block_valid
      0.24 ±  4%      -0.2        0.07 ± 17%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.24 ± 14%      -0.2        0.07 ± 14%  perf-profile.children.cycles-pp.allocate_slab
      0.20 ±  9%      -0.2        0.02 ± 99%  perf-profile.children.cycles-pp.__check_heap_object
      0.20 ± 14%      -0.2        0.03 ±102%  perf-profile.children.cycles-pp.walk_component
      0.25 ± 10%      -0.2        0.08 ± 22%  perf-profile.children.cycles-pp.ext4_get_group_info
      0.23 ± 11%      -0.2        0.06 ± 14%  perf-profile.children.cycles-pp.do_open
      0.22 ±  9%      -0.2        0.06 ± 13%  perf-profile.children.cycles-pp.ext4_mb_use_best_found
      0.22 ±  9%      -0.2        0.06 ± 46%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.22 ± 11%      -0.2        0.06 ± 15%  perf-profile.children.cycles-pp.readlink_copy
      0.21 ± 10%      -0.2        0.04 ± 45%  perf-profile.children.cycles-pp.__ext4fs_dirhash
      0.25 ± 11%      -0.2        0.10 ± 11%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.20 ±  9%      -0.2        0.04 ± 45%  perf-profile.children.cycles-pp.ext4_mb_prefetch_fini
      0.20 ± 18%      -0.2        0.05 ± 46%  perf-profile.children.cycles-pp.shuffle_freelist
      0.22 ± 11%      -0.2        0.07 ± 21%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.19 ± 16%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.20 ± 12%      -0.1        0.06 ± 19%  perf-profile.children.cycles-pp._copy_to_user
      0.19 ±  3%      -0.1        0.05 ± 46%  perf-profile.children.cycles-pp.__jbd2_journal_file_buffer
      0.18 ± 18%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.setup_object
      0.17 ± 15%      -0.1        0.05 ± 46%  perf-profile.children.cycles-pp.ext4_fc_init_inode
      0.16 ± 10%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.16 ± 13%      -0.1        0.05 ± 75%  perf-profile.children.cycles-pp.folio_alloc
      0.17 ± 13%      -0.1        0.06 ± 53%  perf-profile.children.cycles-pp.__alloc_pages
      0.13 ± 19%      -0.1        0.03 ±103%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.27 ± 12%      -0.1        0.18 ± 17%  perf-profile.children.cycles-pp.ext4_mb_find_good_group_avg_frag_lists
      0.12 ±  8%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.touch_atime
      0.11 ± 14%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp._raw_spin_lock_irq
     36.65 ±  5%     +23.9       60.52 ±  5%  perf-profile.children.cycles-pp.symlink
     35.81 ±  5%     +24.5       60.32 ±  5%  perf-profile.children.cycles-pp.__x64_sys_symlink
     35.54 ±  5%     +24.7       60.24 ±  5%  perf-profile.children.cycles-pp.do_symlinkat
     34.80 ±  5%     +25.3       60.07 ±  5%  perf-profile.children.cycles-pp.vfs_symlink
     34.73 ±  5%     +25.3       60.06 ±  5%  perf-profile.children.cycles-pp.ext4_symlink
      8.16 ±  6%     +28.3       36.49 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
      6.76 ±  6%     +29.4       36.14 ±  4%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     28.56 ±  6%     +29.9       58.46 ±  5%  perf-profile.children.cycles-pp.ext4_bread
     28.54 ±  6%     +29.9       58.46 ±  5%  perf-profile.children.cycles-pp.ext4_getblk
     27.14 ±  6%     +30.9       58.06 ±  5%  perf-profile.children.cycles-pp.ext4_init_symlink_block
     18.24 ±  8%     +37.4       55.63 ±  5%  perf-profile.children.cycles-pp.__ext4_journal_get_create_access
     18.24 ±  8%     +37.4       55.63 ±  5%  perf-profile.children.cycles-pp.jbd2_journal_get_create_access
     17.96 ±  8%     +37.6       55.56 ±  5%  perf-profile.children.cycles-pp.jbd2_journal_cancel_revoke
     17.85 ±  8%     +37.7       55.53 ±  5%  perf-profile.children.cycles-pp.find_revoke_record
      2.53 ±  5%      -1.9        0.66 ± 12%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      2.23 ±  5%      -1.7        0.54 ± 15%  perf-profile.self.cycles-pp.__percpu_counter_sum
      2.19 ±  4%      -1.6        0.56 ± 13%  perf-profile.self.cycles-pp.crc32c_pcl_intel_update
      2.15 ±  7%      -1.5        0.60 ±  8%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.64 ±  7%      -1.2        0.44 ±  9%  perf-profile.self.cycles-pp.crc_pcl
      1.47 ±  4%      -1.1        0.40 ± 15%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.41 ±  8%      -1.0        0.36 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock
      1.28 ±  6%      -1.0        0.30 ± 15%  perf-profile.self.cycles-pp.__find_get_block
      1.24 ±  4%      -0.9        0.35 ± 11%  perf-profile.self.cycles-pp._find_next_bit
      1.10 ±  5%      -0.8        0.27 ± 16%  perf-profile.self.cycles-pp.__entry_text_start
      0.96 ±  5%      -0.7        0.26 ± 13%  perf-profile.self.cycles-pp.ext4_fill_raw_inode
      0.82 ±  6%      -0.6        0.19 ± 11%  perf-profile.self.cycles-pp.filemap_get_entry
      0.76 ±  9%      -0.6        0.18 ± 17%  perf-profile.self.cycles-pp._find_next_or_bit
      0.76 ±  4%      -0.6        0.20 ± 11%  perf-profile.self.cycles-pp.ext4_find_dest_de
      0.66 ±  6%      -0.5        0.17 ± 16%  perf-profile.self.cycles-pp.__ext4_get_inode_loc
      0.60 ±  5%      -0.5        0.14 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.62 ±  8%      -0.4        0.18 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.53 ±  8%      -0.4        0.12 ± 17%  perf-profile.self.cycles-pp.ext4_inode_csum
      0.46 ±  3%      -0.4        0.08 ± 21%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.46 ±  3%      -0.4        0.10 ± 11%  perf-profile.self.cycles-pp.__ext4_check_dir_entry
      0.47 ± 13%      -0.4        0.10 ± 18%  perf-profile.self.cycles-pp.__ext4_journal_get_write_access
      0.47 ±  8%      -0.4        0.12 ± 22%  perf-profile.self.cycles-pp.ext4_do_update_inode
      0.41 ± 12%      -0.3        0.09 ± 10%  perf-profile.self.cycles-pp._raw_read_lock
      0.38 ±  9%      -0.3        0.08 ± 14%  perf-profile.self.cycles-pp.__brelse
      0.39 ±  9%      -0.3        0.10 ± 27%  perf-profile.self.cycles-pp.__d_lookup
      0.38 ± 11%      -0.3        0.10 ± 12%  perf-profile.self.cycles-pp.xas_descend
      0.37 ± 10%      -0.3        0.09 ± 14%  perf-profile.self.cycles-pp.link_path_walk
      0.37 ±  4%      -0.3        0.10 ± 18%  perf-profile.self.cycles-pp.kmem_cache_free
      0.36 ± 11%      -0.3        0.08 ± 18%  perf-profile.self.cycles-pp.__cond_resched
      0.37 ±  9%      -0.3        0.11 ±  9%  perf-profile.self.cycles-pp.ext4_mark_iloc_dirty
      0.35 ± 15%      -0.3        0.09 ± 24%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.34 ±  9%      -0.3        0.09 ± 22%  perf-profile.self.cycles-pp.strncpy_from_user
      0.30 ±  8%      -0.2        0.05 ± 48%  perf-profile.self.cycles-pp.ext4_get_group_desc
      0.34 ± 11%      -0.2        0.10 ± 21%  perf-profile.self.cycles-pp.__ext4_handle_dirty_metadata
      0.34 ±  6%      -0.2        0.10 ± 28%  perf-profile.self.cycles-pp.jbd2_write_access_granted
      0.32 ±  7%      -0.2        0.08 ± 20%  perf-profile.self.cycles-pp.__slab_free
      0.31 ±  4%      -0.2        0.08 ± 15%  perf-profile.self.cycles-pp.xas_load
      0.31 ±  6%      -0.2        0.08 ± 20%  perf-profile.self.cycles-pp._IO_default_xsputn
      0.32 ±  2%      -0.2        0.09 ± 10%  perf-profile.self.cycles-pp.memset_orig
      0.31 ±  7%      -0.2        0.08 ± 14%  perf-profile.self.cycles-pp.mb_find_order_for_block
      0.31 ± 14%      -0.2        0.09 ± 32%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.25 ± 11%      -0.2        0.04 ± 73%  perf-profile.self.cycles-pp.ext4_statfs
      0.26 ± 12%      -0.2        0.05 ± 49%  perf-profile.self.cycles-pp.__ext4_new_inode
      0.26 ±  4%      -0.2        0.06 ± 13%  perf-profile.self.cycles-pp.crypto_shash_update
      0.23 ± 13%      -0.2        0.04 ± 71%  perf-profile.self.cycles-pp.path_init
      0.23 ± 14%      -0.2        0.03 ±100%  perf-profile.self.cycles-pp.jbd2_journal_dirty_metadata
      0.25 ±  8%      -0.2        0.06 ± 46%  perf-profile.self.cycles-pp.fscrypt_match_name
      0.22 ±  6%      -0.2        0.03 ±105%  perf-profile.self.cycles-pp.lockref_put_return
      0.21 ±  6%      -0.2        0.03 ±100%  perf-profile.self.cycles-pp.__ext4_mark_inode_dirty
      0.25 ± 14%      -0.2        0.08 ± 18%  perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.24 ±  7%      -0.2        0.06 ± 21%  perf-profile.self.cycles-pp.ext4_sb_block_valid
      0.20 ± 10%      -0.2        0.02 ± 99%  perf-profile.self.cycles-pp.__check_heap_object
      0.23 ± 10%      -0.2        0.06 ± 52%  perf-profile.self.cycles-pp.ext4_get_group_info
      0.20 ±  6%      -0.2        0.04 ± 71%  perf-profile.self.cycles-pp.ext4_reserve_inode_write
      0.23 ±  4%      -0.2        0.06 ± 23%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.19 ± 15%      -0.2        0.03 ±102%  perf-profile.self.cycles-pp.ext4_getblk
      0.19 ± 16%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.18 ±  5%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.dx_probe
      0.20 ± 12%      -0.1        0.08 ± 72%  perf-profile.self.cycles-pp.ext4_mb_prefetch
      0.17 ± 16%      -0.1        0.05 ± 46%  perf-profile.self.cycles-pp.ext4_fc_init_inode
      0.12 ±  8%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.do_syscall_64
      0.10 ± 18%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.10 ± 23%      -0.0        0.07 ± 20%  perf-profile.self.cycles-pp.ext4_mb_find_good_group_avg_frag_lists
     13.44 ±  5%      +9.0       22.43 ±  4%  perf-profile.self.cycles-pp.find_revoke_record
      6.72 ±  6%     +29.2       35.97 ±  4%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

