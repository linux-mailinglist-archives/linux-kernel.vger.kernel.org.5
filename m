Return-Path: <linux-kernel+bounces-47774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9428452A2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52801C22D41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE3817554;
	Thu,  1 Feb 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KsjPgccL"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04607157056;
	Thu,  1 Feb 2024 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775972; cv=none; b=fHuGTBJCeCBXU0WWzwICmfrdAX8gPFw4sNYOtHzQacw3HLHJ/+t+RVru8UUOjR+p2t0aR1opY2utZrIiRQTMclAxDYBKsb0OcMPqzKi5uc7Hi4h22H6zjJwM/tpHbu1aU/PrTP4J0rmNID1uOxmM6juNPM8ROzHy9e1M/0dAruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775972; c=relaxed/simple;
	bh=FMcpzuqbziwjbDKPU3ZKMutj2d/R80lDM22a6yVTZJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k41CjO+PPX5bmQvjSxx9n0PlIQG78DZP/0dHtDhFhVd/BgwDn9hnqERJic40gsnorYkLMbCzX3NBLpHyKPwvUVqwGndjGfpJJM4FrRkST+8Xc9AVfhWlAHiJcsC/Ruj0WIoWG7xoITZXKVlfRK7lxXtca+3GLjoCgZMiWtruiZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KsjPgccL; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1E3D60003;
	Thu,  1 Feb 2024 08:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706775961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYkQXqzcGz3hrfklpGf6cCnC1Loec/vHktXK38RmtMw=;
	b=KsjPgccLmKV1+LN1lgOi+u4HVkmk+JOojxWki84Yx7/kX3tpLAEHnbw0M5SOBRdylO+9su
	pj6qWeV3v+U2fJRx9FQH6DcrHPZMlMm41naFkDbo5k3a8t3Bagu4pyhoQGOSDkEA221+Mh
	VywBw67GHyz7WPF4/0A1LZ9y/oxvQC1FJPbEAhsRV9BRtE7PizquX+rWgGakSdWQ7qAZN2
	lR3EDPnv24fE0E1RZx2dYRR8c9hrWMw8BHwkB8IHVQCPj2NHudCoa4/rBxdRkmm5qeu8pZ
	kLkXNy2Yc1tgFCT9U6aog4tgUXUV+kIKpI2YoXd44VfoKMCc9h5sd5VMrKdTXQ==
Date: Thu, 1 Feb 2024 09:25:58 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: William Zhang <william.zhang@broadcom.com>
Cc: David Regan <dregan@broadcom.com>, dregan@mail.com, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 computersforpeace@gmail.com, kdasu.kdev@gmail.com,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Joel Peshkin
 <joel.peshkin@broadcom.com>, Tomer Yacoby <tomer.yacoby@broadcom.com>, Dan
 Beygelman <dan.beygelman@broadcom.com>, Anand Gore
 <anand.gore@broadcom.com>, Kursad Oney <kursad.oney@broadcom.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andre.przywara@arm.com,
 baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: Re: [PATCH v3 10/10] mtd: rawnand: brcmnand: allow for on-die ecc
Message-ID: <20240201092558.5499ee6a@xps-13>
In-Reply-To: <bcd9f8a5-7dab-42e6-b860-8a56ebb51cb6@broadcom.com>
References: <20240124030458.98408-1-dregan@broadcom.com>
	<20240124030458.98408-11-dregan@broadcom.com>
	<20240124184027.712b1e47@xps-13>
	<CAA_RMS42FaiN+Za1iY12o0YUANH9rJarBTBa=9jNn8x6_g-Fng@mail.gmail.com>
	<20240126071913.699c3795@xps-13>
	<CAA_RMS5gX88v_Qt1csgSL_ffMNsqo2G8B164EB_Hg=hXd620eg@mail.gmail.com>
	<20240129115228.06dc2292@xps-13>
	<2a3edcf5-7afc-410c-a402-3d8cd3feb1da@broadcom.com>
	<20240130120155.3cb6feed@xps-13>
	<CAA_RMS577vw=QWN9_NHfmWqt+_cDG22tA01aU019CPNjAgHqJQ@mail.gmail.com>
	<20240130195504.506fb446@xps-13>
	<bcd9f8a5-7dab-42e6-b860-8a56ebb51cb6@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi William,

> >>>>>>>> This is a double check to turn on/off our hardware ECC. =20
> >>>>>>>
> >>>>>>> I expect the engine to be always disabled. Enable it only when you
> >>>>>>> need (may require an additional patch before this one). =20
> >>>>>>
> >>>>>> We are already turning on the ECC enable at this point,
> >>>>>> this is just adding the option to turn it off if the NAND chip
> >>>>>> itself will be doing the ECC instead of our controller. =20
> >>>>>
> >>>>> Sorry if I have not been clear.
> >>>>>
> >>>>> This sequence:
> >>>>> - init
> >>>>> - enable hw ECC engine
> >>>>> Is broken. =20
> >>>>>   >>>> ECC engine is not enabled for all the cases. Here we only in=
tended to enable it for the nand chip that is set to use NAND_ECC_ENGINE_TY=
PE_ON_HOST. The logic here should better change to: =20
> >>>> if (chip->ecc.engine_type =3D=3D NAND_ECC_ENGINE_TYPE_ON_HOST)
> >>>>       brcmnand_set_ecc_enabled(host, 1);
> >>>> else
> >>>>       brcmnand_set_ecc_enabled(host, 0); =20
> >>>>   >>>>> It *cannot* work as any operation going through exec_op now =
may =20
> >>>>> perform page reads which should be unmodified by the ECC engine. Yo=
u > driver *must* follow the following sequence:
> >>>>> - init and disable (or keep disabled) the hw ECC engine
> >>>>> - when you perform a page operation with correction you need to
> >>>>>      - enable the engine
> >>>>>      - perform the operation
> >>>>>      - disable the engine
> >>>>> Maybe I am missing something here but are you saying the exec_op ca=
n have different ecc type for page read/write at run time on the same nand =
chip? I don't see the op instr structure has the ecc type field and thought=
 it is only bind to the nand chip and won't change at run time. So looks to=
 me the init time setting to the engine based on ecc.engine_type should be =
sufficient. =20
> >>>>
> >>>> What you described here can work for the hw.ecc read path (ecc.read_=
page =3D brcmnand_read_page) which always assumes ecc is enabled. Although =
it is probably not too bad with these two extra operation, it would be bett=
er if we don't have to add anything as our current code does. For the brcmn=
and_read_page_raw,  we currently disable the engine and then re-enable it(b=
ut we need to fix it to only enable it with hw ecc engine type).  So it is =
just opposite of you logic but works the same with no impact on the most pe=
rformance critical path. =20
> >>>
> >>> This is not "my" logic, this is the "core's" logic. I am saying: your
> >>> approach is broken because that is not how the API is supposed to wor=
k,
> >>> but it mostly works in the standard case. =20
> >>
> >> In the interest of minimizing register writes, would it be acceptable =
to
> >> enable/disable ECC at the beginning of a standard
> >> path transfer but not, after the transfer, turn off the ECC? This shou=
ld not
> >> affect other standard path operations nor affect the exec_op path as t=
hose
> >> are low level transfers which our ECC engine would not touch and the N=
AND
> >> device driver should be responsible for turning on/off its own ECC. =20
> >=20
> > Do you have legitimate concerns about this register write taking way
> > more time than I could expect? Because compared to the transfer of a
> > NAND page + tR/tPROG it should not be noticeable. I don't see how you
> > could even measure such impact actually, unless the register write does
> > way more than usual. I'm fine with the above idea if you show me it has
> > an interest.
> >  =20
> Dave did the mtd_speed test and we can see we get consistently ~35KB/s sl=
ower with the extra enable and disable ecc engine calls in ecc read page pa=
th.
>=20
> With the change:
> [   28.148355] mtd_speedtest:   page read speed is 9857 KiB/s
> [   31.754258] mtd_speedtest: 2 page read speed is 9865 KiB/s
> Without the change
> [   56.444735] mtd_speedtest:   page read speed is 9892 KiB/s
> [   60.042262] mtd_speedtest: 2 page read speed is 9897 KiB/s

I believe if you repeat this 10 times you'll get totally different
results. I don't think this test on a non RT machine is precise enough
so that a unique 35kiB difference can be interpreted as being
significant.

> Although it is only less than 1% drop, it is still something. I understan=
d the procedure you laid out above is the preferred way but with our driver=
 fully control the chip ecc read/write page, ecc read_raw/write_raw page fu=
nction and exec_op path, I don't see where it may not work.

I just told you, the exec_op path runs with ECC enabled. I don't know
how this controller works. Now if you don't care and are 100% sure this
is working and future proof, just keep it like this.

Cheers,
Miqu=C3=A8l

