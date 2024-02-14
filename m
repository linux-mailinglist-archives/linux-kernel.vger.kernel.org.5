Return-Path: <linux-kernel+bounces-65395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F427854C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0F928A663
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956E35C901;
	Wed, 14 Feb 2024 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lkWs3yP6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6SSGVqOE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hVS06lzN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6uL1+Jv8"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F75C5FA;
	Wed, 14 Feb 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923559; cv=none; b=AlY/YS2d06tFBf5kfaJovZvp4N3nv0kLeleB61k+6V+XBHGn96naJ1JEupzg5Ra2EU/NV94E1yPCieZlH45e6HHZL5qFUtTeF216CPqxVRuAG/oawHSIXQwMHme8LTnbqmPESYF+WXD4AXDwyjxQEHnBawvkKeE0Keo3y7gStds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923559; c=relaxed/simple;
	bh=7/P7x+/AqII8L6wca9mcDfS/hzMkjEos5evXqT75hRw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9jJVix8p1m0GSrn/AEVrsmJ4tfcf4yBWXyiA0Acgkd27tjI/WeCRLfxiZ0XHSc5I92GT6FgTSAis6PQFndBD2Mgbln20eVcCZGbtC70tnCOUZJ3DrJ+4DvNPhg2CIaEQsVWni89dXA+VBa7reStIOQgLbpfiYvqeDQuYOqQkjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lkWs3yP6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6SSGVqOE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hVS06lzN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6uL1+Jv8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0ECD11F806;
	Wed, 14 Feb 2024 15:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707923556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+/B5wDGrnXVqk4PQUhrU9bSZQxWwxNn0w4TAr6yKcQ=;
	b=lkWs3yP6FFBkBWgFYb5/XRFIuFsC6uzYOwerLfBuM/knxMIy5CK7RFnhqkvHcdkAgvZ/5b
	gDkjbT5sN62k4sXdLHJrBIh1nFFabxPZN4OQ24T5CCQ0k3VPEXcyHmjSVNhxJvVscjzA5l
	zcd+1s8cZHr51Iey8Xf9zi+oL29YXn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707923556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+/B5wDGrnXVqk4PQUhrU9bSZQxWwxNn0w4TAr6yKcQ=;
	b=6SSGVqOEUT7GMI8Eof4haHBGyPj3v01GAQsPCgA/7uh9EXWZEnKSF7oHhXe1m4/VluKImF
	QRXx8ilqzUs8ruCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707923554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+/B5wDGrnXVqk4PQUhrU9bSZQxWwxNn0w4TAr6yKcQ=;
	b=hVS06lzN98Yokb41766nmq2ZnujrLlNWZxDC4h8xVg+ChWfhVO9ESSv8+35LpMX8GKwCd6
	eoxZJDQKNvutURSQQRG4EK0tWyu3+b4q9CZ6TZF9fU2A82v7KfEfZjcNwO050Ih9IpAzIj
	AO1Wmdf2sVJWsiknNeF3bedREJf2vJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707923554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+/B5wDGrnXVqk4PQUhrU9bSZQxWwxNn0w4TAr6yKcQ=;
	b=6uL1+Jv8ciGuXWkHvvH9bz//4XQidPEl0imupmTBSMNoskY84HLPdACN9zh2g1oonSe+wO
	Gh2itcqqtZkSXKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3CA513A6D;
	Wed, 14 Feb 2024 15:12:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OjRNMmHYzGUQIQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 14 Feb 2024 15:12:33 +0000
Date: Wed, 14 Feb 2024 16:12:33 +0100
Message-ID: <87jzn7gjvi.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Warning! Unlikely big volume range (=9234), cval->res is probably wrong. (Dell XPS 13 9360 and Plantronics Blackwire 315.1
In-Reply-To: <a18994c5-6584-403f-8754-b9db43c1f6fa@molgen.mpg.de>
References: <a18994c5-6584-403f-8754-b9db43c1f6fa@molgen.mpg.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SUBJECT_HAS_EXCLAIM(0.00)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,alsa-project.org:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Wed, 14 Feb 2024 15:53:03 +0100,
Paul Menzel wrote:
> 
> Dear Linux folks,
> 
> 
> On the Dell XPS 13 9360, plugging in a USB headset, I saw the warning
> below the first time since using the devices since December 2023.
> 
> ```
> $ sudo dmesg | grep -e "DMI:" -e "Linux version" -e microcode
> [    0.000000] Linux version 6.8.0-rc4
> (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 13.2.0-13) 13.2.0,
> GNU ld (GNU Binutils for Debian) 2.42) #20 SMP PREEMPT_DYNAMIC Mon Feb
> 12 09:40:49 CET 2024
> [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> [    0.386024] microcode: Current revision: 0x000000f4
> [    0.386026] microcode: Updated early from: 0x000000f0
> […]
> [88628.500854] usb 1-2: new full-speed USB device number 11 using xhci_hcd
> [88628.723620] usb 1-2: New USB device found, idVendor=047f,
> idProduct=c037, bcdDevice= 1.45
> [88628.723627] usb 1-2: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [88628.723629] usb 1-2: Product: Plantronics Blackwire 315.1
> [88628.723631] usb 1-2: Manufacturer: Plantronics
> [88628.723633] usb 1-2: SerialNumber: F3D422B734B3EC4CAF12EA236AFCB5EA
> [88628.794126] input: Plantronics Plantronics Blackwire 315.1 Consumer
> Control as
> /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.3/0003:047F:C037.000F/input/input67
> [88628.853158] input: Plantronics Plantronics Blackwire 315.1 as
> /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.3/0003:047F:C037.000F/input/input68
> [88628.853253] input: Plantronics Plantronics Blackwire 315.1 as
> /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.3/0003:047F:C037.000F/input/input69
> [88628.853428] hid-generic 0003:047F:C037.000F: input,hiddev1,hidraw2:
> USB HID v1.11 Device [Plantronics Plantronics Blackwire 315.1] on
> usb-0000:00:14.0-2/input3
> [88628.853447] probe of 0003:047F:C037.000F returned 0 after 59756 usecs
> [88628.853463] probe of 1-2:1.3 returned 0 after 127842 usecs
> [88628.853491] probe of 1-2 returned 0 after 129625 usecs
> [88628.892691] calling  alsa_rawmidi_init+0x0/0xff0 [snd_rawmidi] @ 117168
> [88628.892707] initcall alsa_rawmidi_init+0x0/0xff0 [snd_rawmidi]
> returned 0 after 1 usecs
> [88628.964882] calling  usb_audio_driver_init+0x0/0xff0
> [snd_usb_audio] @ 117168
> [88629.840845] usb 1-2: Warning! Unlikely big volume range (=9234),
> cval->res is probably wrong.
> [88629.840850] usb 1-2: [11] FU [Sidetone Playback Volume] ch = 1, val
> = 0/9234/1
> [88630.401192] probe of 1-2:1.0 returned 0 after 1436245 usecs
> [88630.401216] usbcore: registered new interface driver snd-usb-audio
> [88630.401219] initcall usb_audio_driver_init+0x0/0xff0
> [snd_usb_audio] returned 0 after 1436302 usecs
> [89546.685992] usb 1-2: USB disconnect, device number 11
> ```
> 
> (`/sbin/alsa-info` [1])
> 
> I am unable to reproduce this. Is that a problem with the headset, the
> laptop or something else?
> 
> Looking at the archive of Linux messages archive of *Hardware for
> Linux* [1], the message shows up quite often.

You can ignore it as long as the device appears working.
It mere informs a firmware bug of the device.  The driver detected it
and avoids the strange volume setup.

I have such a Plantronics USB headset, too ;)


thanks,

Takashi

> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://alsa-project.org/db/?f=3dc36e15c0cd57e299a119fb0b5b1ad6ed78e898
> [2]: https://github.com/linuxhw/Dmesg

