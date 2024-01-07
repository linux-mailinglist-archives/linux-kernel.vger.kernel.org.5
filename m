Return-Path: <linux-kernel+bounces-18859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54476826415
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42181F203F8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA5C134AF;
	Sun,  7 Jan 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="BPe5Ef5/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF00134AB;
	Sun,  7 Jan 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 056C9282960;
	Sun,  7 Jan 2024 13:45:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1704631549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZzauvuVedlYhrFCUEuZZ+mKSrUZ8PO0lnWXkiCMvpk=;
	b=BPe5Ef5/0TNjCh8vlr5rqqqcOWXv9T4W2TTadVW/c7t0eUeFg12K1uoScTXwyWETCA9IYS
	83KQigLAupLt1AFfGfafm9+q8ZmKOZu+7sB31CeUUT1mReBB1l0UtRzfWPDDA0JxI5yvsG
	HqplXYTeo4OMOP4pmwmO3GmUW3TmaSo=
Received: from localhost (koleje-wifi-0044.koleje.cuni.cz [78.128.191.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id D55E4457862;
	Sun,  7 Jan 2024 13:45:48 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jan 2024 13:46:15 +0100
Message-Id: <CY8HGN83FGPB.28AJ0GPM9P0BO@gimli.ms.mff.cuni.cz>
Cc: "Karel Balej" <balejk@matfyz.cz>, "Lee Jones" <lee@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Liam Girdwood" <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Duje_Mihanovi=C4=87?=
 <duje.mihanovic@skole.hr>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/5] regulator: add 88pm88x regulators driver
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Mark Brown"
 <broonie@kernel.org>
From: "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
 <20231228100208.2932-5-karelb@gimli.ms.mff.cuni.cz>
 <008ee9d6-6259-43df-9af3-2dc9877cfe94@sirena.org.uk>
 <CY8DP6O8C72H.2XTJT3P7XZAKE@gimli.ms.mff.cuni.cz>
 <89fab5fd-34ce-4196-b246-b5c3e4c7e201@linaro.org>
In-Reply-To: <89fab5fd-34ce-4196-b246-b5c3e4c7e201@linaro.org>

Krzysztof,

On Sun Jan 7, 2024 at 11:34 AM CET, Krzysztof Kozlowski wrote:
> On 07/01/2024 10:49, Karel Balej wrote:
> > Mark,
> >=20
> > On Fri Jan 5, 2024 at 4:18 PM CET, Mark Brown wrote:
> >> On Thu, Dec 28, 2023 at 10:39:13AM +0100, Karel Balej wrote:
> >>
> >>> @@ -68,6 +68,21 @@ static struct mfd_cell pm886_devs[] =3D {
> >>>  		.num_resources =3D ARRAY_SIZE(pm88x_onkey_resources),
> >>>  		.resources =3D pm88x_onkey_resources,
> >>>  	},
> >>> +	{
> >>> +		.name =3D "88pm88x-regulator",
> >>> +		.id =3D PM88X_REGULATOR_ID_LDO2,
> >>> +		.of_compatible =3D "marvell,88pm88x-regulator",
> >>> +	},
> >>
> >> Why are we adding an of_compatible here?  It's redundant, the MFD spli=
t
> >> is a feature of Linux internals not of the hardware, and the existing
> >> 88pm8xx MFD doesn't use them.
> >=20
> > in a feedback to my MFD series, Rob Herring pointed out that there is n=
o
> > need to have a devicetree node for a subdevice if it only contains
> > "compatible" as the MFD driver can instantiate subdevices itself. I
> > understood that this is what he was referring to, but now I suspect tha=
t
> > it is sufficient for the mfd_cell.name to be set to the subdevice drive=
r
> > name for this - is that correct?
>
> I think Rob was only referring to "no need to have a devicetree node".

yes, but I thought the presence of the compatible in the node is what
triggers instantiation of the driver and that adding it here instead was
necessary for that to happen if the node was to be removed. But like I
said, now I think only the .name property is relevant for that.

> But you added here a devicetree node, plus probably undocumented compatib=
le.
>
> Does it even pass the checkpatch?

It does, but you were correct in your previous messages that I have not
run `make dt_binding_check` for this (or I assume that was what you
meant when you said that I did not test this) because I was not aware of
it when sending the MFD series and because this one would fail with the
same problems as Rob pointed out for that one, which is the main reason
why I only asked for feedback on the new parts. Sorry about that, next
time I will be sure to first fix all already known problems before
building on something.
>
> Best regards,
> Krzysztof

Thank you,
K. B.

