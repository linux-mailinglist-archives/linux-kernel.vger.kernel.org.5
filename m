Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF247A1B17
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjIOJps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjIOJpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:45:38 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1956B30EF;
        Fri, 15 Sep 2023 02:44:43 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-577f6205f42so1445820a12.1;
        Fri, 15 Sep 2023 02:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771082; x=1695375882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foX0JP3DAWSOOC0u2+6IXCRMxX6qZKC8TnZGDqevErY=;
        b=A/CJjLG2eR6JCiWFz2hsIwBqwkiZjXdDFjs9RF5bqrhkDpI+gf+LvMkERRJJG1od0w
         gOkqrOUa9U73aaN31+BCkm0bXOc5M4QWiVFJcajmE0WfHDR7r1ba/vzfQSG8M6CjcMyA
         ma54XhKjoMlRrzLM26RZcfcY2yOY4pYI1BQkMahqkUWScrL3I525BFy5zhk+1cPDbmqK
         hl9+5oV4xOy7vjeSF7ptLSFwUSibAZR9LambySRrF4dlxKbJgHTcQ4Ybr3CAXdN7tnso
         F5Taom4FDvOHX0yB9TzmdQ3XwmixwY97KFN9fO7pOxGaO6SpHMJPpGbHS4/Uefl5OvT6
         gUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771082; x=1695375882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foX0JP3DAWSOOC0u2+6IXCRMxX6qZKC8TnZGDqevErY=;
        b=JAmOVzlk8o9EjYuJtBlprqGiYnVxjT6ksXvhobL5yygcyDDWPRJIPJsaszp+JvLhkZ
         V8U2D1sJq9Ktos0ErRR7eWvRZQEQX4X2N3hrgg9+gXLIGcBi7N8ekqfwet/bui1WnmrU
         aTr5TaH3Ii/0Pg1Ct4HlSLwKbmULr5aRWxtFTTdZw3ZWn2jcGECiWQnAG+ks52b5mJYM
         m8rRp5KQvNGgwMfTazbd7PLI9RCPyY7syBNWjazXj2U3Keh3ZO7MidJbNGiKbobGIGte
         mETfh0tSG6he3RFmqifsZFIRrxyu5Kwfb3rv0wFqXokY/5WEFjC31KdYWsD0y2EnFc7r
         x7Rg==
X-Gm-Message-State: AOJu0YzyX3yrudr9DgVRZRn26X/GejN8uSrRECii9XCKBazYbAv04TSO
        ZVR7KDbB/m7/BSUWr/rlMWY=
X-Google-Smtp-Source: AGHT+IFzFkL/BBh9h/RFPIklVtebAe3TjTr1IBTVdRw0g81d173dR+rv7P6xjIeYF+C/GEXL9HhjNg==
X-Received: by 2002:a17:90a:1fc8:b0:26b:2538:d717 with SMTP id z8-20020a17090a1fc800b0026b2538d717mr907420pjz.25.1694771082557;
        Fri, 15 Sep 2023 02:44:42 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e2a6-6d77-d32f-f490-6688-3d32.emome-ip6.hinet.net. [2001:b400:e2a6:6d77:d32f:f490:6688:3d32])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090a530400b0025023726fc4sm4432794pjh.26.2023.09.15.02.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:44:42 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V12 16/23] mmc: sdhci-uhs2: add clock operations
Date:   Fri, 15 Sep 2023 17:43:44 +0800
Message-Id: <20230915094351.11120-17-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915094351.11120-1-victorshihgli@gmail.com>
References: <20230915094351.11120-1-victorshihgli@gmail.com>
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

