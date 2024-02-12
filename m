Return-Path: <linux-kernel+bounces-62556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FEA8522C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332C1B249C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74CB50254;
	Mon, 12 Feb 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="patan0HD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA94F5FA;
	Mon, 12 Feb 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781733; cv=none; b=lCGyLHOX4PxwBBkaIsYnmU3egcYxP99fyzigzgwNIu6vtylkwDK1ba72Da2YMkc0ZennZj1Lfbn9ZUEHGZT1bofJ6OQXWCR1L3S39kWW3eOtctL7JtftzKId7rUeCfwjcL1y4BhF1pmhAdInk2savTs+MQz1tPWM/bbTv0HehO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781733; c=relaxed/simple;
	bh=N0FaQE0vHSopm6AME+8az+/MTsHIzXcz1fDK/aRn3BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGF8ltCt7rlhqcSwkijniQJM+W39EOiZpOyG2qnhIDXmyOVknNsdJ3df1jckY1THt8VTJ/zJGhtuJjXrsTggl+P1ZsTj0nV0rYJz+XbaYBHDcs57XY3q7oeS7VVzveh4fsoalO9IvxVNz4Ohdzxe6m/VgHh/Zs81hGAyA94hOTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=patan0HD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AD5C433F1;
	Mon, 12 Feb 2024 23:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707781732;
	bh=N0FaQE0vHSopm6AME+8az+/MTsHIzXcz1fDK/aRn3BQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=patan0HD5soE+gBudXrfudQL98WiQ/5vfwvnHXCboGYtCztc4VwPbnKE8WsW+Zrrf
	 UrkMMFWAezzDX8xAIwF8/UY2p/MgyOO/luOk1an0afJ9R0LLcqNfXtiyFFpBYIXtcI
	 hOPpUzZzfrlueXD/lDLBSB1gu+vE69gS2JLhPZUZLei1VvXHQNwW0p8YVEbbW2Q5PC
	 VjroYDDKUmfUyeCbYQWgEsYX/3bwMhn3rpH3rtsVCZ5ELSC+oRj2QZ+06RQSuIo8Ru
	 g98tACk1Em22+kSJk5booXP6OFlcAixlWiSzTu/aDFyOP8bMzwWRKRO8RUCgCH4eQG
	 r+RIPW4Acq3SA==
Date: Mon, 12 Feb 2024 16:48:50 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Prebuilt LLVM 18.1.0-rc2 uploaded
Message-ID: <20240212234850.GB3221859@dev-arch.thelio-3990X>
References: <20240208002841.GA2601476@dev-arch.thelio-3990X>
 <CANiq72=G--5LW-9sg2PscTL863mFVNdnX7LUQX2Xj02qZs4crA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=G--5LW-9sg2PscTL863mFVNdnX7LUQX2Xj02qZs4crA@mail.gmail.com>

Hi Miguel,

On Sat, Feb 10, 2024 at 05:36:01PM +0100, Miguel Ojeda wrote:
> On Thu, Feb 8, 2024 at 1:28 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > I have built and uploaded a prebuilt version of LLVM 18.1.0-rc2 to
> > https://mirrors.edge.kernel.org/pub/tools/llvm/.
> >
> > As with Linux -rc releases, this is not the final version that will
> > ship. If you run across any issues, especially ones that were not
> > present in earlier LLVM releases, please consider reporting them to us
> > so that we have a chance to investigate and fix them before the final
> > release.
> 
> I took a look at the LLVM 18 prerelease to see if these would work
> with Rust for e.g. CI and other users (instead of using the
> LLVM-provided apt ones, for instance), and noticed it does not bundle
> `libclang.so`.
> 
> Would it be possible to include it so that we can use `bindgen` and
> thus enable Rust with them?
> 
> I understand they are intended to be minimal toolchains, but if you
> think it would not be an unreasonable overhead, then it would be great
> to have it.

Absolutely, I am more than happy to include libclang.so and anything
else that would be useful for the kernel. Everything gets built but I
only install what has felt needed for the kernel, so there is no real
overhead aside from package size, which obviously should not increase
much with this change. I've added the targets to my build scripts and
kicked off a set of builds. If they finish successfully, I will upload
them so that you can test them out and make sure they will work.

Thanks for bringing this up and giving them a go, cheers!
Nathan

