Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C87780991
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359655AbjHRKE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359648AbjHRKEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:04:25 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A973AAE;
        Fri, 18 Aug 2023 03:04:02 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68879c7f5easo609522b3a.1;
        Fri, 18 Aug 2023 03:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692352979; x=1692957779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gT4GYvp7XZLzsi+yWOCwdJmnYZ/3FfZ/O3XhWmznl5k=;
        b=U+p2OhiE1L6qaZeexiUtXBnBFPKG4ksbUP1c29G/427vrenek/QRV1grXiyB73hU8A
         G6rDeJqh38F7iccrH4NwsliiWjusSQu5QIB4xcrI3G8gmsLAA+QVNFBJJSoyrbu+k9Ew
         /XxxR93fNaWxD6FBIR1m8gyrkPnsnpmnfccGmANb8Okfz2KvrAZYG5cv1Z1MXSLqwARK
         CS24nm+cHSaU7PuEIonF/nF254KGLwih/XRPuln7mZK+gAXaEx3jWs4Gg2GiXv/DaOdG
         IUIpERLcuwUmzEF6YCrpX91TfEzBtrAD4HjG0XzsnnXow4wc85M94HEuxDVkYvw+8qAI
         Y/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352979; x=1692957779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gT4GYvp7XZLzsi+yWOCwdJmnYZ/3FfZ/O3XhWmznl5k=;
        b=i9xlNmKI44f0MJdmHDc1NR2N8aEBVKb5LEFktDU4PJ1BeqhliF6FD51ZuCtiU8h/4k
         69ZVl1sjLq8rFAaktsEV78Ii/qyqV2iDvuEc6ViG4kd7eLGfHvuoQ61qyGq9MLWS5JcR
         neCADciRUZvWVnnqsQWIusDPltKzsvoLVQ8FnkAwSHittZtgIv35Y5hk9yEAzXAkZqCp
         wArWYjrZD+joxqj7nX5Gifb2ZiXvlQ/R4rinj+s5vS8yeeiELUSY27XAD4IWXJ32ssx6
         oRy9jAMca+j5Zgz1WDHz5ZQWStDwH1BI0qCjlbB4Q7CcxFjn6LhO3UVKlXOng7OlteCf
         /F5A==
X-Gm-Message-State: AOJu0Yw4GfL3KcpTkBTpSwbht1UtK5YoxDbf9Nl41mgMepbzquREykiJ
        cS3Xd6fM71fmww0hUaalYa+aQg5G0rs=
X-Google-Smtp-Source: AGHT+IERxivIbsXffMazqWEewX6siFlRE969bCYRVd3afQdWQedLpx2sZ4tjMbWEY9I0A0e98VLbDA==
X-Received: by 2002:a05:6a20:f38a:b0:130:7803:5843 with SMTP id qr10-20020a056a20f38a00b0013078035843mr2399693pzb.4.1692352978881;
        Fri, 18 Aug 2023 03:02:58 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-55ec-ad14-f925-5202-a39b.emome-ip6.hinet.net. [2001:b400:e25c:55ec:ad14:f925:5202:a39b])
        by smtp.gmail.com with ESMTPSA id n22-20020a62e516000000b006870ccfbb54sm1180649pff.196.2023.08.18.03.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:02:58 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V10 10/23] mmc: sdhci-uhs2: add reset function and uhs2_mode function
Date:   Fri, 18 Aug 2023 18:02:04 +0800
Message-Id: <20230818100217.12725-11-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818100217.12725-1-victorshihgli@gmail.com>
References: <20230818100217.12725-1-victorshihgli@gmail.com>
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

