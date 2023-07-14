Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9145753602
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjGNJFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjGNJFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:05:07 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E1E2738
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0IGbWYseQs4eYaurP8GuIUya02OExdwJxmyj8UIGiOR48gDZ02jqmopLSRjDXRbnC+MM+5ZJoHigOvjjVQoLKw/KskVt3yjxkQRAlZUPHxLDoZGJ8Z3g4DUJFL8Fl5xOqPopDA/EFepis8uBILqLnFV+MF7dCubSqL4Pq9mvAasmPs9XUjqPnEWCgs+vgt3TWgEMrDroPJWU4Ys/hnBwPOhfRgWhQVhGSLZcv/fVqvszKJeic+sZbLEnjFbWCH435R1U2/JOxX/TEgwjmprPhV9wkd43afg3UMSzM6eacp3+N8DU3MpsIKMlhlbyePqqAw7R6YolS7jSzB8KsBn/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpkVSwFGmJZnxYHjD52Al+u/lCsNMdENGyWfSZpIPiI=;
 b=WJ8djbN22scG5tF/ZEGiJI0PMBjNk27DfnZ4moKPrYhCQYURjIQwZijeLnniqLuogpVq5BUdHb0jPtfz7zSKBPD9H73EodKUT++1KSWozQpMh7R8o0CJHha+2xsteNfsE2r7WyHaF09/mZJ30SJN0UJs618Qqsbv6Gmv76oDNudwJZEb2wu3Uq+XQAmCl4Ik7LdpUd3IlCsOYFfWv7pk0JfaDPvBQzkUvn71VFOgdtlBAlePsLLYleGznuQefNCc4244aSf6Qlfxyt0BgXmfhSavKj8MdaJNKheW1vavLzU27h4kUEN8tiMiEMe+wSZ75nNXqdjTKiCi/Pv+dkP+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpkVSwFGmJZnxYHjD52Al+u/lCsNMdENGyWfSZpIPiI=;
 b=FODOx7Nb9/KXY9K1HZ6m3h402eNar6ET7JvAtaD9FuwCWiFekWodkJiU1afrDglg9pIaDnrSBr65WzM9fHlmwD/ckt2qIoe2SXbXEpKmWA92iGFr0+aMuHP3IdZ8Jlt0JC0be2RWmK5k1gcwXTzOUGiGuvAJHpNqMQdGvpZQE/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7736.eurprd04.prod.outlook.com (2603:10a6:20b:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 09:05:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 09:05:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Frank.Li@nxp.com, aisheng.dong@nxp.com,
        marcel.ziswiler@toradex.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/7] firmware: imx: scu-pd: do not power off console if no_console_suspend
Date:   Fri, 14 Jul 2023 17:09:32 +0800
Message-Id: <20230714090936.937344-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230714090936.937344-1-peng.fan@oss.nxp.com>
References: <20230714090936.937344-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 554baf13-2acb-4864-b30a-08db8449686a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcAEy008NqusaUCWfp6x6XjCC+v8gzBJBmOmzHArghXFORH8evdGRgGEyBWQhHwsqM7FaUoY9nyBGkWHzZHa1z85SsAILwwhVrhbRPkjIK75aOdecicDtyPMGnLCBaDeD52iUXLAKKA0E72C+pEjCbh3BE01fqQozyGQpyiYPjuuYw9zalQ81qRjKQIp8YsbIHqoblSLOU3cYw3GuPH7602VguuQZq7B5d+u8bIexrtx/LbZH4HwIMzadlnJ42Q0DtiRYscFxokUGpDYszkQHluJj4buPNIL9bBh3qnSBArD6qISiKoTyYQwaJgQK4tIXiu+XVRe41szf76u0FwHFx/S0ijR+y9g9lh44ba50J01zi+47Ea7gZgz1SkDXy9A0k8clXuBYD0DqXNEl6XFRlbW+R8xKOZ7VMQoP1+nZncc89voWinCfg18MCMi3GORFbajLLMn2sDD7QJPI+/DG42HH+y/znj5jbhDPLemiQkt4LoQi9lmBKp/GvFVl0B2s23b4keBwYNX6eGKjYSlidAW7hOhcr90PAhJcD3h3yQMfGMDWoXM/NXvmmNum2myn8zAraadS4HMHtmad4RmUIVdCzBexQRtHxWphyDbL4RcjhMOrdLa7Puyl+v+MKuS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(38100700002)(38350700002)(86362001)(8936002)(6506007)(5660300002)(6666004)(1076003)(8676002)(41300700001)(26005)(186003)(2616005)(2906002)(83380400001)(6512007)(66556008)(52116002)(316002)(4326008)(478600001)(66946007)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?036UUOIwBOi86+7fnLCnM1xd7un6XipvnTrXxfZeTX0pGhxlEBqwYvAB1APD?=
 =?us-ascii?Q?V3aF30pSy4vaEtfyyHH5G7ENnHRhZKzUo3JZZb4o+H6QsLB3Bqvvdu3x0b2R?=
 =?us-ascii?Q?naqccMkHcgiuQXec5YIjfTreFLmB/BmqqRp8kiGh3pHUmyTflTxJMCnx9BP2?=
 =?us-ascii?Q?KGhBiZnPcx9oIPJWrXLNUTIanfESM7sAb+f4ErS2Fw0e1FQvkiJeY9beArET?=
 =?us-ascii?Q?HK0/W3IMfVHqeXLsJSK3v9Kk3taMivmkDHKax6XhB1uRg+Wkvy0Y4jtvhwvZ?=
 =?us-ascii?Q?YGPKwpmxaWo3+HW7xizZMvpkjrJ7RF0C2wk5uJP2vhuFldk7E6LhRVMRfT5e?=
 =?us-ascii?Q?Q8+u5AwTAwaP6bi2KEyK6ytPU/fnmeGzWqesg8lrUGog/AU93PD+sHeyZDug?=
 =?us-ascii?Q?EsmGyTI98MSQiS9wp49yL3lLhk5hN8ygfS4rsFr56JLHFg36+F3xahNHr3O/?=
 =?us-ascii?Q?9heouWzRqvgMPPgnsRl63+fENYUoxjnyChWsdzJcJP2SrGU2YYKYWwzl3lDE?=
 =?us-ascii?Q?vxW5ab86baJHJYAm3qHklEKk1mq2LC0dCY9Fs6rgfJrjCaNtd3E1X5c+d+wy?=
 =?us-ascii?Q?21y4LGf3AiMIFdxRW1jUEo8nqttXSqo9jQUpN1udkuv9HPAqDKK0T1pVaxXj?=
 =?us-ascii?Q?1s4k06NLiLtlFGhFa8dYtkbUv7TPWpSusuaQCxCz01+Gef9QQKNor6e7uo+R?=
 =?us-ascii?Q?vqCmF2wCL3YKbG7ZCBv7HyCN3ne7g5RVuZH2xSD8RKtYWDuHpxkK7Aanq5oz?=
 =?us-ascii?Q?iyTrw9aWytOxLOUuuKj5UCg76anZg6aFOSkEuYDQaE0mnAG6o6cu3rOWCrtC?=
 =?us-ascii?Q?VUEvN8xQbQGYhD9kh6u0oXRCwlFt9gYOgQhJzd409kU5Ayuu3a+sM7j1qk+M?=
 =?us-ascii?Q?b4jSMscZHwU5yNpe4HBriJOHytycgbwOrwSFBSHzq6x5vyGfXmCRdn/bvWSA?=
 =?us-ascii?Q?o/CwRnU4HYS7+arX8WtDgzL/touoLy5vvbPJiTKa6Vc1Ryw5/eOhQCylmdqe?=
 =?us-ascii?Q?LtI9TAWZUEljvmlh0XBBJEjxgYdwBz05kE0SCtxItE/cqJWg4jxOylC0vHRm?=
 =?us-ascii?Q?tyjWJfyOqB+stDsOAVoCJyVnj6Mi+oQDah9Vn/FqI3eJ4fJpXRzXcv/wMuSL?=
 =?us-ascii?Q?T6i/EnKSGWFxA17kypiXEqKCIglysvJFAhwoEbr8YDrDUsA3/kH84343MNGP?=
 =?us-ascii?Q?v3uuTwJDCRXoYSDXexMsSbciVnI8fDWSsPSGbfYIm5Z7FYz0EtNyC2UUm0x/?=
 =?us-ascii?Q?k0k+T/0+dXfT1fgvhnRv0v54FJb647lHRGqEa3IMAvUlsGKhrO8Er+TaqY5f?=
 =?us-ascii?Q?uPjx8v6vjrKt8sTgLjkwRMPL7T2MqxVQOrVgdO+kPwvpQo/kFPHX7rIiCMPS?=
 =?us-ascii?Q?ZymHFmDHD0w5TAgDEwq/tS3g23uCRplpP39OupxCXVyTPrVFun1eRzkxC+FT?=
 =?us-ascii?Q?OUWSUWqFQjRlv5RDRJHfaJ7WtWHbCYIBBVV4r9c8Ba1vPamR8MISVqk3t49b?=
 =?us-ascii?Q?L05dHvQaKJn9nlBKx8+8k7JU1V6XcXyscmbehqx1VwNu8RfmZIQuT0xVifod?=
 =?us-ascii?Q?AisQ0zD33M36Ch+K5lFKcEWl3jO/LZMIzXyOGxAP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554baf13-2acb-4864-b30a-08db8449686a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 09:05:02.5449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUh+e/lwdVMW0h+bCNloROdq0TBjQqbXLzCU2i2wP8JdIirh05r/uw9HwUNMetl9DZ9KU1A5BaxgEi7s9q0OeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7736
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Do not power off console if no_console_suspend

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 08583a10ac62..6770be51d234 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -52,6 +52,7 @@
  */
 
 #include <dt-bindings/firmware/imx/rsrc.h>
+#include <linux/console.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/firmware/imx/svc/rm.h>
 #include <linux/io.h>
@@ -324,6 +325,10 @@ static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
 	msg.resource = pd->rsrc;
 	msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON : IMX_SC_PM_PW_MODE_LP;
 
+	/* keep uart console power on for no_console_suspend */
+	if (imx_con_rsrc == pd->rsrc && !console_suspend_enabled && !power_on)
+		return 0;
+
 	ret = imx_scu_call_rpc(pm_ipc_handle, &msg, true);
 	if (ret)
 		dev_err(&domain->dev, "failed to power %s resource %d ret %d\n",
-- 
2.37.1

