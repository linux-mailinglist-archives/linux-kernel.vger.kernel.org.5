Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B646C79CB62
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjILJRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjILJRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:17:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362DAA9;
        Tue, 12 Sep 2023 02:17:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fbb10dea4so1649315b3a.3;
        Tue, 12 Sep 2023 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694510237; x=1695115037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owu+iw/2FkUrRYrZDkX+J602qOAcIdeb4iAQuIcFb/M=;
        b=blxTRj4oK1E/xG/KC2l0mWgEeBMaxnpHIPMUbhoUzxGTekbyDM5NZ9N/Y/L9QoPT3C
         Y7spyiTvr9AiHVVG0ZNOw0MO3s0ZLUemGwE3gQrgPuJ1RIpS90Swz5tBbVsfrW+PdL0a
         kHPlka9J/GBc3tYfKPVlQdDCV1eJSq9RcoxiWRoAth1nWAxkndFQ66DysgGrrCfX/bDm
         K1//tH1ZcWrpNUCcx3C3HxwtDxRSWwx33sN9JFjH858lrcsoUYnjsUXt8PBTl8O/Y20R
         VUmOzxmH76yrGFAHrd+fNJaruwvb55WvkSuaRJw7LYKvir9UyjFvt7nnJ/TyLdycm+q1
         YnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694510237; x=1695115037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owu+iw/2FkUrRYrZDkX+J602qOAcIdeb4iAQuIcFb/M=;
        b=pn0hU1zkD8oYy9nE0HFbLqe3rlMPEtH69gz1npBlfean3rC7hky+N6c6F8XJ4bLZUV
         m+lxVXD0/5roHeoyb/mEZknHUKQQxVgS2y9FdVAgS4mWRYXTm1vLU+8kDo2fRT0PhIOC
         oKGq6+aIWdtMASy0MATj4J7iD+w4wh5eDOMWKD5nASu2/E2q9/pRTEe3CvvMEp9UbXGZ
         4BjNqWREDkhQmjds2dy61pL8munDlsVu4zcuOK2BOKwP2LKOOqbbRa9Jd6dV9+wIco3Q
         8vovSSV2IYG2Oz2Ku7EYRpqQC5xv+BH5vDDvfVYsYyOfIEQkeGMirLJSe0hrel8ydgNP
         hmDw==
X-Gm-Message-State: AOJu0YycX/dcFTYziv8Xm57BBJIsbnUMmo4WATG3QoZiyke+7Q6xs5ZV
        JdGEudmKf6o+EKdME+gK2BQ=
X-Google-Smtp-Source: AGHT+IGqXNDHKApQE1bCCD8nNs98zTt/9xRUjd40elC0JNPe6ofIn7CyEUKrWqEeqzUgxUAAINQ11A==
X-Received: by 2002:a05:6a20:3d82:b0:13d:bf07:7444 with SMTP id s2-20020a056a203d8200b0013dbf077444mr12497353pzi.0.1694510237473;
        Tue, 12 Sep 2023 02:17:17 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e3a1-00a4-e9b8-a113-90c8-ebfb.emome-ip6.hinet.net. [2001:b400:e3a1:a4:e9b8:a113:90c8:ebfb])
        by smtp.gmail.com with ESMTPSA id fa5-20020a056a002d0500b0068fb5e44827sm4186555pfb.67.2023.09.12.02.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 02:17:17 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, liukun11@huaqin.com,
        Victor Shih <victorshihgli@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V1] mmc: sdhci-pci-gli: A workaround to allow GL9750 to enter ASPM L1.2
Date:   Tue, 12 Sep 2023 17:17:10 +0800
Message-Id: <20230912091710.7797-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

When GL9750 enters ASPM L1 sub-states, it will stay at L1.1 and will not
enter L1.2. The workaround is to toggle PM state to allow GL9750 to enter
ASPM L1.2.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index ae8c307b7aa7..dd6f09024f08 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -25,6 +25,9 @@
 #define   GLI_9750_WT_EN_ON	    0x1
 #define   GLI_9750_WT_EN_OFF	    0x0
 
+#define PCI_GLI_9750_PM_CTRL	0xFC
+#define   PCI_GLI_9750_PM_STATE	  GENMASK(1, 0)
+
 #define SDHCI_GLI_9750_CFG2          0x848
 #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
 #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
@@ -536,8 +539,12 @@ static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
 
 static void gl9750_hw_setting(struct sdhci_host *host)
 {
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev;
 	u32 value;
 
+	pdev = slot->chip->pdev;
+
 	gl9750_wt_on(host);
 
 	value = sdhci_readl(host, SDHCI_GLI_9750_CFG2);
@@ -547,6 +554,13 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 			    GLI_9750_CFG2_L1DLY_VALUE);
 	sdhci_writel(host, value, SDHCI_GLI_9750_CFG2);
 
+	/* toggle PM state to allow GL9750 to enter ASPM L1.2 */
+	pci_read_config_dword(pdev, PCI_GLI_9750_PM_CTRL, &value);
+	value |= PCI_GLI_9750_PM_STATE;
+	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
+	value &= ~PCI_GLI_9750_PM_STATE;
+	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
+
 	gl9750_wt_off(host);
 }
 
-- 
2.25.1

