Return-Path: <linux-kernel+bounces-129074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316E089645E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D071F224BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A7F4DA08;
	Wed,  3 Apr 2024 06:09:24 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2109.outbound.protection.partner.outlook.cn [139.219.146.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B791645
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124563; cv=fail; b=qUQ0pvt95+np6A5UT/4Dm3NQI9PDHacQ3WGrsWC3JIYKPGSgq6Z/LnavNGIVKlFtROaFyoGX+cgNlKiAcv+ESL5WBwTbf64HbV2NzrzGki0izs76Pbn/b6dKQYAA710Y070fBVhGxaQ6H2EuUE6RCPq8hVbgHodAbsWiGbFBVuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124563; c=relaxed/simple;
	bh=peSw4RjIJR/OHIoV4LSSnK2/05IdBwudV/Atgl8nLAg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gi96DcEIT6JCMUrfpR34PKhpD6d+c4ZIFhqm2zT6y3SJ/6H5obP4rBfFuotLnt0Twhba5EMKWYZ5wWHEMSrkjK/mj50JnqdBxIIgkIHdBQkRNYNpXazyBF/o4Du6B6m3ewzFsVjfMXAMClv/+5TGbvICAnvh6XXcUF1YmDrj+as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eoc2uClCSZJ4Hw+N+K6GCPT9zEVL/mloNrdweBHWPkKfYVO0/Dguataci86EKP4M/iLoqffO72gN9nEvNG6mYsBxKK8yQ9Yj97V9U2X5d+0gygqDOKjn1eSFH6uzersHxdZlgZt8ofGVxsQUCQSRoTUGQ3LyEAEzzoUn3HTvhjYBR54l6x18DVsSVZauqdXxABRlVZHVOtLDq40bi9mOsgSOqqdU18xhSfKnb9qdzKpE4URKL+7SPFxi4Urxs62DcRq/n6lYMmSylae7+MAd63wYceyGCHNFMdgPPbtTZFuEC3H0aKh77BLYJPusuYKAptyarirSKT3Caw9Lak+OSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHqs2aDPKB8CxhQEXEssSlHh85Yd4/L9qAM0p3KBIY0=;
 b=IPI/Lfy7k2g09whtQRSSDcxD/ZZmp1KLEPSBO+qKDliPNt8IB0LF9R1JFAr7tsktqhVCo2rglxXTPRJCo0JqOQEkn4DXQRicM+SCOmMJUM7uJ0kghdLA1U1fXhmeGkJpSL9Tg0PfTLp9hL11EIkhgxSgEZZcyj9/QaGV9TO4Xrbz/VITqnvLF+0x6C9YM9LqybFuHJl2Ul2SNwIyqZGS5zVf4uBhy9Gd505TlrbQvh6qizkzQ9Vbs8Oow/81ZaDcUFQihFQ0V9srGCo8LSu51QoMI97uouEUYVcobRKSjLNPyqoY20DRzd//7fnVmgIlgvho5ZeJMWjKiMVMM9MUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1291.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 06:09:10 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 06:09:10 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] riscv: defconfig: Enable StarFive JH7110 drivers
Date: Wed,  3 Apr 2024 14:09:02 +0800
Message-ID: <20240403060902.42834-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0009.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::23) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1291:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9aa0de-a165-46ef-a427-08dc53a493f4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jheu5TVkTqphsHjBcPTk4evnJxmY1d5Dl+1DTRKj2LBVkLsZTZqhV8JCk2RoE+VHhbRNhP/mbWcq2qwVFQWDVSfdLQzUiDP0iun+Gp/+muV47p7PGLI+NP/W4NEIit/Aq72+cQCV5KJ7CHq4PSf6JxBbEDJGlM1p6ONAXNXLuw6LaI8SSm/QvdJkwEKg1CesP6tU8astvLvMCspk8T80VeyR6Y44YS/BiNk8ZNNz9iDQNvlV3MyCupzrXLeWo1OCpQVsyzlFsMnXtVAK0sC7k/8MYbbSI+KehHeaJMTE3Xut6HYsgKnjaPAzMfPIT/VUS1npbjFiBm9V/6CvDSv9XeS5CQZc/n7IzsE7ztmbyMe3W1ELQCMwoNBUvGISvDyXEpjl9X5bN+2R03JQbNm1anowtP2/Mnxy377pRV6uFiYvKiTbnXdLRTkKmF7M6V5pQm0lmTfAhEU6d8hUp6xO3qgoc2rM70qjf785iLJ1H2NccJj7DEmPkLqI1pUBMOKFHoelUjwiqA+imqz6h1AY2a4MrgdkXqU/4M2Vl9Wa24FTJ2phSHQ9T4Sr5u5Z350QWrvPxaBhPJ01EaNSiH8sMbbiiklZClTrUolVEFFLxCsrsP6V3le0zmFJy0+Mq9kl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dg1ZgUYS+Aeo7i5XN5CUjZAJl+dNPaExlFaQR9P94CBkClH0Bl1E8DFgf0v7?=
 =?us-ascii?Q?BDixNwBXvPIOSYxkKBm6Dy2yDwbEbKfDZUnGrQgyqGGl19pW3GiVNzs9vkxt?=
 =?us-ascii?Q?3ji1j1tuaFKfP09RobwfqYli/z7bFZN78gokyvM8PWtectO1gNtTJ6OLbDMA?=
 =?us-ascii?Q?9DMqHNWNWGrJ4/31nxXji2+T+np95Azz5llrHP5Z92LwxWcBIvEBlBJaQVuk?=
 =?us-ascii?Q?6oErcQy0XmuykCXRMHz9UcHCGxeJrPZ1cCZpxGnatKsTW6cpaMiOs8+lE9Ks?=
 =?us-ascii?Q?vp0Pvm0LFm97jlW09cYw6qu7T1LuaOuk6dAvAeH+it0Be/vd9vICSXhi9Vh8?=
 =?us-ascii?Q?K6fKqmv2ODXLVoeDd3sZGVG61ESmDUgqGBfXhSgWvvS7WdCDlWpLdIU+D3UN?=
 =?us-ascii?Q?fIUYmF9mqJuoPmtc4ERKogYJH7Z9+8/3YH5xPwZkXNEuh1hHhiBVA0dDnQjm?=
 =?us-ascii?Q?wju2xPiXfg3+lJZduGlOW6jMEvuiDzs2duKhauFrVvCXdSikK+2a5W6FiJqy?=
 =?us-ascii?Q?VzatTKQarrFtRxp9PeZ/xaLL9JDO0mI92cjfHxq+I2RiUpmfVYp4UVSQp2Rp?=
 =?us-ascii?Q?uCroph+Eb1iMANPXYfd9t3daVzwbWsQ9gy+bSt1SSgz3Z1/rCf6u6V/uoncZ?=
 =?us-ascii?Q?CCLJOceyURrm0Tod4usRjYtlPyoF7GbpzsOaNJo9eQfv5IWDQupoEiJirl+M?=
 =?us-ascii?Q?0Oy5SmdXXVCEt9tQlhQou3SJCfrPMtT+u8z1TuGQbZCZhMxk02Em+un7nFeq?=
 =?us-ascii?Q?+y8+afQ6KPfSR5pn1KxQ8m92sdj4Gu1NnQGQZfbg3+UZ9Pxobb2EKcwg3UGN?=
 =?us-ascii?Q?JTYNW/YIq256HqFAGEKgQH2mjLvBHnG30aG34hUiXbJktT7+mllX+ikXUAN7?=
 =?us-ascii?Q?xCKdS+hmne9AhUy5u9piNB0ZXhM/GQv+0kb7sLootmpKM1OBIBx/Ky5QuNK2?=
 =?us-ascii?Q?oonhMB1thgbffpmhLrrX1RoxnbJYw4HyZ/Bjn3L1iqk0Y+SenXiH4WNty5Kh?=
 =?us-ascii?Q?KUEdn6q2JTDQONYlatlHfvkX2qVi9Hc7afsszE1BS2ZQ55OfMY2k7QiJ6VYe?=
 =?us-ascii?Q?3ftg9gVLrJXukh+tJeQ6de/pd/VXK7F07xZFQXbdkvc4n5q4YKg20E2eh7Au?=
 =?us-ascii?Q?ICtkwMX7oRy0EDt1yGgPDDnvu10OCFUKexoQ1hWqVbGLBHjUqykvcN12J/9x?=
 =?us-ascii?Q?4a4VmfPXluTJwKR5H3MiG37IKerJ6cobPUfOdZdWEL60JDNqsN32h2mXZ4F2?=
 =?us-ascii?Q?bl2zQ6dvvL5+bscIs2oa2emf/mMRYWtgiRQq7tUwrhob9y8GSkCBNpJwcbhF?=
 =?us-ascii?Q?6Fko3zuHbMXVcSwEYIUfqPwFobO9mudmp5586l54lU+zlnd154IdNItDrVjO?=
 =?us-ascii?Q?y6trf4jbmdc9bJZbFDTSWAVGAwTLwmQn9Q/Vs7UhgLwOaDBm9tbSnVtI81T2?=
 =?us-ascii?Q?rOcp7oQIClRgvI4BBZsWUD2Wy+/DfJkoc7pI2AQNMdGCSBsXRvtD4zEioEc3?=
 =?us-ascii?Q?14zNXLPhJTIpI1vip6/v54Zxsp9dJgJP86epjHukmmFa2DyGq2iDgkfnjLR/?=
 =?us-ascii?Q?/ufhegGlDg+YfPHIToUwvFY4CILLj15r8Ju4r1/AGRVyYvjCLwnLxnAWBH+M?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9aa0de-a165-46ef-a427-08dc53a493f4
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 06:09:10.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiR+CVjYeCS6VOll0zWtUUrhay5PUjlYpHdE2hm/7W2bkELqNETb0gL57S/Brxd+qDnZsHVHTtCH8B2RRUQyMLKsCsvWLvInuW+AfZx5Sgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1291

Add support for StarFive JH7110 SoC and VisionFive 2 board.
- Clock & reset
- Cache
- Temperature sensor
- PMIC (AXP15060)
- Restart GPIO
- RNG
- I2C
- SPI
- Quad SPI
- USB & USB 2.0 PHY & PCIe 2.0/USB 3.0 PHY
- Audio (I2S / TDM / PWM-DAC)
- Camera Subsystem & MIPI-CSI2 RX & D-PHY RX

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---

Hi,

As more drivers of StarFive JH7110 VisionFive 2 board are upstream,
add support for them in riscv defconfig.

Best regards,
Hal

---
 arch/riscv/configs/defconfig | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index fc0ec2ee13bc..a4eb66b30d95 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -111,6 +111,7 @@ CONFIG_PCIE_XILINX=y
 CONFIG_PCIE_FU740=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_SIFIVE_CCACHE=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -154,24 +155,36 @@ CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
+CONFIG_HW_RANDOM_JH7110=m
+CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=m
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_I2C_MV64XXX=m
 CONFIG_I2C_RIIC=y
 CONFIG_SPI=y
+CONFIG_SPI_CADENCE_QUADSPI=m
+CONFIG_SPI_PL022=m
 CONFIG_SPI_RSPI=m
 CONFIG_SPI_SIFIVE=y
 CONFIG_SPI_SUN6I=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_GPIO_SIFIVE=y
+CONFIG_POWER_RESET_GPIO_RESTART=y
+CONFIG_SENSORS_SFCTEMP=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_RENESAS_RZG2LWDT=y
+CONFIG_MFD_AXP20X_I2C=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_MEDIA_SUPPORT=m
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_CADENCE_CSI2RX=m
 CONFIG_DRM=m
 CONFIG_DRM_RADEON=m
 CONFIG_DRM_NOUVEAU=m
@@ -183,6 +196,10 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_RZ=m
+CONFIG_SND_DESIGNWARE_I2S=m
+CONFIG_SND_SOC_STARFIVE=m
+CONFIG_SND_SOC_JH7110_PWMDAC=m
+CONFIG_SND_SOC_JH7110_TDM=m
 CONFIG_SND_SOC_WM8978=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_USB=y
@@ -196,6 +213,11 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_RENESAS_USBHS=m
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
+CONFIG_USB_CDNS_SUPPORT=m
+CONFIG_USB_CDNS3=m
+CONFIG_USB_CDNS3_GADGET=y
+CONFIG_USB_CDNS3_HOST=y
+CONFIG_USB_CDNS3_STARFIVE=m
 CONFIG_USB_MUSB_HDRC=m
 CONFIG_USB_MUSB_SUNXI=m
 CONFIG_NOP_USB_XCEIV=m
@@ -233,6 +255,13 @@ CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_RENESAS_OSTM=y
+CONFIG_STAGING=y
+CONFIG_STAGING_MEDIA=y
+CONFIG_VIDEO_STARFIVE_CAMSS=m
+CONFIG_CLK_STARFIVE_JH7110_AON=y
+CONFIG_CLK_STARFIVE_JH7110_STG=y
+CONFIG_CLK_STARFIVE_JH7110_ISP=y
+CONFIG_CLK_STARFIVE_JH7110_VOUT=y
 CONFIG_SUN8I_DE2_CCU=m
 CONFIG_SUN50I_IOMMU=y
 CONFIG_RPMSG_CHAR=y
@@ -244,6 +273,9 @@ CONFIG_RZG2L_ADC=m
 CONFIG_RESET_RZG2L_USBPHY_CTRL=y
 CONFIG_PHY_SUN4I_USB=m
 CONFIG_PHY_RCAR_GEN3_USB2=y
+CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
+CONFIG_PHY_STARFIVE_JH7110_PCIE=m
+CONFIG_PHY_STARFIVE_JH7110_USB=m
 CONFIG_LIBNVDIMM=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_EXT4_FS=y

base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
-- 
2.43.2


