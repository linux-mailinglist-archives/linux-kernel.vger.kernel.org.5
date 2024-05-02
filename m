Return-Path: <linux-kernel+bounces-166861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 483BF8BA104
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CA1282881
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A6017F39F;
	Thu,  2 May 2024 19:19:55 +0000 (UTC)
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de [80.67.31.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448341DDE9;
	Thu,  2 May 2024 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.31.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677594; cv=none; b=etXM6TLUux7ekR63Vc8oepAiibgfSjaEDjpBPEhiDPRmyc6/RZuwFSkY6It24hH/W5/BsaXQgifmMd3Szog/J4+jxp4n0nh0kSrdzaNgoAtX/xajnfbESY0M/2GexIL9/lgQmAwS3u6ZfUb3MeanjZXDLSQ6wuoN1Z1wXhXYQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677594; c=relaxed/simple;
	bh=cMv9nLPugJbMDvj5g8lAQwCGg7iV1EJ33oheAeccbpA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l4fzcCAdyEoENs2xo7PXsgSLqOFxfrU51/ZM+bOAkiZdsiy4rDN78pttx69bgpqL5sM+/qNcq6hvxlav9glhtld0ODUrIHTShpo+kAQ4oThpBHVDmi8zNbK2PhKB82X6TPBc0F4lwRQb2kvJyF1IEOk39H+ZdRO59rLTl5Tmqv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apitzsch.eu; spf=pass smtp.mailfrom=apitzsch.eu; arc=none smtp.client-ip=80.67.31.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apitzsch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apitzsch.eu
Received: from [92.206.191.65] (helo=framework.lan)
	by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <git@apitzsch.eu>)
	id 1s2bxV-000000007N8-1Lcs;
	Thu, 02 May 2024 21:19:09 +0200
Message-ID: <9bb6ef63e19bf079fd881a3b78b71d7a00e4a3bb.camel@apitzsch.eu>
Subject: Re: [PATCH v2 2/3] leds: sy7802: Add support for Silergy SY7802
 flash LED controller
From: =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>,  Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Date: Thu, 02 May 2024 21:19:13 +0200
In-Reply-To: <20240502091017.GF5338@google.com>
References: <20240401-sy7802-v2-0-1138190a7448@apitzsch.eu>
	 <20240401-sy7802-v2-2-1138190a7448@apitzsch.eu>
	 <20240411124855.GJ1980182@google.com>
	 <c5e5f49295350ada2cdb280a77b1c877058d4d64.camel@apitzsch.eu>
	 <20240502091017.GF5338@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=

Am Donnerstag, dem 02.05.2024 um 10:10 +0100 schrieb Lee Jones:
> On Wed, 01 May 2024, Andr=C3=A9 Apitzsch wrote:
>=20
> > > > +		ret =3D -EBUSY;
> > > > +		goto unlock;
> > > > +	}
> > > > +
> > > > +	if (level)
> > > > +		curr =3D chip->fled_torch_used | BIT(led-
> > > > >led_no);
> > > > +	else
> > > > +		curr =3D chip->fled_torch_used & ~BIT(led-
> > > > >led_no);
> > > > +
> > > > +	if (curr)
> > > > +		val |=3D SY7802_MODE_TORCH;
> > > > +
> > > > +	/* Torch needs to be disabled first to apply new
> > > > brightness */
> > >=20
> > > "Disable touch to apply brightness"
> > >=20
> > > > +	ret =3D regmap_update_bits(chip->regmap,
> > > > SY7802_REG_ENABLE,
> > > > SY7802_MODE_MASK,
> > > > +				 SY7802_MODE_OFF);
> > > > +	if (ret)
> > > > +		goto unlock;
> > > > +
> > > > +	mask =3D led->led_no =3D=3D SY7802_LED_JOINT ?
> > > > SY7802_TORCH_CURRENT_MASK_ALL :
> > >=20
> > > Why not just use led->led_no in place of mask?
> >=20
> > I might be missing something, but I don't know how to use led-
> > >led_no
> > in place of mask, when
> > led->led_no is in {0,1,2} and
> > mask is in {0x07, 0x38, 0x3f}.
>=20
> This doesn't make much sense.
>=20
> I guess you mean that led_no is a u8 and mask is a u32.
>=20
> What happens if you cast led_no to u32 in the call to
> regmap_update_bits()?

Sorry, I'm still confused. Could you elaborate your original question?

>=20
> > > Easier to read if you drop SY7802_TORCH_CURRENT_MASK_ALL to its
> > > own
> > > line.
> > >=20
> > > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SY7802_TORCH_CURRENT_MASK(le=
d->led_no);
> > > > +
> > > > [..]
> > > >=20
>=20


