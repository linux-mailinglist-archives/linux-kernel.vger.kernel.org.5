Return-Path: <linux-kernel+bounces-139899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AFB8A08F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11072284FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C12E13DBA7;
	Thu, 11 Apr 2024 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNb3LzaZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3413C9D9;
	Thu, 11 Apr 2024 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818674; cv=none; b=THB2GS4SWHPQqbqADoY0wpHh3CwRpFxDXO9YAEltgaM4f5SOQstRpp3XTgpwa/igvnL4CJ5mvuevfghOAJ0PxbHIhy01TGeTbNwicrn4BsUlqC8BTV2Rfge5E3+OKfcF16kJueFMf2pcTggQlB4uputxj7FVWv+M8F/lRHDs3Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818674; c=relaxed/simple;
	bh=YPEdfjTIPRIr7w6eCXFcj1Ndiu2d1XBq7Iuc7yuFymA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYXTVJgTnmsTqfiuxg4srXen0KrzqdFeTmK6dlLktjMrD4UcE5eJre5ARGxJo1iquOLgja8hoB+MHlJRw5TGnDROQ8wV5M4f+ZbonV/R4siOkp1KZYqUaHRgQ1ypvo/9zSE8RQ0z5RxNpRFV9ZcdTEJOUdtM/6sC3TRsChCovAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNb3LzaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C266C433F1;
	Thu, 11 Apr 2024 06:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712818674;
	bh=YPEdfjTIPRIr7w6eCXFcj1Ndiu2d1XBq7Iuc7yuFymA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNb3LzaZRLK6iHC2zAK3jT7Xh9oAFIlEXycqHUgR+uA8IOfj6xnEf0TqKGsKwXcPI
	 pMI7GUPV9PD16LrnT9s7avRzr4hqZJmTwt/fz+9utJI5xV060/ZPEztDP0mcQs09Bd
	 +Uv0HnNksGzz0bKwxEOdudKs3K//gdfMxukALtsDGex2vmJEKjBDwfX8cM0jfWguy0
	 xzv3zgG6fT3grwhD7Wf5EtiTxUgzRYDgvyz6zGqUZ0OGvWJvvb7E4QiEpsqLKboNHz
	 FjY2RoPz9c9UqWIOz9u0fN9JeUAXBIZ8MVvjDElXp4QY/0DAhUMEQQ4nBLawTAVjfh
	 doRC0xq4+xh2g==
Date: Thu, 11 Apr 2024 07:57:49 +0100
From: Lee Jones <lee@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v4] checkpatch: add check for snprintf to scnprintf
Message-ID: <20240411065749.GC6194@google.com>
References: <20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com>

On Mon, 08 Apr 2024, Justin Stitt wrote:

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

