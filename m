Return-Path: <linux-kernel+bounces-126827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D14893D4A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B551F22D86
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6BE4DA05;
	Mon,  1 Apr 2024 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="koOWiqmw"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55EF47F51
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986665; cv=none; b=TRXq9k0JE+69m1cz2zzeVwTTQ9fVwuF/Q5p9fLCu6vY56p7XLO++hYBzC3PxaEbUkZBkQyNbrqaO1Hpvr6DGSak824STtc0Wfi9mvPxbu4COlm2rrR5/dHur2DrtXJoMWihPZGecxy2jo1qZS+AYX4sQ6EThnezn/5zDqlXqNdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986665; c=relaxed/simple;
	bh=wwNnvRLlmwO23TLovqPMSGYDsJxcK3iaM7F5chSpPYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nj2aS9HWaHzdLKuNJWZiu7+1axc0aoTHawF7s6cd7B4sldYg8Z+iZYKPrd9kjC5OIO7QsaO4CGf4QfxlG6YL50rVtOaI15ZwHiqmj0htNiJrtJ9TPD3NOPV41podjUtfqr/ZmD4pZ7jXWmK4KYg1ui5f1oWzOTssS6HFVys3wFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=koOWiqmw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6eaf7c97738so1467805b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711986663; x=1712591463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQ1z8rqVwmeXYhxl3w3OD366HcbHIhgoe+JIbrhB5sU=;
        b=koOWiqmwuq318KZclWaxG5i0lgqJ9jxrCLNPflgg7/XhdN6rxwzMFFaumZtvlMqryC
         0Q1DuZIsm0XGxQRQQ0W2TMwGFbLiUG9gOFaSYCKtMY8p6aJtMOP0EW5PrW8paU1/M4Qw
         Nfdp0gRAgnGiDLZ+ImnDuLTdPi8+w2FxZsmF1Pg3/jsH9Sn05tfLkdbSrbg8g8E7OCvk
         gkXo1H+Cxak7LUmksSBKbKLhQsSuP18s+5HpZE35AOKf80umD3N7PCc8hCj3f0tdcBi6
         aGGyOD+aWVM/DRksLSLf2NAEK0bCONSe4mUtRSwd+zlPmnfzB2M56iqz4TIZDtChB7aF
         HzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711986663; x=1712591463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ1z8rqVwmeXYhxl3w3OD366HcbHIhgoe+JIbrhB5sU=;
        b=HxeuK8cY5xF2RudOHA2AmgSe1tf2n6myKJofxM48ramXJTXTATkxrF5yo3ERvatvzU
         lacd/SMyJQHKuGSi5dWdmYGdHxYRXMiEaB7sKuf74NPmMqifHXq76sTCtmANkApk6OS9
         aU2rezJbfjF5P2cG9oDNEUB60T/JDL4UI11A1yvctxJ60C+txZoln7vhVSS/sGm2YTub
         r4yFNljQBG52mdfLNiseSPgZB5YocP9GttdXWxoSM34Cl64ZOZUICyOz0YJySrWd2nLS
         CSczIHrJHJw3Fz5i8qwgc9RlOpwu29YtmzM2iRb/XPOPZgd3dfsQD56WTRE7ez1JfG0I
         7TgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWytqAU4HgpK2CWTMSLGrXIClg9S9CZ4ZrgXs0a+TofSU7Rk3XV7N11QMi3m60x7VvcWv04ZkN3+m+LNI5TtOHfxb3Dr+AJrbmBvENo
X-Gm-Message-State: AOJu0YzaeycntO/V/utxUGzkYC9ykGzEVGEbG+QHg7IaISmIv9ytf8gF
	YMhinTdCLAFh77rgihXUw6IYl6bJ7m9vvJmJ4izYpNyn2d4lyBsYwYYC/W+Vrw==
X-Google-Smtp-Source: AGHT+IGW13s39+gWQfJBHOMaIVVQ9wo1ViMZDtd7E97itoXVEQx9NWclNdssLy9zSIKFjwQcUjOj7A==
X-Received: by 2002:a05:6a20:394f:b0:1a5:6a85:8ce9 with SMTP id r15-20020a056a20394f00b001a56a858ce9mr8780317pzg.12.1711986663022;
        Mon, 01 Apr 2024 08:51:03 -0700 (PDT)
Received: from [127.0.1.1] ([103.28.246.102])
        by smtp.gmail.com with ESMTPSA id kh6-20020a170903064600b001e21957fecdsm8949076plb.246.2024.04.01.08.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 08:51:02 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 01 Apr 2024 21:20:29 +0530
Subject: [PATCH v2 03/10] PCI: endpoint: Rename core_init() callback in
 'struct pci_epc_event_ops' to init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-pci-epf-rework-v2-3-970dbe90b99d@linaro.org>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
In-Reply-To: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5286;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=wwNnvRLlmwO23TLovqPMSGYDsJxcK3iaM7F5chSpPYE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmCtfUpcnQtd0V5nQg3kaaFQ+jHJeHI+RwCPByA
 hULZRkRTZ+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgrX1AAKCRBVnxHm/pHO
 9fSKB/4/Q8xUkYo8gNZzPckI13MFgKX34/2G0dIr3ukKrToTFp54DA+RwGq6ViIvU2w74SxTgOR
 nNzAVMVxSaekwxDR7QnUAxPU8Ty4QZv1zlUZhGNSjc0wB1aQECwtNpfsBwTrp2d0Q+E10G7OIoC
 vA60raiq7wlo9EtZLLmkJsinL+36g4bj57BvH+hZxOrimoDCjw6ynh80yqA50S0OJLO2cOj3zHE
 DEh1hr4GsXxZ8nsCJ8zSbYwPWeHJLFLbz+hPoeCQWag/PHjYeUCT/mAtkaKw+ESXITyYQ2i5/1O
 hirztCSFiWCvBO1w0CjjQwZdM2u+tHa/AvGptn7Ei2ZDT0f2
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

core_init() callback is used to notify the EPC initialization event to the
EPF drivers. The 'core' prefix was used indicate that the controller IP
core has completed initialization. But it serves no purpose as the EPF
driver will only care about the EPC initialization as a whole and there is
no real benefit to distinguish the IP core part.

So let's rename the core_init() callback in 'struct pci_epc_event_ops' to
just init() to make it more clear.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c  |  4 ++--
 drivers/pci/endpoint/functions/pci-epf-test.c |  4 ++--
 drivers/pci/endpoint/pci-epc-core.c           | 16 ++++++++--------
 include/linux/pci-epf.h                       |  4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 280863c0eeb9..b3c26ffd29a5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -716,7 +716,7 @@ static void pci_epf_mhi_dma_deinit(struct pci_epf_mhi *epf_mhi)
 	epf_mhi->dma_chan_rx = NULL;
 }
 
-static int pci_epf_mhi_core_init(struct pci_epf *epf)
+static int pci_epf_mhi_epc_init(struct pci_epf *epf)
 {
 	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
 	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
@@ -897,7 +897,7 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
 }
 
 static const struct pci_epc_event_ops pci_epf_mhi_epc_event_ops = {
-	.core_init = pci_epf_mhi_core_init,
+	.init = pci_epf_mhi_epc_init,
 };
 
 static const struct pci_epc_bus_event_ops pci_epf_mhi_bus_event_ops = {
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 973db0b1bde2..abcb6ca61c4e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -731,7 +731,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 	return 0;
 }
 
-static int pci_epf_test_core_init(struct pci_epf *epf)
+static int pci_epf_test_epc_init(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
 	struct pci_epf_header *header = epf->header;
@@ -799,7 +799,7 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
 }
 
 static const struct pci_epc_event_ops pci_epf_test_epc_event_ops = {
-	.core_init = pci_epf_test_core_init,
+	.init = pci_epf_test_epc_init,
 };
 
 static const struct pci_epc_bus_event_ops pci_epf_test_bus_event_ops = {
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index f202ae07ffa9..fe3cb62dd866 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -727,9 +727,9 @@ void pci_epc_linkdown(struct pci_epc *epc)
 EXPORT_SYMBOL_GPL(pci_epc_linkdown);
 
 /**
- * pci_epc_init_notify() - Notify the EPF device that EPC device's core
- *			   initialization is completed.
- * @epc: the EPC device whose core initialization is completed
+ * pci_epc_init_notify() - Notify the EPF device that EPC device initialization
+ *                         is completed.
+ * @epc: the EPC device whose initialization is completed
  *
  * Invoke to Notify the EPF device that the EPC device's initialization
  * is completed.
@@ -744,8 +744,8 @@ void pci_epc_init_notify(struct pci_epc *epc)
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
-		if (epf->epc_event_ops && epf->epc_event_ops->core_init)
-			epf->epc_event_ops->core_init(epf);
+		if (epf->epc_event_ops && epf->epc_event_ops->init)
+			epf->epc_event_ops->init(epf);
 		mutex_unlock(&epf->lock);
 	}
 	epc->init_complete = true;
@@ -756,7 +756,7 @@ EXPORT_SYMBOL_GPL(pci_epc_init_notify);
 /**
  * pci_epc_notify_pending_init() - Notify the pending EPC device initialization
  *                                 complete to the EPF device
- * @epc: the EPC device whose core initialization is pending to be notified
+ * @epc: the EPC device whose initialization is pending to be notified
  * @epf: the EPF device to be notified
  *
  * Invoke to notify the pending EPC device initialization complete to the EPF
@@ -767,8 +767,8 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
 {
 	if (epc->init_complete) {
 		mutex_lock(&epf->lock);
-		if (epf->epc_event_ops && epf->epc_event_ops->core_init)
-			epf->epc_event_ops->core_init(epf);
+		if (epf->epc_event_ops && epf->epc_event_ops->init)
+			epf->epc_event_ops->init(epf);
 		mutex_unlock(&epf->lock);
 	}
 }
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 77399fecaeb5..f4c2aaa6674c 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -70,10 +70,10 @@ struct pci_epf_ops {
 
 /**
  * struct pci_epc_event_ops - Callbacks for capturing the EPC specific events
- * @core_init: Callback for the EPC initialization event
+ * @init: Callback for the EPC initialization event
  */
 struct pci_epc_event_ops {
-	int (*core_init)(struct pci_epf *epf);
+	int (*init)(struct pci_epf *epf);
 };
 
 /**

-- 
2.25.1


