Return-Path: <linux-kernel+bounces-128951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EA1896231
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209C328A3CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F905168DA;
	Wed,  3 Apr 2024 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTqReZOu"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C4A446A0;
	Wed,  3 Apr 2024 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108556; cv=none; b=UT56JQLvEt9Qp1D71KCtSQofxuwfsiwgkvUW3DmqosHGa9l98xEuoUOvd25gWGGa8sEGEQRvAHnixnRhyTcFvMU8DRh+ZUuVu00s3NKT5mveKDokOAj5dwjng+VjRLAjlz4wVftwVIpQ1a5wEfaljNbZBgv70j7G+scKbsGcs2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108556; c=relaxed/simple;
	bh=bOt7Lce4d3VbCB33CfvJ+I4snWQk1P/8JXlCcBzwy4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lTNIP+hxH16mvmGg9uLrY1A2dM1qYJww/34/nJzUJkIkBW0c17gp6udGXGm2E0ThlkjYzrGiCTcq8JMEtetKqLwclSDeXZcFFpRgIPdygx5uLVmbrFSW3+2nMLilCEQkT4RWrvBRO6GomwDQIrTuYeHFqXQwU0LJqbaLgs9IX2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTqReZOu; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-6ea8a0d1a05so312779b3a.1;
        Tue, 02 Apr 2024 18:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712108554; x=1712713354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GbX4v5RI4uqyKHjkEDVu8FsmiWMDcOp1p4Bp3bU0p/A=;
        b=UTqReZOudCctUO1UAB/gszyFPNokN7xtm0OrCDVIHQOnryN04JdovXVj9dc8cNz7CO
         MlHYPWk2N3xRDSJzesUjtzWJt3xTNjPnpmr7Quafl/ekQUMULuwcDz5WC5hMJOJ+2XOe
         DnWY39L1NZVhE6UOmtaCeyzq51Zqmb7fTCclFFUxzcnZxH4EXwchywtOqM2pW2Y5Nsqb
         3p+9ft6iuVouqNrQm9VcnGcW12LDY++FAKa7b2sj4yk0LfKVY1AnvwTyTWkRKRBKzBgp
         iX3vN6ToblDDny9k420DDH+P7wYZfaYcAVGXxlyYTzID/ZUXxWKiqNLcwhR3L2QPlBds
         Ke6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712108554; x=1712713354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbX4v5RI4uqyKHjkEDVu8FsmiWMDcOp1p4Bp3bU0p/A=;
        b=NQ0iKOi9yirWQlsmw1NEiuadoIHhoMYeVQ2Q66J0qW9DtvObCQGs5Y3poE1g082f82
         CdUTNiBuJejoycLob6XEZ/AovgGup8BpWFm3b8ZrokmMHc6GhRawsl8n01qdrDVTEGhn
         IEh1+2gvODbGu/qsE0nazDXUBs6QddFanY0es9g/K8L4VKv8yiMNJYjhkywNYtWkr+nB
         29aYplRwHJrtrDj0pFBbhtLr+vXDFN2QXtdB0kDW7IjwAbXseNCtOs24WlCXr4foKmbP
         n5nnaAFKAJZHr2UaNmt1b7cZw9W4JeSW/z1cBuDQamiybTrggA/tcmVxtdtjShl3YFWP
         uN+w==
X-Forwarded-Encrypted: i=1; AJvYcCUm+fKF4GpINr2mXxoCEWyZTobCVJcle7ljztjCDQdX/AYJqRy9jOjYAkYrjwIoyh+J11o2orOFnZN4MSCzf3Fv9JiKtdILagqKd6Nu
X-Gm-Message-State: AOJu0Yx7S1UR8z76iAZJg2arGHyMfW3AlhfDYJyCGQiiak3zR/jaRDdX
	rjTRKdY1cKn8LAslW3GzbXNhezQWMPKLsOlPS40OhGkScuyg32Un
X-Google-Smtp-Source: AGHT+IHviSRaCh4G02siGZLLy5onMzIQqZw2Dvq2RXo0uEecf9JUbqpy0ZBPsH4RTzqhUOlVs7qIAg==
X-Received: by 2002:a05:6a20:7486:b0:1a7:2ccf:260 with SMTP id p6-20020a056a20748600b001a72ccf0260mr389812pzd.9.1712108554269;
        Tue, 02 Apr 2024 18:42:34 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id fi13-20020a056a00398d00b006ecca2f2a32sm1400654pfb.168.2024.04.02.18.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 18:42:33 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: [PATCH] spi: mchp-pci1xxx: Fix a possible null pointer dereference in pci1xxx_spi_probe
Date: Wed,  3 Apr 2024 09:42:21 +0800
Message-Id: <20240403014221.969801-1-qq810974084@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function pci1xxxx_spi_probe, there is a potential null pointer that 
may be caused by a failed memory allocation by the function devm_kzalloc. 
Hence, a null pointer check needs to be added to prevent null pointer
dereferencing later in the code.

To fix this issue, spi_bus->spi_int[iter] should be checked. The memory
allocated by devm_kzalloc will be automatically released, so just directly
return -ENOMEM without worrying about memory leaks.

Fixes: 1cc0cbea7167 ("spi: microchip: pci1xxxx: Add driver for SPI controller of PCI1XXXX PCIe switch")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
 drivers/spi/spi-pci1xxxx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 5b2d3e4e21b7..5a4226682052 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -275,6 +275,8 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 		spi_bus->spi_int[iter] = devm_kzalloc(&pdev->dev,
 						      sizeof(struct pci1xxxx_spi_internal),
 						      GFP_KERNEL);
+		if (!spi_bus->spi_int[iter])
+			return -ENOMEM;
 		spi_sub_ptr = spi_bus->spi_int[iter];
 		spi_sub_ptr->spi_host = devm_spi_alloc_host(dev, sizeof(struct spi_controller));
 		if (!spi_sub_ptr->spi_host)
-- 
2.34.1


