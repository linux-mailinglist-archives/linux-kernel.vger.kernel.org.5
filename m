Return-Path: <linux-kernel+bounces-31984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0881C8354DF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 09:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D7E1C21CCC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 08:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A1364B0;
	Sun, 21 Jan 2024 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa8nTVig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C4364AA
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705824336; cv=none; b=EOeFg4lpQC0ULRRxvq26cSAayed4bMCoT3wr7hlKfmUXF58n+EJ0dOOSO5geZ+/pWMoXrAlD5Ak3ngby7d67gb+VhnGYpJmYSe41VWu4adpe84tE0k9QgfM778WyYlJMXAoYWY/Q77y7IX57r3SiyYcYAo8j7DyWHqoWtx+SAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705824336; c=relaxed/simple;
	bh=5m4YMZwIUsFW11vATiJB7Zw30FIia+5scna6ZtxzJaE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=owQ6H7ycB68ymPTm3VFnflnjiRZ7YyupfpOcNaHzP7UHQplUg0UFRdzoBcDsoADWZj79rP6IP9wB5KJC9541MFysClCmJK3yc8r0ov7xNAQmGK/GDXqRKLSeoa+Ab+PnaYzo3ntcI/hOsAFRaKSeM16LeB6D46GrLHRAyeXSMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa8nTVig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245B7C433F1;
	Sun, 21 Jan 2024 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705824336;
	bh=5m4YMZwIUsFW11vATiJB7Zw30FIia+5scna6ZtxzJaE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Oa8nTVig4JVK3qSWt/+4HZB/e2JNYSS5N4YMCFFdG/kVtciiFfAV494+aMuMiVTrt
	 Fq1wj3Jw07Z52+UUarm78rX0aBkhuaGwfPw1/SRnJevNjANcvVyHmtQRGMm7wBYCIe
	 Mvz3Fkkw4M06tzuYQFz0WPu1ZOPp7W8dqoOxCCXpvui8Hr/2Q17nqHk9W9Fiyu2sxO
	 BLOTSnW6NzaosPjGq4B47lFazdRRASnuNfk8iRs1RFVYIXjkmVjDMeeGhA9w64HjF5
	 4dJUVausT+pBpV732kSnOK0TWWWjKc+YkBNOLcoIFfoYF6eApNexcOjLjKsFEvclCc
	 bJkrM2/VVaaXw==
Date: Sun, 21 Jan 2024 00:05:34 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>
CC: Josh Triplett <josh@joshtriplett.org>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whw936qzDLBQdUz-He5WK_0fRSWwKAjtbVsMGfX70Nf_Q@mail.gmail.com>
References: <202401081028.0E908F9E0A@keescook> <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com> <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org> <ZZ2W_xzCSyOgltad@localhost> <CAHk-=wi75tFVtZdzFRr4hsDeUKmeACbgD46rLe+2bcd=4mHBBw@mail.gmail.com> <ZZ3_Jmb1sb2wQWO_@localhost> <CAHk-=whf9qLO8ipps4QhmS0BkM8mtWJhvnuDSdtw5gFjhzvKNA@mail.gmail.com> <20240111094711.GT1674809@ZenIV> <20240111100501.GU1674809@ZenIV> <CAHk-=wi-aMO1GuN1odOz4MZksMNECVdrORuXKfqSS9DoTx0yDg@mail.gmail.com> <CAHk-=whw936qzDLBQdUz-He5WK_0fRSWwKAjtbVsMGfX70Nf_Q@mail.gmail.com>
Message-ID: <F3CF53C5-6423-4DA3-83CA-86B8B8C3862C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 20, 2024 2:18:36 PM PST, Linus Torvalds <torvalds@linux-foundat=
ion=2Eorg> wrote:
>End result: I committed my "move do_open_execat() to the beginning of
>execve()" patch, since it's clearly an improvement on the existing
>behavior, and that whole "struct file allocations are unnecessarily
>expensive" issue is a separate thing=2E

Thanks! I'll add the other bits of refactoring I did in my version of the =
clean-up (I created do_close_execat() for the repeated "allow_write_access(=
file); fput(file);" calls, along with some comments):
https://lore=2Ekernel=2Eorg/lkml/202209161637=2E9EDAF6B18@keescook/

I like your removal of the "out" label! :)

-Kees

--=20
Kees Cook

