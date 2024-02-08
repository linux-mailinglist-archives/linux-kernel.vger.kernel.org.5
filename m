Return-Path: <linux-kernel+bounces-58204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA95B84E2B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2992F1C29A3D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A1A78678;
	Thu,  8 Feb 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHL6Pxb7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F9763E8;
	Thu,  8 Feb 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400765; cv=none; b=cvTjratomk9HrHtz3mQ/1SrFlySn7VAL+DjT7qkBnYin240qwKU2sSbKAlHisFwt7S5FR1gmcSe844edOOwyopvM+i8HyMC9YSkU2kKj7g7C6cb5Hdrpmzgx+SgHPBQBqNClgaxD1qT8HZ/4eUziZtEHJaefG/E6nnHyp/E+6JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400765; c=relaxed/simple;
	bh=go3VhlXk6Fnh3yPxAQWPPFT8Rbt755seTs3WL9Bzo/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtkUn8uxFmEiBFt0ZymloMlvNc/NDq8BU47PL84XoS0W2Zw/X+ikpTNKijNmh2UNe4nOwQu64GeTOE2pspa/5Q9Wd969FrRdrH0Mai3tRH6X8bQiO3MyA4nJgmSdGeR67xnd3xD5OcCHnaNMw1pf2rTI76BI9lggxnwC03h+hXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHL6Pxb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EECC433C7;
	Thu,  8 Feb 2024 13:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707400763;
	bh=go3VhlXk6Fnh3yPxAQWPPFT8Rbt755seTs3WL9Bzo/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHL6Pxb7RWXQABZTb2zfXe6Z5RP/2/5HU4UvBJ5fwNlhCcM7IDHBXvWzExYUOCEpx
	 vHQGQvt3BNctGm408Y8OgrWlcwhfnrNb2wTRxw2GGWxxf6CFbgxMjnadqmKijKB67C
	 1nyeYrZr3AEyeELypVSNDkNSPmwm0zknYaJN28mjInlVMZOo6awC/KZK2RFYjc51NC
	 zzG/FPobvPqX2AhacXgI5aBCdrtiFQGPNmG2LeicAQs59Zj9nwmXkSoaxu8JV7w5qF
	 CrxC5NYUVnU97YR/taok71AqcoXtypuFYuFBLsEq8tQNchI0/rmmGkaS0L9uaTTXbN
	 PI5/07xvt9fBw==
Date: Thu, 8 Feb 2024 13:59:18 +0000
From: Lee Jones <lee@kernel.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Pavel Machek <pavel@ucw.cz>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel@salutedevices.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/2] leds: aw200xx: support for hw pattern controllers
Message-ID: <20240208135918.GQ689448@google.com>
References: <20231207125938.175119-1-mmkurbanov@salutedevices.com>
 <20231207125938.175119-2-mmkurbanov@salutedevices.com>
 <20231221161011.GO10102@google.com>
 <ZbQ-jKD_zhonHOCa@ucw.cz>
 <20240129141927.4shshli37fb3cwen@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129141927.4shshli37fb3cwen@CAB-WSD-L081021>

On Mon, 29 Jan 2024, Dmitry Rokosov wrote:

> Hello Pavel,
> 
> On Sat, Jan 27, 2024 at 12:21:48AM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > This led-controller supports 3 pattern controllers for auto breathing or
> > > > group dimming control. Each pattern controller can work in auto
> > > > breathing or manual control mode. All breathing parameters including
> > > > rising/falling slope, on/off time, repeat times, min/max brightness
> > > > and so on are configurable.
> > > > 
> > > > Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> > > > ---
> > > >  .../testing/sysfs-class-led-driver-aw200xx    | 108 +++
> > > >  Documentation/leds/leds-aw200xx.rst           | 274 ++++++++
> > > >  drivers/leds/leds-aw200xx.c                   | 649 ++++++++++++++++++
> > > >  3 files changed, 1031 insertions(+)
> > > >  create mode 100644 Documentation/leds/leds-aw200xx.rst
> > > 
> > > This interface is bananas.  Exposing an entire register interface to
> > > sysfs does not sit will with me at all.  When we add support to a sysfs
> > > class, we usually require it to be generic and work across all devices.
> > > Adding device specific interfaces is generally decried and to be
> > > avoided.  Don't forget, once we commit something to sysfs, it becomes
> > > ABI and we have to support it forever.
> > 
> > If you do git grep hw_pattern, you should get pointers to qcom-lpg
> > driver that solves similar problem, with interface that should be
> > acceptable.
> 
> Thank you for pointing that out. Yes, it's a very similar situation to
> ours.
> 
> But I haven't observed the merging of this driver. Was it encountering
> similar issues with the sysfs interface?

`git grep` kinda implies that it's merged.

-- 
Lee Jones [李琼斯]

