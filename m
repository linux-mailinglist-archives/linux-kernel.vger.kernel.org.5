Return-Path: <linux-kernel+bounces-75293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A1B85E5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222EC285C64
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C18A85951;
	Wed, 21 Feb 2024 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l8P/izgb"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168F85276;
	Wed, 21 Feb 2024 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539990; cv=none; b=lV84an5gWAbMOL/14845S+pgHqwIezzWyEn9deOr/BK47rX+yLKXwYjFJ0mNcrvp2uf+TrPHFxwyFxpSVZJziP2fBM06sWsFIjpm0QYYApr/WMu9QjxlJ8qn1KgJiKUd2v/ReNT2NChrO9N/zmV1G4Md3lKudibQE2VNPi24ah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539990; c=relaxed/simple;
	bh=E7HIVIYw9PMi5QMBxw2IJg5p8jMgQRCuXUWltV6pQ0Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=oXjppstHWYpHSlb6j9GY5343TKr2lHm31QB8IflzYVhAFMaNZ1blYePOLYcSFcjoF9pWFFVYdY9khXtrYkWtLizmolEhkpFd2gpAy10J/UDGj6RnFEsoDIf/w4YwRqEw7/ZLMYDUYTHG4aqQruDtNjGBSxfFNgeFHdmJgbHMQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l8P/izgb; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 18ED6240004;
	Wed, 21 Feb 2024 18:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708539986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E7HIVIYw9PMi5QMBxw2IJg5p8jMgQRCuXUWltV6pQ0Q=;
	b=l8P/izgb8ygf5ZaGOoHf0/UazlH9Gp0XRLBBIyfkeGYbShSxOdMHU8JkmxkCAjSqJdRfiP
	nJ1HYErtWHkQAGVX7DpnvU6i1vs1UUUX3GlP7JyR8dCYoysmJ1iE4lT1VtoIOsfelMerYU
	WhwtJtq8WKKk6OGpaUSF2TSAIHsnXUbqNdc2J68Yg5Cd5KtzJ+ony1rBTTgdwdQvKfhaAT
	prfq5ilQgLQ4ngoaqjGrjG8jBKJ8dl2Tqt6amCbJ4KKPwdjaQPECSSRhDJ0f3H1ixbDXF8
	yb9vBauxfMPbbNA26OuTJYnbhN4+JfCbhBKkTEHEq2p267rv4ormy6szldQuFQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 19:26:24 +0100
Message-Id: <CZAYVLDVTRM8.2JLY1V2J7U7PB@bootlin.com>
Cc: "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, <linux-mips@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>, "Rob Herring"
 <robh@kernel.org>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Linus Walleij"
 <linus.walleij@linaro.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v6 05/13] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl:
 add bindings
X-Mailer: aerc 0.15.2
References: <20240212-mbly-clk-v6-0-c46fa1f93839@bootlin.com>
 <20240212-mbly-clk-v6-5-c46fa1f93839@bootlin.com>
 <CACRpkdYNe=2w10uB1mUgs2Lgg1TRiSF=bOa45OH5Lcz6+G6FEg@mail.gmail.com>
 <CZAVY4NPY4H6.1KJI4UPRUM21C@bootlin.com>
In-Reply-To: <CZAVY4NPY4H6.1KJI4UPRUM21C@bootlin.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Feb 21, 2024 at 5:08 PM CET, Th=C3=A9o Lebrun wrote:
> On Wed Feb 21, 2024 at 2:38 PM CET, Linus Walleij wrote:
> > On Mon, Feb 12, 2024 at 2:44=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@b=
ootlin.com> wrote:
> > > Add dt-schema type bindings for the Mobileye EyeQ5 pin controller.
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > I tried to just apply the pin control patches to the pin control tree, =
but I
> > can't because of all collisions in MAINTAINERS.
> >
> > If you move all MAINTAINERS business to the SoC-wide patch I can
> > apply the pin control stuff directly, but maybe you wanna keep the
> > series together and merge on an all-or-nothing basis?
>
> I'm all in for making the series slimmer over time. MAINTAINERS changes
> will be moved.

I did not have any existing patch to which to move the MAINTAINERS
changes, so they were all put in a new patch. Hope this fits! Please
tell me if something more appropriate could be done. See the patch in
question:

https://lore.kernel.org/lkml/20240221-mbly-clk-v7-10-31d4ce3630c3@bootlin.c=
om/

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

