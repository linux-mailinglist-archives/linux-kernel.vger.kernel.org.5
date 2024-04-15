Return-Path: <linux-kernel+bounces-144911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD28A4C86
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19A51F23919
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FDF5A108;
	Mon, 15 Apr 2024 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="MmchsshG"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D8158AD1;
	Mon, 15 Apr 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176915; cv=none; b=Y5KXWC0dBnWYCyrBd4wLlrn3Vgk3BdrQfaNRdyGP8/ljDu0AT17zZU72bHeKqOsnpAyETXQ7gprUH0HdRkWADX7dvCHyEoH6PdpwkyLTuRfAc27omL6HdPWXIJhjwcfSzNCVtkDj9jVskrWJ+oGRtK9elevSYAkdvd0meH2rqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176915; c=relaxed/simple;
	bh=9qcyX04KyI8G4kbI9fh1FRESLOWNTgk1cIGMzjzWf1o=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=siJgVs3fqa4iPMNpHQXVFAcF30Nxi3OQnvxDclKY/O2SOoJ5/dBOwGft2KZK74iOU6SnA3OTwfbBlp+Gyfb6lx9L+hpNz3aWChLQZeb+xp2lyoc6lGn0pzvnhrsEosbEwJA1XgaYNSMmBMlKzT1aNCcNzUCvCZkV6y3ksvfND6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=MmchsshG; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
Message-ID: <81e1b870-37f9-4ef2-9a3d-87015f32546b@kl.wtf>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1713176910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U9PVb8xivoJgq4CfEp7VS5NnrAbJtk5R/pKxVfPKHvI=;
	b=MmchsshGqvcfQoWrOQpZSpfrNEAo8LMcrO89bEbsDggNM26yaIXRq8qdga4SMJqcvJzuGK
	+0zk6oj/wCNQ7bNODSeoYgyS+V8k8k6FvXu5Mj1EcgMlsrcJCyHqwNdEQG72NZIQABXsV4
	ldHdEeNikM2qwH4sUvw43voXEpjo3/x+6s8AbhnJw2wfXuwUloBPxrrYwZkW+h0xL7ibz5
	V6gx3wu9+zYaG1CX82YH6Fk9Wu84FhjW8M/flhBzyFsOajnV30dRpP1bxBxdUT5Q4fHzOP
	pvFSf2syIQnHsS2CQ1KKe9K6AJzH7eKZi6YensugvHV2ZhN/DJKfl2a/iYuveg==
Date: Mon, 15 Apr 2024 12:28:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: lma@chromium.org
Cc: benjamin.tissoires@redhat.com, dianders@chromium.org, dtor@chromium.org,
 hdegoede@redhat.com, jikos@kernel.org, johan+linaro@kernel.org,
 johan@kernel.org, kai.heng.feng@canonical.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, mripard@kernel.org, rad@chromium.org
References: <CAE5UKNqufWZfKLAXLcpBYKQpJEVt6jPD4Xtr=Nesh34VkNOETg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kenny Levinsen <kl@kl.wtf>
In-Reply-To: <CAE5UKNqufWZfKLAXLcpBYKQpJEVt6jPD4Xtr=Nesh34VkNOETg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> The problem is that the probe function calling i2c_smbus_read_byte()
> is not aware that
> uC on the other end is in a deep sleep state so the first read will
> fail and so the whole probe.
Well, the probe was just added to "avoid scary messages", so we could 
just do away with it and fix the "scary messages" instead.

I think it would be better to handle the wake-up near the command being 
sent that requires the device to be awake, just like is done for 
i2c_hid_set_power(). This would mean removing the smbus probe 
altogether, extending the HID descriptor fetch code to retry on 
EREMOTEIO, and to avoid the "scary messages", print something nice if 
the second attempt also fails with EREMOTEIO.

If the device can enter deep-sleep arbitrarily, then we presumably also 
have problems in i2c_hid_output_raw_report() and 
i2c_hid_get_raw_report() which could happen after the device has gone to 
sleep from inactivity. These places would also need EREMOTEIO retry logic.

All these places should have the same sleeping behavior as they are 
working around the same device glitch. I imagine the client ACK timeout 
is longer than your required 400µs, in which case you don't need any 
sleep on retry at all, as is the case in the current i2c_hid_set_power() 
implementation.

However, as we litter retry-code all over the place, Johan's suggestion 
about doing this in the I2C driver does become a bit more relevant...

Best regards,
Kenny Levinsen


