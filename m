Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A691975C472
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjGUKRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjGUKQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:16:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193D7421F;
        Fri, 21 Jul 2023 03:15:56 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8b318c5cfso13058735ad.1;
        Fri, 21 Jul 2023 03:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689934524; x=1690539324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAnqBK9u9n9QQ0wd99m8MMvR+RiTzHoUMR8TujfMHoc=;
        b=kezBTt7PuHGlSD93yWitoxUFXu2PmDOKnqRjf+OJv5vZNTrsXqYxcHGlXJu2lnydC+
         tO+Z/VEQ0TPYHjYzqC4rGR9YoAJQR53Qpap+K0ySJeNBhds6scyuUFk7snhLXp4TTrMd
         VHb5xfhfILs1X6wW8INumnUtgKD316Y7JBtzFJnGTMxuvC+EQnCGZ0xiX4rM15ckAVmn
         pJXv+lQceG+fEfrQ0Kx92EsAE1KsiPly8PQE7Cyc7rvkHlNN4nmC8bqmHh52WxCIjf/0
         RXjFNddf2cpkPb6zS6jk48eKfndqdX/wwfFmL7ovJA2Hpd0d9BBX6hDh5dPPjluDRy7C
         RleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934524; x=1690539324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAnqBK9u9n9QQ0wd99m8MMvR+RiTzHoUMR8TujfMHoc=;
        b=PReIWORlqZ36UxnPzBXhv5Msnzo42be7VPaz7DW4bhrKumuzC2a69ree8GA58VmoYI
         9Gwnpxx7MTjso9qnJZ54xzrwB4bgQKemyHBOh4hzHgiccC6vms1urWfufPz1MI5iMbff
         zUuc7v0R9lAiZ0YEcgrHUzjKRdYEsUSmej4OzyaLcKCLhK2nyVmeyQFk1j627Z0L3bUR
         SoFA5fDtWqgjJD7gF4cX78JAa0ObqOhLu2RU0x6lfsH3FNL2Cehh4kK1Wof8M2iAr4FX
         lhoRbKpD7Te17TGnUN6NBFtUEIEoRtMD9JWcC99qbMv4yWT8XKQd9lwmVwmT8hypjxCX
         aOrA==
X-Gm-Message-State: ABy/qLZf1pBxTF8TKcUSOxalOMmNyzGsnh7YNHr5PBuSkaaiXpnvpDVt
        awxyxp4uVVg0ESuSW9Na0bw=
X-Google-Smtp-Source: APBJJlEz8k/ts2j7jShiG9BszkYpKgSn8VGewLpl0HGoAb7TgxyYckA+7YxLLtkY2ebmTOCB+WKrFQ==
X-Received: by 2002:a17:902:e54a:b0:1b8:b318:8ae5 with SMTP id n10-20020a170902e54a00b001b8b3188ae5mr2050959plf.42.1689934523657;
        Fri, 21 Jul 2023 03:15:23 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e23e-6b0d-6c46-3684-497a-06ee.emome-ip6.hinet.net. [2001:b400:e23e:6b0d:6c46:3684:497a:6ee])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902b48100b001b86492d724sm3050719plr.223.2023.07.21.03.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 03:15:23 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V9 22/23] mmc: sdhci-pci: add UHS-II support framework
Date:   Fri, 21 Jul 2023 18:13:48 +0800
Message-Id: <20230721101349.12387-23-victorshihgli@gmail.com>
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

This patch prepares for adding UHS-II support at a specific UHS-II
capable sdhci-pci controller, GL9755 for now.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V8:
 - Add config select MMC_SDHCI_UHS2 in Kconfig.

---

 drivers/mmc/host/Kconfig          |  1 +
 drivers/mmc/host/sdhci-pci-core.c | 16 +++++++++++++++-
 drivers/mmc/host/sdhci-pci.h      |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 215f1ab011dd..aa178384de16 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -111,6 +111,7 @@ config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
 	select MMC_CQHCI
+	select MMC_SDHCI_UHS2
 	select IOSF_MBI if X86
 	select MMC_SDHCI_IO_ACCESSORS
 	help
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 1c2572c0f012..e84c2db41a70 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -40,6 +40,7 @@
 #include "sdhci.h"
 #include "sdhci-cqhci.h"
 #include "sdhci-pci.h"
+#include "sdhci-uhs2.h"
 
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
 
@@ -2156,7 +2157,10 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	if (scratch == (u32)-1)
 		dead = 1;
 
-	sdhci_remove_host(slot->host, dead);
+	if (slot->chip->fixes && slot->chip->fixes->remove_host)
+		slot->chip->fixes->remove_host(slot, dead);
+	else
+		sdhci_remove_host(slot->host, dead);
 
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
@@ -2164,6 +2168,16 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	sdhci_free_host(slot->host);
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot)
+{
+	return sdhci_uhs2_add_host(slot->host);
+}
+
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead)
+{
+	sdhci_uhs2_remove_host(slot->host, dead);
+}
+
 static void sdhci_pci_runtime_pm_allow(struct device *dev)
 {
 	pm_suspend_ignore_children(dev, 1);
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 9c8863956381..d5c9f02f3e14 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -141,6 +141,7 @@ struct sdhci_pci_fixes {
 	int			(*probe_slot) (struct sdhci_pci_slot *);
 	int			(*add_host) (struct sdhci_pci_slot *);
 	void			(*remove_slot) (struct sdhci_pci_slot *, int);
+	void			(*remove_host) (struct sdhci_pci_slot *, int);
 
 #ifdef CONFIG_PM_SLEEP
 	int			(*suspend) (struct sdhci_pci_chip *);
@@ -185,6 +186,8 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
 	return (void *)slot->private;
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot);
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead);
 #ifdef CONFIG_PM_SLEEP
 int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
 #endif
-- 
2.25.1

