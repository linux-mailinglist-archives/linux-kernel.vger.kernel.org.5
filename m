Return-Path: <linux-kernel+bounces-41281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A0183EE61
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F5F284521
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E22D2CCB3;
	Sat, 27 Jan 2024 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kk/ygyyV"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9B31758
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372341; cv=none; b=IWodubF+0ggnXuHKeoIjY6HoOOg2L0FvwE/APLYuLiZoHB4AiBZlsVZ3YO27QaF96LEcJCvzrtryi8aKD9MDuleOqvW/M67pd2k4/hnrqCC3HTSocZYU6HS8qn7tmWyr52OeuMfiqUsb2MHfRK6kBzk5hG2m8C7BDNUeOdbfWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372341; c=relaxed/simple;
	bh=zf894zspmVhg+WMJ1y4vte5ionk4Q0cXbTXYteoPD6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UUdw4vgKrkueoph3xqVS9U3mVXlhnwdrMz85W+WR8zfVL6JkT9CK3MR7n556Ywm9EKMZUNLguNSpU6T1961vJeHXXePD2IA7rM0K0TAevji/EcmnqdQW655rI9Wc4oQF0et90SE7A54Z7IJFfkQCq5vEAjCKHCkcs6LCSVWK+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kk/ygyyV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d71c844811so7237365ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372339; x=1706977139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gS7tKJF9YkEmWkNlSPZ/rvbRwowleOoX+c6J0HN4mAw=;
        b=kk/ygyyVluU4mKk+1BJ3Qz3yZOU3w5Q6ruXm1BijWz7Na+5WJlJEBiOVHb4WtCWZae
         9k5DKWj7f3rqipqTvlpGElTE3RRKUP7s0W3eJ+N1AGpoFiV3QfgEWfBkpwpJ0FLYDFPu
         HWdCtM/JrA7+U8qyh0439iOG1UbU8ECJqBEA4XUqIdddw1Uw12Hvq3Drkk5hIC2QKBrb
         +vlrbrupRWSUAk0ZX2W1kqMVHb0weifqTpyAh9BaJ3LoNVeTV8DlEntlxdG6EHrc5qDb
         mNymPd5zxANX+9PPjSHirEUs3LqT3PkCrRLVrgNcmF5H3VAvQLnrK4EWhNdizx7hUt2O
         hpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372339; x=1706977139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gS7tKJF9YkEmWkNlSPZ/rvbRwowleOoX+c6J0HN4mAw=;
        b=U/+S5Au2iaFJwuVfgTVw5PMV9U0b5E5K8Kg1z3tcirICq0q2SO4sgZFvD/TLn9HZuh
         C1hpT4EAigtkVXbxGzzJHKRKswIB4sIix5ivrTTvSer4Ay6y5+veIPVeKWxFLawkqe5J
         WdV8KCi855Oi4vHIJMFqT5clB0EozFrYUAFEpGFAmRASvSHHHk/YbgxVOHCuvqb8yQl6
         1OhJbj7yiXx4RNEparZi86mc2DQCesSdLMmp5UpDkFtVJPfybdxQI8Scf4FP0UnOjOg9
         DCoZFcYj4nV1toZYTWEPBXmgC9czBCxsdwFAmyyP9z1VLH/LU7fW3mAcrzH1dyAwDP9C
         ABEA==
X-Gm-Message-State: AOJu0Yx/+Dw3OWu8++XGxtP13sv+fDotquGFQRDRwwFLDi7eBIs8DqZF
	+qEbD5yIV1IqVf7Ki5j5JEc+qSJJhhLp42qdOSyk3+Td8VPynCv11cXrR742znk=
X-Google-Smtp-Source: AGHT+IEBUp0hCCn7L8sX9sb+HHegemANWFUoOpOylQh+vsDyWc2YB/ckMjuHMjoiGdG/0Mue/ndfbg==
X-Received: by 2002:a17:902:cec6:b0:1d8:ae30:edbc with SMTP id d6-20020a170902cec600b001d8ae30edbcmr1005729plg.12.1706372339173;
        Sat, 27 Jan 2024 08:18:59 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.17])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ac24b00b00290f8c708d0sm5091620pjx.57.2024.01.27.08.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:18:58 -0800 (PST)
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
Subject: [PATCH v12 07/25] genirq/msi: Provide optional translation op
Date: Sat, 27 Jan 2024 21:47:35 +0530
Message-Id: <20240127161753.114685-8-apatel@ventanamicro.com>
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

irq_create_fwspec_mapping() requires translation of the firmware spec to a
hardware interrupt number and the trigger type information.

Wired interrupts which are connected to a wire to MSI bridge, like MBIGEN
are allocated that way. So far MBIGEN provides a regular irqdomain which
then hooks backwards into the MSI infrastructure. That's an unholy mess and
will be replaced with per device MSI domains which are regular MSI domains.

Interrupts on MSI domains are not supported by irq_create_fwspec_mapping(),
but for making the wire to MSI bridges sane it makes sense to provide a
special allocation/free interface in the MSI infrastructure. That avoids
the backdoors into the core MSI allocation code and just shares all the
regular MSI infrastructure.

Provide an optional translation callback in msi_domain_ops which can be
utilized by these wire to MSI bridges. No other MSI domain should provide a
translation callback. The default translation callback of the MSI
irqdomains will warn when it is invoked on a non-prepared MSI domain.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/msi.h |  5 +++++
 kernel/irq/msi.c    | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 9bec9ca19800..fd184309a429 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -412,6 +412,7 @@ bool arch_restore_msi_irqs(struct pci_dev *dev);
 struct irq_domain;
 struct irq_domain_ops;
 struct irq_chip;
+struct irq_fwspec;
 struct device_node;
 struct fwnode_handle;
 struct msi_domain_info;
@@ -431,6 +432,8 @@ struct msi_domain_info;
  *			function.
  * @msi_post_free:	Optional function which is invoked after freeing
  *			all interrupts.
+ * @msi_translate:	Optional translate callback to support the odd wire to
+ *			MSI bridges, e.g. MBIGEN
  *
  * @get_hwirq, @msi_init and @msi_free are callbacks used by the underlying
  * irqdomain.
@@ -468,6 +471,8 @@ struct msi_domain_ops {
 					    struct device *dev);
 	void		(*msi_post_free)(struct irq_domain *domain,
 					 struct device *dev);
+	int		(*msi_translate)(struct irq_domain *domain, struct irq_fwspec *fwspec,
+					 irq_hw_number_t *hwirq, unsigned int *type);
 };
 
 /**
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 79b4a58ba9c3..c0e73788e878 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -726,11 +726,26 @@ static void msi_domain_free(struct irq_domain *domain, unsigned int virq,
 	irq_domain_free_irqs_top(domain, virq, nr_irqs);
 }
 
+static int msi_domain_translate(struct irq_domain *domain, struct irq_fwspec *fwspec,
+				irq_hw_number_t *hwirq, unsigned int *type)
+{
+	struct msi_domain_info *info = domain->host_data;
+
+	/*
+	 * This will catch allocations through the regular irqdomain path except
+	 * for MSI domains which really support this, e.g. MBIGEN.
+	 */
+	if (!info->ops->msi_translate)
+		return -ENOTSUPP;
+	return info->ops->msi_translate(domain, fwspec, hwirq, type);
+}
+
 static const struct irq_domain_ops msi_domain_ops = {
 	.alloc		= msi_domain_alloc,
 	.free		= msi_domain_free,
 	.activate	= msi_domain_activate,
 	.deactivate	= msi_domain_deactivate,
+	.translate	= msi_domain_translate,
 };
 
 static irq_hw_number_t msi_domain_ops_get_hwirq(struct msi_domain_info *info,
-- 
2.34.1


