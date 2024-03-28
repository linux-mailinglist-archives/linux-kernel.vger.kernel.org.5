Return-Path: <linux-kernel+bounces-122435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25F088F763
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539E329598D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC37482C7;
	Thu, 28 Mar 2024 05:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+v8UuEh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4BA27459;
	Thu, 28 Mar 2024 05:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711604783; cv=none; b=KrkilPcIheQ95hdbhaPGgdS7W8SsHwiKrCqK2P0I6EiUTsDF8rQf7CrlN7jg9KCSazkYfIeBlUngiZMmUuQLPKKEp1rlay/5qCXIOSTL2ecyHtu3iIiaDcMw9hl5VLtIFLZb2pSdxv71yV+Z+j4JRZaMv5/qFlWI7QITzJkTmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711604783; c=relaxed/simple;
	bh=gxiY5UZLlWOxibFFRP8rSgWNhezHAFR/cKLxo5sMnvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3//duGuUmeJDawlDYM0vrz5mt0eaPXMh97mdHMIQg45J5ogtiV3RMfBe9P3Cswdw1pIoSa8Se7HGOycuIda7fRDs/zmtW+bY1fMgeHZZrNB+z8fwS3gvYW4UZDWhiiwyD72Z+FcTkiFUFKVVuYxsD4QUkxUdgA1glYFCb0tfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+v8UuEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD4AC433F1;
	Thu, 28 Mar 2024 05:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711604783;
	bh=gxiY5UZLlWOxibFFRP8rSgWNhezHAFR/cKLxo5sMnvw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L+v8UuEh5O1tRgEFJMJ5Frrf4/ID+uUfia8uNCp3PWr94ErWQFVIA9RJ/1Ji34rSh
	 nITbYuxDiU6daI4zgCWdKOc/Ef6ztJgQhOpDoykrvacACxsKwLB6A+7O/RNq3fAIvr
	 DY+Cvakh6ZYloDPjzy/tbNoDXFTPzbl1VtMZG56pcFE7cJdg0GfJktJzfOfPoJSIiS
	 yYkVd0Utalj5sB9tvwnJ2uL7kvRyKNpE456II0VPUkSb7TXxUKHjTYJ2jO32An7OZZ
	 VH9lC6DjHAMJrk4e8f/vpS9N666M/AmMOV3SsNiQhPuZ/Luc2WFAUM4uibZ88msq0p
	 aLE4q8CXiL67w==
Message-ID: <d22054a8-76d3-4ae2-9e20-38a7a8ce902d@kernel.org>
Date: Wed, 27 Mar 2024 22:46:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next: arc: defconfig - gcc-9 - mmu-arcv2.h:82:2: error: implicit
 declaration of function 'write_aux_reg'
 [-Werror=implicit-function-declaration]
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>,
 linux-mm <linux-mm@kvack.org>, linux-snps-arc@lists.infradead.org
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Morton <akpm@linux-foundation.org>, vgupta@kernel.org
References: <CA+G9fYu49=6_L6r8hdagZHUSGk+JfjioFaqh+kRaxhce84Q5Kw@mail.gmail.com>
Content-Language: en-US
From: Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <CA+G9fYu49=6_L6r8hdagZHUSGk+JfjioFaqh+kRaxhce84Q5Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/25/24 23:39, Naresh Kamboju wrote:
> The following arc defconfig build warnings / errors noticed on today's
> Linux next-20240326 tag.
>
> Regressions:
>     * arc - defconfig - gcc-9 build failed.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build log:
> ---------
> arch/arc/kernel/ptrace.c:342:16: warning: no previous prototype for
> 'syscall_trace_enter' [-Wmissing-prototypes]
>   342 | asmlinkage int syscall_trace_enter(struct pt_regs *regs)
>       |                ^~~~~~~~~~~~~~~~~~~
> arch/arc/kernel/kprobes.c:193:15: warning: no previous prototype for
> 'arc_kprobe_handler' [-Wmissing-prototypes]
>   193 | int __kprobes arc_kprobe_handler(unsigned long addr, struct
> pt_regs *regs)
>       |               ^~~~~~~~~~~~~~~~~~
> In file included from arch/arc/include/asm/mmu.h:21,
>                  from arch/arc/include/asm/pgtable.h:14,
>                  from include/linux/pgtable.h:6,
>                  from include/asm-generic/io.h:1047,
>                  from arch/arc/include/asm/io.h:232,
>                  from include/linux/io.h:13,
>                  from kernel/dma/coherent.c:6:
> arch/arc/include/asm/mmu-arcv2.h: In function 'mmu_setup_asid':
> arch/arc/include/asm/mmu-arcv2.h:82:2: error: implicit declaration of
> function 'write_aux_reg' [-Werror=implicit-function-declaration]
>    82 |  write_aux_reg(ARC_REG_PID, asid | MMU_ENABLE);
>       |  ^~~~~~~~~~~~~
> cc1: some warnings being treated as errors

Thx for the report. Fix posted for first 2 warnings [1]

I can't reproduce the last warning about write_aux_reg() despite using
the config from 3rd link below.

-Vineet

[1]
http://lists.infradead.org/pipermail/linux-snps-arc/2024-March/007916.html


>
> Steps to reproduce:
> -------
> # tuxmake --runtime podman --target-arch arc --toolchain gcc-9
> --kconfig defconfig
>
>
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240325/testrun/23149630/suite/build/test/gcc-9-defconfig/log
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240325/testrun/23149630/suite/build/test/gcc-9-defconfig/history/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2eA2VSZdDsL0DMBBhjoauN9IVoK/
>
> --
> Linaro LKFT
> https://lkft.linaro.org


