Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8077B5744
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbjJBP7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbjJBP7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:59:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2209.outbound.protection.outlook.com [52.100.164.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D3EDC;
        Mon,  2 Oct 2023 08:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXGDfR19/AIIRx5DqO51pZZUfM8r20VCcaB++W0s4ItH5gfuiVMJj9m5Hb4zs/f+njgusWW7vjlrYhQ/BB6vpqzTRdVQoTDTg8IrGWt46rIavnPEWi6t0qvt5V8uKr/zAS50mUSLCMeAqu5AjMgdiiDOmBusHjAH3N67c0iBTNDh3kMdlRzj0VsSaBWfraOowhVW17KGdip+AS9s8eF/fNQlCNXLsFiNFrsGhgh7LTLCyK6q6Mimx7x/AfjSaUrPjF1RmlJvOUGY5WFDwD3zc80NhDipg0DF7UyfD5h3a6+lXZDghGly2gjOjvWScTPo8gR/nHBiO74pRur2ufkGzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz+pGrPTo6Q9RvIRMbYVOzaNL3wCvgPOckPVvpbShwk=;
 b=BNzDC+9IjlxKp4Bk8uyPXdePvd+obRfqOduDG9xYjbp41WN0frUHXEuRuQSthg2Kc5E+lcoYIvlCws/VR/c6Oc6053oIATltQpATnqXIyaKbG+/QImrZYXfhoQwARgRSYgs/1JhCyxJGFeu6zt/UY865gLRTRM4qg3veoXrtawQ0or2wZ6k1N8B9/8/KQyCry5al4vk9gquJWFfSv+p3cuSqzqomdJn4msWvBlzJtKYBFrQhdtgI/sR7OgmuDUTiqqWlhwELGDLFJaal8TVlYUak45gcIBfNnwE8A4o4NTJvKntA5oYU7ZWjIF0M57RGUnTcaTBGolQnOCsSKDvOPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz+pGrPTo6Q9RvIRMbYVOzaNL3wCvgPOckPVvpbShwk=;
 b=RC/zGPZEu4wHsbWdVvnYZio64G8Ajc4iqhGs29waE44tn0e0a7vP4vyIEGM02AzYU1xr8rVZRfpJQMGqSazBjo5BAmI/sdbvn3v23PdU0zNQb2hWDM+kPY4EZuDE5JgTFWiN0GhXfNJTxMi/Twh4F0OzrXEPqJVZL67MJZQ5xjE=
Received: from SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) by SEZPR03MB6764.apcprd03.prod.outlook.com
 (2603:1096:101:67::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Mon, 2 Oct
 2023 15:58:53 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:8f:cafe::8d) by SG2PR01CA0141.outlook.office365.com
 (2603:1096:4:8f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 2 Oct 2023 15:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 15:58:52 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 2 Oct
 2023 23:58:52 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 2 Oct
 2023 23:58:51 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 2 Oct 2023 23:58:51 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id A4EA96473F; Mon,  2 Oct 2023 18:58:50 +0300 (IDT)
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
Subject: [PATCH v3 0/3] usb: ChipIdea: add Nuvoton NPCM UDC support
Date:   Mon, 2 Oct 2023 18:58:45 +0300
Message-ID: <20231002155848.62198-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|SEZPR03MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 4579838c-66a7-4d48-5adc-08dbc36079a9
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/4J5ITz2WNhXzfKKL+fGH3TQJ4jEkC6xYZH+DpkuFDHTgo4enFLUNSJ7n34i?=
 =?us-ascii?Q?+PPlK9n805giOHEeN7bBhFaIN2MLxIHJ1he9FTH6UzswQlsQxRSHAGP1u3XA?=
 =?us-ascii?Q?PBNOmmzSIrvVEE1O4JAK6TSlfCoet8m5ZMNABFz6PR59xOTMxo4Z0i+2W52n?=
 =?us-ascii?Q?aSU8N/it4rctPWmeGkBWOD37KHO9KG59NZEKkMnR/A+NV57S47CYnmw66i5m?=
 =?us-ascii?Q?63lnA5y1F+FJIbG+SRAd8bmYdFtKo+AHmC5xJqfwatJwvhm3cvt0wKO3EU0m?=
 =?us-ascii?Q?DIHSd02gwfEfmcAVmVYdLVnffA86OKPfNPhSwfEn/HpxyNst5H0Edx9f0pTL?=
 =?us-ascii?Q?/g95HDifaQYtxsNJkviay+A2d/hmQaA38zmntxcCXEqUa5a9XKZG+sgD4Lki?=
 =?us-ascii?Q?AXc96wpoiAZ0p7/ZxFKKYoWuYVdDenkr9MzD0CSwPYyzFNwjkGvmzOA++XCM?=
 =?us-ascii?Q?ibkwJ4goIjG+Q75fUOEXjlF4Hkwsq1i7iKA6m2B/IO45m57JbZy43gJwyfPE?=
 =?us-ascii?Q?jk8DwxjyyKQOTZRUPvcL2o2tQ8jrGcdlS1q/jt2rAVrLAg2yZkFvLI4xK0i/?=
 =?us-ascii?Q?ck4oZj4DmFHC6S81J4x9r6OGbYis30ZtXQGffRohA/1IS3k5tqBh9W+8nbRN?=
 =?us-ascii?Q?WypEUr0wS83BIDMuEbAt4PAiQH56w/GSOaHUJJ9Q7oueMLwwkPHs/LQYEZaH?=
 =?us-ascii?Q?uEPPKUK8j2SfmeC0jDT7GF9cVsjEhPgC5jvYWu5EvI/k4i0XkcMBKddhJ2zl?=
 =?us-ascii?Q?0GsZwBFki8Df/MiCMJJdy0mKwKc5aMpL3/5oxjXe0t7TNpfttfofMI/QB64/?=
 =?us-ascii?Q?aFSsfdrWCnPKvvCXjCxgEyo0XbBRRrF+vtS8Kd6AQfvv/Ok3L+oKpdYEJO72?=
 =?us-ascii?Q?xs5d0lRvUdeuYe0rTo5tjQPtWooBAavconSlPsTKY33+HnT6uJH0tEu2eO1+?=
 =?us-ascii?Q?GSg75xHEdgkNuE0qheZRlA=3D=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(5400799018)(82310400011)(451199024)(61400799006)(48200799006)(64100799003)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(6666004)(966005)(76482006)(478600001)(34020700004)(81166007)(47076005)(36860700001)(921005)(55446002)(41300700001)(356005)(82740400003)(7416002)(73392003)(1076003)(6266002)(83380400001)(36756003)(336012)(82202003)(2906002)(2616005)(42882007)(26005)(42186006)(83170400001)(5660300002)(316002)(8936002)(110136005)(54906003)(8676002)(70206006)(4326008)(70586007)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:58:52.7382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4579838c-66a7-4d48-5adc-08dbc36079a9
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6764
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

Addressed comments from:
 - Krzysztof Kozlowski : https://www.spinics.net/lists/kernel/msg4951321.html

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

