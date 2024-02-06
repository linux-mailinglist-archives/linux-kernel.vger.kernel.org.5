Return-Path: <linux-kernel+bounces-54664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF2D84B234
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E672838CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DA812E1EE;
	Tue,  6 Feb 2024 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BI/CKhos"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE012EBF3;
	Tue,  6 Feb 2024 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214389; cv=none; b=Al/mBOcCrFtcRO2Yn7ankCcVyKa2M2cnA3TFRcTxgRn462QAJLEFKEefUylzoPopF85WLe59wpo3MQRYSer72UIMvh8amDZ89dq3cJ7ksVPqHnF4QRz1Ao3YJOoKonRHWsrhsIeU4yZtKCUiGBQGJ2H+j8/SR3EYYaBOQEdjFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214389; c=relaxed/simple;
	bh=kqMo2mkEaV1uSbwgI1g5KgAxopmIWmq8uQN0eHbaI8w=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=omxOCiFTQqLL+VCokffkhp7Bpjt4JK15xVtflO4y2NOh27xOMYWYAyIkV0gHX1OHexoP3B2UofriRAWVvFwxF0MtBbcAzPW7o8efE0fnHinEsH9T1+4rscg92C4Gob2+HstwALKZ9lHXkIbwFV06nQcVtXQ/u6B3x9y0aRAWGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BI/CKhos; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5B5D40013;
	Tue,  6 Feb 2024 10:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707214384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYHYy9wM/XJWCBvUKP+eSh79QSZHlIijB5K8Zu/UezQ=;
	b=BI/CKhosTgEXVhWpl9iV4qjDtB08F2u86pXekaGVKk/DX5TY/qjmViVpsZYKTnUacdHRFs
	V0b227hFwI1b/xXybq7zJnTda5BsN83Rg6VZHfj8VyQn4rNaxTsih/FclM6YwQlSjQsXuJ
	3Jcwn8nQiqonmxlq3sDevEAxVf9g9Zh32F0DK4XSB13EyXJWLL0KmC+/G4LoQswtO6DWeS
	PReLv+IivCNS0ImjtBh2p0rK6N1p4ifPfpNLmFuTIMaT/T+JzACQa03UrMcp+R271jlBc5
	wSXx2Vt+8kDG2YeULq2yKE6jO+pMeRPIBUfBOefZWFYTbOEvJIHBESvKeREZ4g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Feb 2024 11:13:03 +0100
Message-Id: <CYXWZOJ7KLIC.27XVZMBQASH9O@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v4 04/18] dt-bindings: clock: mobileye,eyeq5-clk: add
 bindings
Cc: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Linus Walleij"
 <linus.walleij@linaro.org>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>, "Philipp Zabel" <p.zabel@pengutronix.de>
X-Mailer: aerc 0.15.2
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
 <20240131-mbly-clk-v4-4-bcd00510d6a0@bootlin.com>
 <f6e5b748-17c4-4de1-be42-f79155be21cb@linaro.org>
 <CYTOEGEI34JQ.36CF09LNJFQHS@bootlin.com>
 <4e9ce766-602f-4b75-8c25-48da4d22051e@linaro.org>
In-Reply-To: <4e9ce766-602f-4b75-8c25-48da4d22051e@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 1, 2024 at 12:00 PM CET, Krzysztof Kozlowski wrote:
> On 01/02/2024 11:38, Th=C3=A9o Lebrun wrote:
> > Hello,
> >=20
> > On Thu Feb 1, 2024 at 9:58 AM CET, Krzysztof Kozlowski wrote:
> >> On 31/01/2024 17:26, Th=C3=A9o Lebrun wrote:
> >>> Add DT schema bindings for the EyeQ5 clock controller driver.
> >>>
> >>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> >>> ---
> >>
> >> No changelog, tags ignored, I scrolled through first two pages of cove=
r
> >> letter and also no changelog.
> >=20
> > In this case we fit into the "If a tag was not added on purpose". Sorry
> > the changelog was not explicit enough. In my mind it fits into the
> > first bullet point of the cover letter changelog:
> >=20
> >> - Have the three drivers access MMIO directly rather than through the
> >>   syscon & regmap.
>
> ... which I might not even connect to binding patches. I see only one
> entry regarding bindings in your changelog, so I find it not much
> informative.
>
> For the future, please state that you ignore tags for given reason.
>
> >=20
> > That change means important changes to the dt-bindings to adapt to this
> > new behavior. In particular we now have reg and reg-names properties
> > that got added and made required.
> >=20
> > I wanted to have your review on that and did not want to tag the patch
> > as already reviewed.
>
> Makes sense, but how can I know it? Other people often ignore the tags,
> so safe assumption is that it happened here as well.

I'm prepping a new revision. Should I be taking your previous
Reviewed-By tags in? You sent them for the previous revision, do the
changes in this V4 look good to you?

Thanks Krzysztof,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

