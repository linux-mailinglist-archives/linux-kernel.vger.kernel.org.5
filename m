Return-Path: <linux-kernel+bounces-112158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 650AA88765D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9872B21E02
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16D0137E;
	Sat, 23 Mar 2024 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFtXcs4U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E4A31;
	Sat, 23 Mar 2024 01:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711157268; cv=none; b=uIQEJgUSW651o5yg8I5YNDNJfvWFp63hRfsO0hZmCMuULH7c8Ox4mQof9QozEEJEZUKAuuZFjjO4uPp7wJW/wXC3v0E3WOy6bF8Hud9l+e/pXM8u6Gpw/ZNc/c1bDD5QtngFCiXKCqlK5B89f1tCteJwjTjijtLXDV5tkdFehsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711157268; c=relaxed/simple;
	bh=SnJw3WHU7mGXIfMu4X5OwlfqOErDGWfN6ynEqqaOkmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkcWtH520zhgNGQEtjzDF/eg0As8Nc2vlSGeBed0e9FqT+zcIJ8/LAySJ8Rv6rRGsoCIYiYFFSc2j3ebPVM9MoZ3b0Rc6Fk9WGXxFzNrLAbSVl96kRHNIxsY95RG9hNlrZmEHtC2SxKC2tt0MLhOgk3NXPXZgam9BXMYnB+iT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFtXcs4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA87C433F1;
	Sat, 23 Mar 2024 01:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711157267;
	bh=SnJw3WHU7mGXIfMu4X5OwlfqOErDGWfN6ynEqqaOkmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFtXcs4UiPC+Zkt0BcXfyJ69u9R0J549Sy/aI1d4HV2J7RtrutRDdQGru9lMJY00O
	 zPSWuJ2HrnmtZZ/hwEWzDRRPNJv3dZOE1LSzg2GCJ0VOmQ/YfoAoEpB2ww0clVw0NB
	 tGzBJNW4YOq0t6WHPXf2QYdaNDzpX7UgPCl6moTplpdF2cYu/+zuzO5AYY7GuTwmfN
	 mUSEUl/t1mQOhQjOaZAju3CcNSVkGxPI3N5MmOMTUiCby8bVBuQgVlfSnJSCbnjOwv
	 VMSwHGS8QW2MouRZAVcYkYQaac8ypNRM0X5xqIERO1l1R/nL+dCKeNPYt/B35+i6ON
	 a5lU7bsVRaiZA==
Date: Fri, 22 Mar 2024 18:27:45 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leonro@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <Zf4wEV4WPhoATm1C@x130>
References: <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com>
 <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
 <20240322214423.GL159172@nvidia.com>
 <20240322152924.64be7ec4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240322152924.64be7ec4@kernel.org>

On 22 Mar 15:29, Jakub Kicinski wrote:
>On Fri, 22 Mar 2024 18:44:23 -0300 Jason Gunthorpe wrote:
>> On Fri, Mar 22, 2024 at 01:58:26PM -0700, Jakub Kicinski wrote:
>> > > Well said, David.
>> > >
>> > > I would totally support doing something like this in a fairly generic
>> > > way that could be leveraged/instantiated by drivers that will allow
>> > > communication/inspection of hardware blocks in the datapath.  There are
>> > > lots of different ways this could go, so feedback on this would help get
>> > > us all moving in the right direction.
>> >
>> > The more I learn, the more I am convinced that the technical
>> > justifications here are just smoke and mirrors.
>>
>> Let's see some evidence of this then, point to some sillicon devices
>> in the multibillion gate space that don't have complex FW built into
>> their design?
>
>Existence of complex FW does not imply that production systems must
>have a backdoor to talk to that FW in kernel-unmitigated fashion.
>
>As an existence proof I give you NICs we use at Meta.
>Or old Netronome NICs, you can pick.
>

This is not true at all, at least for our NICs. Our NICs do need
non-netdev interfaces at least for debug and monitoring non-netdev
functionality and use-cases at Meta. We can talk about this offline.
Also below you mentioned another one of your vendors using proprietary
mechanism for configuration. So you can't just have it both ways.

It is obvious to everyone that in the AI era, everyone needs
customization, this interface is the proposal for the standardization,
if you cared to look at Jason's proposal you will see how he goes in
length describing how abstraction can happen in user space.

>> > The main motivation for nVidia, Broadcom, (and Enfabrica?) being to
>> > hide as much as possible of what you consider your proprietary
>> > advantage in the "AI gold rush".
>>
>> Despite all of those having built devices like this well before the
>> "AI gold rush" and it being a general overall design principle for the
>> industry because, yes, the silicon technology available actually
>> demands it.
>>
>> It is not to say you couldn't do otherwise, it is just simply too
>> expensive.
>
>I do agree that it is expensive, not sure if it's "too" expensive.
>But Linux never promised that our way of doing SW development would
>always be the most cost effective option, right? Especially short
>term. Or that we'll be competitive time to market.
>
>> > RDMA is what it is but I really hate how you're trying to pretend
>> > that it's is somehow an inherent need of advanced technology and
>> > we need to lower the openness standards for all of the kernel.
>>
>> Open hardware has never been an "openness standard" for the kernel.
>
>I was in the meeting with a vendor this morning and when explicitly
>asked by an SRE (not from my org nor in any way "primed" by me)
>whether configuration of some run of the mill PCI thing can be exposed
>via devlink params instead of whatever proprietary thing the vendor was
>pitching, the vendor's answer was silence and then a pitch of another
>proprietary mechanism.
>

Well, this is why we came up with fwctl interface, so nobody needs to sit
in silence and all vendors can agree to one interface.

We both know devlink params can't scale well enough and accommodate all
vendors and don't forget it's netdev specifc!

>So no, the "open hardware" is certainly not a requirement for the
>kernel. But users can't get vendors to implement standard Linux
>configuration interfaces, and your proposal will make it a lot worse.

Vendors are already using proprietary configuration interfaces, using
direct PCI access via sysfs.. So on the contrary to what you say, this
proposal came to unify vendors, and improve the user's experience..
with fwctl, and the proper use-space shared tooling as Jason's suggested
you can force other vendors to follow the herd and implement the new
standard interfaces that we already have 3 vendors agree to..



