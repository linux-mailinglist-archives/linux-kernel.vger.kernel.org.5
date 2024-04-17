Return-Path: <linux-kernel+bounces-148105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FAE8A7DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A71A7B2291A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B63B7D07A;
	Wed, 17 Apr 2024 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv/2d6ZV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5F16A037;
	Wed, 17 Apr 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341375; cv=none; b=RXv2e0MbgtnZKtkWzzpeJCF85NAfKkKcPlB2OLJtGjR0CKlhaoIsPx/eS6S1kNlD4xz/ylXyL6hqdnsfE7OTSTzAR701P/v1EdpzDPwMrwkXXwR3eg/kA+i4NiUsQOt1oaY5QzOWQieWnsy8wMn6176yjAP4GPtSJ0leNOcylCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341375; c=relaxed/simple;
	bh=qi4dq7ZlMxHgGuIwJZ0/uQx20Y1bZpSQqteB+Lo305U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8LKemAlzRWinMsyeiO3v6NW8o4djy+qGTojavqUtjBslzl8RylV4nJ164JlKY/C8Yz6lWwFCTVRwIT341BYtDe3uFyYv49s7WfulnFBUBHMZZyfW20JqJO01k/sDYt2TpF9qOGvIvDetzEOvReULVBEpVytdU8jbt2r+j18sKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv/2d6ZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B18C072AA;
	Wed, 17 Apr 2024 08:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713341375;
	bh=qi4dq7ZlMxHgGuIwJZ0/uQx20Y1bZpSQqteB+Lo305U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lv/2d6ZVzM67rajDFslSMUivLcQbY9/Q1biq8t0OizHYq8cF3u1PMLxp/9YiBjEka
	 hfu9/NGADg7Lc8GxfhNhMLKn23GdOHTKa23vDaQjqPEwUKo3I2R0z4JgxygI7myD0c
	 ZieFhuTiK+bmJHcKZeeDYNYSn7wPu9e19ltg1i4XbsL+hManp3u+D4GtFt53SdUjH/
	 sbVk8Ny8RDXKhaA6girGhfnXVoquN5XN1s5s+eebaFQUiw4Dr4IvMFR0hQcjGSE8e9
	 dLE2pa7NAE/vE1YKWrL9pl/CSLrFTLQh+amcL507r40fbTnZWIy+Xbrer3gEfqGv7a
	 sf9zbLDWe4aYw==
Date: Wed, 17 Apr 2024 09:09:26 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: helpdesk@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
Message-ID: <20240417090918.77360289@sal.lan>
In-Reply-To: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 17 Apr 2024 09:48:18 +0200
Thorsten Leemhuis <linux@leemhuis.info> escreveu:

> Hi kernel.org helpdesk!
> 
> Could you please create the email alias
> do-not-apply-to-stable@kernel.org which redirects all mail to /dev/null,
> just like stable@kernel.org does?
> 
> That's an idea GregKH brought up a few days ago here:
> https://lore.kernel.org/all/2024041123-earthling-primarily-4656@gregkh/
> 
> To quote:
> 
> > How about:
> > 	cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and must be present
> > 
> > and we can make that address be routed to /dev/null just like
> > <stable@kernel.org> is?  
> 
> There was some discussion about using something shorter, but in the end
> there was no strong opposition and the thread ended a a few days ago.

Heh, a shorter name would make it a lot easier to remember, specially
since not wanting a patch to go to stable is an exception... I bet
I'll never remember the right syntax, needing to look at the docs
every time it would be used.

IMO, something like:
	no-stable
or
	nostable

would do the trick and would be a lot easier to remember.

Btw, IMO, it won't hurt accepting more than one variant that
could be allowed, e. g. using a regular expression like:

	(do)?[-_]?(nt|not?).*stable

at the scripts used by stable developers - and maybe at the ML server - to
catch different variations won't hurt, as it sounds likely that people will
end messing up with a big name like "do-not-apply-to-stable", typing
instead things like:

	do_not_apply_to_stable
	dont-apply-to-stable

and other variants.

Just my 2 cents.

Regards,
Mauro

