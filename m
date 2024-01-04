Return-Path: <linux-kernel+bounces-16706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6978242BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06BA1C213F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574E02232E;
	Thu,  4 Jan 2024 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZCZP+161";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="q+Wj/bMG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708842230B;
	Thu,  4 Jan 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404CSXND023074;
	Thu, 4 Jan 2024 05:30:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=proofpoint; bh=hwX3TC5irCXLeXYu9Kf
	2MkppPEAFrEZ9oFjFcsdlHUA=; b=ZCZP+1617OKz6E7jy8bNeYnUxvQ4zIUaF+I
	hR2XVHsShOwGzM/BgEkYr7AvMCpWNpZ0MyrhAGpWd5tP4+7/N1Aop1hNZxMksgFi
	cOrSOB0w6WsT9zGN9TMay3GL8ZXKdk+HzidxdGhpr/uPc81FNYFUTI+/RrReGLuk
	Ar1zxPVpmdDKUoG5TZNlQ7dYKbbQqRgfjUQtxPd4qwoXH5ZF+x2jc1IgoXLnch35
	V+GJ9g/U8ngzijgmp2ZjrvPmPu5iqqadgrovQ6LTn98VIdd2+LcXMFmzZvhsXpkF
	28I2nSzBwW/fKEQcVWz8Z0HACC9FUkS87XOt0ujnKW8OfR+ByTw==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3vafp0sncu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 05:30:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cp9ZZ9zhuQJBexDQEtcP2eCGSfm9tvRfjbrGv2iL5X6X+1VGZdprvp3dIoZweDWlrI/rrpEwD4cNqt8f1Fuu/lkJqiU+8jcop4py+lNWU8VdYwBpDfOa/Pm1s9BjQaSQ0r1MbXXLF+/FJW5d2P7OcEgsaDaWE4V/Nz7gNB06+VlxCV9LkCob5wp3mOh2F/BpFyE+XUa6qc50HD/f+i9JbeGWVzS4tJ5FVKtNodgk1VvEp70JIP/wBc1Vc2GfCANVjdg8MP8YI/m6EJVAwYFHGj3zwpbJ4GXPZnOJ+5Q+MNvLP4PcIUqCB5EFTY6CaTVCmbKQlc78UHW/RhNvngEI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwX3TC5irCXLeXYu9Kf2MkppPEAFrEZ9oFjFcsdlHUA=;
 b=SmhHFsXlX8L1+HvQSmDf1CUb/djn8LY5xXSfP6nNmRtBcC2LSUCPigtLJIkH+dX96eiLlcJz9icCrYUOBkzPbSPXQr09Y4PRmVjblZgkHDYfEkCoeCc0UZPnwkwcPy8SZB9Y/MP41tirss2G5GXMAeu2C2TsD2lPRWEdhm2gVR1xyuyMv0X3GKg6sFHQae2H2TGh/Re8EXY2Xb19LzQszKwWkxAsheREXZbR2jMV7tizB3ZafwQltdE48kS+zfJg+juQpYXucW7fjCIcrScdMeyPBQC2x94l/aMXANh0HjLivxtVfAB5O6q3f20JCKGnAS3qrR17Kan4mFvJ12sgWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwX3TC5irCXLeXYu9Kf2MkppPEAFrEZ9oFjFcsdlHUA=;
 b=q+Wj/bMGavfx6sHV5tbygw3bo8PXVK3kYrwYWZISDWBXZg+agA+q7WcCJdKKMARWzYpVDFRidyiPCpCDm7APjw/SEwa6F28g5vM/BxFu6zBSwLsda7fPbJz6Fw0iHd4CL0IaMglGgM4fv/CuehmtmnEcmE+AQYPveanQwVoa/Jk=
Received: from SJ0PR03CA0331.namprd03.prod.outlook.com (2603:10b6:a03:39c::6)
 by SA1PR07MB8689.namprd07.prod.outlook.com (2603:10b6:806:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 13:30:24 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::66) by SJ0PR03CA0331.outlook.office365.com
 (2603:10b6:a03:39c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Thu, 4 Jan 2024 13:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 13:30:23 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
	by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 404DUJR4018469
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 05:30:21 -0800
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Jan 2024 14:30:18 +0100
Received: from cadence.com (10.160.88.83) by maileu5.global.cadence.com
 (10.160.110.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24 via Frontend
 Transport; Thu, 4 Jan 2024 14:30:18 +0100
Received: from vleu-orange.cadence.com (localhost [127.0.0.1])
	by cadence.com (8.15.2/8.15.2) with ESMTP id 404DUIZn2911098;
	Thu, 4 Jan 2024 14:30:18 +0100
Received: (from sjakhade@localhost)
	by vleu-orange.cadence.com (8.15.2/8.15.2/Submit) id 404DUIgK2911097;
	Thu, 4 Jan 2024 14:30:18 +0100
From: Swapnil Jakhade <sjakhade@cadence.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 3/5] phy: cadence-torrent: Add USXGMII(156.25MHz) + SGMII/QSGMII(100MHz) multilink configuration
Date: Thu, 4 Jan 2024 14:30:11 +0100
Message-ID: <20240104133013.2911035-4-sjakhade@cadence.com>
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
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|SA1PR07MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b73da1-8f05-48e9-60b8-08dc0d294e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	A2drXvxOHxkeiBR/YhO9YwTC6L32tyyVOlZSN/g0GYYUAsZG85ubaunjHp9wFLfFo3DPfeECPh3AKGV3cc9wHFluyDcVtSJ3usGF1MNWe4uX75zfoUswhqqUhu0/4FjOyiLpl0iSnBltO3nCGBX5t5vF3SJ8O/fKTLfwQaeAjQ8PGcpMbqCMp8taZeHO4xDWk5xFicrpNAaWx+yXLU74ut2PGBrKXLbDB5GbbmXiJKw8KZxYevYkfXdfzdiRolFnDlCqww7mENXpg6TvBP9LZAbLfZIv1iXUjqIPdkNWKlg3x0v1pzwpOqeMYjhJf73PPkF0476IK1ZkKjA179U/QhWY9LX/UDkIsE3XBUifJKRjCXLVMU18e8jQPFUTE3xFe0Fi6qTxbFAj2NnUfJSKwdNIbAextC+bAyn0bVivqGXFicxUaQINyotKbY0yRBKv/eeCvzu0K3DV5hGe/ct/Q+jYO+JgT0eY+9Dl2U0DVQ90lQe3vDrHiyLTikUBdohuQDDT/u50HXowTy+NglbFQ79WtIq1SITiD9o53RE0ddy+nGBIyX618cckZuO0bK6yKoqQPwQdgJ+HBco8Tprz4b826bQLSK1Q3O9RLT1gxc7kB4M7rpWdzrvVnJHLBbe/UXwc6/o+AKkpNDy0ioVIbwQ0O8LEsIgL42UHy7VcW3U8+hv28kcHbiesSe14go+JgEqFkkDMHXCD1FvBkBNCZCCrJ8auoO0xUp2g2CLyEV4QJp6xtQywpxNLRXOEXAh88qPvLXqOu/eVaTDqLstS6Q==
X-Forefront-Antispam-Report: 
	CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(478600001)(8676002)(6666004)(4326008)(8936002)(316002)(42186006)(70206006)(54906003)(70586007)(110136005)(47076005)(36860700001)(82740400003)(426003)(336012)(1076003)(2616005)(26005)(83380400001)(5660300002)(7416002)(30864003)(2906002)(41300700001)(36756003)(7636003)(356005)(86362001)(40480700001)(40460700003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:30:23.2862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b73da1-8f05-48e9-60b8-08dc0d294e0b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB8689
X-Proofpoint-GUID: BObVIRr9N35MsBDxLT8x1Xp_54B7OC2Z
X-Proofpoint-ORIG-GUID: BObVIRr9N35MsBDxLT8x1Xp_54B7OC2Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040105

Add register sequences for USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)
multilink configuration. USXGMII uses PLL0 and SGMII/QSGMII uses PLL1.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 101 ++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index d22ffc97bce9..d1f9ffed5bba 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -3106,6 +3106,73 @@ static struct cdns_torrent_vals dp_usb_xcvr_diag_ln_vals = {
 	.num_regs = ARRAY_SIZE(dp_usb_xcvr_diag_ln_regs),
 };
 
+/* USXGMII and SGMII/QSGMII link configuration */
+static struct cdns_reg_pairs usxgmii_sgmii_link_cmn_regs[] = {
+	{0x0002, PHY_PLL_CFG},
+	{0x0400, CMN_PDIAG_PLL0_CLK_SEL_M0},
+	{0x0601, CMN_PDIAG_PLL1_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs usxgmii_sgmii_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0001, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_reg_pairs sgmii_usxgmii_xcvr_diag_ln_regs[] = {
+	{0x0111, XCVR_DIAG_HSCLK_SEL},
+	{0x0103, XCVR_DIAG_HSCLK_DIV},
+	{0x0A9B, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals usxgmii_sgmii_link_cmn_vals = {
+	.reg_pairs = usxgmii_sgmii_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(usxgmii_sgmii_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals usxgmii_sgmii_xcvr_diag_ln_vals = {
+	.reg_pairs = usxgmii_sgmii_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(usxgmii_sgmii_xcvr_diag_ln_regs),
+};
+
+static struct cdns_torrent_vals sgmii_usxgmii_xcvr_diag_ln_vals = {
+	.reg_pairs = sgmii_usxgmii_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(sgmii_usxgmii_xcvr_diag_ln_regs),
+};
+
+/* Multilink USXGMII, using PLL0, 156.25 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs ml_usxgmii_pll0_156_25_no_ssc_cmn_regs[] = {
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
+static struct cdns_torrent_vals ml_usxgmii_pll0_156_25_no_ssc_cmn_vals = {
+	.reg_pairs = ml_usxgmii_pll0_156_25_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(ml_usxgmii_pll0_156_25_no_ssc_cmn_regs),
+};
+
+/* Multilink SGMII/QSGMII, using PLL1, 100 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs ml_sgmii_pll1_100_no_ssc_cmn_regs[] = {
+	{0x0028, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x001E, CMN_PLL1_DSM_FBH_OVRD_M0},
+	{0x000C, CMN_PLL1_DSM_FBL_OVRD_M0},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
+	{0x007F, CMN_TXPUCAL_TUNE},
+	{0x007F, CMN_TXPDCAL_TUNE}
+};
+
+static struct cdns_torrent_vals ml_sgmii_pll1_100_no_ssc_cmn_vals = {
+	.reg_pairs = ml_sgmii_pll1_100_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(ml_sgmii_pll1_100_no_ssc_cmn_regs),
+};
+
 /* PCIe and USXGMII link configuration */
 static struct cdns_reg_pairs pcie_usxgmii_link_cmn_regs[] = {
 	{0x0003, PHY_PLL_CFG},
@@ -4337,10 +4404,12 @@ static struct cdns_torrent_vals_entry link_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_NONE), &sl_sgmii_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_PCIE), &pcie_sgmii_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_USB), &usb_sgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_USXGMII), &usxgmii_sgmii_link_cmn_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_QSGMII, TYPE_NONE), &sl_sgmii_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_QSGMII, TYPE_PCIE), &pcie_sgmii_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_QSGMII, TYPE_USB), &usb_sgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_QSGMII, TYPE_USXGMII), &usxgmii_sgmii_link_cmn_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_NONE), &sl_usb_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_PCIE), &pcie_usb_link_cmn_vals},
@@ -4350,6 +4419,8 @@ static struct cdns_torrent_vals_entry link_cmn_vals_entries[] = {
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &sl_usxgmii_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &pcie_usxgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_SGMII), &usxgmii_sgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_QSGMII), &usxgmii_sgmii_link_cmn_vals},
 };
 
 static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
@@ -4367,10 +4438,12 @@ static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_NONE), &sl_sgmii_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_PCIE), &sgmii_pcie_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_USB), &sgmii_usb_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_USXGMII), &sgmii_usxgmii_xcvr_diag_ln_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_QSGMII, TYPE_NONE), &sl_sgmii_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_QSGMII, TYPE_PCIE), &sgmii_pcie_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_QSGMII, TYPE_USB), &sgmii_usb_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_QSGMII, TYPE_USXGMII), &sgmii_usxgmii_xcvr_diag_ln_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_NONE), &sl_usb_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_PCIE), &usb_pcie_xcvr_diag_ln_vals},
@@ -4380,6 +4453,8 @@ static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &sl_usxgmii_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &usxgmii_pcie_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_SGMII), &usxgmii_sgmii_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_QSGMII), &usxgmii_sgmii_xcvr_diag_ln_vals},
 };
 
 static struct cdns_torrent_vals_entry pcs_cmn_vals_entries[] = {
@@ -4459,7 +4534,13 @@ static struct cdns_torrent_vals_entry cmn_vals_entries[] = {
 	/* Dual refclk */
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), NULL},
 
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_SGMII, TYPE_USXGMII, NO_SSC), &ml_sgmii_pll1_100_no_ssc_cmn_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_QSGMII, TYPE_USXGMII, NO_SSC), &ml_sgmii_pll1_100_no_ssc_cmn_vals},
+
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_pll1_156_25_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_SGMII, NO_SSC), &ml_usxgmii_pll0_156_25_no_ssc_cmn_vals},
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_QSGMII, NO_SSC), &ml_usxgmii_pll0_156_25_no_ssc_cmn_vals},
 };
 
 static struct cdns_torrent_vals_entry cdns_tx_ln_vals_entries[] = {
@@ -4531,7 +4612,13 @@ static struct cdns_torrent_vals_entry cdns_tx_ln_vals_entries[] = {
 	/* Dual refclk */
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), NULL},
 
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_SGMII, TYPE_USXGMII, NO_SSC), &sgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_QSGMII, TYPE_USXGMII, NO_SSC), &qsgmii_100_no_ssc_tx_ln_vals},
+
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_156_25_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_SGMII, NO_SSC), &ml_usxgmii_156_25_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_QSGMII, NO_SSC), &ml_usxgmii_156_25_no_ssc_tx_ln_vals},
 };
 
 static struct cdns_torrent_vals_entry cdns_rx_ln_vals_entries[] = {
@@ -4603,7 +4690,13 @@ static struct cdns_torrent_vals_entry cdns_rx_ln_vals_entries[] = {
 	/* Dual refclk */
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
 
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_SGMII, TYPE_USXGMII, NO_SSC), &sgmii_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_QSGMII, TYPE_USXGMII, NO_SSC), &qsgmii_100_no_ssc_rx_ln_vals},
+
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_156_25_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_SGMII, NO_SSC), &ml_usxgmii_156_25_no_ssc_rx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_QSGMII, NO_SSC), &ml_usxgmii_156_25_no_ssc_rx_ln_vals},
 };
 
 static const struct cdns_torrent_data cdns_map_torrent = {
@@ -4638,6 +4731,8 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 static struct cdns_torrent_vals_entry j721e_phy_pma_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &ti_usxgmii_phy_pma_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &ti_usxgmii_phy_pma_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_SGMII), &ti_usxgmii_phy_pma_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_QSGMII), &ti_usxgmii_phy_pma_cmn_vals},
 };
 
 static struct cdns_torrent_vals_entry ti_tx_ln_vals_entries[] = {
@@ -4709,7 +4804,13 @@ static struct cdns_torrent_vals_entry ti_tx_ln_vals_entries[] = {
 	/* Dual refclk */
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), NULL},
 
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_SGMII, TYPE_USXGMII, NO_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_QSGMII, TYPE_USXGMII, NO_SSC), &ti_qsgmii_100_no_ssc_tx_ln_vals},
+
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_156_25_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_SGMII, NO_SSC), &ml_usxgmii_156_25_no_ssc_tx_ln_vals},
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_QSGMII, NO_SSC), &ml_usxgmii_156_25_no_ssc_tx_ln_vals},
 };
 
 static const struct cdns_torrent_data ti_j721e_map_torrent = {
-- 
2.25.1


