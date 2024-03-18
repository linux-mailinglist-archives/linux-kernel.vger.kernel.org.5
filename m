Return-Path: <linux-kernel+bounces-105727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EC087E386
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACCA28182F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8E5224CC;
	Mon, 18 Mar 2024 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DaIqC3rt"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC42D2869B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710741912; cv=none; b=d5WlUIiX7SF/zE+i27v9YNS+EcceX0ZSNHpo3AvkM+ndd8MjfW1v8zcVvSa9y0XMPNx2VBgKxBqJHcWRxVEZd91u9Hpw3CYlr9QGFH8LNz7rLnbnHV6HOBKJbzkKLrCE6l742E52CuVztGVinjv0DP9fTDgTJqJWK2hAMqLQVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710741912; c=relaxed/simple;
	bh=U8+MilrlyQLMqCKs6OSXrDnQL6lG3tUvuqNkFusZTRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9YAs+wujU9cPUZKd4WRFDuro+sRD5aTDgK0UOJvyi1DO8c+IDkBcOHpLB2gQtRofZUtqgFu6MMWlzDzL7rI1nuhibiLdjZEwjmCu51TCXUah+KAdhPnTJmcJnOmsT0JCLggBjCSpTdQwfCrQAf2gbBDGpJVzAvNk4V6tYpwhY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DaIqC3rt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6cb0f782bso3332312b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 23:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710741910; x=1711346710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHEwlZG3mvwmMDQMT2HCEzxvwXSOeNme8F0oQ3C5z7U=;
        b=DaIqC3rtDO7XqGfzQuuGiWqQZofKWFKH5r0zm50iYpgnnuUnqAWmrnjRohErCvSswN
         NRLpR9+5pVz7a4+99Rvl8bAm5dVlTWPh+v+nCXcDXwrnV1b/blo6AMikD4uHfsDykemd
         gaV78uKmrFrMnP5lxgV992CpIJ5Iwxhpf3k7YncEwFzFrq592+frWT2S+Wm4H+qSEsKz
         RbaoH9nI5UvWnzBPL+en4BjO9Q4IRBcVm0I2BY3sdZeHOMSyLeAVhAo3d97K0FudtBai
         9cnA98cSJvnSt9Yzun3AHBxPefVnNKfuUT80skior5P5A4NdpReBAPRW20bYGhpG4FZs
         bhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710741910; x=1711346710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHEwlZG3mvwmMDQMT2HCEzxvwXSOeNme8F0oQ3C5z7U=;
        b=eG9swGb6FPnsd9BDzzIhMkbZaYZeMy9mRrOcx4LuqAEhYxm6mGikXIAaG5mRcl1JBM
         whL1KWhvHXq98h8Zvhpwh1dk1XJJZZXESbUqBzne8YsRctNS9cEBDvw2JgHOAOi7TwuZ
         ZrpZyYe7gc6TztVksKMVCRQtVV1ng87Y85Wl2Kdq759VA2rQlKXQy9pwu0ua9KpzRMyy
         ZHuetQ+NYYyHgc5FmqNQAIJibYXuj/QGvp/msENqD4cyl6hoiB5QvtKpUkNdijFFxySA
         ySEMSZbEM5NhWgrSKoQK/KD9hUWbWTQxMbXh8boCCNotIsovWyddVxZMyZCd7x3ZwVXu
         /PUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMjGQlH+V+MxLb03FuPwv+Y5yzdSIVjUllh+TxDCR8+KJoCLyG/rqHKrd7iuYgfwZkk/pyLmVZLSwCLuxedJMHoHXSzqEkCmGUUrOJ
X-Gm-Message-State: AOJu0YzCnFIVkZb9whF7ZEw9xGoHIg1/npsKNxWTi5Vx6AGTgu8oMKT6
	Q8niKa2Jq+LjXL2YUTUIaB4ORB5oBQlSydu70DUH0IaMOsr1K288e8qaVMYKlQ==
X-Google-Smtp-Source: AGHT+IHRiqTI3exT9aUXPbfzfVdObRz6enkM4iNtqTyeJuNf5FUoBWRaGXuUEOw6UXOxL9Yjxzhl7w==
X-Received: by 2002:a05:6a00:22c3:b0:6e6:a8f5:6dc9 with SMTP id f3-20020a056a0022c300b006e6a8f56dc9mr12829827pfj.2.1710741910035;
        Sun, 17 Mar 2024 23:05:10 -0700 (PDT)
Received: from [127.0.1.1] ([103.246.195.160])
        by smtp.gmail.com with ESMTPSA id p12-20020a62ab0c000000b006e6c5b065f5sm7064268pff.28.2024.03.17.23.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 23:05:09 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 18 Mar 2024 11:34:29 +0530
Subject: [PATCH v5 5/5] PCI: epf-mhi: Enable HDMA for SA8775P SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-dw-hdma-v5-5-f04c5cdde760@linaro.org>
References: <20240318-dw-hdma-v5-0-f04c5cdde760@linaro.org>
In-Reply-To: <20240318-dw-hdma-v5-0-f04c5cdde760@linaro.org>
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
 Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=HBFaoOrEPY28OgpXbosd8HC8b9IU9rla4yFX01mozG0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl99l4wGU2gTqdlRV7ctpg1FXFpW0CfJu/Dmtgj
 KkLJ+xYBzSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZffZeAAKCRBVnxHm/pHO
 9Wo6B/9EvqeiSaP7MDStogYrCCg1qe5Iq3029Z58RjdUkm6zgDfGxvGM4fVgAjcgMOIjKu4eE4+
 tK1ebMbz2DjiEE/Xmcp9Y9cpb5f+R37U9Q98qD5uOuKVZbyy/0J7Yk5QK+bbJdGyrWkhMp7zqCf
 3XCPBdvGLdxg507ZRXbp56Qtsn8T1e67Mvsc7pFDGNPkF8CQTTZOq8/juHBWjgIzM21XxQIliQJ
 TKsDPCrI9zKgQgyQ+BPFJVKPYU9kNaL8AANuGLza4TBm3DVtCsXllcdpK4qUycZeBlwtJRCaejm
 n2gzXu0iE2JSBtQ/iCbiGPW5cHOrnYq1ah5hjGfFlPBEeHrh
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

From: Mrinmay Sarkar <quic_msarkar@quicinc.com>

SA8775P SoC supports Hyper DMA (HDMA) DMA Engine present in the DWC IP. So,
let's enable it in the EPF driver so that the DMA Engine APIs can be used
for data transfer.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
[mani: reworded commit message]
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 2c54d80107cf..570c1d1fb12e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -137,6 +137,7 @@ static const struct pci_epf_mhi_ep_info sa8775p_info = {
 	.epf_flags = PCI_BASE_ADDRESS_MEM_TYPE_32,
 	.msi_count = 32,
 	.mru = 0x8000,
+	.flags = MHI_EPF_USE_DMA,
 };
 
 struct pci_epf_mhi {

-- 
2.25.1


