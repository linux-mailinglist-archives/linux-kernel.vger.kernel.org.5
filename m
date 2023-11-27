Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D2B7F9AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjK0H0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0H0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:26:38 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586A912F;
        Sun, 26 Nov 2023 23:26:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dqf3mEvmpF7pa+Ja8DT2nXPnIIIsUC4LLRUMy+dYJ6d9iD8VIahflabFJI7A7aDc1Z/uqIvQ6sLjCJPYIRowgGAREFijT6Sqe8olcE92gFpIwpi/xe5FYusHE2oV1yATHGjuwWrnRST/+uixSDiAKRcwgR/LbfkGAImYKekYe6AcTeWGnqxOapSAKI+zGkkw8bi3lG/N63ifYue+K4zEYslxhg7Dth7+ImQrQBDZ7F2v3OGqAVOynqniuAea4dufYgxVMFv4PtchupJCIlA1mKVgmijcDKcldQTm76tcpysNTT/QCV8t0jF1rW4SM6pJbnk9qox/MPSwqb25Qf4ZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76SLADWkTS3QXMmnUjlMjEpbBQAbk2qEx9d8SojKME4=;
 b=MTbmEYW9l+fZteoMB/HUguA8avXFZtGLNosEgX73LrzL7ycB1U06lE6UDJ5nbh1ITvo/ToCmerfJ7K3jN3AuvsIWFLcH+L18yNgrzDiH60eEknFii/YQzPvMqNmU8WWBI8zG3hRBPLNkfiISLPvJDFDWl+DoLle7mw2Jetfl7kgAAIe9cogytmkJuquyMKvhcRDihxBccQ3Td7XTMPSCaQoaWEFxw4YK8fo3kKSkQN+7ouUH8gNqe4Hk8pnM2Ajs7Zew/CewN10/19CeWbbd8U3xQ93mct99V2LLQtSoZFHBiau5eN91FZJP7nP0JIUuCFl4qarboD4EBm8KCyHLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76SLADWkTS3QXMmnUjlMjEpbBQAbk2qEx9d8SojKME4=;
 b=H3fBnwUQkXaGJRWoGWgECJMJM+pw9P7ITxdV+Br/phWkFUSOhloF6DuvxvVAscm0WVlp+00+yLD6kcMv7wUuwPRrmTuFak096enFqZcvLzHihVf1l6M+107U9hsWkj8zQBDdb8P9nkNTqEeE8oTLCjmwJ55kJG4ik8Oavires1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by DUZPR04MB9871.eurprd04.prod.outlook.com (2603:10a6:10:4b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Mon, 27 Nov
 2023 07:26:40 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30%7]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 07:26:40 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     Frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, irogers@google.com,
        namhyung@kernel.org, acme@kernel.org, john.g.garry@oracle.com
Cc:     james.clark@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf: imx_perf: add support for i.MX95 platform
Date:   Mon, 27 Nov 2023 15:32:07 +0800
Message-Id: <20231127073208.1055466-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127073208.1055466-1-xu.yang_2@nxp.com>
References: <20231127073208.1055466-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DB7PR04MB5146.eurprd04.prod.outlook.com
 (2603:10a6:10:23::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5146:EE_|DUZPR04MB9871:EE_
X-MS-Office365-Filtering-Correlation-Id: fea5c770-59b8-4051-c919-08dbef1a32c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b8JTRCrpB7DyOJ9r9hT9bGiNATw0Yg/D3ymgXxzsO8IgM8rt5e5883KJm4VbuIzJfCa62PZ7EQrQ3uUlcsK7PUSM6SYpl6+NNh+XoXOMhicipCJK7FyzAaVEfLv1ejd5LiIfPlpQ5qOr9FEZWpAdeempE1MJ3TEcxKmTKpf8Zl68WUQybYnhfaeZzw70glB9DjDtPr0QHCPmPIf00fLgVBegZ7wh5J1st6aPiQKBqfnVR/myeK/vdFE4I+vWghHWB25Tp+xlNyxH/qCZsQVgbPvyHR6H2HpUlYL+Ls6re61N5fQmFNKLpHNICneMFcvcYEqTOFBNcF6mxkSTgut8tJmAj0Vcm2UbOxHT0d1uETdwsXU/DCOSmdwqIH+B6ahVlwcR/yGTulD1wEA9Ro/wKFEv7fhrFY3WRdmTtazI5+wZz4iFz7Ef7Io5tI/wdHxFH7I1j86Nef+Xk7YV/WJTIWphSh+KO+dNGHGKcKSfWeGMjcAAujR4Ztm6Y2NtKXWk1sV9IR8W4en+cXKA4U83QgUQknPOeTVO4foA7cBQhZfKDPebttYOpSLq4/sNm+V6yLHn9G5TkKJaNcqfVbPxU9C5VFAJThdslZiFYCTYRmpr0XtfOsdCDVvOHUzLYFWI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(1076003)(6486002)(2616005)(6506007)(6666004)(52116002)(478600001)(6512007)(38100700002)(921008)(38350700005)(36756003)(86362001)(5660300002)(41300700001)(2906002)(7416002)(66946007)(83380400001)(30864003)(66556008)(66476007)(316002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KlIFib8NZNPlTZXMKviYQ9lusyBN171RTSmB4jSQphkT5CWAbg7h9AyZCjgr?=
 =?us-ascii?Q?+YJg+R8cWB4O7MWGc7HT6D0UfmQAaJ1kioQcBvX/iLEcdDmlG8AKcHMc8WaN?=
 =?us-ascii?Q?ltddTFSf3VsMDyU20QLZLVPNH0x0hdl9c1FXVGsvdgmzqeNRvJ+DHN1K63Ek?=
 =?us-ascii?Q?pD4De7o9/9CKxl2wYSYNFaPDOiw9Beog6XUZFFJoMmkwYVEp5V62NJRR/jnx?=
 =?us-ascii?Q?v07lAaIoSZI0mkDhoNK9x4cBtBkOeUrYYBMRvAcB5Xt9lUn2c+USBOazYWNh?=
 =?us-ascii?Q?OMqvNmDbm56SfEXSa3lcG5GKVQcj6nzUgpD6jL6Lj3qHj45zw9PZRSWo9eMM?=
 =?us-ascii?Q?BJVQ4zNxdc4v/mxgL4qWO8BUI1ysZAGexD7t107txuZfeOjg/VvXm6n7h7Jz?=
 =?us-ascii?Q?j9GlGbRvRgpHD5X1oxN+NIfH2j3dhuxLxA7v6+4UT9M/QOi9hUbz7xfGu1a9?=
 =?us-ascii?Q?54t5oiNARuVUhHV8ew8tno+SX3Lemx9vU1Ui1LFvwkHIfoF3/ijddK03xD6x?=
 =?us-ascii?Q?M0i5DOrgH7iU2P8tRpFDf/NdfoRCNis5l7073d+YHzwrg97iKEifw7IQHceR?=
 =?us-ascii?Q?+gpMZpRW3RaB5uLyXE8DjKDtww6v9ZFxUihO5epXahfcUtzbk292509lzUlo?=
 =?us-ascii?Q?yzcS3sob8xm5PS7Grvavm0foAtVquBPfgNLqCFkkB5HyVpCQaU5wEQNllZty?=
 =?us-ascii?Q?8MXIQqg1/46Z4BvrnGyqGMNbCCmF4FiHl2mlqwkGIc76N8oWzbFA5LJHwtio?=
 =?us-ascii?Q?mqqXiqLPj/PagtRyJPS4zBblk11smGZ4X6hE6R8f37pidrwV3OdaUJKVao70?=
 =?us-ascii?Q?pNC2ed33G2HR9vFpiArcuC6dbjuSF2GFe12M9LfE8Z+d1KZp/N4fYwVNb9UZ?=
 =?us-ascii?Q?I7V2+yi8+tqdMQEioIwO900WgDsUvBtTYiO4jMNBquTCqfW6uPA2Vgevrz9X?=
 =?us-ascii?Q?avv8iPGrF8aCubS1+aKM9dklQYJqx7pqXmYR8SYAglh2mIlXc5tsZMEGi90N?=
 =?us-ascii?Q?w1sZQmEneXTN5fmgZA+vptYVFiA+7NtRrB58w7TuyKY2ZpDsq7RKQB//u/Cm?=
 =?us-ascii?Q?SLApNtTX4hNiirfUWG54/bd/0+96jsA/tvVc+Ws4v1W1cKBI6sr7NFoaQ4wd?=
 =?us-ascii?Q?QBefrX+MzmE/1klCpQDmaMu1I6jVnCgxUu8taSft4+ItpqHBWml/QQ9cuYA4?=
 =?us-ascii?Q?NLMzuiT6Zgf92dDFOxeJDDrCctXm2jKOq2KfTpM3bBj4JoBDgcazgCE5WAy3?=
 =?us-ascii?Q?wG42jhKJptt0pt+bdmORQXwaP8sR13g4fK/Yj2hKHuBuWgf5j80oXO8Lq9oK?=
 =?us-ascii?Q?+zwmFQTD7VEDzSDOl7EhkPpLi/R9xJDwIcwOBOjWP+XfrvlYiA01scMNFSPF?=
 =?us-ascii?Q?1m/S2BZHqGGRctyOiQf9cplxIbbAyOVPzCJmo2EK5PPEQk27QWb8t0W872j6?=
 =?us-ascii?Q?8tI/G4uaiy6vsC4oNv1k5bBEL6H6NM3UDm5Npon72wUbfP5rl/YBOv9YLK/m?=
 =?us-ascii?Q?0GpoYkhuNbkrtEtc4xhozhzRT+4yhifqiD+OUeyvxrbo1y1z8HU3wsRYY342?=
 =?us-ascii?Q?7KoFOxdjATmQ00nJKDwfrBkb/5lacb2+VDhh2Cit?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea5c770-59b8-4051-c919-08dbef1a32c0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 07:26:40.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Uic+w5xftM1dvF8FlL0JAqPy3zRYFAiNmd3d6OaoCAe7jE8I4o1/40e2d0QVlH/jKFEgv3mPBZguo9+3+O83Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9871
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
read beat and write beat filter capabilities. This will add support for
i.MX95 and enhance the driver to support specific filter handling for it.

Usage:

For read beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,counter=3,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,counter=4,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=5,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=5,axi_mask=0x00f,axi_id=0x00c/

For write beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=2,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=2,axi_mask=0x00f,axi_id=0x00c/

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/perf/fsl_imx9_ddr_perf.c | 187 +++++++++++++++++++++++++++----
 1 file changed, 164 insertions(+), 23 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 5cf770a1bc31..5e531d94cf3b 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -11,14 +11,24 @@
 #include <linux/perf_event.h>
 
 /* Performance monitor configuration */
-#define PMCFG1  			0x00
-#define PMCFG1_RD_TRANS_FILT_EN 	BIT(31)
-#define PMCFG1_WR_TRANS_FILT_EN 	BIT(30)
-#define PMCFG1_RD_BT_FILT_EN 		BIT(29)
-#define PMCFG1_ID_MASK  		GENMASK(17, 0)
+#define PMCFG1				0x00
+#define MX93_PMCFG1_RD_TRANS_FILT_EN	BIT(31)
+#define MX93_PMCFG1_WR_TRANS_FILT_EN	BIT(30)
+#define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
+#define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
 
-#define PMCFG2  			0x04
-#define PMCFG2_ID			GENMASK(17, 0)
+#define MX95_PMCFG1_WR_BEAT_FILT_EN	BIT(31)
+#define MX95_PMCFG1_RD_BEAT_FILT_EN	BIT(30)
+
+#define PMCFG2				0x04
+#define MX93_PMCFG2_ID			GENMASK(17, 0)
+
+#define PMCFG3				0x08
+#define PMCFG4				0x0C
+#define PMCFG5				0x10
+#define PMCFG6				0x14
+#define MX95_PMCFG_ID_MASK		GENMASK(9, 0)
+#define MX95_PMCFG_ID			GENMASK(25, 16)
 
 /* Global control register affects all counters and takes priority over local control registers */
 #define PMGC0		0x40
@@ -71,12 +81,22 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
 	.identifier = "imx93",
 };
 
+static const struct imx_ddr_devtype_data imx95_devtype_data = {
+	.identifier = "imx95",
+};
+
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
 	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
+	{.compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
 
+static inline bool is_imx93(struct ddr_pmu *pmu)
+{
+	return pmu->devtype_data == &imx93_devtype_data;
+}
+
 static ssize_t ddr_perf_identifier_show(struct device *dev,
 					struct device_attribute *attr,
 					char *page)
@@ -178,7 +198,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
@@ -190,7 +209,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
@@ -202,7 +220,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
@@ -242,6 +259,26 @@ static const struct attribute_group ddr_perf_events_attr_group = {
 	.attrs = ddr_perf_events_attrs,
 };
 
+static struct attribute *imx93_ddr_perf_events_attrs[] = {
+	/* counter2 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
+	/* counter3 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
+	/* counter4 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
+};
+
+static struct attribute *imx95_ddr_perf_events_attrs[] = {
+	/* counter2 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, 73),
+	/* counter3 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, 73),
+	/* counter4 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, 73),
+	/* counter5 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, 73),
+};
+
 PMU_FORMAT_ATTR(event, "config:0-7");
 PMU_FORMAT_ATTR(counter, "config:8-15");
 PMU_FORMAT_ATTR(axi_id, "config1:0-17");
@@ -361,7 +398,7 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 	}
 }
 
-static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
+static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
 {
 	u32 pmcfg1, pmcfg2;
 	int event, counter;
@@ -372,30 +409,80 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
 	if (counter == 2 && event == 73)
-		pmcfg1 |= PMCFG1_RD_TRANS_FILT_EN;
+		pmcfg1 |= MX93_PMCFG1_RD_TRANS_FILT_EN;
 	else if (counter == 2 && event != 73)
-		pmcfg1 &= ~PMCFG1_RD_TRANS_FILT_EN;
+		pmcfg1 &= ~MX93_PMCFG1_RD_TRANS_FILT_EN;
 
 	if (counter == 3 && event == 73)
-		pmcfg1 |= PMCFG1_WR_TRANS_FILT_EN;
+		pmcfg1 |= MX93_PMCFG1_WR_TRANS_FILT_EN;
 	else if (counter == 3 && event != 73)
-		pmcfg1 &= ~PMCFG1_WR_TRANS_FILT_EN;
+		pmcfg1 &= ~MX93_PMCFG1_WR_TRANS_FILT_EN;
 
 	if (counter == 4 && event == 73)
-		pmcfg1 |= PMCFG1_RD_BT_FILT_EN;
+		pmcfg1 |= MX93_PMCFG1_RD_BT_FILT_EN;
 	else if (counter == 4 && event != 73)
-		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
+		pmcfg1 &= ~MX93_PMCFG1_RD_BT_FILT_EN;
 
-	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
-	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, cfg2);
+	pmcfg1 &= ~FIELD_PREP(MX93_PMCFG1_ID_MASK, 0x3FFFF);
+	pmcfg1 |= FIELD_PREP(MX93_PMCFG1_ID_MASK, cfg2);
 	writel(pmcfg1, pmu->base + PMCFG1);
 
 	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
-	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
-	pmcfg2 |= FIELD_PREP(PMCFG2_ID, cfg1);
+	pmcfg2 &= ~FIELD_PREP(MX93_PMCFG2_ID, 0x3FFFF);
+	pmcfg2 |= FIELD_PREP(MX93_PMCFG2_ID, cfg1);
 	writel(pmcfg2, pmu->base + PMCFG2);
 }
 
+static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
+{
+	u32 pmcfg1, pmcfg, offset = 0;
+	int event, counter;
+
+	event = cfg & 0x000000FF;
+	counter = (cfg & 0x0000FF00) >> 8;
+
+	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
+
+	if (counter == 2 && event == 73) {
+		pmcfg1 |= MX95_PMCFG1_WR_BEAT_FILT_EN;
+		offset = PMCFG3;
+	} else if (counter == 2 && event != 73) {
+		pmcfg1 &= ~MX95_PMCFG1_WR_BEAT_FILT_EN;
+	}
+
+	if (counter == 3 && event == 73) {
+		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+		offset = PMCFG4;
+	} else if (counter == 3 && event != 73) {
+		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
+	}
+
+	if (counter == 4 && event == 73) {
+		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+		offset = PMCFG5;
+	} else if (counter == 4 && event != 73) {
+		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
+	}
+
+	if (counter == 5 && event == 73) {
+		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+		offset = PMCFG6;
+	} else if (counter == 5 && event != 73) {
+		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
+	}
+
+	writel(pmcfg1, pmu->base + PMCFG1);
+
+	if (offset) {
+		pmcfg = readl_relaxed(pmu->base + offset);
+		pmcfg &= ~FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF);
+		pmcfg |= FIELD_PREP(MX95_PMCFG_ID_MASK, cfg2);
+		pmcfg &= ~FIELD_PREP(MX95_PMCFG_ID, 0x3FF);
+		pmcfg |= FIELD_PREP(MX95_PMCFG_ID, cfg1);
+		writel(pmcfg, pmu->base + offset);
+	}
+}
+
 static void ddr_perf_event_update(struct perf_event *event)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
@@ -479,8 +566,13 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	if (flags & PERF_EF_START)
 		ddr_perf_event_start(event, flags);
 
-	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+	if (is_imx93(pmu)) {
+		/* read trans, write trans, read beat */
+		imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+	} else {
+		/* write beat, read beat2, read beat1, read beat */
+		imx95_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+	}
 
 	return 0;
 }
@@ -596,6 +688,49 @@ static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+static int ddr_perf_add_events(struct ddr_pmu *pmu)
+{
+	int i, ret, events;
+	struct attribute **attrs;
+	struct device *pmu_dev = pmu->pmu.dev;
+
+	if (is_imx93(pmu)) {
+		events = sizeof(imx93_ddr_perf_events_attrs)/sizeof(struct attribute *);
+		attrs = imx93_ddr_perf_events_attrs;
+	} else {
+		events = sizeof(imx95_ddr_perf_events_attrs)/sizeof(struct attribute *);
+		attrs = imx95_ddr_perf_events_attrs;
+	}
+
+	for (i = 0; i < events; i++) {
+		ret = sysfs_add_file_to_group(&pmu_dev->kobj, attrs[i], "events");
+		if (ret) {
+			dev_warn(pmu->dev, "i.MX9 DDR Perf add events failed (%d)\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void ddr_perf_remove_events(struct ddr_pmu *pmu)
+{
+	int i, events;
+	struct attribute **attrs;
+	struct device *pmu_dev = pmu->pmu.dev;
+
+	if (is_imx93(pmu)) {
+		events = sizeof(imx93_ddr_perf_events_attrs)/sizeof(struct attribute *);
+		attrs = imx93_ddr_perf_events_attrs;
+	} else {
+		events = sizeof(imx95_ddr_perf_events_attrs)/sizeof(struct attribute *);
+		attrs = imx95_ddr_perf_events_attrs;
+	}
+
+	for (i = 0; i < events; i++)
+		sysfs_remove_file_from_group(&pmu_dev->kobj, attrs[i], "events");
+}
+
 static int ddr_perf_probe(struct platform_device *pdev)
 {
 	struct ddr_pmu *pmu;
@@ -666,6 +801,10 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	if (ret)
 		goto ddr_perf_err;
 
+	ret = ddr_perf_add_events(pmu);
+	if (ret)
+		dev_warn(&pdev->dev, "i.MX9 DDR Perf filter events are missing\n");
+
 	return 0;
 
 ddr_perf_err:
@@ -683,6 +822,8 @@ static int ddr_perf_remove(struct platform_device *pdev)
 {
 	struct ddr_pmu *pmu = platform_get_drvdata(pdev);
 
+	ddr_perf_remove_events(pmu);
+
 	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
 	cpuhp_remove_multi_state(pmu->cpuhp_state);
 
-- 
2.34.1

