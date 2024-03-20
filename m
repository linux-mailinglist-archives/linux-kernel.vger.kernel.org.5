Return-Path: <linux-kernel+bounces-109452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090DB881963
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771781F23DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A4585C46;
	Wed, 20 Mar 2024 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Nv8JNhxc"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18185C6A;
	Wed, 20 Mar 2024 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972619; cv=none; b=QW7UyTHmJnWXtQUxtSIj/hNTkR2s/H3k3ck8f2tlO82TuVQgaCtokHWyqn1vrzyx1jpuEcHRO8uiLucSEe/tUgU3g0cqo9cFTCsf6tfTnm6aaM2BiTAWE00WJEfQfi9mplEtLOKn9vJRssrQ8AMwCJ9tDQYByuWOZXig4uZZp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972619; c=relaxed/simple;
	bh=CsJEQmADrhPtwSvw4VsmHPtfUHOgnMp/31Ev3IRt72I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WocBmembfNx6G4SMJqWC4QzqN2LolZx3D+1MauPwLt/gcA7dQ91JLOr/3OqrQ7j1X1ULI6qfXLMvEXTeguXjnmCAYdTZqnu+/sff74xlbEgZTx3pa7bjipq+UcXxzGVRTSiLmR9fUk1wJCv/yCzq1hp+38GMHFQTJEJA0YFbkfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Nv8JNhxc; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710972600; x=1711577400; i=w_armin@gmx.de;
	bh=bBDJ89eKrYBnC5jCQdMNiAA43zoSa7FO4K0DYa5qj6Y=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Nv8JNhxc2HY7lFElxE7IwtnEeoKwVd2oQadfRV9DbXn3MvT8BpxN815smlDihpbq
	 /C7KYE78FbV2RVdIAfCPMYatbSylgwy10tsAlXBxYSqWByDCRaq35uNUoMqqhRoMV
	 v+U2bXl7CR8mWlXlNAOGdmJroxy9/brkvzYg7WsaDTpDXU9uX9nQSKEtpalL1dNmz
	 we9N/BJIJbZoAKoye+wrR/5zSrEFx874nKSijJOvvkyCCWI5TQmaZxLeH0WBfUkN5
	 /EDCzsXd9dJg1n635aw9YiiFhiam0lx/yS5v+BJCZVZ6zLkonWNIb5r53ymTvZsYo
	 Qx+1tIbPJ3niY1KoTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mGB-1qg7YR1Y67-017G9e; Wed, 20
 Mar 2024 23:10:00 +0100
Message-ID: <3e069b7a-fa22-453b-a507-dccc48eb60a3@gmx.de>
Date: Wed, 20 Mar 2024 23:09:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] hwmon: (hp-wmi-sensors) Support autoloading
To: James Seo <james@equiv.tech>
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240318215732.322798-1-W_Armin@gmx.de>
 <Zfkm71dmnRsdmYJz@equiv.tech> <a2c2ef97-3830-4277-8560-b97cfb8eb78e@gmx.de>
 <ZfowhGaCWffQ2N1K@equiv.tech> <600844b1-0d62-4b74-89b7-f185a793038b@gmx.de>
 <ZftC9ojx42l1VAUe@equiv.tech>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <ZftC9ojx42l1VAUe@equiv.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7WH5sVgc4uu67eTNbgk3R4mJdc3/qTKwsOWtOBgWZVN75QhOZeN
 JO6e7oPud/fIxldAlL3wcD1G4Wcg4WULPwnWgILluwDNVaZDVJfNug0NbWNLKeGUMoK8ZNY
 5pddpgMem4b2lLHGvcfP1Cm++bjnUs0tQEz61zqNTXQ59CMhZP9OfrA+5FkKMZLrIYRl5EW
 k48j8jPRoM42MloNFWmLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UnGSoemeVAQ=;Tr587FPkH1h6y4ii5EI7Y1oforS
 W/16v4jB1cw6oTk9t1ZCOp06SADg4tcQKGhBEgSPD0Irtu8SIbeQLYkcSjFCkswkGiNMvLlAT
 Abl8jFCAJCgZDAAncOvGZnwAPNZmr80Qb6a2vc1tur0lom3nYIQBOd/QZgYcTC0SAaDFRFNZX
 k+MecdzPu7BuY07NPqh3fMB6KkG6tlUk6fB7B2cx8pp6lTbfbWjcD+rjyTfhc73/njUWayjBg
 rdu0dklEWEfXkKPPxCcjtu7NkSlLXmwCyhCBd+G8DDGFiTyRztvCBTp6w/0QhkPBj9m8UxFE2
 PxMqqVSIHETBFmkZwCRgxdtd0cYsYj6ig0wEigaPun7+KHpisqxH9My/ZpF7FLoUVTIL5r/84
 /9/mPIjn+vh+D2mevRN+pGNNStwCLeXasQZLOyRwUNQwGH52RNLrcRdmxBrB8h4MkO1LJr8ih
 EW1qgAjF3keIBwwpCQDsXxreL8Acv4O8l2GlljqBPlovX1qDUF1FFDyoXXX1Qv5GGtlzpOMXI
 Vmu3y+s42US25T66mUdF//WE7BqqkhdQKuAvEhyXSCm3RVeShGtziGNNiaSSKxyM/B0zs9ttT
 m3pXkVn3dnTS+uuTo/B1cUfMkBZ4w7NZEwKfDLbVU15NsyyJY6NsPQmauq00l+eQvxKv1j7Gi
 W422/tP++1DtBU0OJU1vuhdxM4vQRy+eEjltza9DQFZ1WmOrSdmTr74bbUpY9vNl84Q5YUJ8i
 0A0ur+AwQleLUS6YRhMxtohm7nMcEJZMFRd5TI5aKSL7sh7eL3kNJ2+nwJd0LZ/XSJOkSV6Uh
 wzG0KUB9YJj61OqBhSClJkOnXJn+L++fkDSUXrSooKPjk=

Am 20.03.24 um 21:11 schrieb James Seo:

> On Wed, Mar 20, 2024 at 04:13:59PM +0100, Armin Wolf wrote:
>> Am 20.03.24 um 01:40 schrieb James Seo:
>>
>>> On Tue, Mar 19, 2024 at 02:00:06PM +0100, Armin Wolf wrote:
>>>> Am 19.03.24 um 06:47 schrieb James Seo:
>>>>
>>>>> On Mon, Mar 18, 2024 at 10:57:31PM +0100, Armin Wolf wrote:
>>>>>> Currently, the hp-wmi-sensors driver needs to be loaded manually
>>>>>> on supported machines. This however is unnecessary since the WMI
>>>>>> id table can be used to support autoloading.
>>>>>>
>>>>>> However the driver might conflict with the hp-wmi driver since both
>>>>>> seem to use the same WMI GUID for registering notify handler.
>>>>>>
>>>>>> I am thus submitting this patch as an RFC for now.
>>>>>>
>>>>>> Armin Wolf (1):
>>>>>>      hwmon: (hp-wmi-sensors) Add missing MODULE_DEVICE_TABLE()
>>>>>>
>>>>>>     drivers/hwmon/hp-wmi-sensors.c | 2 ++
>>>>>>     1 file changed, 2 insertions(+)
>>>>>>
>>>>>> --
>>>>>> 2.39.2
>>>>>>
>>>>> Autoloading was deliberately left out for now because of the GUID
>>>>> conflict with hp-wmi's WMI notify handler.
>>>>>
>>>>> HP's GUID reuse across product lines for different types of WMI
>>>>> objects with different names and shapes means that with a patch like
>>>>> this, many systems that should only load hp-wmi-sensors but not
>>>>> hp-wmi will try to autoload both. (Perhaps all of them; I want to say
>>>>> that the GUID 5FB7F034-2C63-45e9-BE91-3D44E2C707E4, which is the
>>>>> second of the two GUIDs that hp-wmi uses to autoload, exists on every
>>>>> HP system I've examined.)
>>>>>
>>>>> Meanwhile, hp-wmi does various other platform things, and there's so
>>>>> much hardware out there that who knows, maybe there are some systems
>>>>> that really should load both. I don't think so but I can't rule it
>>>>> out.
>>>>>
>>>>> Unlike hp-wmi-sensors, hp-wmi doesn't survive failure to install its
>>>>> notify handler, which sets up a potential race condition depending on
>>>>> when hp-wmi and hp-wmi-sensors loads on a given system.
>>>>>
>>>>> Therefore, I intended to add autoloading at the same time as
>>>>> converting hp-wmi-sensors to use the bus-based WMI interface once
>>>>> aggregate WMI devices are better supported.
>>>>>
>>>>> As you mentioned [1], I ran into issues when I tried to do the
>>>>> conversion by simply adding the GUID to struct wmi_driver.id_table.
>>>>> That resulted in two separate independent instances of hp_wmi_sensors
>>>>> being loaded, which isn't what I wanted.
>>>> After taking a look at a ACPI table dump of a HP machine, i noticed that
>>>> HPBIOS_BIOSEvent has the GUID 2B814318-4BE8-4707-9D84-A190A859B5D0, which is
>>>> different than the event GUID used by hp-wmi.
>>>>
>>>> According your comment in hp_wmi_notify(), i assume that some machines have
>>>> mixed-up event GUIDs.
>>> I investigated further. Every HP machine in the Linux Hardware Database that
>>> has \\.\root\WMI\hpqBEvnt at 95F24279-4D7B-4334-9387-ACCDC67EF61C also has
>>> \\.\root\WMI\HPBIOS_BIOSEvent at 2B814318-4BE8-4707-9D84-A190A859B5D0.
>> Could it be that using 95F24279-4D7B-4334-9387-ACCDC67EF61C is a mistake?
>> Or do you know of a machine which indeed uses this GUID to deliver sensor events?
>> Because it not, then we can just avoid this GUID conflict entirely by using the
>> other GUID.
>>
> No, it's not a mistake, it's HP reusing GUIDs. Both my test machines use
> 95F24279-4D7B-4334-9387-ACCDC67EF61C for \\.\root\WMI\HPBIOS_BIOSEvent.
>
> Previously I examined a sample of ACPI dumps from machines with both
> hpqBEvnt and HPBIOS_BIOSEvent, and concluded:
>
>    - hpqBEvnt is for various events on both business and non-business
>      machines that are of no interest to hp-wmi-sensors (e.g. hotkeys)
>
>    - some machines with hpqBEvnt also have HPBIOS_BIOSEvent at GUID
>      2B814318-4BE8-4707-9D84-A190A859B5D0
>
>    - no machines with both hpqBEvnt and HPBIOS_BIOSEvent actually surface
>      relevant sensor events (e.g. fan speed too high) via HPBIOS_BIOSEvent;
>      they only surface non-sensor events (e.g. BIOS setting was changed)
>      that are of no interest to hp-wmi-sensors
>
>    - therefore, 2B814318-4BE8-4707-9D84-A190A859B5D0 does not need to be
>      handled in hp-wmi-sensors
>
> But this time I have done an exhaustive examination and concluded that a
> few machines with both events do surface sensor events via HPBIOS_BIOSEvent.

This would have interesting implications for the WMI subsystem. Can you send me
the output of "acpidump" on those test machines?

It also seems that there are machines which do use the other GUID, see here:
https://github.com/lm-sensors/lm-sensors/issues/471 (acpidump at the bottom)

>>>> I thing it would be best to create a separate WMI driver for the event and
>>>> use a notifier chain (see include/linux/notifier.h) to distribute the event data.
>>>>
>>>> In case of event GUID 95F24279-4D7B-4334-9387-ACCDC67EF61C, both hp-wmi and
>>>> hp-wmi-sensors can subscribe on this notifier and receive event data without
>>>> stepping on each other's toes.
>>>>
>>>> The same can be done for the event GUID 2B814318-4BE8-4707-9D84-A190A859B5D0,
>>>> with a separate notifier chain.
>>>>
>>>> This would decouple the event handling from the event data consumers, allowing
>>>> both hp-wmi and hp-wmi-sensors to coexist.
>>> No objections from me for this specific use case to work around the GUID conflict.
>>> hp-wmi-sensors should indeed subscribe on 2B814318-4BE8-4707-9D84-A190A859B5D0
>>> for some of those machines.
>>>
>>> Any ideas for getting rid of wmi_query_block() for fetching
>>> \\.\root\HP\InstrumentedBIOS\HPBIOS_PlatformEvents? I know other drivers are
>>> also using it for getting blocks other than their "main" GUID.
>> Good question, it seems that HPBIOS_PlatformEvents is optional, so using the component
>> framework will not work.
>>
> Yes, HPBIOS_PlatformEvents is optional, but it's pretty much necessary for
> alarm and intrusion events. Without it, it's not possible to know whether a
> machine even reports such events until after they occur (rare). We'd have
> to assume that all machines always support such events.
>
>> If those WMI data blocks are always associated with the same ACPI device used by the
>> sensors GUID, then maybe i could create some sort of API for checking if a given GUID
>> exists the ACPI device associated with a WMI device.
> For all HP machines in the Linux Hardware Database, all machines with
> HPBIOS_PlatformEvents also have HPBIOS_BIOSNumericSensor. The reverse is
> not true. Neither WMI object appears under multiple GUIDs.
>
>> However i thing the event GUID issue is more important right now.
> Sure. I also wonder if your idea could be expanded into a generic driver
> for publishing simple WMI events. This would be usable in other drivers
> that are currently using legacy handlers for receiving event data.

You are completely right, this driver could allow clients to register a
notifier block for a event identified by a GUID, and this notifier block
is then called every time this event is received.

> More broadly, if hp-wmi-drivers is any indication, aggregate WMI devices
> could be a pain. Primary WMI object, associated WMI objects (optional or
> mandatory), multiple aggregate devices allowed to bind to the same
> objects. And if using GUIDs for identification, multiple allowable GUIDs.

I agree, part of it stems from many OEMs designing their interfaces in such
a way that it is impossible to discover if some optional features are present.

I suspect this happens because under Windows, the OEMs just check all GUIDs
once the system has "finished booting" (aka reached the login screen), and
this is afaik not possible with device drivers.

However we cannot export WMI method/events/etc to userspace, as this would
be a security nightmare (random RPC with buggy ACPI firmware, yay!).

In the future we might need an API for at least discovering and interacting
with WMI devices backed by the same ACPI device, however this might take some
time.

I will focus on this WMI event driver for now.

Thanks,
Armin Wolf

> Thanks,
>
> James
>
>> Thanks,
>> Armin Wolf
>>
>>>> I can provide a prototype implementation, but unfortunately i have no HP machine
>>>> myself for testing. But i might be able to find one to test my changes.
>>> Happy to test. (Also happy to try it myself, but I'd need some help.)
>>>
>>>> Thanks,
>>>> Armin Wolf
>>>>
>>>>> [1] https://lore.kernel.org/linux-hwmon/cd81a7d6-4b81-f074-1f28-6d1b5300b937@gmx.de/
>>>>>

