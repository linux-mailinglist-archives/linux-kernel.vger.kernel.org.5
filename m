Return-Path: <linux-kernel+bounces-164498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DEF8B7E42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27F41F22E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664A317BB08;
	Tue, 30 Apr 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w21hh/p+"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A517B4E1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497236; cv=none; b=WCWfoXZQY1c8kOmYz8mZCVbZ0mxBuUuTpc7tS6UG4Vx/3vmOxWxoFw7Chc8dB+gz6oXZkHlkRCV+sE9r9Du59qeeqDByVb5svrsVFQR3ldlYaxcKDobqoH9rnyBy3h7Wp9LWf2AowyCrxV0UDrqau0EqvqyTLpPm04CY74kouVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497236; c=relaxed/simple;
	bh=u13WVDDF1j2qoKaU9LvRMy/+HAmqkSIAOTnlmqvKLbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUnAIDR6/HCH7iUj1Oy6uCwoRhln4RWzfOyzCaDREWkg8ddXQJ31C0r2Ar98tNCEWF12eRGCZgTKAmVtXX214pqDYWWcE3YqOQHZ4c2XPlPX43KlsaNRSo295J/NPukH8KqhI2u29mEws9/2mgG1wDO8MdJpPVNI4Z1+ZLnMvy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w21hh/p+; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a88a4b3a-a1c2-40a3-a393-cf91155d7f20@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714497233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gUhs30l2OBlQwExDZS/5EdgveO3O4boTdpbSw9Od6Is=;
	b=w21hh/p+scEshFkQfWJzAgyyv0UQWr9OLYMqd8dRqVfbcrK90o9Jt3FVcaA6OJn6enwp+v
	ZFICrxrniubIjQR2eKjezqE9NseCDQTvyxXe/yxtsyEfSYBRjeXXP0ocqdLYlBUpd66qEH
	1WDjMBmV+TcMirhc9YIRCSYe3UWgNho=
Date: Wed, 1 May 2024 01:13:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm: drm_of.c: Using EXPORT_SYMBOL_GPL instead of
 EXPORT_SYMBOL
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240429173521.709719-1-sui.jingfeng@linux.dev>
 <20240430-monumental-amazing-auk-c2c1a5@houat>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240430-monumental-amazing-auk-c2c1a5@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/30 17:26, Maxime Ripard wrote:
> Hi,
>
> On Tue, Apr 30, 2024 at 01:35:21AM +0800, Sui Jingfeng wrote:
>> Linux kernel puts strict limits on which functions and data structures
>> are available to loadable kernel modules; only those that have been
>> explicitly exported with EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() are
>> accessible. In the case of EXPORT_SYMBOL_GPL(), only modules that declare
>> a GPL-compatible license will be able to see the symbol.
>>
>> Since the whole drm_of.c file is declared with GPL-2.0-only license, so
>> let us keep functions in that source file consistently.
> You're conflating two things: the license of the code itself (GPL2
> here), and the license of the users of the symbols exported in that
> file (anything).
>
> There's no relationship between the two, and you have to make an
> argument for changing the latter other than just because the license is
> GPL because, again, those are two different things.

Yeah, I think you might be correct.

It seems that it is valid to have EXPORT_SYMBOL() in GPL-2.0-only licensed file.


> Maxime

-- 
Best regards,
Sui


