Return-Path: <linux-kernel+bounces-112069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E648874D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F611C2287F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9EE81AAE;
	Fri, 22 Mar 2024 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yfrvu1U/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2514C17589;
	Fri, 22 Mar 2024 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711146567; cv=none; b=LeC19TV5WLBB83RQG2I3IylUr9rVpAN4LnOstS8p2Um3YTGOPufaEdYAqFgAn//yO+LvpgCUy/yz04oFFP6KVWPHezjUEaWW8OfXK1YiwTbkXcBh1bmAJ86nnWsYB+hpZMebQlZrobNuDgq5+1cq4BjmSyJI0c0jWtFOhy2qaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711146567; c=relaxed/simple;
	bh=OYmXPcRz/hhM71/Ak6y2mWSI2AZdABQ0mCMqdj6Hv+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwXPrSoROsHvAqpzD7+Ubbz8ufJJChLCKxM6M45ti0nmdxMavJ3HDFMI98zODqp5rlCPWoWHry+KEun2XZ78ZifRpzoDEN7EpWwfiWypb6+ZdXIAqwqtuGllnGFyKPxvRjig8GcDC5XOuUFKeRa/fvKbJhQRNIPPSilv0GvxRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yfrvu1U/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD6BC433C7;
	Fri, 22 Mar 2024 22:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711146565;
	bh=OYmXPcRz/hhM71/Ak6y2mWSI2AZdABQ0mCMqdj6Hv+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yfrvu1U/BJGu9shuXoAnC8YCF9MGozwb2uRn+f4hbCJV1/SCdGlJxas6knlCf2NVB
	 thF9XuIm5SBVV6s7QWk/gorDlBSTldqgtPk5xfSUTVSOkWWPM5+7iL/OuqwgGpkAJC
	 k5ANzIfdjdT2rhUrFwRWC+0NzFF1e6AeeGV8+JspTmoFl8mwigDZAEHLAGBTJzPknM
	 tJR/gl6Qf3wlrl0Rco2s2bHalXNLnGZb8nmcU6vpddf/ZIMLfRw0zCUbS38T4TIwOD
	 VI4+DFBUHTe/Xi9xGw7XukiDD4quZA8FXFepAOhFLAOBoOBrTD5sAiNj0bdAF9TiTQ
	 ohBkVrjcT+TUg==
Date: Fri, 22 Mar 2024 15:29:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>, David Ahern
 <dsahern@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leonro@nvidia.com>, Jiri
 Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Itay Avraham
 <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Aron Silverton
 <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240322152924.64be7ec4@kernel.org>
In-Reply-To: <20240322214423.GL159172@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
	<Zcx53N8lQjkpEu94@infradead.org>
	<ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
	<20240214175735.GG1088888@nvidia.com>
	<20240304160237.GA2909161@nvidia.com>
	<9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
	<2024032248-ardently-ribcage-a495@gregkh>
	<510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
	<Zf2n02q0GevGdS-Z@C02YVCJELVCG>
	<20240322135826.1c4655e2@kernel.org>
	<20240322214423.GL159172@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 18:44:23 -0300 Jason Gunthorpe wrote:
> On Fri, Mar 22, 2024 at 01:58:26PM -0700, Jakub Kicinski wrote:
> > > Well said, David.
> > > 
> > > I would totally support doing something like this in a fairly generic
> > > way that could be leveraged/instantiated by drivers that will allow
> > > communication/inspection of hardware blocks in the datapath.  There are
> > > lots of different ways this could go, so feedback on this would help get
> > > us all moving in the right direction.  
> > 
> > The more I learn, the more I am convinced that the technical
> > justifications here are just smoke and mirrors.  
> 
> Let's see some evidence of this then, point to some sillicon devices
> in the multibillion gate space that don't have complex FW built into
> their design?

Existence of complex FW does not imply that production systems must
have a backdoor to talk to that FW in kernel-unmitigated fashion.

As an existence proof I give you NICs we use at Meta.
Or old Netronome NICs, you can pick.

> > The main motivation for nVidia, Broadcom, (and Enfabrica?) being to
> > hide as much as possible of what you consider your proprietary
> > advantage in the "AI gold rush".  
> 
> Despite all of those having built devices like this well before the
> "AI gold rush" and it being a general overall design principle for the
> industry because, yes, the silicon technology available actually
> demands it.
> 
> It is not to say you couldn't do otherwise, it is just simply too
> expensive.

I do agree that it is expensive, not sure if it's "too" expensive.
But Linux never promised that our way of doing SW development would
always be the most cost effective option, right? Especially short
term. Or that we'll be competitive time to market.

> > RDMA is what it is but I really hate how you're trying to pretend
> > that it's is somehow an inherent need of advanced technology and
> > we need to lower the openness standards for all of the kernel.  
> 
> Open hardware has never been an "openness standard" for the kernel.

I was in the meeting with a vendor this morning and when explicitly
asked by an SRE (not from my org nor in any way "primed" by me)
whether configuration of some run of the mill PCI thing can be exposed
via devlink params instead of whatever proprietary thing the vendor was
pitching, the vendor's answer was silence and then a pitch of another
proprietary mechanism.

So no, the "open hardware" is certainly not a requirement for the
kernel. But users can't get vendors to implement standard Linux
configuration interfaces, and your proposal will make it a lot worse.

