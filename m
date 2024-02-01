Return-Path: <linux-kernel+bounces-48418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DDA845BB2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97F91F2BE2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3B562166;
	Thu,  1 Feb 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="ZXb+Iga+"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56266626C9;
	Thu,  1 Feb 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801878; cv=none; b=OL0obQgzvUpgg/SEvvMWgD0WreGTH6hZeI5rD7u5wYISLsLmOli3QGhe0fng6N0ZBpVJ2jN+DcnxngC3kZWDdamaBuQcieRuUZNnTfAIqeOssOsSEmZYeGyweaCgVvynorEA4SD1QpHUNvqFYWyljsdMkpLRs7pRAk1STiimvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801878; c=relaxed/simple;
	bh=mlFdx8q/qv+OqqycJ0U0WzY9CEGgq+9/dfyQ3o9wzOY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=pCSBkCZos4zkmUKYMFdj7ybv1YsXWdFxa1nllEY+Hh+Wpp/dfM9urGtz3YWICc1gkQlgPOQo/BVjbhWYr3ynf1noorCS+ZXu6fzK56Y1KYs8o3eQIsS1Q+nV6kfnFOH7uZ2Zp5r1ddToAkiOh4P8+GR9dqpGNnnZozXdm/8/hZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=ZXb+Iga+; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id DA4F6283D4C;
	Thu,  1 Feb 2024 16:37:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1706801859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrwVT/WNDACr7m8GmvCDFAAxCBNQxViS+p8tHUq04XY=;
	b=ZXb+Iga+zgEpxQtmV4KbAtVjpkIqGkOmCVbzHldgvGXUHA8KWzR6UHH4luWzNylkNzXqfw
	6eKWPwViOX7KiMtgw4i94fHUwCtE2uoSB/SPVcsiBwf+Hl8sSIHhAGUlBb9MXaDfOZCM6q
	q2fyvc+E/xzwtwHswjxasn26hQlQJCk=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id B97A8457CB8;
	Thu,  1 Feb 2024 16:37:39 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Feb 2024 16:37:39 +0100
Message-Id: <CYTURHOW0WMR.2UMOT0D1GFZ2W@gimli.ms.mff.cuni.cz>
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
In-Reply-To: <20240131110311.GI8551@google.com>

Lee Jones, 2024-01-31T11:03:11+00:00:
> On Sun, 28 Jan 2024, Karel Balej wrote:
> > > > +	/* GPIO1: DVC, GPIO0: input */
> > > > +	REG_SEQ0(PM88X_REG_GPIO_CTRL1, 0x40),
> > >
> > > Shouldn't you set these up using Pintrl?
> >=20
> > You mean to add a new MFD cell for the pins and write the respective
> > driver? The downstream implementation has no such thing so I'm not sure
> > if I would be able to do that from scratch.
>
> This is not a Pinctrl driver.
>
> Isn't there a generic API you can use?

I'm sorry, I don't think I understand what you mean.

Thank you,
K. B.

