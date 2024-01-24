Return-Path: <linux-kernel+bounces-37217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121C783ACAE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD97E1F260CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6017A720;
	Wed, 24 Jan 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyhySwho"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3021363124
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108510; cv=none; b=epFKZMkAmaH7Nr5+4bdUceB6ntagfIHPw8cqgsov88qJujpLirbCs/7pLS3dQs3GpPEV2zngwmVjVCxzsC7ksW2K2aei2FYlOOCZ4RG71I7ApeYXgfyt0vSXGfF0kKaXhoxUfkMghoYpw5r34pL6gI8iAEYVNF5fEoGgK1bVrIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108510; c=relaxed/simple;
	bh=vXo7kwrg/JEtFg5VNFewRcL3UlxCm3whtvjszAzZPYw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CMITfJncLSdMjssUUWnTvdL/dQUBFoIz+xyjkodZ2V0wM8Hw8AMdW+9fkOmdmiiJWV6FMGSf5LcgwHSlmpRMnOHG+8igXsniohdGV4RK9E3BHfcvjwBUg/fySLtlKRoU0OOL62easx2QmWaeuNMXVj3k0VhS3wMm4Etc0bA5USQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dyhySwho; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3387ef9fc62so5153492f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706108507; x=1706713307; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wddH6dLZWFvD4sBtP23ayzipvN9tjMLSLEUIemLS/70=;
        b=dyhySwhofWH+JkOgzDfSLBlzS9igtUKpI70OvObtint2kwDXlu+crjO9IJGnpK4TI2
         zjwSGBmTDmNyZ7UsPFTWn0XgAcLA7cHnQWozb14ep80vxlgnCsvKc+XAsee6vFQ1xw74
         mxZT2wKqj1JIJ4Gl2MdzeWGElr85Lnyj8ss65BMn02is8cLtiQ7IBXMPhsEiuH/h2dKa
         By74+WvCjk4lIxVaq0FoAZ/8kq1IgZPlYsZhnFWSn7W5SOkn87eXMhJm3pnHB170beGM
         G0IUm0/bhnKz38V3tnQKWNqS+GnfnxrSZ8W8tVTQRGJSmzbjdbyXOIygJTVc1MOh3CMC
         7f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706108507; x=1706713307;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wddH6dLZWFvD4sBtP23ayzipvN9tjMLSLEUIemLS/70=;
        b=aEqGdfVCjJRLqqHYX6xIByuMQQOIVMVzQ1DqXP27TWUg2m2XUU9tXNpBZv0FS18rWo
         kvNZ6tcATnNQIVB7rYtYKH2QJd/HcRqTj93RXJyoCJNrVIkjJPijwcGtqfTBVUt8F5A/
         nmTwo7tUspTooCRzUXg6O+A0+MYmQM6OIdQSHrBEAp1ydvNqzuVybOSWBINy6nkeG0c3
         FKegWzC+zupvlWbo4sPlLTmE1nc3HqpoxaC6jhfsb4W6fJ5LK4wgSyhnzmXmnqTTJToj
         gjcPHDII4vbUDGR2aotcwkYf/1wbjU47ONPlsIumO9cv+AhX590mf8L3a9zQBIc2Ir83
         R2zw==
X-Gm-Message-State: AOJu0YzziEBAHYs1r1ryNEvqCoPnTbnhGiMLIaKPQWASykHGnYQ+oqiO
	4h9SsqAGRjpBlfWUQ3ykIcHcsDTW0UA8IZWnBWpHeO6wAJGpg1JovqQ9kZ+mTv0=
X-Google-Smtp-Source: AGHT+IHXHhrcwAHRLUnkX2s024mT8pEXvkb38AMMNc+9E2uH9gcDtJhJhoQ9GTqAP9FJosVbKHujPg==
X-Received: by 2002:adf:ef12:0:b0:337:bf29:b6ca with SMTP id e18-20020adfef12000000b00337bf29b6camr701919wro.23.1706108507315;
        Wed, 24 Jan 2024 07:01:47 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d62ca000000b00337d4ce6ab4sm15999360wrv.20.2024.01.24.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:01:46 -0800 (PST)
Date: Wed, 24 Jan 2024 18:01:42 +0300
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
Subject: [PATCH v4 1/2] PCI: dwc: Fix a 64bit bug in
 dw_pcie_ep_raise_msix_irq()
Message-ID: <888c23ff-1ee4-4795-8c24-7631c6c37da6@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
---
v4: Add stable and r-b from Niklas
v3: Use ALIGN_DOWN()
v2: fix typo in commit message

 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b..51679c6702cf 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -551,7 +551,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 
 	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
-	msg_addr &= ~aligned_offset;
+	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
 	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)
-- 
2.43.0


