Return-Path: <linux-kernel+bounces-157937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18008B18EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4281F24FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECB1199BC;
	Thu, 25 Apr 2024 02:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ej8vMMWy"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A240217C77;
	Thu, 25 Apr 2024 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714012438; cv=none; b=uifOendzVELkSCFq/3ej5ux/0SSt2/BYgw/hluPEApQvKXD13LfByFTTW/0Bqv1WULRxTW4X/W3fil/ObvKqoZsb8vra9xbfjA/YMvYFlmkhFBTqzv0GKgcBzNzMb+d3l1f1Hw04e95yul+XJyArJJSrEHlN68FLUjG0nyuVuZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714012438; c=relaxed/simple;
	bh=u+9cJGeqKXaq4eZ9WTjevNkTiagqjt5j72Lindr5c8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmZ4024A3CUuD2CAPhSm3VlVIIVvyNihs8C8Mqe+fWTLWsiIdA+oNrfIXeHnYMaZUEwli8ME+f3HafgdODIwJSOjEr6tmw2MmV7U+LXQckz6mF92133r41YBrhDzcEyGkxurFzE45EawBsnZOgBs24WFneSVu1mpWpP7x2f2y4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ej8vMMWy; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 40a7de1c02ac11efb8927bc1f75efef4-20240425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Xpk8TStm+BIaAYKCVa48yk98BAjt0afumgy4Jzvyv7s=;
	b=Ej8vMMWy2gtRAKkQvk2ipo2aJ9gS1Jl2t5a/h4tzI9xUlLMXq/mARdPH7HR9CZQacJ0wdxyvpivqx9z31T2DFou7KXihsHnhJ3hJaFn+4ulOJTLf5QU/ZvXc/4nxokjAt7v5/WT6j9uLNnkrwUNGxvQ8cv9imTuoGwRl8B97zi8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:102beddc-543c-476b-a467-1e6484640da0,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:82c5f88,CLOUDID:9c4a1583-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 40a7de1c02ac11efb8927bc1f75efef4-20240425
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 923521739; Thu, 25 Apr 2024 10:33:51 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 Apr 2024 10:33:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 Apr 2024 10:33:49 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Golle
	<daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, SkyLake Huang
	<SkyLake.Huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, SkyLake.Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH 1/3] net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
Date: Thu, 25 Apr 2024 10:33:23 +0800
Message-ID: <20240425023325.15586-2-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
References: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.544200-8.000000
X-TMASE-MatchedRID: ptJ0KTv/UXCfF/fARRyav23NvezwBrVmK2i9pofGVSvNQVzhfYY5snLM
	RSx26gTiX3E2fHKxS5INbmAgKiEzxBLmJd2F/yFu7spMO3HwKCDVy4hHC3/gyF7zF1i7scLKSAK
	UIhfaB7Aii9Z7QbHpoFHPi8Y3eGK1/Guz40Ud3KS3D7EeeyZCM30tCKdnhB589yM15V5aWpj6C0
	ePs7A07SAJgyd9wrc8GBv6238f5M0QmfyTzgfrmpQ6BnyNbPBfXJ5YkyXIpv/50fenSUXXlQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.544200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3138F1F7FA7E585F5281664CAFD4859A4F786D6963A62751864A369443BBD8A42000:8
X-MTK: N

From: "SkyLake.Huang" <skylake.huang@mediatek.com>

Re-organize MediaTek ethernet phy driver files and get ready to integrate
some common functions and add new 2.5G phy driver.
mtk-ge.c: MT7530 Gphy on MT7621 & MT7531 Gphy
mtk-ge-soc.c: Built-in Gphy on MT7981 & Built-in switch Gphy on MT7988
mtk-2p5ge.c: Planned for built-in 2.5G phy on MT7988

Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
---
 MAINTAINERS                                     |  4 ++--
 drivers/net/phy/Kconfig                         | 17 +----------------
 drivers/net/phy/Makefile                        |  3 +--
 drivers/net/phy/mediatek/Kconfig                | 17 +++++++++++++++++
 drivers/net/phy/mediatek/Makefile               |  3 +++
 .../mtk-ge-soc.c}                               |  0
 .../phy/{mediatek-ge.c => mediatek/mtk-ge.c}    |  0
 7 files changed, 24 insertions(+), 20 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/Kconfig
 create mode 100644 drivers/net/phy/mediatek/Makefile
 rename drivers/net/phy/{mediatek-ge-soc.c => mediatek/mtk-ge-soc.c} (100%)
 rename drivers/net/phy/{mediatek-ge.c => mediatek/mtk-ge.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7ff3c758535..b59edadfb8fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13908,8 +13908,8 @@ M:	Qingfang Deng <dqfext@gmail.com>
 M:	SkyLake Huang <SkyLake.Huang@mediatek.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/net/phy/mediatek-ge-soc.c
-F:	drivers/net/phy/mediatek-ge.c
+F:	drivers/net/phy/mediatek/mtk-ge-soc.c
+F:	drivers/net/phy/mediatek/mtk-ge.c
 F:	drivers/phy/mediatek/phy-mtk-xfi-tphy.c
 
 MEDIATEK I2C CONTROLLER DRIVER
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 7fddc8306d82..c5ff747bb277 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -256,22 +256,7 @@ config MAXLINEAR_GPHY
 	  Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
 	  GPY241, GPY245 PHYs.
 
-config MEDIATEK_GE_PHY
-	tristate "MediaTek Gigabit Ethernet PHYs"
-	help
-	  Supports the MediaTek Gigabit Ethernet PHYs.
-
-config MEDIATEK_GE_SOC_PHY
-	tristate "MediaTek SoC Ethernet PHYs"
-	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
-	depends on NVMEM_MTK_EFUSE
-	help
-	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
-
-	  Include support for built-in Ethernet PHYs which are present in
-	  the MT7981 and MT7988 SoCs. These PHYs need calibration data
-	  present in the SoCs efuse and will dynamically calibrate VCM
-	  (common-mode voltage) during startup.
+source "drivers/net/phy/mediatek/Kconfig"
 
 config MICREL_PHY
 	tristate "Micrel PHYs"
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 1d8be374915f..c0eb595ca773 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -72,8 +72,7 @@ obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
 obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
 obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
 obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
-obj-$(CONFIG_MEDIATEK_GE_PHY)	+= mediatek-ge.o
-obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mediatek-ge-soc.o
+obj-y				+= mediatek/
 obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
 obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
 obj-$(CONFIG_MICREL_PHY)	+= micrel.o
diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
new file mode 100644
index 000000000000..5f97e27af600
--- /dev/null
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config MEDIATEK_GE_PHY
+	tristate "MediaTek Gigabit Ethernet PHYs"
+	help
+	  Supports the MediaTek Gigabit Ethernet PHYs.
+
+config MEDIATEK_GE_SOC_PHY
+	bool "MediaTek SoC Ethernet PHYs"
+	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
+	select NVMEM_MTK_EFUSE
+	help
+	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
+
+	  Include support for built-in Ethernet PHYs which are present in
+	  the MT7981 and MT7988 SoCs. These PHYs need calibration data
+	  present in the SoCs efuse and will dynamically calibrate VCM
+	  (common-mode voltage) during startup.
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/Makefile
new file mode 100644
index 000000000000..005bde26c1d7
--- /dev/null
+++ b/drivers/net/phy/mediatek/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
+obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
diff --git a/drivers/net/phy/mediatek-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
similarity index 100%
rename from drivers/net/phy/mediatek-ge-soc.c
rename to drivers/net/phy/mediatek/mtk-ge-soc.c
diff --git a/drivers/net/phy/mediatek-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
similarity index 100%
rename from drivers/net/phy/mediatek-ge.c
rename to drivers/net/phy/mediatek/mtk-ge.c
-- 
2.18.0


