Return-Path: <linux-kernel+bounces-12001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212A781EEB4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 810DBB213B9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DD7446B5;
	Wed, 27 Dec 2023 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="g8fPewqr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C134446AC;
	Wed, 27 Dec 2023 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 3CA2D28C548;
	Wed, 27 Dec 2023 12:55:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1703678158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdH2yBNiK/xMMpgPKeteq1/bIi2Aa4FzaW/rE8c1K0A=;
	b=g8fPewqrOpd0ltQq7evxQAYLjxvt6JHIvnXsqPHpz7Uk+5zDvmL3colK6SKofAJqmqV+cF
	gpOUX6gosI9DIGESXkflAyZ/B94h31STzpdC1hCFRZ7KT1ymPt5xnnMK2UQIFwJILmE2d5
	MXfkxO2/jRLRIU4M8HR4Lnn145yQ5C0=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 1FA3544D1F0;
	Wed, 27 Dec 2023 12:55:58 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Dec 2023 12:55:57 +0100
Message-Id: <CXZ3I4X6XODY.1PMT2LS10M50M@gimli.ms.mff.cuni.cz>
From: "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Henrik Rydberg" <rydberg@bitmath.org>,
 <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Duje_Mihanovi=C4=87?=
 <duje.mihanovic@skole.hr>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, "Karel Balej" <balejk@matfyz.cz>, "Conor
 Dooley" <conor@kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: input/touchscreen: Add compatible
 for IST3038B
To: "Markuss Broks" <markuss.broks@gmail.com>
References: <20231202125948.10345-1-karelb@gimli.ms.mff.cuni.cz>
 <20231202125948.10345-3-karelb@gimli.ms.mff.cuni.cz>
 <20231203-outskirts-reformat-e0a833903841@spud>
 <0a035c62-9d35-4f85-b1f3-bcb7dea17d52@gmail.com>
 <20231204-stooge-impotent-fe8d2d9177e4@wendy>
 <CXJOLS2I8WH7.1IMVJGPUNG4VB@gimli.ms.mff.cuni.cz>
 <20231209-casing-music-bded1c7b5475@spud>
In-Reply-To: <20231209-casing-music-bded1c7b5475@spud>

Markuss,

On Sat Dec 9, 2023 at 11:58 AM CET, Conor Dooley wrote:
> On Sat, Dec 09, 2023 at 10:05:27AM +0100, Karel Balej wrote:
> > On Mon Dec 4, 2023 at 1:52 PM CET, Conor Dooley wrote:
> > > On Mon, Dec 04, 2023 at 02:40:44PM +0200, Markuss Broks wrote:
> > > > On 12/3/23 13:20, Conor Dooley wrote:
> > > > > On Sat, Dec 02, 2023 at 01:48:33PM +0100, Karel Balej wrote:
> > > > > > From: Markuss Broks <markuss.broks@gmail.com>
> > > > > >=20
> > > > > > Imagis IST3038B is a variant (firmware?) of Imagis IST3038 IC,
> > > > > > add the compatible for it to the IST3038C bindings.
> > > > > This one is better, but would be well served by mentioning what
> > > > > specifically is different (register addresses or firmware command=
s?)
> > > >=20
> > > > I don't think anyone knows this other than Imagis itself. I would g=
uess it's
> > > > different hardware, since register addresses are indeed different, =
but on
> > > > the other hand, there is a possibility that firmware on the MCU cou=
ld be
> > > > responding to those commands. I suppose "... IST3038B is a hardware=
 variant
> > > > of ... IST3038" would be more correct.
> > >
> > > Only Imagis might know the specifics, but you (plural) have made driv=
er
> > > changes so you know what is different in terms of the programming mod=
el.
> > > I'm just asking for you to mention how the programming model varies i=
n
> > > the commit message. Otherwise I can't know whether you should have ad=
ded
> > > a fallback compatible, without going and reading your driver change. =
The
> > > commit message for the bindings should stand on its own merit in that
> > > regard.
> > > "Variant" alone does not suffice, as many variants of devices have a
> > > compatible programming model, be that for a subset of features or
> > > complete compatibility.
> > >
> > > > The reason why I think it could be firmware-defined is because we h=
ave a lot
> > > > of variants (30xxA, 30xxB, 30xxC, plain 30xx), and the numbers usua=
lly mean
> > > > feature level/completeness, e.g. some don't support the touch press=
ure or
> > > > touchkeys, and we don't know what A/B/C/none means.
> > >
> > > Ultimately whether it is due to firmware or the hardware isn't
> > > particular important, just mention what is incompatibly different.
> >=20
> > I propose to update the commit description as such:
> >=20
> > 	Imagis IST3038B is a variant (firmware?) of Imagis IST3038 IC
> > 	differing from IST3038C in its register interface. Add the
> > 	compatible for it to the IST3038C bindings.

is this change OK with you?

>
>
> SGTM. You can add
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> with that commit message update.
>
> Thanks,
> Conor.

Kind regards,
K. B.

