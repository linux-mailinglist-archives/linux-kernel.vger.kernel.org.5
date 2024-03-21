Return-Path: <linux-kernel+bounces-109694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 992CE881C85
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C293F1C20FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC393C484;
	Thu, 21 Mar 2024 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=equiv.tech header.i=@equiv.tech header.b="KVmdIL5p"
Received: from so254-32.mailgun.net (so254-32.mailgun.net [198.61.254.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D913C489
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.61.254.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711002828; cv=none; b=lbwLeUFul6LQ1hOSle5wDDz/uMJYWcunJ8Q8h69CTs6rf5pzN8A/3GRj+VZc6wP5KvhBcs4ATpBFW3Lq40i/FlymWWwwiE9tcSfPeq2Ta1J1hOqcY814TxwowMrvun4JNLw266FEPIjEcB4SIJQEvOMEywGvYPy0uVu5JqJVF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711002828; c=relaxed/simple;
	bh=l5NvXmfoEJ9hjdegYNGhUeH1uu2R1/Gv2ibCgljUJfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDffmhH+KKeUYmX6dSY9USWFnWhAJeT7h9H3ARQHpBIzgjUmW+8/F2CSNl7Lb7nkxUieQoVscSaRlwqf4gBBWbYUb46CoLzqRx4FApGbc7Jo04pqlESNv6ZFv/nJ1QwkvKJtHqICom2a8uRFiVEt+79cPQuHId06pUr9jONPNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=equiv.tech; spf=pass smtp.mailfrom=equiv.tech; dkim=pass (2048-bit key) header.d=equiv.tech header.i=@equiv.tech header.b=KVmdIL5p; arc=none smtp.client-ip=198.61.254.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=equiv.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=equiv.tech
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt; s=mx; t=1711002825; x=1711010025;
 h=In-Reply-To: Content-Type: MIME-Version: References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date: Sender: Sender;
 bh=XzJ+t9Fh61T5jzkGqNJg0KuBJtVxebS2abQAq5EktDU=;
 b=KVmdIL5pMeHjXdkeLITGrFx4R41bl83fx+75AqZ/p07ueSl7ROZbraNCHO+/AOWSp6mPqpZCezwjYFoy7026xjvB13/WvtAo2nNhkkKU8sPUjIpK2VrjnjxrtYrnK0+PyVZE5bEcjxTAGJhLfoaucFfLE2HC/ITCqR9bZTWZNH37Y0dDN20zaYRWoXA0x911QFmXXwKKlCIaHBo4wP+g45dVfH/h1beH8ZD9CXWF5UnpB89kcFgjdfw87LlCJkZHX76dH09OF55rUBSJP1q3LbnEPrH316fIUZMMHzwEkv2/HH5gEd/KB2ljlmn+nNBTEZr752HZLVgdMN5wdoaRHw==
X-Mailgun-Sending-Ip: 198.61.254.32
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 4733713dca97 with SMTP id
 65fbd4c9548c1b722d673e72 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 Mar 2024 06:33:45 GMT
Sender: james@equiv.tech
Date: Wed, 20 Mar 2024 23:33:44 -0700
From: James Seo <james@equiv.tech>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/1] hwmon: (hp-wmi-sensors) Support autoloading
Message-ID: <ZfvUyPVAuLv3KNUm@equiv.tech>
References: <20240318215732.322798-1-W_Armin@gmx.de>
 <Zfkm71dmnRsdmYJz@equiv.tech>
 <a2c2ef97-3830-4277-8560-b97cfb8eb78e@gmx.de>
 <ZfowhGaCWffQ2N1K@equiv.tech>
 <600844b1-0d62-4b74-89b7-f185a793038b@gmx.de>
 <ZftC9ojx42l1VAUe@equiv.tech>
 <3e069b7a-fa22-453b-a507-dccc48eb60a3@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e069b7a-fa22-453b-a507-dccc48eb60a3@gmx.de>

>>> Could it be that using 95F24279-4D7B-4334-9387-ACCDC67EF61C is a mistake?
>>> Or do you know of a machine which indeed uses this GUID to deliver sensor events?
>>> Because it not, then we can just avoid this GUID conflict entirely by using the
>>> other GUID.
>>> 
>> No, it's not a mistake, it's HP reusing GUIDs. Both my test machines use
>> 95F24279-4D7B-4334-9387-ACCDC67EF61C for \\.\root\WMI\HPBIOS_BIOSEvent.
>> 
>> Previously I examined a sample of ACPI dumps from machines with both
>> hpqBEvnt and HPBIOS_BIOSEvent, and concluded:
>> 
>>    - hpqBEvnt is for various events on both business and non-business
>>      machines that are of no interest to hp-wmi-sensors (e.g. hotkeys)
>> 
>>    - some machines with hpqBEvnt also have HPBIOS_BIOSEvent at GUID
>>      2B814318-4BE8-4707-9D84-A190A859B5D0
>> 
>>    - no machines with both hpqBEvnt and HPBIOS_BIOSEvent actually surface
>>      relevant sensor events (e.g. fan speed too high) via HPBIOS_BIOSEvent;
>>      they only surface non-sensor events (e.g. BIOS setting was changed)
>>      that are of no interest to hp-wmi-sensors
>> 
>>    - therefore, 2B814318-4BE8-4707-9D84-A190A859B5D0 does not need to be
>>      handled in hp-wmi-sensors
>> 
>> But this time I have done an exhaustive examination and concluded that a
>> few machines with both events do surface sensor events via HPBIOS_BIOSEvent.
> 
> This would have interesting implications for the WMI subsystem. Can you send me
> the output of "acpidump" on those test machines?
>
> It also seems that there are machines which do use the other GUID, see here:
> https://github.com/lm-sensors/lm-sensors/issues/471 (acpidump at the bottom)

Here are examples of machines in the Linux Hardware Database with
HPBIOS_BIOSEvent at 95F24279-4D7B-4334-9387-ACCDC67EF61C:

Compaq 8100 Elite SFF PC
EliteDesk 800 G1 SFF
Z400 Workstation

https://github.com/linuxhw/ACPI/blob/master/Desktop/Hewlett-Packard/Compaq/Compaq%208100%20Elite%20SFF%20PC/AB6EADEE22B9
https://github.com/linuxhw/ACPI/blob/master/Desktop/Hewlett-Packard/EliteDesk/EliteDesk%20800%20G1%20SFF/F13506CA489E
https://github.com/linuxhw/ACPI/blob/master/Desktop/Hewlett-Packard/Z400/Z400%20Workstation/FF7C21B8CB39

Here are examples of machines that have hpqBEvnt and HPBIOS_BIOSEvent at
95F24279-4D7B-4334-9387-ACCDC67EF61C and 2B814318-4BE8-4707-9D84-A190A859B5D0
but do not surface sensor events via HPBIOS_BIOSEvent. See PEVT and how it
dereferences into CBWE, which is HPBIOS_PlatformEvents giving information
about the types of _WED/HPBIOS_BIOSEvent that may occur:

ZBook 2015 G4
ZBook Studio G5

https://github.com/linuxhw/ACPI/blob/master/Notebook/Hewlett-Packard/ZBook/ZBook%2015%20G4/89F9520CDC60
https://github.com/linuxhw/ACPI/blob/master/Notebook/Hewlett-Packard/ZBook/ZBook%20Studio%20G5/39AAE603D78B

An example of a machine that has hpqBEvnt and HPBIOS_BIOSEvent at
95F24279-4D7B-4334-9387-ACCDC67EF61C and 2B814318-4BE8-4707-9D84-A190A859B5D0
and does surface sensor events via HPBIOS_BIOSEvent is the ProDesk 405 G6
from https://github.com/lm-sensors/lm-sensors/issues/471 in your previous
message. I found a reason to reply to the GitHub issue with the decompiled
ASL for easy reference. See PEVT and how it dereferences into EVNT, which
is HPBIOS_PlatformEvents giving information about the types of
_WED/HPBIOS_BIOSEvent that may occur. Currently hp-wmi-sensors would not
recognize that this BIOS supports reporting alarm and intrusion events.

And finally, a machine that embodies "weird behavior from a HP BIOS". It has
hpqBEvnt and HPBIOS_BIOSEvent at 95F24279-4D7B-4334-9387-ACCDC67EF61C and
2B814318-4BE8-4707-9D84-A190A859B5D0, and has HPBIOS_BIOSNumericSensor at
8F1F6435-9F42-42C8-BADC-0E9424F20C9A. However, it looks like it just
defines these in BMOF without providing any instances during runtime, or
maybe it generates them in some convoluted non-obvious way:

ZHAN 99 Mobile Workstation G1

https://github.com/linuxhw/ACPI/blob/master/Notebook/Hewlett-Packard/ZHAN/ZHAN%2099%20Mobile%20Workstation%20G1/CB1EEAC36F91

>>>>> I thing it would be best to create a separate WMI driver for the event and
>>>>> use a notifier chain (see include/linux/notifier.h) to distribute the event data.
>>>>> 
>>>>> In case of event GUID 95F24279-4D7B-4334-9387-ACCDC67EF61C, both hp-wmi and
>>>>> hp-wmi-sensors can subscribe on this notifier and receive event data without
>>>>> stepping on each other's toes.
>>>>> 
>>>>> The same can be done for the event GUID 2B814318-4BE8-4707-9D84-A190A859B5D0,
>>>>> with a separate notifier chain.
>>>>> 
>>>>> This would decouple the event handling from the event data consumers, allowing
>>>>> both hp-wmi and hp-wmi-sensors to coexist.
>>>> No objections from me for this specific use case to work around the GUID conflict.
>>>> hp-wmi-sensors should indeed subscribe on 2B814318-4BE8-4707-9D84-A190A859B5D0
>>>> for some of those machines.
>>>> 
>>>> Any ideas for getting rid of wmi_query_block() for fetching
>>>> \\.\root\HP\InstrumentedBIOS\HPBIOS_PlatformEvents? I know other drivers are
>>>> also using it for getting blocks other than their "main" GUID.
>>> Good question, it seems that HPBIOS_PlatformEvents is optional, so using the component
>>> framework will not work.
>>> 
>> Yes, HPBIOS_PlatformEvents is optional, but it's pretty much necessary for
>> alarm and intrusion events. Without it, it's not possible to know whether a
>> machine even reports such events until after they occur (rare). We'd have
>> to assume that all machines always support such events.
>> 
>>> If those WMI data blocks are always associated with the same ACPI device used by the
>>> sensors GUID, then maybe i could create some sort of API for checking if a given GUID
>>> exists the ACPI device associated with a WMI device.
>> For all HP machines in the Linux Hardware Database, all machines with
>> HPBIOS_PlatformEvents also have HPBIOS_BIOSNumericSensor. The reverse is
>> not true. Neither WMI object appears under multiple GUIDs.
>> 
>>> However i thing the event GUID issue is more important right now.
>> Sure. I also wonder if your idea could be expanded into a generic driver
>> for publishing simple WMI events. This would be usable in other drivers
>> that are currently using legacy handlers for receiving event data.
> 
> You are completely right, this driver could allow clients to register a
> notifier block for a event identified by a GUID, and this notifier block
> is then called every time this event is received.
> 
>> More broadly, if hp-wmi-drivers is any indication, aggregate WMI devices
>> could be a pain. Primary WMI object, associated WMI objects (optional or
>> mandatory), multiple aggregate devices allowed to bind to the same
>> objects. And if using GUIDs for identification, multiple allowable GUIDs.
> 
> I agree, part of it stems from many OEMs designing their interfaces in such
> a way that it is impossible to discover if some optional features are present.
> 
> I suspect this happens because under Windows, the OEMs just check all GUIDs
> once the system has "finished booting" (aka reached the login screen), and
> this is afaik not possible with device drivers.
> 
> However we cannot export WMI method/events/etc to userspace, as this would
> be a security nightmare (random RPC with buggy ACPI firmware, yay!).

Interesting info here. I assumed they just worked with string names for
objects and properties and didn't care about GUIDs.

> In the future we might need an API for at least discovering and interacting
> with WMI devices backed by the same ACPI device, however this might take some
> time.
>
> I will focus on this WMI event driver for now.

Looking forward to it. Maybe tell platform-driver-x86 about it too.

Thanks,

James

