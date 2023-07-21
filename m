Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E52675C44D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjGUKPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjGUKOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:14:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369641B6;
        Fri, 21 Jul 2023 03:14:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666eef03ebdso1179611b3a.1;
        Fri, 21 Jul 2023 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689934480; x=1690539280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULzAaFgqku6wJgdZ8lId2Hw2UrhRmPEliZUBzYK9qD0=;
        b=TwUiEsUbLWoSjRy4w1RiaF0o0vqWv4RCNoSja627sUWtoke9JnwveewGtUKyqoFAY5
         igrLqbFqIK8W+aNskxgsXFVaUousdB5KCEtVlr6E1TIoID0mAu0YOAoDPuqhSE0a2/1O
         ydsd8bE6wCOndpJvLLZjJhsSnJf+o+uBtX7BpZWfztbGKK0OXPcGlcdh2FB4Ol244TUq
         BqFu/iE4YtV69ibBFFogzMolcMQgrEi6+rRi6R/9ocjN/u9dEO3hxm8q3/84bSiO3en+
         dOP5lFsNtyGN1/qlWAP3rSeGBTfZYu9Oqoyq5LU5XqT5KzyBFm/fhYWspQwgI/vI8iI/
         AsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934480; x=1690539280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULzAaFgqku6wJgdZ8lId2Hw2UrhRmPEliZUBzYK9qD0=;
        b=U5JwVERf1QLBBee+x+D88cmLb8I4dyJ1lT3UWg6sRA+hVBLurZJzZQlimOtGnIy85G
         zsL3aJDSaqzFS6qH/8hQVL6kr+4pc727kVW8UM1moo57SGdMvc1E1TyHWlEi8hGhjWI2
         2sJffuA3GGxe1p6eE/Hi11ez7GJ/dx2Z5pkovmNK8DJZQNvR5s/e3086xaSe9yMCtqu9
         KDmtVHBr4BBTRd8E3kc9kjPv7EZmu8He5hXouOdplsRAUt1PlLiKWZO2MXtKV/zsOhUm
         JNXUFJrJHTA9t9VnhMYbA4V1YaY72qzCZsBScoTqgiGT1ADMbzDYCO1ivo9ZrX5lvPJo
         fNYw==
X-Gm-Message-State: ABy/qLaQMnassxKkIAjZ0HTRcIFYSabqtHi89w1ovfn4OrAMb6cTJI9N
        +NzBsXBSDV2Ub6nkogOgQRo=
X-Google-Smtp-Source: APBJJlG9oacRerzn6ZCiZNPGF2B3od0YmCYORDqspdjNcc+dA0sLqJR+38QAd1qHSBbKu01YkUgszw==
X-Received: by 2002:a05:6a20:2444:b0:126:43f7:e271 with SMTP id t4-20020a056a20244400b0012643f7e271mr1330945pzc.39.1689934480660;
        Fri, 21 Jul 2023 03:14:40 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e23e-6b0d-6c46-3684-497a-06ee.emome-ip6.hinet.net. [2001:b400:e23e:6b0d:6c46:3684:497a:6ee])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902b48100b001b86492d724sm3050719plr.223.2023.07.21.03.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 03:14:40 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V9 09/23] mmc: sdhci-uhs2: dump UHS-II registers
Date:   Fri, 21 Jul 2023 18:13:35 +0800
Message-Id: <20230721101349.12387-10-victorshihgli@gmail.com>
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

Dump UHS-II specific registers, if available, in sdhci_dumpregs()
for informative/debugging use.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V7:
 - Use sdhci_uhs2_mode() to simplify code.

Updates in V6:
 - Remove unnecessary code.

---

 drivers/mmc/host/sdhci-uhs2.c | 30 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  4 ++++
 drivers/mmc/host/sdhci.c      |  3 +++
 drivers/mmc/host/sdhci.h      |  1 +
 4 files changed, 38 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 608f8ad5aaed..e339821d3504 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -18,6 +18,36 @@
 #define DRIVER_NAME "sdhci_uhs2"
 #define DBG(f, x...) \
 	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
+#define SDHCI_UHS2_DUMP(f, x...) \
+	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
+
+void sdhci_uhs2_dump_regs(struct sdhci_host *host)
+{
+	if (!(sdhci_uhs2_mode(host)))
+		return;
+
+	SDHCI_UHS2_DUMP("==================== UHS2 ==================\n");
+	SDHCI_UHS2_DUMP("Blk Size:  0x%08x | Blk Cnt:  0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_BLOCK_SIZE),
+			sdhci_readl(host, SDHCI_UHS2_BLOCK_COUNT));
+	SDHCI_UHS2_DUMP("Cmd:       0x%08x | Trn mode: 0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_CMD),
+			sdhci_readw(host, SDHCI_UHS2_TRANS_MODE));
+	SDHCI_UHS2_DUMP("Int Stat:  0x%08x | Dev Sel : 0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_DEV_INT_STATUS),
+			sdhci_readb(host, SDHCI_UHS2_DEV_SELECT));
+	SDHCI_UHS2_DUMP("Dev Int Code:  0x%08x\n",
+			sdhci_readb(host, SDHCI_UHS2_DEV_INT_CODE));
+	SDHCI_UHS2_DUMP("Reset:     0x%08x | Timer:    0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_SW_RESET),
+			sdhci_readw(host, SDHCI_UHS2_TIMER_CTRL));
+	SDHCI_UHS2_DUMP("ErrInt:    0x%08x | ErrIntEn: 0x%08x\n",
+			sdhci_readl(host, SDHCI_UHS2_INT_STATUS),
+			sdhci_readl(host, SDHCI_UHS2_INT_STATUS_ENABLE));
+	SDHCI_UHS2_DUMP("ErrSigEn:  0x%08x\n",
+			sdhci_readl(host, SDHCI_UHS2_INT_SIGNAL_ENABLE));
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
 
 /*****************************************************************************\
  *                                                                           *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index e993f41ffb7f..2bfe18d29bca 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -174,4 +174,8 @@
 #define SDHCI_UHS2_EMBED_CTRL_PTR		0xE6
 #define SDHCI_UHS2_VENDOR_PTR			0xE8
 
+struct sdhci_host;
+
+void sdhci_uhs2_dump_regs(struct sdhci_host *host);
+
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ff41aa56564e..753b251179f2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -110,6 +110,9 @@ void sdhci_dumpregs(struct sdhci_host *host)
 		}
 	}
 
+	if (host->ops->dump_uhs2_regs)
+		host->ops->dump_uhs2_regs(host);
+
 	if (host->ops->dump_vendor_regs)
 		host->ops->dump_vendor_regs(host);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 4f23d54a7557..43ad3f4b7672 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -720,6 +720,7 @@ struct sdhci_ops {
 	void	(*request_done)(struct sdhci_host *host,
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
+	void	(*dump_uhs2_regs)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

