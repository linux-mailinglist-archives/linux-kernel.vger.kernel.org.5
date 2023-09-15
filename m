Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BC37A1B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjIOJpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjIOJou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:44:50 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AD4271F;
        Fri, 15 Sep 2023 02:44:23 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5776089b652so1461438a12.2;
        Fri, 15 Sep 2023 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771063; x=1695375863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wVKElK4C2zJzSOfixf3qU5LUkfD56mObdk8BVSuhNg=;
        b=i7CCzKBOZUg4JXk/Ubfmqqjb6fiDXYDAqZ738bWDC38+EwixHSXnPdJoF2YYZD8eEY
         bPIutR54x8MB5laba/mhDNjeaqu30nuKSS6EIMHsD7HGnBqv5GXAdXuVbAPWqrWIwFHl
         Jw+LnwqhtD2DEBYdnbpOm//RQl6vLqRStsyce5jBuZyNda9QUsIq+YZfM4Hwec+P38QJ
         8vSKrCigwXCuOMxgwtE2Uzop5RlOqN9PPQkQIFFM6cyxlFho6o02ooZPFju/0ZccVQ5j
         I5QaydxmpkkzI/qGcwFMdbJ0iLrOykm1Azh5drNg3jDB4w9ZrQLUsb8XX9AAAUdj0yON
         zufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771063; x=1695375863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wVKElK4C2zJzSOfixf3qU5LUkfD56mObdk8BVSuhNg=;
        b=hBGffabsdUSEytZ9TIYgh9f3dv0zwBEU74gAypEwocqSoXPkXl+ZD5RB3e4cYoljcP
         rRoVUqx9zR4HxzsA8o8bb6KioA2xGvDoExlhg+PNUgyB9x5G8FXyzWSeeVpLgAVqrtuu
         2xallYWWM47FGT77/M+CHrrJuEvoligJnPwZoaEbdh5llG5jwKc+kGf5GByFnFkeFkhU
         qVYte+jCJjveUdn5mBvvckk8ZpqMrhwFEiDtPL/4SM4OYjcTHj9jPzyS2Yy0HnCNQ3JN
         7CigqdxriK14IlsnhiNu5wUCtbcVStj6QKLUq9GUE0OMwGwDc4ikDh/zNuhw/MgEMWYc
         JMzg==
X-Gm-Message-State: AOJu0YxDop0VSAHvIz10a7yk9lYAgGF8bG+vJ0RiGoQrsYkS3qAq57xC
        GD6K+Wa2pB0bBfItMgyZM+M=
X-Google-Smtp-Source: AGHT+IFuxU/EL6B1YhT0JsMsVOy+Sacf1HjJq9RAUKfweexAoY5zg4+pb3WZpyVRtdo0rQan0dRqLQ==
X-Received: by 2002:a17:90a:d712:b0:274:6f67:e7a8 with SMTP id y18-20020a17090ad71200b002746f67e7a8mr856608pju.45.1694771062989;
        Fri, 15 Sep 2023 02:44:22 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e2a6-6d77-d32f-f490-6688-3d32.emome-ip6.hinet.net. [2001:b400:e2a6:6d77:d32f:f490:6688:3d32])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090a530400b0025023726fc4sm4432794pjh.26.2023.09.15.02.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:44:22 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V12 09/23] mmc: sdhci-uhs2: dump UHS-II registers
Date:   Fri, 15 Sep 2023 17:43:37 +0800
Message-Id: <20230915094351.11120-10-victorshihgli@gmail.com>
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

Dump UHS-II specific registers, if available, in sdhci_dumpregs()
for informative/debugging use.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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

