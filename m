Return-Path: <linux-kernel+bounces-37522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F3183B13F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBA61C22C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABBE131739;
	Wed, 24 Jan 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IPY6oUPt"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF3131733
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121349; cv=none; b=kGGPNswomuckl96OytjGmxMK+kopUtJuzE0rVEfnryqR/xmPwmZVBSuTAh8NvhZZm4ewBSJoz7I5a+nyrdBKDeM/vHKa4NX/xWqDTl4JDFVJBHHrrj9xPf+ucckfxhIRgJItWdJ7PXEMwRQWs2BhX9JfDocB1imDQ6wXjqKN7S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121349; c=relaxed/simple;
	bh=QD6RdBcDxgxeO88Ma7z7Ldbk92/k+S2l/6jPWTI9kvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLfrULklK7nrjNS9KF+awgqD5RAtqztZSQUwocNyAPesH3GOzTmA/GCi4ebU16XjShBIYZQTa3Db77F4EmYFm3ZDrJu50OkGEBv00kdBRi023EC5xlPcRTKv5VzR+GeSuxcNMwLpGFrnBFUn73MrDsJ653/I2kKOKxcr9nW/aws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IPY6oUPt; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bda4bd14e2so4454335b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706121347; x=1706726147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BSDyjeT+sWx4a7+HucQkDxlfBX8Yu1AlwACyEiZHipQ=;
        b=IPY6oUPtAlnmxG36VLpFgsUaNQhBMa2Ig+vdtY1wWWWRQ35/GU1z/r1QME9wBOo6C8
         uUYvw5BRN43BSmjfItcRK12YL61qVx8AWuYPWBLk/b3TAR/R8l2Z3to7QQWu+FKeFFNb
         xSW6AY+Ut+sAoFdkQbRBnzSmX5hA422DorJ0P27+R1w7LqRNJqEMM2nMjmrti3IOF9ix
         DSV+wVNm4/RMT61Pi/TnCDqjMvvVAlDqcQq5vJ+2VASaMb+GJxi5MlUf8UedRkwDTdrQ
         RTmUFifKPa/XrNg8NLgY8eQ2vHTWCpwH00IXFSQuW3k5gedk3/5YNpxcVOXbjiT/H6Pr
         Hbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121347; x=1706726147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSDyjeT+sWx4a7+HucQkDxlfBX8Yu1AlwACyEiZHipQ=;
        b=fi61MJ5vJX+szF/IZ1v1dylH54ivmgSWdJpu2nNfldcsy58WLz/VTlkR4czbl+r7M0
         RLKmAoarO7AAe+0uRw46TOzDasTv+u2U/PC2ND6Mkog2MOsz2Ioogv/KhHPcVlCE3puL
         DmS/URdh8TyUyMp9JM6JLIZ0LNVtNI14/7dwWjX80aZxGEnumxgK9AdOKSJvUGInoiZf
         Q/G0ptGSzDA7NLIJvoghcv0lwrCi+38d0r9noNWmN6EcgKkVXNp1q8SGeuulpEWtlxTg
         MebBcctDS4+Y1AnDK9FFAGgeb6iKdJY6Jo66WbGYfOjN1JzjnjcfuJVr+HsbAkdrQcbN
         ZSAg==
X-Gm-Message-State: AOJu0YwKJvwhXkNZ8JOqsHTcUOd/jPQRTe37/nfyss7iLY/VM6iJ7Q3q
	wHGHhUcZPgYGZZur/SRzTBBV3y/TpyqXyo+OhURzAEfWDYFfFvFDxSbMjI1pwfg=
X-Google-Smtp-Source: AGHT+IG1yY+FPPP5M4yQmH3acC0a0/2mcx5E1lUmj9dQ7hZv1pU3OA5oy37S1GCeQohq0/uOBCuQyA==
X-Received: by 2002:a05:6871:581e:b0:210:9e85:edc3 with SMTP id oj30-20020a056871581e00b002109e85edc3mr4154038oac.18.1706121347349;
        Wed, 24 Jan 2024 10:35:47 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id t8-20020a63dd08000000b005cf450e91d2sm12079197pgg.52.2024.01.24.10.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:35:47 -0800 (PST)
Date: Wed, 24 Jan 2024 10:35:43 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: guoren@kernel.org
Cc: linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, alexghiti@rivosinc.com, xiao.w.wang@intel.com,
	david@redhat.com, panqinglin2020@iscas.ac.cn,
	rick.p.edgecombe@intel.com, willy@infradead.org, bjorn@rivosinc.com,
	conor.dooley@microchip.com, cleger@rivosinc.com, leobras@redhat.com,
	linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V3 3/4] riscv: mm: Remove unused TASK_SIZE_MIN
Message-ID: <ZbFYf+TDKhPQIpVR@ghost>
References: <20231222115703.2404036-1-guoren@kernel.org>
 <20231222115703.2404036-4-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222115703.2404036-4-guoren@kernel.org>

On Fri, Dec 22, 2023 at 06:57:02AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Remove TASK_SIZE_MIN because it's not used anymore.
> 
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/pgtable.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 74ffb2178f54..e415582276ec 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -878,7 +878,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>   */
>  #ifdef CONFIG_64BIT
>  #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
> -#define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
>  
>  #ifdef CONFIG_COMPAT
>  #define TASK_SIZE_32	(_AC(0x80000000, UL))
> @@ -890,7 +889,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  
>  #else
>  #define TASK_SIZE	FIXADDR_START
> -#define TASK_SIZE_MIN	TASK_SIZE
>  #endif
>  
>  #else /* CONFIG_MMU */
> -- 
> 2.40.1
> 

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


