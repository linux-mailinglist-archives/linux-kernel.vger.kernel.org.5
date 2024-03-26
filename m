Return-Path: <linux-kernel+bounces-119564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E8D88CA7D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0E21F83794
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD04120B33;
	Tue, 26 Mar 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="slL/UXig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D9D14A82;
	Tue, 26 Mar 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473182; cv=none; b=HnzHSlbwYcdI9Udu7dao95utK/HHALmb464qgk+jOpIWvphIoyti10/2VS6+LVJfGGhlz6xbiXNg+R8Ha1Ac7pj6TY8UaqLJws3e0hEfDLLTl1cNua5LjNhWXJi5N1evKC9ntpscAOQb8Vor9EHHElnB7fi0e/fYN+d+LsIjDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473182; c=relaxed/simple;
	bh=HFpvbSEvZik1TZ1Ei0VX85c/AP4nPo+Q4x5D6BFOCPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6nqIO69+4dp50UrGJrcjMxBOA1DIAYZ/8P8C+PWNg8MIpdUT5zzdONTwQe85nFFvZK1vmmCyrviiUNdYstaiB4VXDJO1gTDBVLErQa5bZqU3y2lFrbTTUBIkTzRlmh9QCOLCl8j0FZNViUjgwofvPEOi03xnjNmQ7w92NKl7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=slL/UXig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E62BC433C7;
	Tue, 26 Mar 2024 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711473181;
	bh=HFpvbSEvZik1TZ1Ei0VX85c/AP4nPo+Q4x5D6BFOCPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=slL/UXig9Cn6vG9JqKTh9YGBnfdXWCdtIGlKJVbMQnUFTxb0n6PKdfzZew43J+ReY
	 ZjaLJ2Ah74RluYQEyY+L1dunwFSoqd1hddhXhYyDqZdQTSMHlG8OM8F0TqAo7VwQ/X
	 U5/XgihE3nrB5A+Gx2zNKY/natXo1gOJ8Fn7BcxI=
Date: Tue, 26 Mar 2024 18:12:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrew Davis <afd@ti.com>
Cc: Robert Nelson <robertcnelson@gmail.com>,
	Jason Kridner <jkridner@beagleboard.org>,
	Matthijs van Duin <matthijsvanduin@gmail.com>,
	Drew Fustini <drew@beagleboard.org>,
	Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: pruss: Deprecate use of this driver
Message-ID: <2024032658-chosen-salaried-4702@gregkh>
References: <20240325210045.153827-1-afd@ti.com>
 <2024032631-excursion-opposing-be36@gregkh>
 <CAOCHtYjauA+BAxZJBMTaxxaMGcvipP9=ZPeWe4FiNFs_jpq6dg@mail.gmail.com>
 <c2125144-659e-42f2-af1f-ffef7ec3d157@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2125144-659e-42f2-af1f-ffef7ec3d157@ti.com>

On Tue, Mar 26, 2024 at 12:02:09PM -0500, Andrew Davis wrote:
> On 3/26/24 11:19 AM, Robert Nelson wrote:
> > On Tue, Mar 26, 2024 at 12:41 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > On Mon, Mar 25, 2024 at 04:00:45PM -0500, Andrew Davis wrote:
> > > > This UIO driver was used to control the PRU processors found on various
> > > > TI SoCs. It was created before the Remoteproc framework, but now with
> > > > that we have a standard way to program and manage the PRU processors.
> > > > The proper PRU Remoteproc driver should be used instead of this driver.
> > > > Mark this driver deprecated.
> > > > 
> > > > The userspace tools to use this are no longer available, so also remove
> > > > those dead links from the Kconfig description.
> > > > 
> > > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > > ---
> > > >   drivers/uio/Kconfig | 10 ++--------
> > > >   1 file changed, 2 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> > > > index 2e16c5338e5b1..358dc2d19b885 100644
> > > > --- a/drivers/uio/Kconfig
> > > > +++ b/drivers/uio/Kconfig
> > > > @@ -126,19 +126,13 @@ config UIO_FSL_ELBC_GPCM_NETX5152
> > > >          http://www.hilscher.com/netx
> > > > 
> > > >   config UIO_PRUSS
> > > > -     tristate "Texas Instruments PRUSS driver"
> > > > +     tristate "Texas Instruments PRUSS driver (DEPRECATED)"
> > > 
> > > This isn't going to do much, why not just delete the driver entirely if
> > > no one uses it?
> > 
> > CC'ing Matthijs one of our BeagleBoard community members who utilizes
> > and supports UIO on a number of community projects.
> > 
> > We know TI and Mainline in general do not like this UIO driver as it's
> > very open-ended.
> > 
> > While the remoteproc_pruss driver is now mainline (it has taken a long
> > time, since 3.14.x i I think TI first started this..)
> > 
> > There is a large user base of UIO examples that have been running
> > since 3.8.x and as a community we have made sure ( mostly Matthijs )
> > that these continue to operate on this driver in
> > v5.x/v6.x/lts/mainline branches.
> > 
> 
> These users rely on out-of-tree patches to make this driver usable[0].
> In its current state upstream, this driver is not used/usable. Since you
> have to make update patches anyway, why not simply carry the whole driver
> as an out-of-tree patch?
> 
> That is why I was thinking of just marking it deprecated for a cycle
> or two, just to give one last hint that it will be going away soon
> (or you cancarry the driver out-of-tree for however long you want).

No one notices "deprecated" stuff, they only notice if the code is
removed.  So removing it is the only way to pay attention.

But why are out-of-tree changes needed?  If they are needed, why are
they not submitted for us to take so that it is usable by everyone?  Or
is the out-of-tree patches also not supposed to be used?

thanks,

greg k-h

