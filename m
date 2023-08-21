Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FA2782645
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjHUJat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjHUJar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:30:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C295;
        Mon, 21 Aug 2023 02:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvB+zAFV5qSI+fmJGh0T8LJnKiLacL3sh+h2Gernlg7SSwQL5hNRaeMF10+5kFKe7vvEInEq1ud/K0YUU8KC6MSntq64SMpuSUQZXyk3ITVCEOQFii9EB4kWgCQ1/ZbjUG+epxrnQ0t+wuhQrGBBF+eeI6mrqrIPCl6iF4kMtw1ITSziZxFb3asFtdj/rb5QEfyrIdwX/2t7sRPzEuDJE/hwUBRlbadMrJvJPZ9m4eYij8kcjzJlsE5S7T6Bmu9gTmtJEsSH4HtTBv06EFXxwjUAJS9Pg/4qPaQDWa/7iInASgI+DWUxB+aSa7MQGfaWn2YUTf9dU4wRM2WPbS62fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlhfXcMulsAXXrhdZuMP8PkfM1r3pLDIku5KSg5FPiA=;
 b=IbpmVzcxvDpN1mmAQ5ki/LCciVyEQyNYUv+JszLowKQn9bMdfCmSAC059h4bGVafexFKwAuUXzfnOCxhQ73skaV3A39dVmFObdUfJcCuE71T8LLwZDMUYzpQwfibIjhm2SCpmuPgDfC7pMEVMVCc6pwj2tig0tR3Xles3DG6ukz9S0zhTMtyQyccEDDLgnDQTAtip/dgveVgFPl9YwmOpMCNbK9VmZukh4805QZclso/FiOJVJYa3LEdRlGgjpaMeDDjqV3SxsWskm1g00ViSBPRG7kHdm3mKBv7ezUs377ATlcModlN/9s/LvJy0524VBzKvMEG3v811nbZz7ZLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlhfXcMulsAXXrhdZuMP8PkfM1r3pLDIku5KSg5FPiA=;
 b=Gog6o4EpuJGbGrCxZaOp2mPjZexIuOKdgpFvh5KlDIKgRHRQ5ecR/y2lCAKVP/VNGfRCARGRQBpZCTnbGRUJFLf13G3W/VPex2r3s+Y21BFpOJwXEH0oXZX/ytVJx68QgxwmCzOkzduVUBMtcT5zGyWzIhiQigzx5XYdn8bNBqs=
Received: from SJ0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::16)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 09:30:42 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::5b) by SJ0P220CA0025.outlook.office365.com
 (2603:10b6:a03:41b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 09:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 09:30:42 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 04:30:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 02:30:40 -0700
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 21 Aug 2023 04:30:39 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <gcnu.goud@gmail.com>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH] spi: spi-cadence: Fix data corruption issues in slave mode
Date:   Mon, 21 Aug 2023 15:00:16 +0530
Message-ID: <1692610216-217644-1-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f883ed-df37-408e-be34-08dba2294a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ftxRYXsq5IgK2qYyBI/AwrG5wyMLHZHCX2hYHfhrUM9AKckpZf+r7XrxiG92rtCBnq2629aAcoU6xXy/1qz6Mh16GO98ckpIrCGWQKnQxqeneaPbIsOxGJQvHVHId8MoSLvgwjqO53NCpu+uIGK28R8Chln0io5E+0cVPHMtKTvDEt4PNvsBLuqHIVWc3jhSAYBv2MXoYbs3VZUE3EaFBWbnAnQ6/QfYVNme5Ulom1ZEmTY1B5bwg+khOYMcf5OeywEEw5sTJVf6CiW27eVNwKyf5x1fOGM4w5lZkYT4kB4Tlr0LbN90yCwERbFmK4G4W4GKpwN7sagdfOQGEVYccHt2i0BZyPfyAlSDy4++MvcLFyi53H2/uLXEs5TbHiREaAlrnjqG6K6a8IdyTFMMnN4dgUqx2eSeI3BDGgbuvk1r6/93IJ2HFv4Cc3U1s5ed+X64D5uy3qCihAmofLQnQ14QyAFOX37/gvzlpeXLKs48m8wj+cak8FJE9VoASC8hRs8Hqn3cNpZfHf02wsqzpVT39y9HaU9eQROut9vFuy4s2SKbxR60TUvag2Fl5/x3KjPUmukufSCSoJybjWAhgYfBvQAOVx0rf5E/JeKVQUHwpD2xJJmXUvkOp0GFIKM4QmexqVOD8YU5xs2YiErT5nrEqUQu9H6jGpn2oZKllJi5j7fE2zlr0T5Gmus1kYyLzRE5iWxaE6Bp20jbLWm2AFx5E17YjgRwDS1h0QRrHcYiG2oOqJAy0KBKEDaNk+pG3PWOXJFD/ERFK3WIejjKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(40480700001)(5660300002)(44832011)(336012)(426003)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(6916009)(54906003)(70586007)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 09:30:42.2382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f883ed-df37-408e-be34-08dba2294a1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 10us delay in cdns_spi_process_fifo() (called from cdns_spi_irq())
to fix data corruption issue on Master side when this driver
configured in Slave mode, as Slave is failed to prepare the date
on time due to above delay.

Add 10us delay before processing the RX FIFO as TX empty doesn't
guarantee valid data in RX FIFO.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-cadence.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 42f101d..b21d125 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -317,12 +317,6 @@ static void cdns_spi_process_fifo(struct cdns_spi *xspi, int ntx, int nrx)
 	xspi->rx_bytes -= nrx;
 
 	while (ntx || nrx) {
-		/* When xspi in busy condition, bytes may send failed,
-		 * then spi control did't work thoroughly, add one byte delay
-		 */
-		if (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL)
-			udelay(10);
-
 		if (ntx) {
 			if (xspi->txbuf)
 				cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
@@ -392,6 +386,11 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 		if (xspi->tx_bytes) {
 			cdns_spi_process_fifo(xspi, trans_cnt, trans_cnt);
 		} else {
+			/* Fixed delay due to controller limitation with
+			 * RX_NEMPTY incorrect status
+			 * Xilinx AR:65885 contains more details
+			 */
+			udelay(10);
 			cdns_spi_process_fifo(xspi, 0, trans_cnt);
 			cdns_spi_write(xspi, CDNS_SPI_IDR,
 				       CDNS_SPI_IXR_DEFAULT);
@@ -439,12 +438,18 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
 		cdns_spi_setup_transfer(spi, transfer);
 	} else {
 		/* Set TX empty threshold to half of FIFO depth
-		 * only if TX bytes are more than half FIFO depth.
+		 * only if TX bytes are more than FIFO depth.
 		 */
 		if (xspi->tx_bytes > xspi->tx_fifo_depth)
 			cdns_spi_write(xspi, CDNS_SPI_THLD, xspi->tx_fifo_depth >> 1);
 	}
 
+	/* When xspi in busy condition, bytes may send failed,
+	 * then spi control didn't work thoroughly, add one byte delay
+	 */
+	if (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL)
+		udelay(10);
+
 	cdns_spi_process_fifo(xspi, xspi->tx_fifo_depth, 0);
 	spi_transfer_delay_exec(transfer);
 
-- 
2.1.1

