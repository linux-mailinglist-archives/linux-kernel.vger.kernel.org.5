Return-Path: <linux-kernel+bounces-39783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDA683D604
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB30C1C26899
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D002E12BF02;
	Fri, 26 Jan 2024 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMoWsR0b"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717FD1C6BE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258468; cv=none; b=dudQKXsITJYy0w94+wlKl+r+EpiI6ANT2b/D0ULvHF31aVFR6CMIE8sTrAk/LavL9aFHbzPMtUnjJH1tYl4Gz/6itUsKYIJBCj1BCN+FBn5LDtJ33paFv+Xe6L/G2mV/OU+RGOLbe/OeAwKBxLyDCu2BlSQCrfYySDKMI+aZVxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258468; c=relaxed/simple;
	bh=xVnB7uNU2aUwkZfdKtBk3UVgE3IhZNWmluxWDjub8oA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eA2x4xTQPLUbJW2f0wtVuf9I0b6qp/IvhTE27k00pdsH02zOF6xHvQUFn3uCTeJzGqNga7T3/i8Gh7bX/KCNpVia/1AT1kG9j/RfugUn97haGvbsMsDCt2mSorNYtytZ5tFsZ0Nk9i3OfGb1nIUNEJ5Y7inpfg4G0bj3UOS2LAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CMoWsR0b; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40eb033c192so765605e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706258465; x=1706863265; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XX7Apx6LKiP4Pc42nzu4TYMSpS+o60Wt9NvNj/zb+0Q=;
        b=CMoWsR0b/WtKBU+Q3agudlT37Ebw+8U2UkdQmnfuyJT/XXNIQ29cH9ClgJ6DjDpuRS
         +4jrONbEy5tdbNw24iFkEUfUXfZvRzVPXdrqHqhflS8+JdR8Ns06UDiUEGOt3ysto3Vx
         j2U+QQ3qyUENudea6ZfhA5dSlyY9d2luQ7T0JUg8LiXf/eZfRqabOkSb9PxsKxpEX8MS
         X4RN1avtTgC8DGGPrKc1RacvWYPIqNO5xK/v3SHXjZraei8T3pt6LfEm+SnIz27ZYm8H
         sxr43J+186yG8yNvYWC/f4E5vwOuZvPX1U3ertsFRDDteK7GWfdmjSUOO+Thssu6J4Bn
         Uzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706258465; x=1706863265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XX7Apx6LKiP4Pc42nzu4TYMSpS+o60Wt9NvNj/zb+0Q=;
        b=il2xocr6d2EAfIJSuA+jq7AXxjJVxKiQDssQh6e5y9UBzQtxBPsk2hZPx1yzZyO+xZ
         VVWECv912+l5eZgVQqBzWKR6P0NJWK4O7eOjcxLcl9gZVOXwROd+NtIDOO28KCC6+f8D
         uNuogTSDBhiHtyn52AIwWxwWDuSxsUC1GCNLWeub6XVvZDGgGDCLfpu5vh86vs92FP1z
         y7/T+C+CFA/tv/DHZ11abH7cXpDPI0RLz7FYCYPo6Iv7YXhUX8tMPmG6zXUXMmSL7sht
         xoA6zmxzlTcRv1AKfb4BUm9xVGRsn0skFXsxOS2Fv5g3udBnCGULnZimciTlVRnBppy0
         9r2w==
X-Gm-Message-State: AOJu0Yw26gqvB+xVHXvdskiudFNTtX2HW5AQKkceZvhRmYy38y8p8Lc2
	HUckN13qsg86IPfaudIlYPWlPf7BjZeA/UriSv0vk/WjnHiRn+ft1GKGvInlD8I=
X-Google-Smtp-Source: AGHT+IFEq7uN14GEgOVUGh+XC+r/ZDyY6Ub0iEHePwZ1sqpDBMr1Xyrz7nwONatue8o5Dk2Kx2qp8A==
X-Received: by 2002:a1c:721a:0:b0:40e:a555:803d with SMTP id n26-20020a1c721a000000b0040ea555803dmr303589wmc.74.1706258464813;
        Fri, 26 Jan 2024 00:41:04 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d6847000000b00339272c885csm750140wrw.87.2024.01.26.00.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:41:04 -0800 (PST)
Date: Fri, 26 Jan 2024 11:41:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v5 2/2] PCI: dwc: Cleanup in dw_pcie_ep_raise_msi_irq()
Message-ID: <184097e0-c728-42c7-9e8a-556bd33fb612@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af59c7ad-ab93-40f7-ad4a-7ac0b14d37f5@moroto.mountain>
X-Mailer: git-send-email haha only kidding

I recently changed the alignment code in dw_pcie_ep_raise_msix_irq().
The code in dw_pcie_ep_raise_msi_irq() is similar so update it to match
as well, just for consistency.  (No effect on runtime, just a cleanup).

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
v5: no change to this one
v4: style improvements
v3: use ALIGN_DOWN()
v2: new patch
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index d6b66597101e..9a437cfce073 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -483,9 +483,10 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
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


