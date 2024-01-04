Return-Path: <linux-kernel+bounces-16756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1506824365
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1551F22845
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF441224C0;
	Thu,  4 Jan 2024 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="qvwC0N5B";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="FZVWc7SJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3747D224E9;
	Thu,  4 Jan 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404BV3hc011010;
	Thu, 4 Jan 2024 05:30:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=proofpoint; bh=/jH6sFxy7XY8Vkl69eP
	0fjDKhH/hdipLtTpKwt0YNbs=; b=qvwC0N5B1ULgxAcgUuNs8yA/IpdEiLfi+By
	NA4BE1x/F9bqVXUMKc87vANLmBCBO1wSYMZBdmfQPQoPtLTp9lGPg14pSe5AqvWx
	1zSKDW50LfxOuxINLK3bkFzW/5rgvZlMfBon5rTXdu4F4BmApIKDX3VpsCbJklMn
	b2Pcl+2Syvg7e9mR9WEpbEvpYJhL/xFftU/vHxPuP1o+othI3gTYKDXObZhVUuCx
	MU91gzxQcgBFusHmweswcXXHlNXi7rvZB3uUubP3KPqz46zxDoQONNo9p9K9F9CO
	34cHbDtDhwDwCmuowr/mBxGKZPCJFMEImEpn8HID8Vv7OqxB5Kw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3vagmwhm6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 05:30:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAXfSz+++TXT17PqKZBqjiP2nXj6MLnhew/c8wxfRDRdIrYO3xARD/sYrfnBAOL+FJgpET31bfRSkbKjS/tMGMlY497P7jCKOsYtfNnzFk/n2FNTqp2elD/lbTviFdjS8ai8Q/kqtvTRPHXgX1ck5EmN5wNEKFL0Pi6KYr/Pe6dYOKfmriV+/orSlr3TXKWyokxuoyOIoJryax/GYukRVA+3ewrS5DiZFHBhcbQqja7FJRc2s9ZUQKNqjlYQl654cnTIvrutFbOkj48b5+qzjsecJ1+qo0QJmCqZ9EVs77/pmrpKIlulcZmJddopjdgFFQRb83w0gsQDyX7lds09TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jH6sFxy7XY8Vkl69eP0fjDKhH/hdipLtTpKwt0YNbs=;
 b=NSN4d/2YQ4Mu5z3llssG6G9v2W4g4fcxhYAWxLe8qwhtQjejR1KUYkKCGm30n/sEd5KWDG4z+HQ8G1BNWCc/BrTQ0IR4ZAPXI6RON/a1qnPmhxwiLFfu40NB23ZdEE0DXpFreehUdFMOUsXxqj1Ur2TBXkPykSm22FUF5M2pQi7q3SCCXus54xuG0amhSJv0BWPSjZzaHLcUtcSbIj3rGWVaFAt6uGob1gk/jz8fNgQLixLs0ZXvFP7MKiKAa4HAgVd8nNEHzzT+eImwwggE520VqiBJQl3BBucebLUIJHhhNDXxMP9h1hs/N/cJcP/oMGDbFT5OgE98ggn7KuVeXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jH6sFxy7XY8Vkl69eP0fjDKhH/hdipLtTpKwt0YNbs=;
 b=FZVWc7SJDQdtRHDWMwyWZmmX/W0C5Z03PxyJSu03sG4JsmAIp4vuosV1/IqJrpwj0H8xG08IRvzROTyNtTcg5cuCKO30X8xG0DLu72iNxMudcApnUv4ECcPO+pbWVqGWPkNnX+vzPbsBUjcjWrHJ/jLFMIPM944I5BKoMt7zLhA=
Received: from MN2PR12CA0023.namprd12.prod.outlook.com (2603:10b6:208:a8::36)
 by PH0PR07MB9220.namprd07.prod.outlook.com (2603:10b6:510:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 13:30:26 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:a8:cafe::30) by MN2PR12CA0023.outlook.office365.com
 (2603:10b6:208:a8::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24 via Frontend
 Transport; Thu, 4 Jan 2024 13:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 13:30:24 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
	by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 404DUJMl096550
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Thu, 4 Jan 2024 05:30:23 -0800
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 4 Jan 2024 14:30:18 +0100
Received: from cadence.com (10.160.88.83) by maileu5.global.cadence.com
 (10.160.110.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24 via Frontend
 Transport; Thu, 4 Jan 2024 14:30:18 +0100
Received: from vleu-orange.cadence.com (localhost [127.0.0.1])
	by cadence.com (8.15.2/8.15.2) with ESMTP id 404DUJqr2911106;
	Thu, 4 Jan 2024 14:30:19 +0100
Received: (from sjakhade@localhost)
	by vleu-orange.cadence.com (8.15.2/8.15.2/Submit) id 404DUJtC2911105;
	Thu, 4 Jan 2024 14:30:19 +0100
From: Swapnil Jakhade <sjakhade@cadence.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 5/5] phy: cadence-torrent: Add USXGMII(156.25MHz) + SGMII/QSGMII(100MHz) multilink config for TI J7200
Date: Thu, 4 Jan 2024 14:30:13 +0100
Message-ID: <20240104133013.2911035-6-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20240104133013.2911035-1-sjakhade@cadence.com>
References: <20240104133013.2911035-1-sjakhade@cadence.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|PH0PR07MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 034a86ee-6ec8-495a-6e0e-08dc0d294ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IUI3/TBdwniJIy7S4hhEp/Z2y5CMSJICFzwyIQNKlnKoJx6oqbHAbFQguEQYjoepRuYnvhyHN5CXaZz4MPD/cuYbvRpCzyAbx1UgA6ljCn2LY5iUokugqC8HHP7rVdIddQwy7CIE+t+XQOJ7GbkiaWVD6chlWgPrXirHOQ2UJZgQUzGNj5NmduHzwtRurP7WBxGMB4Zb7xUUCwbGpaVQGjEU1M6q5ljbFumyo6PnlhXUktrmeq4T1xSz93avWKzn/QjOt+48oYTL8xvoTAOV1nVoU0j8/zR5Ka/9Oa9swPvB1eSCwPBV93qqP/TJzKuQ/mN41u7gA6GQdeftF031ytdexekmTSVtIzozkr9FBeuPYByKKt3KzGVuWFocLu1RQM2kPabuuysJ6x3ZBpZ3OdIxp5oZktpEGNvWqk2Re8mVG5jmDBdcG0JMW6RI/+BcjYAhql614wzhzJE6EVVRwx1nvlRWAEBj8knYwIQNCVF402LQZV9L5GUl38mX7IlCdTpDZhkfTzmJnLY6gPawkTfGZUZRvuDXLZqN3aD927KGU+CmFKxIsvCinhvb8354HY+/p/jEDZmMwyeVabMIrX47DdEZavNMAXeoon5FMs8WG7OJ3k0YPOsROAQ/8KBNSttJqWyCiNvkNdIyGNcLMb8zIKaFZVTGzA78qUvsOzz7HAvBPwCLzg/2V///9WEYsB80/QID1cjjZVN9T7hknxM/0GiFQeaqgaeXCoCz4MWPKl51uLAfmsDcsxlmVk2CXmTMjuRH5YLD3DfBD1NVSjzWTmwkOUornBoi0gh2olLPCgnV003l1iKCVuMNlcYy
X-Forefront-Antispam-Report: 
	CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(36840700001)(46966006)(36756003)(40480700001)(81166007)(70206006)(86362001)(83380400001)(82740400003)(356005)(1076003)(70586007)(41300700001)(47076005)(2616005)(26005)(110136005)(30864003)(478600001)(2906002)(336012)(426003)(4326008)(42186006)(5660300002)(7416002)(8936002)(36860700001)(316002)(6666004)(8676002)(54906003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:30:24.5524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 034a86ee-6ec8-495a-6e0e-08dc0d294ee4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB9220
X-Proofpoint-GUID: ADH3Nvxyv13eOLROLUBrEIl_n931759n
X-Proofpoint-ORIG-GUID: ADH3Nvxyv13eOLROLUBrEIl_n931759n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401040105

Add a separate compatible and registers map table for TI J7200.
TI J7200 uses Torrent SD0805 version which is a special version
derived from Torrent SD0801 with some differences in register
configurations.

Add register sequences for USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)
multilink config for TI J7200. USXGMII uses PLL0 and SGMII/QSGMII
uses PLL1.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 410 ++++++++++++++++++++++
 1 file changed, 410 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index d1f9ffed5bba..95924a09960c 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -3173,6 +3173,55 @@ static struct cdns_torrent_vals ml_sgmii_pll1_100_no_ssc_cmn_vals = {
 	.num_regs = ARRAY_SIZE(ml_sgmii_pll1_100_no_ssc_cmn_regs),
 };
 
+/* TI J7200, Multilink USXGMII, using PLL0, 156.25 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs j7200_ml_usxgmii_pll0_156_25_no_ssc_cmn_regs[] = {
+	{0x0014, CMN_SSM_BIAS_TMR},
+	{0x0028, CMN_PLLSM0_PLLPRE_TMR},
+	{0x00A4, CMN_PLLSM0_PLLLOCK_TMR},
+	{0x0062, CMN_BGCAL_INIT_TMR},
+	{0x0062, CMN_BGCAL_ITER_TMR},
+	{0x0014, CMN_IBCAL_INIT_TMR},
+	{0x0018, CMN_TXPUCAL_INIT_TMR},
+	{0x0005, CMN_TXPUCAL_ITER_TMR},
+	{0x0018, CMN_TXPDCAL_INIT_TMR},
+	{0x0005, CMN_TXPDCAL_ITER_TMR},
+	{0x024A, CMN_RXCAL_INIT_TMR},
+	{0x0005, CMN_RXCAL_ITER_TMR},
+	{0x000B, CMN_SD_CAL_REFTIM_START},
+	{0x0132, CMN_SD_CAL_PLLCNT_START},
+	{0x0014, CMN_PLL0_DSM_FBH_OVRD_M0},
+	{0x0005, CMN_PLL0_DSM_FBL_OVRD_M0},
+	{0x061B, CMN_PLL0_VCOCAL_INIT_TMR},
+	{0x0019, CMN_PLL0_VCOCAL_ITER_TMR},
+	{0x1354, CMN_PLL0_VCOCAL_REFTIM_START},
+	{0x1354, CMN_PLL0_VCOCAL_PLLCNT_START},
+	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
+	{0x0138, CMN_PLL0_LOCK_REFCNT_START},
+	{0x0138, CMN_PLL0_LOCK_PLLCNT_START}
+};
+
+static struct cdns_torrent_vals j7200_ml_usxgmii_pll0_156_25_no_ssc_cmn_vals = {
+	.reg_pairs = j7200_ml_usxgmii_pll0_156_25_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(j7200_ml_usxgmii_pll0_156_25_no_ssc_cmn_regs),
+};
+
+/* TI J7200, Multilink SGMII/QSGMII, using PLL1, 100 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs j7200_ml_sgmii_pll1_100_no_ssc_cmn_regs[] = {
+	{0x0028, CMN_PLLSM1_PLLPRE_TMR},
+	{0x00A4, CMN_PLLSM1_PLLLOCK_TMR},
+	{0x0028, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x001E, CMN_PLL1_DSM_FBH_OVRD_M0},
+	{0x000C, CMN_PLL1_DSM_FBL_OVRD_M0},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
+	{0x007F, CMN_TXPUCAL_TUNE},
+	{0x007F, CMN_TXPDCAL_TUNE}
+};
+
+static struct cdns_torrent_vals j7200_ml_sgmii_pll1_100_no_ssc_cmn_vals = {
+	.reg_pairs = j7200_ml_sgmii_pll1_100_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(j7200_ml_sgmii_pll1_100_no_ssc_cmn_regs),
+};
+
 /* PCIe and USXGMII link configuration */
 static struct cdns_reg_pairs pcie_usxgmii_link_cmn_regs[] = {
 	{0x0003, PHY_PLL_CFG},
@@ -4044,6 +4093,50 @@ static struct cdns_torrent_vals sgmii_100_no_ssc_rx_ln_vals = {
 	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_rx_ln_regs),
 };
 
+/* TI J7200, multilink SGMII */
+static struct cdns_reg_pairs j7200_sgmii_100_no_ssc_tx_ln_regs[] = {
+	{0x07A2, TX_RCVDET_ST_TMR},
+	{0x00F3, TX_PSC_A0},
+	{0x04A2, TX_PSC_A2},
+	{0x04A2, TX_PSC_A3 },
+	{0x0000, TX_TXCC_CPOST_MULT_00},
+	{0x00B3, DRV_DIAG_TX_DRV},
+	{0x0002, XCVR_DIAG_PSC_OVRD},
+	{0x4000, XCVR_DIAG_RXCLK_CTRL}
+};
+
+static struct cdns_torrent_vals j7200_sgmii_100_no_ssc_tx_ln_vals = {
+	.reg_pairs = j7200_sgmii_100_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(j7200_sgmii_100_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_reg_pairs j7200_sgmii_100_no_ssc_rx_ln_regs[] = {
+	{0x0014, RX_SDCAL0_INIT_TMR},
+	{0x0062, RX_SDCAL0_ITER_TMR},
+	{0x0014, RX_SDCAL1_INIT_TMR},
+	{0x0062, RX_SDCAL1_ITER_TMR},
+	{0x091D, RX_PSC_A0},
+	{0x0900, RX_PSC_A2},
+	{0x0100, RX_PSC_A3},
+	{0x03C7, RX_REE_GCSM1_EQENM_PH1},
+	{0x01C7, RX_REE_GCSM1_EQENM_PH2},
+	{0x0000, RX_DIAG_DFE_CTRL},
+	{0x0019, RX_REE_TAP1_CLIP},
+	{0x0019, RX_REE_TAP2TON_CLIP},
+	{0x0098, RX_DIAG_NQST_CTRL},
+	{0x0C01, RX_DIAG_DFE_AMP_TUNE_2},
+	{0x0000, RX_DIAG_DFE_AMP_TUNE_3},
+	{0x0000, RX_DIAG_PI_CAP},
+	{0x0010, RX_DIAG_PI_RATE},
+	{0x0001, RX_DIAG_ACYA},
+	{0x018C, RX_CDRLF_CNFG}
+};
+
+static struct cdns_torrent_vals j7200_sgmii_100_no_ssc_rx_ln_vals = {
+	.reg_pairs = j7200_sgmii_100_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(j7200_sgmii_100_no_ssc_rx_ln_regs),
+};
+
 /* SGMII 100 MHz Ref clk, internal SSC */
 static struct cdns_reg_pairs sgmii_100_int_ssc_cmn_regs[] = {
 	{0x0004, CMN_PLL0_DSM_DIAG_M0},
@@ -4177,6 +4270,51 @@ static struct cdns_torrent_vals qsgmii_100_no_ssc_rx_ln_vals = {
 	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_rx_ln_regs),
 };
 
+/* TI J7200, multilink QSGMII */
+static struct cdns_reg_pairs j7200_qsgmii_100_no_ssc_tx_ln_regs[] = {
+	{0x07A2, TX_RCVDET_ST_TMR},
+	{0x00F3, TX_PSC_A0},
+	{0x04A2, TX_PSC_A2},
+	{0x04A2, TX_PSC_A3 },
+	{0x0000, TX_TXCC_CPOST_MULT_00},
+	{0x0011, TX_TXCC_MGNFS_MULT_100},
+	{0x0003, DRV_DIAG_TX_DRV},
+	{0x0002, XCVR_DIAG_PSC_OVRD},
+	{0x4000, XCVR_DIAG_RXCLK_CTRL}
+};
+
+static struct cdns_torrent_vals j7200_qsgmii_100_no_ssc_tx_ln_vals = {
+	.reg_pairs = j7200_qsgmii_100_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(j7200_qsgmii_100_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_reg_pairs j7200_qsgmii_100_no_ssc_rx_ln_regs[] = {
+	{0x0014, RX_SDCAL0_INIT_TMR},
+	{0x0062, RX_SDCAL0_ITER_TMR},
+	{0x0014, RX_SDCAL1_INIT_TMR},
+	{0x0062, RX_SDCAL1_ITER_TMR},
+	{0x091D, RX_PSC_A0},
+	{0x0900, RX_PSC_A2},
+	{0x0100, RX_PSC_A3},
+	{0x03C7, RX_REE_GCSM1_EQENM_PH1},
+	{0x01C7, RX_REE_GCSM1_EQENM_PH2},
+	{0x0000, RX_DIAG_DFE_CTRL},
+	{0x0019, RX_REE_TAP1_CLIP},
+	{0x0019, RX_REE_TAP2TON_CLIP},
+	{0x0098, RX_DIAG_NQST_CTRL},
+	{0x0C01, RX_DIAG_DFE_AMP_TUNE_2},
+	{0x0000, RX_DIAG_DFE_AMP_TUNE_3},
+	{0x0000, RX_DIAG_PI_CAP},
+	{0x0010, RX_DIAG_PI_RATE},
+	{0x0001, RX_DIAG_ACYA},
+	{0x018C, RX_CDRLF_CNFG}
+};
+
+static struct cdns_torrent_vals j7200_qsgmii_100_no_ssc_rx_ln_vals = {
+	.reg_pairs = j7200_qsgmii_100_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(j7200_qsgmii_100_no_ssc_rx_ln_regs),
+};
+
 /* QSGMII 100 MHz Ref clk, internal SSC */
 static struct cdns_reg_pairs qsgmii_100_int_ssc_cmn_regs[] = {
 	{0x0004, CMN_PLL0_DSM_DIAG_M0},
@@ -4846,6 +4984,274 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 	},
 };
 
+/* TI J7200 (Torrent SD0805) */
+static struct cdns_torrent_vals_entry ti_j7200_cmn_vals_entries[] = {
+	{CDNS_TORRENT_KEY(CLK_19_2_MHZ, CLK_19_2_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_19_2_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_25_MHZ, CLK_25_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_25_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_PCIE, NO_SSC), &dp_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_USB, NO_SSC), &sl_dp_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, NO_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, EXTERNAL_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, INTERNAL_SSC), &sl_pcie_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, NO_SSC), &pcie_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, EXTERNAL_SSC), &pcie_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, INTERNAL_SSC), &pcie_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, NO_SSC), &pcie_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, EXTERNAL_SSC), &pcie_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, INTERNAL_SSC), &pcie_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, NO_SSC), &pcie_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, EXTERNAL_SSC), &pcie_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, INTERNAL_SSC), &pcie_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_DP, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_NONE, NO_SSC), &sl_sgmii_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, NO_SSC), &sgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, EXTERNAL_SSC), &sgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, INTERNAL_SSC), &sgmii_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, NO_SSC), &sgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, EXTERNAL_SSC), &sgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, INTERNAL_SSC), &sgmii_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_NONE, NO_SSC), &sl_qsgmii_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, NO_SSC), &qsgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, EXTERNAL_SSC), &qsgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, INTERNAL_SSC), &qsgmii_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, NO_SSC), &qsgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, EXTERNAL_SSC), &qsgmii_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, INTERNAL_SSC), &qsgmii_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, NO_SSC), &sl_usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, EXTERNAL_SSC), &sl_usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, INTERNAL_SSC), &sl_usb_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, NO_SSC), &usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, EXTERNAL_SSC), &usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, INTERNAL_SSC), &usb_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, NO_SSC), &sl_usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, EXTERNAL_SSC), &sl_usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, INTERNAL_SSC), &sl_usb_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, NO_SSC), &sl_usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, EXTERNAL_SSC), &sl_usb_100_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, INTERNAL_SSC), &sl_usb_100_int_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &sl_usxgmii_156_25_no_ssc_cmn_vals},
+
+	/* Dual refclk */
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_SGMII, TYPE_USXGMII, NO_SSC), &j7200_ml_sgmii_pll1_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_QSGMII, TYPE_USXGMII, NO_SSC), &j7200_ml_sgmii_pll1_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_pll1_156_25_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_SGMII, NO_SSC), &j7200_ml_usxgmii_pll0_156_25_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_QSGMII, NO_SSC), &j7200_ml_usxgmii_pll0_156_25_no_ssc_cmn_vals},
+};
+
+static struct cdns_torrent_vals_entry ti_j7200_tx_ln_vals_entries[] = {
+	{CDNS_TORRENT_KEY(CLK_19_2_MHZ, CLK_19_2_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_19_2_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_25_MHZ, CLK_25_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_25_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_PCIE, NO_SSC), &dp_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_USB, NO_SSC), &dp_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, NO_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, EXTERNAL_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, INTERNAL_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, NO_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, EXTERNAL_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, INTERNAL_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, NO_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, EXTERNAL_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, INTERNAL_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, NO_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, EXTERNAL_SSC), NULL},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, INTERNAL_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_DP, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_NONE, NO_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, NO_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, EXTERNAL_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, INTERNAL_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, NO_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, EXTERNAL_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, INTERNAL_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_NONE, NO_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, NO_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, EXTERNAL_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, INTERNAL_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, NO_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, EXTERNAL_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, INTERNAL_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &usxgmii_156_25_no_ssc_tx_ln_vals},
+
+	/* Dual refclk */
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_SGMII, TYPE_USXGMII, NO_SSC), &j7200_sgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_QSGMII, TYPE_USXGMII, NO_SSC), &j7200_qsgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_156_25_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_SGMII, NO_SSC), &usxgmii_156_25_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_QSGMII, NO_SSC), &usxgmii_156_25_no_ssc_tx_ln_vals},
+};
+
+static struct cdns_torrent_vals_entry ti_j7200_rx_ln_vals_entries[] = {
+	{CDNS_TORRENT_KEY(CLK_19_2_MHZ, CLK_19_2_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_19_2_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_25_MHZ, CLK_25_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_25_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_PCIE, NO_SSC), &dp_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_DP, TYPE_USB, NO_SSC), &dp_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, EXTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE, INTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, EXTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII, INTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, EXTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_QSGMII, INTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, EXTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_USB, INTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_DP, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_NONE, NO_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, NO_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, EXTERNAL_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE, INTERNAL_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, NO_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, EXTERNAL_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_USB, INTERNAL_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_NONE, NO_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, NO_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, EXTERNAL_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_PCIE, INTERNAL_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, NO_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, EXTERNAL_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_QSGMII, TYPE_USB, INTERNAL_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, EXTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_NONE, INTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, EXTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, INTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, EXTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII, INTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, EXTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_QSGMII, INTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &usxgmii_156_25_no_ssc_rx_ln_vals},
+
+	/* Dual refclk */
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_SGMII, TYPE_USXGMII, NO_SSC), &j7200_sgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_QSGMII, TYPE_USXGMII, NO_SSC), &j7200_qsgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_156_25_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_SGMII, NO_SSC), &usxgmii_156_25_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_QSGMII, NO_SSC), &usxgmii_156_25_no_ssc_rx_ln_vals},
+};
+
+static const struct cdns_torrent_data ti_j7200_map_torrent = {
+	.block_offset_shift = 0x0,
+	.reg_offset_shift = 0x1,
+	.link_cmn_vals_tbl = {
+		.entries = link_cmn_vals_entries,
+		.num_entries = ARRAY_SIZE(link_cmn_vals_entries),
+	},
+	.xcvr_diag_vals_tbl = {
+		.entries = xcvr_diag_vals_entries,
+		.num_entries = ARRAY_SIZE(xcvr_diag_vals_entries),
+	},
+	.pcs_cmn_vals_tbl = {
+		.entries = pcs_cmn_vals_entries,
+		.num_entries = ARRAY_SIZE(pcs_cmn_vals_entries),
+	},
+	.phy_pma_cmn_vals_tbl = {
+		.entries = j721e_phy_pma_cmn_vals_entries,
+		.num_entries = ARRAY_SIZE(j721e_phy_pma_cmn_vals_entries),
+	},
+	.cmn_vals_tbl = {
+		.entries = ti_j7200_cmn_vals_entries,
+		.num_entries = ARRAY_SIZE(ti_j7200_cmn_vals_entries),
+	},
+	.tx_ln_vals_tbl = {
+		.entries = ti_j7200_tx_ln_vals_entries,
+		.num_entries = ARRAY_SIZE(ti_j7200_tx_ln_vals_entries),
+	},
+	.rx_ln_vals_tbl = {
+		.entries = ti_j7200_rx_ln_vals_entries,
+		.num_entries = ARRAY_SIZE(ti_j7200_rx_ln_vals_entries),
+	},
+};
+
 static const struct of_device_id cdns_torrent_phy_of_match[] = {
 	{
 		.compatible = "cdns,torrent-phy",
@@ -4855,6 +5261,10 @@ static const struct of_device_id cdns_torrent_phy_of_match[] = {
 		.compatible = "ti,j721e-serdes-10g",
 		.data = &ti_j721e_map_torrent,
 	},
+	{
+		.compatible = "ti,j7200-serdes-10g",
+		.data = &ti_j7200_map_torrent,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, cdns_torrent_phy_of_match);
-- 
2.25.1


