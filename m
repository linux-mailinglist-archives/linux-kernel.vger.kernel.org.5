Return-Path: <linux-kernel+bounces-153211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC08ACAF4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713CC282550
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC5914F9EC;
	Mon, 22 Apr 2024 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k02LErn6"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C914F9DE;
	Mon, 22 Apr 2024 10:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782318; cv=none; b=iMFwxIBcBG9Eulk7FuycNfrqi+KGUtmj3cJqhj9GZiaL4SnIhUyLj9mhyDao/UCv/kcXVu9+nSKvcoMDV2jRpNlacPfPalbfZj/uZYW1iOVEYHMtLKOdqC0qt1fSIfVEADwZVK2o/N2n4KJ2navaGO2yGO1VZPZHJt82oAGzCIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782318; c=relaxed/simple;
	bh=KRAq96z7KHe+hAYimZ0FQQxPhdvJrzNP8sGPPKi1V0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mLHHq5Ob9i8o8C9JPepxJJCJLUrSH5IJmri0gaaQQj+9tDB2zoOArxamjCRSdR/5Ug2Y1CdyVKaih/TH1IH0n5Dypcei/sZlwiwXD2hn7lagGQks3ZR6UB6albv7zTlTOrZFWdTEdnEvbmdrTn79qYdwmdzhE0v4lmnM+tL2xRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k02LErn6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ff57410ebbso701347a12.1;
        Mon, 22 Apr 2024 03:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713782316; x=1714387116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNW8WEJCG8m2Bvak7Z/O4O/Zw2vG3wxe0oZPywUhvrU=;
        b=k02LErn6jA/rCq7dQcmxrMncuSDHSlxQA1GKIp/RF3gELU24ylX5qrF4nZgtYB07fD
         HpC7s6yPMcWbXKeVHZmZUX9Zufa8pU1HQrWg6T3TkHp3UOstiW3f8OOEwe9Y0M2JadQH
         SoHLxKVB+42uj5MRITwvgXQEfZrtWQPXAXDVZi0sSW7NUl0MCSxhz4PwsSHzG7gXnV3i
         xoctw3gqQ8RtSzdaz0ACpBAZrn7s9FhzfqfAUNtlyKiSygnLEiR13eh9EY75b1W/HKPo
         mcsICWYthsm8FwcDcdMMh12z68qDw1tV1pvKWlklRWYl9JEQi8jx0WxU/eO+P9f/72mK
         FBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782316; x=1714387116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNW8WEJCG8m2Bvak7Z/O4O/Zw2vG3wxe0oZPywUhvrU=;
        b=o3SZM7NpyJfroTay+0CrJF27M/zqWlZc9zK7ftjhXJd2k6+HjzY+sebFcMSIHUi89m
         kpiwcGZiXgScovButVtTCvGTTgz01xKX7oO/GfSDPqBvuToWRcsJtAbUG3z7ZYAbPUvK
         RF048JGMR1SGiNqTsAok66wZYn299ru6xd+0k2FZ+4B786Out/H3uzCHwtzD1/dw7f6z
         MDpSRmp4R3tEIndEzbjHEdiGlCUv5WSBFE3AnsIGjjY/yBO4FOxzIK3i6qKqQy5+YFVb
         UnnsMRcBDw1eyXMxWEGymNYL6iAdmjqQFv/qh5BubGJMIm/HqR+yHyTtvI+vyvhiTdEL
         ojXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaTNQyCXD9gm4W7JLqUiReXHf7a17gbSQbjh2c8EA3nS2VOGRawpgheH41LaskNO7iZou+htZLBVS8amdYyiXBEc3PBz2j5V4Y4xx5
X-Gm-Message-State: AOJu0YwDYyKCAugol+oMytp4NcCQ1kkNOSqAX8Fl0A4FpiGqGI1uvWr3
	iCMBIzxwShyLd9VyMUAwesY3oWpsnIv1u6umLnMlXjY5qWvUza2dUcvQMUKC
X-Google-Smtp-Source: AGHT+IFR/wpWf7ZJ/YycXUK/EXdEt68jRSsxT7NWT4Bh4friPXdhnkg5S3qdvsep4GRAW9xiok6dEA==
X-Received: by 2002:a05:6a20:9484:b0:1a7:78d2:a142 with SMTP id hs4-20020a056a20948400b001a778d2a142mr8914723pzb.38.1713782316296;
        Mon, 22 Apr 2024 03:38:36 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e33b-6ac4-2bfb-4656-8624-cdbd.emome-ip6.hinet.net. [2001:b400:e33b:6ac4:2bfb:4656:8624:cdbd])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001e3dff1e4d5sm7807904plh.135.2024.04.22.03.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:38:35 -0700 (PDT)
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
Subject: [PATCH V15 11/22] mmc: sdhci-uhs2: add reset function function
Date: Mon, 22 Apr 2024 18:37:34 +0800
Message-Id: <20240422103745.14725-12-victorshihgli@gmail.com>
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

Sdhci_uhs2_reset() does a UHS-II specific reset operation.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V15:
 - Refer the SD Host Controller Standard Specification Section 3.10
   to add reset command data mechanism.

Updates in V14:
 - Since mmc_card_uhs2() is the same as sdhci_uhs2_mode(), so drop
   sdhci_uhs2_mode() and use mmc_card_uhs2() instead of sdhci_uhs2_mode().

Updates in V13:
 - Use ios timing to stead MMC_UHS2_SUPPORT for indicate the UHS2 mode.

Updates in V8:
 - Adjust the position of matching brackets.

Updates in V6:
 - Remove unnecessary functions and simplify code.

---

 drivers/mmc/host/sdhci-uhs2.c | 57 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  1 +
 drivers/mmc/host/sdhci.c      |  3 +-
 drivers/mmc/host/sdhci.h      |  1 +
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 9cb0f1b2a37d..7652158ea151 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -10,7 +10,9 @@
  *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/iopoll.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -21,6 +23,8 @@
 #define SDHCI_UHS2_DUMP(f, x...) \
 	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
 
+#define UHS2_RESET_TIMEOUT_100MS		100000
+
 void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 {
 	if (!(mmc_card_uhs2(host->mmc)))
@@ -49,6 +53,57 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
 
+/*****************************************************************************\
+ *                                                                           *
+ * Low level functions                                                       *
+ *                                                                           *
+\*****************************************************************************/
+
+/**
+ * sdhci_uhs2_reset - invoke SW reset
+ * @host: SDHCI host
+ * @mask: Control mask
+ *
+ * Invoke SW reset, depending on a bit in @mask and wait for completion.
+ */
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
+{
+	u32 val;
+
+	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
+
+	if (mask & SDHCI_UHS2_SW_RESET_FULL)
+		host->clock = 0;
+
+	/* hw clears the bit when it's done */
+	if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
+				     UHS2_RESET_TIMEOUT_100MS, true, host, SDHCI_UHS2_SW_RESET)) {
+		pr_warn("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
+			mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
+		sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
+
+static void sdhci_uhs2_reset_cmd_data(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+
+	if (host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+	    host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD) {
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+
+		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+		sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
+	}
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -57,6 +112,8 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
 
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
+	host->mmc_host_ops.uhs2_reset_cmd_data = sdhci_uhs2_reset_cmd_data;
+
 	return 0;
 }
 
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 2bfe18d29bca..caaf9fba4975 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -177,5 +177,6 @@
 struct sdhci_host;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 27ea5b875c29..f9db861853b4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -236,7 +236,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 }
 EXPORT_SYMBOL_GPL(sdhci_reset);
 
-static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
+bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
 {
 	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
 		struct mmc_host *mmc = host->mmc;
@@ -249,6 +249,7 @@ static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(sdhci_do_reset);
 
 static void sdhci_reset_for_all(struct sdhci_host *host)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 782c399fae15..47962cebee22 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -844,6 +844,7 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
 int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
+bool sdhci_do_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
-- 
2.25.1


