Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092E67A1B13
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjIOJpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjIOJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:45:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EF830CB;
        Fri, 15 Sep 2023 02:44:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-273527a8fdeso1555280a91.2;
        Fri, 15 Sep 2023 02:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771077; x=1695375877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5n3eE3Ata3IyatGkRiLKnqfCiSvDcm1Sfzsxn9YuHc=;
        b=VqdXb17YRxSSI1Mc4IYtdNqDF3kRijkvAMWQmMVzJK6RnpPlLTgZeg2Ng7e/WgOsXW
         jHZROnpSHfdjQj9byz807/8aoEZVR8ei2A/LwTxbuFxRuSYXq4Vj20Joe8y42gY1QodI
         nDy4w8eOFo+ZDp+iDUjAXF6sSRG4TLCgSSlWH+rY0kgOjGos0ad7uQPSPGaUVuq+mII4
         nMZbYI0M9WKn3/VYkZXbLe8j0DmP7ROYUa8zIupGAnjAoj2+2lJoDbpK0mdkRt5gZCVZ
         x0WnpAjfnPGpJD/kQsucjNJVOXryvb8fx/pzSPBHSzI9r7dkQ7jwt+6dczDruMoU3Xhz
         8eKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771077; x=1695375877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5n3eE3Ata3IyatGkRiLKnqfCiSvDcm1Sfzsxn9YuHc=;
        b=YddLwF974ebWQLnrNflqJtML3SxABFA4r8s39LaD1NHbQV8jkckBJ/ektQYIV7NWQ5
         CSX1dXGxoEbbZVvsTOdzan3/LzK1L6fpVJqvNUVE4F+LjZRdHmKyFo0Xozby4S7LuQzj
         XAx81omVNYQm2946lS74EVWKsj0Mjl1nE+Q+hKxgzbAKkR6z8pz9h1KqYdM0+Z6OQ0Zz
         arQ++jIajh7iX7/4Aq6n+ccxkXxfZUdt/FELOheq3zUhwbBDuDuOU/TFN4BQhjrdEVOe
         Smb+Ecpg11n/YqTDhujVXDrjRrx2+IjO/QBUhS6CppM/QcnJCCbyT+Zzky3A9JbAZb1g
         u7jA==
X-Gm-Message-State: AOJu0Yy6TflApxr7DLuKlbpftTeUOg+2S7Vg3RaCux7z6J7jnk3cZYSv
        g7HUYyB2axCOrS5Dgd2SPe8XqP6X9vI=
X-Google-Smtp-Source: AGHT+IFd7rNuFYQcX43QACgByA3RqptiFJVCOV/Tte252t2udQhNzNV/MASd8zfu1W8hvC6Num+RNg==
X-Received: by 2002:a17:90b:1d12:b0:274:7fb5:e17b with SMTP id on18-20020a17090b1d1200b002747fb5e17bmr907755pjb.19.1694771076865;
        Fri, 15 Sep 2023 02:44:36 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e2a6-6d77-d32f-f490-6688-3d32.emome-ip6.hinet.net. [2001:b400:e2a6:6d77:d32f:f490:6688:3d32])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090a530400b0025023726fc4sm4432794pjh.26.2023.09.15.02.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:44:36 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V12 14/23] mmc: sdhci-uhs2: add set_ios()
Date:   Fri, 15 Sep 2023 17:43:42 +0800
Message-Id: <20230915094351.11120-15-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915094351.11120-1-victorshihgli@gmail.com>
References: <20230915094351.11120-1-victorshihgli@gmail.com>
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

This is a sdhci version of mmc's set_ios operation.
It covers both UHS-I and UHS-II.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Updates in V9:
 - Simplity the turning_on_clk in sdhci_set_ios().

Updates in V8:
 - Add the judgment formula for MMC_TIMING_SPEED_A_HD, MMC_TIMING_SPEED_B
   and MMC_TIMING_SPEED_B_HD in __sdhci_uhs2_set_ios().
 - Add the switch case for MMC_TIMING_SPEED_A_HD, MMC_TIMING_SPEED_B
   and MMC_TIMING_SPEED_B_HD in sdhci_get_preset_value().
 - mmc_opt_regulator_set_ocr() to instead of mmc_regulator_set_ocr()
   in sdhci_uhs2_set_ios().

Updates in V7:
 - Remove unnecessary functions.

Updates in V6:
 - Modify return value in some functions.
 - Remove unnecessary functions.

---

 drivers/mmc/host/sdhci-uhs2.c | 94 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  1 +
 drivers/mmc/host/sdhci.c      | 55 ++++++++++++--------
 drivers/mmc/host/sdhci.h      |  2 +
 4 files changed, 131 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index d519e6ce6199..ad791c48f681 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -214,6 +214,70 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
 
+/**
+ * sdhci_uhs2_clear_set_irqs - set Error Interrupt Status Enable register
+ * @host:	SDHCI host
+ * @clear:	bit-wise clear mask
+ * @set:	bit-wise set mask
+ *
+ * Set/unset bits in UHS-II Error Interrupt Status Enable register
+ */
+void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
+{
+	u32 ier;
+
+	ier = sdhci_readl(host, SDHCI_UHS2_INT_STATUS_ENABLE);
+	ier &= ~clear;
+	ier |= set;
+	sdhci_writel(host, ier, SDHCI_UHS2_INT_STATUS_ENABLE);
+	sdhci_writel(host, ier, SDHCI_UHS2_INT_SIGNAL_ENABLE);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
+
+static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u8 cmd_res, dead_lock;
+	u16 ctrl_2;
+
+	/* UHS2 Timeout Control */
+	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
+
+	/* change to use calculate value */
+	cmd_res |= FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead_lock);
+
+	sdhci_uhs2_clear_set_irqs(host,
+				  SDHCI_UHS2_INT_CMD_TIMEOUT |
+				  SDHCI_UHS2_INT_DEADLOCK_TIMEOUT,
+				  0);
+	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
+	sdhci_uhs2_clear_set_irqs(host, 0,
+				  SDHCI_UHS2_INT_CMD_TIMEOUT |
+				  SDHCI_UHS2_INT_DEADLOCK_TIMEOUT);
+
+	/* UHS2 timing. Note, UHS2 timing is disabled when powering off */
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	if (ios->timing == MMC_TIMING_UHS2_SPEED_A ||
+	    ios->timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+	    ios->timing == MMC_TIMING_UHS2_SPEED_B ||
+	    ios->timing == MMC_TIMING_UHS2_SPEED_B_HD)
+		ctrl_2 |= SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE;
+	else
+		ctrl_2 &= ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE);
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+	host->timing = ios->timing;
+
+	if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
+		sdhci_enable_preset_value(host, true);
+
+	if (host->ops->set_power)
+		host->ops->set_power(host, ios->power_mode, ios->vdd);
+	else
+		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
+
+	sdhci_set_clock(host, host->clock);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * MMC callbacks                                                             *
@@ -235,6 +299,36 @@ static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
 	return sdhci_start_signal_voltage_switch(mmc, ios);
 }
 
+static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
+		 mmc_hostname(mmc), ios->clock, ios->power_mode, ios->vdd, ios->timing);
+
+	if (!sdhci_uhs2_mode(host)) {
+		sdhci_set_ios(mmc, ios);
+		return 0;
+	}
+
+	if (ios->power_mode == MMC_POWER_UNDEFINED)
+		return 0;
+
+	if (host->flags & SDHCI_DEVICE_DEAD) {
+		if (ios->power_mode == MMC_POWER_OFF) {
+			mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+			mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
+		}
+		return -1;
+	}
+
+	sdhci_set_ios_common(mmc, ios);
+
+	__sdhci_uhs2_set_ios(mmc, ios);
+
+	return 0;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index ccf4e1834c2d..a3641c5f8c77 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -181,5 +181,6 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 bool sdhci_uhs2_mode(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
+void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index eca54a16e7fc..57209accbb03 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -47,8 +47,6 @@
 static unsigned int debug_quirks = 0;
 static unsigned int debug_quirks2;
 
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
-
 static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
 
 void sdhci_dumpregs(struct sdhci_host *host)
@@ -1877,6 +1875,12 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 	case MMC_TIMING_MMC_HS400:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
 		break;
+	case MMC_TIMING_UHS2_SPEED_A:
+	case MMC_TIMING_UHS2_SPEED_A_HD:
+	case MMC_TIMING_UHS2_SPEED_B:
+	case MMC_TIMING_UHS2_SPEED_B_HD:
+		preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
+		break;
 	default:
 		pr_warn("%s: Invalid UHS-I mode selected\n",
 			mmc_hostname(host->mmc));
@@ -2323,24 +2327,9 @@ static bool sdhci_presetable_values_change(struct sdhci_host *host, struct mmc_i
 	       (sdhci_preset_needed(host, ios->timing) || host->drv_type != ios->drv_type);
 }
 
-void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	bool reinit_uhs = host->reinit_uhs;
-	bool turning_on_clk = false;
-	u8 ctrl;
-
-	host->reinit_uhs = false;
-
-	if (ios->power_mode == MMC_POWER_UNDEFINED)
-		return;
-
-	if (host->flags & SDHCI_DEVICE_DEAD) {
-		if (!IS_ERR(mmc->supply.vmmc) &&
-		    ios->power_mode == MMC_POWER_OFF)
-			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
-		return;
-	}
 
 	/*
 	 * Reset the chip on each power off.
@@ -2357,8 +2346,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sdhci_enable_preset_value(host, false);
 
 	if (!ios->clock || ios->clock != host->clock) {
-		turning_on_clk = ios->clock && !host->clock;
-
 		host->ops->set_clock(host, ios->clock);
 		host->clock = ios->clock;
 
@@ -2374,6 +2361,31 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			mmc->max_busy_timeout /= host->timeout_clk;
 		}
 	}
+}
+EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
+
+void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	bool reinit_uhs = host->reinit_uhs;
+	bool turning_on_clk;
+	u8 ctrl;
+
+	host->reinit_uhs = false;
+
+	if (ios->power_mode == MMC_POWER_UNDEFINED)
+		return;
+
+	if (host->flags & SDHCI_DEVICE_DEAD) {
+		if (!IS_ERR(mmc->supply.vmmc) &&
+		    ios->power_mode == MMC_POWER_OFF)
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		return;
+	}
+
+	turning_on_clk = ios->clock != host->clock && ios->clock && !host->clock;
+
+	sdhci_set_ios_common(mmc, ios);
 
 	if (host->ops->set_power)
 		host->ops->set_power(host, ios->power_mode, ios->vdd);
@@ -2957,7 +2969,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 }
 EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
 
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
+void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 {
 	/* Host Controller v3.00 defines preset value registers */
 	if (host->version < SDHCI_SPEC_300)
@@ -2985,6 +2997,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 		host->preset_enabled = enable;
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
 
 static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 				int err)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f3bd558b337f..03d29423a678 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -847,6 +847,8 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
+void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
+void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
 void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
-- 
2.25.1

