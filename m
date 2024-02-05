Return-Path: <linux-kernel+bounces-52023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212C68492ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F422DB21926
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AD3AD5A;
	Mon,  5 Feb 2024 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="J2EynJHt"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B69463
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 04:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707107409; cv=none; b=UzBH7t/QYOtz9klU5EgBfM18ObX/Wu6uSqdD09wJa0aEa8BZQHYp5ULT3YT4VdjkTLv/VxWxhNV8afxSYYbu3WL2CjFXq23WBl7s7xghEInn5OYAX8htDU6aBe7VbYV2GGn1jWxYcPrFd9ntbcRxsi5pL1pEPi2hJ2I3znDr4l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707107409; c=relaxed/simple;
	bh=G0RsFhkK9T958p1QLSDmEXpLOv5/l46Rv0ysQAhZKUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KQ/POSMhjjDoqDLr/2cmGWtCbqZgvUqALemHBtBuwsUhu/4sJF5S3VAekrvXEeMvNHUdtwvT7Y7HMXI0cfqoI0VR9V4c2N3WOZIPwTmxVi+f0pE1PYT/1BNEUdhTcB7b/seR+oXELrXtFX51sHNO+59xOxe7FzxlKlJ5K2c3o2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=J2EynJHt; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-363c869d850so1566185ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 20:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707107407; x=1707712207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3r2vA5FIOIQLGifM1d7hYof79l8b2L/VuDazcZIHp8o=;
        b=J2EynJHtmc5fBSbax0r50vP0+CZW0sdSUs4zxlTjpnDtMXlQZrevzcvVJ72PSov2T1
         +uL/iYlj4w8kXHX1JLpV+PcTv23Ukk8W/SBg0oeiAo3FYeQbG26wNa4Iimhp1mcVu+4S
         jWkXKA3cAx9aXkJzJfaZire6x4BjvHVwF9LyABo15QwwbuPhYn471wwKiukJMrwSrX5G
         yyCmt9r7n6q30ss9BrV31lohSpBAZY88PgKIwc2Q+5QHX31NbnTdrro7/I5YUqysGB54
         o3HCw8SEyi0eqKeYJq44NGI4aGOkprrDRkYCgj7FsT+ewNJmM0ogaS+IU1PKu2I0AoMU
         LXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707107407; x=1707712207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3r2vA5FIOIQLGifM1d7hYof79l8b2L/VuDazcZIHp8o=;
        b=NfSQszDSGdbwknRSlEMST7T7hyFZRML5fbAECE5M9MLgU57BLup1i2E1CStcAapQvE
         mXtme4myrincqZMZBqsYfAm+os9wJUZcHLaI0tsfC/EJ6vyecqzjTOX+6dKLs5Ofb8Kn
         t1wSe/BfqmHgeVT9tHqvExPTJWJO592WN6OqHeUZmhTKfev6chqDtS6OR/2yJuiq0c3U
         KzNNdeCGGSgg06E49n59JAh7WwO8rfxtVBagy6jxzlSpHUwA5bNw6FQMlaFHiWNU6gpP
         EgJlV4xRn4f8aZ+GgHKeYkUFFCMZiDxtxVuNjCieTnFCQAel2ZEgNos9f4i/0M2h7V1W
         cvcA==
X-Gm-Message-State: AOJu0YzkhxEj0Zqk7lIkCZgnX2JxKWSjta5iVAvSiNvPKWoD+pcHaGoQ
	So63gzzMR5zp2eO/bcqy9vKP43LdU0u0flkqpGfQIZGL3Piqi5TtmgheFionhEo=
X-Google-Smtp-Source: AGHT+IGtmgrjzTQeAl5TEJlluMyMvgVEktxni8+qxt143FJmmGYy+5tc5cLjFKC2Z6sTdzGLUuAXVw==
X-Received: by 2002:a92:c150:0:b0:363:c63f:6dcc with SMTP id b16-20020a92c150000000b00363c63f6dccmr2960923ilh.29.1707107406907;
        Sun, 04 Feb 2024 20:30:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzNYHT4cS5fhRnf89OrnogwBxuC4KnPYpo14hZA9l6pDsnlJSHRLanviOZDz4C+Agl2JWXISe7b3KfV9HfScCZa5tCnUDTgDNNpb+e2QsYZeUnExe1sG4GNKNkJ6tozMAmBJW/66GJHbHeMJtsycQz6FiRPzkLqsxbha+aEYG3+AvcFnsMtO5xM0OotGhUEKD6PAlAqcFWV7B5Znhwo1srt4gFzaIcQ13EcbB7LsXJ0mSpz7FuAH5xPS/W4pha3lS0oJ+sAAub8isRwya7Da3+vpvnq85/CK+dO99ygVc7ADtkZzdGDUlrfvOcD4+o4/m/t7kRahyyUgFQON5pH5k=
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id m20-20020a056638409400b0046e917416c8sm1889131jam.89.2024.02.04.20.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 20:30:06 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH] RISC-V: Don't use IPIs in flush_icache_all() when patching text
Date: Mon,  5 Feb 2024 09:59:55 +0530
Message-Id: <20240205042955.833752-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If some of the HARTs are parked by stop machine then IPI-based
flushing in flush_icache_all() will hang. This hang is observed
when text patching is invoked by various debug and BPF features.

To avoid this hang, we force use of SBI-based icache flushing
when patching text.

Fixes: 627922843235 ("RISC-V: Use IPIs for remote icache flush when possible")
Reported-by: Bjorn Topel <bjorn@kernel.org>
Closes: https://gist.github.com/bjoto/04a580568378f3b5483af07cd9d22501
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/cacheflush.h | 7 ++++---
 arch/riscv/kernel/hibernate.c       | 2 +-
 arch/riscv/kernel/patch.c           | 4 ++--
 arch/riscv/mm/cacheflush.c          | 7 ++++---
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index a129dac4521d..561e079f34af 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -32,7 +32,8 @@ static inline void flush_dcache_page(struct page *page)
  * RISC-V doesn't have an instruction to flush parts of the instruction cache,
  * so instead we just flush the whole thing.
  */
-#define flush_icache_range(start, end) flush_icache_all()
+#define flush_icache_range(start, end) flush_icache_all(true)
+#define flush_icache_patch_range(start, end) flush_icache_all(false)
 #define flush_icache_user_page(vma, pg, addr, len) \
 	flush_icache_mm(vma->vm_mm, 0)
 
@@ -43,12 +44,12 @@ static inline void flush_dcache_page(struct page *page)
 
 #ifndef CONFIG_SMP
 
-#define flush_icache_all() local_flush_icache_all()
+#define flush_icache_all(want_ipi) local_flush_icache_all()
 #define flush_icache_mm(mm, local) flush_icache_all()
 
 #else /* CONFIG_SMP */
 
-void flush_icache_all(void);
+void flush_icache_all(bool want_ipi);
 void flush_icache_mm(struct mm_struct *mm, bool local);
 
 #endif /* CONFIG_SMP */
diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
index 671b686c0158..388f10e187ba 100644
--- a/arch/riscv/kernel/hibernate.c
+++ b/arch/riscv/kernel/hibernate.c
@@ -153,7 +153,7 @@ int swsusp_arch_suspend(void)
 	} else {
 		suspend_restore_csrs(hibernate_cpu_context);
 		flush_tlb_all();
-		flush_icache_all();
+		flush_icache_all(true);
 
 		/*
 		 * Tell the hibernation core that we've just restored the memory.
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 37e87fdcf6a0..721e144a7847 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -182,7 +182,7 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
 	ret = patch_insn_set(tp, c, len);
 
 	if (!ret)
-		flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
+		flush_icache_patch_range((uintptr_t)tp, (uintptr_t)tp + len);
 
 	return ret;
 }
@@ -217,7 +217,7 @@ int patch_text_nosync(void *addr, const void *insns, size_t len)
 	ret = patch_insn_write(tp, insns, len);
 
 	if (!ret)
-		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
+		flush_icache_patch_range((uintptr_t) tp, (uintptr_t) tp + len);
 
 	return ret;
 }
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 55a34f2020a8..03cd3d4831ef 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -17,11 +17,12 @@ static void ipi_remote_fence_i(void *info)
 	return local_flush_icache_all();
 }
 
-void flush_icache_all(void)
+void flush_icache_all(bool want_ipi)
 {
 	local_flush_icache_all();
 
-	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
+	if (IS_ENABLED(CONFIG_RISCV_SBI) &&
+	    (!want_ipi || !riscv_use_ipi_for_rfence()))
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
@@ -87,7 +88,7 @@ void flush_icache_pte(pte_t pte)
 	struct folio *folio = page_folio(pte_page(pte));
 
 	if (!test_bit(PG_dcache_clean, &folio->flags)) {
-		flush_icache_all();
+		flush_icache_all(true);
 		set_bit(PG_dcache_clean, &folio->flags);
 	}
 }
-- 
2.34.1


