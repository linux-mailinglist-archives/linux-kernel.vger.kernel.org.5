Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC27809A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359734AbjHRKFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359710AbjHRKEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:04:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76139422F;
        Fri, 18 Aug 2023 03:04:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68859ba3a93so615861b3a.1;
        Fri, 18 Aug 2023 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692352993; x=1692957793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGB6aEfT29O/np/vugEtzabJh26wlJ/7P9M9FZXoZFU=;
        b=bhWZNuhJ5uQ4bONSRm8CBNbI7q/aZv+nYjUsP4Dibn35q/mULzwzjNN1xAffKq7E3Y
         WXdFIz5CZz4WjiUXQ/QGKfjcMfp/E5Kqp6H9YziFivxTSozfBGNfoA8HoRulCbhrNNsH
         04j6OAi16OyVne5ClPKJ/BVOCs8gpMVUgkIi415t0tAJ8cyXFRBLSedmanNjoEKpX/j5
         1cv18Mzo0SWrCbsf/yyV1GsWcPy50+tiSVjrh1WJeO4Z85P7UivOhqXDU12CnufFWy48
         CnjYyNxgVsoyNyKh9Dpa8XmftJPLgl1kr/RAt51x+V3z+E0AOSzP5atOF6yaA3AS5OxV
         a+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352993; x=1692957793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGB6aEfT29O/np/vugEtzabJh26wlJ/7P9M9FZXoZFU=;
        b=gNULx6ikHMovsd5lLvhyGuRID7gOlsyMCLJzNe3wiwum3aPN3e1QQ13Oi66tbww1L8
         FFGCn4ultLsv5hkaHjGaXkHVM4hSqO/XU2tJ7a8occDqC/uvxdvov8HLnGfRRDBHLxZr
         u+5j7hqJh5A1PmEciutQS/Yrh+ls757V7hEMlGIg0j7fXI2Xx3JroQwaW5fVyTAXt0fe
         u47ae7td26yP6ROWh5aC4/DPrGHf7a+kyF8HxmUjWk/Ulw9u6YxipGFntzPG2HO+HvPU
         ZqIKhCzsaLG4RvRHx1HoLJ+iFX40zwjcsrBnWL4f5LbRT7RKlOKyDRoX84n2eh9XgSBi
         4iQQ==
X-Gm-Message-State: AOJu0Yx9OEStZCiRH8Hs3Gp3+uOQ0ZHoegpubpBN379QcQDquSuNYhI7
        f/y7RvTiezpXLSi0AuDW+7k=
X-Google-Smtp-Source: AGHT+IEmYzVmMmzeJZl8EcxNatGEK0l3yNAGLrYz8tF30JegkYYbyi0VwVVCvb8ReKAsnMrdUbaL3w==
X-Received: by 2002:a05:6a20:12c8:b0:137:48cc:9cfa with SMTP id v8-20020a056a2012c800b0013748cc9cfamr2872730pzg.24.1692352993504;
        Fri, 18 Aug 2023 03:03:13 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-55ec-ad14-f925-5202-a39b.emome-ip6.hinet.net. [2001:b400:e25c:55ec:ad14:f925:5202:a39b])
        by smtp.gmail.com with ESMTPSA id n22-20020a62e516000000b006870ccfbb54sm1180649pff.196.2023.08.18.03.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:03:13 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V10 15/23] mmc: sdhci-uhs2: add detect_init() to detect the interface
Date:   Fri, 18 Aug 2023 18:02:09 +0800
Message-Id: <20230818100217.12725-16-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818100217.12725-1-victorshihgli@gmail.com>
References: <20230818100217.12725-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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

