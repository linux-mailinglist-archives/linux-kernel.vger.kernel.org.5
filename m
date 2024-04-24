Return-Path: <linux-kernel+bounces-156752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D44D8B07AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E541F233B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90481598F0;
	Wed, 24 Apr 2024 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nYtZzdaV"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BC154F8D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955922; cv=none; b=MTd6Ahvtd8gas8OBe/kTBySmv9Dk9t7RdP0iCbTcxVPA70doHG38SARaOL/IF367yHjjxMsPZqaZy6PXet2dfZyfPgRdmvbCiq5doVPv04IO8RWFBIrnQ5Z+LD7bNFVU2nVcnyJbz8OLQk0hsqDsrWZw/5Tu51paOUJZHPIhC/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955922; c=relaxed/simple;
	bh=oEJnS67rUdPQroVoyX+dqXeH9nIPzaqkkQvNgVBBJdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAbwMlz+iIKa1R15hxzvI24ockMqf1AN8hyk4xwsC8Bea7VjjT930xnIU1PHmH3LIQZsGOFkU1EtH+trV65yzs/QI8sm14XHE2WcpF3zDw1xPbE9kFDtG/jAJ1q51Jfrl1kbJo8zfFlg5SHZOEW8kpSfzFjDlVE8v9lx0X71/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nYtZzdaV; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <365445ed-8f1d-4c05-90a4-e7867e67977a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713955917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efh86KadtveKwdflYcTs9rm1RrY2uLyDFDzyIYk7Rgk=;
	b=nYtZzdaVHzAhegl6uBw6q0FR1RFmSoDrwoOcZbLWmXVt+xBTJowI/LGPcJMV/a9QNxdrXo
	/UKDDpvUaBEL2+FWVnEpYxpRBAsSGUoxMIB2LipsuOyzUlMb/prcCQ0nBUfpHW7ueRKLFD
	RxQIfj76x1ta8OBiRBFTZD941IbWZro=
Date: Wed, 24 Apr 2024 18:51:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] software node: Implement device_get_match_data fwnode
 callback
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240422164658.217037-1-sui.jingfeng@linux.dev>
 <Zie3ebHOEpWHj1qV@smile.fi.intel.com>
 <d5bc1e73-a553-451e-ab74-f5f0ca259c6b@linux.dev>
 <hcltp2bbxxg2t7ibmzgiib7mgbwgmvzwnnq6mochdh7c4h76r3@bxj6yk5zq64e>
 <22979e28-ed48-467f-a5cf-82be57bcc2f7@linux.dev>
 <CAA8EJpr1vWVeGsoph9h=PPQRPKkjk+d7WVQpGwpPuhCQwkqCbg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJpr1vWVeGsoph9h=PPQRPKkjk+d7WVQpGwpPuhCQwkqCbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/24 16:39, Dmitry Baryshkov wrote:
> Ok, what is the_bug_  that is being fixed by this patch?

I didn't have a way to use that driver under non DT environment,
this is the bug. Note: I demanding full features.

Both st7735r.c and repaper.c requires additional device property.

  - For st7735r.c: device_property_read_u32(dev, "rotation", &rotation);
  - For repaper.c: device_property_read_string(dev, "pervasive,thermal-zone", &thermal_zone)


Under non DT environment, those device properties can not be read.
Software node backend provided a way. Otherwise, the net results
of the patch doesn't meet the description in the commit message.

>   If you check
> the 'submitting-patches.rst', you'll find this phrase as a description
> of the Fixes: tag.

I have readthe 'submitting-patches.rst', the first sentence tell us that
"A Fixes: tag indicates that the patch fixes an issue in a previous commit."

So what's the problem?


>>>> Hence, before my patch is applied, the two "Make driver OF-independent" patch
>>>> have no effect. Using device_get_match_data() itself is exactly*same*  with
>>>> using of_device_get_match_data() as long as the .device_get_match_data hook is
>>>> not implemented.
> As far as I can see, repaper correctly handles the case by falling
> back to the spi_id. So does st7735r.c.


Yeah, this explicitly is the issue.

Falling back to other means is robust design, but it explicitly says
that the freshly addeddevice_get_match_data() don't works at all
under non DT environment. This is the bug, so what's you concern?
  
According to the commit message, the purpose of the introduction of
thedevice_get_match_data() is to achieve OF independent. But as you said, 
it will  fall back, then how does the goal "Make driver
OF-independent" can be achieved by the patch itself?


-- 
Best regards,
Sui


