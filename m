Return-Path: <linux-kernel+bounces-155886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827348AF886
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60EF1C24168
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F17148841;
	Tue, 23 Apr 2024 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGn88T2i"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB391487C1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905439; cv=none; b=kkLEUXWGlRNhlroJVZW1uFR2uxi2skrq/1yPhFYjRRqy15xuSgDFaThfDZnuemqhINaDqd5pGZLat4rsKvS5clVX7/RsJMEqY54pVbefsanHoTOoCiSjHBbpCT4SttUOZ0xL5sokXlIBdiq/2nUXnNQkndnTqzJ0wLKu6sc4UY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905439; c=relaxed/simple;
	bh=k3FP8n950VFNgwhupopw0Tk1YOkwNpwES55fzU6HHhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjrXMTYZFJfE86kKaxF2j9aP4wEGW0zCet48PWPW/TRhIqQipIhGdCJDzigAo2ApvaD/J2ikcYCkCh3r6BvraubP8Tj3HXXfCi0Bqx6srAkq0L2GX8xlgU75M1pvBylomWcDlaODMBDhhEuHWxqJCVqVjFiCDuC7FRCjhJs53ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WGn88T2i; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a5b68ed0aso18656815e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713905436; x=1714510236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YA/3tT3fr7pWJ8UM5dniRKuE+JDGAM81Xu5sX8YLlYU=;
        b=WGn88T2i1r2X8nemnp7PA0/Ix23hcxyZ99u2xFQndg6SeQxxOB9T8zTBSUHzMtl+gU
         xgTnzHoY2cGx0s0WgkWu+XD1wrzjgIQmp4R/YSU8L51DWmkrCUmKbsGFssOQkEcCwnQy
         95w2/K4DVUb8VyaG9WHQR+E1CRq55aoYRXGkLjks/rH3JwCPUk2dcOYCiyOQGHDdUpH7
         oZzbil747Xs4rWCNR8eCCqxXy3QSL2bzFNa0FVZ8/LaIcEaTtz/48lcPhXiyvQsJu4ya
         bvD1D9p6kauxfIFXBtLiThe3T+T6UZZatYLaSuykrwjj9kqU8YPUw8WHpLqRY1GKmHg1
         xSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713905436; x=1714510236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YA/3tT3fr7pWJ8UM5dniRKuE+JDGAM81Xu5sX8YLlYU=;
        b=N0v6FrphV/sayU9Z9BbLwInfaXBHvFivlpfims2a3zHh3j10tcRhjwAM1qpc5GbV1Y
         g+9pAkay1zpR/ReL8bt0SMyrxjQcKvzOB0D4WuBdJRncAnfJCHdaMUI4UXh/aoddLRz1
         QvN2OsaRFycILF1w2t1IF8dQLWFCffc7Fz0oojrZzs+fSvKqhbnMum1Pd2wec5MUjYko
         rRgWmB4vm3thX/JuET2DVUhYlCRxzHt9K7uKKSs692EKQ1KplTNEXaNlYRwqNf7EooK1
         aOUPkWimOMRI8qRGsM5/SGYTSiyj+xv34EBDKyw0tNSP4k72SvJNQl3fZrRn0y/t/5D6
         X48A==
X-Forwarded-Encrypted: i=1; AJvYcCVfRKx44PQWjM7NicDwvvlhbmNoIdKb0U2H2aPi/93iTHFRRBLrocaAWE4oaALyNUaOAUYyaNXZhc3gOXGkrT8fxy/EStKNutG/Zr99
X-Gm-Message-State: AOJu0YwUXzNFWWJF0zbfP5FyowPt66dBsTaVaP9GdVHIhSxitLp5ZpYt
	1K8i5KV0+j1OnmsZ+Z+TgrR+6+bKgpas0sLAS0eLLzXW0RvMCEK8SoY1M17mf24=
X-Google-Smtp-Source: AGHT+IE3j5UJkjv75kYjHfbyWnSKhU/M0Mggu5WGBtj0OCON0029UeKJ/+zOv8tdADgwTVZGTLUlrA==
X-Received: by 2002:a05:600c:3d8b:b0:418:e964:4684 with SMTP id bi11-20020a05600c3d8b00b00418e9644684mr322036wmb.1.1713905436525;
        Tue, 23 Apr 2024 13:50:36 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:4269:2542:5a09:9ca1])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b00419f419236fsm13065443wmb.41.2024.04.23.13.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:50:35 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com,
	ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 12/14] scsi: ufs: host: ufs-exynos: Add support for Tensor gs101 SoC
Date: Tue, 23 Apr 2024 21:50:04 +0100
Message-ID: <20240423205006.1785138-13-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240423205006.1785138-1-peter.griffin@linaro.org>
References: <20240423205006.1785138-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a dedicated compatible and drv_data with associated
hooks for gs101 SoC found on Pixel 6.

Note we make use of the previously added EXYNOS_UFS_OPT_UFSPR_SECURE
option, to skip initialisation of UFSPR registers as these are only
accessible via SMC call.

EXYNOS_UFS_OPT_TIMER_TICK_SELECT option is also set to select tick
source. This has been done so as not to effect any existing platforms.

DBG_OPTION_SUITE on gs101 has different address offsets to other SoCs
so these register offsets now come from uic_attr struct.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Will McVicker <willmcvicker@google.com>
---
 drivers/ufs/host/ufs-exynos.c | 146 ++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-exynos.h |  14 ++++
 2 files changed, 160 insertions(+)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index c086630a96e8..d66dccdc82db 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -61,6 +61,7 @@
 #define CLK_STOP_MASK		(REFCLKOUT_STOP | REFCLK_STOP |\
 				 UNIPRO_MCLK_STOP | MPHY_APBCLK_STOP|\
 				 UNIPRO_PCLK_STOP)
+/* HCI_MISC is also known as HCI_FORCE_HCS */
 #define HCI_MISC		0xB4
 #define REFCLK_CTRL_EN		BIT(7)
 #define UNIPRO_PCLK_CTRL_EN	BIT(6)
@@ -138,6 +139,9 @@ enum {
 /*
  * UNIPRO registers
  */
+#define UNIPRO_DME_POWERMODE_REQ_LOCALL2TIMER0	0x7888
+#define UNIPRO_DME_POWERMODE_REQ_LOCALL2TIMER1	0x788c
+#define UNIPRO_DME_POWERMODE_REQ_LOCALL2TIMER2	0x7890
 #define UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER0	0x78B8
 #define UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER1	0x78BC
 #define UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER2	0x78C0
@@ -938,6 +942,10 @@ static void exynos_ufs_config_unipro(struct exynos_ufs *ufs)
 	if (attr->pa_dbg_opt_suite1_off)
 		ufshcd_dme_set(hba, UIC_ARG_MIB(attr->pa_dbg_opt_suite1_off),
 			       attr->pa_dbg_opt_suite1_val);
+
+	if (attr->pa_dbg_opt_suite2_off)
+		ufshcd_dme_set(hba, UIC_ARG_MIB(attr->pa_dbg_opt_suite2_off),
+			       attr->pa_dbg_opt_suite2_val);
 }
 
 static void exynos_ufs_config_intr(struct exynos_ufs *ufs, u32 errs, u8 index)
@@ -1589,6 +1597,96 @@ static int fsd_ufs_pre_pwr_change(struct exynos_ufs *ufs,
 	return 0;
 }
 
+static inline u32 get_mclk_period_unipro_18(struct exynos_ufs *ufs)
+{
+	return (16 * 1000 * 1000000UL / ufs->mclk_rate);
+}
+
+static int gs101_ufs_pre_link(struct exynos_ufs *ufs)
+{
+	struct ufs_hba *hba = ufs->hba;
+	int i;
+	u32 tx_line_reset_period, rx_line_reset_period;
+
+	rx_line_reset_period = (RX_LINE_RESET_TIME * ufs->mclk_rate)
+				/ NSEC_PER_MSEC;
+	tx_line_reset_period = (TX_LINE_RESET_TIME * ufs->mclk_rate)
+				/ NSEC_PER_MSEC;
+
+	unipro_writel(ufs, get_mclk_period_unipro_18(ufs), COMP_CLK_PERIOD);
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x40);
+
+	for_each_ufs_rx_lane(ufs, i) {
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_CLK_PRD, i),
+			       DIV_ROUND_UP(NSEC_PER_SEC, ufs->mclk_rate));
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_CLK_PRD_EN, i), 0x0);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_VALUE2, i),
+			       (rx_line_reset_period >> 16) & 0xFF);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_VALUE1, i),
+			       (rx_line_reset_period >> 8) & 0xFF);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_RX_LINERESET_VALUE0, i),
+			       (rx_line_reset_period) & 0xFF);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x2f, i), 0x69);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x84, i), 0x1);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x25, i), 0xf6);
+	}
+
+	for_each_ufs_tx_lane(ufs, i) {
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_CLK_PRD, i),
+			       DIV_ROUND_UP(NSEC_PER_SEC, ufs->mclk_rate));
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_CLK_PRD_EN, i),
+			       0x02);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_LINERESET_PVALUE2, i),
+			       (tx_line_reset_period >> 16) & 0xFF);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_LINERESET_PVALUE1, i),
+			       (tx_line_reset_period >> 8) & 0xFF);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(VND_TX_LINERESET_PVALUE0, i),
+			       (tx_line_reset_period) & 0xFF);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x04, i), 1);
+		ufshcd_dme_set(hba, UIC_ARG_MIB_SEL(0x7F, i), 0);
+	}
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0x200), 0x0);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_LOCAL_TX_LCC_ENABLE), 0x0);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(N_DEVICEID), 0x0);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(N_DEVICEID_VALID), 0x1);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(T_PEERDEVICEID), 0x1);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(T_CONNECTIONSTATE), CPORT_CONNECTED);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(0xA006), 0x8000);
+
+	return 0;
+}
+
+static int gs101_ufs_post_link(struct exynos_ufs *ufs)
+{
+	struct ufs_hba *hba = ufs->hba;
+
+	exynos_ufs_enable_dbg_mode(hba);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_SAVECONFIGTIME), 0x3e8);
+	exynos_ufs_disable_dbg_mode(hba);
+
+	return 0;
+}
+
+static int gs101_ufs_pre_pwr_change(struct exynos_ufs *ufs,
+					 struct ufs_pa_layer_attr *pwr)
+{
+	struct ufs_hba *hba = ufs->hba;
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA0), 12000);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA1), 32000);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA2), 16000);
+	unipro_writel(ufs, 8064, UNIPRO_DME_POWERMODE_REQ_LOCALL2TIMER0);
+	unipro_writel(ufs, 28224, UNIPRO_DME_POWERMODE_REQ_LOCALL2TIMER1);
+	unipro_writel(ufs, 20160, UNIPRO_DME_POWERMODE_REQ_LOCALL2TIMER2);
+	unipro_writel(ufs, 12000, UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER0);
+	unipro_writel(ufs, 32000, UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER1);
+	unipro_writel(ufs, 16000, UNIPRO_DME_POWERMODE_REQ_REMOTEL2TIMER2);
+
+	return 0;
+}
+
 static const struct ufs_hba_variant_ops ufs_hba_exynos_ops = {
 	.name				= "exynos_ufs",
 	.init				= exynos_ufs_init,
@@ -1715,6 +1813,34 @@ static const struct exynos_ufs_drv_data exynos_ufs_drvs = {
 	.post_pwr_change	= exynos7_ufs_post_pwr_change,
 };
 
+static struct exynos_ufs_uic_attr gs101_uic_attr = {
+	.tx_trailingclks		= 0xff,
+	.tx_dif_p_nsec			= 3000000,	/* unit: ns */
+	.tx_dif_n_nsec			= 1000000,	/* unit: ns */
+	.tx_high_z_cnt_nsec		= 20000,	/* unit: ns */
+	.tx_base_unit_nsec		= 100000,	/* unit: ns */
+	.tx_gran_unit_nsec		= 4000,		/* unit: ns */
+	.tx_sleep_cnt			= 1000,		/* unit: ns */
+	.tx_min_activatetime		= 0xa,
+	.rx_filler_enable		= 0x2,
+	.rx_dif_p_nsec			= 1000000,	/* unit: ns */
+	.rx_hibern8_wait_nsec		= 4000000,	/* unit: ns */
+	.rx_base_unit_nsec		= 100000,	/* unit: ns */
+	.rx_gran_unit_nsec		= 4000,		/* unit: ns */
+	.rx_sleep_cnt			= 1280,		/* unit: ns */
+	.rx_stall_cnt			= 320,		/* unit: ns */
+	.rx_hs_g1_sync_len_cap		= SYNC_LEN_COARSE(0xf),
+	.rx_hs_g2_sync_len_cap		= SYNC_LEN_COARSE(0xf),
+	.rx_hs_g3_sync_len_cap		= SYNC_LEN_COARSE(0xf),
+	.rx_hs_g1_prep_sync_len_cap	= PREP_LEN(0xf),
+	.rx_hs_g2_prep_sync_len_cap	= PREP_LEN(0xf),
+	.rx_hs_g3_prep_sync_len_cap	= PREP_LEN(0xf),
+	.pa_dbg_opt_suite1_val		= 0x90913C1C,
+	.pa_dbg_opt_suite1_off		= PA_GS101_DBG_OPTION_SUITE1,
+	.pa_dbg_opt_suite2_val		= 0xE01C115F,
+	.pa_dbg_opt_suite2_off		= PA_GS101_DBG_OPTION_SUITE2,
+};
+
 static struct exynos_ufs_uic_attr fsd_uic_attr = {
 	.tx_trailingclks		= 0x10,
 	.tx_dif_p_nsec			= 3000000,	/* unit: ns */
@@ -1758,7 +1884,27 @@ static const struct exynos_ufs_drv_data fsd_ufs_drvs = {
 	.pre_pwr_change         = fsd_ufs_pre_pwr_change,
 };
 
+static const struct exynos_ufs_drv_data gs101_ufs_drvs = {
+	.uic_attr		= &gs101_uic_attr,
+	.quirks			= UFSHCD_QUIRK_PRDT_BYTE_GRAN |
+				  UFSHCI_QUIRK_SKIP_RESET_INTR_AGGR |
+				  UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR |
+				  UFSHCD_QUIRK_BROKEN_OCS_FATAL_ERROR |
+				  UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL |
+				  UFSHCD_QUIRK_SKIP_DEF_UNIPRO_TIMEOUT_SETTING,
+	.opts			= EXYNOS_UFS_OPT_BROKEN_AUTO_CLK_CTRL |
+				  EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR |
+				  EXYNOS_UFS_OPT_UFSPR_SECURE |
+				  EXYNOS_UFS_OPT_TIMER_TICK_SELECT,
+	.drv_init		= exynosauto_ufs_drv_init,
+	.pre_link		= gs101_ufs_pre_link,
+	.post_link		= gs101_ufs_post_link,
+	.pre_pwr_change		= gs101_ufs_pre_pwr_change,
+};
+
 static const struct of_device_id exynos_ufs_of_match[] = {
+	{ .compatible = "google,gs101-ufs",
+	  .data	      = &gs101_ufs_drvs },
 	{ .compatible = "samsung,exynos7-ufs",
 	  .data	      = &exynos_ufs_drvs },
 	{ .compatible = "samsung,exynosautov9-ufs",
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index f30423223474..1646c4a9bb08 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -9,6 +9,12 @@
 #ifndef _UFS_EXYNOS_H_
 #define _UFS_EXYNOS_H_
 
+/*
+ * Component registers
+ */
+
+#define COMP_CLK_PERIOD	0x44
+
 /*
  * UNIPRO registers
  */
@@ -29,6 +35,14 @@
 #define PA_DBG_OPTION_SUITE	0x9564
 #define PA_DBG_OPTION_SUITE_DYN	0x9565
 
+/*
+ * Note: GS101_DBG_OPTION offsets below differ from the TRM
+ * but match the downstream driver. Following the TRM
+ * results in non-functioning UFS.
+ */
+#define PA_GS101_DBG_OPTION_SUITE1 0x956a
+#define PA_GS101_DBG_OPTION_SUITE2 0x956d
+
 /*
  * MIBs for Transport Layer debug registers
  */
-- 
2.44.0.769.g3c40516874-goog


