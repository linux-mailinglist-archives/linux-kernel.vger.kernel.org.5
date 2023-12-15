Return-Path: <linux-kernel+bounces-880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1D481476A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864CF285459
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6AC2DB9C;
	Fri, 15 Dec 2023 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NMk7+ohB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370B2EB0C;
	Fri, 15 Dec 2023 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDZRmnv3T5MoUQmsm2jAyyGBrP9J9vW40wgh7/QDhp+bmCBGudkne9b0urZ6mfQ7CR/p18dID7Rxefi/ppuX/X0iVHrMZup+FsdEFZn7/martqS94iYdWd46ToND4XetqCJ5m/s+oN4FWYpaFjKs/IaIGLKYazQRnDpoTHjklkCynryvCBtSCj/vb9Zr+9bSVvS/iR91gfr/uoI8mrM/DkVM1hfjuI16/XLkPF4fcy3t2Wa0fg/G9yYTU0zLAe3HL+Y48bUK4rUO/p7YDuPJ1wZaxnWRL1AmOtE2ZoN0rmnjNay86h9nVjUicpIN0tMYGZkR+tBTw/9vSxtv43CiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN96ildBqLDvq2WIcHAcgMwAIDICnlC+8rzVh+VDlEs=;
 b=d4yMxP4JEmiAlufrrzXh09rTvIcTiaDmdfhO/Bmx7bNO6B3Vmx9MDIVmIVE111izHcAaIFZ3YvouAe8mahLK+DwjdORNTdZ6ZfHP6sQQj6DLgD75SyMEmItMGK81F6yQqyK8dJ89uSBMfq1m9ZYenJLddBsoGt+Y3ytrD+UNYFyw3mP3sBh06xEZaHOGZVuRlm4P3UAoCKNp2ztqCsGEBZZAYbhi0UykBhxuIvADUZpEscfEWqmAxF2SZ5Ndra53gHyqo6aT/V2mnHEPbVNbvhsLz72j4I2SFXjt6X4dCp39UUFV1OaBCnrU+EEizihgDAbXaRxqbc4DUnF+I/tHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN96ildBqLDvq2WIcHAcgMwAIDICnlC+8rzVh+VDlEs=;
 b=NMk7+ohBSWsBgHh4ExJQiAZF4HqUVpfs8IuZVX+LvQwEd3ZWglV+TXXU40mKfM2duo6Ykls7yB0Dc4070ALcGJTkThHdT6Ou1q9h8t4OR3zqyzYveFYN1G6XARMn0O2meHaCaittzCFgYJnoAQdd0OCW+cUXbKCNrRu3bRGZ6cg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7435.eurprd04.prod.outlook.com (2603:10a6:102:88::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 11:52:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7046.015; Fri, 15 Dec 2023
 11:52:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 15 Dec 2023 19:56:35 +0800
Subject: [PATCH 7/7] pinctrl: scmi: implement
 pinctrl_scmi_imx_dt_node_to_map
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-pinctrl-scmi-v1-7-0fe35e4611f7@nxp.com>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
In-Reply-To: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702641405; l=7141;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=hHLUTZKZuOlBWYtnb/Z3rmokfWbUliFbIfvqAASsy0Q=;
 b=oCn9VoADN77j6GAHDGjstgLp27M8V6n13TPAPV6a01H1gJvoe2qdcMUAQ+C6HVBV8RxA5WSxW
 KVvvFfgOqd3DngOPSzW/dKDap8204Dn5u9g3Y7VBrgnvBBvWwVYMdAq
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: aecf0655-0225-4e05-ee95-08dbfd645b91
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wbosiIIDtRiUm+bc6G0OJWJDmyTZs1BFWu2tQ/OSqeQjFLemVkKsFNE4Nhoz9KvpXlg/Q1PFsQxgfBuMPTLJw2Re1rUto/EUdMGWhX+QuH7WNL/9m9yR9iba92p5Q0T86UFLRSQLF/5folLuSNsrVEbCAaDtsSMxdcYQpPPelctmAJTTa7aMbNEukeopSYA9zwmDEwcqXKxUgNOKJDbHEAj+zAFoUWcxLwtQSW+Au/IJW31jD90KtssX7J3xrE7RCaITtChYhJB5I14xuRnyqum3EWSe3C1JXO6dR6DLHopI4l+04XGIc44/4OBgpcTYNIlin9O8SDBth2IGK4mZ7eJ19zvqushAxN3r0iPfUjKrmHYgm33FZ2apPb2+xbXg6ekt3h/mRbGGPBr1FIlerr7EGSBGKT0iUlHAcJVIsMteto4P4GZlr2f/RZwzNFnpAWBX/E12/ggmvKrbZWEgBzqnsJdJj920axBXwn1caVtjmsNHHR1AMw9VXFyZXLjK+uM/Niv9KvFd3XNxQ+gmgzWfaU+iBbeOk99MZXOcDpK+jBku6KjgTQplcij4al5ikdlWufK6ij+tFAoL7Nz38cabXEizEFUHKA+7zELyMUPUxMxu7dFsKH9/GcVkjpoNALFXITieJewRfb1EQ1VVjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(86362001)(4326008)(8676002)(8936002)(5660300002)(7416002)(921008)(38350700005)(41300700001)(36756003)(478600001)(6486002)(83380400001)(26005)(6512007)(9686003)(6666004)(52116002)(6506007)(110136005)(66946007)(38100700002)(66556008)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1M3SlFhM2JwZ05ZcmxGd2ttekJtdnhiZmh2enZXUHV3RVRSMk1qejBaOVZH?=
 =?utf-8?B?aks3VHNKZWc4VEM2dGJNem1IOEJRYlV0QWxwUlJneEQ5UHQ5WGluNjF6RHRW?=
 =?utf-8?B?cEpaSWN2dm12WVFLb01IQTNKL3ovSUZuRk4xVEtVdS9VTkNZWTladTAvbkkr?=
 =?utf-8?B?R2JMQlp5ZC9yckpSRkJGSk5NY3BHRHVlNWtyT0k1QVhnd080akxxRUh6ejdP?=
 =?utf-8?B?SHN6dlVCekVUU1Z0eWZlSUJZSWxoTFFuTlYxUlBNTnh2Z2F5M0FETVdadFdX?=
 =?utf-8?B?aW1aN0JvVkpITEptWkJaYUdNdDF4NVpzMEEwMFlmVk9ENnpBTk51QjNUUnJJ?=
 =?utf-8?B?NVpGUXhhNnJzUGttTG5jZmNCNXhTaWViUHExNFdaSWdqWEt0N0RTWS96azQ0?=
 =?utf-8?B?TWlsUFJuQTNHY2wxeklpbHU4WW8xcUxBQkI3ekZ3S2JTZGhsa1VkOXFwRlo4?=
 =?utf-8?B?WUgydWdNU1AySkxoOVUyVVN2VG5UVk5OVWltSHAzS09nK21QT1dkL2FrRUdT?=
 =?utf-8?B?VS8xanJyMWdnQjJsOVFaVWxselBYTFBVY1R0TDNDbG41Z2FCdkZ3a2ltVkhn?=
 =?utf-8?B?NjEyUU5sN2pkWTV0MDF5Y24wYTk4L3lDKzI0ZGxveTlHU3VFSnZPdjgwTEZW?=
 =?utf-8?B?NCtTemxFUENrbjdBZnNlUUF6bmNiVXpvV0hGOXh6djA2UUF3TlI1eWpDOWNV?=
 =?utf-8?B?UG50U1FRNHVvdGZicHp5S2diVFlxa1d0YkRjWXFGMC9PRWRGc09SNC80VDZa?=
 =?utf-8?B?VjdYaDNtcW52QU03TWtCTTJVdWV6TTFuQ21Vc3d6UXhVZjdjdkRXSC9Pdm1J?=
 =?utf-8?B?ZEVTVXhGL3NsT2ZOMy91TnBpRkhpOXhpZHNSU3VVTHdYa3NVeWRPOERDTEVo?=
 =?utf-8?B?V0JLRkF1UXkyVURNd3pLdzFTOUF0VEVUTFJqN0hFRUJ1YTVyZnprTTlQclln?=
 =?utf-8?B?N1FQYzFqVVpPb29tVHNwS1NEUGNhMy9ndkZRR1pxekk1bS91VXF1QkZXR1VI?=
 =?utf-8?B?ZTQ3czZkc1QzN0RydVIycjN0K1B4dE5XbW1zVjB1SHNHVTlWV3REMFYvN3p0?=
 =?utf-8?B?emJ0azZ1djZaVnJkMUZmU29YNnhUV3M0a0k4T3NxaTdjSXkrL0VId0xMVi9F?=
 =?utf-8?B?c0VHQU1MUG5iTm5PU2NVRWpQQXhsMzJOSldaZkRFeDdmem5xSGZESUk0NEJi?=
 =?utf-8?B?Y0JzOVNRamNuUnorQ3dndTlrWUM5WjBCZjZUNlJ0a1JxUUkyeFBaWDBWODBX?=
 =?utf-8?B?TEhYQmgxc0NpbWR5OVVaM3lLa3JhQlpYSi80dWpOb1Rpcy9CMHlNSTl2QVFP?=
 =?utf-8?B?bHU4VjZlbVQ2aERDRE80aW95eUh6ZmZwRWpuTTFUR2hwZWtPd0I3SUk2dUNQ?=
 =?utf-8?B?UVNSVTQ1dWluNHYwTmlPQnFSd1gyRTR1TjBHQjd6ZnliOW1wYWpRTTFTS05G?=
 =?utf-8?B?dkp0YTdtYnpKRklMelVDWWdWSXR3RTJGNmdldkRJbGVna3ZQcVhlSnpqbm8z?=
 =?utf-8?B?MU13UjJXQXZjME45dGMxM2hpOHFYeGRaQXZWcHpuRmFNeWtURUNRTHFwSnJ2?=
 =?utf-8?B?ZGNpcEhEenA4K2dKY1lxRnlib2QwM28rdGIvMUo5WHkwUjhMN1FETFQrQ091?=
 =?utf-8?B?TWdnLy82THRKb1BkMWZVQ3FsOXVZMjZqSWdvTDlnemU4Z0NrTk1vd0xTc2lz?=
 =?utf-8?B?LzhjWGNLWU4xZDZadFJyWlNpa2E1ckl1U1RSNnlDMTlwL2xmdnJBNnNDa05n?=
 =?utf-8?B?Wlh1V3NPalIzTkY4alk5aHp5Mnh5Nkh4dGtRT1J6QlRMWXdrZVN2em9oQytT?=
 =?utf-8?B?OSsvOGlOZFUvcmd0VG9pODVsYkRvaC92R0hvV3NrWWYxQUZzU0RTSFRXZXo4?=
 =?utf-8?B?bHd1ZXpOMERIdVcrMGlVdE9oeU5MVXVJOSttRVA1RWhEV1pyWEJ2Y1AxVjNx?=
 =?utf-8?B?OExkZE1jZjZzYTlvcXlYZTB6T0lBSGJ1V2pvSDFvNzRtbXFiZnBiVXVVczY0?=
 =?utf-8?B?SGJFVndya2hlTTJ2VUtlV3RqMVlxbVRXa0NIaTk5QjhqVXhYcGZaVlBmMHp0?=
 =?utf-8?B?MTVNWUFTMGRNTDFnRGprYTdVWXpPNEc1MnpZNmJsdkF5Z3VNbDd4b2paN2NQ?=
 =?utf-8?Q?2ZtUqMWeTsGT7yUc1r++m1X7M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecf0655-0225-4e05-ee95-08dbfd645b91
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 11:52:47.9270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hipEiVaEzZ50fs42xF4NPsroMZIV2A6eviArP/QUU+Lb/Swy2JTpZ/17qN31oA/Qu77lft51FtFLauMhT/+ADA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7435

From: Peng Fan <peng.fan@nxp.com>

i.MX95 System Manager FW supports SCMI PINCTRL protocol, but uses
OEM Pin Configuration type, so need i.MX specific dt_node_to_map.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/Makefile           |   2 +-
 drivers/pinctrl/pinctrl-scmi-imx.c | 117 +++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-scmi.c     |  16 +++++
 drivers/pinctrl/pinctrl-scmi.h     |  12 ++++
 4 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index ba755ed2d46c..d96b7ede1355 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -44,7 +44,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
 obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
 obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
-obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
+obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o pinctrl-scmi-imx.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
diff --git a/drivers/pinctrl/pinctrl-scmi-imx.c b/drivers/pinctrl/pinctrl-scmi-imx.c
new file mode 100644
index 000000000000..e9d02e4c2cc1
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi-imx.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include "pinctrl-scmi.h"
+#include "pinctrl-utils.h"
+#include "core.h"
+#include "pinconf.h"
+
+/* SCMI pin control types, aligned with SCMI firmware */
+#define IMX_SCMI_PIN_TYPE_MUX		192
+#define IMX_SCMI_PIN_TYPE_CONFIG	193
+#define IMX_SCMI_PIN_TYPE_DAISY_ID	194
+#define IMX_SCMI_PIN_TYPE_DAISY_CFG	195
+
+#define IMX_SCMI_NO_PAD_CTL		BIT(31)
+#define IMX_SCMI_PAD_SION		BIT(30)
+#define IMX_SCMI_IOMUXC_CONFIG_SION	BIT(4)
+
+#define IMX_SCMI_NUM_CFG	4
+#define IMX_SCMI_PIN_SIZE	24
+
+int pinctrl_scmi_imx_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node *np,
+				    struct pinctrl_map **map, unsigned int *num_maps)
+{
+	struct pinctrl_map *new_map;
+	const __be32 *list;
+	unsigned long *configs = NULL;
+	unsigned long cfg[IMX_SCMI_NUM_CFG];
+	int map_num, size, pin_size, pin_id, num_pins;
+	int mux_reg, conf_reg, input_reg, mux_val, conf_val, input_val;
+	int i, j;
+	uint32_t ncfg;
+	static uint32_t daisy_off;
+
+	if (!daisy_off) {
+		if (of_machine_is_compatible("fsl,imx95"))
+			daisy_off = 0x408;
+		else
+			dev_err(pctldev->dev, "platform not support scmi pinctrl\n");
+	}
+
+	list = of_get_property(np, "fsl,pins", &size);
+	if (!list) {
+		dev_err(pctldev->dev, "no fsl,pins property in node %pOF\n", np);
+		return -EINVAL;
+	}
+
+	pin_size = IMX_SCMI_PIN_SIZE;
+
+	if (!size || size % pin_size) {
+		dev_err(pctldev->dev, "Invalid fsl,pins or pins property in node %pOF\n", np);
+		return -EINVAL;
+	}
+
+	num_pins = size / pin_size;
+	map_num = num_pins;
+
+	new_map = kmalloc_array(map_num, sizeof(struct pinctrl_map),
+				GFP_KERNEL);
+	if (!new_map)
+		return -ENOMEM;
+
+	*map = new_map;
+	*num_maps = map_num;
+
+	/* create config map */
+	for (i = 0; i < num_pins; i++) {
+		j = 0;
+		ncfg = IMX_SCMI_NUM_CFG;
+		mux_reg = be32_to_cpu(*list++);
+		conf_reg = be32_to_cpu(*list++);
+		input_reg = be32_to_cpu(*list++);
+		mux_val = be32_to_cpu(*list++);
+		input_val = be32_to_cpu(*list++);
+		conf_val = be32_to_cpu(*list++);
+		if (conf_val & IMX_SCMI_PAD_SION)
+			mux_val |= IMX_SCMI_IOMUXC_CONFIG_SION;
+
+		pin_id = mux_reg / 4;
+
+		cfg[j++] = pinconf_to_config_packed(IMX_SCMI_PIN_TYPE_MUX, mux_val);
+
+		if (!conf_reg || (conf_val & IMX_SCMI_NO_PAD_CTL))
+			ncfg--;
+		else
+			cfg[j++] = pinconf_to_config_packed(IMX_SCMI_PIN_TYPE_CONFIG, conf_val);
+
+		if (!input_reg) {
+			ncfg -= 2;
+		} else {
+			cfg[j++] = pinconf_to_config_packed(IMX_SCMI_PIN_TYPE_DAISY_ID,
+							    (input_reg - daisy_off) / 4);
+			cfg[j++] = pinconf_to_config_packed(IMX_SCMI_PIN_TYPE_DAISY_CFG, input_val);
+		}
+
+		configs = kmemdup(cfg, ncfg * sizeof(unsigned long), GFP_KERNEL);
+
+		new_map[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
+		new_map[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_id);
+		new_map[i].data.configs.configs = configs;
+		new_map[i].data.configs.num_configs = ncfg;
+	}
+
+	return 0;
+}
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index 0710ce9a1b42..e677e2064ba7 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/seq_file.h>
 #include <linux/scmi_protocol.h>
 #include <linux/slab.h>
@@ -18,6 +19,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
+#include "pinctrl-scmi.h"
 #include "pinctrl-utils.h"
 #include "core.h"
 #include "pinconf.h"
@@ -86,6 +88,16 @@ static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops = {
 #endif
 };
 
+static const struct pinctrl_ops pinctrl_scmi_imx_pinctrl_ops = {
+	.get_groups_count = pinctrl_scmi_get_groups_count,
+	.get_group_name = pinctrl_scmi_get_group_name,
+	.get_group_pins = pinctrl_scmi_get_group_pins,
+#ifdef CONFIG_OF
+	.dt_node_to_map = pinctrl_scmi_imx_dt_node_to_map,
+	.dt_free_map = pinconf_generic_dt_free_map,
+#endif
+};
+
 static int pinctrl_scmi_get_functions_count(struct pinctrl_dev *pctldev)
 {
 	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
@@ -327,6 +339,7 @@ static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
 
 static const struct scmi_device_id scmi_id_table[] = {
 	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
+	{ SCMI_PROTOCOL_PINCTRL, "pinctrl-scmi-imx", "fsl,imx95-scmi-pinctrl" },
 	{ }
 };
 MODULE_DEVICE_TABLE(scmi, scmi_id_table);
@@ -361,6 +374,9 @@ static int scmi_pinctrl_probe(struct scmi_device *sdev)
 	pmx->pctl_desc.pmxops = &pinctrl_scmi_pinmux_ops;
 	pmx->pctl_desc.confops = &pinctrl_scmi_pinconf_ops;
 
+	if (device_is_compatible(dev, "fsl,imx95-scmi-pinctrl"))
+		pmx->pctl_desc.pctlops = &pinctrl_scmi_imx_pinctrl_ops;
+
 	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc.npins,
 				    &pmx->pctl_desc.pins);
 	if (ret)
diff --git a/drivers/pinctrl/pinctrl-scmi.h b/drivers/pinctrl/pinctrl-scmi.h
new file mode 100644
index 000000000000..25863b4428fe
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2023 NXP
+ */
+
+#ifndef __DRIVERS_PINCTRL_SCMI_H
+#define __DRIVERS_PINCTRL_SCMI_H
+
+int pinctrl_scmi_imx_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node *np,
+				    struct pinctrl_map **map, unsigned int *num_maps);
+
+#endif /* __DRIVERS_PINCTRL_SCMI_H */

-- 
2.37.1


