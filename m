Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88C77B66FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbjJCLBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjJCLBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:01:44 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2223.outbound.protection.outlook.com [52.100.164.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D219EA1;
        Tue,  3 Oct 2023 04:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqghx1C5/Ht5E0ZowINqjM3wiLIOiFo2NTgs8utTRLWi+nE1CgC/IlC4MHg4+dQrWQkeVNwadLUTe69O7VnlKDrIqxPlF8F48H29ymAAateLc1UuOJ7B5w6Jsa2lmlXkxud9Dwnvp9vTDy+E/YXLvgMYP0pc5b655yy913u3KxXlBsKJ/qnnILTTZtDNMkN5gQlvhYlcE5Q3msqQNQPbuZfBBR5pidPqYnR0KjdeclEDEp58U/Dc40DQk6OIMRS9wZP1npRJ9sqbxgT8l/hVC6YGrBnnWZX4psVfpUeBXgVGtoOewLlNrmt3u1W1v3IV0BbEkBttCb7TnHD5ubNyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pPOL7raKLXjZLUgZiYFFdU43gLiX6pNkoAa7Z1XW5M=;
 b=m3sBUosp4Iv/UKW4Scxvn/yAQu7ywLx3StKRLJj/wknfMQIkLqnoSs2OljAcvKVcG7H/3ZAOCtUg2briKwZnBdpVyfFlbDgkDL/dbGobMsGza39iVr/GtLnjko7rCqZqf2p5xQm+qTdhlpOnd6QE7VZoCPLRKittGeOADzDtzVlYQ2ZstLHaWjsAaVtRU4j+OkDZm/aXYyC6CH3tNKwF7UADhw2X3piOCC82eoPkVAFGJ0QGIjeOaiL97+uhbRoE5zyRt5T0OdY7hB3lBKGVAYPval4y7Yp8JJOh4k0QZFE73DR/SCXRSDGP29Ks+P+2MRGe8nmLTa/xw1Kfc24NKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pPOL7raKLXjZLUgZiYFFdU43gLiX6pNkoAa7Z1XW5M=;
 b=jQ0DSVOncRkPre6WX7/txGp6/q+DH8/eclMQ3rU2pYGn6dU6x51vsQH1ViilTcCvZ+DgCDLBDWai5KVz9c3/5jA1EiAmwkCUo5PtzUlmqyzYv7h9Wy7oHKk4X8DwaAiRMfpCGMvPz6aWT3qok7IuNqQOoVe9+s4z8GbzCzp9IGw=
Received: from SG2PR03CA0125.apcprd03.prod.outlook.com (2603:1096:4:91::29) by
 TY0PR03MB6305.apcprd03.prod.outlook.com (2603:1096:400:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 11:01:36 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:91:cafe::34) by SG2PR03CA0125.outlook.office365.com
 (2603:1096:4:91::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.24 via Frontend
 Transport; Tue, 3 Oct 2023 11:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 11:01:36 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 3
 Oct 2023 19:01:35 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 3 Oct
 2023 19:01:35 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 19:01:35 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 663D264740; Tue,  3 Oct 2023 14:01:34 +0300 (IDT)
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
Subject: [PATCH v4 0/3] usb: ChipIdea: add Nuvoton NPCM UDC support
Date:   Tue, 3 Oct 2023 14:01:27 +0300
Message-ID: <20231003110130.229711-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[175.98.123.7];domain=NTHCCAS04.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|TY0PR03MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f93cbf-096d-4a9f-47af-08dbc4001cd9
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yraDvl6UxWJBQVt+TY6szGP/9+HntDtihLjz55DTD+tzZcjmgjbAm3nli0uP?=
 =?us-ascii?Q?HCuI878XlA3khz5aHI6PAKJXOvDMAP/+RcV+7CwXQzBGZlaRg95DWz1ZiQEV?=
 =?us-ascii?Q?+48CoObENs+DUgsclF6qXoQMq43frSdQ8GjfPbzqKw/EA7PS8WsBrR9xlOpy?=
 =?us-ascii?Q?oVnoMjSx7yXqmf9BbB6xsPZeojxprvewc3yUcnlhzc+xtXa3qotn3GprwSbu?=
 =?us-ascii?Q?ZNedbbjQZttZE4Piei+x/AYPL6eiOzNptSHHgxWiPXdO2dKLXm8MyDmHAa8A?=
 =?us-ascii?Q?hydBsU0OXBOILpvae2koFLJwWogs/ph20WVjYs+i80EhVbyOoAMBCF4i4J8v?=
 =?us-ascii?Q?L+FNtERnYf2t32otqJ0U8f+PZglwRu0iSdi3ApNvMHEi9rBkzeg4jB/ZLP68?=
 =?us-ascii?Q?WeSEaHRP3TaZ8z1fxWkVHKxMSccDHhS4gM8L2FyC3nupENPq+IEU4id47hCx?=
 =?us-ascii?Q?fY3j4udtzyP5RWAjqssR+cseeMt1IRTF3xPw+mQWchlCVFVg7e75gfvXRXja?=
 =?us-ascii?Q?/S1LbseIfvXBHyjr9/xPmgu6n9vX2L/WpT8tReGg3/aLHbtl7DKkhosncnSv?=
 =?us-ascii?Q?FydV42a1FoMb6RM0sTvRAdE/Jiw/cZDm4+u5xBz2jRS1rmJTsiWNT3R5TJQd?=
 =?us-ascii?Q?fUQVKLzf3NN1FJkfccFGc71PfCfLvf1WYDqC3E4rLv+KQ4+16UOb6U2ypZzr?=
 =?us-ascii?Q?SicGtf3LMSHvDNUpCbRm7v4YuPhRMBEWUwCqD42JvbFSIEgmpvH4y5AV+z65?=
 =?us-ascii?Q?AZB4ATzKejtnASQU5AXrQhdRbHaNas/kBuioTfYfCutXPOedsitqfq4WhD2o?=
 =?us-ascii?Q?u6nLN/tb1NQLHQsULApdh9imCMf2zla49+NDXV8uNoxT2HGlVXJu+nZrCS9s?=
 =?us-ascii?Q?JZmQ1AEs2MlxrC8dubzjKroxtyGBhYofoFqVVuBgN79hRYeyiQTdOahgLPsT?=
 =?us-ascii?Q?Mfst1zHTL7B7RxS02bSvWC6MIPxXNaSZnX3ZHF+C/38=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(5400799018)(82310400011)(186009)(61400799006)(48200799006)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(478600001)(76482006)(6666004)(6266002)(47076005)(34020700004)(36860700001)(81166007)(921005)(55446002)(82740400003)(356005)(83170400001)(2906002)(7416002)(83380400001)(73392003)(42882007)(336012)(26005)(1076003)(82202003)(2616005)(36756003)(54906003)(70206006)(5660300002)(42186006)(70586007)(41300700001)(110136005)(316002)(4326008)(8936002)(8676002)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 11:01:36.4540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f93cbf-096d-4a9f-47af-08dbc4001cd9
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6305
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

This patch set add USB device controller for the NPCM Baseboard
Management Controllers (BMC).

NPCM UDC driver is a part of the USB ChipIdea driver.

Adding CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag to modify the vbus_active
parameter to active in case the ChipIdea USB IP role is device-only and
there is no otgsc register.

BMC NPCM7XX and BMC NPCM8XX has ten identical NPCM UDC modules,

The NPCM UDC were tested on NPCM845 evaluation board.

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

 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml |   4 +
 drivers/usb/chipidea/Kconfig                  |   4 +
 drivers/usb/chipidea/Makefile                 |   1 +
 drivers/usb/chipidea/ci_hdrc_npcm.c           | 114 ++++++++++++++++++
 drivers/usb/chipidea/otg.c                    |   5 +-
 include/linux/usb/chipidea.h                  |   1 +
 6 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/chipidea/ci_hdrc_npcm.c

-- 
2.33.0

