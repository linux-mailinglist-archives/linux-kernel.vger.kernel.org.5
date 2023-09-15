Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A587A2A94
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbjIOWnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbjIOWms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:42:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100CE2707;
        Fri, 15 Sep 2023 15:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXupIn+ZCUEy7pK10iQ2Eb32mmytFgZoSo8346UMBMKRc84EqImHe2b3qVMyvRpu7Lzcdf3VR0vZaTqNomGRQ7930OFpKTKczNrPa3hJJfiNczLssDPCetPtlbrRY68ppYXcaVlgsznutsgx104PstHVfKaf+FkocE8nbyDns8SXAwoix0cLFW/n3tO5DY1qkebul2xkd0LiESWEcuUpak218kMW6W+n/D65mgofTLsTNc1N2rOiPc7KSX2+1qC/qiHH1O452tvjkYgJuQhgUY95LbHDrk8xZvVYvJNaMpQncD0u7njgyPTHwiUUiLz58Q63hP8zRxqF1bh41iYpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QVjIdzxao2eyL3lM2f05IM8g8b7VkG8jzkBNwmCk1M=;
 b=cKyzbMIQ3rKmb2+xAl7f1xmy/jURD6guyZA9/HZhG/DklK3paPyfJz+6oM9VjyaSRSjxQzQei5U36ri8gJBVkNELukkoPdevLIlYYjvBsK4Nll7bGaWaBUbC9+Ftpg4wvq+jmlHMmcvb2TosEtoGIjHIzO3qSKvowV6MYTnaRPL339QxmT1o91/6P5/AIfvPmfpbBZk9QTR+HU8ybjpNxRQqOGsvRCH9BYdAXpsuiwmPOMwIDrDjYUXfHBTukk6EbHKuA7nuA4hnJ1h6drE4981G6xdCEOd5ksf0+QMloTltm7/jcqet1c5Yet8a0YxLF8L3+lJ5IdS3DVfeYBxd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QVjIdzxao2eyL3lM2f05IM8g8b7VkG8jzkBNwmCk1M=;
 b=ZXRexcqt9vGRPyK26I7KlJbAWLzy+nIDNpdDPN4d3kmo0CxQ4fp5FSlhoUWIlUxLI3PI7KYVUzFpNe2vydN+AzwVAPgFL7qOvFMNyaTHIa4oA5l2ANPNw0S3Fmc4PGabbFRx59VcAKsDNKuBEzyXeMJrwF9zsD/iQCnx14DZyg8=
Received: from CY5P221CA0104.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::32) by
 SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 22:42:37 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::f2) by CY5P221CA0104.outlook.office365.com
 (2603:10b6:930:9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 22:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 22:42:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 17:42:33 -0500
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
Subject: [PATCH v10 00/10] x86/resctrl: Miscellaneous resctrl features
Date:   Fri, 15 Sep 2023 17:42:17 -0500
Message-ID: <20230915224227.1336967-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e50a36a-5b9a-4bec-e507-08dbb63d0e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jOL8q6SxngZEtRrPxwZytiv8UrnDQrOJheZn/y8JvE5brzCSMGjIWoNIcSH7Erk8HD23LmDi0ouvCYfJ+RIdiEkiCGVAuZopS4n+6zl/Za/dMEH3R0WUWX3lFPOAtDKFR35dfXZayRYPeIk6vy7coq3AGPFol3wZ5s+/DiyXWFdB7/1Owvg/OjBiHD5omI1Ql82vPRARlc/9ljnDCSOBwyHFYGgyH2DIUR0QnU+wgNya8j5rXbzSdRF1StpBYHWtJc4VnT0j6ey+5B6zH1L+NXWjiOhsjKCSG9PKNDU1Ef7ewO9bv4zBf9jDAcboNNdVGIacxyRBlbz1yZHqOyGbh99ZoHsH8xGbzv0xK/1SsH0srbZqo2NEBHWloBHSC4+C5iTHcBuaa0j/OiBcg6KuFulW9WeD2DSrmPueuiAk6ELiSYpfa1H0H+vRl7km1Ayw7FW0RCjczzvNzL95mBI33Qh3gsOKCGUE43uWMf9WEym8mil8ajnf8jEJ2iPXIO8lcXFd2Y2Mi2tVczkTJU0/4TAoCHBrWms9OPTLV8taNl30BgnJ6glvrO1F4F5mW9ORkqld6/cuQ3ppECObkHGl9yRteYtXJ3rIzGeuDoCkBxjVE1CAKID1dowkFNuSIgI37s8pG44ptVrSGRS6Mkm16tnrUSK/oMZL94HlTJsQG8gx0dPS6mcorlMWC9sWGNe8lC2PanZDRPxAJYDHGTMeoGCCiSItnR0hO+KrMGZXrTHXnva4b5ONEqti67XnEOvqRa/uOOE8sa7HbvRZInCUTMb2SnvDWt0P3ZDj7a6Y+LY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(356005)(2906002)(86362001)(26005)(336012)(16526019)(966005)(2616005)(1076003)(426003)(478600001)(6666004)(36756003)(7696005)(83380400001)(36860700001)(81166007)(47076005)(82740400003)(40480700001)(4326008)(8676002)(8936002)(7406005)(7416002)(41300700001)(70206006)(110136005)(54906003)(70586007)(5660300002)(44832011)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:42:35.6049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e50a36a-5b9a-4bec-e507-08dbb63d0e9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991
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
5. While doing these above changes, found that rftype flags needed some cleanup.
   They were named inconsistently. Re-arranged them much more cleanly now and added
   few comments. Hope it can help future additions.
---
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

v9: https://lore.kernel.org/lkml/20230907235128.19120-1-babu.moger@amd.com/
v8: https://lore.kernel.org/lkml/20230821233048.434531-1-babu.moger@amd.com/
v7: https://lore.kernel.org/lkml/169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu/
v6: https://lore.kernel.org/lkml/168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu/
v5: https://lore.kernel.org/lkml/168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu/
v4: https://lore.kernel.org/lkml/168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu/
v3: https://lore.kernel.org/lkml/167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu/
v2: https://lore.kernel.org/lkml/167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu/
v1: https://lore.kernel.org/lkml/167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu/


*** BLURB HERE ***

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

 Documentation/arch/x86/resctrl.rst     |  22 ++-
 arch/x86/kernel/cpu/resctrl/internal.h |  88 +++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 253 ++++++++++++++++++-------
 3 files changed, 281 insertions(+), 82 deletions(-)

-- 
2.34.1

