Return-Path: <linux-kernel+bounces-155596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4712E8AF49F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689001C23CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C1213D512;
	Tue, 23 Apr 2024 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nxKPOILR"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79F13D50F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890977; cv=none; b=nj6e0USK7r92cJNaP/4cm96Tm94/QOBT9FeU7uzezI12n747vaHKxyly1bOi5HokNLIvoZpwkB7LgnxGOHAokJoI854Q4M1zjTIpMl6Rnv7uY6pFG9pINrqfik8JycCgSyypVQJdr2jNzHmLS5DRz5Vxmsqu7P78vqcqVySQpX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890977; c=relaxed/simple;
	bh=JK9cWcqCBSN2kQEjqq9Rxdq9K2hbeoRzvX/uzKL2aGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULLDusCyEFq34lr1ULziqNnPTsbelz/ivGRlpHgSBmN44+NcngGvGV/K3i4W9Vsa9e4OP9dyvZy+D4Hd9Thi2zZeMKN7E/53+Afs6LKhCSiVA5L7Z1HlQ8wFf39lUn6PyFVoyh7Aua+xm5WlTa8tGA4huWcDhyLIXU4HsQqAj+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nxKPOILR; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d5bc1e73-a553-451e-ab74-f5f0ca259c6b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713890972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpkgavKs1CpvzyYWvr/KmghPS7XN/sSEyN3iKhZAgIE=;
	b=nxKPOILREIiSPcSzvRoxxF7C3v1XYuoI7y/JLtnsFqYWO1VZyiR2Ag3rmvwEgZLbM//UoP
	TM/mbZDshJBwF9wBvF8KmECASF+XwmF6PrYWWs3jQ6GPDcLFT5iwxHisR7ESWNRTSVAA7o
	0SMfw5XgcfT5O23of6TrhSgzXD+ek+g=
Date: Wed, 24 Apr 2024 00:49:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] software node: Implement device_get_match_data fwnode
 callback
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240422164658.217037-1-sui.jingfeng@linux.dev>
 <Zie3ebHOEpWHj1qV@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <Zie3ebHOEpWHj1qV@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

Thanks a for you reviewing my patch.


On 2024/4/23 21:28, Andy Shevchenko wrote:
> On Tue, Apr 23, 2024 at 12:46:58AM +0800, Sui Jingfeng wrote:
>> Because the software node backend of the fwnode API framework lacks an
>> implementation for the .device_get_match_data function callback. This
>> makes it difficult to use(and/or test) a few drivers that originates
> Missing space before opening parenthesis.

OK, will be fixed at the next version.


>> from DT world on the non-DT platform.
>>
>> Implement the .device_get_match_data fwnode callback, device drivers or
>> platform setup codes are expected to provide a string property, named as
>> "compatible", the value of this software node string property is used to
>> match against the compatible entries in the of_device_id table.
> Yep and again, how is this related? If you want to test a driver originating
> from DT, you would probably want to have a DT (overlay) to be provided.

There are a few reasons, please fixed me if I'm wrong.

DT (overlay) can be possible solution, but DT (overlay) still depend on DT.
For example, one of my x86 computer with Ubuntu 22.04 Linux/x86 6.5.0-28-generic
kernel configuration do not has the DT enabled. This means that the default kernel
configuration is decided by the downstream OS distribution. It is not decided by
usual programmers. This means that out-of-tree device drivers can never utilize
DT or DT overlay, right?

I means that Linux kernel is intended to be used by both in-tree drivers and out-of-tree drivers.
Out-of-tree device drivers don't have a chance to alter kernel config, they can only managed to
get their source code compiled against the Linux kernel the host in-using.

Some out-of-tree device drivers using DKMS to get their source code compiled,
with the kernel configuration already *fixed*. So they don't have a opportunity
to use DT overlay.

Relying on DT overlay is *still* *DT* *dependent*, and I not seeing matured solution
get merged into upstream kernel yet. However, software node has *already* been merged
into Linux kernel. It can be used on both DT systems and non-DT systems. Software node
has the least requirement, it is *handy* for interact with drivers who only need a small
set properties.

In short, I still think my patch maybe useful for some peoples. DT overlay support on
X86 is not matured yet, need some extra work. For out-of-tree kernel module on
downstream kernel. Select DT and DT overlay on X86 is out-of-control. And I don't want
to restrict the freedom of developers.
  


>> This also helps to keep the three backends of the fwnode API aligned as
>> much as possible, which is a fundamential step to make device driver
>> OF-independent truely possible.
>>
>> Fixes: ffb42e64561e ("drm/tiny/repaper: Make driver OF-independent")
>> Fixes: 5703d6ae9573 ("drm/tiny/st7735r: Make driver OF-independent")
> How is it a fix?


Because the drm/tiny/repaper driver and drm/tiny/st7735r driver requires extra
device properties. We can not make them OF-independent simply by switching to
device_get_match_data(). As the device_get_match_data() is a *no-op* on non-DT
environment.

Hence, before my patch is applied, the two "Make driver OF-independent" patch
have no effect. Using device_get_match_data() itself is exactly *same* with
using of_device_get_match_data() as long as the .device_get_match_data hook is
not implemented.


See my analysis below:

When the .device_get_match_data hook is not implemented:

1) On DT systems, device_get_match_data() just redirect to of_fwnode_device_get_match_data(),
    which is just a wrapper of of_device_get_match_data().

2) On Non-DT system, device_get_match_data() has *ZERO* effect, it just return NULL.


Therefore, device_get_match_data() adds *ZERO* benefits to the mentioned drivers if
the .device_get_match_data is not implemented.

  
Only when the .device_get_match_data hook get implemented, device_get_match_data()
can redirect tosoftware_node_get_match_data() function in this patch. Therefore, the 
two driver has a way to get a proper driver match data on non-DT 
environment. Beside, the users of those two driver can provide 
additional software node property at platform setup code. as long as at 
somewhere before the driver is probed.

So the two driver really became OF-independent after applied my patch.


>> Closes: https://lore.kernel.org/lkml/20230223203713.hcse3mkbq3m6sogb@skbuf/
> Yes, and then Reported-by, which is missing here.
>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Daniel Scally <djrscally@gmail.com>
>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Please, move these after the cutter '---' line (note you may have that line in
> your local repo).
>
> ...
>

OK, thanks a lot for teaching me.


>> +static const void *
>> +software_node_get_match_data(const struct fwnode_handle *fwnode,
>> +			     const struct device *dev)
>> +{
>> +	struct swnode *swnode = to_swnode(fwnode);
>> +	const struct of_device_id *matches = dev->driver->of_match_table;
>> +	const char *val = NULL;
>> +	int ret;
>> +	ret = property_entry_read_string_array(swnode->node->properties,
>> +					       "compatible", &val, 1);
> And if there are more than one compatible provided?

Nope, I think this is kind of limitation of the software node,
platform setup code generally could provide a compatible property.
No duplicate name is allowed. But we the best explanation would be
platform setup code should provide the "best" or "default" compatible
property.


>> +	if (ret < 0 || !val)
>> +		return NULL;
>> +	while (matches && matches->compatible[0]) {
> First part of the conditional is invariant to the loop. Can be simply


Right, thanks.


> 	matches = dev->driver->of_match_table;
> 	if (!matches)
> 		return NULL;
>
> 	while (...)
>
>> +		if (!strcmp(matches->compatible, val))
>> +			return matches->data;
>> +
>> +		matches++;
>> +	}
>> +
>> +	return NULL;
>> +}

-- 
Best regards,
Sui


