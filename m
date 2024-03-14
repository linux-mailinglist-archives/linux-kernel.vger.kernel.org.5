Return-Path: <linux-kernel+bounces-103851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B574F87C5B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7162A2819F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB4DFC09;
	Thu, 14 Mar 2024 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cahI+a5h"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC6FC02;
	Thu, 14 Mar 2024 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710457444; cv=none; b=rVIiznBfQN+yFKDyDceJcwlIz3Qc6Zp13q4Mwc/zE1TFn2o+PdrdOtdl5gj/eyIBHwhXS3FIWVVZwaRWk2A150MphGUa4JA1kPmSxxktuGgkk1SPluH5hswloYgwYzvXJLH4qSY2f43Y0nAd96p/bV9x2ctWUWOc4/fg3eLiuw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710457444; c=relaxed/simple;
	bh=unEWSBHMmHpgZhaHuZAnj8KkOfObLBKQC0NwtECu18w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+4CrM1LWj80BkwWsuQSwXP4yVgaDNhl5UE7rca/i8Ww1Ycet/8oLquxoHyvHG2vN+vLT9J5y4xcfBztiS6HMD7cFwd/y7qd2Cy6s6xcjWxGCyjv8QAG3AWcZHXIR2mx4IXvN4NzRllg78SerOn6iXZ81PR1/ll8aEBlkQSaxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cahI+a5h; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 80A7C1C0003;
	Thu, 14 Mar 2024 23:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710457433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unEWSBHMmHpgZhaHuZAnj8KkOfObLBKQC0NwtECu18w=;
	b=cahI+a5hBJzOfDEYgrR2KyOvSqJmsXoxLVI82kgnk8R1TSQ5xQvwx10sKl0hxuWKlq8pQo
	osvjm01aoyslbo1pcCuJQYayrxn1XDW0FHIZciU01P5YEZk0W54RYDb5qx5M7mOhoTRq2k
	QfMJOsG24JkMDkQZB2evW3L2vqsLBx99ecWibrR6H/WufUlbjGkQOaVgo8mTalcz9Og2FR
	K5a/yYD0C/TDewzy4WEvB3PVk76GUYtWmJQgqHGHGargunVeIAquBoB77hGnsEy964hkeB
	25PnhmAij03G/ng+jlsSTg4WSssKIFnZcg42GCnrCsag6jiYL5x1G/0QvpcWng==
Date: Fri, 15 Mar 2024 00:03:46 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, William Zhang
 <william.zhang@broadcom.com>, Linux MTD List
 <linux-mtd@lists.infradead.org>, Linux ARM List
 <linux-arm-kernel@lists.infradead.org>, Broadcom Kernel List
 <bcm-kernel-feedback-list@broadcom.com>, kursad.oney@broadcom.com,
 joel.peshkin@broadcom.com, anand.gore@broadcom.com, dregan@mail.com,
 kamal.dasu@broadcom.com, tomer.yacoby@broadcom.com,
 dan.beygelman@broadcom.com, Andre Przywara <andre.przywara@arm.com>, Rob
 Herring <robh+dt@kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, David Regan <dregan@broadcom.com>,
 devicetree@vger.kernel.org, Alexandre TORGUE <alexandre.torgue@st.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Brian Norris
 <computersforpeace@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v6 00/13] mtd: rawnand: brcmnand: driver and doc updates
Message-ID: <20240315000346.6fad883e@xps-13>
In-Reply-To: <d3c66783-b71f-431f-9028-45897f12f2a0@gmail.com>
References: <20240223034758.13753-1-william.zhang@broadcom.com>
	<90ecf4d2-0eee-48e6-8222-7d3b5fd52b2f@broadcom.com>
	<20240229101101.5208195c@xps-13>
	<20240314230402.5fc7bbf3@xps-13>
	<d3c66783-b71f-431f-9028-45897f12f2a0@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com


> >> I'm sorry for not thinking about this ahead of time, I was also not
> >> Cced on the other patches, I noticed it (told Willliam) and just forgot
> >> about this when I applied the series.
> >>
> >> It is currently living in -next so if there is any problem I can still
> >> act.
> >>
> >> However for this kind of change I usually apply the bindings and .c
> >> changes independently from the DT patches. I believe there is no
> >> problem having one or the other being merged first, or do I overlook
> >> something? =20
> >=20
> > What the heck /o\ I just understand now my mistake, I am very truly
> > sorry for that...
> >=20
> > You were telling me I should sync with you before taking DT changes,
> > and I was so convinced I _did_not_ take the DT, when I looked at the
> > branch I did not understand your point. But I am totally sorry I
> > actually did take the DTs by mistake and I truly did not notice it.
> > Confirmation bias I suppose. My very sincere apologies.
> >=20
> > As mentioned previously, I was not CC'ed on the DT patches, but I
> > believe the linux-mtd list was, so the patches didn't appear in my
> > inbox, and once I was happy with the binding/driver changes I applied
> > it all without noticing the DT changes had sneaked in.
> >=20
> > I'm finally preparing the PR for Linus and I see it now...
> >=20
> > I believe the SoC tree is closed now so it's up to you what I should do
> > with them. Let me know if you want me to keep them in my tree and
> > forward them to Linus or if I should drop them and you'll take them for
> > the next cycle. Also, if I keep them, shall I add some tag of yours on
> > these 3 patches? For the record I did not review them. =20
>=20
> Yes please add my:
>=20
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
>=20
> tag, and it's fine I don't expect that we will get conflicts for those fi=
les.
>=20
> >=20
> > Thanks and again, I'm confused. I never apply DT patches like that,
> > your initial remark was more than legitimate. =20
>=20
> Not a problem!

Thanks :-)

Miqu=C3=A8l

