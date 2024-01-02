Return-Path: <linux-kernel+bounces-14917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D59822473
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD23B227BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58A419470;
	Tue,  2 Jan 2024 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TP2bfssn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460D18EC7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28c0df4b42eso5243380a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704232904; x=1704837704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tIOva8KFaIwh3i+98q+ysPtJyT8vpZl2kFy86xHGzc=;
        b=TP2bfssnGxqJPMtzP4cLt7lxFe+FsXfD55VmnK823h/myUpbpnj3vf8GqR5ZQ0yfqI
         6dnsPojh9MFPy8oWLimIWNgwCwX8DLcAZWmnHp5zdTI+jBQJHMFTBB7kgxMunmrYGCrr
         Rtu9tCidaSaWo7IRhQ5giGKYdxsnxoFFYRwOGG/2CmjILC910XSkSXvUDNE8t8tALJfN
         l7vUcJyOsFKIls+6W1a9xmQkpLt2lRR+zzPjypvne2gz24wELloosE3mIuyHI6Al+DJd
         VQqWeY0Bc4PDtMOHsnZ8TR01/wQ5Oy50fDyWDo6aGWbbt9IAha9EjAgawjrWtTKglPsN
         Ik9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232904; x=1704837704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tIOva8KFaIwh3i+98q+ysPtJyT8vpZl2kFy86xHGzc=;
        b=vqq2oxBRzE+LVNo7nej4fgOORmZ8IKBiuyGkRMYOJy4zlilKaOOI4lr7I5OlOvQH5U
         FheWZSIw8X8n0gRsx3Dy72+9F5gllC3OcsFlWw6RjC/HVv4vVEti+dEcPWnGOlItNlhl
         BxJ/dB0lOYqy18FmCqaU3WJJ7+FDfMf96oz2V72IVh1tJ59u2m60qhl5sYx3sTczroJF
         av5MzzrV3bFop9WReXqLI2brp6R/htpapKqaxJBRoXkwGWHJR2fjANy4xPiDMAtSskTP
         uk1FiWJa7lX9JGC0H3lmrulAh1mXFRRwegKd3uWG7c1ZeZgZQMqvV2Ad2Rmx3jYb6tuR
         r44w==
X-Gm-Message-State: AOJu0Yy1hJb7pv2KXMqF95R8vRUFT4AprjeQihesJIQCo9gRq8cAgfB1
	YS5PzqhN8Bgx6Hzo9ehY9nVMFI8xYNmXyQ==
X-Google-Smtp-Source: AGHT+IERqoXqHCzKpOJ5RqmrnOEOyFJpME6yqKz2yoKuSVbxPLF5GZg8UdvpqpiYsRMOZbO3DMheoA==
X-Received: by 2002:a17:90a:d90b:b0:28c:300d:d858 with SMTP id c11-20020a17090ad90b00b0028c300dd858mr127429pjv.20.1704232904383;
        Tue, 02 Jan 2024 14:01:44 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id r59-20020a17090a43c100b0028ce507cd7dsm101724pjg.55.2024.01.02.14.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:01:44 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 07/12] riscv: Avoid TLB flush loops when affected by SiFive CIP-1200
Date: Tue,  2 Jan 2024 14:00:44 -0800
Message-ID: <20240102220134.3229156-8-samuel.holland@sifive.com>
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

Since implementations affected by SiFive errata CIP-1200 always use the
global variant of the sfence.vma instruction, they only need to execute
the instruction once. The range-based loop only hurts performance.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - Only set tlb_flush_all_threshold when CONFIG_MMU=y.

Changes in v3:
 - New patch for v3

 arch/riscv/errata/sifive/errata.c | 5 +++++
 arch/riscv/include/asm/tlbflush.h | 2 ++
 arch/riscv/mm/tlbflush.c          | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 3d9a32d791f7..716cfedad3a2 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -42,6 +42,11 @@ static bool errata_cip_1200_check_func(unsigned long  arch_id, unsigned long imp
 		return false;
 	if ((impid & 0xffffff) > 0x200630 || impid == 0x1200626)
 		return false;
+
+#ifdef CONFIG_MMU
+	tlb_flush_all_threshold = 0;
+#endif
+
 	return true;
 }
 
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 002c4c2620f3..d9913590f82e 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -58,6 +58,8 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end);
 #endif
+
+extern unsigned long tlb_flush_all_threshold;
 #else /* CONFIG_MMU */
 #define local_flush_tlb_all()			do { } while (0)
 #endif /* CONFIG_MMU */
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 292d7cf3c4f6..76b24d4ed4ab 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -11,7 +11,7 @@
  * Flush entire TLB if number of entries to be flushed is greater
  * than the threshold below.
  */
-static unsigned long tlb_flush_all_threshold __read_mostly = 64;
+unsigned long tlb_flush_all_threshold __read_mostly = 64;
 
 static void local_flush_tlb_range_threshold_asid(unsigned long start,
 						 unsigned long size,
-- 
2.42.0


