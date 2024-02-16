Return-Path: <linux-kernel+bounces-67933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465FC85733A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C991C21A63
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFB215E8B;
	Fri, 16 Feb 2024 01:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFWM4tjP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EEBE556;
	Fri, 16 Feb 2024 01:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708045815; cv=none; b=MjRenzhx/MMgXf+bhDvcsiuTwMhWgbJlccjSGnn8dVX1zVuFkWX9n3+CBNYbzzeZeBpWV8tmKyYwRWmOhwK/gM7eKW/o4yKK1sKIxGQNZci8LWtxMADyFB+7BAxhGZZm6q0nl3X0NCXCxTC+RFUL/ZczrcL6cYgYA0QOJrBeRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708045815; c=relaxed/simple;
	bh=xLBubupRGpWWe5G03FJEqiwiLIlYHoIS//7jBeX8o28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2m0l4U4tKuEr04OjtXlpLkLgd+fLm5AErkDVRde6SVOVTmAlle3MtVNEZJtWd8EVztCMX+mJZDvV414zdXKfzbAY/gyjGx/lxEadc+2VrztonRHEJ+n1bmMHrX76q5mh/bFIJiIBNqjOh3bz20eqPBBnxx3qq8CvNlaeC6olRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFWM4tjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D78CC433F1;
	Fri, 16 Feb 2024 01:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708045814;
	bh=xLBubupRGpWWe5G03FJEqiwiLIlYHoIS//7jBeX8o28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bFWM4tjPaFcoTo7RAF6R5EbV6kRW4qVOZ/HyEWShES9Gb2Rj7u181bu3uAsHfco27
	 rDiMMCFTKDQjaZTeyWPFKjHllt5/lkJ69lcXj5svrZHVJagRBcusDaGNj0qjKvVOlB
	 9cmm2OHf4tJTkOzvW72UPKlOgZ2VHKpmFUdX6LzccRLHFeg9NxbQUvDe0X/TWZRMuo
	 nveb9/x1LjDXpUui8GxUklgkvLXFYzr1zdKeDoAnwlDJiLgLsfLsQBOSVQb5xQ02SK
	 tDLW5coDBNvFogwqayaDocErHPC0Io9MHB7uoQuJCgScmv/bKnvpU2oNxeSRi2ny1m
	 gOevMz5CJOwFw==
Date: Thu, 15 Feb 2024 17:10:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, Saeed Mahameed
 <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Leon Romanovsky <leonro@nvidia.com>, Jiri
 Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Itay Avraham
 <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, David Ahern
 <dsahern@kernel.org>, Aron Silverton <aron.silverton@oracle.com>,
 andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240215171013.60566d7b@kernel.org>
In-Reply-To: <20240215132138.GK1088888@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
	<Zcx53N8lQjkpEu94@infradead.org>
	<20240214074832.713ca16a@kernel.org>
	<20240215132138.GK1088888@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 09:21:38 -0400 Jason Gunthorpe wrote:
> On Wed, Feb 14, 2024 at 07:48:32AM -0800, Jakub Kicinski wrote:
> > On Wed, 14 Feb 2024 00:29:16 -0800 Christoph Hellwig wrote:  
> > > With my busy kernel contributor head on I have to voice my
> > > dissatisfaction with the subsystem maintainer overreach that's causing
> > > the troubles here.   
> > 
> > Overreach is unfortunate, I'd love to say "please do merge it as part 
> > of RDMA". You probably don't trust my opinion but Jason admitted himself
> > this is primarily for RDMA.  
> 
> "admitted"? You make it sound like a crime. I've been very clear on
> this need from the RDMA community since the first posting.

Sorry, unintentional :) Maybe it's a misunderstanding but my impression
was that at least Saeed was trying hard to make this driver a common
one, not just for RDMA.

> > The problem is that some RDMA stuff is built really closely on TCP,  
> 
> Huh? Since when? Are you talking about soft-iwarp? That is a reasearch
> project and Bernard is very responsive, if you have issues ask him and
> he will help.
> 
> Otherwise the actual HW devices are not entangled with netdev TCP, the
> few iWarp devices have their own TCP implementation, in accordance
> with what the IETF standardized.

There are some things I know either from work or otherwise told me 
in confidence which I can't share. This is very frustrating for
me, and probably for you, sorry :(

> > and given Jason's and co. inability to understand that good fences
> > make good neighbors it will soon start getting into the netdev stack :|  
> 
> I seem to recall you saying RDMA shouldn't call any netdev APIs at
> all. We were unable to agree on where to build the fence for this
> reason.

Last time you were calling into the IPsec stack right? It's not just 
a basic API. IDK how to draw a line, definitely open to suggestions!

> > Ah, and I presume they may also want it for their DOCA products. 
> > So 80% RDMA, 15% DOCA, 5% the rest is my guess.  
> 
> I don't know all details about DOCA, but what I know about runs over
> RDMA.

Well, since you're an RDMA person that's not really saying much
about existence of other parts.

