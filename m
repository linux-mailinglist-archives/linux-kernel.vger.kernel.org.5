Return-Path: <linux-kernel+bounces-163399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE558B6A47
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C242C1C21546
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAEE20326;
	Tue, 30 Apr 2024 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iBm+pmxv"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264511B96B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457644; cv=none; b=pAeo/WaVQoY07HVbVrfvfeu+zfnpZ/IKgoDDjS9Pi//w8bnTLWvsMd2kIVNnB9QI2gAmfSALRR3TJ/oehEMuaqp9xCQWB5VoTvbtaDWq7DBdw287nzjcjlfv+q/lUiWjVpB3oCeFE/alYKRq8OZ9nVrn7J78FBxVgylfK9gtFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457644; c=relaxed/simple;
	bh=yKmOOaJz6i/wVDMqUoPJz0PoZUhAo27Wo6a6cpCeIcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JfW5F/fop82wXY1QpyyLF9PidGl7kEBcAMwXQmBw3aZRVsJfjK9HKbn4/ouBNLfEZh/earHmcBo+dlMi/qGwRWIOdwKCbjrfFQNWajrkKON0SOhTRaZ/j4v4DEKBHPJL7+V54RiO0utIME1Lj2O+6uuHOHgFYtHJMRTD5dWg8bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iBm+pmxv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f4178aec15so81973b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714457642; x=1715062442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXHWTwzfZvv6uYitrN43H3qh6MlnEfQjLqcWZK2Nh3g=;
        b=iBm+pmxvSmGk0eyqrS2uwTsOHARu66rKLTZTE7mr+2uNTTi6AiIwipBaXJaj9zTBol
         cb886gIjMMZqfRSsSL76euGZmMhZRFrjPJzsAffp+83Nz1ET6UX3rrWk43QerhE3G3+A
         /r/hPl769n+QXQZtMDz1YUg+cIGDWYAk7iW2H7YBGdVFVkZDReHBuJ0uFfm8nQX6zKRJ
         14PQr0GaV3EsJm14swLRJaAyotKl9cN9Pn1l2TTNq90ZaF7pwVOAX8K1oi2L/RBBo6gD
         LVBntDAoWFzhjQ7fX6mx0uZhPSK1tlQufSL1H3ZNsVa8hxkGKehVE74pbg20bV9obweB
         zn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714457642; x=1715062442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXHWTwzfZvv6uYitrN43H3qh6MlnEfQjLqcWZK2Nh3g=;
        b=ByMaqrjVXFVvh29FXa+okB3tOPNZIOx9RVgHtAlDhKQUP4q7smzNinY5ZFF3ghlddN
         8gL7W6DuBtQ0I3WlWipl7dp1VbvgN2wifsC89+P0Id4TFxiEPehBLU4u2UDBR+fY9Ju3
         8x1vqci755P58GtgB+Vh1rj/UvR1/FkEVQMb78AoVu6L6gSbiuMjs23EFsyOxVGW4UDu
         N5tWJO+SI/qvZ7zCoGxis6Z381lUPJSFmR/qjoY5ZG1MAxzKIoF9eWMxCFMkitddr/Zq
         KrSwYD1ZxL0tRTAuo9NVUtXrE5awb5cOgm9wwKSp+SDRjy4vmCU32/d78PVs+1pAhAy2
         +LYg==
X-Forwarded-Encrypted: i=1; AJvYcCXGVICcsDUpET/Pnh++cEv/51mzuJlOI4qCT1MFc9tXNErO3LgSxaqFj10JbxjBNH1I/YDnBrsTzoUj0bG01YaFptf+vZVFJTwv6MMq
X-Gm-Message-State: AOJu0Yzc4jxUV2PJ8Cx7KHlFvXMF48yGmKSPbZI+ulUEjQzDkADLwN7k
	tT6fXMTRLrj0j2cY6ATpGmQ4GRJyeGLqgqroqEWYfi4aOBNUQncUKACIDmEh1w==
X-Google-Smtp-Source: AGHT+IHRnaevKePYUyqhOl83dh54XWnj9qmpld7AKyPvIOscju3+tYJusTYfY1t7WIa0eSqzmrgVHw==
X-Received: by 2002:a05:6a20:918e:b0:1ac:6762:e62e with SMTP id v14-20020a056a20918e00b001ac6762e62emr15304457pzd.30.1714457642237;
        Mon, 29 Apr 2024 23:14:02 -0700 (PDT)
Received: from [127.0.1.1] ([220.158.156.15])
        by smtp.gmail.com with ESMTPSA id bi2-20020a170902bf0200b001e27ad5199csm21393298plb.281.2024.04.29.23.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 23:14:01 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 30 Apr 2024 11:43:43 +0530
Subject: [PATCH v4 02/10] PCI: endpoint: Rename core_init() callback in
 'struct pci_epc_event_ops' to epc_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-pci-epf-rework-v4-2-22832d0d456f@linaro.org>
References: <20240430-pci-epf-rework-v4-0-22832d0d456f@linaro.org>
In-Reply-To: <20240430-pci-epf-rework-v4-0-22832d0d456f@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5614;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=yKmOOaJz6i/wVDMqUoPJz0PoZUhAo27Wo6a6cpCeIcI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmMIwbIgMEUUVe4HsEcCgfAQPJnzSfgUhA+mY8J
 1G3MD3KQrqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZjCMGwAKCRBVnxHm/pHO
 9VZOB/48tkYcFkSJngFn0it+wlMUxFNsv5Wi3aeZerWI8GdEuH0YGu2iiVpSTxN5F6qWIrDnvtg
 5hH4UgGPYAgXOD6pjAe7mvr1jkuG3KkC+KfQdbkT8kvO6yCXFkyNUfPlzUBNY5yqwNrVZeZNqt4
 wse4giYnhWc2KGJ1MpQJVV0gvcGR+UZCRJJ7YjNTCiAPfy1JQCzH8BswrxKacovF7qUek6zWAYQ
 KFPH8vJO1HFaIc0cbRuL32PFy2o8B1pu/r252b6akQJATr5BsW04nEZCsgKcNtZFkcV8uj5zwtE
 TnG2ysOFzPAPWBXdU+xxb25slgqbC96twv8UgMiwQMLQRf0B
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

core_init() callback is used to notify the EPC initialization event to the
EPF drivers. The 'core' prefix was used indicate that the controller IP
core has completed initialization. But it serves no purpose as the EPF
driver will only care about the EPC initialization as a whole and there is
no real benefit to distinguish the IP core part.

So let's rename the core_init() callback in 'struct pci_epc_event_ops' to
epc_init() to make it more clear.

Reviewed-by: Niklas Cassel <cassel@kernel.org>
Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c  |  4 ++--
 drivers/pci/endpoint/functions/pci-epf-test.c |  4 ++--
 drivers/pci/endpoint/pci-epc-core.c           | 16 ++++++++--------
 include/linux/pci-epf.h                       |  4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 2c54d80107cf..95c3206f609f 100644
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
 
 static const struct pci_epc_event_ops pci_epf_mhi_event_ops = {
-	.core_init = pci_epf_mhi_core_init,
+	.epc_init = pci_epf_mhi_epc_init,
 	.link_up = pci_epf_mhi_link_up,
 	.link_down = pci_epf_mhi_link_down,
 	.bme = pci_epf_mhi_bme,
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 977fb79c1567..8175d4f2a0eb 100644
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
 
 static const struct pci_epc_event_ops pci_epf_test_event_ops = {
-	.core_init = pci_epf_test_core_init,
+	.epc_init = pci_epf_test_epc_init,
 	.link_up = pci_epf_test_link_up,
 };
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 47d27ec7439d..e6bffa37a948 100644
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
-		if (epf->event_ops && epf->event_ops->core_init)
-			epf->event_ops->core_init(epf);
+		if (epf->event_ops && epf->event_ops->epc_init)
+			epf->event_ops->epc_init(epf);
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
-		if (epf->event_ops && epf->event_ops->core_init)
-			epf->event_ops->core_init(epf);
+		if (epf->event_ops && epf->event_ops->epc_init)
+			epf->event_ops->epc_init(epf);
 		mutex_unlock(&epf->lock);
 	}
 }
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index adee6a1b35db..afe3bfd88742 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -70,13 +70,13 @@ struct pci_epf_ops {
 
 /**
  * struct pci_epc_event_ops - Callbacks for capturing the EPC events
- * @core_init: Callback for the EPC initialization complete event
+ * @epc_init: Callback for the EPC initialization complete event
  * @link_up: Callback for the EPC link up event
  * @link_down: Callback for the EPC link down event
  * @bme: Callback for the EPC BME (Bus Master Enable) event
  */
 struct pci_epc_event_ops {
-	int (*core_init)(struct pci_epf *epf);
+	int (*epc_init)(struct pci_epf *epf);
 	int (*link_up)(struct pci_epf *epf);
 	int (*link_down)(struct pci_epf *epf);
 	int (*bme)(struct pci_epf *epf);

-- 
2.25.1


