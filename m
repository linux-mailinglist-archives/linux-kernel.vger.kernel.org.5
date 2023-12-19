Return-Path: <linux-kernel+bounces-5717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1073C818E86
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8981F220E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E602138FB7;
	Tue, 19 Dec 2023 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KFyKhop7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E639860
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3e6c86868so4411625ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703007963; x=1703612763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIbnDt1gfwHKXHRoQ8BCVk+wpgvY6XHWajEKia0uA/M=;
        b=KFyKhop7ECu5rw/sSYQbgCww+757PQ6kmfPwXm9c3sIQAiByCy9xjewSl3U0abbDs2
         emwje+crxrvSWMjCcECMri3HMpotwQ3hXHv2AG5D6EOnj92L/q+XFryw2lyFxX9m2CL+
         Cm8UoXhbLnimyWTgwSzJeNv5T7a94AcdBw0GW2cqEdJaMbzIQmiffk/C8yN2gF8kmvqn
         Ksxt8llKwdbOTxu/TMgiAtEFPZmiNQZ/hLn67dSC3bRWg19ZighYK/4PDc5sBbKj8dJZ
         cHa5ntKhTvEIqiez/TePaWu/v7nq5NG4RENhAq1SkVRCmn0J/ZKfKN8lE5g8f9LJ/VLi
         wpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007963; x=1703612763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIbnDt1gfwHKXHRoQ8BCVk+wpgvY6XHWajEKia0uA/M=;
        b=XV6/Y/NDsdZz3YWx2siQ5PrH98oLWXGv9VuIlFnk+jOIcF/TPuKR460pVR4DoUku2f
         nAVfTh+uub9abTCcDkv+EryiYsH4IzpAKBiE0lgApF2F5NGcZ5OzQbn1099JFH2q+fcK
         CvM8hjkhMwVHEj0qFRFzUhBIwzUxNbCZRwBlZqyvP96cWA4ziL6HjEzYEpcqtsJ9jLoq
         t8dBe03JVUQVIAFQ/+2/310Tnw+2+qUHjqK97ELQsRryWN67VwFfB0RuESYaBQLQZe80
         Y5ViIX5qM2DNzh4+krfv8GX7Rmp0BszV7IgNUGCSnXdXv1chCL65LLRDX9hw5gdrDl+Y
         y6Dw==
X-Gm-Message-State: AOJu0YzmcwGMb8Ojxc2nsDy6sarAd6GGcEi/Ere4bRn7XQ25vyvTKG8I
	McV45s2Va+e8Wpw8SuyN2TBKhQ==
X-Google-Smtp-Source: AGHT+IHoJyst8qKxevbQtQHjUD2Bmcj6vMHRjagPkED1xi9g/ptnAuHzMtmh5nHrJpPdrkAYQWohig==
X-Received: by 2002:a17:903:28f:b0:1d3:d8e5:9e38 with SMTP id j15-20020a170903028f00b001d3d8e59e38mr2543797plr.2.1703007963429;
        Tue, 19 Dec 2023 09:46:03 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:46:03 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v3 05/17] ACPI: irq: Add support for deferred probe in acpi_register_gsi()
Date: Tue, 19 Dec 2023 23:15:14 +0530
Message-Id: <20231219174526.2235150-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The chip which provides the GSI support may not be initialized at the
time of acpi_register_gsi(). Return -EPROBE_DEFER to support deferred
probing similar to acpi_irq_get().

This is required to support ResourceSource as supported by ACPI spec for
Interrupt resource.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/irq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index b3409e2e2041..c4605fdcda77 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -52,6 +52,7 @@ EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
  *
  * Returns: a valid linux IRQ number on success
  *          -EINVAL on failure
+ *          -EPROBE_DEFER if irqdomain not created yet
  */
 int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
@@ -65,6 +66,9 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		return -EINVAL;
 	}
 
+	if (!irq_find_matching_fwnode(fwspec.fwnode, DOMAIN_BUS_ANY))
+		return -EPROBE_DEFER;
+
 	fwspec.param[0] = gsi;
 	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
 	fwspec.param_count = 2;
-- 
2.39.2


