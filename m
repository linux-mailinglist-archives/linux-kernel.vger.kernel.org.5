Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED48B7CCCBE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjJQT7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjJQT7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:59:31 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2051.outbound.protection.outlook.com [40.107.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31430F0;
        Tue, 17 Oct 2023 12:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOvB7U45K+vafh1uOEKspC+4itMfEV/wvl0QXWBJ9/TRIhicVFWnOEaJfevIXIfBGHGDag8tmA9UrfNLBVH18XxXi3XU+zlkMJ8GkANzR29NReVi7+Fe0+0Gth3vWdCTV0oeiruOTI+JsrcoLDQcWXT45ZTdhe3crRsTA7I4Qzu2rBp4mRysm2Cijmwj1WZkrfGMJzRHNdaUYPB6hg7cZSBmBNjVra9KdXRrL5jqGJZFcJWcNwvVkTdD+jPCTX/VVQgnseZczpmx4Nanq72Y4A2iMyHDrc2r9B+Wfc3g8MA75Rc7ogzsGB147PypoQEHNem3jT+2O5skUb2mgEzh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qH4SxFRSuckPoXgIYXCPM9q1hTpt1F4OYpIVD2EW/30=;
 b=ALh9A1/1AJ9t65Qz/NgmJ/b8jwtQBx9YGirhdVGPVgcan2GthukevD87WYjvoT01KdumXX24KPc7kil1XAjuN3prt0EFILzG1DWp+pmkomZQmHeSz6uJiZG990D9e25pH65wTOIV07CvJ0yI3J24jDtMWi6h3uq7+8Kv4J6g60XnIMPzvVTSJZkwZ3WgTvbIfBKL1OL3yVAR89KkhNK9KD0q1paY1b1AeMqwUH7ufUYZ+OeKwjyeBTUXdrfFaz/8iLCNWypr4LAstrICKl5sNzAhA4GWw2a0sXvIbc1cJqmoKnj8+CDWY3ojzcYx7v/JHGaeJGkAW/SKUnITrrPhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qH4SxFRSuckPoXgIYXCPM9q1hTpt1F4OYpIVD2EW/30=;
 b=SY7ftcLhI6CcH2fgee+z9CmCgWPs81EdwzHZc4FYLA8Av9Bj8xNJUzP1KOTHTuWT3jy8FP2y+nxHocNYICEO+A6JToU7pSvtCURHIjlhUkYfgJjYUaAGTlKFWzae6HqImclPKvmN9fDV7a/R0fTFNoD3TF+u3eEAyXeYy1wKnnQ=
Received: from KL1P15301CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:820:3d::23)
 by TY0PR03MB6426.apcprd03.prod.outlook.com (2603:1096:400:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Tue, 17 Oct
 2023 19:59:26 +0000
Received: from HK2PEPF00006FB3.apcprd02.prod.outlook.com
 (2603:1096:820:3d:cafe::b3) by KL1P15301CA0051.outlook.office365.com
 (2603:1096:820:3d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.4 via Frontend
 Transport; Tue, 17 Oct 2023 19:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FB3.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 19:59:24 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Wed, 18
 Oct 2023 03:59:23 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 18 Oct 2023 03:59:23 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id DD9A568E43;
        Tue, 17 Oct 2023 22:59:22 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id B6CD521CFCCF; Tue, 17 Oct 2023 22:59:22 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <xu.yang_2@nxp.com>, <peng.fan@nxp.com>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v7 0/3] usb: ChipIdea: add Nuvoton NPCM UDC support
Date:   Tue, 17 Oct 2023 22:59:00 +0300
Message-ID: <20231017195903.1665260-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB3:EE_|TY0PR03MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: ec51e798-de99-41c1-9deb-08dbcf4b901d
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nisTFeSgInhngz3QTkZNKyuwJMoUXBt/OKeYMN5+F1/5kqgFvcQtpfpdSQIc1J3tLPL62FHt+7kpSIKRmKavYix1VUCV9TYO2kH2mle0Wa6equTxPdCXO9a3ecp6/5lmt1gk/vF+W/onWPhPspz3i2Q6UWpgSsM129HS9HBaWlhbiQOtntRQsxO4j5ZllyY6Za6gEB1UkDcbYcx1fgyAyPRMFA5MVmJdNPH4Hlajr3kT66XYhVCPLbt4yaHDyU0l33JS6KH9oqzOH9MWZVWVivc5xkIOJpKjGKOC9Cf4BA2Nhgb/RpRbLZgkaoZMUHaVXxrjgWfHNSxk9PjcHjj1V8MsEPi73hN3BbaYI4qlIhL1urp0RpJP2k6zcPl5O0tC4yUcNtbblGaVx2pS9Dfl/coEtQADnKaMctT+ZVQzsBMgcTjPJ+Z13DMqCyyXyBe+3Tlen9Q9KUKPBZojIYOgVeZ4sw5GNTJbCTxqG4vIXQtBvlKBDs4uvrfLCgshHNr3esu1HMgLnjedh/Bu+rj0A0PCK3d2Pgg/CQ8yc4Xr0MyqWI6QRkZDSWKLDYOkhqgkjEeDXr3nqGOKbEgvEL4CbSgqnKDel/tiSVu0tjrKQUU/EqKshck4/hn97+i2MoOEJuBCcRbU6I9QoXsgX1jSo6QH7QwX1Y0mgJxJbThCVt+rZ6BbrWz0arw4Tu6tOa5Ahp07LU5Tn/Tp4QgkiBGnUc6otTi5gtL73ZknZ+pvPTfoi51prhU3hb43FS5q1s047peHL+mAsO7i1P1775pvA9s77WRddjVVI07sB5eUYglN4oc/BH0XyBRYeHOKsjL3sDf/aDYHnl57+j1VBk6RxrbZxFgtH90P9CvJtw2VHUd/tDWyu9dInU4TBV9KXAcY
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(61400799006)(48200799006)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(1076003)(2616005)(82202003)(6266002)(8936002)(8676002)(4326008)(6666004)(966005)(478600001)(47076005)(42882007)(336012)(73392003)(83380400001)(26005)(55446002)(36860700001)(54906003)(70586007)(76482006)(110136005)(70206006)(316002)(40480700001)(36756003)(82740400003)(7416002)(41300700001)(2906002)(81166007)(40460700003)(356005)(921005)(42186006)(5660300002)(83170400001)(45356006)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:59:24.9945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec51e798-de99-41c1-9deb-08dbcf4b901d
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6426
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set add USB device controller for the NPCM Baseboard
Management Controllers (BMC).

NPCM UDC driver is a part of the USB ChipIdea driver.

Adding CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag to modify the vbus_active
parameter to active in case the ChipIdea USB IP role is device-only and
there is no otgsc register.

BMC NPCM7XX and BMC NPCM8XX has ten identical NPCM UDC modules,

The NPCM UDC were tested on NPCM845 evaluation board.

Addressed comments from:
 - Paul Menzel : https://www.spinics.net/lists/linux-usb/msg248033.html

Changes since version 6:
 - Modify commit message.
 - Modify debug event message.

Changes since version 5:
 - Remove unnecessary npcm845-udc compatible.

Changes since version 4:
 - Modify npcm845-udc compatible.

Changes since version 3:
 - Add Acked-by Peter Chen.
 
Changes since version 2:
 - Use dev_err_probe.
 - Remove MODULE_ALIAS.

Changes since version 1:
 - Add SoC specific compatible.
 - Remove USB phy mux property from dt-binding, will be handled differently.
 - Add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS commit to this patch set.

Tomer Maimon (3):
  usb: chipidea: add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag
  dt-bindings: usb: ci-hdrc-usb2: add npcm750 and npcm845 compatible
  usb: chipidea: Add support for NPCM

 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml |   6 +
 drivers/usb/chipidea/Kconfig                  |   4 +
 drivers/usb/chipidea/Makefile                 |   1 +
 drivers/usb/chipidea/ci_hdrc_npcm.c           | 114 ++++++++++++++++++
 drivers/usb/chipidea/otg.c                    |   5 +-
 include/linux/usb/chipidea.h                  |   1 +
 6 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/chipidea/ci_hdrc_npcm.c

-- 
2.33.0

