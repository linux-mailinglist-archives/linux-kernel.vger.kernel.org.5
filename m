Return-Path: <linux-kernel+bounces-142515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142708A2CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366381C23BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099E756473;
	Fri, 12 Apr 2024 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WXdU3DTR"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D900E5674D;
	Fri, 12 Apr 2024 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918388; cv=fail; b=M96eq/nt2Wc1Zg2rnYzyTZM9KAJkuFOIBz4u/4r2BfD3mzssRjWiskQQf+ZVkR89jXejbcNg31gemymJTl36/GKLehLwlf30zUAEXAR6w7QEwkI+yzEw1w3jQ8XezVkjoFHQqkUn8+gv2UVaMBd3xpOEw24MAMUY1dYL8KoMWJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918388; c=relaxed/simple;
	bh=F14h2hIZxy/WaPTp6QzvyniwhgTu1G7E/XZjU3o7xuE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pyZcEjPom/f0EYLaohJsg8IVw9GdEIDVVrk+ckDQCsXi6uRhQwkCks0iTjSaAGmX0BDkPxOTxAv1e55PiWOIkzCcer0c2L0FBpFADG3TRJwKPjV5VmEbFPG1Qaot18lPdQiQtNV/Quo3l+WIeML3LgHbx9pbuR8uS5Hkx2Ot2XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WXdU3DTR; arc=fail smtp.client-ip=40.107.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3DLJkWdDJKtOaHEmJJT6R6E52rHTBR6ZKSK6oTINbNo+4YZ+NRsCUZvPmoHhmKArSYH+G9MUdzzELzCpImyt6fBTG9WxbTW5cBOMdcfZnE7kU7S8Dv2StqTF6sd4EGrWnM1bO98rbGgS2kct6Tp/+y3Uxl9jIeyca4NIxG3L2SMWPTP0jtSAIQQo6W3mQG3Sz6f/rKD5wqRE9qIUKl0FvtaKN2t85fQ4cuPkovLkURjEsSyC9Ulb0Rt5y4ADnm0k6xSMh0ILNZMkFm6b0rXgCdamkVEF0bQ+7RyP6nR3cyOTFBaLlLl4k5xzFpvVR9ojTAt48c4ISXu/kefgzK2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmLEKLDgTbuTKcvdN45vKFWC6Ra3feV6bbsCVFoin+Q=;
 b=MmK7po28Dogdg0Jv09RoI4o+tXEDf1DBq1C9JVzaki33xXLuLdPyou4vBSxHznXDUxFeLAe797XDYY3vK8w+0bcuwpjKRFI3pFlQGLbKpA6tCCfk7YPg2uBtxsgSQRArY6H7giPIOXWlT3HsJeS2y80M3z9saqrTkt7iqB+sTXUFjopqul+/aoLVeQCLlIqYueFHsMKIuvcUloOINWl0uWzmQL+UDjexL3k+0M6xU41tG6RkOQ3PtF49RneeSmhii6KZTgb/UrHx3CEWLMVn/oPF1G1Pz1HHkzQTm+ks5/CTZ+HIcmVEZjnj3zQAYD06y2LI/eB+i/u/asmCZF5cIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmLEKLDgTbuTKcvdN45vKFWC6Ra3feV6bbsCVFoin+Q=;
 b=WXdU3DTRyLIAFaYxgCdVKccq9he7yS7ud6UlW4fqRhVPx8fiKulrBO2TjLcTv0TMcOSbwvEmNhEJOyM2Oig5ylNdoNL7gnpptJRKhUX944+ag0WvWcfBkI+vhaNSsmxafQwtAPJzeMxRN2U16F2PBLmSW8dhdf5jLEi/bDRwk7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by VI2PR04MB10147.eurprd04.prod.outlook.com (2603:10a6:800:21e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Fri, 12 Apr
 2024 10:39:43 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 10:39:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 18:47:12 +0800
Subject: [PATCH v3 6/6] firmware: imx: add i.MX95 MISC driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-imx95-bbm-misc-v2-v3-6-4380a4070980@nxp.com>
References: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
In-Reply-To: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712918849; l=4839;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=CxsTem4c2UkSyoEAgF9+D0rRRjQcCv/6gmp4AinHGy8=;
 b=MnmQFLlmxWxbr8VNJYoOn/Y4xHMlU3QSDhC1NmWmqVK4Jm557rYiLnofdQ9a8erkKvED215J6
 6yVwHiJ47/CD0ys4iX56S80O+oVTBS1yzZr7xWdUx8rsJsEEBbnk/2b
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|VI2PR04MB10147:EE_
X-MS-Office365-Filtering-Correlation-Id: f2570369-9839-4ef9-7fde-08dc5adcdd93
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LXypHQ49sSI6HyaSVGk0ohKV78M13swP0AqN6U3jMzTnt5yQqdoI3+tgB8g3KzsbnhiDKNK6/loQ+7sswCNZ6OBcstfrDjFTaOXfjRxG5PDrZn0io8L98coh8TIwEUQ94V5hgHggoD/qf2Pp6csmA50mkO8M3FQg/XF6WdZpL3n6UmjkdW8BE6bYaIpgaMOhm1DzSs/2rUSJ8q6FHCQTdNR0z/TQIe+FfVnByxL06dhUfUeJMRDP22HziWqvB7oGXiqFI7sc8PqjbYqlHUySrPQ0z9hgPQV+kS7oRB0KcJoilod9fLnE7Z0nvSGOiMPDWuHuMW8qsaAVNzkeyvzMrkcRo0856xKiwCvtdO8pyuUL1bGkPvTT8KlIFIjDHkov6nFvEACXiTaGFVxI8DdyHFlSuA3V7Y1T+UF2zCBU8buaI7kLL43HrG6WUZTj5ZeTCVUvB0ww1dsADaCxFhksiiNssd97ma1NhrkNx2Bkv2MhNSUcMCPvZltolraTfOKy+QOBxxVkBYc27RZgYbEyixfRNKKYCnI0DBAR+hN3b1rjFQ2weTS4Qe6UWcg6HJJUglWDNtnYBow7JEIclwYVxMqJ25J+oqeXbPSrcXO0vxdCNwfcQhT/ayy48phOrBq7GFz8BMwWEnTdqaEaSwaSJ1jvOPvI0s6qyRdeLrEKqcDxodOkyw9ripNlK1G/8vKtr4u+j6Qzahxoqf8Wuj9HjmpRJCoYTdeS51aRDYuxRiY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0t3dzFlRXhPSExSWUd0ZmNlV3AwZW5yeU5kR24rL0lKUmxwSTRvcnhuTEJu?=
 =?utf-8?B?OHVwWWh2c25JbDBLNnFReEE3ZzdVblduOUQ3R05MUWpOUUt1NEdIdkVUSWNJ?=
 =?utf-8?B?VGF3SEcvaVVhc3hsVkNrckR1SnhDYVM1bnFtUkt1N0tLWFRjVDY5Q0tKTXli?=
 =?utf-8?B?QVdDZW9NdnJqTmZ3NU8vQWhSZkFaOFFxdlg2YkhHVDIrcEpjZmVweHBwUVo5?=
 =?utf-8?B?NWZaN1VKQkx3RnR4Y0dwRmNrcktueldMRVA0MDdaZlN6ZzhnVlQ2UElTemRY?=
 =?utf-8?B?UFZpWW01S25laHZGOFpiZ3NUMnJsck14VHJiaHBEbGYrcjlCRlFmM1FEOUFZ?=
 =?utf-8?B?Vy9uclJ2TklHZ1FXYVlYZEI1aU9rOTk2dlRXVE9hOTFtMDM2T3NHU2xicGhn?=
 =?utf-8?B?eFc2Y0JKTW9odmZSK0hldVFVTE90RUlIcDg4VVJjbTB6QVVDZVB1NDhhVmJa?=
 =?utf-8?B?MFBnMGlUSXU4N09nZ05NbjVjYVpsamlTNkpvcTVrM3B6TEVDT3VKSVo2L2F0?=
 =?utf-8?B?czduNFhKQjlnL1RLZUsrc00wdzc3bFhuQ084OWxkcVNwQ1luRTZocEk3U3ow?=
 =?utf-8?B?K1JFc1ZmN0t6Z1RpV3N1TlZYNFlGaVl0TUtYZ0ZtOHN0TUZEenBxWk11V05H?=
 =?utf-8?B?aVRUa2FJK0NYMWhzRkhnMU5VQzhFN0VZMWxmdXRFaXg5YkpwazcyMjFiakcx?=
 =?utf-8?B?ditvVGlhQ3ZnZDZXRFlHMXBIeUVmQ282aWd4TS85akhmQ3dQQ0lmMTh2aUIv?=
 =?utf-8?B?TVVuckczSFdIK0hCbHBkYytqVGFORkE2bTRkaVo5MnlEZnBYUFM0SjhFYXNx?=
 =?utf-8?B?UlR4cmtoeWxZNGo2ekl1dVdnWHphK1R3a3hma0t0Z0JxdjlwUkpZd1AxR3V5?=
 =?utf-8?B?OVZWYXFxWlZ4QnVUbU8xSFJBRklmMHZjREU1OGN5MFQxcEVuYXFRa0dnTEFn?=
 =?utf-8?B?Wm03V2d6N0hPRVJ6QUQ4WFBTbmgzQmFLZmlxZ0N5MnlFV3J2OTFUQStPN1RU?=
 =?utf-8?B?VGJRTUlueVA1d0tkYk5sdVJwbmlxalNYcFd2b0pKQ05FbDlmak81ckV3V3dN?=
 =?utf-8?B?dDRYU3QwanZUMjVJZUQvWFVhNERYcVh5TmprcTVKbXpUbktPUWRyMWxUN3ZP?=
 =?utf-8?B?ZjBldWlrbzQ0T3FEanNLQnBkVVNDL2VJN3pQVXQ4bllTTjRZNm1MdFYxZ0Nr?=
 =?utf-8?B?YjAvT3grOEJNYmpuRUg2RE1rY0R6aW9HaVIwZ3AyejJ4M3NjQ0hNbEpSWGt0?=
 =?utf-8?B?dFRZeDFlS3EwSXVIOFVDZXJxNjRYY1hGM001OWZ2NkJmREJyQWFvbzJsU0lk?=
 =?utf-8?B?cnVneGdITUgxOFBjS1cxcURWZWRpSzdzRmxUSERsMHdqbkgxRDhjMVpUZGFP?=
 =?utf-8?B?UUJ0M0MxbEg5bGpUb3NOcS9ETWFwQ3U2N0hna3pyR1J6RUYrYTFDcEZ3NXJt?=
 =?utf-8?B?aXRPb0d1UTdrdTlUTFM1UFQ1anhKRHcxd1k2eEM0blpobzEzNWRJVzBzWmZY?=
 =?utf-8?B?TzlpMnlOVEF2UjRPMWlwRVlrR2lJU2VLazA0V0lSMy9CY3MxUm02RGd0K0xX?=
 =?utf-8?B?UVNkUGphbGdEeGZ2WmNsYk1RbzhvSk5MZGNCOWQwVEtPcmpEQkxrTlhrM0Nt?=
 =?utf-8?B?eUo2RGZZcGNwOGloNHZTRmZjWVg5QlNjcUxWejBOdGxvRis2ZUVNUXAyZ0lm?=
 =?utf-8?B?czhsSldZdlQ4cXNBVEdqRmJWc0JwVmsyS0xIb2ljcHZxbmVMQ2MvNkRLTTFj?=
 =?utf-8?B?YXJjL3NYam5VODV4V3lJY0hoZitna3Z4dHFRMm8xMWNIQUYwdXgwQ05ZWGF3?=
 =?utf-8?B?Sk5PVlN6S1hZZU9NU216bktva0kvN0g1MGZpUHdweldtMFdLRWNSWHExUmoz?=
 =?utf-8?B?KzRwaExSMzVhbWI3aDRIQWhPQktuYWNHK0ZHa2JydWUxcGlmbCtHMnl2TG1O?=
 =?utf-8?B?SWJ3YXNzRHh5MFMrVFZDV29OZEMyMGhlbVlxNXo2TlM5U3NCMG5NSmdmV3Fo?=
 =?utf-8?B?RXUwajJTeHg5bWs4Qm5aTVgzNm95ME50dFFQb2xBVDhvUVNnUUZiY3ZHSHVD?=
 =?utf-8?B?M1JJV3Myam9xa1U0bDF3Y2pnS0pHdko5MjNtYWg4RGJtb1A3citFcDc4WUpK?=
 =?utf-8?Q?G0TmsGl6AA3sfWCNbfEXDRmwi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2570369-9839-4ef9-7fde-08dc5adcdd93
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:39:43.7931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKnb3gXw1zjSaltvFe8AoSpQqHzFPS8+UGmYdaB3hvfJI7YGHDSyrYTThmHi3PN7Zn+2RI9bbt8M8q2qLN8kHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10147

From: Peng Fan <peng.fan@nxp.com>

The i.MX95 System manager exports SCMI MISC protocol for linux to do
various settings, such as set board gpio expander as wakeup source.

The driver is to add the support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/Makefile   |  1 +
 drivers/firmware/imx/sm-misc.c  | 92 +++++++++++++++++++++++++++++++++++++++++
 include/linux/firmware/imx/sm.h | 33 +++++++++++++++
 3 files changed, 126 insertions(+)

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index fb20e22074e1..cb9c361d9b81 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 obj-${CONFIG_IMX_SCMI_BBM_EXT}	+= sm-bbm.o
+obj-${CONFIG_IMX_SCMI_MISC_EXT}	+= sm-misc.o
diff --git a/drivers/firmware/imx/sm-misc.c b/drivers/firmware/imx/sm-misc.c
new file mode 100644
index 000000000000..a5609de426f6
--- /dev/null
+++ b/drivers/firmware/imx/sm-misc.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP.
+ */
+
+#include <linux/firmware/imx/sm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+static const struct scmi_imx_misc_proto_ops *imx_misc_ctrl_ops;
+static struct scmi_protocol_handle *ph;
+struct notifier_block scmi_imx_misc_ctrl_nb;
+
+int scmi_imx_misc_ctrl_set(u32 id, u32 val)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_misc_ctrl_ops->misc_ctrl_set(ph, id, 1, &val);
+};
+EXPORT_SYMBOL(scmi_imx_misc_ctrl_set);
+
+int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_misc_ctrl_ops->misc_ctrl_get(ph, id, num, val);
+}
+EXPORT_SYMBOL(scmi_imx_misc_ctrl_get);
+
+static int scmi_imx_misc_ctrl_notifier(struct notifier_block *nb,
+				       unsigned long event, void *data)
+{
+	return 0;
+}
+
+static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	struct device_node *np = sdev->dev.of_node;
+	u32 src_id, evt_id, wu_num;
+	int ret, i;
+
+	if (!handle)
+		return -ENODEV;
+
+	imx_misc_ctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_MISC, &ph);
+	if (IS_ERR(imx_misc_ctrl_ops))
+		return PTR_ERR(imx_misc_ctrl_ops);
+
+	scmi_imx_misc_ctrl_nb.notifier_call = &scmi_imx_misc_ctrl_notifier;
+	wu_num = of_property_count_u32_elems(np, "wakeup-sources");
+	if (wu_num % 2) {
+		dev_err(&sdev->dev, "Invalid wakeup-sources\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < wu_num; i += 2) {
+		WARN_ON(of_property_read_u32_index(np, "wakeup-sources", i, &src_id));
+		WARN_ON(of_property_read_u32_index(np, "wakeup-sources", i + 1, &evt_id));
+		ret = handle->notify_ops->devm_event_notifier_register(sdev, SCMI_PROTOCOL_IMX_MISC,
+								       evt_id,
+								       &src_id,
+								       &scmi_imx_misc_ctrl_nb);
+		if (ret)
+			dev_err(&sdev->dev, "Failed to register scmi misc event: %d\n", src_id);
+	}
+
+	return 0;
+
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_IMX_MISC, "imx-misc-ctrl" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_imx_misc_ctrl_driver = {
+	.name = "scmi-imx-misc-ctrl",
+	.probe = scmi_imx_misc_ctrl_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_imx_misc_ctrl_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("IMX SM MISC driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
new file mode 100644
index 000000000000..daad4bdf7d1c
--- /dev/null
+++ b/include/linux/firmware/imx/sm.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef _SCMI_IMX_H
+#define _SCMI_IMX_H
+
+#include <linux/bitfield.h>
+#include <linux/types.h>
+
+#define SCMI_IMX_CTRL_PDM_CLK_SEL	0	/* AON PDM clock sel */
+#define SCMI_IMX_CTRL_MQS1_SETTINGS	1	/* AON MQS settings */
+#define SCMI_IMX_CTRL_SAI1_MCLK		2	/* AON SAI1 MCLK */
+#define SCMI_IMX_CTRL_SAI3_MCLK		3	/* WAKE SAI3 MCLK */
+#define SCMI_IMX_CTRL_SAI4_MCLK		4	/* WAKE SAI4 MCLK */
+#define SCMI_IMX_CTRL_SAI5_MCLK		5	/* WAKE SAI5 MCLK */
+
+#if IS_ENABLED(CONFIG_IMX_SCMI_MISC_EXT)
+int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
+int scmi_imx_misc_ctrl_set(u32 id, u32 val);
+#else
+static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val);
+{
+	return -EOPNOTSUPP;
+}
+#endif
+#endif

-- 
2.37.1


