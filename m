Return-Path: <linux-kernel+bounces-41282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B1F83EE63
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF331F232A8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4A031758;
	Sat, 27 Jan 2024 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="f8YtWLgR"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9241C84
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372346; cv=none; b=L2bEIhU9vhjM6YFARDJ2crA0O6jrKACRQT+7u1usQP/6zbd1FJTFyUB1lqrsztOcNVI8ZXHfViTxe0Gp2h2PA2YSEN7zxflVheNXNHKaZxzomfWzoPkKc3qbbkDcchQijn8oRHS1pbm+q8fkuvfBklYxqi1iMtvaTYBPcUTSkWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372346; c=relaxed/simple;
	bh=Zf4/ivIR0VEAEJonc6D3gdQYCPz0KYFQZzGI79d0D+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NlC1v3dsxjyzLPJQV0B5qCBUy1/ScXMRSvJLI3dCI7cES9Xv2bPhDLSkTLobl15Tt5h8pHGGl0BJ8p4OyUtO3GhZWmBxvCd3x3pI4GdXbBCH/NH5Bl+ht+zIy+s4btb1UUP8u38/lmm9znM9NdH6BmDLEaengXdC/3cnUFQQV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=f8YtWLgR; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2945ce598bfso728544a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372345; x=1706977145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23M+0gXGV/RoYlzBP/uez72ZRf4lEwzw20QI/B+WyQg=;
        b=f8YtWLgRtKhWyPfNWZTlKXkFl8Hehhmw0pZ2sK60hmsJfPxS/azizLSWl7JpmBGIwN
         vMJygjkUkqeVXJHZU+5T8UZOz8z76dTsrU/S4ooR0L3L3J/HsKdbud83M3e+nLFCloEK
         v1dAZOmVWCH4YDd7xyw4EpZvCmD470bWcNkipUorTSE+Z0h01PaA2l7G0yF0Ge9KLtgh
         SVsay+uIIfoUvtKEnWrXDgliLg+Ub9Nr/wSJXwHpN5JtRBGzlYl6sQCo7rR5BO6V+CQW
         tYA7c9LEeA6bBpUnlopOp728RNkXLJXhnWdDxYSGmBSVEEXgS8p1mcHBhR3FD/pUIXWn
         U1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372345; x=1706977145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23M+0gXGV/RoYlzBP/uez72ZRf4lEwzw20QI/B+WyQg=;
        b=MOy557Hy3yT8l2sxsGwvw1wjMf+aBlXBD8BlR4hB8tj0NFHv6JOq8EiXaQAIRKJB36
         KEyKLo/9hEgkwb3hSCJamqnBE8plGOPgzlvkKm1+Myq3afZOrRE7dXqd1EBq9/PH9Hnc
         wrfIQkQisX97UrffiPHDsYWFj2U5+Ox6lBRN0lsRw3yLZ0y1WvpRhaxREJmGKPh0r7Ng
         /OuTZtuwxRYdPdx2cWapHC4uiEhiA8t0KcH5gd9YWCs9hmk2tGVCpZLZyt2nJY29tKen
         R3P3jKUOT+Zh7rlDGpyeW6Zjcdb8jFv9XmUsJa80nBC/YTANZqdxFOhI++LcNIaW8qkl
         ak7A==
X-Gm-Message-State: AOJu0YxPRK/uXWmw65qmVuHZe+iv+L8ShN/TFxu0KkH0t3m94o8FtnSV
	ZUIN2oXnxedKefyV+n32Kq1WF61kdELqykTugw8ji+WSBWLHev6XBcpCqyNjT/w=
X-Google-Smtp-Source: AGHT+IGxyReUlRjncQOCaYSxlVLq+2NqHNbCh2EbsUwV16mHxFH7X7d8RBQAnkbApl0UltR3WftXHg==
X-Received: by 2002:a17:90b:3cd:b0:294:f682:b349 with SMTP id go13-20020a17090b03cd00b00294f682b349mr832564pjb.1.1706372344606;
        Sat, 27 Jan 2024 08:19:04 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.17])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ac24b00b00290f8c708d0sm5091620pjx.57.2024.01.27.08.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:19:04 -0800 (PST)
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
Subject: [PATCH v12 08/25] genirq/msi: Split msi_domain_alloc_irq_at()
Date: Sat, 27 Jan 2024 21:47:36 +0530
Message-Id: <20240127161753.114685-9-apatel@ventanamicro.com>
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

In preparation for providing a special allocation function for wired
interrupt which are connected to a wire to MSI bridge, split the inner
workings of msi_domain_alloc_irq_at() out into a helper function so the
code can be shared.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 kernel/irq/msi.c | 76 +++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c0e73788e878..8d463901c864 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1446,34 +1446,10 @@ int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid, int
 	return msi_domain_alloc_locked(dev, &ctrl);
 }
 
-/**
- * msi_domain_alloc_irq_at - Allocate an interrupt from a MSI interrupt domain at
- *			     a given index - or at the next free index
- *
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are allocated
- * @domid:	Id of the interrupt domain to operate on
- * @index:	Index for allocation. If @index == %MSI_ANY_INDEX the allocation
- *		uses the next free index.
- * @affdesc:	Optional pointer to an interrupt affinity descriptor structure
- * @icookie:	Optional pointer to a domain specific per instance cookie. If
- *		non-NULL the content of the cookie is stored in msi_desc::data.
- *		Must be NULL for MSI-X allocations
- *
- * This requires a MSI interrupt domain which lets the core code manage the
- * MSI descriptors.
- *
- * Return: struct msi_map
- *
- *	On success msi_map::index contains the allocated index number and
- *	msi_map::virq the corresponding Linux interrupt number
- *
- *	On failure msi_map::index contains the error code and msi_map::virq
- *	is %0.
- */
-struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, unsigned int index,
-				       const struct irq_affinity_desc *affdesc,
-				       union msi_instance_cookie *icookie)
+static struct msi_map __msi_domain_alloc_irq_at(struct device *dev, unsigned int domid,
+						unsigned int index,
+						const struct irq_affinity_desc *affdesc,
+						union msi_instance_cookie *icookie)
 {
 	struct msi_ctrl ctrl = { .domid	= domid, .nirqs = 1, };
 	struct irq_domain *domain;
@@ -1481,17 +1457,16 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
 	struct msi_desc *desc;
 	int ret;
 
-	msi_lock_descs(dev);
 	domain = msi_get_device_domain(dev, domid);
 	if (!domain) {
 		map.index = -ENODEV;
-		goto unlock;
+		return map;
 	}
 
 	desc = msi_alloc_desc(dev, 1, affdesc);
 	if (!desc) {
 		map.index = -ENOMEM;
-		goto unlock;
+		return map;
 	}
 
 	if (icookie)
@@ -1500,7 +1475,7 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
 	ret = msi_insert_desc(dev, desc, domid, index);
 	if (ret) {
 		map.index = ret;
-		goto unlock;
+		return map;
 	}
 
 	ctrl.first = ctrl.last = desc->msi_index;
@@ -1513,7 +1488,42 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
 		map.index = desc->msi_index;
 		map.virq = desc->irq;
 	}
-unlock:
+	return map;
+}
+
+/**
+ * msi_domain_alloc_irq_at - Allocate an interrupt from a MSI interrupt domain at
+ *			     a given index - or at the next free index
+ *
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @domid:	Id of the interrupt domain to operate on
+ * @index:	Index for allocation. If @index == %MSI_ANY_INDEX the allocation
+ *		uses the next free index.
+ * @affdesc:	Optional pointer to an interrupt affinity descriptor structure
+ * @icookie:	Optional pointer to a domain specific per instance cookie. If
+ *		non-NULL the content of the cookie is stored in msi_desc::data.
+ *		Must be NULL for MSI-X allocations
+ *
+ * This requires a MSI interrupt domain which lets the core code manage the
+ * MSI descriptors.
+ *
+ * Return: struct msi_map
+ *
+ *	On success msi_map::index contains the allocated index number and
+ *	msi_map::virq the corresponding Linux interrupt number
+ *
+ *	On failure msi_map::index contains the error code and msi_map::virq
+ *	is %0.
+ */
+struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, unsigned int index,
+				       const struct irq_affinity_desc *affdesc,
+				       union msi_instance_cookie *icookie)
+{
+	struct msi_map map;
+
+	msi_lock_descs(dev);
+	map = __msi_domain_alloc_irq_at(dev, domid, index, affdesc, icookie);
 	msi_unlock_descs(dev);
 	return map;
 }
-- 
2.34.1


