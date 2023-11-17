Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECD47EF1D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345996AbjKQLdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346062AbjKQLcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:32:53 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECB41BD8;
        Fri, 17 Nov 2023 03:32:33 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2e4107f47so1239751b6e.2;
        Fri, 17 Nov 2023 03:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700220751; x=1700825551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z911V8NmEMY0vpbk9U80PyNddEOopXpE6TaT4ighhqU=;
        b=C8REY6km6orgNID9bPoadHCgcuD42Woqar+RPnpK3hwQH5KBFPY4HcLog4p52rpG8w
         9eFjQ7oD3l+VGZ3ICl9NrofeRMjCM5KBIh8XRWN1BTf8bqZIhgkaX9wh3Kq1gZCQurhD
         NqyPoNgnJkyDndDUk1iLe4wq4t64T1BOjy33XRe/TtkC/xt1Ae2nQtrTmRegBjyoDJuL
         VFZofIfIJPR1+qdtCVkP2kgGZwJPNu7CghluI0PMLD/xsoCLcK60FmlnGGOz4Sru3tpk
         qthLjzTQC20rjaAsuDO0Hk0nbNUXwdSI9pogTV/yC0s2xMJ4CgttAiSk2+99sTA/9RWR
         yfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700220751; x=1700825551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z911V8NmEMY0vpbk9U80PyNddEOopXpE6TaT4ighhqU=;
        b=BhkvwW5aVsDYqkO5jdbUJQb/H8zwRiZBoJXAfNKTvrXVNTLQVPJWGKnTSdc8jKKDRG
         hN4/VAlblpx/BW+1OZ1fxiVvDgFuresDi0O/hahR6O/5FQqmu0+WY4yg2GhmHChzxTiI
         EqLd+NGEfuknot7rlV5ays0Dyy2kFCUEfD8jPmvudKMHxKPN2c0cgE73CDi5CvJgBEWC
         8Qu07XWJqNrijTL7Z9OZLnjCpXvDMFavBvz9kfLlIgVH1teZQgXQ3sHRJwJaYDnZuSOT
         frsjE73/lvsaCKB1xew+acX/ZLstamnM8GzZWQsIGTUu6gRo6b5w9f4ccQ3JzDCsOkDw
         x7QQ==
X-Gm-Message-State: AOJu0Yz79F1AZaJs+glkZY3gHGQpcZpClERtSIXVDt1+oyhplfJNf5rL
        CcpoeW7iSxKGJFivEt74Grc=
X-Google-Smtp-Source: AGHT+IG5djO8LWzy+cSy8fQri7k0arPeiWYLZeS93fdehv87600+2snneyrR16K71fE6bq3m5NBepg==
X-Received: by 2002:a05:6808:319a:b0:3b6:d844:144 with SMTP id cd26-20020a056808319a00b003b6d8440144mr24391506oib.28.1700220751615;
        Fri, 17 Nov 2023 03:32:31 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e286-d458-bc89-d4cd-bd42-ffb5.emome-ip6.hinet.net. [2001:b400:e286:d458:bc89:d4cd:bd42:ffb5])
        by smtp.gmail.com with ESMTPSA id u2-20020a631402000000b005b4b70738e5sm1229224pgl.8.2023.11.17.03.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 03:32:31 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V13 11/21] mmc: sdhci-uhs2: add reset function and uhs2_mode function
Date:   Fri, 17 Nov 2023 19:31:39 +0800
Message-Id: <20231117113149.9069-12-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117113149.9069-1-victorshihgli@gmail.com>
References: <20231117113149.9069-1-victorshihgli@gmail.com>
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

Sdhci_uhs2_reset() does a UHS-II specific reset operation.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V13:
 - Use ios timing to stead MMC_UHS2_SUPPORT for indicate the UHS2 mode.

Updates in V8:
 - Adjust the position of matching brackets.

Updates in V6:
 - Remove unnecessary functions and simplify code.

---

 drivers/mmc/host/sdhci-uhs2.c | 45 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index e339821d3504..ef6f02583d61 100644
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
 	if (!(sdhci_uhs2_mode(host)))
@@ -49,6 +53,47 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
 
+/*****************************************************************************\
+ *                                                                           *
+ * Low level functions                                                       *
+ *                                                                           *
+\*****************************************************************************/
+
+bool sdhci_uhs2_mode(struct sdhci_host *host)
+{
+	return	host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
+		host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+		host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+		host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD;
+}
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
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 2bfe18d29bca..8253d50f7852 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -177,5 +177,7 @@
 struct sdhci_host;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
+bool sdhci_uhs2_mode(struct sdhci_host *host);
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1

