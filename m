Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D86379F416
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjIMVvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIMVvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:51:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01190173A;
        Wed, 13 Sep 2023 14:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4OKs+SFbAD4vCK3TUN6/IaIBZRoPH1zGfwN80De1fE0aCkm4qKTAWj1WXeXuIfaQMfAc6fD/yalAYlweTfFmcl0Z9JKeSfAYY1gJAez9ms1A89EwlO/PMvhk7Kzo3a5ktvdBmdK2xAzN3I57hD2BjwxiodecdDYGqw9Ry8vXF99SP3LhzEYyTdggOZ8JnysLOHuIsOg/AEG/bOY2fKEXS4Vcn8wsF1T2Gnuvk5SRrpmNJN4oKgVH2TEk9kSgfNJgi6mPUBpUiQgjFivko/YDGNYO7s7liewZWBvy6mVhGXiB6M5J3VhxRy8FtJZjCZr93H2SYFW84aYEFuwZPGrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdoZ8NcXBRR2zfzNwIn0gHe6PhXrxAic7y+LaW0xku8=;
 b=TyHqunAfQ1jijz7kVPT/lJxa3lXO+KzfVbs0K3I34D3OXOYCiMeY60e8+Pj74V/WQkUXscrdYJg6L9yX7LXDlFyQOQTCj9gC1yMTOp6PykT6zPoQQqjWhjiQRfYruzwOaCw2/RYKTO/qjsia9BPfW0zKnND+S7699gxzh/tWUfzIRCmQLejWobejNREOYyuzusbTvH4//IKzK3tKF5CKo47XOe72cO3ivIwhdhH4Q8B1IKD6IOpk5ykddtDrEx8FYUQiVuHRz2OpT3le9YddRoIuXWyWwhE8lfIYPL+LZsZC/3N3k+C8AVKuPrMDtgCec8+1e3L8hfSM5ngDY4JDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdoZ8NcXBRR2zfzNwIn0gHe6PhXrxAic7y+LaW0xku8=;
 b=3afV8egbQIqezTRrh7TU8yxHNhzRBcADoaJnwod27uOH8tV4YYE3KmifHG+UvXrkuU0Xom6B6asEZvr95tDEhTgJvrvo+ufd1iITnkfbwkePlxy4FsbgJPXyRERT6lsRwwGwp55WxZENaG4pgSk0Ny/ZIvEiKKrpVSVVVWJ9QOM=
Received: from DM6PR03CA0067.namprd03.prod.outlook.com (2603:10b6:5:100::44)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 13 Sep
 2023 21:51:07 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:100:cafe::c0) by DM6PR03CA0067.outlook.office365.com
 (2603:10b6:5:100::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31 via Frontend
 Transport; Wed, 13 Sep 2023 21:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 21:51:07 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 13 Sep 2023 16:51:03 -0500
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
Subject: [PATCH v16 4/6] arm64: Add config for AMD Pensando SoC platforms
Date:   Wed, 13 Sep 2023 14:49:42 -0700
Message-ID: <20230913214944.59804-5-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230913214944.59804-1-blarson@amd.com>
References: <20230913214944.59804-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1da4b2-041d-467a-6a8e-08dbb4a388f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: To1rfPGeLLnmbXPd+UkhSCvFsbPN4+Hk31IU++GR/IE4BbJAfKKoCuvBWqeht8P9x/M9ytZkcgQhS89WgtKrofGd/I3CR/ZtJUwLrZ/9J2HnzFvsIFV4QjZHOYATo8eHHyJxowydhQyPKB7/NUxZDBnIXNFeyNm/q6Wcq9x41Y1garpkfbCxvZ1PnxSx3C2hbc5TgFCry7FXhTpDOdOD4w2e4YB7jIh+aMOa7eUr2r7lUsUOVfRLDV9RzC4rkWHmc5Bqn5N0WabQ7aLjz4EM9Boiy9jUYaN6h15jBauEi/hkWYdZYzmSZk/4hRFdaYWQn02isndlnNUYdZuIn49BRz8bKjlpgrTcqSUGk1DpURSOjFZGmUEzXJ3Lg52YY4g2aOqym82bwmaoEI158bOGsPwIXuCJC9MVAZckRVjqfzrQ1xPwnS5bBKRXDiqOpwxnXYyqWU5DMSkcmYNQ8bGYFJG+fvElAQb7BCu5uw1YcbLi2mGrFzi04TSFx5rK21Qlxdj5qShFmB2rGuHgN6EjXzE5IrMAh8fZsH+AO/ff1ezfYB7MOI9MNzFktBhnTPwg4QkOMPefDyTrKqCQpKqOwINJTjQI2uzifLvnOcZK4spBxZne3i9ULs88XTR/86Lzuf1gQxKJFDtWj6yJTclSqf3ndxm/viSuKb8PYFrtsrMg5BVVA25DEK1/mSApgpHzS5Rf7zYA48Vws4BG9lDgFNFqUsl6rsZcMXbZzSUwU+byh7UlLWHgar0xNvSRjZo5Nch7IVYq5hAgklJcRiCTgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(6666004)(478600001)(16526019)(1076003)(426003)(336012)(83380400001)(26005)(2616005)(7406005)(2906002)(8676002)(70586007)(5660300002)(6916009)(70206006)(316002)(54906003)(8936002)(4326008)(36756003)(41300700001)(356005)(36860700001)(47076005)(81166007)(82740400003)(7416002)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 21:51:07.2402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1da4b2-041d-467a-6a8e-08dbb4a388f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ARCH_PENSANDO configuration option for AMD Pensando SoC
based platforms.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v16 changes:
- Updated the help description to be more precise

---
 arch/arm64/Kconfig.platforms | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6069120199bb..24335565bad5 100644
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
+	  SoC includes 16 Cortex A-72 CPU cores, 144 P4-programmable
+	  cores for a minimal latency/jitter datapath, and network
+	  interfaces up to 200 Gb/s.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.17.1

