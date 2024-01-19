Return-Path: <linux-kernel+bounces-31542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D77832FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE361F2523A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADCE56755;
	Fri, 19 Jan 2024 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="W48PXxH9"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A791524B3;
	Fri, 19 Jan 2024 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695783; cv=none; b=QgWPCgHZNqV9U7+W+w/HrH2+rv/+jgXwVt1nNPZ378gFL1seEePp0OzPJD8N3GJXleT+TRVMqLXP4Jp9XHUIjqo7jlRbwewYAhSxJmtmlCcDXIISYvwMaUe4q6XYUxfGx0FNiDA3feSkj8Cck9QvM43MnyjgyQSzgxO35iQ7lyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695783; c=relaxed/simple;
	bh=3F4LzeN8gEbum1S++tjiVyy2gjiMWL3KdUxDscOrH20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leTlzbVX2N+XYTilA1dllDsMLLpAO07/jvxpLkXaGBPiV60V4oiyjkHWeaNSKMZfUh5yGroTVej6xaQti679oMhosW9HPIGN0uC0KbZK3bOwHeTqoaBAW4ff+lJ5efgn47Xk8l1af73rkN72Y04hTa4HZIeRBkqbcHyilPYwEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=W48PXxH9; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 64B492FC0077;
	Fri, 19 Jan 2024 21:22:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1705695777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3KB8fN1v11h06dDAChI3rThEEmVbSHsahcI++DtPIU=;
	b=W48PXxH98jl59z8cPo3sKMW1zTP7z+54nd2fx/eDRv/x17PK0rrASStRSulK62Zvx8oC1k
	c0Lt2w6WRRXqmefYboiY4vSa7hC4gNQ4ZzGNCrioC1rGuZ8TX23lpo2GSMr1K9e4iln8Mr
	a8PeXyISJub1qytbPrp2YCPSa6SpHLM=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <36973f9d-bf67-417d-998c-ce24c38322c3@tuxedocomputers.com>
Date: Fri, 19 Jan 2024 21:22:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
Content-Language: en-US
To: Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, jikos@kernel.org,
 Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org
References: <CANiq72mfP+dOLFR352O0UNVF8m8yTi_VmOY1zzQdTBjPWCRowg@mail.gmail.com>
 <87sf61bm8t.fsf@intel.com> <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz>
 <f4137e34-c7fb-4f21-bc93-1496cbf61fdf@tuxedocomputers.com>
 <8096a042-83bd-4b9f-b633-79e86995c9b8@redhat.com>
 <f416fbca-589b-4f6a-aad6-323b66398273@tuxedocomputers.com>
 <4222268b-ff44-4b7d-bf11-e350594bbe24@redhat.com>
 <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>
 <ZaljwLe7P+dXHEHb@duo.ucw.cz>
 <6bbfdd62-e663-4a45-82f4-445069a8d690@redhat.com>
 <ZarYSkzISyS+wuYR@duo.ucw.cz>
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ZarYSkzISyS+wuYR@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 19.01.24 um 21:15 schrieb Pavel Machek:
> Hi!
>
>>>> 2. Implement per-key keyboards as auxdisplay
>>>>
>>>>      - Pro:
>>>>
>>>>          - Already has a concept for led positions
>>>>
>>>>          - Is conceptually closer to "multiple leds forming a singular entity"
>>>>
>>>>      - Con:
>>>>
>>>>          - No preexisting UPower support
>>>>
>>>>          - No concept for special hardware lightning modes
>>>>
>>>>          - No support for arbitrary led outlines yet (e.g. ISO style enter-key)
>>> Please do this one.
>> Ok, so based on the discussion so far and Pavel's feedback lets try to
>> design a custom userspace API for this. I do not believe that auxdisplay
>> is a good fit because:
> Ok, so lets call this a "display". These days, framebuffers and drm
> handles displays. My proposal is to use similar API as other displays.
>
>> So my proposal would be an ioctl interface (ioctl only no r/w)
>> using /dev/rgbkbd0 /dev/rgbkdb1, etc. registered as a misc chardev.
>>
>> For per key controllable rgb LEDs we need to discuss a coordinate
>> system. I propose using a fixed size of 16 rows of 64 keys,
>> so 64x16 in standard WxH notation.
>>
>> And then storing RGB in separate bytes, so userspace will then
>> always send a buffer of 192 bytes per line (64x3) x 14 rows
>> = 3072 bytes. With the kernel driver ignoring parts of
>> the buffer where there are no actual keys.
> That's really really weird interface. If you are doing RGB888 64x14,
> lets make it a ... display? :-).
>
> ioctl always sending 3072 bytes is really a hack.
>
> Small displays exist and are quite common, surely we'd handle this as
> a display:
> https://pajenicko.cz/displeje/graficky-oled-displej-0-66-64x48-i2c-bily-wemos-d1-mini
> It is 64x48.
>
> And then there's this:
> https://pajenicko.cz/displeje/maticovy-8x8-led-displej-s-radicem-max7219
> and this:
> https://pajenicko.cz/displeje/maticovy-8x32-led-displej-s-radicem-max7219
>
> One of them is 8x8.
>
> Surely those should be displays, too?

But what about a light bar with, lets say, 3 zones. Is that a 3x1 display?

And what about a mouse having lit mousebuttons and a single led light bar at the 
wrist: a 2x2 display, but one is thin but long and one is not used?

Regards,

Werner

>
> And yes, we'd probably want some extra ioctls on top, for example to
> map from input device to this and back, and maybe for various effects,
> too. And yes, I realize that display with holes in it and with some
> pixels bigger than others is weird, but it still looks like a display
> to me. (And phones have high-res displays with rounded corners and
> holes in them, so... we'll need to deal with weird displays anyway).
>
> Best regards,
> 								Pavel

