Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF95C7A4704
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbjIRKbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241354AbjIRKbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:31:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F33D8;
        Mon, 18 Sep 2023 03:31:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fb6fd2836so4017759b3a.0;
        Mon, 18 Sep 2023 03:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695033065; x=1695637865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QLJZOub4/BAt+7IdwydIQJYY2CoSBI6D30tEHY6X3RQ=;
        b=h+eH0bWoHTaoVPU6K6DN3xfxwyjiDF/Ea/f/NoeGPSlCf77uz4OF7CmxA0C/Np9D/m
         tGTu9zQjinJN7BjHrEm+BxY8zPhG9hKPJc621cWKWhua/JA2kPM4Qr+zMGr4T3Dbbjnp
         LA+Cljb8nqKPiKVvrP2tWMMjRv9dZXmqrNU12f3flRuMvPnrb0s/2rLHoVHJ5BvFBaq0
         FgbEjjFr37fbwteR42vkK05S/SkThHFJlpyWSw3qJ8TZsu8wuTaSW1q1nXQoCjFCsFN+
         5KsbZ7nrlOAlp3aZe3w0I6YOZqo75em+jtb6zwC/WHRfzleKs3y5tDr9XJNCcPZBcUuf
         Pseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695033065; x=1695637865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLJZOub4/BAt+7IdwydIQJYY2CoSBI6D30tEHY6X3RQ=;
        b=pENKH6qmPDviYdDgKOZdwSZDqsZzZB6ViPhv9ukQnyXpHw2Bc2y8kKTOifmHyCZDvf
         lWgedWMHk13p6oLdjq/acDb6ZpYfIR7rPHFuEIaPCbLkUvMMtxSRrScEeZ5hbujL6UP1
         KColWCViP4+S/hLzw4TDRMbhpu5W8a5PMt/Z7oX1Uid9JIC7n7H69nfk3x0TgRxLqG3v
         Mo15AqcLZV4iHds8mqx7Qd8K+3ttnjjcc9SzD1plyjdHtM0EqUud212XdSPyAegeV7l5
         ed9dS7P4juMwGPOYwwIGP6UR2MdbJvzoW2sNAP8M5/1+fOvh+fnowqy8O52Di7uzGrY6
         cEgw==
X-Gm-Message-State: AOJu0Yxn86ALdMhOPXLdSjZrV+sCUppPjnb4JCGvjWN9veTK+UqEm/pn
        Yx7oY35XJry5g5fU3YrCB1M=
X-Google-Smtp-Source: AGHT+IF21bVzTe/9AlnQIU7ozlm9pww9Vx+yiNPLNR4tU5eNpV9IcfnWExwi4b0Opd2KQOyzz5CfkA==
X-Received: by 2002:a05:6a00:3994:b0:690:2ecd:a593 with SMTP id fi20-20020a056a00399400b006902ecda593mr10089185pfb.26.1695033064750;
        Mon, 18 Sep 2023 03:31:04 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e2a7-a325-4595-6688-c34c-2ae9.emome-ip6.hinet.net. [2001:b400:e2a7:a325:4595:6688:c34c:2ae9])
        by smtp.gmail.com with ESMTPSA id o17-20020a639211000000b0056c3a4a3ca5sm6616292pgd.36.2023.09.18.03.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 03:31:04 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, kangzhen.lou@dell.com,
        kai.heng.feng@canonical.com, Victor Shih <victorshihgli@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V1] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer timeout of AER
Date:   Mon, 18 Sep 2023 18:30:55 +0800
Message-Id: <20230918103055.5471-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Due to a flaw in the hardware design, the GL975x replay timer frequently
times out when ASPM is enabled. As a result, the system will resume
immediately when it enters suspend. Therefore, the replay timer
timeout must be masked.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index d83261e857a5..d8a991b349a8 100644
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
@@ -152,6 +155,9 @@
 #define PCI_GLI_9755_PM_CTRL     0xFC
 #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
 
+#define PCI_GLI_9755_CORRERR_MASK				0x214
+#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
+
 #define SDHCI_GLI_9767_GM_BURST_SIZE			0x510
 #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET	  BIT(8)
 
@@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 	value &= ~PCI_GLI_9750_PM_STATE;
 	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
 
+	/* mask the replay timer timeout of AER */
+	pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
+	value |= PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
+	pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
+
 	gl9750_wt_off(host);
 }
 
@@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
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

