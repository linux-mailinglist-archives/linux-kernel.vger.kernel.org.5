Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131FB7B7591
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbjJCXy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbjJCXyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:54:55 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4F9A9;
        Tue,  3 Oct 2023 16:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Duog0R7oGUlA4oVKJwTRrsJQ8sQ/89ZI6oBGJAXRv5YK8zsp2KHvMwboDe4YhOsT+xzg3eFI/wpp+RspYCBz+G/XEI1NOAwiLLZkpSkTMPj/aMTKtVB0SF5Vq2VXfHndVJO2EXd1bc3+Tva0FsTaxE0vasNWXjIBvnisVYAXRwMGBozfsbKjrR2HZ6NKSzyww/fVh4aB86LnQS+gPTWb2ONEaXf4HFJNkhIyIJk6Upqa+r5IOZ7gUEcP8nQSP/BwGhe0rkbJrurT8rBObPM/qUnlRPrmrhDteV0qzBb0qXj3krjYGQjK/KxukNIbuxKcWgwmLzNawp36I1BwLSdYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9zCtoyndmFbs9H5Od+dimbKluSSGkGRS0mdKm5pAzA=;
 b=VdmU8FG52Fkvk8EwcXkPNPB3h97bfaLIJVlrWoVxlLsfkTWq69cBZaXPNm0UV0D9IN7Fp6OIJw8mhg5j76gyjH4RlRhNaHbUDlTMR1ROGbo95h7OBzOOF96D46mOAs7N40ypfHLGADOqSlw80sFFQuWGUJ8rLdFajGVFWLDCGqONLhO5a40vpGLOtHus/0J3Ne207f2yI/EV52CcBvGLU8YiL8iuAtJFjcIi2WfCqdro++HHX/bggIRTX5lM98J3I5KYfFrjdsrVOWWR6Bx53Aa5rSTsexYzVxnjrLMh8ZrWPXfDOsjZd/Pp203lL2J7JPtRxObO8w/OhmmLQqpBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9zCtoyndmFbs9H5Od+dimbKluSSGkGRS0mdKm5pAzA=;
 b=3HQUd+tM1nXtrm/xlUtYo8OAwlHub755e0ycPPUToAUdcXgQlmIvChFe1+xNhIiEY5ovVnjaNcEPJ+C8QyQlAm5SvJDx1TeFc5lo/dZouIV3rGp4577EV4ZgHh0SQjRl0e+OaSJg1eyBrfNahRPQkbVQseX5dwdRW95+MnCI7tQ=
Received: from MW4P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::34)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31; Tue, 3 Oct
 2023 23:54:46 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::7e) by MW4P220CA0029.outlook.office365.com
 (2603:10b6:303:115::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Tue, 3 Oct 2023 23:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Tue, 3 Oct 2023 23:54:46 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 18:54:43 -0500
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
Subject: [PATCH v11 00/10] x86/resctrl: Miscellaneous resctrl features
Date:   Tue, 3 Oct 2023 18:54:20 -0500
Message-ID: <20231003235430.1231238-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b6cee0-4f9e-448c-76eb-08dbc46c1f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Qwh87BUQ33gYic9Zz6ane/n2aAXIXbPfcDH8scdnPFwoBiHCJvr8yOgtAt+5SeW/MY6YjWsusIhKrTjxdxi4JH6eR5AfQ+ZFDaaOg3+9AIC9mKqxrtu8PpKAuAJJWh4IyQ/bEUX0M/YkuSCF+zW2nnox1fI/YBU9DqF+wpYB04fJt6wSp1BOkFV8FzudBiFL4nCLugBaIcObAcjROFdT5E+pUfJN4eckxznfdONur1qe8acawx2BuDy0lUHdrAkZt7bgZsUw1CiN5CXRe3aoLN1aCsHTVyEeP3fpE01jvhBhJ3L5UQHi73dSJejcfKTWuzbMbbafz+ihwCKZv1OTpN6OzA3Xu20UQ1rekS0o2t0H+LHS8fqroCIxANsEmtiNtWOIpPdWvvZNcLkCiJotxgvgfCP9E6JX5cwiHoU1Ioe/O2xWFnMmq9vrFl4uMOxmpm3x1tAQ43/OHbKYeMLCAb/JSpNiThdPZelt6H+mkfAyp0l5WdonOLuP4CGdtIDNl0Izqr21l5/9YZ5Xu39uioPW63AN46jqujl0PxkmbgpeQ8ajdz2wkg35U0WdqHU/u2Su2c0FUKmL1domjL9ZV/60PLYTDLn8vPvPk8Qe2qGhl3eu9uYX7vEowfQ/d2jXymvzQV7THTQ/8D/qXaRCl5PSqs12OWwFR5qCHiFqXNZZBbbza7thnxaenXK3DGaqaRyZQjofSFr6A5DPr3rxz3QTyoI3vMEUD9bWKQpRr7+5wqt2intCuRb8j0+EjtVqpOUa49wkbfCiU8byG+iR8TIo4Eo4xZNiNcRsyuqjYI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799009)(46966006)(36840700001)(40470700004)(2616005)(7696005)(7406005)(40480700001)(47076005)(36756003)(356005)(86362001)(70586007)(426003)(478600001)(82740400003)(70206006)(336012)(966005)(36860700001)(1076003)(2906002)(16526019)(4326008)(41300700001)(83380400001)(40460700003)(316002)(26005)(7416002)(8936002)(5660300002)(110136005)(81166007)(44832011)(54906003)(8676002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:54:46.0579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b6cee0-4f9e-448c-76eb-08dbc46c1f37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 Documentation/arch/x86/resctrl.rst     |  22 ++-
 arch/x86/kernel/cpu/resctrl/internal.h |  88 +++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 253 ++++++++++++++++++-------
 3 files changed, 281 insertions(+), 82 deletions(-)

-- 
2.34.1

