Return-Path: <linux-kernel+bounces-41285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96D583EE69
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40D9B2251C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB86845BE2;
	Sat, 27 Jan 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XBvviF9v"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AFB45944
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372362; cv=none; b=WVI4QR2JIMWNKiTAgfFB7nEoKYr3XGFexvuyZYrIJUZNXPbtcP4OfYqridAwzzjNhMvW44xKT7/WJ4XLrt7dMxYwsAvG++9X0NJWF5RBpP4edNRhqDYNQGxaFsCxbdRj2piPQfUCQ86PJHZiCtoEGECEi/evxkvWpOEtpRi8wio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372362; c=relaxed/simple;
	bh=Z0bsXyy/eyFNkb57963VO9376500pOd5o0/Yx1fXsWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qu/sfL+cs6cIWT0+1siktga7lFp6iYIpm8QHAz2YZl7yEvad2ZZbma0ueDkZIsAdMLyCmdUtYtzQxZvJNQ8c5VRy5K4z654JqQvh5nKoy5dyZc9IHB9G1+XXf5bLM/gClREGE9sv0VN7xjljESSFYMIcchKGf0MuZwq+zcVPEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=XBvviF9v; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2954b34ddd0so83947a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372361; x=1706977161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEJHdx6IO6bkVVTImbulpm/taR3P8DZhF8xpLu8rn5g=;
        b=XBvviF9vR8CDy+tyYmsv6RACy2gCSNoCBOoie0NgDOqClzp2DSu7zuppiODXIucUuf
         MdWkismK3jtupDved9obhsBkUJd5oN4PEPDnhQkTLuQDZohfynpqNr/J0gXxcBmrYo2Z
         7Rr69WFk25Xsp4BwG+JNRLuFYBFloG7t6YQ9kNf3wfysEB14BovhN18XvH3BfEH4Xik2
         kUG+/kZRjEyvfSpg0VYpCnU7/A3tUbaM6Sl35M6NK5HIa5VD00XopiFiMmUsWI7wupPk
         1Lt4sdpxLgcZAqZJi2UlnIE3J5cI43s7fT+4ia8zlH5m4YttLdz4/5yK9RNMUJMKycrv
         WGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372361; x=1706977161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEJHdx6IO6bkVVTImbulpm/taR3P8DZhF8xpLu8rn5g=;
        b=JqR1wOzEKFyHU+NmRJU+EKlCr9GH6wc/CzIemySr/9ysCq0Gg3XzeI0CSPANpEq1DG
         qTCEf1NjUhsAtbV1GH7NKe3+hsWJoWlQF+NCx1ULodkBkV/iZoy2oaowHQ1UohHodBGT
         gzLNKIzHppJOtUDC7NfvEkDdHSn2eBTWOXY/0UeKfSM4yISArD+5cE9ie/rihQdqbuLs
         ykXqbsJsvg5IDg154K2465jUDMrS3QSfBjBPkeT96HBJgkHBAM0XBw6tFa2jLco2I3zM
         1kcng8kqpVFIpOyOkSsUldSzTYPfKTIm+v5CEZaNt74kTPGLB6+d5lXkUuHRdMXRAuw6
         tLtA==
X-Gm-Message-State: AOJu0YywrPC8/myhxQ05L3xVQo8ZYxuVScEBnqz2baUislT0zAGfQUme
	sMhUGqUFohuvMzhhw8GYOqrc2MxTSBIt8DaLfvTjQL7G7ba7YCA/PDKUI7xu6BM=
X-Google-Smtp-Source: AGHT+IHIUpc0CrfHqSQkzgTdflfoO24IxiwZWgRJHvY8gpPilqZuNaET7dJ7J6HgrcXpdxUGvM2U8Q==
X-Received: by 2002:a17:90a:780f:b0:293:d89e:349b with SMTP id w15-20020a17090a780f00b00293d89e349bmr1219751pjk.57.1706372360712;
        Sat, 27 Jan 2024 08:19:20 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.17])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ac24b00b00290f8c708d0sm5091620pjx.57.2024.01.27.08.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:19:20 -0800 (PST)
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
Subject: [PATCH v12 11/25] genirq/msi: Provide allocation/free functions for "wired" MSI interrupts
Date: Sat, 27 Jan 2024 21:47:39 +0530
Message-Id: <20240127161753.114685-12-apatel@ventanamicro.com>
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

To support wire to MSI bridges proper in the MSI core infrastructure it is
required to have separate allocation/free interfaces which can be invoked
from the regular irqdomain allocaton/free functions.

The mechanism for allocation is:
  - Allocate the next free MSI descriptor index in the domain
  - Store the hardware interrupt number and the trigger type
    which was extracted by the irqdomain core from the firmware spec
    in the MSI descriptor device cookie so it can be retrieved by
    the underlying interrupt domain and interrupt chip
  - Use the regular MSI allocation mechanism for the newly allocated
    index which returns a fully initialized Linux interrupt on succes

This works because:
  - the domains have a fixed size
  - each hardware interrupt is only allocated once
  - the underlying domain does not care about the MSI index it only cares
    about the hardware interrupt number and the trigger type

The free function looks up the MSI index in the MSI descriptor of the
provided Linux interrupt number and uses the regular index based free
functions of the MSI core.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 include/linux/irqdomain.h | 17 ++++++++++
 kernel/irq/msi.c          | 68 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index ee0a82c60508..21ecf582a0fe 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -619,6 +619,23 @@ static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
 
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
+#ifdef CONFIG_GENERIC_MSI_IRQ
+int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hwirq,
+				  unsigned int type);
+void msi_device_domain_free_wired(struct irq_domain *domain, unsigned int virq);
+#else
+static inline int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hwirq,
+						unsigned int type)
+{
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+static inline void msi_device_domain_free_wired(struct irq_domain *domain, unsigned int virq)
+{
+	WARN_ON_ONCE(1);
+}
+#endif
+
 #else /* CONFIG_IRQ_DOMAIN */
 static inline void irq_dispose_mapping(unsigned int virq) { }
 static inline struct irq_domain *irq_find_matching_fwnode(
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 5289fc2c7630..07e9daaf0657 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1540,6 +1540,50 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
 	return map;
 }
 
+/**
+ * msi_device_domain_alloc_wired - Allocate a "wired" interrupt on @domain
+ * @domain:	The domain to allocate on
+ * @hwirq:	The hardware interrupt number to allocate for
+ * @type:	The interrupt type
+ *
+ * This weirdness supports wire to MSI controllers like MBIGEN.
+ *
+ * @hwirq is the hardware interrupt number which is handed in from
+ * irq_create_fwspec_mapping(). As the wire to MSI domain is sparse, but
+ * sized in firmware, the hardware interrupt number cannot be used as MSI
+ * index. For the underlying irq chip the MSI index is irrelevant and
+ * all it needs is the hardware interrupt number.
+ *
+ * To handle this the MSI index is allocated with MSI_ANY_INDEX and the
+ * hardware interrupt number is stored along with the type information in
+ * msi_desc::cookie so the underlying interrupt chip and domain code can
+ * retrieve it.
+ *
+ * Return: The Linux interrupt number (> 0) or an error code
+ */
+int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hwirq,
+				  unsigned int type)
+{
+	unsigned int domid = MSI_DEFAULT_DOMAIN;
+	union msi_instance_cookie icookie = { };
+	struct device *dev = domain->dev;
+	struct msi_map map = { };
+
+	if (WARN_ON_ONCE(!dev || domain->bus_token != DOMAIN_BUS_WIRED_TO_MSI))
+		return -EINVAL;
+
+	icookie.value = ((u64)type << 32) | hwirq;
+
+	msi_lock_descs(dev);
+	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid) != domain))
+		map.index = -EINVAL;
+	else
+		map = __msi_domain_alloc_irq_at(dev, domid, MSI_ANY_INDEX, NULL, &icookie);
+	msi_unlock_descs(dev);
+
+	return map.index >= 0 ? map.virq : map.index;
+}
+
 static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *domain,
 				   struct msi_ctrl *ctrl)
 {
@@ -1665,6 +1709,30 @@ void msi_domain_free_irqs_all(struct device *dev, unsigned int domid)
 	msi_unlock_descs(dev);
 }
 
+/**
+ * msi_device_domain_free_wired - Free a wired interrupt in @domain
+ * @domain:	The domain to free the interrupt on
+ * @virq:	The Linux interrupt number to free
+ *
+ * This is the counterpart of msi_device_domain_alloc_wired() for the
+ * weird wired to MSI converting domains.
+ */
+void msi_device_domain_free_wired(struct irq_domain *domain, unsigned int virq)
+{
+	struct msi_desc *desc = irq_get_msi_desc(virq);
+	struct device *dev = domain->dev;
+
+	if (WARN_ON_ONCE(!dev || !desc || domain->bus_token != DOMAIN_BUS_WIRED_TO_MSI))
+		return;
+
+	msi_lock_descs(dev);
+	if (!WARN_ON_ONCE(msi_get_device_domain(dev, MSI_DEFAULT_DOMAIN) != domain)) {
+		msi_domain_free_irqs_range_locked(dev, MSI_DEFAULT_DOMAIN, desc->msi_index,
+						  desc->msi_index);
+	}
+	msi_unlock_descs(dev);
+}
+
 /**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from
-- 
2.34.1


