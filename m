Return-Path: <linux-kernel+bounces-145607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A738A5875
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4BB1C20F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6238663E;
	Mon, 15 Apr 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ENqBsMHG"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE983CC9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200532; cv=none; b=XDxC0CUpV6duT1y1OIDfHHo7ck+T4F8PtjEGi84Ce3qyTx5Tfo7R4p6FKenY0jfX9L47WVvhP4Hgzbkee4P9JhUy6hPzjwVpMbqo9BjkpzEhRdqGxmz88T33qBwzwVVwBDc7A0ci+2ha3fGrH4U/prgNxySvEovgLPB/UkyEkc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200532; c=relaxed/simple;
	bh=NYDxzQHyf8gJHPAvOALBAMzhx5urWTz2dTzECHqtOGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tlnIJRhKSnmuUKDHoKHquQFhX3hCbmzpfuuo6Y7mplvxZSpC5nLbEvZNnDtKvrK7P6TRzG9U/T2Du3ePfHfRtHnbTFreg7nZSe2FM0W+i59PLT2ifDm4LJVmkZgYOq6ert1FISM7YH60VaDGCvtWtPMekB133PF/MaHHnKyIYTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ENqBsMHG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so3228860b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200530; x=1713805330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wivOzLRmXtJHidm0Hubd14abZ9qXDzBQHr2qytLzYnU=;
        b=ENqBsMHG3dHJoDK9E+1dCa/IRXsngfMyh274xl+bLsBdlYCzo2pFpTtuEKw9OH4w7r
         tAPfZLryh54eyzgeCkvDXCxuU2sp2sATto8QOuxcUXUAUQTZi+KlH5g8EeWSKus98ESE
         vNCVQ8PzxF1/SrbLI+C36qS91tO7TBZk5hZn/BwKn8D411D3Ju0nzUMsIhMZOyNPcV11
         0GXdaeOOhy3K3c3Zq55mOPo3TBaVGWtlN5TcwCWzTaMa91ICmdmHyRp9RXw9AQCMPG7p
         9/n2vPRHPCoSz/e1FNzlsnuXcK44k/23f8P8G+2MuzIHdglTOHSlsRxtizRV12g1LO8k
         OZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200530; x=1713805330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wivOzLRmXtJHidm0Hubd14abZ9qXDzBQHr2qytLzYnU=;
        b=TdUlZTPkVDaepCVRK9ipSOvrXUOByHd3pPwKR/3j+XdR9+cmEhYbVAkhB6dmLq8QeZ
         2U7nP3PudUawP2+iCw3s8BN13itpEsRSivhsyFAymFRcIkjjpd3aAs2W6dNMOSh1KLqN
         lkMKTyC0qWHoSCnb3hJrwK/TTnLsil4dOVsGa0Uhemd3qChOqD/3dj9pGut3U6g49epu
         72Axpr2ty2E2tow9niRgCQ7HlJTgUbogocLj9iZfkCaWmybgHnfqWl61+04KwtBdrpjG
         Ycnlfi8sy/7AhFiPieJBuyQEeUArPFuIZDhsOlM5/c/O4/sWGVfZq/Sdg/dl4cUEimrh
         P7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhesx7ZMzzF9Fbu6+8moDlz5oFBfHgipeUoIXMKcfOct+GwRJb3Pv4KFux9K6UfeX2VnlAbEcg8HieXUAStyFqQ7A9i8a+jQOUcGC2
X-Gm-Message-State: AOJu0YwQm5lWZZVffZRXAOp/paVc3XaDjRXwpZwyc0pt0ah9yxC6ikvf
	nB8+0jRAmVe4ExwB8t7rM+qJz/7nU1nn9yR83pHy9a9U9BeKzogHUsq25CXqO+8=
X-Google-Smtp-Source: AGHT+IFQgj91jSGw2lUkZcvmJ8fK2VsBYSBL2HSqDtP8zaw7fuUgNF2lymwMr71eYZkL80x3yGmBkw==
X-Received: by 2002:a05:6a00:4f94:b0:6e6:8df5:f77a with SMTP id ld20-20020a056a004f9400b006e68df5f77amr12893462pfb.31.1713200530140;
        Mon, 15 Apr 2024 10:02:10 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:09 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v4 07/20] RISC-V: Kconfig: Select deferred GSI probe for ACPI systems
Date: Mon, 15 Apr 2024 22:31:00 +0530
Message-Id: <20240415170113.662318-8-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415170113.662318-1-sunilvl@ventanamicro.com>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On RISC-V platforms, apart from root interrupt controllers (which
provide local interrupts and IPI), other interrupt controllers in the
hierarchy are probed late. Enable this CONFIG option for RISC-V ACPI
based platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/Kconfig   | 1 +
 drivers/acpi/Kconfig | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 69cc0509a19a..d8cdb3535e44 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -15,6 +15,7 @@ config RISCV
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ARCH_ACPI_DEFERRED_GSI if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index e3a7c2aedd5f..ebec1707f662 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -587,6 +587,9 @@ config ACPI_PRMT
 	  substantially increase computational overhead related to the
 	  initialization of some server systems.
 
+config ARCH_ACPI_DEFERRED_GSI
+	bool
+
 endif	# ACPI
 
 config X86_PM_TIMER
-- 
2.40.1


