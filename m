Return-Path: <linux-kernel+bounces-135583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F8A89C7F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765BD1C224BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E313F458;
	Mon,  8 Apr 2024 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CYWjBrT3"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC8B13F439
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589369; cv=none; b=W/QE+W9ugvnC5+YlWV1vs/gyB4GdLnnYCrm41/pxtDXDA0o837HkEMJfXF0e2fqYP5ppOqXN35HMd8dw6BFD09GV76kwHa8E8+it4YwvRRsXkjnxXkd7Zt4kQwbhKNCn6RqGs+BPnNH4wMrOdfFaDU+aWQEBvdYMK8mKqFqF6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589369; c=relaxed/simple;
	bh=xQ+DkAtcWeRrKwW6BgPQ6Wxzn50AV0nL8WqLFmYlEEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3tkVdA2XwWqFi5rgMUKc8f1q7MgQVE13nbei3Nh9AToqIf0j2Ys6gvrW2tj/WDmHDt0TDNthFzzAsuyue3ievASokM1C4UydbJgYhyUdOexud5aRv0kaKsRyR3Xix9GH9Pf2NiPRLbMEsa2LUJSmLMDTF9VL7+Qw1addBKJHDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CYWjBrT3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ank4NMo0tMOsvsZKPxmhfr9ZiRm9h5CIvfJM5C8UMkw=; b=CYWjBrT3mgKQB/fI+Fy50FMMxh
	mrprDMPN3zNdYEN9H0lA/4wcDoClx7stMGrhAjQS4hkORYa2qup79ex7sfDdhLyNwXkHBdBw7QSbw
	Xzw5ytjmTtEB8EBdwF3M3LGP+g+5hhvma65zNyMc4NrkkbJG6RIXLaNmFiAU6VX5nZr9FnmLxKU8r
	dfoRmGwIMYYPvY2Bj7G65PoKWUBrSAYplWKos63LC9A7f7VImotpwdxI+Dq2hchC0VyFIGAB56A00
	p5fNaUp8rRhOAAmtSzqx+fOUdcNInov2dGPaMTJN6MLL4uN5+ZoMCDVVQvcu+U7M3insqoLzmwn/4
	80WrkbQA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtqj2-0000000Fzyh-41mP;
	Mon, 08 Apr 2024 15:16:01 +0000
Message-ID: <e2ca307d-1d8a-49e9-b374-73ec50965464@infradead.org>
Date: Mon, 8 Apr 2024 08:15:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/3 v2] powerpc: Fix kernel-doc comments in
 fsl_gtm.c
To: Yang Li <yang.lee@linux.alibaba.com>, arnd@arndb.de, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240408053109.96360-1-yang.lee@linux.alibaba.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240408053109.96360-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/24 10:31 PM, Yang Li wrote:
> Fix some function names in kernel-doc comments.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/powerpc/sysdev/fsl_gtm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_gtm.c b/arch/powerpc/sysdev/fsl_gtm.c
> index 39186ad6b3c3..3dabc9621810 100644
> --- a/arch/powerpc/sysdev/fsl_gtm.c
> +++ b/arch/powerpc/sysdev/fsl_gtm.c
> @@ -77,7 +77,7 @@ struct gtm {
>  static LIST_HEAD(gtms);
>  
>  /**
> - * gtm_get_timer - request GTM timer to use it with the rest of GTM API
> + * gtm_get_timer16 - request GTM timer to use it with the rest of GTM API
>   * Context:	non-IRQ
>   *
>   * This function reserves GTM timer for later use. It returns gtm_timer
> @@ -110,7 +110,7 @@ struct gtm_timer *gtm_get_timer16(void)
>  EXPORT_SYMBOL(gtm_get_timer16);
>  
>  /**
> - * gtm_get_specific_timer - request specific GTM timer
> + * gtm_get_specific_timer16 - request specific GTM timer
>   * @gtm:	specific GTM, pass here GTM's device_node->data
>   * @timer:	specific timer number, Timer1 is 0.
>   * Context:	non-IRQ
> @@ -260,7 +260,7 @@ int gtm_set_timer16(struct gtm_timer *tmr, unsigned long usec, bool reload)
>  EXPORT_SYMBOL(gtm_set_timer16);
>  
>  /**
> - * gtm_set_exact_utimer16 - (re)set 16 bits timer
> + * gtm_set_exact_timer16 - (re)set 16 bits timer
>   * @tmr:	pointer to the gtm_timer structure obtained from gtm_get_timer
>   * @usec:	timer interval in microseconds
>   * @reload:	if set, the timer will reset upon expiry rather than

-- 
#Randy

