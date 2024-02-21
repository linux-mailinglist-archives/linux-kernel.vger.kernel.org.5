Return-Path: <linux-kernel+bounces-75094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC5B85E2F8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E7E1F24281
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEB38174B;
	Wed, 21 Feb 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ojElP1EM"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8313A1A2;
	Wed, 21 Feb 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532550; cv=none; b=X/l1Pv2VT92p+21zkp92TYZ01Jy93ScoeFUuCWhOVAqKFM+gFBa/XJ60NgSXEW9P+xEHWVs2LFCjkKKQSrU7T9b1Cp1tZcegZaaQ2mRoY9bGCTxca0YdtzFpdUuX4Jrmfb3L3OBY+c/2coiISIYcsx+uCvyLEfAn5iGDChEyqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532550; c=relaxed/simple;
	bh=kiiMrG6mntXHh6iDBqWOevebD5aCEfw6RRIXVCezYaY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=iLTXi/35hNx4AMb/4oc5HJrwNd2xFtC5WS2971tbS4L0CZPuT7dWZiJ668NyZFOikkIV/nVtpVpAfAFGWFG9pIPg3CAKgeC01oLTxNiwrIRKYYWZEFcY+Zk/QNZdRHUR7s3i3A0gY2iURosDy4Q2Au4hqK9k+nBeB4rUQVJAxuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ojElP1EM; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F42F20009;
	Wed, 21 Feb 2024 16:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708532546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYNF6aBAFXnBwLIFV8DYWQPUG0yyBkNdFICAoB9FzHE=;
	b=ojElP1EMF86PODLDP9T4uBAGLfHZ1XkMqIJ3TaYZ+/sPvFdYH/gFLxXGAxPKV8NptsQnTm
	ne9p4VweZ0loVzt0Zxn9ZiI6AoEWxplApr8d3wULM3fpKnDLDrVwznE0qzkPi+DL97wyqp
	SDdPRyCGzk78gi88IJEK4ihGSwIVbuwsnSGU3Y/6bpNZIA9vxndaJXfUHFGVMvVSR2cKcU
	R7WBtOEJywKiZMahVoID7HQWx4ScEF838i1TO9vi3B2+kRwsFRNIMdgbFNrlGU2JJER12O
	kE4NnVSnabdhLkqzuN/FD7goeVkrZnRuu5J6waTx33AtumU8mre+3lTeJCobcQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 17:22:25 +0100
Message-Id: <CZAW8NNS98TB.18RASC15YIRNB@bootlin.com>
Subject: Re: [PATCH 18/23] gpio: nomadik: support mobileye,eyeq5-gpio
Cc: "Bartosz Golaszewski" <brgl@bgdev.pl>, "Rob Herring"
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
To: "Linus Walleij" <linus.walleij@linaro.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-18-f88c0ccf372b@bootlin.com>
 <CACRpkdYb4V5EouMBYRRrZvLT1v6zKEtjHGPAs5orDKoo6dz6nA@mail.gmail.com>
In-Reply-To: <CACRpkdYb4V5EouMBYRRrZvLT1v6zKEtjHGPAs5orDKoo6dz6nA@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Feb 21, 2024 at 2:45 PM CET, Linus Walleij wrote:
> On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
> > We create a custom compatible for the STA2X11 IP block as integrated
> > into the Mobileye EyeQ5 platform. Its wake and alternate functions have
> > been disabled, we want to avoid touching those registers.
> >
> > We both do: (1) early return in functions that do not support the
> > platform, but with warnings, and (2) avoid calling those functions in
> > the first place.
> >
> > We ensure that pinctrl-nomadik is not used with this STA2X11 variant.
> >
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> (...)
> >+       bool quirk_mbly;
>
> Compulsive abbreviation? I would just rename it:
>
> bool is_mobileye_soc;
>
> Nevermind the long name, it makes it crystal clear for readers
> what is going on. (Rusty Russell's API naming guidelines.)
>
> With that changed:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Makes complete sense. This is old heritage from my initial prototype
that should have long gone disappeared.

Thanks for your feedback & reviews!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

