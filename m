Return-Path: <linux-kernel+bounces-112024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C3A88744B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7524A1F2320C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC3D8005D;
	Fri, 22 Mar 2024 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2s5Tvq4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F4780035;
	Fri, 22 Mar 2024 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711141108; cv=none; b=YJW9vZ0Id5CfSzbX1vWlrZSSiMHbYc4Bz+NWPTEMnm//fRBLxT7xfzEVT+mIl692cH3c5ArZ+zMUs9ovATA+HT+GLA4zmuN0jc6ZUq3q2U+IkzP1zaGlD2IcQzzd53i6QF9ZxqpP0Xwjylhpc0VVzN69G8GuF2CJZVZYXVoUiA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711141108; c=relaxed/simple;
	bh=yhyEMZxsDvueYGMFEsTYsvuwS2GHyBzMIu5h25UX7bE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWOiME1yZBnqg7g2Lhunk+qXuvoc6dwdh27MkxW/kqNkeaRMm562SR3UYpv4+guenjUrYGtU1rcuGMKDornf2uzY2aUNJtbVca//MMT7sPkq06cNYihbHNELJzUFNEggJY7tjoWonIEk7bEyPKZidkgqW6bwIpONWXT8foFTWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2s5Tvq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF80C433C7;
	Fri, 22 Mar 2024 20:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711141108;
	bh=yhyEMZxsDvueYGMFEsTYsvuwS2GHyBzMIu5h25UX7bE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q2s5Tvq4nMva3sh1MPDIxpiMg9JiPJ9GIMFSVRrxQEEc78ewgnlpQtfAFKU4edcDy
	 5MSjTs96RBHawdmInPwZNGu41tqSV3CluJ8psz6xuPUUbBBc8nAhg5lae5WNbU9f1R
	 Lq4ghFnEs8NBbn3/fRjDmYEPYynhIg6Bu7GCvU1W6s0y0mzzSyVF3qJCUwOVtmA79J
	 WlM8pn19PPCVEGcGMpBjT+tXT/1jO+ahqxRMxfg7IHFm3uvuVkQIqDDuRo7LHqWf4o
	 QwMNnGbzttaoe0SB08B0YqOOwnUIkaodASyo0xItYmapVbXu8C7cSHtKPrm9IvT6/7
	 0gCfVfWX9WSJw==
Date: Fri, 22 Mar 2024 13:58:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: David Ahern <dsahern@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Gunthorpe <jgg@nvidia.com>, Christoph
 Hellwig <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Itay Avraham
 <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Aron Silverton
 <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240322135826.1c4655e2@kernel.org>
In-Reply-To: <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
References: <20240207072435.14182-1-saeed@kernel.org>
	<Zcx53N8lQjkpEu94@infradead.org>
	<ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
	<20240214175735.GG1088888@nvidia.com>
	<20240304160237.GA2909161@nvidia.com>
	<9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
	<2024032248-ardently-ribcage-a495@gregkh>
	<510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
	<Zf2n02q0GevGdS-Z@C02YVCJELVCG>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 11:46:27 -0400 Andy Gospodarek wrote:
> > > It's the middle of the merge window, not much we can actually do and
> > > this patch series itself couldn't be applied as-is, so it's hard to see
> > > what could have happened on my end...
> > 
> > The proposal was sent a week before the end of the last development
> > cycle, and I believe the intent was to motivate discussion around a
> > concrete proposal to converge on an acceptable solution before sending
> > patches.
> > 
> > On your end, what would be helpful is either a simple yes this seems
> > reasonable or no you don't like it for reasons X, Y, and Z.
> 
> Well said, David.
> 
> I would totally support doing something like this in a fairly generic
> way that could be leveraged/instantiated by drivers that will allow
> communication/inspection of hardware blocks in the datapath.  There are
> lots of different ways this could go, so feedback on this would help get
> us all moving in the right direction.

The more I learn, the more I am convinced that the technical
justifications here are just smoke and mirrors. The main motivation
for nVidia, Broadcom, (and Enfabrica?) being to hide as much as
possible of what you consider your proprietary advantage in the 
"AI gold rush".

RDMA is what it is but I really hate how you're trying to pretend
that it's is somehow an inherent need of advanced technology and
we need to lower the openness standards for all of the kernel.

