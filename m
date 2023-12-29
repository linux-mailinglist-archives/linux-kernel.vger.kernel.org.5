Return-Path: <linux-kernel+bounces-13211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE8820130
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DC7282761
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D386212E72;
	Fri, 29 Dec 2023 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="Ud/KVEaL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E61712E46;
	Fri, 29 Dec 2023 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 1DA392FC006B;
	Fri, 29 Dec 2023 20:13:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1703877226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLTb8MHngpCr9Ay6alL/D0Bkd3X169eJXti2fNSNyUU=;
	b=Ud/KVEaLvSu5mZr8YUyKpZxPaKTMiVlzkT7gRzRovNYW5O6jE76s0nHvX3sKKkiqpQ4aT+
	g4FVQEN+xtw5YnRmzO2e8ZpaoD5WznFS69Z9PTGoEwWlaBAp0BBwGevuglfcPbg+8T7vN1
	xP2xSqZwiIfMaoLCgHz9FoImfR4yKeQ=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <49f12cc1-2dce-43b3-addf-b0fdb7df8fdb@tuxedocomputers.com>
Date: Fri, 29 Dec 2023 20:13:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
From: Werner Sembach <wse@tuxedocomputers.com>
To: Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>,
 Jani Nikula <jani.nikula@linux.intel.com>, jikos@kernel.org,
 Jelle van der Waa <jelle@vdwaa.nl>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-input@vger.kernel.org,
 ojeda@kernel.org, linux-leds@vger.kernel.org
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
 <ZSe1GYLplZo5fsAe@duo.ucw.cz>
 <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
 <ZSf9QneKO/8IzWhd@duo.ucw.cz>
 <a244a00d-6be4-44bc-9d41-6f9df14de8ee@tuxedocomputers.com>
 <ZSk16iTBmZ2fLHZ0@duo.ucw.cz>
 <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
 <ZSmg4tqXiYiX18K/@duo.ucw.cz>
 <CANiq72mfP+dOLFR352O0UNVF8m8yTi_VmOY1zzQdTBjPWCRowg@mail.gmail.com>
 <87sf61bm8t.fsf@intel.com> <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz>
 <f4137e34-c7fb-4f21-bc93-1496cbf61fdf@tuxedocomputers.com>
 <8096a042-83bd-4b9f-b633-79e86995c9b8@redhat.com>
 <f416fbca-589b-4f6a-aad6-323b66398273@tuxedocomputers.com>
 <4222268b-ff44-4b7d-bf11-e350594bbe24@redhat.com>
 <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>
Content-Language: en-US
In-Reply-To: <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Hans & the others,

[snip]
> I also stumbled across a new Problem:
>
> We have an upcoming device that has a per-key keyboard backlight, but does the 
> control completely via a wmi/acpi interface. So no usable hidraw here for a 
> potential userspace driver implementation ...
>
> So a quick summary for the ideas floating in this thread so far:
>
> 1. Expand leds interface allowing arbitrary modes with semi arbitrary optional 
> attributes:
>
>     - Pro:
>
>         - Still offers all default attributes for use with UPower
>
>         - Fairly simple to implement from the preexisting codebase
>
>         - Could be implemented for all (to me) known internal keyboard backlights
>
>     - Con:
>
>         - Violates the simplicity paradigm of the leds interface (e.g. with 
> this one leds entry controls possible multiple leds)
>
> 2. Implement per-key keyboards as auxdisplay
>
>     - Pro:
>
>         - Already has a concept for led positions
>
>         - Is conceptually closer to "multiple leds forming a singular entity"
>
>     - Con:
>
>         - No preexisting UPower support
>
>         - No concept for special hardware lighting modes
>
>         - No support for arbitrary led outlines yet (e.g. ISO style enter-key)
>
> 3. Implement in input subsystem
>
>     - Pro:
>
>         - Preexisting concept for keys and key purpose
>
>     - Con:
>
>         - Not in scope for subsystem
>
>         - No other preexisting light infrastructure
>
> 4. Implement a simple leds driver only supporting a small subset of the 
> capabilities and make it disable-able for a userspace driver to take over
>
>     - Pro:
>
>         - Most simple to implement basic support
>
>         - In scope for led subsystem simplicity paradigm
>
>     - Con:
>
>         - Not all built in keyboard backlights can be implemented in a 
> userspace only driver
>
> Kind Regards,
>
> Werner

Just a gentle bump and request for comments again. 4. would be better then 
nothing but it is not a universal future proof solution so I'm hesitant to put 
work into it even though it would be the simplest driver. I still tend towards 
1. as the leds interface already got expanded once with the multicolor stuff.

The only other way I see would be to implement a platform driver with no 
standardized api or implement a complete new api/subsystem from the ground up.

Kind Regards,

Werner


