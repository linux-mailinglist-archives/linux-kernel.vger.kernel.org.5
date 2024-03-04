Return-Path: <linux-kernel+bounces-91238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24677870B9C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9781F22D27
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93997AE72;
	Mon,  4 Mar 2024 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="WS6j8opJ"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D35FF0E;
	Mon,  4 Mar 2024 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584100; cv=none; b=DMx+9gPe2ZRvrxMPHRoGTGmRdZKeoXTOtvjjV4eE3ufQ7nMr8GFi1XkJzeOmqVr5FFW4jcLRYAxVAh1xMHz/mETokEloze2XyuGs2lg0PgaceDoQisU5DImqVfmuUpZB1lyPhQO7rAq+ZXdDzKjWn+HIgB3Sk4Bu5JuzkwMoXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584100; c=relaxed/simple;
	bh=Wpxa/TK4b0ZLhe17uwNFCNqly4luRjWd6+LrHrOSp08=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=uXLXIe/Uro530eyjHEkIB+2f+uuz0ZdtJkyEdce2MG9aDdzVbha6dJxNtDyNya6tKTNW9DgMlHml3ketjZ+EbS8K7Ae+XCmYD9a915RV5tZT+7EX6XZg4sRcD2wb6O5Q9am/dgoetekrrzDcEEWI8n+FRV2J239W1w/QEvzPCpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=WS6j8opJ; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 509FC2843B5;
	Mon,  4 Mar 2024 21:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1709584089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0gGSi9ctqlSm0+Gdj84gUSgxHdqznSURe1C3VVntQE=;
	b=WS6j8opJpfs0wpsyX6yLSCrostCOINwT8dTgsY2V+OjcaE6QPC7vvhaBybZwwLw2sPQO9f
	VNFBi0Z0Q2XBY0ZyL5gEd76Y6OJK3+Nl2cSO4NaPOW/j+mrRI+N1Bm23jHZ3edJyhrEwrY
	tj/03Qr1cnAi+fyfrA1Y5A8wN3h59f4=
Received: from localhost (koleje-wifi-0023.koleje.cuni.cz [78.128.191.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 2C9E0457628;
	Mon,  4 Mar 2024 21:28:09 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Mar 2024 21:28:45 +0100
Message-Id: <CZL8ZSZAVEBI.349BV2Y6AKIPN@gimli.ms.mff.cuni.cz>
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 4/5] input: add onkey driver for Marvell 88PM886
 PMIC
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
From: "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
References: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
 <20240303101506.4187-5-karelb@gimli.ms.mff.cuni.cz>
 <ZeTgEmjJc_VhYpLm@google.com>
In-Reply-To: <ZeTgEmjJc_VhYpLm@google.com>

Dmitry,

Dmitry Torokhov, 2024-03-03T12:39:46-08:00:
> On Sun, Mar 03, 2024 at 11:04:25AM +0100, Karel Balej wrote:
> > From: Karel Balej <balejk@matfyz.cz>
> >=20
> > Marvell 88PM886 PMIC provides onkey among other things. Add client
> > driver to handle it. The driver currently only provides a basic support
> > omitting additional functions found in the vendor version, such as long
> > onkey and GPIO integration.
> >=20
> > Signed-off-by: Karel Balej <balejk@matfyz.cz>
> > ---
> >=20
> > Notes:
> >     RFC v3:
> >     - Drop wakeup-source.
> >     RFC v2:
> >     - Address Dmitry's feedback:
> >       - Sort includes alphabetically.
> >       - Drop onkey->irq.
> >       - ret -> err in irq_handler and no initialization.
> >       - Break long lines and other formatting.
> >       - Do not clobber platform_get_irq error.
> >       - Do not set device parent manually.
> >       - Use input_set_capability.
> >       - Use the wakeup-source DT property.
> >       - Drop of_match_table.
>
> I only said that you should not be using of_match_ptr(), but you still
> need to have of_match_table set and have MODULE_DEVICE_TABLE() for the
> proper module loading support.

I removed of_match_table because I no longer need compatible for this --
there are no device tree properties and the driver is being instantiated
by the MFD driver.

Is the MODULE_DEVICE_TABLE() entry needed for the driver to probe when
compiled as module? If that is the case, given what I write above, am I
correct that MODULE_DEVICE_TABLE(platform,...) would be the right thing
to use here?

Thank you, kind regards,
K. B.

