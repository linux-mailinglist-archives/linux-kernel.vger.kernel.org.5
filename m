Return-Path: <linux-kernel+bounces-47980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CC184559F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94761281E61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EF615A490;
	Thu,  1 Feb 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L1M7ktTa"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4152E2747F;
	Thu,  1 Feb 2024 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783923; cv=none; b=bV51MDD1AC720ru+U+jw3w4EZh9KIox0NQdLl9UHCVwdvigFAs6Z22Y9sIcSdWj4xiOX6dEU48uzdlbsosgifMOC4zBtv+RQMCna5aNGBUXyymUtJnVKFowRYOCX4tnNq0tvbopEQbRlCdYyUrkGTpEfwIbOlyAsJntoZo+q+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783923; c=relaxed/simple;
	bh=9dO6Oej2KgYjkvAzqv58BDV8rSpNHuXwrckSqS3XlMc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=TYR9tHMyTS++wyIP2GWT1g8Yex0fw3QRXHknu2DoiZbk5KOa8V8S7os7ddyLw92QYugkb/GjSHv6utRboCCA218nZg+5B+NBVw5amo/k3CmBSCp4vlqg+00xloAnU3KD0tLZl/ROUINGlEObm8MlC4FRutGip+lwxvDBUl6a0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L1M7ktTa; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E07EFF812;
	Thu,  1 Feb 2024 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706783912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCjekKQATy7QigT3ZYZ4Fxvzy/254wA5JrrgSgewDR0=;
	b=L1M7ktTaycn0uGbfShyQ/9qgi0r7KX5YamwJgP1jwQjtBt1hlJq06OX61GV98LbMO7C3tw
	B9SFMGFDBTwdVP/6jpcSHdTGQhLK+gupoPbFX3i04QWTY/+N8Er1dxb0vnwzU9fGGLtltx
	ST5sH8vHqUZY53ntk8FKCnTeASX1qL9UilrNS9u5Oxk0WpP7aE4OKd/QRBEANeoPR+1RWM
	qkqcb0PhBhSbCC1+hac4xIlIGxFqf4T2BrmYOAZbD/Y4qlypBlyLkfGfr1OJiEgbBF56aX
	Aoh2JaqHuyviMFWthg4sH2cbNCGHiYFzAn3Eu+6bBwx42UDeoHaGTuot9H2h/w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Feb 2024 11:38:31 +0100
Message-Id: <CYTOEGEI34JQ.36CF09LNJFQHS@bootlin.com>
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
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v4 04/18] dt-bindings: clock: mobileye,eyeq5-clk: add
 bindings
X-Mailer: aerc 0.15.2
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
 <20240131-mbly-clk-v4-4-bcd00510d6a0@bootlin.com>
 <f6e5b748-17c4-4de1-be42-f79155be21cb@linaro.org>
In-Reply-To: <f6e5b748-17c4-4de1-be42-f79155be21cb@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 1, 2024 at 9:58 AM CET, Krzysztof Kozlowski wrote:
> On 31/01/2024 17:26, Th=C3=A9o Lebrun wrote:
> > Add DT schema bindings for the EyeQ5 clock controller driver.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
>
> No changelog, tags ignored, I scrolled through first two pages of cover
> letter and also no changelog.

In this case we fit into the "If a tag was not added on purpose". Sorry
the changelog was not explicit enough. In my mind it fits into the
first bullet point of the cover letter changelog:

> - Have the three drivers access MMIO directly rather than through the
>   syscon & regmap.

That change means important changes to the dt-bindings to adapt to this
new behavior. In particular we now have reg and reg-names properties
that got added and made required.

I wanted to have your review on that and did not want to tag the patch
as already reviewed.

>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/su=
bmitting-patches.rst#L577
>
> If a tag was not added on purpose, please state why and what changed.

As an aside, what's your preference on location for this information?
Cover letter changelog? Following '---' in the specific commit message?
Somewhere else?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

