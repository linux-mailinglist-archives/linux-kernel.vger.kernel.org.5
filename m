Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FBE797F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbjIGXvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjIGXvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:51:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFC21BCB;
        Thu,  7 Sep 2023 16:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDHUWfLPAnirnmxgNGjT5NrhpNJyFPxgZ+8fUH1+EvQ0E7CSCZf6/3csw8Cg+29wQ7C6+RI24LZwS6svucJVST5O9UTDSGRKQXYahLT4Wx3N7bwHpSkSHI6E6i1GZEMSW4O5JE19P1vRrKrrtgGDyXJjlf2sIazvHwwfij0Ic/t82SfeQ91vb2ptDQPggw1JX+mBH1Lv7TYk267K9P1q3VfZPcgnGkELyncV+p5uIHcR3Z3VJ9ttzeKOIP/gEMUeG8ofWKDb63jY+sk+OEzs8ipxiH4sGLrSYe1aQ5l3vtw2NiVaks2ZGPutwybDI19qHVjOPowBjepJOB0x9v2N6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCM7TznTrnkoDU9uMLUESsWO/zH3SNvBYHH7HJaPRzM=;
 b=Rqeh0n5xhd4je9Y3wgtQHFuMbrYTUC2niJbyFFe1EuiwbrmT9fDF55jDy0rYu8bxLk37ft7rgz20NNw2KeoBi46xFkt534F0J0FxY48ZkTjETdsM/BusjUtJilp8k7CY40zkcVGagax5fP9bAh4+anw47OYWoWTigKPuHu3Hco9zteyBm8R6eXIpymNBvwdB0kAiGWaRVEeEUXDrB3ALuXOSWLZjdwJ6khrhjxo1p2g/Qja+6qGr0SfYIf92m6c2g4eehmDj5EXw0Sef5IhtEwGQQ29EfYdXt+3HA8MtRUmRa8aG2kXzemRCsyD9ki+dNLmsxGZPTHd1RcwDudGelg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCM7TznTrnkoDU9uMLUESsWO/zH3SNvBYHH7HJaPRzM=;
 b=CunIEgp7sQEb5eJuU8wyquwJ/bc+Rw13/xUwoocMvo2PljPwv3yBqKnMnaLJ/6ayej/OUU4fEcXXNFeyU1qD+qVcy4Z3dSwJKucaoMtJGvpHquF8j5DuLkcukansEurBHDgQ0aJd1jv1AX/vmpfoEtfxnK2a/rEDl8Kn0l4Up48=
Received: from DS7PR03CA0312.namprd03.prod.outlook.com (2603:10b6:8:2b::21) by
 DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Thu, 7 Sep 2023 23:51:37 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::1e) by DS7PR03CA0312.outlook.office365.com
 (2603:10b6:8:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 23:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 23:51:36 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 18:51:34 -0500
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
Subject: [PATCH v9 0/9] x86/resctrl: Miscellaneous resctrl features
Date:   Thu, 7 Sep 2023 18:51:19 -0500
Message-ID: <20230907235128.19120-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: a96b473b-d1be-4df4-8312-08dbaffd5f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chXTERwOcn9TApOTPpzOjlwv4usJZbevpkksChOT1dAmgVAvyPSZmY7XU5ERDqKhjW+12yY8mn3mZncQFnU2bQ9EWZsFEQnNNGEGCReZe00KK02swAzMG1h/vJz4UnmWdF4T4vIc1FfNphun7NToPMvlVP3+pbJRFcGs8LTxhV2UxJY7AbGNSkb56mTnFD27xU1Gmex9f22Yf1ANCin5BQ8y8utFaJdesg0Ls1yiopqVA610eKEix9A88HEIL2LdyURLqVXUMbucS51xNZDVejqAxwvRhMhnIuC5pMXxj+Oj+dTF4gwWh5OjyrTjG4UYWGdQ8smzQ2kZ0FbVfZE9h4+Y84Ahary5CbSDrpYEJpTc/S88QIRjPPOgpjDyihflNKD+i4bd83l+ZrrUpV0F1vhO7vsiZcGnyWr3SEPE4Te8zAdXMou8WZz1Xov3Or0RVG5W6LQJqOZBaHEJH7/WVYL+phl7j46LCYG/P7YdgxbXvst+NOchEve+hgQCqIwK7rPJCN18xZkEbS5oQQufMJ2mDaVhSuuwewiMfE7ZDN6rR69xZnxbxF7AjzN/UxMFwiIwRCarTN8LteLk56ztqqmeVmCRT03n9PiXN2paLizqOAJRgoHnu88QST0Zj7lQb87p7vm4xXr11/4Oh/r3R+CWSJJ13SHdJfCe+/3nGNJp/Y4HnBnaj5cvJx8Zlz00SjowEIwRLeEonXkZW0pIi71xbH7l1n4epaKx2BD8A4ksJpCBks8+xcTD5wYIScbcRzij4avY+wO7+fJ0YCbC6aBCKso9c3GSEUkXyVyP5XU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(47076005)(7696005)(6666004)(40480700001)(16526019)(83380400001)(26005)(40460700003)(1076003)(2616005)(426003)(336012)(44832011)(110136005)(54906003)(70586007)(70206006)(5660300002)(356005)(7416002)(7406005)(316002)(82740400003)(36756003)(41300700001)(86362001)(8936002)(8676002)(4326008)(81166007)(36860700001)(2906002)(966005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 23:51:36.7708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a96b473b-d1be-4df4-8312-08dbaffd5f9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
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
  x86/resctrl: Add comments on RFTYPE flags hierarchy
  x86/resctrl: Unwind the errors inside rdt_enable_ctx()
  x86/resctrl: Move default group file creation to mount
  x86/resctrl: Introduce "-o debug" mount option
  x86/resctrl: Display CLOSID for resource group
  x86/resctrl: Display RMID of resource group

 Documentation/arch/x86/resctrl.rst     |  22 ++-
 arch/x86/kernel/cpu/resctrl/internal.h |  88 +++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 255 ++++++++++++++++++-------
 3 files changed, 283 insertions(+), 82 deletions(-)

-- 
2.34.1

