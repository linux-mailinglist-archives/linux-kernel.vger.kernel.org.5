Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166677B5BB6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjJBUG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJBUGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:06:25 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2217.outbound.protection.outlook.com [52.100.164.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FB2AC;
        Mon,  2 Oct 2023 13:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K40noMo+h179G3Dh1dxTD6ss3ioPvGH7Qmrk3K/4H241nQkKHShRed0Jc0gC+yjRYom51VmJbl0VoP42/TfPKavgCJBUmZXFux/nCRDW+ebnvTe0t15C+y8RjFYGxuTPbHpoA5zrkQiV1b3hCiHeKyxoaUyYOgg/CsdobubeOsKcPvIPMv9LMr8Zg0Nl+ZjZRGM3KA9NrEKm25nSlhM/W6nW0va+NtyrxlIYdqDfGwBEqQ332BtI1qfcS3bNIvU3w3qVFb1OxG/GssAoqWXybgtzdw2vLSex4TohzKZMiMr4nChC68wgKbKdbxAriAOVzdwTypQw+rHmZGtDevY2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kB6sD7Tg1vA5u7ClWBa1Vtm7Dz0yAQZmvUQO/v/5AU=;
 b=dcWa7TbIF2mTHpFFT0z+tuF7kxt6e3WdF8N7rf12lnkzzo8kE/XN3wCukxH9V5ENOxt1xYJUKBE64ojRP5DN5vvpyTHFateDbveXpwimtG+1Ok39H5iaitwO04R53o0E5W4P8zB0bYPYnY2y0lBqSEVPgbqNreGb+WP2v/QTWoroFt+S6kpjrQ0KK7dsN8qgR8dKYlHa7eCroluRlxNo1rMxf6v9YqQt4JsOIakwJ2goC0Chnvu6Hw9Fc3e8O0SLJti90DN7+wpY0M9jRn0L9R4CVdAw2Y6apBDqaNYwPWWWOqvspqYWk4/N9NZeb7FozuJAO8TPgResZyuYk/bl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=antmicro.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kB6sD7Tg1vA5u7ClWBa1Vtm7Dz0yAQZmvUQO/v/5AU=;
 b=IF027t69zadnrF2pO1h0VoTo/OeGpami6dkAvJt9v/Y9NExfOYFDocW+U4VCM64cNSqXKhb5GUbKNQUJLcAIn1DKKpyvMxSTcWaFG3bDNSUbbUGZBT8Ioa2p/NtK5J+MxPMDO0vVbnwZqPN7DjpqWH0vUkRUViOygybhVEgWJak=
Received: from SG2PR02CA0112.apcprd02.prod.outlook.com (2603:1096:4:92::28) by
 TYSPR03MB7451.apcprd03.prod.outlook.com (2603:1096:400:40f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.32; Mon, 2 Oct 2023 20:06:15 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:92:cafe::b1) by SG2PR02CA0112.outlook.office365.com
 (2603:1096:4:92::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 2 Oct 2023 20:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 20:06:14 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 3
 Oct 2023 04:06:13 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 04:06:13 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 7DC336473F; Mon,  2 Oct 2023 23:06:12 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <ulf.hansson@linaro.org>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <adrian.hunter@intel.com>, <skhan@linuxfoundation.org>,
        <davidgow@google.com>, <pbrobinson@gmail.com>, <gsomlo@gmail.com>,
        <briannorris@chromium.org>, <arnd@arndb.de>,
        <krakoczy@antmicro.com>, <andy.shevchenko@gmail.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v5 0/2] add NPCM SDHCI driver support
Date:   Mon, 2 Oct 2023 23:06:08 +0300
Message-ID: <20231002200610.129799-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[175.98.123.7];domain=NTHCCAS04.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|TYSPR03MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: f51346d0-1b5f-4e5f-813f-08dbc38307f5
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HZgqERuf1fU4oIiDSCUgOZOGsJMpu8lMxSE7jyubDrCdho4YT5Zi636TI2WJ?=
 =?us-ascii?Q?E03vcZfbP+/kJzFjBaHVzHq5e+PPyIAP0qCw7fJqn3+1WSwKsuqW55hs1dEh?=
 =?us-ascii?Q?w0hyfi3eD+7IqviSMOWq/W848A9SyyomNvln9m0urfMBp2Qyqin3oF7sG/PS?=
 =?us-ascii?Q?kl5gC4vQpjHnyXPxutTQjwthTKeisxlzakTbgqc5CJXXKzGOixBysluV6JMy?=
 =?us-ascii?Q?l3sVdyFC+9vK/ow30BJ47H/s4H5SRaH6ufA5G+50Jw/+P0Bw3LamPVmFAwnZ?=
 =?us-ascii?Q?5lzxJfuNWEpdYzDifAgNWhtDEtiJv2kQg2OzSiQfA+Mi7MduzRJ0HjiCg1Jw?=
 =?us-ascii?Q?i2KRJW7SejS2riBXe0oqop+2vUPG2Gj9i7fNSZeUrgBDKLtdvAviwRIy0t8e?=
 =?us-ascii?Q?oLRL7lNtFWPtYI2m+7dV7pt274W3Jqtyr8Pt1Splnn9ajIUZmlM7y0+EUQjN?=
 =?us-ascii?Q?a1fCDceoQIq0mWL5BvvhbuSAM8p61SE3tEujGv8bEO6Ss2GZO2fqTnfCvFNU?=
 =?us-ascii?Q?YYh5RGJqdBKt0mt5fkN+CpfIM1GwlVLyUgQRjYonNM7Qp64Fy09jcmu2sEV/?=
 =?us-ascii?Q?ET4c91YYiuUFS05A4MwxervPaERmon6X9VDxzVO42jl4R5aXKiYaiS3b3RE3?=
 =?us-ascii?Q?QoPX/LPWiPWcL7M2uzyDi9NTZ6kOI3ZUJXT0sv08Ebw0IknX7PTE1PfWzSL9?=
 =?us-ascii?Q?pkJzcOGFIrCTtwBpPIePuQ3ttrca6VQ07KQZVs3RX/eK5iSfhD07CM6oDQYP?=
 =?us-ascii?Q?R1Vw/T0Bk62vSZv7PXecPEbFUkC0Aan0P4GMniQ2tk/081oMTXQY7MVCv5Lt?=
 =?us-ascii?Q?EQnxGVWutYtZyA6dLqnwmFNw5tbyKaJf5G6gNo3s6y1dYH8Auy/tccyoSvan?=
 =?us-ascii?Q?Hc6IAlauY5Uf6uhzKrCnCvWn2Uzbpg2oyGrr+J5NCzux4bcRdzpdOCcSeOGJ?=
 =?us-ascii?Q?1e6ISgj6AJffXGCfNMGjXk0pnfwt03wDw0FLNiyNGM0=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(48200799006)(451199024)(61400799006)(5400799018)(82310400011)(186009)(46966006)(40470700004)(36840700001)(6636002)(54906003)(42186006)(76482006)(70206006)(70586007)(110136005)(26005)(82202003)(1076003)(2616005)(83380400001)(336012)(36756003)(921005)(73392003)(42882007)(6266002)(6666004)(36860700001)(83170400001)(81166007)(40480700001)(82740400003)(55446002)(34020700004)(47076005)(356005)(478600001)(966005)(40460700003)(316002)(2906002)(7416002)(4326008)(8676002)(8936002)(41300700001)(5660300002)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 20:06:14.3625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f51346d0-1b5f-4e5f-813f-08dbc38307f5
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7451
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds SDHCI support for the Nuvoton NPCM Baseboard 
Management Controller (BMC).

Deeply sorry it took that long until sending version three, promise to try
to do better on the next versions (if needed) :-),

The NPCM SDHCI driver tested on NPCM750 and NPCM845 EVB.

Addressed comments from:
 - Andy Shevchenko : https://www.spinics.net/lists/devicetree/msg638000.html

Changes since version 4:
 - Remove unnecessary clk_disable_unprepare function.

Changes since version 3:
 - Use devm_clk_get_optional_enabled function.
 - Add mod_devicetable.h.
 - Modify copyright year.

Changes since version 2:
 - Add data to handle architecture-specific SDHCI parameters.
 - Change config place in make and kconfig files.
 - Calling sdhci_pltfm_free to to avoid a memory leak on error.

Changes since version 1:
 - Use correct spaces in the dt-bindings.
 - Drop unused labels from dt-bindings.
 - Order by module name in the make a configuration.
 - Remove unnecessary blank lines.
 - Using devm_clk_get_optional instead of devm_clk_get.

Tomer Maimon (2):
  dt-bindings: mmc: npcm,sdhci: Document NPCM SDHCI controller
  mmc: sdhci-npcm: Add NPCM SDHCI driver

 .../devicetree/bindings/mmc/npcm,sdhci.yaml   | 45 +++++++++
 drivers/mmc/host/Kconfig                      |  8 ++
 drivers/mmc/host/Makefile                     |  1 +
 drivers/mmc/host/sdhci-npcm.c                 | 94 +++++++++++++++++++
 4 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-npcm.c

-- 
2.33.0

