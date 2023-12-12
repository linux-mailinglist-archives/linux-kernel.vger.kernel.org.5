Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DC580ED11
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376604AbjLLNQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376582AbjLLNQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:16:43 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CEE109;
        Tue, 12 Dec 2023 05:16:48 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCB8sl4013917;
        Tue, 12 Dec 2023 03:48:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=proofpoint; bh=MdxlJnwhtg1umsx7j6e
        RTjeZWi5KL03phuDeT2GhS7w=; b=Uy64vE4WU2TqeIbUN0TKotek55NK4rRv/nR
        +hGrbuCgYVYT0VmQMT5uGBRW+775DRBcqXjyzbAIav2jnUTts6iRjYAPU7RK0BDy
        KRCm7oru0MIZkn0ftIHmIqsgak14KPJDifNiZt9pBFOBnbkpf5QTkP0pAdGzU6Q1
        PhiBtqGK47CZ51qpxA5C+5xjdNCNDsQ7eUpr+Ih1GAovhGF8bVfu9SvIcMC4Jav8
        0dBbnXPRlMFT3ujmQnji1TUyifRy8jr6K0zUFdEzNhCFKkD+sskPGqqk9YsroZ+3
        aUZGUlISWglEZ+ssEptw9715XWCAjxVz7qKIGq2yOZ9WcF1AHbQ==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3uvnnx9k4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 03:48:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciWGD8PgFreWRNN7oWeUcVV5yMVw71sO6QbDgWCum5KAsKe/7GEcE0gC90ISkl5LyVYWcGQGD0pXcm0hnAyVQCM3E9ohyFxSeSLh+l6Kdyd5X1jrkDi34ZmSI05kG5KXaggDrCB//erafI9jEUu8Zz8mCr+DwOmAE7ROFEunjPd+qGQXLT2sAemgIl+BNotVlBRyl7K860XqKAcc77gyg8D0r4BEvjoo482hK6M70LEHZ6CGOIN4iVAvYkz2KLirj5Jb9kPlzX3jaF9j6U2BHtMsnWsNF78kZ6h1i44otWpDDs6AOJ2uCc3IuPzOQ0PnSj5GVlmBD9OIv54XudmHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdxlJnwhtg1umsx7j6eRTjeZWi5KL03phuDeT2GhS7w=;
 b=CjzCZZizBS++M9v2erQAFSBQVL67tjL7pLD92vmhp/6hsHNGb7fuu/gG+yl++OsMPu953ZBjMGRzFmJrE+1Cy85EI6Qc9QgbAezpasZleWtH4Ysy4G2I2A9eDccpJePsD6BlYNOF2FlEFjTgJl9tT+K5HVW+L2rgWZTNFDw/24GKq8zpS5Xr7xL7Y+BW6SygbjwloenE2Up2NXW5znkg9mjohzPEhJFpt/6HcXana63tx1EIR3WjGcsor3U7ezZrUKq0cWJEtJheQ0edFSjLNM2itnntbxnpMh1CMZDfx0nzJtQwZlIWDJDi7Z1W1+f6YB6nQ2eQqb1UGjz7Ib2GGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdxlJnwhtg1umsx7j6eRTjeZWi5KL03phuDeT2GhS7w=;
 b=jDTHA1vz8sb/ri8EPmfy73k6IQblmlfuQHUsGJcEM8gYqbjm8PqV/kOQeX84tSj8DgA6IyHAksrpSkTzH5lMgnysmy9EYZiTdzc+L2YvYEiMd6C3rEeO05eN/1NXnJeROlVOUxTcUkbhqOGioHb4hJhTS7Lzx6XqvGh95aUtkO8=
Received: from DM6PR13CA0072.namprd13.prod.outlook.com (2603:10b6:5:134::49)
 by BL0PR07MB8132.namprd07.prod.outlook.com (2603:10b6:208:1ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:48:49 +0000
Received: from DM6NAM12FT024.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::77) by DM6PR13CA0072.outlook.office365.com
 (2603:10b6:5:134::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 11:48:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com; pr=C
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT024.mail.protection.outlook.com (10.13.179.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.8 via Frontend Transport; Tue, 12 Dec 2023 11:48:48 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 3BCBmk8I027983
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 03:48:47 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Dec 2023 12:48:45 +0100
Received: from cadence.com (10.160.88.83) by maileu4.global.cadence.com
 (10.160.110.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Tue, 12 Dec 2023 12:48:45 +0100
Received: from vleu-orange.cadence.com (localhost [127.0.0.1])
        by cadence.com (8.15.2/8.15.2) with ESMTP id 3BCBmjTE1468955;
        Tue, 12 Dec 2023 12:48:45 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.15.2/8.15.2/Submit) id 3BCBmjXe1468954;
        Tue, 12 Dec 2023 12:48:45 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 2/5] phy: cadence-torrent: Add PCIe(100MHz) + USXGMII(156.25MHz) multilink configuration
Date:   Tue, 12 Dec 2023 12:48:37 +0100
Message-ID: <20231212114840.1468903-3-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20231212114840.1468903-1-sjakhade@cadence.com>
References: <20231212114840.1468903-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT024:EE_|BL0PR07MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d38ce7-322d-4903-ce35-08dbfb084dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2XSHshfDMBK7FSoMRRQkVXCkels27f9gUFUFqz9TXy6SH1+pECPlYVvc2XXFmEKYDeGfAO+Y/NSdq9+zk3wOcMMPBq2BSzOZt4VL1fszyFGq1bf9dpNIs+LJc9vzaocxzTUNIZpq+WwNByGe5RdQ81A0XNvtCted1iyRaaEgm8wyZRVrcM2sO03kYS+vuFiVaTlpVe7CX+btmN6c0HRUaeh6P7hSeB6MzIowOUKKfsmZVyVzb6TlZHgt+nvGUSinr69gYo/qNscI0LF/AGR3/HDO/flm0du1Smi81RdJQL+NNEEzqOg/YM4IC99IAIuH8S2CD6/A4OCrLw+2iKWegcDgdxrgOKrUo/jL2ShVrtWN+9t29otxl99t1NYXnBQmDbuGRlk+rXM8PBUewqsoZLl3HH55cRCSqzF1pm9G4mEwOS37RCplf0qGjUel8HizxQG2icmZuO28Z28DBSd9PkMpekjx7mI+ARoxqfML6FJs3Gx80rO7YsE/ozhTYSjYf3ST+0gyQ/EQbxtfB+NZdbFrIAXz2r+OuCNq254LIrKIiZtpe+vzBc6sVPMXwuM2YDFFAoSH+D7uleKwh49Je5wV8fmexMzgvH5gpL1kHnSeyGRd/xYPdrI6NFQTDfWkwE171NdDDUhrVD/7b1+WtZVWhxOv4jiOYM4sCj/yYYH88ivY59UIglQgPSH3OZ6eBTtn0OF2JGvO7Xk/ZQur3cynqfS1Yq185GMJcLgMuo1iMKLHG9Ecn5Ipxngmdjo456IB0+SeKP/x3iHLA5sSOA==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(110136005)(70206006)(70586007)(82740400003)(7636003)(356005)(86362001)(36756003)(36860700001)(47076005)(83380400001)(26005)(426003)(336012)(1076003)(2616005)(7416002)(30864003)(2906002)(6666004)(54906003)(42186006)(316002)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:48:48.6458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d38ce7-322d-4903-ce35-08dbfb084dda
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT024.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB8132
X-Proofpoint-ORIG-GUID: 8InxVFi5_6q8oFYVvWKP6roBuJzPxMpG
X-Proofpoint-GUID: 8InxVFi5_6q8oFYVvWKP6roBuJzPxMpG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Torrent PHY can have two input reference clocks.
Add support for dual reference clock multilink configurations.
Add register sequences for PCIe(100MHz) + USXGMII(156.25MHz) multilink
configuration.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 194 +++++++++++++++++++++-
 1 file changed, 191 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index a75c96385c57..18ec49c9a76e 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -355,7 +355,9 @@ struct cdns_torrent_phy {
 	struct reset_control *apb_rst;
 	struct device *dev;
 	struct clk *clk;
+	struct clk *clk1;
 	enum cdns_torrent_ref_clk ref_clk_rate;
+	enum cdns_torrent_ref_clk ref_clk1_rate;
 	struct cdns_torrent_inst phys[MAX_NUM_LANES];
 	int nsubnodes;
 	const struct cdns_torrent_data *init_data;
@@ -2460,9 +2462,11 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 {
 	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	enum cdns_torrent_ref_clk ref_clk1 = cdns_phy->ref_clk1_rate;
 	enum cdns_torrent_ref_clk ref_clk = cdns_phy->ref_clk_rate;
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	enum cdns_torrent_phy_type phy_t1, phy_t2;
+	struct cdns_torrent_vals *phy_pma_cmn_vals;
 	struct cdns_torrent_vals *pcs_cmn_vals;
 	int i, j, node, mlane, num_lanes, ret;
 	struct cdns_reg_pairs *reg_pairs;
@@ -2489,6 +2493,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 			 * Get the array values as [phy_t2][phy_t1][ssc].
 			 */
 			swap(phy_t1, phy_t2);
+			swap(ref_clk, ref_clk1);
 		}
 
 		mlane = cdns_phy->phys[node].mlane;
@@ -2552,9 +2557,22 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 					     reg_pairs[i].val);
 		}
 
+		/* PHY PMA common registers configurations */
+		phy_pma_cmn_vals = cdns_torrent_get_tbl_vals(&init_data->phy_pma_cmn_vals_tbl,
+							     CLK_ANY, CLK_ANY,
+							     phy_t1, phy_t2, ANY_SSC);
+		if (phy_pma_cmn_vals) {
+			reg_pairs = phy_pma_cmn_vals->reg_pairs;
+			num_regs = phy_pma_cmn_vals->num_regs;
+			regmap = cdns_phy->regmap_phy_pma_common_cdb;
+			for (i = 0; i < num_regs; i++)
+				regmap_write(regmap, reg_pairs[i].off,
+					     reg_pairs[i].val);
+		}
+
 		/* PMA common registers configurations */
 		cmn_vals = cdns_torrent_get_tbl_vals(&init_data->cmn_vals_tbl,
-						     ref_clk, ref_clk,
+						     ref_clk, ref_clk1,
 						     phy_t1, phy_t2, ssc);
 		if (cmn_vals) {
 			reg_pairs = cmn_vals->reg_pairs;
@@ -2567,7 +2585,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 
 		/* PMA TX lane registers configurations */
 		tx_ln_vals = cdns_torrent_get_tbl_vals(&init_data->tx_ln_vals_tbl,
-						       ref_clk, ref_clk,
+						       ref_clk, ref_clk1,
 						       phy_t1, phy_t2, ssc);
 		if (tx_ln_vals) {
 			reg_pairs = tx_ln_vals->reg_pairs;
@@ -2582,7 +2600,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 
 		/* PMA RX lane registers configurations */
 		rx_ln_vals = cdns_torrent_get_tbl_vals(&init_data->rx_ln_vals_tbl,
-						       ref_clk, ref_clk,
+						       ref_clk, ref_clk1,
 						       phy_t1, phy_t2, ssc);
 		if (rx_ln_vals) {
 			reg_pairs = rx_ln_vals->reg_pairs;
@@ -2684,9 +2702,11 @@ static int cdns_torrent_reset(struct cdns_torrent_phy *cdns_phy)
 static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
 {
 	struct device *dev = cdns_phy->dev;
+	unsigned long ref_clk1_rate;
 	unsigned long ref_clk_rate;
 	int ret;
 
+	/* refclk: Input reference clock for PLL0 */
 	cdns_phy->clk = devm_clk_get(dev, "refclk");
 	if (IS_ERR(cdns_phy->clk)) {
 		dev_err(dev, "phy ref clock not found\n");
@@ -2725,7 +2745,54 @@ static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
 		return -EINVAL;
 	}
 
+	/* refclk1: Input reference clock for PLL1 */
+	cdns_phy->clk1 = devm_clk_get_optional(dev, "pll1_refclk");
+	if (IS_ERR(cdns_phy->clk1)) {
+		dev_err(dev, "phy pll1 ref clock not found\n");
+		return PTR_ERR(cdns_phy->clk1);
+	}
+
+	if (cdns_phy->clk1) {
+		ret = clk_prepare_enable(cdns_phy->clk1);
+		if (ret) {
+			dev_err(cdns_phy->dev, "Failed to prepare pll1 ref clock\n");
+			clk_disable_unprepare(cdns_phy->clk);
+			return ret;
+		}
+
+		ref_clk1_rate = clk_get_rate(cdns_phy->clk1);
+		if (!ref_clk1_rate) {
+			dev_err(cdns_phy->dev, "Failed to get pll1 ref clock rate\n");
+			goto refclk1_err;
+		}
+
+		switch (ref_clk1_rate) {
+		case REF_CLK_19_2MHZ:
+			cdns_phy->ref_clk1_rate = CLK_19_2_MHZ;
+			break;
+		case REF_CLK_25MHZ:
+			cdns_phy->ref_clk1_rate = CLK_25_MHZ;
+			break;
+		case REF_CLK_100MHZ:
+			cdns_phy->ref_clk1_rate = CLK_100_MHZ;
+			break;
+		case REF_CLK_156_25MHZ:
+			cdns_phy->ref_clk1_rate = CLK_156_25_MHZ;
+			break;
+		default:
+			dev_err(cdns_phy->dev, "Invalid pll1 ref clock rate\n");
+			goto refclk1_err;
+		}
+	} else {
+		cdns_phy->ref_clk1_rate = cdns_phy->ref_clk_rate;
+	}
+
 	return 0;
+
+refclk1_err:
+	clk_disable_unprepare(cdns_phy->clk1);
+	clk_disable_unprepare(cdns_phy->clk);
+	return -EINVAL;
 }
 
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
@@ -2981,6 +3048,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	of_node_put(child);
 	reset_control_assert(cdns_phy->apb_rst);
 	clk_disable_unprepare(cdns_phy->clk);
+	clk_disable_unprepare(cdns_phy->clk1);
 clk_cleanup:
 	cdns_torrent_clk_cleanup(cdns_phy);
 	return ret;
@@ -2999,6 +3067,7 @@ static void cdns_torrent_phy_remove(struct platform_device *pdev)
 	}
 
 	clk_disable_unprepare(cdns_phy->clk);
+	clk_disable_unprepare(cdns_phy->clk1);
 	cdns_torrent_clk_cleanup(cdns_phy);
 }
 
@@ -3034,6 +3103,100 @@ static struct cdns_torrent_vals dp_usb_xcvr_diag_ln_vals = {
 	.num_regs = ARRAY_SIZE(dp_usb_xcvr_diag_ln_regs),
 };
 
+/* PCIe and USXGMII link configuration */
+static struct cdns_reg_pairs pcie_usxgmii_link_cmn_regs[] = {
+	{0x0003, PHY_PLL_CFG},
+	{0x0601, CMN_PDIAG_PLL0_CLK_SEL_M0},
+	{0x0400, CMN_PDIAG_PLL0_CLK_SEL_M1},
+	{0x0400, CMN_PDIAG_PLL1_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs pcie_usxgmii_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0012, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_reg_pairs usxgmii_pcie_xcvr_diag_ln_regs[] = {
+	{0x0011, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0089, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals pcie_usxgmii_link_cmn_vals = {
+	.reg_pairs = pcie_usxgmii_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_usxgmii_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals pcie_usxgmii_xcvr_diag_ln_vals = {
+	.reg_pairs = pcie_usxgmii_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(pcie_usxgmii_xcvr_diag_ln_regs),
+};
+
+static struct cdns_torrent_vals usxgmii_pcie_xcvr_diag_ln_vals = {
+	.reg_pairs = usxgmii_pcie_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(usxgmii_pcie_xcvr_diag_ln_regs),
+};
+
+/*
+ * Multilink USXGMII, using PLL1, 156.25 MHz Ref clk, no SSC
+ */
+static struct cdns_reg_pairs ml_usxgmii_pll1_156_25_no_ssc_cmn_regs[] = {
+	{0x0028, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x0014, CMN_PLL1_DSM_FBH_OVRD_M0},
+	{0x0005, CMN_PLL1_DSM_FBL_OVRD_M0},
+	{0x061B, CMN_PLL1_VCOCAL_INIT_TMR},
+	{0x0019, CMN_PLL1_VCOCAL_ITER_TMR},
+	{0x1354, CMN_PLL1_VCOCAL_REFTIM_START},
+	{0x1354, CMN_PLL1_VCOCAL_PLLCNT_START},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
+	{0x0138, CMN_PLL1_LOCK_REFCNT_START},
+	{0x0138, CMN_PLL1_LOCK_PLLCNT_START},
+	{0x007F, CMN_TXPUCAL_TUNE},
+	{0x007F, CMN_TXPDCAL_TUNE}
+};
+
+static struct cdns_reg_pairs ml_usxgmii_156_25_no_ssc_tx_ln_regs[] = {
+	{0x00F3, TX_PSC_A0},
+	{0x04A2, TX_PSC_A2},
+	{0x04A2, TX_PSC_A3 },
+	{0x0000, TX_TXCC_CPOST_MULT_00},
+	{0x0000, XCVR_DIAG_PSC_OVRD}
+};
+
+static struct cdns_reg_pairs ml_usxgmii_156_25_no_ssc_rx_ln_regs[] = {
+	{0x091D, RX_PSC_A0},
+	{0x0900, RX_PSC_A2},
+	{0x0100, RX_PSC_A3},
+	{0x0030, RX_REE_SMGM_CTRL1},
+	{0x03C7, RX_REE_GCSM1_EQENM_PH1},
+	{0x01C7, RX_REE_GCSM1_EQENM_PH2},
+	{0x0000, RX_DIAG_DFE_CTRL},
+	{0x0019, RX_REE_TAP1_CLIP},
+	{0x0019, RX_REE_TAP2TON_CLIP},
+	{0x00B9, RX_DIAG_NQST_CTRL},
+	{0x0C21, RX_DIAG_DFE_AMP_TUNE_2},
+	{0x0002, RX_DIAG_DFE_AMP_TUNE_3},
+	{0x0033, RX_DIAG_PI_RATE},
+	{0x0001, RX_DIAG_ACYA},
+	{0x018C, RX_CDRLF_CNFG}
+};
+
+static struct cdns_torrent_vals ml_usxgmii_pll1_156_25_no_ssc_cmn_vals = {
+	.reg_pairs = ml_usxgmii_pll1_156_25_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(ml_usxgmii_pll1_156_25_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals ml_usxgmii_156_25_no_ssc_tx_ln_vals = {
+	.reg_pairs = ml_usxgmii_156_25_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(ml_usxgmii_156_25_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_torrent_vals ml_usxgmii_156_25_no_ssc_rx_ln_vals = {
+	.reg_pairs = ml_usxgmii_156_25_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(ml_usxgmii_156_25_no_ssc_rx_ln_regs),
+};
+
 /* TI USXGMII configuration: Enable cmn_refclk_rcv_out_en */
 static struct cdns_reg_pairs ti_usxgmii_phy_pma_cmn_regs[] = {
 	{0x0040, PHY_PMA_CMN_CTRL1},
@@ -4166,6 +4329,7 @@ static struct cdns_torrent_vals_entry link_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_QSGMII), &pcie_sgmii_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USB), &pcie_usb_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_DP), &pcie_dp_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USXGMII), &pcie_usxgmii_link_cmn_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_NONE), &sl_sgmii_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_PCIE), &pcie_sgmii_link_cmn_vals},
@@ -4182,6 +4346,7 @@ static struct cdns_torrent_vals_entry link_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_DP), &usb_dp_link_cmn_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &sl_usxgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &pcie_usxgmii_link_cmn_vals},
 };
 
 static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
@@ -4194,6 +4359,7 @@ static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_QSGMII), &pcie_sgmii_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USB), &pcie_usb_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_DP), &pcie_dp_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USXGMII), &pcie_usxgmii_xcvr_diag_ln_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_NONE), &sl_sgmii_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_PCIE), &sgmii_pcie_xcvr_diag_ln_vals},
@@ -4210,6 +4376,7 @@ static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_DP), &usb_dp_xcvr_diag_ln_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &sl_usxgmii_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &usxgmii_pcie_xcvr_diag_ln_vals},
 };
 
 static struct cdns_torrent_vals_entry pcs_cmn_vals_entries[] = {
@@ -4285,6 +4452,11 @@ static struct cdns_torrent_vals_entry cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_cmn_vals},
 
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &sl_usxgmii_156_25_no_ssc_cmn_vals},
+
+	/* Dual refclk */
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_pll1_156_25_no_ssc_cmn_vals},
 };
 
 static struct cdns_torrent_vals_entry cdns_tx_ln_vals_entries[] = {
@@ -4352,6 +4524,11 @@ static struct cdns_torrent_vals_entry cdns_tx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
 
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &usxgmii_156_25_no_ssc_tx_ln_vals},
+
+	/* Dual refclk */
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_156_25_no_ssc_tx_ln_vals},
 };
 
 static struct cdns_torrent_vals_entry cdns_rx_ln_vals_entries[] = {
@@ -4419,6 +4596,11 @@ static struct cdns_torrent_vals_entry cdns_rx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
 
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &usxgmii_156_25_no_ssc_rx_ln_vals},
+
+	/* Dual refclk */
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_156_25_no_ssc_rx_ln_vals},
 };
 
 static const struct cdns_torrent_data cdns_map_torrent = {
@@ -4452,6 +4634,7 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 
 static struct cdns_torrent_vals_entry j721e_phy_pma_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &ti_usxgmii_phy_pma_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &ti_usxgmii_phy_pma_cmn_vals},
 };
 
 static struct cdns_torrent_vals_entry ti_tx_ln_vals_entries[] = {
@@ -4519,6 +4702,11 @@ static struct cdns_torrent_vals_entry ti_tx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
 
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &usxgmii_156_25_no_ssc_tx_ln_vals},
+
+	/* Dual refclk */
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_156_25_no_ssc_tx_ln_vals},
 };
 
 static const struct cdns_torrent_data ti_j721e_map_torrent = {
-- 
2.25.1

