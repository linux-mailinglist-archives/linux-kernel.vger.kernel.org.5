Return-Path: <linux-kernel+bounces-75286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7077985E5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110561F28335
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820AF86AC3;
	Wed, 21 Feb 2024 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YCGN+mur"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E586646;
	Wed, 21 Feb 2024 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539848; cv=none; b=KvQ4BUqL6BxL2DtIaB00NIHclMpwRh5183A15BOWT7W++OIndQKY7tXRClSs4CZoZ6teh++zmRGcEHIX4B4k4NhdAWG88Y8JlvaOi1H2Zvhpf1U8mI8epag3e/FM8phNVQTsNXAdQe2k4J3is6p0xRRQOYf1pOoMxamqonbG020=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539848; c=relaxed/simple;
	bh=yjb4Owa0Esi7QyGu8TKTmbHLEH85uNcdfz6jVPWgP+o=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=ToQQ0jt47aenWCKFPOp2ITlquAnXu93U8GtFdrqnDpQPSJzZN9qzjwk329msa56gf3rURmsKjePLE2/ZCF6gI6SOfIq5dJElrAvTSy0yLz9zyluzvUhdcmO70+c4dtmmOjxEl0Twmsu2sEVrajDejpMBsEeAshwPbk4Sfuokdl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YCGN+mur; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70F511C0007;
	Wed, 21 Feb 2024 18:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708539845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/dwbAwEBir0o+55RLXnFG44DT+GaykMzVR3AlyYmPs=;
	b=YCGN+murJd2C/ZBC6FdQnUQfJGiX0tNlkAb/yTsbPzSiyXYuJoxW36bTP+41DH5ePZ5q4X
	cboFCHzlC1BWTRafCkI7gAudhlHK8kcfCyDTcFIbdAy0yWWLejrAIkV79latcoSX8i7FdQ
	/2z4Gh+3erwUoob2uN8urE5EYsVXiwdl8Yn1wDn+JybzH5IFZRb1CsmS+QAwKntTyejluy
	Wm+9WSmXDuJreX8JWIf8QPcl7YucCwDSo2WxbdNiuuppPiJ52nJIsPjba4mvIMu+6n9MbH
	KDqZmjJ3xmIIpWYQwadVPJouSmeKNOVEmrdamsN67Hrn6cRbdJwPcRV1JIt4Tw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 19:24:04 +0100
Message-Id: <CZAYTSVONT90.2FE905FRDMZBV@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v6 09/13] pinctrl: eyeq5: add platform driver
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
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Linus Walleij" <linus.walleij@linaro.org>
X-Mailer: aerc 0.15.2
References: <20240212-mbly-clk-v6-0-c46fa1f93839@bootlin.com>
 <20240212-mbly-clk-v6-9-c46fa1f93839@bootlin.com>
 <CACRpkdY5QgdtsHLs9QsVQ_zYRZBqdkCiWdkfTvNcw8WgyAfTbw@mail.gmail.com>
In-Reply-To: <CACRpkdY5QgdtsHLs9QsVQ_zYRZBqdkCiWdkfTvNcw8WgyAfTbw@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Feb 21, 2024 at 2:41 PM CET, Linus Walleij wrote:
> On Mon, Feb 12, 2024 at 2:44=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
>
> > Add the Mobileye EyeQ5 pin controller driver. It might grow to add late=
r
> > support of other platforms from Mobileye. It belongs to a syscon region
> > called OLB.
> >
> > Existing pins and their function live statically in the driver code
> > rather than in the devicetree, see compatible match data.
> >
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> > +       ret =3D devm_pinctrl_register_and_init(dev, &pctrl->desc, pctrl=
, &pctldev);
> > +       if (ret) {
> > +               dev_err(dev, "Failed registering pinctrl device: %d\n",=
 ret);
> > +               return ret;
> > +       }
> > +
> > +       ret =3D pinctrl_enable(pctldev);
> > +       if (ret) {
> > +               dev_err(dev, "Failed enabling pinctrl device: %d\n", re=
t);
> > +               return ret;
> > +       }
>
> You could use dev_err_probe() here which suppresses -EPROBE_DEFER
> messages, but I'm not picky, just mentioning it.

Well, I've followed your suggestion in the v7 revision. Thanks!

https://lore.kernel.org/lkml/20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.co=
m/

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

