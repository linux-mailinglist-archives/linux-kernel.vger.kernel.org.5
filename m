Return-Path: <linux-kernel+bounces-18827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCCD8263A5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 10:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3055AB215EA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C982812B8D;
	Sun,  7 Jan 2024 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="JMajUtT4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DF712B7A;
	Sun,  7 Jan 2024 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id D480728295E;
	Sun,  7 Jan 2024 10:48:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1704620933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+5JaUxNv9hPVABXEfoWXdhZ6H5sXzewgbughZ6jl7Y=;
	b=JMajUtT4JlplmBkg7Xu9tMhjPmyV0a4XidTi0FksOylppM3T1ol4szvV5SCzEdt1EGB0/s
	84nGrwN4EZ+zgGl0lRlBZBjuLtxcyjEVyk/sw1qLYrhQOLfnfE5MFZ1FSykXaXbF6ueDXP
	L4YktUzZ6rx9TbMVoMOWlklMFvRZtQw=
Received: from localhost (koleje-wifi-0044.koleje.cuni.cz [78.128.191.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id AF2A7457743;
	Sun,  7 Jan 2024 10:48:53 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jan 2024 10:49:20 +0100
Message-Id: <CY8DP6O8C72H.2XTJT3P7XZAKE@gimli.ms.mff.cuni.cz>
Cc: "Karel Balej" <balejk@matfyz.cz>, "Lee Jones" <lee@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Liam Girdwood" <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Duje_Mihanovi=C4=87?=
 <duje.mihanovic@skole.hr>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/5] regulator: add 88pm88x regulators driver
To: "Mark Brown" <broonie@kernel.org>
From: "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
 <20231228100208.2932-5-karelb@gimli.ms.mff.cuni.cz>
 <008ee9d6-6259-43df-9af3-2dc9877cfe94@sirena.org.uk>
In-Reply-To: <008ee9d6-6259-43df-9af3-2dc9877cfe94@sirena.org.uk>

Mark,

On Fri Jan 5, 2024 at 4:18 PM CET, Mark Brown wrote:
> On Thu, Dec 28, 2023 at 10:39:13AM +0100, Karel Balej wrote:
>
> > @@ -68,6 +68,21 @@ static struct mfd_cell pm886_devs[] =3D {
> >  		.num_resources =3D ARRAY_SIZE(pm88x_onkey_resources),
> >  		.resources =3D pm88x_onkey_resources,
> >  	},
> > +	{
> > +		.name =3D "88pm88x-regulator",
> > +		.id =3D PM88X_REGULATOR_ID_LDO2,
> > +		.of_compatible =3D "marvell,88pm88x-regulator",
> > +	},
>
> Why are we adding an of_compatible here?  It's redundant, the MFD split
> is a feature of Linux internals not of the hardware, and the existing
> 88pm8xx MFD doesn't use them.

in a feedback to my MFD series, Rob Herring pointed out that there is no
need to have a devicetree node for a subdevice if it only contains
"compatible" as the MFD driver can instantiate subdevices itself. I
understood that this is what he was referring to, but now I suspect that
it is sufficient for the mfd_cell.name to be set to the subdevice driver
name for this - is that correct?

Thank you,
K. B.

