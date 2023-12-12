Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C0480E8AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346140AbjLLKHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346113AbjLLKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:07:09 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2076.outbound.protection.outlook.com [40.95.54.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C338ECF;
        Tue, 12 Dec 2023 02:07:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IirS6SiPn2cgutrXOlMalC+9PlEnYt22pyDaps1iZke1kNdOUmb2//O5B5mD9s8nxgIbp7O+O/txT6SJf+ywn8qyTsdPNV98sGbw4bY4NYlpMT2kesQlcZpBqqK/H6ik/U+LLlR8D/O9V+8ihhFXc+DwW7dIHFuOw/zwRDDzYrM2hRySbpyW793PpgmeK6qU5M3btMcyQDmYTbrWnDGrd+8owFKcGFVst45RAAmGBToaOjUmKnP3dHPVJSVUcMMyob2FrM2xGyRMY8tWs7HtIQ6PakWdezEkG9oyxM8Cn7hHjYjTfXEjEABCGmUhLQ2id2522u2SHMAoMXHngmYPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+i9VXHA17foOwtFxfhCvfV4OjRJRyDaaG7Oh+1HoFj4=;
 b=PjdjdNLcHV2UKjaSspMSjr728fUPKWcfGVBTOyg0vHd3Eh+/8tWXre0tE8gE6yGzAGE2+Fw2F7AfE/6Wan9yl80p5fH8omFUULVTxZSXacoI/fL5SJHUF515kUTbrLd/LnsBWfnV9my5ctqQX9K76YBWIVq6wwjyh1Y6OoP8ee/h094zOVzWZUmkSadgrw7tRiBV9AgruPr++no4D6F41kZUlpI+MpAXnDa3Ptw2VBiRYiDHsU82550V5ABPlmIXauiGA/hOmv/LCtC5H3DfeVzCs8PClHTA2h5YFYQs1RDtV0o5DeMnbZlGJZhNyCEgsOq3HzwArsW7RrNFecgvsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 175.98.123.7) smtp.rcpttodomain=arndb.de smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i9VXHA17foOwtFxfhCvfV4OjRJRyDaaG7Oh+1HoFj4=;
 b=N/0p4fG1lCLjoU3P/5QHjHCT5nrsMfa+BxGGm2p1gomI/sJ8u0fg9AngtvjO+baFxau8Ih0hgIhsSMjj9W4pULNluua5skAVz9xUNmqhnykygMG/ZnMFCcF9U3rF/wByJRuhGtd6Ikt7Xu98k9ey7788DDO0wXL07Hor/yt/BmA=
Received: from KL1P15301CA0057.APCP153.PROD.OUTLOOK.COM (2603:1096:820:3d::19)
 by TYZPR03MB7637.apcprd03.prod.outlook.com (2603:1096:400:41f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.30; Tue, 12 Dec
 2023 10:07:11 +0000
Received: from HK3PEPF0000021B.apcprd03.prod.outlook.com
 (2603:1096:820:3d:cafe::1d) by KL1P15301CA0057.outlook.office365.com
 (2603:1096:820:3d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.4 via Frontend
 Transport; Tue, 12 Dec 2023 10:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 175.98.123.7)
 smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 175.98.123.7 as permitted sender)
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK3PEPF0000021B.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 10:07:10 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 12
 Dec 2023 18:07:08 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 12 Dec 2023 18:07:08 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 1096D5F5B2;
        Tue, 12 Dec 2023 12:07:08 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <arnd@arndb.de>, <pmenzel@molgen.mpg.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 2/3] soc: nuvoton: add configuration menu
Date:   Tue, 12 Dec 2023 12:07:02 +0200
Message-ID: <20231212100703.3374555-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212100703.3374555-1-tmaimon77@gmail.com>
References: <20231212100703.3374555-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021B:EE_|TYZPR03MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 76208ba8-d74d-46e7-c0f3-08dbfafa1b2c
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9g6g4GObf6HEAPTCUZ66Qjyj3IUttb4j+IN8B2p7dpYVS94tzcWiJ0SfJVV6ytgNZOIemuC1yjtcyesbFHOnHGM0x4VhbyuMSQP321BQ5u21rDNSYHdzOC0JugauwV0COKMfN1eGvjtd75Jz2yMWF0dvsk3q7ebDVTavgOB5RoREevyV0AJOloP6momeupkGghtEyIG/MNRqBjUBFhP+TpEl0fqcxUQUNG+Qdj616TbwxkBvR3kimN10ics198uq2ZcFucx3DsJUabEYcYHKv6WYIY0q9AgdNIi43PftosQQwZKNsDaQXEGg8edU4PNwqaE+uqEeahdMvzHojzX8jRDAi+JzegMeeqzLg9YAjLQHjrq6miJ2yfCe71jbpYu7rTKv9n9CWmF6E+uGzDOy27FZ4cNwnnrI8+XhEgx7YhKvHNznrUragxuZNVb5rLx7N9+r6BqjqORvEsR+Qnl2MM1XOAFwH30dKrk8GkTU4GU3RoynK2zDVoDxiyws/D9k9SxhvLkH8IG5y33wmqxqogAZ0spdBOKnug+SNErVJSGKzEPubsBmuU+gKqIoFnSHbQ5FpLAiNfhw82GlaUiH+06Lar8mz63t+wa8X8aiJcCHNxeSzjTKsDaPeNwW7Lg+0Jwej4B7CS8RBEvsRvXS4kxY6gGMxK776gj5sDRmi+ZNgvOuQdgOHznfW3AtFg710FtsxTcErgvIA2zl34UrJD52evOfIDkPtijjlb+omvWJPW+hiNCSLm8TGMlBesGGZv8YEzkVEliobr/tSBXrS8p25K4KjgixdhulIHwKxI9hM5XAkpQgI4WlN8kfXBt
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(61400799012)(48200799006)(451199024)(40470700004)(46966006)(40460700003)(73392003)(6266002)(26005)(1076003)(336012)(2616005)(82202003)(6666004)(35950700001)(83380400001)(47076005)(5660300002)(7416002)(4326008)(2906002)(498600001)(76482006)(4744005)(41300700001)(8676002)(8936002)(70206006)(70586007)(316002)(110136005)(54906003)(82740400003)(55446002)(81166007)(36756003)(356005)(86362001)(921008)(40480700001);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 10:07:10.7273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76208ba8-d74d-46e7-c0f3-08dbfafa1b2c
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021B.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7637
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,PDS_HELO_SPF_FAIL,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_FAIL,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add menu configuration to Nuvoton SoC drivers.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/soc/nuvoton/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
index df46182088ec..d5102f5f0c28 100644
--- a/drivers/soc/nuvoton/Kconfig
+++ b/drivers/soc/nuvoton/Kconfig
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-menuconfig WPCM450_SOC
+
+menu "NUVOTON SoC drivers"
+
+config WPCM450_SOC
 	tristate "Nuvoton WPCM450 SoC driver"
 	default y if ARCH_WPCM450
 	select SOC_BUS
@@ -9,3 +12,5 @@ menuconfig WPCM450_SOC
 
 	  This driver provides information such as the SoC model and
 	  revision.
+
+endmenu
-- 
2.34.1

