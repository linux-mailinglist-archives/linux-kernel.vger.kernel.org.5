Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6A978364E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjHUXb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjHUXb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:31:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2206CD4;
        Mon, 21 Aug 2023 16:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yuc0X3E8EZMNaPamzatv8kYYrRPtwwCEJOYALdIU2paUidNpp7yAxXYJQQiYWe5Yj7KQ0gwut47C4MUt/9Rp+J8JMpebAc9Ddynw1OxQcYA7+g7JQ+o3yuru/sPApavqcXcfjsgzwjZiGOjFgCcFHQR2KCYbh5rUaUn/qNirlf9FUqSnv+kO6sh96sre6m2XiYLPTDxhBAgUGlP/455ff+IfhKOpcY/NsrywHAjP9NTbD8M/EWjdWixCPZJ0UpO4bPrqwAOw9r7sVEs4K2f3vhR3mBpRCOnaV3Ssz1NUcNE65brrKnhnIeHwwP9G4hH0WkqXXd79+p9k1Tk6ehk6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaBvfeRKpcvK3xvD7eu2qu4xJTr9RI7ouRIwwVAoC0U=;
 b=RF9OZ8P+DIKBkGF8fNLJul95Z0RO4kcXyCmhX8WwBTZsTu7eifkSmm/T3OgnqX0SCztwiGCxq1Ysp5/QRtG8bZTXZC2VoniKtSXjKTqAWbAORFixdw5uyBGonUhG1gu/7dfYj08v0L6HFDTF7kU/wCKYHqbJxA18u4yYmh5hrs6uR6+JNQEBrjLldPp6+04f8v5x4vOEMlUCsdtwLLFKBZCHsdJknvnXHxrEHBXKACOHwgLeGf76S5rxqfT6rygMSfBgeGVJwnB8LieT30aJhxkDd1Ei9VR76+knNbyPRuLGiiCdUtGPB15IWOdadMEgVkhGbuzpDJilugH4Lh/cdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaBvfeRKpcvK3xvD7eu2qu4xJTr9RI7ouRIwwVAoC0U=;
 b=lPeuYRG4sQrqV8dflMuZBeGAYdgGoHBf62QIm4iLG+I6992sV3ANuBoYwZ4qAWMYrRKZ9mOoG1JRmGNJxd4oTIoZDP+CCDRPVLN4fqG22b7ML4ezz76jtpz+rg1WkKvRdw9nEnCY5QVKBIYOooXARGvSpeA/DBHZhSWyTcUkvnQ=
Received: from SJ0PR13CA0038.namprd13.prod.outlook.com (2603:10b6:a03:2c2::13)
 by SN7PR12MB8789.namprd12.prod.outlook.com (2603:10b6:806:34b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 23:31:08 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::47) by SJ0PR13CA0038.outlook.office365.com
 (2603:10b6:a03:2c2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Mon, 21 Aug 2023 23:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 23:31:07 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 18:31:01 -0500
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
Subject: [PATCH v8 0/8] x86/resctrl: Miscellaneous resctrl features
Date:   Mon, 21 Aug 2023 18:30:40 -0500
Message-ID: <20230821233048.434531-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SN7PR12MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ce29fa-b287-4e29-a0a9-08dba29eb1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+pyhTnwd+tfWqhhajRc5Z3N+Pj/P12j/KBzOycjoAG/toeA6X4k+KMVzb+WTpSE5dFF9PRxy1SWfEUPnc5zf/J6cUDGgR7XMwgtEQgd8u2BBDWSGD4OBXV6nLvFTAb1lvPl8mzh4pVnm10pWLspjRI1oB1bAbUNHBvGGWtEdxaRFMiPx2xxr+W4WT3cfkt9Nxi5ySynQSDfZ9qH5G6eeHbcOvFguEnDBmDX0pjS9iow2lIPf0i+cYGd8hSOLTKcSk8kIhRktzPbDTayTfKFc7XU7zN5RfbUXMc4QQP7rRAeq7HizG8N9+e5iQf/ziFuKOyMa8fs4kPGzN11DmJZCzkc82hsRL/nEtLfhBcfeYrp/eqCe5kdZ1X+tP/JKAWjEBRkEZYDu1zTvp75FViFDQYVD9hgeOMOc7wMFRw0/eBB2OZWrN747aWG2OwSC4IrWY+96Q44drEZa3TXKvxC257D4cTE6DXNAfLR7d8Hl0k55YcCqcXiubSCX2sY9BkjyNvFbGUgyoIe6HAvFfZtfQCHElbSek0d/z4ZZodbKQmOPE4fgFIXb8QUL4s0mI1eoAJveTrH/fhxadIZ+BiNnt6R8vQ2ellW4bMIQY58O4BOY5VnQdvf+IV37YtsW3GvOjOoG5xHPQCoSM8tKIUw49bHlavmnbmXjjGVoAfzXshogpHLQ0EvabnBOiHCBmhQWFkJGfXlrqU7JCD3dOpClOeojMS6jTNFdndjqfpC5kZjsA9wSUlCkRbbStMTWUGPpk9hqudfHrwYHmTHzYa7sLXTABnkLEksvbkjOsiLXJM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(70586007)(70206006)(316002)(110136005)(8676002)(8936002)(2616005)(4326008)(1076003)(36756003)(41300700001)(40460700003)(356005)(82740400003)(81166007)(966005)(478600001)(6666004)(40480700001)(83380400001)(2906002)(7406005)(7416002)(86362001)(7696005)(47076005)(36860700001)(336012)(44832011)(426003)(5660300002)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 23:31:07.4995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ce29fa-b287-4e29-a0a9-08dba29eb1e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8789
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

v7: https://lore.kernel.org/lkml/169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu/
v6: https://lore.kernel.org/lkml/168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu/
v5: https://lore.kernel.org/lkml/168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu/
v4: https://lore.kernel.org/lkml/168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu/
v3: https://lore.kernel.org/lkml/167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu/
v2: https://lore.kernel.org/lkml/167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu/
v1: https://lore.kernel.org/lkml/167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu/

Babu Moger (8):
  x86/resctrl: Add multiple tasks to the resctrl group at once
  x86/resctrl: Simplify rftype flag definitions
  x86/resctrl: Rename rftype flags for consistency
  x86/resctrl: Add comments on RFTYPE flags hierarchy
  x86/resctrl: Unwind the errors inside rdt_enable_ctx()
  x86/resctrl: Move default group file creation to mount
  x86/resctrl: Introduce "-o debug" mount option
  x86/resctrl: Display hardware ids of resource groups

 Documentation/arch/x86/resctrl.rst     |  21 ++-
 arch/x86/kernel/cpu/resctrl/internal.h |  87 +++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 246 ++++++++++++++++++-------
 3 files changed, 273 insertions(+), 81 deletions(-)

-- 
2.34.1

