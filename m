Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B107A146C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjIODeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjIODeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:34:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3981270C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694748842; x=1726284842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tMyYbQ08lRJG6+XgOkxYjjafxPAHqofDjcfsbuTqEW8=;
  b=JdFjrN+6xcWXMF9x90hfM/uz9WkQfcPqfDlzjHHj27uadwmAzwdm8XUY
   wsfEOWmQaXNCk1NUq3X7YyR1WetNS7v1Itv8TPbEZd6l5zxvUSMMIYYKK
   ELvwuSEvtxcolUKZXXBFeeg/qhL0Zr5FJHimREohVMP62SQhGWX+RhwJi
   d4zwukTA8TqQxCsnvhecAGVDplwwOdrJEs6yg292txPGiG0j/goZny6wQ
   LxPY72FtaRllk6yOdI1+Wn5t8jFDDhzZZzSP1nbGQnwPzihgfxSte+cUg
   B7UZh54XVLb0tapBZxQk2ZwtbTQFQ4XG/parvpcBcmzyxKhhN5AJmsCqE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="410086031"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="410086031"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 20:34:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="835016056"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="835016056"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 20:34:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 20:34:01 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 20:34:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 20:34:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 20:34:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjKHD7a9i0SP94BYNQ+9r0gP7gMdv1xb7uThbN9M7FyMscZThfjEHL9iUfCaXZCQJ/pxG5DXlfV3KCeiFs7Xp62oAbvhz3ZcRH05zqtkxykm0OdDOd2phxmfnAxWO59X7foNXp/p2FwYUEL6KPczU5759lROEyk6Dl6gsJMVuOs9AdvPeZwV8eyYFTyZNAsYESU8ojKYH4iqmu2eRPXw2EUxyClsQyC7q1JCTrsMc1gC9O/b7fXLh3+CLOhVg532NwqPxvhGkOXQuHTsdpp1iEN8ClTBFWXwuqZr1TyQ9E3ve6/QqqRK2gr1n3MkB2FGO8/dtBN91trLJrLi4IPzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttuohYEgZ7P1ogZh7NTuarZl6oXaf3PlMNonRLigY9c=;
 b=SYhg1hEpiYVJpZOzobi0t0KZeZ5D8siaCg46N3Hebvhp6RdeODCc4wg6kDR0M+em/IjnUmgzbAiVb4UfAWm7Do2CCI+dAeRn8WBqV6Mhj+HQbkJgNC1OMH/wz6AHKcEyS0gqXvMKg+1urC/yxSycvTEXkbumE2KSiVhUkuc0pVxwZ9pBQ1bXWBMv7ALtGahnwsXnMCV14t2r48sR7eTU9yIzd4vE3LHBk9CEEZpGiKePaSvdfRcdLCsy8T4kG80G8AnMByRUEOH6+Opwn21csrouDO/ino9Ey1JyZypNJGs7iVWiABCZ/40VlYga57sP7k+R7Tdx4tNJi7xrA/UD0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by LV8PR11MB8512.namprd11.prod.outlook.com (2603:10b6:408:1e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Fri, 15 Sep
 2023 03:33:58 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 03:33:57 +0000
Date:   Fri, 15 Sep 2023 11:33:47 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [sched/fair]  e0c2ff903c:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog_nr
Message-ID: <202309151052.222af09a-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|LV8PR11MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 1afdc2bc-473d-4cc0-a660-08dbb59c9800
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBA1sIbZasx7kJgLNT75d9tvS1Xyn/VGMnQsx7z+B8e23kpSr6TytZFRno3/MUPYmbWdlf9bFZLGX8N1JNMDL09skvj6xnGXOnfomu477wLSMP3Etd13EV8tqOi7d8xkTYdUr2I7cetjC4WTExWPxwKvLRqvyY6ce7pxUSNNIBmOUeQ2+UvocbbgMF/PURH85TSfrx561eGXTgs92vlC9JZNlM1R/vJf1xObnr/+P4689gCFZRunWR7AB5++UtOyA/5ZGViRdK87l3bXYnFW/09G3fm3VBerGRGJFAjjb5//XzkdfnfsbS61Qy5xTkuVSWxIXWM/tptUEl+dBk/16wrGPDOLiBx4V0EzeboT6SVDEH2uxD5TQo4jsdIydxNmgGNK5xfe8Aw/fHwKDcDSlvZEprzqhw/fVTnEFduZ1NXilpN2tgeEKQX3Sa3yKRZbx0227RuCvhu5ldqwaLSDn4EyWwnyoi12PRiO0kT3LhqkLt6GS2xnfN9/Suh+LLlP8nQPZK/Xtz9iRAWWv5PhBeWzU3TtM7Lh6eTc6ZRBYqcQcOf4Zou8C1Hu6V2wZ5iXGrS6+/GypM/tGQa83NVtC3dLRHHNl1dQRSciscr8OB0u7v4Ox7zjkupPsaG0e4yYg2VIb/8D2g+mNf8sdbToug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(1800799009)(451199024)(186009)(2616005)(6666004)(6506007)(6486002)(45080400002)(36756003)(38100700002)(86362001)(26005)(82960400001)(2906002)(6512007)(478600001)(8676002)(83380400001)(66476007)(966005)(6916009)(316002)(4326008)(5660300002)(8936002)(41300700001)(66556008)(1076003)(66946007)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8v7Y+btKRtLhwGE6gb7RUbyd2D8EUPQyBSN2YxCAcVG6S9Bzk/fH8YWbzYOT?=
 =?us-ascii?Q?qs+XTkivI5hlo7UFt03j+UesyzmxRWxcztbymcjzJe+reVGf/hCI4rIadSt0?=
 =?us-ascii?Q?3WcbzxTICc0WR1lFMFcnuxW0UIA/wF8dU+aXQHOE0rTAkpCDu00pUra+SyB8?=
 =?us-ascii?Q?0cT1WJYQhaOYQi6dlPPuKWOfqwNZbPON44CpPXq6JzYPXmcStMJXVZzZoZF4?=
 =?us-ascii?Q?gyYasLtnja50U4vNUtR4r8kDE06Vy3KDpLQ0IOqpWRcvbFmCGqwdqTt8y26+?=
 =?us-ascii?Q?2Ai0b/SWHjSsnlw95dt7n9CV8j0SCYnCx1XLEgAqgT85MSZZqbdtU5jQE0h8?=
 =?us-ascii?Q?WR7UtOzFzaYfTw3KM4UZTuv1NHrRKCBvwTTTx7QMUfotId7AnFowhJfaP5FL?=
 =?us-ascii?Q?vKV3z6aO8n+Zqk7KTRqP/qqQO1PszP48IMoauDc0QrFimUGL0tY91YDVuSmv?=
 =?us-ascii?Q?bwmSi5pjw6FewSFQ/4sQeFvg7hich4qXD6IEMqJYIIOtuD1kxKWtIqxDufIW?=
 =?us-ascii?Q?PqUSLRfXtLKyyT32GAXRoWcduZvx+LAjpuh/lrhAukiVvWVbp0zmP2cbNNmz?=
 =?us-ascii?Q?1AixFOZ6g2/+h4fnIDJM2kbbGS3TJVT4Oc9qoqHUNexOtC3eT4aztqdNHtoC?=
 =?us-ascii?Q?71NBtqDjrpOMh3d7urAm1DfP+/358PkEPCKhqVSfpPHQ31zIghTzxtRuWGe6?=
 =?us-ascii?Q?5IALhHOyGLnm/s5fvlVvCuivdpramN8j5cJzHFlI+ePMF60bH5lE4/n+IGyA?=
 =?us-ascii?Q?h3gkJKx/zzdSQqcEwYOrDOa5Oom0o+79Tf8yNHl5IteFKDhJ3N1gQZ/qsUyE?=
 =?us-ascii?Q?/Bpka7QXgS6OS1t9Oiwg+3z24U67Jrc4neXsM6UI/JypwLXrtUDdnrINaB6q?=
 =?us-ascii?Q?K09zvT4bfapZaBuj2Gh2+Wst6+6gojj4Ia+VjnY9ud4izOqrM5DTtvu2V/UX?=
 =?us-ascii?Q?7X18PkOyVk6ltbpAGtnxaWQm23MwyEtMTzH1MwSiHJSFZPJKDol0BEF+1/+d?=
 =?us-ascii?Q?ctzyLuvUzHJLhY4yJTNgycH2g70+Cxn7Vm4hCQxOFuNW3rkcxWry+Q9HuZqd?=
 =?us-ascii?Q?bs9sX4WlZbw8+pgbfCoDhFAtOHsHhzJ7MCwtHT6L95WvneH2L9L4QcJ62Nd9?=
 =?us-ascii?Q?OMFdDDEKkSnv2KjIlSG2szRWW4ZPP6IazM8gGJVkUUhlGKs40xqkqVQ23xiz?=
 =?us-ascii?Q?TuhwbBFNGIjd3sZZr7FM8UvWULPMs1u3crTi4/xP8tyIzOqEjnrWBGC05DBX?=
 =?us-ascii?Q?75vcPNGfZmGRQCXhzKxRR8muZXog2LJyOn8tkQYysOWAKiaVBXvzmAuuSsm0?=
 =?us-ascii?Q?OQiIjj1w/EWnmj0s1YVFQTDgBVTP3at5oc1rApwDWE0YGEUNqDaD1fci24sJ?=
 =?us-ascii?Q?wyssbbn2Ees7zV25+IiXdnQwv/Q+WEAoQp8p3OB5mi+IeUuB+kO7WN0272WQ?=
 =?us-ascii?Q?YpAdbErUjUGXSSoX44qKZ6F2rmuGVUKuPbMlYS5fFjzhsEWeGjgdJhih6t/R?=
 =?us-ascii?Q?zyJjj3z9cxft/3A7daodNpSgdVdaQiYShqCdPwW6tBbwMqZy7FgsdHY+R4To?=
 =?us-ascii?Q?uPLBH3dVHo1nSwONxKpTpxDuBQjfl7uzuwf6PllQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afdc2bc-473d-4cc0-a660-08dbb59c9800
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 03:33:57.4662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMjbnTkFUIuWKNM+xVMiXay2tPlByYaBYNWn8lIkZjsMHwUFkmkA5hPordoR53CSxw/3qNdCD3jatbt9gdzLBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8512
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi, Peter Zijlstra,

as below table:

af4cf40470c22efa e0c2ff903c320d3fd3c2c604dc4
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
        100:100          0%         100:100   dmesg.BUG:workqueue_lockup-pool
           :100         39%          39:100   dmesg.EIP:console_flush_all
          1:100         -1%            :100   dmesg.EIP:kthread_should_stop
          1:100          0%           1:100   dmesg.EIP:raw_spin_rq_unlock_irq
          6:100         -1%           5:100   dmesg.EIP:rcu_torture_fwd_prog_cr
           :100         97%          97:100   dmesg.EIP:rcu_torture_fwd_prog_nr   <----- (a)
        100:100          0%         100:100   dmesg.EIP:ref_tracker_dir_exit
        100:100          0%         100:100   dmesg.EIP:ref_tracker_free
          6:100         -1%           5:100   dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog_cr
           :100         97%          97:100   dmesg.WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog_nr   <----- (a)
        100:100          0%         100:100   dmesg.WARNING:at_lib/ref_tracker.c:#ref_tracker_dir_exit
        100:100          0%         100:100   dmesg.WARNING:at_lib/ref_tracker.c:#ref_tracker_free


we actually saw various issues for both parent and e0c2ff903c in vm boot tests
with a randcofig (the randconfig is same for parent and e0c2ff903c as in [1]),
some of them are very persistent for both commits, and some are very random.

the most obvious difference is about rcu_torture_fwd_prog_nr as above (a).
even when we run tests for both commits to 100 times, parent keeps clean,
but e0c2ff903c almost always show this issue.

frankly, I don't have enough knowledge to connect the commit change with this
issue, or to analyze its relation with other issues, so just report to you with
these data and dmesg (also in [1]) FYI.

if you need more data, log, or tests, please let me know. Thanks!


Hello,

kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog_nr" on:

commit: e0c2ff903c320d3fd3c2c604dc401b3b7c0a1d13 ("sched/fair: Remove sched_feat(START_DEBIT)")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 3669558bdf354cd352be955ef2764cde6a9bf5ec]
[test failed on linux-next/master e143016b56ecb0fcda5bb6026b0a25fe55274f56]

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309151052.222af09a-oliver.sang@intel.com


[1]
The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230915/202309151052.222af09a-oliver.sang@intel.com


[  357.942103][   T37] ------------[ cut here ]------------
[ 357.942792][ T37] WARNING: CPU: 0 PID: 37 at kernel/rcu/rcutorture.c:2702 rcu_torture_fwd_prog_nr (kernel/rcu/rcutorture.c:2702 (discriminator 1)) 
[  357.943914][   T37] Modules linked in:
[  357.944379][   T37] CPU: 0 PID: 37 Comm: rcu_torture_fwd Tainted: G        W        N 6.5.0-rc2-00017-ge0c2ff903c32 #1
[  357.945561][   T37] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 357.946684][ T37] EIP: rcu_torture_fwd_prog_nr (kernel/rcu/rcutorture.c:2702 (discriminator 1)) 
[ 357.947330][ T37] Code: c2 83 f8 01 89 c6 0f 96 c0 31 c9 21 c2 0f b6 fa 89 f8 89 fa 88 45 d8 b8 20 ab 68 c2 6a 00 e8 c1 3f 06 00 80 7d d8 00 59 74 02 <0f> 0b 6a 00 31 c9 89 fa b8 08 ab 68 c2 e8 a8 3f 06 00 56 53 ff 75
All code
========
   0:	c2 83 f8             	ret    $0xf883
   3:	01 89 c6 0f 96 c0    	add    %ecx,-0x3f69f03a(%rcx)
   9:	31 c9                	xor    %ecx,%ecx
   b:	21 c2                	and    %eax,%edx
   d:	0f b6 fa             	movzbl %dl,%edi
  10:	89 f8                	mov    %edi,%eax
  12:	89 fa                	mov    %edi,%edx
  14:	88 45 d8             	mov    %al,-0x28(%rbp)
  17:	b8 20 ab 68 c2       	mov    $0xc268ab20,%eax
  1c:	6a 00                	push   $0x0
  1e:	e8 c1 3f 06 00       	call   0x63fe4
  23:	80 7d d8 00          	cmpb   $0x0,-0x28(%rbp)
  27:	59                   	pop    %rcx
  28:	74 02                	je     0x2c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	6a 00                	push   $0x0
  2e:	31 c9                	xor    %ecx,%ecx
  30:	89 fa                	mov    %edi,%edx
  32:	b8 08 ab 68 c2       	mov    $0xc268ab08,%eax
  37:	e8 a8 3f 06 00       	call   0x63fe4
  3c:	56                   	push   %rsi
  3d:	53                   	push   %rbx
  3e:	ff                   	.byte 0xff
  3f:	75                   	.byte 0x75

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	6a 00                	push   $0x0
   4:	31 c9                	xor    %ecx,%ecx
   6:	89 fa                	mov    %edi,%edx
   8:	b8 08 ab 68 c2       	mov    $0xc268ab08,%eax
   d:	e8 a8 3f 06 00       	call   0x63fba
  12:	56                   	push   %rsi
  13:	53                   	push   %rbx
  14:	ff                   	.byte 0xff
  15:	75                   	.byte 0x75
[  357.949385][   T37] EAX: c268ab20 EBX: 00000000 ECX: 00000000 EDX: 00000001
[  357.950145][   T37] ESI: 00000000 EDI: 00000001 EBP: c6519f4c ESP: c6519f10
[  357.950909][   T37] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010202
[  357.958410][   T37] CR0: 80050033 CR2: ffd99000 CR3: 0288f000 CR4: 000406d0
[  357.959185][   T37] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  357.959952][   T37] DR6: fffe0ff0 DR7: 00000400
[  357.960488][   T37] Call Trace:
[ 357.960896][ T37] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
[ 357.961417][ T37] ? rcu_torture_fwd_prog_nr (kernel/rcu/rcutorture.c:2702 (discriminator 1)) 
[ 357.962043][ T37] ? __warn (kernel/panic.c:673) 
[ 357.962536][ T37] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 357.963046][ T37] ? rcu_torture_fwd_prog_nr (kernel/rcu/rcutorture.c:2702 (discriminator 1)) 
[ 357.963673][ T37] ? exc_overflow (arch/x86/kernel/traps.c:337) 
[ 357.964197][ T37] ? handle_bug (arch/x86/kernel/traps.c:324) 
[ 357.964703][ T37] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator 1)) 
[ 357.965242][ T37] ? handle_exception (arch/x86/entry/entry_32.S:1056) 
[ 357.965832][ T37] ? xas_retry (include/linux/xarray.h:1279 include/linux/xarray.h:1508) 
[ 357.966328][ T37] ? exc_overflow (arch/x86/kernel/traps.c:337) 
[ 357.966852][ T37] ? rcu_torture_fwd_prog_nr (kernel/rcu/rcutorture.c:2702 (discriminator 1)) 
[ 357.967484][ T37] ? exc_overflow (arch/x86/kernel/traps.c:337) 
[ 357.968006][ T37] ? rcu_torture_fwd_prog_nr (kernel/rcu/rcutorture.c:2702 (discriminator 1)) 
[ 357.968634][ T37] ? rcutorture_seq_diff (kernel/rcu/rcutorture.c:2509) 
[ 357.969220][ T37] rcu_torture_fwd_prog (kernel/rcu/rcutorture.c:2914) 
[ 357.969817][ T37] kthread (kernel/kthread.c:391) 
[ 357.970290][ T37] ? rcu_torture_fwd_prog_cr (kernel/rcu/rcutorture.c:2876) 
[ 357.970913][ T37] ? kthread_complete_and_exit (kernel/kthread.c:342) 
[ 357.971537][ T37] ret_from_fork (arch/x86/kernel/process.c:151) 
[ 357.972047][ T37] ? kthread_complete_and_exit (kernel/kthread.c:342) 
[ 357.972684][ T37] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 357.973232][ T37] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[  357.973768][   T37] irq event stamp: 133627
[ 357.974269][ T37] hardirqs last enabled at (133637): __up_console_sem (arch/x86/include/asm/irqflags.h:42 (discriminator 1) arch/x86/include/asm/irqflags.h:77 (discriminator 1) arch/x86/include/asm/irqflags.h:135 (discriminator 1) kernel/printk/printk.c:347 (discriminator 1)) 
[ 357.975253][ T37] hardirqs last disabled at (133646): __up_console_sem (kernel/printk/printk.c:345 (discriminator 1)) 
[ 357.976244][ T37] softirqs last enabled at (133664): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 357.977202][ T37] softirqs last disabled at (133655): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[  357.978216][   T37] ---[ end trace 0000000000000000 ]---
[  357.978834][   T37] rcu_torture_fwd_prog_nr: 0 Duration 2908 cver 0 gps 0
[ 357.979586][ T37] rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x3b() 0 
[  357.980607][    T1] Testing (7,4)_8 code...
[  357.981126][    T1] Testing up to error correction capacity...
[  357.981801][    T1]   Testing correction buffer interface...
[  372.272315][    T1]   Testing with caller provided syndrome...
[  387.604016][    T1]   Testing in-place interface...
[  408.902506][    T1] Testing beyond error correction capacity...



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

