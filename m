Return-Path: <linux-kernel+bounces-131348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C828898692
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D62528B716
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296DD85269;
	Thu,  4 Apr 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GHw7yOx5"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B284D05
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231861; cv=none; b=ZvWvERgi3mZWs0WvHs9Jf1pFkLWGjtq2P0JSxRO4aPARlulsAuhscdUaNSFfu9yW70fkgdN+0CGgPoD1P5QU0lkcMf7LdWzyFcAamPmXYcHSQl9Mod5Wl8Xu1tn5twr93ttbbYjX4au8awDLgKi7iLAZLFpanvhwvZPDs+Xp5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231861; c=relaxed/simple;
	bh=r2y5XgIeaVFD9YYVCCQXxvPJe8jenW3QZdB/CzLVRdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC7iBRGOk+eLRPPxVKx3fC0iorsNrjF8iifNXC1SMqJbfOpExO0geV2siP4xflsi7cPzCTAePNTm+eFVciiBxzUy6kncFx6A2tZ9CxoKV20hZntbQ/9QZfqFdekSGeISuhs6OAUp55eQe5Ndf1RbHBKSai36UScPQbjMz/5i0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GHw7yOx5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5193f56986so33990166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712231857; x=1712836657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWw71C7jU1cEwI+5ODGcknLMAR0yYHVr8hihh6Lqglg=;
        b=GHw7yOx5X/R0s614/5Rftzsrr1O3kiprSpaywNMKFkoxb2PHZ5gMMWYTnBDonwIj5u
         W90RiXYhSFTzTc438kzJKNdb/BvBFWI11G/3uXbuC5BoNNl6HieILMP8xPUeJsI8UlaK
         +mbFivmR/knt0tOhbaYVybM8RaXMDjRzBnmOvY4NgbVr3duzsdmHGa044Qtcaly83HYO
         t/4ADBu49c9g/JplcxZDIzQrAXw7dkytaQ3S/V9pvxJ5MCYOQ8waR21dA/74GK1EzAnU
         wxNrZ3aIIwJ6LqfFgNl1LfylufRqSPE4hdF8DEqE5vnhA2t+bwtuRkAd37BKPkM9yNUD
         E/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231857; x=1712836657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWw71C7jU1cEwI+5ODGcknLMAR0yYHVr8hihh6Lqglg=;
        b=kBVOoIyuc8t1ZhE7X4mxOUXB35KfSsp7zjXgL6tyfC3wDj+jSJ5JSF4fAP3P1sNHs6
         0Wh9lAw8AeLQ69RuoF4fHkER1lVcP28IqXfPhjbwgZn7DZS0vKbgSD/SRr/PJgor5IDy
         GCO1MKeoaaCDg6ILyRd8ztftvWOkUZxpe8fSpBi/U2X7bBg53ORg1/RpLzq6LnLhWbt0
         jhfIOuB4FtQhIeRhtgxpYPU3cqmgM4TEpklfH6QmI3nam9qp3XGBAQYak2JRBywMnzkT
         d3ko1uF87wfa5aI7ec7b5SYIh0mFgBPnTJe4lSfQ79x3gQHFHBFd5fcJzU8tl03KaNpp
         c8NA==
X-Gm-Message-State: AOJu0YxidBDGY/y0Q1OLsKG8Qft2wkJJenOkuRY3V9FEoY7Cr1Y7RCE7
	UOJ8oG1HOHKntlzYBE0vFwbDlHek2JN03zNAJYoVzuy8vAKkaod477F9jdmEx+4=
X-Google-Smtp-Source: AGHT+IF8SdqZ3HyZZ91FGKimTKayOc7UTusAbOGT6GeUZ2TkAX0/2dzA77WUR8ICDxbEhjc/oE44yQ==
X-Received: by 2002:a17:907:c0d:b0:a50:f172:6994 with SMTP id ga13-20020a1709070c0d00b00a50f1726994mr1816047ejc.73.1712231857594;
        Thu, 04 Apr 2024 04:57:37 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906538f00b00a4e98679e7dsm2355698ejo.87.2024.04.04.04.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:57:37 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:57:36 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Ajay Kaher <akaher@vmware.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <amakhalov@vmware.com>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 08/22] RISC-V: KVM: Fix the initial sample period value
Message-ID: <20240404-1c3dc9b63f80fc451d3a732a@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-9-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080452.1007601-9-atishp@rivosinc.com>

On Wed, Apr 03, 2024 at 01:04:37AM -0700, Atish Patra wrote:
> The initial sample period value when counter value is not assigned
> should be set to maximum value supported by the counter width.
> Otherwise, it may result in spurious interrupts.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/kvm/vcpu_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 86391a5061dd..cee1b9ca4ec4 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -39,7 +39,7 @@ static u64 kvm_pmu_get_sample_period(struct kvm_pmc *pmc)
>  	u64 sample_period;
>  
>  	if (!pmc->counter_val)
> -		sample_period = counter_val_mask + 1;
> +		sample_period = counter_val_mask;
>  	else
>  		sample_period = (-pmc->counter_val) & counter_val_mask;
>  
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

