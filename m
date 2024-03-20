Return-Path: <linux-kernel+bounces-109073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74D488144F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1658E1C217EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F231F524AA;
	Wed, 20 Mar 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Kr4yXVly"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE04DA1A;
	Wed, 20 Mar 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947659; cv=none; b=FgtLWvRsVg7yitrnZw2x0UyIdsEv5QuSzuNRT/hw0VdbUCN+ZtFbU8UNRfRWD5OwE/y8ZmC8wF2fguHyghv904sRCCdnmZ23y+f2BP6e1hDBspr853YPigHreaO6/7/mlIk8E//s34NzAfJ/avg2ptopCNJNvfVxhoPL37DLlog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947659; c=relaxed/simple;
	bh=kIAdFEj/7Z2kfL6RjSJnLwd4QaBMoZ7xnoSrhhA6bQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hp/PU7HkNMO4cGY/ZKsP8i1nRQ6fOXVzkkDQenrOp9pPLmqwo/8In9A/bLtcLeU/OqH02YgX62Z6FHF1HK7iR1Teubx5WQM7BDng3J3Zrqjl7q/mac6QwrdZ2V3SuwKKzdZBqF1s0feHH2ARj4f2yz2llWL/67eCGB/oE/onmMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Kr4yXVly; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710947640; x=1711552440; i=w_armin@gmx.de;
	bh=uddcCf+JvdQyj1QNEp4ag2EgQVjb12SVz6FKDooCSiQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Kr4yXVlyuQy2l8PRdNtnygu5KLrObF11Gco1sXLGXSq1JIwu0FNIHUSHawqQd0GU
	 WkLy5SJB1qpqdLdmV8HgVwaK4WXvHU4ogCreKHaoBeI+/6O4xn1ahBrtcxLDQcyT8
	 htVHix6PFlr8LdkTOI8sXJnEIHQFEL4lzoTR74NIfZ8XrEymyvadIG2h6sYFkd4OI
	 AmsQt64i7db4oPevPvFNwoFWDFJOMIDDgDWatsrBASg9Zj4aaQlIpu+BfKRv206iG
	 Ao7ywxv3MbYFpU4uFG8BIvJD9d9yUy+9vismoY+6tgW4u9uAJ5ZddbDTCThBVU1Wd
	 yL7D953tvZQFiE7hjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95eJ-1qjWu71J71-0169MD; Wed, 20
 Mar 2024 16:14:00 +0100
Message-ID: <600844b1-0d62-4b74-89b7-f185a793038b@gmx.de>
Date: Wed, 20 Mar 2024 16:13:59 +0100
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
 <ZfowhGaCWffQ2N1K@equiv.tech>
Content-Language: de-DE, en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <ZfowhGaCWffQ2N1K@equiv.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:b4BdwK0mk935Kxx3xFT3KI515rjvMWHEUmrXT9womQkh9/smjvG
 SNoFM1HTpBv/6qk/nVKJ8J59fQg5TdESGQrUI9/OP7fz/QjU4asHyNe/IaUkA42y01mnb7d
 WfAcYn6xGCNLNP8XjcxG6ZqIa1kmE+g+V2DSL11O6D0dmlenBn3Bw10OMVy8NqZtpr0Yk0P
 cxGpKBx3BV8RaIIRNzKAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jx2zD26ey5s=;Pb+FSuA/qpDCchvNwUWwb1PaCHl
 j9Xl5uoZHMszQoA0NV+SGRiXcbVy4dX0k5zgFI6l9GfXFn8idDbzXZsbwSChEXfi4une73QSy
 5CMP7AahtUP4cXY2tPobH95zQOvfbq4N8xZKOrM8ew3ONNd8Dl7gevUEq+rFfMAFBiB+qCIn/
 8rZD1JTQReVj40VeVSXhx+qFGbREojvVsg2wSeW0aerzqwMad7rXvgaZG4ryw4Vt02ngWCSeK
 zvfDqTXuNbA6RZngOCqCKe9uTbMo+K+H7IY9o+iEWw1dxHoPJZ9truQ6ABcY1+YaVBv4BvdQH
 h0SDIfGK1GQevZXHcBR/fi1arrbbRn8HeQgUjBZIErPogmCqCDAmhq6z1mz6kDB0ZT2tuhtr/
 Yxv91SdXM9hz/0MoWI01kiYFXREihAn4qTVyozuV7D/2+ck43K/q66LmLaWzDGrFz7KyY881y
 aBW3OfvuJlUmDVveAPQeamdu4hIjifCP+k2De/8eIOpK9LX7tQwn3a8CR62ktPRz0eovpppvT
 D60n5NzzrVogkjrDWXlPdXj1BUzveLpD+0Dxlb9xLGXHZAp1nyEj5lUyt2l0J+qm89LRG3jYv
 BfI1crxpn+revm0iXZgAZiuKvwpuC/pl22pRJvFJSUUouTnWhy9UtWe6h7VNcih/9dnGEgznL
 9y9nhFkT+C7XUQY9/RzqVNVmxy4GgoW62ZA3zaYq77+vl5Joonoy9xqbtED777gipDPx3zlCu
 NgkAvYE7tJEJX1WUjuq28bG7RdnvGTDAwF1v7QVchrIUr8Q3GCvkBgFvqfhEeXkmADoVSkxyr
 IHO0JuL0uRSNh+ZTQ2ey407HyNeiezfav/X+mgeFjJwns=

Am 20.03.24 um 01:40 schrieb James Seo:

> On Tue, Mar 19, 2024 at 02:00:06PM +0100, Armin Wolf wrote:
>> Am 19.03.24 um 06:47 schrieb James Seo:
>>
>>> On Mon, Mar 18, 2024 at 10:57:31PM +0100, Armin Wolf wrote:
>>>> Currently, the hp-wmi-sensors driver needs to be loaded manually
>>>> on supported machines. This however is unnecessary since the WMI
>>>> id table can be used to support autoloading.
>>>>
>>>> However the driver might conflict with the hp-wmi driver since both
>>>> seem to use the same WMI GUID for registering notify handler.
>>>>
>>>> I am thus submitting this patch as an RFC for now.
>>>>
>>>> Armin Wolf (1):
>>>>     hwmon: (hp-wmi-sensors) Add missing MODULE_DEVICE_TABLE()
>>>>
>>>>    drivers/hwmon/hp-wmi-sensors.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> --
>>>> 2.39.2
>>>>
>>> Autoloading was deliberately left out for now because of the GUID
>>> conflict with hp-wmi's WMI notify handler.
>>>
>>> HP's GUID reuse across product lines for different types of WMI
>>> objects with different names and shapes means that with a patch like
>>> this, many systems that should only load hp-wmi-sensors but not
>>> hp-wmi will try to autoload both. (Perhaps all of them; I want to say
>>> that the GUID 5FB7F034-2C63-45e9-BE91-3D44E2C707E4, which is the
>>> second of the two GUIDs that hp-wmi uses to autoload, exists on every
>>> HP system I've examined.)
>>>
>>> Meanwhile, hp-wmi does various other platform things, and there's so
>>> much hardware out there that who knows, maybe there are some systems
>>> that really should load both. I don't think so but I can't rule it
>>> out.
>>>
>>> Unlike hp-wmi-sensors, hp-wmi doesn't survive failure to install its
>>> notify handler, which sets up a potential race condition depending on
>>> when hp-wmi and hp-wmi-sensors loads on a given system.
>>>
>>> Therefore, I intended to add autoloading at the same time as
>>> converting hp-wmi-sensors to use the bus-based WMI interface once
>>> aggregate WMI devices are better supported.
>>>
>>> As you mentioned [1], I ran into issues when I tried to do the
>>> conversion by simply adding the GUID to struct wmi_driver.id_table.
>>> That resulted in two separate independent instances of hp_wmi_sensors
>>> being loaded, which isn't what I wanted.
>> After taking a look at a ACPI table dump of a HP machine, i noticed that
>> HPBIOS_BIOSEvent has the GUID 2B814318-4BE8-4707-9D84-A190A859B5D0, which is
>> different than the event GUID used by hp-wmi.
>>
>> According your comment in hp_wmi_notify(), i assume that some machines have
>> mixed-up event GUIDs.
> I investigated further. Every HP machine in the Linux Hardware Database that
> has \\.\root\WMI\hpqBEvnt at 95F24279-4D7B-4334-9387-ACCDC67EF61C also has
> \\.\root\WMI\HPBIOS_BIOSEvent at 2B814318-4BE8-4707-9D84-A190A859B5D0.

Could it be that using 95F24279-4D7B-4334-9387-ACCDC67EF61C is a mistake?
Or do you know of a machine which indeed uses this GUID to deliver sensor events?
Because it not, then we can just avoid this GUID conflict entirely by using the
other GUID.

>> I thing it would be best to create a separate WMI driver for the event and
>> use a notifier chain (see include/linux/notifier.h) to distribute the event data.
>>
>> In case of event GUID 95F24279-4D7B-4334-9387-ACCDC67EF61C, both hp-wmi and
>> hp-wmi-sensors can subscribe on this notifier and receive event data without
>> stepping on each other's toes.
>>
>> The same can be done for the event GUID 2B814318-4BE8-4707-9D84-A190A859B5D0,
>> with a separate notifier chain.
>>
>> This would decouple the event handling from the event data consumers, allowing
>> both hp-wmi and hp-wmi-sensors to coexist.
> No objections from me for this specific use case to work around the GUID conflict.
> hp-wmi-sensors should indeed subscribe on 2B814318-4BE8-4707-9D84-A190A859B5D0
> for some of those machines.
>
> Any ideas for getting rid of wmi_query_block() for fetching
> \\.\root\HP\InstrumentedBIOS\HPBIOS_PlatformEvents? I know other drivers are
> also using it for getting blocks other than their "main" GUID.

Good question, it seems that HPBIOS_PlatformEvents is optional, so using the component
framework will not work.

If those WMI data blocks are always associated with the same ACPI device used by the
sensors GUID, then maybe i could create some sort of API for checking if a given GUID
exists the ACPI device associated with a WMI device.

However i thing the event GUID issue is more important right now.

Thanks,
Armin Wolf

>> I can provide a prototype implementation, but unfortunately i have no HP machine
>> myself for testing. But i might be able to find one to test my changes.
> Happy to test. (Also happy to try it myself, but I'd need some help.)
>
>> Thanks,
>> Armin Wolf
>>
>>> [1] https://lore.kernel.org/linux-hwmon/cd81a7d6-4b81-f074-1f28-6d1b5300b937@gmx.de/
>>>

