Return-Path: <linux-kernel+bounces-23317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B7682AAFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64709B26DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5884814267;
	Thu, 11 Jan 2024 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mFCO27Jq"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463612E6C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28c0536806fso4510113a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704965472; x=1705570272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3co2sOHjGX4HJhNcpLPUh7fyfRHhZQUX9e33G8U5XOw=;
        b=mFCO27JqMW7qG7prHgGKDSJD9JAD2BLjWZzyChAaf6BY1Lj1bQJos0Qpy9QB5cLeNb
         JlqKP6vT9s2mOqrpRQPf8NbXVWytgMF0HOPJM4/wE2jhkMLomMk3GFMUJVstgt4N4Wl3
         rWdsFpt2lWlUrtkfMtAjEaA7EMiOC8H8JEQgK6JsSDbqu/ca2gHQtvGzA2vK0PSzmlFu
         g4TKrW7tuQrYG079Ws4GRzSFV5Z9bjAEmTwHLBDktK7PfGDVHRTN3USO4H0hac0/f/X0
         /r8JAJJgWeNXiSZRLVcKjNiSnfL2eFg4CPrcCoxqNys0KLeTjmAuRsS3MFaohK7UsCrG
         aNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704965472; x=1705570272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3co2sOHjGX4HJhNcpLPUh7fyfRHhZQUX9e33G8U5XOw=;
        b=txg0MoOriRzRE9xHg02iJ1ZRYQ7AHRoi7JkylM2c9ibyVbhOnzbBXGA3mpg4WNcXeA
         klIPct4t4KqCxPYtuoqdJ9oJro+fKr04EBpt6zgFvGmDKwZXCkUtZIhmq0VQkPpWG8ef
         oipFtIXTY+GXAn0lnnK4VCooRN/lwEuhFhuXAx+T2qQjR4ZDcC413GWchBnbd0q4g1YV
         zlUBP+h6fhflocgyta8vWJUlPSqF4plu3mKytfevWaVSAQf05vdArBRXvV86gZg2xnit
         h0s0+AYglVqFF/FR/0nDXzMHTnc1eDvxjXebnQYV9A81vK9phne91O4rdC87Jm5p7NoW
         W5XA==
X-Gm-Message-State: AOJu0Yy93F+FETiuj0aqU7T9A8sBI6J3cOrmH5F2WjXxE5SICM+uLQko
	g6Jpfa0EPNBV2EnplZb08Lovk9RuD0arLA==
X-Google-Smtp-Source: AGHT+IFssiCK0JYjvHueFW2PMxwnkSqT3RYbMAUksprK2TkSi5cy8rguDn4ZmzMpW2QBoaX72pMGgA==
X-Received: by 2002:a17:90a:2e82:b0:28c:134d:fca1 with SMTP id r2-20020a17090a2e8200b0028c134dfca1mr786132pjd.16.1704965471988;
        Thu, 11 Jan 2024 01:31:11 -0800 (PST)
Received: from sunil-laptop.. ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id jd2-20020a170903260200b001d4a7cf0673sm730566plb.117.2024.01.11.01.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:31:11 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH -next 1/2] ACPI: Enable ACPI_PROCESSOR for RISC-V
Date: Thu, 11 Jan 2024 15:00:57 +0530
Message-Id: <20240111093058.121838-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111093058.121838-1-sunilvl@ventanamicro.com>
References: <20240111093058.121838-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI processor driver is not currently enabled for RISC-V.
This is required to enable CPU related functionalities like
LPI and CPPC. Hence, enable ACPI_PROCESSOR for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f819e760ff19..9a920752171c 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -282,7 +282,7 @@ config ACPI_CPPC_LIB
 
 config ACPI_PROCESSOR
 	tristate "Processor"
-	depends on X86 || ARM64 || LOONGARCH
+	depends on X86 || ARM64 || LOONGARCH || RISCV
 	select ACPI_PROCESSOR_IDLE
 	select ACPI_CPU_FREQ_PSS if X86 || LOONGARCH
 	select THERMAL
-- 
2.34.1


