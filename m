Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1A7D5276
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbjJXNrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343534AbjJXNrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:47:04 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F298110CE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDOOOG1pH38TVqE6HX9z4SVLVlCd+8RGIzgTG1EBXZmgRsKugktJ6iH1zpN6fbWDYagLfYeFssLWmgolZtva0ECFA1g2s29gSJ7kydOdz9E79VRyuBEQYs9cbhOj3OtfbfplplmxHX9Ij2ebAGmJlpjX59guaTtDrt+6paPSG0TuUBbVPvCCpfizzu41XJXEA9SY7j8kZ5blDgIRzl9KaF5dCc8z6l4pq4XCaHNgchEifPn7EzGt36vTzG4qVXYVtp+6FWz/4uTfoXZZmLVw61YR1NBTtZn9Zk0DkW6Z7OhosZW4x9fqpQIU8Tw07xUV0OyKcMjlF9Est/B5tIGRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51FWt5CKLiAw/XYJrAm5ZHzlP6oRwIIhs0sTY7I6Llk=;
 b=KsEElkRB7GI9A8wp+Z1CYgfCN05sc7qSCPL1DgjsWWG4MyXskhOXWIlZJT1uhi46xvzU0DEUTzWVWfTpZmpWsyYwAVNP/vf55jg/3hsZfya1qalMuWe6HA2QBCsIZa9LKpSI7WD95iUBFWzsnJ53geYKX7xDg3H8fRdJD65iN/H+lRRgkIVdJcQDedxN4usyKaKbvevYTYH3ZlWUtL03gnV4/dwxBBN1KE4yh7tRrzFf49ehhaYTdS4X/QbAXsdZHTE4af8SlHXrjsUmpUVxPMXPFr9bEJ106hwD71VZSbvstI1+stCyHdiVjPBqhGxqbjocarUZHPnISoSIHpJQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51FWt5CKLiAw/XYJrAm5ZHzlP6oRwIIhs0sTY7I6Llk=;
 b=PMv5yaPn3IVkL9908QR3YqqYtdBF+mHw1ZBkfJ3TLy4Eb8OLht4N4A38qUl7Mv9HboOc6gh20YvfN8Nl5u4k+Zedy9Ci+S70hVsKSo6j5CKrR91I+sIf9kattKZ6kr47ILsyvFDw0Qi+232ZFFkO2zMSaihlZS7jh7MjjzqCNMA=
Received: from BY5PR17CA0022.namprd17.prod.outlook.com (2603:10b6:a03:1b8::35)
 by MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Tue, 24 Oct
 2023 13:46:58 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::d8) by BY5PR17CA0022.outlook.office365.com
 (2603:10b6:a03:1b8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 13:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 13:46:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 08:46:55 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@xilinx.com>,
        Raju Kumar Pothuraju <rajukumar.pothuraju@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 1/3] microblaze: Align defconfig with latest Kconfig layout
Date:   Tue, 24 Oct 2023 15:46:46 +0200
Message-ID: <4414109ba26433f00b4c07f600162462ab6c7a93.1698155190.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1698155190.git.michal.simek@amd.com>
References: <cover.1698155190.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=michal.simek@amd.com; h=from:subject:message-id; bh=xHT7b3/UJPS7m8mr/bQaTefjOWlrdyOXYPpUis+L7XE=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTzU7s3JyedCGfz3MU08ZnTgsdJPI26/OX797yTv6ilk vryzfspHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAi76QZFkyweK3wOzuExUvO /+fF/pVmhorbZjLMFe81vmJi1f1LaH+MUHXGXdFda4SXAAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|MN2PR12MB4504:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3f4948-498a-476d-f881-08dbd497b0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIYd5IRayqiCQwg6x/gGNJUhDttJGPVEA5YUqZvcwMSgv+PIPinN4C0/xlUTD9yMm7y3EttZQRASaJaxNv3Xr6OrF23lqnESeIow6koCxasc5568pN8Oxk+Ky0Qok4OaUCcEKapLZsQA6B8V8FN3WCjq9dOcT9GGMHvOMV0N1YZrtI6dYKO5GCP1W8Zjv+0HLsB8OTeTYA37OEtu91Kgfs551NkxVa8Pc3mQ+7zgx+3Tiavpi4RroF2TL+PS9E/zfbxhMLic4oLhftpS4De68TJJXc4bnnebhC82R2LGU0YdbttfRP7Hl/Wqa5kD50WaH6tuyyRz5mq0ELbSaF0jBpD9e2FrHZbxmOKD3btskMePcqZCrONaxQVCpMH3iHhYpjlmGgDqBntJmHrsjcpnfq0LGN4mlE85sV8ehD+pv6T7ejbL46jG67zim/h81TvKDR2aqkzfAIi9LEe0PRaV/vhHSjQOcfif2Nsi84vobjfdeTfwHVieE9y+kMem2yThBSDl2+mvY3H7z3UdkDJ2L/xZJKsycMufQSjtjXSJsrbW8Z3iq9JGr7tYEoshyjimUqPkBdoDYprkKd7oCnDxsIp5BGn0xmNNdhamVBc1xEiybZCY19vd9uu5WYSspn06TK39PvE12BEKbFDGThRJ105KMwNFXp0W60420ztdsHQn775v+GTZK6g7RqQLoF5ECMOWCB+jumXfMqCnGPRyrxiEGWh3Y2IxXIIS0t2ezH3b25EfYzkQOmmoqN4GLOeFluvCEs/Bi6N4dY9GI7FO9+IiLEPEnyghQUj61aaO+ys=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(46966006)(40470700004)(36840700001)(82740400003)(2616005)(336012)(426003)(26005)(44832011)(41300700001)(36860700001)(47076005)(81166007)(16526019)(83380400001)(356005)(6666004)(478600001)(40460700003)(316002)(4326008)(110136005)(40480700001)(70206006)(70586007)(54906003)(5660300002)(8676002)(86362001)(8936002)(36756003)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 13:46:57.2469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3f4948-498a-476d-f881-08dbd497b0ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync up patch.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/microblaze/configs/mmu_defconfig | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
index 7b2d7f6f23c0..88fce95f6401 100644
--- a/arch/microblaze/configs/mmu_defconfig
+++ b/arch/microblaze/configs/mmu_defconfig
@@ -3,11 +3,9 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
-CONFIG_SYSFS_DEPRECATED=y
-CONFIG_SYSFS_DEPRECATED_V2=y
+CONFIG_EXPERT=y
 # CONFIG_BASE_FULL is not set
 CONFIG_KALLSYMS_ALL=y
-CONFIG_EXPERT=y
 CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=1
 CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR=1
 CONFIG_XILINX_MICROBLAZE0_USE_BARREL=1
@@ -20,7 +18,6 @@ CONFIG_CMDLINE_FORCE=y
 CONFIG_HIGHMEM=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_EFI_PARTITION is not set
 CONFIG_CMA=y
@@ -78,13 +75,11 @@ CONFIG_CRAMFS=y
 CONFIG_ROMFS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_CIFS=y
-CONFIG_CIFS_STATS2=y
 CONFIG_ENCRYPTED_KEYS=y
 CONFIG_DMA_CMA=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_KGDB=y
 CONFIG_KGDB_TESTS=y
 CONFIG_KGDB_KDB=y
-CONFIG_DEBUG_SLAB=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_SPINLOCK=y
-- 
2.36.1

