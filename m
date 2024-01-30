Return-Path: <linux-kernel+bounces-45167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D917C842C67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797331F21B82
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED9A7AE4C;
	Tue, 30 Jan 2024 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="eblZUCnp"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5B7AE44;
	Tue, 30 Jan 2024 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641727; cv=none; b=QIzmUzAGiM5GOKXI/R1zj8RfXASfsWzAAKoFKPVMyfgqgKDaPeae8o4EjXiBpAEGlFNNQdynC1mQ0NwRGKG7BQyfkIyUe1dTolb/P7TAne9KQqoTZjbKREBK3cVKJIYavokMnXPvZ9qKb37GPoIN0AlV7sqpk5PIN9EAuhO9SaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641727; c=relaxed/simple;
	bh=oUIdLXEYaWSKNLi2jOEFBtoL4WM7Kh/0wZWmDFhoNLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiPVS9bXCqI5zyBGuIO9S7MPToHuko/r84+T/ztRLQutBopSD+3cQqdcaKY36yx3bwhD1UM5GX+fjLt/9CYLDTfqKBkP9CpaDeiVZODzg0UW9BbKila5oGD9H0wgqQbbyxU5v3VxMghvAZYfV5rfkJb1HatEwUmfmOBFV95g94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=eblZUCnp; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 23BFC2FC004A;
	Tue, 30 Jan 2024 20:08:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1706641722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LbhUeHVixZ6fHRGYU1VVwvcn9Vo4T6Wzvv+6eidxVh0=;
	b=eblZUCnpERjN7epF9d579T4ea980hdkcfbiNS7lWSKcEn66+MJOtJ9uQNaJZvn5qfRt4X9
	1Z6fJamdKuUtzJ7grIAplzCNz/t9/k6nP5gEunaN544POJRg62gA93IRcMfyAWqWRrCyKx
	H+dD1Gh4Ul1iX0LWZj4tlRq4K2g+z9Y=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <b70b2ea8-abfd-4d41-b336-3e34e5bdb8c6@tuxedocomputers.com>
Date: Tue, 30 Jan 2024 20:08:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
Content-Language: en-US
To: Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, jikos@kernel.org,
 Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org
References: <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
 <ZSmg4tqXiYiX18K/@duo.ucw.cz>
 <CANiq72mfP+dOLFR352O0UNVF8m8yTi_VmOY1zzQdTBjPWCRowg@mail.gmail.com>
 <87sf61bm8t.fsf@intel.com> <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz>
 <f4137e34-c7fb-4f21-bc93-1496cbf61fdf@tuxedocomputers.com>
 <8096a042-83bd-4b9f-b633-79e86995c9b8@redhat.com>
 <f416fbca-589b-4f6a-aad6-323b66398273@tuxedocomputers.com>
 <4222268b-ff44-4b7d-bf11-e350594bbe24@redhat.com>
 <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>
 <ZaljwLe7P+dXHEHb@duo.ucw.cz>
 <6bbfdd62-e663-4a45-82f4-445069a8d690@redhat.com>
 <0cdb78b1-7763-4bb6-9582-d70577781e61@tuxedocomputers.com>
 <7228f2c6-fbdd-4e19-b703-103b8535d77d@redhat.com>
 <730bead8-6e1d-4d21-90d2-4ee73155887a@tuxedocomputers.com>
 <952409e1-2f0e-4d7a-a7a9-3b78f2eafec7@redhat.com>
 <9851a06d-956e-4b57-be63-e10ff1fce8b4@tuxedocomputers.com>
 <1bc6d6f0-a13d-4148-80cb-9c13dec7ed32@redhat.com>
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <1bc6d6f0-a13d-4148-80cb-9c13dec7ed32@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Am 30.01.24 um 19:35 schrieb Hans de Goede:
> Hi,
>
> On 1/30/24 19:09, Werner Sembach wrote:
>> Hi Hans,
>>
>> resend because Thunderbird htmlified the mail :/
> I use thunderbird too. If you right click on the server name
> and then go to "Settings" -> "Composition & Addressing"
> and then uncheck "Compose messages in HTML format"
> I think that should do the trick.
Can't set this globally or other people will complain that my replies delete 
company logos in signatures xD. But usually the auto detection of Thunderbird works.
>
>> Am 30.01.24 um 18:10 schrieb Hans de Goede:
>>> Hi Werner,
>>>
>>> On 1/30/24 12:12, Werner Sembach wrote:
>>>> Hi Hans,
>>>>
>>>> Am 29.01.24 um 14:24 schrieb Hans de Goede:
>> <snip>
>>>> I think that are mostly external keyboards, so in theory a possible cut could also between built-in and external devices.
>>> IMHO it would be better to limit /dev/rgbledstring use to only
>>> cases where direct userspace control is not possible and thus
>>> have the cut be based on whether direct userspace control
>>> (e.g. /dev/hidraw access) is possible or not.
>> Ack
>>
>> <snip>
>>
>>>> So also no basic driver? Or still the concept from before with a basic 1 zone only driver via leds subsystem to have something working, but it is unregistered by userspace, if open rgb wants to take over for fine granular support?
>>> Ah good point, no I think that a basic driver just for kbd backlight
>>> brightness support which works with the standard desktop environment
>>> controls for this makes sense.
>>>
>>> Combined with some mechanism for e.g. openrgb to fully take over
>>> control as discussed. It is probably a good idea to file a separate
>>> issue with the openrgb project to discuss the takeover API.
>> I think the OpenRGB maintainers are pretty flexible at that point, after all it's similar to enable commands a lot of rgb devices need anyway. I would include it in a full api proposal.
> Ack.
>
>> On this note: Any particular reason you suggested an ioctl interface instead of a sysfs one? (Open question as, for example, I have no idea what performance implications both have)
> sysfs APIs typically have a one file per setting approach,
> so for effects with speed and multiple-color settings you
> would need a whole bunch of different files and then you
> would either need to immediately apply every setting,
> needing multiple writes to the hw for a single effect
> update, or have some sort of "commit" sysfs attribute.
>
> With ioctls you can simply provide all the settings
> in one call, which is why I suggested using ioctls.

Ack

If the static mode update is fast enough to have userspace controlled 
animations, OpenRGB is calling that direct mode. Is it feasible to send 30 or 
more ioctls per second for such an direct mode? Or should this spawn a special 
purpose sysfs file that is kept open by userspace to continuously update the 
keyboard?

>
> Regards,
>
> Hans
>
>
>
Regards,

Werner


