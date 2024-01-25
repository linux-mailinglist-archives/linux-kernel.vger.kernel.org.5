Return-Path: <linux-kernel+bounces-38468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6653983C058
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1AC29D4D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB0959156;
	Thu, 25 Jan 2024 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MfjLijkO"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A061BDCA;
	Thu, 25 Jan 2024 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180473; cv=none; b=ufP5h4zqxySHxmc/3uYd6G2nGuwhem1oF4OixzXzSp9viYyvSdPVHLRzplRzWw9Kc/LUOOhIY7RK6spDFk5YEC0bKfJE3JCmzRWSMevxjxKBtQjZiP//4a6p0Vqr9vgLout+kD5aRJaXy8EXCwFYpyYWiGw3HRjftuYVhkYUchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180473; c=relaxed/simple;
	bh=YSxa/mMSgqpJQW+2kobPEHT7Vxr7BU0VRT1lEHw89/8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=o6UdvLhBpA6I7ZHZt5F7piMDaQ0k6wnYyLNup8JndyrTqlPqj+8lrrsrOmuwcP/tqs/qYdiX86d2bDNFx6c+dkVOVxzs3yngGrsfHm+BxzIg+M5/I4TtWo2C54sPefYFOEeoem48N8O0e04UPuQElGwOwYjF99jDNGspWksCbzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MfjLijkO; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C16C3E0007;
	Thu, 25 Jan 2024 11:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706180467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WPcj9jp5TczMii0r01DGB7rL3rO4+5GSU7rJ/lR9/s=;
	b=MfjLijkO2Rs/IJY59mGODNP/JT6HojMlLEygWWr5DF4P1y0IIez1TW8cVbD6TDFRHWVTKi
	PR3KcjQR2MWWU75NdypK99FP5jLTmpxeUFGB/PboMU9DRs8TT12e/NG3cxNsZlYZJrxemH
	4D6PuAiSzlf8BwD9Xlu1994KMwwrs4Gy2NidmNbl4HZ6zzjdGAFii2WJAG4MH4ilF+6G+W
	H73hkH12M/633aKMyZynCItrWYvFM7JbX3251ecZAZvm6GSgwYKauN4igXpCn9hiTqKaFf
	V8ynQBqZaDO+R+kFRJQdbUzuQlHTOMFGwxJ/fpG2i+HjY7D/nYuPNbuVoKWV4A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jan 2024 12:01:06 +0100
Message-Id: <CYNQHXOZ73YR.3QODFI2X08KC6@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v3 04/17] dt-bindings: soc: mobileye: add EyeQ5 OLB
 system controller
Cc: "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, <linux-mips@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Rob Herring"
 <robh@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-4-392b010b8281@bootlin.com>
 <20240124151405.GA930997-robh@kernel.org>
 <dd7e723d-3c4c-4edf-afc2-51db9a074efa@linaro.org>
In-Reply-To: <dd7e723d-3c4c-4edf-afc2-51db9a074efa@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Jan 25, 2024 at 8:51 AM CET, Krzysztof Kozlowski wrote:
> On 24/01/2024 16:14, Rob Herring wrote:
> >> +
> >> +      pinctrl-b {
> >> +        compatible =3D "mobileye,eyeq5-b-pinctrl";
> >> +        #pinctrl-cells =3D <1>;
> >> +      };
> >> +    };
> >=20
> > This can all be simplified to:
> >=20
> > system-controller@e00000 {
> >     compatible =3D "mobileye,eyeq5-olb", "syscon";
> >     reg =3D <0xe00000 0x400>;
> >     #reset-cells =3D <2>;
> >     #clock-cells =3D <1>;
> >     clocks =3D <&xtal>;
> >     clock-names =3D "ref";
> >=20
> >     pins { ... };
> > };
> >=20
> > There is no need for sub nodes unless you have reusable blocks or each=
=20
> > block has its own resources in DT.
>
> Yes, however I believe there should be resources here: each subnode
> should get its address space. This is a bit tied to implementation,
> which currently assumes "everyone can fiddle with everything" in this blo=
ck.
>
> Theo, can you draw memory map?

It would be a mess. I've counted things up. The first 147 registers are
used in this 0x400 block. There are 31 individual blocks, with 7
registers unused (holes to align next block).

Functions are reset, clocks, LBIST, MBIST, DDR control, GPIO,
accelerator control, CPU entrypoint, PDTrace, IRQs, chip info & ID
stuff, control registers for PCIe / eMMC / Eth / SGMII / DMA / etc.

Some will never get used from Linux, others might. Maybe a moderate
approach would be to create ressources for major blocks and make it
evolve organically, without imposing that all uses lead to a new
ressource creation.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

