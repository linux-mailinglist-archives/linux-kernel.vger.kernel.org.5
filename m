Return-Path: <linux-kernel+bounces-148604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA88A84F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F621C212D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFBB140386;
	Wed, 17 Apr 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UuTudOMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE813F432;
	Wed, 17 Apr 2024 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361112; cv=none; b=mrumca2dPhj+5Wd6mULRY6KKFbWHJP92z49T2EAah1gZxUiEkbDTV7NhbHTqaChW92PwGfn2eE9IyRogiapq7UfgKXy5Cgqyjf+k1eOKhYqFK6KdadacH2X2mB3JoRBSGYcKiSu3VDqHEIc+jkzzUdG5ZQjkvPx/juRE0Wn4WnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361112; c=relaxed/simple;
	bh=UZD+Ms8pr+WTEw9cpD/15Yj1rj2z0moWejiq6l9MWTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOvfLhwplLkoV8n2X2qR48Xn+7crzdDhuNmhALruhxjWpaMrMy1bYLlRSqdX0NOL2EWT6q95uIIdohkqChZXXBfNT/VRR9m4kIvTWs9i/GyGC+6bFLoJ+uAOiz8qrThQxiPEN6ZoiHsCI30Y4pmz5TnsK1acEceyExBPEJ2igdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UuTudOMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30795C32786;
	Wed, 17 Apr 2024 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713361111;
	bh=UZD+Ms8pr+WTEw9cpD/15Yj1rj2z0moWejiq6l9MWTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UuTudOMFbsObCPDtn2AlF/jkFC67E5iFBGINTsjcLvpUsD/+y1k4yn2EGzaW87JW8
	 qdajHkWKAH+I38bpdwLyHX8AF/cIPWg08tWtF+s8chE89uqWVigb+NnPbFucr7T4sc
	 kwNTGRSmlGqRSrPzycFeLch4ZeW32EaQK/JpTreI=
Date: Wed, 17 Apr 2024 15:38:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	helpdesk@kernel.org,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
Message-ID: <2024041734-gleeful-freewill-b24b@gregkh>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
 <20240417-lively-zebu-of-tact-efc8f3@lemur>
 <e7318984-7ef4-48cd-aae4-1deda3d711a5@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7318984-7ef4-48cd-aae4-1deda3d711a5@leemhuis.info>

On Wed, Apr 17, 2024 at 03:21:12PM +0200, Thorsten Leemhuis wrote:
> On 17.04.24 14:52, Konstantin Ryabitsev wrote:
> > On Wed, Apr 17, 2024 at 09:48:18AM +0200, Thorsten Leemhuis wrote:
> >>
> >> Could you please create the email alias
> >> do-not-apply-to-stable@kernel.org which redirects all mail to /dev/null,
> >> just like stable@kernel.org does?
> >>
> >> That's an idea GregKH brought up a few days ago here:
> >> https://lore.kernel.org/all/2024041123-earthling-primarily-4656@gregkh/
> >>
> >> To quote:
> >>
> >>> How about:
> >>> 	cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and must be present
> >>>
> >>> and we can make that address be routed to /dev/null just like
> >>> <stable@kernel.org> is?
> 
> First, many thx for your feedback.
> 
> > That would make it into actual commits and probably irk maintainers and 
> > Linus, no?
> 
> Yup.
> 
> > I also don't really love the idea of overloading email 
> > addresses with additional semantics. Using Cc: stable kinda makes sense, 
> > even if it's not a real email address (but it could become at some 
> > point), but this feels different.
> 
> Okay.
> 
> > In general, I feel this information belongs in the patch basement (the 
> > place where change-id, base-commit, etc goes). E.g.:
> > 
> >     stable-autosel: ignore
> >     [This fix requires a feature that is only present in mainline]
> > 
> > This allows passing along structured information that can be parsed by 
> > automated tooling without putting it into the commit.
> 
> That afaics makes them useless for the stable team (Greg may correct me
> if I'm wrong here), as they deal with the commits and have no easy,
> fast, and reliable way to look up the patch posting to query this. Or is
> the "patch basement" available somehow in git for each commit and I just
> missed that?

You are correct, as-is, that would make it useless for my tools.

BUT I could, if it's possible, just look up the original in lore somehow
and parse that.  If it's there, does anyone have a "simple" way to map a
git commit back to a lore message if it does NOT have a Link: line in
it?

I guess I should look at setting up a local copy of lei to dig through
the git record of lkml?  But what about patches that aren't cc: to lkml,
I don't want to have to hit lore.kernel.org for each query, that's going
to not be nice.

> Guess in a better world we might use "git notes" for this, but we
> currently do not use them because they iirc are somewhat tricky (they
> are easily lost on rebases iirc is one of the reasons ) -- and starting
> to use them just for this is not worth it.

git notes never works for anything, and everyone always mentions it :)

> >> There was some discussion about using something shorter, but in the end
> >> there was no strong opposition and the thread ended a a few days ago.
> > I feel this is a significant change to the workflow, so I would like the 
> > workflows list to have another go at this topic. :)
> 
> FWIW, we could go back to what I initially proposed: use the existing
> stable tag with a pre-defined comment to mark patches that AUTOSEL et.
> al. should not pick up:
> https://lore.kernel.org/all/c0a08b160b286e8c98549eedb37404c6e784cf8a.1712812895.git.linux@leemhuis.info/

If you can pick a better string, possibly, yes.

But in the end, your proposal seems to imply:

	cc: stable@kernel.org	# Psych!  Just kidding, never backport this!

but really, that's just mean, and again, this is a VERY rare case you
are trying to automate here.  We have MUCH better and simpler ways for
maintainers to not have their subsystems scanned for stuff like this,
why are we spending all of our time on this topic?

thanks,

greg k-h

