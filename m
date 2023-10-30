Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57FA7DBCCF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjJ3PkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjJ3PkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:40:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40A0B7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698680419; x=1730216419;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rJff4Q1JtP8I9BKYKBizm5r7PU3gg3h+uS6xkuxXMDo=;
  b=YmfH47KFltL9Bvo6ZFEPpAfBR3nG/VbYIn0TQkJ/hxJvI+Oajro+EWAB
   3DsP052CV0luAVP8PWda9N7F0aFSkkscZ68N6if1Pe0HHqkLtgIRxtVNX
   Dkg4TsLh3PIHh/82ZLnnBBA/ZZ01U5dF2CvuYhHeZ4erd8rvW2t9ft71w
   1jmvPUdk6MR28kSVrziKoJjvvOjmGjGo9HeGx1WVUSGVhKvhnPWMqLMmx
   cXJnHpor0mo9YHmJQcTKLeS0P2Q4WgyC6xZl5KBhE98nFr2eOTmoRj3pS
   yVcyXPsAGhZMdH8QP60S7Rd/S+hFfeY1ATGxpvXHhbDE+mUoR/V4jpPD6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="936606"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="936606"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 08:40:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="710127878"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="710127878"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 08:40:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 08:40:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 08:40:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 08:40:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 08:40:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmcyfVUVZU2CvaHIw42DokYvNHo2JSZYSbqJuIGASFHfGVBpjAzJPPuo/gI6UNRHvj0CLCPbOVshW680cqxO0xSOSx7YvlFINqbKb+vy5tZ1MjAEtAdUWY1XzkEtJ41v/GnWiibEOSdB+iR6Jo16VhpAhIk5rJvveNWgD2iB/sR0o5FHHcJGzxsuweXl9spshqBaZPFJsmeY43b06IjnJ6jSj1X5PMq/IxFRNtnxIbDGfQW8VYJwEABe+SRa6+SRr3yS4n09XxwZCoNdv1+FXo3rEdSoTCCqiXYkyM1Qy80nM5ep51HnYDE0eN03jDTThCvZToOWSNoDoy2HHTpGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qcAmFA9dGe1t0TzGvjmrcNid57+ciSnyJp+PkniET8=;
 b=M3IRwbtF8qiuDi04d7mWNnbYP67ermBTmUHt/Z3iNCSDPDujpFTQf62CPC1lrzaVRbjafE49KOBcZW7XSqAHb+lpl7pzuZoupsmdDQWApOr92qBEZr0qkoqSndjJh1wEe13vJ0D0cISqnpaooGIAnDDRw3zygvmK9urBhpG9v+hJ8fUkNBqobYHmXd8JF/cXGqLKTYq3e096hO8LghcrLV2adS+7iI/s7tlLetQs0D7P7RF2U1CZbJULcCyiCsATHqU09niOfcuVpgJOrSDwDMhaDQMq1ey4kXGi3Z2EGDoa+yQDid4byUHJcCUsa31A+LnpS4Re3y07DdD8IgQ1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB7595.namprd11.prod.outlook.com (2603:10b6:510:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25; Mon, 30 Oct
 2023 15:40:08 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6933.026; Mon, 30 Oct 2023
 15:40:08 +0000
Date:   Mon, 30 Oct 2023 23:40:01 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Waiman Long <longman@redhat.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [sched]  851a723e45:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <202310302207.a25f1a30-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f0926d-ab87-4721-3d96-08dbd95e7f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9oRouKR0CmwK2iZuiAonrij1wK5wsxRqTa9YcMGjczM6ZF/tg8xTstATlxaP4Re5bOG379BCWIH2WhWjXhzqqrTLMtbCALm6Du7VQKaaxIkWtNm/ibYeiwSiesKK8WUWrI0cRtFjUsCcHweGUE4NWFOZi3S8095kAneIOgPyd6aAyhhVzQ+DAys4NQ5G4VW5OfD0NV1tH7Zb9OoUiXiPYBS1zDp4dvUTgTY4V3RJeUOg4Fb2OhozaI11yqE0FZkHZ2PkJvcp25I1wjzByg7/YrPctC0k3ayvALSHyQDrryA0SaWsg4BSsHWJnW2Q/Qg6J4x8At32+8VvR0KBBuqCKCEIpTkDLtl4aAUQxHJu0DTWE5GEPtblWTWtuuHqMLYiwfIuMJ4+zYpfRAwhEoe/Y+2RCBe/yvDWyCHEZYQ1AIAHzl7DHM96upjkQ7AwKcyjrgV4320813ptCLo21t/7QyowaDkRePiTfOgxsMN4WjpFXjxUO1SwU11uIuCexGKxqoHCWOIoqO7T8LF71CoaPxFUv385ii3i+cCB3dq91JrotLHvnW1jaUV2auMgvq9S/0WJMRYSmMAlneDJV6ePUp8qM16OBk+yAnAYcv/uO/nKtmAVmW6eYW4ESBW3Y+/s2mzitfHaMopCDZ4x5KTwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(451199024)(186009)(1800799009)(4326008)(8936002)(8676002)(6486002)(2906002)(82960400001)(966005)(26005)(1076003)(83380400001)(66574015)(2616005)(86362001)(5660300002)(36756003)(478600001)(66476007)(66556008)(66946007)(6916009)(41300700001)(6506007)(6512007)(316002)(38100700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L94IzFEv1thCBCmw9lSt5yHuDrSUbfxoltXFCcBehrAVrDVtRV6gK+oIbCue?=
 =?us-ascii?Q?J4m0hkT42jx851lh8D23CYACc1BuXa4KDf7Oki6cb9HTscdlm6QzhhUQqBgR?=
 =?us-ascii?Q?uN8IPqNSJLvn1m3d9GI8x580I8vOhISB6ibZdHTRwb9oTd8cpaAQ34ief6p6?=
 =?us-ascii?Q?7fG6nTul4P82NFMv3w6Nxugq+0iQxeeYsve3dSFaWLj8pLTrgSmF9wUngWC0?=
 =?us-ascii?Q?L7ABJ2nMVfXSwbe1r6IQKo1Edagu7s4bc4wkiQ0b+aPjDxgWK/SpBJkaBDtM?=
 =?us-ascii?Q?4+mTfQtRJZmpz30/qe2PIImkvTSqYsm+YczgxDXxHCgc1ysOkYHstMDUA7rR?=
 =?us-ascii?Q?PpOaDXNdw3dPI3wQke3C0IfMeWYW3nKvxmbTxer5SrpXWep+N6twvkc55r1t?=
 =?us-ascii?Q?Deiczw0V9egHKkjOYzWSNaqFkiUW0XaPm1voApTkXidd/R/zZpqB1vGfCWge?=
 =?us-ascii?Q?jwbvNGjfzoHfrMi5fwVzbLrNjZso2pjDGpwErNB7rBxq3ujYF32OGmTmJDlo?=
 =?us-ascii?Q?l6IWrZkhZuRJphCXwEfalkdAzH2T6coPhAU8Fg8t/Zp8MAI3WuwuLnYwEv/5?=
 =?us-ascii?Q?6hMbNbFYyU+SKEnKMc0o2eA1EjQ2NJ/+gWm6iLxckB2sUnx/Xe8Y2cpyn5no?=
 =?us-ascii?Q?Or8JVLACYWpYEs5DMAtjGWwdJF/jOhltKdxOsUJSQo7M3Q18lzp6s/XIXfns?=
 =?us-ascii?Q?AnjNpmcwYDUMvXJIArC3XIX4z1rCdh5cdfLvkHBIAHzWbwpeBOBzdcPSSTKB?=
 =?us-ascii?Q?ASJdJIPcgZY9VmRdOqTgjwKxTFS8S3wWe3GW2c+U8qEWfgtgK//VJnMU+dRp?=
 =?us-ascii?Q?9BH1lXbOBmaxN28P7yVdKHI4JjfXDrUJ2kdkfIkv989g1+2Por75qfV1BtRv?=
 =?us-ascii?Q?ECARoUs1Msjvs2mlgPSGMggONNfJOjIjFJ57viY7bzKQYex6ReFBFF+oKkY3?=
 =?us-ascii?Q?XIbpEopFqQCKfbTjPk4XqSBSGsgJ/5c5ACWJpsn6Ua6c517uEeMUQfSGJoqz?=
 =?us-ascii?Q?vZwJ0ub3sWtykfDM123XPXsuTx1FzsXNC0E/cso95a/8bL30Q7mU2knWFLup?=
 =?us-ascii?Q?+WvTRxxAbls7qWh5b+Zol0ZGNgE5SUUOvAkENIeN4JWIhJpovDdlauEk7/i5?=
 =?us-ascii?Q?+KoeidLC7KbnFV5DTmvbszoqwbPQOuLZKXGqIeFJkXYXx6BLzF+sGRzh5wIp?=
 =?us-ascii?Q?vObuZHAFHH3XxSij0tmqudBsHg+5e/ELq4oB6Du4mnliQ3oVS373jsiwPvHB?=
 =?us-ascii?Q?CcOEMFNUpz1oJikxjJ768I0mlRajrLhHeY45zv/RwAQ9XTTrozN+/Rdx2yFv?=
 =?us-ascii?Q?1Bnw02k+cZT1u5emqTV6TH16gz72ulHTMjKd679Tj7+oDzIab0jDFa5auWhw?=
 =?us-ascii?Q?svLLam3TBg+/UrEPIQl+sEOJgmha/al+Mpt1VUMAhSPGNerw4OQv2GpPfG7Z?=
 =?us-ascii?Q?ATFrdOlE32ZMMFAiNTVwaDuoIUvNdH9ct4N3pYGbu8l+ilhtbh5MYXu9zqXB?=
 =?us-ascii?Q?DlOZ0tlnlMmsBrg/9NZ+MvMZNhg1ZP8bnxrUmWJuqfP/SMNUcYWKrTOeKJ7h?=
 =?us-ascii?Q?EROiloQ7/6nHuHkcJAY7fctU5AHpvFdQJ4o6PWJTxZlVvjLLFLcn1Cm0tKiw?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f0926d-ab87-4721-3d96-08dbd95e7f00
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:40:08.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7P8PyoPtqXMxToPpmVwZxGhG5ttLO5tE71QVM0oU1451o3WYZAtK0uW+m3DmuO0YOhI4/u7sz9BWJgB/HXopA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7595
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: 851a723e45d1c4c8f6f7b0d2cfbc5f53690bb4e9 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 56567a20b22bdbf85c3e55eee3bf2bd23fa2f108]
[test failed on linux-next/master 66f1e1ea3548378ff6387b1ce0b40955d54e86aa]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: trivial



compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


please be aware that the issue doesn't always happen, ~50% rate:

da019032819a1f09 851a723e45d1c4c8f6f7b0d2cfb
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :44          45%          20:44    dmesg.WARNING:possible_circular_locking_dependency_detected
           :44          45%          20:44    dmesg.WARNING:possible_circular_locking_dependency_detected_migration_is_trying_to_acquire_lock:at:rcu_nocb_try_bypass_but_task_is_already_holding_lock:at:__balance_push_cpu_stop/0x



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310302207.a25f1a30-oliver.sang@intel.com



[  708.890347][   T22] 
[  708.890648][   T22] ======================================================
[  708.891276][   T22] WARNING: possible circular locking dependency detected
[  708.891882][   T22] 6.1.0-rc2-00015-g851a723e45d1 #1 Tainted: G        W         
[  708.892549][   T22] ------------------------------------------------------
[  708.893234][   T22] migration/1/22 is trying to acquire lock:
[  708.893792][   T22] ffff88839d3f2478 (&rdp->nocb_lock){-.-.}-{2:2}, at: rcu_nocb_try_bypass+0x71b/0x990
[  708.894716][   T22] 
[  708.894716][   T22] but task is already holding lock:
[  708.895414][   T22] ffff88839d3f1518 (&rq->__lock){-.-.}-{2:2}, at: __balance_push_cpu_stop+0xa0/0x470
[  708.896311][   T22] 
[  708.896311][   T22] which lock already depends on the new lock.
[  708.896311][   T22] 
[  708.897274][   T22] 
[  708.897274][   T22] the existing dependency chain (in reverse order) is:
[  708.898122][   T22] 
[  708.898122][   T22] -> #2 (&rq->__lock){-.-.}-{2:2}:
[  708.898816][   T22]        __lock_acquire+0x9d7/0x1330
[  708.899332][   T22]        lock_acquire+0x193/0x500
[  708.899802][   T22]        _raw_spin_lock_nested+0x2e/0x70
[  708.900317][   T22]        resched_cpu+0x77/0x150
[  708.900802][   T22]        rcu_implicit_dynticks_qs+0x5bc/0x850
[  708.901391][   T22]        force_qs_rnp+0x40b/0x790
[  708.901873][   T22]        rcu_gp_fqs_loop+0x63a/0xa40
[  708.902393][   T22]        rcu_gp_kthread+0x23b/0x380
[  708.902886][   T22]        kthread+0x246/0x2d0
[  708.903320][   T22]        ret_from_fork+0x1f/0x30
[  708.903777][   T22] 
[  708.903777][   T22] -> #1 (rcu_node_0){-.-.}-{2:2}:
[  708.904456][   T22]        __lock_acquire+0x9d7/0x1330
[  708.904971][   T22]        lock_acquire+0x193/0x500
[  708.905470][   T22]        _raw_spin_lock+0x30/0x70
[  708.905961][   T22]        nocb_gp_wait+0x349/0x1d50
[  708.906460][   T22]        rcu_nocb_gp_kthread+0xa3/0x230
[  708.907000][   T22]        kthread+0x246/0x2d0
[  708.907448][   T22]        ret_from_fork+0x1f/0x30
[  708.907923][   T22] 
[  708.907923][   T22] -> #0 (&rdp->nocb_lock){-.-.}-{2:2}:
[  708.908664][   T22]        check_prev_add+0x94/0xbc0
[  708.909167][   T22]        validate_chain+0x701/0x950
[  708.909678][   T22]        __lock_acquire+0x9d7/0x1330
[  708.910197][   T22]        lock_acquire+0x193/0x500
[  708.910682][   T22]        _raw_spin_lock+0x30/0x70
[  708.911174][   T22]        rcu_nocb_try_bypass+0x71b/0x990
[  708.911715][   T22]        call_rcu+0x22d/0x840
[  708.912172][   T22]        __kmem_cache_free+0x1c9/0x460
[  708.912691][   T22]        select_fallback_rq+0x546/0x690
[  708.913226][   T22]        __balance_push_cpu_stop+0x21d/0x470
[  708.913791][   T22]        cpu_stopper_thread+0x206/0x450
[  708.914328][   T22]        smpboot_thread_fn+0x38a/0x870
[  708.914852][   T22]        kthread+0x246/0x2d0
[  708.915297][   T22]        ret_from_fork+0x1f/0x30
[  708.915769][   T22] 
[  708.915769][   T22] other info that might help us debug this:
[  708.915769][   T22] 
[  708.916718][   T22] Chain exists of:
[  708.916718][   T22]   &rdp->nocb_lock --> rcu_node_0 --> &rq->__lock
[  708.916718][   T22] 
[  708.917838][   T22]  Possible unsafe locking scenario:
[  708.917838][   T22] 
[  708.918541][   T22]        CPU0                    CPU1
[  708.919055][   T22]        ----                    ----
[  708.919543][   T22]   lock(&rq->__lock);
[  708.919927][   T22]                                lock(rcu_node_0);
[  708.920535][   T22]                                lock(&rq->__lock);
[  708.921146][   T22]   lock(&rdp->nocb_lock);
[  708.921576][   T22] 
[  708.921576][   T22]  *** DEADLOCK ***
[  708.921576][   T22] 
[  708.922329][   T22] 2 locks held by migration/1/22:
[  708.922796][   T22]  #0: ffff88812e1ec000 (&p->pi_lock){-.-.}-{2:2}, at: __balance_push_cpu_stop+0x8b/0x470
[  708.923764][   T22]  #1: ffff88839d3f1518 (&rq->__lock){-.-.}-{2:2}, at: __balance_push_cpu_stop+0xa0/0x470
[  708.924711][   T22] 
[  708.924711][   T22] stack backtrace:
[  708.925280][   T22] CPU: 1 PID: 22 Comm: migration/1 Tainted: G        W          6.1.0-rc2-00015-g851a723e45d1 #1
[  708.926248][   T22] Stopper: __balance_push_cpu_stop+0x0/0x470 <- balance_push+0x218/0x360
[  708.927040][   T22] Call Trace:
[  708.927351][   T22]  <TASK>
[  708.927632][   T22]  dump_stack_lvl+0x9c/0xea
[  708.928053][   T22]  check_noncircular+0x28e/0x330
[  708.928517][   T22]  ? kvm_sched_clock_read+0x14/0x30
[  708.929024][   T22]  ? print_circular_bug+0x470/0x470
[  708.929546][   T22]  ? housekeeping_affine+0xa0/0xa0
[  708.930071][   T22]  ? alloc_chain_hlocks+0x21f/0x6f0
[  708.930572][   T22]  check_prev_add+0x94/0xbc0
[  708.931053][   T22]  ? lockdep_lock+0xa8/0x190
[  708.931491][   T22]  ? usage_skip+0x170/0x170
[  708.931936][   T22]  validate_chain+0x701/0x950
[  708.932378][   T22]  ? check_prev_add+0xbc0/0xbc0
[  708.932842][   T22]  ? mark_lock+0x36/0x3c0
[  708.933282][   T22]  __lock_acquire+0x9d7/0x1330
[  708.933749][   T22]  lock_acquire+0x193/0x500
[  708.934198][   T22]  ? rcu_nocb_try_bypass+0x71b/0x990
[  708.934717][   T22]  ? lock_downgrade+0x120/0x120
[  708.935188][   T22]  _raw_spin_lock+0x30/0x70
[  708.935631][   T22]  ? rcu_nocb_try_bypass+0x71b/0x990
[  708.936143][   T22]  rcu_nocb_try_bypass+0x71b/0x990
[  708.936641][   T22]  ? rcu_implicit_dynticks_qs+0x850/0x850
[  708.937195][   T22]  ? find_and_remove_object+0x1b0/0x1b0
[  708.937700][   T22]  call_rcu+0x22d/0x840
[  708.938095][   T22]  ? rcu_nocb_try_bypass+0x990/0x990
[  708.938591][   T22]  ? select_fallback_rq+0x546/0x690
[  708.939097][   T22]  __kmem_cache_free+0x1c9/0x460
[  708.939580][   T22]  select_fallback_rq+0x546/0x690
[  708.940067][   T22]  ? __do_set_cpus_allowed+0x730/0x730
[  708.940593][   T22]  ? update_rq_clock+0xd8/0x890
[  708.941060][   T22]  __balance_push_cpu_stop+0x21d/0x470
[  708.941605][   T22]  ? tracer_hardirqs_on+0x3b/0x3f0
[  708.942101][   T22]  ? migration_cpu_stop+0xb60/0xb60
[  708.942582][   T22]  ? _raw_spin_unlock_irq+0x24/0x40
[  708.943068][   T22]  ? migration_cpu_stop+0xb60/0xb60
[  708.943566][   T22]  cpu_stopper_thread+0x206/0x450
[  708.944084][   T22]  ? stop_core_cpuslocked+0x1c0/0x1c0
[  708.944611][   T22]  ? smpboot_thread_fn+0x6f/0x870
[  708.945096][   T22]  smpboot_thread_fn+0x38a/0x870
[  708.945604][   T22]  ? find_next_bit+0x30/0x30
[  708.946058][   T22]  kthread+0x246/0x2d0
[  708.946467][   T22]  ? kthread_complete_and_exit+0x40/0x40
[  708.947015][   T22]  ret_from_fork+0x1f/0x30
[  708.947449][   T22]  </TASK>
[  708.974879][ T3910] smpboot: CPU 1 is now offline
[  709.052971][ T3910] x86: Booting SMP configuration:
[  709.053504][ T3910] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  709.065107][    T0] masked ExtINT on CPU#1
[  709.177297][ T3910] smpboot: CPU 1 is now offline
[  709.236384][ T3910] x86: Booting SMP configuration:
[  709.236914][ T3910] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  709.248562][    T0] masked ExtINT on CPU#1
[  709.357577][ T3910] smpboot: CPU 1 is now offline



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231030/202310302207.a25f1a30-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

