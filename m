Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07E57EF1DF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346040AbjKQLdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346075AbjKQLdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:33:16 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1C41734;
        Fri, 17 Nov 2023 03:32:46 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35937f2fadeso7004665ab.2;
        Fri, 17 Nov 2023 03:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700220765; x=1700825565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIAPgh/y6S69BHeICZoHmz8PjnaV5v66DJbfDWHZzEA=;
        b=M16ZSqdjT58MHZr9cAmgrY9ANL9nl/a+RxjK1dVdFlAr//YTtfb2uRrcRFmSb5otU1
         EpF/1OBFeW/JllgMrtwW18OVgI6uqzP9RmAHjyvkoD5dKh/JTK2dbYJjKo+MYcD6x+R2
         Fcmy395wdREOkmWLcnBvOGKaKIe+Fdp7mKyiOoP2kp//WNFcaItkXiA1wGoYCMkoW+9g
         I36mJ7S+FoPaKyhbhK89HvXRy0RMvUrU4ncKBIuzuiMbEAL5VcO1EEP5FxfDvuJ0SBzx
         DoaV5o4BqBV6wjEET5PE2Cx5QbkvF7SuQObgc/fO7hiz9rWxkJ75SJ5C9t+H1VOnUFfn
         9WwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700220765; x=1700825565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIAPgh/y6S69BHeICZoHmz8PjnaV5v66DJbfDWHZzEA=;
        b=jZ3Hf9w+EbqlauJbsQTuP2Om0IGbSH3FUQtxgGzxCBFq0LQccNyxJiJrOnYD6MIp0J
         UdGWlyqVBcfGurwF6UxmJbvtzPsGeNE/rqSgVH0X7K6NqrTPs46pGvWHfCbG8+RaY8+C
         U1mje8eUl67hBCYQkrP0DnJ6keTjVx+Bsc9dfD34OTr3mMhb3decDh0/IF0ncUyiVmO2
         R+APCHspX1B91Avf4AUkrENSWk5zcxukOPEoNu3HsG5SWJ0A9GlzijgATtmAGffbnY5N
         ME9JsRo5RJCa6xhzTYlXqQUDPAGX5N6l6v6w+kiFz1vFchBCshvUQdCkAzep0p2k9A4u
         nwyQ==
X-Gm-Message-State: AOJu0YxiZVIUA/4z+wagGAY+ISrPhqs14hne+O2lprEJ8N4GTCkzTzTq
        LKCAkaZbXhA3KQSHokHaDJ0=
X-Google-Smtp-Source: AGHT+IEJJA0Ha41uH3B1ZPSzPTaPIxxeqYeBNZCNGkLxALF8iDGohH0GOP6Us4XKAD73KUmNcnVH/g==
X-Received: by 2002:a05:6e02:1a43:b0:357:abe3:6b96 with SMTP id u3-20020a056e021a4300b00357abe36b96mr21152480ilv.4.1700220765319;
        Fri, 17 Nov 2023 03:32:45 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e286-d458-bc89-d4cd-bd42-ffb5.emome-ip6.hinet.net. [2001:b400:e286:d458:bc89:d4cd:bd42:ffb5])
        by smtp.gmail.com with ESMTPSA id u2-20020a631402000000b005b4b70738e5sm1229224pgl.8.2023.11.17.03.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 03:32:45 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V13 15/21] mmc: sdhci-uhs2: add uhs2_control() to initialise the interface
Date:   Fri, 17 Nov 2023 19:31:43 +0800
Message-Id: <20231117113149.9069-16-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117113149.9069-1-victorshihgli@gmail.com>
References: <20231117113149.9069-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

UHS-II interface (related registers) will be initialized here. The operations include mmc's
uhs2_set_reg operations, mmc's uhs2_detect_init operations, uhs2_[enable|disable]_clk operations,
uhs2_set_ios operations. After detected the UHS-II interface, the host's UHS-II capabilities will
be set up here and interrupts will also be enabled.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V13:
 - Merge Patch#15, Patch#16 and Patch#17 of v12 version into Patch#15 in v13 version.
 - Use definitions to simplify code.
 - Modify comment message.

---
 drivers/mmc/host/sdhci-uhs2.c | 228 ++++++++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index a55b910f3615..569c231af2ab 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -25,6 +25,9 @@
 	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
 
 #define UHS2_RESET_TIMEOUT_100MS		100000
+#define UHS2_CHECK_DORMANT_TIMEOUT_100MS	100000
+#define UHS2_INTERFACE_DETECT_TIMEOUT_100MS	100000
+#define UHS2_LANE_SYNC_TIMEOUT_150MS		150000
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 {
@@ -309,6 +312,229 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
+static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
+{
+	u32 val;
+
+	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IF_DETECT),
+			      100, UHS2_INTERFACE_DETECT_TIMEOUT_100MS, true,
+			      host, SDHCI_PRESENT_STATE)) {
+		pr_warn("%s: not detect UHS2 interface in 100ms.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return -EIO;
+	}
+
+	/* Enable UHS2 error interrupts */
+	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
+
+	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_LANE_SYNC),
+			      100, UHS2_LANE_SYNC_TIMEOUT_150MS, true, host, SDHCI_PRESENT_STATE)) {
+		pr_warn("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return -EIO;
+	}
+
+	DBG("%s: UHS2 Lane synchronized in UHS2 mode, PHY is initialized.\n",
+	    mmc_hostname(host->mmc));
+	return 0;
+}
+
+static int sdhci_uhs2_init(struct sdhci_host *host)
+{
+	u16 caps_ptr = 0;
+	u32 caps_gen = 0;
+	u32 caps_phy = 0;
+	u32 caps_tran[2] = {0, 0};
+	struct mmc_host *mmc = host->mmc;
+
+	caps_ptr = sdhci_readw(host, SDHCI_UHS2_CAPS_PTR);
+	if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
+		pr_err("%s: SDHCI_UHS2_CAPS_PTR(%d) is wrong.\n",
+		       mmc_hostname(mmc), caps_ptr);
+		return -ENODEV;
+	}
+	caps_gen = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_OFFSET);
+	caps_phy = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_PHY_OFFSET);
+	caps_tran[0] = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_TRAN_OFFSET);
+	caps_tran[1] = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_TRAN_1_OFFSET);
+
+	/* General Caps */
+	mmc->uhs2_caps.dap = caps_gen & SDHCI_UHS2_CAPS_DAP_MASK;
+	mmc->uhs2_caps.gap = FIELD_GET(SDHCI_UHS2_CAPS_GAP_MASK, caps_gen);
+	mmc->uhs2_caps.n_lanes = FIELD_GET(SDHCI_UHS2_CAPS_LANE_MASK, caps_gen);
+	mmc->uhs2_caps.addr64 =	(caps_gen & SDHCI_UHS2_CAPS_ADDR_64) ? 1 : 0;
+	mmc->uhs2_caps.card_type = FIELD_GET(SDHCI_UHS2_CAPS_DEV_TYPE_MASK, caps_gen);
+
+	/* PHY Caps */
+	mmc->uhs2_caps.phy_rev = caps_phy & SDHCI_UHS2_CAPS_PHY_REV_MASK;
+	mmc->uhs2_caps.speed_range = FIELD_GET(SDHCI_UHS2_CAPS_PHY_RANGE_MASK, caps_phy);
+	mmc->uhs2_caps.n_lss_sync = FIELD_GET(SDHCI_UHS2_CAPS_PHY_N_LSS_SYN_MASK, caps_phy);
+	mmc->uhs2_caps.n_lss_dir = FIELD_GET(SDHCI_UHS2_CAPS_PHY_N_LSS_DIR_MASK, caps_phy);
+	if (mmc->uhs2_caps.n_lss_sync == 0)
+		mmc->uhs2_caps.n_lss_sync = 16 << 2;
+	else
+		mmc->uhs2_caps.n_lss_sync <<= 2;
+	if (mmc->uhs2_caps.n_lss_dir == 0)
+		mmc->uhs2_caps.n_lss_dir = 16 << 3;
+	else
+		mmc->uhs2_caps.n_lss_dir <<= 3;
+
+	/* LINK/TRAN Caps */
+	mmc->uhs2_caps.link_rev = caps_tran[0] & SDHCI_UHS2_CAPS_TRAN_LINK_REV_MASK;
+	mmc->uhs2_caps.n_fcu = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_N_FCU_MASK, caps_tran[0]);
+	if (mmc->uhs2_caps.n_fcu == 0)
+		mmc->uhs2_caps.n_fcu = 256;
+	mmc->uhs2_caps.host_type = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_HOST_TYPE_MASK, caps_tran[0]);
+	mmc->uhs2_caps.maxblk_len = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_BLK_LEN_MASK, caps_tran[0]);
+	mmc->uhs2_caps.n_data_gap = caps_tran[1] & SDHCI_UHS2_CAPS_TRAN_1_N_DATA_GAP_MASK;
+
+	return 0;
+}
+
+static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	DBG("Begin do uhs2 detect init.\n");
+
+	if (sdhci_uhs2_interface_detect(host)) {
+		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
+		return -EIO;
+	}
+
+	if (sdhci_uhs2_init(host)) {
+		pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
+		return -EIO;
+	}
+
+	/* Init complete, do soft reset and enable UHS2 error irqs. */
+	sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
+	/*
+	 * N.B SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared
+	 * by SDHCI_UHS2_SW_RESET_SD
+	 */
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+
+	return 0;
+}
+
+static int sdhci_uhs2_disable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	return 0;
+}
+
+static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	int timeout_us = 20000; /* 20ms */
+	u32 val;
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	if (read_poll_timeout(sdhci_readw, val, (val & SDHCI_CLOCK_INT_STABLE),
+			      10, timeout_us, true, host, SDHCI_CLOCK_CONTROL)) {
+		pr_err("%s: Internal clock never stabilised.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return -EIO;
+	}
+	return 0;
+}
+
+static void sdhci_uhs2_set_config(struct sdhci_host *host)
+{
+	u32 value;
+	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SETTINGS_PTR);
+	u16 sdhci_uhs2_gen_set_reg	= sdhci_uhs2_set_ptr;
+	u16 sdhci_uhs2_phy_set_reg	= sdhci_uhs2_set_ptr + 4;
+	u16 sdhci_uhs2_tran_set_reg	= sdhci_uhs2_set_ptr + 8;
+	u16 sdhci_uhs2_tran_set_1_reg	= sdhci_uhs2_set_ptr + 12;
+
+	/* Set Gen Settings */
+	value = FIELD_PREP(SDHCI_UHS2_GEN_SETTINGS_N_LANES_MASK, host->mmc->uhs2_caps.n_lanes_set);
+	sdhci_writel(host, value, sdhci_uhs2_gen_set_reg);
+
+	/* Set PHY Settings */
+	value = FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_DIR_MASK, host->mmc->uhs2_caps.n_lss_dir_set) |
+		FIELD_PREP(SDHCI_UHS2_PHY_N_LSS_SYN_MASK, host->mmc->uhs2_caps.n_lss_sync_set);
+	if (host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD)
+		value |= SDHCI_UHS2_PHY_SET_SPEED_B;
+	sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
+
+	/* Set LINK-TRAN Settings */
+	value = FIELD_PREP(SDHCI_UHS2_TRAN_RETRY_CNT_MASK, host->mmc->uhs2_caps.max_retry_set) |
+		FIELD_PREP(SDHCI_UHS2_TRAN_N_FCU_MASK, host->mmc->uhs2_caps.n_fcu_set);
+	sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
+	sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set, sdhci_uhs2_tran_set_1_reg);
+}
+
+static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
+{
+	u32 val;
+
+	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IN_DORMANT_STATE),
+			      100, UHS2_CHECK_DORMANT_TIMEOUT_100MS, true, host,
+			      SDHCI_PRESENT_STATE)) {
+		pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return -EIO;
+	}
+	return 0;
+}
+
+static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mmc_ios *ios = &mmc->ios;
+	int err = 0;
+
+	DBG("Begin uhs2 control, act %d.\n", op);
+
+	switch (op) {
+	case UHS2_PHY_INIT:
+		err = sdhci_uhs2_do_detect_init(mmc);
+		break;
+	case UHS2_SET_CONFIG:
+		sdhci_uhs2_set_config(host);
+		break;
+	case UHS2_ENABLE_INT:
+		sdhci_uhs2_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
+		break;
+	case UHS2_DISABLE_INT:
+		sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
+		break;
+	case UHS2_CHECK_DORMANT:
+		err = sdhci_uhs2_check_dormant(host);
+		break;
+	case UHS2_DISABLE_CLK:
+		err = sdhci_uhs2_disable_clk(mmc);
+		break;
+	case UHS2_ENABLE_CLK:
+		err = sdhci_uhs2_enable_clk(mmc);
+		break;
+	case UHS2_SET_IOS:
+		err = sdhci_uhs2_set_ios(mmc, ios);
+		break;
+	default:
+		pr_err("%s: input sd uhs2 operation %d is wrong!\n",
+		       mmc_hostname(host->mmc), op);
+		err = -EIO;
+		break;
+	}
+
+	return err;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -317,6 +543,8 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
+	host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
+
 	return 0;
 }
 
-- 
2.25.1

