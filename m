Return-Path: <linux-kernel+bounces-134738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6677889B638
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99491B218B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202224687;
	Mon,  8 Apr 2024 03:04:01 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2114.outbound.protection.partner.outlook.cn [139.219.17.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D423522F;
	Mon,  8 Apr 2024 03:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545440; cv=fail; b=n8+jT5gdA9rsRvEMji2NU+y2uRb14OC1jwy6b+UbCHbmKk4RaTH0Cm2tAjcMbeM4H5z5NiwdH+y1eOgNKvBobDGLUMIDtSLxqNwCEbkRAH1KsjSea4jBXh0JX7EDl/Al4kMOG+i/bZ90G0YvMEOct93jR/O2mozG0YPrcLmYeYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545440; c=relaxed/simple;
	bh=bXD5oWWCtttoZyH/fJlQf6T/DhR/+fua4zLXUJavZXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a98DMGXHQTQOz0T/rSjVgeaRF3FM32bkLJUe5m6eX7GKyf0RX7vdylRtj0q7QUcgQSDls5Y2FudiKBXSzLzQkc/TRn+3m/tNDa/TzXBuE3xMbwc0iGeWGo2c7zdTc46larWNxKmn4uatyFlIDdl6VTnkoZILPYMx/OgGRV7eoRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIRl+u6yq9BhneHGcRT7kcDWVJ/nICKWlSqx2k0Imq3Y+g7VH59v/sCRCJELIuxMb4Z+qPrKOoYgogge6ROJ1kEKohrQLaWZgZzV+89eMln4W/8+ribWN3kNEzw1KK3nkL2IuvFxQtVY8/1ozgCfIe+40IkZeVkh6ypNy7wevVgE7WaUQq0ToLU3agT9TNNw558dsZ0GkoXMTSXtBs940rRsB3JycKhePgCAGpEkqgsQP2stsENggO7zV5FdAl32Gd4Rqf+2H19oPzL2apKQckAPyHXe+QDax4+l057oz1ifCNPBEHJX0AckXc2pGTQ47cnLHNMHiBmvke7skNtJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMHpdm0Pdoe+kMUPk+cXNJAMD3NI2g9hf8cdZv+rRPY=;
 b=KLTO4ZnjrEw8PAmrF/h3MGaGfWQ/vo7MxEksCeDNV8NZSJQk6fK3AhtqyGjoryWDgfwD+8rea+kmw6SdfpuyUPWtozIjwkf6oGTs9nVCMe7riYZ7oY66eALBN8NNwA7z27GTpvzYNfTl4pQV50zHCdBPDPL+v8z3Pd5shv9HlGMLtTBWLxzgtfbrP64aN/vunJNZd25c+3gdzKbuQXIu9hhfU4Qz92PYh31JVl4nccKEGzuWQnQEqVueKoNtOKJcc+VcMipDPZPAKRSFcckiNzvr7nH7Q96TttyqyxXKl+zPLtJIu8dRAK60sxJHpVVoemkqn08xLnJ+IfVvlmGF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0605.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 01:30:17 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::a137:b8e5:8a0e:ca9f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::a137:b8e5:8a0e:ca9f%4])
 with mapi id 15.20.7409.053; Mon, 8 Apr 2024 01:30:17 +0000
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
Subject: [PATCH v2 2/2] net: stmmac: mmc_core: Add GMAC mmc tx/rx missing statistics
Date: Mon,  8 Apr 2024 09:29:43 +0800
Message-Id: <20240408012943.66508-3-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3d124cfc-e7b3-40d7-9377-08dc576b72ae
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7x/gIxA5gNq0nJ+ZDeGkNw4/XYFX1TCrU7EMWbjRhX9w5DVFONHs43ldNzbq0w6lYZznBmEHdtBT8OhgFqOv9MNG/AHymSQCy9d1KYuPQhfIsiu1h8Pbt0n3fn0g1sAdEyd6S+VtRc2EO6NQBTBSOmOzDtf+bvebu7NRH9g6t5Fb9VeLZ3Rq5xnjrL/qe7B1Fxw8bGFbHC82KZveOUbqSibKhz/GTO8iWj8KuuoBOniDdN1uZglr5Bg+k9zwsT93DNyVbf7n4oVMCct30g9xEHTV4JFV7pk4fPiqpLBLteMoj8deoYLnmD6J7IUTusTSvTJYOP0YIWXURGMfOIT4pUwiDCjosQSTb4xv33Cm4lBnBVBq+pV9MMGF9aR+PJ+iFbkwh3BGx4uCWD2ivj5vDi7hG2yNeyyjj52GhxFUuThY42AEKgVGwgvOEjyGzYeRUfKtqtXWuPo2SH24WBP1IkXG/X1c6YtyOfNgPwx66/uwPIaoe9mOISmo8aJzrDPTakpmj7Zro1WZKSGxMtXyQ1SiYI8tzX+Mb4gJBcH25EFQtdTFsY7PJfufQ+R65wDqZp3/73Ejtl0gWNEmACW3sbWiXZfl/7DXMqA8HVGJvz5qqh/XPTMzIB2ZBdKqCykh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(7416005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UvwTh/TDkm87OXP+ncwnN5hr4yQh/MoAT+3cu1t8utVg2JoIbgibChvO/xFr?=
 =?us-ascii?Q?3AXQ8e7b8dJ7NURcsq+XWPpEOZcOuLJorvJSB/kqVnvWrRj/OoxvOigIjywT?=
 =?us-ascii?Q?fia7fxObt47URKuPKraXePWaZ1CsXWm4ZUZ7/LMl2g/xrfPtl+JWj70/C/xd?=
 =?us-ascii?Q?EMv2y2JH1nuSWWzhyLipR0LmopmeU8vUN/BGQcCyko6bHLJP19RBDQzzsSkr?=
 =?us-ascii?Q?QBHDvNlnBW+FqEVmHxLFLOFiIUxJoWTeCP58ADt1CrCrnKMDM/tBqHU7kzP5?=
 =?us-ascii?Q?QpH2wYuwTUuG74uJpjAhc1bloZF0Rw18y4FmX/M5qxtO/No9XH9J9CnwZ7xx?=
 =?us-ascii?Q?BDHvxlKJpkh8ppfJdzTFjsDOR4rygM6Xfc5lnanDDP6UHz2sN8miKhheQLu0?=
 =?us-ascii?Q?9t4Hjy0E+ZYiEq7Qa4ri1MFpyahxmO4nNk0J39KvbZznEg9tfe+IzWrRqr33?=
 =?us-ascii?Q?JwaQAHBzhFip2cc4fAm+ROLhDOp4HRKkT21tZhUFL5S2KT02c8gaztUq8Ehp?=
 =?us-ascii?Q?2qTZeKILrPWni3c/rJ4lWDeB/mTcsI4GmOeVQjOn8uazw2a9OMelMYhQM0Wa?=
 =?us-ascii?Q?zfbPfgEM3cp8P04R6Re7cjcdHiYOjziaSmoslwkLvNnlqSJOzlVkYppfR8PX?=
 =?us-ascii?Q?6YscUU5KmaInp3wLhD7505W/+WXQi+C4x/iToOnhRs7t6J3Q41RtZx0Oc/n5?=
 =?us-ascii?Q?3YaUeuKCXgzAufNcnp0BnOEpKJcvWsx77xcH9HXhn2Tf4zkDY0ok/4IeP60a?=
 =?us-ascii?Q?E23eSiUfxCkYDS4qnjhsa6LTABB9eF+TjK/Fc4RHcXHuIMzBrbe/2qYuDZqn?=
 =?us-ascii?Q?l4AA0aa7dJve50d3KH7qgYlqJN5gDD3RkogfuQZtEf6eLkNic7cZsw6PeDmh?=
 =?us-ascii?Q?ZKkcF8DCAyJ1sxO1DbIsdWg5K3/8irlByOrnpPMloCu8tzH98JpL2r6bOJSE?=
 =?us-ascii?Q?+el0fUlbnP6iXV97Eo73y7ePX25bkbrOG0dBcFVKo7Ja3HOcJI2EGHPq/opk?=
 =?us-ascii?Q?MbmWbEIN+jnBwiW8Yday3NlFvf09GtfpfHvMzmXF6ORIw6eJAmZlTzve3p/u?=
 =?us-ascii?Q?FgL3xJfBijY0tm6Y5afRcdGY5lYOl1MlW3rcEssEkloBNzZRM2UEwkLplwIa?=
 =?us-ascii?Q?a7IbX21KBlvvqtzlMWW7NeFYzUBJry3Zt0bAhMErNuzRUKt2LfObrBZ48Mu9?=
 =?us-ascii?Q?nYYFF9Bmeg58hMcpjvK+oRi0Eme3PDy/0jKv6vQX6S7fU1GdQEKzlzmhiXhO?=
 =?us-ascii?Q?eqPj9AMCUQKsPVbOVhqDnvYmOusOqhD3cmOSfmt3vwEVrKn8+A69pveXjcr1?=
 =?us-ascii?Q?pt79k6SxXbCCRF6HGP0JWa+2HQDeYNlPzR2HBgdHFjAqOFBwvMylWyNeHw9s?=
 =?us-ascii?Q?BHmeXWRLj2L1/zt9bmKyVRisC94vBzTHUCmUMoBXOD17b2a96TtyifP7wAaj?=
 =?us-ascii?Q?eRWgAXkpR8RCw3XNBEyR3fQ7PF3p+LlPZQjqPSkknIHv8h0RbT4b1ioJl7uK?=
 =?us-ascii?Q?v7LhpUxHTUfEzIo68Dl82hK3Pxqt21EuC6uLdY53Mrus+Uhc7n2R+7I0bcPB?=
 =?us-ascii?Q?audt+mRIIWCD8C38juVpdx5wxz35BB9vLiknSVcf2wg1UUJaV+Dd7NgySJri?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d124cfc-e7b3-40d7-9377-08dc576b72ae
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 01:30:17.7952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oKzcSj/tNKwE81hwkQ/BD8hwxONP0dX+jXF4tIs3o7DN0nZWgfFMV0kjPqHm6lyX8wnoNhSbDVAblKQ5CVu5AbCdjFooXlcfFFCm60Dxuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0605

The missing statistics including Rx_Receive_Error_Packets and
Tx_OSize_Packets_Good.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/mmc.h            | 2 ++
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c       | 4 ++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc.h b/drivers/net/ethernet/stmicro/stmmac/mmc.h
index dff02d75d519..5d1ea3e07459 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc.h
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc.h
@@ -52,6 +52,7 @@ struct stmmac_counters {
 	unsigned int mmc_tx_excessdef;
 	unsigned int mmc_tx_pause_frame;
 	unsigned int mmc_tx_vlan_frame_g;
+	unsigned int mmc_tx_oversize_g;
 	unsigned int mmc_tx_lpi_usec;
 	unsigned int mmc_tx_lpi_tran;
 
@@ -80,6 +81,7 @@ struct stmmac_counters {
 	unsigned int mmc_rx_fifo_overflow;
 	unsigned int mmc_rx_vlan_frames_gb;
 	unsigned int mmc_rx_watchdog_error;
+	unsigned int mmc_rx_error;
 	unsigned int mmc_rx_lpi_usec;
 	unsigned int mmc_rx_lpi_tran;
 	unsigned int mmc_rx_discard_frames_gb;
diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index b0db5f4e8fe8..0fab842902a8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -53,6 +53,7 @@
 #define MMC_TX_EXCESSDEF		0x6c
 #define MMC_TX_PAUSE_FRAME		0x70
 #define MMC_TX_VLAN_FRAME_G		0x74
+#define MMC_TX_OVERSIZE_G		0x78
 
 /* MMC RX counter registers */
 #define MMC_RX_FRAMECOUNT_GB		0x80
@@ -79,6 +80,7 @@
 #define MMC_RX_FIFO_OVERFLOW		0xd4
 #define MMC_RX_VLAN_FRAMES_GB		0xd8
 #define MMC_RX_WATCHDOG_ERROR		0xdc
+#define MMC_RX_ERROR			0xe0
 
 #define MMC_TX_LPI_USEC			0xec
 #define MMC_TX_LPI_TRAN			0xf0
@@ -289,6 +291,7 @@ static void dwmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
 	mmc->mmc_tx_excessdef += readl(mmcaddr + MMC_TX_EXCESSDEF);
 	mmc->mmc_tx_pause_frame += readl(mmcaddr + MMC_TX_PAUSE_FRAME);
 	mmc->mmc_tx_vlan_frame_g += readl(mmcaddr + MMC_TX_VLAN_FRAME_G);
+	mmc->mmc_tx_oversize_g	 += readl(mmcaddr + MMC_TX_OVERSIZE_G);
 	mmc->mmc_tx_lpi_usec += readl(mmcaddr + MMC_TX_LPI_USEC);
 	mmc->mmc_tx_lpi_tran += readl(mmcaddr + MMC_TX_LPI_TRAN);
 
@@ -324,6 +327,7 @@ static void dwmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
 	mmc->mmc_rx_fifo_overflow += readl(mmcaddr + MMC_RX_FIFO_OVERFLOW);
 	mmc->mmc_rx_vlan_frames_gb += readl(mmcaddr + MMC_RX_VLAN_FRAMES_GB);
 	mmc->mmc_rx_watchdog_error += readl(mmcaddr + MMC_RX_WATCHDOG_ERROR);
+	mmc->mmc_rx_error += readl(mmcaddr + MMC_RX_ERROR);
 	mmc->mmc_rx_lpi_usec += readl(mmcaddr + MMC_RX_LPI_USEC);
 	mmc->mmc_rx_lpi_tran += readl(mmcaddr + MMC_RX_LPI_TRAN);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index e1537a57815f..542e2633a6f5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -212,6 +212,7 @@ static const struct stmmac_stats stmmac_mmc[] = {
 	STMMAC_MMC_STAT(mmc_tx_excessdef),
 	STMMAC_MMC_STAT(mmc_tx_pause_frame),
 	STMMAC_MMC_STAT(mmc_tx_vlan_frame_g),
+	STMMAC_MMC_STAT(mmc_tx_oversize_g),
 	STMMAC_MMC_STAT(mmc_tx_lpi_usec),
 	STMMAC_MMC_STAT(mmc_tx_lpi_tran),
 	STMMAC_MMC_STAT(mmc_rx_framecount_gb),
@@ -238,6 +239,7 @@ static const struct stmmac_stats stmmac_mmc[] = {
 	STMMAC_MMC_STAT(mmc_rx_fifo_overflow),
 	STMMAC_MMC_STAT(mmc_rx_vlan_frames_gb),
 	STMMAC_MMC_STAT(mmc_rx_watchdog_error),
+	STMMAC_MMC_STAT(mmc_rx_error),
 	STMMAC_MMC_STAT(mmc_rx_lpi_usec),
 	STMMAC_MMC_STAT(mmc_rx_lpi_tran),
 	STMMAC_MMC_STAT(mmc_rx_discard_frames_gb),
-- 
2.17.1


