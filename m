Return-Path: <linux-kernel+bounces-147408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 913BB8A738B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44B01C20E11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8820613BAE5;
	Tue, 16 Apr 2024 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="b5XZ6mkY"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A6713AD1A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293096; cv=none; b=aBOdzl1UEb7Wqhv/QGjei3xyMLkxxT8jJLoPqb5EzyIXn1OdqwTlssFD0Ol+027oSUzhO8roX5ku/ErShyAO2h3nQizvrbq/ozTiiUrFFKXXwOMBhiaXaBZD78zosdYyrLjLfjHwu97+vvsdUmo+kojevlIQcq60ojnJLNQe1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293096; c=relaxed/simple;
	bh=FPsPyygnZSr74eMjLFaKQWi7YHw8uHVHUe/hFFEqBDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GHIGOnWTs2c0Bxqfv2lZJwsGZMwdAxSRjmhqERCa0zfozooBHYFJMdcY/uzlndswpUASGLx7x3eQ5T05+dz/hBdZBhXQGTh/lJO6gQ6EQfOXyuamVUedntG/wKEUq4y7zRD56Es5RvoxKPDa9UPjfOwyveM1AniLvdRHgAZyMqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=b5XZ6mkY; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so2739808a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293094; x=1713897894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuiEup71RSFWQPf1rf4RZ6WG8aw8PhI/oCK0Eh5yTgQ=;
        b=b5XZ6mkYtKyfA7hQYHpadL5ezFzYwfwMVwu3ecZQx0dJcd558JYHYo32gdqx95WinN
         alHUoLDGSRzWA5SG+x1Op1COLvpMzsYOCszsb1kx1v73qaUFRYLQ87SaZglxiTQ5l6Ul
         VbOW3g7vP0mH5ag9T6JABK6+49ztwZaqMAfkv1gR0nml99Npu28qYOjuZ0eDTeI2l6Z0
         kAam6LwguiP6PiuyYyzt8cfI58qLGvtdGDKCXEkLDnGku95k8RWPBKNp6m2NR1yFLDKL
         rzyyEhfDMsywle73YVEvMK/AmI4d0j5CJ8/TePt/bDcXInsmlkq5FWPObH95YotMrJ+y
         rTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293094; x=1713897894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuiEup71RSFWQPf1rf4RZ6WG8aw8PhI/oCK0Eh5yTgQ=;
        b=i89QjF9DUbB6mXjXDi/Jizz/2Zc01sUxX9Row6LM8lQg7+Pv754FObM0P06hmMtOJs
         0daTy/7HJOo4oi5hGQ4RA3/1PjqX6tYGRvYveIOOcR29SFZPxYcypUligNiRdPyIkV1U
         Naytv3sKjq1EQP+k3RbWTG7gkVARbgnvpt9D5TMPV19D2szqOlDaz/0m8YmjTezi8jvt
         bfiZjmsX3qZjZPUZnTj1PXUHBeufEqdd59rLUk1tzkrFb+Eh58ED5thzJxSyEkP3lCrI
         +sjDjgmBiRiQbunEfxVofNnz/13FB6dfUcQeMJJdjc6iNWAsTo82mF/kmF6VUKgEAIsg
         bYNA==
X-Gm-Message-State: AOJu0Yx2NtluNGt5fW8KmmV3aPDadKCWpetQmMCVtHoN2nb8SyBkhCVw
	ypE5dzGdkCgkSNh00acB+iMEHKrW/Y7/VrVd+cBrQB+ztbgd7sMOJEw5mAL97JGNITAvnN414ty
	q
X-Google-Smtp-Source: AGHT+IFUOmaHhHwroe47EwxqNzGwapgmI0FWodfq5R0EG3ViEdjmhW2QsjYr95rUk+wVWdwWIZqupw==
X-Received: by 2002:a17:90a:601:b0:29d:eea9:c800 with SMTP id j1-20020a17090a060100b0029deea9c800mr11091313pjj.7.1713293094327;
        Tue, 16 Apr 2024 11:44:54 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:53 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v7 09/24] drivers/perf: riscv: Fix counter mask iteration for RV32
Date: Tue, 16 Apr 2024 11:44:06 -0700
Message-Id: <20240416184421.3693802-10-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For RV32, used_hw_ctrs can have more than 1 word if the firmware chooses
to interleave firmware/hardware counters indicies. Even though it's a
unlikely scenario, handle that case by iterating over all the words
instead of just using the first word.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_sbi.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index dabf8a17b096..60bcd52f6da9 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -772,13 +772,15 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
 {
 	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
 	unsigned long flag = 0;
+	int i;
 
 	if (sbi_pmu_snapshot_available())
 		flag = SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
 
-	/* No need to check the error here as we can't do anything about the error */
-	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, 0,
-		  cpu_hw_evt->used_hw_ctrs[0], flag, 0, 0, 0);
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++)
+		/* No need to check the error here as we can't do anything about the error */
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, i * BITS_PER_LONG,
+			  cpu_hw_evt->used_hw_ctrs[i], flag, 0, 0, 0);
 }
 
 /*
@@ -790,7 +792,7 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
 static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
 						unsigned long ctr_ovf_mask)
 {
-	int idx = 0;
+	int idx = 0, i;
 	struct perf_event *event;
 	unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
 	unsigned long ctr_start_mask = 0;
@@ -798,11 +800,12 @@ static noinline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt
 	struct hw_perf_event *hwc;
 	u64 init_val = 0;
 
-	ctr_start_mask = cpu_hw_evt->used_hw_ctrs[0] & ~ctr_ovf_mask;
-
-	/* Start all the counters that did not overflow in a single shot */
-	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_mask,
-		  0, 0, 0, 0);
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
+		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
+		/* Start all the counters that did not overflow in a single shot */
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG, ctr_start_mask,
+			0, 0, 0, 0);
+	}
 
 	/* Reinitialize and start all the counter that overflowed */
 	while (ctr_ovf_mask) {
-- 
2.34.1


