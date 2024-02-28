Return-Path: <linux-kernel+bounces-85085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE8086B032
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32D31F23976
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FAA14AD3A;
	Wed, 28 Feb 2024 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="O1tbovg4"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C931E493
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126632; cv=none; b=aEZ7ZjOc8wgnydO8KcqCGBj0nhegfdVyBw9I+nlCN7tz1Feg8CArVoI89lWr4eyh/ghaVn0K/A/whulml0FPhVjhwYGGgOFma7evRxmfqt+AS2MZFXTGbcYJKuWaR41p7PYpQSRWEtpmztkupZsIDKMLoBAhiTpd7JCopwHueXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126632; c=relaxed/simple;
	bh=kyD96LlqC0WDcP5SnnAWQxbwUFSnDFt0kfUoP4Y3c7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njxE9RurgFsoXc9tDb07c293smDgD0jf+U0gNxiHrpCkmmCOwCm55jcI94/bt+FIB63Z2jrVmUJJLfsGDJABDeAfCQi8/jCn5SbfdqQ4RqLndJ9iNIqlJuInHPZe+wF0IPjzrQqc9waooRGaY6r52BrEtm7mgU4j3N2ik5xk/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=O1tbovg4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d568fbf62so3147237f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709126629; x=1709731429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4AJ/fArH74SzdFgIIdNAKmcF3qjIEBPPZEADsp2Buk=;
        b=O1tbovg4/6O/ljHAruTDaLS6WOKl+bCI7vpNSaIn/jP5Q3ICPhEHJTGBXKDaERwqNG
         937blckOzDGu2Q+hu9eDMQcBYYe6jCBpquZWoj2/xGu/rgXDpf5UN0uoFsfX6LSLJAuy
         MFw3L1ZTzbx7LKSGk8WCNiTAcEavpdTQeJHV1Qk7T/lVCfa9/umnshxvePEHGNjRCVh1
         hsPOXLb32VllPXKgNf/RT9jeWqRHtKsvCsN359ETv4mcHDuS+iIqlmcCA9s2sz+671Ym
         v/Oohj5/wBj1FbGzFB7a69rHwA5P+bPUH9CvOZxYpfZB1THjfdYhMUHK6PAOQ7RhcBRV
         eQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709126629; x=1709731429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4AJ/fArH74SzdFgIIdNAKmcF3qjIEBPPZEADsp2Buk=;
        b=Ekw3cCVCvOd5RgTj6G+2nPcAAGCGqNNpUvZ9gaX+HEXYt7KzKLQD/+PGRyqNoHl+iL
         iWtO7G9WM0DcAvtlJJmPSYILEnIEdxCEPQwevPnzqMdkfZTiZg4C1AdPkXMlsJgT+F8a
         rWvYJ4U+CVSbNFwYCfXWEA9UWvOBDMOwE6WgYdEc9Ueb0ih+s06mGSuwjJHH2UHleOrj
         /bh1p9kqWP6wX3vuXb4UfcMwLGEJIEfTfKKmBbCA7uZ27pwTU+kMeHT7hCY0plUj6cU6
         b7CqgePdCn64FE4M2Fhk9f05ZQVYrDYAnZ4yk6GhLpr/7Kbnoz9fDGDuLXoNvj3pm0ri
         KPpw==
X-Forwarded-Encrypted: i=1; AJvYcCUSJB/J2ebzn6pIi/LHqgplTKyTWm8wu0KbGu1BTHGarAxQfq7zkJV4SHmDrPPDG7zve2AAc42hCdW7fjicaOV5zwTtiq1aynfa+aiP
X-Gm-Message-State: AOJu0Yw/9kyuRdb8/KOpTEsNe3EoWcbYUb+NjmhLbc9ptm0sLu+Cgug/
	pQ4Xszg43c0l62Gv4ZMvA02sYNoJXlZJAaKutYMOlEe4Ia8BeSqncXPtI9nfLE2K6M9ZVi58V4a
	P
X-Google-Smtp-Source: AGHT+IFBd1kKeTUg2s8YVizQ+9mRMh8SA/NeRYEZS37yHKGxfoOm8vE5+PviOWlb4gymksIThVwa2A==
X-Received: by 2002:a5d:6789:0:b0:33d:e908:3671 with SMTP id v9-20020a5d6789000000b0033de9083671mr3386900wru.4.1709126629485;
        Wed, 28 Feb 2024 05:23:49 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id q16-20020adffed0000000b0033ce06c303csm14568306wrs.40.2024.02.28.05.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:23:49 -0800 (PST)
Date: Wed, 28 Feb 2024 14:23:48 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	Stefan O'Rear <sorear@fastmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH -fixes v4 2/3] riscv: Add a custom ISA extension for the
 [ms]envcfg CSR
Message-ID: <20240228-ca2521f494659596f079b843@orel>
References: <20240228065559.3434837-1-samuel.holland@sifive.com>
 <20240228065559.3434837-3-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228065559.3434837-3-samuel.holland@sifive.com>

On Tue, Feb 27, 2024 at 10:55:34PM -0800, Samuel Holland wrote:
> The [ms]envcfg CSR was added in version 1.12 of the RISC-V privileged
> ISA (aka S[ms]1p12). However, bits in this CSR are defined by several
> other extensions which may be implemented separately from any particular
> version of the privileged ISA (for example, some unrelated errata may
> prevent an implementation from claiming conformance with Ss1p12). As a
> result, Linux cannot simply use the privileged ISA version to determine
> if the CSR is present. It must also check if any of these other
> extensions are implemented. It also cannot probe the existence of the
> CSR at runtime, because Linux does not require Sstrict, so (in the
> absence of additional information) it cannot know if a CSR at that
> address is [ms]envcfg or part of some non-conforming vendor extension.
> 
> Since there are several standard extensions that imply the existence of
> the [ms]envcfg CSR, it becomes unwieldy to check for all of them
> wherever the CSR is accessed. Instead, define a custom Xlinuxenvcfg ISA
> extension bit that is implied by the other extensions and denotes that
> the CSR exists as defined in the privileged ISA, containing at least one
> of the fields common between menvcfg and senvcfg.
> 
> This extension does not need to be parsed from the devicetree or ISA
> string because it can only be implemented as a subset of some other
> standard extension.
> 
> Cc: <stable@vger.kernel.org> # v6.7+
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
> Changes in v4:
>  - New patch for v4
> 
>  arch/riscv/include/asm/hwcap.h |  2 ++
>  arch/riscv/kernel/cpufeature.c | 14 ++++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 5340f818746b..1f2d2599c655 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -81,6 +81,8 @@
>  #define RISCV_ISA_EXT_ZTSO		72
>  #define RISCV_ISA_EXT_ZACAS		73
>  
> +#define RISCV_ISA_EXT_XLINUXENVCFG	127

Since 128 is just the current max and will need to be bumped someday,
xlinuxenvcfg will end up in the middle of the list at some point anyway
(since bumping it too would be unnecessary churn). With that in mind,
I'd probably have just assigned it 74, but either way is fine by me.

> +
>  #define RISCV_ISA_EXT_MAX		128
>  #define RISCV_ISA_EXT_INVALID		U32_MAX
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index c5b13f7dd482..dacffef68ce2 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -201,6 +201,16 @@ static const unsigned int riscv_zvbb_exts[] = {
>  	RISCV_ISA_EXT_ZVKB
>  };
>  
> +/*
> + * While the [ms]envcfg CSRs were not defined until version 1.12 of the RISC-V
> + * privileged ISA, the existence of the CSRs is implied by any extension which
> + * specifies [ms]envcfg bit(s). Hence, we define a custom ISA extension for the
> + * existence of the CSR, and treat it as a subset of those other extensions.
> + */
> +static const unsigned int riscv_xlinuxenvcfg_exts[] = {
> +	RISCV_ISA_EXT_XLINUXENVCFG
> +};
> +
>  /*
>   * The canonical order of ISA extension names in the ISA string is defined in
>   * chapter 27 of the unprivileged specification.
> @@ -250,8 +260,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
>  	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v),
>  	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
> -	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> -	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> +	__RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
> +	__RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts),
>  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
>  	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
>  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> -- 
> 2.43.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

