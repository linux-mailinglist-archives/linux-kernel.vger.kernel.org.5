Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E9D768C32
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGaGnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGaGn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:43:27 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7054010C6;
        Sun, 30 Jul 2023 23:43:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzqHFurjMKJPX5i2w6yRD4hF6F7eoZICpvnd1xX9yrqS8j5XupmhYbEpS/W8fQ0EI09BiPONItmuYJSgjfA7CitmbE426g1OHBz+LgK3tgSB8eZnX886qRGRDspGM1A31s1prxbL/39ner/CacnIj7a+YWYEBMh8VdeBn/bFow7q03vBEfp4WzbT6ndV+13nM0WnN5bGw6DHBlA6J0dEDtWYH8gjxQbbfCagEkQQPuDTZOkMLCwJiredBb80ujyMblxDDeMJU8sSkcjJgquWMBrZ9MWwsDwMpompsikpj3fz1yO56qqGV0PwzrCWXf1vCUWwwGu7hvm1KxHnTFGS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kP0lqZJuvmmSdkRT65OTRDCkODncocwe1oExCy4U/A=;
 b=oAVyNLT/mN2Uxtinn6N6BEULn6xH8VR6xr3nxyqaywc6ZPuk47Qs04ttYe2SZrljULMjjbVyJH0f+/T6aXq4h1cD6JyGZTEefWHkuBdktBGdXP3s882jE7bs/zAYbTM9ZwjqLnfTt7GDlvNaeaXdCXj9r3KfDYiKg2M/7iKhnkoJCyEMSt2/+ZOPSFZYzNp+YI0amwfUqIcA/8975WN3X91uTupcs9LweFjQQe6M1iRToYZ8QuQLodz1NESp5yxQ/PFTVB2hRaoUjJrxB9i9drwDpnH0ijOZMFlm1kLvYfrTQ8EpNn1zavsCRMSv9ZbRTJakCqaGbJQ6qzK12HlChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kP0lqZJuvmmSdkRT65OTRDCkODncocwe1oExCy4U/A=;
 b=HGyEvYpE1uy4pEqUGC9AocmJioU4DKuano/1kLDLKf/VbF873nyC/Hu/B6+zfLx1wFkjZ38NXLxlk0KYLFLbBLXeUu0YqVVMTvG9/Zft5mD3LD0OFULyzRmQHsIkzmmNuDoA0YTTqTpopT9v7QidLeIXrnOVlIHqDpxmzQzMVDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6834.eurprd04.prod.outlook.com (2603:10a6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 06:43:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 06:43:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/8] genpd: imx: scu-pd: do not power off console if no_console_suspend
Date:   Mon, 31 Jul 2023 14:47:42 +0800
Message-Id: <20230731064746.2717684-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0c7c132a-d438-40cb-7a4d-08db91916b96
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xetCxadBqfxIboc5Pzt1rsHIR552LzCqgt5RPEehEh0jD3CNQm/3r086TwduKqNXMOAC6tj7CKOUKyfffntTejH3vYexwe5BOc/la+RF4NtEbNTqKj6zKkUfTTCbz6WHJXpK9eg0bB0CFwAndf1v7Obc4500eXBDqGHj5znpHP9Ulz3mAfoJsFYuIklq46yVNOtreGEXpWIDCksN4WXN4z8vWKhA6XwrMs6KurlzmF2ANmBOx+arK+tATEhX5mBMOO0MUEIyQoHrt2DJ7hID6/esNtZkElKKMQU7v7R2pSFwhksCAiQGljF30b2xO9pWSjJppPXJmGAuvsIyc49nP2NBGxmiggFnauZUtdKBza1e/iQIbFEHLjRcjbdv8AKNX/45GQMbPQr+qDGRBLUzIccMGiloxMLGLxzEkibmb+JqfUkZkdC6E0XifcPKbXEqiI1TcgGt9K0gFKZbIDDnXKTCyNI/mlMXK8BPkF0fgr6BVMVa5GFTiEBj0+CTsmGFQ8Li/PGUPieD2bzQAPN1SHuf3dYc43RFgCHCwEBi8ydSl2ICr3MjPmcU+YQSGmqDz5f2p12TJpEiqvVbsWlgusLNza5AZArflwTuhCXbiuP3jLK1njd5Mx2FIwn2qwEo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(6512007)(52116002)(6666004)(6486002)(186003)(83380400001)(2616005)(86362001)(38350700002)(38100700002)(26005)(6506007)(1076003)(5660300002)(41300700001)(8936002)(8676002)(66946007)(66556008)(66476007)(2906002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H97PuXemyXJI4lwMqj+NonyNwt2L1TPYkpbDRWIcvb8d6dtRJD3JduSSS+Fw?=
 =?us-ascii?Q?A6a//YQVCiaXwB3IYlCV+yCT7WqL/kuNV5g2wf7qcWFC19v3xDZQHhKvpESy?=
 =?us-ascii?Q?73XknujjRZekZRoInyqo3tKC6fKuKKp4vR4UC5JtKK3Bfja4GZAxNK9r/+gf?=
 =?us-ascii?Q?etDyCSLr5Eiea0KarxswF+FifGvh97NTtf85cNvnuItVcK2ADcgWVZEUXNLI?=
 =?us-ascii?Q?EkehNop2AOSAnrbaMNrsk+AAW1JtNjESytX8FRqD6ICrTjjqXY5t8CmMHtsm?=
 =?us-ascii?Q?ViJhsR6dEXs5DXz+rFDUoJZV4Cqpb2xs0Rp8oCN8i2Vx05uWT00D4ZK51UNx?=
 =?us-ascii?Q?eKayrjTdRtBT23Y4zO9fGSp4puOEltULH1styDlUQjqgK5TGByIiTN3BIwXq?=
 =?us-ascii?Q?VL0ytdNqa54uvkuakjhQ7IF03jWeSDj2UGgSICp7JFRbme6f4iwaS0IS/prs?=
 =?us-ascii?Q?+avDVAq9Ca7pNKERs9nwBFNMZu3KoL7LlkEQWWOnkMU7x8DPS3ddntcMJoNt?=
 =?us-ascii?Q?410n5JatpP2/n8NKBx9+cmpJC2bQToFnZoOufpkDtUufWep2tqk2MLIF0l+w?=
 =?us-ascii?Q?uji0ZKhdC71rxb375uBSjXJBHridBUPv5NAlSEETccoO7j2CL49nNGzIOLhc?=
 =?us-ascii?Q?lk0bk45LonhHsnQ/IInBrOZps2MQN5VfVTNcl+Z09TmIwaJ7uZ7VUSpQAKtL?=
 =?us-ascii?Q?dEZ+O2+0LztUntVRkJU3uVak1/GbTnDjWysADCKbXBUYfi3E0hEDMT9rt5n1?=
 =?us-ascii?Q?zyMFMIMNOZafIn2XsHvp2di00arTNrOYPKCf0qLN3PObdUq145Yhnlp9ebVS?=
 =?us-ascii?Q?6rQck83cx2NPLvkseJSW+eGH7m79jfLe8zkQSSo08hGgMSpw3M+JmNAuMKV7?=
 =?us-ascii?Q?nPPwSgVB+PPjNUeNOYOGW2JXMbYaIK4A1sE5HirR1wJsW8LvXdycSKdRbHf+?=
 =?us-ascii?Q?0icI1KIjdY/TCIXL7FXyOFBHmwMmNYgI5UfaryZYVG/qPmWm6Y/sUDV4951M?=
 =?us-ascii?Q?YXjIYDNRXZrvgZKtyAcNG6RLKacAylWF054Mq4WzmG4k4llqzxVAQXmnH/k8?=
 =?us-ascii?Q?8EDFu6r4OU7L3S6p0wYBft16ONTrGX8ztHxMBpUxEZzZ3z+HyRnkRPHtVEBi?=
 =?us-ascii?Q?q+D6tfa/9FI59O9wRGM+rGXds4BLsO8hN1prs32x2vgTKwOceKhnPA/lneCL?=
 =?us-ascii?Q?FweJDHf0In5k4fzgOsys1lGEJpmxlFxXSb4z7jRb/rEsveNd5eDU/cXWh6hg?=
 =?us-ascii?Q?/KUhxpcMZ5wBX3hkEIetmCxdBCSoMUmhQFf98IYc/eDNRfvzeDqv4m6pE4fx?=
 =?us-ascii?Q?eA48bUsWXOMVc28AcTR0h3Xs5mw/fKRZIUNy2TtI14GGS3OjVyQKE+N9ygKp?=
 =?us-ascii?Q?9Mvt9taqY6yxKkb/6MXS2F5DgMvrKQZMXeJ4uVITTgTqW6lDqfA7y6Y8s6b5?=
 =?us-ascii?Q?n5vRKX2M+vRy/xXcmmTrQyXghf/l1uwOBHlYA/1sfKJxJ0Q8+TlMBL6LsMqL?=
 =?us-ascii?Q?NSjqYErCv5tT/Dv4wrRXdwaVykallswTipf9L2oTwMOsOM4HeLQpHmFmR+s0?=
 =?us-ascii?Q?QwSaYTItqvMIdHpma/B/4vS8RjBqdLWvbJFwFGZM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7c132a-d438-40cb-7a4d-08db91916b96
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 06:43:16.7218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrnK6cuF7RDzBhA246FybYGW9KU1Ekim0pMEbhhkOK9WnDOkuMMAsJFbv0jZmvFDQgoQ1rpSK0d95XoCiK4TZg==
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

Do not power off console if no_console_suspend

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/genpd/imx/scu-pd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index 08583a10ac62..d69da79d3130 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
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
+		return -EBUSY;
+
 	ret = imx_scu_call_rpc(pm_ipc_handle, &msg, true);
 	if (ret)
 		dev_err(&domain->dev, "failed to power %s resource %d ret %d\n",
-- 
2.37.1

