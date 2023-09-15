Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CCA7A1B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjIOJpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjIOJo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:44:59 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76657271C;
        Fri, 15 Sep 2023 02:44:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-54290603887so1439569a12.1;
        Fri, 15 Sep 2023 02:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771069; x=1695375869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UK9MBAHGz8tlo/bvdubmQkTLGlYqwazBs/q6Zb4Rh4c=;
        b=EQ0EiGX3cpVk4nKBVr6Rwvb8dkgkc9kQzqrtGMFThKGpqb87g0pUqgI2eBEUIhgKT6
         c+EIBXgVOERIPkT1xyi3XwgRZgNiN/gNol4tkcPq4f+jFY30xHJu9korD0z3biXAiLwu
         axYeSJrwSuUXPxfOkrkU/8A2Rg32xehsuVcILAHHrIFnSoRsqEpn6XKP+og7IH501PdH
         bRT/5CnqEuYk+GT7O/1nfbbni00S0kuJbiHm5xSKcfDdm5iKoscjNd7kVzId4LaDQxxz
         eqaFNu86JogNIVHFYY9dTaMIoVo1DiairNC66GDnoraSuN32ShrDOkpPNUEYrEb66XDg
         Cfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771069; x=1695375869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK9MBAHGz8tlo/bvdubmQkTLGlYqwazBs/q6Zb4Rh4c=;
        b=texGLtM81NBPTk71qRda+HCnp7bMs5piR0a/k7AA4LqCdCnAW/jqnsSWs8Anuvipyf
         950oHXPE2dWGMIUR9dRtx71+BtQ3phFlulBVLZSwLCEDBFZnFMFGYcfntY5IgEjCjgCB
         JWD14I1x22IvdQyD4/2/WCrdrOuDQXWefwJU3GrL3zeckaYZMEfBwddu6H8qubMDFIi8
         9yZMyiu2EuzrfAk/61w23DeAe5cQY3BGC94KKrmAiVehY9tvX8x9bXbVEXZtgiNjK32f
         dzovBfSTNNkrojczQsYwKMlwp/Hkac0HwFq5vZbVGBISosrd4UO0AJgO5pwLDFg/fGc7
         rQpg==
X-Gm-Message-State: AOJu0YwJvi3KGfQ3vg3qcVHfNjLCEdXd33z+2JUEgeymXkM1wZq5voPt
        C6YLKk+YKyx1no6Z7Q+CyLc=
X-Google-Smtp-Source: AGHT+IGNoQ6B8gJsF5axQMEo8rGoQjXSUHMzNOxqgwSID70qBTywuNco4EHDYXU8B28Uo8YSr/9Rtg==
X-Received: by 2002:a05:6a21:7784:b0:14c:6404:7c5e with SMTP id bd4-20020a056a21778400b0014c64047c5emr1338583pzc.24.1694771068834;
        Fri, 15 Sep 2023 02:44:28 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e2a6-6d77-d32f-f490-6688-3d32.emome-ip6.hinet.net. [2001:b400:e2a6:6d77:d32f:f490:6688:3d32])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090a530400b0025023726fc4sm4432794pjh.26.2023.09.15.02.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:44:28 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V12 11/23] mmc: sdhci-uhs2: add set_power() to support vdd2
Date:   Fri, 15 Sep 2023 17:43:39 +0800
Message-Id: <20230915094351.11120-12-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915094351.11120-1-victorshihgli@gmail.com>
References: <20230915094351.11120-1-victorshihgli@gmail.com>
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
index 6c8258310641..610644a0ace5 100644
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

