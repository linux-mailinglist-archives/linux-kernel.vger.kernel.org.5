Return-Path: <linux-kernel+bounces-117509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9811788AC17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E21729242D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D633412F5A7;
	Mon, 25 Mar 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="AXiJ4fMh"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A1D12C7FF;
	Mon, 25 Mar 2024 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385301; cv=none; b=lfcSMDyFKuyJjh2QByySQ1ZN8maiVLdTx6g7+zq/yuq2GdQlUWZ1yYDaqBzPJjFTEkup5r4Z+44WL/1gDt5FFVMHmwPLisRu1ShCaUj27tQuu6lWqatHv6UkMSJtjJBpHJSfaGrZ5ntWI2UyoI+tHFcp/CkShwjZbYTZ1cXHols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385301; c=relaxed/simple;
	bh=KL58tz4W1eeVJ5Z466IQZHdJakOeRAuqBdvV52pZkTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZj4OHzNJycrmh7Ywot1MbDDHY7Fva3GCpgBJKO7y3fMkivx+kB1MaSSrNOlTXyshNr3+Z7ziNeF/YlgMwnILZ2xdwoXmQm0VKMGKFc0ZesmnsxZWeCz6yKO/WB/5GokfDWf+pBxS+Gqec2JCiCtjqxqJjAof8HRYsyqr3No4dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=AXiJ4fMh; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e6.dip0.t-ipconnect.de [93.228.83.230])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id CD66C2FC005D;
	Mon, 25 Mar 2024 17:48:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1711385289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmqQCwZDH4B3OlLrjyEOlYc7e4QIIPgGHiTR19jxo00=;
	b=AXiJ4fMhH2/ea0CIO4qIrQtdeP2H/daJj0oKmG4209NVgz+UnASp7zDmMsXgijLBATf/wk
	zMv/55JwfpkJ/ekaAFQGma2Dv1FFw0/wflPF8Hfg2oiKa5bHnVmcx5XIdzsnM4Z3MoFXjd
	X5fsB01ECUqGGwk19C1k5IUPTfq04Ug=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <870cca8a-1a1b-4d17-874e-a26c30aca2bf@tuxedocomputers.com>
Date: Mon, 25 Mar 2024 17:48:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: In kernel virtual HID devices (was Future handling of complex RGB
 devices on Linux v3)
Content-Language: en-US
To: Benjamin Tissoires <bentiss@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee@kernel.org>, jikos@kernel.org,
 linux-kernel@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org,
 Pavel Machek <pavel@ucw.cz>, Gregor Riepl <onitake@gmail.com>
References: <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com>
 <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
 <247b5dcd-fda8-45a7-9896-eabc46568281@tuxedocomputers.com>
 <ZdZ2kMASawJ9wdZj@duo.ucw.cz>
 <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>
 <a21f6c49-2c05-4496-965c-a7524ed38634@gmail.com>
 <825129ea-d389-4c6c-8a23-39f05572e4b4@redhat.com>
 <adbfdf6c-fb59-4fae-a472-17b04dd8a3f6@tuxedocomputers.com>
 <1fb08a74-62c7-4d0c-ba5d-648e23082dcb@tuxedocomputers.com>
 <aec1d22d-9e59-4dfc-b108-5ba339b0e76a@redhat.com>
 <siebkhaauocqkuox73q2e5p2mbsyc7j4gvpzfvt4c3gvncdpap@oxh5pp4gxpuo>
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <siebkhaauocqkuox73q2e5p2mbsyc7j4gvpzfvt4c3gvncdpap@oxh5pp4gxpuo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Benjamin,

Am 25.03.24 um 16:56 schrieb Benjamin Tissoires:
> On Mar 25 2024, Hans de Goede wrote:
>> +Cc: Bentiss, Jiri
>>
>> Hi Werner,
>>
>> On 3/20/24 12:16 PM, Werner Sembach wrote:
>>> Hi Hans and the others,
>>>
>>> Am 22.02.24 um 14:14 schrieb Werner Sembach:
>>>> Hi,
>>>>
>>>> Thanks everyone for the exhaustive feedback. And at least this thread is a good comprehesive reference for the future ^^.
>>>>
>>>> To recap the hopefully final UAPI for complex RGB lighting devices:
>>>>
>>>> - By default there is a singular /sys/class/leds/* entry that treats the device as if it was a single zone RGB keyboard backlight with no special effects.
>>>>
>>>> - There is an accompanying misc device with the sysfs attributes "name", "device_type",  "firmware_version_string", "serial_number" for device identification and "use_leds_uapi" that defaults to 1.
>>>>
>>>>      - If set to 0 the /sys/class/leds/* entry disappears. The driver should keep the last state the backlight was in active if possible.
>>>>
>>>>      - If set 1 it appears again. The driver should bring it back to a static 1 zone setting while avoiding flicker if possible.
>>>>
>>>> - If the device is not controllable by for example hidraw, the misc device might also implement additional ioctls or sysfs attributes to allow a more complex low level control for the keyboard backlight. This is will be a highly vendor specific UAPI.
>>> So in the OpenRGB issue thread https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/dynamic-lighting-devices aka HID LampArray was mentioned. I did dismiss it because I thought that is only relevant for firmware, but I now stumbled upon the Virtual HID Framework (VHF) https://learn.microsoft.com/en-us/windows-hardware/drivers/hid/virtual-hid-framework--vhf- and now I wonder if an equivalent exists for Linux? A quick search did not yield any results for me.
>> Oh, interesting. I did not know about the HID LampArray API.
>>
>> About your question about virtual HID devices, there is uHID,
>> but as the name suggests this allows userspace to emulate a HID
>> device.
>>
>> In your case you want to do the emulation in kernel so that you
>> can translate the proprietary WMI calls to something HID LampArray
>> compatible.
>>
>> I guess you could do this by defining your own HID transport driver,
>> like how e.g. the i2c-hid code defines 1 i2c-hid parent + 1 HID
>> "client" for each device which talks HID over i2c in the machine.
>>
>> Bentiss, Jiri, do you have any input on this. Would something like
>> that be acceptable to you (just based on the concept at least) ?
> I just read the thread, and I think I now understand a little bit what
> this request is :)
>
> IMO working with the HID LampArray is the way forward. So I would
> suggest to convert any non-HID RGB "LED display" that we are talking
> about as a HID LampArray device through `hid_allocate_device()` in the
> kernel. Basically what you are suggesting Hans. It's just that you don't
> need a formal transport layer, just a child device that happens to be
> HID.
>
> The next question IMO is: do we want the kernel to handle such
> machinery? Wouldn't it be simpler to just export the HID device and let
> userspace talk to it through hidraw, like what OpenRGB does?

That's already part of my plan: The kernels main goal is to give devices a 
LampArray interface that don't have one already (e.g. because they are no HID 
devices to begin with).

The actual handling of LampArray will happen in userspace.

Exception is that maybe it could be useful to implement a small subset of 
LampArray in a generic leds-subsystem driver for backwards compatibility to 
userspace applications that only implement that (e.g. UPower). It would treat 
the whole keyboard as a single led.

>
> If the kernel already handles the custom protocol into generic HID, the
> work for userspace is not too hard because they can deal with a known
> protocol and can be cross-platform in their implementation.
>
> I'm mentioning that cross-platform because SDL used to rely on the
> input, LEDs, and other Linux peculiarities and eventually fell back on
> using hidraw only because it's way more easier that way.
>
> The other advantage of LampArray is that according to Microsoft's
> document, new devices are going to support it out of the box, so they'll
> be supported out of the box directly.
>
> Most of the time my stance is "do not add new kernel API, you'll regret
> it later". So in that case, given that we have a formally approved
> standard, I would suggest to use it, and consider it your API.

The only new UAPI would be the use_leds_uapi switch to turn on/off the backwards 
compatibility.

The control flow for the whole system would look something like this:

- System boots

     - Kernel driver initializes keyboard (maybe stops rainbowpuke boot effects, 
sets brightness to a default value, or initializes a solid color)

     - systemd-backlight restores last keyboard backlight brightness

     - UPower sees sysfs leds entry and exposes it to DBus for DEs to do 
keyboard brightness handling

- If the user wants more control they (auto-)start OpenRGB

     - OpenRGB disables sysfs leds entry via use_leds_uapi to prevent double 
control of the same device by UPower

     - OpenRGB directly interacts with hidraw device via LampArray API to give 
fine granular control of the backlight

     - When OpenRGB closes it should reenable the sysfs leds entry

- System shutdown

     - Since OpenRGB reenables the sysfs leds entry, systemd-backlight can 
correctly store a brightness value for next boot

Regards,

Werner

>
> Side note to self: I really need to resurrect the hidraw revoke series
> so we could export those hidraw node to userspace with uaccess through
> logind...
>
> Cheers,
> Benjamin

