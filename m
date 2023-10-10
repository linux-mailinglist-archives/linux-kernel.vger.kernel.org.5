Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB207BF64F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjJJIoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJJInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:43:49 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2123.outbound.protection.outlook.com [40.107.249.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6505A4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG6fR3tT1kOfn2aMyP3DEsYeVAuwF0OEPkY8AQtuIQXBkIFZvEK6rdqXZ67BhDTvWROiE94PREygfh4iWAFnUwfDdCSetsQlTgqWYdHIPPautNM5Tz2G0MWG/KfXmfnmV87ptvCpKuZzCEqOrPzlkEFSGGWzpkxN2RJqqtdflJ5b/6RDcknNLeN+g9Gg5o+DT5itG4OFkiWYnS+c5EUcksB4ARNT2G/26vrv/CnARXPoQXImS7EipoSPepM5ReCy/ZbMgFoY6CHEXu+VVr4TstLLIbCTxMeSJwUKatD9X9gK8AG4uP9mAsGmujc3suj9Qio1P+6r75ETW52RpOhQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6/JzIfqdOmRIwCHeXtPdofy7Dx/+VqKxk7ZIFYeI6g=;
 b=dZu4lNNaYQEBkY/56hezQP273CeXNf1QIp/sG/XykQ2FJ6grc+Dr/3g4ido3tRXxUbTrKCyW4nxKeFqCugEqvgHkLRwXkeAvJBrKGM7IXbbjTU9YJmC4qChSz6DKpLySVqVFi5Hl+09MUkmEE2CfKbxqpIBmBXPuNAAxLncpUuOnQb85fDnoOuHLgOAPpBBVOfvGpCOF1gsYMT1L3xd44mOlEy4W72FYclZtuxiiVzz4FvMht4zpj7OQ5f8ICn42Y2RTyKtI4Q0Ryhl/AnkQbOMTWeRTKzYL/R1jpg0+ZN1GK2Ry9iPxAp3SglWNko8tqIJBS8pn5JPjuNFEJgGLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6/JzIfqdOmRIwCHeXtPdofy7Dx/+VqKxk7ZIFYeI6g=;
 b=oJ2QavnVTVZKlKgJ7gh4T8qKFdyx9AeZ+AfbjRhTYUbp9OFfLlx29bVA3IsEMqBxaMP/Ftal3VztwhzQurehV7AB8BwpeFtj825hkeP5REatHAwVJf8coqFw9BB8k4IEe3arF3xIn3Szss4nmnIK2pAr0t8SmCLD0Ut+OWpNtcY=
Received: from AS9PR04CA0129.eurprd04.prod.outlook.com (2603:10a6:20b:531::9)
 by AM8PR06MB6929.eurprd06.prod.outlook.com (2603:10a6:20b:1df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 08:43:45 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:20b:531:cafe::99) by AS9PR04CA0129.outlook.office365.com
 (2603:10a6:20b:531::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 08:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 08:43:45 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
         Tue, 10 Oct 2023 10:43:45 +0200
From:   Mamta Shukla <mamta.shukla@leica-geosystems.com>
To:     tudor.ambarus@linaro.org, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bsp-development.geo@leica-geosystems.com,
        Mamta Shukla <mamta.shukla@leica-geosystems.com>
Subject: [PATCH v3 2/3] mtd: micron-st: use SFDP table for mt25qu512a
Date:   Tue, 10 Oct 2023 10:43:22 +0200
Message-Id: <f1620e5f88b7ef94e83cdb46b8f120a161268f80.1696849423.git.mamta.shukla@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6b89ae4e4d7a381050746458cb000cd3c60f7a42.1696849423.git.mamta.shukla@leica-geosystems.com>
References: <6b89ae4e4d7a381050746458cb000cd3c60f7a42.1696849423.git.mamta.shukla@leica-geosystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Oct 2023 08:43:45.0385 (UTC) FILETIME=[E13DB590:01D9FB55]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004D:EE_|AM8PR06MB6929:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 92d88212-63a0-4531-d505-08dbc96d03df
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UhMclM2BCWCFOdl84GWkevIML18B//unaiNLJuFLmehQF5C6r/LrsRDXyGgg0Z5U7GoivXW1up8zlWwNFd/zhANWq/mPSd3wK5Q/Naj2OyZPSzvcjE4YJ0FQqFzN83opNSysdUcMyWyXw7gydhORBjKp0axPI+8ofzK5VUIapBWjI0ThdT7W7+Y8yrN1ZlHrsB9uN57EhkbGLxBk2gRpBgkVsevsHm6qQkZ0ueT+QG6J2/rr+irzfTw9crYioKAdbvfNA1IGsa1C/EtZBgZcSecwf2OlmFV2OKdNjjxQDIo/kB5sBiQnyHF5nQPZPH337Ji9GZl3VkykDHRACxTWYSD6E4vx5Nx6dOwx+rdAJ20oTGnpXHiqSCJMDNYTbdjWifMqOs9ZGhQ7oUCoc9I9ZE2OFyDHC78ZtkmZvfj/v+f2x2a97c3A7Jc+gk/MLPwu5ujXcib9UPNzUJoyrqC+psNl66UEd9IiblTMN/t12NuWTG4lCBmW8GOyfOLy6v7TyYeowMRnWJa4RNbbXD67K9mmA2R/+Bx+3luMxUTjyRmLbWD1bcZKKtqhDr4tmXtcjP+wrdZ0X4oCNfCEPeGURZMgAccCgVMcSAmjUWzDwdTk6dOsOUdVo/uoxjCBmZDVC8LKs+Ze/tGec2js+t0anJPsshYmG15RM31maSsRDY5QVOt1pZQhl6peg3gQwHMYjDRdJ43ZIg5nPCK/s1A4h9tp6hsCD/uJjZjDHfm4Bcj/SW3K7Ghb7Tcj2Ybu6wI
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(36840700001)(46966006)(40470700004)(36860700001)(2906002)(40460700003)(47076005)(4744005)(86362001)(36756003)(81166007)(40480700001)(82740400003)(356005)(70206006)(316002)(70586007)(41300700001)(2616005)(107886003)(26005)(478600001)(966005)(6666004)(336012)(44832011)(5660300002)(8676002)(4326008)(8936002)(83380400001)(138113003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 08:43:45.6363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d88212-63a0-4531-d505-08dbc96d03df
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB6929
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse SFDP table to get size and functions of mt25qu512a

Link: https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_512_abb_0.pdf?rev=b259aadc3bea49ea8210a41c9ad58211
Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
---
 drivers/mtd/spi-nor/micron-st.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 6c8cabbead2e..4feb03ee2d13 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -407,9 +407,6 @@ static const struct flash_info st_nor_parts[] = {
 		.name = "mt25qu512a",
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
 			SPI_NOR_BP3_SR_BIT6,
-		.size = SZ_64M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.fixup_flags = SPI_NOR_4B_OPCODES,
 		.mfr_flags = USE_FSR,
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x20),
-- 
2.34.1

