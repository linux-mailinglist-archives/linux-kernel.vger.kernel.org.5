Return-Path: <linux-kernel+bounces-83233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804A3869091
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3654C1F22236
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EE613A88C;
	Tue, 27 Feb 2024 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="mQYuSXA9"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28C13A87C;
	Tue, 27 Feb 2024 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037009; cv=none; b=oqRcVpralyQZ8lbtfVEpBXwtcppPbZ7Zsdu7ACIzED/uZTFpMUFLqIX4SyV/SSUAOdnQAYrJiQQ41G1Jy2RjB6gG8ehiE2bHkpDyETzQqDbnCtTGVT/a8f7+X1Hib1Yuw+RVnhEAfX4DAw472PeRDMvOL4EB3Enj0qN/ddtxlk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037009; c=relaxed/simple;
	bh=4Oml5WGpUWGH4E2pAWDmHJLXIurGcZNjrQiigLwRZxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZoN4pF4sizYZFA2ayciOLzGI7NTKwPPs4/gGR+EdgmzIXTkggwGhHy49oqeGuj2PcQsxfgquqp3Y5QD7gr7/MzjT5ogcART1Kd5saF6xI47/w/LIlII6BG3b01td4KDmNKC33ua4p50gshMyliiu64mGA/i8QaLOPwQ2YSFIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=mQYuSXA9; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4TkcJG3RP2zDqxh;
	Tue, 27 Feb 2024 12:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1709037006; bh=4Oml5WGpUWGH4E2pAWDmHJLXIurGcZNjrQiigLwRZxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mQYuSXA9hwz4kYJiAqIkpx33zjljXzNw0McZ/d8AEb4W6ypvWOENBZfqVS8Qi3TK5
	 hFaGS6zD8qKMJj5f6oDZl7wONjgkB/ngwXWKqQpZ9uaju56h8e8FU9hQjrX4UVQRD5
	 OtuptIXcDjwf18nqJPFXsHic7+YBeLheLXpyNrhk=
X-Riseup-User-ID: 3F2DEF444453EB7DD4603CFBCDDEB278E8EE48B49FA58E4A5F087EA6FADAFF74
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4TkcJ955ZgzJpbF;
	Tue, 27 Feb 2024 12:30:01 +0000 (UTC)
Message-ID: <0892593d-0fd9-4381-b2bd-843627bd2723@riseup.net>
Date: Tue, 27 Feb 2024 09:29:58 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/vkms: Add information on how to benchmark
Content-Language: en-US
To: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240226-bench-vkms-v1-1-515ef91b11c8@riseup.net>
 <20240227111941.061a2892.pekka.paalanen@collabora.com>
 <8ac7bf91-fbce-4403-a801-9dfee39ea802@riseup.net>
 <20240227135545.62dd5f57.pekka.paalanen@collabora.com>
From: Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <20240227135545.62dd5f57.pekka.paalanen@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/02/24 08:55, Pekka Paalanen wrote:
> On Tue, 27 Feb 2024 08:44:52 -0300
> Arthur Grillo <arthurgrillo@riseup.net> wrote:
> 
>> On 27/02/24 06:19, Pekka Paalanen wrote:
>>> On Mon, 26 Feb 2024 17:42:11 -0300
>>> Arthur Grillo <arthurgrillo@riseup.net> wrote:
>>>   
>>>> Now that we have a defined benchmark for testing the driver, add
>>>> documentation on how to run it.
>>>>
>>>> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
>>>> ---
>>>>  Documentation/gpu/vkms.rst | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
>>>> index ba04ac7c2167..6d07f79f77ff 100644
>>>> --- a/Documentation/gpu/vkms.rst
>>>> +++ b/Documentation/gpu/vkms.rst
>>>> @@ -89,6 +89,12 @@ You can also run subtests if you do not want to run the entire test::
>>>>    sudo ./build/tests/kms_flip --run-subtest basic-plain-flip --device "sys:/sys/devices/platform/vkms"
>>>>    sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_flip --run-subtest basic-plain-flip
>>>>  
>>>> +If you are developing features that may affect performance, you can run the kms_fb_stress  
>>>
>>> s/can/must/
>>>   
>>>> +benchmark::  
>>>
>>> before and after, and report the numbers.  
>>
>> Did you mean to write the benchmarks logs here?
> 
> I mean people should be required tell their before and after numbers in
> either commit message (my preference) or in series cover letter (if
> benchmarking commits is not useful).
> 
> With the addition of YUV support in VKMS, maybe the benchmark needs to

With the upcoming addition, I've sent a patch to arbitrarily change the
formats on the benchmark via command-line options. It's not adding a new
case, but maybe just this could already help.

https://lore.kernel.org/all/20240226-kms_fb_stress-dev-v1-0-1c14942b1244@riseup.net/

Best Regards,
~Arthur Grillo

> start printing YUV numbers separately as a new case.
> 
> 
> Thanks,
> pq
> 
>>
>>>   
>>>> +
>>>> +  sudo ./build/benchmarks/kms_fb_stress --device "sys:/sys/devices/platform/vkms"
>>>> +  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/benchmarks/kms_fb_stress  
>>>
>>> Do people need to run both commands?  
>>
>> No, they don't, just two options.
>>
>> Best Regards,
>> ~Arthur Grillo
>>
>>>
>>> Anyway, a good idea.
>>>
>>> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
>>>
>>>
>>> Thanks,
>>> pq
>>>   
>>>> +
>>>>  TODO
>>>>  ====
>>>>  
>>>>
>>>> ---
>>>> base-commit: eeb8e8d9f124f279e80ae679f4ba6e822ce4f95f
>>>> change-id: 20240226-bench-vkms-5b8b7aab255e
>>>>
>>>> Best regards,  
>>>   
> 

