Return-Path: <linux-kernel+bounces-107919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D199A88038B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499371F24C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28E5200B7;
	Tue, 19 Mar 2024 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+fK/Ixy"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26121134CB;
	Tue, 19 Mar 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869721; cv=none; b=FUqMmEGxOJNbtJlmUT88jSLHOB0mq908nv8rzJeNG0G2fvTGG1lLRm1TLjDh11Uuv4hBSdScPuy9gQKCRR1kk48OtTYJISq9JqYa7sHPSXDGPwKH67DwSJgofdqnJO7BY7pj+2wNiwAzk+gvRyHZG9iAG0w4sMAn/+u3ohrY5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869721; c=relaxed/simple;
	bh=ef8C1CvEpeehus+QBTDaExiX65sj0qQ+0ef8yEAthmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyYJ42mI91WXZy8um/g67glJ0RhAIvLF77NBUizhcL03AttKPsu0nAayyFBCZjHTzGKFt1RsnsWxwewUQjoe8ep6m/9RckRzqLffW/PpbyzYycCBlf5QH+RgBcqWhGTgGTWhlpE4qZfjZ5YTWH1TVf/aNtoj38KN9dMLvIZ6KWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+fK/Ixy; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29f749b6667so2343934a91.0;
        Tue, 19 Mar 2024 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710869719; x=1711474519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ow/5GBMcPISThTjSrcd1SKsYsmgnff7DtPK54ZXKUpU=;
        b=c+fK/Ixyi+3Ya7oGYJ15ABR2jZfxnBI4ixE1Hp+yv9vjZKJercH/1v0sk3Tvw18a2a
         Tsfne31hS5iT/Hr6J6q+p/T9qeNvnLCvSzgte/8ohohjBwB/oDXcn3TcUR+9ayJaJCG1
         LZo8uPAxOSqqwQgxfppNbrgU7/4QKzwlyxx1dHzgTMqHKFqwkYKgQdBgpGBTq+UarP5W
         ugqDnZ7ln27tUQBnpChz+fGY/VQKuXqPb0qrIMQeHwl2ixJCm3jJENSZrIhrLg9ZaE22
         o7AyqQhb6JdapeM/UVpzmtWvZu29P1FcnNlhE3CiyAgFyUdy2LgHEEZxFkEKWaaUrwQy
         lDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869719; x=1711474519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ow/5GBMcPISThTjSrcd1SKsYsmgnff7DtPK54ZXKUpU=;
        b=MsigqlfTSaagZB7UqexMiPQMD3Rqtk+IZJfFVY7pDNnJHwtupnGO/x9ZeiTTlI3HvB
         WfuJEfLTGKf3TTNWyCaAYOYh6V6CU5iDuIxqBddlOGM7UaVKbRAuFCjsXew2YKWaeWBA
         TueQvi7nHRKC91NmeXyf/SkidytwzWedV6T5SJRffS05NWHMTFKP+4KGWp2dQKRa8XCm
         dK/gn9CXfuQX5t1xF8hcptFUsIJQVPvSk4rxDIqTRvo19N+uuKl9VKAJ3en5iGHkrgFl
         Hrp90wGOs08rdSo8y5lh0rRoxBW3F9xQ/StIESnKnZvrg3qRJ649WZ604gjRiDw7C0h+
         FBOw==
X-Forwarded-Encrypted: i=1; AJvYcCVAjN60AsRtMcQerjU25jXbU0T3ym7NAGpglgyNM+lJteapZIM0nFnkyXY7pw9DRAeQ84eg/YiaCjARVvhulxVliqF5f/1yTulG/oNVLkBsvycplzUhoOb2qWjwfzMjIFV9CQsCPmREjZdXo3mz5mvl/L/DIx4J0qpPOwfTmzYRgeBguw==
X-Gm-Message-State: AOJu0Yy1D3O2vaVgQyeFupvomKZzdGlqHcPDuGqeTlxR8ZVY5CDLf/Xe
	LFeWJdGHmPswkaNlzxMDRtg9FMr1WaWNHMaaLtk9uepEmVquSIDl
X-Google-Smtp-Source: AGHT+IFHYdX39P5CH/Sc+0n/dbZFf0DlQuVN2XmpF6WMW1Nik6uP5NLe6nG3lUNpA+AC3IUAsIE21Q==
X-Received: by 2002:a17:90a:b701:b0:29c:5fef:f14d with SMTP id l1-20020a17090ab70100b0029c5feff14dmr2991600pjr.39.1710869719094;
        Tue, 19 Mar 2024 10:35:19 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id sh1-20020a17090b524100b0029951d04dc4sm10012989pjb.54.2024.03.19.10.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 10:35:18 -0700 (PDT)
Message-ID: <28c995cb-1660-435f-9ee4-1195439231f0@gmail.com>
Date: Tue, 19 Mar 2024 23:05:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Content-Language: en-US
To: Vaishnav Achath <vaishnav.a@ti.com>, Michael Walle <mwalle@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 lorforlinux@beagleboard.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
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
 <81ec4156-8758-406e-876b-5acf13951d09@gmail.com>
 <CZXSKOLK6S1S.N86E2AZG2V90@kernel.org>
 <2eec6437-dd11-408d-9bcb-92ba2bee4487@ti.com>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <2eec6437-dd11-408d-9bcb-92ba2bee4487@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/19/24 22:49, Vaishnav Achath wrote:
>> A driver could call a user-space helper, which will read the EEPROM
>> content (or maybe the driver already passes the content to the
>> helper), translate it to a DT overlay, and load it. Wouldn't that
>> work?
>>
>> I'm not saying that is the way to go, just evaluate some ideas.
>>
>
> This would work in most cases when we want to instantiate devices on a 
> physical mikroBUS port on the host running Linux, but another use case 
> we need to support is to instantiate devices on a virtual/greybus 
> mikroBUS port created through greybus, this is the case when a remote 
> microcontroller board (Example BeagleConnect Freedom) has mikroBUS 
> ports and through the magic of greybus these virtual ports 
> (corresponding to the physical remote ports) appear on the Linux host 
> - now we cannot use a device tree overlay to instantiate a Weather 
> click (BME280) sensor on this port, that is why the choice of 
> extending greybus manifest was chosen, another alternative here is to 
> go and add device tree as a description mechanism for greybus, please 
> let know if that is the recommended way forward?
>
> The greybus manifest already is being used in the greybus susbystem 
> for describing an interface and there are already greybus controllers 
> (SPI/I2C .etc) being created according to the manifest contents, all 
> this driver does is to extend that format to be able to instantiate 
> devices on these buses. The primary goals for introducing the driver 
> for mikroBUS add-on boards are:
>
> 1) A way to isolate platform specific information from add-on board 
> specific information - so that each permutation of connecting the 
> add-on board on different ports on different board does not require a 
> new overlay.
> 2) A way to instantiate add-on boards on greybus created virtual 
> mikroBUS ports.
> 3) Both 1 and 2 should use the same add-on board description format.
>
> Standard device tree overlays did not help to achieve this and that is 
> why the standard interface discovery mechanism in greybus, the 
> manifest was extended even though it is not the most optimal way to 
> describe hardware.


Yes, after discussion with Vaishnav and trying to brainstorm some way to 
do the same thing with dt overlays, it seems that trying to use dt 
overlays will mean need to have completely separate implementation of 
mikroBUS for local ports and mikroBUS over greybus. Additionally, trying 
to put dt overlays in EEPROM would mean they will be incompatible with 
use in local ports and vice versa.

Also, I feel like jumping to userspace can fail for all sorts of reasons 
and undermine the plug and play support that clickID strives for.


>
>>> The manual involvement of user space is only for non EEPROM boards 
>>> since
>>> we do not have a way to identify the board without the user needing to
>>> provide the manifest.
>>
>> FWIW, I'm not talking about manual steps here. But more of
>> call_usermodehelper(). Or maybe udev can do it?
>>
>> Btw, [1] mentions hot-plugging. Is that really hot-plugging while
>> the system is running? How would that work?
>>
>
> This should be corrected, it is not recommended to hot-plug the board 
> as the connector standard does not ensure any power sequencing and can 
> cause damage.


Yes, as long as local port is concerned, hot plugging is not 
recommended. However, when using greybus, it is possible to hotplug the 
node that mikroBUS is connected to.


>
>>>> Also how do you know whether there is an EEPROM
>>>> or not?
>>>
>>> Set RST GPIO to low. clickID supported board will enter ID MODE, Then
>>> check if CS line has a w1 gpio bus.
>>
>> Ok.
>>
>>>>> 3. Over Greybus
>>>>>
>>>>> It is quite important to have mikroBUS over greybus for 
>>>>> BeagleConnect.
>>>>> This is one of the major reasons why greybus manifest was chosen 
>>>>> for the
>>>>> manifest format.
>>>>>
>>>>> Also, it is important to note that mikroBUS manifest is being used 
>>>>> since
>>>>> 2020 now and thus manifests for a lot of boards (both supporting 
>>>>> clickID
>>>>> and not supporting it exist). So I would prefer using it, unless of
>>>>> course there are strong reasons not to.
>>>> And also here, I'm not really familiar with greybus. Could you give
>>>> a more complex example? My concern is that some driver might need
>>>> additional properties from DT (or software nodes) to function
>>>> properly. It might not only be a node with a compatible string but
>>>> also more advanced bindings. How would that play together with this?
>>>> My gut feeling is that you can handle any missing properties
>>>> easier/better (eg. for existing modules) in user space. But maybe
>>>> that is already solved in/with greybus?
>>>
>>> Greybus is a communication protocol designed for modular electronic
>>> devices. It allows different parts of a device to be hot plugged (added
>>> or removed) while the device is still running. Greybus manifest is used
>>> to describe the capabilities of a module in the greybus network. The
>>> host then creates appropriate bidirectional unipro connections with the
>>> module based on the cports described in the manifest. I have added a
>>> link to lwn article that goes into more detail.
>>>
>>> BeagleConnect simply allows using greybus over any bidirectional
>>> transport, instead of just Unipro.
>>>
>>> I cannot comment much about how greybus handles missing properties.
>>> While greybus also works just in kernel space, greybus protocols are
>>> inherently higher level than kernel driver, so it might have an easier
>>> time with this.
>>>
>>> I have also added a link to eLInux page which provides rational for the
>>> mikroBUS manifest. But the crux seems to be that dynamic overlays were
>>> not well-supported back then. Also, the use of mikroBUS using greybus
>>> subsystem was already used. Hence the mikroBUS driver.
>>
>> I see this as an opportunity to improve the in-kernel overlays :)
>>
>>> Greybus is not a big blocker from my perspective, since it is always
>>> possible to introduce a new protocol for mikroBUS in Greybus spec. I
>>> think as long as both EEPROM and non EEPROM boards can be supported by
>>> mikroBUS driver and dt-bindings, are can be used outside of Linux (eg:
>>> ZephyrRTOS, nuttx, etc), it is fine.
>>>
>>>> Here's a random one: the manifest [1] just lists the compatible
>>>> string apparently, but the actual DT binding has also reset-gpios,
>>>> some -supply and interrupt properties.
>>>>
>>>> -michael
>>>>
>>>> [1] 
>>>> https://github.com/MikroElektronika/click_id/blob/main/manifests/WEATHER-CLICK.mnfs
>>>
>>>
>>> Yes, the concern is valid. Support for validating the manifest is
>>> nowhere near as good as devicetree overlays. But I think that would 
>>> be a
>>> problem with the device rather than the responsibility of the 
>>> kernel. It
>>> is up to the manufacturer to have valid manifests.
>>
>> But does the manifest have the capabilities to express all that
>> information? To me it looks like just some kind of pinmux, some
>> vendor strings and a (DT) compatible string.
>> [coming back to this after seeing [2]: there are more properties,
>> but it seem just be a list of property=value]
>>
>> What I'd like to avoid is some kind of in-kernel mapping list from
>> manifest to actual driver instantiation.
>
> The property descriptor is implemented to account the properties under 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/property.h#n22 
>
>
> There is no in-kernel mapping that needs to be updated per driver, but 
> a generic mapping and some specific mapping depending on the bus the 
> device is connected (I2C/SPI/.etc)
>
>>
>> I guess you'll get much of that with DT overlays already and if you
>> have some kind of automatic translation from manifest to DT overlay,
>> it will still be plug-and-play. You could fix up any missing
>> properties, etc. manually loading some manifests/dt overlays for
>> modules without EEPROMs.
>>
>> Again, a more complex manifest file would really be appreciated
>> here. Not just a simple "there is exactly one trivial SPI device on
>> the bus".
>>
>> FWIW, here is a more complex example [2] which uses the ssd1306
>> display driver. Dunno if that is a good example, as it seems to use
>> the fb_ssd1306 driver (at least that's what I'm deducing by reading
>> the driver-string-id) in staging and there is also ssd1307fb.c in
>> drivers/video/fbdev. But how are the additional information like
>> width and height translate to the properties of the driver (device
>> tree properties, swnode properties, platform_data*)?
>>
>
> The driver uses device_property_read_* helpers to fetch the 
> infromation and the mikroBUS driver populates the table of properties 
> fetching the information from manifest and combining with platform 
> information.
>
>> On a side note, does the manifest files use the (linux) kernel
>> module name for the driver-string-id?
>>
>
> The spi_device_id is used for the driver-string-id :
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/fbtft/fbtft.h#n361 
>
>
> Thanks and Regards,
> Vaishnav
>
>> -michael
>>
>> [1] https://github.com/MikroElektronika/click_id/blob/main/README.md
>> [2] 
>> https://github.com/MikroElektronika/click_id/blob/main/manifests/OLEDB-CLICK.mnfs
>>
>>> Link: https://lwn.net/Articles/715955/ Greybus
>>> Link https://elinux.org/Mikrobus eLinux article
>>

I apologize if I gave the wrong impression, but the ability to enable 
mikroBUS over Greybus is extremely important here. I left out mikroBUS 
over greybus support from this patchset to allow for easier upstreaming 
of a new driver. However, that does not mean it is a secondary goal of 
this patch.

The current mikroBUS manifest is compatible with Greybus manifest, and 
thus is easy to integrate into standard Greybus. Anything suggested here 
still needs to enable support of mikroBUS over Greybus.


Ayush Singh


