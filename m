Return-Path: <linux-kernel+bounces-40839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B585683E6CC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FBD290DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6B65B5B7;
	Fri, 26 Jan 2024 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="fP4yEtVo"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7352051033;
	Fri, 26 Jan 2024 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311319; cv=none; b=FzJjFCogp2H2/ne5ZMk4xpjtF4FYvj3nETDLSd/0gBSpU1Fg2EcGcgqdMmEYQc494+W3uRQ1d3XAv+aXcusStuWRvDcrYUwsVC4m6aThyfUUFLewCjpzst2+hJIK8VQ/PoX/pvwwJJ6Y2xK2JTsHLzHsGqudYac17p5DNgAyAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311319; c=relaxed/simple;
	bh=3LcrOLtYCxr/GTKWLKz03ve3ssDHsY2b8TJXl7Am82s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IifKrO+LcKI+hDV7720iK4NpWMwsJK0+oJKDI7GvACqSNIr2u0myWoJhB2k1SiSPNltnfgpBqyAb+4eGtvgkBLOeHnXPb2lKd0it0DKSUa9GJE18mlIIZzLABDrh4pghDbiQCJCjAJ82UCm85jSomUjQNW5qBWrT6APe1m7ov44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=fP4yEtVo; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0040B1C0050; Sat, 27 Jan 2024 00:21:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1706311309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4M+57OyzmopiBIibRxQExCs1rF4Qqo0urnMF24rcgA=;
	b=fP4yEtVoWFjetgmkNwG6bgTmXr4f5heLhJ+SAoItwacPFkw+NpmRgcrwojJZd49ZiXOpCc
	QGO7Q4gnNjvX6wretNhfRvs2ddmGykrBbu3jlcCg1yXqpWAbldspd9S+hTO5D9vHVcW87m
	ulH1g/j2xyl2VtCzm10jDyZmxGDtD2M=
Date: Sat, 27 Jan 2024 00:21:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Lee Jones <lee@kernel.org>
Cc: Martin Kurbanov <mmkurbanov@salutedevices.com>,
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
Message-ID: <ZbQ-jKD_zhonHOCa@ucw.cz>
References: <20231207125938.175119-1-mmkurbanov@salutedevices.com>
 <20231207125938.175119-2-mmkurbanov@salutedevices.com>
 <20231221161011.GO10102@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221161011.GO10102@google.com>

Hi!

> > This led-controller supports 3 pattern controllers for auto breathing or
> > group dimming control. Each pattern controller can work in auto
> > breathing or manual control mode. All breathing parameters including
> > rising/falling slope, on/off time, repeat times, min/max brightness
> > and so on are configurable.
> > 
> > Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> > ---
> >  .../testing/sysfs-class-led-driver-aw200xx    | 108 +++
> >  Documentation/leds/leds-aw200xx.rst           | 274 ++++++++
> >  drivers/leds/leds-aw200xx.c                   | 649 ++++++++++++++++++
> >  3 files changed, 1031 insertions(+)
> >  create mode 100644 Documentation/leds/leds-aw200xx.rst
> 
> This interface is bananas.  Exposing an entire register interface to
> sysfs does not sit will with me at all.  When we add support to a sysfs
> class, we usually require it to be generic and work across all devices.
> Adding device specific interfaces is generally decried and to be
> avoided.  Don't forget, once we commit something to sysfs, it becomes
> ABI and we have to support it forever.

If you do git grep hw_pattern, you should get pointers to qcom-lpg
driver that solves similar problem, with interface that should be
acceptable.

Best regards,
								Pavel

