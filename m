Return-Path: <linux-kernel+bounces-3354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1467816B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8488AB21E35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC6A1C68F;
	Mon, 18 Dec 2023 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PDb/c4Gd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98215EB6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-58d18c224c7so1848772eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702896087; x=1703500887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fyVFitalYEi2ik2oU3cHAgTTSiVjR9gn+8uYrWaU68=;
        b=PDb/c4Gd8xFFFxVvLZ4N8ORjQ3ScVUvzzWGDOVyyxdQ1iDLv8ESKIc/gidhUgzXfMV
         Fg6ObH0MowANm81k0eR4Ge4GybQ2IDxovHSKKRc+G+ynH1VcSqWeGfrWnAbg2WKV7YfB
         CV6Z3YFH4LcYZv429Um6uJhNVo9pyLxxEt6pE1FPYQaKyPtWTXhdWUX7kl9GD5rcz//h
         xtSc1X3CNbMAmgPzmz50cHPHA7/+89Ps8R4y1+m6XtBezawFNqKLDARGV0vUhMKwTkqM
         UxzLpYjIrNy8ZzaVuL0Wp0qUPwQoZPCn3Z6cVL+mXer+YHVeBOu8el1ULGNn+RTQkx2U
         T9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702896087; x=1703500887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fyVFitalYEi2ik2oU3cHAgTTSiVjR9gn+8uYrWaU68=;
        b=pkxKmjyHYUZ2MpkZowo8YLBLM0XALjJ6TFUcV8UrIvesXWIOv5aOWAKq7GfookwNdu
         6DYvHjIa4ePQhnfUlwwKxnPMuWDRfYE2FqtWblKSK2v+QhilRCPGiqykw+ZsE5QMMKeV
         68FpmzQ8vxrfsnWvCI82f8THUj+gHuIywYgXzL2o/cJCKmPvtBfyeox5l9WP9xR+PSMt
         CXIfDx4pHxnHHXyU/uH5K6h7xEr8OY96vhVZBK9A4Ej8OHu2V/3uQ2abV3JazlXzWfFO
         GOw0jnnhuXXgFyIVdhEhdBehJ+2mzOuDpvuKTdwIWipzm7soz+6qAbxrHOAQmB5sKpHw
         QURA==
X-Gm-Message-State: AOJu0YxFhw4oLZyXZAw27/EpevQgiQxAOHgSuFW+a67HrtYJiVAv6lta
	UOVwixplFhaROFzIzhsOK4bbrXIJDfK+jUr4rxs=
X-Google-Smtp-Source: AGHT+IGFy5f2J+i4IqKYXFotpQOE6tOEetsGoq9vmp9+rVSODcTXCU6RbekVJWZp93Yuhj/YvC0jyA==
X-Received: by 2002:a4a:ab43:0:b0:591:cb4f:a672 with SMTP id j3-20020a4aab43000000b00591cb4fa672mr843619oon.9.1702896086847;
        Mon, 18 Dec 2023 02:41:26 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 185-20020a4a1ac2000000b005907ad9f302sm574970oof.37.2023.12.18.02.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:41:26 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Icenowy Zheng <uwu@icenowy.me>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Will Deacon <will@kernel.org>
Subject: [v1 06/10] RISC-V: KVM: No need to update the counter value during reset
Date: Mon, 18 Dec 2023 02:41:03 -0800
Message-Id: <20231218104107.2976925-7-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218104107.2976925-1-atishp@rivosinc.com>
References: <20231218104107.2976925-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtual counter value is updated during pmu_ctr_read. There is no need
to update it in reset case. Otherwise, it will be counted twice which is
incorrect.

Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 86391a5061dd..8c44f26e754d 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -432,12 +432,9 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 				sbiret = SBI_ERR_ALREADY_STOPPED;
 			}
 
-			if (flags & SBI_PMU_STOP_FLAG_RESET) {
-				/* Relase the counter if this is a reset request */
-				pmc->counter_val += perf_event_read_value(pmc->perf_event,
-									  &enabled, &running);
+			if (flags & SBI_PMU_STOP_FLAG_RESET)
+				/* Release the counter if this is a reset request */
 				kvm_pmu_release_perf_event(pmc);
-			}
 		} else {
 			sbiret = SBI_ERR_INVALID_PARAM;
 		}
-- 
2.34.1


