Return-Path: <linux-kernel+bounces-126095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C81289321C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA303281890
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557E145345;
	Sun, 31 Mar 2024 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph86thnc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC6A42AA8;
	Sun, 31 Mar 2024 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711899863; cv=none; b=QJXUM2iB5zjRRPQ3m5vNs93AnQ8PinYcFREE606oAKvIJ/dzvq6RE855c4ROgiN0vSOX94JTQpcQ9EcPKhviTy6DBjnNt1Nlt7BfwclXCWn+bICz5mc47SomPZ60rjGeaehQvmECyxufuJlE7QllMVT/jMzp1FkN/8ny6qGwQaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711899863; c=relaxed/simple;
	bh=q1Npa18Wizh6/4uiTHvbZ8rFvZTNTBODkLJ1YPWT1FI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=evdSzpTNmhegsmF57kJlJ7jtwxlMCgotPQzvg8uuYsDSOsmc0YCx7HWWdSIsWNpuK4VpqWS1XVvM+NzWOU7EcNrrIFHYFNItFekNjDnMf3D5hdfc+7aKViSORyjOkYt0Wn0O4IwFBaax24QXvZw/LFob3AUINobr8GVwYMjUOFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph86thnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC13C433F1;
	Sun, 31 Mar 2024 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711899863;
	bh=q1Npa18Wizh6/4uiTHvbZ8rFvZTNTBODkLJ1YPWT1FI=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=Ph86thnclnSfEqHvIDP9jW7oEn3M6Lhdxx/k4DYJc8TGRfTpg5gDW8aCOXmVWR3b1
	 dvZFTWq6k6S+n3NoIo9/ewowefwouVuUH2Lsrmdi4QKxB8E31QMbQ1QMw1cpOSV9nM
	 ETH7HoScRTcq6diU12g5ql8AcaCmZfgcoQV6igmkNEwDYc0lizCHC56/knbFZHxdMk
	 e2Oj5J5c5u+P9wIqZX7/OdA6DT+/vbp2b6Fo4FcC9Bk+bq8TNBx9A32Z2wDD/HjyBm
	 0J8Hhj1caIReMGxz54trt7au1YJFRul/wTev7lFnctxi7lcOMOLcqbabQPZZS/ZOGO
	 VAnx17AKB9RnA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 Mar 2024 18:44:19 +0300
Message-Id: <D081UQF5758Q.3TO9YN0PEQ0O1@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "Zhang Yiqun" <zhangyiqun@phytium.com.cn>
Cc: <dhowells@redhat.com>, <corbet@lwn.net>, <keyrings@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] KEYS: Add ECDH support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240330065506.3146-1-zhangyiqun@phytium.com.cn>
 <20240330070436.GA2116@sol.localdomain>
 <087bbfcf95c9014ee8f87d482773244f0833b892.camel@HansenPartnership.com>
In-Reply-To: <087bbfcf95c9014ee8f87d482773244f0833b892.camel@HansenPartnership.com>

On Sat Mar 30, 2024 at 3:09 PM EET, James Bottomley wrote:
> On Sat, 2024-03-30 at 00:04 -0700, Eric Biggers wrote:
> > [+Cc linux-crypto]
> >=20
> > On Sat, Mar 30, 2024 at 02:55:06PM +0800, Zhang Yiqun wrote:
> > > This patch is to introduce ECDH into keyctl syscall for
> > > userspace usage, containing public key generation and
> > > shared secret computation.
> > >=20
> > > It is mainly based on dh code, so it has the same condition
> > > to the input which only user keys is supported. The output
> > > result is storing into the buffer with the provided length.
> > >=20
> > > Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
> > > ---
> > > =C2=A0Documentation/security/keys/core.rst |=C2=A0 62 ++++++
> > > =C2=A0include/linux/compat.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > > =C2=A0include/uapi/linux/keyctl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +
> > > =C2=A0security/keys/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +
> > > =C2=A0security/keys/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > > =C2=A0security/keys/compat_ecdh.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 50 +++++
> > > =C2=A0security/keys/ecdh.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 318
> > > +++++++++++++++++++++++++++
> > > =C2=A0security/keys/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 44 ++++
> > > =C2=A0security/keys/keyctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +
> > > =C2=A09 files changed, 513 insertions(+)
> > > =C2=A0create mode 100644 security/keys/compat_ecdh.c
> > > =C2=A0create mode 100644 security/keys/ecdh.c
> >=20
> > Nacked-by: Eric Biggers <ebiggers@google.com>
> >=20
> > The existing KEYCTL_PKEY_*, KEYCTL_DH_COMPUTE, and AF_ALG are causing
> > enough problems.=C2=A0 We do not need any more UAPIs like this.=C2=A0 T=
hey are
> > hard to maintain, break often, not properly documented, increase the
> > kernel's attack surface, and what they do is better done in
> > userspace.
>
> Actually that's not entirely true.  There is a use case for keys which
> is where you'd like to harden unwrapped key handling and don't have the
> ability to use a device.  The kernel provides a harder exfiltration
> environment than user space, so there is a use case for getting the
> kernel to handle operations on unwrapped keys for the protection it
> affords the crytpographic key material.
>
> For instance there are people who use the kernel keyring to replace
> ssh-agent and thus *reduce* the attack surface they have for storing
> ssh keys:
>
> https://blog.cloudflare.com/the-linux-kernel-key-retention-service-and-wh=
y-you-should-use-it-in-your-next-application/
>
> The same thing could be done with gpg keys or the gnome keyring.

Eric has a correct standing given that the commit message does not have
motivation part at all.=20

With a description of the problem that this patch is supposed to solve
this would be more meaningful to review.

BR, Jarkko

