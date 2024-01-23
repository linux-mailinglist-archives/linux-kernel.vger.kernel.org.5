Return-Path: <linux-kernel+bounces-34790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB8283877B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590C7B214B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FB05A0EB;
	Tue, 23 Jan 2024 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbdVPkz0"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5459B6F;
	Tue, 23 Jan 2024 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991389; cv=none; b=iCuqSzWvWPleSCk02G/g5LNf5cEoQq4fxXDJ+Ln3ojZEQG2zZ5pBwNh3e/qz8TbcaAYqraM3KThOICK3yg9jZrWqUaw/F10g2OZRlhf/Lnrb6oxlsPPOrz77KNTJrnbbQ+DHtE12KO75Hw1DL2OjH38vgeQ61IYaDqhiI6LPKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991389; c=relaxed/simple;
	bh=IUqprA2TF0JnjmPM0nXsYSs+9jyX8T3LPFUNW+ZA+gM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfQbUb14Moy/nMBUrhtfEeMfy3LrxIqDbRtn4gCmEiiLj96gMvKjMtlvlegeDI+C4g9UFjlO6fmCp3UVMg/zsFOFMRB9f65pIDa4NLOcQ8V48oDXeOuJFth2aE+fz04UcYb+EAbJ7+dTFHK4jqCykFo6ypTZaAI8i0G5B0agEHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbdVPkz0; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bd7c5b243dso2860956b6e.1;
        Mon, 22 Jan 2024 22:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705991387; x=1706596187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAsRT3UHnSw/gnSNp2Q3xHJfdBqwbXKi0Pb7j8g0LCc=;
        b=VbdVPkz0nXRFsnXt3aLNXC9iSiinHvfEs/Ph8aB32LCBi9swHpErlA7N8+dXol0l0e
         QiusWCzfIScfHHUr0fHzoE2nqgIkR8aIloOgncXBsfY3uaQluhYzTeyYRku/flQjTjAA
         dfMjAR/jCu93b4M2nApWhiilGN4x2KjFGJg3bq2bU9SYquh0GQ1oadVHwUlf0TCZe3Vp
         kqPycCquXiQkSJqi29cw547sgkWy6NLZyCcrFPSaDp+i05CASOHv7pIXsA+S0QUIZ0OB
         cj8uokmBZmyolxi5YF7vhM2x7yi/pJRTzuEK1HcLuPmWRQmoukDwHrg5AyFFnKlPvFF9
         kMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705991387; x=1706596187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAsRT3UHnSw/gnSNp2Q3xHJfdBqwbXKi0Pb7j8g0LCc=;
        b=JrwwwKueFqNmkEDztoGkjUQ1/Rp+AheXmfvrKn9nLwbKjV/EibHjmzZZVxs+yE2+XK
         qDGI6/SL4t30XaiS82B2MFx8Z+BDNLr2/lkFODOlWx5kq9lt3Rtmvx5p3+bgJP2s+rFp
         Cs6+fEkmVMiXhmhO4fkq4NiHDcnjPeY6/Zr5AQFF/H3QuEq/YhQAzarh1SuZ9O+yBVhW
         e7e1Y+PAC8slD3DWRLrFLGr0JWYBpAAGQsCPkIIncqebE8//QfC06augupc+RtfPLjkh
         DEZTPvgc7B6wenPJG6gafX/MTJnU0SGAtrbM8Yk06BVmjIqoBRFj+3XzrJ2A9if7/xCm
         g0bQ==
X-Gm-Message-State: AOJu0YwhcTiA/lK2yYmBUQ2w2krLTmY2gZj0Y6BcdA8rzkNm3ezqfy/0
	64vY5Zgkg2v2VW+OdVqkCITmbPcih3tQyxbmgWbAozKgSSe2ei3j
X-Google-Smtp-Source: AGHT+IHlH5SJ11Y7vYXhpVeN7lDIZLO6jtC4viM8DKlP6EFN6EOSNKmmkyOrSsgyr6tv9MpH5A8QUw==
X-Received: by 2002:a05:6808:3192:b0:3bd:729a:774 with SMTP id cd18-20020a056808319200b003bd729a0774mr7617803oib.50.1705991387314;
        Mon, 22 Jan 2024 22:29:47 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2ac-a4c6-7d2b-d8b3-ed27-1f50.emome-ip6.hinet.net. [2001:b400:e2ac:a4c6:7d2b:d8b3:ed27:1f50])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006d9b2694b0csm10595188pfu.200.2024.01.22.22.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:29:47 -0800 (PST)
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
Subject: [PATCH V14 20/21] mmc: sdhci-pci: add UHS-II support framework
Date: Tue, 23 Jan 2024 14:28:26 +0800
Message-Id: <20240123062827.8525-21-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123062827.8525-1-victorshihgli@gmail.com>
References: <20240123062827.8525-1-victorshihgli@gmail.com>
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
index e1f47d252b06..f4c0102f9a33 100644
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


