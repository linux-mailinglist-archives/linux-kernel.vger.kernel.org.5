Return-Path: <linux-kernel+bounces-24133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE9A82B806
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7600DB23C36
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1C559B6F;
	Thu, 11 Jan 2024 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="efzeqXuL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="f3QrsOVo"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F558132;
	Thu, 11 Jan 2024 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705015701;
	bh=JnKyvkyvCozlhB9UYGxUbp/LJ0HPI8f2zjkKwp477Ng=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=efzeqXuLVpwl/M6eWk6o98XfArCftxucPIvEudZAXSIZiFtWLFBDWxexbqOm/Y4iI
	 cL105DyYzjY/Ul1asMvX5NnpZ0/a+Fvstu2ZLh3zYbrlWhasIXLR0LmDtkYocHOHKD
	 VlPykmMVN2WhqV66OQvppMhLiyXHAYNXCq+btKkc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0D4311281E3F;
	Thu, 11 Jan 2024 18:28:21 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id PIqmmRzae-dd; Thu, 11 Jan 2024 18:28:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705015700;
	bh=JnKyvkyvCozlhB9UYGxUbp/LJ0HPI8f2zjkKwp477Ng=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=f3QrsOVo14s15b0h0xmPXPKJFi8zAV76t1HQy/hoh84irV1ZtuYIXxAyUnFYAsWyx
	 WWVzbt9d57bCQPkpz7cAaMHO6cMPiDr//ON00b612ruA1B3MX4p5yxOnp7v/wX4zSA
	 v7t8inrdlCvpERXaUszFws7DUpdG9NJ4pj6pUdrw=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4E8971281C36;
	Thu, 11 Jan 2024 18:28:20 -0500 (EST)
Message-ID: <255e3328bd48c23fbaae0be6d927820d36e14404.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.7+ merge window
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi
	 <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Date: Thu, 11 Jan 2024 18:28:18 -0500
In-Reply-To: <CAHk-=wiHCkxrMCOL+rSGuPxUoX0_GSMLjgs9v5NJg6okxc1NLw@mail.gmail.com>
References: 
	<c5ac3166f35bac3a618b126dabadaddc11c8512d.camel@HansenPartnership.com>
	 <CAHk-=whKVgb27o3+jhSRzuZdpjWJiAvxeO8faMjHpb-asONE1g@mail.gmail.com>
	 <CAHk-=wiHCkxrMCOL+rSGuPxUoX0_GSMLjgs9v5NJg6okxc1NLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-01-11 at 14:47 -0800, Linus Torvalds wrote:
> On Thu, 11 Jan 2024 at 14:36, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > 
> > Stop making a bad pgp experience even worse - for no reason and
> > absolutely zero upside.
> 
> Side note: even getting gpg to show the subkeys was just an exercise
> in frustration.
> 
> For example, I'd expect that when you do
> 
>    gpg --list-key E76040DB76CA3D176708F9AAE742C94CEE98AC85
> 
> it would show the details of that key. No, it does not. It doesn't
> even *mention* that key.

You installed the special "make it even harder to use" version didn't
you?  Because for me (gpg 2.4.3) it gives

jejb@lingrow:~> gpg --list-key E76040DB76CA3D176708F9AAE742C94CEE98AC85
pub   rsa2048 2011-09-23 [SC] [expires: 2026-03-11]
      D5606E73C8B46271BEAD9ADF814AE47C214854D6
uid           [ultimate] James Bottomley
<James.Bottomley@HansenPartnership.com>
uid           [ultimate] James Bottomley <jejb@linux.vnet.ibm.com>
uid           [ultimate] James Bottomley <jejb@kernel.org>
uid           [ultimate] [jpeg image of size 5254]
uid           [ultimate] James Bottomley <jejb@linux.ibm.com>
uid           [ultimate] James Bottomley <jejb@hansenpartnership.com>
sub   nistp256 2018-01-23 [S] [expires: 2024-01-16]
sub   nistp256 2018-01-23 [E] [expires: 2024-01-16]
sub   nistp256 2023-07-20 [A] [expires: 2024-01-16]

Which shows all the subkeys and their expiration dates.  I admit it
doesn't show the fingerprints and you have to know you've requested a
subkey and it's showing the master record.

> Because this is gpg, and the project motto was probably "pgp was
> designed to be hard to use, and by golly, we'll take that to 11".
> 
> And no, adding "-vv" to get more verbose output doesn't help. That
> just makes gpg show more *other* keys.
> 
> Now, obviously, in order to actually show the key I *asked* gpg to
> list, I also have to use the "--with-subkey-fingerprint". OBVIOUSLY.
> 
> I can hear everybody go all Homer on me and say "Well, duh, dummy".
> 
> So yes, I realize that my frustration with pgp is because I'm just
> too stupid to understand how wonderful the UX really is, but my point
> is that you're really making it worse by using pointless features
> that actively makes it all so much less usable than it already is.

OK, OK, I can do longer expiration dates.

> Subkeys and expiration date make a bad experience worse.

I can't really fix the subkeys bit.  The reason I have a signing subkey
is because on my laptop it's TPM resident but with the authorization
password in gnome-keyring, so I unlock it on login (and so, for me, it
just works for all the day to day signing operations).  My master key
is also TPM resident but with a different password that doesn't unlock
on login to try to keep it more secure and because I only need to use
it when extending expiration dates or signing someone else's key.

> Yes, I blame myself for thinking pgp was a good model for tag
> signing. What can I say? I didn't expect people to actively try to
> use every bad feature.

Heh, well to paraphrase Churchill: gpg is the worst key management
system ... except for all the other key management systems out there
..

James


