Return-Path: <linux-kernel+bounces-63831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273B285350F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9748A1F27366
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424A35EE86;
	Tue, 13 Feb 2024 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cUUxxoWJ"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692935EE72
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839303; cv=none; b=NlToxxg/BfgoTxAKO+itwssHezTNzzlSMSOmC+I6OKvp42FJAEqwVH8Z/fLMAkW/6BXBFflifgwR0diaXkG+t0IGcfSThbNjCRJp/oyiYK+YsxkV34kL/l9YnDNouYTzyYwooaJ6tngOySYGbOqD9PnHopJV1ScasJCx9q4E1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839303; c=relaxed/simple;
	bh=w4l6xchzgDPveYf3jkjUBQu5hN9tYPEa+bUtNK5UN+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSdkyvA3MdDqZthUUf9I2FpuyvEnxSHeznD5IjaWBv0gpCcd5LWuMUGFEJEVULddVw5NgbsD+gTlGXUBtDZNW5jDgb2ts82aFP4VPHO4VuI0D+aAPMakL+mkCMqfBhXUT+tiD/O3gp6olkKPFDq4Ok2UrYqT09BLxnuo/dA0Vzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cUUxxoWJ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <45292232-af27-4945-9285-e1c42f1ba65e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707839297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NdXff2HKhkHBa8EZi7NPSQYCYp0SJeGlooiKKxB4EZU=;
	b=cUUxxoWJ+nEcgp1Xd4gvcJnoOUn0IX/OwvYELXLEKAWWrEcb8XV0n6dcmiw6kAa9mDNXtM
	ZNjZ99/1Uj5N1nfkBVASWW5ycGUGXRcDf6+1FOrS0eeG5PeU4MQhJlPyFYAOvZwjHsY8lk
	m3gQ/BmN+r3r7wR+pjvbzeHpC6Guaas=
Date: Tue, 13 Feb 2024 23:48:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [etnaviv-next v13 7/7] drm/etnaviv: Add support for vivante GPU
 cores attached via PCI(e)
To: Maxime Ripard <mripard@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240206172759.421737-1-sui.jingfeng@linux.dev>
 <20240206172759.421737-8-sui.jingfeng@linux.dev>
 <ZcNO9aZwWzyYs-Rv@phenom.ffwll.local>
 <jahydq72bqb27de2ijwwmdjh4ri326mxhfjn5pbvf7cqcpnauq@rw5hjdiroi5d>
 <ZcYGWEG8eqAiqqai@phenom.ffwll.local>
 <65qv24hhkmmy4haylh53muvz2xliejysc3uywq44pl3xx7rus4@ynyau4djposv>
 <67936300-7bfb-4f5e-9b80-ee339313fd61@linux.dev>
 <7ejh5uoppa257ap64ps33wrtabn4iu6flf4fn5lqhuuhbtmpjj@25rqv7mnko5q>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <7ejh5uoppa257ap64ps33wrtabn4iu6flf4fn5lqhuuhbtmpjj@25rqv7mnko5q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/2/13 22:38, Maxime Ripard wrote:
> On Sat, Feb 10, 2024 at 12:25:33AM +0800, Sui Jingfeng wrote:
>> On 2024/2/9 23:15, Maxime Ripard wrote:
>>> On Fri, Feb 09, 2024 at 12:02:48PM +0100, Daniel Vetter wrote:
>>>> On Thu, Feb 08, 2024 at 04:27:02PM +0100, Maxime Ripard wrote:
>>>>> On Wed, Feb 07, 2024 at 10:35:49AM +0100, Daniel Vetter wrote:
>>>>>> On Wed, Feb 07, 2024 at 01:27:59AM +0800, Sui Jingfeng wrote:
>>>>>>> The component helper functions are the glue, which is used to bind multiple
>>>>>>> GPU cores to a virtual master platform device. Which is fine and works well
>>>>>>> for the SoCs who contains multiple GPU cores.
>>>>>>>
>>>>>>> The problem is that usperspace programs (such as X server and Mesa) will
>>>>>>> search the PCIe device to use if it is exist. In other words, usperspace
>>>>>>> programs open the PCIe device with higher priority. Creating a virtual
>>>>>>> master platform device for PCI(e) GPUs is unnecessary, as the PCI device
>>>>>>> has been created by the time drm/etnaviv is loaded.
>>>>>>>
>>>>>>> we create virtual platform devices as a representation for the vivante GPU
>>>>>>> ip core. As all of subcomponent are attached via the PCIe master device,
>>>>>>> we reflect this hardware layout by binding all of the virtual child to the
>>>>>>> the real master.
>>>>>>>
>>>>>>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>>>>>> Uh so my understanding is that drivers really shouldn't create platform
>>>>>> devices of their own. For this case here I think the aux-bus framework is
>>>>>> the right thing to use. Alternatively would be some infrastructure where
>>>>>> you feed a DT tree to driver core or pci subsystem and it instantiates it
>>>>>> all for you correctly, and especially with hotunplug all done right since
>>>>>> this is pci now, not actually part of the soc that cannot be hotunplugged.
>>>>> I don't think we need intermediate platform devices at all. We just need
>>>>> to register our GPU against the PCI device and that's it. We don't need
>>>>> a platform device, we don't need the component framework.
>>>> Afaik that's what this series does. The component stuff is for the
>>>> internal structure of the gpu ip, so that the same modular approach that
>>>> works for arm-soc also works for pci chips.
>>> But there should be a single PCI device, while we have multiple "DT"
>>> devices, right? Or is there several PCI devices too on that PCI card?
>>
>> There is only a single PCI(e) device on that PCI(e) card, this single
>> PCI(e) device is selected as the component master. All other Hardware IP
>> blocks are shipped by the single PCI(e) master. It may includes Display
>> controllers, GPUs, video decoders, HDMI display bridges hardware unit etc.
>>
>> But all of those Hardware IP share the same MMIO registers PCI BAR, this
>> PCI BAR is a kind of PCI(e) MEM resource. It is a relative *big* chunk,
>> as large as 32MB in address ranges for the JingJia Macro dGPU. Therefore,
>> I break the whole registers memory(MMIO) resource into smaller pieces by
>> creating platform device manually, manually created platform device is
>> called as virtual child in this series.
>>
>> In short, we cut the whole into smaller piece, each smaller piece is a
>> single hardware IP block, thus deserve a single device driver. We will
>> have multiple platform devices if the dGPU contains multiple hardware
>> IP block. On the driver side, we bind all of the scattered driver module
>> with component.
> That's kind of my point then. If there's a single device, there's no
> need to create intermediate devices and use the component framework to
> tie them all together. You can have a simpler approach where you create
> a function that takes the memory area it operates on (and whatever
> additional resource it needs: interrupt, clocks, etc.) and call that
> directly from the PCIe device probe, and the MMIO device bind.


Yes, you are right. I have implemented the method just as you told me at
V12 of this series (see 0004 patch at [1]). But at V13, I suddenly realized
that the component code path plus(+) non-component code path yield a
"side-by-side" implement. The old non-component approach can not support
binding multiple sub-core, it can only support one Vivante GPU IP core case.
But there are dGPU which shipping two identical core.

While, the component-based approach implemented at this version is the most
universal and the most flexible and extensible. We could bind a virtual
display driver and/or a real display driver to the real master (refer to the
PCI(e) device).  The PCI(e) device is responsible for present the DRM service
to userspace, like a leader or agent. All other sub hardware and software are
hiding behind of the master.


Besides, Lucas asked me implement the driver like this way at V10 (see [2])

Lucas said:

"My favorite option would be to just always use the component path
even when the GPU is on a PCI device to keep both paths mostly aligned.
One could easily image both a 3D and a 2D core being made available
though the same PCI device."

Lucas, are you watching? How about this version? Can you help to review please?


[1] https://patchwork.freedesktop.org/series/127084/

[2] 
https://lore.kernel.org/dri-devel/0f1095ef333da7ea103486a1121ca9038815e57c.camel@pengutronix.de/


> Maxime

