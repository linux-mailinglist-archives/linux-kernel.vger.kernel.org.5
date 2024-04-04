Return-Path: <linux-kernel+bounces-131744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCE1898B5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022381C21699
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4572912A172;
	Thu,  4 Apr 2024 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Clz870Dj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26A763F4;
	Thu,  4 Apr 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245462; cv=none; b=Tfkw7vUaq67+Ub0ZNrefeuCol9ycHfYsW6A2TGu6eJrVACJFz0V1u6Ly5Q3V8It/4PQUJ6dkiLgMRKZX8B9cxaXMn6KBWxWR3UGfYBvEveg6r3HPqMLu0JhiO9rB4Chu5/3uD8PvdZs+RqBSOXofx0Muihv0WnxPb+3VBRAYO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245462; c=relaxed/simple;
	bh=XyF/KPOxCX9FXqX/BdsHnu7IbjmJCKAUNKTfXOqk1v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHGxIwLlnbN3BVYFQX76QTY9aCc2YGI7Mf0/myi/9GI81yLt2MGvrL1p9K4TgRJkFhiOE6j8FcLfuY/CRAaluDtB5yndCOSWi26Kf+mPUjisQaT8Offe8XS4gPVF5gOuPiEClpmXX4UAX1Pyx0L4oK5EfLZC/bgaeykSPicJQ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Clz870Dj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7445AC433F1;
	Thu,  4 Apr 2024 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712245461;
	bh=XyF/KPOxCX9FXqX/BdsHnu7IbjmJCKAUNKTfXOqk1v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Clz870DjZTRnsAcEdvUqazZ8PFZrZ10E8IYBcCgZCKJCV3VZb138qfAS8JSNf9Pem
	 FfjAlLdQYoAdf5/pRDobmSfUka9nqNV5MA+d77H77bNqPy+4tEWWmc0iuLjqeikBpU
	 t/YEpw05pNUPEj2VBBmMS2rCVbo4d0FOEW3e8y+Y=
Date: Thu, 4 Apr 2024 17:44:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Do we need a "DoNotBackPort" tag? (was: Re: Hibernate stuck
 after recent kernel/workqueue.c changes in Stable 6.6.23)
Message-ID: <2024040454-playful-tainted-7446@gregkh>
References: <ce4c2f67-c298-48a0-87a3-f933d646c73b@leemhuis.info>
 <ZgylCe48FuOKNWtM@slm.duckdns.org>
 <b6cdb17f-206c-4dff-bb45-a60317e0a55e@leemhuis.info>
 <2024040328-surfacing-breezy-34c6@gregkh>
 <Zg10Keik4KORjXMh@slm.duckdns.org>
 <2024040319-doorbell-ecosystem-7d31@gregkh>
 <dfd87673-c581-4b4b-b37a-1cf5c817240d@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfd87673-c581-4b4b-b37a-1cf5c817240d@leemhuis.info>

On Thu, Apr 04, 2024 at 05:36:42PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 03.04.24 18:10, Greg KH wrote:
> > On Wed, Apr 03, 2024 at 05:22:17AM -1000, Tejun Heo wrote:
> >> On Wed, Apr 03, 2024 at 07:11:04AM +0200, Greg KH wrote:
> >>>> Side note: I have no idea why the stable team backported those patches
> >>>> and no option on whether that was wise, just trying to help finding the best
> >>>> solution forward from the current state of things.
> >>>
> >>> The Fixes: tag triggered it, that's why they were backported.
> 
> Yeah, this is what I assumed.
> 
> >>>>> which would
> >>>>> be far too invasive for -stable, thus no Cc: stable.
> >>>>>
> >>>>> I didn't know a Fixes
> >>>>> tag automatically triggers backport to -stable. I will keep that in mind for
> >>>>> future.
> >>>>
> >>>> /me fears that more and more developers due to situations like this will
> >>>> avoid Fixes: tags and wonders what consequences that might have for the
> >>>> kernel as a whole
> >>>
> >>> The problem is that we have subsystems that only use Fixes: and not cc:
> >>> stable which is why we need to pick these up as well.  Fixes: is great,
> >>> but if everyone were to do this "properly" then we wouldn't need to pick
> >>> these other ones up, but instead, it's about 1/3 of our volume :(
> 
> I'm also well aware of that and do not want to complain about it, as I
> think I grasped why the stable team works like that -- and even think
> given the circumstances it is round about the right approach. I also
> understand that mistakes will always happen.
> 
> Nevertheless this thread and the Bluetooth thing we had earlier this
> week[1] makes me fear that this approach could lead to developer
> avoiding Fixes: tags. And funny thing, that's something that is already
> happening, as I noticed by chance today: "'"A "Fixes" tag has been
> deliberately omitted to avoid potential test failures and subsequent
> regression issues that could arise from backporting."'"[2].
> 
> I wonder if that in the long term might be bad. But well, maybe it won't
> matter much. Still made me wonder if we should have a different solution
> for this kind of problem. Something like this?
> 
>   Cc: <stable@vger.kernel.org> # DoNotBackport
> 
> Or something like this?
> 
>   Cc: <stable@vger.kernel.org> # DoNotBackport - or only after 16 weeks
> in mainline [but I don't care]

We do this today, with stuff like:
	Cc: stable <stable@kernel.org>	# wait for -rc3 to be out

So if people want to do that, they can, the documentation says that you
can give us hints and the like in the # area, and usually we notice them :)

thanks,

greg k-h

