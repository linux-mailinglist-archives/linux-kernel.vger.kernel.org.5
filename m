Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A7275C45D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjGUKQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGUKQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:16:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544E42D45;
        Fri, 21 Jul 2023 03:15:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b89d47ffb6so10543925ad.2;
        Fri, 21 Jul 2023 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689934501; x=1690539301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtoxRKPLdlM6AVunMmyhyskFYHXARU63cD5YOSlVOus=;
        b=WXJRpZTgupQNX6UdXFnhQkYqAKvMgy8navuuH6eYleydK8TTu3s8+N/WEJf14E7NoY
         XG/CWuePttAsFWD9eZkaIkjTWYp52IjNWwlgcG06P5lsUx+8Paq5olPj/rlqz+NccJnX
         kXONypCAWRi6vr2RTnSME/kNMMCjOm3dZFyq88PE3cmYz/N6ZRYB9YgHPsncxdzgBaXx
         LD9DlDeft9xBv5mH8i5ZOkRI1ahG68fIcDzy0LGtIthx7NnyMw4PP4MY4A/LCj9Sq91H
         ZkRXQ8GtxE5wnhHnf/CppCldOoo1mFju1sORHpiZBGmmMKtOzJi3asQfw0A2tcGNaens
         wQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934501; x=1690539301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtoxRKPLdlM6AVunMmyhyskFYHXARU63cD5YOSlVOus=;
        b=Gq+xYKf8Xt/YjdRORjZfkjj0pqPiJB/bv6HDtzrd85itIQPcmBjAD8xatv2PFGp81D
         kd6MeZMOVokU4gZRF82gRF7KyPwsVHifTloICFTl2GxYYwII+KPWmyu37MEvtCYerxGZ
         fugpL5C70OtZnro0gm2zJM/PLBiqsA3EkAGCz7fE66mLJnSZEEBlH+HRbTSQDgx5/+Yk
         rhyAENBGNF6Kn7aBsvbHYlWa1FfD/tIk2n+Pg6hZ+BbBpmUN7TQwVPNzza6Y9GX8aFaS
         j2repcLpJ3PqfPJpN3FTVr9zIqYmjTd8DGetaafRke+767b2YaR1Ej+6Lsdg0INrFfnL
         u98A==
X-Gm-Message-State: ABy/qLbBdvYxmOLPxZOsHJ8KlmUliAsqlxV5WQ7cWACsNBv+NV0UID48
        AQDD+RTsykcslU9ADN1XjU4=
X-Google-Smtp-Source: APBJJlFE8eBr6wQXlO7CBwwkjDynDDMgKdQJPA8xe3Mw+WpvbqXS27wgLyF71WWcNCj1mj6QbtRSag==
X-Received: by 2002:a17:902:ff02:b0:1b2:46ab:a9e1 with SMTP id f2-20020a170902ff0200b001b246aba9e1mr1080104plj.28.1689934500919;
        Fri, 21 Jul 2023 03:15:00 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e23e-6b0d-6c46-3684-497a-06ee.emome-ip6.hinet.net. [2001:b400:e23e:6b0d:6c46:3684:497a:6ee])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902b48100b001b86492d724sm3050719plr.223.2023.07.21.03.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 03:15:00 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V9 15/23] mmc: sdhci-uhs2: add detect_init() to detect the interface
Date:   Fri, 21 Jul 2023 18:13:41 +0800
Message-Id: <20230721101349.12387-16-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721101349.12387-1-victorshihgli@gmail.com>
References: <20230721101349.12387-1-victorshihgli@gmail.com>
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

Sdhci_uhs2_do_detect_init() is a sdhci version of mmc's uhs2_detect_init
operation. After detected, the host's UHS-II capabilities will be set up
here and interrupts will also be enabled.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V8:
 - usleep_range() to instead of udelay() in sdhci_uhs2_interface_detect().
 - read_poll_timeout() to instead of read_poll_timeout_atomic()
   in sdhci_uhs2_interface_detect().
 - Modify return value in sdhci_uhs2_do_detect_init().

Updates in V7:
 - Drop using uhs2_reset ops and use sdhci_uhs2_reset()
   in sdhci_uhs2_do_detect_init().

Updates in V6:
 - Remove unnecessary functions.
 - Wrap at 100 columns in some functions.

---

 drivers/mmc/host/sdhci-uhs2.c | 112 ++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index ad791c48f681..4c2a56629ab3 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -335,6 +335,118 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
  *                                                                           *
 \*****************************************************************************/
 
+static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
+{
+	int timeout = 100000; /* 100ms */
+	u32 val;
+
+	usleep_range(50, 200); /* wait for 50us - 200us before check */
+
+	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_IF_DETECT),
+			      100, timeout, true, host, SDHCI_PRESENT_STATE)) {
+		pr_warn("%s: not detect UHS2 interface in 100ms.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return -EIO;
+	}
+
+	/* Enable UHS2 error interrupts */
+	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
+
+	/* 150ms */
+	timeout = 150000;
+	if (read_poll_timeout(sdhci_readl, val, (val & SDHCI_UHS2_LANE_SYNC),
+			      100, timeout, true, host, SDHCI_PRESENT_STATE)) {
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
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
 	host->mmc_host_ops.start_signal_voltage_switch =
-- 
2.25.1

