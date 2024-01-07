Return-Path: <linux-kernel+bounces-18863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0529A82641F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 14:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671DEB21674
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B92134AC;
	Sun,  7 Jan 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="OZLNm4bn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E1134A5;
	Sun,  7 Jan 2024 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id B25DA2807E5;
	Sun,  7 Jan 2024 14:02:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1704632529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9vUeDmoQ6ArSFOj4UH5MFCzRsfwDhilZfFeJMCpNBU=;
	b=OZLNm4bn42sIpotvh4BiK6wETj6k8k7b1ArKiDkvWdGgKZ/woikVHHc163NG5YYqE2CI5W
	P9GuKmTZE1rZ4hWAZVLpkt0PulLIzAFh78YEeGr8/rhxZpLp1MSB4IEKSBRI+mlh4ByKu1
	kQYLRdatIC1brvMVZNVho1KnwLwFvYs=
Received: from localhost (koleje-wifi-0044.koleje.cuni.cz [78.128.191.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 588C14578AF;
	Sun,  7 Jan 2024 14:02:09 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jan 2024 14:02:36 +0100
Message-Id: <CY8HT5NHUF4D.X59U8LV1BCFW@gimli.ms.mff.cuni.cz>
Cc: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/5] regulator: add 88pm88x regulators driver
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Karel Balej"
 <balejk@matfyz.cz>, "Lee Jones" <lee@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
 <20231228100208.2932-5-karelb@gimli.ms.mff.cuni.cz>
 <e5e2ff07-fe29-4ff1-abc8-7250c756154e@linaro.org>
In-Reply-To: <e5e2ff07-fe29-4ff1-abc8-7250c756154e@linaro.org>

On Sun Jan 7, 2024 at 11:35 AM CET, Krzysztof Kozlowski wrote:
> On 28/12/2023 10:39, Karel Balej wrote:
> > diff --git a/drivers/mfd/88pm88x.c b/drivers/mfd/88pm88x.c
> > index 69a8e39d43b3..999d0539b720 100644
> > --- a/drivers/mfd/88pm88x.c
> > +++ b/drivers/mfd/88pm88x.c
> > @@ -68,6 +68,21 @@ static struct mfd_cell pm886_devs[] =3D {
> >  		.num_resources =3D ARRAY_SIZE(pm88x_onkey_resources),
> >  		.resources =3D pm88x_onkey_resources,
> >  	},
> > +	{
> > +		.name =3D "88pm88x-regulator",
> > +		.id =3D PM88X_REGULATOR_ID_LDO2,
> > +		.of_compatible =3D "marvell,88pm88x-regulator",
> > +	},
> > +	{
> > +		.name =3D "88pm88x-regulator",
> > +		.id =3D PM88X_REGULATOR_ID_LDO15,
> > +		.of_compatible =3D "marvell,88pm88x-regulator",
> > +	},
> > +	{
> > +		.name =3D "88pm88x-regulator",
> > +		.id =3D PM886_REGULATOR_ID_BUCK2,
> > +		.of_compatible =3D "marvell,88pm88x-regulator",
>
> Same compatible per each regulator looks suspicious, if not even wrong.
> What are these?

The original attempt for upstreaming this MFD had a different compatible
for each regulator which was not correct according to the reviewers at
the time. I have thus used the same compatible for all regulators and
make the distinction in the regulator driver (using the .id property).
But I think that the problem here is again that I have confused the
purpose of .name and .of_compatible properties of struct mfd_cell - if a
driver is probed due to the .name property then I indeed should not need
compatible for the regulator driver at all.

>
> Best regards,
> Krzysztof

Best regards,
K. B.

