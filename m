Return-Path: <linux-kernel+bounces-153227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0B68ACB2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4849AB22B79
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B731474AE;
	Mon, 22 Apr 2024 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKTCCcpK"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD7502A8;
	Mon, 22 Apr 2024 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782700; cv=none; b=l354xGwc/6iqn7w7weBLVZGl+DLnleLtH/ajNA/tPIdfwDSQPuzwwN3tDpBKeOE6G1gr75h+wiSQuj9PZ6qIZEu8Zlv9oI7riqoA9U5uxtJba5cyDBaXHYVVIjKm0peNZCjEDuYCKwLEP3R66dqfGFYf8QzAHrbFOO//3cTLac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782700; c=relaxed/simple;
	bh=cvlHF+xMs1qsEOuNf3mwOC8mdfVM7AymMc1BF9fSZhU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iip2PiXWuv7urK13OV1D45vZ21lWv9b55wP0qjr+shSkAXWxyKdIFnyh/LIEFj6cY8rP6TJhczMnEzqjBMNDoNjudSHYqqgOGa/deGdmBfymyxSurbDwJAhR4dyf8fLA6up0iObAfoe8X8lL2mCpzDOeHzkxi5FxPty9H4wXhDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKTCCcpK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ee12766586so3240553b3a.0;
        Mon, 22 Apr 2024 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713782698; x=1714387498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0cmjeO4AWJjXgxtd/DzrwOW0GDT9l0zaX03UCUQBXo=;
        b=fKTCCcpKq+p/+joF849VXXySSQgoEy2CytlBBdbGz28+H5VqwYsFb7jqoi0Jq2GOfX
         dPPeaGw6gc7KByjgq+tZWmf/KpD3xHhodJGt02ur5pY+TgdJOUF64qMcOvaKGQFbGl65
         vv1V2z2tDAMW9GdV4BbRxUsPp35J7q9MN+WPgytpaIWVVTRaJm6BFGTde+/GGpFZkZLG
         jgCrq2SxLOgEoy2UYvGW3UIqycrl/2JQwjN7WTMu5tYExZyg/6ERTfGwZMle4EcHb/WE
         auMKH8cjfiFFnapsSRMAx7UtnVgOQv+YvtrKQE5seAUzZURUoLkTqaxeUNL5Y1RLU6G6
         dLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782698; x=1714387498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0cmjeO4AWJjXgxtd/DzrwOW0GDT9l0zaX03UCUQBXo=;
        b=s4NJbQ25zyx+IB9gLKz1Xal6u9LgGNRYiqTRtmVEQN3YjaXimQOmcKzKNXDUc2LZ0c
         30yBtXqjJScEyVEP/RZjrrQQNSW0CzIIfvPMSSLyjLMtQYU/AwQzNAjxQzxCQWgg5M4h
         6vP4l8ychyOhfKenyW2Z6CID4/aI2p5SmB9C6lQSQlDq74VR6gxNVSPyYH+FayQl7Rlw
         8MX+nt3EzkWEMbh6KYDW7fgm1pYu9kX2HE0m/dgGM/gNtHr1lCCfFRPMa/n4R5a/YhAp
         OSdwJbIqBRqNmAB8X7sVYhlpOIk24Eh4iWQd+kZcxn9U7Lph+q8/1B6/f+wgFq8Wjeqt
         zOkg==
X-Forwarded-Encrypted: i=1; AJvYcCUMKCNS8LvK8NM9NeSctKNKjgUr2+XEawkRQAZoxbESMKsN1NlCbDxxlc1hyWm+VKxrfz7nfSLgJjG9wvHuJj9Pl4vCyD0zccxWh8s5
X-Gm-Message-State: AOJu0Yz/geBjokHRFGuDVjeREK/rwkSaQvhAlgOBo/Zpx3Y6F60KJOqm
	OmbXKELkZXlDk81A8GVAC57oGMhXMR39EymN0RG0p1Dgz7IJeCOG
X-Google-Smtp-Source: AGHT+IFdszst8hrT28O/4MOw5soXGN1hcBZ5n23w1kAQeVaIljfo5oe9Z7hphHfiQ3RIPW0LyWbDmg==
X-Received: by 2002:a05:6a00:a0f:b0:6ea:f43b:b961 with SMTP id p15-20020a056a000a0f00b006eaf43bb961mr19364029pfh.6.1713782698366;
        Mon, 22 Apr 2024 03:44:58 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e33b-6ac4-2bfb-4656-8624-cdbd.emome-ip6.hinet.net. [2001:b400:e33b:6ac4:2bfb:4656:8624:cdbd])
        by smtp.gmail.com with ESMTPSA id fk24-20020a056a003a9800b006ed9d839c4csm7528239pfb.4.2024.04.22.03.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:44:57 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V15 20/22] mmc: sdhci-pci: add UHS-II support framework
Date: Mon, 22 Apr 2024 18:44:50 +0800
Message-Id: <20240422104450.14976-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This patch prepares for adding UHS-II support at a specific UHS-II
capable sdhci-pci controller, GL9755 for now.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Updates in V8:
 - Add config select MMC_SDHCI_UHS2 in Kconfig.

---

 drivers/mmc/host/Kconfig          |  1 +
 drivers/mmc/host/sdhci-pci-core.c | 16 +++++++++++++++-
 drivers/mmc/host/sdhci-pci.h      |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 342bbc3ef577..7bd2f3c94e48 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -111,6 +111,7 @@ config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
 	select MMC_CQHCI
+	select MMC_SDHCI_UHS2
 	select IOSF_MBI if X86
 	select MMC_SDHCI_IO_ACCESSORS
 	help
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 025b31aa712c..9c87898a1b03 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -40,6 +40,7 @@
 #include "sdhci.h"
 #include "sdhci-cqhci.h"
 #include "sdhci-pci.h"
+#include "sdhci-uhs2.h"
 
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
 
@@ -2161,7 +2162,10 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	if (scratch == (u32)-1)
 		dead = 1;
 
-	sdhci_remove_host(slot->host, dead);
+	if (slot->chip->fixes && slot->chip->fixes->remove_host)
+		slot->chip->fixes->remove_host(slot, dead);
+	else
+		sdhci_remove_host(slot->host, dead);
 
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
@@ -2169,6 +2173,16 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	sdhci_free_host(slot->host);
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot)
+{
+	return sdhci_uhs2_add_host(slot->host);
+}
+
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead)
+{
+	sdhci_uhs2_remove_host(slot->host, dead);
+}
+
 static void sdhci_pci_runtime_pm_allow(struct device *dev)
 {
 	pm_suspend_ignore_children(dev, 1);
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 153704f812ed..e807c039a8b1 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -145,6 +145,7 @@ struct sdhci_pci_fixes {
 	int			(*probe_slot) (struct sdhci_pci_slot *);
 	int			(*add_host) (struct sdhci_pci_slot *);
 	void			(*remove_slot) (struct sdhci_pci_slot *, int);
+	void			(*remove_host) (struct sdhci_pci_slot *, int);
 
 #ifdef CONFIG_PM_SLEEP
 	int			(*suspend) (struct sdhci_pci_chip *);
@@ -189,6 +190,8 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
 	return (void *)slot->private;
 }
 
+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot);
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead);
 #ifdef CONFIG_PM_SLEEP
 int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
 #endif
-- 
2.25.1


