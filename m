Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7707FCCE2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjK2Ca0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2CaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:30:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25EB1707
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701225029; x=1732761029;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Czc0mUxl7y72ovICPLYSjd0EpHFnTCzZWL+dEsnL11Q=;
  b=IE1dg7rkl5xB2LYMjrp48Y+nGm0V2ZbfYR0IEomndRpsF2hjIuoge7mr
   28AP3Qdkzwi0SXaSfuHdIVI3TkL5LG1f1EC8YDUTmB04FC3woeeDvXckl
   rI+Hr2+wCxHQ3pFoS09owcXhzrytue+W5kBa+OZlcliW3jFLFAWqqnQ/z
   u3+ncEKobRHYO8aQWyGlsJSQEmj0G/EXJrGDdVonx8czELp5OXhb/uU3R
   /5j62LPkSih9tlsTwyYT9YDO3YTnjH5V14bjArHVSL/ydWks3DECxfa1D
   EUM7i9wvtjD/7LVltvOyJJXsqUVqY1mEw5bp1bS46NKiDs1bzxYPAlhhR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6342086"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="6342086"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 18:30:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="772518256"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="772518256"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 18:30:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 18:30:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 18:30:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 18:30:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 18:30:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuZAdjJs5XKGS4fHVdJzjuf4btcwaQ9Y6I1hTmH+DuD6A0nNZaf/iUejxmQdw/+a6nTR+DTxgbgzELrEVUhgexOonoLLZ2wNZqOpuoEwiMFHYExP0LY8Z0sIqxGzLwJa/RFH8w9ZQ8kAkSz5+J5KWXboE7DemHK2KykV4YlSIwTzOVP6yd4GUF1asEy5S2FPkgWk9rK039IvNEcNxE2m9sYiZ1l5mKDeMLs60WL5x5g5YqbTilNjtcl0QEtnlT9rmrQCpvDiSm8LQ5/m7PdXg9YLGXv1EPpE1/g4xqR+FmZURLAK97Qtz7jeh3cq6wrn0rAGPmqemKfB/fYfVQB8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqiKocHJoYrDJlAI6WlZ359PA88aTmEhkpfCilmZ1IQ=;
 b=jXXFpWBycSRUMTJiv5OgWVC4RJZliCzJLOLuTMrz9+fYrLef9+weyf4y4k//gLF/gxqzVvf9dgbySDJuiMEu6GZVRIIC7rI5H7p0BGo59YcN7NJKgsgggcvgGZl9QyUAvU9Vpa4iI7zwiUMzLBgQ2ZKJOjDSLSNtbHTnNgo10ZB2ZtWXJlvd+IlozbY8t8DsrusongKI93YBRC6IFGj5qqCYquH/jQ8p3sBglEWJiJxI6f9bUhbLUxE7jtvwOKiPTKgpT7wiSS1EiCU8qlpT00WXAR+I6mPgWSCzwvvdXiZ2AZXzGXuom0mZtl9ODfF3sBMnt51+YxWkNkV13Bc0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CY8PR11MB7194.namprd11.prod.outlook.com (2603:10b6:930:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 02:30:25 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 02:30:23 +0000
Date:   Wed, 29 Nov 2023 10:24:31 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <elver@google.com>
CC:     <linux-perf-users@archiver.kernel.org>, <heng.su@intel.com>,
        <lkp@intel.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Syzkaller & bisect] There is task hung in perf_tp_event_init in
 v6.7-rc3 mainline kernel
Message-ID: <ZWag32wsESemVfuN@xpf.sh.intel.com>
References: <ZWaeVaNEA/0Oavv8@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZWaeVaNEA/0Oavv8@xpf.sh.intel.com>
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CY8PR11MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0e4944-e6c6-4e7b-e7e7-08dbf08323b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgQtTqElTAaxHwvD81E6uihtbntKvo+vKe4BnJDdn/KjICdcMZgt8L6jIYz7EHLcLyBiudbsuw7OK+54CDaNWbd0ZWedQYI5uvfy0E4Kyx1kIE65YwvHrCVjwP8upsn0zoun8ubbkqgvulfWZ/rx7oac8601yEbfHtj/fkbZk91yhEhmbpCJ1MnGOD71ZoCMaqczB4Y9dXglhInah69CwfZ24xuEifNjglOC1yucarncyv4grdGCaUpJWkuwF0MnPUTZsr6HC1WPonZhlKQP9ht3fRn7DqP9sV8Aku6EAJuwPVPDMCutPHKtl9NzGgDcshdP+lOYbA7EYwFVx7w1k/W60nKMU0hvMZAnbT021Rsf+izP9ilhHzrimdFXL2iH4nor+n+rJxPAs1ZWW/gsCXRA6fl427I14jyTbixL1HlAEN1a7gON7jc4qSYOU15089sHG9Ho88CYnRUSmHRe1GgLbp3uMTBuEu88LnTv8n38NMqa10wgX2v2CQ/L/8K9UBNhiDeWv+/RochcZPAvGFm/zIHQaNUwswGQS2iioGq7KhrELrAr90bWPPDAVegVh6UfN+8fxD7ukx3cqkX4fNzqoBws0t2vC+1GUBeBxXQmL68NxUHycmVU6xaICAqE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(41300700001)(4001150100001)(86362001)(30864003)(83380400001)(5660300002)(82960400001)(2906002)(26005)(44832011)(66476007)(6512007)(53546011)(6506007)(6666004)(8936002)(8676002)(4326008)(966005)(6486002)(478600001)(316002)(66946007)(6916009)(66556008)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bUihaub6T6hDe90Gu/6NuqjUETUwVpAP3Yt39kGtiqYtcVZMEnxwTW8N76qU?=
 =?us-ascii?Q?kd3b8pWcIe9nRhrrQScct4vl4WLGvXSnR7dWvyV0LKECRpIVk9ytxDQjykS5?=
 =?us-ascii?Q?DTxdCYjUnpRx73cQM5/jTfuyHPh2IzsLdc5j0G15SgSU7E+0ZPgSKntq8pub?=
 =?us-ascii?Q?PZPp80+AzkluFPbnCJ9Lmw/N0DQhMCmJ07vQ7b9F0DMXqkh5EuHq7zYfMMYZ?=
 =?us-ascii?Q?yvqRUEN7jiuY/l7TsTzA3Zlc4rs+qGfW2zJ2TwN/Z8AhZ6Ks9kZzY2t2LgKK?=
 =?us-ascii?Q?aSk1pGk+ktnfKIsm88v5bS0/ZX0BZIaUQYs3CLj9b+q9gOn4MNWj+7CUbB9P?=
 =?us-ascii?Q?3tECjGliu04XBQNj5EjQFwe+3xa7nTU4qb/L4oRWO5XDFaE+w95YFHWGdxU2?=
 =?us-ascii?Q?hs+RoIaKUXadRQv+De6k9EEAdcCG9zIFPuXZqLvld6B4DmXvyeTDKiG2AinF?=
 =?us-ascii?Q?7EikIBhTwXhsNZh9F0IeMwDhdJDk3B9KXS5dSmh6gewEF05YpkjnCTv1ZNgc?=
 =?us-ascii?Q?lfuRUO/BS/vPvjxYYCHDp0cmlo93uVXiiqTPezpFgjTg8FGEj+sQ4oYcbMAa?=
 =?us-ascii?Q?8u/l/phKgbsj6l0JQyxalQG48t/h4GOImSDp5hgGp6RTeTyjna1hLKPRavau?=
 =?us-ascii?Q?f8RplyWHhdqIkttg3vu0YTM44qgJJmBcnDkNpWt7bSkqcSsNafTSXBKEgaoP?=
 =?us-ascii?Q?TyaMHeJDFnxVVdR5ZBkO3rToGpxfAdBKoluj0KTYRDtkwwt/EKjJ98bIo30a?=
 =?us-ascii?Q?wuZUWUrmzdg+Ahb07wvVfFfex+ATQoutIF3nEPqEpttMkHw+/Tykm4XgLAi2?=
 =?us-ascii?Q?PayYnkSO3UqcIfmzC832OVnj6wZe2EFlijCDBdYjmvxLHy+ijBKVlHNVfHKm?=
 =?us-ascii?Q?+t29glLm8V4EL/HNOCxA6CUTbW91/dZ4NndqOrq+boQzacY6tkhxusdy470Y?=
 =?us-ascii?Q?GljLiXYvAMEIht3PaihE+RIRG92yDS2WW0gk6VHwivOMIwABBrwfKf/37sbW?=
 =?us-ascii?Q?zyPJPTGCKEKEIR6bR/g1cUqcLxglANwmY99FZP388MOEMCb1S07CXpkl7RCW?=
 =?us-ascii?Q?l+jwkpuFAaaJHqp8ANjOAv++dC0OfXlOKyvt+XlKFu26OzI/mlRGR7vKpdJ4?=
 =?us-ascii?Q?ece48LHibg1jcRgrpzJ+uHgt3g3A9LpvGam4+/zS8Dz4F02VWYh7E0i7iVv1?=
 =?us-ascii?Q?1Q/LpBGcHorjes6EKMOO85PiTlrzwkRvuNWTW4EHc7mXnMetqGoSTtzq9j+N?=
 =?us-ascii?Q?Q/MNS9/i+8f9hzxEmHOi1rwJ1yQuRDLIH4j2OmYFmg1VtJnydISN76UhAn8c?=
 =?us-ascii?Q?SSL9/bImi5vJOAcH2jVMDiYqAW1/GxXU5qmIa/kEqLDVuNaVDJ4NIUnJ5k+h?=
 =?us-ascii?Q?2BxTSYBvPvYvOdYTFBYRzWrbmcE9g+TXj+m59azAEzy3bDf4o8ef5NqQcLg/?=
 =?us-ascii?Q?pKQY4TymUM1O6yA/fIPoW6ht0q1UKKllDzeF8woVZebjC9nVX4fItCHFiqjT?=
 =?us-ascii?Q?WsI5LrCfAIc/tudVhFqBon6wuNDgnlUMogjicET8i4Rn73RB8Eq5nD73KyIM?=
 =?us-ascii?Q?LjkYNFTVoRAe+wP9dT0v8YFwH33thoWERxe82H+V?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0e4944-e6c6-4e7b-e7e7-08dbf08323b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 02:30:23.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lye5BtXINIGRbQsk/E/y5Do/Hi8GYjj4MmFyyS0gTRuaE0kuEz2avdB7Qv+eYp2Cln98HD40c9sgX0KTVAYdYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7194
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-29 at 10:13:41 +0800, Pengfei Xu wrote:
> Hi Marco Elver and perf expert,
> 
> Greeting!
> 
> There is task hung in perf_tp_event_init in v6.7-rc3 mainline kernel in vm.
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/231128_081400_perf_tp_event_init
> Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/231128_081400_perf_tp_event_init/repro.c
> Syzkaller repro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/231128_081400_perf_tp_event_init/repro.report
> Syzkaller syscall reproduced step: https://github.com/xupengfe/syzkaller_logs/blob/main/231128_081400_perf_tp_event_init/repro.prog
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/231128_081400_perf_tp_event_init/bisect_info.log
> Kconfig(Needs make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/231128_081400_perf_tp_event_init/kconfig_origin
> v6.7-rc3 dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/231128_081400_perf_tp_event_init/2cc14f52aeb78ce3f29677c2de1f06c0e91471ab_dmesg.log
> v6.7-rc3 bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/231128_081400_perf_tp_event_init/bzImage_2cc14f52aeb78ce3f29677c2de1f06c0e91471ab.tar.gz
> This issue could be reproduced in 3330s.
> 
> Bisected the suspected commit is:
> "
> 97ba62b27867 perf: Add support for SIGTRAP on perf events
> "
> 
> [  316.705302] EXT4-fs (sda): error count since last fsck: 8
> [  316.706021] EXT4-fs (sda): initial error at time 1699515630: ext4_mb_release_inode_pa:5364
> [  316.706810] EXT4-fs (sda): last error at time 1699515808: mb_free_blocks:1917: block 1286144
> [ 1537.313213] INFO: task repro:960 blocked for more than 143 seconds.
> [ 1537.313584]       Not tainted 6.7.0-rc3-2cc14f52aeb7+ #1
> [ 1537.313871] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1537.314256] task:repro           state:D stack:0     pid:960   tgid:960   ppid:743    flags:0x00000006
> [ 1537.314730] Call Trace:
> [ 1537.314878]  <TASK>
> [ 1537.315037]  __schedule+0xb68/0x3030
> [ 1537.315324]  ? __pfx___schedule+0x10/0x10
> [ 1537.315546]  ? lock_release+0x417/0x7e0
> [ 1537.315792]  ? __pfx_lock_release+0x10/0x10
> [ 1537.316061]  ? preempt_count_add+0x9/0x180
> [ 1537.316334]  schedule+0xf8/0x310
> [ 1537.316544]  schedule_preempt_disabled+0x1c/0x30
> [ 1537.316800]  __mutex_lock+0xd8a/0x1a40
> [ 1537.317111]  ? perf_trace_init+0x5c/0x310
> [ 1537.317344]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> [ 1537.317650]  ? __pfx___mutex_lock+0x10/0x10
> [ 1537.317880]  ? ftrace_call+0x5/0x44
> [ 1537.318087]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> [ 1537.318348]  ? perf_try_init_event+0x13d/0x5b0
> [ 1537.318646]  ? __mutex_lock+0x5/0x1a40
> [ 1537.318894]  mutex_lock_nested+0x1f/0x30
> [ 1537.319108]  ? mutex_lock_nested+0x1f/0x30
> [ 1537.319338]  perf_trace_init+0x5c/0x310
> [ 1537.319583]  perf_tp_event_init+0xaf/0x130
> [ 1537.319818]  perf_try_init_event+0x13d/0x5b0
> [ 1537.320084]  perf_event_alloc.part.0+0xf8f/0x3b10
> [ 1537.320401]  ? perf_event_alloc.part.0+0xe73/0x3b10
> [ 1537.320693]  __do_sys_perf_event_open+0x51a/0x2c60
> [ 1537.320956]  ? lock_release+0x417/0x7e0
> [ 1537.321259]  ? __pfx___do_sys_perf_event_open+0x10/0x10
> [ 1537.321646]  ? __audit_syscall_entry+0x39e/0x500
> [ 1537.321907]  ? __pfx___x64_sys_perf_event_open+0x10/0x10
> [ 1537.322181]  ? ktime_get_coarse_real_ts64+0xb5/0xf0
> [ 1537.322479]  __x64_sys_perf_event_open+0xc7/0x150
> [ 1537.322733]  ? __x64_sys_perf_event_open+0x9/0x150
> [ 1537.322990]  ? do_syscall_64+0x42/0xf0
> [ 1537.323204]  do_syscall_64+0x42/0xf0
> [ 1537.323414]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [ 1537.323680] RIP: 0033:0x7efdcb23ee5d
> [ 1537.323881] RSP: 002b:00007fffa75a2f38 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> [ 1537.324264] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efdcb23ee5d
> [ 1537.324613] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000580
> [ 1537.324961] RBP: 00007fffa75a3140 R08: 0000000000000000 R09: 0000000000000003
> [ 1537.325341] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffa75a32d8
> [ 1537.325689] R13: 000000000040672d R14: 0000000000408e08 R15: 00007efdcb460000
> [ 1537.326136]  </TASK>
> [ 1537.326266] INFO: task repro:961 blocked for more than 143 seconds.
> [ 1537.326576]       Not tainted 6.7.0-rc3-2cc14f52aeb7+ #1
> [ 1537.326842] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1537.327217] task:repro           state:D stack:0     pid:961   tgid:961   ppid:742    flags:0x00004006
> [ 1537.327680] Call Trace:
> [ 1537.327822]  <TASK>
> [ 1537.327976]  __schedule+0xb68/0x3030
> [ 1537.328231]  ? __pfx___schedule+0x10/0x10
> [ 1537.328446]  ? lock_release+0x417/0x7e0
> [ 1537.328685]  ? __pfx_lock_release+0x10/0x10
> [ 1537.328949]  ? preempt_count_add+0x9/0x180
> [ 1537.329245]  schedule+0xf8/0x310
> [ 1537.329452]  schedule_preempt_disabled+0x1c/0x30
> [ 1537.329702]  __mutex_lock+0xd8a/0x1a40
> [ 1537.329932]  ? perf_trace_init+0x5c/0x310
> [ 1537.330156]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> [ 1537.330455]  ? __pfx___mutex_lock+0x10/0x10
> [ 1537.330684]  ? ftrace_call+0x5/0x44
> [ 1537.330889]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> [ 1537.331150]  ? perf_try_init_event+0x13d/0x5b0
> [ 1537.331450]  ? __mutex_lock+0x5/0x1a40
> [ 1537.331698]  mutex_lock_nested+0x1f/0x30
> [ 1537.331912]  ? mutex_lock_nested+0x1f/0x30
> [ 1537.332138]  perf_trace_init+0x5c/0x310
> [ 1537.332384]  perf_tp_event_init+0xaf/0x130
> [ 1537.332617]  perf_try_init_event+0x13d/0x5b0
> [ 1537.332883]  perf_event_alloc.part.0+0xf8f/0x3b10
> [ 1537.333231]  ? perf_event_alloc.part.0+0xe73/0x3b10
> [ 1537.333523]  __do_sys_perf_event_open+0x51a/0x2c60
> [ 1537.333785]  ? lock_release+0x417/0x7e0
> [ 1537.334056]  ? __pfx___do_sys_perf_event_open+0x10/0x10
> [ 1537.334444]  ? __audit_syscall_entry+0x39e/0x500
> [ 1537.334703]  ? __pfx___x64_sys_perf_event_open+0x10/0x10
> [ 1537.334979]  ? ktime_get_coarse_real_ts64+0xb5/0xf0
> [ 1537.335278]  __x64_sys_perf_event_open+0xc7/0x150
> [ 1537.335533]  ? __x64_sys_perf_event_open+0x9/0x150
> [ 1537.335791]  ? do_syscall_64+0x42/0xf0
> [ 1537.336005]  do_syscall_64+0x42/0xf0
> [ 1537.336213]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [ 1537.336477] RIP: 0033:0x7efdcb23ee5d
> [ 1537.336677] RSP: 002b:00007fffa75a2f38 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> [ 1537.337091] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efdcb23ee5d
> [ 1537.337439] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000580
> [ 1537.337788] RBP: 00007fffa75a3140 R08: 0000000000000000 R09: 0000000000000003
> [ 1537.338136] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffa75a32d8
> [ 1537.338484] R13: 000000000040672d R14: 0000000000408e08 R15: 00007efdcb460000
> [ 1537.338932]  </TASK>
> [ 1537.339062] INFO: task repro:962 blocked for more than 143 seconds.
> [ 1537.339377]       Not tainted 6.7.0-rc3-2cc14f52aeb7+ #1
> [ 1537.339644] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1537.340019] task:repro           state:D stack:0     pid:962   tgid:962   ppid:734    flags:0x00000006
> [ 1537.340481] Call Trace:
> [ 1537.340622]  <TASK>
> [ 1537.340777]  __schedule+0xb68/0x3030
> [ 1537.341063]  ? __pfx___schedule+0x10/0x10
> [ 1537.341280]  ? lock_release+0x417/0x7e0
> [ 1537.341519]  ? __pfx_lock_release+0x10/0x10
> [ 1537.341783]  ? preempt_count_add+0x9/0x180
> [ 1537.342048]  schedule+0xf8/0x310
> [ 1537.342256]  schedule_preempt_disabled+0x1c/0x30
> [ 1537.342507]  __mutex_lock+0xd8a/0x1a40
> [ 1537.342738]  ? perf_trace_init+0x5c/0x310
> [ 1537.342962]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> [ 1537.343264]  ? __pfx___mutex_lock+0x10/0x10
> [ 1537.343494]  ? ftrace_call+0x5/0x44
> [ 1537.343699]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> [ 1537.343961]  ? perf_try_init_event+0x13d/0x5b0
> [ 1537.344258]  ? __mutex_lock+0x5/0x1a40
> [ 1537.344507]  mutex_lock_nested+0x1f/0x30
> [ 1537.344722]  ? mutex_lock_nested+0x1f/0x30
> [ 1537.344948]  perf_trace_init+0x5c/0x310
> [ 1537.345236]  perf_tp_event_init+0xaf/0x130
> [ 1537.345470]  perf_try_init_event+0x13d/0x5b0
> [ 1537.345736]  perf_event_alloc.part.0+0xf8f/0x3b10
> [ 1537.346054]  ? perf_event_alloc.part.0+0xe73/0x3b10
> [ 1537.346346]  __do_sys_perf_event_open+0x51a/0x2c60
> [ 1537.346609]  ? lock_release+0x417/0x7e0
> [ 1537.346881]  ? __pfx___do_sys_perf_event_open+0x10/0x10
> [ 1537.347280]  ? __audit_syscall_entry+0x39e/0x500
> [ 1537.347543]  ? __pfx___x64_sys_perf_event_open+0x10/0x10
> [ 1537.347818]  ? ktime_get_coarse_real_ts64+0xb5/0xf0
> [ 1537.348116]  __x64_sys_perf_event_open+0xc7/0x150
> [ 1537.348371]  ? __x64_sys_perf_event_open+0x9/0x150
> [ 1537.348629]  ? do_syscall_64+0x42/0xf0
> [ 1537.348843]  do_syscall_64+0x42/0xf0
> [ 1537.349082]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [ 1537.349346] RIP: 0033:0x7efdcb23ee5d
> [ 1537.349546] RSP: 002b:00007fffa75a2f38 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> [ 1537.349928] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efdcb23ee5d
> [ 1537.350277] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000580
> [ 1537.350625] RBP: 00007fffa75a3140 R08: 0000000000000000 R09: 0000000000000003
> [ 1537.350974] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffa75a32d8
> [ 1537.351325] R13: 000000000040672d R14: 0000000000408e08 R15: 00007efdcb460000
> [ 1537.351773]  </TASK>
> [ 1537.351903] INFO: task repro:963 blocked for more than 143 seconds.
> [ 1537.352212]       Not tainted 6.7.0-rc3-2cc14f52aeb7+ #1
> [ 1537.352478] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1537.352853] task:repro           state:D stack:0     pid:963   tgid:963   ppid:741    flags:0x00004006
> [ 1537.353349] Call Trace:
> [ 1537.353492]  <TASK>
> [ 1537.353646]  __schedule+0xb68/0x3030
> [ 1537.353900]  ? __pfx___schedule+0x10/0x10
> [ 1537.354115]  ? lock_release+0x417/0x7e0
> [ 1537.354355]  ? __pfx_lock_release+0x10/0x10
> [ 1537.354618]  ? preempt_count_add+0x9/0x180
> [ 1537.354884]  schedule+0xf8/0x310
> [ 1537.355090]  schedule_preempt_disabled+0x1c/0x30
> [ 1537.355343]  __mutex_lock+0xd8a/0x1a40
> [ 1537.355574]  ? perf_trace_init+0x5c/0x310
> [ 1537.355798]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> [ 1537.356096]  ? __pfx___mutex_lock+0x10/0x10
> [ 1537.356326]  ? ftrace_call+0x5/0x44
> [ 1537.356531]  ? arch_ftrace_ops_list_func+0x1ad/0x550
> [ 1537.356792]  ? perf_try_init_event+0x13d/0x5b0
> [ 1537.357116]  ? __mutex_lock+0x5/0x1a40
> [ 1537.357365]  mutex_lock_nested+0x1f/0x30
> [ 1537.357580]  ? mutex_lock_nested+0x1f/0x30
> [ 1537.357805]  perf_trace_init+0x5c/0x310
> [ 1537.358051]  perf_tp_event_init+0xaf/0x130
> [ 1537.358285]  perf_try_init_event+0x13d/0x5b0
> [ 1537.358551]  perf_event_alloc.part.0+0xf8f/0x3b10
> [ 1537.358870]  ? perf_event_alloc.part.0+0xe73/0x3b10
> [ 1537.359162]  __do_sys_perf_event_open+0x51a/0x2c60
> [ 1537.359428]  ? lock_release+0x417/0x7e0
> [ 1537.359700]  ? __pfx___do_sys_perf_event_open+0x10/0x10
> [ 1537.360089]  ? __audit_syscall_entry+0x39e/0x500
> [ 1537.360348]  ? __pfx___x64_sys_perf_event_open+0x10/0x10
> [ 1537.360624]  ? ktime_get_coarse_real_ts64+0xb5/0xf0
> [ 1537.360921]  __x64_sys_perf_event_open+0xc7/0x150
> [ 1537.361207]  ? __x64_sys_perf_event_open+0x9/0x150
> [ 1537.361466]  ? do_syscall_64+0x42/0xf0
> [ 1537.361680]  do_syscall_64+0x42/0xf0
> [ 1537.361888]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [ 1537.362152] RIP: 0033:0x7efdcb23ee5d
> [ 1537.362352] RSP: 002b:00007fffa75a2f38 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> [ 1537.362734] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efdcb23ee5d
> [ 1537.363083] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000580
> [ 1537.363434] RBP: 00007fffa75a3140 R08: 0000000000000000 R09: 0000000000000003
> [ 1537.363782] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffa75a32d8
> [ 1537.364130] R13: 000000000040672d R14: 0000000000408e08 R15: 00007efdcb460000
> [ 1537.364577]  </TASK>
> [ 1537.364708] 
> [ 1537.364708] Showing all locks held in the system:
> [ 1537.365016] 1 lock held by khungtaskd/31:
> [ 1537.365259]  #0: ffffffff86c5b6e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x71/0x370
> [ 1537.365780] 1 lock held by repro/958:
> [ 1537.365976]  #0: ffffffff86d7ff08 (event_mutex){+.+.}-{3:3}, at: perf_trace_destroy+0x2c/0x1d0
> [ 1537.366470] 5 locks held by repro/959:
> [ 1537.366670] 2 locks held by repro/960:
> [ 1537.366868]  #0: ffffffff8926f830 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc.part.0+0xd1d/0x3b10
> [ 1537.367383]  #1: ffffffff86d7ff08 (event_mutex){+.+.}-{3:3}, at: perf_trace_init+0x5c/0x310
> [ 1537.367863] 2 locks held by repro/961:
> [ 1537.368066]  #0: ffffffff8926f830 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc.part.0+0xd1d/0x3b10
> [ 1537.368578]  #1: ffffffff86d7ff08 (event_mutex){+.+.}-{3:3}, at: perf_trace_init+0x5c/0x310
> [ 1537.369091] 2 locks held by repro/962:
> [ 1537.369290]  #0: ffffffff8926f830 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc.part.0+0xd1d/0x3b10
> [ 1537.369802]  #1: ffffffff86d7ff08 (event_mutex){+.+.}-{3:3}, at: perf_trace_init+0x5c/0x310
> [ 1537.370283] 2 locks held by repro/963:
> [ 1537.370481]  #0: ffffffff8926f830 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc.part.0+0xd1d/0x3b10
> [ 1537.370993]  #1: ffffffff86d7ff08 (event_mutex){+.+.}-{3:3}, at: perf_trace_init+0x5c/0x310
> [ 1537.371478] 2 locks held by repro/964:
> [ 1537.371677]  #0: ffffffff8926f830 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc.part.0+0xd1d/0x3b10
> [ 1537.372188]  #1: ffffffff86d7ff08 (event_mutex){+.+.}-{3:3}, at: perf_trace_init+0x5c/0x310
> [ 1537.372669] 2 locks held by repro/965:
> [ 1537.372867]  #0: ffffffff8926f830 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc.part.0+0xd1d/0x3b10
> [ 1537.373424]  #1: ffffffff86d7ff08 (event_mutex){+.+.}-{3:3}, at: perf_trace_init+0x5c/0x310
> [ 1537.373904] 
> [ 1537.374003] =============================================
> 
> ---
> 
> If you don't need the following environment to reproduce the problem or if you
> already have one reproduced environment, please ignore the following information.
> 
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
> 
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
> 
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
> 
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
> 
> 
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
> 
> Best Regards,
> Thanks!
