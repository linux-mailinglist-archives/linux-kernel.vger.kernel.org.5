Return-Path: <linux-kernel+bounces-150154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F020F8A9B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3B0281404
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B815FD08;
	Thu, 18 Apr 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IVvXmYNi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283331465BA;
	Thu, 18 Apr 2024 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446411; cv=none; b=tEgMAeP/KwXMwgvWN0g6OtGPHSAnTH7zX1Uow2BsXQbzXyHDJZ/XMlzhoDjsqHyviXifWAkxbPOiXnO1Sn7kEguqoj8MtyotAF5ac5x+Eh9UMPjBfUlP03n8yBDY/eMVqvKpJJuvQemKEnfcu4atB76+YmzxLHl1xh35N2J0G8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446411; c=relaxed/simple;
	bh=KuXUfSk6dLkFeMsUCp1jQslKdCD8Ny3LXJ/2zNIWA/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxbtBVkNwSVQ3M1xa92rUf4AdrUZKPHcuOlwq1Agm7Zncbxbg+0yuJOBTTfRVItvU+L4i2SRfOxF8qOa9HBpz3vVGef/bvD2eK/MHxI5xpTwMCiIyFhMolC+TYE9lT+godzoAf89O2Sf1kWKwj3tlfatm32QHz/dbmYIuBrr0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IVvXmYNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D918C113CC;
	Thu, 18 Apr 2024 13:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713446410;
	bh=KuXUfSk6dLkFeMsUCp1jQslKdCD8Ny3LXJ/2zNIWA/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVvXmYNiyrTlIDjyFTweu89H+2IUXocshq92girXgg6rVvtZeruylAc3ltUG1jZmN
	 aDcmWuP7zemzW2Tyr4BSZuVBg9SA1DwzjQOoHGMWmBE4zFCQzLO6L5qXzzvK6l3Q0w
	 HIVbuRulIF0zcIRM3xbYcArxRk0B8T5oTAnhTbbk=
Date: Thu, 18 Apr 2024 15:20:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	helpdesk@kernel.org,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
Message-ID: <2024041830-karaoke-aspirate-df00@gregkh>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
 <20240417-lively-zebu-of-tact-efc8f3@lemur>
 <e7318984-7ef4-48cd-aae4-1deda3d711a5@leemhuis.info>
 <2024041734-gleeful-freewill-b24b@gregkh>
 <d4853f43-2538-4a92-9ac4-aff5c7b0893e@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4853f43-2538-4a92-9ac4-aff5c7b0893e@leemhuis.info>

On Thu, Apr 18, 2024 at 09:04:53AM +0200, Thorsten Leemhuis wrote:
> On 17.04.24 15:38, Greg KH wrote:
> > On Wed, Apr 17, 2024 at 03:21:12PM +0200, Thorsten Leemhuis wrote:
> >> On 17.04.24 14:52, Konstantin Ryabitsev wrote:
> >>> On Wed, Apr 17, 2024 at 09:48:18AM +0200, Thorsten Leemhuis wrote:
> >>>> Could you please create the email alias
> >>>> do-not-apply-to-stable@kernel.org which redirects all mail to /dev/null,
> >>>> just like stable@kernel.org does?
> >>>>
> >>>> To quote:
> >>>>
> >>>>> How about:
> >>>>> 	cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and must be present
> >>>>>
> >>>>> and we can make that address be routed to /dev/null just like
> >>>>> <stable@kernel.org> is?
> >>
> >> FWIW, we could go back to what I initially proposed: use the existing
> >> stable tag with a pre-defined comment to mark patches that AUTOSEL et.
> >> al. should not pick up:
> >> https://lore.kernel.org/all/c0a08b160b286e8c98549eedb37404c6e784cf8a.1712812895.git.linux@leemhuis.info/
> > 
> > If you can pick a better string, possibly, yes.
> 
> What did you think of Konstantin's
> 
> Cc: stable+noautosel@kernel.org # Reason
> 
> That looked like a good solution -- and I wondered why I did not come up
> with that idea myself. Sure, "autosel" would also imply/mean "the
> scripts/tools that look out for Fixes: tags", but does that matter?

We can live with this, sure.  That way no need to change anything on any
kernel.org backend.

thanks,

greg k-h

