Return-Path: <linux-kernel+bounces-37218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C7B83ACB7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028FD1F261C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1F743154;
	Wed, 24 Jan 2024 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pf6e+/lA"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AB18624
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108637; cv=none; b=u3oU0H5TSge5fNM7Ks6rj9+WDq0JYIEW9ovgyhIIq9s0tj70Ir4+GyYBulWLlbqCNkEl4BDGtIi+AfShVTtHp0RrZBoo1GvmQNC3EtWjlypD1MuTsJQrA2ugjEMauHJ4K2bSbbcJ3x2mj37M1EtDJdiw3qKq9d2HycvowPhO19s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108637; c=relaxed/simple;
	bh=T/pn351JESsRmM/aRPuZIGT3H4X/z2umZFJ27SQOtmM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QfKiFeRFC4ju4eeSmcQYC4UFHDJ4nAocg9233BGa3Ch+sgU7pi2QjCqU+vHqQQuUkcJ1hMut45ATON9ia3m/gY4I2fdJgZBT3QmbbpEGq772rP95w4VxYgQTQXoHL68YZrH1ej+I2Ut7+6QfaLmNPqJNL6PFNBpsVjZop2JiBhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pf6e+/lA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so61465455e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706108635; x=1706713435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VlaR5UjpyG5Q22l5wBG4NSdMskPDkfH7d0hZ/q3K1b0=;
        b=Pf6e+/lAMoKPiAFz/fjTwAzAEOBeXmpzGuwQwb/M7m67wgWiZx+bn0IYip4CLyxFsP
         m6ZyFPZiQKxbOWFi+1ECBCzUgFyyMZmFNt8GYm/ftZbNeoDRZMqel2fpxy/9llpmkBRS
         lvVxM4T6Qp3IhSIy94H21WOF5Sosc2I+2kg99C5RcOlgRFAP1DpFxR0IbhfNrRhnt61o
         3796hbD779jgNbpGLo9lASUT5TNGySAxEwuM2HD/fZK+Yo2xJzacXn/YHdk7b7KiZddz
         XwJLUAvYiml6DpuhPxpBZMAEj1uvz+CJJSPV0jdudh+NGdKPGYcBCdfKvQmpoBWHAQpD
         hcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706108635; x=1706713435;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlaR5UjpyG5Q22l5wBG4NSdMskPDkfH7d0hZ/q3K1b0=;
        b=fLf/6FNtV7lAweQovM9zaeVM7OgD8chIuXGgEFkHwTyCteTjervw6WiELfdlKvhxor
         KnV4WYuQi7nSXbU5A2vnyRDLsHuAxD8hlfXvnDSlXIPh5wLzaOtjQ3r/MJtpXx1lqUFg
         Riyx21F7FQ32+ztCG/WySd5vxbSrrKdNiLJ1GsgpVbpkCsE8JEMe8T52wszXMhuKB1Wi
         IJ0vlwdhblvyec7mK2/vQfjW4jatZBIT+/iYV86jsmSD8tkP3W0Ppv91mdkc8tN3JDxS
         f24KR4VGmf1SotDDlC7V/BDp3vXD4tbGBhJxIMnGVNbNlcNzUEQrhoB+EWgSQZ/HBCGr
         9NuQ==
X-Gm-Message-State: AOJu0YzRyFcPcjabQ4Yoob5c4EVHPtkILAw1L/fMELzAESVEUObMz8u4
	ZIZgEDMmFy9ZjIcyT69D3LinYZSVBrk15WcMteHS6s+m6cCQhxCEaEkMfnJ3vBA=
X-Google-Smtp-Source: AGHT+IGjsZLHD8kGFRZjmgj+ilkWj1OOfr4o3eEgd2290Aodbjq6/EXsgNVRRYOC+8mBQzRIcutvbg==
X-Received: by 2002:a05:600c:1d04:b0:40e:c337:fbe6 with SMTP id l4-20020a05600c1d0400b0040ec337fbe6mr1131335wms.106.1706108634709;
        Wed, 24 Jan 2024 07:03:54 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id f7-20020adff8c7000000b0033921c383b2sm13626449wrq.67.2024.01.24.07.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:03:54 -0800 (PST)
Date: Wed, 24 Jan 2024 18:03:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v4 2/2] PCI: dwc: Cleanup in dw_pcie_ep_raise_msi_irq()
Message-ID: <64ef42f0-5618-40fd-b715-0d412121045c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <888c23ff-1ee4-4795-8c24-7631c6c37da6@moroto.mountain>
X-Mailer: git-send-email haha only kidding

I recently changed the alignment code in dw_pcie_ep_raise_msix_irq().
The code in dw_pcie_ep_raise_msi_irq() is similar so update it to match
as well, just for consistency.  (No effect on runtime, just a cleanup).

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v4: style improvements
v3: use ALIGN_DOWN()
v2: new patch

 drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 51679c6702cf..d2de41f02a77 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -482,9 +482,10 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 		reg = ep_func->msi_cap + PCI_MSI_DATA_32;
 		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
 	}
-	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
-	msg_addr = ((u64)msg_addr_upper) << 32 |
-			(msg_addr_lower & ~aligned_offset);
+	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
+
+	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
+	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)
-- 
2.43.0


