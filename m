Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29117B582B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbjJBQOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238434AbjJBQOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:14:00 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2203.outbound.protection.outlook.com [52.100.0.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACD2B8;
        Mon,  2 Oct 2023 09:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+ZbfGDwbr6AM9qsTkfYKBNyUTOihWuhoDPuhTYV+CF4uDXI6KYIbKxHljwDFzck9cwxQlnmeeFGIqWPu2iTunXvx4l8nlxKf6ARZP4wKt62HdUZ/uGPE4KxEvA8p3SVHU7hyMQ9qf+05SWgXdddd5DUqmqXrKm8H3hACcOPewkrLCWeFLjuWQfoTgSnUePVbYxmaMT2JdQK9FpDrQOOG1yUyk0qUY6Vt2zG5Em98iRfhzHE75b/wiVQ0z4p0EyX8oldU2NZgL04zGyXhk7wOfSmZyru7P0X7IMjilsZqzHxaBVvS87oGhli5+l7taAmTDGA+Z8a5I8RhWGkf9KcQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz+pGrPTo6Q9RvIRMbYVOzaNL3wCvgPOckPVvpbShwk=;
 b=OLxSMRZwaWnXDLXX3gt0NYMP+5WHa8m3N5yqhM9QW1xBj5YNQpdJa30lIBvwYQeRIDmPHDzwXeM5zsoC3sd5nwaQgdyM6CBT5P9uP/uUlh1Offbr/qyhez17QdAeZT4S4tJwF/WUJaYvTlxSOnoadlRx63ZoQRevB1VQQOY7FP6ZPltpNXmZsKQX8WtFQx2WvyTkqJM8pyervPlc8F9aidDGi23PsuffYwhpY9sXKaH7a2cZgm370gPgXtccYEoclErva3DY1MaYSrNK1u6DUEVIbxTdSui5lE/5NJD10V+ZhEZ2ZAA9w6XEadyw91LLCnATwSUAmZLlPD0/wEONfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz+pGrPTo6Q9RvIRMbYVOzaNL3wCvgPOckPVvpbShwk=;
 b=HCTONKSQOKFtP+s9pnqpRy1quQEDzp0zjA+9y4x0jiIo5D2Nq/IHOTpbpKaeLb8HnAnY6o8ar8G63xVX1u5TRMCLdUAvv6lJKggw7Og7l9PwSPz31+o+WsoKQ7iiloWWXtZwAtlMQmvqO//IpDL2QSBVRY/baAnbNzZVltpMP+Y=
Received: from SG2PR02CA0025.apcprd02.prod.outlook.com (2603:1096:3:18::13) by
 KL1PR03MB7526.apcprd03.prod.outlook.com (2603:1096:820:e6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.25; Mon, 2 Oct 2023 16:13:54 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:3:18:cafe::90) by SG2PR02CA0025.outlook.office365.com
 (2603:1096:3:18::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32 via Frontend
 Transport; Mon, 2 Oct 2023 16:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Mon, 2 Oct 2023 16:13:54 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 00:13:53 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 00:13:53 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 70CF36473F; Mon,  2 Oct 2023 19:13:52 +0300 (IDT)
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
Subject: [PATCH RESEND v3 0/3] usb: ChipIdea: add Nuvoton NPCM UDC support
Date:   Mon, 2 Oct 2023 19:13:47 +0300
Message-ID: <20231002161350.64229-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|KL1PR03MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e4942d-1d7c-4b44-2a72-08dbc3629312
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K3Q8IBneLAipaLw0qw9GzcuEiEUs23ID4A6y05G+TvwLzcOsxIbkPBKU1IYY?=
 =?us-ascii?Q?jyDD34NRRXP9pfCbRDUQC0GHA8r11XDHeZp1JkC8aP8g/7DeeOi9mTE7BYvk?=
 =?us-ascii?Q?crh4R44Eto93mYOjxl8fBYNgNysaNlJflm4+FIU62mtRgelkbxc1qGo8GLkw?=
 =?us-ascii?Q?ykf4i2sACW8UpbgQ1rqOmPkIh6H66m6fKSa4GhKF7ostgjxHBOjIlzjeqWzX?=
 =?us-ascii?Q?yEWlfxdhYK1+RwLVT8uENgpqXXLmKL/Qzk+7DkcbYRUa3HtBs3lvrYxdXwgM?=
 =?us-ascii?Q?k9Gl1abHlg/GjtPbXP9S4JzfGsiTDDd+NPAK2UNn2jFupnQIvpsgQgK7GycM?=
 =?us-ascii?Q?S2V6gszbfD4rO/R60LdnnM7DwULKc6f/pdZz8heNLTuLdmEblJuD9yDcypT3?=
 =?us-ascii?Q?UewJi2OfcsbzHbQQVvO6qEttxaCaW+mslxWnXnm3mBQxXp3Gt3GUvTZkV5r0?=
 =?us-ascii?Q?YceQEXKTUMOQMfQTLwG9g82vn5t3hQ5oAViPY1DWxMhK7yd90h7XKv6PRyaO?=
 =?us-ascii?Q?/zhfjPfjwvqw26jJ7Bu5+wPfIzC8xu8awarkJ8NMgYyxmYTS18OMJFVasQVM?=
 =?us-ascii?Q?XL3LKjevolkngsOZxnN2YCNTIBxSZom6bsFUuKRXo+JrNso2gVYfLN0EHdzF?=
 =?us-ascii?Q?CQzpVPHdp7TRW5IIUdFo5r3d4m4pz4PHLP1FPtsbu+mbJSc5bI3P0oyM/GYE?=
 =?us-ascii?Q?k6Bpn/SgNxidJbCurKYV3wwFOvZiQ+PCOQvwEPZwDCAUHW4HtfwQet2ReOOF?=
 =?us-ascii?Q?sndiW7ix2QhaP1abylIGbtjd19m9zhYnlDwR6mQhpY+qtncXMbFmxIKYCnAL?=
 =?us-ascii?Q?rmxxHfp5HCi4BH5knzaCOD5oIpg2CxYIudtB1phdixvIbnO2zEJdyMTer6Wb?=
 =?us-ascii?Q?EhBe5ocu5YM65y8aGE2q9HhUzr8VRkaHMN5q9LlDZM0T5x+viCz3pZjWUjfH?=
 =?us-ascii?Q?FQRozRGB98OtX2my9/589A=3D=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(451199024)(5400799018)(186009)(61400799006)(48200799006)(46966006)(40470700004)(36840700001)(42882007)(73392003)(6266002)(336012)(34020700004)(8936002)(8676002)(5660300002)(4326008)(921005)(47076005)(356005)(82740400003)(83380400001)(82202003)(2616005)(41300700001)(83170400001)(1076003)(81166007)(26005)(36860700001)(478600001)(6666004)(966005)(54906003)(70586007)(70206006)(316002)(76482006)(110136005)(42186006)(40480700001)(55446002)(36756003)(7416002)(40460700003)(2906002)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:13:54.3615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e4942d-1d7c-4b44-2a72-08dbc3629312
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7526
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

