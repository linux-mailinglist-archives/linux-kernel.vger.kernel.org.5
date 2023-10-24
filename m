Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0107D5317
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbjJXNuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343572AbjJXNt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:49:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2AF129
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiikBmROAhE7zL8fq999GwDnLhU1WEO2PDaAOBAyi4Wz097BpeqakXPyH+ojLCB/XwJBOXOv1qkgfEG360WrczDA+RCcSee9WGHGc7NgDuBtxeYYAQZ61RXMkXqEzd9ntNJtaTQMOY4R5lBtAfOzVd0x8y/8hXG4XMhSDWMmGK5wlC8gSpBop0dWO76WM8CImcc/OzjaMhR4W2JznQu10BjvPR4WGQz40JlrucXqxeA56W2HzneBeiR4lFUlVeKnQY4ivU+IesFxi6C289FQLI4fhDWttU6r1NvvvyoDfptYtYlCJzp1l54xftVpq0h3gGy6+sHcLA0As4I5CVW3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPE+T7xCakNmChyrPjDq9l00mLg4hoP+X2JPT+YTOD0=;
 b=THAb4tdwWarL5Bpb21HHlkR5dAaMk+39ugBNha7W7zzfJM8I14LCOIp0kgzIsIjJ01Yrtq2KWsJVAykwWiM1xke4XGZLvYLDxUz3jhvReEiarkpfU20dUNRVYxw0yCzvrpC+fpy2f0SCVtO1jX3y2NyHbjhrkFPqJzd1IUOIy3FaWNBV+DnvSCJIO9qnGIXhRkAQekKY8nfQ1lfe8GiMUQd2HBbu74YOVRyWSjDaN3QfwYNJTwZ4UVKc3mD52zjwZUYZRXnA4RKbq41Rog3fEnIUi1MXkBWmNb20+lj+ztBlfTIijmhQZ5p9DAlhLOgpWOMHZUiipRWWCeIwsYVh+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPE+T7xCakNmChyrPjDq9l00mLg4hoP+X2JPT+YTOD0=;
 b=Vb1ZtBicS/D6wJdRWc3g2yLiE5n0apUnQhciZ/wx7BNvviV92win8xH1S38GHRM0gXcHJOXCKgFlvLiC1J5wXQ2SaZeTyrkRgxrKXCsI9tJk3otY4ncMjpBgEFC0jFwl6y+C3N2xjti5F3WIfJcSXwOw0a8gjMqDSIDPj04DzSQ=
Received: from DM5PR08CA0033.namprd08.prod.outlook.com (2603:10b6:4:60::22) by
 CH2PR12MB5018.namprd12.prod.outlook.com (2603:10b6:610:6e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Tue, 24 Oct 2023 13:47:40 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::4c) by DM5PR08CA0033.outlook.office365.com
 (2603:10b6:4:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Tue, 24 Oct 2023 13:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Tue, 24 Oct 2023 13:47:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 08:46:59 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Raju Kumar Pothuraju <rajukumar.pothuraju@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 2/3] microblaze: Enable options to mount a rootfs via NFS
Date:   Tue, 24 Oct 2023 15:46:47 +0200
Message-ID: <d7bc1c93e485e0a6ab2c234a144402b7bd5f77bb.1698155190.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1698155190.git.michal.simek@amd.com>
References: <cover.1698155190.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=michal.simek@amd.com; h=from:subject:message-id; bh=iT3QQ+UXvdJ9dLeC4dU1cpqmwUSYWCJT4Oab+o6Gobw=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTzU3vctV/6/m/5UOi3tkdY58SaVfN3G6+46tjTNdmpP EZxw4qZHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiSu0Mc4V8D83594fZtPGX bOo+z9cfsu3LpjAsmF73qDjiosOTwHDFnVPd/q7n9haMAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|CH2PR12MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a33e9b-f0ed-40e0-8d34-08dbd497ca18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfoU4Job3JNjdfaEWfnFKTRJx1BKbgaiKDf/4uJUtAdqLgVZr5tgRRS8tH4XqkJ0v9+IGfDbi60Lk15TUdYc2kNNq3zoXomAd6t3cfT4Rr6vy3DKZ7YTds0sUFjeLvwt70KQoqVRpuRGWgwKBepDbUqdckvTillff2yclqt9C1ylLd4YZFvhIuBNkZMsIcAkyrLaAhKGQppanwa1T0N/QT60Zcp1nxlmVvVrevRALvPbp861RPBYiiILENzCe7lux8cW06SnmVFeS/ddPss1L6b6UJ+wmZA+R5Z/lfvhxpuBZZgq8yTPduki+cre4A6pWxliw0xu13IxG4/IHbZf0cW+V9tFK+2PDVzeH/XxtMaV4LgiBO61VUwcoaZCD8Oyr5x/uNqqYg+dpUzeXgYMGKfXhwEcBckQGjbYcJDzAGTX+DRijjACGaxcVDX07VPtUnJhm9+J71j4JVtPatnv5MQUYkxjnDSA8LBXI7HPwEV2yH3mf9zqAtRM/NlSdmG2KLdBvxI+u97MvRJMWuvI9pGySt6tVaI1zbNsHIxXzrlj0ZAJtyZI72GkOae28wXwIDXY0TbabQsXe6C1rDvO5czclWjjsoNNskkTNDdum25HjGZ3UsF7YRAykIIiLBvPwH956Gfl8O7pmC2lTs8PyAfNGUQNtQYKBSdU1X0+hJNiIQNnsMmHOTxcVbdGDB2autC1Cqgc6m1B2TCt4ezPyTgX50ad8sDGZA0SF7jKlEPGeW3/QOoyr+q0mZ41Eu80rXBXdTGyrG2FKgA326N+YPagMgNDxjCeXIXtu6cr/TQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(6666004)(478600001)(36860700001)(86362001)(82740400003)(356005)(81166007)(36756003)(2906002)(54906003)(47076005)(426003)(16526019)(2616005)(26005)(336012)(110136005)(316002)(70586007)(70206006)(44832011)(5660300002)(4326008)(41300700001)(8676002)(8936002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 13:47:39.8032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a33e9b-f0ed-40e0-8d34-08dbd497ca18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raju Kumar Pothuraju <rajukumar.pothuraju@amd.com>

Enable the options to mount a rootfs over NFS for microblaze
platforms and also support for automatic configuration of IP addresses
during boot as needed by NFS.

Signed-off-by: Raju Kumar Pothuraju <rajukumar.pothuraju@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/microblaze/configs/mmu_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/configs/mmu_defconfig
index 88fce95f6401..85afdb377f73 100644
--- a/arch/microblaze/configs/mmu_defconfig
+++ b/arch/microblaze/configs/mmu_defconfig
@@ -25,6 +25,10 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
 # CONFIG_IPV6 is not set
 CONFIG_BRIDGE=m
 CONFIG_PCI=y
@@ -74,6 +78,7 @@ CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
 CONFIG_ROMFS_FS=y
 CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
 CONFIG_CIFS=y
 CONFIG_ENCRYPTED_KEYS=y
 CONFIG_DMA_CMA=y
-- 
2.36.1

