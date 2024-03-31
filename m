Return-Path: <linux-kernel+bounces-126065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3548931A4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6032823EB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C67144D32;
	Sun, 31 Mar 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="La0soKW7";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LIaNafrJ"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB92144D13;
	Sun, 31 Mar 2024 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711890091; cv=none; b=WvPUzngRrOueRnV2Pefx7mhU0th7omOAAc1MJxjuJSUf32+EJx8TepY8Fc8CQsxJGE2OazLxCc6eKXZRETcm9d9izt7jpXVnayY8hFQrEQ3zeo4znXKJXTe3Qmt7XkNH2cjMZsu66ouqeZT54uGco7AYaN50ebJJGlVK2yF84SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711890091; c=relaxed/simple;
	bh=sDzCySBGc78kD08nnzcKeQyX2gLEvAv/rzqBNe7+CzE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JAUKzYw/ASKD64KJvM7Xd0b5VY226JCVMy8cTgvY5DPDVHki8JuJuIpSDniIMzQ2nQnyZYPGtMx6sQnr7lGP9wUa0gWccOerz7z5lCeiK5Vp/mosWK7T9MjxDT0fH5qF3xlyYNm9U3xgFtHlYW17DPut+uMZyi2Syu4nOL6ZmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=La0soKW7; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=LIaNafrJ; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1711890086;
	bh=sDzCySBGc78kD08nnzcKeQyX2gLEvAv/rzqBNe7+CzE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=La0soKW7NsRuUh/rimdDOLzAak0a7z/Qw3VmW2h3qshwBezBO5N3vU/HF9TuASSWc
	 0qt0SsBU/ZTMqwKWrILa0XyIzUDlKvvMNKcysxp8NWXhobpVolWbTiYflaiOrH0m0C
	 47Tzc2C90RKkz2eV4O1rxIxzuAkw2yv48odeT06E=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 73D90128681D;
	Sun, 31 Mar 2024 09:01:26 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id AfUzaoxOPFxH; Sun, 31 Mar 2024 09:01:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1711890085;
	bh=sDzCySBGc78kD08nnzcKeQyX2gLEvAv/rzqBNe7+CzE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=LIaNafrJKwQC0PlYtqfoiToK8eAAYjZpQpkUkk1ND3I5lmO3goivsbWpHTLCHbvPX
	 w7fy0842lTmLlXDwWGLvY5ZQRMnkraJJcVByghLoNujPf+1fHAuB5xXh6FTMV4STZD
	 1XLB/XMN63MHZOyGAlVmsFDA4kzSgKOx1V4MjlpY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1659512867AB;
	Sun, 31 Mar 2024 09:01:25 -0400 (EDT)
Message-ID: <fbc4bb78b39ab5b088b215cf854487022e59bbb4.camel@HansenPartnership.com>
Subject: Re: [PATCH] KEYS: Add ECDH support
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Zhang Yiqun <zhangyiqun@phytium.com.cn>, dhowells@redhat.com, 
	jarkko@kernel.org, corbet@lwn.net, keyrings@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Date: Sun, 31 Mar 2024 09:01:22 -0400
In-Reply-To: <20240331004844.GA104623@sol.localdomain>
References: <20240330065506.3146-1-zhangyiqun@phytium.com.cn>
	 <20240330070436.GA2116@sol.localdomain>
	 <087bbfcf95c9014ee8f87d482773244f0833b892.camel@HansenPartnership.com>
	 <20240331004844.GA104623@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-03-30 at 17:48 -0700, Eric Biggers wrote:
> On Sat, Mar 30, 2024 at 09:09:51AM -0400, James Bottomley wrote:
[...]
> > For instance there are people who use the kernel keyring to replace
> > ssh-agent and thus *reduce* the attack surface they have for
> > storing
> > ssh keys:
> > 
> > https://blog.cloudflare.com/the-linux-kernel-key-retention-service-and-why-you-should-use-it-in-your-next-application/
> > 
> > The same thing could be done with gpg keys or the gnome keyring.
> 
> First, that blog post never actually said that the "replace ssh-agent
> with kernel keyrings" idea was deployed.  It sounds like a proof of
> concept idea that someone thought was interesting and decided to blog
> about.  Upstream OpenSSH has no support for Linux keyrings.

The openssh community is incredibly resistant to out of house
innovation.  It has no support for engine or provider keys, for TPM
keys, or for that systemd start patch xz just exploited ...

>   It seems unlikely it would get added, especially given the OpenSSH
> developers' healthy skepticism of using broken Linux-isms.
> You're welcome to bring it up on openssh-unix-dev and get their buy-
> in first.

I also didn't say just openssh.  You picked the one you apparently know
hardly ever accepts anyone else's ideas.  I don't disagree that finding
implementors is reasonable ... I just wouldn't pick openssh as the
first upstream target.

> Second, as mentioned by the blog post, the kernel also does not
> support private keys in the default OpenSSH format.  That sort of
> thing is an example of the fundamental problem with trying to make
> the kernel support every cryptographic protocol and format in
> existence.  Userspace simply has much more flexibility to implement
> whatever it happens to need.

That's a complete red herring.  You don't need the kernel keyrings to
support every format, you just need a user space converter to import to
the kernel keyring format.  Every device or token that can replace key
handling has their own internal format and they all come with importers
that do conversion.

> Third, ssh-agent is already a separate process, and like any other
> process the kernel enforces isolation of its address space.  The
> potential loopholes are ptrace and coredumps, which ssh-agent already
> disables, except for ptrace by root which it can't do alone, but the
> system administrator can do that by setting the ptrace_scope sysctl
> to 3 or by using SELinux.

Well, a) this doesn't survive privilege escalation and b) I don't think
many people would buy into the notion that we should remove security
functions from the kernel and give them to userspace daemons because
it's safer.

James


