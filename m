Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CD37851B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjHWHg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjHWHg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:36:58 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C66910DF;
        Wed, 23 Aug 2023 00:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4PRu9MRujcghO4TXi9VZ/NKg1lluVPzYJNf8a5NOWiw/IhMlSQNzJjn2Uiw1+Q+bAf5TTSGBLT/kDkM493yL05lZYM7OwXn5A/hYiIM04bxKWCOL41Ya35W+mVaKLnLAj3AEZ/b6qi3diipB0DUTKAGknPyHYkFMnz27m2cF/Tfd2nzew7EedlU3LBKbqLoSJS2+JRKGO4keF4bLQM3ukyyCqkXS9dlD2z3C4bCeaGmPzLDY/6i+cbXdiDZuPF07Li3fSTgPmZl6WmaKcwr29EhZZO9IdPCkxS2VC6Hy7Y2+t7iayxKcBprYz3InhT8sn/HfgKipDFH7+S0PXnbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwbxhYogTTlyjFr22CAQF423RwAB9WqQqlYkTnbhg6c=;
 b=dpR79kHXhhV5c+bzhKOdVCqs7gO9hp9r8qd099oqOYNm/VeIJM0MdIfB6tcpSXBz2b1UVQN6J8mSVcfp6AEMQ3biOlDdN7RERBqmJPTliGGUaq611jQauqLfOo58vxoQaMQHiduD6f1R7tr0gp+u8byFWcHvk7FzZ8aGNAzn9eI+s6F+RCxKNAtTl08cy0gJrI4Cqak83vlnqs7Q3xF2uFVnAUa9u0T8Jego3oELQFwCMo/9KzPHdw3qxZDnV4+mYYvSGufq9WTAwBnlPV65TRJVwqJ+f3Szxt5mldcuAC7fNJYCayZgpXyIuoV/2jFK0Wr6qg8DHP2EBBEjV219wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwbxhYogTTlyjFr22CAQF423RwAB9WqQqlYkTnbhg6c=;
 b=Eoadnx45ckLCkgdkgHPtcT95OP4NKFGJuqGGHi17Zql+ig0n4f9+eEvp6UwHEDjhiTh5FnuLZ3CVzTDfxFQvGe7iJqLz6bmWFqr2EF76BUkssqc1eaYiZyDOLcuOK/FUpuuT/FkmQPpRv4OynyB/7EQdBNM3r2wL8hZJFvHszOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 23 Aug
 2023 07:35:41 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:35:41 +0000
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
Subject: [PATCH v5 08/11] firmware: imx: enable trng
Date:   Wed, 23 Aug 2023 13:03:27 +0530
Message-Id: <20230823073330.1712721-9-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f48a805c-5b7f-46e9-b598-08dba3ab8d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EfROhX6AbHHm6ROv6UJNSlRo+FK/POaeobpC4H4QThEiLL6A/XWZu4R6NsMPXUp26yCL52kenkAPNsx8/aed9zAiQO6PZBwQ+UfUGqtaPENSkFcJGd2N0H0KlCfmFReKoY1yuhJgOfVgzR8rdWSO4bv6PhcopGxhB502+Wf5bBvwZr1hKjFZygEtxVP4a5HfIuCO++Nn0aZl64lmr6iymFEeMt99n2s4vBkxw0QFRzfRk3o0t+bGkkWrifKT1iIT4qz89uXfei9zji69SANFSfy+x+JKPJwn/jxsByQF9J4AkGLDLsI7P+NYyM9MRxG+vrKmsyG+1LlbsbsgZ9EYf5bZZGF67xMLX6HZgy0btVyfgOvaL+FYkYecXHD4CpXZvmjV9tjJedI6+feywEY/W6kdQPprmPzdvTx9kqGvYP/X8FBvQBPC5ACXeTVBt12n4AFAMyPeuV64v5GW1GPZ2sTqTit9KwggkLJ0Z97g+OdheapbKjnfwArclgLZmntwJL56sVMTfXyNn79GBRHkg2UyIf8M+dYQSOmcQTLAU6MA7FOSLvfBQ0zfaV6ZnYU0sKccHadZMZrWftP52kABX9b4eXR9bmUtZ7A0dhxnaBlzuHTMxb51t7Kf+jnRpCDEJzeIvHhl76bbRcT5b6m6HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(36756003)(86362001)(921005)(66476007)(66946007)(66556008)(316002)(41300700001)(6636002)(478600001)(38100700002)(38350700002)(6486002)(6512007)(6666004)(6506007)(52116002)(26005)(1076003)(8676002)(2616005)(2906002)(5660300002)(7416002)(44832011)(4326008)(8936002)(30864003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?35ZUzaf/aCWfcdA5G+z2GEbAVh40aTec5Rc3bthjDjJ6QunM+E/fLox+cO6D?=
 =?us-ascii?Q?RabOZnl3bqe0G+9BcEae05A24AJ7YkUD+K2WDcLpdxF8uPZUuxfnAkdkEEYQ?=
 =?us-ascii?Q?Ct96R4paAkoJOCTY+z0rjsDQ2HbVhK3UmwTIZNuvlFTGSoA+CMeKbXQD7//T?=
 =?us-ascii?Q?eTW2MaSGl7nW5asrLVrwdSka2tJ+5zqSkjnbZssibsZ9dljPSbWVgRYGAtpx?=
 =?us-ascii?Q?cSIj2YBMxKLOnIHirczD0ONKHdJMfMfOHbz6rrKzO99QtBbpaCR4dgyQMGPk?=
 =?us-ascii?Q?XPkx29rdB9zpbt+0MkKP9hFcU9H0N1NpU4cK/Q7gb1ydXOZ2LcchEY8a9iS5?=
 =?us-ascii?Q?B2lLh3lbYtxjvgP3MXrHtEXGp7S8MVP1rrbcGVeSZrsCiM168Z7XTdmP5DmX?=
 =?us-ascii?Q?y/sQZyfh5dUX7zsW2O4H4g9Xq6Uil5qzsMu8oPSKTvIlr6e+lmsbYS/aZqY7?=
 =?us-ascii?Q?H1vzkK0OCwCb5EBndSd0WxT5CEeoR3uLMkQG+Uq6IqBA1WLurLdhw83oIk8C?=
 =?us-ascii?Q?wZf1mVZzYtzQtkdR+cnKN6Q7W1Ll7DgvE8iyaD30DOm0YvhyFQIRokhtwciL?=
 =?us-ascii?Q?Ww81PKck2X/Xg3RC4/65Cx20s7pM/ZMhVZ7wF523MebhUtHeuHKqOjsis5Te?=
 =?us-ascii?Q?oSoPKK1WDZRLD9qCVfFq/70QUrNSqAXdjURmVOI5lR4tAkHl2yIkqhm6zxHW?=
 =?us-ascii?Q?O76NzAxy0k3M/R7pySWLHbc5RpLl6FTAEG52d59yK6wFTYRYpwXv+lJ0FxtL?=
 =?us-ascii?Q?1p4PvBjg6vCZ5mlfCRhg+fuJhGcVKBqqxUNptjyWpYZmoXwgFV9WP6DJTrLY?=
 =?us-ascii?Q?UV/9WUHT5+GM+4Yf37wzgTnYvJ9ubqFtoWCA0fFsIJoQAwytUQAEhKEhbjkK?=
 =?us-ascii?Q?0etzCB/YFR/9C8ywyqZhhMREZNpaAWRcI1Hlj5bfeJcCkNdYKI0PMTT9QSPZ?=
 =?us-ascii?Q?rUdEk18zE+4TkTeJmyhAx9i6ipS2Xe6egOSRV2wxNly57YVR8xZQvmrmBwGt?=
 =?us-ascii?Q?bBcKxMhnwtsWnyX89no91cQ4jPi/fa937lbgBLLmIGIt8P7H1J8HbG/h/Y/V?=
 =?us-ascii?Q?lPHTZQRI4RpawxeTqFnA0CY48YRTC1bhGUIlSJhAr12c8xNzCwzld1lTPgj3?=
 =?us-ascii?Q?tDDB1C6cNcnnpOt2wqByZIWRbzxUDH+dHICZhtz1cXNroaRBdYK2TLx2O2n+?=
 =?us-ascii?Q?bFVTGvHL+Oe+am70ADCBkBGhg9c3VlZDtnu3MCOi/1uqTsYnONk34AyNFaKz?=
 =?us-ascii?Q?RPsJ1zywWGuKYL8rlpKXgk/wEHhGRf8EH94qdLk5ddiD13pTSzY03CbEuwOs?=
 =?us-ascii?Q?iLsnmnEptNuT7O+4E9pXffOKwM+18ZGoiKgBnHmHkrjfVqM4gjMmDpyayK9w?=
 =?us-ascii?Q?Ln3WBQ3wwwG7IELl2ZInPdsXej3HjL493ooCQq8bCYtKxKIuGcEp0GgxBdTK?=
 =?us-ascii?Q?IfRpNxYGnEGXinVNyeHv0MuvxfBQU+hkwt+QCywM9D2HSU1WQ013Sp2oBZnA?=
 =?us-ascii?Q?ypl7jEACSjD3H5skI77ybUqWFK+cMML050Dqa0mm5Jw+TwzzDmmP7goxJzW0?=
 =?us-ascii?Q?x8P9ItTQXlkUrbKf19tjcMPMk78U0moZyD46P+Z0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48a805c-5b7f-46e9-b598-08dba3ab8d31
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:35:40.9726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fpMsX41Kx/5yode2BhmLMozEcxCG9BjgFXGUn7mnoZQ9NC6uhoMgw5xq7FloXghR0Q8I2bNV9lThoY6VcRkYA==
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

Enabled trng on imx93 platform through enclave fw.

Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/firmware/imx/Kconfig              |  9 +++
 drivers/firmware/imx/Makefile             |  3 +-
 drivers/firmware/imx/ele_base_msg.c       | 88 +++++++++++++++++++++++
 drivers/firmware/imx/ele_common.c         | 44 +++++++++++-
 drivers/firmware/imx/ele_common.h         |  2 +
 drivers/firmware/imx/ele_fw_api.c         | 54 ++++++++++++++
 drivers/firmware/imx/ele_trng.c           | 48 +++++++++++++
 drivers/firmware/imx/se_fw.c              | 23 +++++-
 include/linux/firmware/imx/ele_base_msg.h | 11 +++
 include/linux/firmware/imx/ele_fw_api.h   |  5 ++
 10 files changed, 283 insertions(+), 4 deletions(-)
 create mode 100644 drivers/firmware/imx/ele_trng.c

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 2822e5d4b24c..ffc02593293c 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -40,3 +40,12 @@ config IMX_SEC_ENCLAVE
           like base, HSM, V2X & SHE using the SAB protocol via the shared Messaging
           Unit. This driver exposes these interfaces via a set of file descriptors
           allowing to configure shared memory, send and receive messages.
+
+config IMX_ELE_TRNG
+	tristate "i.MX ELE True Random Number Generator"
+	default y
+	select CRYPTO_RNG
+	select HW_RANDOM
+	help
+	  This driver provides kernel-side support for the Random Number generation,
+          through NXP hardware IP for secure-enclave called EdgeLock Enclave.
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index bc6ed5514a19..e46f3053707f 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -2,5 +2,6 @@
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
-sec_enclave-objs		= se_fw.o ele_common.o ele_base_msg.o ele_fw_api.o
+sec_enclave-objs		= ele_common.o se_fw.o ele_base_msg.o ele_fw_api.o
 obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
+sec_enclave-${CONFIG_IMX_ELE_TRNG} += ele_trng.o
diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
index 2eb675a1b389..c42e29e14662 100644
--- a/drivers/firmware/imx/ele_base_msg.c
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -60,3 +60,91 @@ int ele_get_info(struct device *dev, phys_addr_t addr, u32 data_size)
 
 	return -EINVAL;
 }
+
+/*
+ * ele_get_trng_state() - prepare and send the command to read
+ *                        crypto lib and TRNG state
+ * TRNG state
+ *  0x1		TRNG is in program mode
+ *  0x2		TRNG is still generating entropy
+ *  0x3		TRNG entropy is valid and ready to be read
+ *  0x4		TRNG encounter an error while generating entropy
+ *
+ * CSAL state
+ *  0x0		Crypto Lib random context initialization is not done yet
+ *  0x1		Crypto Lib random context initialization is on-going
+ *  0x2		Crypto Lib random context initialization succeed
+ *  0x3		Crypto Lib random context initialization failed
+ *
+ * returns: csal and trng state.
+ *
+ */
+int ele_get_trng_state(struct device *dev)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	int ret;
+	unsigned int tag, command, size, ver, status;
+
+	ret = plat_fill_cmd_msg_hdr(priv,
+				    (struct mu_hdr *)&priv->tx_msg.header,
+				    ELE_GET_TRNG_STATE_REQ, 4);
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
+	if (tag == priv->rsp_tag &&
+	    command == ELE_GET_TRNG_STATE_REQ &&
+	    size == ELE_GET_TRNG_STATE_REQ_MSG_SZ &&
+	    ver == ELE_BASE_API_VERSION &&
+	    status == priv->success_tag) {
+		return (priv->rx_msg.data[1] & CSAL_TRNG_STATE_MASK);
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * ele_start_rng() - prepare and send the command to start
+ *                   initialization of the ELE RNG context
+ *
+ * returns:  0 on success.
+ */
+int ele_start_rng(struct device *dev)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	int ret;
+	unsigned int tag, command, size, ver, status;
+
+	ret = plat_fill_cmd_msg_hdr(priv,
+				    (struct mu_hdr *)&priv->tx_msg.header,
+				    ELE_START_RNG_REQ, 4);
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
+	if (tag == priv->rsp_tag &&
+	    command == ELE_START_RNG_REQ &&
+	    size == ELE_START_RNG_REQ_MSG_SZ &&
+	    ver == ELE_BASE_API_VERSION &&
+	    status == priv->success_tag) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index 08adc7200ceb..f01e5e3255f9 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -1,9 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2021-2023 NXP
+ * Copyright 2023 NXP
  */
 
-#include "se_fw.h"
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/firmware/imx/ele_base_msg.h>
+
+#include "ele_common.h"
 
 int imx_ele_msg_send_rcv(struct ele_mu_priv *priv)
 {
@@ -32,3 +36,39 @@ int imx_ele_msg_send_rcv(struct ele_mu_priv *priv)
 	return err;
 }
 
+int ele_do_start_rng(struct device *dev)
+{
+	int ret;
+	int count = ELE_GET_TRNG_STATE_RETRY_COUNT;
+
+	ret = ele_get_trng_state(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get trng state\n");
+		return ret;
+	} else if (ret != ELE_TRNG_STATE_OK) {
+		/* call start rng */
+		ret = ele_start_rng(dev);
+		if (ret) {
+			dev_err(dev, "Failed to start rng\n");
+			return ret;
+		}
+
+		/* poll get trng state API, ELE_GET_TRNG_STATE_RETRY_COUNT times
+		 * or while trng state != 0x203
+		 */
+		do {
+			msleep(10);
+			ret = ele_get_trng_state(dev);
+			if (ret < 0) {
+				dev_err(dev, "Failed to get trng state\n");
+				return ret;
+			}
+			count--;
+		} while ((ret != ELE_TRNG_STATE_OK) && count);
+		if (ret != ELE_TRNG_STATE_OK)
+			return -EIO;
+	}
+
+	return 0;
+}
+
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index 6af0296b76fd..ed68e5cf9638 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -18,4 +18,6 @@ static inline int ele_trng_init(struct device *dev)
 	return 0;
 }
 #endif
+
+int ele_do_start_rng(struct device *dev);
 #endif
diff --git a/drivers/firmware/imx/ele_fw_api.c b/drivers/firmware/imx/ele_fw_api.c
index 1df1fbcb6d9e..8e0b331531a2 100644
--- a/drivers/firmware/imx/ele_fw_api.c
+++ b/drivers/firmware/imx/ele_fw_api.c
@@ -54,3 +54,57 @@ int ele_init_fw(struct device *dev)
 
 	return -EINVAL;
 }
+
+/*
+ * ele_get_random() - prepare and send the command to proceed
+ *                    with a random number generation operation
+ *
+ * returns:  size of the rondom number generated
+ */
+int ele_get_random(struct device *dev,
+		   void *data, size_t len)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	unsigned int tag, command, size, ver, status;
+	dma_addr_t dst_dma;
+	u8 *buf;
+	int ret;
+
+	buf = dmam_alloc_coherent(priv->dev, len, &dst_dma, GFP_KERNEL);
+	if (!buf) {
+		dev_err(priv->dev, "Failed to map destination buffer memory\n");
+		return -ENOMEM;
+	}
+
+	ret = plat_fill_cmd_msg_hdr(priv,
+				    (struct mu_hdr *)&priv->tx_msg.header,
+				    ELE_GET_RANDOM_REQ, 16);
+	if (ret)
+		goto exit;
+
+	priv->tx_msg.data[0] = 0x0;
+	priv->tx_msg.data[1] = dst_dma;
+	priv->tx_msg.data[2] = len;
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		goto exit;
+
+	tag = MSG_TAG(priv->rx_msg.header);
+	command = MSG_COMMAND(priv->rx_msg.header);
+	size = MSG_SIZE(priv->rx_msg.header);
+	ver = MSG_VER(priv->rx_msg.header);
+	status = RES_STATUS(priv->rx_msg.data[0]);
+	if (tag == priv->rsp_tag
+		&& command == ELE_GET_RANDOM_REQ
+		&& size == ELE_GET_RANDOM_REQ_SZ
+		&& ver == MESSAGING_VERSION_7
+		&& status == priv->success_tag) {
+		memcpy(data, buf, len);
+		ret = len;
+	} else
+		ret = -EINVAL;
+
+exit:
+	dmam_free_coherent(priv->dev, len, buf, dst_dma);
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_trng.c b/drivers/firmware/imx/ele_trng.c
new file mode 100644
index 000000000000..23d5891f9569
--- /dev/null
+++ b/drivers/firmware/imx/ele_trng.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ELE Random Number Generator Driver NXP's Platforms
+ *
+ * Copyright 2023 NXP
+ */
+
+#include <linux/firmware/imx/ele_fw_api.h>
+
+#include "ele_common.h"
+
+struct ele_trng {
+	struct hwrng rng;
+	struct device *dev;
+};
+
+int ele_trng_init(struct device *dev)
+{
+	struct ele_trng *trng;
+	int ret;
+
+	trng = devm_kzalloc(dev, sizeof(*trng), GFP_KERNEL);
+	if (!trng)
+		return -ENOMEM;
+
+	trng->dev         = dev;
+	trng->rng.name    = "ele-trng";
+	trng->rng.read    = ele_get_hwrng;
+	trng->rng.priv    = (unsigned long)trng;
+	trng->rng.quality = 1024;
+
+	dev_dbg(dev, "registering ele-trng\n");
+
+	ret = devm_hwrng_register(dev, &trng->rng);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "Successfully registered ele-trng\n");
+	return 0;
+}
+
+int ele_get_hwrng(struct hwrng *rng,
+		  void *data, size_t len, bool wait)
+{
+	struct ele_trng *trng = (struct ele_trng *)rng->priv;
+
+	return ele_get_random(trng->dev, data, len);
+}
diff --git a/drivers/firmware/imx/se_fw.c b/drivers/firmware/imx/se_fw.c
index 88300c41d62b..6083c42dcda3 100644
--- a/drivers/firmware/imx/se_fw.c
+++ b/drivers/firmware/imx/se_fw.c
@@ -21,10 +21,10 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/delay.h>
 #include <linux/sys_soc.h>
 
 #include "se_fw.h"
+#include "ele_common.h"
 
 #define SOC_ID_OF_IMX8ULP		0x084D
 #define SOC_ID_OF_IMX93			0x9300
@@ -43,6 +43,9 @@ struct imx_info {
 	uint8_t *pool_name;
 	bool reserved_dma_ranges;
 	bool init_fw;
+	/* platform specific flag to enable/disable the ELE True RNG */
+	bool start_rng;
+	bool enable_ele_trng;
 };
 
 static LIST_HEAD(priv_data_list);
@@ -58,6 +61,8 @@ static const struct imx_info imx8ulp_info = {
 	.pool_name = "sram-pool",
 	.reserved_dma_ranges = true,
 	.init_fw = false,
+	.start_rng = true,
+	.enable_ele_trng = false,
 };
 
 static const struct imx_info imx93_info = {
@@ -71,6 +76,8 @@ static const struct imx_info imx93_info = {
 	.pool_name = NULL,
 	.reserved_dma_ranges = true,
 	.init_fw = true,
+	.start_rng = true,
+	.enable_ele_trng = true,
 };
 
 static const struct of_device_id se_fw_match[] = {
@@ -1140,9 +1147,23 @@ static int se_fw_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* start ele rng */
+	if (info->start_rng) {
+		ret = ele_do_start_rng(dev);
+		if (ret)
+			dev_err(dev, "Failed to start ele rng\n");
+	}
+
+	if (!ret && info->enable_ele_trng) {
+		ret = ele_trng_init(dev);
+		if (ret)
+			dev_err(dev, "Failed to init ele-trng\n");
+	}
+
 	pr_info("i.MX secure-enclave: %s's mu#%d interface to firmware, configured.\n",
 		info->se_name,
 		priv->ele_mu_id);
+
 	return devm_of_platform_populate(dev);
 
 exit:
diff --git a/include/linux/firmware/imx/ele_base_msg.h b/include/linux/firmware/imx/ele_base_msg.h
index 9c05936ba813..8a5c385210fc 100644
--- a/include/linux/firmware/imx/ele_base_msg.h
+++ b/include/linux/firmware/imx/ele_base_msg.h
@@ -28,10 +28,21 @@
 #define ELE_GET_INFO_REQ                0xDA
 #define ELE_GET_INFO_REQ_MSG_SZ		0x02
 
+#define ELE_START_RNG_REQ		0xA3
+#define ELE_START_RNG_REQ_MSG_SZ	0x02
+
+#define ELE_GET_TRNG_STATE_REQ		0xA4
+#define ELE_GET_TRNG_STATE_REQ_MSG_SZ	0x03
+#define ELE_TRNG_STATE_OK		0x203
+#define ELE_GET_TRNG_STATE_RETRY_COUNT	0x5
+#define CSAL_TRNG_STATE_MASK		0x0000ffff
+
 #define ELE_BASE_API_VERSION		0x6
 #define ELE_SUCCESS_IND			0xD6
 #define ELE_FAILURE_IND			0x29
 
 int ele_get_info(struct device *dev, phys_addr_t addr, u32 data_size);
+int ele_start_rng(struct device *dev);
+int ele_get_trng_state(struct device *dev);
 
 #endif
diff --git a/include/linux/firmware/imx/ele_fw_api.h b/include/linux/firmware/imx/ele_fw_api.h
index 36c3f743cb38..5e640148e211 100644
--- a/include/linux/firmware/imx/ele_fw_api.h
+++ b/include/linux/firmware/imx/ele_fw_api.h
@@ -13,7 +13,12 @@
 #define ELE_INIT_FW_REQ                 0x17
 #define ELE_INIT_FW_RSP_SZ              0x2
 
+#define ELE_GET_RANDOM_REQ		0xCD
+#define ELE_GET_RANDOM_REQ_SZ		0x2
+
 
 int ele_init_fw(struct device *dev);
+int ele_get_random(struct device *dev, void *data, size_t len);
+int ele_get_hwrng(struct hwrng *rng, void *data, size_t len, bool wait);
 
 #endif /* ELE_FW_API_H */
-- 
2.34.1

