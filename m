Return-Path: <linux-kernel+bounces-143606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E428A3B5A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594E51C214F1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E061CAB7;
	Sat, 13 Apr 2024 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HoNIY3Tw"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6031B947
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712991143; cv=none; b=uX5gDi87fP0SttYLZV2CuyjuMjEPeAWYjimAzxXOBpTqgPiYa1jztCZApFali4pLlZoAIcSA4waoAZvYYIjqt1Ut8ecBqX5EfHVSbEHh17XM7e9DBDuDfyXaJekNPA2zY2s1A3cw2TlUbURs515gKxtzlRh/wtTuslHJJXuKXrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712991143; c=relaxed/simple;
	bh=+50NrkT39j6l5PH4oDaoBTeBieW5JeEih24jP1NhPYw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=if3ri8bfxbtmxScQlHF0crFZLn1HU2eWO1eqL1JyFjKRkqb45/0h+mpOdmHv0OkqAqBNVMrY2Ug3fo9tdJp/OEeEGL1q76XlnXU8pqxfyfPJPcVTKtLOZSZx59TRqR/SPYVA/lgmA0pktOREqXZyApBFN1ZP6FmQv8fMZgyjQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HoNIY3Tw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecf3943040so1276628b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 23:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712991141; x=1713595941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yBFHuV2LVuWEjmAN/8ohS4VG5ENeR9bBP+jEkNcVGnY=;
        b=HoNIY3TwaSuQ/ffITJsNiEnT8a1GxHL4eBbOk9knz0BIlyFaQgaNwdVjqAW7V6KjX1
         UOMpuJFJpyrDwxdrmh/jNglMj+Qrjg1ZLiHeRTJkEUUMSCiQTvpdVqzF39y4z82XQ32q
         bh1zHVyB8lNb0gAsNzWw2lg7iKk4yRXzQZA5R2kIUqPsXtumyhfDQ2/18YCsOdhpGgVP
         OMVsw3kZIFKtbD2GlbV+UWw+WE7cRCxjyliLZLyxKe+kKJMxhlyQiKD8cytPMjk+Sisa
         +hkK08HMSReO8g/iQuGaXEj1+irEtAXKLbWHmlN9nohfpJqvPqB7bQHr7WtoZ5BnWGx+
         nsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712991141; x=1713595941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBFHuV2LVuWEjmAN/8ohS4VG5ENeR9bBP+jEkNcVGnY=;
        b=R6gfqt/GAg/FbLLsYx0YlFREpPm/7+j77Zti8ZxNNyIQZhhspkQFcyb53FhYP3ynnJ
         bQxgEL0suWBfBNZn5PGROFG7Rn7M7uuZNs8WNvu6cPhJiVD2oyELRU9eWnJkmRsEPSgg
         1uzVc6SLwcOeTdca/qW2BY/lOYfHF29LRgKBwpXSa+lrtShJpaAi6bcpFdfl7SYSi72l
         mcLtLUFtEK2A+a3DGdM+eFiEVYJsADi7ANLWU8sypjBORihoN07ZGWD7wWlf4l+9UJe5
         RbkteIkVhGKB4YkuabAf+llo+XLOt69TtLXmMbmgLWjqdEDI3U3n2xwGB96JppguKvly
         4plQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmTorERkT0Jp6fowxOM2BfsmZFHlGDMht9Vz3D/RXbyivOW9dLpLrkQ0al2rJAvYB1PStRzDYUk+vM6zNNPxqMTv4qEE/mYaYKY7kI
X-Gm-Message-State: AOJu0YxMLVuhSQVSnR20S8D1mXgH2mGet3yRp8r2oiSmaIHd7t9dh6Lu
	uRz5Yi+XRdHLYWGYQFR5zMexZPwA0A8Eye4ZWaiymZkHQNdqvuX7x969Pux+IaM=
X-Google-Smtp-Source: AGHT+IFxF4jJ0GHS1OMnmsjR3+db1ACxvmt66Yi/yXJeY5lDM1hSf5pmrlBnuOLCRIE4LCxRJNPrKQ==
X-Received: by 2002:a05:6a00:2183:b0:6ed:cece:8160 with SMTP id h3-20020a056a00218300b006edcece8160mr5221682pfi.31.1712991141027;
        Fri, 12 Apr 2024 23:52:21 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id v12-20020aa799cc000000b006edcdb08d25sm3895634pfi.91.2024.04.12.23.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 23:52:20 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH] irqchip/riscv-imsic: Fix boot time update effective affinity warning
Date: Sat, 13 Apr 2024 12:22:10 +0530
Message-Id: <20240413065210.315896-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the following warning is observed on the QEMU virt machine:
genirq: irq_chip APLIC-MSI-d000000.aplic did not update eff. affinity mask of irq 12

The above warning is because the IMSIC driver does not set the initial
value of effective affinity in the irq descriptor. To address this,
initialize the effective affinity in imsic_irq_domain_alloc().

Fixes: 027e125acdba ("irqchip/riscv-imsic: Add device MSI domain support for platform devices")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 1e6dddfd3046..11723a763c10 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -157,6 +157,7 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 			    handle_simple_irq, NULL, NULL);
 	irq_set_noprobe(virq);
 	irq_set_affinity(virq, cpu_online_mask);
+	irq_data_update_effective_affinity(irq_get_irq_data(virq), cpumask_of(vec->cpu));
 
 	return 0;
 }
-- 
2.34.1


