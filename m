Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FA37B040F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjI0M1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjI0M1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:27:31 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2091CCF0;
        Wed, 27 Sep 2023 05:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW9M9tONnwQSCFhh9MCpwVrjV8sm5Nkh/fKDcux6JlpshkOFnCKmvTIbTi0O8P19UB/C+fjLpcprdh3LYGSROwXWK9igaPH18wVVCvCvEY6SXwmS3+OnVyV5Ye+nwkVHZPp6wQPJDVLtaZ5QiDBgTSD+wKOMX2i6DNoe8uOjlyOJxe646K1B461Vf/UTGQ8s0v8Wc1oHP6CNAb0KQa60BRr9WWsJbZ+zMqliScYtc3u15u5+jcbFZs2+fyPvVchzxuF+QXQBYuDkVnSojoEfyzovYh0m5Sa2jGZHTnSNMdPPTMJdluMi9YSaRGw/LA30HPMvXu4Xu0NVQq3q0gEl/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YK8Ce2sPN4PvhEO31Wk1kFV2ywQ6aCtnoachpsl9dQA=;
 b=LyeojhQRcFeCBAIOdmF+yGsmaKpxnx/7EF8rORxSGhS31Z3lU1RzEC/zi48BQUKK8QAIJ9XUtDYu8Jov8PGFb71VyUmK/Zm4DcSbN3iFAkidPAbfErscD2zomz0l3be4OIR0+cZUQBsRn7NOi7gMN+HFVbM/JMih7MHFsHBYeKxybHCm3dn59fR7iT8BRzqtQu0Wt4OExZlR1QxcA16VnDUOMiel4MmWfEEGKpXZ0+A8b0Nkb4eoNaQO0uH95DxFM+m2vbzLeQwizhZpQrKv/JbTZ84BUcdDxH9n4ezsq64L1UjWgI/Vcbnd+SUZjBoJi8JKzVBZOM8Jui5jIwEG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK8Ce2sPN4PvhEO31Wk1kFV2ywQ6aCtnoachpsl9dQA=;
 b=pW2ea/l7AJsyWs4m6jgC/7L5BcxMvtM4YXkMU7282ydOsj9u9ZFZL3Q0mz1LoCZP2EkqoFKn5f6tktyKw1hRODy7HI4/jcgfYB0p5hCecXCMvJ3izWsYBEafY3wip8v602FKlVAS79K0/ZyWLETgLxq/0I9UNxdMXRK1stkCnNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8181.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:27:15 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:27:15 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v6 09/11] firmware: imx: enable trng
Date:   Wed, 27 Sep 2023 23:23:59 +0530
Message-Id: <20230927175401.1962733-10-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
References: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 36486cd2-55ec-423f-5e41-08dbbf551538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Yosj9pHvmeZIknWVTH86Dz/FZe/qp0k5KxoJ5RwpnlJediibCdkIUM8pNLrpIDqcio+Xs1Wkp1BHPSklAJuzLPYyejJoCwFFObQj1fGdTAZDEm7YyfGkufQV+gdswRkGkYGYhB6ooj3yWiXq9TIl618yGi/NV7fGVR/qXPjmsq21wYqzZXvQtN/CtzzpJHVPPvCTHU/MGjDZUb0E/X1tCaFkHBmi/irwhkTn3ZVipY0FmuJlcy30es5+xau1WNKDom4/vvMSIDBAHc/FMmvS1NQQ2FGtkEKBbsgBaXIOcia+wyAjs9D9DRmBjETGfX74mygGrn12Ky2bPG8gKdftMhlhmkv/QQztZy7JYSa3H2pd9A0g46wF01Q1ZzxLozlA9eEIgTAv+b6MsbS1+36iEdFJiifxaplTMJQoxeLvGl9XhxseXnDBYBFFnD7ZeM/NBY+cd1bZTwDZY+ZywntoACsH+dk0faWLvdvuLF6L4lD6PWU1u7u2pF+uCqqZMdIlybCNSLKnmTgdFu+ejwrh7dt1HaMpcfgiMm4cwuV23V8jE9rUYY7RxMvyFNlsrKqdduoOqqPE7NbcNECXsActSG3JL2BiFXuqLEzV/hXATrB0tKAWB5b2KOohdsAG8M2S1FanVpE5M5LGzZaSXRltQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(7416002)(5660300002)(316002)(921005)(83380400001)(44832011)(41300700001)(6636002)(30864003)(8676002)(8936002)(36756003)(2616005)(66946007)(4326008)(86362001)(1076003)(6666004)(6486002)(6512007)(52116002)(6506007)(66476007)(66556008)(26005)(2906002)(38350700002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d0lIcGdWWanKwXq2MCj9UdSrGqxnXXBDiDGliwUh1ppRmz35GBbYfQOlKc+/?=
 =?us-ascii?Q?M1yoFNRNI2Pc8fFMFSEN3qb6iN3Y4iVfVpe4ENX/QNDRbMmctHKkAY+Gbnsk?=
 =?us-ascii?Q?+mdMoE6o88SH2UE9plN5LBUX63R5M+Ih3DLMOpn9QON9I35k473HyR8JQATy?=
 =?us-ascii?Q?OX0eVJUvrtYF81tBGwmeWqpZnRI/I/JCRU446t5QzKkXM1tkkWS7ijIAtv8s?=
 =?us-ascii?Q?rhl+/b2Ygs7GBI5EoXum9RSEaocCRrUTuBc4sgFwcEGl5qq9itkjLL1lyGxF?=
 =?us-ascii?Q?RCF58CeS8qY4nO7h6WjT/I5+7TzGkjslDlryLrW3IpLS5rK2i/BZ1Wu0Sbz/?=
 =?us-ascii?Q?sUS7/1qmd9LXwxmjAfRakCEDccimXNHExHt0yE+DV4AIpNu7VkVkngWEc3cj?=
 =?us-ascii?Q?aeh2I+WA7nzoW3l86mK86sr4Pstzw8DY2gpxV7SwYzc0gfwftLXu3kcqU9fO?=
 =?us-ascii?Q?v2FIEJrX/GyoGy8BGzkZF2xtvONd62mLMHgl0nY0SkK77mgzdV0pNdNzqvH6?=
 =?us-ascii?Q?drwAs4K7HXojj4EfqPbB8XAxL5HWOJf2UGByfcQKvevd8he4Z6NNKsQaDV+w?=
 =?us-ascii?Q?OYMWGZ0iwpSnny/RmKEfi9jix+ZKf7ON2n/UrQ4Gsl68AEFwEsRd2P5FqnVg?=
 =?us-ascii?Q?0TVV+gExBgSuWLDbdZ1M5ytIJ+VcFv1XL53ZedsVtNhWZISA+VZchp4G987B?=
 =?us-ascii?Q?ifXgOeA8nXkVKpAb1a5SOhKfbT4k+t1mAAaiJIe3tqavG7LyBLCACj1/icyd?=
 =?us-ascii?Q?3Gn0bfQ3hFy6gYOhbkqmGJT3SFU+0qsK7femBv1VrhDvS06Xw3jz0ixTeV9/?=
 =?us-ascii?Q?XrMfDmFAHhtAjBUmPaCa6hUDGpx3jAchuaomFpYH+Sx5I+8yqknrH8k2VFLP?=
 =?us-ascii?Q?Dfq5oya9XuQIcQagodV1lT/3pSkoWsBgf3JRaBXmG3hk8rqxzi3hJKek/NIy?=
 =?us-ascii?Q?cFIunqGVH5uW7MjOHNwc4QWVx2kC61DqBEhJYwk3RJaG1t2BeaSzCdbmXAf+?=
 =?us-ascii?Q?j2nT/N8T0LAOGIkIAUkj+bx/7+NNT923MbuNksr1aICuqchil+JNnTkOfRbm?=
 =?us-ascii?Q?+ij92p/bXra0enmOwvHDa+gE9cIDtNWTBXawCVWy5GBlyeaTywNjRRQd/MJZ?=
 =?us-ascii?Q?yTD/q7E01Q+yxU2UmE1DLoIFEnrYDfe0FtxizXePzMThQEKlLaXvVaJZnBug?=
 =?us-ascii?Q?F7U2XN88xgCPkeKjvWATHCF4msy9o5+IR8cG4DO16NaNHIeThII9NMbXeeNf?=
 =?us-ascii?Q?+8HFN+ssugahwQjuEG54LJHpPlu/uQxpYL8I038JtSsq4i/H3HUhoA9i1rze?=
 =?us-ascii?Q?dwCp4jl1nXDuNhCXthYLF9M0Tg5/JDuCEeEgijwDCz+bsZSXieXV6S8hBSx0?=
 =?us-ascii?Q?LFWnJ83I7a+CuUeQF8rONlRcHeZoo6wldQo29gxHLWgfhNPg6xEooXW1bJkS?=
 =?us-ascii?Q?xa6paOiYgqsyGaL2dwhoFaR+JjlWX6gX6b1WJBN8aIskb/XTc+2jNVlTsA1I?=
 =?us-ascii?Q?t6M7qQu8i2xOLYC/OgMaDN1phrQBkhVY/16YZD84dqBXcYYOzE21fqUhYH0A?=
 =?us-ascii?Q?NNjEfSQxOuJjIB+IS6kVkM/Xs86y/HsfzbK6gWZD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36486cd2-55ec-423f-5e41-08dbbf551538
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:27:15.3998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KO7ZyQpEbEYqNdJD5zgCsGufE4UdpjIUoS8LQ3qK7eRNxr7EKnQKgsnyWhAxi0c/JKD+SCBfXyPQShIbNccsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8181
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabled trng on imx93 platform through enclave fw.

Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/firmware/imx/Kconfig              |   9 ++
 drivers/firmware/imx/Makefile             |   1 +
 drivers/firmware/imx/ele_base_msg.c       | 117 ++++++++++++++++++++++
 drivers/firmware/imx/ele_common.c         |  40 ++++++++
 drivers/firmware/imx/ele_common.h         |   2 +
 drivers/firmware/imx/ele_fw_api.c         |  67 +++++++++++++
 drivers/firmware/imx/ele_fw_api.h         |   6 ++
 drivers/firmware/imx/ele_trng.c           |  47 +++++++++
 drivers/firmware/imx/se_fw.c              |  23 ++++-
 include/linux/firmware/imx/ele_base_msg.h |  13 +++
 10 files changed, 324 insertions(+), 1 deletion(-)
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
index d61f06a8050a..9018f7824f36 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 sec_enclave-objs		= se_fw.o ele_common.o ele_base_msg.o ele_fw_api.o
 obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
+sec_enclave-${CONFIG_IMX_ELE_TRNG} += ele_trng.o
diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
index 813f769f7bc3..3a3af2321f67 100644
--- a/drivers/firmware/imx/ele_base_msg.c
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -99,3 +99,120 @@ int ele_ping(struct device *dev)
 
 	return ret;
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
+	unsigned int status;
+
+	ret = imx_se_alloc_tx_rx_buf(priv);
+	if (ret)
+		return ret;
+
+	ret = plat_fill_cmd_msg_hdr(priv,
+				    (struct mu_hdr *)&priv->tx_msg->header,
+				    ELE_GET_TRNG_STATE_REQ,
+				    ELE_GET_TRNG_STATE_REQ_MSG_SZ,
+				    true);
+	if (ret) {
+		pr_err("Error: plat_fill_cmd_msg_hdr failed.\n");
+		goto exit;
+	}
+
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret)
+		goto exit;
+
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		goto exit;
+
+	ret  = validate_rsp_hdr(priv,
+				priv->rx_msg->header,
+				ELE_GET_TRNG_STATE_REQ,
+				ELE_GET_TRNG_STATE_RSP_MSG_SZ,
+				true);
+	if (ret)
+		goto exit;
+
+	status = RES_STATUS(priv->rx_msg->data[0]);
+	if (status != priv->success_tag) {
+		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
+			ELE_GET_TRNG_STATE_REQ, status);
+		ret = -1;
+	} else
+		ret = (priv->rx_msg->data[1] & CSAL_TRNG_STATE_MASK);
+
+exit:
+	imx_se_free_tx_rx_buf(priv);
+
+	return ret;
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
+	unsigned int status;
+
+	ret = imx_se_alloc_tx_rx_buf(priv);
+	if (ret)
+		return ret;
+
+	ret = plat_fill_cmd_msg_hdr(priv,
+				    (struct mu_hdr *)&priv->tx_msg->header,
+				    ELE_START_RNG_REQ,
+				    ELE_START_RNG_REQ_MSG_SZ,
+				    true);
+	if (ret)
+		goto exit;
+
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		goto exit;
+
+	ret  = validate_rsp_hdr(priv,
+				priv->rx_msg->header,
+				ELE_START_RNG_REQ,
+				ELE_START_RNG_RSP_MSG_SZ,
+				true);
+	if (ret)
+		goto exit;
+
+	status = RES_STATUS(priv->rx_msg->data[0]);
+	if (status != priv->success_tag) {
+		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
+			ELE_START_RNG_REQ, status);
+		ret = -1;
+	}
+
+exit:
+	imx_se_free_tx_rx_buf(priv);
+
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index 4410245a19ec..d4b829c19133 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -3,6 +3,10 @@
  * Copyright 2023 NXP
  */
 
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/firmware/imx/ele_base_msg.h>
+
 #include "ele_common.h"
 #include "se_fw.h"
 
@@ -137,3 +141,39 @@ int validate_rsp_hdr(struct ele_mu_priv *priv, unsigned int header,
 
 	return ret;
 }
+
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
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index 284b7f66d8e3..f9e1d949dc6a 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -27,4 +27,6 @@ static inline int ele_trng_init(struct device *dev)
 	return 0;
 }
 #endif
+
+int ele_do_start_rng(struct device *dev);
 #endif
diff --git a/drivers/firmware/imx/ele_fw_api.c b/drivers/firmware/imx/ele_fw_api.c
index 55dda9d6531a..d195a920b3ee 100644
--- a/drivers/firmware/imx/ele_fw_api.c
+++ b/drivers/firmware/imx/ele_fw_api.c
@@ -49,3 +49,70 @@ int ele_init_fw(struct device *dev)
 
 	return ret;
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
+	unsigned int status;
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
+	ret = imx_se_alloc_tx_rx_buf(priv);
+	if (ret) {
+		ret = -ENOMEM;
+		goto exit1;
+	}
+
+	ret = plat_fill_cmd_msg_hdr(priv,
+				    (struct mu_hdr *)&priv->tx_msg->header,
+				    ELE_GET_RANDOM_REQ, ELE_GET_RANDOM_REQ_SZ,
+				    false);
+	if (ret)
+		goto exit;
+
+	priv->tx_msg->data[0] = 0x0;
+	priv->tx_msg->data[1] = dst_dma;
+	priv->tx_msg->data[2] = len;
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		goto exit;
+
+	ret  = validate_rsp_hdr(priv,
+				priv->rx_msg->header,
+				ELE_GET_RANDOM_REQ,
+				ELE_GET_RANDOM_RSP_SZ,
+				false);
+	if (ret)
+		return ret;
+
+	status = RES_STATUS(priv->rx_msg->data[0]);
+	if (status != priv->success_tag) {
+		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
+			ELE_GET_RANDOM_REQ, status);
+		ret = -1;
+	} else {
+		memcpy(data, buf, len);
+		ret = len;
+	}
+
+exit:
+	imx_se_free_tx_rx_buf(priv);
+exit1:
+	dmam_free_coherent(priv->dev, len, buf, dst_dma);
+
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_fw_api.h b/drivers/firmware/imx/ele_fw_api.h
index 21bb35b4041f..70cd8cf5074b 100644
--- a/drivers/firmware/imx/ele_fw_api.h
+++ b/drivers/firmware/imx/ele_fw_api.h
@@ -14,7 +14,13 @@
 #define ELE_INIT_FW_REQ_SZ              0x04
 #define ELE_INIT_FW_RSP_SZ              0x08
 
+#define ELE_GET_RANDOM_REQ		0xCD
+#define ELE_GET_RANDOM_REQ_SZ		0x10
+#define ELE_GET_RANDOM_RSP_SZ		0x08
+
 
 int ele_init_fw(struct device *dev);
+int ele_get_random(struct device *dev, void *data, size_t len);
+int ele_get_hwrng(struct hwrng *rng, void *data, size_t len, bool wait);
 
 #endif /* ELE_FW_API_H */
diff --git a/drivers/firmware/imx/ele_trng.c b/drivers/firmware/imx/ele_trng.c
new file mode 100644
index 000000000000..4a7a119ff435
--- /dev/null
+++ b/drivers/firmware/imx/ele_trng.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ELE Random Number Generator Driver NXP's Platforms
+ *
+ * Copyright 2023 NXP
+ */
+
+#include "ele_common.h"
+#include "ele_fw_api.h"
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
index c225cdc016be..b2ac00b3ac7d 100644
--- a/drivers/firmware/imx/se_fw.c
+++ b/drivers/firmware/imx/se_fw.c
@@ -20,10 +20,10 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/delay.h>
 #include <linux/sys_soc.h>
 
 #include "se_fw.h"
+#include "ele_common.h"
 #include "ele_fw_api.h"
 
 #define SOC_ID_OF_IMX8ULP		0x084D
@@ -48,6 +48,9 @@ struct imx_info {
 	uint8_t *pool_name;
 	bool reserved_dma_ranges;
 	bool init_fw;
+	/* platform specific flag to enable/disable the ELE True RNG */
+	bool start_rng;
+	bool enable_ele_trng;
 };
 
 struct imx_info_list {
@@ -76,6 +79,8 @@ static const struct imx_info_list imx8ulp_info = {
 				.pool_name = "fsl,sram",
 				.reserved_dma_ranges = true,
 				.init_fw = false,
+				.start_rng = true,
+				.enable_ele_trng = false,
 			},
 	},
 };
@@ -99,6 +104,8 @@ static const struct imx_info_list imx93_info = {
 				.pool_name = NULL,
 				.reserved_dma_ranges = true,
 				.init_fw = true,
+				.start_rng = true,
+				.enable_ele_trng = true,
 			},
 	},
 };
@@ -1252,9 +1259,23 @@ static int se_fw_probe(struct platform_device *pdev)
 	if (ret)
 		dev_err(dev, "Failed[%d] to ping the fw.\n", ret);
 
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
 	dev_info(dev, "i.MX secure-enclave: %s's mu#%d interface to firmware, configured.\n",
 		info->se_name,
 		priv->ele_mu_id);
+
 	return devm_of_platform_populate(dev);
 
 exit:
diff --git a/include/linux/firmware/imx/ele_base_msg.h b/include/linux/firmware/imx/ele_base_msg.h
index 49e3619372be..3ca4b47e4c4e 100644
--- a/include/linux/firmware/imx/ele_base_msg.h
+++ b/include/linux/firmware/imx/ele_base_msg.h
@@ -34,7 +34,20 @@
 #define ELE_PING_REQ_SZ			0x04
 #define ELE_PING_RSP_SZ			0x08
 
+#define ELE_START_RNG_REQ		0xA3
+#define ELE_START_RNG_REQ_MSG_SZ	0x04
+#define ELE_START_RNG_RSP_MSG_SZ	0x08
+
+#define ELE_GET_TRNG_STATE_REQ		0xA4
+#define ELE_GET_TRNG_STATE_REQ_MSG_SZ	0x04
+#define ELE_GET_TRNG_STATE_RSP_MSG_SZ	0x0C
+#define ELE_TRNG_STATE_OK		0x203
+#define ELE_GET_TRNG_STATE_RETRY_COUNT	0x5
+#define CSAL_TRNG_STATE_MASK		0x0000ffff
+
 int ele_get_info(struct device *dev, phys_addr_t addr, u32 data_size);
 int ele_ping(struct device *dev);
+int ele_start_rng(struct device *dev);
+int ele_get_trng_state(struct device *dev);
 
 #endif
-- 
2.34.1

