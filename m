Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332887B0B35
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjI0RjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjI0RjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:39:07 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2213.outbound.protection.outlook.com [52.100.164.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE6A10E;
        Wed, 27 Sep 2023 10:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0l/h6vGt06x5SLtUMiGlv4mTgZcas+mMmAP8GRGqw+rXepuh7beyPyzxuCgVt9fdJINN/jhT5RRk+oXu9p3XfsRoU8ia3F3pKARVFAvFpfk1p0WzsArlykgT6wydbOS3/5IR5zKqytYseO5D1aUUHSELMvl7wUP0uSoqPtIOw/VFG98C4vg4RYQ/o2c6UtpxbBazDSHmi3xaMF5UiiHBVEFSyfFOgB+Ss0v6qBZXdvqPOPTuJSNKqltutKN9U8e9L/snDgnCN8AZ68Iq3MV/VAJNrXknj0TYj/77eA/uT/aG8IqzAOzKrjz9okQYuJ4OChPl4EHb21uNDTGr5DiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JEyyYBL97TFBQGTiv25bcpeSp4AkOMpQanakUxFg4Q=;
 b=DJnZLhki1Xr59RW/cyvswFvK1iYSR3xlqazifJ+GataSzLxBWUVJzivhbqSmyxkfO0RQVnAPZ+AjkcDOjc/ddfcFBEtklTwDkzaKyUHqlBCr2/vlmcaPbU3sIXh3kNKR5M83MvzO83eH4TpWNW24EZQTI1C5tVKfn0kuO+8pu4t5SaxrJH5fOByi5YRgSTWbwhOgG7lya/YBmIRH8BAxoT65Yys99PlBcMRtjlHjS0VtxUkXySvnZ6hcZkFAMMpFWR0OmPbVw3/nABWHY2RVwk0PqpSecUnL/mEYIoCVeCp4mTzjDugoJMKgiE+cRTLLeiSQxw6lunpCaKLhRsWAOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nuvoton.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JEyyYBL97TFBQGTiv25bcpeSp4AkOMpQanakUxFg4Q=;
 b=ZTQ/BkIY/yULXTFOVGIo1/pWXp6qBuFIRspwEgrYUFcTd0uoHjrT4o/E9y4sKcSrv7Zj1ifyHv9R/ABvniRiZvex0SQCrPg4ZU8v/z5NIb3sLPiFJ77Z0RzMfps9qHhIfdTV68DTVzPV0THBAnsbfShR6df0huxerL1XPDLL13g=
Received: from SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6) by
 KL1PR03MB6237.apcprd03.prod.outlook.com (2603:1096:820:a0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21; Wed, 27 Sep 2023 17:39:01 +0000
Received: from SG1PEPF000082E8.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::34) by SG2P153CA0019.outlook.office365.com
 (2603:1096:4:c7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.11 via Frontend
 Transport; Wed, 27 Sep 2023 17:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E8.mail.protection.outlook.com (10.167.240.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 17:39:00 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 28 Sep
 2023 01:39:00 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Thu, 28 Sep
 2023 01:38:59 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 28 Sep 2023 01:38:59 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id DB4C664741; Wed, 27 Sep 2023 20:38:53 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>,
        <andrew@codeconstruct.com.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: hwmon: npcm: Add npcm845 compatible string
Date:   Wed, 27 Sep 2023 20:38:49 +0300
Message-ID: <20230927173850.103435-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230927173850.103435-1-tmaimon77@gmail.com>
References: <20230927173850.103435-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E8:EE_|KL1PR03MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: e97898c6-c032-467a-6618-08dbbf80a2ac
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+DYK6dzG1svfEG5zfgf+LoKA8Eotdy1H49UAN+6tKiLN9yx5aUG1vv0LASrK?=
 =?us-ascii?Q?wnOhyiMo+8uJJ7Y2i5bvUXp0KDaRvM1enZBmr7kv5bW5ErhtpXF489j3etkU?=
 =?us-ascii?Q?Uzx7oqx6xRlrWOQ0YM+F/7x/PY437F++ZVga5rUCiFpNp7L9rJjUoh6QiP61?=
 =?us-ascii?Q?ypYn2Ws0gPH3GAdkx7KKxepccgfshLVjV5fyjRTY6o/ljXYIH6c//U9dZxRp?=
 =?us-ascii?Q?O41mqpXFCkYeM4OZDnVWvldEIWRqDoNcHaRQbt2aChvlIFdyX/6BgGg1cxAl?=
 =?us-ascii?Q?DHbiY0KqY1hy4PezoO3x1775a5KzY1P+Cl9cR0TXIDLUN2JvMtx0Vlmz/DNq?=
 =?us-ascii?Q?0lWd2PtdCObzzhDLC+Sh6dW7rpDzuwCtUBM0O60nLI4Wk9qATxm2DhkleW08?=
 =?us-ascii?Q?MFlAZa+sD9YBIp7gV1dwd76LM8ClQESunMnNdB/3W9uaOpAEjTylyx8rlI5s?=
 =?us-ascii?Q?AXxPLKc28IiPBXJAinrl4ubPczo2ky7vt9a6082mOJSy5lkVevtRA8IF++wD?=
 =?us-ascii?Q?Dl9FjOUbESMilFW0pPUjlhv6+ICoNSFw3TybReKKBChZ6xdjzjRomoEW8lCK?=
 =?us-ascii?Q?iErELdK26CZc4SlMA1g1M6UGBGKN49J2SqYmm7p2w26KoPpYiAAo1xgKfswq?=
 =?us-ascii?Q?AtKf6OmXXXEuzknUWlzSSHipdaxSNdOWfB1mAVaK1T0po7raCeTDBNPcvtOP?=
 =?us-ascii?Q?6eC8mmjDkuxHDR2kpbW4RsPC7iJ9GE2Giine3wzNf3wp6NMbDtgV+3YAuElp?=
 =?us-ascii?Q?nUqyvnU1bfaLuB5+VNIlKZxteZI2sgFLmjl/H9dKsqG3tJXDISH81Iry9WRw?=
 =?us-ascii?Q?vRmpnzl34jh/vNcvmYyb/HNXSb3G8IyPBquuWCvIFleisiIDSpYELJYT3/It?=
 =?us-ascii?Q?xqHpeaWwkSC4/CZ0OwNpNZ2YRO+78Xx38ZonqVvyJjY1pBVwA4VFTQc3fiLI?=
 =?us-ascii?Q?Pot1ILFqm8n+DLaa+KCQStNdREhI5HnQ17wEV6Q6CcA=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(84050400002)(230922051799003)(82310400011)(61400799006)(48200799006)(186009)(451199024)(5400799018)(36840700001)(46966006)(40470700004)(2616005)(336012)(1076003)(26005)(6666004)(478600001)(6266002)(4326008)(42882007)(34020700004)(73392003)(82202003)(7416002)(47076005)(83380400001)(2906002)(8936002)(70586007)(70206006)(8676002)(110136005)(42186006)(54906003)(5660300002)(76482006)(41300700001)(316002)(40460700003)(82740400003)(356005)(921005)(36860700001)(55446002)(83170400001)(36756003)(81166007)(40480700001)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 17:39:00.7733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97898c6-c032-467a-6618-08dbbf80a2ac
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6237
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

Add a compatible string for Nuvoton BMC NPCM845 Pulse Width Modulation (PWM)
and Fan tach controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
index 8523777f560c..18095ba87a5a 100644
--- a/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
+++ b/Documentation/devicetree/bindings/hwmon/npcm750-pwm-fan.txt
@@ -1,12 +1,16 @@
-Nuvoton NPCM7xx PWM and Fan Tacho controller device
+Nuvoton NPCM PWM and Fan Tacho controller device
 
 The Nuvoton BMC NPCM7XX supports 8 Pulse-width modulation (PWM)
 controller outputs and 16 Fan tachometer controller inputs.
 
+The Nuvoton BMC NPCM8XX supports 12 Pulse-width modulation (PWM)
+controller outputs and 16 Fan tachometer controller inputs.
+
 Required properties for pwm-fan node
 - #address-cells : should be 1.
 - #size-cells	: should be 0.
 - compatible	: "nuvoton,npcm750-pwm-fan" for Poleg NPCM7XX.
+				: "nuvoton,npcm845-pwm-fan" for Arbel NPCM8XX.
 - reg			: specifies physical base address and size of the registers.
 - reg-names	: must contain:
 					* "pwm" for the PWM registers.
-- 
2.33.0

