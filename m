Return-Path: <linux-kernel+bounces-8759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA89B81BBDE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A1B1F27A05
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102D59903;
	Thu, 21 Dec 2023 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="W3H4y06l";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="V/L0rGm2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7C155E50;
	Thu, 21 Dec 2023 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BLFmVg7001276;
	Thu, 21 Dec 2023 08:21:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=proofpoint; bh=SLuD+0xPLEmSLkrGoU4
	lHLX3ZIaF1qD3LHHUTpUpBmA=; b=W3H4y06lc6c09iG9trHYO4Szc4sdMiTVa9m
	jl/EPs+/GbHvU1svvinhjkckF59roLD6+grq07efMslZjfXwxlLcTRhH33haoGen
	W4IvNe/7DKTP1bUXTVF0qgQGpJ1RgVG93A9OVvMhpdoPpkLFSz269Uw90G6XJqEF
	iOPPkDV3kb4JS8mFZgeEw1JkFue8ESdNfupW7HVIAkoOUZRHEQAh/Fd4Xozy1iHL
	4S9NtGcNQ74p9/oAXXbDOphUrE0Y/VGdBMJmNDFvThpTijPsYy6Pk5zb3zFvDdXz
	A9nCDj8N9CzoaNOJ3JrT5rZPiDCQyAEFN8s//jn1TjF1H2WWLIw==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3v18bydrtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 08:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLuD+0xPLEmSLkrGoU4lHLX3ZIaF1qD3LHHUTpUpBmA=;
 b=V/L0rGm2gDJ4REHKn9f15ZR+0nzqXO0BzRqywOKkzfrmJUkNMZBUgGOmh14hmiUKdm70CKPaCIQN+7QkF1qx+Zla5aYNnM5kwSZYUBDNEu21AXo7W1RTjnVOhH4kaBjhdPMSJZF37yuswV/QRvCZxEu8qIEAt/1M0dTAS7n5jm0=
Received: from BN8PR12CA0030.namprd12.prod.outlook.com (2603:10b6:408:60::43)
 by DS0PR07MB9848.namprd07.prod.outlook.com (2603:10b6:8:15d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 16:21:02 +0000
Received: from BN8NAM12FT096.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::ce) by BN8PR12CA0030.outlook.office365.com
 (2603:10b6:408:60::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 16:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT096.mail.protection.outlook.com (10.13.182.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.9 via Frontend Transport; Thu, 21 Dec 2023 16:21:01 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
	by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 3BLGKv1K005150
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 08:20:59 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 21 Dec 2023 17:20:55 +0100
Received: from cadence.com (10.160.88.83) by maileu4.global.cadence.com
 (10.160.110.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Thu, 21 Dec 2023 17:20:55 +0100
Received: from vleu-orange.cadence.com (localhost [127.0.0.1])
	by cadence.com (8.15.2/8.15.2) with ESMTP id 3BLGKuwo2131267;
	Thu, 21 Dec 2023 17:20:56 +0100
Received: (from sjakhade@localhost)
	by vleu-orange.cadence.com (8.15.2/8.15.2/Submit) id 3BLGKuh32131266;
	Thu, 21 Dec 2023 17:20:56 +0100
From: Swapnil Jakhade <sjakhade@cadence.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 5/5] phy: cadence-torrent: Add USXGMII(156.25MHz) + SGMII/QSGMII(100MHz) multilink config for TI J7200
Date: Thu, 21 Dec 2023 17:20:51 +0100
Message-ID: <20231221162051.2131202-6-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20231221162051.2131202-1-sjakhade@cadence.com>
References: <20231221162051.2131202-1-sjakhade@cadence.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM12FT096:EE_|DS0PR07MB9848:EE_
X-MS-Office365-Filtering-Correlation-Id: d3cce17d-732b-42b2-bda5-08dc0240d2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LwPeycG9eEXjkxnnMUflwWjqLgWyjyfavUSU9UzJCP1bHkG5U8T+reEPeGOLPNfS7rCOehcUKOqdIjWIfT/+3vQnEWnTjJmFGa5MwdvfftanZV+JrUlySq8JInlZwEXd2pizONfUP103eRfxAt3N3v5eElN7nF0k5Zix2f9PSR4JxIg2D0M9AneDNnK2NmwmASMIdCw1lm/zvyyAd632aKg6IN/0RG1UDoT1DBB7CXSaAYPT1VBo+4VU5IhqEEeR/ozuYeC+doS/y27zwbGNVIrgR5vXD3N4cIBgDc6JnkdFGUrWxU4rnTg16fCpKaqIWjzCW9oZry2pKlXPwYxgCXRIHaEOplrFlK5HfiLpENAuyrsfhNn2EcVcrjQERbXRAg7aO3wDl23Q9xJ/ro9sV1gJ1zCYjREBKaUQTl8n615J787g/G9Z/Y6/PEcv2B08bEGzbpiMevRJMFvj5hAe68n7pjtDo+pbRTtUNpKobVOiC+y86YCzZy+YaxEtbdAvh6SRaWEY6SHPCkfyCaX3w9+C15vbqriaGo40K9gNNSsC4QITUHMaLNPOjybCfkZZDV6JkbH1h8XfL69XKYUi1yj84wqT6QrH+mQegkYYYeDxrJuWBlXT2aKrFPJ0HljJypDudyU8N2VlDtIukEVhMjcjhm6HczaWFSonjE8aF/qwsCArgu5T34FldRUoIelg+j8082i8KAsPOT8QRIfR0DQ6sVdhu4OJ6+YzZDvXeTZf2bGoqW0fN1WKC0PLCzO7Q6+GfkKVu1tl09z+RNh73z7k7exHmZqsf+XMBpo2uXA1GSKJrYAvNGz8ybYSVGMe
X-Forefront-Antispam-Report: 
	CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(230173577357003)(230273577357003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(46966006)(36840700001)(40470700004)(42186006)(30864003)(2906002)(5660300002)(40480700001)(7416002)(7636003)(8676002)(1076003)(2616005)(70586007)(110136005)(70206006)(478600001)(47076005)(316002)(36860700001)(8936002)(4326008)(86362001)(356005)(82740400003)(6666004)(83380400001)(336012)(40460700003)(26005)(426003)(41300700001)(36756003)(54906003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:21:01.5441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cce17d-732b-42b2-bda5-08dc0240d2cd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN8NAM12FT096.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR07MB9848
X-Proofpoint-ORIG-GUID: 3tq3oGzg4mhrbHLO_XtrBekt_sybeiim
X-Proofpoint-GUID: 3tq3oGzg4mhrbHLO_XtrBekt_sybeiim
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312210124

Add a separate compatible and registers map table for TI J7200.
TI J7200 uses Torrent SD0805 version which is a special version
derived from Torrent SD0801 with some differences in register
configurations.

Add register sequences for USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)
multilink config for TI J7200. USXGMII uses PLL0 and SGMII/QSGMII
uses PLL1.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 410 ++++++++++++++++++++++
 1 file changed, 410 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 38828b15d8b1..b6a1611d1a96 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -3170,6 +3170,55 @@ static struct cdns_torrent_vals ml_sgmii_pll1_100_no_ssc_cmn_vals = {
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
@@ -4041,6 +4090,50 @@ static struct cdns_torrent_vals sgmii_100_no_ssc_rx_ln_vals = {
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
@@ -4174,6 +4267,51 @@ static struct cdns_torrent_vals qsgmii_100_no_ssc_rx_ln_vals = {
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
@@ -4843,6 +4981,274 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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
@@ -4852,6 +5258,10 @@ static const struct of_device_id cdns_torrent_phy_of_match[] = {
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


