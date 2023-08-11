Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088B77796BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbjHKSGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbjHKSGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:06:04 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1218E3592;
        Fri, 11 Aug 2023 11:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5uwFAdV65djgMNXyZQ6kmtvVsebl+0StUcuiKy0d6yrg7bW7A7LiTIg82bLp/pr1ozuCwubDPlBwjbTXc45oRGjqO7zAzM5KaqSKLubaJEozIClUE2NpMgfeVA9tEZ1WuhtrZ/Jk3uTiT22zTKwmjv43H7kP5pPLIdI2kSVrgEzs+60eDCgF96u+kyrE/nVZB8LviAKXMXJXdjJFHhs042XAw14UhcL26bHYwywzLNVJzQG7UpIy6IkND4HH4F9VKFdj0oAu2euqXWwAcq3rCdRyWo0jF3mt3X2P3FeQWOWBu/8xTDMt0aa3KDsBrC/YKvPg50rzg4T83yCUBNmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8YrKyss3u7AXOORYMvwRBtA3275Mv6+bnsgcxgDrNM=;
 b=MHFwYb78Uxf3Sd1OtOxhuQAe+0NZPRjuk0GIP5VRNo+FIEtauszl3Fh2inKHf/IpmBx7DECW2raCZVnJcpuAOvFA8VgVsf40fRY2lzGQeoQ4xRP2omh7R52oK6F3dm/vuwvvHfQwCNaxB/OHhlU9fQPIe/bWo/34AjCoW7RwoAPNyYklW/nRUaGsElClGWA9mGnGVsvbRIf8d9I2/fRQYTTqAhtc/WVIPlruqnQ6myLkAByrTPcccS9uR5kwThY3KXw+KWQ/m91eXIZWrrai2O+sryL2cWPZler2siUOsobbq6CtXM6QRL3cyV2IQRMYXS+P1XUSrBfGT44ui2gmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8YrKyss3u7AXOORYMvwRBtA3275Mv6+bnsgcxgDrNM=;
 b=ho8BLmWcgO8GxxDwDXjmjaVT/gl8BO2VUxKkzYje9hI8bf5hzFWhRcSZ+kkxtwXpaVnEMVRWcPa7NBNxbhORmmNe7LbvMqBum1zq3ddhpxRdXugJ8eshn32ht4ELpgxv+wX5VbKJCS2e2auebh7zHQnWKD4KHjrdmr+HC/NGD5g=
Received: from SA1P222CA0178.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::26)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 18:05:50 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::97) by SA1P222CA0178.outlook.office365.com
 (2603:10b6:806:3c4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 18:05:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 18:05:49 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 13:05:45 -0500
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <davidgow@google.com>, <gsomlo@gmail.com>,
        <gerg@linux-m68k.org>, <hal.feng@starfivetech.com>,
        <hasegawa-hitomi@fujitsu.com>, <j.neuschaefer@gmx.net>,
        <joel@jms.id.au>, <kernel@esmil.dk>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <p.zabel@pengutronix.de>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v15 4/6] arm64: Add config for AMD Pensando SoC platforms
Date:   Fri, 11 Aug 2023 11:05:17 -0700
Message-ID: <20230811180519.29644-5-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230811180519.29644-1-blarson@amd.com>
References: <20230811180519.29644-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5023a6-4cbb-49ea-816a-08db9a959812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fudT+/r/oa+XFUHm03jILkX7MLqNRaI/89tSBeALzFif+bcqyyU+/d4LzwhFWOGpBh8zpzZPwfPS0+aPfD3o4uhzhMwLsarKDSRcyDFCBckWzgn+UI3R0VMKOtPtLm7PVGvmzGWOhYxRvn/wqoQq/9aXp3A00M5cl3Tu2rEmm1eMF+/INycGRyrQfG+nBV3aktBMjZX+ctGCYkK21wsDN8d/lkx4dOqe9UqApNEyoLOJKjSjNG8Ji2b35hWAexXbLKGNMjCgl1Ge4a/4um3AushOwPv5t7+TtLGijUR5irbb5gPDQHoikmMujJ9zco4Y8n886RzhcM0SVWQhxNbsFAd8JUR3KTApjj81g0eYUy+au0/mOJgQ+CuA706p/u89+x0ETa1vPVCEXX6/9z29eiUESro0CD+xJzRJ2Xgm3zG2dyIVE3/y+ZZu2ia9VPHMNECn0SWiluMdpDIqNo2/nOG/shTtP1LnsvJWDlL/F+xEDlapSrZbXnE6S0PGZY+mMYSI+vZi028/PW6BAc3wawixGK7FHUWXSUJslLGz7Y+ALEU+vAh78F1D6kHJulBMPgoQVMG53nNu3TpDiq7N9mIfNrul7PLM0vehngzytw6LwkytpPDm5sQ3LcDS4OABLEkMiPoFfB1URMN6ahrWWHYxRFA5WnpSf6aRdNzy7zoBB5e59fqKcTVWftXmMsT6bmufD6NrdIItsRb4yyi6y+dQCjcXYtmnaglvJ/sHGUew84l+Qtz+o3r+hL6td+02svQkvz2D6VncxyojDjSS7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(82310400008)(186006)(1800799006)(451199021)(40470700004)(46966006)(36840700001)(426003)(1076003)(82740400003)(26005)(40460700003)(36756003)(2906002)(336012)(356005)(16526019)(81166007)(40480700001)(54906003)(2616005)(7416002)(36860700001)(7406005)(6666004)(5660300002)(316002)(478600001)(8676002)(41300700001)(8936002)(4744005)(4326008)(6916009)(70206006)(70586007)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:05:49.2867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5023a6-4cbb-49ea-816a-08db9a959812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ARCH_PENSANDO configuration option for AMD Pensando SoC
based platforms.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 arch/arm64/Kconfig.platforms | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6069120199bb..9d09a1cc15ee 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -244,6 +244,18 @@ config ARCH_NPCM
 	  General support for NPCM8xx BMC (Arbel).
 	  Nuvoton NPCM8xx BMC based on the Cortex A35.
 
+config ARCH_PENSANDO
+	bool "AMD Pensando Platforms"
+	help
+	  This enables support for the ARMv8 based AMD Pensando SoC
+	  family to include the Elba SoC.
+
+	  AMD Pensando SoCs support a range of Distributed Services
+	  Cards in PCIe format installed into servers.  The Elba
+	  SoC includes 16 A-72 CPU cores, 144 programmable P4
+	  cores for a minimal latency/jitter datapath, and network
+	  interfaces up to 200 Gb/s.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.17.1

