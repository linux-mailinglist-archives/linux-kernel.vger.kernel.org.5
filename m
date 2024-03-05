Return-Path: <linux-kernel+bounces-92855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A708726FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70907282B14
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40171B597;
	Tue,  5 Mar 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="kIhUI8Fr"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A51C2BD;
	Tue,  5 Mar 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664802; cv=none; b=I5eR6pFkAcJXxAJxPUvktu+75rSE9Cr6G6zr6af2KE8tV+rwq/96V3GjzTlG9NXd5GYGM7q/XoAe1iaBGz9UYYEb4uoMEPpmDTSELLQ35HcGcdbB4+vvP0T9XoHclhRKWnEy8zERsU+VF6MUslgVpgGMDX9l0yqaiQOjdF0K38I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664802; c=relaxed/simple;
	bh=PAjYBfjUZfOfVYAYGp67ZjY5YssOIvuLWF/KNxrjNVI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=JdnYBIV7Aw+NHWoP7hdqiTWZRYCcV45PjZ5SWRiLJijAZSoILJ27IhEjy9+/uJk/K8z7yU9zbVfa2VKBthmvhCwZp6p1HkF23v9Y0XhYN8PJKI3wB0qwMGWPI4sEtay8LVSaiNr5aIlPYmwdAg6/sbq4p/EMqf25x8ebwTkx2hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=kIhUI8Fr; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 5195128443D;
	Tue,  5 Mar 2024 19:53:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1709664796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dks2OPoqszY4gtl403k8F6gGmC1uZy/jgxeo+Bx8K40=;
	b=kIhUI8FrDeRNhFpoEApUP5Tyzna549ZwD7ewVoB7kE9J9TrvfSDh9hdtq390wgkyjbumjt
	MalmDgC6PilHQZ8HG4SSYL7Ddcndbr0FJjLIeakLO4trHcbP/wRvuMX0FAb/H4Xdv17dci
	P15t6/clg2eCRrI/o3dQ4hRxvSkxnSg=
Received: from localhost (koleje-wifi-0023.koleje.cuni.cz [78.128.191.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 26124458158;
	Tue,  5 Mar 2024 19:53:16 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Mar 2024 19:53:52 +0100
Message-Id: <CZM1LPDLQXLP.VVOVCCQPGBOL@gimli.ms.mff.cuni.cz>
Cc: "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-input@vger.kernel.org>, =?utf-8?q?Duje_Mihanovi=C4=87?=
 <duje.mihanovic@skole.hr>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 2/5] mfd: add driver for Marvell 88PM886 PMIC
To: "Lee Jones" <lee@kernel.org>
From: "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
References: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
 <20240303101506.4187-3-karelb@gimli.ms.mff.cuni.cz>
 <20240305114418.GB86322@google.com>
In-Reply-To: <20240305114418.GB86322@google.com>

Lee Jones, 2024-03-05T11:44:18+00:00:
> > +static struct mfd_cell pm886_devs[] =3D {
> > +	{
> > +		.name =3D "88pm886-onkey",
> > +		.num_resources =3D ARRAY_SIZE(pm886_onkey_resources),
> > +		.resources =3D pm886_onkey_resources,
> > +	},
> > +	{
> > +		.name =3D "88pm886-regulator",
> > +		.id =3D PM886_REGULATOR_ID_LDO2,
>
> Why doesn't PLATFORM_DEVID_AUTO work for this device?

Because I am using the IDs in the regulator driver to determine which
regulator data to use/which regulator to register.

> > +static int pm886_initialize_subregmaps(struct pm886_chip *chip)
> > +{
> > +	struct device *dev =3D &chip->client->dev;
> > +	struct i2c_client *page;
> > +	struct regmap *regmap;
> > +	int err;
> > +
> > +	/* regulators page */
> > +	page =3D devm_i2c_new_dummy_device(dev, chip->client->adapter,
> > +				chip->client->addr + PM886_PAGE_OFFSET_REGULATORS);
> > +	if (IS_ERR(page)) {
> > +		err =3D PTR_ERR(page);
> > +		dev_err(dev, "Failed to initialize regulators client: %d\n", err);
> > +		return err;
> > +	}
> > +	regmap =3D devm_regmap_init_i2c(page, &pm886_i2c_regmap);
> > +	if (IS_ERR(regmap)) {
> > +		err =3D PTR_ERR(regmap);
> > +		dev_err(dev, "Failed to initialize regulators regmap: %d\n", err);
> > +		return err;
> > +	}
> > +	chip->regmaps[PM886_REGMAP_REGULATORS] =3D regmap;
>
> Except for the regulator driver, where else is the regulators regmap used=
?

Nowhere, at least as of now. So you are saying that I should initialize
the regmap in the regulator driver?

Thank you,
K. B.

