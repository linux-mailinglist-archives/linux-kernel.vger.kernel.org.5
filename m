Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7937E385B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjKGJ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjKGJ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:57:58 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B8D120;
        Tue,  7 Nov 2023 01:57:56 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso5470405b3a.2;
        Tue, 07 Nov 2023 01:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699351075; x=1699955875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmIG2BB5oMZIMJvfS5LNShy64tFn+UOtZXHaIVjFwZs=;
        b=GVlv7eSmKEQGnf9xsdYhFN8tsA5Cd/4tWLi0kEvNcbuu46nkcdscHnGNNS1hRDlfvU
         w9lXVNVp59uZCwNRwiJVCAI/LDYTCFMDYC0waZbkzoEZzkeyrT82ubzAi5M9pwUve5YQ
         NuRdJy3lUw72PT/4ZgewUuMwmQFU0Ph2cgscFYWK+JOy+UpNzgOSifJB0QQ2BRNcAgQl
         4d5JLPuylZ5r3p4/QbvpDtTu92H6cdU9wJHGN5xikEDstH7qjsNGIYlkTFLbrEFMq0JH
         toOHCZoX2tEujw0/C75TqdqjSYSMgeSeN+fpQw748CHTReCdQOFqx8ZpaTiYh4tHt4vH
         ajJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699351075; x=1699955875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmIG2BB5oMZIMJvfS5LNShy64tFn+UOtZXHaIVjFwZs=;
        b=YbaRcHPKkbqvXkzxJ4UZAD09hUG2HHhUAig8scysFmes2CytvZfEpIuJCGbsedapdc
         9XzoS4tGO15we21W95rsBGu52mc9JGcnzf2iwrXeeEDJ8T5/zrS6oF54pV2CqtwzW+6B
         qet1oOJrY0Km/ybXe4uLVITsm3lEF+GtBf09+L0H+HiMb3m6lY7kviodsCYcLTwRdwQK
         LiwzpnYnHmbv2IZxZFM9X/7bDr/tcljjfaW6Q6neIYFT2ey6pdUbdjxV41mMGbjypols
         LEtJZ+oRq8hmntfL/Yy+UF2U/OT6JYWioxWoNwNVKBEuBnhfDK8fTa0GU3K6WhcC87aT
         KdQQ==
X-Gm-Message-State: AOJu0YzZsbMvQ9HfXFSwQxaGyoB89OIFDBAlTZrfI+2112bIc7Giu5jh
        epYg3cn4iB2ZeER7FQwr2Ek=
X-Google-Smtp-Source: AGHT+IEpitLyg32wwYqZvE6VlxXihLXKM4M1ElZzPqwWcDU/N6x5rrmkmCtZVW9wtgD8sXcew+UYgg==
X-Received: by 2002:a05:6a00:1ca6:b0:6c2:c5b6:3963 with SMTP id y38-20020a056a001ca600b006c2c5b63963mr20614535pfw.0.1699351075663;
        Tue, 07 Nov 2023 01:57:55 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e25d-e1ee-eb42-adf3-9163-f337.emome-ip6.hinet.net. [2001:b400:e25d:e1ee:eb42:adf3:9163:f337])
        by smtp.gmail.com with ESMTPSA id v13-20020a63f20d000000b0050f85ef50d1sm1078725pgh.26.2023.11.07.01.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:57:55 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, SeanHY.Chen.tu@genesyslogic.com.tw,
        kai.heng.feng@canonical.com, Victor Shih <victorshihgli@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Kai-Heng Feng <kai.heng.geng@canonical.com>
Subject: [PATCH V3 2/2] mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of AER
Date:   Tue,  7 Nov 2023 17:57:41 +0800
Message-Id: <20231107095741.8832-3-victorshihgli@gmail.com>
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

Due to a flaw in the hardware design, the GL9755 replay timer frequently
times out when ASPM is enabled. As a result, the warning messages will
often appear in the system log when the system accesses the GL9755
PCI config. Therefore, the replay timer timeout must be masked.

Fixes: 36ed2fd32b2c ("mmc: sdhci-pci-gli: A workaround to allow GL9755 to enter ASPM L1.2")
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Kai-Heng Feng <kai.heng.geng@canonical.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 3887bfd7386b..d8a991b349a8 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -155,6 +155,9 @@
 #define PCI_GLI_9755_PM_CTRL     0xFC
 #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
 
+#define PCI_GLI_9755_CORRERR_MASK				0x214
+#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
+
 #define SDHCI_GLI_9767_GM_BURST_SIZE			0x510
 #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET	  BIT(8)
 
@@ -778,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	value &= ~PCI_GLI_9755_PM_STATE;
 	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
 
+	/* mask the replay timer timeout of AER */
+	pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
+	value |= PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
+	pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
+
 	gl9755_wt_off(pdev);
 }
 
-- 
2.25.1

