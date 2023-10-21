Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BBC7D1D9D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjJUOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjJUOwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:52:06 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A82D79
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nI5iufCdiBtS887WpOA6HgQ6S95VcXX8p4Qk85qzVEhFAcACMJgKHJAfDg8FT+V7kiKNwO+/Tk5Q8aarDTBccig98pDRwuQDkfnf3UoxZtZkpsRlNRKdP5b0tghHOm2625wp9S4BmbAyyLDlSyrEzQ0VL2qYrm45A6PCRQh6EQc6c4uOk/Nq7iRiVYsOg5C8sFd9GUa2vZd3X1a7mt9YN3Ay0DChtz+LBq29g+qTFgUsscNSO5gXcNdEZx37e1ec2JHBUNe2Wl9a7tQVfnTVcCMLhzcq7Qpyv3Q0Qt3bVDcCNdOlt94dGHJa6id//KLRrVNaAkerEBy3onKObTVWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWz4BnHADkuwzJ/1vmb4UAJYRCa27cr9uLeGPHAvEQg=;
 b=aJfoG/0w7jQv+F6VMEjKCRGqsckXZXic8DUhxVafAuXMM5Dlu1dKjp0Un17B0OmcPVD91ZxgRWZyK4quDwelsWepVrHibhUafHq1D/WQLeladkrn+aNokEy211isKdEXh1kk7wN6Xgy8Jz1ETvf3XHTc8q6S07zEPiIFlOO6HS+PH7yTG6m6eEQsUuN927hX5EitUoEa1OSwIzDzadXLy0tmWuwPv+NBvUFKgvnqdRZcMmyeGjKXCepy0Ie0nbauzCheYfUMvTt4LbHBuY/14cGaCGrjV3kMua9GuT9+yjFYNS3C4e5m2l5YghzMDuNnqxJ1XxPh/IZQ2UBCiXt1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWz4BnHADkuwzJ/1vmb4UAJYRCa27cr9uLeGPHAvEQg=;
 b=AKm2fxcZvUWwFo9Lso15R9lGPWWnjZfClqWV7FI/Tppjrnp6dcE8p+G2sUxEIGDydRLa9Otl/X6Mz6nTbj3rhvRu9SIB3TjbcVxhX/vc7UgjBNwKSb10pMIta9nUY4kugVSeBsGEVMlUsT1IJuBMSYmIErC81WqTCgP+N67rkeQ=
Received: from CH2PR08CA0013.namprd08.prod.outlook.com (2603:10b6:610:5a::23)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Sat, 21 Oct
 2023 14:51:52 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::b6) by CH2PR08CA0013.outlook.office365.com
 (2603:10b6:610:5a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Sat, 21 Oct 2023 14:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Sat, 21 Oct 2023 14:51:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 21 Oct
 2023 09:51:51 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sat, 21 Oct 2023 09:51:47 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <venkataprasad.potturu@amd.com>, <arungopal.kondaveeti@amd.com>,
        <mastan.katragadda@amd.com>, <juan.martinez@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marian Postevca <posteuca@mutex.one>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/13] ASoC: amd: acp: add Kconfig options for acp6.3 based platform driver
Date:   Sat, 21 Oct 2023 20:20:46 +0530
Message-ID: <20231021145110.478744-5-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: ded95279-c8d6-45d1-2f7d-08dbd245430f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qv8avkckgz/stjuYH40HlbXv5WJoPJYn/fA3MdEVaBWrT58V/Hiqjai9poLQYyZYMfzLmfVQF+FuGI1VkVTLqamK31SBVhTreymS1uMWhOYa93bZaE3XvrW+j0fDPK3VnYokzB8WBPLQNBdit70cqt/sgNXr3bV+M7n+PejYBupR6ec3cLIDasg4Nf5hiKKB+vPDHmShlVFfhfg+TDZGtlGFpFbYiIm4E7oGeY4JfKF9siSAu/p7vLCRAn0ozgvHcXo9lMYJERHIsiKr/qYavf8t6H3HT0Y2iigtwPsLkC/tcX5Ni6BkmW+1kj7QZZjE7XbYw8NxrfxWzQ2yu8TMxyn7maxANBRJcG3PUBRp9USD3GFtgxXwG8Rq3smxRCMfWacR8HIOSTxQrgTCLrwsOOLJ0zfez/wydVMwAFp1VlS3m/jalY3bWOE0DpL4arPH/ZWeheQj/PfsO6YpFyE85Hy7Abg7Ysr1Iu+LEvcLrAxuV05uY+xKkAh+AxGKAifnSiJIS9+rxQ/wl5FV+iGwVW+XnXPlaxwAvWHXjgi+iVPF2O+N1skCJAejQ3r2YG61+G5u7ykn/GNNxOvdgsWuX3x9q68MVHvdko3dy+1yDAMvgSQfGz6mqBczXcnV/tcA4uv8DwQqMuhLGTi6ujALYe/8n8EAmbPQiYtLjv/yaXd8B45SkCws7gH0iQAtyo/ndZHo7GD3Novl6Uv13S4cBSqM9Dkbadrr/T+JyNVuCbV8VoLXzvI6V8EPz6Vnok49Rq8cXw4XW8DoSmUOWrfypA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(47076005)(36756003)(86362001)(54906003)(2616005)(70586007)(40460700003)(82740400003)(26005)(356005)(81166007)(40480700001)(110136005)(70206006)(1076003)(316002)(7696005)(36860700001)(336012)(426003)(5660300002)(478600001)(8676002)(2906002)(8936002)(41300700001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 14:51:52.1920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ded95279-c8d6-45d1-2f7d-08dbd245430f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP6.3 based platform legacy drivers can be built by selecting
necessary kernel config option. This patch enables build support
of the same.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/Kconfig  | 11 +++++++++++
 sound/soc/amd/acp/Makefile |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 631cdf96d637..c0b2a2df8f80 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -57,6 +57,17 @@ config SND_AMD_ASOC_REMBRANDT
 	  Say Y if you want to enable AUDIO on Rembrandt
 	  If unsure select "N".
 
+config SND_AMD_ASOC_ACP63
+        tristate "AMD ACP ASOC ACP6.3 Support"
+        select SND_SOC_AMD_ACP_PCM
+        select SND_SOC_AMD_ACP_I2S
+        select SND_SOC_AMD_ACP_PDM
+        depends on X86 && PCI
+        help
+          This option enables Acp6.3 I2S support on AMD platform.
+          Say Y if you want to enable AUDIO on ACP6.3
+          If unsure select "N".
+
 config SND_SOC_AMD_MACH_COMMON
 	tristate
 	depends on X86 && PCI && I2C
diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
index dc70691bc293..dd85700f1c5f 100644
--- a/sound/soc/amd/acp/Makefile
+++ b/sound/soc/amd/acp/Makefile
@@ -14,6 +14,7 @@ snd-acp-pci-objs     := acp-pci.o
 #platform specific driver
 snd-acp-renoir-objs     := acp-renoir.o
 snd-acp-rembrandt-objs  := acp-rembrandt.o
+snd-acp63-objs := acp63.o
 
 #machine specific driver
 snd-acp-mach-objs     := acp-mach-common.o
@@ -28,6 +29,7 @@ obj-$(CONFIG_SND_SOC_AMD_ACP_PCI) += snd-acp-pci.o
 
 obj-$(CONFIG_SND_AMD_ASOC_RENOIR) += snd-acp-renoir.o
 obj-$(CONFIG_SND_AMD_ASOC_REMBRANDT) += snd-acp-rembrandt.o
+obj-$(CONFIG_SND_AMD_ASOC_ACP63) += snd-acp63.o
 
 obj-$(CONFIG_SND_SOC_AMD_MACH_COMMON) += snd-acp-mach.o
 obj-$(CONFIG_SND_SOC_AMD_LEGACY_MACH) += snd-acp-legacy-mach.o
-- 
2.25.1

