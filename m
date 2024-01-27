Return-Path: <linux-kernel+bounces-41284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63E383EE67
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BAEBB23D96
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCDD450EE;
	Sat, 27 Jan 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LnOKs7s0"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A345944
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372357; cv=none; b=KJHVPilGE31NMm7dvS2/HLnjXRS70wfxjQUQVLiZWc492A/z35L0y1EHMljJbZu14+eJqTm5PMnzrQMLZ+3kJ82TZttp+bQuvdF77He056bzpZBw1g+MQ4a4NrXXJ3Jg0l+SEK87gBhH/mfpLaDPZGzyJhc9CZNVgWhy+3IAfDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372357; c=relaxed/simple;
	bh=xcH/TMHnoQ/ciOIvqOw1HinQeQmtN3UXgJ/miOYB6K4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AW05JpWwBJ55/HPCEPTge3mcQILwmWYwa42o4mOUEigDMASzBbmX4XkxkMuXDXywYWvF2Ffvh3Yas4kdb8aXV007Q8N2MhWkGpGedZ3WJJGQN/euWSt7+br73YO5p2V6EO0tpMuSiV25hKz5HWtMqN9HpfFA1KK+pBrvbtRa9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LnOKs7s0; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-290b219a60cso893699a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372355; x=1706977155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSirNz5MKgvKyg3PpEGC1NXiMt4KceVCwKab+ZPE5BY=;
        b=LnOKs7s04JnW2pbRtAMDtY66UPBwsdvJPAfs7w7p+AnLEOqr7PQmBTpV1MNYfIJPHE
         SfigJzaP8BZOmEMli6WUhUADWCug/hLSJKnswN2Wsr2CABf7PWOx7mr2q8nrPpb7dTlr
         oqYBtq7McqAKGDj6ecyZdwVGozlurnj/sta3Kt6ccJ9jZOBr1GQk0QiJbQUxgKHQ1ykf
         5IxdWRfSCta2KbSucCtR9BVevvfZiktFUCYsXhAhOjgq0sHjk7BYbLBfWP4bsve8PeeU
         bITog5O10wPmkIIrSYRM0gGb0kbYghGEXInHA5ImMBtcN1aDwJ0jbsc3saTIaFBCif6o
         eltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372355; x=1706977155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSirNz5MKgvKyg3PpEGC1NXiMt4KceVCwKab+ZPE5BY=;
        b=iPNeJ0ZGhl5dk8awHOPdAgFdQ3UZr2b+B1Hcm0Mp+aiHZYVcLTKl5fRpeWQpJx6xKp
         JU5FTuwJHEjHRDl1hGnQZuKGTvY3THu7khodSA4/Z30kjR1q+LRoBB1rboB0UzQEFu98
         sckkhrQ15/+xPg1da9YV6qxri+JfQJzYt033uUKrhHvSmc0mD1+B80PCj4fbeM7kMUS7
         6NpTvlyHDPgx/FVA9Fwh8WqEYN7o0vlBwtK7vpyRB//a7qzLRUTMYMMU3U7fmuR3lNh9
         x4Rmk9OIaJwsH5hRAg3iARmlotbD+pBlKYWHKWYvvWe2bvSWgU+r8vkN4j1oDM2mfh9o
         pT4w==
X-Gm-Message-State: AOJu0YxE22MbUUUvkK9400Vj8rFTSigNauJePOvwqzTfWG6yQmT7beL3
	tXTq3pUyBrbspq3C/mZtUXahgY9vHISHxQDPdWd/XoxjpZqNwZ0A2MBa2+qkBJE=
X-Google-Smtp-Source: AGHT+IFTrsCPRXaYv+1mbbajZ/Ou+1apKh4pOIdfDL0/cy8BDEWqpmkz8q2egq9ITcbz+h7wTfrrQA==
X-Received: by 2002:a17:90a:a606:b0:28c:fec9:f205 with SMTP id c6-20020a17090aa60600b0028cfec9f205mr844337pjq.29.1706372355334;
        Sat, 27 Jan 2024 08:19:15 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.17])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ac24b00b00290f8c708d0sm5091620pjx.57.2024.01.27.08.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:19:14 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Saravana Kannan <saravanak@google.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v12 10/25] genirq/msi: Optionally use dev->fwnode for device domain
Date: Sat, 27 Jan 2024 21:47:38 +0530
Message-Id: <20240127161753.114685-11-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240127161753.114685-1-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

To support wire to MSI domains via the MSI infrastructure it is required to
use the firmware node of the device which implements this for creating the
MSI domain. Otherwise the existing firmware match mechanisms to find the
correct irqdomain for a wired interrupt which is connected to a wire to MSI
bridge would fail.

This cannot be used for the general case because not all devices provide
firmware nodes and all regular per device MSI domains are directly
associated to the device and have not be searched for.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/msi.h |  2 ++
 kernel/irq/msi.c    | 20 ++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index fd184309a429..ac73f678da7d 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -552,6 +552,8 @@ enum {
 	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	= (1 << 5),
 	/* Free MSI descriptors */
 	MSI_FLAG_FREE_MSI_DESCS		= (1 << 6),
+	/* Use dev->fwnode for MSI device domain creation */
+	MSI_FLAG_USE_DEV_FWNODE		= (1 << 7),
 
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 8d463901c864..5289fc2c7630 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -960,9 +960,9 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 				  void *chip_data)
 {
 	struct irq_domain *domain, *parent = dev->msi.domain;
-	const struct msi_parent_ops *pops;
+	struct fwnode_handle *fwnode, *fwnalloced = NULL;
 	struct msi_domain_template *bundle;
-	struct fwnode_handle *fwnode;
+	const struct msi_parent_ops *pops;
 
 	if (!irq_domain_is_msi_parent(parent))
 		return false;
@@ -985,7 +985,19 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 		 pops->prefix ? : "", bundle->chip.name, dev_name(dev));
 	bundle->chip.name = bundle->name;
 
-	fwnode = irq_domain_alloc_named_fwnode(bundle->name);
+	/*
+	 * Using the device firmware node is required for wire to MSI
+	 * device domains so that the existing firmware results in a domain
+	 * match.
+	 * All other device domains like PCI/MSI use the named firmware
+	 * node as they are not guaranteed to have a fwnode. They are never
+	 * looked up and always handled in the context of the device.
+	 */
+	if (bundle->info.flags & MSI_FLAG_USE_DEV_FWNODE)
+		fwnode = dev->fwnode;
+	else
+		fwnode = fwnalloced = irq_domain_alloc_named_fwnode(bundle->name);
+
 	if (!fwnode)
 		goto free_bundle;
 
@@ -1012,7 +1024,7 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 fail:
 	msi_unlock_descs(dev);
 free_fwnode:
-	irq_domain_free_fwnode(fwnode);
+	irq_domain_free_fwnode(fwnalloced);
 free_bundle:
 	kfree(bundle);
 	return false;
-- 
2.34.1


