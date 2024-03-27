Return-Path: <linux-kernel+bounces-121384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0948888E744
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C362E794A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BDD15B158;
	Wed, 27 Mar 2024 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DpzAXhI/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C8F12E1CF;
	Wed, 27 Mar 2024 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547089; cv=none; b=soeMzzkM9aOVG7VvPngcZQDe8xzplS12WVO6JDJn+7RgdeMyx1Jt3x9HZ5wQdrh1NXKRXa4foMdqmZ3QBL02zTZifWyCJWEnhmrEfVMpCl5LPWR9bxS3FsdtZzN+oGJcNWfVAgAtMjGnI5qwZzXB8Sa3IrjhPB10M5Dhibrc67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547089; c=relaxed/simple;
	bh=VqELWQOnvYkU3cz3wSHVJfGko+hutRcn6FL9Tqpk6Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/6/aA33dlElhEqsrhRDj0yRuyVpVMq/2E5CYo/riauuGaCmN5+/ZZE/F0SUJ6iW+HFOO/2jKdITYnizCpc5SQGUpL4j6dPbL10raEnm3c/BOGCjGsuhcZtNIM+L3rBY4EFavQ+HKH2AQU7ZRdSDNLv5T4/b542lgjAXYwiQhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DpzAXhI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FCCC433F1;
	Wed, 27 Mar 2024 13:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711547089;
	bh=VqELWQOnvYkU3cz3wSHVJfGko+hutRcn6FL9Tqpk6Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpzAXhI/qsyK3MK54fw0OYYBkUHL0CgotTpKx3QZiQKZiYHIR3QgxKISsBlAxrPiv
	 PQfYkTaScmdjkdfxn+EJb5Rqp6jV6z9ndl61IDlN9kfWKPKtOA2NDIZpBeP9yZg7cp
	 R81FYA4zTAxCwqRdtR+eIqVdcWoBFGzhI0Oqt3cA=
Date: Wed, 27 Mar 2024 14:44:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, regressions@lists.linux.dev,
	stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Srivastava <yashsri421@gmail.com>, 1064035@bugs.debian.org
Subject: Re: [regression 5.10.y] linux-doc builds: Global symbol "$args"
 requires explicit package name (did you forget to declare "my $args"?) at
 ./scripts/kernel-doc line 1236.
Message-ID: <2024032738-wifi-persecute-8774@gregkh>
References: <ZeHKjjPGoyv_b2Tg@eldamar.lan>
 <877ciiw1yp.fsf@meer.lwn.net>
 <ZeYoZNJaZ4ejONTZ@eldamar.lan>
 <874jdlsqyy.fsf@meer.lwn.net>
 <ZeZAHnzlmZoAhkqW@eldamar.lan>
 <2024030538-upside-unbutton-fe39@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030538-upside-unbutton-fe39@gregkh>

On Tue, Mar 05, 2024 at 07:46:59AM +0000, Greg Kroah-Hartman wrote:
> On Mon, Mar 04, 2024 at 10:41:50PM +0100, Salvatore Bonaccorso wrote:
> > Hi,
> > 
> > On Mon, Mar 04, 2024 at 01:05:09PM -0700, Jonathan Corbet wrote:
> > > Salvatore Bonaccorso <carnil@debian.org> writes:
> > > 
> > > > Ok. In the sprit of the stable series rules we might try the later and
> > > > if it's not feasible pick the first variant?
> > > 
> > > Well, "the spirit of the stable series" is one of Greg's titles, and he
> > > said either was good...:)
> > 
> > here we go. Please let me know if you need anything changed in the
> > commit message to describe the situation better.
> > 
> > Greg, in the Fixes tag I added the 5.10.y commit as the issue is
> > specific to the 5.10.y series. Is this the correct form to note this?
> 
> Looks good, I'll queue this up after the next round of releases goes
> out, thanks for the patch!

Now finally queued up, sorry for the delay.

greg k-h

