Return-Path: <linux-kernel+bounces-110581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E218860E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776891C2232D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C64134406;
	Thu, 21 Mar 2024 19:14:32 +0000 (UTC)
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A62383A4;
	Thu, 21 Mar 2024 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711048472; cv=none; b=dHUvIagsz7SncomV1Z0oOFF7O9NH1gFCiWuFwDAgIRI62lnI8jHmYFQjAs4w4KCC5zS5DhFtbrW0VetRn/KtbnSwRdMkO3CqQ1/9ZQ9+J2awSgOEa+aKLJwXzw+E8dzPrpGXx0SiLWGU6yPq1LC2/ds62XJiJiUk/ChakC/pL9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711048472; c=relaxed/simple;
	bh=rPXKI2wJ/6ccp3M6w1iKzAbMhguC0OcVdXiCwXRzO7A=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Cc:Subject:
	 References:In-Reply-To; b=IHhEzKnYF1SiNSPREE+W0nHP44ivh0hP9kApEbHnHEJ9SWLaYzMu6Xw6n90PL/avBoH+ShjwqRmDJLf7kooTnaKc3kG8SE5qdk1iTuT/MlfGvTJC0zhGcT6TJ1etHx4uxCLGX6a3zm/CWXws+NlB6SA7hlMP6TVLCRbkhZfxkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
Received: from localhost (koleje-wifi-0015.koleje.cuni.cz [78.128.191.15])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42LJEBuf000826
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 20:14:13 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 20:14:44 +0100
Message-Id: <CZZO2EFTAKN2.246XG441ECYYK@matfyz.cz>
To: "Mark Brown" <broonie@kernel.org>
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
References: <20240321154211.GA13211@google.com>
 <CZZK759UU6G7.MFPYOI0HBB6I@matfyz.cz> <20240321162045.GC13211@google.com>
 <CZZL3MNOT0QG.2WDSNX9XD2RET@matfyz.cz>
 <879296b4-5186-4170-af3f-971787d28514@sirena.org.uk>
 <CZZLDK79D5VK.2VK3X59OHIY2Z@matfyz.cz>
 <45079e37-dde9-4310-a112-7af49f35ac77@sirena.org.uk>
 <CZZLVS3T3QIS.223XHI5OZ7UBG@matfyz.cz>
 <e9c7bd38-49cd-44c2-8842-292bc0b4205f@sirena.org.uk>
 <CZZMTZBZ5S7B.2HR8A6LEY08D4@matfyz.cz>
 <bd4e96b9-1026-469b-9884-073cde1f39dc@sirena.org.uk>
In-Reply-To: <bd4e96b9-1026-469b-9884-073cde1f39dc@sirena.org.uk>

Mark Brown, 2024-03-21T19:00:24+00:00:
> On Thu, Mar 21, 2024 at 07:16:43PM +0100, Karel Balej wrote:
> > Mark Brown, 2024-03-21T17:48:28+00:00:
>
> > > > They do according to the downstream driver which is my only referen=
ce.
> > > > In fact, there the driver defines the configs separately for each r=
egmap
> > > > but with the same values.
>
> > > This is a downstream driver - are you sure it's got the best code
> > > quality?
>
> > No, that is why I have rewritten it and tried to improve on this. But
> > like I said, it is my only reference. Is there some other way to verify
> > this value (besides perhaps the datasheet)?
>
> The maximum register is whatever the maximum register we know about for
> the device is, the datasheet is generally a good reference there.
>
> > > I'm not seeing any references to registers with numbers as high as th=
e
> > > maximum register that's there in your driver for example.
>
> > Indeed, I have performed the same check with the same findings. But tha=
t
> > doesn't necessarily mean that the maximum should be lower, no?
>
> > Do you have some specific modifications of my code in mind regarding
> > this?
>
> I would expect that if you have two separate register maps they would
> have separate configurations that describe the corresponding physical
> register maps, as far as I can tell this driver is just making up a
> maximum register number.

Alright, so I should just use a separate config for each regmap and set
the max_register value for each to whatever I can find is actually the
highest used value in the downstream code -- correct?

Thank you,
K. B.

