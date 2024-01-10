Return-Path: <linux-kernel+bounces-22886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8559382A4DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D598528AA03
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EAF56B75;
	Wed, 10 Jan 2024 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vI4rjziU"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43A256753
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bed9f0ea20so79869739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704928493; x=1705533293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8eq1Ys0e5NviyjpdbbjANOonZWXJ28I2i4yrtMskh0=;
        b=vI4rjziUsO94iwrs8LXUthW7VJ/8qfTIfo+u/DtxgNg19YbXfaK/k4/hunsoGSYvE2
         wVsZJvbRblltnQcnniAmDaari42C/jUYCXiaqtj+kkBDgEPTwUYkjs3w5IMovCQ74LNy
         JdP0HvdQwRGtPZhChczy4oHxJ9lRUG1P0g1TPztXwROtroGR/h0FI1djNwRHk6GiWWS5
         qKxBy5TCKUE/Cc/pXPi9kFCOgf+AJ1/xjya7vN6gmAl9c8SxN739yPpjqYwc/CVy6HPG
         Qlm1VatVNQPa/4TQobz550KdjL/KGxLJ2D/ySW1UTajFZ75NiJqqcG63ECOM7sdy6/bx
         D2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704928493; x=1705533293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8eq1Ys0e5NviyjpdbbjANOonZWXJ28I2i4yrtMskh0=;
        b=IIeJTy6F7hj/LGsV013zpxuN4s8J9xcxjbahzKA9fB5nsJ3BMvV/IxsGMODaT38OC8
         6wDmigH+9Hy8ODtNRUDgw3Si0BpMywiM/GlRjQz4UPJHMqwMKKe56Paq2+45UpQSznkX
         7Cku4A8HzTaDYHW0kIKu/TYoYyFIxGWPFSAjWl1NaaxUgXidCIRn8TAEnS+FjD1hruN5
         RmRW8DX366LBotU4qhrL5XNRu1aEW79hl61q4lKLIhnP8WvMxy5EGU7TY99e91FkZ5n5
         Zw9E1vJtChVZIrC5ePbayoCZ4r7jjV6it47jmsB53sRmskNPxdguxiV6/bCOt1scbqNl
         +sDg==
X-Gm-Message-State: AOJu0Yy9tCQ23RoDrDY+XUoAwvq3GLSs6a1+zEWtrxOFE/nttCE68lkD
	lZ+sXv8xWbJhAXfcbfcVgOG3kZu8aXM5nU1TbIZBJ01oZnU=
X-Google-Smtp-Source: AGHT+IE/I4mp9gKGXQVF4buLvs7fObnRnWv0jCa0fj5/bcDDswwtsk/Th12J1Chb2GQBfGKkmS6ZdA==
X-Received: by 2002:a05:6602:2c8b:b0:7bf:c4:1ffb with SMTP id i11-20020a0566022c8b00b007bf00c41ffbmr507836iow.17.1704928493059;
        Wed, 10 Jan 2024 15:14:53 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id co13-20020a0566383e0d00b0046e3b925818sm1185503jab.37.2024.01.10.15.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 15:14:52 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
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
	Will Deacon <will@kernel.org>,
	Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [v3 10/10] RISC-V: KVM: Support 64 bit firmware counters on RV32
Date: Wed, 10 Jan 2024 15:13:59 -0800
Message-Id: <20240110231359.1239367-11-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110231359.1239367-1-atishp@rivosinc.com>
References: <20240110231359.1239367-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI v2.0 introduced a fw_read_hi function to read 64 bit firmware
counters for RV32 based systems.

Add infrastructure to support that.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_pmu.h |  4 ++-
 arch/riscv/kvm/vcpu_pmu.c             | 37 ++++++++++++++++++++++++++-
 arch/riscv/kvm/vcpu_sbi_pmu.c         |  6 +++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
index 8cb21a4f862c..e0ad27dea46c 100644
--- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
+++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
@@ -20,7 +20,7 @@ static_assert(RISCV_KVM_MAX_COUNTERS <= 64);
 
 struct kvm_fw_event {
 	/* Current value of the event */
-	unsigned long value;
+	u64 value;
 
 	/* Event monitoring status */
 	bool started;
@@ -91,6 +91,8 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 				     struct kvm_vcpu_sbi_return *retdata);
 int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata);
+int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
+				      struct kvm_vcpu_sbi_return *retdata);
 void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_pmu_setup_snapshot(struct kvm_vcpu *vcpu, unsigned long saddr_low,
 				      unsigned long saddr_high, unsigned long flags,
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 063e11685340..31016934cd67 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -196,6 +196,29 @@ static int pmu_get_pmc_index(struct kvm_pmu *pmu, unsigned long eidx,
 	return kvm_pmu_get_programmable_pmc_index(pmu, eidx, cbase, cmask);
 }
 
+static int pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
+			      unsigned long *out_val)
+{
+	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
+	struct kvm_pmc *pmc;
+	int fevent_code;
+
+	if (!IS_ENABLED(CONFIG_32BIT))
+		return -EINVAL;
+
+	pmc = &kvpmu->pmc[cidx];
+
+	if (pmc->cinfo.type != SBI_PMU_CTR_TYPE_FW)
+		return -EINVAL;
+
+	fevent_code = get_event_code(pmc->event_idx);
+	pmc->counter_val = kvpmu->fw_event[fevent_code].value;
+
+	*out_val = pmc->counter_val >> 32;
+
+	return 0;
+}
+
 static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 			unsigned long *out_val)
 {
@@ -701,6 +724,18 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 	return 0;
 }
 
+int kvm_riscv_vcpu_pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
+				      struct kvm_vcpu_sbi_return *retdata)
+{
+	int ret;
+
+	ret = pmu_fw_ctr_read_hi(vcpu, cidx, &retdata->out_val);
+	if (ret == -EINVAL)
+		retdata->err_val = SBI_ERR_INVALID_PARAM;
+
+	return 0;
+}
+
 int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata)
 {
@@ -774,7 +809,7 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
 			pmc->cinfo.csr = CSR_CYCLE + i;
 		} else {
 			pmc->cinfo.type = SBI_PMU_CTR_TYPE_FW;
-			pmc->cinfo.width = BITS_PER_LONG - 1;
+			pmc->cinfo.width = 63;
 		}
 	}
 
diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
index 9f61136e4bb1..58a0e5587e2a 100644
--- a/arch/riscv/kvm/vcpu_sbi_pmu.c
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -64,6 +64,12 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	case SBI_EXT_PMU_COUNTER_FW_READ:
 		ret = kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata);
 		break;
+	case SBI_EXT_PMU_COUNTER_FW_READ_HI:
+		if (IS_ENABLED(CONFIG_32BIT))
+			ret = kvm_riscv_vcpu_pmu_fw_ctr_read_hi(vcpu, cp->a0, retdata);
+		else
+			retdata->out_val = 0;
+		break;
 	case SBI_EXT_PMU_SNAPSHOT_SET_SHMEM:
 		ret = kvm_riscv_vcpu_pmu_setup_snapshot(vcpu, cp->a0, cp->a1, cp->a2, retdata);
 		break;
-- 
2.34.1


