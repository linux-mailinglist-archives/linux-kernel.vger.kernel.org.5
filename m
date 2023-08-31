Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530B578EABF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345153AbjHaKqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240404AbjHaKqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:46:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE4710D1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRtqyBAnReR3yX4IjZfbvsP+l0MWGaqSTTyR62NwbyZGm4tEigtWWalYBfVtxiu0JOZaU4LPta5CB0wnhV+ubVgRgK+fVRC80sACrrjuvdgjrfpb/Ky3KtjsyuWhSo38W+cY6kURYQLeelX2iN3z060Zh596/ZXcY+bnH7peKlYUETcmyjhSYpuY+Ydt0ETeRdc/uUP/4H/7O+Go4sSAvcRKYhWG7EIj3GfCeppy+YkH7G4W+JsEQOyVp96IpKhKEtZit3YdqLZp6yt6V89AyquEZARlVawUJR7E7nhNloXgoWpxKZ/ihHrKidjT5FEpWszYGHn0Uj3i8VaOHXig1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUJonmo0l0s5+7g2+fPjmCtFvJaACXdBD2IanLfvkVY=;
 b=T48AIo2bEdPGbApgdmBm5sXw6PdUBJFSc2Zve/jWFineLlb3vELIx51tLWTYUIc5bpBi0r9yig0bo81QmOWtuAKL+ribjKWivqp7tA/QBKKsc9ENLlyjynmAHZ2TSgWMiTJTbxUZfslYyZBhkBpTBpbEWWJZ1ali6zRGLXxx+gbEGBfctwZmkdfWhEXQMnCF+ZA4Lnz5o+W9m4Fyu6nP8XrjYfisle+pPCjbg0AAowhGYRo2pvGoCbqZYFot/bdS5gncN+daW6q0YikiEWaL+l7x07GV5VZG3p6KirVJEa76qAll6SkjHHsemmG5uXivs6fFm8gjZvsTycSuRoPa+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=manifault.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUJonmo0l0s5+7g2+fPjmCtFvJaACXdBD2IanLfvkVY=;
 b=Z3sIHBKufvJFi2ivXOmkIgJvtENSObjwn/IyMfIheOnQvvgzld/cKbIwWcax6nH61TgtWgOs1lUlgVIWoEuXnmtYqO4SFoZ8AY9SPgft3hHGKozH1P85x3IOEq5X31XdDNVLdNQMPNiGuJaKZ0mIEcr194mQzRXJ0WYNRjTf68w=
Received: from SA9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::29)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 10:45:23 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::e7) by SA9P221CA0024.outlook.office365.com
 (2603:10b6:806:25::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21 via Frontend
 Transport; Thu, 31 Aug 2023 10:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 10:45:23 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 05:45:16 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <void@manifault.com>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <tj@kernel.org>,
        <roman.gushchin@linux.dev>, <gautham.shenoy@amd.com>,
        <aaron.lu@intel.com>, <wuyun.abel@bytedance.com>,
        <kernel-team@meta.com>, <kprateek.nayak@amd.com>
Subject: [RFC PATCH 0/3] DO NOT MERGE: Breaking down the experimantal diff
Date:   Thu, 31 Aug 2023 16:15:05 +0530
Message-ID: <20230831104508.7619-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 145ce473-8bfd-4a95-194f-08dbaa0f6112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/vuze3gUVRTzFxm3jRkpVaRAFrd+foiujGYmZQ/I+KEmdvL6nA3QDcgKlFhZJpdMw0C4xioEENsJ0F/MCyAghhia1thypTvakYbHmHv6th3cTo9q4ARGjnV/5SU74hiZzJFQyiLP9VuQ+Tt/yiZrHhzMWYLlYXXutCPK5gE/NwV07TKYR9ErrwzJmy4ThppKqADY8h2RjDhpAYL+l1NtgyOQkgQqYxZ1m2ttzEb2/eSfnu7XXV+1dmBSEtW3uCEINR49lAq7GxzNVFKkBew7F6MI/Jr/UEFZhMNU2Q4BBMkoG1z9UT0slVJwDVhGRE3O099ug+Oqv2gg1GAMEE6/7QIpaieS7qT+al+VOC/6f/npH+5N46vcyPZCZgsr3dEingPimRq+vdke6VRnpXtHgj3AVOwH1LiMT59B1maICu9dfKs/bxZ2lVSCCBpQEvQwUD7BBzKazoMdbunPdwO6KTFc/lFtMSCXI4BBCQBu3MZ7wPmCe7gY5CqIjg3FB7dsP65A3o1lzvL8yoyJ49L4mPGmxV5t34Ov5nf4J8y+bGvWZ2nXCgpwLJQxShCQ9w5/aB+4DzxodC7bzqZdz27fX8Ycahpdc1FrZ31MqPYOP0Kj6dUzrXFb9WY9ntp/DyVtTyOaPCtNvjqr/0Dcikdwn3kC9ZroxxcvXMQ8r+a/nRpEz7VEJ3OARdaAEmb/fsEzz5c1W7POvMvBZ7Hvj+hYbiUOSnQ/ud7V/AFDTX2ttmkuzFC5eELX8ByFeZmqCVHt8RwdqWXfRjSW24iBAhHPcFV2pSkQyXEpwTS5KKuCNo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199024)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(7416002)(40480700001)(83380400001)(4326008)(5660300002)(41300700001)(8676002)(8936002)(7696005)(86362001)(6666004)(16526019)(26005)(1076003)(336012)(426003)(36860700001)(47076005)(2616005)(82740400003)(478600001)(356005)(966005)(2906002)(81166007)(70206006)(316002)(54906003)(6916009)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 10:45:23.2395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 145ce473-8bfd-4a95-194f-08dbaa0f6112
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the diff is a concoction of a bunch of things that somehow work,
this series tries to clean it up. I've lost a bunch of things based on
David's suggestion [1], [2] and added some new logic on top that is
covered in Patch 3.

Breakdown is as follows:

- Patch 1 moves struct definition to sched.h

- Patch 2 is the above diff but more palatable with changes based on
  David's comments.

- Patch 3 adds a bailout mechanism on top, since I saw the same amount
  of regression with Patch2.

With these changes, following are the results for tbench 128-clients:

tip				: 1.00 (var: 1.00%)
tip + v3 + series till patch 2	: 0.41 (var: 1.15%) (diff: -58.81%)
tip + v3 + full series		: 1.01 (var: 0.36%) (diff: +00.92%)

Disclaimer: All the testing is done hyper-focused on tbench 128-clients
case on a dual socket 3rd Generation EPYC system (2 x 64C/128T). The
series should apply cleanly on top of tip at commit 88c56cfeaec4
("sched/fair: Block nohz tick_stop when cfs bandwidth in use") + v3 of
shared_runq series (this series)

The SHARED_RUNQ_SHARD_SZ was set to 16 throughout the testing since that
maches the sd_llc_size on the system.

P.S. I finally got to enabling lockdep and I saw the following splat
early during the boot but nothing after (so I think everything is
alright?):

  ================================
  WARNING: inconsistent lock state
  6.5.0-rc2-shared-wq-v3-fix+ #681 Not tainted
  --------------------------------
  inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
  swapper/0/1 [HC0[0]:SC0[0]:HE1:SE1] takes:
  ffff95f6bb24d818 (&rq->__lock){?.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x15/0x30
  {IN-HARDIRQ-W} state was registered at:
    lock_acquire+0xcc/0x2c0
    _raw_spin_lock_nested+0x2e/0x40
    scheduler_tick+0x5c/0x350
    update_process_times+0x83/0x90
    tick_periodic+0x27/0xe0
    tick_handle_periodic+0x24/0x70
    timer_interrupt+0x18/0x30
    __handle_irq_event_percpu+0x8b/0x240
    handle_irq_event+0x38/0x80
    handle_level_irq+0x90/0x170
    __common_interrupt+0x4f/0x110
    common_interrupt+0x7f/0xa0
    asm_common_interrupt+0x26/0x40
    __x86_return_thunk+0x0/0x40
    console_flush_all+0x2e3/0x590
    console_unlock+0x56/0x100
    vprintk_emit+0x153/0x350
    _printk+0x5c/0x80
    apic_intr_mode_init+0x85/0x110
    x86_late_time_init+0x24/0x40
    start_kernel+0x5e1/0x7a0
    x86_64_start_reservations+0x18/0x30
    x86_64_start_kernel+0x92/0xa0
    secondary_startup_64_no_verify+0x17e/0x18b
  irq event stamp: 65081
  hardirqs last  enabled at (65081): [<ffffffff857723c1>] _raw_spin_unlock_irqrestore+0x31/0x60
  hardirqs last disabled at (65080): [<ffffffff857720d3>] _raw_spin_lock_irqsave+0x63/0x70
  softirqs last  enabled at (64284): [<ffffffff848ccb7b>] __irq_exit_rcu+0x7b/0xa0
  softirqs last disabled at (64269): [<ffffffff848ccb7b>] __irq_exit_rcu+0x7b/0xa0
 
  other info that might help us debug this:
   Possible unsafe locking scenario:
 
         CPU0
         ----
    lock(&rq->__lock);
    <Interrupt>
      lock(&rq->__lock);
 
   *** DEADLOCK ***
 
  1 lock held by swapper/0/1:
   #0: ffffffff8627eec8 (sched_domains_mutex){+.+.}-{4:4}, at: sched_init_smp+0x3f/0xd0
 
  stack backtrace:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc2-shared-wq-v3-fix+ #681
  Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
  Call Trace:
   <TASK>
   dump_stack_lvl+0x5c/0x90
   mark_lock.part.0+0x755/0x930
   ? __lock_acquire+0x3e7/0x21d0
   ? __lock_acquire+0x2f0/0x21d0
   __lock_acquire+0x3ab/0x21d0
   ? lock_is_held_type+0xaa/0x130
   lock_acquire+0xcc/0x2c0
   ? raw_spin_rq_lock_nested+0x15/0x30
   ? free_percpu+0x245/0x4a0
   _raw_spin_lock_nested+0x2e/0x40
   ? raw_spin_rq_lock_nested+0x15/0x30
   raw_spin_rq_lock_nested+0x15/0x30
   update_domains_fair+0xf1/0x220
   sched_update_domains+0x32/0x50
   sched_init_domains+0xd9/0x100
   sched_init_smp+0x4b/0xd0
   ? stop_machine+0x32/0x40
   kernel_init_freeable+0x2d3/0x540
   ? __pfx_kernel_init+0x10/0x10
   kernel_init+0x1a/0x1c0
   ret_from_fork+0x34/0x50
   ? __pfx_kernel_init+0x10/0x10
   ret_from_fork_asm+0x1b/0x30
  RIP: 0000:0x0
  Code: Unable to access opcode bytes at 0xffffffffffffffd6.
  RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
   </TASK>

References:

[1] https://lore.kernel.org/all/20230831013435.GB506447@maniforge/
[2] https://lore.kernel.org/all/20230831023254.GC506447@maniforge/

-- 
Thanks and Regards,
Prateek

