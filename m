Return-Path: <linux-kernel+bounces-83856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E74869F52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763DD1C21099
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B624EB5E;
	Tue, 27 Feb 2024 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="tZatd4uG"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E71F61D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059647; cv=none; b=fl+M7psXF4pSBVzXqw70e6VHFzIfvaAc2zzWJmxDwVU3lpHszLAPCVEraWUDV3ZVPQHcW2rskKQTPxhd6mlPdMb3WcM+BZQT9V+hUnWQ78MGLjIKoUBXvOIjwcLPAbslPkCt3egC9PGskzimZ/6mc6j9OYbLLy75NjMAa9BLUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059647; c=relaxed/simple;
	bh=OCLERH5BUNWNqVAWRAIL2bEHXqesBK/d6BgnZQmH44Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ajiMZ2Re+SUygsI/WZSUDAkF34AA+X1CtuZl/TGEzj+fmEV8saFj7M+BeaedKV9bLwv0KbYVZY657fZvFdPKX7V7LQnxytILS4A8opR7J1Rd2lmN0VAdBZEzctO4WgxRjc8wOZODMlXnMchPaMrKqflhtrvgZOYjSeuIgrzWa90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=tZatd4uG; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4TkmgV1bw0zDqZN;
	Tue, 27 Feb 2024 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1709059638; bh=OCLERH5BUNWNqVAWRAIL2bEHXqesBK/d6BgnZQmH44Y=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tZatd4uGVm2YCRCBLMi8R93U94cS4xMt6Tr0tv1rUgnjpt08yWOu9QkJu0fv1F/Of
	 x+IOUwY9RvRuyw8wFgzxvyRS2Fh02r+AQ99roFn/R0Qptyxvgx6Kep2eSaSHEbdsTG
	 21zlNb4GepAfgsCyp8mQogVleFOtaCx80+IFy3PA=
X-Riseup-User-ID: 4842AE2A53495A92D3F8DE93B2A9FBC67B6744533455E55C8FD1A06C80127020
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4TkmgM5zShzJpbF;
	Tue, 27 Feb 2024 18:47:11 +0000 (UTC)
Message-ID: <592e5da7-7aac-4735-ae8f-625402e381ae@riseup.net>
Date: Tue, 27 Feb 2024 15:47:08 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/9] drm/vkms: write/update the documentation for pixel
 conversion and pixel write functions
Content-Language: en-US
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 pekka.paalanen@haloniitty.fi, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
References: <20240226-yuv-v3-0-ff662f0994db@bootlin.com>
 <20240226-yuv-v3-3-ff662f0994db@bootlin.com>
 <406988be-48a4-4762-9c03-7a27c8e7b91e@riseup.net>
 <Zd35csjqRMstzElA@localhost.localdomain>
From: Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <Zd35csjqRMstzElA@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/02/24 12:02, Louis Chauvet wrote:
> Le 26/02/24 - 10:07, Arthur Grillo a écrit :
>>
>>
>> On 26/02/24 05:46, Louis Chauvet wrote:
>>> Add some documentation on pixel conversion functions.
>>> Update of outdated comments for pixel_write functions.
>>>
>>> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
>>> ---
>>>  drivers/gpu/drm/vkms/vkms_composer.c |  4 +++
>>>  drivers/gpu/drm/vkms/vkms_drv.h      | 13 ++++++++
>>>  drivers/gpu/drm/vkms/vkms_formats.c  | 58 ++++++++++++++++++++++++++++++------
>>>  3 files changed, 66 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
>>> index c6d9b4a65809..5b341222d239 100644
>>> --- a/drivers/gpu/drm/vkms/vkms_composer.c
>>> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
>>> @@ -189,6 +189,10 @@ static void blend(struct vkms_writeback_job *wb,
>>>  
>>>  	size_t crtc_y_limit = crtc_state->base.crtc->mode.vdisplay;
>>>  
>>> +	/*
>>> +	 * The planes are composed line-by-line. It is a necessary complexity to avoid poor
>>> +	 * blending performance.
>>
>> At this moment in the series, you have not yet reintroduced the
>> line-by-line algorithm yet. Maybe it's better to add this comment when
>> you do.
> 
> Is it better with this:
> 
> 	/*
> 	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
> 	 * complexity to avoid poor blending performance.
> 	 *
> 	 * The function vkms_compose_row is used to read a line, pixel-by-pixel, into the staging
> 	 * buffer.
> 	 */
>  
>> Also, I think it's good to give more context, like:
>> "The planes are composed line-by-line, instead of pixel-by-pixel"
> 
> And after PATCHv3 5/9:
> 
> 	/*
> 	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
> 	 * complexity to avoid poor blending performance.
> 	 *
> 	 * The function pixel_read_line callback is used to read a line, using an efficient 
> 	 * algorithm for a specific format, into the staging buffer.
> 	 */
> 

Hi,

This looks good to me.

Best Regards,
~Arthur Grillo

> Kind regards,
> Louis Chauvet
> 
>> Best Regards,
>> ~Arthur Grillo
> 
> [...]
> 

