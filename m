Return-Path: <linux-kernel+bounces-117531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5414D88AC42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776091C3EBBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849DB6F085;
	Mon, 25 Mar 2024 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="A0GEY1B9"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8366BFDD;
	Mon, 25 Mar 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386068; cv=none; b=CHOmwXZvXt54HrC7mNk3cc4FM0r413kD+Ei2i3qq00ctG3Dl3tuo7DKImVksWv5W4pJSSKdoCzHRfAbIvoc61GmSW4zqrROHN9oPeUvnoYqA7+TnX/lUa4PIt42Rf+HFxlPOi6TwUW1c5HhJ6alVBGaWcBDV4Tu7UR72P1xi8sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386068; c=relaxed/simple;
	bh=so55drc7BZofIQPnratz0hw9pejb7zJvlJgfkTj6+v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/64QoI4HAT0k8RfQaPrZq810ZKWhko4qsc6y9hpQyKTHYHC0U2nHc75hAPsCpJDWXpOwjlGumXoNcvyo2JsS1BKRdBeOXxUR6X0XFYhAyJmGaYyW58ke8PTnLOCjYxNSu7Trs37nQAgeUGT9i5G0aAnBmPC5nL/6r82AEV0NO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=A0GEY1B9; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e6.dip0.t-ipconnect.de [93.228.83.230])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id AD8392FC005D;
	Mon, 25 Mar 2024 18:01:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1711386062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ATs5/OdHRjCY1h26TAv0lmEMtG2XpuU45F9t/lj+nys=;
	b=A0GEY1B9FnamydoebSttg0wlw+tkjTkGAiYySc6x/bPZJsR+vPSWJgPzqJhKk5Y18dsAd5
	c3UQOE9aW2cGrY8llgV1BKDXZMtWtL+lmRcfJEmjHQL+yXBA98ptQObBA6jUbDYpAQvsyF
	ak1yM1tNx5Sa8TJrBEn5+6sjPYP93mA=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <4df21921-a32c-41ad-b366-e75a5d4de5de@tuxedocomputers.com>
Date: Mon, 25 Mar 2024 18:01:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Future handling of complex RGB devices on Linux v3
Content-Language: en-US
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee@kernel.org>, jikos@kernel.org,
 linux-kernel@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org,
 Pavel Machek <pavel@ucw.cz>, Gregor Riepl <onitake@gmail.com>
References: <0cdb78b1-7763-4bb6-9582-d70577781e61@tuxedocomputers.com>
 <7228f2c6-fbdd-4e19-b703-103b8535d77d@redhat.com>
 <730bead8-6e1d-4d21-90d2-4ee73155887a@tuxedocomputers.com>
 <952409e1-2f0e-4d7a-a7a9-3b78f2eafec7@redhat.com>
 <9851a06d-956e-4b57-be63-e10ff1fce8b4@tuxedocomputers.com>
 <1bc6d6f0-a13d-4148-80cb-9c13dec7ed32@redhat.com>
 <b70b2ea8-abfd-4d41-b336-3e34e5bdb8c6@tuxedocomputers.com>
 <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com>
 <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
 <247b5dcd-fda8-45a7-9896-eabc46568281@tuxedocomputers.com>
 <ZdZ2kMASawJ9wdZj@duo.ucw.cz>
 <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>
 <a21f6c49-2c05-4496-965c-a7524ed38634@gmail.com>
 <825129ea-d389-4c6c-8a23-39f05572e4b4@redhat.com>
 <adbfdf6c-fb59-4fae-a472-17b04dd8a3f6@tuxedocomputers.com>
 <281f9b71-a565-4ff3-8343-ca36d604584d@redhat.com>
 <93d70ac3-bb18-4732-abb4-134750a5b50c@tuxedocomputers.com>
 <8264bce7-eda0-4e1c-8c72-a6a78ee3a7bd@redhat.com>
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <8264bce7-eda0-4e1c-8c72-a6a78ee3a7bd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Hans,

Am 25.03.24 um 15:18 schrieb Hans de Goede:
> Hi Werner,
>
> On 3/19/24 4:18 PM, Werner Sembach wrote:
>> Hi Hans,
>>
>> Am 18.03.24 um 12:11 schrieb Hans de Goede:
>>> Hi Werner,
>>>
>>> Sorry for the late reply.
>> np
>>> On 2/22/24 2:14 PM, Werner Sembach wrote:
>>>> Hi,
>>>>
>>>> Thanks everyone for the exhaustive feedback. And at least this thread is a good comprehesive reference for the future ^^.
>>>>
>>>> To recap the hopefully final UAPI for complex RGB lighting devices:
>>>>
>>>> - By default there is a singular /sys/class/leds/* entry that treats the device as if it was a single zone RGB keyboard backlight with no special effects.
>>> Ack this sounds good.
>>>
>>>> - There is an accompanying misc device with the sysfs attributes "name", "device_type",  "firmware_version_string", "serial_number" for device identification and "use_leds_uapi" that defaults to 1.
>>> You don't need a char misc device here, you can just make this sysfs attributes on the LED class device's parent device by using device_driver.dev_groups. Please don't use a char misc device just to attach sysfs attributes to it.
>>>
>>> Also I'm a bit unsure about most of these attributes, "use_leds_uapi" was discussed before
>>> and makes sense. But at least for HID devices the rest of this info is already available
>>> in sysfs attributes on the HID devices (things like vendor and product id) and since the
>>> userspace code needs per device code to drive the kbd anyways it can also have device
>>> specific code to retrieve all this info, so the other sysfs attributes just feel like
>>> duplicating information. Also there already are a ton of existing hidraw userspace rgbkbd
>>> drivers which already get this info from other places.
>> The parent device can be a hid device, a wmi device, a platform device etc. so I thought it would be nice to have some unified way for identification.
> I think that some shared ioctl for identifying devices which need a misc-device
> makes sense. But for existing hidraw supported keyboards there already is existing
> userspace support, which already retreives this in a hidraw specific manner.
>
> And I doubt that the existing userspace projects will add support for a new method
> which is only available on new kernels, while they will also need to keep the old
> method around to keep things working with older kernels.
>
> So at least for the hidraw case I see little value in exporting the same info
> in another way.

Ack on the no new device, but since we are adding use_leds_uapi to the parent 
device anyway, having the identification on non-HID devices wie sysfs entries 
would help even more in not creating a new device just to handle an ioctl.

Just to note here. When we go the LampArray route, everything is a HID device 
anyway.

>
>
>>>>       - If set to 0 the /sys/class/leds/* entry disappears. The driver should keep the last state the backlight was in active if possible.
>>>>
>>>>       - If set 1 it appears again. The driver should bring it back to a static 1 zone setting while avoiding flicker if possible.
>>> Ack, if this finds it way into some documentation (which it should) please make it
>>> clear that this is about the "use_leds_uapi" sysfs attribute.
>> Ack
>>>> - If the device is not controllable by for example hidraw, the misc device might also implement additional ioctls or sysfs attributes to allow a more complex low level control for the keyboard backlight. This is will be a highly vendor specific UAPI.
>>> IMHO this is the only case where actually using a misc device makes sense, so that
>>> you have a chardev to do the ioctls on. misc-device-s should really only be used
>>> when you need a chardev under /dev . Since you don't need the chardev for the e.g.
>>> hidraw case you should not use a miscdev there IMHO.
>> My train of thought was that it would be nice to have the use_leds_uapi at a somewhat unified location in sysfs. The parent device can be of any kind, like I mentioned above, and while for deactivating it can easily be found via /sys/class/leds/*/device/. For reactivating, the leds entry doesn't exist.
> That is an interesting point. But I would expect any process/daemon which wants to
> reactivate the in kernel LED class support to be the same process as which
> deactivated it. So that daemon can simply canonicalize the /sys/class/leds/*/device
> symlink or canonicalize the entire /sys/class/leds/*/device/use_leds_uapi path
> and store the canonicalized version for when the daemon wants to reactivate things.

Ack

Regards,

Werner

>
> So I still think that having the miscdevice just for enumeration and
> use_leds_uapi purposes is overkill.
>
> Regards,
>
> Hans
>
>

