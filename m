Return-Path: <linux-kernel+bounces-161993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E34F8B544D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 759B9B21481
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3342E23770;
	Mon, 29 Apr 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mm/qCV//"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726614A8C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714383235; cv=none; b=VQzVLvO9xrsBrcMDp3eaPF+wxpTlxBEc4ZEXRaA6Pz2ld6+x+AnTmBVmZ+kLQ90n316UY0j5Jx7Z9UEEXXLO3rq1c7R2wxZuPA05KOvjB5K+ixB6OfwUqSmYQaVQMSdGc/vjflWCq7Qm8SeHCjlK3fuYQb3RlPla9qcBItuTeyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714383235; c=relaxed/simple;
	bh=amrymcDQCXPE5yRwTJ9bogpBgJMIQ6mc2UUPWFjMYEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgpEsDkoagHp/lpTfLXzVLyjkhSnZ2hbpI2ujPUeO0mEErNsj2PpW+5qgApxyIXvOc/OorN1ZsV4zLXi3dhoN6rwoBqrvSTUXfwIE3uSQHa2HK90JPOOHM4el4mWRXLC6LazHEAv2rsOdaxhFqngui4f9HXIrovi+VaMiEi0qVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=mm/qCV//; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a58d0aea14cso342114766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 02:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714383232; x=1714988032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EU5DwD+o4qYG2LMifv0uxvcF3WJYCYks9+vxzfiwTyo=;
        b=mm/qCV//X6HaL3F3qHsIWnUs/z8FKVXOviZQvvgF+/D0XG7Kr7nN8XTPB7H6cb2aGe
         3Y1Nt62BZyeJm+xCe5MIcsaWZbcsKlsl8qD6uoKwYsciN2gr4mRDq1EOZeDu03MAERHr
         0ytUJxjcab6ocn6zosPSizyUemiUNg/xjtxUo+4I9nbUVjpLEZZE/VPvyYs/Xag4n/g+
         mYn23Rzof0jlTgzNdNk+Xcp24smsMIRuZNVUJil3iTHEokcot+qCsH5qGyfrHPva6jKH
         JfvDby7j4jnhKGWXokejnGZQiIiKRgn1wkKpZRxgnQLWqwTCgNZYm906rmHoiAZqM9dr
         uNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714383232; x=1714988032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EU5DwD+o4qYG2LMifv0uxvcF3WJYCYks9+vxzfiwTyo=;
        b=PyZeuvv8Ij8HconBmfL8st4KrhhWgpeKpHHvHiJCjWdgI4zDHCwGMpNZIvbwXJLYUE
         4QWIKTLw/HMS8u5MQ7WPthho1LBgRemYql+WD5DT6HcLBfCpxYyRv+WTj+18CLglWatw
         YIkwAlTcbmvN9aChhWcEKbRer3lMgr3Th0sPGyzHWw3DJAP0ma1Zl71F74Jmgy+kzneM
         CWW7VFgnbBcNCYVjcdTbz/mPLVkpFXLInlJ3GjCsmUSIfDWE5jAA/aeXB5Qt/dkRJq47
         gddUArwD/1TMtfuPM/KQ9AUJqbL1o6w3kWeGnHfT6KenRHRjmqmB1qHz4fLeXNIKY4Ff
         QN8A==
X-Forwarded-Encrypted: i=1; AJvYcCXGDQQafOy5np29HuWFhOkFSUTfNOjvfpjMQiED4EBNXqvQZpS3/yJX0c8glXVwQKc8DDUxJfzqs9dWjooU0lgcB96dg3Fk0ohZUAjl
X-Gm-Message-State: AOJu0Yzw/IFPCSzZZboacIYP7xgPT8+wRov/CbSX+GszVZ7VDM4aVMGu
	4spb/aD8/5WNE/0G4oMbF9WoO8SZ1eMstgbNzIsPytMQytMJIih4VLy2aGHHxSo=
X-Google-Smtp-Source: AGHT+IERuDfoXTZsVEZYtHEP0m8zcYtgaeZ/2E5V9D4Cg4n2UY/ovyyJ51522Jpbw2aKwxKXDxdzFg==
X-Received: by 2002:a17:906:57c4:b0:a58:e969:1472 with SMTP id u4-20020a17090657c400b00a58e9691472mr3749136ejr.40.1714383231850;
        Mon, 29 Apr 2024 02:33:51 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id bi10-20020a170906a24a00b00a54c12de34dsm13629698ejb.188.2024.04.29.02.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 02:33:51 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:33:50 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Evan Green <evan@rivosinc.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: cpufeature: Fix thead vector hwcap removal
Message-ID: <20240429-f6438977f19e44966d0dd879@orel>
References: <20240426-cpufeature_fixes-v2-0-7377442b1327@rivosinc.com>
 <20240426-cpufeature_fixes-v2-1-7377442b1327@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426-cpufeature_fixes-v2-1-7377442b1327@rivosinc.com>

On Fri, Apr 26, 2024 at 02:58:54PM GMT, Charlie Jenkins wrote:
> The riscv_cpuinfo struct that contains mvendorid and marchid is not
> populated until all harts are booted which happens after the DT parsing.
> Use the vendorid/archid values from the DT if available or assume all
> harts have the same values as the boot hart as a fallback.
> 
> Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT property on older T-Head CPUs")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/sbi.h   |  2 ++
>  arch/riscv/kernel/cpu.c        | 40 ++++++++++++++++++++++++++++++++++++----
>  arch/riscv/kernel/cpufeature.c | 11 +++++++++--
>  3 files changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 6e68f8dff76b..0fab508a65b3 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -370,6 +370,8 @@ static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1
>  static inline void sbi_init(void) {}
>  #endif /* CONFIG_RISCV_SBI */
>  
> +unsigned long riscv_get_mvendorid(void);
> +unsigned long riscv_get_marchid(void);
>  unsigned long riscv_cached_mvendorid(unsigned int cpu_id);
>  unsigned long riscv_cached_marchid(unsigned int cpu_id);
>  unsigned long riscv_cached_mimpid(unsigned int cpu_id);
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index d11d6320fb0d..c1f3655238fd 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -139,6 +139,34 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
>  	return -1;
>  }
>  
> +unsigned long __init riscv_get_marchid(void)
> +{
> +	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
> +
> +#if IS_ENABLED(CONFIG_RISCV_SBI)
> +	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> +#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> +	ci->marchid = csr_read(CSR_MARCHID);
> +#else
> +	ci->marchid = 0;
> +#endif
> +	return ci->marchid;
> +}
> +
> +unsigned long __init riscv_get_mvendorid(void)
> +{
> +	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
> +
> +#if IS_ENABLED(CONFIG_RISCV_SBI)
> +	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> +#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> +	ci->mvendorid = csr_read(CSR_MVENDORID);
> +#else
> +	ci->mvendorid = 0;
> +#endif
> +	return ci->mvendorid;
> +}
> +
>  DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
>  
>  unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
> @@ -170,12 +198,16 @@ static int riscv_cpuinfo_starting(unsigned int cpu)
>  	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
>  
>  #if IS_ENABLED(CONFIG_RISCV_SBI)
> -	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> -	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> +	if (!ci->mvendorid)
> +		ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> +	if (!ci->marchid)
> +		ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
>  	ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
>  #elif IS_ENABLED(CONFIG_RISCV_M_MODE)
> -	ci->mvendorid = csr_read(CSR_MVENDORID);
> -	ci->marchid = csr_read(CSR_MARCHID);
> +	if (!ci->mvendorid)
> +		ci->mvendorid = csr_read(CSR_MVENDORID);
> +	if (!ci->marchid)
> +		ci->marchid = csr_read(CSR_MARCHID);
>  	ci->mimpid = csr_read(CSR_MIMPID);
>  #else
>  	ci->mvendorid = 0;
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 3ed2359eae35..500a9bd70f51 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -490,6 +490,8 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
>  	struct acpi_table_header *rhct;
>  	acpi_status status;
>  	unsigned int cpu;
> +	u64 boot_vendorid;
> +	u64 boot_archid;
>  
>  	if (!acpi_disabled) {
>  		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> @@ -497,6 +499,9 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
>  			return;
>  	}
>  
> +	boot_vendorid = riscv_get_mvendorid();
> +	boot_archid = riscv_get_marchid();
> +
>  	for_each_possible_cpu(cpu) {
>  		struct riscv_isainfo *isainfo = &hart_isa[cpu];
>  		unsigned long this_hwcap = 0;
> @@ -543,9 +548,11 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
>  		 * version of the vector specification put "v" into their DTs.
>  		 * CPU cores with the ratified spec will contain non-zero
>  		 * marchid.
> +		 *
> +		 * Assume that if the boot hart is T-Head, then all harts in the
> +		 * SoC are also T-Head and have the same archid.

The movement of the comment is only half of my suggestion. The other
suggestion is to remove the 'Assume' because we don't have to assume
anything. We can simply state that if the boot hart is T-HEAD, then we
don't want to enable V on any hart. (We don't need to assume the other
hart IDs are the same, because we don't care what they are. They're
not going to get V, no matter what.)

Thanks,
drew

>  		 */
> -		if (acpi_disabled && riscv_cached_mvendorid(cpu) == THEAD_VENDOR_ID &&
> -		    riscv_cached_marchid(cpu) == 0x0) {
> +		if (acpi_disabled && boot_vendorid == THEAD_VENDOR_ID && boot_archid == 0x0) {
>  			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
>  			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
>  		}
> 
> -- 
> 2.44.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

