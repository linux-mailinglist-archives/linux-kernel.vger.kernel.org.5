Return-Path: <linux-kernel+bounces-60659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF0B850821
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A70A1C20C90
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5877458AD9;
	Sun, 11 Feb 2024 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DuFPPgP5"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DAD3F9FA
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640606; cv=none; b=iNRx4XmRlSyuyQ0c0L4LW5LZBCyRGsoly6839BG/NNIes+hqIrgIlfNTXs2410fmMRdI41N773klpx54a1o4C0WP9T4UdaQtZmG6YahEyVEtYMRfx+wotqVRLCnBhgDcv7OIwaQ7HxkoWH9Q+mGiHsla6fdYcEMEm4kMpi8FzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640606; c=relaxed/simple;
	bh=PaQEOmqiRvmk/nVIn8ZoXgDVArBIW2evYornBF1T+Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LHiI07iVzrrAaVi9W4goWpzcMrkKsGM4Nny2pkK9gJ7PJe4cQ6OmU9PKue8Qd2YYM2XnzpHIbETF9P2SRYj4KkinIcIH8msj11MMJLb0mAtHYl3yjWbT6+043HJFLHkQHE1uKgkAXo5Sbz6eBowh0cdWvNUY0Nhf4Lla4TIE8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DuFPPgP5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-410a2adf878so6486725e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 00:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707640602; x=1708245402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WgK2rhF0MEavRxG1nB7KIKdfUxp0z+0YRkDvo4+DSAo=;
        b=DuFPPgP5Kk4upRPMzGWMov0cEaLppQNj0QBd/h7WYvoZg9Dlh2HfjBlExYoWlcEpMg
         N0d22dFXMzR6ZMf5zd8rhzlc0olzEwuU0bWt5NsHjjZtPh+/24nd6KVGqHddtAs4Zd+L
         KJ+xgY8DoqVleKUHBsG/rfYJWIVTC1ArAW/+0JBRsm6TGk30GM4iyWVNb9MosG+PbwUg
         hbpmgMe9ar8lWboMm15OvaFBG8cqwsUHpVbUao8c+PXOFAKHCwS9cno2twz0W0bkxFdv
         URlXKvLm0Re4o7kdVw2765tbpRLBjSarYho2XxU/4tVSNXXTcWKzHFWmAciimmO/Hc3p
         GP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707640602; x=1708245402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgK2rhF0MEavRxG1nB7KIKdfUxp0z+0YRkDvo4+DSAo=;
        b=XahfnGoLqQqvYBeea83N0UAt2aGYSukUXJ2ww3UYOpAmlbzLNn5rjRFCcMokJrBfK7
         hUmYTMr0iMIAwfUm13niu0TK3vBxzXi1hCtbp8FkkSBbO+zZGXBc6ThnDphImbMhjW4M
         c5kCy+ShKRCpRS4CSUj+mhUIIxmQmezlAgn8b589PHIruVUewVU2vsa3RDy9AVgEyN3G
         PyJ3zZGv0jzRrz/+LBJtEGykIIhUJTTVQYDZo19M8t+d1jFp1tGDEeXlcCz9MS4wJttL
         ssiNaBuWLmrjeynNHPoVzpOqwxflDVKyZ7Maym31YqSZ1etDo2ShCKUjTts4MFx5q3lQ
         LdtA==
X-Gm-Message-State: AOJu0YzhBNTdpjuPibUDezhCL8y1OWqBjZbFrTY98uyCa3j6NQbdQp40
	UBiog0uL+mqPjQ13G0Jf+4oN/TLzYjk3UjU870B2KYKadXpA/PBSho1ZQq2TZZU=
X-Google-Smtp-Source: AGHT+IF6J6ikEknPWNk0mkR0oXLiZIQqS80e+U5t4O1lcDADleZa9BZYSBIYhXb367ecZ3+J8anU9A==
X-Received: by 2002:a05:600c:1d11:b0:410:6a37:89c with SMTP id l17-20020a05600c1d1100b004106a37089cmr3067197wms.13.1707640601917;
        Sun, 11 Feb 2024 00:36:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWb/SQxYauRZY0HBr6Cqy/kvT5IVBu6SCA1i6zk+vNJoZLBmYvB4pbObUujZlCM/ql0Y8VwwIYxryM5ZBR7bhEG/2TbbpCyJ9TUucLRrsfFlysHXgALNR3L09EG46mqr1Hqq2EIyi6tO51SSzkEd6cnkKLIAzv6fcByNBkA136GJADRJhNhfCPkgQXNmRIwmx8ER1tK2YCmc0QVziEAqVh9jt0S6Ek3Cf4V56h78LPvyQ==
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id w6-20020a05600c474600b0040efc268713sm5321708wmo.26.2024.02.11.00.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 00:36:41 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
Subject: [PATCH -fixes] riscv: Fix build error if !CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
Date: Sun, 11 Feb 2024 09:36:40 +0100
Message-Id: <20240211083640.756583-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new riscv specific arch_hugetlb_migration_supported() must be
guarded with a #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION to avoid
the following build error:

In file included from include/linux/hugetlb.h:851,
                    from kernel/fork.c:52:
>> arch/riscv/include/asm/hugetlb.h:15:42: error: static declaration of 'arch_hugetlb_migration_supported' follows non-static declaration
      15 | #define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hugetlb.h:916:20: note: in expansion of macro 'arch_hugetlb_migration_supported'
     916 | static inline bool arch_hugetlb_migration_supported(struct hstate *h)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/hugetlb.h:14:6: note: previous declaration of 'arch_hugetlb_migration_supported' with type 'bool(struct hstate *)' {aka '_Bool(struct hstate *)'}
      14 | bool arch_hugetlb_migration_supported(struct hstate *h);
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402110258.CV51JlEI-lkp@intel.com/
Fixes: ce68c035457b ("riscv: Fix arch_hugetlb_migration_supported() for NAPOT")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/hugetlb.h | 2 ++
 arch/riscv/mm/hugetlbpage.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index 20f9c3ba2341..22deb7a2a6ec 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -11,8 +11,10 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 }
 #define arch_clear_hugepage_flags arch_clear_hugepage_flags
 
+#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 bool arch_hugetlb_migration_supported(struct hstate *h);
 #define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
+#endif
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 #define __HAVE_ARCH_HUGE_PTE_CLEAR
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 29c7606414d2..5ef2a6891158 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -426,10 +426,12 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 	return __hugetlb_valid_size(size);
 }
 
+#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 bool arch_hugetlb_migration_supported(struct hstate *h)
 {
 	return __hugetlb_valid_size(huge_page_size(h));
 }
+#endif
 
 #ifdef CONFIG_CONTIG_ALLOC
 static __init int gigantic_pages_init(void)
-- 
2.39.2


