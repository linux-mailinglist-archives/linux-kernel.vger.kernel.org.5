Return-Path: <linux-kernel+bounces-140658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD178A1762
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B5FB2473C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84FC8C7;
	Thu, 11 Apr 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Woy0/ww9"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0247BD51D;
	Thu, 11 Apr 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846071; cv=none; b=P2Hwn/z3qx1Iu/hMP1bAyBe4MCWp0DcE+kcJ8Zb+9A4ZmYzCKCwW7IJ5rR+StIAsbUV0qys+eBSjkWYseKAa3fMToqB2k2SUdmvTCC95py9+zWfNbUb9d68LnRFLOGYXck/5mySI2poKiV+t3A8kM7HrcngfJWonFkQpedbBtpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846071; c=relaxed/simple;
	bh=BPWvX7FMnfSHBT1g9xfH5nN+hbcEQ+/3zdHIQgPG0LU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=RLNYD9256/JvB6RoQDH+QxkcGtc3158xpg1z5+BRu7LLHu8naO9z+PWWNvuyLKPkc/mJwGUXVCFw+cBpycr6U41YOO+yl4DXru1Yv7wwKWgZ2JVItVMzbdrYHhyEy/EHvtZzJU/AZ6WGzZKK+TtSwIIUDKZWJh2yiqiA6PMQtgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Woy0/ww9; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16DB5FF806;
	Thu, 11 Apr 2024 14:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712846060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqUHfFkbPFXkINPYBOMZ3yos79n09w01Malpi4hMiNk=;
	b=Woy0/ww92LZI/zvaNa6V/i/nNLiYIj1d7++rqOyTjF9of0Yd5gY7fGfDZUGr4nJDspWaPl
	SjKzDrjNny9O7dQz96809N9VX7fDrC293nMfTFLZoaP9i3Z01K08JXQTZfz8J/DBrM+qRI
	wLE16x8ARJBceC1RTGvZkAmf0j5KTh0su1TZa+Q4uW6em23D40841bYWZfY51ld9hy/CaF
	HTRwzU+Un/asZ88OgAuQTpNXq/1moG32vTSyP2C/JFSR9YaVErA9MoD0y1JE2/ywcnlTfX
	U+Rwi9qALTB7M4ioEN2/OK8QQ/5ynuh9UtY5OPL/CmeYQgiOOzqYn6BQT+jrTg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 16:34:18 +0200
Message-Id: <D0HD94HI3W7W.3KLAW6WFIN6ZE@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 08/11] MIPS: mobileye: eyeq5: add OLB syscon node
Cc: <linux-mips@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>, "Linus
 Walleij" <linus.walleij@linaro.org>
X-Mailer: aerc 0.15.2
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
 <20240410-mbly-olb-v1-8-335e496d7be3@bootlin.com>
 <faa0769f-bd5e-4c6b-9f61-1a369830ad28@linaro.org>
In-Reply-To: <faa0769f-bd5e-4c6b-9f61-1a369830ad28@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Apr 11, 2024 at 8:15 AM CEST, Krzysztof Kozlowski wrote:
> On 10/04/2024 19:12, Th=C3=A9o Lebrun wrote:
> > The OLB ("Other Logic Block") is a syscon region hosting clock, reset
> > and pin controllers. It contains registers such as I2C speed mode that
> > need to be accessible by other nodes.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  arch/mips/boot/dts/mobileye/eyeq5.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dt=
s/mobileye/eyeq5.dtsi
> > index 6cc5980e2fa1..e82d2a57f6da 100644
> > --- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> > +++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> > @@ -100,6 +100,14 @@ uart2: serial@a00000 {
> >  			clock-names =3D "uartclk", "apb_pclk";
> >  		};
> > =20
> > +		olb: system-controller@e00000 {
> > +			compatible =3D "mobileye,eyeq5-olb", "syscon", "simple-mfd";
> > +			reg =3D <0 0xe00000 0x0 0x400>;
> > +			ranges =3D <0x0 0x0 0xe00000 0x400>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
>
> Do not add incomplete node. ranges, address/size-cells are incorrect in
> this context and you will have warnings.
>
> Add complete node, so these properties make sense.

I'll squash all four commits into one. For reference, commits are:

 - MIPS: mobileye: eyeq5: add OLB syscon node
 - MIPS: mobileye: eyeq5: use OLB clocks controller node
 - MIPS: mobileye: eyeq5: add OLB reset controller node
 - MIPS: mobileye: eyeq5: add pinctrl node & pinmux function nodes

This means two things: (1) it won't be partially applicable and (2) it
will make one big commit adding pins and editing clocks.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


