Return-Path: <linux-kernel+bounces-147412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B48F8A73A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB991F21688
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68197137929;
	Tue, 16 Apr 2024 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="g0ku7YIM"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E713C69C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293103; cv=none; b=axds6T99Qi4bhxK5MUxov4PdmaK7JvEIqp7BmWlBFQnlREXpkOfrqaJVydkgAhEv/gGsvaCat5I3N0Bb4wTIsuitw0wIfJ0lr3NNOB0ZgYvZpQ3/nqd9zERlNYKF9X3Oh4t2q3zl3SEmsRcCH6d9rA0czzr6hxHdsippuL+Y1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293103; c=relaxed/simple;
	bh=gdMzDVnYrwaM9h9kAamPNyWkXYUbTPvF3ijmWyDgOL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qAZ1FerN5Xwx3gpy3+2dhoobhLuvB72lFWifm0PuvYxRcsZC7ONN9oHq7EHQeR10+H/sId+HYiD3DdWhpklT0UL1H2GRL+hV5w/VkWGrVQ89XXf+fKqvIRxQqHTTSPXrnlVND5hkl9UhdYrhT+damgIVXjLfONv5LRnibgDD3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=g0ku7YIM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a2f82ded89so3122491a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293100; x=1713897900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCg3lAsZkQVOh5B2ILSrB/8DeGz9btDFvL9AbiLXqZE=;
        b=g0ku7YIMbwqKeaTI4daaQpJbUCGVW9aQ4+h8y1PsP2IEx9yGkQpxJiQIVrik0axVFN
         qh4TonK2iu3k2B1nhZEu3D+BRkkZkxdBWFJMQ5LWF8QWQvLdxpzXmnT1ib0+CQuyDyfl
         E533M5AKG2P1blq7Smu2PwZERB61VRaVExOXg0lywLpoNRmaNuGjIzmt1wWNfhQZaNxz
         JXOJpXsIToRQ6A1AWK6Y4UGC+T3NL/RJqjjCqMjnnBcpyzh2BIdIAzGwxAH8PtJqK/99
         OsjkCJQGk3nAWvwtEr9Uz+ApVnpf4DVsJP+iKroKJ8bnTwtdIwRUeY+SPcLpNzrm21c7
         agWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293100; x=1713897900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCg3lAsZkQVOh5B2ILSrB/8DeGz9btDFvL9AbiLXqZE=;
        b=dvpyboNkXNrdEtPOc6KaAaEFCGF62jGkfPT/MZYFYadGAHCOW4K5qZ8GMQJKqU9aj3
         6/YxP18HX8zpWPNHlGeGaX7Sx9iN2aHbffg0Sc9qy8ZPd/oEULSHJJnTEaDzSRULfQJc
         qKk5VA+ckMXKuykmP62ezPJ4/5OWNzb6c8CofKPHuf8SOnPCuwS9e92McmaU5cSH4qL8
         AFqBxbMi6aMfv5Ln+At+IbW5XaDl81FPSBAbnLzwWLFpqvzPNp82rLBsppTwkZKYaLyL
         U6SBdITLak/887013x2HDt3zjiRbKWsZsTfYbPoKqCHBbYaOPTT7Ysia83tfkFLLPARN
         0aFA==
X-Gm-Message-State: AOJu0YwetFAdi9EJ+Mh0p6bIVm2HlUAQPE5VYoXZj0p2nTFdjwtpwsy5
	IGLWpEaGr7zNHpiDmdqe2eMW82CrSqAg57kkmKsJOohOEVitrTyzboG0dIuAv8g2+MN2VWjTKP2
	B
X-Google-Smtp-Source: AGHT+IGGDa4Z1hfn4pU8gmLSLALnZSz2t15YOCI8Vy0MXxBh/Lt6xUpR1MMNJqGKq5tQYGB3jRB37w==
X-Received: by 2002:a17:90a:af83:b0:2a2:adfc:6203 with SMTP id w3-20020a17090aaf8300b002a2adfc6203mr13592378pjq.8.1713293099888;
        Tue, 16 Apr 2024 11:44:59 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:59 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
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
Subject: [PATCH v7 13/24] RISC-V: KVM: Implement SBI PMU Snapshot feature
Date: Tue, 16 Apr 2024 11:44:10 -0700
Message-Id: <20240416184421.3693802-14-atishp@rivosinc.com>
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

PMU Snapshot function allows to minimize the number of traps when the
guest access configures/access the hpmcounters. If the snapshot feature
is enabled, the hypervisor updates the shared memory with counter
data and state of overflown counters. The guest can just read the
shared memory instead of trap & emulate done by the hypervisor.

This patch doesn't implement the counter overflow yet.

Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_pmu.h |   7 ++
 arch/riscv/kvm/vcpu_pmu.c             | 121 +++++++++++++++++++++++++-
 arch/riscv/kvm/vcpu_sbi_pmu.c         |   3 +
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
index 395518a1664e..77a1fc4d203d 100644
--- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
+++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
@@ -50,6 +50,10 @@ struct kvm_pmu {
 	bool init_done;
 	/* Bit map of all the virtual counter used */
 	DECLARE_BITMAP(pmc_in_use, RISCV_KVM_MAX_COUNTERS);
+	/* The address of the counter snapshot area (guest physical address) */
+	gpa_t snapshot_addr;
+	/* The actual data of the snapshot */
+	struct riscv_pmu_snapshot_data *sdata;
 };
 
 #define vcpu_to_pmu(vcpu) (&(vcpu)->arch.pmu_context)
@@ -85,6 +89,9 @@ int kvm_riscv_vcpu_pmu_ctr_cfg_match(struct kvm_vcpu *vcpu, unsigned long ctr_ba
 int kvm_riscv_vcpu_pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 				struct kvm_vcpu_sbi_return *retdata);
 void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu);
+int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long saddr_low,
+				      unsigned long saddr_high, unsigned long flags,
+				      struct kvm_vcpu_sbi_return *retdata);
 void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu);
 
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 2d9929bbc2c8..2ebccd73680f 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -14,6 +14,7 @@
 #include <asm/csr.h>
 #include <asm/kvm_vcpu_sbi.h>
 #include <asm/kvm_vcpu_pmu.h>
+#include <asm/sbi.h>
 #include <linux/bitops.h>
 
 #define kvm_pmu_num_counters(pmu) ((pmu)->num_hw_ctrs + (pmu)->num_fw_ctrs)
@@ -311,6 +312,80 @@ int kvm_riscv_vcpu_pmu_read_hpm(struct kvm_vcpu *vcpu, unsigned int csr_num,
 	return ret;
 }
 
+static void kvm_pmu_clear_snapshot_area(struct kvm_vcpu *vcpu)
+{
+	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
+	int snapshot_area_size = sizeof(struct riscv_pmu_snapshot_data);
+
+	if (kvpmu->sdata) {
+		if (kvpmu->snapshot_addr != INVALID_GPA) {
+			memset(kvpmu->sdata, 0, snapshot_area_size);
+			kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr,
+					     kvpmu->sdata, snapshot_area_size);
+		} else {
+			pr_warn("snapshot address invalid\n");
+		}
+		kfree(kvpmu->sdata);
+		kvpmu->sdata = NULL;
+	}
+	kvpmu->snapshot_addr = INVALID_GPA;
+}
+
+int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long saddr_low,
+				      unsigned long saddr_high, unsigned long flags,
+				      struct kvm_vcpu_sbi_return *retdata)
+{
+	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
+	int snapshot_area_size = sizeof(struct riscv_pmu_snapshot_data);
+	int sbiret = 0;
+	gpa_t saddr;
+	unsigned long hva;
+	bool writable;
+
+	if (!kvpmu || flags) {
+		sbiret = SBI_ERR_INVALID_PARAM;
+		goto out;
+	}
+
+	if (saddr_low == SBI_SHMEM_DISABLE && saddr_high == SBI_SHMEM_DISABLE) {
+		kvm_pmu_clear_snapshot_area(vcpu);
+		return 0;
+	}
+
+	saddr = saddr_low;
+
+	if (saddr_high != 0) {
+		if (IS_ENABLED(CONFIG_32BIT))
+			saddr |= ((gpa_t)saddr_high << 32);
+		else
+			sbiret = SBI_ERR_INVALID_ADDRESS;
+		goto out;
+	}
+
+	hva = kvm_vcpu_gfn_to_hva_prot(vcpu, saddr >> PAGE_SHIFT, &writable);
+	if (kvm_is_error_hva(hva) || !writable) {
+		sbiret = SBI_ERR_INVALID_ADDRESS;
+		goto out;
+	}
+
+	kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC);
+	if (!kvpmu->sdata)
+		return -ENOMEM;
+
+	if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area_size)) {
+		kfree(kvpmu->sdata);
+		sbiret = SBI_ERR_FAILURE;
+		goto out;
+	}
+
+	kvpmu->snapshot_addr = saddr;
+
+out:
+	retdata->err_val = sbiret;
+
+	return 0;
+}
+
 int kvm_riscv_vcpu_pmu_num_ctrs(struct kvm_vcpu *vcpu,
 				struct kvm_vcpu_sbi_return *retdata)
 {
@@ -344,20 +419,38 @@ int kvm_riscv_vcpu_pmu_ctr_start(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 	int i, pmc_index, sbiret = 0;
 	struct kvm_pmc *pmc;
 	int fevent_code;
+	bool snap_flag_set = flags & SBI_PMU_START_FLAG_INIT_SNAPSHOT;
 
 	if (kvm_pmu_validate_counter_mask(kvpmu, ctr_base, ctr_mask) < 0) {
 		sbiret = SBI_ERR_INVALID_PARAM;
 		goto out;
 	}
 
+	if (snap_flag_set) {
+		if (kvpmu->snapshot_addr == INVALID_GPA) {
+			sbiret = SBI_ERR_NO_SHMEM;
+			goto out;
+		}
+		if (kvm_vcpu_read_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
+					sizeof(struct riscv_pmu_snapshot_data))) {
+			pr_warn("Unable to read snapshot shared memory while starting counters\n");
+			sbiret = SBI_ERR_FAILURE;
+			goto out;
+		}
+	}
 	/* Start the counters that have been configured and requested by the guest */
 	for_each_set_bit(i, &ctr_mask, RISCV_MAX_COUNTERS) {
 		pmc_index = i + ctr_base;
 		if (!test_bit(pmc_index, kvpmu->pmc_in_use))
 			continue;
 		pmc = &kvpmu->pmc[pmc_index];
-		if (flags & SBI_PMU_START_FLAG_SET_INIT_VALUE)
+		if (flags & SBI_PMU_START_FLAG_SET_INIT_VALUE) {
 			pmc->counter_val = ival;
+		} else if (snap_flag_set) {
+			/* The counter index in the snapshot are relative to the counter base */
+			pmc->counter_val = kvpmu->sdata->ctr_values[i];
+		}
+
 		if (pmc->cinfo.type == SBI_PMU_CTR_TYPE_FW) {
 			fevent_code = get_event_code(pmc->event_idx);
 			if (fevent_code >= SBI_PMU_FW_MAX) {
@@ -398,14 +491,22 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 {
 	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
 	int i, pmc_index, sbiret = 0;
+	u64 enabled, running;
 	struct kvm_pmc *pmc;
 	int fevent_code;
+	bool snap_flag_set = flags & SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
+	bool shmem_needs_update = false;
 
 	if (kvm_pmu_validate_counter_mask(kvpmu, ctr_base, ctr_mask) < 0) {
 		sbiret = SBI_ERR_INVALID_PARAM;
 		goto out;
 	}
 
+	if (snap_flag_set && kvpmu->snapshot_addr == INVALID_GPA) {
+		sbiret = SBI_ERR_NO_SHMEM;
+		goto out;
+	}
+
 	/* Stop the counters that have been configured and requested by the guest */
 	for_each_set_bit(i, &ctr_mask, RISCV_MAX_COUNTERS) {
 		pmc_index = i + ctr_base;
@@ -438,12 +539,28 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 		} else {
 			sbiret = SBI_ERR_INVALID_PARAM;
 		}
+
+		if (snap_flag_set && !sbiret) {
+			if (pmc->cinfo.type == SBI_PMU_CTR_TYPE_FW)
+				pmc->counter_val = kvpmu->fw_event[fevent_code].value;
+			else if (pmc->perf_event)
+				pmc->counter_val += perf_event_read_value(pmc->perf_event,
+									  &enabled, &running);
+			/* TODO: Add counter overflow support when sscofpmf support is added */
+			kvpmu->sdata->ctr_values[i] = pmc->counter_val;
+			shmem_needs_update = true;
+		}
+
 		if (flags & SBI_PMU_STOP_FLAG_RESET) {
 			pmc->event_idx = SBI_PMU_EVENT_IDX_INVALID;
 			clear_bit(pmc_index, kvpmu->pmc_in_use);
 		}
 	}
 
+	if (shmem_needs_update)
+		kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
+					     sizeof(struct riscv_pmu_snapshot_data));
+
 out:
 	retdata->err_val = sbiret;
 
@@ -566,6 +683,7 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
 	kvpmu->num_hw_ctrs = num_hw_ctrs + 1;
 	kvpmu->num_fw_ctrs = SBI_PMU_FW_MAX;
 	memset(&kvpmu->fw_event, 0, SBI_PMU_FW_MAX * sizeof(struct kvm_fw_event));
+	kvpmu->snapshot_addr = INVALID_GPA;
 
 	if (kvpmu->num_hw_ctrs > RISCV_KVM_MAX_HW_CTRS) {
 		pr_warn_once("Limiting the hardware counters to 32 as specified by the ISA");
@@ -625,6 +743,7 @@ void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu)
 	}
 	bitmap_zero(kvpmu->pmc_in_use, RISCV_MAX_COUNTERS);
 	memset(&kvpmu->fw_event, 0, SBI_PMU_FW_MAX * sizeof(struct kvm_fw_event));
+	kvm_pmu_clear_snapshot_area(vcpu);
 }
 
 void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu)
diff --git a/arch/riscv/kvm/vcpu_sbi_pmu.c b/arch/riscv/kvm/vcpu_sbi_pmu.c
index e1633606c98b..d3e7625fb2d2 100644
--- a/arch/riscv/kvm/vcpu_sbi_pmu.c
+++ b/arch/riscv/kvm/vcpu_sbi_pmu.c
@@ -64,6 +64,9 @@ static int kvm_sbi_ext_pmu_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	case SBI_EXT_PMU_COUNTER_FW_READ:
 		ret = kvm_riscv_vcpu_pmu_ctr_read(vcpu, cp->a0, retdata);
 		break;
+	case SBI_EXT_PMU_SNAPSHOT_SET_SHMEM:
+		ret = kvm_riscv_vcpu_pmu_snapshot_set_shmem(vcpu, cp->a0, cp->a1, cp->a2, retdata);
+		break;
 	default:
 		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
 	}
-- 
2.34.1


