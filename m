Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA777796B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbjHKSGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbjHKSFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:05:50 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684C130DA;
        Fri, 11 Aug 2023 11:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoaFWwLhUcAsuXLqLw7z+ndoIi3iloD39E6UcdJ1GStsqfj8CDNB35gDfmx9nqu8xux3uG1me9fS5OJjH8gOnngb8Y67aSn2HETPxX8oUAOdEEP6fMIqvMukqUyg6pa3XnIWSH6nHEunrsQK+DDAjJkoawE3q5u3PbBLYXjN1v4/aMe2MF7mZTOyE+9G1thrhQO+gFzEdYRHrx926NRC1YwUtml+kBMdnklqIMujOf7/ByEMj3sZRg83gKOEoXFUwYdTsFz37jqZZtN92+bngBAfR0JtnkfOgV7T52jTw1mRzUTxL9FHuDO+fHO5B7mWJrrBegaolksYw6t1FaSVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA92WgrlWrid5aKLeciZZapIIEt+bNKHUxGNU1NunH0=;
 b=lwkPSBnU8NzPEgo8+q33DJwGvNHpybE78KTRdoFbK5dhByTLEkU7iMWcurBMI0ZCyeIur8MY1VA12uHSbmNIakv4cxRgaDDy/qQjlM8wOb9Ze9DPHiSQmXPcJ0XBEjaijd9J5vwA8vHzmXEqV+uGYNe8y9PvLkRkYrzu/SShT09kENYJsLlJgQdsy2/LFfIIcJb2FOpxFj8dtSmN/SPH3Vh5lq3BqLtLr7sp1J94YrN9Sl3Te5tkAbrzJjSWI57NW1SjwZtnExtY7wzU2U94vfYYnmb/51u8umG233DkXD2mXhDCOWDojkKleDrOL6qZkUT5X0lDg83LsFXPnlSp9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA92WgrlWrid5aKLeciZZapIIEt+bNKHUxGNU1NunH0=;
 b=mQ0UEv+0ea7b5pj4pHAIna59Ru+Dh6aAEJ2jlJv864aRGwzsXCB256be51yD1/PvLfSKQWh+g59Q26ISVAnYJf/DmWILmMKH2+GmabOY2YocBZzRZQK2A2PxtWch/T4f7Y95XLhGhbLWClsbDV/DdMcYcOD5EE5IFMKMD7/b8iE=
Received: from SA1P222CA0175.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::21)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 18:05:46 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::f7) by SA1P222CA0175.outlook.office365.com
 (2603:10b6:806:3c4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 18:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 18:05:45 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 13:05:41 -0500
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
Subject: [PATCH v15 3/6] MAINTAINERS: Add entry for AMD PENSANDO
Date:   Fri, 11 Aug 2023 11:05:16 -0700
Message-ID: <20230811180519.29644-4-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|PH8PR12MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 4376011b-8835-4c87-0a99-08db9a9595e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gF/dR/AerwciwP83dmuJskExlnm+lcFe/Ai3jq8+t5Ebe+lRFi6LaSEGeSHioHhDAT4RR4aKwyOqKwqdjOpjmYwz3GkIw5OeKJd43/D6nDd97vB+gSOCDFgHKlNtgiyUVm+dCZ6ZXnvO6w8yYMF80z0FhYtn2Q5K+vZLnkAyVw1IMPgb6b/6eFiiLdDOMNOB+gFsy5YLhWPg3vSo+NUa6O8pvSCDJgipdcYYUizEI7reUsAd0O75myVs9xIi4C8XcVci0ODypmjI2OeZYLVYNh6Mc/tDredj0saqI37tnLto58wVILXolvjNUOr4QUK7mtiq7P9SIppM/MEn7O+AcM236fOTh4+N01ZwmHGHdYvWVQTx9SVGFB7cBmkwo7SdW26LjhIQPD25c3gZuKA/iO9rxnHkOBoExqMzKiAxuD9LFzf0Xz/nbSWeENLOkzdJCPXej6ddx3NiMk/Oq9Qb6ZvigKXAnhq32rW4vQ1k5pNivS6Zpd7MNUI+F220J1Atsuk5K9k8euBtNFRsLVDss8rkTXYnbTsd/rxYQpCyhXP4+rRltT47WmJtssHLpmP1aQaTRdJsPZmmKlMVDYyA57i/uX3sCTYjP79RuS8gkRk4OCwO69z2zhOFVHT/VLed5mnKUTA0ELfHu1SVKCGRq1CwXiNLmVQsxRJHiVFLUPHtSOBQGuriSWqb0B72bVL1cRQrwefvYzXKIus9UEiLRr07zbdeJcmJ+e4cN5k5YD9S93wfHDhJaVdLemNFIPXqiyjl4ZKxwu5Vvc1rBSmDyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(82310400008)(451199021)(1800799006)(186006)(36840700001)(46966006)(40470700004)(4326008)(426003)(40460700003)(336012)(83380400001)(81166007)(16526019)(2906002)(40480700001)(54906003)(2616005)(478600001)(36860700001)(7406005)(7416002)(5660300002)(26005)(6666004)(1076003)(316002)(36756003)(8676002)(8936002)(41300700001)(70586007)(47076005)(70206006)(4744005)(356005)(6916009)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:05:45.7765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4376011b-8835-4c87-0a99-08db9a9595e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for AMD PENSANDO maintainer and files

Signed-off-by: Brad Larson <blarson@amd.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..fdff6b0ca0d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1804,6 +1804,16 @@ N:	allwinner
 N:	sun[x456789]i
 N:	sun[25]0i
 
+ARM/AMD PENSANDO ARM64 ARCHITECTURE
+M:	Brad Larson <blarson@amd.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/*/amd,pensando*
+F:	Documentation/devicetree/bindings/soc/amd/amd,pensando*
+F:	arch/arm64/boot/dts/amd/elba*
+F:	drivers/soc/amd/
+F:	include/uapi/linux/amd-pensando*
+
 ARM/Amlogic Meson SoC CLOCK FRAMEWORK
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Jerome Brunet <jbrunet@baylibre.com>
-- 
2.17.1

