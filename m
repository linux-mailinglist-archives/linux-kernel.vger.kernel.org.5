Return-Path: <linux-kernel+bounces-60131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C763D85003B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA9D285FFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF436AF6;
	Fri,  9 Feb 2024 22:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1Ijr/+G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FD429D1C;
	Fri,  9 Feb 2024 22:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707519511; cv=none; b=XdCHPHFDwEHPxnumRuczdVbCJP/Sb2zFUMsLHy+ctR6iG0OVH2AVp0yPq1++PkMWrc5ucM45YwbfHbD1/QnKuY1/y1NUGg/2aW9u+0tmcT+E1L23OGUQNZtE9ca5Uw7Xta6MmnI0S+LxZmTL/ntxTsZQjqWkP7zF/Xp1688iCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707519511; c=relaxed/simple;
	bh=M4wRQhJT3T7Q4Gek0ve4RZyq3rxj5DGP5SkKF3gO0NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWH4iaoOCuFLigHbZ9R/7Tc+EJ9GUdTHM9+02qtaRoEJCT8ShygEoG6Y3FzC5NP25qPAYiHvZDvIX2X6z15aQH8HuNgyU2UWdKoR9suXpExT//QpNcVLwePymjt443A2QXewSogCHAggkNqkZzTDTp5FHSd7tHb20mDDLzzDwKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1Ijr/+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B80C433C7;
	Fri,  9 Feb 2024 22:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707519510;
	bh=M4wRQhJT3T7Q4Gek0ve4RZyq3rxj5DGP5SkKF3gO0NQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h1Ijr/+GiV6aCqCrOpsXzxZbI5duN01e1sYF9UuFwmIBsoouyhTMmHV3dlICDgb+9
	 OYscbS4ttfOA0EH795hCEK52216HLbQ4hISCThXwZnwM9TBLVE5TDs0DqTJybH63Gm
	 3JBAfR4VHCk1GDPawaE5wEP79hdBEdi3qTiz8ZEpZ2akg5pojTLpG/qvV9oYnNlio1
	 70DOR9HUkgErPciEodND8Cdw4P6f6ENT7ilvMme9/tBIzGpQ1R67j4zSXLC69suGAV
	 6Ro4yaa2EQBbXgmrj6K54TzcFtqH8VTZF2AqSfCWdCfJ1AwZ2rPzMvfjVDuvF147Bk
	 8UMmZhZwU0vng==
Date: Fri, 9 Feb 2024 14:58:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Leon Romanovsky
 <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Itay Avraham
 <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Aron Silverton
 <aron.silverton@oracle.com>, Christoph Hellwig <hch@infradead.org>,
 andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240209145828.30e1d000@kernel.org>
In-Reply-To: <2bdc5510-801a-4601-87a3-56eb941d661a@kernel.org>
References: <20240207072435.14182-1-saeed@kernel.org>
	<20240207070342.21ad3e51@kernel.org>
	<ZcRgp76yWcDfEbMy@x130>
	<20240208181555.22d35b61@kernel.org>
	<2bdc5510-801a-4601-87a3-56eb941d661a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Feb 2024 15:42:16 -0700 David Ahern wrote:
> On 2/8/24 7:15 PM, Jakub Kicinski wrote:
> >> I was in the room and I am in support of David's idea, I like it a lot,
> >> but I don't believe we have any concrete proposal, and we don't have any
> >> use case for it in netdev for now, our use case for this is currently RDMA
> >> and HPC specific.
> >>
> >> Also siimilar to devlink we will be the first to jump in and implement
> >> the new API once defined, but this doesn't mean I need to throw away the  
> > 
> > I'm not asking to throw it away. The question is only whether you get
> > to push it upstream and skirt subsystem rules by posting a "misc" driver
> > without even CCing the maintainers on v1 :|  
> 
> Can you define what you mean by 'skirt subsystem rules'? That's a new
> one to me.

I mean that Saeed is well aware that direct FW <> user space interfaces
are not allowed in netdev, so he posted this "misc" driver without
CCing us, knowing we'd nack it.

Maybe the baseline question is whether major subsystems are allowed to
set their own rules. I think they should as historically we have a very
broad range of, eh, openness in different fields. Networking is pretty
open because of the necessary interoperability.

> BTW, there is already a broadcom driver under drivers/misc that seems to
> have a lot of overlap capability wise to this driver. Perhaps a Broadcom
> person could chime in.

I'm not aware. Or do you mean bcm-vk? That's a video encoder.

> >> Thanks, I appreciate your honesty, but I must disagree with your Nack, we
> >> provided enough argument for why we believe this approach is the right
> >> way to go, it is clear from the responses on V3 and from the LWN article
> >> that we have the community support for this open source project.  
> > 
> > Why don't you repost it to netdev and see how many acks you get?
> > I'm not the only netdev maintainer.  
> 
> I'll go out on that limb and say I would have no problem ACK'ing the
> driver. It's been proven time and time again that these kinds of
> debugging facilities are needed for these kinds of complex,
> multifunction devices.

Can we have bare minimum of honesty and stop pretending that his is
primarily about debug :|

