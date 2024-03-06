Return-Path: <linux-kernel+bounces-93739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2908733FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B3928FFCD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FA1604B1;
	Wed,  6 Mar 2024 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2rplGcq"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41D604A5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720548; cv=none; b=HcBLaxty7dnzFb2L9m/+kz0YPTfENcugif5GHzkT1iv8ASN1jn+acfi++4fGZ5RGU6PAf1TEzmJGil2eO5Lve4IWtdukXHPtVFqAYi9z6Cm5QuSTPGH94XposqSklrMm8lWlV5AffKgOtgE8//06Yl3GV9GHggXLr2gRTYciO20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720548; c=relaxed/simple;
	bh=mLMfdy6vJ8u6UFYqXs9q+faj+NP8cJu4pP+nxeyn4zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u24zIZ0IL8TzzhpPyQjskK/j4Vtdi0QMuJbjbHBhJ+8RW2VhpEmDlz6eOSvWVtFtVQe6Q5TRniyWgDqdXjEaxlbNCsQcrCd5OQGY3G8gu9nPxaynefYogkSs9nPW53CNzPks9qwi28LijwZRaNpmTsEY+XKaovd67VfwppJrZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L2rplGcq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e56d594b31so1199059b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 02:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709720546; x=1710325346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUQ9XWlgCeD+qBc1N72QvBPRBPOfUQkP0LYdZ/Y6AbU=;
        b=L2rplGcqhtL8Z4Z41eXVWAb8FjHCD/Fpk360MHYZBP57z0gjqUmVve8aQg3dPS8aD7
         zWwZFV+BMPrQtEB4R/JSmMm+93BsK5WYLhBXRXBeuqclLklG5ocQKBC3LX5z2wUcsQFF
         2eO9nthNzZAla69xRDCVFMmvxpyp7tMOrvOlJ90hPmVnYi6nEDyYABpHsUjZUqUPwX3M
         pG0kVTwb+Sfu4TVH5asANYaIsDFMx9X1g0Ihg9JXLa0AbD/HzXx5NRt4FAJcFThvt1lh
         oLRAo+w4WeI4xnoYapMcBYpeWNrUR/TIhhTEfkHAsHJwkB/NqgQc/EPca5HNkuyt70+j
         pTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709720546; x=1710325346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUQ9XWlgCeD+qBc1N72QvBPRBPOfUQkP0LYdZ/Y6AbU=;
        b=FfKHdlQcg57clXGTFFTk/mAb0Ft0ccMB9OsDZ69MVqWT0RIMHabUqk0FOh8RjFI9SG
         drC6twu1l6Oz49gu/E4YQZrKakVvgDA5b/sujbr23wzw9zk/YJHzRryaupfF6Z1tobOs
         /v7IOBPq/cpqeDR45VkGtpqzxGHIM4K8EJcxWXofiPFB3DlC+ZhED+MPDegu2pot0uIO
         FBPtqGrjUIEnz1M864cJynH3QlKDrhoNKke+RTsWxyRhRC53LLKS5B/hH2+iJFZtVHXp
         Fj6bxRpaeZxl0OsH84lzQ3XMgZkjoPqW7e37pq+TfnTwbm0ak/bJ0MTTvVX3k8tbBADD
         WK9A==
X-Forwarded-Encrypted: i=1; AJvYcCXfhkL9ySHL+nhoWFKod/mLwHeUxuWYxyM1URPPjygwjKBUOOxPWbyM2aHYSuIJ6+WrTvt/Ajv76SfbcmYYOphpYHfxYbcjGF2lgi6Z
X-Gm-Message-State: AOJu0YzV7lcOUGA3o28CXGU8bcKT6YrRNiD68YVXcRdL2IAr/XWvHyaz
	BKAKOVk1y3oyFuW3qJ8zWUTOI14mynq+5VF1g8mFoimfHBPHU1X8x/RpaPjJbg==
X-Google-Smtp-Source: AGHT+IGEl+uO45/L5kaer4TMZee9EwJRvAeYBFgo4H3HFlzRMyufjyHqhd0EeUIgxSUxNcsGcJGUYA==
X-Received: by 2002:a05:6a20:3d8a:b0:1a1:69eb:923e with SMTP id s10-20020a056a203d8a00b001a169eb923emr458653pzi.41.1709720545706;
        Wed, 06 Mar 2024 02:22:25 -0800 (PST)
Received: from [127.0.1.1] ([117.248.1.194])
        by smtp.gmail.com with ESMTPSA id li17-20020a17090b48d100b0029ab96b13ebsm13339320pjb.40.2024.03.06.02.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:22:25 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 06 Mar 2024 15:51:58 +0530
Subject: [PATCH v4 2/5] PCI: dwc: Skip finding eDMA channels count for HDMA
 platforms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-dw-hdma-v4-2-9fed506e95be@linaro.org>
References: <20240306-dw-hdma-v4-0-9fed506e95be@linaro.org>
In-Reply-To: <20240306-dw-hdma-v4-0-9fed506e95be@linaro.org>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2114;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=mLMfdy6vJ8u6UFYqXs9q+faj+NP8cJu4pP+nxeyn4zg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl6EPQyESvJ4GkYeWVdmmhe/LYWOiSlTkv9PB2U
 Ak4oVW39WeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZehD0AAKCRBVnxHm/pHO
 9bkJB/43VwynoOjr97Hyn4f9NAAsXZ3g5Coo4C/ThVnpEziOI1xQJCQgrUNQfLsvsMPSRNT5txj
 jZAj4BHz+obZAtt0RrAz6pHTKuUVSwwfLvHxUd2XuiKp4i7LzPoaSnrvC9JHzazPLqoqylPDTZl
 hRb8ja1BR1OXakF0l3Iy1jYinK03yHOk7JkwzsLfBxGaXFaneH/w8W7yqofD9m/K+SBjS6NMOw3
 Fp2n9LLIR1YhMnopygSQgHS8GVRR/hGiYv0W8wWzAjaS0oh+S+urGsuXT/LXIHxjety2o83Hy/u
 IJShgwoeEN2PLdo/PCu4NaA6x++MXluNt8CJQ7pM4OqXLsqA
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

In the case of Hyper DMA (HDMA) present in DWC controllers, there is no way
the drivers can auto detect the number of read/write channels as like its
predecessor embedded DMA (eDMA). So the glue drivers making use of HDMA
have to pass the channels count during probe.

To accommodate that, let's skip the existing auto detection of channels
count procedure for HDMA based platforms. If the channels count passed by
the glue drivers were wrong in any form, then the existing sanity check
will catch it.

Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 3a26dfc5368f..599991b7ffb2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -927,13 +927,18 @@ static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
 {
 	u32 val;
 
-	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
-		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
-	else
+	/*
+	 * Autodetect the read/write channels count only for non-HDMA platforms.
+	 * HDMA platforms doesn't support autodetect, so the glue drivers should've
+	 * passed the valid count already. If not, the below sanity check will
+	 * catch it.
+	 */
+	if (pci->edma.mf != EDMA_MF_HDMA_NATIVE) {
 		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
 
-	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
-	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
+		pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
+		pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
+	}
 
 	/* Sanity check the channels count if the mapping was incorrect */
 	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||

-- 
2.25.1


