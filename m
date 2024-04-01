Return-Path: <linux-kernel+bounces-126420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FB789378A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 05:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895FB281A23
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EE546B5;
	Mon,  1 Apr 2024 03:01:10 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2120.outbound.protection.partner.outlook.cn [139.219.146.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08067F;
	Mon,  1 Apr 2024 03:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940470; cv=fail; b=pyp9ZmDS3xSfDPtOPZqFAs1JQSudlxAIjaWGg+9RG0rxG4xtVyPHBFvaYcJQI0W00ba0vh4Zogr5sVBLwKzjcbF0sXe1rkGduyOCyFAwFBGYfVzNooPD32njrHqiY9hGcy2zZf92ZAePaTtbZ8bZDjsT7IPuy7B3ArL23Lprty0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940470; c=relaxed/simple;
	bh=CMaKMsmjPF+9KAWjte8JVEB0LDJnRGriiTzeUFBPWfw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=j4aRcwGQrNJ6I3Xi0phxAh3L0Qnh7jc87FXPEk5iV61dep37i0cdnEtGSHcuF85dTAblSyQCVpym7q56qRy/jSPiCKVch5KmC8b/2fkrFZYCkHr/+6iPMBvY0AxZ+N+xOwNr8Jg3WpaYRAyCWQyjM2KIrbL0Pngu64GAMHKi2dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAap0m3QDZLTDKRNRacDlDx27RtlxYU4ff/kAVopBjhtmf1yu8iX+1ssKr9Do6YEcTv3HajCxwGpnXuZRLDLEy41QDKkKAJ/4spZflNOpZyM6ZfbTULVwRSSEfAdOc56wemwnZK3tF5XoMYphFAyZo+jentwXozdLHfp/B9OzCPAHvD/ZbWwxH7f1LuLLlib78N3VnNT139dgLBy8EXCzW4DGs5zIqe8zgFIL1aKvlDK4LViuSurgaNvWVJBbFvn1terZiwa5NQizsocOqjwL8Ut4NvSQEhjdk4np0wRREDRlvmNlXQHdKaE6Sk14C/UcP3H+q8FhERrUsAxQvc+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AuXCWznMFYSu5liF/b9d66KTnMSdUpTu+oBaCetzpc=;
 b=CwaGXfMFiKRjx5dnhInZdLc1hpDfHrPCoJXz+PzrX6IMWg9bNlghPuu+WRSjKLPqS20JyXWDqMjNS7iuErD/irLJ7KnAKV4jH9XrubnJBs31EMxyaRBspbYB60PiyTUksfBGRyRc4E4cW1/dwfMWKIvepiGbnBaEINtEc/dmtlwOZ/sx+LjBrkO+IaLhMp9sHHuqI7yArdvAngGk/bqqNBu0uR4wk8zVIaAGd4mA+22jcytEnH6h2LEuypkv0Xq7aGV1g63foz2HplcU0McmEMMiSs8vJJQTZv8bIk5TqSC2o3U15CqZ+Hv//C4avz4yXqavJfIJVvwS41CzWsG1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0798.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 02:45:05 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::a137:b8e5:8a0e:ca9f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::a137:b8e5:8a0e:ca9f%4])
 with mapi id 15.20.7409.042; Mon, 1 Apr 2024 02:45:05 +0000
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
Subject: [PATCH v1 1/2] net: stmmac: mmc_core: Add GMAC LPI statistics
Date: Mon,  1 Apr 2024 10:44:55 +0800
Message-Id: <20240401024456.41433-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-Office365-Filtering-Correlation-Id: 4d9778c7-813b-46db-dfc8-08dc51f5bc63
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6ep6WJid+UIeJTZxP/aBWfStVNlQM4Qar2qs8DlfZObUiS124vJSInxrYUA9hwztCJTB3psaV0hqocZ7WzRiH/Re+y3MCbRchwl+nvt4u9Q6uKAF8RsvLSpIgAgcF09mvwNX6vMWwkGxv0B2C5aENMIfLag6p964Aa+uQzId6yXbvKZ2M0++ONWF6xwW6yOatPAtLD6QiYokFWefig835a7yc/Pwc/8A8SCnKUpnmQKfRAmPZdMQIjKcBhbgW8Ir38q93vnVdk4qJRPVP+95WMN6DTl3neW/Fn2g+nZKz6CORUmVh47Ugng5m49P6c9VxrG0OtTwpG1gWePSXNeAOkcgfR/fLTc9xVdvWxTX25HL2tpq0mCrlK3T+Kwzm+atiaPM4PA2Q1XxBAgaBasDLb2FheM54bUWhPfuvqLsXyXhy6FWVujRWLYOFlIjBhyIBDC3CjHVcPsKbXLBo7coFDfsKBBvV4PzjLbVRuG+Z1xBX5CSggzCfb81A2t5cG840Fl6zAxaIO7Ff+P529z3XvNLVXjoN5NEOdEeLlZa2J5eN5QO/NFGBQrnbjajdwTqNkKw4IzLx+xGYjUliI31sOv300l2PzXS7IUfNZ9nvIoiAMrrZEz+uvIKGruufMQ3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(52116005)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wgVYuIduLu8szHDrywjjMsXYBvAsJSyxHEr9GgMyfgn9vDN1GLaEBMmlCXW5?=
 =?us-ascii?Q?pQio+y9plqc6aFKFSKvNKIds3buJlF0geX+Pp69bPY+HRxocUjxjQCvaSaoj?=
 =?us-ascii?Q?VpOhGBPjpaLLshheBCIUTHSI8tXi3dOI6hBzx5ytv2oMJ9kae878qTfWzW6p?=
 =?us-ascii?Q?e31QLAdThRpN+LPrdx4eHG/6qtRdAF2vxQYs6i7LXJYpimkRw4gJ4Y7qL4E7?=
 =?us-ascii?Q?sXQMKf8WXFKOCeQG9HcFpn/vRtop1QiKZwn+wSfvLpmL/+ZmoivdSQUnimA/?=
 =?us-ascii?Q?sWiPjij+ogsu2SAlrQKuERv9mHb6QxM+gOune1L5tkrLOlkryn1wjvEevVwE?=
 =?us-ascii?Q?BXl7vZTpN1zLX3p56fFif7YXAx4PztLOxAc/I0A4b+NNMKoc5RUNm2sV0m1E?=
 =?us-ascii?Q?62TAhiQNE3h901JQ6N+R2oVtLjv8PgjA8Zu6hB6hbqJoimeJ+XgoQs/Tei9L?=
 =?us-ascii?Q?QG0bF5LyWkwOrKRGKxYSccFp1YU1I7n+KOVyaSawwxJryb5agVBKnDmQ5lwX?=
 =?us-ascii?Q?bcmukUjBiQbD4+Pbm7XqA1cLLtHiEgMlsTX5Bw7ZhQW7guYmy2m+JFmHnY3F?=
 =?us-ascii?Q?s7j9G/itaIwnTtHCXW/uO1tlNwBSslRnMp53CE1qNjsXGphJdO6Cn8ZMxXXV?=
 =?us-ascii?Q?qH0NvtU0r7pE5n0+OlzLuO1AE52a86/Dqz2cYWgov2LOOsP4TwmJ4+Tq5VTF?=
 =?us-ascii?Q?SCbdH7RyagBddZdMh2RF/TSSQCJ9Ze1CvzcsvO+vXJ9wzlZvBDaVSZXgtUSd?=
 =?us-ascii?Q?PlWh4H3JjangberEw8RoGuCHE3adilPrfjRjLVzoDgsD6hZMjv4rr6VJGlGZ?=
 =?us-ascii?Q?dfFyZUNSc5fhjt/z2FhTv9/qlaaqMsayibJbYcJf2NegYZO6qHYYSjhJ0koR?=
 =?us-ascii?Q?rr9y9bivh9F9TGU0ubFR1xsFt9bMxvmSfuCpNGcxirAGMPF9GP154bnoKZzH?=
 =?us-ascii?Q?2TULn/xfootAbukqIPWW9I0SiBB6Ou6VDsoAG0NbOPUmmsXvFAHKVAUPoEk/?=
 =?us-ascii?Q?fS6MVbXuPI9aAGK5Xq1YYXSVBjeV9T9VHU4vI4MKjxgCNqjQxfbdEACgB5Mv?=
 =?us-ascii?Q?ZpVEQK9QGGzlRWbVbBr/t63Bi+DUQ2xmcUA2CBOE2lPIU7zSEctFQ+Rzmt4V?=
 =?us-ascii?Q?bSojHDIGrqqHBvm0asHElbeFpWv47L3rppJH5vqcjFbggTX9RwmKTAqpmVQH?=
 =?us-ascii?Q?cpW2B37PeZ0j1I56o/xixY6xS93/JLWPw5ypwLb7nlxM3p3bLTTR/YPWJfFz?=
 =?us-ascii?Q?E1AXwcz96RbY0RsYeAxIC2mxfbM9GfmlzBVcfI9TI1um9sygy0d5vq3UKk2+?=
 =?us-ascii?Q?VW11d+upZ5byPBUsLssitorVwyUe4uMf9BWaN60XrlbKvkTJ1E4kArVWk+xp?=
 =?us-ascii?Q?Fq3l7fDPgaAqhwYklCTpid+cnem5J1dlZCj+eMvaQFXdUDMo1QJY4tcVRLTx?=
 =?us-ascii?Q?RotkFbB+KctFmsjdHB0u4I4b8ILlOMZ8BxYvJyab+5RCbZdCln72z0/hh6RF?=
 =?us-ascii?Q?jvhPs+IEvxjc/Da9NU7E0UWUzOK+dRNm/vGDcaFVjohdhRU2zqomXeXFhwlK?=
 =?us-ascii?Q?6p+V4qHaeARI3DJVuQbqMFSAmDEqAAfuyX+8YEQ7kyOBKtollc7wxbUkVaJ3?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9778c7-813b-46db-dfc8-08dc51f5bc63
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 02:45:05.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcFwkNFvtMwtJVXgYAe5CilxuX3HocLNziVIcKhPe4BrTC1PmKcmrhZkvDEvPdbC6ydk9JooaMlJKUo8M8qMQ2sNaOmkqj58nriWTrGfTsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0798

XGMAC MMC has already added LPI statistics. GMAC MMC lack of these
statistics. Add register definition and reading the LPI statistics
from registers.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
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


