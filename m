Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862DD7E385A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjKGJ57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjKGJ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:57:55 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E35F3;
        Tue,  7 Nov 2023 01:57:53 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-577fff1cae6so4027982a12.1;
        Tue, 07 Nov 2023 01:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699351072; x=1699955872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgbrRFHSh+56Lz72WSMa9a/GQjYEEMIgbG85FsQ7VvM=;
        b=A0dK8gczn3t96/AGKSV6Sxz/m2S5pGekhQ3rqcn2AEbxvRuQFQSOQN9E2ZWFdlpDBg
         d2GZWAGmWX7d3THrXi36SCGfZRDbvkXLHGi6H7DO/8I2w824or61yqsMRhald+xlz7Gi
         tThtbiBMkhj3g5t+EvCXggoGxpANHW3d8mfgjDq83MLEY3+eMRkMKUrunvK7mjaPQKG8
         huVBLrLEv19hHLJKC5w2TZCkj/+d9d4R1P93XEZCWyYPuv8TTuwszHf4uxZMgGcWAwwY
         cWWLFVt1m1acpUYml2ly869qATizVYOv2E6hEKhOwr68+Qa2uGppADaKJQs12J0+u7Jo
         BjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699351072; x=1699955872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgbrRFHSh+56Lz72WSMa9a/GQjYEEMIgbG85FsQ7VvM=;
        b=Zvmk9xFpSCG5wENUWiBwB/Go/2Bf0N1Q1p9L7TiAsoT4hhKXc8Z950m0bqaU9FZ87z
         2raQf9hfh/tW0lagsUaJTFDHRtYaK4codTGP1DO0SWlHoXCRhY70mMDrgnWWIJJPIQn9
         CLpeJ9fMzvaL2YTA8yo9XOR3kGJMPK5MrZfe+Fd9Y9sWOT5tqmxocsvBAI8vnHt2l2Nu
         r7JOkGAHDvkWLG9DjVOqFlXiEffAsIsidZtv+lrrYrWHjIL0ebaMat/JBDbKlH4jOy+d
         HMH6O1i7gYXQ+C8wvuAjKMlzzxEeA538ifq9sI3/WO8T4qo9v5mK6Wg+MxYvbY79uCzR
         9EYA==
X-Gm-Message-State: AOJu0Yybfe3q8lNEViUn6R5D73VR4BSW1Ouv7fEBsJrwul/CR6tjuuH0
        wMN28yWTHK2qwOvuTzng5Yg=
X-Google-Smtp-Source: AGHT+IE4XIqoAfBV+HCC9Kf97MpGjZfnQa/4pck/kaH/qnu/cK0s6eQb4lcCpz4FNj7GfX+utmR4Kg==
X-Received: by 2002:a17:90b:a01:b0:280:982:aa9f with SMTP id gg1-20020a17090b0a0100b002800982aa9fmr2817165pjb.7.1699351072501;
        Tue, 07 Nov 2023 01:57:52 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e25d-e1ee-eb42-adf3-9163-f337.emome-ip6.hinet.net. [2001:b400:e25d:e1ee:eb42:adf3:9163:f337])
        by smtp.gmail.com with ESMTPSA id v13-20020a63f20d000000b0050f85ef50d1sm1078725pgh.26.2023.11.07.01.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:57:52 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, SeanHY.Chen.tu@genesyslogic.com.tw,
        kai.heng.feng@canonical.com, Victor Shih <victorshihgli@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Kai-Heng Feng <kai.heng.geng@canonical.com>
Subject: [PATCH V3 1/2] mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER
Date:   Tue,  7 Nov 2023 17:57:40 +0800
Message-Id: <20231107095741.8832-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107095741.8832-1-victorshihgli@gmail.com>
References: <20231107095741.8832-1-victorshihgli@gmail.com>
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

