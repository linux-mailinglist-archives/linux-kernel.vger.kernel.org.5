Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66DD7851B0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjHWHgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjHWHgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:36:38 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554B6CF1;
        Wed, 23 Aug 2023 00:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK4tL0lburemcdD0nPoJzZuuBdc0DqnkV3cS4ZF5tXkMda8NhfeOjAydNTurlE7B3N35I8ikeHtrJlozTV52qnWPK0WhvntRH9Z/awNApW8VFEpXEH5n3uoofAXmG850DCfe+Y69PEOzQvLkZxajkacWYZ4v6EnpKZsLRieMoeruM6oP81hZi9lY0jSUZnOlv6j8JYreBPWwfSOhWVMyi/sNT+jevwjkP2k6OdvHmPpmT+p6rUIo//B9vDsPOc3BVLOUdfJYwu5ZlfsLDbPE1bHZfBNeBklSC8/uQQBy2OZVBzQLomwzl77go7QX1viHCOfXa4ilVIxUwt/xV2+Ohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xc2XJjUg6W5tOR6FJYggWrdO33WOdDHbAyHsk8aRNCI=;
 b=aB1e0M2ARkcqVr2bAODYtqAd+9a7Wbz6qGm9IeYyIo/Urw2d4kEa38IzYIvBbEhpMvX80Xwn1OIILMRN3uurEOXEZVH01ioXcR6MbJZZNNS27J+LjoL06p5rsgZZ+cevxcSe0WaqSAPcsvhbYgzQdHZXr9vUVCoCKZWPi1F/7T7qAQn3UYdLmnWoz0oD9106xLLtlNdl7hxTENVhOMiopS5bdo9GW/qzT6WnLtjB5BtYxlKIW/+fqLa0MmfbI6tm9ubwBHItxKqwUcANaYgCdPP3PIM39ej1JCjdILUvg+wNnXFa6wDxY79WZwRAKY1D6HY35zEvJrK43dkSATwsdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc2XJjUg6W5tOR6FJYggWrdO33WOdDHbAyHsk8aRNCI=;
 b=iw/krKuYuXUvejxK23y8FpuYaaMbFotH1bKwZm5md1u284NFlraDwBiLm+1dJQSE+3bJ8fSOWbFBhPqgJTZO4bMGAgcnU1r9yxqx9fkBJqRAMiIgnFZLTalepofSRGcsI8Tp60gkegWYZaopBrvp7/Yu30Y94dX4GvVSB5OKh/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 23 Aug
 2023 07:35:33 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:35:33 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v5 07/11] firmware: imx: init-fw api exchange on imx93
Date:   Wed, 23 Aug 2023 13:03:26 +0530
Message-Id: <20230823073330.1712721-8-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS1PR04MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 18bf9faa-40bc-4a27-5705-08dba3ab88f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38b0aQeWmDqi+WaYN9jEYYMLwQJOpPyqZE2aa7Pk9NvMVXhd+JmFcuqgCpCYWOuNviQr7XyI06Uqj3QBaszrtn2KYwvVEmTIzJ5G13aI9kRv39e4hEo+OG76j4BHmUyhMRBhgmoq3m/to85k+bBPukxC53L5+tAIG5zP2NTYR4XLn5auTGaSgnXVTdR8CDF/Egz3gWnL+pRRxuFPnB7HjvmRMKuRf0qLZl2AQxSBgxLq0j7BlFGv0uJ5VLtlmTonjdZELZlPf2YVDteNDFU81lhD0M3kSmDYKkq9k1CGVK+irWaOlJrnStn2LokW81eRK6OFk9yzFydsylzigIR0R7UQFhM3yoq4Dmw6HMParCDqvr+LG73Wl/PxHCkZfN1YC/7nDroqtgYZjozSXrdBi+ueaIFi8PckE76S+siuGBwm7+XiuxaO3PuAJgjTGE3QF5r5uYTB1OofVf6Sn2/Awb94W9+tYHtdhoMHBVpFJl8Dfpn2zlrD084S52UBzY2o7Zu+5yJaSYzvQnBMpwzlblCeKtPryhI9KHxOiyhjHQpRmhArQiDHWsW2U6VZESABXrdaTmkIJFVbtY3+ZOqhX+R+veJOPRQUjiXnKH+bf5U7AOwapVbn55o6wmjkI5JZ1lgSLfah6HrCeAfmc+u+Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(36756003)(86362001)(921005)(66476007)(66946007)(66556008)(316002)(41300700001)(6636002)(478600001)(38100700002)(38350700002)(6486002)(6512007)(6666004)(6506007)(52116002)(26005)(1076003)(8676002)(2616005)(2906002)(5660300002)(7416002)(44832011)(4326008)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?33mLJ1VGzGGlxnbD2oOLKgoE7a9jYyq1ge3n9XGMfddHqAmRr7MomgnlmiWI?=
 =?us-ascii?Q?TcV3dnm3aVnyypMEeSD1OvXExDGa47F1wgbzUwtD8n969esMrytUi5UmMIet?=
 =?us-ascii?Q?jY5W2oY93xFiZrzvrhxe9iFm+RsJoAa657TvsP9Imrf3jpfuoCKl9Kn7aRfR?=
 =?us-ascii?Q?PF6XcNWdnobTqENStEBZWCLthIHlS2LLGl8k8csZLHyPhvJcywYU7iKv3dyc?=
 =?us-ascii?Q?uXV4zhTOCxR6KtunmJHyrqE/dTOE7vlezYtLTmddgE+bm5Um+EVOcEAB8rJa?=
 =?us-ascii?Q?uNWliEeQeeAAu0LMyUndzFdSef/fcuJ3aQYWEb2LEu4XSkV4XqhzJVZKtSk0?=
 =?us-ascii?Q?fxjld0DEC4qfowWEJNQu7n9lySNZ4ksi7nN2DlTAYguV9yH00hGSpnj/6nHa?=
 =?us-ascii?Q?DMhpwNNhv10048PNpIC9k80x9Ftr25A2GO5IEbgiP92lCBYcT9j8YkhZXvdD?=
 =?us-ascii?Q?EAgUi92KPG/XBZY0nU5M8cOUVVLrTX7RqsMyux+g1XtWxTSh+iSphNz6k3YX?=
 =?us-ascii?Q?x4IcYJWWaqMA4bVcEEonysDz61Nf+4pRfEUyUuqZl5e5CjwkNH6vCa5SNOzS?=
 =?us-ascii?Q?pZRyswSWbc/76z5EcLiQnpgjkOpuyjKi8Bg4DN71mZV4J2NYsoQrY7ACuWKp?=
 =?us-ascii?Q?uaW830VUzWgN09R5kRSIKorU8oerTOkhkXHtuLkaQzg6TI0RY4eYMHMBNcH/?=
 =?us-ascii?Q?nAR5ZU17U9HQSi9KWw9LeZmbHZTf6iJeKkmjrM3plwJEY58WzX/6sEdBCVu0?=
 =?us-ascii?Q?UpQvu1yxismO+yozrA3K+dzCjS8PEV0EJWdLvhLfKL6SZnU2cOZnbzxc/S6d?=
 =?us-ascii?Q?qiswZZADymG+Ci4Nk+T4iBy+IQLvj4HB/VbLJYRyB621NfNprm1Ez4PYoEjA?=
 =?us-ascii?Q?DdJFP2BKlXRrgSZNjv6j8SxOmzrNIZtZB4tvMIzCzPlQtLWZea5H9bu0Tb8Q?=
 =?us-ascii?Q?arT98/5w5ISxUrWsYOta4KyZwrLREsqWLc76QFswQImAgQ3+3mzA15XqWUfk?=
 =?us-ascii?Q?BCOop4FOVqqCiG9KQlE6HjxoPRmNm0cxt9gOYocnciGkbZkpYK6A2JZIDjtX?=
 =?us-ascii?Q?0UDxBWtDNkut88IOEvAJFlYyKY3qYr8OaHeRHbMka2QmdtV+OoD1/lFrtM6w?=
 =?us-ascii?Q?lGlrVOT15ZSsyhQDlAD3e0Q+OwbsSV4zjtZSYRr2yHQBwDHqGOr1prodRKqm?=
 =?us-ascii?Q?t8rZL7SkY6q98VLSVuX2zCGARKDEeAu9HCZdAJygaX6ILZknOJ5vAst4PqQP?=
 =?us-ascii?Q?OqzGtSY/MATjBLgeWRWiCYFs7NbhS/ma4zsJyurGbdNRbX46Slq/Q0npYu6a?=
 =?us-ascii?Q?/iQ1Eo7XkC5vgp2wI5tKlLX6UYB1NOjvgt9sI/kXdgi5fXhzhEhdtdrEG9mv?=
 =?us-ascii?Q?QH+jt22KivQIA7XWlW5Y2lhAHTKzTCUyqEAw0OjFtreW6KSZH0Q2nOAyWCrv?=
 =?us-ascii?Q?XHxZ95OErQmbJopJIWg+o1EAnUK3WE8iCPbq8iyQ4TVVSF4o3BBq9nfKpweq?=
 =?us-ascii?Q?ZAeAv0v+3QSqB8Ik7DgUq/SFy3qdyg/BryPf5hadU35Dv76m/7fquzNc6Gn+?=
 =?us-ascii?Q?1K+9R1eEPNTymUpNe8P0/siJdDqMHYKnr7zweDnR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bf9faa-40bc-4a27-5705-08dba3ab88f0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:35:33.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzMHZyDGhgKU57NRCRu0SKHsoiIxXinSFa8dUuSbt/vBXOF0FHLN7Zu39bxD0TCOiTFsrAcg5U2Z6FoD9Va2WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On imx93 platforms, exchange init-fw message with enclave's firmware
is to be done.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/firmware/imx/Makefile           |  2 +-
 drivers/firmware/imx/ele_fw_api.c       | 56 +++++++++++++++++++++++++
 drivers/firmware/imx/se_fw.c            | 11 +++++
 include/linux/firmware/imx/ele_fw_api.h | 19 +++++++++
 4 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/imx/ele_fw_api.c
 create mode 100644 include/linux/firmware/imx/ele_fw_api.h

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index eab3f03e2e5e..bc6ed5514a19 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -2,5 +2,5 @@
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
-sec_enclave-objs		= se_fw.o ele_common.o ele_base_msg.o
+sec_enclave-objs		= se_fw.o ele_common.o ele_base_msg.o ele_fw_api.o
 obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
diff --git a/drivers/firmware/imx/ele_fw_api.c b/drivers/firmware/imx/ele_fw_api.c
new file mode 100644
index 000000000000..1df1fbcb6d9e
--- /dev/null
+++ b/drivers/firmware/imx/ele_fw_api.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2023 NXP
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/firmware/imx/ele_fw_api.h>
+
+#include "ele_common.h"
+
+/* Fill a command message header with a given command ID and length in bytes. */
+static int plat_fill_cmd_msg_hdr(struct ele_mu_priv *priv,
+				 struct mu_hdr *hdr,
+				 uint8_t cmd, uint32_t len)
+{
+	int err = 0;
+
+	hdr->tag = priv->cmd_tag;
+	hdr->ver = MESSAGING_VERSION_7;
+	hdr->command = cmd;
+	hdr->size = (uint8_t)(len / sizeof(uint32_t));
+
+	return err;
+}
+
+int ele_init_fw(struct device *dev)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	int ret;
+	unsigned int tag, command, size, ver, status;
+
+	ret = plat_fill_cmd_msg_hdr(priv,
+				    (struct mu_hdr *)&priv->tx_msg.header,
+				    ELE_INIT_FW_REQ, 4);
+	if (ret)
+		return ret;
+
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		return ret;
+
+	tag = MSG_TAG(priv->rx_msg.header);
+	command = MSG_COMMAND(priv->rx_msg.header);
+	size = MSG_SIZE(priv->rx_msg.header);
+	ver = MSG_VER(priv->rx_msg.header);
+	status = RES_STATUS(priv->rx_msg.data[0]);
+
+	if (tag == priv->rsp_tag
+		&& command == ELE_INIT_FW_REQ
+		&& size == ELE_INIT_FW_RSP_SZ
+		&& ver == MESSAGING_VERSION_7
+		&& status == priv->success_tag)
+		return 0;
+
+	return -EINVAL;
+}
diff --git a/drivers/firmware/imx/se_fw.c b/drivers/firmware/imx/se_fw.c
index 2c97b2adf18b..88300c41d62b 100644
--- a/drivers/firmware/imx/se_fw.c
+++ b/drivers/firmware/imx/se_fw.c
@@ -8,6 +8,7 @@
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/firmware/imx/ele_fw_api.h>
 #include <linux/firmware/imx/ele_base_msg.h>
 #include <linux/firmware/imx/ele_mu_ioctl.h>
 #include <linux/genalloc.h>
@@ -41,6 +42,7 @@ struct imx_info {
 	uint8_t *se_name;
 	uint8_t *pool_name;
 	bool reserved_dma_ranges;
+	bool init_fw;
 };
 
 static LIST_HEAD(priv_data_list);
@@ -55,6 +57,7 @@ static const struct imx_info imx8ulp_info = {
 	.se_name = "ele",
 	.pool_name = "sram-pool",
 	.reserved_dma_ranges = true,
+	.init_fw = false,
 };
 
 static const struct imx_info imx93_info = {
@@ -67,6 +70,7 @@ static const struct imx_info imx93_info = {
 	.se_name = "ele",
 	.pool_name = NULL,
 	.reserved_dma_ranges = true,
+	.init_fw = true,
 };
 
 static const struct of_device_id se_fw_match[] = {
@@ -1120,6 +1124,13 @@ static int se_fw_probe(struct platform_device *pdev)
 		priv->flags |= RESERVED_DMA_POOL;
 	}
 
+	if (info->init_fw) {
+		/* start initializing ele fw */
+		ret = ele_init_fw(dev);
+		if (ret)
+			dev_err(dev, "Failed to initialize ele fw.\n");
+	}
+
 	if (info->socdev) {
 		ret = imx_soc_device_register(dev, info);
 		if (ret) {
diff --git a/include/linux/firmware/imx/ele_fw_api.h b/include/linux/firmware/imx/ele_fw_api.h
new file mode 100644
index 000000000000..36c3f743cb38
--- /dev/null
+++ b/include/linux/firmware/imx/ele_fw_api.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2023 NXP
+ */
+
+#ifndef ELE_FW_API_H
+#define ELE_FW_API_H
+
+#include <linux/hw_random.h>
+
+#define MESSAGING_VERSION_7		0x7
+
+#define ELE_INIT_FW_REQ                 0x17
+#define ELE_INIT_FW_RSP_SZ              0x2
+
+
+int ele_init_fw(struct device *dev);
+
+#endif /* ELE_FW_API_H */
-- 
2.34.1

