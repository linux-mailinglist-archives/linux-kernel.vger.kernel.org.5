Return-Path: <linux-kernel+bounces-134698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2B189B5B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D2A1F21B62
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C778F17EF;
	Mon,  8 Apr 2024 01:46:23 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2106.outbound.protection.partner.outlook.cn [139.219.17.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B64685;
	Mon,  8 Apr 2024 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712540783; cv=fail; b=G+MHKIN4P0KyoGLx+dmnTVLpt1rlAPBWDP1YgVd4QzmpyGOxtnc6v8ezLD5NP+WC5jHIIV6CtzfeeuEqOFPT+Bb5trfRIsxfR3PvXnihCnrH0kSrbLLupT6c4wbjIXy01f7Bcl4jHQXS6XBgyRQTnJH27rCa+J5o07ZBAxEx9tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712540783; c=relaxed/simple;
	bh=JQxhhyRt8yD4RwyZ0R7BN2i2rF8WZQgn99xp5tlDhew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LxnDpIPyEOquxid3j6h6E2eCERtkGIu8fpbu+bgbXDZiNwMIJmEcMPERbj7+y7gJwUt1J2NW6HA3cki5wfrli3twio3jaCBQGiWKPvl89k0Zfu0WFdcJmuOfH2AwzPuHr8e3nKKZLqKsuNdJrQebiILrJBeFDy3ogExdKLqMOA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llCK7Nx4rpXB7hHnYkRQt6CQyCHfzUlkvBHpkQmQRuwgxRwKtgDfCb48Uf5uCRbVOlb6P+aoKYEB3Woc9K6ST43rqWkmX13zQe8sdMU85RTHzWttvrkPdeQeaYVCONj+kzwn3ZxHMtsj4UgkVKQP7rVDac+V/xn5ROpYAL7tyi16GcowWWTnkPg+hN+XfmKphyqQZF65OquBGlqT9E/iyMemdtnXv317xaZ7MZaULKaGr2+iyMjtQS2r6cz3hfhFebV/SG8MTLKSxJVlyQTpQ/UrNjIJra1OxtTeLFnn6DPo07kZC51E5LXmJFX/M/Eal6ivwtj/NPxhHS8y8JWjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QX0SfnClk7LRWZIRU9iyQDvzeg5wiOTW+vSlPOWGvs=;
 b=C5S7Q2jAjlWqjuokBcRS7m4l9pZ+ALDbZIBMSK1b0C7Cq89xyvDW56bzerZpv/VyIHuj3fbAiShnx2d40zc6+QjnaOctMZZjQbVMUdr5xpfPJX45Ckd/EhKnun+AIzhW7eErvveufjU4kxVBn3QLhoPJVK/vriCgPN+/U03lQmeVIxS4Fy8vlbqn4QQJoOHGOkCxpqnBTWX4ihf/b6v1RXHXHsmkgVnglfkAxJtwEFdE1/fcfcLTXDd6HYQrUVgwzLf2Hxtny34YzInz+svLX7LYudnvnyTV9dsrcqNlooNtJN7jOnHgLjum+JsXtl/mCdi8LI44o2vsuhxyIp7Plw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0605.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 01:30:16 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::a137:b8e5:8a0e:ca9f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::a137:b8e5:8a0e:ca9f%4])
 with mapi id 15.20.7409.053; Mon, 8 Apr 2024 01:30:16 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] net: stmmac: mmc_core: Add GMAC LPI statistics
Date: Mon,  8 Apr 2024 09:29:42 +0800
Message-Id: <20240408012943.66508-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240408012943.66508-1-minda.chen@starfivetech.com>
References: <20240408012943.66508-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::6) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0605:EE_
X-MS-Office365-Filtering-Correlation-Id: d924d458-a657-4fb8-ff29-08dc576b71c3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S2Q/iSEaUVp2sdOviLvzC7Z/x6tyh1b+FlvJI3JVk4cH2oe4eSQ/+xuDlmZgXlOIYQ0M3mhHePWLKhmrWhovl+cL4LrqvAuWzndu5yE4+8U+rWZFp5QhwR9UaBVBH3P6pL57aJFcHIDm2yq0jYJw+BqfklDOmcUkSSRwfx0lPPs9fYJLCzvrCaHehxvAp/8YBhFRN4SN4m6mAA9IfrzKwyD/Ea5U5HGRMz2NTUYqgnUo8+pXrLOV/MuWlEL5Rpgt8OjeGeF2z+xwHzChWqNywwLW+AWQ+1p6yK1kLAI3cx16/Pisw7Vui/CuYZ9Dr2LoMWQ0IPr0UIjsfurq0fQmvyJSAkenlsbb9vtKMUZ7yBWW6V5TDvLVKTW7ZWM1WASkrhUCQmeUml+EgX3ZjyJ7ggT5jxd9TXuzUgtt65Y0yxyzsiSIWfONHi0m+Jq6lYnnV5+CSvBdZzvJdYE1GDTJkyY1HMlrzzk5tMLKsj1zBix7lu0P+xzB+MjUJ97G/aujfbgm98Uze/y9fVH95pVOLJPkbGPeoYgXqF9uPaR4sMfp1nI3YlTD0eV3kH+rhcYr4zpIlHtHhBSBsflHp5VEOyzXzTFGXsMbs7I6kkby+/gcxjwABtldpOsDbl49F3/G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(7416005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MJUaj0hQtLPYrfFxoWasN40NbM5vVLA0JrGsMsBco2lqR5X9IDXFLeH3Cvah?=
 =?us-ascii?Q?jJp13k4S0dRnlMRlahY8WEu2hqfVfE6y0G1UHGI2zE2MbiPXMC//grfujwML?=
 =?us-ascii?Q?Z/rBD1hDoumJbcN/8VY3f7AhN7UxQzNmvDgdAMSsQoJ+vwKPyBjjEFyUq+C2?=
 =?us-ascii?Q?kKeDlsEUMmT6rbNPkSGUak7Y/mrvsrmJFauL2UbSTnG1M80796Aa0t2ONRtF?=
 =?us-ascii?Q?iAtAIlkY5qQ4/RReGjxm91w1y5EFkLPMuU/CvKPmGNAw2FpteNXRrdo3K3xH?=
 =?us-ascii?Q?AuKSGdg4RaUd8uSO090PFrkHP5BSE856bfp6xUcGouyq34WgJlPLLbo5Szd7?=
 =?us-ascii?Q?OSvOves029QqwPRQ4FymNgqO//HwZwGyQxFr0C/cy8LI46JYkwNv7im3iuHq?=
 =?us-ascii?Q?OaBoH4QvVeWNTwJImhlUL5dMhBQwK/A9X6LDilVVbaUnXQTm0nHKZJxFGNT7?=
 =?us-ascii?Q?lF1mrYlA+xGSqNejD7dVuHYz+pTD/O1bO9X6mZSENbr0roByBPW84s8BxK77?=
 =?us-ascii?Q?/vuRG/PnMPDjNKf3Ysl+mPHH/LiV3edrgMda1uXiZiA01uxRwO6QDdvXMVWE?=
 =?us-ascii?Q?3gv84FjRf1e5hl6hifnXnlgUXjLP8hieaX1PKyD3TwDyePbbcVySbIeNq0xr?=
 =?us-ascii?Q?ZNPM67bgPwFCPxvLupHV8bY+FpRvuXRMYQjamZHcyqOKzHDlzrT6VmiEKI/A?=
 =?us-ascii?Q?Rbi1o7e/GstoOAKUYcd8jxyq7L8D7p+30ard9QFdDWDsVuYd8wx0GGuWuETZ?=
 =?us-ascii?Q?A0OcOMe5C0aCzlOBCZa7cyE6opTHTyyg9BJQt0X6HOEjv6yuM1rtPxCto/0d?=
 =?us-ascii?Q?Z2O0TNu6iPiQaXuUmhPV561PKX0yu7+k1/uB9KIOL6sybOvN1OV6aPm0Iygh?=
 =?us-ascii?Q?dkXwkNsPZGYtpd+WN6JfEadht2VdZ9gmjBQTS98JRBbuVYU1pUYS+zVoe4V7?=
 =?us-ascii?Q?bsd3GtT6m7MZtCeTR9rAvIGnfi7Ez+TFS/w/kdvpt0YOaYax9zKitr9ml51h?=
 =?us-ascii?Q?rnMdAY2mzpO6XqrtRmYEWXeQikjPALJi3GmdLFa5G9anFcoSXD0qRm0+i795?=
 =?us-ascii?Q?/hUwOKndaUFCmV+wNza6NsHotHMnlN3AnnOM8r5CmcKs+QTMHYafXVxjhy8e?=
 =?us-ascii?Q?Oz/gK4GPBirPTuf2pgbMn2i8e5DZcs3YKA+iQdCLNUtvis8ruhDo9/hFlioE?=
 =?us-ascii?Q?2AZJIPLuVibOPsShuKt861v69elPeenxm7sbYBSCN0siD3xUKZDe4E7+HVM2?=
 =?us-ascii?Q?aW4jmoAPS/rFlDEJsM+RWet5AAl+cgfCow6JQKPl3mH2mwLTC3K9a+b9jVhH?=
 =?us-ascii?Q?djDiLUljRmfeyF2SpKXzryDrB0M+Yw/rssf77FravNk845BIgoeUkMaS5en6?=
 =?us-ascii?Q?74HLzPmBG/CYLz8xWf3UpywzQUcvj/+Cr7Pqm9g3Yrr6QmeowelsIw9L4UrS?=
 =?us-ascii?Q?HExKcV1SiinFPtOaPdOHx4p2TZJns8s3B8uR+IWriB/QS2qzp1vkVb1+4gp8?=
 =?us-ascii?Q?BiMR8KDG4jWR/QsflNMGM473YukGmT8XMMGHCNieJmBzfH0Q3+ZNJ7Du3fsy?=
 =?us-ascii?Q?oITknShF/FJCqE6rX0M8Do1OdPbW68OyvnOLeRHIvfYQktKfGNvlgzEmIHXs?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d924d458-a657-4fb8-ff29-08dc576b71c3
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 01:30:16.6256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIVk/FFw3CZQJfSM0XvOTT9LPGFcXL0P6nUdul99jA7SYO3Cg0WUof/C5UTNj9OFxF7uDMDa7nMGNAnwWsBo9Z8A0bz1p8YQsJGcIiB5v3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0605

XGMAC MMC has already added LPI statistics. GMAC MMC lack of these
statistics. Add register definition and reading the LPI statistics
from registers.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index 7eb477faa75a..b0db5f4e8fe8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -79,6 +79,12 @@
 #define MMC_RX_FIFO_OVERFLOW		0xd4
 #define MMC_RX_VLAN_FRAMES_GB		0xd8
 #define MMC_RX_WATCHDOG_ERROR		0xdc
+
+#define MMC_TX_LPI_USEC			0xec
+#define MMC_TX_LPI_TRAN			0xf0
+#define MMC_RX_LPI_USEC			0xf4
+#define MMC_RX_LPI_TRAN			0xf8
+
 /* IPC*/
 #define MMC_RX_IPC_INTR_MASK		0x100
 #define MMC_RX_IPC_INTR			0x108
@@ -283,6 +289,8 @@ static void dwmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
 	mmc->mmc_tx_excessdef += readl(mmcaddr + MMC_TX_EXCESSDEF);
 	mmc->mmc_tx_pause_frame += readl(mmcaddr + MMC_TX_PAUSE_FRAME);
 	mmc->mmc_tx_vlan_frame_g += readl(mmcaddr + MMC_TX_VLAN_FRAME_G);
+	mmc->mmc_tx_lpi_usec += readl(mmcaddr + MMC_TX_LPI_USEC);
+	mmc->mmc_tx_lpi_tran += readl(mmcaddr + MMC_TX_LPI_TRAN);
 
 	/* MMC RX counter registers */
 	mmc->mmc_rx_framecount_gb += readl(mmcaddr + MMC_RX_FRAMECOUNT_GB);
@@ -316,6 +324,9 @@ static void dwmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
 	mmc->mmc_rx_fifo_overflow += readl(mmcaddr + MMC_RX_FIFO_OVERFLOW);
 	mmc->mmc_rx_vlan_frames_gb += readl(mmcaddr + MMC_RX_VLAN_FRAMES_GB);
 	mmc->mmc_rx_watchdog_error += readl(mmcaddr + MMC_RX_WATCHDOG_ERROR);
+	mmc->mmc_rx_lpi_usec += readl(mmcaddr + MMC_RX_LPI_USEC);
+	mmc->mmc_rx_lpi_tran += readl(mmcaddr + MMC_RX_LPI_TRAN);
+
 	/* IPv4 */
 	mmc->mmc_rx_ipv4_gd += readl(mmcaddr + MMC_RX_IPV4_GD);
 	mmc->mmc_rx_ipv4_hderr += readl(mmcaddr + MMC_RX_IPV4_HDERR);
-- 
2.17.1


