Return-Path: <linux-kernel+bounces-167296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7F28BA75F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2B61C21672
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4731465B9;
	Fri,  3 May 2024 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRTyb8do"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29A1465A0;
	Fri,  3 May 2024 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720042; cv=none; b=fGs/tvLa/tX+ikWLiGIVsvdpxpP8oFA25cGsOp0Tzlzbo1cUdtBW1pD9J426f4/OeH8ru9GXhNJMlDvsdlpoHrisLt1pCJSJYm1HpzeNaXkWz/icfVFQCSrfJYpYi0Go+lGzES0GxKehgqlI50cJeW/+VljS0JFH4Ljq70v42PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720042; c=relaxed/simple;
	bh=qxJUpV3gcX4/29yYO+koZ314peU2n/kHV9AlfZoyi5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDmYxK9tY0EE3U4vHTA48YIWMMHCZYYGhbT+zeZ7I9mL5IOC69DGiVyywooOPeDpkvRMoGht9bY/xM0ODbQukc4mYf2o3sf+7BX4bIHh0c2Uvos2QLFrvciqjBlmoYmaU5GNXEB50I1nYIvnGNp9UOOiElMUJgQxjhwEJyIP/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRTyb8do; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E93C116B1;
	Fri,  3 May 2024 07:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714720042;
	bh=qxJUpV3gcX4/29yYO+koZ314peU2n/kHV9AlfZoyi5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sRTyb8dogQOZnKoJuQbHnsuaxIkRgxDoZmBwsgYyXQsyLYKkt57pVLa7iEqIJ44yG
	 K7LvKmqylnQSQfzAaX+uccVS91DLtR6uRMDbGrav0s+QQXsmOHfiMB7pGJiMrv+Btl
	 aWQTZaSm77pk7P5cYvj8oYof96lxwl9yZU4YIlk2bX9j/URqQmr+YO9lZ+vHO4Snxg
	 W2Z0wzqdYB48whz22KMOoyu2VnnocvXskeH57lFaEtyfzks2tOBYWDxtHHUTbyHVTt
	 kor8i4kqqg9MJmGNagrNKcM1K/PxLzeZ9SHMgGm9FvqGpaje38IXh7CDd0rIX90YVP
	 Aa70vh6LNaRZQ==
Date: Fri, 3 May 2024 08:07:17 +0100
From: Lee Jones <lee@kernel.org>
To: FLAVIO SULIGOI <f.suligoi@asem.it>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: EXTERNAL: Re: (subset) [PATCH v1 1/1] backlight: mp3309c: fix
 leds flickering in pwm mode
Message-ID: <20240503070717.GB1227636@google.com>
References: <20240417153105.1794134-1-f.suligoi@asem.it>
 <20240417153105.1794134-2-f.suligoi@asem.it>
 <171466849494.1206441.17324969195592920195.b4-ty@kernel.org>
 <20240502164853.GB1200070@google.com>
 <PH0PR22MB37891FE6DC843E8EF05BDF7DFA1F2@PH0PR22MB3789.namprd22.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR22MB37891FE6DC843E8EF05BDF7DFA1F2@PH0PR22MB3789.namprd22.prod.outlook.com>

On Fri, 03 May 2024, FLAVIO SULIGOI wrote:

> Hi Lee,
> 
> ...
> 
> > Subject: EXTERNAL: Re: (subset) [PATCH v1 1/1] backlight: mp3309c: fix
> > leds flickering in pwm mode
> > 
> > [Use caution with links & attachments]
> > 
> > 
> > 
> > On Thu, 02 May 2024, Lee Jones wrote:
> > 
> > > On Wed, 17 Apr 2024 17:31:05 +0200, Flavio Suligoi wrote:
> > > > The mp3309 has two configuration registers, named according to their
> > > > address (0x00 and 0x01).
> > > > In the second register (0x01), the bit DIMS (Dimming Mode Select)
> > > > must be always 0 (zero), in both analog (via i2c commands) and pwm
> > > > dimming mode.
> > > >
> > > > In the initial driver version, the DIMS bit was set in pwm mode and
> > > > reset in analog mode.
> > > > But if the DIMS bit is set in pwm dimming mode and other devices are
> > > > connected on the same i2c bus, every i2c commands on the bus
> > > > generates a flickering on the LEDs powered by the mp3309c.
> > > >
> > > > [...]
> > >
> > > Applied, thanks!
> > >
> > > [1/1] backlight: mp3309c: fix leds flickering in pwm mode
> > >       commit: ce60cddc2abf61902dfca71d630624db95315124
> > 
> > Applied, but in future it's; I2C, PWM and LED, thanks.
> 
> Sorry for my question, but do you mean that I also have to add the I2C,
> PWM and LED mailing lists in my messages related to the mp33309c patches?

Just use proper capitalisation when you abbreviate the names these
subsystems please.

-- 
Lee Jones [李琼斯]

