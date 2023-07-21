Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A75675C460
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGUKQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjGUKQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:16:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6401830F5;
        Fri, 21 Jul 2023 03:15:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b852785a65so12742225ad.0;
        Fri, 21 Jul 2023 03:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689934504; x=1690539304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrhnPYVVEOXhcGUIlQiYMK3xWKJ+IT6xWZbZF9JpGsE=;
        b=oNe5fTzlTyIkjHKhCVUDLn812lys3fEawVuUMM7mlDn6Rw9Bvqwi8QLMuPQHraazYa
         Sk3O51eIyDxtGVVyEKqTIirb9NMd6i2RD4vW4z++Qnkbi9zMjHNSJ1aJIo50OoiEwWdD
         DFXyOdoA7kKfRsz1riUNXVPLzZh5UdjBgfYuQaJUWD4lqN5fTqS8ho43fvWNiTC9Kr6R
         /Dp6+za1MGYSNSuM6g7AcI+QygwBfg8C8QKyyG+q1eP1aPWRrZ0clFCdNBjEreESBXBW
         ONdwHUaMDsULsnlmCEljaEdpDwkh6U87AnBlzdJovOukFDxR5Ebbq677k9yoJBaAegMp
         9/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934504; x=1690539304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrhnPYVVEOXhcGUIlQiYMK3xWKJ+IT6xWZbZF9JpGsE=;
        b=jbQcYxF7RWQ5E8rtwnoadxxehiDv22tfLqSi5jNOaXpnJCYEOiaPZbrxwvsUEiM39c
         EZITQgpouBBIgK3T9K63sAET6emaVDqwWi/J3vs5FxhsSI8QSOixcPVRE/P+CYMXOR7r
         f+yXjKsOrOahRyvXhe9GnRTtX0plzx3bJn+oNYvlNzF5urkxaraMfikEjfxJI5jtTIjE
         LmTUyz9Tr1k4RfuEhNR8huIPqVQd+dHKB90XzqAIeKirSzARQ7xLIwafDzD4CPcDTghi
         1cw5oj5X0QGgJgQ573AXVo3Xw5EkQ/YIL/uHuVZS+5m/IQPpCr9Q48B+IVU34qwDhplc
         dDVg==
X-Gm-Message-State: ABy/qLa1vKPh0nD+OVJiJzLWc0dS+YQjhebO/Ep3VhO3z8hEdSmDszFN
        urBO7xXYXYIUv2n1HL2X9kA=
X-Google-Smtp-Source: APBJJlGUcz9y6+POFsU77/3YhIB+pvH7oXPvJ41q2MfCq9NU8zAHnSZNo8skVMV0nuxuEJrflpBirw==
X-Received: by 2002:a17:902:ea0a:b0:1b0:3d03:4179 with SMTP id s10-20020a170902ea0a00b001b03d034179mr1901228plg.6.1689934504401;
        Fri, 21 Jul 2023 03:15:04 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e23e-6b0d-6c46-3684-497a-06ee.emome-ip6.hinet.net. [2001:b400:e23e:6b0d:6c46:3684:497a:6ee])
        by smtp.gmail.com with ESMTPSA id y1-20020a170902b48100b001b86492d724sm3050719plr.223.2023.07.21.03.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 03:15:04 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V9 16/23] mmc: sdhci-uhs2: add clock operations
Date:   Fri, 21 Jul 2023 18:13:42 +0800
Message-Id: <20230721101349.12387-17-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721101349.12387-1-victorshihgli@gmail.com>
References: <20230721101349.12387-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

