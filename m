Return-Path: <linux-kernel+bounces-31491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 206AE832EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463FA1C2465A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F626AF7;
	Fri, 19 Jan 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2wnjMVm"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A32112;
	Fri, 19 Jan 2024 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689219; cv=none; b=bB+DAQgW5kD4/7JTfbRFfSA2h7mBDj+bWv4SldvoTDgwpaLafYv0vzXsI8CiogxeHxFY/aMjvIBkkoaKkKoeLGh7ef2a6N27l55oyAX0t4pqg7pcmeSWX/hsfSNNrSM7+XqQfN+vuhCpXX2jcXCCQHQP5C+6P3ECmIzBtQuEXj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689219; c=relaxed/simple;
	bh=2UTEvLs5YWOQsuXjS93MK2My/6R/O8u9HEeLv8CKhG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=do+6HDDjIwT8KrbpHUysXXUVliABemfeZKsoZE7jQDKmUaPsDLWSs+1Y5t3bsz2J/uuKomDy0uysfO47ycchtTJzB4Yao7x3pp3O9H5fBQ9GkeqlwFI/bSJjF8MAONduPNXJRNwbXhsnXQAprKDGBWjKzQ8EvncvEtk1pMSeYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2wnjMVm; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29065efa06fso23199a91.1;
        Fri, 19 Jan 2024 10:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705689217; x=1706294017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zkKnoesKahkqO2ThUINQtzJ7lHkLPPLje48Y8+4TcIw=;
        b=Z2wnjMVmqbKU4URiAB5MWVd7m6hoNZChZS9B+T9HEHRQXoW1QoQZ41wlR/DVovmaMr
         91bK2XzCUz6ZuMIgjZvW4Vbw9c1u0r4Hi1o3Mob17pqk0A99HS3KzwSAF6RTvQmK2+Mq
         kJPKQYYykrQIA3im+Jk54Vk3b16bZvdeGSiBacOgE2AWGmsEVltChCmJn+UDe17Ep0KY
         7fznHTphIhTH7ykH9BCuUdiP1rYKVpCrPIKXhtc+ny/xx3SGsuhBQrydPlhYSV8t0kiM
         tv9R1+b9EHl1IL4nTNBvVtmBE3hy9BeftjScoVsB+Qm+LnJxmBY4/E4RaXlazYqxIgKr
         xq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705689217; x=1706294017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkKnoesKahkqO2ThUINQtzJ7lHkLPPLje48Y8+4TcIw=;
        b=Hgh0KviQhYeyw/p1cREDb1CaP3SaLKfHxU27gCjf45HuQLtAuQRKf/HPH4zCyML0Dm
         59oIR7Y6Q7lTpH+Bvjw1yV/Mv2HBYPCB3upRW1a8q81SV0gt+Ej8Pbc6Ta1BCI3Isg+J
         5ObsLCkrY9vk9EudPt6Xen+61RdoPkIfX86rI5JZ3GXrnlSTO7nXK1LS0UMjtlzYj2+V
         J+Eumnt+T4JPPCc4ppJwpFDxx1CsLVOCK5Qc7dM9j9VBadV1/ns2Xp0y0RnX/UuPIqBK
         SO7qidDDGGyWg04JaLAQVvoqlHTi58OOTigUWdh54YwegD1FIzmdhDPvYBnijJ47diSe
         +ZEg==
X-Gm-Message-State: AOJu0Yw1QZ9k9WSAW5yV7fH3V/47CI1mr9eEqBd4ypSQDE8ILThaLUtu
	b2rmAasgWCnuhzDr1qeMlFHVXffealFCCXozpaXI4I+dLQis3fiH
X-Google-Smtp-Source: AGHT+IE3J3mk+o/jaEbN4lFdflrsPSNaC31PQjCmi5eiwC0XemD3b7u1le1I/qswQjFVSQuib1m0zA==
X-Received: by 2002:a17:90a:c7cb:b0:290:1426:86fc with SMTP id gf11-20020a17090ac7cb00b00290142686fcmr182985pjb.89.1705689217443;
        Fri, 19 Jan 2024 10:33:37 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:97b4:2663:16e0:cf81])
        by smtp.gmail.com with ESMTPSA id sy14-20020a17090b2d0e00b0029005525d76sm4412592pjb.16.2024.01.19.10.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 10:33:37 -0800 (PST)
Date: Fri, 19 Jan 2024 10:33:34 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Werner Sembach <wse@tuxedocomputers.com>, jikos@kernel.org,
	Jelle van der Waa <jelle@vdwaa.nl>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	linux-input@vger.kernel.org, ojeda@kernel.org,
	linux-leds@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
Message-ID: <ZarAfg2_5ocfKAWo@google.com>
References: <87sf61bm8t.fsf@intel.com>
 <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz>
 <f4137e34-c7fb-4f21-bc93-1496cbf61fdf@tuxedocomputers.com>
 <8096a042-83bd-4b9f-b633-79e86995c9b8@redhat.com>
 <f416fbca-589b-4f6a-aad6-323b66398273@tuxedocomputers.com>
 <4222268b-ff44-4b7d-bf11-e350594bbe24@redhat.com>
 <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>
 <ZaljwLe7P+dXHEHb@duo.ucw.cz>
 <6bbfdd62-e663-4a45-82f4-445069a8d690@redhat.com>
 <87bk9hppee.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk9hppee.fsf@intel.com>

On Fri, Jan 19, 2024 at 12:51:21PM +0200, Jani Nikula wrote:
> On Fri, 19 Jan 2024, Hans de Goede <hdegoede@redhat.com> wrote:
> > For per key controllable rgb LEDs we need to discuss a coordinate
> > system. I propose using a fixed size of 16 rows of 64 keys,
> > so 64x16 in standard WxH notation.
> >
> > And then storing RGB in separate bytes, so userspace will then
> > always send a buffer of 192 bytes per line (64x3) x 14 rows
> > = 3072 bytes. With the kernel driver ignoring parts of
> > the buffer where there are no actual keys.
> >
> > I would then like the map the standard 105 key layout onto this,
> > starting at x.y (column.row) coordinates of 16.6 (with 0.0 being
> > the top left). Leaving plenty of space on the left top and right
> > (and some on the bottom) for extra media key rows, macro keys, etc.
> >
> > The idea to have the standard layout at a fixed place is to allow
> > userspace to have a database of preset patterns which will work
> > everywhere.
> >
> > Note I say standard 105 key layout, but in reality for
> > defining the standardized part of the buffer we should
> > use the maximum amount of keys per row of all the standard layouts,
> > so for row 6 (the ESC row) and for extra keys on the right outside
> > the main block we use the standard layout as shown here:
> 
> Doesn't the input stack already have to have pretty much all of this
> already covered? I can view the keyboard layout in my desktop
> environment, and it's a reasonably accurate match, even if unlikely to
> be pixel perfect. But crucially, it has to have all the possible layouts
> covered already.

The kernel actually is not aware of the keyboard geometry, it had no
idea if you are dealing with a standard full 101/102 keys keyboard,
TKL or even smaller one, if it is split or not, maybe something like
Kinesis Advantage360. Arguably, it could potentially know about
101/TLK if vendors would program accurate descriptors into their
devices, but nobody does... And geometry is not a part of HID interface
at all. So your desktop environment makes an [un]educated guess.

> 
> And while I would personally hate it, you can imagine a use case where
> you'd like a keypress to have a visual effect around the key you
> pressed. A kind of force feedback, if you will. I don't actually know,
> and correct me if I'm wrong, but feels like implementing that outside of
> the input subsystem would be non-trivial.

Actually I think it does not belong to the input subsystem as it is,
where the goal is to deliver keystrokes and gestures to userspace.  The
"force feedback" kind of fits, but not really practical, again because
of lack of geometry info. It is also not really essential to be fully
and automatically handled by the kernel. So I think the best way is to
have an API that is flexible enough for the userspace solution to
control, and that is not restricted by the input core design. The
hardware drivers are not restricted to using a single API, they can
implement both an input device and whatever new "rgbled" and userspace
can associate them by topology/sysfs.

> 
> Cc: Dmitry, could we at least have some input from the input subsystem
> POV on this? AFAICT we have received none.

Sorry, I was not CCed and I missed this on the mainling list.

Thanks.

-- 
Dmitry

