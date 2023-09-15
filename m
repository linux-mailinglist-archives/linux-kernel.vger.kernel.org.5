Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05D37A1B10
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjIOJpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbjIOJpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:45:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F702113;
        Fri, 15 Sep 2023 02:44:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2749b3e682aso351018a91.2;
        Fri, 15 Sep 2023 02:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771071; x=1695375871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ei7XNMDznm4gQAPUvGl27pd9IQStOyHk63FGnzmJMW8=;
        b=XQ/QlW9xzottiLbQOwEW3wQ9x4pZp1Sgrmxgqnw55W0//MlRKcpEIVXCZt1T+lFCYm
         5B6mUC7rWiZfG6sMxpa8fQI8o2EFUklhn1go7hScLKeVRMd9T9kkxSq1gs4ydgtA2jWY
         TghRSSyzLXdtuErlOxpWuS2vpHIBB+CfoiqFt6a4xLdnRDiXMOFMKh7S4meQ3Vr6kpzX
         zYLCr0LoDHKGOItRtKPKioDTzMSX1uiPq8z3l4IUz8EIlK5b3lBtnZxkdZRfBjxBOL0e
         fxaqWhB2nx3ty4ZtAkbZH+51jOrbQW//emF5VXYjGpX49jnyergSZ5ohKmoSOfqK2so1
         a7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771071; x=1695375871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ei7XNMDznm4gQAPUvGl27pd9IQStOyHk63FGnzmJMW8=;
        b=dxIH+p7141BktG0a111Wcw0/EdCN2rbJfbAagOS3wHLrmWE7mRsXdo3Y3a++7YrWvc
         kvdlPuH9I+poek8IttbCfUAVgcyGSOuvuzCN5Y0zORlsZ37XayTKrgF16sMH8f/+vvqV
         16n6GzGiFj/TJEbk7Q57bhL4eF83P/QtJ8fQTxKiOB6kFFc3lCTQ0CCd3CY7/FIvSDJL
         ToGyKXq2PUnkkk/J43aiVYbT/cVNesBA9mKtfaGU6TfvUCiIPvMlI5X7j0zTLNGwTWnJ
         zJDC95X1B4w5TJghYfk4o2+OcgqIiQd7eUbgpYHWnMdiEEx7o8iiiT6HJUorRWqsxNdq
         p4nQ==
X-Gm-Message-State: AOJu0YykWJd5a18QhiVrUFZvDd8IMY809/90SO8xERyjr1hmBUjjWS2K
        1T15OmeYpicyzjKDEaA5cwg=
X-Google-Smtp-Source: AGHT+IFcnZRClPj5ni9xMc1Wl7WS2pyXZJyykfq0IL++9JIYQZ0v2Pt6n0tpsxPSiRm3ip17KgURFg==
X-Received: by 2002:a17:90a:2f26:b0:26d:416a:d9d2 with SMTP id s35-20020a17090a2f2600b0026d416ad9d2mr932358pjd.45.1694771071545;
        Fri, 15 Sep 2023 02:44:31 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e2a6-6d77-d32f-f490-6688-3d32.emome-ip6.hinet.net. [2001:b400:e2a6:6d77:d32f:f490:6688:3d32])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090a530400b0025023726fc4sm4432794pjh.26.2023.09.15.02.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:44:31 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V12 12/23] mmc: sdhci-uhs2: skip signal_voltage_switch()
Date:   Fri, 15 Sep 2023 17:43:40 +0800
Message-Id: <20230915094351.11120-13-victorshihgli@gmail.com>
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

