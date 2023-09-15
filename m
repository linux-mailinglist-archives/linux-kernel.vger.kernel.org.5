Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8675F7A1B09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjIOJpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbjIOJo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:44:57 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E812D47;
        Fri, 15 Sep 2023 02:44:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c09673b006so15393185ad.1;
        Fri, 15 Sep 2023 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771066; x=1695375866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gT4GYvp7XZLzsi+yWOCwdJmnYZ/3FfZ/O3XhWmznl5k=;
        b=McJTJW/DgZqiauDdbigcinWre/ZxzJLeQXfnysdTODs20OGva3XbBMk1IR8XujRw67
         WfQ9KKYLPKB7p0i+xG6jaZDddD6xznbAyA63D+t2xlPkglM6FiH4ZsfEtdQU8dLtUbjh
         LcolAGAka76OOZMEnd/26Ik3boEKwKo5jXAC0f32lCvGW97d332yYMhXjrJhIwUGGVn0
         Mb/Z2a1lT/sgjqTsQU/o73MqWnLkdIqWPcsJLhf+rC38V62M8Tt0hp+/h2CUrkdgzMWZ
         eRx9yVamcqlqnRlBOuHT+NXyJqAE3J+7udYSqonvcP0wCfZ/hlN9xFW+P1kOnljEcxSM
         KgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771066; x=1695375866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gT4GYvp7XZLzsi+yWOCwdJmnYZ/3FfZ/O3XhWmznl5k=;
        b=WkiKFC7jMWHZdllbS6IVPGAXmwdbFwqTBDmfl09T17jrMwV5qhxzkHlCu4AYRJRTEq
         K8dPuUDLCVDB9pttmo+vWoyl3H4NVBuXKnsWKxQI6wWwxsRsZmZsbFZXwKy4LTt9W5BZ
         3VadwSETJVH9+g84xam5c8u47+Gn3OIyljWSgFgQZ11AI5tNHlAQwGIMtpkcFbbzp5GW
         laVMpjjgkw0YeUb/OEkUqIsnjCs0sViQSqTv3+gAfIzrfuIY7X3Cb+Q1LvreTVVk8lbB
         Kud6eqfFrOuKH2eNH11qQaARI3K0j/u4+mVlUAPPRQSTFnC8vdLEihUrqfUPmg/oVMlT
         U9hg==
X-Gm-Message-State: AOJu0YxoIZU6OTupYsetRzZ98l12klXKXKT9ryvu1qmFRlgZGbpS9GZM
        bped3EfSV7d31k+uCoAy9OQ=
X-Google-Smtp-Source: AGHT+IEN8vuo/MVQv511P5FB7UnpQgjDmOORfbt4cysY9o+Yuk8cYWcJD3KCs9N3sHSZOudl0JKNFQ==
X-Received: by 2002:a17:90a:7483:b0:273:f584:40ca with SMTP id p3-20020a17090a748300b00273f58440camr865489pjk.16.1694771065891;
        Fri, 15 Sep 2023 02:44:25 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e2a6-6d77-d32f-f490-6688-3d32.emome-ip6.hinet.net. [2001:b400:e2a6:6d77:d32f:f490:6688:3d32])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090a530400b0025023726fc4sm4432794pjh.26.2023.09.15.02.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:44:25 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V12 10/23] mmc: sdhci-uhs2: add reset function and uhs2_mode function
Date:   Fri, 15 Sep 2023 17:43:38 +0800
Message-Id: <20230915094351.11120-11-victorshihgli@gmail.com>
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

Sdhci_uhs2_reset() does a UHS-II specific reset operation.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Updates in V8:
 - Adjust the position of matching brackets.

Updates in V6:
 - Remove unnecessary functions and simplify code.

---

 drivers/mmc/host/sdhci-uhs2.c | 45 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index e339821d3504..dfc80a7f1bad 100644
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
@@ -49,6 +51,49 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
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
+	return host->mmc->flags & MMC_UHS2_SUPPORT;
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
+	unsigned long timeout;
+	u32 val;
+
+	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
+
+	if (mask & SDHCI_UHS2_SW_RESET_FULL)
+		host->clock = 0;
+
+	/* Wait max 100 ms */
+	timeout = 100000;
+
+	/* hw clears the bit when it's done */
+	if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
+				     timeout, true, host, SDHCI_UHS2_SW_RESET)) {
+		pr_err("%s: %s: Reset 0x%x never completed.\n", __func__,
+		       mmc_hostname(host->mmc), (int)mask);
+		pr_err("%s: clean reset bit\n", mmc_hostname(host->mmc));
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

