Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736E47796A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbjHKSFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbjHKSFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:05:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082372D78;
        Fri, 11 Aug 2023 11:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIXQdPSejCbnoSdeWNrBdBN5DaesrWThkZX2UDWFpYTQr2Usr2nQ0979nq3pcxsl//EqUqpJd262LPW50h7q2wkrtryng+jH1Acp6LxFCNFQ9Lw3ecL4QNwLPy82/GknqekcKc8NLksuM7IVeCE74Ais+CYH7chOYoaNsJBuy1XZlB2fupb8nCme8Tw434k4kqTCpfMefLmnRQGc9S9ix9OuN4LnesgS/GZ/XN/uYYpBgSYw4l6FPk6A+2/XnR8egUaccg65x4YUBYGcloHxNMu5DKhMaGKspHUc2l0GBRgvFe5s+c3CYwESflqnpyRNQ8Q12BdCkGnhtVPYZMnXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy28TcdtatfE39iP7KmaaFwO5+MCnCgUUyAylO9Y+RE=;
 b=MMtV0sl1z29gkyke3Yys7TJASfj6+1/NLDEfT7QUmUJOv43798aXiOGXbIEc9zrQHtxNAAuqYao8iHMt+HlokVAY/sjrsxK6SyLDSHV3T/Tc8WWa7QpMAaRjmOz7brC+tIeLAI8Ez/EUPgVgD5T1dQ9DWVteRj/EIRi9bAocR2vCh7l4B69XqR1KJkQhntamgxgmS9lvhBxbhmJnV14uHB1WnlweNvVYhtBXkOqj8NxWFJAik4EPb37b9iY0uioxlZo17No2K70EadLjBCRcqmGna1Bxgr+ttF+LGrohj8gJW95J/ZFQNBCYsWkQt68J8ugEp3YkNXY1Opkmrwvg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy28TcdtatfE39iP7KmaaFwO5+MCnCgUUyAylO9Y+RE=;
 b=ORL9StktDHvyvpLH/uUIDLqGL9J7sEjiKrlJICwRxiXBc3jwZlZ7tfbDGuj30QOur4dsFutY4mjHCzA7j+2DNzsmVdqg2wHRKJdK+YV3eCWO95Bx67hg/SHHJZy7c99EM1Gfmi7wVYhj/DJlh8mkGI1Sk5yeFwtlUOvaCNSyTyc=
Received: from SN4PR0501CA0129.namprd05.prod.outlook.com
 (2603:10b6:803:42::46) by SJ2PR12MB8873.namprd12.prod.outlook.com
 (2603:10b6:a03:53d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 18:05:38 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::f1) by SN4PR0501CA0129.outlook.office365.com
 (2603:10b6:803:42::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.22 via Frontend
 Transport; Fri, 11 Aug 2023 18:05:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 18:05:38 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 13:05:34 -0500
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
Subject: [PATCH v15 1/6] dt-bindings: arm: add AMD Pensando boards
Date:   Fri, 11 Aug 2023 11:05:14 -0700
Message-ID: <20230811180519.29644-2-blarson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: b9654bb8-646c-4b46-40a9-08db9a959179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ElIZPoUuvYHRItE7HBFidv7msCv0wXydsGeeZ2pluSiu8zR6t4TNkhQsPggTD4p/cTkXab41e5M/BUVJDOUQDXdcicEArKMYlYPKKGklY7FWSoesxC+oy9nNJ0zWN1zyb75c1Ltu8UtaDx3ms9HOjLDUoJB4vQCeS9MLi8sXhDAdbXBKLsExy+Vcc3aYy0R67LjAFVMLEYAobPjOqluBGatV3JSGhZV79N3Mh4RijUjbYJQ6bkPsyPY4KPwEaqOWFzDPFLEeYt0wpLmZrap1TVVpHivdH7rXgOSJzVevI9kO4q6ITbguvTE4v/ruza/02EUunI1b8jucSjUZVAExX7q/b7e4e2x0RhM0OJtLPPssARgAM74fofh1j9vYQETI/TpPAdXrJIfU5ywRUCcRntSh2RwU/WgbYPAQ/oR8GTuxa+IaTpJ2UpJD4rI4wBTYPj2pPWOiYcwqOJHPGqEdInCkWpSmKXUv8ypqrtLkXdDQp+DQvd7ft1vt6Tf/qBu9uKEVuT/cy+1vxentnuKSu0VvPaCb6b6Okx63U5UOFPO0pytwZC/eXmC1twHczyGq1VoIYA3COI4Dwk7liE64pOD38GLgOwQo0Lnc2I6aj+/hpLsk8TlcwP+2ObGjGIPtkozTQnxMnjSQLoqYNlaEuOrKWnAtyoHkH7tuwkf6aTsodHV6VseKugi8iWkgs21fbg32rKzM5wKP6qcWEZNeEFcKGd5c6aDdNkpacPA9Y6hjQ2TskxK+tBP9C6KCi4w+EpDpZOp77R5MyaQkN3KL13/UYfD5KEbnz+6/tTCOTME=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(82310400008)(1800799006)(451199021)(186006)(46966006)(36840700001)(40470700004)(8676002)(8936002)(26005)(1076003)(41300700001)(82740400003)(40460700003)(36860700001)(47076005)(36756003)(2906002)(426003)(356005)(81166007)(2616005)(7416002)(7406005)(16526019)(336012)(5660300002)(70586007)(70206006)(6916009)(40480700001)(4326008)(966005)(54906003)(6666004)(478600001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:05:38.3879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9654bb8-646c-4b46-40a9-08db9a959179
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

