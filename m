Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3A277B6E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjHNKhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbjHNKhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:37:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C39010C8;
        Mon, 14 Aug 2023 03:37:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVJmKz0joIpuIR8/QYrHPZtxQW9gKmAkfthdybgUe3wYPBCASFLZGU50u21taS+Fd1tYZ6Y+bVMsQE6pMxi+ainM0/y+WbzRNGiG7RXNyneRnH0MAEIA7/lgyzh4KgVcSPrC2IdpGr4U/vXFMcqjcxXgA/BtVeZ/zOf9v9Dh1mmll223M4LQ5Rsv0sm2s84gCjfbsxBj4Ua68omukDCZzDqNnE71Z3wd4Wv8mvhHE6OS+aJ7NjM2k+VvbVTq92uIzd10uyUSlSNxIhUnQyZIm8MEKA+msz6qc8wbrYWCDkD+ATMp3FBeGiWubRZWGkBqQc3vIqrg+2CVHnUhdc4kqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwRU22VMNvJrYHg4B5UUZdcLWjHx5mVs2a1aJWCugrY=;
 b=TgUBCIsE2PK7xY9x6DF1HV5fPj6x9kLddMeTpyfS3V7IIW5jcNnr17QpkX8VRlaIqpT7ZkxIKU9GQP+nXKHpqqpgJu42UbkLkWOg6IZ8zlRZnqwUOHE0u772XZUMf0gKo0ut4IycrCvwqTiuX/e2dSnLy/qk1KlJjWrdTSn6yz/dxKecb/vtnpKv12XR8hOZMMrfWq/q3Qz6PBBW0UjsKmH06VzYgTyHxbE/vIWVSGNe5X7/9ArhKVMiKZxFfMbtFCBPYABBX2hOYQbU+J+nuMOefaHquArORjMKYbooLXZ+7NLEYv9/xiGXjn7l/OEQX9FJrjig5iXAHpGG/+nb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwRU22VMNvJrYHg4B5UUZdcLWjHx5mVs2a1aJWCugrY=;
 b=e7L2XUPvfugCTkmlEhnXCzs0DSZI1FY9ZlUDX1xS/lX+fKEaJRWUHvJ2/3IPM5nYgHSbuOgfgq7AbOrmL/+6iB2jnS/krTthDhR78FooJdva8HmnoE4ge+DY/MwJSWjNbf2d0VUuzGCxaaoQzvcj6LJpZixOsc67eyEFU4UMCBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 10:37:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 10:37:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 4/8] genpd: imx: scu-pd: do not power off console if no_console_suspend
Date:   Mon, 14 Aug 2023 18:41:23 +0800
Message-Id: <20230814104127.1929-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230814104127.1929-1-peng.fan@oss.nxp.com>
References: <20230814104127.1929-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b93d775-c4d8-4309-1f9a-08db9cb266af
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcmGNMWqpYOfpHcbE4EHr/cqaqRdF6U4DH+q0bC65jnfzDYv7ql7yBLzIHXigWK6oJ0dEzHhVGgphbua4V4+ZAfgze+1LbDVGXXjIwN8/wx99cyBwjIKQ1wByTnU0RK9KOZprMOq5gMR0brBseW7zXqPvsIbZ/j51ucZbegVyFPyuru61vL3FABBjQ/OLG59scAbY03z13ET/+JBlrdsi7Lf/tJwGjpNBBeEMS75MdolaKQFejmbeBmQ4H1hvEtIhFISvF2taMvfOcttjw3AdG4CUKLSewammmSBzvI2OPAZwhxvwZiIKJslZi0dFLQGRN+qaNO/sOqtiZgfwAUCa76nld6oD1EebWzPv7Pc9vLoe6srT+3PYBoHK/9ws7VARfh/uBosJoiXRcqUUPMCyHaSvQmN4Tq8y4F4CJlzDSQA3ZILWvgh22ZLyJZuqeKLHo/S2nF3pw8YrkRqtTWkhOxQHlJTWZkc1I6eAK5JfMWZzz5qqttYqF0Vb1x8DVJsPw0o4EMepA+FQBA0RTacikXE7Lps+ozlr1yJ9o/6UtG1Z0tVqsvhCpkGgu54NfXajaYIeP091vu+7q16T1/EACMR4uRvq3HH9uqwqau5Nz1uCBeFsyWXOKFe0ZhVety+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799006)(186006)(451199021)(478600001)(6486002)(6666004)(6506007)(26005)(1076003)(52116002)(6512007)(2616005)(66946007)(66556008)(66476007)(8676002)(316002)(4326008)(8936002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fe1FIIkOU2hphHBVTZdMv6uN8PDP1YXMRIFN9jgIbCMWLtD34r3da1U9Avac?=
 =?us-ascii?Q?7pMxnveV44YRr+4T4YAyM4/q0RS3bUZTpzEGEA1DLR2fFDe9qQICu+JJG0BA?=
 =?us-ascii?Q?jEon8lZIoY0FzfFnVW6qVHJXDXPP09W1fUPaXfT3cw6T/dskF6xJwkYce6rU?=
 =?us-ascii?Q?z1d/OiISOnf6VqZKkgiKb+9n3HxW+YM+A2SyDzLbfH66gC35hHPVM+e7rlH9?=
 =?us-ascii?Q?WSqhMyKcr6fWJek1vXnqCP3SnlwOzBor6uaC/KEsJG+T0+FRAFJ2DTrkSu2d?=
 =?us-ascii?Q?71blt+oe/W/ilX/HQfKg6d2VuFP4zc8jGMwijjXkua8iwCAWrY3PrI0nJ5CT?=
 =?us-ascii?Q?wqdJSP/hV2FBMuJ9HS2BP97UXLirX4PTBWcE2qZTUIrGJ8TcIFCSwg/15zS6?=
 =?us-ascii?Q?StyesqEpa45ef/gUzCL9kqJ0+bxmZXh1Z1uXX6ddWC3D5FhTF65a5guOWJ+P?=
 =?us-ascii?Q?gjCr/vVc+SWCNoFIPAseQPm3Bw/6UkKIBubAHMPmdbYM3S9B1AGae7gLciR/?=
 =?us-ascii?Q?aQgFU8LoMkLWxO8hBNz9a+74tRtNxZDN/JoK4+gYkmNmHSZATlaN+lR77YNJ?=
 =?us-ascii?Q?K5aD9PVjT/9kx5UdUVARVoig3esGiJ6XYtg67glGKjlrOqYSaveQEcu1aSEE?=
 =?us-ascii?Q?RdjpBjq4WK9vcAZy3jm9hwxpqAeYggdwEJDzwG99bolPdpPmkmElWHmWygG4?=
 =?us-ascii?Q?VgfuAYTFFqba1H5qt0Rh0mvvcf6ubqwEt38hD2myM+tPplVf82ZggIhN9IrK?=
 =?us-ascii?Q?hCM/QR//GqkM3JHRrZz1xMKJA1tIvcw2lfwEydXTKoD51d1SZ8EhiXR7WulN?=
 =?us-ascii?Q?dydOw0FZM8hkH2n0qoCxbPWle6tn57of7kphUCJQ4z8jfn3V3aE/3HMbAjVx?=
 =?us-ascii?Q?5netdOyVkH3oe5YSaYc2Z5Lyh5cbklxPhtAz0J40jrTAiySIflej+s7mxXro?=
 =?us-ascii?Q?C3hIIZDZoBcl3/zfveBRLFzmFFdgSYfo+w7RmE2ZObHSn/gz+yuTj+PbuxIw?=
 =?us-ascii?Q?RtWFXBsDFUgBE3T48DXaWRfWExpTDm7D7ObzonFD1/YppoSmq0tcJJgiY/9S?=
 =?us-ascii?Q?pwL9HCS4Gx8m4TcFjI64bz3E+Hxjj9RKeX2aMOgPprGuZ4JQK8cqOCM6QT8d?=
 =?us-ascii?Q?/Msv6GS0wrlLmhZ/rsFw+f8GrfyY2hw5DFClQzLy0rxAKixhqtH+f6StTSMP?=
 =?us-ascii?Q?ojysgg25fHWATvCei8qS0TGlCyjA++n9i7DklG0VQL8ADHGkscScmE0dPnSw?=
 =?us-ascii?Q?i8hm3fLSwo9WfR9ChzkMTN2LIG48c7vz1tbDpnawFkRJtATPz6xXQaVI0oCn?=
 =?us-ascii?Q?z51W98XhHEtjH/LPCvngnkR0N3U78Awd/0g9C56v8J8XPAN2uNyMq/RMAoVT?=
 =?us-ascii?Q?6qgTev6UZ/J1Vrooh7zE9EfflAdftYMzUJSoWxKuR8UxzA7WwgQ3YyYWFM44?=
 =?us-ascii?Q?9IIKuTlLq22GbhFIYXf3FvVGdZm2GehttL/dgwZ6BtEMjRVg/IWuDbxHhp9F?=
 =?us-ascii?Q?s0ZMesfF/jZ5ntmh8vu0XPfcI1wxY7sadFO0vn5XotPXygxEq3lNwyZnQefw?=
 =?us-ascii?Q?Ob8Vp3M8uxqhb7G6uhxYRkT1lLd69VHR21MbjJry?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b93d775-c4d8-4309-1f9a-08db9cb266af
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:37:04.7319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwIult9NoIKJalTvdRSPNEmbqVcCAkaPhcHNgLwDpHpqni2FfyBhHgC+a1WpMS21QqOGkhnantUiQX5+CCV+pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7216
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Do not power off console if no_console_suspend, this will leave
the serial device's corresponding PM domain on during system suspend,
which is useful for debug system suspend.

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

