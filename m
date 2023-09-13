Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6EF79DE11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbjIMCBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbjIMCB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:01:27 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2051.outbound.protection.outlook.com [40.107.241.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B501716;
        Tue, 12 Sep 2023 19:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jaxt6kWvM62V9rlnTdXC8IVnC8FwKreSniZPvzB+ikQXOf/8HUiWdiaOrxSFkwEFWZVI2t2b6nLPBk1rKIg7Akf1o2lRwC2bhQlpKJM9EZv971B4ncMesJIGRyg7u9m2WUjXoRgn65N7rnaeIm6MdlgLoP8ix5ZkClc3UaNNv5Xd3N32E5kVmbeWL5sFURD0fDFQmI0a29Yof4t1y+fwsKlTDRB6tjR0rTBOWjmspiugRISKyTq9t4QqBmXUQyoDVoAs8W8I5x8Fj3+SpKsLv3M5xuesTcL1xvozHM34v2S5vTLcN3i7aUas+VD6Ft40gFOKAao5EcHvJk7u0UVGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYVpx50VecpP5SLn9VJhxZ4KG+DJoe59lzjo9EVj/lc=;
 b=OvNyGsJP7/XDRgYId5ef1iTT8wnRK5neLetGc77zUhNbkkS7sSF7Tu4SO2mg7zGanNmS2IN2h39/oNUZ8oMPDATXgqRBq4SWmdscT/XBCAmK48hEN60psM/GipXriNn3+QZMlDP+m+uRvTGclBshyTD0ksx1hzd41VJ8Hxs7Gm8yQrpsS2YZk/GELumjzDqA43E1Tf8VSgB8Z7AGXHDaVIg1f8PZIP/gVuLfgXAEIRV0lnu6KO0ds5pDA1SYc18e+Pxbvz560RhQogvveoT1Lq+aeWgG0jodjp9uAQ9ptVNxiyawEPr59Nh4gw/vDjmqkYT14Eyqmf1bCcojMlA/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYVpx50VecpP5SLn9VJhxZ4KG+DJoe59lzjo9EVj/lc=;
 b=kmrk2KfhPxRynCBEshPOkLr6TqGj8/RM/KFctsvLL68IqJ+h4d7gSv6eGibkElaXRemSFchjEYvc13EB+/xfKgzmRwA3lyDKqHIToWGB84C/upECOlJd/UGC/MvkX82GW3QR8qWFEgA9wZinQaD2ohxERZuE9+hIp453VTRIYFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8894.eurprd04.prod.outlook.com (2603:10a6:102:20d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 02:01:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 02:01:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Wed, 13 Sep 2023 10:05:38 +0800
Subject: [PATCH 3/3] genpd: imx: scu-pd: add multi states support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230913-multiple-state-scu-v1-3-9d91c6904ffa@nxp.com>
References: <20230913-multiple-state-scu-v1-0-9d91c6904ffa@nxp.com>
In-Reply-To: <20230913-multiple-state-scu-v1-0-9d91c6904ffa@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694570751; l=3099;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=zvjF/DrHc41OMqevgsg7lem3OK3BtRsEIn6QfoUxmA0=;
 b=vL7wz5JIyUGGhrP3HvnvIEPQnRcPawmgAqXdOlIp9c8GpeW24UO/iKd8+18TRylHyVmWBwEUh
 Lthtl8J9dpqCGiDdRiftaP7BfkXpt0ykGS0uBnNkBQoDCon9EbQYLdr
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe400e1-5d96-4783-1d46-08dbb3fd5300
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqktsG/2tdh3zUX5sHRUenkYrxJO0hRhNP1U86AbgYaqV+wm1FBmWpmSaVw+CK21b5sV842Z20CxqUmNANBP0HvAMfbey45CZKoIzjqzK53CObEs6O9f/ZQ6oEegqTvWQNfV1n7Zq6uP7Ce6tUqVwqjcSlGS0vpL+O7o9I0pWXutY8iEtkuhmHNJ/CLRFeiB5aR7pFC+fq+GSnzv/1xrS8bvT8TIcIwziF/N81l+boRXYDf/+8QNwV297HKWQ2ibTrwnFDQkp5VkRdEs+VLMkGC9UntKcPXE3r5ZW27OZtfB77hKuyLFQR+wSuG1rMRLKqecmIvX4mzglrlPhVNn2BhYFtXT25oKzVR1XxnzRYGQePrV68fXWDrh3FL4ev3pVZ8lhAIBhCI3yR7RpU2JgUMANR6N+SORPihohtJgq+oKAO/1VG0BT+plP51Z/QEsWLIEmlolOCZW0OC4EH3ocJGTZwRj4TK8Mw4nsf/BHkdWhCqd7VrArOP8n9n+45ZLt4UCn7VrDoSEvgB8KOWit1UpDZl1FDlJZdcNeI9lUAgxPWWN/kuISmg1drSwc88WmRhw/ntaoQGNUoVMWw3Mne5FWJCekShOg55INejCs2lpCf7ejfxt/aS8UUMixI9N7ytKEwTL7XhYu+rxDhDIxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(186009)(451199024)(1800799009)(9686003)(6512007)(7416002)(5660300002)(6666004)(52116002)(6486002)(6506007)(26005)(478600001)(2906002)(83380400001)(8936002)(8676002)(4326008)(66946007)(921005)(41300700001)(316002)(110136005)(38100700002)(36756003)(38350700002)(86362001)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk9KSFpBVVA1NGdCOUVuT2Y0bWdONEVNZnFqNW0zUUlGRk5udDgyKzBBVW42?=
 =?utf-8?B?QlovWjJFd1dUbDAvTHVSNWR4QlBGUkl4M3czbWxXOU5kRHcrR3NJUCtJcHMy?=
 =?utf-8?B?aTBZOU5SM01yRHplRUF1b1ZURDJDQjVmTzlNSjR0RXAxK25SK2FWMHVQU3pK?=
 =?utf-8?B?NmRIWkJvUnd4N01pbWRsaHdtTDAyelQ2bHllU2RTbjZKSzZEYTlRN3kvRDVt?=
 =?utf-8?B?aXdZNHhob3VmMnUybXNXZlV4WDY4am4rNFBuaW5sbmZLSGMyYkJ6K1lMc2VD?=
 =?utf-8?B?MkQxbXg3TzJkVnE2aFF5KzllZE1hbkx4a1orTlNYWEdlM0hzR2lLdEt2TmhG?=
 =?utf-8?B?cCt0eFVsbnhUSjRFai9lbDBuNnlaRW5qQTlBaTZmSFVBaUp0QmpqdjdTcmNH?=
 =?utf-8?B?Z0FGWUFoZ2FxNmdINEw2UTg0L0Y5c0dQa2U4aVA3VkRtUEtxK3RYZ3NWWnRl?=
 =?utf-8?B?TmZVbWMyWTZhT2ZpTEw1SHAyUEo2VnhJbFJjeE96WFhHamY0UC81MlVuNlMx?=
 =?utf-8?B?SVNUWjlBOEx1azFvWjI5RXVieWNrU3dYdjFLcWpsblRCWEN2elJqdGV1Q1VY?=
 =?utf-8?B?VUJUcEJMSklIdkJVOGFWLzBCVUdaNXhPMkFVV3Nld2pzNW9MVTRmTldoeUZH?=
 =?utf-8?B?M1VMR281a3NkWXFrY2lPSlZmMW5DQnVGcmFjNjh6MTJxUHVzckxjNlVSQ2VV?=
 =?utf-8?B?ZjQvcjdGSlFTb1hndGV5MGdhVWl1TEs0akNmMHpoVWhJTVd6UWlVQzE0cjZY?=
 =?utf-8?B?RVlVMFhTTC8zNTUyRTJDUnovUlhhSG1mMzljckhJMmpRZHBKV2lDcnFxMVc1?=
 =?utf-8?B?MmpGc3l1QklLQ2I0Y2FsM0FtMzN4aThHUUZzYkYzWnQ1L0J3Ym1aTWhyZ2N2?=
 =?utf-8?B?WGZKdGhYYXBKOWZTQ21IZVlSVVhVNFNNdVFtNmZieWFFd2VLYmMrWXQySk1r?=
 =?utf-8?B?VVdENGZnR0NBc1dUdUwvSnBySGNLS2RaNzM5alM1R1lQS3p3V0tkc1F3OXJX?=
 =?utf-8?B?akYvNXdCNUVTTFcxTXJSRnhURlhMakEyQWxkOHF6eUNOK2N0M2FUMWkrTmdB?=
 =?utf-8?B?Y3I2Y3ZjYnc1ZGp1c0JlYWxwZnJNNm1hRGtyWnRmSCtDdW1VVFYxMmE4Qmlt?=
 =?utf-8?B?SFZmUXRHbGhoQlljTHMyczA3UlBQbVl6d2Z3K1EyVFMyMzZDV3NFeUJaeUwv?=
 =?utf-8?B?Tk94Sm53Z0c2WlMxcWhkaGRod1JSTzAvNWk3aGtFZ2IxYzJoNHBmeGszNnBh?=
 =?utf-8?B?WlFhUEtPd2pkb3ZtSW9qTXhwVlh2Zm5xWGpoV1ZpcWdjOEpBaXBYT2JORTlt?=
 =?utf-8?B?akZsTVpTWWZoNDE4NGFWeE1FNk9CWEhlS2JiTjVkMTg0SmM2UzN5b2hkRFRK?=
 =?utf-8?B?YWViZE4raEUxVmlpa3FOa2RaTS82MVFDVHM2V2VjeXBGVTVPT0hEbEY3UjM0?=
 =?utf-8?B?M0FCNlJLK0RrMmRVTFJXOXZhNngxWkZvYWVpSHNBVW9BSVpqRnV5NU1SamNG?=
 =?utf-8?B?L0dSNmJoN0Q5RjNzQjl3cDB2YUFzbVBydGJPZ0ljNmN1eldJRGxsbXlBTkFD?=
 =?utf-8?B?eDI3dHNGRXkwYXkyUndaM0JYd1V0TnRRcGNZdGJOaFlVblcwMStXZFY5ckVh?=
 =?utf-8?B?ZVJwK3lwNmVoSmt4WW00NnFwcnY5M1pST2pwVDB6MmU2QU9yTCtmR0lIcjhj?=
 =?utf-8?B?aU9Kb1RGZkFtQm1KZ2JIMVZhc1lLdWlYZnRWNTlHbkJDdXN1U1dWQkx3REEr?=
 =?utf-8?B?YWVHTTZlNDhjSGU2ZDZ4Z2E3VExYOFFqYVRSa0hDV1FlQU5TTm13Y1hCU251?=
 =?utf-8?B?WnR1bkxvYkR4VkNQN1hlKzNYeG5welZDRVE3WThGYjZkaFdFUG1JQUN0NXFL?=
 =?utf-8?B?WEt1SEhmVHMzeU1TZzR0TkcxOHdFMW00WWorV0ZOdUE4cUNPekpTNW14eCtJ?=
 =?utf-8?B?OGFWYnRvKzVzOFNKNm9CSWxxNjhqaTU2R1Q0Mk9SdUkydGRBK0lzSXFzeGtL?=
 =?utf-8?B?RTBrMWpBR2wrM2gydXY0S0ZrLzRxMW5EUjN5UmJzZHpvS0ZxajBMWDY4dmFz?=
 =?utf-8?B?ZnlnV2ptOTZEakl2N0ErMEZFUVI0Wk5waXhoUTF0NDBZU09PV2pEa0FvNC8y?=
 =?utf-8?Q?upJb1x0Whg6CiOl9QKFZ5vrtE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe400e1-5d96-4783-1d46-08dbb3fd5300
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 02:01:20.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/uuN9U7/yu4OlAeqHsKO75ZfmS3qWPXtHn0+9jMBKxSndRvUP23acWkkFIy/32hsuKaQba/pZFjJeIUzX6jTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8894
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add multi states support, this is to support devices could run in LP mode
when runtime suspend, and OFF mode when system suspend.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/genpd/imx/scu-pd.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index 2f693b67ddb4..f1a43cb0bf79 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
@@ -368,7 +368,8 @@ static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
 	hdr->size = 2;
 
 	msg.resource = pd->rsrc;
-	msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON : IMX_SC_PM_PW_MODE_LP;
+	msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON : pd->pd.state_idx ?
+		   IMX_SC_PM_PW_MODE_OFF : IMX_SC_PM_PW_MODE_LP;
 
 	/* keep uart console power on for no_console_suspend */
 	if (imx_con_rsrc == pd->rsrc && !console_suspend_enabled && !power_on)
@@ -412,11 +413,33 @@ static struct generic_pm_domain *imx_scu_pd_xlate(struct of_phandle_args *spec,
 	return domain;
 }
 
+static bool imx_sc_pd_suspend_ok(struct device *dev)
+{
+	/* Always true */
+	return true;
+}
+
+static bool imx_sc_pd_power_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+
+	/* For runtime suspend, choose LP mode */
+	genpd->state_idx = 0;
+
+	return true;
+}
+
+struct dev_power_governor imx_sc_pd_qos_governor = {
+	.suspend_ok = imx_sc_pd_suspend_ok,
+	.power_down_ok = imx_sc_pd_power_down_ok,
+};
+
 static struct imx_sc_pm_domain *
 imx_scu_add_pm_domain(struct device *dev, int idx,
 		      const struct imx_sc_pd_range *pd_ranges)
 {
 	struct imx_sc_pm_domain *sc_pd;
+	struct genpd_power_state *states;
 	bool is_off;
 	int mode, ret;
 
@@ -427,9 +450,22 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 	if (!sc_pd)
 		return ERR_PTR(-ENOMEM);
 
+	states = devm_kcalloc(dev, PD_STATE_MAX, sizeof(*states), GFP_KERNEL);
+	if (!states) {
+		devm_kfree(dev, sc_pd);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	sc_pd->rsrc = pd_ranges->rsrc + idx;
 	sc_pd->pd.power_off = imx_sc_pd_power_off;
 	sc_pd->pd.power_on = imx_sc_pd_power_on;
+	states[PD_STATE_LP].power_off_latency_ns = 25000;
+	states[PD_STATE_LP].power_on_latency_ns =  25000;
+	states[PD_STATE_OFF].power_off_latency_ns = 2500000;
+	states[PD_STATE_OFF].power_on_latency_ns =  2500000;
+
+	sc_pd->pd.states = states;
+	sc_pd->pd.state_count = PD_STATE_MAX;
 
 	if (pd_ranges->postfix)
 		snprintf(sc_pd->name, sizeof(sc_pd->name),
@@ -455,14 +491,16 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 			 sc_pd->name, sc_pd->rsrc);
 
 		devm_kfree(dev, sc_pd);
+		devm_kfree(dev, states);
 		return NULL;
 	}
 
-	ret = pm_genpd_init(&sc_pd->pd, NULL, is_off);
+	ret = pm_genpd_init(&sc_pd->pd, &imx_sc_pd_qos_governor, is_off);
 	if (ret) {
 		dev_warn(dev, "failed to init pd %s rsrc id %d",
 			 sc_pd->name, sc_pd->rsrc);
 		devm_kfree(dev, sc_pd);
+		devm_kfree(dev, states);
 		return NULL;
 	}
 

-- 
2.37.1

