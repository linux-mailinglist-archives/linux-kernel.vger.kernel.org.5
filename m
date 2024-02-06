Return-Path: <linux-kernel+bounces-55276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EBA84BA30
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7032B2D5B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581AE134CCC;
	Tue,  6 Feb 2024 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rak93+G/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A413341C;
	Tue,  6 Feb 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234517; cv=none; b=UqBwEW918OR0u9KWLUAn1z41HC9uO9Pqi91PknsDoZhSgkqe28sdTMBoYsO7Fs386Q/l5TlK9leKoHwRK/xNyDmnOUSLvAY5pXrOMYjD3NXDOWlL/Ird5KHY93emMG/IwFhl0rIX0Fs8vPZhSSts0qsBjyEihQm9eFvTX/8pRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234517; c=relaxed/simple;
	bh=zaZSsrvYhW5Ke2AYAmP/ja6WNn71gyudEVeXSINNEsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ5j7qr3f5UarF+KCPt9P3+82A57mhL3TTPjrmuELMlj2yg6S34v0CAL+SuitC/ak/rWtuQiADYWEtK1wYtz/6XgGHRti7NC61hIV85MwmDloIO+t4WN/ZK83Op8Y9KhPqaxMmuvOo+BTPqCZeAwSsduKb0XH9/wVS2P7Eyld4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rak93+G/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C145DC433F1;
	Tue,  6 Feb 2024 15:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707234517;
	bh=zaZSsrvYhW5Ke2AYAmP/ja6WNn71gyudEVeXSINNEsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rak93+G/BJ5ORjKtT7vFG8fmk8Bwt1Ix0jXOncUPNsLpN5JcRXpcq/uuHxMwGa/OC
	 BYwc2bIZqVoxeBRDy7aR8m8/RFB9RT3u0qBiuS6IU+lD22qZEkv3nZ/fJWTw3PoXvV
	 6foJCiRNwclykXHNvYaVMgcc7sNrxJT5WIaaRXgfTdulEZ+jJGkE1g1yC4CMENy324
	 iYCsdeZUGt+6gl00zho0VjeUgWgp6TRcs6qepB3mDA8pxDgZJAiGbnK2H1FEwJqZPQ
	 VKzIxtuCY6zo1MDzmfE3t+sG4xvBD97LH/lfhZU6UpYS9F9ZlIO29kTHaIN+CIHpWb
	 ObfJEzis5v/TA==
Date: Tue, 6 Feb 2024 08:48:35 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Donald Zickus <dzickus@redhat.com>, stable@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 1/6] tools/rtla: Fix Makefile compiler options for clang
Message-ID: <20240206154835.GA1433705@dev-arch.thelio-3990X>
References: <cover.1707217097.git.bristot@kernel.org>
 <567ac1b94effc228ce9a0225b9df7232a9b35b55.1707217097.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <567ac1b94effc228ce9a0225b9df7232a9b35b55.1707217097.git.bristot@kernel.org>

On Tue, Feb 06, 2024 at 12:05:29PM +0100, Daniel Bristot de Oliveira wrote:
> The following errors are showing up when compiling rtla with clang:
> 
>  $ make HOSTCC=clang CC=clang LLVM_IAS=1
>  [...]
> 
>   clang -O -g -DVERSION=\"6.8.0-rc1\" -flto=auto -ffat-lto-objects
> 	-fexceptions -fstack-protector-strong
> 	-fasynchronous-unwind-tables -fstack-clash-protection  -Wall
> 	-Werror=format-security -Wp,-D_FORTIFY_SOURCE=2
> 	-Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
> 	$(pkg-config --cflags libtracefs)    -c -o src/utils.o src/utils.c
> 
>   clang: warning: optimization flag '-ffat-lto-objects' is not supported [-Wignored-optimization-argument]

For what it's worth, this flag is supported in clang 17.0.0 and newer:

https://github.com/llvm/llvm-project/commit/610fc5cbcc8b68879c562f6458608afe2473ab7f

But if it is not critical, just dropping the flag like you have done
here rather than conditionally supporting it is probably easier.

>   warning: unknown warning option '-Wno-maybe-uninitialized'; did you mean '-Wno-uninitialized'? [-Wunknown-warning-option]
>   1 warning generated.
> 
>   clang -o rtla -ggdb  src/osnoise.o src/osnoise_hist.o src/osnoise_top.o
>   src/rtla.o src/timerlat_aa.o src/timerlat.o src/timerlat_hist.o
>   src/timerlat_top.o src/timerlat_u.o src/trace.o src/utils.o $(pkg-config --libs libtracefs)
> 
>   src/osnoise.o: file not recognized: file format not recognized
>   clang: error: linker command failed with exit code 1 (use -v to see invocation)
>   make: *** [Makefile:110: rtla] Error 1
> 
> Solve these issues by:
>   - removing -ffat-lto-objects and -Wno-maybe-uninitialized if using clang
>   - informing the linker about -flto=auto
> 
> Cc: stable@vger.kernel.org
> Fixes: 1a7b22ab15eb ("tools/rtla: Build with EXTRA_{C,LD}FLAGS")
> Suggested-by: Donald Zickus <dzickus@redhat.com>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  tools/tracing/rtla/Makefile | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 2456a399eb9a..afd18c678ff5 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -28,10 +28,15 @@ FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
>  		-fasynchronous-unwind-tables -fstack-clash-protection
>  WOPTS	:= 	-Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
>  
> +ifeq ($(CC),clang)
> +  FOPTS := $(filter-out -ffat-lto-objects, $(FOPTS))
> +  WOPTS := $(filter-out -Wno-maybe-uninitialized, $(WOPTS))
> +endif
> +
>  TRACEFS_HEADERS	:= $$($(PKG_CONFIG) --cflags libtracefs)
>  
>  CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS) $(EXTRA_CFLAGS)
> -LDFLAGS	:=	-ggdb $(EXTRA_LDFLAGS)
> +LDFLAGS	:=	-flto=auto -ggdb $(EXTRA_LDFLAGS)
>  LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs)
>  
>  SRC	:=	$(wildcard src/*.c)
> -- 
> 2.43.0
> 

