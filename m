Return-Path: <linux-kernel+bounces-44558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE0A842430
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABC3286D87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523AF67E69;
	Tue, 30 Jan 2024 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MxPXLMe+"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6702967E63
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615714; cv=none; b=rPe6mmxAexWIkwiAHFrfH4C4MUFmDKe80OhF+ztNkBIBCF9ImDn47/jpy1quyqj03pHNCgZ1OkE9s587XPR9M6MkEwKJwJgaZPj/T/SPIWV6I91NFT02qq+3t0NGcuMnRK0m/q7c4QlknkxkPkCaLV1TBCUt3EmBxbCeK0ED68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615714; c=relaxed/simple;
	bh=o45m/mtm5VLmwqkGL2en//81iIvC/rh+THDkmb6twWo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=t+kHOp3XcapTAtgUovM+a2yKgatXqq7cPb4/BHqxpFWrbQBM/JM7t88pOruiNbNKk0qZ92CwVC/XNg/pvm6u2cb2BkWGZ4DOf/7gVMxsxMheWQw6nyJWZlPH9ubxe++lmF0OVg3ijKDAGYrj5Qkgu/wYZq+ENQtWa3EudEMw+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MxPXLMe+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33aea66a31cso1176981f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706615711; x=1707220511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=96xTLiCr7psVkkYjzXmoBovLDjznb7PjBA5px/xb+ds=;
        b=MxPXLMe+ddh53GwafpLjWQe0+lbNq+ounMXH8yVRAsUI+aFvBA0bfNsyipTKDDIrO4
         vMqYcLXihiamrw0QgPBvD3gwzP+GT/Y9dIcVwX1OHydIR33kHD2p2ZxY9bweqYgr241v
         hGJsIw71Rg9aeb+Q5Ld96NovpdQlTfZAh0Q1uIzif6nVYaDRwdzSWq9pUNgKoUqF05Zu
         SAOeyIDKH5SU9nva11FXWcIawSn4oOfJ1SqD0+wCt9JL+QqgbUFwE1Xemm4OVQ/jl8IK
         bIZ9BiGI2NMsf0E9mDuL5sPwhNNFRULz5SWGicgR6I/bRENjjn5qre6nBqAaGs7phBwZ
         lDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706615711; x=1707220511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96xTLiCr7psVkkYjzXmoBovLDjznb7PjBA5px/xb+ds=;
        b=bpbfL63t7QFQtObTio5lDnkv+f1wAheTFjCVF5bZiKLHemWoGC/qL46sTiHngH4NHv
         kowkrLvmm/mGm17ESRG140EmDkR6Z8la2eQ83mwe1gWwc7x7MVsZvanGXhBWL1C/RjNY
         kAIgxuRP+h0qM65BEMhIWGUxygndJn0eTc4lkquftBJ+47sSft6oSk5ZUCjza9H1uMoW
         X10VKXW3Z6U+rngQS9rBrTXx4Pk2/g99Y4cJmpZg4stTapkTAT2JlRDX6UnXD3zlQRH2
         meUmK9CzDXpdoex2yEuFxOGq3BitEaebF7Eg0YiITAt8CE6V3rLuAHaZYtOlXyIBeZod
         jr1w==
X-Gm-Message-State: AOJu0YxLp7cN7L7+C5osMzzsw0BlRBSrQizu5S8QCXzSZCXK7OfYWU7H
	gklaheUG1U4rRMee0pM/BSEPzpHQu1MKhhs5MMrb5vMjTB2hkOaXDNfiR1zIGjg=
X-Google-Smtp-Source: AGHT+IE88dSxF2s7rFZw1Sosf/6KlrIQmsVVf4dV1I57Dj+3ljlOoH1xXX4Lm+DFI884EUF261e+YQ==
X-Received: by 2002:a5d:4a83:0:b0:33a:e403:dd91 with SMTP id o3-20020a5d4a83000000b0033ae403dd91mr6962974wrq.21.1706615710690;
        Tue, 30 Jan 2024 03:55:10 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d69d2000000b003393457afc2sm10502841wrw.95.2024.01.30.03.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:55:10 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -fixes] riscv: Fix arch_tlbbatch_flush() by clearing the batch cpumask
Date: Tue, 30 Jan 2024 12:55:08 +0100
Message-Id: <20240130115508.105386-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We must clear the cpumask once we have flushed the batch, otherwise cpus
get accumulated and we end sending IPIs to more cpus than needed.

Fixes: 54d7431af73e ("riscv: Add support for BATCHED_UNMAP_TLB_FLUSH")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/tlbflush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 99c3e037f127..c8efc3f87a0f 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -240,4 +240,5 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
 	__flush_tlb_range(NULL, &batch->cpumask,
 			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
+	cpumask_clear(&batch->cpumask);
 }
-- 
2.39.2


