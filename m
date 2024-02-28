Return-Path: <linux-kernel+bounces-85706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 513CD86B99E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A748BB26113
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408F58626E;
	Wed, 28 Feb 2024 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqWX1w8k"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C991A86248;
	Wed, 28 Feb 2024 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154386; cv=none; b=nrepMUTPYM3lEDXJC9TszdyNpMWezTm0et0qYDxVxPK8vceaSwlGfSFzA31UAyGklN1IEREe8vPsnWA3XQ2GHmZuVsjsKBz0gEh4PJCEN3WrBzNWRjwbuvi7yowUgKChetSzyw3ZULGF9NJbBAS/HqKgQcvGzk/5a2+JOBFf92c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154386; c=relaxed/simple;
	bh=KnopYAd5eQKEby5VAzV5cjLQUuk9vdF/QgTymLF2AQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck1y9kVWJkORfqXAM2BzmGZfnPhPA7Gdm2EL56FeM7BxOVjR9dBY59f0fzNwXHPcXInR6Q08RyhUHmAHG+A2BaUxgDsPthExQPCVPvQFp/skexpQLMG5Xcvj+XhpNvA7nWIJFse51s33kfv8J+lbU1EC/4mxILT0P0FMXO10svc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqWX1w8k; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d6f1f17e5so122441f8f.3;
        Wed, 28 Feb 2024 13:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709154383; x=1709759183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0a8qBD6vozPIAISnQHJRWdPKOWiVN4p5/6pJZQ2dXnQ=;
        b=OqWX1w8kHwCQYXdkCxNjkAQNbg4Un52uFynZh9KWAuo0Mg0yufkEJLg8+QGrR2zl+N
         bUVNl4B36a2m5dfVxWPTQX8LSGAxZ5U/rnCq5XKgpuBCE2cX86uZuSq0O1dzQsRrFR/v
         a6iKolcy7LoX6oK11F8J3i7dWamFYW6/uVq6HleodcXIe/8M3Hsxh+7luhUZZJEMu2x2
         asAY7rK9p/+Tn4zAj/6f774PkyekMZAKF2NLs5RQx8EHrakYC590S9KfYC7w/I0qOQag
         eosKGXOlF22OQ/1L9V9DI9kVxD+qQoxqf7b1J0Mmi3Y3PW5RQhzfHuF0Q5l5Lq8sfbOv
         vLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709154383; x=1709759183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0a8qBD6vozPIAISnQHJRWdPKOWiVN4p5/6pJZQ2dXnQ=;
        b=QTKUa/AQt16od3drKCrR+9Ndt8RnArK9ta16WxcwMUyubc3LyZ3KuyZv2HdTaGKhbR
         dIAOQ8dME51JQrU0R67dPFp83GGaRqwxHn97QUmZ3YpX8VVkIcZLv/FK7QacGrXOPUcY
         UL55o9RUKp4S1WNq7Uu1JBjn/7kiFpaClJvDfrbiMqZrqSa/e7o2Q0a9FktIMpAUld3i
         CUqbntMoVP4wSJBCwM8+gDQ3hop2a95BuRQ3lmEnVFfUQkrz7JN+tQTNSfKRiRp/A9fc
         mf1/fNrhCjT9Tkff84Jnf4DJoqMiQ1oYL/xND4x1sKDLgM1AqKy6MeiW5or8hDhRR4ui
         hPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwV96jXs9VLnTWCaSA9CbWYUaIQkbyRZDiLMdbQ62qYaJG7jFvJjU6zELi7sB2y0hM8MEAnhjTkgEtxcFjDVsELB+X9r4Y9luPG628XhW/OxAEw5U1kTb0yvUemwqn+AhmW6N03NoZ2uMKjWM38cRSsAXQjs+IXdApDKZ3TUELkq/VqwjkDWBrPUYDq589x5+30lgB7Mhkhpmog3niAmO4PSQoUqoIVIrCkVpIMdjKHC4Y+IW/CfZBfzudN5zrLuN2zZtnm5fqpGke/G028K+smnPptuPQCYMWr0b48aSvKCfUwu8U8Hcmf/hCb0uUWAOgm4pPo0pm0hztCAe+M8GuwggOnxKnbFelFUjLURaW72GxFGWhk3dJ8hChoNk5IE3yB7E4n6H+bTzP9hqMVDhjdCics6br6jLvyQfcQwkXYCkzo3j34oAv9Z4IwbQDtHk=
X-Gm-Message-State: AOJu0Yyt5x/xkYD0dT17lBEvwQYDbxWaNgQceSVc+iQP4+8dFC5UCxSP
	UntYBUYDHaaUH3I/k64+ev0yXmlVwtGWYg4cWuhTssJnrtfpZzDe
X-Google-Smtp-Source: AGHT+IHczATb7A8ZRTaH383CIQ4ejybI9MzL/yjlqycOyBbx2+IYQRI3gE2POfqlKMAC8LKmr3GeXg==
X-Received: by 2002:a5d:618d:0:b0:33d:f51f:2da5 with SMTP id j13-20020a5d618d000000b0033df51f2da5mr46406wru.7.1709154383088;
        Wed, 28 Feb 2024 13:06:23 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id m1-20020adfa3c1000000b0033d67791dc0sm15568132wrb.43.2024.02.28.13.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:06:21 -0800 (PST)
Date: Wed, 28 Feb 2024 21:06:21 +0000
From: Stafford Horne <shorne@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>, x86@kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH 3/4] arch: define CONFIG_PAGE_SIZE_*KB on all
 architectures
Message-ID: <Zd-gTf6mvVdPEovO@antec>
References: <20240226161414.2316610-1-arnd@kernel.org>
 <20240226161414.2316610-4-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226161414.2316610-4-arnd@kernel.org>

On Mon, Feb 26, 2024 at 05:14:13PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most architectures only support a single hardcoded page size. In order
> to ensure that each one of these sets the corresponding Kconfig symbols,
> change over the PAGE_SHIFT definition to the common one and allow
> only the hardware page size to be selected.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/alpha/Kconfig                 | 1 +
>  arch/alpha/include/asm/page.h      | 2 +-
>  arch/arm/Kconfig                   | 1 +
>  arch/arm/include/asm/page.h        | 2 +-
>  arch/csky/Kconfig                  | 1 +
>  arch/csky/include/asm/page.h       | 2 +-
>  arch/m68k/Kconfig                  | 3 +++
>  arch/m68k/Kconfig.cpu              | 2 ++
>  arch/m68k/include/asm/page.h       | 6 +-----
>  arch/microblaze/Kconfig            | 1 +
>  arch/microblaze/include/asm/page.h | 2 +-
>  arch/nios2/Kconfig                 | 1 +
>  arch/nios2/include/asm/page.h      | 2 +-
>  arch/openrisc/Kconfig              | 1 +
>  arch/openrisc/include/asm/page.h   | 2 +-
>  arch/riscv/Kconfig                 | 1 +
>  arch/riscv/include/asm/page.h      | 2 +-
>  arch/s390/Kconfig                  | 1 +
>  arch/s390/include/asm/page.h       | 2 +-
>  arch/sparc/Kconfig                 | 2 ++
>  arch/sparc/include/asm/page_32.h   | 2 +-
>  arch/sparc/include/asm/page_64.h   | 3 +--
>  arch/um/Kconfig                    | 1 +
>  arch/um/include/asm/page.h         | 2 +-
>  arch/x86/Kconfig                   | 1 +
>  arch/x86/include/asm/page_types.h  | 2 +-
>  arch/xtensa/Kconfig                | 1 +
>  arch/xtensa/include/asm/page.h     | 2 +-
>  28 files changed, 32 insertions(+), 19 deletions(-)
...
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index fd9bb76a610b..3586cda55bde 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -25,6 +25,7 @@ config OPENRISC
>  	select GENERIC_CPU_DEVICES
>  	select HAVE_PCI
>  	select HAVE_UID16
> +	select HAVE_PAGE_SIZE_8KB
>  	select GENERIC_ATOMIC64
>  	select GENERIC_CLOCKEVENTS_BROADCAST
>  	select GENERIC_SMP_IDLE_THREAD
> diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
> index 44fc1fd56717..7925ce09ab5a 100644
> --- a/arch/openrisc/include/asm/page.h
> +++ b/arch/openrisc/include/asm/page.h
> @@ -18,7 +18,7 @@
>  
>  /* PAGE_SHIFT determines the page size */
>  
> -#define PAGE_SHIFT      13
> +#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
>  #ifdef __ASSEMBLY__
>  #define PAGE_SIZE       (1 << PAGE_SHIFT)
>  #else

For the openrisc bits,

Acked-by: Stafford Horne <shorne@gmail.com>

