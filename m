Return-Path: <linux-kernel+bounces-47967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD284556B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229651C22C2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFED43EA74;
	Thu,  1 Feb 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="djNXr9rO"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0CB3A1BB;
	Thu,  1 Feb 2024 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783573; cv=none; b=TdEkZHwhZAqR8ohXue1O36CxceMd2Wd6hrzEHxcPgZBleZuLdWqhrXEIOqlpOJvJYE0yCFMJMGJ0LvVXpNnvVpdhbcu5lBKwhRF4o9RBBNjWUkCyfXnrkZdwzl2YOQMtmjW2+TreEWndP1r5UGRs8aYBSdLs5DwcxtPeM0kWvEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783573; c=relaxed/simple;
	bh=TgTbXs3zXQgsCRHs+2nScZSazTQCoWxdSLvuVQys3Ng=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mMlfcIA4qzQ72PG9RI9gWicr2YfiJZDpEGZ9XomGQyHMkUdlWMK7zF4ciJY0xIZHWTERgP5MfWdcUwrovjx5QTY/MHj7G+J/0FcUoaknotwSzMz24ksCjG8prxATIPrOwr/WTj3L34GWluhXrcmRWB6U/mT4XQyliwgAclJfgac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=djNXr9rO; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6E4D440011;
	Thu,  1 Feb 2024 10:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706783563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nh2ckVW/G7bltpuqgL5G8D+2iH7aZ1ZzEef5xypez5Y=;
	b=djNXr9rOS+iz4zWcJKOooX3ArAh1Rc93KwVsDjNxv3sKkQDcndt6LUnZ7hM5bzcly9XEea
	FJxqt5zgSII3cvpcmmENRHucZ3KcZ3ObIDTpvH5nuQtsmwl8nIF4hB2SFM6Ho1Yi4a6kKH
	DQt5/JCQnCeVi073a/XoH7icXHvRIeM6Xm7qHJqJ2xuh28b+s7WkNufJ1foi0xFzgVSMCl
	aSI0eG0/yjF0gndiFrz6I4dqvPiddyQ5IL3ARs8MdeckXSGy1vEVxGQ+qMQsHK/70pJvqu
	9UVyY7u3AS2KkNVbQniCVMjcMpZuqaObBexdP9JkKVDGmwq+dQv2tILTBVuUAg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Feb 2024 11:32:42 +0100
Message-Id: <CYTO9ZZ41LYD.170JY5PLQE7JE@bootlin.com>
Subject: Re: [PATCH v4 16/18] MIPS: mobileye: eyeq5: add reset properties to
 UARTs
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
X-Mailer: aerc 0.15.2
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
 <20240131-mbly-clk-v4-16-bcd00510d6a0@bootlin.com>
 <3f3b1665-30d4-4581-84a8-7894a4a03b93@linaro.org>
In-Reply-To: <3f3b1665-30d4-4581-84a8-7894a4a03b93@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 1, 2024 at 10:13 AM CET, Krzysztof Kozlowski wrote:
> On 31/01/2024 17:26, Th=C3=A9o Lebrun wrote:
> > UART nodes have been added to the devicetree by the initial platform
> > support patch series. Add reset properties now that the reset node is
> > declared.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  arch/mips/boot/dts/mobileye/eyeq5.dtsi | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dt=
s/mobileye/eyeq5.dtsi
> > index 06e941b0ce10..ece71cafb6ee 100644
> > --- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> > +++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> > @@ -78,6 +78,7 @@ uart0: serial@800000 {
> >  			interrupts =3D <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
> >  			clocks  =3D <&uart_clk>, <&occ_periph>;
> >  			clock-names =3D "uartclk", "apb_pclk";
> > +			resets =3D <&reset 0 10>;
>
> You touch the same file. Squash the patch with previous one. It's the
> same logical change to add reset to entire SoC. You don't add half of
> reset, right?

Makes sense. I'll update the commit message with that change.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

