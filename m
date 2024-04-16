Return-Path: <linux-kernel+bounces-147020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA08E8A6E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704981F212DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8852282D9D;
	Tue, 16 Apr 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CRyCJdk9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716B1CAA6;
	Tue, 16 Apr 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277936; cv=none; b=XbiRmG/hWkHFxRD7z/dyGcIsRtCfAkWKasDda9Kdwm1QG4xW/lG/fzAXT3sFmTc6OXr1Z40YJ9UQzr1y+zsD8E7oliAquQwXJMaAYrToRm6TuE8ZZ6dtVMtPFKrOt6IXkSP7o4e2i3M0Uo+rhdJwL5BSy6iFmWg7ZGsFFNITPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277936; c=relaxed/simple;
	bh=xwtOX3huVgNQWdzLmjX+ow6uv3bTrZuFvMHF8dtE9a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQOZMRfrqZyiI7U1v1kI/LI03UE/NngahIGrfgfwHle30Xe9c+dsA7AgRNpYanYrwgyqKWj+WPOoB27ZzZkd/Md+zEbiv9QPm8MVOYIVpJA0mK8oQvWVALFZgdlqrQbsY4icz37x0ZwvxIxVXU4RomWnizZD6Vq5KBb2MvXK7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CRyCJdk9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713277933;
	bh=xwtOX3huVgNQWdzLmjX+ow6uv3bTrZuFvMHF8dtE9a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRyCJdk9BPM0d4kzXLOxXz4EylR0wqZhxNbJR89AC3uCDb+7PEoZ1pPCcQJx25jvv
	 Y2xbXdD9hj6+yPwoulIB5puWXkEf21/Ba8OUxyvR1D4MoQ7Dy1ykkmLitxLXJ5IT0M
	 4VOz6S+m74p/WqkxE45AX5HPwEYY32SePcmYjfHnm7Ce43lB6zI8pWwksZNl18SWQ3
	 XwfqRnj/OzxJZpKmwEo3RtDoZRaoKV75oiN5BEAemk4n45cftF8PPO3QJxrWl5nlyf
	 zCRAGkMR/9TUPCrcEJBCbeDQ7jXs24jTw9XtgqWHlssOyY4vQUSiaBqfaPPFrZQyg7
	 wt8X90IFgqitw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B6BCE37820F9;
	Tue, 16 Apr 2024 14:32:12 +0000 (UTC)
Date: Tue, 16 Apr 2024 10:32:10 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: sbs-battery: Handle unsupported
 PROP_TIME_TO_EMPTY_NOW
Message-ID: <9f805ec3-1611-4682-831e-9499ba8284d5@notapiano>
References: <20240415-sbs-time-empty-now-error-v2-1-32d8a747e308@collabora.com>
 <9ba1b4df-78dc-4f24-bb61-d7b168da18f8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ba1b4df-78dc-4f24-bb61-d7b168da18f8@collabora.com>

On Tue, Apr 16, 2024 at 09:46:56AM +0200, AngeloGioacchino Del Regno wrote:
> Il 15/04/24 21:05, Nícolas F. R. A. Prado ha scritto:
[..]
> > +
> > +static void sbs_update_quirks(struct sbs_info *chip)
> > +{
> > +	const char *model;
> > +	const char *manufacturer;
> > +	unsigned int i = 0;
> 
> Please reorder:
> 
> 	const char *manufacturer;
> 	const char *model;
> 	unsigned int i;
> 
> ...and please remove (like shown, of course) the double initialization of the
> `i` variable, as you're initializing it again later in your for loop.

Ack.

> 
> > +
> > +	/* reset quirks from battery before the hot-plug event */
> > +	chip->quirks = 0;
> > +
> > +	manufacturer = sbs_get_constant_string(chip, POWER_SUPPLY_PROP_MANUFACTURER);
> > +	model = sbs_get_constant_string(chip, POWER_SUPPLY_PROP_MODEL_NAME);
> > +	if (IS_ERR(manufacturer) || IS_ERR(model)) {
> > +		dev_warn(&chip->client->dev, "Couldn't read manufacturer and model to set quirks\n");
> > +		return;
> > +	}
> > +
> > +	for (i = 0; i < ARRAY_SIZE(sbs_quirks); i++) {
> > +		if (strcmp(manufacturer, sbs_quirks[i].manufacturer))
> > +			continue;
> > +		if (strcmp(model, sbs_quirks[i].model))
> > +			continue;
> > +		chip->quirks |= sbs_quirks[i].flags;
> > +	}
> > +
> > +	if (chip->quirks & SBS_QUIRK_BROKEN_TTE_NOW)
> > +		dev_info(&chip->client->dev, "Added quirk disabling TIME_TO_EMPTY_NOW\n");
> 
> I don't really expect many quirks, but having a dev_info() print for every
> quirk that gets set would make this driver too chatty, IMO.
> 
> Please, either turn that into a dev_dbg() or print a mask of the quirks .. or both.

I wouldn't make this debug as it's pretty important information to be
reported. I'd be ok with having a single message listing all the quirks, but at
the same time I feel like this would be trying to fix a problem that we don't
know will ever exist (one SBS battery that has many quirks). I propose we keep
it the way it is - a nice clear message of what has happened - and adapt in the
future if it turns out to be too much information.

Thanks,
Nícolas

