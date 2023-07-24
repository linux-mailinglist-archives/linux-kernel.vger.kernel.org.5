Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF44F75FC56
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjGXQjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjGXQj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:39:26 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40EC133;
        Mon, 24 Jul 2023 09:39:22 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OC7Thn030912;
        Mon, 24 Jul 2023 08:00:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Tp0TiGZrlvnR5CDpMDfoaIh99gK1imve6sZN2oTNu7o=;
 b=bntNpj/UPyIKXoP3bu70zCvia/NcUvOU0nes9kC4TFMZp9dOvF3PSneB02N+pnYwSUF5
 HPT7mwtCFUvhc0MS7Fqc672vKgGCm7V7Bh8MyYl7KJTerwCl0IAPFz0IELXLNA6iiXeY
 sCxRlQh94MdTnrDQoVJfes9JcCptcT6+fiPZCKKToLUNo40Zn8Ccv6TPjf2aVE54nZu4
 WBipkLceqv+4V9w7hC57+ARefB9q2zk0JaIMJiYxMnRVURxcHQc4C3ipOjOTSdVENC0Z
 x6crtGZkZFQOzJizwLoTMXrPgU5vRY8Oe0N1B7y/buA05hd0F9oSqa2+wUesg+rftr8j 9Q== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3s0bnwx66f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 08:00:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdY6PaygQoW3hQB7wLP34/f7AXCK+tGW6v1wWiQIJQq4TS/+glEk/fEHALZ8zPIJ/iiCwojkiG27RqzzhIplcSyq0mjmGZFjozmNRkyhdBTLCd1GBfILSV0H6Rz5lsWgcZgGbIC/E0cHL6J6m18ImdMnDH6eaiSokrgSzmvxWPv2HRVRloQk3TU1jKg181poryrxpUgRo4PNX0LbboKDqHX/Ne7jlcJ4bCVCgVYA2CaSGLO2Gn6tx6xrKLYBy3lLLecQN6ubT3emxom/4LRLrEK9ty7tuxfoTUzcQ98apX6X53D/abQ/9weYhyNf5pb3sm2aPVZdO8UFTRWpmBJPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp0TiGZrlvnR5CDpMDfoaIh99gK1imve6sZN2oTNu7o=;
 b=Hw+hQZaMPtZ4t+wyYhbCjDdsNPpDJomGDHhd1Nxes1yBwadY2Kkp/+/aMoFhDokohG/50lgU6EUAlnc8RKU/XfaXzN0x4KEhFk+iO6DG+9+AdTrETpj4+AEVDuyThxcIsRCc+kGWNaVkuF5ZRpWAZNxoUNXa4Mv1yAazJUjHgRYpa2+FqzGgihue9ypvUotFgoKJh2a8L9byp6MZ925jFb29JtoWQt55y9feoJcQh0bhrt1D1Y9to3lfKB1NI7yfFwuE9vh6bArMfgcqiGVwM5VvyO94YEziaBewh2Skw/DkhZMQ7tgl0cdbLbPFCP7Zr7DBAqEpWyIAJjMafUz76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp0TiGZrlvnR5CDpMDfoaIh99gK1imve6sZN2oTNu7o=;
 b=rAA7JUYjQT4AACchJTYiRgrlMB5oXP6KkIZB0SoK84vyQhjEiwkn3tG4ZuacNagvUaOaq56urOws69d3w1LjQejy9c6SHpDbaKYiAyoBHVKQVXEYCEgc/mlVQSFtqN67Emnn8mSkrpzYliXJNuScQU9OKT1Ld3m+wz7Qo9s9jwA=
Received: from BN9PR03CA0165.namprd03.prod.outlook.com (2603:10b6:408:f4::20)
 by SJ2PR07MB9710.namprd07.prod.outlook.com (2603:10b6:a03:4af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Mon, 24 Jul
 2023 15:00:09 +0000
Received: from BN8NAM12FT024.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::b1) by BN9PR03CA0165.outlook.office365.com
 (2603:10b6:408:f4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Mon, 24 Jul 2023 15:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT024.mail.protection.outlook.com (10.13.183.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 15:00:09 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 36OF06HD023464
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 08:00:08 -0700
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 24 Jul 2023 17:00:05 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Mon, 24 Jul 2023 17:00:05 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 36OF05uc005741;
        Mon, 24 Jul 2023 17:00:05 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 36OF05nl005738;
        Mon, 24 Jul 2023 17:00:05 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH 3/5] phy: cadence-torrent: Add USXGMII(156.25MHz) + SGMII/QSGMII(100MHz) multilink configuration
Date:   Mon, 24 Jul 2023 17:00:00 +0200
Message-ID: <20230724150002.5645-4-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20230724150002.5645-1-sjakhade@cadence.com>
References: <20230724150002.5645-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT024:EE_|SJ2PR07MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8e9c12-6a0d-4d41-da65-08db8c56acc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6VDltu0cStYwc3ECDm2IJvMfxw0NbpbCW0mzqBJqJruy6yU1HFhhVR4WrFAvvnscTPBfWfQBFgAc2JbmaT5CSIiO5JR62r23RUudf1nTBOBqtKYYprt1So7Rb/py1qIWXR5oQLXBCxYTfP4wAOV8RTH3up5lahI7Q4l19h21rphk2k8Adi7bryhNZqEqzD6Uwm3v5kL/yldLGbEOIq2KrBRRWVW2ptXeqOS+G959NWjdXtYH9r4h/8m5jkkGws0mIkGlU522ne4aSWPwAYtz5szj/+NHZe5O1PP4GvnEoasFT1/ur8/lpQB72oz1qOMIyrST+z0yhcOnkEEUimaBSTGdn3jtDUFHAjvcT5dMjswqBEx6FDvaKSHPc7Lrwmh+jIKk+jWYUXcTyOfkUq+juAjDtDenaFnv63MZFFfE2m/WSqagPUVcu1BgkVdppJc8wbcRNnOjeONEHvnHa7DPfsY+roqSg2tXfQlNPrm+5m5xHK9VyHW7RcF2kmvovqqrz5ugiwVSNLIariJblhdSzDnwabJrUn8pfrjJYSnbXE0M5fKF9ETbgs2vJMZ0rD0rLnTmyL3V+6ungN+EAPpThz5XKVaIYVGMAykwFIygH4kkyfLRw8roUWt+sKEF7zTeem8w+yiWN/n496fb4s/0Bg4yVARglR/wI19jj47gNyt7uPRI9x2tRg3Ilblgl1/neL2p9q4aBBDm+8++rXUt4QGYnWBrf5IaFF8WR6u8GCsBtbfAGn6hSADfDHip4HUDT3ugZbPxsWdpTVYEdHiLYw==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(36092001)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(47076005)(1076003)(41300700001)(186003)(336012)(83380400001)(478600001)(426003)(26005)(6666004)(40480700001)(2616005)(40460700003)(2906002)(36756003)(86362001)(7416002)(5660300002)(70206006)(70586007)(4326008)(7636003)(356005)(8936002)(8676002)(316002)(42186006)(82740400003)(36860700001)(110136005)(54906003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 15:00:09.5243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8e9c12-6a0d-4d41-da65-08db8c56acc3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT024.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR07MB9710
X-Proofpoint-ORIG-GUID: HW4axAXnNIc-zMPtUAiKjXbCUg857lsr
X-Proofpoint-GUID: HW4axAXnNIc-zMPtUAiKjXbCUg857lsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_11,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307240133
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add register sequences for USXGMII(156.25MHz) + SGMII/QSGMII(100MHz)
multilink configuration.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 101 ++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index a76827aefabe..f8dfde010bf0 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -3103,6 +3103,73 @@ static struct cdns_torrent_vals dp_usb_xcvr_diag_ln_vals = {
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
@@ -4334,10 +4401,12 @@ static struct cdns_torrent_vals_entry link_cmn_vals_entries[] = {
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
@@ -4347,6 +4416,8 @@ static struct cdns_torrent_vals_entry link_cmn_vals_entries[] = {
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &sl_usxgmii_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &pcie_usxgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_SGMII), &usxgmii_sgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_QSGMII), &usxgmii_sgmii_link_cmn_vals},
 };
 
 static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
@@ -4364,10 +4435,12 @@ static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
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
@@ -4377,6 +4450,8 @@ static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &sl_usxgmii_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &usxgmii_pcie_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_SGMII), &usxgmii_sgmii_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_QSGMII), &usxgmii_sgmii_xcvr_diag_ln_vals},
 };
 
 static struct cdns_torrent_vals_entry pcs_cmn_vals_entries[] = {
@@ -4456,7 +4531,13 @@ static struct cdns_torrent_vals_entry cmn_vals_entries[] = {
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
@@ -4528,7 +4609,13 @@ static struct cdns_torrent_vals_entry cdns_tx_ln_vals_entries[] = {
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
@@ -4600,7 +4687,13 @@ static struct cdns_torrent_vals_entry cdns_rx_ln_vals_entries[] = {
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
@@ -4635,6 +4728,8 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 static struct cdns_torrent_vals_entry j721e_phy_pma_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &ti_usxgmii_phy_pma_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &ti_usxgmii_phy_pma_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_SGMII), &ti_usxgmii_phy_pma_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_QSGMII), &ti_usxgmii_phy_pma_cmn_vals},
 };
 
 static struct cdns_torrent_vals_entry ti_tx_ln_vals_entries[] = {
@@ -4706,7 +4801,13 @@ static struct cdns_torrent_vals_entry ti_tx_ln_vals_entries[] = {
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
2.34.1

