Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0235768C36
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjGaGoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGaGoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:44:11 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE63CC7;
        Sun, 30 Jul 2023 23:43:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGDYw8d/4D7bjTIDdVRTYzEtrxtGWaceF/Pmzo3JOLvY01N2tKE70pnTr+QDRJH9iXGD+NlEzpTbyGjId/Fbt1chKSLuGlSbKjJJCEFMMTDObe9tf/n7K+caNdzg6exPYqtVdIXCo6/09bkGRjkIPUsKNUKs5g8J0v3OCtso3JcHeOKuCHTq01sRokz6jY8TsqCL1TwpZw4W7yWiY6emkvLEW4ZfpP92m03SjoyMbLUdM6HKZ5b2TfZ83xM78IjCQmytafJzuAolYujFl7BmPL+Fhc0BXVxSDkUgkoTpJBiCQvg9GQlA97Uyt/A0+JTKoyyTvJEH9aRb3xXdILy3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnwPH3pq96T+Zzaklp2pSzzWTeNVi3Kc0UXMFo83+kY=;
 b=SfgRuvgWB8qaIw9JUjdooHxJPzpcjDPRSJ8Y7w2m2UM3Z7ERYoV0ABY6a2vi7wBHKrRpcQ8NzcN5eDrV0vCGagPgIYSRH6SI0hIl/nGfjAsiEvV+lekmBil6u+Ex2kesWXcu4uSDzKBPYnArrzuF8xJ/HjX7yA+yFlta7rYBBrxyVQdwYXUSF2HEkcrjoKno9ebOXQu0PiIIRs0IpZCf3flPj56iXxkwEqVremh894vERnm7NawXEk5ijpaY4dskuD2fD6d25cSZilXaeTZxpKbawLKf2nRhLmxHqn7aC8vMIfWb+BzTeUj/PjgBKtZEtN85DElml/vGHZbs8Mz6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnwPH3pq96T+Zzaklp2pSzzWTeNVi3Kc0UXMFo83+kY=;
 b=YMybmHNqydiRyJmaBBDegoqsCG52UMHzAQ8ZFQwHetrG2tozXGSYX7nLhuhAuF5edsQbx7M+zShgUwaMg8rsLZLEDlFEjy66i+gWqqVtUF0V5zCdrVNUnpvdsR7F8HDCvKqy7J5guFWYWaCGtAyh7/mddZ9m9unw+qCyl4u1lzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6834.eurprd04.prod.outlook.com (2603:10a6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 06:43:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 06:43:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 6/8] genpd: imx: scu-pd: initialize is_off according to HW state
Date:   Mon, 31 Jul 2023 14:47:44 +0800
Message-Id: <20230731064746.2717684-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
References: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b122c7c-e2bf-4a55-b6e9-08db91916fb1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bty2P9MExiG0N6fpY/CFTQoRG+Cu5zTuJDnRmbG3ZJvS4WjNwg8qxlR9lYeh9gtwI9/y4WX730p5V+WHffb5r6PRc7/WRbsiltapSumhULf8oIdTtA1dOAJvpGuGraWKIyj1DOWQtg0gDf12+2Oijnhd0cZrZXBLkA8IKQ+MBG1zAi+hjNdf3DIjEmhzc5HO1OZ2fXfr8RC7GhO0w2xIShZmMSQANfKW28TLVEsA+B4odG7Z0nOvw3Ns5Hd92tuDA0iwatNbDtp2lHSLjEWOuavrCwkWOr07kJhl6HBZ243t1DZbVu2L1AXAdEd2YT7PoB6/cmCsRqQVlS0XfNIcXjbhZhfngBWBUD3++OSyQMSd4ycwRjc9PtHjFxhcry9Xr4+4O0SZJZnGDBF1+a7WRkgvY1TFadJoiWV4VkbW6FpgBLYrz/VcjEwpH0mE88wa1EKEakXKh2nbd3VoJIGeqE15wv+5/HitGvLh1a686x9MiIo3Gb8Ch/VuduS2wJ6SvkUfGfxNUbnAAcdYHX4r+N2EfRs6IEMLU4cm/+ltehGCxbyEbGQpIwitMadaRDk+6jwfdYfsVF8trt9AU81wmemXwig1htvIBvhlT/PwcRpjR21/iNG6I6CtzXWprpan
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(6512007)(52116002)(6666004)(6486002)(186003)(83380400001)(2616005)(86362001)(38350700002)(38100700002)(26005)(6506007)(1076003)(5660300002)(41300700001)(8936002)(8676002)(66946007)(66556008)(66476007)(2906002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5tFs0kUXKMw3lR3hQ/WSpDaic3Y7MOlv2ODNK98+QZKA93448Of+0gIwTzl8?=
 =?us-ascii?Q?MpBHDrGRPUYoqi3LGFOy+cQ9DJ9KRV6GrJRNb9mgVZlDpT49s4SSv6PpdWiX?=
 =?us-ascii?Q?7TwYhqbfkfiah8LlylgIZeMXrYfw0KaysoHMdJtBJIyZ72EDZxkW4yxH6gHN?=
 =?us-ascii?Q?RP60xikaj5Ng6iaXkkEjctmdNwTuU4ER5DSww7hH8Fsehn+RQTFHR5fVXoYt?=
 =?us-ascii?Q?EWXtu6U0rDy7qD8AoY15YdVfknwFqRVvwVELH/bp/eRb6GQocGIqmfBd49tN?=
 =?us-ascii?Q?Dx2JTdFuJXbEPmunpVGST7GwxPqJlrJIOqSDIGF57V4kJ8QiWxFuFM0xyjRm?=
 =?us-ascii?Q?vufVm9z9uMDpXNC14kLaM3mLXS1fmHFLi2Ft06kcb/VtdC0EeLKHTz41ZF0h?=
 =?us-ascii?Q?rZqR+12shjhE6uuEwE8/EaJstCLaAZa7a2WX9O952q7Aaz61TPCXTGwbr0ZI?=
 =?us-ascii?Q?Ivh7F3zs34n45mkCqtnRnD5pyxGbiYpi5QNOp/VuC6w1bIbV1dnr3c6yW/sB?=
 =?us-ascii?Q?zVBYJfpveyZ2mkZQS77AwOMGpqGTJ3AHZCWGywA+JSuqSx+E5fgbSp5OibSZ?=
 =?us-ascii?Q?ZW99nF/jHmGCNdA3MQjnFM7s4brNgYrwuWgapgfF0juqbx7ccwJQSXZXPOgP?=
 =?us-ascii?Q?g7McZWnpoKmHTQ27FwZS6XGPca6pmgNn9M7tqPPUCNKHxiTNAux7hOiEaBfg?=
 =?us-ascii?Q?AIdGNwgf13fVjaGXjlTIA+AAGTcRbTP2uCvTLISUL80mYAFPzjQy/3FVca7+?=
 =?us-ascii?Q?QOQdSaVcADyIGiEo5lpLLgi3oaR13MsQfQJY7vZldeU33am6wlTKwuIp1UvL?=
 =?us-ascii?Q?wuscLEDnwkXt2TwKstGkWXKujwb4LBacKPP8Z/LDuhxsY9IXMBd3eGFgVZ3o?=
 =?us-ascii?Q?EwmQEgmsQ4SRcT8zReU5ivbLxWGQFQLtDUKFcCWTL1Oygo7F0gxBD9jDDtr/?=
 =?us-ascii?Q?GtakT5YXSSBYXSD99guH6MPZLcA8ZRSQokaiIod7fGCECzY6Kcn8O6TbdGco?=
 =?us-ascii?Q?hSYM//fFDRSfLCu9dbudNZIFKRPSgGZZlEhGCf7qrp+IeQRcEgzA8Xof35DE?=
 =?us-ascii?Q?8l+8Aet+0s0Uy092wPMpLELCk3KzGg1LHWuzLK7ImmnREPaYL045X1uubYKQ?=
 =?us-ascii?Q?zgPY8ZW47sa7+h0JQghpZPTypiWGn2Hk95r4DK4YC5RpZwXYtgy/Qit+j1DN?=
 =?us-ascii?Q?jkLw1ynqpmjeP8ToJ34VKrZjmeqJrVeLsk/tGOs8w3bjHM+2O7uSR5kRhDeL?=
 =?us-ascii?Q?JlE324NySplZXOgIRpzKFEjD4trCSGyBzN6Sdv0MHFBrkyzmGyrBdTr3NJJ8?=
 =?us-ascii?Q?A1iFo+HBGEyM0KvD6wdmNmV1UJM3ZvQUw1PzTO23dXwffhvCWRB+wJ1Yw2PQ?=
 =?us-ascii?Q?RhcDar0r9AUHi/X2V1hSnRZXly/DrMLNqbLiLCLo1v8oTxfJb1jV430uHP7E?=
 =?us-ascii?Q?EYyMHHUS0zomAgL9Kmh8R3xcJIYrmY1go/QphcQ+4wS9FmY1FcW5/z8nSoo0?=
 =?us-ascii?Q?4KlKkgrNyhlrMrly1pztGdaqv5Bt+Lb9iNdKpRJUt+cvbZ/HUNAO/K1Bx0Da?=
 =?us-ascii?Q?pZMfrG/h0SzCMdyfOUVf7hZs4enNunJqY+v93dz4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b122c7c-e2bf-4a55-b6e9-08db91916fb1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 06:43:23.5214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukkSR4NXx8dcDJFmnWyJI4u2xBF/zjEnxJJ9vayq21aD9PwiV2HJFCApkVZklG0LyLxHHdwBLq35S7jTheaLxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6834
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The current code default set is_off to true except console resource,
this implies bootloader should power off all the resources it uses.

But this is not always true, let's check the HW state and set is_off.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/genpd/imx/scu-pd.c | 59 +++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index fa840ebe38c5..2f693b67ddb4 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
@@ -72,6 +72,22 @@ struct imx_sc_msg_req_set_resource_power_mode {
 	u8 mode;
 } __packed __aligned(4);
 
+struct req_get_resource_mode {
+	u16 resource;
+};
+
+struct resp_get_resource_mode {
+	u8 mode;
+};
+
+struct imx_sc_msg_req_get_resource_power_mode {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct req_get_resource_mode req;
+		struct resp_get_resource_mode resp;
+	} data;
+} __packed __aligned(4);
+
 #define IMX_SCU_PD_NAME_SIZE 20
 struct imx_sc_pm_domain {
 	struct generic_pm_domain pd;
@@ -96,6 +112,14 @@ struct imx_sc_pd_soc {
 
 static int imx_con_rsrc;
 
+/* Align with the IMX_SC_PM_PW_MODE_[OFF,STBY,LP,ON] macros */
+static const char * const imx_sc_pm_mode[] = {
+	"IMX_SC_PM_PW_MODE_OFF",
+	"IMX_SC_PM_PW_MODE_STBY",
+	"IMX_SC_PM_PW_MODE_LP",
+	"IMX_SC_PM_PW_MODE_ON"
+};
+
 static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	/* LSIO SS */
 	{ "pwm", IMX_SC_R_PWM_0, 8, true, 0 },
@@ -308,6 +332,27 @@ static void imx_sc_pd_get_console_rsrc(void)
 	imx_con_rsrc = specs.args[0];
 }
 
+static int imx_sc_get_pd_power(struct device *dev, u32 rsrc)
+{
+	struct imx_sc_msg_req_get_resource_power_mode msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_PM;
+	hdr->func = IMX_SC_PM_FUNC_GET_RESOURCE_POWER_MODE;
+	hdr->size = 2;
+
+	msg.data.req.resource = rsrc;
+
+	ret = imx_scu_call_rpc(pm_ipc_handle, &msg, true);
+	if (ret)
+		dev_err(dev, "failed to get power resource %d mode, ret %d\n",
+			rsrc, ret);
+
+	return msg.data.resp.mode;
+}
+
 static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
 {
 	struct imx_sc_msg_req_set_resource_power_mode msg;
@@ -372,8 +417,8 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 		      const struct imx_sc_pd_range *pd_ranges)
 {
 	struct imx_sc_pm_domain *sc_pd;
-	bool is_off = true;
-	int ret;
+	bool is_off;
+	int mode, ret;
 
 	if (!imx_sc_rm_is_resource_owned(pm_ipc_handle, pd_ranges->rsrc + idx))
 		return NULL;
@@ -394,10 +439,16 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 			 "%s", pd_ranges->name);
 
 	sc_pd->pd.name = sc_pd->name;
-	if (imx_con_rsrc == sc_pd->rsrc) {
+	if (imx_con_rsrc == sc_pd->rsrc)
 		sc_pd->pd.flags = GENPD_FLAG_RPM_ALWAYS_ON;
+
+	mode = imx_sc_get_pd_power(dev, pd_ranges->rsrc + idx);
+	if (mode == IMX_SC_PM_PW_MODE_ON)
 		is_off = false;
-	}
+	else
+		is_off = true;
+
+	dev_dbg(dev, "%s : %s\n", sc_pd->name, imx_sc_pm_mode[mode]);
 
 	if (sc_pd->rsrc >= IMX_SC_R_LAST) {
 		dev_warn(dev, "invalid pd %s rsrc id %d found",
-- 
2.37.1

