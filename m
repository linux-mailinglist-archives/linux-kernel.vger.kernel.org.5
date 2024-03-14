Return-Path: <linux-kernel+bounces-103916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCEF87C688
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143F728176C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2905134C4;
	Thu, 14 Mar 2024 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SowCYaPC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB84113FE7;
	Thu, 14 Mar 2024 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710459539; cv=none; b=Nv6m7LKbpHiTfU7SYeprMQLT3x/qrEKT4P6uOtsGb5bRwC9JJKzMnzU0AEjQVZd+rP/oqI1/uQD1CWZTjF1/L4k+xmSreoBaqurYtILR+A6oHwzDnmnf/XHC467zeMBkswJC6sosCIxyN27oEjW7oioE9Lgn5NpcXD7+95CEkno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710459539; c=relaxed/simple;
	bh=ToO7+GC40SPPq/DJBkYHMz5VkP5cIZgxtl9+T1qyeNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FX4en9A/QOie8YbNpuWQN/z2ef0M8KeubaF9OiBzH7ymaaGPgdhX1XOqr4EHPpSUTHZZlky0dOtMQGih/pOC8Z8QLTjp++TWB2xEqOqx5ZeF7XU26Syr98VovRFh4fEXmgD0UTTocR9GFNhVDoMeELa2+AGH3S+NaY7iJCt06yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SowCYaPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957B9C43601;
	Thu, 14 Mar 2024 23:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710459538;
	bh=ToO7+GC40SPPq/DJBkYHMz5VkP5cIZgxtl9+T1qyeNw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SowCYaPCOLjEnDgHQ2XC7R0LqG8iVH1tSpqaCRt02cjOZBaHctbbQFmzEqjRcvhmj
	 i/Zv0c3M92heLQdOgfA7NRi08RATmBjbXeesA48ueQQzaTtz4oMZJC+BryGvTZ5lm3
	 hO56AiCBUqrXAEan0fgh5ziDS9R32mi6gkiDZJxFX6Tr8T275Z2BSpkjdh5qiRIEDa
	 /g22lzM98Iq3qxplKJI1PJDely87LNSOCGJT/fh/f8iXg2Z/v7lVh3UzAkWK6HdC8Z
	 bvJhRgLIhynwbMDwZicreJqGkqeTdLFI23xGNjsyjPB+cNlOpR29hGWDtjed/bGmM8
	 7bHtbgf2uwG1Q==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso19976631fa.3;
        Thu, 14 Mar 2024 16:38:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWd2Px/Af6sDtDIT8cbm+QE6lgHKXyCWAQCf3vBqr8tyO8+A83j8fPqfatAzq+Ag/2pojYzm1AWZC60+oeOL/mkfrRaHWXYHVwDYLb1JCaBy1pb1RChTMzSoCCSbD9/Hh6FewnSjf+JaeyqVrtTZXtEZrRP+z0P5DhCqugdfBPeBsb7+wNFI5dz8df9kf4iLenMbUMbo9j2FmGL7p+cEuKYnikYyOmUFVhwvknmgSPLXAhREwx7PhAV8mTuR9UTq37e0FXoKHQwfqByE7+6GBt1pmmaEJx41LIWL7c=
X-Gm-Message-State: AOJu0YxhxQM6KkgZsEklxfjW5qw2KmMnrPUoyl9vT+Le4EedwOsVwDeO
	d8u/W51X0Z7sa1wwOfOfPwffsTtzDfYNQQ1+/aKnGGeJoniGAAAIFLIbcYajObokB4O3c5TcpdA
	RHU6s4MximEJPvz2HYU3TJcLUZxE=
X-Google-Smtp-Source: AGHT+IF2/ImKbZWGcxV6yAg7OxnoINqcxhfzgB5aBbVZi8+MbYBftvaXns5kzEnVc2lBbJ0XnQ1q0SLbGXlAKuS4j2k=
X-Received: by 2002:a2e:9a8a:0:b0:2d2:3fac:5fdc with SMTP id
 p10-20020a2e9a8a000000b002d23fac5fdcmr2171806lji.10.1710459536886; Thu, 14
 Mar 2024 16:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
 <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com> <20240313194423.GA1111@sol.localdomain>
 <b838e729-dc30-4e18-b928-c34c16b08606@gmail.com> <20240313202223.GB1111@sol.localdomain>
 <db86cba4-0e61-441d-8e66-405a13b61a3c@gmail.com> <20240313221043.GC1111@sol.localdomain>
 <f0492c92-1015-48e3-bfce-598c7a4843d1@quicinc.com> <20240313230611.GD1111@sol.localdomain>
 <a4d24b2c-7dbf-4354-9514-f8a253aac14b@gmail.com> <20240314202011.GB1132@sol.localdomain>
In-Reply-To: <20240314202011.GB1132@sol.localdomain>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 00:38:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGxxRs6Rkhevm9NSY6TaJUsOmF3UqdHUo=NRg9kQKtSBA@mail.gmail.com>
Message-ID: <CAMj1kXGxxRs6Rkhevm9NSY6TaJUsOmF3UqdHUo=NRg9kQKtSBA@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
To: Eric Biggers <ebiggers@kernel.org>
Cc: James Prestwood <prestwoj@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Karel Balej <balejk@matfyz.cz>, 
	dimitri.ledkov@canonical.com, alexandre.torgue@foss.st.com, 
	davem@davemloft.net, dhowells@redhat.com, herbert@gondor.apana.org.au, 
	keyrings@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	mcgrof@kernel.org, mcoquelin.stm32@gmail.com, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 21:20, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Thu, Mar 14, 2024 at 04:52:47AM -0700, James Prestwood wrote:
> > IWD uses AF_ALG/keyctl for _all_ its crypto, cipher, and checksum needs.
> > Anything that wifi requires as far as crypto goes IWD uses the kernel,
> > except ECC is the only exception. The entire list of crypto requirements
> > (for full support at least) for IWD is here:
> >
> > https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/tools/test_runner_kernel_config
>
> That's quite an extensive list, and it's not documented in the iwd README.
> Don't you get bug reports from users who are running a kernel that's missing one
> of those options?
>
> > For KEYCTL_PKEY_* specifically we use it for all asymmetric crypto
> > operations, (query), encrypt, decrypt, sign, verify.
> >
> > I'll be honest, the AF_ALG/keyctl support in ELL was mostly done by the time
> > I started working on IWD so I was not aware the documentation was so poor.
> > That is an entirely separate issue than this IMO, and I'm happy to help with
> > getting docs updated to include a proper list of supported features. In
> > addition maybe some automated testing that gets run on kernel builds which
> > actually exercises this API so it doesn't get accidentally get broken in the
> > future? Docs/tests IMO are the proper "fix" here, not telling someone to
> > stop using an API that has existed a long time.
>
> I looked into the history, and it seems the KEYCTL_PKEY_* APIs were added as a
> collaboration between the iwd developers and the kernel keyrings maintainer.
> So, as far as I can tell, it's not that the kernel had an existing API that iwd
> started using.  It's that iwd got some APIs added to the kernel for themselves.
> KEYCTL_PKEY_* don't seem to have been adopted elsewhere; Debian Code Search
> doesn't return any notable results.  keyctl does provide a command-line
> interface to them, but I can't find any users of the keyctl commands either.
>
> Then, everyone disappeared and it got dumped on the next generation of kernel
> developers, who often don't know that this API even exists.  And since the API
> is also poorly specified and difficult to maintain (e.g., changing a seemingly
> unrelated part of the kernel can break it), the results are predictable...  And
> of course the only thing that breaks is iwd, since it's the only user.
>
> It would be worth taking a step back and looking at the overall system
> architecture here.  Is this the best way to ensure a reliable wireless
> experience for Linux users?
>
> Maybe it's time to admit that KEYCTL_PKEY_* was basically an experiment, and a
> different direction (e.g. using OpenSSL) should be taken...
>
> (Another issue with the kernel keyrings stuff is that provides a significant
> attack surface for the kernel to be exploited.)
>
> If you do decide to continue with the status quo, it may be necessary for the
> iwd developers to take a more active role in maintaining this API in order to
> ensure it continues working properly for you.
>
> AF_ALG is on *slightly* firmer ground since it's been around for longer, is
> properly part of the crypto subsystem, and has a few other users.  Unfortunately
> it still suffers from the same issues though, just to a slightly lesser degree.
>

We dropped MD4 because there are no users in the kernel. It is not the
kernel's job to run code on behalf of user space if it does not
require any privileges and can therefore execute in user space
directly.

The fact that AF_ALG permits this is a huge oversight on the part of
the kernel community, and a major maintenance burden. The point of
AF_ALG was to expose hardware crypto accelerators (which are shared
resources that /need/ to be managed by the kernel) to user space, and
we inadvertently ended up allowing the kernel's pure-software
algorithms to be used in the same way.

The fact that we even added APIs to the kernel to accommodate iwd is
even worse. It means system call overhead (which has become worse due
to all the speculation mitigations) to execute some code that could
execute in user space just as well, which is a bad idea for other
reasons too (for instance, accelerated crypto that uses SIMD in the
kernel disables preemption on many architectures, resulting in
scheduling jitter)

Note that in the case of iwd, it is unlikely that the use of AF_ALG
could ever result in meaningful use of hardware accelerators: today's
wireless interfaces don't use software crypto for the bulk of the data
(i.e., the packets themselves) and the wireless key exchange protocols
etc are unlikely to be supported in generic crypto accelerators, and
even if they were, the latency would likely result in worse
performance overall than a software implementation.

So iwd's deliberate choice to use the kernel as a crypto library is
severely misguided. I have made the same point 4 years ago when I
replaced iwd's use of the kernel's ecb(arc4) code with a suitable
software implementation (3 files changed, 53 insertions, 40
deletions). Of course, replacing other algorithms will take more work
than that, but it is the only sensible approach. We all know the cat
is out of the bag when it comes to AF_ALG, and we simply have to
retain all those broken algorithms as executable code at the kernel's
privileged execution level, just in case some user space is still
around that relies on it. But that doesn't mean we cannot be very
clear about our preferred way forward.

