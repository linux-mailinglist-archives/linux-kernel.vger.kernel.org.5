Return-Path: <linux-kernel+bounces-148495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D218A8378
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CB9285A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0713D614;
	Wed, 17 Apr 2024 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LL4sX48I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D7413CFA6;
	Wed, 17 Apr 2024 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358364; cv=none; b=dBFrqrMYaWhXXedPpLQwVdtx4zcMOiw4yJs1eYCYwZ5lqobnpN/QJfm+gcAGPoLT0wlAc5vXuOB4z7sLjL6ROjs8U7bSyA8cMUUU7PEzDDhd1cSJsXXutQnQ5ItFzadB0Ps+2SNYxJQbsF+CtYQA30rPV/9Z5AUEcrVwTPummOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358364; c=relaxed/simple;
	bh=Nz7+wYG+jYURh6hk+/XPOhpQekQnu4bBKnC3lYMnnNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zt+5lewVL19hVK9Uz6C6bPlpRDjCvVMd98iSTl6OLlKQznZsQixiIAmjEgN4dXxyj8O/f16XGZpxrLZqWsQhXfSmPMDNpyYl9ksRzthpjo79nTUPq/D9xdpYALUhXN1RFNyfnWAvpXV+5H33lWZFTzonZV1Eo/30vE0++x9gjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LL4sX48I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C35C072AA;
	Wed, 17 Apr 2024 12:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713358364;
	bh=Nz7+wYG+jYURh6hk+/XPOhpQekQnu4bBKnC3lYMnnNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LL4sX48I2AcFYvoOzgdkVQ2KOWwGJvgIduohvJuHTpik7Rb3BNvzTiAElJnw5qweR
	 VaD46O8B+utNW4nODcU0idnjzMxxiJ2Qx6dVApQnJCqHtkJ6WsPe6bPDcfnRVO32AR
	 TwsEv4KNu5ddYCUq59WNQBE/fDL1Pb/o3VMGwcJY=
Date: Wed, 17 Apr 2024 08:52:40 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: helpdesk@kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
Message-ID: <20240417-lively-zebu-of-tact-efc8f3@lemur>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>

On Wed, Apr 17, 2024 at 09:48:18AM +0200, Thorsten Leemhuis wrote:
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

That would make it into actual commits and probably irk maintainers and 
Linus, no? I also don't really love the idea of overloading email 
addresses with additional semantics. Using Cc: stable kinda makes sense, 
even if it's not a real email address (but it could become at some 
point), but this feels different.

In general, I feel this information belongs in the patch basement (the 
place where change-id, base-commit, etc goes). E.g.:

    stable-autosel: ignore
    [This fix requires a feature that is only present in mainline]

This allows passing along structured information that can be parsed by 
automated tooling without putting it into the commit.

> There was some discussion about using something shorter, but in the end
> there was no strong opposition and the thread ended a a few days ago.

I feel this is a significant change to the workflow, so I would like the 
workflows list to have another go at this topic. :)

-K

