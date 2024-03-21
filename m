Return-Path: <linux-kernel+bounces-109505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6CD881A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BFF1C20E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCFE64F;
	Thu, 21 Mar 2024 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HyiVzWJU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B4EC3;
	Thu, 21 Mar 2024 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710979462; cv=none; b=Mx+j/Ec9/c+yErfvSyya5se0RkvM6jegZBfaq4UfdFGUvyl2/PvLNPWY05NW7JuLTmUjf4VF5Tapna+wIZh5ieRaruGFO8Y98NHH1y9Qt3WmpQXGlQ2wZJEqp+LGGv1Vvp5g49PMqQ0/F5MDWnDXZks3rl3PgmPFn02NJGxc+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710979462; c=relaxed/simple;
	bh=ipxsqMwMInyb4v842p8SuYV8PcroMNKWjBSmmFM49EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdifEZcr5xBA1O5rFB814fIY85TmhdTjWTvqw4Sp28GboI1zg+Uzpw2ugiJ1C9wSWuOZpzRXgGtghGROCmNg678Va8Tsx+i66HNMJUKmL8fV73NjDgiBXl2JG1cyZX8f+MtI1L1O//Zm/kufSj/6KnOhfEA0jSentYFYfUfzVxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HyiVzWJU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=AuTy0DBYYdG/QKWrIh0uagTUXUFOgXWy8+vXQ7SNEJg=; b=HyiVzWJUKN7zEobwCSfi5HSpo8
	+qncGtgXNEe8ND8EP7iESrJwebcnFQ7UO1NaP1y9w+ggyVBvnSTRIs00CKQaYz1qUrjQavuym+Q59
	ErKVvwWvs9RGnWA16WZEpMfAWrbH/A9I99bRvzob1FvUmd7/y9seJi9FkoS+diObsYDI4molelB8i
	TVJ/4N3YosCxpq6guZAnN8IxTbdoI5qRiegSVQuOsoo0hOukfbPQm2eiJYwu2iin6IoLpdeTOPVh4
	7fK+ahU5aAULDrKaXfML1vgGvgSLoXAmCs2hti2cszJa8BcR8lywPlSJV/dxjq1QlJ2CYf5slz5xS
	4Sf0bblw==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.8])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn5uG-00000005TT9-33Nm;
	Thu, 21 Mar 2024 00:03:41 +0000
Message-ID: <5a40e58c-b38d-4bbd-8376-ebdc0c2cc47b@infradead.org>
Date: Thu, 21 Mar 2024 09:03:29 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: ps3: mark ps3_notification_device static for
 stack usage
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Chancellor <nathan@kernel.org>, Paul Mackerras <paulus@ozlabs.org>,
 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kevin Hao <haokexin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240320180333.151043-1-arnd@kernel.org>
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <20240320180333.151043-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/24 03:03, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The device is way too large to be on the stack, causing a warning for
> an allmodconfig build with clang:
> 
> arch/powerpc/platforms/ps3/device-init.c:771:12: error: stack frame size (2064) exceeds limit (2048) in 'ps3_probe_thread' [-Werror,-Wframe-larger-than]
>   771 | static int ps3_probe_thread(void *data)
> 
> There is only a single thread that ever accesses this, so it's fine to
> make it static, which avoids the warning.
> 
> Fixes: b4cb2941f855 ("[POWERPC] PS3: Use the HVs storage device notification mechanism properly")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/platforms/ps3/device-init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
> index 878bc160246e..ce99f06698a9 100644
> --- a/arch/powerpc/platforms/ps3/device-init.c
> +++ b/arch/powerpc/platforms/ps3/device-init.c
> @@ -770,7 +770,7 @@ static struct task_struct *probe_task;
>  
>  static int ps3_probe_thread(void *data)
>  {
> -	struct ps3_notification_device dev;
> +	static struct ps3_notification_device dev;
>  	int res;
>  	unsigned int irq;
>  	u64 lpar;

Seems fine.

Acked-by: Geoff Levand <geoff@infradead.org>


