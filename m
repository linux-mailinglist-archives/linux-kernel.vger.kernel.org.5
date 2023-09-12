Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103B279C6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjILGZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjILGZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:25:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2423FAF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694499912; x=1726035912;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A9xSHEq1Jl2MkCkcEo6Xq+nqRTcINckF1fZKyzpbizQ=;
  b=Q0BZdUhpY32Kt0y3R4rnR5izSebRU/StHw1NjkLDdTDlnq5HFllHJtgZ
   0h48l388Ltk+MMQ2yUwc7MaFiQJ9gyjHcXW9m0HidSR3/DBdqYhEu/qXG
   BzaB50pXioKVE1X3UBW7h3Q9kIj1+wkayb2hBVz9hWGkBMtOq2vWBUK0H
   +bRYNpbipAQkSsRmzhkETulDtnE89AAM6QPnAMa86t3+qpmsd7VlXrEvW
   bb5L/um5wtkmoPBOTHvS1pHmFr3fSdzhK9XKzPPRP3Pxn9m9r1vKOQKcv
   KVj94DRusdfaupI/rlIAENUH3E8tkVcNhRpYPhZMtF3o0qgE19OBTjqZn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="363320396"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="363320396"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 23:25:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858663317"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="858663317"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 23:25:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 23:25:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 23:25:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 23:25:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 23:25:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aq1LokpfSxGQKlDTaIx1mD8LdEsY7WTo5p2B2/jv+QiyDVJ/1hJXvppjCIwyVXaH2Hru+CiHNL/54Nnx8ffjRYrQAGFhe3eYWmI4xfNT9oaUUBjx1n83iFuEddGXaZ88hw2ZuQBYDmP6+wGQuu1lV/E74DYjWet0yJpkwhadrOTR7e81k8wjtb8TTUTIGzmo+CTVaGL+S6DY/tPid/MK9rtRdCod11E6WuKJg33Zv2xvrLBC6pZv3bal6FAFthwMtduJ4oLBpcet9AqnYOBGJD93mnCQ22KuZ2w1YwgZt1s1KD77T5fZKURfu3817V7g7f64IqoapP8RcGIrvbGXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21W4kuhsY7xXungIZKM38UIQW/VI3TZaAuSAWH0RUKg=;
 b=HsrMsMjQEfA3EiS07bGcgyHU/HCAlUjztiOVw6Hxct8uKXWe0XmNwb7lijmCwUczjbdmpuQqgYgO8+A7+SMsthycNGQwfItXIA0MD9XoMzLYaj8wPafh8qi5A+RtBefiZJQbbLPCIj8CzSwtCywTn1Dvxc6VtQCwsL6ey0O1sr6meFNRVUZKxWIyjJdM+n77cIZQk9YuYgaHhvnzgohghM2YUrzXaY6JUBuJGpCzV4yWBLM/hmPvWTmsXQxkIIc8MvrAjPbUa+f+5lKenj11E7N4Yw0i37/X7+lh9b5qTkyWNOBF3l7QpZt7Ihv+xSoTtyl1LI2fP7Ui218hCNkbJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH0PR11MB5829.namprd11.prod.outlook.com (2603:10b6:510:140::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 06:25:08 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::cb79:a11e:ef:af6c]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::cb79:a11e:ef:af6c%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 06:25:08 +0000
Date:   Tue, 12 Sep 2023 14:19:42 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <tj@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <heng.su@intel.com>,
        <pengfei.xu@intel.com>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is BUG: MAX_LOCKDEP_KEYS too low in
 v6.6-rc1
Message-ID: <ZQAC/ofkIimvezUY@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0081.apcprd02.prod.outlook.com
 (2603:1096:4:90::21) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH0PR11MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: c251d099-1efb-4ea7-9339-08dbb35902fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKO56E/m0BCWXOahwF8ijQmJIUNrSvxIfn3owIwWIyFGwi10JCdb2squEGFo5L1EpJg8B1obfwcfTnSvLCZKCSDGI0ZfjsQapH+5zfp/GnxQ75be5+IaJ/O/3ByM/32efh3cEsELG0rDwQGt9jbzvLQUNp/JmP6I/DEgGnoL3nFG5IXwO3rGGgyi8v9yy2TmAHYTyxtL2PEBCXEEy1Bl9PktHzTkhvJyPb3nKHeWhX5hnntljRkuIy4Hq2aEMj8hyuQk3xIXDFWUrFBFO84VYQO0Y/5Go6xOj17mzHHuheoZu0CSvKsR8WBkmf/quIWCX7WDSpROLSEZPKWu3MiNojbGjmmMezjMTxL/nj06qil9hpBkJt8cjc9VmuZD5ykaYzFHYg/k3hkP2ivdQTqHK7J7hTVKeeHgQ7rGOV1f2vDIUhMf7rnI0rhM7AI6QPpxKwyR53nBic0tM1RWiAdKvK5ww1Ji8GG7DqV8p5MzSYwHb6y5y6w2KhHYPrlel4m9Ful9LQR14P7W3mDuO2KZ2BtFrPXq/u5t9S2d3xODkwXqCU+227KT69o/aH8jDtWOTWjU3lQzYGdZQ20AtKr6hp2JcbubmgUEjU4D0t7sFyM2qQW+IrBVyGvDpsD0zrORtD0sbBktHJCKEx9WCOkj2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(186009)(451199024)(1800799009)(2906002)(107886003)(86362001)(83380400001)(6486002)(6512007)(6666004)(6506007)(26005)(82960400001)(38100700002)(478600001)(966005)(5660300002)(8676002)(4326008)(8936002)(66556008)(66476007)(44832011)(6916009)(66946007)(316002)(41300700001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IZg4CYXYABV8rtOJvnCXQ6eFlN/cmji0H5ZKL3xAZ9vZQjeIlgay2RMmuwA0?=
 =?us-ascii?Q?qg7pqocsUcD9YSSXtab1wh8L07PPL6RJbPD4YGMw8Zg/xY5kwZeG1zqRHXeM?=
 =?us-ascii?Q?wm5cyEqKU6hXE9EpiSxv6DC730NthOwwmCQSos6kKvJ6fD6t1xmSgB+1gQhM?=
 =?us-ascii?Q?sNU5Zt0jt3ddIzKRotkINkmRrUsF87mfA9pH2GRVjj/nxjXh7ZtatNvfuN24?=
 =?us-ascii?Q?o6P5Ns3++nl9OAa1x4t0nOloByQEQ8qmf09nUsE7VwYAuTZQz3MSge/ehabF?=
 =?us-ascii?Q?t3gcViK9Ih7eLFvd2lY6JOH3KD4mMq7IVyx/Kr7oKZQII/2VIkQApcX65FfH?=
 =?us-ascii?Q?tRPYmxH+fd+zOcH3adlrZhlXEfsmaDWIYit+EoquckG6+qnAlSU2DhfjwqP0?=
 =?us-ascii?Q?IBVkQ7UGTuEocRWV85w9wN3DzrJ6ogQsKp0NpXt08eze3F8rkXklUcii/BxN?=
 =?us-ascii?Q?jLxg34EkIHaj5I8Rew5MRFyxT1Qb6cHJ52yn/1seTAOi3zf43+9fwgz4e1VE?=
 =?us-ascii?Q?WuBpLJMbFOcYJHwSDX4kHnmTS7guFCfDrfsX47A6kvirMzp+tp8pe8HIz+AM?=
 =?us-ascii?Q?aNyw///gy/lbyxeZ34B3uWjI51BZEVlmzrY95cRtlUn3OSeXza6Vmb52hbbi?=
 =?us-ascii?Q?pllPgeev/j5BnX0ZVL51JP+b2CtPY/+aNlxv/auAU7gY3wm4jP4L0piWeAAX?=
 =?us-ascii?Q?5ZoFrlPNhaLkiwuiMs2ceNV00R9JMicT2/X1SvL3/eZ8zR7r0bRV/Mn7eiD2?=
 =?us-ascii?Q?lThAwR+eATgg4NlsQQu8xIQraUngH26BrJkTOfqfTR3vR0w/MUkdMxlDbN3b?=
 =?us-ascii?Q?W6TfVLky5XYfTqE8OUdESSW3LWILRAc30JhEiMU1OPJ3RlYR2glV1i+HsuBg?=
 =?us-ascii?Q?G4OBfT/kC+Wm21ZEtclSTlOEpsiWEzIw3ndrsomxerNtdHbPPjfEEU4FT5GW?=
 =?us-ascii?Q?oMBRLgTtalw/fJqPbYGQwrEO1e3wtgxIC1T8vbhh6NjNAu6TuBR62iCOGAvm?=
 =?us-ascii?Q?eLgAHtLZsTSkW47am6xTnkG+/LdJsxxP/HhLIckKY6qvy59wAwTXqgAvjKcK?=
 =?us-ascii?Q?VuSAcL+REQOIDFqLN1rL8I5qM62y368q9rYmb2e1yOtHcBFFgMj7fddM197m?=
 =?us-ascii?Q?xYYLRgNBNUxb+cFc8RHlgJG52G8E41wWU0STnPbW0GX1tI1aUWaqbyTRIbnK?=
 =?us-ascii?Q?Gxl6xGvUmsHuSRXwOws5hOxyOvBIxPiYdkSwqcU+Xi0bIWJ699mfUfkTNzNR?=
 =?us-ascii?Q?QoKe2GpyZR8Jto4x5bNVpT5unW4xmerh0dS/nSqO6O8C9t537Kv7hZldMbsy?=
 =?us-ascii?Q?MQy/V2Eu7JZvfoRuMCIrFMfjSv+ECDuFJGAOMFphvTDUlh4N1w7por6ifufd?=
 =?us-ascii?Q?FLE3d2OBCYu2wvqnuTNCTFd8E5UX3SWvyue0jkXFQB/mJnErZZT6ba+1vlap?=
 =?us-ascii?Q?okBTjRw1RwxrcjMMchB6RFefUkgQ6CP8mnwPhfDnGEMYkBreDGm3t9CvRjiU?=
 =?us-ascii?Q?7I/VAvPiqiLvocAE0O1k/FWNbNa1qyd2ib25ru0cE8S3+9iAUL5A1BU2QvtE?=
 =?us-ascii?Q?K4SdvE/PrKM+TVywb/8yLBT83FRzKHVl7iuG1Lor?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c251d099-1efb-4ea7-9339-08dbb35902fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:25:08.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdQiNWOmtquQLDuZVpWCBCLQ0sYz+UayluLCZifA5/zbWpkXQ6AixeRNUnoBI3+JRpoBb9jPI3fBJ4aUYJv3bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5829
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

Greeting!

There is BUG: MAX_LOCKDEP_KEYS too low in v6.6-rc1 kernel in guest:
Seems syzbot didn't report this type of issue yet.
All details are in link:https://github.com/xupengfe/syzkaller_logs/tree/main/230911_142537_MAX_LOCKDEP_KEYS_too_low
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230911_142537_MAX_LOCKDEP_KEYS_too_low/bisect_info.log
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230911_142537_MAX_LOCKDEP_KEYS_too_low/repro.c
Syzkaller reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/230911_142537_MAX_LOCKDEP_KEYS_too_low/repro.prog
Mounted file0: https://github.com/xupengfe/syzkaller_logs/blob/main/230911_142537_MAX_LOCKDEP_KEYS_too_low/file0.gz
Issue dmesg: https://raw.githubusercontent.com/xupengfe/syzkaller_logs/main/230911_142537_MAX_LOCKDEP_KEYS_too_low/0bb80ecc33a8fb5a682236443c1e740d5c917d1d_dmesg.log
v6.6-rc1 kernel bzimage: https://github.com/xupengfe/syzkaller_logs/blob/main/230911_142537_MAX_LOCKDEP_KEYS_too_low/bzImage_0bb80ecc33a8fb5a682236443c1e740d5c917d1d.tar.gz
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230911_142537_MAX_LOCKDEP_KEYS_too_low/kconfig_origin

It could be reproduced in 1900s.

"
[  108.728694] EXT4-fs error (device loop7): __ext4_fill_super:5473: inode #2: comm repro: iget: special inode unallocated
[  108.729658] EXT4-fs error (device loop4): __ext4_fill_super:5473: inode #2: comm repro: iget: special inode unallocated
[  108.731297] EXT4-fs (loop4): get root inode failed
[  108.731303] EXT4-fs error (device loop3): __ext4_fill_super:5473: inode #2: comm repro: iget: special inode unallocated
[  108.731528] EXT4-fs (loop4): mount failed
[  108.732527] BUG: MAX_LOCKDEP_KEYS too low!
[  108.732720] turning off the locking correctness validator.
[  108.732966] CPU: 1 PID: 24162 Comm: repro Not tainted 6.6.0-rc1-0bb80ecc33a8+ #1
[  108.733302] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  108.733803] Call Trace:
[  108.733932]  <TASK>
[  108.734036]  dump_stack_lvl+0xaa/0x110
[  108.734231]  dump_stack+0x19/0x20
[  108.734390]  register_lock_class+0xae5/0x10d0
[  108.734508] EXT4-fs (loop3): get root inode failed
[  108.734602]  ? __pfx_register_lock_class+0x10/0x10
[  108.734824] EXT4-fs (loop3): mount failed
[  108.735038]  __lock_acquire+0xff/0x5c70
[  108.735386]  ? __pfx___lock_acquire+0x10/0x10
[  108.735588]  lock_acquire+0x1c9/0x530
[  108.735757]  ? __flush_workqueue+0xf9/0x1180
[  108.735956]  ? __pfx_lock_acquire+0x10/0x10
[  108.736148]  ? lockdep_init_map_type+0x2df/0x810
[  108.736359]  ? lockdep_init_map_type+0x2df/0x810
[  108.736452] EXT4-fs (loop6): stripe (65535) is not aligned with cluster size (16), stripe is disabled
[  108.736571]  ? __raw_spin_lock_init+0x44/0x120
[  108.737183]  __flush_workqueue+0x12c/0x1180
[  108.737375]  ? __flush_workqueue+0xf9/0x1180
[  108.737572]  ? drain_workqueue+0x30/0x3e0
[  108.737753]  ? __pfx_lock_release+0x10/0x10
[  108.737945]  ? __pfx___flush_workqueue+0x10/0x10
[  108.738154]  ? __pfx___mutex_lock+0x10/0x10
[  108.738356]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[  108.738589]  drain_workqueue+0x19c/0x3e0
[  108.738769]  ? drain_workqueue+0x19c/0x3e0
[  108.738958]  destroy_workqueue+0xda/0xa30
[  108.739147]  ext4_fill_super+0x933c/0xc160
[  108.739342]  ? __pfx___lock_acquire+0x10/0x10
[  108.739551]  ? __pfx_ext4_fill_super+0x10/0x10
[  108.739763]  ? down_write+0x157/0x210
[  108.739936]  ? __pfx_down_write+0x10/0x10
[  108.739971] loop0: detected capacity change from 0 to 1024
[  108.740128]  get_tree_bdev+0x418/0x700
[  108.740545]  ? get_tree_bdev+0x418/0x700
[  108.740729]  ? __pfx_ext4_fill_super+0x10/0x10
[  108.740854] EXT4-fs (loop0): stripe (65535) is not aligned with cluster size (16), stripe is disabled
[  108.740934]  ? __pfx_get_tree_bdev+0x10/0x10
[  108.741542]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  108.741787]  ? cap_capable+0x1dc/0x250
[  108.741964]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  108.742204]  ? security_capable+0xa0/0xd0
[  108.742389]  ext4_get_tree+0x26/0x30
[  108.742554]  vfs_get_tree+0x9d/0x390
[  108.742724]  path_mount+0x6d9/0x1fc0
[  108.742897]  ? __pfx_path_mount+0x10/0x10
[  108.743084]  ? putname+0x122/0x160
[  108.743247]  __x64_sys_mount+0x2c2/0x350
[  108.743432]  ? __pfx___x64_sys_mount+0x10/0x10
[  108.743638]  ? syscall_trace_enter.constprop.0+0x160/0x1e0
[  108.743890]  do_syscall_64+0x3c/0x90
[  108.744057]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  108.744285] RIP: 0033:0x7fa0bee3f7be
[  108.744455] Code: 48 8b 0d 65 a6 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 32 a6 1b 00 f7 d8 64 89 01 48
[  108.745242] RSP: 002b:00007ffeb4e4dbf8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
[  108.745575] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa0bee3f7be
[  108.745883] RDX: 0000000020000580 RSI: 0000000020000000 RDI: 00007ffeb4e4dd30
[  108.746192] RBP: 00007ffeb4e4ddc0 R08: 00007ffeb4e4dc30 R09: 0000000000000000
[  108.746500] R10: 0000000000000042 R11: 0000000000000206 R12: 00007ffeb4e4df78
[  108.746808] R13: 0000000000404c8a R14: 0000000000407e08 R15: 00007fa0bf1e1000
[  108.747121]  </TASK>
"
I hope it's helpful.

---

If you don't need the following environment to reproduce the problem or if you
already have one, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!
