Return-Path: <linux-kernel+bounces-153914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3B48AD4CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE861C214EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1EE155328;
	Mon, 22 Apr 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyKSgTwJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D3154432;
	Mon, 22 Apr 2024 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713813891; cv=none; b=lTNao8VBA70z3zsUKsRzAk2qEAw/KQWmFkxh8tb8n30u2HtPlTs8lZBKW96aZhpTy6gRQMcU774zCeCr5jsS0JrGBcrc+sLPomCBJ+mVYh0fJcnqpla2IXHASdsHEwFzLwVh2qWNJcwO2/jB/cIzptQoqQSvOCJmehu2tUCbV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713813891; c=relaxed/simple;
	bh=zIUa5SvVminmx3eVAGvIUp8fg8imeSayLppin82OLoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXusOuUd9extEM9CCJfirewxZHtw8DmYFhr4JAmAev6XLYWsT6josACQDP1Wb4s4oiCkev8WdjY1rtFm2y2JW6wmIhzzmDiQIRdRCc9FaxUYoKuur7IQwRArJuzKkyMBitRuDsWmlT6+NkkIAX+qLsbpTYPQm8DM3CIk/YJM57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyKSgTwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23105C113CC;
	Mon, 22 Apr 2024 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713813891;
	bh=zIUa5SvVminmx3eVAGvIUp8fg8imeSayLppin82OLoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyKSgTwJVuRMqlOfroY7bQ7kbyfCs3d1lnVI+shiARXgEbrmHarmmpIKT8JTV+/D8
	 Hvnwwq3k5U70K/N2/9+IDipgCMdrIIqmKPEIdpW/VWgsOzzBIpV6OfwAJq/KE8Eunh
	 Na6NTdEdPX/QghJlkaQURvgR8FT/PV3VpWencSCRVsw3iVyGkm9AJotMLZ7mTD7UQd
	 JsKg77+vJvDmc1umNF+FC5eIm/BEzzdM1oGVWXz4UCvmeIsE44d/IhsYyZtlh30CNF
	 mu6C/Gt0EDCyGMD2a3sPRalS6EIdrHiRxyOiGhSeZVouXxqGBZTlRVi8ii4yAaULwg
	 NYHMYP47Uz6DQ==
Date: Mon, 22 Apr 2024 12:24:48 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yuntao Liu <liuyuntao12@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, masahiroy@kernel.org,
	nicolas@fjasle.eu, peterz@infradead.org, jpoimboe@kernel.org,
	leitao@debian.org, petr.pavlu@suse.com, richard.weiyang@gmail.com,
	ruanjinjie@huawei.com, ndesaulniers@google.com, jgross@suse.com
Subject: Re: [PATCH] x86: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <20240422192448.GA19445@dev-arch.thelio-3990X>
References: <20240422060556.1226848-1-liuyuntao12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422060556.1226848-1-liuyuntao12@huawei.com>

Hi Yuntao,

Just a drive by review since I saw this patch via another CC in my
inbox, I would wait for x86 maintainer thoughts before sending a v2.

On Mon, Apr 22, 2024 at 06:05:56AM +0000, Yuntao Liu wrote:
> The current x86 architecture does not yet support the
> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. x86 is widely used in
> embedded scenarios, and enabling this feature would be beneficial for
> reducing the size of the kernel image.
> 
> In order to make this work, we keep the necessary tables by annotating
> them with KEEP, also it requires further changes to linker script to KEEP
> some tables and wildcard compiler generated sections into the right place.
> 
> Enabling CONFIG_UNWINDER_ORC or CONFIG_MITIGATION_RETPOLINE will enable
> the objtool's --orc and --retpoline parameters, which will alter the
> layout of the binary file, thereby preventing gc-sections from functioning
> properly. Therefore, HAVE_LD_DEAD_CODE_DATA_ELIMINATION should only be
> selected when they are not enabled.
> 
> Enabling CONFIG_LTO_CLANG or CONFIG_X86_KERNEL_IBT will use vmlinux.o
> instead of performing the slow LTO link again. This can also prevent
> gc-sections from functioning properly. Therefore, using this optimization
> when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled.

These two paragraphs indicate to me that this feature will be
unselectable the vast majority of x86 configurations, why should the
upstream kernel support it in that case?

> The size comparison of zImage is as follows:

                         ^ bzImage?

> x86_def_defconfig  i386_defconfig    tinyconfig
> 10892288           10826240          607232          no dce
> 10748928           10719744          529408          dce
> 1.3%               0.98%             12.8%           shrink
> 
> When using smaller config file, there is a significant reduction in the
> size of the zImage.

Same here.

What toolchain was this tested with? There have been behavior
differences between the GNU and LLVM toolchains that have shown up when
dead code elimination is enabled, such as with 32-bit ARM [1] and RISC-V
[2]. While I am not saying there are any problems here, it would be good
to qualify how well this has been tested and perhaps do some testing
with other toolchains and versions, especially since you are touching
areas guarded by CONFIG_LTO_CLANG. Does the resulting kernel boot and
run properly?

[1]: https://lore.kernel.org/30b01c65-12f2-4ee0-81d5-c7a2da2c36b4@app.fastmail.com/
[2]: https://lore.kernel.org/20230622215327.GA1135447@dev-arch.thelio-3990X/

> ---
>  arch/x86/Kconfig              |  1 +
>  arch/x86/kernel/vmlinux.lds.S | 24 ++++++++++++------------
>  scripts/link-vmlinux.sh       |  2 +-
>  3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index a902680b6537..92dfbc8ee4e7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -247,6 +247,7 @@ config X86
>  	select HAVE_FUNCTION_ERROR_INJECTION
>  	select HAVE_KRETPROBES
>  	select HAVE_RETHOOK
> +	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !CONFIG_UNWINDER_ORC && !CONFIG_MITIGATION_RETPOLINE

This is incorrect, it should be

    select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !UNWINDER_ORC && !MITIGATION_RETPOLINE

>  	select HAVE_LIVEPATCH			if X86_64
>  	select HAVE_MIXED_BREAKPOINTS_REGS
>  	select HAVE_MOD_ARCH_SPECIFIC

Cheers,
Nathan

