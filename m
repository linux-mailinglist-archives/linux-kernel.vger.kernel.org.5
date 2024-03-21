Return-Path: <linux-kernel+bounces-110465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019FD885F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E61284F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E9C1332AC;
	Thu, 21 Mar 2024 17:08:03 +0000 (UTC)
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC63132C19;
	Thu, 21 Mar 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040882; cv=none; b=Dg9cCabYBODjTh2KDGU1Fs4OzcXs10bnjTtdBs8+NLcw17o+a6fmfjsFKAN7uo4K6iWLp3OctY8aC2wtaPRcIloDKNflElf0EnYyYu9aBG0yLA7l/3r3BeodOF9xLre/yzGiO3MPG0d79uNVvI+Q5W2kqXYAg4p8ILbyG2zwlNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040882; c=relaxed/simple;
	bh=3eTxWlyZ3yvKG7IqSaj3xnqURvyDX21tfOB8h+e0Gbg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:Subject:To:
	 References:In-Reply-To; b=Xjxa0JEGd8Wd1btRMOjBK7b0/PfbXMAL6MVWlPxQqXtIHg0sSbY87xkka8jLF+scgSLz45VFojCBbn6s9Vhv68qUCny6iPl3I9BEg4K1KckKWLlPl1ZTbPImFZOfigfyqzKdxxVxBr4XyS7UZuGLXbr5VHSQK4NaxVxLmRTPepU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
Received: from localhost (koleje-wifi-0015.koleje.cuni.cz [78.128.191.15])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42LH7hHN095693
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 18:07:44 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 18:08:16 +0100
Message-Id: <CZZLDK79D5VK.2VK3X59OHIY2Z@matfyz.cz>
From: "Karel Balej" <balejk@matfyz.cz>
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley"
 <conor+dt@kernel.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Liam
 Girdwood" <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 2/5] mfd: add driver for Marvell 88PM886 PMIC
To: "Mark Brown" <broonie@kernel.org>
References: <20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz>
 <20240311160110.32185-3-karelb@gimli.ms.mff.cuni.cz>
 <20240321154211.GA13211@google.com> <CZZK759UU6G7.MFPYOI0HBB6I@matfyz.cz>
 <20240321162045.GC13211@google.com> <CZZL3MNOT0QG.2WDSNX9XD2RET@matfyz.cz>
 <879296b4-5186-4170-af3f-971787d28514@sirena.org.uk>
In-Reply-To: <879296b4-5186-4170-af3f-971787d28514@sirena.org.uk>

Mark Brown, 2024-03-21T16:58:44+00:00:
> On Thu, Mar 21, 2024 at 05:55:17PM +0100, Karel Balej wrote:
> > Lee Jones, 2024-03-21T16:20:45+00:00:
> > > On Thu, 21 Mar 2024, Karel Balej wrote:
>
> > > > > > +static const struct regmap_config pm886_i2c_regmap =3D {
> > > > > > +	.reg_bits =3D 8,
> > > > > > +	.val_bits =3D 8,
> > > > > > +	.max_register =3D PM886_REGMAP_CONF_MAX_REG,
> > > > > > +};
>
> > > > > Why is this in here?
>
> > > > Because since I moved the regulators regmap initialization into the
> > > > regulators driver, I need to access it from there.
>
> > > So move it into the regulators driver?
>
> > It is used in the MFD driver too for the base regmap.
>
> You shouldn't be creating two regmaps for the same set of registers,
> that just opens the potential for confusion.

Just the regmap config is the same. Otherwise, each regmap lives at a
different I2C address.

Regards,
K. B.

