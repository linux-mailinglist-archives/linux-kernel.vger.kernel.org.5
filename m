Return-Path: <linux-kernel+bounces-83105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D128868E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93FB5B28961
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22841139584;
	Tue, 27 Feb 2024 11:11:39 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE91386CB;
	Tue, 27 Feb 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032297; cv=fail; b=J07XLMvuReEoJvxoa2cje5VcdcCvDa5hsFlAzxlzxa7oGnvAnUinPOx9Pzs0GRH2gJrfuEt5z9gHljB5untYSFg9BRwfQ2UnaGmH/q03at2jKUYExgpkZ2GnqylRmf//3h0D84AkOOvoQf0IzSp8LpTIHZ6f5MIhmdF6+daANf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032297; c=relaxed/simple;
	bh=E4MuPUYzusFcv5qxoAvR7HYbKqITw/fcPp0xXIyjL3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KQXo50LsNnQCP7E9pn1QDU7rY/SkpDQxcrUcp+bTnRVACh3QAGCgAvuuw5oCPKnKRiqqyhJ3fUmQgPSGcfk8hHlFz9JVa3x4cM/r3Y1MUQzgyIHKM9aZtDET7hCnELjuNbbY6/pllU+yDgQyv6s3F4VGMEPobcaUPgbrnvk+i94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENiuSpH4BWrg7goIZYXXyVp5EV/11AkUNWJ/4jmEwgttefsvnXF3YHZloB50IeZI6HjOz2cViTxt4rH3xZkjMxrrTNqNpf1shctpJiHlwDUFrkz0eFDcoUjMQkv8+kHhS3wQOM8kmTJWmznl6yMCInsoqq5tq31B/NUOblVy+qeKL7vKkNPEyBIEWuRjSGF6Ko4QhUSz1A0lsIkqCu2rWsdDudnkkMskeREgayA8Ddq8Qm86e6qAGRO8humpBQhmZDbcMvF6BYhjtaoHPegfcRKixb6sgSlNEtm6xtMbuDZBzSc2IXsf0ixXMLNIglAk3YrcusTMiNUThoOKzr2qcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEeNglHCepgfRZUSLqLswWHDPSV+ixokl0sZx6amgvk=;
 b=EV4G20UvYCY6QK6BR42VGSXc4GeL3K3TVsyQvoEw0uo362OhDGPrvpuSoiZUsr6JtW21gBZdef3/HtUzOBPtWBMjAoY6ZzIqCLots+Jhxfiyz2Zq9WiRdWyk+2w+XbjiQeBFGaSknYHMJ9J1wL8H9YvhFpCX5PRrXVwkfkeKpg7IJRzY730gZ3n1aBPUIGPWeJ6vOepk7mN3fsYsjjGZ3A9hgHL+ePsErW53ijfUbYsRZUWG3dgqPYq7hCngLVcJQKfZLuytG3cVb7ruHoJhQE6p/E3VwGWIdScHQULj0XQ4xOCYppR3lnGAvkL/JYczhxdKRpC0891vXbk7sS3I+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:51 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:51 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v15,RESEND 21/23] PCI: starfive: Add JH7110 PCIe controller
Date: Tue, 27 Feb 2024 18:35:20 +0800
Message-Id: <20240227103522.80915-22-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240227103522.80915-1-minda.chen@starfivetech.com>
References: <20240227103522.80915-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_
X-MS-Office365-Filtering-Correlation-Id: 8381a3b7-0b8b-459f-d062-08dc377fde5b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UGh3ToDm63ozUQrBFMMIeisr97dF9Ri0RMs/H8gbro1UlhoMezWvCeVub4WHl+NOep3iLU747t/mQZvNf01b06CNkjpdZW4ELHLLughuW3ZhcYhOhvzK1WGBV0geJ+79H1iIxKgfS63MO9ycg4aDOJpiJdyFV+WEadwumD/qJfT21bJd+HzAKyiM5lNcSzGwvHnY7txNgAn12Zk+4VNyZz4pyU2o1eBXsEWhZ0UN6O3FAS/0cpjSjgnfE4WcEAaYpas1FFTrheflLasS5axMD5ogFpYdJWxwYJcDvP+Z4S+4xSrUnf5SWQrqIRF6dy1h4ea5srFrQc8/iJGkUyiJMHdB//Wd/nf90YNMGqhNobBLE8mnvNMOvDQAhCaodTxxEXGWJ5YXcIjMA+AB3Dleknusp/DJwrUcTMDfktt/ESDIaaEc7MOrnTRNKeAcAcvQtgLMGeRJyu4L3K42xGXCZ5MkDAidaLgjEV1F97Pw+dgBvLdJa+dlnCz/q5olMEEo8YZVj8ycAIgQ+7wNTJdnNfydy8zOokfGoR8W9s4k4VEfB9FFmfTv9pAMkpaNERN6bxRkQJlSJ6/uFO3TaFsPypjp/Go/HQRLNh3KK2dqPieZu2qnpbYBMK+3jLS6Bd3o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vRULJwIq94iNvwAbV8YCdcpcGrwH8DERJtMHmR901ZbrHUw5Vq0gx8XuAPfy?=
 =?us-ascii?Q?TqlUivVHeeANdV4NXv7yopTenK65d9sFjPeYo7MZbddaIr46idCIiOgN+UMC?=
 =?us-ascii?Q?sE5JyVllA9lldg9dDopAoE1vxZt5JEU7THgNATvUabi3U0Z3AA9GhEXHvx2f?=
 =?us-ascii?Q?/GvOeObeJkQrz9gFCM2V4V6f+PAtiOqsVllG9A5/txHaD91t1TJikLOLqJ5n?=
 =?us-ascii?Q?3OHpsTXMC+lqyMQb5lwfGrVGc+jYbeHZ87NWkx2yo4DSz0qIIdEzRp2AN+WC?=
 =?us-ascii?Q?IKn/ofjjrd7aXZsSNRxWWygWNocBqgIV5mzPvqPwUbZcv8vgmqF42yJoMuYu?=
 =?us-ascii?Q?P3rbXT1870AZxKTp5hZJAyGkrwz/GGZuE3bWly8DxYrUZ0IvBt6U+htXgKvB?=
 =?us-ascii?Q?UdeOZBHMmbBlZDJHA9KvHBYskcPfEDaHRzZClUkn/oXkBw+WTk/DoA9QjgWa?=
 =?us-ascii?Q?2XFn8FBX7y0+RfVekBXeaU5pqPMFUl3CY7bJg+06MKJaj+OnMP72+pMi6Gda?=
 =?us-ascii?Q?Xfq+LGuNnVP1KuCtyI89L7jYyVveY4Bf+GPHj8s3bhqsjDu+YLuPWOOUODOx?=
 =?us-ascii?Q?XcyOhsXDt9Ln0QJ7FjHy8ryh1baMO4mTYZPWaM3OIQ2y2/iLfV0GKS/Mdnle?=
 =?us-ascii?Q?pPS1dQFlF18HJidcVWw4J54eLMLjyvGpSYRe1IRGVenjcUPKL39rV8N21wXy?=
 =?us-ascii?Q?lMcn6p8hFRMgpG2oQYFGOPJxm+fUICkxYhjpJkze8KmEx6HZmNvN4IQqA1to?=
 =?us-ascii?Q?sHX4vwaBumsEXTPzSee/SloA/lPbNx4MJU6MThX/AAh+XHV4jTAGymrEpBsl?=
 =?us-ascii?Q?4Y0F/iUDArAQLbYS/T9fZa0nJc/2RqcUXqn69wbOhFgRdGjdI4JJpQZnryub?=
 =?us-ascii?Q?h5DTGttc5uB3ll+lxylECj1kwax9tXP+YfHRjqEdYcrRYZLXv8YtseKulJia?=
 =?us-ascii?Q?1ZyOwfHPICdfYaOQpmSEYoHJjenwCaRL4AUBVbXVKKJBNiED1NKj0r+WXnjw?=
 =?us-ascii?Q?+AhMhJTTeScBXLtywQ30IukDQ9Iv3hpJOi/QQRRHWRCKDRjsmRw3Rbn1qty2?=
 =?us-ascii?Q?L+/8cL3ghQaduVMyMCDqCEcE3fV4d2JaK//35hPQtm5m74APJEd/jYsChfEq?=
 =?us-ascii?Q?CcTpJ5BHUmxN1TzGCQ//FukrCty15Q80xphQg3R5zbNQf3N/XqUOd6U30mIp?=
 =?us-ascii?Q?I0UC5mFmeFg7NS5UpQY9hsWXZ3kjCfvCB0o28EUwk48GEQDFMPMvvuv5G6EB?=
 =?us-ascii?Q?oOb8ybBS0hj80K1dAtYqwD2HmnBTkE1JoFocanuUNW8MUNqiLQ2aK0ybODWW?=
 =?us-ascii?Q?ar1u/GYWY2KotcnX4zZ09wPj/sfIf9ud0RUuMvi1YynX4wsU6nVNYi+OT0Vp?=
 =?us-ascii?Q?fqjOUBCXI1hoD333/of8y4DmqwbrJO45+0cDJxw4M1AJoi24RGSnp3N2R4j5?=
 =?us-ascii?Q?25H2bAg/iIXGBIx8hzZQJl9Z7ixoBkRKkNaSlrkDrxSLFH1oqFs7vUQbzq+f?=
 =?us-ascii?Q?Nl6D3ykHfy6YEBba4vUYLroNeDeteb8N+hRJTpvs4XkbDNxZdGmUv4rvyw19?=
 =?us-ascii?Q?Cvpb9SeXtpuf64vcSxnqnRQ8mgbkzqHoaMLA9JBI5OyUmxJXn7KXyhEZgspP?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8381a3b7-0b8b-459f-d062-08dc377fde5b
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:51.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8vZKrIjHRMI2rpS19WrUqalsWRCp27u4di4w3hwaLTZz8tPOiaf3zGoN/2MJQs9UwcXs5cffcGzY/6UYi4U6CADjzNQrl43uodFuk5SODo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0863

Add StarFive JH7110 SoC PCIe controller platform driver codes, JH7110
with PLDA host PCIe core.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Co-developed-by: Kevin Xie <kevin.xie@starfivetech.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
---
 MAINTAINERS                                 |   7 +
 drivers/pci/controller/plda/Kconfig         |  12 +
 drivers/pci/controller/plda/Makefile        |   1 +
 drivers/pci/controller/plda/pcie-plda.h     |  71 ++-
 drivers/pci/controller/plda/pcie-starfive.c | 473 ++++++++++++++++++++
 5 files changed, 563 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/controller/plda/pcie-starfive.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fc9576e69a71..d3b0a0fb754f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17078,6 +17078,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/socionext,uniphier-pcie*
 F:	drivers/pci/controller/dwc/pcie-uniphier*
 
+PCIE DRIVER FOR STARFIVE JH71x0
+M:	Kevin Xie <kevin.xie@starfivetech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/starfive*
+F:	drivers/pci/controller/plda/pcie-starfive.c
+
 PCIE DRIVER FOR ST SPEAR13XX
 M:	Pratyush Anand <pratyush.anand@gmail.com>
 L:	linux-pci@vger.kernel.org
diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
index e54a82ee94f5..c0e14146d7e4 100644
--- a/drivers/pci/controller/plda/Kconfig
+++ b/drivers/pci/controller/plda/Kconfig
@@ -15,4 +15,16 @@ config PCIE_MICROCHIP_HOST
 	  Say Y here if you want kernel to support the Microchip AXI PCIe
 	  Host Bridge driver.
 
+config PCIE_STARFIVE_HOST
+	tristate "StarFive PCIe host controller"
+	depends on PCI_MSI && OF
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select PCIE_PLDA_HOST
+	help
+	  Say Y here if you want to support the StarFive PCIe controller in
+	  host mode. StarFive PCIe controller uses PLDA PCIe core.
+
+	  If you choose to build this driver as module it will be dynamically
+	  linked and module will be called pcie-starfive.ko.
+
 endmenu
diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controller/plda/Makefile
index 4340ab007f44..0ac6851bed48 100644
--- a/drivers/pci/controller/plda/Makefile
+++ b/drivers/pci/controller/plda/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_PLDA_HOST) += pcie-plda-host.o
 obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
+obj-$(CONFIG_PCIE_STARFIVE_HOST) += pcie-starfive.o
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 7b69891700a4..04e385758a2f 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -10,10 +10,20 @@
 #define PLDA_MAX_NUM_MSI_IRQS			32
 
 /* PCIe Bridge Phy Regs */
+#define GEN_SETTINGS				0x80
+#define  RP_ENABLE				1
+#define PCIE_PCI_IDS_DW1			0x9c
+#define  IDS_CLASS_CODE_SHIFT			16
+#define  REVISION_ID_MASK			GENMASK(7, 0)
+#define  CLASS_CODE_ID_MASK			GENMASK(31, 8)
 #define PCIE_PCI_IRQ_DW0			0xa8
 #define  MSIX_CAP_MASK				BIT(31)
 #define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
 #define  NUM_MSI_MSGS_SHIFT			4
+#define PCI_MISC				0xb4
+#define  PHY_FUNCTION_DIS			BIT(15)
+#define PCIE_WINROM				0xfc
+#define  PREF_MEM_WIN_64_SUPPORT		BIT(3)
 
 #define IMASK_LOCAL				0x180
 #define  DMA_END_ENGINE_0_MASK			0x00000000u
@@ -65,6 +75,8 @@
 #define ISTATUS_HOST				0x18c
 #define IMSI_ADDR				0x190
 #define ISTATUS_MSI				0x194
+#define PMSG_SUPPORT_RX				0x3f0
+#define  PMSG_LTR_SUPPORT			BIT(2)
 
 /* PCIe Master table init defines */
 #define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
@@ -86,6 +98,8 @@
 #define  PCIE_TX_RX_INTERFACE			0x00000000u
 #define  PCIE_CONFIG_INTERFACE			0x00000001u
 
+#define CONFIG_SPACE_ADDR_OFFSET		0x1000u
+
 #define ATR_ENTRY_SIZE				32
 
 enum plda_int_event {
@@ -200,4 +214,59 @@ static inline void plda_set_default_msi(struct plda_msi *msi)
 	msi->vector_phy = IMSI_ADDR;
 	msi->num_vectors = PLDA_MAX_NUM_MSI_IRQS;
 }
-#endif
+
+static inline void plda_pcie_enable_root_port(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + GEN_SETTINGS);
+	value |= RP_ENABLE;
+	writel_relaxed(value, plda->bridge_addr + GEN_SETTINGS);
+}
+
+static inline void plda_pcie_set_standard_class(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	/* set class code and reserve revision id */
+	value = readl_relaxed(plda->bridge_addr + PCIE_PCI_IDS_DW1);
+	value &= REVISION_ID_MASK;
+	value |= (PCI_CLASS_BRIDGE_PCI << IDS_CLASS_CODE_SHIFT);
+	writel_relaxed(value, plda->bridge_addr + PCIE_PCI_IDS_DW1);
+}
+
+static inline void plda_pcie_set_pref_win_64bit(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + PCIE_WINROM);
+	value |= PREF_MEM_WIN_64_SUPPORT;
+	writel_relaxed(value, plda->bridge_addr + PCIE_WINROM);
+}
+
+static inline void plda_pcie_disable_ltr(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + PMSG_SUPPORT_RX);
+	value &= ~PMSG_LTR_SUPPORT;
+	writel_relaxed(value, plda->bridge_addr + PMSG_SUPPORT_RX);
+}
+
+static inline void plda_pcie_disable_func(struct plda_pcie_rp *plda)
+{
+	u32 value;
+
+	value = readl_relaxed(plda->bridge_addr + PCI_MISC);
+	value |= PHY_FUNCTION_DIS;
+	writel_relaxed(value, plda->bridge_addr + PCI_MISC);
+}
+
+static inline void plda_pcie_write_rc_bar(struct plda_pcie_rp *plda, u64 val)
+{
+	void __iomem *addr = plda->bridge_addr + CONFIG_SPACE_ADDR_OFFSET;
+
+	writel_relaxed(lower_32_bits(val), addr + PCI_BASE_ADDRESS_0);
+	writel_relaxed(upper_32_bits(val), addr + PCI_BASE_ADDRESS_1);
+}
+#endif /* _PCIE_PLDA_H */
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
new file mode 100644
index 000000000000..9bb9f0e29565
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCIe host controller driver for StarFive JH7110 Soc.
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include "../../pci.h"
+
+#include "pcie-plda.h"
+
+#define PCIE_FUNC_NUM			4
+
+/* system control */
+#define STG_SYSCON_PCIE0_BASE			0x48
+#define STG_SYSCON_PCIE1_BASE			0x1f8
+
+#define STG_SYSCON_AR_OFFSET			0x78
+#define STG_SYSCON_AXI4_SLVL_AR_MASK		GENMASK(22, 8)
+#define STG_SYSCON_AXI4_SLVL_PHY_AR(x)		FIELD_PREP(GENMASK(20, 17), x)
+#define STG_SYSCON_AW_OFFSET			0x7c
+#define STG_SYSCON_AXI4_SLVL_AW_MASK		GENMASK(14, 0)
+#define STG_SYSCON_AXI4_SLVL_PHY_AW(x)		FIELD_PREP(GENMASK(12, 9), x)
+#define STG_SYSCON_CLKREQ			BIT(22)
+#define STG_SYSCON_CKREF_SRC_MASK		GENMASK(19, 18)
+#define STG_SYSCON_RP_NEP_OFFSET		0xe8
+#define STG_SYSCON_K_RP_NEP			BIT(8)
+#define STG_SYSCON_LNKSTA_OFFSET		0x170
+#define DATA_LINK_ACTIVE			BIT(5)
+
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES	10
+#define LINK_WAIT_USLEEP_MIN	90000
+#define LINK_WAIT_USLEEP_MAX	100000
+
+struct starfive_jh7110_pcie {
+	struct plda_pcie_rp plda;
+	struct reset_control *resets;
+	struct clk_bulk_data *clks;
+	struct regmap *reg_syscon;
+	struct gpio_desc *power_gpio;
+	struct gpio_desc *reset_gpio;
+	struct phy *phy;
+
+	unsigned int stg_pcie_base;
+	int num_clks;
+};
+
+/*
+ * The BAR0/1 of bridge should be hidden during enumeration to
+ * avoid the sizing and resource allocation by PCIe core.
+ */
+static bool starfive_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int devfn,
+				      int offset)
+{
+	if (pci_is_root_bus(bus) && !devfn &&
+	    (offset == PCI_BASE_ADDRESS_0 || offset == PCI_BASE_ADDRESS_1))
+		return true;
+
+	return false;
+}
+
+static int starfive_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+				      int where, int size, u32 value)
+{
+	if (starfive_pcie_hide_rc_bar(bus, devfn, where))
+		return PCIBIOS_SUCCESSFUL;
+
+	return pci_generic_config_write(bus, devfn, where, size, value);
+}
+
+static int starfive_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+				     int where, int size, u32 *value)
+{
+	if (starfive_pcie_hide_rc_bar(bus, devfn, where)) {
+		*value = 0;
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+	return pci_generic_config_read(bus, devfn, where, size, value);
+}
+
+static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie,
+				  struct device *dev)
+{
+	int domain_nr;
+
+	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
+	if (pcie->num_clks < 0)
+		return dev_err_probe(dev, pcie->num_clks,
+				     "failed to get pcie clocks\n");
+
+	pcie->resets = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(pcie->resets))
+		return dev_err_probe(dev, PTR_ERR(pcie->resets),
+				     "failed to get pcie resets");
+
+	pcie->reg_syscon =
+		syscon_regmap_lookup_by_phandle(dev->of_node,
+						"starfive,stg-syscon");
+
+	if (IS_ERR(pcie->reg_syscon))
+		return dev_err_probe(dev, PTR_ERR(pcie->reg_syscon),
+				     "failed to parse starfive,stg-syscon\n");
+
+	pcie->phy = devm_phy_optional_get(dev, NULL);
+	if (IS_ERR(pcie->phy))
+		return dev_err_probe(dev, PTR_ERR(pcie->phy),
+				     "failed to get pcie phy\n");
+
+	domain_nr = of_get_pci_domain_nr(dev->of_node);
+
+	if (domain_nr < 0 || domain_nr > 1)
+		return dev_err_probe(dev, -ENODEV,
+				     "failed to get valid pcie domain\n");
+
+	if (domain_nr == 0)
+		pcie->stg_pcie_base = STG_SYSCON_PCIE0_BASE;
+	else
+		pcie->stg_pcie_base = STG_SYSCON_PCIE1_BASE;
+
+	pcie->reset_gpio = devm_gpiod_get_optional(dev, "perst",
+						   GPIOD_OUT_HIGH);
+	if (IS_ERR(pcie->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
+				     "failed to get perst-gpio\n");
+
+	pcie->power_gpio = devm_gpiod_get_optional(dev, "enable",
+						   GPIOD_OUT_LOW);
+	if (IS_ERR(pcie->power_gpio))
+		return dev_err_probe(dev, PTR_ERR(pcie->power_gpio),
+				     "failed to get power-gpio\n");
+
+	return 0;
+}
+
+static struct pci_ops starfive_pcie_ops = {
+	.map_bus	= plda_pcie_map_bus,
+	.read           = starfive_pcie_config_read,
+	.write          = starfive_pcie_config_write,
+};
+
+static int starfive_pcie_clk_rst_init(struct starfive_jh7110_pcie *pcie)
+{
+	struct device *dev = pcie->plda.dev;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable clocks\n");
+
+	ret = reset_control_deassert(pcie->resets);
+	if (ret) {
+		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+		dev_err_probe(dev, ret, "failed to deassert resets\n");
+	}
+
+	return ret;
+}
+
+static void starfive_pcie_clk_rst_deinit(struct starfive_jh7110_pcie *pcie)
+{
+	reset_control_assert(pcie->resets);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+}
+
+static bool starfive_pcie_link_up(struct plda_pcie_rp *plda)
+{
+	struct starfive_jh7110_pcie *pcie =
+		container_of(plda, struct starfive_jh7110_pcie, plda);
+	int ret;
+	u32 stg_reg_val;
+
+	ret = regmap_read(pcie->reg_syscon,
+			  pcie->stg_pcie_base + STG_SYSCON_LNKSTA_OFFSET,
+			  &stg_reg_val);
+	if (ret) {
+		dev_err(pcie->plda.dev, "failed to read link status\n");
+		return false;
+	}
+
+	return !!(stg_reg_val & DATA_LINK_ACTIVE);
+}
+
+static int starfive_pcie_host_wait_for_link(struct starfive_jh7110_pcie *pcie)
+{
+	int retries;
+
+	/* Check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (starfive_pcie_link_up(&pcie->plda)) {
+			dev_info(pcie->plda.dev, "port link up\n");
+			return 0;
+		}
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int starfive_pcie_enable_phy(struct device *dev,
+				    struct starfive_jh7110_pcie *pcie)
+{
+	int ret;
+
+	if (!pcie->phy)
+		return 0;
+
+	ret = phy_init(pcie->phy);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to initialize pcie phy\n");
+
+	ret = phy_set_mode(pcie->phy, PHY_MODE_PCIE);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to set pcie mode\n");
+		goto err_phy_on;
+	}
+
+	ret = phy_power_on(pcie->phy);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to power on pcie phy\n");
+		goto err_phy_on;
+	}
+
+	return 0;
+
+err_phy_on:
+	phy_exit(pcie->phy);
+	return ret;
+}
+
+static void starfive_pcie_disable_phy(struct starfive_jh7110_pcie *pcie)
+{
+	phy_power_off(pcie->phy);
+	phy_exit(pcie->phy);
+}
+
+static void starfive_pcie_host_deinit(struct plda_pcie_rp *plda)
+{
+	struct starfive_jh7110_pcie *pcie =
+		container_of(plda, struct starfive_jh7110_pcie, plda);
+
+	starfive_pcie_clk_rst_deinit(pcie);
+	if (pcie->power_gpio)
+		gpiod_set_value_cansleep(pcie->power_gpio, 0);
+	starfive_pcie_disable_phy(pcie);
+}
+
+static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
+{
+	struct starfive_jh7110_pcie *pcie =
+		container_of(plda, struct starfive_jh7110_pcie, plda);
+	struct device *dev = plda->dev;
+	int ret;
+	int i;
+
+	ret = starfive_pcie_enable_phy(dev, pcie);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_RP_NEP_OFFSET,
+			   STG_SYSCON_K_RP_NEP, STG_SYSCON_K_RP_NEP);
+
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_AW_OFFSET,
+			   STG_SYSCON_CKREF_SRC_MASK,
+			   FIELD_PREP(STG_SYSCON_CKREF_SRC_MASK, 2));
+
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_AW_OFFSET,
+			   STG_SYSCON_CLKREQ, STG_SYSCON_CLKREQ);
+
+	ret = starfive_pcie_clk_rst_init(pcie);
+	if (ret)
+		return ret;
+
+	if (pcie->power_gpio)
+		gpiod_set_value_cansleep(pcie->power_gpio, 1);
+
+	if (pcie->reset_gpio)
+		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+
+	/* Disable physical functions except #0 */
+	for (i = 1; i < PCIE_FUNC_NUM; i++) {
+		regmap_update_bits(pcie->reg_syscon,
+				   pcie->stg_pcie_base + STG_SYSCON_AR_OFFSET,
+				   STG_SYSCON_AXI4_SLVL_AR_MASK,
+				   STG_SYSCON_AXI4_SLVL_PHY_AR(i));
+
+		regmap_update_bits(pcie->reg_syscon,
+				   pcie->stg_pcie_base + STG_SYSCON_AW_OFFSET,
+				   STG_SYSCON_AXI4_SLVL_AW_MASK,
+				   STG_SYSCON_AXI4_SLVL_PHY_AW(i));
+
+		plda_pcie_disable_func(plda);
+	}
+
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_AR_OFFSET,
+			   STG_SYSCON_AXI4_SLVL_AR_MASK, 0);
+	regmap_update_bits(pcie->reg_syscon,
+			   pcie->stg_pcie_base + STG_SYSCON_AW_OFFSET,
+			   STG_SYSCON_AXI4_SLVL_AW_MASK, 0);
+
+	plda_pcie_enable_root_port(plda);
+	plda_pcie_write_rc_bar(plda, 0);
+
+	/* PCIe PCI Standard Configuration Identification Settings. */
+	plda_pcie_set_standard_class(plda);
+
+	/*
+	 * The LTR message forwarding of PCIe Message Reception was set by core
+	 * as default, but the forward id & addr are also need to be reset.
+	 * If we do not disable LTR message forwarding here, or set a legal
+	 * forwarding address, the kernel will get stuck after the driver probe.
+	 * To workaround, disable the LTR message forwarding support on
+	 * PCIe Message Reception.
+	 */
+	plda_pcie_disable_ltr(plda);
+
+	/* Prefetchable memory window 64-bit addressing support */
+	plda_pcie_set_pref_win_64bit(plda);
+
+	/*
+	 * Ensure that PERST has been asserted for at least 100 ms,
+	 * the sleep value is T_PVPERL from PCIe CEM spec r2.0 (Table 2-4)
+	 */
+	msleep(100);
+	if (pcie->reset_gpio)
+		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+
+	/*
+	 * With a Downstream Port (<=5GT/s), software must wait a minimum
+	 * of 100ms following exit from a conventional reset before
+	 * sending a configuration request to the device.
+	 */
+	msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);
+
+	if (starfive_pcie_host_wait_for_link(pcie))
+		dev_info(dev, "port link down\n");
+
+	return 0;
+}
+
+static const struct plda_pcie_host_ops sf_host_ops = {
+	.host_init = starfive_pcie_host_init,
+	.host_deinit = starfive_pcie_host_deinit,
+};
+
+static const struct plda_event stf_pcie_event = {
+	.intx_event = EVENT_PM_MSI_INT_INTX,
+	.msi_event  = EVENT_PM_MSI_INT_MSI
+};
+
+static int starfive_pcie_probe(struct platform_device *pdev)
+{
+	struct starfive_jh7110_pcie *pcie;
+	struct device *dev = &pdev->dev;
+	struct plda_pcie_rp *plda;
+	int ret;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	plda = &pcie->plda;
+	plda->dev = dev;
+
+	ret = starfive_pcie_parse_dt(pcie, dev);
+	if (ret)
+		return ret;
+
+	plda->host_ops = &sf_host_ops;
+	plda->num_events = PLDA_MAX_EVENT_NUM;
+	/* mask doorbell event */
+	plda->events_bitmap = GENMASK(PLDA_INT_EVENT_NUM - 1, 0)
+			     & ~BIT(PLDA_AXI_DOORBELL)
+			     & ~BIT(PLDA_PCIE_DOORBELL);
+	plda->events_bitmap <<= PLDA_NUM_DMA_EVENTS;
+	ret = plda_pcie_host_init(&pcie->plda, &starfive_pcie_ops,
+				  &stf_pcie_event);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+	platform_set_drvdata(pdev, pcie);
+
+	return 0;
+}
+
+static void starfive_pcie_remove(struct platform_device *pdev)
+{
+	struct starfive_jh7110_pcie *pcie = platform_get_drvdata(pdev);
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	plda_pcie_host_deinit(&pcie->plda);
+	platform_set_drvdata(pdev, NULL);
+}
+
+static int starfive_pcie_suspend_noirq(struct device *dev)
+{
+	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+	starfive_pcie_disable_phy(pcie);
+
+	return 0;
+}
+
+static int starfive_pcie_resume_noirq(struct device *dev)
+{
+	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = starfive_pcie_enable_phy(dev, pcie);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks\n");
+		starfive_pcie_disable_phy(pcie);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops starfive_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(starfive_pcie_suspend_noirq,
+				  starfive_pcie_resume_noirq)
+};
+
+static const struct of_device_id starfive_pcie_of_match[] = {
+	{ .compatible = "starfive,jh7110-pcie", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, starfive_pcie_of_match);
+
+static struct platform_driver starfive_pcie_driver = {
+	.driver = {
+		.name = "pcie-starfive",
+		.of_match_table = of_match_ptr(starfive_pcie_of_match),
+		.pm = pm_sleep_ptr(&starfive_pcie_pm_ops),
+	},
+	.probe = starfive_pcie_probe,
+	.remove_new = starfive_pcie_remove,
+};
+module_platform_driver(starfive_pcie_driver);
+
+MODULE_DESCRIPTION("StarFive JH7110 PCIe host driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


