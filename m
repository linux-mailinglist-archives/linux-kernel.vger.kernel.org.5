Return-Path: <linux-kernel+bounces-56709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F91484CDE6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B32BFB27273
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C197F7DF;
	Wed,  7 Feb 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ne58+47S"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CFD7F7D5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319362; cv=none; b=ptnsyMR5JZBw2Wp/VE4EkACh5XWngOYDqCB/xdbTU+tKLSYCIx/wNML/2KuDD2Y4lhm8g7YrG3uSNhGKoZ6W0VePP7x3QjzH153RStZTqIFG+BEDflwqCPk+FJFNGZAx0st9ytqxuNx8rt6oH3RhCfTOibtwxzkygTOPqIURRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319362; c=relaxed/simple;
	bh=2/mtwgRzlJOkc0LXlTrmrg1S+ufrZk1Z+V5fxCx51kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c+wZDVLpslBjJeHP0FcheqX9o3sxEFXEDQSrdRGeFXfi6T0ZxGcEn+qUwBIukj14NJ9HJnKHoQmQ+Ej2/nLzacWpm4j2jFK3x2gB15X9QYdfAVW1bFUQy+8NjTnPT6P11AXMrvligeI9MLqdUPmvZG/GqoVCgpsCepg5+DRQep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ne58+47S; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ad282cac-1455-4063-aa47-400c9ac07851@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707319357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BcrHDCtY4EmMAqg4uodbZ6nytdDsnnuuhPuoEVB1AqU=;
	b=ne58+47SUtp/Ee1jtsQ5M/swxzbAZXspv1TYStfC4sOqG1J4NK5Q5Rob9sXsHR/3PEOINx
	OrSyjt3tR6MrYpv8ATy84ExlFHy3/GTcZedjtzQ5oPkmKsLpxtb7ZYyfQA21fJe1xX2Eud
	fBempHikef5QSeQwAVbXMpqXoPFHvBk=
Date: Wed, 7 Feb 2024 23:22:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [etnaviv-next v13 7/7] drm/etnaviv: Add support for vivante GPU
 cores attached via PCI(e)
To: Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240206172759.421737-1-sui.jingfeng@linux.dev>
 <20240206172759.421737-8-sui.jingfeng@linux.dev>
 <ZcNO9aZwWzyYs-Rv@phenom.ffwll.local>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ZcNO9aZwWzyYs-Rv@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/2/7 17:35, Daniel Vetter wrote:
> On Wed, Feb 07, 2024 at 01:27:59AM +0800, Sui Jingfeng wrote:
>> The component helper functions are the glue, which is used to bind multiple
>> GPU cores to a virtual master platform device. Which is fine and works well
>> for the SoCs who contains multiple GPU cores.
>>
>> The problem is that usperspace programs (such as X server and Mesa) will
>> search the PCIe device to use if it is exist. In other words, usperspace
>> programs open the PCIe device with higher priority. Creating a virtual
>> master platform device for PCI(e) GPUs is unnecessary, as the PCI device
>> has been created by the time drm/etnaviv is loaded.
>>
>> we create virtual platform devices as a representation for the vivante GPU
>> ip core. As all of subcomponent are attached via the PCIe master device,
>> we reflect this hardware layout by binding all of the virtual child to the
>> the real master.
>>
>> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> Uh so my understanding is that drivers really shouldn't create platform
> devices of their own.
>

Yes,

At least for DT-based systems, this driver can be modified
to let the core to create the virtual master for us. We don't
have to create platform devices by our own(refer to the drm/etnaviv
driver).

I means that we could put the following example device node
into the .dts file.


		gpu_2d: gpu@A0000 {
			compatible = "vivante,gc";
			reg = <0xA0000 0x4000>;
		};

		gpu_3d: gpu@90000 {
			compatible = "vivante,gc";
			reg = <0x90000 0x4000>;
		};

		gpu@0 {
			compatible = "etnaviv";
			cores = <&gpu_2d &gpu_3d>;
			dma-coherent;
			dma-mask = <0xffffffff>
			virtual_master;
		};

But now, I'm afraid it's too late. Because the DTS/DTB may already have been
burned into board's BIOS for years. I guess, nowadays, modifying(changes)
this driver have to take the backward compatibility constraint into consideration.

Since we only have one chance to form the spec, that happens when this driver was
initially merged. Apparently, we miss it.



