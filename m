Return-Path: <linux-kernel+bounces-72377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A81285B2A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9401F21E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC3658ABE;
	Tue, 20 Feb 2024 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kvKVklWx"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF3058104
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409281; cv=none; b=i9JQwrRM91VQwVNdy32PmYQi2Z8kcDvII/fT19gHhuSKGAwNYLTkeFwtES+Y6IhOeDP2qMMATVklKqhd+qP9y0K2IZE/2KIgek9oZmS3XiPcjRSW0k1Qt6L41ZFJL6WtMFgTndTS1PfgBqlNjI2LRBMDXUgb/ei4KcHW6mPCyCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409281; c=relaxed/simple;
	bh=8FCJ627xMjRAiuUoRP29/NuSzjKpz0ZXqVHlGndLTg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TAAxbYlX+v//AI3iWfPns65aGtkSUdp4PgtbIMkbnI64YI2zXVJ7GBhY+ooPetWjOhtK4tbo4KUo7BMMq8Gcxyhn8zhp0AWjNQ7Wsydk9MPXvpZK/6uh4NeazJT4HPtvhuYeZnF8xCaduEmgE/8w155kVT4h1GdIYdDnhG1c91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kvKVklWx; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59a31c14100so1828642eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708409278; x=1709014078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADCbdCrzcPKrHuVNHArQAhKf5LOV1FP1desVsvizcyc=;
        b=kvKVklWxSIS8zG8ACARHcZfy7BRT6KwG/0ENmglatMKQXiOesEwRjezyA6QxWa8qff
         MCARU2AdDuGv0XVgSPnoH/MMutsi7TG9JXaHrvn8B1KwwdzJKEizNzI9s0yPBzEU+q3D
         4/qVVLhKsmd5Cf5r4rsobMgNFxRRJdFeuUSPYNaY0G0S49l2KGY4C0QMSjYgtBMW9Xj9
         wzThMxOUYxkYODWm6zMx0vHSr/lq6YQEicK9nHSGC4XTHisywWXMV71kKXGNqxXjU2kd
         M6icK8SyF7rBcm8SEaKb8nqmH92W6WKbe+IwmcY1vXSRwuuPPrSsQWrBLYv9Qrj9eOfc
         WSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708409278; x=1709014078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADCbdCrzcPKrHuVNHArQAhKf5LOV1FP1desVsvizcyc=;
        b=hMGqdnuMI8Nq3Z0a07i90KzJ1AB3sJ//7mrRKd9/I5gDyxxoVCDhNcmaygJJJT0+Q5
         yaaHgfk7Cr7qjrwpxCl2X46q0jio0vIQb71FSTqO2yeGmQLt+RhlPxROTpDYQdsa4YWa
         kMhzBi7MmLqneeV3kPyrG2bC6V9jT8EYH+kUQvWZjdXcNfCoEWKgc3uNdboMeC5moilW
         wAeo0o5b+wvy/98bkVX70knEg/vOGsibZAI2EWeuiWp6jYB8vy+mNOB2hhLCg3sQu7ae
         WCcuacX86Vj9lC7TEKCkSdjodz0eFRf9rfwoJGkdbpeEezqF+7M+RyftBxRPn1P+zbpv
         HW5A==
X-Forwarded-Encrypted: i=1; AJvYcCU3UoEcwSD5YKOAkoAwdtMfPC0U5ekkg92chMHKJafuOa3nMTvbuKjczn4FBUT6Ng4BGQuP2wXDX5NENP+7k7psPVUq0Aa8xEzEoLkx
X-Gm-Message-State: AOJu0YyZi3YpK7DPjUb/iBaoxodtm2E8dwXIbA13yQrsCivuNOlh5HHz
	YQ6sTBwsVpw/e9GuCcj+KYRttgydSbTlCRW4reEmNkek5abGyVlI5ZhUNQ6Mw/0=
X-Google-Smtp-Source: AGHT+IFmjBmRXnMrxFIxl7ltl98zshg6DefC/ZSQRgCv09coMxJDssOSPjyVh6cEeNZep67UibNQjw==
X-Received: by 2002:a05:6359:c85:b0:179:24ae:25dd with SMTP id go5-20020a0563590c8500b0017924ae25ddmr15679627rwb.25.1708409278454;
        Mon, 19 Feb 2024 22:07:58 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.86])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001db4c89aea5sm5368114plt.158.2024.02.19.22.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 22:07:58 -0800 (PST)
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
Subject: [PATCH v13 02/13] irqchip/sifive-plic: Improve locking safety by using irqsave/irqrestore
Date: Tue, 20 Feb 2024 11:37:07 +0530
Message-Id: <20240220060718.823229-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220060718.823229-1-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that PLIC driver is probed as a regular platform driver, the lock
dependency validator complains about the safety of handler->enable_lock
usage:

[    0.956775]  Possible interrupt unsafe locking scenario:

[    0.956998]        CPU0                    CPU1
[    0.957247]        ----                    ----
[    0.957439]   lock(&handler->enable_lock);
[    0.957607]                                local_irq_disable();
[    0.957793]                                lock(&irq_desc_lock_class);
[    0.958021]                                lock(&handler->enable_lock);
[    0.958246]   <Interrupt>
[    0.958342]     lock(&irq_desc_lock_class);
[    0.958501]
                *** DEADLOCK ***

To address above, let's use raw_spin_lock_irqsave/unlock_irqrestore()
instead of raw_spin_lock/unlock().

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-sifive-plic.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 48483a1a41dd..e91077ff171f 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -103,9 +103,11 @@ static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
 
 static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
 {
-	raw_spin_lock(&handler->enable_lock);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&handler->enable_lock, flags);
 	__plic_toggle(handler->enable_base, hwirq, enable);
-	raw_spin_unlock(&handler->enable_lock);
+	raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
 }
 
 static inline void plic_irq_toggle(const struct cpumask *mask,
@@ -236,6 +238,7 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type)
 static int plic_irq_suspend(void)
 {
 	unsigned int i, cpu;
+	unsigned long flags;
 	u32 __iomem *reg;
 	struct plic_priv *priv;
 
@@ -253,12 +256,12 @@ static int plic_irq_suspend(void)
 		if (!handler->present)
 			continue;
 
-		raw_spin_lock(&handler->enable_lock);
+		raw_spin_lock_irqsave(&handler->enable_lock, flags);
 		for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
 			reg = handler->enable_base + i * sizeof(u32);
 			handler->enable_save[i] = readl(reg);
 		}
-		raw_spin_unlock(&handler->enable_lock);
+		raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
 	}
 
 	return 0;
@@ -267,6 +270,7 @@ static int plic_irq_suspend(void)
 static void plic_irq_resume(void)
 {
 	unsigned int i, index, cpu;
+	unsigned long flags;
 	u32 __iomem *reg;
 	struct plic_priv *priv;
 
@@ -284,12 +288,12 @@ static void plic_irq_resume(void)
 		if (!handler->present)
 			continue;
 
-		raw_spin_lock(&handler->enable_lock);
+		raw_spin_lock_irqsave(&handler->enable_lock, flags);
 		for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
 			reg = handler->enable_base + i * sizeof(u32);
 			writel(handler->enable_save[i], reg);
 		}
-		raw_spin_unlock(&handler->enable_lock);
+		raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
 	}
 }
 
-- 
2.34.1


