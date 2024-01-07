Return-Path: <linux-kernel+bounces-18970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAAA8265D6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D494CB21233
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFB81170A;
	Sun,  7 Jan 2024 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jtgW04aF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD111706
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 245F440E01F9;
	Sun,  7 Jan 2024 19:47:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id O5-U9mV-3SS6; Sun,  7 Jan 2024 19:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704656852; bh=kqESimdcXy57y8GBtFttloiGQkW4AhZT/hHCXZDbvZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jtgW04aFLcX3afBxceVCZklNSktZ7Xv+409DcrmdrGuYn6rcM2LfPAD3MCqRLdsjM
	 Qhhq8qYMspMPIrD5pGiliR/nN37BVfqJedzXvepaHoSrhmVSlfzgZYdPoNHlwBZR51
	 2ELHjfOjG8Wtp7QNB13wYigt8X9zn1h32YH/qbo2T2R8gwEIbHO/MUy0A5hLUzCNKR
	 ymfHcPRHakqSup5kYE0wSKwlxyP65qleYd4B3DyUEByTXkCWfof2rzKs2htd9zf2gA
	 d3cbtlQMug747iHA24X2qmCzDMGb0yd63fwhf5KAzlsDgO1ybPJE/g2eisb+Tk6zeM
	 MyoT0Wjlj7CIxPE5x+ipChzc/n8OErBXvZljWn53gR3kIlJgcnWSWNVEEWR5eZYead
	 +hZEp9AwEW9NH+PBkUi5IqawixJRy4yQh/Cbe8K1msn6io0qAvUj10zY3QSNiccdaq
	 /l8ZXCmdCKiE+qMveTTgH5UreRDN34OihkaX/X0V7vrVD7jULDoENJ4Bm+ZAt6NZGv
	 buVmS6DqkBORuElWlyhEzQ9jn0D544Sy7m+su4De2aDIKnmQhD37E6kTrX1+6vGug7
	 mt1RJI916Sc6NIe95f7KkHgQ0qmTlwHh/orLQR7Lmg/QpC4KwVSNnvhu9huPAvTbEb
	 SrB286Uoa9gKR6D+KB3npMuE=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B5B440E00C5;
	Sun,  7 Jan 2024 19:47:25 +0000 (UTC)
Date: Sun, 7 Jan 2024 20:47:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Aleksander Mazur <deweloper@wp.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/Kconfig: Transmeta Crusoe is cpu family 5, not 6
Message-ID: <20240107194716.GDZZr/xBl3+G8O7i7E@fat_crate.local>
References: <1517697968-19014-3-git-send-email-tedheadster@gmail.com>
 <20240107140609.2c1709e3@mocarz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240107140609.2c1709e3@mocarz>

On Sun, Jan 07, 2024 at 02:16:57PM +0100, Aleksander Mazur wrote:
> I found out I am no longer able to boot kernel compiled with CONFIG_MCRUSOE=y on
> my HP t5300 with CPU: Transmeta(tm) Crusoe(tm) Processor TM5500 (family: 0x5,
> model: 0x4, stepping: 0x3). It says:
> 
> > This kernel requires an i686 CPU, but only detected an i586 CPU.
> > Unable to boot - please use a kernel appropriate for your CPU.    
> 
> It looks like this is caused by 25d76ac888216c369dea91768764728b83769799 which
> started setting X86_MINIMUM_CPU_FAMILY=6 for MCRUSOE while CPUID gives family=5.
> 
> I was able to fix the problem with a patch included below. It just changes
> X86_MINIMUM_CPU_FAMILY to 5

... for MCRUSOE.

> No other change was necessary (using -march=i686
> seems fine).
> 
> /proc/cpuinfo:
> processor	: 0
> vendor_id	: GenuineTMx86
> cpu family	: 5
> model		: 4
> model name	: Transmeta(tm) Crusoe(tm) Processor TM5500
> stepping	: 3
> cpu MHz		: 532.091
> cache size	: 256 KB
> fdiv_bug	: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 1
> wp		: yes
> flags		: fpu vme de pse tsc msr cx8 sep cmov mmx longrun lrti constant_tsc cpuid
> bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs itlb_multihit mmio_unknown
> bogomips	: 1064.18
> clflush size	: 32
> cache_alignment	: 32
> address sizes	: 32 bits physical, 32 bits virtual
> power management:
> 
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -375,7 +375,7 @@
>  config X86_MINIMUM_CPU_FAMILY
>  	int
>  	default "64" if X86_64
> -	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCRUSOE || MCORE2 || MK7 || MK8)
> +	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || MK7 || MK8)
>  	default "5" if X86_32 && X86_CMPXCHG64
>  	default "4"

Care to turn this into a proper patch with your SOB etc?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

