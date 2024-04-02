Return-Path: <linux-kernel+bounces-128735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74469895ECC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146B1B256FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673515ECC1;
	Tue,  2 Apr 2024 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/BcqB7h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A0415E80C;
	Tue,  2 Apr 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093769; cv=none; b=HwvPkUYsptrkW3Zj7/qIkclWuYJehLPZEZyGtbGrxzCQOz5bmVBeuRXgrIXg8JhJwFdjucFQq0FPjywoca0Sz5Sr+nmesyj6+QsGsuvyTV8ELxE9xkFbQNeNlKzMsesyqddzB+8gJEBgpTpmT7eFqBlK1NkKjQCbsGDVHNNbRjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093769; c=relaxed/simple;
	bh=R77JGoAQZP5S0g5y2bfP8VgjOnnsNP41b6UnDI/qAyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXhzF57nzmxD3V4pVUAUe0+qEmXrQ+gSOhBGbHqM0roTWQloxciYUKLBQQp/fbmjtmCJPKXcIVPXP3/FmS2EHzEnSMLZYYjThCFt5NNRJglhxGiOmdD5cn9uImIyt8o9LeU5br9lq1dUqhFaYuDcQceYrgmyskPJvZlKsRLgt6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/BcqB7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D3EC433F1;
	Tue,  2 Apr 2024 21:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712093768;
	bh=R77JGoAQZP5S0g5y2bfP8VgjOnnsNP41b6UnDI/qAyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h/BcqB7h3KKw6rPNPsob8OeNn++N2NesXRaozpuCALGFb5dmPwqog8SHMB2Ki7yJs
	 WGk9bpU/qzIjCiZDrww4dp/+8yfHoNRNvwtEVPZb7FDpdWN2GU6RKvNxeJZJphHyiM
	 bgaIwuyQWob4F1Z3nY+af37edcbeNx4gdmvvY2jJ4Fww/9/q5y793Xs8FeLvogrzVU
	 /1iotnjH9tOAUIN3/mWUiwiZsbslr9kWO8CGYGLaypYe9TnOMQvorV5VB0OWLzGGSk
	 l/XZpW3/lmWfEZwKJ9LKL4dDKsTqw0heVE80YyN+K1XWLj2ZWM/E+ApcVBSyb8+ih3
	 t4HBIwdScI4YA==
Date: Tue, 2 Apr 2024 14:36:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, David Ahern <dsahern@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig
 <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Aron Silverton <aron.silverton@oracle.com>,
 linux-kernel@vger.kernel.org, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240402143607.0357d71a@kernel.org>
In-Reply-To: <20240402184554.GQ946323@nvidia.com>
References: <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
	<2024032248-ardently-ribcage-a495@gregkh>
	<510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
	<Zf2n02q0GevGdS-Z@C02YVCJELVCG>
	<20240322135826.1c4655e2@kernel.org>
	<e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
	<20240322154027.5555780a@kernel.org>
	<1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
	<20240401123003.GC73174@unreal>
	<20240401075003.70f5cb4b@kernel.org>
	<20240402184554.GQ946323@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 15:45:54 -0300 Jason Gunthorpe wrote:
> On Mon, Apr 01, 2024 at 07:50:03AM -0700, Jakub Kicinski wrote:
> > On Mon, 1 Apr 2024 15:30:03 +0300 Leon Romanovsky wrote:  
> > > HNS driver is a good example of such device. It has nothing to do with
> > > netdev and needs common and reliable way to configure FW.  
> > 
> > Sorry, I have a completely different reading of that thread.
> > Thanks for bringing it up, tho.
> > 
> > As I said multiple times I agree that configuring custom parameters
> > in RDMA is a necessity. Junxian's approach of putting such code in
> > the RDMA driver / subsystem is more than reasonable. Even better,
> > it looks like the API is fairly narrowly defined.  
> 
> Uh, if I understand netdev rules aren't read/write sysfs created from
> drivers banned? 

Neither is that true as an absolute "netdev rule" nor relevant 
to the discussion.

> So reasonable for RDMA but unacceptable to netdev?

I don't know or care what interface guidance you provide.
What I called reasonable is putting that code in RDMA driver
/ subsystem.

> My brain hurts.

Maybe brains are better suited for understanding what other people
say rather than twisting and misinterpreting..

> FWIW, I've been trying to push RDMA away from driver created sysfs for
> a while now. Aside from the API complexity, implementations have
> messed up using the sysfs APIs and resulted in some significant
> problems :(

Sure, agreed, but off-topic.

