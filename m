Return-Path: <linux-kernel+bounces-60873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F559850A6B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB824281F4A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BE35C611;
	Sun, 11 Feb 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVxrlf6v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461432837D;
	Sun, 11 Feb 2024 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707670899; cv=none; b=juDNsVBkh9PWxBI0y3amyUC8Hg36bLmZShYRr+6PYr+v3ZewBC5X23vUVeSsns8eTm3SyVfCpXluGcytXzzzSFg7lK5dBstGkj4MTLQJjpznaCdM5Zoz4QqITNf8LMNW8MpNDNnSMgUTZjSyipPvy4pc0+CzD8xnQj8KqWCbAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707670899; c=relaxed/simple;
	bh=e6Z2oy34W8X6Wf/2NjUc/VUdRyZnfQp5k22nZ0yw4yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibsKI+JYaqyEdjxxeFwYZrDLw5CZFflK1DHCcQDjNwrpqe4E5lUgG9ZhAAlP8aw+qzs3zhaQs5O2pGvwr4ZSsekKpnScqaFw2MsaZQqaZgSqkXPjhG1xanZ/EQJErewsqYhtuY5Nphzsu3zeL7Q6giNKMNK5Dq6+ruSAcke2iRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVxrlf6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2322C433C7;
	Sun, 11 Feb 2024 17:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707670898;
	bh=e6Z2oy34W8X6Wf/2NjUc/VUdRyZnfQp5k22nZ0yw4yY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JVxrlf6vzJpyAkdJ6PERTVDgZBduqfZgbXJXnlXKWLG3veUC21Le4s6bHqm1+CTcr
	 JurTac2K7is4A27zjF1cnKgJ375rsAHUE6lzB7jUc5mmYyud70slxcFGGhfly33dgF
	 23VdRfr3sLOJTrtiqtIx1I40uzXq+WK/5fqFs6XRIs5NFO0bado0d0K3dZ9cF3bTxO
	 Ox6OVn7GqArloXjZjbRfMYmx12bzuuLofd765lvYViRhaqWS2i8hyRvVgt/VR19yxI
	 C/BbUvFv5hDM05Ic7qOLa795nLaNx8XLqAzAP8wGVMbnJMcy5IiGzIVghMWYa0r93/
	 PTj2xfOAkrkZA==
Message-ID: <24504183-6118-4bf3-9d83-9037cd5635ce@kernel.org>
Date: Sun, 11 Feb 2024 10:01:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leonro@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, andrew.gospodarek@broadcom.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207070342.21ad3e51@kernel.org> <ZcRgp76yWcDfEbMy@x130>
 <20240208181555.22d35b61@kernel.org>
 <2bdc5510-801a-4601-87a3-56eb941d661a@kernel.org>
 <20240209145828.30e1d000@kernel.org>
 <df5d7538-52c6-465c-b250-13532b90c6ae@kernel.org>
 <2024021139-feast-subtitle-f6e3@gregkh>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <2024021139-feast-subtitle-f6e3@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/24 4:03 AM, Greg Kroah-Hartman wrote:
> On Fri, Feb 09, 2024 at 10:01:33PM -0700, David Ahern wrote:
>>>> BTW, there is already a broadcom driver under drivers/misc that seems to
>>>> have a lot of overlap capability wise to this driver. Perhaps a Broadcom
>>>> person could chime in.
>>>
>>> I'm not aware. Or do you mean bcm-vk? That's a video encoder.
>>
>> If that specific piece of S/W is a video encoder, why isn't it under
>> drivers/video? Scanning the code it seems to me to fall under the open
>> channel between userspace and F/W which is a common paradigm. But I do
>> not want this to distract from this patch set; really I was just
>> browsing existing drivers for any overlap.
> 
> It is an "offload-engine" type of thing that was added before we had the
> specific subsystem for it.  It should be moved to drivers/accel/ one of
> these days, want to volunteer to help out with that?  :)
> 

Thanks for the background.

As for volunteering to move it, I believe Broadcom has more kernel
engineers than Enfabrica. :-)


