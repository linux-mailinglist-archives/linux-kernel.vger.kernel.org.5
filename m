Return-Path: <linux-kernel+bounces-49899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB1784712A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A538A1F24C2F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2794654B;
	Fri,  2 Feb 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IezIkzd0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED54643A;
	Fri,  2 Feb 2024 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880586; cv=none; b=BwvgTz6z/D7vNGC8NjoGcH9u91PyKCxoTU9BMlgLohDkBu4TJKBckwmDJQWZNjmcHdkzWBG29IDZs89Ir+IA60vyHD6NaBlR98DB5mrRV3u2MEl81Uz3FHpt39V3GWTs7VQlyU23/O7P1h5rZATYu7qSCAtcI/UhjGjZ53JpU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880586; c=relaxed/simple;
	bh=emWHbtbKmHt44W1EEZpZpoNIQ47i7QfIYpdTdG9/FUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNs1m1BhFO2AyGYbfE6ZARxI2K7b8yXitZaDgaOUmJCivnVAV92p3qndFckbcfRvihSNaoBTR9taV2I4L1JILFQ6AnmDg+4v9PmAfcLWQ90fjjGxiGUpvRMgsyao46d5Df184LFv89/+Va8FEH5I5tFz3tXkNtDrjIaaj6LcbbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IezIkzd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CEEC433F1;
	Fri,  2 Feb 2024 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706880585;
	bh=emWHbtbKmHt44W1EEZpZpoNIQ47i7QfIYpdTdG9/FUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IezIkzd0Uc+tG7hy/lyHyY7q+70ph0LArTYnWrdSZB/soOCU74p82GOqyzzZ3IspI
	 P9kuaKt8RC9Pmg8Ga9ETLt8LtAXwxTp8lvwbQPVD15lHJp20ymArkNM3epDmSVwG5P
	 D8xnQLyCodAAy5pXpS8pLk8Rh4IZw9yydGpfDQ00ot6PbMwatR7pccRGdEUiYYeoHV
	 XbN7wXgQyj1tc4eejDh7ZHC4KRQEbT21umWIvKAmMqBnjm07DU7hjTGh2E+rtIJ+yl
	 PRQTsvj264iIPI0o4IWVce/N3prRs8Hw5dSaYZZ2NldH24jwjFpzhjKVQIDupQU8RD
	 rgwg88YkFkmmg==
Date: Fri, 2 Feb 2024 13:29:40 +0000
From: Lee Jones <lee@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] mfd: add 88pm88x driver
Message-ID: <20240202132940.GG1379817@google.com>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
 <20231217131838.7569-3-karelb@gimli.ms.mff.cuni.cz>
 <20240125122634.GE74950@google.com>
 <CYQ8MEQRJELE.2GB9316NZA998@gimli.ms.mff.cuni.cz>
 <20240131110311.GI8551@google.com>
 <CYTURHOW0WMR.2UMOT0D1GFZ2W@gimli.ms.mff.cuni.cz>
 <20240202124550.GE1379817@google.com>
 <CYULY1BYVCYK.1EGSBSVNRSTLQ@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CYULY1BYVCYK.1EGSBSVNRSTLQ@gimli.ms.mff.cuni.cz>

Linus,

On Fri, 02 Feb 2024, Karel Balej wrote:

> Lee Jones, 2024-02-02T12:45:50+00:00:
> > On Thu, 01 Feb 2024, Karel Balej wrote:
> >
> > > Lee Jones, 2024-01-31T11:03:11+00:00:
> > > > On Sun, 28 Jan 2024, Karel Balej wrote:
> > > > > > > +	/* GPIO1: DVC, GPIO0: input */
> > > > > > > +	REG_SEQ0(PM88X_REG_GPIO_CTRL1, 0x40),

Do we have a precedent for drivers setting up their own pins like this?

> > > > > > Shouldn't you set these up using Pintrl?
> > > > > 
> > > > > You mean to add a new MFD cell for the pins and write the respective
> > > > > driver? The downstream implementation has no such thing so I'm not sure
> > > > > if I would be able to do that from scratch.
> > > >
> > > > This is not a Pinctrl driver.
> > > >
> > > > Isn't there a generic API you can use?
> > > 
> > > I'm sorry, I don't think I understand what you mean.
> >
> > Perhaps I misunderstand the code.  It looks like this regmap patch hack
> > is configuring pins and a bunch of other things.  Would that be a
> > correct assessment?
> 
> Yes, that sounds correct.
> 
> > If so, where do we draw the line here?  Do we accept a 1000 line driver
> > which configures a large SoC with a bunch of bespoke register writes?
> 
> I understand, I just don't know what you mean by "a generic API". I'm
> also not clear on whether what you have in mind is simply adding a
> dedicated driver for the pins as a new subdevice of this MFD.

-- 
Lee Jones [李琼斯]

