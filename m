Return-Path: <linux-kernel+bounces-126419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE04893788
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 05:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A918D1F2163F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386734A15;
	Mon,  1 Apr 2024 03:00:11 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB4137E;
	Mon,  1 Apr 2024 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940410; cv=fail; b=tvw1lXqkNQKAkyOJguezI3fBu/DMKjVILJY8hVXC6f77qbVnAv8v5bU7af+l0VM91CkA4cEdR7EtstR525qq2YrVioT+KVZbWUzFrhTf2R21qDm8nFqDMnBMKovJ6MGUGlOClPod6aPAJMUkq6FgOJCahMFzIuzYO9nQWAp0dAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940410; c=relaxed/simple;
	bh=NikvNeBUajkESp2KtJZ9xFcUt3RLNoCIwAWR8hVnxFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KFriLIeA4uneMHK4mfH8YOgpo4jjoTtZJ2ox6zzsslma9RklLq0Kt+MfV9vN2M14Gp1peAdaIw9uHAWhaL9DMaWyc00D+jFElkJsMTtyet9wF4W5bzcZHDeRMtUmHt8uQ4Pj/05lzwu05fANEuTZ5BxLXDlAwJl9DQlxXXhzjIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjK8eIg6tbgkcVbJ81StShJFQtp55/WwGnw6mt26CLuL4KWMOkKjqnLPZKGQg/cH7n0sjby1mHouOK7Dv5/z0mfE2/Pg8cgoYO1RnAwbxeoF8ADpAd1/wqmEamOOFDSYT38q+wjk5r1Ubl06kYzstLF5m5UKz//L6XzNKbJFramIawQ8xcQy0dDWnb7/wYtDLlqIviDOcmKLIcWnKNMJt7uYpD9Vx5+hUiMQbbRWnTz17snpTPtPd2M1ZOvpT9kcN7WszL/QsAhbz/0L5IUnF6QJs05Ge8l7DYPGw5yS/ULmbspGbmgsfGH2tLMhM0QyFUVR4c9fYrKWTzakSb/Q3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jtMtNgDpgd+6HzWti/38A2fomqFbCv36tpXTq1pucs=;
 b=awnEmpSUHvg1dCsm0vty/3kZoivPysqryfZHJ3V5iBQ9NFT7YCdtGKh+10tOOv/r2qrhcW6z3KOOzHib4eB1TKZGqBgxzdsv7mtJw2IMff/62tHYwY6I8TXTJfpXjW4v2/ygTmUnefekYVJlojuvnhWP6ogLqGxg1Xn8KM7/hhhiM4EpzSQlQTRaGLEP0zf9oZacnARhRIaDZ3SCESaNueY42U7b+AJTUJFSq8hH/sDqp1vZxgv+701JFthHjIx8hbGhQJIeQHmL7lCf377EDTzUpsX541ATjjPknd9zAYe059HNBEMQRymOvXhb/mz/1wUd21fDZXFkuV7zmCvQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0798.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 02:45:06 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::a137:b8e5:8a0e:ca9f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::a137:b8e5:8a0e:ca9f%4])
 with mapi id 15.20.7409.042; Mon, 1 Apr 2024 02:45:06 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v1 2/2] net: stmmac: mmc_core: Add GMAC mmc tx/rx missing statistics
Date: Mon,  1 Apr 2024 10:44:56 +0800
Message-Id: <20240401024456.41433-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240401024456.41433-1-minda.chen@starfivetech.com>
References: <20240401024456.41433-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::31) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0798:EE_
X-MS-Office365-Filtering-Correlation-Id: a5732c68-97a0-4912-bfad-08dc51f5bcf9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i81Vbv+dPtfo77+UIoYAZMvgG5eGOuB07sXEkJS3vSQsxTfK/4Uc0ZHxeln7MH6Yy1mrzYOMiSsFDl3htOMST59vivaf4MUSX2VR9uvcs8Nwdl8AznU6mjfKBO7kLL1xlYN1ygA5tW77VWwbs1Df6Tm/e/LOEnBI41YjwrmryNUdABfkYF7Y04grMuFmfKv8w7WX/NDN2d5z5M4ynXHR87hXPntRLFk3yKcKLbpMS5wAqjQw66FyFiEPj0oWI53RTfgTCkHzEneiWmu9L/1jYzz3AV4xbef40sPSDLeceOXUSjT3/hACGiAiYXA8c8NLrduvPKP4oD4uV+eaBak/tmJtsZc6TQy4HzXb0nFToBLvvXs6w8ZTJEplU9jKK1kroAIefSWJgEBloVdeKWgvQXT8LXuO9p/NWTSstow6Kp4pYM/MnfHQOF4Zcyi94KW0Jb+WTusQBXYrBpU3SBa68jWGpfRZzDdeWemvDDibhuR/Zq8TSg27xS+c1FdFe9h8whXXHfMDpiB/cFGI6YA6wGZq7kiEhrAKMa6o4W4yX5WQNljTzE5LCG0U+eeVoQG3oe3RhuZxVuBrU9TWR3D7gtyevXppZCYsfKamIfoa4ZSxERXcaeYY4PmN2aAWK+ev
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(52116005)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m7ATje5jk4LVpEov/SEMUrqeh33BPPdIeoGg/D4d8O+0EQTLqao3HePvMiTJ?=
 =?us-ascii?Q?cz0cTlkICT7uB78Wd+GqTX5whKEssbZKNSteJVmbK00hvpv3KPLBCV3Mzcg4?=
 =?us-ascii?Q?obiHEVyWua34wLjYUTvNYBn3YMFmgrBAy8MWhSGM7gTRUBndZNt5Ktp8+iS3?=
 =?us-ascii?Q?tn338p0lpxGNAu2r1m6XWgKs6mwJ/dYcfL0KQlN3daZyZz6WFG+ZJbDUEOUz?=
 =?us-ascii?Q?q4D6ZGo3RRC6s/sHdL5XckZXRTGbkSKsdwUu7dXKzWtya9VoD679p9f+PTrR?=
 =?us-ascii?Q?xg88JED53EoKqRg9Pxd+djax5OTYBnMKuYmhM2+RdlhNexS4FpX6Vz+5L8Js?=
 =?us-ascii?Q?NtiLWN64EPknrmfWhIV+htp4EdfpG6ZCbsbsaRsNCD38oSYywM0r2i5miikZ?=
 =?us-ascii?Q?ROPzp5OLGogiN/TcOyLSTzBJEEsco1fowQNdKKlsH7SfaiokmmGt0cfzElZm?=
 =?us-ascii?Q?nP6iTg0mW+ZIzPstTRXqc1ffiYl5CjqqAqSjnPo1ct5TCrWugP5Ag7Es46bT?=
 =?us-ascii?Q?lT6mOURtIOjM4bnkXS9Kv5Ow23USQRbXPD0b5vntIg7BAl2SZLVr2iTd2Y4A?=
 =?us-ascii?Q?8L123XQmuXhrGAY+4kfFZUxAy/WDjA7vL972zH/jfUvXVkFeldlW/klY2BJ5?=
 =?us-ascii?Q?zoPTuKXoVpMM+JELJPTCz59Q+VD3SMX2jFSEVqTuM8oMlaFX+s/KZqfasBPp?=
 =?us-ascii?Q?0pc6TOIyrmwEC7wpk4xS+SvDspCCBd5mfH7WaV3pkx3Aqoj3+IwGDpXEsBAC?=
 =?us-ascii?Q?SW3WO097EQ/6Ov9PExiK6Y9EzSDbRPHCyXZAlmYCAgiFxniFYnPbPXNbqKeK?=
 =?us-ascii?Q?zaT7WuWsKjgokrBf6jlQ83knoOsZSg2nkscuKR4ejfyjU+oDFE65WnRYKGcE?=
 =?us-ascii?Q?4oGUIgTtqHGDy4tQIUQr0Ka0iqF1Rxf6VITv4WeGlhM/Knjepejn8HcMX1Yz?=
 =?us-ascii?Q?/oaZ8dflEYclzwH5gfVIO0+O17TlJhbGPpIS5r9Sgi0NtnRSjQTdC0Ylri5Q?=
 =?us-ascii?Q?3lYYcIP9NJbneIoRlaWybK36rf1DYMQzrwLVwA+masmvZ526/Lhhqo+rwvxE?=
 =?us-ascii?Q?nIEE33sdQzNUtPRb8dwNoh5QX7TuQGaYpgWeePOpblaX7iiylFXemOyQBHCg?=
 =?us-ascii?Q?hKbavHFcBdvTCy63MutGGgCpYN/JMpuq+xCM0Q3GOIoL9h6tN+di4gt2n+Tr?=
 =?us-ascii?Q?tNFiCLxmIinQYHonyJPt5B0ifTjCzw4ovNfZ2NZo7CaQBgqn+v+JI9xCsDgf?=
 =?us-ascii?Q?1DzMRRb+toHRy/cEtFL+XALiMOcjoYFFGrBHwpeJPWSI17xtPpq/rSuY+MoT?=
 =?us-ascii?Q?rUXSfC+koIeOx7l13Ssb+cqD7ce+WPTKx2SKGFlyTi/iLZx7kOi7dCkeV80s?=
 =?us-ascii?Q?pjXJbUNkR+XfbwkLFitbASOuPpVC0bh7VAu6KjxcYQf3ssPh5KiIzyp1vq/v?=
 =?us-ascii?Q?HBhIdyjzSfS0d0g6yKbUS0+ADOCZ/v7vkbG6m7Wn9OzasuquhXQwprpaxfo6?=
 =?us-ascii?Q?5DQP9zXVuCrsMC4ToVEojZ4KXP2JlK9Z+vbkkgaCYcoFH4wvJDYxledUB2Yw?=
 =?us-ascii?Q?GqlBKHEh0I+5XUU6PvuYjIG16BAfcW9OQXfjDka2pLUIBdrfoUemFq57rdMf?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5732c68-97a0-4912-bfad-08dc51f5bcf9
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 02:45:05.9867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHZcSPMMlHLi+gLqiTwgrZF/XvV7vs1xDfQVRw61ZQiA+wIGzUMGsRSJ+2xZHZqUmqzzl/6TB/vPygdXmwHwi44JmpGp8JCGSMMVmTO/qeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0798

The missing statistics including Rx_Receive_Error_Packets,
Rx_Control_Packets_Good and Tx_OSize_Packets_Good.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/mmc.h            | 3 +++
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c       | 6 ++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc.h b/drivers/net/ethernet/stmicro/stmmac/mmc.h
index dff02d75d519..cc189bdc563f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc.h
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc.h
@@ -54,6 +54,7 @@ struct stmmac_counters {
 	unsigned int mmc_tx_vlan_frame_g;
 	unsigned int mmc_tx_lpi_usec;
 	unsigned int mmc_tx_lpi_tran;
+	unsigned int mmc_tx_oversize_g;
 
 	/* MMC RX counter registers */
 	unsigned int mmc_rx_framecount_gb;
@@ -85,6 +86,8 @@ struct stmmac_counters {
 	unsigned int mmc_rx_discard_frames_gb;
 	unsigned int mmc_rx_discard_octets_gb;
 	unsigned int mmc_rx_align_err_frames;
+	unsigned int mmc_rx_error;
+	unsigned int mmc_rx_control_g;
 
 	/* IPv4 */
 	unsigned int mmc_rx_ipv4_gd;
diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index b0db5f4e8fe8..948f12b18de3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -53,6 +53,7 @@
 #define MMC_TX_EXCESSDEF		0x6c
 #define MMC_TX_PAUSE_FRAME		0x70
 #define MMC_TX_VLAN_FRAME_G		0x74
+#define MMC_TX_OVERSIZE_G		0x78
 
 /* MMC RX counter registers */
 #define MMC_RX_FRAMECOUNT_GB		0x80
@@ -79,6 +80,8 @@
 #define MMC_RX_FIFO_OVERFLOW		0xd4
 #define MMC_RX_VLAN_FRAMES_GB		0xd8
 #define MMC_RX_WATCHDOG_ERROR		0xdc
+#define MMC_RX_ERROR			0xe0
+#define MMC_RX_CONTROL_G		0xe4
 
 #define MMC_TX_LPI_USEC			0xec
 #define MMC_TX_LPI_TRAN			0xf0
@@ -289,6 +292,7 @@ static void dwmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
 	mmc->mmc_tx_excessdef += readl(mmcaddr + MMC_TX_EXCESSDEF);
 	mmc->mmc_tx_pause_frame += readl(mmcaddr + MMC_TX_PAUSE_FRAME);
 	mmc->mmc_tx_vlan_frame_g += readl(mmcaddr + MMC_TX_VLAN_FRAME_G);
+	mmc->mmc_tx_oversize_g	 += readl(mmcaddr + MMC_TX_OVERSIZE_G);
 	mmc->mmc_tx_lpi_usec += readl(mmcaddr + MMC_TX_LPI_USEC);
 	mmc->mmc_tx_lpi_tran += readl(mmcaddr + MMC_TX_LPI_TRAN);
 
@@ -324,6 +328,8 @@ static void dwmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
 	mmc->mmc_rx_fifo_overflow += readl(mmcaddr + MMC_RX_FIFO_OVERFLOW);
 	mmc->mmc_rx_vlan_frames_gb += readl(mmcaddr + MMC_RX_VLAN_FRAMES_GB);
 	mmc->mmc_rx_watchdog_error += readl(mmcaddr + MMC_RX_WATCHDOG_ERROR);
+	mmc->mmc_rx_error += readl(mmcaddr + MMC_RX_ERROR);
+	mmc->mmc_rx_control_g += readl(mmcaddr + MMC_RX_CONTROL_G);
 	mmc->mmc_rx_lpi_usec += readl(mmcaddr + MMC_RX_LPI_USEC);
 	mmc->mmc_rx_lpi_tran += readl(mmcaddr + MMC_RX_LPI_TRAN);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index e1537a57815f..4517d5162c5a 100644
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
@@ -238,6 +239,8 @@ static const struct stmmac_stats stmmac_mmc[] = {
 	STMMAC_MMC_STAT(mmc_rx_fifo_overflow),
 	STMMAC_MMC_STAT(mmc_rx_vlan_frames_gb),
 	STMMAC_MMC_STAT(mmc_rx_watchdog_error),
+	STMMAC_MMC_STAT(mmc_rx_error),
+	STMMAC_MMC_STAT(mmc_rx_control_g),
 	STMMAC_MMC_STAT(mmc_rx_lpi_usec),
 	STMMAC_MMC_STAT(mmc_rx_lpi_tran),
 	STMMAC_MMC_STAT(mmc_rx_discard_frames_gb),
-- 
2.17.1


