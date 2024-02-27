Return-Path: <linux-kernel+bounces-83654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F223869CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E5A281593
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E330B208CE;
	Tue, 27 Feb 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="NJwn5npR"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B26320DD3;
	Tue, 27 Feb 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052796; cv=none; b=YqyJGj/EZgc5HGP2kV0qLHjKC/0C8bJ+Yo2xWOoExRLjjQ//NhtsA1rKZzdYywa24O405d6Ebw6meLYUvrT9agfMl3fIkrsZE2Gs7vJ5Ja2DgcpwC5Xgo0l7U+owEzFQthDyBf5sDfg2br3B9gLxJ88rdzpCpjbWraoZVV11enk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052796; c=relaxed/simple;
	bh=Da954MbnRPw4bxw+5mIkqfjjxTIv+w4RxJZWrQGj13Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dCelcqFVZ2cSvNGTuArhfpfBFaJlT9y6gAiUHwxcO5O5GY8OZIyuEehRwkmugyEvMQ7Svq6/DQOq60gQ0aJeFUW96jB5q3Q/+iXZ62cVmQs0MMU77xks9jPUvxneWZLKYun29+g06znGenhS33Lz0VXncZra+N3IZFW+OU8E9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=NJwn5npR; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4Tkk7m11lpzDqWP;
	Tue, 27 Feb 2024 16:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1709052788; bh=Da954MbnRPw4bxw+5mIkqfjjxTIv+w4RxJZWrQGj13Q=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=NJwn5npRMXm6Skwq2AdJ6RK8+WSAKBcRTkXBkZsvegwvHJPlAlLDQZeJME25XbbHm
	 0OHKncuJh7Yvyoc0KZiDzJCGjZ3lQhAVCIGxUeqLtg7YvLxt1KwdsqmiWe7nUWc0vA
	 3dfDCVyIEdG9OCYa5NYiiecUA+p0hy78UWIZFJns=
X-Riseup-User-ID: 7D71F872B5A8A8BB4637B660A5C3BEF426D5D08ECD5582D178E0808550356D2B
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Tkk7f6kxfzJrX8;
	Tue, 27 Feb 2024 16:53:02 +0000 (UTC)
Message-ID: <6979cd2e-2b00-4dc4-8e41-66b435cf7ea8@riseup.net>
Date: Tue, 27 Feb 2024 13:52:59 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/vkms: Add information on how to benchmark
Content-Language: en-US
To: Pekka Paalanen <pekka.paalanen@collabora.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
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
 <0892593d-0fd9-4381-b2bd-843627bd2723@riseup.net>
 <20240227152639.6426c401.pekka.paalanen@collabora.com>
 <Zd35c5TLS6ygc_Pr@localhost.localdomain>
From: Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <Zd35c5TLS6ygc_Pr@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/02/24 12:02, Louis Chauvet wrote:
> Le 27/02/24 - 15:26, Pekka Paalanen a écrit :
>> On Tue, 27 Feb 2024 09:29:58 -0300
>> Arthur Grillo <arthurgrillo@riseup.net> wrote:
>>
>>> On 27/02/24 08:55, Pekka Paalanen wrote:
>>>> On Tue, 27 Feb 2024 08:44:52 -0300
>>>> Arthur Grillo <arthurgrillo@riseup.net> wrote:
>>>>   
>>>>> On 27/02/24 06:19, Pekka Paalanen wrote:  
>>>>>> On Mon, 26 Feb 2024 17:42:11 -0300
>>>>>> Arthur Grillo <arthurgrillo@riseup.net> wrote:
>>>>>>     
>>>>>>> Now that we have a defined benchmark for testing the driver, add
>>>>>>> documentation on how to run it.
>>>>>>>
>>>>>>> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
>>>>>>> ---
>>>>>>>  Documentation/gpu/vkms.rst | 6 ++++++
>>>>>>>  1 file changed, 6 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
>>>>>>> index ba04ac7c2167..6d07f79f77ff 100644
>>>>>>> --- a/Documentation/gpu/vkms.rst
>>>>>>> +++ b/Documentation/gpu/vkms.rst
>>>>>>> @@ -89,6 +89,12 @@ You can also run subtests if you do not want to run the entire test::
>>>>>>>    sudo ./build/tests/kms_flip --run-subtest basic-plain-flip --device "sys:/sys/devices/platform/vkms"
>>>>>>>    sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_flip --run-subtest basic-plain-flip
>>>>>>>  
>>>>>>> +If you are developing features that may affect performance, you can run the kms_fb_stress    
>>>>>>
>>>>>> s/can/must/
>>>>>>     
>>>>>>> +benchmark::    
>>>>>>
>>>>>> before and after, and report the numbers.    
>>>>>
>>>>> Did you mean to write the benchmarks logs here?  
>>>>
>>>> I mean people should be required tell their before and after numbers in
>>>> either commit message (my preference) or in series cover letter (if
>>>> benchmarking commits is not useful).
>>>>
>>>> With the addition of YUV support in VKMS, maybe the benchmark needs to  
>>>
>>> With the upcoming addition, I've sent a patch to arbitrarily change the
>>> formats on the benchmark via command-line options. It's not adding a new
>>> case, but maybe just this could already help.
>>>
>>> https://lore.kernel.org/all/20240226-kms_fb_stress-dev-v1-0-1c14942b1244@riseup.net/
>>
>> In that case you would need to document exactly what command line
>> options to use, and ask people to report the numbers of each test
>> case.
>>
>> That works. Alternatively or additionally, the test cases could be
>> built in to the benchmark, and it just reports numbers for all of them
>> in a single invocation. Then people running the standard benchmark do
>> not need to worry about getting the command line options right, or
>> running multiple cases. And reviewers do not need to ask to re-run with
>> the correct options.
>>
>> I suppose rotations might get added, too.
>>
>> Or maybe you'd provide a script that covers all the standard
>> performance test cases?
> 
> I agree with Pekka, it would be nice to have a simple "bench everything" 
> tool. Like kms_rotation is a test for all rotations, kms_plane for color 
> conversions... kms_fb_test can run a few combinations (rgb+norotation, 
> rgb+yuv, rgb+rotation...) and report a "global result" (this way it's easy 
> to spot a regression not related directly to your changes).
> 
> I don't know the IGT benchmark API, but I think there is a way to create 
> "sub-benchmarks" so you can run a specific benchmark when developping and 
> the whole thing before pushing your series.
> 
> Kind regards,
> Louis Chauvet
> 

Thank you guys for the ideas!

I'm going to work on something along on those lines, having combinations
of formats, rotations and whatever property that might be useful for
stress testing the driver. Maybe query the driver for the supported
properties (e.g. what formats and rotations it supports) and do many/all
possible combinations.

Best Regards,
~Arthur Grillo


>>
>> Thanks,
>> pq
>>
>>>> start printing YUV numbers separately as a new case.
>>>>
>>>>
>>>> Thanks,
>>>> pq
>>>>   
>>>>>  
>>>>>>     
>>>>>>> +
>>>>>>> +  sudo ./build/benchmarks/kms_fb_stress --device "sys:/sys/devices/platform/vkms"
>>>>>>> +  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/benchmarks/kms_fb_stress    
>>>>>>
>>>>>> Do people need to run both commands?    
>>>>>
>>>>> No, they don't, just two options.
>>>>>
>>>>> Best Regards,
>>>>> ~Arthur Grillo
>>>>>  
>>>>>>
>>>>>> Anyway, a good idea.
>>>>>>
>>>>>> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> pq
>>>>>>     
>>>>>>> +
>>>>>>>  TODO
>>>>>>>  ====
>>>>>>>  
>>>>>>>
>>>>>>> ---
>>>>>>> base-commit: eeb8e8d9f124f279e80ae679f4ba6e822ce4f95f
>>>>>>> change-id: 20240226-bench-vkms-5b8b7aab255e
>>>>>>>
>>>>>>> Best regards,    
>>>>>>     
>>>>   
>>
> 
> 
> 

