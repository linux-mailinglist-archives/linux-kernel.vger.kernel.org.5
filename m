Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0392E7C457B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbjJJXdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJJXdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:33:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345D899;
        Tue, 10 Oct 2023 16:33:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMV5JXJwwpXYR+bVlQAfxiY/5LLNXMwFd32hEQ87IFf0BXyV3UnVmcvHbww7LXpk12yBRzG2I0czJPNg76NK2KHfnp2pE2mVnowRy5tMSmJmIi+v+kjYhHWVlz0fKxUM8znfKaKb+XW0KdD4AxIqmWjir4+qCFA0VilUkvbyCFa1/XCjAXz5/LXDIPgn4Dj73jeV+dSsF7ZAk9WvpJv2YbGWmXH8A1rKs2vVvB3nJL1PkaKiAgyk5MzNtDVxYlyIEPDnoMQ4Ghp6jVf9IE79mWQHNowNbp6eogbnDTVHB5DwSRjZjveayKPFypN6DkWwIrenE7r6qXQQegBNkCVI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Yh00WhN6Ye/r4J58uFN2HH9ae6ZwKDro23/q8AgEn4=;
 b=ftgag/zEo825UY8JA8rXyWVw3lL/fqxc4xuNAd6dtDOdPEmsFVcQwxg9brXEygFbnepTAE+URIj6EOLi2jGEtzdpmV8mLpOL5VKIwUqczm+nCsyXHCy+rIEe5lFV5oHQz3BQeyXiyuTKlwpX/VB1RMgugvGx06gfgpxwqfmQ8xFrNmvfpzrM1JiMHH7f0AQKn25xz8ZCa9fhSoQsMCX83ywEkdgknG1DaegmMIf7EbjFB7GYFxI2bgd7v7bOE/A5EffSpxLr+L9Is9Z7N8jVbKspAQuvmdCC0LS4IM7BKzgiR+NLL5ojmYo9eCYI1gBa4OJq6mczT0ldLxKIrg0gJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Yh00WhN6Ye/r4J58uFN2HH9ae6ZwKDro23/q8AgEn4=;
 b=YKYY5p1Dx8UXehJiD57QkCb5RBfUbIzM8dVEpCXndJ9e7j6aafFiLkcuj01lydIEAgBzAfsrhrf8NWZ1IhlnfN+SUb3im9Ji/l7V8eaJaN5NLPtHwylimm+I3A3Oio6TBzBldxh6PXR2h2huk6P3VO1k8NuILW17VjneKreEXno=
Received: from BL1PR13CA0423.namprd13.prod.outlook.com (2603:10b6:208:2c3::8)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 23:33:43 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::8) by BL1PR13CA0423.outlook.office365.com
 (2603:10b6:208:2c3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Tue, 10 Oct 2023 23:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 23:33:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 18:33:41 -0500
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
Subject: [PATCH v12 00/10] x86/resctrl: Miscellaneous resctrl features
Date:   Tue, 10 Oct 2023 18:33:25 -0500
Message-ID: <20231010233335.998475-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|SJ2PR12MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: 4794be7d-275e-4033-d233-08dbc9e95787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrEKbkA1kvjJ/WmEpaxDk8Z/ahe4aDC0pJTroLSpW/AY6TzCSutwzw2eJ1R+qi3naC1jifg1B7gbrBT/vgz12FfdGGR09YHcx6CrC4NCj+qaIHY2eZb8Txf4uK9bUlTKUe48uX04aPTeMlHpnpZh1Il4eNqwh6t4G/WQzUHYaL51jAoZ0am8lAfd1TZI3tHtwRH9soshw0ktAr/WGvLnvYAAo8Al4+gL6IKCFDq5prQgoCMqqoAzlyPP+nM+5XI0VDAVG4q9ZRdMgEpu6NJ6Y1omVqenGmFkrssvFZb+fgyOMxF8Ho4OsykG4c45FRa7Q4F7VTfCcrTvNIQNARMsQHJvkd7r5Y075kC743CunZNYlwHZabANvAEVvkVZ8izhI2dXIcV+8gb+XcRGhGDsazaZ1jCwBgYfxGptC+DxdJhdfB2pKqwGPwOF/0aFdOkyObwd6hT/Qqeg+wZTYGyrGDLNldxPxVvFt5QCGcmu+r+VaiZuFbZED/7/5fuaa26LpVBLniZFWEwnlIg7F4YOSfvJWrNkfqKdfw1yi9X9YmvNrsNET0H1gbIjbCahHTYArujSj1/43aiEiyX39iJjxdYLr4I76wnBOdmZp5VITng6Gbhy87hUIBRuP+3J2EZ6iSGuPSi1MFV6ZLlru5FeI683bqf/KREOogDYgTicn9DScy3h3ZWLtJouMkReBDMb0E2fRi07oVLnr4yYFvi+uj6B8pMiDIK47sEuqUyCodyL2wJH1CGcio/+/AuRi+TBRI7ynVcjWKwT6e6dHaCq0yDg8SMSA0himIYoR2UBzaQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(426003)(7696005)(966005)(2616005)(478600001)(6666004)(356005)(16526019)(44832011)(47076005)(2906002)(336012)(83380400001)(7416002)(7406005)(54906003)(5660300002)(70586007)(316002)(110136005)(70206006)(8936002)(4326008)(8676002)(41300700001)(82740400003)(26005)(36860700001)(36756003)(81166007)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 23:33:43.5514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4794be7d-275e-4033-d233-08dbc9e95787
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

 Documentation/arch/x86/resctrl.rst     |  90 ++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h |  22 +--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 253 ++++++++++++++++++-------
 3 files changed, 283 insertions(+), 82 deletions(-)

-- 
2.34.1

