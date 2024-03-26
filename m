Return-Path: <linux-kernel+bounces-119529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E98B88CA49
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720011C373C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EE813D251;
	Tue, 26 Mar 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="scasLxEk"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5213CFB8;
	Tue, 26 Mar 2024 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472290; cv=none; b=OfgTP8wkI9Dhfg7/b0/3QVc+rQW+fVG0AwQyBJh7cAHgTKQOQt2A90UMx+oaGxAtu5ISdXfOGE6u3Bxxefg8mQaAMwZXTUoR1n/tNNFcRG8T6IhH6s/K2TOVmAPTeBXlWgzTIBqag2uioB8gGwCh7FuPz1yZ0UA22Mp+ICOPmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472290; c=relaxed/simple;
	bh=PBbw7sLsDC3HNLZx0go/ln6hEUiHAL9h8ZDX4qqUcZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lk0Ag7ildKMEhNObVPdL7w0yshebsdoT4BUQKgd6UrLo88paMivDn8BMOkhQcD0ccgMXn5Y7vl75nubAi8uY0nFHySYtMbzwYV5e9ZU2CRs2PExCu4BUJEUt/QaKNERVVJ+CCd15DQO1ekz6SKMOWWRF+3LL2Tr67ZVoQ/kgtEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=scasLxEk; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de45f8b.dip0.t-ipconnect.de [93.228.95.139])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 749CB2FC0064;
	Tue, 26 Mar 2024 17:57:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1711472277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pXIUAuDah8hqasm5kZQQMehVL9KqqXP2c2x80MZfEqI=;
	b=scasLxEks0jzHmYguWmUvj+yDW2Vtss4BodOn0y1aeBcNXgsn3CclsGpx+tjlBNYbn1TPI
	IkQZZDMo2lRQJ06sGaX5R0zca4Q89l95+qQpdKzfwBLXrRYARCkAQ6sSD44NjIjnyJ55nT
	200nEKVG7xaJeN6w3Pl7uxyDDtINN0Q=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <9b5151f9-4d1c-401e-abb5-540097749b76@tuxedocomputers.com>
Date: Tue, 26 Mar 2024 17:57:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: In kernel virtual HID devices (was Future handling of complex RGB
 devices on Linux v3)
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Lee Jones <lee@kernel.org>,
 jikos@kernel.org, linux-kernel@vger.kernel.org,
 Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org,
 Pavel Machek <pavel@ucw.cz>, Gregor Riepl <onitake@gmail.com>
References: <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>
 <a21f6c49-2c05-4496-965c-a7524ed38634@gmail.com>
 <825129ea-d389-4c6c-8a23-39f05572e4b4@redhat.com>
 <adbfdf6c-fb59-4fae-a472-17b04dd8a3f6@tuxedocomputers.com>
 <1fb08a74-62c7-4d0c-ba5d-648e23082dcb@tuxedocomputers.com>
 <aec1d22d-9e59-4dfc-b108-5ba339b0e76a@redhat.com>
 <siebkhaauocqkuox73q2e5p2mbsyc7j4gvpzfvt4c3gvncdpap@oxh5pp4gxpuo>
 <870cca8a-1a1b-4d17-874e-a26c30aca2bf@tuxedocomputers.com>
 <fcf4dd53-f461-4c2e-8fbe-50b50e4e6797@redhat.com>
 <65b24776-ae1a-4290-a1d5-c7637ad0accc@tuxedocomputers.com>
 <vjd5xqgd2gsyz4ubgk6eusuyqdtxpdw6vogc5u537x2a245xcj@m2twppbxea4p>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <vjd5xqgd2gsyz4ubgk6eusuyqdtxpdw6vogc5u537x2a245xcj@m2twppbxea4p>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

Am 26.03.24 um 16:39 schrieb Benjamin Tissoires:
> On Mar 26 2024, Werner Sembach wrote:
>> Hi all,
>>
>> Am 25.03.24 um 19:30 schrieb Hans de Goede:
>>
>> [snip]
>>>>> If the kernel already handles the custom protocol into generic HID, the
>>>>> work for userspace is not too hard because they can deal with a known
>>>>> protocol and can be cross-platform in their implementation.
>>>>>
>>>>> I'm mentioning that cross-platform because SDL used to rely on the
>>>>> input, LEDs, and other Linux peculiarities and eventually fell back on
>>>>> using hidraw only because it's way more easier that way.
>>>>>
>>>>> The other advantage of LampArray is that according to Microsoft's
>>>>> document, new devices are going to support it out of the box, so they'll
>>>>> be supported out of the box directly.
>>>>>
>>>>> Most of the time my stance is "do not add new kernel API, you'll regret
>>>>> it later". So in that case, given that we have a formally approved
>>>>> standard, I would suggest to use it, and consider it your API.
>>>> The only new UAPI would be the use_leds_uapi switch to turn on/off the backwards compatibility.
> I have my reserves with such a kill switch (see below).
>
>>> Actually we don't even need that. Typically there is a single HID
>>> driver handling both keys and the backlight, so userspace cannot
>>> just unbind the HID driver since then the keys stop working.
> I don't think Werner meant unbinding the HID driver, just a toggle to
> enable/disable the basic HID core processing of LampArray.
>
>>> But with a virtual LampArray HID device the only functionality
>>> for an in kernel HID driver would be to export a basic keyboard
>>> backlight control interface for simple non per key backlight control
>>> to integrate nicely with e.g. GNOME's backlight control.
>> Don't forget that in the future there will be devices that natively support
>> LampArray in their firmware, so for them it is the same device.
> Yeah, the generic LampArray support will not be able to differentiate
> "emulated" devices from native ones.
>
>> Regards,
>>
>> Werner
>>
>>> And then when OpenRGB wants to take over it can just unbind the HID
>>> driver from the HID device using existing mechanisms for that.
> Again no, it'll be too unpredicted.
>
>>> Hmm, I wonder if that will not also kill hidraw support though ...
>>> I guess getting hidraw support back might require then also manually
>>> binding the default HID input driver.  Bentiss any input on this?
> To be able to talk over hidraw you need a driver to be bound, yes. But I
> had the impression that LampArray would be supported by default in
> hid-input.c, thus making this hard to remove. Having a separate driver
> will work, but as soon as the LampArray device will also export a
> multitouch touchpad, we are screwed and will have to make a choice
> between LampArray and touch...
>
>>> Background info: as discussed earlier in the thread Werner would like
>>> to have a basic driver registering a /sys/class/leds/foo::kbd_backlight/
>>> device, since those are automatically supported by GNOME (and others)
>>> and will give basic kbd backlight brightness control in the desktop
>>> environment. This could be a simple HID driver for
>>> the hid_allocate_device()-ed virtual HID device, but userspace needs
>>> to be able to move that out of the way when it wants to take over
>>> full control of the per key lighting.
> Do we really need to entirely unregister the led class device? Can't we
> snoop on the commands and get some "mean value"?
>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>> The control flow for the whole system would look something like this:
>>>>
>>>> - System boots
>>>>
>>>>       - Kernel driver initializes keyboard (maybe stops rainbowpuke boot effects, sets brightness to a default value, or initializes a solid color)
>>>>
>>>>       - systemd-backlight restores last keyboard backlight brightness
>>>>
>>>>       - UPower sees sysfs leds entry and exposes it to DBus for DEs to do keyboard brightness handling
>>>>
>>>> - If the user wants more control they (auto-)start OpenRGB
>>>>
>>>>       - OpenRGB disables sysfs leds entry via use_leds_uapi to prevent double control of the same device by UPower
>>>>
>>>>       - OpenRGB directly interacts with hidraw device via LampArray API to give fine granular control of the backlight
>>>>
>>>>       - When OpenRGB closes it should reenable the sysfs leds entry
> That's where your plan falls short: if OpenRGB crashes, or is killed it
> will not reset that bit.
>
> Next question: is OpenRGB supposed to keep the hidraw node opened all
> the time or not?
TBH I didn't look at the OpenRGB code yet and LampArray there is currently only 
planned. I somewhat hope that until the kernel driver is ready someone else 
already picked up implementing LampArray in OpenRGB.
>
> If it has to keep it open, we should be able to come up with a somewhat
> similar hack that we have with hid-steam: when the hidraw node is
> opened, we disable the kernel processing of LampArray. When the node is
> closed, we re-enable it.
>
> But that also means we have to distinguish steam/SDL from OpenRGB...

My first thought here also: What is if something else is reading hidraw devices?

Especially for hidraw devices that are not just LampArray.

>
> I just carefully read the LampArray spec. And it's simpler than what
> I expected. But the thing that caught my attention was that it's
> mentioned that there is no way for the host to query the current
> color/illumination of the LEDs when the mode is set to
> AutonomousMode=false. Which means that the kernel should be able to
> snoop into any commands sent from OpenRGB to the device, compute a mean
> value and update its internal state.
>
> Basically all we need is the "toggle" to put the led class in read-only
> mode while OpenRGB kicks in. Maybe given that we are about to snoop on
> the commands sent, we can detect that there is a LampArray command
> emitted, attach this information to the struct file * in hidraw, and
> then re-enable rw when that user closes the hidraw node.

I think a read-only mode is not part of the current led class UAPI. Also I don't 
want to associate AutonomousMode=true with led class is used. 
AutonomousMode=true could for example mean that it is controlled via keyboard 
shortcuts that are directly handled in the keyboard firmware, aka a case where 
you want neither OpenRGB nor led class make any writes to the keyboard.

Or AutonomousMode=true could mean that on a device that implements both a 
LampArray interface as well as a proprietary legacy interface is currently 
controlled via the proprietary legacy interface (a lot of which are supported by 
OpenRGB).

Regards,

Werner

>
> Cheers,
> Benjamin
>
>>>> - System shutdown
>>>>
>>>>       - Since OpenRGB reenables the sysfs leds entry, systemd-backlight can correctly store a brightness value for next boot
>>>>
>>>> Regards,
>>>>
>>>> Werner
>>>>
>>>>> Side note to self: I really need to resurrect the hidraw revoke series
>>>>> so we could export those hidraw node to userspace with uaccess through
>>>>> logind...
>>>>>
>>>>> Cheers,
>>>>> Benjamin

