Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB06758DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGSGfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGSGe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:34:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95491FCB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689748485; x=1721284485;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Rg/Tc2DHD+YsRGZod0AVHeJJ0C4KSkNItxO7LGd/anQ=;
  b=I/qAzSoziDAAuuqyT+V2dGStbsw4GzXO3fiRIL1pGohO4bqdinFrbQ6i
   3bzUhiSgjUAxqgEmLjVjqM1Zo7lZL7sSLClcnqENAUi6lf5ZbZH/p6PUV
   6T0Ax2afI9BNTJ58IzMniYdvXAEg3I+VQx+Yx8UiFQz8xd3xYIE79W5cS
   6IBpgaKmNcM36PwfvPHAXPEqeXYl4w4y9IjuWpkZhQDuFDgN/Vx9K9QUd
   /dzysDXN1TCKg6G7GkB7tcF/fLLUQQWeIFjnHfKp9gBSkj5WoHElUjx+t
   J4E27d75GaRfVKidEKnYkABmwtkoRfnGqplwsOCgl5zKgRm0IHwMdRL62
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="363841758"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="yaml'?scan'208";a="363841758"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 23:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="897812369"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="yaml'?scan'208";a="897812369"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 18 Jul 2023 23:34:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 23:34:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 23:34:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 23:34:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 23:34:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jb8wej19hqlgrSIRTYeIjKIhJT3LEbXJYw5PdBGdZAuOnb/8/R7I/dVYuUcF7jxTqj5xAM5RjIzbZkURz/lKqFZTD0EGui41fPBxvUzqWbhBHK08KpBs0ioOZ7kW+CMmHuuD97RlMtT7n8KMoUZ/Gc6WYIPdwsTUdVU74P4nHYUgXK61xhlppezmcaiK+X8K3K3kl7CA15ErdtT5Gv2EE2/8Zc6DFpViW0NUqfjirY0eYHm9tJg/KpVA/c+llX5GT7ZS2VkAVOMJXanymtu3NE0Hgo9mSmd9PaYT4iaT/3YapRX5/uIVNvJX/FS9h/4xo9y4M8PsnJK2tA6UJmncMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeyJpTHyLV8uCZvSZN54k98gWcoD1NnGIE3yClp3kgM=;
 b=A193uo5qgjgrs+L3Z33lSA12k4GaOvhjzubd7pZdMqG0UqQpV1Hk+7061g7SLjw3snM6VAo6pTgFSYa4Vnh16181/2uRkios3v6EEF11Hbq+qUf3OrnHthkQ/P5R7qSB3ZEGSrfhBJglq92H5Fi642BYy1fHNpA8jVW+uxiJrX+uLFa68N9Fjw0Xv5Seg5OiYvrGzx+w3wgIR55lJU5ag/X18XxhPxpmoZSFX3jMx+njXqAS5hxW6bomOiPOqcjc+0euWbQHxw2YDLnNmf44wdo/UakwcUIUEWWt9N7O2uI/9b/xLzLKMJ1DewXGxj7NXKOYlN2dfEvo0ydTjKMKqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22)
 by DM4PR11MB5341.namprd11.prod.outlook.com (2603:10b6:5:390::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 06:34:33 +0000
Received: from SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::b6b6:4109:345a:2aab]) by SJ0PR11MB6792.namprd11.prod.outlook.com
 ([fe80::b6b6:4109:345a:2aab%4]) with mapi id 15.20.6588.028; Wed, 19 Jul 2023
 06:34:33 +0000
Date:   Wed, 19 Jul 2023 14:34:21 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <yujie.liu@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Olivier Dion <odion@efficios.com>,
        Feng Tang <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        <ying.huang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [mm]  c1753fd02a:  stress-ng.madvise.ops_per_sec
 -6.5% regression
Message-ID: <202307181511.8643eac7-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="k2j0AZe56lBmWZqw"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0179.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::35) To SJ0PR11MB6792.namprd11.prod.outlook.com
 (2603:10b6:a03:485::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6792:EE_|DM4PR11MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: 953eeec7-f815-416a-4f53-08db88223650
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsQJkNxfbaM2k778yghbU+LwSjhssRlAj7it0S2Zl70xwXZJNzKYvo7Ymes0ZfCOlCp3fIpGlACWGI/gFf8I9OlFPxVSvuLIcxwF8ZJFCRfW4vu+6/cRf0aKQh2oEHqfJownDjOmbaDni4K1udCm2akap5ggSiF1QDJAOp/qdh86zNNvoe0eNZqtMR1QNCAXNLqupSiqzSvkOrFoG9N//3AwNAHJjC/ULEwds4rA0NEOWoE167RZkoMqFtEwNy6gs2AkS4By0ltJMLdgaL3C/Wlmd6rOe8aKgHsANCIqGxQIBG1LkspSswYSxVWvRNlTzyKTLXB4Vq2Oj5L3HqkDsFENdtmAzyiAogNspf098lUl3SCB8k/2iDGv+Vu+dbq7w0G88oCMTqIaXkzV5Te4YE2z5stAF3A2i70oEt6DhjIJ2VyQ0+UcSR4Wg15ZVL44Y0EYz4Ag0O6JtfV0d+uIUXPpKfP9LjFkw5Qj6AjsMi6G4bEZjQUhoz7ORRDBw9JvcWCW7vxCZoq7mWhpTco+6m+f4ledkmRLJIONGvVTABNLsPPfx0zHIlQpiLtY75HglVF7iSgOytScmoaHpPwZ+6G1BH/l7+990oDAJOZDhXqHRMPLR+qmC+r7OVvrwNV4ZLvIY5+XOenbu8cWjUzHe629hBnorF3+RtaT6qcxSn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6792.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199021)(2906002)(30864003)(235185007)(8936002)(8676002)(66556008)(66476007)(6916009)(4326008)(66946007)(316002)(41300700001)(5660300002)(966005)(26005)(1076003)(6506007)(6512007)(36756003)(6486002)(186003)(478600001)(6666004)(107886003)(19627235002)(54906003)(44144004)(83380400001)(2616005)(21490400003)(38100700002)(82960400001)(86362001)(2700100001)(579004)(559001)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lsDusBagcNvloqUnNKEiAKOGFxiiGjbYAkm6CqAHFYjkGMczWVFwyjSIeK?=
 =?iso-8859-1?Q?cIxYb1eKckKlvbm7R7Vf1UdcUp889v12zYH5YyzGHMy5Du61JqgZ1gjAhm?=
 =?iso-8859-1?Q?upNZEPYD4s3Q0EsnjO9mPdYEMpZaB9XBmqPZvDjtdTB/YFL+y8blM8WkNw?=
 =?iso-8859-1?Q?kTPzLZk2vBFYVL+IQGZjkGrFph2LfrD+nwx06Ra15YbcoF5kLoikto2j35?=
 =?iso-8859-1?Q?s52HZX7+pGQOJ3ZXFJHQbOaC59OWFn47EWiLELhJUzW4mgxa6HWceYO48R?=
 =?iso-8859-1?Q?bai9Me3x7u0MEDMvcZq2AKAsOBxpvuVNbO+clI2mhkjndfZY34Q+YliWhX?=
 =?iso-8859-1?Q?4vbUhp8nGzUkIbmATI9+RWi0NxbHyavskYreBnpknVhfm3Ib7OZr3c7AwD?=
 =?iso-8859-1?Q?udaE1CW8BU+woqxiDKoKAZPNabpbN/kUB9onn//ckjBkXMoY/1gwBXnpqb?=
 =?iso-8859-1?Q?O6TGV+4iTFF2ffupxJ4FFOMuCfQAf9nXtE0S/tziynLSYfcuu1EPHyC9Zo?=
 =?iso-8859-1?Q?eyV5DIT0qtc6MgxyKcZ+4WSjMx4iLDUJ5SuLgMfjj9Luh2k8xAEpW5cCqF?=
 =?iso-8859-1?Q?QKznXI4nKiwNfLFk8CKnvlPKEucWnEXeqruuXFp6pObHSty4mJgSh4Sl1z?=
 =?iso-8859-1?Q?G5F5rI9ImHGyd7v64W+DrU2/US9RfASl62x429wkxUuaBME3EalBoFUqM9?=
 =?iso-8859-1?Q?DjF7PAvGIhGCEHwhlJ2hoxfUoxyEQRAlcMu80f21P1LtXvuflhSouu2vrF?=
 =?iso-8859-1?Q?NH3czkmARu3mabmrxYeisdtNyI6zXUieZDtGaVyVdJReHSxk7gXU6FwRll?=
 =?iso-8859-1?Q?NCY405rDzZtijTICLlE+bC+O2y+YeHAWbhzF7HSs8NNoQ5Ag8MuEVaQG10?=
 =?iso-8859-1?Q?bRMOP4Y0t0ECN0PK2EqY61w59btwWgDxcus2x14c/vuBNyMN/IXmopEX92?=
 =?iso-8859-1?Q?fsgjclW1/V577QRCkyj6Z2ZDUzrNmq3xqa64nCbj/2WKkOqvpTzvor4soh?=
 =?iso-8859-1?Q?N88DtQPPucioxk3gHeUhzPJNb6QC0WHpNYaxXnumGLMAByymDZUd8VBj14?=
 =?iso-8859-1?Q?iIO2Zy70xtK45SQAUTG73ChHVS75e0+jxFnbiQIW3tTDK6eb4Y/U5/Vg3p?=
 =?iso-8859-1?Q?iJaRLJVgXcZlV8vPzOhTzSi5tbohBcMK1TBtHOrH3hf6ORj9tr9/0fFjza?=
 =?iso-8859-1?Q?NCT43OiK7Ne6c3LdUJKGm/ye4FOnhn6cX4OnARyzx1pqRyNSkPwQgFXwSG?=
 =?iso-8859-1?Q?8l0Cj1GMhQVZqONRmWpg7fPx34mhr4J1B03qU/yScDrQOHmDzDASb7qBPg?=
 =?iso-8859-1?Q?2UWrDY61Uj/bOefa29bndAjhZAPaAp1pYE4HD/SZvRKd9ntpfBGrAkorI9?=
 =?iso-8859-1?Q?o8GqrWGyBrybjfy9fi/NNjgV7uDriwy7Bd+kNBcYF6ja+wHcz3gvwLKHmc?=
 =?iso-8859-1?Q?PMTSy7IqAgOcbqxAguut8+Ex4EFREqyHfqkBbckUZ4wlj3B7HWxQLMnDqU?=
 =?iso-8859-1?Q?3lbY84NRTS01DwN6VULgl04pKzrPW6uZ+uRVkg5pswxEsnrjJ+xGnCCv7f?=
 =?iso-8859-1?Q?pJNPytxX2UF54WW1gjnv5Xa0OU7+T+JeNRVQulvC1GWC5bqiUjuRPJnzTe?=
 =?iso-8859-1?Q?Na7geXRbmS9Al1AkWxHlqxK6vVmP7hChJSL8VEnRvTaqO+QX7Y8wErAA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 953eeec7-f815-416a-4f53-08db88223650
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 06:34:33.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgVTmYDOBbYrQptIs/ml+dJk7nPfavGr9gB7LEM9XHKcJPVKLH4tuKiyl4PpBJOnL/QK9ci6oUOUm/YgdSxY1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5341
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--k2j0AZe56lBmWZqw
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


hi, Mathieu Desnoyers,

we noticed that this commit addressed issue:
  "[linus:master] [sched] af7f588d8f: will-it-scale.per_thread_ops -13.9% regression"
we reported before on:
  https://lore.kernel.org/oe-lkp/202305151017.27581d75-yujie.liu@intel.com/

we really saw a will-it-scale.per_thread_ops 92.2% improvement by this commit
(details are as below).
however, we also noticed a stress-ng regression.

below detail report FYI.


Hello,

kernel test robot noticed a -6.5% regression of stress-ng.madvise.ops_per_sec on:


commit: c1753fd02a0058ea43cbb31ab26d25be2f6cfe08 ("mm: move mm_count into its own cache line")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	class: os
	test: madvise
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops 92.2% improvement |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory              |
| test parameters  | cpufreq_governor=performance                                  |
|                  | mode=thread                                                   |
|                  | nr_task=50%                                                   |
|                  | test=context_switch1                                          |
+------------------+---------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202307181511.8643eac7-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/madvise/stress-ng/60s

commit: 
  025b7799b3 ("mm/memcg: remove return value of mem_cgroup_scan_tasks()")
  c1753fd02a ("mm: move mm_count into its own cache line")

025b7799b35d32e4 c1753fd02a0058ea43cbb31ab26 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     75.45            -2.3%      73.68        iostat.cpu.idle
     22.96            +8.1%      24.82        iostat.cpu.system
   1532875            -6.2%    1437466        vmstat.system.cs
    405460            -4.8%     386179        vmstat.system.in
    182.50 ±  8%     +39.0%     253.67 ±  6%  perf-c2c.DRAM.local
      6540 ±  7%     +18.0%       7719 ±  4%  perf-c2c.HITM.local
     11038 ±  7%     +14.7%      12655 ±  3%  perf-c2c.HITM.total
     63.91 ± 45%    +503.4%     385.60 ± 88%  sched_debug.cfs_rq:/.load_avg.avg
    226.38 ± 84%    +841.1%       2130 ±110%  sched_debug.cfs_rq:/.load_avg.stddev
      0.00 ± 12%     +31.8%       0.00 ± 16%  sched_debug.cpu.next_balance.stddev
    245385 ± 24%     -43.7%     138251 ± 37%  numa-meminfo.node0.AnonPages
    263049 ± 24%     -42.1%     152330 ± 37%  numa-meminfo.node0.Inactive
    256261 ± 24%     -43.0%     146021 ± 35%  numa-meminfo.node0.Inactive(anon)
      8816 ±  5%     -12.1%       7751 ±  2%  numa-meminfo.node1.KernelStack
     61340 ± 24%     -43.7%      34551 ± 37%  numa-vmstat.node0.nr_anon_pages
     64059 ± 24%     -43.1%      36476 ± 35%  numa-vmstat.node0.nr_inactive_anon
     64057 ± 24%     -43.1%      36477 ± 35%  numa-vmstat.node0.nr_zone_inactive_anon
      8827 ±  5%     -11.9%       7776 ±  2%  numa-vmstat.node1.nr_kernel_stack
   5574645           +17.7%    6559502        turbostat.C1
      2.80            +0.4        3.25        turbostat.C1%
  46042553           -10.7%   41114702        turbostat.C1E
     40.58            -2.8       37.75        turbostat.C1E%
    232771           +35.5%     315298 ±  3%  turbostat.POLL
      0.10            +0.0        0.12 ±  4%  turbostat.POLL%
      5473            -6.5%       5116        stress-ng.madvise.ops
     91.17            -6.5%      85.22        stress-ng.madvise.ops_per_sec
     18921 ±  2%      -5.2%      17935        stress-ng.time.involuntary_context_switches
   4377760            -6.9%    4077120        stress-ng.time.minor_page_faults
      1451            +8.5%       1575        stress-ng.time.percent_of_cpu_this_job_got
    868.58            +9.1%     947.90        stress-ng.time.system_time
  49882899            -6.2%   46774408        stress-ng.time.voluntary_context_switches
      0.00           -25.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.do_madvise
      0.01 ± 12%     -32.0%       0.01 ± 14%  perf-sched.sch_delay.max.ms.__cond_resched.shrink_folio_list.reclaim_folio_list.reclaim_pages.madvise_cold_or_pageout_pte_range
      0.02 ± 29%     -38.0%       0.01 ± 25%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     27004 ±  3%     -14.4%      23109 ±  4%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.madvise_vma_behavior
      0.02 ±147%    +302.1%       0.06 ± 37%  perf-sched.wait_time.avg.ms.__cond_resched.down_read_killable.m_start.seq_read_iter.seq_read
      0.03 ± 28%     +77.2%       0.05 ± 25%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.madvise_vma_behavior
      0.09 ± 37%     -54.0%       0.04 ± 58%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file.alloc_empty_file
      0.06 ± 13%     +33.7%       0.08 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.smaps_pte_range.walk_pmd_range.isra.0
      0.02 ±  7%     +26.4%       0.02 ±  8%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__mm_populate
      0.02 ±142%    +459.3%       0.13 ± 71%  perf-sched.wait_time.max.ms.__cond_resched.down_read_killable.m_start.seq_read_iter.seq_read
      0.10 ± 38%     +76.8%       0.18 ± 21%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.madvise_vma_behavior
      0.18 ± 32%     -63.4%       0.07 ± 64%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file.alloc_empty_file
      0.28 ± 20%     +82.2%       0.51 ± 49%  perf-sched.wait_time.max.ms.__cond_resched.smaps_pte_range.walk_pmd_range.isra.0
    511753            -2.6%     498421        proc-vmstat.nr_active_anon
   1230717            -1.2%    1215541        proc-vmstat.nr_file_pages
    111859            -2.1%     109551        proc-vmstat.nr_inactive_anon
    521558            -2.9%     506414        proc-vmstat.nr_shmem
    511753            -2.6%     498421        proc-vmstat.nr_zone_active_anon
    111859            -2.1%     109551        proc-vmstat.nr_zone_inactive_anon
   5787879            -5.9%    5446905        proc-vmstat.numa_hit
   5721666            -6.0%    5380670        proc-vmstat.numa_local
   8764839            -6.4%    8203387        proc-vmstat.pgactivate
   8817630            -5.6%    8321742        proc-vmstat.pgalloc_normal
   6169256            -6.5%    5767868        proc-vmstat.pgdeactivate
   4886189            -5.9%    4597761        proc-vmstat.pgfault
   8040298            -5.9%    7568628        proc-vmstat.pgfree
   1124737            -5.4%    1063589        proc-vmstat.pglazyfree
    330302            -5.4%     312509        proc-vmstat.pglazyfreed
      2731            -5.5%       2582        proc-vmstat.thp_split_page
      2731            -5.5%       2582        proc-vmstat.thp_swpout_fallback
     43222            -6.1%      40594        proc-vmstat.unevictable_pgs_culled
     43109            -6.1%      40479        proc-vmstat.unevictable_pgs_mlocked
     43108            -6.1%      40479        proc-vmstat.unevictable_pgs_munlocked
     43077            -6.1%      40449        proc-vmstat.unevictable_pgs_rescued
      4.02            +3.0%       4.14        perf-stat.i.MPKI
 5.327e+09            -2.6%  5.187e+09        perf-stat.i.branch-instructions
  61923807            -3.9%   59499312        perf-stat.i.branch-misses
     38.78            -0.9       37.91        perf-stat.i.cache-miss-rate%
  39271495            -1.7%   38622495        perf-stat.i.cache-misses
   1604399            -6.3%    1502597        perf-stat.i.context-switches
      2.52            +6.8%       2.69        perf-stat.i.cpi
   6.3e+10            +4.2%  6.564e+10        perf-stat.i.cpu-cycles
      3551           -12.1%       3123 ±  2%  perf-stat.i.cpu-migrations
      1634            +6.0%       1731        perf-stat.i.cycles-between-cache-misses
      0.05 ±  3%      -0.0        0.04 ±  2%  perf-stat.i.dTLB-load-miss-rate%
   3024995 ±  3%      -8.7%    2760425 ±  2%  perf-stat.i.dTLB-load-misses
 6.315e+09            -2.5%  6.159e+09        perf-stat.i.dTLB-loads
    342929            -8.5%     313646        perf-stat.i.dTLB-store-misses
 3.133e+09            -6.6%  2.928e+09        perf-stat.i.dTLB-stores
 2.525e+10            -2.5%  2.463e+10        perf-stat.i.instructions
      0.42            -5.4%       0.40        perf-stat.i.ipc
      0.98            +4.2%       1.03        perf-stat.i.metric.GHz
    632.41            -1.5%     622.71        perf-stat.i.metric.K/sec
    232.39            -3.4%     224.57        perf-stat.i.metric.M/sec
     40.09            +1.7       41.80        perf-stat.i.node-store-miss-rate%
   8117024            +2.2%    8297397        perf-stat.i.node-store-misses
  12712453            -4.2%   12179387        perf-stat.i.node-stores
      4.01            +3.0%       4.13        perf-stat.overall.MPKI
      2.50            +6.8%       2.67        perf-stat.overall.cpi
      1606            +6.0%       1701        perf-stat.overall.cycles-between-cache-misses
      0.05 ±  3%      -0.0        0.04 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
      0.40            -6.4%       0.38        perf-stat.overall.ipc
     38.94            +1.6       40.51        perf-stat.overall.node-store-miss-rate%
 5.242e+09            -2.6%  5.105e+09        perf-stat.ps.branch-instructions
  60941850            -3.9%   58557696        perf-stat.ps.branch-misses
  38615124            -1.7%   37976567        perf-stat.ps.cache-misses
   1580007            -6.3%    1479894        perf-stat.ps.context-switches
 6.202e+10            +4.2%  6.462e+10        perf-stat.ps.cpu-cycles
      3547           -12.0%       3120 ±  3%  perf-stat.ps.cpu-migrations
   2977065 ±  3%      -8.8%    2716443 ±  2%  perf-stat.ps.dTLB-load-misses
 6.214e+09            -2.5%  6.061e+09        perf-stat.ps.dTLB-loads
    337701            -8.6%     308807        perf-stat.ps.dTLB-store-misses
 3.083e+09            -6.6%  2.881e+09        perf-stat.ps.dTLB-stores
 2.485e+10            -2.5%  2.424e+10        perf-stat.ps.instructions
   7978706            +2.2%    8157706        perf-stat.ps.node-store-misses
  12509147            -4.2%   11980867        perf-stat.ps.node-stores
  1.56e+12            -2.1%  1.527e+12        perf-stat.total.instructions
     26.65            -2.5       24.11        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     26.20            -2.5       23.74        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     26.22            -2.5       23.75        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     26.17            -2.5       23.71        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     17.21            -1.8       15.41        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     16.22            -1.7       14.49        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     12.35            -1.7       10.63        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     16.05            -1.7       14.35        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      4.93            -1.5        3.47 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise
     10.37            -1.2        9.14        perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.76            -0.6        4.15        perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.99 ±  3%      -0.4        3.56 ±  3%  perf-profile.calltrace.cycles-pp.read
      3.96 ±  3%      -0.4        3.54 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      3.96 ±  3%      -0.4        3.53 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.94 ±  3%      -0.4        3.52 ±  3%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.91 ±  3%      -0.4        3.49 ±  3%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.96 ±  3%      -0.4        3.53 ±  3%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.90 ±  3%      -0.4        3.48 ±  3%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      3.52            -0.4        3.11        perf-profile.calltrace.cycles-pp.wake_up_q.rwsem_wake.up_write.do_madvise.__x64_sys_madvise
      3.21 ±  4%      -0.4        2.81 ±  4%  perf-profile.calltrace.cycles-pp.show_smap.seq_read_iter.seq_read.vfs_read.ksys_read
      3.34            -0.4        2.95        perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.rwsem_wake.up_write.do_madvise
      2.89            -0.4        2.51        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      6.26            -0.4        5.89        perf-profile.calltrace.cycles-pp.rwsem_wake.up_write.do_madvise.__x64_sys_madvise.do_syscall_64
      2.72 ±  3%      -0.4        2.35 ±  5%  perf-profile.calltrace.cycles-pp.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range
      0.59 ±  2%      -0.3        0.25 ±100%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.wake_up_q.rwsem_wake
      4.37            -0.3        4.06        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.01            -0.2        1.76        perf-profile.calltrace.cycles-pp.__split_vma.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      0.58 ±  3%      -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.70            -0.2        1.46        perf-profile.calltrace.cycles-pp.madvise_pageout.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      0.58 ±  3%      -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.58 ±  2%      -0.2        0.36 ± 70%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.__get_user_pages.populate_vma_page_range
      0.58 ±  2%      -0.2        0.36 ± 70%  perf-profile.calltrace.cycles-pp.do_cow_fault.do_fault.__handle_mm_fault.handle_mm_fault.__get_user_pages
      1.69            -0.2        1.48        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      0.54 ±  2%      -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.rwsem_wake.up_read.do_madvise
      1.64 ±  2%      -0.2        1.44        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue.do_idle
      5.32            -0.2        5.13        perf-profile.calltrace.cycles-pp.down_read.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
      1.61 ±  2%      -0.2        1.41        perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue
      1.72            -0.2        1.53        perf-profile.calltrace.cycles-pp.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      1.50 ±  2%      -0.2        1.31        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      1.46            -0.2        1.27        perf-profile.calltrace.cycles-pp.vma_merge.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      1.30            -0.2        1.13        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      1.38            -0.2        1.21        perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.wake_up_q.rwsem_wake.up_write
      1.28            -0.2        1.11 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.60 ±  3%      -0.2        0.44 ± 44%  perf-profile.calltrace.cycles-pp.shrink_folio_list.reclaim_folio_list.reclaim_pages.madvise_cold_or_pageout_pte_range.walk_pmd_range
      1.16            -0.2        1.01        perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.wake_up_q.rwsem_wake
      0.60 ±  2%      -0.2        0.45 ± 44%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff
      0.60 ±  2%      -0.1        0.45 ± 44%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__get_user_pages.populate_vma_page_range.__mm_populate
      1.13            -0.1        0.99 ±  2%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      0.92 ±  2%      -0.1        0.78 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read.__do_sys_msync
      1.05            -0.1        0.92        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise
      0.84 ±  3%      -0.1        0.72        perf-profile.calltrace.cycles-pp.madvise_cold.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      1.04 ±  2%      -0.1        0.91        perf-profile.calltrace.cycles-pp.walk_page_range.madvise_pageout.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      0.95 ±  2%      -0.1        0.83        perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single
      0.99 ±  2%      -0.1        0.87        perf-profile.calltrace.cycles-pp.__walk_page_range.walk_page_range.madvise_pageout.madvise_vma_behavior.do_madvise
      0.96 ±  2%      -0.1        0.84        perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior
      6.60            -0.1        6.48        perf-profile.calltrace.cycles-pp.up_write.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.98 ±  2%      -0.1        0.87        perf-profile.calltrace.cycles-pp.walk_pgd_range.__walk_page_range.walk_page_range.madvise_pageout.madvise_vma_behavior
      0.97 ±  2%      -0.1        0.86        perf-profile.calltrace.cycles-pp.find_vma_prev.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.92 ±  2%      -0.1        0.81        perf-profile.calltrace.cycles-pp.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_range.madvise_pageout
      0.91 ±  2%      -0.1        0.80        perf-profile.calltrace.cycles-pp.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range
      0.77 ±  2%      -0.1        0.66        perf-profile.calltrace.cycles-pp.llist_add_batch.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.wake_up_q
      0.92 ±  2%      -0.1        0.81        perf-profile.calltrace.cycles-pp.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_range
      0.69            -0.1        0.58        perf-profile.calltrace.cycles-pp.update_rq_clock_task.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      1.07 ±  2%      -0.1        0.97 ±  3%  perf-profile.calltrace.cycles-pp.__mmap
      0.82 ±  2%      -0.1        0.72        perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.do_madvise.__x64_sys_madvise.do_syscall_64
      1.07 ±  2%      -0.1        0.97 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      1.07 ±  2%      -0.1        0.97 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.79 ±  2%      -0.1        0.69        perf-profile.calltrace.cycles-pp.llist_reverse_order.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      1.09 ±  3%      -0.1        1.00 ±  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.61 ±  2%      -0.1        0.52        perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.wake_up_q.rwsem_wake.up_write
      0.76 ±  3%      -0.1        0.67        perf-profile.calltrace.cycles-pp.mtree_range_walk.mas_walk.find_vma_prev.do_madvise.__x64_sys_madvise
      1.05 ±  3%      -0.1        0.96 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.73 ±  2%      -0.1        0.64 ±  2%  perf-profile.calltrace.cycles-pp.wake_q_add.rwsem_mark_wake.rwsem_wake.up_write.do_madvise
      0.64 ±  2%      -0.1        0.56 ±  2%  perf-profile.calltrace.cycles-pp.reclaim_pages.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range.walk_p4d_range
      0.60 ±  2%      -0.1        0.52 ±  2%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.madvise_vma_behavior.do_madvise
      1.70            -0.1        1.63        perf-profile.calltrace.cycles-pp.rwsem_mark_wake.rwsem_wake.up_write.do_madvise.__x64_sys_madvise
      0.61 ±  2%      -0.1        0.54 ±  2%  perf-profile.calltrace.cycles-pp.reclaim_folio_list.reclaim_pages.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range
      0.60 ±  3%      -0.1        0.53 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      0.60 ±  3%      -0.1        0.53 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.60 ±  3%      -0.1        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.60 ±  3%      -0.1        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.60 ±  3%      -0.1        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__munmap
      0.63 ±  2%      -0.1        0.56 ±  5%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.63 ±  2%      -0.1        0.56 ±  5%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.68            -0.1        0.62        perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.60 ±  3%      -0.1        0.54 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable
      0.62 ±  2%      -0.1        0.56 ±  4%  perf-profile.calltrace.cycles-pp.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.62 ±  2%      -0.1        0.56 ±  4%  perf-profile.calltrace.cycles-pp.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff
      0.62 ±  2%      -0.1        0.56 ±  4%  perf-profile.calltrace.cycles-pp.populate_vma_page_range.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.76 ±  2%      -0.1        0.70 ±  3%  perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      0.66 ±  3%      -0.0        0.62 ±  4%  perf-profile.calltrace.cycles-pp.madvise_free_single_vma.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      0.58 ±  2%      -0.0        0.54 ±  3%  perf-profile.calltrace.cycles-pp.wake_up_q.rwsem_wake.up_read.do_madvise.__x64_sys_madvise
      0.88            +0.1        0.94 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.do_madvise.__x64_sys_madvise.do_syscall_64
      1.23            +0.1        1.30        perf-profile.calltrace.cycles-pp.up_read.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.89            +0.1        1.98        perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise
      1.83            +0.1        1.92        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable
      1.88            +0.1        1.98        perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.do_madvise
      0.92 ±  3%      +0.1        1.02 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_write_slowpath.down_write_killable.do_madvise
      1.25            +0.1        1.36        perf-profile.calltrace.cycles-pp.down_read.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.65 ±  3%      +0.1        0.76        perf-profile.calltrace.cycles-pp.wake_up_q.rwsem_wake.up_read.__do_sys_msync.do_syscall_64
      0.55 ±  2%      +0.1        0.66        perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.rwsem_wake.up_read.__do_sys_msync
      1.45 ±  2%      +0.1        1.57 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise
      0.95            +0.1        1.08        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rwsem_wake.up_write.do_madvise.__x64_sys_madvise
      1.47            +0.2        1.62        perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      8.28            +0.2        8.47        perf-profile.calltrace.cycles-pp.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
      1.35 ±  2%      +0.2        1.58        perf-profile.calltrace.cycles-pp.rwsem_wake.up_read.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.28            +0.5        2.77        perf-profile.calltrace.cycles-pp.up_read.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
      0.00            +0.6        0.61 ±  2%  perf-profile.calltrace.cycles-pp.mm_cid_get.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00            +0.6        0.62 ±  2%  perf-profile.calltrace.cycles-pp.osq_unlock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise
     53.90            +3.8       57.74        perf-profile.calltrace.cycles-pp.__madvise
     53.26            +3.9       57.14        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
     53.18            +3.9       57.07        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     52.95            +3.9       56.85        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     52.99            +3.9       56.89        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     18.92            +4.0       22.89        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise
     25.94            +4.8       30.73        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise
     30.65            +5.3       35.96        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.do_madvise.__x64_sys_madvise.do_syscall_64
     31.48            +5.3       36.82        perf-profile.calltrace.cycles-pp.down_write_killable.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.65            -2.5       24.11        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     26.65            -2.5       24.11        perf-profile.children.cycles-pp.cpu_startup_entry
     26.62            -2.5       24.09        perf-profile.children.cycles-pp.do_idle
     26.22            -2.5       23.75        perf-profile.children.cycles-pp.start_secondary
     17.51            -1.9       15.66        perf-profile.children.cycles-pp.cpuidle_idle_call
     16.49            -1.8       14.72        perf-profile.children.cycles-pp.cpuidle_enter
     12.55            -1.8       10.79        perf-profile.children.cycles-pp.intel_idle
     16.41            -1.8       14.65        perf-profile.children.cycles-pp.cpuidle_enter_state
     10.67            -1.3        9.40        perf-profile.children.cycles-pp.madvise_vma_behavior
      4.48            -1.0        3.47        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      5.74            -0.7        5.04        perf-profile.children.cycles-pp.wake_up_q
      5.37            -0.7        4.70        perf-profile.children.cycles-pp.try_to_wake_up
      4.84            -0.6        4.22        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      3.68 ±  2%      -0.5        3.23 ±  3%  perf-profile.children.cycles-pp.walk_pgd_range
      3.70 ±  2%      -0.5        3.24 ±  3%  perf-profile.children.cycles-pp.__walk_page_range
      3.36 ±  3%      -0.4        2.92 ±  4%  perf-profile.children.cycles-pp.walk_pmd_range
      3.99 ±  3%      -0.4        3.56 ±  3%  perf-profile.children.cycles-pp.read
      3.40 ±  3%      -0.4        2.96 ±  4%  perf-profile.children.cycles-pp.walk_p4d_range
      3.38 ±  3%      -0.4        2.94 ±  4%  perf-profile.children.cycles-pp.walk_pud_range
      3.96 ±  3%      -0.4        3.53 ±  3%  perf-profile.children.cycles-pp.ksys_read
      3.95 ±  3%      -0.4        3.52 ±  3%  perf-profile.children.cycles-pp.vfs_read
      3.91 ±  3%      -0.4        3.49 ±  3%  perf-profile.children.cycles-pp.seq_read_iter
      3.91 ±  3%      -0.4        3.49 ±  3%  perf-profile.children.cycles-pp.seq_read
      3.22 ±  4%      -0.4        2.83 ±  4%  perf-profile.children.cycles-pp.show_smap
      2.68            -0.4        2.29        perf-profile.children.cycles-pp.tlb_finish_mmu
      3.07            -0.4        2.69        perf-profile.children.cycles-pp.sched_ttwu_pending
      2.71            -0.3        2.37        perf-profile.children.cycles-pp._raw_spin_lock
      2.48            -0.3        2.15        perf-profile.children.cycles-pp.flush_tlb_mm_range
      2.41            -0.3        2.10        perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      2.41            -0.3        2.10        perf-profile.children.cycles-pp.smp_call_function_many_cond
      2.50            -0.3        2.20        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      1.90            -0.3        1.64        perf-profile.children.cycles-pp.madvise_pageout
      2.13            -0.3        1.87        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      2.03 ±  2%      -0.2        1.78        perf-profile.children.cycles-pp.__split_vma
      5.57            -0.2        5.32        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      1.82            -0.2        1.61 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.78            -0.2        1.56        perf-profile.children.cycles-pp.__smp_call_single_queue
      1.48            -0.2        1.26        perf-profile.children.cycles-pp.llist_add_batch
      1.88 ±  2%      -0.2        1.66        perf-profile.children.cycles-pp.walk_page_range
      1.75            -0.2        1.54        perf-profile.children.cycles-pp.activate_task
      1.71            -0.2        1.51        perf-profile.children.cycles-pp.enqueue_task_fair
      1.72            -0.2        1.53        perf-profile.children.cycles-pp.zap_page_range_single
      1.62            -0.2        1.42        perf-profile.children.cycles-pp.enqueue_entity
      1.66 ±  2%      -0.2        1.47        perf-profile.children.cycles-pp.asm_sysvec_call_function
      1.47            -0.2        1.29        perf-profile.children.cycles-pp.vma_merge
      1.43 ±  2%      -0.2        1.25        perf-profile.children.cycles-pp.mtree_range_walk
      1.52 ±  2%      -0.2        1.34 ±  2%  perf-profile.children.cycles-pp.wake_q_add
      1.36 ±  2%      -0.2        1.19        perf-profile.children.cycles-pp.madvise_cold_or_pageout_pte_range
      1.32 ±  3%      -0.2        1.16        perf-profile.children.cycles-pp.sysvec_call_function
      2.83            -0.2        2.68        perf-profile.children.cycles-pp.rwsem_mark_wake
      7.26            -0.2        7.10        perf-profile.children.cycles-pp.up_write
      1.22            -0.2        1.07        perf-profile.children.cycles-pp.llist_reverse_order
      8.76            -0.2        8.61        perf-profile.children.cycles-pp.rwsem_wake
      1.20 ±  3%      -0.2        1.05        perf-profile.children.cycles-pp.__sysvec_call_function
      0.97            -0.1        0.82 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.23 ±  2%      -0.1        1.08 ±  3%  perf-profile.children.cycles-pp.handle_mm_fault
      1.22 ±  2%      -0.1        1.07 ±  2%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.88            -0.1        0.74 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
      0.92 ±  3%      -0.1        0.78        perf-profile.children.cycles-pp.madvise_cold
      0.92 ±  2%      -0.1        0.79 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      1.88 ±  2%      -0.1        1.75 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.92 ±  2%      -0.1        0.79        perf-profile.children.cycles-pp.select_task_rq
      0.72 ±  3%      -0.1        0.60 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.74 ±  2%      -0.1        1.62 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.06 ±  4%      -0.1        0.94 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.56 ±  2%      -0.1        0.44 ±  3%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.46 ±  3%      -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.__list_add_valid
      0.98            -0.1        0.86 ±  3%  perf-profile.children.cycles-pp.__do_softirq
      0.91            -0.1        0.80 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.79            -0.1        0.68 ±  4%  perf-profile.children.cycles-pp.rcu_core
      0.75            -0.1        0.63 ±  4%  perf-profile.children.cycles-pp.rcu_do_batch
      0.98 ±  2%      -0.1        0.86        perf-profile.children.cycles-pp.find_vma_prev
      0.86 ±  2%      -0.1        0.75        perf-profile.children.cycles-pp.mas_walk
      0.76            -0.1        0.65        perf-profile.children.cycles-pp.mt_find
      0.80            -0.1        0.70 ±  2%  perf-profile.children.cycles-pp.mas_store_prealloc
      1.00 ±  2%      -0.1        0.89 ±  3%  perf-profile.children.cycles-pp.__mm_populate
      0.81            -0.1        0.70        perf-profile.children.cycles-pp.update_rq_clock_task
      0.99 ±  2%      -0.1        0.89 ±  3%  perf-profile.children.cycles-pp.__get_user_pages
      0.99 ±  2%      -0.1        0.89 ±  3%  perf-profile.children.cycles-pp.populate_vma_page_range
      0.66 ±  2%      -0.1        0.55        perf-profile.children.cycles-pp.find_vma
      1.08 ±  2%      -0.1        0.97 ±  3%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      1.07 ±  2%      -0.1        0.97 ±  3%  perf-profile.children.cycles-pp.__mmap
      0.74 ±  2%      -0.1        0.64 ±  2%  perf-profile.children.cycles-pp.available_idle_cpu
      0.40 ±  9%      -0.1        0.30 ± 12%  perf-profile.children.cycles-pp.zap_pmd_range
      0.75 ±  2%      -0.1        0.65        perf-profile.children.cycles-pp.wake_affine
      0.75 ±  2%      -0.1        0.66        perf-profile.children.cycles-pp.default_send_IPI_mask_sequence_phys
      0.44 ±  9%      -0.1        0.35 ± 11%  perf-profile.children.cycles-pp.unmap_page_range
      0.78 ±  2%      -0.1        0.69 ±  3%  perf-profile.children.cycles-pp.reclaim_pages
      0.38 ± 10%      -0.1        0.29 ± 13%  perf-profile.children.cycles-pp.zap_pte_range
      0.76 ±  2%      -0.1        0.67 ±  3%  perf-profile.children.cycles-pp.reclaim_folio_list
      0.60 ±  3%      -0.1        0.51 ±  2%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.59 ±  3%      -0.1        0.51 ±  2%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.71            -0.1        0.63 ±  4%  perf-profile.children.cycles-pp.shrink_folio_list
      0.66 ±  2%      -0.1        0.59        perf-profile.children.cycles-pp.seq_put_decimal_ull_width
      0.45 ±  3%      -0.1        0.37 ±  7%  perf-profile.children.cycles-pp.ret_from_fork
      0.61 ±  3%      -0.1        0.53 ±  2%  perf-profile.children.cycles-pp.__x64_sys_munmap
      1.00 ±  2%      -0.1        0.92 ±  2%  perf-profile.children.cycles-pp.vma_complete
      0.61 ±  3%      -0.1        0.53 ±  2%  perf-profile.children.cycles-pp.__vm_munmap
      0.18 ± 22%      -0.1        0.10 ± 43%  perf-profile.children.cycles-pp.unmap_vmas
      0.44 ±  3%      -0.1        0.37 ±  7%  perf-profile.children.cycles-pp.kthread
      0.61 ±  3%      -0.1        0.53 ±  2%  perf-profile.children.cycles-pp.__munmap
      0.62 ±  2%      -0.1        0.55 ±  4%  perf-profile.children.cycles-pp.do_fault
      0.77 ±  2%      -0.1        0.70 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.41 ±  2%      -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.anon_vma_clone
      0.64 ±  2%      -0.1        0.56 ±  4%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.61 ±  2%      -0.1        0.54        perf-profile.children.cycles-pp.__default_send_IPI_dest_field
      0.43 ±  3%      -0.1        0.37 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.49 ±  2%      -0.1        0.42 ±  2%  perf-profile.children.cycles-pp.stress_mwc64
      0.45 ±  3%      -0.1        0.38 ±  4%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.60 ±  2%      -0.1        0.53 ±  4%  perf-profile.children.cycles-pp.do_cow_fault
      0.70            -0.1        0.64        perf-profile.children.cycles-pp.menu_select
      0.34 ±  3%      -0.1        0.28 ±  8%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.92 ±  3%      -0.1        0.86 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.53 ±  4%      -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.flush_tlb_func
      0.15 ±  4%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.__task_rq_lock
      0.61 ±  2%      -0.1        0.55        perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.37 ±  4%      -0.1        0.31 ±  2%  perf-profile.children.cycles-pp.vma_prepare
      0.36 ±  2%      -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.stress_mwc32
      0.53 ±  2%      -0.1        0.47        perf-profile.children.cycles-pp.__show_smap
      0.91 ±  2%      -0.1        0.86 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.41 ±  2%      -0.1        0.36 ±  2%  perf-profile.children.cycles-pp.native_sched_clock
      0.36 ±  4%      -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.36 ±  3%      -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.mas_preallocate
      0.30 ±  4%      -0.1        0.25 ±  8%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.52 ±  2%      -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
      0.42 ±  3%      -0.1        0.37 ±  4%  perf-profile.children.cycles-pp.clear_page_erms
      0.30 ±  2%      -0.1        0.25 ±  3%  perf-profile.children.cycles-pp.release_pages
      0.54            -0.1        0.48        perf-profile.children.cycles-pp.open64
      0.28 ±  3%      -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.52            -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.34 ±  2%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.down_write
      0.27 ±  5%      -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.39 ±  3%      -0.0        0.34 ±  4%  perf-profile.children.cycles-pp.__do_huge_pmd_anonymous_page
      0.32 ±  3%      -0.0        0.27        perf-profile.children.cycles-pp.unmap_region
      0.41            -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.39 ±  3%      -0.0        0.34 ±  4%  perf-profile.children.cycles-pp.clear_huge_page
      0.31 ±  3%      -0.0        0.26 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
      0.31 ±  3%      -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.folio_referenced
      0.34 ±  4%      -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.43 ±  2%      -0.0        0.39 ±  2%  perf-profile.children.cycles-pp.do_filp_open
      0.45 ±  3%      -0.0        0.41 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.34 ±  4%      -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.lru_add_drain
      0.28 ±  2%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.mas_wr_modify
      0.34 ±  2%      -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.rmap_walk_anon
      0.28 ±  3%      -0.0        0.24 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.33 ±  3%      -0.0        0.29 ±  4%  perf-profile.children.cycles-pp.__entry_text_start
      0.43 ±  2%      -0.0        0.38 ±  3%  perf-profile.children.cycles-pp.path_openat
      0.28 ±  6%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.update_cfs_group
      0.29 ±  6%      -0.0        0.25 ±  9%  perf-profile.children.cycles-pp.exc_page_fault
      0.29 ±  6%      -0.0        0.25 ±  9%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.62 ±  3%      -0.0        0.57 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      0.46            -0.0        0.42 ±  2%  perf-profile.children.cycles-pp.smaps_account
      0.36 ±  4%      -0.0        0.32        perf-profile.children.cycles-pp.seq_puts
      0.26 ±  4%      -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.28 ±  2%      -0.0        0.24 ±  4%  perf-profile.children.cycles-pp.__do_sys_process_madvise
      0.26 ±  6%      -0.0        0.23 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.29            -0.0        0.26 ±  4%  perf-profile.children.cycles-pp.vm_area_dup
      0.27            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.25 ±  4%      -0.0        0.21 ±  6%  perf-profile.children.cycles-pp.___perf_sw_event
      0.28 ±  2%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.syscall
      0.27 ±  4%      -0.0        0.23 ±  5%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.30 ±  5%      -0.0        0.27 ±  5%  perf-profile.children.cycles-pp.show_map_vma
      0.23 ±  4%      -0.0        0.20 ±  9%  perf-profile.children.cycles-pp.pthread_create@@GLIBC_2.2.5
      0.17 ±  4%      -0.0        0.14        perf-profile.children.cycles-pp.__anon_vma_interval_tree_subtree_search
      0.23 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.num_to_str
      0.30            -0.0        0.27 ±  4%  perf-profile.children.cycles-pp.kmem_cache_free
      0.29 ±  3%      -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.down_read_killable
      0.19 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.24 ±  4%      -0.0        0.21 ±  5%  perf-profile.children.cycles-pp.mas_split
      0.18 ±  2%      -0.0        0.16 ±  6%  perf-profile.children.cycles-pp.stress_madvise_pages
      0.26 ±  4%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.28            -0.0        0.25 ±  6%  perf-profile.children.cycles-pp.update_curr
      0.22 ±  3%      -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.19 ±  3%      -0.0        0.16 ±  7%  perf-profile.children.cycles-pp.folio_alloc_swap
      0.30 ±  2%      -0.0        0.27 ±  5%  perf-profile.children.cycles-pp.copy_page
      0.24 ±  4%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.22 ±  4%      -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.mtree_load
      0.19 ±  3%      -0.0        0.17 ±  7%  perf-profile.children.cycles-pp.add_to_swap
      0.16 ±  3%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.mas_destroy
      0.14 ±  4%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__mem_cgroup_try_charge_swap
      0.22 ±  3%      -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.14 ±  3%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.folio_isolate_lru
      0.19 ±  4%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.strlen
      0.48 ±  3%      -0.0        0.46 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      0.26 ±  3%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.11 ±  6%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.tlb_gather_mmu
      0.09 ±  4%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.free_unref_page
      0.14 ±  3%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.memcg_memory_event
      0.14 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.kernel_clone
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.can_vma_merge_before
      0.06 ±  7%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.__rb_erase_color
      0.18 ±  4%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.free_pgtables
      0.15 ±  3%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__clone
      0.13 ±  2%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
      0.12 ±  5%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__alloc_file
      0.24 ±  2%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.__switch_to_asm
      0.17 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__do_sys_clone
      0.10 ±  5%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.12 ±  4%      -0.0        0.11 ±  9%  perf-profile.children.cycles-pp.stress_mwc64modn
      0.09 ±  6%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.08 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.os_xsave
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__unfreeze_partials
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.dup_task_struct
      0.10 ±  5%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.mas_descend_adopt
      0.13 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.15 ±  3%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.08 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.lookup_fast
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.29 ±  4%      +0.0        0.33 ±  3%  perf-profile.children.cycles-pp.poll_idle
      1.60            +0.1        1.75        perf-profile.children.cycles-pp.intel_idle_irq
      8.30            +0.2        8.48        perf-profile.children.cycles-pp.__do_sys_msync
      2.88            +0.2        3.07        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.42 ±  3%      +0.2        0.63 ±  2%  perf-profile.children.cycles-pp.osq_unlock
      0.40 ±  2%      +0.2        0.63 ±  2%  perf-profile.children.cycles-pp.mm_cid_get
      2.46            +0.3        2.71        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.75            +0.3        1.05        perf-profile.children.cycles-pp.finish_task_switch
      3.84            +0.6        4.40        perf-profile.children.cycles-pp.up_read
     68.93            +3.2       72.16        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     68.78            +3.2       72.03        perf-profile.children.cycles-pp.do_syscall_64
     54.04            +3.8       57.86        perf-profile.children.cycles-pp.__madvise
     53.27            +3.9       57.13        perf-profile.children.cycles-pp.do_madvise
     53.00            +3.9       56.89        perf-profile.children.cycles-pp.__x64_sys_madvise
     19.07            +4.0       23.06        perf-profile.children.cycles-pp.osq_lock
     26.60            +4.7       31.35        perf-profile.children.cycles-pp.rwsem_optimistic_spin
     30.77            +5.3       36.11        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     31.58            +5.4       36.95        perf-profile.children.cycles-pp.down_write_killable
     12.55            -1.8       10.79        perf-profile.self.cycles-pp.intel_idle
      3.82 ±  2%      -0.9        2.92        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      2.50            -0.3        2.20        perf-profile.self.cycles-pp._raw_spin_lock
      1.44            -0.2        1.23        perf-profile.self.cycles-pp.llist_add_batch
      1.40            -0.2        1.22        perf-profile.self.cycles-pp.mtree_range_walk
      1.51 ±  2%      -0.2        1.34        perf-profile.self.cycles-pp.wake_q_add
      1.22            -0.2        1.06        perf-profile.self.cycles-pp.llist_reverse_order
      0.97 ±  2%      -0.1        0.83 ±  2%  perf-profile.self.cycles-pp.do_madvise
      1.00 ±  2%      -0.1        0.88        perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.56 ±  3%      -0.1        0.43 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.45 ±  2%      -0.1        0.33 ±  2%  perf-profile.self.cycles-pp.__list_add_valid
      0.81 ±  2%      -0.1        0.71        perf-profile.self.cycles-pp.enqueue_entity
      0.76            -0.1        0.67        perf-profile.self.cycles-pp.update_rq_clock_task
      0.73 ±  2%      -0.1        0.63 ±  2%  perf-profile.self.cycles-pp.available_idle_cpu
      0.81 ±  2%      -0.1        0.71 ±  2%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.73 ±  2%      -0.1        0.64        perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.85            -0.1        0.77 ±  2%  perf-profile.self.cycles-pp.madvise_vma_behavior
      0.61            -0.1        0.54        perf-profile.self.cycles-pp.__default_send_IPI_dest_field
      0.43 ±  3%      -0.1        0.36 ±  4%  perf-profile.self.cycles-pp.__slab_free
      0.47 ±  2%      -0.1        0.40        perf-profile.self.cycles-pp.stress_mwc64
      0.60            -0.1        0.55 ±  2%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.35 ±  3%      -0.1        0.29 ±  3%  perf-profile.self.cycles-pp.stress_mwc32
      0.41 ±  4%      -0.1        0.36 ±  4%  perf-profile.self.cycles-pp.clear_page_erms
      0.39 ±  2%      -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
      0.27 ±  6%      -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.33 ±  2%      -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.down_write
      0.44 ±  3%      -0.0        0.39 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.32 ±  5%      -0.0        0.28 ±  3%  perf-profile.self.cycles-pp.flush_tlb_func
      0.19 ±  3%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.dequeue_entity
      0.27 ±  7%      -0.0        0.23        perf-profile.self.cycles-pp.update_cfs_group
      0.33 ±  2%      -0.0        0.30        perf-profile.self.cycles-pp.vma_merge
      0.26 ±  6%      -0.0        0.22 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.31 ±  3%      -0.0        0.28 ±  3%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.46            -0.0        0.42 ±  2%  perf-profile.self.cycles-pp.menu_select
      0.22 ±  4%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.mtree_load
      0.17 ±  4%      -0.0        0.14 ±  7%  perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.22 ±  4%      -0.0        0.19 ±  5%  perf-profile.self.cycles-pp.___perf_sw_event
      0.30 ±  3%      -0.0        0.27 ±  6%  perf-profile.self.cycles-pp.copy_page
      0.26 ±  4%      -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.38 ±  2%      -0.0        0.35 ±  3%  perf-profile.self.cycles-pp.wake_up_q
      0.29 ±  3%      -0.0        0.26 ±  4%  perf-profile.self.cycles-pp.smaps_account
      0.20 ±  2%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      0.16 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_subtree_search
      0.07 ±  5%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__task_rq_lock
      0.18 ±  5%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.__do_sys_msync
      0.14 ±  3%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp.can_vma_merge_before
      0.23 ±  2%      -0.0        0.21 ±  4%  perf-profile.self.cycles-pp.kmem_cache_free
      0.11 ±  6%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.18 ±  4%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.strlen
      0.28 ±  3%      -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.walk_pgd_range
      0.17 ±  4%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.msync
      0.15 ±  3%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.stress_madvise_pages
      0.13 ±  4%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.tlb_gather_mmu
      0.21 ±  3%      -0.0        0.19 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.18 ±  4%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.__madvise
      0.18 ±  3%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.num_to_str
      0.14 ±  3%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.12 ±  5%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.__entry_text_start
      0.10 ±  3%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.vma_complete
      0.09 ±  5%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.06 ±  6%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.format_decode
      0.12 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.zap_pte_range
      0.09 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free_bulk
      0.08 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.os_xsave
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.mas_walk
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.read_tsc
      0.08 ±  6%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.cpuidle_enter
      0.26 ±  5%      +0.0        0.30 ±  4%  perf-profile.self.cycles-pp.poll_idle
      0.96 ±  2%      +0.1        1.06        perf-profile.self.cycles-pp.rwsem_mark_wake
      1.06            +0.1        1.18 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.42            +0.2        1.57        perf-profile.self.cycles-pp.intel_idle_irq
      1.33 ±  2%      +0.2        1.49 ±  2%  perf-profile.self.cycles-pp.down_read
      0.99            +0.2        1.15 ±  2%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.40 ±  3%      +0.2        0.61 ±  2%  perf-profile.self.cycles-pp.osq_unlock
      0.96 ±  2%      +0.2        1.17        perf-profile.self.cycles-pp.up_write
      0.78 ±  2%      +0.2        1.00 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.39 ±  2%      +0.2        0.62 ±  2%  perf-profile.self.cycles-pp.mm_cid_get
      0.48 ±  2%      +0.3        0.78 ±  2%  perf-profile.self.cycles-pp.finish_task_switch
      1.35            +0.3        1.68        perf-profile.self.cycles-pp.up_read
      0.53 ±  2%      +0.4        0.92 ±  3%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      2.97            +1.5        4.47        perf-profile.self.cycles-pp.rwsem_optimistic_spin
     18.35            +4.0       22.39        perf-profile.self.cycles-pp.osq_lock


***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/50%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/context_switch1/will-it-scale

commit: 
  025b7799b3 ("mm/memcg: remove return value of mem_cgroup_scan_tasks()")
  c1753fd02a ("mm: move mm_count into its own cache line")

025b7799b35d32e4 c1753fd02a0058ea43cbb31ab26 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 2.977e+09 ±  5%     -34.9%  1.937e+09 ±  9%  cpuidle..time
  1.57e+09 ±  2%     +92.4%  3.022e+09 ± 10%  cpuidle..usage
   3038432 ± 20%     +43.2%    4349518 ±  3%  meminfo.Active
   3037608 ± 20%     +43.2%    4348692 ±  3%  meminfo.Active(anon)
   2988708 ± 20%     +44.6%    4320355 ±  3%  numa-meminfo.node1.Active
   2988570 ± 20%     +44.5%    4319945 ±  3%  numa-meminfo.node1.Active(anon)
    747629 ± 20%     +44.2%    1078438 ±  3%  numa-vmstat.node1.nr_active_anon
    747628 ± 20%     +44.2%    1078437 ±  3%  numa-vmstat.node1.nr_zone_active_anon
     12.00           +58.3%      19.00 ±  3%  vmstat.cpu.us
  10422399 ±  2%     +93.6%   20172635 ±  9%  vmstat.system.cs
    145941 ±  2%     +72.6%     251898 ± 12%  vmstat.system.in
     22.53 ±  3%      +3.0       25.50 ±  5%  mpstat.cpu.all.idle%
      0.09            +0.0        0.11 ±  2%  mpstat.cpu.all.soft%
     63.71           -10.2       53.49 ±  3%  mpstat.cpu.all.sys%
     12.32            +7.2       19.54 ±  2%  mpstat.cpu.all.usr%
      1206 ± 11%     -73.1%     324.67 ± 34%  perf-c2c.DRAM.remote
      5740 ± 12%     -34.8%       3744 ± 35%  perf-c2c.HITM.local
      1077 ±  7%     -75.8%     261.00 ± 36%  perf-c2c.HITM.remote
      6818 ± 11%     -41.3%       4005 ± 35%  perf-c2c.HITM.total
   5340158 ±  2%     +92.2%   10261925 ±  9%  will-it-scale.52.threads
     21.82 ±  3%     +15.4%      25.18 ±  4%  will-it-scale.52.threads_idle
    102694 ±  2%     +92.2%     197344 ±  9%  will-it-scale.per_thread_ops
   5340158 ±  2%     +92.2%   10261925 ±  9%  will-it-scale.workload
    758948 ± 19%     +43.3%    1087255 ±  3%  proc-vmstat.nr_active_anon
    758948 ± 19%     +43.3%    1087255 ±  3%  proc-vmstat.nr_zone_active_anon
     29851 ± 53%     -50.7%      14723 ± 37%  proc-vmstat.numa_pages_migrated
    887090 ±  2%      -3.0%     860349        proc-vmstat.pgfree
     29851 ± 53%     -50.7%      14723 ± 37%  proc-vmstat.pgmigrate_success
     45860 ± 17%     -21.2%      36152        proc-vmstat.pgreuse
 1.425e+08 ± 22%     -99.2%    1205856 ± 23%  turbostat.C1
      1.44 ± 30%      -1.4        0.01        turbostat.C1%
     19609 ±  4%     -20.9%      15503 ±  4%  turbostat.C1E
      1.29 ±  8%     -52.6%       0.61 ± 20%  turbostat.CPU%c1
      0.06 ±  6%     +80.0%       0.10 ± 10%  turbostat.IPC
  44599035 ±  2%     +72.0%   76689229 ± 11%  turbostat.IRQ
      2.23 ± 34%     +82.2       84.46 ± 42%  turbostat.PKG_%
 1.428e+09 ±  3%    +111.6%  3.021e+09 ± 10%  turbostat.POLL
      6.94 ±  5%      -1.5        5.44 ±  9%  turbostat.POLL%
    341.57            +9.5%     374.18        turbostat.PkgWatt
     49.88 ± 43%    +191.6%     145.46 ± 39%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.09 ± 67%     -93.2%       0.01 ±115%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      8.05 ± 20%     +74.7%      14.07 ± 19%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1006           +66.5%       1677 ± 28%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     83.24 ± 35%     -88.7%       9.37 ±104%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.11 ±  7%     -18.0%       0.09 ±  4%  perf-sched.total_wait_and_delay.average.ms
      0.09 ±  6%     -18.6%       0.08 ±  4%  perf-sched.total_wait_time.average.ms
     11.71 ±  5%     +15.5%      13.52 ±  3%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    227.71 ± 21%    +104.6%     465.98 ± 34%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     22.61 ± 12%     +54.6%      34.97 ± 17%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      7.17 ± 16%     -25.6%       5.33 ± 17%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    344.00 ±  6%     -28.1%     247.17 ± 17%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     11.70 ±  5%     +15.4%      13.49 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.01 ±  7%     -35.4%       0.01 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.11 ± 58%     -77.4%       0.02 ± 73%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     14.56 ±  8%     +43.5%      20.90 ± 15%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    143477 ± 25%     +82.2%     261348 ± 21%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   3910496           +13.9%    4454795        sched_debug.cfs_rq:/.MIN_vruntime.max
    702315 ± 13%     +42.3%     999495 ±  9%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      0.56 ±  3%     +15.7%       0.65        sched_debug.cfs_rq:/.h_nr_running.avg
      2.03 ± 16%     -64.4%       0.72 ± 17%  sched_debug.cfs_rq:/.load_avg.min
    143477 ± 25%     +82.2%     261348 ± 21%  sched_debug.cfs_rq:/.max_vruntime.avg
   3910496           +13.9%    4454795        sched_debug.cfs_rq:/.max_vruntime.max
    702315 ± 13%     +42.3%     999495 ±  9%  sched_debug.cfs_rq:/.max_vruntime.stddev
   3851680           +11.0%    4274174 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
   4306537 ±  3%     +16.8%    5029214 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
   3775558           +11.0%    4192147 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
      0.52 ±  4%     +23.9%       0.65 ±  2%  sched_debug.cfs_rq:/.nr_running.avg
    287.94 ± 18%     -33.2%     192.31 ± 24%  sched_debug.cfs_rq:/.runnable_avg.min
    487424 ± 29%     +56.9%     764659 ± 12%  sched_debug.cfs_rq:/.spread0.max
    287.56 ± 18%     -33.3%     191.75 ± 25%  sched_debug.cfs_rq:/.util_avg.min
    255.12           -12.8%     222.50 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      5659 ±  4%     -31.2%       3894 ± 16%  sched_debug.cpu.avg_idle.min
  15164704 ±  2%     +91.0%   28964322 ±  9%  sched_debug.cpu.nr_switches.avg
  17539538 ±  4%     +80.6%   31675457 ±  5%  sched_debug.cpu.nr_switches.max
  12443131 ±  7%     +75.7%   21858035 ± 10%  sched_debug.cpu.nr_switches.min
      3.02 ± 15%     -46.6%       1.61 ± 34%  perf-stat.i.MPKI
 1.174e+10 ±  2%     +84.1%  2.161e+10 ±  9%  perf-stat.i.branch-instructions
 1.955e+08 ±  2%     +87.9%  3.675e+08 ±  9%  perf-stat.i.branch-misses
  10542460 ±  2%     +93.3%   20374987 ±  9%  perf-stat.i.context-switches
      5.10 ±  2%     -45.9%       2.76 ± 11%  perf-stat.i.cpi
      1122            +7.0%       1201        perf-stat.i.cpu-migrations
      0.10 ±  4%      -0.0        0.08 ±  3%  perf-stat.i.dTLB-load-miss-rate%
  15805396 ±  4%     +53.4%   24253313 ±  8%  perf-stat.i.dTLB-load-misses
 1.605e+10 ±  2%     +85.5%  2.976e+10 ±  9%  perf-stat.i.dTLB-loads
      0.00 ± 19%      -0.0        0.00 ± 15%  perf-stat.i.dTLB-store-miss-rate%
 9.617e+09 ±  2%     +87.0%  1.798e+10 ±  9%  perf-stat.i.dTLB-stores
     29.32 ±  7%     +14.8       44.12        perf-stat.i.iTLB-load-miss-rate%
   9215863 ±  2%    +157.5%   23727570 ± 11%  perf-stat.i.iTLB-load-misses
  22498612 ± 10%     +33.1%   29949386 ±  9%  perf-stat.i.iTLB-loads
 5.759e+10 ±  2%     +84.4%  1.062e+11 ±  9%  perf-stat.i.instructions
      6285           -26.1%       4644 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.20 ±  2%     +84.2%       0.37 ±  9%  perf-stat.i.ipc
    361.06 ±  2%     +85.1%     668.26 ±  9%  perf-stat.i.metric.M/sec
   2377201 ± 11%     -70.7%     695789 ± 47%  perf-stat.i.node-load-misses
   2206925 ± 27%     -35.5%    1424414 ± 14%  perf-stat.i.node-loads
     89.11            +5.5       94.64        perf-stat.i.node-store-miss-rate%
   1638034 ±  3%    +104.2%    3345555 ±  4%  perf-stat.i.node-store-misses
      1.67            +0.0        1.70        perf-stat.overall.branch-miss-rate%
      4.98 ±  2%     -45.1%       2.73 ± 11%  perf-stat.overall.cpi
      0.10 ±  4%      -0.0        0.08 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  4%      -0.0        0.00 ± 15%  perf-stat.overall.dTLB-store-miss-rate%
     29.21 ±  7%     +15.0       44.16        perf-stat.overall.iTLB-load-miss-rate%
      6249           -28.2%       4489 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.20 ±  2%     +84.1%       0.37 ±  9%  perf-stat.overall.ipc
     52.35 ± 11%     -21.1       31.22 ± 41%  perf-stat.overall.node-load-miss-rate%
     87.49            +6.4       93.90        perf-stat.overall.node-store-miss-rate%
   3258006            -4.3%    3117902        perf-stat.overall.path-length
  1.17e+10 ±  2%     +84.1%  2.154e+10 ±  9%  perf-stat.ps.branch-instructions
 1.949e+08 ±  2%     +87.9%  3.662e+08 ±  9%  perf-stat.ps.branch-misses
  10507840 ±  2%     +93.2%   20306310 ±  9%  perf-stat.ps.context-switches
      1118            +7.2%       1198        perf-stat.ps.cpu-migrations
  15766322 ±  4%     +53.4%   24180917 ±  8%  perf-stat.ps.dTLB-load-misses
 1.599e+10 ±  2%     +85.5%  2.966e+10 ±  9%  perf-stat.ps.dTLB-loads
 9.586e+09 ±  2%     +87.0%  1.792e+10 ±  9%  perf-stat.ps.dTLB-stores
   9185838 ±  2%    +157.4%   23646171 ± 11%  perf-stat.ps.iTLB-load-misses
  22428693 ± 10%     +33.1%   29846727 ±  9%  perf-stat.ps.iTLB-loads
 5.741e+10 ±  2%     +84.4%  1.059e+11 ±  9%  perf-stat.ps.instructions
   2369252 ± 11%     -70.7%     693656 ± 47%  perf-stat.ps.node-load-misses
   2208271 ± 27%     -35.4%    1425540 ± 14%  perf-stat.ps.node-loads
   1632569 ±  3%    +104.3%    3334535 ±  4%  perf-stat.ps.node-store-misses
  1.74e+13 ±  2%     +83.8%  3.198e+13 ±  9%  perf-stat.total.instructions
     43.54           -15.9       27.69 ± 13%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
     43.66           -15.8       27.88 ± 13%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
     45.62           -11.1       34.56 ± 14%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.34            -9.2        0.10 ±223%  perf-profile.calltrace.cycles-pp.mm_cid_get.__schedule.schedule_idle.do_idle.cpu_startup_entry
     13.96            -9.0        4.95 ± 10%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
     14.10            -8.8        5.33 ± 10%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.33 ±  2%      -5.3        0.00        perf-profile.calltrace.cycles-pp.__switch_to.__schedule.schedule.pipe_read.vfs_read
     14.00            -4.8        9.18 ± 13%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.pipe_read.vfs_read
     34.74            -4.1       30.66 ±  7%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     35.28            -4.0       31.28 ±  7%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     34.91            -4.0       30.94 ±  7%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     34.92            -4.0       30.97 ±  7%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      8.80 ±  8%      -2.4        6.38 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      8.86 ±  8%      -2.4        6.50 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      6.58 ±  6%      -1.4        5.21 ±  9%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.26 ± 32%      -0.3        0.94 ± 10%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.56 ±  2%      +0.5        1.05 ± 10%  perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_write
      0.53 ±  2%      +0.5        1.02 ± 11%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.55            +0.5        1.04 ± 11%  perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_read
      0.75 ±  2%      +0.6        1.31 ± 10%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule_idle.do_idle
      0.67 ±  2%      +0.6        1.23 ± 10%  perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.77 ±  4%      +0.6        1.37 ±  9%  perf-profile.calltrace.cycles-pp.ktime_get.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary
      0.65 ±  2%      +0.6        1.26 ±  9%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.00            +0.7        0.70 ± 10%  perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00            +0.7        0.71 ± 11%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.25 ±  4%      +0.7        1.96 ± 10%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +0.7        0.72 ±  8%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      0.00            +0.7        0.73 ± 10%  perf-profile.calltrace.cycles-pp.update_load_avg.set_next_entity.pick_next_task_fair.__schedule.schedule_idle
      0.08 ±223%      +0.7        0.82 ± 10%  perf-profile.calltrace.cycles-pp.read_tsc.ktime_get.tick_nohz_idle_exit.do_idle.cpu_startup_entry
      0.08 ±223%      +0.8        0.85 ± 12%  perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.00            +0.8        0.81 ± 13%  perf-profile.calltrace.cycles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.87            +0.9        2.73 ± 10%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__libc_read
      0.00            +0.9        0.86 ± 13%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      1.41 ±  2%      +0.9        2.28 ± 10%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      0.00            +0.9        0.88 ± 14%  perf-profile.calltrace.cycles-pp.__switch_to_asm.__libc_read
      0.00            +0.9        0.91 ± 40%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.14 ±  2%      +0.9        2.06 ± 10%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
      3.38 ± 10%      +1.1        4.48 ± 10%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.41 ±  2%      +1.2        2.61 ± 10%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__libc_write
      1.84 ±  2%      +1.3        3.11 ± 11%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
      1.68 ±  3%      +1.4        3.08 ±  9%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      2.04 ±  2%      +1.4        3.44 ± 11%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
      1.71 ±  3%      +1.5        3.22 ± 10%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
      2.10 ±  2%      +1.6        3.66 ± 11%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
      2.08 ±  2%      +1.7        3.74 ±  9%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue
      2.28 ±  2%      +1.7        3.99 ± 11%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
      2.06 ±  3%      +1.8        3.85 ± 10%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
      2.15 ±  2%      +1.8        3.94 ± 11%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      2.13 ±  2%      +1.8        3.94 ±  9%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue.do_idle
      2.37 ±  2%      +2.0        4.42 ±  9%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      2.69 ±  2%      +2.3        4.95 ±  9%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      3.34 ±  2%      +2.4        5.76 ± 10%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.18            +2.4        5.62 ±  9%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +2.5        2.52 ± 71%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      0.17 ±141%      +2.9        3.07 ± 57%  perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.79 ±  2%      +3.2        6.98 ± 10%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      4.21 ±  2%      +3.5        7.66 ± 10%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      5.89            +4.4       10.34 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      6.76            +5.1       11.84 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
      9.19 ±  2%      +7.1       16.29 ± 10%  perf-profile.calltrace.cycles-pp.__libc_write
     57.78           -24.9       32.90 ± 10%  perf-profile.children.cycles-pp.__schedule
     43.69           -15.8       27.89 ± 13%  perf-profile.children.cycles-pp.schedule
     45.66           -11.0       34.66 ± 14%  perf-profile.children.cycles-pp.pipe_read
      9.45            -9.1        0.32 ± 59%  perf-profile.children.cycles-pp.mm_cid_get
     14.25            -8.9        5.40 ± 10%  perf-profile.children.cycles-pp.schedule_idle
      7.80 ±  3%      -6.6        1.24 ±  6%  perf-profile.children.cycles-pp.__switch_to
     14.18            -4.8        9.40 ± 13%  perf-profile.children.cycles-pp.finish_task_switch
     35.24            -4.1       31.18 ±  7%  perf-profile.children.cycles-pp.do_idle
     35.28            -4.0       31.28 ±  7%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     35.28            -4.0       31.28 ±  7%  perf-profile.children.cycles-pp.cpu_startup_entry
     34.92            -4.0       30.97 ±  7%  perf-profile.children.cycles-pp.start_secondary
      8.92 ±  8%      -2.4        6.49 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter_state
      8.95 ±  8%      -2.4        6.58 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter
      6.65 ±  6%      -1.4        5.28 ±  9%  perf-profile.children.cycles-pp.poll_idle
      0.99 ± 16%      -0.8        0.19 ± 14%  perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.87 ± 49%      -0.4        0.48 ± 10%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      1.30 ± 31%      -0.3        0.99 ± 10%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.45            -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.14 ±  6%      -0.0        0.09 ± 14%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.40            -0.0        0.36 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.30 ±  3%      -0.0        0.26 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.29 ±  2%      -0.0        0.26 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.24 ±  4%      -0.0        0.20 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.11            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
      0.15 ±  2%      -0.0        0.12 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
      0.15 ±  2%      -0.0        0.12 ±  7%  perf-profile.children.cycles-pp.update_process_times
      0.06 ±  6%      +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.09 ±  7%      +0.0        0.13 ±  7%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.06 ±  6%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.__list_add_valid
      0.07 ± 26%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.13 ± 12%      +0.1        0.18 ± 11%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.07 ±  6%      +0.1        0.13 ± 10%  perf-profile.children.cycles-pp.__x64_sys_write
      0.08 ±  5%      +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.update_min_vruntime
      0.07 ± 10%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.06 ± 11%      +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.04 ± 44%      +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.child
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.sched_clock
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.read@plt
      0.06            +0.1        0.12 ± 25%  perf-profile.children.cycles-pp.local_touch_nmi
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.__msecs_to_jiffies
      0.08 ±  8%      +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.check_spread
      0.03 ± 70%      +0.1        0.10 ± 12%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.08 ±  6%      +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.put_prev_task_idle
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.00            +0.1        0.07 ± 16%  perf-profile.children.cycles-pp.timer_clear_idle
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.06 ±  7%      +0.1        0.13 ± 11%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.07            +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.__x64_sys_read
      0.01 ±223%      +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.10 ±  8%      +0.1        0.17 ±  9%  perf-profile.children.cycles-pp.rb_next
      0.07 ± 11%      +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.sched_idle_set_state
      0.10 ±  3%      +0.1        0.18 ± 15%  perf-profile.children.cycles-pp.wake_affine
      0.00            +0.1        0.08 ± 12%  perf-profile.children.cycles-pp.aa_file_perm
      0.14 ±  5%      +0.1        0.23 ± 10%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.07            +0.1        0.15 ±  9%  perf-profile.children.cycles-pp.__get_task_ioprio
      0.10 ±  3%      +0.1        0.19 ± 12%  perf-profile.children.cycles-pp.rep_movs_alternative
      0.10 ±  9%      +0.1        0.18 ± 11%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.09 ± 10%      +0.1        0.17 ± 16%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.08 ±  5%      +0.1        0.17 ± 12%  perf-profile.children.cycles-pp.testcase
      0.06 ±  7%      +0.1        0.15 ± 12%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.12 ±  3%      +0.1        0.22 ± 12%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.08 ±  5%      +0.1        0.18 ± 11%  perf-profile.children.cycles-pp.llist_add_batch
      0.10 ±  5%      +0.1        0.20 ± 10%  perf-profile.children.cycles-pp.copyin
      0.07 ±  5%      +0.1        0.17 ± 11%  perf-profile.children.cycles-pp.__pthread_enable_asynccancel
      0.00            +0.1        0.10 ± 19%  perf-profile.children.cycles-pp.resched_curr
      0.09 ±  5%      +0.1        0.19 ± 11%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.08 ±  5%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.10 ±  5%      +0.1        0.21 ±  8%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.13 ±  2%      +0.1        0.24 ± 13%  perf-profile.children.cycles-pp.__calc_delta
      0.08 ±  6%      +0.1        0.19 ± 13%  perf-profile.children.cycles-pp.fsnotify_perm
      0.25 ±  4%      +0.1        0.37 ±  9%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.19 ±  4%      +0.1        0.31 ± 11%  perf-profile.children.cycles-pp.file_update_time
      0.15 ±  4%      +0.1        0.26 ± 10%  perf-profile.children.cycles-pp.available_idle_cpu
      0.12 ±  4%      +0.1        0.24 ± 12%  perf-profile.children.cycles-pp.put_prev_entity
      0.14 ±  4%      +0.1        0.26 ± 10%  perf-profile.children.cycles-pp.pick_next_entity
      0.08 ± 12%      +0.1        0.21 ± 14%  perf-profile.children.cycles-pp.cpuacct_charge
      0.14 ±  3%      +0.1        0.28 ±  9%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.13 ±  2%      +0.1        0.27 ± 10%  perf-profile.children.cycles-pp.copyout
      0.07 ±  5%      +0.1        0.22 ± 14%  perf-profile.children.cycles-pp.tick_nohz_idle_retain_tick
      0.16 ±  4%      +0.1        0.31 ± 11%  perf-profile.children.cycles-pp._copy_from_iter
      0.17 ±  2%      +0.2        0.32 ± 12%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.26            +0.2        0.42 ±  8%  perf-profile.children.cycles-pp.newidle_balance
      0.19 ±  2%      +0.2        0.34 ± 12%  perf-profile.children.cycles-pp.__cond_resched
      0.13 ± 12%      +0.2        0.29 ± 14%  perf-profile.children.cycles-pp.current_time
      0.28 ±  3%      +0.2        0.44 ±  9%  perf-profile.children.cycles-pp.perf_tp_event
      0.21 ±  5%      +0.2        0.37 ± 12%  perf-profile.children.cycles-pp.__update_idle_core
      0.16 ±  3%      +0.2        0.32 ± 11%  perf-profile.children.cycles-pp.place_entity
      0.26            +0.2        0.42 ± 10%  perf-profile.children.cycles-pp.update_rq_clock
      0.24 ±  4%      +0.2        0.41 ± 16%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.20 ±  2%      +0.2        0.38 ± 11%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.23 ±  5%      +0.2        0.41 ± 10%  perf-profile.children.cycles-pp.select_idle_sibling
      0.43 ±  4%      +0.2        0.61 ± 11%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.17 ±  2%      +0.2        0.35 ±  9%  perf-profile.children.cycles-pp._copy_to_iter
      0.26 ±  4%      +0.2        0.44 ± 12%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.28 ±  8%      +0.2        0.46 ± 10%  perf-profile.children.cycles-pp.local_clock
      0.20 ±  4%      +0.2        0.38 ± 10%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.10 ±  4%      +0.2        0.30 ±  6%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.10 ±  3%      +0.2        0.29 ± 10%  perf-profile.children.cycles-pp.finish_wait
      0.27 ±  7%      +0.2        0.47 ± 15%  perf-profile.children.cycles-pp.call_cpuidle
      0.20 ±  2%      +0.2        0.41 ±  9%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.23 ±  2%      +0.2        0.44 ± 11%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.15 ±  4%      +0.2        0.36 ± 10%  perf-profile.children.cycles-pp.check_preempt_curr
      0.09 ±  4%      +0.2        0.30 ±  5%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.10 ±  4%      +0.2        0.32 ±  5%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.16 ±  3%      +0.2        0.39 ± 11%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.11            +0.2        0.35 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.2        0.24 ± 11%  perf-profile.children.cycles-pp.tick_nohz_idle_got_tick
      0.17 ±  2%      +0.2        0.42 ± 14%  perf-profile.children.cycles-pp.fput
      0.21 ±  5%      +0.3        0.47 ± 11%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.19            +0.3        0.47 ± 10%  perf-profile.children.cycles-pp.atime_needs_update
      0.31 ±  2%      +0.3        0.60 ± 12%  perf-profile.children.cycles-pp.reweight_entity
      0.40 ±  4%      +0.3        0.70 ±  8%  perf-profile.children.cycles-pp.update_cfs_group
      0.36 ±  2%      +0.3        0.66 ± 11%  perf-profile.children.cycles-pp.mutex_lock
      0.36 ±  2%      +0.3        0.66 ± 11%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.42 ±  3%      +0.3        0.72 ± 10%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.06 ± 13%      +0.3        0.39 ± 11%  perf-profile.children.cycles-pp.cpuidle_get_cpu_driver
      0.08 ±  6%      +0.3        0.41 ± 14%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.38 ±  2%      +0.3        0.73 ± 10%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.44 ±  3%      +0.4        0.80 ± 11%  perf-profile.children.cycles-pp.__fget_light
      0.20 ±  3%      +0.4        0.56 ±  6%  perf-profile.children.cycles-pp.os_xsave
      0.26 ±  2%      +0.4        0.62 ± 11%  perf-profile.children.cycles-pp.touch_atime
      0.48 ±  3%      +0.4        0.85 ± 11%  perf-profile.children.cycles-pp.__fdget_pos
      0.42 ±  3%      +0.4        0.81 ± 11%  perf-profile.children.cycles-pp.___perf_sw_event
      0.32 ±  2%      +0.4        0.75 ± 11%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.12 ±  6%      +0.4        0.55 ± 18%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.20 ±  5%      +0.4        0.64 ± 10%  perf-profile.children.cycles-pp.mutex_unlock
      0.36 ±  3%      +0.5        0.84 ± 24%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.36 ±  3%      +0.5        0.86 ± 11%  perf-profile.children.cycles-pp.security_file_permission
      0.52 ±  3%      +0.5        1.03 ±  8%  perf-profile.children.cycles-pp.native_sched_clock
      0.55 ±  2%      +0.5        1.06 ± 10%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.61 ±  4%      +0.5        1.14 ±  3%  perf-profile.children.cycles-pp.read_tsc
      0.12 ±  5%      +0.5        0.66 ± 10%  perf-profile.children.cycles-pp.menu_reflect
      0.67 ±  2%      +0.6        1.23 ± 11%  perf-profile.children.cycles-pp.select_task_rq
      0.35 ±  6%      +0.6        0.96 ± 41%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.62 ±  3%      +0.6        1.24 ± 12%  perf-profile.children.cycles-pp.prepare_task_switch
      0.82 ±  2%      +0.6        1.45 ± 10%  perf-profile.children.cycles-pp.set_next_entity
      0.75 ±  3%      +0.7        1.42 ± 10%  perf-profile.children.cycles-pp.update_curr
      0.14 ±  2%      +0.7        0.81 ± 13%  perf-profile.children.cycles-pp.switch_fpu_return
      0.25 ±  2%      +0.7        0.96 ± 12%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      1.28 ±  4%      +0.7        2.01 ± 10%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      1.02 ±  5%      +0.8        1.86 ±  4%  perf-profile.children.cycles-pp.ktime_get
      0.57 ±  3%      +0.9        1.50 ± 13%  perf-profile.children.cycles-pp.__switch_to_asm
      1.26 ±  2%      +1.1        2.38 ± 10%  perf-profile.children.cycles-pp.__entry_text_start
      1.35 ±  2%      +1.1        2.47 ± 10%  perf-profile.children.cycles-pp.update_load_avg
      3.42 ± 10%      +1.1        4.57 ± 10%  perf-profile.children.cycles-pp.menu_select
      1.59 ±  2%      +1.2        2.78 ± 10%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.87 ±  2%      +1.3        3.17 ± 11%  perf-profile.children.cycles-pp.try_to_wake_up
      2.05 ±  2%      +1.4        3.46 ± 11%  perf-profile.children.cycles-pp.autoremove_wake_function
      1.78 ±  2%      +1.5        3.25 ±  9%  perf-profile.children.cycles-pp.enqueue_entity
      2.11 ±  2%      +1.6        3.67 ± 11%  perf-profile.children.cycles-pp.__wake_up_common
      1.77 ±  3%      +1.6        3.35 ± 10%  perf-profile.children.cycles-pp.dequeue_entity
      2.18 ±  2%      +1.7        3.87 ± 10%  perf-profile.children.cycles-pp.enqueue_task_fair
      2.30 ±  2%      +1.7        4.03 ± 11%  perf-profile.children.cycles-pp.__wake_up_common_lock
      2.06 ±  3%      +1.8        3.86 ± 10%  perf-profile.children.cycles-pp.dequeue_task_fair
      2.23 ±  2%      +1.8        4.07 ± 10%  perf-profile.children.cycles-pp.activate_task
      3.31 ±  2%      +2.1        5.38 ± 10%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      2.49            +2.1        4.59 ±  9%  perf-profile.children.cycles-pp.ttwu_do_activate
      2.73 ±  2%      +2.3        5.03 ±  9%  perf-profile.children.cycles-pp.sched_ttwu_pending
      3.35 ±  2%      +2.4        5.79 ± 10%  perf-profile.children.cycles-pp.pipe_write
      3.21            +2.5        5.68 ±  9%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.82 ±  5%      +2.5        3.34 ± 51%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.48 ±  6%      +2.6        3.09 ± 56%  perf-profile.children.cycles-pp.prepare_to_wait_event
      3.58            +2.7        6.26 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.80 ±  2%      +3.2        7.00 ± 10%  perf-profile.children.cycles-pp.vfs_write
      4.24 ±  2%      +3.5        7.70 ± 10%  perf-profile.children.cycles-pp.ksys_write
      9.30 ±  2%      +7.2       16.49 ± 10%  perf-profile.children.cycles-pp.__libc_write
      9.45            -9.1        0.32 ± 60%  perf-profile.self.cycles-pp.mm_cid_get
     21.15 ±  2%      -8.5       12.66 ± 24%  perf-profile.self.cycles-pp.__schedule
      7.79 ±  3%      -6.7        1.14 ±  6%  perf-profile.self.cycles-pp.__switch_to
     13.93            -4.7        9.24 ± 13%  perf-profile.self.cycles-pp.finish_task_switch
      6.51 ±  6%      -1.5        5.04 ±  9%  perf-profile.self.cycles-pp.poll_idle
      0.98 ± 16%      -0.8        0.18 ± 13%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.67 ± 59%      -0.3        0.40 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock
      0.13 ±  8%      -0.0        0.09 ± 12%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.08 ±  6%      -0.0        0.05 ± 44%  perf-profile.self.cycles-pp.clear_buddies
      0.11 ±  6%      -0.0        0.09 ±  8%  perf-profile.self.cycles-pp.tick_nohz_stop_idle
      0.04 ± 45%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.pick_next_task_idle
      0.04 ± 44%      +0.0        0.08 ± 12%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.07 ±  6%      +0.0        0.11 ±  9%  perf-profile.self.cycles-pp.update_min_vruntime
      0.05            +0.0        0.09 ± 11%  perf-profile.self.cycles-pp.__list_add_valid
      0.06 ±  7%      +0.0        0.11 ± 12%  perf-profile.self.cycles-pp.check_spread
      0.10 ±  5%      +0.0        0.14 ± 11%  perf-profile.self.cycles-pp.ksys_write
      0.12 ±  3%      +0.0        0.17 ± 10%  perf-profile.self.cycles-pp.select_task_rq
      0.06 ±  9%      +0.0        0.10 ± 17%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.08 ±  6%      +0.1        0.13 ±  9%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.06 ±  6%      +0.1        0.11 ± 26%  perf-profile.self.cycles-pp.local_touch_nmi
      0.02 ±141%      +0.1        0.07 ± 13%  perf-profile.self.cycles-pp.local_clock
      0.07 ±  7%      +0.1        0.12 ± 11%  perf-profile.self.cycles-pp.file_update_time
      0.06 ± 11%      +0.1        0.12 ± 14%  perf-profile.self.cycles-pp.wake_affine
      0.07 ± 10%      +0.1        0.12 ± 12%  perf-profile.self.cycles-pp.__x64_sys_write
      0.06 ±  6%      +0.1        0.12 ± 11%  perf-profile.self.cycles-pp._copy_from_iter
      0.04 ± 44%      +0.1        0.10 ± 10%  perf-profile.self.cycles-pp.child
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.06 ±  6%      +0.1        0.12 ± 12%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.__msecs_to_jiffies
      0.07 ±  7%      +0.1        0.13 ± 14%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.13 ±  5%      +0.1        0.19 ± 10%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.16 ±  4%      +0.1        0.23 ± 10%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.07            +0.1        0.13 ± 11%  perf-profile.self.cycles-pp.__x64_sys_read
      0.03 ± 70%      +0.1        0.10 ± 16%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.07 ±  6%      +0.1        0.14 ± 13%  perf-profile.self.cycles-pp.put_prev_task_idle
      0.01 ±223%      +0.1        0.07 ±  9%  perf-profile.self.cycles-pp.hrtimer_get_next_event
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.perf_trace_buf_alloc
      0.10 ±  4%      +0.1        0.17 ± 10%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.06 ±  9%      +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.cpu_startup_entry
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      0.09 ±  7%      +0.1        0.16 ±  9%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.sched_idle_set_state
      0.00            +0.1        0.07 ± 13%  perf-profile.self.cycles-pp.aa_file_perm
      0.06 ± 11%      +0.1        0.13 ± 16%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.07 ±  9%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.copyin
      0.01 ±223%      +0.1        0.08 ± 12%  perf-profile.self.cycles-pp._copy_to_iter
      0.00            +0.1        0.07 ±  9%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.06 ±  7%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.09 ±  4%      +0.1        0.16 ± 13%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.cpuidle_enter
      0.10 ± 10%      +0.1        0.17 ± 12%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.05            +0.1        0.13 ± 34%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.10 ±  8%      +0.1        0.17 ±  9%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.07 ±  5%      +0.1        0.15 ± 11%  perf-profile.self.cycles-pp.put_prev_entity
      0.07 ±  5%      +0.1        0.15 ±  8%  perf-profile.self.cycles-pp.__get_task_ioprio
      0.18 ±  6%      +0.1        0.26 ± 11%  perf-profile.self.cycles-pp.do_syscall_64
      0.08 ±  4%      +0.1        0.16 ± 10%  perf-profile.self.cycles-pp.testcase
      0.06 ±  7%      +0.1        0.15 ± 15%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.13 ±  5%      +0.1        0.22 ±  9%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.08 ± 11%      +0.1        0.17 ± 17%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.12 ±  4%      +0.1        0.21 ± 10%  perf-profile.self.cycles-pp.select_idle_sibling
      0.03 ± 70%      +0.1        0.12 ± 29%  perf-profile.self.cycles-pp.tick_nohz_idle_enter
      0.06 ±  6%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.touch_atime
      0.03 ± 70%      +0.1        0.12 ± 15%  perf-profile.self.cycles-pp.cpuidle_reflect
      0.10 ±  5%      +0.1        0.19 ± 11%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.1        0.09 ± 15%  perf-profile.self.cycles-pp.resched_curr
      0.11 ±  6%      +0.1        0.20 ± 11%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.08 ±  5%      +0.1        0.18 ± 10%  perf-profile.self.cycles-pp.llist_add_batch
      0.08 ±  4%      +0.1        0.18 ± 12%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.15 ±  6%      +0.1        0.25 ± 12%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.07 ±  7%      +0.1        0.17 ± 10%  perf-profile.self.cycles-pp.__pthread_enable_asynccancel
      0.11 ±  3%      +0.1        0.21 ± 11%  perf-profile.self.cycles-pp.pick_next_entity
      0.14 ±  8%      +0.1        0.24 ± 12%  perf-profile.self.cycles-pp.available_idle_cpu
      0.09 ±  4%      +0.1        0.19 ± 10%  perf-profile.self.cycles-pp.__wake_up_common_lock
      0.08 ±  5%      +0.1        0.19 ±  9%  perf-profile.self.cycles-pp.copyout
      0.12 ±  3%      +0.1        0.23 ± 11%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.08 ±  5%      +0.1        0.19 ±  7%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.09 ±  7%      +0.1        0.20 ± 10%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.13 ±  2%      +0.1        0.24 ± 13%  perf-profile.self.cycles-pp.__calc_delta
      0.09 ± 12%      +0.1        0.20 ± 11%  perf-profile.self.cycles-pp.current_time
      0.13 ±  5%      +0.1        0.24 ± 14%  perf-profile.self.cycles-pp.__update_idle_core
      0.08 ±  6%      +0.1        0.19 ± 13%  perf-profile.self.cycles-pp.fsnotify_perm
      0.00            +0.1        0.11 ± 11%  perf-profile.self.cycles-pp.security_file_permission
      0.19 ±  4%      +0.1        0.31 ±  9%  perf-profile.self.cycles-pp.perf_tp_event
      0.14 ±  3%      +0.1        0.26 ± 12%  perf-profile.self.cycles-pp.__cond_resched
      0.08 ± 12%      +0.1        0.20 ± 11%  perf-profile.self.cycles-pp.cpuacct_charge
      0.10 ±  4%      +0.1        0.23 ± 11%  perf-profile.self.cycles-pp.ksys_read
      0.10 ±  4%      +0.1        0.23 ± 12%  perf-profile.self.cycles-pp.autoremove_wake_function
      0.12 ±  4%      +0.1        0.26 ±  9%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.29 ±  3%      +0.1        0.42 ± 10%  perf-profile.self.cycles-pp.tick_nohz_idle_exit
      0.07            +0.1        0.20 ± 13%  perf-profile.self.cycles-pp.tick_nohz_idle_retain_tick
      0.06 ±  6%      +0.1        0.20 ± 12%  perf-profile.self.cycles-pp.__wake_up_common
      0.10 ±  6%      +0.1        0.24 ±  9%  perf-profile.self.cycles-pp.check_preempt_curr
      0.18 ±  4%      +0.1        0.32 ±  9%  perf-profile.self.cycles-pp.try_to_wake_up
      0.09 ±  7%      +0.1        0.23 ± 12%  perf-profile.self.cycles-pp.put_prev_task_fair
      0.04 ± 44%      +0.1        0.19 ± 11%  perf-profile.self.cycles-pp.activate_task
      0.16 ±  3%      +0.2        0.31 ± 10%  perf-profile.self.cycles-pp.place_entity
      0.18 ±  4%      +0.2        0.33 ± 11%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.10 ±  7%      +0.2        0.26 ±  8%  perf-profile.self.cycles-pp.atime_needs_update
      0.18 ±  4%      +0.2        0.34 ±  9%  perf-profile.self.cycles-pp.newidle_balance
      0.09 ±  4%      +0.2        0.27 ±  6%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.25 ±  7%      +0.2        0.43 ± 16%  perf-profile.self.cycles-pp.call_cpuidle
      0.08 ±  6%      +0.2        0.26 ±  6%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.33 ±  2%      +0.2        0.53 ± 11%  perf-profile.self.cycles-pp.vfs_read
      0.27 ±  3%      +0.2        0.48 ± 11%  perf-profile.self.cycles-pp.set_next_entity
      0.27 ±  5%      +0.2        0.48 ±  9%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.10 ±  6%      +0.2        0.31 ±  6%  perf-profile.self.cycles-pp.schedule_idle
      0.24 ±  2%      +0.2        0.44 ± 10%  perf-profile.self.cycles-pp.__libc_write
      0.22 ±  2%      +0.2        0.43 ± 11%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.22 ±  3%      +0.2        0.43 ± 11%  perf-profile.self.cycles-pp.mutex_lock
      0.20 ±  6%      +0.2        0.41 ± 13%  perf-profile.self.cycles-pp.prepare_task_switch
      0.13 ±  3%      +0.2        0.35 ± 14%  perf-profile.self.cycles-pp.fput
      0.00            +0.2        0.22 ± 11%  perf-profile.self.cycles-pp.tick_nohz_idle_got_tick
      0.37 ±  3%      +0.2        0.60 ± 12%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.24 ±  4%      +0.2        0.47 ±  9%  perf-profile.self.cycles-pp.__libc_read
      0.10 ±  4%      +0.2        0.33 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.30 ±  2%      +0.2        0.53 ± 11%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.16 ±  3%      +0.2        0.39 ± 10%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.21 ±  2%      +0.3        0.47 ± 11%  perf-profile.self.cycles-pp.prepare_to_wait_event
      0.37 ±  9%      +0.3        0.63 ±  9%  perf-profile.self.cycles-pp.update_curr
      0.22 ±  3%      +0.3        0.50 ±  9%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.39 ±  4%      +0.3        0.68 ±  7%  perf-profile.self.cycles-pp.update_cfs_group
      0.34 ±  2%      +0.3        0.64 ± 11%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.29 ±  3%      +0.3        0.59 ± 11%  perf-profile.self.cycles-pp.reweight_entity
      0.36 ±  2%      +0.3        0.68 ± 10%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.44 ±  9%      +0.3        0.77 ±  7%  perf-profile.self.cycles-pp.ktime_get
      0.36 ±  3%      +0.3        0.68 ±  9%  perf-profile.self.cycles-pp.pipe_write
      0.06 ± 13%      +0.3        0.39 ± 11%  perf-profile.self.cycles-pp.cpuidle_get_cpu_driver
      0.10 ±  4%      +0.3        0.43 ± 10%  perf-profile.self.cycles-pp.menu_reflect
      0.06            +0.3        0.40 ± 15%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.43 ±  3%      +0.3        0.77 ± 11%  perf-profile.self.cycles-pp.__fget_light
      0.33 ±  3%      +0.4        0.68 ± 11%  perf-profile.self.cycles-pp.dequeue_entity
      0.38 ±  2%      +0.4        0.74 ± 11%  perf-profile.self.cycles-pp.___perf_sw_event
      0.41 ±  3%      +0.4        0.78 ± 12%  perf-profile.self.cycles-pp.pipe_read
      0.20 ±  2%      +0.4        0.56 ±  6%  perf-profile.self.cycles-pp.os_xsave
      0.28 ±  2%      +0.4        0.67 ± 11%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.12 ±  6%      +0.4        0.54 ± 18%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.22 ±  4%      +0.4        0.66 ± 10%  perf-profile.self.cycles-pp.vfs_write
      0.18 ±  5%      +0.4        0.63 ±  9%  perf-profile.self.cycles-pp.mutex_unlock
      0.60 ±  5%      +0.5        1.06 ±  9%  perf-profile.self.cycles-pp.update_load_avg
      0.52 ±  2%      +0.5        1.01 ±  8%  perf-profile.self.cycles-pp.native_sched_clock
      0.57 ±  2%      +0.5        1.09 ±  2%  perf-profile.self.cycles-pp.read_tsc
      0.62 ±  3%      +0.5        1.16 ±  9%  perf-profile.self.cycles-pp.enqueue_entity
      0.12            +0.7        0.79 ± 13%  perf-profile.self.cycles-pp.switch_fpu_return
      0.57 ±  3%      +0.9        1.49 ± 13%  perf-profile.self.cycles-pp.__switch_to_asm
      0.48 ±  5%      +0.9        1.41 ± 11%  perf-profile.self.cycles-pp.cpuidle_idle_call
      1.10 ±  2%      +0.9        2.04 ± 11%  perf-profile.self.cycles-pp.__entry_text_start
      0.99 ±  2%      +1.0        1.96 ± 10%  perf-profile.self.cycles-pp.menu_select
      1.86 ±  2%      +1.4        3.28 ± 10%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      3.28            +2.0        5.23 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      3.31 ±  2%      +2.1        5.38 ± 10%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.80 ±  5%      +2.5        3.31 ± 52%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



--k2j0AZe56lBmWZqw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc4-00338-gc1753fd02a00"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.4.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-12 (Debian 12.2.0-14) 12.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
CONFIG_CACHESTAT_SYSCALL=y
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_INTEL_TDX_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
# CONFIG_ADDRESS_MASKING is not set
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_CALL_PADDING=y
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CALL_THUNKS=y
CONFIG_PREFIX_SYMBOLS=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_BPF_LINK=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_MQPRIO_LIB=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_DEBUG=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_SGI_XP is not set
CONFIG_HP_ILO=m
# CONFIG_SGI_GRU is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_PARPORT is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_T1S_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_CBTX_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_CAN_DEV is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
# CONFIG_WLAN is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_FXL6408 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ELKHARTLAKE is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_VIRTIO_GPU_KMS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=m
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2606MVV is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_TASK=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
# CONFIG_HYPERV_VTL_MODE is not set
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_LENOVO_YMC is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_EC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_SUPPORT_ASCII_CI=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_DEBUG is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SM4_GENERIC=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_FLAGS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SLUB_DEBUG is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_PER_VMA_LOCK_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--k2j0AZe56lBmWZqw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh

export_top_env()
{
	export suite=3D'stress-ng'
	export testcase=3D'stress-ng'
	export category=3D'benchmark'
	export nr_threads=3D6
	export testtime=3D60
	export job_origin=3D'stress-ng-class-os.yaml'
	export queue_cmdline_keys=3D'branch
commit
kbuild_queue_analysis'
	export queue=3D'validate'
	export testbox=3D'lkp-icl-2sp7'
	export tbox_group=3D'lkp-icl-2sp7'
	export submit_id=3D'64b4a55443b3cf609fc67c0e'
	export job_file=3D'/lkp/jobs/queued/validate/lkp-icl-2sp7/stress-ng-os-per=
formance-1HDD-ext4-10%-madvise-60s-debian-11.1-x86_64-20220510.cgz-c1753fd0=
2a00-20230717-90271-1y1b1sa-5.yaml'
	export id=3D'cae6e01e3a2ff7459bfc64961885193f51f86f82'
	export queuer_version=3D'/zday/lkp'
	export model=3D'Ice Lake'
	export nr_node=3D2
	export nr_cpu=3D64
	export memory=3D'256G'
	export nr_ssd_partitions=3D3
	export nr_hdd_partitions=3D6
	export hdd_partitions=3D'/dev/disk/by-id/ata-WDC_WD20SPZX-22UA7T0_WD-WXK2E=
319F11A-part*'
	export ssd_partitions=3D'/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF7414=
01PU4P0IGN-part1
/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part2
/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part3'
	export rootfs_partition=3D'/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF74=
1401PU4P0IGN-part4'
	export kernel_cmdline_hw=3D'acpi_rsdp=3D0x6988f014'
	export result_service=3D'tmpfs'
	export LKP_SERVER=3D'10.239.97.5'
	export avoid_nfs=3D1
	export brand=3D'Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz'
	export need_kconfig=3D'{"XFS_DEBUG"=3D>"n"}
{"XFS_WARN"=3D>"y"}
{"PM_DEBUG"=3D>"n"}
{"PM_SLEEP_DEBUG"=3D>"n"}
{"DEBUG_ATOMIC_SLEEP"=3D>"n"}
{"DEBUG_SPINLOCK_SLEEP"=3D>"n"}
{"CIFS_DEBUG"=3D>"n"}
{"SCSI_DEBUG"=3D>"n"}
{"NFS_DEBUG"=3D>"n"}
{"SUNRPC_DEBUG"=3D>"n"}
{"DM_DEBUG"=3D>"n"}
{"DEBUG_SHIRQ"=3D>"n"}
{"OCFS2_DEBUG_MASKLOG"=3D>"n"}
{"DEBUG_MEMORY_INIT"=3D>"n"}
{"SLUB_DEBUG"=3D>"n"}
{"EXPERT"=3D>"y"}
{"PREEMPT_VOLUNTARY"=3D>"y"}
{"PREEMPT_NONE"=3D>"n"}
{"PREEMPT"=3D>"n"}
{"PREEMPT_RT"=3D>"n"}
{"PREEMPT_DYNAMIC"=3D>"n"}
{"PREEMPT_VOLUNTARY_BEHAVIOUR"=3D>"y"}
{"PREEMPT_BEHAVIOUR"=3D>"n"}
{"PREEMPT_NONE_BEHAVIOUR"=3D>"n"}
{"PREEMPT_DYNAMIC"=3D>"n"}
{"PREEMPT_VOLUNTARY"=3D>"y"}
{"PREEMPT_NONE"=3D>"n"}
{"PREEMPT"=3D>"n"}
{"PREEMPT_RT"=3D>"n"}
BLK_DEV_SD
SCSI
{"BLOCK"=3D>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"PCI"=3D>"y"}
EXT4_FS'
	export commit=3D'c1753fd02a0058ea43cbb31ab26d25be2f6cfe08'
	export ucode=3D'0xd000389'
	export kconfig=3D'x86_64-rhel-8.3'
	export enqueue_time=3D'2023-07-17 10:20:04 +0800'
	export _id=3D'64b4a55943b3cf609fc67c10'
	export _rt=3D'/result/stress-ng/os-performance-1HDD-ext4-10%-madvise-60s/l=
kp-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/c1753fd0=
2a0058ea43cbb31ab26d25be2f6cfe08'
	export compiler=3D'gcc-12'
	export head_commit=3D'90cefc2102aa94195ec7751acea4ad5ecb734463'
	export base_commit=3D'06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5'
	export branch=3D'linus/master'
	export rootfs=3D'debian-11.1-x86_64-20220510.cgz'
	export user=3D'lkp'
	export scheduler_version=3D'/lkp/lkp/src'
	export arch=3D'x86_64'
	export max_uptime=3D2100
	export initrd=3D'/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append=3D'root=3D/dev/ram0
RESULT_ROOT=3D/result/stress-ng/os-performance-1HDD-ext4-10%-madvise-60s/lk=
p-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/c1753fd02=
a0058ea43cbb31ab26d25be2f6cfe08/3
BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-12/c1753fd02a0058ea43cbb31ab26d=
25be2f6cfe08/vmlinuz-6.4.0-rc4-00338-gc1753fd02a00
branch=3Dlinus/master
job=3D/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-os-performance-1HDD-ext4-1=
0%-madvise-60s-debian-11.1-x86_64-20220510.cgz-c1753fd02a00-20230717-90271-=
1y1b1sa-5.yaml
user=3Dlkp
ARCH=3Dx86_64
kconfig=3Dx86_64-rhel-8.3
commit=3Dc1753fd02a0058ea43cbb31ab26d25be2f6cfe08
nmi_watchdog=3D0
acpi_rsdp=3D0x6988f014
max_uptime=3D2100
LKP_SERVER=3D10.239.97.5
nokaslr
selinux=3D0
debug
apic=3Ddebug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=3D100
net.ifnames=3D0
printk.devkmsg=3Don
panic=3D-1
softlockup_panic=3D1
nmi_watchdog=3Dpanic
oops=3Dpanic
load_ramdisk=3D2
prompt_ramdisk=3D0
drbd.minor_count=3D8
systemd.log_level=3Derr
ignore_loglevel
console=3Dtty0
earlyprintk=3DttyS0,115200
console=3DttyS0,115200
vga=3Dnormal
rw'
	export modules_initrd=3D'/pkg/linux/x86_64-rhel-8.3/gcc-12/c1753fd02a0058e=
a43cbb31ab26d25be2f6cfe08/modules.cgz'
	export bm_initrd=3D'/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_2022=
0513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_2022051=
5.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.c=
gz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/d=
eps/debian-11.1-x86_64-20220510.cgz/stress-ng_20230716.cgz,/osimage/pkg/deb=
ian-11.1-x86_64-20220510.cgz/stress-ng-x86_64-0.15.04-1_20230716.cgz,/osima=
ge/deps/debian-11.1-x86_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/d=
ebian-11.1-x86_64-20220510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-1=
1.1-x86_64-20220510.cgz/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osima=
ge/deps/debian-11.1-x86_64-20220510.cgz/perf_20230522.cgz,/osimage/pkg/debi=
an-11.1-x86_64-20220510.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimag=
e/pkg/debian-11.1-x86_64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/os=
image/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz,/osimage/deps/de=
bian-11.1-x86_64-20220510.cgz/rootfs_20220515.cgz'
	export ucode_initrd=3D'/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd=3D'/osimage/user/lkp/lkp-x86_64.cgz'
	export site=3D'lkp-wsx01'
	export LKP_CGI_PORT=3D80
	export LKP_CIFS_PORT=3D139
	export job_initrd=3D'/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-os-perform=
ance-1HDD-ext4-10%-madvise-60s-debian-11.1-x86_64-20220510.cgz-c1753fd02a00=
-20230717-90271-1y1b1sa-5.cgz'
	export last_kernel=3D'6.5.0-rc1'
	export acpi_rsdp=3D'0x6988f014'
	export repeat_to=3D6
	export bad_samples=3D'85.48
84.81
85.94'
	export kbuild_queue_analysis=3D1
	export kernel=3D'/pkg/linux/x86_64-rhel-8.3/gcc-12/c1753fd02a0058ea43cbb31=
ab26d25be2f6cfe08/vmlinuz-6.4.0-rc4-00338-gc1753fd02a00'
	export result_root=3D'/result/stress-ng/os-performance-1HDD-ext4-10%-madvi=
se-60s/lkp-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/=
c1753fd02a0058ea43cbb31ab26d25be2f6cfe08/3'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=3D/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_hdd=3D1 $LKP_SRC/setup/disk

	run_setup fs=3D'ext4' $LKP_SRC/setup/fs

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_setup $LKP_SRC/setup/sanity-check

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=3D1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-c2c
	run_monitor debug_mode=3D0 $LKP_SRC/monitors/no-stdout/wrapper perf-profil=
e
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test class=3D'os' test=3D'madvise' $LKP_SRC/tests/wrapper stress-ng
}

extract_stats()
{
	export stats_part_begin=3D
	export stats_part_end=3D

	env class=3D'os' test=3D'madvise' $LKP_SRC/stats/wrapper stress-ng
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=3D1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-c2c
	env debug_mode=3D0 $LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time stress-ng.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--k2j0AZe56lBmWZqw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"
Content-Transfer-Encoding: quoted-printable

---
suite: stress-ng
testcase: stress-ng
category: benchmark
nr_threads: 10%
disk: 1HDD
testtime: 60s
fs: ext4
stress-ng:
  class: os
  test: madvise
job_origin: stress-ng-class-os.yaml
queue_cmdline_keys:
- branch
- commit
- kbuild_queue_analysis
queue: bisect
testbox: lkp-icl-2sp7
tbox_group: lkp-icl-2sp7
submit_id: 64b470c343b3cf144cc8cde7
job_file: "/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-os-performance-1HDD-e=
xt4-10%-madvise-60s-debian-11.1-x86_64-20220510.cgz-c1753fd02a00-20230717-7=
0732-109h8de-2.yaml"
id: c34118c4d0dc682c8820e7b427814b96e7d8b2ed
queuer_version: "/zday/lkp"
model: Ice Lake
nr_node: 2
nr_cpu: 64
memory: 256G
nr_ssd_partitions: 3
nr_hdd_partitions: 6
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD20SPZX-22UA7T0_WD-WXK2E319F11A-p=
art*"
ssd_partitions:
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part1"
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part2"
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0IGN-part3"
rootfs_partition: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401PU4P0=
IGN-part4"
kernel_cmdline_hw: acpi_rsdp=3D0x6988f014
result_service: tmpfs
LKP_SERVER: 10.239.97.5
avoid_nfs: 1
brand: Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz
need_kconfig:
- XFS_DEBUG: n
- XFS_WARN: y
- PM_DEBUG: n
- PM_SLEEP_DEBUG: n
- DEBUG_ATOMIC_SLEEP: n
- DEBUG_SPINLOCK_SLEEP: n
- CIFS_DEBUG: n
- SCSI_DEBUG: n
- NFS_DEBUG: n
- SUNRPC_DEBUG: n
- DM_DEBUG: n
- DEBUG_SHIRQ: n
- OCFS2_DEBUG_MASKLOG: n
- DEBUG_MEMORY_INIT: n
- SLUB_DEBUG: n
- EXPERT: y
- PREEMPT_VOLUNTARY: y
- PREEMPT_NONE: n
- PREEMPT: n
- PREEMPT_RT: n
- PREEMPT_DYNAMIC: n
- PREEMPT_VOLUNTARY_BEHAVIOUR: y
- PREEMPT_BEHAVIOUR: n
- PREEMPT_NONE_BEHAVIOUR: n
- PREEMPT_DYNAMIC: n
- PREEMPT_VOLUNTARY: y
- PREEMPT_NONE: n
- PREEMPT: n
- PREEMPT_RT: n
- BLK_DEV_SD
- SCSI
- BLOCK: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- PCI: y
- EXT4_FS
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
perf-c2c:
perf-profile:
  debug_mode: 0
cpufreq_governor: performance
sanity-check:
commit: c1753fd02a0058ea43cbb31ab26d25be2f6cfe08
ucode: '0xd000389'
kconfig: x86_64-rhel-8.3
enqueue_time: 2023-07-17 06:35:48.035183551 +08:00
_id: 64b4754543b3cf144cc8cde9
_rt: "/result/stress-ng/os-performance-1HDD-ext4-10%-madvise-60s/lkp-icl-2s=
p7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/c1753fd02a0058ea4=
3cbb31ab26d25be2f6cfe08"
compiler: gcc-12
head_commit: 90cefc2102aa94195ec7751acea4ad5ecb734463
base_commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
branch: internal-devel/devel-hourly-20230716-100607
rootfs: debian-11.1-x86_64-20220510.cgz
user: lkp
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=3D/dev/ram0
- RESULT_ROOT=3D/result/stress-ng/os-performance-1HDD-ext4-10%-madvise-60s/=
lkp-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/c1753fd=
02a0058ea43cbb31ab26d25be2f6cfe08/0
- BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-12/c1753fd02a0058ea43cbb31ab2=
6d25be2f6cfe08/vmlinuz-6.4.0-rc4-00338-gc1753fd02a00
- branch=3Dinternal-devel/devel-hourly-20230716-100607
- job=3D/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-os-performance-1HDD-ext4=
-10%-madvise-60s-debian-11.1-x86_64-20220510.cgz-c1753fd02a00-20230717-7073=
2-109h8de-2.yaml
- user=3Dlkp
- ARCH=3Dx86_64
- kconfig=3Dx86_64-rhel-8.3
- commit=3Dc1753fd02a0058ea43cbb31ab26d25be2f6cfe08
- nmi_watchdog=3D0
- acpi_rsdp=3D0x6988f014
- max_uptime=3D2100
- LKP_SERVER=3D10.239.97.5
- nokaslr
- selinux=3D0
- debug
- apic=3Ddebug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=3D100
- net.ifnames=3D0
- printk.devkmsg=3Don
- panic=3D-1
- softlockup_panic=3D1
- nmi_watchdog=3Dpanic
- oops=3Dpanic
- load_ramdisk=3D2
- prompt_ramdisk=3D0
- drbd.minor_count=3D8
- systemd.log_level=3Derr
- ignore_loglevel
- console=3Dtty0
- earlyprintk=3DttyS0,115200
- console=3DttyS0,115200
- vga=3Dnormal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-12/c1753fd02a0058ea43cbb31a=
b26d25be2f6cfe08/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,=
/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/os=
image/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osima=
ge/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debia=
n-11.1-x86_64-20220510.cgz/stress-ng_20230716.cgz,/osimage/pkg/debian-11.1-=
x86_64-20220510.cgz/stress-ng-x86_64-0.15.04-1_20230716.cgz,/osimage/deps/d=
ebian-11.1-x86_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/debian-11.=
1-x86_64-20220510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-11.1-x86_6=
4-20220510.cgz/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osimage/deps/d=
ebian-11.1-x86_64-20220510.cgz/perf_20230522.cgz,/osimage/pkg/debian-11.1-x=
86_64-20220510.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimage/pkg/deb=
ian-11.1-x86_64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/osimage/dep=
s/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz,/osimage/deps/debian-11.1=
-x86_64-20220510.cgz/rootfs_20220515.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
job_initrd: "/lkp/jobs/scheduled/lkp-icl-2sp7/stress-ng-os-performance-1HDD=
-ext4-10%-madvise-60s-debian-11.1-x86_64-20220510.cgz-c1753fd02a00-20230717=
-70732-109h8de-2.cgz"
last_kernel: 6.5.0-rc1
acpi_rsdp: '0x6988f014'
repeat_to: 3
bad_samples:
- 85.48
- 84.81
- 85.94

#! queue options

#! user overrides
kbuild_queue_analysis: 1
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-12/c1753fd02a0058ea43cbb31ab26d25be=
2f6cfe08/vmlinuz-6.4.0-rc4-00338-gc1753fd02a00"
result_root: "/result/stress-ng/os-performance-1HDD-ext4-10%-madvise-60s/lk=
p-icl-2sp7/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/c1753fd02=
a0058ea43cbb31ab26d25be2f6cfe08/0"

#! schedule options

#! /db/releases/20230716204618/lkp-src/include/site/lkp-wsx01
dequeue_time: 2023-07-17 06:58:24.968110092 +08:00
job_state: finished
loadavg: 12.94 6.95 2.67 1/758 47568
start_time: '1689548401'
end_time: '1689548463'
version: "/lkp/lkp/.src-20230715-171746:0f39afd92b5d:0523cb6b5dc5"

--k2j0AZe56lBmWZqw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

dmsetup remove_all
wipefs -a --force /dev/sda1
mkfs -t ext4 -q -F /dev/sda1
mkdir -p /fs/sda1
mount -t ext4 /dev/sda1 /fs/sda1

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "mkdir" "-p" "/mnt/stress-ng"
 "mount" "/dev/sda1" "/mnt/stress-ng"
 "stress-ng" "--timeout" "60" "--times" "--verify" "--metrics-brief" "--madvise" "6"

--k2j0AZe56lBmWZqw--
