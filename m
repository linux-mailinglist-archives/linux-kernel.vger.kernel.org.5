Return-Path: <linux-kernel+bounces-10458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE0A81D4A0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91F7B219B4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A0FD52F;
	Sat, 23 Dec 2023 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFwnIk5J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616EB81F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a233bf14cafso329933066b.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 06:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703342047; x=1703946847; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fk7uNoBSFRaFqjHE5lH7d8qA+IRnTtQdN7sSbWssLaQ=;
        b=kFwnIk5JuNfl/QZmgWMWhsH46C0qpP+e4e0yigmfUZrkIG+vrnykWTHg7ADL/bn0Wp
         1emXBZtehgnWidp8JlGlnqcPWZelIYlnpicn9OCOjnPx0gZJhNoeB/xYT/hSAahMUevs
         TbysmWdnIIx3NYEMKFoLcJu2oj26mYkxae9gyWD7AjCGyumuyG+lIQploJmLsVsHc+/j
         KDH4A/LJqY3d7PFvEwSNpldC32tEVTMRATVXZONTwwhgfVBzdhXeHj53sa7xq07WDsWr
         htlNByW1VkWTCyA1unhU5nT8TGZssTP+MX8OBHFrF3ucYBd2BGyV6RPX+aQlTfdNb9Kn
         zCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703342047; x=1703946847;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fk7uNoBSFRaFqjHE5lH7d8qA+IRnTtQdN7sSbWssLaQ=;
        b=efh9ggM1HceeUowe/0hUKw4/Jf9DnNS+YJC/gjLnvYFCrjmQ7GwyLpeKFuO5WBpiOZ
         hmia6rIZcx5XOmMc+NX9zkgXYnS7NwXtQFW2MoXC9Uzhb1aG72eGdWd1dq4nd3SCVkpX
         8/hn1KnItjhIinUqtOrO/qPlucUuFySATnpBWjPtVRNtFJYGjWlP3XG707/HQOQNBOD5
         /2NhfKB714VN/fbfxflj8s6hjOwtt8VNB0bPUexweXzAYIHrkCewfP05r+TnPO0PiQj0
         lweKmLdVAyjeMp4DRVWsaiHifNPJwX5sZ6s/lYPHEK0O2mBvmLGTU0brXy97yejSvah+
         Ju6g==
X-Gm-Message-State: AOJu0YyIqyds0kr/HW4VpfLQoJh34tqvtLTsTrh62dvMVSjkzdy7E0Fc
	nMvc1rYFRB+4gvI2Ct3N6P4=
X-Google-Smtp-Source: AGHT+IGKRVrD1Dz5+oUUWuUhtOYpSdJTCPfx4mNWD2iGrjlhhgvEcDpJyP7AhaRMnHST6+2EG+JOkQ==
X-Received: by 2002:a17:907:208f:b0:a23:4fed:ecc2 with SMTP id pv15-20020a170907208f00b00a234fedecc2mr1492506ejb.146.1703342047277;
        Sat, 23 Dec 2023 06:34:07 -0800 (PST)
Received: from gmail.com (1F2EF32E.nat.pool.telekom.hu. [31.46.243.46])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090648cd00b00a2350a75dc0sm3134083ejt.207.2023.12.23.06.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 06:34:06 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 23 Dec 2023 15:34:04 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZYbv3GXLNLuc+rka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-12-23

   # HEAD: d5a10b976ecb77fa49b95f3f1016ca2997c122cb x86/acpi: Handle bogus MADT APIC tables gracefully

Misc fixes:

 - Fix a secondary CPUs enumeration regression caused by creative
   MADT APIC table entries on certain systems.

 - Fix a race in the NOP-patcher that can spuriously trigger crashes
   on bootup.

 - Fix a bootup failure regression caused by the parallel bringup
   code, caused by firmware inconsistency between the APIC
   initialization states of the boot and secondary CPUs, on certain
   systems.

 Thanks,

	Ingo

------------------>
Thomas Gleixner (4):
      x86/smpboot/64: Handle X2APIC BIOS inconsistency gracefully
      x86/alternatives: Sync core before enabling interrupts
      x86/alternatives: Disable interrupts and sync when optimizing NOPs in place
      x86/acpi: Handle bogus MADT APIC tables gracefully


 arch/x86/kernel/acpi/boot.c   |  2 +-
 arch/x86/kernel/alternative.c | 14 ++++++++++++--
 arch/x86/kernel/head_64.S     | 16 ++++++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 1a0dd80d81ac..85a3ce2a3666 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -293,6 +293,7 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
 			    processor->processor_id, /* ACPI ID */
 			    processor->lapic_flags & ACPI_MADT_ENABLED);
 
+	has_lapic_cpus = true;
 	return 0;
 }
 
@@ -1134,7 +1135,6 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	if (!count) {
 		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
 					acpi_parse_lapic, MAX_LOCAL_APIC);
-		has_lapic_cpus = count > 0;
 		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
 					acpi_parse_x2apic, MAX_LOCAL_APIC);
 	}
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 73be3931e4f0..aae7456ece07 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -255,6 +255,16 @@ static void __init_or_module noinline optimize_nops(u8 *instr, size_t len)
 	}
 }
 
+static void __init_or_module noinline optimize_nops_inplace(u8 *instr, size_t len)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	optimize_nops(instr, len);
+	sync_core();
+	local_irq_restore(flags);
+}
+
 /*
  * In this context, "source" is where the instructions are placed in the
  * section .altinstr_replacement, for example during kernel build by the
@@ -438,7 +448,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		 *   patch if feature is *NOT* present.
 		 */
 		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
-			optimize_nops(instr, a->instrlen);
+			optimize_nops_inplace(instr, a->instrlen);
 			continue;
 		}
 
@@ -1685,8 +1695,8 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 	} else {
 		local_irq_save(flags);
 		memcpy(addr, opcode, len);
-		local_irq_restore(flags);
 		sync_core();
+		local_irq_restore(flags);
 
 		/*
 		 * Could also do a CLFLUSH here to speed up CPU recovery; but
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 086a2c3aaaa0..0f8103240fda 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -255,6 +255,22 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	testl	$X2APIC_ENABLE, %eax
 	jnz	.Lread_apicid_msr
 
+#ifdef CONFIG_X86_X2APIC
+	/*
+	 * If system is in X2APIC mode then MMIO base might not be
+	 * mapped causing the MMIO read below to fault. Faults can't
+	 * be handled at that point.
+	 */
+	cmpl	$0, x2apic_mode(%rip)
+	jz	.Lread_apicid_mmio
+
+	/* Force the AP into X2APIC mode. */
+	orl	$X2APIC_ENABLE, %eax
+	wrmsr
+	jmp	.Lread_apicid_msr
+#endif
+
+.Lread_apicid_mmio:
 	/* Read the APIC ID from the fix-mapped MMIO space. */
 	movq	apic_mmio_base(%rip), %rcx
 	addq	$APIC_ID, %rcx

