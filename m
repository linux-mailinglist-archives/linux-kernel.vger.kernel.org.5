Return-Path: <linux-kernel+bounces-118832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A60B88BFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99023B25A09
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018A86AB6;
	Tue, 26 Mar 2024 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKI9rqcO"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DCE14AB8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450143; cv=none; b=livYQj0vvpVorRkECfTrjDLUbuuXemqtriRZ6apY3dKH53NpuoJQdSOIklBdom4quJ7WZFG4FA5QfkEHkW1lV1qb8jiYa7MNWjppTuC1BZuaVc2J4PmIHtv9yV6ozvdixU3Crc4ybv/rjoPrEbfwXfCQzil4frx6nbAXCwFOap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450143; c=relaxed/simple;
	bh=a9jhEQgepLFu1V/9oFFkAbVrqrZxzbztMATHDJFc3OU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WhA1Cu62BIvGIxjWXf7So9JYquXxvXuYyrSP0K9BsyGiMfz2DuoVM3h2k3g52eQZoWlYuFbzgTh8PJg+wr64M+RXFUS0m9i1ZusOf2Fg6vs5v5uSjZcsXoUnrqNIieHrVeWy/uREnkjlhqB4MKitVPAlJlzpHBrG5l9p8myVtJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DKI9rqcO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a0782f0da5so1066368a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711450141; x=1712054941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3SaotDWl/4tLhYj27mIQOcHctxJufPLQpgAq2r/Phs=;
        b=DKI9rqcOywAd/xF3C0HFG0zlBOPpf6/tdssQ9ECGiIrOYlM0+27o5d8M53lawXcz5L
         wEQQR80kSaPJX9H9NoAI/cyw0nnVkF1lJedokvO7BKIP0eASiioZv4zv8TpG6PL6A7tw
         oIyzCv32Yr/nqRn4VRUUBNrfQT6NRqDLWEN7SwKf0zwB00TP3RB49GlIBrYNn9G/0/jf
         PUS4IZ4ypkc/mHRJh+i9AOCvGzYpnnrqkhHgpmaR6d3Jok8tZISq4kdwhbPRzkPCYNcm
         ZqGT0VbrkB+yw6q1Ry2+DGb1SSf8JlIIzlhyDxvjH3OXH2vGWjWAx3NPsoZoU3ArFEiA
         b1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711450141; x=1712054941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3SaotDWl/4tLhYj27mIQOcHctxJufPLQpgAq2r/Phs=;
        b=NCvC2JntpYO3iuWDSpv30/Y3kNHX7l8FM4P2W63u/egfYF33oCxFv9mmwfh9Jvp5yX
         /Fd+WJ1uzUHLenOsKRWvEWCYuhPnnq/DIY8GxAh9KhrqHOOXVO/2T08iINWhSH2kbqa8
         t4j7akRuTXCI8Rfren1tk/4ozkjwg7EwETNbDOKTZPoByELs55MbB+dDsNcqcY/s40lC
         qFBSejua7WS1gyAkGDfR/S4FrmfGPLPmQ+ysc++LaUpkIQBTEFnd57/2sIOKN8CggrU+
         wQuLk22saGkA+v4qW9TdZUp6UJvjNfQw6zigcpQcDBZ6/yIuwiCAgCjgTSeDQx57yXEe
         kokA==
X-Forwarded-Encrypted: i=1; AJvYcCXe9kmI2iZjECyAlh0T/UiyrqnDe7P1SBDIZ+ACZ0DtOztSpZs9be+yHsnZ1emhpZ2QXjMyTkcUTjsAbtdR9TOY+27hro/xU2Y9YiUy
X-Gm-Message-State: AOJu0YyQKhxeMfDwaA74fZnN+jxYnoL3a1tL4xnA07iF2UW5eJpZiP4T
	HFt82ecZaKrZUUl6PZwB7pqEPJH34eALGIrD6wFvEAVH4PP0JwvEGViGpvhNSgqVFJSQ3Qs25SI
	=
X-Google-Smtp-Source: AGHT+IHlO3+pLdIHsXr+Zqk4ZTZm+g6rYTdPkIaErY2qnQHcr3IGV3c/Zdyg8NfbLAv1QA3Qf4eobw==
X-Received: by 2002:a17:90a:c788:b0:2a0:8eee:5603 with SMTP id gn8-20020a17090ac78800b002a08eee5603mr706623pjb.6.1711450140840;
        Tue, 26 Mar 2024 03:49:00 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090a059600b0029fc196159bsm8777218pji.30.2024.03.26.03.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:49:00 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 26 Mar 2024 16:18:17 +0530
Subject: [PATCH v4 1/4] PCI/portdrv: Make use of pci_dev::bridge_d3 for
 checking the D3 possibility
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-pci-bridge-d3-v4-1-f1dce1d1f648@linaro.org>
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
In-Reply-To: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, lukas@wunner.de, 
 mika.westerberg@linux.intel.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=a9jhEQgepLFu1V/9oFFkAbVrqrZxzbztMATHDJFc3OU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmAqgUbSOKJVFNG5vo+m1rTB5ZtU8V4c/GTGvtz
 SRWC0jHPCGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgKoFAAKCRBVnxHm/pHO
 9X8aB/4mHeDmAABHwdZVT2KCy3Oi2k8U3Euk7a/eKi2F/KDGkvTB2juxg6mHFSYM6GAAuFUEMqv
 H1bqB0ctCMAnm5M9Ic8ML+rjdYiCCs9iX4FoXtSkqIyMg/Ggvcugfyq0z7cSSmSSVchACmFV1zN
 CxqohHwRG9XlbS9KWYTXkDRs77JklCpTdk4Yb4wTD8sxVCevT9xo0dNymysXSEwDVr8c7oNTTX3
 EVeeOnwqSgTgtNxsxVLVRlme4T+xTuZVYT9IXPrPtq0KWXk29YZZ3RvD8R96F3tVWLjByX3oFh9
 fmHw26ZXd7Fl0Ca0GWeUwfyszN1gouLii9fer4v1Hb2tPDra
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

PCI core is already caching the value of pci_bridge_d3_possible() in
pci_dev::bridge_d3 during pci_pm_init(). Since the value is not going to
change, let's make use of the cached value.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pcie/portdrv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..1f02e5d7b2e9 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -702,7 +702,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
 					   DPM_FLAG_SMART_SUSPEND);
 
-	if (pci_bridge_d3_possible(dev)) {
+	if (dev->bridge_d3) {
 		/*
 		 * Keep the port resumed 100ms to make sure things like
 		 * config space accesses from userspace (lspci) will not
@@ -720,7 +720,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 
 static void pcie_portdrv_remove(struct pci_dev *dev)
 {
-	if (pci_bridge_d3_possible(dev)) {
+	if (dev->bridge_d3) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);
@@ -733,7 +733,7 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 
 static void pcie_portdrv_shutdown(struct pci_dev *dev)
 {
-	if (pci_bridge_d3_possible(dev)) {
+	if (dev->bridge_d3) {
 		pm_runtime_forbid(&dev->dev);
 		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_dont_use_autosuspend(&dev->dev);

-- 
2.25.1


