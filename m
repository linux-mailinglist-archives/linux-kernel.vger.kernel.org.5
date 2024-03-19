Return-Path: <linux-kernel+bounces-107551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE47F87FE00
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19241C21D23
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C9A40BF0;
	Tue, 19 Mar 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC/dNi7o"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE53BBC1;
	Tue, 19 Mar 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853442; cv=none; b=SpzweDjxoY5iXWp6SwZTFmCKsPjE9iOQFq1zA68gOn5zJJbfdJi08qPNqq22lM5nNVIAW/aLe57exovdAX3IbDDwxRo91JJyn0X60sMCRmIjaEBwQomFFz9KwOIV2DBkh0ZNlBdNTN4SoM1VNaH6CVtidRJ4mMBfeG/nDseEHPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853442; c=relaxed/simple;
	bh=QE/8lpIZPvfWqvPbW9p7F/jcV8d4DPm17U+lWFead+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYbw035olBQLPjwCZ06Sg/9FaHpWz2QvF71WCpzf4wRaTSICnqWdXzFodew0LMhV6KA86Y8JX90firKGrKYr0XsZxJd/I/XYL+QzAskN5KlRyJ98nM+4T/otU6gfBmfhVQPG33gq34DxSSR8qI+oavOzlwkHsTT7cbLUcMWC5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QC/dNi7o; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dedb92e540so34515245ad.0;
        Tue, 19 Mar 2024 06:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710853440; x=1711458240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TB3+Jx7RLucIKEs6eH+0Nj3AnIcH8F/JCvJNLp7YE6g=;
        b=QC/dNi7o/tXtW0YWE3Se0mX0fOFIkoJwKlPbpmqxfpLQJLpeH8FpVjkEgodSlDSfiE
         hgaJGz5naBE21qR6CwJq+4HzcU7iHYzTk38C6Bo0AA0mZiwxXjb8hdOdiKiK8OhH82Mh
         P/9DgU5UL/x4XtuDQERvbIkEkMY2AbabiLSfyg3I09ZCFHgH/BN8P5a9GgFW610haRV3
         XFFIJiHpKLhsUUcq5gaJXq5XXOIXDqZmslHimJSoBnm2rBhWP+1O6S3b/2DtuIug5gE9
         GfsPYdGtrog5YcZm0n9NY/j4diFqGkdMzYuE+uYlnT0Cy6RMpVTNs6QKntTBFcTBLUhk
         9qgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710853440; x=1711458240;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TB3+Jx7RLucIKEs6eH+0Nj3AnIcH8F/JCvJNLp7YE6g=;
        b=FZM1expbIcR9Cc/wWgN0zmbCKYEiTIqM4EvYsg7x6kkKzRKwriixCVVtnqXoWn0P2j
         8zAxLyzaadtF1J+fhdvCNVQC3CeVE6GE5GQtZR0CKZOO/S9qZJAuo9GxWksKd4znQPZC
         rJtqv6bSPhxU3NGjpa80VcTo6Tou4Q03cN/bpzykoXVns3TKgIrnhZ4vDYoDLt5FzQf6
         Hnq8MaL0tHGyotquujB1e8l5sz6NaM0Hc6KQnpdZGp3yWt9enDQNSJIJ9xm5UL/I5f6a
         Xv19Res7UVTpdlqdfPGVRuEjcLf3g1DZlO7DDH7h29KDy+6GFLtlnT503UaVwUrtd6RE
         Krvg==
X-Forwarded-Encrypted: i=1; AJvYcCV1H/W61f+FuzPFfpMjpzynq9wv2/QjSwRi32B0XvAW+nKnu/DehL9VTWOssE2P3LZlCqrgY8nsXjSCY+CNF8Ranwgh+B510SVLPtm6dWqlTo/30K1POQ6Gr5H9bhP4yb6zE1yEdlVLQ+EsoQkK6ALovD7yBH6HJSZ2zAIlfGcAf1ZPbQ==
X-Gm-Message-State: AOJu0YyIyIN0m8GoY6MHmemUIGEk2uMNFmEpGnJoJHC0VVkaDjotqlz0
	zFYd+mCSWyLuLJGUhn+8XSHUUjNDyOlNbjUGXFCS/0M1E7NrtNWZ
X-Google-Smtp-Source: AGHT+IHp9n/ieIqxsK6SNAifPecss5n/WcUXZF+7gmtGuEG/9nF1SdfwSwoEsfEnrazkiPBdUXRu0g==
X-Received: by 2002:a17:903:2308:b0:1e0:119e:f925 with SMTP id d8-20020a170903230800b001e0119ef925mr3803743plh.26.1710853439734;
        Tue, 19 Mar 2024 06:03:59 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79a48000000b006e685994cdesm9676540pfj.63.2024.03.19.06.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 06:03:59 -0700 (PDT)
Message-ID: <81ec4156-8758-406e-876b-5acf13951d09@gmail.com>
Date: Tue, 19 Mar 2024 18:33:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 lorforlinux@beagleboard.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vaishnav M A <vaishnav.a@ti.com>, Mark Brown <broonie@kernel.org>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
 Vaishnav M A <vaishnav@beagleboard.org>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
 <CZWVF90JJO98.2M7ARQ9WMGC94@kernel.org>
 <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
 <0f3f56d4-3381-44f1-91bc-c126f3ced085@linaro.org>
 <c8031e17-5ae8-4794-8b8c-1736be6452d3@gmail.com>
 <CZXMK3W52AFO.1APK080GVJESK@kernel.org>
 <5a9b1cd9-05ec-4606-92b6-eadbc7af6202@gmail.com>
 <CZXPQZY8PUGE.QZM8XSOUNMT4@kernel.org>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <CZXPQZY8PUGE.QZM8XSOUNMT4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 17:38, Michael Walle wrote:

> On Tue Mar 19, 2024 at 12:36 PM CET, Ayush Singh wrote:
>>>> Regardless, this patch actually does not contain any code for EEPROM
>>>> support I have just mentioned it to give more context on why mikroBUS
>>>> manifest is the focus of this patch instead of DT overlay or something
>>>> else.
>>> Right, and I think this is the crux here. Why can't you use DT
>>> overlays? The manifest files, seem to be yet another hardware
>>> description (method) and we already have DT. Can't we have some kind
>>> of userspace helper that could translate them to DT overlays? That
>>> way, you could also handle the EEPROM vs non-EEPROM case, or have
>>> some other kind of method to load a DT overlay.
>>>
>>> Admittedly, I've never worked with in-kernel overlays, but AFAIK
>>> they work with some subsystems.
>>>
>>> -michael
>>
>> So let me 1st go over 3 cases that the driver needs to support:
>>
>> 1. Non EEPROM boards:
>>
>> Using overlays should be pretty similar to current solution. If the
>> manifest is converted to overlay in userspace, then we do not even need
>> to do manifest parsing, setting up spi, i2c etc in the kernel driver.
>>
>>
>> 2. EEPROM boards
>>
>> How do you propose handling these. If you are proposing storing dt
>> overlay in EEPROM, then this raises some questions regarding support
>> outside of Linux.
>>
>> The other option would be generating overlay from manifest in the kernel
>> driver, which I'm not sure is significantly better than registering the
>> i2c, spi, etc. interfaces separately using standard kernel APIs.
> You did answer that yourself in (1): you could use a user space
> helper to translate it to a DT overlay, I don't think this has to be
> done in the kernel.

I do not understand what you mean. For EEPROM supported boards, user 
space is not involved. The driver can directly read the manifest from 
add-on board and setup everything, so it is plug and play.

The manual involvement of user space is only for non EEPROM boards since 
we do not have a way to identify the board without the user needing to 
provide the manifest.


> Also how do you know whether there is an EEPROM
> or not?

Set RST GPIO to low. clickID supported board will enter ID MODE, Then 
check if CS line has a w1 gpio bus.

>> 3. Over Greybus
>>
>> It is quite important to have mikroBUS over greybus for BeagleConnect.
>> This is one of the major reasons why greybus manifest was chosen for the
>> manifest format.
>>
>> Also, it is important to note that mikroBUS manifest is being used since
>> 2020 now and thus manifests for a lot of boards (both supporting clickID
>> and not supporting it exist). So I would prefer using it, unless of
>> course there are strong reasons not to.
> And also here, I'm not really familiar with greybus. Could you give
> a more complex example? My concern is that some driver might need
> additional properties from DT (or software nodes) to function
> properly. It might not only be a node with a compatible string but
> also more advanced bindings. How would that play together with this?
> My gut feeling is that you can handle any missing properties
> easier/better (eg. for existing modules) in user space. But maybe
> that is already solved in/with greybus?

Greybus is a communication protocol designed for modular electronic 
devices. It allows different parts of a device to be hot plugged (added 
or removed) while the device is still running. Greybus manifest is used 
to describe the capabilities of a module in the greybus network. The 
host then creates appropriate bidirectional unipro connections with the 
module based on the cports described in the manifest. I have added a 
link to lwn article that goes into more detail.

BeagleConnect simply allows using greybus over any bidirectional 
transport, instead of just Unipro.

I cannot comment much about how greybus handles missing properties. 
While greybus also works just in kernel space, greybus protocols are 
inherently higher level than kernel driver, so it might have an easier 
time with this.

I have also added a link to eLInux page which provides rational for the 
mikroBUS manifest. But the crux seems to be that dynamic overlays were 
not well-supported back then. Also, the use of mikroBUS using greybus 
subsystem was already used. Hence the mikroBUS driver.

Greybus is not a big blocker from my perspective, since it is always 
possible to introduce a new protocol for mikroBUS in Greybus spec. I 
think as long as both EEPROM and non EEPROM boards can be supported by 
mikroBUS driver and dt-bindings, are can be used outside of Linux (eg: 
ZephyrRTOS, nuttx, etc), it is fine.

> Here's a random one: the manifest [1] just lists the compatible
> string apparently, but the actual DT binding has also reset-gpios,
> some -supply and interrupt properties.
>
> -michael
>
> [1] https://github.com/MikroElektronika/click_id/blob/main/manifests/WEATHER-CLICK.mnfs


Yes, the concern is valid. Support for validating the manifest is 
nowhere near as good as devicetree overlays. But I think that would be a 
problem with the device rather than the responsibility of the kernel. It 
is up to the manufacturer to have valid manifests.


Link: https://lwn.net/Articles/715955/ Greybus

Link https://elinux.org/Mikrobus eLinux article


Ayush Singh


