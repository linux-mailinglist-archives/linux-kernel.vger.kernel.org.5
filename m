Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17C679F411
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjIMVvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIMVvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:51:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2AE173A;
        Wed, 13 Sep 2023 14:50:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9msg8WBbguc4/V1Tcce3CkdhwAVEvmXmCWsmz95o/IadtPWXbPEwckHngsowsLImUIr5HQwb3CrzDhNnoKhmjz7r8po+wtGs0rqb2Tmhr3w2DD3EonWFU6xo9ovAZ4L1xLkdnm2K1RAG7mByxI9e6vrBOG4ki1dHvvc8+QSfwgtsus1bx0r7ZFcXyTEXDMjkorbhZs9kqqVfS5n3YAPxeewB5rbHpuvdQCc5QOYJmsTFIwfe40OA4fYLWor6o7NafBfH/bA13qyNOpOMJPgSSMLqiSwgnanx/tAK7V3qOj/pajdFR10rqnQGcMtuXGViz8dVzfN2gE++JIcsGyogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9kL/riPHsqf8cLbjR48NEYq7anS+TKOVkKPA1PH86Q=;
 b=doB8ssswbd/KUo+eBsODa14QekV/Oy0W+/5KbiDPiGbFQ+zS3kWIh5oSmh4RZLVRm/Vpuk12Xl+O0uE7FWnyQZXCj1jgy1Q/M8pQii+9wxmHYVDgkOojwp5uoo/im2eSJh4BPgHWDjG8V6GEiw7oAK+HGIXTgjRq1e9B6+U4H6k4ytP6rVborGJ9fu9ebUIP3WQHP0SSFuS2oZtRRcrpUvnsqtSrXVoC+21JmolFGc8h6IxosWNyUUvgj1MTAqY9Ikb72IrHKkYm9IKaC0PW67PXuniQCWpSfEwygVKZLufTXAGhDjVUgCO+a0REIIqWxeW310NWNFoqB/yZKtT+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9kL/riPHsqf8cLbjR48NEYq7anS+TKOVkKPA1PH86Q=;
 b=g4WNl1xqhGo8XU8DlZzA9PN0Kz4ttK0qJwlO59NQgrZ/O2kHdQwjwZAiQ1u5oed+HwL842HKs/Npcf7xddbLZSXTOZT1qElUWw8lSc/2NIJ8eUjfbCyyWn11NTamdc4KKW1Bd3KKCG0IOQRKVJbIxibsZy8tukIEwKob6B0xiY0=
Received: from DS7PR06CA0019.namprd06.prod.outlook.com (2603:10b6:8:2a::18) by
 SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 13 Sep
 2023 21:50:55 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::3c) by DS7PR06CA0019.outlook.office365.com
 (2603:10b6:8:2a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Wed, 13 Sep 2023 21:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 21:50:55 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 13 Sep 2023 16:50:52 -0500
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
Subject: [PATCH v16 3/6] MAINTAINERS: Add entry for AMD PENSANDO
Date:   Wed, 13 Sep 2023 14:49:41 -0700
Message-ID: <20230913214944.59804-4-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b21010-77d8-4605-dfdf-08dbb4a38209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jEz9NwxSyUD4x188oC26IlDhFqYzIDIL/YQm+mLMQtrFXE/AndBXDsm++7sbI2mFuexu5NEk55qZMkftJIsWUQJbMH5Q4FkXWSYvElrupqK9abUJ+JhpbobiGjqZ1VNf77gadsZfr2x1tYnulStfT4SKiUR01X/UKDH/1mGIuoRK0xUc2I3a4lHMUF8Hld2hNK4OmeyjwdImkn/4DC2hfpxr4kGdUSdYgP9tE+gsO/I2rFdWieHyLOLN7gsi3CkaQY1YyZW/yeidigMkY0EYT92+nFW4heRb0wWWtnWXSMRHoJUYsicCKsSB8cKfOoAttmCDcCBuFvHxtsxZWYYn+wgamFyy+ci25+BlKMYuD35uNWIPDSGlb4rTr5DlGpz2nkxWTYppQnZZ+EB1DWVlHsnUkHh1vqlzk/NCY05x2lcUIcp1/Mgvj6GhTLKFmVYV7/nhuGvlVpWYiBPSWK3kuM5UTCsqkmxLL7LwMaFLIs5jOBOC5bxiy/hFB9nyXWYI0OcPnhJwVbJmSBjxn9i5UgO6VEK9YSngVnIxi3k0+5KLIyRMC3qGMX0NYN0a67wtL5pMCFneaxcq9P3oerEjD4+diVb3EAO4O8keB0uRBppzNwZ4XAxXXAwKTMbcqXW3PKb4VYRRmW7oJOAsGhTxBMfFhkGSGxI0tdqNcNstjaJX6kMs8CXIuD5D5OgUMLfG23EDbL/VUX4N081fYVC3/NTtCqNI9XCHSWoIMkZfWi5BocJPCDdSAEkhpLSQiL9x1DlbtgRTj+8eXgA8O0h4Zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(316002)(16526019)(83380400001)(6666004)(81166007)(36860700001)(36756003)(356005)(47076005)(40480700001)(82740400003)(4744005)(336012)(426003)(8676002)(40460700003)(1076003)(2906002)(54906003)(2616005)(26005)(478600001)(4326008)(41300700001)(8936002)(5660300002)(70586007)(7406005)(70206006)(6916009)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 21:50:55.6630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b21010-77d8-4605-dfdf-08dbb4a38209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for AMD PENSANDO maintainer and files

Signed-off-by: Brad Larson <blarson@amd.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2833e2da63e0..28c1e29425a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1815,6 +1815,16 @@ N:	allwinner
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

