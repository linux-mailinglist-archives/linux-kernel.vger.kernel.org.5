Return-Path: <linux-kernel+bounces-14911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0112B82246B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E37283204
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A600518C01;
	Tue,  2 Jan 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="k0R4KwlT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E718AF4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28ce6eeb4easo310245a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704232898; x=1704837698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sx1CrYCYqcy0I3lbTucfKtzktUZzOavzb19InQrqEBM=;
        b=k0R4KwlTr46S55jHvhzg/o8eollZhzK6pzTHwCz1T8zqKvHQU3BsmWUf4lurfepP/m
         4IYn3Ua468pGBIZwAcdXb7+rO3nCvvl5Mo+1W07ES0fRyOjfjm+mdUibpgGnEQwBP3Lk
         KG8T359hvMvcuU+36tIUT3hc5ov0asYY1zDGJCd1lionGf4/sWZukLGPJMu/z+58IDKZ
         cyBWCM+M5oJuwwiyQUyt2b0NTyRL1VMYFPrsy49tlGm73PNeqHK+SKg3qKrTUjYsyPVN
         4tDrj+rh/CkyVAaHtD8EtNz7AbCQ0olPZ4JKDFmAroinso3n64OkV1H/D/bP3ugOARAb
         iihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232898; x=1704837698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sx1CrYCYqcy0I3lbTucfKtzktUZzOavzb19InQrqEBM=;
        b=IsuWJSh15s3LHoOn1AQhByGZtMasWaQ73rHj40PKhqnHkHHXv2TRMuOIIpj32faYg6
         e1BzBw5LjF9P1M9vA2jzJQ6nKlcQg/glC2L0uLTCFqkpBoed0EW88FpI3qcmNLOiuTOl
         KXXH9lugPKe6Iu5xkDZmzMuD+k3soM0BwkujappzW7oAgw6hmZrJneO6H9u8y7SFHhMt
         xfnipmCfPk0rNKGbR7prBUG0Wmee6ydvihD6vPHjI8kbNri5BLIvJSVm8vd+nIXnYeAe
         Qcx6AYYUi+Z/GUhrja5lyVaFnSkbb0HTpmIkopwhU5zU4t/o0pounIjNKaU3V92ZXxUw
         AnVQ==
X-Gm-Message-State: AOJu0Yz5p8zt1366m442V/I2bCojlU/qfD+jghYPfzClYjZ6g2l2NYoM
	i0z9h63+TMWNYKXd/J3RdA++XL8Ozaxr+g==
X-Google-Smtp-Source: AGHT+IHSNOWtd16BNBpr13f63JilpUsY7HXImYHsivjSF6nbDu6T9MOgsg44oEC59WRv4BX5AKGF0w==
X-Received: by 2002:a17:90a:728e:b0:28c:a9d0:33ff with SMTP id e14-20020a17090a728e00b0028ca9d033ffmr2151486pjg.62.1704232897945;
        Tue, 02 Jan 2024 14:01:37 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id r59-20020a17090a43c100b0028ce507cd7dsm101724pjg.55.2024.01.02.14.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:01:37 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 01/12] riscv: Flush the instruction cache during SMP bringup
Date: Tue,  2 Jan 2024 14:00:38 -0800
Message-ID: <20240102220134.3229156-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240102220134.3229156-1-samuel.holland@sifive.com>
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instruction cache flush IPIs are sent only to CPUs in cpu_online_mask,
so they will not target a CPU until it calls set_cpu_online() earlier in
smp_callin(). As a result, if instruction memory is modified between the
CPU coming out of reset and that point, then its instruction cache may
contain stale data. Therefore, the instruction cache must be flushed
after the set_cpu_online() synchronization point.

Fixes: 08f051eda33b ("RISC-V: Flush I$ when making a dirty page executable")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - New patch for v4

 arch/riscv/kernel/smpboot.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index d162bf339beb..48af5bd3ec30 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -26,7 +26,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
 
-#include <asm/cpufeature.h>
+#include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
 #include <asm/cpufeature.h>
 #include <asm/irq.h>
@@ -257,9 +257,10 @@ asmlinkage __visible void smp_callin(void)
 	riscv_user_isa_enable();
 
 	/*
-	 * Remote TLB flushes are ignored while the CPU is offline, so emit
-	 * a local TLB flush right now just in case.
+	 * Remote cache and TLB flushes are ignored while the CPU is offline,
+	 * so flush them both right now just in case.
 	 */
+	local_flush_icache_all();
 	local_flush_tlb_all();
 	complete(&cpu_running);
 	/*
-- 
2.42.0


