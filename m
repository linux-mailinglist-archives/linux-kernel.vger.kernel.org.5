Return-Path: <linux-kernel+bounces-76573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8F785F956
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1943F1C232C9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F037D1350D6;
	Thu, 22 Feb 2024 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="jT4sZDQj"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE4A13341F;
	Thu, 22 Feb 2024 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607688; cv=none; b=gqBUNhX09X6bKbx08oY/aok34g432oT/XZeSAj0XTkk6PCytE19H/UdM9ZztCekUaUZ+Jnh80knTAZZFo/oruzkkW9IHIwAuu3mwv2D6/9xTocDcpZ82GRBw5QsEzjGwNpuv68DydPLAed1Y4p1evkUFdv77+KdJXgOgdZXMDBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607688; c=relaxed/simple;
	bh=7PbEL0xaSE2/nfsjSGjetHz7DwXTgQaYwcMTBucrhss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVW93HEABAd23U4/x0jnmAilAGx44XejLN4w5zJbEknnnZQEmGlqhrrKe+082pYV0xLzw6pEacGDy3KQOOFtQMMJF4Qh5sfYUJDcT0DKSiHTd0qWtzupiqNvXIO/wa5c07QuA0sjYoLFNTDXelAcAQBcUfZnuIBQqb0XAmKO8pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=jT4sZDQj; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (pd9e59c8a.dip0.t-ipconnect.de [217.229.156.138])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 100502FC0048;
	Thu, 22 Feb 2024 14:14:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1708607676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kEwJ6CVKjeTV/UU4ZV2snp8TyY3Zz/wXMxCmc/s4Y8=;
	b=jT4sZDQjgVqsUv6H+vH93l0lNim+8BdierhwIrRCoqBC1LqB5KliVgLTF/Q6wzbltOPbK1
	+Z84A6myGtJxl/WtgyOAD8fxeo6mhJoRjqGBpylu1ByBVDG+Z45lIBmKjLlt8NGof+RFCK
	qZhf597EmPiTKb7Uf2I38W6RbylvXg4=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <adbfdf6c-fb59-4fae-a472-17b04dd8a3f6@tuxedocomputers.com>
Date: Thu, 22 Feb 2024 14:14:35 +0100
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
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <825129ea-d389-4c6c-8a23-39f05572e4b4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Thanks everyone for the exhaustive feedback. And at least this thread is a good 
comprehesive reference for the future ^^.

To recap the hopefully final UAPI for complex RGB lighting devices:

- By default there is a singular /sys/class/leds/* entry that treats the device 
as if it was a single zone RGB keyboard backlight with no special effects.

- There is an accompanying misc device with the sysfs attributes "name", 
"device_type",  "firmware_version_string", "serial_number" for device 
identification and "use_leds_uapi" that defaults to 1.

     - If set to 0 the /sys/class/leds/* entry disappears. The driver should 
keep the last state the backlight was in active if possible.

     - If set 1 it appears again. The driver should bring it back to a static 1 
zone setting while avoiding flicker if possible.

- If the device is not controllable by for example hidraw, the misc device might 
also implement additional ioctls or sysfs attributes to allow a more complex low 
level control for the keyboard backlight. This is will be a highly vendor 
specific UAPI.

     - The actual logic interacting with this low level UAPI is implemented by a 
userspace driver

Implementation wise: For the creation of the misc device with the use_leds_uapi 
switch a helper function/macro might be useful? Wonder if it should go into 
leds.h, led-class-multicolor.h, or a new header file?

- Out of my head it would look something like this:

led_classdev_add_optional_misc_control(
     struct led_classdev *led_cdev,
     char* name,
     char* device_type,
     char* firmware_version_string,
     char* serial_number,
     void (*deregister_led)(struct led_classdev *led_cdev),
     void (*reregister_led)(struct led_classdev *led_cdev))

Let me know your thoughts and hopefully I can start implementing it soon for one 
of our devices.

Kind regards,

Werner Sembach


