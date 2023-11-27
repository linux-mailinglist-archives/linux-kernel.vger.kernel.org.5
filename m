Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275857F99D8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjK0G2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjK0G2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:28:37 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2046.outbound.protection.outlook.com [40.107.241.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49CBE4;
        Sun, 26 Nov 2023 22:28:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVFy2L/FtWJ/6Y0aqPwByJp/9Az6rL14/4tI5CO3/UBSWfQ7KeEVb9RrwzqWxERVVvDc4cgxoPQFXcOvIdbO2+vXJxCBO146uJompxj7aDc822CNB+uJLUy2JQaruINh+AGPzuofkfMo2y5wRT+R9mCnOIUJrSISk4B30tINyKUY8uKhlku1e1dtBmgyUgc0gC3QIF986e5imQ/ge9fpjjBHmdokaS7JRAZ67p2GedAhtyYVsSlSkSZ4xtpmDyO5jM1GtHU/a89SwXZeTgq1LVRwjHHPbGwgmgQAj1nZDkqhflNpC/ePyHwJXG1CR3SAlggSXWk6pESafckxuKEV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rA85grcbCCCx9jcrAVVDhU+4gZoplR3wPTaOZyfytac=;
 b=mHnBRRNG00+JQ79HvPsvJc+hRWmENi9s5L4c1DkziA+l/e5j/e6dmoGt77RjTnlyN0QgmKYmGvJ27goN46Izh/GfxJvGEn9gaoAaapwwa6+eFxyubyww4r/GqgZo4Sobh3V0VYM/9QA0FStOChfUWouff13l8PTuxgBQQcg5rkZb/o8a8o1AYz0bypCYPn7/ddAWA0DNuJvnGHHHO6BewaqA760uHmT6EnVcx4hvfa/RX95ZQ9jTxH8gNXd2B8esZnnJbnEXM3ob+yeopenGTTalXeNkaik17+OVwq/CbKmR9y7ijymPIvt/sxx7nqPL4b1wG+qDkZKHky9Wade+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA85grcbCCCx9jcrAVVDhU+4gZoplR3wPTaOZyfytac=;
 b=LWZeq32bb0yVsx7SRMfXl5e2UODs1C/Gi+gVTskZ1BjVthqankgm9eMbOfYHBXzsCOE3fB2A2yOn8u4T9xYNfJNvyp3aKiy+r7cI1pk6P5DK05iyPHYd3ogprnb+yuAfH32bOJuTvbpWBd1xiEikh3AXAE8STDV9iEDCfkmebdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by DB9PR04MB8313.eurprd04.prod.outlook.com (2603:10a6:10:241::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Mon, 27 Nov
 2023 06:28:40 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30%7]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 06:28:39 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com
Cc:     adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf pmu: add loaded_json_aliases for non-core pmu when get total events number
Date:   Mon, 27 Nov 2023 14:34:15 +0800
Message-Id: <20231127063415.996831-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To DB7PR04MB5146.eurprd04.prod.outlook.com
 (2603:10a6:10:23::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5146:EE_|DB9PR04MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 5153188b-006c-4a81-6e71-08dbef1217e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qw/4m7pnAuKuoMKc5xyn/QPKVUArVjaDjxCNmljCCilVg8Q8zQKa8d+qdZ+LRECvH3/sjNwnZ7tNTzZ7UaO8JASZiUePk27214jHoysyjXguTEOG3a0909ASG4mQbgA2zET9ewB7LVrkC04wiOTLyW9IpAQxsZcFYGZqPZDoQGkBOIWsQ4VMGNBTgBJBIxaLtpeAYuytU2PLRRTx15vMX6rfYQ+xPYI/Ekc7RIQc5dSkJvQvCmmlu2Ncr6BT3AtIFXUPGRX6t+igOi5CMdyb5JBO5lkObGs2bdVenbW2XMl7vzzjGaGym06cr2vPS7G2aqdqlJz7eAGJ4PaFNh3AbkA4cQp0QICD2g2Fp/z00kjGEnro8pFqWr7I4QI7MDD8BOU5fcK0nWdWpIVNrgnOJm746GTrCCm//AXEXPwS4diFuK92j10wMoP9WZMRdGGdT4RaTvU4U/HuRA+YpmiDe3pwZOPwMGgEcgcTUYHLCHbLX8LIoe6DGCjGAPDN6bxduDahT976cXLtryguuFPN58MMEeGXvYDEyFInAY0PXnvPV/ByJsS0dVJ7qn1fw6yaKh6qC0IlkMF/+iPVpNPOwVBSubc9a50cKR6l81uIL95xPqvzLsefBl67AAuFnahw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(36756003)(38350700005)(86362001)(6512007)(52116002)(6486002)(6666004)(6506007)(478600001)(5660300002)(7416002)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(316002)(41300700001)(2906002)(26005)(2616005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PSO05Nas1gLs8o4QXBDwAMHElbWfI6EB7J2ak7aJCnVaZ+ABrrS88QjMXH+x?=
 =?us-ascii?Q?3A9EoWdV3DZB4/HmixH3rs2J6SknH2NcHLJzYgU7H4gkWm37tZtM+BxFvYDd?=
 =?us-ascii?Q?QrAe069NmzroeTg6EcSwMSxqM9ON/uPjuSfTDMs4Pz9NUEhvjgUOexzNLoXV?=
 =?us-ascii?Q?VWf4KNzUPXZVrI2qLzhQK1jwM7Q+ONl7JcOzwpa7yiXyULiOQ1YgQkLstMSa?=
 =?us-ascii?Q?TuLqxLb/KC7pvCtuC21iT3cQSrmbJRNiIdST0LW9YTwZBqzY54/jKIX14cQF?=
 =?us-ascii?Q?KoQyRRe5RTBQYw9VlHCXud9tb6ClNjgO4zUJMDpEXpV0zJ7v7mOdGyxQ719Y?=
 =?us-ascii?Q?SvbxRhEqNGIK5bspKdR2pZ0PyvQlc5HphCWkGa+ahayTGZvgepZa6WSSOjQy?=
 =?us-ascii?Q?KYxLLsPweqBo39a8jVkGvnLdajmqV2GcHwIXkYkP+/KawhlD48wd4TjkjNev?=
 =?us-ascii?Q?k30pLEQ9zgZ0mdXxyZhGqN9eoa3N5hwpAZ0jSs85iKWPXFbplc2phBNlvwcz?=
 =?us-ascii?Q?mltAvFj+S3nSNG6FVWQYMJW861NrbEQNE18YxPnPBlq07XgJqyhwzSKJQCTb?=
 =?us-ascii?Q?IrNGoz/YnW211BnMiWjzYkVPDxlctVPTMXmQ6CQr4JNA0aUUg9QxGJ7F+2UT?=
 =?us-ascii?Q?CUdAQJxc52dFU6VAJiE+mkG1cnZl7IXgJ3VRcpfe5fgW8+bWJTCELdQtAbdG?=
 =?us-ascii?Q?C7pHGXCGeeXg/cFnHQ8wBforaOuHgnQazKT3MYE1QUVMxGnX6SXqG8eralAV?=
 =?us-ascii?Q?Kztk5slidDo3UtUF1mcZaR7TVPMIlm/aiZz/C0q476RDPHuAUOzqsS/TLtIQ?=
 =?us-ascii?Q?CEr/4WA38aTbloNxuwkw8IuquwPU3iDz2EkOd7WlP5mtmBKlqSwFc6pJ98C2?=
 =?us-ascii?Q?949FAfIeNUSkNSK5uhpYagfjcwdCxKxt3p6KRpf6NeHk3d/apBdTenBRVEJV?=
 =?us-ascii?Q?3ZvEVPCqgfjc2EBoGQLLfY0lPVsOJiR1g4viX3kg2afy8+wg9+deLa9Ci7eR?=
 =?us-ascii?Q?Dksd9J9Dq3IAxJ7unEWX3U+oDnnqZr19nZdlohmGkEjtdqIFjCVIQi1F9go9?=
 =?us-ascii?Q?NMdFzm9DQgp26AG/sqdEqVFAlrPwtP6EV1lwS39Sg4+vPv5ewa7krQLJ8485?=
 =?us-ascii?Q?cYxzkPHpTU/9FV/Ti9dHV2DsFPpy8n7mJEApQuhVH0HQGI96GrNrNVx0+mrA?=
 =?us-ascii?Q?MPJFolnwuNS/zyHjlQkbC2gr2/KpuuUcCaKSU9QToHkLJySPVo+2n/tRSSc8?=
 =?us-ascii?Q?UmbEyyZYBxXzLGFKlcCII3AVbGp4B8WkewEwxqEnr62h8nEYukTmScYYn1Rg?=
 =?us-ascii?Q?RtQ/snXtaVkcdntIdf4u4fZLA27Be8tG5vf2OPhwuQFlWlDeiXGwxFrErP6q?=
 =?us-ascii?Q?J0KuA+r4TkW8sYcSoiYP1wHF9IE4afKlDsvBFYrnWMkap+bNlRzqLrDznh5n?=
 =?us-ascii?Q?z5Gskl1YPu1ByEDsWrQm8iFMY/Lp2QWJbiffg68+J3XV3LK17AtuRTOBOl1d?=
 =?us-ascii?Q?PXVU35gjoA8g6Tc9+f8Lw0YRaXsENufh15RgQkkk/hXk91FviGy5qHv3hkcf?=
 =?us-ascii?Q?MP3QLzd1k2t/sVh9JK98rtPWlGSGYuEDSKH5lrKp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5153188b-006c-4a81-6e71-08dbef1217e4
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 06:28:39.7648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWh702T2nYakAyWC8fabZ7ry3Umyb62gCPSQR3P8jqjYq5X65tqOj3o/uZ3fk7d0DA1K+aCq18Nc/b4hcBt9BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After pmu_read_sysfs(), event aliases in json may be loaded for non-core
pmu. And pmu->event_table is NULL for non-core pmu.
If perf_pmu__num_events() didn't add loaded_json_aliases to the total
number, perf list will show below error:

Unexpected event imx8_ddr0/imx8_ddr0/write-command//
...

This is because perf_pmu__num_events() didn't count correct events number.
This will allow perf_pmu__num_events() to get corrent events number.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 tools/perf/util/pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d3c9aa4326be..646cf3351883 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1631,8 +1631,8 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 
 	nr = pmu->sysfs_aliases;
 
-	if (pmu->cpu_aliases_added)
-		 nr += pmu->loaded_json_aliases;
+	if (pmu->cpu_aliases_added || pmu->is_uncore)
+		nr += pmu->loaded_json_aliases;
 	else if (pmu->events_table)
 		nr += pmu_events_table__num_events(pmu->events_table, pmu) - pmu->loaded_json_aliases;
 
-- 
2.34.1

