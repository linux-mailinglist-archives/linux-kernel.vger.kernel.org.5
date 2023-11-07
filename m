Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECE57E384C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjKGJzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjKGJyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:54:51 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F9FD78;
        Tue,  7 Nov 2023 01:54:48 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6cf65093780so3505218a34.0;
        Tue, 07 Nov 2023 01:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699350887; x=1699955687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgbrRFHSh+56Lz72WSMa9a/GQjYEEMIgbG85FsQ7VvM=;
        b=V1+Xwa6ZwuQ0QrWE6TFpdznm46EjasPaxOk31bj/p8obqNYcSKLYinEOnvSL/kX9/n
         PsNOpBLSF5L0I2FO3wXprqQ0yo/uF0ho83X+6Y5DvkKi2XZlhaqKfa9vrNDVH4m5ERmU
         02k5TNjkocapXy8sSgQ7YKDthT+AcF9FvGR4829WcHaucG+m4jrBIJKZweuf7tWQkjAA
         veSopktXE5ptaL9cfG/zwFzJ2UbQHGXUwoWzGUF0vdQZA6J4867PPNrNc8Potf3wXwxp
         02hQDgXw2nXE5lPmCwHkX9Q2/+iOu2LTWrPOXBIZoU5wHFOX4lyUtn7cvs94hHN+pYaU
         PtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350887; x=1699955687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgbrRFHSh+56Lz72WSMa9a/GQjYEEMIgbG85FsQ7VvM=;
        b=lrgv477o2CTDyk8ZvrpUvHPv0weRGBP2TpdCFmxIUbgO5H/hqkAZ5+E4627UVQ8wfL
         C16tiOOd4TFSTUvMGEdWMiSOJTko9SWClVpqPZmADuUsGyY2xncnUA1FfoTAIOQ5qrWt
         VFnnCZWlc/EyQvHBX1tK7w67KkIMJSmKLNiLwV/c5wMlm3xcS5P6UDp1Z9841XnJ2OVj
         ueJe/bh0Y1BUxG/LEyuJrRgOxPHvML1SOg8yK+I0JWQFKF37Gyn+5D/CxjJgHmwK0rRP
         2uUOkG5Ic+IP4cXZTI6bzj0CSnejaaNb1/bcynJxGY19OUKn4Qwjj0iLg0mEmzQSZJAQ
         vK3Q==
X-Gm-Message-State: AOJu0YwxWtIgHZjVi0TSVVlIKTSYUi6eFleccuAtH4lxIrswaUzOUW6e
        Zy4tyaUAAXH/LgDAWv7AjCq4gZinBopP+A==
X-Google-Smtp-Source: AGHT+IHTL9haXFqNLoKK0hUXBW2K2gIRmmHYHEaoLDqFZwPG9FeEMJ/uNsMPpMn/+MlJLckV0v5GKA==
X-Received: by 2002:a05:6830:925:b0:6bf:1444:966d with SMTP id v37-20020a056830092500b006bf1444966dmr37863634ott.1.1699350887400;
        Tue, 07 Nov 2023 01:54:47 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e25d-e1ee-eb42-adf3-9163-f337.emome-ip6.hinet.net. [2001:b400:e25d:e1ee:eb42:adf3:9163:f337])
        by smtp.gmail.com with ESMTPSA id u8-20020aa78388000000b0068fe5a5a566sm7106705pfm.142.2023.11.07.01.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:54:47 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, SeanHY.Chen.tu@genesyslogic.com.tw,
        kai.heng.feng@canonical.com, Victor Shih <victorshihgli@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Kai-Heng Feng <kai.heng.geng@canonical.com>
Subject: [PATCH V3 1/2] mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER
Date:   Tue,  7 Nov 2023 17:54:36 +0800
Message-Id: <20231107095437.8724-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107095437.8724-1-victorshihgli@gmail.com>
References: <20231107095437.8724-1-victorshihgli@gmail.com>
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

Due to a flaw in the hardware design, the GL9750 replay timer frequently
times out when ASPM is enabled. As a result, the warning messages will
often appear in the system log when the system accesses the GL9750
PCI config. Therefore, the replay timer timeout must be masked.

Fixes: d7133797e9e1 ("mmc: sdhci-pci-gli: A workaround to allow GL9750 to enter ASPM L1.2")
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Kai-Heng Feng <kai.heng.geng@canonical.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index d83261e857a5..3887bfd7386b 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -28,6 +28,9 @@
 #define PCI_GLI_9750_PM_CTRL	0xFC
 #define   PCI_GLI_9750_PM_STATE	  GENMASK(1, 0)
 
+#define PCI_GLI_9750_CORRERR_MASK				0x214
+#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
+
 #define SDHCI_GLI_9750_CFG2          0x848
 #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
 #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
@@ -561,6 +564,11 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 	value &= ~PCI_GLI_9750_PM_STATE;
 	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
 
+	/* mask the replay timer timeout of AER */
+	pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
+	value |= PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
+	pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
+
 	gl9750_wt_off(host);
 }
 
-- 
2.25.1

