Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D354798528
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242789AbjIHJzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 05:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242702AbjIHJzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:55:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4794A2120;
        Fri,  8 Sep 2023 02:54:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c34c9cc9b9so14815525ad.3;
        Fri, 08 Sep 2023 02:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694166850; x=1694771650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dguUjMOvjRLJariqiYEYbcld50cWoXzcuD1+RCxeUPc=;
        b=llGJFusiaTJybQJud8L6mIbV1GI4OW35pouhHehNLG2zNdTOH0+djtFWmWXJrHmsdU
         p6rDFaMlyJt4+ujROI5r1rqLWPqJhnV5gvvW9WQSvAC5Fpbi/nJrPCHkghikH/abIhmW
         sAuegH9WelNTq45l+D55B6+a6rwg9xwckebL312ifxnw3wI/ozhI13kkIuc3Iihx4Imq
         kZfCZPNiAB5ApQ4L8HUuQO1l0M4i7xqDOCZQTDfywMGb3JunBg0Fo7fTCh3v/2wTQjZD
         Zg1fD2GSDw8Nq6S/UvY0p38fFFlP8a7oLoqQa6yhS1tonKMJ49LEvB0e4yA23olFMvBY
         Ry7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694166850; x=1694771650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dguUjMOvjRLJariqiYEYbcld50cWoXzcuD1+RCxeUPc=;
        b=T1hB+ai+qafgh1Z35do+GEI3RTKCCnLI5KYROBIVqDYEzd1/6kXjYegaVE79wBFy7k
         8sPiZ8pnrssXfmkFkjin39/d05w/ZD9uA0eYafS8AswMrcqrZ4M55aAQBfsrBuZZ4sPl
         kj2DrUbg2FtBn2W+Sm4MV+IkHLhhA9Jpd3NbHlCe0ibTA7c3i+uVPOTNuo0TvxRssAH2
         U5vUDjkBSZ/HyWElD2qdC/wiyxD7W4O0xE7EzsnjL2W82hNs4Ng9htwPa1vThK6sTg/L
         ERTQ5RHvx1xIawSffn8oV5Hv2SL7/Gw3O6uxX4qo7UL68vdec5ZAga2xmvSHGCi/CvTe
         0ZIg==
X-Gm-Message-State: AOJu0Yzi2NOHONjx5eFlzTL5+HzyO/A5Gcd54cBbeamcK0Ag4U0k4tCu
        UjLc0fknHf72S2UkpYi0Rn4YKn4I5ug=
X-Google-Smtp-Source: AGHT+IF7LdqVh/AMnlrwmjBripgHBeSlkejbAIfxn2GhZyDP03CZSIkNqrojJBNduNdfLCY9EqwzKw==
X-Received: by 2002:a17:902:e80f:b0:1c0:bcbc:d64 with SMTP id u15-20020a170902e80f00b001c0bcbc0d64mr2176994plg.51.1694166849878;
        Fri, 08 Sep 2023 02:54:09 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e3a1-00a4-a20b-46bc-ccec-3e79.emome-ip6.hinet.net. [2001:b400:e3a1:a4:a20b:46bc:ccec:3e79])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b001b892aac5c9sm1172178plg.298.2023.09.08.02.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 02:54:09 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V11 11/23] mmc: sdhci-uhs2: add set_power() to support vdd2
Date:   Fri,  8 Sep 2023 17:53:18 +0800
Message-Id: <20230908095330.12075-12-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908095330.12075-1-victorshihgli@gmail.com>
References: <20230908095330.12075-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a UHS-II version of sdhci's set_power operation.
VDD2, as well as VDD, is handled here.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Updates in V10:
 - Move some definitions of PatchV9[05/23] to PatchV10[11/23].

Updates in V9:
 - Modify annotations in sdhci_get_vdd_value().

Updates in V8:
 - Adjust the position of matching brackets.
 - Add the initial value of the pwr in sdhci_uhs2_set_power().

Updates in V7:
 - Add clear the power reg before setting a new value
   in sdhci_uhs2_set_power().
 - Add MMC_VDD_34_35 case and MMC_VDD_35_36 case in sdhci_get_vdd_value().
 - Drop pwr variable in sdhci_get_vdd_value().

Updates in V6:
 - Add mmc_opt_regulator_set_ocr().
 - Remove unnecessary functions.

---

 drivers/mmc/host/sdhci-uhs2.c | 48 +++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c      | 61 +++++++++++++++++++----------------
 drivers/mmc/host/sdhci.h      |  1 +
 include/linux/mmc/host.h      |  1 +
 4 files changed, 83 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index dfc80a7f1bad..fc37a34629c2 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -57,6 +57,13 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
  *                                                                           *
 \*****************************************************************************/
 
+static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
+					    struct regulator *supply,
+					    unsigned short vdd_bit)
+{
+	return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc, supply, vdd_bit);
+}
+
 bool sdhci_uhs2_mode(struct sdhci_host *host)
 {
 	return host->mmc->flags & MMC_UHS2_SUPPORT;
@@ -94,6 +101,47 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
 
+static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+	u8 pwr = 0;
+
+	if (mode != MMC_POWER_OFF) {
+		pwr = sdhci_get_vdd_value(vdd);
+		if (!pwr)
+			WARN(1, "%s: Invalid vdd %#x\n",
+			     mmc_hostname(host->mmc), vdd);
+		pwr |= SDHCI_VDD2_POWER_180;
+	}
+
+	if (host->pwr == pwr)
+		return;
+	host->pwr = pwr;
+
+	if (pwr == 0) {
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+
+		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
+	} else {
+		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+		/* support 1.8v only for now */
+		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, fls(MMC_VDD_165_195) - 1);
+
+		/* Clear the power reg before setting a new value */
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+
+		/* vdd first */
+		pwr |= SDHCI_POWER_ON;
+		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
+		mdelay(5);
+
+		pwr |= SDHCI_VDD2_POWER_ON;
+		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		mdelay(5);
+	}
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 753b251179f2..eca54a16e7fc 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -23,7 +23,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
-
+#include <linux/bug.h>
 #include <linux/leds.h>
 
 #include <linux/mmc/mmc.h>
@@ -2061,41 +2061,46 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 }
 
+unsigned short sdhci_get_vdd_value(unsigned short vdd)
+{
+	switch (1 << vdd) {
+	case MMC_VDD_165_195:
+	/*
+	 * Without a regulator, SDHCI does not support 2.0v
+	 * so we only get here if the driver deliberately
+	 * added the 2.0v range to ocr_avail. Map it to 1.8v
+	 * for the purpose of turning on the power.
+	 */
+	case MMC_VDD_20_21:
+		return SDHCI_POWER_180;
+	case MMC_VDD_29_30:
+	case MMC_VDD_30_31:
+		return SDHCI_POWER_300;
+	case MMC_VDD_32_33:
+	case MMC_VDD_33_34:
+	/*
+	 * 3.4V ~ 3.6V are valid only for those platforms where it's
+	 * known that the voltage range is supported by hardware.
+	 */
+	case MMC_VDD_34_35:
+	case MMC_VDD_35_36:
+		return SDHCI_POWER_330;
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
+
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd)
 {
 	u8 pwr = 0;
 
 	if (mode != MMC_POWER_OFF) {
-		switch (1 << vdd) {
-		case MMC_VDD_165_195:
-		/*
-		 * Without a regulator, SDHCI does not support 2.0v
-		 * so we only get here if the driver deliberately
-		 * added the 2.0v range to ocr_avail. Map it to 1.8v
-		 * for the purpose of turning on the power.
-		 */
-		case MMC_VDD_20_21:
-			pwr = SDHCI_POWER_180;
-			break;
-		case MMC_VDD_29_30:
-		case MMC_VDD_30_31:
-			pwr = SDHCI_POWER_300;
-			break;
-		case MMC_VDD_32_33:
-		case MMC_VDD_33_34:
-		/*
-		 * 3.4 ~ 3.6V are valid only for those platforms where it's
-		 * known that the voltage range is supported by hardware.
-		 */
-		case MMC_VDD_34_35:
-		case MMC_VDD_35_36:
-			pwr = SDHCI_POWER_330;
-			break;
-		default:
+		pwr = sdhci_get_vdd_value(vdd);
+		if (!pwr) {
 			WARN(1, "%s: Invalid vdd %#x\n",
 			     mmc_hostname(host->mmc), vdd);
-			break;
 		}
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 43ad3f4b7672..f3bd558b337f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -837,6 +837,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
 				     unsigned char mode,
 				     unsigned short vdd);
+unsigned short sdhci_get_vdd_value(unsigned short vdd);
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 int sdhci_get_cd_nogpio(struct mmc_host *mmc);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c300b1cfaf4d..b2b789a28383 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -363,6 +363,7 @@ struct mmc_pwrseq;
 
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
+	struct regulator *vmmc2;	/* UHS2 VDD2 power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
 	struct regulator *vqmmc2;	/* Optional supply for phy */
 };
-- 
2.25.1

