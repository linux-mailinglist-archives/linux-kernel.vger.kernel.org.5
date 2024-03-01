Return-Path: <linux-kernel+bounces-88164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C686DE12
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA0EB26752
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C65E6A8A1;
	Fri,  1 Mar 2024 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zPCwsrHJ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5AD6A34B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284820; cv=none; b=WpVWFzLVWvAQWKUHn1bXzzjLWzKZ26ZLZyoVWsIE5qvaz89TAYEjZnO/1VdWPFM5cpPqf/YYfpExm2k4vN7KaNp1W8gYmiZxWgQ4bnZNzIIOSKuyAJ+12bXSr9rmQf6BRgCHJkc9PjQIfRIiNfZzFaX7CGXaaw+mJ8IEW44UDjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284820; c=relaxed/simple;
	bh=deJfNqmd+84vDDBO0fDBd8YCdfhsA76uVTjUbdf6HeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mJOz939GfnMa5SzyKDCcWv5uY2AeAexXHXNUKwGEWPlqWuw3DmiaBYLzseA3Gb6ujyhb4ktRQj8n4g7r6Iyk4nmBV0HXCc/l49fG7D0gFMPUkOgYjQgLxfZiF6qYkG5SqM7sdsjj9fy2JKIe971I4vKbRqtSIKwbIpuSReBiLEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zPCwsrHJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412a9e9c776so17909525e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 01:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709284817; x=1709889617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdWlfuEJdB5bVZdrcri04Zmq/yhRfMcRDdftEw7qNFA=;
        b=zPCwsrHJ0eOHW1Zv7kbRW3DsboeAnoZUSy0hAXtloUAYPfO4RAkUjsac/X2ewPz05k
         W6hoat+sjn8uzRpkkIEHZ/bxqUXkMWuIhCymnz5+GL2NRotPD2c3n0Vs9caGI/nP9MAg
         7/yY4MVZ4/Pws1E8MFkip8bxCsn/2/k5FrTdIh50aDXYOjZVJD/qLxxN1D5ietqs28Y1
         fsrcWfMP+K4AQF1mphtfOYovOE3FA/b8HfnCJkaaBMsr6BGDPQv+24Q318PBfhdK9cEj
         Vcs2DwNsQFc/qFX6IITboGPZAjyfk+nN2bPmiDjOHbBRPIerGSIGZfpJuCGyt1I6qQMX
         wBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709284817; x=1709889617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdWlfuEJdB5bVZdrcri04Zmq/yhRfMcRDdftEw7qNFA=;
        b=hAsxSpopjcCdoCdM7aXFhbRdCzIZK8lHZmCxLZLSKxmJxwGfP61P1JcIuETRHqHo3u
         5TMgj+7NU4UebDQX9TCzjGpEwqPSrN8SLIkLKtZHz9FBfTxvKHBgGkGroLHp1s95i7Tx
         OtF8J9wmtdIng9sb0zcxHwJfBvIERbiM2MHs+IhECIlI/GZb1g7m3M3EJAovWaqG6xBq
         0iXR44l9S4N8OJuKpELb8zt0a+tknS2kSYHkUek1D9FJIVfv0n9hAd7d7ScMYaegZscE
         MQ4WRp5TnPtOWzMcnSzD4ik9GcMvoV7lFy7CC0fvr2rU62YoSNRINdEsxxAVLB/NGYsX
         zDLw==
X-Forwarded-Encrypted: i=1; AJvYcCWLB7yOdZipiapj6YFKl6mo2Iv92wv2xL9B3KDKuuAOp73nUwtWmhX26uwZjXD1A/fKNdrDMXNh2xsA/7MEbfZ1eEOFugE//2VxnOHc
X-Gm-Message-State: AOJu0YxdAZWDJp0UnSK+6oTk5P4Odw2V4rogoJMOhR1jeYNXtN2e+TPC
	jxlUGOllBwiEEYC+MowPN4hZUVz6qwjJ4WBFLiDCmWbge0Ez0cY2dRnJwaV2kPw=
X-Google-Smtp-Source: AGHT+IHirYUWWAQ3EzQ3D3sM4w5kbNmWdiMfyHww76VDivA5fk7+UlmhKkRo6vORNs4FOsSe8ylbjw==
X-Received: by 2002:adf:a3c9:0:b0:33e:21bc:bc6f with SMTP id m9-20020adfa3c9000000b0033e21bcbc6fmr809159wrb.11.1709284817327;
        Fri, 01 Mar 2024 01:20:17 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id l9-20020a056000022900b0033cf2063052sm3994161wrz.111.2024.03.01.01.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:20:17 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 5/9] mm: Use common huge_pte_clear() function for riscv/arm64
Date: Fri,  1 Mar 2024 10:14:51 +0100
Message-Id: <20240301091455.246686-6-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301091455.246686-1-alexghiti@rivosinc.com>
References: <20240301091455.246686-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both architectures have the same implementation so move it to generic code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/mm/hugetlbpage.c | 12 ------------
 arch/riscv/mm/hugetlbpage.c | 19 -------------------
 mm/contpte.c                | 13 +++++++++++++
 3 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 4da951e81bde..09b55bac8c7c 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -284,18 +284,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
-		    pte_t *ptep, unsigned long sz)
-{
-	int i, ncontig;
-	size_t pgsize;
-
-	ncontig = arch_contpte_get_num_contig(NULL, sz, &pgsize);
-
-	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
-		pte_clear(mm, addr, ptep);
-}
-
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index ebc735f5d325..01b1403dd4cb 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -254,25 +254,6 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 	return get_clear_contig_flush(vma->vm_mm, addr, ptep, pte_num);
 }
 
-void huge_pte_clear(struct mm_struct *mm,
-		    unsigned long addr,
-		    pte_t *ptep,
-		    unsigned long sz)
-{
-	size_t pgsize;
-	pte_t pte = ptep_get(ptep);
-	int i, pte_num;
-
-	if (!pte_napot(pte)) {
-		pte_clear(mm, addr, ptep);
-		return;
-	}
-
-	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
-	for (i = 0; i < pte_num; i++, addr += pgsize, ptep++)
-		pte_clear(mm, addr, ptep);
-}
-
 static bool is_napot_size(unsigned long size)
 {
 	unsigned long order;
diff --git a/mm/contpte.c b/mm/contpte.c
index f7bfa861c6a1..5200c234404d 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -19,6 +19,7 @@
  * This file implements the following contpte aware API:
  * huge_ptep_get()
  * set_huge_pte_at()
+ * huge_pte_clear()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -101,3 +102,15 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 	set_contptes(mm, addr, ptep, pte, ncontig, pgsize);
 }
+
+void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
+		    pte_t *ptep, unsigned long sz)
+{
+	int i, ncontig;
+	size_t pgsize;
+
+	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
+
+	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
+		pte_clear(mm, addr, ptep);
+}
-- 
2.39.2


