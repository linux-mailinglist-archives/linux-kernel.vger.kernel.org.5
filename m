Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30754780994
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359681AbjHRKFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359672AbjHRKE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:04:27 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E5A3AB9;
        Fri, 18 Aug 2023 03:04:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6889350bc2bso699132b3a.0;
        Fri, 18 Aug 2023 03:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692352982; x=1692957782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmvRcwSX9mivOMd2F6LZuvrkylgkIQLRzYwEdUvvsrE=;
        b=gejVDWt0+IRvMB0se7Yiop/p3f5/2EkYud97pvY098/YXkBJQu6IPUprbAHrkdeuNn
         kO7fqdX81O4qVakf6kaArNgv/OyoXSssUgp9dWjbQ6+Er/ldw4YFBf8ppmUD6fzDVgh3
         aWicw4JaASn7Yz4ej0matjTV2bBCGrTZ+NIo2FZ8kbffpSz2YqrnBl6Vj849kuQW/wjj
         0tqyuVy+WOX7qfNbXMgr4mUaC+vUlX9qqT+LKmAc4t2QPE0/r+PrXuvAegTBCP44yCmj
         p5VftvECec/D5cC9W3TEOL9GJuKKOGBPuy6KXLb6oNADDFvXeZOIwdQqJQLBKrV6WayF
         0TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352982; x=1692957782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmvRcwSX9mivOMd2F6LZuvrkylgkIQLRzYwEdUvvsrE=;
        b=LWf/kDs9mNama8P+uPieloB9AcZ1SNTifBTOPbL9peULz21iq1vnhvC/fEoraXdNYv
         vHnjYAdV/lBzMuJz8b6G/+SORFDOrJmPnRyiAplK5tZbrglnhYwxZly5afm9/eeGuFwq
         8QRHWTOUXt224LJIP+5D3JmimqfI+I6x9dKP8xyl3TFxbTqvCleF0q7mQUr8UraNJGys
         PgjJ9VTZ0OaPxAMnB2D3LSaOzlveNrj/e7FOmrHfglZyOtg7uStSLgQbudjYAvWSUXsX
         feoEih5gjiJbcRgAOiSAFpTjt9cgkAB5BYf/reLEpRcdUSJWgnlvJ5irtdL865IoXQm6
         ULew==
X-Gm-Message-State: AOJu0Yz1lMUkVWt/3jth65qZwGaDTvkkO2yOfXSfFKNq6ZZOGuwqvjlU
        NRPodv1Zi3j/o5mDwly6kUli2WW83SY=
X-Google-Smtp-Source: AGHT+IF1PWRBKsdI3Rf8fiSct4jX4lKzsiIhYoD4Uq8qg2g7wuW1dHzfDoNxvF86SeDtsVfdsH+Rew==
X-Received: by 2002:a05:6a20:a123:b0:135:4527:efe4 with SMTP id q35-20020a056a20a12300b001354527efe4mr2997135pzk.10.1692352981814;
        Fri, 18 Aug 2023 03:03:01 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-55ec-ad14-f925-5202-a39b.emome-ip6.hinet.net. [2001:b400:e25c:55ec:ad14:f925:5202:a39b])
        by smtp.gmail.com with ESMTPSA id n22-20020a62e516000000b006870ccfbb54sm1180649pff.196.2023.08.18.03.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:03:01 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V10 11/23] mmc: sdhci-uhs2: add set_power() to support vdd2
Date:   Fri, 18 Aug 2023 18:02:05 +0800
Message-Id: <20230818100217.12725-12-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818100217.12725-1-victorshihgli@gmail.com>
References: <20230818100217.12725-1-victorshihgli@gmail.com>
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
index e38c45392079..1eba64228725 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -357,6 +357,7 @@ struct mmc_pwrseq;
 
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
+	struct regulator *vmmc2;	/* UHS2 VDD2 power supply */
 	struct regulator *vqmmc;	/* Optional Vccq supply */
 	struct regulator *vqmmc2;	/* Optional supply for phy */
 };
-- 
2.25.1

