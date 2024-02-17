Return-Path: <linux-kernel+bounces-69659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C3F858CE5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796411F25709
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3371D54F;
	Sat, 17 Feb 2024 01:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vg95R0lh"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8780A1D537
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708134389; cv=none; b=AikoZGe0p66v1DkT78Dvduqpi/SCWSa+sDKDkVD4IIMlrWCm0GAkJ/Enj8aRyNw5OGeTsBDSA1caeT/p/X8/beaF95xwJYPPaIgNQSJjvVKZHYx4gsP6waDXcihVwV22sbD95+wsQIKGWQZdWxcx990Np5t70xXniq9STsa01fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708134389; c=relaxed/simple;
	bh=ebtkhZa9f8zdVomsb1q0aUWFOJmg84ZTw+4BmJGHN5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FglB0aD7xmGXhuPe0VWsk4G9Yx3w8V/RYpEOUyLz0oCk5QaHBvywWJBiXs6DiUBNOaYpn328OEqEXDEeiTvysY3bIQgWpJlbbaKoUUFHynqgesNQFqTi1bLrR1gEVFnOpFGi0991z9cP71MAgu6TcqImPFjKk3EL4d1Odrf+M6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vg95R0lh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=mW+9H2smD/H8mX4e4XCousTPiUmSsQuKkNGqqdye5Xc=; b=vg95R0lhtgCX+vYR15NytJy+b9
	r3nz1FWWKApJrUTauGa8jOWlzpPIOhVOSN4RHVGpjmJL3HvEe2tBaVgErc465JYhyY/kJFfoBiQ6R
	hsf6GTqtXE1dOML2oFnpsFrVQ1UV4mA+/69nO5gdb4m+v/y5A+4+TdWE2QGt5Y76gkCdw3x/J//v9
	uq40SCU/iV3/zrxNwAih0nN/s31irTgcJ3lDdhCLi8Dk/PUANTwhhOl62hg2N2IvYtJHOxjpP0y4R
	DKOKrplXvg2WiTJ8yO1qWtO7UlFm8WEdAXKwtmiKQCil0Oe3GVmzHztsSb8Sji8dqvlJbOTBzr5LD
	U4Kj51oA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb9mY-00000004R4o-2H6Q;
	Sat, 17 Feb 2024 01:46:22 +0000
Message-ID: <158119e5-43e2-43bb-879a-f83ed6057007@infradead.org>
Date: Fri, 16 Feb 2024 17:46:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: fix building without CONFIG_KVM
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Xin Li <xin@zytor.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240216202527.2493264-1-arnd@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240216202527.2493264-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/16/24 12:25, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Some constants are only defined if KVM is enabled:
> 
> arch/x86/entry/entry_fred.c:117:9: error: use of undeclared identifier 'POSTED_INTR_VECTOR'
>   117 |         SYSVEC(POSTED_INTR_VECTOR,              kvm_posted_intr_ipi),
>       |                ^
> arch/x86/entry/entry_fred.c:118:9: error: use of undeclared identifier 'POSTED_INTR_WAKEUP_VECTOR'
>   118 |         SYSVEC(POSTED_INTR_WAKEUP_VECTOR,       kvm_posted_intr_wakeup_ipi),
>       |                ^
> arch/x86/entry/entry_fred.c:119:9: error: use of undeclared identifier 'POSTED_INTR_NESTED_VECTOR'
>   119 |         SYSVEC(POSTED_INTR_NESTED_VECTOR,       kvm_posted_intr_nested_ipi),
>       |                ^
> 
> Hiding the references behind the same preprocessor conditional is
> probably the best fix here.
> 
> Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/x86/entry/entry_fred.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
> index ac120cbdaaf2..660b7f7f9a79 100644
> --- a/arch/x86/entry/entry_fred.c
> +++ b/arch/x86/entry/entry_fred.c
> @@ -114,9 +114,11 @@ static idtentry_t sysvec_table[NR_SYSTEM_VECTORS] __ro_after_init = {
>  
>  	SYSVEC(IRQ_WORK_VECTOR,			irq_work),
>  
> +#if IS_ENABLED(CONFIG_KVM)
>  	SYSVEC(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
>  	SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	kvm_posted_intr_wakeup_ipi),
>  	SYSVEC(POSTED_INTR_NESTED_VECTOR,	kvm_posted_intr_nested_ipi),
> +#endif
>  };
>  
>  static bool fred_setup_done __initdata;

-- 
#Randy

