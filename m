Return-Path: <linux-kernel+bounces-153218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A498ACB04
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1582815E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A552C15217D;
	Mon, 22 Apr 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5y8J1og"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31FF152160;
	Mon, 22 Apr 2024 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782346; cv=none; b=l5l04yBsDjoBZUiS53GojbbXGziYFmDb2r+peA3CxzQlKw7mbQMIwYWQnGDFEp9bAgQ0O7M9ts/+tiAjB/IJiNIYipP/Ng9lYAGFLwNvs1wLK4MzEm18+JCp0Z85N1SJFnoh/1FoW7dICmQDvz1k/3gIoNSuTrgARt47KDoUDe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782346; c=relaxed/simple;
	bh=v9mxBjl4iAGGAGoXMTHEqqSw4F02OKsbE7vjYoXauoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=egHNq09GsGwKLPiu0MbT2iQ2yFqfkgFOAk6v1eNSli4B8Qb6mvErQwIep4DcKmzyxXeJhoiJ3LCvt97Db5nVL6vAaTqR382QVcTVsLI377DxBnfX7xpl2TnmB+e+FOh6yQDVgPaM/9GhA1LKNTi2lb5HV4GSUWoCj6J8YYlB1AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5y8J1og; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f26588dd5eso1312707b3a.0;
        Mon, 22 Apr 2024 03:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713782344; x=1714387144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qVegFk/KpEaqZ/zYOxYtiHLSmvTYrUk6gG178ZL8fs=;
        b=j5y8J1ogywUOAn2ObnBfzPMTjtpp73tDLA7mn/gDdk/zE13ezURU2JlRHtGWknTRiw
         FvSbkDCW+0gZ5w4cYgyHvGcq4ob7OlJkxFPecfmtEgh1uSoX64g8O9yUM1pRckgVHzUO
         ZTHvHnoVT/CFU0Oqvn3Hc7MU9iz+NjahYQGqhQ4vwMAX/R5VtwjSoWr636lgXixPji/q
         5Ab7xnMhQScvXopEz4LjU0rJzk6eqkea2KK7U+GBH4P91XyYR4UURJXxTkBOXHakx9nr
         dfLOjna/vtVRfO/qxQUG6sPilUqYKObvZOhlEJaWxP0EXB8oGpiDBGWMsGKvBiCc/HbT
         ryYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782344; x=1714387144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qVegFk/KpEaqZ/zYOxYtiHLSmvTYrUk6gG178ZL8fs=;
        b=ljNppQODrZO2ADNvMJC45a+7NbhVGwUREZ43/ycCHel8kbfK9yWD2S0HaH6WijAL3v
         o+JT0vf38AgvVnrnXjxLu7OYw1pjQACtjYMn7QSphc8i5AWMet5ZEn93XFfApPLw8vLC
         KujwA9ttuFgdg2zeYdWoaT0H5sr8zTDnrMpzG7Am4CnvCfgF87fKOviUtw78157ppOBa
         8UumSqOlTfMO4CTuLQWHX8Iqs2xbHRgzlFH1md+0GaGmfsCBLaa6xVQZ+KhG1bgBVe0i
         Vn6hJrea52mvxifQYAdQI9GBObHZEXwHM2ZMAQ+dQAI8bDYhC17Je5n5fxE6Qj+12X7u
         +o2w==
X-Forwarded-Encrypted: i=1; AJvYcCVvr7oO5ZVa3xPP8ix7mVMcuqq1YWipyG/PnkkB7r1dMpA7ajpm3CRli7NoGbbddztsF3KK2T0WyL8Jevr+fdyF/CFBTkQIGpyk2fst
X-Gm-Message-State: AOJu0YxaShM8Q0m+ct5Xg+P9JX0bCrVkK5LZKZK9y12/YuxQJVr05jWF
	QI6toPg+/1VIzB4k0rf40Sw2DbBTZktHvreesan8fqgQ2hi1WSHr
X-Google-Smtp-Source: AGHT+IEQdu2QCJ4U6dHZzIuBvtrXQX4sqfQlVOmgR+JNE/452zX3Kbjl/yakBXrQ0eLCJIyrpp6kWQ==
X-Received: by 2002:a05:6a20:2d0c:b0:1a3:65af:9baa with SMTP id g12-20020a056a202d0c00b001a365af9baamr10634895pzl.62.1713782344238;
        Mon, 22 Apr 2024 03:39:04 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e33b-6ac4-2bfb-4656-8624-cdbd.emome-ip6.hinet.net. [2001:b400:e33b:6ac4:2bfb:4656:8624:cdbd])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001e3dff1e4d5sm7807904plh.135.2024.04.22.03.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:39:03 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V15 18/22] mmc: sdhci-uhs2: add add_host() and others to set up the driver
Date: Mon, 22 Apr 2024 18:37:41 +0800
Message-Id: <20240422103745.14725-19-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422103745.14725-1-victorshihgli@gmail.com>
References: <20240422103745.14725-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a UHS-II version of sdhci's add_host/remove_host operation.
Any sdhci drivers which are capable of handling UHS-II cards must
call those functions instead of the corresponding sdhci's.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V14:
 - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
   __sdhci_uhs2_remove_host().

Updates in V13:
 - Re-order function to avoid declaration.
 - Use vqmmc2 to stead vmmc2.

Updates in V11:
 - Remove unused ocr_avail_uhs2.

Updates in V10:
 - Move some definitions of PatchV9[05/23] to PatchV10[20/23].

Updates in V8:
 - Change return type to void for __sdhci_uhs2_add_host_v4().
 - Remove unused variables in __sdhci_uhs2_add_host_v4().

Updates in V7:
 - __sdhci_add_host() to instead of __sdhci_uhs2_add_host()
   in sdhci_uhs2_add_host().
 - Cancel export state of some functions.

Updates in V6:
 - Add complete_work_fn/thread_irq_fn variables in struct sdhci_host.
 - Use complete_work_fn/thread_irq_fn variables in
   sdhci_alloc_host() and sdhci_uhs2_add_host().
 - Use sdhci_uhs2_mode() to simplify code in __sdhci_uhs2_remove_host().

---

 drivers/mmc/host/sdhci-uhs2.c | 98 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  2 +
 drivers/mmc/host/sdhci.c      |  7 ++-
 drivers/mmc/host/sdhci.h      |  3 ++
 4 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 71c169a8b306..310a8d18c2f4 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -16,6 +16,7 @@
 #include <linux/bitfield.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
+#include <linux/regulator/consumer.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -1162,6 +1163,103 @@ static void __exit sdhci_uhs2_mod_exit(void)
 }
 module_exit(sdhci_uhs2_mod_exit);
 
+/*****************************************************************************\
+ *
+ * Device allocation/registration                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+static void __sdhci_uhs2_add_host_v4(struct sdhci_host *host, u32 caps1)
+{
+	struct mmc_host *mmc;
+	u32 max_current_caps2;
+
+	mmc = host->mmc;
+
+	/* Support UHS2 */
+	if (caps1 & SDHCI_SUPPORT_UHS2)
+		mmc->caps2 |= MMC_CAP2_SD_UHS2;
+
+	max_current_caps2 = sdhci_readl(host, SDHCI_MAX_CURRENT_1);
+
+	if ((caps1 & SDHCI_CAN_VDD2_180) &&
+	    !max_current_caps2 &&
+	    !IS_ERR(mmc->supply.vqmmc2)) {
+		/* UHS2 - VDD2 */
+		int curr = regulator_get_current_limit(mmc->supply.vqmmc2);
+
+		if (curr > 0) {
+			/* convert to SDHCI_MAX_CURRENT format */
+			curr = curr / 1000;  /* convert to mA */
+			curr = curr / SDHCI_MAX_CURRENT_MULTIPLIER;
+			curr = min_t(u32, curr, SDHCI_MAX_CURRENT_LIMIT);
+			max_current_caps2 = curr;
+		}
+	}
+
+	if (!(caps1 & SDHCI_CAN_VDD2_180))
+		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
+}
+
+static void __sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
+{
+	if (!mmc_card_uhs2(host->mmc))
+		return;
+
+	if (!dead)
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
+}
+
+int sdhci_uhs2_add_host(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	int ret;
+
+	ret = sdhci_setup_host(host);
+	if (ret)
+		return ret;
+
+	if (host->version >= SDHCI_SPEC_400)
+		__sdhci_uhs2_add_host_v4(host, host->caps1);
+
+	if ((mmc->caps2 & MMC_CAP2_SD_UHS2) && !host->v4_mode)
+		/* host doesn't want to enable UHS2 support */
+		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
+
+	/* overwrite ops */
+	if (mmc->caps2 & MMC_CAP2_SD_UHS2)
+		sdhci_uhs2_host_ops_init(host);
+
+	host->complete_work_fn = sdhci_uhs2_complete_work;
+	host->thread_irq_fn    = sdhci_uhs2_thread_irq;
+
+	/* LED support not implemented for UHS2 */
+	host->quirks |= SDHCI_QUIRK_NO_LED;
+
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto cleanup;
+
+	return 0;
+
+cleanup:
+	if (host->version >= SDHCI_SPEC_400)
+		__sdhci_uhs2_remove_host(host, 0);
+
+	sdhci_cleanup_host(host);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_add_host);
+
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
+{
+	__sdhci_uhs2_remove_host(host, dead);
+
+	sdhci_remove_host(host, dead);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_remove_host);
+
 MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
 MODULE_DESCRIPTION("MMC UHS-II Support");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index beef08db0a16..42f34ca75275 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -183,5 +183,7 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
 u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
+int sdhci_uhs2_add_host(struct sdhci_host *host);
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 43f98a1ff7e2..fe2a70310fa6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4106,6 +4106,9 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->max_timeout_count = 0xE;
 
+	host->complete_work_fn = sdhci_complete_work;
+	host->thread_irq_fn    = sdhci_thread_irq;
+
 	return host;
 }
 
@@ -4855,7 +4858,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 	if (!host->complete_wq)
 		return -ENOMEM;
 
-	INIT_WORK(&host->complete_work, sdhci_complete_work);
+	INIT_WORK(&host->complete_work, host->complete_work_fn);
 
 	timer_setup(&host->timer, sdhci_timeout_timer, 0);
 	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
@@ -4864,7 +4867,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_init(host, 0);
 
-	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
+	ret = request_threaded_irq(host->irq, sdhci_irq, host->thread_irq_fn,
 				   IRQF_SHARED,	mmc_hostname(mmc), host);
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 8a5e594c5281..91b52fca1002 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -626,6 +626,9 @@ struct sdhci_host {
 	struct timer_list timer;	/* Timer for timeouts */
 	struct timer_list data_timer;	/* Timer for data timeouts */
 
+	void		(*complete_work_fn)(struct work_struct *work);
+	irqreturn_t	(*thread_irq_fn)(int irq, void *dev_id);
+
 #if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
 	struct dma_chan *rx_chan;
 	struct dma_chan *tx_chan;
-- 
2.25.1


