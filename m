Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063D57D0A45
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbjJTIJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbjJTIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:09:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E92118F;
        Fri, 20 Oct 2023 01:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9kEuwVwPI/ILynqjT/XUKLdTq3INc3SfPtXPN6vflB8xbzvCTxJ/XIAih1rPFJkF5WGM3rV3NJPeb9+fq+1e+ml67QZskSW5/Rmyw2ZQd9OQqrUugpLoqTdR2wjpYJnZlwe/4GMUivpVd1+LLYQRQFZeUpAZImmx8oTXBgTjlDBBjqpggLG4OWAhdwKIKUxmTmCOYl1laIHWJWhImo1nQdA+8v74xBK5doorjJsQEtxTnldQLrZVplgLA5Pw3WIRFcRHQnQ5Eshd/Xjf+UJlEl2B27f6utmhM8fN5sLRDpiw3GPiYXExonqvWuc03xRKfcfGEC/DfQNYbL5MF3VHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8seKGxRjDiE4b+l1Latozxzp+3IhrF1f8+q3TByBFIQ=;
 b=AH+89Slm+8LVffnovFWed6Reyls1ZTlcTiAlhn6n6lDP19eeHHV6eUamxZW297/qqejgJabJoc+GiE/oF7VSnTtknl5HVE/gaIxpgzfxJvGHdXObkKJrOJ8xBG35bvQZtXRjB1xazZSyy7y2ocIROn5HOgyimLvn/N7WSp1ZWmMQCfWwHI8Gfo33w5BZe5A+yg6mOZP+Gze7XEHa8onkHTBrptUfRtz7JIllBR0EpAw0vBtFSGPnStGJFdi2BMaT4RmF//dFXoqfmUXXqZN/pDobcgtXj5P168cdEag8D7Oi1psQo1q6zARcMA07LcKXSucXHMiUwcUKVmnUI0qN0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8seKGxRjDiE4b+l1Latozxzp+3IhrF1f8+q3TByBFIQ=;
 b=F+SG6wC+HV2AC1CxlTUoYms680skYyUp0n+SNi2eotVBsUbWlCQYLNwoD5aH71Hz+0tdW9uukuBKR/K0hXsV8EEMMLiMDI/2d6l1ZmolErLIGPBX4flgz1LYL4aKO/3sDSVuy5G0Gaf97Kylb/EHOE+EBJ3dJaVmqmadb6J7f+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7678.eurprd04.prod.outlook.com (2603:10a6:102:ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.9; Fri, 20 Oct
 2023 08:09:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b9ee:e067:5935:4965]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b9ee:e067:5935:4965%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 08:09:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] thermal/drivers/qoriq: fix getting tmu range
Date:   Fri, 20 Oct 2023 16:13:37 +0800
Message-Id: <20231020081337.3141488-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: b50d1137-1a17-48e1-4a23-08dbd143d44e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0ML1UHsaG6uWwrrenpUyWJbe0dbExr+tpiitP/Pt28FqjnAXVkguWLIiQGn18yWrOHvF/qk3VIBIV6VVs5TGRYGMErNh/MDiekVtRnIZ/ibpYKdZseKbAXZENXAUfAd2w2yuvWbtEisF1S2Hnmnrc6zztIHBnBBaoMO0cOXYDaLvZKEcqyB6ZG0TvrdLkSeQMSsOSA1BWoPmAXL0K4gge/4HZ81MQUY/jJtZyE4Wsl1M2bDwW5DDA3bqmTMtlXu3i9xnlHGrjmxSci2MQooMuHKQtrIMPwKvAA4CHmfWiIDI94Tvq26cPr0zXViZKKqAszpJjIKhN7OjmUGdKQoKhxiNFmf85KvYSSfiDZbH9C42WyoakiaUwW4k/0ZzyF69OGYitPan5xZ/KCYVduk2/JEsZNJAUVgNim4V6J63j3C3UAOBAs64yKk4KPeErUsUGqoUEGrzoUAUzeysUrs1rq89KV8CMtTiY621awF1aUsulNxFL1g1GMw2TU5+XDj3p+/lgEH7Tvsb2rYRIeAD5amLk4AED/xgsGK7RxWy9EmCyO8xgO0QYeJZQTDLfQlz6GKMDLMj4rTigjKi6wJhz96xzR8AT1OQGt6yKOJXQ1f4r0amsQzKo9oOjEMGdfb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(86362001)(4326008)(38100700002)(316002)(66946007)(66476007)(478600001)(6666004)(8676002)(66556008)(8936002)(6486002)(41300700001)(2906002)(6506007)(2616005)(5660300002)(26005)(52116002)(1076003)(6512007)(83380400001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rvtxESq5RKIE1Z60Y3LrLQxJLpOxGpbcmiPspRTehbS3opQwUhVSld2DRVbN?=
 =?us-ascii?Q?9XKuJDPAiwDK89z4WSJCmOmUXruHv8uvNWEQ8A2qXiEEPogGkNySRrnd5pSa?=
 =?us-ascii?Q?oxDESTi1CoI2DZ/ycVx9LDcPBklLocH2czW1hHLKywVPCds0AjVrR78lZTG2?=
 =?us-ascii?Q?U0Ta4X6wtLz2w8aZu8A7mvTU0Gp66H694gLn8X6ne3yky6TD/3lvSlb02rh4?=
 =?us-ascii?Q?iW5cp1GOSDJNLHv+3jTmvVQMGxqItFlNkZ/rnGz5fATS2PBfsNXWCInm65YX?=
 =?us-ascii?Q?dPBYevbS7ExyOD9YIxXtYyhwOj5JAgkZMo0XpIkkPmdkmVcRtwMT7Cj8lWg1?=
 =?us-ascii?Q?kTqXD2hbcHDTVa1j6EzPlcWUXAmW7+3mJzE0GpH8+XHFj5NBDlaj0q8QSTBD?=
 =?us-ascii?Q?HblSBC2X/r+4UNPgNW28hD2OEajEwP2uQM6z5Ou3KYnfEkfuJmiWC52Ijt0T?=
 =?us-ascii?Q?MTylYSsNXg7Sc/w2frnjaMVRWf5LHEBdtEcTT5pxeK+oQH+czKski8wrc/9q?=
 =?us-ascii?Q?sbO4SCX/hYSixKUEVhFRUjvccLP6mvXD+DfmJ4NoQVRo12d1mYWzsR9+71bI?=
 =?us-ascii?Q?Gmo/bhAA7GoA8MVe1sghTo5rrAF9Eb+CauBTiPwmHeawBwq1dTRHMi+PrhQX?=
 =?us-ascii?Q?RFaHllMcUQGhMpkCC6pN0y3MW1VKRvcA/BZW5qQCmrAz5fqqgW3HXjwFqgvG?=
 =?us-ascii?Q?kqE0etXytUhCrwZ/uBPuPfDB1HCGXh9kQMHo62v8Iz5UpV+crTAv0GtwW4Pc?=
 =?us-ascii?Q?8TW/2U4mL1USnC7pnJsc9SH6f7DSdm8nt/IUkp4wlyqrursfV2gZSPLM0mc2?=
 =?us-ascii?Q?jLsxDo/MONCr2Zrw/4bucOulzWBAVK7EXRH1kF2Mau2hJEnEW1EEWZuQdboD?=
 =?us-ascii?Q?rzy16oJDeFJnrffvQTmXw2mLtdhHZlnfLY4KhoS1SFT8ew0JlF+gC890nxNR?=
 =?us-ascii?Q?0vppf67qDGwXethqwCRwKCweVhFjNTiUIt/LYznz3xP+0kpXQS+QMyfH9hvS?=
 =?us-ascii?Q?474Xd+7ZWwT1pvL3cmq52v6p3OX0L7RgHiv5QVZUX8hoNNQs4R8Yr0XOBdgL?=
 =?us-ascii?Q?+5TkF3pehev1rMBvmiyIIT2aXACoDYbDE+MDlhADARWf44g1MjXYbEMrnyVb?=
 =?us-ascii?Q?wzuEP8HvW4BUgj+lvlExPBfKqO922w2J21bByctJdNzHPtfkWeryQFUz6j3h?=
 =?us-ascii?Q?3p+rvj0OhEx/bHuK6mwSD8LjUiflMs6pFcAjcRjbT1XKapPJfTUeKEf7b6IJ?=
 =?us-ascii?Q?v6sOHfgFQyqmdme2zyajm8hLGUdQrHX+V5m0D9ao+0NtkDnJtQHj9U4ZGOTZ?=
 =?us-ascii?Q?fax7/UFpxMKoFYUDeo0U8SMSJeWk8d7bR/ioMiOxXfgn7bprrlLQFyIWHwSw?=
 =?us-ascii?Q?al3DVNHkE4sBC1nxUCkO7UU57OP5+xyp7Lh0/ODhUijVRUpnvkUt8q889DxN?=
 =?us-ascii?Q?Q8qc7bPDUUqib8MBVVCCea38YZZS/FGV6FXo/3zrD0qGeu1ipJLbB3BRZRKu?=
 =?us-ascii?Q?o7XOubvAntPha1bNqPy4ZRBNzK+iecBUxcjEZFCm/9ZkYJFEgQt14RTbBytN?=
 =?us-ascii?Q?+tNlTeOgEkPAr5yttvdGAseubfYkjutYBiq8ThQ4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50d1137-1a17-48e1-4a23-08dbd143d44e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 08:09:06.1556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8GcMLkqpXNnLYccR3AP96AjX6iNrLtSXJRwyngrbspG+MOn62VZgqzrKhDcj/PIt23+3mpe/HZRU/oApPPypg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7678
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

TMU Version 1 has 4 TTRCRs, while TMU Version >=2 has 16 TTRCRs.
So limit the len to 4 will report "invalid range data" for i.MX93.

This patch drop the local array with allocated ttrcr array and
able to support larger tmu ranges.

Fixes: f12d60c81fce ("thermal/drivers/qoriq: Support version 2.1")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index ccc2eea7f9f5..404f01cca4da 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -57,6 +57,9 @@
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
+#define NUM_TTRCR_V1	4
+#define NUM_TTRCR_MAX	16
+
 #define REGS_IPBRR(n)		(0xbf8 + 4 * (n)) /* IP Block Revision
 						   * Register n
 						   */
@@ -71,6 +74,7 @@ struct qoriq_sensor {
 
 struct qoriq_tmu_data {
 	int ver;
+	u32 ttrcr[NUM_TTRCR_MAX];
 	struct regmap *regmap;
 	struct clk *clk;
 	struct qoriq_sensor	sensor[SITES_MAX];
@@ -182,17 +186,17 @@ static int qoriq_tmu_calibration(struct device *dev,
 				 struct qoriq_tmu_data *data)
 {
 	int i, val, len;
-	u32 range[4];
 	const u32 *calibration;
 	struct device_node *np = dev->of_node;
 
 	len = of_property_count_u32_elems(np, "fsl,tmu-range");
-	if (len < 0 || len > 4) {
+	if (len < 0 || (data->ver == TMU_VER1 && len > NUM_TTRCR_V1) ||
+	    (data->ver > TMU_VER1 && len > NUM_TTRCR_MAX)) {
 		dev_err(dev, "invalid range data.\n");
 		return len;
 	}
 
-	val = of_property_read_u32_array(np, "fsl,tmu-range", range, len);
+	val = of_property_read_u32_array(np, "fsl,tmu-range", data->ttrcr, len);
 	if (val != 0) {
 		dev_err(dev, "failed to read range data.\n");
 		return val;
@@ -200,7 +204,7 @@ static int qoriq_tmu_calibration(struct device *dev,
 
 	/* Init temperature range registers */
 	for (i = 0; i < len; i++)
-		regmap_write(data->regmap, REGS_TTRnCR(i), range[i]);
+		regmap_write(data->regmap, REGS_TTRnCR(i), data->ttrcr[i]);
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
-- 
2.37.1

