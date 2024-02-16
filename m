Return-Path: <linux-kernel+bounces-69077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2079D858431
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CD11F225B2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C03B132C35;
	Fri, 16 Feb 2024 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XdMP6QGo"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7113341C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104916; cv=none; b=hoxxqEI80G0pryVY1CFlxMapPwXTkb1ijY4P+ZCPjjKCzSKC2hgmnw/PpF4dDUZ0nkEq5I8A06nj7mbjQUXZ83FlvQvOzRJ7YCfnMgGTeMCzHHdx2WlHQxoeie6cGJ3syvt6abBKZai87W0mcW6QV/2mGG3UrFjHCPMAl53+TKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104916; c=relaxed/simple;
	bh=bNnVXR6L3kcnzQ1W5qCDxOjLhMtpGjDiA8ja4nbUZBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lsUisnBYIS8XyDe1VHG0obDtm95hbrWG8VJm5PioAbMhww4CDpZMfHxwEh/iSh2kTE6389pqN7XcNgAbjhfskoMMHBtDiFY8gk+WqYlh+/f50AXeYIH/9l/la5wxqAiP1oWbhUjH/PfhiDABMWHF7N80wFc5PUM5tD8oTIsm/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XdMP6QGo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d72f71f222so8045905ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708104913; x=1708709713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDNeyW6m4BTGEiUVj7puFwGWPFjKwT7Zu5mdH9vjNlo=;
        b=XdMP6QGoGj8bVU6PIJ/5+6SBe1gvx9ktMO+T9Zde+84ei5owXlvr+rT3nFgAzbQ5+z
         hYtqUtPhj1sfpBP1vkNlE6WZ/pBq+n/1LvM8mFFTWYf9A8cqmTsHtBMZCZAotpfI1i1x
         4pnqIkXDyEHQ+ztp91XvhP/4u2QwCJJd2GxG3nXuACD5/sj7ClodP5grxdhCJ+ZrG6Lk
         uStIWQsITr2JydmLGVTxoCoOzOXTF5o7c3NK6uvsP/5LTRULIPOWJNRFpTuQxM01SfQN
         EnfP9oAjlNeC7sxB17e/VHf41ZaUfrcBWMPlhoRWNecKh5IRZscpxE/4nLO2W4DofC5+
         0z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708104913; x=1708709713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDNeyW6m4BTGEiUVj7puFwGWPFjKwT7Zu5mdH9vjNlo=;
        b=mtzBFEZhu+ZzLDbs1YEdF7nMU5KwheQ428QWpg5XS6dkZ/l3Q0crSWivMOyaZcnSai
         fz1rxCQtFHWccGt9etfUBd1/Hbu5GXEJVYQuYJCb1Nc1jG/0zT6kgxY0UExO/tswh5Xu
         JJemmhJgeUjk9Qt/fhnKoGrAbVaaJEpHQXezR5F4kbljFFCVPAiMnBFGnVlaW6TBdEv2
         IfyJ97psEHsT1VUCCan9KrC3moKA6PM5NmW0BJ/iVXaGg1PPDhm2thFdL4zzZH7TCtql
         LTjbIhL+zGSv2w/3wTgKMCxlZADnBdf3dFqKnSdWi4ZS+LpVOi2z6NsX8GmR/qIsXqLo
         TCcg==
X-Forwarded-Encrypted: i=1; AJvYcCWHJ2UvADFv9cNxYtt/se1zXShv4m9V9Tbfm6Q92iKgpmx7Kb/Kc3tN6ya4Mz0ItBYSd3tqnkKuKygPgOW0gp3E6mFhjFnuUEEac0u+
X-Gm-Message-State: AOJu0YxpYyULiuB9emRJAS74D0K8JLfrU7WFei8lBdoJXStwSFgzEcqY
	4yKf+lM42Z55Ee9KBi9MnoOK+7wgGEGOwuEGsw4MEswcY9tml6GETfOlLqD+bA==
X-Google-Smtp-Source: AGHT+IGsyNn3mNv12tgQelDLLoo35aQUFAw/kHVMCOOKEv8w8Wkzb6KwjfgLIwjtiKot37EuV2E0Yw==
X-Received: by 2002:a17:902:784b:b0:1db:4b29:9b21 with SMTP id e11-20020a170902784b00b001db4b299b21mr5227700pln.23.1708104913087;
        Fri, 16 Feb 2024 09:35:13 -0800 (PST)
Received: from [127.0.1.1] ([120.138.12.48])
        by smtp.gmail.com with ESMTPSA id v9-20020a170902b7c900b001db5241100fsm118592plz.183.2024.02.16.09.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 09:35:12 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Fri, 16 Feb 2024 23:04:42 +0530
Subject: [PATCH v2 3/5] PCI: dwc: Pass the eDMA mapping format flag
 directly from glue drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-dw-hdma-v2-3-b42329003f43@linaro.org>
References: <20240216-dw-hdma-v2-0-b42329003f43@linaro.org>
In-Reply-To: <20240216-dw-hdma-v2-0-b42329003f43@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3317;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=bNnVXR6L3kcnzQ1W5qCDxOjLhMtpGjDiA8ja4nbUZBM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlz5y9ST0H2R6ShbbqEzDuD117Tis4bX9tke/qy
 ZDo5Q/SdWKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZc+cvQAKCRBVnxHm/pHO
 9Zk+B/wK63dSxW1bW2CzlTD3p4svLzBTxAAADKqa5609ZLV2lzA5c+F1+wWIaGjeORKNzMdbMSJ
 f6z7IcaFqqwvDrScULenCSF6eunG88xP41wIg1EF/p21hcTwjh1eVvXy2LtnTizeXQSMzp9PgRQ
 qokAbMVPf2XINZMTsYjYLxLQyjTw6V4DPMC087YNu0W/S6ABi3kLAZFYIobL+byp6f/gXeJmzzT
 fXl4XLkjnJ2POiJR+xFmY4IoVJeqRc6p4Y6Q+rwxM3yf3ihyDxI8l1levR/Qy93poZH9lVI8WNR
 qkkH950uk6qnrTrEuhXF1nxP3kFlbgDj3TLIBYgNy5vdLVC1
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Instead of maintaining a separate capability for glue drivers that cannot
support auto detection of the eDMA mapping format, let's pass the mapping
format directly from them.

This will simplify the code and also allow adding HDMA support that also
doesn't support auto detection of mapping format.

Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h |  5 ++---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c  |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index d07747b75947..54ecd536756d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -894,18 +894,20 @@ static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
 {
 	u32 val;
 
+	/*
+	 * Bail out finding the mapping format if it is already set by the glue
+	 * driver. Also ensure that the edma.reg_base is pointing to a valid
+	 * memory region.
+	 */
+	if (pci->edma.mf != EDMA_MF_EDMA_LEGACY)
+		return pci->edma.reg_base ? 0 : -ENODEV;
+
 	/*
 	 * Indirect eDMA CSRs access has been completely removed since v5.40a
 	 * thus no space is now reserved for the eDMA channels viewport and
 	 * former DMA CTRL register is no longer fixed to FFs.
-	 *
-	 * Note that Renesas R-Car S4-8's PCIe controllers for unknown reason
-	 * have zeros in the eDMA CTRL register even though the HW-manual
-	 * explicitly states there must FFs if the unrolled mapping is enabled.
-	 * For such cases the low-level drivers are supposed to manually
-	 * activate the unrolled mapping to bypass the auto-detection procedure.
 	 */
-	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
+	if (dw_pcie_ver_is_ge(pci, 540A))
 		val = 0xFFFFFFFF;
 	else
 		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae4837462..995805279021 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -51,9 +51,8 @@
 
 /* DWC PCIe controller capabilities */
 #define DW_PCIE_CAP_REQ_RES		0
-#define DW_PCIE_CAP_EDMA_UNROLL		1
-#define DW_PCIE_CAP_IATU_UNROLL		2
-#define DW_PCIE_CAP_CDM_CHECK		3
+#define DW_PCIE_CAP_IATU_UNROLL		1
+#define DW_PCIE_CAP_CDM_CHECK		2
 
 #define dw_pcie_cap_is(_pci, _cap) \
 	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index e9166619b1f9..3c535ef5ea91 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -255,7 +255,7 @@ static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
 	rcar->dw.ops = &dw_pcie_ops;
 	rcar->dw.dev = dev;
 	rcar->pdev = pdev;
-	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
+	rcar->dw.edma.mf = EDMA_MF_EDMA_UNROLL;
 	dw_pcie_cap_set(&rcar->dw, REQ_RES);
 	platform_set_drvdata(pdev, rcar);
 

-- 
2.25.1


