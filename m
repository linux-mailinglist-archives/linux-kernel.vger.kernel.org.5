Return-Path: <linux-kernel+bounces-102481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0958987B2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3426F1C26192
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A774D9F8;
	Wed, 13 Mar 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBd6Rwno"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C224CDE0;
	Wed, 13 Mar 2024 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360795; cv=none; b=XyLwwOWT8yhf1bVvoDqUt+xXp+dOrlBK5ylPxGYeXJOblx+KLuuTgiVlmS3uyc0kMKl4fC2YQyAyw3YArTKBR/WXCCU+hqtb2AMKsxBkMJAPTGumG9CDjxg3e+AHa/36KtFXK2HQh7VnGl3NkoViNwQEJ63hSBIpJc1Hd9LCcCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360795; c=relaxed/simple;
	bh=c64cY2qgtziptw227hn4tBZzUV80RXRr2wvr31Rcm2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6TLSbCFh6G3MGutcUv59vL3SD1jbvLKylH4h/TipKCK/iQPVrXwNnHwkjRjFHQdRpjzqYJQPepooMSDW97+uLzRSZl3f1Lw0pE88C1SMN+DJY7Z8EsgJNHCF3YFFrcCozprgN3Av9OpdnjjJzMxR2OJ6knywv4hTSKSV/raR1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBd6Rwno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63FEC433F1;
	Wed, 13 Mar 2024 20:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710360795;
	bh=c64cY2qgtziptw227hn4tBZzUV80RXRr2wvr31Rcm2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBd6RwnokLPitlwriypZTz3KnoincvFjruThclF1F6u/abqvBZMOlhd2eVEU7qMOs
	 PCqxeRJWHtMQ/YwZB24PrOyvAdqVC3Wlo2nIpLyUOCbGbzLL/RA+9cjGOdDcf5Tkxc
	 PwKNrCyvK0EvTtS30vchOg7t3x5kh4faIjf1v0fFoSzgwyyxs9RddXMV/txBHRSg9S
	 YlMgrT+x4mtgdyJECGtngFahtUMKZ4thGDpW/gla2CtN0KK+LPcaDXe0ieRuThAUpb
	 7c4JaBhQi7xMLwycXhdJkz5Iy4mHCEJSymFT76T8omGMq5MxSAvVCK0LoqvT/hbzKr
	 nAejlPyVNASuw==
Date: Wed, 13 Mar 2024 16:13:13 -0400
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 5.15 45/76] modpost: Add '.ltext' and '.ltext.*' to
 TEXT_SECTIONS
Message-ID: <ZfII2Rrv452_5hrw@sashalap>
References: <20240313164223.615640-1-sashal@kernel.org>
 <20240313164223.615640-46-sashal@kernel.org>
 <20240313171229.GA3064248@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240313171229.GA3064248@dev-arch.thelio-3990X>

On Wed, Mar 13, 2024 at 10:12:29AM -0700, Nathan Chancellor wrote:
>Hi Sasha,
>
>On Wed, Mar 13, 2024 at 12:41:52PM -0400, Sasha Levin wrote:
>> From: Nathan Chancellor <nathan@kernel.org>
>>
>> [ Upstream commit 397586506c3da005b9333ce5947ad01e8018a3be ]
>>
>> After the linked LLVM change, building ARCH=um defconfig results in a
>> segmentation fault in modpost. Prior to commit a23e7584ecf3 ("modpost:
>> unify 'sym' and 'to' in default_mismatch_handler()"), there was a
>> warning:
>>
>>   WARNING: modpost: vmlinux.o(__ex_table+0x88): Section mismatch in reference to the .ltext:(unknown)
>>   WARNING: modpost: The relocation at __ex_table+0x88 references
>>   section ".ltext" which is not in the list of
>>   authorized sections.  If you're adding a new section
>>   and/or if this reference is valid, add ".ltext" to the
>>   list of authorized sections to jump to on fault.
>>   This can be achieved by adding ".ltext" to
>>   OTHER_TEXT_SECTIONS in scripts/mod/modpost.c.
>>
>> The linked LLVM change moves global objects to the '.ltext' (and
>> '.ltext.*' with '-ffunction-sections') sections with '-mcmodel=large',
>> which ARCH=um uses. These sections should be handled just as '.text'
>> and '.text.*' are, so add them to TEXT_SECTIONS.
>>
>> Cc: stable@vger.kernel.org
>> Closes: https://github.com/ClangBuiltLinux/linux/issues/1981
>> Link: https://github.com/llvm/llvm-project/commit/4bf8a688956a759b7b6b8d94f42d25c13c7af130
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This causes a warning when building with HOSTCC=clang:
>
>  scripts/mod/modpost.c:1123:37: warning: excess elements in array initializer [-Wexcess-initializers]
>   1123 |         .good_tosec = {ALL_TEXT_SECTIONS , NULL},
>        |                                            ^~~~
>  .../lib/clang/17/include/stddef.h:89:16: note: expanded from macro 'NULL'
>     89 | #  define NULL ((void*)0)
>        |                ^~~~~~~~~~
>  1 warning generated.
>
>Same comment as on the other UML clang-18 patch, I do not think this is
>necessary right now in 5.15 and earlier. The other modpost patch can go
>as well, as it is only a prerequisite change.

Dropped, thanks!

-- 
Thanks,
Sasha

