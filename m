Return-Path: <linux-kernel+bounces-95117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8120387495D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F0C1F2437C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9706341B;
	Thu,  7 Mar 2024 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvYuqc+U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F70634EB;
	Thu,  7 Mar 2024 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799385; cv=none; b=a+1j0tl98lbNnq6/vrW2ufnpnbrhxIkuJDv+91ETbOLCOLIto+lDfdvpUisPWaN/xfwWOOVD/YSpLvxJoqMbvKGDRUqrvvEMHokic+QPXQRvN8sHfTTRhjfQVgY+y7pJINDqGPLganbyfTR3vvPh1FaMXKRWK48Xnb6SiRPD9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799385; c=relaxed/simple;
	bh=rVFMQEnfrYG4Wgn4S68I3EQLzaLnbMdVngZen2hYYOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g91WokQaqHU4kdSKfBy5OBpN2T6RdGkDFqYQZvEzVy3aT29SYLT0JJ4TcUMiqTk0JeRkiJUB7EFjjui6IaVWkEu0xhz7gOiJu3vIll3gIdZpMxcn2lMjpO69PHjmFFbp1/cpD5Tk0I3TPABFqNZqi0/bBU9pXTNnawVVpW+HCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvYuqc+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46105C433C7;
	Thu,  7 Mar 2024 08:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709799385;
	bh=rVFMQEnfrYG4Wgn4S68I3EQLzaLnbMdVngZen2hYYOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvYuqc+UTOlU2ALSL6tZwugkxiFcZurvxlhQ50GsLxBZSPch5EtQlJAdGIs3iQlfW
	 EnTJOn5BkAevPqEBqsfxcojKNVIILbeUsmwz9iqm4qDVgsaDn81/ROgEFgOEv9Ah7p
	 Bq+OzvhNwV2Z/SqVgY/HTd2ndLJdJf/2R5H4+EIKANHVqqi6mMu0jCGWQtRUQjpxrg
	 CrAwW1vxOCmc3jRhSx+cUTKsaS+Q+HpQTszMA7pVRIjaMJ+jdYkgHiu/zFzqINzfLX
	 +j6y77zKrH4bjI90Rkhh+0HHCbAbhxrudX5M5EMs3EdnxG+ObraMmEWEY0+x66De+d
	 DKYEdnQm3dPfg==
Date: Thu, 7 Mar 2024 08:16:19 +0000
From: Lee Jones <lee@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/5] mfd: add driver for Marvell 88PM886 PMIC
Message-ID: <20240307081619.GI86322@google.com>
References: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
 <20240303101506.4187-3-karelb@gimli.ms.mff.cuni.cz>
 <20240305114418.GB86322@google.com>
 <CZM1LPDLQXLP.VVOVCCQPGBOL@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZM1LPDLQXLP.VVOVCCQPGBOL@gimli.ms.mff.cuni.cz>

> > > +static int pm886_initialize_subregmaps(struct pm886_chip *chip)
> > > +{
> > > +	struct device *dev = &chip->client->dev;
> > > +	struct i2c_client *page;
> > > +	struct regmap *regmap;
> > > +	int err;
> > > +
> > > +	/* regulators page */
> > > +	page = devm_i2c_new_dummy_device(dev, chip->client->adapter,
> > > +				chip->client->addr + PM886_PAGE_OFFSET_REGULATORS);
> > > +	if (IS_ERR(page)) {
> > > +		err = PTR_ERR(page);
> > > +		dev_err(dev, "Failed to initialize regulators client: %d\n", err);
> > > +		return err;
> > > +	}
> > > +	regmap = devm_regmap_init_i2c(page, &pm886_i2c_regmap);
> > > +	if (IS_ERR(regmap)) {
> > > +		err = PTR_ERR(regmap);
> > > +		dev_err(dev, "Failed to initialize regulators regmap: %d\n", err);
> > > +		return err;
> > > +	}
> > > +	chip->regmaps[PM886_REGMAP_REGULATORS] = regmap;
> >
> > Except for the regulator driver, where else is the regulators regmap used?
> 
> Nowhere, at least as of now. So you are saying that I should initialize
> the regmap in the regulator driver?

I am.

-- 
Lee Jones [李琼斯]

