Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBF67F9AED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjK0H05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjK0H0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:26:48 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38778181;
        Sun, 26 Nov 2023 23:26:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbGbtl2k77oTErqwyHkg0SC9BbigBXoP9/4XBLshwORa5HPc8vaBDPhkpmP/IQ8VlntgjA7ieNEQkvkM2gAz0NM5PPAtqH1CbpyzWJrMo4FFbeHF3v2fStNTyjfZAP47Bl3HKx4h3A7whih4osCB7wjK3Z8qmG2IlbhYSZJTioQOywnq2M/RkzuujiwxNY+WLqusUR1oKWek9KnnKrqJeyAWo60V9Pqd4mKKQOViixfnHSH1OmCUFz/F1+N8AXkSSYXgJQDYvzLiX0OBCnJCCaQlbciOMkq233gdSojW3iljkw6NH17lSeFYC4jsUirJqRulP09cQgucW4JWGZa9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DCcuACRDJy/z6xvIb6cPWtnOx4kGM9md0rIYBVF9T0=;
 b=W9oIUV5G2WJWfdBFu+iPL0y90Hl+6rFg7iCoGF028n8s//4/fr+5Ln1weIGDmvtF1e268tVHEQDeLQ9L80Rotdq4LSiSu9wukd+XCacvzZAPXpP97H4wqj47HngYFWTjhj1indrkloJQL1sLy1rncvlPnYjVlcPyLUBPkQ01N5gmdgksI/AVfEq2Mp8+NMUQL084mxf60Q/NieeVbN2b3Tw3tfUCcSXW5LbaCRYYlZ/TJuMY4FSn6KHyHakPksfAANXNU/7T6ydglYZ2qWXaQJmf7FpTV/IDm6llDoTvmnbp7nQCBu8vUxGjrhcsnUbzhy4z6MDEhMLmhIvgSB9/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DCcuACRDJy/z6xvIb6cPWtnOx4kGM9md0rIYBVF9T0=;
 b=izReq1iuW3GInuobZP6KKtK7DMJm5tUdM5hCSe3i41BKCsqoDFu4s46xUVRrC8id7Gx2y8wPMvTDAQ//e0+enAPp07tuQjkNeEypun10wSLG5T0upvpXul8gC+VuPxaRWcnxoOysp/ayz2wLZm295uirSuv0THFXp6nInkl7MTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by PAXPR04MB8157.eurprd04.prod.outlook.com (2603:10a6:102:1cf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Mon, 27 Nov
 2023 07:26:47 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30%7]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 07:26:47 +0000
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
Subject: [PATCH 3/3] perf vendor events arm64:: Add i.MX95 DDR Performane Monitor metrics
Date:   Mon, 27 Nov 2023 15:32:08 +0800
Message-Id: <20231127073208.1055466-3-xu.yang_2@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DB7PR04MB5146:EE_|PAXPR04MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: b942efba-4295-4551-49be-08dbef1a36d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kh/MpAJs27wVCHC9qnyX1IjkiD0tzHcmr6sg6M14xSYwCCoTV37LjNQ0G4vB8dyOtUksfVSSllb2y/yZKIk8HX/NYNBCHehZ+RlTR/rrxyhKyfpsoBWmWu8MQSeu54S7jwyaInekuHvIMP6hwKf0/imFZJlQtQC3Dbpu5MaIXCYK5MzDGKHi1OXEuFLvVgaTG3vTNqvy+gw9P8XKprWz8N7tmWtI2Z/Cs/8CbPyt2K+NVYKuo0ZkyYgDOtJ2qrAYxcSYRqgk1OWGyAFiHyMuBQFp+GQfeRSNmgvxyZcsSCf+GgsmVWtfNBuikKZf46gxsR5lDp+4Y6t59QfjWuPx8m47FAfkw1VacN0sKThgtkMj8hnbNOuDCYMGtauEf88qn+dVo3ct4SHD7s2EirUE2v5TlctBxGUBd5daPFT3/lyUDNYRdKssd7+P1HlWS1wG81wXRuVWn+cihZ5Gv446khB4+HVt2WX/6ZY5zIVuEOY4qKUCNQ3HLAFa0or/36/u/KKR9Gy99fjB+jK1b5usF3dY7BRPDeLdU9PjoQy8AvDGLfzTSbOpkkGapCyEHeZU424engIaEAZxUQhvYsWtwp3puY4QwjpyEVw8rF7ShLNn1u0hPSDZHokF14uwl+Cn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(6506007)(1076003)(2616005)(6486002)(478600001)(52116002)(6666004)(30864003)(2906002)(7416002)(41300700001)(5660300002)(66946007)(66476007)(66556008)(316002)(8676002)(8936002)(4326008)(36756003)(38100700002)(38350700005)(921008)(86362001)(26005)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w/GwYUwnH+USudc0hYb+Z4LWaxjTp4MipRqwnVL3V64eqtNLHrrKQW4VU62a?=
 =?us-ascii?Q?6OyuKxdx43OlZig22IAOCXq1vAHCj9BJSDxm0KlZ0T2cGn8u+Duyzzcfc0iK?=
 =?us-ascii?Q?jh/CPhgXOANYs79B8isLIjLuGCmOmHUC9Gd3M8OnYyGV8vk4S3LqfX4CTPMU?=
 =?us-ascii?Q?tCYOum0hX3iHQyJfSjNFf4UQVIXTxcjZzvBNJg5anb/mwIVrxUheFs2jPT4i?=
 =?us-ascii?Q?Un4I3Lll7x4TcdNFqeRGWQ2BlnUqCYPeG6BGtwbQvi2TgpKBCLftF6DrGZtX?=
 =?us-ascii?Q?pwlbkF5k9hzJ5FURbiQWDHQK09xKHWVu9xB2QxVURVbb5aO6e8OhSS/H1T7q?=
 =?us-ascii?Q?Uh3amd3MbKPMgfzU5KyvwZ1YT1QnfkOZN6jkIAnc2unoLMbIR5Xdo9a1Ss+g?=
 =?us-ascii?Q?ELVXzdIe00os8IAYR4d1ccYYnbO8BJltZRTJL2ucpPtUMt2jslsRFv9kRBzF?=
 =?us-ascii?Q?xNZeDbtTkijEck84RNlhydko3W+4g8f1zwgZCmamO5jxjiwnvXysZWWJfn+A?=
 =?us-ascii?Q?4X7GJYeG3v0CZjTh0gDvOrADmyujZWZGAju+aCVPTU38AokXR+Bqt5srmpH5?=
 =?us-ascii?Q?4aTf486pzEwb6TjVNdkm98cWWoaI7LLW5jaBZa/KJt9ilbv5ZTAr2GuqYoR6?=
 =?us-ascii?Q?icsIiwzD5jSHUWUTwHDyPBw4CvCzkuP/KqaGm9amC1I1WziEqNTF+fRdKV5u?=
 =?us-ascii?Q?+noxoLzkosMpvUA0OAgrKf0Kvcujh4SBhaicLHi+nahk1/1T2bgE4vpHj1Z/?=
 =?us-ascii?Q?gJbrwMseDTF0BYLiJt/2Gp3QgEHEdATsvY6fDPKNzaQc7pckMCxWw0k/XvB2?=
 =?us-ascii?Q?KdJ+kJ37QpadSNzcgkzxw4p2IwDliqK5Vyr/KjgoJUxJANfewIUk2vPEISgX?=
 =?us-ascii?Q?likmpBdyn0UFQIebpeuMn+zUS9xoYmtXV90Q/5IirSsKkfyam/CdVn8GlEt4?=
 =?us-ascii?Q?MPhc8Xickrn+JPDPx0b4N0lMHEH/GaUD3z0gGsv43XzdrH8DFqiTw3XWBW6E?=
 =?us-ascii?Q?3GErMpmaoOlVnS0NjSRYlx0ergSw6WTsH5mMhCdWkP/4oJcVtyJ3jD3PLoZN?=
 =?us-ascii?Q?3iLDm+qKL/hec6/vHDoojako7FicUtMkZjeDDg2rkYu34OY3NiMG3lamWAkk?=
 =?us-ascii?Q?OXT1DCtig7FptwR0EvfFpgCoszps5uUebtaIj2TK/BrcW911Xyj80jisTBE6?=
 =?us-ascii?Q?VyB1ZranRqNA6rv+8EtZMCom4GqC33JIl5H9kKDGQVJ+ELmJl8j0CDxuJ72B?=
 =?us-ascii?Q?mCMl0ZGJvCHFuAsH4Aapx25yCWbigcsra8Llwatnd7ZIcNLitlm0RshgN/5J?=
 =?us-ascii?Q?KwerhDtN8F1RcBHOQYj6wZCjWJVZvz1NGL5bsnc0o8BMfn/5LcCSNmD86K2u?=
 =?us-ascii?Q?pleqAMDXAAdKBKiUQNuItU0f+xNZ9grICNKLzlMMcgz+djZyQJBiot68w+KQ?=
 =?us-ascii?Q?yMHALaG2vnFO/jMCmsgmYnJSZ9ox4jEjtGhGnHTNz3Rl60BeiXZ9mDxKLg9J?=
 =?us-ascii?Q?4vUfZM/bdC+EZYXa6aUTY/ENTVz+glqCGX/Vuzp5gjfeBLi9ltcGejWMEYKy?=
 =?us-ascii?Q?7Mfv31Ux0ArUx3ZbUmH39XnbvuKni+xxOcgBItpt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b942efba-4295-4551-49be-08dbef1a36d0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 07:26:47.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xxv0VVAhvoWJ22klgsx+VhFqSsVfE4apGf6ugCl7s/fNUAs6EZgxPquL7lxDDajuDiMgguYIf6sErBFDhLbSDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON metrics for i.MX95 DDR Performane Monitor.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 .../arch/arm64/freescale/imx95/sys/ddrc.json  |    9 +
 .../arm64/freescale/imx95/sys/metrics.json    | 1098 +++++++++++++++++
 tools/perf/pmu-events/jevents.py              |    1 +
 3 files changed, 1108 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
new file mode 100644
index 000000000000..4dc9d2968bdc
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
@@ -0,0 +1,9 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx95_ddr.cycles",
+           "Unit": "imx9_ddr",
+           "Compat": "imx95"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
new file mode 100644
index 000000000000..629b9bae5d46
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
@@ -0,0 +1,1098 @@
+[
+	{
+		"BriefDescription": "bytes of all masters read from ddr",
+		"MetricName": "imx95_ddr_read.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all masters write to ddr",
+		"MetricName": "imx95_ddr_write.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3fe\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 4 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 4 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 5 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_5",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 5 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_5",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions read from ddr",
+		"MetricName": "imx95_ddr_read.cortexa_dsu_l3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x00F@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions write to ddr",
+		"MetricName": "imx95_ddr_write.cortexa_dsu_l3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00F@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m33 read from ddr",
+		"MetricName": "imx95_ddr_read.m33",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m33 write to ddr",
+		"MetricName": "imx95_ddr_write.m33",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m7 read from ddr",
+		"MetricName": "imx95_ddr_read.m7",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m7 write to ddr",
+		"MetricName": "imx95_ddr_write.m7",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of sentinel read from ddr",
+		"MetricName": "imx95_ddr_read.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of sentinel write to ddr",
+		"MetricName": "imx95_ddr_write.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma1 read from ddr",
+		"MetricName": "imx95_ddr_read.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma1 write to ddr",
+		"MetricName": "imx95_ddr_write.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma2 read from ddr",
+		"MetricName": "imx95_ddr_read.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma2 write to ddr",
+		"MetricName": "imx95_ddr_write.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of netc read from ddr",
+		"MetricName": "imx95_ddr_read.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of netc write to ddr",
+		"MetricName": "imx95_ddr_write.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of v2x-fh read from ddr",
+		"MetricName": "imx95_ddr_read.v2x-fh",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x00e@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of v2x-fh write to ddr",
+		"MetricName": "imx95_ddr_write.v2x-fh",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00e@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of mtr(aonmix) read from ddr",
+		"MetricName": "imx95_ddr_read.mtr",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x00f@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of mtr(aonmix) write to ddr",
+		"MetricName": "imx95_ddr_write.mtr",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00f@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of npu read from ddr",
+		"MetricName": "imx95_ddr_read.npu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of npu write to ddr",
+		"MetricName": "imx95_ddr_write.npu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of gpu read from ddr",
+		"MetricName": "imx95_ddr_read.gpu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x020@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of gpu write to ddr",
+		"MetricName": "imx95_ddr_write.gpu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x020@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of caam read from ddr",
+		"MetricName": "imx95_ddr_read.caam",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x030@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of caam write to ddr",
+		"MetricName": "imx95_ddr_write.caam",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x030@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of coresignt read from ddr",
+		"MetricName": "imx95_ddr_read.coresignt",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x080@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of coresignt write to ddr",
+		"MetricName": "imx95_ddr_write.coresignt",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x080@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of dap ahb-ap read from ddr",
+		"MetricName": "imx95_ddr_read.dap",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x090@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of dap ahb-ap write to ddr",
+		"MetricName": "imx95_ddr_write.dap",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x090@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of test port read from ddr",
+		"MetricName": "imx95_ddr_read.test_port",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x0a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of test port write to ddr",
+		"MetricName": "imx95_ddr_write.test_port",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x0a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of v2h-fx read from ddr",
+		"MetricName": "imx95_ddr_read.v2h-fx",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x0e0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of v2h-fx write to ddr",
+		"MetricName": "imx95_ddr_write.v2h-fx",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x0e0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of xspi read from ddr",
+		"MetricName": "imx95_ddr_read.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of xspi write to ddr",
+		"MetricName": "imx95_ddr_write.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie3 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x120@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie3 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x120@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie4 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x130@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie4 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x130@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb1 read from ddr",
+		"MetricName": "imx95_ddr_read.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb1 write to ddr",
+		"MetricName": "imx95_ddr_write.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb2 read from ddr",
+		"MetricName": "imx95_ddr_read.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb2 write to ddr",
+		"MetricName": "imx95_ddr_write.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec primary bus read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_primy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec primary bus write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_primy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec secondary bus read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_secndy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x190@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec secondary bus write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_secndy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x190@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg decoder read from ddr",
+		"MetricName": "imx95_ddr_read.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x1a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg decoder write to ddr",
+		"MetricName": "imx95_ddr_write.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x1a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg encoder read from ddr",
+		"MetricName": "imx95_ddr_read.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x1b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg encoder write to ddr",
+		"MetricName": "imx95_ddr_write.jpeg_enc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x1b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of hifi dsp read from ddr",
+		"MetricName": "imx95_ddr_read.hifi_dsp",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x1c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of hifi dsp write to ddr",
+		"MetricName": "imx95_ddr_write.hifi_dsp",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x1c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of cortex m0+ read from ddr",
+		"MetricName": "imx95_ddr_read.m0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of cortex m0+ write to ddr",
+		"MetricName": "imx95_ddr_write.m0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of camera edma read from ddr",
+		"MetricName": "imx95_ddr_read.camera_edma",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x210@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of camera edma write to ddr",
+		"MetricName": "imx95_ddr_write.camera_edma",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x210@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi rd read from ddr",
+		"MetricName": "imx95_ddr_read.isi_rd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x220@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi rd write to ddr",
+		"MetricName": "imx95_ddr_write.isi_rd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x220@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr y read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_y",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x230@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr y write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_y",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x230@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr u read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_u",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x240@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr u write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_u",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x240@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr v read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_v",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x250@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr v write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_v",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x250@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma1 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_in_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x260@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma1 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_in_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x260@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma2 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_in_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x270@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma2 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_in_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x270@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma1 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_out_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma1 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_out_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma2 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_out_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma2 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_out_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display blitter store read from ddr",
+		"MetricName": "imx95_ddr_read.disp_blit",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display blitter write to ddr",
+		"MetricName": "imx95_ddr_write.disp_blit",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display command sequencer read from ddr",
+		"MetricName": "imx95_ddr_read.disp_cmd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display command sequencer write to ddr",
+		"MetricName": "imx95_ddr_write.disp_cmd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display usb3.1 read from ddr",
+		"MetricName": "imx95_ddr_read.disp_usb3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x2c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display usb3.1 write to ddr",
+		"MetricName": "imx95_ddr_write.disp_usb3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x2c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 1 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x2f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 1 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x2f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 2 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x300@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 2 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x300@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 3 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x310@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 3 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x310@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 4 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x320@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 4 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x320@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 5 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init5",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x330@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 5 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init5",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x330@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 6 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init6",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x340@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 6 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init6",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x340@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 7 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init7",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x350@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 7 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init7",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x350@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 8 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init8",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x360@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 8 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init8",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x360@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 9 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init9",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x370@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 9 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init9",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x370@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 10 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init10",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x380@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 10 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init10",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x380@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 11 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init11",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x390@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 11 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init11",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x390@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 12 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init12",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x3a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 12 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init12",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x3a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 13 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init13",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x3b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 13 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init13",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x3b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 14 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init14",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x3c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 14 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init14",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x3c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 15 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init15",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x3d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 15 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init15",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x3d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 16 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init16",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x3e0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 16 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init16",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x3e0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of fu initiator 17 read from ddr",
+		"MetricName": "imx95_ddr_read.fu_init17",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x03f\\,axi_id\\=0x3f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of initiator 17 write to ddr",
+		"MetricName": "imx95_ddr_write.fu_init17",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x03f\\,axi_id\\=0x3f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	}
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 3c091ab75305..89652b32fdec 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -284,6 +284,7 @@ class JsonEvent:
           'hisi_sccl,hha': 'hisi_sccl,hha',
           'hisi_sccl,l3c': 'hisi_sccl,l3c',
           'imx8_ddr': 'imx8_ddr',
+          'imx9_ddr': 'imx9_ddr',
           'L3PMC': 'amd_l3',
           'DFPMC': 'amd_df',
           'cpu_core': 'cpu_core',
-- 
2.34.1

