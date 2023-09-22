Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102877AAF09
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjIVKCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjIVKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:01:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBF2195;
        Fri, 22 Sep 2023 03:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695376903; x=1726912903;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=LCcmJQVjRGdX3QzvLcL20AAZgF56uAl6GUFe8za/yBs=;
  b=ZvhE51It6tvr4ZftsgIuHRPgqjpbTopc9uba/IBHECmp9Nr4PcJn4g5w
   M2iRvYjsldU7NT++9REMI2cSua+X0Q3gmc2osBWt+Nr2CNOM3Dp0KbTUl
   Wsn0TvfhyVhGNOO9C4WJzFxg++UzyB4ZaucePci2auOxKIOOsyMjjHm0O
   3KPB7ROR0c1kU+8alW68sG2li/UBNYFEVimwEqh0usuzRcoy1elLNTuxe
   02Zmj4IOCSp+AH9Bq3oJWErLi72NM/ZE3IvG9jZkOx6myFKg9+bcTlGVp
   DcDC+5HbLP7JWOL6d+9Go/fO8+Pcu4H3ZbAPhhpNNd1ghhicztZUZUBMr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383539717"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="383539717"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 03:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="862886987"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="862886987"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 03:01:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 03:01:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 03:01:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 03:01:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/P9vyfi4Bopk/hJnm4xTYY1ub0wB0lstJRuuQCvI7oi+lqF3KCyeWpwQXsZjqrPN36NtKnJ0JR19oPFqOFnWMmH/N+7wY5fsrUKJL/m5+lnK+3AD3/AuE2YeYF6x/h2XKVkSF7LqLuDUh0PLtx705KfGP5MiU3vekJ4fChCUxgAyvAnPWMXUR+Ll8Lkk5WVFsRpORax+XC8wytynlmiEN252V6ZXgyKBuoR8Q0BPE1zsND/L/izvABtf7w3WpKGamcF2cuJD2ohpxtcOpAQTT6VSudaeQLCDwWncckN557ztxB+7ik2WIHj2gYwWSSjy+cnY4VMp4yUtjmQkrjR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKM6Owvpq8red6vjVwXDogqaWf+o7GYfqB7mpfkU21I=;
 b=aktIF1lqGFQAyxgf3sH9DW5mR9mbLbo3r+E+2ddZBe9fzXjYkkme0zNNPQRCIv7CjFcsnNlJ+RuXofG+uLnyYA0iaiByXDoaRzc6UgANYOZ5WttjxNPjWKEVWA6s2iF0HEAYFVULAFIBbQL56fkZnI9Rq6IVdpKeqsYgi6I00GX3gngryhNQHS+gbLURQsK13y2cmPWyBF8CZYr/+y03F99KiS7BEkIBRSpWMD3oBj8+ENkOp25bt+ccUv0wEc+yvfCKu5Wb0f8fETqdLfBZ73a42zibJa9m0p2MDubInFoF1hQzQ08CdxFFnCXp4mCx9XapZi3nFktSWnWDhl5D9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA1PR11MB6893.namprd11.prod.outlook.com (2603:10b6:806:2b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 10:01:12 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 10:01:12 +0000
Date:   Fri, 22 Sep 2023 18:00:59 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>,
        Mike Galbraith <efault@gmx.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        <linux-tip-commits@vger.kernel.org>, <x86@kernel.org>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH] sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER
 tasks
Message-ID: <202309221758.d655aa5b-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQljoiSBhZLEFI/G@gmail.com>
X-ClientProxiedBy: SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA1PR11MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 8903fa0a-6c0e-4d97-04f5-08dbbb52d983
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: filiEBW+fw1lvkh0oUGqFHRxzE7vNFx/Z0vJhITIOj9egC0Fkvd73Bu/KOv84X7BRdbuZBkmqWjFkOW8rdwFuWF1XmA62HDFl/JcJViFivsSJYgQbGMq2OmXw825zPD8MeqplHvCeYzq794jEq0xclv3FlCDl0XDwKT2JNKImJhsJ9/hVTK03xqY8mTffBhuff/4qTEfu1HIox0pBVpjXrLZapn9ur5ja4Zlyua3CTRjJQve8KGYKQaoajTtoyHZ/PtcoEjZl3xpKW2GjlNDWWABsJbl/KcEN4TMZcL6G6h96iLQ3/jlsWo9DPaWr5SlNTAZKvclgLE+MCaFWtrdiqECYw3wzNaSYpIonU7CVadS5iuuNS6368RSU50U/WViupdj+/jGBmYqkM4h/XO5kt5LWNs+1t5+bAgumtR7QqYUDsEARoA0tIi0RHP6HZsvZr/OwO86XxPEaEw5HUqHHHCjEGAMJfwZkcORLoOS279/XZc7epiqQ+c5OF2Jx7BQsmoiogFNHy7f9Qi1Cf3gIv0qnHsUwJ7Zej4MUHwDpy0nrTYWjSubJVUdScWQ7JTcxK/pH8Zenj/mdTa4cOnX1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(186009)(1800799009)(451199024)(6486002)(6506007)(6666004)(6512007)(966005)(19627235002)(478600001)(2616005)(83380400001)(26005)(1076003)(30864003)(7416002)(2906002)(6916009)(66556008)(66476007)(66946007)(54906003)(316002)(4326008)(5660300002)(8676002)(8936002)(41300700001)(86362001)(36756003)(82960400001)(38100700002)(84970400001)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WlhMNx+lV2iglzRbe8X8RVPDlz5x6yvLUD0o76o0jlX2SBtm80Qb2XpPoG?=
 =?iso-8859-1?Q?jJbmhCZm2yGiggkrOW3v5WunP7c8DmehUVdKea3FIVNAJ6/1gW0GMBWCP7?=
 =?iso-8859-1?Q?gbn+GWHHVMHKzR6G9O0+ccr7VBTyHuFHj8uV6xiTwpdd97Sf66VOiyeZNE?=
 =?iso-8859-1?Q?Nc09QAK7b0tTx7tcHwP239OBvYHsGk/4vMQhOKf9DlPG0x1mpDaes90aZW?=
 =?iso-8859-1?Q?25hJ5TWyDxew3jSyjJc4RVp0Rr/wBtJ7MleMLx4vENuN4pyFdV16px2Sxp?=
 =?iso-8859-1?Q?pXCZ/y8R1o5SApIxpvgaqX7t/tjB89BxMTcQAKLMGJ3pnPNisxi/m/wxjQ?=
 =?iso-8859-1?Q?vyGqztzH39lJ+HLR2O+UoQ6WMCv+viHRtDxXmfNMO4sskHefhDrtrH9jxW?=
 =?iso-8859-1?Q?lhfeWhEsGNy4+UAMd7DcJup/bngSg8N6y4gKUrgaeeGv8y5N9JDdTdFE12?=
 =?iso-8859-1?Q?g5xn85RE/GrB87DZ4Sax/BtLkbz2IWl2rs8hQBRGfnDKtzTaIdeI6+e4t1?=
 =?iso-8859-1?Q?CvCpuqqs03WxK9BgtDg2LZbgLHnYm/wuf836RiBK0ipvvIGMZgRTD+knvi?=
 =?iso-8859-1?Q?LHSXKqbvdZ7OSIhERXE/4GJ8Hge98l0SbI51dBMMu94y32/J7PABwW3AFy?=
 =?iso-8859-1?Q?z1dnb4dPmAPY9x592FwDWTe7hoAFUg8C16m5ZcL4BPXoq0vhJGApgw1tsm?=
 =?iso-8859-1?Q?fSW1Djt81ZTK8uojy8MwZZVvLTlaN8kxC3/Dz0UDbLWlsprESXUZVRW7CU?=
 =?iso-8859-1?Q?xZmOkDpaYUt0aiHFh9b9mWoyojfvKU2WiHNIb1ErK6ERBHjS5HwigLv/0W?=
 =?iso-8859-1?Q?54c9lGNrtqwOyuJ6lE7Cllao1E9zr3myi8xct3Z+/92E1GCA1Glj8houii?=
 =?iso-8859-1?Q?M0vNd8XN/zkqpYtlZEBZseJSKUKD41598lyooQlYJl9iUbeqO2oJCYnjtC?=
 =?iso-8859-1?Q?GMgrkoYubU8X15CU1iWT9/7QBNAUXiuO47NSpTpl3/xWXdBLZRfFpbMaB/?=
 =?iso-8859-1?Q?gEvl+riW4VfhvQb0HjXOxN4qPHYofTOb+n4kWOvNmeKMmZYUtVpQgf1wYy?=
 =?iso-8859-1?Q?4RxTs6sm6LCucWGltpO7eVdnCTl3JUrvPas9qGWmpCUKczvwDN/2YTlLWu?=
 =?iso-8859-1?Q?RIezpD2fsX7KSbFHc/T4WzhJ90BNXmqJsFNWPBHsD0qSPp5ACw9G91JMlB?=
 =?iso-8859-1?Q?xb53JSGoXGuVBprwf2mBgvzJE5g5dClSfaAFFvXzDWYr98Jjy1VDbvgLRt?=
 =?iso-8859-1?Q?NN3foyujGulwkG49baB/BNVO8GTte+NNuQuCLfgEOQ2nl5zXHKaED/VxME?=
 =?iso-8859-1?Q?RVkGq9IU6C+HyWoC1vx/7CzAXHgZzuC9KZIGo1oczopunMYUqoqVNSkhEk?=
 =?iso-8859-1?Q?icQhEkTRH1AKFovsY0mZslEUVjNd5pVJPwey47uGYJelGe52O+Cc72xRvg?=
 =?iso-8859-1?Q?E+xq0IGlF/El4BLv6OFoVUDPb/PjFmjtNeLW4/jXzmzv5TMpSDd2OKuL4y?=
 =?iso-8859-1?Q?1Q7QDZB6aIBGWwMQqXkq/Ke9zsg+PhxXIkiwbRi8DZOn+UmTjGwKpwHIqG?=
 =?iso-8859-1?Q?07VOrdHU5F6rTSbWhvHrc1m/7KZFSo86Fw0d6jvEubr9YXa2MHS1m0hVNb?=
 =?iso-8859-1?Q?I67lN4hl2WYurabTbItnky6ZwBIK8V0hAWbnkQ0UTo/YjMsiCBxnstcw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8903fa0a-6c0e-4d97-04f5-08dbbb52d983
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:01:12.6145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PclnqctKHKRvC3pNRLNf6TuM2rlww9JdwVRWJQPUCBUZzP65uTaYssy8F/L7r+6bsTyacGaFmg6DwuNqjTmoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6893
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a -19.0% regression of stress-ng.filename.ops_per_sec on:


commit: 8afa2eec7fb5de648561dba3b195cef09dab884d ("[PATCH] sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")
url: https://github.com/intel-lab-lkp/linux/commits/Ingo-Molnar/sched-fair-Do-not-wakeup-preempt-same-prio-SCHED_OTHER-tasks/20230919-170307
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 7ad0354d18ae05e9c8885251e234cbcf141f8972
patch link: https://lore.kernel.org/all/ZQljoiSBhZLEFI/G@gmail.com/
patch subject: [PATCH] sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks

testcase: stress-ng
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
parameters:

	nr_threads: 10%
	disk: 1SSD
	testtime: 60s
	fs: xfs
	class: filesystem
	test: filename
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.lockbus.ops_per_sec -6.0% regression                                          |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory          |
| test parameters  | class=memory                                                                                       |
|                  | cpufreq_governor=performance                                                                       |
|                  | nr_threads=100%                                                                                    |
|                  | test=lockbus                                                                                       |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.sigfd.ops_per_sec 17.6% improvement                                           |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory           |
| test parameters  | class=interrupt                                                                                    |
|                  | cpufreq_governor=performance                                                                       |
|                  | disk=1SSD                                                                                          |
|                  | nr_threads=100%                                                                                    |
|                  | test=sigfd                                                                                         |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.darktable.Masskrug.CPU-only.seconds -5.3% improvement     |
| test machine     | 12 threads 1 sockets Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz (Coffee Lake) with 16G memory         |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | option_a=Masskrug                                                                                  |
|                  | option_b=CPU-only                                                                                  |
|                  | test=darktable-1.0.5                                                                               |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | lmbench3: lmbench3.TCP.socket.bandwidth.64B.MB/sec 11.5% improvement                               |
| test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory    |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | mode=development                                                                                   |
|                  | nr_threads=100%                                                                                    |
|                  | test=TCP                                                                                           |
|                  | test_memory_size=50%                                                                               |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.darktable.Boat.CPU-only.seconds -3.5% improvement         |
| test machine     | 12 threads 1 sockets Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz (Coffee Lake) with 16G memory         |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | option_a=Boat                                                                                      |
|                  | option_b=CPU-only                                                                                  |
|                  | test=darktable-1.0.5                                                                               |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.sigrt.ops_per_sec 100.2% improvement                                          |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory           |
| test parameters  | class=interrupt                                                                                    |
|                  | cpufreq_governor=performance                                                                       |
|                  | disk=1SSD                                                                                          |
|                  | nr_threads=100%                                                                                    |
|                  | test=sigrt                                                                                         |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.sigsuspend.ops_per_sec -93.9% regression                                      |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory           |
| test parameters  | class=interrupt                                                                                    |
|                  | cpufreq_governor=performance                                                                       |
|                  | disk=1SSD                                                                                          |
|                  | nr_threads=100%                                                                                    |
|                  | test=sigsuspend                                                                                    |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.sigsuspend.ops_per_sec -82.1% regression                                      |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory          |
| test parameters  | class=interrupt                                                                                    |
|                  | cpufreq_governor=performance                                                                       |
|                  | disk=1HDD                                                                                          |
|                  | nr_threads=100%                                                                                    |
|                  | test=sigsuspend                                                                                    |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.sock.ops_per_sec 59.4% improvement                                            |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory          |
| test parameters  | class=network                                                                                      |
|                  | cpufreq_governor=performance                                                                       |
|                  | nr_threads=100%                                                                                    |
|                  | test=sock                                                                                          |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | blogbench: blogbench.write_score -35.9% regression                                                 |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | disk=1SSD                                                                                          |
|                  | fs=btrfs                                                                                           |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | hackbench: hackbench.throughput -4.8% regression                                                   |
| test machine     | 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | ipc=socket                                                                                         |
|                  | iterations=4                                                                                       |
|                  | mode=threads                                                                                       |
|                  | nr_threads=50%                                                                                     |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | blogbench: blogbench.write_score -59.3% regression                                                 |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | disk=1SSD                                                                                          |
|                  | fs=xfs                                                                                             |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.exec.ops_per_sec -34.6% regression                                            |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory          |
| test parameters  | class=exec_spawn                                                                                   |
|                  | cpufreq_governor=performance                                                                       |
|                  | disk=1HDD                                                                                          |
|                  | nr_threads=100%                                                                                    |
|                  | test=exec                                                                                          |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps 60.6% improvement                                                 |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory         |
| test parameters  | cluster=cs-localhost                                                                               |
|                  | cpufreq_governor=performance                                                                       |
|                  | ip=ipv4                                                                                            |
|                  | nr_threads=200%                                                                                    |
|                  | runtime=300s                                                                                       |
|                  | test=UDP_STREAM                                                                                    |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | hackbench: hackbench.throughput 19.1% improvement                                                  |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory         |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | ipc=pipe                                                                                           |
|                  | iterations=4                                                                                       |
|                  | mode=threads                                                                                       |
|                  | nr_threads=50%                                                                                     |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.dnotify.ops_per_sec -15.7% regression                                         |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory           |
| test parameters  | class=filesystem                                                                                   |
|                  | cpufreq_governor=performance                                                                       |
|                  | disk=1SSD                                                                                          |
|                  | fs=xfs                                                                                             |
|                  | nr_threads=10%                                                                                     |
|                  | test=dnotify                                                                                       |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309221758.d655aa5b-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230922/202309221758.d655aa5b-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1SSD/xfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/filename/stress-ng/60s

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   4641666           +19.5%    5545394 ±  2%  cpuidle..usage
      1.78            -0.2        1.57        mpstat.cpu.all.usr%
      6.49            -5.6%       6.13        iostat.cpu.system
      1.77           -11.3%       1.57        iostat.cpu.user
     10560 ±  2%     +56.5%      16523        vmstat.io.bo
     90589 ±  2%     +70.5%     154471 ±  2%  vmstat.system.cs
     55956            +4.2%      58304        vmstat.system.in
     10705 ±  6%     -18.7%       8702 ± 21%  sched_debug.cfs_rq:/.avg_vruntime.avg
     75917 ± 18%     -24.3%      57455 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.max
     14846 ± 13%     -19.3%      11978 ± 15%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     10705 ±  6%     -18.7%       8702 ± 21%  sched_debug.cfs_rq:/.min_vruntime.avg
     75917 ± 18%     -24.3%      57455 ± 12%  sched_debug.cfs_rq:/.min_vruntime.max
     14846 ± 13%     -19.3%      11978 ± 15%  sched_debug.cfs_rq:/.min_vruntime.stddev
     36871 ± 14%     -36.1%      23564 ± 45%  sched_debug.cpu.nr_switches.min
    628439           -19.2%     507711        stress-ng.filename.ops
     10317           -19.0%       8355        stress-ng.filename.ops_per_sec
    171981           -59.7%      69333 ±  3%  stress-ng.time.involuntary_context_switches
    221.00           -12.7%     193.00        stress-ng.time.percent_of_cpu_this_job_got
    108.56           -11.7%      95.90        stress-ng.time.system_time
     31.82           -16.9%      26.44        stress-ng.time.user_time
    770691 ±  3%    +200.9%    2319214        stress-ng.time.voluntary_context_switches
   1138479 ±  3%     +63.3%    1859024 ±  5%  turbostat.C1
      5.16 ±  2%      +2.0        7.15 ±  4%  turbostat.C1%
   1194780           +10.1%    1315182        turbostat.C1E
      7.10            +1.7        8.76 ±  2%  turbostat.C1E%
    404353 ±  4%     +32.1%     534162 ±  5%  turbostat.POLL
      0.09 ±  4%      +0.0        0.12 ±  3%  turbostat.POLL%
     86.42            -1.4%      85.17        turbostat.PkgWatt
    157494           +97.3%     310687        meminfo.Active
    157288           +97.4%     310497        meminfo.Active(anon)
    714039           +24.1%     885851        meminfo.Committed_AS
    759716           -17.0%     630878        meminfo.KReclaimable
     48745           +20.5%      58737 ±  5%  meminfo.Mapped
    759716           -17.0%     630878        meminfo.SReclaimable
    171371           +99.9%     342496        meminfo.Shmem
    881795           -15.2%     747680        meminfo.Slab
     39322           +97.4%      77624        proc-vmstat.nr_active_anon
    740918            +5.8%     783713        proc-vmstat.nr_file_pages
     79407            +5.9%      84102        proc-vmstat.nr_inactive_anon
     12193           +20.5%      14691 ±  5%  proc-vmstat.nr_mapped
     42845           +99.9%      85627        proc-vmstat.nr_shmem
    189913           -17.0%     157692        proc-vmstat.nr_slab_reclaimable
     30518            -4.3%      29198        proc-vmstat.nr_slab_unreclaimable
     39322           +97.4%      77624        proc-vmstat.nr_zone_active_anon
     79407            +5.9%      84102        proc-vmstat.nr_zone_inactive_anon
    734099            +9.4%     802836        proc-vmstat.numa_hit
    734074            +9.4%     802787        proc-vmstat.numa_local
     57736           +99.3%     115074        proc-vmstat.pgactivate
   1010216            -7.8%     931388 ±  2%  proc-vmstat.pgfree
    707596 ±  2%     +56.5%    1107112        proc-vmstat.pgpgout
 2.279e+09            -6.6%  2.128e+09        perf-stat.i.branch-instructions
      1.41            +0.1        1.52        perf-stat.i.branch-miss-rate%
      8.25 ±  5%      -1.3        7.00 ±  3%  perf-stat.i.cache-miss-rate%
  47892495 ±  2%     +14.2%   54671049 ±  2%  perf-stat.i.cache-references
     95307           +70.9%     162853 ±  2%  perf-stat.i.context-switches
      1.06            +3.1%       1.09        perf-stat.i.cpi
 1.238e+10            -3.8%  1.191e+10        perf-stat.i.cpu-cycles
      1422           +51.5%       2155 ±  3%  perf-stat.i.cpu-migrations
      4209            +7.0%       4504        perf-stat.i.cycles-between-cache-misses
  2.84e+09            -6.2%  2.665e+09        perf-stat.i.dTLB-loads
      0.00 ± 16%      +0.0        0.01 ± 15%  perf-stat.i.dTLB-store-miss-rate%
     60986 ± 16%     +44.5%      88132 ± 14%  perf-stat.i.dTLB-store-misses
 1.734e+09            -7.5%  1.604e+09        perf-stat.i.dTLB-stores
     23.19 ±  9%      -5.9       17.32 ± 11%  perf-stat.i.iTLB-load-miss-rate%
   4381599 ± 10%     +27.7%    5596623 ±  9%  perf-stat.i.iTLB-loads
 1.174e+10            -6.3%    1.1e+10        perf-stat.i.instructions
      0.95            -2.8%       0.92        perf-stat.i.ipc
      0.34            -3.8%       0.33        perf-stat.i.metric.GHz
    191.62            -6.5%     179.14        perf-stat.i.metric.M/sec
      1.44            +0.1        1.56        perf-stat.overall.branch-miss-rate%
      7.87 ±  5%      -1.1        6.74        perf-stat.overall.cache-miss-rate%
      1.05            +2.7%       1.08        perf-stat.overall.cpi
      0.00 ± 17%      +0.0        0.01 ± 14%  perf-stat.overall.dTLB-store-miss-rate%
     23.16 ±  9%      -5.9       17.22 ± 11%  perf-stat.overall.iTLB-load-miss-rate%
      0.95            -2.6%       0.92        perf-stat.overall.ipc
 2.243e+09            -6.6%  2.095e+09        perf-stat.ps.branch-instructions
  47146306 ±  2%     +14.1%   53816827 ±  2%  perf-stat.ps.cache-references
     93818           +70.9%     160303 ±  2%  perf-stat.ps.context-switches
 1.218e+10            -3.8%  1.172e+10        perf-stat.ps.cpu-cycles
      1400           +51.5%       2121 ±  3%  perf-stat.ps.cpu-migrations
 2.795e+09            -6.2%  2.623e+09        perf-stat.ps.dTLB-loads
     60034 ± 16%     +44.5%      86753 ± 14%  perf-stat.ps.dTLB-store-misses
 1.707e+09            -7.5%  1.579e+09        perf-stat.ps.dTLB-stores
   4313198 ± 10%     +27.7%    5509023 ±  9%  perf-stat.ps.iTLB-loads
 1.155e+10            -6.3%  1.082e+10        perf-stat.ps.instructions
 7.437e+11            -6.3%  6.968e+11        perf-stat.total.instructions
      0.00 ±223%   +1200.0%       0.00 ± 31%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.__d_alloc.d_alloc
      0.00 ±141%    +650.0%       0.00 ± 19%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_dir_createname
      0.00 ±223%   +1100.0%       0.00 ± 70%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_dir_removename
      0.00 ±223%   +1000.0%       0.00 ± 37%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.single_open.do_dentry_open
      0.00 ±223%   +1000.0%       0.00 ± 37%  perf-sched.sch_delay.avg.ms.__cond_resched.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file
      0.00 ±223%   +1100.0%       0.00 ± 40%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.path_lookupat.filename_lookup
      0.00 ± 70%    +275.0%       0.00 ± 30%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlink
      0.00 ±141%    +550.0%       0.00 ± 31%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.xfs_ilock.xfs_create.xfs_generic_create
      0.00 ±141%    +600.0%       0.00 ± 58%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.xfs_ilock.xfs_lock_two_inodes.xfs_trans_alloc_dir
      0.00 ±141%    +500.0%       0.00 ± 40%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__lookup_slow.walk_component.path_lookupat
      0.00          +150.0%       0.00 ± 19%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.00 ±223%   +1300.0%       0.00 ± 40%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.lookup_open.isra.0
      0.00 ±223%   +3100.0%       0.01 ±140%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      0.00 ±223%   +1000.0%       0.00 ± 58%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_lookupat.filename_lookup
      0.00 ±223%    +800.0%       0.00 ± 33%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
      0.00 ±141%    +550.0%       0.00 ± 81%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.seq_open.single_open.do_dentry_open
      0.00 ± 17%    +276.9%       0.02 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor.xfs_difree_finobt
      0.00 ±223%   +1800.0%       0.00 ± 76%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_iunlink_log_inode.xfs_iunlink.xfs_remove
      0.37 ± 30%    +260.3%       1.32 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_inactive_ifree.xfs_inactive
      0.00 ±223%    +900.0%       0.00 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_trans_alloc_icreate.xfs_create
      0.00 ±141%    +500.0%       0.00 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.08 ± 28%     +94.1%       0.16 ±  8%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xlog_cil_commit
      0.03 ±  3%     -36.7%       0.02        perf-sched.sch_delay.avg.ms.schedule_timeout.___down_common.__down.down
      0.00          +166.7%       0.00 ± 17%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      0.01 ± 42%     +78.3%       0.02 ± 31%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_killable.__kthread_create_on_node
      0.03 ± 10%    +194.0%       0.08 ±  5%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 34%    +233.3%       0.02 ± 29%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_dir_createname
      0.00 ± 52%    +432.0%       0.02 ± 63%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.single_open.do_dentry_open
      0.00 ± 54%    +203.7%       0.01 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file
      0.02 ± 40%  +23085.6%       4.29 ±221%  perf-sched.sch_delay.max.ms.__cond_resched.down.xlog_write_iclog.xlog_state_release_iclog.xlog_write_get_more_iclog_space
      0.01 ± 56%    +204.1%       0.02 ± 56%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.walk_component.path_lookupat.filename_lookup
      0.00 ±223%    +900.0%       0.01 ± 28%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.open_last_lookups.path_openat.do_filp_open
      0.01 ± 28%    +135.6%       0.02 ± 54%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlink
      0.01 ± 37%    +189.5%       0.02 ± 63%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.xfs_ilock.xfs_lock_two_inodes.xfs_trans_alloc_dir
      0.01 ± 18%    +100.0%       0.02 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.dput.path_put.vfs_statx.__do_sys_newstat
      0.01 ± 32%    +450.0%       0.03 ± 77%  perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.00 ± 99%    +500.0%       0.01 ± 68%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_dup_cursor.xfs_btree_dup_cursor
      0.01 ± 27%    +236.0%       0.03 ± 30%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor.xfs_dialloc_ag
      0.02 ± 48%    +114.2%       0.04 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor.xfs_difree_finobt
      0.00 ±152%   +1250.0%       0.03 ±144%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.xfs_iunlink_log_inode.xfs_iunlink.xfs_remove
      0.01 ± 28%    +163.3%       0.01 ± 55%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt
      0.01 ± 33%   +3565.1%       0.26 ±153%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.02 ± 42%    +162.1%       0.05 ± 58%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.02 ± 24%     +71.3%       0.03 ± 29%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      3.81 ±  4%     +27.2%       4.85 ± 16%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±  3%     -13.8%       0.02 ±  2%  perf-sched.total_sch_delay.average.ms
      3.48 ±  2%     -46.4%       1.86        perf-sched.total_wait_and_delay.average.ms
    227601           +91.9%     436761        perf-sched.total_wait_and_delay.count.ms
      3.45 ±  2%     -46.6%       1.85        perf-sched.total_wait_time.average.ms
      6.78 ± 14%     -35.0%       4.40 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down.xlog_write_iclog.xlog_state_release_iclog.xlog_write_get_more_iclog_space
      0.10          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
      3.78 ± 72%    +281.9%      14.42 ± 29%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_inactive_ifree.xfs_inactive
    138.51 ±  3%     -51.2%      67.56 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.10 ±  4%     -58.2%       0.46        perf-sched.wait_and_delay.avg.ms.schedule_timeout.___down_common.__down.down
     60.79 ±  5%     -30.7%      42.15 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     14.81 ±  2%     +29.7%      19.21 ±  2%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      7.15 ±  6%     -33.2%       4.78 ±  9%  perf-sched.wait_and_delay.avg.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
    318.17 ± 16%     +50.1%     477.50 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.down.xlog_write_iclog.xlog_state_release_iclog.xlog_write_get_more_iclog_space
      8265          -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
      7.17 ± 64%    +130.2%      16.50 ± 24%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
     85.50 ± 27%     -95.5%       3.83 ± 43%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    108.17 ±  4%    +103.9%     220.50 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      2.50 ± 75%    +193.3%       7.33 ± 47%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.xlog_cil_push_work
    112747 ±  2%    +194.7%     332296        perf-sched.wait_and_delay.count.schedule_timeout.___down_common.__down.down
      5400 ±  5%     +47.7%       7978 ±  3%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     14061           -26.8%      10296        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     11.17 ± 25%    +129.9%      25.67 ± 14%  perf-sched.wait_and_delay.count.xlog_state_get_iclog_space.xlog_write_get_more_iclog_space.xlog_write_partial.xlog_write
    326.67           +34.9%     440.83 ±  2%  perf-sched.wait_and_delay.count.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
     47.65 ± 11%     -39.4%      28.86 ±  6%  perf-sched.wait_and_delay.max.ms.__cond_resched.down.xlog_write_iclog.xlog_state_release_iclog.xlog_write_get_more_iclog_space
      5.96 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
      1001 ± 55%     -94.4%      56.12 ±117%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     52.30 ± 15%     -54.3%      23.88 ±  9%  perf-sched.wait_and_delay.max.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
      0.04 ± 25%     -76.3%       0.01 ± 31%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.seq_read_iter.seq_read
      6.78 ± 14%     -35.2%       4.39 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.down.xlog_write_iclog.xlog_state_release_iclog.xlog_write_get_more_iclog_space
      0.05 ± 24%    +133.6%       0.11 ± 40%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_remove
      0.06 ± 34%     -85.1%       0.01 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.open_last_lookups.path_openat.do_filp_open
      0.10           -41.5%       0.06 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.04 ± 39%    +185.4%       0.10 ± 82%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      0.57 ± 52%     +80.2%       1.03 ± 19%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.xfs_buf_item_init._xfs_trans_bjoin.xfs_trans_get_buf_map
      0.37 ± 19%     -93.2%       0.02 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor.xfs_difree_finobt
      0.58 ± 52%     +80.4%       1.05 ± 24%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor.xfs_difree_inobt
      4.11 ± 41%    +218.5%      13.10 ± 32%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_inactive_ifree.xfs_inactive
      0.23 ±104%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
    138.51 ±  3%     -51.2%      67.56 ±  6%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.07 ±  4%     -58.8%       0.44        perf-sched.wait_time.avg.ms.schedule_timeout.___down_common.__down.down
      0.07 ± 28%    +388.3%       0.36 ± 17%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
     60.77 ±  5%     -30.8%      42.07 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     14.74 ±  2%     +29.8%      19.13 ±  2%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      7.14 ±  6%     -33.2%       4.77 ±  9%  perf-sched.wait_time.avg.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
      0.12 ± 28%     -87.8%       0.01 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.seq_read_iter.seq_read
     47.64 ± 11%     -39.4%      28.85 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.down.xlog_write_iclog.xlog_state_release_iclog.xlog_write_get_more_iclog_space
      0.27 ± 69%     -93.2%       0.02 ± 26%  perf-sched.wait_time.max.ms.__cond_resched.down_write.open_last_lookups.path_openat.do_filp_open
      0.22 ± 74%    +458.4%       1.25 ± 95%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      1.32 ± 65%    +462.3%       7.41 ± 59%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      1.16 ± 87%     -94.6%       0.06 ± 36%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor.xfs_difree_finobt
      1.34 ± 84%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
      1000 ± 55%     -94.5%      54.97 ±119%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.70 ± 70%    +184.0%      13.35 ± 38%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
     52.29 ± 15%     -54.3%      23.87 ±  9%  perf-sched.wait_time.max.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
      9.93            -1.4        8.56        perf-profile.calltrace.cycles-pp.__xstat64
     17.34            -1.2       16.19        perf-profile.calltrace.cycles-pp.creat64
     16.29            -1.1       15.18        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
     15.99            -1.1       14.92        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      7.66            -1.0        6.64 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat64
     15.38            -1.0       14.37        perf-profile.calltrace.cycles-pp.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
     15.32            -1.0       14.32        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
     14.68            -0.9       13.76        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.60            -0.9       13.68        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64
      6.91 ±  2%      -0.9        6.03 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      4.72 ±  3%      -0.7        4.02 ±  3%  perf-profile.calltrace.cycles-pp.open64
     12.76 ±  2%      -0.7       12.10        perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      5.49 ±  2%      -0.7        4.84 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
     12.44 ±  2%      -0.6       11.83        perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      3.40 ±  5%      -0.6        2.79 ±  2%  perf-profile.calltrace.cycles-pp.read
      3.97 ±  4%      -0.6        3.40 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      3.74 ±  4%      -0.5        3.21 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     11.76 ±  2%      -0.5       11.22        perf-profile.calltrace.cycles-pp.xfs_generic_create.lookup_open.open_last_lookups.path_openat.do_filp_open
      4.19 ±  2%      -0.5        3.68 ±  2%  perf-profile.calltrace.cycles-pp.__close
      4.18 ±  3%      -0.5        3.69 ±  2%  perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      2.68 ±  6%      -0.5        2.21 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      3.32 ±  4%      -0.5        2.85 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      3.28 ±  4%      -0.5        2.82 ±  4%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      3.79 ±  2%      -0.4        3.35 ±  2%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.85 ±  4%      -0.4        2.44 ±  4%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.43 ±  6%      -0.4        2.02 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.79 ±  4%      -0.4        2.39 ±  4%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      3.58 ±  2%      -0.4        3.19 ±  2%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64
      2.55 ±  4%      -0.3        2.20 ±  3%  perf-profile.calltrace.cycles-pp.stress_mwc32modn
      2.88 ±  3%      -0.3        2.54 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      0.58 ±  8%      -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.__entry_text_start.__xstat64
      0.58 ±  5%      -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.list_sort.xfs_trans_run_precommits.__xfs_trans_commit.xfs_create.xfs_generic_create
      1.98 ±  6%      -0.3        1.67 ±  4%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.39 ±  2%      -0.3        4.09        perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_create.xfs_generic_create.lookup_open.open_last_lookups
      1.91 ±  6%      -0.3        1.62 ±  4%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.41 ±  3%      -0.3        2.14 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.68 ±  7%      -0.2        1.44 ±  3%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      1.72 ±  7%      -0.2        1.48 ±  4%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.37 ±  3%      -0.2        1.15 ±  4%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__xstat64
      1.62 ±  2%      -0.2        1.42 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.22 ±  2%      -0.2        3.03 ±  2%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_create.xfs_generic_create.lookup_open
      1.24 ±  5%      -0.2        1.05 ±  4%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      2.70 ±  3%      -0.2        2.50 ±  3%  perf-profile.calltrace.cycles-pp.xfs_dialloc_ag.xfs_dialloc.xfs_create.xfs_generic_create.lookup_open
      1.21 ±  2%      -0.2        1.03 ±  3%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.22 ±  3%      -0.2        1.05 ±  3%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      0.97 ± 10%      -0.2        0.81 ±  5%  perf-profile.calltrace.cycles-pp.seq_show.seq_read_iter.seq_read.vfs_read.ksys_read
      1.44 ±  3%      -0.1        1.30 ±  3%  perf-profile.calltrace.cycles-pp.xfs_init_new_inode.xfs_create.xfs_generic_create.lookup_open.open_last_lookups
      0.60 ±  4%      -0.1        0.45 ± 44%  perf-profile.calltrace.cycles-pp.destroy_inode.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.69 ±  4%      -0.1        1.56 ±  3%  perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat
      0.94 ±  7%      -0.1        0.82 ±  6%  perf-profile.calltrace.cycles-pp.getname_flags.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      0.68 ±  7%      -0.1        0.57 ±  7%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.80 ±  3%      -0.1        0.69 ±  5%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__close
      1.11 ±  6%      -0.1        1.02 ±  5%  perf-profile.calltrace.cycles-pp.xfs_difree_finobt.xfs_difree.xfs_ifree.xfs_inactive_ifree.xfs_inactive
      0.68 ±  5%      -0.1        0.58 ±  2%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      0.64 ±  4%      -0.1        0.55 ±  4%  perf-profile.calltrace.cycles-pp.xfs_dir_createname.xfs_create.xfs_generic_create.lookup_open.open_last_lookups
      0.75 ±  4%      -0.1        0.66 ±  4%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.99 ±  3%      -0.1        0.90 ±  4%  perf-profile.calltrace.cycles-pp.xfs_trans_run_precommits.__xfs_trans_commit.xfs_create.xfs_generic_create.lookup_open
      0.67 ±  5%      -0.1        0.59 ±  3%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.71 ±  3%      -0.1        0.64 ±  5%  perf-profile.calltrace.cycles-pp.xfs_trans_alloc.xfs_trans_alloc_dir.xfs_remove.xfs_vn_unlink.vfs_unlink
      0.61 ±  5%      -0.0        0.56 ±  5%  perf-profile.calltrace.cycles-pp.xfs_btree_lookup.xfs_difree_finobt.xfs_difree.xfs_ifree.xfs_inactive_ifree
      1.01 ±  3%      +0.1        1.09 ±  3%  perf-profile.calltrace.cycles-pp.xfs_trans_run_precommits.__xfs_trans_commit.xfs_remove.xfs_vn_unlink.vfs_unlink
      0.62 ±  8%      +0.1        0.73 ±  3%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      0.70 ±  9%      +0.1        0.83 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.69 ±  8%      +0.1        0.82 ±  2%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.do_nanosleep
      0.82 ±  7%      +0.1        0.96 ±  2%  perf-profile.calltrace.cycles-pp.xlog_cil_alloc_shadow_bufs.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree.xfs_inactive
      0.84 ± 10%      +0.1        0.98 ±  3%  perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.94 ±  9%      +0.2        1.09 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.83 ±  9%      +0.2        0.98 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep
      0.94 ±  9%      +0.2        1.10 ±  3%  perf-profile.calltrace.cycles-pp.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.97 ±  8%      +0.2        1.12 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.92 ±  8%      +0.2        1.08 ±  2%  perf-profile.calltrace.cycles-pp.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64
      1.05 ±  8%      +0.2        1.21 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      1.09 ±  9%      +0.2        1.25 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.86 ±  5%      +0.2        1.02 ±  5%  perf-profile.calltrace.cycles-pp.xfs_trans_run_precommits.__xfs_trans_commit.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker
      1.23 ±  8%      +0.2        1.40 ±  3%  perf-profile.calltrace.cycles-pp.clock_nanosleep
     10.12            +0.2       10.33        perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.81 ± 10%      +0.3        1.08 ±  7%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.58 ±  5%      +0.3        0.86 ±  6%  perf-profile.calltrace.cycles-pp.xfs_trans_read_buf_map.xfs_read_agi.xfs_ialloc_read_agi.xfs_dialloc.xfs_create
      0.62 ±  5%      +0.3        0.90 ±  6%  perf-profile.calltrace.cycles-pp.xfs_read_agi.xfs_ialloc_read_agi.xfs_dialloc.xfs_create.xfs_generic_create
      0.66 ±  4%      +0.3        0.94 ±  6%  perf-profile.calltrace.cycles-pp.xfs_ialloc_read_agi.xfs_dialloc.xfs_create.xfs_generic_create.lookup_open
      1.50 ±  5%      +0.3        1.80 ±  4%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit.xfs_remove.xfs_vn_unlink
      1.32 ±  6%      +0.3        1.64 ±  4%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_format_items.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit.xfs_remove
      0.27 ±100%      +0.3        0.59 ±  3%  perf-profile.calltrace.cycles-pp.xfs_buf_item_size_segment.xfs_buf_item_size.xlog_cil_alloc_shadow_bufs.xlog_cil_commit.__xfs_trans_commit
      0.64 ±  8%      +0.3        0.96 ±  5%  perf-profile.calltrace.cycles-pp.xfs_trans_read_buf_map.xfs_read_agi.xfs_iunlink.xfs_remove.xfs_vn_unlink
      0.68 ±  8%      +0.3        1.01 ±  4%  perf-profile.calltrace.cycles-pp.xfs_read_agi.xfs_iunlink.xfs_remove.xfs_vn_unlink.vfs_unlink
      0.98 ±  7%      +0.3        1.32 ±  4%  perf-profile.calltrace.cycles-pp.xfs_iunlink.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat
      2.60 ±  7%      +0.4        2.98 ±  6%  perf-profile.calltrace.cycles-pp.xfs_buf_item_format_segment.xfs_buf_item_format.xlog_cil_insert_format_items.xlog_cil_insert_items.xlog_cil_commit
      2.97 ±  2%      +0.4        3.36 ±  2%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_remove.xfs_vn_unlink.vfs_unlink
      1.97 ±  2%      +0.4        2.41 ±  5%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_format_items.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree
      2.14 ±  2%      +0.5        2.59 ±  5%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree.xfs_inactive
      4.17            +0.5        4.63        perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat
      0.36 ± 70%      +0.5        0.84 ±  6%  perf-profile.calltrace.cycles-pp.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agi.xfs_iunlink
      0.38 ± 70%      +0.5        0.85 ±  6%  perf-profile.calltrace.cycles-pp.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agi.xfs_iunlink.xfs_remove
      3.57 ±  4%      +0.5        4.08 ±  2%  perf-profile.calltrace.cycles-pp.xfs_difree.xfs_ifree.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker
      0.84 ±  7%      +0.5        1.38 ±  6%  perf-profile.calltrace.cycles-pp.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agi.xfs_ialloc_read_agi.xfs_difree
      0.00            +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.___down_common
      4.16 ±  4%      +0.5        4.71 ±  2%  perf-profile.calltrace.cycles-pp.xfs_ifree.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work
      7.83            +0.6        8.39        perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.56 ±  8%  perf-profile.calltrace.cycles-pp.up.xfs_buf_unlock.xfs_buf_item_release.xlog_cil_commit.__xfs_trans_commit
      1.03 ±  6%      +0.6        1.61 ±  6%  perf-profile.calltrace.cycles-pp.xfs_read_agi.xfs_ialloc_read_agi.xfs_difree.xfs_ifree.xfs_inactive_ifree
      0.98 ±  7%      +0.6        1.55 ±  6%  perf-profile.calltrace.cycles-pp.xfs_trans_read_buf_map.xfs_read_agi.xfs_ialloc_read_agi.xfs_difree.xfs_ifree
      1.06 ±  6%      +0.6        1.65 ±  6%  perf-profile.calltrace.cycles-pp.xfs_ialloc_read_agi.xfs_difree.xfs_ifree.xfs_inactive_ifree.xfs_inactive
      0.00            +0.6        0.59 ±  7%  perf-profile.calltrace.cycles-pp.xfs_buf_unlock.xfs_buf_item_release.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree
      7.31            +0.6        7.92        perf-profile.calltrace.cycles-pp.xfs_vn_unlink.vfs_unlink.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.09 ±223%      +0.6        0.71 ±  8%  perf-profile.calltrace.cycles-pp.xfs_buf_item_release.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree.xfs_inactive
      7.26            +0.6        7.88        perf-profile.calltrace.cycles-pp.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat.__x64_sys_unlink
      0.00            +0.6        0.63 ± 11%  perf-profile.calltrace.cycles-pp.memcpy_orig.xfs_buf_item_format_segment.xfs_buf_item_format.xlog_cil_insert_format_items.xlog_cil_insert_items
      0.08 ±223%      +0.7        0.75 ±  8%  perf-profile.calltrace.cycles-pp.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agi.xfs_ialloc_read_agi.xfs_dialloc
      3.01 ±  2%      +0.7        3.76 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buf_item_format.xlog_cil_insert_format_items.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit
      1.61 ±  9%      +0.8        2.40 ±  8%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      4.19 ±  3%      +0.8        4.99 ±  3%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker
      5.29 ±  3%      +1.0        6.26 ±  3%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work
      3.39 ±  4%      +1.1        4.45 ±  6%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.81 ±  8%      +1.3        2.09 ±  6%  perf-profile.calltrace.cycles-pp.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agi.xfs_ialloc_read_agi
      0.00            +1.4        1.36 ± 25%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.___down_common.__down
      4.60 ±  9%      +1.4        6.01 ±  7%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     10.49 ±  3%      +1.5       11.94 ±  2%  perf-profile.calltrace.cycles-pp.xfs_inodegc_worker.process_one_work.worker_thread.kthread.ret_from_fork
      0.17 ±141%      +1.5        1.64 ± 23%  perf-profile.calltrace.cycles-pp.schedule_timeout.___down_common.__down.down.xfs_buf_lock
     10.23 ±  3%      +1.5       11.72 ±  2%  perf-profile.calltrace.cycles-pp.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread.kthread
     10.17 ±  3%      +1.5       11.66 ±  2%  perf-profile.calltrace.cycles-pp.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread
      0.00            +1.5        1.51 ± 21%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.___down_common.__down.down
      0.28 ±100%      +1.5        1.81 ± 16%  perf-profile.calltrace.cycles-pp.___down_common.__down.down.xfs_buf_lock.xfs_buf_find_lock
      0.56 ±  8%      +1.6        2.11 ± 11%  perf-profile.calltrace.cycles-pp.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup.xfs_buf_get_map.xfs_buf_read_map
     11.52 ±  3%      +1.6       13.12 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     11.52 ±  3%      +1.6       13.12 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     11.52 ±  3%      +1.6       13.12 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.46 ± 45%      +1.6        2.06 ± 11%  perf-profile.calltrace.cycles-pp.down.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup.xfs_buf_get_map
      0.28 ±100%      +1.6        1.91 ± 15%  perf-profile.calltrace.cycles-pp.__down.down.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup
     11.08 ±  3%      +1.7       12.75 ±  2%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     10.98 ±  3%      +1.7       12.65 ±  2%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.59 ±  8%      +1.7        2.27 ± 10%  perf-profile.calltrace.cycles-pp.xfs_buf_find_lock.xfs_buf_lookup.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map
      0.65 ±  9%      +1.9        2.56 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buf_lookup.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agi
     29.87 ±  3%      +2.1       32.02 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     29.58 ±  2%      +2.5       32.05        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     30.03 ±  2%      +2.6       32.63        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     31.48 ±  2%      +2.9       34.42        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     30.91 ±  2%      +3.0       33.88        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     30.93 ±  2%      +3.0       33.90        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     30.92 ±  2%      +3.0       33.90        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     45.93            -3.2       42.69        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     43.64            -2.9       40.77        perf-profile.children.cycles-pp.do_syscall_64
     18.64 ±  2%      -1.5       17.17        perf-profile.children.cycles-pp.do_sys_openat2
     10.02            -1.4        8.64        perf-profile.children.cycles-pp.__xstat64
     17.54            -1.3       16.20        perf-profile.children.cycles-pp.do_filp_open
     17.42            -1.3       16.09        perf-profile.children.cycles-pp.path_openat
     17.39            -1.2       16.23        perf-profile.children.cycles-pp.creat64
     15.38            -1.0       14.37        perf-profile.children.cycles-pp.__x64_sys_creat
     13.27 ±  2%      -0.7       12.54        perf-profile.children.cycles-pp.open_last_lookups
      4.75 ±  3%      -0.7        4.04 ±  3%  perf-profile.children.cycles-pp.open64
      5.50 ±  2%      -0.7        4.84 ±  2%  perf-profile.children.cycles-pp.__do_sys_newstat
      4.08 ±  3%      -0.6        3.46 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      3.43 ±  5%      -0.6        2.81 ±  2%  perf-profile.children.cycles-pp.read
     12.45 ±  2%      -0.6       11.84        perf-profile.children.cycles-pp.lookup_open
     11.77 ±  2%      -0.5       11.23        perf-profile.children.cycles-pp.xfs_generic_create
      4.26 ±  2%      -0.5        3.73 ±  2%  perf-profile.children.cycles-pp.__close
      4.18 ±  2%      -0.5        3.70 ±  2%  perf-profile.children.cycles-pp.vfs_statx
      3.84 ±  3%      -0.5        3.35 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.34 ±  4%      -0.5        2.87 ±  4%  perf-profile.children.cycles-pp.__x64_sys_openat
      3.80 ±  2%      -0.4        3.36 ±  2%  perf-profile.children.cycles-pp.filename_lookup
      3.60 ±  2%      -0.4        3.21 ±  2%  perf-profile.children.cycles-pp.path_lookupat
      2.75            -0.4        2.37 ±  4%  perf-profile.children.cycles-pp.link_path_walk
      2.65 ±  3%      -0.3        2.30 ±  3%  perf-profile.children.cycles-pp.stress_mwc32modn
      1.98 ±  6%      -0.3        1.67 ±  4%  perf-profile.children.cycles-pp.ksys_read
      2.18 ±  3%      -0.3        1.87 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      2.17 ±  3%      -0.3        1.88 ±  4%  perf-profile.children.cycles-pp.__entry_text_start
      1.92 ±  6%      -0.3        1.63 ±  4%  perf-profile.children.cycles-pp.vfs_read
      1.73 ±  7%      -0.2        1.48 ±  4%  perf-profile.children.cycles-pp.seq_read
      1.69 ±  7%      -0.2        1.44 ±  3%  perf-profile.children.cycles-pp.seq_read_iter
      1.84 ±  6%      -0.2        1.61 ±  3%  perf-profile.children.cycles-pp.getname_flags
      1.22 ±  5%      -0.2        1.01 ±  3%  perf-profile.children.cycles-pp.alloc_empty_file
      1.62 ±  2%      -0.2        1.42 ±  3%  perf-profile.children.cycles-pp.__x64_sys_close
      2.71 ±  3%      -0.2        2.51 ±  3%  perf-profile.children.cycles-pp.xfs_dialloc_ag
      1.30 ±  6%      -0.2        1.10 ±  3%  perf-profile.children.cycles-pp.strncpy_from_user
      1.95 ±  2%      -0.2        1.77 ±  2%  perf-profile.children.cycles-pp.xfs_trans_alloc
      1.25 ±  2%      -0.2        1.07 ±  2%  perf-profile.children.cycles-pp.__fput
      1.31 ±  4%      -0.2        1.14 ±  2%  perf-profile.children.cycles-pp.do_open
      0.97 ± 10%      -0.2        0.82 ±  5%  perf-profile.children.cycles-pp.seq_show
      1.08 ±  6%      -0.1        0.94 ±  2%  perf-profile.children.cycles-pp.do_dentry_open
      1.45 ±  3%      -0.1        1.31 ±  3%  perf-profile.children.cycles-pp.xfs_init_new_inode
      0.79 ±  8%      -0.1        0.66 ±  4%  perf-profile.children.cycles-pp.__check_object_size
      0.88 ±  6%      -0.1        0.75 ±  6%  perf-profile.children.cycles-pp.xfs_inobt_update
      0.93 ±  4%      -0.1        0.80 ±  3%  perf-profile.children.cycles-pp.inode_permission
      1.40 ±  2%      -0.1        1.27 ±  3%  perf-profile.children.cycles-pp.xfs_log_reserve
      1.54 ±  3%      -0.1        1.41 ±  2%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.80 ±  3%      -0.1        0.68 ±  5%  perf-profile.children.cycles-pp.dput
      0.34 ± 14%      -0.1        0.22 ± 23%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.58 ±  8%      -0.1        0.48 ±  5%  perf-profile.children.cycles-pp.__filename_parentat
      1.12 ±  5%      -0.1        1.03 ±  5%  perf-profile.children.cycles-pp.xfs_difree_finobt
      0.27 ± 12%      -0.1        0.18 ± 18%  perf-profile.children.cycles-pp.xfs_btree_update_keys
      0.67 ±  6%      -0.1        0.57 ±  8%  perf-profile.children.cycles-pp.stress_filename
      0.51 ±  5%      -0.1        0.41 ± 10%  perf-profile.children.cycles-pp.down_read
      0.64 ±  4%      -0.1        0.55 ±  4%  perf-profile.children.cycles-pp.xfs_dir_createname
      0.51 ±  6%      -0.1        0.42 ±  8%  perf-profile.children.cycles-pp.generic_permission
      1.04 ±  4%      -0.1        0.96 ±  3%  perf-profile.children.cycles-pp.xfs_inode_item_format
      0.54 ± 11%      -0.1        0.46 ±  9%  perf-profile.children.cycles-pp.xfs_inobt_init_cursor
      0.42 ±  5%      -0.1        0.34 ±  9%  perf-profile.children.cycles-pp.xlog_grant_add_space
      0.51 ±  7%      -0.1        0.44 ±  4%  perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      0.46 ±  8%      -0.1        0.38 ±  6%  perf-profile.children.cycles-pp.check_heap_object
      0.54 ±  7%      -0.1        0.47 ±  7%  perf-profile.children.cycles-pp.xfs_trans_log_inode
      0.50 ±  6%      -0.1        0.42 ±  6%  perf-profile.children.cycles-pp.security_file_alloc
      0.60 ±  4%      -0.1        0.53 ±  5%  perf-profile.children.cycles-pp.destroy_inode
      0.16 ± 11%      -0.1        0.10 ± 16%  perf-profile.children.cycles-pp.xfs_btree_get_leaf_keys
      0.24 ± 11%      -0.1        0.19 ± 11%  perf-profile.children.cycles-pp.__check_heap_object
      0.38 ±  4%      -0.1        0.33 ±  8%  perf-profile.children.cycles-pp.__kmalloc_node
      0.34 ±  7%      -0.1        0.29 ±  7%  perf-profile.children.cycles-pp.__kmem_cache_free
      0.25 ± 16%      -0.1        0.20 ± 11%  perf-profile.children.cycles-pp.security_file_free
      0.47 ±  4%      -0.1        0.42 ±  5%  perf-profile.children.cycles-pp.__cond_resched
      0.17 ± 13%      -0.1        0.12 ± 16%  perf-profile.children.cycles-pp.mnt_want_write
      0.09 ± 18%      -0.0        0.04 ± 75%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.19 ±  7%      -0.0        0.14 ± 18%  perf-profile.children.cycles-pp.fsnotify_destroy_marks
      0.31 ± 10%      -0.0        0.26 ±  5%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.19 ± 12%      -0.0        0.15 ± 13%  perf-profile.children.cycles-pp.seq_open
      0.36 ±  4%      -0.0        0.33 ±  6%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.32 ±  6%      -0.0        0.28 ±  5%  perf-profile.children.cycles-pp.xfs_da_hashname
      0.18 ± 10%      -0.0        0.14 ± 10%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.06 ± 11%      +0.0        0.09 ± 11%  perf-profile.children.cycles-pp._find_next_and_bit
      0.05 ±  8%      +0.0        0.09 ± 17%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.xfs_alloc_vextent_exact_bno
      0.08 ± 19%      +0.0        0.13 ± 12%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.10 ± 26%      +0.0        0.15 ± 10%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.11 ± 18%      +0.0        0.16 ± 18%  perf-profile.children.cycles-pp.crc_pcl
      0.01 ±223%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.10 ± 13%      +0.1        0.15 ± 12%  perf-profile.children.cycles-pp.xfs_iunlink_lookup
      0.12 ± 21%      +0.1        0.17 ± 15%  perf-profile.children.cycles-pp.xfs_iunlink_log_inode
      0.01 ±223%      +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.check_preempt_curr
      0.08 ± 17%      +0.1        0.14 ± 13%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.02 ±142%      +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.xlog_cil_order_cmp
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.08 ± 17%      +0.1        0.14 ± 12%  perf-profile.children.cycles-pp.finish_task_switch
      0.01 ±223%      +0.1        0.06 ± 21%  perf-profile.children.cycles-pp.update_cfs_group
      0.06 ± 11%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.update_rq_clock
      0.07 ± 18%      +0.1        0.13 ± 27%  perf-profile.children.cycles-pp.switch_fpu_return
      0.02 ±141%      +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.sched_use_asym_prio
      0.02 ±141%      +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.10 ±  7%      +0.1        0.16 ± 14%  perf-profile.children.cycles-pp.xlog_write
      0.04 ± 45%      +0.1        0.10 ± 13%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.17 ± 15%      +0.1        0.22 ± 13%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.15 ± 10%      +0.1        0.21 ± 17%  perf-profile.children.cycles-pp.xfs_trans_committed_bulk
      0.08 ± 22%      +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.__switch_to
      0.12 ± 22%      +0.1        0.18 ±  5%  perf-profile.children.cycles-pp.__switch_to_asm
      0.01 ±223%      +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.os_xsave
      0.13 ± 14%      +0.1        0.19 ±  7%  perf-profile.children.cycles-pp.native_sched_clock
      0.07 ± 13%      +0.1        0.13 ± 13%  perf-profile.children.cycles-pp.___perf_sw_event
      0.02 ±142%      +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.14 ± 16%      +0.1        0.20 ± 13%  perf-profile.children.cycles-pp.idle_cpu
      0.21 ±  9%      +0.1        0.28 ±  9%  perf-profile.children.cycles-pp.xfs_ialloc_ag_alloc
      0.12 ±  6%      +0.1        0.19 ±  9%  perf-profile.children.cycles-pp._xfs_buf_obj_cmp
      0.10 ± 22%      +0.1        0.17 ± 12%  perf-profile.children.cycles-pp.prepare_task_switch
      0.08 ± 23%      +0.1        0.16 ± 16%  perf-profile.children.cycles-pp.update_curr
      0.11 ±  6%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.sched_clock
      0.01 ±223%      +0.1        0.09 ± 23%  perf-profile.children.cycles-pp.avg_vruntime
      0.33 ±  5%      +0.1        0.41 ±  5%  perf-profile.children.cycles-pp.menu_select
      0.11 ± 13%      +0.1        0.20 ± 12%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.12 ±  7%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.13 ±  5%      +0.1        0.21 ± 10%  perf-profile.children.cycles-pp.update_blocked_averages
      0.18 ± 16%      +0.1        0.26 ± 11%  perf-profile.children.cycles-pp.xfs_buf_item_init
      0.01 ±223%      +0.1        0.10 ± 13%  perf-profile.children.cycles-pp.place_entity
      0.10 ± 20%      +0.1        0.18 ± 12%  perf-profile.children.cycles-pp.set_next_entity
      0.23 ± 10%      +0.1        0.32 ± 12%  perf-profile.children.cycles-pp.xlog_cil_process_committed
      0.23 ± 10%      +0.1        0.32 ± 12%  perf-profile.children.cycles-pp.xlog_cil_committed
      0.23 ±  9%      +0.1        0.32 ± 11%  perf-profile.children.cycles-pp.xlog_state_do_callback
      0.23 ±  9%      +0.1        0.32 ± 11%  perf-profile.children.cycles-pp.xlog_state_do_iclog_callbacks
      0.24 ± 10%      +0.1        0.33 ± 11%  perf-profile.children.cycles-pp.xlog_ioend_work
      0.69 ±  4%      +0.1        0.79 ±  4%  perf-profile.children.cycles-pp.xlog_prepare_iovec
      0.36 ±  2%      +0.1        0.46 ±  5%  perf-profile.children.cycles-pp.xfs_next_bit
      0.37 ±  6%      +0.1        0.47 ±  7%  perf-profile.children.cycles-pp.xfs_buf_offset
      0.21 ± 12%      +0.1        0.32 ± 11%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      1.26 ±  5%      +0.1        1.38 ±  4%  perf-profile.children.cycles-pp.xfs_buf_item_size
      0.26 ± 14%      +0.1        0.38 ± 12%  perf-profile.children.cycles-pp.xfs_dinode_calc_crc
      0.22 ±  3%      +0.1        0.34 ±  8%  perf-profile.children.cycles-pp.xlog_cil_push_work
      0.40 ± 15%      +0.1        0.53 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      0.27 ± 14%      +0.1        0.40 ± 12%  perf-profile.children.cycles-pp.crc32c
      0.60 ± 12%      +0.1        0.74 ±  6%  perf-profile.children.cycles-pp._xfs_trans_bjoin
      0.24 ± 12%      +0.1        0.38 ±  4%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.20 ± 11%      +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.94 ±  9%      +0.2        1.09 ±  3%  perf-profile.children.cycles-pp.hrtimer_nanosleep
      0.97 ±  8%      +0.2        1.12 ±  3%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
      0.94 ±  9%      +0.2        1.10 ±  3%  perf-profile.children.cycles-pp.common_nsleep
      0.92 ±  8%      +0.2        1.08 ±  2%  perf-profile.children.cycles-pp.do_nanosleep
      1.24 ±  8%      +0.2        1.40 ±  3%  perf-profile.children.cycles-pp.clock_nanosleep
      1.00 ±  6%      +0.2        1.17 ±  4%  perf-profile.children.cycles-pp.xfs_buf_item_size_segment
      0.46 ±  5%      +0.2        0.63 ±  3%  perf-profile.children.cycles-pp.xfs_contig_bits
      0.30 ± 16%      +0.2        0.47 ±  6%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.30 ± 12%      +0.2        0.48 ±  5%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.32 ±  7%      +0.2        0.50 ±  3%  perf-profile.children.cycles-pp.xfs_imap_to_bp
      2.00 ±  3%      +0.2        2.19 ±  2%  perf-profile.children.cycles-pp.xlog_cil_alloc_shadow_bufs
     10.13            +0.2       10.34        perf-profile.children.cycles-pp.do_unlinkat
      0.21 ±  8%      +0.2        0.42 ±  6%  perf-profile.children.cycles-pp.dequeue_entity
      0.21 ± 10%      +0.2        0.44 ±  6%  perf-profile.children.cycles-pp.enqueue_entity
      0.26 ±  4%      +0.2        0.51 ±  6%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.82 ±  9%      +0.3        1.10 ±  6%  perf-profile.children.cycles-pp.poll_idle
      0.25 ±  6%      +0.3        0.54 ±  6%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.27 ±  8%      +0.3        0.57 ±  5%  perf-profile.children.cycles-pp.activate_task
      0.54 ±  5%      +0.3        0.85 ±  7%  perf-profile.children.cycles-pp.xfs_iunlink_log_dinode
      0.31 ±  8%      +0.3        0.62 ±  4%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.60 ±  5%      +0.3        0.94 ±  5%  perf-profile.children.cycles-pp.xfs_iunlink_item_precommit
      0.98 ±  7%      +0.3        1.33 ±  4%  perf-profile.children.cycles-pp.xfs_iunlink
      1.07 ±  2%      +0.4        1.43 ±  7%  perf-profile.children.cycles-pp.memcpy_orig
      0.85 ±  7%      +0.4        1.23 ±  4%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.90 ± 10%      +0.4        1.29 ±  3%  perf-profile.children.cycles-pp.xfs_buf_item_release
      0.98 ±  7%      +0.4        1.38 ±  4%  perf-profile.children.cycles-pp.update_sd_lb_stats
      1.01 ±  7%      +0.4        1.41 ±  4%  perf-profile.children.cycles-pp.find_busiest_group
      0.58 ± 10%      +0.5        1.04 ±  4%  perf-profile.children.cycles-pp.xfs_buf_unlock
      0.51 ± 11%      +0.5        0.98 ±  4%  perf-profile.children.cycles-pp.up
      0.42 ±  6%      +0.5        0.90 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      3.57 ±  4%      +0.5        4.08 ±  2%  perf-profile.children.cycles-pp.xfs_difree
      1.21 ±  7%      +0.5        1.72 ±  3%  perf-profile.children.cycles-pp.load_balance
      4.16 ±  4%      +0.6        4.72 ±  2%  perf-profile.children.cycles-pp.xfs_ifree
      7.84            +0.6        8.39        perf-profile.children.cycles-pp.vfs_unlink
      1.30 ±  7%      +0.6        1.86 ±  2%  perf-profile.children.cycles-pp.newidle_balance
      7.31            +0.6        7.92        perf-profile.children.cycles-pp.xfs_vn_unlink
      7.26            +0.6        7.89        perf-profile.children.cycles-pp.xfs_remove
      1.47 ±  5%      +0.7        2.18 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      5.14            +0.7        5.84 ±  2%  perf-profile.children.cycles-pp.xlog_cil_insert_items
      4.62 ±  2%      +0.7        5.34 ±  3%  perf-profile.children.cycles-pp.xlog_cil_insert_format_items
      3.04 ±  2%      +0.7        3.78 ±  4%  perf-profile.children.cycles-pp.xfs_buf_item_format
      2.80 ±  2%      +0.7        3.54 ±  4%  perf-profile.children.cycles-pp.xfs_buf_item_format_segment
      4.89 ±  4%      +0.8        5.73 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.72 ±  5%      +0.9        2.59 ±  5%  perf-profile.children.cycles-pp.xfs_ialloc_read_agi
     10.46            +1.0       11.46 ±  2%  perf-profile.children.cycles-pp.xlog_cil_commit
      3.44 ±  5%      +1.1        4.49 ±  6%  perf-profile.children.cycles-pp.intel_idle
      0.92 ±  6%      +1.1        2.04 ±  4%  perf-profile.children.cycles-pp.schedule_timeout
      1.20 ±  6%      +1.2        2.35 ±  4%  perf-profile.children.cycles-pp.down
      1.27 ±  6%      +1.2        2.43 ±  4%  perf-profile.children.cycles-pp.xfs_buf_lock
      0.96 ±  7%      +1.2        2.12 ±  4%  perf-profile.children.cycles-pp.___down_common
      0.97 ±  7%      +1.2        2.13 ±  4%  perf-profile.children.cycles-pp.__down
      2.44 ±  5%      +1.2        3.61 ±  3%  perf-profile.children.cycles-pp.xfs_read_agi
     13.92            +1.2       15.08        perf-profile.children.cycles-pp.__xfs_trans_commit
      1.42 ±  7%      +1.2        2.59 ±  4%  perf-profile.children.cycles-pp.xfs_buf_find_lock
      3.05 ±  4%      +1.2        4.26 ±  2%  perf-profile.children.cycles-pp.xfs_buf_read_map
      2.92 ±  4%      +1.2        4.15 ±  3%  perf-profile.children.cycles-pp.xfs_buf_get_map
      1.90 ±  5%      +1.2        3.14 ±  3%  perf-profile.children.cycles-pp.schedule
      1.95 ±  5%      +1.3        3.23 ±  4%  perf-profile.children.cycles-pp.xfs_buf_lookup
      2.30 ±  5%      +1.3        3.59 ±  2%  perf-profile.children.cycles-pp.__schedule
      4.01 ±  4%      +1.4        5.39 ±  2%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
     10.49 ±  3%      +1.5       11.95 ±  2%  perf-profile.children.cycles-pp.xfs_inodegc_worker
      3.82 ±  9%      +1.5        5.30 ±  7%  perf-profile.children.cycles-pp.intel_idle_irq
     10.24 ±  3%      +1.5       11.72 ±  2%  perf-profile.children.cycles-pp.xfs_inactive
     10.17 ±  3%      +1.5       11.66 ±  2%  perf-profile.children.cycles-pp.xfs_inactive_ifree
     11.52 ±  3%      +1.6       13.12 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
     11.52 ±  3%      +1.6       13.12 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
     11.52 ±  3%      +1.6       13.12 ±  2%  perf-profile.children.cycles-pp.kthread
     11.08 ±  3%      +1.7       12.75 ±  2%  perf-profile.children.cycles-pp.worker_thread
     10.98 ±  3%      +1.7       12.65 ±  2%  perf-profile.children.cycles-pp.process_one_work
     30.10 ±  2%      +2.4       32.52        perf-profile.children.cycles-pp.cpuidle_enter_state
     30.10 ±  2%      +2.4       32.54        perf-profile.children.cycles-pp.cpuidle_enter
     30.58 ±  2%      +2.6       33.14        perf-profile.children.cycles-pp.cpuidle_idle_call
     31.47 ±  2%      +2.9       34.40        perf-profile.children.cycles-pp.do_idle
     31.48 ±  2%      +2.9       34.42        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     31.48 ±  2%      +2.9       34.42        perf-profile.children.cycles-pp.cpu_startup_entry
     30.93 ±  2%      +3.0       33.90        perf-profile.children.cycles-pp.start_secondary
      4.07 ±  3%      -0.6        3.45 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      3.56 ±  3%      -0.5        3.06 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      2.34 ±  4%      -0.4        1.96        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.50 ±  3%      -0.3        2.16 ±  4%  perf-profile.self.cycles-pp.stress_mwc32modn
      1.90 ±  4%      -0.2        1.67 ±  4%  perf-profile.self.cycles-pp.__entry_text_start
      1.23 ±  2%      -0.2        1.05 ±  4%  perf-profile.self.cycles-pp.link_path_walk
      0.65 ±  6%      -0.1        0.56 ±  7%  perf-profile.self.cycles-pp.stress_filename
      0.45 ±  7%      -0.1        0.36 ± 11%  perf-profile.self.cycles-pp.down_read
      0.44 ±  8%      -0.1        0.35 ±  9%  perf-profile.self.cycles-pp.generic_permission
      0.42 ±  5%      -0.1        0.34 ±  9%  perf-profile.self.cycles-pp.xlog_grant_add_space
      0.52 ±  6%      -0.1        0.44 ±  8%  perf-profile.self.cycles-pp.xfs_buf_get_map
      0.47 ±  7%      -0.1        0.41 ±  4%  perf-profile.self.cycles-pp.xfs_log_ticket_ungrant
      0.24 ± 10%      -0.1        0.18 ± 11%  perf-profile.self.cycles-pp.__check_heap_object
      0.21 ±  8%      -0.1        0.16 ± 11%  perf-profile.self.cycles-pp.step_into
      0.20 ±  6%      -0.0        0.16 ±  8%  perf-profile.self.cycles-pp.do_dentry_open
      0.19 ±  7%      -0.0        0.15 ± 14%  perf-profile.self.cycles-pp.set_nlink
      0.32 ±  6%      -0.0        0.28 ±  5%  perf-profile.self.cycles-pp.xfs_da_hashname
      0.08 ± 17%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.mnt_want_write
      0.17 ± 10%      -0.0        0.14 ± 11%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.06 ± 11%      +0.0        0.08 ± 17%  perf-profile.self.cycles-pp.newidle_balance
      0.06 ± 11%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.load_balance
      0.06 ± 14%      +0.0        0.08 ± 11%  perf-profile.self.cycles-pp._find_next_and_bit
      0.15 ±  6%      +0.0        0.18 ± 11%  perf-profile.self.cycles-pp.read_tsc
      0.06 ± 48%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.08 ± 20%      +0.0        0.13 ± 16%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.52 ±  7%      +0.0        0.56 ±  4%  perf-profile.self.cycles-pp.xfs_buf_item_size_segment
      0.02 ±141%      +0.1        0.07 ± 23%  perf-profile.self.cycles-pp.xlog_cil_order_cmp
      0.11 ± 15%      +0.1        0.16 ± 18%  perf-profile.self.cycles-pp.crc_pcl
      0.04 ± 71%      +0.1        0.10 ± 11%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.06 ± 11%      +0.1        0.12 ± 10%  perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.04 ± 44%      +0.1        0.10 ±  8%  perf-profile.self.cycles-pp.enqueue_entity
      0.08 ± 14%      +0.1        0.14 ±  7%  perf-profile.self.cycles-pp.update_load_avg
      0.03 ±100%      +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.update_curr
      0.12 ± 12%      +0.1        0.18 ± 10%  perf-profile.self.cycles-pp.native_sched_clock
      0.15 ± 12%      +0.1        0.21 ± 12%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.03 ± 70%      +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.12 ± 21%      +0.1        0.17 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.08 ± 21%      +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.__switch_to
      0.04 ± 71%      +0.1        0.09 ± 15%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.13 ± 18%      +0.1        0.19 ± 12%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.update_cfs_group
      0.02 ±142%      +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.02 ±142%      +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.os_xsave
      0.12 ±  6%      +0.1        0.19 ± 10%  perf-profile.self.cycles-pp._xfs_buf_obj_cmp
      0.18 ± 10%      +0.1        0.26 ±  6%  perf-profile.self.cycles-pp.menu_select
      0.02 ±142%      +0.1        0.09 ± 19%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.30 ±  8%      +0.1        0.38 ±  8%  perf-profile.self.cycles-pp.xfs_buf_offset
      0.14 ±  7%      +0.1        0.22 ± 11%  perf-profile.self.cycles-pp.__schedule
      0.00            +0.1        0.08 ± 22%  perf-profile.self.cycles-pp.avg_vruntime
      0.67 ±  3%      +0.1        0.76 ±  4%  perf-profile.self.cycles-pp.xlog_prepare_iovec
      0.16 ± 17%      +0.1        0.25 ± 10%  perf-profile.self.cycles-pp.xfs_buf_item_init
      0.35 ±  3%      +0.1        0.45 ±  6%  perf-profile.self.cycles-pp.xfs_next_bit
      0.41 ±  4%      +0.1        0.56 ±  3%  perf-profile.self.cycles-pp.xfs_contig_bits
      0.56 ±  6%      +0.3        0.82 ±  4%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.81 ± 10%      +0.3        1.08 ±  7%  perf-profile.self.cycles-pp.poll_idle
      1.04 ±  2%      +0.3        1.39 ±  7%  perf-profile.self.cycles-pp.memcpy_orig
      3.44 ±  5%      +1.1        4.49 ±  6%  perf-profile.self.cycles-pp.intel_idle
      3.45 ±  9%      +1.4        4.83 ±  8%  perf-profile.self.cycles-pp.intel_idle_irq


***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  memory/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/lockbus/stress-ng/60s

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     13656 ±  9%     -14.9%      11627 ±  9%  numa-meminfo.node1.Active(anon)
     60.52            +1.4%      61.36        turbostat.RAMWatt
      3887 ±  4%     -17.0%       3224 ± 11%  vmstat.system.cs
      3413 ±  9%     -15.0%       2902 ±  9%  numa-vmstat.node1.nr_active_anon
      3413 ±  9%     -15.0%       2901 ±  9%  numa-vmstat.node1.nr_zone_active_anon
      3966 ±  3%      -6.2%       3721 ±  2%  proc-vmstat.nr_active_anon
      3966 ±  3%      -6.2%       3721 ±  2%  proc-vmstat.nr_zone_active_anon
     69264            -6.0%      65120        stress-ng.lockbus.ops
      1152            -6.0%       1083        stress-ng.lockbus.ops_per_sec
     17830           -32.9%      11961 ±  7%  stress-ng.time.involuntary_context_switches
     36007           -32.3%      24373 ±  7%  stress-ng.time.voluntary_context_switches
     13.93            -0.6       13.32        perf-stat.i.cache-miss-rate%
      3761 ±  4%     -18.5%       3066 ± 12%  perf-stat.i.context-switches
     11.55            +4.1%      12.02 ±  2%  perf-stat.i.cpi
     27963 ±  2%      -3.4%      27016 ±  2%  perf-stat.i.dTLB-store-misses
    142439 ±  2%      -9.4%     128993 ±  4%  perf-stat.i.node-load-misses
      4.43            +2.9%       4.56        perf-stat.overall.cpi
      0.23            -2.8%       0.22        perf-stat.overall.ipc
      3706 ±  4%     -18.5%       3019 ± 12%  perf-stat.ps.context-switches
     27533 ±  2%      -3.5%      26568 ±  2%  perf-stat.ps.dTLB-store-misses
    140198 ±  2%      -9.4%     126952 ±  4%  perf-stat.ps.node-load-misses
      0.01 ± 42%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 11%     +98.0%       0.02 ± 31%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.11 ±  7%   +1058.4%       1.30 ± 10%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 85%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.63 ± 42%    +281.6%       2.41 ± 39%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ±  9%    +992.3%       0.28 ± 14%  perf-sched.total_sch_delay.average.ms
    113.93 ± 10%     +40.6%     160.23 ±  7%  perf-sched.total_wait_and_delay.average.ms
      8907 ± 12%     -28.7%       6347 ±  9%  perf-sched.total_wait_and_delay.count.ms
    113.90 ± 10%     +40.4%     159.95 ±  7%  perf-sched.total_wait_time.average.ms
    234.83 ±  3%     -23.0%     180.82 ± 10%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    189.41           +49.2%     282.58 ±  5%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    141.64 ±  5%     +46.2%     207.06 ±  3%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1500           -32.8%       1007 ±  5%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1496           -32.6%       1008 ±  5%  perf-sched.wait_and_delay.count.schedule_timeout.___down_common.__down_interruptible.down_interruptible
      1495           -32.6%       1008 ±  5%  perf-sched.wait_and_delay.count.schedule_timeout.msleep_interruptible.split_lock_warn.handle_user_split_lock
      1837           -26.4%       1352 ±  4%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    216.51 ±  2%     +53.6%     332.55 ±  5%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    355.47 ±118%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    234.82 ±  3%     -23.0%     180.82 ± 10%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    189.41           +49.2%     282.57 ±  5%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    141.53 ±  5%     +45.4%     205.77 ±  3%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1173 ±114%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    216.51 ±  2%     +53.6%     332.55 ±  5%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
     56.75            -3.5       53.26 ±  2%  perf-profile.calltrace.cycles-pp.stress_lockbus
      2.21 ±  4%      +0.2        2.39 ±  5%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      2.02 ±  7%      +0.4        2.45 ± 13%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     20.55 ±  3%      +1.5       22.06 ±  2%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     46.79            +2.4       49.24        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     37.90            +2.8       40.70        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     38.00            +3.2       41.16        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     37.58            +3.2       40.75        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     40.36            +3.3       43.67 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     40.84            +3.3       44.18 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     40.84            +3.3       44.18 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     40.79            +3.4       44.14 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     41.44            +3.4       44.87 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     56.78            -3.5       53.30 ±  2%  perf-profile.children.cycles-pp.stress_lockbus
      0.68 ±  9%      -0.1        0.54 ±  7%  perf-profile.children.cycles-pp.irq_work_run_list
      0.68 ± 10%      -0.1        0.53 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.67 ±  9%      -0.1        0.53 ±  8%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.67 ±  9%      -0.1        0.53 ±  8%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.67 ±  9%      -0.1        0.53 ±  8%  perf-profile.children.cycles-pp.irq_work_run
      0.67 ±  9%      -0.1        0.53 ±  8%  perf-profile.children.cycles-pp.irq_work_single
      0.67 ±  9%      -0.1        0.53 ±  8%  perf-profile.children.cycles-pp._printk
      0.67 ±  9%      -0.1        0.53 ±  8%  perf-profile.children.cycles-pp.vprintk_emit
      0.66 ± 10%      -0.1        0.52 ±  7%  perf-profile.children.cycles-pp.console_unlock
      0.66 ± 10%      -0.1        0.52 ±  7%  perf-profile.children.cycles-pp.console_flush_all
      0.63 ±  9%      -0.1        0.50 ±  8%  perf-profile.children.cycles-pp.serial8250_console_write
      0.60 ±  8%      -0.1        0.47 ±  8%  perf-profile.children.cycles-pp.wait_for_lsr
      0.49 ± 11%      -0.1        0.36 ±  9%  perf-profile.children.cycles-pp.io_serial_in
      0.26 ± 15%      -0.1        0.16 ± 21%  perf-profile.children.cycles-pp.asm_exc_alignment_check
      0.56 ±  9%      -0.1        0.46 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.25 ± 15%      -0.1        0.16 ± 20%  perf-profile.children.cycles-pp.exc_alignment_check
      0.20 ± 14%      -0.1        0.12 ± 25%  perf-profile.children.cycles-pp.msleep_interruptible
      0.24 ± 15%      -0.1        0.16 ± 20%  perf-profile.children.cycles-pp.handle_user_split_lock
      0.24 ± 15%      -0.1        0.16 ± 20%  perf-profile.children.cycles-pp.split_lock_warn
      0.16 ± 17%      -0.1        0.09 ± 20%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.14 ± 20%      -0.1        0.07 ± 47%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.14 ± 18%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.13 ± 11%      -0.0        0.08 ± 26%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.11 ± 15%      -0.0        0.06 ± 50%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.10 ± 15%      -0.0        0.05 ± 46%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.12 ± 12%      -0.0        0.07 ± 21%  perf-profile.children.cycles-pp.task_work_run
      0.20 ± 14%      +0.1        0.26 ±  7%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.06 ± 47%      +0.1        0.17 ± 30%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.00            +0.2        0.16 ±122%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      2.06 ±  7%      +0.4        2.49 ± 13%  perf-profile.children.cycles-pp.menu_select
     30.75            +1.0       31.77        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     38.45            +2.9       41.35        perf-profile.children.cycles-pp.cpuidle_enter
     38.32            +2.9       41.24        perf-profile.children.cycles-pp.cpuidle_enter_state
     37.88            +2.9       40.82        perf-profile.children.cycles-pp.acpi_idle_enter
     37.79            +2.9       40.73        perf-profile.children.cycles-pp.acpi_safe_halt
     40.84            +3.3       44.18 ±  2%  perf-profile.children.cycles-pp.start_secondary
     40.98            +3.4       44.37 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
     41.44            +3.4       44.87 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     41.44            +3.4       44.87 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     41.43            +3.4       44.87 ±  2%  perf-profile.children.cycles-pp.do_idle
     56.26            -3.3       52.94 ±  2%  perf-profile.self.cycles-pp.stress_lockbus
      0.47 ± 10%      -0.1        0.35 ± 10%  perf-profile.self.cycles-pp.io_serial_in
      0.55 ±  9%      -0.1        0.46 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.09 ± 11%      -0.0        0.05 ± 72%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.03 ±101%      +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.hrtimer_next_event_without
      0.15 ±  9%      +0.1        0.21 ± 12%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.05 ± 48%      +0.1        0.13 ± 34%  perf-profile.self.cycles-pp.irq_work_needs_cpu
      0.01 ±223%      +0.1        0.10 ± 20%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.2        0.16 ±127%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.39 ±  5%      +0.2        0.63 ± 10%  perf-profile.self.cycles-pp.menu_select
     23.01 ±  3%      +3.5       26.48 ±  3%  perf-profile.self.cycles-pp.acpi_safe_halt



***************************************************************************************************
lkp-skl-d08: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  interrupt/gcc-12/performance/1SSD/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/sigfd/stress-ng/60s

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    253708 ± 13%    +136.2%     599134 ± 33%  cpuidle..usage
     35.43            +4.5       39.94        mpstat.cpu.all.usr%
     56.93            -7.8%      52.48        iostat.cpu.system
     34.43           +12.3%      38.67        iostat.cpu.user
    166.50 ± 62%     -87.9%      20.17 ± 37%  perf-c2c.DRAM.local
      2950 ±  4%     +36.7%       4034 ±  3%  perf-c2c.HITM.local
   6322874           -53.5%    2941783        vmstat.memory.cache
  25427591           +13.6%   28889500        vmstat.memory.free
     55.00           +16.4%      64.00        vmstat.procs.r
   3896193           -98.6%      53463 ± 21%  vmstat.system.cs
     81531           -30.6%      56593        vmstat.system.in
 3.441e+08           +17.6%  4.047e+08        stress-ng.sigfd.ops
   5734484           +17.6%    6745114        stress-ng.sigfd.ops_per_sec
 1.277e+08           -99.7%     375150        stress-ng.time.involuntary_context_switches
      3369            +1.1%       3406        stress-ng.time.percent_of_cpu_this_job_got
      1343            -7.9%       1237        stress-ng.time.system_time
    757.06           +18.0%     893.08        stress-ng.time.user_time
 1.282e+08           -98.2%    2309843 ± 19%  stress-ng.time.voluntary_context_switches
      0.23 ± 58%    +271.7%       0.86 ± 14%  turbostat.CPU%c6
      0.09 ±  4%     -35.8%       0.06 ±  8%  turbostat.IPC
   5368468           -30.8%    3714484        turbostat.IRQ
     31407 ± 43%    +994.9%     343860 ± 49%  turbostat.POLL
      0.05 ±223%   +1100.0%       0.64 ± 18%  turbostat.Pkg%pc2
     46.33 ±  3%      -8.6%      42.33        turbostat.PkgTmp
    179.76            -6.0%     169.06        turbostat.PkgWatt
      1.01           -11.4%       0.90        turbostat.RAMWatt
    574041 ± 79%     -63.0%     212329 ± 79%  meminfo.Active
    573863 ± 79%     -77.5%     128881 ± 17%  meminfo.Active(anon)
    354239           -15.1%     300649        meminfo.AnonPages
   6204630           -53.9%    2863247        meminfo.Cached
   4724536           -72.3%    1307972 ±  2%  meminfo.Committed_AS
   3273969 ± 14%     -90.1%     323898        meminfo.Inactive
   3273680 ± 14%     -90.2%     319651        meminfo.Inactive(anon)
   1289574 ± 12%     -95.7%      54909 ±  5%  meminfo.Mapped
  25234814           +13.9%   28730239        meminfo.MemAvailable
  25458262           +13.5%   28886614        meminfo.MemFree
   7103772           -48.3%    3675420 ±  4%  meminfo.Memused
     10748 ±  3%     -25.5%       8009 ±  2%  meminfo.PageTables
   3493681           -95.8%     148301 ± 18%  meminfo.Shmem
   7140927           -46.4%    3828694 ±  4%  meminfo.max_used_kB
    143464 ± 79%     -77.5%      32218 ± 17%  proc-vmstat.nr_active_anon
     88568           -15.1%      75170        proc-vmstat.nr_anon_pages
    628908           +14.0%     716679        proc-vmstat.nr_dirty_background_threshold
   1259356           +14.0%    1435113        proc-vmstat.nr_dirty_threshold
   1551266           -52.5%     736621 ±  5%  proc-vmstat.nr_file_pages
   6364467           +13.5%    7221660        proc-vmstat.nr_free_pages
    818533 ± 14%     -90.2%      79908        proc-vmstat.nr_inactive_anon
     10060            -2.3%       9828        proc-vmstat.nr_kernel_stack
    322934 ± 12%     -95.8%      13709 ±  5%  proc-vmstat.nr_mapped
      2688 ±  3%     -25.5%       2001 ±  2%  proc-vmstat.nr_page_table_pages
    873528           -95.8%      37060 ± 18%  proc-vmstat.nr_shmem
    143464 ± 79%     -77.5%      32218 ± 17%  proc-vmstat.nr_zone_active_anon
    818533 ± 14%     -90.2%      79908        proc-vmstat.nr_zone_inactive_anon
   2677779            +2.6%    2747266        proc-vmstat.numa_hit
   2677778            +2.6%    2747331        proc-vmstat.numa_local
     28685 ± 38%     +92.4%      55189 ± 12%  proc-vmstat.pgactivate
   2713395            +2.5%    2782484        proc-vmstat.pgalloc_normal
    317818 ±  3%     -21.8%     248483        proc-vmstat.pgfault
   1394260           +92.6%    2685162        proc-vmstat.pgfree
      8198            +3.3%       8467        proc-vmstat.pgreuse
    938223           +14.4%    1073726        sched_debug.cfs_rq:/.avg_vruntime.avg
    994157           +20.0%    1192780 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
     19325 ±  9%    +150.1%      48339 ± 13%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      1.10 ±  3%     +12.7%       1.24        sched_debug.cfs_rq:/.h_nr_running.avg
    551.08 ±  4%     +29.2%     712.17 ±  4%  sched_debug.cfs_rq:/.load_avg.max
    938223           +14.4%    1073726        sched_debug.cfs_rq:/.min_vruntime.avg
    994157           +20.0%    1192790 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
     19325 ±  9%    +150.1%      48340 ± 13%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1201           +12.5%       1350        sched_debug.cfs_rq:/.runnable_avg.avg
      2025 ±  4%     +18.2%       2393 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
    276.13 ±  9%     +61.0%     444.71 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
    476.67 ±  5%     -22.2%     370.83 ±  9%  sched_debug.cfs_rq:/.util_avg.min
    203.19 ± 11%     +32.4%     269.09 ± 10%  sched_debug.cfs_rq:/.util_avg.stddev
    174.48 ±  7%     +16.4%     203.01 ±  8%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    380990 ±  3%     -31.8%     259898 ±  4%  sched_debug.cpu.avg_idle.avg
    307426 ±  4%     -39.9%     184804 ±  9%  sched_debug.cpu.avg_idle.stddev
      3.81 ± 10%     -38.1%       2.36 ± 29%  sched_debug.cpu.clock.stddev
     73.87 ±  4%     -12.2%      64.86        sched_debug.cpu.clock_task.stddev
      1.11 ±  3%     +12.3%       1.25        sched_debug.cpu.nr_running.avg
   3367531           -98.5%      50921 ± 19%  sched_debug.cpu.nr_switches.avg
   3625378           -94.0%     218664 ± 49%  sched_debug.cpu.nr_switches.max
   2489663 ± 13%     -99.5%      12797 ±  5%  sched_debug.cpu.nr_switches.min
    268237 ± 21%     -84.7%      40977 ± 40%  sched_debug.cpu.nr_switches.stddev
      0.13 ±  3%     -43.8%       0.07 ± 12%  perf-stat.i.MPKI
  7.37e+09           -41.2%  4.333e+09        perf-stat.i.branch-instructions
      1.75            +0.1        1.88        perf-stat.i.branch-miss-rate%
 1.218e+08           -35.1%   79006703        perf-stat.i.branch-misses
      4.54 ±  7%      -2.7        1.89 ± 11%  perf-stat.i.cache-miss-rate%
   5337171 ±  4%     -70.8%    1556171 ±  4%  perf-stat.i.cache-misses
 1.324e+08 ± 10%     +17.0%  1.549e+08 ±  4%  perf-stat.i.cache-references
   4092256           -98.7%      55203 ± 21%  perf-stat.i.context-switches
      3.33           +56.7%       5.22        perf-stat.i.cpi
    185.40 ±  4%     +29.6%     240.27 ±  7%  perf-stat.i.cpu-migrations
 2.551e+12 ±223%    -100.0%   25988310        perf-stat.i.dTLB-load-misses
 1.054e+10           -37.7%  6.568e+09        perf-stat.i.dTLB-loads
      0.01 ± 39%      -0.0        0.00 ± 10%  perf-stat.i.dTLB-store-miss-rate%
    756875 ± 40%     -90.4%      72744 ± 10%  perf-stat.i.dTLB-store-misses
 6.348e+09           -35.9%   4.07e+09        perf-stat.i.dTLB-stores
     34.90           +47.5       82.41 ±  2%  perf-stat.i.iTLB-load-miss-rate%
  25434272 ±  2%     +18.1%   30031173 ±  4%  perf-stat.i.iTLB-load-misses
  47308644           -88.6%    5405815 ± 13%  perf-stat.i.iTLB-loads
 3.885e+10           -37.4%  2.432e+10        perf-stat.i.instructions
      3454 ±  3%     -21.7%       2706 ± 14%  perf-stat.i.instructions-per-iTLB-miss
      0.33           -31.3%       0.23        perf-stat.i.ipc
    267.83 ±  5%     -26.7%     196.31 ±  9%  perf-stat.i.metric.K/sec
    678.76           -38.1%     419.96        perf-stat.i.metric.M/sec
      3629 ±  4%     -29.7%       2551        perf-stat.i.minor-faults
   1176942 ± 19%     -87.4%     148587 ±  6%  perf-stat.i.node-loads
    553456 ±  6%     -48.3%     286312 ±  2%  perf-stat.i.node-stores
      3629 ±  4%     -29.7%       2552        perf-stat.i.page-faults
      0.14 ±  4%     -54.1%       0.06 ±  5%  perf-stat.overall.MPKI
      1.65            +0.2        1.82        perf-stat.overall.branch-miss-rate%
      4.07 ± 11%      -3.1        0.99 ±  7%  perf-stat.overall.cache-miss-rate%
      3.35           +59.2%       5.34        perf-stat.overall.cpi
     24445 ±  4%    +246.8%      84772 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.01 ± 40%      -0.0        0.00 ± 10%  perf-stat.overall.dTLB-store-miss-rate%
     34.96           +49.8       84.73 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
      1528 ±  2%     -47.0%     810.40 ±  4%  perf-stat.overall.instructions-per-iTLB-miss
      0.30           -37.2%       0.19        perf-stat.overall.ipc
 7.255e+09           -41.2%  4.267e+09        perf-stat.ps.branch-instructions
 1.199e+08           -35.3%   77595921        perf-stat.ps.branch-misses
   5256369 ±  4%     -71.2%    1512093 ±  4%  perf-stat.ps.cache-misses
 1.304e+08 ± 10%     +17.3%   1.53e+08 ±  4%  perf-stat.ps.cache-references
   4027980           -98.6%      54625 ± 21%  perf-stat.ps.context-switches
    182.42 ±  4%     +29.9%     237.02 ±  7%  perf-stat.ps.cpu-migrations
 2.504e+12 ±223%    -100.0%   25641665        perf-stat.ps.dTLB-load-misses
 1.038e+10           -37.6%  6.472e+09        perf-stat.ps.dTLB-loads
    745124 ± 40%     -90.4%      71588 ± 10%  perf-stat.ps.dTLB-store-misses
 6.249e+09           -35.8%  4.013e+09        perf-stat.ps.dTLB-stores
  25036838 ±  2%     +18.4%   29632745 ±  4%  perf-stat.ps.iTLB-load-misses
  46566778           -88.6%    5330136 ± 13%  perf-stat.ps.iTLB-loads
 3.824e+10           -37.4%  2.396e+10        perf-stat.ps.instructions
      3569 ±  4%     -30.8%       2469        perf-stat.ps.minor-faults
   1158877 ± 19%     -87.5%     144748 ±  6%  perf-stat.ps.node-loads
    545337 ±  6%     -48.4%     281416 ±  2%  perf-stat.ps.node-stores
      3569 ±  4%     -30.8%       2469        perf-stat.ps.page-faults
 2.432e+12           -37.4%  1.524e+12        perf-stat.total.instructions
      0.14 ± 87%   +1555.7%       2.31 ± 15%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.56 ± 17%    +319.2%       2.36 ± 15%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.60 ±143%   +1009.2%       6.60 ±109%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.02 ±  4%  +10979.7%       2.46 ± 48%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.29 ± 23%    +499.9%       1.73 ± 16%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.11 ± 48%    +849.5%       1.06 ± 23%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ± 14%    +123.3%       0.02 ± 29%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.04 ± 17%   +2052.2%       0.80 ± 19%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 42%  +22451.8%       3.12 ±  6%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 90%    +465.7%       0.27 ± 23%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ± 11%  +11390.4%       1.40 ± 22%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.48 ± 16%    +174.2%       1.33 ±  8%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ±  5%  +12626.3%       1.21 ± 19%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.02 ± 77%  +15778.6%       2.73 ±  5%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.02 ±  2%   +4345.4%       0.96 ± 37%  perf-sched.sch_delay.avg.ms.signalfd_dequeue.signalfd_read.vfs_read.ksys_read
      0.01 ± 27%   +1287.7%       0.17 ± 17%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.08 ± 80%   +1825.3%       1.56 ± 61%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.03 ±143%   +3719.1%       1.16 ± 40%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.02 ± 26%  +26270.4%       4.31 ±162%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.92 ± 76%    +173.4%       5.26 ±  7%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      2.55 ± 25%     +93.7%       4.93 ± 10%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.62 ±135%    +959.9%       6.60 ±109%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1.50 ± 55%    +200.2%       4.52 ± 26%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2.78 ± 22%     -91.5%       0.24 ±142%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      3.02 ± 19%     +49.5%       4.51 ±  9%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.69 ±216%    +772.6%       6.01 ± 53%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.56 ± 98%    +458.0%       3.10 ±  6%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.03 ± 43%  +11384.2%       3.02 ± 14%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ±  7%  +21834.2%       2.67 ± 27%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      2.86 ±221%    +721.8%      23.50 ± 77%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.15 ± 78%    +245.8%       3.98        perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.12 ± 96%   +1205.0%       1.56 ± 61%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.54 ±165%    +751.0%       4.60 ± 13%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      1.18 ± 74%   +3965.3%      47.99 ±196%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01         +6693.9%       0.75 ± 27%  perf-sched.total_sch_delay.average.ms
      0.09         +6069.7%       5.43 ± 27%  perf-sched.total_wait_and_delay.average.ms
   8083586           -98.2%     147185 ± 27%  perf-sched.total_wait_and_delay.count.ms
      0.08 ±  2%   +5967.6%       4.68 ± 27%  perf-sched.total_wait_time.average.ms
      1.48 ±126%  +21665.4%     322.06 ± 50%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
     18.51 ±  7%     +16.4%      21.54 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.51 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.26 ± 83%  +48951.0%     125.33 ± 40%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.14 ± 81%  +1.3e+05%     176.52 ± 57%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
    374.91 ± 26%    +114.5%     804.01        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.13 ± 13%   +5456.7%       6.97 ± 47%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.11 ± 16%   +1515.9%       1.77 ±  2%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.02 ±  3%  +10782.8%       1.80 ±  3%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    111.99 ± 28%    +414.1%     575.79 ±  2%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.63 ±  5%    +190.7%      10.54 ±  2%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    586.45 ±  2%     -68.0%     187.86 ± 18%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    387.39 ±  3%     +11.5%     431.95 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      8.40 ±  2%     +22.7%      10.30 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.05         +4315.4%       2.25 ± 38%  perf-sched.wait_and_delay.avg.ms.signalfd_dequeue.signalfd_read.vfs_read.ksys_read
      5.00 ± 40%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     54900           -94.3%       3143 ± 85%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     47.17 ±  4%     -74.2%      12.17 ±100%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     27665 ±  3%     -49.4%      13994        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
   3967007           -99.6%      17684 ±  2%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    461.67 ± 27%     -81.7%      84.33 ±  2%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    264.33 ±  2%     -23.2%     203.00 ±  5%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     20.50 ±  2%    +291.9%      80.33 ± 21%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
   4015151           -97.2%     110553 ± 35%  perf-sched.wait_and_delay.count.signalfd_dequeue.signalfd_read.vfs_read.ksys_read
      5.77 ± 46%   +9584.3%     559.22 ± 61%  perf-sched.wait_and_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      2.47 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      6.64 ± 71%   +5251.2%     355.39 ± 62%  perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      6.49 ± 72%   +4657.3%     308.75 ± 59%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      1001           -96.6%      34.32 ± 10%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      5.51 ± 20%    +191.4%      16.06 ± 40%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    499.96           +11.9%     559.61 ±  6%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.49 ±125%  +21524.1%     322.06 ± 50%  perf-sched.wait_time.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
     18.49 ±  7%     +16.2%      21.48 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.17 ±133%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      1.51 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.27 ± 71%  +45862.8%     125.33 ± 40%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.16 ± 60%  +1.1e+05%     176.52 ± 57%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      0.06 ±101%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
    374.35 ± 26%    +114.1%     801.65        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.10 ± 16%   +4250.9%       4.52 ± 46%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.52 ± 32%    +593.2%       3.63 ± 17%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.10 ± 19%   +1653.1%       1.74 ±  2%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.05 ± 46%   +4462.5%       2.43 ± 33%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.02 ±  3%  +10625.3%       1.77 ±  2%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    111.96 ± 28%    +413.6%     574.99 ±  2%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.61 ±  5%    +105.5%       7.42        perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    586.40 ±  2%     -68.0%     187.59 ± 18%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    387.37 ±  3%     +11.1%     430.56 ±  6%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      2.79 ± 10%     +70.8%       4.76 ±  8%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.03         +4244.4%       1.29 ± 39%  perf-sched.wait_time.avg.ms.signalfd_dequeue.signalfd_read.vfs_read.ksys_read
      0.05 ± 77%    +948.6%       0.51 ± 20%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      6.95 ± 11%   +7947.3%     559.22 ± 61%  perf-sched.wait_time.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      2.05 ± 97%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      2.47 ± 13%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      9.86 ±  5%   +3506.0%     355.39 ± 62%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      9.04 ± 18%   +3315.1%     308.75 ± 59%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      0.33 ±129%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      3.45 ± 28%    +210.4%      10.71 ± 14%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1000           -97.3%      26.58 ± 24%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      5.50 ± 20%     +82.9%      10.06 ± 31%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    499.95           +11.5%     557.31 ±  7%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      8.72 ± 17%     +24.3%      10.84 ±  7%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.37 ±137%   +1006.1%       4.12 ±  8%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      5.76            -5.8        0.00        perf-profile.calltrace.cycles-pp.schedule.signalfd_dequeue.signalfd_read.vfs_read.ksys_read
      5.63            -5.6        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.signalfd_dequeue.signalfd_read.vfs_read
      5.32            -5.1        0.19 ±142%  perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.__send_signal_locked.do_send_sig_info
      5.70            -4.8        0.87 ±  6%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.__send_signal_locked.do_send_sig_info.kill_pid_info
      6.16            -4.8        1.36 ±  4%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.__send_signal_locked.do_send_sig_info.kill_pid_info.do_rt_sigqueueinfo
     10.19            -4.4        5.80 ±  3%  perf-profile.calltrace.cycles-pp.signalfd_dequeue.signalfd_read.vfs_read.ksys_read.do_syscall_64
     11.77            -4.1        7.66 ±  2%  perf-profile.calltrace.cycles-pp.signalfd_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.97            -3.8        6.17        perf-profile.calltrace.cycles-pp.__send_signal_locked.do_send_sig_info.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo
      8.10            -3.7        4.44        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sigqueue
     10.70            -3.6        7.12        perf-profile.calltrace.cycles-pp.do_send_sig_info.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo.do_syscall_64
     29.25            -3.4       25.83        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sigqueue
     31.76            -3.4       28.38        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sigqueue
     14.16            -3.2       10.95 ±  2%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     14.88            -3.0       11.83        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     19.48            -2.7       16.76        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     39.98            -2.6       37.35        perf-profile.calltrace.cycles-pp.sigqueue
     22.09            -2.5       19.62        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     29.54            -1.6       27.98        perf-profile.calltrace.cycles-pp.read
      0.86            +0.1        0.96 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_getuid.do_syscall_64.entry_SYSCALL_64_after_hwframe.getuid
      0.52 ±  2%      +0.1        0.62        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc.__sigqueue_alloc.__send_signal_locked.do_send_sig_info
      0.73 ±  2%      +0.1        0.85        perf-profile.calltrace.cycles-pp.kmem_cache_free.dequeue_signal.signalfd_dequeue.signalfd_read.vfs_read
      0.70            +0.1        0.84        perf-profile.calltrace.cycles-pp._copy_from_user.__x64_sys_rt_sigqueueinfo.do_syscall_64.entry_SYSCALL_64_after_hwframe.sigqueue
      0.55 ±  6%      +0.2        0.73 ±  9%  perf-profile.calltrace.cycles-pp._copy_to_user.signalfd_copyinfo.signalfd_read.vfs_read.ksys_read
      1.36            +0.3        1.62        perf-profile.calltrace.cycles-pp.__entry_text_start.getuid
      1.12 ±  3%      +0.3        1.40 ±  5%  perf-profile.calltrace.cycles-pp.signalfd_copyinfo.signalfd_read.vfs_read.ksys_read.do_syscall_64
      0.79 ± 10%      +0.3        1.07 ±  9%  perf-profile.calltrace.cycles-pp.profile_signal_perm.aa_may_signal.apparmor_task_kill.security_task_kill.kill_pid_info
      1.40            +0.3        1.68        perf-profile.calltrace.cycles-pp.__entry_text_start.sigqueue
      4.11            +0.3        4.40        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.38            +0.3        1.68        perf-profile.calltrace.cycles-pp.__entry_text_start.__getpid
      1.33            +0.3        1.65        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.__sigqueue_alloc.__send_signal_locked.do_send_sig_info.kill_pid_info
      0.70 ±  2%      +0.3        1.03 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_getpid.do_syscall_64.entry_SYSCALL_64_after_hwframe.__getpid
      1.25            +0.4        1.62        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.getuid
      1.51            +0.4        1.90        perf-profile.calltrace.cycles-pp.__entry_text_start.read
      1.36            +0.4        1.77        perf-profile.calltrace.cycles-pp.inc_rlimit_get_ucounts.__sigqueue_alloc.__send_signal_locked.do_send_sig_info.kill_pid_info
      0.58 ±  2%      +0.4        1.00 ±  2%  perf-profile.calltrace.cycles-pp.__task_pid_nr_ns.__x64_sys_getpid.do_syscall_64.entry_SYSCALL_64_after_hwframe.__getpid
      3.64            +0.4        4.07        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__getpid
      0.17 ±141%      +0.4        0.60 ±  2%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.21 ±  2%      +0.5        1.75 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.read
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.58            +0.6        4.21        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.getuid
      0.97 ± 25%      +0.7        1.62        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__getpid
      1.46            +0.7        2.18        perf-profile.calltrace.cycles-pp.do_dec_rlimit_put_ucounts.collect_signal.dequeue_signal.signalfd_dequeue.signalfd_read
      2.82            +0.7        3.55        perf-profile.calltrace.cycles-pp.__sigqueue_alloc.__send_signal_locked.do_send_sig_info.kill_pid_info.do_rt_sigqueueinfo
      1.72            +0.8        2.55        perf-profile.calltrace.cycles-pp.collect_signal.dequeue_signal.signalfd_dequeue.signalfd_read.vfs_read
      0.00            +0.9        0.86 ±  4%  perf-profile.calltrace.cycles-pp.__slab_free.dequeue_signal.signalfd_dequeue.signalfd_read.vfs_read
      0.55 ±  2%      +0.9        1.42 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.sigqueue
      4.89            +0.9        5.81        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getuid
      1.83            +0.9        2.77 ±  2%  perf-profile.calltrace.cycles-pp.aa_get_task_label.apparmor_task_kill.security_task_kill.kill_pid_info.do_rt_sigqueueinfo
      2.09 ±  4%      +1.0        3.05 ±  3%  perf-profile.calltrace.cycles-pp.aa_may_signal.apparmor_task_kill.security_task_kill.kill_pid_info.do_rt_sigqueueinfo
      1.72            +1.0        2.69        perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_read.ksys_read.do_syscall_64
      1.84            +1.0        2.82        perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.70            +1.0        5.68        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__getpid
      4.16            +1.0        5.14        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.getuid
      4.20            +1.0        5.19        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.sigqueue
      4.13            +1.1        5.19        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      4.19            +1.1        5.26        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__getpid
      7.18            +1.3        8.45        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getuid
      7.03            +1.3        8.36        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__getpid
      3.40            +1.5        4.89        perf-profile.calltrace.cycles-pp.dequeue_signal.signalfd_dequeue.signalfd_read.vfs_read.ksys_read
     13.72            +2.8       16.48        perf-profile.calltrace.cycles-pp.getuid
     13.55            +3.0       16.55        perf-profile.calltrace.cycles-pp.__getpid
      7.36            +3.4       10.78        perf-profile.calltrace.cycles-pp.apparmor_task_kill.security_task_kill.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo
      7.42            +3.4       10.85        perf-profile.calltrace.cycles-pp.security_task_kill.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo.do_syscall_64
      9.68            -9.5        0.18 ± 35%  perf-profile.children.cycles-pp.schedule
      9.47            -9.3        0.20 ± 42%  perf-profile.children.cycles-pp.__schedule
      6.14            -5.3        0.85 ±  3%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      5.37            -4.9        0.52 ± 12%  perf-profile.children.cycles-pp.try_to_wake_up
      5.71            -4.8        0.88 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      6.20            -4.8        1.40 ±  4%  perf-profile.children.cycles-pp.__wake_up_common_lock
     10.23            -4.4        5.81 ±  3%  perf-profile.children.cycles-pp.signalfd_dequeue
     58.54            -4.3       54.25        perf-profile.children.cycles-pp.do_syscall_64
     11.80            -4.1        7.68 ±  2%  perf-profile.children.cycles-pp.signalfd_read
     10.00            -3.8        6.22        perf-profile.children.cycles-pp.__send_signal_locked
     10.72            -3.6        7.16        perf-profile.children.cycles-pp.do_send_sig_info
     68.34            -3.2       65.11        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     14.17            -3.2       10.97 ±  2%  perf-profile.children.cycles-pp.vfs_read
     14.89            -3.0       11.84        perf-profile.children.cycles-pp.ksys_read
      3.03            -3.0        0.06 ± 94%  perf-profile.children.cycles-pp.ttwu_do_activate
     40.22            -2.6       37.61        perf-profile.children.cycles-pp.sigqueue
      2.45            -2.4        0.04 ±114%  perf-profile.children.cycles-pp.activate_task
      2.36            -2.3        0.04 ±114%  perf-profile.children.cycles-pp.enqueue_task_fair
      2.36            -2.3        0.06 ± 60%  perf-profile.children.cycles-pp.dequeue_task_fair
     19.51            -2.3       17.22        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.75            -1.7        0.06 ± 24%  perf-profile.children.cycles-pp.update_load_avg
     29.80            -1.5       28.27        perf-profile.children.cycles-pp.read
      0.14 ±  6%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.13 ±  4%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.39 ±  2%      -0.0        0.35 ±  5%  perf-profile.children.cycles-pp.recalc_sigpending
      0.37            -0.0        0.33 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.32 ±  2%      -0.0        0.29        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.09 ± 10%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.__libc_current_sigrtmin@plt
      0.28 ±  2%      -0.0        0.26        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.29            -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.24 ±  2%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.05 ±  8%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.post_copy_siginfo_from_user
      0.10            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.complete_signal
      0.06 ±  8%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.siginfo_layout
      0.05 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.fsnotify_perm
      0.11 ±  4%      +0.0        0.14 ±  8%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.32 ±  3%      +0.0        0.35 ±  4%  perf-profile.children.cycles-pp.__libc_current_sigrtmin_private
      0.22            +0.0        0.27 ±  3%  perf-profile.children.cycles-pp.mod_objcg_state
      0.38 ±  3%      +0.0        0.43 ±  2%  perf-profile.children.cycles-pp.from_kuid_munged
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.05 ±  8%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.allocate_slab
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.shuffle_freelist
      0.19 ±  3%      +0.1        0.26 ±  7%  perf-profile.children.cycles-pp.prepare_signal
      0.25            +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.map_id_up
      0.47 ±  3%      +0.1        0.56        perf-profile.children.cycles-pp.__fget_light
      0.53 ±  2%      +0.1        0.63        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.50 ±  3%      +0.1        0.61 ±  2%  perf-profile.children.cycles-pp.__fdget_pos
      0.10 ±  3%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.___slab_alloc
      0.92 ±  2%      +0.1        1.04 ±  2%  perf-profile.children.cycles-pp.__x64_sys_getuid
      0.74 ±  2%      +0.1        0.86        perf-profile.children.cycles-pp.kmem_cache_free
      0.92 ±  2%      +0.1        1.06        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.74 ±  2%      +0.2        0.90        perf-profile.children.cycles-pp._copy_from_user
      0.30 ±  3%      +0.2        0.47 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.62 ±  4%      +0.2        0.80        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.61 ±  5%      +0.2        0.80 ±  8%  perf-profile.children.cycles-pp.rep_movs_alternative
      0.64 ±  5%      +0.2        0.84 ±  7%  perf-profile.children.cycles-pp._copy_to_user
      0.32 ±  2%      +0.2        0.55 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.2        0.24 ± 11%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.20 ±  5%      +0.3        0.47        perf-profile.children.cycles-pp.aa_file_perm
      0.80 ± 10%      +0.3        1.08 ±  9%  perf-profile.children.cycles-pp.profile_signal_perm
      1.13 ±  3%      +0.3        1.42 ±  5%  perf-profile.children.cycles-pp.signalfd_copyinfo
      1.35            +0.3        1.68        perf-profile.children.cycles-pp.kmem_cache_alloc
      1.36            +0.4        1.77        perf-profile.children.cycles-pp.inc_rlimit_get_ucounts
      0.68 ±  2%      +0.4        1.10 ±  3%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.76            +0.4        1.19 ±  2%  perf-profile.children.cycles-pp.__x64_sys_getpid
      0.37 ±  3%      +0.5        0.87 ±  4%  perf-profile.children.cycles-pp.__slab_free
      1.46            +0.7        2.18        perf-profile.children.cycles-pp.do_dec_rlimit_put_ucounts
      2.82            +0.7        3.56        perf-profile.children.cycles-pp.__sigqueue_alloc
      1.72            +0.8        2.56        perf-profile.children.cycles-pp.collect_signal
      2.54            +0.9        3.47        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.83            +0.9        2.77 ±  2%  perf-profile.children.cycles-pp.aa_get_task_label
      2.10 ±  4%      +1.0        3.07 ±  3%  perf-profile.children.cycles-pp.aa_may_signal
      1.74            +1.0        2.70        perf-profile.children.cycles-pp.apparmor_file_permission
      1.85            +1.0        2.83        perf-profile.children.cycles-pp.security_file_permission
      3.42            +1.5        4.90        perf-profile.children.cycles-pp.dequeue_signal
      7.69            +2.1        9.83        perf-profile.children.cycles-pp.__entry_text_start
     13.99            +2.8       16.81        perf-profile.children.cycles-pp.getuid
     13.82            +3.1       16.88        perf-profile.children.cycles-pp.__getpid
      7.38            +3.4       10.80        perf-profile.children.cycles-pp.apparmor_task_kill
      7.42            +3.4       10.85        perf-profile.children.cycles-pp.security_task_kill
     16.80            +4.1       20.92        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.48 ±  3%      -0.2        0.28 ±  3%  perf-profile.self.cycles-pp.signalfd_dequeue
      0.32 ±  5%      -0.1        0.19 ± 11%  perf-profile.self.cycles-pp.try_to_wake_up
      0.43 ±  3%      -0.1        0.34 ± 10%  perf-profile.self.cycles-pp.vfs_read
      0.12 ±  4%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.80 ±  2%      -0.1        0.74 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.12 ±  4%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.38 ±  2%      -0.0        0.34 ±  5%  perf-profile.self.cycles-pp.recalc_sigpending
      0.10            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.complete_signal
      0.14 ±  4%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.send_signal_locked
      0.11 ±  3%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.kill_pid_info
      0.04 ± 44%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.siginfo_layout
      0.49            +0.0        0.52        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.09 ±  5%      +0.0        0.12 ± 10%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.27 ±  4%      +0.0        0.30 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.03 ± 70%      +0.0        0.07 ±  8%  perf-profile.self.cycles-pp.fsnotify_perm
      0.22 ±  2%      +0.0        0.26 ±  4%  perf-profile.self.cycles-pp.mod_objcg_state
      0.21 ±  3%      +0.0        0.26 ±  5%  perf-profile.self.cycles-pp.ksys_read
      0.31 ±  4%      +0.1        0.36 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__fdget_pos
      0.26 ±  4%      +0.1        0.32 ±  2%  perf-profile.self.cycles-pp._copy_to_user
      0.78            +0.1        0.84        perf-profile.self.cycles-pp.__x64_sys_rt_sigqueueinfo
      0.27 ±  2%      +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.getuid
      0.27 ±  3%      +0.1        0.33 ±  3%  perf-profile.self.cycles-pp.__getpid
      0.48 ±  3%      +0.1        0.55        perf-profile.self.cycles-pp.kmem_cache_free
      0.24            +0.1        0.30 ±  4%  perf-profile.self.cycles-pp.__libc_current_sigrtmin_private
      0.18 ±  4%      +0.1        0.25 ±  7%  perf-profile.self.cycles-pp.prepare_signal
      0.45            +0.1        0.53 ±  3%  perf-profile.self.cycles-pp.signalfd_copyinfo
      0.42 ±  3%      +0.1        0.51        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.46 ±  2%      +0.1        0.56        perf-profile.self.cycles-pp.__fget_light
      0.57            +0.1        0.67 ±  3%  perf-profile.self.cycles-pp.__x64_sys_getuid
      0.91 ±  2%      +0.1        1.01        perf-profile.self.cycles-pp.sigqueue
      0.22 ±  4%      +0.1        0.33 ±  4%  perf-profile.self.cycles-pp.collect_signal
      0.23 ±  2%      +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.map_id_up
      0.36 ±  3%      +0.1        0.47 ±  4%  perf-profile.self.cycles-pp.read
      0.22 ±  5%      +0.1        0.34 ±  6%  perf-profile.self.cycles-pp.__x64_sys_getpid
      0.73 ±  3%      +0.1        0.86 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.55 ±  2%      +0.1        0.68 ±  2%  perf-profile.self.cycles-pp._copy_from_user
      0.80 ±  2%      +0.1        0.94        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.62 ±  2%      +0.1        0.76 ±  3%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.52 ±  6%      +0.2        0.68 ±  9%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.66 ±  3%      +0.2        0.83 ±  3%  perf-profile.self.cycles-pp.__send_signal_locked
      0.53 ±  5%      +0.2        0.71        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.30            +0.2        0.51 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.2        0.24 ± 10%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.20 ±  3%      +0.3        0.46        perf-profile.self.cycles-pp.aa_file_perm
      0.79 ± 10%      +0.3        1.06 ±  9%  perf-profile.self.cycles-pp.profile_signal_perm
      0.62 ±  3%      +0.3        0.94 ±  2%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      1.36            +0.4        1.76        perf-profile.self.cycles-pp.inc_rlimit_get_ucounts
      0.37 ±  3%      +0.5        0.87 ±  4%  perf-profile.self.cycles-pp.__slab_free
      1.30 ±  2%      +0.7        1.99        perf-profile.self.cycles-pp.aa_may_signal
      1.53 ±  2%      +0.7        2.23        perf-profile.self.cycles-pp.apparmor_file_permission
      1.46            +0.7        2.18        perf-profile.self.cycles-pp.do_dec_rlimit_put_ucounts
      1.82            +0.9        2.75 ±  2%  perf-profile.self.cycles-pp.aa_get_task_label
      9.98            +1.1       11.08        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.43            +1.5        4.95        perf-profile.self.cycles-pp.apparmor_task_kill
      6.90            +2.0        8.92        perf-profile.self.cycles-pp.__entry_text_start
     13.14            +2.7       15.88        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
     16.78            +4.1       20.90        perf-profile.self.cycles-pp.syscall_return_via_sysret



***************************************************************************************************
lkp-cfl-d1: 12 threads 1 sockets Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz (Coffee Lake) with 16G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/option_b/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/Masskrug/CPU-only/debian-x86_64-phoronix/lkp-cfl-d1/darktable-1.0.5/phoronix-test-suite

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1213004           -17.6%     998925        turbostat.IRQ
      1.63            +1.9%       1.66        turbostat.RAMWatt
      7.02            -5.3%       6.64        phoronix-test-suite.darktable.Masskrug.CPU-only.seconds
    204076 ±  3%     -96.0%       8120        phoronix-test-suite.time.involuntary_context_switches
    207.98            -2.7%     202.35        phoronix-test-suite.time.user_time
      3569 ±  2%      +4.5%       3731        vmstat.io.bi
     27380           -29.3%      19366        vmstat.system.cs
     24655           -14.9%      20990        vmstat.system.in
     21.04 ± 38%     -12.1        8.98 ± 75%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      4.75 ±112%      -3.4        1.35 ±150%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
      4.15 ±105%      -1.1        3.04 ±184%  perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      4.75 ±112%      -3.4        1.35 ±150%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      4.15 ±105%      -1.1        3.04 ±184%  perf-profile.children.cycles-pp.wp_page_copy
      4.75 ±112%      -3.4        1.35 ±150%  perf-profile.self.cycles-pp.syscall_return_via_sysret
     91846 ± 40%    +155.2%     234436 ± 50%  sched_debug.cfs_rq:/.load.avg
    318475 ±114%    +211.4%     991708 ± 36%  sched_debug.cfs_rq:/.load.max
    222871 ±  8%     +19.9%     267301 ±  8%  sched_debug.cpu.avg_idle.stddev
      7765 ±  8%     +13.6%       8821 ± 10%  sched_debug.cpu.nr_switches.max
     56.67 ± 36%     +90.0%     107.67 ± 17%  sched_debug.cpu.nr_uninterruptible.max
     32.73 ± 45%     +88.4%      61.69 ± 20%  sched_debug.cpu.nr_uninterruptible.stddev
     27757           -30.1%      19398        perf-stat.i.context-switches
     53.71           -12.9%      46.77 ±  2%  perf-stat.i.cpu-migrations
      0.18 ±  3%      -0.0        0.17 ±  3%  perf-stat.i.dTLB-load-miss-rate%
      0.03            -0.0        0.03 ±  2%  perf-stat.i.dTLB-store-miss-rate%
     36.96            +3.5       40.45        perf-stat.i.iTLB-load-miss-rate%
    195744            -9.7%     176715        perf-stat.i.iTLB-load-misses
    497587 ±  2%      -9.7%     449446 ±  2%  perf-stat.i.iTLB-loads
    147371 ±  3%    +156.2%     377598 ±  5%  perf-stat.i.instructions-per-iTLB-miss
      0.68            +3.0%       0.70        perf-stat.i.ipc
      4.95            +0.1        5.01        perf-stat.overall.branch-miss-rate%
     52.27            +0.8       53.06        perf-stat.overall.cache-miss-rate%
      1.29            -3.1%       1.25        perf-stat.overall.cpi
    152.38            -3.6%     146.92        perf-stat.overall.cycles-between-cache-misses
      0.02            -0.0        0.02 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
     87114           +14.8%     100039 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.77            +3.2%       0.80        perf-stat.overall.ipc
 1.415e+08            +3.4%  1.463e+08        perf-stat.ps.cache-misses
     27167           -30.8%      18787        perf-stat.ps.context-switches
     52.57           -12.7%      45.87 ±  2%  perf-stat.ps.cpu-migrations
    191616           -10.4%     171736        perf-stat.ps.iTLB-load-misses
    487106 ±  2%     -10.8%     434393 ±  2%  perf-stat.ps.iTLB-loads
  16888296            +3.7%   17516532        perf-stat.ps.node-loads
  13019327 ±  2%      +4.1%   13557844 ±  2%  perf-stat.ps.node-stores



***************************************************************************************************
lkp-ivb-2ep1: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 112G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_threads/rootfs/tbox_group/test/test_memory_size/testcase:
  gcc-12/performance/x86_64-rhel-8.3/development/100%/debian-11.1-x86_64-20220510.cgz/lkp-ivb-2ep1/TCP/50%/lmbench3

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      6.53 ±  2%      -2.0        4.48        mpstat.cpu.all.soft%
      0.15 ±141%     -82.6%       0.03 ± 76%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
    742523 ±  2%     -65.0%     260147        vmstat.system.cs
  97884842 ±  2%     +15.3%  1.129e+08 ±  2%  numa-numastat.node0.local_node
  97897136 ±  2%     +15.3%  1.129e+08 ±  2%  numa-numastat.node0.numa_hit
      0.10           -15.0%       0.08 ±  5%  turbostat.IPC
     26.66           +12.1%      29.90        turbostat.RAMWatt
    510239 ±  3%     +11.7%     569754        meminfo.AnonHugePages
    645720           +11.3%     718985        meminfo.AnonPages
    650621           +12.0%     728941        meminfo.Inactive
    649977           +12.0%     728297        meminfo.Inactive(anon)
    231411 ± 13%     +28.8%     297976 ± 13%  numa-meminfo.node1.AnonHugePages
    298950 ± 16%     +24.8%     373214 ± 14%  numa-meminfo.node1.AnonPages
    304547 ± 16%     +24.3%     378608 ± 13%  numa-meminfo.node1.Inactive
    304010 ± 16%     +24.4%     378071 ± 13%  numa-meminfo.node1.Inactive(anon)
  97897001 ±  2%     +15.3%  1.129e+08 ±  2%  numa-vmstat.node0.numa_hit
  97884707 ±  2%     +15.3%  1.129e+08 ±  2%  numa-vmstat.node0.numa_local
     74802 ± 16%     +24.8%      93363 ± 14%  numa-vmstat.node1.nr_anon_pages
     76037 ± 16%     +24.4%      94578 ± 13%  numa-vmstat.node1.nr_inactive_anon
     76037 ± 16%     +24.4%      94578 ± 13%  numa-vmstat.node1.nr_zone_inactive_anon
    161396           +11.5%     179907        proc-vmstat.nr_anon_pages
    162463           +12.1%     182130        proc-vmstat.nr_inactive_anon
    162463           +12.1%     182130        proc-vmstat.nr_zone_inactive_anon
 1.715e+08 ±  2%      +9.0%  1.868e+08 ±  2%  proc-vmstat.numa_hit
 1.715e+08 ±  2%      +9.0%  1.868e+08 ±  2%  proc-vmstat.numa_local
 1.367e+09 ±  2%      +9.0%   1.49e+09 ±  2%  proc-vmstat.pgalloc_normal
   2337627            +3.7%    2423386        proc-vmstat.pgfault
 1.367e+09 ±  2%      +9.0%   1.49e+09 ±  2%  proc-vmstat.pgfree
     76598 ±  2%      +4.7%      80163        proc-vmstat.pgreuse
     25.32            +8.2%      27.39        lmbench3.TCP.localhost.latency
     31811           -29.7%      22377 ± 10%  lmbench3.TCP.socket.bandwidth.10MB.MB/sec
    958.62           +11.5%       1068        lmbench3.TCP.socket.bandwidth.64B.MB/sec
    662.76            +5.5%     699.02        lmbench3.time.elapsed_time
    662.76            +5.5%     699.02        lmbench3.time.elapsed_time.max
  27141817           -97.2%     751186 ±  5%  lmbench3.time.involuntary_context_switches
      1697           +12.3%       1905        lmbench3.time.percent_of_cpu_this_job_got
      8586 ±  2%     +22.4%      10512 ±  2%  lmbench3.time.system_time
      2663 ±  2%      +5.6%       2811 ±  3%  lmbench3.time.user_time
 2.177e+08 ±  2%     -59.4%   88495229        lmbench3.time.voluntary_context_switches
     66942 ± 26%    +533.5%     424063 ± 64%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.22 ±223%  +1.6e+07%      36129 ± 63%  sched_debug.cfs_rq:/.left_vruntime.avg
     10.55 ±223%  +1.6e+07%    1641139 ± 65%  sched_debug.cfs_rq:/.left_vruntime.max
      1.51 ±223%  +1.6e+07%     238933 ± 64%  sched_debug.cfs_rq:/.left_vruntime.stddev
     64627 ± 55%    +324.8%     274564 ± 45%  sched_debug.cfs_rq:/.load.max
     13943 ± 63%    +208.5%      43020 ± 42%  sched_debug.cfs_rq:/.load.stddev
     66942 ± 26%    +533.5%     424063 ± 64%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.22 ±223%  +1.6e+07%      36129 ± 63%  sched_debug.cfs_rq:/.right_vruntime.avg
     10.55 ±223%  +1.6e+07%    1641139 ± 65%  sched_debug.cfs_rq:/.right_vruntime.max
      1.51 ±223%  +1.6e+07%     238933 ± 64%  sched_debug.cfs_rq:/.right_vruntime.stddev
      5.99 ±  2%    +132.9%      13.94        perf-stat.i.MPKI
 7.894e+09           -14.1%  6.779e+09        perf-stat.i.branch-instructions
      2.29 ±  3%      -0.1        2.17        perf-stat.i.branch-miss-rate%
 1.519e+08           -16.6%  1.268e+08        perf-stat.i.branch-misses
      7.64 ±  3%      +3.9       11.50        perf-stat.i.cache-miss-rate%
  66250181 ±  2%     +45.0%   96066421        perf-stat.i.cache-misses
 6.213e+08           -13.5%  5.374e+08        perf-stat.i.cache-references
    745606 ±  2%     -63.5%     272354        perf-stat.i.context-switches
      4.03           +80.0%       7.26        perf-stat.i.cpi
    240.83 ± 25%     +79.5%     432.40 ± 29%  perf-stat.i.cpu-migrations
     65304 ±  8%     -15.8%      55003 ±  5%  perf-stat.i.cycles-between-cache-misses
 1.244e+10           -13.2%  1.079e+10        perf-stat.i.dTLB-loads
      0.42            -0.0        0.40        perf-stat.i.dTLB-store-miss-rate%
  45312253 ±  2%      -7.3%   42014497        perf-stat.i.dTLB-store-misses
  9.34e+09           -11.3%  8.282e+09        perf-stat.i.dTLB-stores
     95.38            -1.4       93.98        perf-stat.i.iTLB-load-miss-rate%
  39012477 ±  2%     -44.5%   21654013 ±  2%  perf-stat.i.iTLB-load-misses
 4.083e+10           -14.0%   3.51e+10        perf-stat.i.instructions
      2001 ±  3%     +76.1%       3524        perf-stat.i.instructions-per-iTLB-miss
      0.37           -12.0%       0.33        perf-stat.i.ipc
    482.59           +17.9%     568.77 ±  3%  perf-stat.i.metric.K/sec
    634.08           -12.7%     553.57        perf-stat.i.metric.M/sec
     37.86            -4.8       33.02        perf-stat.i.node-load-miss-rate%
   8319154        +1.4e+06%  1.199e+11 ±223%  perf-stat.i.node-load-misses
  76634824 ±  2%     +24.2%   95161297        perf-stat.i.node-loads
     27.91 ±  4%      -6.1       21.81 ±  3%  perf-stat.i.node-store-miss-rate%
   2370524 ±  3%     +79.6%    4256478 ± 11%  perf-stat.i.node-store-misses
  34212304 ±  3%     +65.5%   56621839        perf-stat.i.node-stores
      1.63 ±  2%     +63.3%       2.66 ±  2%  perf-stat.overall.MPKI
      1.92            -0.1        1.86        perf-stat.overall.branch-miss-rate%
     10.69            +7.2       17.87        perf-stat.overall.cache-miss-rate%
      2.85           +16.5%       3.33        perf-stat.overall.cpi
      1754           -28.6%       1251        perf-stat.overall.cycles-between-cache-misses
      0.48            +0.0        0.51        perf-stat.overall.dTLB-store-miss-rate%
      1046           +56.1%       1632        perf-stat.overall.instructions-per-iTLB-miss
      0.35           -14.2%       0.30        perf-stat.overall.ipc
      9.79           +15.8       25.61 ±129%  perf-stat.overall.node-load-miss-rate%
 7.894e+09           -12.7%  6.889e+09        perf-stat.ps.branch-instructions
 1.518e+08           -15.5%  1.283e+08        perf-stat.ps.branch-misses
  66453715 ±  2%     +42.6%   94782071        perf-stat.ps.cache-misses
 6.216e+08           -14.7%  5.302e+08        perf-stat.ps.cache-references
    743709 ±  2%     -65.0%     260297        perf-stat.ps.context-switches
    239.31 ± 25%     +80.4%     431.62 ± 27%  perf-stat.ps.cpu-migrations
 1.244e+10           -12.0%  1.094e+10        perf-stat.ps.dTLB-loads
  45329501 ±  2%      -5.2%   42978604        perf-stat.ps.dTLB-store-misses
 9.341e+09           -10.1%  8.397e+09        perf-stat.ps.dTLB-stores
  39030275           -44.0%   21854369 ±  2%  perf-stat.ps.iTLB-load-misses
 4.083e+10           -12.6%  3.567e+10        perf-stat.ps.instructions
   8343744        +1.5e+06%  1.253e+11 ±223%  perf-stat.ps.node-load-misses
  76921361 ±  2%     +22.1%   93936207        perf-stat.ps.node-loads
   2373023 ±  3%     +77.1%    4203412 ± 11%  perf-stat.ps.node-store-misses
  34320713 ±  3%     +62.8%   55873239        perf-stat.ps.node-stores
 2.712e+13            -7.9%  2.498e+13        perf-stat.total.instructions



***************************************************************************************************
lkp-cfl-d1: 12 threads 1 sockets Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz (Coffee Lake) with 16G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/option_b/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/Boat/CPU-only/debian-x86_64-phoronix/lkp-cfl-d1/darktable-1.0.5/phoronix-test-suite

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.03 ±  4%      +0.0        0.03 ±  2%  mpstat.cpu.all.soft%
   1813331           -22.3%    1409832        turbostat.IRQ
   8137165            +2.3%    8323779        proc-vmstat.pgalloc_normal
   8072998            +2.3%    8260434        proc-vmstat.pgfree
     20617           -50.7%      10174        vmstat.system.cs
     23085           -20.4%      18383        vmstat.system.in
     16.65            -3.5%      16.07        phoronix-test-suite.darktable.Boat.CPU-only.seconds
    414303 ±  2%     -95.0%      20719        phoronix-test-suite.time.involuntary_context_switches
    563.17            -1.8%     553.12        phoronix-test-suite.time.user_time
      1.08 ± 22%     +48.4%       1.60 ± 11%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.54 ± 27%     +64.0%       0.88 ± 28%  sched_debug.cfs_rq:/.h_nr_running.stddev
     87.44 ±148%  +17938.3%      15772 ± 82%  sched_debug.cfs_rq:/.left_vruntime.avg
    858.21 ±170%  +17391.2%     150111 ± 69%  sched_debug.cfs_rq:/.left_vruntime.max
    255.23 ±160%  +17609.7%      45201 ± 72%  sched_debug.cfs_rq:/.left_vruntime.stddev
    111255 ± 45%     +96.3%     218448 ± 21%  sched_debug.cfs_rq:/.load.avg
    441826 ± 80%    +155.0%    1126499 ± 36%  sched_debug.cfs_rq:/.load.max
    117920 ± 84%    +171.2%     319813 ± 34%  sched_debug.cfs_rq:/.load.stddev
    184.32 ± 14%     +44.3%     266.03 ± 15%  sched_debug.cfs_rq:/.load_avg.avg
      0.89 ± 17%     +25.0%       1.11 ±  3%  sched_debug.cfs_rq:/.nr_running.avg
      1.17 ± 20%     +71.4%       2.00 ± 20%  sched_debug.cfs_rq:/.nr_running.max
     87.44 ±148%  +17938.4%      15772 ± 82%  sched_debug.cfs_rq:/.right_vruntime.avg
    858.21 ±170%  +17391.3%     150112 ± 69%  sched_debug.cfs_rq:/.right_vruntime.max
    255.23 ±160%  +17609.8%      45201 ± 72%  sched_debug.cfs_rq:/.right_vruntime.stddev
      1070 ± 16%     +20.9%       1295        sched_debug.cfs_rq:/.runnable_avg.avg
      1660 ± 15%     +25.7%       2087 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
      1.04 ± 22%     +52.0%       1.58 ± 12%  sched_debug.cpu.nr_running.avg
      0.52 ± 32%     +69.6%       0.88 ± 27%  sched_debug.cpu.nr_running.stddev
     71162           -48.2%      36847        sched_debug.cpu.nr_switches.avg
     26317 ± 17%     -69.5%       8014 ± 22%  sched_debug.cpu.nr_switches.min
     21322           -50.1%      10644        perf-stat.i.context-switches
     52.41           -19.6%      42.12        perf-stat.i.cpu-migrations
     47285 ±  2%      -8.0%      43518 ±  2%  perf-stat.i.dTLB-store-misses
     36.71 ±  3%      +5.1       41.78 ±  4%  perf-stat.i.iTLB-load-miss-rate%
    130170 ±  3%     -16.5%     108627 ±  2%  perf-stat.i.iTLB-load-misses
    338792           -17.3%     280337 ±  2%  perf-stat.i.iTLB-loads
    337767 ±  6%     +75.2%     591790 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.64            +2.2%       0.65        perf-stat.i.ipc
      0.03 ± 29%     +65.5%       0.05 ±  6%  perf-stat.i.metric.G/sec
      5644 ±  2%      +3.2%       5823        perf-stat.i.minor-faults
      5649 ±  2%      +3.2%       5829        perf-stat.i.page-faults
     12.22            +1.4%      12.39        perf-stat.overall.MPKI
     44.88            +1.0       45.91        perf-stat.overall.cache-miss-rate%
      1.55            -2.2%       1.52        perf-stat.overall.cpi
    127.03            -3.6%     122.51        perf-stat.overall.cycles-between-cache-misses
      0.01 ±  2%      -0.0        0.01 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
    169606 ±  3%     +23.8%     209958 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.64            +2.2%       0.66        perf-stat.overall.ipc
  2.66e+08            +3.3%  2.747e+08        perf-stat.ps.cache-misses
     21044           -51.1%      10292        perf-stat.ps.context-switches
     51.73           -19.6%      41.58        perf-stat.ps.cpu-migrations
    263944 ±  2%      -3.8%     253811        perf-stat.ps.dTLB-load-misses
     46679 ±  2%      -8.7%      42611 ±  2%  perf-stat.ps.dTLB-store-misses
    128484 ±  3%     -17.7%     105690 ±  2%  perf-stat.ps.iTLB-load-misses
    334309           -18.9%     271276 ±  2%  perf-stat.ps.iTLB-loads
   5363609 ±  2%      +4.2%    5588414        perf-stat.ps.node-loads



***************************************************************************************************
lkp-skl-d08: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  interrupt/gcc-12/performance/1SSD/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/sigrt/stress-ng/60s

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.593e+08 ±  4%      -9.9%  1.436e+08 ±  5%  cpuidle..time
     60.99            -6.3%      57.13        iostat.cpu.system
     30.16           +15.2%      34.74        iostat.cpu.user
      1.01            -0.2        0.81 ±  2%  mpstat.cpu.all.irq%
     31.02            +4.8       35.79        mpstat.cpu.all.usr%
      1033 ± 27%     -66.5%     346.33 ± 11%  perf-c2c.DRAM.local
      1475 ± 12%    +301.4%       5921 ±  7%  perf-c2c.HITM.local
      1475 ± 12%    +301.4%       5921 ±  7%  perf-c2c.HITM.total
   6685023 ±  5%     -35.3%    4324007        vmstat.memory.cache
    180.50 ±  3%    +318.8%     756.00        vmstat.procs.r
   4928645           -89.5%     519621        vmstat.system.cs
     78059 ±  4%     -18.3%      63798        vmstat.system.in
 1.645e+08          +100.2%  3.294e+08        stress-ng.sigrt.ops
   2741487          +100.2%    5488391        stress-ng.sigrt.ops_per_sec
  1.04e+08           -99.7%     340761        stress-ng.time.involuntary_context_switches
      1424            -5.4%       1347        stress-ng.time.system_time
    672.86           +13.8%     765.82        stress-ng.time.user_time
  2.21e+08           -85.0%   33196290        stress-ng.time.voluntary_context_switches
    211047 ± 74%    +387.2%    1028244 ± 14%  meminfo.Active
    200486 ± 77%    +388.0%     978459 ± 10%  meminfo.Active(anon)
    410105           -12.8%     357737        meminfo.AnonPages
   6573265 ±  5%     -35.6%    4231363        meminfo.Cached
  15173178 ±  2%     -14.7%   12939277        meminfo.Committed_AS
   4071852 ±  7%     -77.9%     899527 ± 12%  meminfo.Inactive
   4067728 ±  7%     -78.1%     891282 ± 12%  meminfo.Inactive(anon)
    983422 ± 10%     -53.9%     453243 ± 10%  meminfo.Mapped
   7674294 ±  4%     -31.5%    5255062 ±  2%  meminfo.Memused
   3858501 ±  8%     -60.8%    1512401        meminfo.Shmem
   7714943 ±  4%     -30.4%    5370445 ±  2%  meminfo.max_used_kB
     30811 ± 32%    +104.9%      63143 ± 23%  turbostat.C1
      0.03 ± 24%      +0.0        0.06 ± 17%  turbostat.C1%
     53638 ±  6%     +27.1%      68152 ±  9%  turbostat.C1E
      0.18 ±  8%      +0.0        0.21 ±  6%  turbostat.C1E%
    149004 ±  5%     -10.8%     132981 ±  6%  turbostat.C6
      6.57 ±  4%      -0.7        5.86 ±  5%  turbostat.C6%
      6.58 ±  4%     -19.7%       5.28 ±  5%  turbostat.CPU%c1
      0.18 ±  4%    +346.8%       0.81 ± 11%  turbostat.CPU%c6
      0.10 ±  5%     -26.3%       0.07        turbostat.IPC
   5152367 ±  4%     -19.1%    4167291        turbostat.IRQ
      6243 ± 54%    +265.3%      22809 ± 48%  turbostat.POLL
     47.00 ±  2%      -9.2%      42.67        turbostat.PkgTmp
    187.20            -5.9%     176.24        turbostat.PkgWatt
      1.44 ±  6%     -25.6%       1.08        turbostat.RAMWatt
     50124 ± 77%    +389.5%     245381 ± 10%  proc-vmstat.nr_active_anon
    102535           -12.8%      89425        proc-vmstat.nr_anon_pages
    615018           +10.0%     676477        proc-vmstat.nr_dirty_background_threshold
   1231542           +10.0%    1354609        proc-vmstat.nr_dirty_threshold
   1646034 ±  5%     -35.0%    1070730 ±  2%  proc-vmstat.nr_file_pages
   6221811            +9.7%    6826456        proc-vmstat.nr_free_pages
   1017053 ±  8%     -78.1%     222524 ± 12%  proc-vmstat.nr_inactive_anon
    246027 ± 10%     -54.1%     113019 ± 10%  proc-vmstat.nr_mapped
    964741 ±  8%     -60.8%     378578        proc-vmstat.nr_shmem
     50124 ± 77%    +389.5%     245381 ± 10%  proc-vmstat.nr_zone_active_anon
   1017053 ±  8%     -78.1%     222524 ± 12%  proc-vmstat.nr_zone_inactive_anon
   1860386 ±  6%     -50.6%     918734 ±  3%  proc-vmstat.numa_hit
   1852974 ±  6%     -50.5%     917323 ±  2%  proc-vmstat.numa_local
     21127 ± 18%   +1738.1%     388340 ±  6%  proc-vmstat.pgactivate
   1895717 ±  6%     -49.5%     956438 ±  2%  proc-vmstat.pgalloc_normal
    352900            -4.5%     336903        proc-vmstat.pgfault
    434980           -11.9%     383073 ±  2%  proc-vmstat.pgfree
    960649           +11.4%    1070530        sched_debug.cfs_rq:/.avg_vruntime.avg
   1214116 ± 11%     +57.6%    1913835 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.max
     70132 ± 39%    +286.2%     270868 ± 18%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      2.47 ± 20%    +396.0%      12.23 ±  9%  sched_debug.cfs_rq:/.h_nr_running.avg
     16.25 ± 10%     +12.8%      18.33 ±  4%  sched_debug.cfs_rq:/.h_nr_running.max
      3.55 ± 19%     +52.5%       5.41 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
     10.52 ±160%  +53297.6%       5616 ±217%  sched_debug.cfs_rq:/.left_vruntime.avg
    271.36 ±146%  +73728.8%     200341 ±219%  sched_debug.cfs_rq:/.left_vruntime.max
     49.42 ±149%  +66598.7%      32963 ±219%  sched_debug.cfs_rq:/.left_vruntime.stddev
     37985 ± 40%    +101.8%      76655 ± 29%  sched_debug.cfs_rq:/.load.avg
     78644 ± 83%    +149.6%     196333 ± 27%  sched_debug.cfs_rq:/.load.stddev
    960649           +11.4%    1070532        sched_debug.cfs_rq:/.min_vruntime.avg
   1214116 ± 11%     +57.6%    1913835 ± 11%  sched_debug.cfs_rq:/.min_vruntime.max
     70132 ± 39%    +286.2%     270869 ± 18%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.26 ± 13%     +31.8%       0.35 ± 15%  sched_debug.cfs_rq:/.nr_running.stddev
     10.52 ±160%  +53293.0%       5616 ±217%  sched_debug.cfs_rq:/.right_vruntime.avg
    271.39 ±146%  +73719.9%     200341 ±219%  sched_debug.cfs_rq:/.right_vruntime.max
     49.43 ±149%  +66592.6%      32963 ±219%  sched_debug.cfs_rq:/.right_vruntime.stddev
      3170 ±  2%    +286.2%      12242 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
      5697 ±  9%    +160.0%      14816 ±  5%  sched_debug.cfs_rq:/.runnable_avg.max
    806.39 ± 11%    +218.5%       2568 ± 17%  sched_debug.cfs_rq:/.runnable_avg.stddev
    211.14 ±  6%     +63.8%     345.75 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    332013 ±  9%     -17.5%     273981 ±  6%  sched_debug.cpu.avg_idle.avg
     27647 ± 17%     -29.3%      19559 ± 11%  sched_debug.cpu.avg_idle.min
    211303 ± 10%     -11.5%     186985 ±  4%  sched_debug.cpu.avg_idle.stddev
      2.39 ± 22%    +410.0%      12.21 ±  9%  sched_debug.cpu.nr_running.avg
      3.47 ± 20%     +56.1%       5.41 ±  7%  sched_debug.cpu.nr_running.stddev
   4282626           -89.5%     451524        sched_debug.cpu.nr_switches.avg
   4490688           -82.0%     808072 ± 15%  sched_debug.cpu.nr_switches.max
   3803398 ±  4%     -90.9%     345054 ±  3%  sched_debug.cpu.nr_switches.min
    157828 ± 24%     -32.9%     105929 ± 23%  sched_debug.cpu.nr_switches.stddev
      0.89 ±  8%     -60.1%       0.35 ±  3%  perf-stat.i.MPKI
 8.358e+09           -34.7%  5.458e+09        perf-stat.i.branch-instructions
      1.79            -0.1        1.65        perf-stat.i.branch-miss-rate%
 1.398e+08           -38.6%   85770592        perf-stat.i.branch-misses
      9.88 ±  5%      -4.5        5.42 ±  2%  perf-stat.i.cache-miss-rate%
  38787613 ±  6%     -72.6%   10639896 ±  3%  perf-stat.i.cache-misses
 4.288e+08 ±  5%     -46.2%  2.307e+08        perf-stat.i.cache-references
   5186746           -89.6%     540527        perf-stat.i.context-switches
      3.07           +42.2%       4.36        perf-stat.i.cpi
      4563 ±  3%     +99.9%       9123 ±  3%  perf-stat.i.cpu-migrations
      3504 ±  8%    +313.6%      14493 ±  4%  perf-stat.i.cycles-between-cache-misses
      1.61 ±  3%      -1.0        0.61        perf-stat.i.dTLB-load-miss-rate%
 1.899e+08 ±  2%     -73.2%   50962287        perf-stat.i.dTLB-load-misses
 1.162e+10           -30.6%  8.059e+09        perf-stat.i.dTLB-loads
      0.44 ±  2%      -0.4        0.09        perf-stat.i.dTLB-store-miss-rate%
  30729438 ±  2%     -85.7%    4393879        perf-stat.i.dTLB-store-misses
 6.881e+09           -27.9%  4.962e+09        perf-stat.i.dTLB-stores
     57.28           +24.1       81.41        perf-stat.i.iTLB-load-miss-rate%
  59373888           -45.8%   32152758 ±  3%  perf-stat.i.iTLB-load-misses
  42335180           -85.1%    6310611 ± 15%  perf-stat.i.iTLB-loads
 4.308e+10           -31.5%  2.949e+10        perf-stat.i.instructions
      0.36           -27.2%       0.26        perf-stat.i.ipc
      1429 ±  2%     -67.8%     459.72 ±  5%  perf-stat.i.metric.K/sec
    759.02           -31.6%     519.50        perf-stat.i.metric.M/sec
      4130 ±  2%      -3.1%       4002        perf-stat.i.minor-faults
   9282786 ±  7%     -67.7%    2997133 ±  5%  perf-stat.i.node-loads
   3643109 ±  5%     -56.4%    1587011 ±  4%  perf-stat.i.node-stores
      4130 ±  2%      -3.1%       4002        perf-stat.i.page-faults
      0.90 ±  7%     -60.0%       0.36 ±  3%  perf-stat.overall.MPKI
      1.67            -0.1        1.57        perf-stat.overall.branch-miss-rate%
      9.06 ±  6%      -4.4        4.61 ±  3%  perf-stat.overall.cache-miss-rate%
      3.02           +46.4%       4.42        perf-stat.overall.cpi
      3366 ±  7%    +264.1%      12258 ±  3%  perf-stat.overall.cycles-between-cache-misses
      1.61 ±  3%      -1.0        0.63        perf-stat.overall.dTLB-load-miss-rate%
      0.44 ±  2%      -0.4        0.09        perf-stat.overall.dTLB-store-miss-rate%
     58.38           +25.3       83.66 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
    725.64           +26.4%     917.19 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.33           -31.7%       0.23        perf-stat.overall.ipc
 8.228e+09           -34.7%  5.374e+09        perf-stat.ps.branch-instructions
 1.376e+08           -38.6%   84440936        perf-stat.ps.branch-misses
  38188699 ±  6%     -72.6%   10471539 ±  3%  perf-stat.ps.cache-misses
 4.222e+08 ±  5%     -46.2%  2.273e+08        perf-stat.ps.cache-references
   5105776           -89.6%     533193        perf-stat.ps.context-switches
      4492 ±  3%    +100.6%       9010 ±  3%  perf-stat.ps.cpu-migrations
 1.869e+08 ±  2%     -73.1%   50231984        perf-stat.ps.dTLB-load-misses
 1.144e+10           -30.6%  7.936e+09        perf-stat.ps.dTLB-loads
  30250301 ±  2%     -85.7%    4332582        perf-stat.ps.dTLB-store-misses
 6.775e+09           -27.9%  4.887e+09        perf-stat.ps.dTLB-stores
  58447403           -45.8%   31692746 ±  3%  perf-stat.ps.iTLB-load-misses
  41674419           -85.1%    6222297 ± 15%  perf-stat.ps.iTLB-loads
 4.241e+10           -31.5%  2.903e+10        perf-stat.ps.instructions
      4064            -4.3%       3887        perf-stat.ps.minor-faults
   9139873 ±  7%     -67.7%    2950054 ±  6%  perf-stat.ps.node-loads
   3587370 ±  5%     -56.6%    1558351 ±  4%  perf-stat.ps.node-stores
      4064            -4.3%       3887        perf-stat.ps.page-faults
   2.7e+12           -32.2%  1.832e+12        perf-stat.total.instructions
      0.01 ± 99%    +333.3%       0.03 ± 41%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.05 ± 70%   +3735.4%       1.84 ± 24%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.22 ±115%    +650.0%       1.67 ± 59%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.04 ± 49%    +400.0%       0.18 ± 75%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.13 ±134%    +245.4%       0.46 ± 40%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.64 ±128%    +307.5%       6.68 ± 40%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.11 ± 45%   +1580.9%       1.77 ±  2%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_sigtimedwait.__x64_sys_rt_sigtimedwait.do_syscall_64
      0.04 ±146%   +1699.2%       0.72 ± 36%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 45%   +6406.5%       0.50 ± 43%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 44%    +882.5%       0.07 ± 19%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 72%   +2646.4%       0.95 ± 44%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.74 ± 96%    +307.8%       3.02 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.46 ± 91%   +1392.9%       6.84 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      2.94 ±104%    +175.9%       8.10 ± 30%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.22 ±183%   +1048.2%       2.57 ± 26%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 49%  +20581.0%       2.00 ± 40%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.05 ± 62%   +6009.1%       2.81 ± 13%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.16 ± 69%   +4356.0%       7.20 ± 49%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.07 ± 45%   +2214.0%       1.73 ±  2%  perf-sched.total_sch_delay.average.ms
      0.76 ± 45%    +486.9%       4.44 ±  2%  perf-sched.total_wait_and_delay.average.ms
      0.68 ± 45%    +297.3%       2.71 ±  2%  perf-sched.total_wait_time.average.ms
      0.33 ±223%   +1914.3%       6.71 ± 14%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.34 ±223%   +1970.3%       6.96 ± 23%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.23 ±223%   +3657.4%       8.68 ± 27%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      0.16 ±223%   +1722.4%       2.98        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.08 ± 45%   +3795.1%       2.94        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    263.78 ± 47%    +108.5%     550.09 ±  6%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.00 ± 45%    +329.1%       4.31 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_sigtimedwait.__x64_sys_rt_sigtimedwait.do_syscall_64
    123.67 ± 47%     +74.8%     216.17        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      5.00 ± 74%    +100.0%      10.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     31.00 ± 45%    +106.5%      64.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    910.33 ±223%   +1198.2%      11818        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
     10.00 ± 49%    +110.0%      21.00 ± 19%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     11.17 ± 47%    +164.2%      29.50 ± 23%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      6.83 ± 46%     +78.0%      12.17 ±  5%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      4.50 ± 52%    +118.5%       9.83 ±  3%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
     39.17 ± 56%    +160.9%     102.17 ± 10%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    209.50 ± 46%     +53.5%     321.50 ±  5%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    121.67 ± 49%     +77.9%     216.50        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     13.51 ±223%    +406.9%      68.50 ± 58%  perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.67 ± 98%    +908.4%       6.71 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.03 ± 89%  +17207.2%       5.97 ± 39%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      0.64 ±101%    +991.7%       6.96 ± 23%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.58 ±215%    +686.2%       4.56 ± 28%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
      0.03 ± 83%  +14149.8%       4.87 ± 29%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.48 ± 90%   +1710.8%       8.68 ± 27%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      0.08 ±157%   +6874.1%       5.35 ± 24%  perf-sched.wait_time.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.12 ± 50%    +263.8%       0.44 ± 56%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    137.90 ± 47%     +81.8%     250.73        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.69 ± 50%    +212.7%       2.16 ± 12%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.58 ± 52%    +414.5%       2.98        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1.76 ± 55%    +198.4%       5.27 ± 40%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.07 ± 45%   +3925.6%       2.93        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    237.09 ± 47%    +131.8%     549.68 ±  6%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.90 ± 45%    +182.3%       2.54        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_sigtimedwait.__x64_sys_rt_sigtimedwait.do_syscall_64
      0.09 ± 56%  +13828.3%      13.21 ± 40%  perf-sched.wait_time.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      1.56 ±170%    +658.1%      11.85 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
      1.82 ±202%    +661.3%      13.89 ± 29%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      1.74 ±208%    +584.0%      11.88 ± 14%  perf-sched.wait_time.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
    285.21 ±115%    +251.8%       1003        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     17.87           -14.5        3.35 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigtimedwait.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigtimedwait
     33.49           -13.3       20.16        perf-profile.calltrace.cycles-pp.__sigtimedwait
     15.99           -13.0        3.04 ±  3%  perf-profile.calltrace.cycles-pp.do_sigtimedwait.__x64_sys_rt_sigtimedwait.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigtimedwait
     12.85           -10.6        2.26 ±  3%  perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range_clock.do_sigtimedwait.__x64_sys_rt_sigtimedwait.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.48           -10.3        2.20 ±  3%  perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range_clock.do_sigtimedwait.__x64_sys_rt_sigtimedwait.do_syscall_64
     12.13           -10.0        2.14 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_hrtimeout_range_clock.do_sigtimedwait.__x64_sys_rt_sigtimedwait
      9.86            -7.9        1.92 ±  4%  perf-profile.calltrace.cycles-pp.complete_signal.__send_signal_locked.do_send_sig_info.kill_pid_info.do_rt_sigqueueinfo
      9.40            -7.9        1.55 ±  5%  perf-profile.calltrace.cycles-pp.try_to_wake_up.complete_signal.__send_signal_locked.do_send_sig_info.kill_pid_info
     26.46            -7.4       19.10        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sigtimedwait
     13.01            -6.3        6.68        perf-profile.calltrace.cycles-pp.__send_signal_locked.do_send_sig_info.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo
     13.84            -6.2        7.59        perf-profile.calltrace.cycles-pp.do_send_sig_info.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo.do_syscall_64
     28.54            -6.0       22.52        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sigqueue
     24.67            -5.8       18.86        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigtimedwait
     30.44            -5.6       24.80        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sigqueue
     37.34            -5.3       32.06        perf-profile.calltrace.cycles-pp.sigqueue
      5.89            -5.0        0.88 ±  4%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.complete_signal.__send_signal_locked.do_send_sig_info
      4.89            -4.1        0.81 ±  4%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.complete_signal.__send_signal_locked
      4.76            -4.0        0.78 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.complete_signal
      4.25            -3.6        0.64 ±  4%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_hrtimeout_range_clock.do_sigtimedwait
      7.00            -3.5        3.54        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sigqueue
     19.94            -2.8       17.18        perf-profile.calltrace.cycles-pp.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo.do_syscall_64.entry_SYSCALL_64_after_hwframe.sigqueue
     19.02            -2.6       16.39        perf-profile.calltrace.cycles-pp.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.15            -2.6       18.54        perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigqueueinfo.do_syscall_64.entry_SYSCALL_64_after_hwframe.sigqueue
      2.19            -1.6        0.60 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_signal.do_sigtimedwait.__x64_sys_rt_sigtimedwait.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.14 ± 30%      -0.8        0.37 ±100%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      1.10 ± 29%      -0.8        0.34 ±100%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
      1.09 ± 29%      -0.8        0.34 ±100%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
      1.94 ±  5%      -0.4        1.52 ±  2%  perf-profile.calltrace.cycles-pp.stress_sigrt
      0.66            -0.3        0.37 ± 71%  perf-profile.calltrace.cycles-pp.__radix_tree_lookup.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.82 ±  2%      -0.2        0.64        perf-profile.calltrace.cycles-pp.__x64_sys_getuid.do_syscall_64.entry_SYSCALL_64_after_hwframe.getuid
      0.75 ±  3%      -0.1        0.66 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_getpid.do_syscall_64.entry_SYSCALL_64_after_hwframe.__getpid
      0.64 ±  5%      -0.1        0.57 ±  4%  perf-profile.calltrace.cycles-pp.__task_pid_nr_ns.__x64_sys_getpid.do_syscall_64.entry_SYSCALL_64_after_hwframe.__getpid
      1.25 ±  2%      +0.2        1.41        perf-profile.calltrace.cycles-pp.__entry_text_start.sigqueue
      0.44 ± 44%      +0.2        0.64 ±  2%  perf-profile.calltrace.cycles-pp._copy_from_user.__x64_sys_rt_sigqueueinfo.do_syscall_64.entry_SYSCALL_64_after_hwframe.sigqueue
      1.14 ±  2%      +0.3        1.46        perf-profile.calltrace.cycles-pp.__entry_text_start.getuid
      1.13            +0.3        1.48        perf-profile.calltrace.cycles-pp.__entry_text_start.__getpid
      0.66 ±  2%      +0.4        1.08        perf-profile.calltrace.cycles-pp.profile_signal_perm.aa_may_signal.apparmor_task_kill.security_task_kill.kill_pid_info
      1.02            +0.4        1.45        perf-profile.calltrace.cycles-pp.inc_rlimit_get_ucounts.__sigqueue_alloc.__send_signal_locked.do_send_sig_info.kill_pid_info
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp._copy_from_user.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.signal_setup_done.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.__get_user_nocheck_8.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.58 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.sigqueue
      0.00            +0.6        0.59 ±  2%  perf-profile.calltrace.cycles-pp.check_xstate_in_sigframe.__fpu_restore_sig.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn
      0.00            +0.6        0.62 ±  3%  perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc.__sigqueue_alloc.__send_signal_locked.do_send_sig_info
      3.76            +0.6        4.40        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getuid
      0.00            +0.7        0.70 ±  6%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc.__sigqueue_alloc.__send_signal_locked.do_send_sig_info
      0.00            +0.7        0.72        perf-profile.calltrace.cycles-pp.restore_altstack.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigtimedwait
      2.67            +0.7        3.40        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.getuid
      3.63            +0.8        4.38        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__getpid
      2.62            +0.8        3.38        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__getpid
      3.23            +0.8        4.03        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.getuid
      1.26 ±  5%      +0.9        2.12        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.__sigqueue_alloc.__send_signal_locked.do_send_sig_info.kill_pid_info
      0.00            +0.9        0.87        perf-profile.calltrace.cycles-pp.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.26            +0.9        4.18        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.sigqueue
      3.27            +0.9        4.21        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__getpid
      1.18 ±  5%      +1.0        2.18        perf-profile.calltrace.cycles-pp.aa_get_task_label.apparmor_task_kill.security_task_kill.kill_pid_info.do_rt_sigqueueinfo
      0.00            +1.0        1.04        perf-profile.calltrace.cycles-pp.__entry_text_start.stress_sighandler_nop
      0.17 ±141%      +1.1        1.23 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__getpid
      0.00            +1.1        1.06        perf-profile.calltrace.cycles-pp.save_xstate_epilog.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart
      0.00            +1.1        1.11        perf-profile.calltrace.cycles-pp.fpu__clear_user_states.handle_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
      5.56            +1.2        6.72        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getuid
      0.00            +1.2        1.17 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.dequeue_signal.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      0.00            +1.2        1.18 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.getuid
      0.00            +1.2        1.23        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.stress_sighandler_nop
      5.44            +1.3        6.72        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__getpid
      1.39 ±  4%      +1.3        2.68        perf-profile.calltrace.cycles-pp.aa_may_signal.apparmor_task_kill.security_task_kill.kill_pid_info.do_rt_sigqueueinfo
      2.37 ±  2%      +1.3        3.69        perf-profile.calltrace.cycles-pp.__sigqueue_alloc.__send_signal_locked.do_send_sig_info.kill_pid_info.do_rt_sigqueueinfo
      0.00            +1.5        1.47        perf-profile.calltrace.cycles-pp.__slab_free.dequeue_signal.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      0.00            +1.5        1.53        perf-profile.calltrace.cycles-pp.do_dec_rlimit_put_ucounts.collect_signal.dequeue_signal.get_signal.arch_do_signal_or_restart
      0.00            +1.5        1.55 ±  2%  perf-profile.calltrace.cycles-pp.restore_fpregs_from_user.__fpu_restore_sig.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn
      0.18 ±141%      +1.7        1.89        perf-profile.calltrace.cycles-pp.copy_fpstate_to_sigframe.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart
      0.00            +2.2        2.23        perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.3        2.35        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sighandler_nop
      0.00            +2.5        2.48        perf-profile.calltrace.cycles-pp.collect_signal.dequeue_signal.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      0.00            +2.5        2.49        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.67            +2.5       13.20        perf-profile.calltrace.cycles-pp.getuid
      0.79 ±  5%      +2.6        3.36        perf-profile.calltrace.cycles-pp.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      0.00            +2.7        2.66        perf-profile.calltrace.cycles-pp.__fpu_restore_sig.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64
      0.17 ±141%      +2.7        2.89        perf-profile.calltrace.cycles-pp.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigtimedwait
     10.69            +2.7       13.42        perf-profile.calltrace.cycles-pp.__getpid
      0.00            +2.8        2.75        perf-profile.calltrace.cycles-pp.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.63 ±  2%      +3.1        3.74        perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigtimedwait
      0.91 ±  4%      +3.1        4.05        perf-profile.calltrace.cycles-pp.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
      0.64 ±  3%      +3.1        3.78        perf-profile.calltrace.cycles-pp.__irqentry_text_end.stress_sighandler_nop
      4.46 ±  4%      +3.7        8.16        perf-profile.calltrace.cycles-pp.apparmor_task_kill.security_task_kill.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo
      4.51 ±  4%      +3.7        8.23        perf-profile.calltrace.cycles-pp.security_task_kill.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo.do_syscall_64
      0.78 ±  3%      +3.9        4.64        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.86 ±  3%      +4.5        5.33        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sighandler_nop
      0.93 ±  5%      +4.6        5.49        perf-profile.calltrace.cycles-pp.handle_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.87 ±  3%      +4.6        5.46        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sighandler_nop
      0.89 ±  3%      +4.6        5.51        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.stress_sighandler_nop
      0.67 ±  3%      +5.1        5.76        perf-profile.calltrace.cycles-pp.dequeue_signal.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
      0.82 ±  3%      +5.7        6.56        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      5.83            +5.8       11.68        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigtimedwait
      3.63            +7.7       11.30        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigtimedwait
      5.52            +7.8       13.36        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.80 ±  3%     +11.4       13.21        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.10 ±  3%     +11.9       13.96        perf-profile.calltrace.cycles-pp.stress_sighandler_nop
     17.91           -14.6        3.35 ±  3%  perf-profile.children.cycles-pp.__x64_sys_rt_sigtimedwait
     16.11           -13.9        2.24 ±  3%  perf-profile.children.cycles-pp.schedule
     15.72           -13.5        2.20 ±  4%  perf-profile.children.cycles-pp.__schedule
     33.63           -13.4       20.18        perf-profile.children.cycles-pp.__sigtimedwait
     16.02           -13.0        3.04 ±  3%  perf-profile.children.cycles-pp.do_sigtimedwait
     12.86           -10.6        2.26 ±  3%  perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
      9.88            -7.9        1.93 ±  4%  perf-profile.children.cycles-pp.complete_signal
      9.46            -7.9        1.56 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
     13.03            -6.3        6.71        perf-profile.children.cycles-pp.__send_signal_locked
     13.87            -6.3        7.61        perf-profile.children.cycles-pp.do_send_sig_info
     37.52            -5.2       32.28        perf-profile.children.cycles-pp.sigqueue
      5.92            -5.0        0.89 ±  4%  perf-profile.children.cycles-pp.ttwu_do_activate
      4.91            -4.1        0.82 ±  4%  perf-profile.children.cycles-pp.activate_task
      4.79            -4.0        0.80 ±  4%  perf-profile.children.cycles-pp.enqueue_task_fair
     62.14            -3.8       58.30        perf-profile.children.cycles-pp.do_syscall_64
      4.28            -3.6        0.66 ±  4%  perf-profile.children.cycles-pp.dequeue_task_fair
      3.32            -2.9        0.42 ±  4%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      3.36            -2.9        0.48 ±  5%  perf-profile.children.cycles-pp.pick_next_task_fair
     19.95            -2.8       17.20        perf-profile.children.cycles-pp.do_rt_sigqueueinfo
     19.04            -2.6       16.41        perf-profile.children.cycles-pp.kill_pid_info
     21.22            -2.6       18.61        perf-profile.children.cycles-pp.__x64_sys_rt_sigqueueinfo
      2.64            -2.3        0.36 ±  5%  perf-profile.children.cycles-pp.update_curr
      2.56 ±  2%      -2.2        0.40 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      2.22 ±  3%      -2.1        0.10 ±  5%  perf-profile.children.cycles-pp.switch_fpu_return
     69.84            -2.1       67.75        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.51            -2.0        0.49 ±  6%  perf-profile.children.cycles-pp.enqueue_entity
      2.08            -1.8        0.31 ±  5%  perf-profile.children.cycles-pp.dequeue_entity
      1.90 ±  2%      -1.7        0.22 ±  5%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      1.64 ±  3%      -1.4        0.24 ±  4%  perf-profile.children.cycles-pp.reweight_entity
      1.20 ±  2%      -1.1        0.14 ±  7%  perf-profile.children.cycles-pp.prepare_task_switch
      1.20 ±  3%      -1.0        0.15 ±  8%  perf-profile.children.cycles-pp.__switch_to_asm
      1.24 ±  2%      -1.0        0.23 ±  5%  perf-profile.children.cycles-pp.set_next_entity
      1.18 ±  2%      -0.9        0.24 ± 18%  perf-profile.children.cycles-pp.select_task_rq
      1.04 ±  7%      -0.9        0.18 ±  4%  perf-profile.children.cycles-pp.copy_siginfo_to_user
      0.98 ±  3%      -0.8        0.14 ± 19%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.93 ±  2%      -0.8        0.12 ±  7%  perf-profile.children.cycles-pp.pick_eevdf
      0.86 ±  2%      -0.8        0.05 ± 45%  perf-profile.children.cycles-pp.check_preempt_curr
      0.89 ±  3%      -0.8        0.10 ± 10%  perf-profile.children.cycles-pp.___perf_sw_event
      0.89 ±  3%      -0.7        0.20 ± 20%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.81 ±  2%      -0.7        0.15 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.79 ± 10%      -0.6        0.14 ±  5%  perf-profile.children.cycles-pp._copy_to_user
      0.75 ±  4%      -0.6        0.12 ±  7%  perf-profile.children.cycles-pp.update_cfs_group
      0.74 ±  4%      -0.6        0.12 ±  6%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      1.10 ± 29%      -0.6        0.50 ± 35%  perf-profile.children.cycles-pp.queue_event
      1.10 ± 29%      -0.6        0.52 ± 35%  perf-profile.children.cycles-pp.ordered_events__queue
      1.14 ± 30%      -0.6        0.56 ± 33%  perf-profile.children.cycles-pp.process_simple
      0.62 ±  3%      -0.6        0.07 ±  5%  perf-profile.children.cycles-pp.__switch_to
      0.62 ±  3%      -0.5        0.08        perf-profile.children.cycles-pp.os_xsave
      0.61 ±  4%      -0.5        0.09 ± 18%  perf-profile.children.cycles-pp.perf_tp_event
      0.52 ±  2%      -0.4        0.09 ±  8%  perf-profile.children.cycles-pp.place_entity
      1.98 ±  5%      -0.4        1.57 ±  2%  perf-profile.children.cycles-pp.stress_sigrt
      0.48 ±  2%      -0.4        0.08 ±  6%  perf-profile.children.cycles-pp.avg_vruntime
      0.46 ±  3%      -0.4        0.08 ± 11%  perf-profile.children.cycles-pp.update_rq_clock
      0.49 ±  5%      -0.4        0.12 ±  3%  perf-profile.children.cycles-pp.__dequeue_entity
      0.38 ±  6%      -0.4        0.02 ± 99%  perf-profile.children.cycles-pp.cr4_update_irqsoff
      0.39 ±  2%      -0.3        0.06 ±  7%  perf-profile.children.cycles-pp.__calc_delta
      0.34 ±  4%      -0.3        0.03 ± 70%  perf-profile.children.cycles-pp.update_min_vruntime
      0.34 ±  3%      -0.3        0.06 ± 14%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.42 ± 20%      -0.3        0.16 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock
      0.29 ± 25%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.56 ±  3%      -0.3        0.30 ±  5%  perf-profile.children.cycles-pp.__libc_current_sigrtmin_private
      0.31 ±  4%      -0.3        0.05 ± 46%  perf-profile.children.cycles-pp.sched_clock
      0.35 ±  7%      -0.2        0.10 ± 38%  perf-profile.children.cycles-pp.select_idle_sibling
      0.28 ±  3%      -0.2        0.04 ± 45%  perf-profile.children.cycles-pp.native_sched_clock
      0.34 ± 10%      -0.2        0.13 ±  8%  perf-profile.children.cycles-pp.__enqueue_entity
      0.26 ±  6%      -0.2        0.06 ±  9%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.28 ±  4%      -0.2        0.11 ±  6%  perf-profile.children.cycles-pp.__libc_current_sigrtmin@plt
      0.84 ±  2%      -0.2        0.67        perf-profile.children.cycles-pp.__x64_sys_getuid
      0.47 ±  5%      -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.54 ±  4%      -0.1        0.41 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.67            -0.1        0.54 ±  8%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.44 ±  5%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.43 ±  5%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.44 ± 13%      -0.1        0.32 ±  4%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.32 ± 19%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.38 ±  5%      -0.1        0.26 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.29 ±  5%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.30 ±  5%      -0.1        0.22 ±  5%  perf-profile.children.cycles-pp.tick_sched_timer
      0.28 ±  4%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.36 ±  6%      -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.audit_signal_info_syscall
      0.18 ±  5%      -0.1        0.10 ±  6%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.18 ±  5%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.24 ±  4%      -0.1        0.17 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
      0.77 ±  3%      -0.1        0.71 ±  3%  perf-profile.children.cycles-pp.__x64_sys_getpid
      0.45 ±  6%      -0.1        0.39        perf-profile.children.cycles-pp.check_kill_permission
      0.20 ±  2%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.14 ±  7%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.pid_task
      0.07 ± 24%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.10 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.10 ±  4%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.find_vpid
      0.62 ±  2%      +0.0        0.66        perf-profile.children.cycles-pp.recalc_sigpending
      0.08            +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.__set_task_blocked
      0.14 ±  5%      +0.1        0.20        perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.31 ±  5%      +0.1        0.37 ±  2%  perf-profile.children.cycles-pp.send_signal_locked
      0.16 ±  4%      +0.1        0.26 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      0.12 ±  5%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.map_id_up
      0.15 ±  4%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.from_kuid_munged
      0.00            +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.fpu__alloc_mathframe
      0.54 ±  7%      +0.1        0.65        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.36 ±  7%      +0.1        0.48 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.19 ±  4%      +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.47            +0.2        0.62 ±  3%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.60 ±  6%      +0.2        0.83 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.2        0.24 ±  3%  perf-profile.children.cycles-pp.do_sigaltstack
      0.06 ±  8%      +0.3        0.31 ±  2%  perf-profile.children.cycles-pp.fpregs_mark_activate
      0.00            +0.3        0.32 ±  5%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.07 ±  5%      +0.3        0.40        perf-profile.children.cycles-pp.set_current_blocked
     12.57            +0.3       12.92        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.08 ±  5%      +0.4        0.45 ±  2%  perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.07 ± 10%      +0.4        0.47 ±  2%  perf-profile.children.cycles-pp.__set_current_blocked
      0.09 ± 10%      +0.4        0.50 ±  2%  perf-profile.children.cycles-pp.__get_user_nocheck_4
      0.00            +0.4        0.41 ±  7%  perf-profile.children.cycles-pp.get_partial_node
      0.07 ±123%      +0.4        0.50 ±  7%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.66 ±  3%      +0.4        1.09        perf-profile.children.cycles-pp.profile_signal_perm
      1.02            +0.4        1.45        perf-profile.children.cycles-pp.inc_rlimit_get_ucounts
      0.09 ±  6%      +0.5        0.55        perf-profile.children.cycles-pp.signal_setup_done
      0.12 ±  6%      +0.5        0.63 ±  2%  perf-profile.children.cycles-pp.check_xstate_in_sigframe
      0.82 ±  3%      +0.5        1.35        perf-profile.children.cycles-pp.kmem_cache_free
      0.10 ±  3%      +0.6        0.67        perf-profile.children.cycles-pp.__get_user_nocheck_8
      1.16 ±  2%      +0.6        1.75        perf-profile.children.cycles-pp.do_dec_rlimit_put_ucounts
      1.08 ±  2%      +0.6        1.71        perf-profile.children.cycles-pp._copy_from_user
      0.05 ±  7%      +0.7        0.70 ±  5%  perf-profile.children.cycles-pp.___slab_alloc
      0.13 ±  3%      +0.7        0.79        perf-profile.children.cycles-pp.restore_altstack
      1.91 ±  3%      +0.8        2.66        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.28 ±  5%      +0.9        2.14        perf-profile.children.cycles-pp.kmem_cache_alloc
      0.22 ±  6%      +0.9        1.13        perf-profile.children.cycles-pp.save_xstate_epilog
      0.18 ±  4%      +0.9        1.12        perf-profile.children.cycles-pp.fpu__clear_user_states
      1.18 ±  4%      +1.0        2.19        perf-profile.children.cycles-pp.aa_get_task_label
      0.28 ±  4%      +1.2        1.46 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      1.40 ±  4%      +1.3        2.69        perf-profile.children.cycles-pp.aa_may_signal
      0.27 ±  2%      +1.3        1.59        perf-profile.children.cycles-pp.restore_fpregs_from_user
      2.37 ±  2%      +1.3        3.70        perf-profile.children.cycles-pp.__sigqueue_alloc
      6.31            +1.4        7.69        perf-profile.children.cycles-pp.__entry_text_start
      0.15 ± 14%      +1.4        1.57        perf-profile.children.cycles-pp.__slab_free
      1.50            +1.4        2.93        perf-profile.children.cycles-pp.collect_signal
      0.52 ±  6%      +1.5        1.97        perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.47 ±  2%      +2.3        2.78        perf-profile.children.cycles-pp.__fpu_restore_sig
      0.49 ±  3%      +2.4        2.84        perf-profile.children.cycles-pp.fpu__restore_sig
     10.89            +2.6       13.47        perf-profile.children.cycles-pp.getuid
      0.82 ±  5%      +2.7        3.48        perf-profile.children.cycles-pp.get_sigframe
     10.92            +2.8       13.67        perf-profile.children.cycles-pp.__getpid
      0.65 ±  4%      +3.1        3.79        perf-profile.children.cycles-pp.__irqentry_text_end
      0.67 ±  2%      +3.2        3.86        perf-profile.children.cycles-pp.restore_sigcontext
      0.94 ±  5%      +3.3        4.21        perf-profile.children.cycles-pp.x64_setup_rt_frame
      2.89            +3.7        6.58        perf-profile.children.cycles-pp.dequeue_signal
      4.47 ±  4%      +3.7        8.17        perf-profile.children.cycles-pp.apparmor_task_kill
      4.51 ±  4%      +3.7        8.23        perf-profile.children.cycles-pp.security_task_kill
      1.16 ±  4%      +4.3        5.50        perf-profile.children.cycles-pp.handle_signal
      1.04 ±  2%      +5.1        6.12        perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      8.54            +5.6       14.10        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.85 ±  3%      +6.0        6.81        perf-profile.children.cycles-pp.get_signal
      5.94            +7.5       13.44        perf-profile.children.cycles-pp.exit_to_user_mode_loop
     19.04            +8.4       27.42        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.24 ±  3%     +10.9       13.14        perf-profile.children.cycles-pp.stress_sighandler_nop
      2.16 ±  3%     +11.1       13.26        perf-profile.children.cycles-pp.arch_do_signal_or_restart
      3.20            -2.8        0.40 ±  3%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      2.16 ±  2%      -1.9        0.30 ±  3%  perf-profile.self.cycles-pp.__schedule
      1.90 ±  2%      -1.7        0.22 ±  4%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      1.19 ±  3%      -1.0        0.15 ±  8%  perf-profile.self.cycles-pp.__switch_to_asm
      1.17 ±  4%      -1.0        0.13 ±  8%  perf-profile.self.cycles-pp.update_curr
      1.02 ±  2%      -0.9        0.14 ±  3%  perf-profile.self.cycles-pp.update_load_avg
      0.98 ±  8%      -0.8        0.15 ±  7%  perf-profile.self.cycles-pp.__sigtimedwait
      0.94 ±  2%      -0.8        0.15 ±  3%  perf-profile.self.cycles-pp.reweight_entity
      0.82 ±  4%      -0.7        0.10 ± 12%  perf-profile.self.cycles-pp.___perf_sw_event
      0.79 ±  2%      -0.6        0.14 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.74 ±  4%      -0.6        0.11 ±  9%  perf-profile.self.cycles-pp.update_cfs_group
      0.69 ±  5%      -0.6        0.08 ±  4%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.68            -0.6        0.07 ±  5%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.72 ±  3%      -0.6        0.11 ±  7%  perf-profile.self.cycles-pp.pick_eevdf
      0.71 ±  4%      -0.6        0.11 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      1.07 ± 29%      -0.6        0.49 ± 35%  perf-profile.self.cycles-pp.queue_event
      0.62 ±  2%      -0.5        0.08        perf-profile.self.cycles-pp.os_xsave
      0.56 ±  2%      -0.5        0.06 ±  7%  perf-profile.self.cycles-pp.__switch_to
      0.53 ±  4%      -0.5        0.07        perf-profile.self.cycles-pp.select_task_rq_fair
      0.54 ±  3%      -0.5        0.08 ±  5%  perf-profile.self.cycles-pp.__x64_sys_rt_sigtimedwait
      1.90 ±  5%      -0.4        1.47 ±  3%  perf-profile.self.cycles-pp.stress_sigrt
      0.47 ±  6%      -0.4        0.05 ±  7%  perf-profile.self.cycles-pp.enqueue_entity
      0.46 ±  2%      -0.4        0.08 ±  6%  perf-profile.self.cycles-pp.avg_vruntime
      0.43 ±  4%      -0.4        0.05 ± 47%  perf-profile.self.cycles-pp.perf_tp_event
      0.44 ±  3%      -0.4        0.07        perf-profile.self.cycles-pp.dequeue_task_fair
      0.39 ±  2%      -0.4        0.03 ± 70%  perf-profile.self.cycles-pp.schedule
      0.39 ±  3%      -0.3        0.06 ±  7%  perf-profile.self.cycles-pp.__calc_delta
      0.38 ±  4%      -0.3        0.07 ±  8%  perf-profile.self.cycles-pp.schedule_hrtimeout_range_clock
      0.38 ±  6%      -0.3        0.08 ±  5%  perf-profile.self.cycles-pp.__dequeue_entity
      0.34 ±  5%      -0.3        0.05 ±  7%  perf-profile.self.cycles-pp.try_to_wake_up
      0.33 ±  4%      -0.3        0.04 ± 44%  perf-profile.self.cycles-pp._raw_spin_lock
      0.31 ±  5%      -0.3        0.02 ± 99%  perf-profile.self.cycles-pp.update_min_vruntime
      0.34 ±  3%      -0.3        0.06 ±  7%  perf-profile.self.cycles-pp.do_sigtimedwait
      0.29 ± 25%      -0.3        0.03 ±100%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.29 ±  2%      -0.2        0.04 ± 45%  perf-profile.self.cycles-pp.dequeue_entity
      0.68 ±  2%      -0.2        0.43        perf-profile.self.cycles-pp.__x64_sys_getuid
      0.28 ±  4%      -0.2        0.04 ± 45%  perf-profile.self.cycles-pp.native_sched_clock
      0.25 ±  6%      -0.2        0.04 ± 71%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.34 ±  9%      -0.2        0.13 ±  8%  perf-profile.self.cycles-pp.__enqueue_entity
      0.26 ±  4%      -0.2        0.08 ± 11%  perf-profile.self.cycles-pp.__libc_current_sigrtmin@plt
      0.59 ±  6%      -0.2        0.44        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.96 ± 10%      -0.2        0.81 ±  2%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.17 ± 13%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.select_idle_sibling
      0.67 ±  2%      -0.1        0.53 ±  8%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.96 ±  2%      -0.1        0.84        perf-profile.self.cycles-pp.sigqueue
      0.32 ± 19%      -0.1        0.20 ±  7%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.38 ±  4%      -0.1        0.30 ±  5%  perf-profile.self.cycles-pp.complete_signal
      0.35 ±  7%      -0.1        0.28 ±  2%  perf-profile.self.cycles-pp.audit_signal_info_syscall
      0.14 ±  8%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.29 ±  9%      -0.1        0.22 ±  5%  perf-profile.self.cycles-pp.__libc_current_sigrtmin_private
      0.68 ±  4%      -0.1        0.63 ±  3%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.14 ±  6%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.pid_task
      0.17 ±  4%      -0.0        0.13 ±  4%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.16 ±  3%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.exit_to_user_mode_loop
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.check_kill_permission
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__sigqueue_alloc
      0.62            +0.0        0.64        perf-profile.self.cycles-pp.recalc_sigpending
      0.14 ±  4%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.__x64_sys_getpid
      0.06 ±  7%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.08 ±  4%      +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.__libc_current_sigrtmax_private
      0.14 ±  3%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.22 ±  4%      +0.1        0.28        perf-profile.self.cycles-pp.getuid
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.fpu__restore_sig
      0.45 ±  5%      +0.1        0.52        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.15 ±  4%      +0.1        0.22 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.signal_setup_done
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.set_current_blocked
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.__set_current_blocked
      0.12 ±  6%      +0.1        0.22 ±  3%  perf-profile.self.cycles-pp.map_id_up
      0.39            +0.1        0.50 ±  3%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.fpu__alloc_mathframe
      0.00            +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.__unfreeze_partials
      0.44 ±  9%      +0.1        0.56 ±  2%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.18 ±  3%      +0.1        0.30 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
      0.34 ±  8%      +0.1        0.46 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.13 ±  4%  perf-profile.self.cycles-pp.get_partial_node
      0.00            +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.handle_signal
      0.23 ±  7%      +0.1        0.37        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.37 ±  2%      +0.2        0.53 ±  2%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.35 ±  3%      +0.2        0.54 ±  2%  perf-profile.self.cycles-pp.__send_signal_locked
      0.00            +0.2        0.20 ±  4%  perf-profile.self.cycles-pp.do_sigaltstack
      0.00            +0.2        0.20 ±  4%  perf-profile.self.cycles-pp.restore_altstack
      0.04 ± 45%      +0.2        0.28 ±  4%  perf-profile.self.cycles-pp.get_sigframe
      0.06 ±  8%      +0.2        0.30 ±  2%  perf-profile.self.cycles-pp.check_xstate_in_sigframe
      0.05 ±  7%      +0.2        0.30        perf-profile.self.cycles-pp.fpregs_mark_activate
      0.06 ± 11%      +0.3        0.32        perf-profile.self.cycles-pp.save_xstate_epilog
      0.00            +0.3        0.28 ±  5%  perf-profile.self.cycles-pp.___slab_alloc
      0.08 ±  6%      +0.3        0.42 ±  2%  perf-profile.self.cycles-pp.__x64_sys_rt_sigreturn
     12.56            +0.3       12.90        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.06 ± 11%      +0.4        0.42        perf-profile.self.cycles-pp.arch_do_signal_or_restart
      0.08 ±  4%      +0.4        0.44 ±  3%  perf-profile.self.cycles-pp.__put_user_nocheck_4
      0.07 ±  5%      +0.4        0.43 ±  2%  perf-profile.self.cycles-pp.restore_sigcontext
      0.08 ± 11%      +0.4        0.49 ±  2%  perf-profile.self.cycles-pp.__get_user_nocheck_4
      0.58 ±  3%      +0.4        0.98 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      0.65 ±  3%      +0.4        1.07        perf-profile.self.cycles-pp.profile_signal_perm
      0.06 ±145%      +0.4        0.50 ±  7%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.01            +0.4        1.45        perf-profile.self.cycles-pp.inc_rlimit_get_ucounts
      0.70            +0.4        1.15        perf-profile.self.cycles-pp._copy_from_user
      0.10 ±  4%      +0.5        0.58        perf-profile.self.cycles-pp.get_signal
      0.09 ±  8%      +0.5        0.58        perf-profile.self.cycles-pp.__fpu_restore_sig
      0.13 ±  8%      +0.5        0.63 ±  2%  perf-profile.self.cycles-pp.stress_sighandler_nop
      0.10            +0.6        0.66        perf-profile.self.cycles-pp.__get_user_nocheck_8
      1.16 ±  2%      +0.6        1.75        perf-profile.self.cycles-pp.do_dec_rlimit_put_ucounts
      0.12 ±  7%      +0.6        0.72 ±  3%  perf-profile.self.cycles-pp.x64_setup_rt_frame
      0.15 ±  4%      +0.8        0.96        perf-profile.self.cycles-pp.fpu__clear_user_states
      0.29 ± 10%      +0.8        1.10        perf-profile.self.cycles-pp.collect_signal
      0.75 ±  6%      +0.9        1.61        perf-profile.self.cycles-pp.aa_may_signal
      1.17 ±  5%      +1.0        2.17        perf-profile.self.cycles-pp.aa_get_task_label
      0.28 ±  4%      +1.2        1.46 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.24 ±  3%      +1.2        1.42 ±  2%  perf-profile.self.cycles-pp.restore_fpregs_from_user
      0.33 ±  4%      +1.3        1.65        perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
      5.69            +1.4        7.08        perf-profile.self.cycles-pp.__entry_text_start
      1.89 ±  4%      +1.4        3.29        perf-profile.self.cycles-pp.apparmor_task_kill
      0.15 ± 14%      +1.4        1.57        perf-profile.self.cycles-pp.__slab_free
      7.83            +1.8        9.62        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
     10.42            +2.7       13.13        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.65 ±  4%      +3.1        3.79        perf-profile.self.cycles-pp.__irqentry_text_end



***************************************************************************************************
lkp-skl-d08: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  interrupt/gcc-12/performance/1SSD/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/sigsuspend/stress-ng/60s

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    249337 ±  6%     +50.3%     374645 ±  8%  cpuidle..usage
     27.84            +3.0       30.79        mpstat.cpu.all.usr%
     64.76            -5.0%      61.54        iostat.cpu.system
     27.07           +10.4%      29.90        iostat.cpu.user
    192.83 ± 30%     -96.6%       6.50 ± 52%  perf-c2c.DRAM.local
      2321 ± 17%     +75.1%       4065 ± 15%  perf-c2c.HITM.local
      2321 ± 17%     +75.1%       4065 ± 15%  perf-c2c.HITM.total
   7134990 ±  4%     -51.8%    3438618 ±  3%  vmstat.memory.cache
  24539145           +15.8%   28406554        vmstat.memory.free
     83.17           +85.6%     154.33        vmstat.procs.r
   5561442           -96.3%     203150 ±  4%  vmstat.system.cs
 2.077e+08           -93.9%   12639824 ±  5%  stress-ng.sigsuspend.ops
   3461868           -93.9%     210660 ±  5%  stress-ng.sigsuspend.ops_per_sec
 1.559e+08           -99.7%     514434        stress-ng.time.involuntary_context_switches
      3389            +1.1%       3427        stress-ng.time.percent_of_cpu_this_job_got
      1487            -3.8%       1430        stress-ng.time.system_time
    617.36           +13.0%     697.67        stress-ng.time.user_time
 2.076e+08           -94.1%   12311096 ±  5%  stress-ng.time.voluntary_context_switches
     19245 ± 36%     +78.9%      34432 ± 15%  turbostat.C1
      0.17 ± 10%    +558.3%       1.13 ± 32%  turbostat.CPU%c6
     47.83           -12.5%      41.83        turbostat.CoreTmp
      0.11 ±  3%     -53.8%       0.05        turbostat.IPC
   5727321 ±  7%      -8.9%    5218101 ±  2%  turbostat.IRQ
     45347 ± 20%    +201.2%     136579 ± 14%  turbostat.POLL
     47.50 ±  2%     -12.3%      41.67 ±  2%  turbostat.PkgTmp
    188.77           -17.4%     156.00        turbostat.PkgWatt
      1.01           -11.6%       0.89        turbostat.RAMWatt
     97263 ± 38%    +497.2%     580860 ± 17%  meminfo.Active
     87518 ± 38%    +563.5%     580681 ± 17%  meminfo.Active(anon)
    433224           -13.5%     374894        meminfo.AnonPages
   7019086 ±  4%     -52.2%    3358359 ±  3%  meminfo.Cached
   6553310 ±  5%     -57.0%    2820190 ±  3%  meminfo.Committed_AS
   5307050 ± 21%     +23.3%    6542336 ± 11%  meminfo.DirectMap2M
   4653770 ±  6%     -90.5%     441481 ±  3%  meminfo.Inactive
   4647503 ±  6%     -90.5%     441107 ±  3%  meminfo.Inactive(anon)
     85173           -10.2%      76471        meminfo.KReclaimable
   1228127 ±  8%     -92.0%      98369 ± 13%  meminfo.Mapped
  24353220           +15.7%   28178003        meminfo.MemAvailable
  24567682           +15.6%   28404545        meminfo.MemFree
   7994352 ±  4%     -48.0%    4157489 ±  2%  meminfo.Memused
     16997 ±  3%     -12.9%      14808 ±  4%  meminfo.PageTables
     85173           -10.2%      76471        meminfo.SReclaimable
   4302180 ±  7%     -85.0%     647263 ± 16%  meminfo.Shmem
   8034165 ±  4%     -46.4%    4303791 ±  2%  meminfo.max_used_kB
     21833 ± 38%    +565.0%     145182 ± 17%  proc-vmstat.nr_active_anon
    108372           -13.6%      93685        proc-vmstat.nr_anon_pages
    607141           +15.7%     702469        proc-vmstat.nr_dirty_background_threshold
   1215767           +15.7%    1406656        proc-vmstat.nr_dirty_threshold
   1756412 ±  4%     -52.2%     839582 ±  3%  proc-vmstat.nr_file_pages
   6142589           +15.6%    7101129        proc-vmstat.nr_free_pages
   1161234 ±  6%     -90.5%     110217 ±  3%  proc-vmstat.nr_inactive_anon
    305935 ±  9%     -92.0%      24521 ± 13%  proc-vmstat.nr_mapped
      4252 ±  3%     -13.0%       3701 ±  4%  proc-vmstat.nr_page_table_pages
   1074788 ±  7%     -84.9%     161806 ± 16%  proc-vmstat.nr_shmem
     21290           -10.2%      19117        proc-vmstat.nr_slab_reclaimable
     21833 ± 38%    +565.0%     145182 ± 17%  proc-vmstat.nr_zone_active_anon
   1161234 ±  6%     -90.5%     110217 ±  3%  proc-vmstat.nr_zone_inactive_anon
   1777928 ±  6%     -73.1%     478826 ±  8%  proc-vmstat.numa_hit
   1784234 ±  6%     -73.4%     474428 ±  7%  proc-vmstat.numa_local
     18962 ±  5%    +684.1%     148679 ±  6%  proc-vmstat.pgactivate
   1830911 ±  6%     -71.3%     525134 ±  7%  proc-vmstat.pgalloc_normal
    316769           -13.9%     272741        proc-vmstat.pgfault
    216412           +27.0%     274858        proc-vmstat.pgfree
    917478           +21.2%    1111830        sched_debug.cfs_rq:/.avg_vruntime.avg
    976815 ±  2%     +60.8%    1570651 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.max
     19932 ± 22%    +576.0%     134748 ± 15%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      1.52 ±  4%     +79.1%       2.72 ±  3%  sched_debug.cfs_rq:/.h_nr_running.avg
      3.25 ±  7%     +35.9%       4.42 ±  7%  sched_debug.cfs_rq:/.h_nr_running.max
      0.95 ±  2%     -14.7%       0.81 ± 14%  sched_debug.cfs_rq:/.h_nr_running.stddev
    917478           +21.2%    1111831        sched_debug.cfs_rq:/.min_vruntime.avg
    976815 ±  2%     +60.8%    1570651 ± 11%  sched_debug.cfs_rq:/.min_vruntime.max
     19932 ± 22%    +576.0%     134748 ± 15%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1652           +69.4%       2798 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
      2748 ± 11%     +60.4%       4409 ±  8%  sched_debug.cfs_rq:/.runnable_avg.max
      1097 ± 18%     -37.3%     688.33 ± 23%  sched_debug.cfs_rq:/.runnable_avg.min
    341.89 ± 17%    +111.6%     723.58 ± 15%  sched_debug.cfs_rq:/.runnable_avg.stddev
    295.42 ±  3%     -22.5%     228.81 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1044 ±  9%     -14.3%     894.42 ±  8%  sched_debug.cfs_rq:/.util_est_enqueued.max
    230.41 ±  4%      -9.3%     208.98 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
      3.25 ±  8%     -32.0%       2.21 ± 19%  sched_debug.cpu.clock.stddev
     81.33 ± 11%     -17.0%      67.53 ±  5%  sched_debug.cpu.clock_task.stddev
      1.50 ±  5%     +81.2%       2.72 ±  2%  sched_debug.cpu.nr_running.avg
      3.25 ±  7%     +35.9%       4.42 ±  7%  sched_debug.cpu.nr_running.max
   4802408           -96.2%     181526 ±  5%  sched_debug.cpu.nr_switches.avg
   5003393           -83.9%     803946 ± 27%  sched_debug.cpu.nr_switches.max
   4149380 ±  7%     -99.0%      42283 ±  9%  sched_debug.cpu.nr_switches.min
 9.351e+09           -55.6%  4.155e+09        perf-stat.i.branch-instructions
 1.573e+08           -56.0%   69287057        perf-stat.i.branch-misses
      4.23 ±  7%      -2.2        2.01 ±  2%  perf-stat.i.cache-miss-rate%
   6751954 ±  5%     -78.8%    1428725 ±  8%  perf-stat.i.cache-misses
 1.872e+08 ± 10%     -41.4%  1.096e+08 ±  9%  perf-stat.i.cache-references
   5817774           -96.4%     211465 ±  5%  perf-stat.i.context-switches
      2.75          +115.9%       5.94        perf-stat.i.cpi
    327628 ± 14%    +373.6%    1551605 ±  4%  perf-stat.i.cycles-between-cache-misses
      1.34            -1.0        0.34 ±  2%  perf-stat.i.dTLB-load-miss-rate%
 1.787e+08           -88.8%   20010077 ±  2%  perf-stat.i.dTLB-load-misses
 1.302e+10           -54.8%  5.879e+09        perf-stat.i.dTLB-loads
      0.70 ± 85%      -0.7        0.05 ±  7%  perf-stat.i.dTLB-store-miss-rate%
 1.351e+12 ±223%    -100.0%    1548664 ±  7%  perf-stat.i.dTLB-store-misses
 7.591e+09           -57.9%  3.197e+09        perf-stat.i.dTLB-stores
     52.32           +31.9       84.24        perf-stat.i.iTLB-load-miss-rate%
  77655104           -79.3%   16073669 ±  2%  perf-stat.i.iTLB-load-misses
  67953773           -96.2%    2583574 ±  6%  perf-stat.i.iTLB-loads
 4.781e+10           -54.6%   2.17e+10        perf-stat.i.instructions
      2609 ±  7%     +27.4%       3324 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.40           -48.1%       0.21        perf-stat.i.ipc
    691.54 ± 22%     -78.0%     151.98 ±  7%  perf-stat.i.metric.K/sec
    839.73           -55.9%     370.40        perf-stat.i.metric.M/sec
      3605 ±  2%     -18.3%       2945        perf-stat.i.minor-faults
   1917836 ± 14%     -91.7%     158930 ±  5%  perf-stat.i.node-loads
    559746 ±  6%     -78.7%     119446 ± 18%  perf-stat.i.node-stores
      3606 ±  2%     -18.3%       2946        perf-stat.i.page-faults
      0.14 ±  4%     -53.9%       0.07 ±  7%  perf-stat.overall.MPKI
      3.65 ± 12%      -2.4        1.30 ± 10%  perf-stat.overall.cache-miss-rate%
      2.73          +119.3%       5.98        perf-stat.overall.cpi
     19357 ±  4%    +377.8%      92490 ±  7%  perf-stat.overall.cycles-between-cache-misses
      1.35            -1.0        0.34        perf-stat.overall.dTLB-load-miss-rate%
     17.01 ±217%     -17.0        0.05 ±  7%  perf-stat.overall.dTLB-store-miss-rate%
     53.33           +32.9       86.19        perf-stat.overall.iTLB-load-miss-rate%
    615.74          +119.1%       1348        perf-stat.overall.instructions-per-iTLB-miss
      0.37           -54.4%       0.17        perf-stat.overall.ipc
 9.204e+09           -55.5%  4.094e+09        perf-stat.ps.branch-instructions
 1.548e+08           -56.1%   68037157        perf-stat.ps.branch-misses
   6647486 ±  5%     -79.1%    1392058 ±  8%  perf-stat.ps.cache-misses
 1.843e+08 ± 10%     -41.3%  1.081e+08 ±  9%  perf-stat.ps.cache-references
   5726331           -96.4%     208210 ±  5%  perf-stat.ps.context-switches
 1.759e+08           -88.8%   19737632 ±  2%  perf-stat.ps.dTLB-load-misses
 1.281e+10           -54.8%  5.795e+09        perf-stat.ps.dTLB-loads
 1.326e+12 ±223%    -100.0%    1525476 ±  7%  perf-stat.ps.dTLB-store-misses
 7.472e+09           -57.8%  3.153e+09        perf-stat.ps.dTLB-stores
  76434496           -79.2%   15860324 ±  2%  perf-stat.ps.iTLB-load-misses
  66885780           -96.2%    2543308 ±  6%  perf-stat.ps.iTLB-loads
 4.706e+10           -54.6%  2.139e+10        perf-stat.ps.instructions
      3547 ±  2%     -19.2%       2865        perf-stat.ps.minor-faults
   1887790 ± 14%     -91.7%     156314 ±  5%  perf-stat.ps.node-loads
    551228 ±  6%     -78.8%     117021 ± 18%  perf-stat.ps.node-stores
      3548 ±  2%     -19.2%       2865        perf-stat.ps.page-faults
  2.99e+12           -54.5%   1.36e+12        perf-stat.total.instructions
      0.01 ±148%    +600.0%       0.04 ± 40%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.01 ± 71%  +21401.7%       2.11 ± 52%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.26 ±139%    +652.5%       1.96 ± 28%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 73%   +3052.6%       0.60 ± 81%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.02 ± 99%   +2003.0%       0.47 ± 29%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.16 ± 71%    +219.9%       0.50 ±  6%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.43 ±116%    +412.5%       2.18 ± 11%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 71%   +5040.0%       0.21 ± 15%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.08 ±120%   +1422.8%       1.26 ± 44%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 71%  +20254.5%       1.12 ± 13%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.03 ± 70%   +2713.2%       0.71 ± 21%  perf-sched.sch_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.02 ± 95%   +3400.8%       0.75 ± 54%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.04 ± 72%  +25117.5%      10.09 ± 53%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      1.16 ±142%    +330.0%       4.98 ± 44%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.08 ±128%    +392.6%       5.32 ±124%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.39 ±147%    +729.0%       3.21 ± 30%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ± 72%  +39108.7%       3.01        perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.76 ±142%    +267.9%       2.79 ± 21%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 73%  +34165.8%       2.17 ± 17%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.13 ± 81%   +4389.0%       5.73 ± 51%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.02 ± 71%   +4307.6%       0.68 ± 20%  perf-sched.total_sch_delay.average.ms
      0.10 ± 70%   +1928.4%       1.93 ± 20%  perf-sched.total_wait_and_delay.average.ms
      0.08 ± 70%   +1473.4%       1.25 ± 20%  perf-sched.total_wait_time.average.ms
      0.35 ± 77%   +2608.9%       9.56 ± 69%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.28 ± 82%   +7145.3%      19.96 ± 56%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
    276.75 ± 85%    +190.3%     803.34        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.05 ±141%   +3263.9%       1.79 ± 76%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.19 ± 76%   +1535.7%       3.09 ±  9%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.55 ± 72%    +526.0%       3.46 ±  6%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.01 ± 70%   +5118.5%       0.70 ± 10%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    137.43 ± 76%    +302.6%     553.27 ±  8%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.11 ± 70%   +1285.7%       1.50 ± 20%  perf-sched.wait_and_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.00 ± 82%    +150.0%      10.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     28.33 ± 74%    +126.5%      64.17        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      4669 ± 71%    +201.6%      14080 ±  2%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      8.33 ± 74%    +206.0%      25.50 ± 10%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      9.17 ± 77%   +1574.5%     153.50 ± 13%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     19.67 ± 71%    +113.6%      42.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      4.67 ± 73%    +114.3%      10.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
     41.33 ± 72%    +150.8%     103.67 ± 12%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    171.00 ± 72%     +78.3%     304.83 ±  5%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     18.91 ± 85%    +719.3%     154.94 ±114%  perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      9.29 ± 91%    +714.6%      75.71 ± 76%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
    191.87 ±190%    +425.1%       1007        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1.29 ± 91%   +1076.9%      15.18 ± 17%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.25 ± 79%   +2911.4%       7.59 ± 87%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.01 ±101%  +27812.8%       1.81 ± 70%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      0.35 ± 77%   +2608.9%       9.56 ± 69%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.02 ±100%  +20233.7%       3.52 ± 52%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
      0.01 ± 71%  +29442.9%       3.10 ± 91%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.28 ± 82%   +7145.3%      19.96 ± 56%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      0.12 ±210%   +2745.5%       3.41 ± 42%  perf-sched.wait_time.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
    276.49 ± 85%    +189.8%     801.38        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.08 ± 71%   +1396.0%       1.19 ± 73%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    125.29 ± 74%     +99.9%     250.43        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.17 ± 75%   +1474.2%       2.62 ± 14%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.40 ± 73%    +647.9%       2.96 ±  6%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.59 ±109%    +734.4%       4.91 ± 42%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.01 ± 70%   +5183.8%       0.70 ± 10%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    125.95 ± 76%    +338.8%     552.62 ±  8%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.08 ± 70%    +850.6%       0.80 ± 19%  perf-sched.wait_time.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.42 ±101%    +201.7%       1.28 ± 34%  perf-sched.wait_time.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.01 ±103%  +67159.1%       7.40 ±105%  perf-sched.wait_time.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
     18.91 ± 85%    +719.3%     154.94 ±114%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.19 ±196%  +18735.6%      35.32 ± 35%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
      0.02 ± 73%  +1.1e+05%      25.54 ±130%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      9.29 ± 91%    +714.6%      75.71 ± 76%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      1.01 ±221%   +2598.5%      27.34 ± 44%  perf-sched.wait_time.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
    210.40 ±168%    +377.1%       1003        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.98 ± 84%   +1376.7%      14.48 ± 21%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.83 ±104%    +208.9%       2.56 ± 34%  perf-sched.wait_time.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
     30.53           -28.4        2.16 ± 26%  perf-profile.calltrace.cycles-pp.__sigsuspend
     24.42           -22.6        1.82 ± 26%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sigsuspend
     22.97           -21.3        1.67 ± 26%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigsuspend
     13.62           -13.1        0.53 ± 47%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.04           -10.4        0.65 ± 47%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigsuspend
     10.39            -9.8        0.62 ± 47%  perf-profile.calltrace.cycles-pp.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigsuspend
     11.06            -9.7        1.35 ± 11%  perf-profile.calltrace.cycles-pp.__send_signal_locked.do_send_sig_info.kill_pid_info.kill_something_info.__x64_sys_kill
     10.17            -9.6        0.61 ± 47%  perf-profile.calltrace.cycles-pp.schedule.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.97            -9.4        0.60 ± 47%  perf-profile.calltrace.cycles-pp.__schedule.schedule.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64
     11.95            -9.2        2.73 ±  6%  perf-profile.calltrace.cycles-pp.do_send_sig_info.kill_pid_info.kill_something_info.__x64_sys_kill.do_syscall_64
      9.36            -8.8        0.59 ± 46%  perf-profile.calltrace.cycles-pp.stress_sighandler_nop
      9.04            -8.3        0.73 ± 47%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigsuspend
      8.57            -8.1        0.48 ± 46%  perf-profile.calltrace.cycles-pp.complete_signal.__send_signal_locked.do_send_sig_info.kill_pid_info.kill_something_info
      8.24            -7.9        0.37 ± 71%  perf-profile.calltrace.cycles-pp.try_to_wake_up.complete_signal.__send_signal_locked.do_send_sig_info.kill_pid_info
      7.91            -7.4        0.52 ± 47%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      6.93            -6.4        0.53 ± 47%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigsuspend
      6.59            -5.9        0.72 ±  3%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
      5.44            -5.4        0.00        perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      5.28            -5.3        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      4.99 ±  2%      -5.0        0.00        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.complete_signal.__send_signal_locked.do_send_sig_info
      1.06 ±  3%      -0.5        0.57 ±  6%  perf-profile.calltrace.cycles-pp.clock_gettime
      0.58 ±  3%      -0.1        0.44 ± 44%  perf-profile.calltrace.cycles-pp.stress_time_now_timespec
      0.60 ±  5%      +0.2        0.77 ±  8%  perf-profile.calltrace.cycles-pp.__radix_tree_lookup.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.56 ±  6%  perf-profile.calltrace.cycles-pp.check_kill_permission.kill_pid_info.kill_something_info.__x64_sys_kill.do_syscall_64
      0.98 ±  8%      +0.6        1.58 ± 13%  perf-profile.calltrace.cycles-pp.profile_signal_perm.aa_may_signal.apparmor_task_kill.security_task_kill.kill_pid_info
      0.00            +0.7        0.75 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.do_send_sig_info.kill_pid_info.kill_something_info.__x64_sys_kill
      0.17 ±141%      +1.0        1.22 ±  3%  perf-profile.calltrace.cycles-pp.__task_pid_nr_ns.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
      1.72            +1.2        2.87        perf-profile.calltrace.cycles-pp.__entry_text_start.kill
      0.55 ±  2%      +1.3        1.86 ±  3%  perf-profile.calltrace.cycles-pp.stress_time_now
      0.00            +1.5        1.48 ±  8%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
      0.74 ± 26%      +2.1        2.85 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.kill
      3.12 ±  3%      +4.2        7.35 ±  7%  perf-profile.calltrace.cycles-pp.aa_may_signal.apparmor_task_kill.security_task_kill.kill_pid_info.kill_something_info
      0.94 ±  7%      +4.5        5.45 ±  3%  perf-profile.calltrace.cycles-pp.stress_atomic_lock_acquire
      4.76            +6.5       11.22        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.kill
      3.43 ±  2%     +11.1       14.48        perf-profile.calltrace.cycles-pp.aa_get_task_label.apparmor_task_kill.security_task_kill.kill_pid_info.kill_something_info
     24.98           +25.4       50.35        perf-profile.calltrace.cycles-pp.kill_pid_info.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.86           +25.8       51.63        perf-profile.calltrace.cycles-pp.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
     27.18           +27.1       54.31        perf-profile.calltrace.cycles-pp.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
     38.37           +27.7       66.05        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
     41.43           +30.4       71.79        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.kill
     12.29 ±  2%     +34.3       46.54        perf-profile.calltrace.cycles-pp.apparmor_task_kill.security_task_kill.kill_pid_info.kill_something_info.__x64_sys_kill
     12.37 ±  2%     +34.3       46.70        perf-profile.calltrace.cycles-pp.security_task_kill.kill_pid_info.kill_something_info.__x64_sys_kill.do_syscall_64
     50.05           +37.8       87.88        perf-profile.calltrace.cycles-pp.kill
     30.84           -28.7        2.17 ± 26%  perf-profile.children.cycles-pp.__sigsuspend
     15.71           -15.0        0.70 ± 24%  perf-profile.children.cycles-pp.schedule
     15.41           -14.7        0.70 ± 25%  perf-profile.children.cycles-pp.__schedule
     14.90           -13.4        1.48 ± 13%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
     13.70           -12.9        0.76 ± 25%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
     23.14           -11.0       12.12        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     11.06           -10.4        0.71 ± 26%  perf-profile.children.cycles-pp.__x64_sys_rt_sigsuspend
     10.39            -9.7        0.68 ± 26%  perf-profile.children.cycles-pp.sigsuspend
     11.09            -9.7        1.39 ± 11%  perf-profile.children.cycles-pp.__send_signal_locked
     11.98            -9.2        2.79 ±  6%  perf-profile.children.cycles-pp.do_send_sig_info
      9.00            -8.3        0.69 ± 25%  perf-profile.children.cycles-pp.stress_sighandler_nop
      8.58            -8.1        0.52 ± 24%  perf-profile.children.cycles-pp.complete_signal
      8.29            -7.8        0.50 ± 24%  perf-profile.children.cycles-pp.try_to_wake_up
      7.93            -7.2        0.71 ± 27%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      5.02 ±  2%      -4.8        0.25 ± 25%  perf-profile.children.cycles-pp.ttwu_do_activate
      4.86            -4.5        0.32 ± 26%  perf-profile.children.cycles-pp.handle_signal
      4.17 ±  4%      -4.0        0.20 ± 24%  perf-profile.children.cycles-pp.dequeue_task_fair
      4.13 ±  2%      -3.9        0.23 ± 25%  perf-profile.children.cycles-pp.activate_task
      3.99 ±  3%      -3.8        0.22 ± 26%  perf-profile.children.cycles-pp.enqueue_task_fair
      4.01            -3.8        0.26 ± 27%  perf-profile.children.cycles-pp.x64_setup_rt_frame
      3.95            -3.7        0.27 ± 26%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      3.56            -3.4        0.12 ± 20%  perf-profile.children.cycles-pp.pick_next_task_fair
      3.54            -3.3        0.22 ± 26%  perf-profile.children.cycles-pp.get_sigframe
      3.07            -2.9        0.18 ± 25%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      2.75 ±  4%      -2.6        0.14 ± 25%  perf-profile.children.cycles-pp.update_curr
      2.56            -2.4        0.19 ± 24%  perf-profile.children.cycles-pp.__irqentry_text_end
      2.52            -2.3        0.17 ± 27%  perf-profile.children.cycles-pp.restore_sigcontext
      2.46            -2.3        0.16 ± 24%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      2.34 ±  3%      -2.2        0.13 ± 18%  perf-profile.children.cycles-pp.update_load_avg
      2.52            -2.2        0.31 ± 29%  perf-profile.children.cycles-pp.get_signal
      2.15            -2.0        0.12 ± 27%  perf-profile.children.cycles-pp.enqueue_entity
      2.11 ±  4%      -2.0        0.10 ± 26%  perf-profile.children.cycles-pp.dequeue_entity
      1.88            -1.8        0.12 ± 28%  perf-profile.children.cycles-pp.fpu__restore_sig
      1.83            -1.7        0.12 ± 27%  perf-profile.children.cycles-pp.__fpu_restore_sig
      1.87            -1.7        0.19 ± 29%  perf-profile.children.cycles-pp.dequeue_signal
      1.75            -1.7        0.09 ± 26%  perf-profile.children.cycles-pp.__sigqueue_alloc
      1.44 ±  4%      -1.4        0.07 ± 47%  perf-profile.children.cycles-pp.reweight_entity
      1.34            -1.3        0.03 ±100%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      1.36 ± 12%      -1.3        0.09 ± 20%  perf-profile.children.cycles-pp.select_task_rq
      1.59 ±  2%      -1.3        0.33 ±  2%  perf-profile.children.cycles-pp.stress_sigsuspend
      1.22            -1.2        0.04 ± 71%  perf-profile.children.cycles-pp.set_next_entity
      1.19 ±  3%      -1.2        0.02 ± 99%  perf-profile.children.cycles-pp.prepare_task_switch
      1.15 ± 14%      -1.1        0.07 ± 45%  perf-profile.children.cycles-pp.select_task_rq_fair
      1.05 ±  2%      -1.0        0.06 ± 48%  perf-profile.children.cycles-pp._copy_from_user
      1.04            -1.0        0.06 ± 49%  perf-profile.children.cycles-pp.collect_signal
      1.02 ±  2%      -0.9        0.07 ± 47%  perf-profile.children.cycles-pp.native_irq_return_iret
      1.00            -0.9        0.06 ± 45%  perf-profile.children.cycles-pp.restore_fpregs_from_user
      0.82 ±  3%      -0.8        0.05 ± 46%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.79            -0.8        0.03 ±101%  perf-profile.children.cycles-pp.do_dec_rlimit_put_ucounts
      0.78            -0.7        0.05 ± 48%  perf-profile.children.cycles-pp.save_xstate_epilog
      0.71            -0.7        0.05 ± 45%  perf-profile.children.cycles-pp.fpu__clear_user_states
      0.66 ±  3%      -0.6        0.05 ± 48%  perf-profile.children.cycles-pp.kmem_cache_free
      1.08 ±  3%      -0.5        0.58 ±  6%  perf-profile.children.cycles-pp.clock_gettime
      0.43 ±  2%      -0.4        0.07 ± 47%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      4.62            -0.3        4.31        perf-profile.children.cycles-pp.__entry_text_start
      0.37 ±  3%      -0.3        0.06 ± 47%  perf-profile.children.cycles-pp.signal_setup_done
      0.42 ±  3%      -0.3        0.11 ± 26%  perf-profile.children.cycles-pp._raw_spin_lock
      0.36 ±  2%      -0.3        0.08 ± 48%  perf-profile.children.cycles-pp.recalc_sigpending
      0.31 ±  2%      -0.2        0.06 ± 46%  perf-profile.children.cycles-pp.__set_current_blocked
      0.51 ±  4%      -0.2        0.27 ± 10%  perf-profile.children.cycles-pp.stress_lock_acquire
      0.30 ±  7%      -0.2        0.09 ± 10%  perf-profile.children.cycles-pp.clock_gettime@plt
      0.09 ±  9%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.map_id_up
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.idr_find
      0.01 ±223%      +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.audit_signal_info
      0.30 ±  2%      +0.1        0.36 ±  3%  perf-profile.children.cycles-pp.send_signal_locked
      0.10 ±  6%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.find_vpid
      0.28 ±  2%      +0.1        0.37 ±  9%  perf-profile.children.cycles-pp.audit_signal_info_syscall
      0.44 ±  3%      +0.1        0.54        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.34 ±  2%      +0.2        0.50 ±  2%  perf-profile.children.cycles-pp.prepare_signal
      0.60            +0.2        0.77 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.61 ±  5%      +0.2        0.78 ±  8%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.39 ±  3%      +0.2        0.57 ±  6%  perf-profile.children.cycles-pp.check_kill_permission
      1.31 ±  3%      +0.3        1.57 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.99 ±  8%      +0.6        1.59 ± 13%  perf-profile.children.cycles-pp.profile_signal_perm
      0.64 ±  2%      +0.7        1.32 ±  3%  perf-profile.children.cycles-pp.stress_time_now
      0.59 ±  3%      +0.8        1.36 ±  3%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.23 ±  3%      +1.3        1.49 ±  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
     66.38            +1.9       68.30        perf-profile.children.cycles-pp.do_syscall_64
     72.50            +2.0       74.46        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      7.29            +4.2       11.45        perf-profile.children.cycles-pp.syscall_return_via_sysret
      3.13 ±  3%      +4.3        7.39 ±  7%  perf-profile.children.cycles-pp.aa_may_signal
      1.03 ±  7%      +5.0        6.02 ±  3%  perf-profile.children.cycles-pp.stress_atomic_lock_acquire
      3.43 ±  2%     +11.1       14.49        perf-profile.children.cycles-pp.aa_get_task_label
     25.00           +25.4       50.38        perf-profile.children.cycles-pp.kill_pid_info
     25.88           +25.8       51.67        perf-profile.children.cycles-pp.kill_something_info
     27.21           +27.2       54.36        perf-profile.children.cycles-pp.__x64_sys_kill
     12.30 ±  2%     +34.3       46.57        perf-profile.children.cycles-pp.apparmor_task_kill
     12.38 ±  2%     +34.3       46.70        perf-profile.children.cycles-pp.security_task_kill
     50.41           +37.9       88.35        perf-profile.children.cycles-pp.kill
      3.01            -2.8        0.18 ± 25%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      2.56            -2.4        0.19 ± 24%  perf-profile.self.cycles-pp.__irqentry_text_end
      1.90 ±  2%      -1.8        0.07 ± 46%  perf-profile.self.cycles-pp.__schedule
      1.33            -1.3        0.02 ± 99%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      1.30 ±  7%      -1.2        0.06 ± 47%  perf-profile.self.cycles-pp.update_curr
      1.34            -1.2        0.10 ± 25%  perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
      1.27 ±  2%      -1.1        0.20 ± 19%  perf-profile.self.cycles-pp.stress_sigsuspend
      1.01 ±  2%      -0.9        0.07 ± 47%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.88            -0.8        0.05 ± 47%  perf-profile.self.cycles-pp.restore_fpregs_from_user
      0.79            -0.8        0.03 ±101%  perf-profile.self.cycles-pp.do_dec_rlimit_put_ucounts
      0.42 ±  2%      -0.4        0.06 ± 46%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      4.25            -0.3        3.94        perf-profile.self.cycles-pp.__entry_text_start
      0.36 ±  2%      -0.3        0.07 ± 48%  perf-profile.self.cycles-pp.get_signal
      0.79 ±  3%      -0.3        0.52 ±  7%  perf-profile.self.cycles-pp.clock_gettime
      0.35 ±  3%      -0.3        0.08 ± 48%  perf-profile.self.cycles-pp.recalc_sigpending
      0.50 ±  4%      -0.3        0.24 ±  7%  perf-profile.self.cycles-pp.stress_lock_acquire
      0.50 ±  2%      -0.2        0.35        perf-profile.self.cycles-pp.do_syscall_64
      0.41 ±  2%      -0.1        0.30 ±  4%  perf-profile.self.cycles-pp.__send_signal_locked
      0.34 ±  4%      -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.07 ± 11%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.10 ±  7%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.12 ±  4%      +0.0        0.15 ±  4%  perf-profile.self.cycles-pp.send_signal_locked
      0.08 ± 10%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.map_id_up
      0.51 ±  4%      +0.0        0.56 ±  3%  perf-profile.self.cycles-pp.stress_time_now_timespec
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.idr_find
      0.14 ±  5%      +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.kill_pid_info
      0.09 ±  6%      +0.1        0.16 ±  4%  perf-profile.self.cycles-pp.find_vpid
      0.07 ±  6%      +0.1        0.14 ± 10%  perf-profile.self.cycles-pp.security_task_kill
      0.12 ±  5%      +0.1        0.18 ±  4%  perf-profile.self.cycles-pp.do_send_sig_info
      0.07 ±  8%      +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.check_kill_permission
      0.39 ±  2%      +0.1        0.47 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.28 ±  3%      +0.1        0.36 ±  9%  perf-profile.self.cycles-pp.audit_signal_info_syscall
      0.33 ±  2%      +0.1        0.47 ±  2%  perf-profile.self.cycles-pp.prepare_signal
      0.14 ±  4%      +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.kill_something_info
      0.59            +0.2        0.75 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.54 ±  2%      +0.2        0.71 ±  3%  perf-profile.self.cycles-pp.stress_time_now
      0.60 ±  5%      +0.2        0.78 ±  8%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.42 ±  2%      +0.2        0.65 ±  2%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.97 ±  8%      +0.6        1.57 ± 13%  perf-profile.self.cycles-pp.profile_signal_perm
      0.69            +0.7        1.34        perf-profile.self.cycles-pp.__x64_sys_kill
      0.57 ±  2%      +0.8        1.33 ±  3%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      8.10            +1.2        9.26        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.21 ±  2%      +1.3        1.47 ±  8%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      2.14 ±  2%      +3.7        5.80 ±  5%  perf-profile.self.cycles-pp.aa_may_signal
      7.28            +4.2       11.44        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.99 ±  7%      +5.0        5.98 ±  3%  perf-profile.self.cycles-pp.stress_atomic_lock_acquire
      3.41 ±  2%     +11.0       14.43        perf-profile.self.cycles-pp.aa_get_task_label
      5.73           +18.9       24.62        perf-profile.self.cycles-pp.apparmor_task_kill



***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  interrupt/gcc-12/performance/1HDD/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/sigsuspend/stress-ng/60s

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.153e+08 ± 11%     +40.9%  4.443e+08 ± 14%  cpuidle..time
   5481241 ± 18%    +276.0%   20610803 ± 22%  cpuidle..usage
      9.61 ±  5%     +27.1%      12.21 ± 10%  iostat.cpu.idle
     10.25 ±  2%     -29.0%       7.28 ±  3%  iostat.cpu.user
      6.87 ±  7%      +2.4        9.30 ± 13%  mpstat.cpu.all.idle%
      0.85 ±  2%      +0.6        1.44 ± 18%  mpstat.cpu.all.irq%
      0.01 ±  7%      +0.0        0.02 ± 14%  mpstat.cpu.all.soft%
     10.54 ±  2%      -3.0        7.52 ±  3%  mpstat.cpu.all.usr%
     79719 ± 19%   +2380.3%    1977310 ± 55%  numa-meminfo.node1.Active
     75233 ± 12%   +2528.1%    1977238 ± 55%  numa-meminfo.node1.Active(anon)
   5606537 ± 46%     -87.0%     730627 ± 29%  numa-meminfo.node1.Inactive
   5602487 ± 46%     -87.0%     730499 ± 29%  numa-meminfo.node1.Inactive(anon)
     18805 ± 12%   +2521.8%     493051 ± 55%  numa-vmstat.node1.nr_active_anon
   1400600 ± 46%     -87.0%     182524 ± 29%  numa-vmstat.node1.nr_inactive_anon
     18805 ± 12%   +2521.8%     493050 ± 55%  numa-vmstat.node1.nr_zone_active_anon
   1400600 ± 46%     -87.0%     182525 ± 29%  numa-vmstat.node1.nr_zone_inactive_anon
   9472810 ± 11%     -34.9%    6168068 ±  4%  vmstat.memory.cache
    126.17           +88.2%     237.50        vmstat.procs.r
  11136388           -86.5%    1508689 ±  5%  vmstat.system.cs
    280720 ± 11%     +88.4%     528750 ± 13%  vmstat.system.in
    445.50 ± 21%     -56.0%     196.17 ± 24%  perf-c2c.DRAM.local
      1718 ±  7%     +46.8%       2522 ± 11%  perf-c2c.DRAM.remote
      2903 ± 11%    +329.9%      12482 ±  9%  perf-c2c.HITM.local
    812.00 ±  9%     +25.9%       1022 ± 17%  perf-c2c.HITM.remote
      3715 ±  9%    +263.5%      13505 ±  9%  perf-c2c.HITM.total
 4.119e+08           -82.1%   73702782 ± 12%  stress-ng.sigsuspend.ops
   6864693           -82.1%    1228335 ± 12%  stress-ng.sigsuspend.ops_per_sec
 3.171e+08           -99.7%     854068        stress-ng.time.involuntary_context_switches
     25483            -4.4%      24363        stress-ng.time.minor_page_faults
      5944            -3.5%       5735 ±  2%  stress-ng.time.percent_of_cpu_this_job_got
    410.58 ±  2%     -28.9%     292.11 ±  4%  stress-ng.time.user_time
 4.117e+08           -82.2%   73220853 ± 12%  stress-ng.time.voluntary_context_switches
   5374378 ± 19%    +278.1%   20318436 ± 23%  turbostat.C1
      6.99 ± 12%      +3.2       10.15 ± 15%  turbostat.C1%
      6.60 ± 13%     +26.9%       8.37 ± 13%  turbostat.CPU%c1
     63.83 ±  3%      -7.8%      58.83 ±  2%  turbostat.CoreTmp
      0.14 ±  2%     -63.5%       0.05 ±  7%  turbostat.IPC
  18533186 ± 11%     +88.4%   34918066 ± 13%  turbostat.IRQ
      8.57 ± 13%      -8.6        0.01 ±223%  turbostat.PKG_%
     63.50 ±  2%      -6.8%      59.17 ±  2%  turbostat.PkgTmp
    396.02           -12.2%     347.63        turbostat.PkgWatt
     65.65            -3.0%      63.68        turbostat.RAMWatt
    106442 ± 27%   +2425.0%    2687648 ±  4%  meminfo.Active
     91979 ±  4%   +2821.9%    2687504 ±  4%  meminfo.Active(anon)
    584098           -14.9%     496908        meminfo.AnonPages
   9314973 ± 11%     -35.1%    6042275 ±  4%  meminfo.Cached
  10265181 ± 10%     -33.0%    6878896 ±  4%  meminfo.Committed_AS
   7061821 ± 14%     -84.3%    1105432 ± 15%  meminfo.Inactive
   7055660 ± 14%     -84.3%    1105092 ± 15%  meminfo.Inactive(anon)
   1983205 ±  4%     -64.8%     697466 ± 17%  meminfo.Mapped
  11236856 ±  9%     -31.2%    7727784 ±  3%  meminfo.Memused
     28127 ±  2%     -10.0%      25308 ±  4%  meminfo.PageTables
   6562876 ± 15%     -49.8%    3295910 ±  7%  meminfo.Shmem
  11308526 ±  9%     -29.8%    7937794 ±  3%  meminfo.max_used_kB
     22992 ±  4%   +2823.8%     672263 ±  4%  proc-vmstat.nr_active_anon
    146027           -14.9%     124341        proc-vmstat.nr_anon_pages
   6276102            +1.4%    6363190        proc-vmstat.nr_dirty_background_threshold
  12567550            +1.4%   12741940        proc-vmstat.nr_dirty_threshold
   2332556 ± 11%     -35.2%    1510629 ±  4%  proc-vmstat.nr_file_pages
  63132681            +1.4%   64009876        proc-vmstat.nr_free_pages
   1764143 ± 14%     -84.4%     276059 ± 15%  proc-vmstat.nr_inactive_anon
    495967 ±  4%     -65.0%     173781 ± 18%  proc-vmstat.nr_mapped
      7017 ±  2%     -10.2%       6303 ±  4%  proc-vmstat.nr_page_table_pages
   1640948 ± 15%     -49.8%     824035 ±  8%  proc-vmstat.nr_shmem
     27434 ±  2%      -7.2%      25448        proc-vmstat.nr_slab_reclaimable
     22992 ±  4%   +2823.8%     672262 ±  4%  proc-vmstat.nr_zone_active_anon
   1764143 ± 14%     -84.4%     276059 ± 15%  proc-vmstat.nr_zone_inactive_anon
    273202 ± 13%     -65.8%      93554 ±  5%  proc-vmstat.numa_hint_faults
    212829 ± 17%     -68.4%      67222 ± 14%  proc-vmstat.numa_hint_faults_local
   2834604 ± 14%     -44.6%    1571597 ±  5%  proc-vmstat.numa_hit
      1442           -45.8%     781.17 ±  2%  proc-vmstat.numa_huge_pte_updates
   2694400 ± 13%     -44.1%    1505222 ±  6%  proc-vmstat.numa_local
   1110690 ±  3%     -46.9%     589549 ±  2%  proc-vmstat.numa_pte_updates
     45441 ±  3%   +1228.5%     603669 ± 17%  proc-vmstat.pgactivate
   2843888 ± 12%     -41.9%    1651423 ±  5%  proc-vmstat.pgalloc_normal
    778597 ±  6%     -27.0%     568119        proc-vmstat.pgfault
    379559 ±  3%     +23.1%     467169        proc-vmstat.pgfree
   1674425           +25.8%    2106274 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.avg
   2070968 ±  2%     +82.1%    3771832 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.max
   1495530           -10.0%    1346187 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
    102696 ± 14%    +444.2%     558889 ± 14%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      1.24 ±  4%     +77.5%       2.20 ±  3%  sched_debug.cfs_rq:/.h_nr_running.avg
      3.33 ± 16%     +45.0%       4.83 ±  9%  sched_debug.cfs_rq:/.h_nr_running.max
      0.90 ±  7%     +27.5%       1.15 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
      4315 ±223%   +1037.3%      49080 ± 33%  sched_debug.cfs_rq:/.left_vruntime.avg
    276181 ±223%    +880.0%    2706646 ± 14%  sched_debug.cfs_rq:/.left_vruntime.max
     34251 ±223%    +941.9%     356863 ± 18%  sched_debug.cfs_rq:/.left_vruntime.stddev
   1674426           +25.8%    2106275 ±  3%  sched_debug.cfs_rq:/.min_vruntime.avg
   2070968 ±  2%     +82.1%    3771832 ±  9%  sched_debug.cfs_rq:/.min_vruntime.max
   1495530           -10.0%    1346187 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
    102696 ± 14%    +444.2%     558890 ± 14%  sched_debug.cfs_rq:/.min_vruntime.stddev
      4315 ±223%   +1037.3%      49080 ± 33%  sched_debug.cfs_rq:/.right_vruntime.avg
    276181 ±223%    +880.0%    2706646 ± 14%  sched_debug.cfs_rq:/.right_vruntime.max
     34251 ±223%    +941.9%     356863 ± 18%  sched_debug.cfs_rq:/.right_vruntime.stddev
      1349           +77.8%       2399        sched_debug.cfs_rq:/.runnable_avg.avg
      2553 ± 12%     +94.9%       4978 ±  8%  sched_debug.cfs_rq:/.runnable_avg.max
    334.47 ± 14%    +218.1%       1064 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    365.42 ± 31%     -69.2%     112.50 ± 55%  sched_debug.cfs_rq:/.util_avg.min
    199.71 ± 10%     +46.0%     291.64 ± 13%  sched_debug.cfs_rq:/.util_avg.stddev
      4.83 ± 27%     -52.1%       2.32 ± 27%  sched_debug.cpu.clock.stddev
    862.45 ± 10%     +36.4%       1176 ± 18%  sched_debug.cpu.curr->pid.stddev
      1.24 ±  6%     +77.6%       2.20 ±  3%  sched_debug.cpu.nr_running.avg
      3.33 ± 16%     +45.0%       4.83 ±  9%  sched_debug.cpu.nr_running.max
      0.90 ±  5%     +29.5%       1.16 ±  8%  sched_debug.cpu.nr_running.stddev
   5401202           -86.3%     737648 ±  5%  sched_debug.cpu.nr_switches.avg
   5904940           -55.4%    2630889 ±  8%  sched_debug.cpu.nr_switches.max
   4207188 ±  5%     -99.2%      35131 ±  3%  sched_debug.cpu.nr_switches.min
    306253 ±  9%    +144.4%     748534 ±  3%  sched_debug.cpu.nr_switches.stddev
      5.90 ± 11%     +22.7%       7.24 ± 12%  sched_debug.cpu.nr_uninterruptible.stddev
      0.32           +88.3%       0.61 ± 11%  perf-stat.i.MPKI
 1.772e+10           -63.1%  6.533e+09 ±  2%  perf-stat.i.branch-instructions
      0.86 ±  3%      -0.3        0.55        perf-stat.i.branch-miss-rate%
 1.374e+08 ±  2%     -76.5%   32249763 ±  3%  perf-stat.i.branch-misses
     25.69 ±  5%     -13.0       12.66 ±  5%  perf-stat.i.cache-miss-rate%
  29425206           -30.4%   20491507 ± 10%  perf-stat.i.cache-misses
 1.105e+08 ±  5%     +46.2%  1.615e+08 ± 12%  perf-stat.i.cache-references
  11696956           -86.5%    1584573 ±  5%  perf-stat.i.context-switches
      2.49          +165.9%       6.61 ±  2%  perf-stat.i.cpi
      2682 ± 15%   +3544.5%      97753 ± 73%  perf-stat.i.cpu-migrations
      7982 ±  2%     +47.9%      11805 ± 10%  perf-stat.i.cycles-between-cache-misses
      0.24            -0.2        0.03 ± 19%  perf-stat.i.dTLB-load-miss-rate%
  58578477           -94.9%    2999773 ± 16%  perf-stat.i.dTLB-load-misses
 2.453e+10           -63.4%  8.967e+09 ±  3%  perf-stat.i.dTLB-loads
      0.11 ±  3%      -0.1        0.01 ± 22%  perf-stat.i.dTLB-store-miss-rate%
  16110645 ±  3%     -96.2%     618460 ± 20%  perf-stat.i.dTLB-store-misses
 1.441e+10           -65.4%  4.982e+09 ±  3%  perf-stat.i.dTLB-stores
 8.984e+10           -63.2%  3.304e+10 ±  3%  perf-stat.i.instructions
      0.43 ±  2%     -58.2%       0.18 ±  4%  perf-stat.i.ipc
    771.99 ±  2%     -67.7%     249.22 ±  8%  perf-stat.i.metric.K/sec
    886.72           -63.7%     322.11 ±  3%  perf-stat.i.metric.M/sec
     10557 ±  5%     -28.9%       7503 ±  2%  perf-stat.i.minor-faults
     68.85 ±  6%     +16.5       85.38 ±  2%  perf-stat.i.node-load-miss-rate%
   2492992 ± 16%     -72.9%     675588 ± 13%  perf-stat.i.node-loads
     84.88            -5.9       79.01 ±  2%  perf-stat.i.node-store-miss-rate%
  10676104 ±  3%     -50.4%    5294348 ±  5%  perf-stat.i.node-store-misses
     10558 ±  5%     -28.9%       7504 ±  2%  perf-stat.i.page-faults
      0.33           +89.5%       0.62 ± 11%  perf-stat.overall.MPKI
      0.78            -0.3        0.49        perf-stat.overall.branch-miss-rate%
     26.66 ±  5%     -13.9       12.72 ±  5%  perf-stat.overall.cache-miss-rate%
      2.42          +170.5%       6.55 ±  2%  perf-stat.overall.cpi
      7386           +44.4%      10667 ± 10%  perf-stat.overall.cycles-between-cache-misses
      0.24            -0.2        0.03 ± 18%  perf-stat.overall.dTLB-load-miss-rate%
      0.11 ±  3%      -0.1        0.01 ± 23%  perf-stat.overall.dTLB-store-miss-rate%
      0.41           -63.0%       0.15 ±  2%  perf-stat.overall.ipc
     65.40 ±  8%     +21.0       86.35 ±  3%  perf-stat.overall.node-load-miss-rate%
     82.36           -10.7       71.70 ±  2%  perf-stat.overall.node-store-miss-rate%
 1.742e+10           -63.1%  6.434e+09 ±  2%  perf-stat.ps.branch-instructions
 1.352e+08 ±  2%     -76.7%   31552895 ±  3%  perf-stat.ps.branch-misses
  28958605           -30.3%   20174319 ± 10%  perf-stat.ps.cache-misses
 1.089e+08 ±  5%     +46.3%  1.593e+08 ± 12%  perf-stat.ps.cache-references
  11523298           -86.4%    1563817 ±  5%  perf-stat.ps.context-switches
      2620 ± 15%   +3589.0%      96685 ± 74%  perf-stat.ps.cpu-migrations
  57759305           -94.9%    2957134 ± 16%  perf-stat.ps.dTLB-load-misses
 2.413e+10           -63.4%  8.835e+09 ±  3%  perf-stat.ps.dTLB-loads
  15880442 ±  3%     -96.2%     609839 ± 20%  perf-stat.ps.dTLB-store-misses
 1.417e+10           -65.4%  4.911e+09 ±  3%  perf-stat.ps.dTLB-stores
 8.835e+10           -63.2%  3.254e+10 ±  3%  perf-stat.ps.instructions
     10344 ±  6%     -29.6%       7280 ±  2%  perf-stat.ps.minor-faults
   2484298 ± 16%     -73.1%     667951 ± 13%  perf-stat.ps.node-loads
  10513724 ±  3%     -50.3%    5223127 ±  5%  perf-stat.ps.node-store-misses
     10345 ±  6%     -29.6%       7281 ±  2%  perf-stat.ps.page-faults
 5.612e+12           -63.4%  2.055e+12 ±  3%  perf-stat.total.instructions
      0.00 ±223%  +70400.0%       0.47 ± 39%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.00 ±223%  +79653.3%       1.99 ± 47%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±223%  +6.6e+05%       2.20 ± 69%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ±223%  +15548.9%       1.23 ± 20%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00 ±223%  +1.5e+05%       1.46 ± 17%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.31 ±223%    +732.4%       2.55 ± 37%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.00 ±223%  +61558.3%       1.23 ± 56%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.03 ±223%   +2718.5%       0.94 ± 19%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.00 ±223%  +86033.3%       0.86 ± 25%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ±223%   +1805.1%       0.19 ± 10%  perf-sched.sch_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.03 ±223%   +2747.4%       0.72 ± 36%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.01 ±223%  +1.9e+05%      11.24 ±148%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±223%  +3.1e+05%       4.18 ± 62%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%  +5.8e+05%      11.58 ± 42%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ±223%  +49755.4%       4.65 ± 60%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±223%  +3.3e+05%       4.89 ± 93%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.08 ±223%  +21410.1%      17.39 ± 34%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00 ±223%  +1.8e+05%       3.34 ± 14%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.00 ±223%  +1.8e+05%       6.39 ± 63%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.31 ±223%   +1225.7%       4.08 ±  9%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.00 ±223%  +2.1e+05%       2.84 ± 24%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.15 ±223%   +2375.4%       3.82 ±  9%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.49 ±223%  +1.4e+05%     664.31 ±166%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±223%   +3013.9%       0.19 ± 10%  perf-sched.total_sch_delay.average.ms
      0.03 ±223%   +1560.1%       0.58 ± 10%  perf-sched.total_wait_and_delay.average.ms
      0.03 ±223%   +1255.2%       0.39 ± 10%  perf-sched.total_wait_time.average.ms
     83.33 ±223%    +864.1%     803.38        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     10.12 ±223%   +2201.2%     232.95 ±  4%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.07 ±223%    +802.7%       9.65 ± 26%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.01 ±223%  +18894.3%       1.11 ±  7%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     41.00 ±223%    +954.7%     432.37 ±  8%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.31 ±223%    +782.3%       2.70 ± 33%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.04 ±223%    +869.8%       0.43 ± 10%  perf-sched.wait_and_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.33 ±223%    +735.7%     320.33        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.67 ±223%   +1400.0%      10.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.50 ±223%   +2193.9%     126.17        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      4.83 ±223%   +1227.6%      64.17 ± 11%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     84.50 ±223%   +6033.5%       5182 ± 10%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
     23.17 ±223%    +624.5%     167.83 ±  8%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.83 ±223%   +1641.2%      49.33 ± 17%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1.00 ±223%   +1800.0%      19.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.50 ±223%    +600.0%       3.50 ± 14%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      1.00 ±223%   +1083.3%      11.83 ±  9%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      4.67 ±223%   +1775.0%      87.50        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.67 ±223%   +2850.0%      19.67 ±  2%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
     16.00 ±223%   +2991.7%     494.67 ± 17%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     52.67 ±223%    +958.5%     557.50 ±  5%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     17.50 ±223%   +1452.4%     271.67 ±  4%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    166.71 ±223%    +806.2%       1510 ± 50%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00 ±223%  +16555.6%       0.50 ±159%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.01 ±223%   +1578.1%       0.20 ± 70%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.00 ±223%   +7083.3%       0.07 ±128%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
      0.00 ±223%   +2850.0%       0.03 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.00 ±223%   +9166.7%       0.37 ± 94%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      0.00 ±223%   +6157.1%       0.07 ±136%  perf-sched.wait_time.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     83.33 ±223%    +861.8%     801.38        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±223%  +3.6e+07%     652.15 ±  5%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     10.12 ±223%   +2190.9%     231.73 ±  4%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.00 ±223%    +551.9%       6.52 ±  4%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.12 ±223%   +6688.1%       8.34 ± 24%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.01 ±223%  +19450.0%       1.11 ±  7%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     31.33 ±223%   +1278.0%     431.77 ±  8%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.03 ±223%    +605.3%       0.25 ± 10%  perf-sched.wait_time.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ±223%  +81633.3%       0.82 ±176%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
      0.00 ±223%  +10075.0%       0.20 ± 49%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.00 ±223%  +23508.3%       0.94 ±144%  perf-sched.wait_time.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ±223%  +3.8e+07%       1003        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    166.71 ±223%    +804.7%       1508 ± 50%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    515.98 ±223%    +628.1%       3756 ± 13%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     26.90           -20.0        6.93 ± 12%  perf-profile.calltrace.cycles-pp.__sigsuspend
     24.82           -18.2        6.58 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sigsuspend
     24.72           -18.2        6.56 ± 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigsuspend
     18.74           -15.4        3.32 ±  9%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.10            -9.8        3.31 ±  9%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     11.05            -8.4        2.60 ±  9%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigsuspend
     10.79            -8.4        2.38 ± 10%  perf-profile.calltrace.cycles-pp.__send_signal_locked.do_send_sig_info.kill_pid_info.kill_something_info.__x64_sys_kill
     10.95            -8.4        2.58 ±  9%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigsuspend
     11.57            -8.0        3.52 ±  5%  perf-profile.calltrace.cycles-pp.do_send_sig_info.kill_pid_info.kill_something_info.__x64_sys_kill.do_syscall_64
     10.32            -7.1        3.26 ± 14%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigsuspend
      9.86            -6.7        3.18 ± 14%  perf-profile.calltrace.cycles-pp.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigsuspend
      6.64 ±  2%      -6.6        0.00        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
      6.56 ±  2%      -6.6        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
      9.66            -6.5        3.15 ± 14%  perf-profile.calltrace.cycles-pp.schedule.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.46            -6.4        3.10 ± 14%  perf-profile.calltrace.cycles-pp.__schedule.schedule.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64
      7.22            -5.5        1.73 ± 12%  perf-profile.calltrace.cycles-pp.complete_signal.__send_signal_locked.do_send_sig_info.kill_pid_info.kill_something_info
      5.37            -5.4        0.00        perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      5.21 ±  2%      -5.2        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      6.50            -5.0        1.55 ± 12%  perf-profile.calltrace.cycles-pp.try_to_wake_up.complete_signal.__send_signal_locked.do_send_sig_info.kill_pid_info
      6.61            -4.9        1.67 ± 10%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      5.19            -4.3        0.87 ±  7%  perf-profile.calltrace.cycles-pp.handle_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      4.88            -3.9        1.02 ± 11%  perf-profile.calltrace.cycles-pp.stress_sighandler_nop
      4.88            -3.8        1.09 ± 10%  perf-profile.calltrace.cycles-pp.dequeue_signal.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
      3.98            -3.1        0.85 ±  7%  perf-profile.calltrace.cycles-pp.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
      3.52            -2.8        0.76 ±  6%  perf-profile.calltrace.cycles-pp.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      2.97            -2.4        0.59 ± 46%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigsuspend
      2.46            -2.1        0.38 ± 71%  perf-profile.calltrace.cycles-pp.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.54            -2.0        0.50 ± 46%  perf-profile.calltrace.cycles-pp.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sigsuspend
      2.41            -2.0        0.38 ± 71%  perf-profile.calltrace.cycles-pp.__fpu_restore_sig.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64
      2.47            -2.0        0.46 ± 44%  perf-profile.calltrace.cycles-pp.copy_fpstate_to_sigframe.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart
      2.53            -1.8        0.71 ±  9%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.sigsuspend.__x64_sys_rt_sigsuspend
      2.54            -1.8        0.78 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.stress_sighandler_nop
      2.39            -1.6        0.74 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.36            -1.6        0.76 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sighandler_nop
      2.36            -1.6        0.76 ± 10%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sighandler_nop
      2.33            -1.6        0.74 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.34            -1.6        0.75 ± 10%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sighandler_nop
      2.23            -1.6        0.67 ± 10%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.40            -1.1        0.26 ±100%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.sigsuspend
      1.43 ±  3%      -1.0        0.44 ± 72%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.sigsuspend.__x64_sys_rt_sigsuspend
      1.19            -0.9        0.26 ±100%  perf-profile.calltrace.cycles-pp.set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.54 ±  2%      +0.1        0.60 ±  3%  perf-profile.calltrace.cycles-pp.profile_signal_perm.aa_may_signal.apparmor_task_kill.security_task_kill.kill_pid_info
      0.10 ±223%      +0.7        0.79 ±  6%  perf-profile.calltrace.cycles-pp.stress_time_now
      0.00            +0.8        0.80 ± 11%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.do_send_sig_info.kill_pid_info.kill_something_info.__x64_sys_kill
      0.00            +1.5        1.51 ± 35%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.62 ±  8%      +1.8        3.46 ±  8%  perf-profile.calltrace.cycles-pp.stress_atomic_lock_acquire
      0.20 ±142%      +3.1        3.28 ± 33%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.20 ±142%      +3.2        3.41 ± 33%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.21 ±142%      +3.2        3.42 ± 33%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.22 ±142%      +3.4        3.62 ± 33%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.46 ± 74%      +4.1        4.61 ± 31%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.46 ± 74%      +4.2        4.62 ± 31%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.46 ± 74%      +4.2        4.62 ± 31%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      0.46 ± 74%      +4.2        4.68 ± 32%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.09 ±223%      +4.2        4.34 ± 35%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     15.50            +9.7       25.24 ±  2%  perf-profile.calltrace.cycles-pp.aa_get_task_label.apparmor_task_kill.security_task_kill.kill_pid_info.kill_something_info
      3.27           +10.4       13.68 ±  5%  perf-profile.calltrace.cycles-pp.aa_may_signal.apparmor_task_kill.security_task_kill.kill_pid_info.kill_something_info
     59.43           +21.0       80.45        perf-profile.calltrace.cycles-pp.kill
     57.84           +22.1       79.92        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.kill
     57.49           +22.3       79.76        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
     50.66           +28.8       79.47        perf-profile.calltrace.cycles-pp.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
     49.95           +29.0       78.92        perf-profile.calltrace.cycles-pp.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
     49.38           +29.1       78.46        perf-profile.calltrace.cycles-pp.kill_pid_info.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.42           +37.1       74.56        perf-profile.calltrace.cycles-pp.security_task_kill.kill_pid_info.kill_something_info.__x64_sys_kill.do_syscall_64
     37.19           +37.3       74.46        perf-profile.calltrace.cycles-pp.apparmor_task_kill.security_task_kill.kill_pid_info.kill_something_info.__x64_sys_kill
     27.08           -20.1        6.96 ± 11%  perf-profile.children.cycles-pp.__sigsuspend
     20.11           -16.6        3.55 ±  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     19.95           -16.5        3.44 ±  9%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
     18.82           -15.5        3.36 ±  9%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
     15.14           -12.0        3.18 ± 14%  perf-profile.children.cycles-pp.schedule
     14.94           -11.1        3.79 ±  8%  perf-profile.children.cycles-pp.__schedule
     13.12            -9.8        3.31 ±  9%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
     10.83            -8.4        2.41 ±  9%  perf-profile.children.cycles-pp.__send_signal_locked
     11.62            -8.0        3.57 ±  5%  perf-profile.children.cycles-pp.do_send_sig_info
     10.53            -7.3        3.27 ± 14%  perf-profile.children.cycles-pp.__x64_sys_rt_sigsuspend
      9.88            -6.7        3.19 ± 14%  perf-profile.children.cycles-pp.sigsuspend
      7.24            -5.5        1.74 ± 11%  perf-profile.children.cycles-pp.complete_signal
      6.55            -5.0        1.55 ± 12%  perf-profile.children.cycles-pp.try_to_wake_up
      6.64            -5.0        1.68 ± 10%  perf-profile.children.cycles-pp.get_signal
      5.20            -4.1        1.13 ±  7%  perf-profile.children.cycles-pp.handle_signal
      5.24            -3.9        1.34 ± 12%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      4.90            -3.8        1.10 ± 10%  perf-profile.children.cycles-pp.dequeue_signal
      3.84            -3.3        0.58 ± 15%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      4.23            -3.2        1.06 ± 11%  perf-profile.children.cycles-pp.stress_sighandler_nop
      4.02            -3.2        0.86 ±  7%  perf-profile.children.cycles-pp.x64_setup_rt_frame
      3.22            -2.9        0.32 ±  9%  perf-profile.children.cycles-pp.__sigqueue_alloc
      3.30            -2.8        0.46 ± 10%  perf-profile.children.cycles-pp.collect_signal
      3.54            -2.8        0.76 ±  6%  perf-profile.children.cycles-pp.get_sigframe
      3.48            -2.7        0.82 ± 11%  perf-profile.children.cycles-pp.ttwu_do_activate
      2.96            -2.6        0.34 ± 11%  perf-profile.children.cycles-pp.do_dec_rlimit_put_ucounts
      3.18            -2.5        0.68 ± 17%  perf-profile.children.cycles-pp.restore_sigcontext
      3.00            -2.3        0.68 ± 20%  perf-profile.children.cycles-pp.pick_next_task_fair
      2.46 ±  2%      -2.3        0.15 ± 15%  perf-profile.children.cycles-pp.inc_rlimit_get_ucounts
      2.66            -2.0        0.69 ±  9%  perf-profile.children.cycles-pp.activate_task
      2.51            -2.0        0.55 ±  7%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      2.54            -1.9        0.60 ± 11%  perf-profile.children.cycles-pp.enqueue_task_fair
      2.47            -1.9        0.53 ± 15%  perf-profile.children.cycles-pp.fpu__restore_sig
      2.43            -1.9        0.52 ± 15%  perf-profile.children.cycles-pp.__fpu_restore_sig
      2.56            -1.8        0.72 ±  9%  perf-profile.children.cycles-pp.dequeue_task_fair
      2.01            -1.6        0.46 ± 13%  perf-profile.children.cycles-pp.update_load_avg
      1.80            -1.5        0.34 ± 20%  perf-profile.children.cycles-pp.update_curr
      2.00            -1.4        0.64 ±  8%  perf-profile.children.cycles-pp.recalc_sigpending
      1.65            -1.3        0.38 ± 15%  perf-profile.children.cycles-pp.restore_fpregs_from_user
      1.29            -1.1        0.15 ± 10%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      1.27 ±  2%      -1.1        0.18 ± 17%  perf-profile.children.cycles-pp._copy_from_user
      1.33 ±  2%      -1.1        0.28 ±  7%  perf-profile.children.cycles-pp.stress_sigsuspend
      1.44 ±  2%      -1.0        0.40 ± 10%  perf-profile.children.cycles-pp.enqueue_entity
      1.34 ±  7%      -1.0        0.30 ± 60%  perf-profile.children.cycles-pp.reader__read_event
      1.34 ±  7%      -1.0        0.32 ± 57%  perf-profile.children.cycles-pp.record__finish_output
      1.34 ±  7%      -1.0        0.32 ± 57%  perf-profile.children.cycles-pp.perf_session__process_events
      1.36 ±  7%      -1.0        0.36 ± 56%  perf-profile.children.cycles-pp.__cmd_record
      1.63            -1.0        0.62 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.45            -0.9        0.50 ±  8%  perf-profile.children.cycles-pp.dequeue_entity
      1.25            -0.9        0.32 ±  8%  perf-profile.children.cycles-pp.__switch_to
      1.14 ±  3%      -0.9        0.29 ± 23%  perf-profile.children.cycles-pp.set_next_entity
      1.06            -0.8        0.26 ±  6%  perf-profile.children.cycles-pp.native_irq_return_iret
      1.05            -0.8        0.26 ± 11%  perf-profile.children.cycles-pp.fpu__clear_user_states
      1.10 ±  2%      -0.8        0.33 ±  5%  perf-profile.children.cycles-pp.prepare_task_switch
      0.86 ±  4%      -0.8        0.10 ± 55%  perf-profile.children.cycles-pp.process_simple
      0.84 ±  4%      -0.8        0.09 ± 56%  perf-profile.children.cycles-pp.queue_event
      0.84 ±  4%      -0.7        0.09 ± 58%  perf-profile.children.cycles-pp.ordered_events__queue
      1.21            -0.7        0.48 ±  8%  perf-profile.children.cycles-pp.set_current_blocked
      1.03 ±  3%      -0.7        0.36 ± 25%  perf-profile.children.cycles-pp.select_task_rq
      1.44            -0.7        0.78 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock
      0.74            -0.7        0.08 ± 48%  perf-profile.children.cycles-pp.pick_eevdf
      1.08            -0.7        0.42 ± 10%  perf-profile.children.cycles-pp.__set_current_blocked
      1.13            -0.7        0.48 ± 10%  perf-profile.children.cycles-pp.signal_setup_done
      0.78 ±  3%      -0.6        0.14 ± 25%  perf-profile.children.cycles-pp.reweight_entity
      0.72            -0.6        0.08 ± 14%  perf-profile.children.cycles-pp.os_xsave
      0.74            -0.6        0.10 ±  7%  perf-profile.children.cycles-pp.__switch_to_asm
      0.76            -0.6        0.13 ± 24%  perf-profile.children.cycles-pp.check_preempt_curr
      0.74 ±  2%      -0.6        0.13 ± 10%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.77            -0.6        0.18 ±  7%  perf-profile.children.cycles-pp.save_xstate_epilog
      0.92 ±  3%      -0.6        0.33 ± 27%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.88            -0.5        0.33 ± 12%  perf-profile.children.cycles-pp.fpregs_mark_activate
      0.71            -0.5        0.16 ±  8%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.79 ±  3%      -0.5        0.25 ±  7%  perf-profile.children.cycles-pp.___perf_sw_event
      0.56            -0.5        0.03 ±100%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.64 ±  2%      -0.5        0.14 ± 13%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.68            -0.5        0.19 ± 10%  perf-profile.children.cycles-pp.kmem_cache_free
      0.57 ±  6%      -0.4        0.16 ± 47%  perf-profile.children.cycles-pp.select_idle_sibling
      0.46            -0.4        0.08 ± 20%  perf-profile.children.cycles-pp.check_xstate_in_sigframe
      0.55 ±  6%      -0.3        0.20 ± 33%  perf-profile.children.cycles-pp.__dequeue_entity
      0.38 ±  2%      -0.3        0.06 ± 14%  perf-profile.children.cycles-pp.__get_user_nocheck_4
      0.40 ±  2%      -0.3        0.09 ±  7%  perf-profile.children.cycles-pp.update_rq_clock
      0.41            -0.3        0.10 ± 13%  perf-profile.children.cycles-pp.restore_altstack
      0.37            -0.3        0.06 ± 11%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.56 ±  3%      -0.3        0.26 ±  6%  perf-profile.children.cycles-pp.clock_gettime
      0.32 ±  4%      -0.3        0.04 ± 71%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.34 ±  4%      -0.3        0.06 ± 13%  perf-profile.children.cycles-pp.update_cfs_group
      0.33 ±  5%      -0.3        0.05 ± 47%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.29            -0.3        0.03 ±100%  perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.31 ±  6%      -0.3        0.06 ± 46%  perf-profile.children.cycles-pp.update_min_vruntime
      0.42 ± 14%      -0.2        0.17 ± 67%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.28            -0.2        0.04 ± 71%  perf-profile.children.cycles-pp.place_entity
      0.28            -0.2        0.05 ± 46%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.26 ±  5%      -0.2        0.03 ± 70%  perf-profile.children.cycles-pp.__enqueue_entity
      0.42 ± 14%      -0.2        0.19 ± 61%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.32 ±  2%      -0.2        0.10 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.62 ±  2%      -0.2        0.40        perf-profile.children.cycles-pp.__entry_text_start
      0.28 ±  2%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.sched_clock
      0.38 ±  6%      -0.2        0.20 ± 19%  perf-profile.children.cycles-pp.stress_lock_acquire
      0.26            -0.2        0.10 ± 44%  perf-profile.children.cycles-pp.resched_curr
      0.26            -0.2        0.09 ±  7%  perf-profile.children.cycles-pp.native_sched_clock
      0.35 ± 15%      -0.2        0.18 ± 62%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.23            -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.25 ±  5%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.from_kuid_munged
      0.20 ±  5%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.cpuacct_charge
      0.18 ± 13%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.evlist__parse_sample
      0.22 ± 10%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.clock_gettime@plt
      0.41            -0.1        0.29 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.22 ±  2%      -0.1        0.11        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.13 ±  2%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.refill_obj_stock
      0.15 ±  7%      -0.1        0.05 ± 73%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.14 ±  7%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.rb_next
      0.12 ± 15%      -0.1        0.05 ± 46%  perf-profile.children.cycles-pp.perf_exclude_event
      0.14 ±  3%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.audit_signal_info_syscall
      0.09 ±  9%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.perf_swevent_event
      0.36 ±  4%      -0.1        0.30 ±  6%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.17 ±  4%      -0.1        0.11 ± 12%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.15 ±  3%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.12 ±  3%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.10 ±  4%      -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.find_vpid
      0.12 ±  6%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.map_id_up
      0.09 ± 13%      -0.0        0.05 ± 48%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.30            +0.0        0.33 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.16 ±  3%      +0.0        0.21 ±  4%  perf-profile.children.cycles-pp.prepare_signal
      0.55 ±  2%      +0.1        0.62 ±  3%  perf-profile.children.cycles-pp.profile_signal_perm
      0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.menu_select
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.task_h_load
      0.12 ±  5%      +0.1        0.20 ± 27%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.00            +0.1        0.08 ± 35%  perf-profile.children.cycles-pp.irqentry_exit
      0.00            +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.newidle_balance
      0.00            +0.1        0.09 ± 38%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.00            +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.wake_affine
      0.01 ±223%      +0.2        0.21 ± 35%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.04 ± 77%      +0.2        0.25 ± 12%  perf-profile.children.cycles-pp.__slab_free
      0.60 ± 11%      +0.3        0.86 ±  5%  perf-profile.children.cycles-pp.stress_time_now
      0.02 ±144%      +0.3        0.34 ± 33%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.05 ± 75%      +0.6        0.63 ± 41%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.06 ± 74%      +0.6        0.66 ± 25%  perf-profile.children.cycles-pp.schedule_idle
      0.07 ± 53%      +0.7        0.81 ± 38%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.07 ± 55%      +0.7        0.82 ± 38%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.09 ± 55%      +0.9        0.96 ± 37%  perf-profile.children.cycles-pp.sysvec_call_function_single
      1.74 ±  9%      +2.0        3.72 ±  8%  perf-profile.children.cycles-pp.stress_atomic_lock_acquire
      0.34 ± 46%      +2.5        2.86 ± 35%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.38 ± 47%      +2.9        3.32 ± 35%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.38 ± 46%      +2.9        3.33 ± 35%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.40 ± 47%      +3.1        3.46 ± 35%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.40 ± 47%      +3.1        3.47 ± 35%  perf-profile.children.cycles-pp.cpuidle_enter
      0.43 ± 47%      +3.2        3.66 ± 34%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.54 ± 47%      +4.1        4.62 ± 31%  perf-profile.children.cycles-pp.start_secondary
      0.54 ± 47%      +4.1        4.68 ± 32%  perf-profile.children.cycles-pp.do_idle
      0.54 ± 47%      +4.1        4.68 ± 32%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.54 ± 47%      +4.1        4.68 ± 32%  perf-profile.children.cycles-pp.cpu_startup_entry
     15.51            +9.7       25.25 ±  2%  perf-profile.children.cycles-pp.aa_get_task_label
      3.30           +10.4       13.71 ±  5%  perf-profile.children.cycles-pp.aa_may_signal
     59.72           +21.0       80.71        perf-profile.children.cycles-pp.kill
     50.68           +28.8       79.50        perf-profile.children.cycles-pp.__x64_sys_kill
     49.98           +29.0       78.95        perf-profile.children.cycles-pp.kill_something_info
     49.41           +29.1       78.50        perf-profile.children.cycles-pp.kill_pid_info
     37.43           +37.1       74.57        perf-profile.children.cycles-pp.security_task_kill
     37.22           +37.3       74.50        perf-profile.children.cycles-pp.apparmor_task_kill
      3.80            -3.2        0.58 ± 15%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      2.95            -2.6        0.34 ± 11%  perf-profile.self.cycles-pp.do_dec_rlimit_put_ucounts
      2.46 ±  2%      -2.3        0.14 ± 14%  perf-profile.self.cycles-pp.inc_rlimit_get_ucounts
      1.98            -1.4        0.63 ±  8%  perf-profile.self.cycles-pp.recalc_sigpending
      1.73            -1.2        0.54 ±  9%  perf-profile.self.cycles-pp.__schedule
      1.27            -1.1        0.14 ± 10%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      1.40            -1.0        0.36 ±  8%  perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
      1.61            -1.0        0.60 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      1.23 ±  2%      -1.0        0.23 ±  5%  perf-profile.self.cycles-pp.stress_sigsuspend
      1.15            -1.0        0.19 ± 15%  perf-profile.self.cycles-pp.restore_fpregs_from_user
      1.39 ±  2%      -0.9        0.46 ± 16%  perf-profile.self.cycles-pp._raw_spin_lock
      1.22            -0.9        0.31 ±  8%  perf-profile.self.cycles-pp.__switch_to
      1.07            -0.9        0.18 ± 16%  perf-profile.self.cycles-pp._copy_from_user
      1.06            -0.8        0.26 ±  6%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.79 ±  4%      -0.7        0.08 ± 59%  perf-profile.self.cycles-pp.queue_event
      0.72            -0.6        0.08 ± 15%  perf-profile.self.cycles-pp.os_xsave
      0.73            -0.6        0.10 ±  6%  perf-profile.self.cycles-pp.__switch_to_asm
      0.68            -0.6        0.11 ± 13%  perf-profile.self.cycles-pp.fpu__clear_user_states
      0.67 ±  2%      -0.6        0.12 ± 11%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.66 ±  2%      -0.5        0.12 ± 19%  perf-profile.self.cycles-pp.update_curr
      0.68            -0.5        0.16 ± 18%  perf-profile.self.cycles-pp.update_load_avg
      0.83            -0.5        0.31 ± 13%  perf-profile.self.cycles-pp.fpregs_mark_activate
      0.63 ±  2%      -0.5        0.13 ± 16%  perf-profile.self.cycles-pp.complete_signal
      0.77            -0.5        0.26 ± 10%  perf-profile.self.cycles-pp.get_signal
      0.64            -0.5        0.16 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.60 ±  2%      -0.5        0.14 ± 15%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.52            -0.5        0.06 ± 48%  perf-profile.self.cycles-pp.pick_eevdf
      0.50 ±  3%      -0.4        0.07 ±  5%  perf-profile.self.cycles-pp.__sigsuspend
      0.58            -0.4        0.16 ± 14%  perf-profile.self.cycles-pp.___perf_sw_event
      0.48            -0.4        0.10 ± 21%  perf-profile.self.cycles-pp.x64_setup_rt_frame
      0.48            -0.3        0.15 ± 19%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.41 ±  4%      -0.3        0.10 ± 19%  perf-profile.self.cycles-pp.reweight_entity
      0.36            -0.3        0.06 ± 13%  perf-profile.self.cycles-pp.__get_user_nocheck_4
      0.35 ±  2%      -0.3        0.06 ± 14%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.32            -0.3        0.05 ± 47%  perf-profile.self.cycles-pp.__fpu_restore_sig
      0.31 ±  4%      -0.3        0.04 ± 71%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.32 ±  5%      -0.3        0.06 ± 13%  perf-profile.self.cycles-pp.update_cfs_group
      0.27            -0.2        0.02 ± 99%  perf-profile.self.cycles-pp.__put_user_nocheck_4
      0.29 ±  6%      -0.2        0.06 ± 47%  perf-profile.self.cycles-pp.update_min_vruntime
      0.35 ±  6%      -0.2        0.12 ± 32%  perf-profile.self.cycles-pp.__dequeue_entity
      0.27            -0.2        0.05 ± 47%  perf-profile.self.cycles-pp.check_xstate_in_sigframe
      0.33            -0.2        0.11 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      0.25 ±  5%      -0.2        0.03 ± 70%  perf-profile.self.cycles-pp.__enqueue_entity
      0.26 ±  2%      -0.2        0.05 ± 46%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.30 ±  2%      -0.2        0.09 ± 13%  perf-profile.self.cycles-pp.prepare_task_switch
      0.30 ±  2%      -0.2        0.09 ± 20%  perf-profile.self.cycles-pp.save_xstate_epilog
      0.29 ±  4%      -0.2        0.09 ±  9%  perf-profile.self.cycles-pp.kmem_cache_free
      0.25            -0.2        0.08 ±  8%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.24 ±  2%      -0.2        0.08 ±  8%  perf-profile.self.cycles-pp.native_sched_clock
      0.25            -0.2        0.08 ± 14%  perf-profile.self.cycles-pp.enqueue_entity
      0.38 ±  7%      -0.2        0.21 ±  6%  perf-profile.self.cycles-pp.clock_gettime
      0.26 ±  2%      -0.2        0.09 ± 45%  perf-profile.self.cycles-pp.resched_curr
      0.35 ±  5%      -0.2        0.18 ± 20%  perf-profile.self.cycles-pp.stress_lock_acquire
      0.23 ±  2%      -0.2        0.06 ± 47%  perf-profile.self.cycles-pp.restore_sigcontext
      0.18 ±  8%      -0.1        0.04 ± 72%  perf-profile.self.cycles-pp.set_next_entity
      0.22 ±  2%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.21            -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.security_task_kill
      0.23            -0.1        0.09 ± 14%  perf-profile.self.cycles-pp.dequeue_entity
      0.19 ±  6%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.cpuacct_charge
      0.19 ±  4%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.40 ±  2%      -0.1        0.28 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.20 ±  2%      -0.1        0.09 ± 16%  perf-profile.self.cycles-pp.try_to_wake_up
      0.22 ±  2%      -0.1        0.11        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.13 ±  2%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.refill_obj_stock
      0.23 ±  3%      -0.1        0.13 ±  5%  perf-profile.self.cycles-pp.__entry_text_start
      0.12 ±  8%      -0.1        0.04 ± 72%  perf-profile.self.cycles-pp.rb_next
      0.12 ± 10%      -0.1        0.05 ± 75%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.14 ±  3%      -0.1        0.07 ± 15%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.10 ±  3%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.36 ±  3%      -0.1        0.28 ±  2%  perf-profile.self.cycles-pp.kill
      0.13 ±  5%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.audit_signal_info_syscall
      0.10 ±  4%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.find_vpid
      0.16 ±  3%      -0.1        0.08 ± 13%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.12 ± 13%      -0.1        0.05 ± 46%  perf-profile.self.cycles-pp.perf_exclude_event
      0.20 ±  2%      -0.1        0.14        perf-profile.self.cycles-pp.__send_signal_locked
      0.35 ±  4%      -0.1        0.29 ±  6%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.15 ±  2%      -0.1        0.09 ± 19%  perf-profile.self.cycles-pp.finish_task_switch
      0.14 ±  3%      -0.1        0.09 ± 20%  perf-profile.self.cycles-pp.collect_signal
      0.12 ±  3%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.13 ±  3%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.map_id_up
      0.15 ±  2%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.prepare_signal
      0.08 ±  4%      +0.1        0.14 ±  9%  perf-profile.self.cycles-pp.check_kill_permission
      0.53 ±  2%      +0.1        0.60 ±  3%  perf-profile.self.cycles-pp.profile_signal_perm
      0.00            +0.1        0.08 ± 24%  perf-profile.self.cycles-pp.task_h_load
      0.46 ±  8%      +0.1        0.57 ±  5%  perf-profile.self.cycles-pp.stress_time_now
      0.00            +0.1        0.13 ± 28%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.00            +0.2        0.18 ± 32%  perf-profile.self.cycles-pp.do_idle
      0.01 ±223%      +0.2        0.21 ± 35%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.04 ± 77%      +0.2        0.25 ± 12%  perf-profile.self.cycles-pp.__slab_free
      0.02 ±144%      +0.3        0.34 ± 33%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.68 ±  9%      +2.0        3.66 ±  8%  perf-profile.self.cycles-pp.stress_atomic_lock_acquire
      0.26 ± 48%      +2.1        2.34 ± 31%  perf-profile.self.cycles-pp.acpi_safe_halt
     15.45            +9.7       25.17 ±  2%  perf-profile.self.cycles-pp.aa_get_task_label
      2.75 ±  2%     +10.3       13.06 ±  5%  perf-profile.self.cycles-pp.aa_may_signal
     18.36           +17.1       35.44        perf-profile.self.cycles-pp.apparmor_task_kill



***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  network/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/sock/stress-ng/60s

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      9220 ± 10%     -25.4%       6878 ±  4%  perf-c2c.DRAM.local
    427.50 ± 15%     +25.0%     534.50 ±  9%  perf-c2c.DRAM.remote
   8687407 ±  2%     -60.8%    3401817        vmstat.memory.cache
   9104079           -99.2%      76005 ±  3%  vmstat.system.cs
      1.42            +0.5        1.88        mpstat.cpu.all.irq%
     21.66            -6.5       15.13        mpstat.cpu.all.soft%
     66.59            +6.9       73.48        mpstat.cpu.all.sys%
      4.74            -1.3        3.41        mpstat.cpu.all.usr%
  36698401          +100.4%   73530845        numa-numastat.node0.local_node
  36743603          +100.2%   73556209        numa-numastat.node0.numa_hit
  39746823           +86.6%   74187371        numa-numastat.node1.local_node
  39767761           +86.6%   74219438        numa-numastat.node1.numa_hit
      3480            -4.1%       3337        turbostat.Bzy_MHz
      0.27 ±  9%     -23.9%       0.21 ±  7%  turbostat.IPC
    164.36 ±  2%     +20.5      184.86        turbostat.PKG_%
    111.21           +43.3%     159.31        turbostat.RAMWatt
    179.40 ±  3%     +10.4%     198.05 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
      6.93 ± 10%     -44.8%       3.83 ±  3%  sched_debug.cpu.clock.stddev
      1010 ±  2%     -11.1%     897.55        sched_debug.cpu.clock_task.stddev
   4417021           -99.1%      40112 ±  2%  sched_debug.cpu.nr_switches.avg
   4633822           -98.0%      92783 ± 11%  sched_debug.cpu.nr_switches.max
   3155274 ±  5%     -99.0%      31120 ±  7%  sched_debug.cpu.nr_switches.min
    257878 ±  8%     -96.5%       8984 ± 22%  sched_debug.cpu.nr_switches.stddev
   1463496           +59.6%    2335111        stress-ng.sock.ops
     24393           +59.4%      38886        stress-ng.sock.ops_per_sec
 2.963e+08          -100.0%      23120 ± 24%  stress-ng.time.involuntary_context_switches
      4579            +9.4%       5011        stress-ng.time.percent_of_cpu_this_job_got
      2704           +11.0%       3002        stress-ng.time.system_time
    138.93           -18.5%     113.20        stress-ng.time.user_time
 2.994e+08           -98.4%    4779638        stress-ng.time.voluntary_context_switches
     13292 ± 22%    +516.9%      81996 ± 49%  numa-meminfo.node0.Active
     13244 ± 22%    +518.4%      81900 ± 49%  numa-meminfo.node0.Active(anon)
    127398 ± 11%     -50.7%      62800 ± 29%  numa-meminfo.node0.Mapped
     19753 ± 17%    +460.4%     110688 ± 50%  numa-meminfo.node0.Shmem
     95378 ±  4%    +224.5%     309529 ± 11%  numa-meminfo.node1.Active
     95282 ±  4%    +224.8%     309481 ± 11%  numa-meminfo.node1.Active(anon)
   7381585 ± 15%     -67.7%    2382225 ± 39%  numa-meminfo.node1.FilePages
   5922737 ±  3%     -93.6%     379656 ±  9%  numa-meminfo.node1.Inactive
   5922599 ±  3%     -93.6%     379587 ±  9%  numa-meminfo.node1.Inactive(anon)
   1547876 ±  3%     -92.1%     122727 ± 24%  numa-meminfo.node1.Mapped
   8342373 ± 13%     -60.7%    3280359 ± 29%  numa-meminfo.node1.MemUsed
   5768899 ±  3%     -92.5%     435300 ± 12%  numa-meminfo.node1.Shmem
    108530 ±  5%    +260.3%     391084 ±  4%  meminfo.Active
    108386 ±  5%    +260.7%     390940 ±  4%  meminfo.Active(anon)
   8531615 ±  2%     -61.4%    3291104        meminfo.Cached
   7676613 ±  2%     -69.5%    2344739        meminfo.Committed_AS
   6180671 ±  3%     -90.5%     586262 ± 12%  meminfo.Inactive
   6180462 ±  3%     -90.5%     586052 ± 12%  meminfo.Inactive(anon)
    113439           -10.2%     101831        meminfo.KReclaimable
   1670440 ±  3%     -89.0%     183788 ±  9%  meminfo.Mapped
  10473614 ±  2%     -52.0%    5029882        meminfo.Memused
     16325           -17.2%      13525 ±  2%  meminfo.PageTables
    113439           -10.2%     101831        meminfo.SReclaimable
   5785468 ±  3%     -90.6%     544897        meminfo.Shmem
  10520180 ±  2%     -50.7%    5182942        meminfo.max_used_kB
      3322 ± 22%    +515.8%      20463 ± 49%  numa-vmstat.node0.nr_active_anon
     31835 ± 11%     -50.6%      15735 ± 28%  numa-vmstat.node0.nr_mapped
      4942 ± 17%    +459.9%      27672 ± 50%  numa-vmstat.node0.nr_shmem
      3322 ± 22%    +515.8%      20463 ± 49%  numa-vmstat.node0.nr_zone_active_anon
  36743650          +100.2%   73556294        numa-vmstat.node0.numa_hit
  36698448          +100.4%   73530930        numa-vmstat.node0.numa_local
     23867 ±  4%    +224.0%      77337 ± 11%  numa-vmstat.node1.nr_active_anon
   1845745 ± 15%     -67.7%     595578 ± 39%  numa-vmstat.node1.nr_file_pages
   1480927 ±  3%     -93.6%      95003 ±  9%  numa-vmstat.node1.nr_inactive_anon
    387463 ±  3%     -92.1%      30744 ± 24%  numa-vmstat.node1.nr_mapped
   1442574 ±  3%     -92.5%     108847 ± 12%  numa-vmstat.node1.nr_shmem
     23867 ±  4%    +224.0%      77337 ± 11%  numa-vmstat.node1.nr_zone_active_anon
   1480926 ±  3%     -93.6%      95002 ±  9%  numa-vmstat.node1.nr_zone_inactive_anon
  39767712           +86.6%   74219234        numa-vmstat.node1.numa_hit
  39746773           +86.6%   74187167        numa-vmstat.node1.numa_local
     27114 ±  5%    +261.7%      98078 ±  4%  proc-vmstat.nr_active_anon
   6294668            +2.2%    6430570        proc-vmstat.nr_dirty_background_threshold
  12604727            +2.2%   12876865        proc-vmstat.nr_dirty_threshold
   2132985 ±  2%     -61.4%     823062        proc-vmstat.nr_file_pages
  63323676            +2.1%   64684697        proc-vmstat.nr_free_pages
   1545180 ±  3%     -90.5%     146386 ± 12%  proc-vmstat.nr_inactive_anon
    417921 ±  3%     -89.0%      45993 ± 10%  proc-vmstat.nr_mapped
      4079           -17.3%       3374 ±  2%  proc-vmstat.nr_page_table_pages
   1446446 ±  3%     -90.6%     136509        proc-vmstat.nr_shmem
     28359           -10.2%      25459        proc-vmstat.nr_slab_reclaimable
     27114 ±  5%    +261.7%      98078 ±  4%  proc-vmstat.nr_zone_active_anon
   1545180 ±  3%     -90.5%     146386 ± 12%  proc-vmstat.nr_zone_inactive_anon
    191857 ±  8%     -73.2%      51331        proc-vmstat.numa_hint_faults
    141647 ± 11%     -74.9%      35486 ±  6%  proc-vmstat.numa_hint_faults_local
  76513548           +93.1%  1.478e+08        proc-vmstat.numa_hit
  76447407           +93.2%  1.477e+08        proc-vmstat.numa_local
     56551 ±  8%    +248.0%     196817        proc-vmstat.pgactivate
 5.946e+08           +98.0%  1.178e+09        proc-vmstat.pgalloc_normal
    653661 ±  2%     -30.8%     452095        proc-vmstat.pgfault
 5.924e+08           +98.7%  1.177e+09        proc-vmstat.pgfree
      2.54 ±  2%    +247.7%       8.83        perf-stat.i.MPKI
 3.162e+10           -26.2%  2.333e+10        perf-stat.i.branch-instructions
      1.01            -0.4        0.59        perf-stat.i.branch-miss-rate%
 3.007e+08           -58.0%  1.264e+08        perf-stat.i.branch-misses
     24.80           +12.5       37.26        perf-stat.i.cache-miss-rate%
 4.154e+08 ±  2%    +171.4%  1.127e+09        perf-stat.i.cache-misses
 1.629e+09           +80.7%  2.943e+09        perf-stat.i.cache-references
   9543474           -99.2%      79674 ±  3%  perf-stat.i.context-switches
      1.30           +24.7%       1.61        perf-stat.i.cpi
 2.111e+11            -4.5%  2.015e+11        perf-stat.i.cpu-cycles
    665.75 ±  2%     -54.4%     303.29 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.01 ±  3%      -0.0        0.00 ±  5%  perf-stat.i.dTLB-load-miss-rate%
   5000927 ±  3%     -81.4%     930683 ±  4%  perf-stat.i.dTLB-load-misses
 4.595e+10           -23.9%  3.498e+10        perf-stat.i.dTLB-loads
      0.00 ±  2%      +0.0        0.02        perf-stat.i.dTLB-store-miss-rate%
   1050765 ±  2%    +349.6%    4723978        perf-stat.i.dTLB-store-misses
 2.687e+10           -24.6%  2.027e+10        perf-stat.i.dTLB-stores
 1.642e+11           -24.7%  1.236e+11        perf-stat.i.instructions
      0.78           -20.2%       0.62        perf-stat.i.ipc
      3.30            -4.5%       3.15        perf-stat.i.metric.GHz
    376.37 ±  2%     -38.2%     232.62 ±  2%  perf-stat.i.metric.K/sec
      1661           -22.6%       1285        perf-stat.i.metric.M/sec
      8755 ±  2%     -36.2%       5589        perf-stat.i.minor-faults
      5.44 ±  7%      -1.6        3.84 ±  3%  perf-stat.i.node-load-miss-rate%
   3394831 ±  7%     +56.4%    5310095 ±  3%  perf-stat.i.node-load-misses
 1.121e+08 ±  5%    +175.7%  3.092e+08        perf-stat.i.node-loads
      2.17 ± 14%      -0.7        1.42 ± 11%  perf-stat.i.node-store-miss-rate%
   2041975 ± 10%     +79.2%    3658647 ±  7%  perf-stat.i.node-store-misses
 1.731e+08          +173.3%  4.732e+08        perf-stat.i.node-stores
      8756 ±  2%     -36.2%       5589        perf-stat.i.page-faults
      2.53 ±  2%    +260.2%       9.13        perf-stat.overall.MPKI
      0.95            -0.4        0.54        perf-stat.overall.branch-miss-rate%
     25.51           +12.8       38.31        perf-stat.overall.cache-miss-rate%
      1.29           +26.8%       1.63        perf-stat.overall.cpi
    507.86 ±  2%     -64.8%     178.74        perf-stat.overall.cycles-between-cache-misses
      0.01 ±  3%      -0.0        0.00 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  2%      +0.0        0.02        perf-stat.overall.dTLB-store-miss-rate%
      0.78           -21.2%       0.61        perf-stat.overall.ipc
      2.95 ± 13%      -1.3        1.69 ±  3%  perf-stat.overall.node-load-miss-rate%
      1.17 ± 10%      -0.4        0.77 ±  7%  perf-stat.overall.node-store-miss-rate%
  3.11e+10           -26.1%  2.299e+10        perf-stat.ps.branch-instructions
 2.959e+08           -58.0%  1.243e+08        perf-stat.ps.branch-misses
 4.092e+08 ±  2%    +171.7%  1.112e+09        perf-stat.ps.cache-misses
 1.604e+09           +80.9%  2.902e+09        perf-stat.ps.cache-references
   9393169           -99.2%      78457 ±  3%  perf-stat.ps.context-switches
 2.077e+11            -4.3%  1.987e+11        perf-stat.ps.cpu-cycles
   4918971 ±  3%     -81.6%     904508 ±  4%  perf-stat.ps.dTLB-load-misses
 4.521e+10           -23.7%  3.448e+10        perf-stat.ps.dTLB-loads
   1036059 ±  2%    +349.2%    4653866        perf-stat.ps.dTLB-store-misses
 2.644e+10           -24.4%  1.998e+10        perf-stat.ps.dTLB-stores
 1.615e+11           -24.6%  1.218e+11        perf-stat.ps.instructions
      8588           -36.7%       5440        perf-stat.ps.minor-faults
   3340433 ±  7%     +56.8%    5237317 ±  3%  perf-stat.ps.node-load-misses
 1.105e+08 ±  5%    +176.1%  3.051e+08        perf-stat.ps.node-loads
   2010110 ± 10%     +79.6%    3611038 ±  7%  perf-stat.ps.node-store-misses
 1.705e+08          +173.6%  4.664e+08        perf-stat.ps.node-stores
      8588           -36.7%       5440        perf-stat.ps.page-faults
 1.014e+13           -24.0%  7.704e+12        perf-stat.total.instructions
      0.10 ±100%    +720.2%       0.78 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
      0.00 ± 99%  +28933.3%       0.15 ±194%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
      0.01 ±188%   +4331.1%       0.55 ±  3%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.13 ±154%    +661.6%       0.95 ± 14%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.05 ±134%    +965.6%       0.56 ±  9%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.04 ±133%    +363.9%       0.18 ± 69%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.21 ±217%    +343.4%       0.92 ± 61%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ±108%    +174.2%       0.03        perf-sched.sch_delay.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      0.00 ±107%   +9703.6%       0.46 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ±100%   +5433.0%       0.81        perf-sched.sch_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      0.02 ±126%    +396.9%       0.11 ± 23%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.10 ±201%   +1603.5%       1.72 ±  2%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.18 ±170%    +757.6%       1.53 ±  8%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.52 ±222%    +366.0%       7.10 ± 89%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ±121%  +11961.0%       0.82 ±  2%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ±100%   +4938.0%       0.42        perf-sched.total_sch_delay.average.ms
      0.06 ±100%   +5069.9%       3.27 ±  3%  perf-sched.total_wait_and_delay.average.ms
      0.05 ±100%   +5089.4%       2.85 ±  3%  perf-sched.total_wait_time.average.ms
      0.15 ±111%  +78953.3%     119.63 ± 77%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.74 ±143%   +7023.2%      52.77 ± 99%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.24 ±104%  +18409.1%      44.58 ± 39%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.16 ±113%  +24208.5%      38.81 ± 90%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
     67.31 ±222%    +892.6%     668.08        perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.22 ±100%    +304.9%       0.87        perf-sched.wait_and_delay.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      0.04 ±100%   +4498.1%       1.64        perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     16.14 ±102%   +3168.2%     527.60 ±  4%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.67 ±145%    +500.0%      10.00 ± 45%  perf-sched.wait_and_delay.count.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
    104.50 ±101%    +267.5%     384.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.00 ±141%    +400.0%       5.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.33 ±134%    +350.0%       6.00        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     23.83 ±100%    +428.7%     126.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     31.17 ±100%    +400.5%     156.00        perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.17 ±105%   +2900.0%     125.00 ±  9%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      4.00 ±107%    +212.5%      12.50 ±  4%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      6559 ±100%   +2807.6%     190728        perf-sched.wait_and_delay.count.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      3.00 ±105%    +566.7%      20.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
    378.83 ±101%    +315.5%       1574 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     68.33 ±100%    +460.0%     382.67 ±  6%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      3.06 ±100%   +9424.2%     291.66 ± 85%  perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      1.93 ±142%  +24932.3%     483.87 ± 98%  perf-sched.wait_and_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      3.74 ±100%  +21791.0%     817.67 ± 21%  perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      3.73 ±100%  +10126.5%     381.06 ± 82%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      0.15 ±111%  +78953.3%     119.63 ± 77%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      0.74 ±142%   +6999.3%      52.77 ± 99%  perf-sched.wait_time.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.03 ±100%   +2490.1%       0.74 ± 47%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
      0.24 ±104%  +18409.1%      44.58 ± 39%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.01 ±100%   +6623.7%       0.66 ± 39%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked
      0.16 ±113%  +24208.5%      38.81 ± 90%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
     66.90 ±223%    +897.3%     667.24        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     71.60 ±110%    +211.6%     223.12        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.14 ±119%  +11827.5%      16.48 ±203%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.01 ±100%   +5690.1%       0.69 ± 36%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.21 ±100%    +311.4%       0.84        perf-sched.wait_time.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      0.02 ±100%   +3845.2%       0.83        perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     16.12 ±102%   +3171.9%     527.50 ±  4%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ±109%    +874.8%       0.49 ± 11%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      3.06 ±100%   +9424.2%     291.66 ± 85%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      1.94 ±141%  +24837.7%     483.87 ± 98%  perf-sched.wait_time.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      3.74 ±100%  +21791.0%     817.67 ± 21%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      3.73 ±100%  +10126.5%     381.06 ± 82%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      0.64 ±106%    +166.1%       1.72 ±  2%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     18.01           -16.1        1.90        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
     16.53           -14.7        1.82        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
     22.91           -14.7        8.24        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
     22.58           -14.7        7.92        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
     15.60           -11.8        3.80        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
     15.54 ±  2%     -11.4        4.10 ±  6%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
     11.16           -10.4        0.71 ± 44%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
     13.15 ± 85%      -9.9        3.21 ±223%  perf-profile.calltrace.cycles-pp.__send
     11.96 ± 92%      -8.9        3.10 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__send
     11.87 ± 92%      -8.8        3.08 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
      7.82            -7.8        0.00        perf-profile.calltrace.cycles-pp.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      7.04 ±  2%      -7.0        0.00        perf-profile.calltrace.cycles-pp.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
     10.06 ±100%      -7.0        3.04 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
      6.78            -6.8        0.00        perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
     10.53            -6.7        3.88        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      6.51            -6.5        0.00        perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
     21.45            -6.4       15.08        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb
      6.27            -6.3        0.00        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     21.30            -6.3       15.05        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
     21.08            -6.1       14.98        perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
      6.10            -6.1        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_woken.sk_wait_data
      5.50 ±  3%      -5.5        0.00        perf-profile.calltrace.cycles-pp.sock_def_readable.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      5.39 ±  3%      -5.4        0.00        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv
     19.80            -5.2       14.59        perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      5.19 ±  3%      -5.2        0.00        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_data_queue.tcp_rcv_established
      5.01 ±  3%      -5.0        0.00        perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_data_queue
     19.32            -4.9       14.42        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
     19.10            -4.7       14.37        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
      9.78            -4.7        5.06        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
     18.28            -4.2       14.09        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__do_softirq
     16.41            -3.9       12.54        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     15.94            -3.7       12.22        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     15.48            -3.6       11.88        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      8.98            -3.5        5.44        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg
     13.12            -3.2        9.96        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      8.66            -3.1        5.52        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked
     31.20            -2.9       28.35        perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      3.66            -0.6        3.08        perf-profile.calltrace.cycles-pp.ioctl.stress_sock
      2.87            -0.5        2.33        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl.stress_sock
      2.71            -0.5        2.20        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.stress_sock
      2.41            -0.5        1.94        perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl.stress_sock
      1.92            -0.4        1.51        perf-profile.calltrace.cycles-pp.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      1.75            -0.4        1.34        perf-profile.calltrace.cycles-pp.sock_ioctl.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.64 ±  5%      -0.3        1.30 ±  2%  perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto
      0.59            -0.3        0.25 ±100%  perf-profile.calltrace.cycles-pp.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
      1.51            -0.3        1.20        perf-profile.calltrace.cycles-pp.sock_do_ioctl.sock_ioctl.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
      1.38            -0.3        1.10        perf-profile.calltrace.cycles-pp.inet_ioctl.sock_do_ioctl.sock_ioctl.do_vfs_ioctl.__x64_sys_ioctl
     38.50            -0.3       38.25        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      2.01 ±  4%      -0.2        1.76        perf-profile.calltrace.cycles-pp.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      0.90            -0.1        0.76 ±  2%  perf-profile.calltrace.cycles-pp.sk_ioctl.inet_ioctl.sock_do_ioctl.sock_ioctl.do_vfs_ioctl
      1.24            +0.1        1.30        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      1.05            +0.1        1.18        perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked
      0.81            +0.1        0.95        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.54            +0.1        0.68        perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.55            +0.1        0.70        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.56            +0.2        0.71        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl
      0.58            +0.2        0.75        perf-profile.calltrace.cycles-pp.ioctl
      0.26 ±100%      +0.3        0.54        perf-profile.calltrace.cycles-pp.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_try_rmem_schedule.tcp_data_queue
      0.34 ± 70%      +0.3        0.63        perf-profile.calltrace.cycles-pp.sock_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.52            +0.3        0.86        perf-profile.calltrace.cycles-pp.skb_attempt_defer_free.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      0.90            +0.3        1.25        perf-profile.calltrace.cycles-pp.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64
      0.91 ±  2%      +0.3        1.26        perf-profile.calltrace.cycles-pp.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.93 ±  2%      +0.4        1.28        perf-profile.calltrace.cycles-pp.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect.stress_sock
      0.93 ±  2%      +0.4        1.28        perf-profile.calltrace.cycles-pp.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect
      0.93            +0.4        1.29        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.connect.stress_sock
      0.93 ±  2%      +0.4        1.29        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect.stress_sock
      0.94            +0.4        1.30        perf-profile.calltrace.cycles-pp.connect.stress_sock
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock.release_sock.__inet_stream_connect
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock.release_sock
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.tcp_rcv_space_adjust.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.release_sock.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect.__sys_connect
      0.00            +0.6        0.65        perf-profile.calltrace.cycles-pp.tcp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect
      0.00            +0.7        0.69 ±  2%  perf-profile.calltrace.cycles-pp.inet_shutdown.__sys_shutdown.__x64_sys_shutdown.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.70 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_shutdown.do_syscall_64.entry_SYSCALL_64_after_hwframe.shutdown.stress_sock
      0.00            +0.7        0.70 ±  2%  perf-profile.calltrace.cycles-pp.__sys_shutdown.__x64_sys_shutdown.do_syscall_64.entry_SYSCALL_64_after_hwframe.shutdown
      0.00            +0.7        0.70 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.shutdown.stress_sock
      0.00            +0.7        0.70        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.shutdown.stress_sock
      0.00            +0.7        0.71 ±  2%  perf-profile.calltrace.cycles-pp.shutdown.stress_sock
      0.00            +0.8        0.75        perf-profile.calltrace.cycles-pp.skb_try_coalesce.tcp_try_coalesce.tcp_queue_rcv.tcp_data_queue.tcp_rcv_established
      0.00            +0.8        0.83        perf-profile.calltrace.cycles-pp.tcp_try_rmem_schedule.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      0.00            +0.8        0.84        perf-profile.calltrace.cycles-pp.skb_release_data.skb_attempt_defer_free.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      0.00            +0.8        0.84        perf-profile.calltrace.cycles-pp.tcp_try_coalesce.tcp_queue_rcv.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv
      0.00            +0.9        0.89 ± 16%  perf-profile.calltrace.cycles-pp.__entry_text_start.__send.stress_sock
      0.39 ±100%      +0.9        1.29 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.00            +0.9        0.91        perf-profile.calltrace.cycles-pp.tcp_queue_rcv.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      0.53 ± 74%      +1.0        1.51        perf-profile.calltrace.cycles-pp.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.00            +1.0        1.02 ± 15%  perf-profile.calltrace.cycles-pp.tcp_mtu_probe.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
      0.56 ± 74%      +1.1        1.64        perf-profile.calltrace.cycles-pp.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      1.15 ± 16%      +1.1        2.26        perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg
      0.38 ±100%      +1.1        1.50        perf-profile.calltrace.cycles-pp.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked
      1.20 ± 16%      +1.2        2.43        perf-profile.calltrace.cycles-pp.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      1.36            +1.2        2.60        perf-profile.calltrace.cycles-pp.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      2.12            +1.2        3.37        perf-profile.calltrace.cycles-pp.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      1.48            +1.4        2.88        perf-profile.calltrace.cycles-pp.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.36 ±100%      +1.5        1.83        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg
      0.00            +1.7        1.72        perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv
      0.00            +2.2        2.19        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      0.00            +2.2        2.21        perf-profile.calltrace.cycles-pp.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      0.00            +2.7        2.75        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_state_process
      0.00            +2.9        2.90        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_recvmsg
      0.00            +4.9        4.90        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_state_process.tcp_v4_do_rcv
      0.00            +5.2        5.25        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_v4_do_rcv.__release_sock.release_sock.tcp_recvmsg
      5.08            +5.6       10.67        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg
      0.51            +5.7        6.26        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv
      0.51            +5.8        6.29        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      0.00            +5.9        5.94        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_v4_do_rcv.__release_sock.release_sock
      5.41            +5.9       11.35        perf-profile.calltrace.cycles-pp._copy_from_iter.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.00            +6.0        6.00        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_v4_do_rcv.__release_sock
      0.00            +6.0        6.00        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_v4_do_rcv
      0.00            +6.4        6.38        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      6.41            +6.6       13.04        perf-profile.calltrace.cycles-pp.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
     34.83            +6.9       41.69        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
     36.29            +6.9       43.24        perf-profile.calltrace.cycles-pp.recv.stress_sock
     35.24            +7.0       42.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv.stress_sock
     33.81            +7.0       40.85        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     34.94            +7.1       42.05        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.stress_sock
     33.00            +7.3       40.26        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     32.76            +7.4       40.16        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     33.86            +7.9       41.75        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.stress_sock
      0.94            +8.1        9.08        perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      6.69 ±  2%      +9.0       15.66        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked
      6.89 ±  2%      +9.1       15.98        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      8.65            +9.7       18.30        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      8.72            +9.7       18.39        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      0.68 ±  5%     +10.4       11.08        perf-profile.calltrace.cycles-pp.release_sock.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      0.08 ±223%     +10.7       10.81        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg.sock_recvmsg
     31.60           -12.6       18.95        perf-profile.children.cycles-pp.__tcp_transmit_skb
     28.75           -10.5       18.21        perf-profile.children.cycles-pp.__ip_queue_xmit
     10.22            -9.9        0.34        perf-profile.children.cycles-pp.__schedule
      9.72            -9.4        0.34 ±  2%  perf-profile.children.cycles-pp.schedule
     26.70            -9.1       17.61        perf-profile.children.cycles-pp.ip_finish_output2
     25.92            -8.5       17.40        perf-profile.children.cycles-pp.__dev_queue_xmit
     24.85            -8.5       16.34        perf-profile.children.cycles-pp.tcp_write_xmit
     24.00            -8.4       15.62        perf-profile.children.cycles-pp.__tcp_push_pending_frames
      7.87            -7.7        0.18 ±  2%  perf-profile.children.cycles-pp.sk_wait_data
     12.76            -7.6        5.21        perf-profile.children.cycles-pp.tcp_rcv_established
      6.79            -6.6        0.16 ±  3%  perf-profile.children.cycles-pp.wait_woken
      6.63            -6.3        0.34        perf-profile.children.cycles-pp.schedule_timeout
     23.02            -6.2       16.85        perf-profile.children.cycles-pp.__local_bh_enable_ip
     22.53            -6.1       16.46        perf-profile.children.cycles-pp.do_softirq
     22.50            -5.9       16.62        perf-profile.children.cycles-pp.__do_softirq
      5.71 ±  3%      -5.3        0.37 ±  2%  perf-profile.children.cycles-pp.sock_def_readable
      5.60 ±  3%      -5.3        0.30 ±  3%  perf-profile.children.cycles-pp.__wake_up_common_lock
      5.38 ±  3%      -5.1        0.26 ±  3%  perf-profile.children.cycles-pp.__wake_up_common
     20.96            -5.0       15.92        perf-profile.children.cycles-pp.net_rx_action
      5.23 ±  3%      -5.0        0.22 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      7.71 ±  2%      -5.0        2.72        perf-profile.children.cycles-pp.tcp_data_queue
      5.04            -4.8        0.28 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      5.47            -4.7        0.73        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     20.45            -4.7       15.73        perf-profile.children.cycles-pp.__napi_poll
     20.32            -4.6       15.68        perf-profile.children.cycles-pp.process_backlog
     51.63            -4.5       47.16        perf-profile.children.cycles-pp.__send
     19.56            -4.2       15.37        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     17.67            -3.5       14.15        perf-profile.children.cycles-pp.ip_local_deliver_finish
     17.20            -3.4       13.80        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     16.78            -3.2       13.56        perf-profile.children.cycles-pp.tcp_v4_rcv
     31.28            -2.9       28.42        perf-profile.children.cycles-pp.tcp_recvmsg_locked
      2.75            -2.7        0.10 ±  5%  perf-profile.children.cycles-pp.ttwu_do_activate
      2.42            -2.4        0.06        perf-profile.children.cycles-pp.pick_next_task_fair
      2.24            -2.2        0.08        perf-profile.children.cycles-pp.dequeue_task_fair
      2.22            -2.1        0.08 ±  7%  perf-profile.children.cycles-pp.activate_task
      2.14            -2.1        0.08 ±  8%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.84            -1.8        0.07        perf-profile.children.cycles-pp.update_load_avg
      1.57            -1.5        0.06 ±  9%  perf-profile.children.cycles-pp.update_curr
      1.45 ±  8%      -1.3        0.12 ±122%  perf-profile.children.cycles-pp.__cmd_record
      1.32 ±  2%      -1.3        0.05        perf-profile.children.cycles-pp.switch_fpu_return
      1.20            -1.2        0.03 ± 70%  perf-profile.children.cycles-pp.enqueue_entity
      1.17 ±  2%      -1.1        0.04 ± 44%  perf-profile.children.cycles-pp.dequeue_entity
      2.03            -0.9        1.14        perf-profile.children.cycles-pp.dev_hard_start_xmit
      1.84            -0.8        1.02        perf-profile.children.cycles-pp.loopback_xmit
      0.76            -0.7        0.05 ±  8%  perf-profile.children.cycles-pp.__switch_to
      1.39            -0.7        0.72        perf-profile.children.cycles-pp.__cond_resched
      3.82            -0.7        3.16        perf-profile.children.cycles-pp.tcp_ack
      0.79            -0.6        0.17 ±  4%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.78            -0.6        0.22 ±  2%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.68            -0.5        0.14 ±  2%  perf-profile.children.cycles-pp.sched_clock
      0.93            -0.5        0.41        perf-profile.children.cycles-pp.__tcp_send_ack
      0.60            -0.5        0.12 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.77 ±  9%      -0.5        0.30        perf-profile.children.cycles-pp._raw_spin_lock
      1.06 ±  2%      -0.5        0.61 ±  2%  perf-profile.children.cycles-pp.ip_rcv
      4.51            -0.4        4.09        perf-profile.children.cycles-pp.ioctl
      1.94            -0.4        1.53        perf-profile.children.cycles-pp.do_vfs_ioctl
      0.70            -0.4        0.32        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.26            -0.4        0.89        perf-profile.children.cycles-pp.tcp_try_rmem_schedule
      0.82            -0.3        0.48        perf-profile.children.cycles-pp.__netif_rx
      0.78 ±  2%      -0.3        0.45        perf-profile.children.cycles-pp.netif_rx_internal
      3.00            -0.3        2.67        perf-profile.children.cycles-pp.__x64_sys_ioctl
      1.54            -0.3        1.23        perf-profile.children.cycles-pp.sock_do_ioctl
      0.69            -0.3        0.38        perf-profile.children.cycles-pp.enqueue_to_backlog
      1.01            -0.3        0.72        perf-profile.children.cycles-pp.__inet_lookup_skb
      2.27            -0.3        2.00        perf-profile.children.cycles-pp.sock_ioctl
      1.40            -0.3        1.12        perf-profile.children.cycles-pp.inet_ioctl
      0.83            -0.3        0.55        perf-profile.children.cycles-pp.__inet_lookup_established
     41.35            -0.3       41.09        perf-profile.children.cycles-pp.tcp_sendmsg
      0.49            -0.2        0.26 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.35            -0.2        0.13 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.44 ±  7%      -0.2        0.22 ±  5%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.62 ±  2%      -0.2        0.40 ±  2%  perf-profile.children.cycles-pp.validate_xmit_skb
      0.52 ±  3%      -0.2        0.31 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_skmem
      0.47            -0.2        0.29 ±  2%  perf-profile.children.cycles-pp.ip_rcv_core
      1.10            -0.2        0.92        perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
      0.72            -0.2        0.56        perf-profile.children.cycles-pp.kmalloc_reserve
      1.03            -0.2        0.86        perf-profile.children.cycles-pp.kmem_cache_free
      0.54            -0.2        0.38 ±  2%  perf-profile.children.cycles-pp.ip_output
      0.38 ±  5%      -0.2        0.23 ±  9%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.37            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.bpf_skops_write_hdr_opt
      0.92            -0.1        0.78 ±  2%  perf-profile.children.cycles-pp.sk_ioctl
      0.58            -0.1        0.45 ±  3%  perf-profile.children.cycles-pp.tcp_ioctl
      0.27            -0.1        0.14 ±  2%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.42            -0.1        0.29 ±  2%  perf-profile.children.cycles-pp.ip_local_out
      0.25            -0.1        0.13 ±  2%  perf-profile.children.cycles-pp.tcp_ack_update_rtt
      0.34 ±  4%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.netif_skb_features
      2.31            -0.1        2.19        perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      0.48            -0.1        0.37 ±  4%  perf-profile.children.cycles-pp.stress_sock_client
      0.35            -0.1        0.24        perf-profile.children.cycles-pp.__ip_local_out
      0.57            -0.1        0.46        perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.20 ±  3%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.40 ±  2%      -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.ktime_get_with_offset
      0.18 ±  3%      -0.1        0.08        perf-profile.children.cycles-pp.__fdget
      0.16 ±  3%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.61 ±  2%      -0.1        0.51 ±  2%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.22 ±  4%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__sk_dst_check
      0.15 ±  3%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.tcp_rtt_estimator
      0.27            -0.1        0.19        perf-profile.children.cycles-pp.import_single_range
      0.23 ±  2%      -0.1        0.15 ±  2%  perf-profile.children.cycles-pp.ip_send_check
      0.33            -0.1        0.25        perf-profile.children.cycles-pp.__lock_sock_fast
      0.80            -0.1        0.72        perf-profile.children.cycles-pp.__kfree_skb
      0.11 ±  4%      -0.1        0.04 ± 44%  perf-profile.children.cycles-pp.rb_next
      0.24 ±  2%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.30 ±  3%      -0.1        0.23 ±  5%  perf-profile.children.cycles-pp.__ip_finish_output
      0.15 ±  3%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.tcp_options_write
      0.16 ±  6%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.ipv4_dst_check
      0.12 ±  6%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.raw_local_deliver
      0.17 ±  2%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.nf_hook_slow
      0.13 ±  3%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.skb_push
      0.12 ±  3%      -0.1        0.06        perf-profile.children.cycles-pp.tcp_rearm_rto
      0.16 ±  4%      -0.1        0.10 ±  3%  perf-profile.children.cycles-pp.skb_network_protocol
      0.20 ±  3%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.inet_ehashfn
      0.14 ±  3%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.security_sock_rcv_skb
      0.16 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.sock_put
      0.18 ±  5%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.ip_skb_dst_mtu
      0.16 ±  4%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.ip_finish_output
      0.12 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.eth_type_trans
      0.17 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.tcp_update_skb_after_send
      0.13 ±  5%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.raw_v4_input
      0.81            -0.0        0.78        perf-profile.children.cycles-pp.tcp_mstamp_refresh
      0.42            -0.0        0.38        perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      0.10 ±  3%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__usecs_to_jiffies
      0.17            -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.dst_release
      0.14 ±  2%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.skb_release_head_state
      0.09 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.tcp_rate_skb_sent
      0.11 ±  7%      -0.0        0.08        perf-profile.children.cycles-pp.neigh_hh_output
      0.12            -0.0        0.09        perf-profile.children.cycles-pp.tcp_event_data_recv
      0.09 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.validate_xmit_xfrm
      0.09 ±  7%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.cubictcp_cong_avoid
      0.12 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__build_skb_around
      0.09 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__xfrm_policy_check2
      0.13 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.tcp_v4_fill_cb
      0.08 ±  7%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.tcp_cleanup_rbuf
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.ip_local_deliver
      0.08 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.netdev_core_pick_tx
      0.24 ±  2%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.tcp_check_space
      0.08 ±  7%      -0.0        0.06        perf-profile.children.cycles-pp.rb_first
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.tcp_small_queue_check
      0.14 ±  2%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.tcp_inbound_md5_hash
      0.10 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.tcp_recv_timestamp
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.tcp_v4_send_check
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__copy_skb_header
      0.07 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.security_file_ioctl
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.tcp_urg
      0.06 ±  6%      +0.0        0.07        perf-profile.children.cycles-pp.__tcp_close
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
      0.06 ±  9%      +0.0        0.07        perf-profile.children.cycles-pp.ip_route_output_flow
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.do_tcp_getsockopt
      0.07            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.do_tcp_setsockopt
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.tcp_update_recv_tstamps
      0.05 ±  8%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.seq_show
      0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.task_tick_fair
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.sock_rfree
      0.06            +0.0        0.08        perf-profile.children.cycles-pp.__sk_destruct
      0.04 ± 44%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.tcp_v4_send_synack
      0.06 ±  6%      +0.0        0.08 ±  7%  perf-profile.children.cycles-pp.__d_alloc
      0.21 ±  2%      +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.07 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__tcp_ack_snd_check
      0.06 ±  8%      +0.0        0.08 ±  7%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.06 ±  8%      +0.0        0.08        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.11 ±  3%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.inet_release
      0.07 ±  9%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.tcp_getsockopt
      0.06 ±  9%      +0.0        0.08 ±  7%  perf-profile.children.cycles-pp.tcp_create_openreq_child
      0.05 ±  8%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.walk_component
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__sock_release
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.sock_close
      0.05            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.tcp_reset
      0.07            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.init_file
      0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__inet_hash_connect
      0.06 ±  6%      +0.0        0.09        perf-profile.children.cycles-pp.evict
      0.08 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.link_path_walk
      0.22            +0.0        0.25 ±  3%  perf-profile.children.cycles-pp.check_stack_object
      0.08            +0.0        0.11        perf-profile.children.cycles-pp.alloc_file_pseudo
      0.12 ±  3%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.07            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.do_open
      0.04 ± 44%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp._copy_from_user
      0.09 ±  4%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.tcp_v4_send_reset
      0.08 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.sock_alloc_file
      0.03 ± 70%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.inet_csk_clone_lock
      0.11            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.do_dentry_open
      0.24 ±  3%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.12 ±  3%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.dentry_open
      0.11            +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.seq_read_iter
      0.08 ±  6%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.mod_objcg_state
      0.08 ±  6%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.inode_init_always
      0.06 ±  7%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.tcp_set_state
      0.10 ±  3%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.29 ±  3%      +0.0        0.33 ±  3%  perf-profile.children.cycles-pp.tcp_established_options
      0.12 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.seq_read
      0.07 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.tcp_done
      0.14            +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__sys_setsockopt
      0.02 ± 99%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.sk_clone_lock
      0.09 ±  4%      +0.0        0.13 ±  4%  perf-profile.children.cycles-pp.lookup_fast
      0.27            +0.0        0.32        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.12 ±  4%      +0.0        0.16        perf-profile.children.cycles-pp.ip_send_unicast_reply
      0.06 ±  8%      +0.0        0.10        perf-profile.children.cycles-pp.rb_erase
      1.13            +0.0        1.17        perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.14            +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.ksys_read
      0.10 ±  5%      +0.0        0.14 ±  6%  perf-profile.children.cycles-pp.tcp_v4_syn_recv_sock
      0.02 ± 99%      +0.0        0.07        perf-profile.children.cycles-pp.prep_compound_page
      0.14 ±  3%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.__x64_sys_setsockopt
      0.12 ±  4%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.tcp_check_req
      0.13 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.tcp_conn_request
      0.13 ±  2%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.vfs_read
      0.15            +0.0        0.20 ±  4%  perf-profile.children.cycles-pp.read
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.enqueue_timer
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.sk_leave_memory_pressure
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.vsnprintf
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.seq_printf
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.get_nohz_timer_target
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__kmalloc_node
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.apparmor_socket_sendmsg
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.tcp_leave_memory_pressure
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.tcp_v4_send_ack
      0.02 ±141%      +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.getsockname
      0.15 ±  4%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.__dentry_kill
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__mkroute_output
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.02 ±141%      +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.alloc_file
      0.16 ±  2%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.dentry_kill
      0.14 ±  3%      +0.1        0.19 ±  4%  perf-profile.children.cycles-pp.tcp_child_process
      0.13 ±  2%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.10 ±  5%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.inet_sendmsg
      0.02 ± 99%      +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.memcmp
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.open_last_lookups
      0.01 ±223%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.18 ±  4%      +0.1        0.24 ±  3%  perf-profile.children.cycles-pp.__x64_sys_getsockopt
      0.17 ±  4%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.__sys_getsockopt
      0.17 ±  5%      +0.1        0.23        perf-profile.children.cycles-pp.__sock_create
      0.19 ±  3%      +0.1        0.25        perf-profile.children.cycles-pp.__ns_get_path
      0.06            +0.1        0.12        perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.single_open
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.sock_alloc_inode
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.security_file_alloc
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.free_tail_page_prepare
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.alloc_pages
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.inet_send_prepare
      0.11 ±  5%      +0.1        0.17        perf-profile.children.cycles-pp.sock_alloc
      1.26            +0.1        1.32        perf-profile.children.cycles-pp.simple_copy_to_iter
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.inet_put_port
      0.22 ±  3%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.rcu_core
      0.19            +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.dput
      0.58            +0.1        0.65 ±  2%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.18 ±  2%      +0.1        0.25 ±  2%  perf-profile.children.cycles-pp.rcu_do_batch
      0.18 ±  4%      +0.1        0.25 ±  4%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.14 ±  3%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.alloc_empty_file
      0.07 ±  5%      +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.rb_insert_color
      0.17 ±  4%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.alloc_inode
      0.14 ±  3%      +0.1        0.21        perf-profile.children.cycles-pp.__x64_sys_accept
      0.13 ±  3%      +0.1        0.20        perf-profile.children.cycles-pp.kmem_cache_alloc
      0.23 ±  4%      +0.1        0.30        perf-profile.children.cycles-pp.__x64_sys_socket
      0.23 ±  3%      +0.1        0.30        perf-profile.children.cycles-pp.__sys_socket
      0.20 ±  2%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.setsockopt
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.___slab_alloc
      1.04            +0.1        1.12 ±  3%  perf-profile.children.cycles-pp.__fget_light
      0.53 ±  2%      +0.1        0.62 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.10 ±  4%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.tcp_validate_incoming
      0.14 ±  3%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.__x64_sys_accept4
      0.20 ±  4%      +0.1        0.28 ±  7%  perf-profile.children.cycles-pp.ipv4_mtu
      0.25 ±  4%      +0.1        0.34        perf-profile.children.cycles-pp.__socket
      0.30            +0.1        0.40        perf-profile.children.cycles-pp.__skb_clone
      0.20 ±  3%      +0.1        0.29        perf-profile.children.cycles-pp.new_inode_pseudo
      0.16 ±  3%      +0.1        0.25        perf-profile.children.cycles-pp.accept
      0.49 ±  2%      +0.1        0.59        perf-profile.children.cycles-pp.tcp_rcv_space_adjust
      0.25 ±  2%      +0.1        0.35 ±  2%  perf-profile.children.cycles-pp.getsockopt
      0.35            +0.1        0.45        perf-profile.children.cycles-pp.open_related_ns
      0.20 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.rmqueue
      0.24 ±  2%      +0.1        0.34        perf-profile.children.cycles-pp.path_openat
      0.24 ±  2%      +0.1        0.34        perf-profile.children.cycles-pp.do_filp_open
      0.15 ±  6%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.inet_csk_accept
      0.41            +0.1        0.52        perf-profile.children.cycles-pp.refill_stock
      0.16 ±  3%      +0.1        0.27        perf-profile.children.cycles-pp.accept4
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.kfree_skb_partial
      0.36 ±  6%      +0.1        0.48 ±  3%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      1.03            +0.1        1.15        perf-profile.children.cycles-pp.read_tsc
      0.36 ±  6%      +0.1        0.48 ±  4%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.30            +0.1        0.42        perf-profile.children.cycles-pp.tcp_connect
      0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.tcp_stream_memory_free
      0.16 ±  4%      +0.1        0.27        perf-profile.children.cycles-pp.inet_accept
      0.39            +0.1        0.50        perf-profile.children.cycles-pp.__fput
      0.27            +0.1        0.39        perf-profile.children.cycles-pp.do_sys_openat2
      0.28            +0.1        0.40        perf-profile.children.cycles-pp.__x64_sys_openat
      0.17 ±  4%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.tcp_push
      0.29 ±  2%      +0.1        0.42        perf-profile.children.cycles-pp.open64
      0.43 ±  2%      +0.1        0.56        perf-profile.children.cycles-pp.__x64_sys_close
      0.00            +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.lock_timer_base
      0.46 ±  6%      +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      0.14 ±  4%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.14 ±  3%      +0.1        0.28        perf-profile.children.cycles-pp.free_unref_page_prepare
      0.15 ±  3%      +0.1        0.29        perf-profile.children.cycles-pp.drain_stock
      0.57 ±  7%      +0.1        0.71 ±  4%  perf-profile.children.cycles-pp.tick_sched_timer
      0.38 ±  2%      +0.1        0.52        perf-profile.children.cycles-pp.sk_reset_timer
      0.54 ±  7%      +0.1        0.69 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.61 ±  2%      +0.1        0.76 ±  2%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.64 ±  6%      +0.1        0.78 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.55 ±  6%      +0.2        0.70 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.26            +0.2        0.40        perf-profile.children.cycles-pp.do_accept
      0.46            +0.2        0.62        perf-profile.children.cycles-pp.__close
      0.41            +0.2        0.56        perf-profile.children.cycles-pp.tcp_rcv_synsent_state_process
      0.04 ± 44%      +0.2        0.20 ±  2%  perf-profile.children.cycles-pp.tcp_rbtree_insert
      0.27 ±  2%      +0.2        0.43        perf-profile.children.cycles-pp.__sys_accept4
      0.22 ±  3%      +0.2        0.38        perf-profile.children.cycles-pp.tcp_tso_segs
      0.20 ±  3%      +0.2        0.36        perf-profile.children.cycles-pp.page_counter_try_charge
      0.68 ±  5%      +0.2        0.85 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.32            +0.2        0.49        perf-profile.children.cycles-pp.__mod_timer
      0.29            +0.2        0.47        perf-profile.children.cycles-pp.get_page_from_freelist
      0.55            +0.2        0.73        perf-profile.children.cycles-pp.lock_sock_nested
      0.70 ±  6%      +0.2        0.88 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.47            +0.2        0.65        perf-profile.children.cycles-pp.tcp_v4_connect
      0.18 ±  2%      +0.2        0.37        perf-profile.children.cycles-pp.tcp_skb_entail
      0.89            +0.2        1.08        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.54            +0.2        0.74        perf-profile.children.cycles-pp.tcp_event_new_data_sent
      0.21            +0.2        0.42        perf-profile.children.cycles-pp.free_unref_page
      0.34            +0.2        0.58        perf-profile.children.cycles-pp.__alloc_pages
      0.44            +0.2        0.69 ±  2%  perf-profile.children.cycles-pp.inet_shutdown
      0.45            +0.2        0.70 ±  2%  perf-profile.children.cycles-pp.__x64_sys_shutdown
      0.44 ±  2%      +0.3        0.70 ±  2%  perf-profile.children.cycles-pp.__sys_shutdown
      0.89 ±  4%      +0.3        1.14 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.46 ±  2%      +0.3        0.71 ±  2%  perf-profile.children.cycles-pp.shutdown
      0.93 ±  4%      +0.3        1.20 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.68            +0.3        0.97 ±  2%  perf-profile.children.cycles-pp.tcp_send_mss
      0.54            +0.3        0.84 ±  2%  perf-profile.children.cycles-pp.tcp_current_mss
      0.08 ±  5%      +0.3        0.39 ±  2%  perf-profile.children.cycles-pp.tcp_add_backlog
      0.11 ±  5%      +0.3        0.43 ±  2%  perf-profile.children.cycles-pp.skb_clone
      0.53            +0.3        0.87        perf-profile.children.cycles-pp.skb_attempt_defer_free
      0.90            +0.3        1.25        perf-profile.children.cycles-pp.__inet_stream_connect
      0.91 ±  2%      +0.3        1.26        perf-profile.children.cycles-pp.inet_stream_connect
      0.93 ±  2%      +0.4        1.28        perf-profile.children.cycles-pp.__x64_sys_connect
      0.93 ±  2%      +0.4        1.28        perf-profile.children.cycles-pp.__sys_connect
      0.94            +0.4        1.30        perf-profile.children.cycles-pp.connect
      1.97            +0.4        2.35        perf-profile.children.cycles-pp.mem_cgroup_charge_skmem
      0.75            +0.4        1.13        perf-profile.children.cycles-pp.try_charge_memcg
      1.35 ±  2%      +0.4        1.75        perf-profile.children.cycles-pp.ktime_get
      1.11            +0.4        1.54        perf-profile.children.cycles-pp.skb_release_data
      0.00            +0.4        0.45        perf-profile.children.cycles-pp.__slab_free
      1.47            +0.5        1.97        perf-profile.children.cycles-pp.check_heap_object
      1.27            +0.6        1.84 ±  2%  perf-profile.children.cycles-pp.__entry_text_start
      2.13            +0.6        2.75        perf-profile.children.cycles-pp.__check_object_size
      0.90            +0.6        1.54        perf-profile.children.cycles-pp.skb_page_frag_refill
      0.41            +0.7        1.13        perf-profile.children.cycles-pp.tcp_mtu_probe
      0.96            +0.7        1.68        perf-profile.children.cycles-pp.sk_page_frag_refill
      1.66            +0.8        2.47        perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.08 ±  4%      +0.8        0.90        perf-profile.children.cycles-pp.skb_try_coalesce
      0.23 ±  2%      +0.8        1.08        perf-profile.children.cycles-pp.tcp_queue_rcv
      0.09 ±  4%      +0.9        0.99        perf-profile.children.cycles-pp.tcp_try_coalesce
      2.46            +0.9        3.41        perf-profile.children.cycles-pp.__sk_mem_raise_allocated
      2.37            +1.0        3.33        perf-profile.children.cycles-pp.__alloc_skb
      2.54            +1.1        3.60        perf-profile.children.cycles-pp.__sk_mem_schedule
      1.38            +1.3        2.64        perf-profile.children.cycles-pp.tcp_wmem_schedule
      2.16            +1.3        3.42        perf-profile.children.cycles-pp.tcp_stream_alloc_skb
     92.39            +2.5       94.93        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     91.61            +2.8       94.41        perf-profile.children.cycles-pp.do_syscall_64
     15.61            +3.5       19.09        perf-profile.children.cycles-pp.tcp_v4_do_rcv
     38.74            +4.8       43.56        perf-profile.children.cycles-pp.recv
      5.17            +5.7       10.85        perf-profile.children.cycles-pp.copyin
      5.44            +6.0       11.40        perf-profile.children.cycles-pp._copy_from_iter
      6.46            +6.7       13.13        perf-profile.children.cycles-pp.skb_do_copy_data_nocache
     35.00            +6.8       41.78        perf-profile.children.cycles-pp.__x64_sys_recvfrom
     34.87            +6.9       41.74        perf-profile.children.cycles-pp.__sys_recvfrom
     33.83            +7.1       40.89        perf-profile.children.cycles-pp.sock_recvmsg
     33.03            +7.3       40.29        perf-profile.children.cycles-pp.inet_recvmsg
     32.84            +7.4       40.22        perf-profile.children.cycles-pp.tcp_recvmsg
      1.61            +8.4       10.00        perf-profile.children.cycles-pp.tcp_rcv_state_process
      6.74 ±  2%      +9.0       15.75        perf-profile.children.cycles-pp.copyout
      6.91 ±  2%      +9.1       16.02        perf-profile.children.cycles-pp._copy_to_iter
      8.74            +9.7       18.41        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      8.67            +9.7       18.34        perf-profile.children.cycles-pp.__skb_datagram_iter
      3.51           +10.2       13.68        perf-profile.children.cycles-pp.release_sock
      2.66           +10.2       12.86        perf-profile.children.cycles-pp.__release_sock
      1.17 ±  2%      -1.1        0.05 ±  7%  perf-profile.self.cycles-pp.__schedule
      0.73            -0.7        0.05 ±  7%  perf-profile.self.cycles-pp.__switch_to
      0.74 ±  9%      -0.5        0.28        perf-profile.self.cycles-pp._raw_spin_lock
      0.58            -0.5        0.12 ±  4%  perf-profile.self.cycles-pp.native_sched_clock
      0.54            -0.4        0.17        perf-profile.self.cycles-pp.loopback_xmit
      0.66            -0.4        0.30        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.74 ±  3%      -0.4        0.38 ±  2%  perf-profile.self.cycles-pp.ip_finish_output2
      0.99            -0.4        0.64        perf-profile.self.cycles-pp.tcp_ack
      0.52            -0.3        0.18 ±  2%  perf-profile.self.cycles-pp.__do_softirq
      0.44            -0.3        0.16        perf-profile.self.cycles-pp.net_rx_action
      0.67            -0.3        0.40        perf-profile.self.cycles-pp.__ip_queue_xmit
      0.81            -0.3        0.56        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.81            -0.2        0.56        perf-profile.self.cycles-pp.tcp_recvmsg_locked
      0.42            -0.2        0.19        perf-profile.self.cycles-pp.process_backlog
      0.62            -0.2        0.41 ±  2%  perf-profile.self.cycles-pp.__inet_lookup_established
      0.33            -0.2        0.12 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.44            -0.2        0.24 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.42 ±  7%      -0.2        0.22 ±  6%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.44 ±  2%      -0.2        0.25 ±  2%  perf-profile.self.cycles-pp.mem_cgroup_uncharge_skmem
      0.25            -0.2        0.07 ±  5%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.54            -0.2        0.37        perf-profile.self.cycles-pp.do_syscall_64
      0.74            -0.2        0.56 ±  2%  perf-profile.self.cycles-pp.__sys_recvfrom
      0.97            -0.2        0.80        perf-profile.self.cycles-pp.kmem_cache_free
      0.45            -0.2        0.28 ±  2%  perf-profile.self.cycles-pp.ip_rcv_core
      0.52            -0.2        0.36        perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.32 ±  2%      -0.2        0.16 ±  2%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.22 ±  3%      -0.1        0.08        perf-profile.self.cycles-pp.__x64_sys_sendto
      0.25 ±  3%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.is_vmalloc_addr
      0.36 ±  2%      -0.1        0.21        perf-profile.self.cycles-pp.bpf_skops_write_hdr_opt
      0.22 ±  3%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp.do_softirq
      0.35 ±  5%      -0.1        0.21 ± 10%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.57            -0.1        0.43        perf-profile.self.cycles-pp.tcp_v4_rcv
      0.45            -0.1        0.31        perf-profile.self.cycles-pp.tcp_recvmsg
      0.47 ±  2%      -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.inet_ioctl
      0.18 ±  2%      -0.1        0.07        perf-profile.self.cycles-pp.inet_recvmsg
      0.20            -0.1        0.09 ±  6%  perf-profile.self.cycles-pp.sock_recvmsg
      0.56            -0.1        0.45        perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.22 ±  2%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.tcp_schedule_loss_probe
      1.60            -0.1        1.50        perf-profile.self.cycles-pp.__tcp_transmit_skb
      0.37            -0.1        0.27        perf-profile.self.cycles-pp.ip_output
      0.16 ±  3%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.43 ±  8%      -0.1        0.34 ±  4%  perf-profile.self.cycles-pp.recv
      0.25            -0.1        0.16 ±  4%  perf-profile.self.cycles-pp.import_single_range
      0.21            -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.tcp_event_new_data_sent
      0.25 ±  4%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.sock_ioctl
      0.14 ±  3%      -0.1        0.06        perf-profile.self.cycles-pp.tcp_rtt_estimator
      0.12 ±  4%      -0.1        0.04 ± 44%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.45            -0.1        0.36 ±  2%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.19 ±  2%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.__netif_receive_skb_one_core
      0.24            -0.1        0.16 ±  3%  perf-profile.self.cycles-pp.validate_xmit_skb
      0.13 ±  2%      -0.1        0.05        perf-profile.self.cycles-pp.__napi_poll
      0.30            -0.1        0.22        perf-profile.self.cycles-pp.tcp_rcv_established
      0.19            -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.39 ±  2%      -0.1        0.31 ±  2%  perf-profile.self.cycles-pp.stress_sock_client
      0.22 ±  2%      -0.1        0.14 ±  2%  perf-profile.self.cycles-pp.ip_send_check
      0.11 ±  4%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.raw_local_deliver
      0.20 ±  2%      -0.1        0.13 ±  4%  perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.17 ±  4%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.ip_rcv
      0.13 ±  3%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.tcp_options_write
      0.18 ±  2%      -0.1        0.11 ±  3%  perf-profile.self.cycles-pp.__sk_mem_reduce_allocated
      0.18 ±  7%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.netif_skb_features
      0.15 ±  7%      -0.1        0.09        perf-profile.self.cycles-pp.skb_network_protocol
      0.14 ±  7%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.ipv4_dst_check
      0.11 ±  3%      -0.1        0.05        perf-profile.self.cycles-pp.skb_push
      0.24 ±  2%      -0.1        0.18 ±  4%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.89            -0.1        0.84        perf-profile.self.cycles-pp.aa_sk_perm
      0.18 ±  2%      -0.1        0.13 ± 10%  perf-profile.self.cycles-pp.tcp_ioctl
      0.18 ±  2%      -0.1        0.13 ±  3%  perf-profile.self.cycles-pp.inet_ehashfn
      0.22 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.tcp_data_queue
      0.15 ±  2%      -0.0        0.10        perf-profile.self.cycles-pp.sock_put
      0.13 ±  2%      -0.0        0.08        perf-profile.self.cycles-pp.tcp_queue_rcv
      0.19 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.tcp_sendmsg
      0.11 ±  6%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.eth_type_trans
      0.16 ±  3%      -0.0        0.11 ±  5%  perf-profile.self.cycles-pp.ktime_get_with_offset
      0.12 ±  3%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__sk_dst_check
      0.11 ±  3%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.kmalloc_reserve
      0.15 ±  6%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.ip_finish_output
      0.12 ±  6%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.raw_v4_input
      0.17 ±  4%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.ip_skb_dst_mtu
      0.14 ±  2%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.sock_do_ioctl
      0.11 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.nf_hook_slow
      0.25            -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.refill_stock
      0.17            -0.0        0.14 ±  5%  perf-profile.self.cycles-pp.__inet_lookup_skb
      0.10 ±  3%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.security_sock_rcv_skb
      0.15 ±  2%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.dst_release
      0.22 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__mod_timer
      0.12 ±  4%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.__ip_local_out
      0.09 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.tcp_rate_skb_sent
      0.10 ±  6%      -0.0        0.07        perf-profile.self.cycles-pp.neigh_hh_output
      0.09 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.netif_rx_internal
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.tcp_event_data_recv
      0.10 ±  3%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__build_skb_around
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__ip_finish_output
      0.12 ±  3%      -0.0        0.10        perf-profile.self.cycles-pp.tcp_v4_fill_cb
      0.23            -0.0        0.21 ±  3%  perf-profile.self.cycles-pp.tcp_check_space
      0.10 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.sk_filter_trim_cap
      0.09            -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.ip_local_deliver_finish
      0.09 ±  4%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.tcp_update_skb_after_send
      0.08 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.validate_xmit_xfrm
      0.07 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.__usecs_to_jiffies
      0.07 ±  9%      -0.0        0.05        perf-profile.self.cycles-pp.__xfrm_policy_check2
      0.10            -0.0        0.08        perf-profile.self.cycles-pp.sock_def_readable
      0.10 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.tcp_recv_timestamp
      0.11 ±  3%      -0.0        0.09        perf-profile.self.cycles-pp.__copy_skb_header
      0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.tcp_v4_send_check
      0.07 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.ip_local_deliver
      0.18 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.sock_sendmsg
      0.07 ± 10%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.tcp_cleanup_rbuf
      0.06 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.rb_first
      0.06 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.ip_local_out
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.tcp_update_recv_tstamps
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.tcp_urg
      0.19            +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.18 ±  3%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.18 ±  2%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.check_stack_object
      0.06 ±  9%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.22 ±  2%      +0.0        0.25        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.12 ±  5%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.sock_rfree
      0.09 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.lock_sock_nested
      0.06 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.mod_objcg_state
      0.11 ±  3%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.06 ±  9%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.inet_sendmsg
      0.06            +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.kmem_cache_alloc
      1.04            +0.0        1.08        perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.03 ± 70%      +0.0        0.07        perf-profile.self.cycles-pp._copy_from_user
      0.26 ±  4%      +0.0        0.30 ±  3%  perf-profile.self.cycles-pp.tcp_established_options
      0.05            +0.0        0.09        perf-profile.self.cycles-pp.rb_erase
      0.14 ±  3%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.sockfd_lookup_light
      0.09 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.tcp_rcv_space_adjust
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.simple_copy_to_iter
      0.43 ±  2%      +0.0        0.48        perf-profile.self.cycles-pp.skb_release_data
      0.14 ±  2%      +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.tcp_send_mss
      0.08            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.security_socket_sendmsg
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.memcmp
      0.06            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.09 ±  5%      +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.tcp_stream_alloc_skb
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.06            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.sk_page_frag_refill
      0.01 ±223%      +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.prep_compound_page
      0.02 ±141%      +0.1        0.08        perf-profile.self.cycles-pp.propagate_protected_usage
      0.04 ± 44%      +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.__alloc_pages
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.get_page_from_freelist
      1.00            +0.1        1.07 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.06 ±  6%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.rb_insert_color
      0.18 ±  5%      +0.1        0.26 ±  8%  perf-profile.self.cycles-pp.ipv4_mtu
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.rmqueue
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.___slab_alloc
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.tcp_rcv_state_process
      0.99 ±  3%      +0.1        1.06 ±  2%  perf-profile.self.cycles-pp.mem_cgroup_charge_skmem
      0.52            +0.1        0.60 ±  2%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.52 ±  2%      +0.1        0.61 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.tcp_validate_incoming
      0.08 ±  4%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.tcp_wmem_schedule
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.__release_sock
      0.10 ±  5%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.free_unref_page_prepare
      0.96            +0.1        1.06        perf-profile.self.cycles-pp.read_tsc
      0.46            +0.1        0.57 ±  2%  perf-profile.self.cycles-pp.__check_object_size
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.tcp_stream_memory_free
      0.19            +0.1        0.30        perf-profile.self.cycles-pp.__skb_clone
      0.08 ±  5%      +0.1        0.19        perf-profile.self.cycles-pp.__sk_mem_schedule
      0.16 ±  2%      +0.1        0.27 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
      0.16 ±  4%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.tcp_push
      0.25 ±  6%      +0.1        0.37 ±  3%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.12 ±  4%      +0.1        0.24 ±  3%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.22            +0.1        0.34 ±  3%  perf-profile.self.cycles-pp.tcp_current_mss
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.tcp_try_coalesce
      0.17 ±  4%      +0.1        0.31        perf-profile.self.cycles-pp.page_counter_try_charge
      0.89 ±  2%      +0.1        1.04        perf-profile.self.cycles-pp.__sk_mem_raise_allocated
      0.21 ±  2%      +0.2        0.36        perf-profile.self.cycles-pp.tcp_tso_segs
      0.05            +0.2        0.21        perf-profile.self.cycles-pp.tcp_add_backlog
      0.17            +0.2        0.34 ±  2%  perf-profile.self.cycles-pp.skb_do_copy_data_nocache
      0.01 ±223%      +0.2        0.19        perf-profile.self.cycles-pp.tcp_rbtree_insert
      0.14 ±  3%      +0.2        0.33        perf-profile.self.cycles-pp.tcp_skb_entail
      0.45 ±  2%      +0.2        0.65 ±  3%  perf-profile.self.cycles-pp.__send
      0.86            +0.2        1.05        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.50            +0.2        0.70        perf-profile.self.cycles-pp.__alloc_skb
      0.56 ±  4%      +0.2        0.77        perf-profile.self.cycles-pp.ktime_get
      0.51            +0.2        0.72        perf-profile.self.cycles-pp.try_charge_memcg
      0.92            +0.2        1.17        perf-profile.self.cycles-pp.__sys_sendto
      0.27            +0.3        0.55        perf-profile.self.cycles-pp._copy_from_iter
      0.10 ±  5%      +0.3        0.42 ±  2%  perf-profile.self.cycles-pp.skb_clone
      0.50            +0.4        0.86        perf-profile.self.cycles-pp.skb_page_frag_refill
      0.88            +0.4        1.26        perf-profile.self.cycles-pp.__dev_queue_xmit
      0.42 ±  3%      +0.4        0.82 ±  5%  perf-profile.self.cycles-pp.__entry_text_start
      0.00            +0.4        0.44 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.45 ±  2%      +0.5        0.92        perf-profile.self.cycles-pp.__skb_datagram_iter
      0.65 ±  2%      +0.5        1.17        perf-profile.self.cycles-pp.check_heap_object
      0.38            +0.7        1.04        perf-profile.self.cycles-pp.tcp_mtu_probe
      1.38            +0.8        2.18        perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.08 ±  4%      +0.8        0.88        perf-profile.self.cycles-pp.skb_try_coalesce
      2.20            +1.4        3.62        perf-profile.self.cycles-pp.tcp_write_xmit
      2.54            +4.1        6.62        perf-profile.self.cycles-pp.tcp_sendmsg_locked
      5.10            +5.6       10.68        perf-profile.self.cycles-pp.copyin
      6.67 ±  2%      +8.9       15.54        perf-profile.self.cycles-pp.copyout



***************************************************************************************************
lkp-csl-2sp3: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/rootfs/tbox_group/testcase:
  gcc-12/performance/1SSD/btrfs/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp3/blogbench

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 6.695e+08 ±  7%     +11.6%  7.468e+08 ±  6%  cpuidle..time
      2.75 ±  5%     +15.0%       3.17 ±  5%  iostat.cpu.idle
      2.12 ±  7%      +0.4        2.55 ±  7%  mpstat.cpu.all.idle%
      1.64 ±  6%      -0.3        1.34 ±  8%  mpstat.cpu.all.soft%
    206451 ± 19%     -28.6%     147387 ± 10%  numa-meminfo.node1.Active(anon)
   1438479 ± 23%     -35.7%     925625 ± 38%  numa-meminfo.node1.Inactive
   7482580 ± 10%     -22.8%    5778855 ± 14%  numa-numastat.node1.local_node
   7539650 ± 10%     -22.9%    5815892 ± 14%  numa-numastat.node1.numa_hit
    521731 ±  9%     +19.7%     624301 ±  7%  turbostat.C6
      1.98 ±  6%     +16.0%       2.29 ±  5%  turbostat.CPU%c1
     51613 ± 19%     -28.6%      36831 ± 10%  numa-vmstat.node1.nr_active_anon
     51613 ± 19%     -28.6%      36831 ± 10%  numa-vmstat.node1.nr_zone_active_anon
   7539552 ± 10%     -22.9%    5815411 ± 14%  numa-vmstat.node1.numa_hit
   7482483 ± 10%     -22.8%    5778375 ± 14%  numa-vmstat.node1.numa_local
     87888           -28.9%      62448 ±  2%  vmstat.io.bo
  15888177           -19.9%   12718486        vmstat.memory.cache
     30035           -49.7%      15097 ±  3%  vmstat.system.cs
    115535            -6.2%     108398        vmstat.system.in
   2243545 ±  2%      -4.1%    2152228        blogbench.read_score
  52412617           -28.3%   37571769        blogbench.time.file_system_outputs
   2682930           -74.1%     694136        blogbench.time.involuntary_context_switches
   2369329           -50.0%    1184098 ±  5%  blogbench.time.voluntary_context_switches
      5851           -35.9%       3752 ±  2%  blogbench.write_score
   9556530           -23.7%    7288507        meminfo.Active
    335058 ±  2%     -11.0%     298303        meminfo.Active(anon)
   9221471           -24.2%    6990203        meminfo.Active(file)
  14822026           -19.8%   11882120        meminfo.Cached
   2813168 ±  2%     -23.9%    2141166 ±  2%  meminfo.Inactive
   2495481 ±  2%     -26.9%    1823137 ±  3%  meminfo.Inactive(file)
   1027330           -21.5%     806837        meminfo.KReclaimable
  17291320           -18.7%   14055876        meminfo.Memused
   1027330           -21.5%     806837        meminfo.SReclaimable
    567705           -11.8%     500491        meminfo.SUnreclaim
    347747 ±  2%     -10.4%     311626        meminfo.Shmem
   1595036           -18.0%    1307328        meminfo.Slab
  17296989           -18.7%   14063076        meminfo.max_used_kB
     83751 ±  2%     -10.9%      74593        proc-vmstat.nr_active_anon
   2305037           -24.2%    1747654        proc-vmstat.nr_active_file
   6910506           -28.1%    4965836        proc-vmstat.nr_dirtied
   3705052           -19.8%    2970624        proc-vmstat.nr_file_pages
  28598624            +2.8%   29406900        proc-vmstat.nr_free_pages
    623755 ±  2%     -26.9%     455767 ±  3%  proc-vmstat.nr_inactive_file
     86928 ±  2%     -10.4%      77904        proc-vmstat.nr_shmem
    256791           -21.4%     201717        proc-vmstat.nr_slab_reclaimable
    141880           -11.9%     125045        proc-vmstat.nr_slab_unreclaimable
   6683552           -29.1%    4740612 ±  2%  proc-vmstat.nr_written
     83750 ±  2%     -10.9%      74593        proc-vmstat.nr_zone_active_anon
   2305037           -24.2%    1747654        proc-vmstat.nr_zone_active_file
    623755 ±  2%     -26.9%     455767 ±  3%  proc-vmstat.nr_zone_inactive_file
     10239 ± 31%     -43.9%       5745 ±  8%  proc-vmstat.numa_hint_faults
  14790318           -18.1%   12115224        proc-vmstat.numa_hit
  14690001           -18.2%   12015656        proc-vmstat.numa_local
   5041659           -27.1%    3676364        proc-vmstat.pgactivate
  22801122           -16.1%   19140499        proc-vmstat.pgalloc_normal
    941255            -2.0%     922358        proc-vmstat.pgfault
  16727716 ±  2%     -10.1%   15042005 ±  2%  proc-vmstat.pgfree
  26688664           -29.1%   18932460 ±  2%  proc-vmstat.pgpgout
      0.34 ±  4%     +26.3%       0.43 ± 16%  sched_debug.cfs_rq:/.h_nr_running.stddev
    143848 ± 73%    +503.5%     868094 ± 46%  sched_debug.cfs_rq:/.left_vruntime.avg
   5267401 ± 54%    +140.4%   12664767 ± 15%  sched_debug.cfs_rq:/.left_vruntime.max
    775016 ± 57%    +264.4%    2824325 ± 29%  sched_debug.cfs_rq:/.left_vruntime.stddev
     19797 ± 25%    +273.1%      73865 ± 46%  sched_debug.cfs_rq:/.load.avg
    432533 ± 44%    +248.2%    1506268 ± 38%  sched_debug.cfs_rq:/.load.max
     59670 ± 38%    +295.8%     236179 ± 38%  sched_debug.cfs_rq:/.load.stddev
      1.36 ± 10%     +73.5%       2.36 ± 24%  sched_debug.cfs_rq:/.nr_running.max
      0.12 ± 19%    +131.1%       0.28 ± 26%  sched_debug.cfs_rq:/.nr_running.stddev
    143848 ± 73%    +503.5%     868094 ± 46%  sched_debug.cfs_rq:/.right_vruntime.avg
   5267401 ± 54%    +140.4%   12664767 ± 15%  sched_debug.cfs_rq:/.right_vruntime.max
    775016 ± 57%    +264.4%    2824326 ± 29%  sched_debug.cfs_rq:/.right_vruntime.stddev
      2050 ±  5%     +13.3%       2324 ±  7%  sched_debug.cfs_rq:/.runnable_avg.max
    144.28 ± 52%     -60.9%      56.44 ± 45%  sched_debug.cfs_rq:/.util_est_enqueued.min
    715372 ±  5%     +18.2%     845717        sched_debug.cpu.avg_idle.avg
   1295617 ±  9%     -14.2%    1112152 ±  4%  sched_debug.cpu.avg_idle.max
     75779 ± 21%     +81.8%     137779 ± 26%  sched_debug.cpu.avg_idle.min
    305540 ± 10%     -31.2%     210201 ±  4%  sched_debug.cpu.avg_idle.stddev
     39563 ± 64%     -65.5%      13646 ± 54%  sched_debug.cpu.max_idle_balance_cost.stddev
     55267 ±  2%     -39.7%      33351 ±  4%  sched_debug.cpu.nr_switches.avg
    117367 ±  8%     -32.0%      79860 ±  6%  sched_debug.cpu.nr_switches.max
     26070 ±  4%     -40.7%      15457 ±  9%  sched_debug.cpu.nr_switches.min
     21097 ±  7%     -34.0%      13918 ± 13%  sched_debug.cpu.nr_switches.stddev
      0.11 ±  7%     +14.2%       0.13 ±  9%  sched_debug.cpu.nr_uninterruptible.avg
     76.11            +1.5       77.58        perf-stat.i.cache-miss-rate%
 4.955e+08            -4.6%  4.728e+08 ±  2%  perf-stat.i.cache-references
     30207           -47.5%      15845 ±  4%  perf-stat.i.context-switches
      1977 ±  4%     -18.7%       1606 ±  2%  perf-stat.i.cpu-migrations
 7.754e+09            -1.4%  7.649e+09        perf-stat.i.dTLB-loads
 1.822e+09 ±  2%      -4.0%  1.749e+09        perf-stat.i.dTLB-stores
 3.046e+10            -1.3%  3.005e+10        perf-stat.i.instructions
    177.30            -1.6%     174.44        perf-stat.i.metric.M/sec
      2470            -1.7%       2428        perf-stat.i.minor-faults
     68.87            -1.9       66.92        perf-stat.i.node-load-miss-rate%
  83930000 ±  2%      -5.8%   79071089        perf-stat.i.node-load-misses
   4258826 ±  2%      -4.9%    4049629        perf-stat.i.node-stores
      2470            -1.7%       2428        perf-stat.i.page-faults
     76.23            +1.5       77.74        perf-stat.overall.cache-miss-rate%
     68.87            -2.0       66.89        perf-stat.overall.node-load-miss-rate%
 4.937e+08            -4.6%  4.711e+08 ±  2%  perf-stat.ps.cache-references
     30138           -50.3%      14978 ±  4%  perf-stat.ps.context-switches
      1972 ±  4%     -19.2%       1594 ±  2%  perf-stat.ps.cpu-migrations
 7.725e+09            -1.4%  7.618e+09        perf-stat.ps.dTLB-loads
 1.816e+09 ±  2%      -4.2%   1.74e+09        perf-stat.ps.dTLB-stores
 3.034e+10            -1.4%  2.993e+10        perf-stat.ps.instructions
      2464            -2.6%       2402        perf-stat.ps.minor-faults
  83612770 ±  2%      -5.7%   78809861        perf-stat.ps.node-load-misses
   4243163 ±  2%      -4.9%    4033510        perf-stat.ps.node-stores
      2465            -2.6%       2402        perf-stat.ps.page-faults
 9.141e+12            -1.4%  9.017e+12        perf-stat.total.instructions
      2.10 ±  5%      -1.2        0.86 ± 19%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      2.10 ±  5%      -1.2        0.86 ± 19%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      2.10 ±  5%      -1.2        0.86 ± 19%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      1.82 ±  6%      -1.1        0.69 ± 17%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.82 ±  7%      -1.1        0.68 ± 17%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      1.82 ±  7%      -1.1        0.68 ± 17%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.54 ±  6%      -1.1        0.42 ± 72%  perf-profile.calltrace.cycles-pp.file_free_rcu.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
      1.81 ±  7%      -1.1        0.68 ± 17%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
      1.81 ±  7%      -1.1        0.68 ± 17%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
      7.52            -0.2        7.28        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
      7.50            -0.2        7.27        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      7.62            -0.2        7.39        perf-profile.calltrace.cycles-pp.__libc_read
      6.98            -0.2        6.77        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      6.41            -0.2        6.21        perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.74            -0.2        6.54        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      5.23            -0.2        5.06        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
      4.92            -0.2        4.75        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read
      5.34            -0.2        5.17        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
      4.79            -0.2        4.63        perf-profile.calltrace.cycles-pp.rep_movs_alternative.copyout._copy_to_iter.copy_page_to_iter.filemap_read
      0.00            +0.5        0.54 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.alloc_fd
      0.00            +0.6        0.55 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.alloc_fd.do_sys_openat2
     37.34            +0.8       38.13        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     37.41            +0.8       38.20        perf-profile.calltrace.cycles-pp.__close
     37.35            +0.8       38.14        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     37.13            +0.8       37.92        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     36.51            +0.8       37.31        perf-profile.calltrace.cycles-pp.close_fd_get_file.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     36.21            +0.8       37.01        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.close_fd_get_file.__x64_sys_close.do_syscall_64
     36.39            +0.8       37.20        perf-profile.calltrace.cycles-pp._raw_spin_lock.close_fd_get_file.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.10 ±  5%      -1.2        0.86 ± 19%  perf-profile.children.cycles-pp.ret_from_fork_asm
      2.10 ±  5%      -1.2        0.86 ± 19%  perf-profile.children.cycles-pp.ret_from_fork
      2.10 ±  5%      -1.2        0.86 ± 19%  perf-profile.children.cycles-pp.kthread
      1.82 ±  6%      -1.1        0.69 ± 17%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.82 ±  7%      -1.1        0.68 ± 17%  perf-profile.children.cycles-pp.run_ksoftirqd
      2.07 ±  6%      -0.5        1.59 ±  8%  perf-profile.children.cycles-pp.rcu_do_batch
      2.08 ±  6%      -0.5        1.60 ±  8%  perf-profile.children.cycles-pp.rcu_core
      2.09 ±  6%      -0.5        1.61 ±  8%  perf-profile.children.cycles-pp.__do_softirq
      1.76 ±  6%      -0.4        1.35 ±  9%  perf-profile.children.cycles-pp.file_free_rcu
      7.64            -0.2        7.42        perf-profile.children.cycles-pp.__libc_read
      6.99            -0.2        6.78        perf-profile.children.cycles-pp.ksys_read
      6.42            -0.2        6.21        perf-profile.children.cycles-pp.filemap_read
      6.74            -0.2        6.55        perf-profile.children.cycles-pp.vfs_read
      5.34            -0.2        5.18        perf-profile.children.cycles-pp.copy_page_to_iter
      4.82            -0.2        4.65        perf-profile.children.cycles-pp.rep_movs_alternative
      5.30            -0.2        5.13        perf-profile.children.cycles-pp._copy_to_iter
      4.94            -0.2        4.78        perf-profile.children.cycles-pp.copyout
      0.27 ±  4%      -0.1        0.17 ± 35%  perf-profile.children.cycles-pp.process_one_work
      0.27 ±  4%      -0.1        0.17 ± 36%  perf-profile.children.cycles-pp.worker_thread
      0.18 ±  8%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.btrfs_search_slot
      0.23 ±  6%      -0.1        0.16 ± 15%  perf-profile.children.cycles-pp.rename
      0.22 ±  7%      -0.1        0.16 ± 16%  perf-profile.children.cycles-pp.do_renameat2
      0.22 ±  8%      -0.1        0.16 ± 15%  perf-profile.children.cycles-pp.__x64_sys_rename
      0.15 ±  8%      -0.1        0.09 ± 24%  perf-profile.children.cycles-pp.btrfs_work_helper
      0.15 ±  8%      -0.0        0.11 ± 15%  perf-profile.children.cycles-pp.btrfs_rename2
      0.14 ±  8%      -0.0        0.10 ± 16%  perf-profile.children.cycles-pp.__libc_write
      0.14 ±  8%      -0.0        0.09 ± 17%  perf-profile.children.cycles-pp.vfs_write
      0.16 ±  6%      -0.0        0.12 ± 16%  perf-profile.children.cycles-pp.vfs_rename
      0.14 ±  6%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.ksys_write
      0.12 ±  6%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.btrfs_do_write_iter
      0.12 ±  6%      -0.0        0.08 ± 13%  perf-profile.children.cycles-pp.btrfs_buffered_write
      0.07 ±  9%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.lookup_open
      0.12 ±  5%      -0.0        0.09 ± 15%  perf-profile.children.cycles-pp.btrfs_rename
      0.10 ±  6%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.46            -0.0        0.44 ±  2%  perf-profile.children.cycles-pp.open_last_lookups
      0.09 ±  7%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.dput
      0.23 ± 29%      +0.1        0.37 ± 27%  perf-profile.children.cycles-pp.start_secondary
      0.23 ± 29%      +0.1        0.37 ± 28%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.23 ± 29%      +0.1        0.37 ± 28%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.23 ± 29%      +0.1        0.37 ± 28%  perf-profile.children.cycles-pp.do_idle
      0.23 ± 29%      +0.1        0.37 ± 28%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.23 ± 29%      +0.1        0.37 ± 28%  perf-profile.children.cycles-pp.cpuidle_enter
      0.23 ± 29%      +0.1        0.37 ± 28%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.21 ± 28%      +0.1        0.36 ± 27%  perf-profile.children.cycles-pp.intel_idle
      0.28 ±  4%      +0.7        0.94 ±  3%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.65 ±  3%      +0.7        1.30 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.62 ±  2%      +0.7        1.28 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     37.42            +0.8       38.21        perf-profile.children.cycles-pp.__close
     37.13            +0.8       37.92        perf-profile.children.cycles-pp.__x64_sys_close
     36.51            +0.8       37.31        perf-profile.children.cycles-pp.close_fd_get_file
     97.16            +1.1       98.25        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     97.12            +1.1       98.22        perf-profile.children.cycles-pp.do_syscall_64
     84.64            +1.6       86.20        perf-profile.children.cycles-pp._raw_spin_lock
     84.20            +1.6       85.77        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.76 ±  6%      -0.4        1.35 ±  9%  perf-profile.self.cycles-pp.file_free_rcu
      4.77            -0.2        4.58        perf-profile.self.cycles-pp.rep_movs_alternative
      0.21 ± 28%      +0.1        0.36 ± 27%  perf-profile.self.cycles-pp.intel_idle
     83.71            +1.0       84.66        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.26 ± 55%    +300.3%       1.03 ± 29%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.pagecache_get_page
      0.01 ± 12%    +563.8%       0.09 ± 31%  perf-sched.sch_delay.avg.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.20 ± 73%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.btrfs_wq_run_delayed_node.btrfs_btree_balance_dirty
      0.00 ±223%   +9900.0%       0.02 ± 44%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.03 ± 49%   +4632.4%       1.48 ±109%  perf-sched.sch_delay.avg.ms.__cond_resched.btrfs_alloc_path.__btrfs_unlink_inode.btrfs_rename.btrfs_rename2
      0.44 ±210%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_async_run_delayed_root.btrfs_work_helper.process_one_work
      0.02 ± 45%   +3572.2%       0.81 ± 55%  perf-sched.sch_delay.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode
      0.04 ± 44%     -93.6%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_lookup_dentry.btrfs_lookup.lookup_one_qstr_excl
      0.01 ±159%   +4251.0%       0.36 ±166%  perf-sched.sch_delay.avg.ms.__cond_resched.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.34 ±124%     -91.3%       0.03 ±144%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.find_free_extent.btrfs_reserve_extent.btrfs_alloc_tree_block
      0.09 ±107%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_delete_delayed_items
      0.05 ± 90%     -98.1%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_file_extent
      0.38 ± 38%     -81.6%       0.07 ±137%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_truncate_inode_items
      0.36 ±124%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.10 ± 37%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      0.01 ±116%    +381.8%       0.03 ± 77%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.42 ± 40%    +365.1%       1.96 ±110%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.vfs_rename.do_renameat2.__x64_sys_rename
      0.02 ± 24%    +375.8%       0.08 ± 29%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      0.16 ± 75%   +1051.5%       1.85 ± 78%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_dirty_pages
      0.00 ± 91%   +1495.2%       0.06 ±101%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
      0.15 ± 49%    +395.9%       0.75 ± 65%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_create_common.lookup_open
      0.08 ±182%   +1182.8%       1.04 ±129%  perf-sched.sch_delay.avg.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
      0.08 ± 28%   +1245.8%       1.02 ± 55%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.__btrfs_release_delayed_node.part.0
      0.14 ± 44%   +1386.6%       2.03 ± 85%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.btrfs_delayed_delete_inode_ref.__btrfs_unlink_inode.btrfs_rename
      0.01 ± 47%     -94.0%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.btrfs_delete_delayed_items.btrfs_async_run_delayed_root.btrfs_work_helper
      0.03 ± 54%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.workqueue_set_max_active.btrfs_work_helper.process_one_work
      0.01 ± 42%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.start_transaction.btrfs_async_run_delayed_root.btrfs_work_helper.process_one_work
      0.78 ± 61%    +153.0%       1.97 ± 21%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.10 ± 33%    +114.8%       0.23 ± 72%  perf-sched.sch_delay.avg.ms.btrfs_balance_delayed_items.btrfs_btree_balance_dirty.btrfs_rename2.vfs_rename
      0.09 ± 39%    +266.4%       0.34 ± 25%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ±101%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.10 ± 83%    +392.8%       0.49 ± 28%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.49 ± 65%    +740.0%       4.12 ±130%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.16 ± 38%    +288.6%       0.63 ± 24%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_async_run_delayed_root
      0.21 ± 11%    +152.5%       0.52 ± 13%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_delete_delayed_dir_index
      0.12 ± 75%    +328.8%       0.52 ± 48%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_delete_delayed_items
      0.13 ± 28%     +95.9%       0.26 ± 30%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_insert_delayed_dir_index
      0.10 ±  7%    +290.3%       0.38 ± 23%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.07 ±  5%    +240.2%       0.24 ± 37%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      0.25 ± 24%    +123.8%       0.56 ± 33%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_renameat2
      0.30 ± 18%    +147.2%       0.75 ± 23%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.29 ± 19%    +112.6%       0.61 ± 30%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ± 39%   +9932.6%       2.41 ± 32%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.blk_execute_rq
      0.15 ± 85%    +999.8%       1.65 ± 14%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.07 ± 16%   +1038.8%       0.77 ± 23%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.17 ± 13%   +1740.5%       3.10        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.09 ± 26%    +787.9%       0.78 ± 11%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      9.30 ± 80%    +605.4%      65.59 ± 42%  perf-sched.sch_delay.max.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.66 ±105%     -95.1%       0.13 ±151%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.btrfs_alloc_delayed_item.btrfs_delete_delayed_dir_index
      1.42 ± 68%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.btrfs_wq_run_delayed_node.btrfs_btree_balance_dirty
      0.12 ±167%   +2268.0%       2.85 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      9.24 ±215%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.btrfs_alloc_path.btrfs_async_run_delayed_root.btrfs_work_helper.process_one_work
      5.22 ± 41%     -50.0%       2.61 ± 47%  perf-sched.sch_delay.max.ms.__cond_resched.btrfs_alloc_path.btrfs_del_inode_ref.__btrfs_unlink_inode.btrfs_rename
      0.69 ±108%    +342.1%       3.07 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.btrfs_alloc_path.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode
      0.13 ± 27%     -96.2%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.btrfs_alloc_path.btrfs_lookup_dentry.btrfs_lookup.lookup_one_qstr_excl
      0.03 ±169%   +2465.1%       0.71 ±166%  perf-sched.sch_delay.max.ms.__cond_resched.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
     21.47 ± 83%     -82.7%       3.72 ± 54%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
     10.14 ±138%     -92.1%       0.81 ±165%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_dir_item
      1.24 ±133%     -96.8%       0.04 ±143%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.find_free_extent.btrfs_reserve_extent.btrfs_alloc_tree_block
      6.24 ± 49%     -70.5%       1.84 ± 95%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      8.65 ± 19%     -75.8%       2.09 ± 92%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_del_inode_ref
      5.30 ± 59%     -76.0%       1.28 ±140%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_del_orphan_item
      2.06 ±138%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_delete_delayed_items
      7.27 ± 27%     -67.4%       2.37 ± 71%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_dir_item
      1.58 ±101%     -99.9%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_file_extent
      5.08 ± 20%     -85.9%       0.72 ±180%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_inode
      5.66 ± 39%     -98.6%       0.08 ±139%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_truncate_inode_items
      5.43 ±173%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      1.90 ± 61%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      0.12 ± 59%     -68.8%       0.04 ±126%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_tree_ref.btrfs_free_tree_block.__btrfs_cow_block
      0.09 ± 92%     -98.5%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.btrfs_delete_delayed_items.btrfs_async_run_delayed_root.btrfs_work_helper
      0.10 ±112%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.workqueue_set_max_active.btrfs_work_helper.process_one_work
      0.02 ± 58%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.start_transaction.btrfs_async_run_delayed_root.btrfs_work_helper.process_one_work
      1.18 ±128%     -97.1%       0.03 ±150%  perf-sched.sch_delay.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.04 ± 33%    +292.7%      11.95 ±131%  perf-sched.sch_delay.max.ms.btrfs_balance_delayed_items.btrfs_btree_balance_dirty.btrfs_create_common.lookup_open.isra
      2.65 ± 31%     +69.4%       4.49 ± 22%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      2.22 ± 23%    +115.0%       4.78 ± 48%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.73 ±107%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.96 ± 84%     -99.6%       0.00 ±223%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
     48.23 ± 79%    +760.5%     415.00 ± 80%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      4.33 ± 21%    +293.8%      17.05 ± 88%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
     14.68 ± 51%    +622.8%     106.09 ± 65%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      4.13 ±  8%    +161.6%      10.80 ± 78%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.03 ± 40%  +11011.0%       3.20 ± 27%  perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.blk_execute_rq
      1.57 ± 83%    +157.5%       4.04        perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.08          +763.2%       0.73 ± 11%  perf-sched.total_sch_delay.average.ms
     96.59 ±108%    +725.2%     797.08 ± 40%  perf-sched.total_sch_delay.max.ms
     15.18 ±  5%    +108.2%      31.60 ±  8%  perf-sched.total_wait_and_delay.average.ms
    109382 ±  5%     -51.4%      53178 ±  6%  perf-sched.total_wait_and_delay.count.ms
     15.09 ±  5%    +104.5%      30.87 ±  8%  perf-sched.total_wait_time.average.ms
      1.45 ± 34%    +171.3%       3.94 ± 31%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.59 ±100%    +171.3%       9.75 ±  7%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2.23 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      1.62 ± 41%     -91.5%       0.14 ±223%  perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
     49.97 ± 54%    +513.1%     306.37 ± 70%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.56 ± 22%    +184.1%       4.42 ± 25%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
    346.80 ± 15%    +135.0%     814.99 ±  3%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     52.56 ± 54%     +97.8%     103.98 ± 10%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    237.56 ±  3%      +9.8%     260.81 ±  6%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    178.06 ±  3%     +86.0%     331.14 ±  8%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    328.16 ±  4%     +10.0%     360.96 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      2.55 ± 11%    +156.3%       6.54 ± 17%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      1.43 ± 11%    +123.8%       3.19 ± 27%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      4.48           +30.7%       5.85 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     59.30 ±  4%     +61.0%      95.49 ±  8%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      9337 ± 11%     -64.6%       3303 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1708 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
    755.17 ±  5%     -94.1%      44.67 ±223%  perf-sched.wait_and_delay.count.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
     17.67 ± 32%     -71.7%       5.00 ± 62%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     11011 ± 12%     -64.9%       3864 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
     17.83 ±  7%     -95.3%       0.83 ±107%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    105.83 ± 20%     -98.9%       1.17 ± 76%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4522 ± 14%     -74.5%       1152 ±  6%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     75.67 ±  4%     -45.4%      41.33 ±  4%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     42893 ± 11%     -50.9%      21042 ± 12%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
     12748 ± 15%     -52.9%       6008 ± 11%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      1126           -11.8%     993.33 ±  2%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      7303 ±  5%     -37.1%       4592 ±  6%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     39.77 ± 84%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
    672.58 ± 69%     -99.6%       2.81 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
    350.82 ± 66%     -86.6%      47.13 ±100%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    385.08 ± 13%     -80.5%      74.94 ± 72%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1077 ±  6%     +31.8%       1419 ± 18%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1084 ±  6%     +68.8%       1830 ± 30%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.42 ± 26%    +228.5%       4.68 ± 44%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.pagecache_get_page
      1.44 ± 35%    +167.7%       3.85 ± 32%  perf-sched.wait_time.avg.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.11 ±  9%    +267.3%       4.06 ± 38%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.btrfs_alloc_delayed_item.btrfs_insert_delayed_dir_index
      1.24 ± 41%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.btrfs_wq_run_delayed_node.btrfs_btree_balance_dirty
      6.88 ±  5%     +41.5%       9.73 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     19.67 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_async_run_delayed_root.btrfs_work_helper.process_one_work
      1.11 ± 87%     -98.6%       0.02 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper
      0.62 ± 24%    +738.4%       5.21 ± 30%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_del_inode_ref.__btrfs_unlink_inode.btrfs_rename
      0.60 ± 14%    +599.5%       4.19 ± 69%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_insert_dir_item.btrfs_add_link.btrfs_create_new_inode
      1.03 ±149%     -97.4%       0.03 ±169%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_lookup_dentry.btrfs_lookup.lookup_one_qstr_excl
      0.68 ± 93%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_del_inode_ref.__btrfs_unlink_inode.btrfs_rename
      1.36 ± 72%     -90.9%       0.12 ±156%  perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_lookup_dir_item.__btrfs_unlink_inode.btrfs_rename
      1.90 ±  9%    +269.8%       7.02 ± 70%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      0.92 ±  8%    +366.3%       4.31 ± 36%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.__btrfs_tree_read_lock.btrfs_search_slot.btrfs_lookup_dir_item
      2.00 ± 41%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_delete_delayed_items
      1.03 ± 11%    +227.6%       3.36 ± 42%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_insert_empty_items
      0.94 ± 39%    +284.1%       3.61 ± 49%  perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      1.27 ± 27%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      1.36 ± 24%    +325.9%       5.79 ± 59%  perf-sched.wait_time.avg.ms.__cond_resched.dput.vfs_rename.do_renameat2.__x64_sys_rename
     49.97 ± 54%    +513.1%     306.37 ± 70%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.54 ± 22%    +182.1%       4.34 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      1.31 ± 34%    +218.6%       4.18 ± 43%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__clear_extent_bit.btrfs_dirty_pages
     59.90 ± 50%     -91.6%       5.04 ± 53%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.lock_extent
      1.25 ± 24%    +260.1%       4.52 ± 32%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.start_transaction.btrfs_create_common.lookup_open
      0.80 ± 19%    +740.1%       6.72 ± 37%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.start_transaction.evict_refill_and_join.btrfs_evict_inode
      0.76 ± 77%    +525.0%       4.74 ± 55%  perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write.do_renameat2.__x64_sys_rename.do_syscall_64
      1.08 ± 11%    +300.0%       4.32 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.__btrfs_release_delayed_node.part.0
      0.92 ± 17%    +395.3%       4.57 ± 49%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.btrfs_delayed_delete_inode_ref.__btrfs_unlink_inode.btrfs_rename
     22.56 ± 54%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.workqueue_set_max_active.btrfs_work_helper.process_one_work
      2.71 ± 69%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.start_transaction.btrfs_async_run_delayed_root.btrfs_work_helper.process_one_work
      1.08 ± 47%   +4057.6%      44.81 ±207%  perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.btrfs_evict_inode.evict.__dentry_kill
      6.94 ±135%     -93.9%       0.42 ±188%  perf-sched.wait_time.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
    346.02 ± 15%    +135.0%     813.02 ±  3%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.76 ± 29%    +123.7%       1.70 ± 65%  perf-sched.wait_time.avg.ms.btrfs_balance_delayed_items.btrfs_btree_balance_dirty.btrfs_create_common.lookup_open.isra
      0.71 ± 21%    +169.6%       1.91 ± 64%  perf-sched.wait_time.avg.ms.btrfs_balance_delayed_items.btrfs_btree_balance_dirty.btrfs_rename2.vfs_rename
     52.62 ± 53%     +96.9%     103.64 ± 10%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    237.10 ±  3%      +8.6%     257.41 ±  5%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.05 ± 69%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt
      0.24 ±121%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      3.51 ±123%    -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
    177.96 ±  3%     +85.8%     330.65 ±  8%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    327.67 ±  3%      +8.9%     356.84        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.83 ± 20%    +147.4%       2.04 ± 18%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__btrfs_release_delayed_node
      2.45 ± 30%    +174.6%       6.73 ± 27%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_async_run_delayed_root
      1.47 ± 12%    +136.3%       3.47 ± 17%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_delayed_update_inode
      1.39 ± 13%    +126.7%       3.16 ± 21%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_delete_delayed_dir_index
      1.06 ± 21%    +167.0%       2.83 ± 25%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_delete_delayed_items
      1.44 ± 19%    +123.9%       3.22 ± 20%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_insert_delayed_dir_index
      2.45 ± 12%    +151.0%       6.15 ± 17%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      1.36 ± 12%    +117.8%       2.96 ± 26%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      1.51 ± 38%     +99.2%       3.02 ± 31%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_renameat2
      1.54 ± 13%    +154.8%       3.91 ± 24%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      4.41           +15.2%       5.08 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     59.22 ±  4%     +59.9%      94.70 ±  8%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     18.06 ± 56%     -92.2%       1.41 ±141%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.btrfs_alloc_delayed_item.btrfs_delete_delayed_dir_index
      7.21 ± 73%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.btrfs_wq_run_delayed_node.btrfs_btree_balance_dirty
      6.08 ± 54%     -60.5%       2.40 ± 53%  perf-sched.wait_time.max.ms.__cond_resched.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file
    127.33 ± 76%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_alloc_path.btrfs_async_run_delayed_root.btrfs_work_helper.process_one_work
      5.83 ±169%     -99.7%       0.02 ±223%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_alloc_path.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper
      2.04 ±149%     -98.5%       0.03 ±174%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_alloc_path.btrfs_lookup_dentry.btrfs_lookup.lookup_one_qstr_excl
      6.35 ± 32%     -41.9%       3.69 ± 46%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_buffered_write.btrfs_do_write_iter.vfs_write.ksys_write
      3.72 ±106%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_del_inode_ref.__btrfs_unlink_inode.btrfs_rename
      5.15 ± 64%     -97.6%       0.12 ±156%  perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_lookup_dir_item.__btrfs_unlink_inode.btrfs_rename
     16.69 ±103%     -81.6%       3.08 ±114%  perf-sched.wait_time.max.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
     14.90 ± 32%     -82.2%       2.65 ±140%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_del_orphan_item
     12.39 ± 56%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_delete_delayed_items
     33.98 ±105%     -76.7%       7.93 ± 86%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_dir_item
     14.96 ± 33%     -87.3%       1.91 ±223%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_file_extent
     22.42 ± 48%     -91.6%       1.89 ±113%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_inode
     13.01 ± 24%     -71.3%       3.74 ±101%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_truncate_inode_items
     14.14 ± 68%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      9.34 ± 32%    +332.2%      40.36 ±116%  perf-sched.wait_time.max.ms.__cond_resched.dput.vfs_rename.do_renameat2.__x64_sys_rename
    942.33 ± 53%     -98.8%      10.95 ± 52%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.lock_extent
      5.66 ± 60%     -86.9%       0.74 ±215%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.btrfs_get_or_create_delayed_node.btrfs_delayed_update_inode.btrfs_update_inode
    350.82 ± 66%     -86.6%      47.13 ±100%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
     40.53 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.workqueue_set_max_active.btrfs_work_helper.process_one_work
    385.03 ± 13%     -81.0%      73.31 ± 72%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      7.13 ± 83%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.start_transaction.btrfs_async_run_delayed_root.btrfs_work_helper.process_one_work
     49.86 ±156%     -99.1%       0.42 ±188%  perf-sched.wait_time.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.87 ± 36%    +191.4%      28.77 ± 43%  perf-sched.wait_time.max.ms.btrfs_balance_delayed_items.btrfs_dirty_inode.touch_atime.filemap_read
      0.36 ± 86%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_common_interrupt
      0.61 ±108%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
    345.76 ±134%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
    677.96 ± 68%     -99.8%       1.30 ±223%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      1076 ±  6%     +20.7%       1300        perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     28.80 ± 35%    +213.0%      90.13 ± 52%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_async_run_delayed_root
      7.71 ± 35%     +83.8%      14.17 ± 29%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_delayed_update_inode
      1084 ±  6%     +68.8%       1830 ± 30%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm



***************************************************************************************************
lkp-cpl-4sp2: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/socket/4/x86_64-rhel-8.3/threads/50%/debian-11.1-x86_64-20220510.cgz/lkp-cpl-4sp2/hackbench

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  30767113 ±  3%     +30.0%   39986173        cpuidle..usage
     46513 ± 24%     -56.2%      20388 ± 63%  numa-vmstat.node1.nr_kernel_stack
     10994 ± 44%     -47.7%       5753 ± 39%  numa-vmstat.node2.nr_slab_reclaimable
     46474 ± 24%     -56.1%      20420 ± 63%  numa-meminfo.node1.KernelStack
     43970 ± 44%     -47.7%      23008 ± 39%  numa-meminfo.node2.KReclaimable
     43970 ± 44%     -47.7%      23008 ± 39%  numa-meminfo.node2.SReclaimable
      5106 ±  5%     +45.4%       7425 ±  6%  perf-c2c.DRAM.local
      3600 ± 10%     +75.1%       6304 ±  3%  perf-c2c.DRAM.remote
      1412 ± 16%    +133.9%       3304 ±  4%  perf-c2c.HITM.remote
   7611598 ± 13%     +24.6%    9486023 ±  4%  vmstat.memory.cache
   5412487           -60.4%    2142060        vmstat.system.cs
   1257846           -48.9%     642429        vmstat.system.in
      3591            +1.1%       3631        turbostat.Bzy_MHz
  30443383 ±  4%     +30.3%   39652818 ±  2%  turbostat.C1
 2.037e+08           -41.9%  1.183e+08        turbostat.IRQ
     24.15           +10.0%      26.56        turbostat.RAMWatt
    247.86 ±  3%      +9.6%     271.71 ±  3%  sched_debug.cfs_rq:/.util_avg.stddev
   1443002           -63.3%     529509 ± 20%  sched_debug.cpu.nr_switches.avg
   1732432 ±  5%     -60.4%     685443 ± 18%  sched_debug.cpu.nr_switches.max
   1259291 ±  4%     -62.9%     466859 ± 20%  sched_debug.cpu.nr_switches.min
     58428 ± 12%     -49.5%      29525 ± 28%  sched_debug.cpu.nr_switches.stddev
    197915 ±  4%     +10.7%     219104        meminfo.Active
    197828 ±  4%     +10.7%     219020        meminfo.Active(anon)
   7433766 ± 14%     +25.1%    9300322 ±  5%  meminfo.Cached
   5681250 ± 18%     +33.0%    7558762 ±  6%  meminfo.Committed_AS
   5147786 ± 20%     +36.2%    7010760 ±  6%  meminfo.Inactive
   5147589 ± 20%     +36.2%    7010560 ±  6%  meminfo.Inactive(anon)
  11052237 ±  9%     +17.1%   12940406 ±  3%  meminfo.Memused
   4718879 ± 22%     +39.6%    6585374 ±  7%  meminfo.Shmem
  11219273 ±  9%     +17.0%   13129328 ±  3%  meminfo.max_used_kB
    739563            -4.8%     703970        hackbench.throughput
    728804            -4.2%     698518        hackbench.throughput_avg
    739563            -4.8%     703970        hackbench.throughput_best
    703747            -1.6%     692698        hackbench.throughput_worst
    145.81            +4.2%     151.93        hackbench.time.elapsed_time
    145.81            +4.2%     151.93        hackbench.time.elapsed_time.max
 1.617e+08           -99.5%     820613        hackbench.time.involuntary_context_switches
    177419            +5.0%     186254        hackbench.time.minor_page_faults
     29800            +4.4%      31096        hackbench.time.system_time
      1370            -5.7%       1292        hackbench.time.user_time
 6.081e+08           -52.7%  2.879e+08        hackbench.time.voluntary_context_switches
     49436 ±  4%     +10.7%      54736        proc-vmstat.nr_active_anon
    156662            +2.8%     161046        proc-vmstat.nr_anon_pages
   1857775 ± 14%     +25.1%    2324649 ±  5%  proc-vmstat.nr_file_pages
   1286180 ± 20%     +36.2%    1752228 ±  6%  proc-vmstat.nr_inactive_anon
   1179052 ± 22%     +39.6%    1645911 ±  7%  proc-vmstat.nr_shmem
    152254            +4.6%     159244        proc-vmstat.nr_slab_unreclaimable
     49436 ±  4%     +10.7%      54736        proc-vmstat.nr_zone_active_anon
   1286180 ± 20%     +36.2%    1752228 ±  6%  proc-vmstat.nr_zone_inactive_anon
    542581 ± 15%     +28.9%     699338 ±  4%  proc-vmstat.numa_hint_faults
   2979572 ± 11%     +23.5%    3680914 ±  4%  proc-vmstat.numa_hit
   2631931 ± 13%     +26.5%    3330495 ±  4%  proc-vmstat.numa_local
     82333 ±  2%      +6.5%      87675 ±  2%  proc-vmstat.pgactivate
   4134461 ±  8%     +29.6%    5358720 ±  3%  proc-vmstat.pgalloc_normal
   1713524 ±  4%     +10.2%    1889151        proc-vmstat.pgfault
   2097823           +30.8%    2744388        proc-vmstat.pgfree
      0.68           +45.7%       0.99        perf-stat.i.MPKI
 7.654e+10            -7.5%  7.083e+10        perf-stat.i.branch-instructions
      7.88            +3.4       11.29        perf-stat.i.cache-miss-rate%
 2.713e+08           +37.6%  3.733e+08        perf-stat.i.cache-misses
 3.515e+09            -5.6%  3.319e+09        perf-stat.i.cache-references
   5504254           -60.8%    2158477        perf-stat.i.context-switches
      1.91            +8.8%       2.08        perf-stat.i.cpi
    733816           -13.7%     633594        perf-stat.i.cpu-migrations
      2890           -26.9%       2112        perf-stat.i.cycles-between-cache-misses
      0.01 ±  8%      +0.0        0.02 ±  4%  perf-stat.i.dTLB-load-miss-rate%
  13018959 ±  7%     +25.1%   16280772 ±  4%  perf-stat.i.dTLB-load-misses
 1.111e+11            -7.3%   1.03e+11        perf-stat.i.dTLB-loads
      0.01 ± 15%      +0.0        0.01 ±  5%  perf-stat.i.dTLB-store-miss-rate%
   3972585 ± 14%     +40.9%    5597716 ±  5%  perf-stat.i.dTLB-store-misses
 6.844e+10            -7.3%  6.344e+10        perf-stat.i.dTLB-stores
 2.533e+08 ±  8%     -19.9%   2.03e+08        perf-stat.i.iTLB-load-misses
   5777737            +7.5%    6211845 ±  2%  perf-stat.i.iTLB-loads
 4.075e+11            -7.3%  3.778e+11        perf-stat.i.instructions
      0.52            -8.3%       0.48        perf-stat.i.ipc
      3.46            +1.2%       3.50        perf-stat.i.metric.GHz
    806.15           +43.5%       1156        perf-stat.i.metric.K/sec
      1158            -7.4%       1073        perf-stat.i.metric.M/sec
  42534701           +44.0%   61247922        perf-stat.i.node-load-misses
  48366476 ±  2%     +45.0%   70147043        perf-stat.i.node-loads
     36.75            +5.4       42.11        perf-stat.i.node-store-miss-rate%
  27919430           +71.2%   47811964        perf-stat.i.node-store-misses
  46266177           +42.3%   65859572        perf-stat.i.node-stores
      0.67           +48.4%       0.99        perf-stat.overall.MPKI
      7.72            +3.5       11.25        perf-stat.overall.cache-miss-rate%
      1.90            +9.2%       2.08        perf-stat.overall.cpi
      2858           -26.5%       2102        perf-stat.overall.cycles-between-cache-misses
      0.01 ±  7%      +0.0        0.02 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ± 14%      +0.0        0.01 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
      0.53            -8.4%       0.48        perf-stat.overall.ipc
     37.36            +4.5       41.90        perf-stat.overall.node-store-miss-rate%
 7.604e+10            -7.6%  7.027e+10        perf-stat.ps.branch-instructions
 2.695e+08           +37.4%  3.703e+08        perf-stat.ps.cache-misses
  3.49e+09            -5.7%  3.293e+09        perf-stat.ps.cache-references
   5460869           -60.7%    2145220        perf-stat.ps.context-switches
    727414           -13.5%     629220        perf-stat.ps.cpu-migrations
  13347934 ±  7%     +24.1%   16558649 ±  4%  perf-stat.ps.dTLB-load-misses
 1.104e+11            -7.5%  1.022e+11        perf-stat.ps.dTLB-loads
   3960394 ± 14%     +40.1%    5546955 ±  5%  perf-stat.ps.dTLB-store-misses
   6.8e+10            -7.4%  6.294e+10        perf-stat.ps.dTLB-stores
 2.516e+08 ±  8%     -20.0%  2.012e+08        perf-stat.ps.iTLB-load-misses
   5624655            +9.7%    6169172 ±  2%  perf-stat.ps.iTLB-loads
 4.049e+11            -7.4%  3.748e+11        perf-stat.ps.instructions
  42012686           +44.0%   60495775        perf-stat.ps.node-load-misses
  48376582 ±  2%     +44.7%   69980029        perf-stat.ps.node-loads
  27483719           +71.8%   47215357        perf-stat.ps.node-store-misses
  46080326           +42.1%   65466159        perf-stat.ps.node-stores
 5.906e+13            -3.4%  5.707e+13        perf-stat.total.instructions
      3.74            -2.5        1.20 ±  3%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_write_iter.vfs_write
      5.21            -2.5        2.69        perf-profile.calltrace.cycles-pp.sock_def_readable.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
      2.78            -1.8        0.93        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_write_iter
      2.68            -1.8        0.89        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg
      2.64            -1.8        0.88        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable
      2.81            -1.6        1.19        perf-profile.calltrace.cycles-pp.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      2.41            -1.4        1.03        perf-profile.calltrace.cycles-pp.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      2.32            -1.3        1.00        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
      2.30            -1.3        0.99        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic
     46.71            -1.3       45.43        perf-profile.calltrace.cycles-pp.__libc_write.start_thread
     45.23            -1.2       43.99        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write.start_thread
     44.99            -1.2       43.77        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.start_thread
     39.77            -1.0       38.79        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
     44.22            -1.0       43.24        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.start_thread
     37.63            -0.9       36.74        perf-profile.calltrace.cycles-pp.sock_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.89            -0.8       35.05        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write.do_syscall_64
      1.12 ± 20%      -0.7        0.42 ± 71%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      2.16 ±  8%      -0.6        1.55 ± 15%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      1.53 ±  7%      -0.5        1.01 ± 14%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.54 ±  7%      -0.5        1.02 ± 14%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      1.53 ±  7%      -0.5        1.01 ± 14%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.53 ±  7%      -0.5        1.01 ± 14%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      3.68 ±  5%      -0.5        3.19        perf-profile.calltrace.cycles-pp.__kmem_cache_free.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      1.43 ±  7%      -0.5        0.96 ± 14%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.39 ±  7%      -0.5        0.94 ± 14%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.39 ±  7%      -0.5        0.94 ± 14%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.38 ±  7%      -0.4        0.93 ± 14%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.55 ±  3%      -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__kmem_cache_free.skb_release_data.consume_skb.unix_stream_read_generic
      1.32 ±  2%      -0.2        1.16        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1.32 ±  3%      -0.1        1.18        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.__kmem_cache_alloc_node.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
      2.60            -0.1        2.49        perf-profile.calltrace.cycles-pp.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
      0.97 ±  2%      -0.1        0.88 ±  3%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84            -0.1        0.75        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      0.92            -0.1        0.83        perf-profile.calltrace.cycles-pp.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      0.83 ±  4%      -0.1        0.75 ±  5%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_read.ksys_read.do_syscall_64
      0.76 ±  3%      -0.1        0.69        perf-profile.calltrace.cycles-pp.security_socket_recvmsg.sock_recvmsg.sock_read_iter.vfs_read.ksys_read
      0.64 ±  3%      -0.1        0.58        perf-profile.calltrace.cycles-pp.fput.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      0.71 ±  2%      -0.1        0.65 ±  2%  perf-profile.calltrace.cycles-pp.__pthread_disable_asynccancel.start_thread
      1.28            -0.1        1.22        perf-profile.calltrace.cycles-pp.__check_object_size.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter.vfs_write
      1.11            -0.0        1.06        perf-profile.calltrace.cycles-pp._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter.vfs_write
      0.63            -0.0        0.59 ±  2%  perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter
      0.64            -0.0        0.61        perf-profile.calltrace.cycles-pp.__pthread_enable_asynccancel.start_thread
      0.78            -0.0        0.75        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter
      0.55 ±  2%      -0.0        0.53        perf-profile.calltrace.cycles-pp.__check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      1.67            +0.1        1.74        perf-profile.calltrace.cycles-pp.__build_skb_around.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      0.54 ±  4%      +0.1        0.61 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.unix_stream_sendmsg.sock_write_iter.vfs_write
      2.96            +0.1        3.05        perf-profile.calltrace.cycles-pp.__slab_free.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      3.01            +0.1        3.11        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      2.92            +0.1        3.03        perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      2.16            +0.1        2.29        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      3.05            +0.1        3.19        perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
      2.52            +0.2        2.73        perf-profile.calltrace.cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.consume_skb.unix_stream_read_generic
      2.64            +0.2        2.88        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      2.71            +0.2        2.96        perf-profile.calltrace.cycles-pp.unix_destruct_scm.skb_release_head_state.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      2.84            +0.2        3.09        perf-profile.calltrace.cycles-pp.skb_release_head_state.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      2.34            +0.3        2.60        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      2.11            +0.3        2.38        perf-profile.calltrace.cycles-pp.rep_movs_alternative.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      5.91            +0.3        6.24        perf-profile.calltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      5.86            +0.3        6.20        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      5.79            +0.3        6.13        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg
     98.04            +0.5       98.54        perf-profile.calltrace.cycles-pp.start_thread
      6.88 ±  3%      +0.7        7.59 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      2.53 ±  2%      +1.2        3.75 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.kmem_cache_alloc_node
      2.59 ±  2%      +1.2        3.82 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.kmem_cache_alloc_node.__alloc_skb
      2.88 ±  2%      +1.3        4.19 ±  5%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      7.84 ±  2%      +1.3        9.18        perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      7.01 ±  2%      +1.3        8.35 ±  2%  perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      6.98 ±  2%      +1.4        8.34 ±  2%  perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_node.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      3.42            +1.4        4.81 ±  4%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      2.66 ±  7%      +1.4        4.06 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.__kmem_cache_alloc_node
      2.71 ±  6%      +1.4        4.13 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.__kmem_cache_alloc_node.__kmalloc_node_track_caller
      3.00 ±  6%      +1.5        4.50 ±  4%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__kmem_cache_alloc_node.__kmalloc_node_track_caller.kmalloc_reserve
      3.54 ±  5%      +1.6        5.14 ±  4%  perf-profile.calltrace.cycles-pp.___slab_alloc.__kmem_cache_alloc_node.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb
     20.34            +1.7       22.08        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
      4.01 ±  2%      +1.9        5.89 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__unfreeze_partials.unix_stream_read_generic.unix_stream_recvmsg
     49.14            +1.9       51.05        perf-profile.calltrace.cycles-pp.__libc_read.start_thread
      4.12 ±  2%      +1.9        6.03 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__unfreeze_partials.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      4.36 ±  2%      +2.0        6.34 ±  5%  perf-profile.calltrace.cycles-pp.__unfreeze_partials.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
     12.34 ±  2%      +2.0       14.35 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
     17.40            +2.1       19.47        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write
     17.25            +2.1       19.32        perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
     47.43            +2.1       49.54        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read.start_thread
     47.19            +2.1       49.33        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read.start_thread
      4.18 ±  7%      +2.2        6.37 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__unfreeze_partials.skb_release_data.consume_skb
      4.29 ±  7%      +2.2        6.51 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__unfreeze_partials.skb_release_data.consume_skb.unix_stream_read_generic
     15.54            +2.2       17.79        perf-profile.calltrace.cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      4.54 ±  6%      +2.3        6.82 ±  4%  perf-profile.calltrace.cycles-pp.__unfreeze_partials.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
     45.06            +2.3       47.40        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
     46.29            +2.4       48.67        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read.start_thread
     42.45            +2.5       44.99        perf-profile.calltrace.cycles-pp.sock_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.82            +2.6       44.42        perf-profile.calltrace.cycles-pp.sock_recvmsg.sock_read_iter.vfs_read.ksys_read.do_syscall_64
     40.90            +2.7       43.60        perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_recvmsg.sock_read_iter.vfs_read.ksys_read
     40.69            +2.7       43.42        perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter.vfs_read
      5.22            -2.5        2.70        perf-profile.children.cycles-pp.sock_def_readable
      4.10            -2.5        1.58 ±  2%  perf-profile.children.cycles-pp.__wake_up_common_lock
      3.12            -1.8        1.30        perf-profile.children.cycles-pp.__wake_up_common
      3.16            -1.8        1.36        perf-profile.children.cycles-pp.__schedule
      3.02            -1.8        1.26        perf-profile.children.cycles-pp.autoremove_wake_function
      2.98            -1.7        1.23        perf-profile.children.cycles-pp.try_to_wake_up
      3.05            -1.7        1.33        perf-profile.children.cycles-pp.schedule
      2.82            -1.6        1.19        perf-profile.children.cycles-pp.unix_stream_data_wait
      2.78            -1.4        1.37        perf-profile.children.cycles-pp.schedule_timeout
     47.15            -1.3       45.86        perf-profile.children.cycles-pp.__libc_write
     39.82            -1.0       38.84        perf-profile.children.cycles-pp.vfs_write
     44.25            -1.0       43.28        perf-profile.children.cycles-pp.ksys_write
      1.51            -0.9        0.59        perf-profile.children.cycles-pp.ttwu_do_activate
     37.65            -0.9       36.76        perf-profile.children.cycles-pp.sock_write_iter
     35.97            -0.8       35.13        perf-profile.children.cycles-pp.unix_stream_sendmsg
      1.38            -0.8        0.60        perf-profile.children.cycles-pp.activate_task
      1.33            -0.8        0.58        perf-profile.children.cycles-pp.enqueue_task_fair
      1.69 ± 17%      -0.6        1.06 ± 10%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      1.16 ± 24%      -0.6        0.54 ± 13%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      1.08            -0.6        0.51        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.88            -0.6        0.32 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      1.54 ±  7%      -0.5        1.02 ± 14%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      1.54 ±  7%      -0.5        1.02 ± 14%  perf-profile.children.cycles-pp.cpu_startup_entry
      1.53 ±  7%      -0.5        1.01 ± 14%  perf-profile.children.cycles-pp.start_secondary
      1.54 ±  7%      -0.5        1.02 ± 14%  perf-profile.children.cycles-pp.do_idle
      0.99            -0.5        0.48        perf-profile.children.cycles-pp.dequeue_task_fair
      3.68 ±  5%      -0.5        3.19        perf-profile.children.cycles-pp.__kmem_cache_free
      1.43 ±  7%      -0.5        0.96 ± 14%  perf-profile.children.cycles-pp.cpuidle_idle_call
      1.40 ±  7%      -0.5        0.94 ± 14%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.80            -0.5        0.34        perf-profile.children.cycles-pp.enqueue_entity
      1.40 ±  7%      -0.5        0.94 ± 14%  perf-profile.children.cycles-pp.cpuidle_enter
      1.38 ±  7%      -0.4        0.93 ± 14%  perf-profile.children.cycles-pp.acpi_safe_halt
      1.38 ±  7%      -0.4        0.94 ± 14%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.94            -0.4        0.49        perf-profile.children.cycles-pp.pick_next_task_fair
      0.57 ±  3%      -0.4        0.18 ±  3%  perf-profile.children.cycles-pp.prepare_to_wait
      0.77            -0.4        0.39        perf-profile.children.cycles-pp.update_load_avg
      1.22 ±  7%      -0.4        0.85 ± 15%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.60 ±  4%      -0.3        0.28 ±  2%  perf-profile.children.cycles-pp.select_task_rq
      0.53 ±  2%      -0.3        0.21        perf-profile.children.cycles-pp.update_curr
      4.53            -0.3        4.22        perf-profile.children.cycles-pp._raw_spin_lock
      0.56 ±  4%      -0.3        0.26 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      2.65 ±  3%      -0.3        2.36        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.51            -0.2        0.26        perf-profile.children.cycles-pp.dequeue_entity
      0.27            -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.set_next_entity
      0.31            -0.2        0.13 ±  2%  perf-profile.children.cycles-pp.reweight_entity
      0.24 ±  2%      -0.2        0.08 ±  6%  perf-profile.children.cycles-pp.__enqueue_entity
      0.21 ±  2%      -0.2        0.05        perf-profile.children.cycles-pp.pick_eevdf
      0.36            -0.2        0.20 ±  2%  perf-profile.children.cycles-pp.switch_fpu_return
      0.24            -0.2        0.08 ±  5%  perf-profile.children.cycles-pp.prepare_task_switch
      0.28 ±  9%      -0.2        0.12 ±  6%  perf-profile.children.cycles-pp.select_idle_sibling
      0.49 ±  2%      -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.update_cfs_group
      0.18 ± 12%      -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.finish_task_switch
      0.22            -0.1        0.10 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.20 ±  2%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      1.94 ±  2%      -0.1        1.81 ±  2%  perf-profile.children.cycles-pp.security_file_permission
      2.62            -0.1        2.51        perf-profile.children.cycles-pp.skb_copy_datagram_from_iter
      0.21            -0.1        0.10        perf-profile.children.cycles-pp.wake_affine
      1.70 ±  2%      -0.1        1.60 ±  3%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.26            -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.20 ±  2%      -0.1        0.10        perf-profile.children.cycles-pp.__switch_to_asm
      0.23            -0.1        0.13        perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.91            -0.1        0.81 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.15 ±  2%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.___perf_sw_event
      0.51 ±  6%      -0.1        0.42        perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.14 ±  2%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__dequeue_entity
      0.11 ±  3%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.92            -0.1        0.84        perf-profile.children.cycles-pp.skb_unlink
      0.19 ±  5%      -0.1        0.10 ± 11%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.93 ±  2%      -0.1        0.85        perf-profile.children.cycles-pp.fput
      0.13 ± 10%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.available_idle_cpu
      0.14 ± 18%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.select_idle_cpu
      0.17 ±  5%      -0.1        0.09 ± 14%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.17 ±  4%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.77 ±  2%      -0.1        0.70        perf-profile.children.cycles-pp.security_socket_recvmsg
      0.14 ±  2%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__switch_to
      1.71            -0.1        1.65        perf-profile.children.cycles-pp.mod_objcg_state
      0.67            -0.1        0.61        perf-profile.children.cycles-pp.__cond_resched
      0.14 ±  4%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.13            -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.task_h_load
      0.71 ±  2%      -0.1        0.65        perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.56            -0.1        0.50        perf-profile.children.cycles-pp.mutex_lock
      0.11 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.perf_tp_event
      1.12            -0.0        1.07        perf-profile.children.cycles-pp._copy_from_iter
      1.42            -0.0        1.38        perf-profile.children.cycles-pp.__entry_text_start
      0.64            -0.0        0.61        perf-profile.children.cycles-pp.__pthread_enable_asynccancel
      0.92            -0.0        0.89        perf-profile.children.cycles-pp.copyin
      0.33            -0.0        0.30        perf-profile.children.cycles-pp.__get_task_ioprio
      0.91            -0.0        0.88        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.09            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.35            -0.0        0.33        perf-profile.children.cycles-pp.refill_obj_stock
      0.07 ±  7%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.07 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.set_task_cpu
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.put_pid
      0.06 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp.find_busiest_group
      0.06 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.06 ±  9%      +0.0        0.07        perf-profile.children.cycles-pp.update_sg_lb_stats
      0.12 ±  3%      +0.0        0.14        perf-profile.children.cycles-pp.put_cpu_partial
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.detach_tasks
      0.08 ± 13%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.24            +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.load_balance
      0.24            +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.newidle_balance
      1.68            +0.1        1.75        perf-profile.children.cycles-pp.__build_skb_around
      0.11 ±  6%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.__x64_sys_read
      2.83            +0.1        2.92        perf-profile.children.cycles-pp.check_heap_object
      5.70            +0.1        5.80        perf-profile.children.cycles-pp.__slab_free
      3.02            +0.1        3.12        perf-profile.children.cycles-pp.simple_copy_to_iter
      0.30 ±  3%      +0.1        0.41 ± 12%  perf-profile.children.cycles-pp.get_any_partial
      2.52            +0.2        2.73        perf-profile.children.cycles-pp.sock_wfree
      2.65            +0.2        2.89        perf-profile.children.cycles-pp._copy_to_iter
      2.86            +0.2        3.10        perf-profile.children.cycles-pp.skb_release_head_state
      2.68            +0.2        2.92        perf-profile.children.cycles-pp.rep_movs_alternative
      2.80            +0.2        3.05        perf-profile.children.cycles-pp.unix_destruct_scm
      2.46            +0.3        2.72        perf-profile.children.cycles-pp.copyout
      5.91            +0.3        6.24        perf-profile.children.cycles-pp.unix_stream_read_actor
      5.87            +0.3        6.20        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      5.80            +0.3        6.14        perf-profile.children.cycles-pp.__skb_datagram_iter
     98.04            +0.5       98.54        perf-profile.children.cycles-pp.start_thread
      6.94 ±  3%      +0.7        7.64 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
     92.75            +0.9       93.61        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     92.26            +0.9       93.16        perf-profile.children.cycles-pp.do_syscall_64
      7.88 ±  2%      +1.3        9.21        perf-profile.children.cycles-pp.kmalloc_reserve
      7.06 ±  2%      +1.3        8.41 ±  2%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      7.37 ±  2%      +1.4        8.72 ±  2%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
     20.35            +1.7       22.09        perf-profile.children.cycles-pp.sock_alloc_send_pskb
     49.57            +1.9       51.46        perf-profile.children.cycles-pp.__libc_read
     12.35 ±  2%      +2.0       14.36 ±  2%  perf-profile.children.cycles-pp.skb_release_data
     17.42            +2.1       19.49        perf-profile.children.cycles-pp.alloc_skb_with_frags
     17.28            +2.1       19.36        perf-profile.children.cycles-pp.__alloc_skb
     15.57            +2.2       17.82        perf-profile.children.cycles-pp.consume_skb
     45.09            +2.3       47.42        perf-profile.children.cycles-pp.vfs_read
     46.32            +2.4       48.69        perf-profile.children.cycles-pp.ksys_read
     42.47            +2.5       45.01        perf-profile.children.cycles-pp.sock_read_iter
     41.85            +2.6       44.45        perf-profile.children.cycles-pp.sock_recvmsg
     40.92            +2.7       43.61        perf-profile.children.cycles-pp.unix_stream_recvmsg
     40.76            +2.7       43.48        perf-profile.children.cycles-pp.unix_stream_read_generic
      6.17 ±  3%      +2.9        9.10 ±  2%  perf-profile.children.cycles-pp.get_partial_node
      6.96 ±  2%      +3.0        9.94 ±  2%  perf-profile.children.cycles-pp.___slab_alloc
      8.90 ±  3%      +4.3       13.17 ±  2%  perf-profile.children.cycles-pp.__unfreeze_partials
     18.14 ±  2%      +5.7       23.84 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     15.76 ±  2%      +5.7       21.46 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.14 ± 25%      -0.6        0.53 ± 13%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      1.20 ±  7%      -0.4        0.84 ± 14%  perf-profile.self.cycles-pp.acpi_safe_halt
      2.58 ±  6%      -0.4        2.23        perf-profile.self.cycles-pp.__kmem_cache_free
      1.96 ±  4%      -0.3        1.66        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.48 ±  3%      -0.3        0.20        perf-profile.self.cycles-pp.__schedule
      3.28            -0.2        3.07        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.24 ±  2%      -0.2        0.07 ±  6%  perf-profile.self.cycles-pp.__enqueue_entity
      0.26 ±  2%      -0.2        0.10 ±  5%  perf-profile.self.cycles-pp.update_curr
      0.49 ±  2%      -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.update_cfs_group
      0.32            -0.1        0.19 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      0.20            -0.1        0.08        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.21            -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_se
      1.53            -0.1        1.42        perf-profile.self.cycles-pp.mod_objcg_state
      0.26            -0.1        0.16 ±  2%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.20 ±  2%      -0.1        0.10        perf-profile.self.cycles-pp.__switch_to_asm
      0.18            -0.1        0.08        perf-profile.self.cycles-pp.reweight_entity
      3.58            -0.1        3.49        perf-profile.self.cycles-pp._raw_spin_lock
      0.18 ± 22%      -0.1        0.09 ±  8%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      2.26            -0.1        2.17        perf-profile.self.cycles-pp.unix_stream_sendmsg
      0.14 ±  2%      -0.1        0.05        perf-profile.self.cycles-pp.___perf_sw_event
      0.90 ±  2%      -0.1        0.82        perf-profile.self.cycles-pp.fput
      0.13 ±  8%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.available_idle_cpu
      1.05            -0.1        0.97        perf-profile.self.cycles-pp.vfs_read
      0.10 ±  3%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.schedule_timeout
      0.14 ±  2%      -0.1        0.07 ±  6%  perf-profile.self.cycles-pp.__switch_to
      0.11 ±  4%      -0.1        0.05        perf-profile.self.cycles-pp.try_to_wake_up
      0.43            -0.1        0.37        perf-profile.self.cycles-pp.mutex_lock
      0.13 ±  2%      -0.1        0.07        perf-profile.self.cycles-pp.enqueue_task_fair
      0.13            -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.task_h_load
      0.62            -0.1        0.56        perf-profile.self.cycles-pp.sock_read_iter
      0.11            -0.1        0.05 ±  7%  perf-profile.self.cycles-pp.enqueue_entity
      0.69 ±  2%      -0.1        0.63 ±  2%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.72 ±  5%      -0.1        0.67        perf-profile.self.cycles-pp.__libc_read
      1.04            -0.0        1.00        perf-profile.self.cycles-pp.vfs_write
      0.34            -0.0        0.30        perf-profile.self.cycles-pp.unix_write_space
      0.10            -0.0        0.06        perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.09 ±  4%      -0.0        0.05        perf-profile.self.cycles-pp.perf_tp_event
      0.50            -0.0        0.47        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.63            -0.0        0.60 ±  2%  perf-profile.self.cycles-pp.__pthread_enable_asynccancel
      0.87            -0.0        0.84        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.31            -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.__get_task_ioprio
      0.16 ±  3%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.unix_stream_recvmsg
      0.79            -0.0        0.77        perf-profile.self.cycles-pp.__alloc_skb
      0.12            -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.40            -0.0        0.38        perf-profile.self.cycles-pp.copyout
      0.34            -0.0        0.32        perf-profile.self.cycles-pp.refill_obj_stock
      0.18 ±  2%      -0.0        0.16        perf-profile.self.cycles-pp.sock_recvmsg
      0.14 ±  3%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.20 ±  2%      -0.0        0.18        perf-profile.self.cycles-pp.do_syscall_64
      0.36            -0.0        0.35        perf-profile.self.cycles-pp.consume_skb
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp._copy_from_iter
      0.19            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.skb_copy_datagram_from_iter
      0.19            -0.0        0.18        perf-profile.self.cycles-pp._copy_to_iter
      0.08 ±  5%      +0.0        0.10        perf-profile.self.cycles-pp.put_pid
      0.12            +0.0        0.14        perf-profile.self.cycles-pp.put_cpu_partial
      0.52            +0.0        0.54 ±  2%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      0.08 ± 12%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.18 ±  2%      +0.0        0.21 ±  3%  perf-profile.self.cycles-pp.ksys_read
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.76            +0.1        0.82        perf-profile.self.cycles-pp.___slab_alloc
      1.66            +0.1        1.73        perf-profile.self.cycles-pp.__build_skb_around
      0.10 ±  5%      +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.__x64_sys_read
      0.39            +0.1        0.48        perf-profile.self.cycles-pp.__unfreeze_partials
      5.66            +0.1        5.75        perf-profile.self.cycles-pp.__slab_free
      0.42 ±  2%      +0.1        0.54        perf-profile.self.cycles-pp.get_partial_node
      0.94 ±  2%      +0.1        1.06 ±  2%  perf-profile.self.cycles-pp.skb_release_data
      1.88            +0.1        2.03        perf-profile.self.cycles-pp.check_heap_object
      1.76            +0.2        1.97        perf-profile.self.cycles-pp.sock_wfree
      2.51            +0.3        2.77        perf-profile.self.cycles-pp.rep_movs_alternative
     15.74 ±  2%      +5.7       21.44 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-csl-2sp3: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/rootfs/tbox_group/testcase:
  gcc-12/performance/1SSD/xfs/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp3/blogbench

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      7499 ±  5%     +13.3%       8495 ±  2%  perf-c2c.DRAM.local
 3.527e+08 ±  9%     +54.6%  5.453e+08 ±  6%  cpuidle..time
    415301 ±  8%     +58.9%     659888 ±  7%  cpuidle..usage
      1.66 ±  9%     +46.7%       2.43 ±  5%  iostat.cpu.idle
      1.74 ±  2%      -4.9%       1.65        iostat.cpu.user
      1.01 ± 15%      +0.8        1.79 ±  8%  mpstat.cpu.all.idle%
      0.00 ± 27%      +0.0        0.00 ± 22%  mpstat.cpu.all.iowait%
      1.78 ±  9%      -0.4        1.37 ±  5%  mpstat.cpu.all.soft%
 1.151e+08           -62.0%   43742493        blogbench.time.file_system_outputs
   1810540           -55.7%     801888        blogbench.time.involuntary_context_switches
   1287050           -56.5%     560205        blogbench.time.voluntary_context_switches
     13606           -59.3%       5540        blogbench.write_score
   9989139 ± 20%     -31.4%    6849227 ±  6%  numa-numastat.node0.local_node
  10015980 ± 20%     -31.2%    6894845 ±  6%  numa-numastat.node0.numa_hit
  13369217 ± 13%     -52.5%    6349579 ±  5%  numa-numastat.node1.local_node
  13425354 ± 13%     -52.3%    6403904 ±  5%  numa-numastat.node1.numa_hit
    182611           -61.1%      70997        vmstat.io.bo
  30794675           -50.4%   15267505        vmstat.memory.cache
  97798124           +17.0%  1.144e+08        vmstat.memory.free
     15769           -50.3%       7831        vmstat.system.cs
    113890            -6.3%     106679        vmstat.system.in
     23666 ± 16%     +55.2%      36720 ± 25%  turbostat.C1
     47654 ± 13%     +52.6%      72730 ±  7%  turbostat.C1E
      0.04 ± 16%      +0.0        0.09 ±  7%  turbostat.C1E%
    307535 ± 11%     +64.9%     506978 ±  6%  turbostat.C6
      1.13 ± 11%      +0.6        1.74 ±  6%  turbostat.C6%
      0.96 ± 10%     +63.3%       1.57 ±  5%  turbostat.CPU%c1
      6890 ± 17%    +111.9%      14603 ±  7%  turbostat.POLL
  19729599           -54.9%    8903829        meminfo.Active
  19418799           -55.6%    8619704        meminfo.Active(file)
  28310960           -50.1%   14140405        meminfo.Cached
   5407969           -62.9%    2004774 ±  2%  meminfo.Dirty
   6129889           -54.6%    2783669 ±  2%  meminfo.Inactive
   5814371           -57.6%    2466804 ±  2%  meminfo.Inactive(file)
   2388126           -54.5%    1086718        meminfo.KReclaimable
     27378 ±  2%     -20.0%      21915        meminfo.KernelStack
  97898878           +16.9%  1.144e+08        meminfo.MemFree
  33785080           -48.9%   17257562        meminfo.Memused
   2388126           -54.5%    1086718        meminfo.SReclaimable
   1528111           -43.5%     862709        meminfo.SUnreclaim
   3916238           -50.2%    1949429        meminfo.Slab
  33786668           -48.9%   17265013        meminfo.max_used_kB
  12164579 ± 25%     -32.6%    8196575 ± 15%  numa-meminfo.node0.FilePages
     14656 ± 10%     -20.6%      11638 ±  9%  numa-meminfo.node0.KernelStack
  14648986 ± 24%     -32.7%    9851554 ± 14%  numa-meminfo.node0.MemUsed
  11750087 ± 19%     -67.7%    3793215 ± 18%  numa-meminfo.node1.Active
  11512623 ± 19%     -69.0%    3564771 ± 20%  numa-meminfo.node1.Active(file)
   3393154 ± 20%     -73.2%     907764 ± 14%  numa-meminfo.node1.Dirty
  16142152 ± 18%     -63.2%    5940861 ± 21%  numa-meminfo.node1.FilePages
   3616437 ± 18%     -66.7%    1204429 ± 16%  numa-meminfo.node1.Inactive
   3461709 ± 18%     -71.2%     997578 ± 18%  numa-meminfo.node1.Inactive(file)
   1363742 ± 18%     -66.7%     454332 ± 19%  numa-meminfo.node1.KReclaimable
  46878383 ±  7%     +25.0%   58606546 ±  2%  numa-meminfo.node1.MemFree
  19130463 ± 18%     -61.3%    7402301 ± 18%  numa-meminfo.node1.MemUsed
   1363742 ± 18%     -66.7%     454332 ± 19%  numa-meminfo.node1.SReclaimable
   2165606 ± 21%     -60.4%     856793 ± 15%  numa-meminfo.node1.Slab
   3042027 ± 25%     -32.7%    2048741 ± 15%  numa-vmstat.node0.nr_file_pages
     14657 ± 10%     -20.6%      11640 ±  9%  numa-vmstat.node0.nr_kernel_stack
  10016173 ± 20%     -31.2%    6894532 ±  6%  numa-vmstat.node0.numa_hit
   9989331 ± 20%     -31.4%    6848914 ±  6%  numa-vmstat.node0.numa_local
   2879703 ± 19%     -69.1%     890805 ± 20%  numa-vmstat.node1.nr_active_file
   8866075 ± 19%     -72.6%    2432986 ± 15%  numa-vmstat.node1.nr_dirtied
    848292 ± 20%     -73.2%     227046 ± 14%  numa-vmstat.node1.nr_dirty
   4037556 ± 18%     -63.2%    1484735 ± 21%  numa-vmstat.node1.nr_file_pages
  11717275 ±  7%     +25.0%   14652208 ±  2%  numa-vmstat.node1.nr_free_pages
    865897 ± 18%     -71.2%     249317 ± 18%  numa-vmstat.node1.nr_inactive_file
    341110 ± 18%     -66.7%     113538 ± 19%  numa-vmstat.node1.nr_slab_reclaimable
   7216977 ± 21%     -72.2%    2009178 ± 16%  numa-vmstat.node1.nr_written
   2879702 ± 19%     -69.1%     890805 ± 20%  numa-vmstat.node1.nr_zone_active_file
    865897 ± 18%     -71.2%     249317 ± 18%  numa-vmstat.node1.nr_zone_inactive_file
    848345 ± 20%     -73.2%     227062 ± 14%  numa-vmstat.node1.nr_zone_write_pending
  13425546 ± 13%     -52.3%    6403736 ±  5%  numa-vmstat.node1.numa_hit
  13369409 ± 13%     -52.5%    6349410 ±  5%  numa-vmstat.node1.numa_local
    237454 ± 14%     -46.2%     127707 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    281333 ± 72%    +245.3%     971329 ± 25%  sched_debug.cfs_rq:/.left_vruntime.avg
   1513017 ± 40%    +100.4%    3032618 ± 16%  sched_debug.cfs_rq:/.left_vruntime.stddev
     10.08 ± 25%     +99.0%      20.07 ± 29%  sched_debug.cfs_rq:/.load_avg.min
    237455 ± 14%     -46.2%     127707 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.15 ± 22%     +69.2%       0.25 ± 14%  sched_debug.cfs_rq:/.nr_running.stddev
    281334 ± 72%    +245.3%     971329 ± 25%  sched_debug.cfs_rq:/.right_vruntime.avg
   1513017 ± 40%    +100.4%    3032618 ± 16%  sched_debug.cfs_rq:/.right_vruntime.stddev
      2582 ±  4%     -15.5%       2181 ±  8%  sched_debug.cfs_rq:/.runnable_avg.max
    316.33 ±  5%     -24.3%     239.31 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
    148.04 ± 11%     -17.1%     122.69 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
    687989 ±  4%     +26.2%     868129 ±  2%  sched_debug.cpu.avg_idle.avg
    278391 ±  6%     -22.8%     215039 ±  5%  sched_debug.cpu.avg_idle.stddev
     13.15 ±  9%     -29.1%       9.32 ± 14%  sched_debug.cpu.clock.stddev
    888.73 ±  5%     -11.6%     786.08 ±  4%  sched_debug.cpu.curr->pid.stddev
     27314           -46.1%      14723 ±  5%  sched_debug.cpu.nr_switches.avg
     78618 ±  9%     -42.4%      45244 ± 18%  sched_debug.cpu.nr_switches.max
     13072 ± 19%     -36.9%       8247 ± 11%  sched_debug.cpu.nr_switches.min
     11267 ± 15%     -51.4%       5472 ±  8%  sched_debug.cpu.nr_switches.stddev
     69.78 ± 26%     -37.7%      43.48 ± 14%  sched_debug.cpu.nr_uninterruptible.stddev
     77702            -8.6%      71011 ±  2%  proc-vmstat.nr_active_anon
   4856684           -55.6%    2154541        proc-vmstat.nr_active_file
  14382743           -62.0%    5467742        proc-vmstat.nr_dirtied
   1352052           -62.9%     501053 ±  2%  proc-vmstat.nr_dirty
   3058358            +1.9%    3117839        proc-vmstat.nr_dirty_background_threshold
   6124195            +1.9%    6243302        proc-vmstat.nr_dirty_threshold
   7080320           -50.1%    3534557        proc-vmstat.nr_file_pages
  24471767           +16.9%   28607216        proc-vmstat.nr_free_pages
   1454177           -57.6%     616549 ±  2%  proc-vmstat.nr_inactive_file
     27379 ±  2%     -20.0%      21914        proc-vmstat.nr_kernel_stack
     10068            -3.1%       9757        proc-vmstat.nr_mapped
     80678            -7.9%      74291 ±  2%  proc-vmstat.nr_shmem
    597268           -54.5%     271633        proc-vmstat.nr_slab_reclaimable
    382038           -43.6%     215628        proc-vmstat.nr_slab_unreclaimable
  11806249           -60.5%    4665462        proc-vmstat.nr_written
     77702            -8.6%      71011 ±  2%  proc-vmstat.nr_zone_active_anon
   4856684           -55.6%    2154541        proc-vmstat.nr_zone_active_file
   1454177           -57.6%     616549 ±  2%  proc-vmstat.nr_zone_inactive_file
   1352125           -62.9%     501087 ±  2%  proc-vmstat.nr_zone_write_pending
  23443764           -43.3%   13300295        proc-vmstat.numa_hit
  23360786           -43.5%   13200349        proc-vmstat.numa_local
    101119            -1.5%      99647        proc-vmstat.numa_other
  11447594           -61.5%    4402707        proc-vmstat.pgactivate
  32942601           -36.0%   21069699        proc-vmstat.pgalloc_normal
  19182964           -19.2%   15502671        proc-vmstat.pgfree
  55214729           -61.3%   21390778        proc-vmstat.pgpgout
     11.59            +5.9%      12.28        perf-stat.i.MPKI
 7.491e+09            -5.4%  7.087e+09        perf-stat.i.branch-instructions
      0.41            -0.1        0.34        perf-stat.i.branch-miss-rate%
  30427014           -21.1%   24011532 ±  2%  perf-stat.i.branch-misses
     75.23            +2.9       78.08        perf-stat.i.cache-miss-rate%
 5.097e+08            -4.9%  4.846e+08        perf-stat.i.cache-references
     15802           -50.3%       7853        perf-stat.i.context-switches
      8.89            +6.3%       9.45        perf-stat.i.cpi
    806.13 ±  3%     -59.9%     323.03 ±  2%  perf-stat.i.cpu-migrations
      0.08 ± 13%      -0.0        0.04 ± 21%  perf-stat.i.dTLB-load-miss-rate%
   6792913 ± 14%     -56.3%    2969547 ± 21%  perf-stat.i.dTLB-load-misses
 8.472e+09            -7.3%  7.851e+09        perf-stat.i.dTLB-loads
      0.03 ± 21%      -0.0        0.01 ± 29%  perf-stat.i.dTLB-store-miss-rate%
    581113 ± 21%     -52.1%     278227 ± 30%  perf-stat.i.dTLB-store-misses
 2.264e+09           -16.3%  1.895e+09        perf-stat.i.dTLB-stores
     73.39           +12.8       86.24        perf-stat.i.iTLB-load-miss-rate%
   7089683 ±  2%     -12.3%    6220677 ±  4%  perf-stat.i.iTLB-load-misses
   2589801           -60.2%    1030982 ±  6%  perf-stat.i.iTLB-loads
 3.317e+10            -6.9%  3.089e+10        perf-stat.i.instructions
      4730 ±  2%      +7.0%       5062 ±  4%  perf-stat.i.instructions-per-iTLB-miss
      0.12            -5.1%       0.11        perf-stat.i.ipc
    194.68            -7.5%     180.12        perf-stat.i.metric.M/sec
     73.66            -4.4       69.27        perf-stat.i.node-load-miss-rate%
  92452040            -8.4%   84721005 ±  2%  perf-stat.i.node-load-misses
  33026451           +13.3%   37421493 ±  2%  perf-stat.i.node-loads
     72.82            +2.3       75.13        perf-stat.i.node-store-miss-rate%
  14065332            -4.2%   13479612        perf-stat.i.node-store-misses
   5237884           -15.3%    4436059 ±  2%  perf-stat.i.node-stores
     11.57            +6.2%      12.29        perf-stat.overall.MPKI
      0.41            -0.1        0.34        perf-stat.overall.branch-miss-rate%
     75.34            +3.0       78.30        perf-stat.overall.cache-miss-rate%
      8.87            +6.6%       9.46        perf-stat.overall.cpi
      0.08 ± 13%      -0.0        0.04 ± 21%  perf-stat.overall.dTLB-load-miss-rate%
      0.03 ± 20%      -0.0        0.01 ± 29%  perf-stat.overall.dTLB-store-miss-rate%
     73.19           +12.7       85.85        perf-stat.overall.iTLB-load-miss-rate%
      4690 ±  2%      +6.3%       4983 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.11            -6.2%       0.11        perf-stat.overall.ipc
     73.68            -4.3       69.36        perf-stat.overall.node-load-miss-rate%
     72.85            +2.4       75.26        perf-stat.overall.node-store-miss-rate%
 7.454e+09            -5.3%  7.057e+09        perf-stat.ps.branch-instructions
  30346141           -21.5%   23821173 ±  2%  perf-stat.ps.branch-misses
 5.068e+08            -4.7%  4.828e+08        perf-stat.ps.cache-references
     15735           -50.7%       7755        perf-stat.ps.context-switches
    799.77 ±  3%     -59.9%     320.39 ±  2%  perf-stat.ps.cpu-migrations
   6797855 ± 13%     -56.4%    2960817 ± 21%  perf-stat.ps.dTLB-load-misses
 8.434e+09            -7.3%  7.816e+09        perf-stat.ps.dTLB-loads
    580794 ± 21%     -52.2%     277399 ± 30%  perf-stat.ps.dTLB-store-misses
 2.257e+09           -16.5%  1.884e+09        perf-stat.ps.dTLB-stores
   7044215 ±  2%     -12.2%    6181385 ±  4%  perf-stat.ps.iTLB-load-misses
   2579465           -60.6%    1017233 ±  6%  perf-stat.ps.iTLB-loads
 3.301e+10            -6.8%  3.075e+10        perf-stat.ps.instructions
      2402            -1.1%       2376        perf-stat.ps.minor-faults
  91948654            -8.2%   84415047 ±  2%  perf-stat.ps.node-load-misses
  32841685           +13.6%   37299426 ±  2%  perf-stat.ps.node-loads
  13989660            -4.0%   13428744        perf-stat.ps.node-store-misses
   5212115           -15.3%    4413635 ±  2%  perf-stat.ps.node-stores
      2402            -1.1%       2376        perf-stat.ps.page-faults
  9.94e+12            -6.8%  9.268e+12        perf-stat.total.instructions
      2.51 ± 14%      -1.6        0.92 ± 10%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      2.51 ± 14%      -1.6        0.92 ± 10%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      2.51 ± 14%      -1.6        0.92 ± 10%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      1.97 ± 11%      -1.3        0.71 ±  8%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      1.97 ± 11%      -1.3        0.71 ±  8%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.97 ± 11%      -1.3        0.70 ±  8%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
      1.98 ± 11%      -1.3        0.71 ±  8%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.96 ± 11%      -1.3        0.70 ±  8%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
      1.66 ± 12%      -1.1        0.59 ±  9%  perf-profile.calltrace.cycles-pp.file_free_rcu.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
      2.70 ±  4%      -0.3        2.36 ±  2%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      2.81 ±  3%      -0.3        2.48        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.73 ±  2%      -0.1        0.66        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.82 ±  3%      -0.1        0.76        perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      5.82            +0.4        6.26        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.put_unused_fd.do_sys_openat2.__x64_sys_openat
      5.84            +0.4        6.29        perf-profile.calltrace.cycles-pp._raw_spin_lock.put_unused_fd.do_sys_openat2.__x64_sys_openat.do_syscall_64
      5.86            +0.4        6.30        perf-profile.calltrace.cycles-pp.put_unused_fd.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.67            +0.5       38.16        perf-profile.calltrace.cycles-pp.__close
     37.62            +0.5       38.11        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     37.61            +0.5       38.10        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     37.38            +0.5       37.89        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.alloc_fd
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.native_queued_spin_lock_slowpath._raw_spin_lock.alloc_fd.do_sys_openat2
     36.40            +0.6       36.98        perf-profile.calltrace.cycles-pp.close_fd_get_file.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     36.10            +0.6       36.68        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.close_fd_get_file.__x64_sys_close.do_syscall_64
     36.28            +0.6       36.86        perf-profile.calltrace.cycles-pp._raw_spin_lock.close_fd_get_file.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.35            +1.2       42.56        perf-profile.calltrace.cycles-pp._raw_spin_lock.alloc_fd.do_sys_openat2.__x64_sys_openat.do_syscall_64
     41.16            +1.2       42.37        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.alloc_fd.do_sys_openat2.__x64_sys_openat
     41.65            +1.2       42.86        perf-profile.calltrace.cycles-pp.alloc_fd.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     51.11            +1.3       52.42        perf-profile.calltrace.cycles-pp.__open64
     51.02            +1.3       52.33        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64
     51.03            +1.3       52.34        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64
     50.60            +1.3       51.93        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64
     50.59            +1.3       51.92        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64
      2.51 ± 14%      -1.6        0.92 ± 10%  perf-profile.children.cycles-pp.ret_from_fork_asm
      2.51 ± 14%      -1.6        0.92 ± 10%  perf-profile.children.cycles-pp.ret_from_fork
      2.51 ± 14%      -1.6        0.92 ± 10%  perf-profile.children.cycles-pp.kthread
      1.97 ± 11%      -1.3        0.71 ±  8%  perf-profile.children.cycles-pp.run_ksoftirqd
      1.98 ± 11%      -1.3        0.71 ±  8%  perf-profile.children.cycles-pp.smpboot_thread_fn
      2.21 ± 11%      -0.6        1.62 ±  3%  perf-profile.children.cycles-pp.__do_softirq
      2.19 ± 11%      -0.6        1.60 ±  3%  perf-profile.children.cycles-pp.rcu_do_batch
      2.20 ± 11%      -0.6        1.61 ±  3%  perf-profile.children.cycles-pp.rcu_core
      1.85 ± 11%      -0.5        1.36 ±  3%  perf-profile.children.cycles-pp.file_free_rcu
      2.70 ±  4%      -0.3        2.37        perf-profile.children.cycles-pp.path_openat
      0.54 ± 26%      -0.3        0.21 ± 25%  perf-profile.children.cycles-pp.worker_thread
      0.53 ± 26%      -0.3        0.21 ± 25%  perf-profile.children.cycles-pp.process_one_work
      2.81 ±  3%      -0.3        2.49        perf-profile.children.cycles-pp.do_filp_open
      0.37 ± 37%      -0.2        0.16 ± 31%  perf-profile.children.cycles-pp.wb_workfn
      0.37 ± 37%      -0.2        0.16 ± 31%  perf-profile.children.cycles-pp.wb_do_writeback
      0.37 ± 37%      -0.2        0.16 ± 31%  perf-profile.children.cycles-pp.wb_writeback
      0.37 ± 37%      -0.2        0.16 ± 31%  perf-profile.children.cycles-pp.__writeback_inodes_wb
      0.37 ± 37%      -0.2        0.16 ± 31%  perf-profile.children.cycles-pp.writeback_sb_inodes
      0.36 ± 37%      -0.2        0.16 ± 31%  perf-profile.children.cycles-pp.__writeback_single_inode
      0.36 ± 37%      -0.2        0.16 ± 31%  perf-profile.children.cycles-pp.do_writepages
      0.36 ± 37%      -0.2        0.16 ± 31%  perf-profile.children.cycles-pp.xfs_vm_writepages
      0.35 ± 38%      -0.2        0.15 ± 32%  perf-profile.children.cycles-pp.iomap_writepages
      0.35 ± 38%      -0.2        0.15 ± 32%  perf-profile.children.cycles-pp.write_cache_pages
      0.32 ±  6%      -0.2        0.12 ± 12%  perf-profile.children.cycles-pp.__libc_write
      0.32 ± 39%      -0.2        0.14 ± 32%  perf-profile.children.cycles-pp.xfs_map_blocks
      0.31 ±  6%      -0.2        0.12 ± 14%  perf-profile.children.cycles-pp.ksys_write
      0.32 ± 39%      -0.2        0.14 ± 32%  perf-profile.children.cycles-pp.xfs_bmapi_convert_delalloc
      0.30 ±  5%      -0.2        0.12 ± 14%  perf-profile.children.cycles-pp.vfs_write
      0.29 ±  6%      -0.2        0.11 ± 14%  perf-profile.children.cycles-pp.xfs_file_buffered_write
      0.29 ±  5%      -0.2        0.11 ± 14%  perf-profile.children.cycles-pp.iomap_file_buffered_write
      0.29 ± 42%      -0.2        0.12 ± 36%  perf-profile.children.cycles-pp.xfs_bmapi_allocate
      0.29 ± 42%      -0.2        0.12 ± 36%  perf-profile.children.cycles-pp.xfs_bmap_btalloc
      0.29 ± 42%      -0.2        0.12 ± 36%  perf-profile.children.cycles-pp.xfs_bmap_btalloc_best_length
      0.29 ± 41%      -0.2        0.12 ± 34%  perf-profile.children.cycles-pp.xfs_alloc_vextent_start_ag
      0.27 ±  5%      -0.2        0.10 ± 15%  perf-profile.children.cycles-pp.iomap_write_iter
      0.27 ± 40%      -0.2        0.11 ± 31%  perf-profile.children.cycles-pp.xfs_alloc_ag_vextent_near
      0.59 ±  5%      -0.1        0.45 ±  4%  perf-profile.children.cycles-pp.open_last_lookups
      0.20 ± 10%      -0.1        0.06 ± 19%  perf-profile.children.cycles-pp.lookup_open
      0.20 ± 12%      -0.1        0.07 ± 13%  perf-profile.children.cycles-pp.__xfs_trans_commit
      0.18 ±  9%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp.rename
      0.17 ±  9%      -0.1        0.05 ± 49%  perf-profile.children.cycles-pp.xfs_generic_create
      0.17 ± 12%      -0.1        0.05 ± 46%  perf-profile.children.cycles-pp.__x64_sys_rename
      0.16 ± 10%      -0.1        0.05 ± 46%  perf-profile.children.cycles-pp.do_renameat2
      0.16 ± 11%      -0.1        0.05 ± 49%  perf-profile.children.cycles-pp.xfs_create
      0.16 ± 11%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.xlog_cil_commit
      0.17 ±  7%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.16 ±  5%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.do_flush_stats
      0.16 ±  5%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.16 ±  5%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.mem_cgroup_wb_stats
      0.16 ±  5%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.cgroup_rstat_flush
      0.16 ±  5%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.cgroup_rstat_flush_locked
      0.11 ±  6%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.mem_cgroup_css_rstat_flush
      0.76 ±  2%      -0.1        0.69        perf-profile.children.cycles-pp.__fput
      0.32 ±  8%      -0.1        0.25 ±  6%  perf-profile.children.cycles-pp.inode_permission
      0.29 ±  8%      -0.1        0.22 ±  8%  perf-profile.children.cycles-pp.generic_permission
      0.31 ±  5%      -0.1        0.25 ±  3%  perf-profile.children.cycles-pp.link_path_walk
      0.14 ± 15%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.__slab_free
      0.82 ±  3%      -0.1        0.76        perf-profile.children.cycles-pp.do_open
      0.49 ±  2%      -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.xfs_release
      1.10 ±  2%      -0.1        1.05        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.38 ±  4%      -0.0        0.34 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.07 ±  8%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.touch_atime
      0.29 ±  2%      -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.xfs_can_free_eofblocks
      0.23 ±  4%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.may_open
      0.15 ±  3%      -0.0        0.13 ±  4%  perf-profile.children.cycles-pp.xfs_bmapi_read
      0.13 ±  2%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent
      0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.kmem_cache_free
      0.07 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.___slab_alloc
      0.11 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.down_read
      0.08 ±  5%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.errseq_sample
      0.01 ±223%      +0.2        0.20 ± 44%  perf-profile.children.cycles-pp.intel_idle
      0.01 ±223%      +0.2        0.20 ± 45%  perf-profile.children.cycles-pp.cpuidle_enter
      0.01 ±223%      +0.2        0.20 ± 45%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.01 ±223%      +0.2        0.20 ± 47%  perf-profile.children.cycles-pp.start_secondary
      0.01 ±223%      +0.2        0.21 ± 46%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.01 ±223%      +0.2        0.21 ± 46%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.01 ±223%      +0.2        0.21 ± 46%  perf-profile.children.cycles-pp.do_idle
      0.01 ±223%      +0.2        0.21 ± 46%  perf-profile.children.cycles-pp.cpuidle_idle_call
      5.86            +0.4        6.30        perf-profile.children.cycles-pp.put_unused_fd
     37.68            +0.5       38.18        perf-profile.children.cycles-pp.__close
     37.38            +0.5       37.89        perf-profile.children.cycles-pp.__x64_sys_close
     36.40            +0.6       36.98        perf-profile.children.cycles-pp.close_fd_get_file
      0.59 ±  4%      +0.7        1.24 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.61 ±  4%      +0.7        1.27 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.25 ± 10%      +0.7        0.92 ±  3%  perf-profile.children.cycles-pp.__irq_exit_rcu
     41.65            +1.2       42.86        perf-profile.children.cycles-pp.alloc_fd
     51.13            +1.3       52.43        perf-profile.children.cycles-pp.__open64
     50.61            +1.3       51.94        perf-profile.children.cycles-pp.__x64_sys_openat
     50.60            +1.3       51.92        perf-profile.children.cycles-pp.do_sys_openat2
     96.92            +1.4       98.35        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     96.89            +1.4       98.32        perf-profile.children.cycles-pp.do_syscall_64
     83.67            +2.2       85.87        perf-profile.children.cycles-pp._raw_spin_lock
     83.10            +2.2       85.33        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.85 ± 11%      -0.5        1.36 ±  3%  perf-profile.self.cycles-pp.file_free_rcu
      0.28 ±  8%      -0.1        0.21 ±  7%  perf-profile.self.cycles-pp.generic_permission
      0.14 ± 13%      -0.1        0.08 ± 11%  perf-profile.self.cycles-pp.__slab_free
      1.02 ±  2%      -0.0        0.97        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.58 ±  2%      -0.0        0.54 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.13 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.xfs_iext_lookup_extent
      0.10 ±  3%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.down_read
      0.40            +0.0        0.43        perf-profile.self.cycles-pp._copy_to_iter
      0.01 ±223%      +0.2        0.20 ± 44%  perf-profile.self.cycles-pp.intel_idle
     82.65            +1.6       84.27        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.03 ± 17%     -41.0%       0.02 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.06 ± 77%     -86.0%       0.01 ±181%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_dir_createname
      0.12 ± 47%     -94.3%       0.01 ±205%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_dir_lookup
      0.15 ±101%     -84.6%       0.02 ±157%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_dir_removename
      0.01 ± 72%    +183.3%       0.02 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.10 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      0.08 ±101%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_free_eofblocks
      0.03 ± 85%     -91.9%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.xfs_ilock.xfs_create.xfs_generic_create
      0.12 ±102%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.xfs_ilock.xfs_free_eofblocks.xfs_release
      0.14 ± 31%     -85.3%       0.02 ±141%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.xfs_ilock.xfs_iget_cache_hit.xfs_iget
      0.22 ±115%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.65 ± 59%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.do_mkdirat.__x64_sys_mkdir.do_syscall_64
      0.23 ±  3%     -76.9%       0.05 ± 77%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.08 ± 86%     -97.0%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.13 ± 48%     -86.7%       0.02 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_inode_item_init.xfs_trans_ijoin.xfs_init_new_inode
      0.07 ± 73%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_free_eofblocks.xfs_release
      0.08 ± 69%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_rename.xfs_vn_rename
      0.04 ±111%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_trans_alloc_icreate.xfs_create
      0.07 ±115%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.xlog_ticket_alloc.xfs_log_reserve.xfs_trans_reserve
      0.07 ± 92%     -90.1%       0.01 ±152%  perf-sched.sch_delay.avg.ms.__cond_resched.mnt_want_write.do_renameat2.__x64_sys_rename.do_syscall_64
      0.04 ± 74%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
      0.27 ± 70%   +7399.7%      19.94 ±189%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.04 ±152%  +18500.8%       7.32 ±212%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.17 ± 31%    +159.0%       0.44 ± 26%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.04 ±103%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.05 ±133%   +4237.8%       2.10 ± 60%  perf-sched.sch_delay.avg.ms.kthreadd.ret_from_fork.ret_from_fork_asm
      0.03 ± 61%   +4840.1%       1.62 ±151%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.11 ± 41%    +867.3%       1.03 ± 32%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.08 ± 58%    +114.8%       2.32 ± 27%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.25 ± 27%    +155.1%       0.64 ± 18%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_renameat2
      0.30 ± 29%    +574.6%       2.05 ±142%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.16 ±  5%    +207.2%       0.48 ± 22%  perf-sched.sch_delay.avg.ms.schedule_timeout.___down_common.__down.down
      0.21 ± 33%    +266.2%       0.76 ± 18%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.03 ± 65%   +6017.7%       2.02 ± 48%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.blk_execute_rq
      0.06 ±104%   +3279.9%       1.99 ± 14%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.04 ± 22%   +2605.6%       1.06 ± 17%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.08 ± 46%   +1680.3%       1.39 ± 13%  perf-sched.sch_delay.avg.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
      0.10 ± 11%   +3086.2%       3.05        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 27%   +4472.4%       2.45 ± 24%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      6.77 ± 40%     -50.6%       3.34 ± 40%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.iomap_write_begin
      7.14 ± 12%     -22.4%       5.54 ± 15%  perf-sched.sch_delay.max.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.74 ± 66%     -96.8%       0.02 ±206%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_dir_createname
      3.30 ± 47%     -99.2%       0.03 ±197%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_dir_lookup
      2.51 ±110%     -97.1%       0.07 ±147%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_dir_removename
      1.73 ±119%     -97.4%       0.04 ±130%  perf-sched.sch_delay.max.ms.__cond_resched.begin_current_label_crit_section.apparmor_path_rename.part.0
      5.07 ± 33%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      5.86 ± 70%     -84.4%       0.91 ±138%  perf-sched.sch_delay.max.ms.__cond_resched.down.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup
      2.36 ±126%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_free_eofblocks
      0.23 ±124%     -98.9%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.xfs_ilock.xfs_create.xfs_generic_create
      1.42 ±106%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.xfs_ilock.xfs_free_eofblocks.xfs_release
      1.64 ± 38%     -97.1%       0.05 ±143%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.xfs_ilock.xfs_iget_cache_hit.xfs_iget
      0.90 ±125%     -85.9%       0.13 ±201%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.xfs_ilock.xfs_ilock_for_iomap.xfs_buffered_write_iomap_begin
      0.23 ± 93%     -82.1%       0.04 ±149%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.xfs_ilock.xfs_lock_inodes.constprop
      0.86 ± 98%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      5.26 ± 52%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.do_mkdirat.__x64_sys_mkdir.do_syscall_64
     10.75 ± 26%     -97.1%       0.31 ±110%  perf-sched.sch_delay.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      6.74 ± 34%     -92.5%       0.50 ±117%  perf-sched.sch_delay.max.ms.__cond_resched.dput.vfs_rename.do_renameat2.__x64_sys_rename
      1.92 ± 82%     -97.9%       0.04 ±212%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.39 ±139%     -93.3%       0.03 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_dup_cursor.xfs_btree_dup_cursor
      1.99 ± 65%     -97.6%       0.05 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.xfs_inode_item_init.xfs_trans_ijoin.xfs_init_new_inode
      0.30 ±114%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_free_eofblocks.xfs_release
      0.74 ± 91%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_rename.xfs_vn_rename
      0.53 ±125%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_trans_alloc_icreate.xfs_create
      0.94 ±122%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.xlog_ticket_alloc.xfs_log_reserve.xfs_trans_reserve
      1.30 ±121%     -97.9%       0.03 ±183%  perf-sched.sch_delay.max.ms.__cond_resched.mnt_want_write.do_renameat2.__x64_sys_rename.do_syscall_64
      0.71 ±110%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
      0.25 ± 42%     -78.7%       0.05 ±126%  perf-sched.sch_delay.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.46 ± 70%   +7019.5%     175.26 ±211%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.82 ±158%  +20809.2%     170.93 ±217%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      2.21 ±122%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.17 ±180%   +1920.1%       3.51 ± 40%  perf-sched.sch_delay.max.ms.kthreadd.ret_from_fork.ret_from_fork_asm
     19.18 ± 23%    +468.8%     109.07 ± 31%  perf-sched.sch_delay.max.ms.schedule_timeout.___down_common.__down.down
      0.06 ± 94%   +4671.5%       2.76 ± 28%  perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.blk_execute_rq
      0.74 ±152%    +502.7%       4.47 ± 13%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      5.84 ± 71%   +1283.7%      80.87 ±100%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.38 ± 58%    +128.8%       5.44 ± 28%  perf-sched.sch_delay.max.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
     54.67 ±201%   +1136.3%     675.85 ± 53%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.10 ±  5%    +818.1%       0.93 ± 10%  perf-sched.total_sch_delay.average.ms
     74.20 ±137%   +1036.6%     843.38 ± 39%  perf-sched.total_sch_delay.max.ms
     23.12 ±  8%     +83.1%      42.32 ±  8%  perf-sched.total_wait_and_delay.average.ms
     67776 ± 10%     -45.6%      36844 ±  8%  perf-sched.total_wait_and_delay.count.ms
     23.02 ±  8%     +79.8%      41.39 ±  8%  perf-sched.total_wait_time.average.ms
      7.15           +25.0%       8.94 ±  3%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.51 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      1.47 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.vfs_rename.do_renameat2.__x64_sys_rename
      2.32 ± 13%     +28.6%       2.98 ± 19%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
    190.08 ± 51%    +328.2%     814.00 ±  5%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     58.27 ± 21%    +104.8%     119.35 ± 25%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    230.25 ±  4%      +8.5%     249.75 ±  2%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    251.07 ±  9%     +73.5%     435.71 ± 17%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      2.80 ±  9%    +137.2%       6.64 ± 20%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.___down_common.__down.down
      4.38           +43.4%       6.28 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    144.32 ±  5%     -13.6%     124.67 ±  8%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      7271 ± 12%     -47.1%       3849 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
    576.33           -16.8%     479.50        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2795 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
    622.33 ± 21%     -61.3%     240.83 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
    944.67 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.dput.vfs_rename.do_renameat2.__x64_sys_rename
      8111 ± 14%     -45.0%       4458 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
     99.00 ± 22%     -99.2%       0.83 ±107%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3732 ± 19%     -63.0%       1381 ±  8%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     52.83 ± 10%     -41.6%      30.83 ± 14%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     26865 ±  6%     -45.9%      14540 ± 27%  perf-sched.wait_and_delay.count.schedule_timeout.___down_common.__down.down
      1147           -16.0%     964.67 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      6233 ±  5%     +16.1%       7233 ±  6%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     32.01 ± 22%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
     23.43 ± 30%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.dput.vfs_rename.do_renameat2.__x64_sys_rename
    317.91 ±  6%     -76.5%      74.78 ±104%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1032           +32.3%       1366 ± 10%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     15.60 ± 52%    +554.0%     102.01 ± 69%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1034           +63.2%       1688 ± 26%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.22 ± 10%     +58.1%       3.51 ± 27%  perf-sched.wait_time.avg.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.39 ± 37%     -82.6%       0.24 ±165%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_iext_insert
      1.34 ± 55%     -70.4%       0.40 ±147%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
      7.14           +24.9%       8.92 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.34 ± 10%     -41.3%       0.78 ± 32%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.xfs_can_free_eofblocks.xfs_release.__fput
      0.98 ± 56%     -71.5%       0.28 ±142%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_vn_update_time
      1.62 ± 52%     -90.7%       0.15 ±216%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.xfs_ilock.xfs_create.xfs_generic_create
      1.28 ± 37%     -73.0%       0.34 ±149%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.xfs_ilock.xfs_ilock_for_iomap.xfs_buffered_write_iomap_begin
      0.13 ±136%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      2.43 ± 40%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.do_mkdirat.__x64_sys_mkdir.do_syscall_64
      1.20 ± 55%     -97.3%       0.03 ±168%  perf-sched.wait_time.avg.ms.__cond_resched.dput.do_renameat2.__x64_sys_rename.do_syscall_64
      0.75 ± 85%     -90.1%       0.07 ±160%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc._xfs_buf_alloc.xfs_buf_find_insert.constprop
      2.30 ± 13%     +28.9%       2.96 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      1.58 ± 10%     -41.7%       0.92 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
      0.73 ± 69%     -96.2%       0.03 ±168%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.xfs_iunlink_log_inode.xfs_iunlink.xfs_rename
      1.68 ± 46%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_free_eofblocks.xfs_release
      1.46 ± 23%     -84.6%       0.22 ±103%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_trans_alloc_icreate.xfs_create
      1.81 ± 61%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.xlog_ticket_alloc.xfs_log_reserve.xfs_trans_reserve
      1.50 ± 17%     -41.5%       0.88 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_read.do_syscall_64
      1.07 ± 45%     -93.4%       0.07 ±201%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
      1.54 ± 29%     -54.6%       0.70 ± 61%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1.99 ± 94%     -97.5%       0.05 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.xfs_trans_alloc.xfs_free_eofblocks.xfs_release.__fput
    189.81 ± 51%    +318.3%     794.07 ±  2%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     58.23 ± 21%     +92.4%     112.03 ± 19%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      2.16 ± 12%     -33.2%       1.44 ± 23%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    250.97 ±  9%     +73.2%     434.68 ± 17%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.56 ± 15%    +182.8%       4.40 ± 53%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.open_last_lookups
      1.78 ± 24%    +255.3%       6.31 ± 18%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_renameat2
      1.62 ± 32%    +433.7%       8.65 ± 97%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      2.64 ±  9%    +133.0%       6.16 ± 20%  perf-sched.wait_time.avg.ms.schedule_timeout.___down_common.__down.down
      1.20 ±141%    +299.1%       4.79 ± 75%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      4.34           +20.4%       5.23 ±  4%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    144.23 ±  5%     -15.7%     121.62 ±  8%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      7.12 ± 18%     -76.3%       1.68 ±159%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_dir_removename
      6.25 ± 47%     -90.4%       0.60 ±175%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_iext_insert
      3.96 ± 50%     -89.9%       0.40 ±146%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.allocate_slab
      9.08 ± 49%     -68.6%       2.85 ± 42%  perf-sched.wait_time.max.ms.__cond_resched.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file
     11.70 ± 13%     -66.1%       3.97 ± 77%  perf-sched.wait_time.max.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
     38.74 ±134%     -97.7%       0.88 ±175%  perf-sched.wait_time.max.ms.__cond_resched.dentry_kill.dput.do_renameat2.__x64_sys_rename
      7.04 ± 29%     -42.9%       4.02        perf-sched.wait_time.max.ms.__cond_resched.down_read.xfs_can_free_eofblocks.xfs_release.__fput
      7.87 ± 34%     -82.5%       1.38 ± 89%  perf-sched.wait_time.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_create
     10.82 ± 23%     -59.2%       4.42 ± 52%  perf-sched.wait_time.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_rename
      2.57 ± 61%     -84.1%       0.41 ±147%  perf-sched.wait_time.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_vn_update_time
      6.42 ± 56%     -97.7%       0.15 ±216%  perf-sched.wait_time.max.ms.__cond_resched.down_write.xfs_ilock.xfs_create.xfs_generic_create
      5.92 ± 52%     -84.6%       0.91 ±218%  perf-sched.wait_time.max.ms.__cond_resched.down_write.xfs_ilock.xfs_free_eofblocks.xfs_release
      7.63 ± 36%     -95.1%       0.37 ±142%  perf-sched.wait_time.max.ms.__cond_resched.down_write.xfs_ilock.xfs_ilock_for_iomap.xfs_buffered_write_iomap_begin
      0.67 ±157%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     11.40 ± 41%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.do_mkdirat.__x64_sys_mkdir.do_syscall_64
      5.50 ± 57%     -99.4%       0.03 ±168%  perf-sched.wait_time.max.ms.__cond_resched.dput.do_renameat2.__x64_sys_rename.do_syscall_64
     25.24 ± 23%     -74.8%       6.36 ± 58%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
     20.87 ± 17%     -70.5%       6.16 ± 50%  perf-sched.wait_time.max.ms.__cond_resched.dput.vfs_rename.do_renameat2.__x64_sys_rename
      1.84 ± 79%     -95.8%       0.08 ±155%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc._xfs_buf_alloc.xfs_buf_find_insert.constprop
      4.87 ± 44%     -79.3%       1.01 ±140%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_dup_cursor.xfs_btree_dup_cursor
      1.38 ± 70%     -98.0%       0.03 ±168%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.xfs_iunlink_log_inode.xfs_iunlink.xfs_rename
      5.49 ± 37%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_free_eofblocks.xfs_release
      8.34 ± 32%     -95.6%       0.36 ±113%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_trans_alloc_icreate.xfs_create
      4.34 ± 26%     -66.7%       1.44 ±142%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_vn_update_time.kiocb_modified
      9.40 ± 43%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.xlog_ticket_alloc.xfs_log_reserve.xfs_trans_reserve
     10.08 ± 30%     -61.2%       3.91 ± 98%  perf-sched.wait_time.max.ms.__cond_resched.mnt_want_write.do_renameat2.__x64_sys_rename.do_syscall_64
      6.53 ± 48%     -86.8%       0.86 ±165%  perf-sched.wait_time.max.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
      9.41 ± 17%     -47.4%       4.95 ± 23%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_read.do_syscall_64
      7.34 ± 84%     -98.2%       0.13 ±211%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.__fdget_pos.ksys_write.do_syscall_64
     10.79 ± 60%     -83.8%       1.75 ±157%  perf-sched.wait_time.max.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
    317.83 ±  6%     -74.6%      80.68 ± 86%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5.50 ± 30%     -53.7%       2.55 ± 56%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      3.45 ± 47%     -98.5%       0.05 ±223%  perf-sched.wait_time.max.ms.__cond_resched.xfs_trans_alloc.xfs_free_eofblocks.xfs_release.__fput
      6.53 ± 53%     -88.0%       0.79 ±223%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
    172.54 ±214%     -99.6%       0.69 ±151%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      1032           +32.3%       1366 ± 10%  perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     13.16 ± 22%     +79.6%      23.63 ± 20%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_renameat2
      9.36 ± 21%   +2228.4%     218.04 ±165%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      3.58 ±141%    +369.9%      16.83 ± 70%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
     11.22 ± 49%    +308.4%      45.82 ± 84%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1034           +63.2%       1688 ± 26%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm



***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  exec_spawn/gcc-12/performance/1HDD/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/exec/stress-ng/60s

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     82.25            +3.6%      85.24        iostat.cpu.system
      8.48           -32.5%       5.73        iostat.cpu.user
      1.19            -0.2        1.01        mpstat.cpu.all.irq%
      0.53            +0.1        0.67 ±  2%  mpstat.cpu.all.soft%
      8.73            -2.8        5.89        mpstat.cpu.all.usr%
    151.83 ±  4%     +79.1%     272.00 ±  5%  vmstat.procs.r
     88287           -45.7%      47970 ±  2%  vmstat.system.cs
    117994           -13.4%     102190        vmstat.system.in
  79317172           -34.2%   52217838 ±  3%  numa-numastat.node0.local_node
  79360983           -34.2%   52240348 ±  3%  numa-numastat.node0.numa_hit
  77971050           -33.2%   52068168 ±  3%  numa-numastat.node1.local_node
  78009071           -33.2%   52089987 ±  3%  numa-numastat.node1.numa_hit
      6311 ±  2%     -12.6%       5512 ±  3%  perf-c2c.DRAM.remote
      5297           -33.4%       3527 ±  4%  perf-c2c.HITM.local
      3611 ±  2%     -37.0%       2276 ±  4%  perf-c2c.HITM.remote
      8908           -34.8%       5804 ±  4%  perf-c2c.HITM.total
    361953 ±  8%     -17.5%     298533 ±  9%  turbostat.C1
      0.14 ±  5%     -30.2%       0.10        turbostat.IPC
   7803781           -13.6%    6739655        turbostat.IRQ
     13.85 ± 18%     -13.8        0.09 ±123%  turbostat.PKG_%
    272.00 ± 43%     -58.6%     112.67 ± 28%  turbostat.POLL
    400.63            -4.7%     381.62        turbostat.PkgWatt
     97.98           -11.2%      87.05        turbostat.RAMWatt
    943488           -34.6%     617225 ±  3%  stress-ng.exec.ops
     15709           -34.6%      10274 ±  3%  stress-ng.exec.ops_per_sec
   1152325           -45.6%     627349        stress-ng.time.involuntary_context_switches
    367062           -41.4%     215251 ±  3%  stress-ng.time.major_page_faults
 2.058e+08           -33.3%  1.372e+08 ±  3%  stress-ng.time.minor_page_faults
      3144            +4.3%       3281        stress-ng.time.system_time
    301.60           -37.2%     189.54 ±  2%  stress-ng.time.user_time
   2253503           -38.6%    1384317 ±  3%  stress-ng.time.voluntary_context_switches
    391400 ±  4%     +13.2%     443196 ±  3%  meminfo.Active
    391256 ±  4%     +13.2%     443060 ±  3%  meminfo.Active(anon)
   2301202 ±  2%     -44.5%    1277982 ±  4%  meminfo.AnonPages
   3028901 ±  2%     -45.9%    1638075 ±  4%  meminfo.Inactive
   3028698 ±  2%     -45.9%    1637865 ±  4%  meminfo.Inactive(anon)
    733055           -50.6%     362045 ±  4%  meminfo.Mapped
   7451969           -18.3%    6086630        meminfo.Memused
    249614           +13.3%     282720        meminfo.SUnreclaim
   1084892           -28.8%     772281 ±  2%  meminfo.Shmem
   7905146           -15.7%    6660361        meminfo.max_used_kB
    585668 ± 36%     -37.4%     366632 ± 19%  numa-meminfo.node0.Inactive
    585629 ± 36%     -37.4%     366493 ± 19%  numa-meminfo.node0.Inactive(anon)
     12587 ±  4%      +6.6%      13419 ±  3%  numa-meminfo.node0.KernelStack
    241837 ± 15%     -54.9%     108956 ± 14%  numa-meminfo.node0.Mapped
    131373 ±  4%     +14.2%     150063        numa-meminfo.node0.SUnreclaim
    321414 ± 28%     -46.4%     172158 ± 21%  numa-meminfo.node0.Shmem
    268099 ±  8%     +27.7%     342267 ±  4%  numa-meminfo.node1.Active
    267979 ±  8%     +27.7%     342221 ±  4%  numa-meminfo.node1.Active(anon)
   1927265 ±  7%     -48.5%     991743 ± 11%  numa-meminfo.node1.AnonPages
   6126082 ±  9%     -60.6%    2411821 ±  3%  numa-meminfo.node1.AnonPages.max
   2441426 ±  7%     -48.1%    1267741 ±  9%  numa-meminfo.node1.Inactive
   2441262 ±  7%     -48.1%    1267671 ±  9%  numa-meminfo.node1.Inactive(anon)
    491202 ±  7%     -49.3%     248842 ±  9%  numa-meminfo.node1.Mapped
    763522 ± 11%     -21.3%     600904 ±  5%  numa-meminfo.node1.Shmem
    146263 ± 36%     -37.7%      91143 ± 18%  numa-vmstat.node0.nr_inactive_anon
     60515 ± 15%     -54.9%      27318 ± 15%  numa-vmstat.node0.nr_mapped
     80250 ± 28%     -46.7%      42760 ± 21%  numa-vmstat.node0.nr_shmem
     32997 ±  4%     +13.7%      37503        numa-vmstat.node0.nr_slab_unreclaimable
    146263 ± 36%     -37.7%      91144 ± 18%  numa-vmstat.node0.nr_zone_inactive_anon
  79361000           -34.2%   52240236 ±  3%  numa-vmstat.node0.numa_hit
  79317189           -34.2%   52217726 ±  3%  numa-vmstat.node0.numa_local
     66840 ±  8%     +26.7%      84693 ±  5%  numa-vmstat.node1.nr_active_anon
    483705 ±  6%     -48.6%     248549 ± 11%  numa-vmstat.node1.nr_anon_pages
    612356 ±  7%     -48.1%     317581 ±  9%  numa-vmstat.node1.nr_inactive_anon
    122952 ±  7%     -49.4%      62247 ±  8%  numa-vmstat.node1.nr_mapped
    190826 ± 11%     -21.7%     149413 ±  5%  numa-vmstat.node1.nr_shmem
     66840 ±  8%     +26.7%      84693 ±  5%  numa-vmstat.node1.nr_zone_active_anon
    612357 ±  7%     -48.1%     317580 ±  9%  numa-vmstat.node1.nr_zone_inactive_anon
  78008757           -33.2%   52089958 ±  3%  numa-vmstat.node1.numa_hit
  77970736           -33.2%   52068139 ±  3%  numa-vmstat.node1.numa_local
     97892 ±  2%     +14.4%     112017        proc-vmstat.nr_active_anon
    576196 ±  2%     -44.8%     317799 ±  4%  proc-vmstat.nr_anon_pages
    958147            -8.1%     880525        proc-vmstat.nr_file_pages
    758356           -46.3%     407365 ±  4%  proc-vmstat.nr_inactive_anon
     24263            +6.0%      25716        proc-vmstat.nr_kernel_stack
    183853           -51.1%      89950 ±  3%  proc-vmstat.nr_mapped
    271480           -28.6%     193835 ±  2%  proc-vmstat.nr_shmem
     62515           +12.6%      70382        proc-vmstat.nr_slab_unreclaimable
     97892 ±  2%     +14.4%     112017        proc-vmstat.nr_zone_active_anon
    758356           -46.3%     407365 ±  4%  proc-vmstat.nr_zone_inactive_anon
 1.574e+08           -33.7%  1.043e+08 ±  3%  proc-vmstat.numa_hit
 1.573e+08           -33.7%  1.043e+08 ±  3%  proc-vmstat.numa_local
    360578           -12.9%     313907 ±  2%  proc-vmstat.pgactivate
 1.646e+08           -33.8%   1.09e+08 ±  3%  proc-vmstat.pgalloc_normal
 2.177e+08           -33.2%  1.453e+08 ±  3%  proc-vmstat.pgfault
 1.632e+08           -33.5%  1.086e+08 ±  3%  proc-vmstat.pgfree
   2457518           -30.9%    1697138 ±  2%  proc-vmstat.pgreuse
      3067           -31.7%       2095 ±  2%  proc-vmstat.thp_fault_alloc
      3027 ±  2%     -33.5%       2012 ±  5%  proc-vmstat.thp_split_pmd
    177531 ±  3%     -39.1%     108181 ±  4%  proc-vmstat.unevictable_pgs_culled
   1773286           +41.2%    2504364        sched_debug.cfs_rq:/.avg_vruntime.avg
   2257333 ±  5%     +35.3%    3053999 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.max
   1312190 ±  2%     +61.8%    2122831 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.min
     94694 ± 11%     +44.6%     136926 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    257547 ± 33%    +195.6%     761221 ± 24%  sched_debug.cfs_rq:/.left_vruntime.avg
   1827692           +57.3%    2875024 ±  6%  sched_debug.cfs_rq:/.left_vruntime.max
    611191 ± 14%     +85.5%    1133544 ±  8%  sched_debug.cfs_rq:/.left_vruntime.stddev
    118843 ± 17%     +93.5%     230014 ± 21%  sched_debug.cfs_rq:/.load.avg
   1151341 ± 16%     +48.9%    1713855 ± 20%  sched_debug.cfs_rq:/.load.max
    269930 ±  6%     +40.0%     377785 ± 14%  sched_debug.cfs_rq:/.load.stddev
   1773288           +41.2%    2504386        sched_debug.cfs_rq:/.min_vruntime.avg
   2257333 ±  5%     +35.3%    3053992 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
   1312190 ±  2%     +61.8%    2122809 ±  5%  sched_debug.cfs_rq:/.min_vruntime.min
     94694 ± 11%     +44.6%     136925 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.71 ±  5%     +14.2%       0.81 ±  8%  sched_debug.cfs_rq:/.nr_running.avg
     31.58 ± 16%     -37.1%      19.86 ± 28%  sched_debug.cfs_rq:/.removed.util_avg.avg
    257547 ± 33%    +195.6%     761225 ± 24%  sched_debug.cfs_rq:/.right_vruntime.avg
   1827692           +57.3%    2875024 ±  6%  sched_debug.cfs_rq:/.right_vruntime.max
    611191 ± 14%     +85.5%    1133548 ±  8%  sched_debug.cfs_rq:/.right_vruntime.stddev
    916.68 ±  8%    +142.2%       2220 ± 92%  sched_debug.cfs_rq:/.runnable_avg.avg
      2254 ± 24%    +262.5%       8171 ± 87%  sched_debug.cfs_rq:/.runnable_avg.max
    421.39 ± 20%    +353.5%       1910 ±114%  sched_debug.cfs_rq:/.runnable_avg.stddev
    153.00 ± 22%     -51.5%      74.17 ± 55%  sched_debug.cfs_rq:/.util_avg.min
      6.19 ±  8%     +40.0%       8.67 ± 11%  sched_debug.cpu.clock.stddev
    532031 ±  4%     -37.6%     332043 ±  8%  sched_debug.cpu.curr->pid.avg
    700350           -34.9%     455732 ±  2%  sched_debug.cpu.curr->pid.max
    296839 ±  3%     -33.0%     198864 ±  6%  sched_debug.cpu.curr->pid.stddev
     46273           -43.3%      26252        sched_debug.cpu.nr_switches.avg
     91990 ± 12%     -25.4%      68587 ±  4%  sched_debug.cpu.nr_switches.max
     32267 ±  4%     -38.5%      19850 ±  4%  sched_debug.cpu.nr_switches.min
    228.08 ± 10%     -47.9%     118.83 ± 25%  sched_debug.cpu.nr_uninterruptible.max
   -825.92           -72.4%    -227.75        sched_debug.cpu.nr_uninterruptible.min
    133.85 ± 14%     -58.5%      55.54 ±  7%  sched_debug.cpu.nr_uninterruptible.stddev
      3.77            -5.9%       3.54        perf-stat.i.MPKI
 1.835e+10           -26.6%  1.346e+10        perf-stat.i.branch-instructions
      1.76            -0.2        1.58        perf-stat.i.branch-miss-rate%
 3.211e+08           -34.1%  2.116e+08 ±  2%  perf-stat.i.branch-misses
     23.67            +0.8       24.51        perf-stat.i.cache-miss-rate%
 3.485e+08           -32.2%  2.364e+08 ±  2%  perf-stat.i.cache-misses
 1.441e+09           -34.6%  9.418e+08 ±  2%  perf-stat.i.cache-references
     93021           -46.0%      50257 ±  2%  perf-stat.i.context-switches
      2.37           +40.4%       3.33 ±  2%  perf-stat.i.cpi
     24503           -34.2%      16111 ±  2%  perf-stat.i.cpu-migrations
    720.98 ±  2%     +44.2%       1039 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.11 ±  5%      -0.0        0.10 ±  4%  perf-stat.i.dTLB-load-miss-rate%
  25736302 ±  4%     -35.8%   16517247 ±  3%  perf-stat.i.dTLB-load-misses
 2.313e+10           -28.4%  1.657e+10        perf-stat.i.dTLB-loads
  22962749           -34.3%   15087029 ±  2%  perf-stat.i.dTLB-store-misses
 1.078e+10           -34.4%  7.074e+09 ±  2%  perf-stat.i.dTLB-stores
 8.975e+10           -28.1%  6.454e+10        perf-stat.i.instructions
      0.43           -26.5%       0.32        perf-stat.i.ipc
      5967           -41.7%       3481 ±  3%  perf-stat.i.major-faults
      1399           +76.9%       2475 ±  2%  perf-stat.i.metric.K/sec
    840.84           -29.4%     593.80        perf-stat.i.metric.M/sec
   3446130           -33.3%    2299865 ±  2%  perf-stat.i.minor-faults
     69.34            -6.6       62.78        perf-stat.i.node-load-miss-rate%
  67098069           -26.7%   49212970        perf-stat.i.node-load-misses
     24.81            -2.2       22.64        perf-stat.i.node-store-miss-rate%
  25783451           -45.6%   14015341 ±  3%  perf-stat.i.node-store-misses
  78809232           -38.0%   48884286 ±  3%  perf-stat.i.node-stores
   3452098           -33.3%    2303346 ±  2%  perf-stat.i.page-faults
      3.88            -5.7%       3.66        perf-stat.overall.MPKI
      1.75            -0.2        1.56        perf-stat.overall.branch-miss-rate%
     24.24            +0.9       25.15        perf-stat.overall.cache-miss-rate%
      2.42           +40.4%       3.39 ±  2%  perf-stat.overall.cpi
    622.01           +49.0%     926.59 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.11 ±  4%      -0.0        0.10 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.41           -28.8%       0.29 ±  2%  perf-stat.overall.ipc
     68.86            -6.7       62.16        perf-stat.overall.node-load-miss-rate%
     24.60            -2.3       22.25        perf-stat.overall.node-store-miss-rate%
 1.811e+10           -26.9%  1.323e+10        perf-stat.ps.branch-instructions
 3.163e+08           -34.6%  2.069e+08 ±  2%  perf-stat.ps.branch-misses
 3.439e+08           -32.5%  2.322e+08 ±  2%  perf-stat.ps.cache-misses
 1.419e+09           -34.9%  9.233e+08 ±  2%  perf-stat.ps.cache-references
     91435           -46.2%      49192        perf-stat.ps.context-switches
     24084           -34.5%      15781 ±  2%  perf-stat.ps.cpu-migrations
  25583545 ±  4%     -36.5%   16239719 ±  3%  perf-stat.ps.dTLB-load-misses
 2.283e+10           -28.7%  1.628e+10        perf-stat.ps.dTLB-loads
  22666931           -34.7%   14802539 ±  2%  perf-stat.ps.dTLB-store-misses
 1.065e+10           -34.8%  6.945e+09 ±  2%  perf-stat.ps.dTLB-stores
 8.855e+10           -28.4%   6.34e+10        perf-stat.ps.instructions
      5864           -41.9%       3405 ±  2%  perf-stat.ps.major-faults
   3397769           -33.6%    2255265 ±  2%  perf-stat.ps.minor-faults
  66094286           -26.7%   48443106        perf-stat.ps.node-load-misses
  25346139           -45.9%   13711174 ±  3%  perf-stat.ps.node-store-misses
  77676625           -38.3%   47895043 ±  3%  perf-stat.ps.node-stores
   3403634           -33.6%    2258671 ±  2%  perf-stat.ps.page-faults
 5.608e+12           -28.2%  4.028e+12 ±  2%  perf-stat.total.instructions
      0.91 ± 16%     -69.5%       0.28 ±102%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.wp_page_copy
      0.54 ± 35%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc.mm_init
      1.60 ± 78%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.get_zeroed_page.__p4d_alloc.__handle_mm_fault
      0.38 ±102%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.move_page_tables
      0.93 ± 15%     -94.4%       0.05 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.do_read_fault.do_fault
      0.44 ± 52%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.39 ± 63%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__fput.task_work_run.do_exit.do_group_exit
      0.32 ± 30%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.load_elf_binary.search_binary_handler
      0.42 ± 37%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.load_elf_phdrs.load_elf_binary
      0.66 ± 38%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_prepare_creds.prepare_creds
      1.10 ± 15%     -79.7%       0.22 ±102%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
      0.95 ± 50%     -97.6%       0.02 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.alloc_bprm.do_execveat_common
      0.00 ± 83%    +511.1%       0.02 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.20 ± 89%    +615.2%       1.42 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.58 ± 36%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file
      0.28 ± 17%     -48.9%       0.14 ± 49%  perf-sched.sch_delay.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      1.46 ± 54%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.count.constprop.0.isra
      1.14 ± 59%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dentry_kill.dput.step_into.path_lookupat
      0.48 ± 41%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      1.31 ± 49%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.exit_mm.do_exit.do_group_exit
      0.63 ± 65%     -96.9%       0.02 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.exit_mmap.__mmput.exec_mmap
      0.89 ± 78%     -79.8%       0.18 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
      0.05 ±126%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.get_arg_page.copy_string_kernel.copy_strings_kernel
      0.61 ±112%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_timeout.__request_module.search_binary_handler.exec_binprm
      0.63 ± 45%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.46 ± 57%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__anon_vma_prepare.do_cow_fault.do_fault
      0.32 ± 27%     -94.1%       0.02 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.19 ± 69%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      1.35 ±124%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlink
      0.59 ± 57%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_expand.mmap_region.do_mmap
      0.47 ± 94%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_expand.shift_arg_pages.setup_arg_pages
      0.34 ±146%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_link.insert_vm_struct.__install_special_mapping
      0.18 ± 73%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_prepare.vma_expand.mmap_region
      0.59 ± 64%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.__vm_munmap.elf_map.load_elf_binary
      0.58 ± 37%     -96.0%       0.02 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.create_elf_tables.load_elf_binary.search_binary_handler
      0.53 ± 45%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      1.21 ±160%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.50 ± 19%     -84.5%       0.08 ±142%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map.load_elf_interp
      0.12 ±115%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.nd_jump_root.pick_link.step_into
      1.12 ± 46%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.path_openat.do_filp_open.do_sys_openat2
      0.65 ± 79%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      0.76 ± 77%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.exit_signals.do_exit.do_group_exit.get_signal
      0.34 ± 83%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.filemap_read.__kernel_read.load_elf_binary.search_binary_handler
      1.51 ± 39%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.69 ± 29%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.53 ± 34%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_cow_fault.do_fault
      1.21 ± 11%     -77.1%       0.28 ±101%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      0.29 ±108%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      0.08 ± 96%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
      0.74 ± 70%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.expand_downwards
      0.74 ± 28%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.vma_link
      1.29 ± 27%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.mm_alloc.alloc_bprm.do_execveat_common
      1.34 ± 76%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.prepare_creds.__do_sys_capset.do_syscall_64
      1.57 ± 70%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.prepare_creds.prepare_exec_creds.bprm_execve
      0.04 ± 71%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.prepare_kernel_cred.call_usermodehelper_exec_async.ret_from_fork
      0.48 ± 15%     -92.6%       0.04 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
      0.49 ± 24%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.taskstats_exit.do_exit.do_group_exit
      0.09 ±185%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm.kernel_execve
      0.40 ± 43%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.__split_vma
      0.33 ± 41%     -86.6%       0.04 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
      0.25 ± 63%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      1.73 ±  4%    +567.7%      11.52 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
      0.64 ± 37%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mmput.free_bprm.do_execveat_common.isra
      0.62 ± 51%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
      1.92 ± 55%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
      1.23 ± 23%     -84.7%       0.19 ±160%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      1.24 ± 47%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_interruptible.bprm_execve.do_execveat_common.isra
      0.75 ± 22%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.alloc_bprm
      0.20 ± 37%    +698.6%       1.60 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      2.09 ±  4%    +305.1%       8.46 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.36 ± 70%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.50 ±  6%    +102.5%       1.01 ± 40%  perf-sched.sch_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      0.46 ± 44%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.shift_arg_pages.setup_arg_pages
      0.57 ± 78%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.truncate_inode_pages_range.evict.__dentry_kill.dentry_kill
      0.47 ± 62%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlink
      0.74 ± 34%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exec_mmap
      0.11 ±113%   +1453.8%       1.66 ± 25%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.53 ±  3%    +169.2%       1.43 ±  7%  perf-sched.sch_delay.avg.ms.de_thread.begin_new_exec.load_elf_binary.search_binary_handler
      1.09 ±  7%    +333.5%       4.73 ± 15%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.56 ± 12%    +183.7%       1.59 ±  8%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.60 ±  9%    +552.7%       3.92 ± 18%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.17 ± 27%    +778.2%       1.49 ±  8%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait.call_usermodehelper_exec_work.process_one_work
      0.44 ± 27%    +112.2%       0.94 ± 20%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.52 ±  3%     +81.3%       0.94 ±  9%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1.59 ±  4%    +298.5%       6.35 ± 18%  perf-sched.sch_delay.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.47 ±  7%    +133.6%       1.11 ±  8%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.22 ± 23%    +348.6%       0.99 ±  8%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 48%    +981.2%       0.12 ± 33%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.31 ±121%    +335.9%       1.35 ± 36%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.54 ± 31%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
      0.39 ±  6%    +223.2%       1.26 ± 88%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
      0.55 ± 11%    +221.7%       1.76 ± 24%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      0.39 ± 17%     +87.5%       0.73 ± 27%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      0.55 ±  3%    +157.1%       1.41 ± 13%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec
      0.35 ± 10%    +208.8%       1.07 ± 15%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.19 ± 64%    +536.1%       1.21 ± 16%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.17 ± 11%    +961.9%       1.85 ±  8%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.06 ±  3%    +775.3%       0.55 ±  6%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ± 63%    +720.5%       0.35 ± 17%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.06 ±  8%   +1352.1%       0.88 ±  4%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     87.88 ±100%     -88.8%       9.89 ±113%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.wp_page_copy
      4.86 ± 17%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.__get_free_pages.pgd_alloc.mm_init
      3.85 ± 33%     -86.5%       0.52 ±161%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.__pmd_alloc.__handle_mm_fault.handle_mm_fault
      3.12 ± 44%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.get_zeroed_page.__p4d_alloc.__handle_mm_fault
      5.82 ± 34%     -83.1%       0.98 ±206%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.do_anonymous_page
      1.31 ±109%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.move_page_tables
      9.59 ± 36%     -97.3%       0.26 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.pte_alloc_one.do_read_fault.do_fault
      4.08 ± 45%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      1.43 ± 46%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__fput.task_work_run.do_exit.do_group_exit
      6.99 ± 43%     -90.5%       0.66 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__get_user_pages.get_user_pages_remote.get_arg_page.copy_string_kernel
      4.27 ± 56%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.load_elf_binary.search_binary_handler
      5.95 ± 33%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.load_elf_phdrs.load_elf_binary
      4.81 ± 13%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_prepare_creds.prepare_creds
      8.56 ± 16%     -79.8%       1.72 ±107%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
      2.18 ± 60%     -99.0%       0.02 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.alloc_bprm.do_execveat_common
      0.74 ± 81%    +319.2%       3.12 ± 25%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.45 ± 98%    +584.3%       3.10 ± 11%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      3.28 ± 38%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file
     33.39 ± 80%     -77.1%       7.66 ± 54%  perf-sched.sch_delay.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      3.29 ± 55%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.count.constprop.0.isra
      3.51 ± 68%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dentry_kill.dput.step_into.path_lookupat
      3.75 ± 36%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      6.09 ± 65%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.exit_mm.do_exit.do_group_exit
      4.96 ± 34%     -99.6%       0.02 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.exit_mmap.__mmput.exec_mmap
      2.91 ± 94%     -87.7%       0.36 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.exit_mmap.__mmput.exit_mm
      0.07 ±103%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.get_arg_page.copy_string_kernel.copy_strings_kernel
      4.08 ± 33%     -86.9%       0.54 ±141%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.kernfs_iop_permission.inode_permission.link_path_walk
      1.98 ± 90%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_timeout.__request_module.search_binary_handler.exec_binprm
      3.93 ± 47%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      3.73 ± 59%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.__anon_vma_prepare.do_cow_fault.do_fault
      5.51 ± 27%     -97.2%       0.15 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      5.68 ± 86%     -89.1%       0.62 ±166%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.mprotect_fixup
      1.53 ± 52%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      2.96 ± 98%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlink
      3.06 ± 50%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_expand.mmap_region.do_mmap
      1.97 ± 85%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_expand.shift_arg_pages.setup_arg_pages
      0.69 ±145%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_link.insert_vm_struct.__install_special_mapping
      2.26 ± 75%     -69.7%       0.69 ±141%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
      1.81 ± 68%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_prepare.vma_expand.mmap_region
      3.46 ± 64%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.__vm_munmap.elf_map.load_elf_binary
      4.32 ± 28%     -99.5%       0.02 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.create_elf_tables.load_elf_binary.search_binary_handler
      4.59 ± 44%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      4.05 ± 23%     -82.5%       0.71 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.search_binary_handler
      4.32 ±112%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.84 ± 42%     -89.0%       0.64 ±141%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map.load_elf_interp
      3.66 ± 26%     -86.8%       0.48 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.51 ±123%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.nd_jump_root.pick_link.step_into
      2.20 ± 67%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.path_openat.do_filp_open.do_sys_openat2
      2.45 ± 84%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
     13.60 ± 23%     -77.4%       3.08 ±109%  perf-sched.sch_delay.max.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
      5.17 ± 64%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.exit_signals.do_exit.do_group_exit.get_signal
      3.11 ± 70%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.filemap_read.__kernel_read.load_elf_binary.search_binary_handler
      1.54 ± 89%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.filemap_read.__kernel_read.load_elf_phdrs.load_elf_binary
      6.70 ± 27%     -81.3%       1.25 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.filemap_read.__kernel_read.search_binary_handler.exec_binprm
      3.70 ± 55%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      6.70 ± 53%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      4.49 ± 35%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_cow_fault.do_fault
      8.44 ± 12%     -82.6%       1.47 ± 92%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      2.49 ±129%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.copy_sighand.copy_process.kernel_clone
      1.11 ± 89%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.dup_mm.constprop.0
      2.68 ± 55%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.expand_downwards
      3.73 ± 40%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.vma_link
      3.51 ± 27%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.mm_alloc.alloc_bprm.do_execveat_common
      2.48 ± 63%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.__do_sys_capset.do_syscall_64
      1.90 ± 70%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.prepare_creds.prepare_exec_creds.bprm_execve
      0.83 ± 81%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.prepare_kernel_cred.call_usermodehelper_exec_async.ret_from_fork
      5.60 ± 44%     -94.9%       0.28 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
      2.85 ± 38%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.taskstats_exit.do_exit.do_group_exit
      6.97 ± 35%     -81.3%       1.30 ±111%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm.do_execveat_common
      0.26 ±184%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm.kernel_execve
      9.57 ± 14%     -47.3%       5.04 ± 55%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.mprotect_fixup
      1.74 ± 37%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.__split_vma
      2.73 ± 49%     -93.5%       0.18 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
      4.09 ± 44%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
     26.55 ± 18%    +272.2%      98.83 ± 10%  perf-sched.sch_delay.max.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
      3.77 ± 29%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mmput.free_bprm.do_execveat_common.isra
      2.34 ± 43%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
      3.38 ± 67%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
     11.39 ± 40%     -88.0%       1.37 ±155%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      2.51 ± 55%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_interruptible.bprm_execve.do_execveat_common.isra
      7.66 ± 34%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.mm_init.alloc_bprm
      3.29 ± 35%     -87.1%       0.43 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      5.81 ± 68%     -81.0%       1.11 ±143%  perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exec_mmap
      4.97 ± 37%     -71.6%       1.41 ±108%  perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exit_mm
      5.55 ± 14%     -98.7%       0.07 ±202%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     37.98 ± 17%    +285.9%     146.59 ± 14%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      2.00 ± 64%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      4.43 ± 48%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.shift_arg_pages.setup_arg_pages
      2.63 ± 37%     -76.1%       0.63 ±141%  perf-sched.sch_delay.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.constprop
      1.65 ± 94%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.truncate_inode_pages_range.evict.__dentry_kill.dentry_kill
      2.32 ± 96%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlink
      1.82 ± 61%     -89.2%       0.20 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      6.32 ± 45%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exec_mmap
      0.52 ±102%    +663.3%       3.99 ± 19%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     24.57 ± 29%    +275.9%      92.36 ± 15%  perf-sched.sch_delay.max.ms.de_thread.begin_new_exec.load_elf_binary.search_binary_handler
     22.84 ± 20%    +344.8%     101.59 ± 13%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     37.30 ± 18%    +368.1%     174.59 ± 21%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     10.72 ± 60%     -67.3%       3.50 ±  5%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      5.70 ± 21%     -87.5%       0.71 ±175%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      8.53 ± 22%     -92.4%       0.65 ±223%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
     33.90 ± 14%    +246.7%     117.54 ± 13%  perf-sched.sch_delay.max.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      2.78 ± 29%    +139.7%       6.66 ± 20%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.44 ± 44%    +150.1%       3.59 ± 37%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      3.80 ± 39%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
      7.53 ± 35%     -86.5%       1.02 ±223%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
     16.03 ± 29%    +324.3%      68.00 ± 22%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec
      2.66 ± 20%     +87.4%       4.98 ± 34%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1.64 ± 63%    +122.2%       3.65 ±  8%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      7.89 ± 29%    +443.0%      42.85 ±122%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.89 ± 99%    +180.2%       2.50 ± 14%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.57 ±  5%    +365.1%       2.63 ± 12%  perf-sched.total_sch_delay.average.ms
      6.14          +124.8%      13.80 ±  5%  perf-sched.total_wait_and_delay.average.ms
    461279           -51.8%     222478 ±  7%  perf-sched.total_wait_and_delay.count.ms
      5.57          +100.4%      11.16 ±  5%  perf-sched.total_wait_time.average.ms
      6.94 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_read.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64
     13.84 ±  8%     -83.6%       2.27 ±223%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
     18.61 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      8.64 ± 26%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
    119.50 ± 12%    +298.7%     476.42 ± 58%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.02 ±223%   +3125.3%      32.92 ± 10%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
     16.55 ± 35%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
     15.61 ± 28%     -81.8%       2.84 ±223%  perf-sched.wait_and_delay.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exec_mmap
      2.14 ±  4%    +296.1%       8.46 ± 13%  perf-sched.wait_and_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      1.32 ±  6%    +317.9%       5.53 ± 11%  perf-sched.wait_and_delay.avg.ms.de_thread.begin_new_exec.load_elf_binary.search_binary_handler
      1.39 ±  6%    +275.8%       5.22 ± 13%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      9.15           +88.6%      17.25 ± 12%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      2.16 ±  8%    +469.8%      12.33 ± 17%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     12.81 ±  8%     +56.4%      20.04 ± 11%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait.call_usermodehelper_exec_work.process_one_work
     14.22 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      4.55 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      9.00 ±  5%     +31.9%      11.87 ±  4%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1.79 ±  5%    +276.1%       6.72 ± 15%  perf-sched.wait_and_delay.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      6.38 ±  2%     +82.8%      11.66 ± 20%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
    366.82 ±  7%     +15.5%     423.79 ±  2%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     49.80 ±  5%     +91.9%      95.57 ± 14%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      9.89 ± 11%    +182.3%      27.93 ± 39%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
      8.40 ±  8%    +275.0%      31.49 ± 66%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      8.56 ± 11%    +261.6%      30.96 ± 83%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      1.29 ±  6%    +276.5%       4.85 ± 13%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec
      7.91 ±  2%     +98.8%      15.72 ± 10%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.92          +276.0%      26.03 ± 10%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1153 ±  4%     -98.9%      12.83 ±223%  perf-sched.wait_and_delay.count.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
    679.83 ±  5%     -98.5%      10.33 ±223%  perf-sched.wait_and_delay.count.__cond_resched.change_pmd_range.change_p4d_range.change_protection_range.mprotect_fixup
    695.67 ±  5%     -95.8%      29.00 ±223%  perf-sched.wait_and_delay.count.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
    912.00 ±  4%     -96.1%      35.83 ±223%  perf-sched.wait_and_delay.count.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
    239.17 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_read.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64
    171.67 ±  7%     -87.1%      22.17 ±102%  perf-sched.wait_and_delay.count.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      1745 ±  2%     -95.1%      84.67 ±223%  perf-sched.wait_and_delay.count.__cond_resched.down_write.dup_mmap.dup_mm.constprop
    337.33 ±  6%     -94.8%      17.67 ±223%  perf-sched.wait_and_delay.count.__cond_resched.down_write.dup_userfaultfd.dup_mmap.dup_mm
      2326 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
    248.67 ±  7%     -98.0%       5.00 ±223%  perf-sched.wait_and_delay.count.__cond_resched.down_write.vma_prepare.__split_vma.mprotect_fixup
    367.33 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
    368.50 ±  9%     -99.9%       0.50 ±223%  perf-sched.wait_and_delay.count.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
     19.67 ± 19%     -69.5%       6.00 ± 63%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1297 ±  4%     -92.5%      97.33 ±141%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.anon_vma_fork.dup_mmap.dup_mm
    481.33 ±  4%     -96.5%      16.83 ±223%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap.dup_mm
     34.67 ± 19%     -98.1%       0.67 ±223%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
     39.33 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
     38.17 ± 22%     -99.6%       0.17 ±223%  perf-sched.wait_and_delay.count.__cond_resched.remove_vma.exit_mmap.__mmput.exec_mmap
      7.00 ± 31%     -90.5%       0.67 ±111%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
     32372          -100.0%       0.50 ±223%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     37242 ±  3%     -26.2%      27502 ± 10%  perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      1235 ±  4%     -95.3%      58.00 ±143%  perf-sched.wait_and_delay.count.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      3090 ±  3%     -98.3%      53.67 ±223%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     21317           -36.8%      13480 ±  9%  perf-sched.wait_and_delay.count.de_thread.begin_new_exec.load_elf_binary.search_binary_handler
     14310           -42.6%       8210 ±  7%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      3760 ±  4%     -45.0%       2067 ±  7%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
     81460           -42.7%      46707 ±  7%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     34640           -42.4%      19964 ±  7%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      4361 ± 14%     -41.8%       2536 ± 12%  perf-sched.wait_and_delay.count.do_wait.kernel_wait.call_usermodehelper_exec_work.process_one_work
    190.50 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      6841 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     18858           -44.7%      10428 ± 10%  perf-sched.wait_and_delay.count.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
     17352           -55.5%       7724 ±  9%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
    185.00 ±  6%     -15.9%     155.67 ±  2%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    258.67 ±  3%     -45.0%     142.17 ± 12%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      3489 ±  5%     -90.8%     320.00 ±100%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
      2106 ±  7%     -91.2%     186.00 ± 17%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
      8439 ±  5%     -82.7%       1461 ± 13%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      2609 ±  8%     -90.4%     251.00 ± 11%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      4297 ± 14%     -41.0%       2537 ± 12%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec
     63957 ±  2%     -35.8%      41042 ±  9%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     48844           -72.1%      13616 ±  9%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    248.37 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_read.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64
    471.01 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
    275.69 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.exit_mmap.__mmput.exit_mm.do_exit
    133.38 ± 66%     -95.8%       5.61 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
    272.22 ±133%     -91.8%      22.24 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
     25.72 ±223%    +763.3%     222.05 ± 11%  perf-sched.wait_and_delay.max.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
    200.89 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
    270.60 ± 24%     -99.0%       2.84 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exec_mmap
    124.17 ± 22%     -93.7%       7.87 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     37.98 ± 17%    +285.9%     146.59 ± 14%  perf-sched.wait_and_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     33.61 ± 18%    +358.2%     153.97 ± 15%  perf-sched.wait_and_delay.max.ms.de_thread.begin_new_exec.load_elf_binary.search_binary_handler
      1009           +30.6%       1319 ± 29%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     79.71 ± 12%    +328.0%     341.16 ± 13%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
    389.95 ± 71%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    428.59 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
     33.90 ± 14%    +255.8%     120.62 ± 10%  perf-sched.wait_and_delay.max.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
    473.25 ± 27%    +164.0%       1249 ± 21%  perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
    460.89 ± 27%    +146.1%       1134 ± 35%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
    345.08 ± 16%    +156.5%     885.16 ± 52%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
    180.36 ± 15%    +290.7%     704.70 ± 93%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     22.25 ± 97%     -98.2%       0.40 ±154%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.move_page_tables
      5.27 ±119%     -91.5%       0.45 ±195%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_bulk.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
      4.06 ± 96%     -85.5%       0.59 ±139%  perf-sched.wait_time.avg.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.63 ±106%     -87.8%       2.28 ±123%  perf-sched.wait_time.avg.ms.__cond_resched.__fput.task_work_run.do_exit.do_group_exit
      0.17 ±171%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__get_user_pages.get_user_pages_remote.get_arg_page.remove_arg_zero
      0.24 ± 64%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.load_elf_binary.search_binary_handler
      0.32 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.load_elf_phdrs.load_elf_binary
      2.62 ± 42%    +142.0%       6.34 ± 33%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
      0.76 ± 89%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.load_elf_binary.search_binary_handler
      3.74 ±  9%     +20.9%       4.52 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.65 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec.__request_module
      0.99 ± 24%   +1541.5%      16.24 ±169%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      9.18 ±  6%     +32.5%      12.17 ± 30%  perf-sched.wait_time.avg.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.12 ±116%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
      0.64 ± 55%     -94.8%       0.03 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.exit_mmap.__mmput.exec_mmap
      0.45 ± 71%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.get_arg_page.copy_string_kernel.load_script
      0.62 ± 76%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.get_arg_page.remove_arg_zero.load_script
      3.16 ± 61%    +299.2%      12.63 ± 64%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.kernfs_dop_revalidate.lookup_fast.walk_component
      0.80 ±144%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read_killable.exec_mmap.begin_new_exec.load_elf_binary
      2.99 ± 49%     -92.3%       0.23 ±222%  perf-sched.wait_time.avg.ms.__cond_resched.down_read_killable.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.86 ± 97%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_timeout.__request_module.search_binary_handler.exec_binprm
     13.55 ±  8%     -25.4%      10.10 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
     18.06 ±  4%     -63.0%       6.67 ± 28%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      2.34 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlink
      8.04 ±163%     -95.6%       0.35 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_expand.shift_arg_pages.setup_arg_pages
     15.39 ±132%    -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.vma_expand.shift_arg_pages
      0.30 ± 84%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      6.73 ± 96%     -93.3%       0.45 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_brk_flags.load_elf_interp.constprop
      0.99 ± 85%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_brk_flags.set_brk.load_elf_binary
      1.54 ±108%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
      2.77 ± 30%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.exit_signals.do_exit.do_group_exit.get_signal
      0.26 ± 98%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.__kernel_read.load_elf_binary.search_binary_handler
      0.48 ± 64%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.__kernel_read.load_elf_phdrs.load_elf_binary
      0.33 ± 39%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.__kernel_read.search_binary_handler.exec_binprm
    119.50 ± 12%    +298.7%     476.42 ± 58%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      1.20 ± 58%    +276.6%       4.53 ± 50%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      1.83 ± 54%    +351.4%       8.26 ± 47%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.45 ± 67%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.getname_kernel.open_exec.load_elf_binary
      2.36 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.taskstats_exit.do_exit.do_group_exit
      0.87 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      3.97 ±  5%    +439.6%      21.40 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.mmput.exit_mm.do_exit.do_group_exit
      2.42 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mmput.free_bprm.do_execveat_common.isra
      3.31 ± 70%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
     12.75 ±105%     -96.2%       0.49 ±222%  perf-sched.wait_time.avg.ms.__cond_resched.move_page_tables.shift_arg_pages.setup_arg_pages.load_elf_binary
      1.57          +361.6%       7.23 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.futex_exec_release.exec_mm_release.exec_mmap
     18.93 ±212%     -98.8%       0.23 ±210%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.kernfs_fop_open.do_dentry_open.do_open
      9.50 ± 85%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
      4.26 ± 37%    +224.9%      13.84 ± 62%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init_many.mm_init
     15.97 ± 35%     -65.8%       5.46 ± 64%  perf-sched.wait_time.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
     15.04 ± 28%     -69.0%       4.67 ±122%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exec_mmap
      0.66 ±137%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
      0.05 ±  6%     -91.4%       0.00 ± 42%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      3.28 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.evict.__dentry_kill.dentry_kill
      2.13 ± 52%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlink
      3.84 ± 69%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.unmap_region.constprop
      3.58 ±  6%    +114.1%       7.68 ± 46%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      0.79 ±  9%    +417.7%       4.10 ± 13%  perf-sched.wait_time.avg.ms.de_thread.begin_new_exec.load_elf_binary.search_binary_handler
      0.30           +64.6%       0.49 ±  7%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      8.59           +82.4%      15.66 ± 12%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.56 ±  8%    +438.0%       8.42 ± 17%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     12.64 ±  8%     +46.8%      18.55 ± 12%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait.call_usermodehelper_exec_work.process_one_work
     13.78 ± 18%     -73.4%       3.67 ± 30%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      3.87 ±  5%     +95.9%       7.59 ± 25%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      8.48 ±  5%     +28.9%      10.92 ±  4%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.01 ± 62%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
      0.19 ± 11%     +92.2%       0.37 ± 27%  perf-sched.wait_time.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      5.90 ±  2%     +78.7%      10.55 ± 21%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
    366.60 ±  7%     +15.3%     422.81 ±  2%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     49.79 ±  5%     +91.7%      95.44 ± 14%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      9.50 ± 12%    +180.7%      26.68 ± 38%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.mmap_region
      7.85 ±  8%    +278.8%      29.73 ± 69%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
      8.18 ± 12%    +269.8%      30.23 ± 85%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      0.02 ± 23%     -89.8%       0.00 ±223%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.stop_one_cpu.sched_exec
      0.74 ± 10%    +365.1%       3.44 ± 14%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec
      1.44 ± 24%    +161.3%       3.77 ± 56%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      3.84 ±  2%     +48.0%       5.68 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      7.84 ±  2%     +93.4%      15.17 ± 10%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.06 ± 53%   +1136.6%       0.79 ± 27%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      6.86          +266.4%      25.15 ± 10%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     75.72 ± 57%     -77.2%      17.24 ±120%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__pmd_alloc.__handle_mm_fault.handle_mm_fault
     41.72 ±182%     -96.4%       1.52 ±154%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.allocate_slab.___slab_alloc.kmem_cache_alloc_node
     97.63 ±110%     -99.6%       0.40 ±154%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.pte_alloc_one.__pte_alloc.move_page_tables
     18.50 ±137%     -97.6%       0.45 ±195%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_bulk.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
    249.77 ± 36%     -93.9%      15.28 ± 29%  perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepare.do_cow_fault.do_fault.__handle_mm_fault
     18.44 ±113%     -94.4%       1.03 ±158%  perf-sched.wait_time.max.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     84.47 ± 94%     -95.7%       3.67 ±159%  perf-sched.wait_time.max.ms.__cond_resched.__fput.task_work_run.do_exit.do_group_exit
      0.21 ±143%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__get_user_pages.get_user_pages_remote.get_arg_page.remove_arg_zero
      2.34 ± 35%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.load_elf_binary.search_binary_handler
      4.94 ± 47%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.load_elf_phdrs.load_elf_binary
     92.00 ± 62%     -78.4%      19.88 ± 36%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
      3.61 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.load_elf_binary.search_binary_handler
    290.60 ± 19%     -88.7%      32.76 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
     14.96 ± 32%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.call_usermodehelper_exec.__request_module
      1.49 ± 26%   +8603.7%     129.38 ±209%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
    314.82 ± 13%     +76.5%     555.60 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      1.99 ± 91%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
    129.47 ± 81%     -97.8%       2.81 ±172%  perf-sched.wait_time.max.ms.__cond_resched.down_read.exit_mm.do_exit.__x64_sys_exit
     25.23 ±106%     -90.0%       2.51 ±145%  perf-sched.wait_time.max.ms.__cond_resched.down_read.exit_mm.do_exit.do_group_exit
      3.33 ± 55%     -99.0%       0.03 ±223%  perf-sched.wait_time.max.ms.__cond_resched.down_read.exit_mmap.__mmput.exec_mmap
      1.26 ± 72%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.get_arg_page.copy_string_kernel.load_script
      1.98 ± 77%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.get_arg_page.remove_arg_zero.load_script
    246.51 ± 20%     -76.1%      58.86 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.down_read.kernfs_fop_readdir.iterate_dir.__x64_sys_getdents64
      1.32 ±171%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read_killable.exec_mmap.begin_new_exec.load_elf_binary
      6.24 ± 40%     -96.3%       0.23 ±222%  perf-sched.wait_time.max.ms.__cond_resched.down_read_killable.iterate_dir.__x64_sys_getdents64.do_syscall_64
      3.65 ± 95%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_timeout.__request_module.search_binary_handler.exec_binprm
     35.42 ± 87%     -65.4%      12.26 ±158%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__anon_vma_prepare.do_cow_fault.do_fault
    158.45 ± 74%     -90.8%      14.51 ± 23%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munmap.do_vmi_munmap
     92.81 ± 48%     -87.7%      11.39 ± 47%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__split_vma.mprotect_fixup.do_mprotect_pkey
    118.04 ± 42%     -91.8%       9.64 ± 64%  perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.mprotect_fixup
    288.08 ± 19%     -89.8%      29.50 ± 47%  perf-sched.wait_time.max.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
    205.15 ± 12%     -87.8%      25.07 ± 52%  perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
    240.47 ± 41%     -82.4%      42.21 ± 40%  perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.exit_mmap
     99.37 ± 54%     -93.7%       6.21 ±109%  perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_file_vma.free_pgtables.unmap_region
      4.78 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlink
     46.19 ±170%     -99.2%       0.35 ±223%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_expand.shift_arg_pages.setup_arg_pages
     39.69 ±139%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.vma_expand.shift_arg_pages
     55.96 ±134%     -97.2%       1.56 ±223%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.__vm_munmap.elf_map.load_elf_binary
    114.17 ± 94%     -93.8%       7.13 ±153%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.create_elf_tables.load_elf_binary.search_binary_handler
      1.37 ± 78%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     13.56 ±121%     -95.1%       0.67 ±131%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.map_vdso.load_elf_binary.search_binary_handler
    156.40 ± 50%     -87.2%      20.01 ±161%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.search_binary_handler
     44.77 ±127%     -99.0%       0.45 ±223%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_brk_flags.load_elf_interp.constprop
      3.88 ± 63%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_brk_flags.set_brk.load_elf_binary
    133.01 ± 42%     -92.6%       9.90 ±100%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map.load_elf_binary
    196.01 ± 42%     -84.3%      30.69 ± 69%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_map.load_elf_interp
    157.78 ± 46%     -92.8%      11.29 ± 70%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      3.80 ± 78%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
     45.13 ±182%     -98.3%       0.76 ±141%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
    131.32 ± 68%     -92.6%       9.74 ±117%  perf-sched.wait_time.max.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
      8.79 ± 41%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.exit_signals.do_exit.do_group_exit.get_signal
      1.52 ± 89%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.filemap_read.__kernel_read.load_elf_binary.search_binary_handler
      3.76 ± 71%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.filemap_read.__kernel_read.load_elf_phdrs.load_elf_binary
      7.02 ± 39%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.filemap_read.__kernel_read.search_binary_handler.exec_binprm
    120.56 ± 79%     -87.5%      15.12 ±102%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_cow_fault.do_fault
      2.58 ± 78%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.getname_kernel.open_exec.load_elf_binary
    208.87 ± 25%     -88.2%      24.63 ± 87%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma
    171.23 ± 33%     -91.7%      14.18 ± 32%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.mmap_region
     60.37 ±201%     -98.8%       0.72 ±223%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.vma_link
     12.35 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.taskstats_exit.do_exit.do_group_exit
     73.47 ±131%     -99.4%       0.45 ±223%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping.map_vdso
    387.68 ± 32%     -66.8%     128.69 ± 86%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region.do_mmap
      5.03 ± 31%     -95.2%       0.24 ±217%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.__split_vma
     29.39 ±217%     -99.4%       0.16 ±208%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.mmap_region
    272.00 ±133%     -90.9%      24.84 ±193%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node.dup_task_struct.copy_process.kernel_clone
      6.30 ± 42%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      7.35 ± 17%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mmput.free_bprm.do_execveat_common.isra
     10.71 ± 79%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
     68.74 ±104%     -98.6%       0.98 ±223%  perf-sched.wait_time.max.ms.__cond_resched.move_page_tables.shift_arg_pages.setup_arg_pages.load_elf_binary
     25.02 ± 30%    +275.5%      93.93 ± 21%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.futex_exec_release.exec_mm_release.exec_mmap
    224.32 ± 73%     -94.8%      11.57 ± 73%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
     38.07 ±206%     -99.4%       0.23 ±210%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.kernfs_fop_open.do_dentry_open.do_open
      9.34 ±166%     -93.2%       0.63 ±132%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_exit_task.do_exit.do_group_exit
     18.43 ± 63%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    259.41 ± 25%     -83.0%      44.12 ±158%  perf-sched.wait_time.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
    198.89 ± 29%     -92.3%      15.31 ± 49%  perf-sched.wait_time.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
     79.54 ± 69%     -89.4%       8.40 ±129%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
    336.72 ± 27%     -89.8%      34.34 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
    269.35 ± 24%     -97.6%       6.35 ± 90%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.exit_mmap.__mmput.exec_mmap
      3.69 ±157%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
    123.54 ± 22%     -91.0%      11.14 ±150%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    144.86 ± 54%     -82.4%      25.46 ± 42%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
     99.26 ± 64%     -95.6%       4.35 ±100%  perf-sched.wait_time.max.ms.__cond_resched.tlb_batch_pages_flush.tlb_finish_mmu.shift_arg_pages.setup_arg_pages
      6.41 ± 37%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.truncate_inode_pages_range.evict.__dentry_kill.dentry_kill
      6.38 ± 48%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlink
      7.06 ± 60%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.unmap_page_range.unmap_vmas.unmap_region.constprop
      5.74 ± 47%     -88.7%       0.65 ±153%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.exit_mmap.__mmput.exec_mmap
    346.66 ± 27%     -77.3%      78.62 ± 59%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
     26.95 ± 26%    +308.5%     110.09 ± 11%  perf-sched.wait_time.max.ms.de_thread.begin_new_exec.load_elf_binary.search_binary_handler
      1002           +31.1%       1314 ± 29%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     45.81 ± 13%    +334.5%     199.05 ±  9%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
    388.29 ± 72%     -87.1%      50.21 ±124%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    117.03 ± 28%     -94.4%       6.56 ± 99%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.95 ± 59%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
     22.11 ± 14%    +360.9%     101.90 ± 21%  perf-sched.wait_time.max.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
    471.08 ± 27%    +164.0%       1243 ± 21%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
     37.56 ±123%     -97.9%       0.78 ±142%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__put_anon_vma
    371.15 ± 11%    +170.6%       1004 ± 42%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
    458.19 ± 27%    +145.9%       1126 ± 36%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma
    341.64 ± 16%    +158.5%     883.18 ± 52%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vma_prepare
      0.03 ± 37%     -92.9%       0.00 ±223%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.stop_one_cpu.sched_exec
    180.35 ± 15%    +289.9%     703.25 ± 93%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.14 ± 41%    +242.4%       3.90 ± 26%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     10.30 ±  2%      -5.6        4.73 ± 10%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.25 ±  2%      -5.5        4.71 ± 10%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.16 ±  2%      -5.5        4.66 ± 10%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.01 ±  2%      -5.4        4.58 ± 10%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     10.78            -5.1        5.69 ±  7%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     10.51            -5.0        5.53 ±  7%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      8.54            -4.6        3.96 ±  8%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      8.52            -4.6        3.95 ±  8%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      9.01            -4.3        4.73 ±  6%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      7.87            -3.9        3.96 ±  8%  perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      7.66            -3.8        3.84 ±  8%  perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
      7.64            -3.8        3.82 ±  8%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
      8.16            -3.7        4.49 ±  7%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      7.53            -3.4        4.13 ±  7%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      7.49            -3.4        4.10 ±  7%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      6.16 ±  2%      -3.4        2.79 ± 10%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      6.09 ±  2%      -3.3        2.75 ± 10%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      3.60 ±  3%      -3.3        0.30 ±100%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
      6.73            -3.1        3.67 ±  7%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      6.44            -2.9        3.50 ±  7%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      3.93 ±  2%      -2.5        1.48 ± 34%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      4.22 ±  2%      -2.4        1.86 ± 35%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      3.78 ±  2%      -2.4        1.42 ± 11%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      4.72            -2.2        2.55 ±  7%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      3.90            -2.1        1.76 ±  8%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exec_mmap.begin_new_exec
      3.84 ±  2%      -2.0        1.81 ± 10%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      2.76 ±  3%      -1.7        1.01 ± 14%  perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_process.kernel_clone
      2.52 ±  3%      -1.7        0.83 ± 12%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
      1.92 ±  3%      -1.6        0.27 ±100%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma
      2.50 ±  3%      -1.6        0.88 ± 15%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm.copy_process
     12.08            -1.6       10.52 ±  2%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      2.40 ±  3%      -1.6        0.84 ± 15%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap.dup_mm
      3.31            -1.5        1.78 ±  7%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      3.00            -1.5        1.47 ±  8%  perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.00            -1.5        1.48 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.17            -1.5        1.70 ±  7%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      2.77            -1.4        1.35 ±  8%  perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.69 ±  6%      -1.4        0.29 ±100%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
      1.69 ±  6%      -1.4        0.29 ±100%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
     37.56            -1.4       36.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     37.53            -1.3       36.19        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.34 ±  2%      -1.3        1.01 ± 11%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      1.79 ±  4%      -1.3        0.52 ± 46%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.dup_mmap
      2.36            -1.2        1.12 ±  9%  perf-profile.calltrace.cycles-pp.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      1.96 ±  2%      -1.2        0.78 ± 12%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      3.22            -1.2        2.05 ±  6%  perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
      1.46 ±  4%      -1.2        0.30 ±100%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      2.55            -1.1        1.42 ±  7%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      1.41 ±  3%      -1.1        0.30 ±100%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.39 ±  3%      -1.1        0.28 ±100%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
      2.40            -1.1        1.33 ±  7%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      1.57 ±  3%      -1.1        0.50 ± 46%  perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      1.93 ±  4%      -1.0        0.91 ± 45%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exec_mmap
      6.54            -1.0        5.56 ±  2%  perf-profile.calltrace.cycles-pp.execve
      6.53            -1.0        5.55 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      6.53            -1.0        5.55 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      6.53            -1.0        5.55 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.69 ±  6%      -1.0        0.71 ± 45%  perf-profile.calltrace.cycles-pp.__cmd_record
      6.52            -1.0        5.54 ±  2%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      6.40            -0.9        5.46 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      6.40            -0.9        5.46 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      6.40            -0.9        5.46 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_execveat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      6.41            -0.9        5.47 ±  2%  perf-profile.calltrace.cycles-pp.syscall
      6.39            -0.9        5.46 ±  2%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execveat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      2.13 ±  4%      -0.9        1.21 ±  7%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exec_mmap.begin_new_exec
      6.28            -0.9        5.41 ±  2%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.23 ±  2%      -0.9        0.37 ± 71%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
     10.44            -0.8        9.60        perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      2.21            -0.8        1.38 ±  6%  perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      1.09            -0.8        0.27 ±100%  perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput
      6.13            -0.8        5.31        perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      6.14            -0.8        5.32 ±  2%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execveat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.13            -0.8        5.31        perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      6.01            -0.8        5.24 ±  2%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execveat.do_syscall_64
      6.01            -0.8        5.24 ±  2%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execveat
      1.59 ±  8%      -0.7        0.85 ±  6%  perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
      1.54 ±  8%      -0.7        0.82 ±  7%  perf-profile.calltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mmap.dup_mm.copy_process
      1.44            -0.7        0.72 ±  7%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      1.39            -0.7        0.68 ±  8%  perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      1.45 ±  2%      -0.7        0.79 ±  9%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      1.36 ±  9%      -0.6        0.71 ±  7%  perf-profile.calltrace.cycles-pp.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      1.39            -0.6        0.75 ±  7%  perf-profile.calltrace.cycles-pp.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.08            -0.6        0.45 ± 45%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     17.18            -0.5       16.64        perf-profile.calltrace.cycles-pp.__libc_fork
      0.98            -0.5        0.46 ± 45%  perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.06 ±  2%      -0.4        0.65 ±  6%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.46 ± 44%      +0.5        0.97 ±  6%  perf-profile.calltrace.cycles-pp.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.46 ± 44%      +0.5        0.97 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.44 ± 44%      +0.5        0.97 ±  6%  perf-profile.calltrace.cycles-pp.exit_notify.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.57 ±  6%  perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.exit_notify.do_exit.__x64_sys_exit.do_syscall_64
      1.11            +0.7        1.84 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
      1.11            +0.7        1.84 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.ret_from_fork_asm
      1.11            +0.7        1.84 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
      1.11            +0.7        1.84 ±  2%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork_asm
      0.00            +0.8        0.76 ±  4%  perf-profile.calltrace.cycles-pp.mm_update_next_owner.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      0.26 ±100%      +0.8        1.05 ± 12%  perf-profile.calltrace.cycles-pp.queued_read_lock_slowpath.do_wait.kernel_wait.call_usermodehelper_exec_work.process_one_work
      0.17 ±141%      +0.9        1.04 ± 12%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_read_lock_slowpath.do_wait.kernel_wait.call_usermodehelper_exec_work
      0.69 ± 18%      +0.9        1.57 ± 12%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait.call_usermodehelper_exec_work.process_one_work.worker_thread
      0.69 ± 18%      +0.9        1.57 ± 12%  perf-profile.calltrace.cycles-pp.kernel_wait.call_usermodehelper_exec_work.process_one_work.worker_thread.kthread
      1.24 ± 15%      +1.1        2.36 ± 12%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.22 ± 15%      +1.1        2.34 ± 12%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.07 ± 17%      +1.2        2.26 ± 13%  perf-profile.calltrace.cycles-pp.call_usermodehelper_exec_work.process_one_work.worker_thread.kthread.ret_from_fork
      3.58 ±  5%      +1.2        4.82 ±  6%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      2.69            +1.3        4.02        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      2.37            +1.4        3.80 ±  2%  perf-profile.calltrace.cycles-pp.mm_update_next_owner.exit_mm.do_exit.do_group_exit.get_signal
      0.87 ±  2%      +1.5        2.34 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.release_task.exit_notify.do_exit
      0.91 ±  2%      +1.5        2.41 ±  3%  perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.release_task.exit_notify.do_exit.do_group_exit
      1.30 ±  2%      +1.5        2.80 ± 10%  perf-profile.calltrace.cycles-pp.queued_read_lock_slowpath.mm_update_next_owner.exit_mm.do_exit.do_group_exit
      0.94 ±  2%      +1.5        2.44 ±  3%  perf-profile.calltrace.cycles-pp.release_task.exit_notify.do_exit.do_group_exit.get_signal
      1.29            +1.5        2.80 ± 10%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_read_lock_slowpath.mm_update_next_owner.exit_mm.do_exit
     15.50            +1.7       17.24        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.50            +1.7       17.24        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.50            +1.7       17.24        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.34 ±  2%      +1.9        3.21 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.de_thread.begin_new_exec.load_elf_binary
      1.45 ±  2%      +1.9        3.38 ±  3%  perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.de_thread.begin_new_exec.load_elf_binary.search_binary_handler
      0.00            +2.0        2.03 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.release_task.de_thread.begin_new_exec
      0.00            +2.1        2.10 ±  3%  perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.release_task.de_thread.begin_new_exec.load_elf_binary
      0.00            +2.1        2.12 ±  3%  perf-profile.calltrace.cycles-pp.release_task.de_thread.begin_new_exec.load_elf_binary.search_binary_handler
     19.38            +2.4       21.79        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.21            +2.5        5.72 ±  3%  perf-profile.calltrace.cycles-pp.__clone
      3.13            +2.5        5.67 ±  3%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      3.13            +2.5        5.68 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      3.13            +2.5        5.68 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__clone
      3.13            +2.5        5.68 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__clone
      2.58            +3.0        5.56 ±  2%  perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.exit_notify.do_exit.do_group_exit.get_signal
      2.47            +3.1        5.56 ±  3%  perf-profile.calltrace.cycles-pp.de_thread.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      4.29            +3.8        8.04 ±  2%  perf-profile.calltrace.cycles-pp.exit_notify.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      3.37 ±  2%      +4.1        7.45 ±  4%  perf-profile.calltrace.cycles-pp.queued_read_lock_slowpath.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      3.35 ±  2%      +4.1        7.44 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_read_lock_slowpath.do_wait.kernel_wait4.__do_sys_wait4
      3.44 ±  2%      +4.2        7.67 ±  5%  perf-profile.calltrace.cycles-pp.wait_task_zombie.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      3.42 ±  2%      +4.2        7.65 ±  5%  perf-profile.calltrace.cycles-pp.release_task.wait_task_zombie.do_wait.kernel_wait4.__do_sys_wait4
      3.30 ±  2%      +4.3        7.55 ±  5%  perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.release_task.wait_task_zombie.do_wait.kernel_wait4
      6.39            +4.4       10.77 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.36            +4.4       10.75 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.35            +4.4       10.75 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.32            +4.4       10.73 ±  2%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      3.08 ±  2%      +4.6        7.64 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.release_task.wait_task_zombie.do_wait
      7.43            +5.1       12.57 ±  2%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop
      7.43            +5.1       12.57 ±  2%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare
      7.43            +5.1       12.57 ±  2%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      5.93 ±  2%      +6.2       12.16 ±  4%  perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.exit_notify.do_exit.do_group_exit.__x64_sys_exit_group
      6.01 ±  2%      +6.2       12.24 ±  4%  perf-profile.calltrace.cycles-pp.exit_notify.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      7.21            +7.8       15.04 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone
      7.65            +7.8       15.50 ±  4%  perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      6.85 ±  2%      +8.3       15.15 ±  4%  perf-profile.calltrace.cycles-pp.wait4
      6.84 ±  2%      +8.3       15.13 ±  4%  perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      6.84 ±  2%      +8.3       15.13 ±  4%  perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      6.83 ±  2%      +8.3       15.13 ±  4%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.84 ±  2%      +8.3       15.14 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      6.84 ±  2%      +8.3       15.14 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      8.05 ±  2%      +9.1       17.19 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.exit_notify.do_exit.do_group_exit
     16.62            -8.6        8.06 ±  8%  perf-profile.children.cycles-pp.__mmput
     16.58            -8.5        8.04 ±  8%  perf-profile.children.cycles-pp.exit_mmap
     13.55 ±  3%      -8.3        5.21 ± 11%  perf-profile.children.cycles-pp.down_write
     12.02 ±  3%      -7.6        4.42 ± 12%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     11.58 ±  3%      -7.4        4.23 ± 12%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     11.65            -6.2        5.43 ±  9%  perf-profile.children.cycles-pp.vm_mmap_pgoff
     11.51            -6.2        5.36 ±  9%  perf-profile.children.cycles-pp.do_mmap
     11.29            -6.1        5.24 ±  9%  perf-profile.children.cycles-pp.mmap_region
     13.35            -5.8        7.59 ±  7%  perf-profile.children.cycles-pp.asm_exc_page_fault
      9.68 ±  2%      -5.7        3.95 ± 10%  perf-profile.children.cycles-pp.free_pgtables
     10.32 ±  2%      -5.6        4.75 ± 10%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      7.92 ±  4%      -5.3        2.59 ± 14%  perf-profile.children.cycles-pp.osq_lock
     12.13            -5.3        6.85 ±  7%  perf-profile.children.cycles-pp.exc_page_fault
     12.07            -5.3        6.82 ±  7%  perf-profile.children.cycles-pp.do_user_addr_fault
     10.78            -5.1        5.69 ±  7%  perf-profile.children.cycles-pp.dup_mm
     10.53            -5.0        5.55 ±  7%  perf-profile.children.cycles-pp.dup_mmap
     11.04            -4.8        6.21 ±  7%  perf-profile.children.cycles-pp.handle_mm_fault
     10.61            -4.7        5.96 ±  7%  perf-profile.children.cycles-pp.__handle_mm_fault
      6.16 ±  3%      -4.0        2.16 ± 12%  perf-profile.children.cycles-pp.unlink_file_vma
      7.88            -3.9        3.98 ±  8%  perf-profile.children.cycles-pp.exec_mmap
      6.96            -3.8        3.18 ± 10%  perf-profile.children.cycles-pp.do_vmi_munmap
      6.87 ±  2%      -3.7        3.13 ± 10%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      7.74            -3.6        4.18 ±  7%  perf-profile.children.cycles-pp.do_fault
      6.42            -3.4        3.04 ±  9%  perf-profile.children.cycles-pp.__split_vma
      6.25 ±  2%      -2.9        3.37 ±  7%  perf-profile.children.cycles-pp.do_read_fault
     12.10            -2.9        9.22 ±  2%  perf-profile.children.cycles-pp.exit_mm
      5.98 ±  2%      -2.8        3.22 ±  7%  perf-profile.children.cycles-pp.filemap_map_pages
      3.93 ±  2%      -2.2        1.69 ± 10%  perf-profile.children.cycles-pp.vma_prepare
      5.02            -2.2        2.83 ±  7%  perf-profile.children.cycles-pp.unmap_vmas
      4.63 ±  2%      -2.0        2.59 ±  7%  perf-profile.children.cycles-pp.unmap_page_range
      4.49 ±  2%      -2.0        2.50 ±  7%  perf-profile.children.cycles-pp.zap_pmd_range
      4.38 ±  2%      -1.9        2.44 ±  7%  perf-profile.children.cycles-pp.zap_pte_range
     12.95            -1.9       11.04 ±  2%  perf-profile.children.cycles-pp.do_execveat_common
     12.58            -1.7       10.84 ±  2%  perf-profile.children.cycles-pp.bprm_execve
      3.03 ±  2%      -1.7        1.38 ± 10%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
     12.26            -1.6       10.64 ±  2%  perf-profile.children.cycles-pp.exec_binprm
     12.26            -1.6       10.64 ±  2%  perf-profile.children.cycles-pp.search_binary_handler
      2.71 ±  2%      -1.6        1.12 ±  9%  perf-profile.children.cycles-pp.up_write
     12.19            -1.6       10.60 ±  2%  perf-profile.children.cycles-pp.load_elf_binary
      3.06            -1.6        1.51 ±  8%  perf-profile.children.cycles-pp.do_mprotect_pkey
      3.06            -1.5        1.51 ±  8%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      2.83            -1.4        1.38 ±  8%  perf-profile.children.cycles-pp.mprotect_fixup
      2.44 ±  2%      -1.4        1.00 ± 11%  perf-profile.children.cycles-pp.unmap_region
      1.68 ±  6%      -1.3        0.42 ± 41%  perf-profile.children.cycles-pp.reader__read_event
      1.69 ±  6%      -1.2        0.46 ± 37%  perf-profile.children.cycles-pp.record__finish_output
      1.69 ±  6%      -1.2        0.46 ± 37%  perf-profile.children.cycles-pp.perf_session__process_events
      2.53 ±  2%      -1.2        1.30 ±  6%  perf-profile.children.cycles-pp.tlb_finish_mmu
      2.60            -1.2        1.40 ±  8%  perf-profile.children.cycles-pp.next_uptodate_folio
      3.23            -1.2        2.06 ±  6%  perf-profile.children.cycles-pp.anon_vma_fork
      2.33 ±  2%      -1.2        1.16 ±  7%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      2.43            -1.1        1.38 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc
      2.23            -1.0        1.24 ±  8%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      6.54            -1.0        5.56 ±  2%  perf-profile.children.cycles-pp.execve
      6.55            -1.0        5.57 ±  2%  perf-profile.children.cycles-pp.__x64_sys_execve
      1.26 ±  9%      -1.0        0.30 ± 39%  perf-profile.children.cycles-pp.process_simple
      1.24 ±  8%      -1.0        0.29 ± 39%  perf-profile.children.cycles-pp.ordered_events__queue
      1.24 ±  9%      -1.0        0.29 ± 39%  perf-profile.children.cycles-pp.queue_event
      1.75 ±  6%      -1.0        0.80 ± 26%  perf-profile.children.cycles-pp.__cmd_record
      1.83 ±  2%      -0.9        0.88 ±  7%  perf-profile.children.cycles-pp.release_pages
      6.41            -0.9        5.47 ±  2%  perf-profile.children.cycles-pp.syscall
      6.42            -0.9        5.48 ±  2%  perf-profile.children.cycles-pp.__x64_sys_execveat
      1.85            -0.9        0.94 ±  9%  perf-profile.children.cycles-pp.vma_complete
      2.29            -0.9        1.43 ±  6%  perf-profile.children.cycles-pp.anon_vma_clone
      1.93            -0.8        1.10 ±  6%  perf-profile.children.cycles-pp.unlink_anon_vmas
     10.47            -0.8        9.64        perf-profile.children.cycles-pp.begin_new_exec
      1.02 ±  4%      -0.8        0.26 ± 13%  perf-profile.children.cycles-pp.rwsem_wake
      1.60 ±  7%      -0.7        0.85 ±  6%  perf-profile.children.cycles-pp.copy_page_range
      1.56 ±  3%      -0.7        0.82 ±  7%  perf-profile.children.cycles-pp.page_remove_rmap
      1.09 ±  3%      -0.7        0.35 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.54 ±  8%      -0.7        0.82 ±  7%  perf-profile.children.cycles-pp.copy_p4d_range
      1.46            -0.7        0.79 ±  7%  perf-profile.children.cycles-pp.do_cow_fault
      1.37 ±  9%      -0.7        0.72 ±  7%  perf-profile.children.cycles-pp.copy_pte_range
      1.39            -0.6        0.79 ±  6%  perf-profile.children.cycles-pp.__do_softirq
      1.34            -0.6        0.76 ±  6%  perf-profile.children.cycles-pp.rcu_core
      1.33            -0.6        0.76 ±  9%  perf-profile.children.cycles-pp._compound_head
      1.31            -0.6        0.74 ±  7%  perf-profile.children.cycles-pp.rcu_do_batch
      1.31            -0.6        0.74 ±  7%  perf-profile.children.cycles-pp.vm_area_dup
     17.21            -0.6       16.66        perf-profile.children.cycles-pp.__libc_fork
      1.08            -0.5        0.53 ±  6%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.57            -0.5        1.04 ±  5%  perf-profile.children.cycles-pp.wp_page_copy
      1.26            -0.5        0.73 ±  7%  perf-profile.children.cycles-pp.kmem_cache_free
      1.20            -0.5        0.68 ±  5%  perf-profile.children.cycles-pp.__alloc_pages
      1.18            -0.5        0.66 ±  6%  perf-profile.children.cycles-pp.__x64_sys_openat
      1.17            -0.5        0.66 ±  6%  perf-profile.children.cycles-pp.do_sys_openat2
      1.15            -0.5        0.64 ±  6%  perf-profile.children.cycles-pp.set_pte_range
      0.98            -0.5        0.48 ±  6%  perf-profile.children.cycles-pp.run_ksoftirqd
      1.10 ±  2%      -0.5        0.59 ±  8%  perf-profile.children.cycles-pp.elf_map
      1.13            -0.5        0.62 ±  7%  perf-profile.children.cycles-pp.__slab_free
      1.02 ±  2%      -0.5        0.56 ±  7%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      1.06            -0.5        0.59 ±  6%  perf-profile.children.cycles-pp.perf_event_mmap
      1.07            -0.5        0.62 ±  8%  perf-profile.children.cycles-pp.mas_store_prealloc
      1.02            -0.4        0.57 ±  6%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.93 ± 13%      -0.4        0.48 ±  6%  perf-profile.children.cycles-pp.copy_present_pte
      1.02            -0.4        0.58 ±  6%  perf-profile.children.cycles-pp.do_filp_open
      1.02 ±  2%      -0.4        0.58 ±  7%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      1.01            -0.4        0.57 ±  6%  perf-profile.children.cycles-pp.path_openat
      1.08 ±  2%      -0.4        0.66 ±  6%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.78 ±  2%      -0.4        0.41 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock
      0.86            -0.4        0.49 ±  7%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.83            -0.4        0.46 ±  5%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.99            -0.3        0.68 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.70            -0.3        0.40 ±  6%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.66 ±  2%      -0.3        0.36 ±  5%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.95            -0.3        0.66 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.44 ±  2%      -0.3        0.14 ± 12%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.42 ±  3%      -0.3        0.13 ± 11%  perf-profile.children.cycles-pp.try_to_wake_up
      0.38 ±  4%      -0.3        0.10 ± 14%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.62            -0.3        0.34 ±  6%  perf-profile.children.cycles-pp.mod_objcg_state
      0.52 ±  3%      -0.3        0.24 ± 11%  perf-profile.children.cycles-pp.vma_expand
      0.39 ±  9%      -0.3        0.12 ± 52%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.62            -0.3        0.35 ±  6%  perf-profile.children.cycles-pp.mas_split
      0.39 ±  9%      -0.3        0.12 ± 51%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.50            -0.3        0.23 ±  9%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.35 ±  4%      -0.3        0.09 ± 14%  perf-profile.children.cycles-pp.wake_up_q
      0.66            -0.3        0.40 ±  6%  perf-profile.children.cycles-pp.sync_regs
      0.42 ±  6%      -0.3        0.17 ± 10%  perf-profile.children.cycles-pp.osq_unlock
      0.54            -0.3        0.28 ±  7%  perf-profile.children.cycles-pp.__schedule
      0.56            -0.3        0.30 ±  5%  perf-profile.children.cycles-pp.do_anonymous_page
      0.60            -0.3        0.35 ±  7%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.54 ±  4%      -0.2        0.29 ±  7%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.54            -0.2        0.29 ±  7%  perf-profile.children.cycles-pp.load_elf_interp
      0.54            -0.2        0.30 ±  5%  perf-profile.children.cycles-pp.vma_alloc_folio
      0.33 ±  3%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.wake_q_add
      0.61            -0.2        0.36 ±  7%  perf-profile.children.cycles-pp._dl_addr
      0.35 ±  9%      -0.2        0.11 ± 51%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.50 ±  2%      -0.2        0.27 ±  9%  perf-profile.children.cycles-pp.dup_task_struct
      0.51 ±  4%      -0.2        0.28 ±  6%  perf-profile.children.cycles-pp.free_swap_cache
      0.50 ±  2%      -0.2        0.27 ±  8%  perf-profile.children.cycles-pp.__vm_munmap
      0.48 ±  2%      -0.2        0.26 ±  7%  perf-profile.children.cycles-pp.getdents64
      0.48 ±  2%      -0.2        0.26 ±  5%  perf-profile.children.cycles-pp.open64
      0.52 ±  2%      -0.2        0.30 ±  7%  perf-profile.children.cycles-pp.mas_store
      0.49            -0.2        0.27 ±  8%  perf-profile.children.cycles-pp.__vm_area_free
      0.48 ±  2%      -0.2        0.26 ±  6%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      0.47 ±  2%      -0.2        0.26 ±  6%  perf-profile.children.cycles-pp.iterate_dir
      0.56            -0.2        0.35 ±  7%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.49 ±  2%      -0.2        0.27 ±  8%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.47            -0.2        0.26 ±  5%  perf-profile.children.cycles-pp.__folio_alloc
      0.48 ±  2%      -0.2        0.27 ±  6%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.46 ±  3%      -0.2        0.25 ±  5%  perf-profile.children.cycles-pp.kernfs_fop_readdir
      0.46 ±  2%      -0.2        0.25 ±  9%  perf-profile.children.cycles-pp.pte_alloc_one
      0.47 ±  2%      -0.2        0.26 ±  8%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.47 ±  2%      -0.2        0.26 ±  8%  perf-profile.children.cycles-pp.mm_init
      0.49            -0.2        0.29 ±  7%  perf-profile.children.cycles-pp.__cond_resched
      0.47            -0.2        0.26 ±  4%  perf-profile.children.cycles-pp.clear_page_erms
      0.36 ±  2%      -0.2        0.16 ± 11%  perf-profile.children.cycles-pp.lru_add_drain
      0.44            -0.2        0.24 ±  7%  perf-profile.children.cycles-pp.__rb_erase_color
      0.36 ±  2%      -0.2        0.16 ± 11%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.48            -0.2        0.28 ±  9%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.43 ±  3%      -0.2        0.23 ±  7%  perf-profile.children.cycles-pp.folio_add_file_rmap_range
      0.46 ±  2%      -0.2        0.27 ±  6%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.46 ±  2%      -0.2        0.26 ±  6%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.42            -0.2        0.23 ±  7%  perf-profile.children.cycles-pp.copy_page
      0.41 ±  2%      -0.2        0.23 ±  7%  perf-profile.children.cycles-pp.__mmdrop
      0.40            -0.2        0.22 ±  6%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.40 ±  3%      -0.2        0.22 ±  6%  perf-profile.children.cycles-pp.vm_area_alloc
      0.38 ±  3%      -0.2        0.20 ± 10%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.43            -0.2        0.25 ±  7%  perf-profile.children.cycles-pp.mas_preallocate
      0.40 ±  3%      -0.2        0.22 ±  7%  perf-profile.children.cycles-pp.___slab_alloc
      0.42            -0.2        0.25 ±  8%  perf-profile.children.cycles-pp.mas_walk
      0.39            -0.2        0.22 ±  8%  perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.42            -0.2        0.25 ±  8%  perf-profile.children.cycles-pp.mtree_range_walk
      0.36            -0.2        0.19 ±  7%  perf-profile.children.cycles-pp.finish_fault
      0.39            -0.2        0.23 ±  8%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.38            -0.2        0.22 ±  6%  perf-profile.children.cycles-pp.mas_next_slot
      0.40 ±  2%      -0.2        0.24 ±  7%  perf-profile.children.cycles-pp.__perf_sw_event
      0.54            -0.2        0.38 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.37            -0.2        0.21 ±  6%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.34 ±  2%      -0.2        0.19 ±  7%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.53            -0.2        0.38 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.36 ±  3%      -0.2        0.21 ±  7%  perf-profile.children.cycles-pp.__sysconf
      0.34            -0.2        0.20 ±  7%  perf-profile.children.cycles-pp.rmqueue
      0.31 ±  5%      -0.2        0.16 ± 10%  perf-profile.children.cycles-pp.__vmalloc_node_range
      0.36 ±  2%      -0.1        0.21 ±  8%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.32            -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.charge_memcg
      0.31 ±  3%      -0.1        0.17 ± 12%  perf-profile.children.cycles-pp.__pte_alloc
      0.34 ±  2%      -0.1        0.20 ±  6%  perf-profile.children.cycles-pp.find_idlest_cpu
      0.33 ±  2%      -0.1        0.19 ±  7%  perf-profile.children.cycles-pp.__do_fault
      0.48            -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.30            -0.1        0.16 ±  8%  perf-profile.children.cycles-pp.schedule
      0.33 ±  2%      -0.1        0.19 ±  8%  perf-profile.children.cycles-pp.___perf_sw_event
      0.40 ±  2%      -0.1        0.27 ±  8%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.30 ±  2%      -0.1        0.16 ±  8%  perf-profile.children.cycles-pp.pcpu_alloc
      0.30 ±  3%      -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.31 ±  2%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.stress_exec
      0.31 ±  2%      -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.find_idlest_group
      0.29 ±  2%      -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.do_open
      0.30            -0.1        0.18 ±  7%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.30            -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.wake_up_new_task
      0.27 ±  3%      -0.1        0.15 ±  9%  perf-profile.children.cycles-pp.alloc_bprm
      0.29 ±  2%      -0.1        0.17 ±  7%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.26 ±  3%      -0.1        0.14 ±  6%  perf-profile.children.cycles-pp.__count_memcg_events
      0.27 ±  3%      -0.1        0.16 ±  8%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.26 ±  5%      -0.1        0.15 ±  8%  perf-profile.children.cycles-pp.stress_mwc1
      0.23 ±  7%      -0.1        0.12 ± 12%  perf-profile.children.cycles-pp.__get_vm_area_node
      0.41            -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.27 ±  3%      -0.1        0.16 ±  8%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.26 ±  2%      -0.1        0.15 ±  9%  perf-profile.children.cycles-pp.__put_anon_vma
      0.26 ±  2%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.22 ±  7%      -0.1        0.11 ± 13%  perf-profile.children.cycles-pp.alloc_vmap_area
      0.28 ±  2%      -0.1        0.17 ± 10%  perf-profile.children.cycles-pp.unmap_single_vma
      0.20 ±  2%      -0.1        0.09 ±  8%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.23            -0.1        0.12 ±  5%  perf-profile.children.cycles-pp.link_path_walk
      0.24 ±  2%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.finish_task_switch
      0.24 ±  3%      -0.1        0.13 ±  7%  perf-profile.children.cycles-pp.remove_vma
      0.39            -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
      0.39            -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.24 ±  2%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.24            -0.1        0.14 ±  9%  perf-profile.children.cycles-pp.alloc_empty_file
      0.13 ±  8%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.machine__process_fork_event
      0.25            -0.1        0.14 ±  9%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.23 ±  2%      -0.1        0.12 ± 11%  perf-profile.children.cycles-pp.vma_interval_tree_augment_rotate
      0.24 ±  2%      -0.1        0.14 ±  9%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.23 ±  2%      -0.1        0.13 ±  6%  perf-profile.children.cycles-pp.mas_store_gfp
      0.23 ±  2%      -0.1        0.13 ±  7%  perf-profile.children.cycles-pp.mas_push_data
      0.22 ±  3%      -0.1        0.13 ±  8%  perf-profile.children.cycles-pp.__cpu_indicator_init
      0.22 ±  2%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.__call_rcu_common
      0.20 ±  5%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.prctl
      0.21 ±  4%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.filemap_fault
      0.20 ±  2%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.schedule_tail
      0.21 ±  2%      -0.1        0.12 ±  7%  perf-profile.children.cycles-pp.__open64_nocancel
      0.22 ±  2%      -0.1        0.13 ±  8%  perf-profile.children.cycles-pp.mas_update_gap
      0.23            -0.1        0.14 ±  6%  perf-profile.children.cycles-pp.open_last_lookups
      0.21 ± 10%      -0.1        0.12 ±  9%  perf-profile.children.cycles-pp.vm_normal_page
      0.22 ±  2%      -0.1        0.13 ±  7%  perf-profile.children.cycles-pp.vfs_read
      0.21 ±  4%      -0.1        0.12 ±  7%  perf-profile.children.cycles-pp.getname_flags
      0.33            -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      0.23 ±  2%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.ksys_read
      0.21 ±  4%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.12 ±  4%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.put_cred_rcu
      0.20 ±  2%      -0.1        0.12 ± 10%  perf-profile.children.cycles-pp.__memcpy
      0.20 ±  2%      -0.1        0.11 ± 10%  perf-profile.children.cycles-pp.task_work_run
      0.19 ±  6%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.xas_load
      0.18 ±  2%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.folio_add_lru_vma
      0.22 ±  3%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.flush_tlb_func
      0.20            -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.mas_find
      0.20            -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.lru_add_fn
      0.20            -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.d_path
      0.20 ±  3%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.do_dentry_open
      0.17 ±  7%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.xas_find
      0.19 ±  3%      -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.14 ±  4%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.newidle_balance
      0.18 ±  3%      -0.1        0.10 ±  6%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.19 ±  2%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.mas_wr_walk
      0.18 ±  2%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.fput
      0.20 ±  3%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.__fput
      0.19 ±  6%      -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.strncpy_from_user
      0.16 ±  6%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.do_task_dead
      0.20 ±  2%      -0.1        0.12 ±  5%  perf-profile.children.cycles-pp.vma_interval_tree_insert_after
      0.18 ±  4%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.13 ±  4%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.load_balance
      0.19 ±  2%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.17 ±  2%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.get_unmapped_area
      0.17 ±  3%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.filemap_read
      0.16 ±  4%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.16 ±  4%      -0.1        0.08 ± 11%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.16 ±  2%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.mas_topiary_replace
      0.16 ±  2%      -0.1        0.09 ± 10%  perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.16 ±  4%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.try_charge_memcg
      0.16 ±  2%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.lookup_fast
      0.20 ±  3%      -0.1        0.13 ±  7%  perf-profile.children.cycles-pp.sched_exec
      0.17 ±  2%      -0.1        0.10 ±  6%  perf-profile.children.cycles-pp.dup_userfaultfd
      0.16 ±  4%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.filemap_get_entry
      0.15 ±  4%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.memset_orig
      0.14 ±  3%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.up_read
      0.16 ±  3%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.setup_arg_pages
      0.12 ±  4%      -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.delayed_vfree_work
      0.09            -0.1        0.03 ±100%  perf-profile.children.cycles-pp._init
      0.14 ±  3%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp._exit
      0.16 ±  3%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.step_into
      0.14 ±  2%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.14 ±  2%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.16 ±  3%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      0.14 ±  3%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.down_read_trylock
      0.14            -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.free_unref_page
      0.13 ±  3%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.15 ±  3%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.15 ±  3%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.get_arg_page
      0.11 ±  4%      -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.vfree
      0.09 ±  5%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.dput
      0.14 ±  5%      -0.1        0.08 ±  9%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.14 ±  3%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.do_brk_flags
      0.14 ±  3%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.copy_string_kernel
      0.14            -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.__get_user_pages
      0.14 ±  2%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.mas_wr_append
      0.12            -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.09 ±  5%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.free_percpu
      0.14 ±  2%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.handle_pte_fault
      0.14 ± 15%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.prctl@plt
      0.14 ±  3%      -0.1        0.08 ±  7%  perf-profile.children.cycles-pp.rcu_all_qs
      0.14 ± 13%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.call_usermodehelper_exec_async
      0.13 ±  5%      -0.1        0.08 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.09 ±  4%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.update_curr
      0.12 ±  3%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.change_protection_range
      0.08            -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.mas_split_final_node
      0.14 ±  3%      -0.1        0.09 ±  6%  perf-profile.children.cycles-pp.free_unref_page_list
      0.14 ± 15%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.kernel_execve
      0.11 ±  6%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.do_wp_page
      0.11 ±  4%      -0.1        0.05 ± 45%  perf-profile.children.cycles-pp.__nptl_set_robust
      0.13 ±  8%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.main
      0.09 ±  7%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.get_partial_node
      0.08            -0.1        0.03 ±100%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.13 ±  4%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.prepend_path
      0.12 ±  3%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.init_file
      0.08 ±  4%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.walk_system_ram_range
      0.12 ±  4%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.refill_obj_stock
      0.11 ±  3%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.change_p4d_range
      0.12 ±  6%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.08 ±  5%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.memmove
      0.12 ±  3%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.activate_task
      0.12 ±  3%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.12 ±  4%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.08 ±  6%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.find_next_iomem_res
      0.08 ±  6%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.stress_cpu_bitops.resolver
      0.18 ±  4%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.12 ±  3%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.shift_arg_pages
      0.11 ±  3%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.09 ±  4%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.free_p4d_range
      0.11 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.mab_mas_cp
      0.09 ±  5%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.__getrlimit
      0.12 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.pick_link
      0.08 ±  8%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.__gettimeofday
      0.18 ±  2%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.11 ±  3%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.brk
      0.10 ±  3%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.free_pgd_range
      0.08            -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.08            -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.find_vma
      0.11            -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.10 ±  4%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.12 ±  4%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.11 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__do_sys_brk
      0.10 ±  3%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.pgd_alloc
      0.10 ±  3%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.change_pmd_range
      0.09 ±  5%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.inode_permission
      0.11 ±  3%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.11 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.do_open_execat
      0.08            -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.pat_pagerange_is_ram
      0.09 ±  4%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.mas_pop_node
      0.10            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__perf_event_header__init_id
      0.10 ±  3%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp._find_next_bit
      0.17 ±  4%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.rb_next
      0.11 ±  3%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.padzero
      0.11 ±  3%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.10 ±  4%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.mt_find
      0.10 ±  4%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.acct_collect
      0.10 ±  4%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.lock_mm_and_find_vma
      0.12 ±  4%      -0.0        0.08 ±  9%  perf-profile.children.cycles-pp.clock_gettime
      0.10 ±  3%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__exit_signal
      0.11 ±  3%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__pmd_alloc
      0.10 ±  3%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__get_free_pages
      0.11 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.mast_fill_bnode
      0.10 ±  3%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.__pte_offset_map
      0.09 ±  4%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.__libc_pthread_init
      0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.07 ±  9%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.error_entry
      0.08 ±  4%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.track_pfn_insert
      0.08 ±  4%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.lookup_memtype
      0.09 ±  4%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.sched_move_task
      0.07            -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.__output_copy
      0.09 ±  4%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.__put_user_4
      0.09 ±  6%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.__pud_alloc
      0.09 ±  5%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.mas_prev_slot
      0.09            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__x64_sys_close
      0.09 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.vmf_insert_pfn_prot
      0.08 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.09 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.11 ±  3%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.stress_exec_remove_pid
      0.10            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.do_softirq
      0.21 ±  7%      +0.1        0.27 ±  5%  perf-profile.children.cycles-pp.setproctitle
      0.00            +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.map__put
      0.21 ±  7%      +0.1        0.32 ±  4%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.21 ±  7%      +0.1        0.32 ±  4%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.00            +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.rb_erase
      0.00            +0.3        0.26 ± 12%  perf-profile.children.cycles-pp.maps__put
      0.00            +0.3        0.29 ± 12%  perf-profile.children.cycles-pp.thread__delete
      0.00            +0.3        0.30 ± 12%  perf-profile.children.cycles-pp.machine__delete_threads
      0.00            +0.3        0.30 ± 12%  perf-profile.children.cycles-pp.perf_session__delete
      0.39 ± 17%      +0.3        0.69 ± 14%  perf-profile.children.cycles-pp.user_mode_thread
      0.55 ±  4%      +0.4        0.98 ±  6%  perf-profile.children.cycles-pp.__x64_sys_exit
      0.69 ± 18%      +0.9        1.57 ± 12%  perf-profile.children.cycles-pp.kernel_wait
      1.24 ± 15%      +1.1        2.36 ± 12%  perf-profile.children.cycles-pp.worker_thread
      1.22 ± 15%      +1.1        2.34 ± 12%  perf-profile.children.cycles-pp.process_one_work
      3.81 ±  5%      +1.1        4.95 ±  6%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.07 ± 17%      +1.2        2.26 ± 13%  perf-profile.children.cycles-pp.call_usermodehelper_exec_work
     15.64            +1.7       17.32        perf-profile.children.cycles-pp.__x64_sys_exit_group
      3.13            +1.9        5.00 ±  2%  perf-profile.children.cycles-pp.mm_update_next_owner
     19.70            +2.3       21.98        perf-profile.children.cycles-pp.__do_sys_clone
      3.21            +2.5        5.72 ±  3%  perf-profile.children.cycles-pp.__clone
     20.09            +2.6       22.68        perf-profile.children.cycles-pp.kernel_clone
     19.76            +2.7       22.50        perf-profile.children.cycles-pp.copy_process
      2.48            +3.1        5.58 ±  3%  perf-profile.children.cycles-pp.de_thread
      3.67 ±  3%      +4.5        8.19 ±  5%  perf-profile.children.cycles-pp.wait_task_zombie
      7.63            +5.1       12.68 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      7.60            +5.1       12.68 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      7.57            +5.1       12.64 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      7.49            +5.1       12.60 ±  2%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      7.49            +5.1       12.60 ±  2%  perf-profile.children.cycles-pp.get_signal
      5.52 ±  3%      +6.3       11.83 ±  4%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
     79.06            +6.5       85.52        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     79.03            +6.5       85.50        perf-profile.children.cycles-pp.do_syscall_64
     23.12            +6.8       29.91        perf-profile.children.cycles-pp.do_group_exit
      6.07 ±  2%      +7.1       13.14 ±  4%  perf-profile.children.cycles-pp.release_task
     23.67            +7.2       30.88        perf-profile.children.cycles-pp.do_exit
      6.84 ±  2%      +8.3       15.13 ±  4%  perf-profile.children.cycles-pp.__do_sys_wait4
      6.85 ±  2%      +8.3       15.15 ±  4%  perf-profile.children.cycles-pp.wait4
      6.84 ±  2%      +8.3       15.13 ±  4%  perf-profile.children.cycles-pp.kernel_wait4
      7.52 ±  3%      +9.2       16.70 ±  4%  perf-profile.children.cycles-pp.do_wait
     10.83           +10.4       21.26 ±  3%  perf-profile.children.cycles-pp.exit_notify
     24.57 ±  2%     +26.3       50.85 ±  4%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
     29.35 ±  2%     +32.0       61.32 ±  4%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      7.83 ±  4%      -5.3        2.57 ± 14%  perf-profile.self.cycles-pp.osq_lock
      2.99 ±  2%      -1.6        1.36 ± 10%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      2.35 ±  2%      -1.1        1.24 ±  7%  perf-profile.self.cycles-pp.filemap_map_pages
      2.38            -1.1        1.28 ±  9%  perf-profile.self.cycles-pp.next_uptodate_folio
      2.21            -1.0        1.23 ±  8%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      1.23 ±  9%      -0.9        0.29 ± 39%  perf-profile.self.cycles-pp.queue_event
      1.67 ±  2%      -0.8        0.85 ±  7%  perf-profile.self.cycles-pp.up_write
      1.44 ±  4%      -0.7        0.75 ±  7%  perf-profile.self.cycles-pp.page_remove_rmap
      1.37 ±  2%      -0.7        0.70 ±  7%  perf-profile.self.cycles-pp.down_write
      1.22 ±  3%      -0.6        0.59 ±  8%  perf-profile.self.cycles-pp.release_pages
      1.46 ±  3%      -0.6        0.83 ±  8%  perf-profile.self.cycles-pp.zap_pte_range
      1.20 ±  2%      -0.5        0.68 ±  9%  perf-profile.self.cycles-pp._compound_head
      1.11            -0.5        0.62 ±  7%  perf-profile.self.cycles-pp.__slab_free
      1.01 ±  2%      -0.5        0.55 ±  7%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      1.07 ±  2%      -0.4        0.65 ±  6%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.57 ±  3%      -0.4        0.20 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.78            -0.3        0.45 ±  7%  perf-profile.self.cycles-pp.kmem_cache_free
      0.63 ± 19%      -0.3        0.31 ±  6%  perf-profile.self.cycles-pp.copy_present_pte
      0.72            -0.3        0.42 ±  7%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.65            -0.3        0.40 ±  6%  perf-profile.self.cycles-pp.sync_regs
      0.42 ±  7%      -0.3        0.16 ± 11%  perf-profile.self.cycles-pp.osq_unlock
      0.56            -0.2        0.31 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.54            -0.2        0.30 ±  6%  perf-profile.self.cycles-pp.mod_objcg_state
      0.32 ±  4%      -0.2        0.08 ± 14%  perf-profile.self.cycles-pp.wake_q_add
      0.57            -0.2        0.33 ±  6%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.54            -0.2        0.32 ±  7%  perf-profile.self.cycles-pp._dl_addr
      0.46 ±  3%      -0.2        0.24 ±  7%  perf-profile.self.cycles-pp.free_swap_cache
      0.39 ±  3%      -0.2        0.18 ± 13%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.56            -0.2        0.35 ±  7%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.46 ±  2%      -0.2        0.25 ±  7%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.46            -0.2        0.26 ±  4%  perf-profile.self.cycles-pp.clear_page_erms
      0.46 ±  2%      -0.2        0.26 ±  5%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.41            -0.2        0.23 ±  7%  perf-profile.self.cycles-pp.copy_page
      0.39            -0.2        0.21 ±  8%  perf-profile.self.cycles-pp.__rb_erase_color
      0.38 ±  3%      -0.2        0.21 ±  8%  perf-profile.self.cycles-pp.folio_add_file_rmap_range
      0.42            -0.2        0.25 ±  8%  perf-profile.self.cycles-pp.mtree_range_walk
      0.38            -0.2        0.22 ±  7%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.38            -0.2        0.22 ±  7%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.35 ±  5%      -0.2        0.20 ± 11%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.34 ±  2%      -0.1        0.20 ±  5%  perf-profile.self.cycles-pp.mas_next_slot
      0.33 ±  2%      -0.1        0.18 ±  5%  perf-profile.self.cycles-pp.dup_mmap
      0.32            -0.1        0.19 ±  9%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.31 ±  2%      -0.1        0.18 ±  5%  perf-profile.self.cycles-pp.set_pte_range
      0.23 ±  9%      -0.1        0.10 ± 19%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.26 ±  2%      -0.1        0.14 ±  5%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.26 ±  3%      -0.1        0.14 ±  5%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.27            -0.1        0.16 ±  7%  perf-profile.self.cycles-pp.___perf_sw_event
      0.27 ±  2%      -0.1        0.16 ±  7%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.26            -0.1        0.15 ±  7%  perf-profile.self.cycles-pp.__cond_resched
      0.26 ±  2%      -0.1        0.16 ±  9%  perf-profile.self.cycles-pp.unmap_single_vma
      0.24 ±  2%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.22            -0.1        0.12 ±  9%  perf-profile.self.cycles-pp.vma_interval_tree_augment_rotate
      0.23            -0.1        0.13 ±  7%  perf-profile.self.cycles-pp.anon_vma_clone
      0.22 ±  2%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.vm_area_dup
      0.22 ±  3%      -0.1        0.13 ±  5%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.21 ±  3%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.___slab_alloc
      0.23 ±  2%      -0.1        0.14 ± 10%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.19 ±  2%      -0.1        0.11 ± 10%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.19            -0.1        0.11 ±  9%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.19 ±  2%      -0.1        0.11 ±  7%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.18 ±  2%      -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.__memcpy
      0.18 ±  2%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.mas_wr_walk
      0.16 ±  2%      -0.1        0.09 ±  7%  perf-profile.self.cycles-pp.mmap_region
      0.19 ±  2%      -0.1        0.12 ±  5%  perf-profile.self.cycles-pp.vma_interval_tree_insert_after
      0.13 ±  2%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.up_read
      0.15 ±  3%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.fput
      0.15 ±  5%      -0.1        0.08 ± 12%  perf-profile.self.cycles-pp.memset_orig
      0.16 ± 10%      -0.1        0.09 ±  8%  perf-profile.self.cycles-pp.vm_normal_page
      0.16 ±  3%      -0.1        0.09 ±  8%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.16 ±  4%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.handle_mm_fault
      0.16 ±  2%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.14 ±  3%      -0.1        0.07 ±  8%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.14 ±  4%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.13 ± 14%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.copy_pte_range
      0.14 ±  2%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp.down_read_trylock
      0.14 ±  4%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.__split_vma
      0.14 ±  4%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.13 ±  5%      -0.1        0.07 ±  6%  perf-profile.self.cycles-pp.filemap_get_entry
      0.08 ±  5%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__pte_offset_map
      0.13 ±  6%      -0.1        0.07 ±  8%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.08 ±  5%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.lru_add_fn
      0.13 ±  2%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.mas_topiary_replace
      0.17 ±  4%      -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.rb_next
      0.12 ±  3%      -0.1        0.07 ±  8%  perf-profile.self.cycles-pp.__call_rcu_common
      0.12 ±  4%      -0.1        0.07 ±  6%  perf-profile.self.cycles-pp.try_charge_memcg
      0.10 ±  4%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.12 ±  3%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.11 ±  3%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.memcg_account_kmem
      0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.find_next_iomem_res
      0.12            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.unmap_page_range
      0.12 ±  4%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.refill_obj_stock
      0.10            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.perf_event_mmap_event
      0.09            -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.mas_update_gap
      0.10 ±  3%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.rcu_all_qs
      0.10 ±  4%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.09 ±  5%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.mas_wr_store_entry
      0.09 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.__alloc_pages
      0.10            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.10 ±  4%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.mas_preallocate
      0.08 ±  5%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.mas_pop_node
      0.09 ±  4%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.mas_walk
      0.08 ±  4%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.mas_prev_slot
      0.09 ±  4%      -0.0        0.05        perf-profile.self.cycles-pp.mab_mas_cp
      0.09            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.anon_vma_fork
      0.08 ±  5%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.08 ±  5%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__perf_sw_event
      0.08 ±  4%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.map__put
      0.00            +0.1        0.10 ± 12%  perf-profile.self.cycles-pp.rb_erase
      0.21 ±  6%      +0.1        0.32 ±  3%  perf-profile.self.cycles-pp.smp_call_function_many_cond
      1.44            +0.1        1.58        perf-profile.self.cycles-pp.queued_write_lock_slowpath
      1.41            +0.2        1.65        perf-profile.self.cycles-pp.mm_update_next_owner
     29.30 ±  2%     +32.0       61.25 ±  4%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/200%/debian-11.1-x86_64-20220510.cgz/300s/lkp-icl-2sp2/UDP_STREAM/netperf

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1004672 ± 11%     +24.9%    1254792 ± 11%  cpuidle..usage
      1.47            -0.3        1.17        mpstat.cpu.all.irq%
      3.23            -0.9        2.33        mpstat.cpu.all.usr%
    781.17 ±  2%     -19.2%     630.83 ±  6%  perf-c2c.DRAM.remote
    604.50 ±  7%     -69.0%     187.67 ±  6%  perf-c2c.HITM.local
    114.83 ± 10%     -45.3%      62.83 ± 18%  perf-c2c.HITM.remote
   5146557 ±  8%     -32.9%    3453221        vmstat.memory.cache
   7185524           -99.1%      67189        vmstat.system.cs
    170126           -14.0%     146355        vmstat.system.in
 1.685e+09           +58.0%  2.662e+09        numa-numastat.node0.local_node
 1.685e+09           +58.0%  2.663e+09        numa-numastat.node0.numa_hit
 1.678e+09           +59.1%   2.67e+09        numa-numastat.node1.local_node
 1.678e+09           +59.2%  2.671e+09        numa-numastat.node1.numa_hit
      2265           +10.7%       2508        turbostat.Avg_MHz
      2325           +10.9%       2578        turbostat.Bzy_MHz
    970892 ± 11%     +25.8%    1221367 ± 12%  turbostat.C1
  52445416           -13.8%   45226755        turbostat.IRQ
     46.73           -18.5%      38.09        turbostat.RAMWatt
     79579 ± 49%     -56.4%      34716 ± 52%  numa-meminfo.node0.Mapped
     21986 ± 92%    +333.7%      95357 ± 88%  numa-meminfo.node0.Shmem
   1618649 ±  8%     -68.2%     514719 ± 16%  numa-meminfo.node1.Active
   1618211 ±  8%     -68.2%     514388 ± 16%  numa-meminfo.node1.Active(anon)
   1063350 ± 47%     -63.5%     387904 ± 22%  numa-meminfo.node1.Inactive
   1063088 ± 47%     -63.5%     387713 ± 22%  numa-meminfo.node1.Inactive(anon)
    468998 ± 82%     -84.7%      71668 ± 30%  numa-meminfo.node1.Mapped
   2317831 ± 18%     -76.0%     555548 ± 14%  numa-meminfo.node1.Shmem
   1636051 ±  8%     -63.6%     595731 ±  3%  meminfo.Active
   1635395 ±  8%     -63.6%     595065 ±  3%  meminfo.Active(anon)
   5018135 ±  8%     -33.6%    3330447        meminfo.Cached
   3337774 ± 13%     -51.9%    1604797        meminfo.Committed_AS
   1382280 ± 40%     -49.2%     701859 ±  3%  meminfo.Inactive
   1381892 ± 41%     -49.3%     700895 ±  3%  meminfo.Inactive(anon)
    548575 ± 77%     -80.7%     105894 ± 29%  meminfo.Mapped
   7471815 ±  6%     -24.8%    5621352        meminfo.Memused
   2338897 ± 18%     -72.2%     650557        meminfo.Shmem
   7892406 ±  6%     -23.4%    6045488        meminfo.max_used_kB
     30399           +19.5%      36340        netperf.ThroughputBoth_Mbps
   7751914           +20.0%    9303206        netperf.ThroughputBoth_total_Mbps
      7975           -95.8%     332.42 ±  2%  netperf.ThroughputRecv_Mbps
   2033643           -95.8%      85098 ±  2%  netperf.ThroughputRecv_total_Mbps
     22424           +60.6%      36008        netperf.Throughput_Mbps
   5718270           +61.2%    9218107        netperf.Throughput_total_Mbps
 1.106e+09           -99.1%    9520520        netperf.time.involuntary_context_switches
      8317           +30.3%      10837        netperf.time.percent_of_cpu_this_job_got
     24609           +31.2%      32299        netperf.time.system_time
    835.50            +3.2%     861.97        netperf.time.user_time
 4.438e+09           +20.0%  5.326e+09        netperf.workload
     19860 ± 49%     -56.3%       8683 ± 51%  numa-vmstat.node0.nr_mapped
      5500 ± 92%    +333.6%      23849 ± 88%  numa-vmstat.node0.nr_shmem
 1.685e+09           +58.0%  2.663e+09        numa-vmstat.node0.numa_hit
 1.685e+09           +58.0%  2.662e+09        numa-vmstat.node0.numa_local
    404554 ±  8%     -68.2%     128549 ± 16%  numa-vmstat.node1.nr_active_anon
    265645 ± 47%     -63.5%      97018 ± 22%  numa-vmstat.node1.nr_inactive_anon
    117175 ± 82%     -84.6%      18054 ± 28%  numa-vmstat.node1.nr_mapped
    579350 ± 18%     -76.0%     138956 ± 14%  numa-vmstat.node1.nr_shmem
    404554 ±  8%     -68.2%     128549 ± 16%  numa-vmstat.node1.nr_zone_active_anon
    265645 ± 47%     -63.5%      97018 ± 22%  numa-vmstat.node1.nr_zone_inactive_anon
 1.678e+09           +59.2%  2.671e+09        numa-vmstat.node1.numa_hit
 1.678e+09           +59.1%   2.67e+09        numa-vmstat.node1.numa_local
    408871 ±  8%     -63.6%     148824 ±  3%  proc-vmstat.nr_active_anon
    169563 ±  3%      -4.8%     161384        proc-vmstat.nr_anon_pages
   1254896 ±  8%     -33.6%     832715        proc-vmstat.nr_file_pages
    345783 ± 40%     -49.3%     175209 ±  3%  proc-vmstat.nr_inactive_anon
    137462 ± 77%     -80.7%      26555 ± 29%  proc-vmstat.nr_mapped
    585085 ± 18%     -72.2%     162739        proc-vmstat.nr_shmem
     31187            -3.0%      30254        proc-vmstat.nr_slab_reclaimable
    408871 ±  8%     -63.6%     148824 ±  3%  proc-vmstat.nr_zone_active_anon
    345783 ± 40%     -49.3%     175209 ±  3%  proc-vmstat.nr_zone_inactive_anon
    226345 ± 23%     -77.1%      51839 ± 17%  proc-vmstat.numa_hint_faults
    186550 ± 31%     -81.5%      34594 ± 25%  proc-vmstat.numa_hint_faults_local
 3.363e+09           +58.6%  5.334e+09        proc-vmstat.numa_hit
 3.363e+09           +58.6%  5.331e+09        proc-vmstat.numa_local
    472352 ± 12%     -41.9%     274372 ±  9%  proc-vmstat.numa_pte_updates
    800993 ± 17%     -71.5%     228526 ±  3%  proc-vmstat.pgactivate
 2.687e+10           +58.6%  4.261e+10        proc-vmstat.pgalloc_normal
   1460411 ±  4%     -16.3%    1222576        proc-vmstat.pgfault
 2.687e+10           +58.6%  4.261e+10        proc-vmstat.pgfree
  17657434           +14.3%   20178457        sched_debug.cfs_rq:/.avg_vruntime.avg
   2081801 ± 15%     +71.2%    3564504 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      4.17 ±  3%     +29.3%       5.39 ±  5%  sched_debug.cfs_rq:/.h_nr_running.max
      0.89 ±  8%     +43.8%       1.28 ± 14%  sched_debug.cfs_rq:/.h_nr_running.min
      0.67           +37.6%       0.92 ±  6%  sched_debug.cfs_rq:/.h_nr_running.stddev
      2.58 ± 88%  +3.7e+06%      96092 ± 75%  sched_debug.cfs_rq:/.left_vruntime.avg
    267.58 ± 91%  +3.3e+06%    8722171 ± 66%  sched_debug.cfs_rq:/.left_vruntime.max
     25.27 ± 87%  +3.4e+06%     869559 ± 67%  sched_debug.cfs_rq:/.left_vruntime.stddev
      9616 ± 18%     +44.3%      13876 ± 25%  sched_debug.cfs_rq:/.load.avg
    188854 ± 74%    +215.5%     595845 ± 52%  sched_debug.cfs_rq:/.load.max
     18292 ± 75%    +233.6%      61017 ± 47%  sched_debug.cfs_rq:/.load.stddev
  17657434           +14.3%   20178460        sched_debug.cfs_rq:/.min_vruntime.avg
   2081802 ± 15%     +71.2%    3564506 ±  8%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.06 ± 12%     +70.6%       0.10 ± 26%  sched_debug.cfs_rq:/.nr_running.stddev
      2.58 ± 88%  +3.7e+06%      96092 ± 75%  sched_debug.cfs_rq:/.right_vruntime.avg
    267.58 ± 91%  +3.3e+06%    8722171 ± 66%  sched_debug.cfs_rq:/.right_vruntime.max
     25.27 ± 87%  +3.4e+06%     869559 ± 67%  sched_debug.cfs_rq:/.right_vruntime.stddev
      3668 ±  3%     +48.1%       5432 ±  5%  sched_debug.cfs_rq:/.runnable_avg.max
    416.43 ±  8%    +126.1%     941.39 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
    616.47 ±  2%     -21.8%     481.86 ± 14%  sched_debug.cfs_rq:/.util_avg.min
    503.78 ±  3%     -15.5%     425.51        sched_debug.cfs_rq:/.util_est_enqueued.avg
      1365 ±  5%     +12.8%       1540 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.max
    255.94           +16.8%     298.85 ±  3%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    626590 ± 11%     -28.4%     448406 ±  3%  sched_debug.cpu.avg_idle.avg
   1549078 ± 42%     -34.7%    1012313        sched_debug.cpu.avg_idle.max
      4009 ± 16%    +138.1%       9547 ±  7%  sched_debug.cpu.avg_idle.min
    386914 ± 24%     -23.0%     297912        sched_debug.cpu.avg_idle.stddev
     37.85 ± 11%     -50.4%      18.76 ± 15%  sched_debug.cpu.clock.stddev
      0.00 ±  4%     -40.8%       0.00 ±  9%  sched_debug.cpu.next_balance.stddev
      4.08 ±  5%     +32.0%       5.39 ±  5%  sched_debug.cpu.nr_running.max
      0.67 ±  2%     +37.0%       0.92 ±  6%  sched_debug.cpu.nr_running.stddev
   8520448           -99.0%      83495 ±  2%  sched_debug.cpu.nr_switches.avg
  10903805 ±  3%     -98.3%     186011 ± 22%  sched_debug.cpu.nr_switches.max
   7314094 ±  3%     -99.1%      64483 ± 14%  sched_debug.cpu.nr_switches.min
    607096 ± 18%     -97.2%      16789 ± 27%  sched_debug.cpu.nr_switches.stddev
      1.80 ±  5%     -62.3%       0.68 ±  2%  perf-stat.i.MPKI
 2.394e+10            +9.0%  2.609e+10        perf-stat.i.branch-instructions
      1.09            -0.1        0.95        perf-stat.i.branch-miss-rate%
 2.591e+08            -4.2%  2.483e+08        perf-stat.i.branch-misses
      5.47 ±  5%     +12.7       18.16 ±  2%  perf-stat.i.cache-miss-rate%
 2.337e+08 ±  5%     -57.7%   98986630 ±  2%  perf-stat.i.cache-misses
 4.279e+09           -87.1%  5.541e+08        perf-stat.i.cache-references
   7253512           -99.1%      67518        perf-stat.i.context-switches
      2.24            -2.1%       2.19        perf-stat.i.cpi
 2.887e+11           +10.6%  3.193e+11        perf-stat.i.cpu-cycles
      1377 ±  4%    +143.6%       3356 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.01 ±  9%      -0.0        0.00 ±  2%  perf-stat.i.dTLB-load-miss-rate%
   4032948 ± 10%     -70.6%    1186470 ±  3%  perf-stat.i.dTLB-load-misses
  3.57e+10           +13.1%  4.037e+10        perf-stat.i.dTLB-loads
      0.01 ±  9%      -0.0        0.01 ±  2%  perf-stat.i.dTLB-store-miss-rate%
   2761122 ± 10%     -21.3%    2172944        perf-stat.i.dTLB-store-misses
 2.163e+10           +13.0%  2.445e+10        perf-stat.i.dTLB-stores
 1.299e+11           +12.4%  1.459e+11        perf-stat.i.instructions
      0.45            +1.7%       0.46        perf-stat.i.ipc
      2.26           +10.5%       2.49        perf-stat.i.metric.GHz
      1219 ±  5%     -56.7%     528.18 ±  2%  perf-stat.i.metric.K/sec
    668.28            +6.9%     714.19        perf-stat.i.metric.M/sec
      4230 ±  4%     -16.2%       3544        perf-stat.i.minor-faults
  33627191 ±  6%     -47.6%   17606499 ±  3%  perf-stat.i.node-load-misses
    860333 ± 28%     -62.0%     327037 ± 17%  perf-stat.i.node-loads
  55972753 ±  5%     -61.2%   21707486 ±  6%  perf-stat.i.node-store-misses
  55165937 ±  6%     -54.2%   25284256 ±  8%  perf-stat.i.node-stores
      4230 ±  4%     -16.2%       3544        perf-stat.i.page-faults
      1.80 ±  5%     -62.3%       0.68 ±  2%  perf-stat.overall.MPKI
      1.08            -0.1        0.95        perf-stat.overall.branch-miss-rate%
      5.47 ±  5%     +12.5       17.93 ±  2%  perf-stat.overall.cache-miss-rate%
      2.22            -1.6%       2.19        perf-stat.overall.cpi
      1237 ±  5%    +160.5%       3224 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±  9%      -0.0        0.00 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  9%      -0.0        0.01        perf-stat.overall.dTLB-store-miss-rate%
      0.45            +1.6%       0.46        perf-stat.overall.ipc
      8952            -5.9%       8424        perf-stat.overall.path-length
 2.386e+10            +9.4%   2.61e+10        perf-stat.ps.branch-instructions
 2.583e+08            -3.8%  2.484e+08        perf-stat.ps.branch-misses
  2.33e+08 ±  5%     -57.5%   99108939 ±  2%  perf-stat.ps.cache-misses
 4.265e+09           -87.0%  5.527e+08        perf-stat.ps.cache-references
   7229443           -99.1%      67558        perf-stat.ps.context-switches
 2.878e+11           +11.0%  3.194e+11        perf-stat.ps.cpu-cycles
   4022939 ± 10%     -70.2%    1200154 ±  3%  perf-stat.ps.dTLB-load-misses
 3.557e+10           +13.5%  4.038e+10        perf-stat.ps.dTLB-loads
   2750827 ± 10%     -21.0%    2173887        perf-stat.ps.dTLB-store-misses
 2.156e+10           +13.4%  2.446e+10        perf-stat.ps.dTLB-stores
 1.294e+11           +12.8%   1.46e+11        perf-stat.ps.instructions
      0.03 ± 55%     +95.5%       0.05 ± 32%  perf-stat.ps.major-faults
      4199 ±  4%     -18.7%       3415        perf-stat.ps.minor-faults
  33544663 ±  6%     -47.4%   17639108 ±  3%  perf-stat.ps.node-load-misses
    857620 ± 28%     -61.9%     326891 ± 17%  perf-stat.ps.node-loads
  55803283 ±  5%     -61.1%   21731314 ±  6%  perf-stat.ps.node-store-misses
  54985365 ±  6%     -53.9%   25321155 ±  8%  perf-stat.ps.node-stores
      4199 ±  4%     -18.7%       3415        perf-stat.ps.page-faults
 3.973e+13           +12.9%  4.487e+13        perf-stat.total.instructions
      0.05 ± 13%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
      0.01 ± 19%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 61%  +17477.2%       1.67 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ±142%  +14366.7%       1.01 ±  7%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.17 ±192%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
    127.29 ± 84%     -96.7%       4.21 ± 76%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 43%   +7000.0%       0.59 ± 37%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.18 ± 76%    +242.8%       4.04 ± 29%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.26 ± 17%   +1330.0%       3.65        perf-sched.sch_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
      0.25 ± 53%    +557.4%       1.63 ±  5%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 20%  +10098.5%       1.14 ± 34%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     34.60 ± 57%     -94.0%       2.08 ± 20%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ±198%  +11439.2%       0.98 ± 13%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     94.28 ±181%     -97.7%       2.14 ± 86%  perf-sched.sch_delay.max.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg
      0.09 ± 20%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
      0.02 ± 25%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.06 ± 63%   +6835.1%       4.18 ± 13%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ±142%  +19200.0%       1.35 ± 33%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.48 ±223%    +456.2%       2.64 ± 51%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      5.94 ±219%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
    613.00 ± 98%     -99.6%       2.57 ± 60%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      3205 ± 28%     -84.1%     508.83 ± 99%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02 ± 88%  +13173.1%       3.21 ± 11%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      2.83 ± 72%    +131.2%       6.54 ± 28%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      2534 ± 24%     -94.1%     148.88 ± 11%  perf-sched.sch_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
      2.18 ± 66%    +169.8%       5.89 ± 49%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 31%  +18121.6%       2.67 ± 27%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1034 ± 47%     -98.0%      20.51 ±179%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.03 ±191%  +15454.5%       4.04 ±  4%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.13 ± 15%   +1300.9%       1.88        perf-sched.total_sch_delay.average.ms
      3754 ± 19%     -65.6%       1292 ± 49%  perf-sched.total_sch_delay.max.ms
      1.07 ± 15%   +1093.0%      12.71        perf-sched.total_wait_and_delay.average.ms
   3239167 ± 19%     -89.9%     328252        perf-sched.total_wait_and_delay.count.ms
      6639 ± 15%     -37.2%       4170 ±  8%  perf-sched.total_wait_and_delay.max.ms
      0.93 ± 15%   +1063.2%      10.82        perf-sched.total_wait_time.average.ms
      5297 ±  5%     -21.3%       4170 ±  8%  perf-sched.total_wait_time.max.ms
     15.94 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     19.65 ± 20%     -79.1%       4.10 ±  2%  perf-sched.wait_and_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
      3.36 ± 38%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     20.96 ± 23%     -80.3%       4.14        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     25.51 ± 31%     -83.7%       4.15        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_node.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
    313.39 ± 33%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.06 ±223%  +75297.4%     801.22        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.24 ±117%  +52898.3%     656.47 ±  3%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     40.73 ±100%    +446.1%     222.42        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     23.95 ± 42%     -83.0%       4.06 ±  2%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.55 ± 16%    +653.1%       4.11        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    168.76 ±151%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.96 ± 16%   +1064.0%      11.18        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
    108.37 ±124%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    103.74 ± 35%     -84.0%      16.62 ± 46%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    300.52 ± 15%     +56.5%     470.21 ±  5%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.17 ± 70%     -97.3%       0.17 ±223%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
    315.83 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    418.50 ± 12%   +1405.4%       6300        perf-sched.wait_and_delay.count.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
      1.33 ± 35%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
    698.50 ± 18%   +1271.6%       9580        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
    107.83 ± 17%   +1624.6%       1859 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_node.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     24.67 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.17 ±223%   +2900.0%       5.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.83 ±107%    +600.0%       5.83 ±  6%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     11.33 ± 78%    +998.5%     124.50        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    284.33 ± 24%   +1338.0%       4088        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
   1612428 ± 19%     -91.6%     135646        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     11.00 ± 56%    -100.0%       0.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1.50 ±171%   +4700.0%      72.00 ± 26%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      3.67 ± 20%    +259.1%      13.17 ±  5%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
   1621410 ± 19%     -89.7%     166227        perf-sched.wait_and_delay.count.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
     12.00 ± 47%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      3.00 ± 66%    +566.7%      20.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      2837 ± 16%     -23.4%       2173 ±  9%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.50 ± 33%     -77.8%       0.33 ±141%  perf-sched.wait_and_delay.count.syslog_print.do_syslog.kmsg_read.vfs_read
    104.67 ± 22%    +585.2%     717.17 ±  2%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1043          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1721 ± 45%     -96.2%      65.67 ± 53%  perf-sched.wait_and_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
      3.67 ± 44%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      1922 ± 39%     -95.8%      79.93 ± 65%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1053 ± 21%     -96.1%      41.26 ± 74%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_node.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      1996 ± 26%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.06 ±223%  +94154.0%       1001        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.63 ±102%  +61175.4%       1001        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1628 ± 41%     -97.3%      43.26 ± 46%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      2855 ± 14%     -95.3%     135.14 ± 17%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      4723 ± 33%     -69.6%       1436 ± 18%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    744.50 ±112%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      5093 ± 23%     -95.5%     229.27 ± 10%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
      1354 ±102%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2276 ± 46%     -88.5%     262.05 ± 45%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      5245 ±  6%     -25.2%       3922 ± 17%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5717 ± 20%     -47.9%       2976 ± 22%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     15.93 ± 10%     -57.8%       6.73 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.10 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
     19.65 ± 20%     -79.1%       4.10 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
      3.36 ± 38%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
     20.96 ± 23%     -80.3%       4.14        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     25.51 ± 31%     -83.7%       4.15        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      8.24 ± 21%    +788.2%      73.17 ± 82%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
    313.38 ± 33%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.23 ±130%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1.07 ±221%  +74662.7%     800.21        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.00 ±152%  +65480.4%     655.80 ±  3%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     22.48 ±152%    +875.7%     219.36        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     21.79 ± 38%     -81.4%       4.06 ±  2%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      8.98 ±136%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.54 ± 16%    +653.5%       4.11        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.70 ± 16%    +967.4%       7.53        perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
     69.14 ± 27%     -76.0%      16.61 ± 18%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    300.10 ± 15%     +56.7%     470.14 ±  5%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±166%   +4177.8%       0.83 ± 35%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    383.82 ± 71%     -98.6%       5.34 ± 93%  perf-sched.wait_time.max.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg
      0.14 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
      1721 ± 45%     -96.2%      65.67 ± 53%  perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
      3.67 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      1922 ± 39%     -95.8%      79.93 ± 65%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1053 ± 21%     -96.1%      41.26 ± 74%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     11.92 ± 19%   +7785.8%     940.02 ± 75%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      1996 ± 26%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.38 ±179%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1.08 ±220%  +92833.7%       1000        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.16 ±143%  +86225.1%       1000        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    335.65 ±139%    +199.3%       1004        perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1346 ± 19%     -96.8%      43.26 ± 46%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    232.14 ±116%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      2829 ± 14%     -95.2%     135.14 ± 17%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      3221 ± 21%     -59.1%       1318        perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2695 ± 15%     -93.9%     165.66 ±  4%  perf-sched.wait_time.max.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
      1309 ± 36%     -75.8%     317.35 ±  7%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      5157 ±  4%     -23.9%       3922 ± 17%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.09 ±184%   +3992.1%       3.87        perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      4853 ± 18%     -38.7%       2975 ± 22%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     23.97           -22.4        1.53 ±  6%  perf-profile.calltrace.cycles-pp.recv_omni.process_requests.spawn_child.accept_connection.accept_connections
     23.48           -22.0        1.49 ±  6%  perf-profile.calltrace.cycles-pp.recvfrom.recv_omni.process_requests.spawn_child.accept_connection
     23.26           -21.8        1.48 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvfrom.recv_omni.process_requests.spawn_child
     23.12           -21.6        1.48 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom.recv_omni.process_requests
     23.04           -21.6        1.45 ±  6%  perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
     22.51           -21.0        1.46 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom.recv_omni
     22.41 ± 15%     -20.9        1.53 ±  6%  perf-profile.calltrace.cycles-pp.accept_connections.main.__libc_start_main
     22.41 ± 15%     -20.9        1.53 ±  6%  perf-profile.calltrace.cycles-pp.accept_connection.accept_connections.main.__libc_start_main
     22.41 ± 15%     -20.9        1.53 ±  6%  perf-profile.calltrace.cycles-pp.spawn_child.accept_connection.accept_connections.main.__libc_start_main
     22.41 ± 15%     -20.9        1.53 ±  6%  perf-profile.calltrace.cycles-pp.process_requests.spawn_child.accept_connection.accept_connections.main
     22.14           -20.7        1.40 ±  7%  perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.97           -20.6        1.40 ±  7%  perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     21.92           -20.5        1.40 ±  7%  perf-profile.calltrace.cycles-pp.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     15.63           -14.5        1.17 ±  7%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
     15.59           -14.4        1.17 ±  7%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg.sock_recvmsg
     15.00           -13.9        1.14 ±  7%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg
     14.69           -13.6        1.13 ±  7%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg
      5.70 ±  3%      -0.8        4.86        perf-profile.calltrace.cycles-pp.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      5.80 ±  3%      -0.8        5.01        perf-profile.calltrace.cycles-pp.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      6.84 ±  2%      -0.3        6.50        perf-profile.calltrace.cycles-pp.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      7.13 ±  2%      -0.2        6.89        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
      7.20 ±  2%      -0.2        6.98        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      0.61 ±  5%      +0.1        0.74 ±  3%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill
      0.62 ±  2%      +0.2        0.82        perf-profile.calltrace.cycles-pp.move_addr_to_kernel.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.09 ±  4%      +0.2        1.31        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill.__ip_append_data
      0.57            +0.2        0.82        perf-profile.calltrace.cycles-pp.irqtime_account_irq.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      1.21            +0.3        1.46 ±  2%  perf-profile.calltrace.cycles-pp.fib_table_lookup.ip_route_output_key_hash_rcu.ip_route_output_flow.udp_sendmsg.sock_sendmsg
      0.61 ±  5%      +0.3        0.87        perf-profile.calltrace.cycles-pp.netif_rx_internal.__netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit
      0.73 ±  7%      +0.3        1.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data
      0.68 ±  2%      +0.3        0.95        perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      0.64 ±  4%      +0.3        0.92        perf-profile.calltrace.cycles-pp.__netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
      1.36 ±  3%      +0.3        1.66        perf-profile.calltrace.cycles-pp.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill.__ip_append_data.ip_make_skb
      0.69            +0.3        1.00        perf-profile.calltrace.cycles-pp.__udp4_lib_lookup.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      0.67 ±  2%      +0.3        0.98        perf-profile.calltrace.cycles-pp.__check_object_size.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg
      0.47 ± 44%      +0.3        0.79        perf-profile.calltrace.cycles-pp.enqueue_to_backlog.netif_rx_internal.__netif_rx.loopback_xmit.dev_hard_start_xmit
      1.39            +0.3        1.71 ±  2%  perf-profile.calltrace.cycles-pp.ip_route_output_key_hash_rcu.ip_route_output_flow.udp_sendmsg.sock_sendmsg.__sys_sendto
      0.47 ± 44%      +0.3        0.79        perf-profile.calltrace.cycles-pp.security_socket_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      1.99            +0.5        2.53        perf-profile.calltrace.cycles-pp.ip_route_output_flow.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.send_data.send_omni_inner.send_udp_stream.main.__libc_start_main
      1.32 ±  3%      +0.5        1.85        perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_send_skb
      0.00            +0.5        0.55 ±  2%  perf-profile.calltrace.cycles-pp._copy_from_user.move_addr_to_kernel.__sys_sendto.__x64_sys_sendto.do_syscall_64
      0.00            +0.6        0.56 ±  3%  perf-profile.calltrace.cycles-pp.sock_wfree.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.sched_clock_cpu.irqtime_account_irq.__do_softirq.do_softirq.__local_bh_enable_ip
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.__netif_receive_skb_core.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      1.47 ±  2%      +0.6        2.06        perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
      0.08 ±223%      +0.6        0.68        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.ip_generic_getfrag.__ip_append_data.ip_make_skb
      0.00            +0.6        0.60 ±  2%  perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      2.02 ±  2%      +0.6        2.64        perf-profile.calltrace.cycles-pp.skb_page_frag_refill.sk_page_frag_refill.__ip_append_data.ip_make_skb.udp_sendmsg
      0.17 ±141%      +0.6        0.79        perf-profile.calltrace.cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data
      0.00            +0.6        0.64 ±  2%  perf-profile.calltrace.cycles-pp.udp4_lib_lookup2.__udp4_lib_lookup.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      2.10 ±  2%      +0.7        2.76        perf-profile.calltrace.cycles-pp.sk_page_frag_refill.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg
      0.00            +0.7        0.66        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.00            +0.7        0.67 ±  2%  perf-profile.calltrace.cycles-pp.validate_xmit_skb.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
     10.81            +0.7       11.51        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
     10.57            +0.7       11.28        perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     10.72            +0.7       11.43        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb
      1.64 ±  3%      +0.8        2.42        perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_make_skb
      1.73 ±  3%      +0.9        2.58        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg
      0.26 ±100%      +0.9        1.13        perf-profile.calltrace.cycles-pp.free_unref_page_prepare.free_unref_page.skb_release_data.kfree_skb_reason.udp_queue_rcv_one_skb
      2.20 ±  2%      +0.9        3.14        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg
      0.83 ±  2%      +0.9        1.78        perf-profile.calltrace.cycles-pp.free_unref_page.skb_release_data.kfree_skb_reason.udp_queue_rcv_one_skb.udp_unicast_rcv_skb
      1.34            +1.6        2.99        perf-profile.calltrace.cycles-pp.skb_release_data.kfree_skb_reason.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv
      1.39            +1.7        3.08        perf-profile.calltrace.cycles-pp.kfree_skb_reason.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu
     13.20            +1.7       14.94        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg
     13.81            +1.9       15.67        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg.sock_sendmsg
     14.84            +2.3       17.12        perf-profile.calltrace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
     15.31            +2.4       17.70        perf-profile.calltrace.cycles-pp.udp_send_skb.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
     94.98 ±  3%      +4.2       99.17        perf-profile.calltrace.cycles-pp.__libc_start_main
     94.90 ±  3%      +4.2       99.14        perf-profile.calltrace.cycles-pp.main.__libc_start_main
      4.80 ±  7%      +5.9       10.72        perf-profile.calltrace.cycles-pp.__ip_select_ident.__ip_make_skb.ip_make_skb.udp_sendmsg.sock_sendmsg
      5.23 ±  6%      +6.0       11.27        perf-profile.calltrace.cycles-pp.__ip_make_skb.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
     31.86           +12.6       44.43        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.ip_generic_getfrag.__ip_append_data.ip_make_skb
     32.48           +12.8       45.28        perf-profile.calltrace.cycles-pp._copy_from_iter.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg
     33.38           +13.2       46.60        perf-profile.calltrace.cycles-pp.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg
     39.94           +15.7       55.68        perf-profile.calltrace.cycles-pp.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
     45.69           +22.0       67.73        perf-profile.calltrace.cycles-pp.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
     70.52           +24.5       95.06        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendto.send_omni_inner.send_udp_stream.main
     70.32           +24.6       94.94        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.send_omni_inner.send_udp_stream
     71.13           +24.8       95.89        perf-profile.calltrace.cycles-pp.sendto.send_omni_inner.send_udp_stream.main.__libc_start_main
     72.45           +25.1       97.56        perf-profile.calltrace.cycles-pp.send_omni_inner.send_udp_stream.main.__libc_start_main
     72.48           +25.1       97.61        perf-profile.calltrace.cycles-pp.send_udp_stream.main.__libc_start_main
     64.78           +25.3       90.08        perf-profile.calltrace.cycles-pp.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     65.70           +25.7       91.42        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     67.28           +26.6       93.84        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     67.49           +26.7       94.14        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.send_omni_inner
     24.71           -23.2        1.55 ±  3%  perf-profile.children.cycles-pp.recvfrom
     23.97           -22.4        1.57 ±  3%  perf-profile.children.cycles-pp.accept_connections
     23.97           -22.4        1.57 ±  3%  perf-profile.children.cycles-pp.accept_connection
     23.97           -22.4        1.57 ±  3%  perf-profile.children.cycles-pp.spawn_child
     23.97           -22.4        1.57 ±  3%  perf-profile.children.cycles-pp.process_requests
     23.97           -22.4        1.57 ±  3%  perf-profile.children.cycles-pp.recv_omni
     23.12           -21.6        1.50 ±  3%  perf-profile.children.cycles-pp.__x64_sys_recvfrom
     23.06           -21.6        1.50 ±  3%  perf-profile.children.cycles-pp.__sys_recvfrom
     22.14           -20.7        1.45 ±  3%  perf-profile.children.cycles-pp.sock_recvmsg
     21.98           -20.5        1.44 ±  3%  perf-profile.children.cycles-pp.inet_recvmsg
     21.93           -20.5        1.44 ±  3%  perf-profile.children.cycles-pp.udp_recvmsg
     15.63           -14.4        1.20 ±  3%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
     15.60           -14.4        1.20 ±  3%  perf-profile.children.cycles-pp.__skb_datagram_iter
     15.01           -13.8        1.17 ±  4%  perf-profile.children.cycles-pp._copy_to_iter
     14.80           -13.6        1.16 ±  4%  perf-profile.children.cycles-pp.copyout
      5.70            -5.6        0.12 ±  3%  perf-profile.children.cycles-pp.schedule
      5.58            -5.5        0.13 ±  2%  perf-profile.children.cycles-pp.__schedule
      4.92            -4.8        0.13        perf-profile.children.cycles-pp.__skb_recv_udp
      3.91            -3.8        0.08 ±  4%  perf-profile.children.cycles-pp.__skb_wait_for_more_packets
      3.50            -3.4        0.07 ±  5%  perf-profile.children.cycles-pp.schedule_timeout
      3.46            -3.3        0.20 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      3.63            -3.2        0.44        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.45 ±  5%      -3.1        0.34 ±  4%  perf-profile.children.cycles-pp.__udp_enqueue_schedule_skb
      2.70 ±  6%      -2.6        0.05 ±  8%  perf-profile.children.cycles-pp.sock_def_readable
      2.63 ±  7%      -2.6        0.05        perf-profile.children.cycles-pp.__wake_up_common_lock
      2.50 ±  7%      -2.5        0.04 ± 44%  perf-profile.children.cycles-pp.__wake_up_common
      2.45 ±  7%      -2.4        0.02 ± 99%  perf-profile.children.cycles-pp.autoremove_wake_function
      2.50            -2.4        0.09        perf-profile.children.cycles-pp.exit_to_user_mode_loop
      2.41 ±  7%      -2.4        0.02 ± 99%  perf-profile.children.cycles-pp.try_to_wake_up
      0.97 ±  4%      -0.9        0.09 ±  5%  perf-profile.children.cycles-pp.__consume_stateless_skb
      5.84 ±  2%      -0.9        4.98        perf-profile.children.cycles-pp.udp_queue_rcv_one_skb
      5.91 ±  2%      -0.8        5.06        perf-profile.children.cycles-pp.udp_unicast_rcv_skb
      6.99 ±  2%      -0.4        6.59        perf-profile.children.cycles-pp.__udp4_lib_rcv
      7.27 ±  2%      -0.3        6.98        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
      7.34 ±  2%      -0.3        7.05        perf-profile.children.cycles-pp.ip_local_deliver_finish
      0.80 ±  2%      -0.2        0.61 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.58 ±  2%      -0.2        0.40        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.70 ±  3%      -0.2        0.53 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.67 ±  3%      -0.2        0.51 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.65 ±  3%      -0.2        0.49 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.75            -0.2        0.59        perf-profile.children.cycles-pp.sockfd_lookup_light
      0.60 ±  3%      -0.1        0.45 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.53 ±  2%      -0.1        0.40 ±  5%  perf-profile.children.cycles-pp.tick_sched_timer
      0.50 ±  3%      -0.1        0.38 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.50 ±  3%      -0.1        0.38 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.29 ±  6%      -0.1        0.18 ±  5%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.29 ±  6%      -0.1        0.18 ±  5%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.43 ±  3%      -0.1        0.34 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      0.59            -0.1        0.51        perf-profile.children.cycles-pp.__fget_light
      0.14 ±  2%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.import_single_range
      0.45 ±  2%      -0.0        0.41 ±  3%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.19            -0.0        0.15        perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.14 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.12 ±  4%      -0.0        0.09 ±  9%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.09            -0.0        0.07        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.07 ±  5%      +0.0        0.08        perf-profile.children.cycles-pp.netdev_core_pick_tx
      0.13            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.check_stack_object
      0.44            +0.0        0.46        perf-profile.children.cycles-pp.native_sched_clock
      0.11            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.ip_finish_output
      0.06 ±  8%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.demo_interval_tick
      0.49            +0.0        0.51        perf-profile.children.cycles-pp.sched_clock
      0.22 ±  4%      +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.20 ±  3%      +0.0        0.22        perf-profile.children.cycles-pp.ipv4_mtu
      0.14 ±  3%      +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.security_sock_rcv_skb
      0.06 ±  6%      +0.0        0.09        perf-profile.children.cycles-pp.policy_node
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.ip_send_check
      0.06 ±  6%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.skb_pull_rcsum
      0.17 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.compute_score
      0.07            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.neigh_hh_output
      0.06 ±  8%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.ip_local_deliver
      0.09 ±  5%      +0.0        0.12        perf-profile.children.cycles-pp.__folio_put
      0.58            +0.0        0.61        perf-profile.children.cycles-pp.sched_clock_cpu
      0.07 ±  7%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.should_failslab
      0.07 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.inet_sendmsg
      0.06            +0.0        0.10        perf-profile.children.cycles-pp.validate_xmit_xfrm
      0.09 ±  4%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.raw_v4_input
      0.08 ± 13%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.eth_type_trans
      0.09            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.udp4_hwcsum
      1.23            +0.0        1.28        perf-profile.children.cycles-pp.__check_object_size
      0.06 ± 45%      +0.0        0.11        perf-profile.children.cycles-pp.apparmor_socket_sendmsg
      0.09 ±  4%      +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.ip_skb_dst_mtu
      0.02 ±141%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.raw_local_deliver
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__raise_softirq_irqoff
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.sendto@plt
      0.10 ±  4%      +0.1        0.15        perf-profile.children.cycles-pp.nf_hook_slow
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__page_cache_release
      0.08 ±  5%      +0.1        0.14        perf-profile.children.cycles-pp.__build_skb_around
      0.18 ±  2%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.udp4_csum_init
      0.02 ± 99%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge
      0.18 ±  2%      +0.1        0.24        perf-profile.children.cycles-pp.ipv4_pktinfo_prepare
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.find_exception
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.skb_put
      0.13            +0.1        0.19        perf-profile.children.cycles-pp.xfrm_lookup_with_ifid
      0.24            +0.1        0.30        perf-profile.children.cycles-pp.ip_setup_cork
      0.25            +0.1        0.31 ±  2%  perf-profile.children.cycles-pp.__ip_local_out
      0.08 ±  5%      +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.destroy_large_folio
      0.28 ±  3%      +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.18            +0.1        0.25        perf-profile.children.cycles-pp.alloc_pages
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.inet_lookup_reuseport
      0.16            +0.1        0.23        perf-profile.children.cycles-pp.prep_compound_page
      0.44            +0.1        0.51 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.24 ±  2%      +0.1        0.32        perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.16 ±  3%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.xfrm_lookup_route
      0.19            +0.1        0.27        perf-profile.children.cycles-pp.dst_release
      0.51            +0.1        0.59        perf-profile.children.cycles-pp.send_data
      0.21 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.siphash_3u32
      0.23 ±  2%      +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.40 ±  4%      +0.1        0.48        perf-profile.children.cycles-pp.__mkroute_output
      0.16 ±  3%      +0.1        0.25        perf-profile.children.cycles-pp.__ip_finish_output
      0.10 ±  6%      +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.skb_network_protocol
      0.48 ±  3%      +0.1        0.57 ±  3%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.28 ±  4%      +0.1        0.38        perf-profile.children.cycles-pp.ip_rcv_core
      0.34 ±  4%      +0.1        0.46 ±  4%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.10 ± 10%      +0.1        0.22 ±  4%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.65 ±  5%      +0.1        0.77 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.50 ± 10%      +0.1        0.63 ±  2%  perf-profile.children.cycles-pp.aa_sk_perm
      0.22 ±  2%      +0.1        0.35        perf-profile.children.cycles-pp.free_tail_page_prepare
      0.46 ±  2%      +0.1        0.60        perf-profile.children.cycles-pp._copy_from_user
      0.44            +0.1        0.59        perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.50            +0.2        0.68 ±  2%  perf-profile.children.cycles-pp.udp4_lib_lookup2
      0.22 ±  3%      +0.2        0.41 ±  2%  perf-profile.children.cycles-pp.netif_skb_features
      0.34            +0.2        0.54        perf-profile.children.cycles-pp.ip_output
      0.66 ±  2%      +0.2        0.88        perf-profile.children.cycles-pp.move_addr_to_kernel
      0.35 ±  2%      +0.2        0.57 ±  2%  perf-profile.children.cycles-pp.sock_wfree
      0.60 ±  4%      +0.2        0.84        perf-profile.children.cycles-pp.enqueue_to_backlog
      1.14 ±  4%      +0.2        1.38        perf-profile.children.cycles-pp.get_page_from_freelist
      1.24            +0.2        1.50 ±  2%  perf-profile.children.cycles-pp.fib_table_lookup
      0.55 ± 12%      +0.3        0.81        perf-profile.children.cycles-pp.security_socket_sendmsg
      0.62            +0.3        0.88        perf-profile.children.cycles-pp.irqtime_account_irq
      0.64 ±  4%      +0.3        0.90        perf-profile.children.cycles-pp.netif_rx_internal
      0.58            +0.3        0.85        perf-profile.children.cycles-pp.kmem_cache_free
      0.71 ±  2%      +0.3        0.98        perf-profile.children.cycles-pp.ip_rcv
      0.67 ±  4%      +0.3        0.94        perf-profile.children.cycles-pp.__netif_rx
      1.42 ±  4%      +0.3        1.70        perf-profile.children.cycles-pp.__alloc_pages
      0.42 ±  2%      +0.3        0.71        perf-profile.children.cycles-pp.validate_xmit_skb
      0.51 ±  2%      +0.3        0.81        perf-profile.children.cycles-pp.kmalloc_reserve
      0.73            +0.3        1.04        perf-profile.children.cycles-pp.__udp4_lib_lookup
      1.42            +0.3        1.74 ±  2%  perf-profile.children.cycles-pp.ip_route_output_key_hash_rcu
      0.87            +0.4        1.30        perf-profile.children.cycles-pp.free_unref_page_prepare
      1.43 ±  3%      +0.5        1.89        perf-profile.children.cycles-pp.free_unref_page
      1.22 ±  5%      +0.5        1.75        perf-profile.children.cycles-pp.kmem_cache_alloc_node
      2.04            +0.5        2.58        perf-profile.children.cycles-pp.ip_route_output_flow
      1.38 ±  2%      +0.5        1.92        perf-profile.children.cycles-pp.loopback_xmit
     11.03            +0.6       11.61        perf-profile.children.cycles-pp.__local_bh_enable_ip
      1.51 ±  2%      +0.6        2.10        perf-profile.children.cycles-pp.dev_hard_start_xmit
      2.07 ±  3%      +0.6        2.68        perf-profile.children.cycles-pp.skb_page_frag_refill
     10.79            +0.6       11.41        perf-profile.children.cycles-pp.__do_softirq
     10.91            +0.6       11.54        perf-profile.children.cycles-pp.do_softirq
      2.17 ±  3%      +0.7        2.83        perf-profile.children.cycles-pp.sk_page_frag_refill
      2.34 ±  2%      +0.8        3.12        perf-profile.children.cycles-pp.skb_release_data
      1.70 ±  3%      +0.8        2.49        perf-profile.children.cycles-pp.__alloc_skb
      1.78 ±  3%      +0.9        2.63        perf-profile.children.cycles-pp.alloc_skb_with_frags
      2.25            +0.9        3.19        perf-profile.children.cycles-pp.sock_alloc_send_pskb
     96.16            +1.2       97.35        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     95.65            +1.3       96.92        perf-profile.children.cycles-pp.do_syscall_64
     13.46            +1.7       15.12        perf-profile.children.cycles-pp.__dev_queue_xmit
      1.42 ±  2%      +1.7        3.13        perf-profile.children.cycles-pp.kfree_skb_reason
     14.06            +1.7       15.81        perf-profile.children.cycles-pp.ip_finish_output2
     15.14            +2.2       17.30        perf-profile.children.cycles-pp.ip_send_skb
     15.58            +2.3       17.87        perf-profile.children.cycles-pp.udp_send_skb
     95.06 ±  3%      +4.1       99.17        perf-profile.children.cycles-pp.main
     94.98 ±  3%      +4.2       99.17        perf-profile.children.cycles-pp.__libc_start_main
      4.88 ±  7%      +5.9       10.81 ±  2%  perf-profile.children.cycles-pp.__ip_select_ident
      5.34 ±  6%      +6.1       11.41        perf-profile.children.cycles-pp.__ip_make_skb
     32.67           +12.4       45.06        perf-profile.children.cycles-pp.copyin
     33.03           +12.5       45.58        perf-profile.children.cycles-pp._copy_from_iter
     33.96           +13.0       46.92        perf-profile.children.cycles-pp.ip_generic_getfrag
     40.53           +15.5       56.05        perf-profile.children.cycles-pp.__ip_append_data
     46.26           +21.7       67.96        perf-profile.children.cycles-pp.ip_make_skb
     73.02           +23.8       96.79        perf-profile.children.cycles-pp.sendto
     65.26           +25.1       90.40        perf-profile.children.cycles-pp.udp_sendmsg
     72.89           +25.2       98.06        perf-profile.children.cycles-pp.send_omni_inner
     72.82           +25.2       98.02        perf-profile.children.cycles-pp.send_udp_stream
     66.10           +25.5       91.62        perf-profile.children.cycles-pp.sock_sendmsg
     68.21           +26.0       94.25        perf-profile.children.cycles-pp.__sys_sendto
     68.43           +26.1       94.54        perf-profile.children.cycles-pp.__x64_sys_sendto
     14.69           -13.5        1.16 ±  4%  perf-profile.self.cycles-pp.copyout
      0.55            -0.2        0.39        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.18 ± 12%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.58            -0.1        0.50        perf-profile.self.cycles-pp.__fget_light
      0.52            -0.1        0.44        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.13 ±  2%      -0.1        0.07        perf-profile.self.cycles-pp.import_single_range
      0.12 ±  3%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.43 ±  2%      -0.0        0.39 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.10 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.16 ±  3%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.35 ±  3%      -0.0        0.32        perf-profile.self.cycles-pp.do_syscall_64
      0.11 ±  4%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.12 ±  4%      -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.sockfd_lookup_light
      0.12            -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__netif_receive_skb_one_core
      0.07            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.05            +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.ipv4_pktinfo_prepare
      0.19 ±  2%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.ipv4_mtu
      0.05            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.demo_interval_tick
      0.26            +0.0        0.28        perf-profile.self.cycles-pp.check_heap_object
      0.09 ±  4%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.security_sock_rcv_skb
      0.06            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.security_socket_sendmsg
      0.19 ±  2%      +0.0        0.22 ±  3%  perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.31 ±  2%      +0.0        0.33        perf-profile.self.cycles-pp.net_rx_action
      0.16 ±  3%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.compute_score
      0.17 ±  2%      +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.ip_send_check
      0.05            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.ip_local_deliver
      0.05            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.skb_pull_rcsum
      0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.neigh_hh_output
      0.14 ±  3%      +0.0        0.18 ±  8%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.08 ±  6%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__ip_local_out
      0.08 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.udp4_hwcsum
      0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.kmalloc_reserve
      0.09            +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.alloc_pages
      0.06 ±  9%      +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.should_failslab
      0.14 ±  4%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.move_addr_to_kernel
      0.05 ±  7%      +0.0        0.09        perf-profile.self.cycles-pp.validate_xmit_xfrm
      0.27 ±  2%      +0.0        0.31 ±  2%  perf-profile.self.cycles-pp.__alloc_pages
      0.08 ±  9%      +0.0        0.12 ±  8%  perf-profile.self.cycles-pp.eth_type_trans
      0.08 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.raw_v4_input
      0.07            +0.0        0.11        perf-profile.self.cycles-pp.nf_hook_slow
      0.30 ±  2%      +0.0        0.34        perf-profile.self.cycles-pp.process_backlog
      0.07 ±  7%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__ip_finish_output
      0.12 ±  5%      +0.0        0.17 ±  6%  perf-profile.self.cycles-pp.sk_filter_trim_cap
      0.12 ±  4%      +0.0        0.16        perf-profile.self.cycles-pp.free_unref_page
      0.13 ±  3%      +0.0        0.18        perf-profile.self.cycles-pp.ip_setup_cork
      0.07 ±  6%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__build_skb_around
      0.08            +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.ip_skb_dst_mtu
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.policy_node
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.find_exception
      0.10 ±  3%      +0.1        0.15        perf-profile.self.cycles-pp.ip_rcv
      0.05 ± 45%      +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.apparmor_socket_sendmsg
      0.17 ±  2%      +0.1        0.22        perf-profile.self.cycles-pp.udp4_csum_init
      0.16 ±  3%      +0.1        0.21        perf-profile.self.cycles-pp.dst_release
      0.13 ±  3%      +0.1        0.19        perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__folio_put
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__page_cache_release
      0.08 ±  5%      +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.inet_lookup_reuseport
      0.25            +0.1        0.30        perf-profile.self.cycles-pp.ip_send_skb
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.netif_rx_internal
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.kfree_skb_reason
      0.17 ±  2%      +0.1        0.23        perf-profile.self.cycles-pp.ip_route_output_key_hash_rcu
      0.12            +0.1        0.18        perf-profile.self.cycles-pp.xfrm_lookup_with_ifid
      0.53 ±  3%      +0.1        0.59 ±  2%  perf-profile.self.cycles-pp.ip_finish_output2
      0.01 ±223%      +0.1        0.07        perf-profile.self.cycles-pp.inet_sendmsg
      0.10 ±  4%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.sk_page_frag_refill
      0.36 ±  5%      +0.1        0.42 ±  2%  perf-profile.self.cycles-pp.__mkroute_output
      0.14 ±  3%      +0.1        0.21        perf-profile.self.cycles-pp.prep_compound_page
      0.42            +0.1        0.48        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.28 ±  3%      +0.1        0.34 ±  5%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.destroy_large_folio
      0.39            +0.1        0.46 ±  2%  perf-profile.self.cycles-pp.send_data
      0.31 ±  3%      +0.1        0.38 ±  3%  perf-profile.self.cycles-pp.__check_object_size
      0.22 ±  2%      +0.1        0.29        perf-profile.self.cycles-pp.__x64_sys_sendto
      0.21 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp.get_page_from_freelist
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.__mem_cgroup_uncharge
      0.16 ±  3%      +0.1        0.23        perf-profile.self.cycles-pp.ip_make_skb
      0.26 ±  8%      +0.1        0.33        perf-profile.self.cycles-pp.rmqueue
      0.36 ±  2%      +0.1        0.44        perf-profile.self.cycles-pp.__do_softirq
      0.20 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp.ip_generic_getfrag
      0.24 ± 11%      +0.1        0.32 ±  3%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.20 ±  2%      +0.1        0.29 ±  2%  perf-profile.self.cycles-pp.udp_queue_rcv_one_skb
      0.46 ±  4%      +0.1        0.54 ±  3%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.07 ±  6%      +0.1        0.16        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.09 ±  5%      +0.1        0.18 ±  3%  perf-profile.self.cycles-pp.skb_network_protocol
      0.20 ±  2%      +0.1        0.29        perf-profile.self.cycles-pp.siphash_3u32
      0.22 ±  2%      +0.1        0.31 ±  3%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.36 ±  2%      +0.1        0.45        perf-profile.self.cycles-pp.udp_send_skb
      0.20            +0.1        0.29 ±  2%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.12 ±  4%      +0.1        0.22 ±  3%  perf-profile.self.cycles-pp.netif_skb_features
      0.23 ±  2%      +0.1        0.32        perf-profile.self.cycles-pp.sock_sendmsg
      0.19 ±  3%      +0.1        0.28        perf-profile.self.cycles-pp.__udp4_lib_rcv
      0.14 ±  2%      +0.1        0.23        perf-profile.self.cycles-pp.free_tail_page_prepare
      0.16 ±  3%      +0.1        0.26 ±  3%  perf-profile.self.cycles-pp.validate_xmit_skb
      0.27 ±  3%      +0.1        0.37        perf-profile.self.cycles-pp.ip_rcv_core
      0.35            +0.1        0.45        perf-profile.self.cycles-pp.sendto
      0.09 ± 10%      +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.34 ±  2%      +0.1        0.45        perf-profile.self.cycles-pp.__ip_make_skb
      0.34 ±  4%      +0.1        0.45 ±  4%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.50 ±  2%      +0.1        0.62        perf-profile.self.cycles-pp.skb_release_data
      0.45 ±  2%      +0.1        0.58        perf-profile.self.cycles-pp._copy_from_user
      0.28            +0.1        0.41 ±  3%  perf-profile.self.cycles-pp.udp4_lib_lookup2
      0.23            +0.1        0.36        perf-profile.self.cycles-pp.ip_route_output_flow
      0.43 ±  3%      +0.1        0.57 ±  2%  perf-profile.self.cycles-pp.__dev_queue_xmit
      0.43 ± 12%      +0.1        0.56 ±  2%  perf-profile.self.cycles-pp.aa_sk_perm
      0.24            +0.1        0.38        perf-profile.self.cycles-pp.__udp4_lib_lookup
      0.43            +0.1        0.57        perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.25            +0.1        0.39        perf-profile.self.cycles-pp.ip_output
      0.36            +0.2        0.51        perf-profile.self.cycles-pp._copy_from_iter
      0.34 ±  2%      +0.2        0.52 ±  2%  perf-profile.self.cycles-pp.__alloc_skb
      0.62            +0.2        0.79        perf-profile.self.cycles-pp.send_omni_inner
      0.34 ±  2%      +0.2        0.56 ±  2%  perf-profile.self.cycles-pp.sock_wfree
      0.50            +0.2        0.73        perf-profile.self.cycles-pp.free_unref_page_prepare
      0.47            +0.2        0.71        perf-profile.self.cycles-pp.skb_page_frag_refill
      0.57            +0.3        0.84        perf-profile.self.cycles-pp.kmem_cache_free
      0.92 ±  2%      +0.3        1.19 ±  2%  perf-profile.self.cycles-pp.fib_table_lookup
      0.95 ±  5%      +0.3        1.28 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.78            +0.3        1.12        perf-profile.self.cycles-pp.__sys_sendto
      1.16            +0.5        1.71        perf-profile.self.cycles-pp.udp_sendmsg
      2.13            +0.9        3.08        perf-profile.self.cycles-pp.__ip_append_data
      4.64 ±  7%      +5.8       10.46 ±  2%  perf-profile.self.cycles-pp.__ip_select_ident
     32.40           +12.4       44.77        perf-profile.self.cycles-pp.copyin



***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/pipe/4/x86_64-rhel-8.3/threads/50%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp2/hackbench

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  11501929 ±  3%     +68.8%   19412513        cpuidle..usage
      5.00 ± 14%      +1.5        6.49 ±  7%  mpstat.cpu.all.idle%
      0.03            +0.0        0.04        mpstat.cpu.all.soft%
     12.06            +1.3       13.33        mpstat.cpu.all.usr%
   5326554 ±  9%     +14.0%    6069773 ±  2%  vmstat.memory.cache
   8815288           -69.6%    2682569        vmstat.system.cs
   1343184           -59.7%     541194        vmstat.system.in
  61966805           +14.7%   71085124        numa-numastat.node0.local_node
  62024282           +14.7%   71118693        numa-numastat.node0.numa_hit
  62376162           +16.2%   72483066        numa-numastat.node1.local_node
  62445945           +16.2%   72585175        numa-numastat.node1.numa_hit
    457.17 ± 19%     -98.9%       5.17 ± 47%  perf-c2c.DRAM.local
      5400 ±  5%     -93.2%     369.00 ± 50%  perf-c2c.DRAM.remote
     36324 ±  3%     -99.8%      65.83 ± 37%  perf-c2c.HITM.local
    593.50 ±  9%     -90.5%      56.50 ± 55%  perf-c2c.HITM.remote
     36918 ±  3%     -99.7%     122.33 ± 43%  perf-c2c.HITM.total
  11462642 ±  3%     +69.1%   19384557        turbostat.C1
      5.94 ±  7%      +1.5        7.45 ±  6%  turbostat.C1%
      5.53 ±  7%     +21.5%       6.72 ±  7%  turbostat.CPU%c1
      2.55 ±199%   +2201.3%      58.61 ± 49%  turbostat.IPC
  91841576           -66.0%   31216183        turbostat.IRQ
     33171 ± 10%     -24.6%      25015 ±  8%  turbostat.POLL
     40.82            +3.5%      42.26        turbostat.RAMWatt
     22245 ± 20%     -50.8%      10952 ± 12%  meminfo.Active
     21589 ± 21%     -52.3%      10296 ± 13%  meminfo.Active(anon)
   5166665 ±  9%     +13.3%    5851434 ±  2%  meminfo.Cached
   3325001 ± 15%     +19.9%    3985812 ±  3%  meminfo.Committed_AS
   3014195 ± 16%     +22.3%    3687514 ±  3%  meminfo.Inactive
   3013807 ± 16%     +22.3%    3687126 ±  3%  meminfo.Inactive(anon)
    787068 ±  7%     -26.8%     576258 ±  4%  meminfo.Mapped
   2485474 ± 20%     +27.6%    3171140 ±  4%  meminfo.Shmem
      9587 ± 58%     -76.9%       2211 ± 42%  numa-meminfo.node0.Active
      9259 ± 60%     -79.7%       1883 ± 37%  numa-meminfo.node0.Active(anon)
    522086 ±138%     -98.8%       6399 ±  9%  numa-meminfo.node0.Shmem
   2285325 ± 29%     +50.7%    3443925 ±  5%  numa-meminfo.node1.Inactive
   2285131 ± 29%     +50.7%    3443731 ±  5%  numa-meminfo.node1.Inactive(anon)
    630807 ± 12%     -28.5%     450860 ±  7%  numa-meminfo.node1.Mapped
      4583 ± 12%     -21.5%       3598 ± 20%  numa-meminfo.node1.PageTables
   1953932 ± 32%     +62.1%    3166983 ±  4%  numa-meminfo.node1.Shmem
    982091           +19.1%    1169196        hackbench.throughput
    937326           +19.1%    1116209        hackbench.throughput_avg
    982091           +19.1%    1169196        hackbench.throughput_best
    892204           +17.7%    1050479        hackbench.throughput_worst
     64.72           -15.9%      54.42        hackbench.time.elapsed_time
     64.72           -15.9%      54.42        hackbench.time.elapsed_time.max
 1.258e+08           -99.9%     135322 ±  5%  hackbench.time.involuntary_context_switches
     51327           -13.6%      44325        hackbench.time.minor_page_faults
     12140            -1.4%      11968        hackbench.time.percent_of_cpu_this_job_got
      6871           -18.6%       5591        hackbench.time.system_time
    986.79            -6.5%     922.72        hackbench.time.user_time
 4.596e+08           -71.4%  1.315e+08        hackbench.time.voluntary_context_switches
      2328 ± 59%     -79.8%     470.67 ± 37%  numa-vmstat.node0.nr_active_anon
    130558 ±138%     -98.8%       1599 ±  9%  numa-vmstat.node0.nr_shmem
      2328 ± 59%     -79.8%     470.67 ± 37%  numa-vmstat.node0.nr_zone_active_anon
  62024201           +14.7%   71118659        numa-vmstat.node0.numa_hit
  61966726           +14.7%   71085090        numa-vmstat.node0.numa_local
    571427 ± 29%     +51.0%     862801 ±  5%  numa-vmstat.node1.nr_inactive_anon
    157801 ± 12%     -28.3%     113172 ±  7%  numa-vmstat.node1.nr_mapped
      1145 ± 12%     -21.3%     901.33 ± 20%  numa-vmstat.node1.nr_page_table_pages
    488630 ± 32%     +62.4%     793580 ±  4%  numa-vmstat.node1.nr_shmem
    571426 ± 29%     +51.0%     862799 ±  5%  numa-vmstat.node1.nr_zone_inactive_anon
  62445598           +16.2%   72584990        numa-vmstat.node1.numa_hit
  62375815           +16.2%   72482881        numa-vmstat.node1.numa_local
     17.47 ± 35%     -15.6        1.84 ±166%  perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     17.47 ± 35%     -15.6        1.84 ±166%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.get_signal
     15.20 ± 32%     -13.4        1.84 ±166%  perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.do_exit.do_group_exit
     15.20 ± 32%     -13.4        1.84 ±166%  perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.do_exit
      7.20 ± 78%      -6.0        1.19 ±146%  perf-profile.calltrace.cycles-pp.number.vsnprintf.seq_printf.show_interrupts.seq_read_iter
      6.20 ± 57%      -5.3        0.93 ±223%  perf-profile.calltrace.cycles-pp._free_event.perf_event_release_kernel.perf_release.__fput.task_work_run
      6.37 ± 55%      -5.0        1.32 ±157%  perf-profile.calltrace.cycles-pp.smp_call_function_single.event_function_call.perf_event_release_kernel.perf_release.__fput
      6.37 ± 55%      -5.0        1.32 ±157%  perf-profile.calltrace.cycles-pp.event_function_call.perf_event_release_kernel.perf_release.__fput.task_work_run
      6.10 ± 92%      -3.3        2.82 ±169%  perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.shmem_file_write_iter.vfs_write
     17.47 ± 35%     -15.6        1.90 ±159%  perf-profile.children.cycles-pp.task_work_run
     17.47 ± 35%     -14.6        2.88 ±111%  perf-profile.children.cycles-pp.__fput
     15.20 ± 32%     -13.3        1.85 ±165%  perf-profile.children.cycles-pp.perf_release
     15.20 ± 32%     -13.3        1.85 ±165%  perf-profile.children.cycles-pp.perf_event_release_kernel
      6.37 ± 55%      -5.0        1.32 ±157%  perf-profile.children.cycles-pp.smp_call_function_single
      6.37 ± 55%      -5.0        1.32 ±157%  perf-profile.children.cycles-pp.event_function_call
      5.12 ± 52%      -3.8        1.32 ±157%  perf-profile.self.cycles-pp.smp_call_function_single
      5525 ± 19%     -53.5%       2569 ± 13%  proc-vmstat.nr_active_anon
    137664            -4.5%     131536        proc-vmstat.nr_anon_pages
   1293208 ±  9%     +12.9%    1460660 ±  2%  proc-vmstat.nr_file_pages
    754874 ± 16%     +21.8%     919494 ±  3%  proc-vmstat.nr_inactive_anon
    197541 ±  7%     -27.3%     143595 ±  5%  proc-vmstat.nr_mapped
      1756            -6.0%       1651        proc-vmstat.nr_page_table_pages
    622910 ± 20%     +26.9%     790585 ±  4%  proc-vmstat.nr_shmem
      5525 ± 19%     -53.5%       2569 ± 13%  proc-vmstat.nr_zone_active_anon
    754874 ± 16%     +21.8%     919494 ±  3%  proc-vmstat.nr_zone_inactive_anon
    146005 ± 11%     -25.2%     109177 ± 15%  proc-vmstat.numa_hint_faults_local
 1.245e+08           +15.5%  1.437e+08        proc-vmstat.numa_hit
 1.243e+08           +15.5%  1.436e+08        proc-vmstat.numa_local
      5859 ± 39%     -63.3%       2153 ± 53%  proc-vmstat.numa_pages_migrated
    422264 ± 12%     -29.3%     298674 ±  9%  proc-vmstat.numa_pte_updates
     14681 ± 58%     -97.0%     442.00 ± 12%  proc-vmstat.pgactivate
 1.245e+08           +15.4%  1.438e+08        proc-vmstat.pgalloc_normal
    810834 ±  6%     -18.6%     659998 ±  4%  proc-vmstat.pgfault
 1.229e+08           +15.1%  1.414e+08        proc-vmstat.pgfree
      5859 ± 39%     -63.3%       2153 ± 53%  proc-vmstat.pgmigrate_success
     16433 ±  7%     -23.3%      12605        proc-vmstat.pgreuse
    601472           -16.7%     500736        proc-vmstat.unevictable_pgs_scanned
      0.37            -0.2        0.19        perf-stat.i.branch-miss-rate%
 1.878e+08           -47.7%   98129053        perf-stat.i.branch-misses
 1.594e+09            +4.1%  1.659e+09        perf-stat.i.cache-references
   9235551           -69.5%    2820801        perf-stat.i.context-switches
      1.23            -1.4%       1.21        perf-stat.i.cpi
    558021           -10.3%     500432        perf-stat.i.cpu-migrations
      1761 ±  2%      -7.1%       1637 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.01 ±  6%      -0.0        0.01 ±  5%  perf-stat.i.dTLB-load-miss-rate%
 7.519e+10            +2.3%  7.692e+10        perf-stat.i.dTLB-loads
      0.00 ±  4%      +0.0        0.00 ±  2%  perf-stat.i.dTLB-store-miss-rate%
    320069 ±  4%     +13.5%     363267        perf-stat.i.dTLB-store-misses
 4.394e+10            +2.4%  4.499e+10        perf-stat.i.dTLB-stores
 2.585e+11            +1.3%   2.62e+11        perf-stat.i.instructions
      0.82            +1.4%       0.83        perf-stat.i.ipc
    541.12           -10.3%     485.16 ±  3%  perf-stat.i.metric.K/sec
      1337            +1.9%       1363        perf-stat.i.metric.M/sec
     80.81            +6.1       86.94        perf-stat.i.node-store-miss-rate%
  22165236            +7.1%   23737654 ±  2%  perf-stat.i.node-store-misses
   5569243 ±  2%     -34.1%    3670117 ±  5%  perf-stat.i.node-stores
      0.37            -0.2        0.19        perf-stat.overall.branch-miss-rate%
      1.22            -1.5%       1.20        perf-stat.overall.cpi
      1723 ±  2%      -5.7%       1624 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±  6%      -0.0        0.01 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  4%      +0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
      0.82            +1.5%       0.83        perf-stat.overall.ipc
     79.96            +6.6       86.61        perf-stat.overall.node-store-miss-rate%
 1.846e+08           -47.9%   96187705        perf-stat.ps.branch-misses
 1.566e+09            +3.9%  1.627e+09        perf-stat.ps.cache-references
   9086394           -69.6%    2766280        perf-stat.ps.context-switches
    547994           -10.5%     490624        perf-stat.ps.cpu-migrations
 7.396e+10            +2.0%  7.546e+10        perf-stat.ps.dTLB-loads
    313926 ±  4%     +13.2%     355487        perf-stat.ps.dTLB-store-misses
 4.322e+10            +2.1%  4.413e+10        perf-stat.ps.dTLB-stores
 2.543e+11            +1.1%   2.57e+11        perf-stat.ps.instructions
   5454114 ±  2%     -34.0%    3600130 ±  5%  perf-stat.ps.node-stores
 1.659e+13           -14.4%  1.421e+13        perf-stat.total.instructions
   3539626           -99.9%       2518 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.avg
   5096880 ±  6%     -99.4%      30625 ± 21%  sched_debug.cfs_rq:/.avg_vruntime.max
   3382807          -100.0%      77.16 ± 29%  sched_debug.cfs_rq:/.avg_vruntime.min
    169658 ± 13%     -97.5%       4318 ± 18%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      6.56 ±  2%     -98.2%       0.12 ± 19%  sched_debug.cfs_rq:/.h_nr_running.avg
     14.83 ±  9%     -84.3%       2.33 ± 31%  sched_debug.cfs_rq:/.h_nr_running.max
      3.40 ±  4%     -88.9%       0.38 ± 15%  sched_debug.cfs_rq:/.h_nr_running.stddev
    110634 ±177%   +1184.3%    1420878 ± 54%  sched_debug.cfs_rq:/.load.max
     11881 ±140%   +1102.8%     142905 ± 52%  sched_debug.cfs_rq:/.load.stddev
    515.16 ± 66%    +310.8%       2116 ± 57%  sched_debug.cfs_rq:/.load_avg.avg
     30912 ± 62%    +182.5%      87339 ±  2%  sched_debug.cfs_rq:/.load_avg.max
      1.08 ± 31%    -100.0%       0.00        sched_debug.cfs_rq:/.load_avg.min
      3468 ± 65%    +235.4%      11631 ± 32%  sched_debug.cfs_rq:/.load_avg.stddev
   3539626           -99.9%       2519 ± 10%  sched_debug.cfs_rq:/.min_vruntime.avg
   5096880 ±  6%     -99.4%      30625 ± 21%  sched_debug.cfs_rq:/.min_vruntime.max
   3382807          -100.0%      77.16 ± 29%  sched_debug.cfs_rq:/.min_vruntime.min
    169658 ± 13%     -97.5%       4318 ± 18%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.55           -77.9%       0.12 ± 19%  sched_debug.cfs_rq:/.nr_running.avg
      0.20 ± 20%     +86.0%       0.38 ± 15%  sched_debug.cfs_rq:/.nr_running.stddev
    512.00         +5811.2%      30265 ±136%  sched_debug.cfs_rq:/.removed.load_avg.max
    262.50           +98.2%     520.33        sched_debug.cfs_rq:/.removed.runnable_avg.max
    262.50           +98.2%     520.33        sched_debug.cfs_rq:/.removed.util_avg.max
      6520 ±  2%     -96.1%     255.07 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
     12582 ±  5%     -90.3%       1220 ± 16%  sched_debug.cfs_rq:/.runnable_avg.max
    956.83 ± 51%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
      1986 ±  3%     -84.6%     306.55 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    611.45           -59.0%     250.81 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
    161.75 ± 22%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
    318.54 ±  2%     -92.0%      25.53 ± 26%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1178 ±  5%     -29.7%     828.00        sched_debug.cfs_rq:/.util_est_enqueued.max
    215.82 ±  5%     -47.1%     114.24 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    480833 ±  2%     +76.4%     848127        sched_debug.cpu.avg_idle.avg
    801726 ±  7%     +36.7%    1096160 ± 12%  sched_debug.cpu.avg_idle.max
    157976 ±  4%     +41.5%     223472 ±  4%  sched_debug.cpu.avg_idle.stddev
     83176 ±  2%     -34.4%      54588 ±  4%  sched_debug.cpu.clock.avg
     83225 ±  2%     -34.4%      54594 ±  4%  sched_debug.cpu.clock.max
     83121 ±  2%     -34.3%      54578 ±  4%  sched_debug.cpu.clock.min
     28.92 ± 25%     -88.0%       3.48 ±  3%  sched_debug.cpu.clock.stddev
     82606 ±  2%     -34.1%      54459 ±  4%  sched_debug.cpu.clock_task.avg
     82808 ±  2%     -34.1%      54585 ±  4%  sched_debug.cpu.clock_task.max
     74892 ±  3%     -37.6%      46731 ±  5%  sched_debug.cpu.clock_task.min
      7846           -94.9%     403.47 ± 11%  sched_debug.cpu.curr->pid.avg
     10604           -60.1%       4227        sched_debug.cpu.curr->pid.max
      0.00 ± 23%     -44.8%       0.00 ± 23%  sched_debug.cpu.next_balance.stddev
      6.54 ±  2%     -98.1%       0.12 ± 17%  sched_debug.cpu.nr_running.avg
     14.83 ±  9%     -84.3%       2.33 ± 31%  sched_debug.cpu.nr_running.max
      3.39 ±  4%     -88.8%       0.38 ± 14%  sched_debug.cpu.nr_running.stddev
   2125675           -99.9%       1749        sched_debug.cpu.nr_switches.avg
   2505734 ±  5%     -98.5%      36714 ± 30%  sched_debug.cpu.nr_switches.max
   1744096 ±  3%    -100.0%     134.33 ±  6%  sched_debug.cpu.nr_switches.min
     99374 ± 12%     -95.8%       4130 ± 14%  sched_debug.cpu.nr_switches.stddev
    142.50 ± 21%     -62.9%      52.83 ± 18%  sched_debug.cpu.nr_uninterruptible.max
   -141.58           -90.7%     -13.17        sched_debug.cpu.nr_uninterruptible.min
     42.75 ± 11%     -85.3%       6.27 ±  7%  sched_debug.cpu.nr_uninterruptible.stddev
     83123 ±  2%     -34.3%      54584 ±  4%  sched_debug.cpu_clk
     81893 ±  2%     -34.8%      53354 ±  4%  sched_debug.ktime
     84041 ±  2%     -34.0%      55457 ±  4%  sched_debug.sched_clk



***************************************************************************************************
lkp-skl-d08: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1SSD/xfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/dnotify/stress-ng/60s

commit: 
  7ad0354d18 ("sched/headers: Remove duplicated includes in kernel/sched/sched.h")
  8afa2eec7f ("sched/fair: Do not wakeup-preempt same-prio SCHED_OTHER tasks")

7ad0354d18ae05e9 8afa2eec7fb5de648561dba3b19 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   4116086           +22.7%    5049549        cpuidle..usage
      7.17            -4.6%       6.84        iostat.cpu.system
      1.51           -13.1%       1.31        iostat.cpu.user
      0.09            +0.0        0.10        mpstat.cpu.all.soft%
      1.51            -0.2        1.31        mpstat.cpu.all.usr%
      6999 ±  2%     +90.6%      13341        vmstat.io.bo
     76876           +75.1%     134583        vmstat.system.cs
     56176            +6.1%      59603        vmstat.system.in
    140962 ±  2%     +89.6%     267323        meminfo.Active
    140740 ±  2%     +89.8%     267104        meminfo.Active(anon)
    669736           +20.2%     805324        meminfo.Committed_AS
    154066 ±  2%     +88.3%     290124        meminfo.Shmem
    589958 ±  2%    +102.9%    1197072        turbostat.C1
      3.20 ±  2%      +2.4        5.54        turbostat.C1%
   1208014           +15.2%    1391274        turbostat.C1E
      8.55            +2.7       11.27        turbostat.C1E%
    394730 ±  2%     +61.2%     636419        turbostat.POLL
      0.10 ±  4%      +0.1        0.17        turbostat.POLL%
    914019           -15.7%     770790        stress-ng.dnotify.ops
     15233           -15.7%      12846        stress-ng.dnotify.ops_per_sec
  36560733           -15.7%   30831585        stress-ng.time.file_system_outputs
    158471           -51.9%      76226        stress-ng.time.involuntary_context_switches
    233.67            -9.7%     211.00        stress-ng.time.percent_of_cpu_this_job_got
    122.05            -9.2%     110.86        stress-ng.time.system_time
    437727 ±  2%    +274.8%    1640596        stress-ng.time.voluntary_context_switches
     35185 ±  2%     +89.8%      66776        proc-vmstat.nr_active_anon
   4569227           -15.7%    3852767        proc-vmstat.nr_dirtied
    736600            +4.6%     770633        proc-vmstat.nr_file_pages
     79569            +2.5%      81525        proc-vmstat.nr_inactive_anon
      9245            -1.0%       9154        proc-vmstat.nr_kernel_stack
     12204            +4.0%      12688        proc-vmstat.nr_mapped
     38518 ±  2%     +88.3%      72534        proc-vmstat.nr_shmem
     35185 ±  2%     +89.8%      66776        proc-vmstat.nr_zone_active_anon
     79569            +2.5%      81525        proc-vmstat.nr_zone_inactive_anon
   5126131           -12.2%    4501912        proc-vmstat.numa_hit
   5128956           -12.3%    4499112        proc-vmstat.numa_local
     52552 ±  2%     +86.8%      98141        proc-vmstat.pgactivate
   5244883           -12.4%    4596666        proc-vmstat.pgalloc_normal
   5174307           -13.4%    4478515        proc-vmstat.pgfree
    456141 ±  2%     +91.6%     873837        proc-vmstat.pgpgout
     11233 ±  2%     -13.7%       9699 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.avg
      2572 ± 12%     -23.1%       1977 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.min
     15056 ±  6%     -19.2%      12165 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      1.58 ± 21%     +47.4%       2.33 ± 15%  sched_debug.cfs_rq:/.h_nr_running.max
      0.48 ±  6%     +23.2%       0.59 ± 11%  sched_debug.cfs_rq:/.h_nr_running.stddev
     11233 ±  2%     -13.7%       9700 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
      2572 ± 12%     -23.1%       1977 ±  9%  sched_debug.cfs_rq:/.min_vruntime.min
     15056 ±  6%     -19.2%      12165 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1.58 ± 21%     +47.4%       2.33 ± 15%  sched_debug.cfs_rq:/.nr_running.max
      0.48 ±  6%     +22.4%       0.59 ± 11%  sched_debug.cfs_rq:/.nr_running.stddev
      0.49 ±  6%     +20.8%       0.59 ± 11%  sched_debug.cpu.nr_running.stddev
     73121           +67.4%     122381        sched_debug.cpu.nr_switches.avg
    157331 ±  2%    +197.2%     467519 ±  3%  sched_debug.cpu.nr_switches.max
     25739 ±  3%    +251.8%      90541        sched_debug.cpu.nr_switches.stddev
      1152          +202.9%       3490 ±  6%  sched_debug.cpu.nr_uninterruptible.max
   -280.33          +109.0%    -585.92        sched_debug.cpu.nr_uninterruptible.min
    318.24 ±  2%    +165.1%     843.69 ±  3%  sched_debug.cpu.nr_uninterruptible.stddev
      0.13 ±  2%     +16.1%       0.15        perf-stat.i.MPKI
 1.957e+09            -3.0%  1.898e+09        perf-stat.i.branch-instructions
      1.48            +0.1        1.61        perf-stat.i.branch-miss-rate%
  30093641            +4.8%   31541589        perf-stat.i.branch-misses
   1543470           +17.1%    1807270        perf-stat.i.cache-misses
  65963562 ±  3%      +6.3%   70112140        perf-stat.i.cache-references
     79898           +76.0%     140612        perf-stat.i.context-switches
      1.23            +2.3%       1.25        perf-stat.i.cpi
 1.291e+10            -1.2%  1.276e+10        perf-stat.i.cpu-cycles
      1469           +69.6%       2492        perf-stat.i.cpu-migrations
     14595 ±  2%      -7.9%      13446        perf-stat.i.cycles-between-cache-misses
      0.04            +0.0        0.05        perf-stat.i.dTLB-load-miss-rate%
 2.809e+09            -4.2%   2.69e+09        perf-stat.i.dTLB-loads
      0.00 ±  6%      +0.0        0.00 ±  7%  perf-stat.i.dTLB-store-miss-rate%
     53064 ±  6%     +28.2%      68019 ±  7%  perf-stat.i.dTLB-store-misses
 1.735e+09            -5.4%  1.642e+09        perf-stat.i.dTLB-stores
     19.72 ±  4%      -1.9       17.79 ±  5%  perf-stat.i.iTLB-load-miss-rate%
   4467778 ±  7%     +23.8%    5532316 ±  3%  perf-stat.i.iTLB-loads
 1.056e+10            -3.2%  1.022e+10        perf-stat.i.instructions
      0.82            -2.2%       0.81        perf-stat.i.ipc
      0.36            -1.2%       0.35        perf-stat.i.metric.GHz
    165.56 ±  5%     +19.3%     197.48 ±  3%  perf-stat.i.metric.K/sec
    182.39            -4.1%     174.97        perf-stat.i.metric.M/sec
    174277 ±  2%     +19.7%     208636 ±  2%  perf-stat.i.node-loads
    226393           +19.8%     271319 ±  2%  perf-stat.i.node-stores
      0.15           +21.1%       0.18        perf-stat.overall.MPKI
      1.54            +0.1        1.66        perf-stat.overall.branch-miss-rate%
      2.34 ±  2%      +0.2        2.58        perf-stat.overall.cache-miss-rate%
      1.22            +2.1%       1.25        perf-stat.overall.cpi
      8365           -15.6%       7056        perf-stat.overall.cycles-between-cache-misses
      0.04            +0.0        0.05        perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  6%      +0.0        0.00 ±  7%  perf-stat.overall.dTLB-store-miss-rate%
     19.58 ±  4%      -2.0       17.55 ±  5%  perf-stat.overall.iTLB-load-miss-rate%
      9759 ±  4%     -10.6%       8728 ±  7%  perf-stat.overall.instructions-per-iTLB-miss
      0.82            -2.1%       0.80        perf-stat.overall.ipc
 1.926e+09            -3.0%  1.868e+09        perf-stat.ps.branch-instructions
  29616558            +4.8%   31047367        perf-stat.ps.branch-misses
   1519046           +17.2%    1779751        perf-stat.ps.cache-misses
  64920277 ±  3%      +6.3%   69002916        perf-stat.ps.cache-references
     78634           +76.0%     138383        perf-stat.ps.context-switches
  1.27e+10            -1.2%  1.256e+10        perf-stat.ps.cpu-cycles
      1446           +69.6%       2452        perf-stat.ps.cpu-migrations
 2.765e+09            -4.2%  2.648e+09        perf-stat.ps.dTLB-loads
     52223 ±  6%     +28.2%      66941 ±  7%  perf-stat.ps.dTLB-store-misses
 1.708e+09            -5.4%  1.616e+09        perf-stat.ps.dTLB-stores
   4397091 ±  7%     +23.8%    5444632 ±  3%  perf-stat.ps.iTLB-loads
  1.04e+10            -3.2%  1.006e+10        perf-stat.ps.instructions
    171521 ±  2%     +19.8%     205431 ±  2%  perf-stat.ps.node-loads
    222827           +19.9%     267072 ±  2%  perf-stat.ps.node-stores
 6.572e+11            -3.2%  6.361e+11        perf-stat.total.instructions
      0.00 ±223%    +900.0%       0.00 ± 44%  perf-sched.sch_delay.avg.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      0.00 ±223%   +1100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_create
      0.71 ± 42%    +262.2%       2.57 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_truncate
      0.00 ±223%   +1000.0%       0.00 ± 37%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_remove
      0.00 ±141%    +450.0%       0.00 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_rename
      0.00 ±223%    +900.0%       0.00 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlink
      0.00 ±223%    +900.0%       0.00 ± 44%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.xfs_ilock.xfs_free_eofblocks.xfs_release
      0.00 ±141%    +750.0%       0.00 ± 62%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.xfs_ilock.xfs_iget_cache_hit.xfs_iget
      0.00 ±223%    +900.0%       0.00 ± 44%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.00 ±223%   +1100.0%       0.00 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fsnotify_parent.notify_change.chmod_common
      0.00 ±223%   +1400.0%       0.00 ± 50%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.vfs_rename.do_renameat2.__x64_sys_rename
      0.00 ±223%    +800.0%       0.00 ± 33%  perf-sched.sch_delay.avg.ms.__cond_resched.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
      0.00 ±223%   +1000.0%       0.00 ± 37%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor.xfs_dialloc_ag
      0.00 ± 33%   +1736.8%       0.06 ±164%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor.xfs_difree_finobt
      0.17 ± 71%    +762.5%       1.44 ± 52%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_inactive_ifree.xfs_inactive
      0.33 ± 42%    +319.5%       1.37 ± 21%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_inactive_truncate.xfs_inactive
      0.00 ±141%    +500.0%       0.00 ± 70%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_trans_alloc_ichange.xfs_setattr_nonsize
      0.00 ±141%    +650.0%       0.00 ± 50%  perf-sched.sch_delay.avg.ms.__cond_resched.mnt_want_write.do_renameat2.__x64_sys_rename.do_syscall_64
      0.00 ±152%    +466.7%       0.00 ± 51%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.dnotify_flush
      0.39 ±  4%     +28.8%       0.50 ±  3%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xlog_cil_commit
      0.03 ±  4%     -36.2%       0.02        perf-sched.sch_delay.avg.ms.schedule_timeout.___down_common.__down.down
      0.00 ± 82%    +175.0%       0.00 ± 12%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.00          +116.7%       0.00 ± 17%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      0.03 ± 10%    +128.2%       0.07 ±  4%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 23%     +91.7%       0.01 ± 17%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.iomap_write_begin
      0.01 ± 31%    +931.4%       0.09 ±150%  perf-sched.sch_delay.max.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 35%    +142.2%       0.02 ± 30%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_dir_createname
      0.00 ±145%    +610.0%       0.01 ± 61%  perf-sched.sch_delay.max.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      0.00 ±104%    +250.0%       0.01 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.dentry_kill.dput.do_renameat2.__x64_sys_rename
      0.00 ± 72%    +428.6%       0.01 ± 26%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.xfs_can_free_eofblocks.xfs_release.__fput
      0.01 ± 22%    +244.6%       0.03 ± 21%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_create
      0.02 ± 68%     -75.7%       0.00 ± 52%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree
      0.01 ± 66%    +135.6%       0.03 ± 42%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_remove
      0.00 ± 21%   +1092.6%       0.05 ±144%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.xfs_ilock.xfs_create.xfs_generic_create
      0.01 ± 67%   +1102.9%       0.14 ±104%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.xfs_ilock.xfs_iget_cache_hit.xfs_iget
      0.00 ± 65%    +467.9%       0.03 ± 62%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.xfs_ilock.xfs_lock_two_inodes.xfs_trans_alloc_dir
      0.01 ± 52%    +129.4%       0.01 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.dput.__fsnotify_parent.notify_change.chmod_common
      0.01 ± 24%    +198.0%       0.03 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.01 ± 27%    +362.5%       0.04 ± 64%  perf-sched.sch_delay.max.ms.__cond_resched.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
      0.01 ± 24%    +143.6%       0.02 ± 27%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      0.01 ± 26%    +643.4%       0.07 ±117%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.01 ± 23%    +639.5%       0.05 ± 65%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor.xfs_dialloc_ag
      0.01        +11161.1%       0.68 ±213%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor.xfs_difree_finobt
      0.01 ± 43%    +250.0%       0.03 ± 54%  perf-sched.sch_delay.max.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.01 ± 41%    +245.5%       0.02 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.dnotify_flush.filp_flush.__x64_sys_close
      0.00 ±145%    +480.0%       0.00 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
      0.63 ±  5%     -90.8%       0.06 ±200%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 23%   +1292.9%       0.10 ±140%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.07 ± 34%     -59.8%       0.03 ± 28%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.01 ±110%    +324.4%       0.03 ± 21%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.01 ± 19%    +624.3%       0.08 ±150%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      3.96 ±  2%     -41.6%       2.32        perf-sched.total_wait_and_delay.average.ms
    207803           +79.8%     373538        perf-sched.total_wait_and_delay.count.ms
      3.94 ±  2%     -41.8%       2.29        perf-sched.total_wait_time.average.ms
      0.13          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
      1.12 ±223%   +1462.1%      17.43 ± 74%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_inactive_ifree.xfs_inactive
    149.63 ±  2%     -47.0%      79.32 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     13.77 ± 13%     -21.5%      10.81 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xlog_cil_commit
      1.05 ±  5%     -56.6%       0.46        perf-sched.wait_and_delay.avg.ms.schedule_timeout.___down_common.__down.down
     60.07 ±  3%     -40.0%      36.03 ±  4%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     13.00           +19.3%      15.51 ±  2%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      7293 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
     59.17 ± 28%     -98.0%       1.17 ±125%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    100.33 ±  2%     +89.0%     189.67        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    807.17 ±  3%     +72.0%       1388 ±  2%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xlog_cil_commit
     85849 ±  4%    +198.3%     256077        perf-sched.wait_and_delay.count.schedule_timeout.___down_common.__down.down
      5487 ±  2%     +70.7%       9364 ±  3%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     19743           -13.5%      17076        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      6.26 ± 54%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
    714.57 ± 59%     -80.5%     139.66 ±207%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.16 ±223%    +534.8%       1.05 ± 49%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_bulk.xfs_buf_alloc_pages.xfs_buf_find_insert.constprop
      0.05 ± 21%     -33.1%       0.04 ± 34%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.kmem_alloc.xfs_dir_createname
      0.05 ± 47%     -76.5%       0.01 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.begin_current_label_crit_section.apparmor_path_rename.part.0
      0.26 ± 32%     -97.0%       0.01 ± 34%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree
      0.93 ± 31%    +202.3%       2.81 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_truncate
      0.07 ± 47%     -53.5%       0.03 ± 41%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.xfs_ilock.xfs_create.xfs_generic_create
      0.05 ±  5%     +83.2%       0.09 ± 28%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.13           -60.8%       0.05 ± 22%  perf-sched.wait_time.avg.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
      1.86 ±117%    +759.0%      15.99 ± 79%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_inactive_ifree.xfs_inactive
      0.09 ± 86%     -68.7%       0.03 ± 42%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_trans_alloc_icreate.xfs_create
      0.03 ± 33%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
    149.62 ±  2%     -47.0%      79.32 ±  4%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     13.38 ± 13%     -22.9%      10.31 ±  4%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xlog_cil_commit
      1.02 ±  5%     -57.3%       0.43        perf-sched.wait_time.avg.ms.schedule_timeout.___down_common.__down.down
      0.07 ± 15%    +297.2%       0.26 ±  4%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
     60.04 ±  3%     -40.1%      35.96 ±  4%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     12.96           +19.3%      15.46 ±  2%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.96 ± 44%    +229.1%       3.15 ± 45%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.iomap_write_begin
      0.16 ±223%    +611.0%       1.17 ± 58%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_bulk.xfs_buf_alloc_pages.xfs_buf_find_insert.constprop
      0.13 ± 29%     -85.0%       0.02 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.begin_current_label_crit_section.apparmor_path_rename.part.0
      1.51 ± 54%     -99.2%       0.01 ± 54%  perf-sched.wait_time.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree
      0.77 ± 48%    +202.7%       2.33 ± 53%  perf-sched.wait_time.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_remove
      0.32 ± 21%    +434.9%       1.73 ± 65%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlink
      0.26 ± 44%    +653.2%       1.92 ± 80%  perf-sched.wait_time.max.ms.__cond_resched.down_write.xfs_ilock.xfs_free_eofblocks.xfs_release
      0.80 ± 53%    +377.0%       3.80 ±109%  perf-sched.wait_time.max.ms.__cond_resched.down_write.xfs_ilock.xfs_iget_cache_hit.xfs_iget
      0.52 ± 24%    +708.7%       4.24 ± 67%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      1.43 ± 78%    +158.0%       3.68 ± 57%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.61 ± 43%    +210.5%       1.90 ± 49%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      0.03 ±167%   +3200.6%       0.95 ±102%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.xfs_allocbt_init_common.xfs_allocbt_init_cursor.xfs_alloc_ag_vextent_exact
      0.67 ± 59%    +790.2%       5.97 ±103%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.xfs_inobt_init_common.xfs_inobt_init_cursor.xfs_dialloc_ag
      0.69 ± 86%    +234.1%       2.31 ± 80%  perf-sched.wait_time.max.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.58 ±  5%    +292.4%       2.27 ± 55%  perf-sched.wait_time.max.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
      0.05 ± 41%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
    714.27 ± 59%     -80.4%     139.65 ±207%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.69 ± 58%    +265.0%       2.52 ± 46%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.xlog_cil_push_work
      0.74 ±123%    +639.9%       5.46 ± 45%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      1.97 ± 48%    +501.3%      11.82 ± 22%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      4.90 ± 12%     +42.2%       6.96 ± 13%  perf-sched.wait_time.max.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
     20.19            -1.4       18.83 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle_ibrs.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     15.82            -1.1       14.68        perf-profile.calltrace.cycles-pp.open64
     14.49            -1.0       13.47        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     14.05            -1.0       13.08        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      7.65            -0.9        6.74        perf-profile.calltrace.cycles-pp.__close
     13.25            -0.9       12.39        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     13.17            -0.8       12.33        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      6.30            -0.8        5.52        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     12.29            -0.7       11.55 ±  2%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.15            -0.7       11.43 ±  2%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      5.83 ±  2%      -0.7        5.13        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      6.06 ±  2%      -0.6        5.42        perf-profile.calltrace.cycles-pp.write
      5.02 ±  2%      -0.6        4.41        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      5.45 ±  3%      -0.5        4.91 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      5.26 ±  2%      -0.5        4.74 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     13.67            -0.5       13.20        perf-profile.calltrace.cycles-pp.unlink
      3.37 ±  4%      -0.5        2.92 ±  2%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      4.44 ±  3%      -0.4        4.02 ±  2%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      4.50 ±  3%      -0.4        4.08 ±  2%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      9.12            -0.4        8.75        perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      3.09 ±  2%      -0.4        2.73 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.80 ±  3%      -0.4        3.44 ±  2%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.51 ±  4%      -0.3        2.18 ±  5%  perf-profile.calltrace.cycles-pp.evict.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.41 ±  3%      -0.3        3.09 ±  3%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
      2.56 ±  4%      -0.3        2.25 ±  2%  perf-profile.calltrace.cycles-pp.xfs_release.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.50 ±  3%      -0.3        2.20 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.92 ±  3%      -0.3        1.65 ±  2%  perf-profile.calltrace.cycles-pp.rename
      1.81 ±  3%      -0.3        1.56 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.rename
      1.97 ±  3%      -0.3        1.72 ±  5%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlink.do_syscall_64
      1.78 ±  3%      -0.3        1.52 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.rename
      2.10 ±  5%      -0.2        1.86 ±  3%  perf-profile.calltrace.cycles-pp.xfs_free_eofblocks.xfs_release.__fput.__x64_sys_close.do_syscall_64
      2.41 ±  2%      -0.2        2.18 ±  3%  perf-profile.calltrace.cycles-pp.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write
      1.52 ±  4%      -0.2        1.31 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_rename.do_syscall_64.entry_SYSCALL_64_after_hwframe.rename
      1.44 ±  4%      -0.2        1.24 ±  4%  perf-profile.calltrace.cycles-pp.do_renameat2.__x64_sys_rename.do_syscall_64.entry_SYSCALL_64_after_hwframe.rename
      3.75            -0.2        3.56 ±  3%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_create.xfs_generic_create.lookup_open.open_last_lookups
      2.72 ±  2%      -0.2        2.53 ±  2%  perf-profile.calltrace.cycles-pp.xfs_inactive_truncate.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread
      0.62 ±  3%      -0.2        0.44 ± 44%  perf-profile.calltrace.cycles-pp.notify_change.chmod_common.__x64_sys_chmod.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.64 ±  5%      -0.2        0.47 ± 44%  perf-profile.calltrace.cycles-pp.__filename_parentat.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.05 ±  4%      -0.2        0.88 ±  6%  perf-profile.calltrace.cycles-pp.vfs_rename.do_renameat2.__x64_sys_rename.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.46 ±  4%      -0.2        1.30 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.30 ±  2%      -0.2        2.14 ±  3%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_create.xfs_generic_create.lookup_open
      1.04 ±  4%      -0.2        0.89 ±  6%  perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.evict.do_unlinkat.__x64_sys_unlink
      1.34 ±  4%      -0.1        1.20 ±  4%  perf-profile.calltrace.cycles-pp.do_fcntl.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.99 ±  2%      -0.1        0.85 ±  4%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.30 ±  2%      -0.1        1.17 ±  5%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.21 ±  2%      -0.1        1.08 ±  3%  perf-profile.calltrace.cycles-pp.chmod
      1.11 ±  2%      -0.1        0.98 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.chmod
      1.08 ±  2%      -0.1        0.95 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.chmod
      1.38 ±  3%      -0.1        1.26 ±  4%  perf-profile.calltrace.cycles-pp.dnotify_handler
      1.29 ±  4%      -0.1        1.16 ±  4%  perf-profile.calltrace.cycles-pp.fcntl_dirnotify.do_fcntl.__x64_sys_fcntl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.09 ±  4%      -0.1        0.96 ±  6%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit.xfs_create.xfs_generic_create
      0.96 ±  3%      -0.1        0.84 ±  3%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.70 ±  5%      -0.1        0.58 ±  7%  perf-profile.calltrace.cycles-pp.xfs_vn_rename.vfs_rename.do_renameat2.__x64_sys_rename.do_syscall_64
      0.68 ±  4%      -0.1        0.56 ±  7%  perf-profile.calltrace.cycles-pp.xfs_rename.xfs_vn_rename.vfs_rename.do_renameat2.__x64_sys_rename
      0.82 ±  2%      -0.1        0.70        perf-profile.calltrace.cycles-pp.__x64_sys_chmod.do_syscall_64.entry_SYSCALL_64_after_hwframe.chmod
      2.00 ±  5%      -0.1        1.88        perf-profile.calltrace.cycles-pp.xfs_dialloc_ag.xfs_dialloc.xfs_create.xfs_generic_create.lookup_open
      1.32 ±  4%      -0.1        1.20 ±  3%  perf-profile.calltrace.cycles-pp.filp_flush.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.76 ±  3%      -0.1        0.66 ±  7%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.open64
      1.05 ±  5%      -0.1        0.96 ±  6%  perf-profile.calltrace.cycles-pp.xfs_init_new_inode.xfs_create.xfs_generic_create.lookup_open.open_last_lookups
      0.80 ±  4%      -0.1        0.70 ±  5%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__close
      0.70 ±  5%      -0.1        0.61 ±  7%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
      0.66 ±  3%      -0.1        0.57 ±  2%  perf-profile.calltrace.cycles-pp.chmod_common.__x64_sys_chmod.do_syscall_64.entry_SYSCALL_64_after_hwframe.chmod
      0.89 ±  6%      -0.1        0.80 ±  4%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_free_eofblocks.xfs_release.__fput.__x64_sys_close
      1.39 ±  2%      -0.1        1.30 ±  3%  perf-profile.calltrace.cycles-pp.xfs_itruncate_extents_flags.xfs_inactive_truncate.xfs_inactive.xfs_inodegc_worker.process_one_work
      0.74 ±  6%      -0.1        0.65 ±  5%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.72 ±  3%      -0.1        0.64 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.95 ±  7%      -0.1        0.86 ±  3%  perf-profile.calltrace.cycles-pp.iomap_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write
      0.84 ±  5%      -0.1        0.77 ±  5%  perf-profile.calltrace.cycles-pp.xfs_trans_alloc_dir.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat
      0.98            -0.1        0.92 ±  2%  perf-profile.calltrace.cycles-pp.xfs_defer_finish.xfs_itruncate_extents_flags.xfs_inactive_truncate.xfs_inactive.xfs_inodegc_worker
      0.80 ±  4%      -0.1        0.74 ±  3%  perf-profile.calltrace.cycles-pp.read
      0.95            -0.1        0.89 ±  2%  perf-profile.calltrace.cycles-pp.xfs_defer_trans_roll.xfs_defer_finish.xfs_itruncate_extents_flags.xfs_inactive_truncate.xfs_inactive
      0.64 ±  4%      -0.0        0.59 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      1.29 ±  3%      +0.1        1.44 ±  4%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit.xfs_remove.xfs_vn_unlink
      0.60 ±  9%      +0.2        0.76 ±  6%  perf-profile.calltrace.cycles-pp.xlog_cil_alloc_shadow_bufs.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree.xfs_inactive
      1.12 ±  4%      +0.2        1.31 ±  3%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_format_items.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit.xfs_remove
      0.64 ±  3%      +0.2        0.83 ±  6%  perf-profile.calltrace.cycles-pp.xfs_trans_run_precommits.__xfs_trans_commit.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker
      2.47 ±  3%      +0.2        2.71 ±  2%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_remove.xfs_vn_unlink.vfs_unlink
      0.55 ±  5%      +0.3        0.84 ±  4%  perf-profile.calltrace.cycles-pp.xfs_read_agi.xfs_iunlink.xfs_remove.xfs_vn_unlink.vfs_unlink
      3.47 ±  2%      +0.3        3.78 ±  2%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat
      0.27 ±100%      +0.3        0.58 ±  7%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      0.77 ±  6%      +0.3        1.09 ±  3%  perf-profile.calltrace.cycles-pp.xfs_iunlink.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat
      0.27 ±100%      +0.3        0.60 ±  7%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      6.70            +0.4        7.07        perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.63 ±  2%      +0.4        2.02 ±  3%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree.xfs_inactive
      1.49 ±  2%      +0.4        1.88 ±  3%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_format_items.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree
      5.98            +0.5        6.45        perf-profile.calltrace.cycles-pp.xfs_remove.xfs_vn_unlink.vfs_unlink.do_unlinkat.__x64_sys_unlink
      6.03            +0.5        6.50        perf-profile.calltrace.cycles-pp.xfs_vn_unlink.vfs_unlink.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.09 ±223%      +0.5        0.60 ±  8%  perf-profile.calltrace.cycles-pp.xfs_buf_item_size.xlog_cil_alloc_shadow_bufs.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree
      0.95 ±  4%      +0.5        1.48 ±  2%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.27 ±100%      +0.5        0.80 ±  4%  perf-profile.calltrace.cycles-pp.xfs_trans_read_buf_map.xfs_read_agi.xfs_iunlink.xfs_remove.xfs_vn_unlink
      1.91 ± 12%      +0.6        2.49 ±  3%  perf-profile.calltrace.cycles-pp.xfs_buf_item_format.xlog_cil_insert_format_items.xlog_cil_insert_items.xlog_cil_commit.__xfs_trans_commit
      2.91 ±  4%      +0.6        3.51 ±  2%  perf-profile.calltrace.cycles-pp.xfs_difree.xfs_ifree.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker
      0.64 ±  4%      +0.6        1.24 ±  2%  perf-profile.calltrace.cycles-pp.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agi.xfs_ialloc_read_agi.xfs_difree
      0.00            +0.6        0.61 ±  8%  perf-profile.calltrace.cycles-pp.xfs_trans_read_buf_map.xfs_read_agi.xfs_ialloc_read_agi.xfs_dialloc.xfs_create
      0.75 ±  3%      +0.6        1.38 ±  4%  perf-profile.calltrace.cycles-pp.xfs_trans_read_buf_map.xfs_read_agi.xfs_ialloc_read_agi.xfs_difree.xfs_ifree
      0.79 ±  2%      +0.6        1.42 ±  3%  perf-profile.calltrace.cycles-pp.xfs_read_agi.xfs_ialloc_read_agi.xfs_difree.xfs_ifree.xfs_inactive_ifree
      1.63 ±  3%      +0.6        2.26 ±  3%  perf-profile.calltrace.cycles-pp.xfs_buf_item_format_segment.xfs_buf_item_format.xlog_cil_insert_format_items.xlog_cil_insert_items.xlog_cil_commit
      0.81 ±  3%      +0.6        1.46 ±  3%  perf-profile.calltrace.cycles-pp.xfs_ialloc_read_agi.xfs_difree.xfs_ifree.xfs_inactive_ifree.xfs_inactive
      0.72 ±  9%      +0.6        1.37 ±  4%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +0.6        0.65 ±  7%  perf-profile.calltrace.cycles-pp.xfs_read_agi.xfs_ialloc_read_agi.xfs_dialloc.xfs_create.xfs_generic_create
      0.00            +0.7        0.66 ±  3%  perf-profile.calltrace.cycles-pp.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agi.xfs_iunlink
      0.00            +0.7        0.67 ±  7%  perf-profile.calltrace.cycles-pp.xfs_ialloc_read_agi.xfs_dialloc.xfs_create.xfs_generic_create.lookup_open
      3.40 ±  3%      +0.7        4.08 ±  2%  perf-profile.calltrace.cycles-pp.xfs_ifree.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work
      0.00            +0.7        0.68 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agi.xfs_iunlink.xfs_remove
      3.22 ±  2%      +0.8        4.00 ±  2%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker
      0.00            +0.8        0.79 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.___down_common.__down
      0.00            +0.8        0.84 ±  3%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.___down_common.__down.down
      0.62 ±  3%      +0.9        1.49 ± 19%  perf-profile.calltrace.cycles-pp.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agi.xfs_ialloc_read_agi
      0.00            +0.9        0.87 ±  4%  perf-profile.calltrace.cycles-pp.schedule_timeout.___down_common.__down.down.xfs_buf_lock
      0.00            +0.9        0.92 ±  3%  perf-profile.calltrace.cycles-pp.___down_common.__down.down.xfs_buf_lock.xfs_buf_find_lock
      0.00            +0.9        0.93 ±  3%  perf-profile.calltrace.cycles-pp.__down.down.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup
      0.00            +1.0        0.96 ±  3%  perf-profile.calltrace.cycles-pp.down.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup.xfs_buf_get_map
      0.00            +1.0        0.98 ±  3%  perf-profile.calltrace.cycles-pp.xfs_buf_lock.xfs_buf_find_lock.xfs_buf_lookup.xfs_buf_get_map.xfs_buf_read_map
      4.06            +1.0        5.05 ±  2%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work
      0.08 ±223%      +1.0        1.09 ± 19%  perf-profile.calltrace.cycles-pp.xfs_buf_find_lock.xfs_buf_lookup.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map
      0.35 ± 70%      +1.3        1.65 ±  3%  perf-profile.calltrace.cycles-pp.xfs_buf_lookup.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_read_agi
     10.80            +1.5       12.28 ±  2%  perf-profile.calltrace.cycles-pp.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread.kthread
     11.01            +1.5       12.52 ±  2%  perf-profile.calltrace.cycles-pp.xfs_inodegc_worker.process_one_work.worker_thread.kthread.ret_from_fork
     12.13            +1.5       13.65 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     12.13            +1.5       13.65 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     12.13            +1.5       13.65 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     11.60            +1.6       13.22 ±  2%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     11.76            +1.6       13.39 ±  2%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      8.02            +1.7        9.68 ±  2%  perf-profile.calltrace.cycles-pp.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread
      3.17 ±  2%      +1.7        4.85 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      2.77 ±  3%      +1.9        4.63 ±  9%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     28.56            +2.3       30.91 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     29.00            +2.4       31.40 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     28.83            +2.4       31.26 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     29.64            +2.8       32.41 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     29.65            +2.8       32.44 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     29.66            +2.8       32.44 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     30.26            +2.8       33.04 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     50.13            -3.7       46.48        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     47.98            -3.4       44.59        perf-profile.children.cycles-pp.do_syscall_64
     20.49            -1.4       19.10 ±  2%  perf-profile.children.cycles-pp.intel_idle_ibrs
     15.87            -1.1       14.73        perf-profile.children.cycles-pp.open64
     15.48            -1.0       14.52        perf-profile.children.cycles-pp.do_sys_openat2
      7.72            -0.9        6.80        perf-profile.children.cycles-pp.__close
     13.27            -0.9       12.40        perf-profile.children.cycles-pp.__x64_sys_openat
     14.52            -0.9       13.66        perf-profile.children.cycles-pp.do_filp_open
     14.40            -0.9       13.54        perf-profile.children.cycles-pp.path_openat
      6.09 ±  2%      -0.6        5.45        perf-profile.children.cycles-pp.write
      5.02 ±  2%      -0.6        4.41        perf-profile.children.cycles-pp.__x64_sys_close
      4.76 ±  2%      -0.5        4.22 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     13.71            -0.5       13.24        perf-profile.children.cycles-pp.unlink
     11.12            -0.5       10.66        perf-profile.children.cycles-pp.open_last_lookups
      3.39 ±  4%      -0.5        2.93 ±  2%  perf-profile.children.cycles-pp.__fput
      4.45 ±  3%      -0.4        4.04 ±  2%  perf-profile.children.cycles-pp.vfs_write
      4.50 ±  3%      -0.4        4.10 ±  2%  perf-profile.children.cycles-pp.ksys_write
      3.40 ±  2%      -0.4        3.00 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      3.80 ±  3%      -0.4        3.44 ±  2%  perf-profile.children.cycles-pp.xfs_file_buffered_write
      2.84 ±  3%      -0.4        2.48 ±  4%  perf-profile.children.cycles-pp.xfs_trans_alloc
      2.52 ±  4%      -0.3        2.18 ±  5%  perf-profile.children.cycles-pp.evict
      3.41 ±  3%      -0.3        3.09 ±  3%  perf-profile.children.cycles-pp.iomap_file_buffered_write
      2.57 ±  4%      -0.3        2.26 ±  2%  perf-profile.children.cycles-pp.xfs_release
      1.93 ±  3%      -0.3        1.65 ±  2%  perf-profile.children.cycles-pp.rename
      2.23 ±  4%      -0.3        1.96 ±  3%  perf-profile.children.cycles-pp.xfs_trans_reserve
      1.99 ±  4%      -0.3        1.72 ±  4%  perf-profile.children.cycles-pp.xfs_log_reserve
      1.98 ±  3%      -0.2        1.73 ±  5%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      2.11 ±  5%      -0.2        1.86 ±  3%  perf-profile.children.cycles-pp.xfs_free_eofblocks
      2.31 ±  2%      -0.2        2.08 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc
      2.41 ±  2%      -0.2        2.18 ±  3%  perf-profile.children.cycles-pp.iomap_write_iter
      1.84 ±  2%      -0.2        1.62 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      1.52 ±  4%      -0.2        1.31 ±  4%  perf-profile.children.cycles-pp.__x64_sys_rename
      1.44 ±  4%      -0.2        1.24 ±  3%  perf-profile.children.cycles-pp.do_renameat2
      2.72 ±  2%      -0.2        2.53 ±  2%  perf-profile.children.cycles-pp.xfs_inactive_truncate
      0.63 ± 12%      -0.2        0.46 ±  7%  perf-profile.children.cycles-pp.rcu_do_batch
      0.68 ± 13%      -0.2        0.50 ±  6%  perf-profile.children.cycles-pp.rcu_core
      1.05 ±  4%      -0.2        0.88 ±  5%  perf-profile.children.cycles-pp.vfs_rename
      0.26 ± 13%      -0.2        0.09 ± 11%  perf-profile.children.cycles-pp.run_ksoftirqd
      1.34 ±  4%      -0.2        1.18 ±  2%  perf-profile.children.cycles-pp.fsnotify
      1.46 ±  4%      -0.2        1.30 ±  4%  perf-profile.children.cycles-pp.__x64_sys_fcntl
      1.34 ±  4%      -0.2        1.18 ±  3%  perf-profile.children.cycles-pp.xfs_inode_item_format
      1.04 ±  4%      -0.2        0.89 ±  6%  perf-profile.children.cycles-pp.__folio_batch_release
      2.44 ±  5%      -0.2        2.29        perf-profile.children.cycles-pp.xfs_dialloc_ag
      1.07 ±  2%      -0.2        0.92 ±  3%  perf-profile.children.cycles-pp.alloc_empty_file
      1.40 ±  2%      -0.2        1.25 ±  5%  perf-profile.children.cycles-pp.do_open
      0.92 ± 10%      -0.1        0.78 ±  7%  perf-profile.children.cycles-pp.__do_softirq
      1.34 ±  4%      -0.1        1.20 ±  4%  perf-profile.children.cycles-pp.do_fcntl
      0.98 ±  6%      -0.1        0.84 ±  5%  perf-profile.children.cycles-pp.kmem_cache_free
      1.03 ±  3%      -0.1        0.90 ±  3%  perf-profile.children.cycles-pp.do_dentry_open
      0.77 ±  6%      -0.1        0.64 ±  5%  perf-profile.children.cycles-pp.down_read
      1.78 ±  2%      -0.1        1.65 ±  2%  perf-profile.children.cycles-pp.xfs_itruncate_extents_flags
      1.02            -0.1        0.89 ±  8%  perf-profile.children.cycles-pp.link_path_walk
      1.21 ±  2%      -0.1        1.08 ±  3%  perf-profile.children.cycles-pp.chmod
      1.30 ±  4%      -0.1        1.17 ±  4%  perf-profile.children.cycles-pp.fcntl_dirnotify
      1.39 ±  3%      -0.1        1.26 ±  4%  perf-profile.children.cycles-pp.dnotify_handler
      0.67 ±  5%      -0.1        0.54 ±  5%  perf-profile.children.cycles-pp.xfs_trans_alloc_icreate
      0.70 ±  5%      -0.1        0.58 ±  7%  perf-profile.children.cycles-pp.xfs_vn_rename
      0.68 ±  4%      -0.1        0.56 ±  7%  perf-profile.children.cycles-pp.xfs_rename
      0.82 ±  2%      -0.1        0.70        perf-profile.children.cycles-pp.__x64_sys_chmod
      1.32 ±  4%      -0.1        1.20 ±  3%  perf-profile.children.cycles-pp.filp_flush
      0.95 ±  5%      -0.1        0.83 ±  3%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.98 ±  2%      -0.1        0.87 ±  4%  perf-profile.children.cycles-pp.getname_flags
      0.61 ±  6%      -0.1        0.50 ± 10%  perf-profile.children.cycles-pp.__cond_resched
      0.34 ±  8%      -0.1        0.23 ±  9%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.71 ±  4%      -0.1        0.61 ±  2%  perf-profile.children.cycles-pp.dnotify_handle_event
      0.77 ±  7%      -0.1        0.67 ±  6%  perf-profile.children.cycles-pp.xlog_ticket_alloc
      0.54 ±  6%      -0.1        0.44 ±  3%  perf-profile.children.cycles-pp.init_file
      1.15 ±  3%      -0.1        1.05 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.83 ±  4%      -0.1        0.73 ±  3%  perf-profile.children.cycles-pp.send_to_group
      0.78 ±  5%      -0.1        0.68 ±  4%  perf-profile.children.cycles-pp.__filename_parentat
      0.62 ±  3%      -0.1        0.52 ±  3%  perf-profile.children.cycles-pp.notify_change
      1.12 ±  3%      -0.1        1.03 ±  3%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      0.66 ±  3%      -0.1        0.57        perf-profile.children.cycles-pp.chmod_common
      0.53 ±  5%      -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.do_send_sig_info
      0.61 ±  4%      -0.1        0.53 ±  4%  perf-profile.children.cycles-pp.send_sigio
      0.95 ±  7%      -0.1        0.87 ±  2%  perf-profile.children.cycles-pp.iomap_iter
      0.68 ±  7%      -0.1        0.60 ±  5%  perf-profile.children.cycles-pp.path_parentat
      0.57 ±  4%      -0.1        0.49 ±  4%  perf-profile.children.cycles-pp.send_sigio_to_task
      0.75 ±  2%      -0.1        0.67 ±  6%  perf-profile.children.cycles-pp.xfs_trans_log_inode
      0.50 ±  4%      -0.1        0.42 ± 10%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.46 ±  6%      -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.__send_signal_locked
      0.57 ±  7%      -0.1        0.49 ±  5%  perf-profile.children.cycles-pp.release_pages
      0.87 ±  8%      -0.1        0.79 ±  3%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      0.40 ± 10%      -0.1        0.32 ± 10%  perf-profile.children.cycles-pp.xlog_space_left
      0.57 ±  6%      -0.1        0.50 ±  5%  perf-profile.children.cycles-pp.filemap_dirty_folio
      0.48 ±  3%      -0.1        0.41 ± 11%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.55 ±  5%      -0.1        0.48 ±  6%  perf-profile.children.cycles-pp.fsnotify_add_mark_locked
      0.44 ±  8%      -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.security_file_alloc
      1.30 ±  3%      -0.1        1.23 ±  3%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.50 ±  8%      -0.1        0.44 ±  6%  perf-profile.children.cycles-pp.dput
      0.40 ±  8%      -0.1        0.33 ± 10%  perf-profile.children.cycles-pp.xlog_grant_push_threshold
      0.66 ±  4%      -0.1        0.59 ±  3%  perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      0.65 ±  6%      -0.1        0.58 ±  5%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      0.81 ±  4%      -0.1        0.74 ±  4%  perf-profile.children.cycles-pp.read
      0.32 ±  6%      -0.1        0.26 ±  8%  perf-profile.children.cycles-pp.security_file_free
      0.74 ±  3%      -0.1        0.68        perf-profile.children.cycles-pp.handle_signal
      1.02            -0.1        0.95 ±  2%  perf-profile.children.cycles-pp.xfs_defer_finish
      0.60 ±  4%      -0.1        0.53 ±  4%  perf-profile.children.cycles-pp.xlog_grant_add_space
      0.25 ± 15%      -0.1        0.19 ± 18%  perf-profile.children.cycles-pp.xlog_calc_unit_res
      0.49 ±  4%      -0.1        0.43 ±  5%  perf-profile.children.cycles-pp.xfs_dir_removename
      0.36 ±  8%      -0.1        0.30 ± 10%  perf-profile.children.cycles-pp.generic_permission
      0.59 ±  3%      -0.1        0.52 ±  5%  perf-profile.children.cycles-pp.fsnotify_put_mark
      0.31 ±  5%      -0.1        0.25 ±  8%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.31 ±  9%      -0.1        0.25 ±  6%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.58 ±  4%      -0.1        0.52 ±  2%  perf-profile.children.cycles-pp.x64_setup_rt_frame
      0.34 ±  6%      -0.1        0.29 ±  8%  perf-profile.children.cycles-pp.xfs_setattr_nonsize
      0.31 ± 11%      -0.1        0.26 ±  3%  perf-profile.children.cycles-pp.xfs_ilock
      0.46 ±  8%      -0.0        0.41 ±  4%  perf-profile.children.cycles-pp.xfs_bmapi_reserve_delalloc
      0.21 ± 10%      -0.0        0.17 ± 11%  perf-profile.children.cycles-pp.locked_inode_to_wb_and_lock_list
      0.41 ±  3%      -0.0        0.36 ±  6%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.18 ± 10%      -0.0        0.13 ± 12%  perf-profile.children.cycles-pp.rcu_all_qs
      0.98 ±  2%      -0.0        0.93 ±  2%  perf-profile.children.cycles-pp.xfs_defer_trans_roll
      0.34 ±  9%      -0.0        0.30 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.27 ±  7%      -0.0        0.23 ±  7%  perf-profile.children.cycles-pp.__sigqueue_alloc
      0.29 ±  6%      -0.0        0.26 ±  8%  perf-profile.children.cycles-pp.xfs_trans_del_item
      0.30 ±  6%      -0.0        0.27 ±  5%  perf-profile.children.cycles-pp.xfs_can_free_eofblocks
      0.10 ± 11%      -0.0        0.08 ± 20%  perf-profile.children.cycles-pp.security_path_unlink
      0.10 ± 11%      -0.0        0.07 ± 23%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent_before
      0.13 ±  9%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.xfs_btree_get_leaf_keys
      0.13 ±  7%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.mem_cgroup_css_rstat_flush
      0.06 ± 11%      +0.0        0.09 ± 12%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.04 ± 45%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.sched_use_asym_prio
      0.08 ± 17%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.06 ± 17%      +0.0        0.10 ± 13%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.09 ± 11%      +0.0        0.13 ± 14%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.03 ±100%      +0.0        0.07 ± 14%  perf-profile.children.cycles-pp.kernel_fpu_begin_mask
      0.05 ± 48%      +0.0        0.10 ± 18%  perf-profile.children.cycles-pp.xlog_write
      0.06 ± 49%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.xfs_iunlink_lookup
      0.09 ± 14%      +0.0        0.14 ± 11%  perf-profile.children.cycles-pp.cpu_util
      0.08 ± 20%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.xfs_iunlink_log_inode
      0.04 ± 72%      +0.0        0.09 ± 17%  perf-profile.children.cycles-pp.llist_add_batch
      0.04 ± 71%      +0.0        0.08 ± 20%  perf-profile.children.cycles-pp.xfs_btree_dup_cursor
      0.10 ± 16%      +0.1        0.16 ±  8%  perf-profile.children.cycles-pp.sched_clock
      0.14 ±  6%      +0.1        0.20 ± 12%  perf-profile.children.cycles-pp.idle_cpu
      0.02 ±142%      +0.1        0.07 ± 16%  perf-profile.children.cycles-pp.select_task_rq
      0.08 ± 18%      +0.1        0.13 ±  4%  perf-profile.children.cycles-pp.update_curr
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.balance_fair
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.09 ± 20%      +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.__switch_to_asm
      0.12 ± 19%      +0.1        0.18 ±  7%  perf-profile.children.cycles-pp.native_sched_clock
      0.02 ±141%      +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.31 ±  6%      +0.1        0.37 ±  6%  perf-profile.children.cycles-pp.xfs_next_bit
      0.15 ± 16%      +0.1        0.20 ±  6%  perf-profile.children.cycles-pp.xfs_buf_item_init
      0.03 ±100%      +0.1        0.09 ± 18%  perf-profile.children.cycles-pp.switch_fpu_return
      0.05 ± 51%      +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.__switch_to
      0.09 ± 12%      +0.1        0.15 ± 17%  perf-profile.children.cycles-pp.prepare_task_switch
      0.08 ± 10%      +0.1        0.14 ± 12%  perf-profile.children.cycles-pp.finish_task_switch
      0.04 ± 71%      +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.update_rq_clock
      0.12 ± 15%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.07 ± 24%      +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.set_next_entity
      0.04 ± 72%      +0.1        0.11 ± 14%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.00            +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.place_entity
      0.16 ± 14%      +0.1        0.23 ±  8%  perf-profile.children.cycles-pp.xfs_ialloc_ag_alloc
      0.40 ±  6%      +0.1        0.48 ±  4%  perf-profile.children.cycles-pp.xfs_perag_get
      0.08 ± 12%      +0.1        0.16 ± 14%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.31 ± 11%      +0.1        0.39 ±  4%  perf-profile.children.cycles-pp.xfs_buf_offset
      0.13 ± 12%      +0.1        0.23 ± 10%  perf-profile.children.cycles-pp.xlog_cil_push_work
      0.18 ± 11%      +0.1        0.29 ±  9%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.49 ± 12%      +0.1        0.61 ±  8%  perf-profile.children.cycles-pp._xfs_trans_bjoin
      0.19 ± 10%      +0.1        0.31 ±  5%  perf-profile.children.cycles-pp.update_load_avg
      0.20 ± 10%      +0.1        0.33 ±  5%  perf-profile.children.cycles-pp.enqueue_entity
      0.21 ±  9%      +0.1        0.36 ±  9%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.23 ± 12%      +0.1        0.38 ±  5%  perf-profile.children.cycles-pp.xfs_imap_to_bp
      0.32 ± 18%      +0.2        0.47 ±  9%  perf-profile.children.cycles-pp.xfs_contig_bits
      0.22 ± 13%      +0.2        0.38 ±  7%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.20 ±  9%      +0.2        0.36 ±  5%  perf-profile.children.cycles-pp.dequeue_entity
      0.24 ±  7%      +0.2        0.40 ±  5%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.25 ±  7%      +0.2        0.42 ±  4%  perf-profile.children.cycles-pp.activate_task
      0.29 ± 13%      +0.2        0.46 ±  6%  perf-profile.children.cycles-pp.schedule_idle
      1.00 ±  4%      +0.2        1.18 ±  7%  perf-profile.children.cycles-pp.xfs_buf_item_size
      0.28 ±  8%      +0.2        0.45 ±  4%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.23 ±  8%      +0.2        0.42 ±  6%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.79 ±  4%      +0.2        0.98 ±  9%  perf-profile.children.cycles-pp.xfs_buf_item_size_segment
      2.66 ±  3%      +0.2        2.90 ±  2%  perf-profile.children.cycles-pp.xfs_trans_run_precommits
      0.39 ±  9%      +0.3        0.65 ± 13%  perf-profile.children.cycles-pp.xfs_iunlink_log_dinode
      1.73 ±  3%      +0.3        2.00 ±  4%  perf-profile.children.cycles-pp.xlog_cil_alloc_shadow_bufs
      0.44 ±  7%      +0.3        0.72 ± 13%  perf-profile.children.cycles-pp.xfs_iunlink_item_precommit
      5.10 ±  2%      +0.3        5.40 ±  2%  perf-profile.children.cycles-pp.xlog_cil_insert_items
      0.44 ±  9%      +0.3        0.76 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      0.75 ±  3%      +0.3        1.08 ±  3%  perf-profile.children.cycles-pp.memcpy_orig
      0.77 ±  6%      +0.3        1.09 ±  3%  perf-profile.children.cycles-pp.xfs_iunlink
      0.82 ±  5%      +0.4        1.17 ±  5%  perf-profile.children.cycles-pp.update_sg_lb_stats
      6.70            +0.4        7.08        perf-profile.children.cycles-pp.vfs_unlink
      0.38 ±  7%      +0.4        0.77 ±  7%  perf-profile.children.cycles-pp.up
      0.43 ±  8%      +0.4        0.83 ±  7%  perf-profile.children.cycles-pp.xfs_buf_unlock
      0.66 ±  7%      +0.4        1.06 ±  4%  perf-profile.children.cycles-pp.xfs_buf_item_release
      0.94 ±  6%      +0.4        1.34 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.96 ±  5%      +0.4        1.38 ±  5%  perf-profile.children.cycles-pp.find_busiest_group
      4.29 ±  3%      +0.4        4.74        perf-profile.children.cycles-pp.xlog_cil_insert_format_items
      5.99            +0.5        6.46        perf-profile.children.cycles-pp.xfs_remove
      6.03            +0.5        6.50        perf-profile.children.cycles-pp.xfs_vn_unlink
      1.18 ±  5%      +0.5        1.68 ±  4%  perf-profile.children.cycles-pp.load_balance
      0.98 ±  4%      +0.5        1.53 ±  2%  perf-profile.children.cycles-pp.poll_idle
      2.91 ±  4%      +0.6        3.51 ±  2%  perf-profile.children.cycles-pp.xfs_difree
      1.21 ±  5%      +0.6        1.81 ±  2%  perf-profile.children.cycles-pp.newidle_balance
      2.40 ±  4%      +0.6        3.00 ±  2%  perf-profile.children.cycles-pp.xfs_buf_item_format
      2.19 ±  4%      +0.6        2.82 ±  2%  perf-profile.children.cycles-pp.xfs_buf_item_format_segment
     10.46            +0.7       11.13        perf-profile.children.cycles-pp.xlog_cil_commit
      3.41 ±  3%      +0.7        4.08 ±  2%  perf-profile.children.cycles-pp.xfs_ifree
      1.32 ±  6%      +0.7        2.04 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      3.93 ±  2%      +0.8        4.76 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     14.08            +0.8       14.93        perf-profile.children.cycles-pp.__xfs_trans_commit
      1.37            +0.9        2.26 ±  3%  perf-profile.children.cycles-pp.xfs_ialloc_read_agi
      0.68 ±  8%      +1.0        1.72        perf-profile.children.cycles-pp.schedule_timeout
      0.86 ±  7%      +1.1        1.94 ±  2%  perf-profile.children.cycles-pp.down
      0.67 ±  8%      +1.1        1.76 ±  2%  perf-profile.children.cycles-pp.___down_common
      0.91 ±  7%      +1.1        2.01 ±  2%  perf-profile.children.cycles-pp.xfs_buf_lock
      0.67 ±  8%      +1.1        1.77 ±  2%  perf-profile.children.cycles-pp.__down
      1.02 ±  6%      +1.1        2.14 ±  2%  perf-profile.children.cycles-pp.xfs_buf_find_lock
      1.52 ±  3%      +1.1        2.66 ±  3%  perf-profile.children.cycles-pp.xfs_buf_lookup
      1.96 ±  2%      +1.2        3.12 ±  3%  perf-profile.children.cycles-pp.xfs_read_agi
      1.70 ±  4%      +1.2        2.87 ±  2%  perf-profile.children.cycles-pp.schedule
      2.29 ±  3%      +1.2        3.51 ±  3%  perf-profile.children.cycles-pp.xfs_buf_get_map
      2.39 ±  2%      +1.2        3.62 ±  3%  perf-profile.children.cycles-pp.xfs_buf_read_map
      2.00 ±  4%      +1.3        3.28 ±  2%  perf-profile.children.cycles-pp.__schedule
      3.20 ±  2%      +1.4        4.56 ±  3%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
     10.80            +1.5       12.28 ±  2%  perf-profile.children.cycles-pp.xfs_inactive
     12.13            +1.5       13.65 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
     12.13            +1.5       13.65 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
     12.13            +1.5       13.65 ±  2%  perf-profile.children.cycles-pp.kthread
     11.01            +1.5       12.52 ±  2%  perf-profile.children.cycles-pp.xfs_inodegc_worker
      2.07 ±  5%      +1.6        3.64 ±  6%  perf-profile.children.cycles-pp.intel_idle_irq
     11.60            +1.6       13.22 ±  2%  perf-profile.children.cycles-pp.process_one_work
     11.76            +1.6       13.39 ±  2%  perf-profile.children.cycles-pp.worker_thread
      8.02            +1.7        9.68 ±  2%  perf-profile.children.cycles-pp.xfs_inactive_ifree
      3.27 ±  2%      +1.7        4.94        perf-profile.children.cycles-pp.intel_idle
     29.12            +2.3       31.45 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
     29.12            +2.3       31.45 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
     29.59            +2.4       31.97 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
     30.25            +2.8       33.03 ±  2%  perf-profile.children.cycles-pp.do_idle
     29.66            +2.8       32.44 ±  2%  perf-profile.children.cycles-pp.start_secondary
     30.26            +2.8       33.04 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     30.26            +2.8       33.04 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     20.48            -1.4       19.10 ±  2%  perf-profile.self.cycles-pp.intel_idle_ibrs
      3.42 ±  2%      -0.5        2.95 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      3.40 ±  2%      -0.4        2.99 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      2.20 ±  3%      -0.3        1.93 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.66 ±  3%      -0.2        1.47 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
      2.76 ±  3%      -0.2        2.57 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.81 ±  7%      -0.2        0.66 ±  6%  perf-profile.self.cycles-pp.xlog_cil_insert_items
      0.66 ±  5%      -0.1        0.54 ±  5%  perf-profile.self.cycles-pp.down_read
      0.78 ±  5%      -0.1        0.68 ±  5%  perf-profile.self.cycles-pp.kmem_cache_free
      1.14            -0.1        1.05 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.44 ±  5%      -0.1        0.36 ± 12%  perf-profile.self.cycles-pp.link_path_walk
      0.39 ± 10%      -0.1        0.32 ± 11%  perf-profile.self.cycles-pp.xlog_space_left
      0.45 ±  8%      -0.1        0.38 ±  8%  perf-profile.self.cycles-pp.fsnotify
      0.62 ±  5%      -0.1        0.55 ±  4%  perf-profile.self.cycles-pp.xfs_log_ticket_ungrant
      0.59 ±  5%      -0.1        0.52 ±  5%  perf-profile.self.cycles-pp.xlog_grant_add_space
      0.24 ± 15%      -0.1        0.18 ± 17%  perf-profile.self.cycles-pp.xlog_calc_unit_res
      0.30 ±  5%      -0.1        0.25 ±  8%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.30 ±  9%      -0.1        0.24 ±  7%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.41 ±  3%      -0.0        0.36 ±  6%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.24 ± 11%      -0.0        0.20 ±  9%  perf-profile.self.cycles-pp._atomic_dec_and_lock
      0.15 ±  8%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.13 ±  8%      -0.0        0.10 ± 15%  perf-profile.self.cycles-pp.rcu_all_qs
      0.12 ±  6%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.mem_cgroup_css_rstat_flush
      0.10 ± 22%      -0.0        0.07 ± 18%  perf-profile.self.cycles-pp.getname_flags
      0.06 ± 13%      +0.0        0.08 ± 11%  perf-profile.self.cycles-pp.load_balance
      0.08 ± 14%      +0.0        0.11 ± 11%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.10 ±  7%      +0.0        0.13 ± 11%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.05 ± 47%      +0.0        0.09 ± 10%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.14 ±  5%      +0.0        0.18 ± 11%  perf-profile.self.cycles-pp.idle_cpu
      0.09 ± 14%      +0.0        0.14 ± 11%  perf-profile.self.cycles-pp.cpu_util
      0.04 ± 72%      +0.0        0.09 ± 17%  perf-profile.self.cycles-pp.llist_add_batch
      0.08 ± 14%      +0.1        0.13 ±  6%  perf-profile.self.cycles-pp.update_load_avg
      0.02 ±141%      +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.do_idle
      0.11 ± 18%      +0.1        0.16 ±  5%  perf-profile.self.cycles-pp.native_sched_clock
      0.01 ±223%      +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.09 ± 20%      +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.__switch_to_asm
      0.26 ± 10%      +0.1        0.32 ±  9%  perf-profile.self.cycles-pp.xfs_perag_put
      0.41 ±  3%      +0.1        0.47 ±  3%  perf-profile.self.cycles-pp.xlog_cil_alloc_shadow_bufs
      0.13 ± 16%      +0.1        0.19 ±  9%  perf-profile.self.cycles-pp.xfs_buf_item_init
      0.05 ± 53%      +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.__switch_to
      0.30 ±  6%      +0.1        0.36 ±  6%  perf-profile.self.cycles-pp.xfs_next_bit
      0.26 ± 14%      +0.1        0.32 ±  6%  perf-profile.self.cycles-pp.xfs_buf_offset
      0.24 ± 11%      +0.1        0.30 ± 11%  perf-profile.self.cycles-pp.xfs_perag_get
      0.01 ±223%      +0.1        0.08 ± 21%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.39 ±  7%      +0.1        0.48 ±  8%  perf-profile.self.cycles-pp.xfs_buf_item_size_segment
      0.71 ±  6%      +0.1        0.80 ±  4%  perf-profile.self.cycles-pp.xfs_buf_item_format_segment
      0.09 ±  7%      +0.1        0.20 ± 14%  perf-profile.self.cycles-pp.__schedule
      0.29 ± 17%      +0.1        0.43 ±  8%  perf-profile.self.cycles-pp.xfs_contig_bits
      0.53 ±  7%      +0.2        0.76 ±  5%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.73 ±  3%      +0.3        1.04 ±  3%  perf-profile.self.cycles-pp.memcpy_orig
      0.96 ±  4%      +0.5        1.51 ±  2%  perf-profile.self.cycles-pp.poll_idle
      1.84 ±  5%      +1.5        3.34 ±  7%  perf-profile.self.cycles-pp.intel_idle_irq
      3.27 ±  2%      +1.7        4.94        perf-profile.self.cycles-pp.intel_idle





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

