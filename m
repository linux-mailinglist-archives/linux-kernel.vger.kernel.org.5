Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7287BF64E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjJJIoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjJJIny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:43:54 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2123.outbound.protection.outlook.com [40.107.104.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF67A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBSous9YZxo/SIfyPMhXljowevA4C8J8CmpG/bNAZiHQwu4vNsgrVEinW/CftLOY6gE4icV7nAFYUBRus1Kf3Xd7U0+Bltkaf1OKu35ZTCkuQIFIPSb3yC0XtQp4RA2bQV96wBTjom2DnPsLI9Z3YbR0Ptii3IR37StNH0izZ7bUb/RMPY7OfBYeiuDg6IimyB95AdgXcvFmxWQUH8J2aK/OyQel+Ek2CBtbJewS5HrO5LVoJ4qurhjg/li1egYXn1UPtsiJIpUctbN8haGuZqkKGQDAA3am4tLb+kFsn11rW63RcAWs6dUGDtOfARG/DmBMfIZ8EyDOWBQ6h87bvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVo26xdZqOAILJa8xeBMwi007uLApMIutQP2DssQ7No=;
 b=aOVVcjG66aNme8vzTzqt3HtHkx+KYWnUBAVFZsTK4CylqFLEu/jqdZKoaoVtSBX3J+AwYxINHlNHDJQ9RjQTYcq4GdFRjUaWB0YDVICn9BctvqPDvRIO69NlEBSVLrIyhFl5EFczjL/2QRxsZ8LvZ2A1ptb4hbPe94BZjgRPqy9tlwTzsfWVSfIxfX1/f3FUvanZA2S8/3d/etRL5mXPE0s5an/SWIq3ACbQILnR7ykyIIQV8FSgFVsMHRfdDN+WjJT0gnSUp627Gbw0MdTPvyI7GEh2qIqxRYWIXosZpAQIk+960wBlbMxmI2A5PSKk84Yz9y6Fj79jwBs5STrY9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVo26xdZqOAILJa8xeBMwi007uLApMIutQP2DssQ7No=;
 b=Yy5WcrdymlDeimsQTKjdRdVO5O9BRb64VPOCUsJcjkb73y3axXP8jKi8jEmpiOxP903D2WPg4fDOTuQf3H6X9nZgP2K3oaSBMjttCp3yYbbkhVkgeREoA6Y+IFBncYciHm1y4BA+yXNHTnJyvA+8NmHIPRqyIhZ9bEW07qMjnoI=
Received: from AM6P191CA0046.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::23)
 by DB9PR06MB7404.eurprd06.prod.outlook.com (2603:10a6:10:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 08:43:47 +0000
Received: from AMS1EPF0000004B.eurprd04.prod.outlook.com
 (2603:10a6:209:7f:cafe::7f) by AM6P191CA0046.outlook.office365.com
 (2603:10a6:209:7f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 08:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS1EPF0000004B.mail.protection.outlook.com (10.167.16.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 08:43:47 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
         Tue, 10 Oct 2023 10:43:47 +0200
From:   Mamta Shukla <mamta.shukla@leica-geosystems.com>
To:     tudor.ambarus@linaro.org, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bsp-development.geo@leica-geosystems.com,
        Mamta Shukla <mamta.shukla@leica-geosystems.com>
Subject: [PATCH v3 3/3] mtd: micron-st: add post bfpt fix for mt25qu512a
Date:   Tue, 10 Oct 2023 10:43:23 +0200
Message-Id: <28b5597f13ca6baab602e076b4beff4c893e4d11.1696849423.git.mamta.shukla@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6b89ae4e4d7a381050746458cb000cd3c60f7a42.1696849423.git.mamta.shukla@leica-geosystems.com>
References: <6b89ae4e4d7a381050746458cb000cd3c60f7a42.1696849423.git.mamta.shukla@leica-geosystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Oct 2023 08:43:47.0510 (UTC) FILETIME=[E281F560:01D9FB55]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004B:EE_|DB9PR06MB7404:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 647408b6-9f04-46ff-22ce-08dbc96d051f
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqGLLJ9XZIUjW795rUMGYhaXkkBgqsuS8G9YfvaVwxDGkz2mg3sY6n4FflKFQEJnaL6MVqc/n8wefp//GUCpCGfrs+Ae5arNUzqiC/rHQIeQ0aMvcGl9PCNkCDzbnwZpnZDLGbjcM7MWWewwP6Bh8Tf77H3KYks7ct3LSfDYayCVk68MeLfIfMN7Eo1twtKAnCGRgdEcH5e4GIoC8SBIEoMahA8XOTSJ5wzrC09uTIakcRRp22iqlf+M46Zp+doENmo6L18y7G8+c+HVkMKZy/wqp2NRLxT8mqMQmHY7y2RCuGXDp62ZXSU5HLYdbGMhV73P7XfnkYIZlf2wcPBpTWbcn/oyuQJ4KTIAAvKpABjI4Me94/xKfVAgm6JTct49/zX7iycAn9XTTcWVkgI4Di9HpflSSbgoEakax4gZxmX1kamAGXGEYP2XQERkSa+ZITe2+Rxq6vKnekK1AQCp0KQUccRFaKZM7NA00JnoJpAvynMGpvgdK6CHj10yM697M+JCWjXp2d+vEReKYNzd4TNkUdmzwcJV0T6PpRM+ZukC8+oKip2bkWjoHXcVjeskb2MIu5LUcvsMBYQJ6mW2i0uxdjXfR3YK35zVRSL7T9oi1TLohGzEgtpleEDW1jU/Wud/i+WEQSzf2AAnuIsIpu6P9Xn3HlV0Of3rGNe+nGJDi67DvFQhKiWpy6GL/rq34FpM5T1G0Gy5UbcA0zlxgF5/KsS3bb3QeiWtgUt64dDcfePEkkaPax/HlvkZFhRn/NQzmOZ0J3e8R5peVSYDqw==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(6666004)(2616005)(107886003)(82740400003)(40460700003)(86362001)(40480700001)(81166007)(36756003)(36860700001)(356005)(44832011)(83380400001)(336012)(2906002)(47076005)(41300700001)(316002)(478600001)(8676002)(8936002)(70206006)(26005)(4326008)(5660300002)(70586007)(138113003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 08:43:47.7289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647408b6-9f04-46ff-22ce-08dbc96d051f
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7404
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parsing SFDP Table for mt25qu512a adds flag for 16Bit Status Register.

 cat /sys/kernel/debug/spi-nor/spi-PRP0001:00/params
 name            mt25qu512a
 id              20 bb 20 10 44 00
 size            64.0 MiB
 write size      1
 page size       256
 address nbytes  4
 flags           HAS_SR_TB | 4B_OPCODES | HAS_4BAIT | HAS_LOCK | HAS_16BIT_SR |
  HAS_4BIT_BP | HAS_SR_BP3_BIT6 | SOFT_RESET

This Flag leads to miscalculation of BP bits and thus causes failure of lock/
unlock functionality of chip. Hence, add post bfpt fixups to fix parsed
sfdp setting.

Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/micron-st.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 4feb03ee2d13..b7bf0570c01f 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -180,6 +180,19 @@ static const struct flash_info micron_nor_parts[] = {
 	},
 };
 
+
+static int mt25qu512a_post_bfpt_fixup(struct spi_nor *nor,
+								const struct sfdp_parameter_header *bfpt_header,
+								const struct sfdp_bfpt *bfpt)
+{
+	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
+	return 0;
+}
+
+static struct spi_nor_fixups mt25qu512a_fixups = {
+	.post_bfpt = mt25qu512a_post_bfpt_fixup,
+};
+
 static const struct flash_info st_nor_parts[] = {
 	{
 		.name = "m25p05-nonjedec",
@@ -408,6 +421,7 @@ static const struct flash_info st_nor_parts[] = {
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
 			SPI_NOR_BP3_SR_BIT6,
 		.mfr_flags = USE_FSR,
+		.fixups = &mt25qu512a_fixups,
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x20),
 		.name = "n25q512a",
-- 
2.34.1

