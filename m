Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844DB7CD94F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjJRKdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRKdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:33:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3380B0;
        Wed, 18 Oct 2023 03:33:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c87a85332bso57398625ad.2;
        Wed, 18 Oct 2023 03:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697625223; x=1698230023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxQGM9qA4EGtcdIFGLpO7R5wP1z0FxL0mkOXOfmIXcI=;
        b=lI8wgWs1OCxxbcvsJXTI7bgySE5gIZOXL94kDdf3Vm8Mk1b2tK092DGOm39cYxatXI
         QQZPujHhzjUT5OJCLx5i43B9uILi5zFtYpoJU9g7c4TNsVDWiJyDk2cyVLwk+Jdy9s81
         J8y6//o4BquMpuzSyxt+uWjq59vIxyX2ifXWwrjvqdFEJvIHP/hnj7TcD1qnLT6y4ku2
         3wlccJradKx488iwF/X+bQtWZtqweEt50OUHfMIw3TGhTm45vE3tZL1vlrjTk12qH70I
         DRXBxUMEjShtFwPdL/D+ZL9otOI8JEmB53zfvKgy5Hht+RcCBN4mh1eJlFgjFJ2S85g+
         sJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697625223; x=1698230023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxQGM9qA4EGtcdIFGLpO7R5wP1z0FxL0mkOXOfmIXcI=;
        b=rxwKhfv6eDE3kUg/ZuVkla76Lt7eI8APwXFcQFROa+NBg2mOmZvLwx31VqHLZbgnlQ
         sanJIQMo0rwXl2idiwPgoAEWX9JVoaPTss5kpG9vhu2q4bdnPHvl502f0LuI+w8sztp+
         suMUCoLJpUvYYb4SL/WSYCNdRcsn/DDXuZimGKAv4ebegRZQZogOUlTUL2CKRrvkZHpj
         YPXQRx9HF8HE+Z96okrA+leZuCW1QjM1Ujo6UpfBjlobVLaT2qau9sBmqtEcUlGk+wqF
         ZOkfwXpCdwT979zkovaL2DgSEo8umL0JIPUiyN8mqHxiKLBxtX7gyPQGsEpuDHOFxHV+
         Hu3A==
X-Gm-Message-State: AOJu0Yyk4m/xFJ7vUK46ik5du68Ab6fem3D6wzrq/THEaVQDXFeydBPv
        iGhrFhbOXSfS+r8Up9MRR68=
X-Google-Smtp-Source: AGHT+IGjdgDEP5J0rFnhPHh2CCsY0/4A9EtCl8TwsZKdFdw8z27aKTdmuk166B/cPgHJWGw1xddclw==
X-Received: by 2002:a17:902:e743:b0:1ca:2caa:aca6 with SMTP id p3-20020a170902e74300b001ca2caaaca6mr4942272plf.68.1697625223134;
        Wed, 18 Oct 2023 03:33:43 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e757-5817-b46c-3b23-233f-77d9.emome-ip6.hinet.net. [2001:b400:e757:5817:b46c:3b23:233f:77d9])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902eac600b001ca4ad86369sm2871480pld.236.2023.10.18.03.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:33:42 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw,
        kai.heng.feng@canonical.com, Victor Shih <victorshihgli@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V2] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer timeout of AER
Date:   Wed, 18 Oct 2023 18:33:37 +0800
Message-Id: <20231018103337.34622-1-victorshihgli@gmail.com>
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
times out when ASPM is enabled. As a result, the warning messages that will
often appear in the system log when the system accesses the GL975x
PCI config. Therefore, the replay timer timeout must be masked.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V2:
 - Modify the commit message.

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

