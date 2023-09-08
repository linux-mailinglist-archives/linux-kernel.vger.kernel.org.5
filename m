Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B71E798160
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 06:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbjIHEyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 00:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIHEye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 00:54:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E13C1990
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 21:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694148869; x=1725684869;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+SbbHusH7lyavDnIrLBH3TeV4pFFxKpWStpQRtt7OhM=;
  b=ZgaT77vgItc6ZgHzwrI+YsOfWxEM0ENZaS6jwTayCX7gMha/1OtgYUgt
   5bJn7VgiBtQdWuliBJCglFZ3fAIYop/VcSXBqS7p2Po8eJysXj4wT2Hwz
   /j9kNb0+VZj/sQvhUZX/MtbhxB6MXUBwmcFMwqCKqtC9crIfIWA1DNxzd
   WyDsIWeqvosB3PdV3ik58Nn+bsjltn9mDyv6xjVXoqh6CxcPLf2K9v6z0
   ATk9lSLFHJipSyTg9YCh0rorfW2qZXlTmw3Xtj69pGrDT9h4lBEbHkGxK
   GT8oGgmm9U7Q7QqAfZXy0Ki1UHvvbjDNXDGgg1UDWPxUQ1jK5JuTN1rWs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="443992776"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="443992776"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 21:54:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="692080936"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="692080936"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 21:54:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 21:54:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 21:54:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 21:54:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 21:54:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7FN1sOJoSopM3JcFFpp9RioWokaJRPySGi4vcbDtTfs4s9A4lJB6WmKZO9R0BGz0T6q2sGn900AyAAbFEXJsZRsuLPEwkDywBWRlcuyyJb+4S0+CBrvqrX0ScsmngFeZD9p/CXHiKuWQN8s/6NmuDBoA13cvUSdjO2AK5lIz8xqCuHiUkLZQhu3h9xWTKhxiVheAtoGUqi0+2o/gfFGvoQ3vUOaoPCRk04gC1WZ3wq/snYJgs+eqHYy+yRPnAulwd+fJqNrBxJr8K607aKE3OUSb7LX1cEVVlMwRYmTNZpNxcRehOjSc+P6Mf1JP6Bg/yasO3tPvHkBejkZruRjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i4QjXNBZmDJIZ0jVj1TxnlCosv5tpdw9hdWD/jzBF4=;
 b=JTB56girhhW6ALdcz46xUHSZs01BCBH6ZAs+qAp0nqu663ufXR1LEJYVgo3QtWqPeCWq5qS2wSENdaPsH9qVSXpF+NupIMdIF0V4FTrkfY6pYfyF7cP1fFk60aYSOh08oCxanOLbdVMfa4WFl1CSMPU56rOSIP4zsUzgysENvgHVPoApLSOBJ/I5bw0Ibhmi/E45inwNxZFt2qIvDysE/At+PBRazXwU4r+GiRyammlGbU4R3YPDs4we/bcHWKbNK552ipRR6QpRQSN1T4hAPUuGVuIIqq5LWwSaS3Eg63IpXdSdf+wP/oX+Kxw1zJNDQVuA4Fp+ibsFcnn2qcVtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH8PR11MB8016.namprd11.prod.outlook.com (2603:10b6:510:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 04:54:20 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 04:54:20 +0000
Date:   Fri, 8 Sep 2023 12:54:10 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [paulmck-rcu:dev.2023.08.24a] [EXP qspinlock] 3d22d912bd:
 UBSAN:array-index-out-of-bounds_in_kernel/locking/qspinlock.c
Message-ID: <202309081258.8d57032f-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0124.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::28) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH8PR11MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0ae94b-0342-4f23-6e2a-08dbb027a98f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z00SYUlQJms1tG7ep3DYCYJ55bE6GJUS5CmcoR4TT12SA3KvhpzD97ezqeq65LO0LuY8d4HsNccdEoV4zRx1CDO/e4vkhv2Q5DCuDjockbOuBmAZzjH6N2sC2d3fvXbOpFfyOwAH9y3MPgVHuImkf/qDt+QLs1ELq21KdNgZ5ZLBwDLi1ZgxIJNUzf9wiPkw1PsyijYw7WNnuMqP1zscKpTsqimFa+8Anq+YZcU4aNAZ+yV1W9Pd6iTTzo7UDZn0b7QLb9T1GOp2lirfZV1iv7iHb1mKAHKcOdOQsKMMhFjMkEdlCz+9zF4I/N+Lb2fKxUIOUIxRNCvOwf0KAALIojBy2XMk6QkBiNNroPtf8Mpnv7imLl5zTvc1tJwBAbsETZRngF46qombZwUIkejf3ACbA+4mTjY3UgPFLTt2VMTWcNJ/IBprMRPcrrw2W+qIn+LWnac+LtSoZNP2j6CnNlMz+oc15bkRs4ZRamzyEMC13WQYWgBVUENiL4rxAg2GuSkHRNDYdNDt7g5AdIaGt1VrzjNnehpnUvszsdiidq5JitbdGed93DRffzD8toJ6HMzaOvynceObO7qjOoar+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(1800799009)(186009)(451199024)(2906002)(83380400001)(30864003)(6506007)(316002)(6486002)(6916009)(966005)(66476007)(66556008)(5660300002)(1076003)(478600001)(6666004)(66946007)(26005)(107886003)(6512007)(8676002)(2616005)(41300700001)(4326008)(8936002)(36756003)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VzSj/eukLIW3y9HCo3SSpvGrR2O/EcOJyN7XmC6YjFTyTffH3F3MQQyGlzzV?=
 =?us-ascii?Q?5v/hO1AajPkPmqUadbZsH0whQN9hCCK/PQPG9d0xtc9hXkR8MLEXNg789QMj?=
 =?us-ascii?Q?1DHFl9XrYT0GMVaumXZo2GxQ6drDiyFuiv4+d+T+RIpgHWudIRPbyoBpXwtK?=
 =?us-ascii?Q?untxvYerbpVWb7UkcBQNtbMjEw8md0/HvOa7HuOHJLDPr7JfEddJ7k4lIfVJ?=
 =?us-ascii?Q?HdqsHKRVNbtV9qHQ+a4ydX+9/zXXCbjRQrGCo8QG5Zo38/3iV6i7nM2jA/mH?=
 =?us-ascii?Q?5Trk+JJOEOpDwDSM13ET3HYDEvBsBCtbmCeNws36PsATmkBsJWyJx76UbG4s?=
 =?us-ascii?Q?rA7uJ4xe2sfLbJnui1eECt30ErGWH1BlJUK9r3usvYZoj0BLzLiiLiZv1cox?=
 =?us-ascii?Q?M5Rg8PziGdp8n5rXxt1WKsAwtvwWRGKLTb9TCOSSvX2TYwdWFx6JKG1kZUrF?=
 =?us-ascii?Q?+LGN5DfLBf5EJxs7C2guyatyYEOA5zqD9pYDi+Wf93P+/FdLLZ/NTN/nSpir?=
 =?us-ascii?Q?re66JVDWzaEKfxBMHL5yHAJrPDNft+wu9hVNA/rwWZXM/wWxoCJMV2OpYJn/?=
 =?us-ascii?Q?kRXOw6PaNp2u46xj6yLtbWf5JH8SFcKnlVeGiSZRG1A5koyl3R/3TeqahUZc?=
 =?us-ascii?Q?6fV8rhoK5dVHn6viNcWCRUv8Bv68dx555iJh1Vcvu0IzNOZqnG1KvlO1SuHh?=
 =?us-ascii?Q?wwKRNgdTVnnBGkm/aYlkTjTEJyqr2noUfYlQkwtx5KVoJ8ZPfX4YVXdFKotA?=
 =?us-ascii?Q?a6NCjqRXPgzWdDZ0zALUIw5yCyounqOTfixgWO3JtqmZ0svopn7P+0ITwuD0?=
 =?us-ascii?Q?mVVd3yh8AyDI55OOMgbAXegVjTk7j3lFYrjHzqVyBIGugat8prci9SnKGXw0?=
 =?us-ascii?Q?CYiPMnTUi8AC0JOC7QKVfLb76/Q1nupA0llbz+Kf4JVfQrS2Z8XynkEUTrmQ?=
 =?us-ascii?Q?opyaX2cH/ivNayoJzYxSZdjvEqMXOtuL6ou8cBSlWtkGtgLgxwuNRk/UHcIi?=
 =?us-ascii?Q?Cno81te2GVA7LsQ7fgcRb4HnHjvCikX24odZClqCARndHbTKbLHOS+UnIiyy?=
 =?us-ascii?Q?8A2pUkh21Yx3V0n+LWMa4JE4sCOg9lWaeXDZ78YcFQsHkC5BUFd4ExF9GJJ1?=
 =?us-ascii?Q?Y/zkqKDuc/0eveNmI3rAvCDwmW0QC4PS09QkqOTyJIOXWuU7wL+0sv90nJtl?=
 =?us-ascii?Q?nvi2vkS9Z7c9UWKFZbNoyAiOCLRIeQycwfSTSQucVctllrOBIPb7cbHgJiXg?=
 =?us-ascii?Q?BcCBSUt4lIJ8iHvJ6libcHgYWS157xsIpQtB3ERZq/ruU5FkA07lpVtUGzgs?=
 =?us-ascii?Q?sWXBwoaSsff7AcM0MAx4C7sL2HByVHKcUEKp0WblLIseRK8bq9pud1EB6AYn?=
 =?us-ascii?Q?6QbFFIqacH74rOstSwNlJnz4XmL+k9inRVvTDP67Wfv00+3S3Bkmv093V//Z?=
 =?us-ascii?Q?fSeAtw7MwGLcRBmU4gbmQRZbMoDN3mJKHr86JhzBiD+S3fRo+AKxdzQGXoCF?=
 =?us-ascii?Q?YvCSumrbjezt6dsDY8RBRzdAf9d+TAaRu6kvy5DCg7R5zad1A10UztOLkfsg?=
 =?us-ascii?Q?vEymlzXIvhZAmY+CgIJxX5YDKTtMYLQ42a04JOBzpJ/ziFwbS+1/qHajKumm?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0ae94b-0342-4f23-6e2a-08dbb027a98f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 04:54:20.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/kAh0Y9yS3nVBebDuG4SBUhCYVBp4GJzQkClQzxL8e5a7Nj+syA/DW7N0C6MUFuJesurdt/29WxrUDmu4ojnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8016
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "UBSAN:array-index-out-of-bounds_in_kernel/locking/qspinlock.c" on:

commit: 3d22d912bd0373dd479764644b8c0c81ec4bcc61 ("EXP qspinlock: Dump lock state, add call from locktorture")
https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.24a

in testcase: boot

compiler: gcc-9
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309081258.8d57032f-oliver.sang@intel.com


[ 1660.539448][    C0] UBSAN: array-index-out-of-bounds in kernel/locking/qspinlock.c:712:8
[ 1660.539448][    C0] index -1 is out of range for type 'long unsigned int [64]'
[ 1660.539448][    C0] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       TN 6.5.0-rc1-00129-g3d22d912bd03 #1
[ 1660.539448][    C0] Call Trace:
[ 1660.539448][    C0]  <IRQ>
[ 1660.539448][ C0] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[ 1660.539448][ C0] dump_stack (lib/dump_stack.c:114) 
[ 1660.539448][ C0] ubsan_epilogue (lib/ubsan.c:218) 
[ 1660.539448][ C0] __ubsan_handle_out_of_bounds (lib/ubsan.c:349) 
[ 1660.539448][ C0] spinlock_dump (kernel/locking/qspinlock.c:712) 
[ 1660.539448][ C0] torture_spin_lock_dump (kernel/locking/locktorture.c:289) 
[ 1660.539448][ C0] notifier_call_chain (kernel/notifier.c:93) 
[ 1660.539448][ C0] atomic_notifier_call_chain (kernel/notifier.c:231) 
[ 1660.539448][ C0] rcu_stall_notifier_call_chain (kernel/rcu/tree_stall.h:1101) 
[ 1660.539448][ C0] rcu_sched_clock_irq (kernel/rcu/tree_stall.h:775 kernel/rcu/tree.c:3863 kernel/rcu/tree.c:2241) 
[ 1660.539448][ C0] update_process_times (arch/x86/include/asm/preempt.h:27 kernel/time/timer.c:2073) 
[ 1660.539448][ C0] tick_sched_handle+0x45/0x54 
[ 1660.539448][ C0] tick_sched_timer (kernel/time/tick-sched.c:1492) 
[ 1660.539448][ C0] ? tick_sched_do_timer (kernel/time/tick-sched.c:1479) 
[ 1660.539448][ C0] __hrtimer_run_queues (kernel/time/hrtimer.c:1690 kernel/time/hrtimer.c:1752) 
[ 1660.539448][ C0] hrtimer_interrupt (kernel/time/hrtimer.c:1817) 
[ 1660.539448][ C0] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1116) 
[ 1660.539448][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1109 (discriminator 14)) 
[ 1660.539448][    C0]  </IRQ>
[ 1660.539448][    C0]  <TASK>
[ 1660.539448][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
[ 1660.539448][ C0] RIP: 0010:_raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
[ 1660.539448][ C0] Code: 5e 12 ff 81 e3 00 02 00 00 74 05 e8 12 96 1a ff 9c 58 0f ba e0 09 73 05 e8 97 4a ff ff 48 85 db 74 01 fb 65 ff 0d d3 c8 17 7e <75> 05 0f 1f 44 00 00 5b 41 5c 5d c3 f3 0f 1e fa 55 48 89 e5 53 48
All code
========
   0:	5e                   	pop    %rsi
   1:	12 ff                	adc    %bh,%bh
   3:	81 e3 00 02 00 00    	and    $0x200,%ebx
   9:	74 05                	je     0x10
   b:	e8 12 96 1a ff       	callq  0xffffffffff1a9622
  10:	9c                   	pushfq 
  11:	58                   	pop    %rax
  12:	0f ba e0 09          	bt     $0x9,%eax
  16:	73 05                	jae    0x1d
  18:	e8 97 4a ff ff       	callq  0xffffffffffff4ab4
  1d:	48 85 db             	test   %rbx,%rbx
  20:	74 01                	je     0x23
  22:	fb                   	sti    
  23:	65 ff 0d d3 c8 17 7e 	decl   %gs:0x7e17c8d3(%rip)        # 0x7e17c8fd
  2a:*	75 05                	jne    0x31		<-- trapping instruction
  2c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  31:	5b                   	pop    %rbx
  32:	41 5c                	pop    %r12
  34:	5d                   	pop    %rbp
  35:	c3                   	retq   
  36:	f3 0f 1e fa          	endbr64 
  3a:	55                   	push   %rbp
  3b:	48 89 e5             	mov    %rsp,%rbp
  3e:	53                   	push   %rbx
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	75 05                	jne    0x7
   2:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   7:	5b                   	pop    %rbx
   8:	41 5c                	pop    %r12
   a:	5d                   	pop    %rbp
   b:	c3                   	retq   
   c:	f3 0f 1e fa          	endbr64 
  10:	55                   	push   %rbp
  11:	48 89 e5             	mov    %rsp,%rbp
  14:	53                   	push   %rbx
  15:	48                   	rex.W
[ 1660.539448][    C0] RSP: 0000:ffff88810038fb20 EFLAGS: 00000246
[ 1660.539448][    C0] RAX: 0000000000000002 RBX: 0000000000000200 RCX: 000001829fdcdc01
[ 1660.539448][    C0] RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffffffff82075cdb
[ 1660.539448][    C0] RBP: ffff88810038fb30 R08: 000001829fdce0a9 R09: 00000000bf076f6e
[ 1660.539448][    C0] R10: 0000000071314968 R11: 0000000068a51dbd R12: ffffffff837adc28
[ 1660.539448][    C0] R13: ffff88810038fb78 R14: ffff88810038fc34 R15: 0000000000000004
[ 1660.539448][ C0] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 1660.539448][ C0] crng_make_state (drivers/char/random.c:343) 
[ 1660.539448][ C0] _get_random_bytes (drivers/char/random.c:386) 
[ 1660.539448][ C0] get_random_u32 (drivers/char/random.c:532 (discriminator 13)) 
[ 1660.539448][ C0] __get_random_u32_below (drivers/char/random.c:557) 
[ 1660.539448][ C0] get_random_u32_below (include/linux/random.h:91) 
[ 1660.539448][ C0] get_rcw_we (lib/reed_solomon/test_rslib.c:187 (discriminator 1)) 
[ 1660.539448][ C0] ex_rs_helper (lib/reed_solomon/test_rslib.c:277 lib/reed_solomon/test_rslib.c:331) 
[ 1660.539448][ C0] ? vprintk_emit (kernel/printk/printk.c:2312 (discriminator 3)) 
[ 1660.539448][ C0] test_rslib_init (lib/reed_solomon/test_rslib.c:360 lib/reed_solomon/test_rslib.c:475 lib/reed_solomon/test_rslib.c:494) 
[ 1660.539448][ C0] ? crc64_rocksoft_mod_init (lib/reed_solomon/test_rslib.c:488) 
[ 1660.539448][ C0] do_one_initcall (init/main.c:1232) 
[ 1660.539448][ C0] kernel_init_freeable (init/main.c:1293 init/main.c:1310 init/main.c:1329 init/main.c:1546) 
[ 1660.539448][ C0] ? rest_init (init/main.c:1429) 
[ 1660.539448][ C0] kernel_init (init/main.c:1439) 
[ 1660.539448][ C0] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[ 1660.539448][    C0]  </TASK>
[ 1660.539448][    C0] ================================================================================
[ 1660.539448][    C0] spinlock_dump: End of queue.
[ 1660.539448][    C0] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 1660.539448][    C0] rcu: 	(detected by 0, t=105002 jiffies, g=47729, q=35 ncpus=2)
[ 1660.539448][    C0] rcu: All QSes seen, last rcu_preempt kthread activity 105002 (4296327522-4296222520), jiffies_till_next_fqs=3, root ->qsmask 0x0
[ 1660.539448][    C0] rcu: rcu_preempt kthread starved for 105002 jiffies! g47729 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
[ 1660.539448][    C0] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[ 1660.539448][    C0] rcu: RCU grace-period kthread stack dump:
[ 1660.539448][    C0] task:rcu_preempt     state:R  running task     stack:14320 pid:12    ppid:2      flags:0x00004000
[ 1660.539448][    C0] Call Trace:
[ 1660.539448][    C0]  <TASK>
[ 1660.539448][ C0] __schedule (kernel/sched/core.c:5381 kernel/sched/core.c:6710) 
[ 1660.539448][ C0] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6787 (discriminator 1)) 
[ 1660.539448][ C0] schedule_timeout (include/linux/timer.h:200 kernel/time/timer.c:2168) 
[ 1660.539448][ C0] ? __next_timer_interrupt (kernel/time/timer.c:2091) 
[ 1660.539448][ C0] rcu_gp_fqs_loop (kernel/rcu/tree.c:1613 (discriminator 13)) 
[ 1660.539448][ C0] rcu_gp_kthread (kernel/rcu/tree.c:1815) 
[ 1660.539448][ C0] ? rcu_gp_fqs_loop (kernel/rcu/tree.c:1787) 
[ 1660.539448][ C0] kthread (kernel/kthread.c:391) 
[ 1660.539448][ C0] ? kthread_complete_and_exit (kernel/kthread.c:342) 
[ 1660.539448][ C0] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[ 1660.539448][    C0]  </TASK>
[ 1660.539448][    C0] rcu: Stack dump where RCU GP kthread last ran:
[ 1660.539448][    C0] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       TN 6.5.0-rc1-00129-g3d22d912bd03 #1
[ 1660.539448][ C0] RIP: 0010:_raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
[ 1660.539448][ C0] Code: 5e 12 ff 81 e3 00 02 00 00 74 05 e8 12 96 1a ff 9c 58 0f ba e0 09 73 05 e8 97 4a ff ff 48 85 db 74 01 fb 65 ff 0d d3 c8 17 7e <75> 05 0f 1f 44 00 00 5b 41 5c 5d c3 f3 0f 1e fa 55 48 89 e5 53 48
All code
========
   0:	5e                   	pop    %rsi
   1:	12 ff                	adc    %bh,%bh
   3:	81 e3 00 02 00 00    	and    $0x200,%ebx
   9:	74 05                	je     0x10
   b:	e8 12 96 1a ff       	callq  0xffffffffff1a9622
  10:	9c                   	pushfq 
  11:	58                   	pop    %rax
  12:	0f ba e0 09          	bt     $0x9,%eax
  16:	73 05                	jae    0x1d
  18:	e8 97 4a ff ff       	callq  0xffffffffffff4ab4
  1d:	48 85 db             	test   %rbx,%rbx
  20:	74 01                	je     0x23
  22:	fb                   	sti    
  23:	65 ff 0d d3 c8 17 7e 	decl   %gs:0x7e17c8d3(%rip)        # 0x7e17c8fd
  2a:*	75 05                	jne    0x31		<-- trapping instruction
  2c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  31:	5b                   	pop    %rbx
  32:	41 5c                	pop    %r12
  34:	5d                   	pop    %rbp
  35:	c3                   	retq   
  36:	f3 0f 1e fa          	endbr64 
  3a:	55                   	push   %rbp
  3b:	48 89 e5             	mov    %rsp,%rbp
  3e:	53                   	push   %rbx
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	75 05                	jne    0x7
   2:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   7:	5b                   	pop    %rbx
   8:	41 5c                	pop    %r12
   a:	5d                   	pop    %rbp
   b:	c3                   	retq   
   c:	f3 0f 1e fa          	endbr64 
  10:	55                   	push   %rbp
  11:	48 89 e5             	mov    %rsp,%rbp
  14:	53                   	push   %rbx
  15:	48                   	rex.W
[ 1660.539448][    C0] RSP: 0000:ffff88810038fb20 EFLAGS: 00000246
[ 1660.539448][    C0] RAX: 0000000000000002 RBX: 0000000000000200 RCX: 000001829fdcdc01
[ 1660.539448][    C0] RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffffffff82075cdb
[ 1660.539448][    C0] RBP: ffff88810038fb30 R08: 000001829fdce0a9 R09: 00000000bf076f6e
[ 1660.539448][    C0] R10: 0000000071314968 R11: 0000000068a51dbd R12: ffffffff837adc28
[ 1660.539448][    C0] R13: ffff88810038fb78 R14: ffff88810038fc34 R15: 0000000000000004
[ 1660.539448][    C0] FS:  0000000000000000(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
[ 1660.539448][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1660.539448][    C0] CR2: ffff88843ffff000 CR3: 000000000323b000 CR4: 00000000000406f0
[ 1660.539448][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1660.539448][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1660.539448][    C0] Call Trace:
[ 1660.539448][    C0]  <IRQ>
[ 1660.539448][ C0] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 1660.539448][ C0] ? dump_cpu_task (kernel/sched/core.c:11472) 
[ 1660.539448][ C0] ? rcu_check_gp_kthread_starvation (kernel/rcu/tree_stall.h:549) 
[ 1660.539448][ C0] ? print_other_cpu_stall (kernel/rcu/tree_stall.h:652 (discriminator 3)) 
[ 1660.539448][ C0] ? rcu_sched_clock_irq (kernel/rcu/tree_stall.h:783 kernel/rcu/tree.c:3863 kernel/rcu/tree.c:2241) 
[ 1660.539448][ C0] ? update_process_times (arch/x86/include/asm/preempt.h:27 kernel/time/timer.c:2073) 
[ 1660.539448][ C0] ? tick_sched_handle+0x45/0x54 
[ 1660.539448][ C0] ? tick_sched_timer (kernel/time/tick-sched.c:1492) 
[ 1660.539448][ C0] ? tick_sched_do_timer (kernel/time/tick-sched.c:1479) 
[ 1660.539448][ C0] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1690 kernel/time/hrtimer.c:1752) 
[ 1660.539448][ C0] ? hrtimer_interrupt (kernel/time/hrtimer.c:1817) 
[ 1660.539448][ C0] ? __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1116) 
[ 1660.539448][ C0] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1109 (discriminator 14)) 
[ 1660.539448][    C0]  </IRQ>
[ 1660.539448][    C0]  <TASK>
[ 1660.539448][ C0] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
[ 1660.539448][ C0] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 1660.539448][ C0] ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
[ 1660.539448][ C0] crng_make_state (drivers/char/random.c:343) 
[ 1660.539448][ C0] _get_random_bytes (drivers/char/random.c:386) 
[ 1660.539448][ C0] get_random_u32 (drivers/char/random.c:532 (discriminator 13)) 
[ 1660.539448][ C0] __get_random_u32_below (drivers/char/random.c:557) 
[ 1660.539448][ C0] get_random_u32_below (include/linux/random.h:91) 
[ 1660.539448][ C0] get_rcw_we (lib/reed_solomon/test_rslib.c:187 (discriminator 1)) 
[ 1660.539448][ C0] ex_rs_helper (lib/reed_solomon/test_rslib.c:277 lib/reed_solomon/test_rslib.c:331) 
[ 1660.539448][ C0] ? vprintk_emit (kernel/printk/printk.c:2312 (discriminator 3)) 
[ 1660.539448][ C0] test_rslib_init (lib/reed_solomon/test_rslib.c:360 lib/reed_solomon/test_rslib.c:475 lib/reed_solomon/test_rslib.c:494) 
[ 1660.539448][ C0] ? crc64_rocksoft_mod_init (lib/reed_solomon/test_rslib.c:488) 
[ 1660.539448][ C0] do_one_initcall (init/main.c:1232) 
[ 1660.539448][ C0] kernel_init_freeable (init/main.c:1293 init/main.c:1310 init/main.c:1329 init/main.c:1546) 
[ 1660.539448][ C0] ? rest_init (init/main.c:1429) 
[ 1660.539448][ C0] kernel_init (init/main.c:1439) 
[ 1660.539448][ C0] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[ 1660.539448][    C0]  </TASK>
[ 1661.397796][    T1]   Testing with caller provided syndrome...
[ 1673.580986][    T1]   Testing in-place interface...
[ 1686.021233][    T1] Testing beyond error correction capacity...


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230908/202309081258.8d57032f-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

