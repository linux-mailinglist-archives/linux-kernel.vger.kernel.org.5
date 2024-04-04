Return-Path: <linux-kernel+bounces-131728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DF8898B29
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475B51F2B126
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD0112A173;
	Thu,  4 Apr 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQLRQoQ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93C1292EE;
	Thu,  4 Apr 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244781; cv=none; b=Ap1X0x0yW7X8vUxpvUpPFI5SX/oFwheKh1BRjk/8SOrov4vcKsrfuLWmdN1LGsek8AVy7WybS8Zs+pQB7wQf8u0Uc0WeFGB+lAliMz4WBJ5se+pR6XWYz8LCbyUIVLPbwMzzghIRj1voJ6xFMXhCP/Zf2y7TXs2vOzwm6Mp+QMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244781; c=relaxed/simple;
	bh=+ihKIoYDSDX/L3rUTACaGuGGhf6TLUZ/+4aywDsnmIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEt5xSpdYo0uctKDX1QyToz6xN01HMRwwuwzURpBDcd3VELKQzzpo7gRiAql9aFF8mFNv7JzBZkpms7RATLwSjS36yQ2dRDH8f+6QEi/kTOtAts+YpzNgv2wLYliqdBCuFvEHRJ2qJL0Dv0bR23r6L+ZP43rrDto7pXeJg5Qehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQLRQoQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96471C433F1;
	Thu,  4 Apr 2024 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712244781;
	bh=+ihKIoYDSDX/L3rUTACaGuGGhf6TLUZ/+4aywDsnmIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQLRQoQ8m3JLC2Td7LqTr9Gyx8iw2LqCI4y/rdO3jtZZbS+Jx+i1K/p9KSnZBmeME
	 +c29ns5saD6bgCr/l+2SX/f4nFyiiSIxm/5E9rcRe8PW0ZE7NZpGIwjxhx5E89VL15
	 82t9Vd7JFQgbffAMgIwa0aZMPBP883Z6LDkVPEtCDYG8PJHV9dhQXrPGeZxtYv/B+S
	 TdPsbPup6lVeq9b/AlKD3BSDhXEVHVqOEnkLN8LdjH60jD/0MagUPdIpfuABSjbPKn
	 Ca++IKiyI5MdVDhXG+zD+xnTEBgDZk67+RLYMxMdw2G32RjOdiVttZUzTgVOGqjsQP
	 tS4iFvBCBEjKg==
Date: Thu, 4 Apr 2024 08:32:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v3] rust: make mutually exclusive with CFI_CLANG
Message-ID: <20240404153258.GA852748@dev-arch.thelio-3990X>
References: <20240404-providing-emporium-e652e359c711@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-providing-emporium-e652e359c711@spud>

On Thu, Apr 04, 2024 at 03:17:02PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> On RISC-V and arm64, and presumably x86, if CFI_CLANG is enabled,
> loading a rust module will trigger a kernel panic. Support for
> sanitisers, including kcfi (CFI_CLANG), is in the works, but for now
> they're nightly-only options in rustc. Make RUST depend on !CFI_CLANG
> to prevent configuring a kernel without symmetrical support for kfi.
> 
> Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> cc: stable@vger.kernel.org
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Nathan Chancellor <nathan@kernel.org>

It seems like this won't be forgotten about but if there is not already
an issue open for this somewhere, it would be good to have one, since we
obviously want this for both C and Rust code.

As a general meta comment not directed at anyone in particualr, I think
these 'depends on !' should all have some sort of comment or description
as to why they are disabled. I can infer from most of them but it would
still be good to be explicit, especially since someone might want to
work on fixing the ones that are due to missing support and such.

> ---
> Sending this one on its own, there's no explicit dep on this for the
> riscv enabling patch, v3 to continue the numbering from there. Nothing
> has changed since v2.
> 
> CC: Miguel Ojeda <ojeda@kernel.org>
> CC: Alex Gaynor <alex.gaynor@gmail.com>
> CC: Wedson Almeida Filho <wedsonaf@gmail.com>
> CC: linux-kernel@vger.kernel.org (open list)
> CC: rust-for-linux@vger.kernel.org
> CC: Sami Tolvanen <samitolvanen@google.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: Nathan Chancellor <nathan@kernel.org>
> CC: llvm@lists.linux.dev
> ---
>  init/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index aa02aec6aa7d..ad9a2da27dc9 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1899,6 +1899,7 @@ config RUST
>  	bool "Rust support"
>  	depends on HAVE_RUST
>  	depends on RUST_IS_AVAILABLE
> +	depends on !CFI_CLANG
>  	depends on !MODVERSIONS
>  	depends on !GCC_PLUGINS
>  	depends on !RANDSTRUCT
> -- 
> 2.43.0
> 
> 

