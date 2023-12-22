Return-Path: <linux-kernel+bounces-9941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 604D281CD8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCA0285444
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666D5286B5;
	Fri, 22 Dec 2023 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="ZNZmAtXS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EF525763;
	Fri, 22 Dec 2023 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id D8F7B28C52C;
	Fri, 22 Dec 2023 18:25:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1703265917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o11YE5j79FN8PAmtNGUeQ/O6aLa108mHrEVJebvZVkA=;
	b=ZNZmAtXS6ynEkqeZFfs1vx18Bm+f+bAqFuYywlmaEqdrOSPLxrCeoVuj8TxtJxkkHQyPwA
	9uHFWxRcqi0HnHV7gVTvGDEV1UogKoEk5TvY1qgbgptZJNcmYvYvCbNC8FOHKLSN/FIP/t
	Q1yR253z3c8GzhRICrHMIyFmNaceLE8=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id A9B2D447BF5;
	Fri, 22 Dec 2023 18:25:17 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Dec 2023 18:25:17 +0100
Message-Id: <CXV1DK9TRFFE.2XFOC3C4K4N52@gimli.ms.mff.cuni.cz>
Cc: "Karel Balej" <balejk@matfyz.cz>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Lee Jones" <lee@kernel.org>, <linux-input@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] dt-bindings: mfd: add entry for the Marvell
 88PM88X PMICs
To: "Rob Herring" <robh@kernel.org>
From: "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
 <20231217131838.7569-2-karelb@gimli.ms.mff.cuni.cz>
 <20231218151718.GA3827526-robh@kernel.org>
In-Reply-To: <20231218151718.GA3827526-robh@kernel.org>

Rob,

thank you very much for your feedback.

On Mon Dec 18, 2023 at 4:17 PM CET, Rob Herring wrote:
> > +  Marvell 88PM880 and 88PM886 are two similar PMICs providing
> > +  several functions such as onkey, regulators or battery and
> > +  charger. Both seem to come in two revisions -- A0 and A1.
> > +
> > +properties:
> > +  compatible:
> > +    const: marvell,88pm886-a1
>
> The description talks about 4 different devices, but only 1 here.=20
>
> Do you expect to need A0 support? Devices with these PMICs should be=20
> known and few, right?=20

I know of three smartphones which have 88PM886 and all of them (at least
the revisions that have been tested) seem to use A1. So no, I don't know
of any device that would need A0, but I wanted have the driver ready in
case somebody needed to add it later. What change do you then suggest?

Thank you and kind regards,
K. B.

