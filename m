Return-Path: <linux-kernel+bounces-110557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D2688608C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D051F231A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843F912BE80;
	Thu, 21 Mar 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqGNCgYd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60718625E;
	Thu, 21 Mar 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711045808; cv=none; b=j+qXe5b+OQNrHEl+mDkSOjwaEGPVHN33EQVUNJeWilQNLmuB9CeIgjpy9wiB46entvcYotEKAWUyL4WkMJT2LqlCboiGNAS/wAP8ThHrt8lDmMhBsgEKXZkljHpwUsxR4oy38Myg4hnbaeWtXbV48XS8Szmw8Epg5cZx9XaAGeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711045808; c=relaxed/simple;
	bh=5UQdsWFzoch7R+MKt7H8VtFuUB4YUzJ8RXhJIzOFzG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByxTwmoRGtLcVwe6CuplvGX6TgG3MZP9EHPVTPv/g7KCw+PEaJ9gendnDRMxdC6a9LLL9kyNMU7VxON6bmih+O2ALLYHUzjJES6xbplvsVqadH6X32f8UKTaq2zAU/VapfYJxWvRB1TCi5UVAIGBxoTU8zVr14cCIwEIVH+FdZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqGNCgYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03BEC433C7;
	Thu, 21 Mar 2024 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711045808;
	bh=5UQdsWFzoch7R+MKt7H8VtFuUB4YUzJ8RXhJIzOFzG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uqGNCgYdn3LVnxrP9IbUP2/V/nsEaHMdJSg63lMybandToW0kPIucP6HS0TRySl3q
	 IDmjlTiSZJe2aXCdof+UAHkcfH2/YvRw2QmYkGIPz4VOgBIM0i45/nrBcfHq8JVCS+
	 CJozbzuKTrgIWUtlBFggvKnG8dw0WEbw8SvZO1Nqxea8KP/IE35RJqxRTyDXEQ/tY4
	 0mqHCZkUY43FfjdxBNVwNqfJDfa9L0y7S/3YQAocxY9uf0x5dr5DebGllaaSgPMYGa
	 zYSISaaiz2p9iujbpBHDCBNkbFEu9WjBsUXEY4U4cKw3xUDwLT1Gmcm9SD+gJNyEmV
	 zY7NLlLNnoIyQ==
Date: Thu, 21 Mar 2024 11:30:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.9-rc1
Message-ID: <20240321183006.GA2907026@dev-arch.thelio-3990X>
References: <Zfwv2y7P7BneKqMZ@kroah.com>
 <20240321134831.GA2762840@dev-arch.thelio-3990X>
 <CAHk-=wgGhgkEngBBureLRLKe7mQ-sRhYngUQNvxEUqR9mmc60w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgGhgkEngBBureLRLKe7mQ-sRhYngUQNvxEUqR9mmc60w@mail.gmail.com>

On Thu, Mar 21, 2024 at 11:10:22AM -0700, Linus Torvalds wrote:
> On Thu, 21 Mar 2024 at 06:48, Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > That build warning actually happens with clang, not GCC as far as I am
> > aware, and it is actually a hard build error with older versions of
> > clang
> 
> So the "labels without a statement" thing is not only a long-time gcc
> behavior (admittedly due to a parsing bug), afaik it's becoming
> "standard C" in C23.

Right, N2508 has been applied to the C23 draft [1] as far as I can tell
and clang finished implementing it with [2], which was released in
18.1.0.

> Does clang have a flag to allow this?

As far as I understand it, clang does not have separate flags to control
the warnings that it emits for the various c23 extensions that it allows
in older standard versions, just the big hammer of -Wc23-extensions.

Since GCC does not appear emit warnings for newer C features that it
allows even with older 'gnu' standard values by default (I think it does
with '-pedantic'?), perhaps we should just disable -Wc23-extensions
altogether? Not sure how big of a hammer this is, I think this type of
warning is the only thing I have seen come from -Wc23-extensions...

> Considering that gcc doesn't warn for it, and that it will become
> official at some point anyway, I think this might be a thing that we
> might be better off just accepting, rather than be in the situation
> where people write code that compiles fine with gcc and don't notice
> that clang will error out.
> 
> So yes, clang is being correct, but in this case it only causes problems.

Agreed, it isn't the first time :/

[1]: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3096.pdf
[2]: https://github.com/llvm/llvm-project/commit/8bd06d5b65845e5e01dd899a2deb773580460b89

Cheers,
Nathan

