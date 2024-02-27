Return-Path: <linux-kernel+bounces-82510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FD5868591
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C631C20F72
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FF56139;
	Tue, 27 Feb 2024 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FgCAthic"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5F5667;
	Tue, 27 Feb 2024 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996201; cv=none; b=EyqAWqVxcpa9rW2lmOpbtcriRQipJMw/72qOBl5xPWoLMcsFBFkGlU6p43E8LlR8/kiHsQNnUJHExQm+Ipa1UEtM1kaObOzi1r55jSWfy+CFHWqAOrCllgwVduzMmFCoUR51f3D6GsPyaibcEswsNwSIy2YevX59SBTLf54OL8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996201; c=relaxed/simple;
	bh=u3pF9IuPzcNrvYdAT+1cDQgD9k9JyQ4Z1midFjBg6YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkTnduhKZwG1yyI3JAd5LQ65Y+9gDBT/u/VmKlAp80iYdljaUIRVbeA38KteJ9OEKpSDXAqzJLsIN3DVvXF291YKEQ/2kUiJtUZTNRs/jr6J/Z7Vu8nDS/LqRsTK/UnaRw8lO1sDO/LS9keBMebW021HbCLF6QqS/FDft0ceuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FgCAthic; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=gwiXT85stAdWTOUd6txuILwVivp2eGJBqmUEFcS5o58=; b=FgCAthicwmPNlQ+DMbEELBmK/I
	qUAzdjuLcWA2Bys4HwHthcbpwBzlNPwaS/tovAfOoew9JrEZFYjESxt+zGf8GkFapHxP9/SO/esq9
	bHcF/VwthH48hoKJXxy0LWHTdE9TbOnF3bJGbQkXPrKGnVbI83gQmS7rAZ+UCvS+MTjuKDVqPWq7L
	6H023rd4HQlenEZ+ZGEIPQvCzTnNks64kjPFKDR1Fk3MSf2LLPo/wY2dO1IMuuj+Ffy/jw98te5qy
	uxfagMnu+cQOjpgWnSf3CSb/QQb3G83xIV4aotv3un7jMKOheFwwVwCguDPGSOq/EvcNaNR/DoSr6
	eX/RJ77w==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1relyf-00000003Dq6-1hGA;
	Tue, 27 Feb 2024 01:09:59 +0000
Message-ID: <7624c14e-0f5c-435c-9f6e-3d59b4e27aa2@infradead.org>
Date: Mon, 26 Feb 2024 17:09:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Feb 26 (drivers/mtd/ubi/nvmem.c)
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mtd@lists.infradead.org
References: <20240226175509.37fa57da@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240226175509.37fa57da@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/25/24 22:55, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20240223:
> 

on powerpc32:

In file included from ./arch/powerpc/include/generated/asm/div64.h:1,
                 from ../include/linux/math.h:6,
                 from ../include/linux/kernel.h:27,
                 from ../arch/powerpc/include/asm/page.h:11,
                 from ../arch/powerpc/include/asm/thread_info.h:13,
                 from ../include/linux/thread_info.h:60,
                 from ../arch/powerpc/include/asm/ptrace.h:342,
                 from ../arch/powerpc/include/asm/hw_irq.h:12,
                 from ../arch/powerpc/include/asm/irqflags.h:12,
                 from ../include/linux/irqflags.h:18,
                 from ../include/asm-generic/cmpxchg-local.h:6,
                 from ../arch/powerpc/include/asm/cmpxchg.h:755,
                 from ../arch/powerpc/include/asm/atomic.h:11,
                 from ../include/linux/atomic.h:7,
                 from ../include/linux/rcupdate.h:25,
                 from ../include/linux/rbtree.h:24,
                 from ../drivers/mtd/ubi/ubi.h:14,
                 from ../drivers/mtd/ubi/nvmem.c:7:
./drivers/mtd/ubi/nvmem.c: In function 'ubi_nvmem_reg_read':
./include/asm-generic/div64.h:222:35: warning: comparison of distinct pointer types lacks a cast
  222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
      |                                   ^~
./drivers/mtd/ubi/nvmem.c:34:16: note: in expansion of macro 'do_div'
   34 |         offs = do_div(lnum, unv->usable_leb_size);
      |                ^~~~~~
In file included from ../include/linux/build_bug.h:5,
                 from ../include/linux/container_of.h:5,
                 from ../include/linux/list.h:5,
                 from ../drivers/mtd/ubi/ubi.h:13:
./include/asm-generic/div64.h:234:32: warning: right shift count >= width of type [-Wshift-count-overflow]
  234 |         } else if (likely(((n) >> 32) == 0)) {          \
      |                                ^~
./include/linux/compiler.h:76:45: note: in definition of macro 'likely'
   76 | # define likely(x)      __builtin_expect(!!(x), 1)
      |                                             ^
./drivers/mtd/ubi/nvmem.c:34:16: note: in expansion of macro 'do_div'
   34 |         offs = do_div(lnum, unv->usable_leb_size);
      |                ^~~~~~
./include/asm-generic/div64.h:238:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
  238 |                 __rem = __div64_32(&(n), __base);       \
      |                                    ^~~~
      |                                    |
      |                                    int *
./drivers/mtd/ubi/nvmem.c:34:16: note: in expansion of macro 'do_div'
   34 |         offs = do_div(lnum, unv->usable_leb_size);
      |                ^~~~~~
./include/asm-generic/div64.h:213:38: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'int *'
  213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
      |                            ~~~~~~~~~~^~~~~~~~




-- 
#Randy

