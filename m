Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A01E811C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442540AbjLMS3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjLMS2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:28:52 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2061.outbound.protection.outlook.com [40.107.215.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16018DD;
        Wed, 13 Dec 2023 10:28:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXILhwqkDYWdG8AEO4uRsNnmj98wTFy1OkOmfNpjgbbCvgsSXS/qi19bA+9MTmhVFb4TX2pEiMCKRJXa62DKCPXnLvOTyoLHQRIIas2BnNms3c/Lrt0m6dCgaoCZjBMWkddW5nLed5JdSNSO05CuYcbph5nd3PIthYopoI4/w1S4sUf4cOoggmxdgrmjinUX+cBTT73i8YdokDESLmurysCUN5BJ96Dpr7Hlz3uqxnSUikooZ2ZMN6OqLFMnJLad7jR2ue4criu+5A8XbZ/FVNlcFTBXiGBxTNmAhMw6zdzZKkOijWWhL2qsZe1nyUWEzTvrve0yIDEuVgoxoKx9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+i9VXHA17foOwtFxfhCvfV4OjRJRyDaaG7Oh+1HoFj4=;
 b=hsQZVvpcyI9Pkmt0cc9MI1Db0ZDw0p58nSqEMwWEmPhK3u3Pwl1tyywGjm3HhHzCUXgZRcFpqNldozNJ6LHumRRsCBkn5FA6rSfv/9dULxbMtcapXsISlMki3aLuYY1EHI3wOenneMU4LxlhX8fuBwaM6VJpqZ830XL76q9Wxd+wpwIdUOzHlAHZ9yhQAYSXpF4bS96O2GMe7xOd4oXTbW8tvm0nsR5/hNfaf0tkGWkdASTlJFN40rynLCb9wDZpYD37qyr1Pn3ss6GriuRYhdAFlITMyF7CC6eW6+7hIORdJCsn9XtpsCjl+Oj/kkl/ET1MO77rgzsvH/dFMPsfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 211.75.126.7) smtp.rcpttodomain=arndb.de
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i9VXHA17foOwtFxfhCvfV4OjRJRyDaaG7Oh+1HoFj4=;
 b=MMiVcOIHPC2T9V8gksBVbw2c7GyMlrQ/1AFHGGc89tRRl3jNY9r45Hyf/h0iyp/P7M/GhuKBb0wHye7apD1IHthXIKL8pCVHG9gt41/uJsXC3FsEXViJTGw3WGxyPCevtEqhaMKLgGhd4E85k6EBn458IS3oZVfeRnFiquPnES4=
Received: from SG2PR02CA0125.apcprd02.prod.outlook.com (2603:1096:4:188::13)
 by KL1PR03MB8449.apcprd03.prod.outlook.com (2603:1096:820:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 18:28:53 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:4:188:cafe::60) by SG2PR02CA0125.outlook.office365.com
 (2603:1096:4:188::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 18:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 211.75.126.7) smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not
 signed) header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of taln60.nuvoton.co.il: DNS Timeout)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 18:28:52 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 14 Dec
 2023 02:28:49 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Thu, 14 Dec
 2023 02:28:48 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 14 Dec 2023 02:28:48 +0800
Received: from taln60.localdomain (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 15F305F490;
        Wed, 13 Dec 2023 20:28:48 +0200 (IST)
Received: by taln60.localdomain (Postfix, from userid 10070)
        id 128D8DC3749; Wed, 13 Dec 2023 20:28:48 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <arnd@arndb.de>, <pmenzel@molgen.mpg.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 2/3] soc: nuvoton: add configuration menu
Date:   Wed, 13 Dec 2023 20:28:44 +0200
Message-ID: <20231213182845.3744685-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213182845.3744685-1-tmaimon77@gmail.com>
References: <20231213182845.3744685-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[211.75.126.7];domain=NTHCCAS01.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|KL1PR03MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e90595-132c-4f17-1c79-08dbfc095b7e
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8GQMeEO8gE8SA29EhbPG0U4Ssq3f39KAe56edXqee04fszR4iKAA4j9CwgH0SI63uVLQ7IwW5O85XgmHjWu/TdM3EMoWJlSAJEZmS+rTz4Z0yxB4N+qC5ad8ZHi0z4lzGK/sx9WEfVVUd/o5icgxiBqpszBozo89ii/j35itNLl8CkkH5sIhLyVnbcmsEM6YvKP2y1e6KAbPsSXTo4fDykOZ7p0C7IZ02qKrYZl2bEcb2jyRxrBW4+rjmHl5EtLVWrmQVDIVAUktQuG8mwqTsPH2MlDYsOn7GhO+PjkP7jDs9tn/hGmIJDPOlT444dZBEuF5ZMoY0F3yalNsh5+2v4RJVaFfbc0pWo3D7+0R0t/79m/qFScBY5Gtc/nR1KlPyFry4DAbMc9lYpSeuBn13+4W2EjZ4t13b4tW7xsklhfb6KXgT3159Ci2/sVOlEauCpFrv/B5SpgyWQjp8n2Am2YLTP21P0Yqrbyt+vbfRxkEbaDF+MLR2EhAwPT9FERYg6rJVLmkUN/Rj45GiZaYsjb4BlBdQ2bQARjb+wv7ErYn+Cji9KlmGKoMBUI0yY7WOPhkITU4o8UnmafsQcr0hxcLXBPqThTvjaB8qTn6XOprg4etxjr7V094lscuasxvqZ8vUlVv4rH3AmrC8ttzzbMMbZaG4m+Kn67Cy05YN7Wi+iBatRY+LRJYlC3SkGgPB1k9MFDGVVlot3yXQzKvj7EEDwzNPvuRKjsDeIiD35Beu1avL6J51G1Ts1PfpYcfcY8qfmJvehHXYnXsXRnW0EUBGrzamZQADGsQ3JA/ugZ1b8XyRpRui200zSBqId71EW1czJaYKpykYiQbAZzaOaQHjcmsZqr4rxdLfz+3eQ=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(451199024)(61400799012)(48200799006)(64100799003)(82310400011)(46966006)(40470700004)(40460700003)(26005)(1076003)(82202003)(2616005)(73392003)(42882007)(336012)(6266002)(6666004)(35950700001)(70206006)(83380400001)(63350400001)(47076005)(5660300002)(7416002)(70586007)(76482006)(41300700001)(4326008)(2906002)(4744005)(498600001)(316002)(8676002)(110136005)(42186006)(54906003)(8936002)(82740400003)(55446002)(81166007)(36756003)(83170400001)(356005)(921008)(40480700001)(45356006)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 18:28:52.2641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e90595-132c-4f17-1c79-08dbfc095b7e
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8449
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

