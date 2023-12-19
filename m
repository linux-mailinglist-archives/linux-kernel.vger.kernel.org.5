Return-Path: <linux-kernel+bounces-5430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F733818A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2896D1C23A17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72E032C9D;
	Tue, 19 Dec 2023 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B/j7CUQx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3079A22EF2;
	Tue, 19 Dec 2023 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5Kx1fgmf8geJmzU/1nU//AtN8QwrWQf6soVl5VMRrQhYG25KjM4hGiViQzSNB5qwks9vzISuZfj3rvLOJC0URU1rtdTSzGbDaBpw6R3+31wF1PX+PE0jEyna8Qq1QshddCZzQQUxxfjiquXszcjDTWSZf9enTDby8Qg0/rkvGXBswORe5SCDsdPbvgJlpQSRx9C6B2ZmHNTCLWZbzkwnXzkU5f2ww0Jdejg8WFtu/XYtuCVhMI++OVoZ388ll5sbRcEHAjLiO7enLWqGMxgaw8FSoMSO+TB+pjpvT16y518+2P4WDaFu8ezGhfkEXgu5MNrJ4yoD3Qbk73f516jsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bI+WLDlvFKFpCn4ll6biTNvX3rhcEBt0ktMrqrH8BPo=;
 b=Gdb2EiDZTYH1Lp8aY0xnNUkgLHijzEC2yAxbkLJEdc8Y3fLVed+5qipV9tDlTLLD8CnokR3q743N1XS5I7Vab5lvFVOPhTa/oertGPIVHhbyoGiNNbBVFZm43RFqV1WGQAWGMWN8QQsAjtaDUQh0hYOaxsXg+EJD7KVZkmfRZfk0xRFMwU/GIVcPCuO2UX668lINk+libnxtkiynujwRMMh+zwGkwDpRbVhx8fOVAXl0hFsBRkzlyzmPMAu872Vd1/zK6fmsMf3PDErTpaRsxkZUKAg213+H8/rZLMFatnEqUPEstIjHHx2ht/xgWCBkp0WcLPMDtFq/SC6sQJQHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI+WLDlvFKFpCn4ll6biTNvX3rhcEBt0ktMrqrH8BPo=;
 b=B/j7CUQxaARpD/Gq81fBE1KJdHR9rq1YMqLzA04X1FsuOXLMX0qlKWZPi8nE0rxtS+lrpAPyG8PHFJhxk6K4gioF/QSc5be43eqJ/OQZplsK37yXIXd1EX6uqyD3W8HExCnVhObRrXN2dFrti8QGEeLqhrm7DkamAbqiVCmBkfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Tue, 19 Dec
 2023 14:54:30 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:54:30 +0000
From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To: sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	richardcochran@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	sebastian.tobuschat@oss.nxp.com,
	andrei.botila@oss.nxp.com,
	"Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v9 7/9] net: phy: nxp-c45-tja11xx: add MACsec support
Date: Tue, 19 Dec 2023 16:53:31 +0200
Message-Id: <20231219145333.240323-8-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::45) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e35271c-fcff-4dcc-1f4a-08dc00a26768
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QZGr+TA6WiV6m+d1prEmjm1hNnF1Xj40E6PNTOKemDPuQtltBUj+jBbhgppxaer1jER9ooHZxEfxGhj3VYB/EbITX5VpBFTshaR2X6y0usqjrCNHHUcFTXWPXjp9BABok0wm+kjF1XNaw//JBm+zx/O7IYIJaYm3pM77b2v2zOc0L6kdFFGVUt2WfmNXjQyhBByM2kzto9/lW+2YxEfR0LQ7VxpKsaimWVoWJOlpv6XXBaOeQK7m9pDD/DtDf9bTq5Crfc+63KT1nFGY9atU0LDu4Bm4VDj/G1kxApEmJjg/TTUpiCvJTzTKMKgpcJcOMOWJJnRtWvMdEi5n8L3JM4xchBTQSUYGUdznvi5FXF7/Yl3vxWrCCvzZkn6XGEx7C++ji54UZmshVwAy2PZp+TYE+RfZjE20W2Vk9hrJvW//Qn3fIu0C5Rrfyx9bKYi5pQ8SINaIjddmEqqkPzMTD8qwzVkrxQiq17wcQCuMKdtKtGmDEGvA92cBU6++M41yVM9MLdq20cXCG0SvFOXMyiaK8eIvaxEAzNRNPnEQKkYEJYxTDqcxMt9YId8adIQNkGzIgX7dTJkxHxHNnwpyO40vuceEc3skBrQDuBymJI8IjItNICyOhZnM3YtsSIi7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(52116002)(2616005)(1076003)(38100700002)(83380400001)(66946007)(316002)(7416002)(5660300002)(41300700001)(30864003)(8936002)(478600001)(2906002)(66476007)(6486002)(66556008)(6506007)(6512007)(4326008)(8676002)(86362001)(38350700005)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LT9H1SaSBKq3Jp65ug4bq5Zba/FI2kUwPYUq9doz9T5Mz1kaIfX1E73PZ13L?=
 =?us-ascii?Q?AhaPDDkPQNjesRyVQO7WRwzgJ7aKT3ycnuSh96ESkNWZEe6PdOP+OWhB0g2O?=
 =?us-ascii?Q?Wym3HPNsvoZPcySKRHoC6hcYV4TCm2ksS2HdGxQJNxmdZbJwlXD/Gka/mB0P?=
 =?us-ascii?Q?n461sJf603KGC/YW93RYeFQ1Sfj0xnT1kL23SoDTz37AfdpJlNgfS6+AZnc2?=
 =?us-ascii?Q?QIPVk4IDmVb7UpmbYsKtkL3SVoN+i8zNTQgvl0iR4mOYuquOTpNVQpBXQhco?=
 =?us-ascii?Q?t/4JJ2IaxlhGilTdhVT85vygSGziPldb3w7YF9gbObTM8qRwchjhVIBZ56pp?=
 =?us-ascii?Q?I0kjSClyiQwiIuWwNlY1gy8e1O4qSCEOeKgPrlZ/8Tw6pm1RRjx0lSXPJ3NK?=
 =?us-ascii?Q?mQ1HOUE9NcWIvmRdWo10k9GPz7yCyyqZyTK50LyV5XFGg35fl3vO/CM0ytLr?=
 =?us-ascii?Q?l2D9X+tTlIhB1Fqiv6TEvglL8cXmV0qVkXoVTVJautGond2SAUBOHackC15m?=
 =?us-ascii?Q?E9CrJhoOPLHHlkt+zFoI4K36NH+dbPD3LRzF4yDrFVrXeF291lV9qxhMajzH?=
 =?us-ascii?Q?jzqlm2T5hMaMsUxxMWzpSdXdAOlCrd6bkN+rUM5VFmLsew+KEAxRDyopfHkI?=
 =?us-ascii?Q?RiSC8rB/66iaaL3EHx0U3W3Hc5eXepkkCzJ6lRi8ZICQQXovmf0nsf+fdx3z?=
 =?us-ascii?Q?IGYeZncbhYcla8fD845iXgKRHyCL/zmn3kg9NPJ9o66IcSpvYl9s6fsbf4vj?=
 =?us-ascii?Q?n7rCOG4Fosp/tEbbSbN1SHsx0O4elfeQodKCIyDs5sSg6owIe2Wyt75WHvNH?=
 =?us-ascii?Q?lzxwJDqjJFDzK4nzpX/ao5M+9pe7XzL6V+AvmkEJfHswxVfGGFSbr1J/6UoD?=
 =?us-ascii?Q?SeXRDJ4vhvMeFkENqzm9JVY/VTK7NeYNcLG2w4PnmwXqSmCrkOmospQbO2wX?=
 =?us-ascii?Q?QeVA//PxLhpoV12VLaZ3z50UzHlxIg56euc/lUZSJ5RsANgPSgtnKkco1bzs?=
 =?us-ascii?Q?l7z8HLNxtUk4HvG3DT9kBH87kxWUxGi8GFXBOFbma3UhB6aF8tTxirIkc0aI?=
 =?us-ascii?Q?9fayLak/rmOr4InmEL8mDNH3eGDEvedb+FfUySS5DlwTPN8RFOffVF0OOJtl?=
 =?us-ascii?Q?reTHWy3WfFZn/DVJ7GNWvZMbcd1d6KR4RGbTam+6o+twGzjOeGfxsDA+OMXJ?=
 =?us-ascii?Q?Kf9YnZ1JuSZ7V2RhUh2Yu32lff3eWoBRoaH98zi2/6Cx8jdXXoYA/4aax5sC?=
 =?us-ascii?Q?E4fzmayeivhr7hQ9juFWN63j7gKLd4YXZcttb/cHXAyMGE58NhDdNPpOUoU6?=
 =?us-ascii?Q?gx6ycrqlgHdM+OKNKJIeqlCumMrqfl2SC/Z8qzSw/Q+2+j5yCqPHXYC6sG0/?=
 =?us-ascii?Q?Dq9fx0Pj+fI1shYA0sW9bshoEtRlJamaNAGdPBWsU0Nhea2p3tFgSQpXKY53?=
 =?us-ascii?Q?XqFCKiZj5DuLkfWA0aZvqA9LBgazT+8ZcNN3DkpDJRWFK9Edcfe++Ac0BPXn?=
 =?us-ascii?Q?3UdlY6UQJh3j6iR0GRZq3/AfR/L5bYZSdkZR4B83a+CZpbN80lPgmzxlOVAv?=
 =?us-ascii?Q?Ytz+eO0U0KJe3Nmy2cK0vywk47kiDvFTkmHYJjoCV/hOfVI4spnzT/tBI3Yn?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e35271c-fcff-4dcc-1f4a-08dc00a26768
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:54:30.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPripN6unKrEOx+EociLlOjb50UbdSkW/nWVZ/oUWEY6p+RhZ4js+7C62LMG3gJxPUVKjB/cksvM05prz7Ds5PsufGxAzJncHFBE2vD0iD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142

Add MACsec support.
The MACsec block has four TX SCs and four RX SCs. The driver supports up
to four SecY. Each SecY with one TX SC and one RX SC.
The RX SCs can have two keys, key A and key B, written in hardware and
enabled at the same time.
The TX SCs can have two keys written in hardware, but only one can be
active at a given time.
On TX, the SC is selected using the MAC source address. Due of this
selection mechanism, each offloaded netdev must have a unique MAC
address.
On RX, the SC is selected by SCI(found in SecTAG or calculated using MAC
SA), or using RX SC 0 as implicit.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v9:
- added driver MACSEC dependency
- ocurences -> occurrences - fixed typo
- use kfree instead of kfree_sensitive
- nxp_c45_sci_valid transformed to nxp_c45_port_is_1
- nxp_c45_secy_valid was simplified and is not touching
phy_secy->rx_sc0_impl anymore
- phy_secy->rx_sc0_impl is assigned using nxp_c45_rx_sc0_impl
- the replay window is updated even if the RX SC is enabled
- the RX SAs are removed when the RX SC is removed
- nxp_c45_handle_macsec_interrupt use nxp_c45_find_secy_by_id to find the
source of the IRQ. If the nxp_c45_find_secy_by_id has returned an error,
then a WARN will be printed and the IRQ will be acked.

Changes in v6-v8:
- none

Changes in V5:
- added nxp_c45_secy_irq_en helper to enable and disable the irqs and
replaced the irq enable/disable sequence from
nxp_c45_mdo_add_secy/nxp_c45_mdo_del_secy with it
- changed nxp_c45_tx_sc_set_flt parameters. macsec_context and secy_id
replaced with phy_device and nxp_c45_secy pointers.
- nxp_c45_mdo_dev_open/nxp_c45_mdo_dev_stop - priv is get from phydev->priv
instead of ctx->phydev->priv
- nxp_c45_sa_set_key - nxp_c45_macsec_write call uses 
phydev(local variable) instead of ctx->phydev

Changes in V4:
- Added nxp_c45_secy_free.
- Added nxp_c45_macsec_en.
- Added nxp_c45_macsec_remove.
- nxp_c45_sa_set_pn does if the pn is 0. validate_upd_sa checks this.
- check ctx->sa.update_pn flag before updating next_pn.
- nxp_c45_macsec_config_init and nxp_c45_handle_macsec_interrupt are
checking priv->macsec instead of phydev->macsec_ops to check if macsec is
offloaded.
- nxp_c45_handle_macsec_interrupt - replaced WARN_ON(!sa) with 
WARN_ON(1). sa is either -err_value or a valid pointer and WARN_ON was
doing nothing.
- nxp_c45_tx_sa_update does not check if (sa->an != encoding_sa).
encoding_sa removed from parameters list.
- nxp_c45_mdo_upd/del_txsa updates the sa status only if sa->an ==
encoding_sa
- nxp_c45_mdo_add_rxsc - apply RX SCI restrictions only if end_station is
true

Changes in v3:
- removed struct nxp_c45_rx_sc
- replaced struct nxp_c45_tx_sa with struct nxp_c45_sa
- reworked the implementation around struct nxp_c45_sa
- various renamings
- tried to better group the functions by SA type/SC type
- no key is stored in the driver
- TX SAs limited to 2 insted of 4(no key in the driver consequence)
- used sci_to_cpu where in various functions
- improved debug information
- nxp_c45_secy_valid function reworked
- merged TX/RX SA set key functions
- merged TX/RX SA set pn functions
- tried to stick to tx_sa/rx_sa/rx_sc/tx_sc function naming. 
- nxp_c45_macsec_config_init will return an error if a write fails.
- MACSEC_TXSC_CFG_SCI renamed to MACSEC_TXSC_CFG_SCB
- return -ENOSPC if no SC/SA available in the hardware
- phydev->macsec allocated using devm_kzalloc
- changed name of the driver object file

Changes in v2:
- WARN_ON_ONCE if reg address is not properly aligned
- improved patch description

 MAINTAINERS                              |    2 +-
 drivers/net/phy/Kconfig                  |    3 +-
 drivers/net/phy/Makefile                 |    6 +-
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1343 ++++++++++++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c        |   77 +-
 drivers/net/phy/nxp-c45-tja11xx.h        |   62 +
 6 files changed, 1460 insertions(+), 33 deletions(-)
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index dda78b4ce707..0504bb015f57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15443,7 +15443,7 @@ NXP C45 TJA11XX PHY DRIVER
 M:	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/net/phy/nxp-c45-tja11xx.c
+F:	drivers/net/phy/nxp-c45-tja11xx*
 
 NXP FSPI DRIVER
 M:	Han Xu <han.xu@nxp.com>
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 2e4667bf9ff5..9e2672800f0b 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -317,9 +317,10 @@ config NXP_CBTX_PHY
 config NXP_C45_TJA11XX_PHY
 	tristate "NXP C45 TJA11XX PHYs"
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on MACSEC || !MACSEC
 	help
 	  Enable support for NXP C45 TJA11XX PHYs.
-	  Currently supports the TJA1103 and TJA1120 PHYs.
+	  Currently supports the TJA1103, TJA1104 and TJA1120 PHYs.
 
 config NXP_TJA11XX_PHY
 	tristate "NXP TJA11xx PHYs support"
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index e35ea69d9cb4..6097afd44392 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -84,7 +84,11 @@ obj-$(CONFIG_MICROSEMI_PHY)	+= mscc/
 obj-$(CONFIG_MOTORCOMM_PHY)	+= motorcomm.o
 obj-$(CONFIG_NATIONAL_PHY)	+= national.o
 obj-$(CONFIG_NCN26000_PHY)	+= ncn26000.o
-obj-$(CONFIG_NXP_C45_TJA11XX_PHY)	+= nxp-c45-tja11xx.o
+nxp-c45-tja-objs		+= nxp-c45-tja11xx.o
+ifdef CONFIG_MACSEC
+nxp-c45-tja-objs		+= nxp-c45-tja11xx-macsec.o
+endif
+obj-$(CONFIG_NXP_C45_TJA11XX_PHY)	+= nxp-c45-tja.o
 obj-$(CONFIG_NXP_CBTX_PHY)	+= nxp-cbtx.o
 obj-$(CONFIG_NXP_TJA11XX_PHY)	+= nxp-tja11xx.o
 obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
new file mode 100644
index 000000000000..9c5c07138f89
--- /dev/null
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -0,0 +1,1343 @@
+// SPDX-License-Identifier: GPL-2.0
+/* NXP C45 PTP PHY driver interface
+ * Copyright 2023 NXP
+ * Author: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/ethtool_netlink.h>
+#include <linux/kernel.h>
+#include <linux/mii.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+#include <linux/processor.h>
+#include <net/macsec.h>
+
+#include "nxp-c45-tja11xx.h"
+
+#define MACSEC_REG_SIZE			32
+#define TX_SC_MAX			4
+
+#define TX_SC_BIT(secy_id)		BIT(MACSEC_REG_SIZE - (secy_id) - 1)
+
+#define VEND1_MACSEC_BASE		0x9000
+
+#define MACSEC_CFG			0x0000
+#define MACSEC_CFG_BYPASS		BIT(1)
+#define MACSEC_CFG_S0I			BIT(0)
+
+#define MACSEC_TPNET			0x0044
+#define PN_WRAP_THRESHOLD		0xffffffff
+
+#define MACSEC_RXSCA			0x0080
+#define MACSEC_RXSCKA			0x0084
+
+#define MACSEC_TXSCA			0x00C0
+#define MACSEC_TXSCKA			0x00C4
+
+#define MACSEC_RXSC_SCI_1H		0x0100
+
+#define MACSEC_RXSC_CFG			0x0128
+#define MACSEC_RXSC_CFG_XPN		BIT(25)
+#define MACSEC_RXSC_CFG_AES_256		BIT(24)
+#define MACSEC_RXSC_CFG_SCI_EN		BIT(11)
+#define MACSEC_RXSC_CFG_RP		BIT(10)
+#define MACSEC_RXSC_CFG_VF_MASK		GENMASK(9, 8)
+#define MACSEC_RXSC_CFG_VF_OFF		8
+
+#define MACSEC_RPW			0x012C
+
+#define MACSEC_RXSA_A_CS		0x0180
+#define MACSEC_RXSA_A_NPN		0x0184
+#define MACSEC_RXSA_A_XNPN		0x0188
+#define MACSEC_RXSA_A_LNPN		0x018C
+#define MACSEC_RXSA_A_LXNPN		0x0190
+
+#define MACSEC_RXSA_B_CS		0x01C0
+#define MACSEC_RXSA_B_NPN		0x01C4
+#define MACSEC_RXSA_B_XNPN		0x01C8
+#define MACSEC_RXSA_B_LNPN		0x01CC
+#define MACSEC_RXSA_B_LXNPN		0x01D0
+
+#define MACSEC_RXSA_CS_AN_OFF		1
+#define MACSEC_RXSA_CS_EN		BIT(0)
+
+#define MACSEC_TXSC_SCI_1H		0x0200
+#define MACSEC_TXSC_CFG			0x0228
+#define MACSEC_TXSC_CFG_XPN		BIT(25)
+#define MACSEC_TXSC_CFG_AES_256		BIT(24)
+#define MACSEC_TXSC_CFG_AN_MASK		GENMASK(19, 18)
+#define MACSEC_TXSC_CFG_AN_OFF		18
+#define MACSEC_TXSC_CFG_ASA		BIT(17)
+#define MACSEC_TXSC_CFG_SCE		BIT(16)
+#define MACSEC_TXSC_CFG_ENCRYPT		BIT(4)
+#define MACSEC_TXSC_CFG_PROTECT		BIT(3)
+#define MACSEC_TXSC_CFG_SEND_SCI	BIT(2)
+#define MACSEC_TXSC_CFG_END_STATION	BIT(1)
+#define MACSEC_TXSC_CFG_SCB		BIT(0)
+
+#define MACSEC_TXSA_A_CS		0x0280
+#define MACSEC_TXSA_A_NPN		0x0284
+#define MACSEC_TXSA_A_XNPN		0x0288
+
+#define MACSEC_TXSA_B_CS		0x02C0
+#define MACSEC_TXSA_B_NPN		0x02C4
+#define MACSEC_TXSA_B_XNPN		0x02C8
+
+#define MACSEC_SA_CS_A			BIT(31)
+
+#define MACSEC_EVR			0x0400
+#define MACSEC_EVER			0x0404
+
+#define MACSEC_RXSA_A_KA		0x0700
+#define MACSEC_RXSA_A_SSCI		0x0720
+#define MACSEC_RXSA_A_SALT		0x0724
+
+#define MACSEC_RXSA_B_KA		0x0740
+#define MACSEC_RXSA_B_SSCI		0x0760
+#define MACSEC_RXSA_B_SALT		0x0764
+
+#define MACSEC_TXSA_A_KA		0x0780
+#define MACSEC_TXSA_A_SSCI		0x07A0
+#define MACSEC_TXSA_A_SALT		0x07A4
+
+#define MACSEC_TXSA_B_KA		0x07C0
+#define MACSEC_TXSA_B_SSCI		0x07E0
+#define MACSEC_TXSA_B_SALT		0x07E4
+
+#define MACSEC_UPFR0D2			0x0A08
+#define MACSEC_UPFR0M1			0x0A10
+#define MACSEC_OVP			BIT(12)
+
+#define	MACSEC_UPFR0M2			0x0A14
+#define ETYPE_MASK			0xffff
+
+#define MACSEC_UPFR0R			0x0A18
+#define MACSEC_UPFR_EN			BIT(0)
+
+#define ADPTR_CNTRL			0x0F00
+#define ADPTR_CNTRL_CONFIG_EN		BIT(14)
+#define ADPTR_CNTRL_ADPTR_EN		BIT(12)
+
+#define TX_SC_FLT_BASE			0x800
+#define TX_SC_FLT_SIZE			0x10
+#define TX_FLT_BASE(flt_id)		(TX_SC_FLT_BASE + \
+	TX_SC_FLT_SIZE * (flt_id))
+
+#define TX_SC_FLT_OFF_MAC_DA_SA		0x04
+#define TX_SC_FLT_OFF_MAC_SA		0x08
+#define TX_SC_FLT_OFF_MAC_CFG		0x0C
+#define TX_SC_FLT_BY_SA			BIT(14)
+#define TX_SC_FLT_EN			BIT(8)
+
+#define TX_SC_FLT_MAC_DA_SA(base)	((base) + TX_SC_FLT_OFF_MAC_DA_SA)
+#define TX_SC_FLT_MAC_SA(base)		((base) + TX_SC_FLT_OFF_MAC_SA)
+#define TX_SC_FLT_MAC_CFG(base)		((base) + TX_SC_FLT_OFF_MAC_CFG)
+
+#define ADAPTER_EN	BIT(6)
+#define MACSEC_EN	BIT(5)
+
+enum nxp_c45_sa_type {
+	TX_SA,
+	RX_SA,
+};
+
+struct nxp_c45_sa {
+	void *sa;
+	const struct nxp_c45_sa_regs *regs;
+	enum nxp_c45_sa_type type;
+	bool is_key_a;
+	u8 an;
+	struct list_head list;
+};
+
+struct nxp_c45_secy {
+	struct macsec_secy *secy;
+	struct macsec_rx_sc *rx_sc;
+	struct list_head sa_list;
+	int secy_id;
+	bool rx_sc0_impl;
+	struct list_head list;
+};
+
+struct nxp_c45_macsec {
+	struct list_head secy_list;
+	DECLARE_BITMAP(secy_bitmap, TX_SC_MAX);
+	DECLARE_BITMAP(tx_sc_bitmap, TX_SC_MAX);
+};
+
+struct nxp_c45_sa_regs {
+	u16 cs;
+	u16 npn;
+	u16 xnpn;
+	u16 lnpn;
+	u16 lxnpn;
+	u16 ka;
+	u16 ssci;
+	u16 salt;
+};
+
+static const struct nxp_c45_sa_regs rx_sa_a_regs = {
+	.cs	= MACSEC_RXSA_A_CS,
+	.npn	= MACSEC_RXSA_A_NPN,
+	.xnpn	= MACSEC_RXSA_A_XNPN,
+	.lnpn	= MACSEC_RXSA_A_LNPN,
+	.lxnpn	= MACSEC_RXSA_A_LXNPN,
+	.ka	= MACSEC_RXSA_A_KA,
+	.ssci	= MACSEC_RXSA_A_SSCI,
+	.salt	= MACSEC_RXSA_A_SALT,
+};
+
+static const struct nxp_c45_sa_regs rx_sa_b_regs = {
+	.cs	= MACSEC_RXSA_B_CS,
+	.npn	= MACSEC_RXSA_B_NPN,
+	.xnpn	= MACSEC_RXSA_B_XNPN,
+	.lnpn	= MACSEC_RXSA_B_LNPN,
+	.lxnpn	= MACSEC_RXSA_B_LXNPN,
+	.ka	= MACSEC_RXSA_B_KA,
+	.ssci	= MACSEC_RXSA_B_SSCI,
+	.salt	= MACSEC_RXSA_B_SALT,
+};
+
+static const struct nxp_c45_sa_regs tx_sa_a_regs = {
+	.cs	= MACSEC_TXSA_A_CS,
+	.npn	= MACSEC_TXSA_A_NPN,
+	.xnpn	= MACSEC_TXSA_A_XNPN,
+	.ka	= MACSEC_TXSA_A_KA,
+	.ssci	= MACSEC_TXSA_A_SSCI,
+	.salt	= MACSEC_TXSA_A_SALT,
+};
+
+static const struct nxp_c45_sa_regs tx_sa_b_regs = {
+	.cs	= MACSEC_TXSA_B_CS,
+	.npn	= MACSEC_TXSA_B_NPN,
+	.xnpn	= MACSEC_TXSA_B_XNPN,
+	.ka	= MACSEC_TXSA_B_KA,
+	.ssci	= MACSEC_TXSA_B_SSCI,
+	.salt	= MACSEC_TXSA_B_SALT,
+};
+
+static const
+struct nxp_c45_sa_regs *nxp_c45_sa_regs_get(enum nxp_c45_sa_type sa_type,
+					    bool key_a)
+{
+	if (sa_type == RX_SA)
+		if (key_a)
+			return &rx_sa_a_regs;
+		else
+			return &rx_sa_b_regs;
+	else if (sa_type == TX_SA)
+		if (key_a)
+			return &tx_sa_a_regs;
+		else
+			return &tx_sa_b_regs;
+	else
+		return NULL;
+}
+
+static int nxp_c45_macsec_write(struct phy_device *phydev, u16 addr, u32 value)
+{
+	u32 lvalue = value;
+	u16 laddr;
+	int ret;
+
+	WARN_ON_ONCE(addr % 4);
+
+	phydev_dbg(phydev, "write addr 0x%x value 0x%x\n", addr, value);
+
+	laddr = VEND1_MACSEC_BASE + addr / 2;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, laddr, lvalue);
+	if (ret)
+		return ret;
+
+	laddr += 1;
+	lvalue >>= 16;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, laddr, lvalue);
+
+	return ret;
+}
+
+static int nxp_c45_macsec_read(struct phy_device *phydev, u16 addr, u32 *value)
+{
+	u32 lvalue;
+	u16 laddr;
+	int ret;
+
+	WARN_ON_ONCE(addr % 4);
+
+	laddr = VEND1_MACSEC_BASE + addr / 2;
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, laddr);
+	if (ret < 0)
+		return ret;
+
+	laddr += 1;
+	lvalue = (u32)ret & 0xffff;
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, laddr);
+	if (ret < 0)
+		return ret;
+
+	lvalue |= (u32)ret << 16;
+	*value = lvalue;
+
+	phydev_dbg(phydev, "read addr 0x%x value 0x%x\n", addr, *value);
+
+	return 0;
+}
+
+static void nxp_c45_secy_irq_en(struct phy_device *phydev,
+				struct nxp_c45_secy *phy_secy, bool en)
+{
+	u32 reg;
+
+	nxp_c45_macsec_read(phydev, MACSEC_EVER, &reg);
+	if (en)
+		reg |= TX_SC_BIT(phy_secy->secy_id);
+	else
+		reg &= ~TX_SC_BIT(phy_secy->secy_id);
+	nxp_c45_macsec_write(phydev, MACSEC_EVER, reg);
+}
+
+static struct nxp_c45_secy *nxp_c45_find_secy(struct list_head *secy_list,
+					      sci_t sci)
+{
+	struct nxp_c45_secy *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, secy_list, list)
+		if (pos->secy->sci == sci)
+			return pos;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static struct
+nxp_c45_secy *nxp_c45_find_secy_by_id(struct list_head *secy_list,
+				      int id)
+{
+	struct nxp_c45_secy *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, secy_list, list)
+		if (pos->secy_id == id)
+			return pos;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static void nxp_c45_secy_free(struct nxp_c45_secy *phy_secy)
+{
+	list_del(&phy_secy->list);
+	kfree(phy_secy);
+}
+
+static struct nxp_c45_sa *nxp_c45_find_sa(struct list_head *sa_list,
+					  enum nxp_c45_sa_type sa_type, u8 an)
+{
+	struct nxp_c45_sa *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, sa_list, list)
+		if (pos->an == an && pos->type == sa_type)
+			return pos;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static struct nxp_c45_sa *nxp_c45_sa_alloc(struct list_head *sa_list, void *sa,
+					   enum nxp_c45_sa_type sa_type, u8 an)
+{
+	struct nxp_c45_sa *first = NULL, *pos, *tmp;
+	int occurrences = 0;
+
+	list_for_each_entry_safe(pos, tmp, sa_list, list) {
+		if (pos->type != sa_type)
+			continue;
+
+		if (pos->an == an)
+			return ERR_PTR(-EINVAL);
+
+		first = pos;
+		occurrences++;
+		if (occurrences >= 2)
+			return ERR_PTR(-ENOSPC);
+	}
+
+	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return ERR_PTR(-ENOMEM);
+
+	if (first)
+		tmp->is_key_a = !first->is_key_a;
+	else
+		tmp->is_key_a = true;
+
+	tmp->sa = sa;
+	tmp->type = sa_type;
+	tmp->an = an;
+	tmp->regs = nxp_c45_sa_regs_get(tmp->type, tmp->is_key_a);
+	list_add_tail(&tmp->list, sa_list);
+
+	return tmp;
+}
+
+static void nxp_c45_sa_free(struct nxp_c45_sa *sa)
+{
+	list_del(&sa->list);
+	kfree(sa);
+}
+
+static void nxp_c45_sa_list_free(struct list_head *sa_list)
+{
+	struct nxp_c45_sa *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, sa_list, list)
+		nxp_c45_sa_free(pos);
+}
+
+static void nxp_c45_sa_set_pn(struct phy_device *phydev,
+			      struct nxp_c45_sa *sa, u64 pn,
+			      u32 replay_window)
+{
+	const struct nxp_c45_sa_regs *sa_regs = sa->regs;
+	pn_t npn = {.full64 = pn};
+	pn_t lnpn;
+
+	nxp_c45_macsec_write(phydev, sa_regs->npn, npn.lower);
+	nxp_c45_macsec_write(phydev, sa_regs->xnpn, npn.upper);
+	if (sa->type != RX_SA)
+		return;
+
+	if (pn > replay_window)
+		lnpn.full64 = pn - replay_window;
+	else
+		lnpn.full64 = 1;
+
+	nxp_c45_macsec_write(phydev, sa_regs->lnpn, lnpn.lower);
+	nxp_c45_macsec_write(phydev, sa_regs->lxnpn, lnpn.upper);
+}
+
+static void nxp_c45_sa_set_key(struct macsec_context *ctx,
+			       const struct nxp_c45_sa_regs *sa_regs,
+			       u8 *salt, ssci_t ssci)
+{
+	struct phy_device *phydev = ctx->phydev;
+	u32 key_size = ctx->secy->key_len / 4;
+	u32 salt_size = MACSEC_SALT_LEN / 4;
+	u32 *key_u32 = (u32 *)ctx->sa.key;
+	u32 *salt_u32 = (u32 *)salt;
+	u32 reg, value;
+	int i;
+
+	for (i = 0; i < key_size; i++) {
+		reg = sa_regs->ka + i * 4;
+		value = (__force u32)cpu_to_be32(key_u32[i]);
+		nxp_c45_macsec_write(phydev, reg, value);
+	}
+
+	if (ctx->secy->xpn) {
+		for (i = 0; i < salt_size; i++) {
+			reg = sa_regs->salt + (2 - i) * 4;
+			value = (__force u32)cpu_to_be32(salt_u32[i]);
+			nxp_c45_macsec_write(phydev, reg, value);
+		}
+
+		value = (__force u32)cpu_to_be32((__force u32)ssci);
+		nxp_c45_macsec_write(phydev, sa_regs->ssci, value);
+	}
+
+	nxp_c45_macsec_write(phydev, sa_regs->cs, MACSEC_SA_CS_A);
+}
+
+static void nxp_c45_rx_sa_update(struct phy_device *phydev,
+				 struct nxp_c45_sa *sa, bool en)
+{
+	const struct nxp_c45_sa_regs *sa_regs = sa->regs;
+	u32 cfg;
+
+	cfg = sa->an << MACSEC_RXSA_CS_AN_OFF;
+	cfg |= en ? MACSEC_RXSA_CS_EN : 0;
+	nxp_c45_macsec_write(phydev, sa_regs->cs, cfg);
+}
+
+static void nxp_c45_tx_sa_update(struct phy_device *phydev,
+				 struct nxp_c45_sa *sa, bool en)
+{
+	u32 cfg = 0;
+
+	nxp_c45_macsec_read(phydev, MACSEC_TXSC_CFG, &cfg);
+
+	cfg &= ~MACSEC_TXSC_CFG_AN_MASK;
+	cfg |= sa->an << MACSEC_TXSC_CFG_AN_OFF;
+
+	if (sa->is_key_a)
+		cfg &= ~MACSEC_TXSC_CFG_ASA;
+	else
+		cfg |= MACSEC_TXSC_CFG_ASA;
+
+	if (en)
+		cfg |= MACSEC_TXSC_CFG_SCE;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_SCE;
+
+	nxp_c45_macsec_write(phydev, MACSEC_TXSC_CFG, cfg);
+}
+
+static void nxp_c45_set_sci(struct phy_device *phydev, u16 sci_base_addr,
+			    sci_t sci)
+{
+	u64 lsci = sci_to_cpu(sci);
+
+	nxp_c45_macsec_write(phydev, sci_base_addr, lsci >> 32);
+	nxp_c45_macsec_write(phydev, sci_base_addr + 4, lsci);
+}
+
+static bool nxp_c45_port_is_1(sci_t sci)
+{
+	u16 port = sci_to_cpu(sci);
+
+	return port == 1;
+}
+
+static void nxp_c45_select_secy(struct phy_device *phydev, u8 id)
+{
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCA, id);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCKA, id);
+	nxp_c45_macsec_write(phydev, MACSEC_TXSCA, id);
+	nxp_c45_macsec_write(phydev, MACSEC_TXSCKA, id);
+}
+
+static bool nxp_c45_secy_valid(struct nxp_c45_secy *phy_secy,
+			       bool can_rx_sc0_impl)
+{
+	bool end_station = phy_secy->secy->tx_sc.end_station;
+	bool scb = phy_secy->secy->tx_sc.scb;
+
+	phy_secy->rx_sc0_impl = false;
+
+	if (end_station) {
+		if (!nxp_c45_port_is_1(phy_secy->secy->sci))
+			return false;
+		if (!phy_secy->rx_sc)
+			return true;
+		return nxp_c45_port_is_1(phy_secy->rx_sc->sci);
+	}
+
+	if (scb)
+		return false;
+
+	if (!can_rx_sc0_impl)
+		return false;
+
+	if (phy_secy->secy_id != 0)
+		return false;
+
+	phy_secy->rx_sc0_impl = true;
+
+	return true;
+}
+
+static bool nxp_c45_rx_sc0_impl(struct nxp_c45_secy *phy_secy)
+{
+	bool end_station = phy_secy->secy->tx_sc.end_station;
+	bool send_sci = phy_secy->secy->tx_sc.send_sci;
+	bool scb = phy_secy->secy->tx_sc.scb;
+
+	return !end_station && !send_sci && !scb;
+}
+
+static bool nxp_c45_mac_addr_free(struct macsec_context *ctx)
+{
+	struct nxp_c45_phy *priv = ctx->phydev->priv;
+	struct nxp_c45_secy *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, &priv->macsec->secy_list, list) {
+		if (pos->secy == ctx->secy)
+			continue;
+
+		if (memcmp(pos->secy->netdev->dev_addr,
+			   ctx->secy->netdev->dev_addr, ETH_ALEN) == 0)
+			return false;
+	}
+
+	return true;
+}
+
+static void nxp_c45_tx_sc_en_flt(struct phy_device *phydev, int secy_id,
+				 bool en)
+{
+	u32 tx_flt_base = TX_FLT_BASE(secy_id);
+	u32 reg = 0;
+
+	nxp_c45_macsec_read(phydev, TX_SC_FLT_MAC_CFG(tx_flt_base), &reg);
+	if (en)
+		reg |= TX_SC_FLT_EN;
+	else
+		reg &= ~TX_SC_FLT_EN;
+	nxp_c45_macsec_write(phydev, TX_SC_FLT_MAC_CFG(tx_flt_base), reg);
+}
+
+static void nxp_c45_tx_sc_set_flt(struct phy_device *phydev,
+				  struct nxp_c45_secy *phy_secy)
+{
+	const u8 *dev_addr = phy_secy->secy->netdev->dev_addr;
+	u32 tx_flt_base = TX_FLT_BASE(phy_secy->secy_id);
+	u32 reg;
+
+	reg = dev_addr[0] << 8 | dev_addr[1];
+	nxp_c45_macsec_write(phydev, TX_SC_FLT_MAC_DA_SA(tx_flt_base), reg);
+	reg = dev_addr[5] | dev_addr[4] << 8 | dev_addr[3] << 16 |
+		dev_addr[2] << 24;
+
+	nxp_c45_macsec_write(phydev, TX_SC_FLT_MAC_SA(tx_flt_base), reg);
+	nxp_c45_macsec_read(phydev, TX_SC_FLT_MAC_CFG(tx_flt_base), &reg);
+	reg &= TX_SC_FLT_EN;
+	reg |= TX_SC_FLT_BY_SA | phy_secy->secy_id;
+	nxp_c45_macsec_write(phydev, TX_SC_FLT_MAC_CFG(tx_flt_base), reg);
+}
+
+static void nxp_c45_tx_sc_update(struct phy_device *phydev,
+				 struct nxp_c45_secy *phy_secy)
+{
+	u32 cfg = 0;
+
+	nxp_c45_macsec_read(phydev, MACSEC_TXSC_CFG, &cfg);
+
+	phydev_dbg(phydev, "XPN %s\n", phy_secy->secy->xpn ? "on" : "off");
+	if (phy_secy->secy->xpn)
+		cfg |= MACSEC_TXSC_CFG_XPN;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_XPN;
+
+	phydev_dbg(phydev, "key len %u\n", phy_secy->secy->key_len);
+	if (phy_secy->secy->key_len == 32)
+		cfg |= MACSEC_TXSC_CFG_AES_256;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_AES_256;
+
+	phydev_dbg(phydev, "encryption %s\n",
+		   phy_secy->secy->tx_sc.encrypt ? "on" : "off");
+	if (phy_secy->secy->tx_sc.encrypt)
+		cfg |= MACSEC_TXSC_CFG_ENCRYPT;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_ENCRYPT;
+
+	phydev_dbg(phydev, "protect frames %s\n",
+		   phy_secy->secy->protect_frames ? "on" : "off");
+	if (phy_secy->secy->protect_frames)
+		cfg |= MACSEC_TXSC_CFG_PROTECT;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_PROTECT;
+
+	phydev_dbg(phydev, "send sci %s\n",
+		   phy_secy->secy->tx_sc.send_sci ? "on" : "off");
+	if (phy_secy->secy->tx_sc.send_sci)
+		cfg |= MACSEC_TXSC_CFG_SEND_SCI;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_SEND_SCI;
+
+	phydev_dbg(phydev, "end station %s\n",
+		   phy_secy->secy->tx_sc.end_station ? "on" : "off");
+	if (phy_secy->secy->tx_sc.end_station)
+		cfg |= MACSEC_TXSC_CFG_END_STATION;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_END_STATION;
+
+	phydev_dbg(phydev, "scb %s\n",
+		   phy_secy->secy->tx_sc.scb ? "on" : "off");
+	if (phy_secy->secy->tx_sc.scb)
+		cfg |= MACSEC_TXSC_CFG_SCB;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_SCB;
+
+	nxp_c45_macsec_write(phydev, MACSEC_TXSC_CFG, cfg);
+}
+
+static void nxp_c45_set_rx_sc0_impl(struct phy_device *phydev,
+				    bool enable)
+{
+	u32 reg = 0;
+
+	nxp_c45_macsec_read(phydev, MACSEC_CFG, &reg);
+	if (enable)
+		reg |= MACSEC_CFG_S0I;
+	else
+		reg &= ~MACSEC_CFG_S0I;
+	nxp_c45_macsec_write(phydev, MACSEC_CFG, reg);
+}
+
+static bool nxp_c45_is_rx_sc0_impl(struct list_head *secy_list)
+{
+	struct nxp_c45_secy *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, secy_list, list)
+		if (pos->rx_sc0_impl)
+			return pos->rx_sc0_impl;
+
+	return false;
+}
+
+static void nxp_c45_rx_sc_en(struct phy_device *phydev,
+			     struct macsec_rx_sc *rx_sc, bool en)
+{
+	u32 reg = 0;
+
+	nxp_c45_macsec_read(phydev, MACSEC_RXSC_CFG, &reg);
+	if (rx_sc->active && en)
+		reg |= MACSEC_RXSC_CFG_SCI_EN;
+	else
+		reg &= ~MACSEC_RXSC_CFG_SCI_EN;
+	nxp_c45_macsec_write(phydev, MACSEC_RXSC_CFG, reg);
+}
+
+static void nxp_c45_rx_sc_update(struct phy_device *phydev,
+				 struct nxp_c45_secy *phy_secy)
+{
+	struct macsec_rx_sc *rx_sc = phy_secy->rx_sc;
+	struct nxp_c45_phy *priv = phydev->priv;
+	u32 cfg = 0;
+
+	nxp_c45_macsec_read(phydev, MACSEC_RXSC_CFG, &cfg);
+	cfg &= ~MACSEC_RXSC_CFG_VF_MASK;
+	cfg = phy_secy->secy->validate_frames << MACSEC_RXSC_CFG_VF_OFF;
+
+	phydev_dbg(phydev, "validate frames %u\n",
+		   phy_secy->secy->validate_frames);
+	phydev_dbg(phydev, "replay_protect %s window %u\n",
+		   phy_secy->secy->replay_protect ? "on" : "off",
+		   phy_secy->secy->replay_window);
+	if (phy_secy->secy->replay_protect) {
+		cfg |= MACSEC_RXSC_CFG_RP;
+		nxp_c45_macsec_write(phydev, MACSEC_RPW,
+				     phy_secy->secy->replay_window);
+	} else {
+		cfg &= ~MACSEC_RXSC_CFG_RP;
+	}
+
+	phydev_dbg(phydev, "rx_sc->active %s\n",
+		   rx_sc->active ? "on" : "off");
+	if (rx_sc->active &&
+	    test_bit(phy_secy->secy_id, priv->macsec->secy_bitmap))
+		cfg |= MACSEC_RXSC_CFG_SCI_EN;
+	else
+		cfg &= ~MACSEC_RXSC_CFG_SCI_EN;
+
+	phydev_dbg(phydev, "key len %u\n", phy_secy->secy->key_len);
+	if (phy_secy->secy->key_len == 32)
+		cfg |= MACSEC_RXSC_CFG_AES_256;
+	else
+		cfg &= ~MACSEC_RXSC_CFG_AES_256;
+
+	phydev_dbg(phydev, "XPN %s\n", phy_secy->secy->xpn ? "on" : "off");
+	if (phy_secy->secy->xpn)
+		cfg |= MACSEC_RXSC_CFG_XPN;
+	else
+		cfg &= ~MACSEC_RXSC_CFG_XPN;
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXSC_CFG, cfg);
+}
+
+static void nxp_c45_rx_sc_del(struct phy_device *phydev,
+			      struct nxp_c45_secy *phy_secy)
+{
+	struct nxp_c45_sa *pos, *tmp;
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXSC_CFG, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RPW, 0);
+	nxp_c45_set_sci(phydev, MACSEC_RXSC_SCI_1H, 0);
+
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list) {
+		if (pos->type == RX_SA) {
+			nxp_c45_rx_sa_update(phydev, pos, false);
+			nxp_c45_sa_free(pos);
+		}
+	}
+}
+
+static void nxp_c45_macsec_en(struct phy_device *phydev, bool en)
+{
+	u32 reg;
+
+	nxp_c45_macsec_read(phydev, MACSEC_CFG, &reg);
+	if (en)
+		reg |= MACSEC_CFG_BYPASS;
+	else
+		reg &= ~MACSEC_CFG_BYPASS;
+	nxp_c45_macsec_write(phydev, MACSEC_CFG, reg);
+}
+
+static int nxp_c45_mdo_dev_open(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	int any_bit_set;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_tx_sc_en_flt(phydev, phy_secy->secy_id, true);
+	nxp_c45_set_rx_sc0_impl(phydev, phy_secy->rx_sc0_impl);
+	if (phy_secy->rx_sc)
+		nxp_c45_rx_sc_en(phydev, phy_secy->rx_sc, true);
+
+	any_bit_set = find_first_bit(priv->macsec->secy_bitmap, TX_SC_MAX);
+	if (any_bit_set == TX_SC_MAX)
+		nxp_c45_macsec_en(phydev, true);
+
+	set_bit(phy_secy->secy_id, priv->macsec->secy_bitmap);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_dev_stop(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	int any_bit_set;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_tx_sc_en_flt(phydev, phy_secy->secy_id, false);
+	if (phy_secy->rx_sc)
+		nxp_c45_rx_sc_en(phydev, phy_secy->rx_sc, false);
+	nxp_c45_set_rx_sc0_impl(phydev, false);
+
+	clear_bit(phy_secy->secy_id, priv->macsec->secy_bitmap);
+	any_bit_set = find_first_bit(priv->macsec->secy_bitmap, TX_SC_MAX);
+	if (any_bit_set == TX_SC_MAX)
+		nxp_c45_macsec_en(phydev, false);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_add_secy(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	bool can_rx_sc0_impl;
+	int idx;
+
+	phydev_dbg(phydev, "add SecY SCI %016llx\n",
+		   sci_to_cpu(ctx->secy->sci));
+
+	if (!nxp_c45_mac_addr_free(ctx))
+		return -EBUSY;
+
+	if (nxp_c45_is_rx_sc0_impl(&priv->macsec->secy_list))
+		return -EBUSY;
+
+	idx = find_first_zero_bit(priv->macsec->tx_sc_bitmap, TX_SC_MAX);
+	if (idx == TX_SC_MAX)
+		return -ENOSPC;
+
+	phy_secy = kzalloc(sizeof(*phy_secy), GFP_KERNEL);
+	if (!phy_secy)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&phy_secy->sa_list);
+	phy_secy->secy = ctx->secy;
+	phy_secy->secy_id = idx;
+
+	/* If the point to point mode should be enabled, we should have no
+	 * SecY added yet.
+	 */
+	can_rx_sc0_impl = list_count_nodes(&priv->macsec->secy_list) == 0;
+	if (!nxp_c45_secy_valid(phy_secy, can_rx_sc0_impl)) {
+		kfree(phy_secy);
+		return -EINVAL;
+	}
+
+	phy_secy->rx_sc0_impl = nxp_c45_rx_sc0_impl(phy_secy);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_set_sci(phydev, MACSEC_TXSC_SCI_1H, ctx->secy->sci);
+	nxp_c45_tx_sc_set_flt(phydev, phy_secy);
+	nxp_c45_tx_sc_update(phydev, phy_secy);
+	if (phy_interrupt_is_valid(phydev))
+		nxp_c45_secy_irq_en(phydev, phy_secy, true);
+
+	set_bit(idx, priv->macsec->tx_sc_bitmap);
+	list_add_tail(&phy_secy->list, &priv->macsec->secy_list);
+
+	return 0;
+}
+
+static void nxp_c45_tx_sa_next(struct nxp_c45_secy *phy_secy,
+			       struct nxp_c45_sa *next_sa, u8 encoding_sa)
+{
+	struct nxp_c45_sa *sa;
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, TX_SA, encoding_sa);
+	if (!IS_ERR(sa)) {
+		memcpy(next_sa, sa, sizeof(*sa));
+	} else {
+		next_sa->is_key_a = true;
+		next_sa->an = encoding_sa;
+	}
+}
+
+static int nxp_c45_mdo_upd_secy(struct macsec_context *ctx)
+{
+	u8 encoding_sa = ctx->secy->tx_sc.encoding_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_sa next_sa;
+	bool can_rx_sc0_impl;
+
+	phydev_dbg(phydev, "update SecY SCI %016llx\n",
+		   sci_to_cpu(ctx->secy->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	if (!nxp_c45_mac_addr_free(ctx))
+		return -EBUSY;
+
+	/* If the point to point mode should be enabled, we should have only
+	 * one SecY added, respectively the updated one.
+	 */
+	can_rx_sc0_impl = list_count_nodes(&priv->macsec->secy_list) == 1;
+	if (!nxp_c45_secy_valid(phy_secy, can_rx_sc0_impl))
+		return -EINVAL;
+	phy_secy->rx_sc0_impl = nxp_c45_rx_sc0_impl(phy_secy);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_tx_sc_set_flt(phydev, phy_secy);
+	nxp_c45_tx_sc_update(phydev, phy_secy);
+	nxp_c45_tx_sa_next(phy_secy, &next_sa, encoding_sa);
+	nxp_c45_tx_sa_update(phydev, &next_sa, ctx->secy->operational);
+
+	nxp_c45_set_rx_sc0_impl(phydev, phy_secy->rx_sc0_impl);
+	if (phy_secy->rx_sc)
+		nxp_c45_rx_sc_update(phydev, phy_secy);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
+{
+	u8 encoding_sa = ctx->secy->tx_sc.encoding_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_sa next_sa;
+
+	phydev_dbg(phydev, "delete SecY SCI %016llx\n",
+		   sci_to_cpu(ctx->secy->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_mdo_dev_stop(ctx);
+	nxp_c45_tx_sa_next(phy_secy, &next_sa, encoding_sa);
+	nxp_c45_tx_sa_update(phydev, &next_sa, false);
+	if (phy_secy->rx_sc)
+		nxp_c45_rx_sc_del(phydev, phy_secy);
+
+	nxp_c45_sa_list_free(&phy_secy->sa_list);
+	if (phy_interrupt_is_valid(phydev))
+		nxp_c45_secy_irq_en(phydev, phy_secy, false);
+
+	clear_bit(phy_secy->secy_id, priv->macsec->tx_sc_bitmap);
+	nxp_c45_secy_free(phy_secy);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_add_rxsc(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+
+	phydev_dbg(phydev, "add RX SC SCI %016llx %s\n",
+		   sci_to_cpu(ctx->rx_sc->sci),
+		   ctx->rx_sc->active ? "enabled" : "disabled");
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	if (phy_secy->rx_sc)
+		return -ENOSPC;
+
+	if (phy_secy->secy->tx_sc.end_station &&
+	    !nxp_c45_port_is_1(ctx->rx_sc->sci))
+		return -EINVAL;
+
+	phy_secy->rx_sc = ctx->rx_sc;
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_set_sci(phydev, MACSEC_RXSC_SCI_1H, ctx->rx_sc->sci);
+	nxp_c45_rx_sc_update(phydev, phy_secy);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_upd_rxsc(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+
+	phydev_dbg(phydev, "update RX SC SCI %016llx %s\n",
+		   sci_to_cpu(ctx->rx_sc->sci),
+		   ctx->rx_sc->active ? "enabled" : "disabled");
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_rx_sc_update(phydev, phy_secy);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_del_rxsc(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+
+	phydev_dbg(phydev, "delete RX SC SCI %016llx %s\n",
+		   sci_to_cpu(ctx->rx_sc->sci),
+		   ctx->rx_sc->active ? "enabled" : "disabled");
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_rx_sc_del(phydev, phy_secy);
+	phy_secy->rx_sc = NULL;
+
+	return 0;
+}
+
+static int nxp_c45_mdo_add_rxsa(struct macsec_context *ctx)
+{
+	struct macsec_rx_sa *rx_sa = ctx->sa.rx_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phydev_dbg(phydev, "add RX SA %u %s to RX SC SCI %016llx\n",
+		   an, rx_sa->active ? "enabled" : "disabled",
+		   sci_to_cpu(rx_sa->sc->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_sa_alloc(&phy_secy->sa_list, rx_sa, RX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_sa_set_pn(phydev, sa, rx_sa->next_pn,
+			  ctx->secy->replay_window);
+	nxp_c45_sa_set_key(ctx, sa->regs, rx_sa->key.salt.bytes, rx_sa->ssci);
+	nxp_c45_rx_sa_update(phydev, sa, rx_sa->active);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_upd_rxsa(struct macsec_context *ctx)
+{
+	struct macsec_rx_sa *rx_sa = ctx->sa.rx_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phydev_dbg(phydev, "update RX SA %u %s to RX SC SCI %016llx\n",
+		   an, rx_sa->active ? "enabled" : "disabled",
+		   sci_to_cpu(rx_sa->sc->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, RX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	if (ctx->sa.update_pn)
+		nxp_c45_sa_set_pn(phydev, sa, rx_sa->next_pn,
+				  ctx->secy->replay_window);
+	nxp_c45_rx_sa_update(phydev, sa, rx_sa->active);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_del_rxsa(struct macsec_context *ctx)
+{
+	struct macsec_rx_sa *rx_sa = ctx->sa.rx_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phydev_dbg(phydev, "delete RX SA %u %s to RX SC SCI %016llx\n",
+		   an, rx_sa->active ? "enabled" : "disabled",
+		   sci_to_cpu(rx_sa->sc->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, RX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_rx_sa_update(phydev, sa, false);
+
+	nxp_c45_sa_free(sa);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_add_txsa(struct macsec_context *ctx)
+{
+	struct macsec_tx_sa *tx_sa = ctx->sa.tx_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phydev_dbg(phydev, "add TX SA %u %s to TX SC %016llx\n",
+		   an, ctx->sa.tx_sa->active ? "enabled" : "disabled",
+		   sci_to_cpu(ctx->secy->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_sa_alloc(&phy_secy->sa_list, tx_sa, TX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_sa_set_pn(phydev, sa, tx_sa->next_pn, 0);
+	nxp_c45_sa_set_key(ctx, sa->regs, tx_sa->key.salt.bytes, tx_sa->ssci);
+	if (ctx->secy->tx_sc.encoding_sa == sa->an)
+		nxp_c45_tx_sa_update(phydev, sa, tx_sa->active);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_upd_txsa(struct macsec_context *ctx)
+{
+	struct macsec_tx_sa *tx_sa = ctx->sa.tx_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phydev_dbg(phydev, "update TX SA %u %s to TX SC %016llx\n",
+		   an, ctx->sa.tx_sa->active ? "enabled" : "disabled",
+		   sci_to_cpu(ctx->secy->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, TX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	if (ctx->sa.update_pn)
+		nxp_c45_sa_set_pn(phydev, sa, tx_sa->next_pn, 0);
+	if (ctx->secy->tx_sc.encoding_sa == sa->an)
+		nxp_c45_tx_sa_update(phydev, sa, tx_sa->active);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_del_txsa(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phydev_dbg(phydev, "delete TX SA %u %s to TX SC %016llx\n",
+		   an, ctx->sa.tx_sa->active ? "enabled" : "disabled",
+		   sci_to_cpu(ctx->secy->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, TX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	if (ctx->secy->tx_sc.encoding_sa == sa->an)
+		nxp_c45_tx_sa_update(phydev, sa, false);
+
+	nxp_c45_sa_free(sa);
+
+	return 0;
+}
+
+static const struct macsec_ops nxp_c45_macsec_ops = {
+	.mdo_dev_open = nxp_c45_mdo_dev_open,
+	.mdo_dev_stop = nxp_c45_mdo_dev_stop,
+	.mdo_add_secy = nxp_c45_mdo_add_secy,
+	.mdo_upd_secy = nxp_c45_mdo_upd_secy,
+	.mdo_del_secy = nxp_c45_mdo_del_secy,
+	.mdo_add_rxsc = nxp_c45_mdo_add_rxsc,
+	.mdo_upd_rxsc = nxp_c45_mdo_upd_rxsc,
+	.mdo_del_rxsc = nxp_c45_mdo_del_rxsc,
+	.mdo_add_rxsa = nxp_c45_mdo_add_rxsa,
+	.mdo_upd_rxsa = nxp_c45_mdo_upd_rxsa,
+	.mdo_del_rxsa = nxp_c45_mdo_del_rxsa,
+	.mdo_add_txsa = nxp_c45_mdo_add_txsa,
+	.mdo_upd_txsa = nxp_c45_mdo_upd_txsa,
+	.mdo_del_txsa = nxp_c45_mdo_del_txsa,
+};
+
+int nxp_c45_macsec_config_init(struct phy_device *phydev)
+{
+	struct nxp_c45_phy *priv = phydev->priv;
+	int ret;
+
+	if (!priv->macsec)
+		return 0;
+
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PORT_FUNC_ENABLES,
+			       MACSEC_EN | ADAPTER_EN);
+	if (ret)
+		return ret;
+
+	ret = nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_CONFIG_EN |
+				   ADPTR_CNTRL_ADPTR_EN);
+	if (ret)
+		return ret;
+
+	ret = nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_ADPTR_EN);
+	if (ret)
+		return ret;
+
+	ret = nxp_c45_macsec_write(phydev, MACSEC_TPNET, PN_WRAP_THRESHOLD);
+	if (ret)
+		return ret;
+
+	/* Set MKA filter. */
+	ret = nxp_c45_macsec_write(phydev, MACSEC_UPFR0D2, ETH_P_PAE);
+	if (ret)
+		return ret;
+
+	ret = nxp_c45_macsec_write(phydev, MACSEC_UPFR0M1, MACSEC_OVP);
+	if (ret)
+		return ret;
+
+	ret = nxp_c45_macsec_write(phydev, MACSEC_UPFR0M2, ETYPE_MASK);
+	if (ret)
+		return ret;
+
+	ret = nxp_c45_macsec_write(phydev, MACSEC_UPFR0R, MACSEC_UPFR_EN);
+
+	return ret;
+}
+
+int nxp_c45_macsec_probe(struct phy_device *phydev)
+{
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+
+	priv->macsec = devm_kzalloc(dev, sizeof(*priv->macsec), GFP_KERNEL);
+	if (!priv->macsec)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&priv->macsec->secy_list);
+	phydev->macsec_ops = &nxp_c45_macsec_ops;
+
+	return 0;
+}
+
+void nxp_c45_macsec_remove(struct phy_device *phydev)
+{
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *secy_p, *secy_t;
+	struct nxp_c45_sa *sa_p, *sa_t;
+	struct list_head *secy_list;
+
+	if (!priv->macsec)
+		return;
+
+	secy_list = &priv->macsec->secy_list;
+	nxp_c45_macsec_en(phydev, false);
+
+	list_for_each_entry_safe(secy_p, secy_t, secy_list, list) {
+		list_for_each_entry_safe(sa_p, sa_t, &secy_p->sa_list, list)
+			nxp_c45_sa_free(sa_p);
+		nxp_c45_secy_free(secy_p);
+	}
+}
+
+void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
+				     irqreturn_t *ret)
+{
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *secy;
+	struct nxp_c45_sa *sa;
+	u8 encoding_sa;
+	int secy_id;
+	u32 reg = 0;
+
+	if (!priv->macsec)
+		return;
+
+	do {
+		nxp_c45_macsec_read(phydev, MACSEC_EVR, &reg);
+		if (!reg)
+			return;
+
+		secy_id = MACSEC_REG_SIZE - ffs(reg);
+		secy = nxp_c45_find_secy_by_id(&priv->macsec->secy_list,
+					       secy_id);
+		if (IS_ERR(secy)) {
+			WARN_ON(1);
+			goto macsec_ack_irq;
+		}
+
+		encoding_sa = secy->secy->tx_sc.encoding_sa;
+		phydev_dbg(phydev, "pn_wrapped: TX SC %d, encoding_sa %u\n",
+			   secy->secy_id, encoding_sa);
+
+		sa = nxp_c45_find_sa(&secy->sa_list, TX_SA, encoding_sa);
+		if (!IS_ERR(sa))
+			macsec_pn_wrapped(secy->secy, sa->sa);
+		else
+			WARN_ON(1);
+
+macsec_ack_irq:
+		nxp_c45_macsec_write(phydev, MACSEC_EVR,
+				     TX_SC_BIT(secy_id));
+		*ret = IRQ_HANDLED;
+	} while (reg);
+}
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 780ad353cf55..3cf614b4cd52 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* NXP C45 PHY driver
- * Copyright (C) 2021 NXP
+ * Copyright 2021-2023 NXP
  * Author: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
  */
 
@@ -14,9 +14,10 @@
 #include <linux/processor.h>
 #include <linux/property.h>
 #include <linux/ptp_classify.h>
-#include <linux/ptp_clock_kernel.h>
 #include <linux/net_tstamp.h>
 
+#include "nxp-c45-tja11xx.h"
+
 #define PHY_ID_TJA_1103			0x001BB010
 #define PHY_ID_TJA_1120			0x001BB031
 
@@ -75,9 +76,11 @@
 #define PORT_CONTROL_EN			BIT(14)
 
 #define VEND1_PORT_ABILITIES		0x8046
+#define MACSEC_ABILITY			BIT(5)
 #define PTP_ABILITY			BIT(3)
 
 #define VEND1_PORT_FUNC_IRQ_EN		0x807A
+#define MACSEC_IRQS			BIT(5)
 #define PTP_IRQS			BIT(3)
 
 #define VEND1_PTP_IRQ_ACK		0x9008
@@ -148,7 +151,6 @@
 
 #define TS_SEC_MASK			GENMASK(1, 0)
 
-#define VEND1_PORT_FUNC_ENABLES		0x8048
 #define PTP_ENABLE			BIT(3)
 #define PHY_TEST_ENABLE			BIT(0)
 
@@ -281,25 +283,6 @@ struct nxp_c45_phy_data {
 			    irqreturn_t *irq_status);
 };
 
-struct nxp_c45_phy {
-	const struct nxp_c45_phy_data *phy_data;
-	struct phy_device *phydev;
-	struct mii_timestamper mii_ts;
-	struct ptp_clock *ptp_clock;
-	struct ptp_clock_info caps;
-	struct sk_buff_head tx_queue;
-	struct sk_buff_head rx_queue;
-	/* used to access the PTP registers atomic */
-	struct mutex ptp_lock;
-	int hwts_tx;
-	int hwts_rx;
-	u32 tx_delay;
-	u32 rx_delay;
-	struct timespec64 extts_ts;
-	int extts_index;
-	bool extts;
-};
-
 static const
 struct nxp_c45_phy_data *nxp_c45_get_data(struct phy_device *phydev)
 {
@@ -1215,12 +1198,25 @@ static int nxp_c45_start_op(struct phy_device *phydev)
 
 static int nxp_c45_config_intr(struct phy_device *phydev)
 {
-	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
+	int ret;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				       VEND1_PORT_FUNC_IRQ_EN, MACSEC_IRQS);
+		if (ret)
+			return ret;
+
 		return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
 					VEND1_PHY_IRQ_EN, PHY_IRQ_LINK_EVENT);
-	else
-		return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
-					  VEND1_PHY_IRQ_EN, PHY_IRQ_LINK_EVENT);
+	}
+
+	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 VEND1_PORT_FUNC_IRQ_EN, MACSEC_IRQS);
+	if (ret)
+		return ret;
+
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				  VEND1_PHY_IRQ_EN, PHY_IRQ_LINK_EVENT);
 }
 
 static int tja1103_config_intr(struct phy_device *phydev)
@@ -1286,6 +1282,7 @@ static irqreturn_t nxp_c45_handle_interrupt(struct phy_device *phydev)
 	}
 
 	data->nmi_handler(phydev, &ret);
+	nxp_c45_handle_macsec_interrupt(phydev, &ret);
 
 	return ret;
 }
@@ -1611,6 +1608,9 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 
 	nxp_c45_counters_enable(phydev);
 	nxp_c45_ptp_init(phydev);
+	ret = nxp_c45_macsec_config_init(phydev);
+	if (ret)
+		return ret;
 
 	return nxp_c45_start_op(phydev);
 }
@@ -1626,7 +1626,9 @@ static int nxp_c45_get_features(struct phy_device *phydev)
 static int nxp_c45_probe(struct phy_device *phydev)
 {
 	struct nxp_c45_phy *priv;
-	int ptp_ability;
+	bool macsec_ability;
+	int phy_abilities;
+	bool ptp_ability;
 	int ret = 0;
 
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
@@ -1642,9 +1644,9 @@ static int nxp_c45_probe(struct phy_device *phydev)
 
 	mutex_init(&priv->ptp_lock);
 
-	ptp_ability = phy_read_mmd(phydev, MDIO_MMD_VEND1,
-				   VEND1_PORT_ABILITIES);
-	ptp_ability = !!(ptp_ability & PTP_ABILITY);
+	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				     VEND1_PORT_ABILITIES);
+	ptp_ability = !!(phy_abilities & PTP_ABILITY);
 	if (!ptp_ability) {
 		phydev_dbg(phydev, "the phy does not support PTP");
 		goto no_ptp_support;
@@ -1663,6 +1665,20 @@ static int nxp_c45_probe(struct phy_device *phydev)
 	}
 
 no_ptp_support:
+	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+	if (!macsec_ability) {
+		phydev_info(phydev, "the phy does not support MACsec\n");
+		goto no_macsec_support;
+	}
+
+	if (IS_ENABLED(CONFIG_MACSEC)) {
+		ret = nxp_c45_macsec_probe(phydev);
+		phydev_dbg(phydev, "MACsec support enabled.");
+	} else {
+		phydev_dbg(phydev, "MACsec support not enabled even if the phy supports it");
+	}
+
+no_macsec_support:
 
 	return ret;
 }
@@ -1676,6 +1692,7 @@ static void nxp_c45_remove(struct phy_device *phydev)
 
 	skb_queue_purge(&priv->tx_queue);
 	skb_queue_purge(&priv->rx_queue);
+	nxp_c45_macsec_remove(phydev);
 }
 
 static void tja1103_counters_enable(struct phy_device *phydev)
diff --git a/drivers/net/phy/nxp-c45-tja11xx.h b/drivers/net/phy/nxp-c45-tja11xx.h
new file mode 100644
index 000000000000..f364fca68f0b
--- /dev/null
+++ b/drivers/net/phy/nxp-c45-tja11xx.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* NXP C45 PHY driver header file
+ * Copyright 2023 NXP
+ * Author: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
+ */
+
+#include <linux/ptp_clock_kernel.h>
+
+#define VEND1_PORT_FUNC_ENABLES		0x8048
+
+struct nxp_c45_macsec;
+
+struct nxp_c45_phy {
+	const struct nxp_c45_phy_data *phy_data;
+	struct phy_device *phydev;
+	struct mii_timestamper mii_ts;
+	struct ptp_clock *ptp_clock;
+	struct ptp_clock_info caps;
+	struct sk_buff_head tx_queue;
+	struct sk_buff_head rx_queue;
+	/* used to access the PTP registers atomic */
+	struct mutex ptp_lock;
+	int hwts_tx;
+	int hwts_rx;
+	u32 tx_delay;
+	u32 rx_delay;
+	struct timespec64 extts_ts;
+	int extts_index;
+	bool extts;
+	struct nxp_c45_macsec *macsec;
+};
+
+#if IS_ENABLED(CONFIG_MACSEC)
+int nxp_c45_macsec_config_init(struct phy_device *phydev);
+int nxp_c45_macsec_probe(struct phy_device *phydev);
+void nxp_c45_macsec_remove(struct phy_device *phydev);
+void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
+				     irqreturn_t *ret);
+#else
+static inline
+int nxp_c45_macsec_config_init(struct phy_device *phydev)
+{
+	return 0;
+}
+
+static inline
+int nxp_c45_macsec_probe(struct phy_device *phydev)
+{
+	return 0;
+}
+
+static inline
+void nxp_c45_macsec_remove(struct phy_device *phydev)
+{
+}
+
+static inline
+void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
+				     irqreturn_t *ret)
+{
+}
+#endif
-- 
2.34.1


