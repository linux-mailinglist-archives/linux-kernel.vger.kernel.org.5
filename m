Return-Path: <linux-kernel+bounces-62546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C641A8522A0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B17284718
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA309524C3;
	Mon, 12 Feb 2024 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Q35k1rqB"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F651C31
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780998; cv=none; b=XTx7XeUw35by2SWkhpjdfML93WoJ+R0xvpGyA4HUdeJ5Cm7j5EuB954P9/ZxDseCL3F8HVQrCnCw3KBScYLQzohdVwPc1a2WbfY/xCriEC+RMmV5VEnynstv1KCIhitHWhGyEJ8c3eZ/lb6ho8EOohfFOud5T7K/8TkkDkLJ/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780998; c=relaxed/simple;
	bh=teNltxEe5ATnvQPKeLgPp6b3k0t1rOkLmnDUUB6OJdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ekSE7LNiTs/Y9P41nvP9mJR6NhyWIaQ9f2xCmIDItJCy6Z1G6mnKdASUH+VHZ0TeNLgidjHTKrMhCGGXUmJvjdlk0iqw0Nx0JfcCFjqm0z0K4ewn9hq2ulNSARV4mb2xNMkTon16R5fVA6OEOwAdm51IHXRXBXW8JihgB7pw4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Q35k1rqB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d70b0e521eso28788425ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707780996; x=1708385796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqFsnYbayaROauH/yeBk3F9rNPdoEfeRLt6dO0Xr65g=;
        b=Q35k1rqB4YpMTGpKAqZt4kbWTfOmhg2zYuJUOvj36dLLgAXt9kV9jorYIu0+StBmQR
         xKVI+uL5b9WL02m1HijiMafaYxzXoG7N6unUh3nCvxGrduvMXh49gmZQDmBbfF7Lv6or
         UutyATMyanVGpvgko86IVXA+UeMLd8hqycxxYBR6Wx+WbnBdvLPp47cVwa8VgQw81bGb
         YUbOlZnL2iUdAMlk3KNB2JsyCN8MO6aI5cE56oFb4pN2VHZjM8rkFw1Jsa6ZNZHLvDby
         x7MzBJrqxuPpf2crusLzy7BkeG4BuyJ9yUnUWBFnl7F3AAwwKxMCQpw6MkDrPin4QhS7
         /mGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707780997; x=1708385797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqFsnYbayaROauH/yeBk3F9rNPdoEfeRLt6dO0Xr65g=;
        b=L8KICoPf4c4s62JOrHklgEKmjNYKa5pCm0tBFIA9aFRuN2HYFPp+gPvqshE8ABEVcA
         v9WedOjPEcC1i0pTBlTHqnHaz8MSftVKuNuClb0b6UuIK3CbBZ3wKWBp+TzTJnFQtv1H
         CntHfa6JQ9TOeJh2cUhOWzxMl6b46J90gSYsof/N5aD7+KIz13B2X2r8JbBZhi9Y1/G5
         TdqrddKZaxzECQvXqKLDcvUKPZUeOWX/8wapfmDPDXhKAqknnIwHRVbYxhAbHdeJFLTH
         dYmw7APJ3W7cA4BqCpUWKYvbwqvnryF/R/bHUXzrAUnHZGoY9kW8fIGoEv/16+0E45ru
         TqyA==
X-Forwarded-Encrypted: i=1; AJvYcCUNErQfvIXmpL66YlHHZq7QN5W+wcbuMk2j8JTmVY2oSKuZHp8DvDIwgeVe6Zed6Pqqu8W0y+eDRP0+CGnWCuGoMLcIA+/jdUFOZnl5
X-Gm-Message-State: AOJu0Yxb73RrMd0JLLTlk8/fqaN2vaHtDta87K5MjhjddT3dR5H4Z4Fz
	N++cWF1BVDuFyKxrc7GjPacFNAWxPAXaqqrRTDFnafLwD0Ntlbz5eFmbtOqF0cQ=
X-Google-Smtp-Source: AGHT+IEtzelG1aBj8MhHUkWpgbenml+rvNSXi4YOjQkaIXkajpKLpyf9eRWHPskzRMV/SZLXbDR4ug==
X-Received: by 2002:a17:902:ecc1:b0:1d7:b1f:be9e with SMTP id a1-20020a170902ecc100b001d70b1fbe9emr9547643plh.66.1707780996763;
        Mon, 12 Feb 2024 15:36:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmhahLkBycaRs+zzoTPL0pP1/Wbhljlk09mGvZl2U3BYlRz5afgzfA4K6oqUcu0CEflM4zj5+TqIePAEv1u9fURwIXrlf9AzC8VlXIv3fVP2DyI2ElWKkAeanWCs3jfOGB55CzBhMOKNK7t91AFuCyfpr4hG54nAJds3f4sSV/prcfAWmcrnbBMVlm49hPtTlMiLw3bu4G8rxu4OuobxGyLSqhOg50X9uwZDi/69PwQrtG4GAJTMhS1bmhY8NjeEdYt7zKMUFhPBN5NmfRWbF3Ci7F2uELrXj92QbZKRN/KTacsTyfNLYjc/k9bL7lSTdk+FXPauBA/9p9ZxViYmvh+WCSf4bb33CHZnad4402Ud3kDU2e9RlKDluUzWsPPLzK4MwXbl4=
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b001da153682c5sm888693plk.261.2024.02.12.15.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 15:36:36 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 12 Feb 2024 15:36:29 -0800
Subject: [PATCH v11 4/4] cpumask: Add assign cpu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-fencei-v11-4-e1327f25fe10@rivosinc.com>
References: <20240212-fencei-v11-0-e1327f25fe10@rivosinc.com>
In-Reply-To: <20240212-fencei-v11-0-e1327f25fe10@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707780989; l=1797;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=teNltxEe5ATnvQPKeLgPp6b3k0t1rOkLmnDUUB6OJdA=;
 b=EiKlcL1ulk4DvUiCSUgvbFtR389U08UGs9J+Mx1NjicMNyA7ytjbg4bgirWaWZZtdE5HGgwHU
 EVUxZnpx4C/A+JHiRo45OTnP3oYSGtoMtT2ZFchA7WKDMysLkz7sWPx
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Standardize an assign_cpu function for cpumasks.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/mm/cacheflush.c |  2 +-
 include/linux/cpumask.h    | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 6513a0ab8655..d10c2cba8aff 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -234,7 +234,7 @@ int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long scope)
 			stale_cpu = cpumask_test_cpu(smp_processor_id(), mask);
 
 			cpumask_setall(mask);
-			assign_bit(cpumask_check(smp_processor_id()), cpumask_bits(mask), stale_cpu);
+			cpumask_assign_cpu(smp_processor_id(), mask, stale_cpu);
 			break;
 		case PR_RISCV_SCOPE_PER_THREAD:
 			current->thread.force_icache_flush = false;
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index cfb545841a2c..1b85e09c4ba5 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -492,6 +492,22 @@ static __always_inline void __cpumask_clear_cpu(int cpu, struct cpumask *dstp)
 	__clear_bit(cpumask_check(cpu), cpumask_bits(dstp));
 }
 
+/**
+ * cpumask_assign_cpu - assign a cpu in a cpumask
+ * @cpu: cpu number (< nr_cpu_ids)
+ * @dstp: the cpumask pointer
+ * @bool: the value to assign
+ */
+static __always_inline void cpumask_assign_cpu(int cpu, struct cpumask *dstp, bool value)
+{
+	assign_bit(cpumask_check(cpu), cpumask_bits(dstp), value);
+}
+
+static __always_inline void __cpumask_assign_cpu(int cpu, struct cpumask *dstp, bool value)
+{
+	__assign_bit(cpumask_check(cpu), cpumask_bits(dstp), value);
+}
+
 /**
  * cpumask_test_cpu - test for a cpu in a cpumask
  * @cpu: cpu number (< nr_cpu_ids)

-- 
2.43.0


