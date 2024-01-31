Return-Path: <linux-kernel+bounces-46375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30271843EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553E71C21CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FE2762CD;
	Wed, 31 Jan 2024 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="ZxYtFrTD"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0B762C3;
	Wed, 31 Jan 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701274; cv=none; b=Tmpknyo890UFmI/XGUZ3mpKmbD1uKuSReuHodz/yoNzHVbvE/1Vj+qLbuWtmHHmF9PKWkswvMEXZnc4SB1vPV7HgOi/35sY0Y3rxqilyBIBSIGQMdX59JjHqqFkHnTDsoKiX+iK+0PksPA2x/pJrm5r3ZvQxYhTSF2CLAnVt7rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701274; c=relaxed/simple;
	bh=Ysk1DXQQH8iuG3T6SLSADhPrd8JuNH55pHiq/6Vyz18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqCQfzVHcOHwaf9/kYM6ZOftnT9Dfh/evLSuoHD9JgjI7BNx8STCh7FR5GPoQ0sDl3w5ULCnodXZZn2cmmfJF1HNYCgIrfUj8FwwoegsIkK+8gFio0Q5YRRLATp9kKhR80nCk59J0sCw9H9lJ1u35frMTZRuTzsmaQEQqtovpd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=ZxYtFrTD; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id A32332FC004A;
	Wed, 31 Jan 2024 12:41:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1706701263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SsJehYO30sr02LgW1i3XyRegpdTntKLXnN2eAseYrk=;
	b=ZxYtFrTDL35wTkktQPwdhDVYEOf8pW9ybpn7/klnIOy0ABz9s2wkDHJ500ZGK/X9L/hUNQ
	12LVdbNj7C9QpSeFB0m7MXclVlvHmle5/ZCdjQe56Bjoq9VS8viJv6tDuZnGG9dDYJebuD
	k0LFC/WFVpfDcbwzUp9vYywXrLB8dUM=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
Date: Wed, 31 Jan 2024 12:41:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Future handling of complex RGB devices on Linux
To: Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>, jikos@kernel.org,
 linux-kernel@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org
References: <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
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
 <b70b2ea8-abfd-4d41-b336-3e34e5bdb8c6@tuxedocomputers.com>
 <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

so I combined Hans last draft, with the discussion since then and the comments 
from the OpenRGB maintainers from here 
https://gitlab.com/CalcProgrammer1/OpenRGB/-/issues/3916 and my own experience 
and came up witrh this rough updated draft for the new uapi:

Future handling of complex RGB devices on Linux:

Optional: Provide a basic leds-subsystem driver:
     - The whole device is treated as a singular RGB led in the current leds uapi
         - Backwards compatibility
         - Have something work out-of-the-box and during boot time
     - The driver also registers a misc device with a singluar sysfs attribute 
select_uapi
         - reading this gives back "[leds] none"
         - the current active uapi can be selected by writing it to that attribute
         - switching the uapi means deregistering the device from that entirely 
and registering and initializing it with the new one froms scratch
         - selecting none only does the deregistering

If the device is already reachable by userspace directly, e.g. via hidraw, the 
kernel will only offer this basic implementation and a more complex driver has 
to be implemented in userspace.
     - This driver has to use the select_uapi attribute first and select "none" 
to avoid undefined behaviour caused by accessing the leds upai and hidraw to 
control the lighting at the same time
     - Question: How to best associate the select_uapi attribute to the 
corresponding hidraw (or other) direct access channel? So that a userspace 
driver can reliable check whether or not this has to be set.

Devices not reachable by userspace directly, e.g. because they are controled via 
a wmi interface, can also be implemented in the new rgbledstring-subsystem 
(working title) for more complex control
     - a rgbledstring device provides an ioctl interface (ioctl only no r/w) 
using /dev/rgbledstring0, /dev/rgbledstring1, etc. registered as a misc chardev.
         - get-device-info ioctl which returns in a single struct:
             - char name[64]                     /* Device model name / 
identifier, preferable human readable. For keyboards, if known to the driver, 
physical layout (or even printed layout) should be separated here */
             - enum device_type                  /* e.g. keyboard, mouse, 
lightbar, etc. */
             - char firmware_version_string[64]  /* if known to the driver, 
empty otherwise */
             - char serial_number[64]            /* if known to the driver, 
empty otherwise */
             - enum supported_modes[64]          /* modes supported by the 
firmware e.g. static/direct, breathing, scan, raindrops, etc. */
         - get-mode-info icotl, RFC here: Hans thinks it is better to have the 
modes and their inputs staticly defined and have, if required, something like 
breathing_clevo_1, breathing_clevo_2, breathing_tongfang_1 if the inputs vary 
between vendors. I think a dynamic approach could be useful where userspace just 
queries the struct required for each individual mode.
             - input: a mode from the supported_modes extracted from get-device-info
             - output: static information about the mode, e.g. 
max_animation_speed, max_brightness, etc.
             - output: the struct/a list of attributes and their types required 
to configure the mode
         - set-mode ioctl takes a single struct:
             - enum mode                         /* from supported_modes */
             - union data
                 - char raw[3072]
                 - <all structs returned by get-mode-info>
         - The driver also registers a singluar sysfs attribute select_uapi
             - reading this gives back "[leds] rgbledstring none" or 
"[rgbledstring] none" respectifly
             - Discussion question: should select_uapi instead be use_leds_uapi
                 - if 1: use basic leds driver
                 - if 0: if device is userspace accessible no kernel driver is 
active, if device ist not userspace accessible register rgbledstring (aka 
implicit separation between rgbledstring and none instead of explicit one)

Zone configuration would be seen as a subset of mode configuration, as I suspect 
not every mode needs the zone configuration even on devices that offer it?

The most simple mode would be static/direct and the set-mode struct would look 
like this:
{
     enum mode, /* = static */
     {
         uint8 brightness, /* global brightness, some keyboards offer this */
         uint8 color[<number_of_leds>*3]
     }
}

Question: Are there modes that have a separate setup command that is only 
required once and then a continuous stream of update information? If yes, should 
we reflect that by splitting set-mode into set-mode-setup and set-mode-update 
(with get-mode-info returning one struct for each)? Or should userspace just 
always send setup and update information and it's up to the kernel driver to 
only resend the setup command when something has changed? In the former case 
set-mode-update might be a noop in most cases.

Discussion on this might also happen here: 
https://gitlab.com/CalcProgrammer1/OpenRGB/-/issues/3916#note_1751170108

Regards,

Werner


