Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FBE7BF64B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjJJIns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJJInq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:43:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2095.outbound.protection.outlook.com [40.107.7.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A79E97
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeSzzqiAWfxxzgs5WoC7966BvXXDTReORDADwLdRJVL8tXmItM12PobpSQ6NvEz/3KMLJpkajWw8HWJADF66npr1OAUMIk+A89LhpL+ZI62K2YCsj9ghFBUIZilsjzVvKpqIoVE/NZtmvwnj0heXmnghIy2Y8J1cWoUcdrWvLsca8kM5jUHZZAan2UKpUzGxGpNef5Or6NXUiHTLOMXgLrqqpAAiF4Ra8tXGbNseMilX/mVJlETmSzNRzd0mAqw8Efmu83lWt/bX9z4kqBkcdNt9Gg8K+EQyRtIHp37nqEOWmpJevUMrWRNcVM8pAQM0a3RX1IwGOGfkY67536O6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrfR5Y/88iLjVt5OpNjlWtAop8x4E0hStZQy8D2ICMA=;
 b=JcLpaJRUQwALxa58Ct4XC8HKBeMH2Obts25+YIO/u4n/ZpoCoLXWxdH4r7niccmrJh+fylt3g0wteZyHcFZsyjSzLl54AVUZXBNDBYrdT0adDW6H7fd1tN5sw6tt5E+wJ+PuBmuInuI1cLUEtXLglrq6LihnFgTCE9/jyZRKOATT4i7S0tcwMYakDHUXpbs2FH3ltBd9VjbKhqQ/kd3buyg+XGLa5XmsOnTq9tbDGjN4VcxIy9R8DUjCRIpfqURy5SeVB564ORhhi543oFWpmG2ADT9Tys72CFPDmuMH7usAd57qgLQ96TbO6EoSie5aHjR4YpQPXIauROny96BqPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrfR5Y/88iLjVt5OpNjlWtAop8x4E0hStZQy8D2ICMA=;
 b=TURo/5MrNMdBhPXNUOoNAg5cWPA7DkLgkwUNZXyj08czJloF82o4TG8hkKkBh9GfjcwoUp3sAR/EMNiRFOw3hVXtZ3UDSTEYHXLrYIHhCVhUZi+aiTCrv2bg3dpCLHZVa7rLowmDxdhKA/MFu9yK5sgceK7YGHAaTfaEb+dp1fE=
Received: from AM6PR05CA0025.eurprd05.prod.outlook.com (2603:10a6:20b:2e::38)
 by PA4PR06MB7311.eurprd06.prod.outlook.com (2603:10a6:102:ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 08:43:42 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:20b:2e:cafe::6d) by AM6PR05CA0025.outlook.office365.com
 (2603:10a6:20b:2e::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.33 via Frontend
 Transport; Tue, 10 Oct 2023 08:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 08:43:41 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
         Tue, 10 Oct 2023 10:43:41 +0200
From:   Mamta Shukla <mamta.shukla@leica-geosystems.com>
To:     tudor.ambarus@linaro.org, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bsp-development.geo@leica-geosystems.com,
        Mamta Shukla <mamta.shukla@leica-geosystems.com>
Subject: [PATCH v3 1/3] mtd: micron-st: enable lock/unlock for mt25qu512a
Date:   Tue, 10 Oct 2023 10:43:21 +0200
Message-Id: <6b89ae4e4d7a381050746458cb000cd3c60f7a42.1696849423.git.mamta.shukla@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Oct 2023 08:43:41.0729 (UTC) FILETIME=[DF0FD910:01D9FB55]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000049:EE_|PA4PR06MB7311:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ebf9b101-bffa-49d5-0926-08dbc96d01bd
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PgyIO6/+z6o99Yxp0WOCZJGkxNOKW7fSwSq2zq2N+ifzFvqbvF6XVRed6+eZEDH3D6Js2CIR9HyjR452TDHHnz3omGLX1HZGIb+GVvINTxqBva21KBvik62zVL+oFnXKBiKOabtk5qK8SW+hDiWTOn0CeWDXdUbqJz6cNsrWwu+Toxpbknb3jAl/3F3LT3vw9wGFdb2hZMGCFVmw7PxiyGFNjHg2C8+o3p+efqeCCyr20MpU1ldJLI0aaKwykk1gZ346vKeYlyP4+7F2aebB0ecwMKFNbytBxLdNG0jjXzd8VOa0tsiVUSPka8MUuOboC8eHMWGO43ve76SFtEDk8sOq5r0KIRBzmfoMTls8kOvNAkpNTLPpKA9gGj3jwJQhHPy4YFFMLf4p1+SO9WJZZo+gKCAifsXNSPZZHiV3LntNOSWix9rB7RbXALWea0V0osHsx8o+Q80LXpDhAwUiah4lySDZo4D79AelhMO/u7az9J0O9TLn4JAyMBTkOv+RxAVZUUWg2cWkr8mtLMcjPWSxwNerYIx1ISUZITd4MVQr9T7bDla3CpVHgoUXEUDFIdyzSE161RwGDIUOGxIcnnHvsmcpP8cdQi/zIYo42PIP3WeSOaG1hFCZGIJJNpxpb7rl/naC/5vKJFOot5+/EXw4ZkDmR/nhrC7LLKKQN+p5RVRwhggHD0mJbes2uTo29QTgw1z0u7y5sAiZR0wDROux4S7AMqoZklpwVY71mHGy7O9+bCedXuUs8urV2VUd
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(82310400011)(1800799009)(64100799003)(186009)(36840700001)(46966006)(40470700004)(40460700003)(86362001)(47076005)(2906002)(36860700001)(81166007)(82740400003)(356005)(40480700001)(70206006)(70586007)(316002)(26005)(2616005)(478600001)(107886003)(966005)(36756003)(6666004)(41300700001)(44832011)(83380400001)(5660300002)(8936002)(8676002)(4326008)(336012)(138113003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 08:43:41.9591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf9b101-bffa-49d5-0926-08dbc96d01bd
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB7311
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt25qu512a[1] supports locking/unlocking through BP bits in SR.

Tested using mtd-utils- flash_lock/flash_unlock for MT25QU512ABB8E12.

Link: https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_512_abb_0.pdf?rev=b259aadc3bea49ea8210a41c9ad58211
Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
---
Changes in v2:
 - add Link tag
 - fix chip part number mt25ql512a->mt25qu512a

Changes in v3:
 - sync with spi-nor/next:8f407eda173f to align with new FLASH_INFO format
 - new patch in series for parsing SFDP table
 - new patch in series to add post bfpt fixup

Lock/Unlock Verification:
[   72.584003] spi-nor spi-PRP0001:00: mt25qu512a (65536 Kbytes)

# flash_lock -i /dev/mtd0
Device: /dev/mtd0
Start: 0
Len: 0x4000000
Lock status: unlocked
Return code: 0
# flash_lock -l /dev/mtd0
# flash_lock -i /dev/mtd0
Device: /dev/mtd0
Start: 0
Len: 0x4000000
Lock status: locked
Return code: 1

# mtd_debug erase /dev/mtd0 0 1048576
[  203.419693] spi-nor spi-PRP0001:00: at 0x0, len 1048576
[  203.438616] spi-nor spi-PRP0001:00: Erase operation failed.
[  203.444283] spi-nor spi-PRP0001:00: Attempted to modify a protected sector.
MEMERASE: Input/output error

# flash_lock -u /dev/mtd0
# flash_lock -i /dev/mtd0
Device: /dev/mtd0
Start: 0
Len: 0x4000000
Lock status: unlocked
Return code: 0

# mtd_debug erase /dev/mtd0 0 1048576
[  215.585620] spi-nor spi-PRP0001:00: at 0x0, len 1048576
Erased 1048576 bytes from address 0x00000000 in flash


drivers/mtd/spi-nor/micron-st.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 4afcfc57c896..6c8cabbead2e 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -405,6 +405,8 @@ static const struct flash_info st_nor_parts[] = {
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x20, 0x10, 0x44, 0x00),
 		.name = "mt25qu512a",
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+			SPI_NOR_BP3_SR_BIT6,
 		.size = SZ_64M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
-- 
2.34.1

