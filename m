Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0EA7CB752
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjJQAXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjJQAXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:23:24 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4BE93;
        Mon, 16 Oct 2023 17:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv9TQtPQpymPJ83/fgQHGSDlV+X3nMSgLzqs2jpKV8BKPzfok7YIxLgzFKg5FA4X6NctXoxX0e5oHFa4EFOpyTVNZXWZMlQqYUBB6BLE3cx33yYGfAjgRJmC8z2VKF81a/2ME3AaSSckQEocQzGo0oKlZi3Z5V7lA5k/n77NtAD2SLeyqV7yjz/80oUq8UG9ahbw0S+zO1hJcJxDvYRTIo9FMPoyo8gabVOdgQDKlFCocXVf/WbTnj/ot/PJ4E+tAc1sU13TYTFuiMMUFddEziTD1+pFd0r7RyMoiOXl9ulI1gFgT0toXsX/vnH3UQsqIPM61aX5c3/YwJsZRonA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqOweiFK9S3qnV6eT9f8+sRdccwE56bvEB0dqSk/sS8=;
 b=mb5EtqUlUE+9AribpMLKt9R37Yei3+GNkZtwoQfMWK4efqOhyzhACPCsIQu+r+EYYDGHcY/ILLHPbR7tzQqs/m54YkM4rMat3jSMl2m41HnK1uE449A1DbXWky3jCj12YMeufwZYxBLz+icgmWfb3U1c1pE82vXDwXF6tybzoWWQXLy5Jwncb3PRjvH8EwkFiwS0IHlxTYqGcko3zICKPFyeunOI6E2Rnt9Mbg+sYiRJvPYvxuZBWPMxMX/VV7BkcbWfgZWS+yi7pWROldik/jIQvc63S7bnryviOImxj40ZjOJ2d5uc4l93EkvaKfgZddSpaVm+CX5I6PiqOgSuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqOweiFK9S3qnV6eT9f8+sRdccwE56bvEB0dqSk/sS8=;
 b=20RJj74wsBZe4qLSef9RcOGS6rdI0dKdyZ+40jh95fQbnrRFg7iAXJwtY5PsHVA0bI+IDKIrZmZaUv+up5nMYpwce2gYzfhMGW5f9LeYqaxIQkXY7OVPugrvDTlg/z+/92Gt5vLWNu5tbMjbQxJu/DbpvNVTMQgEq4fhpQkdS08=
Received: from BY3PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:39b::7)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 17 Oct
 2023 00:23:17 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::13) by BY3PR05CA0032.outlook.office365.com
 (2603:10b6:a03:39b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.16 via Frontend
 Transport; Tue, 17 Oct 2023 00:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 00:23:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 19:23:14 -0500
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
Subject: [PATCH v14 0/9] x86/resctrl: Miscellaneous resctrl features
Date:   Mon, 16 Oct 2023 19:22:59 -0500
Message-ID: <20231017002308.134480-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: e52a0370-5ac7-4e22-726a-08dbcea7422c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Veab+P5hHFMdcJZtJP7epg4JDs8TDFpuBP3zsp7GN6zFDeFm/Ex6Gt1qie+wFopU8KG7XfET/fjlm7oWgeiWzhN7JoV2A/+H0iraeolASddObOq9dT9tRcEnAORhNak7dLGfE34JY2xlCQEJXy2vMi28+m45YMck7BHnqjq201vU9ZAr2Z1NfGqWoj30FQzFb4hbnplaRxTr7o1i5pMrxzBc8Pv5+4jai99VVtsQqHz7hW6d1uY3mGDrew3mqGLqUdyQ/NezJbtkZ1SvJBlB/aI/5lrCjV6XCfDIqFevvzjBjSRdYuCd/hCU9R0tIq+9qd0cqkpVb0PLC3IGWqzRGr95iwMark2XBog2qeVy0dg82E6TRxqd11XMpfgDFv78dviDmuHhmBRA5TLv/GDBHZnGxfe8vS6Usew9lJxlbGy51St+xyanuOKnSJNf9lTankQK/d8xTGTNM9WaZDLJ+m5LrAQJiyk5JxK5ADahfbqbD9K/7BAoa+HBvxAlSiqpUohAhxHukbGQ2fKHDXKHy3pkDL9LUvyFAYB62YATe6Ucpj/urmxw1UuWr1S8oQvIA0C2MHyKqfiuiLJJzGrBUPU5PwcZJkb2Ormh3NVwzI2gmZSFx1nbZ3YYxMHZF8J5WUza9AKSuJAmoi3RO31lJSSu1ADdN3IJa+aRAk0fcBuFmXFq1Xq68n6IJWYX9wsNqVE3A3D6CO0SYRvajKsWrk+diRB/Vk5HdJI1ouDOjuYwvUB5YTY0QMVm4QaD8J34KXr+c+MYe3txlxgdyg3V1/+rTv4lYjApYZXwFPwMw8U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(40460700003)(336012)(426003)(36860700001)(1076003)(2616005)(16526019)(316002)(47076005)(83380400001)(7416002)(7406005)(8676002)(110136005)(4326008)(54906003)(70586007)(8936002)(70206006)(81166007)(41300700001)(966005)(44832011)(6666004)(5660300002)(478600001)(2906002)(7696005)(82740400003)(356005)(40480700001)(86362001)(36756003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 00:23:16.6564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e52a0370-5ac7-4e22-726a-08dbcea7422c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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
   They were named inconsistently. Re-arranged them much more cleanly now.
---
v14:
   Boris asked me to remove the doc changes for now. So, removed the RFTYPE
   flag documentation from resctrl.rst file. (Boris)
   So, patch 4 from v13 is removed. Now series has 9 patches.
   Patch 7,10 are updated accordingly to remove doc changes.
   No other code changes.

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

v13:https://lore.kernel.org/lkml/20231013202602.2492645-1-babu.moger@amd.com/
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

Babu Moger (9):
  x86/resctrl: Add multiple tasks to the resctrl group at once
  x86/resctrl: Simplify rftype flag definitions
  x86/resctrl: Rename rftype flags for consistency
  x86/resctrl: Unwind the errors inside rdt_enable_ctx()
  x86/resctrl: Move default group file creation to mount
  x86/resctrl: Introduce "-o debug" mount option
  x86/resctrl: Display CLOSID for resource group
  x86/resctrl: Add support for the files for MON groups only
  x86/resctrl: Display RMID of resource group

 Documentation/arch/x86/resctrl.rst     |  22 ++-
 arch/x86/kernel/cpu/resctrl/internal.h |  22 +--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 255 ++++++++++++++++++-------
 3 files changed, 216 insertions(+), 83 deletions(-)

-- 
2.34.1

