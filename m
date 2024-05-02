Return-Path: <linux-kernel+bounces-166224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4393A8B97BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BF81F27957
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954C654903;
	Thu,  2 May 2024 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGfegygy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BDC2C6BC;
	Thu,  2 May 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642224; cv=none; b=ktvFo4D1MEGLLoX295yz6qaGzVQVj4BUEXzVA0zaQRaTpb00nm5VKarrmmcmJfYUPbUKKx17njN49s/ouiIiIIqlqUZJ7FjQIUxVffw3ezLY42AP6FLbxj1vhsMR9nSoTfO8O+bW6rPg7kzreFcDrvB4cCgBjK/r5Ok87Qokzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642224; c=relaxed/simple;
	bh=Qns0M3prwynpZkQZNCgqtHT45rA7WTncoO7uiBRtf3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPjpPIk3kQ0uSMLm+w8CShz6ArdB+haAgfzzhcGHrSncaKoqqGUWRM8Lzx6214+dNfqKZHxdVsWrbG5j0nwP2UGs/cjaokwHRX01RUZFlUKHunD2k/FQqfS3kXbw13Fir2wviF0wIQ+UHfByrdQIFwuLyll4kzG6j30jUAHpzsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGfegygy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74950C113CC;
	Thu,  2 May 2024 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642224;
	bh=Qns0M3prwynpZkQZNCgqtHT45rA7WTncoO7uiBRtf3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGfegygyl/gPEHlP/t5eWjVLCfeyHxfqPhdCVmEJ6e4kl0VoqmS1s3paknd5LrASY
	 U8jDEeKVcl68M5St/yCPcyApmrC4NYVnug4ivHpWwmV4gnG6wHEMPe0onv+ar0oAjD
	 7VFZ8e55Lw/ph4oXZ2thqsBAg+9cxngqt8+9tszOCVyJUqGvWRx7o3IRw5uqqmkKkT
	 aUbtBlOo+X640h7z3/FRHfj2k/8HJ6ktWkCgEy5x0YK7vcO8iWVfSld6q12bdIweHL
	 nI37CLfwuCXKLPEFRM9ewqkokz0BNp2WtfWV0xfoNVy2/ToHMkOqbRZzKsRMhRXkfe
	 hiA2kX9+imivg==
Date: Thu, 2 May 2024 10:30:19 +0100
From: Lee Jones <lee@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v6] checkpatch: add check for snprintf to scnprintf
Message-ID: <20240502093019.GH5338@google.com>
References: <20240429-snprintf-checkpatch-v6-1-354c62c88290@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429-snprintf-checkpatch-v6-1-354c62c88290@google.com>

On Mon, 29 Apr 2024, Justin Stitt wrote:

> I am going to quote Lee Jones who has been doing some snprintf ->
> scnprintf refactorings:
> 
> "There is a general misunderstanding amongst engineers that
> {v}snprintf() returns the length of the data *actually* encoded into the
> destination array.  However, as per the C99 standard {v}snprintf()
> really returns the length of the data that *would have been* written if
> there were enough space for it.  This misunderstanding has led to
> buffer-overruns in the past.  It's generally considered safer to use the
> {v}scnprintf() variants in their place (or even sprintf() in simple
> cases).  So let's do that."
> 
> To help prevent new instances of snprintf() from popping up, let's add a
> check to checkpatch.pl.
> 
> Suggested-by: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v6:
> - move capture group to only include symbol name (not spaces or paren)
> - Link to v5: https://lore.kernel.org/r/20240422-snprintf-checkpatch-v5-1-f1e90bf7164e@google.com
> 
> Changes in v5:
> - use capture groups to let the user know which variation they used
> - Link to v4: https://lore.kernel.org/r/20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com
> 
> Changes in v4:
> - also check for vsnprintf variant (thanks Bill)
> - Link to v3: https://lore.kernel.org/r/20240315-snprintf-checkpatch-v3-1-a451e7664306@google.com
> 
> Changes in v3:
> - fix indentation
> - add reference link (https://github.com/KSPP/linux/issues/105) (thanks Joe)
> - Link to v2: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com
> 
> Changes in v2:
> - Had a vim moment and deleted a character before sending the patch.
> - Replaced the character :)
> - Link to v1: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v1-1-3ac5025b5961@google.com
> ---
> From a discussion here [1].
> 
> [1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@linux-m68k.org/
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

