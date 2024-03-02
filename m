Return-Path: <linux-kernel+bounces-89425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF6686F02B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 12:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52161B21FDD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A99171A5;
	Sat,  2 Mar 2024 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="N7vCnMtV"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61FB79C8
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709377269; cv=none; b=dkPD+qRJetv0poYFu5+CFx+vQ5CZjbAAaxTgkA1dBbcAEja3IJYbmYc5JmwkWyuOABgL2gOY0Jkng0rC/Pybvv1e1r4hFjlxnSqkgm+ZCxnmOuGHB0lcqY7mO4Ds22hzqmD/QgnH80KLDobSx5OFYb1Rw264thv4iRoKH+iXcrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709377269; c=relaxed/simple;
	bh=QIqM/BeUdDzc4fcCgwEcSQUPcDNmvMpROD3uyltk1rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s11F2jkBxxNS4Wzac65gfhX+CJFYC1shSW+SOXUN/0463iLAutU0zboAy02sWAaROKKX+SxtdXcDLT38hLZsi/IOQioJ1sIhhbT7mBLhYJ00AgRe0DMLfJqSt2BzvWjxY/QGaY2H4ZU8p4dlodHfbB/+24JcxJmiEHYOSbhEuEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=N7vCnMtV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d7b8f563eso1799146f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 03:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709377266; x=1709982066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BnBh9q3h81nttMpKclVeCqqdtApMcvk+N5PgmMdmQjQ=;
        b=N7vCnMtVbH6tV9AqPoSAgYvyo2u8AJB+RumemowDY/sIu3cLXzhTJf3lp0uxAGp0ct
         dmcaPWoK6gLiHO7R77j7ybRc7qVWWLj11/oWBTD+Vbk16aXL5nn9kCBfewdU+3fH5r0f
         aKmGZWBlvmbe1kfDhd+FjiYDH0WcrNJqTR+3eX6xPFI29u+wJHBIT5kk+x93N6fWdzSl
         X1aZ4KIeuK7nb/TIHqed7tbImDbpkRPFVULZAX07dJiq8/QIInK78qdgO8u/S2Sgg3W8
         xW1EH0jKBVugDylPLbDCmZZTjML2QCDqy/9hotQhFsNgdWvEnCZdWURnmv5VR4Hdcj0/
         ESyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709377266; x=1709982066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnBh9q3h81nttMpKclVeCqqdtApMcvk+N5PgmMdmQjQ=;
        b=byZhWjNkyPUchc49TT4jkVrgDb85aA2p2u8XirqixR7IHK7ASB6sGHoaguvXMTvcqi
         vPFxcgtjRtS1BQpv40R5OCWxsZEfxsMZo/f5u62/ofSPzzejd9gXB7nhM/Ec3cQgp2Us
         hT3L7l20eq0pIly1R5Fql1FERgpAGZvndK4hYqfIAGIzia0YbcdNMXj48ilIUXpHixFB
         3/Wy/0DZIQY1VzQ7gDZnV6ZTyFku/k2uWrqeT3Gzp8mc6Y9xH5PrqgHldL4DAOSpqEMc
         g9rueX+Ox5OEoaLX8IBdEdL9o8pm8HVX69UF5Lh7h9dGHNbKgqgc8rFHhUmnoJPKUCHo
         GCyA==
X-Gm-Message-State: AOJu0YzJ9IvgcB9QFLo3ZzLWuUhkPpRs5P9EWvas+OM7vb0VyD1up91h
	WIIJwevAsQD4htHr1HRlTC+Q5Maw6YfmqdFx1WMpDcDsK6t/iBrKhpQ38Pj7D0k=
X-Google-Smtp-Source: AGHT+IFBE0FYUXd6PXNSgQDWSCL6Ga0yuS3Bws39s4NBtN3Sv+6V9ZcPw12uO6ds6wR23yK7a7LHrg==
X-Received: by 2002:a5d:510b:0:b0:33d:e140:a81f with SMTP id s11-20020a5d510b000000b0033de140a81fmr3159514wrt.56.1709377265670;
        Sat, 02 Mar 2024 03:01:05 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d4583000000b0033b47ee01f1sm6994178wrq.49.2024.03.02.03.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 03:01:05 -0800 (PST)
Date: Sat, 2 Mar 2024 12:00:59 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 12/15] KVM: riscv: selftests: Add SBI PMU extension
 definitions
Message-ID: <20240302-698f4322ab7ba74fc3dba416@orel>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-13-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229010130.1380926-13-atishp@rivosinc.com>

On Wed, Feb 28, 2024 at 05:01:27PM -0800, Atish Patra wrote:
> The SBI PMU extension definition is required for upcoming SBI PMU
> selftests.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  .../selftests/kvm/include/riscv/processor.h   | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index f75c381fa35a..a49a39c8e8d4 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h

We should probably create a new header (include/riscv/sbi.h) since
otherwise processor.h is very quickly going to look like an SBI
header with a few non-sbi things in it. Can we add a patch prior to
this one that moves the SBI stuff we currently have in processor.h
out to an sbi.h? Or, we could start synchronizing a copy of
arch/riscv/include/asm/sbi.h in tools/arch/riscv/include/asm like
we've done for csr.h

> @@ -169,17 +169,84 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector, exception_handl
>  enum sbi_ext_id {
>  	SBI_EXT_BASE = 0x10,
>  	SBI_EXT_STA = 0x535441,
> +	SBI_EXT_PMU = 0x504D55,
>  };
>  
>  enum sbi_ext_base_fid {
>  	SBI_EXT_BASE_PROBE_EXT = 3,
>  };
>  
> +enum sbi_ext_pmu_fid {
> +	SBI_EXT_PMU_NUM_COUNTERS = 0,
> +	SBI_EXT_PMU_COUNTER_GET_INFO,
> +	SBI_EXT_PMU_COUNTER_CFG_MATCH,
> +	SBI_EXT_PMU_COUNTER_START,
> +	SBI_EXT_PMU_COUNTER_STOP,
> +	SBI_EXT_PMU_COUNTER_FW_READ,
> +	SBI_EXT_PMU_COUNTER_FW_READ_HI,
> +	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
> +};
> +
> +union sbi_pmu_ctr_info {
> +	unsigned long value;
> +	struct {
> +		unsigned long csr:12;
> +		unsigned long width:6;
> +#if __riscv_xlen == 32
> +		unsigned long reserved:13;
> +#else
> +		unsigned long reserved:45;
> +#endif
> +		unsigned long type:1;
> +	};
> +};
> +
>  struct sbiret {
>  	long error;
>  	long value;
>  };
>  
> +/** General pmu event codes specified in SBI PMU extension */
> +enum sbi_pmu_hw_generic_events_t {
> +	SBI_PMU_HW_NO_EVENT			= 0,
> +	SBI_PMU_HW_CPU_CYCLES			= 1,
> +	SBI_PMU_HW_INSTRUCTIONS			= 2,
> +	SBI_PMU_HW_CACHE_REFERENCES		= 3,
> +	SBI_PMU_HW_CACHE_MISSES			= 4,
> +	SBI_PMU_HW_BRANCH_INSTRUCTIONS		= 5,
> +	SBI_PMU_HW_BRANCH_MISSES		= 6,
> +	SBI_PMU_HW_BUS_CYCLES			= 7,
> +	SBI_PMU_HW_STALLED_CYCLES_FRONTEND	= 8,
> +	SBI_PMU_HW_STALLED_CYCLES_BACKEND	= 9,
> +	SBI_PMU_HW_REF_CPU_CYCLES		= 10,
> +
> +	SBI_PMU_HW_GENERAL_MAX,
> +};
> +
> +/* SBI PMU counter types */
> +enum sbi_pmu_ctr_type {
> +	SBI_PMU_CTR_TYPE_HW = 0x0,
> +	SBI_PMU_CTR_TYPE_FW,
> +};
> +
> +/* Flags defined for config matching function */
> +#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
> +#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
> +#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
> +#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 3)
> +#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 4)
> +#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
> +#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 6)
> +#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 7)
> +
> +/* Flags defined for counter start function */
> +#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
> +#define SBI_PMU_START_FLAG_INIT_FROM_SNAPSHOT BIT(1)
> +
> +/* Flags defined for counter stop function */
> +#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> +#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)

When changing shifts to BIT()'s, don't forget these (easy not to forget
if we go with the synch sbi.h to tools approach)

> +
>  struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  			unsigned long arg1, unsigned long arg2,
>  			unsigned long arg3, unsigned long arg4,
> -- 
> 2.34.1
>

Thanks,
drew

