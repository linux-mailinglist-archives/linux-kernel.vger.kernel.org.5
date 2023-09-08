Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751A2798525
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242721AbjIHJzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 05:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242730AbjIHJzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:55:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649942123;
        Fri,  8 Sep 2023 02:54:52 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-56a8794b5adso1400707a12.2;
        Fri, 08 Sep 2023 02:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694166853; x=1694771653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ei7XNMDznm4gQAPUvGl27pd9IQStOyHk63FGnzmJMW8=;
        b=FYSUQRk+lKJ0vF1ignrm9aSbGj95BjBRxH198dxBjdOZRqPct2HoXnOlmAJiurPzNr
         jwQ67rThs5t/hWxXs+ETQJxllNcz0xTs2ioKSy2XQhNGUC75cG3vu7dIch2bKlrp16fw
         OG/sJb9vVfxQV49t+jemuY+X7JbOrBHNt82ymcLAqvWPmJ0Xunfy/76SzGHn0VtnNi9w
         2DYPd4HoUvYgqfEXLDQBEnS/YNi/MCn/ekIYJ6CtRnsyrjsHMTvouexW04x/vUeOzWVB
         UPW+X/pp7OLeG/Bf0qGjNX6kZYCRFnpBl/j/J3IwdWgK1CVq8Vod6q7A/Ger/kKpCQy/
         ap2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694166853; x=1694771653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ei7XNMDznm4gQAPUvGl27pd9IQStOyHk63FGnzmJMW8=;
        b=ao7T4jqdlIUAfYjcdilHxko6loG+7uxDKi6rEMiTCiFy91NZHwacgASnotVB2ANGs2
         lOPsK1XYEWBfy/tX0gTicUoWiCsCoYyv/WCB7opQ7T93RESwXtSQV64MI07QHuvC4szw
         ZdkWWYSE317dv2G8QHebQESkRT/uZqPZOJ+J3k3UobrFan3zZl+/PGHGv/XNM3IyyirT
         KYJ7a5dmgx6GbwUaF4OGJuoHWPQu02OfjumU7abAEbz9YsJRHv2hoPty381nRYB6ZpOy
         hxxKcsUa0rdB8FbN7ZurWKBIqls6eNuemdZ4kOdq9HmygOQZJAuPawRaxjjPcP3s7/vk
         ZjvQ==
X-Gm-Message-State: AOJu0YyaHFpByJ0ufpJfIL2J0i+C+pw8Fh8fuBVVUHTwyPGJlQ2dOPiT
        ocqfx/J5DvMj1mOieOpBrOA=
X-Google-Smtp-Source: AGHT+IGblyl8Ovf8J90lX1yyJvr8vPlJRmgbqJvYuuNIWJlUDtZ0BbX6Z0vXbaLmM28ay5a55XPjPg==
X-Received: by 2002:a05:6a20:7343:b0:153:6ce7:294d with SMTP id v3-20020a056a20734300b001536ce7294dmr2344261pzc.12.1694166852711;
        Fri, 08 Sep 2023 02:54:12 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e3a1-00a4-a20b-46bc-ccec-3e79.emome-ip6.hinet.net. [2001:b400:e3a1:a4:a20b:46bc:ccec:3e79])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b001b892aac5c9sm1172178plg.298.2023.09.08.02.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 02:54:12 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V11 12/23] mmc: sdhci-uhs2: skip signal_voltage_switch()
Date:   Fri,  8 Sep 2023 17:53:19 +0800
Message-Id: <20230908095330.12075-13-victorshihgli@gmail.com>
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

