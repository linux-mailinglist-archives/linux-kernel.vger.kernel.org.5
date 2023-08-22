Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE37784CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjHVWpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHVWpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:45:54 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0841CCF2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:45:52 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-64c5f5d6f04so23782826d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692744351; x=1693349151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IA+F9ijfpdDdMdFFKNzTJ+HhXSTDp2+LPFf3LSuVukc=;
        b=MZmfQU/jF6hti+j8QBpEKlF4/1F4b+iSStWbr2ZoCz6SSGNdQeD68dNaIX1JnISuVz
         5VSa57ZNlt+IZelO4/UCkawz9J0W/USJEp3jhiBT+V8buguwF54PJX1LJR+EmS8kjrOI
         PWbRwknIVX3y+aZFGygj/fXwc3KV0wUJvEQBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692744351; x=1693349151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IA+F9ijfpdDdMdFFKNzTJ+HhXSTDp2+LPFf3LSuVukc=;
        b=BkaVpfH6LIcHte1Nqgh0a+er2FIr3kc/uq7boRPvV2YdP2BFzaQUFxHHmIAZbbCW6O
         LbjPPiv9tMhEL6t5DlXv3C7eJTMudbQkSzUL5iExZZ37vGxNetE3SPibLJBqMAKOJTQx
         slggj50K9TccCb8sKnP9FcPbX7LNxmZJMqyjuEPWMBB5OfvzLsui/OtXLvQlc79E+Y0t
         +GUDvMyh67+w2U0/bxR2eR1dk4Pdn4l+A/wPUqdFgwMb7RO6qmrygd7mpZ6prLm9iiuH
         6Kb8D1DSLrIs1EKijY2q6o+fySGMPAcARbD4bhp+CKizlmbO+9BZSCWPU/eR9D+iFtN+
         3v+A==
X-Gm-Message-State: AOJu0YzMnOzAmvA2fRMMxVcAdrGRzSC1WaED+jYhrq7/XGkMNVz3BNoA
        wjlgmUU6F3n/OnmbTwDfDBUMh6u6unO3JKW2qZxv9TVY
X-Google-Smtp-Source: AGHT+IHjE45w2hhTJuEBWNipjgPO63SVpzysUBrY5TQ77WJroBOdxkSOhmVHywFsmr+Xq8LpQcQ5WA==
X-Received: by 2002:a0c:dc12:0:b0:64b:fdf0:48a3 with SMTP id s18-20020a0cdc12000000b0064bfdf048a3mr11731188qvk.10.1692744350854;
        Tue, 22 Aug 2023 15:45:50 -0700 (PDT)
Received: from trappist.c.googlers.com.com (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id g16-20020a05620a109000b0076ceb5eb309sm3532667qkk.74.2023.08.22.15.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 15:45:50 -0700 (PDT)
From:   Sven van Ashbrook <svenva@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     SeanHY.chen@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com, greg.tu@genesyslogic.com.tw,
        linux-mmc@vger.kernel.org, Renius Chen <reniuschengl@gmail.com>,
        ben.chuang@genesyslogic.com.tw, skardach@google.com,
        victor.shih@genesyslogic.com.tw, stable@vger.kernel.org,
        Sven van Ashbrook <svenva@chromium.org>
Subject: [PATCH v1] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix SoCs can suspend
Date:   Tue, 22 Aug 2023 22:45:37 +0000
Message-ID: <20230822224536.v1.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the r/w performance of GL9763E, the current driver inhibits LPM
negotiation while the device is active.

This prevents a large number of SoCs from suspending, notably x86 systems
which use S0ix as the suspend mechanism:
1. Userspace initiates s2idle suspend (e.g. via writing to
   /sys/power/state)
2. This switches the runtime_pm device state to active, which disables
   LPM negotiation, then calls the "regular" suspend callback
3. With LPM negotiation disabled, the bus cannot enter low-power state
4. On a large number of SoCs, if the bus not in a low-power state, S0ix
   cannot be entered, which in turn prevents the SoC from entering
   suspend.

Fix by re-enabling LPM negotiation in the device's suspend callback.

Suggested-by: Stanislaw Kardach <skardach@google.com>
Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
Cc: stable@vger.kernel.org
Signed-off-by: Sven van Ashbrook <svenva@chromium.org>
---

 drivers/mmc/host/sdhci-pci-gli.c | 96 +++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 1792665c9494a..bc148276cc001 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -745,42 +745,6 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
 	return value;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
-{
-	struct sdhci_pci_slot *slot = chip->slots[0];
-
-	pci_free_irq_vectors(slot->chip->pdev);
-	gli_pcie_enable_msi(slot);
-
-	return sdhci_pci_resume_host(chip);
-}
-
-static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
-{
-	struct sdhci_pci_slot *slot = chip->slots[0];
-	int ret;
-
-	ret = sdhci_pci_gli_resume(chip);
-	if (ret)
-		return ret;
-
-	return cqhci_resume(slot->host->mmc);
-}
-
-static int sdhci_cqhci_gli_suspend(struct sdhci_pci_chip *chip)
-{
-	struct sdhci_pci_slot *slot = chip->slots[0];
-	int ret;
-
-	ret = cqhci_suspend(slot->host->mmc);
-	if (ret)
-		return ret;
-
-	return sdhci_suspend_host(slot->host);
-}
-#endif
-
 static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
 					  struct mmc_ios *ios)
 {
@@ -1029,6 +993,62 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
 }
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+
+	pci_free_irq_vectors(slot->chip->pdev);
+	gli_pcie_enable_msi(slot);
+
+	return sdhci_pci_resume_host(chip);
+}
+
+static int gl9763e_resume(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+	int ret;
+
+	ret = sdhci_pci_gli_resume(chip);
+	if (ret)
+		return ret;
+
+	ret = cqhci_resume(slot->host->mmc);
+	if (ret)
+		return ret;
+
+	/* Disable LPM negotiation to bring device back in sync
+	 * with its runtime_pm state.
+	 */
+	gl9763e_set_low_power_negotiation(slot, false);
+
+	return 0;
+}
+
+static int gl9763e_suspend(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+	int ret;
+
+	ret = cqhci_suspend(slot->host->mmc);
+	if (ret)
+		return ret;
+
+	ret = sdhci_suspend_host(slot->host);
+	if (ret)
+		return ret;
+
+	/* Certain SoCs can suspend only with the bus in low-
+	 * power state, notably x86 SoCs when using S0ix.
+	 * Re-enable LPM negotiation to allow entering L1 state
+	 * and entering system suspend.
+	 */
+	gl9763e_set_low_power_negotiation(slot, true);
+
+	return 0;
+}
+#endif
+
 static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
@@ -1113,8 +1133,8 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
 	.probe_slot	= gli_probe_slot_gl9763e,
 	.ops            = &sdhci_gl9763e_ops,
 #ifdef CONFIG_PM_SLEEP
-	.resume		= sdhci_cqhci_gli_resume,
-	.suspend	= sdhci_cqhci_gli_suspend,
+	.resume		= gl9763e_resume,
+	.suspend	= gl9763e_suspend,
 #endif
 #ifdef CONFIG_PM
 	.runtime_suspend = gl9763e_runtime_suspend,
-- 
2.42.0.rc1.204.g551eb34607-goog

