Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07347BC564
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343639AbjJGHJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343572AbjJGHJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:09:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1E5B9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 00:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696662551; x=1728198551;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=WRIgSouKSGv3AhtV0sNYxyiADj5tfKtwEDovGlCRSCQ=;
  b=X25ttU4eYwBrNpvZiN/TYD6Mk1mabKNx1sFB9i7NGNktMI4XT4mC08wg
   nyg93g4gQlL1XGg2lLrDCrmBVwzO2yDQjUI0sphhQrAMcck2NkyHK27to
   12UqYjzf+MV96upHL+D7o32eZOrqlHKHtlpFUwakAxrR5LWbRSQh9ELKF
   gUYM3QapZrNxzdbo+2oMFFlutn0CDbHBkGvxlAO6S+G1DVTEspMHC9Gpt
   pgc9ggDm4GgQ4MS7W5zUQg6A1xIhStRnufyLruaF28O7W34A4bwwIAOEv
   mmp1j9yE6cP88TXOX6L5e9tirWdpZO6wbHxl+f6VqTRSPvemiApA3Rjcy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="364187042"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="364187042"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="1083742038"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="1083742038"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2023 00:09:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 7 Oct 2023 00:09:09 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 7 Oct 2023 00:09:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 7 Oct 2023 00:09:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 7 Oct 2023 00:09:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5jhzqgEt4X5mmhys0bRuPjTsIq5ievueQoN5CROYGcP56OIfcVjfHhY8hhBccl3Sg9jEb2zbr8YYjFICNvhYtEZQR/hdB/Upk6rW9Ij+2R0X3ds/bTGUooA2X6Tzy3p37S0DaLRWnjCLwuIa7xI2dzjS9uODYZA9THJq3I3lp1vQChdeHmfNLvnvCT4y6QiWuiUR3BNC4URV9ep7O05HlsaJCEcPm6J9DZgEdLVuKP5tNlfCZSeQhHG+yKUOuWGU5dN7k1qc3/CDDY96tWdlC+MHvz9qE/sfiAUiPbuxYfbF5/cq0P/iXIzH7JZmyJ+GFvAKsvaI24fYK583SsAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYYwi1O2JA9/tb9xh6g0NrpA2iSWE22qu+TfYu+ynps=;
 b=FjGG45F3cUZXvdyOVRrQ8kWzKTGBEiDIU6YK3L5VqU2R+b+6TQFrrZHv1Ma3853c4SpbTGEEY/l33X94OlggedznBzjmXfcPzfpAw8Fg8xZClCAnXg+9PaD9NcXTkqlMrweDQjOoX/CKVtpuw6fKV/vi0TW9Nf/S1/Nxy5Ww39fvw2l4Rzrib22AuMhACfn4Uof9G0iwd6mpyY/soCEME1CDiIkpDpB5h3maKxgRVHTwOdSWQtgJFQN0bcnzRJDqj6MM0vLm5XIKuxZVEPHY5KADKD3iM6tsEHYIEj4KaU5PNUJlW42/1VCJFrzwVG4bVkQ7MRj+SmUbMB/6IC0H4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CH0PR11MB5474.namprd11.prod.outlook.com (2603:10b6:610:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Sat, 7 Oct
 2023 07:09:01 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6838.029; Sat, 7 Oct 2023
 07:09:01 +0000
Date:   Sat, 7 Oct 2023 15:08:48 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Yang Shi <yang@os.amperecomputing.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Oscar Salvador" <osalvador@suse.de>,
        Rafael Aquini <aquini@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Rientjes <rientjes@google.com>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  24526268f4:  stress-ng.numa.ops_per_sec 4.7%
 improvement
Message-ID: <202310071416.df82eed7-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::31) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CH0PR11MB5474:EE_
X-MS-Office365-Filtering-Correlation-Id: dd508686-62f4-4c8c-528d-08dbc704481b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYAcnxYaltH7NYocrrj1+F/kLQVK96Hr1uqsilijofe6F0nq1mmDRbDjwASqE6SXk4JYCHBZJv2W1tF4wwyrO4AV9bO3z2g7eivl2FWiwSAzNggw1ocaR5Anf/F3P5tN/1KiNhOgeZfb5CNh8KwkA+t4ylCThCpjoL4nvrYeki9oNoEVK2PGpKIJrNPLKSzUuUw87C7O56oRWgVB/SU4/h4OpbU0KaYxABW6EFHQ1DmNO3TuJ2pnkp40umHzXO4CnjbJ8bCdEmOmQ7rbEdkIesi8C+nfHx6iZGk5QTPwtbpzxEEKsF1dZXOeCtdDZyvloXDb5MOy1xIqE6QJAaqok+47R89Zmj2WxYPxsDJdr7X901Adif1vkj+gh97sfwNMIrVTTGK7yE/t2729DjxBGlzaoFGlTvMuuJCYqxAUx5C7mIxgjWHc6bnm/tasu8RVjKfZJmj0bRrkw2Kc9XoOe3/GNRy716NSx/idJdzhF7yuKPphsBniy18T4d7SEIOIr4LboEGRw47KWrXJoWZFWgTpPMgNovp1KBrLON8bhF76qbZds+uD5F0NX8Q9uXV0GtxGhYAKOQ4bPUq08KN1MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(83380400001)(6666004)(6506007)(966005)(6486002)(478600001)(38100700002)(1076003)(86362001)(82960400001)(316002)(41300700001)(2616005)(2906002)(6512007)(107886003)(26005)(54906003)(36756003)(66946007)(66476007)(7416002)(6916009)(5660300002)(66556008)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MKUvxJcNMQgMNrY4kTRjNlFHfOBj0cq2VvCldUCtMaDbn0JVLAleK1YDYb?=
 =?iso-8859-1?Q?ScbwuAfFN9QbLBatVMdz3MRKxVuhSB2SQW2IShd3koyRXTsaPcm+cWP88V?=
 =?iso-8859-1?Q?kiehhb22l/vu+hqU+ikEie01mQk2C3tbeTQQWBVvb8hTjPurv3VpSPAo+o?=
 =?iso-8859-1?Q?hEvyPr2UL3TfqHsrEwfBegQjHQ4imx2hGy4jTJvkPH+QKGA7KEDTc1hPk6?=
 =?iso-8859-1?Q?Hz4zgXWK+jGFOLTwvrSLNI+2vHbps7tqqikr7H+VxT9XpOCwRb4y+7ujQU?=
 =?iso-8859-1?Q?KhDFgpuEXM8Qz8s1wjjulDNFyVeT7yuBV01rE2dt+7J9RgIjPaG88/AHNL?=
 =?iso-8859-1?Q?2sysAxO6lvAI66fxBNb/0jxjxmEcoC+ZA34J+pRMeDB6Xe7PCDHt0qqVBd?=
 =?iso-8859-1?Q?63+kl7bN3MnykzVweWzXPRSsHQjSVxFcOQbjcHUqfY1PcVaFFu6UPq7A4w?=
 =?iso-8859-1?Q?uWQAZTEIK87emzOAy0rpix5F6vmpm74nnM55NIdQmHcsXnbz/3Lc9asNT4?=
 =?iso-8859-1?Q?mL1JxBskdMoDHXz2myVpvQ48OBcqjAvO6jk3Y6xC5lUot1U7HJreV7dgqK?=
 =?iso-8859-1?Q?SKLdWPcBrM391dxIqHjDDfjgA1tnON7NJ+56yMqYYfU72Fkp+0StiMxAEV?=
 =?iso-8859-1?Q?hZyouwLxBSIlQIcTdhKioAnWS+OZ+6/dEQGYpDwAbXs+gl6yi/K2eFvbkN?=
 =?iso-8859-1?Q?osmjDy8JnYxw2LMQFsBJVRBe1/aKYT2DeiAlYSpEbKRxZSLEW0IzH5UmDt?=
 =?iso-8859-1?Q?DJPJXRqXXGs5Ed3olpBZl1YRX2Jj6yMZIk5WRdXEzFZHUYn9yml9cFhCJY?=
 =?iso-8859-1?Q?iTLE5PJLNbiDn1xX88VBrh+AI6jAKwx+ITRU7WXFeaFCk9A19PMNcByQ+Q?=
 =?iso-8859-1?Q?gXBadnlj9+PLsx/uJZLaE0BsnkRefL2iHD85/DGtwgc/edp0jM50vbZHR7?=
 =?iso-8859-1?Q?svVN1vn1vecmYfbrY4VBU0dhyQygBVbnANSlJ6v4G1XFhRnh4E9+gwXNJX?=
 =?iso-8859-1?Q?KoyZEOD+YXil0qViVQNKqD/383FBMXIlKV6Pp9fk+LYVSyMLRNXtsr6BZY?=
 =?iso-8859-1?Q?kpE2B9FrrLgV1hCtmGg6haNbQDQyUIAfb0Vgme4LEFaisF0bprc3/IWT/L?=
 =?iso-8859-1?Q?BIxmmMmfAEzEBIfR8JKCotUBYDIWAuN21r4TY/IFKTB4kHV2qwSRdn1LVC?=
 =?iso-8859-1?Q?ewXX/Xt4aSNDBBvOZz/pmCaNNWGnldE82fvYlYGU7k9QGMUwAIpuqPIhPi?=
 =?iso-8859-1?Q?IFn023DRFYLslrTEtcckxjDhtoG6Ssx50aYLODEjPXjeqmJvNSMz2mUhNu?=
 =?iso-8859-1?Q?wSvD39qeX462dh24m3vOgoqiDArnHomq4z5fwnTUEIaqKM3hcl3oQ2X2lb?=
 =?iso-8859-1?Q?2gMW7vRYtOiZFtOXSx4wBCRWQAwl12amaStjqotoxrZIrWk0+SluInfGEm?=
 =?iso-8859-1?Q?+hZbTce940aKecgP60EN6vLhDRdTn0Q0XGvCzvPnW3L1ZMsAhcKX3+N1h2?=
 =?iso-8859-1?Q?6UVHV/fCJndRKPBLb3amMzPE6u7ckpE6W0vhMz5yvP7Vo8jEhS2oLcWbWv?=
 =?iso-8859-1?Q?GIFiTdf4EGWAuVUNbdHJlE699iby6Su0dR0yK6tqI1MUVMY8+CyHlcsPyG?=
 =?iso-8859-1?Q?EL1Rr4CvcO6nAf0lDsywhHvGFwHhCQvFvm7x2dDUAxuH/FHJZ+mhtrdg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd508686-62f4-4c8c-528d-08dbc704481b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 07:09:01.0411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6o/jpmnpBAwvnvf6/k9U4jxJ6QCOORfrUD6kPNRGtWvLwYG2cvu2m6T+1ddkWA91b0ZjJGFmiQMusuPj4SJfdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5474
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 4.7% improvement of stress-ng.numa.ops_per_sec on:


commit: 24526268f4e38c9ec0c4a30de4f37ad2a2a84e47 ("mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and MPOL_MF_MOVE are specified")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
parameters:

	nr_threads: 1
	testtime: 60s
	class: cpu
	test: numa
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.numa.ops_per_sec 4.5% improvement                                          |
| test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
| test parameters  | class=os                                                                                        |
|                  | cpufreq_governor=performance                                                                    |
|                  | disk=1HDD                                                                                       |
|                  | fs=ext4                                                                                         |
|                  | nr_threads=1                                                                                    |
|                  | test=numa                                                                                       |
|                  | testtime=60s                                                                                    |
+------------------+-------------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231007/202310071416.df82eed7-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  cpu/gcc-12/performance/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/numa/stress-ng/60s

commit: 
  45120b1574 ("mm/damon/vaddr-test: fix memory leak in damon_do_test_apply_three_regions()")
  24526268f4 ("mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and MPOL_MF_MOVE are specified")

45120b15743fa7c0 24526268f4e38c9ec0c4a30de4f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    272.18 ± 77%     -99.9%       0.31 ±220%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1089            +4.7%       1141        stress-ng.numa.ops
     18.16            +4.7%      19.01        stress-ng.numa.ops_per_sec
     20387            +5.2%      21456        stress-ng.time.involuntary_context_switches
 2.173e+09            +3.6%  2.251e+09        perf-stat.i.branch-instructions
      0.50            -3.5%       0.48        perf-stat.i.cpi
 1.865e+09            +3.6%  1.932e+09        perf-stat.i.dTLB-loads
  1.06e+10            +3.4%  1.096e+10        perf-stat.i.instructions
      2.02            +3.8%       2.10        perf-stat.i.ipc
    130.34            +3.1%     134.39        perf-stat.i.metric.M/sec
      0.50            -3.6%       0.49        perf-stat.overall.cpi
      1.99            +3.7%       2.06        perf-stat.overall.ipc
 2.139e+09            +3.6%  2.216e+09        perf-stat.ps.branch-instructions
 1.836e+09            +3.6%  1.901e+09        perf-stat.ps.dTLB-loads
 1.043e+10            +3.4%  1.079e+10        perf-stat.ps.instructions
 6.597e+11            +3.4%  6.822e+11        perf-stat.total.instructions
     17.43 ±  5%      -1.9       15.50 ±  2%  perf-profile.calltrace.cycles-pp.queue_folios_pte_range.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range
     18.49 ±  4%      -1.9       16.61 ±  2%  perf-profile.calltrace.cycles-pp.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range
     19.07 ±  4%      -1.8       17.25 ±  2%  perf-profile.calltrace.cycles-pp.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_range
     19.67 ±  4%      -1.8       17.86 ±  2%  perf-profile.calltrace.cycles-pp.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_range.migrate_to_node
      3.76 ±  4%      -0.4        3.33 ±  9%  perf-profile.calltrace.cycles-pp.mt_find.find_vma.queue_pages_test_walk.walk_page_range.migrate_to_node
      3.94 ±  4%      -0.4        3.53 ±  8%  perf-profile.calltrace.cycles-pp.find_vma.queue_pages_test_walk.walk_page_range.migrate_to_node.do_migrate_pages
     17.60 ±  4%      -1.9       15.71 ±  2%  perf-profile.children.cycles-pp.queue_folios_pte_range
     18.50 ±  4%      -1.9       16.63 ±  2%  perf-profile.children.cycles-pp.walk_pmd_range
     19.11 ±  4%      -1.8       17.29 ±  2%  perf-profile.children.cycles-pp.walk_pud_range
     19.69 ±  4%      -1.8       17.88 ±  2%  perf-profile.children.cycles-pp.walk_p4d_range
     20.79 ±  4%      -1.8       19.02 ±  3%  perf-profile.children.cycles-pp.__walk_page_range
      0.08 ± 19%      +0.1        0.15 ± 17%  perf-profile.children.cycles-pp.rcu_all_qs
      0.27 ±  9%      +0.1        0.35 ± 13%  perf-profile.children.cycles-pp.__cond_resched
     11.70 ±  6%      -1.9        9.84        perf-profile.self.cycles-pp.queue_folios_pte_range
      2.01 ± 10%      -0.3        1.72 ±  6%  perf-profile.self.cycles-pp.vm_normal_folio
      0.14 ± 20%      +0.1        0.22 ± 16%  perf-profile.self.cycles-pp.__cond_resched


***************************************************************************************************
lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/numa/stress-ng/60s

commit: 
  45120b1574 ("mm/damon/vaddr-test: fix memory leak in damon_do_test_apply_three_regions()")
  24526268f4 ("mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and MPOL_MF_MOVE are specified")

45120b15743fa7c0 24526268f4e38c9ec0c4a30de4f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1023 ± 22%     -42.3%     590.75 ± 35%  sched_debug.cpu.nr_switches.min
      1096            +4.5%       1145        stress-ng.numa.ops
     18.26            +4.5%      19.08        stress-ng.numa.ops_per_sec
     20712 ±  2%      +4.6%      21663        stress-ng.time.involuntary_context_switches
      6.57 ± 17%      -1.4        5.17 ± 12%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      5.55 ± 15%      -1.0        4.55 ±  9%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      4.37 ± 17%      -0.8        3.60 ±  8%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      4.32 ± 17%      -0.7        3.57 ±  8%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      2.54 ± 17%      -0.5        2.08 ± 10%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.20 ± 28%      -0.1        0.13 ± 27%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.13 ± 19%      +0.1        0.20 ± 24%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
 2.068e+09            +3.7%  2.143e+09        perf-stat.i.branch-instructions
      0.55            -0.0        0.52        perf-stat.i.branch-miss-rate%
  12019422            -4.1%   11526701        perf-stat.i.branch-misses
      0.50            -3.5%       0.48        perf-stat.i.cpi
 1.767e+09            +3.6%   1.83e+09        perf-stat.i.dTLB-loads
 1.009e+10            +3.5%  1.044e+10        perf-stat.i.instructions
     19534            +2.4%      20010        perf-stat.i.instructions-per-iTLB-miss
      2.03            +3.7%       2.11        perf-stat.i.ipc
    123.98            +3.1%     127.81        perf-stat.i.metric.M/sec
      0.58            -0.0        0.54        perf-stat.overall.branch-miss-rate%
      0.49            -3.6%       0.48        perf-stat.overall.cpi
     17843            +2.3%      18252        perf-stat.overall.instructions-per-iTLB-miss
      2.02            +3.7%       2.10        perf-stat.overall.ipc
 2.035e+09            +3.7%   2.11e+09        perf-stat.ps.branch-instructions
  11834693            -4.1%   11344043        perf-stat.ps.branch-misses
 1.739e+09            +3.6%  1.801e+09        perf-stat.ps.dTLB-loads
    497472            +1.6%     505490        perf-stat.ps.iTLB-loads
 9.932e+09            +3.5%  1.028e+10        perf-stat.ps.instructions
 6.277e+11            +3.7%  6.512e+11        perf-stat.total.instructions





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

