Return-Path: <linux-kernel+bounces-107546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DF487FDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674691C21F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08042405FC;
	Tue, 19 Mar 2024 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="m2Zz7PY0"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3633981;
	Tue, 19 Mar 2024 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853226; cv=none; b=Cyy3NvzucIX7fhQePn6ab+vWybHmNC0P+pKdXhNUnEekOphvhmIIcNW8C/OwObh+F4O12ZUUZu6T159hoRFqA4plvkSblruBnQgYAXR3FdPPhUHvOVoKc5u1unitYzMQ+EU93O+1DHRTuBOXMR+KHKrcL0RhpIQ2HGHe/ky3qlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853226; c=relaxed/simple;
	bh=6h4ggd4kJsuUDgFPIuZLKp2omf7z2OBHeTS2aSVdzfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tz3xOewzpYUqU9NMYEabCHA6N5qKo/xvaihMa84SMwVrtRlQY/Lg1EJn9FCH2Jxfi4AkKl9LyVzotEQVn5rSis3ThcqkICns7fj7JNCE8ud/NOAadHdvmc3Djv0UUb1YuvmloOSSgwvrBE7gOfg1EWTCZ2X6HsaUNqoAAqajPOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=m2Zz7PY0; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710853208; x=1711458008; i=w_armin@gmx.de;
	bh=h3r0i7uxPBQEXuxnP1w5J3zwT2m6u+r35CHLKMvMNIc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=m2Zz7PY0a42nqVUVsGeQDMOXEmTDXX02LB82mK5zu1gnkB5LA7NfxN8m13REtLhO
	 TMBAm2gmxbmBiee6BVnQHBUtXejlEjIB2N/hr1ECg4ZDeoKBopQ9CmAGR6FUNtP+m
	 9WTmDHS0Isl0r0NHIhIRKM78bSfm5nkEkPPg1/xwVicliGNfEG+hawhxNxZZCj76Q
	 tE9Xw/Dk9Rc8EFzvLEtS3zl+Yr7LOLmbVC+2R13UpbYSaORIAef/DYF4TdLx35r0e
	 +Z9tFWL30zwBWBrifdLAchJjiIXMD9RXImy8B8g1ytOeDGKweDO+ea+8NlQlNHyUf
	 AYYDgch4/1hyMs7ktQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1r7jbf46m4-00h6AJ; Tue, 19
 Mar 2024 14:00:08 +0100
Message-ID: <a2c2ef97-3830-4277-8560-b97cfb8eb78e@gmx.de>
Date: Tue, 19 Mar 2024 14:00:06 +0100
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
 <Zfkm71dmnRsdmYJz@equiv.tech>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <Zfkm71dmnRsdmYJz@equiv.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vwIxFHYpYPhEq7Io7uBPH7Aocn/DNwHAIHC5Ie1kcRvXfPXbUL1
 osjJtoQUMwbjmsM4/fqxUzz23FaF9diUWVbYAQjzczCMQ3lN7XmaPIxW3pww0SJV78EHqMF
 zPD118kf8e80KubPIDhjZBabhEHR+CIIpxmypPWAObsueJmRQwI0FNRrDR46Jrdbrn1PREO
 HhOvdZYWbkX9EODAZgwqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mXACdlmHwYA=;fwGvU2m/7SqJuxtXPb/0Gzv84yz
 ubycw5gUJAGAmWxK3UTYnZWwoSvJgpxdXdgBgMPT4uXO470+TEwevjoFvmtWQ3yieNIMAallx
 h0wp8ZFq/wk/rLFrEgTmZ7fkLCxoq4mF3glW6CkD12rqedXzJayG1/t8AwEoTKIUNScN5cEZp
 hT+RuwJ1tXg/fIpqcUvH/Gp4AjY8uKX7eODeWjeGrB3FhkwEM3FwyK8BBxRd0vk1qU1uCxJU9
 L4SfM0f8/1dFcJisAO0PpGOGNjFXvVApSXBwx9ccMBu3yrrn4R1ZzniKd0pXy1bUrQltC37cc
 YlPpEymLXCCxAlWnxhc7aL3+f0gi/h6OZS/WYxoCTagTigbttFUFptm2u0kXAU6RbHV/vtfzn
 dna1FXveXCho0jeLxrzkQDTBilDYBYRI0lxtH2yeAPgjciDUf3PdLXbwyJmQdYpJrGabXwV1w
 tsD1qaVI+Ibe+rp/TPKW7I3Z2d2rOblWJRDY8jymvS6c1DPLC0kKnz1pomMTC4ZfB7VyXG7FH
 C+IP17oVrukFZ9VSY+q4q/Il7xKVaP5+4/H4movOtHAPtqGFYUPNnUv+bAcjwNrCLR+85R9Wn
 KAsw7s0vUPHfhzSPTruYii4defKyzt7NmoM/SaRkxmdI4ivlO3/uIX7f1R+yssRWcg6hwZTZt
 9tDCpUn6oqI6PWE/P2Ft3i6C1RPRmOFmhVjDTuO+mP9D2JvkbwTeymirkfahXfuPR1cH+yOTq
 YQUJlLkSLCLuyUSPdy+PjklgykzfUqTCLLtUeG4GcGYKym1Xj1dHVyLxXTjelIUx3bx4LtdxE
 DhKe4QML86UGSXV9In/HG7FquIsSCaPdNCsq2Mapk39Uw=

Am 19.03.24 um 06:47 schrieb James Seo:

> On Mon, Mar 18, 2024 at 10:57:31PM +0100, Armin Wolf wrote:
>> Currently, the hp-wmi-sensors driver needs to be loaded manually
>> on supported machines. This however is unnecessary since the WMI
>> id table can be used to support autoloading.
>>
>> However the driver might conflict with the hp-wmi driver since both
>> seem to use the same WMI GUID for registering notify handler.
>>
>> I am thus submitting this patch as an RFC for now.
>>
>> Armin Wolf (1):
>>    hwmon: (hp-wmi-sensors) Add missing MODULE_DEVICE_TABLE()
>>
>>   drivers/hwmon/hp-wmi-sensors.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> --
>> 2.39.2
>>
> Autoloading was deliberately left out for now because of the GUID
> conflict with hp-wmi's WMI notify handler.
>
> HP's GUID reuse across product lines for different types of WMI
> objects with different names and shapes means that with a patch like
> this, many systems that should only load hp-wmi-sensors but not
> hp-wmi will try to autoload both. (Perhaps all of them; I want to say
> that the GUID 5FB7F034-2C63-45e9-BE91-3D44E2C707E4, which is the
> second of the two GUIDs that hp-wmi uses to autoload, exists on every
> HP system I've examined.)
>
> Meanwhile, hp-wmi does various other platform things, and there's so
> much hardware out there that who knows, maybe there are some systems
> that really should load both. I don't think so but I can't rule it
> out.
>
> Unlike hp-wmi-sensors, hp-wmi doesn't survive failure to install its
> notify handler, which sets up a potential race condition depending on
> when hp-wmi and hp-wmi-sensors loads on a given system.
>
> Therefore, I intended to add autoloading at the same time as
> converting hp-wmi-sensors to use the bus-based WMI interface once
> aggregate WMI devices are better supported.
>
> As you mentioned [1], I ran into issues when I tried to do the
> conversion by simply adding the GUID to struct wmi_driver.id_table.
> That resulted in two separate independent instances of hp_wmi_sensors
> being loaded, which isn't what I wanted.

After taking a look at a ACPI table dump of a HP machine, i noticed that
HPBIOS_BIOSEvent has the GUID 2B814318-4BE8-4707-9D84-A190A859B5D0, which is
different than the event GUID used by hp-wmi.

According your comment in hp_wmi_notify(), i assume that some machines have
mixed-up event GUIDs.

I thing it would be best to create a separate WMI driver for the event and
use a notifier chain (see include/linux/notifier.h) to distribute the event data.

In case of event GUID 95F24279-4D7B-4334-9387-ACCDC67EF61C, both hp-wmi and
hp-wmi-sensors can subscribe on this notifier and receive event data without
stepping on each other's toes.

The same can be done for the event GUID 2B814318-4BE8-4707-9D84-A190A859B5D0,
with a separate notifier chain.

This would decouple the event handling from the event data consumers, allowing
both hp-wmi and hp-wmi-sensors to coexist.

I can provide a prototype implementation, but unfortunately i have no HP machine
myself for testing. But i might be able to find one to test my changes.

Thanks,
Armin Wolf

>
> [1] https://lore.kernel.org/linux-hwmon/cd81a7d6-4b81-f074-1f28-6d1b5300b937@gmx.de/
>

