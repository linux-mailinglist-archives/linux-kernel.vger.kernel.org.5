Return-Path: <linux-kernel+bounces-140137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF778A0BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28D21C22C80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34F814430F;
	Thu, 11 Apr 2024 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OmEZYaW/"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659301442FF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826415; cv=none; b=d3LyK10CDryROSiQcJyI3w7tPIvAQ4bBzqpwYfoPfprbCPP6Et25NERZMxFCR7sRhqcCrZB3gyOUVwc0IK9X9vewQmaY+ZujOA1peTefXZj5x1dWZ7iFa59aJ8FkJslXBJfgtpx+uB67Vis2jLp6BA1UaINNwBI9U6GneX73m9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826415; c=relaxed/simple;
	bh=5R5HClKDyvVMYt+Dlj2lOG3qD5DL07WR9z83rlZrbpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p2vBKIYjY0yB9rHt25Ycrd+JxKJQw8hSYo4aDFjOeUDFCsKjqXeeJ0vDXMcsl2nwqhsEY/9pFL/PSEZpxF/vN4+lQS1dBB0fAllvdmEaAjfV+Sg295hfE/1PVFREnSJopoEDyvadhnFe68mPe/YQ1pO1ibemkvAckhMeEbVUM24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OmEZYaW/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecf8ebff50so454464b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712826413; x=1713431213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qo8k+jtku3GLugoqX/2jDzvY4YtbrVgAtt9TNzdVCZA=;
        b=OmEZYaW/sKgFW0YQYvdshEMMM1NnMXMmgW3DjqLj9zdL1XlzFieKuTNlusDGzDcYHV
         XtHXqJfzoTzXq7Km0FZEi2NHebmkiwwv1Xd3R+lm3Y82wBTlfM4v8TVadL3DQs4UnK7K
         Psj0Sdc8wUnPZ2zFKNmNS8nhjG+zVL9yeeLc2ZYWGZqk8/QOwgquQrQbWPeiV6g23/a+
         Dpx/rzYL5Cr/09unDXEjOG2qG3frfG3PF+E/S7QlT0ReWd1Yo834Qw34lgeqeW7Xjq7O
         fyfUExSiuszOtU6t6WhlqaVqVz9pwHGgQ+agM17bAgmn56sT/uUNc4IyMdMngRF/2OYT
         PGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712826413; x=1713431213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qo8k+jtku3GLugoqX/2jDzvY4YtbrVgAtt9TNzdVCZA=;
        b=T+Imr6Jxulp3G/PnBsHWHG2TuP37fdKKdO8kLElCKKxZaFA5y2sPkJmdNVMAhXYr08
         FMNFLr5jUmeBqVzx1/G4XOoqDGc3ito8u0JZjpm73EppuW0PsNF97V7dWZuBCXUTHRPW
         vX/NHfFsaNKBfrshdagl0UigqQCXzDbWInH2W9qflFiIFBpgw9hAkFOZoc0oi0P56KcA
         sTWbKsatmGzwOvNkuoqJ685T68XHnWJOKITwswR6Iy5MKTvxAkoglvOStSbpWu2dRtYw
         urDauIUa3lmROouj67gzPR6wzLc09XqbNM451VxjejLXSD/NIZDgwVbMNum7JZXefsgW
         sWnA==
X-Forwarded-Encrypted: i=1; AJvYcCUIGYwswIsbAIXz8BT/yBoGK6S0NMCpWk3l694BIQH/2Qu9ts95XbJOogOSaLm6qIJ1rj0rebmIlyYuiM6SDDyKs+T3jO/0WJDG6Udh
X-Gm-Message-State: AOJu0YzLAhtk/RNSY+b5b4XUzFAg2xzB+JgN/Jy5xUUYzkoJKupX0gq2
	gw1aIWrri9YsFrDmew+UZe37yHYxQO60yt89yPAs+cSjqdXgD1nDReinWoNHCd4=
X-Google-Smtp-Source: AGHT+IGZP6juHrol3fKL1x66YwON+Qtfij0V69IuBhzViScGhPXqaDbsuXNlmAWPVoD/pCLNE2ePRg==
X-Received: by 2002:a05:6a00:10c7:b0:6ed:825b:30c0 with SMTP id d7-20020a056a0010c700b006ed825b30c0mr2579203pfu.15.1712826412404;
        Thu, 11 Apr 2024 02:06:52 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.82.118])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78c55000000b006e729dd12d5sm816738pfd.48.2024.04.11.02.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 02:06:52 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 1/2] RISC-V: KVM: Share APLIC and IMSIC defines with irqchip drivers
Date: Thu, 11 Apr 2024 14:36:38 +0530
Message-Id: <20240411090639.237119-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411090639.237119-1-apatel@ventanamicro.com>
References: <20240411090639.237119-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have common APLIC and IMSIC headers available under
include/linux/irqchip/ directory which are used by APLIC
and IMSIC irqchip drivers. Let us replace the use of
kvm_aia_*.h headers with include/linux/irqchip/riscv-*.h
headers.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_aia_aplic.h | 58 --------------------------
 arch/riscv/include/asm/kvm_aia_imsic.h | 38 -----------------
 arch/riscv/kvm/aia.c                   |  2 +-
 arch/riscv/kvm/aia_aplic.c             |  2 +-
 arch/riscv/kvm/aia_device.c            |  2 +-
 arch/riscv/kvm/aia_imsic.c             |  2 +-
 6 files changed, 4 insertions(+), 100 deletions(-)
 delete mode 100644 arch/riscv/include/asm/kvm_aia_aplic.h
 delete mode 100644 arch/riscv/include/asm/kvm_aia_imsic.h

diff --git a/arch/riscv/include/asm/kvm_aia_aplic.h b/arch/riscv/include/asm/kvm_aia_aplic.h
deleted file mode 100644
index 6dd1a4809ec1..000000000000
--- a/arch/riscv/include/asm/kvm_aia_aplic.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2021 Western Digital Corporation or its affiliates.
- * Copyright (C) 2022 Ventana Micro Systems Inc.
- */
-#ifndef __KVM_RISCV_AIA_IMSIC_H
-#define __KVM_RISCV_AIA_IMSIC_H
-
-#include <linux/bitops.h>
-
-#define APLIC_MAX_IDC			BIT(14)
-#define APLIC_MAX_SOURCE		1024
-
-#define APLIC_DOMAINCFG			0x0000
-#define APLIC_DOMAINCFG_RDONLY		0x80000000
-#define APLIC_DOMAINCFG_IE		BIT(8)
-#define APLIC_DOMAINCFG_DM		BIT(2)
-#define APLIC_DOMAINCFG_BE		BIT(0)
-
-#define APLIC_SOURCECFG_BASE		0x0004
-#define APLIC_SOURCECFG_D		BIT(10)
-#define APLIC_SOURCECFG_CHILDIDX_MASK	0x000003ff
-#define APLIC_SOURCECFG_SM_MASK	0x00000007
-#define APLIC_SOURCECFG_SM_INACTIVE	0x0
-#define APLIC_SOURCECFG_SM_DETACH	0x1
-#define APLIC_SOURCECFG_SM_EDGE_RISE	0x4
-#define APLIC_SOURCECFG_SM_EDGE_FALL	0x5
-#define APLIC_SOURCECFG_SM_LEVEL_HIGH	0x6
-#define APLIC_SOURCECFG_SM_LEVEL_LOW	0x7
-
-#define APLIC_IRQBITS_PER_REG		32
-
-#define APLIC_SETIP_BASE		0x1c00
-#define APLIC_SETIPNUM			0x1cdc
-
-#define APLIC_CLRIP_BASE		0x1d00
-#define APLIC_CLRIPNUM			0x1ddc
-
-#define APLIC_SETIE_BASE		0x1e00
-#define APLIC_SETIENUM			0x1edc
-
-#define APLIC_CLRIE_BASE		0x1f00
-#define APLIC_CLRIENUM			0x1fdc
-
-#define APLIC_SETIPNUM_LE		0x2000
-#define APLIC_SETIPNUM_BE		0x2004
-
-#define APLIC_GENMSI			0x3000
-
-#define APLIC_TARGET_BASE		0x3004
-#define APLIC_TARGET_HART_IDX_SHIFT	18
-#define APLIC_TARGET_HART_IDX_MASK	0x3fff
-#define APLIC_TARGET_GUEST_IDX_SHIFT	12
-#define APLIC_TARGET_GUEST_IDX_MASK	0x3f
-#define APLIC_TARGET_IPRIO_MASK	0xff
-#define APLIC_TARGET_EIID_MASK	0x7ff
-
-#endif
diff --git a/arch/riscv/include/asm/kvm_aia_imsic.h b/arch/riscv/include/asm/kvm_aia_imsic.h
deleted file mode 100644
index da5881d2bde0..000000000000
--- a/arch/riscv/include/asm/kvm_aia_imsic.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2021 Western Digital Corporation or its affiliates.
- * Copyright (C) 2022 Ventana Micro Systems Inc.
- */
-#ifndef __KVM_RISCV_AIA_IMSIC_H
-#define __KVM_RISCV_AIA_IMSIC_H
-
-#include <linux/types.h>
-#include <asm/csr.h>
-
-#define IMSIC_MMIO_PAGE_SHIFT		12
-#define IMSIC_MMIO_PAGE_SZ		(1UL << IMSIC_MMIO_PAGE_SHIFT)
-#define IMSIC_MMIO_PAGE_LE		0x00
-#define IMSIC_MMIO_PAGE_BE		0x04
-
-#define IMSIC_MIN_ID			63
-#define IMSIC_MAX_ID			2048
-
-#define IMSIC_EIDELIVERY		0x70
-
-#define IMSIC_EITHRESHOLD		0x72
-
-#define IMSIC_EIP0			0x80
-#define IMSIC_EIP63			0xbf
-#define IMSIC_EIPx_BITS			32
-
-#define IMSIC_EIE0			0xc0
-#define IMSIC_EIE63			0xff
-#define IMSIC_EIEx_BITS			32
-
-#define IMSIC_FIRST			IMSIC_EIDELIVERY
-#define IMSIC_LAST			IMSIC_EIE63
-
-#define IMSIC_MMIO_SETIPNUM_LE		0x00
-#define IMSIC_MMIO_SETIPNUM_BE		0x04
-
-#endif
diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index a944294f6f23..8ea51a791371 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -10,12 +10,12 @@
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/irq.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/irqdomain.h>
 #include <linux/kvm_host.h>
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 #include <asm/cpufeature.h>
-#include <asm/kvm_aia_imsic.h>
 
 struct aia_hgei_control {
 	raw_spinlock_t lock;
diff --git a/arch/riscv/kvm/aia_aplic.c b/arch/riscv/kvm/aia_aplic.c
index b467ba5ed910..da6ff1bade0d 100644
--- a/arch/riscv/kvm/aia_aplic.c
+++ b/arch/riscv/kvm/aia_aplic.c
@@ -7,12 +7,12 @@
  *	Anup Patel <apatel@ventanamicro.com>
  */
 
+#include <linux/irqchip/riscv-aplic.h>
 #include <linux/kvm_host.h>
 #include <linux/math.h>
 #include <linux/spinlock.h>
 #include <linux/swab.h>
 #include <kvm/iodev.h>
-#include <asm/kvm_aia_aplic.h>
 
 struct aplic_irq {
 	raw_spinlock_t lock;
diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index 0eb689351b7d..308b3bbede33 100644
--- a/arch/riscv/kvm/aia_device.c
+++ b/arch/riscv/kvm/aia_device.c
@@ -8,9 +8,9 @@
  */
 
 #include <linux/bits.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/kvm_host.h>
 #include <linux/uaccess.h>
-#include <asm/kvm_aia_imsic.h>
 
 static void unlock_vcpus(struct kvm *kvm, int vcpu_lock_idx)
 {
diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index e808723a85f1..0a1e859323b4 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -9,13 +9,13 @@
 
 #include <linux/atomic.h>
 #include <linux/bitmap.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/kvm_host.h>
 #include <linux/math.h>
 #include <linux/spinlock.h>
 #include <linux/swab.h>
 #include <kvm/iodev.h>
 #include <asm/csr.h>
-#include <asm/kvm_aia_imsic.h>
 
 #define IMSIC_MAX_EIX	(IMSIC_MAX_ID / BITS_PER_TYPE(u64))
 
-- 
2.34.1


