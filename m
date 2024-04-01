Return-Path: <linux-kernel+bounces-126512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB978938DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C961C20E48
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6DCC157;
	Mon,  1 Apr 2024 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="IkJWzBqd";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="DCdK1Kxc"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDB52F55
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711959528; cv=none; b=hpyAEVFg7TxAnxju+ZB8iy2obmk/24v35dsRB9gFngrIjCW5xRdtJbXn6xn0rP2n7xPKwjCrrU/hEzVmmWeCJsqcmXSROGm3r0f5PgOG4m64MOI3nVGf15kwLmYTQG0r6NUZQPc9nYYcS1mzeEAgXxDDTJBYUUdKhHzBnJEAjIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711959528; c=relaxed/simple;
	bh=66DvLelDFwRcnBMioM5AmrRxjKQUmhBf29UewNpcIVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+i3M0UQlomsTBOaySUA5aRD3iOOyI3lFxvFwYZCdz+7uPHI3wlbaAGfDuanahsPhQ+rWU7kydUIHkS1jwRf7ROPoIamliDwSzyMtGdX5IjH+5bWBg3LnkH2HMqLaGHDb5GyHM3e74TsMtzWFh/vAF1/AQaPmsLsdROajAIFFYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=IkJWzBqd; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=DCdK1Kxc; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1711959526;
	bh=66DvLelDFwRcnBMioM5AmrRxjKQUmhBf29UewNpcIVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkJWzBqd2in4l2HPnhAUc3wDkiiTGY25A4vayFeVWmH8qyKFQAJvqndP1pYMiSbBg
	 MLo8A8cr7iJGOeZDmucJpV8RtdPSR3s0Wc3EKo6HkO2GCEMJ6RbFw8/FLE85JrNHG3
	 2rvRcXa8E1OGgP5W4DNfrP5wjfTN5U4PCKkYgbCFQIQqNrcqH+D7ooxlWnFkYbMA3q
	 uLBuMeVWEdZ83MFA72nQz+FjGQJshkCCQcFkUh9Xf6eT7moH0xaia7Is4M3dovaxAd
	 VNXJAnZAWx8E1mgaRYFCosm91OvQYHCbL2CSNkpqLP9lJhAMTkQpGQkl6XnLjeR42G
	 A8zweuNSb40Kg==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 0347517D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 17:18:46 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=DCdK1Kxc;
	dkim-atps=neutral
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id CDD535C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 17:18:44 +0900 (JST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6eab60b13e3so3147828b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 01:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1711959524; x=1712564324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/NnmyzP61r7am8Gc9zbH47jhDXOCLB/VPtXTUd0Z2c=;
        b=DCdK1Kxc91dSnlFZIk1axx36zplI/Ycveu64YBotYF+TwuzSkas7dygF9u0V7NBXRS
         EpuPCLjpO6xcjc+KNAUDwtiMRgStqWRlDZ+eqj2NRddcPZ1bjUodVwNg8XYuSHe7pUKE
         7Hg3i7MBX5MkHT518gUnOKd4zjJ5XuHnUjArZwGLQxaDJMLgkmM+UF5NM0x8tFY510EJ
         Q8+GEYKxqWeXIykANRPhkdqYXxiwLenOHv16UnwJBvyrF0ag3ptl8yKDMvTU7LnLUtPb
         oZ8q66369fKotYnX5VjDf1FinMo0WJr3WG5eHDSJYEd1C1E3D/Di6h2RlGwVMzu1QBuP
         f72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711959524; x=1712564324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/NnmyzP61r7am8Gc9zbH47jhDXOCLB/VPtXTUd0Z2c=;
        b=uMxxuWkpce15qSs5nHkSrDHCeeVM9/8lLo1q+SWwFrT8ZHyFVSKV7VOHqt4fVJnXXE
         UkkO4wnK2xBP93f/QZv/b2psj4BabUhSweOL0Jt8fGjbYwmiP+tGcrT3U33KEGWSW6kT
         M4p0vmmyxeplGHbEbSFFFA2kpOsSzoNS9pVn8f8V1SzTJmCENOLBGZrHNwqkKYphvU6z
         3qZ0FZ/YQZyJwISwb+i4cqNFWqWqMWYTFUD4O/JQ2ErBk2vcjnj9a7aAWyJ36KPLN7tb
         Hfvxe3yd3y9CJN2mk1NMtXbfYH8VhGr5/t/ENEXRFBJUnHQJj+yPT0FQ78EBJmYIaNKz
         vM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXN4FXLVwDH32ZeZdkoxpY8zZppBzs97KCaOzny34EX/t34PfGlttmNF3RfltMhqZ6HZx7fQ2FiXBNVsUMc0ytDofxyP7mEtTZsv+0h
X-Gm-Message-State: AOJu0YzmPL4YX+LHAl2aUXRIfRoKnwLEBK337tNEYElHLy8jTSA0xwBi
	WNJKfKC5O0G8HKo/NLtDI73ydw6a+UJ7/6dEJ7HHXLgIcdmzoHTFnjwgpuYZeQndJ4YQrwvEcva
	nFRrBnUUQHjZ6M+V4HWilAYbGU5hxEVBuNWj0qWD1JWvH8RpPkAYfjVEDgJyp6a4=
X-Received: by 2002:a05:6a00:1aca:b0:6ea:c156:f8dd with SMTP id f10-20020a056a001aca00b006eac156f8ddmr8433685pfv.11.1711959523811;
        Mon, 01 Apr 2024 01:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUOFo3lcIWy6cV0KUo99q6VRaAg/6jkt8RGIUrUCXrkXL5ImRZ1Ye/dwYJDu34C94yrI7EsQ==
X-Received: by 2002:a05:6a00:1aca:b0:6ea:c156:f8dd with SMTP id f10-20020a056a001aca00b006eac156f8ddmr8433666pfv.11.1711959523405;
        Mon, 01 Apr 2024 01:18:43 -0700 (PDT)
Received: from pc-0182.atmarktech (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id ey12-20020a056a0038cc00b006eaaaf5e0a8sm7325409pfb.71.2024.04.01.01.18.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2024 01:18:43 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rrCsM-00D4ZH-00;
	Mon, 01 Apr 2024 17:18:42 +0900
Date: Mon, 1 Apr 2024 17:18:31 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Syunya Ohshio <syunya.ohshio@atmark-techno.com>,
	Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
Message-ID: <Zgpt136Q2rGL-cl_@atmark-techno.com>
References: <Zd7hSOw3_zosyrn3@atmark-techno.com>
 <daed8ada-9e01-41ad-82af-5da5cbbc865c@linaro.org>
 <Zd7qz1Qte8HWieF_@atmark-techno.com>
 <20240228142441.00002a79@Huawei.com>
 <Zd_zB_ymxkx0HB3q@atmark-techno.com>
 <ZfPg-nMANUtBlr6S@atmark-techno.com>
 <CAMknhBG_kJx8JPvTBQo7zpy3mFAkUjZpRY3DLBfXt+39nRJWiA@mail.gmail.com>
 <ZfejyEvPIncygKJ9@atmark-techno.com>
 <20240318122953.000013f3@Huawei.com>
 <20240331152042.394b4289@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240331152042.394b4289@jic23-huawei>

Jonathan Cameron wrote on Sun, Mar 31, 2024 at 03:20:42PM +0100:
> Hi, got back to this finally...

Thank you for taking the time to express your thoughts!

> So the problems compared to other 'alias' users is that IIO is a bit more
> complex than for example LEDs.  A single DT node/compatible (or equivalent) can
> result in a 1+ IIO devices and 1+ triggers.

Right. I'm no longer really arguing for it at this point, but for
comparison in the patch I sent, the alias sets the start of the idr for
the device index, so if you have a driver that creates two IIO devices
you could just "reserve" two for this DT node and assuming the order
within this node is constant you'd still get constant numbering, so I
think it still somewhat holds up here.

For triggers though the numbers are separate and it wouldn't make sense
to use the same alias, if we wanted a coherent design with this we'd
need to add a second alias (such as iio_trigger = ..), but that makes
much less sense to me given they're also likely to be dynamically
instancied via configfs from what I've seen; I wouldn't want to do this
kind of mapping, so I agree with you.

> So I've messed around a bit and can think of various possible options to make
> this simpler.
> 1) Use a tmpfs mount and link from that.
>    Now we 'could' put an alias directory somewhere under /sys/bus/iio/ that
>    is a mount point created via sysfs_create_mount_point() - I abused the
>    /sys/kernel/debug directory to test this (unmounted debugfs and mounted
>    a tmpfs).  That would provide somewhere in sysfs that allows suitable
>    links. However, this is unusual so likely to be controversial.

Agreed that's probably not something we want to put our hands into.

> 2) Alternatively the relevant platform could create one of these somewhere
>    outside of sysfs and use udev rules to create the links.

I'm not sure I understood this one, something akin to the udev rules
I've showed that made links to the /sys iio device in /dev?
"relevant platform" here would be vendors?

> 3) Stick to the oddity of doing it under /dev/
> 4) Access the things in the first place via more stable paths?
>   /sys/bus/i2c/devices/i2c-0/0-0008/iio\:device?/ etc 
>    Relying on the alias support for i2c bus numbering to make that stable should work
>    and if you are sure there will only be one entry (most devices) that matches
>    the wild card, should be easy enough to use in scripts.
> 
> My personal preference is this last option.  Basically if you want stable paths
> don't use /sys/bus/iio/devices/ to get them.

Hmm, I wouldn't call that path stable given the '?' portion can change,
but at least that certainly is a single glob away so it's definitely
simpler than checking every labels all the time.

My second nitpick with this is that while these paths are stable for a
given kernel version, but we've had some paths changes over many years
(not sure if it was 3.14 or 4.9 but one of these perhaps didn't have
/sys/devices/platform yet? and things got moved there at some point with
some subtle name changes, breaking a couple of scripts).
OTOH /sys/bus/iio/devices feels less likely to change, but I guess this
is something that'd come up on tests when preparing a new kernel anyway,
so this is probably acceptable; I'm just thinking out loud.


With that said I can't think of anything that'd work everywhere either,
so I guess we can stick to the status-quo and I'll rediscuss what we
want to do with coworkers.


Thanks,
-- 
Dominique



