Return-Path: <linux-kernel+bounces-96895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575658762B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8722FB21ABC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3494555C3A;
	Fri,  8 Mar 2024 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="le04kcLe"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E82263A;
	Fri,  8 Mar 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895998; cv=none; b=Zx4Y6WPFq6nDHjMU4uprCFIKsIJ1nGCc1W35PT8D3UKIZxRQWLqjy/UJB5SEfYGmcLYefruIY8zYwD3SnbXASDfBtTIyjvUaxcm7SBa9V8zxsjuioJ2mL4EgMAHNFCQe1RchL9N8n06y+8lnKM6q1qibFLmLTprWz+cGrZs+ChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895998; c=relaxed/simple;
	bh=Dlic2xdJ/4Lp/BC+kW2Kll6aPOhh2E5AospJCmpw9rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms7A7T8ei6LMf1/VodIkXdB6/l6tdpqWeb1SkJ1+O25M3ZTyL7tivZNUKOtmG6DMBGMZ4pH0TC+gZkn/slHEXbmMwKYzeLOQ3uJzJIAnqI20+p3u4DfFHd+arFU3lYt2BgBGZlknM1O8p+VsU89DidmvOx+DqCiOWN90HCseJRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=le04kcLe; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 881F220005;
	Fri,  8 Mar 2024 11:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709895994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yDokQE8eDevsZTVbL+J84sEhjfKF7F3KjE3ssol2SRA=;
	b=le04kcLei1b9u0cNrGSc+7mmEjWxFYNIWNuBCBWBXInJiPoZ6dlCTkQt7rZqKgROC6JuwV
	xrwL/JvruFTsA/EevlSdi9X0Fvfu8hJlOWo7p9vPEYiYAFt4JX/35zlsRJIlNsayoRcgQc
	eYYJoL5T1c1Khei+Lvc93IBsTk3raSIrSto5PP/M6Yeti8PwNRwQ+dngj658YOBDr+TJDr
	tipL8rnYTgA6Vbb2FoMlDb6i/3dj9kXjrrJQmMdpwgIMVvL32/awV7ykHIAXn1MaZZguoF
	ckUJ1lR13iP4H5aZoXjcC5K4QnWmh1DJv1rjvZ8InmYk1olzO8UVjmicP08dzQ==
Date: Fri, 8 Mar 2024 12:06:33 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	linux-rtc@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Eddie Huang <eddie.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in ARM/Mediatek RTC DRIVER
Message-ID: <170989597157.2150728.2892505588638437856.b4-ty@bootlin.com>
References: <20240301145907.32732-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301145907.32732-1-lukas.bulwahn@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Fri, 01 Mar 2024 15:59:07 +0100, Lukas Bulwahn wrote:
> Commit e8c0498505b0 ("dt-bindings: rtc: convert MT2717 RTC to the
> json-schema") and commit aef3952ec13f ("dt-bindings: rtc: convert MT7622
> RTC to the json-schema") convert rtc-mt{2712,7622}.txt to
> mediatek,mt{2712,7622}-rtc.yaml, but misses to adjust the file entries in
> MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: adjust file entry in ARM/Mediatek RTC DRIVER
      https://git.kernel.org/abelloni/c/1e60ac6b8b57

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

