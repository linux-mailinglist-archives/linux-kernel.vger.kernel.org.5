Return-Path: <linux-kernel+bounces-91828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E501F871737
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81055B21703
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7817EEF3;
	Tue,  5 Mar 2024 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ynDJrLZj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129B17E777;
	Tue,  5 Mar 2024 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624823; cv=none; b=g/Eyp/cf+TEv2G/M5tfVKW77wzyItq1bIaasVpesEDMXcNSpXbTAwDYHUd2/OI4W18vwbVgQfQZAzaugqBJRhBOG+cPoqkwxpZBeVi1dMtGcSgxq9SrrPLbtDS3TCGDV9WaDSKErmG48EOSD6+atXsqs50MPd3n6itMkhN22g+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624823; c=relaxed/simple;
	bh=FobFuYhuNWplU1QAMbJNX1qSizdU/tw2pWGX143mWxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhdD6Uk0wy/PBBQM+yYNT8HEiBaXJCAH+Nam59BYLwTO1enAuIqROoje5gWVCIWXa+rI6UyW41ZGj1C75W+R/oE/gDT8ZHpLawZ9XCF6WI/YXsxaLramgjKdvzqCA+/PRtPmLq0GWBVqRwzsfTzzQC91cr68l5cGo3D2HfYHCmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ynDJrLZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A40DC433C7;
	Tue,  5 Mar 2024 07:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709624822;
	bh=FobFuYhuNWplU1QAMbJNX1qSizdU/tw2pWGX143mWxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ynDJrLZjms+dg7Z2a6Bv9hu1aGzdCq7mtr+zTM4H31VmSMRMzcwuvBVqZ13Xx5Fbb
	 CqJy5Gwf2BbZ9iKeIwWA3NJ7Gt1ZRFUV+8NMMB7gNL4KFLGMDDCGvkgl63vCDA7gau
	 uAzC42zfqtcJaQZffs6h2GqaEgsuO65+THN1RbfA=
Date: Tue, 5 Mar 2024 07:46:59 +0000
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
Message-ID: <2024030538-upside-unbutton-fe39@gregkh>
References: <ZeHKjjPGoyv_b2Tg@eldamar.lan>
 <877ciiw1yp.fsf@meer.lwn.net>
 <ZeYoZNJaZ4ejONTZ@eldamar.lan>
 <874jdlsqyy.fsf@meer.lwn.net>
 <ZeZAHnzlmZoAhkqW@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeZAHnzlmZoAhkqW@eldamar.lan>

On Mon, Mar 04, 2024 at 10:41:50PM +0100, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Mon, Mar 04, 2024 at 01:05:09PM -0700, Jonathan Corbet wrote:
> > Salvatore Bonaccorso <carnil@debian.org> writes:
> > 
> > > Ok. In the sprit of the stable series rules we might try the later and
> > > if it's not feasible pick the first variant?
> > 
> > Well, "the spirit of the stable series" is one of Greg's titles, and he
> > said either was good...:)
> 
> here we go. Please let me know if you need anything changed in the
> commit message to describe the situation better.
> 
> Greg, in the Fixes tag I added the 5.10.y commit as the issue is
> specific to the 5.10.y series. Is this the correct form to note this?

Looks good, I'll queue this up after the next round of releases goes
out, thanks for the patch!

greg k-h

