Return-Path: <linux-kernel+bounces-123430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6546189087D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9635D1C294C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B786136E1A;
	Thu, 28 Mar 2024 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LdHR18D+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F07E115;
	Thu, 28 Mar 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651573; cv=none; b=qp+5qaDEwMfUIdNHGVltDfkHCgioWd0JfwzfdbO0xMz/T2GVh8e5QmUEK07kOjP3BIVqVPxcMw16H9bcrVBtNt/DMAI0JpQulr3NbXVuFxg8VJkndMWDj/+VfGBvDlvtnKSE7bbmmdWsFQXLch2P6D88b/5jGYch9DiWIP3noAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651573; c=relaxed/simple;
	bh=r9sPgfprQr4ss5yOQRQ+LuOkNETi9+8h/ITL1cLkamo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tgYMYGs7aWBN0OMcJ0PCa7zY7vjJpNnJu8AKaBk01FRA64U5C0uPHQrJQEUbLq4kAFT6Z4H67522ZWs0TRogQUF+1J/yF3HxBxEgUYZRoE/noVJOmOJqfr8xHX7kbVxAOuJ14PLDb/rcwcZ8z0ha0nhiXutHykJYPDVI6jbHk7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LdHR18D+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C88C433C7;
	Thu, 28 Mar 2024 18:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711651573;
	bh=r9sPgfprQr4ss5yOQRQ+LuOkNETi9+8h/ITL1cLkamo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LdHR18D+vl35xAZ8PoRaL+NhkViGAemYSCiROgu6PEwl0+nyTZD+42wut061xBmeC
	 6g3Ztc66LxXtoLnUUmXABlSFwF7Rg/ZXKi64ykyqyE41OcycuD1HdN2mGC9rnwiLv2
	 /isOduoShBIG+Ej4piZULRL6sIyoxXagFJqs7eGY=
Date: Thu, 28 Mar 2024 11:46:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-mm <linux-mm@kvack.org>, Linux Regressions
 <regressions@lists.linux.dev>, willy@infradead.org, Arnd Bergmann
 <arnd@arndb.de>
Subject: Re: next: sh: mm/cache-sh4.c:250:51: error: too few arguments to
 function 'folio_flags'
Message-Id: <20240328114612.d60b7ad4eb552281bedbff10@linux-foundation.org>
In-Reply-To: <CA+G9fYvB6unkhzFomVcg+M14Cc7xSKkzhMuXaWqZQbDej_aduQ@mail.gmail.com>
References: <CA+G9fYvB6unkhzFomVcg+M14Cc7xSKkzhMuXaWqZQbDej_aduQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 19:12:26 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> While building sh defconfig with gcc-11 the following build warnings /
> errors noticed on Linux next-20240328 tag.
> 
> sh:
>   build:
>     * gcc-11-shx3_defconfig  - Failed
>     * gcc-11-dreamcast_defconfig - Failed
>     * gcc-11-defconfig - Failed
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build error:
> ---------
> arch/sh/kernel/cpu/sh4/fpu.c:389:6: warning: no previous prototype for
> 'float_raise' [-Wmissing-prototypes]
>   389 | void float_raise(unsigned int flags)
>       |      ^~~~~~~~~~~
> arch/sh/kernel/cpu/sh4/fpu.c:394:5: warning: no previous prototype for
> 'float_rounding_mode' [-Wmissing-prototypes]
>   394 | int float_rounding_mode(void)
>       |     ^~~~~~~~~~~~~~~~~~~
> In file included from include/linux/thread_info.h:27,
>                  from include/asm-generic/preempt.h:5,
>                  from ./arch/sh/include/generated/asm/preempt.h:1,
>                  from include/linux/preempt.h:79,
>                  from include/linux/spinlock.h:56,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:7,
>                  from include/linux/mm.h:7,
>                  from arch/sh/mm/cache-sh4.c:14:
> arch/sh/mm/cache-sh4.c: In function 'sh4_flush_cache_page':
> arch/sh/mm/cache-sh4.c:250:51: error: too few arguments to function
> 'folio_flags'
>   250 |                         test_bit(PG_dcache_clean, folio_flags(folio)) &&
>       |                                                   ^~~~~~~~~~~
> 

Thanks.

--- a/arch/sh/mm/cache-sh4.c~sh-remove-use-of-pg_arch_1-on-individual-pages-fix
+++ a/arch/sh/mm/cache-sh4.c
@@ -247,7 +247,7 @@ static void sh4_flush_cache_page(void *a
 		 * another ASID than the current one.
 		 */
 		map_coherent = (current_cpu_data.dcache.n_aliases &&
-			test_bit(PG_dcache_clean, folio_flags(folio)) &&
+			test_bit(PG_dcache_clean, folio_flags(folio, 0)) &&
 			page_mapped(page));
 		if (map_coherent)
 			vaddr = kmap_coherent(page, address);
_


