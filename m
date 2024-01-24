Return-Path: <linux-kernel+bounces-37729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4109F83B482
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB41A1F24CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27AC135413;
	Wed, 24 Jan 2024 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hVQ8yHbJ"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA3F135A42
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134287; cv=none; b=VQV2ud1tgRt6xkg8jkHAZeJpS89VIQMIMSAS2lHVEWZ4SXXWqchc3V1lv4Nle63DLNizDhsfnpSUVORZVJq4OmtDuXXL73anyg9gw9eu/77m/CvzAjPJUm+z7oVXeWfWW4hHXjnDQzcSiF7YHb7KZ4b27de1hI3vLd878rmVLFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134287; c=relaxed/simple;
	bh=snqluUj8YXe23n5Y2Bps+oBqaBBXlWni7cujNtHcNQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K53p2blvrxbyMLYq19L8aEmHVWfKgqwBiaI8xfFcaEVNQSz9/iipA0w62/KrWZwgD3qxg/Pgdx/fC8xqCjkdleR+BZi1Hg2djtFZeeVAA+KttuXeznFjqzRqftGpum1GrHTv5430/Bli9UuMb2smhz9N8Z4HM5RRnOAiy2UeJYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hVQ8yHbJ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 99E1B40002;
	Wed, 24 Jan 2024 22:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706134283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snqluUj8YXe23n5Y2Bps+oBqaBBXlWni7cujNtHcNQk=;
	b=hVQ8yHbJQMOoWV/QXsWrhrKOpEp7VHXGeWww4Y4+q217L3mfMDc8Gp5FmdePqAwQ5HDwP4
	zghkCy0qctP0EdVP48tXWDUizvlsb/aeRQ/bMSqRof5L0tyBaIirqUSLxAhkP/WinTH4XY
	KENWw1sHbjmgMSARqalQLDmjx1xCfvkeblb3WUbZAqNhbcINlnndIO7aaeEsVFDgna3i88
	wYIjx0cdy7sLVpRPZ+oRnVCKG/f7SoMOOyhc8x7v8VIQheMJ0pm4FdlvAA0ptJ4T9LZeGz
	iz9RTBH/H8x+nQpM9klnFlPyGM77wL6JqJ3FtXrgz37Bx+JKIOQQx46IQexYFw==
Date: Wed, 24 Jan 2024 23:11:20 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Srinivas Kandagatla"
 <srinivas.kandagatla@linaro.org>, regressions@lists.linux.dev,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, "Chen-Yu Tsai"
 <wenst@chromium.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 asahi@lists.linux.dev, "Sven Peter" <sven@svenpeter.dev>, "Michael Walle"
 <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: include bit index in cell sysfs file name
Message-ID: <20240124231120.562f06f3@xps-13>
In-Reply-To: <1d13250c-e48b-4e31-b449-5b54837a0d40@app.fastmail.com>
References: <20240122153442.7250-1-arnd@kernel.org>
	<20240124182256.776c164b@xps-13>
	<1d13250c-e48b-4e31-b449-5b54837a0d40@app.fastmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Arnd,

arnd@arndb.de wrote on Wed, 24 Jan 2024 20:49:53 +0100:

> On Wed, Jan 24, 2024, at 18:22, Miquel Raynal wrote:
> > arnd@kernel.org wrote on Mon, 22 Jan 2024 16:34:10 +0100:
> > =20
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>=20
> >>=20
> >> As far as I can tell, this is a problem for any device with multiple c=
ells on
> >> different bits of the same address. Avoid the issue by changing the fi=
le name
> >> to include the first bit number. =20
> >
> > There is only one bit number right? We are talking about byte offsets
> > so this value can only range from 0 to 7? If we understand each other
> > correctly then why not, I'm fine with the extra ",0" thing. =20
>=20
> On the Apple M1, the nvmem registers are 32 bit wide, so the
> bit numbers can go up to 31. I can imagine some system using
> 64-bit registers, but it's unlikely to be higher than that.

In this case we will soon or later have a problem again. Can we include
the full offset of the bit and not just the first digit?

Thanks,
Miqu=C3=A8l

