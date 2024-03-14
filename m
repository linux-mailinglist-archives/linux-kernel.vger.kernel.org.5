Return-Path: <linux-kernel+bounces-103475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2D087BFDD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A2D1F223E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25F871B34;
	Thu, 14 Mar 2024 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LK7PBwQM"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90E71B5D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429853; cv=none; b=CNAkE7JqMCbrS5H+PU4MjD51hqFE8afQH1BjS+ngfwZJUct3L2/KsM6MzHknrxoPqEY7ABk+U/g9y0xFEO9AaXKCrFks9q0fCvgRPjL1Xt1z0nnsTD6ea52eKdK1AeVavfRf9mWL48yaZ6Ypntqf1bkmc2vOpvA4cuDzy2WY44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429853; c=relaxed/simple;
	bh=JRZLwKxhEM0x8HfB67G9+Fzppqg8xFqlyA8aRxI9XHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMKJs0NYfgl9vD5dh509jFg5sucNOdMBBuCRzLEZRyx9vpcXm13TwZST5j5jIdNfLXadviuvv+J2M5jHEsAki54B95PKcxAfA7+2CE4v0geAP7xRNp05mQdKV1wR2wVmie2AeoMqthba8ZDyBFsMiT0HBkJQ48csJbXoWFE1qng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LK7PBwQM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6b6e000a4so885700b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710429851; x=1711034651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IrOa9F9FCptyyElLcaGG4pDepSH3LTIYhrJfnXA2HI=;
        b=LK7PBwQMYWbLkvRxwvWy/ZjWPoXZwFihG1FkCi0AIudAoVAB1eS0H7bH/s3Oy6y6jk
         AF0rYbkid5IvNxMpChhQrDoMdEmVgp1vo/3+y8qmMI/rAnubePompPYvVzReDulzX1uo
         znWPI8C7hQ7CbQ94rPH/OCmc45KtaRYsRcckWj1zLLNAGwTiyhlLs+PNUWLdtLOAZPZc
         K7ufHM2XenZaIthORJ3vX0Ob+vOVNVNLsI8SJKRhetdnZ5+O/rdViopv6cbqRCxlyHK5
         s+/zYojZ32by9TLWxXMr9KYeZrHjwcYNalAIn9PuYIuBYNmGAPeXBvJuXZ+hZzkr0WGT
         lF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710429851; x=1711034651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IrOa9F9FCptyyElLcaGG4pDepSH3LTIYhrJfnXA2HI=;
        b=d7lWk4zlPgzlOOXT068sLTH5x7mk2BIBjRf4uC95MCi1RQrWSgsgxL2gJqoCSzKmfJ
         nyIIbGFTIwM3bHTJ5rfWLeCC736G5jQqICqzp0RtthwHKAvZ3updVXqDFCRwIZuIQ/UY
         p+5djJZDb5KcihXQrXKXVSv3ofPyEQ8sh7pHQuHwyND7JyAsRZF2LQyqgzwLJaTA8zjU
         qy7zzQG5DFQ2Fav4naLZY7XNjGzAgkI20lsscvE+vlSA56vbMcDMixjQrk6DKX8RBjqo
         a9ktNK9a1RB1kKlL9nPk+eqb6G7F777QYfZHuJE2SDgKMQ2N9LLvt6tPMJB426x0v3/M
         ZHWw==
X-Forwarded-Encrypted: i=1; AJvYcCVhR1hTzK5TQfr96SvpcewmlOGhvRUwjh/fPDrx4E/mDrYrA+8KhCX3OgS6hgBImt7ZaLPit1M0yxXkVvkklziisjRdlPR5yrYQGXj2
X-Gm-Message-State: AOJu0Ywc4DP/t4yWHCyTmRxqrZe9+FkJrM0aSoH42F+yohCmu7P3cyT1
	vGSd4Q7xmfDoCgGluwOGY+H0LV7Sc6vz/7l3lbnItVSG3w9aRfgX+HOKzmz8gg==
X-Google-Smtp-Source: AGHT+IG7jwbZIclHbE1GnAK6Rj5Bq8CoICWzMlScgrOOGIyJU6eaD/H0E/Up5FStL4M0GtXAcOvRKg==
X-Received: by 2002:a05:6a20:3941:b0:1a1:e41:3edb with SMTP id r1-20020a056a20394100b001a10e413edbmr3110511pzg.11.1710429850762;
        Thu, 14 Mar 2024 08:24:10 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id m4-20020a63ed44000000b005e438ea2a5asm824021pgk.53.2024.03.14.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:24:10 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 14 Mar 2024 20:53:40 +0530
Subject: [PATCH 01/11] PCI: qcom-ep: Disable resources unconditionally
 during PERST# assert
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-pci-epf-rework-v1-1-6134e6c1d491@linaro.org>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
In-Reply-To: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=JRZLwKxhEM0x8HfB67G9+Fzppqg8xFqlyA8aRxI9XHM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl8xaOLrQOPVb1HVr/175Bwj4SLK9E64perYmGL
 IBSuWUMVHGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfMWjgAKCRBVnxHm/pHO
 9ROLCACSxVDvqf0sTonqAB4efCgXpbE8NA//bIFdXLvO2DxsLrdraqYdwvMEiH+CAtxrSHwW3cE
 FCGe61CdFCnn3hhtoh05WnTStcOoxu7X2p8Lah7zUn7BBg7dScjvASClkPt0iqwsQjNhi0LmwHW
 xSofd+6XrLFHrATDGnodX1uVN2PcZZSXJdHw5oINOdggFxeHD1m9exuzvl6s5gY5SJ3lgg4q8Nw
 SZ86dARIy67pxK4Tkui+6vLp8YpJuby4gtksND4QVksT3VGTatVl30dDQE+e86Ntl1YgSKaJost
 K6XAXGDFLhZf0jQo8+mwwqh3P5s4NtOxeKumlgu2yg6kSQ4B
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

All EP specific resources are enabled during PERST# deassert. As a counter
operation, all resources should be disabled during PERST# assert. There is
no point in skipping that if the link was not enabled.

This will also result in enablement of the resources twice if PERST# got
deasserted again. So remove the check from qcom_pcie_perst_assert() and
disable all the resources unconditionally.

Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 2fb8c15e7a91..50b1635e3cbb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -500,12 +500,6 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 static void qcom_pcie_perst_assert(struct dw_pcie *pci)
 {
 	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
-	struct device *dev = pci->dev;
-
-	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED) {
-		dev_dbg(dev, "Link is already disabled\n");
-		return;
-	}
 
 	dw_pcie_ep_cleanup(&pci->ep);
 	qcom_pcie_disable_resources(pcie_ep);

-- 
2.25.1


