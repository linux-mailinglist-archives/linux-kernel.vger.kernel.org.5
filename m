Return-Path: <linux-kernel+bounces-49869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18BC8470B5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005481C2325D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923EA4428;
	Fri,  2 Feb 2024 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="edLqh18U"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FB15D2;
	Fri,  2 Feb 2024 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878550; cv=none; b=O7yqRAsWIy2Ir8hKvbuTOpND5ZEZGkdscm4YWSCR9OV+jIT2+EmXtzPfgtNcwyOexWSUG2C4bbaBwiAA1+rwK8ngAJTnDJXQlNtx1cECX+DVjlT7C4KXFyaafAwpDtqqYDsXbTp8tgw6niF8eRmKHG6Sh03Md/K/AgJbsaakUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878550; c=relaxed/simple;
	bh=+TmtUtIfmZcdIbEuOgcCdi2sK+bzSVptb/iPlbxGHIg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=RL+QXAiPE2QKx1ZWmw8ThmWuKjmugkCeR7/uS+6bfRMFeQz+3SDlcMJZms5ap/TNyEO3f3HCpcExs+4+GMmwFPjNX5+/G7d2TWpF98gp1aQkRbgOgWdlq0pm41Cx+yzV4Tz+ctx+iSyvd483IeOx016NrMCEn8y8kbTrbUyCFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=edLqh18U; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id C0E8B283DA8;
	Fri,  2 Feb 2024 13:55:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1706878542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vk6ebVfUP0DK1H8nYjPQE8hIkEuSNdLAy6sElffR3ok=;
	b=edLqh18Utjzl1LdX29V+5A3Xpy1mu+zS9Cjr0I7nC5D7VZkcP8c/Po1Aw4c6/EQT9UqRQK
	5EK3JQp5RLXKt7ZZbsdacOYx9ft6eu7X9yjIJtXn9lBVa9NigZxKwWEkj+zvnZ0kKd4gap
	e7k007zRwHiSQD8Ybnib+aMzJuMR9zU=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 93ED14516B2;
	Fri,  2 Feb 2024 13:55:42 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 13:55:42 +0100
Message-Id: <CYULY1BYVCYK.1EGSBSVNRSTLQ@gimli.ms.mff.cuni.cz>
Cc: "Karel Balej" <balejk@matfyz.cz>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <linux-input@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/5] mfd: add 88pm88x driver
To: "Lee Jones" <lee@kernel.org>
From: "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
 <20231217131838.7569-3-karelb@gimli.ms.mff.cuni.cz>
 <20240125122634.GE74950@google.com>
 <CYQ8MEQRJELE.2GB9316NZA998@gimli.ms.mff.cuni.cz>
 <20240131110311.GI8551@google.com>
 <CYTURHOW0WMR.2UMOT0D1GFZ2W@gimli.ms.mff.cuni.cz>
 <20240202124550.GE1379817@google.com>
In-Reply-To: <20240202124550.GE1379817@google.com>

Lee Jones, 2024-02-02T12:45:50+00:00:
> On Thu, 01 Feb 2024, Karel Balej wrote:
>
> > Lee Jones, 2024-01-31T11:03:11+00:00:
> > > On Sun, 28 Jan 2024, Karel Balej wrote:
> > > > > > +	/* GPIO1: DVC, GPIO0: input */
> > > > > > +	REG_SEQ0(PM88X_REG_GPIO_CTRL1, 0x40),
> > > > >
> > > > > Shouldn't you set these up using Pintrl?
> > > >=20
> > > > You mean to add a new MFD cell for the pins and write the respectiv=
e
> > > > driver? The downstream implementation has no such thing so I'm not =
sure
> > > > if I would be able to do that from scratch.
> > >
> > > This is not a Pinctrl driver.
> > >
> > > Isn't there a generic API you can use?
> >=20
> > I'm sorry, I don't think I understand what you mean.
>
> Perhaps I misunderstand the code.  It looks like this regmap patch hack
> is configuring pins and a bunch of other things.  Would that be a
> correct assessment?

Yes, that sounds correct.

> If so, where do we draw the line here?  Do we accept a 1000 line driver
> which configures a large SoC with a bunch of bespoke register writes?

I understand, I just don't know what you mean by "a generic API". I'm
also not clear on whether what you have in mind is simply adding a
dedicated driver for the pins as a new subdevice of this MFD.

Thanks,
K. B.

