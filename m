Return-Path: <linux-kernel+bounces-109384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7192881865
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9B91F210DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FCE8594B;
	Wed, 20 Mar 2024 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=equiv.tech header.i=@equiv.tech header.b="Z9+zpm5D"
Received: from so254-32.mailgun.net (so254-32.mailgun.net [198.61.254.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26785925
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.61.254.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965498; cv=none; b=SiKwLY/pzpEXwXCykWsxsvgI+APAmIt3BxEO9f6sHuxvOtqGCjymskzU6cyMxNwjXXbpdacG2DAwl23dGa6DcptiyTbOme7gI22RTLHOXBbqSh7XD76WROXgXJsWE+Smj5l2AwqIVDNTWEaXjqUr05O/PJVL5Nhh7zIVYgTJv2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965498; c=relaxed/simple;
	bh=Oz5ZjMCIRPmh5VuGFkGpEzCbG8O5zibKh1t5gb/LpIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMqaZ0mXFROjgNJGCLW48jLDMfOxUG4/PqcsNujlorv2XtxxLATS0JWD4I6NDAQAcWpRuJWaFNVkpG6612/DKcMnwSlOBUZH+V8TaDeNbwbe4WbolDOKgsw3yJi7t91xalwAaLIkG0pEh7rKKjPPlefOJ+mK8LCfgCPiaKKz/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=equiv.tech; spf=pass smtp.mailfrom=equiv.tech; dkim=pass (2048-bit key) header.d=equiv.tech header.i=@equiv.tech header.b=Z9+zpm5D; arc=none smtp.client-ip=198.61.254.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=equiv.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=equiv.tech
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt; s=mx; t=1710965495; x=1710972695;
 h=In-Reply-To: Content-Type: MIME-Version: References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date: Sender: Sender;
 bh=r7CsR24eon0gXEkEyGo+pWJ4MaqAG5+Utjc3J4F9Ev4=;
 b=Z9+zpm5DMPb6QkaUNjWl1qIqChSwoYszA7hUcEUHoYgM5IBQYQnmi8BsVwYQtam9f/eZT1SLEDNDpo3SEr7UF/g+CL7Dxdp/gGv5hQHlrYiMGEC6E5TfAz3lWRsQnk2aqxJp4pR3BSKOJDiV2gVfWRENijZpmXaVVkjWztBEEUgwVzGrwTA3YfsgDbHzM6MMyTD1r03bukb2PSz2SISjFPvFMsIgI1H8+qNne0jOf34np+rd8dsUM2+48vKMk+G+mYyVjKorrMyNzuRypvB5v7pPIkJj+TjvsJSMxL0ohj9rfslc4Z4V/th/bM4w0dKDYBc73tszj5yikfuqxi2h+w==
X-Mailgun-Sending-Ip: 198.61.254.32
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by d1cfb0595350 with SMTP id
 65fb42f73435515e476ed72f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Mar 2024 20:11:35 GMT
Sender: james@equiv.tech
Date: Wed, 20 Mar 2024 13:11:34 -0700
From: James Seo <james@equiv.tech>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/1] hwmon: (hp-wmi-sensors) Support autoloading
Message-ID: <ZftC9ojx42l1VAUe@equiv.tech>
References: <20240318215732.322798-1-W_Armin@gmx.de>
 <Zfkm71dmnRsdmYJz@equiv.tech>
 <a2c2ef97-3830-4277-8560-b97cfb8eb78e@gmx.de>
 <ZfowhGaCWffQ2N1K@equiv.tech>
 <600844b1-0d62-4b74-89b7-f185a793038b@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <600844b1-0d62-4b74-89b7-f185a793038b@gmx.de>

On Wed, Mar 20, 2024 at 04:13:59PM +0100, Armin Wolf wrote:
> Am 20.03.24 um 01:40 schrieb James Seo:
> 
>> On Tue, Mar 19, 2024 at 02:00:06PM +0100, Armin Wolf wrote:
>>> Am 19.03.24 um 06:47 schrieb James Seo:
>>> 
>>>> On Mon, Mar 18, 2024 at 10:57:31PM +0100, Armin Wolf wrote:
>>>>> Currently, the hp-wmi-sensors driver needs to be loaded manually
>>>>> on supported machines. This however is unnecessary since the WMI
>>>>> id table can be used to support autoloading.
>>>>> 
>>>>> However the driver might conflict with the hp-wmi driver since both
>>>>> seem to use the same WMI GUID for registering notify handler.
>>>>> 
>>>>> I am thus submitting this patch as an RFC for now.
>>>>> 
>>>>> Armin Wolf (1):
>>>>>     hwmon: (hp-wmi-sensors) Add missing MODULE_DEVICE_TABLE()
>>>>> 
>>>>>    drivers/hwmon/hp-wmi-sensors.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>> 
>>>>> --
>>>>> 2.39.2
>>>>> 
>>>> Autoloading was deliberately left out for now because of the GUID
>>>> conflict with hp-wmi's WMI notify handler.
>>>> 
>>>> HP's GUID reuse across product lines for different types of WMI
>>>> objects with different names and shapes means that with a patch like
>>>> this, many systems that should only load hp-wmi-sensors but not
>>>> hp-wmi will try to autoload both. (Perhaps all of them; I want to say
>>>> that the GUID 5FB7F034-2C63-45e9-BE91-3D44E2C707E4, which is the
>>>> second of the two GUIDs that hp-wmi uses to autoload, exists on every
>>>> HP system I've examined.)
>>>> 
>>>> Meanwhile, hp-wmi does various other platform things, and there's so
>>>> much hardware out there that who knows, maybe there are some systems
>>>> that really should load both. I don't think so but I can't rule it
>>>> out.
>>>> 
>>>> Unlike hp-wmi-sensors, hp-wmi doesn't survive failure to install its
>>>> notify handler, which sets up a potential race condition depending on
>>>> when hp-wmi and hp-wmi-sensors loads on a given system.
>>>> 
>>>> Therefore, I intended to add autoloading at the same time as
>>>> converting hp-wmi-sensors to use the bus-based WMI interface once
>>>> aggregate WMI devices are better supported.
>>>> 
>>>> As you mentioned [1], I ran into issues when I tried to do the
>>>> conversion by simply adding the GUID to struct wmi_driver.id_table.
>>>> That resulted in two separate independent instances of hp_wmi_sensors
>>>> being loaded, which isn't what I wanted.
>>> After taking a look at a ACPI table dump of a HP machine, i noticed that
>>> HPBIOS_BIOSEvent has the GUID 2B814318-4BE8-4707-9D84-A190A859B5D0, which is
>>> different than the event GUID used by hp-wmi.
>>> 
>>> According your comment in hp_wmi_notify(), i assume that some machines have
>>> mixed-up event GUIDs.
>> I investigated further. Every HP machine in the Linux Hardware Database that
>> has \\.\root\WMI\hpqBEvnt at 95F24279-4D7B-4334-9387-ACCDC67EF61C also has
>> \\.\root\WMI\HPBIOS_BIOSEvent at 2B814318-4BE8-4707-9D84-A190A859B5D0.
> 
> Could it be that using 95F24279-4D7B-4334-9387-ACCDC67EF61C is a mistake?
> Or do you know of a machine which indeed uses this GUID to deliver sensor events?
> Because it not, then we can just avoid this GUID conflict entirely by using the
> other GUID.
>

No, it's not a mistake, it's HP reusing GUIDs. Both my test machines use
95F24279-4D7B-4334-9387-ACCDC67EF61C for \\.\root\WMI\HPBIOS_BIOSEvent.

Previously I examined a sample of ACPI dumps from machines with both
hpqBEvnt and HPBIOS_BIOSEvent, and concluded:

  - hpqBEvnt is for various events on both business and non-business
    machines that are of no interest to hp-wmi-sensors (e.g. hotkeys)

  - some machines with hpqBEvnt also have HPBIOS_BIOSEvent at GUID
    2B814318-4BE8-4707-9D84-A190A859B5D0

  - no machines with both hpqBEvnt and HPBIOS_BIOSEvent actually surface
    relevant sensor events (e.g. fan speed too high) via HPBIOS_BIOSEvent;
    they only surface non-sensor events (e.g. BIOS setting was changed)
    that are of no interest to hp-wmi-sensors

  - therefore, 2B814318-4BE8-4707-9D84-A190A859B5D0 does not need to be
    handled in hp-wmi-sensors

But this time I have done an exhaustive examination and concluded that a
few machines with both events do surface sensor events via HPBIOS_BIOSEvent.

>>> I thing it would be best to create a separate WMI driver for the event and
>>> use a notifier chain (see include/linux/notifier.h) to distribute the event data.
>>> 
>>> In case of event GUID 95F24279-4D7B-4334-9387-ACCDC67EF61C, both hp-wmi and
>>> hp-wmi-sensors can subscribe on this notifier and receive event data without
>>> stepping on each other's toes.
>>> 
>>> The same can be done for the event GUID 2B814318-4BE8-4707-9D84-A190A859B5D0,
>>> with a separate notifier chain.
>>> 
>>> This would decouple the event handling from the event data consumers, allowing
>>> both hp-wmi and hp-wmi-sensors to coexist.
>> No objections from me for this specific use case to work around the GUID conflict.
>> hp-wmi-sensors should indeed subscribe on 2B814318-4BE8-4707-9D84-A190A859B5D0
>> for some of those machines.
>> 
>> Any ideas for getting rid of wmi_query_block() for fetching
>> \\.\root\HP\InstrumentedBIOS\HPBIOS_PlatformEvents? I know other drivers are
>> also using it for getting blocks other than their "main" GUID.
> 
> Good question, it seems that HPBIOS_PlatformEvents is optional, so using the component
> framework will not work.
> 

Yes, HPBIOS_PlatformEvents is optional, but it's pretty much necessary for
alarm and intrusion events. Without it, it's not possible to know whether a
machine even reports such events until after they occur (rare). We'd have
to assume that all machines always support such events.

> If those WMI data blocks are always associated with the same ACPI device used by the
> sensors GUID, then maybe i could create some sort of API for checking if a given GUID
> exists the ACPI device associated with a WMI device.

For all HP machines in the Linux Hardware Database, all machines with
HPBIOS_PlatformEvents also have HPBIOS_BIOSNumericSensor. The reverse is
not true. Neither WMI object appears under multiple GUIDs.

> However i thing the event GUID issue is more important right now.

Sure. I also wonder if your idea could be expanded into a generic driver
for publishing simple WMI events. This would be usable in other drivers
that are currently using legacy handlers for receiving event data.

More broadly, if hp-wmi-drivers is any indication, aggregate WMI devices
could be a pain. Primary WMI object, associated WMI objects (optional or
mandatory), multiple aggregate devices allowed to bind to the same
objects. And if using GUIDs for identification, multiple allowable GUIDs.

Thanks,

James

> Thanks,
> Armin Wolf
> 
>>> I can provide a prototype implementation, but unfortunately i have no HP machine
>>> myself for testing. But i might be able to find one to test my changes.
>> Happy to test. (Also happy to try it myself, but I'd need some help.)
>> 
>>> Thanks,
>>> Armin Wolf
>>> 
>>>> [1] https://lore.kernel.org/linux-hwmon/cd81a7d6-4b81-f074-1f28-6d1b5300b937@gmx.de/
>>>> 

