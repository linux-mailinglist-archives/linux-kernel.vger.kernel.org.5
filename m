Return-Path: <linux-kernel+bounces-108271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303148808A0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAEC282B74
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981A7A47;
	Wed, 20 Mar 2024 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=equiv.tech header.i=@equiv.tech header.b="X1beOm5K"
Received: from rs227.mailgun.us (rs227.mailgun.us [209.61.151.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4AD631
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.61.151.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895242; cv=none; b=ix6Ab1yS6XwfkCdZBf25FQxJ/ZjCa8C8458C27CPouRdyKxbGnEOPT3/HXN0wIk2lNS2hv2voKj9yvws75IoGphHk5KN6osa3ETD9sM619Z9Uq8P4Yyyx3qTbBWUzohi2m/1AiHAV/3OCgeuwAKtxgg+Q49paMk2glN1oiSs4ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895242; c=relaxed/simple;
	bh=8UdZEQECNiplv1wHoLYqOuerdmaToHckxFrsTGjFYYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5nlld8FckhS7JXLP2pcxI/bk0hsV4O3hNwIv15RFbHr1AP2DmCt1QadGt16kchiB7cct2WkzWkyHj2JmvlvxYFhbwEbjwR7FGQLgy6ltPPh5SpK/yJCpFOX43COWothPt0xwpGn+Cf2iLnU2iy8AGlOnBLWvGHLjTqdq8cCZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=equiv.tech; spf=pass smtp.mailfrom=equiv.tech; dkim=pass (2048-bit key) header.d=equiv.tech header.i=@equiv.tech header.b=X1beOm5K; arc=none smtp.client-ip=209.61.151.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=equiv.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=equiv.tech
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt; s=mx; t=1710895239; x=1710902439;
 h=In-Reply-To: Content-Type: MIME-Version: References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date: Sender: Sender;
 bh=Vba18DIvpVUb9RocEMGsrgJRp6jLvYik0ghTDLFy9VM=;
 b=X1beOm5KnbLKAcla70JPjpvnb8GCyox6pafg2AdyjBx6Se9iulbrgVLp7a5rHE0s7OMTLwxn6kzscacXljZ6X08L6uLmz7KXAIzGzG/7pRC+KYcGhHGvYzXISa4+eV81DT8hRj/TggNXTBcyKuMYcuAfPN6gY9+JUViEXkSdtpiJ7V3ASEfYy7Eir7LZvZBBH2H1NIZjwj7UVMLrjNz3wRxTeYC+eO9ybniD+d3yDoYv1dz17wAM5XK1gkXejzi81cofVv7iW19ru4Rv9aVFLUxubzqFHRpl0Q8XIo0iSoXuHyZOGkMMUQ5AwXwipD3C7LCRA8xx3zqHeGC9CtxsAg==
X-Mailgun-Sending-Ip: 209.61.151.227
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 569a831ee738 with SMTP id
 65fa308720c07c2af1764548 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Mar 2024 00:40:39 GMT
Sender: james@equiv.tech
Date: Tue, 19 Mar 2024 17:40:36 -0700
From: James Seo <james@equiv.tech>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/1] hwmon: (hp-wmi-sensors) Support autoloading
Message-ID: <ZfowhGaCWffQ2N1K@equiv.tech>
References: <20240318215732.322798-1-W_Armin@gmx.de>
 <Zfkm71dmnRsdmYJz@equiv.tech>
 <a2c2ef97-3830-4277-8560-b97cfb8eb78e@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2c2ef97-3830-4277-8560-b97cfb8eb78e@gmx.de>

On Tue, Mar 19, 2024 at 02:00:06PM +0100, Armin Wolf wrote:
> Am 19.03.24 um 06:47 schrieb James Seo:
> 
>> On Mon, Mar 18, 2024 at 10:57:31PM +0100, Armin Wolf wrote:
>>> Currently, the hp-wmi-sensors driver needs to be loaded manually
>>> on supported machines. This however is unnecessary since the WMI
>>> id table can be used to support autoloading.
>>> 
>>> However the driver might conflict with the hp-wmi driver since both
>>> seem to use the same WMI GUID for registering notify handler.
>>> 
>>> I am thus submitting this patch as an RFC for now.
>>> 
>>> Armin Wolf (1):
>>>    hwmon: (hp-wmi-sensors) Add missing MODULE_DEVICE_TABLE()
>>> 
>>>   drivers/hwmon/hp-wmi-sensors.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>> 
>>> --
>>> 2.39.2
>>> 
>> Autoloading was deliberately left out for now because of the GUID
>> conflict with hp-wmi's WMI notify handler.
>> 
>> HP's GUID reuse across product lines for different types of WMI
>> objects with different names and shapes means that with a patch like
>> this, many systems that should only load hp-wmi-sensors but not
>> hp-wmi will try to autoload both. (Perhaps all of them; I want to say
>> that the GUID 5FB7F034-2C63-45e9-BE91-3D44E2C707E4, which is the
>> second of the two GUIDs that hp-wmi uses to autoload, exists on every
>> HP system I've examined.)
>> 
>> Meanwhile, hp-wmi does various other platform things, and there's so
>> much hardware out there that who knows, maybe there are some systems
>> that really should load both. I don't think so but I can't rule it
>> out.
>> 
>> Unlike hp-wmi-sensors, hp-wmi doesn't survive failure to install its
>> notify handler, which sets up a potential race condition depending on
>> when hp-wmi and hp-wmi-sensors loads on a given system.
>> 
>> Therefore, I intended to add autoloading at the same time as
>> converting hp-wmi-sensors to use the bus-based WMI interface once
>> aggregate WMI devices are better supported.
>> 
>> As you mentioned [1], I ran into issues when I tried to do the
>> conversion by simply adding the GUID to struct wmi_driver.id_table.
>> That resulted in two separate independent instances of hp_wmi_sensors
>> being loaded, which isn't what I wanted.
> 
> After taking a look at a ACPI table dump of a HP machine, i noticed that
> HPBIOS_BIOSEvent has the GUID 2B814318-4BE8-4707-9D84-A190A859B5D0, which is
> different than the event GUID used by hp-wmi.
> 
> According your comment in hp_wmi_notify(), i assume that some machines have
> mixed-up event GUIDs.

I investigated further. Every HP machine in the Linux Hardware Database that
has \\.\root\WMI\hpqBEvnt at 95F24279-4D7B-4334-9387-ACCDC67EF61C also has
\\.\root\WMI\HPBIOS_BIOSEvent at 2B814318-4BE8-4707-9D84-A190A859B5D0.

> I thing it would be best to create a separate WMI driver for the event and
> use a notifier chain (see include/linux/notifier.h) to distribute the event data.
> 
> In case of event GUID 95F24279-4D7B-4334-9387-ACCDC67EF61C, both hp-wmi and
> hp-wmi-sensors can subscribe on this notifier and receive event data without
> stepping on each other's toes.
> 
> The same can be done for the event GUID 2B814318-4BE8-4707-9D84-A190A859B5D0,
> with a separate notifier chain.
> 
> This would decouple the event handling from the event data consumers, allowing
> both hp-wmi and hp-wmi-sensors to coexist.

No objections from me for this specific use case to work around the GUID conflict.
hp-wmi-sensors should indeed subscribe on 2B814318-4BE8-4707-9D84-A190A859B5D0
for some of those machines.

Any ideas for getting rid of wmi_query_block() for fetching
\\.\root\HP\InstrumentedBIOS\HPBIOS_PlatformEvents? I know other drivers are
also using it for getting blocks other than their "main" GUID.

> I can provide a prototype implementation, but unfortunately i have no HP machine
> myself for testing. But i might be able to find one to test my changes.

Happy to test. (Also happy to try it myself, but I'd need some help.)

> Thanks,
> Armin Wolf
> 
>> 
>> [1] https://lore.kernel.org/linux-hwmon/cd81a7d6-4b81-f074-1f28-6d1b5300b937@gmx.de/
>> 

