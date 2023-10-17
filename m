Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FB57CC70D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344098AbjJQPIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344351AbjJQPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:08:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D2A3861
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697555224; x=1729091224;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=1M6FROn6Nn1EG2ekyFz8pMfCQolH08ysIJy2I5BbGsw=;
  b=XWJk3zOpjJFKOjYLdHe+TIQrxmRgxe6/1AW90wsfe/h4arRITDQmLp1Z
   7oglCXMkRFYFmfHA2lmWscdQjnpto7f5e6ExsDMHUVGGmURe3KB94sCJD
   HqP0AZDU4yI8KA6c8WaHuPRrAdgfZ5MnKs6ph09CKxc1Fp46aF989XgRT
   Bk6GU71x89PZOEO7q7MN/Lrx0G+VkAy9KJngdJVDY/AEJrEhoockWGFhS
   iH+kWr9wRnwiZfs92mjuJWARUKOjevxMd9kz4wUHFEU+dzVWtP7j21Xj/
   tG7XGajy+9CmE5HQ9+Zw3yHYY6d6rtKpvoEa9lRTVdqfb6vqt2mbdhFBP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="389673008"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="389673008"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 08:07:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="756154027"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="756154027"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 08:06:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 08:06:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 08:06:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 08:06:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwXVDs0jnLOlcrfUdlCiNc+jzQb/jrwGWzMRD9VIdvQGvJVbAJDqTqql7+1QwleJVDxrHym+e6rEGYzS2FVzdQ11c0er39gGtB5WSvOuwPs7BwUkqr2BW0jy8VfLqOyh6OjqOJCm0EBMoG+MJ7aY3bIVlH3H4M7B0ljaQs1AF8ixZePhYVrr55mbPV9LlCj/s8djwiglFDMYNZHiRLrl/Mv6wY4q/FniUVV/5JbUlHklG0FDz7vmli62BZfNngj4d4r2MdMLUQ2Z8k6U17Fob4EGpnOyKkbCvw06guMbkNUz6s/UMd2KKUSYHmC1x6foYrI8+fuNb5IJcKHFppPMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue6cQODFUBKY324XKjUQXf8MFirb727MspoGKGd5tLY=;
 b=N1hxQ3WwPfaGNN83qU+B1o9SkVh5IxMkwPwyDC7oW/tPSsxkaQNx8NKQhFb8WRgcWqN8dRbfX+WEPDh3yokNEpCYwtR+3mJssd9Zs4YotHFtme+SGcBK97VIX6m5SOmXP0CNeRHp5mdHMgZurdWT2eVa+zGNVWQSm1Ib3qNbY7K/+0rhuqf4AKXqFSPHuSzOHSsrPL2fG0lh0+JVwHKnHYqKZ3NwC1zAna4fytO4G8ZgQZ4jHdMRSE1LZHnxcTJq4Qa7ApsN7ry73eIPbxudhHjIbT3MTEWETOMjkaQZ895lVlKqZlHChl5vSDB/WzJLdQyxu99bA2JByScVK86NTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DS0PR11MB7383.namprd11.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 15:06:51 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Tue, 17 Oct 2023
 15:06:51 +0000
Date:   Tue, 17 Oct 2023 23:06:42 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Max Kellermann <max.kellermann@ionos.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linux-next:master] [drivers/char/mem]  1b057bd800:
 stress-ng.splice.ops_per_sec -99.8% regression
Message-ID: <202310172247.b9959bd4-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::13) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DS0PR11MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f6ca8c-f614-41bf-46f8-08dbcf22b0fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NL11TMFmNSlF0YwAqTSIvhuYpJaxU7B0wtilFOWcKBAxvEy3umBgeWBHnn8EYGnwZLkCJ9UX+FfRGgGnhOaPvm1275cg16WJ9cNYR0VgiSXSR/+Pob65peo9UpausexVjQrf6NeeGwXWIPPrIx1yKT325Vj7ii7N/LLp52xd42CH0IKfkW3us/Z4o99bxJc3g5I7btUEQ1KDLtJc/+cfiVsd2V6DpUgIa6NR5hYCRxLXaz5r5qH6MWF8k1Gc6wqfw4hM6Pwap+wUzZmbY+0glAM2qY3QwS9FPsOBr1ZuHQERsCwc79Ten5qOaBbHLtobVdNdYhSvDq7W86HqFU92DPPQIQ173wahQveNJD2ThzyKD/1jW1cyOfUo95B8EqAfoo2fEZN+U8BWUR2fN394pqizwTdVeJrZh59MuICZFCuZ7znV9wZALveT1cTdEYs3l1vhHCRU4z96/VWPm/Mdbyb2tlzJnL1v8ynm/F2SYTIIFUvdwcoIBjpzMY0BMvtPpf7DuFXNJ588oVgvtXOez/LVyPecCcQeuGfxdUStTjVl0sN0EXq3ZFz06ZZR7fA0NywWCR3xjIEWCZyk/gaKPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(2616005)(66574015)(1076003)(6506007)(6512007)(6666004)(107886003)(83380400001)(41300700001)(2906002)(30864003)(8676002)(8936002)(4326008)(478600001)(966005)(6486002)(5660300002)(54906003)(66556008)(66946007)(66476007)(6916009)(316002)(38100700002)(36756003)(82960400001)(86362001)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6YJcD+B11WRgfzjKkvzWcn62T/IYQaRNLVPdUkkXFtC0kahK/Lugbp/8VS?=
 =?iso-8859-1?Q?qu4VLV1hVgZs/CzZpcUyHi3et1/USu6E2vPgNXTW9gZ6F3c8FVHBROAF+h?=
 =?iso-8859-1?Q?R/hpwlmQFtkC/xZRY4nrDcZrIZOsF4oZA6GZceNgBeru2/R+nzqMrW42Yg?=
 =?iso-8859-1?Q?KTv+hTJHeMtczxoVy4bjgcDsL1WWCaF56GQIE2/DPfKAW6qvpURQxY0PFS?=
 =?iso-8859-1?Q?2vYErlDkYLtJ4fYgJ4AHCSrdFatZpGzprO7sLkbQmHDxlNymrvIvr/aWaR?=
 =?iso-8859-1?Q?1PAe8ORX45ExJ6o67YKYu2McBlwGj4YoSrFYV1ptGi1MaqQjwtC0SvNKBR?=
 =?iso-8859-1?Q?OvDIH0mKeCILrGgwrFitwBeAe8rmpgrcCtSlAXpFPg1pjUuTKynJAAKoEg?=
 =?iso-8859-1?Q?Hvju75CuZoANoGbABt++6I9bdk5FUJKJifgsCXM40NFKHtrPKpfaylPYOR?=
 =?iso-8859-1?Q?jIJbjkjHu6geUgV1IIinNnBSEN+n7wAsxIMGFikZIRsGoZZLOzmY9TTVJ2?=
 =?iso-8859-1?Q?aIQM2agyDCXgUy9ffcthc4l6Y5VlO/yUugAZhgOLcSicnDr6nMgzxD8n1S?=
 =?iso-8859-1?Q?g2OjCf6qpkmb29+x4qvjqf7GsbZ8jlvZmgR3PSHsKKscO6AZMbVvctoChQ?=
 =?iso-8859-1?Q?oQEQ1kew2sXpnb2IPGsyhaCBicpU6VncjMaAAfItaxreOhiVO2OouWCq5/?=
 =?iso-8859-1?Q?HUX/uDmksF9isouPbnAF4NweBcdOmFl1UDLp1A8K8uMAdmxSzR8//rQQpU?=
 =?iso-8859-1?Q?XvEJgUnCOFEJo6z82t3FOljRgK2YWvx2OFkfsCAH/ZcLrWrnBdscofC1wU?=
 =?iso-8859-1?Q?5x9r1SMkmDuXiCBFFdTsfivo+qk0fm+VGSoci7FzwviRlE8WYCCUXzEJwU?=
 =?iso-8859-1?Q?nV4LY1XpK8Wxf96ljwnddjHksVTUn6dTKv3dOmyyk4DC7MsZwTheC+JqPj?=
 =?iso-8859-1?Q?TKSRHRgIiMSEmHuYBm10Ri9wmt48Wok3mDd5kIYRYWntCApggz/DQLb+ZW?=
 =?iso-8859-1?Q?8WJZie/0PuNG/7pbqUd8cEklOuvlLSt4FakbdMPbrlBkw0+AHywlsZUpKB?=
 =?iso-8859-1?Q?3QVuIwQMUaNK1qIKEXiMXdkZbh+WF4J/Q5Olz1SmGWHDnMp/tjvy8evD1a?=
 =?iso-8859-1?Q?uizj5igUMn494kMXaYkUssd9d2AqYcQ99PJIZcDGcpH0DgotgKJAaXmhiQ?=
 =?iso-8859-1?Q?kZvrvxbJ+MTlq6WmFHnl7oSwahHLvwKUpDn3ZDW3XWGcJp8sPxMJT7BeYu?=
 =?iso-8859-1?Q?RxLOdRFCn5WdNGlB5s/BzytUoTeIyM3Rr7jLP5TLaL7nNvl9/8FUXhqNMq?=
 =?iso-8859-1?Q?AeNuT8QqUyEbRYKPiTG1rHv9c89y6lcAUH0/9692YOt3DrdWomXQjQbvp/?=
 =?iso-8859-1?Q?4/Xflhp21+y4/djNnvxCI7gBJ5xgh2jonNpYjWce0oxLi6efSeBJNQPMFX?=
 =?iso-8859-1?Q?YdrM4DJ/uC2MXymj7ToEIG67Csq9e9OJbo3QCXE5oL7uvXjQaH2nybM6Ke?=
 =?iso-8859-1?Q?qw1CHLAWX4OB6rnHBzYjIZgKM5CT/BYZHo2C/aiVb/mIOCExLNXlgefKZ1?=
 =?iso-8859-1?Q?u8IumRNKY0+X+NejlSK2xeSa1McDD/6/m1hb74su/wT1VAKdoc+7Dd/zzp?=
 =?iso-8859-1?Q?d+7oRU3NpB05kmAnNNREFeaZ8z0RkMbWHfrms9hr1oLTHgLobfyFcgLg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f6ca8c-f614-41bf-46f8-08dbcf22b0fb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 15:06:51.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygo2dzgBothzENXYE0E5R6M0kU862j6QyJ7LeNlDJ3cPGe8pY25CXxx8+xnrU3wisq82Omd9tRDcK/SsPQnHtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7383
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a -99.8% regression of stress-ng.splice.ops_per_sec on:


commit: 1b057bd800c3ea0c926191d7950cd2365eddc9bb ("drivers/char/mem: implement splice() for /dev/zero, /dev/full")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	class: pipe
	test: splice
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.splice.ops_per_sec 38.9% improvement                                       |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | class=os                                                                                        |
|                  | cpufreq_governor=performance                                                                    |
|                  | disk=1HDD                                                                                       |
|                  | fs=ext4                                                                                         |
|                  | nr_threads=1                                                                                    |
|                  | test=splice                                                                                     |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310172247.b9959bd4-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231017/202310172247.b9959bd4-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  pipe/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/splice/stress-ng/60s

commit: 
  19e3e6cdfd ("accessibility: speakup: refactor deprecated strncpy")
  1b057bd800 ("drivers/char/mem: implement splice() for /dev/zero, /dev/full")

19e3e6cdfdc73400 1b057bd800c3ea0c926191d7950 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2272          +166.0%       6045        uptime.idle
 2.724e+08 ±  6%   +1401.7%  4.091e+09        cpuidle..time
    301247 ±  3%   +1283.6%    4167916        cpuidle..usage
 3.774e+08 ±  5%     -99.6%    1510553 ±  8%  numa-numastat.node0.local_node
 3.774e+08 ±  5%     -99.6%    1545040 ±  6%  numa-numastat.node0.numa_hit
 3.696e+08 ±  5%     -99.6%    1536537 ±  8%  numa-numastat.node1.local_node
 3.698e+08 ±  5%     -99.6%    1568287 ±  7%  numa-numastat.node1.numa_hit
    136270           -91.3%      11853 ±  3%  meminfo.Active
    136158           -91.4%      11741 ±  3%  meminfo.Active(anon)
   1318175           -12.0%    1160436        meminfo.Committed_AS
     57581           -35.5%      37162        meminfo.Mapped
    161552           -88.2%      19074        meminfo.Shmem
      5.78 ±  9%     +93.1       98.86        mpstat.cpu.all.idle%
      0.72            -0.1        0.62        mpstat.cpu.all.irq%
      0.00 ± 17%      +0.0        0.02 ±  4%  mpstat.cpu.all.soft%
     78.79           -78.6        0.20 ±  4%  mpstat.cpu.all.sys%
     14.69           -14.4        0.27        mpstat.cpu.all.usr%
    402.17 ± 11%     -99.5%       2.17 ± 86%  perf-c2c.DRAM.local
      4747 ±  3%     -99.5%      22.83 ± 16%  perf-c2c.DRAM.remote
      4301 ±  6%     -98.8%      53.00 ± 18%  perf-c2c.HITM.local
      2593 ±  7%     -99.5%      14.00 ± 20%  perf-c2c.HITM.remote
      6894 ±  2%     -99.0%      67.00 ± 15%  perf-c2c.HITM.total
      8.60 ±  6%   +1046.3%      98.61        vmstat.cpu.id
     77.15           -98.5%       1.14        vmstat.cpu.sy
     14.23           -98.1%       0.28 ±  2%  vmstat.cpu.us
     58.37           -99.0%       0.60 ±  4%  vmstat.procs.r
    112757           -41.9%      65497        vmstat.system.in
     14891 ± 17%     -85.7%       2127 ± 55%  numa-meminfo.node0.Active
     14872 ± 17%     -86.1%       2071 ± 55%  numa-meminfo.node0.Active(anon)
     21319 ± 16%     -67.5%       6920 ± 18%  numa-meminfo.node0.Shmem
    122229           -92.0%       9734 ± 12%  numa-meminfo.node1.Active
    122135           -92.1%       9678 ± 12%  numa-meminfo.node1.Active(anon)
    140624           -91.4%      12163 ± 12%  numa-meminfo.node1.Shmem
    743.57          +334.3%       3229 ±  3%  stress-ng.splice.MB_per_sec_splice_rate
  7.46e+08           -99.8%    1373628 ±  3%  stress-ng.splice.ops
  12433266           -99.8%      22893 ±  3%  stress-ng.splice.ops_per_sec
     58608 ± 19%     -99.9%      41.50 ± 79%  stress-ng.time.involuntary_context_switches
      6121           -99.9%       5.67 ±  8%  stress-ng.time.percent_of_cpu_this_job_got
      3212           -99.9%       2.93 ±  6%  stress-ng.time.system_time
    586.44           -99.8%       0.99 ±  5%  stress-ng.time.user_time
      3721 ± 17%     -86.1%     517.86 ± 55%  numa-vmstat.node0.nr_active_anon
      5334 ± 16%     -67.6%       1727 ± 17%  numa-vmstat.node0.nr_shmem
      3721 ± 17%     -86.1%     517.86 ± 55%  numa-vmstat.node0.nr_zone_active_anon
 3.774e+08 ±  5%     -99.6%    1544858 ±  6%  numa-vmstat.node0.numa_hit
 3.774e+08 ±  5%     -99.6%    1510371 ±  8%  numa-vmstat.node0.numa_local
     30543           -92.1%       2409 ± 12%  numa-vmstat.node1.nr_active_anon
     35175           -91.4%       3033 ± 12%  numa-vmstat.node1.nr_shmem
     30543           -92.1%       2409 ± 12%  numa-vmstat.node1.nr_zone_active_anon
 3.698e+08 ±  5%     -99.6%    1567973 ±  7%  numa-vmstat.node1.numa_hit
 3.696e+08 ±  5%     -99.6%    1536223 ±  8%  numa-vmstat.node1.numa_local
      3375           -98.6%      47.67        turbostat.Avg_MHz
     94.04           -92.7        1.32        turbostat.Busy%
    260617 ±  9%   +1489.4%    4142197        turbostat.C1
      6.02 ±  9%     +93.8       99.83        turbostat.C1%
      5.96 ±  9%   +1556.1%      98.68        turbostat.CPU%c1
     63.83 ±  3%     -22.5%      49.50 ±  2%  turbostat.CoreTmp
   7374866           -41.9%    4288223        turbostat.IRQ
     23.49 ± 30%     -23.5        0.01 ±100%  turbostat.PKG_%
     63.00 ±  2%     -21.4%      49.50 ±  2%  turbostat.PkgTmp
    400.87           -40.6%     238.28        turbostat.PkgWatt
     70.18 ±  2%     -13.5%      60.74        turbostat.RAMWatt
     34160           -91.4%       2935 ±  3%  proc-vmstat.nr_active_anon
     87556            -1.5%      86204        proc-vmstat.nr_anon_pages
    726993            -4.9%     691342        proc-vmstat.nr_file_pages
     93734            -6.0%      88078        proc-vmstat.nr_inactive_anon
     14153           -34.3%       9292        proc-vmstat.nr_mapped
     40421           -88.2%       4770        proc-vmstat.nr_shmem
     34160           -91.4%       2935 ±  3%  proc-vmstat.nr_zone_active_anon
     93734            -6.0%      88078        proc-vmstat.nr_zone_inactive_anon
     13484 ±  5%     -99.7%      36.33 ± 58%  proc-vmstat.numa_hint_faults
     12534 ±  6%    -100.0%       5.50 ±223%  proc-vmstat.numa_hint_faults_local
 7.472e+08           -99.6%    3115004 ±  3%  proc-vmstat.numa_hit
  7.47e+08           -99.6%    3048767 ±  3%  proc-vmstat.numa_local
      1482 ± 28%     -97.9%      30.83 ± 45%  proc-vmstat.numa_pages_migrated
     55167           -99.8%     120.00 ± 46%  proc-vmstat.numa_pte_updates
     65858 ±  2%     -93.2%       4468 ±  4%  proc-vmstat.pgactivate
 7.465e+08           -99.6%    3156108 ±  3%  proc-vmstat.pgalloc_normal
    358101           -18.6%     291467        proc-vmstat.pgfault
 7.464e+08           -99.6%    3150970 ±  3%  proc-vmstat.pgfree
      1482 ± 28%     -97.9%      30.83 ± 45%  proc-vmstat.pgmigrate_success
   1919511           -99.7%       5014 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.avg
   1945627           -99.2%      16366 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.max
   1822945           -99.9%     977.33 ± 13%  sched_debug.cfs_rq:/.avg_vruntime.min
     20450 ±  4%     -84.1%       3245 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.63           -78.0%       0.14 ±  9%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.83 ± 12%     -45.5%       1.00        sched_debug.cfs_rq:/.h_nr_running.max
      0.50          -100.0%       0.00        sched_debug.cfs_rq:/.h_nr_running.min
    545483           +51.1%     824178 ± 11%  sched_debug.cfs_rq:/.load.max
      8018          -100.0%       0.00        sched_debug.cfs_rq:/.load.min
     66622           +68.9%     112536 ± 12%  sched_debug.cfs_rq:/.load.stddev
    548.42         +3600.6%      20294 ± 91%  sched_debug.cfs_rq:/.load_avg.max
      7.50          -100.0%       0.00        sched_debug.cfs_rq:/.load_avg.min
    184.01 ±  5%   +1389.8%       2741 ± 89%  sched_debug.cfs_rq:/.load_avg.stddev
   1919511           -99.7%       5014 ±  3%  sched_debug.cfs_rq:/.min_vruntime.avg
   1945627           -99.2%      16366 ± 10%  sched_debug.cfs_rq:/.min_vruntime.max
   1822945           -99.9%     977.33 ± 13%  sched_debug.cfs_rq:/.min_vruntime.min
     20450 ±  4%     -84.1%       3245 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.62           -77.5%       0.14 ±  9%  sched_debug.cfs_rq:/.nr_running.avg
      0.50          -100.0%       0.00        sched_debug.cfs_rq:/.nr_running.min
      0.21 ±  3%     +44.5%       0.31 ±  3%  sched_debug.cfs_rq:/.nr_running.stddev
    766.20           -65.5%     264.60 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
      1333 ±  4%     -20.1%       1065 ± 12%  sched_debug.cfs_rq:/.runnable_avg.max
    512.00          -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
    195.91 ±  4%     +26.6%     248.04 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
    762.56           -65.4%     264.06 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
    505.42          -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
    176.81 ±  3%     +39.9%     247.39 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
    248.65 ±  4%     -90.2%      24.31 ± 26%  sched_debug.cfs_rq:/.util_est_enqueued.avg
     84.08 ± 12%    -100.0%       0.00        sched_debug.cfs_rq:/.util_est_enqueued.min
    736503           +10.7%     815492        sched_debug.cpu.avg_idle.avg
    125501 ± 37%    +150.5%     314353 ±  7%  sched_debug.cpu.avg_idle.min
    209723 ±  5%     -17.4%     173320 ±  4%  sched_debug.cpu.avg_idle.stddev
      3.56 ± 11%     -59.9%       1.43 ±  5%  sched_debug.cpu.clock.stddev
      2481           -81.4%     462.76 ± 10%  sched_debug.cpu.curr->pid.avg
      2027 ±  6%    -100.0%       0.00        sched_debug.cpu.curr->pid.min
    790.94 ±  2%     +45.0%       1146 ±  4%  sched_debug.cpu.curr->pid.stddev
      0.63           -78.0%       0.14 ± 10%  sched_debug.cpu.nr_running.avg
      1.83 ± 12%     -45.5%       1.00        sched_debug.cpu.nr_running.max
      0.50          -100.0%       0.00        sched_debug.cpu.nr_running.min
      0.74 ±  2%     -42.9%       0.42 ±  5%  perf-stat.i.MPKI
 2.563e+10           -98.6%  3.557e+08        perf-stat.i.branch-instructions
      0.16 ±  5%      +1.1        1.27        perf-stat.i.branch-miss-rate%
  23826465 ±  4%     -70.4%    7064101        perf-stat.i.branch-misses
     36.05 ±  3%     -26.9        9.14 ±  4%  perf-stat.i.cache-miss-rate%
  97109331 ±  2%     -99.5%     445320 ±  3%  perf-stat.i.cache-misses
 2.636e+08           -98.2%    4830384 ±  3%  perf-stat.i.cache-references
      1.67           +58.9%       2.65        perf-stat.i.cpi
 2.185e+11           -99.0%  2.225e+09 ±  2%  perf-stat.i.cpu-cycles
    142.39           -38.7%      87.35        perf-stat.i.cpu-migrations
      2287 ±  2%    +214.5%       7193 ±  6%  perf-stat.i.cycles-between-cache-misses
      0.00 ±  5%      +0.0        0.03 ± 10%  perf-stat.i.dTLB-load-miss-rate%
    126811 ±  6%     -55.6%      56317 ±  8%  perf-stat.i.dTLB-load-misses
 3.748e+10           -98.9%  4.216e+08        perf-stat.i.dTLB-loads
      0.00 ±  7%      +0.0        0.02 ±  4%  perf-stat.i.dTLB-store-miss-rate%
     66664           -67.3%      21800 ±  4%  perf-stat.i.dTLB-store-misses
 2.342e+10           -99.2%  1.814e+08        perf-stat.i.dTLB-stores
 1.294e+11           -98.6%  1.763e+09        perf-stat.i.instructions
      0.61           -19.6%       0.49        perf-stat.i.ipc
      0.16 ± 54%     -81.7%       0.03 ± 48%  perf-stat.i.major-faults
      3.41           -99.0%       0.03 ±  2%  perf-stat.i.metric.GHz
    559.53 ±  3%     +18.7%     663.98 ±  3%  perf-stat.i.metric.K/sec
      1356           -98.9%      14.37        perf-stat.i.metric.M/sec
      4046           -27.6%       2928        perf-stat.i.minor-faults
     90.60            -5.5       85.14 ±  2%  perf-stat.i.node-load-miss-rate%
  15399896 ±  4%     -99.5%      73111 ±  5%  perf-stat.i.node-load-misses
   1456459 ±  5%     -98.4%      22922 ± 10%  perf-stat.i.node-loads
     96.48           -59.4       37.04 ± 31%  perf-stat.i.node-store-miss-rate%
  17686801 ±  3%     -99.8%      38212 ± 22%  perf-stat.i.node-store-misses
    211214 ±  5%     -73.3%      56368 ± 13%  perf-stat.i.node-stores
      4046           -27.6%       2928        perf-stat.i.page-faults
      0.75 ±  2%     -66.4%       0.25 ±  3%  perf-stat.overall.MPKI
      0.09 ±  5%      +1.9        1.99        perf-stat.overall.branch-miss-rate%
     36.84 ±  3%     -27.6        9.22 ±  3%  perf-stat.overall.cache-miss-rate%
      1.69           -25.3%       1.26 ±  2%  perf-stat.overall.cpi
      2252 ±  2%    +122.0%       4998 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  8%      +0.0        0.01 ±  7%  perf-stat.overall.dTLB-load-miss-rate%
      0.00            +0.0        0.01 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
      0.59           +34.0%       0.79 ±  2%  perf-stat.overall.ipc
     91.32           -15.2       76.12 ±  3%  perf-stat.overall.node-load-miss-rate%
     98.82           -58.5       40.36 ± 21%  perf-stat.overall.node-store-miss-rate%
 2.522e+10           -98.6%  3.509e+08        perf-stat.ps.branch-instructions
  23422336 ±  4%     -70.2%    6970716        perf-stat.ps.branch-misses
  95558027 ±  2%     -99.5%     438886 ±  3%  perf-stat.ps.cache-misses
 2.595e+08           -98.2%    4763002 ±  3%  perf-stat.ps.cache-references
  2.15e+11           -99.0%  2.192e+09 ±  2%  perf-stat.ps.cpu-cycles
    140.46           -38.8%      85.97        perf-stat.ps.cpu-migrations
    129105 ±  8%     -57.0%      55458 ±  8%  perf-stat.ps.dTLB-load-misses
 3.689e+10           -98.9%  4.157e+08        perf-stat.ps.dTLB-loads
     65855           -67.4%      21474 ±  4%  perf-stat.ps.dTLB-store-misses
 2.304e+10           -99.2%  1.789e+08        perf-stat.ps.dTLB-stores
 1.273e+11           -98.6%  1.739e+09        perf-stat.ps.instructions
      0.16 ± 54%     -81.6%       0.03 ± 48%  perf-stat.ps.major-faults
      3974           -27.5%       2882        perf-stat.ps.minor-faults
  15153146 ±  4%     -99.5%      72034 ±  5%  perf-stat.ps.node-load-misses
   1435599 ±  5%     -98.4%      22594 ± 10%  perf-stat.ps.node-loads
  17403697 ±  3%     -99.8%      37693 ± 22%  perf-stat.ps.node-store-misses
    207650 ±  5%     -73.2%      55558 ± 13%  perf-stat.ps.node-stores
      3974           -27.5%       2882        perf-stat.ps.page-faults
 8.067e+12           -98.6%  1.098e+11        perf-stat.total.instructions
      2.08 ±  5%    -100.0%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.20 ±149%     -98.4%       0.00 ± 11%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.09 ±135%     -97.5%       0.00 ± 17%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.54 ± 30%     -99.5%       0.00 ± 13%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.02 ± 82%     -81.8%       0.00 ± 11%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.02 ± 37%     -65.0%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.01 ± 19%     -78.8%       0.00        perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ±  4%     -74.5%       0.00        perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±  7%     -58.6%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.18 ± 56%     -99.6%       0.00 ± 10%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ±  6%     -60.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.09 ± 33%     -96.6%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ±  6%     -62.2%       0.00 ± 20%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 33%     -61.5%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  9%     -27.6%       0.01        perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      1.20 ± 30%     -99.8%       0.00        perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      1.23 ±116%     -99.6%       0.01 ± 11%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      3.93          -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.97 ±153%     -99.5%       0.01 ± 34%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.50 ±142%     -99.4%       0.00 ± 11%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      3.91           -99.7%       0.01 ±111%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.03 ±130%     -99.3%       0.01 ± 24%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      3.82 ±  9%     -99.8%       0.01 ± 16%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1.50 ± 65%     -99.3%       0.01 ± 15%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 20%     -50.7%       0.01 ±  9%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 18%     -47.3%       0.00 ± 14%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      2.75 ± 31%     -99.8%       0.01 ±  6%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ±  9%     -44.4%       0.01 ± 11%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      2.45 ± 46%     -99.7%       0.01 ± 46%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 25%     -59.4%       0.00 ± 21%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      2.04 ± 56%     -93.7%       0.13 ±121%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  6%     -27.9%       0.01 ±  4%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      3.94           -99.9%       0.00 ± 48%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.06 ±  4%     -91.9%       0.00 ± 24%  perf-sched.total_sch_delay.average.ms
    111.94 ±  6%    +149.0%     278.74 ±  7%  perf-sched.total_wait_and_delay.average.ms
      5730 ±  6%     -61.0%       2233 ±  6%  perf-sched.total_wait_and_delay.count.ms
    111.89 ±  6%    +149.1%     278.74 ±  7%  perf-sched.total_wait_time.average.ms
      0.07 ± 22%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.pipe_double_lock.splice_pipe_to_pipe.do_splice
      0.17 ± 84%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.07 ± 32%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.splice_from_pipe.do_splice.__do_splice
      2.08 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      2.87 ± 18%     -93.6%       0.18 ±  2%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.08 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.39 ±171%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    148.55 ± 35%     +95.5%     290.39        perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.82 ±  3%     +60.0%       4.51 ± 11%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1.67 ±  3%     -68.5%       0.53 ± 58%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      6.72 ±  3%    +376.7%      32.02 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    505.64 ±  7%     +20.3%     608.06 ±  7%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.33 ± 24%     -99.8%       0.00        perf-sched.wait_and_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    570.88 ±  4%     -24.1%     433.13 ±  4%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    110.50 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.pipe_double_lock.splice_pipe_to_pipe.do_splice
     46.17 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
     41.33 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.splice_from_pipe.do_splice.__do_splice
     26.67 ± 16%     -90.6%       2.50 ± 38%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     61.17 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
    104.33 ±  3%     +18.5%     123.67        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    305.17 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1977 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    503.33 ± 25%     -53.6%     233.33        perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     51.00 ±  6%     +64.7%      84.00 ±  9%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    721.67 ±  3%     -79.8%     145.67 ± 10%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    615.33 ±  6%     -12.2%     540.17 ±  7%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    291.17 ±  7%     +15.7%     337.00 ±  4%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.28 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.pipe_double_lock.splice_pipe_to_pipe.do_splice
      4.26 ±130%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      1.47 ± 71%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.splice_from_pipe.do_splice.__do_splice
      2527 ± 38%     -47.1%       1336 ± 55%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.93          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     50.82 ± 99%     -98.9%       0.57 ±  2%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      5.04 ±101%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    176.65 ±208%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    189.67 ± 18%     +44.2%     273.50 ± 17%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3.94           -99.9%       0.00 ± 45%  perf-sched.wait_and_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.05 ± 36%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.pipe_write.vfs_write.ksys_write
      0.04 ± 94%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__splice_from_pipe.splice_from_pipe.do_splice.__do_splice
      0.12 ± 98%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.07 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_double_lock.splice_pipe_to_pipe.do_splice
      0.17 ± 84%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.21 ±164%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.splice_file_to_pipe.do_splice.__do_splice
      0.07 ± 32%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.splice_from_pipe.do_splice.__do_splice
      0.10 ± 39%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.splice_pipe_to_pipe.do_splice.__do_splice
      2.85 ± 18%     -93.7%       0.18 ±  2%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.07 ± 32%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.13 ± 77%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.37 ±178%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    148.54 ± 35%     +95.5%     290.38        perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.81 ±  3%     +60.4%       4.51 ± 11%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1.58 ±  5%     -66.9%       0.52 ± 58%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      6.71 ±  3%    +376.9%      32.01 ± 10%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    505.63 ±  7%     +20.3%     608.06 ±  7%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.12 ± 74%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    570.86 ±  4%     -24.1%     433.12 ±  4%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.49 ± 75%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.pipe_write.vfs_write.ksys_write
      0.20 ±133%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__splice_from_pipe.splice_from_pipe.do_splice.__do_splice
      0.54 ± 98%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      1.28 ± 24%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_double_lock.splice_pipe_to_pipe.do_splice
      4.26 ±130%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      3.16 ±184%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.splice_file_to_pipe.do_splice.__do_splice
      1.47 ± 71%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.splice_from_pipe.do_splice.__do_splice
      1.46 ± 78%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.splice_pipe_to_pipe.do_splice.__do_splice
      2527 ± 38%     -47.1%       1336 ± 55%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     50.74 ± 99%     -98.9%       0.56 ±  2%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      5.04 ±101%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1.02 ± 77%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
    176.65 ±208%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    189.66 ± 18%     +44.2%     273.50 ± 17%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.77 ± 33%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     81.68           -81.7        0.00        perf-profile.calltrace.cycles-pp.splice
     69.84           -69.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.splice
     67.70           -67.7        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
     64.18           -64.2        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
     59.37           -59.4        0.00        perf-profile.calltrace.cycles-pp.__do_splice.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
     57.18           -57.2        0.00        perf-profile.calltrace.cycles-pp.do_splice.__do_splice.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe
     42.45           -42.5        0.00        perf-profile.calltrace.cycles-pp.splice_from_pipe.do_splice.__do_splice.__x64_sys_splice.do_syscall_64
     41.51           -41.5        0.00        perf-profile.calltrace.cycles-pp.__splice_from_pipe.splice_from_pipe.do_splice.__do_splice.__x64_sys_splice
     39.36           -39.4        0.00        perf-profile.calltrace.cycles-pp.__folio_put.__splice_from_pipe.splice_from_pipe.do_splice.__do_splice
     39.26           -39.3        0.00        perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge.__folio_put.__splice_from_pipe.splice_from_pipe.do_splice
     38.84           -38.8        0.00        perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge.__folio_put.__splice_from_pipe.splice_from_pipe
     36.10           -36.1        0.00        perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge.__folio_put.__splice_from_pipe
     12.98           -13.0        0.00        perf-profile.calltrace.cycles-pp.write
     12.06           -12.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     11.90           -11.9        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     11.57           -11.6        0.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     10.51           -10.5        0.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      9.76            -9.8        0.00        perf-profile.calltrace.cycles-pp.splice_pipe_to_pipe.do_splice.__do_splice.__x64_sys_splice.do_syscall_64
      9.45            -9.5        0.00        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.30 ±  5%      -9.3        0.00        perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge.__folio_put
      8.53            -8.5        0.00        perf-profile.calltrace.cycles-pp.__entry_text_start.splice
      5.44            -5.4        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.00            +0.7        0.66 ±  7%  perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.00            +0.7        0.70 ±  7%  perf-profile.calltrace.cycles-pp.native_apic_msr_eoi.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +0.7        0.73 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.73 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.74 ± 11%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains
      0.00            +0.9        0.94 ± 13%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.00            +0.9        0.94 ±  8%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__do_softirq
      0.00            +1.0        1.00 ±  7%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu
      0.00            +1.0        1.05 ±  8%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +1.1        1.07 ± 26%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +1.1        1.12 ±  6%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +1.4        1.40 ± 23%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +1.4        1.44 ± 18%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.00            +1.5        1.48 ± 11%  perf-profile.calltrace.cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +1.5        1.51 ± 18%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      0.00            +1.5        1.54 ± 17%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
      0.00            +1.5        1.54 ± 17%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations
      0.00            +1.5        1.54 ± 17%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.5        1.54 ± 17%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.5        1.54 ± 17%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.5        1.54 ± 17%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +1.5        1.54 ± 17%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.00            +1.6        1.57 ±  3%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.6        1.59 ± 13%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +1.6        1.62 ±  6%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +1.7        1.66 ± 14%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +2.2        2.24 ± 10%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +2.3        2.30 ± 13%  perf-profile.calltrace.cycles-pp.arch_scale_freq_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.00            +2.4        2.38 ±  5%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +3.2        3.20 ±  5%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +3.9        3.88 ±  7%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +4.4        4.41 ±  7%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +8.0        8.00 ±  8%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times
      0.00           +12.1       12.15 ±  6%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      0.00           +12.5       12.54 ±  6%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.00           +16.7       16.65 ±  6%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.00           +18.4       18.44 ±  5%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.00           +18.6       18.64 ±  5%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00           +20.5       20.49 ±  8%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00           +24.3       24.29 ±  7%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00           +28.3       28.30 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00           +29.3       29.31 ±  7%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00           +37.3       37.26 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.00           +46.9       46.88 ±  3%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00           +88.4       88.42        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00           +89.0       88.95        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00           +89.9       89.85        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00           +93.5       93.46        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00           +94.3       94.31        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00           +94.5       94.46        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00           +94.5       94.46        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      0.00           +96.0       96.00        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.00          +123.6      123.62        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     82.00           -82.0        0.00        perf-profile.children.cycles-pp.splice
     82.07           -79.8        2.28 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     80.39           -78.1        2.27 ±  8%  perf-profile.children.cycles-pp.do_syscall_64
     64.69           -64.7        0.00        perf-profile.children.cycles-pp.__x64_sys_splice
     59.95           -60.0        0.00        perf-profile.children.cycles-pp.__do_splice
     57.55           -57.6        0.00        perf-profile.children.cycles-pp.do_splice
     42.50           -42.5        0.00        perf-profile.children.cycles-pp.splice_from_pipe
     41.57           -41.6        0.00        perf-profile.children.cycles-pp.__splice_from_pipe
     39.38           -39.4        0.00        perf-profile.children.cycles-pp.__folio_put
     39.28           -39.3        0.00        perf-profile.children.cycles-pp.__mem_cgroup_uncharge
     38.90           -38.9        0.00        perf-profile.children.cycles-pp.uncharge_batch
     36.14           -36.1        0.00        perf-profile.children.cycles-pp.page_counter_uncharge
     13.29           -13.2        0.09 ± 30%  perf-profile.children.cycles-pp.write
     11.64           -11.6        0.07 ± 28%  perf-profile.children.cycles-pp.ksys_write
     10.58           -10.5        0.07 ± 31%  perf-profile.children.cycles-pp.vfs_write
     10.12           -10.1        0.00        perf-profile.children.cycles-pp.splice_pipe_to_pipe
      9.56            -9.5        0.04 ± 73%  perf-profile.children.cycles-pp.pipe_write
      9.45 ±  5%      -9.4        0.00        perf-profile.children.cycles-pp.propagate_protected_usage
      5.51            -5.5        0.01 ±223%  perf-profile.children.cycles-pp.__entry_text_start
      5.49            -5.5        0.03 ±102%  perf-profile.children.cycles-pp.__alloc_pages
      1.18            -1.1        0.06 ± 78%  perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.1        0.06 ± 23%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.00            +0.1        0.06 ± 21%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.filename_lookup
      0.00            +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.path_lookupat
      0.00            +0.1        0.07 ± 32%  perf-profile.children.cycles-pp.exec_mmap
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.sched_clock_noinstr
      0.07 ±  6%      +0.1        0.15 ± 23%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.08 ± 25%  perf-profile.children.cycles-pp.evsel__read_counter
      0.00            +0.1        0.08 ± 49%  perf-profile.children.cycles-pp.setlocale
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.drm_gem_get_pages
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.drm_gem_shmem_get_pages
      0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.release_pages
      0.00            +0.1        0.08 ± 35%  perf-profile.children.cycles-pp.can_stop_idle_tick
      0.00            +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.begin_new_exec
      0.00            +0.1        0.09 ± 41%  perf-profile.children.cycles-pp.elf_map
      0.00            +0.1        0.09 ± 23%  perf-profile.children.cycles-pp.copy_strings
      0.00            +0.1        0.09 ± 26%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.00            +0.1        0.09 ± 36%  perf-profile.children.cycles-pp.drm_gem_vmap_unlocked
      0.00            +0.1        0.09 ± 36%  perf-profile.children.cycles-pp.drm_gem_vmap
      0.00            +0.1        0.09 ± 36%  perf-profile.children.cycles-pp.drm_gem_shmem_vmap
      0.00            +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.00            +0.1        0.10 ± 36%  perf-profile.children.cycles-pp.dup_mm
      0.00            +0.1        0.10 ± 49%  perf-profile.children.cycles-pp.tick_program_event
      0.00            +0.1        0.10 ± 40%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.00            +0.1        0.10 ± 39%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.1        0.10 ± 21%  perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +0.1        0.10 ± 12%  perf-profile.children.cycles-pp.seq_read_iter
      0.00            +0.1        0.10 ± 26%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.00            +0.1        0.11 ± 21%  perf-profile.children.cycles-pp.tick_nohz_idle_retain_tick
      0.00            +0.1        0.11 ± 25%  perf-profile.children.cycles-pp.link_path_walk
      0.00            +0.1        0.11 ± 38%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.1        0.12 ±  9%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.12 ± 25%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.00            +0.1        0.12 ± 46%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.00            +0.1        0.12 ± 44%  perf-profile.children.cycles-pp.update_rt_rq_load_avg
      0.00            +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.00            +0.1        0.12 ± 26%  perf-profile.children.cycles-pp.schedule
      0.00            +0.1        0.12 ± 41%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.00            +0.1        0.12 ± 29%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      0.00            +0.1        0.12 ± 38%  perf-profile.children.cycles-pp.__mmap
      0.00            +0.1        0.13 ± 10%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.13 ± 36%  perf-profile.children.cycles-pp._dl_addr
      0.00            +0.1        0.13 ± 15%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.00            +0.1        0.14 ± 41%  perf-profile.children.cycles-pp.__collapse_huge_page_copy
      0.00            +0.1        0.14 ± 45%  perf-profile.children.cycles-pp.rcu_report_qs_rdp
      0.00            +0.1        0.14 ± 28%  perf-profile.children.cycles-pp.__do_sys_clone
      0.00            +0.1        0.14 ± 25%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.00            +0.1        0.14 ± 25%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
      0.00            +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.hrtimer_forward
      0.00            +0.1        0.14 ± 12%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.2        0.15 ± 35%  perf-profile.children.cycles-pp.intel_pmu_disable_all
      0.00            +0.2        0.15 ± 38%  perf-profile.children.cycles-pp.collapse_huge_page
      0.00            +0.2        0.15 ± 33%  perf-profile.children.cycles-pp.irqentry_exit
      0.00            +0.2        0.16 ± 37%  perf-profile.children.cycles-pp.khugepaged
      0.00            +0.2        0.16 ± 37%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      0.00            +0.2        0.16 ± 37%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
      0.00            +0.2        0.16 ± 32%  perf-profile.children.cycles-pp.menu_reflect
      0.00            +0.2        0.16 ± 11%  perf-profile.children.cycles-pp.cpu_util
      0.00            +0.2        0.16 ± 36%  perf-profile.children.cycles-pp.update_wall_time
      0.00            +0.2        0.16 ± 36%  perf-profile.children.cycles-pp.timekeeping_advance
      0.00            +0.2        0.17 ± 33%  perf-profile.children.cycles-pp.__libc_fork
      0.00            +0.2        0.17 ± 42%  perf-profile.children.cycles-pp.sched_setaffinity
      0.00            +0.2        0.17 ± 18%  perf-profile.children.cycles-pp.copy_process
      0.00            +0.2        0.17 ± 33%  perf-profile.children.cycles-pp.arch_cpu_idle_exit
      0.00            +0.2        0.18 ± 15%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.00            +0.2        0.18 ± 35%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.2        0.18 ± 39%  perf-profile.children.cycles-pp.path_openat
      0.00            +0.2        0.19 ± 36%  perf-profile.children.cycles-pp.do_filp_open
      0.00            +0.2        0.19 ± 15%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.2        0.20 ± 27%  perf-profile.children.cycles-pp.filemap_map_pages
      0.00            +0.2        0.20 ± 17%  perf-profile.children.cycles-pp.__schedule
      0.00            +0.2        0.20 ± 25%  perf-profile.children.cycles-pp.check_cpu_stall
      0.00            +0.2        0.20 ± 13%  perf-profile.children.cycles-pp.kernel_clone
      0.00            +0.2        0.21 ± 41%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.00            +0.2        0.21 ± 20%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.2        0.21 ± 25%  perf-profile.children.cycles-pp.note_gp_changes
      0.00            +0.2        0.21 ± 23%  perf-profile.children.cycles-pp.do_sys_openat2
      0.00            +0.2        0.21 ± 30%  perf-profile.children.cycles-pp.error_entry
      0.00            +0.2        0.21 ± 17%  perf-profile.children.cycles-pp.__memcpy
      0.00            +0.2        0.21 ± 22%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.00            +0.2        0.21 ± 22%  perf-profile.children.cycles-pp.exit_mm
      0.00            +0.2        0.21 ± 26%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.2        0.22 ± 33%  perf-profile.children.cycles-pp.do_read_fault
      0.00            +0.2        0.22 ± 34%  perf-profile.children.cycles-pp._find_next_and_bit
      0.00            +0.2        0.23 ± 20%  perf-profile.children.cycles-pp.read
      0.00            +0.2        0.23 ± 31%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.2        0.24 ±  9%  perf-profile.children.cycles-pp.read_counters
      0.00            +0.2        0.24 ±  8%  perf-profile.children.cycles-pp.cmd_stat
      0.00            +0.2        0.24 ±  8%  perf-profile.children.cycles-pp.dispatch_events
      0.00            +0.2        0.24 ±  8%  perf-profile.children.cycles-pp.process_interval
      0.00            +0.2        0.24 ± 23%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.00            +0.2        0.25 ± 17%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.00            +0.3        0.25 ± 29%  perf-profile.children.cycles-pp.trigger_load_balance
      0.00            +0.3        0.26 ±  7%  perf-profile.children.cycles-pp.main
      0.00            +0.3        0.26 ±  7%  perf-profile.children.cycles-pp.run_builtin
      0.00            +0.3        0.26 ±  7%  perf-profile.children.cycles-pp.__libc_start_main
      0.00            +0.3        0.26 ± 34%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.3        0.26 ± 21%  perf-profile.children.cycles-pp.exit_mmap
      0.00            +0.3        0.27 ± 32%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.3        0.27 ± 22%  perf-profile.children.cycles-pp.__mmput
      0.00            +0.3        0.27 ± 18%  perf-profile.children.cycles-pp.vfs_read
      0.00            +0.3        0.28 ± 17%  perf-profile.children.cycles-pp.ksys_read
      0.00            +0.3        0.28 ± 28%  perf-profile.children.cycles-pp.do_fault
      0.00            +0.3        0.28 ± 18%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +0.3        0.28 ± 18%  perf-profile.children.cycles-pp.do_group_exit
      0.00            +0.3        0.28 ± 18%  perf-profile.children.cycles-pp.do_exit
      0.00            +0.3        0.28 ± 21%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.3        0.28 ± 23%  perf-profile.children.cycles-pp.ct_nmi_enter
      0.00            +0.3        0.28 ± 23%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.3        0.29 ± 20%  perf-profile.children.cycles-pp.mmap_region
      0.00            +0.3        0.32 ± 21%  perf-profile.children.cycles-pp.do_mmap
      0.00            +0.3        0.33 ± 19%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.00            +0.3        0.34 ± 12%  perf-profile.children.cycles-pp.irq_work_tick
      0.00            +0.4        0.35 ± 19%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.00            +0.4        0.35 ± 22%  perf-profile.children.cycles-pp.load_elf_binary
      0.00            +0.4        0.37 ± 21%  perf-profile.children.cycles-pp.exec_binprm
      0.00            +0.4        0.37 ± 21%  perf-profile.children.cycles-pp.search_binary_handler
      0.00            +0.4        0.37 ± 13%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.4        0.38 ± 23%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.4        0.38 ± 21%  perf-profile.children.cycles-pp.ct_idle_exit
      0.00            +0.4        0.38 ± 18%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.4        0.40 ± 44%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.4        0.40 ± 20%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.4        0.40 ± 21%  perf-profile.children.cycles-pp.bprm_execve
      0.00            +0.4        0.40 ± 16%  perf-profile.children.cycles-pp.irqentry_enter
      0.00            +0.4        0.40 ± 33%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.00            +0.4        0.41 ± 24%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.4        0.42 ± 13%  perf-profile.children.cycles-pp.get_cpu_device
      0.30 ±  2%      +0.4        0.72 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.4        0.42 ± 20%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.4        0.42 ± 29%  perf-profile.children.cycles-pp.handle_mm_fault
      0.00            +0.4        0.42 ± 20%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.00            +0.4        0.44 ± 23%  perf-profile.children.cycles-pp.perf_pmu_nop_void
      0.00            +0.4        0.44 ± 26%  perf-profile.children.cycles-pp.exc_page_fault
      0.00            +0.4        0.44 ± 26%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.00            +0.4        0.45 ± 20%  perf-profile.children.cycles-pp.should_we_balance
      0.00            +0.4        0.45 ± 12%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.5        0.48 ± 25%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.00            +0.5        0.48 ± 28%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.5        0.48 ± 23%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.5        0.49 ± 14%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.5        0.49 ±  7%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.6        0.56 ± 28%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.00            +0.6        0.57 ± 11%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.6        0.58 ± 21%  perf-profile.children.cycles-pp.do_execveat_common
      0.00            +0.6        0.58 ± 21%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.00            +0.6        0.59 ± 20%  perf-profile.children.cycles-pp.execve
      0.00            +0.6        0.62 ± 20%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.00            +0.6        0.62 ± 33%  perf-profile.children.cycles-pp.kthread
      0.00            +0.6        0.63 ± 32%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +0.6        0.63 ± 21%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.6        0.64 ± 32%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.00            +0.7        0.67 ±  6%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.7        0.68 ± 19%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.8        0.75 ± 10%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.8        0.84 ± 10%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.00            +0.9        0.87 ± 17%  perf-profile.children.cycles-pp.sched_clock
      0.00            +0.9        0.88 ±  6%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.00            +1.0        0.97 ± 15%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +1.0        1.00 ± 12%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +1.0        1.02 ± 15%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +1.1        1.06 ±  8%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +1.1        1.09 ± 14%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +1.1        1.11 ±  7%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +1.1        1.14 ± 26%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +1.2        1.22 ±  3%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +1.3        1.26 ± 60%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.00            +1.3        1.27 ±  8%  perf-profile.children.cycles-pp.read_tsc
      0.00            +1.5        1.46 ± 23%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +1.5        1.54 ± 17%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.00            +1.5        1.54 ± 17%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.00            +1.5        1.54 ± 17%  perf-profile.children.cycles-pp.start_kernel
      0.00            +1.5        1.54 ± 17%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.00            +1.5        1.54 ± 17%  perf-profile.children.cycles-pp.rest_init
      0.00            +1.6        1.56 ± 12%  perf-profile.children.cycles-pp.perf_rotate_context
      0.00            +1.6        1.62 ±  2%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +1.6        1.64 ± 12%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +1.7        1.68 ± 15%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +1.7        1.74 ±  5%  perf-profile.children.cycles-pp.load_balance
      0.00            +1.8        1.76 ± 11%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +2.2        2.17 ± 23%  perf-profile.children.cycles-pp.ktime_get
      0.00            +2.3        2.35 ±  9%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.00            +2.4        2.36 ± 12%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +2.4        2.45 ±  4%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +3.3        3.27 ±  5%  perf-profile.children.cycles-pp.menu_select
      0.00            +4.0        3.99 ±  8%  perf-profile.children.cycles-pp.__do_softirq
      0.00            +4.5        4.54 ±  7%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.05 ±  8%      +9.2        9.29 ±  7%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.08 ± 10%     +12.6       12.65 ±  5%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.08 ±  8%     +12.7       12.75 ±  6%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.16 ±  3%     +16.8       17.00 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      0.18 ±  2%     +18.6       18.80 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.18 ±  2%     +18.8       18.94 ±  5%  perf-profile.children.cycles-pp.tick_sched_handle
      0.19 ±  3%     +20.7       20.87 ±  8%  perf-profile.children.cycles-pp.tick_sched_timer
      0.22 ±  2%     +24.5       24.69 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.25 ±  3%     +28.5       28.72 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.25 ±  2%     +29.5       29.71 ±  6%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.26           +37.1       37.37 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.29 ±  3%     +80.7       81.02        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00           +88.3       88.31        perf-profile.children.cycles-pp.acpi_safe_halt
      0.00           +88.5       88.50        perf-profile.children.cycles-pp.acpi_idle_enter
      0.00           +90.0       89.96        perf-profile.children.cycles-pp.cpuidle_enter_state
      0.00           +90.4       90.40        perf-profile.children.cycles-pp.cpuidle_enter
      0.00           +94.5       94.46        perf-profile.children.cycles-pp.start_secondary
      0.00           +95.1       95.07        perf-profile.children.cycles-pp.cpuidle_idle_call
      0.00           +96.0       96.00        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.00           +96.0       96.00        perf-profile.children.cycles-pp.cpu_startup_entry
      0.00           +96.0       96.00        perf-profile.children.cycles-pp.do_idle
     26.75           -26.8        0.00        perf-profile.self.cycles-pp.page_counter_uncharge
      9.40 ±  5%      -9.4        0.00        perf-profile.self.cycles-pp.propagate_protected_usage
      0.06 ±  6%      +0.1        0.12 ± 28%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.07 ± 25%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.00            +0.1        0.08 ± 35%  perf-profile.self.cycles-pp.can_stop_idle_tick
      0.00            +0.1        0.08 ± 35%  perf-profile.self.cycles-pp.update_blocked_averages
      0.00            +0.1        0.09 ± 36%  perf-profile.self.cycles-pp.intel_pmu_disable_all
      0.00            +0.1        0.10 ± 43%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.1        0.10 ± 25%  perf-profile.self.cycles-pp.tick_nohz_idle_retain_tick
      0.00            +0.1        0.10 ± 17%  perf-profile.self.cycles-pp.hrtimer_update_next_event
      0.00            +0.1        0.10 ± 16%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.10 ± 38%  perf-profile.self.cycles-pp.menu_reflect
      0.00            +0.1        0.11 ± 46%  perf-profile.self.cycles-pp.clockevents_program_event
      0.00            +0.1        0.11 ± 10%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.11 ± 33%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.1        0.11 ± 21%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.1        0.11 ± 39%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
      0.00            +0.1        0.11 ± 27%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.11 ± 23%  perf-profile.self.cycles-pp.irqentry_enter
      0.00            +0.1        0.12 ± 19%  perf-profile.self.cycles-pp.__irq_exit_rcu
      0.00            +0.1        0.12 ± 23%  perf-profile.self.cycles-pp.hrtimer_forward
      0.00            +0.1        0.12 ± 46%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.00            +0.1        0.12 ± 17%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.12 ± 41%  perf-profile.self.cycles-pp._dl_addr
      0.00            +0.1        0.12 ± 14%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.00            +0.1        0.12 ± 37%  perf-profile.self.cycles-pp.timerqueue_del
      0.00            +0.1        0.13 ± 16%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +0.1        0.13 ± 40%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.1        0.13 ± 32%  perf-profile.self.cycles-pp.tick_sched_timer
      0.00            +0.1        0.14 ± 26%  perf-profile.self.cycles-pp.rebalance_domains
      0.00            +0.1        0.14 ± 31%  perf-profile.self.cycles-pp.__do_softirq
      0.00            +0.1        0.14 ± 21%  perf-profile.self.cycles-pp.note_gp_changes
      0.00            +0.2        0.15 ± 27%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.00            +0.2        0.16 ± 40%  perf-profile.self.cycles-pp.cpuidle_reflect
      0.00            +0.2        0.16 ± 14%  perf-profile.self.cycles-pp.cpu_util
      0.00            +0.2        0.16 ± 36%  perf-profile.self.cycles-pp.acpi_idle_enter
      0.00            +0.2        0.16 ± 21%  perf-profile.self.cycles-pp.load_balance
      0.00            +0.2        0.16 ± 18%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.2        0.17 ± 26%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.2        0.17 ± 16%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.00            +0.2        0.18 ± 12%  perf-profile.self.cycles-pp.call_cpuidle
      0.00            +0.2        0.18 ± 23%  perf-profile.self.cycles-pp.ct_nmi_enter
      0.00            +0.2        0.19 ± 32%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.2        0.19 ± 25%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.2        0.20 ± 27%  perf-profile.self.cycles-pp.check_cpu_stall
      0.00            +0.2        0.20 ± 30%  perf-profile.self.cycles-pp.trigger_load_balance
      0.00            +0.2        0.20 ± 27%  perf-profile.self.cycles-pp.error_entry
      0.00            +0.2        0.20 ± 31%  perf-profile.self.cycles-pp.perf_pmu_nop_void
      0.00            +0.2        0.21 ± 16%  perf-profile.self.cycles-pp.__memcpy
      0.00            +0.2        0.21 ± 27%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.2        0.21 ± 34%  perf-profile.self.cycles-pp._find_next_and_bit
      0.00            +0.2        0.21 ± 43%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.00            +0.2        0.24 ± 25%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.00            +0.3        0.26 ± 14%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.3        0.28 ± 33%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.3        0.28 ± 42%  perf-profile.self.cycles-pp.perf_rotate_context
      0.00            +0.3        0.29 ± 17%  perf-profile.self.cycles-pp.timerqueue_add
      0.00            +0.3        0.30 ± 24%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.3        0.32 ± 22%  perf-profile.self.cycles-pp.irq_enter_rcu
      0.00            +0.3        0.32 ± 28%  perf-profile.self.cycles-pp.scheduler_tick
      0.30 ±  2%      +0.3        0.62 ± 13%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.3        0.33 ± 12%  perf-profile.self.cycles-pp.irq_work_tick
      0.00            +0.4        0.35 ± 17%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.4        0.36 ± 22%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.00            +0.4        0.36 ± 18%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.4        0.37 ± 26%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.4        0.39 ± 45%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.4        0.39 ± 23%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.4        0.40 ± 15%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.4        0.41 ± 21%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.4        0.43 ± 14%  perf-profile.self.cycles-pp.cpuidle_enter
      0.00            +0.4        0.44 ± 22%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.00            +0.5        0.49 ± 15%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +0.5        0.51 ± 14%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.00            +0.6        0.58 ±  9%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.00            +0.7        0.66 ± 10%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.7        0.69 ±  8%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.00            +0.9        0.88 ±  6%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.00            +0.9        0.90 ± 13%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +1.0        1.00 ±  9%  perf-profile.self.cycles-pp.menu_select
      0.00            +1.0        1.02 ± 67%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.00            +1.0        1.04 ± 14%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +1.1        1.10 ± 41%  perf-profile.self.cycles-pp.ktime_get
      0.00            +1.2        1.22 ±  4%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +1.2        1.24 ±  9%  perf-profile.self.cycles-pp.read_tsc
      0.00            +1.5        1.48 ± 14%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +1.8        1.76 ± 11%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +2.4        2.35 ± 12%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.00            +3.7        3.69 ±  5%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.05 ±  8%      +9.2        9.29 ±  7%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.00           +48.2       48.17 ±  2%  perf-profile.self.cycles-pp.acpi_safe_halt


***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/splice/stress-ng/60s

commit: 
  19e3e6cdfd ("accessibility: speakup: refactor deprecated strncpy")
  1b057bd800 ("drivers/char/mem: implement splice() for /dev/zero, /dev/full")

19e3e6cdfdc73400 1b057bd800c3ea0c926191d7950 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.98            -3.3%       2.88        iostat.cpu.system
      0.51            +0.1        0.60 ±  2%  mpstat.cpu.all.usr%
      0.40           -10.1%       0.36 ±  3%  turbostat.IPC
      0.01 ± 55%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.pipe_write.vfs_write.ksys_write
      0.02 ± 56%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.pipe_write.vfs_write.ksys_write
     65093           +70.3%     110836        stress-ng.splice.MB_per_sec_splice_rate
  10307909           +38.9%   14322626 ±  4%  stress-ng.splice.ops
    171798           +38.9%     238710 ±  4%  stress-ng.splice.ops_per_sec
  1.71e+08           +39.3%  2.383e+08 ±  2%  proc-vmstat.numa_hit
 1.751e+08 ±  2%     +35.5%  2.372e+08 ±  2%  proc-vmstat.numa_local
 1.652e+08           +43.1%  2.364e+08 ±  2%  proc-vmstat.pgalloc_normal
 1.652e+08           +43.1%  2.363e+08 ±  2%  proc-vmstat.pgfree
      0.05 ±  4%     +10.8%       0.06 ±  2%  perf-stat.i.MPKI
 1.277e+09           -15.1%  1.085e+09 ±  2%  perf-stat.i.branch-instructions
      0.71            +0.3        0.96        perf-stat.i.branch-miss-rate%
  10496910           +14.8%   12053487 ±  2%  perf-stat.i.branch-misses
      0.75           +13.7%       0.85 ±  2%  perf-stat.i.cpi
      0.00 ±  7%      +0.0        0.00 ±  6%  perf-stat.i.dTLB-load-miss-rate%
 1.831e+09           -15.0%  1.557e+09 ±  2%  perf-stat.i.dTLB-loads
 1.124e+09           -11.5%   9.94e+08 ±  2%  perf-stat.i.dTLB-stores
     89.35            +1.7       91.10        perf-stat.i.iTLB-load-miss-rate%
   4833975 ±  5%     +26.6%    6118619 ±  9%  perf-stat.i.iTLB-load-misses
 6.665e+09           -11.6%  5.892e+09 ±  2%  perf-stat.i.instructions
      1534 ±  4%     -25.7%       1140 ±  5%  perf-stat.i.instructions-per-iTLB-miss
      1.34           -11.8%       1.18 ±  3%  perf-stat.i.ipc
    117.54           -14.1%     100.98 ±  2%  perf-stat.i.metric.M/sec
      0.06 ±  3%     +16.3%       0.07 ±  2%  perf-stat.overall.MPKI
      0.82            +0.3        1.11        perf-stat.overall.branch-miss-rate%
      0.75           +13.2%       0.84 ±  2%  perf-stat.overall.cpi
      0.00 ±  6%      +0.0        0.00 ±  6%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  5%      +0.0        0.00 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
     90.21            +1.9       92.08        perf-stat.overall.iTLB-load-miss-rate%
      1382 ±  5%     -29.9%     968.76 ±  6%  perf-stat.overall.instructions-per-iTLB-miss
      1.34           -11.6%       1.19 ±  3%  perf-stat.overall.ipc
 1.257e+09           -15.1%  1.068e+09 ±  2%  perf-stat.ps.branch-instructions
  10335583           +14.8%   11864548 ±  2%  perf-stat.ps.branch-misses
 1.802e+09           -15.0%  1.532e+09 ±  2%  perf-stat.ps.dTLB-loads
 1.106e+09           -11.5%  9.783e+08 ±  2%  perf-stat.ps.dTLB-stores
   4757545 ±  5%     +26.6%    6022044 ±  9%  perf-stat.ps.iTLB-load-misses
 6.559e+09           -11.6%  5.799e+09 ±  2%  perf-stat.ps.instructions
 4.149e+11           -11.6%  3.668e+11 ±  2%  perf-stat.total.instructions
     29.20 ± 11%     -29.2        0.00        perf-profile.calltrace.cycles-pp.write
     28.74 ± 11%     -28.7        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     28.67 ± 11%     -28.7        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     28.57 ± 11%     -28.6        0.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     28.41 ± 11%     -28.4        0.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     27.88 ± 11%     -27.9        0.00        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.96 ± 11%     -12.0        0.00        perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
     11.62 ± 12%     -11.6        0.00        perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
     11.58 ± 11%     -11.6        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages.pipe_write.vfs_write.ksys_write.do_syscall_64
      9.48 ± 12%      -9.5        0.00        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write
      9.47 ±  9%      -9.5        0.00        perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge.__folio_put.__splice_from_pipe.splice_from_pipe.do_splice
      9.90 ±  9%      -8.9        0.97 ± 17%  perf-profile.calltrace.cycles-pp.__folio_put.__splice_from_pipe.splice_from_pipe.do_splice.__do_splice
      8.42 ± 11%      -8.4        0.00        perf-profile.calltrace.cycles-pp.rep_movs_alternative.copyin._copy_from_iter.copy_page_from_iter.pipe_write
      7.82 ±  9%      -7.8        0.00        perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge.__folio_put.__splice_from_pipe.splice_from_pipe
     16.11 ±  9%      -6.1        9.97 ±  8%  perf-profile.calltrace.cycles-pp.__splice_from_pipe.splice_from_pipe.do_splice.__do_splice.__x64_sys_splice
     16.43 ±  9%      -6.0       10.44 ±  7%  perf-profile.calltrace.cycles-pp.splice_from_pipe.do_splice.__do_splice.__x64_sys_splice.do_syscall_64
      5.34 ± 12%      -5.3        0.00        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.pipe_write.vfs_write.ksys_write
      0.41 ± 71%      +0.4        0.81 ± 16%  perf-profile.calltrace.cycles-pp.pipe_double_lock.splice_pipe_to_pipe.do_splice.__do_splice.__x64_sys_splice
      1.01 ±  8%      +0.4        1.45 ±  4%  perf-profile.calltrace.cycles-pp.free_unref_page_prepare.free_unref_page.__splice_from_pipe.splice_from_pipe.do_splice
      1.02 ± 14%      +0.5        1.48 ± 11%  perf-profile.calltrace.cycles-pp._raw_spin_trylock.free_unref_page.__splice_from_pipe.splice_from_pipe.do_splice
      0.18 ±141%      +0.5        0.65 ± 11%  perf-profile.calltrace.cycles-pp.get_pfnblock_flags_mask.free_unref_page_prepare.free_unref_page.__splice_from_pipe.splice_from_pipe
      0.28 ±100%      +0.5        0.75 ± 16%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_double_lock.splice_pipe_to_pipe.do_splice.__do_splice
      0.86 ± 19%      +0.5        1.33 ± 11%  perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.__splice_from_pipe.splice_from_pipe.do_splice
      0.17 ±141%      +0.5        0.69 ± 17%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.splice
      0.08 ±223%      +0.5        0.62 ± 10%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
      1.36 ± 18%      +0.7        2.03 ±  9%  perf-profile.calltrace.cycles-pp.__fget_light.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
      0.00            +0.8        0.80 ±  9%  perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_node.__kmalloc.copy_splice_read.splice_file_to_pipe.do_splice
      0.00            +1.1        1.06 ±  7%  perf-profile.calltrace.cycles-pp.__kmalloc.copy_splice_read.splice_file_to_pipe.do_splice.__do_splice
      0.09 ±223%      +1.1        1.20 ±  8%  perf-profile.calltrace.cycles-pp.vfs_splice_read.splice_file_to_pipe.do_splice.__do_splice.__x64_sys_splice
      3.43 ± 10%      +1.4        4.79 ±  7%  perf-profile.calltrace.cycles-pp.splice_pipe_to_pipe.do_splice.__do_splice.__x64_sys_splice.do_syscall_64
      3.59 ± 12%      +1.8        5.37 ±  6%  perf-profile.calltrace.cycles-pp.free_unref_page.__splice_from_pipe.splice_from_pipe.do_splice.__do_splice
      4.06 ± 13%      +2.1        6.12 ±  5%  perf-profile.calltrace.cycles-pp.__entry_text_start.splice
      0.00            +2.2        2.20 ± 10%  perf-profile.calltrace.cycles-pp.generic_pipe_buf_release.__splice_from_pipe.splice_from_pipe.do_splice.__do_splice
      0.00            +2.3        2.33 ±  4%  perf-profile.calltrace.cycles-pp.__alloc_pages_bulk.copy_splice_read.splice_file_to_pipe.do_splice.__do_splice
      0.00           +18.4       18.44 ± 11%  perf-profile.calltrace.cycles-pp.iov_iter_zero.read_iter_zero.copy_splice_read.splice_file_to_pipe.do_splice
      0.00           +19.0       19.02 ± 10%  perf-profile.calltrace.cycles-pp.read_iter_zero.copy_splice_read.splice_file_to_pipe.do_splice.__do_splice
     21.46 ±  9%     +22.8       44.25 ±  6%  perf-profile.calltrace.cycles-pp.do_splice.__do_splice.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.01 ±  9%     +23.1       45.09 ±  6%  perf-profile.calltrace.cycles-pp.__do_splice.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
     24.22 ±  9%     +24.3       48.48 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
     25.33 ±  9%     +24.8       50.10 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
     26.16 ±  9%     +25.2       51.36 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.splice
      0.00           +25.2       25.21 ±  8%  perf-profile.calltrace.cycles-pp.copy_splice_read.splice_file_to_pipe.do_splice.__do_splice.__x64_sys_splice
      0.54 ± 46%     +26.7       27.26 ±  7%  perf-profile.calltrace.cycles-pp.splice_file_to_pipe.do_splice.__do_splice.__x64_sys_splice.do_syscall_64
     32.15 ± 10%     +27.9       60.02 ±  5%  perf-profile.calltrace.cycles-pp.splice
     29.33 ± 11%     -29.3        0.00        perf-profile.children.cycles-pp.write
     28.59 ± 11%     -28.6        0.00        perf-profile.children.cycles-pp.ksys_write
     28.44 ± 11%     -28.4        0.00        perf-profile.children.cycles-pp.vfs_write
     28.01 ± 11%     -28.0        0.00        perf-profile.children.cycles-pp.pipe_write
     12.00 ± 11%     -12.0        0.00        perf-profile.children.cycles-pp.copy_page_from_iter
     11.30 ± 11%     -11.3        0.00        perf-profile.children.cycles-pp._copy_from_iter
     11.73 ± 11%     -11.1        0.59 ±  9%  perf-profile.children.cycles-pp.__alloc_pages
     10.36 ± 11%     -10.4        0.00        perf-profile.children.cycles-pp.copyin
      9.51 ±  9%      -9.1        0.37 ± 16%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge
     10.02 ±  9%      -8.9        1.12 ± 16%  perf-profile.children.cycles-pp.__folio_put
      8.62 ± 11%      -8.6        0.00        perf-profile.children.cycles-pp.rep_movs_alternative
      8.03 ±  9%      -8.0        0.00        perf-profile.children.cycles-pp.uncharge_batch
     16.19 ±  9%      -6.1       10.09 ±  8%  perf-profile.children.cycles-pp.__splice_from_pipe
     16.44 ±  9%      -6.0       10.45 ±  7%  perf-profile.children.cycles-pp.splice_from_pipe
      5.42 ± 12%      -5.0        0.38 ±  8%  perf-profile.children.cycles-pp.get_page_from_freelist
      4.21 ± 11%      -3.9        0.27 ± 18%  perf-profile.children.cycles-pp.rmqueue
      2.85 ±  9%      -1.1        1.74 ± 10%  perf-profile.children.cycles-pp._raw_spin_trylock
      1.04 ± 12%      -1.0        0.06 ± 59%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.23 ± 14%      -0.1        0.15 ± 33%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.06 ± 50%      +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.pipe_clear_nowait
      0.23 ±  7%      +0.1        0.32 ± 11%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.10 ± 17%      +0.1        0.20 ± 15%  perf-profile.children.cycles-pp.clock_gettime
      0.28 ± 15%      +0.1        0.39 ± 13%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.40 ± 14%      +0.2        0.55 ± 14%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.35 ± 15%      +0.2        0.53 ± 13%  perf-profile.children.cycles-pp.stress_splice
      0.28 ± 18%      +0.2        0.46 ± 10%  perf-profile.children.cycles-pp.get_pipe_info
      0.00            +0.2        0.18 ± 14%  perf-profile.children.cycles-pp.kmalloc_slab
      0.62 ± 11%      +0.2        0.82 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.02 ±  8%      +0.2        1.23 ± 10%  perf-profile.children.cycles-pp.mutex_unlock
      0.00            +0.2        0.24 ± 23%  perf-profile.children.cycles-pp.kfree
      0.53 ± 19%      +0.2        0.77 ± 14%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.59 ± 13%      +0.2        0.84 ± 15%  perf-profile.children.cycles-pp.pipe_double_lock
      0.00            +0.3        0.31 ± 18%  perf-profile.children.cycles-pp.memset_orig
      0.52 ± 22%      +0.3        0.85 ±  7%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.00            +0.4        0.39 ± 18%  perf-profile.children.cycles-pp.__kmem_cache_free
      1.06 ±  9%      +0.4        1.46 ±  4%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.60 ± 18%      +0.4        1.00 ±  7%  perf-profile.children.cycles-pp.security_file_permission
      0.96 ± 17%      +0.5        1.48 ± 10%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.24 ± 19%      +0.5        0.76 ± 11%  perf-profile.children.cycles-pp.__fsnotify_parent
      1.17 ±  7%      +0.5        1.72 ± 10%  perf-profile.children.cycles-pp.mutex_lock
      1.44 ± 18%      +0.6        2.04 ±  9%  perf-profile.children.cycles-pp.__fget_light
      1.78 ± 10%      +0.7        2.48 ±  7%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.41 ± 18%      +0.8        1.21 ±  9%  perf-profile.children.cycles-pp.vfs_splice_read
      0.00            +0.8        0.83 ± 10%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      2.96 ± 12%      +1.0        3.97 ±  5%  perf-profile.children.cycles-pp.__entry_text_start
      0.00            +1.1        1.07 ±  8%  perf-profile.children.cycles-pp.__kmalloc
      3.46 ± 10%      +1.3        4.80 ±  7%  perf-profile.children.cycles-pp.splice_pipe_to_pipe
      3.68 ± 11%      +1.8        5.43 ±  6%  perf-profile.children.cycles-pp.free_unref_page
      0.00            +2.3        2.27 ± 11%  perf-profile.children.cycles-pp.generic_pipe_buf_release
      0.00            +2.3        2.34 ±  4%  perf-profile.children.cycles-pp.__alloc_pages_bulk
      0.00           +18.5       18.47 ± 11%  perf-profile.children.cycles-pp.iov_iter_zero
      0.00           +19.1       19.09 ± 10%  perf-profile.children.cycles-pp.read_iter_zero
     21.49 ±  9%     +22.8       44.32 ±  6%  perf-profile.children.cycles-pp.do_splice
     22.11 ±  9%     +23.2       45.27 ±  6%  perf-profile.children.cycles-pp.__do_splice
     24.25 ±  9%     +24.3       48.54 ±  6%  perf-profile.children.cycles-pp.__x64_sys_splice
      0.00           +25.2       25.24 ±  8%  perf-profile.children.cycles-pp.copy_splice_read
      0.62 ± 17%     +26.7       27.29 ±  7%  perf-profile.children.cycles-pp.splice_file_to_pipe
     32.06 ± 10%     +28.0       60.02 ±  5%  perf-profile.children.cycles-pp.splice
      8.29 ± 11%      -8.3        0.00        perf-profile.self.cycles-pp.rep_movs_alternative
      2.16 ± 17%      -2.0        0.11 ± 10%  perf-profile.self.cycles-pp.rmqueue
      1.56 ± 18%      -1.4        0.17 ± 19%  perf-profile.self.cycles-pp.__alloc_pages
      1.25 ± 17%      -1.1        0.11 ± 31%  perf-profile.self.cycles-pp.get_page_from_freelist
      2.79 ±  9%      -1.1        1.72 ±  9%  perf-profile.self.cycles-pp._raw_spin_trylock
      1.00 ± 12%      -1.0        0.05 ± 79%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.06 ± 52%      +0.0        0.09 ± 26%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.06 ± 49%      +0.0        0.10 ± 17%  perf-profile.self.cycles-pp.pipe_clear_nowait
      0.08 ± 19%      +0.1        0.18 ± 16%  perf-profile.self.cycles-pp.clock_gettime
      0.28 ± 15%      +0.1        0.38 ± 13%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.21 ± 18%      +0.1        0.32 ± 11%  perf-profile.self.cycles-pp.get_pipe_info
      0.33 ± 13%      +0.1        0.44 ± 10%  perf-profile.self.cycles-pp.do_syscall_64
      0.17 ±  8%      +0.1        0.31 ±  9%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.30 ± 20%      +0.1        0.43 ± 15%  perf-profile.self.cycles-pp.stress_splice
      0.16 ± 32%      +0.1        0.29 ±  8%  perf-profile.self.cycles-pp.stress_time_now_timespec
      0.30 ± 16%      +0.1        0.44 ±  9%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.40 ± 14%      +0.2        0.55 ± 14%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.2        0.18 ± 12%  perf-profile.self.cycles-pp.kmalloc_slab
      0.01 ±223%      +0.2        0.19 ± 14%  perf-profile.self.cycles-pp.vfs_splice_read
      0.49 ± 19%      +0.2        0.71 ± 13%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.2        0.23 ± 25%  perf-profile.self.cycles-pp.kfree
      0.58 ±  9%      +0.2        0.82 ±  7%  perf-profile.self.cycles-pp.free_unref_page_prepare
      0.43 ± 17%      +0.3        0.68 ±  6%  perf-profile.self.cycles-pp.__do_splice
      0.03 ±100%      +0.3        0.31 ± 17%  perf-profile.self.cycles-pp.splice_file_to_pipe
      0.66 ±  4%      +0.3        0.94 ± 10%  perf-profile.self.cycles-pp.free_unref_page
      0.43 ± 20%      +0.3        0.72 ± 10%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.50 ± 20%      +0.3        0.80 ± 11%  perf-profile.self.cycles-pp.do_splice
      0.00            +0.3        0.30 ± 16%  perf-profile.self.cycles-pp.memset_orig
      0.91 ±  9%      +0.4        1.28 ± 12%  perf-profile.self.cycles-pp.mutex_lock
      1.40 ± 14%      +0.4        1.77 ±  5%  perf-profile.self.cycles-pp.__entry_text_start
      0.00            +0.4        0.39 ± 18%  perf-profile.self.cycles-pp.__kmem_cache_free
      0.98 ± 14%      +0.4        1.38 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.72 ± 14%      +0.4        1.13 ± 15%  perf-profile.self.cycles-pp.__x64_sys_splice
      0.84 ± 14%      +0.4        1.28 ± 10%  perf-profile.self.cycles-pp.__splice_from_pipe
      0.00            +0.4        0.44 ± 15%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.83 ± 17%      +0.5        1.31 ±  9%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.24 ± 20%      +0.5        0.76 ± 12%  perf-profile.self.cycles-pp.__fsnotify_parent
      1.66 ± 14%      +0.5        2.20 ±  9%  perf-profile.self.cycles-pp.splice_pipe_to_pipe
      1.42 ± 17%      +0.6        1.99 ±  9%  perf-profile.self.cycles-pp.__fget_light
      1.74 ± 10%      +0.7        2.41 ±  8%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.7        0.68 ± 10%  perf-profile.self.cycles-pp.read_iter_zero
      1.99 ± 13%      +1.1        3.08 ±  5%  perf-profile.self.cycles-pp.splice
      0.00            +1.3        1.33 ±  7%  perf-profile.self.cycles-pp.__alloc_pages_bulk
      0.00            +2.0        2.01 ±  7%  perf-profile.self.cycles-pp.copy_splice_read
      0.00            +2.2        2.22 ± 11%  perf-profile.self.cycles-pp.generic_pipe_buf_release
      0.00           +18.4       18.38 ± 11%  perf-profile.self.cycles-pp.iov_iter_zero





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

