Return-Path: <linux-kernel+bounces-16775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F35824396
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704A41F243B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640FB2376E;
	Thu,  4 Jan 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="lUzdDDme";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="6BAnshRO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD922F1F;
	Thu,  4 Jan 2024 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404C8rmv000917;
	Thu, 4 Jan 2024 05:30:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=proofpoint; bh=hoE7XRh/496hT1CklGl
	1HzR4bXB4IDLmtnvrNdP0CBY=; b=lUzdDDmeJZICYzIfqQmelA6xeFC696FZYBf
	QgK/TsQWkNOozEIebHvwA8xrPTe1fOt1Ld/I9yJsmpNGjRjYPDfSY02JYyS1nTCe
	cYIV6AQ1B6sBX4jlBdF8hiL98ttN7S7FlOa6wSlnrZjzS0FFQmqdDwVlqd64Rf4N
	KEk07GVpCyFNdeqGgOJv5iLnhB7FnDRtSscIPT0m6g+deaHRiny1NLLmw5goOppV
	Y/y3RWR69Bc7HYtSTS+Z9JmENJor+eh1fbFMJXlsvFBnwuCxgg+7rtiGIBavAgCY
	tXo0PeHJ8sYq46mQn4qqfJLf613ctXhYUHzh2m+FmmMtiQK+VtA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3vagmwhm6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 05:30:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+KvJV/HoplVhUu3kiFqrezvUhuBBX4chok9nYDGl3EBo6B+x8MiLi/eviITRrCGBqsnLmJ03vikrHntF9LE8I6QDS6wGWYgi1N8OpOAYm0/Si6D8Bmmi5Eo/bRKeXJSoaGiTELZ3n9ozQ1ai/d16bV0iZbUcYkwCZwsryaumpl+aM9Ex6HWbiiSCRfwaXbl+U0hxH58leJlSjH+be8Yhp5JKdp4O/KJKiH+6kOCcUnf3z77BNy3B+dYRlOJKIQRHFsW98hJsAMF1DFPVzfT8Yh3PZV+sHfW/wRCZFKTjfmoVt7yivonQRKDwRJfhMZPX9QUN8jdmabqgDK0ld58/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoE7XRh/496hT1CklGl1HzR4bXB4IDLmtnvrNdP0CBY=;
 b=kksAKKK2lU6YWWIc4xP99kq9TvflJGzwAsC6nKHxJ6PnQjYVhv2qw1zoy5o0rYnZ2/S3w6J3YLnAtcbRadXiaUrv+hfbYtt0t7KU5UkYK1Jesq3N2tb4sZquLvjx58y0vQSHRPRTD57/R3o9Yyy1os9TEbb9V0/HTkIEmAnpLFjl5yEjsHr8CzKDK6M/r80rUISyHJIxMlNpngFkPJN72apDCix1lcABIy4F49IYhHUVUfv+C4E4kJRXkHSg5hHjsgr5TPjGZcMGl7RS8IkoUrw1mNhfeDgzVtjsSdq7YfI1JKpD3/MAcEfzXMtD7bBgM9kFXb7+5WXHddOMVwccEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoE7XRh/496hT1CklGl1HzR4bXB4IDLmtnvrNdP0CBY=;
 b=6BAnshROao/vAmrRh25TQkOX4ZP2hDIL8tQ7SiPJN+m7RU0lQegZqyZgYNUadWubYkvQUbfDUf2I9ReXWY+Wu2a5srLtrRo/M/dzCK0oj7NMF5HmhslPZyCuPUef+RgP4QasjL4jL8Ygf/lLdaecaPPXGKu9nzo9P/Jl9HZA1v0=
Received: from MW4PR03CA0295.namprd03.prod.outlook.com (2603:10b6:303:b5::30)
 by BN8PR07MB7121.namprd07.prod.outlook.com (2603:10b6:408:d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 13:30:24 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::ae) by MW4PR03CA0295.outlook.office365.com
 (2603:10b6:303:b5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Thu, 4 Jan 2024 13:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com; pr=C
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 13:30:23 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
	by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 404DUJMj096550
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Thu, 4 Jan 2024 05:30:22 -0800
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 4 Jan 2024 14:30:18 +0100
Received: from cadence.com (10.160.88.83) by maileu5.global.cadence.com
 (10.160.110.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24 via Frontend
 Transport; Thu, 4 Jan 2024 14:30:18 +0100
Received: from vleu-orange.cadence.com (localhost [127.0.0.1])
	by cadence.com (8.15.2/8.15.2) with ESMTP id 404DUIsw2911090;
	Thu, 4 Jan 2024 14:30:18 +0100
Received: (from sjakhade@localhost)
	by vleu-orange.cadence.com (8.15.2/8.15.2/Submit) id 404DUIfg2911089;
	Thu, 4 Jan 2024 14:30:18 +0100
From: Swapnil Jakhade <sjakhade@cadence.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <mparab@cadence.com>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 2/5] phy: cadence-torrent: Add PCIe(100MHz) + USXGMII(156.25MHz) multilink configuration
Date: Thu, 4 Jan 2024 14:30:10 +0100
Message-ID: <20240104133013.2911035-3-sjakhade@cadence.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|BN8PR07MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e95d6ee-70f4-427b-0339-08dc0d294e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q3ANii78c+eKsgehQj/rn52dJjfUHh5i3LLJBHGNGYIdKT9rLOQvgoSF4LKEZEKz1/p0gBFAfWxSZui9teVw0s8TMCWi0oGiANWvYsqC6o/ruPH5ztixvhECy5r9NDE3p1JN+YcWlp7F5NkgLZZp3Yb19ADOU62NZcm9JoHo4IqzLWIX7l0mYbDpIiUhNqan4v8CdkiPuMwyNyivwvq9aDDj/5R2HfuBOMoZRqzX0vnp2BlTZAltWhbUsVnDsKmWxInze+YKQcIzlLE4UFQEY4qXKxjCKCRy/fjSW9M1lzREXutGmH0lTfxXT5mXEsZtYd9TQrZ8vGvwnnXF8ThMaz3CjqP/us+4+KRlatYOD6Pihw7vgzWPKqKbpThC+UVMp7mEYDwdTGbm0S8Yse/9SKrPttydHo2olgtKQAXLGsdUF8+Los7RnnJstuz3xwj+9eplCwr/CpEHy7rhNfCHCQBEr8rlxB5Wu/hRULhOQMbPN8Ga4tIYGIFg3n5eSAeWVTwCAr+VBK+zTLNoQECZBaaIjKoXItWF2xj69XTw2LVQy+ESJM92xssbPN7yES7o0ZZxa4WNcVXbXgpGnhkh3QFUnLS/ZUL2///BpMkDJR8xvuRJbnkjBBHUXndBLWbrx1N39TdnIO19e/fGhXP/hPixtWvG3TVhZTR41if9+ib/q4ApLRYeRRsZdUU3wqmNuhsnkJIkWmN9CwOzlHTSKn1V2VNKO1oYTYBwBQ62JWdj9mtL9t58WhSR0qiLzGMxcXoxi1qDjTFCO9iYnQg8Yw==
X-Forefront-Antispam-Report: 
	CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39850400004)(396003)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(36840700001)(46966006)(82740400003)(81166007)(356005)(36756003)(40480700001)(86362001)(1076003)(2616005)(426003)(6666004)(26005)(316002)(8676002)(478600001)(8936002)(54906003)(70206006)(110136005)(70586007)(4326008)(47076005)(42186006)(336012)(36860700001)(83380400001)(41300700001)(2906002)(30864003)(5660300002)(7416002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:30:23.2354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e95d6ee-70f4-427b-0339-08dc0d294e06
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB7121
X-Proofpoint-GUID: l-tHn7c9XhRsDTbRcR7tVoi95sdUt81t
X-Proofpoint-ORIG-GUID: l-tHn7c9XhRsDTbRcR7tVoi95sdUt81t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401040105

Torrent PHY can have separate input reference clocks for PLL0 and PLL1.
Add support for dual reference clock multilink configurations.

Add register sequences for PCIe(100MHz) + USXGMII(156.25MHz) multilink
configuration. PCIe uses PLL0 and USXGMII uses PLL1.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 209 +++++++++++++++++++++-
 1 file changed, 200 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index a75c96385c57..d22ffc97bce9 100644
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
@@ -2695,15 +2715,15 @@ static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
 
 	ret = clk_prepare_enable(cdns_phy->clk);
 	if (ret) {
-		dev_err(cdns_phy->dev, "Failed to prepare ref clock\n");
+		dev_err(cdns_phy->dev, "Failed to prepare ref clock: %d\n", ret);
 		return ret;
 	}
 
 	ref_clk_rate = clk_get_rate(cdns_phy->clk);
 	if (!ref_clk_rate) {
 		dev_err(cdns_phy->dev, "Failed to get ref clock rate\n");
-		clk_disable_unprepare(cdns_phy->clk);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto disable_clk;
 	}
 
 	switch (ref_clk_rate) {
@@ -2720,12 +2740,62 @@ static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
 		cdns_phy->ref_clk_rate = CLK_156_25_MHZ;
 		break;
 	default:
-		dev_err(cdns_phy->dev, "Invalid Ref Clock Rate\n");
-		clk_disable_unprepare(cdns_phy->clk);
-		return -EINVAL;
+		dev_err(cdns_phy->dev, "Invalid ref clock rate\n");
+		ret = -EINVAL;
+		goto disable_clk;
+	}
+
+	/* refclk1: Input reference clock for PLL1 */
+	cdns_phy->clk1 = devm_clk_get_optional(dev, "pll1_refclk");
+	if (IS_ERR(cdns_phy->clk1)) {
+		dev_err(dev, "phy PLL1 ref clock not found\n");
+		ret = PTR_ERR(cdns_phy->clk1);
+		goto disable_clk;
+	}
+
+	if (cdns_phy->clk1) {
+		ret = clk_prepare_enable(cdns_phy->clk1);
+		if (ret) {
+			dev_err(cdns_phy->dev, "Failed to prepare PLL1 ref clock: %d\n", ret);
+			goto disable_clk;
+		}
+
+		ref_clk1_rate = clk_get_rate(cdns_phy->clk1);
+		if (!ref_clk1_rate) {
+			dev_err(cdns_phy->dev, "Failed to get PLL1 ref clock rate\n");
+			ret = -EINVAL;
+			goto disable_clk1;
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
+			dev_err(cdns_phy->dev, "Invalid PLL1 ref clock rate\n");
+			ret = -EINVAL;
+			goto disable_clk1;
+		}
+	} else {
+		cdns_phy->ref_clk1_rate = cdns_phy->ref_clk_rate;
 	}
 
 	return 0;
+
+disable_clk1:
+	clk_disable_unprepare(cdns_phy->clk1);
+disable_clk:
+	clk_disable_unprepare(cdns_phy->clk);
+	return ret;
 }
 
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
@@ -2980,6 +3050,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		reset_control_put(cdns_phy->phys[i].lnk_rst);
 	of_node_put(child);
 	reset_control_assert(cdns_phy->apb_rst);
+	clk_disable_unprepare(cdns_phy->clk1);
 	clk_disable_unprepare(cdns_phy->clk);
 clk_cleanup:
 	cdns_torrent_clk_cleanup(cdns_phy);
@@ -2998,6 +3069,7 @@ static void cdns_torrent_phy_remove(struct platform_device *pdev)
 		reset_control_put(cdns_phy->phys[i].lnk_rst);
 	}
 
+	clk_disable_unprepare(cdns_phy->clk1);
 	clk_disable_unprepare(cdns_phy->clk);
 	cdns_torrent_clk_cleanup(cdns_phy);
 }
@@ -3034,6 +3106,100 @@ static struct cdns_torrent_vals dp_usb_xcvr_diag_ln_vals = {
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
@@ -4166,6 +4332,7 @@ static struct cdns_torrent_vals_entry link_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_QSGMII), &pcie_sgmii_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USB), &pcie_usb_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_DP), &pcie_dp_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USXGMII), &pcie_usxgmii_link_cmn_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_NONE), &sl_sgmii_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_PCIE), &pcie_sgmii_link_cmn_vals},
@@ -4182,6 +4349,7 @@ static struct cdns_torrent_vals_entry link_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_DP), &usb_dp_link_cmn_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &sl_usxgmii_link_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &pcie_usxgmii_link_cmn_vals},
 };
 
 static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
@@ -4194,6 +4362,7 @@ static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_QSGMII), &pcie_sgmii_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USB), &pcie_usb_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_DP), &pcie_dp_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USXGMII), &pcie_usxgmii_xcvr_diag_ln_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_NONE), &sl_sgmii_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_PCIE), &sgmii_pcie_xcvr_diag_ln_vals},
@@ -4210,6 +4379,7 @@ static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_DP), &usb_dp_xcvr_diag_ln_vals},
 
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &sl_usxgmii_xcvr_diag_ln_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &usxgmii_pcie_xcvr_diag_ln_vals},
 };
 
 static struct cdns_torrent_vals_entry pcs_cmn_vals_entries[] = {
@@ -4285,6 +4455,11 @@ static struct cdns_torrent_vals_entry cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_cmn_vals},
 
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &sl_usxgmii_156_25_no_ssc_cmn_vals},
+
+	/* Dual refclk */
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_pll1_156_25_no_ssc_cmn_vals},
 };
 
 static struct cdns_torrent_vals_entry cdns_tx_ln_vals_entries[] = {
@@ -4352,6 +4527,11 @@ static struct cdns_torrent_vals_entry cdns_tx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
 
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &usxgmii_156_25_no_ssc_tx_ln_vals},
+
+	/* Dual refclk */
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), NULL},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_156_25_no_ssc_tx_ln_vals},
 };
 
 static struct cdns_torrent_vals_entry cdns_rx_ln_vals_entries[] = {
@@ -4419,6 +4599,11 @@ static struct cdns_torrent_vals_entry cdns_rx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_DP, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
 
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_156_25_MHZ, TYPE_USXGMII, TYPE_NONE, NO_SSC), &usxgmii_156_25_no_ssc_rx_ln_vals},
+
+	/* Dual refclk */
+	{CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_156_25_MHZ, TYPE_PCIE, TYPE_USXGMII, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
+
+	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_PCIE, NO_SSC), &ml_usxgmii_156_25_no_ssc_rx_ln_vals},
 };
 
 static const struct cdns_torrent_data cdns_map_torrent = {
@@ -4452,6 +4637,7 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 
 static struct cdns_torrent_vals_entry j721e_phy_pma_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &ti_usxgmii_phy_pma_cmn_vals},
+	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &ti_usxgmii_phy_pma_cmn_vals},
 };
 
 static struct cdns_torrent_vals_entry ti_tx_ln_vals_entries[] = {
@@ -4519,6 +4705,11 @@ static struct cdns_torrent_vals_entry ti_tx_ln_vals_entries[] = {
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


