Return-Path: <linux-kernel+bounces-8757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A981BBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8D61C2355D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379FF58227;
	Thu, 21 Dec 2023 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="c/EzA3Vc";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="WZ7Zwspk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E99555E56;
	Thu, 21 Dec 2023 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL9MiHF004611;
	Thu, 21 Dec 2023 08:21:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=proofpoint; bh=eXLN4hx86pRRuNmkilu
	FnaK+Cb8A3f4oCgr9WskbLk4=; b=c/EzA3VcCS11SW6kTCfLOxzOxfd7jAyb+tx
	oEgDbbQq7DfKQJsE3Kou320GEtQhHGek6zxQIizXYyjsFD+TcJXrTF/yN8Z3v92I
	PvcBVGuEJoFCcSKDCSGs/4ysiQjx/N3mdfc6rxx4tqwkN/rC5XYOj9b1eoQzy+/W
	JEf8GVTa1Csr2Vt+LNan4S+Pv2tMmykYNnBoIT2RGnBh/mhzgFxfVhuT+PGw0HVc
	8E5M/ulKihtv73F771+euv+EM6zxj1hv90p2uRRPM8LHPIPwv/Vyse3WguqPb89M
	DhFKrwcLmodAI4aLbURa62SYN5G824uJPD++PBp8VMX2glPNLQQ==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3v18bydrtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 08:21:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcYYzh8+IzqUBODbb1xJnW4wMkvB1n6T3JINutCykUtKa2eSG5tCXFMD93+SOoXLoav+dBbbbaP/oA4b2P/OhDm/xrj39SieAe7YfaHMdvzonZsDoirw1RQR1XIJPJg1lrEPth2lZRaWNTGbuI3nhBzFOs7sEgXE1dZMJet7M4O23vThFm3e3UpVRDGI1CCpS5JrFSfsL6u5Hcsn14odQYxFI4JY47sOUlyc8cjvcnXfIfgKgdj5Ib8fBDNXu1MGJfRnRp9DmxwSW0f6gIVW7FKIo1FxX/QMivsR6LuLVG9+3/bdYYzBGHLeFIC1+r+9fk4qrKw/VjKOCsZkJQqhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXLN4hx86pRRuNmkiluFnaK+Cb8A3f4oCgr9WskbLk4=;
 b=l+sxHmiwX4iwZ94SF2vNeJTxcSHtH11cNL2eYNmiLcJSQih8tqFJz+u/6BRs6maDrhMesST1lb6W3b6etexeY7QZxvavpSMIBa6bMPRBajXxvoLGWZfdX4psoIG+pZxE88os1kYa+wxupQ3rDqNZKJgY1O3wox+7LD3k7QDJunUZfqT5MbU4IdhthCVENDuy/cXds1+JEXuFhOs/57iGwDOrzPcHhsciq4mAFSxGzlaiasE2/PMvX2yeJIsHqpgt0yrxUc1il/dKi35kpSO79Oblmzm/PDX5Zx2H/B2/ZEsF2JkYefAELijjrEOW/YtzPYcP0MLl67hNK6JR3E44dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXLN4hx86pRRuNmkiluFnaK+Cb8A3f4oCgr9WskbLk4=;
 b=WZ7ZwspkgrXX2WAo31QSlANXMLPtomLOVr3zpSynLP1KQV/0GbiekuEIOvP3M4z2zDN+nzN7DbluVFHTny10BCXQDa0fkP4PSjoFhi9ExqEPkFd1r4WC6gn1YzR7oV+M3N+rBnAmd/wK6vTjkqmreIEDWqjhim7uZOlUz64IIgA=
Received: from MW2PR16CA0038.namprd16.prod.outlook.com (2603:10b6:907:1::15)
 by BL3PR07MB8899.namprd07.prod.outlook.com (2603:10b6:208:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 16:21:00 +0000
Received: from MW2NAM12FT049.eop-nam12.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::61) by MW2PR16CA0038.outlook.office365.com
 (2603:10b6:907:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 16:20:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com; pr=C
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT049.mail.protection.outlook.com (10.13.181.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18 via Frontend Transport; Thu, 21 Dec 2023 16:20:59 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
	by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 3BLGKv1I005150
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 08:20:58 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 21 Dec 2023 17:20:55 +0100
Received: from cadence.com (10.160.88.83) by maileu4.global.cadence.com
 (10.160.110.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Thu, 21 Dec 2023 17:20:55 +0100
Received: from vleu-orange.cadence.com (localhost [127.0.0.1])
	by cadence.com (8.15.2/8.15.2) with ESMTP id 3BLGKuRu2131255;
	Thu, 21 Dec 2023 17:20:56 +0100
Received: (from sjakhade@localhost)
	by vleu-orange.cadence.com (8.15.2/8.15.2/Submit) id 3BLGKtiW2131254;
	Thu, 21 Dec 2023 17:20:55 +0100
From: Swapnil Jakhade <sjakhade@cadence.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 2/5] phy: cadence-torrent: Add PCIe(100MHz) + USXGMII(156.25MHz) multilink configuration
Date: Thu, 21 Dec 2023 17:20:48 +0100
Message-ID: <20231221162051.2131202-3-sjakhade@cadence.com>
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
X-MS-TrafficTypeDiagnostic: MW2NAM12FT049:EE_|BL3PR07MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: e58a4421-659a-4bfa-9e7c-08dc0240d197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JQ/JvJQcCdtQwuwH5isy+McOBN9JK4UMEKJd/xl/A+RsteQ3c/aTAC4uaYHavAo6OMLZWLQJRzZtRPDqXdLb4PCjT4F4uz77lkaQSmpgfsf5dyAv+494baymdfz7zmVscOxagiL+PQjmnDT16gERWSUrFFwfDaFhHfBsBIkXt6l9iz405o+Ymm8fCYRaZhzVndovENrv8Ft+48t+++MBdczURCqI4SOcHpymI48qm2yT1QntynpRmpOfaFgwnWhTaga4jjQ2bLGQyDvE8gxlfMg2NzA8OSPu6v0UL8B3nGcgIKQfyDCi7Yel38T5WOYvUCrkXF2rjVNIJ/sHlc3rNilEp2AcSGUbqDvmUQ3bnX3RLGMXUV8jlSgN0wMh2EXwI3AW2a2zm6w/Haj6ikiyQkoFgQgkqh9hiWsGCnZuY1RKi+48f9B9agca/OJwMeiGcB2vGrJnaDqetsN2hOD+XdgIzz24xILpdrToccBFSEjNuoC8gI51HTJCpZhTRtqCU+yBKj8XQoX08Bpf5N1/BIt28Yw13L7HmWwVKQZvydAsfpOCD7QuP3aTy2+biO8acboi07NmhvBRbbTvaBGhq/uYK4ZZwf8Dzgc6SR1CC3Iff/wWAGsK664mqxIkIe7KwvWIYlH2WSrlivLvwrTSsWr3W4WGh9aYFcQk2hhIQhjVsG5fpcxzXM748zXSuSOxRFgJl9fzFYxmVUE43HRUX/EBSP6oK0KcuMaM2BrOotkew2b/ORELiyc4St2zk9XvHkuUO48yXEHOUxQ69uKu5Q==
X-Forefront-Antispam-Report: 
	CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(336012)(1076003)(2616005)(26005)(6666004)(426003)(40460700003)(82740400003)(36756003)(86362001)(356005)(7636003)(7416002)(83380400001)(4326008)(8936002)(8676002)(30864003)(41300700001)(36860700001)(47076005)(54906003)(42186006)(5660300002)(70206006)(110136005)(70586007)(2906002)(316002)(478600001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:20:59.6523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e58a4421-659a-4bfa-9e7c-08dc0240d197
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MW2NAM12FT049.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR07MB8899
X-Proofpoint-ORIG-GUID: CwyezArskeMmHqs3QrIUnOlfB2amgbIh
X-Proofpoint-GUID: CwyezArskeMmHqs3QrIUnOlfB2amgbIh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312210124

Torrent PHY can have separate input reference clocks for PLL0 and PLL1.
Add support for dual reference clock multilink configurations.

Add register sequences for PCIe(100MHz) + USXGMII(156.25MHz) multilink
configuration. PCIe uses PLL0 and USXGMII uses PLL1.

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


