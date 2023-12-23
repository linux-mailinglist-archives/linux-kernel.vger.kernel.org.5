Return-Path: <linux-kernel+bounces-10421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A3581D439
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EBB21C20F41
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE17FC1E;
	Sat, 23 Dec 2023 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAeInkuj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A054FBF7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703338814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3Crgm+xQZj4yib2cvvCof3wHYCimcJoYyUl6ZxCn24=;
	b=LAeInkujENofEAF+vpMmLTktKzhzKHa6dW73+HvjyJZaAc0v5w76t4UczuQ28UVP2lXwSm
	8SsvzjowSufY5he7Sf3Z2MCN12LY8verwxHWnYTdNZdAc5kyvzfWnvl5Kl4rqQnDPQTQbA
	26FBuOtdDZJEKqLSRjV291xkWuIleus=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-F6TcNV6WO1iy5R_se_imXw-1; Sat, 23 Dec 2023 08:40:12 -0500
X-MC-Unique: F6TcNV6WO1iy5R_se_imXw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c58a71b7cso21673625e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 05:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703338811; x=1703943611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3Crgm+xQZj4yib2cvvCof3wHYCimcJoYyUl6ZxCn24=;
        b=bzVQSDdf/mTMXyI3Gwkkwi7wgO0nDrCXhNfzg+6hLMsXy33oFVyoSCLwiLVz/+hGFX
         sci/rx4unH/H5rH9P9wnOnZWdnXhb27FCQ2ej/OdJ5IhjoopOT2+bbo6KY+MMuzG6k4i
         KPv6Sa1ROVOP8/NWOJwZ2aOW1bLYPT6NUaIqpb3fSNOBhpMTohKCMy52Z7mNWFf1eOAH
         gHhlEBFs7Qc1xZ29nKuwRw0sUqrEOhlJ8mo1vqMDFXNK6a0N2oY6Vz3xRalBLpg7aNkK
         S5Dn7kzjtjnc2X+Zw6GcQ8+QDgatG5mZFzovh/O7Yckq8cRbxzpJWq+Fs372kGfAJD63
         YyqQ==
X-Gm-Message-State: AOJu0YzKAVSKj/ux8eKVnTzp0f22xKGCemSM+3yODvxeNphVZAy3fOkp
	WPF+2eMte7wY5RgqgNS2Gryrv7kblc9OUx8H37pogRU5O9r0z8j47kjSDd5G4kRvWzlxMw3man0
	FSAmEnrLnOIp7ewws7FURUWc3gV5lok1k
X-Received: by 2002:a05:600c:5187:b0:40d:35a7:aa9 with SMTP id fa7-20020a05600c518700b0040d35a70aa9mr1715413wmb.57.1703338811622;
        Sat, 23 Dec 2023 05:40:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+3xb75CFZPMPt31kEvT7MU7PU4VcwLRIpItNCM8tc94PdHsluZXZgweWWeszrMsODogzi4g==
X-Received: by 2002:a05:600c:5187:b0:40d:35a7:aa9 with SMTP id fa7-20020a05600c518700b0040d35a70aa9mr1715401wmb.57.1703338811214;
        Sat, 23 Dec 2023 05:40:11 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709066c8400b00a1f7ab65d3fsm3058182ejr.131.2023.12.23.05.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Dec 2023 05:40:10 -0800 (PST)
Message-ID: <79134dc1-c71c-4f9e-b721-52385df62cf5@redhat.com>
Date: Sat, 23 Dec 2023 14:40:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ideas for a generic solution to support accelerometer lis3lv02d
 in Dell laptops/notebooks?
Content-Language: en-US, nl
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Jean Delvare <jdelvare@suse.com>,
 Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa@kernel.org>,
 linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Marius Hoch
 <mail@mariushoch.de>, Mario Limonciello <mario.limonciello@amd.com>,
 Dell.Client.Kernel@dell.com, Greg KH <gregkh@linuxfoundation.org>
References: <4820e280-9ca4-4d97-9d21-059626161bfc@molgen.mpg.de>
 <a1128471-bbff-4124-a7e5-44de4b1730b7@redhat.com>
 <20231223125350.xqggx3nyzyjjmnut@pali>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231223125350.xqggx3nyzyjjmnut@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 12/23/23 13:53, Pali Rohár wrote:
> On Saturday 23 December 2023 13:45:32 Hans de Goede wrote:
>> 2. Add a "probe_i2c_address" bool module option and when this
>>    is set try to read the WHO_AM_I register, see
>>    drivers/misc/lis3lv02d/lis3lv02d.c
>>    and if this succeeds and gives a known model id then
>>    continue with the found i2c_address. This should first
>>    try address 0x29 which seems to be the most common and
>>    then try 0x18 and then give up.
> 
> This is the main problem of the whole email thread. How to figure out
> the correct smbus device address.

Ack.

> And we really must not poke random address during kernel boot time.
> I think in the past was there enough problems linux kernel broke some HW
> or made system unbootable just because it tried to read something from
> some random undocumented address.
> 
> Please do not try random unverified address on all machines.

Right, that is why this sits behind a module option. Also note
that the 0x29 / 0x18 addresses are typically used by some
sensor ic, which are typically safe to probe.

> smbus is not really bus which provides discovering and identifying
> devices on the bus.

I know I have worked on the lm_sensors project and the
sensors-detect script in the past. Generally speaking
though i2c probing is not that dangerous. But one can
get unlucky ...

We should probably first do 2 single byte i2c-reads
(not smbus byte reads but plain i2c reads) if there
is a i2c device there with the standard smbus register
model where there is a 8 bit register address pointer
then reading 2 times in a row will read 2 different
registers (the internal register address pointer will
increment) so we should get 2 different values.

If we get the same value twice then whatever is
present on address 0x29 or 0x18 does not follow
the standard smbus register addressing and we should
refrain from doing a smbus-byte-read, which first
sends the register-address to read so involves
an actual i2c-*write*.

The combination of determining that normal smbus
register addressing is used + only doing reads
should make probing pretty safe. And the probing
will only happen when the module option is set
in the first place.

Regards,

Hans





