Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F058C7E384E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjKGJzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjKGJzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:55:00 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7417210F3;
        Tue,  7 Nov 2023 01:54:51 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso4465859b3a.2;
        Tue, 07 Nov 2023 01:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699350890; x=1699955690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmIG2BB5oMZIMJvfS5LNShy64tFn+UOtZXHaIVjFwZs=;
        b=jhhNAtwAfKw4Ecof8CqgOav8c70S/H3H2RGhEq5q3J1iFkk5KQt0B828pU81Mpy3V+
         9kV/SPA15D/dUREy0YIEX3a6YDTacBbszExVRYPUg861HKYAsIKQj5WXzNTjccuYui4+
         eWtbbMPKxtHjXyH4bXaU5qmYwXsox2vj3aaP0io4ijHPZymM+aoxjItpDzeuI+hXLimS
         2t3H58gvON3eO5omLeAyeSGmySeVB+yCnXF05uSaQVTueOmRvKWT0MPLYpo5O6ZvqqGU
         +Cvuq1N9NFF/yJYr3ltVazq3i6BR3lBr8QV5sCFXRDOQU2XVQuaffEVWjDhmi2L95RR3
         27PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350890; x=1699955690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmIG2BB5oMZIMJvfS5LNShy64tFn+UOtZXHaIVjFwZs=;
        b=dVk/Tee5utmGenmtOw2JMjfQZor8hTUASTpcKnQW5AF0CHvt4UY+4iHSsiDrnYlJCk
         uaNrAWwb2IGO0wwFRW++ddyWQ+8GH9WtPUEsn4aXhycVzVBNPSh/EmwRauqlC+7iTCz9
         vqkfSpY+AH/j2iHmOmB/GRyhSTYwjjGPQykqQ8vF2yVhCiC6SWEX9GvAq8c8kAir1uqh
         mMjCorYg5IS4OWFZZ3HmlXqKGLOgttslwUWdGe6grz0vd/Z5cWcs41dYzePjCo39/0It
         NriARJ8/5TunfNd1aXr4ubOpbSTKtoXDqdTaqHHHIyaSWhDvjLbW2e2jzNftwdYZ/9Bc
         vMNg==
X-Gm-Message-State: AOJu0Yw4Qu3MgdHTX+ETsAQcFaQFkcGxIE4h7v2YdzKA7PbuiLOhRY8w
        cAQI3wXrjeSfsu5umkMF1Sk=
X-Google-Smtp-Source: AGHT+IHnWGSNm4gQ3U45n+wXQaNEMozegFa4guOQqx+0QUroNTgdYTfuT3PnILgSVjiQ+F3DdPpxyw==
X-Received: by 2002:a05:6a00:814:b0:6b2:2a2d:7a26 with SMTP id m20-20020a056a00081400b006b22a2d7a26mr32525997pfk.28.1699350890518;
        Tue, 07 Nov 2023 01:54:50 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e25d-e1ee-eb42-adf3-9163-f337.emome-ip6.hinet.net. [2001:b400:e25d:e1ee:eb42:adf3:9163:f337])
        by smtp.gmail.com with ESMTPSA id u8-20020aa78388000000b0068fe5a5a566sm7106705pfm.142.2023.11.07.01.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:54:50 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, SeanHY.Chen.tu@genesyslogic.com.tw,
        kai.heng.feng@canonical.com, Victor Shih <victorshihgli@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Kai-Heng Feng <kai.heng.geng@canonical.com>
Subject: [PATCH V3 2/2] mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of AER
Date:   Tue,  7 Nov 2023 17:54:37 +0800
Message-Id: <20231107095437.8724-3-victorshihgli@gmail.com>
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

