Return-Path: <linux-kernel+bounces-75053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA7085E239
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD431C23AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A0881ACD;
	Wed, 21 Feb 2024 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gGYFQU56"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C1D80C19;
	Wed, 21 Feb 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531032; cv=none; b=Gi7uuJ8B0+oPKmwyr0Zk1BEZ0CPXSuia2e68i9J59y1oKvxTw92MwujDVtpzGTNTCFUYqqsZ2GjxmEeovTKDeTkuG1b/Y3n1QxtU9h1y4ApQ2tFTaAwCkB/FDCau0twfVvoTZ6KY/9sZIBambxBbLi8DzmhRHHcJ/nFX5VLtj24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531032; c=relaxed/simple;
	bh=oFTqTVOhHyDJ5iYE8i8hwXVq+ixGFDMjQjac4S4aVmQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=t0swwV0q1qSEiXdZf7fH73uUZqlNZK91hi5y551hYEyuPLLMjQQGUkZUilABcXLCGJTDt0GoGSwpRM6HdOJBI//czC/A0XgDgJSFRQOeE4OP1CSQamg4qgVDifoYsYS+dH3glkf4b4lQXC84e0aYfFAFI3StEWUTOD0jNz/3cJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gGYFQU56; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2B85C000D;
	Wed, 21 Feb 2024 15:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708531027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZfXtDRePUcMFundzZXNFuj+fqBl14FactsX+t+og0A=;
	b=gGYFQU56WVJfwGdXAyVvjtXT0qNdEkBQSjeig/nT1NCNXHpjmwTTlMZm/91p2oVbqfvlCy
	Ksl62koMCFbE9sOvKBQCLHCLBT7RSAM1S83SYeHq8nGNqGRs7RpfbgmJ+S5wE7yBFulkRS
	ZhTBCPDR+JvIl/fB2WEG0xQzNv1ckP4phguN5HcYYFG3WE3ZI+tZZBcy6CvhXZj0aENgwp
	JnNn09CQlZgOxgPavln5KGAFVvADqKYcmDDQUG+Ijstk4bZVJiwOViE4s++YVGAlNI5lQN
	tHZmhzqdAZqrn00ULmx/netaZlbaFvaLLFLJfdoysx7j9Kmd/LryfAKFy+ME+g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 16:57:04 +0100
Message-Id: <CZAVP96SON5X.2KDT24P963WZ9@bootlin.com>
To: "Bartosz Golaszewski" <brgl@bgdev.pl>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 13/23] gpio: nomadik: fix offset bug in nmk_pmx_set()
Cc: "Linus Walleij" <linus.walleij@linaro.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>, <linux-gpio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mips@vger.kernel.org>,
 "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
X-Mailer: aerc 0.15.2
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-13-f88c0ccf372b@bootlin.com>
 <CAMRc=MdwAQUgc=LP45r-j0UCtN1gzPg9_y3hrbQhCyH91D=W-g@mail.gmail.com>
In-Reply-To: <CAMRc=MdwAQUgc=LP45r-j0UCtN1gzPg9_y3hrbQhCyH91D=W-g@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Mon Feb 19, 2024 at 4:54 PM CET, Bartosz Golaszewski wrote:
> On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
> >
> > Previously, the statement looked like:
> >
> >     slpm[x] &=3D ~BIT(g->pins[i]);
> >
> > Where:
> >  - slpm is a unsigned int pointer;
> >  - g->pins[i] is a pin number which can grow to more than 32.
> >
> > The expected shift amount is a pin bank offset.
> >
> > This bug does not occur on every group or pin: the altsetting must be
> > NMK_GPIO_ALT_C and the pin must be 32 or above. It is possible that it
> > occurred. For example, in pinctrl-nomadik-db8500.c, pin group i2c3_c_2
> > has the right altsetting and has pins 229 and 230.
> >
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> Maybe add a Fixes: tag and put it at the beginning of the series so
> that it can go upstream earlier as a fix?

I'll see how it works out because the fix depends on helpers added in
this series. I'll be reworking that.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

