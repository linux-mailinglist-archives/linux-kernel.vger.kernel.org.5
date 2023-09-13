Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC479F409
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjIMVuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjIMVuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:50:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853021985;
        Wed, 13 Sep 2023 14:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2d/Tzz2vZmVyfeXhKiJ2RiIL77q/HqjVbGrxffU+O91XdejwFeLQ8egFVu1V8Qs7t/cvDAimTWzw5ii0U3N7pcVsdVzg1hKB73dZEZay0NDRy3OHEjQVoJFdtNzInP28HXuUIBTBoXHwK6ibZWUFhgOmuHJ7YHy+stNQQ8Z+SkDKh7acnWRMuQCHGsXZPavVV8nNqdlOLrLlyY3xs713jPBXBLt/xXrsPRsUWx7BJ/V41NpS4ablnfaOij5isO1Rf+vQ6X4c3vIhXvr9gxMyZ2xwHWQEZEgtCdF27msA+GtHbhUDtUswTyHFS5YHdS0qYsx+KeAiOsF6Dko3kb4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy28TcdtatfE39iP7KmaaFwO5+MCnCgUUyAylO9Y+RE=;
 b=og54kwjy80IC3DNe2FR2g2pR9EMaM4/9Z5frzMoZw1kHLZmm/wjCbXtNOO934ScL+gSufG95fk3aUCIeihHR3Oz46zOZD2kRiiYAgBUuLmGIJor+88jttvVVX9VfZuJTGN1B9HU4/2V8g8hWUJdcbj0p/DqZbiRwaD/MmlTVGBRWLdMKrAqhywWH0NBczsIZEND89pbpIfO63VljNrDhzoZHZ+bjIB3ND6DQwbatZbV3m+t/iqh0RKJfreKSZjCX+n4ovWHN1hYEZbMrMV0+cImjqb3pM3ZjpiWSJ+hA4YE6k3qt/DxrFqE5faBndEVJmCKsQgezOn4jaX6KdmPKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy28TcdtatfE39iP7KmaaFwO5+MCnCgUUyAylO9Y+RE=;
 b=PsiRPIDVry3yCBMkGW/pRqOwpUNWFLDGBa6/+o9Ut0byoAzkkXxOvZXNIPno63gVZQdgd8XJQ9BYaCxPD/L2egMmrd9noLIF0h02V5cQSWNUzxIYUi6otQLjNVmPXHuN3jk6zpNIaTYHa6eWuwa8VRgvUTmqfAHTiu3vtC5andU=
Received: from DM6PR01CA0030.prod.exchangelabs.com (2603:10b6:5:296::35) by
 SN7PR12MB8433.namprd12.prod.outlook.com (2603:10b6:806:2e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 21:50:12 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:296:cafe::72) by DM6PR01CA0030.outlook.office365.com
 (2603:10b6:5:296::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 21:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 21:50:12 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 13 Sep 2023 16:50:08 -0500
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
Subject: [PATCH v16 1/6] dt-bindings: arm: add AMD Pensando boards
Date:   Wed, 13 Sep 2023 14:49:39 -0700
Message-ID: <20230913214944.59804-2-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|SN7PR12MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e1c103-9d99-4e4c-0599-08dbb4a3682d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJWZ7YXOsAcebwag4dmhiaE+9NcJaYR3icI+cQ4jAmZ/no5XUSZqvZp9m8J5WliwQI3EbABPOor4JXr/rUAy61r7jWRI0W3QT3tuw0HglWCVuqSdzlrYjpnWkaR/WJH41NRZA9qxgyjxKUmr6oFULm0V7tMKacJHbiuiK2oDR7VwzFKkfWTtbvx2o2ro3a9SlszlefoAXNTvyT4a5vV9EDaoAcQtUtBJh3DBgWxsUetlxSX8x2nBSgkABa7NFWooH0hSS8Tqbz2VK8vtKZT8xTUpxLxqJ6e+tSYChMfbt8nYVhwi1x/ky/SCBP2QybOGa5uojcQkueuXGBgLTcrczzEM98rh6gx9JPxSOjJqf/UViu39nw44U2s3zposGbb3ED9dBu+B12+YifbqY1xupFj2hj8eqPCsmzn3HVR5AGfzIBe6TBk0Oqy01GaizWFd1YXQrVd9QwiTutdR2cZ9qhO19MxzVrjovRwYA3vEHQj5GmzonDrBFEN+qYEV51z87cM15QiJCNmkzmuWKXMBqZourWHd2amRIns4BCTEp5rdDoZOiH5ACQ+q2NI3Htmh1mAGO72n1yXjM7qRGDsStAj5lGdMb88c/A0QcW/8RTi/uuWWSpgur0+yEB6i6FSTh0ezSrOmiu5GvGdfK0q6P3tqP5UOv74Pxqjoni3J2BYrAOwCUseZbGaDUhTHoG/g7hK/cMrydtDl7o/2Bzhsk/nbFCki4blU6caxRzj9XMQxUWjlIMtq7RM6lE7FZ3c36Fky9/tlH7dPBp+LF3VnSH/rSwevHLMCK0EwEEosVlI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(186009)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(81166007)(82740400003)(356005)(47076005)(36860700001)(36756003)(426003)(2616005)(336012)(1076003)(40480700001)(26005)(316002)(2906002)(8676002)(7406005)(7416002)(4326008)(8936002)(70586007)(6916009)(70206006)(41300700001)(16526019)(966005)(478600001)(54906003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 21:50:12.2725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e1c103-9d99-4e4c-0599-08dbb4a3682d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8433
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for AMD Pensando Elba SoC boards.

Signed-off-by: Brad Larson <blarson@amd.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/amd,pensando.yaml | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amd,pensando.yaml

diff --git a/Documentation/devicetree/bindings/arm/amd,pensando.yaml b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
new file mode 100644
index 000000000000..e5c2591834a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/amd,pensando.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando SoC Platforms
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+
+      - description: Boards with Pensando Elba SoC
+        items:
+          - enum:
+              - amd,pensando-elba-ortano
+          - const: amd,pensando-elba
+
+additionalProperties: true
+
+...
-- 
2.17.1

