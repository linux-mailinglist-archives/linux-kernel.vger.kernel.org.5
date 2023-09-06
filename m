Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17134793440
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 05:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbjIFDxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 23:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjIFDxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 23:53:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC01A1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 20:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693972390; x=1725508390;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=FJmgdK5W2nIvKBboD61VPTK8SILe9PdKF4JhehnxnDI=;
  b=IBvGfeS+a9sD9nPEHEoFs3YDXBKMAEwp/qE4BOkHmruOVEcr4qdwEDbg
   DKhtusivjorN9xJP9v+h9vGsO9mM6WSIRSIWHHS/GXNJZt5kw4feGQ47A
   4F7MvZCFbwmmdOzo5JqCIwwGEVojWwRKU7N0WcmTwdYiGLBcQBWnbGtkx
   dJcvyezoyGoSsulUjOrRW0yyI/aOieIzYE9Dwiwb7HSXZkQL6Q/m/kdq9
   GEgHEN0X01lNxhQp0P8qPYbqg6HDqfWQkNar9FsQ8Eg/DLZGFxkE8dTfo
   +OG5oKLXrIwFmmrM/mlHvGNgyoSGk17Xn+EwgrUFoNnALtkNaaldgJSuT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="361992594"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="361992594"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 20:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="884537011"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="884537011"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 20:52:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 20:53:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 20:53:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 20:53:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 20:53:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdFLcWOZG0lwBkHvnhQcR2Ht+ToVDZkLELP33pNRtKoqLKNuPNCOSCUhzD7nOLOflh0DdT6Y6uvvzN8xUcxy7wnHOvQeVDiACPOh1yJTqaZf6P2LQtdicvnk4rNN9/Bp3jq2d2PL+maSt9GzpNBZxwX6UF5sUg8n8qG6lawFmoglTt/Wxa6qAvNOn2V6ym+x38vGhZvB4XAVnwhenbnNMZJTb2U4huqg5zJ8tHIP+bsqsBXusxstL6I8DV7WojpjrJ//ZeZlkQW0wI61V996eEfXQYcQESj5mc+v4w775UfSBcmD+WTG4ei/4qnuD+0dz61mQoPVsJ8/jtMSAig4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5LGB4pM2VqZnKscfIltq4Wabzp7EpD+km9/zLSOoUQ=;
 b=ACpEp3EYDhtJRbvqiAGPHx0F56EaZaTl5CMZXTO2LIjREtC5lquA/sv57O204m/Zu9UBGRFz1/FbvytOhXbIdudcc8Qtv7mO1nGI5x+1tJLF3pCbSa3rS2d4UJvlt8VCie/GF1FrWz7mH2Sr9NX6hFiR4l3jx5vHkZY+OXdz64M+D2/RiPhId3Bjqt9e4tt3dYRbViNcX++eJEaitmH1N2yeVVg8fxLNUtw4eUo9GpCnVplGFUg7NO4PkTcyQ7fjQNwg/n0l3n88Kxfx2ic66mPGkKHlkVdVWQ0aNsiI/l77lEJRep/YzWWd11nwSSS1+gyhsGZ5xB2bj3RRKBw9+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BL1PR11MB5288.namprd11.prod.outlook.com (2603:10b6:208:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 03:52:59 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 03:52:59 +0000
Date:   Wed, 6 Sep 2023 11:52:45 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Deng Pan <pan.deng@intel.com>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        David Vernet <void@manifault.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 1/1] sched/fair: ratelimit update to tg->load_avg
Message-ID: <202309061004.94b065e5-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823060832.454842-2-aaron.lu@intel.com>
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BL1PR11MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: c022a4ac-524f-4155-c5f5-08dbae8cc2a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s3pSOxqfki41idwPy93rL8Q3DCAzyBuG3HvzHytvUA+osZbq4O0PRuWYLQ9vgMtgdp41PvK9hMG9AbyMlVAHFYA+02XDCqj6GI9xP6y+X5v4Ux3R4NyGuZPtEYrSUTKu7AuGOD0jHkvjsZd31l3ACRExTaQyml1KV00IixsWfAf9df14QYbVM/O6ms4JS/rEnwA+Lg4yMrjeOyBacRDWSOvax85nZ8Xs+YT/BBnntNUfrHbkHTcaKiG+2OR6Ttk7+u2erkTPPbXYOga+bm36HXxlbVO2Y9sqq/F4kuMDZhc9DzsLuBhzQJQJvEoDoU1+SkLBv+d7VDobVzzO4us0s1quzJjuxMDDbjVlg6qFl7zaKIBmHY5f2V17K/U00daX3E9nK5q9G7Ht5oD7qo12ADSPyFjFIOm9uD5yiVzYqtuSXOOnQ2dHDw9yMWskw0CSDsSJFa5eAkGxyOcc0Q3oVfj/dvNxh+m651PErSESQTFgnL+7xxPcHx6GgWLtYr5ZP8hO1dP0aXy18inYQuw8yhsft6gVFN6s2QhxuElJz8SHP8wQysbX/kba0JSTfokGJzjKWwtT/dZzVEk2qweeWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199024)(186009)(1800799009)(6666004)(6506007)(6486002)(82960400001)(86362001)(36756003)(38100700002)(1076003)(2906002)(26005)(30864003)(2616005)(15650500001)(19627235002)(966005)(6512007)(83380400001)(478600001)(316002)(66946007)(8676002)(8936002)(5660300002)(6862004)(4326008)(7416002)(6636002)(41300700001)(66556008)(37006003)(54906003)(66476007)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?62PsDzg+5Qhw8x39RswTwf5w84OrLP3fBE9rqpgwihh6/O5Um1eDwh/Erh?=
 =?iso-8859-1?Q?W8uIL1BXV4pnitw6MmKLZn9G2UD33H7dHqf+rAc+aAzlYKAjeYdJ2z7UIz?=
 =?iso-8859-1?Q?W6pJRX2Q2ifWspK85F9ym2JDghbcGhV+nYTzvtWMKvBE1JpySCE5Q6T3wA?=
 =?iso-8859-1?Q?Vn93WqI3abExwP4EVN7ps6vHULclfT7nxNxgokFHYxOkJ+eiSoEWKaEiE8?=
 =?iso-8859-1?Q?8MjNFQn0XrZqPiDqiopuredwjfEWz2X7gYkqJFYIBdI5CljRx0EJDaSTZF?=
 =?iso-8859-1?Q?r8gTK9HxlANuoq9wSmEMcdcF5Ci2tKTT3f7u/Bw4i4H52p/XISZ/orU+oI?=
 =?iso-8859-1?Q?wKozgNsxfoiljP7HHwDhu9x6yntonCj9i56lI0UPEQDEX8JXhYsIiqzVVy?=
 =?iso-8859-1?Q?HxCA5xnZGDL5qbTB9ArWGLfSQa1I5an8byGjktWE/RB5MHnZJUFvFiaFZ3?=
 =?iso-8859-1?Q?DmLjaDQZnjzVPXwHfR3XjzsVmRadtqvvwFe1tgVCs7LtgDQESB0yOFO33f?=
 =?iso-8859-1?Q?9lvu46PJ5Cbd8Og9CjnrVDFft0slpCxXWDmCMiC7vvo6J6sjNhoOLwWjBm?=
 =?iso-8859-1?Q?lFXhVhMnPV47NzW66MkdZdVSDtn/244In/B/pAZGkQ2M5qZjjnP27v4fmz?=
 =?iso-8859-1?Q?vcK4ePoECapQyXLboSrY5JhhABZOLo811O2ENzTqhPVipEgo60pgDEKz64?=
 =?iso-8859-1?Q?KJM17yG77bb2oYeRFyoSgYi7arBJXmfP9Ob51bdgHNIzArx8Xhi80r6Mtt?=
 =?iso-8859-1?Q?i389tNUvAU5wo8B/WcwiPFP1nEGstc7PjiWK8cuj1/GPedCi8FVJ3Ovlt9?=
 =?iso-8859-1?Q?7IfUCNeBWHJ+bD5rvpyh+c7AEjFafHmy/Z+zNHc0nEElYUOmLJquVlQq+I?=
 =?iso-8859-1?Q?jHqRwsBUF1vkzWmhwEcYXZ77rfniHHkkxByh8CsI9m6jzO1yOlPT9+7Cxa?=
 =?iso-8859-1?Q?0ywnDZ2txt0D9y++ttPzTlmgb8rbnjP6CztmhCchQ0i7Y4MbRxeduGl/Lt?=
 =?iso-8859-1?Q?vutmsS5v4RoSkcC+b/rvGbIlegOjZkcrexNmLTHex5g3n15mox/P60hZCt?=
 =?iso-8859-1?Q?4LMD/twvC1HxBmCwjhjrqOs/a9XKVo3AH0bE5+2moPqRmEKHEF66rwGcoR?=
 =?iso-8859-1?Q?7MgbNUDtnIagxFojv1lsl5kF5PAp17tX41l6d2djve/MBWIxZQSxSHVx07?=
 =?iso-8859-1?Q?N0Ajnji3jKjXhXl70b3YfHliUz8cXAsTPNGVnOWX02dN3Xzp0sGRuFM4cm?=
 =?iso-8859-1?Q?H0lmOiANAGof8RnFtAx+G4+7DfLZCiq7ErapO6TTtCNcRiT3wAylplI27F?=
 =?iso-8859-1?Q?KEK7R4hI8/XxxIULM8mKwxqNt+H/WJnEMmYqwXnLcfd6U4sKdM0KRMfZpv?=
 =?iso-8859-1?Q?M3+kr56V3u6ZIz8AWD9/B0G4acsGrTy7qmH9z3zI5NVqQYiu1ZTPfKoG5g?=
 =?iso-8859-1?Q?I/+Qu0ez71Zzhnl8+Nvmsuan48cV9aodpIEZQXeEXGaBVpZCbaGbI4fTi8?=
 =?iso-8859-1?Q?K/0NSmiCzjRfTra1FmI5GkF0iJZcIzesuxa978nTWvdb2N7tU25xvjXAix?=
 =?iso-8859-1?Q?BjFMGqg6B39hacmSEumNwNGtBhrCyRwRR7K3WO5qElVfrx465PVI+cezf0?=
 =?iso-8859-1?Q?T3tqK2gSDZvVRr8maE6J6GwWlnzIzLoyyRkMCE1ocIm/528ndXeZvb0g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c022a4ac-524f-4155-c5f5-08dbae8cc2a3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 03:52:59.5352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XewFH+53ceJu2fVheETooX4dlkS8y3F3455+mrdk7usYznEcZarfhaHzXrpMNNPnpZoQZmj+Bqq1vrQhhjr8Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5288
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed a 141.1% improvement of stress-ng.nanosleep.ops_per_sec on:


commit: 0a24d7afed5c3c59ee212782f9c902c7ada6c3a8 ("[PATCH 1/1] sched/fair: ratelimit update to tg->load_avg")
url: https://github.com/intel-lab-lkp/linux/commits/Aaron-Lu/sched-fair-ratelimit-update-to-tg-load_avg/20230823-141042
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 63304558ba5dcaaff9e052ee43cfdcc7f9c29e85
patch link: https://lore.kernel.org/all/20230823060832.454842-2-aaron.lu@intel.com/
patch subject: [PATCH 1/1] sched/fair: ratelimit update to tg->load_avg

testcase: stress-ng
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	sc_pid_max: 4194304
	class: scheduler
	test: nanosleep
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.sem.ops_per_sec 120.7% improvement                                     |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory |
| test parameters  | class=scheduler                                                                             |
|                  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | sc_pid_max=4194304                                                                          |
|                  | test=sem                                                                                    |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.switch.ops_per_sec 422.1% improvement                                  |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory |
| test parameters  | class=scheduler                                                                             |
|                  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | sc_pid_max=4194304                                                                          |
|                  | test=switch                                                                                 |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230906/202309061004.94b065e5-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/sc_pid_max/tbox_group/test/testcase/testtime:
  scheduler/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/4194304/lkp-spr-r02/nanosleep/stress-ng/60s

commit: 
  63304558ba ("sched/eevdf: Curb wakeup-preemption")
  0a24d7afed ("sched/fair: ratelimit update to tg->load_avg")

63304558ba5dcaaf 0a24d7afed5c3c59ee212782f9c 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.114e+09 ±  5%     +99.5%  2.223e+09 ±  2%  cpuidle..time
  32153856 ±  6%    +989.9%  3.505e+08        cpuidle..usage
    447243 ± 17%    +164.1%    1181057 ± 29%  numa-numastat.node0.numa_hit
   1795453 ±  9%     +45.6%    2613814 ± 13%  numa-numastat.node1.local_node
   1926792 ±  6%     +41.7%    2729682 ± 13%  numa-numastat.node1.numa_hit
      1211 ± 14%     +60.4%       1944 ± 15%  perf-c2c.DRAM.local
     43481 ±  4%    +115.6%      93764 ±  2%  perf-c2c.HITM.local
      2142 ±  8%     +18.6%       2540 ±  4%  perf-c2c.HITM.remote
     45623 ±  3%    +111.1%      96304 ±  2%  perf-c2c.HITM.total
      6.50 ±  8%      +9.2       15.72 ±  4%  mpstat.cpu.all.idle%
     63.25            -8.8       54.48        mpstat.cpu.all.irq%
      0.23 ±  3%      -0.1        0.13 ±  2%  mpstat.cpu.all.soft%
     23.74            -5.1       18.68        mpstat.cpu.all.sys%
      6.26 ±  4%      +4.7       10.99        mpstat.cpu.all.usr%
      8.67 ± 10%    +103.8%      17.67 ±  4%  vmstat.cpu.id
   6780737 ±  4%     +62.2%   11001409        vmstat.memory.cache
    807.67           -45.4%     441.17 ±  3%  vmstat.procs.r
   9455773 ±  3%    +190.9%   27507213        vmstat.system.cs
   2332672 ±  3%    +135.7%    5497135        vmstat.system.in
      8442 ±125%    +361.9%      38993 ± 42%  numa-meminfo.node0.Active
      8394 ±126%    +364.0%      38945 ± 42%  numa-meminfo.node0.Active(anon)
   3920452 ±  8%     +59.6%    6258302 ± 13%  numa-meminfo.node1.FilePages
   4046956 ±  8%     +61.7%    6543199 ± 12%  numa-meminfo.node1.Inactive
   4046855 ±  8%     +61.7%    6542806 ± 12%  numa-meminfo.node1.Inactive(anon)
    809538           +23.4%     999251        numa-meminfo.node1.Mapped
   5779147 ±  5%     +44.2%    8333883 ± 11%  numa-meminfo.node1.MemUsed
   3797230 ±  8%     +63.2%    6195756 ± 12%  numa-meminfo.node1.Shmem
   6594006 ±  4%     +63.2%   10760383        meminfo.Cached
  20357957           +20.8%   24592848        meminfo.Committed_AS
  10202112 ±  4%     +12.1%   11439445 ±  4%  meminfo.DirectMap2M
   4594955 ±  7%     +90.9%    8772956        meminfo.Inactive
   4594801 ±  7%     +90.9%    8772510        meminfo.Inactive(anon)
   1244823           +15.3%    1435693        meminfo.Mapped
  10703248 ±  3%     +39.2%   14903502        meminfo.Memused
   3850091 ±  8%    +108.2%    8016158        meminfo.Shmem
  10828684 ±  3%     +38.8%   15024943        meminfo.max_used_kB
    191619 ±  2%     -62.9%      71181        stress-ng.nanosleep.nanosec_sleep_overrun
  27467749 ±  2%    +141.1%   66219303        stress-ng.nanosleep.ops
    457768 ±  2%    +141.1%    1103623        stress-ng.nanosleep.ops_per_sec
  34002509           -32.1%   23081269 ±  3%  stress-ng.time.involuntary_context_switches
     45135 ±  2%     +10.2%      49751        stress-ng.time.minor_page_faults
      4740 ±  2%     +58.5%       7515        stress-ng.time.percent_of_cpu_this_job_got
      2387 ±  2%     +26.6%       3022        stress-ng.time.system_time
    566.06 ±  4%    +191.5%       1650        stress-ng.time.user_time
 5.218e+08 ±  2%    +140.9%  1.257e+09        stress-ng.time.voluntary_context_switches
      2100 ±126%    +364.0%       9746 ± 42%  numa-vmstat.node0.nr_active_anon
      2100 ±126%    +364.0%       9746 ± 42%  numa-vmstat.node0.nr_zone_active_anon
    447538 ± 17%    +163.9%    1181134 ± 29%  numa-vmstat.node0.numa_hit
    978909 ±  8%     +59.9%    1564891 ± 13%  numa-vmstat.node1.nr_file_pages
   1010763 ±  8%     +61.9%    1636024 ± 12%  numa-vmstat.node1.nr_inactive_anon
    201775           +23.8%     249732        numa-vmstat.node1.nr_mapped
    948105 ±  8%     +63.4%    1549255 ± 12%  numa-vmstat.node1.nr_shmem
   1010756 ±  8%     +61.9%    1636022 ± 12%  numa-vmstat.node1.nr_zone_inactive_anon
   1926790 ±  6%     +41.7%    2730098 ± 13%  numa-vmstat.node1.numa_hit
   1795451 ±  9%     +45.6%    2614231 ± 13%  numa-vmstat.node1.numa_local
  23571016 ±  6%   +1005.6%  2.606e+08        turbostat.C1
      0.62 ±  7%      +4.5        5.12 ±  4%  turbostat.C1%
      6.52 ±  6%     +55.6%      10.15 ±  4%  turbostat.CPU%c1
      0.11 ±  3%    +134.3%       0.26        turbostat.IPC
 1.523e+08 ±  3%    +135.8%   3.59e+08        turbostat.IRQ
   4826320 ±  8%   +1620.7%   83044122 ±  4%  turbostat.POLL
      1.18 ±  4%      +3.2        4.39 ±  3%  turbostat.POLL%
     35.50 ±  2%      +9.4%      38.83 ±  4%  turbostat.PkgTmp
    606.26           +11.4%     675.12        turbostat.PkgWatt
     17.82            +8.1%      19.27        turbostat.RAMWatt
    221604            +3.6%     229668        proc-vmstat.nr_anon_pages
   6286339            -1.7%    6181379        proc-vmstat.nr_dirty_background_threshold
  12588050            -1.7%   12377872        proc-vmstat.nr_dirty_threshold
   1647119 ±  4%     +63.3%    2690349        proc-vmstat.nr_file_pages
  63240215            -1.7%   62188983        proc-vmstat.nr_free_pages
   1147706 ±  7%     +91.1%    2193365        proc-vmstat.nr_inactive_anon
    310602           +15.6%     358915        proc-vmstat.nr_mapped
    961140 ±  8%    +108.5%    2004292        proc-vmstat.nr_shmem
     40821            +5.6%      43093        proc-vmstat.nr_slab_reclaimable
   1147706 ±  7%     +91.1%    2193365        proc-vmstat.nr_zone_inactive_anon
    307036 ±  6%     +18.3%     363373 ±  6%  proc-vmstat.numa_hint_faults
    174792 ±  4%     +47.6%     257908 ±  8%  proc-vmstat.numa_hint_faults_local
   2376244 ±  4%     +64.7%    3912565        proc-vmstat.numa_hit
   2148067 ±  5%     +71.1%    3675698        proc-vmstat.numa_local
     74658 ± 15%     +32.3%      98789 ±  8%  proc-vmstat.numa_pages_migrated
    845358 ±  5%     +16.6%     985918 ±  4%  proc-vmstat.numa_pte_updates
   2651749 ±  4%     +58.7%    4208257        proc-vmstat.pgalloc_normal
   1178205           +11.3%    1310935        proc-vmstat.pgfault
     74658 ± 15%     +32.3%      98789 ±  8%  proc-vmstat.pgmigrate_success
   1619572 ±  4%     +31.0%    2121483 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.avg
   1384229 ±  2%     +21.2%    1678009 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.min
      2.14 ±  4%     -49.5%       1.08 ±  5%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.59 ±  7%     -23.0%       1.23 ± 10%  sched_debug.cfs_rq:/.h_nr_running.stddev
    755771 ±  4%     +21.1%     914988 ±  7%  sched_debug.cfs_rq:/.left_vruntime.stddev
   1619572 ±  4%     +31.0%    2121483 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
   1384229 ±  2%     +21.2%    1678009 ±  6%  sched_debug.cfs_rq:/.min_vruntime.min
      0.51           -13.3%       0.44 ±  2%  sched_debug.cfs_rq:/.nr_running.avg
      0.25 ±  6%     +25.7%       0.32 ±  4%  sched_debug.cfs_rq:/.nr_running.stddev
    755771 ±  4%     +21.1%     914988 ±  7%  sched_debug.cfs_rq:/.right_vruntime.stddev
      2098           -56.3%     916.79 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
      5955 ±  6%     -56.7%       2580 ± 51%  sched_debug.cfs_rq:/.runnable_avg.max
    789.15 ±  6%     -55.7%     349.41 ± 20%  sched_debug.cfs_rq:/.runnable_avg.stddev
    307.62           +22.2%     375.91        sched_debug.cfs_rq:/.util_avg.avg
     24.31 ±  5%     -33.7%      16.12 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    519896 ±  8%      -9.5%     470290 ±  2%  sched_debug.cpu.avg_idle.avg
     34.99 ±  9%     -64.1%      12.55 ±  4%  sched_debug.cpu.clock.stddev
     64962 ± 54%     -60.1%      25901 ± 75%  sched_debug.cpu.max_idle_balance_cost.stddev
      1.99 ±  3%     -49.2%       1.01 ±  6%  sched_debug.cpu.nr_running.avg
      1.58 ±  8%     -24.8%       1.19 ± 10%  sched_debug.cpu.nr_running.stddev
   1312627 ±  3%    +189.6%    3801969        sched_debug.cpu.nr_switches.avg
   1454886 ±  2%    +180.8%    4084862        sched_debug.cpu.nr_switches.max
    520509 ± 19%    +118.1%    1135305 ±  6%  sched_debug.cpu.nr_switches.min
    107407 ± 27%    +121.0%     237364        sched_debug.cpu.nr_switches.stddev
      1.54 ± 16%     -30.7%       1.06 ±  4%  sched_debug.rt_rq:.rt_time.avg
    344.38 ± 16%     -30.7%     238.55 ±  4%  sched_debug.rt_rq:.rt_time.max
     22.96 ± 16%     -30.7%      15.90 ±  4%  sched_debug.rt_rq:.rt_time.stddev
     21.30            -7.6%      19.68        perf-stat.i.MPKI
 2.464e+10 ±  2%    +116.4%  5.333e+10        perf-stat.i.branch-instructions
      2.35            -0.2        2.15        perf-stat.i.branch-miss-rate%
 5.179e+08 ±  3%    +104.0%  1.056e+09        perf-stat.i.branch-misses
  24433597 ±  4%    +134.2%   57211897        perf-stat.i.cache-misses
 2.292e+09 ±  3%    +117.1%  4.977e+09        perf-stat.i.cache-references
   9691167 ±  2%    +192.2%   28317740        perf-stat.i.context-switches
      5.50 ±  2%     -58.0%       2.31        perf-stat.i.cpi
 6.037e+11            -2.5%  5.886e+11        perf-stat.i.cpu-cycles
   2763209 ±  6%    +493.6%   16401859        perf-stat.i.cpu-migrations
     27315 ±  5%     -58.5%      11336        perf-stat.i.cycles-between-cache-misses
      0.27 ±  3%      +0.1        0.38 ±  5%  perf-stat.i.dTLB-load-miss-rate%
  75642414 ±  6%    +234.9%  2.534e+08 ±  5%  perf-stat.i.dTLB-load-misses
 2.882e+10 ±  2%    +133.7%  6.734e+10        perf-stat.i.dTLB-loads
      0.09            +0.0        0.12        perf-stat.i.dTLB-store-miss-rate%
  11815823 ±  4%    +250.9%   41464964        perf-stat.i.dTLB-store-misses
 1.431e+10 ±  2%    +154.8%  3.647e+10        perf-stat.i.dTLB-stores
 1.179e+11 ±  2%    +125.2%  2.655e+11        perf-stat.i.instructions
      0.22 ±  4%    +107.2%       0.46        perf-stat.i.ipc
      2.69            -2.5%       2.63        perf-stat.i.metric.GHz
    168.78 ±  3%    +191.3%     491.66        perf-stat.i.metric.K/sec
    312.66 ±  2%    +131.4%     723.39        perf-stat.i.metric.M/sec
     83.64            -4.6       79.07        perf-stat.i.node-load-miss-rate%
   8492785 ±  5%     +91.4%   16253628        perf-stat.i.node-load-misses
   1978671 ±  8%    +156.8%    5080695 ±  3%  perf-stat.i.node-loads
     20.13            -5.6%      19.01        perf-stat.overall.MPKI
      2.17            -0.2        2.01        perf-stat.overall.branch-miss-rate%
      1.04 ±  4%      +0.1        1.14        perf-stat.overall.cache-miss-rate%
      5.27 ±  2%     -57.4%       2.24        perf-stat.overall.cpi
     25098 ±  4%     -58.6%      10384        perf-stat.overall.cycles-between-cache-misses
      0.27 ±  3%      +0.1        0.38 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.08            +0.0        0.11        perf-stat.overall.dTLB-store-miss-rate%
      0.19 ±  2%    +134.7%       0.45        perf-stat.overall.ipc
     78.22 ±  2%      -3.3       74.96        perf-stat.overall.node-load-miss-rate%
 2.351e+10 ±  2%    +121.2%    5.2e+10        perf-stat.ps.branch-instructions
 5.098e+08 ±  3%    +105.1%  1.046e+09        perf-stat.ps.branch-misses
  23627740 ±  4%    +136.8%   55950974        perf-stat.ps.cache-misses
 2.265e+09 ±  3%    +117.5%  4.927e+09        perf-stat.ps.cache-references
   9507437 ±  2%    +194.8%   28026780        perf-stat.ps.context-switches
    217084            +1.3%     219882        perf-stat.ps.cpu-clock
  5.92e+11            -1.9%  5.809e+11        perf-stat.ps.cpu-cycles
   2705311 ±  6%    +500.2%   16238454        perf-stat.ps.cpu-migrations
  73862253 ±  5%    +238.6%  2.501e+08 ±  5%  perf-stat.ps.dTLB-load-misses
  2.76e+10 ±  2%    +138.7%  6.588e+10        perf-stat.ps.dTLB-loads
  11580338 ±  4%    +254.4%   41039686        perf-stat.ps.dTLB-store-misses
 1.367e+10 ±  2%    +161.0%  3.568e+10        perf-stat.ps.dTLB-stores
 1.125e+11 ±  2%    +130.3%  2.592e+11        perf-stat.ps.instructions
     17267 ±  2%     +11.0%      19173        perf-stat.ps.minor-faults
   8196664 ±  5%     +94.6%   15947509        perf-stat.ps.node-load-misses
   2277667 ±  7%    +134.0%    5330072 ±  4%  perf-stat.ps.node-loads
     17267 ±  2%     +11.0%      19173        perf-stat.ps.page-faults
    217084            +1.3%     219882        perf-stat.ps.task-clock
 7.044e+12 ±  2%    +129.7%  1.618e+13        perf-stat.total.instructions
     13.44           -13.4        0.00        perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_task_fair.__schedule.schedule.do_nanosleep
     17.47           -12.7        4.76        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
     39.60 ±  2%     -12.5       27.06        perf-profile.calltrace.cycles-pp.__schedule.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep
     12.30 ±  2%     -12.3        0.00        perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup
     39.94           -12.2       27.71        perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     12.32 ±  3%     -12.2        0.17 ±141%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues
     12.43 ±  2%     -11.9        0.54        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
     43.43           -10.2       33.22        perf-profile.calltrace.cycles-pp.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64
     20.08            -9.9       10.20        perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     44.17            -9.7       34.48        perf-profile.calltrace.cycles-pp.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
     44.22            -9.6       34.58        perf-profile.calltrace.cycles-pp.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     45.34            -8.8       36.51        perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     10.46 ±  2%      -8.0        2.44        perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      7.82 ±  3%      -7.8        0.00        perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
     44.86            -7.8       37.06        perf-profile.calltrace.cycles-pp.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
     44.88            -7.8       37.12        perf-profile.calltrace.cycles-pp.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
     45.94            -7.6       38.34        perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     12.12            -7.6        4.52        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
     12.05            -7.6        4.48        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.flush_smp_call_function_queue.do_idle.cpu_startup_entry
     11.96            -7.5        4.46        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.flush_smp_call_function_queue.do_idle
     11.95            -7.5        4.44        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.flush_smp_call_function_queue
     10.99            -7.1        3.91        perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq
     47.61            -6.9       40.70        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     47.91            -6.6       41.28        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     22.37 ±  3%      -6.6       15.82        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch
     22.41 ±  3%      -6.5       15.86        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule
      6.41 ±  3%      -5.7        0.70        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      6.40 ±  2%      -4.7        1.70        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
     16.05 ±  4%      -4.7       11.35        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule.do_nanosleep
     15.91 ±  4%      -4.7       11.22        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule
      4.88 ±  2%      -4.3        0.55        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
     16.36 ±  4%      -3.8       12.61        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      8.95            -3.6        5.34        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
     53.17            -3.3       49.84        perf-profile.calltrace.cycles-pp.clock_nanosleep
      6.38 ±  2%      -2.9        3.53        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
      6.41 ±  2%      -2.8        3.63        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
     40.76            -2.4       38.40        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     40.82            -2.3       38.53        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     41.01            -2.3       38.72        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     40.82            -2.3       38.54        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      6.52 ±  2%      -2.2        4.28        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      6.81            -2.1        4.72        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule_idle
      6.84            -2.1        4.77        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule_idle.do_idle
      6.67 ±  2%      -1.7        4.99        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      2.09            -1.6        0.51        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.finish_task_switch.__schedule.schedule_idle.do_idle
     23.74            -1.0       22.79        perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up
     10.21            -0.7        9.54        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
     10.43            -0.6        9.85        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.07 ±  4%      -0.4        0.67        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.cpuidle_enter_state
      1.07 ±  4%      -0.4        0.69        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.cpuidle_enter_state.cpuidle_enter
      1.08 ±  4%      -0.4        0.72        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      2.82 ±  2%      -0.3        2.48        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.do_nanosleep
      1.08 ±  4%      -0.3        0.80        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.07 ±  6%      -0.3        0.82        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.nohz_run_idle_balance.do_idle.cpu_startup_entry.start_secondary
      1.06 ±  6%      -0.2        0.82        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.nohz_run_idle_balance.do_idle.cpu_startup_entry
      1.05 ±  6%      -0.2        0.80        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.nohz_run_idle_balance.do_idle
      1.05 ±  6%      -0.2        0.80        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.nohz_run_idle_balance
      0.70 ±  6%      -0.2        0.54        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_idle.cpu_startup_entry.start_secondary
      0.67 ±  7%      -0.2        0.52        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.nohz_run_idle_balance.do_idle.cpu_startup_entry
      0.70 ±  6%      -0.2        0.54        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.69 ±  6%      -0.2        0.54        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_idle.cpu_startup_entry
      0.69 ±  6%      -0.2        0.53        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_idle
      0.68 ±  7%      -0.1        0.56        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.nohz_run_idle_balance.do_idle.cpu_startup_entry.start_secondary
      0.57 ±  4%      +0.1        0.67        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.54            +0.2        0.74        perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.87            +0.2        1.09        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.76            +0.2        0.99        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.hrtimer_active.hrtimer_try_to_cancel
      0.78            +0.2        1.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.hrtimer_active.hrtimer_try_to_cancel.do_nanosleep.hrtimer_nanosleep
      0.76            +0.2        0.99        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.hrtimer_active
      0.77            +0.2        1.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.hrtimer_active.hrtimer_try_to_cancel.do_nanosleep
      0.80            +0.3        1.08        perf-profile.calltrace.cycles-pp.__hrtimer_start_range_ns.hrtimer_start_range_ns.do_nanosleep.hrtimer_nanosleep.common_nsleep
      0.76 ±  2%      +0.3        1.05        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_nanosleep
      0.76 ±  2%      +0.3        1.05        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_nanosleep.hrtimer_nanosleep
      0.77 ±  2%      +0.3        1.06        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_nanosleep.hrtimer_nanosleep.common_nsleep
      0.78 ±  3%      +0.3        1.06        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.61 ±  2%      +0.4        1.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.59 ±  2%      +0.4        0.98        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.59 ±  2%      +0.4        0.98        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.60 ±  2%      +0.4        0.99        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.99 ±  5%      +0.4        1.41 ±  4%  perf-profile.calltrace.cycles-pp.stress_mwc32
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.tick_nohz_idle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.07            +0.5        1.61        perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00            +0.5        0.55 ±  2%  perf-profile.calltrace.cycles-pp.set_task_cpu.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      0.58 ±  2%      +0.6        1.14        perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.llist_reverse_order.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      0.00            +0.6        0.58 ±  2%  perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.00            +0.6        0.60        perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      0.87 ±  3%      +0.6        1.46 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.stress_pthread_func
      0.90 ±  4%      +0.6        1.50 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.stress_pthread_func
      0.87 ±  3%      +0.6        1.47 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.stress_pthread_func
      0.87 ±  3%      +0.6        1.48 ±  3%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.stress_pthread_func
      0.00            +0.6        0.61 ±  2%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.6        0.62 ± 11%  perf-profile.calltrace.cycles-pp.__nanosleep
      1.30            +0.6        1.92        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00            +0.7        0.66        perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.7        0.67        perf-profile.calltrace.cycles-pp._copy_from_user.get_timespec64.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.70        perf-profile.calltrace.cycles-pp.__switch_to.clock_nanosleep
      0.58 ±  3%      +0.7        1.28        perf-profile.calltrace.cycles-pp.__switch_to_asm.clock_nanosleep
      0.00            +0.7        0.72 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clock_gettime
      0.00            +0.7        0.73 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clock_gettime
      0.00            +0.7        0.73 ±  3%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clock_gettime
      0.00            +0.7        0.74 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.clock_gettime
      0.00            +0.8        0.78        perf-profile.calltrace.cycles-pp.get_timespec64.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.00            +0.8        0.78        perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.00            +0.8        0.83 ±  3%  perf-profile.calltrace.cycles-pp.__update_idle_core.pick_next_task_idle.__schedule.schedule.do_nanosleep
      0.00            +0.8        0.84 ±  3%  perf-profile.calltrace.cycles-pp.pick_next_task_idle.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
     25.15            +0.9       26.05        perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up.hrtimer_wakeup
      0.00            +0.9        0.92        perf-profile.calltrace.cycles-pp.__switch_to_asm
      2.94 ±  2%      +0.9        3.87        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clock_nanosleep
      3.09 ±  2%      +0.9        4.02        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.clock_nanosleep
      2.96 ±  2%      +0.9        3.89        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clock_nanosleep
      2.95 ±  2%      +0.9        3.88        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clock_nanosleep
      1.44            +1.0        2.41        perf-profile.calltrace.cycles-pp.hrtimer_active.hrtimer_try_to_cancel.do_nanosleep.hrtimer_nanosleep.common_nsleep
      1.40 ±  2%      +1.0        2.41        perf-profile.calltrace.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00            +1.0        1.04        perf-profile.calltrace.cycles-pp.sched_mm_cid_migrate_to.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.50            +1.1        2.58        perf-profile.calltrace.cycles-pp.hrtimer_try_to_cancel.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     25.25            +1.1       26.32        perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues
      3.13            +1.1        4.22        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.13            +1.1        4.23        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
     25.31            +1.1       26.42        perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      3.16            +1.1        4.31        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      3.17            +1.2        4.34        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.80 ±  8%      +1.3        2.11 ± 11%  perf-profile.calltrace.cycles-pp.clock_gettime
      0.00            +1.4        1.44        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule_idle.do_idle.cpu_startup_entry
      1.98            +1.5        3.45        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      2.04            +1.6        3.59        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      1.75 ±  2%      +1.6        3.37        perf-profile.calltrace.cycles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.92 ±  4%      +1.9        3.86 ±  2%  perf-profile.calltrace.cycles-pp.stress_pthread_func
      0.17 ±141%      +2.2        2.39        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.03 ±  2%      +2.4        3.40        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle
      1.03 ±  2%      +2.4        3.40        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state
      1.04 ±  2%      +2.4        3.45        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state.cpuidle_enter
      1.05 ±  2%      +2.4        3.48        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.37 ±  3%      +3.8        5.15        perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +6.0        5.98        perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair
      6.17            +6.8       12.96        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      6.21            +6.9       13.08        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      6.68            +7.6       14.28        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.25            +8.6        9.84        perf-profile.calltrace.cycles-pp.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq
     30.81           -29.8        1.00 ±  9%  perf-profile.children.cycles-pp.update_cfs_group
     26.74           -21.1        5.60        perf-profile.children.cycles-pp.enqueue_task_fair
     27.45           -20.2        7.29        perf-profile.children.cycles-pp.activate_task
     27.66           -20.0        7.70        perf-profile.children.cycles-pp.ttwu_do_activate
     50.48           -13.5       37.02        perf-profile.children.cycles-pp.__schedule
     17.49           -12.7        4.78        perf-profile.children.cycles-pp.dequeue_task_fair
     40.51 ±  2%     -12.5       27.97        perf-profile.children.cycles-pp.schedule
     43.46           -10.2       33.28        perf-profile.children.cycles-pp.do_nanosleep
     20.27 ±  2%      -9.9       10.35        perf-profile.children.cycles-pp.flush_smp_call_function_queue
     44.18            -9.7       34.50        perf-profile.children.cycles-pp.hrtimer_nanosleep
     44.28            -9.6       34.72        perf-profile.children.cycles-pp.common_nsleep
     45.35            -8.8       36.53        perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
     12.11            -8.7        3.43        perf-profile.children.cycles-pp.enqueue_entity
     11.22            -7.8        3.41        perf-profile.children.cycles-pp.update_load_avg
     50.72            -7.7       42.98        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     51.22            -7.7       43.50        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     48.74            -7.7       41.08        perf-profile.children.cycles-pp.try_to_wake_up
     25.96 ±  3%      -7.7       18.30        perf-profile.children.cycles-pp.finish_task_switch
     48.74            -7.6       41.10        perf-profile.children.cycles-pp.hrtimer_wakeup
     49.92            -7.6       42.28        perf-profile.children.cycles-pp.__hrtimer_run_queues
     50.13            -7.5       42.59        perf-profile.children.cycles-pp.hrtimer_interrupt
     50.20            -7.5       42.70        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     47.73            -7.0       40.77        perf-profile.children.cycles-pp.do_syscall_64
     48.02            -6.7       41.34        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     12.52 ±  2%      -5.9        6.60        perf-profile.children.cycles-pp.sched_ttwu_pending
     12.86 ±  2%      -5.1        7.80        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      6.17 ±  2%      -3.3        2.86        perf-profile.children.cycles-pp.__sysvec_call_function_single
      6.20 ±  2%      -3.2        2.99        perf-profile.children.cycles-pp.sysvec_call_function_single
     53.30            -3.1       50.18        perf-profile.children.cycles-pp.clock_nanosleep
      6.28 ±  2%      -3.0        3.32        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     40.96            -2.3       38.63        perf-profile.children.cycles-pp.do_idle
     41.01            -2.3       38.72        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     41.01            -2.3       38.72        perf-profile.children.cycles-pp.cpu_startup_entry
     40.82            -2.3       38.54        perf-profile.children.cycles-pp.start_secondary
     28.17            -1.6       26.60        perf-profile.children.cycles-pp.select_idle_cpu
     10.48            -0.6        9.91        perf-profile.children.cycles-pp.schedule_idle
     15.47            -0.5       14.92        perf-profile.children.cycles-pp.available_idle_cpu
      0.65 ±  6%      -0.3        0.31 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      2.85 ±  2%      -0.3        2.54        perf-profile.children.cycles-pp.dequeue_entity
      0.41 ±  4%      -0.3        0.14 ±  3%  perf-profile.children.cycles-pp.__do_softirq
      0.49 ±  4%      -0.2        0.27        perf-profile.children.cycles-pp.__irq_exit_rcu
      0.43 ±  3%      -0.2        0.25        perf-profile.children.cycles-pp.tick_sched_handle
      0.46 ±  6%      -0.2        0.28 ±  2%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.42 ±  3%      -0.2        0.24 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.44 ±  3%      -0.2        0.27        perf-profile.children.cycles-pp.tick_sched_timer
      0.38 ±  3%      -0.2        0.22 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.46 ±  2%      -0.1        0.32        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.10 ±  3%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.sched_clock_noinstr
      0.74            -0.1        0.67        perf-profile.children.cycles-pp.update_rq_clock
      0.10 ± 19%      -0.1        0.04 ± 76%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.10 ± 19%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.perf_mmap__push
      0.12 ± 15%      -0.1        0.07 ± 18%  perf-profile.children.cycles-pp.__libc_start_main
      0.12 ± 15%      -0.1        0.07 ± 18%  perf-profile.children.cycles-pp.main
      0.12 ± 15%      -0.1        0.07 ± 18%  perf-profile.children.cycles-pp.run_builtin
      0.38 ±  3%      -0.1        0.33        perf-profile.children.cycles-pp.get_nohz_timer_target
      0.11 ± 19%      -0.1        0.06 ± 49%  perf-profile.children.cycles-pp.cmd_record
      0.10            -0.1        0.05        perf-profile.children.cycles-pp.entity_eligible
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.05 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.rebalance_domains
      0.05            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.put_prev_entity
      0.13 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.05 ±  8%      +0.0        0.08        perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.05            +0.0        0.08        perf-profile.children.cycles-pp._find_next_and_bit
      0.16            +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.place_entity
      0.06 ±  6%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.mm_cid_get
      0.08 ±  6%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.24 ±  3%      +0.0        0.28        perf-profile.children.cycles-pp.call_cpuidle
      0.14            +0.0        0.19        perf-profile.children.cycles-pp.avg_vruntime
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__bitmap_and
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ct_kernel_enter
      0.13 ±  2%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.23            +0.1        0.28        perf-profile.children.cycles-pp.__dequeue_entity
      0.06 ±  7%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.ct_idle_exit
      0.08 ±  5%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.resched_curr
      0.01 ±223%      +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.nanosleep@plt
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.perf_exclude_event
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.perf_trace_sched_migrate_task
      0.13 ±  2%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.20 ±  2%      +0.1        0.26        perf-profile.children.cycles-pp.clockevents_program_event
      0.02 ±141%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_blocked_se
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.00            +0.1        0.07 ±  9%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.08            +0.1        0.16        perf-profile.children.cycles-pp.rcu_note_context_switch
      0.22 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.pick_eevdf
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.15            +0.1        0.24        perf-profile.children.cycles-pp.hrtimer_init_sleeper
      0.08            +0.1        0.17        perf-profile.children.cycles-pp.rb_erase
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.__x2apic_send_IPI_dest
      0.06 ±  7%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.00            +0.1        0.10        perf-profile.children.cycles-pp.__list_add_valid
      0.00            +0.1        0.10        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.10        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.10 ±  4%      +0.1        0.20        perf-profile.children.cycles-pp.__hrtimer_init
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.45 ±  6%      +0.1        0.55        perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.07            +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.1        0.11        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.11        perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.11        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.08            +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.update_entity_lag
      0.10 ±  4%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.1        0.12        perf-profile.children.cycles-pp.__calc_delta
      0.01 ±223%      +0.1        0.14        perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.24            +0.1        0.38        perf-profile.children.cycles-pp.os_xsave
      0.06            +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.17 ±  2%      +0.1        0.32        perf-profile.children.cycles-pp.check_preempt_curr
      0.07 ±  5%      +0.1        0.22        perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.48            +0.1        0.62        perf-profile.children.cycles-pp.update_rq_clock_task
      0.00            +0.2        0.15 ±  2%  perf-profile.children.cycles-pp.newidle_balance
      0.00            +0.2        0.16 ±  2%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.07 ±  5%      +0.2        0.24 ±  6%  perf-profile.children.cycles-pp.cpuacct_charge
      0.23 ±  3%      +0.2        0.41        perf-profile.children.cycles-pp.native_irq_return_iret
      0.14            +0.2        0.32        perf-profile.children.cycles-pp.stress_mwc32modn
      0.11 ±  4%      +0.2        0.30        perf-profile.children.cycles-pp.read_tsc
      0.22            +0.2        0.41        perf-profile.children.cycles-pp.ktime_get
      0.24 ±  2%      +0.2        0.43        perf-profile.children.cycles-pp.perf_tp_event
      0.09 ±  4%      +0.2        0.28        perf-profile.children.cycles-pp.attach_entity_load_avg
      0.50            +0.2        0.70        perf-profile.children.cycles-pp.sched_clock_cpu
      0.44            +0.2        0.64        perf-profile.children.cycles-pp.__update_load_avg_se
      0.14 ±  3%      +0.2        0.34        perf-profile.children.cycles-pp.cpus_share_cache
      0.16 ±  2%      +0.2        0.36        perf-profile.children.cycles-pp.update_min_vruntime
      0.34            +0.2        0.54        perf-profile.children.cycles-pp.sched_clock
      0.16 ±  2%      +0.2        0.38        perf-profile.children.cycles-pp.timerqueue_del
      0.14 ±  3%      +0.2        0.36        perf-profile.children.cycles-pp.__entry_text_start
      0.15            +0.2        0.38        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.39 ±  2%      +0.2        0.63        perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.21            +0.2        0.45        perf-profile.children.cycles-pp.__enqueue_entity
      0.27            +0.2        0.52        perf-profile.children.cycles-pp.native_sched_clock
      0.06 ±  7%      +0.3        0.32 ±  2%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.3        0.25        perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.17 ±  2%      +0.3        0.44        perf-profile.children.cycles-pp.timerqueue_add
      0.40 ±  3%      +0.3        0.68        perf-profile.children.cycles-pp._copy_from_user
      0.19 ±  3%      +0.3        0.48        perf-profile.children.cycles-pp.enqueue_hrtimer
      0.81            +0.3        1.10        perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.35 ± 16%      +0.3        0.66 ± 11%  perf-profile.children.cycles-pp.__nanosleep
      0.09 ±  5%      +0.3        0.41        perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.44 ±  3%      +0.3        0.78        perf-profile.children.cycles-pp.get_timespec64
      0.22 ±  2%      +0.4        0.57        perf-profile.children.cycles-pp.___perf_sw_event
      0.77            +0.4        1.14        perf-profile.children.cycles-pp.reweight_entity
      1.49 ±  2%      +0.4        1.86        perf-profile.children.cycles-pp.pick_next_task_fair
      1.00 ±  5%      +0.4        1.43 ±  4%  perf-profile.children.cycles-pp.stress_mwc32
      0.30 ± 15%      +0.5        0.76 ±  9%  perf-profile.children.cycles-pp.clock_gettime@plt
      0.14 ±  7%      +0.5        0.62        perf-profile.children.cycles-pp.menu_select
      0.57            +0.5        1.06        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      1.08            +0.5        1.62        perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.66            +0.6        1.26        perf-profile.children.cycles-pp.prepare_task_switch
      1.25            +0.6        1.86        perf-profile.children.cycles-pp._find_next_bit
      0.21 ±  5%      +0.7        0.87        perf-profile.children.cycles-pp.llist_reverse_order
      0.52            +0.7        1.23        perf-profile.children.cycles-pp.update_curr
      0.05 ±  7%      +0.8        0.83 ±  3%  perf-profile.children.cycles-pp.__update_idle_core
      0.06 ±  9%      +0.8        0.85 ±  2%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.81 ±  8%      +0.8        1.65 ±  3%  perf-profile.children.cycles-pp.clock_gettime
      0.68 ±  2%      +0.9        1.63        perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.07 ±  6%      +1.0        1.04 ±  2%  perf-profile.children.cycles-pp.remove_entity_load_avg
      0.58 ±  2%      +1.0        1.55        perf-profile.children.cycles-pp.__switch_to
      1.45            +1.0        2.43        perf-profile.children.cycles-pp.hrtimer_active
      1.41 ±  2%      +1.0        2.42        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.34 ±  6%      +1.1        1.40        perf-profile.children.cycles-pp.llist_add_batch
      1.51            +1.1        2.58        perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.30 ±  4%      +1.2        1.54        perf-profile.children.cycles-pp.migrate_task_rq_fair
      1.30            +1.2        2.55        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      2.44            +1.3        3.74        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.44 ±  6%      +1.4        1.85        perf-profile.children.cycles-pp.__smp_call_single_queue
      0.70 ±  3%      +1.5        2.23        perf-profile.children.cycles-pp.__switch_to_asm
      2.04            +1.6        3.61        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.77 ±  2%      +1.6        3.39        perf-profile.children.cycles-pp.switch_fpu_return
      0.41 ±  2%      +1.6        2.03        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.21 ±  3%      +1.7        1.91 ±  5%  perf-profile.children.cycles-pp.__bitmap_andnot
      0.43 ±  4%      +1.8        2.18        perf-profile.children.cycles-pp.set_task_cpu
      0.61 ±  5%      +1.9        2.48        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      1.56            +1.9        3.42        perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.49 ±  3%      +1.9        2.40        perf-profile.children.cycles-pp.intel_idle
      1.94 ±  4%      +2.0        3.92 ±  3%  perf-profile.children.cycles-pp.stress_pthread_func
      2.48            +2.2        4.65        perf-profile.children.cycles-pp._raw_spin_lock
      1.38 ±  3%      +3.8        5.23        perf-profile.children.cycles-pp.poll_idle
      6.23            +6.9       13.14        perf-profile.children.cycles-pp.cpuidle_enter
      6.22            +6.9       13.12        perf-profile.children.cycles-pp.cpuidle_enter_state
      6.72 ±  2%      +7.6       14.36        perf-profile.children.cycles-pp.cpuidle_idle_call
      2.32 ±  2%     +11.1       13.44        perf-profile.children.cycles-pp.select_idle_core
     30.80           -29.8        0.98 ± 10%  perf-profile.self.cycles-pp.update_cfs_group
     10.11            -8.9        1.18        perf-profile.self.cycles-pp.update_load_avg
     11.11            -4.9        6.26        perf-profile.self.cycles-pp.select_idle_cpu
     15.35            -0.6       14.78        perf-profile.self.cycles-pp.available_idle_cpu
      0.46 ±  2%      -0.1        0.32        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.38 ±  3%      -0.1        0.33        perf-profile.self.cycles-pp.get_nohz_timer_target
      0.10 ±  4%      -0.0        0.05        perf-profile.self.cycles-pp.entity_eligible
      0.12 ±  3%      +0.0        0.13        perf-profile.self.cycles-pp.ktime_get
      0.10 ±  3%      +0.0        0.12        perf-profile.self.cycles-pp.__hrtimer_start_range_ns
      0.07            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.select_task_rq
      0.13 ±  2%      +0.0        0.15 ±  6%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.05 ±  7%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.06 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.06 ±  9%      +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.mm_cid_get
      0.15 ±  3%      +0.0        0.19        perf-profile.self.cycles-pp.__dequeue_entity
      0.06 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.12 ±  3%      +0.0        0.17        perf-profile.self.cycles-pp.update_irq_load_avg
      0.01 ±223%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__bitmap_and
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.cpu_startup_entry
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.perf_exclude_event
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.perf_trace_sched_migrate_task
      0.02 ±141%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp._find_next_and_bit
      0.05            +0.1        0.11        perf-profile.self.cycles-pp.check_preempt_curr
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.update_entity_lag
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__update_load_avg_blocked_se
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.08            +0.1        0.14        perf-profile.self.cycles-pp.resched_curr
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.remove_entity_load_avg
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.activate_task
      0.13 ±  2%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.03 ± 70%      +0.1        0.10        perf-profile.self.cycles-pp.set_next_entity
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.hrtimer_try_to_cancel
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.get_timespec64
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.rb_next
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.33            +0.1        0.40        perf-profile.self.cycles-pp.update_rq_clock
      0.06            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.__hrtimer_init
      0.09 ±  5%      +0.1        0.17        perf-profile.self.cycles-pp.avg_vruntime
      0.08 ±  6%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.08            +0.1        0.16        perf-profile.self.cycles-pp.rb_erase
      0.00            +0.1        0.08        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.10 ±  4%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.05 ±  8%      +0.1        0.14        perf-profile.self.cycles-pp.do_syscall_64
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.__list_add_valid
      0.09 ±  4%      +0.1        0.18        perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.07            +0.1        0.16        perf-profile.self.cycles-pp.common_nsleep
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.35 ±  2%      +0.1        0.44        perf-profile.self.cycles-pp.update_rq_clock_task
      0.00            +0.1        0.10 ±  5%  perf-profile.self.cycles-pp.__x2apic_send_IPI_dest
      0.00            +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      0.06 ±  6%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.00            +0.1        0.10        perf-profile.self.cycles-pp.schedule_idle
      0.07 ±  5%      +0.1        0.17        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.07 ±  5%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.timerqueue_del
      0.00            +0.1        0.11        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.10 ±  5%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.__calc_delta
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.call_cpuidle
      0.12 ±  3%      +0.1        0.25 ±  2%  perf-profile.self.cycles-pp.pick_eevdf
      0.00            +0.1        0.13        perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.15 ±  3%      +0.1        0.28        perf-profile.self.cycles-pp.pick_next_task_fair
      0.06 ±  8%      +0.1        0.19        perf-profile.self.cycles-pp.hrtimer_start_range_ns
      0.16 ±  2%      +0.1        0.30        perf-profile.self.cycles-pp.do_nanosleep
      0.09 ±  5%      +0.1        0.23        perf-profile.self.cycles-pp.stress_mwc32modn
      0.07 ±  5%      +0.1        0.21        perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.24            +0.1        0.38        perf-profile.self.cycles-pp.os_xsave
      0.00            +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.newidle_balance
      0.13            +0.2        0.28        perf-profile.self.cycles-pp.try_to_wake_up
      0.17 ±  2%      +0.2        0.32        perf-profile.self.cycles-pp.perf_tp_event
      0.00            +0.2        0.15 ±  3%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.06 ±  6%      +0.2        0.21        perf-profile.self.cycles-pp.menu_select
      0.07 ±  5%      +0.2        0.23 ±  2%  perf-profile.self.cycles-pp.timerqueue_add
      0.07 ±  5%      +0.2        0.23 ±  8%  perf-profile.self.cycles-pp.cpuacct_charge
      0.13 ± 13%      +0.2        0.31 ± 15%  perf-profile.self.cycles-pp.clock_gettime
      0.23 ±  3%      +0.2        0.41        perf-profile.self.cycles-pp.native_irq_return_iret
      0.11 ±  3%      +0.2        0.29 ±  2%  perf-profile.self.cycles-pp.read_tsc
      0.16 ± 12%      +0.2        0.34 ± 10%  perf-profile.self.cycles-pp.__nanosleep
      0.16 ±  2%      +0.2        0.35        perf-profile.self.cycles-pp.update_min_vruntime
      0.09 ±  4%      +0.2        0.28        perf-profile.self.cycles-pp.attach_entity_load_avg
      0.41            +0.2        0.60        perf-profile.self.cycles-pp.__update_load_avg_se
      0.16 ±  3%      +0.2        0.35        perf-profile.self.cycles-pp.schedule
      0.13 ±  3%      +0.2        0.33        perf-profile.self.cycles-pp.cpus_share_cache
      0.13 ±  5%      +0.2        0.33        perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.21 ±  2%      +0.2        0.42        perf-profile.self.cycles-pp._copy_from_user
      0.00            +0.2        0.20 ±  2%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.21 ±  5%      +0.2        0.42        perf-profile.self.cycles-pp.migrate_task_rq_fair
      0.20 ±  2%      +0.2        0.44        perf-profile.self.cycles-pp.__enqueue_entity
      0.57 ±  5%      +0.3        0.82 ±  3%  perf-profile.self.cycles-pp.stress_mwc32
      0.26            +0.3        0.52        perf-profile.self.cycles-pp.dequeue_entity
      0.13 ±  6%      +0.3        0.39        perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.23 ±  2%      +0.3        0.50        perf-profile.self.cycles-pp.native_sched_clock
      0.30 ±  4%      +0.3        0.58        perf-profile.self.cycles-pp.__x64_sys_clock_nanosleep
      0.29 ±  3%      +0.3        0.57        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.30            +0.3        0.59        perf-profile.self.cycles-pp.hrtimer_nanosleep
      0.17 ±  2%      +0.3        0.47        perf-profile.self.cycles-pp.___perf_sw_event
      0.13 ±  7%      +0.3        0.44        perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.08 ±  7%      +0.3        0.40        perf-profile.self.cycles-pp.sched_ttwu_pending
      0.09 ±  5%      +0.3        0.40        perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.22 ± 13%      +0.3        0.56 ± 10%  perf-profile.self.cycles-pp.clock_gettime@plt
      0.28 ±  2%      +0.3        0.62 ±  3%  perf-profile.self.cycles-pp.update_curr
      0.00            +0.3        0.35        perf-profile.self.cycles-pp.do_idle
      0.58            +0.4        0.94        perf-profile.self.cycles-pp.reweight_entity
      0.54            +0.5        1.00        perf-profile.self.cycles-pp.prepare_task_switch
      0.11 ±  6%      +0.5        0.57 ±  3%  perf-profile.self.cycles-pp.set_task_cpu
      0.40 ±  2%      +0.5        0.87        perf-profile.self.cycles-pp.enqueue_entity
      0.07 ± 10%      +0.5        0.54        perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.55            +0.5        1.04        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      1.12            +0.5        1.66        perf-profile.self.cycles-pp._find_next_bit
      0.23 ±  2%      +0.5        0.77 ±  2%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.64            +0.6        1.23        perf-profile.self.cycles-pp.dequeue_task_fair
      0.36 ±  2%      +0.6        0.96        perf-profile.self.cycles-pp.switch_fpu_return
      0.21 ±  6%      +0.7        0.87        perf-profile.self.cycles-pp.llist_reverse_order
      0.00            +0.7        0.71 ±  3%  perf-profile.self.cycles-pp.__update_idle_core
      0.68 ±  3%      +0.7        1.42        perf-profile.self.cycles-pp.hrtimer_active
      0.47 ±  2%      +0.8        1.26        perf-profile.self.cycles-pp.finish_task_switch
      1.17            +0.9        2.09        perf-profile.self.cycles-pp._raw_spin_lock
      0.68 ±  2%      +0.9        1.62        perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.57 ±  2%      +0.9        1.52        perf-profile.self.cycles-pp.__switch_to
      1.41 ±  2%      +1.0        2.42        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.34 ±  6%      +1.1        1.40        perf-profile.self.cycles-pp.llist_add_batch
      0.72 ±  5%      +1.1        1.80 ±  2%  perf-profile.self.cycles-pp.clock_nanosleep
      1.30            +1.2        2.55        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.96 ±  6%      +1.3        2.28 ±  3%  perf-profile.self.cycles-pp.stress_pthread_func
      0.06 ± 11%      +1.4        1.44        perf-profile.self.cycles-pp.poll_idle
      0.54            +1.5        2.02 ±  2%  perf-profile.self.cycles-pp.select_idle_sibling
      0.69 ±  3%      +1.5        2.22        perf-profile.self.cycles-pp.__switch_to_asm
      0.38 ±  3%      +1.6        1.97        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.20 ±  5%      +1.7        1.86 ±  5%  perf-profile.self.cycles-pp.__bitmap_andnot
      1.22            +1.8        3.06        perf-profile.self.cycles-pp.__schedule
      1.54            +1.8        3.39        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.49 ±  3%      +1.9        2.40        perf-profile.self.cycles-pp.intel_idle
      0.79 ±  2%      +1.9        2.74        perf-profile.self.cycles-pp.select_idle_core


***************************************************************************************************
lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/sc_pid_max/tbox_group/test/testcase/testtime:
  scheduler/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/4194304/lkp-spr-r02/sem/stress-ng/60s

commit: 
  63304558ba ("sched/eevdf: Curb wakeup-preemption")
  0a24d7afed ("sched/fair: ratelimit update to tg->load_avg")

63304558ba5dcaaf 0a24d7afed5c3c59ee212782f9c 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     11351 ±  3%     +46.2%      16601        uptime.idle
 3.846e+09 ±  2%    +132.5%  8.942e+09        cpuidle..time
 1.809e+08 ±  4%    +188.7%  5.221e+08        cpuidle..usage
   1748151 ± 30%     +96.9%    3442946 ± 10%  numa-numastat.node1.local_node
   1884868 ± 27%     +91.3%    3605026 ± 10%  numa-numastat.node1.numa_hit
      1396 ± 21%     +31.4%       1834 ±  9%  perf-c2c.DRAM.local
     77083 ±  8%     +25.5%      96721 ±  5%  perf-c2c.HITM.local
     78543 ±  8%     +25.0%      98216 ±  5%  perf-c2c.HITM.total
     38.23 ±  3%     +42.9       81.16        mpstat.cpu.all.idle%
     32.27 ±  2%     -23.0        9.27        mpstat.cpu.all.irq%
      0.43 ±  6%      -0.4        0.08 ±  3%  mpstat.cpu.all.soft%
     20.22           -14.8        5.47        mpstat.cpu.all.sys%
      8.85            -4.8        4.01 ±  2%  mpstat.cpu.all.usr%
     39.67 ±  2%    +104.2%      81.00        vmstat.cpu.id
     50.83 ±  2%     -72.5%      14.00        vmstat.cpu.sy
   7584537 ±  4%     +62.1%   12297640 ±  2%  vmstat.memory.cache
    141.17           -59.0%      57.83 ±  4%  vmstat.procs.r
   7826695 ±  4%    +127.3%   17789598        vmstat.system.cs
   3068646 ±  2%     +34.3%    4120105        vmstat.system.in
     84090 ± 31%     +62.5%     136620 ±  9%  numa-meminfo.node1.Active
     83901 ± 31%     +62.7%     136529 ±  9%  numa-meminfo.node1.Active(anon)
   4332711 ± 24%    +100.1%    8670667 ± 10%  numa-meminfo.node1.FilePages
   4148689 ± 32%    +115.2%    8929944 ± 10%  numa-meminfo.node1.Inactive
   4148234 ± 32%    +115.3%    8929838 ± 10%  numa-meminfo.node1.Inactive(anon)
    755396 ±  2%     +35.6%    1024533        numa-meminfo.node1.Mapped
   6280993 ± 18%     +68.2%   10562500 ±  8%  numa-meminfo.node1.MemUsed
   3791150 ± 35%    +126.9%    8600616 ± 10%  numa-meminfo.node1.Shmem
 5.324e+08 ±  3%    +120.7%  1.175e+09        stress-ng.sem.ops
   8872696 ±  3%    +120.7%   19585942        stress-ng.sem.ops_per_sec
  36203483           -44.3%   20170299        stress-ng.time.involuntary_context_switches
     41804            -5.5%      39488        stress-ng.time.minor_page_faults
      7970           -44.6%       4412        stress-ng.time.percent_of_cpu_this_job_got
      3548           -53.3%       1658        stress-ng.time.system_time
      1419           -23.4%       1087        stress-ng.time.user_time
 2.657e+08 ±  3%    +120.7%  5.864e+08        stress-ng.time.voluntary_context_switches
     21077 ± 31%     +62.0%      34153 ±  9%  numa-vmstat.node1.nr_active_anon
   1083493 ± 24%    +100.1%    2167954 ± 10%  numa-vmstat.node1.nr_file_pages
   1037164 ± 32%    +115.3%    2232740 ± 10%  numa-vmstat.node1.nr_inactive_anon
    188463 ±  2%     +36.0%     256345        numa-vmstat.node1.nr_mapped
    948102 ± 35%    +126.8%    2150441 ± 10%  numa-vmstat.node1.nr_shmem
     21077 ± 31%     +62.0%      34153 ±  9%  numa-vmstat.node1.nr_zone_active_anon
   1037160 ± 32%    +115.3%    2232735 ± 10%  numa-vmstat.node1.nr_zone_inactive_anon
   1884811 ± 27%     +91.3%    3605221 ± 10%  numa-vmstat.node1.numa_hit
   1748094 ± 31%     +97.0%    3443141 ± 10%  numa-vmstat.node1.numa_local
    113047 ± 12%     +32.7%     150063 ±  4%  meminfo.Active
    112858 ± 12%     +32.8%     149930 ±  4%  meminfo.Active(anon)
   7383553 ±  4%     +63.3%   12055933 ±  2%  meminfo.Cached
  11049975 ±  3%     +42.2%   15716475        meminfo.Committed_AS
   5392328 ±  6%     +86.8%   10072875 ±  2%  meminfo.Inactive
   5391867 ±  6%     +86.8%   10072720 ±  2%  meminfo.Inactive(anon)
   1185651           +20.6%    1430121        meminfo.Mapped
  11425070 ±  3%     +40.8%   16088748        meminfo.Memused
   4639309 ±  7%    +100.7%    9312054 ±  3%  meminfo.Shmem
  11531671 ±  3%     +41.0%   16259717        meminfo.max_used_kB
      2128           -46.4%       1141        turbostat.Avg_MHz
     74.52           -33.3       41.25        turbostat.Busy%
      2868            -3.6%       2765        turbostat.Bzy_MHz
  10682212 ±  8%    +223.7%   34581909 ±  2%  turbostat.C1
      0.45 ±  8%      +0.6        1.06 ±  4%  turbostat.C1%
 1.672e+08 ±  4%    +186.8%  4.794e+08        turbostat.C1E
     22.71 ±  2%     +35.2       57.90        turbostat.C1E%
     25.39 ±  2%    +131.4%      58.75        turbostat.CPU%c1
 2.003e+08           +34.2%  2.689e+08        turbostat.IRQ
   2595431 ±  6%    +191.2%    7557295        turbostat.POLL
      0.39            -0.1        0.29        turbostat.POLL%
    546.17            -4.0%     524.25        turbostat.PkgWatt
     17.63            +5.4%      18.59        turbostat.RAMWatt
     28245 ± 12%     +32.8%      37500 ±  4%  proc-vmstat.nr_active_anon
    216361            +5.3%     227804        proc-vmstat.nr_anon_pages
   6268223            -1.9%    6151776        proc-vmstat.nr_dirty_background_threshold
  12551772            -1.9%   12318594        proc-vmstat.nr_dirty_threshold
   1846243 ±  4%     +63.3%    3014307 ±  2%  proc-vmstat.nr_file_pages
  63058692            -1.8%   61892607        proc-vmstat.nr_free_pages
   1348115 ±  6%     +86.8%    2518510 ±  2%  proc-vmstat.nr_inactive_anon
    296600           +20.6%     357727        proc-vmstat.nr_mapped
   1160181 ±  7%    +100.7%    2328337 ±  3%  proc-vmstat.nr_shmem
     41135            +6.4%      43765        proc-vmstat.nr_slab_reclaimable
     28245 ± 12%     +32.8%      37500 ±  4%  proc-vmstat.nr_zone_active_anon
   1348115 ±  6%     +86.8%    2518510 ±  2%  proc-vmstat.nr_zone_inactive_anon
    305736 ±  9%     +64.0%     501444 ± 16%  proc-vmstat.numa_hint_faults
    212439 ± 11%     +68.3%     357589 ± 17%  proc-vmstat.numa_hint_faults_local
   2618374 ±  5%     +65.4%    4331174 ±  2%  proc-vmstat.numa_hit
      1476 ±  2%     -21.4%       1159 ±  4%  proc-vmstat.numa_huge_pte_updates
   2389468 ±  5%     +71.5%    4099042 ±  2%  proc-vmstat.numa_local
     18075 ± 18%    +243.7%      62123 ± 11%  proc-vmstat.pgactivate
   2893156 ±  4%     +59.3%    4608688 ±  2%  proc-vmstat.pgalloc_normal
   1164766 ±  2%     +24.7%    1452985 ±  6%  proc-vmstat.pgfault
    750923 ±  7%     +20.2%     902954 ±  4%  proc-vmstat.pgfree
   1587344           -80.7%     305805        sched_debug.cfs_rq:/.avg_vruntime.avg
   3053761 ± 15%     -79.5%     627436 ± 20%  sched_debug.cfs_rq:/.avg_vruntime.max
   1349541 ±  8%     -80.5%     263633 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.min
    119162 ± 17%     -72.5%      32738 ± 18%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.43 ±  8%     -57.8%       0.18 ±  6%  sched_debug.cfs_rq:/.h_nr_running.avg
    459622 ±  7%     -94.1%      26943 ± 10%  sched_debug.cfs_rq:/.left_vruntime.avg
   1802751 ±  8%     -81.4%     334976 ± 13%  sched_debug.cfs_rq:/.left_vruntime.max
    715952 ±  2%     -88.0%      86086 ±  4%  sched_debug.cfs_rq:/.left_vruntime.stddev
   1587344           -80.7%     305805        sched_debug.cfs_rq:/.min_vruntime.avg
   3053761 ± 15%     -79.5%     627436 ± 20%  sched_debug.cfs_rq:/.min_vruntime.max
   1349542 ±  8%     -80.5%     263633 ±  7%  sched_debug.cfs_rq:/.min_vruntime.min
    119162 ± 17%     -72.5%      32738 ± 18%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.32 ±  3%     -48.3%       0.17 ±  5%  sched_debug.cfs_rq:/.nr_running.avg
    459622 ±  7%     -94.1%      26943 ± 10%  sched_debug.cfs_rq:/.right_vruntime.avg
   1802751 ±  8%     -81.4%     334976 ± 13%  sched_debug.cfs_rq:/.right_vruntime.max
    715952 ±  2%     -88.0%      86086 ±  4%  sched_debug.cfs_rq:/.right_vruntime.stddev
    456.43 ±  3%     -58.2%     190.59 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
      1516 ± 11%     -23.5%       1159 ± 12%  sched_debug.cfs_rq:/.runnable_avg.max
    225.37 ±  4%     -29.1%     159.79 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
    317.90 ±  2%     -43.2%     180.41 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
     20.61 ± 17%     -54.7%       9.33 ± 21%  sched_debug.cfs_rq:/.util_est_enqueued.avg
     41.44 ± 18%     -73.0%      11.19 ±  2%  sched_debug.cpu.clock.stddev
      1127 ±  9%     -26.2%     831.86        sched_debug.cpu.clock_task.stddev
      1517 ±  4%     -23.9%       1155 ±  8%  sched_debug.cpu.curr->pid.avg
      0.00 ± 18%     -70.3%       0.00 ± 10%  sched_debug.cpu.next_balance.stddev
      0.39 ±  4%     -54.9%       0.17 ±  6%  sched_debug.cpu.nr_running.avg
      0.54 ±  6%     -27.4%       0.39 ± 12%  sched_debug.cpu.nr_running.stddev
   1086308 ±  3%    +126.7%    2462284        sched_debug.cpu.nr_switches.avg
   1230656 ±  4%    +115.6%    2653087 ±  2%  sched_debug.cpu.nr_switches.max
    511501 ± 20%    +208.1%    1576039 ± 20%  sched_debug.cpu.nr_switches.min
      0.00          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_migratory.avg
      0.50          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_migratory.max
      0.03          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_migratory.stddev
      0.00          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_running.avg
      0.50          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_running.max
      0.03          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_running.stddev
      1.21 ± 19%    -100.0%       0.00        sched_debug.rt_rq:.rt_time.avg
    270.28 ± 19%    -100.0%       0.00        sched_debug.rt_rq:.rt_time.max
     18.02 ± 19%    -100.0%       0.00        sched_debug.rt_rq:.rt_time.stddev
     11.96           -25.6%       8.90        perf-stat.i.MPKI
 1.534e+10 ±  2%     +89.5%  2.908e+10        perf-stat.i.branch-instructions
      1.45            -0.4        1.09        perf-stat.i.branch-miss-rate%
 1.844e+08 ±  2%     +46.4%    2.7e+08        perf-stat.i.branch-misses
      3.02 ±  4%      +0.2        3.27        perf-stat.i.cache-miss-rate%
  14912654 ±  5%     +92.1%   28640533 ±  2%  perf-stat.i.cache-misses
 7.818e+08 ±  3%     +48.0%  1.157e+09        perf-stat.i.cache-references
   8093326 ±  3%    +128.3%   18474462        perf-stat.i.context-switches
      7.31 ±  4%     -75.0%       1.82        perf-stat.i.cpi
  4.79e+11           -49.8%  2.405e+11        perf-stat.i.cpu-cycles
   3201059 ±  3%    +117.3%    6956049        perf-stat.i.cpu-migrations
     41589 ±  5%     -69.5%      12679 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.24 ±  2%      -0.1        0.15 ±  2%  perf-stat.i.dTLB-load-miss-rate%
  44628478 ±  4%     +24.9%   55730478 ±  2%  perf-stat.i.dTLB-load-misses
 1.958e+10 ±  3%     +97.5%  3.867e+10        perf-stat.i.dTLB-loads
      0.08            -0.0        0.05        perf-stat.i.dTLB-store-miss-rate%
   7655277 ±  2%     +29.8%    9933453        perf-stat.i.dTLB-store-misses
 1.103e+10 ±  3%    +102.9%  2.238e+10        perf-stat.i.dTLB-stores
 7.611e+10 ±  2%     +89.8%  1.445e+11        perf-stat.i.instructions
      0.19 ±  2%    +212.9%       0.58        perf-stat.i.ipc
      2.12           -49.6%       1.07        perf-stat.i.metric.GHz
    128.80 ±  3%     +68.7%     217.34        perf-stat.i.metric.K/sec
    207.54 ±  3%     +96.0%     406.79        perf-stat.i.metric.M/sec
     19217           +15.9%      22269 ±  7%  perf-stat.i.minor-faults
     80.23 ±  2%     -10.5       69.77 ±  2%  perf-stat.i.node-load-miss-rate%
   4830206 ±  4%     +40.9%    6803808 ±  4%  perf-stat.i.node-load-misses
   1648661 ± 12%    +152.3%    4158848 ±  6%  perf-stat.i.node-loads
     19217           +15.9%      22269 ±  7%  perf-stat.i.page-faults
     10.69           -24.6%       8.06        perf-stat.overall.MPKI
      1.25            -0.3        0.93        perf-stat.overall.branch-miss-rate%
      1.86 ±  5%      +0.6        2.46 ±  2%  perf-stat.overall.cache-miss-rate%
      6.56 ±  4%     -74.5%       1.67        perf-stat.overall.cpi
     33078 ±  5%     -74.4%       8459        perf-stat.overall.cycles-between-cache-misses
      0.23 ±  2%      -0.1        0.14 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
      0.07            -0.0        0.04        perf-stat.overall.dTLB-store-miss-rate%
      0.15 ±  4%    +291.0%       0.60        perf-stat.overall.ipc
     70.66 ±  3%     -10.0       60.71 ±  3%  perf-stat.overall.node-load-miss-rate%
 1.442e+10 ±  3%     +96.7%  2.838e+10        perf-stat.ps.branch-instructions
 1.798e+08 ±  3%     +47.5%  2.653e+08        perf-stat.ps.branch-misses
  14255932 ±  5%     +96.0%   27941497 ±  2%  perf-stat.ps.cache-misses
 7.673e+08 ±  3%     +48.2%  1.137e+09        perf-stat.ps.cache-references
   7947074 ±  4%    +129.1%   18204433        perf-stat.ps.context-switches
   4.7e+11           -49.7%  2.363e+11        perf-stat.ps.cpu-cycles
   3148303 ±  4%    +117.8%    6855484        perf-stat.ps.cpu-migrations
  43383948 ±  5%     +26.3%   54781737 ±  2%  perf-stat.ps.dTLB-load-misses
 1.859e+10 ±  3%    +103.5%  3.783e+10        perf-stat.ps.dTLB-loads
   7530893 ±  2%     +30.0%    9786994        perf-stat.ps.dTLB-store-misses
 1.049e+10 ±  3%    +108.7%   2.19e+10        perf-stat.ps.dTLB-stores
 7.175e+10 ±  3%     +96.6%  1.411e+11        perf-stat.ps.instructions
     17174 ±  2%     +24.8%      21436 ±  6%  perf-stat.ps.minor-faults
   4621265 ±  4%     +43.9%    6648855 ±  4%  perf-stat.ps.node-load-misses
   1927489 ± 13%    +123.1%    4300926 ±  5%  perf-stat.ps.node-loads
     17174 ±  2%     +24.8%      21436 ±  6%  perf-stat.ps.page-faults
 4.485e+12 ±  3%     +98.9%   8.92e+12        perf-stat.total.instructions
     27.32           -18.6        8.70        perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     21.32           -18.0        3.36 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
     18.25           -15.6        2.69 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
     18.99           -13.8        5.16        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
     19.06           -13.8        5.29        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
     17.39           -13.5        3.88 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
     19.49           -13.0        6.44        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
     19.77           -12.5        7.27        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
     11.46 ±  2%     -10.7        0.80 ±  4%  perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_entity.dequeue_task_fair.__schedule.schedule
     14.02           -10.6        3.37 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.do_nanosleep
     10.59           -10.5        0.09 ±223%  perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
     18.67            -8.4       10.29        perf-profile.calltrace.cycles-pp.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      9.63            -8.4        1.27        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
     18.68            -8.3       10.34        perf-profile.calltrace.cycles-pp.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
     22.51            -8.1       14.45 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep
     19.24            -7.9       11.33        perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     22.71            -7.8       14.88 ±  4%  perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     10.88 ±  4%      -7.3        3.57 ±  2%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up.hrtimer_wakeup
      9.66 ±  2%      -7.3        2.40        perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up
     10.95 ±  4%      -7.2        3.70        perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues
     10.97 ±  4%      -7.2        3.76        perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      8.82 ±  2%      -6.6        2.23 ±  2%  perf-profile.calltrace.cycles-pp.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq
     25.03            -6.5       18.57 ±  3%  perf-profile.calltrace.cycles-pp.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64
     25.38            -6.1       19.25 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.41            -6.1       19.30 ±  3%  perf-profile.calltrace.cycles-pp.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     26.14            -5.8       20.31 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      6.52 ±  4%      -5.6        0.89 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      6.36 ±  4%      -5.5        0.82 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      6.20 ±  4%      -5.4        0.80 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.flush_smp_call_function_queue.do_idle
      6.17 ±  4%      -5.4        0.78 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.flush_smp_call_function_queue
      5.01            -5.0        0.00        perf-profile.calltrace.cycles-pp.update_load_avg.set_next_entity.pick_next_task_fair.__schedule.schedule_idle
     29.04            -4.9       24.15 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     60.01            -4.9       55.12        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     29.44            -4.9       24.57 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     60.32            -4.9       55.46        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     60.05            -4.8       55.24        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     12.60            -4.8        7.81        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
     60.06            -4.8       55.29        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     12.70            -4.6        8.08        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.10            -4.4        0.67        perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule_idle.do_idle
      5.23            -4.2        0.98        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
      4.86            -3.8        1.07        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      4.90 ±  2%      -3.5        1.38 ±  2%  perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair
     31.19            -3.4       27.79        perf-profile.calltrace.cycles-pp.clock_nanosleep
      4.78            -3.3        1.45        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch
      4.81            -3.3        1.49        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule
      3.99            -3.2        0.82 ±  9%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup
      4.00            -3.2        0.84 ±  9%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues
      4.09            -3.1        0.95 ±  8%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      3.70            -3.0        0.67 ± 10%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up
      3.79            -3.0        0.78        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule_idle.do_idle
      3.73            -3.0        0.73        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule_idle
      2.35            -1.8        0.54        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.74            -0.8        0.96 ±  2%  perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
      1.36 ±  3%      -0.6        0.81 ±  3%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule
      1.43 ±  3%      -0.5        0.89 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule.do_nanosleep
      0.70 ±  3%      -0.1        0.56        perf-profile.calltrace.cycles-pp.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      1.15 ±  2%      -0.1        1.08        perf-profile.calltrace.cycles-pp.hrtimer_active.hrtimer_try_to_cancel.do_nanosleep.hrtimer_nanosleep.common_nsleep
      0.43 ± 44%      +0.2        0.62        perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      2.43 ±  2%      +0.3        2.71        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      2.16            +0.3        2.48        perf-profile.calltrace.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1.26            +0.5        1.76        perf-profile.calltrace.cycles-pp.sched_mm_cid_migrate_to.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state.cpuidle_enter
      0.00            +0.6        0.57 ±  2%  perf-profile.calltrace.cycles-pp.cpus_share_cache.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.update_curr.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      0.00            +0.7        0.66        perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.00            +0.7        0.68 ±  2%  perf-profile.calltrace.cycles-pp.llist_reverse_order.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      2.72            +0.7        3.41        perf-profile.calltrace.cycles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.77            +0.7        3.48        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.00            +0.7        0.74 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.7        0.75        perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues
      2.46            +0.8        3.23        perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      2.80            +0.8        3.58        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.29 ±100%      +0.8        1.09 ±  8%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
      0.29 ±100%      +0.8        1.10 ±  8%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
      0.29 ±100%      +0.8        1.10 ±  8%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      0.30 ±100%      +0.8        1.11 ±  8%  perf-profile.calltrace.cycles-pp.__cmd_record
      0.30 ±100%      +0.8        1.11 ±  8%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
      0.30 ±100%      +0.8        1.11 ±  8%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
      0.30 ±100%      +0.8        1.11 ±  8%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      1.70            +0.8        2.55        perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.72 ±  3%      +0.9        1.59        perf-profile.calltrace.cycles-pp.shim_nanosleep_uint64
      2.57            +0.9        3.45        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      1.73            +0.9        2.63        perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.00            +0.9        0.90        perf-profile.calltrace.cycles-pp.__hrtimer_start_range_ns.hrtimer_start_range_ns.do_nanosleep.hrtimer_nanosleep.common_nsleep
      0.00            +0.9        0.93        perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +0.9        0.95        perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      2.60            +0.9        3.54        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.00            +1.0        0.98        perf-profile.calltrace.cycles-pp.__switch_to
      0.00            +1.0        1.00 ±  4%  perf-profile.calltrace.cycles-pp.sem_post@@GLIBC_2.2.5
      0.62 ±  4%      +1.0        1.65 ±  2%  perf-profile.calltrace.cycles-pp.sem_getvalue@@GLIBC_2.2.5
      0.00            +1.0        1.04        perf-profile.calltrace.cycles-pp.set_task_cpu.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +1.1        1.05        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      0.00            +1.1        1.13        perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.64 ±  2%      +1.2        1.81 ±  5%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.58            +1.2        1.77        perf-profile.calltrace.cycles-pp.__switch_to_asm
      0.86            +1.2        2.08        perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1.00 ±  2%      +1.3        2.26 ±  8%  perf-profile.calltrace.cycles-pp.semaphore_posix_thrash
      2.98            +1.3        4.25        perf-profile.calltrace.cycles-pp.__sched_yield
      7.89            +1.9        9.77        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.9        1.94 ± 31%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
      0.70 ±  2%      +2.0        2.67        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule_idle.do_idle.cpu_startup_entry
      7.93            +2.1       10.00        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +2.1        2.14 ± 29%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      0.00            +2.2        2.18 ± 29%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      8.35            +2.3       10.66        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00            +2.4        2.41 ± 26%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      0.00            +3.4        3.35 ± 18%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.do_nanosleep
      0.00            +3.5        3.48 ± 17%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      8.48            +3.6       12.08        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      6.22 ±  3%     +13.2       19.41        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     17.85           +14.9       32.78        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     18.03           +15.6       33.59        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     18.91           +17.2       36.16        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     29.17           -27.5        1.63 ±  4%  perf-profile.children.cycles-pp.update_cfs_group
     26.97           -22.3        4.65 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
     28.59           -21.9        6.64        perf-profile.children.cycles-pp.activate_task
     28.80           -21.9        6.90        perf-profile.children.cycles-pp.ttwu_do_activate
     23.52           -19.7        3.81 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
     27.63           -18.8        8.81        perf-profile.children.cycles-pp.flush_smp_call_function_queue
     24.39           -17.3        7.10        perf-profile.children.cycles-pp.sched_ttwu_pending
     24.82           -16.8        8.06        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
     18.44           -15.1        3.31 ±  2%  perf-profile.children.cycles-pp.update_load_avg
     17.44           -13.5        3.93 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
     36.97           -11.9       25.11 ±  2%  perf-profile.children.cycles-pp.__schedule
     14.08           -10.6        3.47 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
     21.16            -8.7       12.42        perf-profile.children.cycles-pp.try_to_wake_up
     21.12            -8.7       12.43        perf-profile.children.cycles-pp.hrtimer_wakeup
     21.83            -8.2       13.59        perf-profile.children.cycles-pp.__hrtimer_run_queues
     22.20            -7.8       14.40        perf-profile.children.cycles-pp.hrtimer_interrupt
     23.28            -7.7       15.54        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     11.63 ±  2%      -7.7        3.95 ±  2%  perf-profile.children.cycles-pp.select_idle_cpu
     22.32            -7.6       14.74        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     23.88            -7.1       16.75        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     12.80 ±  2%      -7.0        5.74 ±  2%  perf-profile.children.cycles-pp.select_idle_sibling
     12.88 ±  2%      -7.0        5.92 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
     10.67 ±  2%      -6.9        3.72 ±  2%  perf-profile.children.cycles-pp.select_idle_core
     24.50            -6.9       17.56 ±  3%  perf-profile.children.cycles-pp.schedule
     12.90 ±  2%      -6.9        6.00 ±  2%  perf-profile.children.cycles-pp.select_task_rq
     25.06            -6.4       18.65 ±  3%  perf-profile.children.cycles-pp.do_nanosleep
     25.39            -6.1       19.28 ±  3%  perf-profile.children.cycles-pp.hrtimer_nanosleep
     25.46            -6.0       19.47 ±  3%  perf-profile.children.cycles-pp.common_nsleep
     26.16            -5.8       20.33 ±  2%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
     60.29            -4.9       55.35        perf-profile.children.cycles-pp.do_idle
     60.32            -4.9       55.46        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     60.32            -4.9       55.46        perf-profile.children.cycles-pp.cpu_startup_entry
     60.06            -4.8       55.29        perf-profile.children.cycles-pp.start_secondary
     12.76            -4.6        8.14        perf-profile.children.cycles-pp.schedule_idle
      7.42 ±  3%      -4.5        2.97 ±  2%  perf-profile.children.cycles-pp.available_idle_cpu
      5.20            -4.5        0.75        perf-profile.children.cycles-pp.set_next_entity
      4.99            -4.2        0.79        perf-profile.children.cycles-pp.__sysvec_call_function_single
      5.01            -4.2        0.84        perf-profile.children.cycles-pp.sysvec_call_function_single
      5.12            -4.1        0.98        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     31.91            -4.1       27.82        perf-profile.children.cycles-pp.do_syscall_64
     32.32            -4.0       28.30        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      7.73            -3.8        3.98        perf-profile.children.cycles-pp.finish_task_switch
     31.29            -3.1       28.16        perf-profile.children.cycles-pp.clock_nanosleep
      1.51 ±  5%      -1.4        0.16 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.73 ±  6%      -0.5        0.25 ±  3%  perf-profile.children.cycles-pp.__do_softirq
      0.88 ±  5%      -0.4        0.46 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.68            -0.4        0.32        perf-profile.children.cycles-pp._find_next_bit
      2.55 ±  2%      -0.3        2.26 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.26 ± 24%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.__update_idle_core
      0.26 ± 24%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.71 ±  3%      -0.1        0.58        perf-profile.children.cycles-pp.do_sched_yield
      0.43 ±  3%      -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.__bitmap_andnot
      0.27 ± 15%      -0.1        0.17 ± 56%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.27 ± 15%      -0.1        0.17 ± 56%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.27 ± 15%      -0.1        0.17 ± 56%  perf-profile.children.cycles-pp.start_kernel
      0.27 ± 15%      -0.1        0.17 ± 56%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.27 ± 15%      -0.1        0.17 ± 56%  perf-profile.children.cycles-pp.rest_init
      1.16 ±  2%      -0.1        1.10        perf-profile.children.cycles-pp.hrtimer_active
      0.13 ±  7%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.do_futex
      0.14 ±  8%      -0.0        0.11 ±  9%  perf-profile.children.cycles-pp.__x64_sys_futex
      0.20 ±  3%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.yield_task_fair
      0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.15 ±  3%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.check_preempt_curr
      0.10 ±  9%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.clock_gettime
      0.34 ±  2%      +0.0        0.38        perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.14 ±  2%      +0.0        0.19 ±  4%  perf-profile.children.cycles-pp.attach_entity_load_avg
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.perf_trace_run_bpf_submit
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ct_kernel_exit
      0.03 ± 70%      +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.put_prev_entity
      0.06 ±  6%      +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.rb_insert_color
      0.06 ±  6%      +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.entity_eligible
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.perf_swevent_event
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.__update_load_avg_blocked_se
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.mm_cid_get
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.menu_reflect
      0.05 ±  7%      +0.1        0.11        perf-profile.children.cycles-pp.perf_trace_buf_update
      0.12 ± 11%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.remove_entity_load_avg
      0.31 ±  6%      +0.1        0.37 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.08            +0.1        0.14        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.irqentry_enter
      0.08            +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.10 ± 16%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.06            +0.1        0.13 ±  8%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.08 ± 14%      +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.stress_mwc1
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.34 ±  6%      +0.1        0.41 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.34 ±  6%      +0.1        0.42 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      0.05 ±  8%      +0.1        0.13        perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.error_entry
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.09 ±  5%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.perf_exclude_event
      0.01 ±223%      +0.1        0.09 ±  6%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.08 ±  6%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.sched_clock_noinstr
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.14 ±  3%      +0.1        0.23        perf-profile.children.cycles-pp.get_nohz_timer_target
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.rb_erase
      0.00            +0.1        0.10 ± 80%  perf-profile.children.cycles-pp.get_cpu_device
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.__list_add_valid
      0.36 ±  6%      +0.1        0.46 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.07 ±  6%      +0.1        0.18 ±  5%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.07            +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.__dequeue_entity
      0.06            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.14 ±  3%      +0.1        0.27 ±  2%  perf-profile.children.cycles-pp.update_min_vruntime
      0.32            +0.1        0.45 ±  2%  perf-profile.children.cycles-pp.llist_add_batch
      0.05 ±  8%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.hrtimer_reprogram
      0.09            +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.52 ±  2%      +0.1        0.65        perf-profile.children.cycles-pp.poll_idle
      0.00            +0.1        0.14 ± 37%  perf-profile.children.cycles-pp.cpu_util
      0.01 ±223%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.11 ± 12%      +0.1        0.25 ±  4%  perf-profile.children.cycles-pp.avg_vruntime
      0.10 ±  3%      +0.1        0.24        perf-profile.children.cycles-pp.__calc_delta
      0.00            +0.1        0.14 ± 21%  perf-profile.children.cycles-pp._find_next_and_bit
      0.14 ±  2%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.14            +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.13 ±  2%      +0.1        0.28        perf-profile.children.cycles-pp.timerqueue_add
      0.21 ±  2%      +0.1        0.36 ±  2%  perf-profile.children.cycles-pp.perf_tp_event
      0.08 ± 13%      +0.2        0.23 ±  9%  perf-profile.children.cycles-pp.sem_getvalue@plt
      0.07 ±  6%      +0.2        0.23 ± 14%  perf-profile.children.cycles-pp.__enqueue_entity
      0.00            +0.2        0.16 ±  4%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.05            +0.2        0.21 ±  2%  perf-profile.children.cycles-pp.__hrtimer_init
      0.00            +0.2        0.16 ±  3%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.15 ±  4%      +0.2        0.32        perf-profile.children.cycles-pp.enqueue_hrtimer
      0.08 ±  4%      +0.2        0.24 ±  3%  perf-profile.children.cycles-pp.hrtimer_init_sleeper
      0.09 ±  5%      +0.2        0.26 ±  3%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.45 ± 17%      +0.2        0.62        perf-profile.children.cycles-pp.native_irq_return_iret
      0.05            +0.2        0.22 ±  2%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.00            +0.2        0.18 ±  2%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.05            +0.2        0.23 ± 34%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.26 ±  5%      +0.2        0.45 ±  5%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.2        0.20 ±  2%  perf-profile.children.cycles-pp.tick_irq_enter
      0.11 ±  6%      +0.2        0.30 ±  3%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.14 ±  3%      +0.2        0.34 ±  2%  perf-profile.children.cycles-pp.reweight_entity
      0.01 ±223%      +0.2        0.21 ±  3%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.13 ±  8%      +0.2        0.33 ±  8%  perf-profile.children.cycles-pp.place_entity
      0.19 ±  3%      +0.2        0.39        perf-profile.children.cycles-pp.pick_eevdf
      0.14 ± 11%      +0.2        0.34 ±  2%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.2        0.21 ±  2%  perf-profile.children.cycles-pp.ct_idle_exit
      0.10 ±  4%      +0.2        0.32        perf-profile.children.cycles-pp.update_entity_lag
      0.09 ±  5%      +0.2        0.31 ± 23%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.2        0.22 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.34            +0.2        0.58        perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.13 ±  4%      +0.2        0.38 ±  2%  perf-profile.children.cycles-pp._copy_from_user
      0.00            +0.3        0.26 ±  2%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.12 ±  4%      +0.3        0.38        perf-profile.children.cycles-pp.timerqueue_del
      0.37            +0.3        0.63 ±  2%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.10 ±  6%      +0.3        0.37 ±  2%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.21 ±  8%      +0.3        0.49 ±  2%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.07 ±  5%      +0.3        0.36 ±  2%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.21 ±  9%      +0.3        0.52 ±  5%  perf-profile.children.cycles-pp.__nanosleep
      0.16 ±  3%      +0.3        0.46        perf-profile.children.cycles-pp.get_timespec64
      0.08 ±  4%      +0.3        0.39        perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.19            +0.3        0.50        perf-profile.children.cycles-pp.__update_load_avg_se
      0.09 ±  4%      +0.3        0.40        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.18            +0.3        2.50        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      1.61            +0.3        1.93        perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.19 ±  7%      +0.3        0.53 ±  2%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.12 ±  4%      +0.3        0.46 ±  2%  perf-profile.children.cycles-pp.os_xsave
      0.30 ±  3%      +0.5        0.76 ±  2%  perf-profile.children.cycles-pp.llist_reverse_order
      0.67 ±  9%      +0.5        1.14 ±  7%  perf-profile.children.cycles-pp.__cmd_record
      0.25 ±  2%      +0.5        0.72 ±  2%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.27 ±  2%      +0.5        0.75        perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.44 ±  2%      +0.5        0.93        perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.23 ±  4%      +0.5        0.72 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      0.44 ±  2%      +0.5        0.94 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.53 ± 11%      +0.6        1.10 ±  8%  perf-profile.children.cycles-pp.process_simple
      0.52 ± 11%      +0.6        1.10 ±  8%  perf-profile.children.cycles-pp.ordered_events__queue
      0.54 ± 10%      +0.6        1.11 ±  8%  perf-profile.children.cycles-pp.record__finish_output
      0.54 ± 10%      +0.6        1.11 ±  8%  perf-profile.children.cycles-pp.perf_session__process_events
      0.54 ± 10%      +0.6        1.11 ±  8%  perf-profile.children.cycles-pp.reader__read_event
      0.52 ± 11%      +0.6        1.10 ±  8%  perf-profile.children.cycles-pp.queue_event
      0.44 ±  2%      +0.6        1.02 ±  4%  perf-profile.children.cycles-pp.sem_post@@GLIBC_2.2.5
      0.38            +0.6        0.95        perf-profile.children.cycles-pp.clockevents_program_event
      0.27 ±  3%      +0.6        0.85 ±  2%  perf-profile.children.cycles-pp.cpus_share_cache
      0.17 ±  4%      +0.6        0.77 ±  2%  perf-profile.children.cycles-pp.read_tsc
      0.34 ±  4%      +0.6        0.95        perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.22 ±  2%      +0.6        0.82 ±  2%  perf-profile.children.cycles-pp.__entry_text_start
      0.26            +0.6        0.89        perf-profile.children.cycles-pp.update_rq_clock
      0.60            +0.6        1.23        perf-profile.children.cycles-pp.__smp_call_single_queue
      0.81            +0.7        1.46        perf-profile.children.cycles-pp.update_curr
      2.76            +0.7        3.44        perf-profile.children.cycles-pp.switch_fpu_return
      2.86            +0.7        3.58        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.82 ±  2%      +0.7        1.55        perf-profile.children.cycles-pp.set_task_cpu
      0.83            +0.7        1.56        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      2.46            +0.8        3.24        perf-profile.children.cycles-pp.__x64_sys_sched_yield
      0.24 ±  2%      +0.8        1.03        perf-profile.children.cycles-pp.ktime_get
      2.88            +0.8        3.72        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.74 ±  3%      +0.9        1.63        perf-profile.children.cycles-pp.shim_nanosleep_uint64
      0.25 ±  4%      +0.9        1.19 ±  2%  perf-profile.children.cycles-pp.sched_clock
      0.26 ±  4%      +1.0        1.28        perf-profile.children.cycles-pp.native_sched_clock
      0.63 ±  4%      +1.0        1.67        perf-profile.children.cycles-pp.sem_getvalue@@GLIBC_2.2.5
      0.58            +1.1        1.66        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.29 ±  3%      +1.1        1.38        perf-profile.children.cycles-pp.sched_clock_cpu
      0.78            +1.1        1.88        perf-profile.children.cycles-pp.__switch_to
      0.66 ±  2%      +1.2        1.84 ±  5%  perf-profile.children.cycles-pp.menu_select
      0.66 ±  2%      +1.2        1.85        perf-profile.children.cycles-pp.prepare_task_switch
      0.88            +1.2        2.10        perf-profile.children.cycles-pp.hrtimer_start_range_ns
      1.03 ±  2%      +1.4        2.38 ±  7%  perf-profile.children.cycles-pp.semaphore_posix_thrash
      0.90            +1.4        2.29        perf-profile.children.cycles-pp.__switch_to_asm
      3.06            +1.5        4.58        perf-profile.children.cycles-pp.__sched_yield
      0.99            +1.9        2.86        perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.00            +2.0        2.02 ± 30%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.00            +2.2        2.19 ± 29%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +2.2        2.23 ± 28%  perf-profile.children.cycles-pp.find_busiest_group
      0.07 ±  7%      +2.4        2.47 ± 25%  perf-profile.children.cycles-pp.load_balance
      0.06 ±  8%      +3.3        3.38 ± 18%  perf-profile.children.cycles-pp.newidle_balance
      6.26 ±  3%     +13.2       19.48        perf-profile.children.cycles-pp.intel_idle
     18.09           +15.6       33.68        perf-profile.children.cycles-pp.cpuidle_enter_state
     18.12           +15.6       33.72        perf-profile.children.cycles-pp.cpuidle_enter
     19.00           +17.3       36.32        perf-profile.children.cycles-pp.cpuidle_idle_call
     29.16           -27.6        1.61 ±  4%  perf-profile.self.cycles-pp.update_cfs_group
     17.63           -16.1        1.52 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      7.40 ±  3%      -4.5        2.94 ±  2%  perf-profile.self.cycles-pp.available_idle_cpu
      3.28 ±  2%      -2.5        0.81 ±  2%  perf-profile.self.cycles-pp.select_idle_core
      1.51 ±  5%      -1.4        0.16 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.62            -0.3        0.28 ±  2%  perf-profile.self.cycles-pp._find_next_bit
      0.38 ±  7%      -0.3        0.13 ±  2%  perf-profile.self.cycles-pp.select_idle_cpu
      0.38 ±  3%      -0.2        0.24 ±  2%  perf-profile.self.cycles-pp.migrate_task_rq_fair
      0.21 ± 31%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__update_idle_core
      0.42 ±  3%      -0.1        0.31 ±  3%  perf-profile.self.cycles-pp.__bitmap_andnot
      0.19 ±  6%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.44 ±  2%      -0.1        0.37        perf-profile.self.cycles-pp.__x64_sys_clock_nanosleep
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.clockevents_program_event
      0.08            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.09            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.12 ±  3%      +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.17 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.14 ±  2%      +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.attach_entity_load_avg
      0.08 ±  6%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.08 ±  6%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.yield_task_fair
      0.06 ±  8%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.rb_insert_color
      0.08            +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.05 ±  8%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.entity_eligible
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__update_load_avg_blocked_se
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.mm_cid_get
      0.09 ±  4%      +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.__hrtimer_start_range_ns
      0.08            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.update_blocked_averages
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.hrtimer_try_to_cancel
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.activate_task
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.hrtimer_next_event_without
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.95            +0.1        1.01        perf-profile.self.cycles-pp.hrtimer_active
      0.06 ± 14%      +0.1        0.12 ±  8%  perf-profile.self.cycles-pp.stress_mwc1
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.perf_exclude_event
      0.42            +0.1        0.48        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.05            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.set_next_entity
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.tick_nohz_idle_enter
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.check_preempt_curr
      0.06 ±  9%      +0.1        0.13 ±  2%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.07 ±  8%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.1        0.07 ±  9%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.09 ±  5%      +0.1        0.16 ±  5%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.08 ± 12%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.error_entry
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.sched_clock
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.05            +0.1        0.13 ±  4%  perf-profile.self.cycles-pp.__dequeue_entity
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.select_task_rq
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.do_sched_yield
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.get_timespec64
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.tick_nohz_idle_exit
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.08 ±  7%  perf-profile.self.cycles-pp.__list_add_valid
      0.08 ±  6%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.16 ±  2%      +0.1        0.25 ±  2%  perf-profile.self.cycles-pp.perf_tp_event
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.poll_idle
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.rb_erase
      0.13 ±  3%      +0.1        0.22 ±  3%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.14 ±  3%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.get_nohz_timer_target
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.10 ±  5%      +0.1        0.19        perf-profile.self.cycles-pp.try_to_wake_up
      0.07 ±  6%      +0.1        0.17        perf-profile.self.cycles-pp.timerqueue_add
      0.02 ± 99%      +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.update_entity_lag
      0.00            +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.28            +0.1        0.38 ±  4%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.00            +0.1        0.10 ±  6%  perf-profile.self.cycles-pp.load_balance
      0.08 ±  4%      +0.1        0.18        perf-profile.self.cycles-pp.select_task_rq_fair
      0.14 ±  4%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.update_min_vruntime
      0.04 ± 47%      +0.1        0.15 ± 12%  perf-profile.self.cycles-pp.place_entity
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.11 ± 42%  perf-profile.self.cycles-pp.cpu_util
      0.10            +0.1        0.21 ±  4%  perf-profile.self.cycles-pp.update_rq_clock
      0.28 ±  3%      +0.1        0.40        perf-profile.self.cycles-pp.dequeue_entity
      0.07 ± 16%      +0.1        0.20 ±  7%  perf-profile.self.cycles-pp.sem_getvalue@plt
      0.32            +0.1        0.44 ±  2%  perf-profile.self.cycles-pp.llist_add_batch
      0.05 ±  7%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.hrtimer_reprogram
      0.08 ± 10%      +0.1        0.21 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      0.06            +0.1        0.19        perf-profile.self.cycles-pp.common_nsleep
      0.09 ±  5%      +0.1        0.22        perf-profile.self.cycles-pp.__calc_delta
      0.00            +0.1        0.13 ± 23%  perf-profile.self.cycles-pp._find_next_and_bit
      0.07            +0.1        0.20 ± 16%  perf-profile.self.cycles-pp.__enqueue_entity
      0.09 ±  4%      +0.1        0.23 ±  4%  perf-profile.self.cycles-pp.avg_vruntime
      0.00            +0.1        0.14 ±  9%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.13 ±  5%      +0.1        0.27        perf-profile.self.cycles-pp.pick_eevdf
      0.00            +0.1        0.15 ±  2%  perf-profile.self.cycles-pp.cpu_startup_entry
      0.21 ±  2%      +0.2        0.36 ±  2%  perf-profile.self.cycles-pp.hrtimer_nanosleep
      0.00            +0.2        0.15 ±  4%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.08 ±  5%      +0.2        0.24 ±  2%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.2        0.16 ±  3%  perf-profile.self.cycles-pp.call_cpuidle
      0.06 ±  6%      +0.2        0.22 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      0.45 ± 17%      +0.2        0.62        perf-profile.self.cycles-pp.native_irq_return_iret
      0.08 ±  6%      +0.2        0.25 ±  3%  perf-profile.self.cycles-pp.timerqueue_del
      0.13 ±  3%      +0.2        0.31 ±  3%  perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.00            +0.2        0.17 ±  2%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.01 ±223%      +0.2        0.19 ±  2%  perf-profile.self.cycles-pp.__hrtimer_init
      0.03 ± 70%      +0.2        0.22 ±  2%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.01 ±223%      +0.2        0.19 ±  3%  perf-profile.self.cycles-pp.schedule_idle
      0.17 ±  2%      +0.2        0.36 ±  2%  perf-profile.self.cycles-pp.schedule
      0.14            +0.2        0.33 ±  2%  perf-profile.self.cycles-pp.do_nanosleep
      0.11 ±  6%      +0.2        0.30 ±  2%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.12 ±  4%      +0.2        0.32 ±  2%  perf-profile.self.cycles-pp.reweight_entity
      0.09 ±  5%      +0.2        0.30 ± 23%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.2        0.22 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.12 ±  5%      +0.2        0.34 ±  2%  perf-profile.self.cycles-pp.hrtimer_start_range_ns
      0.11 ±  3%      +0.2        0.34 ±  2%  perf-profile.self.cycles-pp._copy_from_user
      0.09 ±  5%      +0.2        0.33 ±  2%  perf-profile.self.cycles-pp.ktime_get
      0.12            +0.2        0.37        perf-profile.self.cycles-pp.pick_next_task_fair
      0.09 ±  6%      +0.3        0.35 ±  2%  perf-profile.self.cycles-pp.__sched_yield
      0.28 ±  2%      +0.3        0.54 ±  2%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.07 ±  7%      +0.3        0.33 ±  2%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.17 ±  2%      +0.3        0.45        perf-profile.self.cycles-pp.__update_load_avg_se
      0.19 ±  3%      +0.3        0.48        perf-profile.self.cycles-pp.sched_ttwu_pending
      0.34 ±  2%      +0.3        0.62        perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.19 ± 11%      +0.3        0.48 ±  5%  perf-profile.self.cycles-pp.__nanosleep
      0.08 ±  7%      +0.3        0.38        perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.08 ±  5%      +0.3        0.39        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.18            +0.3        2.50        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      1.61            +0.3        1.93        perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.31 ±  2%      +0.3        0.64 ±  8%  perf-profile.self.cycles-pp.enqueue_entity
      0.11 ±  3%      +0.3        0.45        perf-profile.self.cycles-pp.os_xsave
      0.05 ±  8%      +0.3        0.40 ± 12%  perf-profile.self.cycles-pp.newidle_balance
      0.31            +0.3        0.66        perf-profile.self.cycles-pp.update_curr
      0.25 ±  4%      +0.4        0.61 ±  2%  perf-profile.self.cycles-pp.menu_select
      0.58            +0.4        0.94        perf-profile.self.cycles-pp.switch_fpu_return
      0.19 ±  5%      +0.4        0.59 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.10 ±  6%      +0.4        0.54        perf-profile.self.cycles-pp.do_idle
      0.43            +0.4        0.86 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.30 ±  4%      +0.5        0.75 ±  2%  perf-profile.self.cycles-pp.llist_reverse_order
      0.25 ±  2%      +0.5        0.72 ±  2%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.27 ±  2%      +0.5        0.74        perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.37 ±  8%      +0.5        0.90 ±  3%  perf-profile.self.cycles-pp.clock_nanosleep
      0.21 ±  2%      +0.6        0.76 ±  6%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.52 ± 10%      +0.6        1.08 ±  8%  perf-profile.self.cycles-pp.queue_event
      0.27 ±  3%      +0.6        0.84 ±  2%  perf-profile.self.cycles-pp.cpus_share_cache
      0.31 ±  2%      +0.6        0.90 ±  5%  perf-profile.self.cycles-pp.sem_post@@GLIBC_2.2.5
      0.17 ±  4%      +0.6        0.75        perf-profile.self.cycles-pp.read_tsc
      1.08            +0.7        1.83        perf-profile.self.cycles-pp.finish_task_switch
      0.25 ±  2%      +0.7        1.00 ±  2%  perf-profile.self.cycles-pp.set_task_cpu
      0.49 ±  2%      +0.8        1.32        perf-profile.self.cycles-pp.shim_nanosleep_uint64
      0.55            +0.9        1.44        perf-profile.self.cycles-pp.prepare_task_switch
      0.46 ±  4%      +0.9        1.37        perf-profile.self.cycles-pp.sem_getvalue@@GLIBC_2.2.5
      0.25 ±  4%      +1.0        1.23        perf-profile.self.cycles-pp.native_sched_clock
      0.25 ±  4%      +1.0        1.24        perf-profile.self.cycles-pp.cpuidle_enter_state
      1.03 ±  2%      +1.0        2.06 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.57 ±  2%      +1.1        1.62        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.76            +1.1        1.83        perf-profile.self.cycles-pp.__switch_to
      0.84 ±  2%      +1.3        2.12 ±  8%  perf-profile.self.cycles-pp.semaphore_posix_thrash
      0.90            +1.4        2.28        perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +1.5        1.55 ± 30%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.98            +1.9        2.83        perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.97            +2.1        4.04        perf-profile.self.cycles-pp.__schedule
      6.26 ±  3%     +13.2       19.48        perf-profile.self.cycles-pp.intel_idle



***************************************************************************************************
lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/sc_pid_max/tbox_group/test/testcase/testtime:
  scheduler/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/4194304/lkp-spr-r02/switch/stress-ng/60s

commit: 
  63304558ba ("sched/eevdf: Curb wakeup-preemption")
  0a24d7afed ("sched/fair: ratelimit update to tg->load_avg")

63304558ba5dcaaf 0a24d7afed5c3c59ee212782f9c 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.792e+08 ±  4%    +356.6%  8.181e+08        cpuidle..usage
   1257499 ± 25%     +97.2%    2479986 ±  4%  numa-numastat.node1.local_node
   1363779 ± 23%     +92.3%    2622537 ±  3%  numa-numastat.node1.numa_hit
      1520 ±  3%     -37.6%     949.17 ±  3%  perf-c2c.DRAM.remote
     83408 ±  2%     +32.9%     110872 ±  2%  perf-c2c.HITM.local
      1113 ±  3%     -28.4%     797.33 ±  3%  perf-c2c.HITM.remote
     84522 ±  2%     +32.1%     111670 ±  2%  perf-c2c.HITM.total
   6744974 ±  4%     +65.1%   11139304 ±  2%  vmstat.memory.cache
    182.17           +18.0%     215.00        vmstat.procs.r
   7208379 ±  4%    +394.4%   35639830        vmstat.system.cs
    904223 ±  2%    +192.2%    2641908        vmstat.system.in
     29.53            -4.7       24.87        mpstat.cpu.all.idle%
      7.99            -5.0        2.98        mpstat.cpu.all.irq%
      0.43 ±  5%      -0.2        0.25        mpstat.cpu.all.soft%
     56.25            +8.2       64.42        mpstat.cpu.all.sys%
      5.80            +1.7        7.47        mpstat.cpu.all.usr%
 1.415e+08 ±  5%    +422.1%  7.387e+08        stress-ng.switch.ops
   2357895 ±  5%    +422.1%   12310763        stress-ng.switch.ops_per_sec
    303844 ±  4%   +1122.7%    3715226        stress-ng.time.involuntary_context_switches
     12532           +14.7%      14376        stress-ng.time.percent_of_cpu_this_job_got
      7172           +12.8%       8090        stress-ng.time.system_time
    629.90           +35.9%     856.07        stress-ng.time.user_time
 2.732e+08 ±  5%    +403.8%  1.377e+09        stress-ng.time.voluntary_context_switches
    438651 ±  2%     +14.6%     502822        meminfo.AnonPages
   6551534 ±  4%     +66.5%   10905701 ±  2%  meminfo.Cached
   8926904 ±  3%     +49.2%   13315485        meminfo.Committed_AS
   4104936 ±  7%    +107.1%    8502046 ±  2%  meminfo.Inactive
   4104785 ±  7%    +107.1%    8501888 ±  2%  meminfo.Inactive(anon)
   1189315 ±  3%     +25.4%    1491641        meminfo.Mapped
  10181121 ±  2%     +43.5%   14606335        meminfo.Memused
   3807597 ±  7%    +114.4%    8161798 ±  2%  meminfo.Shmem
  10280871 ±  3%     +43.0%   14704729        meminfo.max_used_kB
    378940 ± 45%     +59.0%     602609 ±  9%  numa-vmstat.node0.nr_inactive_anon
    378938 ± 45%     +59.0%     602607 ±  9%  numa-vmstat.node0.nr_zone_inactive_anon
    638178 ± 26%    +139.5%    1528430 ±  3%  numa-vmstat.node1.nr_file_pages
    648468 ± 27%    +135.1%    1524245 ±  2%  numa-vmstat.node1.nr_inactive_anon
    188166 ±  6%     +39.7%     262869        numa-vmstat.node1.nr_mapped
    615278 ± 29%    +144.7%    1505431 ±  2%  numa-vmstat.node1.nr_shmem
    648464 ± 27%    +135.1%    1524241 ±  2%  numa-vmstat.node1.nr_zone_inactive_anon
   1363943 ± 23%     +92.3%    2622303 ±  3%  numa-vmstat.node1.numa_hit
   1257663 ± 25%     +97.2%    2479754 ±  4%  numa-vmstat.node1.numa_local
    277293 ± 20%     +99.2%     552340 ±  9%  numa-meminfo.node0.AnonPages.max
   1515282 ± 45%     +59.1%    2410064 ±  9%  numa-meminfo.node0.Inactive
   1515280 ± 45%     +59.0%    2410010 ±  9%  numa-meminfo.node0.Inactive(anon)
   5921261 ± 11%     +14.3%    6767795 ±  2%  numa-meminfo.node0.MemUsed
   2551274 ± 26%    +139.6%    6112583 ±  3%  numa-meminfo.node1.FilePages
   2592782 ± 27%    +135.1%    6095995 ±  2%  numa-meminfo.node1.Inactive
   2592634 ± 27%    +135.1%    6095892 ±  2%  numa-meminfo.node1.Inactive(anon)
    751876 ±  6%     +39.7%    1049995        numa-meminfo.node1.Mapped
   4262948 ± 16%     +84.0%    7842823 ±  2%  numa-meminfo.node1.MemUsed
   2459674 ± 29%    +144.8%    6020586 ±  2%  numa-meminfo.node1.Shmem
  20460839 ± 21%   +2277.8%  4.865e+08        turbostat.C1
      1.38 ± 17%      +6.6        8.02        turbostat.C1%
 1.557e+08 ±  2%     -94.5%    8505821 ±  2%  turbostat.C1E
     14.93           -11.8        3.09 ±  7%  turbostat.C1E%
     18.32           -31.4%      12.56 ±  3%  turbostat.CPU%c1
      0.08 ±  6%    +278.3%       0.29        turbostat.IPC
  58972223 ±  3%    +193.9%  1.733e+08        turbostat.IRQ
   2614421 ±  3%  +12238.7%  3.226e+08        turbostat.POLL
      0.06 ±  6%      +4.5        4.53        turbostat.POLL%
    550.43           +22.6%     675.10        turbostat.PkgWatt
     17.66            +3.4%      18.26        turbostat.RAMWatt
    109633 ±  2%     +14.5%     125554        proc-vmstat.nr_anon_pages
   6299234            -1.7%    6189022        proc-vmstat.nr_dirty_background_threshold
  12613872            -1.7%   12393176        proc-vmstat.nr_dirty_threshold
   1638204 ±  4%     +66.3%    2724201 ±  2%  proc-vmstat.nr_file_pages
  63369354            -1.7%   62265610        proc-vmstat.nr_free_pages
   1026430 ±  7%    +106.9%    2123321 ±  2%  proc-vmstat.nr_inactive_anon
    297396 ±  3%     +24.9%     371454        proc-vmstat.nr_mapped
    952218 ±  7%    +114.1%    2038225 ±  3%  proc-vmstat.nr_shmem
     40692            +6.3%      43273        proc-vmstat.nr_slab_reclaimable
   1026430 ±  7%    +106.9%    2123321 ±  2%  proc-vmstat.nr_zone_inactive_anon
    243574 ±  8%     +39.3%     339259 ±  2%  proc-vmstat.numa_hint_faults
    135818 ± 18%     +70.6%     231662 ±  3%  proc-vmstat.numa_hint_faults_local
   2345361 ±  4%     +68.7%    3956948 ±  2%  proc-vmstat.numa_hit
   2109765 ±  5%     +76.6%    3724999 ±  2%  proc-vmstat.numa_local
    544814 ±  4%     +17.3%     639106 ±  3%  proc-vmstat.numa_pte_updates
     16992 ± 10%     +37.7%      23393 ±  6%  proc-vmstat.pgactivate
   2439275 ±  4%     +66.3%    4056303 ±  2%  proc-vmstat.pgalloc_normal
   1112292           +16.6%    1296617        proc-vmstat.pgfault
   3291142           +14.7%    3773335        sched_debug.cfs_rq:/.avg_vruntime.avg
   4708699 ±  5%     +15.7%    5449685 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.max
    651007 ±  8%     -41.3%     382212 ± 12%  sched_debug.cfs_rq:/.left_vruntime.avg
   3404176           +21.7%    4141767 ± 13%  sched_debug.cfs_rq:/.left_vruntime.max
   1303825 ±  3%     -13.0%    1134537 ±  5%  sched_debug.cfs_rq:/.left_vruntime.stddev
   3291142           +14.7%    3773335        sched_debug.cfs_rq:/.min_vruntime.avg
   4708699 ±  5%     +15.7%    5449685 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
    651007 ±  8%     -41.3%     382212 ± 12%  sched_debug.cfs_rq:/.right_vruntime.avg
   3404176           +21.7%    4141767 ± 13%  sched_debug.cfs_rq:/.right_vruntime.max
   1303825 ±  3%     -13.0%    1134537 ±  5%  sched_debug.cfs_rq:/.right_vruntime.stddev
    309.43 ±  6%     -22.4%     240.16 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    184.67 ±  6%     -16.8%     153.61        sched_debug.cfs_rq:/.util_avg.stddev
     67.77 ± 14%     -83.0%      11.54 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.avg
     99.34 ± 11%     -35.4%      64.19 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
     44.07 ± 12%     -70.0%      13.22 ±  4%  sched_debug.cpu.clock.stddev
      2416 ±  7%     +21.8%       2943 ±  2%  sched_debug.cpu.curr->pid.avg
      0.00 ± 11%     -60.0%       0.00 ± 10%  sched_debug.cpu.next_balance.stddev
      0.47 ±  6%     +17.7%       0.55 ±  4%  sched_debug.cpu.nr_running.avg
    993749 ±  5%    +397.7%    4946105        sched_debug.cpu.nr_switches.avg
   1123429 ±  4%    +367.4%    5250556        sched_debug.cpu.nr_switches.max
    528386 ± 14%    +339.9%    2324144 ± 17%  sched_debug.cpu.nr_switches.min
     81513 ± 18%    +225.4%     265263 ±  4%  sched_debug.cpu.nr_switches.stddev
      1.55 ±  7%     -31.3%       1.07 ±  2%  sched_debug.rt_rq:.rt_time.avg
    347.61 ±  7%     -31.3%     238.83 ±  2%  sched_debug.rt_rq:.rt_time.max
     23.17 ±  7%     -31.3%      15.92 ±  2%  sched_debug.rt_rq:.rt_time.stddev
     14.40            +8.8%      15.66        perf-stat.i.MPKI
 1.419e+10 ±  4%    +300.9%  5.688e+10        perf-stat.i.branch-instructions
      1.36            -0.1        1.23        perf-stat.i.branch-miss-rate%
 1.624e+08 ±  4%    +298.8%  6.478e+08        perf-stat.i.branch-misses
      2.71 ±  3%      -0.8        1.89 ±  2%  perf-stat.i.cache-miss-rate%
  14303386 ±  3%    +104.9%   29304692        perf-stat.i.cache-misses
 8.988e+08 ±  5%    +381.5%  4.328e+09        perf-stat.i.cache-references
   7363534 ±  5%    +401.1%   36899734        perf-stat.i.context-switches
      8.28 ±  4%     -74.7%       2.10        perf-stat.i.cpi
 5.176e+11           +12.5%  5.822e+11        perf-stat.i.cpu-cycles
   2716479 ±  5%    +389.6%   13299565        perf-stat.i.cpu-migrations
     43307 ±  2%     -37.0%      27270        perf-stat.i.cycles-between-cache-misses
  41832335 ±  9%    +354.4%  1.901e+08 ±  2%  perf-stat.i.dTLB-load-misses
   1.8e+10 ±  4%    +315.9%  7.485e+10        perf-stat.i.dTLB-loads
   5430661 ±  6%    +373.7%   25724171 ±  2%  perf-stat.i.dTLB-store-misses
 9.847e+09 ±  4%    +333.9%  4.272e+10        perf-stat.i.dTLB-stores
 7.026e+10 ±  4%    +305.4%  2.849e+11        perf-stat.i.instructions
      0.17 ±  3%    +205.6%       0.51        perf-stat.i.ipc
      2.31           +12.5%       2.60        perf-stat.i.metric.GHz
    111.01 ±  3%    +264.1%     404.23        perf-stat.i.metric.K/sec
    191.57 ±  4%    +316.5%     797.89        perf-stat.i.metric.M/sec
     18432 ±  2%      +9.5%      20184        perf-stat.i.minor-faults
     81.21           -13.1       68.09        perf-stat.i.node-load-miss-rate%
   4976001 ±  2%     +46.0%    7265429        perf-stat.i.node-load-misses
   1487000 ±  6%    +219.9%    4757391        perf-stat.i.node-loads
     18432 ±  2%      +9.5%      20184        perf-stat.i.page-faults
     13.31           +15.2%      15.34        perf-stat.overall.MPKI
      1.19            -0.0        1.15        perf-stat.overall.branch-miss-rate%
      1.56 ±  4%      -0.9        0.67        perf-stat.overall.cache-miss-rate%
      7.69 ±  4%     -73.2%       2.06        perf-stat.overall.cpi
     37074 ±  3%     -45.7%      20124        perf-stat.overall.cycles-between-cache-misses
      0.06 ±  2%      +0.0        0.06 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
      0.13 ±  4%    +272.6%       0.49        perf-stat.overall.ipc
     73.48           -14.1       59.33        perf-stat.overall.node-load-miss-rate%
 1.334e+10 ±  4%    +317.8%  5.572e+10        perf-stat.ps.branch-instructions
 1.584e+08 ±  5%    +304.7%  6.411e+08        perf-stat.ps.branch-misses
  13716290 ±  3%    +108.4%   28582536        perf-stat.ps.cache-misses
  8.82e+08 ±  5%    +385.7%  4.284e+09        perf-stat.ps.cache-references
   7221087 ±  5%    +405.8%   36523032        perf-stat.ps.context-switches
    217584            +1.3%     220460        perf-stat.ps.cpu-clock
 5.081e+11           +13.2%  5.751e+11        perf-stat.ps.cpu-cycles
   2673546 ±  5%    +392.9%   13179198        perf-stat.ps.cpu-migrations
  40827035 ±  9%    +360.3%  1.879e+08 ±  2%  perf-stat.ps.dTLB-load-misses
 1.708e+10 ±  4%    +330.6%  7.352e+10        perf-stat.ps.dTLB-loads
   5337456 ±  6%    +377.4%   25482959 ±  2%  perf-stat.ps.dTLB-store-misses
 9.357e+09 ±  5%    +348.8%  4.199e+10        perf-stat.ps.dTLB-stores
 6.622e+10 ±  4%    +321.8%  2.793e+11        perf-stat.ps.instructions
     16190 ±  2%     +19.0%      19266        perf-stat.ps.minor-faults
   4783057 ±  2%     +49.3%    7140248        perf-stat.ps.node-load-misses
   1727513 ±  5%    +183.3%    4893702        perf-stat.ps.node-loads
     16190 ±  2%     +19.0%      19266        perf-stat.ps.page-faults
    217584            +1.3%     220460        perf-stat.ps.task-clock
 4.156e+12 ±  4%    +320.9%  1.749e+13        perf-stat.total.instructions
     22.02           -17.7        4.28        perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
     18.48           -15.1        3.42        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
     24.23           -15.0        9.26        perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     19.99           -14.3        5.66        perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue
     20.09           -14.2        5.84        perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle
     20.68           -13.6        7.10        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
     21.09           -12.8        8.24        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
     10.08           -10.1        0.00        perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_entity.dequeue_task_fair.__schedule.schedule
      9.04            -9.0        0.00        perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
     37.64            -7.7       29.92        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     37.84            -7.7       30.19        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     37.66            -7.7       30.01        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     37.67            -7.6       30.04        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     10.34            -7.3        3.07        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
     10.14            -7.1        3.07        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_write.vfs_write
      8.31            -6.8        1.48        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate
      8.11            -5.8        2.26        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_read
      7.93            -5.7        2.26        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe_write
     12.83            -4.9        7.91        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
     12.92            -4.8        8.07        perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
     12.61            -4.7        7.88        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_write.vfs_write.ksys_write
     12.69            -4.6        8.04        perf-profile.calltrace.cycles-pp.schedule.pipe_write.vfs_write.ksys_write.do_syscall_64
      4.66            -2.6        2.06        perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
      1.94            -1.3        0.66        perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule_idle.do_idle
      2.01            -1.1        0.91        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
      5.61            -1.0        4.65        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.61            +0.2        0.79        perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule_idle.do_idle.cpu_startup_entry
      1.18 ±  2%      +0.2        1.38        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.17 ±  2%      +0.2        1.39        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.56 ±  4%      +0.3        0.82 ±  2%  perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      0.59 ±  4%      +0.3        0.87 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      1.22 ±  2%      +0.3        1.54        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.22 ±  2%      +0.3        1.54        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.97            +0.3        1.30        perf-profile.calltrace.cycles-pp.sched_mm_cid_migrate_to.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
     26.91            +0.4       27.31        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.19 ±  2%      +0.4        2.61        perf-profile.calltrace.cycles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.__switch_to
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.pipe_write.vfs_write
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.pipe_read.vfs_read
      0.00            +0.6        0.62        perf-profile.calltrace.cycles-pp.__update_load_avg_cfs_rq.update_load_avg.enqueue_entity.enqueue_task_fair.activate_task
      0.00            +0.6        0.63        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.pipe_read.vfs_read
      0.66 ±  4%      +0.6        1.29        perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.pipe_write.vfs_write
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.34 ± 70%      +0.7        1.04        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.00            +0.7        0.72        perf-profile.calltrace.cycles-pp.nohz_run_idle_balance.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +0.7        0.73        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_read.vfs_read.ksys_read
      0.00            +0.7        0.74        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_write.vfs_write.ksys_write
      0.00            +0.8        0.76        perf-profile.calltrace.cycles-pp.__update_idle_core.pick_next_task_idle.__schedule.schedule.pipe_write
      0.00            +0.8        0.77 ±  2%  perf-profile.calltrace.cycles-pp.__update_idle_core.pick_next_task_idle.__schedule.schedule.pipe_read
      0.00            +0.8        0.77        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read
      0.00            +0.8        0.78        perf-profile.calltrace.cycles-pp.pick_next_task_idle.__schedule.schedule.pipe_write.vfs_write
      0.00            +0.8        0.78        perf-profile.calltrace.cycles-pp.pick_next_task_idle.__schedule.schedule.pipe_read.vfs_read
      1.41 ±  2%      +0.8        2.19        perf-profile.calltrace.cycles-pp.migrate_task_rq_fair.set_task_cpu.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.60 ±  2%      +0.8        2.38        perf-profile.calltrace.cycles-pp.set_task_cpu.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.00            +0.8        0.82        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
     27.39            +0.8       28.21        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.8        0.83        perf-profile.calltrace.cycles-pp.__switch_to_asm
      0.00            +0.8        0.84        perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00            +0.9        0.86        perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
     27.50            +0.9       28.44        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     27.56            +1.0       28.52        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +1.0        0.97        perf-profile.calltrace.cycles-pp.llist_reverse_order.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry
      0.00            +1.0        1.02        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.59            +1.0        5.60        perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.1        1.14        perf-profile.calltrace.cycles-pp.wake_affine.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function
      0.00            +1.1        1.15        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule_idle.do_idle.cpu_startup_entry
      4.66            +1.2        5.82        perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +1.2        1.20        perf-profile.calltrace.cycles-pp.remove_entity_load_avg.migrate_task_rq_fair.set_task_cpu.try_to_wake_up.autoremove_wake_function
      1.03 ±  5%      +1.2        2.27 ±  2%  perf-profile.calltrace.cycles-pp.stress_switch_pipe
     27.94            +1.3       29.20        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     28.83            +1.4       30.20        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +1.4        1.38 ±  3%  perf-profile.calltrace.cycles-pp.__bitmap_andnot.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair
     29.00            +1.4       30.43        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     28.10            +1.4       29.54        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +1.5        1.50        perf-profile.calltrace.cycles-pp.llist_add_batch.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function
      1.44            +1.6        3.09        perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
     29.38            +1.8       31.21        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     29.55            +1.9       31.44        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.00            +2.3        2.30        perf-profile.calltrace.cycles-pp.__smp_call_single_queue.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common
     29.58            +2.4       32.02        perf-profile.calltrace.cycles-pp.write
     12.07            +2.9       15.00        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write
     12.15            +2.9       15.10        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_read
     12.09            +3.0       15.06        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write
     12.17            +3.0       15.16        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_read.vfs_read
     30.16            +3.0       33.17        perf-profile.calltrace.cycles-pp.read
     12.31            +3.3       15.64        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_write.ksys_write
     12.50            +3.4       15.86        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
     12.40            +3.4       15.76        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_read.vfs_read.ksys_read
     12.60            +3.4       16.00        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.68            +3.5        9.22        perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair
      6.99            +3.8       10.76        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      7.07            +3.8       10.85        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      7.98            +4.7       12.72        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      8.56            +5.0       13.55        perf-profile.calltrace.cycles-pp.select_idle_core.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq
      0.00            +5.1        5.14        perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     10.17            +5.7       15.90        perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up
     11.79            +6.6       18.37        perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function
     12.90            +7.0       19.90        perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common
     13.07            +7.0       20.12        perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
     27.98           -26.6        1.35 ±  5%  perf-profile.children.cycles-pp.update_cfs_group
     24.39           -18.8        5.58        perf-profile.children.cycles-pp.enqueue_task_fair
     25.65           -18.4        7.23        perf-profile.children.cycles-pp.activate_task
     25.77           -18.2        7.60        perf-profile.children.cycles-pp.ttwu_do_activate
     25.03           -16.7        8.29        perf-profile.children.cycles-pp.sched_ttwu_pending
     25.58           -15.9        9.70        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
     20.04           -15.7        4.30        perf-profile.children.cycles-pp.enqueue_entity
     24.41           -15.0        9.38        perf-profile.children.cycles-pp.flush_smp_call_function_queue
     20.52           -14.4        6.17        perf-profile.children.cycles-pp.dequeue_task_fair
     16.78           -11.6        5.22        perf-profile.children.cycles-pp.update_load_avg
     16.11           -11.5        4.60        perf-profile.children.cycles-pp.dequeue_entity
     25.62            -9.4       16.18        perf-profile.children.cycles-pp.schedule
     30.10            -8.4       21.65        perf-profile.children.cycles-pp.__schedule
     37.82            -7.7       30.12        perf-profile.children.cycles-pp.do_idle
     37.84            -7.7       30.19        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     37.84            -7.7       30.19        perf-profile.children.cycles-pp.cpu_startup_entry
     37.67            -7.6       30.04        perf-profile.children.cycles-pp.start_secondary
      4.42            -2.9        1.47        perf-profile.children.cycles-pp.__sysvec_call_function_single
      4.45            -2.9        1.58        perf-profile.children.cycles-pp.sysvec_call_function_single
      4.56            -2.7        1.88        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      2.32            -1.4        0.92        perf-profile.children.cycles-pp.set_next_entity
      2.24 ±  3%      -1.3        0.96        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      5.64            -1.0        4.68        perf-profile.children.cycles-pp.intel_idle
      2.54            -0.8        1.75        perf-profile.children.cycles-pp.pick_next_task_fair
      1.30 ±  6%      -0.7        0.62        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.24 ±  6%      -0.7        0.58        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.69 ±  6%      -0.4        0.32 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.68 ±  6%      -0.4        0.31 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.63 ±  6%      -0.4        0.28 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.58 ±  7%      -0.3        0.24        perf-profile.children.cycles-pp.tick_sched_handle
      0.58 ±  7%      -0.3        0.24 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.59 ±  6%      -0.3        0.25 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      0.54 ±  6%      -0.3        0.21 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.42 ±  4%      -0.3        0.11 ±  4%  perf-profile.children.cycles-pp.__task_rq_lock
      0.53 ±  5%      -0.3        0.24        perf-profile.children.cycles-pp.__do_softirq
      0.55 ±  5%      -0.3        0.28        perf-profile.children.cycles-pp.__irq_exit_rcu
      0.24 ±  3%      -0.1        0.10 ±  3%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.15 ±  5%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.task_work_run
      0.15 ±  8%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.16 ±  7%      -0.1        0.11        perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.10 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.24 ±  4%      -0.0        0.21        perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.07 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.inode_needs_update_time
      0.33 ±  2%      +0.0        0.35        perf-profile.children.cycles-pp.cpus_share_cache
      0.12 ±  4%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.file_update_time
      0.08 ±  8%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.09 ± 15%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.16 ±  4%      +0.0        0.19        perf-profile.children.cycles-pp.touch_atime
      0.11 ±  4%      +0.0        0.15        perf-profile.children.cycles-pp.atime_needs_update
      0.06            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__get_task_ioprio
      0.06 ±  9%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.resched_curr
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.perf_swevent_event
      0.00            +0.1        0.05        perf-profile.children.cycles-pp._find_next_and_bit
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.can_stop_idle_tick
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.perf_trace_run_bpf_submit
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.kill_fasync
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.46            +0.1        0.52        perf-profile.children.cycles-pp.perf_tp_event
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.sched_clock_noinstr
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.rb_next
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.02 ± 99%      +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.aa_file_perm
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.put_prev_entity
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.perf_exclude_event
      0.12 ±  4%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.cpuacct_charge
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.mm_cid_get
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.10 ±  8%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.02 ± 99%      +0.1        0.10        perf-profile.children.cycles-pp.current_time
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.__x2apic_send_IPI_dest
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.10 ± 23%  perf-profile.children.cycles-pp.read@plt
      0.00            +0.1        0.10        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.1        0.10        perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.45 ±  2%      +0.1        0.56        perf-profile.children.cycles-pp.task_h_load
      0.12 ±  4%      +0.1        0.22        perf-profile.children.cycles-pp.avg_vruntime
      0.12 ±  3%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.attach_entity_load_avg
      0.27 ±  3%      +0.1        0.38 ±  2%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.00            +0.1        0.11        perf-profile.children.cycles-pp.ct_kernel_enter
      0.08 ±  6%      +0.1        0.19        perf-profile.children.cycles-pp.__calc_delta
      0.00            +0.1        0.12        perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__list_add_valid
      0.14 ±  3%      +0.1        0.26        perf-profile.children.cycles-pp.update_entity_lag
      0.02 ±141%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.12 ± 12%      +0.1        0.25        perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.13        perf-profile.children.cycles-pp.ct_idle_exit
      0.00            +0.1        0.13        perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.13 ±  3%      +0.1        0.26        perf-profile.children.cycles-pp.place_entity
      0.06 ±  7%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.pick_eevdf
      0.28 ±  3%      +0.1        0.42        perf-profile.children.cycles-pp.security_file_permission
      0.10 ±  5%      +0.1        0.24        perf-profile.children.cycles-pp.check_preempt_curr
      0.04 ± 44%      +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.__dequeue_entity
      0.00            +0.2        0.15        perf-profile.children.cycles-pp._raw_spin_trylock
      0.07 ±  7%      +0.2        0.22        perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.05 ±  8%      +0.2        0.21 ±  2%  perf-profile.children.cycles-pp.call_cpuidle
      0.06 ±  6%      +0.2        0.22        perf-profile.children.cycles-pp.read_tsc
      0.04 ± 44%      +0.2        0.21 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.2        0.16 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.17 ±  4%      +0.2        0.34 ±  2%  perf-profile.children.cycles-pp.update_min_vruntime
      0.28 ±  7%      +0.2        0.45 ±  3%  perf-profile.children.cycles-pp.copyin
      0.00            +0.2        0.17        perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.00            +0.2        0.17        perf-profile.children.cycles-pp.local_clock_noinstr
      0.19 ±  9%      +0.2        0.36        perf-profile.children.cycles-pp.tick_nohz_next_event
      0.44 ±  2%      +0.2        0.61        perf-profile.children.cycles-pp.update_rq_clock_task
      0.04 ± 44%      +0.2        0.22        perf-profile.children.cycles-pp.finish_wait
      0.02 ±141%      +0.2        0.20        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.08 ±  6%      +0.2        0.27        perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.23 ±  2%      +0.2        0.42        perf-profile.children.cycles-pp.__fget_light
      0.07 ±  6%      +0.2        0.28        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.20 ±  2%      +0.2        0.41        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.94            +0.2        1.15        perf-profile.children.cycles-pp.wake_affine
      0.23 ±  3%      +0.2        0.45        perf-profile.children.cycles-pp.__fdget_pos
      0.06            +0.2        0.28 ±  2%  perf-profile.children.cycles-pp.newidle_balance
      0.09 ±  4%      +0.2        0.31        perf-profile.children.cycles-pp.ktime_get
      0.00            +0.2        0.23 ±  9%  perf-profile.children.cycles-pp.__mutex_lock
      0.16 ±  5%      +0.2        0.39        perf-profile.children.cycles-pp.mutex_lock
      0.06 ±  7%      +0.2        0.30        perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.11 ±  7%      +0.2        0.35        perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.56 ±  4%      +0.3        0.83 ±  2%  perf-profile.children.cycles-pp._copy_from_iter
      0.59 ±  3%      +0.3        0.88 ±  2%  perf-profile.children.cycles-pp.copy_page_from_iter
      0.12 ±  6%      +0.3        0.42 ±  2%  perf-profile.children.cycles-pp.mutex_unlock
      0.12 ±  4%      +0.3        0.44        perf-profile.children.cycles-pp.__entry_text_start
      0.09 ±  7%      +0.3        0.42        perf-profile.children.cycles-pp.os_xsave
      1.24            +0.3        1.57        perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.21 ±  3%      +0.3        0.56        perf-profile.children.cycles-pp.__update_load_avg_se
      0.08 ±  6%      +0.4        0.43        perf-profile.children.cycles-pp.__enqueue_entity
      0.94            +0.4        1.32        perf-profile.children.cycles-pp.update_curr
      0.28 ±  7%      +0.4        0.66        perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      2.37 ±  2%      +0.4        2.79        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.15 ±  3%      +0.4        0.58        perf-profile.children.cycles-pp.sched_clock
      0.17 ±  6%      +0.4        0.60        perf-profile.children.cycles-pp.___perf_sw_event
      2.19 ±  2%      +0.4        2.62        perf-profile.children.cycles-pp.switch_fpu_return
      0.23 ±  2%      +0.4        0.67        perf-profile.children.cycles-pp.update_rq_clock
      0.16 ±  4%      +0.4        0.61        perf-profile.children.cycles-pp.native_sched_clock
      0.30            +0.4        0.74        perf-profile.children.cycles-pp.call_function_single_prep_ipi
     26.92            +0.5       27.38        perf-profile.children.cycles-pp.pipe_write
      0.33 ±  5%      +0.5        0.78        perf-profile.children.cycles-pp.copyout
      1.53            +0.5        2.00        perf-profile.children.cycles-pp.finish_task_switch
      0.35 ±  5%      +0.5        0.83        perf-profile.children.cycles-pp._copy_to_iter
      0.18 ±  4%      +0.5        0.66        perf-profile.children.cycles-pp.reweight_entity
      0.26            +0.5        0.76        perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.38 ±  5%      +0.5        0.87        perf-profile.children.cycles-pp.copy_page_to_iter
      0.18 ±  3%      +0.5        0.72        perf-profile.children.cycles-pp.sched_clock_cpu
      0.65            +0.5        1.19        perf-profile.children.cycles-pp._find_next_bit
      0.62 ±  2%      +0.6        1.21        perf-profile.children.cycles-pp.remove_entity_load_avg
      0.70 ±  3%      +0.6        1.32        perf-profile.children.cycles-pp.menu_select
      2.44 ±  2%      +0.7        3.11        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.39            +0.7        1.10        perf-profile.children.cycles-pp.llist_reverse_order
     27.52            +0.7       28.25        perf-profile.children.cycles-pp.vfs_write
      1.41 ±  2%      +0.8        2.20        perf-profile.children.cycles-pp.migrate_task_rq_fair
      1.60 ±  2%      +0.8        2.39        perf-profile.children.cycles-pp.set_task_cpu
     27.69            +0.9       28.55        perf-profile.children.cycles-pp.ksys_write
      0.62            +0.9        1.52        perf-profile.children.cycles-pp.llist_add_batch
     27.52            +1.0       28.50        perf-profile.children.cycles-pp.pipe_read
      0.61            +1.0        1.63        perf-profile.children.cycles-pp.__switch_to_asm
      0.69 ±  2%      +1.0        1.72        perf-profile.children.cycles-pp.__switch_to
      0.64 ±  2%      +1.1        1.70        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.36 ±  5%      +1.1        1.42 ±  3%  perf-profile.children.cycles-pp.__bitmap_andnot
      0.66 ±  2%      +1.1        1.75        perf-profile.children.cycles-pp.prepare_task_switch
      0.96            +1.1        2.09        perf-profile.children.cycles-pp.prepare_to_wait_event
      0.38 ± 12%      +1.2        1.54        perf-profile.children.cycles-pp.__update_idle_core
      4.69            +1.2        5.87        perf-profile.children.cycles-pp.schedule_idle
      0.38 ± 13%      +1.2        1.56        perf-profile.children.cycles-pp.pick_next_task_idle
      1.03 ±  5%      +1.2        2.28        perf-profile.children.cycles-pp.stress_switch_pipe
     27.96            +1.3       29.22        perf-profile.children.cycles-pp.vfs_read
      0.64 ±  2%      +1.3        1.95        perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.95            +1.4        2.31        perf-profile.children.cycles-pp.__smp_call_single_queue
     28.11            +1.4       29.54        perf-profile.children.cycles-pp.ksys_read
      1.45            +1.6        3.10        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      1.29            +2.0        3.32        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     29.82            +2.8       32.66        perf-profile.children.cycles-pp.write
     58.39            +3.1       61.48        perf-profile.children.cycles-pp.do_syscall_64
     58.71            +3.2       61.92        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     30.42            +3.4       33.80        perf-profile.children.cycles-pp.read
      7.53            +3.6       11.15        perf-profile.children.cycles-pp.available_idle_cpu
      7.10            +3.8       10.91        perf-profile.children.cycles-pp.cpuidle_enter
      7.05            +3.8       10.88        perf-profile.children.cycles-pp.cpuidle_enter_state
      8.02            +4.8       12.81        perf-profile.children.cycles-pp.cpuidle_idle_call
      8.62            +5.1       13.76        perf-profile.children.cycles-pp.select_idle_core
      0.00            +5.2        5.20        perf-profile.children.cycles-pp.poll_idle
     10.20            +5.8       16.02        perf-profile.children.cycles-pp.select_idle_cpu
     24.24            +5.9       30.15        perf-profile.children.cycles-pp.try_to_wake_up
     24.26            +6.0       30.22        perf-profile.children.cycles-pp.autoremove_wake_function
     11.80            +6.6       18.41        perf-profile.children.cycles-pp.select_idle_sibling
     24.71            +6.7       31.41        perf-profile.children.cycles-pp.__wake_up_common
     25.12            +6.8       31.91        perf-profile.children.cycles-pp.__wake_up_common_lock
     12.91            +7.0       19.92        perf-profile.children.cycles-pp.select_task_rq_fair
     13.08            +7.0       20.13        perf-profile.children.cycles-pp.select_task_rq
     27.98           -26.6        1.33 ±  5%  perf-profile.self.cycles-pp.update_cfs_group
     15.77           -13.3        2.50        perf-profile.self.cycles-pp.update_load_avg
      4.28            -2.9        1.36        perf-profile.self.cycles-pp.try_to_wake_up
      2.24 ±  3%      -1.3        0.96        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      5.64            -1.0        4.67        perf-profile.self.cycles-pp.intel_idle
      0.24 ±  3%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.21 ±  4%      -0.1        0.10        perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.14 ±  8%      -0.1        0.06        perf-profile.self.cycles-pp.task_mm_cid_work
      0.23 ±  4%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.07 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.inode_needs_update_time
      0.06 ±  6%      +0.0        0.07        perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.13 ±  2%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.set_task_cpu
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.update_entity_lag
      0.08 ±  8%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.05 ±  7%      +0.0        0.10        perf-profile.self.cycles-pp.__get_task_ioprio
      0.05 ±  7%      +0.0        0.10        perf-profile.self.cycles-pp.resched_curr
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__smp_call_single_queue
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.copy_page_from_iter
      0.00            +0.1        0.05        perf-profile.self.cycles-pp._copy_to_iter
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.sched_clock
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.tick_nohz_idle_enter
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.ct_kernel_enter
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.rb_next
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.tick_nohz_idle_exit
      0.02 ± 99%      +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.aa_file_perm
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.perf_exclude_event
      0.32 ±  2%      +0.1        0.38 ±  2%  perf-profile.self.cycles-pp._copy_from_iter
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.rcu_note_context_switch
      0.20 ±  2%      +0.1        0.27        perf-profile.self.cycles-pp.perf_tp_event
      0.12 ±  4%      +0.1        0.19 ±  6%  perf-profile.self.cycles-pp.cpuacct_charge
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.mm_cid_get
      0.07 ±  5%      +0.1        0.14        perf-profile.self.cycles-pp.ttwu_do_activate
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.06            +0.1        0.13        perf-profile.self.cycles-pp.__entry_text_start
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.activate_task
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.__cond_resched
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.current_time
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.10 ±  8%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.05            +0.1        0.13        perf-profile.self.cycles-pp.place_entity
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.__x2apic_send_IPI_dest
      0.09 ±  5%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.15 ±  6%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.schedule
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.00            +0.1        0.09 ± 23%  perf-profile.self.cycles-pp.read@plt
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.ksys_read
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.ksys_write
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.ktime_get
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.01 ±223%      +0.1        0.10        perf-profile.self.cycles-pp.__wake_up_common_lock
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.cpu_startup_entry
      0.45 ±  2%      +0.1        0.55        perf-profile.self.cycles-pp.task_h_load
      0.12 ±  3%      +0.1        0.22        perf-profile.self.cycles-pp.attach_entity_load_avg
      0.00            +0.1        0.10        perf-profile.self.cycles-pp.check_preempt_curr
      0.00            +0.1        0.10        perf-profile.self.cycles-pp.__list_add_valid
      0.10 ±  4%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.avg_vruntime
      0.07 ±  5%      +0.1        0.17        perf-profile.self.cycles-pp.__calc_delta
      0.33            +0.1        0.44        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.10 ±  9%  perf-profile.self.cycles-pp.__mutex_lock
      0.00            +0.1        0.11        perf-profile.self.cycles-pp.set_next_entity
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.14 ±  3%      +0.1        0.25        perf-profile.self.cycles-pp.wake_affine
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.34 ±  3%      +0.1        0.46        perf-profile.self.cycles-pp.menu_select
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.security_file_permission
      0.05 ±  8%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.pick_eevdf
      0.00            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.1        0.14        perf-profile.self.cycles-pp.__dequeue_entity
      0.17 ±  2%      +0.1        0.32        perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.00            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.schedule_idle
      0.00            +0.1        0.15 ±  3%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.05            +0.2        0.20        perf-profile.self.cycles-pp.call_cpuidle
      0.06 ±  8%      +0.2        0.21        perf-profile.self.cycles-pp.read_tsc
      0.00            +0.2        0.16 ±  3%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.17 ±  4%      +0.2        0.32 ±  2%  perf-profile.self.cycles-pp.update_min_vruntime
      0.00            +0.2        0.16        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.08 ±  6%      +0.2        0.24        perf-profile.self.cycles-pp.cpuidle_enter_state
      0.13 ±  5%      +0.2        0.29 ±  2%  perf-profile.self.cycles-pp.mutex_lock
      0.00            +0.2        0.16 ±  2%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.27 ±  6%      +0.2        0.44 ±  3%  perf-profile.self.cycles-pp.copyin
      0.78 ±  3%      +0.2        0.95        perf-profile.self.cycles-pp.migrate_task_rq_fair
      0.08 ±  4%      +0.2        0.26        perf-profile.self.cycles-pp.pick_next_task_fair
      0.42            +0.2        0.60        perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.02 ±141%      +0.2        0.20        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.22 ±  2%      +0.2        0.41        perf-profile.self.cycles-pp.__fget_light
      0.08 ±  6%      +0.2        0.27 ±  2%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.07            +0.2        0.27        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.19 ±  2%      +0.2        0.40        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.36 ±  3%      +0.2        0.57        perf-profile.self.cycles-pp.update_rq_clock_task
      0.15 ±  3%      +0.2        0.36        perf-profile.self.cycles-pp.select_task_rq_fair
      0.40 ±  2%      +0.2        0.61        perf-profile.self.cycles-pp.remove_entity_load_avg
      0.29 ±  2%      +0.2        0.51        perf-profile.self.cycles-pp.vfs_read
      0.05 ±  8%      +0.2        0.27 ±  2%  perf-profile.self.cycles-pp.newidle_balance
      0.14 ±  3%      +0.2        0.36        perf-profile.self.cycles-pp.update_rq_clock
      0.28 ±  2%      +0.2        0.50        perf-profile.self.cycles-pp.vfs_write
      0.06 ±  7%      +0.2        0.29        perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.34 ±  2%      +0.2        0.58        perf-profile.self.cycles-pp.dequeue_entity
      0.26 ±  2%      +0.2        0.50        perf-profile.self.cycles-pp.prepare_to_wait_event
      0.25 ±  2%      +0.2        0.49 ±  2%  perf-profile.self.cycles-pp.pipe_write
      0.38            +0.2        0.63        perf-profile.self.cycles-pp.update_curr
      0.12 ±  6%      +0.3        0.41 ±  2%  perf-profile.self.cycles-pp.mutex_unlock
      2.12 ±  2%      +0.3        2.41        perf-profile.self.cycles-pp.select_idle_core
      0.19 ±  3%      +0.3        0.50        perf-profile.self.cycles-pp.__update_load_avg_se
      0.09 ±  7%      +0.3        0.41        perf-profile.self.cycles-pp.os_xsave
      1.24            +0.3        1.57        perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.14 ±  7%      +0.3        0.48        perf-profile.self.cycles-pp.___perf_sw_event
      0.07            +0.3        0.42        perf-profile.self.cycles-pp.__enqueue_entity
      0.09 ±  6%      +0.4        0.45        perf-profile.self.cycles-pp.do_idle
      0.44 ±  2%      +0.4        0.82        perf-profile.self.cycles-pp.switch_fpu_return
      0.23 ±  3%      +0.4        0.61        perf-profile.self.cycles-pp.sched_ttwu_pending
      0.21 ±  2%      +0.4        0.61        perf-profile.self.cycles-pp.enqueue_task_fair
      0.14 ±  3%      +0.4        0.54        perf-profile.self.cycles-pp.reweight_entity
      0.16 ±  4%      +0.4        0.58        perf-profile.self.cycles-pp.native_sched_clock
      0.29 ±  2%      +0.4        0.72        perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.30 ±  2%      +0.4        0.74        perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.37            +0.4        0.81        perf-profile.self.cycles-pp.dequeue_task_fair
      0.32 ±  6%      +0.4        0.77        perf-profile.self.cycles-pp.copyout
      0.13 ±  5%      +0.5        0.59        perf-profile.self.cycles-pp.nohz_run_idle_balance
      0.60            +0.5        1.06        perf-profile.self.cycles-pp._find_next_bit
      0.61            +0.5        1.12        perf-profile.self.cycles-pp.finish_task_switch
      0.37 ±  6%      +0.5        0.88        perf-profile.self.cycles-pp.write
      0.40 ±  7%      +0.5        0.93 ±  2%  perf-profile.self.cycles-pp.read
      0.33 ±  2%      +0.6        0.93        perf-profile.self.cycles-pp.enqueue_entity
      0.61            +0.7        1.28        perf-profile.self.cycles-pp.select_idle_cpu
      0.69 ±  2%      +0.7        1.37        perf-profile.self.cycles-pp.select_idle_sibling
      0.38 ±  2%      +0.7        1.10        perf-profile.self.cycles-pp.llist_reverse_order
      0.59 ±  8%      +0.7        1.31 ±  2%  perf-profile.self.cycles-pp.stress_switch_pipe
      0.44            +0.7        1.18        perf-profile.self.cycles-pp.__wake_up_common
      0.58            +0.8        1.33        perf-profile.self.cycles-pp.pipe_read
      0.58 ±  2%      +0.8        1.40        perf-profile.self.cycles-pp.prepare_task_switch
      0.62            +0.9        1.51        perf-profile.self.cycles-pp.llist_add_batch
      0.68 ±  2%      +1.0        1.68        perf-profile.self.cycles-pp.__switch_to
      0.61            +1.0        1.63        perf-profile.self.cycles-pp.__switch_to_asm
      0.63 ±  2%      +1.0        1.65        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.34 ±  4%      +1.0        1.37 ±  3%  perf-profile.self.cycles-pp.__bitmap_andnot
      0.30 ± 17%      +1.0        1.32        perf-profile.self.cycles-pp.__update_idle_core
      0.64 ±  2%      +1.3        1.92        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.88 ±  2%      +1.3        2.22        perf-profile.self.cycles-pp._raw_spin_lock
      1.70            +1.6        3.28        perf-profile.self.cycles-pp.__schedule
      1.28            +2.0        3.28        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      7.50            +3.6       11.06        perf-profile.self.cycles-pp.available_idle_cpu
      0.00            +4.8        4.81        perf-profile.self.cycles-pp.poll_idle





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

