Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479827B0408
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjI0M1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjI0M1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:27:18 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D2CCEE;
        Wed, 27 Sep 2023 05:27:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoFXArNdEqQRaxSUMOPuQ36xbUx+CyVRlQPnfhjB26iiGQM8zAamITU7LN5fCOO/wcFCDfIQEb7Y2dIl7GmYnPxrc0mrzFC/7za06e+Ohj7FkBQfT0T+qhsdfhLWCtjPRJkXMqi+gJX6ONo8T5O4gHiQRmu6kv4lwbMGPM/SE4GoAQSCJ4qhMBFiUQ+FbR5l6+34DALDg4W5Aol3DeaS/ANxE30zTvk7H8WAoZU4SAXjgNWT3pQSzZWyCgVcPEr50vC1YS7B8c3Zk9FuQkex8KluyKHoXEHlUaShy7OKvaCOG7ItxyNSS8cFsHrQmmm/efpQmmmBzCmw3sto6OjHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzREwVvYaak8+gjWo2ETEM0vTm+xQwAvK8277hoN5sg=;
 b=PEgylbimHtwYpaiS7ZZp2u9b/n2pBBjKteT+ItoIhGMd+dM8RRMwdREw2tVlUjlUpJpjWiu3dDc6fYVK95CxW/nF50LKmqLNcVIflsx1wVCJmLdK2bmwyLISnWcXnd4rwT5qIOL4W0i+v2RPZdoG1otxoeVZHhG3ATP3HXwAWWRwrDW8OZI1pkLPci+czSwhbr15Y0IJlbguSvDERrRGFtgtYvB+2NKy//SI0sUo+Tfn7vBL5lB1ewunr55sNIzN7CQoV4AmY34gLu0TTnaRSqIM9o+B0f0eX6Yj/3527fIvPVRukY3hrfINNumWuS6JbE0Ijh2J49lFSfqXjvQlJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzREwVvYaak8+gjWo2ETEM0vTm+xQwAvK8277hoN5sg=;
 b=ref+Lca12VZzupyXk9im5NB7NSnd67SAR7c7hCmtkHnZ2V/0HYh7ptMKRhczLrUbypVOyPs/ZQ1ADuoje9Uj/qJZQSpuyptlMs+/8ot6ryw+++M6XQbv+p0FeY+mq1Gf1ivaGeHabMXGmu7kbt3yP8/duQA0IwJHeu3Z3zt0khI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8181.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:27:05 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:27:05 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v6 07/11] firmware: imx: add driver for NXP EdgeLock Enclave
Date:   Wed, 27 Sep 2023 23:23:57 +0530
Message-Id: <20230927175401.1962733-8-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6f90550d-9cd0-40ec-5355-08dbbf550f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJtyoKBZPGxBYNv+ut/tpDPEPyWC3+2UT7P5f4/wQ476mkrT3OtOrh0eczq6vmNNfdaJ5Rx783aIoISsBHX3hRH6KUj26uJqa+NUSiHZ5w+0FfL13Oh1GvYXUCJcVoUmn/Gr3+ajhBY6x+sntip4+HCJQSju6KSB2eruokG0O1Ux5SvXGu5izxY2ai7gwnFwqt/flQBkgVGDjGhTJ0/uhFQVg6fhUnfMNrgcKGMYcIqLYd1q0TDmoLTAjacvZOtgOULJQC+LX1Ie8ssYNfK1CtETN19x0x7adnYYVUlyYsTe44uzWJNiURQg35ny3r2H6VOhN5ySentLDp1VH8Z5Ro//8gRMt9jIMQi7tWGwJAon9k9NIzHm5x8tnO4biSx3Y9IX9+6kON/ARwTO6faa1F03032aeDf/1IW1RhE33b1O/Fu7csBjw0rG3PoYZ5NkaFeqxJBB43RkZlfwdKHMtJiESvWuHuKETM5ZzyH5+gD6zCebtR3oTJw0IzeGhh43dsPDeZ5vx62CuLq5Qhe06JKwKHNFvZHtVCT0L16+r4wjxm1HWzkOqSV7GMa7VVWU3wqXj3mWUAOA2ak45/enFUucDOfOdsrLW5b3/pj5cffBruM0K4dyWJLTpco7GT6x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(66899024)(7416002)(5660300002)(316002)(921005)(83380400001)(44832011)(41300700001)(6636002)(30864003)(8676002)(8936002)(36756003)(2616005)(66946007)(4326008)(86362001)(1076003)(966005)(6666004)(6486002)(6512007)(52116002)(6506007)(66476007)(66556008)(26005)(2906002)(38350700002)(38100700002)(478600001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3/G/rRXbWKen62Uksp2FboLSgtzM2tSTcbxt2PtqH/pr/lLMIDDCzofAVMO1?=
 =?us-ascii?Q?JSOEphieGionUGjY1DlFOGkng3CPn0321ryAFoSzXc56X6eXKkcMMtILdYhK?=
 =?us-ascii?Q?n8bXM6i2IuRB3zSJZtro/S5DwTRUXeleyfMgB9SLaIaCWSUG74RRY6Rm8EoS?=
 =?us-ascii?Q?T5h3j9qe1+ecwlx9d68CWaYdz4Q5f4GbOc59foLidGJQi6cb2zg6xeDC0rbW?=
 =?us-ascii?Q?kXfSUa+LQq05hgXWSaxjqX2P89dbNr36Gw4XHKexBtAgM6HUQNT4p0M64Dic?=
 =?us-ascii?Q?A4XJE/fEuO68kmX1OOWc4vD/PjXCMyJSyxQqMldP4MMhZlf6SF/N01F89nlN?=
 =?us-ascii?Q?zu3fyQo2uaIn8v7nTVDbY54S3dk40N6qVNaBcwgRlcZhLr31Im8qgzDzIxwt?=
 =?us-ascii?Q?RD4+SFIEzmKKa/pl2lVwauutUkXa0nvSZwkxRFQUzq5yMLMo6iQ3EIC8KXAo?=
 =?us-ascii?Q?mOgKqeqR+whzhDXnB0S7Kv8fcH1VacR+3Fd5JE3F8kR0C0MFyrWGp5TUctXh?=
 =?us-ascii?Q?Z7FOe3DM+bWpEUHi5XN9wrezQ0ofbf9EXnWT80NFZZGIec3Lo+BvE5FVtAyQ?=
 =?us-ascii?Q?vJXmFqVr0MWEggU+d6mHU0zvLSSyFlh/Lmblg19Kqj8UK+PEPmVsoExvOtcf?=
 =?us-ascii?Q?w65FVkA86/SINRahw5mvLx1fmM4DItFMyqvPx0Uj0bM92B9RDZTF9PIL7hAA?=
 =?us-ascii?Q?TN3Hq72EPeJaueeLfrIPHWLYvCUPMwxaPPgcSGa/vxp7xh+nL3zneYa4ZA+W?=
 =?us-ascii?Q?hyX/WSrtFEjtbaVcJODpkbYF25nZKf60jQGuZGBmDCrTdy9yHqp5L1FP9HMc?=
 =?us-ascii?Q?3FS8M48kFWoTIzRN3457noSz4r/V6SYI09yFufsOZAgPaD303lvq1Kb7q02P?=
 =?us-ascii?Q?RsHSbJYXXidWtnRj1Frmo1z9B4jaTPM0EEGsOpX66Tbx4aYvYICKpUmchOK8?=
 =?us-ascii?Q?YulIR4CvoX51xbf+oxuqFAewfl8wzj9MceKQ0+8Ks7rO7Hjx8FLSbEgqSNdG?=
 =?us-ascii?Q?cVGGRlWjQ+WjL3sJ2i5AmG0NryfscD7h8cYimSjz1jNdwhVsddI3CjaBX5Qw?=
 =?us-ascii?Q?jfqQtWMf3l8BI+zY68rj6gkKmFkyL2WyLyVbuNJIRLBtTdFFNOW/swZp5CLO?=
 =?us-ascii?Q?Ta0nag4QK96fO3VbGL80FIfI1pIHEOKTLzRQtaGq1Lj3OA/Y4ybOqDNfhRid?=
 =?us-ascii?Q?f0dnOvcVgCpMLbmuwrxRvnFkmCbraqqTvjBVlyZ7wzX1jaNXbzbdEmhI0MY+?=
 =?us-ascii?Q?gEzzcqoBwZfB7gw26q087sl3Njyz6iW28hm+Op1CveFxMmeLUN62ZsJVHJaA?=
 =?us-ascii?Q?iGTYkSsWxs3ehD3hfrCTTtwU2OFEBl9aNckVZn5BNzrdfhVVDT3sC8ofciW7?=
 =?us-ascii?Q?Gn1EFM723QVuzNEuojNwxUUya7Of3OiiHZl2v6NQRh3jVmu2Vp5tjnzA9sl2?=
 =?us-ascii?Q?WBxifhhKlKU8ZHAUmiBnpPnmUH/hn/lWt5TECXOrBFj8zrlw7Y98POw1CZxN?=
 =?us-ascii?Q?ZsZCIRsVKsSMMZrdWcI76vjBFoUXldK5BozpwNLmCTtq2xTidTfFZ6bazTGO?=
 =?us-ascii?Q?JboUZ4zwtCFehjCL7Uv7rgE4tvq5AwPwWGYcKpng?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f90550d-9cd0-40ec-5355-08dbbf550f0e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:27:05.1947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryxaAgV2+QrlxBbTcCD9Uhv9YHrnZUVKSM45R2mbCWg3H2hawR/mVVWHwUmAEmve986iVI1HPzuZGs/gyYCZiw==
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

The Edgelock Enclave , is the secure enclave embedded in the SoC
to support the features like HSM, SHE & V2X, using message based
communication channel.

ELE FW communicates on a dedicated MU with application core where
kernel is running. It exists on specific i.MX processors. e.g.
i.MX8ULP, i.MX93.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 Documentation/ABI/testing/se-cdev         |   41 +
 drivers/firmware/imx/Kconfig              |   12 +
 drivers/firmware/imx/Makefile             |    2 +
 drivers/firmware/imx/ele_base_msg.c       |  101 ++
 drivers/firmware/imx/ele_common.c         |  139 +++
 drivers/firmware/imx/ele_common.h         |   30 +
 drivers/firmware/imx/se_fw.c              | 1300 +++++++++++++++++++++
 drivers/firmware/imx/se_fw.h              |  144 +++
 include/linux/firmware/imx/ele_base_msg.h |   40 +
 include/linux/firmware/imx/ele_mu_ioctl.h |   73 ++
 10 files changed, 1882 insertions(+)
 create mode 100644 Documentation/ABI/testing/se-cdev
 create mode 100644 drivers/firmware/imx/ele_base_msg.c
 create mode 100644 drivers/firmware/imx/ele_common.c
 create mode 100644 drivers/firmware/imx/ele_common.h
 create mode 100644 drivers/firmware/imx/se_fw.c
 create mode 100644 drivers/firmware/imx/se_fw.h
 create mode 100644 include/linux/firmware/imx/ele_base_msg.h
 create mode 100644 include/linux/firmware/imx/ele_mu_ioctl.h

diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
new file mode 100644
index 000000000000..14a7143fcaf3
--- /dev/null
+++ b/Documentation/ABI/testing/se-cdev
@@ -0,0 +1,41 @@
+What:		/dev/<se>_mu[0-9]+_ch[0-9]+
+Date:		August 2023
+KernelVersion:	6.6
+Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
+Description:
+		NXP offers multiple hardware IP(s) for  secure-enclaves like EdgeLock-
+		Enclave(ELE), SECO. The character device file-descriptors
+		/dev/<se>_mu*_ch* are the interface between user-space NXP's secure-
+		enclave shared-library and the kernel driver.
+
+		The ioctl(2)-based ABI is defined and documented in
+		[include]<linux/firmware/imx/ele_mu_ioctl.h>
+		 ioctl(s) are used primarily for:
+			- shared memory management
+			- allocation of I/O buffers
+			- get mu info
+			- setting a dev-ctx as receiver that is slave to fw
+
+		The following file operations are supported:
+
+		open(2)
+		  Currently the only useful flags are O_RDWR.
+
+		read(2)
+		  Every read() from the opened character device context is waiting on
+		  wakeup_intruptible, that gets set by the registered mailbox callback
+		  function; indicating a message received from the firmware on message-
+		  unit.
+
+		write(2)
+		  Every write() to the opened character device context needs to acquire
+		  mailbox_lock, before sending message on to the message unit.
+
+		close(2)
+		  Stops and free up the I/O contexts that was associated
+		  with the file descriptor.
+
+Users:		https://github.com/nxp-imx/imx-secure-enclave.git,
+		https://github.com/nxp-imx/imx-smw.git
+		crypto/skcipher,
+		drivers/nvmem/imx-ocotp-ele.c
diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index c027d99f2a59..2822e5d4b24c 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -28,3 +28,15 @@ config IMX_SCU_PD
 	depends on IMX_SCU
 	help
 	  The System Controller Firmware (SCFW) based power domain driver.
+
+config IMX_SEC_ENCLAVE
+	tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmware driver."
+	depends on IMX_MBOX && ARCH_MXC && ARM64
+	default m if ARCH_MXC
+
+	help
+	  It is possible to use APIs exposed by the iMX Secure Enclave HW IP called:
+          - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
+          like base, HSM, V2X & SHE using the SAB protocol via the shared Messaging
+          Unit. This driver exposes these interfaces via a set of file descriptors
+          allowing to configure shared memory, send and receive messages.
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8f9f04a513a8..77ec0f922788 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+sec_enclave-objs		= se_fw.o ele_common.o ele_base_msg.o
+obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
new file mode 100644
index 000000000000..813f769f7bc3
--- /dev/null
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021-2023 NXP
+ */
+
+#include <linux/types.h>
+#include <linux/completion.h>
+
+#include <linux/firmware/imx/ele_base_msg.h>
+#include <linux/firmware/imx/ele_mu_ioctl.h>
+
+#include "ele_common.h"
+
+int ele_get_info(struct device *dev, phys_addr_t addr, u32 data_size)
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
+				    ELE_GET_INFO_REQ,
+				    ELE_GET_INFO_REQ_MSG_SZ,
+				    true);
+	if (ret)
+		goto exit;
+
+	priv->tx_msg->data[0] = upper_32_bits(addr);
+	priv->tx_msg->data[1] = lower_32_bits(addr);
+	priv->tx_msg->data[2] = data_size;
+	ret = imx_ele_msg_send_rcv(priv);
+	if (ret < 0)
+		goto exit;
+
+	ret  = validate_rsp_hdr(priv,
+				priv->rx_msg->header,
+				ELE_GET_INFO_REQ,
+				ELE_GET_INFO_RSP_MSG_SZ,
+				true);
+	if (ret)
+		goto exit;
+
+	status = RES_STATUS(priv->rx_msg->data[0]);
+	if (status != priv->success_tag) {
+		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
+			ELE_GET_INFO_REQ, status);
+		ret = -1;
+	}
+
+exit:
+	imx_se_free_tx_rx_buf(priv);
+
+	return ret;
+}
+
+int ele_ping(struct device *dev)
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
+				    ELE_PING_REQ, ELE_PING_REQ_SZ,
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
+	ret  = validate_rsp_hdr(priv,
+				priv->rx_msg->header,
+				ELE_PING_REQ,
+				ELE_PING_RSP_SZ,
+				true);
+	if (ret)
+		goto exit;
+
+	status = RES_STATUS(priv->rx_msg->data[0]);
+	if (status != priv->success_tag) {
+		dev_err(dev, "Command Id[%d], Response Failure = 0x%x",
+			ELE_PING_REQ, status);
+		ret = -1;
+	}
+exit:
+	imx_se_free_tx_rx_buf(priv);
+
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
new file mode 100644
index 000000000000..4410245a19ec
--- /dev/null
+++ b/drivers/firmware/imx/ele_common.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 NXP
+ */
+
+#include "ele_common.h"
+#include "se_fw.h"
+
+int imx_se_alloc_tx_rx_buf(struct ele_mu_priv *priv)
+{
+	int ret = 0;
+
+	priv->tx_msg = devm_kzalloc(priv->dev,
+				    sizeof(*priv->tx_msg),
+				    GFP_KERNEL);
+	if (!priv->tx_msg) {
+		ret = -ENOMEM;
+		dev_err(priv->dev, "Fail allocate mem for tx_msg.\n");
+		return ret;
+	}
+
+	priv->rx_msg = devm_kzalloc(priv->dev,
+				    sizeof(*priv->rx_msg),
+				    GFP_KERNEL);
+
+	if (!priv->rx_msg) {
+		ret = -ENOMEM;
+		dev_err(priv->dev, "Fail allocate mem for rx_msg.\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+void imx_se_free_tx_rx_buf(struct ele_mu_priv *priv)
+{
+	if (priv->tx_msg)
+		devm_kfree(priv->dev, priv->tx_msg);
+
+	if (priv->rx_msg)
+		devm_kfree(priv->dev, priv->rx_msg);
+}
+
+int imx_ele_msg_send_rcv(struct ele_mu_priv *priv)
+{
+	unsigned int wait;
+	int err;
+
+	mutex_lock(&priv->mu_cmd_lock);
+	mutex_lock(&priv->mu_lock);
+
+	err = mbox_send_message(priv->tx_chan, priv->tx_msg);
+	if (err < 0) {
+		pr_err("Error: mbox_send_message failure.\n");
+		mutex_unlock(&priv->mu_lock);
+		mutex_unlock(&priv->mu_cmd_lock);
+		return err;
+	}
+	err = 0;
+
+	mutex_unlock(&priv->mu_lock);
+
+	wait = msecs_to_jiffies(1000);
+	if (!wait_for_completion_timeout(&priv->done, wait)) {
+		pr_err("Error: wait_for_completion timed out.\n");
+		err = -ETIMEDOUT;
+	}
+
+	mutex_unlock(&priv->mu_cmd_lock);
+
+	return err;
+}
+
+/* Fill a command message header with a given command ID and length in bytes. */
+int plat_fill_cmd_msg_hdr(struct ele_mu_priv *priv,
+			  struct mu_hdr *hdr,
+			  uint8_t cmd,
+			  uint32_t len,
+			  bool is_base_api)
+{
+	hdr->tag = priv->cmd_tag;
+	hdr->ver = (is_base_api) ? priv->base_api_ver : priv->fw_api_ver;
+	hdr->command = cmd;
+	hdr->size = len >> 2;
+
+	return 0;
+}
+
+int validate_rsp_hdr(struct ele_mu_priv *priv, unsigned int header,
+		     uint8_t msg_id, uint8_t sz, bool is_base_api)
+{
+	unsigned int tag, command, size, ver;
+	int ret = -EINVAL;
+
+	tag = MSG_TAG(header);
+	command = MSG_COMMAND(header);
+	size = MSG_SIZE(header);
+	ver = MSG_VER(header);
+
+	do {
+		if (tag != priv->rsp_tag) {
+			dev_err(priv->dev,
+				"MSG[0x%x] Hdr: Resp tag mismatch. (0x%x != 0x%x)",
+				msg_id, tag, priv->rsp_tag);
+			break;
+		}
+
+		if (command != msg_id) {
+			dev_err(priv->dev,
+				"MSG Header: Cmd id mismatch. (0x%x != 0x%x)",
+				command, msg_id);
+			break;
+		}
+
+		if (size != (sz >> 2)) {
+			dev_err(priv->dev,
+				"MSG[0x%x] Hdr: Cmd size mismatch. (0x%x != 0x%x)",
+				msg_id, size, (sz >> 2));
+			break;
+		}
+
+		if (is_base_api && (ver != priv->base_api_ver)) {
+			dev_err(priv->dev,
+				"MSG[0x%x] Hdr: Base API Vers mismatch. (0x%x != 0x%x)",
+				msg_id, ver, priv->base_api_ver);
+			break;
+		} else if (!is_base_api && ver != priv->fw_api_ver) {
+			dev_err(priv->dev,
+				"MSG[0x%x] Hdr: FW API Vers mismatch. (0x%x != 0x%x)",
+				msg_id, ver, priv->fw_api_ver);
+			break;
+		}
+
+		ret = 0;
+
+	} while (false);
+
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
new file mode 100644
index 000000000000..284b7f66d8e3
--- /dev/null
+++ b/drivers/firmware/imx/ele_common.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2023 NXP
+ */
+
+
+#ifndef __ELE_COMMON_H__
+#define __ELE_COMMON_H__
+
+#include "se_fw.h"
+
+int imx_ele_msg_send_rcv(struct ele_mu_priv *priv);
+void imx_se_free_tx_rx_buf(struct ele_mu_priv *priv);
+int imx_se_alloc_tx_rx_buf(struct ele_mu_priv *priv);
+int validate_rsp_hdr(struct ele_mu_priv *priv, unsigned int header,
+		     uint8_t msg_id, uint8_t sz, bool is_base_api);
+int plat_fill_cmd_msg_hdr(struct ele_mu_priv *priv,
+			  struct mu_hdr *hdr,
+			  uint8_t cmd,
+			  uint32_t len,
+			  bool is_base_api);
+#ifdef CONFIG_IMX_ELE_TRNG
+int ele_trng_init(struct device *dev);
+#else
+static inline int ele_trng_init(struct device *dev)
+{
+	return 0;
+}
+#endif
+#endif
diff --git a/drivers/firmware/imx/se_fw.c b/drivers/firmware/imx/se_fw.c
new file mode 100644
index 000000000000..e47ad4b6ba54
--- /dev/null
+++ b/drivers/firmware/imx/se_fw.c
@@ -0,0 +1,1300 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021-2023 NXP
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/completion.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/firmware/imx/ele_base_msg.h>
+#include <linux/firmware/imx/ele_mu_ioctl.h>
+#include <linux/genalloc.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/miscdevice.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/sys_soc.h>
+
+#include "se_fw.h"
+
+#define SOC_ID_OF_IMX8ULP		0x084D
+#define SOC_ID_OF_IMX93			0x9300
+#define SOC_VER_MASK			0xFFFF0000
+#define SOC_ID_MASK			0x0000FFFF
+#define RESERVED_DMA_POOL		BIT(1)
+
+struct imx_info {
+	uint8_t mu_id;
+	bool socdev;
+	uint8_t mu_did;
+	uint8_t max_dev_ctx;
+	uint8_t cmd_tag;
+	uint8_t rsp_tag;
+	uint8_t success_tag;
+	uint8_t base_api_ver;
+	uint8_t fw_api_ver;
+	uint8_t *se_name;
+	uint8_t *mbox_tx_name;
+	uint8_t *mbox_rx_name;
+	uint8_t *pool_name;
+	bool reserved_dma_ranges;
+};
+
+struct imx_info_list {
+	uint8_t num_mu;
+	struct imx_info info[];
+};
+
+static LIST_HEAD(priv_data_list);
+
+static const struct imx_info_list imx8ulp_info = {
+	.num_mu = 1,
+	.info = {
+			{
+				.mu_id = 2,
+				.socdev = true,
+				.mu_did = 7,
+				.max_dev_ctx = 4,
+				.cmd_tag = 0x17,
+				.rsp_tag = 0xe1,
+				.success_tag = 0xd6,
+				.base_api_ver = MESSAGING_VERSION_6,
+				.fw_api_ver = MESSAGING_VERSION_7,
+				.se_name = "ele",
+				.mbox_tx_name = "tx",
+				.mbox_rx_name = "rx",
+				.pool_name = "fsl,sram",
+				.reserved_dma_ranges = true,
+			},
+	},
+};
+
+static const struct imx_info_list imx93_info = {
+	.num_mu = 1,
+	.info = {
+			{
+				.mu_id = 2,
+				.socdev = true,
+				.mu_did = 3,
+				.max_dev_ctx = 4,
+				.cmd_tag = 0x17,
+				.rsp_tag = 0xe1,
+				.success_tag = 0xd6,
+				.base_api_ver = MESSAGING_VERSION_6,
+				.fw_api_ver = MESSAGING_VERSION_7,
+				.se_name = "ele",
+				.mbox_tx_name = "tx",
+				.mbox_rx_name = "rx",
+				.pool_name = NULL,
+				.reserved_dma_ranges = true,
+			},
+		},
+};
+
+static const struct of_device_id se_fw_match[] = {
+	{ .compatible = "fsl,imx8ulp-se-fw", .data = (void *)&imx8ulp_info},
+	{ .compatible = "fsl,imx93-se-fw", .data = (void *)&imx93_info},
+	{},
+};
+
+static struct imx_info *get_imx_info(struct imx_info_list *info_list,
+				     uint32_t mu_id)
+{
+	int i = 0;
+
+	for (i = 0; i < info_list->num_mu; i++)
+		if (info_list->info[i].mu_id == mu_id)
+			return &info_list->info[i];
+
+	return NULL;
+}
+
+/*
+ * Callback called by mailbox FW when data are received
+ */
+static void ele_mu_rx_callback(struct mbox_client *c, void *msg)
+{
+	struct device *dev = c->dev;
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	struct ele_mu_device_ctx *dev_ctx;
+	bool is_response = false;
+	int msg_size;
+	struct mu_hdr header;
+
+	/* The function can be called with NULL msg */
+	if (!msg) {
+		dev_err(dev, "Message is invalid\n");
+		return;
+	}
+
+	header.tag = ((u8 *)msg)[TAG_OFFSET];
+	header.command = ((u8 *)msg)[CMD_OFFSET];
+	header.size = ((u8 *)msg)[SZ_OFFSET];
+	header.ver = ((u8 *)msg)[VER_OFFSET];
+
+	/* Incoming command: wake up the receiver if any. */
+	if (header.tag == priv->cmd_tag) {
+		dev_dbg(dev, "Selecting cmd receiver\n");
+		dev_ctx = priv->cmd_receiver_dev;
+	} else if (header.tag == priv->rsp_tag) {
+		if (priv->waiting_rsp_dev) {
+			dev_dbg(dev, "Selecting rsp waiter\n");
+			dev_ctx = priv->waiting_rsp_dev;
+			is_response = true;
+		} else {
+			/*
+			 * Reading the EdgeLock Enclave response
+			 * to the command, sent by other
+			 * linux kernel services.
+			 */
+			spin_lock(&priv->lock);
+			if (priv->rx_msg)
+				memcpy(priv->rx_msg, msg, header.size << 2);
+			else
+				dev_err(dev, "No RX buffer to save response.\n");
+
+			complete(&priv->done);
+			spin_unlock(&priv->lock);
+			return;
+		}
+	} else {
+		dev_err(dev, "Failed to select a device for message: %.8x\n",
+				*((u32 *) &header));
+		return;
+	}
+
+	if (!dev_ctx) {
+		dev_err(dev, "No device context selected for message: %.8x\n",
+				*((u32 *)&header));
+		return;
+	}
+	/* Init reception */
+	msg_size = header.size;
+	if (msg_size > MAX_RECV_SIZE) {
+		dev_err(dev, "%s: Message is too big (%d > %d)",
+				dev_ctx->miscdev.name,
+				msg_size,
+				MAX_RECV_SIZE);
+		return;
+	}
+
+	memcpy(dev_ctx->temp_resp, msg, msg_size << 2);
+	dev_ctx->temp_resp_size = msg_size;
+
+	/* Allow user to read */
+	dev_ctx->pending_hdr = dev_ctx->temp_resp[0];
+	wake_up_interruptible(&dev_ctx->wq);
+
+	if (is_response)
+		priv->waiting_rsp_dev = NULL;
+
+}
+
+static phys_addr_t get_phy_buf_mem_pool(struct device *dev,
+					char *mem_pool_name,
+					u32 **buf,
+					uint32_t size)
+{
+	struct device_node *of_node = dev->of_node;
+	struct gen_pool *mem_pool = of_gen_pool_get(of_node,
+						    mem_pool_name, 0);
+	if (!mem_pool) {
+		dev_err(dev, "Unable to get sram pool\n");
+		return 0;
+	}
+
+	*buf = (u32 *)gen_pool_alloc(mem_pool, size);
+	if (!buf) {
+		dev_err(dev, "Unable to alloc sram from sram pool\n");
+		return 0;
+	}
+
+	return gen_pool_virt_to_phys(mem_pool, (ulong)*buf);
+}
+
+static void free_phybuf_mem_pool(struct device *dev,
+				 char *mem_pool_name,
+				 u32 *buf,
+				 uint32_t size)
+{
+	struct device_node *of_node = dev->of_node;
+	struct gen_pool *mem_pool = of_gen_pool_get(of_node,
+						    mem_pool_name, 0);
+
+	if (!mem_pool)
+		dev_err(dev, "%s failed: Unable to get sram pool.\n", __func__);
+
+	gen_pool_free(mem_pool, (unsigned long)buf, size);
+}
+
+static int imx_soc_device_register(struct device *dev,
+				   struct imx_info *info)
+{
+	struct soc_device_attribute *attr;
+	struct soc_device *sdev = NULL;
+	phys_addr_t get_info_addr = 0;
+	u32 *get_info_data = NULL;
+	u8 major_ver, minor_ver;
+	int err;
+
+	if (info->pool_name) {
+		get_info_addr = get_phy_buf_mem_pool(dev,
+						     info->pool_name,
+						     &get_info_data,
+						     DEVICE_GET_INFO_SZ);
+	} else {
+		get_info_data = dmam_alloc_coherent(dev,
+						    DEVICE_GET_INFO_SZ,
+						    &get_info_addr,
+						    GFP_KERNEL);
+	}
+	if (!get_info_addr) {
+		dev_err(dev, "Unable to alloc buffer for device info.\n");
+		return -ENOMEM;
+	}
+
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	err = ele_get_info(dev, get_info_addr, ELE_GET_INFO_READ_SZ);
+	if (err) {
+		attr->revision = kasprintf(GFP_KERNEL, "A0");
+	} else {
+		major_ver = (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
+				& SOC_VER_MASK) >> 24;
+		minor_ver = ((get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
+				& SOC_VER_MASK) >> 16) & 0xFF;
+		if (minor_ver)
+			attr->revision = kasprintf(GFP_KERNEL,
+						   "%x.%x",
+						   major_ver,
+						   minor_ver);
+		else
+			attr->revision = kasprintf(GFP_KERNEL,
+						   "%x",
+						   major_ver);
+
+		switch (get_info_data[GET_INFO_SOC_INFO_WORD_OFFSET]
+				& SOC_ID_MASK) {
+			case SOC_ID_OF_IMX8ULP:
+				attr->soc_id = kasprintf(GFP_KERNEL,
+							 "i.MX8ULP");
+				break;
+			case SOC_ID_OF_IMX93:
+				attr->soc_id = kasprintf(GFP_KERNEL,
+							 "i.MX93");
+				break;
+		}
+	}
+
+	err = of_property_read_string(of_root, "model",
+				      &attr->machine);
+	if (err) {
+		kfree(attr);
+		return -EINVAL;
+	}
+	attr->family = kasprintf(GFP_KERNEL, "Freescale i.MX");
+
+	attr->serial_number
+		= kasprintf(GFP_KERNEL, "%016llX",
+			    (u64)get_info_data[GET_INFO_SL_NUM_MSB_WORD_OFF] << 32
+			    | get_info_data[GET_INFO_SL_NUM_LSB_WORD_OFF]);
+
+	if (info->pool_name) {
+		free_phybuf_mem_pool(dev, info->pool_name,
+				     get_info_data, DEVICE_GET_INFO_SZ);
+	} else {
+		dmam_free_coherent(dev,
+				   DEVICE_GET_INFO_SZ,
+				   get_info_data,
+				   get_info_addr);
+	}
+
+	sdev = soc_device_register(attr);
+	if (IS_ERR(sdev)) {
+		kfree(attr->soc_id);
+		kfree(attr->serial_number);
+		kfree(attr->revision);
+		kfree(attr->family);
+		kfree(attr->machine);
+		kfree(attr);
+		return PTR_ERR(sdev);
+	}
+
+	return 0;
+}
+
+/*
+ * File operations for user-space
+ */
+
+/* Write a message to the MU. */
+static ssize_t ele_mu_fops_write(struct file *fp, const char __user *buf,
+				  size_t size, loff_t *ppos)
+{
+	struct ele_mu_device_ctx *dev_ctx
+		= container_of(fp->private_data,
+			       struct ele_mu_device_ctx,
+			       miscdev);
+	struct ele_mu_priv *ele_mu_priv = dev_ctx->priv;
+	u32 nb_words = 0;
+	struct mu_hdr header;
+	int err;
+
+	dev_dbg(ele_mu_priv->dev,
+		"%s: write from buf (%p)%zu, ppos=%lld\n",
+			dev_ctx->miscdev.name,
+			buf, size, ((ppos) ? *ppos : 0));
+
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx->status != MU_OPENED) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (size < ELE_MU_HDR_SZ) {
+		dev_err(ele_mu_priv->dev,
+			"%s: User buffer too small(%zu < %d)\n",
+				dev_ctx->miscdev.name,
+				size, ELE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+
+	if (size > MAX_MESSAGE_SIZE_BYTES) {
+		dev_err(ele_mu_priv->dev,
+			"%s: User buffer too big(%zu > %d)\n",
+				dev_ctx->miscdev.name,
+				size,
+				MAX_MESSAGE_SIZE_BYTES);
+		err = -ENOSPC;
+		goto exit;
+	}
+
+	/* Copy data to buffer */
+	if (copy_from_user(dev_ctx->temp_cmd, buf, size)) {
+		err = -EFAULT;
+		dev_err(ele_mu_priv->dev,
+			"%s: Fail copy message from user\n",
+				dev_ctx->miscdev.name);
+		goto exit;
+	}
+
+	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     dev_ctx->temp_cmd, size, false);
+
+	header = *((struct mu_hdr *) (&dev_ctx->temp_cmd[0]));
+
+	/* Check the message is valid according to tags */
+	if (header.tag == ele_mu_priv->cmd_tag) {
+		/*
+		 * Command-lock will be unlocked in ele_mu_fops_read
+		 * when the response to this command, is read.
+		 *
+		 * This command lock is taken to serialize
+		 * the command execution over an MU.
+		 *
+		 * A command execution considered completed, when the
+		 * response to the command is received.
+		 */
+		mutex_lock(&ele_mu_priv->mu_cmd_lock);
+		ele_mu_priv->waiting_rsp_dev = dev_ctx;
+	} else if (header.tag == ele_mu_priv->rsp_tag) {
+		/* Check the device context can send the command */
+		if (dev_ctx != ele_mu_priv->cmd_receiver_dev) {
+			dev_err(ele_mu_priv->dev,
+				"%s: Channel not configured to send resp to FW.",
+				dev_ctx->miscdev.name);
+			err = -EPERM;
+			goto exit;
+		}
+	} else {
+		dev_err(ele_mu_priv->dev,
+			"%s: The message does not have a valid TAG\n",
+				dev_ctx->miscdev.name);
+		err = -EINVAL;
+		goto exit;
+	}
+
+	/*
+	 * Check that the size passed as argument matches the size
+	 * carried in the message.
+	 */
+	nb_words = header.size;
+	if (nb_words << 2 != size) {
+		dev_err(ele_mu_priv->dev,
+			"%s: User buffer too small\n",
+				dev_ctx->miscdev.name);
+		goto exit;
+	}
+
+	mutex_lock(&ele_mu_priv->mu_lock);
+
+	/* Send message */
+	dev_dbg(ele_mu_priv->dev,
+		"%s: sending message\n",
+			dev_ctx->miscdev.name);
+	err = mbox_send_message(ele_mu_priv->tx_chan, dev_ctx->temp_cmd);
+	if (err < 0) {
+		dev_err(ele_mu_priv->dev,
+			"%s: Failed to send message\n",
+				dev_ctx->miscdev.name);
+		goto unlock;
+	}
+
+	err = nb_words << 2;
+
+unlock:
+	mutex_unlock(&ele_mu_priv->mu_lock);
+
+exit:
+	if (err < 0)
+		mutex_unlock(&ele_mu_priv->mu_cmd_lock);
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+/*
+ * Read a message from the MU.
+ * Blocking until a message is available.
+ */
+static ssize_t ele_mu_fops_read(struct file *fp, char __user *buf,
+				 size_t size, loff_t *ppos)
+{
+	struct ele_mu_device_ctx *dev_ctx
+		= container_of(fp->private_data,
+			       struct ele_mu_device_ctx,
+			       miscdev);
+	struct ele_mu_priv *ele_mu_priv = dev_ctx->priv;
+	u32 data_size = 0, size_to_copy = 0;
+	struct ele_buf_desc *b_desc;
+	int err;
+	struct mu_hdr header = {0};
+
+	dev_dbg(ele_mu_priv->dev,
+		"%s: read to buf %p(%zu), ppos=%lld\n",
+			dev_ctx->miscdev.name,
+			buf, size, ((ppos) ? *ppos : 0));
+
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx->status != MU_OPENED) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	/* Wait until the complete message is received on the MU. */
+	if (wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hdr != 0)) {
+		dev_err(ele_mu_priv->dev,
+			"%s: Err[0x%x]:Interrupted by signal.\n",
+				dev_ctx->miscdev.name, err);
+		err = -EINTR;
+		goto exit;
+	}
+
+	dev_dbg(ele_mu_priv->dev,
+			"%s: %s %s\n",
+			dev_ctx->miscdev.name,
+			__func__,
+			"message received, start transmit to user");
+
+	/*
+	 * Check that the size passed as argument is larger than
+	 * the one carried in the message.
+	 */
+	data_size = dev_ctx->temp_resp_size << 2;
+	size_to_copy = data_size;
+	if (size_to_copy > size) {
+		dev_dbg(ele_mu_priv->dev,
+			"%s: User buffer too small (%zu < %d)\n",
+				dev_ctx->miscdev.name,
+				size, size_to_copy);
+		size_to_copy = size;
+	}
+
+	/*
+	 * We may need to copy the output data to user before
+	 * delivering the completion message.
+	 */
+	while (!list_empty(&dev_ctx->pending_out)) {
+		b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
+						  struct ele_buf_desc,
+						  link);
+		if (!b_desc)
+			continue;
+
+		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr) {
+
+			dev_dbg(ele_mu_priv->dev,
+				"%s: Copy output data to user\n",
+				dev_ctx->miscdev.name);
+			if (copy_to_user(b_desc->usr_buf_ptr,
+					 b_desc->shared_buf_ptr,
+					 b_desc->size)) {
+				dev_err(ele_mu_priv->dev,
+					"%s: Failure copying output data to user.",
+					dev_ctx->miscdev.name);
+				err = -EFAULT;
+				goto exit;
+			}
+		}
+
+		if (b_desc->shared_buf_ptr)
+			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+		__list_del_entry(&b_desc->link);
+		devm_kfree(dev_ctx->dev, b_desc);
+	}
+
+	header = *((struct mu_hdr *) (&dev_ctx->temp_resp[0]));
+
+	/* Copy data from the buffer */
+	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     dev_ctx->temp_resp, size_to_copy, false);
+	if (copy_to_user(buf, dev_ctx->temp_resp, size_to_copy)) {
+		dev_err(ele_mu_priv->dev,
+			"%s: Failed to copy to user\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	err = size_to_copy;
+
+	/* free memory allocated on the shared buffers. */
+	dev_ctx->secure_mem.pos = 0;
+	dev_ctx->non_secure_mem.pos = 0;
+
+	dev_ctx->pending_hdr = 0;
+
+exit:
+	/*
+	 * Clean the used Shared Memory space,
+	 * whether its Input Data copied from user buffers, or
+	 * Data received from FW.
+	 */
+	while (!list_empty(&dev_ctx->pending_in) ||
+	       !list_empty(&dev_ctx->pending_out)) {
+		if (!list_empty(&dev_ctx->pending_in))
+			b_desc = list_first_entry_or_null(&dev_ctx->pending_in,
+							  struct ele_buf_desc,
+							  link);
+		else
+			b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
+							  struct ele_buf_desc,
+							  link);
+
+		if (!b_desc)
+			continue;
+
+		if (b_desc->shared_buf_ptr)
+			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+		__list_del_entry(&b_desc->link);
+		devm_kfree(dev_ctx->dev, b_desc);
+	}
+	if (header.tag == ele_mu_priv->rsp_tag)
+		mutex_unlock(&ele_mu_priv->mu_cmd_lock);
+
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+/* Give access to EdgeLock Enclave, to the memory we want to share */
+static int ele_mu_setup_ele_mem_access(struct ele_mu_device_ctx *dev_ctx,
+					     u64 addr, u32 len)
+{
+	/* Assuming EdgeLock Enclave has access to all the memory regions */
+	int ret = 0;
+
+	if (ret) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Fail find memreg\n", dev_ctx->miscdev.name);
+		goto exit;
+	}
+
+	if (ret) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Fail set permission for resource\n",
+				dev_ctx->miscdev.name);
+		goto exit;
+	}
+
+exit:
+	return ret;
+}
+
+static int ele_mu_ioctl_get_mu_info(struct ele_mu_device_ctx *dev_ctx,
+				    unsigned long arg)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev_ctx->dev);
+	struct ele_mu_ioctl_get_mu_info info;
+	int err = -EINVAL;
+
+	info.ele_mu_id = priv->ele_mu_id;
+	info.interrupt_idx = 0;
+	info.tz = 0;
+	info.did = priv->ele_mu_did;
+
+	dev_dbg(priv->dev,
+		"%s: info [mu_idx: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
+			dev_ctx->miscdev.name,
+			info.ele_mu_id, info.interrupt_idx, info.tz, info.did);
+
+	if (copy_to_user((u8 *)arg, &info, sizeof(info))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy mu info to user\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+exit:
+	return err;
+}
+
+/*
+ * Copy a buffer of data to/from the user and return the address to use in
+ * messages
+ */
+static int ele_mu_ioctl_setup_iobuf_handler(struct ele_mu_device_ctx *dev_ctx,
+					    unsigned long arg)
+{
+	struct ele_buf_desc *b_desc;
+	struct ele_mu_ioctl_setup_iobuf io = {0};
+	struct ele_shared_mem *shared_mem;
+	int err = 0;
+	u32 pos;
+
+	if (copy_from_user(&io, (u8 *)arg, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed copy iobuf config from user\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	dev_dbg(dev_ctx->priv->dev,
+			"%s: io [buf: %p(%d) flag: %x]\n",
+			dev_ctx->miscdev.name,
+			io.user_buf, io.length, io.flags);
+
+	if (io.length == 0 || !io.user_buf) {
+		/*
+		 * Accept NULL pointers since some buffers are optional
+		 * in FW commands. In this case we should return 0 as
+		 * pointer to be embedded into the message.
+		 * Skip all data copy part of code below.
+		 */
+		io.ele_addr = 0;
+		goto copy;
+	}
+
+	/* Select the shared memory to be used for this buffer. */
+	if (io.flags & ELE_MU_IO_FLAGS_USE_SEC_MEM) {
+		/* App requires to use secure memory for this buffer.*/
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed allocate SEC MEM memory\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	} else {
+		/* No specific requirement for this buffer. */
+		shared_mem = &dev_ctx->non_secure_mem;
+	}
+
+	/* Check there is enough space in the shared memory. */
+	if (shared_mem->size < shared_mem->pos
+			|| io.length >= shared_mem->size - shared_mem->pos) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Not enough space in shared memory\n",
+				dev_ctx->miscdev.name);
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	/* Allocate space in shared memory. 8 bytes aligned. */
+	pos = shared_mem->pos;
+	shared_mem->pos += round_up(io.length, 8u);
+	io.ele_addr = (u64)shared_mem->dma_addr + pos;
+
+	if ((io.flags & ELE_MU_IO_FLAGS_USE_SEC_MEM) &&
+	    !(io.flags & ELE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
+		/*Add base address to get full address.*/
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed allocate SEC MEM memory\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	memset(shared_mem->ptr + pos, 0, io.length);
+	if ((io.flags & ELE_MU_IO_FLAGS_IS_INPUT) ||
+	    (io.flags & ELE_MU_IO_FLAGS_IS_IN_OUT)) {
+		/*
+		 * buffer is input:
+		 * copy data from user space to this allocated buffer.
+		 */
+		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
+				   io.length)) {
+			dev_err(dev_ctx->priv->dev,
+				"%s: Failed copy data to shared memory\n",
+				dev_ctx->miscdev.name);
+			err = -EFAULT;
+			goto exit;
+		}
+	}
+
+	b_desc = devm_kmalloc(dev_ctx->dev, sizeof(*b_desc), GFP_KERNEL);
+	if (!b_desc) {
+		err = -ENOMEM;
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed allocating mem for pending buffer\n",
+			dev_ctx->miscdev.name);
+		goto exit;
+	}
+
+	b_desc->shared_buf_ptr = shared_mem->ptr + pos;
+	b_desc->usr_buf_ptr = io.user_buf;
+	b_desc->size = io.length;
+
+	if (io.flags & ELE_MU_IO_FLAGS_IS_INPUT) {
+		/*
+		 * buffer is input:
+		 * add an entry in the "pending input buffers" list so
+		 * that copied data can be cleaned from shared memory
+		 * later.
+		 */
+		list_add_tail(&b_desc->link, &dev_ctx->pending_in);
+	} else {
+		/*
+		 * buffer is output:
+		 * add an entry in the "pending out buffers" list so data
+		 * can be copied to user space when receiving ELE
+		 * response.
+		 */
+		list_add_tail(&b_desc->link, &dev_ctx->pending_out);
+	}
+
+copy:
+	/* Provide the EdgeLock Enclave address to user space only if success.*/
+	if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy iobuff setup to user\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+exit:
+	return err;
+}
+
+/* Open a char device. */
+static int ele_mu_fops_open(struct inode *nd, struct file *fp)
+{
+	struct ele_mu_device_ctx *dev_ctx
+		= container_of(fp->private_data,
+			       struct ele_mu_device_ctx,
+			       miscdev);
+	int err;
+
+	/* Avoid race if opened at the same time */
+	if (down_trylock(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	/* Authorize only 1 instance. */
+	if (dev_ctx->status != MU_FREE) {
+		err = -EBUSY;
+		goto exit;
+	}
+
+	/*
+	 * Allocate some memory for data exchanges with S40x.
+	 * This will be used for data not requiring secure memory.
+	 */
+	dev_ctx->non_secure_mem.ptr = dmam_alloc_coherent(dev_ctx->dev,
+					MAX_DATA_SIZE_PER_USER,
+					&dev_ctx->non_secure_mem.dma_addr,
+					GFP_KERNEL);
+	if (!dev_ctx->non_secure_mem.ptr) {
+		err = -ENOMEM;
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to map shared memory with FW.\n",
+				dev_ctx->miscdev.name);
+		goto exit;
+	}
+
+	err = ele_mu_setup_ele_mem_access(dev_ctx,
+					  dev_ctx->non_secure_mem.dma_addr,
+					  MAX_DATA_SIZE_PER_USER);
+	if (err) {
+		err = -EPERM;
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to share access to shared memory\n",
+			   dev_ctx->miscdev.name);
+		goto free_coherent;
+	}
+
+	dev_ctx->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
+	dev_ctx->non_secure_mem.pos = 0;
+	dev_ctx->status = MU_OPENED;
+
+	dev_ctx->pending_hdr = 0;
+
+	goto exit;
+
+free_coherent:
+	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
+			   dev_ctx->non_secure_mem.ptr,
+			   dev_ctx->non_secure_mem.dma_addr);
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+/* Close a char device. */
+static int ele_mu_fops_close(struct inode *nd, struct file *fp)
+{
+	struct ele_mu_device_ctx *dev_ctx = container_of(fp->private_data,
+					struct ele_mu_device_ctx, miscdev);
+	struct ele_mu_priv *priv = dev_ctx->priv;
+	struct ele_buf_desc *b_desc;
+
+	/* Avoid race if closed at the same time */
+	if (down_trylock(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	/* The device context has not been opened */
+	if (dev_ctx->status != MU_OPENED)
+		goto exit;
+
+	/* check if this device was registered as command receiver. */
+	if (priv->cmd_receiver_dev == dev_ctx)
+		priv->cmd_receiver_dev = NULL;
+
+	/* check if this device was registered as waiting response. */
+	if (priv->waiting_rsp_dev == dev_ctx) {
+		priv->waiting_rsp_dev = NULL;
+		mutex_unlock(&priv->mu_cmd_lock);
+	}
+
+	/* Unmap secure memory shared buffer. */
+	if (dev_ctx->secure_mem.ptr)
+		devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
+
+	dev_ctx->secure_mem.ptr = NULL;
+	dev_ctx->secure_mem.dma_addr = 0;
+	dev_ctx->secure_mem.size = 0;
+	dev_ctx->secure_mem.pos = 0;
+
+	/* Free non-secure shared buffer. */
+	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
+			   dev_ctx->non_secure_mem.ptr,
+			   dev_ctx->non_secure_mem.dma_addr);
+
+	dev_ctx->non_secure_mem.ptr = NULL;
+	dev_ctx->non_secure_mem.dma_addr = 0;
+	dev_ctx->non_secure_mem.size = 0;
+	dev_ctx->non_secure_mem.pos = 0;
+
+	while (!list_empty(&dev_ctx->pending_in) ||
+	       !list_empty(&dev_ctx->pending_out)) {
+		if (!list_empty(&dev_ctx->pending_in))
+			b_desc = list_first_entry_or_null(&dev_ctx->pending_in,
+							  struct ele_buf_desc,
+							  link);
+		else
+			b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
+							  struct ele_buf_desc,
+							  link);
+
+		if (!b_desc)
+			continue;
+
+		if (b_desc->shared_buf_ptr)
+			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+		__list_del_entry(&b_desc->link);
+		devm_kfree(dev_ctx->dev, b_desc);
+	}
+
+	dev_ctx->status = MU_FREE;
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return 0;
+}
+
+/* IOCTL entry point of a char device */
+static long ele_mu_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct ele_mu_device_ctx *dev_ctx
+		= container_of(fp->private_data,
+			       struct ele_mu_device_ctx,
+			       miscdev);
+	struct ele_mu_priv *ele_mu_priv = dev_ctx->priv;
+	int err = -EINVAL;
+
+	/* Prevent race during change of device context */
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	switch (cmd) {
+	case ELE_MU_IOCTL_ENABLE_CMD_RCV:
+		if (!ele_mu_priv->cmd_receiver_dev) {
+			ele_mu_priv->cmd_receiver_dev = dev_ctx;
+			err = 0;
+		}
+		break;
+	case ELE_MU_IOCTL_GET_MU_INFO:
+		err = ele_mu_ioctl_get_mu_info(dev_ctx, arg);
+		break;
+	case ELE_MU_IOCTL_SETUP_IOBUF:
+		err = ele_mu_ioctl_setup_iobuf_handler(dev_ctx, arg);
+		break;
+	default:
+		err = -EINVAL;
+		dev_dbg(ele_mu_priv->dev,
+			"%s: IOCTL %.8x not supported\n",
+				dev_ctx->miscdev.name,
+				cmd);
+	}
+
+	up(&dev_ctx->fops_lock);
+	return (long)err;
+}
+
+/* Char driver setup */
+static const struct file_operations ele_mu_fops = {
+	.open		= ele_mu_fops_open,
+	.owner		= THIS_MODULE,
+	.release	= ele_mu_fops_close,
+	.unlocked_ioctl = ele_mu_ioctl,
+	.read		= ele_mu_fops_read,
+	.write		= ele_mu_fops_write,
+};
+
+/* interface for managed res to free a mailbox channel */
+static void if_mbox_free_channel(void *mbox_chan)
+{
+	mbox_free_channel(mbox_chan);
+}
+
+/* interface for managed res to unregister a char device */
+static void if_misc_deregister(void *miscdevice)
+{
+	misc_deregister(miscdevice);
+}
+
+static int ele_mu_request_channel(struct device *dev,
+				 struct mbox_chan **chan,
+				 struct mbox_client *cl,
+				 const char *name)
+{
+	struct mbox_chan *t_chan;
+	int ret = 0;
+
+	t_chan = mbox_request_channel_byname(cl, name);
+	if (IS_ERR(t_chan)) {
+		ret = PTR_ERR(t_chan);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev,
+				"Failed to request chan %s ret %d\n", name,
+				ret);
+		goto exit;
+	}
+
+	ret = devm_add_action(dev, if_mbox_free_channel, t_chan);
+	if (ret) {
+		dev_err(dev, "failed to add devm removal of mbox %s\n", name);
+		goto exit;
+	}
+
+	*chan = t_chan;
+
+exit:
+	return ret;
+}
+
+static int se_probe_cleanup(struct platform_device *pdev)
+{
+	int ret;
+	int i;
+	struct device *dev = &pdev->dev;
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv) {
+		ret = -EINVAL;
+		dev_err(dev, "Invalid ELE-MU Priv data");
+		return ret;
+	}
+
+	if (priv->tx_chan)
+		mbox_free_channel(priv->tx_chan);
+	if (priv->rx_chan)
+		mbox_free_channel(priv->rx_chan);
+
+	if (priv->flags & RESERVED_DMA_POOL) {
+		of_reserved_mem_device_release(dev);
+		priv->flags &= (~RESERVED_DMA_POOL);
+	}
+
+	if (priv->ctxs) {
+		for (i = 0; i < priv->max_dev_ctx; i++) {
+			if (priv->ctxs[i])
+				devm_kfree(dev, priv->ctxs[i]);
+		}
+		devm_kfree(dev, priv->ctxs);
+	}
+
+	list_del(&priv->priv_data);
+
+	devm_kfree(dev, priv);
+	return ret;
+}
+
+static int se_fw_probe(struct platform_device *pdev)
+{
+	struct ele_mu_device_ctx *dev_ctx;
+	struct device *dev = &pdev->dev;
+	struct ele_mu_priv *priv;
+	const struct of_device_id *of_id = of_match_device(se_fw_match, dev);
+	struct imx_info *info = NULL;
+	char *devname;
+	int ret;
+	int i;
+	struct device_node *np;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		dev_err(dev, "Fail allocate mem for private data\n");
+		return ret;
+	}
+	memset(priv, 0x0, sizeof(*priv));
+	priv->dev = dev;
+	dev_set_drvdata(dev, priv);
+
+	/*
+	 * Get the address of MU.
+	 */
+	np = pdev->dev.of_node;
+	if (!np) {
+		dev_err(dev, "Cannot find MU User entry in device tree\n");
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	/* Initialize the mutex. */
+	mutex_init(&priv->mu_cmd_lock);
+	mutex_init(&priv->mu_lock);
+
+	priv->cmd_receiver_dev = NULL;
+	priv->waiting_rsp_dev = NULL;
+
+	/* Mailbox client configuration */
+	priv->ele_mb_cl.dev		= dev;
+	priv->ele_mb_cl.tx_block	= false;
+	priv->ele_mb_cl.knows_txdone	= true;
+	priv->ele_mb_cl.rx_callback	= ele_mu_rx_callback;
+
+	ret = of_property_read_u32(np, "fsl,mu-id", &priv->ele_mu_id);
+	if (ret) {
+		ret = -EINVAL;
+		dev_err(dev, "Not able to read mu-id.\n");
+		goto exit;
+	}
+
+	info = get_imx_info((struct imx_info_list *)of_id->data,
+			    priv->ele_mu_id);
+
+	priv->ele_mu_did = info->mu_did;
+	priv->max_dev_ctx = info->max_dev_ctx;
+	priv->cmd_tag = info->cmd_tag;
+	priv->rsp_tag = info->rsp_tag;
+	priv->success_tag = info->success_tag;
+	priv->base_api_ver = info->base_api_ver;
+	priv->fw_api_ver = info->fw_api_ver;
+
+	ret = ele_mu_request_channel(dev, &priv->tx_chan,
+				     &priv->ele_mb_cl, info->mbox_tx_name);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to request tx channel\n");
+
+		goto exit;
+	}
+
+	ret = ele_mu_request_channel(dev, &priv->rx_chan,
+				     &priv->ele_mb_cl, info->mbox_rx_name);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to request rx channel\n");
+
+		goto exit;
+	}
+
+	priv->ctxs = devm_kzalloc(dev, sizeof(dev_ctx) * priv->max_dev_ctx,
+				  GFP_KERNEL);
+
+	if (!priv->ctxs) {
+		ret = -ENOMEM;
+		dev_err(dev, "Fail allocate mem for private dev-ctxs.\n");
+		goto exit;
+	}
+
+	/* Create users */
+	for (i = 0; i < priv->max_dev_ctx; i++) {
+		dev_ctx = devm_kzalloc(dev, sizeof(*dev_ctx), GFP_KERNEL);
+		if (!dev_ctx) {
+			ret = -ENOMEM;
+			dev_err(dev,
+				"Fail to allocate memory for device context\n");
+			goto exit;
+		}
+
+		dev_ctx->dev = dev;
+		dev_ctx->status = MU_FREE;
+		dev_ctx->priv = priv;
+
+		priv->ctxs[i] = dev_ctx;
+
+		/* Default value invalid for an header. */
+		init_waitqueue_head(&dev_ctx->wq);
+
+		INIT_LIST_HEAD(&dev_ctx->pending_out);
+		INIT_LIST_HEAD(&dev_ctx->pending_in);
+		sema_init(&dev_ctx->fops_lock, 1);
+
+		devname = devm_kasprintf(dev, GFP_KERNEL, "%s_mu%d_ch%d",
+					 info->se_name,
+					 priv->ele_mu_id, i);
+		if (!devname) {
+			ret = -ENOMEM;
+			dev_err(dev,
+				"Fail to allocate memory for misc dev name\n");
+			goto exit;
+		}
+
+		dev_ctx->miscdev.name = devname;
+		dev_ctx->miscdev.minor = MISC_DYNAMIC_MINOR;
+		dev_ctx->miscdev.fops = &ele_mu_fops;
+		dev_ctx->miscdev.parent = dev;
+		ret = misc_register(&dev_ctx->miscdev);
+		if (ret) {
+			dev_err(dev, "failed to register misc device %d\n",
+				ret);
+			goto exit;
+		}
+
+		ret = devm_add_action(dev, if_misc_deregister,
+				      &dev_ctx->miscdev);
+		if (ret) {
+			dev_err(dev,
+				"failed[%d] to add action to the misc-dev\n",
+				ret);
+			goto exit;
+		}
+	}
+
+	init_completion(&priv->done);
+	spin_lock_init(&priv->lock);
+
+	list_add_tail(&priv->priv_data, &priv_data_list);
+	dev_set_drvdata(dev, priv);
+
+	if (info->reserved_dma_ranges) {
+		ret = of_reserved_mem_device_init(dev);
+		if (ret) {
+			dev_err(dev,
+				"failed to init reserved memory region %d\n",
+				ret);
+			priv->flags &= (~RESERVED_DMA_POOL);
+			goto exit;
+		}
+		priv->flags |= RESERVED_DMA_POOL;
+	}
+
+	if (info->socdev) {
+		ret = imx_soc_device_register(dev, info);
+		if (ret) {
+			dev_err(dev,
+				"failed[%d] to register SoC device\n", ret);
+			goto exit;
+		}
+	}
+
+	ret = ele_ping(dev);
+	if (ret)
+		dev_err(dev, "Failed[%d] to ping the fw.\n", ret);
+
+	dev_info(dev, "i.MX secure-enclave: %s's mu#%d interface to firmware, configured.\n",
+		info->se_name,
+		priv->ele_mu_id);
+	return devm_of_platform_populate(dev);
+
+exit:
+	/* if execution control reaches here, ele-mu probe fail.
+	 * hence doing the cleanup
+	 */
+	return se_probe_cleanup(pdev);
+}
+
+static int se_fw_remove(struct platform_device *pdev)
+{
+	se_probe_cleanup(pdev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int se_fw_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int se_fw_resume(struct device *dev)
+{
+	struct ele_mu_priv *priv = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < priv->max_dev_ctx; i++)
+		wake_up_interruptible(&priv->ctxs[i]->wq);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops se_fw_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(se_fw_suspend, se_fw_resume)
+};
+
+static struct platform_driver se_fw_driver = {
+	.driver = {
+		.name = "fsl-se-fw",
+		.of_match_table = se_fw_match,
+		.pm = &se_fw_pm,
+	},
+	.probe = se_fw_probe,
+	.remove = se_fw_remove,
+};
+MODULE_DEVICE_TABLE(of, se_fw_match);
+
+module_platform_driver(se_fw_driver);
+
+MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
+MODULE_DESCRIPTION("iMX Secure Enclave FW Driver.");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/imx/se_fw.h b/drivers/firmware/imx/se_fw.h
new file mode 100644
index 000000000000..25906f40daef
--- /dev/null
+++ b/drivers/firmware/imx/se_fw.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2021-2023 NXP
+ */
+
+#ifndef SE_MU_H
+#define SE_MU_H
+
+#include <linux/miscdevice.h>
+#include <linux/semaphore.h>
+#include <linux/mailbox_client.h>
+
+#define MAX_MESSAGE_SIZE		31
+#define MAX_RECV_SIZE			MAX_MESSAGE_SIZE
+#define MAX_RECV_SIZE_BYTES		(MAX_RECV_SIZE << 2)
+#define MAX_MESSAGE_SIZE_BYTES		(MAX_MESSAGE_SIZE << 2)
+
+#define ELE_MSG_DATA_NUM		10
+
+#define MSG_TAG(x)			(((x) & 0xff000000) >> 24)
+#define MSG_COMMAND(x)			(((x) & 0x00ff0000) >> 16)
+#define MSG_SIZE(x)			(((x) & 0x0000ff00) >> 8)
+#define MSG_VER(x)			((x) & 0x000000ff)
+#define RES_STATUS(x)			((x) & 0x000000ff)
+#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
+#define S4_DEFAULT_MUAP_INDEX		(2)
+#define S4_MUAP_DEFAULT_MAX_USERS	(4)
+#define MESSAGING_VERSION_6		0x6
+#define MESSAGING_VERSION_7		0x7
+
+#define DEFAULT_MESSAGING_TAG_COMMAND           (0x17u)
+#define DEFAULT_MESSAGING_TAG_RESPONSE          (0xe1u)
+
+#define ELE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
+#define ELE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
+
+struct ele_imem_buf {
+	u8 *buf;
+	phys_addr_t phyaddr;
+	u32 size;
+};
+
+struct ele_buf_desc {
+	u8 *shared_buf_ptr;
+	u8 *usr_buf_ptr;
+	u32 size;
+	struct list_head link;
+};
+
+/* Status of a char device */
+enum mu_device_status_t {
+	MU_FREE,
+	MU_OPENED
+};
+
+struct ele_shared_mem {
+	dma_addr_t dma_addr;
+	u32 size;
+	u32 pos;
+	u8 *ptr;
+};
+
+/* Private struct for each char device instance. */
+struct ele_mu_device_ctx {
+	struct device *dev;
+	struct ele_mu_priv *priv;
+	struct miscdevice miscdev;
+
+	enum mu_device_status_t status;
+	wait_queue_head_t wq;
+	struct semaphore fops_lock;
+
+	u32 pending_hdr;
+	struct list_head pending_in;
+	struct list_head pending_out;
+
+	struct ele_shared_mem secure_mem;
+	struct ele_shared_mem non_secure_mem;
+
+	u32 temp_cmd[MAX_MESSAGE_SIZE];
+	u32 temp_resp[MAX_RECV_SIZE];
+	u32 temp_resp_size;
+	struct notifier_block ele_notify;
+};
+
+/* Header of the messages exchange with the EdgeLock Enclave */
+struct mu_hdr {
+	u8 ver;
+	u8 size;
+	u8 command;
+	u8 tag;
+}  __packed;
+
+#define ELE_MU_HDR_SZ	4
+#define TAG_OFFSET	(ELE_MU_HDR_SZ - 1)
+#define CMD_OFFSET	(ELE_MU_HDR_SZ - 2)
+#define SZ_OFFSET	(ELE_MU_HDR_SZ - 3)
+#define VER_OFFSET	(ELE_MU_HDR_SZ - 4)
+
+struct ele_api_msg {
+	u32 header; /* u8 Tag; u8 Command; u8 Size; u8 Ver; */
+	u32 data[ELE_MSG_DATA_NUM];
+};
+
+struct ele_mu_priv {
+	struct list_head priv_data;
+	struct ele_mu_device_ctx *cmd_receiver_dev;
+	struct ele_mu_device_ctx *waiting_rsp_dev;
+	/*
+	 * prevent parallel access to the MU registers
+	 * e.g. a user trying to send a command while the other one is
+	 * sending a response.
+	 */
+	struct mutex mu_lock;
+	/*
+	 * prevent a command to be sent on the MU while another one is still
+	 * processing. (response to a command is allowed)
+	 */
+	struct mutex mu_cmd_lock;
+	struct device *dev;
+	u8 ele_mu_did;
+	u32 ele_mu_id;
+	u8 cmd_tag;
+	u8 rsp_tag;
+	u8 success_tag;
+	u8 base_api_ver;
+	u8 fw_api_ver;
+
+	struct mbox_client ele_mb_cl;
+	struct mbox_chan *tx_chan, *rx_chan;
+	struct ele_api_msg *tx_msg, *rx_msg;
+	struct completion done;
+	spinlock_t lock;
+	/*
+	 * Flag to retain the state of initialization done at
+	 * the time of ele-mu probe.
+	 */
+	uint32_t flags;
+	u8 max_dev_ctx;
+	struct ele_mu_device_ctx **ctxs;
+	struct ele_imem_buf imem;
+};
+
+#endif
diff --git a/include/linux/firmware/imx/ele_base_msg.h b/include/linux/firmware/imx/ele_base_msg.h
new file mode 100644
index 000000000000..49e3619372be
--- /dev/null
+++ b/include/linux/firmware/imx/ele_base_msg.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2021-2023 NXP
+ *
+ * Header file for the ELE Base API(s).
+ */
+
+#ifndef ELE_BASE_MSG_H
+#define ELE_BASE_MSG_H
+
+#include <linux/types.h>
+
+#define WORD_SZ				4
+#define ELE_NONE_VAL			0x0
+
+#define ELE_SUCCESS_IND			0xD6
+
+#define ELE_GET_INFO_REQ		0xDA
+#define ELE_GET_INFO_REQ_MSG_SZ		0x10
+#define ELE_GET_INFO_RSP_MSG_SZ		0x08
+
+#define ELE_GET_INFO_BUFF_SZ		0x100
+#define ELE_GET_INFO_READ_SZ		0xA0
+#define DEVICE_GET_INFO_SZ		0x100
+
+#define GET_INFO_SOC_INFO_WORD_OFFSET	1
+#define GET_INFO_UUID_WORD_OFFSET	3
+#define GET_INFO_SL_NUM_MSB_WORD_OFF \
+	(GET_INFO_UUID_WORD_OFFSET + 3)
+#define GET_INFO_SL_NUM_LSB_WORD_OFF \
+	(GET_INFO_UUID_WORD_OFFSET + 0)
+
+#define ELE_PING_REQ			0x01
+#define ELE_PING_REQ_SZ			0x04
+#define ELE_PING_RSP_SZ			0x08
+
+int ele_get_info(struct device *dev, phys_addr_t addr, u32 data_size);
+int ele_ping(struct device *dev);
+
+#endif
diff --git a/include/linux/firmware/imx/ele_mu_ioctl.h b/include/linux/firmware/imx/ele_mu_ioctl.h
new file mode 100644
index 000000000000..3eb1f1177393
--- /dev/null
+++ b/include/linux/firmware/imx/ele_mu_ioctl.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause*/
+/*
+ * Copyright 2019-2023 NXP
+ */
+
+#ifndef ELE_MU_IOCTL_H
+#define ELE_MU_IOCTL_H
+
+/* IOCTL definitions. */
+
+struct ele_mu_ioctl_setup_iobuf {
+	u8 *user_buf;
+	u32 length;
+	u32 flags;
+	u64 ele_addr;
+};
+
+struct ele_mu_ioctl_shared_mem_cfg {
+	u32 base_offset;
+	u32 size;
+};
+
+struct ele_mu_ioctl_get_mu_info {
+	u8 ele_mu_id;
+	u8 interrupt_idx;
+	u8 tz;
+	u8 did;
+};
+
+struct ele_mu_ioctl_signed_message {
+	u8 *message;
+	u32 msg_size;
+	u32 error_code;
+};
+
+/* IO Buffer Flags */
+#define ELE_MU_IO_FLAGS_IS_OUTPUT	(0x00u)
+#define ELE_MU_IO_FLAGS_IS_INPUT	(0x01u)
+#define ELE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
+#define ELE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
+#define ELE_MU_IO_FLAGS_IS_IN_OUT	(0x08u)
+
+/* IOCTLS */
+#define ELE_MU_IOCTL			0x0A /* like MISC_MAJOR. */
+
+/*
+ * ioctl to designated the current fd as logical-reciever.
+ * This is ioctl is send when the nvm-daemon, a slave to the
+ * firmware is started by the user.
+ */
+#define ELE_MU_IOCTL_ENABLE_CMD_RCV	_IO(ELE_MU_IOCTL, 0x01)
+
+/*
+ * ioctl to get the buffer allocated from the memory, which is shared
+ * between kernel and FW.
+ * Post allocation, the kernel tagged the allocated memory with:
+ *  Output
+ *  Input
+ *  Input-Output
+ *  Short address
+ *  Secure-memory
+ */
+#define ELE_MU_IOCTL_SETUP_IOBUF	_IOWR(ELE_MU_IOCTL, 0x03, \
+					struct ele_mu_ioctl_setup_iobuf)
+
+/*
+ * ioctl to get the mu information, that is used to exchange message
+ * with FW, from user-spaced.
+ */
+#define ELE_MU_IOCTL_GET_MU_INFO	_IOR(ELE_MU_IOCTL, 0x04, \
+					struct ele_mu_ioctl_get_mu_info)
+
+#endif
-- 
2.34.1

