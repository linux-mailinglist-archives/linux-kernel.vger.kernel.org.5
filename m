Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C8E79A376
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjIKGZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjIKGZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:25:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D63B118
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694413518; x=1725949518;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=qkaEOIvZjGPutL3Yj2gkEIx1y4HpKXYwBNXQ9EBRl6U=;
  b=KvRlp7VURsPw37Szyt1YnZqtjZgvtTfV4pl6z+LhVemp7BuO8FgwfM21
   MuBhsdIlLqd9oKZf1z1Zc1tUe7xAQ4hBu7i2OrKDGbDkn4uv4t4Pd+Hvo
   owX38y/uJLX8u02N4JwMdCY25qlG0GkFdpWPBcJddtjMara0MoTnrx3q2
   +PY8yWrjvRsfiMH+VyAElmqjXgR9fUfaNYxFj5zjzGClO5nfqhZIjRKQe
   rPi5MnfYIKKDerrRF1sE0pJhEjWvfjfrq1SRrzaWg7e//RnSa4k5B5WOd
   7MnwUVJQxtRn2ZcA7KH6szDx3rdzG6vR+TOBYjyma/nRJQbPFpHB4cyJw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="368244601"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="368244601"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 23:25:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="808713195"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="808713195"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2023 23:25:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 10 Sep 2023 23:25:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 10 Sep 2023 23:25:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 10 Sep 2023 23:25:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNn9yK2k/R74OG7J325wJx6iNWAc6OV6cSVrywDKwXiOzkyY5F6X250YkPBUJM9bRl8lkeJ3aPqaBxrP32LV748JFm7x0oj+8z+f7CvZ6mKSmBSD2C7cSCTToQOvNG9sWEyF/H3Fh1AEAsmH6MBeFOdjnn4M6HeXaMFNwtzCYqowJM1bhbVh1rzj8E/Ew7PoTysi7zTNJxNT2T4v67kZnHHB6TGt/lpHwIrANTZDjGokpdu3P0fyf1b2EBpJ5xOAkVtJbi9sY8A32cJ8S2FZDy2CeKxS58EGR8o6IFMsQ+ljzlH54gLyZ+5GvjJjaJHL+Dczd2ZJdsXlz8yiEPfwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHJpKdw5bgdp6wXUsFnoJTNVce6WvI1j5TPmk/3ykRI=;
 b=mp8248JkV5hofErPsDyivKZjv0URdYXd9WSoZaM92eGYV9nQcXh62KToG8YetnEKuf2yZWKaMMpUw06Lowr1rFcYOJ10nKiL5BtnIohzBfEQWojenBgxloXZfi43YdlsYLkI3xHpg/YBarpUS39CEw8RN2g/tXlBgH0qNZVNrIAEhnecAYHLrbWiRa059pTQ01YgbqazEQphteysvVPkcQKll05li7aYKbsYz3yiHVYQpwBoHNKIcSxIraYXM7jyzvbgEe6oG2JfBlCuq2QsEdoNuTtVYuEVrc0e11S+dW4wSNxXrktb8gZYxmXq8H1fqwrhozCU/ZrJGUMD6zvg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CO1PR11MB4833.namprd11.prod.outlook.com (2603:10b6:303:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 06:25:11 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 06:25:10 +0000
Date:   Mon, 11 Sep 2023 14:24:59 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>,
        <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [maple_tree]  17983dc617:
 stress-ng.mmapmany.ops_per_sec 21.4% improvement
Message-ID: <202309111405.694eddb1-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CO1PR11MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1ad13c-74e1-4bb2-1373-08dbb28fd966
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZ9ov8Zf51cDGmwlMpVtWY/HZxstQTdTzedeLbMljPTa6l0f7Xz/Lfjs+CUodp6HftxtpnjmWe/bzVidd5hfOKoY582mIUzV1Afoxijg/rVlh6gK5vZARsobqmL7ZZ6gmDLzNTbgQ2BsiiJ820fXqJfMJOJdtUZ3oHUhtdr9O8JXIP0y3yNNIwYsl70/TeMZ3c08PoWwHerMEBuNZbIxJS1eC4mfQr8xLSvR7ohE8KgzzonXsm1uimuJIXQp9LOFWQ/Imf0wFUIAVJ1+13XijjQOa1l2LCSe+9uc5FZ9pk55/1mOdm7m8+QBzlJukNEBt521HOghEvkrCP+5J3/kUpz0rWdqTNEoOsI1CxdyWUClm6QxsxwZOcAasPMwAQjJl5X5uJKFzz39DFzJnZExYBc2KhRqJ8BIa97b0SXbOB0QM0Bv7tv0gNYvUSuJOh13b97eMXbtl5aLyht1cLLC7N4J/iZYlq4IDjIm3MEdMe/ZJXcVTWQSMiXcj2FbOBb7kWwwj9GMgZFqmpVDOHfVFTubXP3PDL6bE5bskXTzdH5qtoFGwUmfRCpPWluJsDXIASmkXQKg2THTs6mflH5fHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(186009)(1800799009)(451199024)(6666004)(6486002)(6506007)(82960400001)(36756003)(86362001)(38100700002)(1076003)(107886003)(2616005)(30864003)(2906002)(966005)(19627235002)(6512007)(83380400001)(478600001)(41300700001)(316002)(8676002)(8936002)(4326008)(5660300002)(26005)(6916009)(66946007)(66556008)(66476007)(54906003)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5UHpzvxVJSWktfHJLtHe9grhF7HWP3oEWg8Tx3Er1d/TMbIp+kMbtrteoC?=
 =?iso-8859-1?Q?yTrNDwitUuNZBTjVGV51MkW8AOuKpwXYSB0jy8P4QIJjvUC/2eZ4fASYma?=
 =?iso-8859-1?Q?BtxGmJJZOIPZg5W58IJZhBfKuBw439JlCEaH0nfZs2dKnnAWs15QhCIDmI?=
 =?iso-8859-1?Q?Wl0mzhDWXCQM+q2uLSqjZtgk2ehDGkc8c4elTdgsn5WfSdyO7jycUhE10s?=
 =?iso-8859-1?Q?dcIp4ANyfGggkehxm4c+0bmDBeOS7J/IRlUnoPqnb9CpgVtBCj900Cp/Rm?=
 =?iso-8859-1?Q?GRVV2vD5qCoW1Pfu5SFogObSNHE8k34V49hbMl5M1BRI6+r4NxYh8y/MCC?=
 =?iso-8859-1?Q?jHEh3pghSZWWKnToidSjUpy/ofPkYdz/EEo2eESrLmOOhPIaF+Pabzljm3?=
 =?iso-8859-1?Q?w4DNHcYJySgwizauAZVNiuOpfOzld5BSOu+GrR4qse2e16Cxi4DCNxQO8Q?=
 =?iso-8859-1?Q?d9VMH8Du0LXkXt3hT0EXpOhArdSa+j4a/nRvB8RGXVR5FPh38idlvkt07K?=
 =?iso-8859-1?Q?izUiP7pMZt83lLn4yUG85uejvlhW01B/Olwq7do+mV0J+CspEusD8Px5Qa?=
 =?iso-8859-1?Q?svSxgo5Ur452stcCti6pWdIQZ6MlkcGuSW3KO5QLJgGVKESeXT7k7eojir?=
 =?iso-8859-1?Q?kMCQrvDOn28N9biSVFaSmpL5cHy+51ilFj4J/BBSrtqtTbuclShnbzHN4m?=
 =?iso-8859-1?Q?ZZYydssVIeQRwNDGt/cKJwkdr02Kv6yedDCvGjHKQSURZXmKUr5rF4SfaZ?=
 =?iso-8859-1?Q?pfCZgsH/CMHtj4HFrOaIvId33HhR50KSBe2Hq66K4MbHby34B7j+AYh8TH?=
 =?iso-8859-1?Q?m2bGzIAXvTdyZnS5NMxuq6QqQanEA6I1bNAYlpcuNGwK/D51rzzJQb24/B?=
 =?iso-8859-1?Q?FSTKpxmPF+Yon3OffIXQ/CnATqpAmavtkoXTqCoZJKf+vLonpt80orRQAI?=
 =?iso-8859-1?Q?DW1PfkG6+aH19PlVtXwEix9flb2mOOElOu4iHE/+uMjrZciE5m0ZzFmrb+?=
 =?iso-8859-1?Q?GNfJT0GDs2UtLrz1heVrieNF3EmYpb3LNQs7FW8/HMGU5IoiqIuPwK/8+F?=
 =?iso-8859-1?Q?1Zbvc6KTajKem39FdNcjrzx8KaprT1FA925K2SGihynEaq6tCRCn40ZJAZ?=
 =?iso-8859-1?Q?37GgAje9HWEbjQYHZrQwUEszGHtGn5pAND3cfftwr7daxhwpexumSy5lNI?=
 =?iso-8859-1?Q?RtZ1Vy0TMGPs8+jzp1WSVjwPxwMSYs5YWGECcueJ4n1kp8mnicpHD2u7Rb?=
 =?iso-8859-1?Q?Ile/XB9LYThihtllsdiHfLgY2YhY3Qylhs1jTa1Nbh/vGBueRnsy2MLBXj?=
 =?iso-8859-1?Q?g1S+ppLj/R3narIYxyH2TC1wwSYcO2gf2BlVK7Nu7TAnChm6UM+erTiDJh?=
 =?iso-8859-1?Q?Joiypfnm+O6WJn1M9ntcDo8thjBgfevxL2RLFf+G+QXg+g74kEZwap0ShS?=
 =?iso-8859-1?Q?TLbfs3cwP3M2rKoIEfl2l3hMa6Jt3oOFISBS5HDJeZ7Y+HK1XyO9Fgr2lN?=
 =?iso-8859-1?Q?2BCRaVwu4Z+XYQRcduX+inB6ViZQG48LhsB6YMiqFTXoqFlZ7aFYcV4uD9?=
 =?iso-8859-1?Q?LxpxKhLTX7XM8VuuyFgcktA+Nx1wVg2gw6a+sj87JFjRTUB/FyQY3QYybu?=
 =?iso-8859-1?Q?fZP+YhsfTLYjO//gEJZwSSoh2126eZwT2vo1kP7+XdzmkNxWYp7uB+Iw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1ad13c-74e1-4bb2-1373-08dbb28fd966
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 06:25:10.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GY+8gxos/yLzaTsIGflRChB3XX4w45Jf4EkCdYmYiSyz3zh4veFWDwWd2LyG1CXXsNrQnTkuJbHtsm+S8LB3Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4833
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 21.4% improvement of stress-ng.mmapmany.ops_per_sec on:


commit: 17983dc617837a588a52848ab4034d8efa6c1fa6 ("maple_tree: refine mas_preallocate() node calculations")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	class: vm
	test: mmapmany
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.tmpfs.ops_per_sec 7.4% improvement                                         |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory       |
| test parameters  | class=memory                                                                                    |
|                  | cpufreq_governor=performance                                                                    |
|                  | nr_threads=100%                                                                                 |
|                  | test=tmpfs                                                                                      |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.tmpfs.ops_per_sec 4.9% improvement                                         |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | class=memory                                                                                    |
|                  | cpufreq_governor=performance                                                                    |
|                  | nr_threads=1                                                                                    |
|                  | test=tmpfs                                                                                      |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230911/202309111405.694eddb1-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  vm/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/mmapmany/stress-ng/60s

commit: 
  0b8bb544b1 ("maple_tree: update mas_preallocate() testing")
  17983dc617 ("maple_tree: refine mas_preallocate() node calculations")

0b8bb544b1a7051c 17983dc617837a588a52848ab40 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      7362 ±  4%      -7.8%       6789 ±  5%  numa-meminfo.node1.KernelStack
    681.00 ± 19%     +32.5%     902.17 ±  7%  perf-c2c.DRAM.local
     41025 ±  8%     -12.4%      35932 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
     71.82            +3.2%      74.12        turbostat.RAMWatt
      0.84            +0.2        1.03        mpstat.cpu.all.soft%
      0.52            +0.1        0.59        mpstat.cpu.all.usr%
  22458133 ±  9%     +23.4%   27716537 ±  4%  numa-numastat.node0.local_node
  22475498 ±  9%     +23.5%   27757901 ±  4%  numa-numastat.node0.numa_hit
  24279266 ±  9%     +18.9%   28860960 ±  4%  numa-numastat.node1.local_node
  24328316 ±  9%     +18.8%   28904203 ±  4%  numa-numastat.node1.numa_hit
  22475366 ±  9%     +23.5%   27757954 ±  4%  numa-vmstat.node0.numa_hit
  22458001 ±  9%     +23.4%   27716590 ±  4%  numa-vmstat.node0.numa_local
      7364 ±  4%      -7.8%       6790 ±  5%  numa-vmstat.node1.nr_kernel_stack
  24328157 ±  9%     +18.8%   28904271 ±  4%  numa-vmstat.node1.numa_hit
  24279107 ±  9%     +18.9%   28861028 ±  4%  numa-vmstat.node1.numa_local
  46805781           +21.1%   56665148        proc-vmstat.numa_hit
  46739367           +21.1%   56580541        proc-vmstat.numa_local
     45820 ±  4%      +7.9%      49447        proc-vmstat.pgactivate
  47376998           +20.9%   57300833        proc-vmstat.pgalloc_normal
  45597648           +21.1%   55222396        proc-vmstat.pgfault
  47290647           +20.9%   57193576        proc-vmstat.pgfree
  22636062           +21.3%   27447928        stress-ng.mmapmany.ops
    375584           +21.4%     455871        stress-ng.mmapmany.ops_per_sec
      6904 ±  3%     +15.3%       7963 ±  4%  stress-ng.time.involuntary_context_switches
  45280021           +21.3%   54909557        stress-ng.time.minor_page_faults
    524.33            -1.6%     516.00        stress-ng.time.percent_of_cpu_this_job_got
    313.70            -2.7%     305.32        stress-ng.time.system_time
      0.84 ±220%    +198.0%       2.51 ± 99%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.54 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.do_vmi_align_munmap
      0.50 ± 45%     +48.4%       0.74 ± 15%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.42 ± 50%     +61.5%       0.68 ± 13%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.59 ± 10%     +23.5%       0.73 ±  4%  perf-sched.wait_and_delay.avg.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
     61.67 ± 26%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_write.anon_vma_clone.__split_vma.do_vmi_align_munmap
     84.83 ±  8%     +39.1%     118.00 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.constprop
    137.50 ± 15%     +28.5%     176.67 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.unmap_vmas.unmap_region.constprop.0
      2.14 ± 28%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.do_vmi_align_munmap
      2.21 ± 22%     +29.0%       2.85 ± 15%  perf-sched.wait_and_delay.max.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      1.39 ± 47%     +75.0%       2.43 ± 10%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.58 ± 10%     +27.6%       0.74 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.51 ± 19%     +33.8%       0.68 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.59 ± 10%     +23.5%       0.73 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      1.38 ± 29%     -62.0%       0.52 ± 82%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.vma_expand.mmap_region
      1.27 ± 18%     +35.2%       1.72 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
      2.21 ± 22%     +29.0%       2.85 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      1.59 ± 24%     +50.1%       2.38 ± 22%  perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      6.18            +4.6%       6.46        perf-stat.i.MPKI
 4.765e+09           +10.1%  5.244e+09        perf-stat.i.branch-instructions
      1.03            -0.4        0.59        perf-stat.i.branch-miss-rate%
  48783771           -38.9%   29830374        perf-stat.i.branch-misses
     32.48            +2.5       34.94        perf-stat.i.cache-miss-rate%
  50411568           +22.1%   61552341        perf-stat.i.cache-misses
 1.532e+08           +13.4%  1.737e+08        perf-stat.i.cache-references
      0.91            -6.9%       0.85        perf-stat.i.cpi
    145.81 ±  2%     +13.7%     165.79 ±  3%  perf-stat.i.cpu-migrations
    491.12           -15.9%     412.79        perf-stat.i.cycles-between-cache-misses
      0.02 ±  5%      +0.0        0.02 ±  4%  perf-stat.i.dTLB-load-miss-rate%
   1220238 ±  6%     +19.6%    1459884 ±  4%  perf-stat.i.dTLB-load-misses
 6.037e+09            +9.2%   6.59e+09        perf-stat.i.dTLB-loads
      0.16            +0.0        0.18        perf-stat.i.dTLB-store-miss-rate%
   5543237           +21.2%    6720196        perf-stat.i.dTLB-store-misses
 3.335e+09            +8.9%  3.631e+09        perf-stat.i.dTLB-stores
 2.443e+10            +8.4%  2.647e+10        perf-stat.i.instructions
      1.10            +7.3%       1.18        perf-stat.i.ipc
    484.73           +14.7%     556.13        perf-stat.i.metric.K/sec
    223.26            +9.4%     244.33        perf-stat.i.metric.M/sec
    729194           +21.0%     882664        perf-stat.i.minor-faults
   6157316 ±  6%     +21.5%    7481341 ±  4%  perf-stat.i.node-loads
  11319353 ±  2%     +14.2%   12928670 ±  2%  perf-stat.i.node-stores
    729194           +21.0%     882664        perf-stat.i.page-faults
      6.27            +4.6%       6.56        perf-stat.overall.MPKI
      1.02            -0.5        0.57        perf-stat.overall.branch-miss-rate%
     32.91            +2.5       35.44        perf-stat.overall.cache-miss-rate%
      0.92            -7.1%       0.85        perf-stat.overall.cpi
    443.99           -17.5%     366.31        perf-stat.overall.cycles-between-cache-misses
      0.02 ±  5%      +0.0        0.02 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.17            +0.0        0.18        perf-stat.overall.dTLB-store-miss-rate%
      1.09            +7.6%       1.17        perf-stat.overall.ipc
 4.689e+09           +10.1%  5.161e+09        perf-stat.ps.branch-instructions
  48008846           -38.9%   29356608        perf-stat.ps.branch-misses
  49613598           +22.1%   60578072        perf-stat.ps.cache-misses
 1.508e+08           +13.3%  1.709e+08        perf-stat.ps.cache-references
    143.49 ±  2%     +13.7%     163.15 ±  3%  perf-stat.ps.cpu-migrations
   1200901 ±  6%     +19.6%    1436786 ±  4%  perf-stat.ps.dTLB-load-misses
 5.941e+09            +9.2%  6.486e+09        perf-stat.ps.dTLB-loads
   5455639           +21.2%    6613896        perf-stat.ps.dTLB-store-misses
 3.282e+09            +8.9%  3.574e+09        perf-stat.ps.dTLB-stores
 2.404e+10            +8.4%  2.605e+10        perf-stat.ps.instructions
    717671           +21.0%     868700        perf-stat.ps.minor-faults
   6059815 ±  6%     +21.5%    7362832 ±  4%  perf-stat.ps.node-loads
  11140400 ±  2%     +14.2%   12724002 ±  2%  perf-stat.ps.node-stores
    717672           +21.0%     868701        perf-stat.ps.page-faults
  1.52e+12            +8.3%  1.647e+12        perf-stat.total.instructions
     30.76 ±  2%      -9.4       21.35        perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      8.00 ±  9%      -6.8        1.16 ±  9%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap
      7.44 ±  6%      -6.8        0.61 ±  2%  perf-profile.calltrace.cycles-pp.mas_destroy.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
      8.59 ±  8%      -6.6        1.97 ±  6%  perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      7.53 ± 10%      -6.4        1.11 ±  9%  perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.__split_vma
     11.75 ±  3%      -6.2        5.59        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      6.11 ±  6%      -6.1        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_free_bulk.mas_destroy.mas_store_prealloc.vma_complete.__split_vma
     13.58 ±  2%      -5.9        7.71        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      8.65 ±  8%      -5.8        2.86 ±  4%  perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      5.66 ± 17%      -5.4        0.27 ±100%  perf-profile.calltrace.cycles-pp.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate
      5.94 ±  6%      -3.7        2.22 ±  2%  perf-profile.calltrace.cycles-pp.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      8.05 ±  3%      -3.4        4.62 ±  2%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     60.10            -3.1       56.99        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     10.67            -2.9        7.75 ±  2%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     11.09            -2.9        8.22 ±  2%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     11.22            -2.8        8.38 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     11.25            -2.8        8.41 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
     61.82            -2.8       59.06        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.40            -2.6        9.78 ±  2%  perf-profile.calltrace.cycles-pp.__mmap
     62.62            -2.6       60.04        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     62.66            -2.6       60.08        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     63.10            -2.3       60.82        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     63.38            -2.2       61.16        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      2.59 ±  4%      -2.0        0.54 ±  3%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.mmap_region.do_mmap.vm_mmap_pgoff
     64.19            -2.0       62.16        perf-profile.calltrace.cycles-pp.__munmap
      0.55 ±  6%      +0.1        0.66 ±  6%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.69 ±  2%      +0.1        0.79 ±  4%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.unmap_region.do_vmi_align_munmap
      0.89 ±  5%      +0.1        1.01 ±  3%  perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap
      0.70 ±  6%      +0.1        0.82 ±  4%  perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region
      0.65 ±  2%      +0.1        0.79 ±  2%  perf-profile.calltrace.cycles-pp.mas_wmb_replace.mas_spanning_rebalance.mas_rebalance.mas_wr_bnode.mas_store_gfp
      0.63 ±  6%      +0.1        0.77 ±  3%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.unmap_region
      0.69 ±  8%      +0.2        0.84 ±  3%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.53 ±  3%      +0.2        0.68 ±  4%  perf-profile.calltrace.cycles-pp.mas_push_data.mas_split.mas_wr_bnode.mas_store_prealloc.vma_complete
      0.96 ±  3%      +0.2        1.12 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
      0.74 ±  5%      +0.2        0.90 ±  5%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.69 ±  3%      +0.2        0.86 ±  4%  perf-profile.calltrace.cycles-pp.mas_wmb_replace.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap
      0.70 ±  5%      +0.2        0.88 ±  5%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.69 ±  6%      +0.2        0.88 ±  9%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.92 ±  3%      +0.2        1.12 ±  3%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.unmap_region
      0.77 ±  5%      +0.2        0.97 ±  2%  perf-profile.calltrace.cycles-pp.__count_memcg_events.charge_memcg.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault
      1.20 ±  4%      +0.2        1.41 ±  6%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.88 ±  4%      +0.2        1.08 ±  2%  perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.unmap_region
      0.96 ±  4%      +0.2        1.17 ±  2%  perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      1.07 ±  3%      +0.2        1.28 ±  2%  perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.stress_mmapmany_child
      2.20 ±  3%      +0.2        2.42 ±  2%  perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma
      1.33 ±  4%      +0.2        1.56 ±  4%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region
      0.79 ±  9%      +0.2        1.03 ±  5%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.__folio_alloc.vma_alloc_folio
      1.21 ±  3%      +0.2        1.46 ±  2%  perf-profile.calltrace.cycles-pp.mas_wr_walk.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      1.08 ±  4%      +0.3        1.33 ±  2%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.19 ±  3%      +0.3        1.45 ±  2%  perf-profile.calltrace.cycles-pp.mtree_range_walk.mas_walk.mas_find.do_vmi_munmap.__vm_munmap
      2.55 ±  4%      +0.3        2.80 ±  3%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      2.50 ±  2%      +0.3        2.76        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
      1.41 ±  4%      +0.3        1.68 ±  3%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      1.48 ±  5%      +0.3        1.75 ±  4%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      1.38 ±  3%      +0.3        1.66 ±  2%  perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      1.32 ±  3%      +0.3        1.60 ±  2%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      0.88 ± 12%      +0.3        1.16 ± 11%  perf-profile.calltrace.cycles-pp.free_unref_page_list.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region
      0.49 ± 46%      +0.3        0.77 ±  2%  perf-profile.calltrace.cycles-pp.folio_add_new_anon_rmap.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.30 ±  2%      +0.3        1.61 ±  3%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.65 ±  4%      +0.3        1.96 ±  3%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      1.59 ±  5%      +0.3        1.91 ±  2%  perf-profile.calltrace.cycles-pp.mas_rev_awalk.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_topdown.get_unmapped_area
      0.83 ±  6%      +0.3        1.15 ±  9%  perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap
      5.43 ±  2%      +0.3        5.75 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.47 ±  2%      +0.3        5.80 ±  3%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.48 ±  2%      +0.3        5.81 ±  3%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.48 ±  2%      +0.3        5.81 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      1.63 ±  2%      +0.3        1.96 ±  2%  perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      5.58 ±  2%      +0.3        5.91 ±  3%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      1.91 ±  2%      +0.3        2.25 ±  3%  perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.38 ±  2%      +0.4        1.74 ±  2%  perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store_prealloc.vma_complete.__split_vma
      1.38 ±  6%      +0.4        1.74 ±  2%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.__folio_alloc.vma_alloc_folio.do_anonymous_page
      0.94 ± 10%      +0.4        1.31 ±  8%  perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_wr_spanning_store.mas_store_gfp
      0.97 ± 10%      +0.4        1.34 ±  8%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap
      1.92 ±  4%      +0.4        2.30 ±  2%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.02 ± 10%      +0.4        1.40 ±  7%  perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      1.56 ±  2%      +0.4        1.94 ±  2%  perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
      2.09 ±  2%      +0.4        2.47 ±  2%  perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.93 ±  4%      +0.4        2.32 ±  2%  perf-profile.calltrace.cycles-pp.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_topdown.get_unmapped_area.do_mmap
      0.90 ±  4%      +0.4        1.29 ±  9%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      1.54 ±  5%      +0.4        1.93        perf-profile.calltrace.cycles-pp.__alloc_pages.__folio_alloc.vma_alloc_folio.do_anonymous_page.__handle_mm_fault
      1.56 ±  5%      +0.4        1.95        perf-profile.calltrace.cycles-pp.__folio_alloc.vma_alloc_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      1.92 ±  4%      +0.4        2.32 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__mmap
      1.84 ±  3%      +0.4        2.26        perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.17 ±141%      +0.4        0.60 ±  4%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_mmapmany_child
      1.76 ±  5%      +0.4        2.19        perf-profile.calltrace.cycles-pp.vma_alloc_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      2.12 ±  3%      +0.4        2.57 ±  2%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.27 ±100%      +0.5        0.74 ±  3%  perf-profile.calltrace.cycles-pp.__slab_free.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
      2.42 ±  3%      +0.5        2.88        perf-profile.calltrace.cycles-pp.vm_unmapped_area.arch_get_unmapped_area_topdown.get_unmapped_area.do_mmap.vm_mmap_pgoff
      2.18 ±  3%      +0.5        2.64 ±  2%  perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      2.18            +0.5        2.66 ±  2%  perf-profile.calltrace.cycles-pp.mas_spanning_rebalance.mas_rebalance.mas_wr_bnode.mas_store_gfp.do_vmi_align_munmap
      1.91 ±  5%      +0.5        2.39        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.unmap_region.do_vmi_align_munmap
      1.97 ±  5%      +0.5        2.46 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      2.50 ±  3%      +0.5        2.99 ±  2%  perf-profile.calltrace.cycles-pp.arch_get_unmapped_area_topdown.get_unmapped_area.do_mmap.vm_mmap_pgoff.do_syscall_64
      1.98 ±  5%      +0.5        2.47        perf-profile.calltrace.cycles-pp.lru_add_drain.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      2.55 ±  3%      +0.5        3.04        perf-profile.calltrace.cycles-pp.get_unmapped_area.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.08 ±223%      +0.5        0.61 ±  7%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.09 ±223%      +0.5        0.63 ±  3%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_add_new_anon_rmap.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.00            +0.5        0.54 ±  2%  perf-profile.calltrace.cycles-pp.__entry_text_start.__munmap
      0.00            +0.5        0.55 ±  7%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.vma_complete.vma_expand.mmap_region.do_mmap
      0.09 ±223%      +0.6        0.64 ±  7%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.75 ±  5%      +0.6        3.33 ±  2%  perf-profile.calltrace.cycles-pp.charge_memcg.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      2.41            +0.6        3.00        perf-profile.calltrace.cycles-pp.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      0.19 ±142%      +0.6        0.80 ±  3%  perf-profile.calltrace.cycles-pp.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
      0.00            +0.7        0.65 ±  9%  perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_rebalance.mas_wr_bnode
      0.00            +0.7        0.65 ± 15%  perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc.anon_vma_clone.__split_vma.do_vmi_align_munmap
      3.09 ±  5%      +0.7        3.76 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      3.21 ±  2%      +0.7        3.88        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.00            +0.7        0.68 ±  9%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_rebalance.mas_wr_bnode.mas_store_gfp
      0.00            +0.8        0.76 ±  8%  perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_rebalance.mas_wr_bnode.mas_store_gfp.do_vmi_align_munmap
      0.00            +0.8        0.79 ±  4%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap
      2.82 ±  3%      +0.8        3.63        perf-profile.calltrace.cycles-pp.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      3.00 ±  5%      +0.8        3.82 ±  4%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      2.85 ±  2%      +0.9        3.70 ±  3%  perf-profile.calltrace.cycles-pp.mas_rebalance.mas_wr_bnode.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      2.97 ±  2%      +0.9        3.84 ±  2%  perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.64 ± 12%      +0.9        2.57 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      1.64 ± 12%      +0.9        2.57 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      1.64 ± 12%      +0.9        2.57 ±  3%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      1.52 ± 12%      +0.9        2.47 ±  3%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
      1.54 ± 12%      +0.9        2.48 ±  3%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      1.54 ± 12%      +0.9        2.48 ±  3%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.53 ± 12%      +0.9        2.48 ±  3%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
      1.55 ± 12%      +1.0        2.51 ±  3%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.83 ±  5%      +1.0        4.85 ±  3%  perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      3.84 ±  3%      +1.0        4.86 ±  3%  perf-profile.calltrace.cycles-pp.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      6.36 ±  3%      +1.3        7.64 ±  5%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
      6.60 ±  3%      +1.3        7.94 ±  5%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      8.25 ±  2%      +1.7        9.98 ±  4%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      8.35 ±  4%      +1.9       10.22        perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      8.83 ±  4%      +1.9       10.75        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      9.28 ±  4%      +2.0       11.31        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_mmapmany_child
     10.50 ±  4%      +2.3       12.79        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_mmapmany_child
     10.56 ±  4%      +2.3       12.86        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_mmapmany_child
     11.46 ±  2%      +2.7       14.15        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     13.58 ±  4%      +3.0       16.55        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_mmapmany_child
     14.88            +3.2       18.04 ±  2%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     15.65 ±  4%      +3.3       18.92        perf-profile.calltrace.cycles-pp.stress_mmapmany_child
     30.81 ±  2%      -9.4       21.42        perf-profile.children.cycles-pp.__split_vma
     10.65 ±  6%      -9.0        1.69 ±  2%  perf-profile.children.cycles-pp.mas_destroy
     11.44 ± 10%      -8.2        3.19 ±  8%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
     14.38 ±  3%      -8.2        6.17        perf-profile.children.cycles-pp.mas_store_prealloc
     12.58 ±  9%      -7.7        4.84 ±  6%  perf-profile.children.cycles-pp.mas_alloc_nodes
     10.77 ± 11%      -7.7        3.08 ±  8%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
     10.96 ±  8%      -7.6        3.34 ±  4%  perf-profile.children.cycles-pp.mas_preallocate
      8.58 ±  6%      -7.6        0.96 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
     14.24 ±  2%      -5.8        8.42        perf-profile.children.cycles-pp.vma_complete
     74.55            -5.1       69.45        perf-profile.children.cycles-pp.do_syscall_64
     74.83            -5.0       69.78        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      7.27 ± 14%      -4.9        2.40 ±  9%  perf-profile.children.cycles-pp.___slab_alloc
      5.95 ±  5%      -3.7        2.23 ±  2%  perf-profile.children.cycles-pp.vma_expand
      8.10 ±  3%      -3.4        4.67 ±  2%  perf-profile.children.cycles-pp.mmap_region
     60.24            -3.1       57.16        perf-profile.children.cycles-pp.do_vmi_align_munmap
     10.70            -2.9        7.78 ±  2%  perf-profile.children.cycles-pp.do_mmap
      3.66 ± 23%      -2.9        0.79 ± 13%  perf-profile.children.cycles-pp.get_partial_node
     11.12            -2.9        8.26 ±  2%  perf-profile.children.cycles-pp.vm_mmap_pgoff
     62.10            -2.7       59.39        perf-profile.children.cycles-pp.do_vmi_munmap
     12.48            -2.6        9.87 ±  2%  perf-profile.children.cycles-pp.__mmap
     62.64            -2.6       60.07        perf-profile.children.cycles-pp.__vm_munmap
     62.67            -2.6       60.10        perf-profile.children.cycles-pp.__x64_sys_munmap
      2.94 ± 23%      -2.4        0.54 ± 10%  perf-profile.children.cycles-pp.__unfreeze_partials
      4.43 ± 23%      -2.4        2.03 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.87 ± 33%      -2.3        0.58 ±  7%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     64.50            -2.0       62.53        perf-profile.children.cycles-pp.__munmap
      1.24 ± 35%      -1.0        0.24 ± 50%  perf-profile.children.cycles-pp.get_any_partial
      6.36            -0.5        5.86 ±  2%  perf-profile.children.cycles-pp.__slab_free
      0.58 ±  3%      -0.4        0.18 ±  8%  perf-profile.children.cycles-pp.put_cpu_partial
      0.38 ±  3%      -0.0        0.34 ±  4%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.06 ±  6%      +0.0        0.08 ± 12%  perf-profile.children.cycles-pp.uncharge_folio
      0.12 ±  9%      +0.0        0.14 ±  7%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.14 ±  4%      +0.0        0.16 ±  7%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.08 ± 10%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.08 ± 14%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.down_read_trylock
      0.09 ± 11%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.14 ±  7%      +0.0        0.17 ± 11%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.12 ±  6%      +0.0        0.15 ± 10%  perf-profile.children.cycles-pp.mas_split_final_node
      0.14 ±  9%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.20 ±  6%      +0.0        0.23 ±  6%  perf-profile.children.cycles-pp.__pte_offset_map
      0.14 ± 10%      +0.0        0.18 ±  6%  perf-profile.children.cycles-pp.mas_wr_slot_store
      0.03 ± 70%      +0.0        0.07 ± 10%  perf-profile.children.cycles-pp._find_next_bit
      0.14 ±  7%      +0.0        0.18 ±  6%  perf-profile.children.cycles-pp.mast_topiary
      0.14 ±  4%      +0.0        0.18 ±  5%  perf-profile.children.cycles-pp.downgrade_write
      0.37 ±  5%      +0.0        0.41 ±  5%  perf-profile.children.cycles-pp.__folio_throttle_swaprate
      0.11 ±  8%      +0.0        0.16 ± 10%  perf-profile.children.cycles-pp.mas_next_sibling
      0.26 ±  4%      +0.0        0.31 ±  8%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.25 ±  4%      +0.1        0.30 ±  6%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.28 ±  8%      +0.1        0.33 ±  5%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.33 ±  3%      +0.1        0.38 ±  5%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.24 ±  9%      +0.1        0.30 ±  7%  perf-profile.children.cycles-pp.mas_replace
      0.28 ±  5%      +0.1        0.34 ±  7%  perf-profile.children.cycles-pp.refill_obj_stock
      0.07 ± 11%      +0.1        0.12 ± 17%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.33 ±  4%      +0.1        0.39 ±  4%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.06 ± 14%      +0.1        0.12 ± 17%  perf-profile.children.cycles-pp.kmalloc_trace
      0.39 ±  4%      +0.1        0.46 ±  5%  perf-profile.children.cycles-pp.mas_prev_node
      0.28 ±  5%      +0.1        0.35 ±  7%  perf-profile.children.cycles-pp.mast_fill_bnode
      0.01 ±223%      +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.mas_node_count_gfp
      0.36 ± 11%      +0.1        0.43 ±  8%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.30 ± 10%      +0.1        0.38 ±  7%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.67 ±  4%      +0.1        0.76 ±  5%  perf-profile.children.cycles-pp.mas_prev_slot
      0.76            +0.1        0.85 ±  3%  perf-profile.children.cycles-pp.mas_pop_node
      0.46 ±  8%      +0.1        0.55 ±  4%  perf-profile.children.cycles-pp.__rb_erase_color
      0.35 ±  6%      +0.1        0.44 ±  5%  perf-profile.children.cycles-pp.userfaultfd_unmap_complete
      0.34 ±  8%      +0.1        0.44 ±  5%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.65 ±  4%      +0.1        0.76 ±  6%  perf-profile.children.cycles-pp.__memcpy
      0.46 ±  7%      +0.1        0.57 ±  7%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.48 ±  6%      +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.50 ±  5%      +0.1        0.61 ±  4%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.90 ±  5%      +0.1        1.02 ±  3%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.56 ±  3%      +0.1        0.68        perf-profile.children.cycles-pp.__entry_text_start
      0.71 ±  6%      +0.1        0.84 ±  4%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.66 ±  4%      +0.1        0.78 ±  3%  perf-profile.children.cycles-pp.mas_mab_cp
      0.20 ± 11%      +0.1        0.33 ±  6%  perf-profile.children.cycles-pp.mas_is_span_wr
      0.83 ±  4%      +0.1        0.98 ±  3%  perf-profile.children.cycles-pp.mas_next_slot
      0.63 ±  5%      +0.1        0.78 ±  2%  perf-profile.children.cycles-pp.mas_update_gap
      0.13 ± 11%      +0.1        0.28 ±  4%  perf-profile.children.cycles-pp.mas_wr_store_setup
      0.72 ±  5%      +0.2        0.87 ±  6%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.54 ±  2%      +0.2        0.70 ±  5%  perf-profile.children.cycles-pp.mas_push_data
      0.49 ±  5%      +0.2        0.65 ±  7%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.30 ±  7%      +0.2        0.46 ±  7%  perf-profile.children.cycles-pp.rcu_all_qs
      0.98 ±  3%      +0.2        1.16 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.90 ±  3%      +0.2        1.08 ±  2%  perf-profile.children.cycles-pp.up_write
      0.14 ± 22%      +0.2        0.31 ± 23%  perf-profile.children.cycles-pp.vma_migratable
      0.81 ±  3%      +0.2        1.01 ±  5%  perf-profile.children.cycles-pp.mab_mas_cp
      0.95 ±  3%      +0.2        1.14 ±  3%  perf-profile.children.cycles-pp.lru_add_fn
      0.58 ± 11%      +0.2        0.78 ±  2%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.50 ± 14%      +0.2        0.70 ± 13%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.98 ±  4%      +0.2        1.18 ±  2%  perf-profile.children.cycles-pp.mas_ascend
      2.04            +0.2        2.25 ±  2%  perf-profile.children.cycles-pp.__call_rcu_common
      1.09 ±  3%      +0.2        1.30 ±  2%  perf-profile.children.cycles-pp.sync_regs
      0.88 ±  4%      +0.2        1.10 ±  2%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.97 ±  4%      +0.2        1.19 ±  2%  perf-profile.children.cycles-pp.flush_tlb_func
      0.93 ±  3%      +0.2        1.15 ±  4%  perf-profile.children.cycles-pp.mas_descend_adopt
      0.74 ±  4%      +0.2        0.96 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.96 ±  4%      +0.2        1.20        perf-profile.children.cycles-pp.__count_memcg_events
      0.84 ±  8%      +0.2        1.08 ±  4%  perf-profile.children.cycles-pp.rmqueue
      1.16 ±  5%      +0.2        1.41 ±  5%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.00            +0.3        0.25 ±  8%  perf-profile.children.cycles-pp.mas_wr_end_piv
      0.37 ±  7%      +0.3        0.64 ± 12%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.53 ±  5%      +0.3        1.81 ±  4%  perf-profile.children.cycles-pp.zap_pte_range
      0.28 ± 14%      +0.3        0.58 ± 18%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.90 ± 12%      +0.3        1.20 ± 10%  perf-profile.children.cycles-pp.free_unref_page_list
      0.28 ± 14%      +0.3        0.57 ± 18%  perf-profile.children.cycles-pp.task_numa_work
      0.28 ± 14%      +0.3        0.58 ± 18%  perf-profile.children.cycles-pp.task_work_run
      1.67 ±  4%      +0.3        1.98 ±  3%  perf-profile.children.cycles-pp.zap_pmd_range
      1.31 ±  2%      +0.3        1.63 ±  3%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.35 ± 13%      +0.3        0.67 ± 15%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      5.48 ±  2%      +0.3        5.81 ±  3%  perf-profile.children.cycles-pp.start_secondary
      3.57 ±  3%      +0.3        3.89 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      5.52 ±  2%      +0.3        5.85 ±  3%  perf-profile.children.cycles-pp.cpuidle_idle_call
      1.62 ±  5%      +0.3        1.95 ±  2%  perf-profile.children.cycles-pp.mas_rev_awalk
      5.58 ±  2%      +0.3        5.91 ±  3%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      5.58 ±  2%      +0.3        5.91 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
      5.58 ±  2%      +0.3        5.91 ±  3%  perf-profile.children.cycles-pp.do_idle
      1.94 ±  2%      +0.3        2.28 ±  3%  perf-profile.children.cycles-pp.unlink_anon_vmas
      1.39 ±  2%      +0.4        1.75 ±  2%  perf-profile.children.cycles-pp.mas_split
      1.97            +0.4        2.34 ±  3%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      1.94 ±  4%      +0.4        2.32 ±  2%  perf-profile.children.cycles-pp.unmap_page_range
      2.12 ±  2%      +0.4        2.50 ±  2%  perf-profile.children.cycles-pp.free_pgtables
      1.42 ±  5%      +0.4        1.80        perf-profile.children.cycles-pp.get_page_from_freelist
      1.36 ±  3%      +0.4        1.74        perf-profile.children.cycles-pp.vma_prepare
      1.92 ±  3%      +0.4        2.31 ±  2%  perf-profile.children.cycles-pp.mas_find
      2.02 ±  3%      +0.4        2.41        perf-profile.children.cycles-pp.mtree_range_walk
      2.20 ±  2%      +0.4        2.60        perf-profile.children.cycles-pp.mas_walk
      1.98 ±  4%      +0.4        2.38 ±  2%  perf-profile.children.cycles-pp.mas_empty_area_rev
      1.57 ±  5%      +0.4        1.97        perf-profile.children.cycles-pp.__folio_alloc
      1.60 ±  4%      +0.4        2.01        perf-profile.children.cycles-pp.__alloc_pages
      1.73            +0.4        2.14 ±  2%  perf-profile.children.cycles-pp.mas_wmb_replace
      1.30 ±  3%      +0.4        1.72        perf-profile.children.cycles-pp.down_write
      1.78 ±  5%      +0.4        2.21        perf-profile.children.cycles-pp.vma_alloc_folio
      2.15 ±  3%      +0.4        2.60 ±  2%  perf-profile.children.cycles-pp.unmap_vmas
      2.03 ±  2%      +0.5        2.48        perf-profile.children.cycles-pp._raw_spin_lock
      2.42 ±  3%      +0.5        2.89        perf-profile.children.cycles-pp.vm_unmapped_area
      1.93 ±  5%      +0.5        2.41        perf-profile.children.cycles-pp.folio_batch_move_lru
      2.51 ±  3%      +0.5        3.00 ±  2%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      2.06 ±  5%      +0.5        2.55 ±  2%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      2.55 ±  3%      +0.5        3.05 ±  2%  perf-profile.children.cycles-pp.get_unmapped_area
      2.08 ±  5%      +0.5        2.58 ±  2%  perf-profile.children.cycles-pp.lru_add_drain
      2.47 ±  3%      +0.5        3.00        perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.63 ±  5%      +0.5        2.17 ±  7%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      1.27 ±  6%      +0.5        1.82 ± 12%  perf-profile.children.cycles-pp.mod_objcg_state
      1.46            +0.6        2.02 ±  3%  perf-profile.children.cycles-pp.mas_wr_walk
      3.88            +0.6        4.44 ±  2%  perf-profile.children.cycles-pp.mas_wr_node_store
      1.38 ±  5%      +0.6        1.94 ± 11%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      3.08 ±  4%      +0.6        3.65 ±  4%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      2.78 ±  5%      +0.6        3.35 ±  2%  perf-profile.children.cycles-pp.charge_memcg
      3.11 ±  5%      +0.7        3.77 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      2.84 ±  3%      +0.8        3.67        perf-profile.children.cycles-pp.anon_vma_clone
      2.85 ±  2%      +0.9        3.71 ±  3%  perf-profile.children.cycles-pp.mas_rebalance
      3.08 ±  9%      +0.9        4.01 ±  2%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      1.64 ± 12%      +0.9        2.57 ±  3%  perf-profile.children.cycles-pp.kthread
      1.64 ± 12%      +0.9        2.58 ±  3%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.64 ± 12%      +0.9        2.58 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      1.54 ± 12%      +0.9        2.48 ±  3%  perf-profile.children.cycles-pp.run_ksoftirqd
      1.55 ± 12%      +1.0        2.51 ±  3%  perf-profile.children.cycles-pp.smpboot_thread_fn
      6.00            +1.0        7.00        perf-profile.children.cycles-pp.mas_wr_store_entry
      3.86 ±  5%      +1.0        4.88 ±  3%  perf-profile.children.cycles-pp.vm_area_dup
      3.84 ±  3%      +1.0        4.87 ±  3%  perf-profile.children.cycles-pp.mas_wr_spanning_store
      4.66            +1.1        5.76        perf-profile.children.cycles-pp.mas_spanning_rebalance
      4.54            +1.3        5.79 ±  2%  perf-profile.children.cycles-pp.mas_wr_bnode
      8.30 ±  2%      +1.3        9.60 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
      6.55 ±  3%      +1.3        7.88 ±  5%  perf-profile.children.cycles-pp.release_pages
      6.62 ±  3%      +1.3        7.95 ±  5%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
     10.44            +1.4       11.86 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     12.64            +1.5       14.14 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      8.27 ±  2%      +1.7       10.00 ±  4%  perf-profile.children.cycles-pp.tlb_finish_mmu
      4.77 ±  4%      +1.8        6.58 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      8.40 ±  4%      +1.9       10.28        perf-profile.children.cycles-pp.do_anonymous_page
      8.87 ±  4%      +1.9       10.80        perf-profile.children.cycles-pp.__handle_mm_fault
      9.33 ±  4%      +2.0       11.36        perf-profile.children.cycles-pp.handle_mm_fault
      9.80 ±  2%      +2.2       12.04 ±  2%  perf-profile.children.cycles-pp.__do_softirq
      9.50 ±  2%      +2.2       11.75 ±  2%  perf-profile.children.cycles-pp.rcu_do_batch
      9.54 ±  2%      +2.3       11.79 ±  2%  perf-profile.children.cycles-pp.rcu_core
     10.56 ±  4%      +2.3       12.86        perf-profile.children.cycles-pp.do_user_addr_fault
     10.61 ±  4%      +2.3       12.91        perf-profile.children.cycles-pp.exc_page_fault
     11.50 ±  2%      +2.7       14.20        perf-profile.children.cycles-pp.mas_store_gfp
     13.72 ±  4%      +3.0       16.69        perf-profile.children.cycles-pp.asm_exc_page_fault
     14.92            +3.2       18.09 ±  2%  perf-profile.children.cycles-pp.unmap_region
     16.65 ±  4%      +3.5       20.16        perf-profile.children.cycles-pp.stress_mmapmany_child
      4.43 ±  2%      -3.9        0.55 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free_bulk
      4.07 ±  3%      -2.4        1.70 ±  8%  perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      2.86 ± 33%      -2.3        0.58 ±  6%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.97 ±  3%      -1.8        1.20 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
      1.14 ± 12%      -0.8        0.36 ±  8%  perf-profile.self.cycles-pp.get_partial_node
      0.92 ± 11%      -0.7        0.25 ±  5%  perf-profile.self.cycles-pp.__unfreeze_partials
      0.54 ±  7%      -0.4        0.09 ±  7%  perf-profile.self.cycles-pp.kmem_cache_alloc_bulk
      6.20            -0.4        5.77 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.53 ±  3%      -0.4        0.16 ±  4%  perf-profile.self.cycles-pp.put_cpu_partial
      0.43 ±  7%      -0.0        0.38 ±  3%  perf-profile.self.cycles-pp.mas_wr_store_entry
      0.33 ±  5%      -0.0        0.29 ±  3%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.18 ±  8%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.mas_destroy
      0.10 ±  8%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.perf_event_mmap_event
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.05 ±  8%      +0.0        0.07 ± 11%  perf-profile.self.cycles-pp.uncharge_folio
      0.08 ±  5%      +0.0        0.10 ± 10%  perf-profile.self.cycles-pp.do_syscall_64
      0.04 ± 45%      +0.0        0.07 ± 11%  perf-profile.self.cycles-pp.mas_wmb_replace
      0.15 ±  6%      +0.0        0.17 ±  3%  perf-profile.self.cycles-pp.mas_wr_spanning_store
      0.09 ±  7%      +0.0        0.11 ±  7%  perf-profile.self.cycles-pp.vm_unmapped_area
      0.10 ±  6%      +0.0        0.12 ±  7%  perf-profile.self.cycles-pp.error_entry
      0.12 ±  5%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.vma_prepare
      0.11 ±  9%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.page_remove_rmap
      0.06 ±  7%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.mas_next_sibling
      0.15 ±  8%      +0.0        0.18 ±  5%  perf-profile.self.cycles-pp.__pte_offset_map
      0.15 ±  8%      +0.0        0.18 ±  5%  perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.12 ±  6%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp.do_vmi_munmap
      0.12 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.downgrade_write
      0.12 ±  7%      +0.0        0.15 ±  9%  perf-profile.self.cycles-pp.tlb_gather_mmu
      0.18 ±  2%      +0.0        0.21 ±  5%  perf-profile.self.cycles-pp.vma_complete
      0.17 ±  5%      +0.0        0.20 ±  8%  perf-profile.self.cycles-pp.rcu_do_batch
      0.22 ±  7%      +0.0        0.25 ±  4%  perf-profile.self.cycles-pp.mas_replace
      0.12 ± 10%      +0.0        0.16 ±  9%  perf-profile.self.cycles-pp.mmap_region
      0.12 ±  4%      +0.0        0.15 ±  8%  perf-profile.self.cycles-pp.free_unref_page_list
      0.15 ±  8%      +0.0        0.19 ±  7%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.12 ±  7%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.22 ±  9%      +0.0        0.26 ±  4%  perf-profile.self.cycles-pp.mas_update_gap
      0.17 ± 11%      +0.0        0.21 ±  5%  perf-profile.self.cycles-pp.up_read
      0.13 ±  3%      +0.0        0.16 ±  9%  perf-profile.self.cycles-pp.mas_push_data
      0.24 ±  3%      +0.0        0.28 ±  7%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.27 ±  4%      +0.0        0.31 ±  8%  perf-profile.self.cycles-pp.__vm_munmap
      0.24 ±  4%      +0.0        0.28 ±  4%  perf-profile.self.cycles-pp.zap_pte_range
      0.22 ±  4%      +0.0        0.26 ±  9%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.21 ±  7%      +0.0        0.25 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      0.25 ± 10%      +0.0        0.30 ±  7%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.01 ±223%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.security_mmap_file
      0.22 ±  9%      +0.0        0.26 ±  4%  perf-profile.self.cycles-pp.unmap_page_range
      0.20 ±  8%      +0.0        0.25 ±  7%  perf-profile.self.cycles-pp.rcu_all_qs
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.mas_node_count_gfp
      0.36 ±  4%      +0.1        0.42        perf-profile.self.cycles-pp.mas_store_gfp
      0.28 ±  5%      +0.1        0.34 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.31 ±  7%      +0.1        0.37 ±  3%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.25 ±  6%      +0.1        0.32 ±  6%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.21 ± 12%      +0.1        0.27 ±  7%  perf-profile.self.cycles-pp.unmap_region
      0.31 ±  6%      +0.1        0.37 ±  3%  perf-profile.self.cycles-pp.tlb_finish_mmu
      0.32 ±  6%      +0.1        0.39 ±  2%  perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.28 ±  4%      +0.1        0.34 ±  6%  perf-profile.self.cycles-pp.lru_add_fn
      0.34 ±  3%      +0.1        0.42 ±  6%  perf-profile.self.cycles-pp.mas_alloc_nodes
      0.40 ±  4%      +0.1        0.48 ±  9%  perf-profile.self.cycles-pp.clear_page_erms
      0.68 ±  3%      +0.1        0.76 ±  3%  perf-profile.self.cycles-pp.mas_pop_node
      0.42 ±  6%      +0.1        0.50 ±  4%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.28 ± 11%      +0.1        0.35 ±  6%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.35 ±  4%      +0.1        0.43 ±  3%  perf-profile.self.cycles-pp.__munmap
      0.45 ±  3%      +0.1        0.52 ±  5%  perf-profile.self.cycles-pp.mas_mab_cp
      0.56 ±  4%      +0.1        0.63 ±  4%  perf-profile.self.cycles-pp.__memcpy
      0.40 ±  9%      +0.1        0.49 ±  7%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.09 ± 12%      +0.1        0.18 ±  7%  perf-profile.self.cycles-pp.mas_wr_store_setup
      0.15 ± 12%      +0.1        0.24 ±  8%  perf-profile.self.cycles-pp.mas_is_span_wr
      0.60 ±  3%      +0.1        0.69 ±  3%  perf-profile.self.cycles-pp.mas_next_slot
      0.44 ±  6%      +0.1        0.53 ±  3%  perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.59 ±  4%      +0.1        0.69 ±  4%  perf-profile.self.cycles-pp.folio_lruvec_lock_irqsave
      0.40 ±  5%      +0.1        0.50 ±  9%  perf-profile.self.cycles-pp.release_pages
      0.66 ±  7%      +0.1        0.78 ±  5%  perf-profile.self.cycles-pp.__split_vma
      0.40 ±  3%      +0.1        0.53 ±  7%  perf-profile.self.cycles-pp.__cond_resched
      0.67 ±  6%      +0.1        0.80 ±  4%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.85 ±  5%      +0.1        0.98 ±  2%  perf-profile.self.cycles-pp.mas_ascend
      0.79 ±  2%      +0.1        0.92 ±  2%  perf-profile.self.cycles-pp.up_write
      0.39 ±  6%      +0.1        0.54 ±  9%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.64 ±  4%      +0.1        0.78 ±  4%  perf-profile.self.cycles-pp.mab_mas_cp
      0.13 ± 23%      +0.2        0.28 ± 23%  perf-profile.self.cycles-pp.vma_migratable
      0.69 ±  9%      +0.2        0.85 ±  3%  perf-profile.self.cycles-pp.vm_area_dup
      0.95 ±  3%      +0.2        1.12 ±  2%  perf-profile.self.cycles-pp.__call_rcu_common
      0.50 ± 12%      +0.2        0.66 ±  7%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      0.75 ±  4%      +0.2        0.92 ±  3%  perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.98 ±  3%      +0.2        1.16 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.69 ±  3%      +0.2        0.86 ±  5%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.84 ±  2%      +0.2        1.03 ±  3%  perf-profile.self.cycles-pp.mas_descend_adopt
      0.77 ±  5%      +0.2        0.97        perf-profile.self.cycles-pp.__count_memcg_events
      0.00            +0.2        0.21 ±  8%  perf-profile.self.cycles-pp.mas_wr_end_piv
      0.88 ±  4%      +0.2        1.09 ±  2%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      1.09 ±  3%      +0.2        1.30 ±  2%  perf-profile.self.cycles-pp.sync_regs
      1.48            +0.2        1.71 ±  2%  perf-profile.self.cycles-pp.mas_wr_node_store
      1.19 ±  6%      +0.2        1.42 ±  3%  perf-profile.self.cycles-pp.charge_memcg
      1.48 ±  4%      +0.3        1.74 ±  2%  perf-profile.self.cycles-pp.mas_rev_awalk
      1.12 ±  4%      +0.3        1.38 ±  3%  perf-profile.self.cycles-pp.mas_spanning_rebalance
      1.24 ±  4%      +0.3        1.55 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.99 ±  4%      +0.3        1.31 ±  2%  perf-profile.self.cycles-pp.down_write
      1.82 ±  3%      +0.4        2.18        perf-profile.self.cycles-pp.mtree_range_walk
      1.89            +0.4        2.26        perf-profile.self.cycles-pp._raw_spin_lock
      1.19            +0.4        1.58 ±  3%  perf-profile.self.cycles-pp.mas_wr_walk
      0.10 ± 10%      +0.4        0.51 ±  5%  perf-profile.self.cycles-pp.mas_preallocate
      1.11 ±  7%      +0.4        1.52 ± 11%  perf-profile.self.cycles-pp.mod_objcg_state
      2.81 ±  4%      +0.5        3.30 ±  3%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      1.60 ±  5%      +0.5        2.14 ±  7%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      3.49 ±  2%      +0.6        4.12        perf-profile.self.cycles-pp.stress_mmapmany_child


***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  memory/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/tmpfs/stress-ng/60s

commit: 
  0b8bb544b1 ("maple_tree: update mas_preallocate() testing")
  17983dc617 ("maple_tree: refine mas_preallocate() node calculations")

0b8bb544b1a7051c 17983dc617837a588a52848ab40 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     95.86            +1.6%      97.42        turbostat.RAMWatt
      5479 ±  3%     +11.6%       6114 ±  4%  vmstat.system.cs
      1376           -15.6%       1162        stress-ng.time.system_time
    993.94            +7.4%       1067        stress-ng.tmpfs.ops_per_sec
    450032 ±  2%     -11.0%     400476 ±  2%  meminfo.Active
    449936 ±  2%     -11.0%     400380 ±  2%  meminfo.Active(anon)
    275823 ±  4%     -10.5%     246948 ±  2%  meminfo.Mapped
    284348 ± 10%     -29.4%     200680 ± 15%  numa-meminfo.node1.AnonPages.max
    350412 ± 10%     -22.3%     272335 ± 12%  numa-meminfo.node1.Inactive
    350376 ± 10%     -22.3%     272198 ± 12%  numa-meminfo.node1.Inactive(anon)
   4161469 ±  4%     +22.6%    5101694 ±  3%  numa-numastat.node0.local_node
   4179507 ±  3%     +23.0%    5142404 ±  3%  numa-numastat.node0.numa_hit
   4260051 ±  2%     +25.2%    5333058 ±  3%  numa-numastat.node1.local_node
   4308278 ±  2%     +24.4%    5358567 ±  3%  numa-numastat.node1.numa_hit
      5285 ±  7%     -25.8%       3921 ±  7%  perf-c2c.DRAM.local
      2339 ±  8%     -22.8%       1805 ±  8%  perf-c2c.DRAM.remote
      3368 ±  7%     -40.8%       1992 ±  4%  perf-c2c.HITM.local
      1339 ±  8%     -29.5%     944.67 ± 10%  perf-c2c.HITM.remote
      4708 ±  7%     -37.6%       2937 ±  6%  perf-c2c.HITM.total
   4179567 ±  3%     +23.0%    5142495 ±  3%  numa-vmstat.node0.numa_hit
   4161576 ±  4%     +22.6%    5101785 ±  3%  numa-vmstat.node0.numa_local
     87605 ± 10%     -22.3%      68082 ± 12%  numa-vmstat.node1.nr_inactive_anon
     87605 ± 10%     -22.3%      68081 ± 12%  numa-vmstat.node1.nr_zone_inactive_anon
   4308314 ±  2%     +24.4%    5358374 ±  3%  numa-vmstat.node1.numa_hit
   4260087 ±  2%     +25.2%    5332865 ±  3%  numa-vmstat.node1.numa_local
      0.20 ±103%     -86.6%       0.03 ± 45%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    693.00 ± 11%     -55.9%     305.67 ± 10%  perf-sched.wait_and_delay.count.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
    708.33 ±  9%     +32.8%     941.00 ± 10%  perf-sched.wait_and_delay.count.__cond_resched.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range.isra
      1.55 ±  7%     -30.9%       1.07 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.madvise_vma_behavior
      0.98 ± 29%     +50.4%       1.48 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
      1.02 ± 25%     -23.0%       0.79 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     13.71 ± 10%     -28.5%       9.81 ± 35%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
     14.27 ± 12%     -21.6%      11.18 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault
     17.85 ± 18%     -36.9%      11.26 ± 11%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
    113053 ±  3%     -11.3%     100323 ±  2%  proc-vmstat.nr_active_anon
    871484            -2.0%     854236        proc-vmstat.nr_file_pages
    153950            -3.2%     149074        proc-vmstat.nr_inactive_anon
     68586 ±  3%      -9.8%      61866 ±  3%  proc-vmstat.nr_mapped
    185401            -9.3%     168157        proc-vmstat.nr_shmem
    113053 ±  3%     -11.3%     100323 ±  2%  proc-vmstat.nr_zone_active_anon
    153950            -3.2%     149075        proc-vmstat.nr_zone_inactive_anon
   8490162 ±  3%     +23.7%   10503041 ±  3%  proc-vmstat.numa_hit
   8429214 ±  3%     +23.8%   10436824 ±  3%  proc-vmstat.numa_local
  15190853 ±  3%     +26.9%   19274212 ±  3%  proc-vmstat.pgalloc_normal
  14869653 ±  3%     +27.4%   18944380 ±  3%  proc-vmstat.pgfree
 5.867e+10            +5.5%   6.19e+10        perf-stat.i.branch-instructions
      0.53 ±  2%      -0.0        0.48        perf-stat.i.branch-miss-rate%
  2.72e+08            -6.4%  2.548e+08        perf-stat.i.branch-misses
 1.641e+08            +3.9%  1.705e+08        perf-stat.i.cache-misses
 4.729e+08            +3.5%  4.893e+08        perf-stat.i.cache-references
      5437 ±  3%     +12.3%       6107 ±  5%  perf-stat.i.context-switches
      0.65            -4.8%       0.62        perf-stat.i.cpi
    350.56 ±  2%     +10.7%     387.96 ±  2%  perf-stat.i.cpu-migrations
   1596102 ±  5%     -17.0%    1324985 ±  3%  perf-stat.i.dTLB-load-misses
 3.283e+10            +3.6%  3.402e+10        perf-stat.i.dTLB-loads
      0.10            +0.0        0.10        perf-stat.i.dTLB-store-miss-rate%
  25699419            +6.9%   27462600        perf-stat.i.dTLB-store-misses
 2.516e+10            +4.6%  2.633e+10        perf-stat.i.dTLB-stores
 2.932e+11            +5.3%  3.088e+11        perf-stat.i.instructions
      1.60            +5.5%       1.69        perf-stat.i.ipc
      0.74 ±  3%     +19.9%       0.88        perf-stat.i.metric.G/sec
      1663            +2.6%       1706        perf-stat.i.metric.K/sec
      1094 ±  2%      -5.4%       1034        perf-stat.i.metric.M/sec
   2957742            +6.9%    3162872        perf-stat.i.minor-faults
  24244950            -5.6%   22895340 ±  2%  perf-stat.i.node-loads
   2957742            +6.9%    3162872        perf-stat.i.page-faults
      1.61            -1.8%       1.58        perf-stat.overall.MPKI
      0.46            -0.1        0.41        perf-stat.overall.branch-miss-rate%
      0.63            -5.5%       0.59        perf-stat.overall.cpi
      1121            -4.2%       1074        perf-stat.overall.cycles-between-cache-misses
      0.00 ±  6%      -0.0        0.00 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.10            +0.0        0.10        perf-stat.overall.dTLB-store-miss-rate%
      1.59            +5.8%       1.69        perf-stat.overall.ipc
 5.776e+10            +5.4%  6.088e+10        perf-stat.ps.branch-instructions
 2.676e+08            -6.4%  2.504e+08        perf-stat.ps.branch-misses
 1.616e+08            +3.8%  1.677e+08        perf-stat.ps.cache-misses
 4.655e+08            +3.4%  4.811e+08        perf-stat.ps.cache-references
      5348 ±  3%     +11.9%       5987 ±  5%  perf-stat.ps.context-switches
    345.30 ±  2%     +10.5%     381.48 ±  2%  perf-stat.ps.cpu-migrations
   1562858 ±  5%     -17.1%    1295309 ±  3%  perf-stat.ps.dTLB-load-misses
 3.232e+10            +3.5%  3.346e+10        perf-stat.ps.dTLB-loads
  25305038            +6.8%   27015988        perf-stat.ps.dTLB-store-misses
 2.477e+10            +4.5%   2.59e+10        perf-stat.ps.dTLB-stores
 2.887e+11            +5.2%  3.037e+11        perf-stat.ps.instructions
   2912341            +6.8%    3111537        perf-stat.ps.minor-faults
  23880066            -5.6%   22534451 ±  2%  perf-stat.ps.node-loads
   2912341            +6.8%    3111537        perf-stat.ps.page-faults
 1.663e+13            -1.9%  1.632e+13        perf-stat.total.instructions
     11.27            -3.8        7.50        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     11.55            -3.8        7.80        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.60            -3.6        9.05        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     12.73            -3.5        9.19        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     12.80            -3.5        9.27        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     12.83            -3.5        9.30        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
     13.01            -3.5        9.50        perf-profile.calltrace.cycles-pp.__mmap
      2.70 ±  4%      -2.2        0.53        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.mmap_region.do_mmap.vm_mmap_pgoff
      4.29 ±  2%      -2.1        2.17        perf-profile.calltrace.cycles-pp.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      4.74            -2.1        2.68        perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      2.72 ±  4%      -2.0        0.71        perf-profile.calltrace.cycles-pp.mas_preallocate.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      3.51            -1.5        2.05        perf-profile.calltrace.cycles-pp.__split_vma.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      6.08            -1.2        4.90        perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.00            -1.1        0.92        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      2.19            -1.1        1.12        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      7.81            -1.1        6.75        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      7.88            -1.1        6.82        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      8.04            -1.0        7.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      8.14            -1.0        7.11        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
      9.32            -1.0        8.36        perf-profile.calltrace.cycles-pp.__madvise
      1.52            -0.9        0.66 ±  2%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.madvise_vma_behavior.do_madvise
      1.66            -0.9        0.80 ±  2%  perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      5.28            -0.3        4.93        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      1.96            -0.3        1.67        perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.66            -0.3        1.41        perf-profile.calltrace.cycles-pp.mas_rebalance.mas_wr_bnode.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      1.36            -0.1        1.30        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      0.66            +0.0        0.70        perf-profile.calltrace.cycles-pp.mtree_range_walk.mas_walk.find_vma_prev.do_madvise.__x64_sys_madvise
      0.51            +0.0        0.55        perf-profile.calltrace.cycles-pp.mas_push_data.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region
      0.56            +0.0        0.61        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      0.61            +0.0        0.65 ±  2%  perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.stress_mmap_set
      0.73            +0.0        0.78        perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.do_madvise.__x64_sys_madvise.do_syscall_64
      0.77            +0.0        0.82        perf-profile.calltrace.cycles-pp.vma_merge.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      0.60            +0.0        0.65        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region
      0.92            +0.1        0.97        perf-profile.calltrace.cycles-pp.mas_spanning_rebalance.mas_rebalance.mas_wr_bnode.mas_store_gfp.do_vmi_align_munmap
      0.72            +0.1        0.77        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap
      0.64            +0.1        0.70        perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.zap_pte_range.zap_pmd_range
      0.56            +0.1        0.62 ±  2%  perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.69            +0.1        0.76        perf-profile.calltrace.cycles-pp.stress_mwc64modn
      0.78            +0.1        0.84        perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.71            +0.1        0.78        perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.zap_pte_range.zap_pmd_range.unmap_page_range
      1.14            +0.1        1.20        perf-profile.calltrace.cycles-pp.find_vma_prev.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.83            +0.1        0.90        perf-profile.calltrace.cycles-pp.stress_tmpfs_child
      0.91            +0.1        0.99        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.80            +0.1        0.88        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff
      1.02            +0.1        1.10        perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region.do_mmap
      1.16            +0.1        1.24        perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff
      0.91            +0.1        1.00        perf-profile.calltrace.cycles-pp.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.54 ±  2%      +0.1        0.64        perf-profile.calltrace.cycles-pp.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      1.44            +0.1        1.54        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__madvise
      1.33            +0.1        1.44        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff
      1.40            +0.1        1.51        perf-profile.calltrace.cycles-pp.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.55 ±  5%      +0.1        0.68 ±  5%  perf-profile.calltrace.cycles-pp.do_set_pte.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.62 ±  4%      +0.1        0.76 ±  4%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.63 ±  4%      +0.1        0.77 ±  4%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff
      0.60 ±  6%      +0.1        0.74 ±  3%  perf-profile.calltrace.cycles-pp.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range
      0.59 ±  5%      +0.1        0.73 ±  3%  perf-profile.calltrace.cycles-pp.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range
      0.63 ±  5%      +0.1        0.77 ±  3%  perf-profile.calltrace.cycles-pp.walk_pgd_range.__walk_page_range.walk_page_range.madvise_pageout.madvise_vma_behavior
      0.62 ±  4%      +0.1        0.76 ±  5%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.__get_user_pages
      0.61 ±  5%      +0.1        0.75 ±  3%  perf-profile.calltrace.cycles-pp.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_range
      0.62 ±  4%      +0.1        0.76 ±  5%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.__get_user_pages.populate_vma_page_range
      0.63 ±  4%      +0.1        0.77 ±  4%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__get_user_pages.populate_vma_page_range.__mm_populate
      0.62 ±  5%      +0.1        0.76 ±  3%  perf-profile.calltrace.cycles-pp.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_range.madvise_pageout
      0.64 ±  5%      +0.1        0.78 ±  3%  perf-profile.calltrace.cycles-pp.__walk_page_range.walk_page_range.madvise_pageout.madvise_vma_behavior.do_madvise
      0.75 ±  4%      +0.1        0.90 ±  2%  perf-profile.calltrace.cycles-pp.walk_page_range.madvise_pageout.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      1.21            +0.2        1.36        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.83 ±  4%      +0.2        0.98 ±  2%  perf-profile.calltrace.cycles-pp.madvise_pageout.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      0.42 ± 44%      +0.2        0.59 ±  2%  perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.81 ±  3%      +0.2        0.98 ±  5%  perf-profile.calltrace.cycles-pp.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff
      0.61 ±  7%      +0.2        0.78 ±  6%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      0.81 ±  3%      +0.2        0.99 ±  5%  perf-profile.calltrace.cycles-pp.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.81 ±  3%      +0.2        0.99 ±  5%  perf-profile.calltrace.cycles-pp.populate_vma_page_range.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.57 ±  8%      +0.2        0.75 ±  7%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.unmap_region.do_vmi_align_munmap
      1.53            +0.2        1.71        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.61 ±  7%      +0.2        0.79 ±  6%  perf-profile.calltrace.cycles-pp.lru_add_drain.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.92            +0.2        2.13        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_mmap_set
      3.15            +0.3        3.44        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_mmap_set
      3.21            +0.3        3.51        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_mmap_set
      0.38 ± 70%      +0.3        0.68 ±  9%  perf-profile.calltrace.cycles-pp.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
      0.85 ± 13%      +0.4        1.20 ± 10%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain
      0.94 ± 12%      +0.4        1.30 ±  9%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain.free_pages_and_swap_cache.tlb_batch_pages_flush
      0.92 ± 12%      +0.4        1.30 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain.free_pages_and_swap_cache
      4.31            +0.4        4.70        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_mmap_set
      1.39 ±  9%      +0.4        1.83 ±  7%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain.free_pages_and_swap_cache.tlb_batch_pages_flush.zap_pte_range
      1.43 ±  9%      +0.4        1.87 ±  7%  perf-profile.calltrace.cycles-pp.lru_add_drain.free_pages_and_swap_cache.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range
      0.08 ±223%      +0.5        0.59 ±  6%  perf-profile.calltrace.cycles-pp.mlock_folio.do_set_pte.filemap_map_pages.do_read_fault.do_fault
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.page_remove_rmap.tlb_flush_rmaps.zap_pte_range.zap_pmd_range.unmap_page_range
      1.63 ± 11%      +0.7        2.35 ± 10%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.folio_lruvec_lock_irq.__munlock_folio.mlock_folio_batch
      1.80 ± 10%      +0.8        2.56 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.folio_lruvec_lock_irq.__munlock_folio.mlock_folio_batch.mlock_drain_local
      1.82 ± 10%      +0.8        2.60 ±  9%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irq.__munlock_folio.mlock_folio_batch.mlock_drain_local.free_pages_and_swap_cache
      2.39 ±  8%      +0.9        3.27 ±  7%  perf-profile.calltrace.cycles-pp.__munlock_folio.mlock_folio_batch.mlock_drain_local.free_pages_and_swap_cache.tlb_batch_pages_flush
      2.62 ±  8%      +0.9        3.56 ±  7%  perf-profile.calltrace.cycles-pp.mlock_drain_local.free_pages_and_swap_cache.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range
      2.61 ±  8%      +0.9        3.55 ±  7%  perf-profile.calltrace.cycles-pp.mlock_folio_batch.mlock_drain_local.free_pages_and_swap_cache.tlb_batch_pages_flush.zap_pte_range
      4.09 ±  8%      +1.4        5.47 ±  7%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range.unmap_page_range
      4.44 ±  8%      +1.4        5.84 ±  6%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     21.82            +1.6       23.46        perf-profile.calltrace.cycles-pp.stress_mmap_set
      7.10 ±  5%      +1.7        8.81 ±  4%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      7.27 ±  5%      +1.7        8.98 ±  4%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      7.48 ±  4%      +1.7        9.21 ±  4%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      7.65 ±  4%      +1.7        9.38 ±  4%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      9.49 ±  4%      +2.0       11.51 ±  4%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     28.16            +2.4       30.54        perf-profile.calltrace.cycles-pp.stress_mmap_check
      7.92 ±  5%      -5.5        2.45 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      6.63 ±  3%      -4.8        1.81        perf-profile.children.cycles-pp.mas_alloc_nodes
     43.54            -4.7       38.81        perf-profile.children.cycles-pp.do_syscall_64
     43.79            -4.7       39.08        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.63 ±  3%      -4.6        1.03        perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      9.66 ±  6%      -4.5        5.13 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      5.40 ±  4%      -4.4        0.96        perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      4.72 ±  3%      -4.2        0.48 ±  2%  perf-profile.children.cycles-pp.mas_destroy
      7.83            -4.1        3.77        perf-profile.children.cycles-pp.mas_store_prealloc
      5.08 ±  4%      -3.9        1.14 ±  2%  perf-profile.children.cycles-pp.___slab_alloc
      5.33 ±  3%      -3.8        1.54        perf-profile.children.cycles-pp.mas_preallocate
     11.31            -3.8        7.54        perf-profile.children.cycles-pp.mmap_region
     11.56            -3.8        7.81        perf-profile.children.cycles-pp.do_mmap
      3.87 ±  6%      -3.6        0.24 ±  6%  perf-profile.children.cycles-pp.get_partial_node
     12.62            -3.6        9.06        perf-profile.children.cycles-pp.vm_mmap_pgoff
     12.74            -3.5        9.20        perf-profile.children.cycles-pp.ksys_mmap_pgoff
      8.27            -3.5        4.75        perf-profile.children.cycles-pp.__split_vma
     13.06            -3.5        9.56        perf-profile.children.cycles-pp.__mmap
      3.38 ±  3%      -3.2        0.19 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
      3.51 ±  5%      -3.0        0.51 ±  6%  perf-profile.children.cycles-pp.__unfreeze_partials
      3.86            -1.9        1.93        perf-profile.children.cycles-pp.vma_complete
      1.47 ±  7%      -1.4        0.06 ±  7%  perf-profile.children.cycles-pp.get_any_partial
      6.10            -1.2        4.92        perf-profile.children.cycles-pp.madvise_vma_behavior
      7.85            -1.1        6.79        perf-profile.children.cycles-pp.do_madvise
      7.89            -1.1        6.84        perf-profile.children.cycles-pp.__x64_sys_madvise
      9.47            -0.9        8.53        perf-profile.children.cycles-pp.__madvise
      5.30            -0.3        4.96        perf-profile.children.cycles-pp.mas_store_gfp
      1.67 ±  2%      -0.3        1.41        perf-profile.children.cycles-pp.mas_rebalance
      3.74            -0.1        3.59        perf-profile.children.cycles-pp.mas_wr_bnode
      0.30 ±  3%      -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.mas_nomem
      0.13 ±  2%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.put_cpu_partial
      3.46            -0.1        3.40        perf-profile.children.cycles-pp.mas_wr_store_entry
      2.39            -0.1        2.34        perf-profile.children.cycles-pp.mas_wr_node_store
      0.39 ±  2%      -0.0        0.34 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.lru_add_fn
      0.14 ±  3%      +0.0        0.15        perf-profile.children.cycles-pp.get_unmapped_area
      0.11 ±  4%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.kmalloc_trace
      0.14 ±  3%      +0.0        0.15        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.29            +0.0        0.30        perf-profile.children.cycles-pp.mtree_load
      0.19 ±  4%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.prepend_path
      0.30 ±  2%      +0.0        0.32        perf-profile.children.cycles-pp.mas_prev_node
      0.24 ±  2%      +0.0        0.25        perf-profile.children.cycles-pp.down_write_killable
      0.20 ±  3%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.reclaim_pages
      0.17 ±  2%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.21 ±  3%      +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.fault_dirty_shared_page
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__alloc_pages
      0.45            +0.0        0.47 ±  2%  perf-profile.children.cycles-pp.mas_mab_cp
      0.37            +0.0        0.39        perf-profile.children.cycles-pp.mas_pop_node
      0.35 ±  3%      +0.0        0.37 ±  2%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.30 ±  2%      +0.0        0.32        perf-profile.children.cycles-pp.scheduler_tick
      0.38            +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.__perf_sw_event
      0.29 ±  3%      +0.0        0.31        perf-profile.children.cycles-pp.d_path
      0.16 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.mas_split_final_node
      0.18 ±  2%      +0.0        0.20        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.32 ±  2%      +0.0        0.34 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.16 ±  4%      +0.0        0.19 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.04 ± 44%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.38            +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.07 ±  8%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.setup_object
      0.38            +0.0        0.41        perf-profile.children.cycles-pp.mas_ascend
      0.35            +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      0.35            +0.0        0.38        perf-profile.children.cycles-pp.update_process_times
      0.28            +0.0        0.31 ±  2%  perf-profile.children.cycles-pp.madvise_cold
      0.44            +0.0        0.47        perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.43 ±  2%      +0.0        0.46 ±  2%  perf-profile.children.cycles-pp.mas_descend_adopt
      0.04 ± 44%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.inc_slabs_node
      0.44            +0.0        0.48        perf-profile.children.cycles-pp.lock_mm_and_find_vma
      0.42            +0.0        0.45 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.37            +0.0        0.41 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      0.34            +0.0        0.37        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.37            +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.14 ±  3%      +0.0        0.18 ±  5%  perf-profile.children.cycles-pp.follow_page_pte
      0.45            +0.0        0.48 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.19 ±  5%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.46            +0.0        0.49 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.43            +0.0        0.47 ±  2%  perf-profile.children.cycles-pp.__entry_text_start
      0.42            +0.0        0.46 ±  2%  perf-profile.children.cycles-pp.shmem_fault
      0.53            +0.0        0.57        perf-profile.children.cycles-pp.native_irq_return_iret
      0.63            +0.0        0.67        perf-profile.children.cycles-pp.mas_prev_slot
      0.46            +0.0        0.50 ±  2%  perf-profile.children.cycles-pp.__do_fault
      0.63            +0.0        0.67 ±  2%  perf-profile.children.cycles-pp.sync_regs
      0.16 ±  3%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.45 ±  2%      +0.0        0.49        perf-profile.children.cycles-pp.mas_update_gap
      0.61            +0.0        0.65        perf-profile.children.cycles-pp.down_write
      0.39            +0.0        0.44        perf-profile.children.cycles-pp.up_write
      0.58            +0.0        0.62 ±  2%  perf-profile.children.cycles-pp.unlink_file_vma
      0.55            +0.0        0.60        perf-profile.children.cycles-pp.find_vma
      0.07            +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.mas_wr_store_setup
      0.53            +0.0        0.58        perf-profile.children.cycles-pp.vma_prepare
      0.61            +0.0        0.66        perf-profile.children.cycles-pp.perf_event_mmap_output
      0.32 ±  3%      +0.0        0.37 ±  3%  perf-profile.children.cycles-pp.folio_activate_fn
      0.12            +0.1        0.17        perf-profile.children.cycles-pp.mas_is_span_wr
      0.78            +0.1        0.83        perf-profile.children.cycles-pp.vma_merge
      0.75            +0.1        0.80        perf-profile.children.cycles-pp.mas_wmb_replace
      0.59            +0.1        0.64        perf-profile.children.cycles-pp.mas_next_slot
      0.69 ±  2%      +0.1        0.75        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.60 ±  2%      +0.1        0.65 ±  2%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.22 ±  2%      +0.1        0.27 ±  2%  perf-profile.children.cycles-pp.workingset_activation
      1.04            +0.1        1.09        perf-profile.children.cycles-pp.mas_find
      0.55            +0.1        0.61 ±  2%  perf-profile.children.cycles-pp.mab_mas_cp
      0.72            +0.1        0.78        perf-profile.children.cycles-pp.perf_iterate_sb
      0.89            +0.1        0.94        perf-profile.children.cycles-pp.__call_rcu_common
      0.69            +0.1        0.76        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.76            +0.1        0.83        perf-profile.children.cycles-pp.stress_mwc64modn
      0.45            +0.1        0.52 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.79            +0.1        0.86        perf-profile.children.cycles-pp.free_pgtables
      0.84            +0.1        0.91        perf-profile.children.cycles-pp.mt_find
      1.16            +0.1        1.22        perf-profile.children.cycles-pp.find_vma_prev
      0.78            +0.1        0.84        perf-profile.children.cycles-pp.flush_tlb_func
      0.79            +0.1        0.86        perf-profile.children.cycles-pp.mas_push_data
      0.43 ±  2%      +0.1        0.50        perf-profile.children.cycles-pp.release_pages
      0.32 ±  3%      +0.1        0.39 ±  2%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.32 ±  2%      +0.1        0.40 ±  4%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.89            +0.1        0.97        perf-profile.children.cycles-pp.stress_tmpfs_child
      0.52            +0.1        0.60 ±  2%  perf-profile.children.cycles-pp.finish_fault
      1.00            +0.1        1.08        perf-profile.children.cycles-pp.flush_tlb_mm_range
      1.25            +0.1        1.34 ±  4%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.92            +0.1        1.01        perf-profile.children.cycles-pp.vm_area_alloc
      1.30            +0.1        1.40        perf-profile.children.cycles-pp.mas_spanning_rebalance
      0.51 ±  2%      +0.1        0.60        perf-profile.children.cycles-pp.page_remove_rmap
      0.23 ±  7%      +0.1        0.33 ±  7%  perf-profile.children.cycles-pp.shuffle_freelist
      0.55 ±  2%      +0.1        0.65        perf-profile.children.cycles-pp.tlb_flush_rmaps
      0.96            +0.1        1.06        perf-profile.children.cycles-pp.vm_area_dup
      1.34            +0.1        1.45        perf-profile.children.cycles-pp.perf_event_mmap_event
      0.40 ±  6%      +0.1        0.51 ±  6%  perf-profile.children.cycles-pp.__mlock_folio
      1.40            +0.1        1.51        perf-profile.children.cycles-pp.perf_event_mmap
      0.32 ± 10%      +0.1        0.44 ±  6%  perf-profile.children.cycles-pp.folio_isolate_lru
      1.95            +0.1        2.06        perf-profile.children.cycles-pp.mas_walk
      0.47 ±  5%      +0.1        0.59 ±  6%  perf-profile.children.cycles-pp.mlock_folio
      0.31 ±  7%      +0.1        0.43 ±  7%  perf-profile.children.cycles-pp.allocate_slab
      1.57            +0.1        1.70        perf-profile.children.cycles-pp.mas_split
      0.62 ±  4%      +0.1        0.76 ±  5%  perf-profile.children.cycles-pp.filemap_map_pages
      0.66 ±  5%      +0.1        0.80 ±  3%  perf-profile.children.cycles-pp.madvise_cold_or_pageout_pte_range
      0.63 ±  4%      +0.1        0.77 ±  4%  perf-profile.children.cycles-pp.do_read_fault
      0.69 ±  5%      +0.1        0.84 ±  3%  perf-profile.children.cycles-pp.walk_pud_range
      0.70 ±  5%      +0.1        0.85 ±  2%  perf-profile.children.cycles-pp.walk_p4d_range
      0.67 ±  5%      +0.1        0.82 ±  3%  perf-profile.children.cycles-pp.walk_pmd_range
      0.72 ±  5%      +0.1        0.87 ±  2%  perf-profile.children.cycles-pp.walk_pgd_range
      2.36            +0.1        2.51        perf-profile.children.cycles-pp.mtree_range_walk
      0.00            +0.2        0.15 ±  2%  perf-profile.children.cycles-pp.mas_wr_end_piv
      0.74 ±  5%      +0.2        0.89 ±  3%  perf-profile.children.cycles-pp.__walk_page_range
      0.83 ±  4%      +0.2        0.98 ±  2%  perf-profile.children.cycles-pp.madvise_pageout
      1.58            +0.2        1.74 ±  2%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.64 ±  2%      +0.2        0.80        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.96 ±  3%      +0.2        1.13 ±  2%  perf-profile.children.cycles-pp.walk_page_range
      0.81 ±  3%      +0.2        0.98 ±  5%  perf-profile.children.cycles-pp.__get_user_pages
      0.81 ±  3%      +0.2        0.99 ±  5%  perf-profile.children.cycles-pp.__mm_populate
      0.81 ±  3%      +0.2        0.99 ±  5%  perf-profile.children.cycles-pp.populate_vma_page_range
      0.67 ±  7%      +0.2        0.85 ±  5%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.91 ±  3%      +0.2        1.12 ±  3%  perf-profile.children.cycles-pp.do_set_pte
      0.72 ±  2%      +0.2        0.93        perf-profile.children.cycles-pp.mas_wr_walk
      1.86 ±  2%      +0.3        2.15        perf-profile.children.cycles-pp.do_fault
      3.18            +0.3        3.48        perf-profile.children.cycles-pp.do_user_addr_fault
      3.22            +0.3        3.53        perf-profile.children.cycles-pp.exc_page_fault
      2.17            +0.3        2.50        perf-profile.children.cycles-pp.__handle_mm_fault
      2.58            +0.3        2.92        perf-profile.children.cycles-pp.handle_mm_fault
      5.07            +0.4        5.50        perf-profile.children.cycles-pp.asm_exc_page_fault
      1.38 ± 11%      +0.5        1.92 ±  9%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      2.08 ±  8%      +0.6        2.70 ±  6%  perf-profile.children.cycles-pp.lru_add_drain
      2.02 ±  9%      +0.6        2.66 ±  7%  perf-profile.children.cycles-pp.folio_batch_move_lru
      2.40 ±  8%      +0.9        3.28 ±  7%  perf-profile.children.cycles-pp.__munlock_folio
      2.20 ± 10%      +0.9        3.14 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      2.64 ±  8%      +0.9        3.58 ±  7%  perf-profile.children.cycles-pp.mlock_drain_local
      2.24 ± 10%      +0.9        3.19 ±  9%  perf-profile.children.cycles-pp.folio_lruvec_lock_irq
      3.05 ±  8%      +1.1        4.11 ±  7%  perf-profile.children.cycles-pp.mlock_folio_batch
      4.11 ±  8%      +1.4        5.49 ±  7%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      4.48 ±  8%      +1.4        5.90 ±  6%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
     22.46            +1.7       24.15        perf-profile.children.cycles-pp.stress_mmap_set
      7.17 ±  5%      +1.7        8.88 ±  4%  perf-profile.children.cycles-pp.zap_pte_range
      7.28 ±  5%      +1.7        9.00 ±  4%  perf-profile.children.cycles-pp.zap_pmd_range
      7.49 ±  4%      +1.7        9.22 ±  4%  perf-profile.children.cycles-pp.unmap_page_range
      7.66 ±  4%      +1.7        9.40 ±  4%  perf-profile.children.cycles-pp.unmap_vmas
      9.51 ±  4%      +2.0       11.53 ±  4%  perf-profile.children.cycles-pp.unmap_region
     28.17            +2.4       30.55        perf-profile.children.cycles-pp.stress_mmap_check
      9.66 ±  6%      -4.5        5.13 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.01            -0.9        0.12 ±  3%  perf-profile.self.cycles-pp.kmem_cache_free_bulk
      0.98            -0.6        0.37 ±  3%  perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.78 ±  2%      -0.4        0.36 ±  3%  perf-profile.self.cycles-pp.___slab_alloc
      0.27 ±  4%      -0.2        0.08 ±  5%  perf-profile.self.cycles-pp.get_partial_node
      0.28 ±  2%      -0.2        0.11 ±  3%  perf-profile.self.cycles-pp.__unfreeze_partials
      0.17 ±  4%      -0.1        0.05        perf-profile.self.cycles-pp.kmem_cache_alloc_bulk
      0.12 ±  3%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.put_cpu_partial
      0.31 ±  2%      -0.1        0.22 ±  2%  perf-profile.self.cycles-pp.mas_wr_store_entry
      0.95            -0.1        0.88 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      0.16 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.mas_alloc_nodes
      0.38            -0.0        0.34 ±  3%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.26 ±  2%      -0.0        0.22 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.10 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp.mas_destroy
      0.27            +0.0        0.28        perf-profile.self.cycles-pp.___perf_sw_event
      0.09 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.page_remove_rmap
      0.07 ±  5%      +0.0        0.08        perf-profile.self.cycles-pp.unlink_file_vma
      0.08 ±  4%      +0.0        0.09        perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.27 ±  2%      +0.0        0.28        perf-profile.self.cycles-pp.mtree_load
      0.10 ±  4%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      0.16            +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.mt_find
      0.12            +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__munmap
      0.11            +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.mast_fill_bnode
      0.18 ±  2%      +0.0        0.19        perf-profile.self.cycles-pp.unmap_page_range
      0.15 ±  5%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.mas_update_gap
      0.26            +0.0        0.28        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.25            +0.0        0.27        perf-profile.self.cycles-pp.__list_add_valid
      0.25 ±  2%      +0.0        0.27 ±  2%  perf-profile.self.cycles-pp.do_madvise
      0.21 ±  3%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.unmap_region
      0.11 ±  4%      +0.0        0.13 ±  5%  perf-profile.self.cycles-pp.folio_activate_fn
      0.16 ±  4%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.14 ±  2%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.34 ±  2%      +0.0        0.36        perf-profile.self.cycles-pp.mas_pop_node
      0.28 ±  2%      +0.0        0.30 ±  2%  perf-profile.self.cycles-pp.mas_spanning_rebalance
      0.21 ±  2%      +0.0        0.23 ±  3%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.16 ±  3%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.mas_push_data
      0.10 ±  4%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.__mlock_folio
      0.24            +0.0        0.26 ±  3%  perf-profile.self.cycles-pp.mas_store_gfp
      0.43 ±  3%      +0.0        0.46        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.32 ±  2%      +0.0        0.34 ±  2%  perf-profile.self.cycles-pp.mas_prev_slot
      0.28            +0.0        0.31        perf-profile.self.cycles-pp.mas_walk
      0.31 ±  2%      +0.0        0.33 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.68            +0.0        0.70        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.04 ± 44%      +0.0        0.07 ±  8%  perf-profile.self.cycles-pp.inc_slabs_node
      0.24 ±  3%      +0.0        0.27 ±  5%  perf-profile.self.cycles-pp._compound_head
      0.41 ±  2%      +0.0        0.44        perf-profile.self.cycles-pp.mas_descend_adopt
      0.35            +0.0        0.38        perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.38 ±  2%      +0.0        0.41        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.34 ±  2%      +0.0        0.38        perf-profile.self.cycles-pp.mas_ascend
      0.15 ±  6%      +0.0        0.18 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.37            +0.0        0.40 ±  2%  perf-profile.self.cycles-pp.madvise_vma_behavior
      0.39 ±  3%      +0.0        0.42        perf-profile.self.cycles-pp.perf_event_mmap_output
      0.46            +0.0        0.50        perf-profile.self.cycles-pp.down_write
      0.49 ±  2%      +0.0        0.53        perf-profile.self.cycles-pp.__call_rcu_common
      0.40            +0.0        0.44        perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.62            +0.0        0.66 ±  2%  perf-profile.self.cycles-pp.sync_regs
      0.43            +0.0        0.47        perf-profile.self.cycles-pp.zap_pte_range
      0.44            +0.0        0.48        perf-profile.self.cycles-pp.mas_next_slot
      0.53            +0.0        0.57        perf-profile.self.cycles-pp.native_irq_return_iret
      0.35            +0.0        0.39        perf-profile.self.cycles-pp.up_write
      0.09 ±  5%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.mas_is_span_wr
      0.45            +0.0        0.49        perf-profile.self.cycles-pp.mab_mas_cp
      0.15 ±  4%      +0.0        0.19 ±  3%  perf-profile.self.cycles-pp.workingset_age_nonresident
      0.23 ±  2%      +0.0        0.28        perf-profile.self.cycles-pp.__split_vma
      0.51            +0.0        0.55        perf-profile.self.cycles-pp.mmap_region
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.folio_lruvec_lock_irq
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.apparmor_mmap_file
      0.20 ±  5%      +0.1        0.25 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.40 ±  2%      +0.1        0.46 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
      0.56            +0.1        0.61 ±  2%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.68            +0.1        0.74        perf-profile.self.cycles-pp.stress_mwc64modn
      0.30 ±  4%      +0.1        0.36 ±  2%  perf-profile.self.cycles-pp.release_pages
      0.69            +0.1        0.75        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.mas_wr_store_setup
      0.30 ±  4%      +0.1        0.37 ±  2%  perf-profile.self.cycles-pp.__munlock_folio
      0.80            +0.1        0.88        perf-profile.self.cycles-pp.stress_tmpfs_child
      1.23            +0.1        1.32 ±  3%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.18 ±  7%      +0.1        0.26 ±  7%  perf-profile.self.cycles-pp.shuffle_freelist
      0.44 ±  2%      +0.1        0.57 ±  2%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.00            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.mas_wr_end_piv
      2.23            +0.1        2.37        perf-profile.self.cycles-pp.mtree_range_walk
      0.60 ±  2%      +0.2        0.76        perf-profile.self.cycles-pp.mas_wr_walk
      0.00            +0.2        0.23        perf-profile.self.cycles-pp.mas_preallocate
     17.11            +1.3       18.40        perf-profile.self.cycles-pp.stress_mmap_set
     26.96            +2.4       29.32        perf-profile.self.cycles-pp.stress_mmap_check



***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  memory/gcc-12/performance/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/tmpfs/stress-ng/60s

commit: 
  0b8bb544b1 ("maple_tree: update mas_preallocate() testing")
  17983dc617 ("maple_tree: refine mas_preallocate() node calculations")

0b8bb544b1a7051c 17983dc617837a588a52848ab40 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      8578 ±  4%      -7.9%       7902 ±  4%  turbostat.C1
    527768 ±  2%      -8.1%     485168 ±  5%  meminfo.Inactive
    527620 ±  2%      -8.1%     485021 ±  5%  meminfo.Inactive(anon)
   4896677 ±  4%     +14.3%    5597392 ±  7%  stress-ng.time.minor_page_faults
     93.00            -1.1%      92.00        stress-ng.time.percent_of_cpu_this_job_got
     32.67            +4.1%      34.00        stress-ng.tmpfs.ops
      0.54            +4.9%       0.57        stress-ng.tmpfs.ops_per_sec
    131892 ±  2%      -8.1%     121258 ±  5%  proc-vmstat.nr_inactive_anon
    131892 ±  2%      -8.1%     121258 ±  5%  proc-vmstat.nr_zone_inactive_anon
    642314            +2.4%     657789        proc-vmstat.numa_hit
    646535            +3.0%     665653        proc-vmstat.numa_local
    882759            +3.2%     911244        proc-vmstat.pgalloc_normal
   5099852 ±  4%     +13.8%    5802813 ±  6%  proc-vmstat.pgfault
    741768 ±  5%     +10.9%     822608 ±  7%  proc-vmstat.pgfree
    230.56 ±  5%     -17.8%     189.44 ± 12%  sched_debug.cfs_rq:/.load_avg.avg
    141.17           -20.3%     112.52 ± 20%  sched_debug.cfs_rq:/.removed.load_avg.avg
    351.53           -10.1%     316.08 ±  9%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    663.10 ±  2%     -10.3%     595.01        sched_debug.cfs_rq:/.runnable_avg.avg
      1995 ±  7%     -25.3%       1491 ±  8%  sched_debug.cfs_rq:/.runnable_avg.max
     29.67 ±124%     -97.8%       0.67 ± 70%  sched_debug.cfs_rq:/.runnable_avg.min
    660.56 ±  2%     -10.2%     593.32        sched_debug.cfs_rq:/.util_avg.avg
      1994 ±  7%     -25.3%       1490 ±  8%  sched_debug.cfs_rq:/.util_avg.max
     30.00 ±122%     -97.8%       0.67 ± 70%  sched_debug.cfs_rq:/.util_avg.min
     19912 ±  3%     +39.0%      27668 ±  8%  sched_debug.cpu.nr_switches.max
      4862 ±  4%     +19.3%       5801 ±  4%  sched_debug.cpu.nr_switches.stddev
     16.67 ± 20%     -32.0%      11.33 ± 11%  sched_debug.cpu.nr_uninterruptible.max
      0.00          +333.3%       0.01 ± 46%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    132.03 ± 32%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      1.33 ± 35%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
    156.63 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      3620 ± 11%     -35.5%       2336 ± 20%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.20 ± 69%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.unmap_region
    132.03 ± 32%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.01 ±141%    +344.4%       0.05 ± 38%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
      0.21 ±136%    +269.6%       0.77 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.11 ± 93%     -95.8%       0.00 ± 72%  perf-sched.wait_time.avg.ms.__cond_resched.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range.isra
      0.34 ± 20%     -94.0%       0.02 ± 92%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      0.08 ±  3%      +9.5%       0.09 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      0.33 ± 93%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.unmap_region
    156.63 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.01 ±141%    +405.6%       0.06 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
      0.24 ±136%    +224.3%       0.77 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.29 ±105%     -98.4%       0.00 ± 72%  perf-sched.wait_time.max.ms.__cond_resched.tlb_batch_pages_flush.zap_pte_range.zap_pmd_range.isra
      1.28 ±  9%     -93.4%       0.08 ±121%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
      3620 ± 11%     -35.5%       2336 ± 20%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
 2.007e+09            +3.0%  2.068e+09        perf-stat.i.branch-instructions
      1.14            -0.1        1.05        perf-stat.i.branch-miss-rate%
  23886819            -3.8%   22973412        perf-stat.i.branch-misses
     43.32            +1.5       44.82        perf-stat.i.cache-miss-rate%
  10695531            +5.1%   11236145        perf-stat.i.cache-misses
  22637852            +3.0%   23310283        perf-stat.i.cache-references
      0.55            -2.4%       0.53        perf-stat.i.cpi
      1216 ±  4%     -21.9%     949.50 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.01 ±  9%      +0.0        0.02 ± 10%  perf-stat.i.dTLB-load-miss-rate%
    156852 ±  9%     +31.7%     206629 ±  9%  perf-stat.i.dTLB-load-misses
      0.05 ±  5%      +0.0        0.05 ±  4%  perf-stat.i.dTLB-store-miss-rate%
    430735 ±  5%     +13.9%     490520 ±  4%  perf-stat.i.dTLB-store-misses
 8.571e+08            +1.7%  8.719e+08        perf-stat.i.dTLB-stores
     51.65            +1.2       52.84        perf-stat.i.iTLB-load-miss-rate%
   1331538 ±  2%      +6.3%    1415929        perf-stat.i.iTLB-load-misses
   1245333            +1.6%    1265257        perf-stat.i.iTLB-loads
 1.001e+10            +2.8%  1.029e+10        perf-stat.i.instructions
      7971            -3.4%       7699        perf-stat.i.instructions-per-iTLB-miss
      1.88            +2.2%       1.93        perf-stat.i.ipc
    115.63            +2.1%     118.05        perf-stat.i.metric.M/sec
    738181            +5.1%     775708        perf-stat.i.node-stores
      1.19            -0.1        1.11        perf-stat.overall.branch-miss-rate%
     47.24            +1.0       48.20        perf-stat.overall.cache-miss-rate%
      0.54            -2.1%       0.53        perf-stat.overall.cpi
    503.89            -4.2%     482.56        perf-stat.overall.cycles-between-cache-misses
      0.01 ±  9%      +0.0        0.02 ±  9%  perf-stat.overall.dTLB-load-miss-rate%
      0.05 ±  5%      +0.0        0.06 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
     51.67            +1.1       52.81        perf-stat.overall.iTLB-load-miss-rate%
      7519            -3.4%       7264        perf-stat.overall.instructions-per-iTLB-miss
      1.86            +2.1%       1.90        perf-stat.overall.ipc
 1.975e+09            +3.0%  2.035e+09        perf-stat.ps.branch-instructions
  23511838            -3.8%   22608120        perf-stat.ps.branch-misses
  10524774            +5.1%   11057675        perf-stat.ps.cache-misses
  22277601            +3.0%   22940376        perf-stat.ps.cache-references
    154366 ±  9%     +31.7%     203351 ±  9%  perf-stat.ps.dTLB-load-misses
    423832 ±  5%     +13.9%     482733 ±  4%  perf-stat.ps.dTLB-store-misses
 8.434e+08            +1.7%  8.581e+08        perf-stat.ps.dTLB-stores
   1310364 ±  2%      +6.3%    1393509        perf-stat.ps.iTLB-load-misses
   1225475            +1.6%    1245174        perf-stat.ps.iTLB-loads
  9.85e+09            +2.8%  1.012e+10        perf-stat.ps.instructions
    726396            +5.1%     763406        perf-stat.ps.node-stores
 6.216e+11            +2.8%  6.387e+11        perf-stat.total.instructions
      6.51 ±  8%      -2.3        4.21 ±  3%  perf-profile.calltrace.cycles-pp.__mmap
      6.16 ±  9%      -2.3        3.89 ±  3%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      6.36 ±  8%      -2.3        4.10 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      6.33 ±  8%      -2.3        4.07 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      6.27 ±  8%      -2.2        4.03 ±  3%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      5.40            -1.9        3.52 ±  4%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.21            -1.8        3.39 ±  5%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      2.30 ±  3%      -1.1        1.20 ±  6%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      3.79 ±  6%      -1.0        2.75 ±  6%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     13.96            -1.0       12.97 ±  4%  perf-profile.calltrace.cycles-pp.__munmap
     13.63            -1.0       12.66 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     13.53            -1.0       12.57 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     13.43            -0.9       12.49 ±  4%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     13.45            -0.9       12.51 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     13.19            -0.9       12.28 ±  4%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.06 ±  3%      -0.9        2.15 ± 10%  perf-profile.calltrace.cycles-pp.__split_vma.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
     12.61 ±  2%      -0.9       11.72 ±  4%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      7.66 ±  2%      -0.9        6.77 ±  2%  perf-profile.calltrace.cycles-pp.__madvise
      6.61 ±  2%      -0.8        5.78 ±  4%  perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      1.66 ±  4%      -0.8        0.84 ± 17%  perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      1.50 ±  2%      -0.8        0.68 ± 15%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.madvise_vma_behavior.do_madvise
      6.81 ±  2%      -0.8        6.00 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
      6.76 ±  2%      -0.8        5.95 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      6.65 ±  2%      -0.8        5.85 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      4.87 ±  3%      -0.8        4.09 ±  6%  perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.71 ±  6%      -0.7        1.00 ± 10%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      2.01 ±  6%      -0.7        1.31 ± 10%  perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.87 ±  6%      -0.2        0.67 ±  4%  perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff
      0.76 ±  5%      -0.2        0.60 ±  2%  perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region.do_mmap
      0.99 ±  6%      -0.1        0.85 ±  8%  perf-profile.calltrace.cycles-pp.mtree_range_walk.mas_walk.find_vma_prev.do_madvise.__x64_sys_madvise
      1.28 ±  5%      -0.1        1.15 ±  4%  perf-profile.calltrace.cycles-pp.find_vma_prev.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.74 ±  9%      -0.1        0.63 ±  3%  perf-profile.calltrace.cycles-pp.vma_merge.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      0.62 ±  7%      +0.1        0.69 ±  5%  perf-profile.calltrace.cycles-pp.mas_wr_walk.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      0.61 ± 12%      +0.1        0.73 ± 13%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.40 ± 71%      +0.4        0.80 ±  8%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.84 ± 28%      +0.4        1.29 ± 14%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_mmap_set
      0.50 ± 72%      +0.5        1.02 ± 11%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.51 ± 22%      +0.5        2.03 ± 10%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_mmap_set
      1.54 ± 22%      +0.5        2.08 ± 11%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_mmap_set
      1.11 ± 14%      +0.6        1.69 ±  7%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      1.06 ± 13%      +0.6        1.66 ±  5%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      0.00            +0.6        0.60 ± 10%  perf-profile.calltrace.cycles-pp.madvise_pageout.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      1.54 ± 13%      +0.7        2.19 ±  2%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      2.07 ± 12%      +0.7        2.78 ±  3%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.75 ± 12%      +0.7        2.49 ±  3%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      1.78 ± 13%      +0.8        2.54 ±  3%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      2.71 ±  9%      +0.8        3.55 ±  5%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.40 ±  9%      +0.9        4.28 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.44 ±  9%      +0.9        4.33 ±  8%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      4.55 ±  9%      +1.2        5.79 ± 14%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      2.33 ± 38%      +1.5        3.80 ± 13%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_mmap_set
      4.95 ±  8%      +1.7        6.63 ± 19%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     27.67            -3.9       23.78 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     27.46            -3.9       23.59 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
      5.53            -2.6        2.90 ±  7%  perf-profile.children.cycles-pp.mas_store_prealloc
      6.55 ±  8%      -2.3        4.25 ±  3%  perf-profile.children.cycles-pp.__mmap
      2.92            -2.3        0.64 ±  9%  perf-profile.children.cycles-pp.mas_destroy
      6.19 ±  8%      -2.2        3.94 ±  3%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      6.29 ±  8%      -2.2        4.06 ±  3%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      6.87 ±  5%      -1.9        4.94 ±  8%  perf-profile.children.cycles-pp.__split_vma
      2.30 ±  2%      -1.9        0.41 ± 10%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
      5.43            -1.9        3.56 ±  4%  perf-profile.children.cycles-pp.do_mmap
      5.26            -1.8        3.44 ±  4%  perf-profile.children.cycles-pp.mmap_region
      2.18 ±  7%      -1.6        0.57 ± 12%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      2.53 ±  5%      -1.6        0.98 ±  6%  perf-profile.children.cycles-pp.mas_alloc_nodes
      3.68 ±  4%      -1.5        2.15 ± 11%  perf-profile.children.cycles-pp.vma_complete
      2.05 ±  8%      -1.5        0.52 ± 11%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      2.21 ±  8%      -1.2        1.05 ± 10%  perf-profile.children.cycles-pp.mas_preallocate
     14.04            -1.0       13.05 ±  4%  perf-profile.children.cycles-pp.__munmap
      1.38 ±  8%      -1.0        0.41 ±  5%  perf-profile.children.cycles-pp.___slab_alloc
     13.45            -0.9       12.50 ±  4%  perf-profile.children.cycles-pp.__vm_munmap
     13.45            -0.9       12.52 ±  4%  perf-profile.children.cycles-pp.__x64_sys_munmap
     13.60            -0.9       12.68 ±  4%  perf-profile.children.cycles-pp.do_vmi_munmap
     12.67 ±  2%      -0.9       11.76 ±  4%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      7.76 ±  2%      -0.9        6.87 ±  2%  perf-profile.children.cycles-pp.__madvise
      6.61 ±  2%      -0.8        5.79 ±  4%  perf-profile.children.cycles-pp.do_madvise
      6.65 ±  2%      -0.8        5.85 ±  4%  perf-profile.children.cycles-pp.__x64_sys_madvise
      4.87 ±  3%      -0.8        4.10 ±  6%  perf-profile.children.cycles-pp.madvise_vma_behavior
      1.37 ± 12%      -0.5        0.88 ±  4%  perf-profile.children.cycles-pp.__slab_free
      0.49 ± 62%      -0.4        0.13 ± 45%  perf-profile.children.cycles-pp.mlock_folio_batch
      2.73            -0.3        2.42 ±  3%  perf-profile.children.cycles-pp.mtree_range_walk
      0.35 ±  2%      -0.2        0.10 ± 37%  perf-profile.children.cycles-pp.__unfreeze_partials
      1.03 ±  3%      -0.2        0.80 ± 10%  perf-profile.children.cycles-pp.kmem_cache_free
      0.32 ± 19%      -0.2        0.10 ±  8%  perf-profile.children.cycles-pp.get_partial_node
      0.22 ± 46%      -0.2        0.07 ± 23%  perf-profile.children.cycles-pp.__munlock_folio
      2.18 ±  2%      -0.1        2.05 ±  4%  perf-profile.children.cycles-pp.mas_walk
      1.29 ±  5%      -0.1        1.16 ±  3%  perf-profile.children.cycles-pp.find_vma_prev
      0.22 ± 16%      -0.1        0.09 ± 35%  perf-profile.children.cycles-pp.put_cpu_partial
      0.74 ±  9%      -0.1        0.63 ±  3%  perf-profile.children.cycles-pp.vma_merge
      1.39            -0.1        1.30 ±  3%  perf-profile.children.cycles-pp.mas_split
      0.13 ± 31%      -0.1        0.05 ± 77%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.10 ± 12%      -0.1        0.05 ± 71%  perf-profile.children.cycles-pp.d_path
      0.09 ± 13%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.xas_find
      0.17 ±  7%      -0.0        0.13 ±  9%  perf-profile.children.cycles-pp.mas_store_b_node
      0.07            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.downgrade_write
      0.11 ±  8%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.perf_pmu_nop_void
      0.08 ± 10%      +0.0        0.11 ± 15%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.11 ±  7%      +0.0        0.14 ± 15%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.21 ± 10%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.hrtimer_wakeup
      0.10 ± 14%      +0.0        0.13 ± 12%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.21 ±  7%      +0.0        0.25 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      0.11 ± 11%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.03 ± 70%      +0.0        0.08 ± 17%  perf-profile.children.cycles-pp.ct_idle_exit
      0.30 ±  8%      +0.0        0.35 ±  2%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.02 ±141%      +0.1        0.07        perf-profile.children.cycles-pp.mas_wr_store_setup
      0.16 ± 15%      +0.1        0.21 ±  9%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.02 ±141%      +0.1        0.08 ± 30%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.05 ± 72%      +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.try_to_unmap
      0.67 ±  7%      +0.1        0.74 ±  3%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.19 ±  4%      +0.1        0.26 ± 12%  perf-profile.children.cycles-pp.native_sched_clock
      0.15 ±  5%      +0.1        0.22 ± 17%  perf-profile.children.cycles-pp.sched_clock
      0.15 ± 30%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.filemap_get_entry
      0.02 ±141%      +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.update_rq_clock
      0.16 ±  5%      +0.1        0.24 ± 18%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.48 ±  9%      +0.1        0.56 ±  3%  perf-profile.children.cycles-pp.flush_tlb_func
      0.12 ± 49%      +0.1        0.21 ± 16%  perf-profile.children.cycles-pp.rmap_walk_file
      0.22 ± 33%      +0.1        0.32 ±  6%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.25 ± 11%      +0.1        0.35 ± 13%  perf-profile.children.cycles-pp._compound_head
      0.02 ±141%      +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.error_entry
      0.27 ± 16%      +0.1        0.39 ± 22%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.26 ± 27%      +0.1        0.38 ±  8%  perf-profile.children.cycles-pp.__do_fault
      0.16 ± 23%      +0.1        0.29 ±  5%  perf-profile.children.cycles-pp.finish_fault
      0.24 ± 27%      +0.1        0.37 ±  6%  perf-profile.children.cycles-pp.shmem_fault
      0.00            +0.1        0.13 ± 33%  perf-profile.children.cycles-pp.mas_wr_end_piv
      0.17 ± 48%      +0.1        0.30 ± 12%  perf-profile.children.cycles-pp.shrink_folio_list
      0.18 ± 46%      +0.1        0.31 ±  9%  perf-profile.children.cycles-pp.reclaim_folio_list
      0.18 ± 46%      +0.1        0.32 ± 11%  perf-profile.children.cycles-pp.reclaim_pages
      0.90 ±  6%      +0.1        1.04 ±  4%  perf-profile.children.cycles-pp.mas_wr_walk
      0.30 ± 35%      +0.2        0.52 ± 13%  perf-profile.children.cycles-pp.walk_pud_range
      0.30 ± 35%      +0.2        0.51 ± 12%  perf-profile.children.cycles-pp.walk_pmd_range
      0.29 ± 37%      +0.2        0.51 ± 13%  perf-profile.children.cycles-pp.madvise_cold_or_pageout_pte_range
      0.32 ± 33%      +0.2        0.54 ± 10%  perf-profile.children.cycles-pp.walk_p4d_range
      0.32 ± 34%      +0.2        0.55 ± 10%  perf-profile.children.cycles-pp.__walk_page_range
      0.32 ± 33%      +0.2        0.55 ± 11%  perf-profile.children.cycles-pp.walk_pgd_range
      0.49 ± 20%      +0.2        0.72 ±  8%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.35 ± 28%      +0.2        0.60 ± 10%  perf-profile.children.cycles-pp.madvise_pageout
      0.48 ± 29%      +0.3        0.78 ±  6%  perf-profile.children.cycles-pp.walk_page_range
      1.57 ± 22%      +0.5        2.10 ± 10%  perf-profile.children.cycles-pp.do_user_addr_fault
      1.60 ± 22%      +0.6        2.15 ± 11%  perf-profile.children.cycles-pp.exc_page_fault
      1.23 ±  9%      +0.6        1.81 ±  5%  perf-profile.children.cycles-pp.perf_event_task_tick
      1.20 ±  9%      +0.6        1.78 ±  4%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      1.73 ±  9%      +0.7        2.41 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      2.32 ±  9%      +0.7        3.06 ±  6%  perf-profile.children.cycles-pp.tick_sched_timer
      1.97 ±  8%      +0.8        2.75 ±  4%  perf-profile.children.cycles-pp.update_process_times
      1.99 ±  9%      +0.8        2.80 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      3.82 ±  8%      +0.9        4.74 ± 10%  perf-profile.children.cycles-pp.hrtimer_interrupt
      3.05 ±  8%      +0.9        3.98 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      3.85 ±  8%      +0.9        4.79 ± 10%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.67 ± 26%      +1.0        3.65 ± 10%  perf-profile.children.cycles-pp.asm_exc_page_fault
      1.47            -1.2        0.27 ± 13%  perf-profile.self.cycles-pp.kmem_cache_free_bulk
      0.85 ±  9%      -0.7        0.19 ±  4%  perf-profile.self.cycles-pp.___slab_alloc
      0.82 ±  6%      -0.5        0.28 ± 11%  perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      1.33 ± 12%      -0.4        0.88 ±  4%  perf-profile.self.cycles-pp.__slab_free
      2.62            -0.3        2.32 ±  2%  perf-profile.self.cycles-pp.mtree_range_walk
      0.30 ±  4%      -0.2        0.08 ± 31%  perf-profile.self.cycles-pp.__unfreeze_partials
      0.81 ±  3%      -0.2        0.61 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free
      0.22 ± 11%      -0.2        0.06 ±  7%  perf-profile.self.cycles-pp.get_partial_node
      0.21 ± 18%      -0.1        0.07 ± 11%  perf-profile.self.cycles-pp.put_cpu_partial
      0.12 ± 33%      -0.1        0.05 ± 78%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.35 ± 15%      -0.1        0.29 ±  4%  perf-profile.self.cycles-pp.mas_pop_node
      0.21 ± 17%      -0.1        0.15 ±  6%  perf-profile.self.cycles-pp.mas_wr_store_entry
      0.14 ±  5%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      0.16 ± 18%      -0.0        0.13 ± 18%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.10 ±  4%      +0.0        0.12 ± 10%  perf-profile.self.cycles-pp.down_write_killable
      0.09 ± 13%      +0.0        0.12 ± 13%  perf-profile.self.cycles-pp.perf_pmu_nop_void
      0.06 ± 14%      +0.0        0.10 ± 12%  perf-profile.self.cycles-pp.handle_mm_fault
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.do_syscall_64
      0.02 ±141%      +0.0        0.06 ± 13%  perf-profile.self.cycles-pp.page_add_file_rmap
      0.30 ±  8%      +0.0        0.35 ±  2%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.19 ±  4%      +0.1        0.24 ± 13%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.mas_wr_store_setup
      0.02 ±141%      +0.1        0.07 ± 20%  perf-profile.self.cycles-pp.mas_store_prealloc
      0.00            +0.1        0.06 ± 23%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.00            +0.1        0.06 ± 23%  perf-profile.self.cycles-pp.madvise_cold_or_pageout_pte_range
      0.02 ±141%      +0.1        0.08 ± 24%  perf-profile.self.cycles-pp.filemap_get_entry
      0.28 ± 10%      +0.1        0.34 ±  7%  perf-profile.self.cycles-pp.mas_spanning_rebalance
      0.05 ± 74%      +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.mt_find
      0.26 ±  8%      +0.1        0.33 ±  9%  perf-profile.self.cycles-pp.menu_select
      0.23 ± 12%      +0.1        0.31 ± 18%  perf-profile.self.cycles-pp._compound_head
      0.02 ±141%      +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.error_entry
      0.00            +0.1        0.10 ± 29%  perf-profile.self.cycles-pp.mas_wr_end_piv
      0.78 ±  6%      +0.1        0.88 ±  2%  perf-profile.self.cycles-pp.mas_wr_walk
      0.00            +0.1        0.13 ± 14%  perf-profile.self.cycles-pp.mas_preallocate
      0.49 ± 20%      +0.2        0.72 ±  8%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.63 ±  5%      +0.4        0.98 ±  7%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

