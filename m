Return-Path: <linux-kernel+bounces-150027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7838A994F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AEE281E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BE015FA74;
	Thu, 18 Apr 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGAcee6F"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75816131A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441552; cv=none; b=hXVsKMsF14sv4LZxlLFftD4uU/kA36QsjWjlu7dL7S7VsOB+F+yETbYIM5aVu7p64NgxQNvXArlgWYI2pJ+TrH5d773m1yupqDwgtyolXF28UGRfR+hp5q9mmn9sl20FgxV6axjc7caAVqsIAEzkhFBm2wGvp8Ujgl+Xtbs8VXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441552; c=relaxed/simple;
	bh=0z6wX7i75zAQbc5rT+hGCcXotYGUGlxy6iIs1Con2yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ih3eCLdySNhTJQlRcMwnQBKbWz1EzcieWWiuTsN/XEDIt7u1EzxOg93XHzkW2M3Z9rAZ71tpHX+KwrNOZAemgZuajlmaO8rEIYU3JijKpKtBJy+LhzHrd4T3B2JSKRhnVNfD/j5jcekBbwdMVI8hqkHy1PNQrE4d9V6Mar1IoVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bGAcee6F; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2352cc0b076so527512fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713441550; x=1714046350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2N2Z6xy8oQhfjIfDa8B6axpEslsZ8eq+zErFp+7u1hA=;
        b=bGAcee6F2vzAMddbo+//uDUxrf1Ui/nOdVOLxo+zCS6WtGZ3lbTD/NnXwtfWtr4zsk
         1GhRl5bCHV0FEEmgUMCl30J/iX0lbdGBwFeVrMLhJf8BkhsYNRVIlJ/4ti0/vlM4fBEk
         AlXSHhNUk8mcB3jog0P4FJjwDhs0foIuckx3sEeE5dzznmUOZW61toqONrDDUV6aKFqU
         zCKmpw/r0WQKfjL05qmaA1WHSJeCbRKTKDKlGTLZNC2AakkHYym8CMgaEPnA3laUk/zH
         3sJIDawwW3AYqB9Gwo5i6NX3gkHqp/syH486fzsIjggD2b4GU82f8omteeT6jc/fQ+gg
         VtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441550; x=1714046350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N2Z6xy8oQhfjIfDa8B6axpEslsZ8eq+zErFp+7u1hA=;
        b=fHS7fLhNNOFQfWL4FVtjI/3rCO9XCUKcyEiSICi8kb5J8zbBVxDqaebApBBbtR/yfp
         XY0zJ3V2UCJ0oJJGo8THlxmaMIwM4o3i6K8Z0L4fb2kcoN5YuwK7BXGqHdLmo6jvhzi+
         wGQ2r1h7xU9VTl/eOqN248yOI5mBPUG0evDV+tvjiUNy/QlfLNVhtfmXF1FeGvIL4g9h
         epE6kHDnahtD56P577c3jeCD6Vm4w5AkWeWUtgC8OVhtyvwWVnZALlTopRXQn6X8KZqB
         XSUw1j2aR/rUf8FmdOeSbLQnVEKuPxCLtrTLZfU4D/q4NJ3vByqqGNhSN+Jwks1cUEbM
         LNag==
X-Forwarded-Encrypted: i=1; AJvYcCWjRZ/MEsIeMBH9DHsSSQ97puAc+FjxLox+RFfWfBrMCgAsRUC7pUGRXFT9m2OjhupHsCpLm3Sp7PThyUJNkgxvg3hZ02Oro8HClHbv
X-Gm-Message-State: AOJu0Yx+obdJe01uOy1OvNQcZT1ywnd59I0jr9Q2az3FjFtGawZ0b9TB
	aGcf+quA+A0dY1K9tpE4k2alAlIsaxDWutXOsf8cB+VAYNP/pDcuEzLrr8xCow==
X-Google-Smtp-Source: AGHT+IGqqD+K5zG10HIErj/uVTd8nkUVVpXS7lvDEvXl1IFawaGTfNbyTrK9ZXW3ToRDC5Vf7qCWgQ==
X-Received: by 2002:a05:6870:9a07:b0:233:5fa0:8b72 with SMTP id fo7-20020a0568709a0700b002335fa08b72mr3134116oab.27.1713441550127;
        Thu, 18 Apr 2024 04:59:10 -0700 (PDT)
Received: from [127.0.1.1] ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id ei16-20020a056a0080d000b006ed06c4074bsm1305512pfb.85.2024.04.18.04.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:59:09 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 18 Apr 2024 17:28:33 +0530
Subject: [PATCH v3 5/9] PCI: endpoint: pci-epf-{mhi/test}: Move DMA
 initialization to EPC init callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pci-epf-rework-v3-5-222a5d1ed2e5@linaro.org>
References: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
In-Reply-To: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2516;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=0z6wX7i75zAQbc5rT+hGCcXotYGUGlxy6iIs1Con2yc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmIQrzCIMss9Xjkc+w+Ay5cf4DIf0b4nbOW0HHv
 I2+r5lXzJeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZiEK8wAKCRBVnxHm/pHO
 9fSDB/97uQNmmFoSDfLvIRtqPL8WQZukYg0HqiFlU/A2DvHpF0l0a4/dOpB02EhlwCbzlgRsApX
 fnI5M09vT+w8De2g+dGSs7akU9bU6xtBY6d2JlPhD+6nIt4ONnfuKABaUHTt4vGTGb0X+sV7F1M
 SCbAz+4UgR3hMi3A4h/aoWe0yU0Bxu2pwlXpBVzb5I8WoVChpKfRBkGmqdcWij+zg6EuX8UyeJQ
 9i62Vjln9QTwFdV3peHBz66cj8gsmwVi/Wb3gSK/JDtHJtVnzvNS6laQyolSf4QIeULgqSp/QXm
 p3O41K0ndqaHwllHSz95vDE5zF1i2j1ukljaN7P2z82XwB6v
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

To maintain uniformity across EPF drivers, let's move the DMA
initialization to EPC init callback. This will also allow us to deinit DMA
during PERST# assert in the further commits.

For EPC drivers without PERST#, DMA deinit will only happen during driver
unbind.

Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c  | 16 ++++++++--------
 drivers/pci/endpoint/functions/pci-epf-test.c | 12 ++++++------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index b662905e2532..205c02953f25 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -753,6 +753,14 @@ static int pci_epf_mhi_epc_init(struct pci_epf *epf)
 	if (!epf_mhi->epc_features)
 		return -ENODATA;
 
+	if (info->flags & MHI_EPF_USE_DMA) {
+		ret = pci_epf_mhi_dma_init(epf_mhi);
+		if (ret) {
+			dev_err(dev, "Failed to initialize DMA: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -765,14 +773,6 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
 	struct device *dev = &epf->dev;
 	int ret;
 
-	if (info->flags & MHI_EPF_USE_DMA) {
-		ret = pci_epf_mhi_dma_init(epf_mhi);
-		if (ret) {
-			dev_err(dev, "Failed to initialize DMA: %d\n", ret);
-			return ret;
-		}
-	}
-
 	mhi_cntrl->mmio = epf_mhi->mmio;
 	mhi_cntrl->irq = epf_mhi->irq;
 	mhi_cntrl->mru = info->mru;
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 2430384f9a89..ab714108dfdb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -739,6 +739,12 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
 	bool msi_capable = true;
 	int ret;
 
+	epf_test->dma_supported = true;
+
+	ret = pci_epf_test_init_dma_chan(epf_test);
+	if (ret)
+		epf_test->dma_supported = false;
+
 	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
 	if (epc_features) {
 		msix_capable = epc_features->msix_capable;
@@ -895,12 +901,6 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
-	epf_test->dma_supported = true;
-
-	ret = pci_epf_test_init_dma_chan(epf_test);
-	if (ret)
-		epf_test->dma_supported = false;
-
 	return 0;
 }
 

-- 
2.25.1


