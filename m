Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1135278099A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359699AbjHRKFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359687AbjHRKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:04:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE50420B;
        Fri, 18 Aug 2023 03:04:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-689f4fb1c29so528968b3a.0;
        Fri, 18 Aug 2023 03:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692352985; x=1692957785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ei7XNMDznm4gQAPUvGl27pd9IQStOyHk63FGnzmJMW8=;
        b=XrM/qJGkbel1RCG3De4AztvK9DE7zha1o1KJx9YjloI0houUgkDZJUznZhvuQaLr5p
         WcUkPn+pJfafmAxC/2TjZQ+z6iTzQfXFtl+CS6doRLWoQRO50AuXTapdr3IQdx6QWonY
         kkfvLczMoejefRlJDpJK12asuG9lpo2Yh6iRAvbCo5G4zycAdpVsb6QL6/x7qHtQHi+G
         OmuJNV4NbiAcK5zUNCqqARmKGlgZJWXHOIZOM1amVAPkA22FjdrrqKGlXw2CGQRD7Xsd
         JE15j0gJIUWnVGRd5tto+RVFwZ7fUZNgecwC3VRFJCxBnkKtJmxt/Ny25RLTK2s4RZFJ
         y1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352985; x=1692957785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ei7XNMDznm4gQAPUvGl27pd9IQStOyHk63FGnzmJMW8=;
        b=VzSAM/Uqh/CCdfdq5SO3bHNJhgi+6ECB0OebUv9lQfsPG40rGOhBEyZwK1P0m05OEN
         xvmUODwwyJS0lEVzdqQVkKbrruzXEu1duBhRu4oQPfmyTEvpWMagZWQDMyCBZteI6197
         Ta4gNuI8l2yIFPn2yS/KFrt5Alprtz3NJK6BJbPhR47DECyAX8uTxV7MOSb84d9hb8OL
         k8NtUud1XysaU3H4a7aSEMGturhhQwK1Ph842fXICydBfIrj9yaBNzrdSw0elQwOQjk0
         s6rYNsv6uqfbzlGDv+xHnDGBTUmZa6i9vO8/425ZCkWXP4T+LQZPbBXb2WqOamsE+Mjo
         aoYA==
X-Gm-Message-State: AOJu0Yxziz1Cz0zkYRPIYgQibupg/J+6zMmujsUcZFYOXXENemamT7ie
        WRnuzpfZnMJXNGhUR6SPEKg=
X-Google-Smtp-Source: AGHT+IF2Sy7vLbQCBNdiBSTHz8lCRNxIUBQmPFJHq+rCcw6393vcnFkKnU2ySc/XX/k4GzwGBx57Ug==
X-Received: by 2002:a05:6a20:72a6:b0:133:38cb:2b93 with SMTP id o38-20020a056a2072a600b0013338cb2b93mr2493649pzk.9.1692352984915;
        Fri, 18 Aug 2023 03:03:04 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-55ec-ad14-f925-5202-a39b.emome-ip6.hinet.net. [2001:b400:e25c:55ec:ad14:f925:5202:a39b])
        by smtp.gmail.com with ESMTPSA id n22-20020a62e516000000b006870ccfbb54sm1180649pff.196.2023.08.18.03.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:03:04 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V10 12/23] mmc: sdhci-uhs2: skip signal_voltage_switch()
Date:   Fri, 18 Aug 2023 18:02:06 +0800
Message-Id: <20230818100217.12725-13-victorshihgli@gmail.com>
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

For UHS2, the signal voltage is supplied by vdd2 which is already 1.8v,
so no voltage switch required.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Updates in V5:
 - Use sdhci_uhs2_mode() to simplify code in
   sdhci_uhs2_start_signal_voltage_switch().

---

 drivers/mmc/host/sdhci-uhs2.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index fc37a34629c2..92fb69b7e209 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -142,6 +142,27 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
 	}
 }
 
+/*****************************************************************************\
+ *                                                                           *
+ * MMC callbacks                                                             *
+ *                                                                           *
+\*****************************************************************************/
+
+static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
+						  struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	/*
+	 * For UHS2, the signal voltage is supplied by vdd2 which is
+	 * already 1.8v so no voltage switch required.
+	 */
+	if (sdhci_uhs2_mode(host))
+		return 0;
+
+	return sdhci_start_signal_voltage_switch(mmc, ios);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -150,6 +171,9 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
 
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
+	host->mmc_host_ops.start_signal_voltage_switch =
+		sdhci_uhs2_start_signal_voltage_switch;
+
 	return 0;
 }
 
-- 
2.25.1

