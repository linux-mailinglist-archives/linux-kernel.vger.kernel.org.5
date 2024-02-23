Return-Path: <linux-kernel+bounces-78154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3245C860F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC0C1F2880C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7E07E787;
	Fri, 23 Feb 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2HjcuNN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30B67C7D;
	Fri, 23 Feb 2024 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684730; cv=none; b=pCR/QhomsLymZ8iVrBa1DgzcZFFRS2gXHJb1hNtViRBpYuDpZJI6vLry5pXNSGXfF96quzsKHvi/2zjY2AtE/Fi5j9vGeR7ifU1gt7VXs+2VzPQBd5x9WE3AVMXXQ9NTL8SrrIWBWpimmyayYLMwg89f/o73U9fpwAngoO2Wiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684730; c=relaxed/simple;
	bh=NWT5bX994Gc9URSqTJ1uQ/MVapIMzP60ER2OflZLuLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkdVSY2y3vhycJzy+3QgAkiiCqy7at0z8HM2APMwuaWZfk3XakvUEs4+DapT+0ADZbIC1bt5OCktAwwtViqTfd/4CMJdDDp3G8zZ7a+FyOwHCbYYcvFQjwCpXTPQvQjLDqxbnwLQhcENUjfvO/7DLvb1CSeIPUJ2U22KlYblBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2HjcuNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDDAC433C7;
	Fri, 23 Feb 2024 10:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708684730;
	bh=NWT5bX994Gc9URSqTJ1uQ/MVapIMzP60ER2OflZLuLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r2HjcuNNUujkUWMNDNnrB78JazeIbOj63Yi6su96i4X1jHKfp+xNSEA+JErWEz3r+
	 ZhCP+6MzK7joA79HaNeDScuq08FfZidzymx3wWrBVCF3kv4zJV+knzxB5QZF06Wh9D
	 ayjLt+1eFkSpXsU0G3AYZuytji4M94H4Er3PpEHCAUyZTv7lmG/EHA/3tQJ8KZgja4
	 1p/HW8uThdRxNOSLfBLdS/TbtwGO1Ze83JzlfXwYiwu8kpAutImi6gSzcB2RlpKpc4
	 9tmIjQDK5WDf2koNRQoVNCvqc8gzyHbTmhwVPzBY7hExmClb1fjq3c1o2alhjh6u//
	 CiVB5R+MMpy/w==
Date: Fri, 23 Feb 2024 10:38:45 +0000
From: Lee Jones <lee@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Justin Stitt <justinstitt@google.com>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v2] checkpatch: add check for snprintf to scnprintf
Message-ID: <20240223103845.GP10170@google.com>
References: <20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com>
 <bccc704fc78b362bbc57a79eb240219f5ec1548e.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bccc704fc78b362bbc57a79eb240219f5ec1548e.camel@perches.com>

On Wed, 21 Feb 2024, Joe Perches wrote:

> On Wed, 2024-02-21 at 22:11 +0000, Justin Stitt wrote:
> > I am going to quote Lee Jones who has been doing some snprintf ->
> > scnprintf refactorings:
> > 
> > "There is a general misunderstanding amongst engineers that
> > {v}snprintf() returns the length of the data *actually* encoded into the
> > destination array.  However, as per the C99 standard {v}snprintf()
> > really returns the length of the data that *would have been* written if
> > there were enough space for it.  This misunderstanding has led to
> > buffer-overruns in the past.  It's generally considered safer to use the
> > {v}scnprintf() variants in their place (or even sprintf() in simple
> > cases).  So let's do that."
> > 
> > To help prevent new instances of snprintf() from popping up, let's add a
> > check to checkpatch.pl.
> > 
> > Suggested-by: Finn Thain <fthain@linux-m68k.org>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Changes in v2:
> > - Had a vim moment and deleted a character before sending the patch.
> > - Replaced the character :)
> > - Link to v1: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v1-1-3ac5025b5961@google.com
> > ---
> > From a discussion here [1].
> > 
> > [1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@linux-m68k.org/
> 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -7012,6 +7012,12 @@ sub process {
> >  			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
> >  		}
> >  
> > +# snprintf uses that should likely be {v}scnprintf
> > +		if ($line =~ /\bsnprintf\s*\(\s*/) {
> > +				WARN("SNPRINTF",
> > +				     "Prefer scnprintf over snprintf\n" . $herecurr);
> 
> There really should be some sort of reference link here
> similar to the one above this.
> 
> Also, I rather doubt _all_ of these should be changed just
> for churn's sake.

This is for new implementations only.

Kees is planning on changing all of the current instances kernel-wide.

> Maybe add a test for some return value use like
> 
> 		if (defined($stat) &&
> 		    $stat =~ /$Lval\s*=\s*snprintf\s*\(/) {
> 			etc...
> 
> Maybe offer to --fix it too.
> 

-- 
Lee Jones [李琼斯]

