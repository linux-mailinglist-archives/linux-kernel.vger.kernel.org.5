Return-Path: <linux-kernel+bounces-35386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C78839007
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EDF292D38
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E025F85C;
	Tue, 23 Jan 2024 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GRgDkmS8"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08B65F852
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016456; cv=none; b=XRvjsxrWmJtEhrINWp9KYNJbazTqTM0ciI+C74l8iaN7IAPNUNSFG4p0JQJXFjChDENGHPpYRH33yGQ9DEyA7h6jtMLXkHvqAFRyRqNV/7PbUFdPqugTQn6S2xnaXSMxrUPwaJwcEAwOt4bqnvYrN1bRnFhABHaj6NE7tRg7MZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016456; c=relaxed/simple;
	bh=4951Xxv7xemiO5DxAc/QzmfbApiZAuyJPUfXzXCYCGY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=CDB6gANGf8DnW7jWgN9LX55afMkI1O1P+r/oS+mjVSS5X+3+tvpSiMnL+ueXjuKDwoZoPkCwgMHzVXk077tVVIBATNcQN2I1vTkc6Izs7LLU47rXF/3eqoRKvHFnCI1ZlsQqC22wrqzsCOAY1TNAhXQyV5SBfex/ncf7NmfcaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GRgDkmS8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-337cf4eabc9so3508868f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 05:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706016453; x=1706621253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QL2GFdOO+kItFWYTRtC2kovPV4Gzg0BKVM2d6mHAVeo=;
        b=GRgDkmS8NaEUUGQ27WwftwFamvOLeYxW9JNsMYBQMVA5rUnbzZmrInO19CUy/twy8b
         2WvWIMct80Hinv16gHnrQduEf7wbRTV++/AlaqVKSanFTdRT58SUn0vzw3mKKEjLw7V/
         7glPp9eqf1zhp+yFxTJnq29w/iddfDoPf7ig0GDaUExx1EDKAhUXJ8YDB3ndIdCRenw6
         pltxeaPvyE2jQWIFQ+9uT0KdDILsknxb9VyGLjxzsLwHUTTSBZpqJqQYXUv/ZyoGgnQN
         Ayskg/ZZza1GyUWJpukJRuSUP8Ua085IbgVvL2vOLt8hlOQ7ViwpJGgeHBpFcH9G1cfW
         xfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706016453; x=1706621253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QL2GFdOO+kItFWYTRtC2kovPV4Gzg0BKVM2d6mHAVeo=;
        b=FfT2poUp09NkU3zDYXbfsh//69/DN1Tz2JIosowx4kHN+DH0qy5e8I3xsEzjeQ09dR
         aYuA4kq8mq4j6Aer8KqWimOJEF3dXND3zT8FaBWbv+OnoxHR6icdDpljXndk+qW+Es1X
         4/s5v/oBnKqQoLaiD/AxnLrmvfX/1exLUYTU0WCOheTmj7q3bEKbd76Sd3MdB9Y7EURU
         hL42DPQR0zi2R6YFJJBZBnSBEaeSP4EGTWwDc8Nb1BBeXxGJmq8f8p0upksE62Z0zCpM
         XzbP4mHLTykK/EB0GW5EFRs6R40eUFmgnzT8mVo1BZ5HMIxY92frN+R/vhO0t+aghtTm
         FKlw==
X-Gm-Message-State: AOJu0YzA7iOw4BMAkl6jgjidxtxqiHwoDNcUym9STp4+Gvq2qHDi2j5R
	KfPuXextcFZMDYwdU0K8T9rLzkoqhTJc01NeMErlcX5y77VtOq3/khfwvQbvyp/qHa9tvYCGkq4
	p
X-Google-Smtp-Source: AGHT+IG5XIy+1vzarPkJNH17F+T3vYPOYhLpPlb/4qpi1Gz3DTxWN1NwgqXH8kvpbyFb4ZjOd0Xacg==
X-Received: by 2002:adf:fdc7:0:b0:337:70cd:a02f with SMTP id i7-20020adffdc7000000b0033770cda02fmr3005386wrs.9.1706016452996;
        Tue, 23 Jan 2024 05:27:32 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id y6-20020a5d6146000000b003392f625adcsm6652270wrt.36.2024.01.23.05.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 05:27:32 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Dennis Zhou <dennis@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Fix wrong size passed to local_flush_tlb_range_asid()
Date: Tue, 23 Jan 2024 14:27:30 +0100
Message-Id: <20240123132730.2297719-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

local_flush_tlb_range_asid() takes the size as argument, not the end of
the range to flush, so fix this by computing the size from the end and
the start of the range.

Fixes: 7a92fc8b4d20 ("mm: Introduce flush_cache_vmap_early()")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/tlbflush.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 8d12b26f5ac3..9619965f6501 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -68,7 +68,7 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
 
 void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	local_flush_tlb_range_asid(start, end, PAGE_SIZE, FLUSH_TLB_NO_ASID);
+	local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_TLB_NO_ASID);
 }
 
 static void __ipi_flush_tlb_all(void *info)
-- 
2.39.2


