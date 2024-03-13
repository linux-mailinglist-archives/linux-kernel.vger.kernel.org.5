Return-Path: <linux-kernel+bounces-100991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B44E87A087
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC21D1F237D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65238D51A;
	Wed, 13 Mar 2024 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eaFnMQAS"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD0C13D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710292266; cv=none; b=KIeJ21s10hAOmmBLSlu7ursJrlWyCnwIMgDx7ahDd9MZB+pOrhDZ/h/xXN3Vv8zekQA/UJqJ+HNQqQ3wwgEKSDX6C923CV0QJ1yUDbc/+5De+X/gSjxO/ljEO7v2ACbd3yfH5PepaPRSymhB0Kp3nmeh9rhnmIW8GjRyYb90b9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710292266; c=relaxed/simple;
	bh=m8lONA1Y/Qn0HmuMHvclR4yAm5be+jt2pbB7DOkU9CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRIFMQl4lTvRBoNWF7rwpQgcICteD9S7ny1bQQU95gYLgd0XbB1/gLqH+BpvBKYhspfgn3+tC7bag30xt4rSeWDldhn9f4rCR0CrfryzUEvlPSGDQ5vYQkoLISiUR0QPFPpC5GH0rlkZWN1qXsuuVY5LkMw22wjlVLpAU940Yx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eaFnMQAS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6ac58fceaso1046300b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710292264; x=1710897064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iZVTEdL4tspWGYZt6WUdOVkVxO9G+Bnl9WSMo6I37UI=;
        b=eaFnMQASebhLFkVLIL8syeC17PPCIodX9ZhGNfYwd9phoVayeq11CCALWev4ST8Mnc
         Ku1eDrW09OF5qo2Omba+9Z7v393Z8W1B0lPYxJw5rS+Acq9SFNdHYZZJgMm4WveKOF/q
         EgFTiRe+lC4/nczLMg0mPrjK2UPlP2LrJ5xmiAMTUGDrgX9ZVnhLSuSp0/ecD7bQBG1b
         lPQ4d+PhIZSu+mEczvJQMVjdoZLsg/733PDTj11h62RkdePFNkYSUGBLYU7xINqAvKfX
         ttgl0NDxlAZEDJ+BRo5w6DvpqEvF/GKp5SUv1WN3OF04ldHkHIkZA5QnS89BUUYe0tYs
         jygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710292264; x=1710897064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZVTEdL4tspWGYZt6WUdOVkVxO9G+Bnl9WSMo6I37UI=;
        b=UyDXz3vbBUcfPLtL8SlGXtlL/6xzzQ5zSPyAp+KOX63dVTyhQrnYwDZ4hopn3/1Mwr
         sEvq00rch+i4UuS7JIy8Nm4OOQR3SnCEfdeqBbu5xVNIY79hyX2lmGbnTjKaL4McQFDf
         u8bDhjPEmD/UPlEeqf0t43wkVedzzndLeeGQbHhvzFnGh/v9GnGbRJ5z327bDxdDgIot
         RAbDG1FTqHzKlQmy6teucBsxxSVYfVEAa27dCf0iqrhtDolSB4jcyMb0o0ECHvo5PhYN
         zZTS2onnhcs+xeyLj1h7Q1/bvinZtJcJ6bEqUTte0R3AZsKtSaiI9RPU/XRtEeJtGenk
         HRHA==
X-Forwarded-Encrypted: i=1; AJvYcCXj1h1+7l0y3J4ygmxDYjDPWfVAk8vhBPZybCADzq2tGmWlercOgAL1rPT5j1s/TidRLfi6S19scFarXH64jmU03W+dr7+wW7E/SN+L
X-Gm-Message-State: AOJu0YzyMWPmJnS4VGtbFbiAqk2EFvzcpuhu+2LJTF/uCdRuNQNWSsbX
	N+mh/n+rhwGBH4Pl92fgWcEl493p0o3GvBs2DY+s+2R/5gpL0/RM+XhVNqoLY+0=
X-Google-Smtp-Source: AGHT+IF3xwXoWk7UDjbgIIi2TOB7cq2R7KvxH9ZhaPo/B3eQFdlHc8H6tyaNvFMqdYNDUub+oREQiA==
X-Received: by 2002:a05:6a00:198c:b0:6e6:673e:3447 with SMTP id d12-20020a056a00198c00b006e6673e3447mr1126901pfl.14.1710292263967;
        Tue, 12 Mar 2024 18:11:03 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:733c:479a:4b7b:f77b])
        by smtp.gmail.com with ESMTPSA id hq22-20020a056a00681600b006e635740126sm6747332pfb.112.2024.03.12.18.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:11:03 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:11:01 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Robin Ehn <rehn@rivosinc.com>, Stefan O'Rear <sorear@fastmail.com>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [PATCH] riscv: hwprobe: export highest virtual userspace address
Message-ID: <ZfD9JV51GER/8OOX@ghost>
References: <20240301164407.475957-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301164407.475957-1-cleger@rivosinc.com>

On Fri, Mar 01, 2024 at 05:44:06PM +0100, Clément Léger wrote:
> Some userspace applications (OpenJDK for instance) uses the free MSBs
> in pointers to insert additional information for their own logic and
> need to get this information from somewhere. Currently they rely on
> parsing /proc/cpuinfo "mmu=svxx" string to obtain the current value of
> virtual address usable bits [1]. Since this reflect the raw supported
> MMU mode, it might differ from the logical one used internally which is
> why arch_get_mmap_end() is used. Exporting the highest mmapable address
> through hwprobe will allow a more stable interface to be used. For that
> purpose, add a new hwprobe key named
> RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS which will export the highest
> userspace virtual address.
> 
> Link: https://github.com/openjdk/jdk/blob/master/src/hotspot/os_cpu/linux_riscv/vm_version_linux_riscv.cpp#L171 [1]
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> ---
> 
> v3:
>  - Note: I did not added Stefan Reviewed-by since I did more
>    modifications than just a simple respin.
>  - Handle CONFIG_MMU=n as well and rename the key to
>    RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS
>  - Add a user_max_virt_addr() macro to handle !MMU config
>  - Link to v2: https://lore.kernel.org/lkml/20240220110950.871307-1-cleger@rivosinc.com/
> 
> v2:
>  - Note: tried sysconf to export it but this is not backed by syscall
>    and thus does not allow exporting such information easily.
>  - Use arch_get_mmap_end() instead of VA_BITS since it reflects the
>    maximum logical address used by the riscv port
>  - Change hwprobe key name from RISCV_HWPROBE_KEY_VA_BITS to
>    RISCV_HWPROBE_KEY_MAX_ADDRESS
>  - Link to v1: https://lore.kernel.org/lkml/20240201140319.360088-1-cleger@rivosinc.com/
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 3 +++
>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>  arch/riscv/include/asm/processor.h    | 8 +++++++-
>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>  arch/riscv/kernel/sys_hwprobe.c       | 4 ++++
>  5 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index b2bcc9eed9aa..875d3122bd66 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -210,3 +210,6 @@ The following keys are defined:
>  
>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>    represents the size of the Zicboz block in bytes.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS`: An unsigned long which
> +  represent the highest userspace virtual address usable.
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
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index a8509cc31ab2..341863d4d989 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -14,7 +14,7 @@
>  
>  #include <asm/ptrace.h>
>  
> -#ifdef CONFIG_64BIT
> +#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
>  #define STACK_TOP_MAX		TASK_SIZE
>  
> @@ -58,6 +58,12 @@
>  
>  #define STACK_TOP		DEFAULT_MAP_WINDOW
>  
> +#ifdef CONFIG_MMU
> +#define user_max_virt_addr() arch_get_mmap_end(ULONG_MAX, 0, 0)
> +#else
> +#define	user_max_virt_addr() 0
> +#endif /* CONFIG_MMU */
> +
>  /*
>   * This decides where the kernel will search for a free chunk of vm
>   * space during mmap's.
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index 9f2a8e3ff204..3630e3f30354 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -67,6 +67,7 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
> +#define RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS	7
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>  
>  /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index a7c56b41efd2..560ea41a716d 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -8,6 +8,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
>  #include <asm/hwprobe.h>
> +#include <asm/processor.h>
>  #include <asm/sbi.h>
>  #include <asm/switch_to.h>
>  #include <asm/uaccess.h>
> @@ -202,6 +203,9 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>  		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
>  			pair->value = riscv_cboz_block_size;
>  		break;
> +	case RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS:
> +		pair->value = user_max_virt_addr();
> +		break;
>  
>  	/*
>  	 * For forward compatibility, unknown keys don't fail the whole
> -- 
> 2.43.0
> 

Looks like a great solution.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


