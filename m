Return-Path: <linux-kernel+bounces-49109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E0A8465EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F6D286FE8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AADE563;
	Fri,  2 Feb 2024 02:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bqTQn0by"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9FBE5C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841175; cv=none; b=DmdAxhUUu5jCdI+lAsNr+crtnSPWo471Lx6o37uSD/ZoN+6OCp46Ii0cOjpGOR42+ivkXFt/Brv2A8VxFUV7ydalwhrSeKnORhW0IJ8MmJJPD5/T0WhovtIWaketstk7LyFEbui4k4srFCdw3lJjTBaq08PfnUifQFuKl/qQW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841175; c=relaxed/simple;
	bh=fxQOIG7+vgteotClB1CdAI70My2PQ8a3hxXKVhBrh6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXVMRo1zJ0PemskrG6YNdxThJ6xCJJKWQE2vxp4ujN9z/zUUWDs64BLN8yJR2OokLjz0yOJjKDMmSGrzL3LR388L7LQh7rYjqHXLYXujvVfGl/kSiaY4ep/JNHHI7skm+Y02OLvmeG4EWAMxVl7gwbJXuSETw8pQPTJa7SQCHec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bqTQn0by; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d928a8dee8so19135155ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 18:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706841173; x=1707445973; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0bXBoUL8xedCmLcnMAqTDLt5mCSq9W7voiTTkiqTwv4=;
        b=bqTQn0byxqWkiKww4qG2sLLU+cfGse+l5tQ1+EaMw/GtU2HtXZS1p320oqNKlyqcGR
         cjyGW7W88N1C70t4VdbvKojcO1ugjxFuyBPCb86Hkte9udfdYUnh1qvU6l4OdVofiGHE
         hX0PAw6mUFuPsDszWQaqP4ieGHriupemdVhp6czwomuJ3JMNiZLCWs6xoru2T5rjIGCH
         Prd7ISm4qPplU2Efw04a+Br6JiCGv2zesAl4q1+WJ473OQDP0Gh6wQGKA5O46aGGLyQZ
         zatl8dk5exG6ATJUwWHN5ZnaD1czOibx6hXAkE4s9HXHA60Sjajxyr6CjjJiFLB34gcr
         D94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706841173; x=1707445973;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bXBoUL8xedCmLcnMAqTDLt5mCSq9W7voiTTkiqTwv4=;
        b=vn+DN2bkM27imtftrdY4Wknd5wimt/EeZ2QHwVOZQZH0QibTRssSWqnKE8Wlt+O4m1
         Oss/6A9OE5e0iyNkDOG5mFm0q21gAle+6BCxCSr9xdjHlA0i9O4NXZQ1Mche1Y2AnG1f
         JOD7/Ys180522sdNufnXFf2pfbZ//YGHlC84reVMIziyhV3QU+r/C9l2WK2MoMIJ0gu9
         s6mvt7lIjW7o92Boyh4KoW22vXQ5O2SMEWZ10NoJV1T0VQeMbIzP6Rvf75FfWOq85ZXt
         l8fLpcnFw90ueeCZpCBZ0SA2CGyh14KCkNDL4CohsvJy8neTNxIO6DptKAPyjfUDLMOY
         NwTA==
X-Gm-Message-State: AOJu0YxhzWWOOxkQ/cEVS39HBM5IU/ZtKSMURVES3K9oiCz5zBzvxhBu
	+WJ66SaHfpZdkH/4poAW9loRiIFCqnbTQ04urdC5oqHVGiCefAYFttWnsd1y+h0=
X-Google-Smtp-Source: AGHT+IGtFCDECe658rt2QpCLasaQ2JkghYeJOImzP8BJBK7/gOp6/f6aiZdBc58sQIW8BtovrJE54Q==
X-Received: by 2002:a17:90a:b10a:b0:296:2843:99cd with SMTP id z10-20020a17090ab10a00b00296284399cdmr1401923pjq.19.1706841173141;
        Thu, 01 Feb 2024 18:32:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXZ6STwiDMcre3f6rZaunHarbO54/adMkGh2ZZ/CykLb79STq4eDTPsA5FX5WMZZXHBB5Msk+NlKkixeem05d2nlknG/D+rpeG6q2rYqx6udY6poFg+E2WGpkLZbpqBQQDqH9FQ+G+6INoHRtQ2OYwp3QKaCj50D06NLGYRrElpiFFjg3oohH9gLBhab/i78AaPUCe4L/BJDoWZYoChqaaYdPZqS09P7OlDc5V51mcNlvFgyeGGbBkX4bUko2TCq4ihf/Ye1gsASBbkH+BajspR/pXVmcfJ83NELoR6FiZShQ==
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090a024d00b0028ce81d9f32sm650159pje.16.2024.02.01.18.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 18:32:52 -0800 (PST)
Date: Thu, 1 Feb 2024 18:32:50 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Robin Ehn <rehn@rivosinc.com>
Subject: Re: [PATCH] riscv: hwprobe: export VA_BITS
Message-ID: <ZbxUUsKdKIPI8Fb/@ghost>
References: <20240201140319.360088-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240201140319.360088-1-cleger@rivosinc.com>

On Thu, Feb 01, 2024 at 03:02:45PM +0100, Clément Léger wrote:
> Some userspace applications (OpenJDK for instance) uses the free bits
> in pointers to insert additional information for their own logic.
> Currently they rely on parsing /proc/cpuinfo to obtain the current value
> of virtual address used bits [1]. Exporting VA_BITS through hwprobe will
> allow for a more stable interface to be used.

mmap already supports this without a need for applications to know the
underlying hardware. If a hint address is passed into mmap, it will never
return an address that uses more bits than the hint address. I designed
it that way so that something like this wasn't necessary.

- Charlie

> 
> Link: https://github.com/openjdk/jdk/blob/master/src/hotspot/os_cpu/linux_riscv/vm_version_linux_riscv.cpp#L171 [1]
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 3 +++
>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>  arch/riscv/kernel/sys_hwprobe.c       | 3 +++
>  4 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index b2bcc9eed9aa..6f198c6ed4f0 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -210,3 +210,6 @@ The following keys are defined:
>  
>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>    represents the size of the Zicboz block in bytes.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_VA_BITS`: An unsigned long which
> +  represent the number of bits used to store virtual addresses.
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> index 630507dff5ea..150a9877b0af 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>  
>  #include <uapi/asm/hwprobe.h>
>  
> -#define RISCV_HWPROBE_MAX_KEY 6
> +#define RISCV_HWPROBE_MAX_KEY 7
>  
>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>  {
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index 9f2a8e3ff204..2a5006cddb7b 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -67,6 +67,7 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
> +#define RISCV_HWPROBE_KEY_VA_BITS		7
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>  
>  /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index a7c56b41efd2..328435836e36 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -202,6 +202,9 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>  		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
>  			pair->value = riscv_cboz_block_size;
>  		break;
> +	case RISCV_HWPROBE_KEY_VA_BITS:
> +		pair->value = VA_BITS;
> +		break;
>  
>  	/*
>  	 * For forward compatibility, unknown keys don't fail the whole
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

