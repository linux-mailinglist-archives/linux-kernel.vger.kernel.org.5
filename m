Return-Path: <linux-kernel+bounces-39781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E78D783D602
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB4C283196
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171321CAA1;
	Fri, 26 Jan 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnwjDeMZ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1011C2AD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258445; cv=none; b=QL5iKKuZ5DIsJYUCiNI5U4YKFziI0JCUPNDW06VIjnFdwfS5+F3kZrWgtRDBt4g6iiUopOwPm9b0OpFfmkbsI2haR+KfVlCsp2yNkq8jSqiK+p1O+j6vsQuDSg9n7hDFKSm+uUEQKrq1j82vh2gXguGB6EPz6N/dglJRY8lLLR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258445; c=relaxed/simple;
	bh=HdOkxYHBGdOriH1GG4cA3n+x/WczKYLs05GJtHkGUu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kNYREuZtBWmJdknBQJzrSTeaOq1OLa1cBFhZOlrS1SYQyl/KHT1Hn+BxC+mjp0wi2FiQ+e4fKJ39o6dGii3Ytsmxs+LsyQEUVw4RJekKtY3jkl+S+F/Of3aMBrw7M2NAEo3MkTXwz4bxj4vdT8siaCqH0f3qmMWnmZHwiqTU8Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YnwjDeMZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-337d99f9cdfso197138f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706258442; x=1706863242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM7me6hr0DgfYBqYZ1m5/5Y61fSb6nrf7rD27pa9FgQ=;
        b=YnwjDeMZv3BaKmVcvXYhajTfyPBqBOHwdefKPMdptCwayOJ0v4G2bg5DzjglXRHd0A
         btCfEYpP+g9HhCMC9n0oS1aMhXuQZJaiJs5QMmJAegVoaHL+KqvifGgyCgJrnMxPjUyh
         oFC5SnSyIYGEsxdaszRRTKivYG3flJ/gKnfrODIuRwBHbJ/VuSsW7epfAH7qpvKM7Hjb
         hxW/WVj1zBCN1fPim8YQFYCHh5GahCW+wQLEHmHhLrh2tbMLBTSTF4XqgZH7QcV3t2ed
         /f6PHul8tuZQd6W4C9S+ogwrOFYXXY7AZCpZMT8DcyMkx5kh5ymHcRZfgyKmjdLNN9gC
         gafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706258442; x=1706863242;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EM7me6hr0DgfYBqYZ1m5/5Y61fSb6nrf7rD27pa9FgQ=;
        b=ZI5YR++ZfN5AbB65udhFlXRrLHgZPCjVKitsB5M8e7YGhqPDGQpiGs0fqR0A8TXcdo
         WDIWXcjYzAgvDu0vfi1UIfegXtenxdnckWvKF2NehWDpeiRzyzu5vrU4rlZ+67Cs+cIV
         8bRTZTrtkhe8rVrF+BUweeooxMnlvL3xTnJVv7riM2C9xL80HKks7/8X8zZKNx+Vp+fk
         7fnJSusPIMjvgZHIHe/jAUR8weuqYFpUu1LSQ9HOfmBKZtSqDxW6k+6v6SXefZvdCOdH
         hyNxCFM3xI5xrDktm3W7xNSvXIbziP7TdJX0vCmeb6B1KhBN6htKub14aVx4FuiK4aJN
         wZ7w==
X-Gm-Message-State: AOJu0Yycl0rY3jTnbuIw0JPfvQr73YRmRkw2uRJPU/7+ygTguwqBo9mm
	dyri/Mh4uZAWdfvMbPr2u4SfdRZlo8xqae9RjLxTJMQDbUohi66sSGnecAp8mrQ=
X-Google-Smtp-Source: AGHT+IGHPb2CxwM2qpL6dKONYAgUO/n/8kVqCQ5TFvAG633n4nCm8O00Evt6e+Evh/2zxBYBS61Bmw==
X-Received: by 2002:adf:fa10:0:b0:339:2b28:32e2 with SMTP id m16-20020adffa10000000b003392b2832e2mr605254wrr.42.1706258441917;
        Fri, 26 Jan 2024 00:40:41 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d618b000000b003393592ef8dsm753877wru.54.2024.01.26.00.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:40:41 -0800 (PST)
Date: Fri, 26 Jan 2024 11:40:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Niklas Cassel <niklas.cassel@wdc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v5 1/2] PCI: dwc: Fix a 64bit bug in
 dw_pcie_ep_raise_msix_irq()
Message-ID: <af59c7ad-ab93-40f7-ad4a-7ac0b14d37f5@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email haha only kidding

The "msg_addr" variable is u64.  However, the "aligned_offset" is an
unsigned int.  This means that when the code does:

        msg_addr &= ~aligned_offset;

it will unintentionally zero out the high 32 bits.  Use ALIGN_DOWN()
to do the alignment instead.

Cc: stable@vger.kernel.org
Fixes: 2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
v5: Add the #include.
v4: Add stable and r-b from Niklas
v3: Use ALIGN_DOWN()
v2: fix typo in commit message

 drivers/pci/controller/dwc/pcie-designware-ep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b..d6b66597101e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -6,6 +6,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -551,7 +552,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 
 	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
-	msg_addr &= ~aligned_offset;
+	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)
-- 
2.43.0


