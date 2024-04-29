Return-Path: <linux-kernel+bounces-163098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D98B65A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFCB1F2244E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E93194C67;
	Mon, 29 Apr 2024 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kM1hUkor"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5152382D90
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429376; cv=none; b=UhpaSCUcXp1s+CweWEu1UWlS75LdLl43+h9TaQHjUnekhgQZBV7DP4YjBP4b0Wkm371GrObewqCUOjYCycA1mAmxvLtyGqBxZHID0n5/fFzGoTiEQ7Kz3UyRw90feUK7/E2EHbBaXZ5YprTQhMPBYnPIkUJaAAHSeX/DPIYXTOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429376; c=relaxed/simple;
	bh=L2B18ABmRVHRW/n8AqGM7CIeWfnEzcbvwRkkWrcy/Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIojJ206R/k2xOAPrwu45DHK2byGMpFoXSFXzVYos+zdquc/t7dGN0kWQ5MAE4K2T26gFQS8h5byKFh/4Din1Q9nMAx1fU/rRV59m9oJ5HrTqH1FVdVdaCy8w5Tvnk4gH76Uj+8Eq0XU8axAdtgCQYWK0lX8GxY8+YGs4FLFFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kM1hUkor; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso3505513b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714429373; x=1715034173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inf0s5yVmthP6npdhxNJMPqdoBPbadtRMotml3Pg8rs=;
        b=kM1hUkor4mrQDi/EXtYduxeHltx8eVi97jbQhejRpIsgilW0eCH67XXLMlnUM3Oco/
         JWizfJIZvFOmA+pAmpTze/JOjAvQj4pwy+P+YuL9A8tAVvAWB0YjxYzmDN4Upq7mnS7p
         BbbSB0mMSHdYPBE/inFmAN1cU/yDsYXramCvRNXOcjG64RepiTL+8WAVM6ss2n07jbDa
         Vc/kGYlzNFvlHLXMqNZqmNoIAlE5cAF18fZWIWCzG4DPgfVBdOLj94urLKJ5lK5NOmAG
         NL8BPMdtDI4eGVt/YkY40UpK72dNi8Escd9yBR7DpTWf0Lf25kZ9cR5eKDpWB2wCfEGf
         w8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714429373; x=1715034173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inf0s5yVmthP6npdhxNJMPqdoBPbadtRMotml3Pg8rs=;
        b=uJ1ZBbd5+I9uNjVaHz1HR3jRZgoCHQC9bBqSZOW2bJoVUiXOdu9v3tPkkYSD+K9xMC
         2th/km2TAXRNNQvxIeMQEhUi89HuB9lhFnbctC1ZUsjO9y7IQUfu22dK5Ck0p6u7akuh
         FrMmMQC0uu4gRyvgu7nGihXgtn64pAmvvSuR9nzwZ5RgcU+qiY/NbgTaS1p4I6KTau8C
         YNjZXIdbz/7ULWvs8qaw+KblOW3z4H3lsrEQp3gkg8AMrhAnhEhbRe+/afIxC+0npvIE
         76xY09R4PbqJGRsXhKlMfpgrXMwqDO6Bapkxk4zbWPIoGofcY9/48qlerAyZS/VBc8Fe
         9CZw==
X-Forwarded-Encrypted: i=1; AJvYcCWoEPuyNi6iAy2GLqHEM9iNxiWOCiG6F1j/EbFA2p2X/6GvTpiIKTerSCKwJQ4+u08FCK4aBzVad2A/zM/jMe1iDJDF/L8+b+i3A6HK
X-Gm-Message-State: AOJu0YxNj7ra9i9nTlr5x7hOBO480uLLrNYhAQSLT1yIU6pn/P3nza09
	G4nRTEqL4Bp539QCWw9PfM5lOYO6JNbHTwA0aEjvfsIG/TLD0ypxV+z6BS2lGvY=
X-Google-Smtp-Source: AGHT+IE50wiagQrblCMq5oU4MAdq+2X/FpoYODpwDG67URQDoEzfVMBuHk4sK2NMmD4RRCX06Avayw==
X-Received: by 2002:a05:6a20:f392:b0:1ad:6874:497d with SMTP id qr18-20020a056a20f39200b001ad6874497dmr1431554pzb.17.1714429373376;
        Mon, 29 Apr 2024 15:22:53 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:a4ca:d475:325f:33c1])
        by smtp.gmail.com with ESMTPSA id x26-20020a056a000bda00b006e6c16179dbsm19815696pfu.24.2024.04.29.15.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:22:52 -0700 (PDT)
Date: Mon, 29 Apr 2024 15:22:50 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: cpufeature: Fix thead vector hwcap removal
Message-ID: <ZjAduvtEZAjwoG+v@ghost>
References: <20240426-cpufeature_fixes-v2-0-7377442b1327@rivosinc.com>
 <20240426-cpufeature_fixes-v2-1-7377442b1327@rivosinc.com>
 <20240429-f6438977f19e44966d0dd879@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-f6438977f19e44966d0dd879@orel>

On Mon, Apr 29, 2024 at 11:33:50AM +0200, Andrew Jones wrote:
> On Fri, Apr 26, 2024 at 02:58:54PM GMT, Charlie Jenkins wrote:
> > The riscv_cpuinfo struct that contains mvendorid and marchid is not
> > populated until all harts are booted which happens after the DT parsing.
> > Use the vendorid/archid values from the DT if available or assume all
> > harts have the same values as the boot hart as a fallback.
> > 
> > Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT property on older T-Head CPUs")
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/sbi.h   |  2 ++
> >  arch/riscv/kernel/cpu.c        | 40 ++++++++++++++++++++++++++++++++++++----
> >  arch/riscv/kernel/cpufeature.c | 11 +++++++++--
> >  3 files changed, 47 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > index 6e68f8dff76b..0fab508a65b3 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -370,6 +370,8 @@ static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1
> >  static inline void sbi_init(void) {}
> >  #endif /* CONFIG_RISCV_SBI */
> >  
> > +unsigned long riscv_get_mvendorid(void);
> > +unsigned long riscv_get_marchid(void);
> >  unsigned long riscv_cached_mvendorid(unsigned int cpu_id);
> >  unsigned long riscv_cached_marchid(unsigned int cpu_id);
> >  unsigned long riscv_cached_mimpid(unsigned int cpu_id);
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index d11d6320fb0d..c1f3655238fd 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -139,6 +139,34 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
> >  	return -1;
> >  }
> >  
> > +unsigned long __init riscv_get_marchid(void)
> > +{
> > +	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
> > +
> > +#if IS_ENABLED(CONFIG_RISCV_SBI)
> > +	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> > +#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> > +	ci->marchid = csr_read(CSR_MARCHID);
> > +#else
> > +	ci->marchid = 0;
> > +#endif
> > +	return ci->marchid;
> > +}
> > +
> > +unsigned long __init riscv_get_mvendorid(void)
> > +{
> > +	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
> > +
> > +#if IS_ENABLED(CONFIG_RISCV_SBI)
> > +	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> > +#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> > +	ci->mvendorid = csr_read(CSR_MVENDORID);
> > +#else
> > +	ci->mvendorid = 0;
> > +#endif
> > +	return ci->mvendorid;
> > +}
> > +
> >  DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
> >  
> >  unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
> > @@ -170,12 +198,16 @@ static int riscv_cpuinfo_starting(unsigned int cpu)
> >  	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
> >  
> >  #if IS_ENABLED(CONFIG_RISCV_SBI)
> > -	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> > -	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> > +	if (!ci->mvendorid)
> > +		ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> > +	if (!ci->marchid)
> > +		ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> >  	ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
> >  #elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> > -	ci->mvendorid = csr_read(CSR_MVENDORID);
> > -	ci->marchid = csr_read(CSR_MARCHID);
> > +	if (!ci->mvendorid)
> > +		ci->mvendorid = csr_read(CSR_MVENDORID);
> > +	if (!ci->marchid)
> > +		ci->marchid = csr_read(CSR_MARCHID);
> >  	ci->mimpid = csr_read(CSR_MIMPID);
> >  #else
> >  	ci->mvendorid = 0;
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 3ed2359eae35..500a9bd70f51 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -490,6 +490,8 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
> >  	struct acpi_table_header *rhct;
> >  	acpi_status status;
> >  	unsigned int cpu;
> > +	u64 boot_vendorid;
> > +	u64 boot_archid;
> >  
> >  	if (!acpi_disabled) {
> >  		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> > @@ -497,6 +499,9 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
> >  			return;
> >  	}
> >  
> > +	boot_vendorid = riscv_get_mvendorid();
> > +	boot_archid = riscv_get_marchid();
> > +
> >  	for_each_possible_cpu(cpu) {
> >  		struct riscv_isainfo *isainfo = &hart_isa[cpu];
> >  		unsigned long this_hwcap = 0;
> > @@ -543,9 +548,11 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
> >  		 * version of the vector specification put "v" into their DTs.
> >  		 * CPU cores with the ratified spec will contain non-zero
> >  		 * marchid.
> > +		 *
> > +		 * Assume that if the boot hart is T-Head, then all harts in the
> > +		 * SoC are also T-Head and have the same archid.
> 
> The movement of the comment is only half of my suggestion. The other
> suggestion is to remove the 'Assume' because we don't have to assume
> anything. We can simply state that if the boot hart is T-HEAD, then we
> don't want to enable V on any hart. (We don't need to assume the other
> hart IDs are the same, because we don't care what they are. They're
> not going to get V, no matter what.)

In the case that you mentioned, that the boot hart incorrectly reports
xtheadvector as V but a different hart has "true" V, V will be disabled
and all is well.

This comment was more out of paranoia for the inverse case though. It is
possible that the boot hart has a correctly reported V, but a different
hart actually has xtheadvector. Since we only probed the boot hart, we
don't know that though, and try to execute standard V instructions on
the secondary hart and run into illegal exceptions.

I can change the wording to:

"Disable vector if the boot hart has a T-Head mvendorid and an marchid
of 0."

I hope some vendor doesn't make an SoC like the problem case ;).

- Charlie

> 
> Thanks,
> drew
> 
> >  		 */
> > -		if (acpi_disabled && riscv_cached_mvendorid(cpu) == THEAD_VENDOR_ID &&
> > -		    riscv_cached_marchid(cpu) == 0x0) {
> > +		if (acpi_disabled && boot_vendorid == THEAD_VENDOR_ID && boot_archid == 0x0) {
> >  			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
> >  			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
> >  		}
> > 
> > -- 
> > 2.44.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

