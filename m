Return-Path: <linux-kernel+bounces-37523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A369083B140
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5CF61C22875
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5723D131736;
	Wed, 24 Jan 2024 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="U79ePXOS"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE413172C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121394; cv=none; b=nI68x3JLO0+5X7hki3Y0PFFS+/GHOnyleTWOzMjoWkFiMFj5nJCuA0YUYPAxMa875ujWRUIS4enmMGVX5fckaGGcraO+188aqQtjrp3hWeGkPr0xNsAcIjOjUN4mqr4JHaCk9vKOhclgICodWT4CysJ5yJA1zBkz0UNtV/f5skE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121394; c=relaxed/simple;
	bh=Y84vm7zPVQwyKhmEkvswV7MwbzkZTeonxhhVQOUT2pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEMNDYU+HbpwbQ8duVRB7XeF1OGBwy/kCLKTWlrnySWk9g8+OgvcgdtU35jb7+IWLzeuf7W7+YjnIbjWMhMHX09SHqK9tnz9x4jjcL3HEPrwxNRJgKOByR0H+YcC1cWIs3R33G0GO1vigrwtpl4AaG8QCloRjzcX5jaXVueeUEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=U79ePXOS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ddc6f5eaccso154b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706121381; x=1706726181; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dyoVaujb6HdGGQZquWAHWyK8BzIubclZKA3RVrGEVpc=;
        b=U79ePXOSMF/HbuhbOuujkQY+eusf3qkq3agMM3NmznpRgcs2MUQi0a4DeoFTkHDsMi
         BAdknpuaEwiohreDALcBJIPhNRI2dfP/hCjA3SUmK2N6hGbvDE5eYp0La3JFArEgqB9h
         IV2b/89iesS2MEuH678m1uFtWjZWZgv0I2danINL9TcpIqYCC2DWkcYjo+iGjO8lLRnG
         /GQ1T1iWjj9sT9I+YURuTIln0VLRsbXW+slf2ULghZj2uDvjP0Yn3tjyi8CXCUTA4z5I
         gl4rln64vv96oJp59UaBS5mzXA4s9JWNxyGwMiqdcTaRUe8uEAgexO0UhIaDXu0BJ4nj
         0NRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121381; x=1706726181;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyoVaujb6HdGGQZquWAHWyK8BzIubclZKA3RVrGEVpc=;
        b=CcI7CKg1mGzzVgKZ+05Sg3/DgQm3owarj+XKGXImOFfIlae/3dIbInGPHVFGf5MEdp
         OUOAaqi5lj010dfiki+WDeIrmnJdjeTWH7s4uUDxQ9BTLfl5Fpb+sUCAE3G+2DIet73o
         swqLdRL5OE/ssZNyDJKKHPWE0/u40sE+jEks2ng70ij4L2kF490zfv1CVbHTTwPdCnVK
         v7Of4uYZ6RCXjUsfS+Wk53Pn48SERgVt+cWPxiperzqal3rfPTkV4Vs/if1xnMr7LUlb
         t5UAnCO8tCii5aDcIiam9b5TPeFeM6jx7KSNmCqtGprcr5CkROF8f9ZszQ42ADFueTx6
         tmLQ==
X-Gm-Message-State: AOJu0Ywa6HzPAVz7xsE7OqXp33M7daNC221H6s8XZNK6CCrewQThSEv4
	t1VEsAW3wpnGM1pWN6ubWguCLn6zvoSI79+cKV61FZkmtFxlkdd4PJux1WbNJ04=
X-Google-Smtp-Source: AGHT+IGa4MiJVKL68+be1ENZatYewBEzPKO9fNG4WgZ7fFnKMwOYC9yysxlwKGZJPdjj+oZ9bTHTzA==
X-Received: by 2002:a05:6a20:6e91:b0:19a:e5cd:c41d with SMTP id gr17-20020a056a206e9100b0019ae5cdc41dmr881650pzb.96.1706121381191;
        Wed, 24 Jan 2024 10:36:21 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a056a0026cc00b006ddc2a97806sm444955pfw.213.2024.01.24.10.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:36:20 -0800 (PST)
Date: Wed, 24 Jan 2024 10:36:17 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: guoren@kernel.org
Cc: linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, alexghiti@rivosinc.com, xiao.w.wang@intel.com,
	david@redhat.com, panqinglin2020@iscas.ac.cn,
	rick.p.edgecombe@intel.com, willy@infradead.org, bjorn@rivosinc.com,
	conor.dooley@microchip.com, cleger@rivosinc.com, leobras@redhat.com,
	linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V3 4/4] riscv: mm: Optimize TASK_SIZE definition
Message-ID: <ZbFYoT4OWQQs7H5z@ghost>
References: <20231222115703.2404036-1-guoren@kernel.org>
 <20231222115703.2404036-5-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231222115703.2404036-5-guoren@kernel.org>

On Fri, Dec 22, 2023 at 06:57:03AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Unify the TASK_SIZE definition with VA_BITS for better readability.
> Add COMPAT mode user address space info in the comment.
> 
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/pgtable.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index e415582276ec..271565e1956f 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -866,6 +866,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>   * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
>   * Task size is:
>   * -        0x9fc00000	(~2.5GB) for RV32.
> + * -        0x80000000	(   2GB) for RV64 compat mode
>   * -      0x4000000000	( 256GB) for RV64 using SV39 mmu
>   * -    0x800000000000	( 128TB) for RV64 using SV48 mmu
>   * - 0x100000000000000	(  64PB) for RV64 using SV57 mmu
> @@ -877,10 +878,10 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>   * Similarly for SV57, bits 63–57 must be equal to bit 56.
>   */
>  #ifdef CONFIG_64BIT
> -#define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
> +#define TASK_SIZE_64	(UL(1) << (VA_BITS - 1))
>  
>  #ifdef CONFIG_COMPAT
> -#define TASK_SIZE_32	(_AC(0x80000000, UL))
> +#define TASK_SIZE_32	(UL(1) << (VA_BITS_SV32 - 1))
>  #define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
>  			 TASK_SIZE_32 : TASK_SIZE_64)
>  #else
> -- 
> 2.40.1
> 

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


