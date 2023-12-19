Return-Path: <linux-kernel+bounces-4866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AEE818316
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F905286416
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8021A111BC;
	Tue, 19 Dec 2023 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RD2CkaEn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F413AD5;
	Tue, 19 Dec 2023 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDF98240012;
	Tue, 19 Dec 2023 08:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702973546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQdUFyLeNJUwSBurp25+RwofnZarRLxRivzumNAHgLw=;
	b=RD2CkaEn/GG9QxTYaa0dWcy6UlNPS5YXoBiXAWMwaFltIhdneTFchqmrllZwjquGRNKBVa
	RXLuk1LY9NtnuMY1sO0q+3L2JgQlQ09b5tLMWEt4p+CEtsIfVeVzh2hxDWq3QaW14DcVua
	G3RM5wdEOZp7SLHR8Ii0LoF3LlEFi83qaccyzXfivV8ed0QDu9QeeAEGNjHl6GYFM3EAV4
	/+AjQM0KUdsxQYFB31hCcqXvoJxXbCB8PO2C7Oh5Y9lcaN40/ZoI8EQCTt1zbeaWhkB420
	QyYheZGGYiPCpEW7xplaotEH62ULXemTci1tXDqN5+q+R078QgB5ux51ARZ/0g==
Date: Tue, 19 Dec 2023 09:12:21 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, Mark Brown
 <broonie@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, pratyush
 <pratyush@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 sbinding@opensource.cirrus.com, Lee Jones <lee@kernel.org>, james schulman
 <james.schulman@cirrus.com>, david rhodes <david.rhodes@cirrus.com>,
 rf@opensource.cirrus.com, Jaroslav Kysela <perex@perex.cz>, tiwai@suse.com,
 linux-spi <linux-spi@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, Michael Walle <michael@walle.cc>, linux-mtd
 <linux-mtd@lists.infradead.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 michal simek <michal.simek@amd.com>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, alsa-devel
 <alsa-devel@alsa-project.org>, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v11 00/10] spi: Add support for stacked/parallel
 memories
Message-ID: <20231219091221.30b1f167@xps-13>
In-Reply-To: <1953466568.133535.1702937420979.JavaMail.zimbra@nod.at>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
	<1953466568.133535.1702937420979.JavaMail.zimbra@nod.at>
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

Hi Richard,

richard@nod.at wrote on Mon, 18 Dec 2023 23:10:20 +0100 (CET):

> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Amit Kumar Mahapatra" <amit.kumar-mahapatra@amd.com> =20
>=20
> > This patch series updated the spi-nor, spi core and the AMD-Xilinx GQSPI
> > driver to add stacked and parallel memories support. =20
>=20
> I wish the series had a real cover letter which explains the big picture
> in more detail.
>=20
> What I didn't really get so far, is it really necessary to support multip=
le
> chip selects within a single mtd?
> You changes introduce hard to maintain changes into the spi-nor/mtd core =
code
> which alert me.
> Why can't we have one mtd for each cs and, if needed, combine them later?
> We have drivers such as mtdconcat for reasons.

The Xilinx SPI controller is a bit convoluted, there are two ways to
address the bits in a memory:
* Either your extend the memory range with the second chip "on
  top" of the first (which would typically be a mtd-concat use case)
* Or you use the two chips in parallel and you store the even bits
  in one device (let's say cs0) and the odd bits in the other (cs1).
  Extending mtd-concat for this might be another solution, I don't know
  how feasible it would be.

Maybe these bindings will help understanding the logic:
e2edd1b64f1c ("spi: dt-bindings: Describe stacked/parallel memories modes")
eba5368503b4 ("spi: dt-bindings: Add an example with two stacked flashes")

However I agree the changes will likely be hard to maintain given the
complexity brought with such a different controller.

Thanks,
Miqu=C3=A8l

