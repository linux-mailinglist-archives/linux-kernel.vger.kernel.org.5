Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B44798530
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242806AbjIHJzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbjIHJzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:55:42 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924591FC1;
        Fri,  8 Sep 2023 02:54:55 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-56b2e689828so1405597a12.1;
        Fri, 08 Sep 2023 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694166864; x=1694771664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foX0JP3DAWSOOC0u2+6IXCRMxX6qZKC8TnZGDqevErY=;
        b=JvblvJO2QJUV7r4NQgDUYNSD+47AiN24MARFBeFcvbmtjt6DF2miVIkhhPTB86G2A5
         JlwOBQY5m/CTNqKI5B+s5Qyry9nZ+4KoGNEiCchABnSw2AI/4OddEP8ffzUbQ3QCkEHf
         KaoNsngL7EzAWkbiOrdGCYPF9QfwGAmZkgIXQb/NXrSTv90lIkp2OuOZS51l1EYOe8lL
         SdLFcyLuQOtYYmqU7B7/qryKTovKKk0mRYcqxlfMLgD/AJhaPgg+yYcnjLxRu/mruRLC
         fTDFp4l5b7rLN+QDLaFc1GZ3n39kLSiIw04lLZ19CZ9xLXEMwxw+5bQOhObgWH6Ae4U/
         rHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694166864; x=1694771664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foX0JP3DAWSOOC0u2+6IXCRMxX6qZKC8TnZGDqevErY=;
        b=fjbvRXFQ83+a/6olmj6pHp604Aw4yJSNxTbcBvHODI8k6NuGEaDtVq8l7YsnQwiDPC
         YQXd9rQQWEFItT8caL1FkE2t6/WxbyVdt2Gg/3MMx9Ffl+M1UL+y3p/fk9pjELBXQY/W
         rYTXic6McO2MUL2RBoOEgdb/M5Boe4lD2Tb0T/oVQpo6H6FvH7Mlm8UMWYWJ+jd+LP3e
         AUYIWsPckRkBSELfWBJcHjNBuqPTHfz/TTOShw26ECHUmJDiSQP4GiKYquLKXI5IPsN6
         8ZxQJ9yh24muXNFstL2ynMZOtKChiXjRAzT6xc0hsB34OhtLgKhTMrsoL3M7wK4hb4/N
         q7ww==
X-Gm-Message-State: AOJu0Yyb3LdhhpF2rqhr3nMqCPf9jCKGVC6kY2riaboWZ2PUxr3sOh6d
        Xbz+k2+87O4aJxWxVX5UcVHY6VWiPhA=
X-Google-Smtp-Source: AGHT+IG2+kS4vtZmgB9s3/RN3rs15QAraRpLAZKbDv3xIsOai3UHoeLRNmbLMEKzs5ddn1d0CnxwtQ==
X-Received: by 2002:a05:6a20:ce83:b0:134:4f86:7990 with SMTP id if3-20020a056a20ce8300b001344f867990mr2141584pzb.3.1694166864095;
        Fri, 08 Sep 2023 02:54:24 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e3a1-00a4-a20b-46bc-ccec-3e79.emome-ip6.hinet.net. [2001:b400:e3a1:a4:a20b:46bc:ccec:3e79])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b001b892aac5c9sm1172178plg.298.2023.09.08.02.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 02:54:23 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V11 16/23] mmc: sdhci-uhs2: add clock operations
Date:   Fri,  8 Sep 2023 17:53:23 +0800
Message-Id: <20230908095330.12075-17-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908095330.12075-1-victorshihgli@gmail.com>
References: <20230908095330.12075-1-victorshihgli@gmail.com>
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

This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Updates in V8:
 - Remove unnecessary include file.
 - read_poll_timeout() to instead of read_poll_timeout_atomic()
   in sdhci_uhs2_enable_clk().
 - Put the comment on the end and put the lines in descending
   line length in sdhci_uhs2_enable_clk().
 - Modify return value in sdhci_uhs2_enable_clk().

Updates in V6:
 - Remove unnecessary functions.

---

 drivers/mmc/host/sdhci-uhs2.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 4c2a56629ab3..af1b0c5e48fd 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -329,6 +329,36 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
+static int sdhci_uhs2_disable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	return 0;
+}
+
+static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	int timeout_us = 20000; /* 20ms */
+	u32 val;
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	if (read_poll_timeout(sdhci_readw, val, (val & SDHCI_CLOCK_INT_STABLE),
+			      10, timeout_us, true, host, SDHCI_CLOCK_CONTROL)) {
+		pr_err("%s: Internal clock never stabilised.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return -EIO;
+	}
+	return 0;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
-- 
2.25.1

