Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3D17A5024
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjIRRAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjIRRAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:00:15 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2051.outbound.protection.outlook.com [40.107.215.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A825FB;
        Mon, 18 Sep 2023 10:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luj+v2LZusX6xUg1qxJBpgluZgkdNbUFXBcSfhRvlYlmLNJfpz0GDQ/DfJUQDMRyY6GBmthZgDWkX+tMsQ7u/Avcq1MstiOOLfB/VNKmp/S+uaFmKMcjqvFvmR1FLv3PizhAXnZgk15dcd5I96Tdg0qP+rf34QNSCUqoUu6bxeSGd4MCgr6tc1qTrtm7hlIW4+oZyQxsJRoO3FAxg9wlDfMw9MlgvnYAsbsdCJEQu3h7GZmXPnk2obVgxTBueqIzeF8yD5YJGnXJ6KamHFeTpNZK9StmN0EuBKcrb0M2um0HPRjf1xfJiLw4a+ov5cXg6iR2r6TDN2/HOR0Ibvgwew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/26KH+EA6lvFQEO/nQIYrlOHn756T3Ld0n5AaeE/Wk=;
 b=MZiGSu0y30BA6oHdmVoFtfgM2dlngyf1hYUq2X/0jzMkmeQMfFgG8IGVqq/26VixcL2Gn8L0qKdK3r5wi2GYAot6Dmkp+GKldASD1eTydWXfRJo7M5qegD8CkxT1XIOhWJV7SBHElKGUpEOVbkLQS5DLD9LpFdeozI5TFjKBIG3qxLTCXiaWhvbd510njzo96fzEIyuEED7MKCRLreM6XJ9ODnDWkmuvQvADj9qx2SGhe1lvc1N1czbnlculBvNA20UiWNk9yg9gMqcCvuC9uV2CssTMhBz1F6z+M7iJtNg0QbdQ7yHu6UBGq5lDe3cC+HRPmOMTdzT1RQwyOo5rOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/26KH+EA6lvFQEO/nQIYrlOHn756T3Ld0n5AaeE/Wk=;
 b=EszytZzPru4MAb0fDIjnwGAYqLwK0EIKEuf4DuAI9/p/t6PQsrq6EN69c62+s4JHzRoE/H+QLQahmK1g90bGRWmlWxhG7pPyYh8rZCyENPmx33C9RUhMlgq/xLhoxTVudqE9Msky3mZG/oQa+UJbR/XYWkT6SD+/58dZuWqR28M=
Received: from SI2PR02CA0039.apcprd02.prod.outlook.com (2603:1096:4:196::9) by
 TYZPR03MB5584.apcprd03.prod.outlook.com (2603:1096:400:57::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Mon, 18 Sep 2023 17:00:03 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:196:cafe::72) by SI2PR02CA0039.outlook.office365.com
 (2603:1096:4:196::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26 via Frontend
 Transport; Mon, 18 Sep 2023 17:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 17:00:02 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 19
 Sep 2023 01:00:01 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 19 Sep 2023 01:00:01 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 5F1706473F; Mon, 18 Sep 2023 20:00:00 +0300 (IDT)
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
Subject: [PATCH v1 0/2] usb: ChipIdea: add Nuvoton NPCM UDC support
Date:   Mon, 18 Sep 2023 19:59:56 +0300
Message-ID: <20230918165958.2659-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYZPR03MB5584:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c08622d-e08c-4324-5c3e-08dbb868b31e
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8usqIWzlSpTk2He16B9riaX0X5aKz9xA6WMd7hfO4AEYM7R4IpzdlUjDlnbk6YZYclxLXGoXsx2KtQWZc6fzbDDdtHZKWsPtxXXHo7lm66lI+IpvXw3tMTGQsp2OiZ8RxQsywrlVGH5m87RODk+eGFDtXxUzkg9eZ5xmnlU67qWa0k9Tq9ugyswD0A6QoFinhe2tsZXeUWKPO7mYaBaywNQfWFXlmRFuJOdhhq9h2lMcbu6ubxWEiolm0WoO+PpBB16wp5L10UF1IXDwYuG39BSJGawWlMZcP7vqd4r7Dh6vFlDTuzeIWL+ZJ9dVsj/F/CTKQR7VHgdTcLJk+KiiUY88qSOYdwCDqCJhzwkdAxIscd6O2LFX0KhPHby4Kz1BoRUvPwgmS85c2czMd0bZU+ONd08xAkSWsGGYQ5PF3xSgK8bU8UyvnLLXNWxd34YyrZbGiTxHQpUI1Ofu7SN8CkWvqMbFWDyZ4JxhlyNhtnp+sbBDOsbwv47DD8ViN51ydZf7UM2+1/kC6y99dh4RGehRz3ZR8skv66lPjZlmHOQZ2dGbT7ICGZ2LLV6cVBUpEEzXpAvwllbMr6baw2JwsRxvtCoAIIrY0jkjQZ4i2zNi6O0+zP7D/5xh6TDupHmMRvTLr5ua/hPyp4CMWWxtg70pzU6DQJJqm6WzODL4pS2NzINO+LMJFFP+vEhB337TDyGDrTi8zQFNARFnIvXkYBwKVbtOBJs45rxJR3wxc6TNnZjA1a7iTXyZWpL1BXINQ3XKZd9fSAYSwWHsBE5uqfliSkJQZTa3W7lkuLHnCbxkSVJhxCzrCAm28Y6M4TIrCsovX1pzUS99P6h9dsMOh1RLypUSjjC3+VzFXEpVV1bIh4Or8vy6JpvlG3TJ5nAYM/AwutMVwJo9djx63s2RAQ==
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(61400799006)(48200799006)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(7416002)(336012)(73392003)(6266002)(42882007)(36756003)(40460700003)(83170400001)(921005)(81166007)(356005)(40480700001)(47076005)(2906002)(4744005)(82740400003)(36860700001)(41300700001)(2616005)(54906003)(70206006)(42186006)(70586007)(110136005)(316002)(76482006)(26005)(55446002)(478600001)(5660300002)(6666004)(4326008)(8676002)(8936002)(82202003)(1076003)(45356006)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:00:02.2559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c08622d-e08c-4324-5c3e-08dbb868b31e
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5584
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

The NPCM UDC is using the CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag
therefor, this patch set should apply after  
usb: chipidea: add CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag commit will
apply.

BMC NPCM7XX and BMC NPCM8XX has ten identical NPCM UDC modules,

The NPCM UDC were tested on NPCM845 evaluation board.

Tomer Maimon (2):
  dt-binding: usb: ci-hdrc-usb2: document Nuvoton NPCM supprt
  usb: chipidea: Add support for NPCM

 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml |  16 +++
 drivers/usb/chipidea/Kconfig                  |   4 +
 drivers/usb/chipidea/Makefile                 |   1 +
 drivers/usb/chipidea/ci_hdrc_npcm.c           | 126 ++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 drivers/usb/chipidea/ci_hdrc_npcm.c

-- 
2.33.0

