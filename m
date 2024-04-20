Return-Path: <linux-kernel+bounces-152241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E504C8ABB49
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44684B2137A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4CD2941F;
	Sat, 20 Apr 2024 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuCv8B1w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880D1C294
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713611866; cv=none; b=pLMXGByaei9pDxBdxjppNkavwFiSe2ZPRtC1jNsF4g/G2hBkAipK7Bdhq8A3SnHLojtylK316o+0CNGvukFMWuVsQbDzS7CyqfU0813Q2f4mc6uRTUq6aujKv+NLqveQwo1kY6tBEKfq67uaiGestuhUOX08B/1eaSBW3zEbM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713611866; c=relaxed/simple;
	bh=p3oWmVyGlcLLzHs5KM/jHHXQg4aBBYt9qMr0gvutLek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7hKCbTvuXBdZgj3yaWlSZTR1JIKkERXPeA4cxWNX8uIFQ5kq3wDnHRPhpY7kyGtDx0HNfyOhgEL3WZ6nVjvtPPdFBQ+Bs6TzWtDL8ikU/uSrDyJqxFKEjyerx2W0V6Z96fwpAnlvZRc8dZnZ2NHiDwIP1GtS1JoYEV9TQyzq/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuCv8B1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA11C072AA;
	Sat, 20 Apr 2024 11:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713611865;
	bh=p3oWmVyGlcLLzHs5KM/jHHXQg4aBBYt9qMr0gvutLek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VuCv8B1wSmn3Cb5VZNbpxNPm4YYVc8guYhcxwtgZKhau6PXoW44JSJ+5BlWHxoPOR
	 kc7DGfQLCLG/lytqZeo7FHkPbLV3UbXXfCGAhErDpJgEQIUw9dnKduZBY5LEXrelp+
	 TZGGVkXANV1QvflZ/e9cyVz68x9Vr1m9LlnQRqgOqC49KjEMl2XVSH5u/IMZgNby3w
	 35XePNlBH6/InzTXd/kOc7Z7ZdNIlHBfbZa8yskolPc8T7NKQsupqpwWLHiAgIcZM6
	 okBbyXh0KFl6SGhwKzbwkKpwTZy8SbWdaLlAXwRb+1I6jR0e+o5/n4ZQL4uDibKEng
	 I9zJJ0BGAhWDg==
Date: Sat, 20 Apr 2024 19:04:18 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	cleger@rivosinc.com
Subject: Re: [PATCH v3 0/2] riscv: improve nommu and timer-clint
Message-ID: <ZiOhMnZ1fdzj2IzE@xhacker>
References: <20240410142347.964-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410142347.964-1-jszhang@kernel.org>

On Wed, Apr 10, 2024 at 10:23:45PM +0800, Jisheng Zhang wrote:
> As is known, the sophgo CV1800B contains so called little core, which
> is C906 w/o MMU, so I want to run nommu linux on it. This series is
> the result of the bring up. After this series, w/ proper dts, we can
> run nommu linux on milkv duo's little core.
> 
> First of all, patch1 removes the PAGE_OFFSET hardcoding by introducing
> DRAM_BASE Kconfig option.
> 
> Secondly, to use the T-HEAD C9xx clint in RISCV-M NOMMU env, we need
> to take care two points:
> 
> 1.The mtimecmp in T-Head C9xx clint only supports 32bit read/write,
> implement such support.
> 
> 2. As pointed out by commit ca7810aecdba ("lib: utils/timer: mtimer:
> add a quirk for lacking mtime register") of opensbi:
> 
> "T-Head developers surely have a different understanding of time CSR and
> CLINT's mtime register with SiFive ones, that they did not implement
> the mtime register at all -- as shown in openC906 source code, their
> time CSR value is just exposed at the top of their processor IP block
> and expects an external continous counter, which makes it not
> overrideable, and thus mtime register is not implemented, even not for
> reading. However, if CLINTEE is not enabled in T-Head's MXSTATUS
> extended CSR, these systems still rely on the mtimecmp registers to
> generate timer interrupts. This makes it necessary to implement T-Head
> C9xx CLINT support in OpenSBI MTIMER driver, which skips implementing
> reading mtime register and falls back to default code that reads time
> CSR."
> 
> So, we need to fall back to read time CSR instead of mtime register.
> Add riscv_csr_time_available static key for this purpose.
> 
> The second patch adds T-Head C9xxx clint support to timer-clint driver
> by taking care of above two points.
> 
> Since v2:
>   - drop CONFIG_CLINT_USE_CSR_INSTEADOF_MTIME, instead we use runtime
>     code patch to dynamically enable CSR TIME code path or MTIME code
>     path.
> 
> Since v1:
>   - fix c900_clint_timer_init_dt() defined but not used build warning
>   - add option CONFIG_CLINT_USE_CSR_INSTEADOF_MTIME instead of removing
>     mtime usage for all platforms, since not all platforms implement the
>     time CSR in HW in M mode.
>   - rebase on the timer-clint improvement series
> https://lore.kernel.org/linux-riscv/20240406111757.1597-1-jszhang@kernel.org/T/#t

Hi Palmer, Daniel,

This series itself relies on the timer-clint improvement series
https://lore.kernel.org/linux-riscv/20240406111757.1597-1-jszhang@kernel.org/T/#t

But as suggested by Clément, it's better to rebase the patch1 on
the Samuel's work which has been merged into riscv for-next,
So I have two dependencies now, how do I handle this series then?

Could I leave patch1 alone and move patch2 into the timer-clint
improvement series? Any suggestion?

Thanks in advance
> 
> 
> Jisheng Zhang (2):
>   riscv: nommu: remove PAGE_OFFSET hardcoding
>   clocksource/drivers/timer-clint: Add T-Head C9xx clint
> 
>  arch/riscv/Kconfig                |  8 +++++-
>  arch/riscv/include/asm/clint.h    |  2 ++
>  arch/riscv/include/asm/timex.h    | 18 +++++++++---
>  drivers/clocksource/timer-clint.c | 48 +++++++++++++++++++++++++++----
>  4 files changed, 66 insertions(+), 10 deletions(-)
> 
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

