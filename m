Return-Path: <linux-kernel+bounces-125730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F17E9892B44
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 14:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761551F21CA4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34214219F0;
	Sat, 30 Mar 2024 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="k7ZkZ0kL";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="k7ZkZ0kL"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8782EFC17;
	Sat, 30 Mar 2024 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711804198; cv=none; b=msGf8CqcdmNeggNMg/HufFCOaYLKDCEWxuH3O/HYKutQkZ8dqKrJKxFTgIAbVfUpzXHxMzCrVvvB60xEHZcVAXZOTIhF344HXeNyftmdq2n3pWpWXTEQD1MKM4ENdiTmmtUT6NrFUm2FDeB4w0fPsSRDoH50rHOJx1oPPXHiP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711804198; c=relaxed/simple;
	bh=c8vGuGwO3AQu+ZaWNspJpBlAkE/1kfO3BpTmIYNdLVY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=koWJdVTSseW/8e2uUM6ICEAmEyd8jACBtp+FVrlMFBK4bjfLXSxLUwl17iJ6Q4/WRy5upZmg4uUPcdR3iidAA5Q0z4E9KQVg020dzp93l+0LaapYMKDoZ36p6gZU8MMaC/WJGpnWCimgg2DXlN+dcSfwVsBkkKDHygzf4/shaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=k7ZkZ0kL; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=k7ZkZ0kL; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1711804194;
	bh=c8vGuGwO3AQu+ZaWNspJpBlAkE/1kfO3BpTmIYNdLVY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=k7ZkZ0kLppSHzm1nkkO3q6EXCLJvU15p7Y4lbbnMyqVOXBCvW0tp296hLlQGhA2Mb
	 jSg9QmE2PwlaiJmeLeshYuQjGJ5h+N6dpUEvCH6roKM76amz8+xqYcj29OBdCFvdGG
	 PkR0QzcjCtuLmBPEQNJv3VQRXqxYHYtYx1SC/Grg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id F01A11280C22;
	Sat, 30 Mar 2024 09:09:54 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id xc_84SD9HvHL; Sat, 30 Mar 2024 09:09:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1711804194;
	bh=c8vGuGwO3AQu+ZaWNspJpBlAkE/1kfO3BpTmIYNdLVY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=k7ZkZ0kLppSHzm1nkkO3q6EXCLJvU15p7Y4lbbnMyqVOXBCvW0tp296hLlQGhA2Mb
	 jSg9QmE2PwlaiJmeLeshYuQjGJ5h+N6dpUEvCH6roKM76amz8+xqYcj29OBdCFvdGG
	 PkR0QzcjCtuLmBPEQNJv3VQRXqxYHYtYx1SC/Grg=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EB8D31280A41;
	Sat, 30 Mar 2024 09:09:53 -0400 (EDT)
Message-ID: <087bbfcf95c9014ee8f87d482773244f0833b892.camel@HansenPartnership.com>
Subject: Re: [PATCH] KEYS: Add ECDH support
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Eric Biggers <ebiggers@kernel.org>, Zhang Yiqun
 <zhangyiqun@phytium.com.cn>
Cc: dhowells@redhat.com, jarkko@kernel.org, corbet@lwn.net, 
	keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Date: Sat, 30 Mar 2024 09:09:51 -0400
In-Reply-To: <20240330070436.GA2116@sol.localdomain>
References: <20240330065506.3146-1-zhangyiqun@phytium.com.cn>
	 <20240330070436.GA2116@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-03-30 at 00:04 -0700, Eric Biggers wrote:
> [+Cc linux-crypto]
> 
> On Sat, Mar 30, 2024 at 02:55:06PM +0800, Zhang Yiqun wrote:
> > This patch is to introduce ECDH into keyctl syscall for
> > userspace usage, containing public key generation and
> > shared secret computation.
> > 
> > It is mainly based on dh code, so it has the same condition
> > to the input which only user keys is supported. The output
> > result is storing into the buffer with the provided length.
> > 
> > Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
> > ---
> >  Documentation/security/keys/core.rst |  62 ++++++
> >  include/linux/compat.h               |   4 +
> >  include/uapi/linux/keyctl.h          |  11 +
> >  security/keys/Kconfig                |  12 +
> >  security/keys/Makefile               |   2 +
> >  security/keys/compat_ecdh.c          |  50 +++++
> >  security/keys/ecdh.c                 | 318
> > +++++++++++++++++++++++++++
> >  security/keys/internal.h             |  44 ++++
> >  security/keys/keyctl.c               |  10 +
> >  9 files changed, 513 insertions(+)
> >  create mode 100644 security/keys/compat_ecdh.c
> >  create mode 100644 security/keys/ecdh.c
> 
> Nacked-by: Eric Biggers <ebiggers@google.com>
> 
> The existing KEYCTL_PKEY_*, KEYCTL_DH_COMPUTE, and AF_ALG are causing
> enough problems.  We do not need any more UAPIs like this.  They are
> hard to maintain, break often, not properly documented, increase the
> kernel's attack surface, and what they do is better done in
> userspace.

Actually that's not entirely true.  There is a use case for keys which
is where you'd like to harden unwrapped key handling and don't have the
ability to use a device.  The kernel provides a harder exfiltration
environment than user space, so there is a use case for getting the
kernel to handle operations on unwrapped keys for the protection it
affords the crytpographic key material.

For instance there are people who use the kernel keyring to replace
ssh-agent and thus *reduce* the attack surface they have for storing
ssh keys:

https://blog.cloudflare.com/the-linux-kernel-key-retention-service-and-why-you-should-use-it-in-your-next-application/

The same thing could be done with gpg keys or the gnome keyring.

> Please refer to the recent thread
> https://lore.kernel.org/linux-crypto/CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz/T/#u
> where these issues were discussed in detail.

This thread was talking about using the kernel for handling the
algorithms themselves (which is probably best done in userspace) and
didn't address using the kernel to harden the key protection
environment.

James


