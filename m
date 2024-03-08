Return-Path: <linux-kernel+bounces-97141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21AB876602
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BDE1F26936
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E9C40857;
	Fri,  8 Mar 2024 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yNyS0Ruj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ACE63B8;
	Fri,  8 Mar 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906903; cv=none; b=HtawIOVUnY0BVDPfT0sLUvWEze4fk7Cl5e0YddFRUB7602b7XHjilSaT8erwIV3i7d/VWZpyhqEs22cOgzR7+t+HcqfY2pnPd2hoK5XSgpkxjIyOxkBDVvKpLhH2HalPqvVOxvsrcz50F7kYkD7XauGStRGaJ8V/FLITseK0VT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906903; c=relaxed/simple;
	bh=wefvkTTCoZvNRPlXyzWk06NTVJGu8R7LMpdXHxDxiy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/6YBoJIQxE5y0iyzOqoweN2uPm8/BuT0mj3KnJwcMfXFm1eV7By8hRdtrFaz19e21vd92hQvm71wogg0aZudRq4CrleRfarSmJf6xOyfkKA8+zJ9AoSKSLKVPzjWda3yoAWNfhU8MHEq+vQPoIdIvytKyY/Ue1wqxIfVFMy0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yNyS0Ruj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709906894;
	bh=wefvkTTCoZvNRPlXyzWk06NTVJGu8R7LMpdXHxDxiy4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=yNyS0RujkB0DNybLfVf7NH+HhpN7qHTqtzXps3SMSxsZLl3SEQt/MLmDCgMMdRPSu
	 TOINSTCC1zvfZJ3tGoYriRGN+mJpeIm5+ehnQxObZ+4NTj2xr1sb74ftZIJUJvZoRF
	 pf4I4l2w/Qt1sb7eLkl2SgiY+g8Zxr6p/OkCu8doCjzxd1xvgG0flLd8cwDxkmhiCa
	 pQY+Zy7l0ELeg9ij6/+xzoOUEXAIVInbeAWPvo9ZBUMxt0jaPjTLGmlc041eqQehoO
	 a70KroxXvRhwHc9TcUmWE0fqElbNsIGxrdtMSwKzIdn2Kl9jXXF6JUaxdGS6PU0kgu
	 U8LzlTBhJpbQA==
Received: from [100.74.67.65] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5DF8737820F1;
	Fri,  8 Mar 2024 14:08:13 +0000 (UTC)
Message-ID: <8f6972a1-e174-4c0e-808e-afece9b529bf@collabora.com>
Date: Fri, 8 Mar 2024 15:08:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: media: add Maxim MAX96714 GMSL2
 Deserializer
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: linux-media@vger.kernel.org, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 mchehab@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, sakari.ailus@iki.fi
References: <20240305152608.287527-1-julien.massot@collabora.com>
 <20240305152608.287527-3-julien.massot@collabora.com>
 <20240307-retract-aloof-9ff1fde79a82@spud>
From: Julien Massot <julien.massot@collabora.com>
In-Reply-To: <20240307-retract-aloof-9ff1fde79a82@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Conor,

Thanks for reviewing my patchset.

On 3/7/24 20:21, Conor Dooley wrote:
> On Tue, Mar 05, 2024 at 04:26:06PM +0100, Julien Massot wrote:
>> Add DT bindings for Maxim MAX96714 GMSL2 Deserializer.
>>
>> Signed-off-by: Julien Massot <julien.massot@collabora.com>
>> ---
>> Change since v3:
>>   - Renamed file to maxim,max96714.yaml dropped the 'f' suffix
> 
> Why? The filename should match the compatible, which /does/ have an f.
All the work has been done on MAX96714F variant of this Maxim GMSL2 
deserializer.
The driver and the binding remain suitable for all variants of this 
chipset, since they share the same
register mapping, similar features etc..

MAX96714 exists in different variant: MAX96714 / MAX96714F / MAX96714K 
that will be easy
to add support for this binding and driver later.

The MAX96714 name looks the most suitable.
Please have a look at this discussion on the V3 version
https://lore.kernel.org/lkml/ZdXYpc2csVnhtZH9@valkosipuli.retiisi.eu

> 
>>   - Removed mention to C-PHY since it's not supported by MAX96714 deserializers
>>   - Removed bus-type requirement on CSI endpoint since the device only support D-PHY
>>   - Removed the clock-lanes property in the dt example
>>
>> Change since v2:
>>   - remove reg description
>>   - rename enable gpio to powerdown
>>   - use generic node name: i2c, serializer, deserializer
>> ---
>> ---
>>   .../bindings/media/i2c/maxim,max96714.yaml    | 169 ++++++++++++++++++
>>   1 file changed, 169 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
> 
>> +properties:
>> +  compatible:
>> +    const: maxim,max96714f
> 
>> +  i2c-gate:
>> +    $ref: /schemas/i2c/i2c-controller.yaml
> 
> There is an i2c-gate binding, you should reference it here instead.
Ok, I will post a new version with a reference to the i2c-gate binding.

> 
>> +    unevaluatedProperties: false
>> +    description: |
> 
> This | is not needed, there's no formatting to preserve.
Ok I will drop the '|'
> 
>> +      The MAX96714 will pass through and forward the I2C requests from the
>> +      incoming I2C bus over the GMSL2 link. Therefore it supports an i2c-gate
>> +      subnode to configure a serializer.

Regards,
-- 
Julien Massot
Senior Software Engineer
Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

