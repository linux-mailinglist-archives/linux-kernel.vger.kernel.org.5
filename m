Return-Path: <linux-kernel+bounces-102239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B54987AFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA5C1C25730
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ADB6166B;
	Wed, 13 Mar 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7ZV37c+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9786A60DDD;
	Wed, 13 Mar 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349952; cv=none; b=aiJJY7HzC9coNsmMLVyTss9Kw4ftXNdqAiroO1SXWf1qFF6IQVfrt0KL+TZIITOAyuI4HPjv5n+Zt2I+NsfbDFulHTs0yn0KkIOTI/SOfEdmJLp6VinGIhZfZ7bNGsHILSYUtR4a8WDkOn0rriYFZdixUWuOawaIkzOD/EolEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349952; c=relaxed/simple;
	bh=P6edbYcrI8nT1RQqI4ia/s7CJ831ZSWH4YbGScmu1xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODhmx/NyQzQXXHuGLxgEQaLpyHyN6VWEZnwe6Bibgo7U6xQ96VYSQpFDV1bvM9HnqdJtj/VVHyEKhSRVwD3BSAv+FGcwXoagKLHqnEY0kS2DKzLRQAZKvP3StOaCOR+BYYA3CMq/a6TtLAEMR9gN25xmsjh4Ou7X2iKhMHC2gEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7ZV37c+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3778CC433F1;
	Wed, 13 Mar 2024 17:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349951;
	bh=P6edbYcrI8nT1RQqI4ia/s7CJ831ZSWH4YbGScmu1xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7ZV37c+CXO3OTsdcEETlOHei6+cF1IAnNh4K6RQEz59QPShKdUKIBN192k2mSvnx
	 NK+98Vf3gfKKj3MzzTFFfpbyOW/LHP9vX3omJ9/z2mEgvXEd+3e9p5LrOII/wDk6T0
	 jcAz3B1TcNFlZEF4UbaA/AR0XFhZkhFBY3ZFwEYU79TXYyjTFPkhfXfVkJmIVEW8FE
	 5FjonMBI38PT2w9Ix5WmWf1lWIHfhDA4Xq/m7ObEDyYtbmc5zyhrdtD7SObDk767LL
	 niCvs6S4y8MhsHAnxtnwzJTZduSr3Du7MrCJ6viNV6PH66oUUzyJPYRb2kF/7f9Alr
	 jH8uUPQY7NUnw==
Date: Wed, 13 Mar 2024 10:12:29 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 5.15 45/76] modpost: Add '.ltext' and '.ltext.*' to
 TEXT_SECTIONS
Message-ID: <20240313171229.GA3064248@dev-arch.thelio-3990X>
References: <20240313164223.615640-1-sashal@kernel.org>
 <20240313164223.615640-46-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313164223.615640-46-sashal@kernel.org>

Hi Sasha,

On Wed, Mar 13, 2024 at 12:41:52PM -0400, Sasha Levin wrote:
> From: Nathan Chancellor <nathan@kernel.org>
> 
> [ Upstream commit 397586506c3da005b9333ce5947ad01e8018a3be ]
> 
> After the linked LLVM change, building ARCH=um defconfig results in a
> segmentation fault in modpost. Prior to commit a23e7584ecf3 ("modpost:
> unify 'sym' and 'to' in default_mismatch_handler()"), there was a
> warning:
> 
>   WARNING: modpost: vmlinux.o(__ex_table+0x88): Section mismatch in reference to the .ltext:(unknown)
>   WARNING: modpost: The relocation at __ex_table+0x88 references
>   section ".ltext" which is not in the list of
>   authorized sections.  If you're adding a new section
>   and/or if this reference is valid, add ".ltext" to the
>   list of authorized sections to jump to on fault.
>   This can be achieved by adding ".ltext" to
>   OTHER_TEXT_SECTIONS in scripts/mod/modpost.c.
> 
> The linked LLVM change moves global objects to the '.ltext' (and
> '.ltext.*' with '-ffunction-sections') sections with '-mcmodel=large',
> which ARCH=um uses. These sections should be handled just as '.text'
> and '.text.*' are, so add them to TEXT_SECTIONS.
> 
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1981
> Link: https://github.com/llvm/llvm-project/commit/4bf8a688956a759b7b6b8d94f42d25c13c7af130
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This causes a warning when building with HOSTCC=clang:

  scripts/mod/modpost.c:1123:37: warning: excess elements in array initializer [-Wexcess-initializers]
   1123 |         .good_tosec = {ALL_TEXT_SECTIONS , NULL},
        |                                            ^~~~
  .../lib/clang/17/include/stddef.h:89:16: note: expanded from macro 'NULL'
     89 | #  define NULL ((void*)0)
        |                ^~~~~~~~~~
  1 warning generated.

Same comment as on the other UML clang-18 patch, I do not think this is
necessary right now in 5.15 and earlier. The other modpost patch can go
as well, as it is only a prerequisite change.

Cheers,
Nathan

