Return-Path: <linux-kernel+bounces-154067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9C38AD712
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECFCCB20E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5111D547;
	Mon, 22 Apr 2024 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AHQvgUt9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8081B1CD2E;
	Mon, 22 Apr 2024 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713823449; cv=none; b=S0NwuI3zd7UdE0Wpy3homKuItYzWuH2TGVGeoTVdUwCQEA0AEUDo87PG6e5G6ByNzA3QhBwjLODysFvQuJqKdu3hBAUqplmknBHSmoqvXuoAj5MUt/RBFHvDhH+dMOIAkvXz5BS/Cm+qtsjtj0atv/aYidlEsjdzV5kVD1Jp3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713823449; c=relaxed/simple;
	bh=jIeuYRRpHR0UWxzlB8ABZBl1/4izL0FuQpPECw+Tdno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYvmG+cYhLMCNgxtFOvGAdJEp9luOSPpItxWZu3wcWxxf5v0jkmCvn0BzUxFnfP/uTwIUdJ+0kI8NkWjnKdM433SV2ReK88a+c9+fbBi4UyUda/cuOahXOcU3z0jFfFWoe2KGniexfO+4gBrtfgEYKzFdSBwqLr/lpUcgqwdjNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AHQvgUt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1270CC113CC;
	Mon, 22 Apr 2024 22:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713823449;
	bh=jIeuYRRpHR0UWxzlB8ABZBl1/4izL0FuQpPECw+Tdno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AHQvgUt9QDnFUQUdFsCTMwf8AOJwkrjlhg7hwLyJHG6poKhV+FnnLqOWOa6wOd6ZC
	 Ve5AZ5EBuwbfXldgULIXkc9T+rlBGrvyq1Kv19rwk4RZNMCwz7QCRj9SXk1K2zJOlg
	 3VUPI22tJjQUpt/lBPyeuiILf4HDfECG7v+yPHTs=
Date: Tue, 23 Apr 2024 00:04:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Sasha Levin <sashal@kernel.org>, helpdesk@kernel.org,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
Message-ID: <2024042311-slinky-musket-fc75@gregkh>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
 <20240417-lively-zebu-of-tact-efc8f3@lemur>
 <e7318984-7ef4-48cd-aae4-1deda3d711a5@leemhuis.info>
 <2024041734-gleeful-freewill-b24b@gregkh>
 <d4853f43-2538-4a92-9ac4-aff5c7b0893e@leemhuis.info>
 <2024041830-karaoke-aspirate-df00@gregkh>
 <655ce2a3-eb04-4ade-999e-23fc5dc5fb3a@leemhuis.info>
 <20240422-stoic-sawfly-of-protection-db8bfe@lemur>
 <20240422224637.01bb3058@sal.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422224637.01bb3058@sal.lan>

On Mon, Apr 22, 2024 at 10:46:37PM +0100, Mauro Carvalho Chehab wrote:
> Em Mon, 22 Apr 2024 15:25:18 -0400
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> escreveu:
> 
> > On Mon, Apr 22, 2024 at 05:49:29PM +0200, Thorsten Leemhuis wrote:
> > > @Greg, BTW: should this be stable+noautosel@kernel.org or have a 
> > > 'vger.'  
> > 
> > No vger, just stable+whatever@kernel.org.
> > 
> > > in it, e.g. stable+noautosel@vger.kernel.org? I assume without 'vger.'
> > > is fine, just wanted to be sure, as
> > > Documentation/process/stable-kernel-rules.rst in all other cases
> > > specifies stable@vger.kernel.org, so people are likely to get confused.
> > > :-/ #sigh  
> > 
> > These serve two different purposes:
> > 
> > stable@kernel.org (goes into devnull)
> > stable@vger.kernel.org (actual mailing list)
> > 
> > Confusion happens all the time, unfortunately.
> 
> Yeah, I did already used stable@kernel.org a few times in the
> past. 
> 
> IMO, the best would be either for stable to also accept it or for
> kernel.org mail server to return an error message (only to the
> submitter) warning about the invalid address, eventually with a
> hint message pointing to the correct value.

stable@kernel.org is there to route to /dev/null on purpose so that
developers/maintainers who only want their patches to get picked up when
they hit Linus's tree, will have happen and not notify anyone else.
This is especially good when dealing with security-related things as we
have had MANY people accidentally leak patches way too early by having
 cc: stable@vger.kernel.org in their signed-off-by areas, and forgetting
to tell git send-email to suppress cc: when sending them out for
internal review.

Having that bounce would just be noisy for the developers involved.

thanks,

greg k-h

