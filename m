Return-Path: <linux-kernel+bounces-64055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A5E85397E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C2AB26B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AB5605DD;
	Tue, 13 Feb 2024 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBMCa0sX"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F6605BA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847672; cv=none; b=BOr/UiR8squ+TPox64Q4VIygsYaB+yjg6aWr9uN0o+g3NHmV2ASNqsTHCT/MphmyGx+XUY5HYVLHZPM4rb5qi9oZ+j0O6lr7pir1FKf6iEVVjcGhkuhWESifpG0baa5OMhWUgHnnEjQEHufu6wqMjZpgAx9F2gR5IsVHX8iVInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847672; c=relaxed/simple;
	bh=GCgeemHEMjZObr29TItNfoPRYs3mnZZ8ua3W5kWq4mY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RM7XH2azJeJaXWiVSKYj812hgvwL2l8cUaaK9YY5hd6VPI69zYGMvGvG4yYl+JxStYie5Y+1hCLPrVb/gsh9SgqXjKoCGr0vXUL50w64cxuZ2c0RUciCjAjT8vVZ1iZUqF5Wj9yMu+UxedfUENUMCO9LW2jCoGRa2Z+e+FS/aas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PBMCa0sX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so6117919a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707847669; x=1708452469; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nvXkv/btphQ8MW54HksmzNQa+3jvkr/X94Oa7LChw8=;
        b=PBMCa0sX68glYuVtRESYoGSy5EYLyelv1inhXuWb2nqhHbhRa6+qB6CzCozLvEguq1
         kDxy3kLIyfvmCvKbE4ZTkKlm7A3XbkbTRSxR4NOMOxEiRJ2GyaOgejcVKvj3gDV3BvFb
         SECW2+G4I35sfl0vP5OjHcp060Q/QLOXFZhj99I78jcQEHXz3njEOpwGVFvo1Jy+BsxH
         aft7GnkCspwYbV40KJIpgkdQIC5E6yQjcX3sqSHZ27Pe15Kh6ftWbldAREA5YWvPHV3r
         mK6gz6yhLYf5aDHXkzXGuZFsGPPfshCPds2+hcRcXsumua8jmkcW5s+tRIn0x50s01gE
         +C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707847669; x=1708452469;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nvXkv/btphQ8MW54HksmzNQa+3jvkr/X94Oa7LChw8=;
        b=BNEV52/mlspph1rHSJQQedgHzVYAZVRk9h5tEWAsEXbt5RnzJkmrSruzEP2HNfyzdb
         31B+XUDMVXe/cygeNzAgwG3OPta3LMoCIFAPddwmI1dmQeHXB9HI2nNnVW/pnm9AlY5E
         D9aqEjYJqaBT4cZs1xTYG6NiD0/nGf6VtXPDOe1R3RhNOzlOQIt2Nsh92gc8CDeUDEKi
         bxn35Tkp0ua1HqbnUT6ID17cMavsE6Pw5b8tj9PTE7bBHpRwsjks62rVhi5aZ9r6aYzJ
         XGmQ5fsuW2RPjsTJLIl2mCvJMG15jZXhQgQHa0Wad1m8mGNZAwA35KP045q3UOKfRVZ3
         BkHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbYwunLJa4LyCRdzf/aSPwqAMu8rL/A8K5eUr8RQlJhz90WG7VrgydMAUGYFj/KEOcf5/w0JsJDDXiUI9i9xLGPbKli+X7yC6zlQaz
X-Gm-Message-State: AOJu0Yx6jQyeg9HSuf+2RAIhfXFc01eaLNqhHWy9I5lNGxEVkzeYL8bD
	vOtL8d6v9SDtct4EGrQ91aeqXkS8vKbuP0YAvJN3iJpBebopg1AF94+XcYaWMJs=
X-Google-Smtp-Source: AGHT+IGK8/ZBrBuhIG/7OAVoNU04LTnr1+ZqxDgeVB3c6G4zRJq+Lh+jgIpN6PATnoCEqrkuPR72MA==
X-Received: by 2002:aa7:d752:0:b0:562:1083:b7d7 with SMTP id a18-20020aa7d752000000b005621083b7d7mr311615eds.3.1707847668986;
        Tue, 13 Feb 2024 10:07:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrsKCNbf/H0BamORPHywycyrYJdRpP/MwEAylAwHFCf+pPW5AVS441po4B7fqyI8k9/YOXHdY3yHcze2IpAwPjUOYk7MRBB6D9Fxz9CMUHR8WPiocNWVasnjrrivezy6GFP8RMbcBCR1aRJNgi11vYB7EsWJTmMCro51Cq4t/HpNAE7aXCG4ys7jrY7/TeKL1iX76vc5SwjnwOCL4tp6gnko4=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id fk7-20020a056402398700b00561a443a393sm2498874edb.92.2024.02.13.10.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:07:48 -0800 (PST)
Date: Tue, 13 Feb 2024 21:07:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: mchp-pci1xxxx: release resources on error in probe()
Message-ID: <efc92197-4023-4bfe-bc63-452e7ed112e8@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Call pci_release_regions(pdev) before returning on this error path.

Fixes: 3e7cfd6ad29a ("spi: mchp-pci1xxxx: Add support for DMA in SPI")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.  Not tested.

 drivers/spi/spi-pci1xxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index a99db6163aec..969965d7bc98 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -776,7 +776,7 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 
 			ret = pci1xxxx_spi_dma_init(spi_bus, spi_sub_ptr->irq);
 			if (ret && ret != -EOPNOTSUPP)
-				return ret;
+				goto error;
 
 			/* This register is only applicable for 1st instance */
 			regval = readl(spi_bus->reg_base + SPI_PCI_CTRL_REG_OFFSET(0));
-- 
2.43.0


