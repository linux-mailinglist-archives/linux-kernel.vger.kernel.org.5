Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AFE7C8E40
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjJMU0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjJMU0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:26:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0361283;
        Fri, 13 Oct 2023 13:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dN8rOZQ7ToWTWdHQTA2ypVoE2SbwYBso7/cSOYD/zCl9YSWjzbTkvn0zSKOZmPIqdILSbBKcaZ4BCsSCov5Pg0HqO5oZZ7jPOgbZHGE851MBHoaGDn8Jt6L+lq5qEXH8/vBzDe0N2xzOGV4flbIdiinvZv9JxhLcnGWkSBBssN84JMujrig8wySECP6rhlfIie7njHJ4WF1J52E+Mh6+pneRAIGjR60qiplr3f6fTIzoFU8SzhjmH8goB5O1CEMZ9kVmuSTs63mbQ9+VF/B5HHAUaSWYkE5giJNjp6uXOZNAijMr33OpibXXewOUkiiFX3PpymshbJOuFFCq2tx5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QejpP/9FZZsp9Wg0sp3EXnndOTKgQTIeleOe0K6AyA=;
 b=SpKzEut9urZwxZ1fqGe/ZbRSkj1r0ejgEzzbJgd0+pzsSNeTX9QlbtYIXQc4cZW+5DeiZ/HJzXLroQb3X+jsISfi2PuiPo+7wjrNYmkO/SiBTl0mE4+UPO8uTml+SXYtCvHhJ/m3pm9etk0MZf1pfx4xKOfa39irePfMa71x9vLYf7wcXQQKsGqhu/sL0g2d/xwUuO3Yxp2j26r8Xc2oR8xxRCPU0sfjdGgmw9fR02yKCLgfTx0VQwK7WhuVVD+L6Ii7H04aIH4NAzgdDy/y73DpblUiisw0GJoxzLv9aUmiYbPGBKJlkn4r2MItOZE3TkhtNB4rFPXhc31lvDiZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QejpP/9FZZsp9Wg0sp3EXnndOTKgQTIeleOe0K6AyA=;
 b=cMWGxUrHnRa3FQwBCi1MZd4s4jvB9w9oB+wo1tEQ0ekkspBXKHGizonZo0Rcm4n2VbKjUmgIosJguz9tU0u2ZB28qLY9NgcOO589LeDzAUZd0OTJs/CqLIausXAERsQwtlxw+y763xmdFckdu/usoqXmV6ggkRPbs6ULYrkcTms=
Received: from DS7PR07CA0023.namprd07.prod.outlook.com (2603:10b6:5:3af::28)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 20:26:13 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::33) by DS7PR07CA0023.outlook.office365.com
 (2603:10b6:5:3af::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 20:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 20:26:12 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 15:26:08 -0500
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
Subject: [PATCH v13 00/10] x86/resctrl: Miscellaneous resctrl features
Date:   Fri, 13 Oct 2023 15:25:52 -0500
Message-ID: <20231013202602.2492645-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 8542c86e-6363-49ce-9f9f-08dbcc2aa4eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEIsdjZNPmZqqKiwi/UgOAtQV/Un6yEkaGogTV9jdHm5qx57Uz7FQx4C8L/4gwsbRtMXuxwtSS/Ew4eQHND29KHE+FX2FXRp1iC/k88xsQtCG3guH7K8FCHsj3ZX0tu8EPHwhQSadZFSx0JaNPbbcX8RUqvi6jp/FokzZOfjbJ3E4W7xHtKK1Y3y00Z9d4pLXsSokti79ps4f5qhcoe3um2Fd+D+9GPU8b2ayPh73If2s60hXoGLezqQtJEUnMplau/I8s04WLFGx6ZCfwQZJ54quJBQy6CeJvdDUZl+ecIHqWFH/Xiuvuw0qs6qpiEtn3euPx1qW5GyRSD8SmWuh5iOARWb297vPpiYRA3qAr6l6jcqYuM0+dh9phCS6V99XJW5OHIBRA7DcPta+Sofsb7ErMPBVtI3Iy53d5LE5CjaT/1G7QEA/yD268rY5+6LFQU+wh/fBM8Tcq1YBx58rsncdqJ5Byv2bt5CXpKt/1wHi3utf0FZIGkq0bRczVKdfXITTMoaKvH7dTymgSkELJ0NVkNagqzzfsQKpHacJTWTKUknA5vejmwVQ16Sdccfrt/KmOFAfQxSzPsAPhuE2erS65kdB/sNdpDPlkwFt9QuBF/Py3f5MKFAGrj8zCP8MNnmrzAKgMvk0stMypLDQN3NXw3zoZryWtavnWpS0h4USCTfpipXJRnrPVmJb9XJrmlxE318r8r05iioVr3167EXZ5Ost85KtCzjC+Yu8pEyz2m1j4dV2v7AcNTKzprmjWX91y48KPvEVPzyvZ9XwWt4Zuq5lsr1hOds0LwhAlo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(36756003)(47076005)(83380400001)(40460700003)(316002)(54906003)(110136005)(356005)(8676002)(70586007)(82740400003)(81166007)(86362001)(8936002)(36860700001)(40480700001)(70206006)(4326008)(44832011)(2616005)(7696005)(7406005)(41300700001)(6666004)(2906002)(7416002)(966005)(426003)(5660300002)(336012)(1076003)(16526019)(478600001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 20:26:12.9873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8542c86e-6363-49ce-9f9f-08dbcc2aa4eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series adds support few minor features.
1. Support assigning multiple tasks to control/mon groups in one command.
2. Add debug mount option for resctrl interface.
3. Add RMID and CLOSID in resctrl interface when mounted with debug option.
4. Moves the default control group creation during the mount instead of during init.
5. Added support for the files for MON groups only
6. While doing these above changes, found that rftype flags needed some cleanup.
   They were named inconsistently. Re-arranged them much more cleanly now and added
   few comments. Hope it can help future additions.
---
v13:
   Pardon me for sending two versions in a week. Hoping to get this series
   in v6.7 kernel.
   Rebased on top of Maciej patches. Resolved the conflict.
   https://lore.kernel.org/lkml/0eb67a16-971f-4e5c-9c9c-9ae7902866b7@intel.com/
   Resolved the documentation syntax issues. Needed few format changes.
   This version is mostly for doc and commit message changes.
   
v12:
   Most of the changes are related commit messages and code comments.
   Moved the comments in arch/x86/kernel/cpu/resctrl/internal.h
   to Documentation/arch/x86/resctrl.rst. (Boris)
   Removed the text "Later patch' from commit message and moved the
   text to the patch related to that changes. (Boris)
   Added change log to each patch. (Fenghua)
   
v11:
   Patches 1-2: No changes. Added Reviewed-by and fixed tag order. Fixed
                the tag order for all the patches.
   Patch 3: Corrected the commit messages about RFTYPE_MON_BASE.
   Patch 4: Removed only from the text "Files only for CTRL group" in internal.h.
   Patches 5-8: No changes.
   Patch 9: Commit message change (Reinette). This patch needs Reviewed-by from
            Reinette. Rest all have it already.
   Patch 10: Removed only from the text "Files for MON group" in internal.h.(Peter)

v10:
   Patches 1-2: no code changes. Added "Reviewed-by" from Fenghua.
   Patch 3: Added the new flag RFTYPE_MON_BASE [comment for Reinette].
            Removed the Reviewed as the patch has changed.
   patch 4: No code change.  Added "Reviewed-by" from Fenghua.
   Patch 5: Removed empty lines in rdt_disable_ctx().
   Patch 6: No changes. Added "Reviewed-by".
   Patch 7: No changes.
   Patch 8: No changes.
   Patch 9: New patch. Added support for the files for MON groups only.
   Patch 10: Modified. This patch only adds changes for "mon_hw_id" interface.
v9:
   Changes since v8:
   Split the RMID display in a separate patch. RMID is a special case here as it
   should be printed only if monitoring is enabled.
   Made rdtgroup_setup_root and rdtgroup_destroy_root as static functions.
   Added code to print pid_str in case of task parse error.
  
v8:
   Changes since v7:
   Earlier moved both default group initialization and file creation on mount.
   Now kept the group initialization as is and only moved the file creation on mount.
   Re-organized the RFTYPE flags comments little more to avoid confusion. Thanks
   to Reinette for feedback.
   Re-factored the rdt_enable_ctx and added rdt_disable_ctx to unwind the errors.
   And same call also used in rdt_kill_sb which simplifies the code.
   Few other minor text changes.
   
v7:
   Changes since v6:
   While moving the default group file creation on mount, I also moved the
   initialization of default group data structures. Reinette suggested to move
   only the filesystem creation and keep the group initialization as is. Addressed it now.
   Added a new function rdt_disable_ctx to unwind the context related features.
   Few other minor text changes.

v6:
   Changes since v5:
   Moved the default group creation during mount instead of kernel init.
   The rdt_root creation moved to rdt_get_tree as suggested by Reinette.
   https://lore.kernel.org/lkml/8f68ace7-e05b-ad6d-fa74-5ff8e179aec9@intel.com/
   Needed to modify rdtgroup_setup_root to take care of this.
   Re-arraged the patches to move the default group creation earlier.
   Others are mostly text changes and few minor changes.
   Patches are based on tip/master commit 1a2945f27157825a561be7840023e3664111ab2f

v5:
   Changes since v4:
   Moved the default group creation during mount instead of kernel init.
   Tried to address most of the comments on commit log. Added more context and details.
   Addressed feedback about the patch4. Removed the code changes and only kept the comments.
   I am ok to drop patch4. But I will wait for the comment on that.
   There were lots of comments. Hope I did not miss anything. Even if I missed, it is
   not intentional. 

v4: Changes since v3
    Addressed comments from Reinette and others.
    Removed newline requirement when adding tasks.
    Dropped one of the changes on flags. Kept the flag names mostly same.
    Changed the names of closid and rmid to ctrl_hw_id and mon_hw_id respectively.
    James had some concerns about adding these files. Addressed it by making these
    files x86 specific.
    Tried to address Reinette's comment on patch 7. But due to current code design
    I could not do it exact way. But changed it little bit to make it easy debug
    file additions in the future.  

v3: Changes since v2
    Still waiting for more comments. While waiting, addressed few comments from Fenghua.
    Added few more texts in the documentation about multiple tasks assignment feature.
    Added pid in last_cmd_status when applicable.
    Introduced static resctrl_debug to save the debug option.
    Few minor text changes.
  
v2: Changes since v1
  a. Removed the changes to add the task's threads automatically. It required
     book keeping to handle the failures and gets complicated. Removed that change
     for now.
  b. Added -o debug option to mount in debug mode(comment from Fenghua)
  c. Added debug files rmid and closid. Stephane wanted to rename them more
     generic to accommodate ARM. It kind of loses meaning if is renamed differently.
     Kept it same for now. Will change if he feels strong about it. 

v12:https://lore.kernel.org/lkml/20231010233335.998475-11-babu.moger@amd.com/
v11:https://lore.kernel.org/lkml/6102a5e9-ffec-5499-c27a-3c0a3443f792@amd.com/
v10:https://lore.kernel.org/lkml/20230915224227.1336967-1-babu.moger@amd.com/
v9: https://lore.kernel.org/lkml/20230907235128.19120-1-babu.moger@amd.com/
v8: https://lore.kernel.org/lkml/20230821233048.434531-1-babu.moger@amd.com/
v7: https://lore.kernel.org/lkml/169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu/
v6: https://lore.kernel.org/lkml/168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu/
v5: https://lore.kernel.org/lkml/168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu/
v4: https://lore.kernel.org/lkml/168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu/
v3: https://lore.kernel.org/lkml/167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu/
v2: https://lore.kernel.org/lkml/167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu/
v1: https://lore.kernel.org/lkml/167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu/

Babu Moger (10):
  x86/resctrl: Add multiple tasks to the resctrl group at once
  x86/resctrl: Simplify rftype flag definitions
  x86/resctrl: Rename rftype flags for consistency
  x86/resctrl: Add comments on RFTYPE flags hierarchy
  x86/resctrl: Unwind the errors inside rdt_enable_ctx()
  x86/resctrl: Move default group file creation to mount
  x86/resctrl: Introduce "-o debug" mount option
  x86/resctrl: Display CLOSID for resource group
  x86/resctrl: Add support for the files for MON groups only
  x86/resctrl: Display RMID of resource group

 Documentation/arch/x86/resctrl.rst     |  97 +++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h |  22 +--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 255 ++++++++++++++++++-------
 3 files changed, 291 insertions(+), 83 deletions(-)

-- 
2.34.1

