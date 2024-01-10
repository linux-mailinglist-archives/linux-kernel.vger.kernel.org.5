Return-Path: <linux-kernel+bounces-22206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5EB829ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1652C2892C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E324879C;
	Wed, 10 Jan 2024 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss8TjBZH"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC048CC1;
	Wed, 10 Jan 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6da202aa138so3283559b3a.2;
        Wed, 10 Jan 2024 05:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704891726; x=1705496526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6k/nsanH7h+OoETQsf0mg+WqirUcHwExUVYJ+IUj20s=;
        b=Ss8TjBZH/Q81cw9iZX2qaC328wFL/IccTVr+Q425f/tjj+wKNF2Vuf2YXgJig304mw
         6xh356vi3TAoA0m6udRGstGXh3YwU/j7voa7bw0nRgeF2EB3bJRKrMMa7EPgYtUaTlR6
         x83aLYEt54DAyHAukmLtBcRXGLTPcW2nkcc4Ah9IkEtbF5wtcPpanAjjMQTsh/oquc3A
         FQki0VU3MoP2F5nV6Jq+lawqdg3HiKGkjvg45cagpFyb3Ly5W+6n0vHV6XL/+S6LM//7
         bKcBDYfVJDWKMzHYNohOC4Z+jswODtLQnui+9fBb/t+N15f0LlgVwS/moWL66JuHyNvP
         oy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704891726; x=1705496526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k/nsanH7h+OoETQsf0mg+WqirUcHwExUVYJ+IUj20s=;
        b=ByFhXqLzrvw9HoAz0XI2j3XE90jxBeCAVKLKfQYhVari/5RqI2busM9eLKYDM/lsHC
         x5rMjEph9s2bNo4UaHZbaiMWi6Em0/R0lx7qWuVrGimDKuXYmz9HBKrRfG1vxAoAvsdi
         6xjFsg8dlTuLscmiAp5WMRAJsGOv3Dhmxkud9u113qOk+di7LVRCOL8AxRlO+cGFZZd1
         1E0c6KECIVM8DGNdiUXEV5Y3SaaCTd7HwrVEauxUZxC/1FMFqIBaAUeKODRArMQ1XHeX
         IgCvm8xosEc2x35la6fJRpi4Q9A0AySSHDYk0kAAJE4GAEPZ/CyAPeLuGP+nCxmE9nZF
         SyKQ==
X-Gm-Message-State: AOJu0YwAWRAEqsSoN1YgKLiywx/FBaUdyATRhIUNEujQ5g1Z2O2cHlGR
	Pw2an7Q6KPv5sIKmCtGHdGc=
X-Google-Smtp-Source: AGHT+IFWQCk5czwMttjZAELBAEjl1P1cfMull9IGmSvkCIqAMLNs4XVaLwVPBtf28wavFGduZyZwfA==
X-Received: by 2002:a05:6a20:3942:b0:19a:39da:184f with SMTP id r2-20020a056a20394200b0019a39da184fmr126081pzg.38.1704891725756;
        Wed, 10 Jan 2024 05:02:05 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id w11-20020aa7858b000000b006d9a96b7d0dsm3426975pfn.208.2024.01.10.05.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 05:02:04 -0800 (PST)
Date: Wed, 10 Jan 2024 21:01:58 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Phil Howard <phil@gadgetoid.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
	andy@kernel.org, corbet@lwn.net
Subject: Re: [PATCH 1/7] Documentation: gpio: add chardev userspace API
 documentation
Message-ID: <20240110130158.GA28045@rigel>
References: <20240109135952.77458-1-warthog618@gmail.com>
 <20240109135952.77458-2-warthog618@gmail.com>
 <CA+kSVo_347gS+w_7ZXFDi9qDtT1aw15qoWRJZAVSkfbHShz7kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+kSVo_347gS+w_7ZXFDi9qDtT1aw15qoWRJZAVSkfbHShz7kQ@mail.gmail.com>

On Wed, Jan 10, 2024 at 11:40:34AM +0000, Phil Howard wrote:

[snip]
> > +
> > +===================================
> > +GPIO Character Device Userspace API
> > +===================================
> > +
> > +This is latest version (v2) of the character device API, as defined in
> > +``include/uapi/linux/gpio.h.``
> > +
> > +.. note::
> > +   Do NOT abuse userspace APIs to control hardware that has proper kernel
> > +   drivers. There may already be a driver for your use case, and an existing
> > +   kernel driver is sure to provide a superior solution to bitbashing
> > +   from userspace.
> > +
> > +   Read Documentation/driver-api/gpio/drivers-on-gpio.rst to avoid reinventing
> > +   kernel wheels in userspace.
>
> I realise this is in part an emotional response, but very much
> "citation needed" on
> this one.
> While I believe Kernel drivers for things are a good idea, I
> don't believe
> userspace libraries are necessarily bad or wrong. They might be the first
> experience a future kernel dev has with hardware. Either way there are multiple
> ecosystems of userspace drivers both existing and thriving right now, and there
> are good reasons to reinvent kernel wheels in userspace.
>

What I stated is kernel policy as I understand it.

What you describe is what I would consider to be prototyping.
If you want play with bitbashing SPI, or whatever, go knock yourself out.
If you want to release that in a product then you really should
be using the kernel driver if one is available.
Bitbashing should be the last resort.

> At least some of these reasons relate to the (incorrectly assumed)
> insurmountable
> nature of kernel development vs just throwing together some Python. Including
> this loaded language just serves to reinforce that.
>
> You catch more flies with honey than with vinegar, so I'd probably soften to:
>
> Before abusing userspace APIs to bitbash drivers for your hardware you should
> read Documentation/driver-api/gpio/drivers-on-gpio.rst to see if your device has
> an existing kernel driver. If not, please consider contributing one.
>

The note is is a rewording of a section of the existing sysfs documentation:

    DO NOT ABUSE SYSFS TO CONTROL HARDWARE THAT HAS PROPER KERNEL DRIVERS.
    PLEASE READ THE DOCUMENT AT Subsystem drivers using GPIO TO AVOID REINVENTING
    KERNEL WHEELS IN USERSPACE. I MEAN IT. REALLY.

So I've already toned down the vineger.

And your suggestion seems at odds with your earlier argument - we should suggest
that such a user write a kernel driver??

> > +
> > +   Similarly, for multi-function lines there may be other subsystems, such as
> > +   Documentation/spi/index.rst, Documentation/i2c/index.rst,
> > +   Documentation/driver-api/pwm.rst, Documentation/w1/index.rst etc, that
> > +   provide suitable drivers and APIs for your hardware.
>
> This is good, people trying to do PWM via userspace bitbashing on arbitrary pins
> (sometimes we really do just want to dim a bunch of LEDs without the cost of an
> extra driver IC) is kind of silly in hindsight. If we steer people
> toward the right
> subsystems, perhaps those can be improved for the benefit of all.
>

Indeed, this paragraph is in response to community discussions, one of
which was looking for a something official that says this.
Now there is one.

> > +
> > +Basic examples using the character device API can be found in ``tools/gpio/*``.
> > +
> > +The API is based around two major objects, the :ref:`gpio-v2-chip` and the
> > +:ref:`gpio-v2-line-request`.
> > +
> > +.. _gpio-v2-chip:
> > +
> > +Chip
> > +====
> > +
> > +The Chip represents a single GPIO chip and is exposed to userspace using device
> > +files of the form ``/dev/gpiochipX``.
>
> Is it worth clarifying that - afaik - the numbering of these device
> files is or can
> be arbitrary? Or, in the opposite case, that the order is guaranteed
> by the vendor's
> device tree configuration?
>

I consider that outside the scope of the API.

> > +
> > +Each chip supports a number of GPIO lines,
> > +:c:type:`chip.lines<gpiochip_info>`. Lines on the chip are identified by an
> > +``offset`` in the range from 0 to ``chip.lines - 1``, i.e. `[0,chip.lines)`.
>
> I don't recognise this syntax "`[0,chip.lines)`", typo, or me being clueless?
>

Sadly the latter.

To exand on Andy's response, within the notation '[' and ']' are inclusive,
'(' and ')' are exclusive.

Too esoteric?

[snip]
> > +    -  -  ``EBUSY``
> > +
> > +       -  The ioctl can't be handled because the device is busy. Typically
> > +          returned when an ioctl attempts something that would require the
> > +          usage of a resource that was already allocated. The ioctl must not
> > +          be retried without performing another action to fix the problem
> > +          first.
>
> eg: When a line is already claimed by another process?
>

My preference would be to put a note in the appropriate ioctl than provide
specific examples in the error codes.
The descriptions here should remain general.

That one probably should be explicitly stated in GPIO_V2_GET_LINE_IOCTL.

[snip]
> > +Description
> > +===========
> > +
> > +On success, the requesting process is granted exclusive access to the line
> > +value, write access to the line configuration, and may receive events when
> > +edges are detected on the line, all of which are described in more detail in
> > +:ref:`gpio-v2-line-request`.
> > +
> > +A number of lines may be requested in the one line request, and request
> > +operations are performed on the requested lines by the kernel as atomically
> > +as possible. e.g. gpio-v2-line-get-values-ioctl.rst will read all the
> > +requested lines at once.
> > +
> > +The state of a line, including the value of output lines, is guaranteed to
> > +remain as requested until the returned file descriptor is closed. Once the
> > +file descriptor is closed, the state of the line becomes uncontrolled from
> > +the userspace perspective, and may revert to its default state.
>
> At the behest of the line driver? (an example of a line driver that
> has good reason
> for reverting might be useful here, to indicate that in the general
> case the user
> cannot assume the state of unclaimed lines)
>

I've tried to keep the kernel a black box from the userspace perspective.
And the sentence explicitly includes "from the userspace perspective"
for that reason.

Where I do provide details of the internal workings it remains high
level - "the kernel does this".

I do not want to go into the detais of kernel internal components here
- out of scope.

[snip]
> > +
> > +Description
> > +===========
> > +
> > +Update the configuration of previously requested lines, without releasing the
> > +line or introducing potential glitches.
>
> Is this guaranteed by all line drivers?
>

I'm not sure anything is guaranteed by all the line drivers ;-).

But, AIUI, we should be all good. AFAIAA, and I stand to be corrected if I'm
wrong, none of the actions we perform on the driver would trigger a glitch
unless the driver is buggy.

It certainly wont glitch output line values like releasing and requesting
the line with the new config could - and that is independent of driver.

[snip]
> > +Description
> > +===========
> > +
> > +Set the values of requested output lines.
> > +
> > +Only the values of output lines may be set.
> > +Attempting to set the value of an input line is an error (**EPERM**).
>
> User beware if they come from some cursed ecosystem where writing a value
> to an input line sets or enables/disables the bias,
>
> eg: https://www.arduino.cc/reference/en/language/functions/digital-io/digitalwrite/
>

Everything there boggles the mind.

How does this API do anything that such a user needs to "beware" of?
Here if they use their janky overloading behaviour they get an error and
have to switch to the correct knob.  Is that scary ;-).

Cheers,
Kent.

