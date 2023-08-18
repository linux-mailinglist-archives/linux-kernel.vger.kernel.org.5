Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B817809A4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359786AbjHRKFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359715AbjHRKEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:04:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2EE4230;
        Fri, 18 Aug 2023 03:04:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68730bafa6bso1299018b3a.1;
        Fri, 18 Aug 2023 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692352996; x=1692957796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foX0JP3DAWSOOC0u2+6IXCRMxX6qZKC8TnZGDqevErY=;
        b=pMdaastHeHp4zkrbaws4PDJgxPOKKMXqAuI+XcLKJ3GbjF7oHXB1pbudIPhrxhcZhH
         q3ksThEzFRlH40akvA8nWShW6BUSsfrxqpwFpUU8wiqO1aV+adyaH7Kcc0RmEfFgrE3v
         hnVjvrujgt81kqeLHyHIxrocFDIiuWJEj4Ju+YyLGjbeVJuyJcajLoX4oTXUJGKW4+Jr
         Q5XZPHrdXNkj4tyonxy7w2fJY7TDRbMsUq2W6aAGG5FJ6clZZ6IHF4wATI/JXjVD49XK
         3kf2s2T8HnrkyaSjNlbdvdQ/N2B64QXl/GsCFe199uzJEeQNbzjwk5IOxYpazpJsojVs
         iv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352996; x=1692957796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foX0JP3DAWSOOC0u2+6IXCRMxX6qZKC8TnZGDqevErY=;
        b=QcXuT3rIHJzy6EYq3ir2+kWHIWD8OC/b27f4Kycvnp70DHTy6wEZRUUXCf7xdaAJ+H
         M7iiVe7i2NMlwaIhLl5Sv6gAdO3aBo+XzK+ug63WQKzM2PGwwFO977ozOnjowa5NfUik
         pEkz+OO4+viExVlJrLKrdDZXHwOPBtrwgsGLPrS21RAzBUaNvTyS/4YuEHYGZwzhGzc8
         wT2NvLT1RyvpVXBrcUcFdGujg7e0XqzfN2TKCpG5jsjN9ohfRitJmJWeX/r/UJvc2UjF
         meMPV6EjFK0kFTeb5fQ4ICw/us1qg3HZSRO+VSDO1tHCrQqWMv8LIqPPR6nbBTIFflLs
         ACRQ==
X-Gm-Message-State: AOJu0YyS6Bv+qkGFGLvxVwr3tCzwKxdBp/mOgyT1uyPswy9u6DzFMJO8
        op0tIORbdYqVaA1bqxEZgCA=
X-Google-Smtp-Source: AGHT+IET29a6mLrqFCqU7KT8X7n7iuodkl+ZR936rv2hmZ5HcXGgipwgDNNy6lh7/rA3NfV9O4OFvA==
X-Received: by 2002:a05:6a20:2584:b0:13e:2080:ab91 with SMTP id k4-20020a056a20258400b0013e2080ab91mr2273720pzd.28.1692352996520;
        Fri, 18 Aug 2023 03:03:16 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-55ec-ad14-f925-5202-a39b.emome-ip6.hinet.net. [2001:b400:e25c:55ec:ad14:f925:5202:a39b])
        by smtp.gmail.com with ESMTPSA id n22-20020a62e516000000b006870ccfbb54sm1180649pff.196.2023.08.18.03.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:03:16 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V10 16/23] mmc: sdhci-uhs2: add clock operations
Date:   Fri, 18 Aug 2023 18:02:10 +0800
Message-Id: <20230818100217.12725-17-victorshihgli@gmail.com>
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

