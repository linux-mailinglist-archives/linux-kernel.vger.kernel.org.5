Return-Path: <linux-kernel+bounces-148081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC4E8A7D72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F011F22127
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC4274402;
	Wed, 17 Apr 2024 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="in2TKG1Q"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CF66E61E;
	Wed, 17 Apr 2024 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340409; cv=none; b=BUobtl+jIqB3N4ghcKXPNw6fSS6Czb5+JptP7PeBp+tJbw/ikHKOLDtgfQVoJZagfNQVXPK6pbOVWfMGoyPKeyMRa9FldtW9ddPK8DFeGv4vb9sQHxRD6kQfGJxliWyI+z/A3Eu8lP48NsFZouHKgty8ss8OeOlYcrkYvkj7w4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340409; c=relaxed/simple;
	bh=Mb2a7596Lmd6anWCFMHZ+kYccUmgTpwKjnEeL5+XNOQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=jms4mf8n9GScZ96m5WBP0KBrpi8qsUXb6O2FvxJc6WcofANs0cNm7Ckqzwx+N0v9qaTkBcPe3+P/+Ab6aqI4ljid6kdNe6b8o4ZO/kdv9EEcDI0yDIgp7lLJ989/TUoH4kfPJd/rEltEBn8M+ZzUTASvpC0n0N9Zzw9+sT+iZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=in2TKG1Q; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2BA64E0004;
	Wed, 17 Apr 2024 07:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713340405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/f2fgDpr3YH/Sb3o75KFxeysANmwnrDztJzWkxW1KI=;
	b=in2TKG1QGupbNAYcOgKkb0N+dVS1KjzghCUGoMBe/aO0EnXrHvmHWh7B4fgRNMDorqxFxk
	Vuehzy3mwP2JIu5l0/DQ/WKBZfYpRZOx0XlqZ3B8KbIhltcld9wUuIsulVWvTVWiN24eY1
	mfPUHr8xDB9sSUC6vVHNZLQzFMpXdjiz6Ujf6rhHILx2mJDDlA+9NsLIjSID/W+j12L43J
	EmmVr+jH3vl643xlJo/0mKxo0gSrnePqWBG00NOY447pgnnknE0J7w+W8r1pwapgNpvK6S
	IU1JqiqWAMdbTSh6T9vkRiJYUb2FweW+P7Vs/Kqvy6f1vMJsYJH8GfgFhhdIcg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Apr 2024 09:53:23 +0200
Message-Id: <D0M8HFHFPO6M.KXQCAE8TZNIH@bootlin.com>
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
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
 <20240410-mbly-olb-v1-8-335e496d7be3@bootlin.com>
 <faa0769f-bd5e-4c6b-9f61-1a369830ad28@linaro.org>
 <D0HD94HI3W7W.3KLAW6WFIN6ZE@bootlin.com>
 <6e3b02d9-9a1e-4fc0-9459-9c9c0d37aa92@linaro.org>
In-Reply-To: <6e3b02d9-9a1e-4fc0-9459-9c9c0d37aa92@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Apr 11, 2024 at 5:07 PM CEST, Krzysztof Kozlowski wrote:
> On 11/04/2024 16:34, Th=C3=A9o Lebrun wrote:
> > Hello,
> >=20
> > On Thu Apr 11, 2024 at 8:15 AM CEST, Krzysztof Kozlowski wrote:
> >> On 10/04/2024 19:12, Th=C3=A9o Lebrun wrote:
> >>> The OLB ("Other Logic Block") is a syscon region hosting clock, reset
> >>> and pin controllers. It contains registers such as I2C speed mode tha=
t
> >>> need to be accessible by other nodes.
> >>>
> >>> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> >>> ---
> >>>  arch/mips/boot/dts/mobileye/eyeq5.dtsi | 8 ++++++++
> >>>  1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/=
dts/mobileye/eyeq5.dtsi
> >>> index 6cc5980e2fa1..e82d2a57f6da 100644
> >>> --- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> >>> +++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> >>> @@ -100,6 +100,14 @@ uart2: serial@a00000 {
> >>>  			clock-names =3D "uartclk", "apb_pclk";
> >>>  		};
> >>> =20
> >>> +		olb: system-controller@e00000 {
> >>> +			compatible =3D "mobileye,eyeq5-olb", "syscon", "simple-mfd";
> >>> +			reg =3D <0 0xe00000 0x0 0x400>;
> >>> +			ranges =3D <0x0 0x0 0xe00000 0x400>;
> >>> +			#address-cells =3D <1>;
> >>> +			#size-cells =3D <1>;
> >>
> >> Do not add incomplete node. ranges, address/size-cells are incorrect i=
n
> >> this context and you will have warnings.
> >>
> >> Add complete node, so these properties make sense.
> >=20
> > I'll squash all four commits into one. For reference, commits are:
> >=20
> >  - MIPS: mobileye: eyeq5: add OLB syscon node
> >  - MIPS: mobileye: eyeq5: use OLB clocks controller node
> >  - MIPS: mobileye: eyeq5: add OLB reset controller node
> >  - MIPS: mobileye: eyeq5: add pinctrl node & pinmux function nodes
> >=20
> > This means two things: (1) it won't be partially applicable and (2) it
>
> Why?
>
> > will make one big commit adding pins and editing clocks.
>
> It never was partially applicable. Causing warnings does not make things
> partially applicable. If node is too big, although I personally do not
> agree, it's quite moderate size chunk, then sure, split pinctrl groups
> or pinctrl node to additional patch.

Thanks for feedback; it'll become a single patch as it is fine with you.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


