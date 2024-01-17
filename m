Return-Path: <linux-kernel+bounces-29319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC876830CC0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 395F2B21577
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA623752;
	Wed, 17 Jan 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TwTr7tL+"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57F22F0D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516335; cv=none; b=CEWLmvsOcU9nACQUEcX8zbo4e88gMFMZ1G1HMtuIr5C+Tm3GxxsapS1dDe6AwEKVN3l41MmkA0qnjJj2iCOUY+hEtQ++U1aFWfepbeJ6zAntXbJF4+3f9UZHatSgvdz3UTlbLxsJPPcMhufVRiCNqSacv+UlGyg2hFOSyzi+oeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516335; c=relaxed/simple;
	bh=GJoKVb2+DXUwHo6EryFUbR0bKGFrwQdlvWC+jGiPY6k=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:X-Mailer; b=ikATTLcBp3AOA9Bq2sdBnowqktNlw9oT2h3NG+g9l8mXsZ9SC9ShKgwZmuDsdx6xbiYrOICAtPiiaZKxjaijFMJzS/9SeDNqrj2RZ0lTa1ohCJcXXd33VHJtZwS/jS1K82rkxyvGsU5QC3a6XL0P4KE0Z2LRlHSWqHvFjEpLxEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TwTr7tL+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so126812315e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705516332; x=1706121132; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dowglsIPVbYVAFa4rVjn+rlDsEzlw1XXMllVZiyv4c4=;
        b=TwTr7tL+WDZwmHbKemDUyUDIWb4rMpnc4+pKMYXD0kBmNUhOxA2BQCrDumLI49gUkE
         SItrJ7H+S6tadYJjJB0HhN6c7BO4OguGscHfxRnOnavEK6nTgFWY20WxemizPHzBDsI2
         1yCI9pmUvXn41H5HhNmLIDYwGWm9MTTMOmle8NHNJPE4m8M5FVeh+h6wy63h82g4pFTk
         hE3JYSyUOy9LMoGkudQ1dytir8o/fvxTRHzJiNkUB/ooMJ++fajbjI9Dr+fmwzwgGA5S
         wGwcFo0FefarJ73kGoG9DNY1hiOjL/AOcI4Uq85wiJdwSXfWF6UnNs/dw8tust6D57Iy
         ml8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705516332; x=1706121132;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dowglsIPVbYVAFa4rVjn+rlDsEzlw1XXMllVZiyv4c4=;
        b=HZRwYQeOzQsWQdNtWIRjGE8hF5l0fVQG/aUt+jxr0HZdQswvQ73u/TLk/8ir9mWUlF
         29iICT6dkHpXwPllIZTZ/07xclkuEabYFLs+mKVadoKU9f6HU7K8QpnCevWj+Z9zoJ+r
         FXN59xYbhAlvYg0eReQODmcKhqxstzGigTcfuCHcSKMOB4XeRP/YrRaJs4MMbkX2/NdZ
         L2EeqSC8YTCRI/Ce9gtQ1Fgm5lxmfD9TblFYqzr67a8UEsbuSpo0LqRMJ5j22HCzUrkP
         brxZw30jMpHRdCuarmrhf1v61LlKZopnKt551LU0tO2HdeuKklRhJ4XgaukS86b1xPAw
         3fjQ==
X-Gm-Message-State: AOJu0Ywd9FionUedehd4wKVSW6VEO5ism1+/2QT1WnDNezZnqWSySXsd
	YZloODTc95hq5QuQRZeHWfIax+f9qm4kYQ==
X-Google-Smtp-Source: AGHT+IEerS4tRmti12dAHzaJBQqQIekd1m4weeIk92C/xIkzUsjHTdaIpdo1h9j8pRaeTCy5m+p8lA==
X-Received: by 2002:a05:600c:45ce:b0:40e:6e84:e95f with SMTP id s14-20020a05600c45ce00b0040e6e84e95fmr2723425wmo.252.1705516331931;
        Wed, 17 Jan 2024 10:32:11 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b0040e549c77a1sm27223849wmq.32.2024.01.17.10.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 10:32:11 -0800 (PST)
Date: Wed, 17 Jan 2024 21:32:08 +0300
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
Subject: [PATCH] PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()
Message-ID: <3f9f779c-a32f-4925-9ff9-a706861d3357@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "msg_addr" variable is u64.  However, the "tbl_offset" is an unsigned
int.  This means that when the code does

	msg_addr &= ~aligned_offset;

it will unintentionally zero out the high 32 bits.  Declare "tbl_offset"
as a u64 to address this bug.

Fixes: 2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis (not tested).

 drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b..2b6607c23541 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -525,7 +525,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct dw_pcie_ep_func *ep_func;
 	struct pci_epc *epc = ep->epc;
 	u32 reg, msg_data, vec_ctrl;
-	unsigned int aligned_offset;
+	u64 aligned_offset;
 	u32 tbl_offset;
 	u64 msg_addr;
 	int ret;
-- 
2.43.0


