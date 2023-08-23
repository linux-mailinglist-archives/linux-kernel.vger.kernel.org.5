Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53D47851B7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjHWHhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjHWHhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:37:00 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C48E73;
        Wed, 23 Aug 2023 00:36:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPrNME3NGZs5PGZVCMdonh3qs7Q7syqmt+f6FyyGZg8+qwB40ercoW+6jHPHTlGQAEhJ17qQbMSMnilqpE007/8horA07+XzIK++wZa6giMv3G3yxCEXautEXB8S2TEQJ8ATrBaxqm/12+4kpAaPLwcPxQFfo2vWM7JS8b0tVt8hsnhoNA7fnsWTMaPqHapY3cb1V8Ndl6C2ZV+Cvvwru+qIg0oN0ButR7tf9pkJ4cTG9WC/tBGUP7sfKJlTlwWWMpJIa/XAOiMKMUeSrzRSh28eXweD3V5+92qw2vy8Fq2cLhEA1BIOXyRHNCcMnXU5fIXSGLcKxY2kp6QDBqJEZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ioS17uE/jdeC6WZ+ranEs9w4zP+cDJuX7Yi6PFBop4=;
 b=G0Zx0xRgjcHSiaF9Ua92z+CB34OZDViwrmsIyqkYkXPSjVEUnRBKM1j7u3FGxrkVMGq1VTOoJbxuUzFvTsqh+BrjKRZ7U57ZuaKW44QC73vJRGl6n2gcqrkUQWaLc1Eujn1JxvfJCquQQukgrELAWQ+zloLdI5gA5nmzYXcP4Ll67TFaM6oM4CdhDXR72Q3pRiwt+l8o7YDFfGHfcz7Bk99mbGBvWR+5qTI3754NGzjO771VgJDDe6m/EZvOGtuuGQtXelnfk/Ai7MRjaZj8/8Zfq1WJMRhJW5Uhsm8EucfXQT4UVlWO8suTzCytJ9W6QTIxAA0F4YRp+aaPtS+XZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ioS17uE/jdeC6WZ+ranEs9w4zP+cDJuX7Yi6PFBop4=;
 b=hcr/baNCk2YlGRBbnni94SspdUweuF1xYzUT0Rms8yRPGvdt/z0yHtODJNdg1qdYTJqGN77R8SYj3joAzajKQ7ZEbQSfSQmN2aDXJ0udFoSQ6m6OzynGDTJlq1/rzo9exY7CdPd5gVVj1fNobn+f+zLAW+Nmk/ftctHIgwexa8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 23 Aug
 2023 07:35:48 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:35:48 +0000
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
Subject: [PATCH v5 09/11] firmware: imx: enclave-fw: add handling for save/restore IMEM region
Date:   Wed, 23 Aug 2023 13:03:28 +0530
Message-Id: <20230823073330.1712721-10-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32ce3585-5553-4ba9-f039-08dba3ab914c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 63t8Ncqc1t4XM8PwlrKuofEw1fYiUU7uP0ZsCiYZ1OMmkyNrYdiWKL/HNcZkmOsHuzorOO01NCBE/VsYMtc+mv2g4KGm86mQA6xnR7quQVFjvp4yiBXNkaiQ7kqQUrwZQ19SgL/u1fNk0A/aN8V12H1dtnm7+bVHe3nFw9j99wh32zH0M5+goM19ewx1rqfXg2w7NwjctoBG+X6AxlVHEGJzBD5y9HTReCmnEqQkmXtSr1AKLd7YoCL3h6r2LsaXeslj+TpJO9GYW+0Q0jWyh/xu/1hGWnCA25dIh4YMxzTS6R9WOwtb8wHPg8V152QiMdht98Askinz/kZQmUf5fU69GvdjY2thg+8BnwRv/XVVyffx18+uRELe0chguYw6AtAFQHKBuacCtAvAeS/1nbByYYuY4IISwL7T7lAQsZ3NOwBxQHn/Chf3trZYOkYyt136tBJWx25UP1f6AJyLMWpvpmQtRk8CU38Oj6zA/IALkH1vT29yQhaoIgSce+VVuIrseu2ItTb8e6x1ydQg/kPaRQRs7DLwjEjO699Xk+ZbmVv8SaL5xExc2qwnPXum5Ue2cNDxvhjGzUqsbFAJ0kNFJqd3johCIkFtfSeMdjTd4PcCvDAALynjXHbEy7/Pr5RUwuu4PWLawldBPCxIhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(36756003)(86362001)(921005)(66476007)(66946007)(66556008)(316002)(41300700001)(6636002)(478600001)(38100700002)(38350700002)(6486002)(6512007)(6666004)(6506007)(52116002)(26005)(1076003)(8676002)(2616005)(2906002)(5660300002)(7416002)(44832011)(4326008)(8936002)(30864003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/N3oi1OoKzC1btEqIHdsDmCgz5dJ0RFza/LfPsOEiOsVUtXhy+imv5VHIQMZ?=
 =?us-ascii?Q?fBCUlxz7vwNSdzwTzKbVl2EzQiVpKTL51BjG6A0rorlMdLb054+ZJd54cuOU?=
 =?us-ascii?Q?zfY0GcsgGL6qVRbSgrQ1lpOGqU641PRzmuIjNgUodehSi5PiBQYjvulS1jQr?=
 =?us-ascii?Q?jI4NyZn3KabPdLmt9u4UjI3a770SVE1YxeuENJq671hNTNbjIWak6xacOKSQ?=
 =?us-ascii?Q?RDXu1XC2ulLn9V9/jddc12NSzmJxlzv42IlrdX/SX+Nh9QWdpuqxfmi0icwS?=
 =?us-ascii?Q?Oc3MX1XQ2kbS/wZEADXeCuHd0uiQHajtHn/edfxcmuqR5oRkZT3ngF03mZvx?=
 =?us-ascii?Q?OCTtPCsIcuu8ulrRnekfgzsa0tdL5noHYYUxUaOHnoNlG7XN/aAus2ILxfG1?=
 =?us-ascii?Q?PCRYzTpZWMQ9jerpfZkejrFx3fu45rgh19Pm2XirV/Me+N5xbPruTks1tgkg?=
 =?us-ascii?Q?IX5iq9LClqFHaTf1+HzmfonSQyIzMeEI9vFl6FUm7al6Sv6/EQDYnQobnwoN?=
 =?us-ascii?Q?/Q3kGOm7TFoOV/hZe7iopxxJleoTWQ0bhMJLJKpIRFs7RP8avvjSkhgjnZ9j?=
 =?us-ascii?Q?rx2K94tyYX5VoKmuWXtWrgtZIZNB+oF/chvQQkaP8uS/Ot6wkQNialVaqtQ1?=
 =?us-ascii?Q?YEysC2TEyQp9u0bZ5+4L4fgicetFWkTKEfBdAYxyiq8AsCLGkaleHpaJG9vc?=
 =?us-ascii?Q?YhjZ+S1XyGtDLFNnIXJTPnRZJT6T79geA7fcJUVuwcD7a8NfmtSN6/Spv78A?=
 =?us-ascii?Q?J74c3rJGISEYewEHdV+5vdiSHpIVTClDCzxdcDA8qEAjaOL325Ktt9T5+QTq?=
 =?us-ascii?Q?QAlvQNEE99jd50fnAzz5k7NTdW+TVtgUns9D79BBrog5SAYRkuHELha7ViY0?=
 =?us-ascii?Q?/Nvs2RrQhefnfZshh6ZqymsHmQHfc5Xz8khZTqSBkzzQy2FEOpZgQuSUdFI5?=
 =?us-ascii?Q?prGJainPXsrV8/07oQwxAUNRMl4dEfXfc3WZDXYMth0UvgbhMBFqbK6oJjrf?=
 =?us-ascii?Q?Nuwa/B/VNKP0LRe7BOwsG2FqN2NG0kR9wHq13a9scJacc1yLsSAdhJzu/ZYS?=
 =?us-ascii?Q?7rNT54DF/ZOIItMc2uJkZlugJGsEximjCzf37Vt5soJ+w1TTJX9fTi7am+dg?=
 =?us-ascii?Q?cBgd4HLmS0nDdi+j/Mv0XbpI1isLYj2cV8wbMgBTD7TJrqXEdVxY5wEQW4ta?=
 =?us-ascii?Q?7APYA5NTRe4kqfsdkq74Mk8mX0/1shZfra67cuKeK05jIRSsHnZvCKC+78fj?=
 =?us-ascii?Q?J+9P4DRQEcCA5zzd+iN5CaCoqFGc+1wKj/GpsftrIh32Nb4hGa5zDA4KMUWd?=
 =?us-ascii?Q?lW5gixF45xVg/qQHPXQUJAmBkjmnZti8k0ZIBx6uoXfXqak179KIuV6FuDs3?=
 =?us-ascii?Q?Bfds/XgPmgrzaCcpRwbbEmnU0b3PN6klyMht7Xyu6QG3Yx2gmribFua6wc3H?=
 =?us-ascii?Q?lyVm2FtN7WPQ/jcixCew4+WMyKC+ht4rGHHsXoILwC8N4A+rGl6QAhqcqCXw?=
 =?us-ascii?Q?SeS4Er7PpPsVoIn316wBRJyt8bvOsV+AEQOi3iukpferBBKIV3d6cc5UN8WA?=
 =?us-ascii?Q?Ne6yKyQLcWm5V/QnFC2SmuO742mh7S4h7KuA+vUf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ce3585-5553-4ba9-f039-08dba3ab914c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:35:47.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuzs+wKGA8hHbCkTw6DZTrIyGXA6GT8WQOwj0BvVNgIq6bD4UfzhHy/A65LDAGdM1T3QozUIaADrTOoElgIYEg==
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

Some IMEM region is lost during kernel power down. Due to this,
firmware's functionaity cannot work correctly.

Saving encrypted IMEM region in kernel memory during power down,
and restore IMEM region on resume.

Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/firmware/imx/ele_base_msg.c       |  42 ++++++++
 drivers/firmware/imx/ele_common.c         | 114 ++++++++++++++++++++++
 drivers/firmware/imx/ele_common.h         |   8 ++
 drivers/firmware/imx/se_fw.c              |  45 ++++++++-
 drivers/firmware/imx/se_fw.h              |   8 ++
 include/linux/firmware/imx/ele_base_msg.h |  15 ++-
 6 files changed, 228 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
index c42e29e14662..b19ab8abeeb8 100644
--- a/drivers/firmware/imx/ele_base_msg.c
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -148,3 +148,45 @@ int ele_start_rng(struct device *dev)
 
 	return -EINVAL;
 }
+
+int ele_service_swap(struct device *dev,
+		     phys_addr_t addr,
+		     u32 addr_size, u16 flag)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	int ret;
+	unsigned int tag, command, size, ver, status;
+
+	ret = plat_fill_cmd_msg_hdr(priv,
+				    (struct mu_hdr *)&priv->tx_msg.header,
+				    ELE_SERVICE_SWAP_REQ, 24);
+	if (ret)
+		return ret;
+
+	priv->tx_msg.data[0] = flag;
+	priv->tx_msg.data[1] = addr_size;
+	priv->tx_msg.data[2] = ELE_NONE_VAL;
+	priv->tx_msg.data[3] = lower_32_bits(addr);
+	priv->tx_msg.data[4] = plat_add_msg_crc((uint32_t *)&priv->tx_msg, 24);
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
+	    command == ELE_SERVICE_SWAP_REQ &&
+	    size == ELE_SERVICE_SWAP_REQ_MSG_SZ &&
+	    ver == ELE_BASE_API_VERSION &&
+	    status == priv->success_tag) {
+		if (flag == ELE_IMEM_EXPORT)
+			return priv->rx_msg.data[1];
+		else
+			return 0;
+	}
+
+	return -EINVAL;
+}
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index f01e5e3255f9..f6feb8f986a7 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -9,6 +9,18 @@
 
 #include "ele_common.h"
 
+uint32_t plat_add_msg_crc(uint32_t *msg, uint32_t msg_len)
+{
+	uint32_t i;
+	uint32_t crc = 0;
+	uint32_t nb_words = msg_len / (uint32_t)sizeof(uint32_t);
+
+	for (i = 0; i < nb_words - 1; i++)
+		crc ^= *(msg + i);
+
+	return crc;
+}
+
 int imx_ele_msg_send_rcv(struct ele_mu_priv *priv)
 {
 	unsigned int wait;
@@ -72,3 +84,105 @@ int ele_do_start_rng(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+int save_imem(struct device *dev)
+{
+	int ret;
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+
+	/* EXPORT command will save encrypted IMEM to given address,
+	 * so later in resume, IMEM can be restored from the given
+	 * address.
+	 *
+	 * Size must be at least 64 kB.
+	 */
+	ret = ele_service_swap(dev,
+			       priv->imem.phyaddr,
+			       ELE_IMEM_SIZE,
+			       ELE_IMEM_EXPORT);
+	if (ret < 0)
+		dev_err(dev, "Failed to export IMEM\n");
+	else
+		dev_info(dev,
+				"Exported %d bytes of encrypted IMEM\n",
+				ret);
+
+	return ret;
+}
+
+int restore_imem(struct device *dev,
+		 uint8_t *pool_name)
+{
+	int ret;
+	u32 imem_state;
+	u32 *get_info_buf = NULL;
+	phys_addr_t get_info_phyaddr = 0;
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+
+	get_info_phyaddr
+		= pool_name ? get_phy_buf_mem_pool(dev,
+						   pool_name,
+						   &get_info_buf,
+						   DEVICE_GET_INFO_SZ)
+			    : 0x0;
+
+	if (!get_info_buf) {
+		dev_err(dev, "Unable to alloc sram from sram pool\n");
+		return -ENOMEM;
+	}
+
+	ret = ele_do_start_rng(dev);
+	if (ret)
+		goto exit;
+
+	/* get info from ELE */
+	ret = ele_get_info(dev, get_info_phyaddr, ELE_GET_INFO_READ_SZ);
+	if (ret) {
+		dev_err(dev, "Failed to get info from ELE.\n");
+		goto exit;
+	}
+
+	/* Get IMEM state, if 0xFE then import IMEM */
+	imem_state = (get_info_buf[ELE_IMEM_STATE_WORD]
+			& ELE_IMEM_STATE_MASK) >> 16;
+	if (imem_state == ELE_IMEM_STATE_BAD) {
+		/* IMPORT command will restore IMEM from the given
+		 * address, here size is the actual size returned by ELE
+		 * during the export operation
+		 */
+		ret = ele_service_swap(dev,
+				       priv->imem.phyaddr,
+				       priv->imem.size,
+				       ELE_IMEM_IMPORT);
+		if (ret) {
+			dev_err(dev, "Failed to import IMEM\n");
+			goto exit;
+		}
+	} else
+		goto exit;
+
+	/* After importing IMEM, check if IMEM state is equal to 0xCA
+	 * to ensure IMEM is fully loaded and
+	 * ELE functionality can be used.
+	 */
+	ret = ele_get_info(dev, get_info_phyaddr, ELE_GET_INFO_READ_SZ);
+	if (ret) {
+		dev_err(dev, "Failed to get info from ELE.\n");
+		goto exit;
+	}
+
+	imem_state = (get_info_buf[ELE_IMEM_STATE_WORD]
+			& ELE_IMEM_STATE_MASK) >> 16;
+	if (imem_state == ELE_IMEM_STATE_OK)
+		dev_info(dev, "Successfully restored IMEM\n");
+	else
+		dev_err(dev, "Failed to restore IMEM\n");
+
+exit:
+	if (pool_name && get_info_buf)
+		free_phybuf_mem_pool(dev, pool_name,
+				get_info_buf, DEVICE_GET_INFO_SZ);
+
+	return ret;
+}
+#endif
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index ed68e5cf9638..55bcbb9fc261 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -9,6 +9,7 @@
 
 #include "se_fw.h"
 
+uint32_t plat_add_msg_crc(uint32_t *msg, uint32_t msg_len);
 int imx_ele_msg_send_rcv(struct ele_mu_priv *priv);
 #ifdef CONFIG_IMX_ELE_TRNG
 int ele_trng_init(struct device *dev);
@@ -20,4 +21,11 @@ static inline int ele_trng_init(struct device *dev)
 #endif
 
 int ele_do_start_rng(struct device *dev);
+
+#ifdef CONFIG_PM_SLEEP
+int save_imem(struct device *dev);
+int restore_imem(struct device *dev,
+		 uint8_t *pool_name);
 #endif
+
+#endif /*__ELE_COMMON_H__ */
diff --git a/drivers/firmware/imx/se_fw.c b/drivers/firmware/imx/se_fw.c
index 6083c42dcda3..936fc0352054 100644
--- a/drivers/firmware/imx/se_fw.c
+++ b/drivers/firmware/imx/se_fw.c
@@ -46,6 +46,7 @@ struct imx_info {
 	/* platform specific flag to enable/disable the ELE True RNG */
 	bool start_rng;
 	bool enable_ele_trng;
+	bool imem_mgmt;
 };
 
 static LIST_HEAD(priv_data_list);
@@ -63,6 +64,7 @@ static const struct imx_info imx8ulp_info = {
 	.init_fw = false,
 	.start_rng = true,
 	.enable_ele_trng = false,
+	.imem_mgmt = true,
 };
 
 static const struct imx_info imx93_info = {
@@ -78,6 +80,7 @@ static const struct imx_info imx93_info = {
 	.init_fw = true,
 	.start_rng = true,
 	.enable_ele_trng = true,
+	.imem_mgmt = false,
 };
 
 static const struct of_device_id se_fw_match[] = {
@@ -160,7 +163,7 @@ static void ele_mu_rx_callback(struct mbox_client *c, void *msg)
 
 }
 
-static phys_addr_t get_phy_buf_mem_pool(struct device *dev,
+phys_addr_t get_phy_buf_mem_pool(struct device *dev,
 					char *mem_pool_name,
 					u32 **buf,
 					uint32_t size)
@@ -182,7 +185,7 @@ static phys_addr_t get_phy_buf_mem_pool(struct device *dev,
 	return gen_pool_virt_to_phys(mem_pool, (ulong)*buf);
 }
 
-static void free_phybuf_mem_pool(struct device *dev,
+void free_phybuf_mem_pool(struct device *dev,
 				 char *mem_pool_name,
 				 u32 *buf,
 				 uint32_t size)
@@ -959,6 +962,17 @@ static int se_probe_cleanup(struct platform_device *pdev)
 		priv->flags &= (~RESERVED_DMA_POOL);
 	}
 
+	/* free the buffer in ele-mu remove, previously allocated
+	 * in ele-mu probe to store encrypted IMEM
+	 */
+	if (priv->imem.buf) {
+		dmam_free_coherent(&pdev->dev,
+				   ELE_IMEM_SIZE,
+				   priv->imem.buf,
+				   priv->imem.phyaddr);
+		priv->imem.buf = NULL;
+	}
+
 	if (priv->ctxs) {
 		for (i = 0; i < priv->max_dev_ctx; i++) {
 			if (priv->ctxs[i])
@@ -1160,6 +1174,19 @@ static int se_fw_probe(struct platform_device *pdev)
 			dev_err(dev, "Failed to init ele-trng\n");
 	}
 
+	if (info->imem_mgmt) {
+		/* allocate buffer where ELE store encrypted IMEM */
+		priv->imem.buf = dmam_alloc_coherent(dev, ELE_IMEM_SIZE,
+						     &priv->imem.phyaddr,
+						     GFP_KERNEL);
+		if (!priv->imem.buf) {
+			dev_err(dev,
+				"dmam-alloc-failed: To store encr-IMEM.\n");
+			ret = -ENOMEM;
+			goto exit;
+		}
+	}
+
 	pr_info("i.MX secure-enclave: %s's mu#%d interface to firmware, configured.\n",
 		info->se_name,
 		priv->ele_mu_id);
@@ -1196,17 +1223,31 @@ static int se_fw_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int se_fw_suspend(struct device *dev)
 {
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	const struct of_device_id *of_id = of_match_device(se_fw_match, dev);
+	struct imx_info *info = (of_id != NULL) ? (struct imx_info *)of_id->data
+						: NULL;
+
+	if (info && info->imem_mgmt)
+		priv->imem.size = save_imem(dev);
+
 	return 0;
 }
 
 static int se_fw_resume(struct device *dev)
 {
 	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	const struct of_device_id *of_id = of_match_device(se_fw_match, dev);
+	struct imx_info *info = (of_id != NULL) ? (struct imx_info *)of_id->data
+						: NULL;
 	int i;
 
 	for (i = 0; i < priv->max_dev_ctx; i++)
 		wake_up_interruptible(&priv->ctxs[i]->wq);
 
+	if (info && info->imem_mgmt)
+		restore_imem(dev, info->pool_name);
+
 	return 0;
 }
 #endif
diff --git a/drivers/firmware/imx/se_fw.h b/drivers/firmware/imx/se_fw.h
index b3502affbc85..acb967f2357c 100644
--- a/drivers/firmware/imx/se_fw.h
+++ b/drivers/firmware/imx/se_fw.h
@@ -165,4 +165,12 @@ struct ele_mu_priv {
 	struct ele_imem_buf imem;
 };
 
+phys_addr_t get_phy_buf_mem_pool(struct device *dev,
+				 char *mem_pool_name,
+				 u32 **buf,
+				 uint32_t size);
+void free_phybuf_mem_pool(struct device *dev,
+			  char *mem_pool_name,
+			  u32 *buf,
+			  uint32_t size);
 #endif
diff --git a/include/linux/firmware/imx/ele_base_msg.h b/include/linux/firmware/imx/ele_base_msg.h
index 8a5c385210fc..6fbea7a8d7c9 100644
--- a/include/linux/firmware/imx/ele_base_msg.h
+++ b/include/linux/firmware/imx/ele_base_msg.h
@@ -37,12 +37,23 @@
 #define ELE_GET_TRNG_STATE_RETRY_COUNT	0x5
 #define CSAL_TRNG_STATE_MASK		0x0000ffff
 
+#define ELE_SERVICE_SWAP_REQ		0xDF
+#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x03
+#define ELE_IMEM_SIZE			0x10000
+#define ELE_IMEM_STATE_OK		0xCA
+#define ELE_IMEM_STATE_BAD		0xFE
+#define ELE_IMEM_STATE_WORD		0x27
+#define ELE_IMEM_STATE_MASK		0x00ff0000
+#define ELE_IMEM_EXPORT			0x1
+#define ELE_IMEM_IMPORT			0x2
+
 #define ELE_BASE_API_VERSION		0x6
-#define ELE_SUCCESS_IND			0xD6
-#define ELE_FAILURE_IND			0x29
 
 int ele_get_info(struct device *dev, phys_addr_t addr, u32 data_size);
 int ele_start_rng(struct device *dev);
 int ele_get_trng_state(struct device *dev);
+int ele_service_swap(struct device *dev,
+		     phys_addr_t addr,
+		     u32 addr_size, u16 flag);
 
 #endif
-- 
2.34.1

