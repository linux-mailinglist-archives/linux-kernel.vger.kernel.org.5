Return-Path: <linux-kernel+bounces-83140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6840868F61
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A301F28C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254B913A242;
	Tue, 27 Feb 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="dqJg9RIE"
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940DA130E48;
	Tue, 27 Feb 2024 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034306; cv=none; b=AAcQdWglmJrTF7vx1E2R9mP0/x9MXLPvgJWwI+sQAPvKZ1ACytKX5XAr1qp/h27z6fLpTgcJ9PbFfhz8wf+USEgFhHw1uvBI1fXLkJfF3bS7HL52aNUz51jVfdH+zlYGt1AY9RYxPpGAsTO7yobpXHZkNnzVrIq/7q8te32j32A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034306; c=relaxed/simple;
	bh=reB1Odb45/l1dvPXc/JgyVKuOjKvEdq6Kb78XAUVaxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiAicTEk57Y3AMEkV9qtDvNQR2O6RCjFKqY65uD+SUj5KmxOmKCj8RAHRV9dskHAjQpzoI9AsSh83WVJmHNsx96BONSaRNhC9PJcD0v+m3o5hTzBbWwUEgh3E/ZhfiR/ySSIPGrQrHoMdhlGBKmDV4H9QJP/cE/EB98c5PbM6Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=dqJg9RIE; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4TkbJH3rPtz9sjZ;
	Tue, 27 Feb 2024 11:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1709034303; bh=reB1Odb45/l1dvPXc/JgyVKuOjKvEdq6Kb78XAUVaxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dqJg9RIE8eu8y2cKu+9cnGHYFnsGUkL7ueJyGDO2S1kJDFRYprUsj2yzAkh5kWxWi
	 Q2QIhVdaUsO9DDLumxdp3NlRr5JXaHFpL84dxbh+hM3qT1ZaxOf2VNQvXfac1Wy9C+
	 jupyHQB4Crd79qLolye0CPSa5Sjiz6c6DWNjUyGg=
X-Riseup-User-ID: 32958693706746C82A54B118B535079799FE5CF83FAE7455EBE508B6A3F4C0A7
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4TkbJB4cHjzJqCg;
	Tue, 27 Feb 2024 11:44:58 +0000 (UTC)
Message-ID: <8ac7bf91-fbce-4403-a801-9dfee39ea802@riseup.net>
Date: Tue, 27 Feb 2024 08:44:52 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/vkms: Add information on how to benchmark
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
Content-Language: en-US
From: Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <20240227111941.061a2892.pekka.paalanen@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/02/24 06:19, Pekka Paalanen wrote:
> On Mon, 26 Feb 2024 17:42:11 -0300
> Arthur Grillo <arthurgrillo@riseup.net> wrote:
> 
>> Now that we have a defined benchmark for testing the driver, add
>> documentation on how to run it.
>>
>> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
>> ---
>>  Documentation/gpu/vkms.rst | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
>> index ba04ac7c2167..6d07f79f77ff 100644
>> --- a/Documentation/gpu/vkms.rst
>> +++ b/Documentation/gpu/vkms.rst
>> @@ -89,6 +89,12 @@ You can also run subtests if you do not want to run the entire test::
>>    sudo ./build/tests/kms_flip --run-subtest basic-plain-flip --device "sys:/sys/devices/platform/vkms"
>>    sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/tests/kms_flip --run-subtest basic-plain-flip
>>  
>> +If you are developing features that may affect performance, you can run the kms_fb_stress
> 
> s/can/must/
> 
>> +benchmark::
> 
> before and after, and report the numbers.

Did you mean to write the benchmarks logs here?

> 
>> +
>> +  sudo ./build/benchmarks/kms_fb_stress --device "sys:/sys/devices/platform/vkms"
>> +  sudo IGT_DEVICE="sys:/sys/devices/platform/vkms" ./build/benchmarks/kms_fb_stress
> 
> Do people need to run both commands?

No, they don't, just two options.

Best Regards,
~Arthur Grillo

> 
> Anyway, a good idea.
> 
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> 
> 
> Thanks,
> pq
> 
>> +
>>  TODO
>>  ====
>>  
>>
>> ---
>> base-commit: eeb8e8d9f124f279e80ae679f4ba6e822ce4f95f
>> change-id: 20240226-bench-vkms-5b8b7aab255e
>>
>> Best regards,
> 

