Return-Path: <linux-kernel+bounces-85060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AA786AFDC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF631F21E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEFC14A4F9;
	Wed, 28 Feb 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="PRg+yigA"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA02073508
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125535; cv=none; b=BsvXKYEZvCyCheGCRW8qwTaKgRrdkO2Kdx9R3oLSchw1998aFufWj18EuNMf3X2r0mwhbMnOdZpDRjgOv8vMUAXp1pINR42xqYdvjSWW+JLALxZUaZpn0D/5LfvvGEv1aV2gU91fjjBF9/jWstKqG9GYfDZKm3T6XwNabCLl/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125535; c=relaxed/simple;
	bh=MMhWgFzk2xvRvZhLcEHl1omXZ+ewrj46X6uo0KVBQU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p01QiyVP/zrLazcspEvBdUIV2LlpD6MAJf1huZVbrgGgbEt36xyGn2uvNBIRWF4fwvqRpvFiF9j2cDX9cdO1cyCfKqsXVLeXRvv+l9ijDAPVuyVmpnlAblQ/LcODsbXxuxcOOkX911FkOaoR5z9pIHUBhTW3bwH0nbwQKd2CPrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=PRg+yigA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4348aaa705so443377566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709125532; x=1709730332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3WgTNeeGr6uKUuJvcES9LZuUweLm/sbBaRIaDoEjes=;
        b=PRg+yigArlQOvAMf+4ViDVkE40RfzRlIqwtr42og9I+JvnDOywEaiTu1mCCXlJ5MWq
         g4mMw2IWpGXE+kCqjeBUKMWy92rVUbbPhiltZU1+vemO4e4+GHBiDxODTL+cHCFx56i7
         jTofTAxBrjwPoKEaIL9mQZuo49h94995gno9C67NPVHIvCNJYy1hYJtThC0MHVmBiYBb
         6Lq60c6RDn5PM/GUpxF5JO+vf+iI/lpX12McpdbYcjZWyvInxGcb3qBFumEbO2LpVUnL
         SjAr1NtulmGC5Y7Ia+RWN1NhL8BMsisT5hQRByKzU6vEAL54JHu9AIFMMpHTseRKxtuz
         /TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125532; x=1709730332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3WgTNeeGr6uKUuJvcES9LZuUweLm/sbBaRIaDoEjes=;
        b=T5vRmq/LzSuYm4zbpsQYAAktZn4EPcZuIumpqrem9SdwUc9FFTxdkJh3X5HDQIteVl
         SwInOkuCBTte9RicCzqW2n8XsrG+48Ypz7zV3nlcISSojHAvuSNgWGemY4mj0VEombcb
         44tgZyZAu22324RGWONBXJZBLvneYU+LsT0p6PoR/XPlQ5ChXI7Q2EStVv6MxtHsPa9B
         QeGVvl8VM98gPpa56YItCAr/VGqDz7YnXkIyAmY7P7KqtkjjCALzobbTZu9n2/K1uQjR
         MPukwsz1pKqQbnMpPR40rb4mzuKl89slpeoliLMh9e65/9id0dFn7wT6agrExBj+AXy6
         m/qA==
X-Forwarded-Encrypted: i=1; AJvYcCU6QiNIL0vNU6DYeZ2mvCD8CdKJdunx9FUvs77855E9ULgDKAFerJIQZUKGX8UyUAaxY/CDhS2RxdTYmwidfRIGvWS1Y3bxoDhUj8QH
X-Gm-Message-State: AOJu0YwUMmY8iiJk4VfUCIEAz2XSk2asgyzK/zKySmI50sla99Vpo5mS
	E1TyvG2CO5B8kGTkxAXbr6Q0jyOf/9zA6ZiPPVNm6VQrY8cffjvPzh9r08CXRXk=
X-Google-Smtp-Source: AGHT+IH+C1UK8TXkfq2HYZwku9tG0/J9fW8seqeejTe1fbola7gcXOqlPx5qIbzYgVlGAurTsc1Dmw==
X-Received: by 2002:a17:906:371a:b0:a3e:9ad2:b555 with SMTP id d26-20020a170906371a00b00a3e9ad2b555mr9508772ejc.24.1709125532375;
        Wed, 28 Feb 2024 05:05:32 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ti6-20020a170907c20600b00a43c3e5e008sm1386581ejc.205.2024.02.28.05.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:05:31 -0800 (PST)
Date: Wed, 28 Feb 2024 14:05:31 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/5] RISC-V: KVM: Allow Ztso extension for Guest/VM
Message-ID: <20240228-4b0546ecd98e675844aab46f@orel>
References: <20240214123757.305347-1-apatel@ventanamicro.com>
 <20240214123757.305347-3-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214123757.305347-3-apatel@ventanamicro.com>

On Wed, Feb 14, 2024 at 06:07:54PM +0530, Anup Patel wrote:
> We extend the KVM ISA extension ONE_REG interface to allow KVM
> user space to detect and enable Ztso extension for Guest/VM.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 1 +
>  arch/riscv/kvm/vcpu_onereg.c      | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
> index 7499e88a947c..f8aa9f2ace95 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -166,6 +166,7 @@ enum KVM_RISCV_ISA_EXT_ID {
>  	KVM_RISCV_ISA_EXT_ZVFH,
>  	KVM_RISCV_ISA_EXT_ZVFHMIN,
>  	KVM_RISCV_ISA_EXT_ZFA,
> +	KVM_RISCV_ISA_EXT_ZTSO,
>  	KVM_RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index 5f7355e96008..38f5cf286087 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -66,6 +66,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
>  	KVM_ISA_EXT_ARR(ZKSED),
>  	KVM_ISA_EXT_ARR(ZKSH),
>  	KVM_ISA_EXT_ARR(ZKT),
> +	KVM_ISA_EXT_ARR(ZTSO),
>  	KVM_ISA_EXT_ARR(ZVBB),
>  	KVM_ISA_EXT_ARR(ZVBC),
>  	KVM_ISA_EXT_ARR(ZVFH),
> @@ -141,6 +142,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
>  	case KVM_RISCV_ISA_EXT_ZKSED:
>  	case KVM_RISCV_ISA_EXT_ZKSH:
>  	case KVM_RISCV_ISA_EXT_ZKT:
> +	case KVM_RISCV_ISA_EXT_ZTSO:
>  	case KVM_RISCV_ISA_EXT_ZVBB:
>  	case KVM_RISCV_ISA_EXT_ZVBC:
>  	case KVM_RISCV_ISA_EXT_ZVFH:
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

