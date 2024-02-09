Return-Path: <linux-kernel+bounces-60128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB39185002F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E02B1F25335
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C464C2E647;
	Fri,  9 Feb 2024 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMDUSxV8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1327C2134B;
	Fri,  9 Feb 2024 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707518538; cv=none; b=AcG8GpCPB4riu674z5P7+qPqI/dgll/8Tp2qrU0keWNNWyFgQV8fSM0Fpf81AcTOS6sbsWOw6yFKNO2Z0SLLxmBTnC37gQJtOmLdZAWuuoH6hbK1/+Mvmr29aFV6YR+5bKT6K+b5LKJc2mo6diFR36ciN0/P8ouKFiniNGPSkiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707518538; c=relaxed/simple;
	bh=LB2yq/a/dObdaIA/QKejtPmk1xv0qVIDrLv38rM+hwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtTx73wvau0TW1Tq9Mu1vdO8jOW3Gc6/mrc0TAKMv8WLWZzFDPBlvEKQFMLc55pPGt1t0xC/H+jpV6vGf5dclCRzpaqr3mLh59xpSjBDZAUXx9NIgqvmBVjB+w/snjDt8AJ4pmjsE0UCdqC7hJ/mWs1V92FB+A4Np/57SSPvmOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMDUSxV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09679C433C7;
	Fri,  9 Feb 2024 22:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707518537;
	bh=LB2yq/a/dObdaIA/QKejtPmk1xv0qVIDrLv38rM+hwY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FMDUSxV8DcP6+vvHsaIGYsiVQCScFd182quGHHIs1DTBHQv4UIfUKOQ01JVWBaW7o
	 r+ob50tFH7NFzFSIBqpz3IfoKKkPeHX5iz1SEZxVmNdzW+pF90kwrogGbSUmPdPFUs
	 eQPdlhg+uecKlw9hBEA7KLFaokJESE17zQ7RvDGDW1Ibk2G0Lv7f0aOGzjMpF3ueom
	 hIFrA5BjqTnvmUvh197AlJA5YJfGVgOWYik6VtBQLumIafAZFaePTBekqCnYKZeAKU
	 l8Kx6e7rgdSozVkBS5MTpR4S/k+MZwwiQgN4VUQr14/7vZYDJYWBc491hapXmMtvlz
	 goJOJ9U/RPddg==
Message-ID: <2bdc5510-801a-4601-87a3-56eb941d661a@kernel.org>
Date: Fri, 9 Feb 2024 15:42:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
 Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, andrew.gospodarek@broadcom.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207070342.21ad3e51@kernel.org> <ZcRgp76yWcDfEbMy@x130>
 <20240208181555.22d35b61@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240208181555.22d35b61@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/8/24 7:15 PM, Jakub Kicinski wrote:
>>> Ah yes, the high frequency counters. Something that is definitely
>>> impossible to implement in a generic way. You were literally in the
>>> room at netconf when David Ahern described his proposal for this.

The key point of that proposal is host memory mapped to userspace where
H/W counters land (either via direct DMA by a H/W push or a
kthread/timer pulling in updates). That is similar to what is proposed here.

>>>  
>>
>> I was in the room and I am in support of David's idea, I like it a lot,
>> but I don't believe we have any concrete proposal, and we don't have any
>> use case for it in netdev for now, our use case for this is currently RDMA
>> and HPC specific.
>>
>> Also siimilar to devlink we will be the first to jump in and implement
>> the new API once defined, but this doesn't mean I need to throw away the
> 
> I'm not asking to throw it away. The question is only whether you get
> to push it upstream and skirt subsystem rules by posting a "misc" driver
> without even CCing the maintainers on v1 :|

Can you define what you mean by 'skirt subsystem rules'? That's a new
one to me.

BTW, there is already a broadcom driver under drivers/misc that seems to
have a lot of overlap capability wise to this driver. Perhaps a Broadcom
person could chime in.

> 
>> whole driver just because one single use case will be implemented in netdev
>> one day, and I am sure the netdev implementation won't satisfy all the
>> use-cases of high frequency counters:
>>
>> Also keep in mind high frequency counters is a very small part of the debug 
>> and access capabilities the mlx5ctl interface offers.
>>
>>> Anyway, I don't want to waste any more time arguing with you.
>>> My opinion is that the kernel community is under no obligation to carry
>>> your proprietary gateway interfaces. I may be wrong, but I'm entitled
>>> to my opinion.
>>
>> Thanks, I appreciate your honesty, but I must disagree with your Nack, we
>> provided enough argument for why we believe this approach is the right
>> way to go, it is clear from the responses on V3 and from the LWN article
>> that we have the community support for this open source project.
> 
> Why don't you repost it to netdev and see how many acks you get?
> I'm not the only netdev maintainer.

I'll go out on that limb and say I would have no problem ACK'ing the
driver. It's been proven time and time again that these kinds of
debugging facilities are needed for these kinds of complex,
multifunction devices.

