Return-Path: <linux-kernel+bounces-152033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C09C58AB7B7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A9C1F21BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18B9144317;
	Fri, 19 Apr 2024 23:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ovqiwdIm"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B3D145345
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 23:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570485; cv=none; b=WpmpmGNqI03+vp8GthWpyJYTdyHadAtnUzp0QU0fPvPtmCT6PwxvOyNQfnh9/PFPV7OUfAyFkHc0GmX2BHDPW/kOqE5X+uPYcA7JO1lsqOYwBbwUwIZ2wV331xm1jXDeMCWZlwkCxlAYJ5ZZxdkfOXtZxZZP+3nWCpf2lMaEVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570485; c=relaxed/simple;
	bh=i4/+SnhxIOkVH6jnqRPVGKLSvQvEdBjQqHeh5YP3SQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Se9DZd0ZgvXLPR5DY/WYMUBvSJe+wqwCIV6Vo6+zSrSdMImeMHiC9qF5KLqfePNGoomZCGpgi3f0hwr815Cppj2LLrzKRa+xK4c6zm9ejQkHyMJCkZE5E4m+PK7MLLwrDmj0urpf4JfQ9nrCHdnxKFHx777HH/fiT7HkKU4ECdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ovqiwdIm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e40042c13eso21256645ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570483; x=1714175283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=ovqiwdIm+tdsGciS90weKXkMlO8DwB/UxneEkFaoo1mgU3NtFEq9GEIpJ3XVa/Mm6S
         3ZOYsl2x5iVjNX97pFAyN4vhzf7q7c1t5XoXq2nKgxpzwfhBApvWe1coJSx5AbgFe2AI
         ShfAxvxpBDe9pe3CsftZqHSL+WRdSI7oN+RYk5YxOMUEKqS6jSih5ex7GljPZ7LdUlvm
         i+XrwrppMxr126gsSHB0zAj9YKIR99SBZupyqErK6Lxzs1b1ERFLY4gzpKk8hooNDtrj
         RWe+8IJ/OdGtO49ugND1qQJUuoZhxo87/3NO1Afc1/UAi1J+5Pdz4TfXKkpRU+gO9nux
         +voQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570483; x=1714175283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=C9w3Sqhy5PP5lFW9GcSJQRkTlKF1G7Z7U7sCFFhx1K21TFiUb0dd26PhB0H7cFOyu8
         rMepT4wzVclY0m20XnN/NGShr4F0KuGsbxmo+HzDadE3nW5QaYb3Lnm7+4zTRsHtpckV
         FexYaWz7SjGFHfvJtStaUwDz9BNTge8z5/WOshBOl8v8J6o0Tj4IiX3ebPO9Ou7kvXw5
         4QqNxIwk36c9Nk1c7MFyc1i2t+w/6EfxTdOAjDguEqZ3t53jCA/uVc/ERmrh+TQJPKo6
         FqNjoYjS5o5dozTBKK7c58dm4AADliORwoAzWjX68DHL3D+QTGDA95K5gS7sajXxVUd2
         lmVw==
X-Gm-Message-State: AOJu0YxvzNkOaeViZu3BU17wF1gwt2OEi9W45n2JCQORo1yev9JVs7TJ
	51qav2C9vmUxDnky1zhgyyyre+tcqkkodrlEBxjVjRgcr1P1/nwvAstBFoZe5de1fplA8kmt4R/
	A
X-Google-Smtp-Source: AGHT+IFuxivVAucFqLYqwANgIIbEmyPV0tNMGWLxqaH8776sBq/Go9KZec7LTwKbbmPafjRvAwUZ5w==
X-Received: by 2002:a17:903:22ca:b0:1e5:2ba9:a667 with SMTP id y10-20020a17090322ca00b001e52ba9a667mr4212130plg.3.1713570483020;
        Fri, 19 Apr 2024 16:48:03 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:48:02 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	samuel.holland@sifive.com,
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
Subject: [PATCH v8 10/24] RISC-V: KVM: Fix the initial sample period value
Date: Sat, 20 Apr 2024 08:17:26 -0700
Message-Id: <20240420151741.962500-11-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial sample period value when counter value is not assigned
should be set to maximum value supported by the counter width.
Otherwise, it may result in spurious interrupts.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 86391a5061dd..cee1b9ca4ec4 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -39,7 +39,7 @@ static u64 kvm_pmu_get_sample_period(struct kvm_pmc *pmc)
 	u64 sample_period;
 
 	if (!pmc->counter_val)
-		sample_period = counter_val_mask + 1;
+		sample_period = counter_val_mask;
 	else
 		sample_period = (-pmc->counter_val) & counter_val_mask;
 
-- 
2.34.1


