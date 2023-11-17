Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD337EF1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346089AbjKQLeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346165AbjKQLdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:33:37 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A997D2126;
        Fri, 17 Nov 2023 03:32:59 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so1875461b3a.3;
        Fri, 17 Nov 2023 03:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700220779; x=1700825579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MEzikBOSI0IzLimKwIxezna9qhfNLGyuWYtUgFehms=;
        b=HfAyo4rGyUqKvsQlUQuijZuEmC3BqHVaYyCaiQRK34fs9HgEInocMuStgMn5mOfPOI
         FVSGPjoT4rMsDxQQzWOOX1UcHrOvfDpg+TPEBBZPrKOjqHBXsyHc/2SYGi9NmoS3jdoW
         66MQjfwflxaFJJ1nSgraBsOU9ldw+8CiV+D9TOWLunHktHNrHhXpB2SmSXibQo4YoKTA
         O7uBIWNezO3KO/ddYGYWdOgHU3I9+pYp8c5nkhwxh92FmK7wuYPyhozmrSGIAr1NrCow
         XHAS+AzgqIUCI2JhN4ytlKY8zqTC6Er9cHY1VH7MZyzZwxDXMYgXbSfdApenKUgBSRBF
         4iUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700220779; x=1700825579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MEzikBOSI0IzLimKwIxezna9qhfNLGyuWYtUgFehms=;
        b=ThlWim20AFE7t8SJrDGPDJsuQSwBFph8ZETR8uslrzv7QXzgvI5OCDF2FV1uUOlT5Y
         53s9CqgRSVd6mUHkvKW7Kw0tDwGryRIjXaOYJcOFPmjFjRwmS2JlLb1jsZgytdAloYgQ
         i+6e7pU2n6KsYpRrTWd5OOGend64PRDIUeEOu7gHq2bPAhgzUoShSjBnHejsaIMMwanV
         RRAFs47XA9td8WIMVW51V0pP/ADDuKWjggOE5LOLcaxE6fTFJ4R32eD0HbAdNu2yb1vZ
         V8MsaVW+coh0o9J29ITDFko7TMouf8vIhMt/7TJ1/NTFmJpTINiwEJ9bqWKDltzOBgpx
         wIog==
X-Gm-Message-State: AOJu0Yw5LrP/aHZsDu1ShazCO6hS8V6/hEY5/ZXPWd/qV60M+VtqNzTW
        bouv9XPF198tL1ZUizuBV+emYUjYWcI=
X-Google-Smtp-Source: AGHT+IGl/H1cI0nH5eGsCwqDxMHB3g+pw0qZYXEqOsnUAUxnP175hFqOAP4TvWDGPniv0sMew8Np4w==
X-Received: by 2002:a05:6a20:9144:b0:16b:e46e:1246 with SMTP id x4-20020a056a20914400b0016be46e1246mr22488201pzc.30.1700220778716;
        Fri, 17 Nov 2023 03:32:58 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e286-d458-bc89-d4cd-bd42-ffb5.emome-ip6.hinet.net. [2001:b400:e286:d458:bc89:d4cd:bd42:ffb5])
        by smtp.gmail.com with ESMTPSA id u2-20020a631402000000b005b4b70738e5sm1229224pgl.8.2023.11.17.03.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 03:32:58 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V13 19/21] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Fri, 17 Nov 2023 19:31:47 +0800
Message-Id: <20231117113149.9069-20-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117113149.9069-1-victorshihgli@gmail.com>
References: <20231117113149.9069-1-victorshihgli@gmail.com>
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

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 45ff0bfedf3c..e187176b79d7 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -407,6 +407,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("Begin do uhs2 detect init.\n");
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
 		return -EIO;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 1085942d47a9..fb10a26dc251 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -724,6 +724,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

