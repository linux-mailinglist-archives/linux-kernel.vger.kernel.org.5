Return-Path: <linux-kernel+bounces-58934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF5684EED0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC3A1C252AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FBE15CB;
	Fri,  9 Feb 2024 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuT6M5jT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7911847;
	Fri,  9 Feb 2024 02:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707444958; cv=none; b=DqccfleeiZ8fQdlV9mmpYhquqfe7KheD/3Y8jFDLVG1hE8NICAFr7XP3CfAxHTYquhtJU2UMEult3n3Fl//mYWrS8skP7NGCyrVEZldpK5yGmYXEx6K7wNLdjzgYqhPSVCRMwWHpldmap1M3vRWlPOFP0qBSdp+EyAq/Imu0U40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707444958; c=relaxed/simple;
	bh=K41srwnRLdSplv9McebjGI4ImuKEtYaNhWDWRSAPk2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rcwc6xSVWrDkgj/2AzyykipQ+Z6l2LXdqgWSlHyb+cmmQKBGO9mXleCyOfU7yW9jcbdL+l3vKbjzpr5+q6TLFdBUfu5//W56u8WJ2lqTQDoGMmrAv1waWYb3rsSgCvXGMp9nGlxz7FhThscKuMSFXg/hNjYwZehg9bZaH2vDPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuT6M5jT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B96C433C7;
	Fri,  9 Feb 2024 02:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707444957;
	bh=K41srwnRLdSplv9McebjGI4ImuKEtYaNhWDWRSAPk2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RuT6M5jTJijYFyI5SwRwHsw3lH3+l0Mkfq553+hVwJbhBQuNWfKvQnt63DSstFKL8
	 /PTlhj50Af5gLbzj2hxKFOQAw26PD8Xj/j2skaLtvo/U5A1BwYYxtmwB3Pg2hFsHzA
	 G4Fu9q3bzXgP5tVLJcfBQTLMQ76YXYlMlygqgYh3AaXCovwhXrend/cOxF0k4HJuKl
	 iA12vZ7JxkFyIFNJBnhnaOVVBnWeEzUJmzg9p1Ik7w5LpwbzmysjvmjX3jnKMmYAeE
	 y2QGK7LbMUG1m8AlUuVZSDiT6jOTsJRky2fvCliB53wrkvHkH1/9VCFRiEfFS5bUly
	 BPNd5UhN7IYZw==
Date: Thu, 8 Feb 2024 18:15:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Leon Romanovsky <leonro@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, David Ahern <dsahern@kernel.org>, Aron Silverton
 <aron.silverton@oracle.com>, Christoph Hellwig <hch@infradead.org>,
 andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240208181555.22d35b61@kernel.org>
In-Reply-To: <ZcRgp76yWcDfEbMy@x130>
References: <20240207072435.14182-1-saeed@kernel.org>
	<20240207070342.21ad3e51@kernel.org>
	<ZcRgp76yWcDfEbMy@x130>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 21:03:35 -0800 Saeed Mahameed wrote:
> On 07 Feb 07:03, Jakub Kicinski wrote:
> >On Tue,  6 Feb 2024 23:24:30 -0800 Saeed Mahameed wrote:  
> >> From: Saeed Mahameed <saeedm@nvidia.com>
> >>
> >> Recap from V3 discussion:
> >> =========================
> >>
> >> LWN has published an article on this series aptly summarizing the debate.
> >> LINK: https://lwn.net/Articles/955001/
> >>
> >> We continue to think that mlx5ctl is reasonable and aligned with the
> >> greater kernel community values. People have pointed to the HW RAID
> >> miscdevices as a good analog. The MD developers did not get to block HW
> >> RAID configuration on the basis that it undermines their work on the
> >> software RAID stack. Further, while there is a superficial similarity to
> >> the DRM/accel debate, that was grounded in a real concern that DRM values
> >> on open source would be bypassed. That argument does not hold up here as
> >> this does come with open source userspace and the functionality mlx5ctl
> >> enables on lockdown has always been available to ConnectX users through
> >> the non-lockdown PCI sysfs. netdev has been doing just fine despite the
> >> long standing presence of this tooling and we have continued to work with
> >> Jakub on building common APIs when appropriate. mlx5 already implements
> >> a wide range of the netdev common interfaces, many of which were pushed
> >> forward by our staff - the DPLL configuration netlink being a recent
> >> example.  
> >
> >I appreciate Jiri's contributions (and you hired Maciej off of Intel at
> >some point) but don't make it sound like nVidia lead DPLL, or pushed for
> >a common interface :| Intel posted SyncE support. I asked them make it
> >a standalone API family:
>
> I will let the stats speak for itself.
> $ git shortlog -sne --no-merges net/devlink 
> and prior to commit f05bd8ebeb69 devlink: move code to a dedicated directory
> $ git shortlog -sne --no-merges net/core/devlink.c
> 
> More than 70% of the commits are authored by more than 10 different individuals
> form Mellanox/Nvidia .. 

I'm not questioning that there are folks at nVidia who prefer to go 
the generic infrastructure route. Jiri and mlxsw team especially.
I do worry that adding a pass thru interface will undermine them,
but that wasn't my main point.

> Ok you don't like DPLL,

I didn't say I dislike DPLL. I think it's a very odd example for
you to pick for nVidia's contribution. My recollection is:

 - Maciej from Intel started developing upstream API for SyncE support
 - I asked him to generalize it to DPLL, he started working on it
 - nVidia expressed interest in creating a common interface, we thought
   it'd be great to align vendors
 - nVidia hired Maciej from Intel, shutting down Intel's progress for a while
 - nVidia went AWoL, long response times, we held meetings to nudge
   you along, no commitments
 - then after months and months Jiri started helping Arkadiusz and Vadim

I remember thinking at the time that it must have been a terrible
experience for Intel, definitely not how cooperation upstream should
look :|

IDK how disconnected from upstream netdev you have to be to put that on
your banner.

> here is a list of some central devlink features we did 
> push to the devlink standard API:
> 
>   - subfunction API and devlink infrastructure
>   - Shared buffer API
>   - port function and rate API
>   - shared buffer
>   - health 

I guess shared buffer was important enough to mention twice? :)

> >https://lore.kernel.org/netdev/20210830162909.110753ec@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/
> >
> >Vadim from Meta joined in and helped a lot based on the OCP time card.
> >Then after some delaying and weird noises y'all started participating.
> >  
> 
> I remember those discussions, and I agree it is very weird when it
> takes 3 vendors and 2 years to get a simple devlink API for single bit
> flip accepted.

In hindsight it was naive of us to try to wait for nVidia.
It's better to let one vendor blaze the trail and others to follow.

> >>     i) mstreg
> >>       The mlxreg utility allows users to obtain information regarding
> >>       supported access registers, such as their fields  
> >
> >So the access mstreg gives over this interface is read only? That's
> >what your description sounds like, but given your complaints about
> >"inability to add knobs" and "control" in the name of the driver that
> >must be false.
> >  
> 
> Yes this is enforced by the mlx5ctl driver and FW using the special
> debug uid.

So we trust the proprietary FW not to let the proprietary user space
do something out of scope. Got it.

> >> Other usecases with umem:
> >>   - dynamic HW and FW trace monitoring
> >>   - high frequency diagnostic counters sampling  
> >
> >Ah yes, the high frequency counters. Something that is definitely
> >impossible to implement in a generic way. You were literally in the
> >room at netconf when David Ahern described his proposal for this.
> >  
> 
> I was in the room and I am in support of David's idea, I like it a lot,
> but I don't believe we have any concrete proposal, and we don't have any
> use case for it in netdev for now, our use case for this is currently RDMA
> and HPC specific.
> 
> Also siimilar to devlink we will be the first to jump in and implement
> the new API once defined, but this doesn't mean I need to throw away the

I'm not asking to throw it away. The question is only whether you get
to push it upstream and skirt subsystem rules by posting a "misc" driver
without even CCing the maintainers on v1 :|

> whole driver just because one single use case will be implemented in netdev
> one day, and I am sure the netdev implementation won't satisfy all the
> use-cases of high frequency counters:
> 
> Also keep in mind high frequency counters is a very small part of the debug 
> and access capabilities the mlx5ctl interface offers.
> 
> >Anyway, I don't want to waste any more time arguing with you.
> >My opinion is that the kernel community is under no obligation to carry
> >your proprietary gateway interfaces. I may be wrong, but I'm entitled
> >to my opinion.
> 
> Thanks, I appreciate your honesty, but I must disagree with your Nack, we
> provided enough argument for why we believe this approach is the right
> way to go, it is clear from the responses on V3 and from the LWN article
> that we have the community support for this open source project.

Why don't you repost it to netdev and see how many acks you get?
I'm not the only netdev maintainer.

