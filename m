Return-Path: <linux-kernel+bounces-74607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF785D6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5018F1C213BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8DD3FE25;
	Wed, 21 Feb 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="k7E5wTI9"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94EA3C493;
	Wed, 21 Feb 2024 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514556; cv=none; b=UEUl91aJZlUbbcAeNwWboNXQ80D2TezNxAc0M5r0vERkMUi7Y87taYLYeU6kpoq7fiKYgJ2l0iarM4Vnzeobn/BQyPotYoy+SmbeRetzMbVurOgKoWmxM/tfXBmAaLV9gWXozbaPI+Cv0aKaPeO//zvGGjDc3dYZdEQ/BaLceR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514556; c=relaxed/simple;
	bh=Cd4YbmGVn6HLR5Rl2we4DAmAlvwWASoLb8I9ojQ3DSA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EUwlsXyhKbS1LLR1GRuW51b+eawSt3ji5tE3whI7d5Vqt8Ql9dK5UC82hl10M/4Wfc7gfyqrPXD0W/av3OQa/NHw+J4SyfQGZI4r0CDv6YTdb1O60fO5HuZEj4rEguE1mFSnPJb/wJVUxOZP5QCmGl1d6N5qJv7v2HcOnR5LQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=k7E5wTI9; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (pd9e59c8a.dip0.t-ipconnect.de [217.229.156.138])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id D40662FC0048;
	Wed, 21 Feb 2024 12:12:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1708513959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbjUnH12jdTK6RPMAkyasJrnzhc5mx7f3K8nZGIu3HM=;
	b=k7E5wTI9wjKCm/lrwKWCcvr4H172M6hup+m/2tF3hvs5LCeQDFEYbXXCDDw4YQr49vfn3p
	iUUXgwkSMVO7nIrwnDQmkbIVfjxjqRatSrkD6TpFzw/fKL0LKJC6qFkIZsVD5fc2u1QT50
	GtGuma4H+b3wtpNf58YTKmC0MsP4Sy8=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <247b5dcd-fda8-45a7-9896-eabc46568281@tuxedocomputers.com>
Date: Wed, 21 Feb 2024 12:12:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Future handling of complex RGB devices on Linux v2
From: Werner Sembach <wse@tuxedocomputers.com>
To: Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>, jikos@kernel.org,
 linux-kernel@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org
References: <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
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
 <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
Content-Language: en-US
In-Reply-To: <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

so after more feedback from the OpenRGB maintainers I came up with an even more 
generic proposal: 
https://gitlab.com/CalcProgrammer1/OpenRGB/-/issues/3916#note_1753072869

Copy pasting the relevant part:

 >Another, yet more generic, approach:
 >
 >```
 >get-device-info ioctl returning:
 >{
 >    char name[64]                /* Device model name / identifier */
 >    enum device_type            /* e.g. keyboard, mouse, lightbar, etc. */
 >    char firmware_version_string[64]    /* if known to the driver, empty 
otherwise */
 >    char serial_number[64]            /* if known to the driver, empty 
otherwise */
 >    enum supported_commands[128]        /* comands supported by the firmware */
 >}
 >
 >evaluate-set-command ioctl taking:
 >{
 >    enum command                /* one of supported_commands */
 >    union data
 >    {
 >        char raw[3072],
 >        {
 >            <input struct for command 0>
 >        },
 >        {
 >            <input struct for command 1>
 >        },
 >        ...
 >    }
 >}
 >
 >evaluate-get-command ioctl taking:
 >{
 >    enum command                /* one of supported_commands */
 >    union data
 >    {
 >        char raw[3072],
 >        {
 >            <input struct for command 0>
 >        },
 >        {
 >            <input struct for command 1>
 >        },
 >        ...
 >    }
 >}
 >and returning:
 >{
 >    union data
 >    {
 >        char raw[3072],
 >        {
 >            <return struct for command 0>    /* not every command might have 
one */
 >        },
 >        {
 >            <return struct for command 1>    /* not every command might have 
one */
 >        },
 >        ...
 >    }
 >}
 >```
 >
 >- char name[64] still includes, if know to the driver, information about 
physical or even printed layout.
 >- differentiation between evaluate-set-command and evaluate-get-command is 
mainly there for performance optimization for direct mode (for 
evaluate-set-command the kernel does not have to copy anything back to userspace)
 >- commands without a return struct must not be used with evaluate-get-command
 >- the input struct might be empty for very simple commands (or "int unused" to 
not confuse the compiler if neccessary)
 >
 >Now is the question: How does userspace know which commands takes/returns 
which structs? Define them in one big header file (as struct 
clevo_set_breathing_mode_1_input, struct tongfang_set_breathing_mode_1_input, 
etc.), or somehow dynamicaly? I'm warming up to Hans suggestion to just do it 
statically, unlike my suggestion yesterday.
 >
 >Min/Max values are documented in the header file (if not implied by variable 
type). With different max value -> different command, e.g. 
clevo_set_breathing_mode_1 for devices with speed from 0 to 7 and 
clevo_set_breathing_mode_2 for devices with speed from 1 to 10.

But at this point it is almost a generic interface that can be used to expose 
anything to userspace, looping back to the sanitized-wmiraw idea that was 
floating around earlier.

So a new approach (Please correct me if there is already something similar I'm 
not aware of):

New subsystem "Platform Device Commands" (short platdevcom) (I'm open for better 
name suggestions):

- Registers /sys/class/platdevcom/platdevcom[0-9]* (similar to hidraw)
- Has get-device-info ioctl, evaluate-set-command ioctl, and 
evaluate-get-command ioctl as described above
- device_type enum entries for rgb would be for example rgbleds_keyboard, 
rgbleds_mouse, etc.

On a high level this subsystem can be used to expose any platform functionality 
to userspace that doesn't fit another subsystem in a central location. This 
could be for example a nearly 1 to 1 sanitized mapping to wmi calls. Or writing 
a specific EC register to control OEM BIOS features like flexi charging (only 
charge battery to specific percentage to extend the live).

However I am aware that this is hardly an api. So Maybe it's best to just fall 
back on extending the leds subsystem with the deactivate command, and from there 
just implement the few rgb devices that are not hidraw as misc devices in a per 
OEM fasion without a unified api.


