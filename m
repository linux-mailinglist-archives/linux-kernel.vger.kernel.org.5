Return-Path: <linux-kernel+bounces-81288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FDD867369
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642531C24AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B917122337;
	Mon, 26 Feb 2024 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sszqh8j4"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0658739856
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947477; cv=none; b=LQIvSLchRXKKnZ1kXZbInwRk/6HkcBTtQX03FWeGMdkBX8rjIygVS/sz/cJcWamXDJaWxAjN3sjMhOZC2ynigVlSxfEmSh1EiD94hEO6iLqZAft/6NiV1vL5HpGqYHwwrG5wz0vdB5klTcOgcvi1Nn08Go7IKrDmN+WofYyh7ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947477; c=relaxed/simple;
	bh=WcbOX7Mto0c1BGHRXqQ6U7dCJ8afc+aUAohuOTqaRuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wuyx7hksg9gZDRFMn931cGA9WdMJ39n8CpePmBTghg5SlxO9hfc2mkyi6Kk8EnnehK49VsbzXunP0KXtfo4XVDtYgahUbY2EDjq4f4DYZFEy3kxEZChD4fUiKcgaOZ/vV2Xw4NpUDn9i46VpjlF69KyyR2Ed3qMD1gMXNY7nV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sszqh8j4; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42a9c21f9ecso11573961cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708947474; x=1709552274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYL0y9tWhN7SH+jeAOGY/jbLEk1NIed7kqGutW5jR3I=;
        b=sszqh8j4DerttvwpHxTcjUQzBhDGiWbZmhkguBqQaYK0ub3fMWO/U3x9rUhPia6485
         MWTw3UsQODCLCNO5Ji7djMTPbt42mDfxpgdQfWAliI5rvJnwnf4V5/D3M7sn2ZkrncvJ
         y+BxK5y9bi9nktDGABLanvR1sTapGK6SFQu2lqN4huboZhtQUH3rgvJ+g1+Bs0MkAZze
         ZarImE0xLnSac6sC+WaxXsDz13UFCDPjhnqqo+bxQ1euucGWgBDIrn+8J7DDJo/yzRlo
         tkv7aMOBNpPqush9RXtTjzvJQOl6UlK8hDMSr7okdJznq2ynvTobCd3dC2thzZRRLCNl
         nIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947474; x=1709552274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYL0y9tWhN7SH+jeAOGY/jbLEk1NIed7kqGutW5jR3I=;
        b=c32DxzEhO01+vQxsfLBk8wZpgUIWu0TMlXuWEZASKXm85BZCKZBF6UOOICyuCMroZP
         s0J8nNKrMui53Uo58QaVF5tfq/qb9RAXKYAymHxFXQZHARdMJQ7uMaKBLS/IAwh+xHqd
         OWwWa+YKJKGcTS5xnMOj50OlSYjpu/02oh1J57yCQv6yqztre1um62tZgu0g+r1W1Fwj
         3X8WDC/W0r5K3sj2xwE/GJEhhHkHywkgBvsgrNQvAiGDSYrv1FsFcybsF2ZSbQ7936E3
         C2GPwchbrCQEZXp0azadQqn9cUX6O7uCJt1ciFILekB2numDY/83sR1YztwDEwrAMcEn
         bTxw==
X-Forwarded-Encrypted: i=1; AJvYcCX58Wca616jOb+fQlrO3HhIOnc5s/uVyedn1umeNnx05v+pgq1NE+xR2/ZO4fO6dw/UUbM8PPiJtJkqnnBF7GWqw1O7iDyPKrQEAc6N
X-Gm-Message-State: AOJu0YwyQNP6obeTXf7VsWX6g9uPEmQCCiYRSKsg3v8TvumpwSNbjUIx
	3uQqIVphW0Oh5q/BxTqJ/TJYrcKtqOTr9Y33si0fS5Ov334aOfv+/DtGiXYw/w==
X-Google-Smtp-Source: AGHT+IHuWpaOENwwArEM6m/vdlMMGgNpfJ/kNDP4tXZvfsnC4dwJbFir7UIomSl1kHxj0YReiFgf8w==
X-Received: by 2002:ac8:5701:0:b0:42e:7f29:9efc with SMTP id 1-20020ac85701000000b0042e7f299efcmr4475781qtw.39.1708947474011;
        Mon, 26 Feb 2024 03:37:54 -0800 (PST)
Received: from [127.0.1.1] ([117.202.184.81])
        by smtp.gmail.com with ESMTPSA id q15-20020a05620a0c8f00b007878babb96asm2341842qki.94.2024.02.26.03.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:37:53 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 26 Feb 2024 17:07:26 +0530
Subject: [PATCH v3 1/5] PCI: dwc: Refactor dw_pcie_edma_find_chip() API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-dw-hdma-v3-1-cfcb8171fc24@linaro.org>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
In-Reply-To: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2890;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=WcbOX7Mto0c1BGHRXqQ6U7dCJ8afc+aUAohuOTqaRuY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl3HgFyYup7jym/LtqWaupNXR74OV2VbzwWJrkH
 tEM6mBeAL6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdx4BQAKCRBVnxHm/pHO
 9R86B/958Cp/+Pz70HZ9LC1l9vbXmsJZ5PmimkFurM1/Bd9WLaQ9SIK6kpmWAQhnckUZySHX48C
 X75w//3ffLd1MeUhpOQNERUXyl7+SEj5Ugydpun2zp+9PMxYWxZ2gpUWII4d/O5oR1WqER5qMNi
 SOQ6VUSBgJ+L7cGr89i4H/vrQoPASGw1lWTYRZ10BMeyOWoSyqelXUFGCBt122rc3UiueeGKH7R
 kjA16aYf4z8vZedV2pfzr/cu6+AW4qb8qiP9bNDSbeDlMZbp3jqTGKHTpIIt/fdigwip67GrNkC
 nADoNQAZQPsD3mfgstgk1VLFQXjZch0KhwolrHK8kfTgkmi0
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

In order to add support for Hyper DMA (HDMA), let's refactor the existing
dw_pcie_edma_find_chip() API by moving the common code to separate
functions.

No functional change.

Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 52 +++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b85..193fcd86cf93 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -880,7 +880,17 @@ static struct dw_edma_plat_ops dw_pcie_edma_ops = {
 	.irq_vector = dw_pcie_edma_irq_vector,
 };
 
-static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
+static void dw_pcie_edma_init_data(struct dw_pcie *pci)
+{
+	pci->edma.dev = pci->dev;
+
+	if (!pci->edma.ops)
+		pci->edma.ops = &dw_pcie_edma_ops;
+
+	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
+}
+
+static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
 {
 	u32 val;
 
@@ -900,24 +910,27 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
 	else
 		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
 
-	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
-		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
-
-		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
-	} else if (val != 0xFFFFFFFF) {
-		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
+	/* Set default mapping format here and update it below if needed */
+	pci->edma.mf = EDMA_MF_EDMA_LEGACY;
 
+	if (val == 0xFFFFFFFF && pci->edma.reg_base)
+		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
+	else if (val != 0xFFFFFFFF)
 		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
-	} else {
+	else
 		return -ENODEV;
-	}
 
-	pci->edma.dev = pci->dev;
+	return 0;
+}
 
-	if (!pci->edma.ops)
-		pci->edma.ops = &dw_pcie_edma_ops;
+static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
+{
+	u32 val;
 
-	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
+	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
+		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
+	else
+		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
 
 	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
 	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
@@ -930,6 +943,19 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
 	return 0;
 }
 
+static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
+{
+	int ret;
+
+	dw_pcie_edma_init_data(pci);
+
+	ret = dw_pcie_edma_find_mf(pci);
+	if (ret)
+		return ret;
+
+	return dw_pcie_edma_find_channels(pci);
+}
+
 static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
 {
 	struct platform_device *pdev = to_platform_device(pci->dev);

-- 
2.25.1


