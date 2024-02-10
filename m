Return-Path: <linux-kernel+bounces-60283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF3C850299
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 06:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32531F25B06
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 05:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C198263BF;
	Sat, 10 Feb 2024 05:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJWiDHWM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3AB63B3;
	Sat, 10 Feb 2024 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707541296; cv=none; b=KrgqQpZR4JQ9iP/Me5kGufKb9sDlFUvqLEaVFYfruR2yHLW/eEKUrDD0aF5Y666m+whaxTdD7pmOI4HoI1K3WfQGgV4oJ4K8ymR5glnfMxyvbISmr5PYMMwUO2TLW3YcbIM626b2tsKAXHpAcVuC9R/SZXWRE8Kf892agV4ubpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707541296; c=relaxed/simple;
	bh=yW4SvVrA+uehcZQFBiIcKyOq0EVCxgF6A4J8ysbpmiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmjGr4OKN831LZiDEdFu6wmaQYHwxEX8+MXPuMW/HB3VjXRBkxjk0w4FFEzYiXYvXkrS/4aJkak6krkcL2VvFlJdJw0277lJSoYVOZDX82UIY38u1Wz3STp9ekN+JYRAGyVJM3z1HZkq7ML5c/o4zwGLcFtRD+J9DkXKnrQhdI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJWiDHWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE721C433F1;
	Sat, 10 Feb 2024 05:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707541295;
	bh=yW4SvVrA+uehcZQFBiIcKyOq0EVCxgF6A4J8ysbpmiA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oJWiDHWMZ0LfZy1Zfi2dBv4UYV01xbt7wXuSND3b8/ImOt3cxgcVeqomVQTtFn5UB
	 p8pI2WeLidOtXtg2LKs4P7KZoJ24uxYZWt4tt1hA8RMad4j9qxKnlKY+JpW/frjvb1
	 tZPA9WaN2pu/Lb8TgiKQbXEwU0s1DxqhaF5NzJwScFJ2+IwNICWPXikpwLRAuzRuWs
	 IKwmdCUh7eJjb/6ADqlrUUjkL7pzAimfTQMLIObX4NTgAJwGOm8NunT+1pSvNjitoJ
	 HQswCLOwClV7Bgp21pg8870MRvQcXuyxgVB1NMFdqQJXGg8G7LJTZZ3AExjh8VM40d
	 bmwVOgMefYDQQ==
Message-ID: <df5d7538-52c6-465c-b250-13532b90c6ae@kernel.org>
Date: Fri, 9 Feb 2024 22:01:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
 <2bdc5510-801a-4601-87a3-56eb941d661a@kernel.org>
 <20240209145828.30e1d000@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240209145828.30e1d000@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 3:58 PM, Jakub Kicinski wrote:
> On Fri, 9 Feb 2024 15:42:16 -0700 David Ahern wrote:
>> On 2/8/24 7:15 PM, Jakub Kicinski wrote:
>>>> I was in the room and I am in support of David's idea, I like it a lot,
>>>> but I don't believe we have any concrete proposal, and we don't have any
>>>> use case for it in netdev for now, our use case for this is currently RDMA
>>>> and HPC specific.
>>>>
>>>> Also siimilar to devlink we will be the first to jump in and implement
>>>> the new API once defined, but this doesn't mean I need to throw away the  
>>>
>>> I'm not asking to throw it away. The question is only whether you get
>>> to push it upstream and skirt subsystem rules by posting a "misc" driver
>>> without even CCing the maintainers on v1 :|  
>>
>> Can you define what you mean by 'skirt subsystem rules'? That's a new
>> one to me.
> 
> I mean that Saeed is well aware that direct FW <> user space interfaces
> are not allowed in netdev, so he posted this "misc" driver without
> CCing us, knowing we'd nack it.

The argument you are making here is that if a device has an ethernet
port, all patches must flow through netdev. Or am I misunderstanding?

There are a lot of devices that toggle between IB and ethernet with only
one (ignore roce here) active at a moment. MLX5 (like many) is split
between drivers/net and drivers/infinband. If the debugging capabilities
went through drivers/infiniband would you have the same stance?

Maybe my bigger question is should drivers that can do different
physical layers, or can operate without a netdev, should they be split
into different drivers? drivers/misc for the PCI interface, drivers/net
for ethernet interfaces and its APIs and drivers/infiniband for IB and
its APIs? Generic capabilities like this debugging interface belong to
the PCI device since it is generic to the device hence drivers/misc.

> 
> Maybe the baseline question is whether major subsystems are allowed to
> set their own rules. I think they should as historically we have a very
> broad range of, eh, openness in different fields. Networking is pretty
> open because of the necessary interoperability.

Interoperability applies solely to networking protocols, not how a
device is designed and certainly not to how it can be debugged. There is
a clear difference between standard networking protocols (packets on a
wire and its headers) and device designs.

> 
>> BTW, there is already a broadcom driver under drivers/misc that seems to
>> have a lot of overlap capability wise to this driver. Perhaps a Broadcom
>> person could chime in.
> 
> I'm not aware. Or do you mean bcm-vk? That's a video encoder.

If that specific piece of S/W is a video encoder, why isn't it under
drivers/video? Scanning the code it seems to me to fall under the open
channel between userspace and F/W which is a common paradigm. But I do
not want this to distract from this patch set; really I was just
browsing existing drivers for any overlap.



